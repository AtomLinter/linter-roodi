{BufferedProcess, CompositeDisposable} = require 'atom'

module.exports =
  config:
    executablePath:
      type: 'string'
      title: 'The path where Roodi is located'
      default: 'roodi'
  activate: ->
    console.log 'activate linter-roodi'
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.config.observe 'linter-roodi.executablePath',
      (executablePath) =>
        @executablePath = executablePath
  deactivate: ->
    @subscriptions.dispose()
  provideLinter: ->
    provider =
      grammarScopes: ['source.ruby', 'source.ruby.rails', 'source.ruby.rspec']
      scope: 'file' # or 'project'
      lintOnFly: true # must be false for scope: 'project'
      lint: (textEditor) =>
        return new Promise (resolve, reject) =>
          filePath = textEditor.getPath()
          output = ""
          process = new BufferedProcess
            command: @executablePath
            args: [filePath, '--json']
            stdout: (data) ->
              output = data
            exit: (code) ->
              return resolve [] if code is 0

              lines = output.split("\n")
              errorPattern = /.+?:(\d+) - (.+)\[/

              errors = []

              for line in lines
                result = line.match errorPattern
                if result
                  errors.push {
                    text: result[2]
                    line: result[1]
                  }

              return resolve [] unless errors?
              resolve errors.map (error) ->
                type: "Error",
                text: error.text,
                filePath: filePath,
                range: [
                  # Atom expects ranges to be 0-based
                  [error.line - 1, 0],
                  [error.line - 1, 10000]
                ]

          process.onWillThrowError ({error,handle}) ->
            atom.notifications.addError "Failed to run #{@executablePath}",
              detail: "#{error.message}"
              dismissable: true
            handle()
            resolve []
