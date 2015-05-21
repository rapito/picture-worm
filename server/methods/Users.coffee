getAccountId = (userId)->
  Meteor.users.findOne({_id: userId}).services?.contextio?.accountId

Meteor.methods
  'Users.getAccountId': (userId) ->
    getAccountId userId

  'Users.connectTokens': (userId, token)->
    console.log arguments
    accountId = getAccountId userId
    source = Cio.connectTokensSimple accountId, token
    source = source?.label

    console.log 'received source!', source
    user = Meteor.user()
    user.services?.contextio?.sources?.push source

    Meteor.users.update({_id: userId}, user)


  'Users.getMailboxes': (accountId)->
    result = Cio.callAsyncOrSync(Cio.client.accounts(accountId).sources().get)
    result = result?.body
