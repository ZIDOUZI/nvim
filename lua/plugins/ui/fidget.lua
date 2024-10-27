return {
  'j-hui/fidget.nvim',
  enabled = false,
  config = function()
    require('fidget').setup {
      notification = {
        window = {
          winblend = 10,
        }
      }
    }
  end
}
