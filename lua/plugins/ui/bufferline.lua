return {
  'akinsho/bufferline.nvim',
  event = "VeryLazy",
  opts = {
    options = {
      diagnostics = 'nvim_lsp',
      -- diagnostics_indicator = function (count, level, diagnostics_dict, context)
      --   local s = " "
      --   for e, n in pairs(diagnostics_dict) do
      --     local sym = e == "error" and " "
      --       or (e == "warning" and " " or " ")
      --     s = s .. n .. sym
      --   end
      --   return s
      -- end,
      indicator = { style = 'underline' },
      hover = {
        enabled = true,
        delay = 200,
        reveal = { 'close' }
      },
      offsets = {
        {
          filetype = 'NvimTree',
          text = 'File Explorer',
          highlight = 'Directory',
          separator = true,
          text_align = 'left',
        },
        {
          filetype = 'alpha',
          text = nil,
        }
      },
      -- highlights = {
      --   background = {
      --     bg = 'transparent',
      --   },
      -- },
      always_show_bufferline = false,
      separator_style = 'slant',
      custom_areas = {
        right = function ()
          return {
            { text = string.format('%2d/%-2d', vim.api.nvim_win_get_number(0), #vim.api.nvim_list_wins()) }
          }
        end
      }
    }
  }
}
