# Picture Worm - Context.io

Tiny Worm living in your email that eats all of your pictures and throws them on a materialized web page.

Entry App for [Context.io App Challenge](http://contextio.challengepost.com/)

## Live Demo

- [http://pictureworm.meteor.com](http://pictureworm.meteor.com)

## Running

- development: ```meteor run --settings settings.dev.json```
- production: ```meteor run --settings settings.prod.json```

## Testing

- munit tests: ```meteor test-packages rapito:worm-core --port 1234 --settings settings.dev.json```

## Dependencies

- [Differential BoilerPlate](https://github.com/Differential/meteor-boilerplate/tree/materialize)
- [Materialize](http://materializecss.com/getting-started.html)
- [Context.io](https://github.com/rapito/meteor-contextio)
- [Munit](https://github.com/practicalmeteor/munit)