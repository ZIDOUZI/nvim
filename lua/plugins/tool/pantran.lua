return {
  "potamides/pantran.nvim",
  config = function ()
    local pantran = require("pantran")
    pantran.setup {
      default_engine = "google"
    }
    local opts = { noremap = true, silent = true, expr = true }
    vim.keymap.set("n", "<C-Y>", pantran.motion_translate, opts)
  end
}
