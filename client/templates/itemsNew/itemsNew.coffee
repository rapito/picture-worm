AutoForm.hooks 'items-new-form':
  onSuccess: (operation, result, template) ->
    _toast 'Item created successfully!'
    Router.go 'dashboard'
    return
