local o = vim.opt
local g = vim.g
local cmd = vim.cmd

-- 行号
o.relativenumber = true
o.number = true

-- 缩进
-- opt.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.autoindent = true

-- 防止折叠行
o.wrap = false

-- 光标行
o.scrolloff = 5
o.sidescrolloff = 5
-- 高亮行
-- o.cursorline = true
-- 右侧参考线
-- o.colorcolumn = '80,160'

-- 启用鼠标
o.mouse:append('a')

-- 系统剪贴板
o.clipboard:append('unnamedplus')

-- 默认split方向
-- opt.splitright = true
-- opt.splitbelow = true

-- 搜索
o.ignorecase = true
o.smartcase = true

-- 外观
o.termguicolors = true
o.signcolumn = 'yes'
o.guicursor = 'a:ver20,v:block'

-- ultisnips snippets
-- g.UltiSnipsExpandTrigger = '<tab>'
-- g.UltiSnipsJumpForwardTrigger = '<tab>'
-- g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
-- g.UltiSnipsEditSplit = 'vertical'
-- g.UltiSnipsSnippetDirectories = {'UltiSnips'}
-- g.UltiSnipsSnippetsDir = 'UltiSnips'

if jit.os:find('Windows') then
  o.path:append(',~/AppData/Local/nvim/**,D:/Dou/Documents/笔记/**')
  g.python3_host_prog = "C:/Users/Dou/AppData/Local/Programs/Python/Python310/python.exe"
end

cmd [[
  augroup markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
  augroup END
]]
