Accounts.onCreateUser (opts, user)->
  mail = user.emails[0].address
  #attach account to user
  id = Cio.createAccountSimple(mail, mail, mail)
  if id?
    user.services.contextio =
      accountId: id
      sources: []
  else
    return false
  user
