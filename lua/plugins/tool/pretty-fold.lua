return {
  'anuvyklack/pretty-fold.nvim',
  opts = {
    sections = {
      left = { 'content' },
      right = {
        ' ',
        'number_of_folded_lines',
        ': ',
        'percentage',
        ' ──',
        function(config)
        	return config.fill_char:rep(3)
        end,
      },
    },
  }
}
