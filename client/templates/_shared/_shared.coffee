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

@toast = (message)->
  Materialize.toast(message, Settings.toastTimeout)