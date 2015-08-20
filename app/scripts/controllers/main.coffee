'use strict'

angular.module 'tagatrekApp'
  .controller 'MainCtrl', ($scope,$interval) ->
    #TODO charger objectifs depuis un fichier json
    $scope.objectives = [{id:1,name:"objectif 1"},{id:2,name:"objectif 2"}]
    
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

    updateBotContent = ()->
      $scope.grid[bot.row][bot.col].content = ['x','>','v','<'][bot.direction / 90]
      console.log 'updateBot, ', bot
    
    initGrid = () ->
      bot = {row: gridLastIndex/2, col: gridLastIndex/2, direction: 90}
      grid = []
      id = 0
      for row in [0..gridLastIndex]
        colArray = []
        for col in [0..gridLastIndex]
          colArray.push({id: id, content: '.'})
          id++
        grid.push(colArray)  
      $scope.grid = grid
      updateBotContent()
    
    initGrid()
    
    moveBot = (addRow,addCol) ->
      console.log 'moveBot ', addRow, addCol
      if (0 <= bot.row + addRow <= gridLastIndex) and (0 <= bot.col + addCol <= gridLastIndex)
        $scope.grid[bot.row][bot.col].content = '.'
        bot.row += addRow
        bot.col += addCol
        updateBotContent()
      
    $scope.reset = () ->
      initGrid()
    
    turnBot = (angle)->
      if bot.direction == 0 && angle == -90
        bot.direction = 270
      else if bot.direction == 270 && angle == 90
        bot.direction = 0
      else 
        bot.direction = bot.direction + angle
      console.log 'turnBot ',angle," -> ", bot.direction
      updateBotContent()
    
    goBot = ()->
      console.log 'goBot', bot.direction
      switch bot.direction 
        when 0 then moveBot -1,0
        when 90 then moveBot 0,1
        when 180 then moveBot 1,0
        when 270 then moveBot -0,-1
    
    run = () ->
      console.log 'run ', $scope.program.instructions[instructionIndex]
      switch $scope.program.instructions[instructionIndex].code
        when 'right' then turnBot 90
        when 'left' then turnBot -90
        when 'go' then goBot()
        else console.log 'else'
      console.log 'run done'
        
      instructionIndex += 1
    
    $scope.start = () ->
      initGrid()
      instructionIndex = 0
      $interval(()->
        run()
      ,500,$scope.program.instructions.length)
        
  