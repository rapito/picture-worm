# Parses the result of a meteor call to any of the Cio Exposed methods.
# Returns false if there is no error or the error object if any
@parseCioError = (e, r)->
  result = null # no error by default

  if e?
    result = e
  else if r?.body?.type == 'error'
    result = r.body.value

  result

@safeArray = (obj) ->
  result = if _.isArray(obj) then obj else []
  result

@toggleDisabledElement = (element, enable)->
  if _.isString element
    element = $(element)

  classes = $(element).attr 'class'

  disabled = if enable? then enable else _.contains(classes, 'disabled')

  if disabled
    $(element).removeClass 'disabled'
  else
    $(element).addClass 'disabled'

# toggles the visibility of an element
@toggleElementVisibility = (element, show)->
  if show
    $(element).show()
  else if !show or $(element).css('display') != 'none'
    $(element).hide()

# Add more files to the session
@pushFiles = (loadout)->
  files = Session.get 'files'
  files ?= []

  for f in loadout
    files.push f

  Session.set 'files', files

@clearFiles = ->
  Session.set 'files', []

# fix query filters and add default values
@sanitizeDoc = (doc)->
  doc ?= {}

  if _.isObject(doc?.date_after) or _.isObject(doc?.date_before)
    doc?.date_before = doc?.date_before?.getTime() / 1000 | 0
    doc?.date_after = doc?.date_after?.getTime() / 1000 | 0

  doc

@_toast = (message)->
  toast(message, Settings.toastTimeout)

@deleteMailboxFromArray = (str)->
  mbs = Session.get 'mailboxes'
  result = []

  for s in mbs
    if s.label != str
      result.push s

  Session.set 'mailboxes', result
  mbs

# creates materialboxed image hides it, adds it to a container to be
# later shown on the card that contains the same fileId
@appendMaterializedBoxedImg = (fileId, imgUri, caption) ->
  boxed = document.createElement 'img'
  boxed.src = imgUri
  $(boxed).attr 'class', 'materialboxed hidden-card-image'
  $(boxed).attr 'id', "img-materialboxed-#{fileId}"
  $(boxed).attr 'data-caption', caption

  $('#materialboxed-container').append(boxed)
  $('.materialboxed').materialbox()

