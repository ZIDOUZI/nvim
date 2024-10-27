return {
  'lukas-reineke/headlines.nvim',
  config = function()
    vim.cmd [[highlight Headline1 guibg=#1e2718]]
    vim.cmd [[highlight Headline2 guibg=#21262d]]
    vim.cmd [[highlight CodeBlock guibg=#1C1C1C]]
    vim.cmd [[highlight Dash guibg=#D19A66, gui=bold]]
    require('headlines').setup {
      org = {
        headlines_highlights = {  }
      }
    }
  end
}
