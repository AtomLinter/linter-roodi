linter-roodi
=========================

This is a [Linter](https://github.com/AtomLinter/Linter) plugin that inspects your Ruby code using [roodi](https://github.com/roodi/roodi).

## Usage
As you save a file, Roodi will run checks just like any other Linter plugin. If there are any issues in your file, a message will pop up.

## Installation

1. Linter must be installed in order to use this plugin. If Linter is not installed, please see [the instructions](https://github.com/AtomLinter/Linter).
1. Install [roodi](https://github.com/roodi/roodi):
   ```
   gem install roodi
   ```

Now you can proceed to install the linter-roodi plugin.

### Plugin installation
```
$ apm install linter-roodi
```

#### executablePath
```
'linter-roodi':
  'executablePath': null # roodi path.
```
Run `which roodi` to find the path,
if you using rbenv run `rbenv which roodi`

**Note**: This plugin finds the nearest .roodi.yml file and uses the --config command line argument to use that file, so you may not use the --config argument in the linter settings.

## Contributing

### Bug reporting
Please use the GitHub issue tracker.

### Want to submit some code?
Fantastic! Please follow this procedure:
- Fork the repository
- Create a well-named topic branch
- Add specs for any changes you make
- Write meaningful commit messages explaining why this change is needed
- Create a pull request.

## License

(The MIT License)

Copyright (c) 2015 Peter Evjan

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.

IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
