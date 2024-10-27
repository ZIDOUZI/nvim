return {
  'stevearc/conform.nvim',
  cond = false,
  event = 'BufWritePre',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      javascript = { { 'prettierd', 'prettier' } }
    },
    format_on_save = {
      timeous_ms = 500,
      lsp_fallback = true,
    }
  }
}
