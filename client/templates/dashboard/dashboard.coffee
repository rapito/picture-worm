Template.dashboard.rendered = ->
  userId = Meteor.userId()
  fetchAccountInfo(userId)
  initModals()


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
      toggleDisabledElement '#btn-load-more', false # disable load more

      doc = Session.get 'currentDoc' # get currentQuery
      doc = sanitizeDoc(doc)
      doc.offset = if doc.offset? then doc.offset + Settings.pageSize else Settings.pageSize # offset to 9 more

      Meteor.call 'Users.filterMailboxes', id, doc, (e, r)->
        e = parseCioError e, r
        console.log e, r
        if not e?
          pushFiles r?.body
          Session.set 'currentDoc', doc

          # hide load more button if no more files
          if _.isEmpty r?.body
            toggleElementVisibility '#btn-load-more', false # re-enable button
            _toast 'No more images!'
          else  # just enable it
            toggleDisabledElement '#btn-load-more', true # re-enable button

        else
          console.log e
    catch e
      console.error e

  'click .mb-delete': (evt)->
    initModals()
    $('#modal-del-mb').openModal();

    Session.set 'mailboxToDelete', this

Template.deleteMailboxConfirmModal.events =
  'click a[data-mailbox]': (evt)->
    label = this.label
    username = this.username
    accountId = Session.get 'accountId'
    Meteor.call 'Users.deleteMailbox', accountId, label, (e, r)->
      e = parseCioError e, r
      if e?
        alert e
      else
        if r?.success == true
          deleteMailboxFromArray label
          _toast "Mailbox #{username} deleted!"

Template.dashboard.helpers
  accountId: ->
    result = Session.get 'accountId'

  classesMailboxAdd: ->
    'btn-floating btn-large waves-effect waves-light right mdi-content-add'

  callbackUrl: ->
    hash = {};
    hash.route = 'callbackProcess';
    options = new Spacebars.kw(hash);

    UI._globalHelpers.urlFor options

  mailboxes: ->
    result = Session.get 'mailboxes'
#    result = safeArray result
    #    console.log result
    result

  mailboxFiles: ->
    result = Session.get 'files'
#    result = safeArray result
    #    console.log result
    result

  mailboxToDelete: ->
    Session.get 'mailboxToDelete'

  emailToShow: ->
    Session.get 'emailToShow'

Template.emailModal.helpers
  date_received: ->
    moment(this.date_received).format("LLLL")

  content: ->
    Session.get 'emailToShow.content'

  mailImages: ->
    Session.get 'emailToShow.images'

# Looks for mailboxes on the current accountId
# and stores them in Session.
fetchAccountInfo = (userId) ->
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
        if _.isEmpty r
          _toast 'Click on the "+" button to add your first Mailbox!'

initModals = ->
  $('.modal-trigger').leanModal() # init modal triggers
