return {
  on_init = function()
    local map = vim.keymap.set
    local buf = vim.lsp.buf
    map('n', 'K', buf.hover)
    return true
  end,
}
