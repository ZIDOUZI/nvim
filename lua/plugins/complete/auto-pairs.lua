return {
  'windwp/nvim-autopairs',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local npairs = require('nvim-autopairs')
    npairs.setup {
      disable_filetype = { 'TelescopePrompt', 'vim', 'NvimTree' },
      check_ts = true,
      enable_check_bracket_line = true,
      ignored_next_char = "[%w%.]" -- will ignore alphanumeric and `.`
    }

    local Rule = require('nvim-autopairs.rule')
    local cond = require('nvim-autopairs.conds')

    -- auto enlarge brackets
    local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
    npairs.add_rules {
      -- Rule for a pair with left-side ' ' and right side ' '
      Rule(' ', ' ')
        -- Pair will only occur if the conditional function returns true
        :with_pair(function(opts)
          -- We are checking if we are inserting a space in (), [], or {}
          local pair = opts.line:sub(opts.col - 1, opts.col)
          return vim.tbl_contains({
            brackets[1][1] .. brackets[1][2],
            brackets[2][1] .. brackets[2][2],
            brackets[3][1] .. brackets[3][2]
          }, pair)
        end)
        :with_move(cond.none())
        :with_cr(cond.none())
        -- We only want to delete the pair of spaces when the cursor is as such: ( | )
        :with_del(function(opts)
          local col = vim.api.nvim_win_get_cursor(0)[2]
          local context = opts.line:sub(col - 1, col + 2)
          return vim.tbl_contains({
            brackets[1][1] .. '  ' .. brackets[1][2],
            brackets[2][1] .. '  ' .. brackets[2][2],
            brackets[3][1] .. '  ' .. brackets[3][2]
          }, context)
        end)
    }
    -- For each pair of brackets we will add another rule
    for _, bracket in pairs(brackets) do
      npairs.add_rules {
        -- Each of these rules is for a pair with left-side '( ' and right-side ' )' for each bracket type
        Rule(bracket[1] .. ' ', ' ' .. bracket[2])
          :with_pair(cond.none())
          :with_move(function(opts) return opts.char == bracket[2] end)
          :with_del(cond.none())
          :use_key(bracket[2])
          -- Removes the trailing whitespace that can occur without this
          :replace_map_cr(function(_) return '<C-c>2xi<CR><C-c>O' end)
      }
    end

    -- move past commas and semicolons
    for _, punct in pairs { ",", ";" } do
      npairs.add_rules {
        Rule("", punct)
          :with_move(function(opts) return opts.char == punct end)
          :with_pair(function() return false end)
          :with_del(function() return false end)
          :with_cr(function() return false end)
          :use_key(punct)
      }
    end

    -- tex
    npairs.add_rule(Rule("$$", "$$", { "tex", 'markdown' }))
    npairs.add_rule(Rule("$", "$", { "tex", "latex", 'makrdown' })
      -- don't add a pair if the next character is %
      -- :with_pair(cond.not_after_regex("%%"))
      -- don't add a pair if  the previous character is xxx
      -- :with_pair(cond.not_before_regex("xxx", 3))
      -- don't move right when repeat character
      -- :with_move(cond.none())
      -- don't delete if the next character is xx
      -- :with_del(cond.not_after_regex("xx"))
      -- disable adding a newline when you press <cr>
      -- :with_cr(cond.none())
    )
    -- disable for .vim files, but it work for another filetypes
    -- Rule("a", "a", "-vim")
  end
}
