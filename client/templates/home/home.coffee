Template.home.rendered = ->


Meteor.methods
  'connectTokens': (token)->
    console.log 'connectTokens:received!', token