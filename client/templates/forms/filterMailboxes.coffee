Template.filterMailboxesForm.rendered = ->


Template.filterMailboxesForm.helpers
  mailboxesFilterSchema: ->
    MailboxesFilterSchema

AutoForm.hooks
  filterMailboxesForm:
    onSubmit: (doc)->
      id = Session.get 'accountId'

      # we are looking only for images
      doc?.file_name = "/\.jpe?g$/"

      form = this

      Meteor.call 'Users.filterMailboxes', id, doc, (e,r)->
        console.log e,r
        form.done()

      false