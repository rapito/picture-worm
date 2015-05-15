AutoForm.hooks 'items-new-form':
  onSuccess: (operation, result, template) ->
    toast 'Item created successfully!', 4000
    Router.go 'dashboard'
    return
