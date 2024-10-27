return {
  'williamboman/mason-lspconfig.nvim',
  dependencies = {
    {
      'williamboman/mason.nvim',
      opts = {
        ui = {
          border = 'single',
          icnos = {
            package_installed = '✓',
            package_pending = '→',
            package_uninstalled = '✗'
          }
        }
      }
    },
    'neovim/nvim-lspconfig'
  },
  opts = {
    ensure_installed = {
      -- 'clangd', -- 'cpplint',
      'lua_ls', -- 'luacheck', 'luaformat',
      'kotlin_language_server', -- 'kotlin-debug_adapter', 'ktlint',
      -- 'powershell_es',
      -- 'quick_lint_js',
      -- 'java_language_server', -- java required.
      -- 'pyre', -- 'isort',
      -- 'bashls', -- 'shellharden', --npm required.
      -- 'gopls', -- 'go-debug-adapter', 'golangci-lint', 'gofumpt',

      -- 'cssls', -- 'stylelint', -- npm required.
      -- 'vimls', -- npm required
      -- 'matlab_ls', -- npm required
      -- 'nginx_language_server',
      -- 'ltex', -- 'vale', 'latexindent',

      'marksman', -- 'mdformat',
      -- 'jsonls', -- 'jsonlint', 'fixjson', -- npm required
      -- 'yamlls', -- 'yamllint', 'yamlfmt', --npm required
      'taplo',
      -- 'html', -- 'markuplint', 'htmlbeautifier' -- npm required
    }
  },
  init = function ()
    -- vim.api.nvim_command [[LspStart]]

    local signs = {
      Error = "󰅚",
      Warn = "󰀪",
      Info = "",
      Question = "",
      Hint = "󰌶",
    }

    for name, icon in pairs(signs) do
      local hl = "DiagnosticSign"..name
      vim.fn.sign_define(hl, { text = icon, texthl = hl })
    end

    vim.diagnostic.config {
      underline = true,
      severity_sort = true,
      float = {
        focusable = false,
        style = 'minimal',
        border = 'rounded',
        source = 'always',
      }
    }
  end
}
