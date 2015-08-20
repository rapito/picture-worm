Router.route '/',
  name: 'home'

Router.route '/ToS',
  name: 'tos'
  layoutTemplate: 'appLayout'

Router.route '/Privacy',
  name: 'privacy'
  layoutTemplate: 'appLayout'

Router.route '/dashboard',
  name: 'dashboard'

Router.route '/items/new',
  name: 'items.new'

Router.route '/callbacks/process',
  name: 'callbackProcess'
  path: '/api/cb/contextio/connect_tokens/'
  data: ->
    data =
      params: this.params
      token: this.params.query.contextio_token

Router.plugin 'ensureSignedIn',
  only: ['dashboard']
