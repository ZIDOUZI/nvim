return {
  'ofirgall/open.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim' },
  config = function()
    local open = require('open')
    open.setup {
      curl_opts = {
        compressd = false
      }
    }
    vim.keymap.set('n', 'gx', open.open_cword)
    -- vim.keymap.set('n', '<C-;>', open.open_cword)
  end
}
