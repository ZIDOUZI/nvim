unpack = unpack or table.unpack
local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local compare_lsp_score = function(entry1, entry2)
  if entry1.completion_item.score and entry2.completion_item.score then
    return entry2.completion_item.score * entry2.score < entry1.completion_item.score * entry1.score
  else
    return entry2.score < entry1.score
  end
end

return {
  'hrsh7th/nvim-cmp',
  event = "InsertEnter",
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    {
      'saadparwaiz1/cmp_luasnip',
      dependencies = { "L3MON4D3/LuaSnip" }
    },
    'hrsh7th/cmp-path',
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    'hrsh7th/cmp-cmdline',
    'onsails/lspkind.nvim',
    'zbirenbaum/copilot-cmp',
    'windwp/nvim-autopairs',
  },
  config = function()
    local cmp = require('cmp')
    local ls = require('luasnip')
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')

    cmp.setup {
      window = {
        completion = {
          winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
          col_offset = -3,
          side_padding = 0,
          border = 'rounded',
          scrollbar = true,
        },
        documentation = {
          winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
          border = 'rounded',
          scrollbar = true,
        },
      },
      snippet = {
        expand = function(args)
          ls.lsp_expand(args.body)
        end,
      },
      mapping = {
        ['<Tab>']   = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif ls.expand_or_jumpable() then
            ls.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif ls.jumpable(-1) then
            ls.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<C-b>']   = cmp.mapping.scroll_docs(-4),
        ['<C-f>']   = cmp.mapping.scroll_docs(4),
        ['<C-e>']   = cmp.mapping.abort(),
        ['<CR>']    = cmp.mapping.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace },
        ['<C-L>']   = cmp.mapping(function(fallback)
          if ls.choice_active() then
            ls.change_choice(1)
          else
            fallback()
          end
        end),
        ['<C-H>']   = cmp.mapping(function(fallback)
          if ls.choice_active() then
            ls.change_choice(-1)
          else
            fallback()
          end
        end),
      },
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
          local kind =
              require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. (strings[1] or "") .. " "
          kind.menu = "    (" .. (strings[2] or "") .. ")"

          return kind
        end,
      },
      sources = cmp.config.sources {
        { name = "nvim_lsp",  max_item_count = 350 },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "path" },
        { name = "treesitter" },
        { name = "spell" },
        { name = "buffer" },
        { name = "copilot" },
      }
    }

    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    cmp.config.compare.lsp_scores = compare_lsp_score
    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = 'buffer' } },
    })
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources {
        { name = 'path' },
        { name = 'cmdline' },
      }
    })
  end
}
