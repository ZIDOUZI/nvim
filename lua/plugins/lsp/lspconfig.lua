return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'folke/neodev.nvim',
      opts = {
        lspconfig = true,
        override = function(_, library)
          library.enabled = true
          library.plugins = true
          library.types = true
        end,
      }
    },
    'lukas-reineke/lsp-format.nvim',
    'b0o/schemastore.nvim'
  },
  config = function()
    local lspconfig = require('lspconfig')
    require('lsp-format').setup {}
    lspconfig.gopls.setup { on_attatch = require('lsp-format').on_attatch }
    -- lspconfig.marksman.setup(require('plugins.lsp.lang.marksman'))
    -- lspconfig.quick_lint_js.setup()
    lspconfig.lua_ls.setup(require('plugins.lsp.lang.lua-ls'))
    lspconfig.pyright.setup(require('plugins.lsp.lang.pyright'))
    -- lspconfig.leanls.setup() -- already set by lean.nvim
    lspconfig.jsonls.setup(require('plugins.lsp.lang.json'))
    lspconfig.yamlls.setup(require('plugins.lsp.lang.yaml'))
    -- lspconfig.taplo.setup() -- toml

    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        local opts = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = 'rounded',
          source = 'always',
          prefix = ' ',
          scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
      end
    })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local map = vim.keymap.set
        local opts = { buffer = ev.buf }
        map('n', 'K', vim.lsp.buf.hover, opts)
        map('n', 'gD', vim.lsp.buf.declaration, opts)
        map('n', 'gd', vim.lsp.buf.definition, opts)
        map('n', 'gi', vim.lsp.buf.implementation, opts)
        map('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        map('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        map('n', '<space>D', vim.lsp.buf.type_definition, opts)
        map('n', '<space>rn', vim.lsp.buf.rename, opts)
        map({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        map('n', 'gr', vim.lsp.buf.references, opts)
        map('n', '<space>f', function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end
    })
  end,
}
