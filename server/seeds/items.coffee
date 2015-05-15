Meteor.startup ->
  Factory.define 'item', Items,
    name: ->
      Fake.sentence()

    description: ->
      Fake.paragraph()

    rating: ->
      _.random 1, 5

  if Items.find({}).count() is 0
    _(10).times (n) ->
      Factory.create 'item'
      return

  return
