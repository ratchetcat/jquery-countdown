{exec} = require 'child_process'

task 'assets:watch', 'Watch source files and build JS & CSS', (options) ->
  run = (command, callback) ->
    console.log command
    child = exec(command, (error, stdout, stderr) ->
      console.log stdout
      if error != null
        console.log "exec error: #{error}"
    )

  #run 'sass --watch public/css/sass:public/css'
  run 'coffee -co js coffee test'
  run 'uglifyjs js/jquery.countdown.js > js/jquery.countdown.min.js'
