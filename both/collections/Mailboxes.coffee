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
  date_after:
    type: Date
    optional: true
    autoform:
      type: 'pickadate'

