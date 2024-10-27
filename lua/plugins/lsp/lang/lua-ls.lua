return {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        diagnostics = {
          globals = { "vim" }
        },
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT'
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
            -- "${3rd}/luv/library"
            -- "${3rd}/busted/library",
          }
          -- or pull in all of 'runtimepath'. Note: this is a lot slower
          -- library = vim.api.nvim_get_runtime_file("", true)
        },
        completion = {
          callSnippet = "Replace",
        },
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end

    local map = vim.keymap.set
    local buf = vim.lsp.buf
    map('n', 'K', buf.hover)
    return true
  end,
  settings = {
    Lua = {}
  },
  capabilities = require("cmp_nvim_lsp").default_capabilities()
}
