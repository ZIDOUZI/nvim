return {
  'ziontee113/icon-picker.nvim',
  dependencies = { 'stevearc/dressing.nvim' },
  config = function()
    local picker = require('icon-picker')
    picker.setup {
      disable_legacy_commands = true
    }

    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }
    map('n', '<leader>ic', '<CMD>IconPickerNormal nerd_font<CR>', opts)
    map('n', '<leader>icy', '<CMD>IconPickerYank nerd_font<CR>', opts)
    -- map('i', '<C-I>', '<CMD>IconPickerInsert nerd_font<CR>', opts)
  end
}
