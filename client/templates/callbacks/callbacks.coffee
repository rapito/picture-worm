Template.callbackProcess.rendered = ->
  token = this.data?.token
  parentWindow = window.opener

  if token? and parentWindow?
    console.log 'received token: ', token
    id = parentWindow.Meteor.userId()
    console.log 'userId', id
    console.log 'userId2', parentWindow.Session.get('accountId')
    parentWindow.Meteor.call 'Users.connectTokens', id, token
#    window.close()