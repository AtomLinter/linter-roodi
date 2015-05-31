module.exports =
  config:
    executablePath:
      title: 'Roodi executable path'
      description: 'The path where Roodi is located'
      type: 'string'
      default: ''

  activate: (state) ->
    console.log 'activate linter-roodi'
