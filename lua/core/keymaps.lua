local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = ' '

map('i', 'jk', '<ESC>')
map('n', '<C-A>', 'ggVG')
map({ 'n', 'x' }, '<leader>p', '"0p')
map('n', '<leader>q', ':q<CR>')
map('n', '<leader>w', ':w<CR>')
map('n', '<leader>x', ':x<CR>')
map('n', 'j', [[v:count?'j':'gj']], { noremap = true, expr = true })
map('n', 'k', [[v:count?'k':'gk']], { noremap = true, expr = true })
map('v', 'J', ':m \'>+1<CR>gv=gv')
map('v', 'K', ':m \'<-2<CR>gv=gv')
map('n', '<C-J>', '9j')
map('n', '<C-K>', '9k')
map('n', '<leader>sv', '<C-w>v')
map('n', '<leader>sh', '<C-w>s')

map('n', '<leader>nh', ':nohl<CR>')
map('n', '<C-L>', ':bnext<CR>')
map('n', '<C-H>', ':bprevious<CR>')

-- bug of treesitter
-- map('c', 'wqa<CR>', 'wqa!<CR>')

---------    插件    ---------
-- Lazy https://github.com/folke/lazy.nvim#-usage
map('n', '<leader>ls', ':Lazy update<CR>')
map('n', '<leader>lz', ':Lazy<CR>')

map('i', '<C-Z>', '<CMD>undo<CR>')
map('i', '<C-X>', '<CMD>red<CR>')

map("i", "<C-n>", "<Plug>luasnip-next-choice")
map("s", "<C-n>", "<Plug>luasnip-next-choice")
map("i", "<C-p>", "<Plug>luasnip-prev-choice")
map("s", "<C-p>", "<Plug>luasnip-prev-choice")

-- map({ "v", "v" }, "gf", require('actions-preview').code_action)

