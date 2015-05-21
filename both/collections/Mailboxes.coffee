@MailboxesFilterSchema = new SimpleSchema
  email:
    type: String
    max: 200
    optional: true
    autoform:
      class: 'white-text'
