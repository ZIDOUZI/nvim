print('Hello Neovim! Happy with you!')

-- due to nvim-tree, see https://github.com/nvim-tree/nvim-tree.lua#install
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- link system clipboard

require('core.options')
require('core.keymaps')
require('core.plugins')


