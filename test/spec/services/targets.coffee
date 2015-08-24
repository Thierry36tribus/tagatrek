'use strict'

describe 'Service: Targets', ->

  # load the service's module
  beforeEach module 'tagatrekApp'

  # instantiate service
  Targets = {}
  beforeEach inject (_Targets_) ->
    Targets = _Targets_

  it 'should do something', ->
    expect(!!Targets).toBe true
