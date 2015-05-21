Template.imgCard.rendered = ->
  imgs = $('img[data-img-id]')
  accountId = Session.get 'accountId'

  for img in imgs
    fileId = $(img).attr('data-img-id')
    cb = (e, r)->
      imgUri = if e? then 'http://materializecss.com/images/sample-1.jpg' else r.url
      imgId = r?.fileId
      $("img[data-img-id='#{imgId}']")[0].src = imgUri

    Meteor.call 'Users.getFileLink', accountId, fileId, cb


