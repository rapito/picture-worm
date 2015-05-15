Package.describe({
    summary: "picture-worm backend package",
    version: "0.0.0",
    name: "rapito:worm-core",
    git: "https://github.com/rapito/picture-worm.git"
});

Npm.depends({
    "contextio": "0.4.0"
})

Package.onUse(function (api) {
    api.versionsFrom('1.1.0.2');
    api.use('coffeescript');
    api.use('underscore');
    api.addFiles('ContextIOClient.coffee', 'server');
});

Package.onTest(function (api) {
    api.use('rapito:worm-core', 'server');
    api.use('practicalmeteor:munit');
    api.use('coffeescript');

    api.addFiles('tests/Tests.coffee', 'server');
    api.addFiles('tests/ContextIOClientTests.coffee', 'server');
});
