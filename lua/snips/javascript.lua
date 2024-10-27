local r = require('utils.resolver')
local resolve = r.parse

return {
  resolve('(%a[%w_]+%)) ?=>', '[[1]] => {$0}', 'pHA')
}