Package.onUse(function (api) {

});

Package.onTest(function (api) {
    api.use(['practicalmeteor:munit']);
    api.use(['coffeescript', 'underscore']);
    api.addFiles('contextioTests.coffee');
})

