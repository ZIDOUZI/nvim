return {
  'nvim-tree/nvim-tree.lua',
  cond = function ()
    -- TODO: when use vscode, disable this and make `<leader>e` to vscode file panel, etc.
    return true
  end,
  init = function ()
    -- see https://github.com/nvim-tree/nvim-tree.lua#install
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  config = function()
    require('utils.natural_compare')
    require('nvim-tree').setup {
      filters = {
        custom = { '^.git$' },
      },
      actions = {
        open_file = { quit_on_open = true }
      },
      -- update_focused_file = {
      --   enable = true,
      --   update_cwd = true,
      -- },
      sort_by = function (nodes) -- TODO: sorter can't put folder at top. need fix
        table.sort(nodes, function (left, right)
          if (left.type == "file") ~= (right.type == "file") then
            return right.type == "file"
          end
          return left.name:lower():natural_compare(right.name:lower())
        end)
      end,
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          error = "󰅚",
          warning = "󰀪",
          info = "",
          hint = "󰌶",
        }
      },
      view = {
        float = {
          enable = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = math.floor(screen_w * 0.5)
            local window_h = math.floor(screen_h * 0.8)
            local center_x = (screen_w - window_w) / 2
            local center_y = ((vim.opt.lines:get() - window_h) / 2 - vim.opt.cmdheight:get())
            return {
              border = "rounded",
              relative = "editor",
              row = center_y,
              col = center_x,
              width = window_w,
              height = window_h,
            }
          end
        },
        width = function ()
          return math.floor(vim.opt.columns:get() * 0.5)
        end
      }
    }
    local view = require('nvim-tree.view')
    local api = require('nvim-tree.api')
    vim.keymap.set('n', '<leader>e', api.tree.toggle)
    local resize = vim.api.nvim_create_augroup("NvimTreeResize", { clear = true })
    vim.api.nvim_create_autocmd("VimResized", {
      group = resize,
      callback = function ()
        if view.is_visible() then
          view.close()
          api.tree.open()
        end
      end
    })
  end
}
