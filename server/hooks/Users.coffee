Accounts.onCreateUser (opts, user)->
  console.log opts
  console.log user
  mail = user.emails[0]
  #attach account to user
  Cio.createAccountSimple(mail,mail,mail)
  user