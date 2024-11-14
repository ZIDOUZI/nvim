return {
  'echasnovski/mini.nvim',
  cond = false,
  config = function()
    local animate = require('mini.animate')
    local timing =  animate.gen_timing.cubic { duration =  150, unit = 'total' }
    animate.setup {
      cursor = { timing = timing },
      scroll = { timing = timing },
      resize = { timing = timing },
      open = { timing = timing },
      close = { timing = timing },
    }
    require('mini.comment').setup {

    }
    require('mini.align').setup {}
    require('mini.surround').setup {}
  end
}
