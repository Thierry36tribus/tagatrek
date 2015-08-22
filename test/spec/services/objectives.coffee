'use strict'

describe 'Service: Objectives', ->

  # load the service's module
  beforeEach module 'tagatrekApp'

  # instantiate service
  Objectives = {}
  beforeEach inject (_Objectives_) ->
    Objectives = _Objectives_

  it 'should do something', ->
    expect(!!Objectives).toBe true
