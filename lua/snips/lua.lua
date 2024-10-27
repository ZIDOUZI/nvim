local r = require('utils.resolver')
local resolve = r.parse



return {
  resolve('plug', r.trim [[
    return {
      '$1/$2',
      opts = {$0},
    }]]),
  -- resolve('({[^}]-}) ', r.f(function(_, snip)
  --   return snip.captures[1]:gsub([[%b'',]], '%1\n'):gsub([[%b"",]], '%1\n'):gsub('^{', '{\n'):gsub('} $', '\n}')
  -- end), 'pHA'),
  resolve('({[^}]-}) ', r.d(1, function(_, snip)
    local s = snip.captures[1]:gsub([[%b'',]], '%1\n'):gsub([[%b"",]], '%1\n'):gsub('^{', '{\n'):gsub('}$', '\n}')
    return r.s(nil, r.t(r.split(s, '\n')))
  end), 'pHA'),
  --[[ r.S('plug', {
    r.t { "return {", "  '" },
    r.i(1),
    r.t("/"),
    r.i(2),
    r.t { "',", "  config = function()", "    require('" },
    r.d(3, function(args) return r.s(nil, r.i(1, args[1])) end, 2),
    r.t("').setup {"),
    r.i(0),
    r.t { "}", "  end", "}" }
  }) ]]
}
