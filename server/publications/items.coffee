Meteor.publishComposite 'items', ->
  find: ->
    Items.find {}


# ,
# children: [
#   {
#     find: function(item) {
#       return [];
#     }
#   }
# ]