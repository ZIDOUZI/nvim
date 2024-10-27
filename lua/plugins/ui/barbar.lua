return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons'
  },
  init = function()
    vim.g.barbar_auto_setup = false
    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = 'apprentice',
      callback = function()
        vim.api.nvim_set_hl(0, 'BufferCurrentSign', { fg = '#1B1D2B' })
        vim.api.nvim_set_hl(0, 'BufferCurrentSignRight', { fg = '#1B1D2B' })
        vim.api.nvim_set_hl(0, 'BufferVisibleSign', { fg = '#2C3048' })
        vim.api.nvim_set_hl(0, 'BufferVisibleSignRight', { fg = '#2C3048' })

        vim.api.nvim_set_hl(0, 'BufferCurrent', { bg = 'transparent' })
      end
    })
  end,
  opts = {
    icons = {
      separator = { left = '', right = '' },
    }
  },
  version = '^1.0.0'
}
