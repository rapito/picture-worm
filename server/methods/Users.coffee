getAccountId = (userId)->
  Meteor.users.findOne({_id: userId}).services?.contextio?.accountId

Meteor.methods
  'Users.getAccountId': (userId) ->
    getAccountId userId

  'Users.connectTokens': (userId, accountId, token)->
    if not accountId or not token
      console.error 'no accountId nor token? wth dude?'
      return

    source = Cio.connectTokensSimple accountId, token

    user = Meteor.user()
    user.services?.contextio?.sources?.push
      email: source?.email
      label: source?.serverLabel

    Meteor.users.update({_id: userId}, user)
    source

  'Users.getMailboxes': (accountId)->
    result = Cio.callAsyncOrSync(Cio.client.accounts(accountId).sources().get)
    result = result?.body

  'Users.filterMailboxes': (accountId, doc)->
    result = Cio.callAsyncOrSync Cio.client.accounts(accountId).files().get, doc
    result

  'Users.getFileLink': (accountId, fileId)->
    params = {as_link: 1} # get link
    result = Cio.callAsyncOrSync Cio.client.accounts(accountId).files(fileId).content().get, params
    result =
      fileId: fileId
      url: result?.body

    result