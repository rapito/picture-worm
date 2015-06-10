Template.registerHelper 'userName', ->
  name = Meteor.user()?.emails?[0].address
  name