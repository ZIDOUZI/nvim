local r = require('utils.resolver')
local resolve = r.parse


local part = function(func, ...)
  local args = {...}
  return function() return func(unpack(args)) end
end

local pair = function(pair_begin, pair_end, expand_func, ...)
  return r.S(
    { trig = pair_begin, wordTrig = false, snippetType = 'autosnippet' },
    { r.t(pair_begin), r.i(1), r.t(pair_end) },
    { condition = part(expand_func, part(..., pair_begin, pair_end))}
  )
end

return {
   
  -- resolve('(%w+) ?=', '[[1]] = ', 'pHA'),
  -- resolve('(%w+) ?= ?=', '[[1]] == ', 'pHA'),
}
