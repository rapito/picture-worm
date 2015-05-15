module.exports = (grunt) ->
# Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    js2coffee:
      each:
        options: {}
        files: [{
          expand: true
          src: ['both/**/*.js', 'client/**/*.js', 'private/**/*.js', 'public/**/*.js', 'server/**/*.js']
          dest: './'
          ext: '.coffee'
        }]

  # Load the plugin that provides the "uglify" task.
  grunt.loadNpmTasks 'grunt-js2coffee'
  # Default task(s).
  grunt.registerTask 'default', ['js2coffee']
  return
