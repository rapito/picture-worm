Template.imgCard.rendered = ->
  imgs = $('img[data-img-id]')
  accountId = Session.get 'accountId'
  fileId = this.data?.file_id

  cb = (e, r)->
    console.log 'received', arguments
    error = e? or r?.url?.type == 'error'

    imgUri = if (error) then 'http://data2.whicdn.com/images/45431798/thumb.png' else r.url
    imgId = r?.fileId

    el = "img[data-img-id='#{imgId}']"

    $(el)[0]?.src = imgUri
    $(el).parent().next().hide() # hide spinner

    if error
      console.error e, r
      el = $("#img-card-#{imgId} .card-content b")[0]
      $(el).html("There was a problem so here's Kamina")

    # make it previewable
    $('.materialboxed').materialbox()

  Meteor.call 'Users.getFileLink', accountId, fileId, cb


