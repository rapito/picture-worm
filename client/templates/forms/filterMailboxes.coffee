Template.filterMailboxesForm.rendered = ->

Template.filterMailboxesForm.helpers
  mailboxesFilterSchema: ->
    MailboxesFilterSchema

  pickadateOptions: ->
    options =
      selectMonths: true
      selectYears: 25
    options

AutoForm.hooks
  filterMailboxesForm:
    onSubmit: (doc)->
      try
        clearFiles()
        id = Session.get 'accountId'

        toggleDisabledElement '#filterMailboxesForm .btn', false # disable button
        toggleElementVisibility('#btn-load-more', false) # hide load more button
        doc = sanitizeDoc doc

        mailboxes = Session.get 'filteredMailboxes'
        form = this

        methodCalled = false

        for label,v of mailboxes
          if mailboxes[label]?
            doc.source = label
            Meteor.call 'Users.filterMailboxes', id, doc, (e, r)->
              e = parseCioError e, r
#              console.log e, r
              if not e?
                pushFiles r?.body
                form.done()
                toggleElementVisibility '#btn-load-more', true
                Session.set 'currentDoc', doc  # save current query

                files = Session.get 'files'
                if files?.length == 0
                  _toast 'No messages found try filtering by something else!'

              else
                console.log e

              toggleDisabledElement '#filterMailboxesForm .btn', true # re enable button
            methodCalled = true

        if not methodCalled
          _toast 'Choose at least one mailbox to send the worms to!'
          toggleDisabledElement '#filterMailboxesForm .btn', true # re enable button

      catch e
        console.error e

      false