Template.filterMailboxesForm.rendered = ->

Template.filterMailboxesForm.helpers
  mailboxesFilterSchema: ->
    MailboxesFilterSchema

  pickadateOptions: ->
    options =
      selectMonths: true
      selectYears: 15
    options

AutoForm.hooks
  filterMailboxesForm:
    onSubmit: (doc)->
      try
        clearFiles()
        id = Session.get 'accountId'

        toggleDisabledElement '#filterMailboxesForm .btn', false # disable button
        toggleElementVisibility('#btn-load-more',false) # hide load more button
        doc = sanitizeDoc doc

        mailboxes = Session.get 'filteredMailboxes'
        form = this

        for label,v of mailboxes
          if mailboxes[label]?
            Meteor.call 'Users.filterMailboxes', id, doc, (e, r)->
              e = parseCioError e, r
              console.log e, r
              if not e?
                pushFiles r?.body
                form.done()
                toggleElementVisibility('#btn-load-more',true)
                Session.set 'currentDoc', doc  # save current query
              else
                console.log e

              toggleDisabledElement '#filterMailboxesForm .btn', true # re enable button
      catch e
        console.error e

      false