Template.callbackProcess.rendered = ->
  console.log 'callbackProcess.rendered', this.data

  window.opener.Meteor.call 'connectTokens', this.data.token
  window.close()