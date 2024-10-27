return {
  'jbyuki/nabla.nvim',
  cond = false,
  ft = { 'markdown', 'tex' },
  keys = {
    { '<C-K>' },
    { 'K' },
  },
  config = function()
    local nabla = require('nabla')
    nabla.enable_virt {
      autogen = true,
    }
    vim.keymap.set('i', '<C-K>', nabla.popup)
    vim.keymap.set('n', 'K', nabla.popup)
  end
}
