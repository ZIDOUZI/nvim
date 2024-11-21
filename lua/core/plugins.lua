local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

local plugins = {}
local plugins_path = 'plugins'
local abs_plugins_path = vim.fn.stdpath('config') .. '/lua/' .. plugins_path .. '/'
for _, item in ipairs(vim.fn.readdir(abs_plugins_path)) do
  if vim.fn.isdirectory(item) then
    table.insert(plugins, { import = plugins_path .. '.' .. item })
  end
end

require('lazy').setup {
  spec = plugins,
  defaults = {
    cond = vim.g.vscode == nil
  },
  ui = {
    border = "rounded",
    pills = true,
  },
  lockfile = vim.fn.stdpath('data') .. '/lazy.lock',
  checker = {
    enable = true
  }
}
