require('utils.string-ext')
local unpack = unpack or table.unpack

local ls = require('luasnip')

local extra = require('luasnip.extras')

local types = require("luasnip.util.types")

local condition = require('luasnip.extras.expand_conditions')

local True = function() return true end
local False = function() return false end

local M = {
  reg_start_index = 1,
  S = ls.snippet,
  s = ls.snippet_node,
  t = ls.text_node,
  i = ls.insert_node,
  f = ls.function_node,
  c = ls.choice_node,
  d = ls.dynamic_node,
  l = extra.lambda,
  r = extra.rep,
  p = extra.partial,
  m = extra.match,
  n = extra.nonempty,
  dl = extra.dynamic_lambda,
  log = ls.log.new('Resolver'),
  tex = (function()
    local latex = require('utils.latex')
    return {
      in_mathzone = latex.in_mathzone,
      in_comment = latex.in_comment,
      in_text = function() return not latex.in_mathzone() and not latex.in_comment() end
    }
  end)(),
  split = string.split,
  pipe = function(...)
    return function(...)
      for _, f in ipairs({ ... }) do
        if f(...) then return true end
      end
      return false
    end
  end,
  backslash = function(line_to_cursor)
    return not line_to_cursor:find("\\%a+$", - #line_to_cursor)
  end
}

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function is_chinese()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  return vim.getline('.')[col('.') - 3]:match('[%u4e00-%u9fa5]')
end

local conditions = {
  m = M.tex.in_mathzone,
  t = M.tex.in_text,
  mb = M.pipe(M.tex.in_mathzone, condition.line_begin),
  tb = M.pipe(M.tex.in_text, condition.line_begin),
}

local rep_patterns = {
  '%$%d+',       -- InsertNode
  '%${%d+}',     -- InsertNode
  '%${%d+:.-}',  -- InsertNode with defualt value
  '%${%d+=%d+}', -- DynamicNode with a InsertNode.
  '%${%d+|.-|}', -- ChoiceNode
  '%[%[%d+]]',  -- FunctionNode, used for regex
}

local I = function(idx, tbl, text)
  if tbl[idx] == nil then
    tbl[idx] = tbl.count + 1
    return M.i(idx, text)
  else
    return M.r(idx)
    -- return D(tbl[idx], function(args) return i(1, args[1]) end)
    -- tbl.diff = tbl.diff + 1
    -- return M.f(function(args) return args[1][1] end, tbl[idx])
  end
end

local rep_func = {
  function(anchor, tbl) return I(tonumber(anchor:sub(2)), tbl) end,
  function(anchor, tbl) return I(tonumber(anchor:sub(3, -2)), tbl) end,
  function(anchor, tbl)
    local idx = anchor:find(':')
    return I(tonumber(anchor:sub(3, idx - 1)), tbl, anchor:sub(idx + 1, -2))
  end,
  function(anchor, _)
    local idx = anchor:find('=')
    return M.d(
      tonumber(anchor:sub(3, idx - 1)),
      function(args) return M.s(nil, { M.i(1, args[1]) }) end,
      tonumber(anchor:sub(idx + 1, -2))
    )
  end,
  function(anchor, tbl)
    M.log.info('Receive ChoiceNode: %q', anchor)
    local pos = anchor:find('|')
    local idx = tonumber(anchor:sub(3, pos - 1))
    local n = anchor:sub(pos + 1, -3):split(',')
    for j = 1, #n do n[j] = M.parse_snippet(n[j], tbl.rep) end
    return M.c(idx, n)
  end,
  function(anchor)
    return M.f(function(_, snip)
      return snip.captures[tonumber(anchor:sub(3, -3)) + M.reg_start_index]
    end)
  end,
}

---comment
---@param trig string
---@param rep (string|table)
---@param opt (string|nil)
---@param ctx (string|number|table|nil)
---@param ... (function|string|number)
---@return luasnip.snippet
function M.parse(trig, rep, opt, ctx, ...)
  local context, opts = M.parse_options(trig, opt, ctx, ...)
  M.log.info('Parse Snippet: %q', context.trig)
  if type(rep) == 'table' then
    return M.S(context, rep, opts)
  end
  return M.S(context, M.parse_replace(rep, context.regTrig), opts)
  -- return ls.parser.parse_snippet(context, rep, opts)
end

---comment
---@param trig string
---@param opt (string|nil)
---@param ctx (table|number|string|nil)
---@param ... (function|string|number)
---@return table
---@return table
function M.parse_options(trig, opt, ctx, ...)
  if type(ctx) == "number" then
    ctx = { priority = ctx }
  elseif type(ctx) == "string" then
    ctx = { name = ctx }
  else
    ctx = ctx or {}
  end
  ctx.trig = trig

  local opts = {}
  for _, v in pairs { ... } do
    if type(v) == 'function' then
      opts.callbacks = v
    elseif type(v) == 'string' then
      if not ctx.name then ctx.name = v elseif not ctx.dscr then ctx.dscr = v end
    elseif type(v) == 'number' then
      ctx.priority = v
    elseif type(v) == 'table' then
      ctx.dscr = v
    end
  end
  if ctx.name and not ctx.dscr then ctx.dscr = { ctx.name, '**More Description needed.**' } end

  if opt then
    if opt:find('m') then
      if opt:find('b') then
        opts.condition = conditions.mb
      else
        opts.condition = conditions.m
      end
    elseif opt:find('t') then
      if opt:find('b') then
        opts.condition = conditions.tb
      else
        opts.condition = conditions.t
      end
    end

    if opt:find('A') then
      ctx.snippetType = 'autosnippet'
    end
    if opt:find('H') then
      opts.show_condition = ctx.snippetType and False or True
    elseif opt:find('h') then
      opts.show_condition = False
    elseif opt:find('s') then
      opts.show_condition = True
    end

    ctx.regTrig = opt:find('r') or opt:find('p')
    ctx.wordTrig = opt:find('w')
    ctx.trigEngine = opt:find('r') and 'ecma'
    -- ctx.hidden = opt:find('h') or opt:find('H')
  end
  return ctx, opts
end

---comments
---@param rep string
---@param is_reg (boolean|nil)
---@return table
function M.parse_replace(rep, is_reg)
  local result = {}
  local indicies = string.find_indicies(rep, rep_patterns)

  -- register
  local opts = { count = 0, diff = 0, rep = is_reg }
  local current = 1
  for _, info in pairs(indicies) do
    local _start, _end, _index = unpack(info)
    if not is_reg and _index == 6 then
      M.log.warn('Expected Regex Replacement at: %d~%d in rep: %q %q', _start, _end, is_reg, rep)
      goto continue
    end
    if _start < current then
      M.log.info('Duplicate Index: %d~%d in rep: %q', _start, _end, rep)
      goto continue
    end
    if _start > current then
      local res = rep:sub(current, _start - 1):split('\n')
      table.insert(result, M.t(res))
      opts.count = opts.count + 1
    end
    table.insert(result, rep_func[_index](rep:sub(_start, _end), opts))
    opts.count = opts.count + 1
    current = _end + 1
    ::continue::
  end
  table.insert(result, M.t(rep:sub(current):split('\n')))
  opts.count = opts.count + 1

  return result
end

function M.parse_snippet(rep, is_reg)
  M.log.info('Parse Snippet: %q', rep)
  local result = M.parse_replace(rep, is_reg)
  if #result == 1 then
    return result[1]
  end
  return M.s(nil, result)
end

---comment
---@param input string
---@param enter (string|nil)
---@return string
function M.trim(input, enter)
  local _s, _e = input:find('^%s*')
  enter = enter or '\n'
  if _s and _e then
    local r = input:sub(_e + 1):gsub(enter .. input:sub(_s, _e), enter)
    return r
  end
  return input
end

return M
