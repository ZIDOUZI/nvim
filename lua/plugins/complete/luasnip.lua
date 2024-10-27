return {
  'L3MON4D3/LuaSnip',
  build = 'make install_jsregexp',
  config = function()
    local ls = require('luasnip')

    ls.config.setup { enable_autosnippets = true, }
    -- ls.log.set_loglevel('debug')


    --[[ ls.add_snippets('all', require('luasnippets.all'))
    ls.add_snippets('markdown', require('luasnippets.markdown')) ]]
    require('luasnip.loaders.from_lua').lazy_load {
      paths = './lua/snips',
    }
  end,
}
