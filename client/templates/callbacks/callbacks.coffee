Template.callbackProcess.rendered = ->
  token = this.data?.token
  parentWindow = window.opener

  if token? and parentWindow?
    userId = parentWindow.Meteor.userId()
    accountId = parentWindow.Session.get('accountId')

    parentWindow.Meteor.call 'Users.connectTokens', userId, accountId, token, (e, result)->
      if not e? # update previous windows mailboxes if successful
        parentWindow.Meteor.call 'Users.getMailboxes', accountId, (e, r)->
          if not e?
            parentWindow.Session.set 'mailboxes', r

    window.close()