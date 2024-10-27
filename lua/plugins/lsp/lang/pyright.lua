return {
  python = {
    analysis = {
      autoSearchPaths = true,
      diagnosticMode = "openFilesOnly",
      useLibraryCodeForTypes = true,
    }
  },
  capabilities = require("cmp_nvim_lsp").default_capabilities()
}
