class @ContextIOClient
  ContextIO = Npm.require('contextio')
  @instance: null

  client: null
  key: null
  secret: null

  Constructor: (key, secret)->
    @key = key
    @secret = secret

    @client = new ContextIO.Client
      key: key
      secret: secret
    @instance = @

  @get: (key, secret)->
    if @instance?
      return @instance

    key ?= Meteor.settings.services.contextio.key
    secret ?= Meteor.settings.services.contextio.secret
    @instance ?= new ContextIOClient(key, secret)
    @instance


@CioC = ContextIOClient.get()
@Cio = @CioC.client