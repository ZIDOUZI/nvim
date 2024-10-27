return {
  'folke/todo-comments.nvim',
  config = function()
    require('todo-comments').setup {}
    local map = vim.keymap.set
    map('n', '<leader>tl', ':TodoLocList<CR>')
    map('c', 'tl', 'TodoLocList<CR>')
  end
}
