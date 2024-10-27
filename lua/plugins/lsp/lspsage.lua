return {
  'nvimdev/lspsaga.nvim',
  opts = {
    outline = {
      layout = "float",
      keys = {
        quit = "Q",
        toggle_or_jump = "<CR>",
      }
    },
    finder = {
      keys = {
        quit = "Q",
        shuttle = 'J',
        toggle_or_open = '<CR>',
      },
    },
    definition = {
      keys = {
        edit = '<C-c>j',
      }
    }
  }
}
