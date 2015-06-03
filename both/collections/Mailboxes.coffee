@MailboxesFilterSchema = new SimpleSchema
  email:
    type: String
    max: 200
    optional: true
  date_before:
    type: Date
    optional: true
    autoform:
      type: 'pickadate'
      pickadateOptions: 'pickadateOptions'
  date_after:
    type: Date
    optional: true
    autoform:
      type: 'pickadate'
      pickadateOptions: 'pickadateOptions'

