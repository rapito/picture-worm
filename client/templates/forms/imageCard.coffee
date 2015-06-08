Template.imgCard.rendered = ->
  accountId = Session.get 'accountId'
  fileId = this.data?.file_id
  caption = "#{this.data?.file_name} - #{this.data?.subject}"

  Meteor.call 'Users.getFileLink', accountId, fileId, (e, r)->
    error = e? or r?.url?.type == 'error'
    imgId = r?.fileId

    if error
      console.error e, r
      # customize content in case of error
      subject = $("#img-card-#{imgId} .card-content b")[0]
      $(subject).html("There was a problem so here's Kamina")
      imgUri = 'http://data2.whicdn.com/images/45431798/thumb.png'
    else
      imgUri = r.url

    # let client load the img
    el = "img[data-img-id='#{imgId}']"
    $(el)[0]?.src = imgUri
    $(el).parent().next().hide() # hide spinner

    # create materialboxed image to trigger on this img click
    appendMaterializedBoxedImg fileId, imgUri, caption

Template.imgCard.events =
  'click .card-image': (evt)->
    $("#img-materialboxed-#{this.file_id}").click();

  'click .mail-trigger': (evt)->
    Session.set 'emailToShow', this
    Session.set 'emailToShow.images', []
    delete Session.keys['emailToShow.mail']
    delete Session.keys['emailToShow.content']

    $('.mail-trigger').leanModal();
    $('#modal-email').openModal();

    accountId = Session.get 'accountId'
    # fetch Email
    Meteor.call 'Users.fetchMail', accountId, this.email_message_id, (e,r)->
      e = parseCioError e, r
      console.log e, r
      if not e?
        Session.set 'emailToShow.mail', r
        content = getPreferredContent r
        Session.set 'emailToShow.content', content
        images = getImages r
        Session.set 'emailToShow.images', images


# extracts all images from the
getImages = (mail)->
  result = []
  for f in mail?.files
    if f.type.indexOf('image/') > -1
      result.push f
  result

# extracts mail body from mail object, looks for any text/html first
getPreferredContent = (mail)->
  content = '<p>Loading Content</p>'
  for b in mail?.body
    if b.type == 'text/html'
      return b.content
    else content = b.content
  content

# creates materialboxed image hides it, adds it to a container to be
# later shown on the card that contains the same fileId
appendMaterializedBoxedImg = (fileId, imgUri, caption) ->
  boxed = document.createElement 'img'
  boxed.src = imgUri
  $(boxed).attr 'class', 'materialboxed hidden-card-image'
  $(boxed).attr 'id', "img-materialboxed-#{fileId}"
  $(boxed).attr 'data-caption', caption

  $('#materialboxed-container').append(boxed)
  $('.materialboxed').materialbox()