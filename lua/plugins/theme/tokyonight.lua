return {
  'folke/tokyonight.nvim',
  priority = 10000,
  lazy = false,
  config = function ()
    require('tokyonight').setup {
      transparent = true,
      terminal_color = true,
      styles = {
        comments = { italic = true },
        functions = { bold = true },
        keywords = { italic = true },
      },
      lualine_bold = true,
    }
    vim.cmd [[colorscheme tokyonight]]
  end
}
