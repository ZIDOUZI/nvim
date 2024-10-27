return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-frecency.nvim', 'nvim-telescope/telescope-ui-select.nvim' },
  config = function()
    local builtin = require('telescope.builtin')
    local map = vim.keymap.set
    map('n', '<leader>fd', builtin.find_files)
    map('n', '<leader>fk', builtin.keymaps)
    map('n', '<leader>fr', '<CMD>Telescope frecency<CR>')
    map('n', '<leader>fw', builtin.current_buffer_fuzzy_find)
    map('n', '<leader>fb', builtin.buffers)
    map('n', '<leader>fg', builtin.git_status)
    map('n', '<leader>ft', builtin.live_grep)
    map('n', '<leader>fz', builtin.spell_suggest)
    map('n', '<leader>fn', '<CMD>Telescope notify<CR>')
    map('n', 'gr', builtin.lsp_references)

    local telescope = require('telescope')
    telescope.setup {
      extensions = {
        frecency = {
          show_scores = true,
          -- default_workspace = 'conf',
          workspaces = {
            conf = vim.fn.stdpath('config'),
            note = 'D:/Dou/Documents/笔记'
          }
        },
        ['ui-select'] = {
          require('telescope.themes').get_dropdown {

          }
        }
      },
      pickers = {
        find_files = { hideden = true },
      },
      defaults = {
        file_ignore_patterns = {
          'lazy-lock.json',
        },
        path_display = { 'smart' },
      }
    }
    telescope.load_extension('frecency')
    telescope.load_extension('ui-select')
    telescope.load_extension('noice')
  end
}
