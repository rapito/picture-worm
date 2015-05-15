Package.onUse(function (api) {

});

Package.onTest(function (api) {
    api.use(['practicalmeteor:munit']);
    api.use(['coffeescript']);
    api.addFiles('contextioTests.coffee');
})

