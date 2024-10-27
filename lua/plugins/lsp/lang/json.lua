return {
  settings = {
    json = {
      schema = require('schemastore').json.schemas {
        ignore = {
          '.eslintrc',
          'package.json'
        },
        validate = { enable = true }
      }
    }
  }
}
