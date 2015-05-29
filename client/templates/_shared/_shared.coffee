# Parses the result of a meteor call to any of the Cio Exposed methods.
# Returns false if there is no error or the error object if any
@parseCioError = (e, r)->
  result = null # no error by default

  if e?
    result = e
  else if r?.body?.type == 'error'
    result = r.body.value

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


