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

Template.dashboard.events =
  'click input[data-mailbox-label]': (evt)->
#    console.log this, evt
    filtered = Session.get 'filteredMailboxes'
    filtered ?= {}

    if filtered?[this.label]?
      filtered[this.label] = null
    else
      filtered[this.label] = true

#    console.log filtered
    Session.set 'filteredMailboxes', filtered

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