Template.dashboard.rendered = ->
  userId = Meteor.userId()
  Meteor.call 'Users.getAccountId', userId, (e, r)->
    if e?
      alert e
    else
      accountId = r
      Session.set 'accountId', accountId

    Meteor.call 'Users.getMailboxes', accountId, (e, r)->
      if e?
        alert e
      else
        Session.set 'mailboxes', r


Template.dashboard.helpers
  accountId: ->
    Session.get 'accountId'

  classesMailboxAdd: ->
    'btn-floating btn-large waves-effect waves-light right mdi-content-add'

  callbackUrl: ->
    hash = {};
    hash.route = 'callbackProcess';
    options = new Spacebars.kw(hash);

    UI._globalHelpers.urlFor options

  mailboxes: ->
    Session.get 'mailboxes'