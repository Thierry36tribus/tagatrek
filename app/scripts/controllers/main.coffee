'use strict'

angular.module 'tagatrekApp'
  .controller 'MainCtrl', ($scope) ->
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
    
    initGrid = () ->
      bot = {row: gridLastIndex/2, col: gridLastIndex/2}
      grid = []
      id = 0
      for row in [0..gridLastIndex]
        colArray = []
        for col in [0..gridLastIndex]
          colArray.push({id: id, content: '.'})
          id++
        grid.push(colArray)  
      grid[bot.row][bot.col].content = 'X'
      $scope.grid = grid
    
    initGrid()
    
    moveBot = (addRow,addCol) ->
      if (0 <= bot.row + addRow <= gridLastIndex) and (0 <= bot.col + addCol <= gridLastIndex)
        $scope.grid[bot.row][bot.col].content = '.'
        bot.row = bot.row + addRow
        bot.col = bot.col + addCol
        $scope.grid[bot.row][bot.col].content = 'X'
    
    $scope.start = () ->
      moveBot(-1,1)
      
    $scope.reset = () ->
      initGrid()
    