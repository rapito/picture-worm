Template.filterMailboxesForm.rendered = ->


Template.filterMailboxesForm.helpers
  mailboxesFilterSchema: ->
    MailboxesFilterSchema

AutoForm.hooks
  filterMailboxesForm:
    onSubmit: (doc)->
      event.preventDefault();
      clearFiles()
      id = Session.get 'accountId'

      # we are looking only for images
      doc?.file_name = "/\.jpe?g$/"
      doc?.date_before = doc?.date_before?.getTime() / 1000 | 0
      doc?.date_after = doc?.date_after?.getTime() / 1000 | 0

#      doc =
#        file_name: doc?.file_name

      mailboxes = Session.get 'filteredMailboxes'
      form = this

      for label,v of mailboxes
        if mailboxes[label]?
          Meteor.call 'Users.filterMailboxes', id, doc, (e, r)->
            console.log e, r
            pushFiles r?.body
            form.done()

      false

pushFiles = (loadout)->
  files = Session.get 'files'
  files ?= []

  for f in loadout
    files.push f

  Session.set 'files', files

clearFiles = ->
  Session.set 'files', []