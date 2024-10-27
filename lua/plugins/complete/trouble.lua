return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    modes = {
      symbols = {
        filter = {
          ["not"] = { ft = "NvimTree" }
        }
      }
    }
  }
}
