'use strict'
  
class Bot
  constructor: (@viewer,@row,@col,@direction,@gridLastIndex)->
    
  getContent: ()->
    ['up','right','down','left'][@direction / 90]
    
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
      @viewer('empty')
      @row += addRow
      @col += addCol
      @viewer(@getContent())
      @checkTargets()
  
  go: ()->
    console.log 'goBot', @direction
    switch @direction 
      when 0 then @move -1,0
      when 90 then @move 0,1
      when 180 then @move 1,0
      when 270 then @move -0,-1      

  setTargets: (@targets)->
  setOnTargetCheck: (@onTargetCheck)->
  
  checkTargets: ()->
    @onTargetCheck(target) for target in @targets when target.check(@row,@col)
    
# -------------------------------------------------------------------------      

angular.module 'tagatrekApp'
  .controller 'MainCtrl', ($scope,$interval,Targets) ->    
    bot = {}
    gridLastIndex = 10 
    instructionIndex = 0
    
    $scope.level = 2
    
    updateBotView = (content)->
      $scope.grid[bot.row][bot.col].content = content
    
    initGrid = () ->
      $scope.targetsMet = []
      bot = new Bot(updateBotView,gridLastIndex/2, gridLastIndex/2, 90,gridLastIndex)
      bot.setTargets $scope.targets
      bot.setOnTargetCheck((target)->
        console.log 'checked! ', target
        $scope.targetsMet.push(target)
      )
      grid = []
      id = 0
      for row in [0..gridLastIndex]
        colArray = []
        for col in [0..gridLastIndex]
          colArray.push({id: id, content: 'empty'})
          id++
        grid.push(colArray)  
      for target in $scope.targets
        grid[target.row][target.col].content = "target"
        
      $scope.grid = grid
      updateBotView(bot.getContent())
  
    $scope.newGame = ()->
      $scope.selecting = true
      
    $scope.startNewGame = ()->
      $scope.selecting = false
      updateTargets $scope.datasetId
      $scope.targetsMet = []
      $scope.program = {instructions : []}
      initGrid()
      
    findDataset = (datasetId)->
      for dataset in $scope.datasets
        if dataset.id == datasetId 
          return dataset
      return false
      
    updateTargets = (datasetId)->
      $scope.targets = Targets.getTargets(datasetId,gridLastIndex,$scope.level) 
      $scope.datasetName = findDataset(datasetId).name
            
    Targets.getDatasets((datasets)->
      $scope.datasetId = datasets[0].id
      $scope.datasets = datasets
      updateTargets($scope.datasetId)
      $scope.startNewGame()
    )
    
    $scope.cancelNewGame = ()->
      $scope.selecting = false
     
    $scope.availableInstructions = [
      {id:1, code:"go", name:"Avancer"},
      {id:2, code:"left", name:"Gauche"},
      {id:3, code:"right", name:"Droite"}
    ]
    
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
    
    $scope.getTargetUrl = (url)->
      if url && url.indexOf("http://") != 0
        return 'http://' + url
      return url
    
    $scope.getTargetImage = (images)->
      if (!images)
        return images
      imagesArray = images.split(';')
      return imagesArray[0]
      