return {
  'HiPhish/rainbow-delimiters.nvim',
  event = 'BufRead',
  config = function()
    -- This module contains a number of default definitions
    local rainbow = require('rainbow-delimiters')

    -- - @type rainbow_delimiters.config
    vim.g.rainbow_delimiters = {
      strategy = {
        [''] = rainbow.strategy['global'],
        vim = rainbow.strategy['local'],
      },
      query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
      },
      priority = {
        [''] = 110,
        lua = 210,
      },
      highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
      },
    }
  end
}
