-- llvm clang: https://github.com/mstorsjo/llvm-mingw/releases
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.install').prefer_git = false
    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.lean4 = {
      install_info = {
        url = "https://github.com/Julian/tree-sitter-lean", -- local path or git repo
        files = {"src/parser.c", "src/scanner.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
        -- optional entries:
        branch = "main", -- default branch in case of git repo if different from master
        generate_requires_npm = false, -- if stand-alone parser without npm dependencies
        requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
      },
      filetype = "lean", -- if filetype does not match the parser name
    }

    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'c',
        'lua',
        'kotlin',
        'javascript',
        'java',
        'python',
        'bash',
        'go',

        'css',
        'vim',
        'vimdoc',
        'regex',
        -- 'help',
        'lean4',
        -- 'nginx', -- not support yet
        'matlab',
        'latex',

        'markdown_inline',
        'markdown',
        'json',
        'yaml',
        'toml',
        'html',
      },
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection    = "<CR>",
          node_incremental  = "<CR>",
          node_decremental  = "<BS>",
          scope_incremental = "<TAB>",
        },
      },
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
      }
    }
  end
}
