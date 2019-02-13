{ BufferedProcess, CompositeDisposable } = require 'atom'
helpers = require 'atom-linter'

module.exports =
  activate: ->
    console.log 'activate linter-roodi' if atom.inDevMode()
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.config.observe 'linter-roodi.executablePath',
      (executablePath) ->
        @executablePath = executablePath
  deactivate: ->
    @subscriptions.dispose()
  provideLinter: ->
    provider =
      name: 'roodi'
      grammarScopes: ['source.ruby', 'source.ruby.rails', 'source.ruby.rspec']
      scope: 'file' # or 'project'
      lintsOnChange: true # must be false for scope: 'project'
      lint: (textEditor) ->
        return new Promise (resolve, reject) ->
          filePath = textEditor.getPath()
          output = ''
          process = new BufferedProcess
            command: @executablePath
            args: [filePath]
            stdout: (data) ->
              output = data
            exit: (code) ->
              return resolve [] if code is 0

              lines = output.split("\n")
              errorPattern = /.+?:(\d+) - (.*)\x1B\[[0-?]/

              errors = []

              for line in lines
                result = line.match errorPattern

                if result
                  errors.push {
                    message: result[2]
                    line: result[1]
                  }

              return resolve [] unless errors?

              resolve errors.map (error) ->
                severity: 'error'
                excerpt: error.message
                location:
                  file: filePath
                  position: helpers.generateRange(textEditor, Number.parseInt(error.line, 10) - 1)

          process.onWillThrowError ({ error, handle }) ->
            atom.notifications.addError "Failed to run #{@executablePath}",
              detail: "#{error.message}"
              dismissable: true
            handle()
            resolve []
