# Parses the result of a meteor call to any of the Cio Exposed methods.
# Returns false if there is no error or the error object if any
@parseCioError = (e,r)->
  result = false # no error by default

  if e?
    result = e
  else if r?.body?.type == 'error'
    result = r.body.value

  result

