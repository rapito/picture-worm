Template.dashboard.rendered = ->
  userId = Meteor.userId()
  Meteor.call 'Users.getAccountId', userId, (e, r)->
    e = parseCioError e, r
    if e?
      alert e
    else
      accountId = r
      Session.set 'accountId', accountId

    Meteor.call 'Users.getMailboxes', accountId, (e, r)->
      e = parseCioError e, r
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

  'click #btn-load-more': (evt)->
    try
      id = Session.get 'accountId'
      toggleDisabledElement '#btn-load-more', false       # disable load more

      doc = Session.get 'currentDoc' # get currentQuery
      doc = sanitizeDoc(doc)
      doc.offset = if doc.offset? then doc.offset + 9 else 9 # offset to 9 more

      Meteor.call 'Users.filterMailboxes', id, doc, (e, r)->
        e = parseCioError e, r
        console.log e, r
        if not e?
          pushFiles r?.body
          toggleDisabledElement '#btn-load-more', true # re-enable button
          Session.set 'currentDoc', doc
        else
          console.log e
    catch e
      console.error e

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
    result = Session.get 'mailboxes'
    #    console.log result
    result

  mailboxFiles: ->
    result = Session.get 'files'
    #    console.log result
    result
