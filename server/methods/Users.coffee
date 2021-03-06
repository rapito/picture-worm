cioError = (error)->
  {type: 'error', value: error}

getAccountId = (userId)->
  Meteor.users.findOne({_id: userId}).services?.contextio?.accountId

Meteor.methods
  'Users.getAccountId': (userId) ->
    getAccountId userId

  'Users.connectTokens': (userId, accountId, token)->
#    accountId =
    if not accountId or not token
      console.error 'no accountId nor token? wth dude?'
      return

    source = Cio.connectTokensSimple accountId, token
#    accountId =

    user = Meteor.user()
    user.services?.contextio?.sources?.push
      email: source?.email
      label: source?.serverLabel

    Meteor.users.update({_id: userId}, user)
    source

  'Users.getMailboxes': (accountId)->
#    accountId =
    result = cioError 'no accountId passed'
    if accountId
      result = Cio.callAsyncOrSync(Cio.client.accounts(accountId).sources().get)
      result = result?.body

    result

  'Users.filterMailboxes': (accountId, doc, label)->
#    accountId =
    result = cioError 'no accountId or doc passed'
    if accountId?
      doc ?= {}

      # we are looking only for images
      doc?.file_name = "/\.(?i)(jpg|jpeg|png|gif|bmp)$/"
      doc.limit = Settings.pageSize
      doc.file_size_min = 102400 # 100kb
      doc.file_size_max = 819200 # 800kb

      if doc.date_before == 0
        delete doc.date_before

      if doc.date_after == 0
        delete doc.date_after

      doc.sort_order = 'asc'

      result = Cio.callAsyncOrSync Cio.client.accounts(accountId).files().get, doc
      result?.label = label
      result?.doc = doc
    result

  'Users.getFileLink': (accountId, fileId)->
#    accountId =
    result = cioError 'no accountId or fileId passed'

    if accountId? and fileId?
      params =
        as_link: 1 # get link

      result = Cio.callAsyncOrSync Cio.client.accounts(accountId).files(fileId).content().get, params
      result =
        fileId: fileId
        url: result?.body

    result

  'Users.deleteMailbox': (accountId, label)->
#    accountId =
    result = cioError 'no accountId or label passed'

    if accountId? and label?
      result = Cio.callAsyncOrSync Cio.client.accounts(accountId).sources(label).delete, {}
      result = result?.body

    result

  'Users.fetchMail': (accountId, messageId)->
#    accountId =
    result = cioError 'no accountId or messageId passed'
    params =
      include_body: 1

    if accountId? and messageId?
      result = Cio.callAsyncOrSync Cio.client.accounts(accountId).messages(messageId).get, params
      result = result?.body

    result