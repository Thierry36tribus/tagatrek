'use strict'

# -------------------------------------------------------------------------   
class Objective
  constructor: (@id,@row,@col,@data)->
  
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
  
    data = [{"datasetid": "adt04_loisirs", "recordid": "29779b7d13e3985e103a5e95fc1eef1244cf54b1", "fields": {"adr_etab": "Route de Marseille", "lang": "fr", "commune_etab": "RIEZ", "modified": "2015-05-25", "themes": "Patrimoine culturel/Vestiges", "site_web": "www.ville-riez.fr", "id": "48571", "etat": "publi\u00e9e", "themes_ids": "THE0179", "multimedia_url_photo": "http://static.kap-tourisme.fr/public/medias/27/1287663164000.jpg", "code_insee_etab": "04166", "titre": "BAPTISTERE - MUSEE LAPIDAIRE", "type": "PCU", "personne_fax1_etab": "04 92 77 99 07", "description_introduction": "Dans ce baptist\u00e8re \u00e9difi\u00e9 au V\u00e8me si\u00e8cle, unique en France, sont rassembl\u00e9s des vestiges gallo-romains proven\u00e7aux.\r\n\r\nDur\u00e9e moyenne de la visite : 30 mn", "personne_tel1_etab": "04 92 77 99 09", "prestations": "Parking;Parking autocar", "territoires": "Lacs et Plateaux du Verdon", "code_postal_etab": "04500", "raison_sociale_etab": "BAPTISTERE - MUSEE LAPIDAIRE", "created": "2013-07-01", "geo_point_2d": [43.818695, 6.090767], "personne_mel1_etab": "musee.riez@wanadoo.fr", "prestations_ids": "PRE0270;PRE0271"}, "geometry": {"type": "Point", "coordinates": [6.090767, 43.818695]}, "record_timestamp": "2015-05-25T20:00:05+02:00"},{"datasetid": "adt04_loisirs", "recordid": "5643a3bb94d7e4ec13f4b807d088603d7aeb0906", "fields": {"code_postal_etab": "04500", "description_introduction": "B\u00e9n\u00e9ficiant d\u2019un soleil g\u00e9n\u00e9reux, la flore abondante et riche en nectar parfum\u00e9 des Alpes de Haute-Provence fait des collines et plateaux du d\u00e9partement un espace naturel privil\u00e9gi\u00e9 pour les abeilles et les apiculteurs. L\u2019IGP concerne tous les miels de Provence.", "personne_tel1_etab": "04 42 17 15 00", "themes_ids": "THE0191", "lang": "fr", "created": "2013-07-01", "adr_etab": "Maison des agriculteurs", "commune_etab": "RIEZ", "modified": "2015-05-25", "themes": "Produits du Terroir", "raison_sociale_etab": "Syndicat de promotion des miels de Provence-Alpes-C\u00f4te d'Azur", "personne_mel1_etab": "contact@miels-de-provence.com", "site_web": "www.miels-de-provence.com", "code_insee_etab": "04166", "titre": "Miels de Provence (I.G.P et Label Rouge)", "territoires": "Lacs et Plateaux du Verdon", "etat": "publi\u00e9e", "type": "DEG", "id": "48745", "description_presentation": "Le miel de lavande et de lavandin ainsi que les miels poly floraux de Provence, b\u00e9n\u00e9ficient par ailleurs d\u2019un label rouge. Miel proven\u00e7al par excellence le miel de lavandes, \u00e0 la consistance douce, fine et au go\u00fbt si particulier, est un enchantement.  Il est fabriqu\u00e9 par les abeilles qui tirent le nectar exclusivement des fleurs de lavande au milieu de l'\u00e9t\u00e9.Lors de votre venue en Provence, ne manquez pas de d\u00e9guster ce miel tout \u00e0 fait local."}, "record_timestamp": "2015-05-25T20:00:05+02:00"},{"datasetid": "adt04_loisirs", "recordid": "0e6f01cfac10ebf29223d5a82231d85f06603a89", "fields": {"code_postal_etab": "04500", "description_introduction": "Randonn\u00e9e en quad, balades sur le plateau de Valensole autour du lac de Sainte-Croix", "personne_tel1_etab": "06 09 43 17 40", "themes_ids": "THE0142", "lang": "fr", "created": "2013-07-01", "commune_etab": "RIEZ", "modified": "2015-05-25", "themes": "Activit\u00e9 Terre/Motoris\u00e9e", "raison_sociale_etab": "QUAD ESCAPE", "code_insee_etab": "04166", "personne_mel1_etab": "quad-escape.jm@wanadoo.fr", "titre": "QUAD ESCAPE", "territoires": "Lacs et Plateaux du Verdon", "etat": "publi\u00e9e", "type": "ASC", "id": "48131", "personne_tel2_etab": "06 88 80 37 20"}, "record_timestamp": "2015-05-25T20:00:05+02:00"},{"datasetid": "adt04_loisirs", "recordid": "a8486e846d5ca42b94647af097dcb9abb5fa5759", "fields": {"adr_etab": "Base nautique \u00e0 Montpezat", "multimedia_url_video": "http://www.youtube.com/embed/N4L6hORXCAE", "description_presentation": "Labellis\u00e9 par le Parc Naturel R\u00e9gional du Verdon pour la qualit\u00e9 de nos prestations d\u2019un point de vue de l\u2019accueil, de la d\u00e9couverte du patrimoine culturel, historique, pr\u00e9historique et naturel mais aussi pour notre respect de l\u2019environnement.\r\nNous vous proposons\u00a0:\r\nDes activit\u00e9s encadr\u00e9es (cano\u00eb kayak, vtt, randonn\u00e9e p\u00e9destre, rafting, raquette \u00e0 neige) par des moniteurs dipl\u00f4m\u00e9s d\u2019\u00e9tat, comp\u00e9tents et passionn\u00e9s ayant de nombreuses ann\u00e9es d\u2019exp\u00e9rience dans le Verdon et dans les disciplines enseign\u00e9es.\r\nUn accueil chaleureux sur notre base nautique pour les activit\u00e9s de location de cano\u00eb kayak, p\u00e9dalos\u2026\r\nPublic\u00a0: Individuel, famille (enfant \u00e0 partir de 4 ans), personne \u00e0 mobilit\u00e9 r\u00e9duite, groupe d\u2019amis, comit\u00e9 d\u2019entreprise, s\u00e9minaire, scolaire, centre de vacances et de loisirs, accueil de presse\u2026\r\nNous vous accueillons\u00a0sur l\u2019ensemble du territoire du Verdon et des Alpes de haute Provence voir sur la r\u00e9gion PACA pour les activit\u00e9s encadr\u00e9es, sur notre base nautique \u00e0 Montpezat. Au d\u00e9part de Quinson (club de cano\u00eb kayak de Quinson).", "classement_labels_ids": "LAB0068;LAB0038", "commune_etab": "MONTAGNAC-MONTPEZAT", "modified": "2015-05-25", "multimedia_credits": ";;;;", "site_web": "http://www.aquattitude.com", "classement_labels": "Parc Naturel R\u00e9gional;Qualit\u00e9 Tourisme", "id": "48217", "lang": "fr", "etat": "publi\u00e9e", "description_complementaire": "Toutes nos activit\u00e9s se font uniquement sur RESERVATION.\r\nPour tous renseignements ou devis nous contacter.\r\nMarque Parc.", "themes_ids": "THE0106;THE0109;THE0115;THE0121;THE0143;THE0145;THE0153", "altitude": 413.405059814, "raison_sociale_etab": "AQUATTITUDE", "multimedia_url_photo": "http://static.kap-tourisme.fr/public/medias/27/1301387584000.jpg;http://static.kap-tourisme.fr/public/medias/27/1301387744000.jpg;http://static.kap-tourisme.fr/public/medias/27/1302696553000.jpg;http://static.kap-tourisme.fr/public/medias/27/1302696602000.jpg", "personne_civilite_etab": "M", "code_insee_etab": "04124", "titre": "AQUATTITUDE", "type": "ASC", "description_introduction": "Aquattitude, une \u00e9quipe de professionnels des sports de pleine nature, vous invite \u00e0 partager leur passion dans un site unique et grandiose\u00a0: \u00ab\u00a0les gorges du Verdon\u00a0\u00bb.\r\nNotre devise \u00ab\u00a0Ressentir la nature, Vivre une aventure\u00a0\u00bb.", "personne_tel1_etab": "06 79 21 03 77", "prestations": "Accessible handicap moteur;Accessible handicap visuel;Accessible handicap auditif;Accessible handicap mental;Acc\u00e8s partiel handicap moteur", "adr_info": "Base nautique de Quinson", "territoires": "Lacs et Plateaux du Verdon", "personne_prenom_etab": "Christophe", "code_postal_etab": "04500", "themes": "Activit\u00e9 Aquatiques/Rafting;Activit\u00e9 Aquatiques/Cano\u00eb Kayak;Activit\u00e9 Aquatiques/Nage en eau vive;Activit\u00e9 Aquatiques/Randonn\u00e9e Aquatique;Activit\u00e9 Terre/Balade comment\u00e9e;Activit\u00e9 Terre/Parcours d'Orientation;Activit\u00e9 Terre/Randonn\u00e9e P\u00e9destre", "pays_etab": "FRANCE", "personne_nom_etab": "TREMEAU", "created": "2013-07-01", "geo_point_2d": [43.746359, 6.085138], "personne_mel1_etab": "aquattitude04@aliceadsl.fr", "prestations_ids": "PRE0001;PRE0002;PRE0003;PRE0004;PRE0005"}, "geometry": {"type": "Point", "coordinates": [6.085138, 43.746359]}, "record_timestamp": "2015-05-25T20:00:05+02:00"},{"datasetid": "adt04_loisirs", "recordid": "8357086d5277367db52eaa00da4ed77a664a9253", "fields": {"adr_etab": "Le haut village", "description_presentation": "Martine CAZIN, c\u00e9ramiste et peintre ont fait le choix d'y pr\u00e9senter leur travail et les oeuvres des artistes de leur r\u00e9gion, entretenant avec eux un dialogue constant.\r\n\r\nAbstraits ou figuratifs, leurs personnalit\u00e9s s'expriment dans le langage de notre \u00e9poque.\r\n\r\nUne petite biblioth\u00e8que \u00e0 la disposition des visiteurs, des rencontres avec les artistes en permettent l'approche et font de la cr\u00e9ation un lieu de partage.\r\n\r\nP\u00e9riode d'Ouverture \r\n\r\nMai: tous les jours, de 15 \u00e0 19 h et sur rendez-vous\r\nJuillet : tous les jours, de 15 \u00e0 19 H et sur rendez-vous\r\nAo\u00fbt : tous les jours, de 15 \u00e0 19 H et sur rendez-vous\r\n\r\nParking \u00e0 la Rotonde", "commune_etab": "SIMIANE-LA-ROTONDE", "modified": "2015-05-25", "themes": "Mus\u00e9e exposition et observatoire/Mus\u00e9e exposition, observatoires;Patrimoine culturel/Patrimoine culturel", "site_web": "http://www.lamaisondebrian.fr", "id": "48439", "lang": "fr", "etat": "publi\u00e9e", "themes_ids": "THE0170;THE0171", "altitude": 705.231384277, "raison_sociale_etab": "LA MAISON DE BRIAN - ART CONTEMPORAIN", "code_insee_etab": "04208", "titre": "LA MAISON DE BRIAN - ART CONTEMPORAIN", "type": "PCU", "description_introduction": "Quand le Luberon s'\u00e9tire vers la Haute - Provence mythique de Giono, on arrive \u00e0 SIMIANE-LA-ROTONDE.\r\nUn jour gris de novembre 1964, un anglais amoureux de la France, Brian Featherstone, pose sa malle et ses livres dans l'ancienne maison du cordonnier.\r\nTraducteur aux Nations Unies, \u00e9crivain et berger au pays, cet homme de dialogue participera activement pendant toute son existence au renouveau du village.\r\n\r\nSa maison fut toujours ouverte aux artistes.\r\nEt aujourd'hui, dans le d\u00e9dale de pierre, l'ancienne et chaleureuse maison de Brian se consacre \u00e0 l'art contemporain et invite \u00e0 partager l'aventure de la modernit\u00e9.", "personne_tel1_etab": "04 92 75 91 49", "adherent": "forcalquier", "prestations": "Parking;Parking;Parking mort;Parking mort", "bureau_distrib_etab": "SIMIANE-LA-ROTONDE", "territoires": "Manosque - Forcalquier en Haute Provence", "code_postal_etab": "04150", "pays_etab": "FRANCE", "created": "2013-07-01", "geo_point_2d": [43.981081, 5.55876], "personne_mel1_etab": "lamaisondebrian@orange.fr", "prestations_ids": "PRE0270;PRE0270;PRE0272;PRE0272"}, "geometry": {"type": "Point", "coordinates": [5.55876, 43.981081]}, "record_timestamp": "2015-05-25T20:00:05+02:00"}]
    
    #TODO charger data depuis un fichier json et en prendre quelques uns au hasard (coté serveur)
    $scope.objectives = [
      new Objective(1, 3, 5,data[0]),
      new Objective(2, 4, 7,data[1])
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
        
  