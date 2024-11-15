-- local function windows()
--   return string.format('%2d/%-2d', vim.api.nvim_win_get_number(0), #vim.api.nvim_list_wins())
-- end
--
-- local function keymap()
--   if vim.opt.iminsert:get() > 0 and vim.b.keymap_name then
--     return '⌨ ' .. vim.b.keymap_name
--   end
--   return ''
-- end

local format_lens = { unix = 1, dos = 2, mac = 1 }
-- local selection_symbols = { line = '󰦨', char = '󱌯' }
local selection_symbols = { line = 'L', char = 'C' }

local function locations()
  local row_start, col_start = vim.fn.line('v'), vim.fn.col('v')
  local row_end, col_end = vim.fn.line('.'), vim.fn.col('.')
  local row_off, col_off = math.abs(row_start - row_end) + 1, math.abs(col_start - col_end) + 1
  local mode = vim.fn.mode(true)
  local location = string.format('%3d:%-2d ', row_end, col_end)
  -- TODO: nvim and lua recognized utf8bmp3 as 3 chars, which is a mistake.
  if mode:match('') then -- ^V aka visual blocks, only show selected line count
    return location .. string.format('%2dx%-2d', row_off, col_off)
  elseif mode:match('v') and row_off == 1 then
    return location .. string.format('%2d%s', col_off, selection_symbols.char)
  elseif mode:match('V') or row_off ~= 1 then
    local start = row_start < row_end and row_start or row_end
    local end_ = row_start > row_end and row_start or row_end
    local lb_len = format_lens[vim.bo.fileformat]
    local total = mode:match('v') and (row_start > row_end and col_start - col_end or col_end - col_start) or -1
    local lines = vim.api.nvim_buf_get_lines(0, start - 1, end_ - (mode:match('v') and 1 or 0), false)
    for _, s in ipairs(lines) do
      total = total + #s + lb_len
    end
    return location .. string.format('%2d%s %3d%s', row_off, selection_symbols.line, total + 1, selection_symbols.char)
  else
    return location
  end
end

local format_symbol = { unix = 'LF', dos = 'CRLF', mac = 'CR' }

return {
  'nvim-lualine/lualine.nvim',
  -- cond = false,
  event = "VeryLazy",
  opts = {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {
        'alpha'
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename', 'filesize' },
      lualine_x = {
        'encoding',
        { 'fileformat', icons_enabled = true, symbols = format_symbol },
        'filetype'
      },
      lualine_y = { 'progress' },
      lualine_z = { locations },
    },
    -- tabline = {
    --   lualine_a = { 'buffers' },
    --   lualine_b = {},
    --   lualine_c = {},
    --   lualine_x = { keymap },
    --   lualine_y = { 'tabs' },
    --   lualine_z = { windows },
    -- },
    -- tabline = {
    --   lualine_a = { 'tabs' },
    --   lualine_b = {  },
    -- },
    extensions = {
      'nvim-tree',
      'lazy',
      'mason',
      'trouble'
    }
  }
}
