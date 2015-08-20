'use strict'

# -------------------------------------------------------------------------   
class Objective
  constructor: (@id,@name,@row,@col)->
  
  check: (row,col)->
    row == @row && col == @col

# -------------------------------------------------------------------------   
class Bot
  constructor: (@viewer,@row,@col,@direction,@gridLastIndex)->
    
  getContent: ()->
    ['x','>','v','<'][@direction / 90]
    
  turn: (angle)->
    if @direction == 0 && angle == -90
      @direction = 270
    else if @direction == 270 && angle == 90
      @direction = 0
    else 
      @direction = @direction + angle
    console.log 'turnBot ',angle," -> ", @direction
    @viewer(@getContent())    
    
  move : (addRow,addCol) ->
    console.log 'moveBot ', addRow, addCol
    if (0 <= @row + addRow <= @gridLastIndex) and (0 <= @col + addCol <= @gridLastIndex)
      @viewer('.')
      @row += addRow
      @col += addCol
      @viewer(@getContent())
      @checkObjectives()
  
  go: ()->
    console.log 'goBot', @direction
    switch @direction 
      when 0 then @move -1,0
      when 90 then @move 0,1
      when 180 then @move 1,0
      when 270 then @move -0,-1      

  setObjectives: (@objectives)->
  setOnObjectiveCheck: (@onObjectiveCheck)->
  
  checkObjectives: ()->
    @onObjectiveCheck(objective) for objective in @objectives when objective.check(@row,@col)
    
# -------------------------------------------------------------------------      

angular.module 'tagatrekApp'
  .controller 'MainCtrl', ($scope,$interval) ->    
    
    #TODO charger objectifs depuis un fichier json
    $scope.objectives = [
      new Objective(1,"obj 1", 3, 5),
      new Objective(2,"obj 2", 4, 7)
    ]
    
    $scope.objectivesMet = []
    
    $scope.availableInstructions = [
      {id:1, code:"go", name:"Avancer"},
      {id:2, code:"left", name:"Gauche"},
      {id:3, code:"right", name:"Droite"}
    ]

    $scope.program = {instructions : []}
    
    $scope.addInstruction = (instruction) ->
      newInstruction = angular.copy(instruction)
      newInstruction.id = $scope.program.instructions.length
      $scope.program.instructions.push(newInstruction)
     
    $scope.removeInstruction = (instruction) ->
      index = -1
      index = i for inst,i in $scope.program.instructions when inst.id == instruction.id
      if index >= 0   
        $scope.program.instructions.splice(index,1)
      
    $scope.clearProgram = () ->
      $scope.program.instructions = []

    bot = {}
    gridLastIndex = 10 
    instructionIndex = 0
    
    updateBotView = (content)->
      $scope.grid[bot.row][bot.col].content = content
    
    initGrid = () ->
      $scope.objectivesMet = []
      bot = new Bot(updateBotView,gridLastIndex/2, gridLastIndex/2, 90,gridLastIndex)
      bot.setObjectives $scope.objectives
      bot.setOnObjectiveCheck((objective)->
        console.log 'checked! ', objective
        $scope.objectivesMet.push(objective)
      )
      grid = []
      id = 0
      for row in [0..gridLastIndex]
        colArray = []
        for col in [0..gridLastIndex]
          colArray.push({id: id, content: '.'})
          id++
        grid.push(colArray)  
      for obj in $scope.objectives
        grid[obj.row][obj.col].content = "O"
        
      $scope.grid = grid
      updateBotView(bot.getContent())
    
    initGrid()
    
    $scope.reset = () ->
      initGrid()
    
    run = () ->
      switch $scope.program.instructions[instructionIndex].code
        when 'right' then bot.turn 90
        when 'left' then bot.turn -90
        when 'go' then bot.go()        
      instructionIndex += 1
    
    $scope.start = () ->
      initGrid()
      instructionIndex = 0
      $interval(()->
        run()
      ,500,$scope.program.instructions.length)
        
  