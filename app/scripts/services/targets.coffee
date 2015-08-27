'use strict'

# -------------------------------------------------------------------------   
class Target
  constructor: (@id,@row,@col,@data)->
  
  check: (row,col)->
    row == @row && col == @col

# ------------------------------------------------------------------------- 

dataset1 = []
dataset2 = []

angular.module 'tagatrekApp'
  .service 'Targets', ($http)->
    
    getRandomInt = (min, max) ->
      Math.floor(Math.random() * (max - min)) + min
    
    shuffle = (array)->
      m = array.length
      while (m) 
        i = Math.floor(Math.random() * m--)
        t = array[m]
        array[m] = array[i]
        array[i] = t
      return array
    
    # Ne conserve que les données avec photos
    filter = (dataset)->
      data for data in dataset when data.fields.multimedia_url_photo && data.fields.multimedia_url_photo.length > 0
    
    getDatasets = (callback)->
      $http.get('data/adt04_loisirs-full.json').success((data1)->
        dataset1 = filter(data1)
        $http.get('data/adt04_fetes_animations-full.json').success((data2)->
          dataset2 = filter(data2)
          callback([ {id:'1', name:"Loisirs"}, {id:'2', name:"Fêtes et manifestations"}])
        )
      )
      
    getTargets = (datasetId,lastIndex,nb)->
      getRandomTargets(getDataset(datasetId),lastIndex,nb)
      
    getDataset = (datasetId)->  
      if datasetId == "1"
        return dataset1
      else if datasetId == "2"
        return dataset2
      
      
    getRandomTargets = (datasetData,lastIndex,nb)->
      # TODO empêcher objectif au centre
      data = shuffle datasetData
      indexes = (i for i in [0..lastIndex])
      indexes = shuffle indexes
      result = []
      result.push(new Target(i+1,indexes[2*i],indexes[2*i+1],data[i])) for i in [0..nb-1]
      return result
    
    return {
      getDatasets : getDatasets,
      getTargets: getTargets
    }
