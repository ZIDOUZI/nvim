local M = require('utils.resolver')
-- 希腊字母
local GREEK =
    'alpha|beta|Gamma|varGamma|gamma|Delta|varDelta|delta|epsilon|varepsilon|zeta|eta|theta|vartheta|Theta|varTheta|'
    .. 'iota|kappa|varkappa|lambda|Lambda|varLambda|mu|nu|xi|Xi|varXi|pi|varpi|Pi|varPi|rho|varrho|sigma|varsigma|'
    .. 'Sigma|varSigma|tau|upsilon|Upsilon|varUpsilon|phi|varphi|Phi|varPhi|chi|psi|Psi|varPsi|omega|Omega|varOmega|'
    .. 'backepsilon'
-- 希伯来字母
local HEBREW = 'aleph|beth|gimel|daleth'
-- 可变大小符号
local BIG_SYMBOL =
    'sum|prod|int|oint|iiint|iint|coprod|bigcap|bigcup|bigwedge|bigvee|bigodot|bigotimes|bigoplus|biguplus|'
    .. 'lim|liminf|limsup|max|min|sup|inf|Pr|det|gcd'
-- 常规函数名
local FUNCTIONS = 'sin|cos|tan|cot|csc|sec|arcsin|arccos|arctan|arccot|arccsc|arcsec|'
    .. 'sinh|cosh|tanh|coth|csch|sech|arcsinh|arccosh|arctanh|arccoth|arcsch|arcsech|'
    .. 'ln|log|exp|dim|ker|hom|arg|deg'
-- 二元运算符
local BINARY =
    'ast|star|cdot|circ|bullet|bigcirc|diamond|times|div|centerdot|circledast|circledcirc|circleddash|dotplus|'
    .. 'divideontimes|pm|mp|amalg|odot|ominus|oplus|oslash|otimes|wr|Box|boxplus|boxminus|boxtimes|boxdot|square|cap|cup|'
    .. 'uplus|sqcap|sqcup|vee|wedge|dagger|ddagger|barwedge|curlywedge|Cap|bot|intercal|doublebarwedge|lhd|rhd|triangleleft|'
    ..
    'triangleright|unlhd|unrhd|bigtriangledown|bigtriangleup|setminus|veebar|curlyvee|Cup|top|rightthreetimes|leftthreetimes|'
    ..
    'equiv|cong|ne|neq|sim|simeq|approx|asymp|doteq|propto|models|le|leq|prec|preceq|ll|subset|subseteq|sqsubset|sqsubseteq|'
    .. 'dashv|in|ge|geq|succ|succeq|gg|supset|supseteq|sqsupset|sqsupseteq|vdash|ni|prep|mid|parallel|bowtie|Join|letimes|'
    ..
    'rtimes|smile|frown|notin|approxeq|thicksim|backsim|triangleq|circeq|bumpeq|Bumpeq|doteqdot|thickapprox|fallingdotseq|'
    .. 'risingdotseq|varpropto|therefore|because|eqcirc|leqq|leqslant|lessapprox|lll|lessdot|lesssim|eqslantless|precsim|'
    .. 'precapprox|Subset|subseteqq|preccurlyeq|'
local SYMBOL =
    'hbar|ell|nabla|infty|dots|leftrightarrow|mapsto|setminus|mid|cap|cup|land|lor|subseteq|subset|implies|impliedby|iff|exists'
    .. '|equiv|square|neq|geq|leq|gg|ll|sim|simeq|approx|propto|cdot|oplus|otimes|times|star|perp|det|exp|ln|log|partial'
local SHORT_SYMBOL = 'pm|to|mp'
-- local KEYWORDS = GREEK + '|' + HEBREW + '|' + SYMBOL + '|' + SHORT_SYMBOL

---comment
---@param trig string
---@param rep string|table
---@param opt (string|nil)
---@param ctx (string|number|table|nil)
---@param ... (function|string|number)
---@return luasnip.snippet
local resolve = function(trig, rep, opt, ctx, ...)
  if type(rep) == 'table' then
    return M.parse(trig, rep, opt, ctx, ...)
  end
  rep = rep:gsub('${GREEK}', GREEK):gsub('${SYMBOL}', SYMBOL):gsub('${HEBREW}', HEBREW):gsub('${SHORT_SYMBOL}',
    SHORT_SYMBOL)
  -- :gsub('${KEYWORDS}', KEYWORDS):gsub('${BINARY}', BINARY):gsub('${FUNCTIONS}', FUNCTIONS):gsub('${BIG_SYMBOL}', BIG_SYMBOL)
  return M.parse(trig, rep, opt, ctx, ...)
end


return {
  -- enter math mode
  resolve('$', '$$1$', 'mtA'),
  resolve([[*]], '*$1*', 'mtA'),

  -- special cases
  -- resolve('\\neq?(%d)', '\\neq[[0]]', 'rtA'),
  resolve('latex', '\\LaTeX', 'mA'),
  resolve('!proof', '> [!proof]- 证明\n> ', 'tA'),
  resolve('!notice', '> [!notice]- 注意\n> ', 'tA'),
  resolve('!%a ', '> [![[0]]]- {1}\n> {2}', 'ptA'),
  resolve('!([a-z]+) ', '> [![[0]]] ', 'rtA'),
  resolve('!([a-z]+)-', '> [![[0]]]- ', 'rtA'),

  -- Chinese Punctuation
  resolve(', ', '，', 'tA'),
  resolve('? ', '？', 'tA'),
  resolve('(%d+%. )', '[[0]]', 'rtA'),
  resolve('. ', '。', 'tA'),
  resolve('\" ', '“$1”', 'tA'),
  resolve('\\ ', '、', 'tA'),
  resolve('(%[\\^%d+\\]: )', '[[0]]', 'rtA'),
  resolve(': ', '：', 'tA'),
  resolve('() ', '（$1）', 'tA'),
  resolve('%(([^)]+)%) ', '（[[0]]）', 'rtA'),
  resolve('; ', '；', 'tA'),
  resolve('--', '—', 'tA'),

  -- resolve('(?<![a-zA-Z])([a-zA-Z])', '$[[0]]$', 'rt', { dscr = 'single word' }),
  -- resolve('%[([A-Za-z0-9,+-=]+)\\]', '$[[[0]]]$', 'rt', { dscr = 'interval' }),
  -- resolve('([A-Za-z])([0-9])', '$[[0]]_[[1]]$', 'rt', { dscr = 'word or with subscript' }),


  resolve('R', '$\\mathcal{R}$', 't', 'Riemann Integral Symbol'),
  resolve('L', '$\\mathcal{L}$', 't', 'Lebesgue Integral Symbol'),

  -- display
  resolve('dis', '%displaystyle', 'mA'),


  -- Math mode
  resolve('beg', '\\begin{$1}$2\\end{$1}', 'mA'),
  resolve('tag_(%d)', '\\tag{[[0]]$1}', 'rm'),
  resolve('tag_{(%d+)}', '\\tag{[[0]]}', 'rm'),
  resolve('tag([^\\\\{}_ ]+)', '\\tag{[[0]]}', 'rm'),


  -- blank
  resolve('-3sp', '\\!', 'mA'),
  resolve('-2sp', '\\:\\!\\!', 'mA'),
  resolve('-1sp', '\\;\\!\\!', 'mA'),
  resolve('1sp', '\\:\\!', 'mA'),
  resolve('2sp', '\\;\\!', 'mA'),
  resolve('3sp', '\\,', 'mA'),
  resolve('4sp', '\\:', 'mA'),
  resolve('5sp', '\\;', 'mA'),
  resolve('6sp', '\\,\\,', 'mA'),
  resolve('7sp', '\\:\\,', 'mA'),
  resolve('8sp', '\\:\\:', 'mA'),
  resolve('9sp', '\\;\\:', 'mA'),
  resolve('10sp', '\\;\\;', 'mA'),
  resolve('11sp', '\\;\\,\\,', 'mA'),
  resolve('12sp', '\\;\\:\\,', 'mA'),
  resolve('13sp', '\\;\\:\\:', 'mA'),
  resolve('14sp', '\\;\\:\\:', 'mA'),
  resolve('15sp', '\\;\\;\\;', 'mA'),
  resolve('16sp', '\\;\\;\\,\\,', 'mA'),
  resolve('17sp', '\\;\\;\\:\\,', 'mA'),
  resolve('18sp', '\\quad', 'mA'),
  resolve('1em', '\\quad', 'mA'),
  resolve('2em', '\\qquad', 'mA'),
  resolve('em', '\\hspace{$1em}$1', 'mA'),
  -- resolve('ex', '\\vspace{$1ex}$1', 'mA'),
  resolve('pt', '\\phantom{$1}$1', 'mA'),


  -- Dashes
  resolve('--', '–', 'tA'),
  resolve('–-', '—', 'tA'),
  resolve('—-', '---', 'tA'),


  -- Greek letters
  resolve('@a', '\\alpha', 'mA'),
  resolve('@A', '\\alpha', 'mA'),
  resolve('@b', '\\beta', 'mA'),
  resolve('@B', '\\beta', 'mA'),
  resolve('@c', '\\chi', 'mA'),
  resolve('@C', '\\chi', 'mA'),
  resolve('@d', '\\delta', 'mA'),
  resolve('@D', '\\delta', 'mA'),
  resolve('@e', '\\epsilon', 'mA'),
  resolve('@E', '\\epsilon', 'mA'),
  resolve(':e', '\\varepsilon', 'mA'),
  resolve(':E', '\\varepsilon', 'mA'),
  resolve('@g', '\\gamma', 'mA'),
  resolve('@G', '\\Gamma', 'mA'),
  resolve('@k', '\\kappa', 'mA'),
  resolve('@K', '\\kappa', 'mA'),
  resolve('@l', '\\lambda', 'mA'),
  resolve('@L', '\\Lambda', 'mA'),
  resolve(':L', '\\varLambda', 'mA'),
  resolve('@m', '\\mu', 'mA'),
  resolve('@M', '\\mu', 'mA'),
  resolve('@n', '\\nu', 'mA'),
  resolve('@N', '\\nu', 'mA'),
  resolve('ome', '\\omega', 'mA'),
  resolve('@o', '\\omega', 'mA'),
  resolve('@O', '\\Omega', 'mA'),
  resolve(':O', '\\varOmega', 'mA'),
  resolve('@p', '\\phi', 'mA'),
  resolve('@P', '\\Phi', 'mA'),
  resolve(':p', '\\varphi', 'mA'),
  resolve(':P', '\\varPhi', 'mA'),
  resolve(';p', '\\psi', 'mA'),
  resolve(';P', '\\Psi', 'mA'),
  resolve('@r', '\\rho', 'mA'),
  resolve('@R', '\\rho', 'mA'),
  resolve('@s', '\\sigma', 'mA'),
  resolve('@S', '\\Sigma', 'mA'),
  resolve(':S', '\\varSigma', 'mA'),
  resolve('@t', '\\theta', 'mA'),
  resolve('@T', '\\Theta', 'mA'),
  resolve(':T', '\\varTheta', 'mA'),
  resolve('@x', '\\xi', 'mA'),
  resolve('@X', '\\Xi', 'mA'),
  resolve('@z', '\\zeta', 'mA'),
  resolve('@Z', '\\zeta', 'mA'),
  resolve(
    '([^\\\\])(${GREEK}|${SYMBOL}|arcsin|arccos|arctan|arccot|arccsc|arcsec|sin|cos|tan|cot|csc|sec|aleph|forall|atop|inf|sup)',
    '[[0]]\\[[1]]', 'pmA', { 'Add backslash before greek letters, functions and symbols' }),


  -- Insert space after greek letters and symbols, etc
  resolve('\\\\(${GREEK}|${SYMBOL}|${SHORT_SYMBOL}|in|to|forall)(%a)', '\\[[0]] [[1]]', 'pmA', { 'Add blank after symbols.' }),
  resolve('\\\\(${GREEK}|${SYMBOL}) sr', '\\[[0]]^2', 'pmA'),
  resolve('\\\\(${GREEK}|${SYMBOL}) cb', '\\[[0]]^3', 'pmA'),
  resolve('\\\\(${GREEK}|${SYMBOL}) rd', '\\[[0]]^{$1}', 'pmA'),
  resolve('\\\\(${GREEK}|${SYMBOL}) hat', '\\hat{\\[[0]]}', 'pmA'),
  resolve('\\\\(${GREEK}|${SYMBOL}) ave', '\\bar{\\[[0]]}', 'pmA'),
  resolve('\\\\(${GREEK}|${SYMBOL}) dot', '%dot{\\[[0]]}', 'pmA'),
  resolve('\\\\(${GREEK}|${SYMBOL})~', '\\tilde{\\[[0]]}', 'pmA'),
  resolve('\\\\(${GREEK}),%.', '\\mathbf{\\[[0]]}', 'pmA'),
  resolve('\\\\(${GREEK})%.,', '\\mathbf{\\[[0]]}', 'pmA'),


  -- Operations
  resolve('te', '\\text{$1}', 'm'),
  resolve('rm', '\\mathrm{$1}', 'mA'),
  resolve('bf', '\\mathbf{$1}', 'mA'),
  resolve('bi', '\\mathbfit{$1}', 'mA'),
  resolve('cal', '\\mathcal{$1}', 'mA'),
  resolve('scr', '\\mathscr{$1}', 'mA'),
  resolve('bb', '\\mathbb{$1}', 'mA'),
  resolve('fr', '\\mathfrak{$1}', 'mA'),
  resolve('sr', '^2', 'mA'),
  resolve('cb', '^3', 'mA'),
  resolve('rd', '^{$1}$1', 'mA'),
  resolve('_', '_{$1}$1', 'm'),
  resolve('sts', '_\\text{$1}', 'mA'),
  resolve('sq', '\\sqrt{$1}', 'mA'),
  resolve('/', '\\frac{$1}{$2}', 'mA'),
  resolve('ee', '\\mathrm{e}^{$1}', 'mA'),
  resolve('(%a),%.', '\\mathbf{[[0]]}', 'pmA'),
  resolve('(%a)%.,', '\\mathbf{[[0]]}', 'pmA'),
  -- resolve(
  --   '((?:(?:(?:[^\\\\](?:\\\\\\%)*|^)\\b)|%d)(?:[A-Za-z]+)|(?:${GREEK}|${HEBREW})|(?:\\\\math(?:bf|rm|bfit|cal){[A-Za-z]}))(%d)',
  --   '[[0]]_[[1]]', 'rmA', { dscr = 'Auto letter subscript' }),
  M.S(
    { trig = '(%a)(%d)', regTrig = true, snippetType = 'autosnippet' }, M.parse_replace('[[0]]_[[1]]', true), { condition = function (line)
      if not M.tex.in_mathzone() then
        return false
      end
      if line:find('\\('..FUNCTIONS..'|'..BINARY..')$', -#line) then
        return false
      end
      if line:find('\\%a+$') then
      end
      return true
    end }
  ),
  resolve('\\\\mathbf{(%a)}(%d)', '\\mathbf{[[0]]}_{[[1]]}', 'pmA'),
  resolve('(%a)_(%w%d)', '[[0]]_{[[1]]}', 'pmA'),
  resolve('\\hat{(%a)}(%d)', 'hat{[[0]]}_{[[1]]}', 'pmA'),
  resolve('([a-zA-Z])bar', '\\overline{[[0]]}', 'rmA'),
  resolve('([a-zA-Z])ave', '\\bar{[[0]]}', 'rmA'),
  resolve('([a-zA-Z])cord', '\\bar{\\bar{[[0]]}}', 'rmA'),
  resolve('([a-zA-Z])~', '\\tilde{[[0]]}', 'rmA', { priority = -5 }),
  resolve('([a-zA-Z])hat', '\\hat{[[0]]}', 'rmA'),
  resolve('([a-zA-Z])\"', '%ddot{[[0]]}', 'rmA'),
  resolve('([a-zA-Z])`', '%dot{[[0]]}', 'rmA'),
  resolve('([a-zA-Z])ker', '\\overset{\\circ}{[[0]]}', 'rmA'),
  resolve('conj', '^*', 'mA'),
  resolve('(?:[^\\\\]|^)bar', '\\overline{$1}', 'mA'),
  resolve('ave', '\\bar{$1}', 'mA'),
  resolve('hat', '\\hat{$1}', 'mA'),
  resolve('dot', '%dot{$1}', 'mA'),
  resolve('\\%(arcsin|arccos|arctan|arccot|arccsc|arcsec|sin|cos|tan|cot|csc|sec)([A-Za-gi-z])', '\\[[0]] [[1]]',
    'rmA'),                  -- Insert space after trig funcs. Skips letter "h" to allow sinh, cosh, etc.
  resolve('\\%(arcsinh|arccosh|arctanh|arccoth|arcsch|arcsech|sinh|cosh|tanh|coth|csch|sech)([A-Za-z])',
    '\\[[0]] [[1]]', 'rmA'), -- Insert space after trig funcs
  resolve('trace', '\\mathrm{Tr}', 'mA'),
  resolve('\\noto', '\\varnothing', 'mA'),
  resolve('!o', '\\varnothing', 'mA'),
  resolve('(?<!\\%)var', '\\mathrm{Var}', 'rmA'),
  resolve('cov', '\\mathrm{Cov}', 'mA'),


  -- Visual operations
  -- resolve('U', '\\underbrace{${VISUAL}}_{$1}', 'mA'),
  -- -- resolve('B', '\\underset{$1}{${VISUAL}}', 'mA'),
  -- resolve('B', '\\mathbfit{${VISUAL}}$1', 'mA'),
  -- resolve('C', '\\cancel{${VISUAL}}', 'mA'),
  -- resolve('K', '\\cancelto{$1}{${VISUAL}}', 'mA'),
  -- resolve('S', '\\sqrt{${VISUAL}}', 'mA'),
  -- resolve('E', '\\begin{$1}${VISUAL}\\\\$2\\end{$1}', 'mA'),
  -- resolve('O', '\\overset{$1}{${VISUAL}}', 'mA'),


  -- Symbols
  resolve('ooo', '\\infty', 'mA'),
  -- resolve('sum', '\\sum', 'mA'),
  resolve('sum', '${1|\\sum_,\\sum_{$1},\\sum_{${1:i=1}}^{${2:n}},\\sum\\limits_{${1:i=1}}^{${2:n}}|}', 'mA'),
  resolve('prod', '${1|\\prod_,\\prod_{$1},\\prod_{${1:i=1}}^{${2:n}},\\prod\\limits_{${1:i=1}}^{${2:n}}|}', 'mA'),
  -- resolve('sum', { M.c(1, {
  --   M.t('\\sum_'),
  --   M.s(nil, M.parse_replace('\\sum_{$1}')),
  --   M.s(nil, M.parse_replace('\\sum_{${1:i=1}}^{${2:n}}')),
  --   M.s(nil, M.parse_replace('\\sum\\limits_{${1:i=1}}^{${2:n}}')),
  -- }) }, 'mA'),
  -- resolve('prod', { M.c(1, {
  --   M.t('\\prod_'),
  --   M.t('\\prod_{$1}'),
  --   M.t('\\prod_{$1:i=1}^{$2:n}'),
  --   M.t('\\prod\\limits_{$1:i=1}^{$2:n}'),
  -- }) }, 'mA'),
  resolve('lim', '\\lim_{${0:n}\\to${1:\\infty}}$2', 'mA'),
  resolve('Ilim', '\\liminf_{${0:n}\\to\\infty}$1', 'mA'),
  resolve('ilim', '\\varliminf_{${0:n}\\to\\infty}$1', 'mA'),
  resolve('Slim', '\\limsup_{${0:n}\\to\\infty}$1', 'mA'),
  resolve('slim', '\\varlimsup_{${0:n}\\to\\infty}$1', 'mA'),
  resolve('max', '\\max', 'mA'),
  resolve('\\max_', '\\max_{$1}', 'mA'),
  resolve('min', '\\min', 'mA'),
  resolve('\\min_', '\\min_{$1}', 'mA'),
  resolve('pm', '\\pm', 'm'),
  resolve('+-', '\\pm', 'mA'),
  resolve('-+', '\\mp', 'mA'),
  resolve('-->', '\\rightrightarrows', 'mA'),
  resolve('<<-', '\\leftleftarrows', 'mA'),
  resolve('->', '\\to', 'mA'),
  resolve('<->', '\\leftrightarrow ', 'mA'),
  resolve('!>', '\\mapsto', 'mA'),
  resolve('inv', '^{-1}', 'mA'),
  resolve('\\\\\\', '\\setminus', 'mA'),
  resolve('||', '\\mid', 'mA'),
  resolve(';a', '\\cap', 'mA'),
  resolve(';u', '\\cup', 'mA'),
  resolve(';A', '\\bigcap', 'mA'),
  resolve(';U', '\\bigcup', 'mA'),
  resolve('\\%(big)?(c[au]p)\\^', '\\big[[1]]_{${0:i=1}}^${1:\\infty}$2', 'rmA'),
  resolve('\\%(big)?(c[au]p)_', '\\big[[1]]_{${0:\\alpha}\\in${1:\\varLambda}}$2', 'rmA'),
  resolve('inn', '\\in', 'mA'),
  resolve('=>', '\\implies', 'mA'),
  resolve('=<', '\\impliedby', 'mA'),
  resolve('iff', '\\iff', 'mA'),
  resolve('\\leqslant>', '\\iff', 'mA'),
  resolve('e\\xi st', '\\exists', 'mA', { priority = 1 }),
  resolve('===', '\\equiv', 'mA'),
  resolve('tr=', '\\triangleq', 'mA'),
  resolve('def', '\\overset{def}{=}', 'mA'),
  resolve('Sq', '\\square', 'mA'),
  resolve('!=', '\\ne', 'mA'),
  resolve('\\ne=', '\\not\\equiv ', 'mA'),
  resolve('>=', '\\geqslant', 'mA'),
  resolve('<=', '\\leqslant', 'mA'),
  resolve('>>', '\\gg', 'mA'),
  resolve('<<', '\\ll', 'mA'),
  resolve('~~', '\\sim', 'mA'),
  resolve('\\sim~', '\\approx', 'mA', { priority = 5 }),
  resolve('prop', '\\propto', 'mA'),
  resolve('nabl', '\\nabla', 'mA'),
  resolve('xx', '\\times', 'mA'),
  resolve('...', '%dots', 'mA'),
  resolve('(?<!\\^)\\*', '\\cdot', 'rmA'),
  resolve('\\cdot*', '\\cdots', 'mA', { priority = 10 }),
  resolve('::', '\\vdots', 'mA'),
  resolve('``', '%ddots', 'mA'),
  resolve('pal', '\\parallel', 'mA'),
  resolve('\\subset eq', '\\subseteq', 'mA'),
  resolve('\\supset eq', '\\supseteq', 'mA'),
  resolve('\\subset=', '\\subseteq', 'mA'),
  resolve('\\supset=', '\\supseteq', 'mA'),
  resolve('ae.', '\\;\\text{a.e.}\\;', 'mA'),
  resolve('ae.', '$\\text{a.e.}$', 'tA'),


  resolve('([A-Za-z]|${GREEK})([A-Za-z])\\2', '[[0]]_[[1]]', 'rmA', { priority = -10 }),
  resolve('([A-Za-z]|${GREEK})([A-Za-z])p', '[[0]]_{[[1]]+1}', 'rmA', { priority = -100 }),
  resolve('([A-Za-z]|${GREEK})ij', '[[0]]_{ij}', 'rmA', { priority = -50 }),
  resolve('\\xii', 'x_i', 'mA', { priority = 10 }),
  resolve('x_ii', '\\xi_i', 'mA'),
  resolve('\\pij', 'p_{ij}', 'mA', { priority = 10 }),


  resolve('mcal', '\\mathcal{$1}', 'mA'),
  resolve('ell', '\\ell', 'mA'),
  resolve('lll', '\\ell', 'mA'),
  resolve('LL', '\\mathcal{L}', 'mA'),
  resolve('HH', '\\mathcal{H}', 'mA'),
  resolve('CC', '\\mathbb{C}', 'mA'),
  resolve('RR', '\\mathbb{R}', 'mA'),
  resolve('ZZ', '\\mathbb{Z}', 'mA'),
  resolve('NN', '\\mathbb{N}', 'mA'),
  resolve('II', '\\mathbb{I}', 'mA'),
  resolve('PP', '\\mathbb{P}', 'mA'),
  resolve('QQ', '\\mathbb{Q}', 'mA'),
  resolve('\\mathbb{1}I', '\\hat{\\mathbb{1}}', 'mA'),
  resolve('AA', '\\mathcal{A}', 'mA'),
  resolve('BB', '\\mathbf{B}', 'mA'),
  resolve('EE', '\\mathbf{E}', 'mA'),


  -- Unit vectors
  resolve(':i', '\\mathbfit{i}', 'mA'),
  resolve(':j', '\\mathbfit{j}', 'mA'),
  resolve(':k', '\\mathbfit{k}', 'mA'),
  resolve(':x', '\\hat{\\mathbfit{x}}', 'mA'),
  resolve(':y', '\\hat{\\mathbfit{y}}', 'mA'),
  resolve(':z', '\\hat{\\mathbfit{z}}', 'mA'),



  -- Derivatives
  resolve('par', '\\frac{\\partial${0: y}}{\\partial ${1:x}} $2', 'rmA'),
  resolve('pa2', '\\frac{\\partial^2${0: y}}{\\partial ${1:x}^2} $2', 'rmA'),
  resolve('pa3', '\\frac{\\partial^3${0: y}}{\\partial ${1:x}^3} $2', 'rmA'),
  resolve('pa([A-Za-z])([A-Za-z])', '\\frac{\\partial [[0]]}{\\partial [[1]]}', 'rm'),
  resolve('pa([A-Za-z])([A-Za-z])([A-Za-z])', '\\frac{\\partial^2 [[0]]}{\\partial [[1]]\\partial [[3]]}', 'rm'),
  resolve('pa([A-Za-z])([A-Za-z])2', '\\frac{\\partial^2 [[0]]}{\\partial{[[1]]^2}}', 'rmA'),

  resolve('dd([A-Za-z])', '\\frac{\\mathrm{d}$1}{\\mathrm{d}[[0]]}', 'rm'),
  resolve('dd([A-Za-z])n', '\\frac{\\mathrm{d}^n$1}{\\mathrm{d}[[0]]^n}', 'rmA'),
  resolve('dd([A-Za-z])(%d)', '\\frac{\\mathrm{d}^{[[1]]}$1}{\\mathrm{d}[[0]]^[[1]]}', 'rmA'),
  resolve('(?<!\\w)d([A-Za-z])([A-Za-z])', '\\frac{\\mathrm{d}[[0]]}{\\mathrm{d}[[1]]}', 'rm', { priority = -10 }),
  resolve('d([A-Za-z])([A-Za-z])n', '\\frac{\\mathrm{d}^n[[0]]}{\\mathrm{d}[[1]]^n}', 'rm'),
  resolve('d([A-Za-z])([A-Za-z])(%d)', '\\frac{\\mathrm{d}^[[2]][[0]]}{\\mathrm{d}[[1]]^[[2]]}', 'rmA'),


  -- Integrals
  resolve('oinf', '\\int_{0}^{\\infty}$1\\,\\mathrm{d}${2:x}', 'mA'),
  resolve('\\infi', '\\int_{-\\infty}^{\\infty}$1\\,\\mathrm{d}${2:x}', 'mA'),
  resolve('dint', '\\int_{${1:0}}^{${2:\\infty}}$3\\,\\mathrm{d}${4:x}', 'mA'),
  resolve('oint', '\\oint', 'mA'),
  resolve('iiint', '\\iiint', 'mA'),
  resolve('iint', '\\iint', 'mA'),
  resolve('int', '\\int $1\\,\\mathrm{d}${2:x}', 'mA'),
  resolve('eint', '\\int_${1:E}$2\\,\\mathrm{d}${3:x}', 'mA'),
  resolve('lint', '\\int_{${1:[a,b]}}$2\\,\\mathrm{d}${3:x}', 'mA'),



  -- Physics
  resolve('kbt', 'k_BT', 'mA'),


  -- Quantum mechanics
  resolve('hba', '\\hbar', 'mA'),
  resolve('dag', '^{%dagger}', 'mA'),
  resolve('bra', '\\bra{$1}', 'mA'),
  resolve('ket', '\\ket{$1}', 'mA'),
  resolve('brk', '\\braket{$1|$2}', 'mA'),
  resolve('\\\\bra{([^|]+)\\|', '\\braket{[[0]]|', 'rmA', { dscr = 'Convert bra into braket' }),
  resolve('\\\\bra{(.+)}([^ ]+)>', '\\braket{[[0]]|$1}', 'rmA', { dscr = 'Convert bra into braket (alternate)' }),
  resolve('outp', '\\ket{${1:\\psi}} \\bra{${1:\\psi}} $2', 'mA'),



  -- Chemistry
  resolve('pu', '\\pu{ $1 }', 'mA'),
  resolve('msun', 'M_{\\odot}', 'mA'),
  resolve('solm', 'M_{\\odot}', 'mA'),
  resolve('ce', '\\ce{ $1 }', 'mA'),
  resolve('iso', '{}^{${0:4}}_{${1:2}}${2:He}', 'mA'),
  resolve('hel4', '{}^4_2He ', 'mA'),
  resolve('hel3', '{}^3_2He ', 'mA'),



  -- Environments
  resolve('pmat', '\\begin{pmatrix}$1\\end{pmatrix}', 'mA', { dscr = '()' }),
  resolve('bmat', '\\begin{bmatrix}$1\\end{bmatrix}', 'mA', { dscr = '[]' }),
  resolve('Bmat', '\\begin{Bmatrix}$1\\end{Bmatrix}', 'mA', { dscr = '{}' }),
  resolve('vmat', '\\begin{vmatrix}$1\\end{vmatrix}', 'mA', { dscr = '| |' }),
  resolve('Vmat', '\\begin{Vmatrix}$1\\end{Vmatrix}', 'mA', { dscr = '|| ||' }),
  resolve('case', '\\begin{cases}$1\\end{cases}', 'mA'),
  resolve('align', '\\begin{align}$1\\end{align}', 'mA'),
  resolve('eqnarray', '\\begin{eqnarray}$1\\end{eqnarray}', 'mA'),
  resolve('array', '\\begin{array}$1\\end{array}', 'mA'),
  resolve('matrix', '\\begin{matrix}$1\\end{matrix}', 'mA'),



  -- Brackets
  resolve('lr(', '\\left($1\\right)', 'mA'),
  resolve('lr|', '\\left|$1\\right|', 'mA'),
  resolve('lr{', '\\left\\{$1\\right\\}', 'mA'),
  resolve('lr[', '\\left[$1\\right]', 'mA'),
  resolve('lr<', '\\left<$1\\right>', 'mA'),
  resolve('lrn', '\\left\\|$1\\right\\|', 'mA'),
  -- resolve('lr()', '\\left<$1\\right> $1', 'mA'),
  resolve('avg', '\\langle$1\\rangle', 'mA'),
  resolve('(', '($1)', 'mA'),
  resolve('{', '{$1}', 'mA'),
  resolve('[', '[$1]', 'mA'),
  resolve('mod', '|$1|', 'mA'),
  resolve('norm', '\\|$1\\|', 'mA'),
  resolve('^(', '^{($1)}', 'mA'),
  resolve('_(', '_{($1)}', 'mA'),
  resolve('^-', '^{-$1}', 'mA'),
  resolve('^[', '^{[$1]}', 'mA'),
  resolve('set', '\\{$1\\}', 'mA'),



  -- Misc
  resolve('taylor',
    '${1:f}(${2:x}+${3:h})=$1($2)+$1\'($2)$3+$1\'\'($2)\\frac{$3^2}{2!}+\\cdots',
    'mA'),
  resolve('ndet',
    '\\begin{vmatrix}a_{11}&a_{12}&\\cdots&a_{1${1:n}}\\\\a_{21}&a_{22}&\\cdots&a_{2$1}\\\\\\vdots&\\vdots&&\\vdots\\\\a_{$11}&a_{$12}&\\cdots&a_{$1$1}\\end{vmatrix}',
    'mA', { priority = 10 }),
  resolve('smat',
    '\\begin{bmatrix}a_{11}&a_{12}&\\cdots&a_{1${1:n}}\\\\a_{21}&a_{22}&\\cdots&a_{2$1}\\\\\\vdots&\\vdots&&\\vdots\\\\a_{$11}&a_{$12}&\\cdots&a_{$1$1}\\end{bmatrix}',
    'mA', { priority = 10 }),
  resolve('([a-zA-Z])([a-zA-Z])mat',
    '\\left[\\begin{matrix}a_{11}&a_{12}&\\cdots&a_{1[[1]]}\\\\a_{21}&a_{22}&\\cdots&a_{2[[1]]}\\\\\\vdots&\\vdots&&\\vdots\\\\a_{[[0]]1}&a_{[[0]]2}&\\cdots&a_{[[0]][[1]]}\\end{matrix}\\right]',
    'rmA'),
  resolve('vand',
    '\\begin{vmatrix}1&${1:x_1}&$1^2&\\cdots&$1^n\\\\1&${2:x_2}&$2^2&\\cdots&$2^n\\\\\\vdots&\\vdots&\\vdots&&\\vdots\\\\1&${3:x_n}&$3^2&\\cdots&$3^n\\end{vmatrix}',
    'mA'),
  resolve('remainder.lagrange',
    '\\frac{${1:f}^{(${2:n}+1)}(${3:\\zeta})}{($2+1)!}\\prod_{i=0}^{$2}($3-x_i)', 'mA'),
  resolve('s.t.', '\\text{s.t.}', 'mA'),
  resolve('seq', '${1:x}_1,$1_2,\\cdots,$1_n', 'mA'),
  resolve('nseq', '1,2,\\cdots,${1:n}', 'mA'),
  resolve('iseq', '${1:x}_1$2$3$1_2$2$3\\cdots $3$1_${4:n}$2,', 'mAs', { 'powerful sequence generator.', 'step 1: leader character', 'step 2: trailing character', 'step 3: separator', 'step 4: end of sequence' }),
  M.S({ trig = '(%d+)#seq', regTrig = true, snippetType = 'autosnippet', priority = 1010 }, {
    M.d(1, function (_, parent)
      local times = tonumber(parent.snippet.captures[1])
      local seq = {}
      for i = 1, times do
        table.insert(seq, M.i(i, 'x'))
        table.insert(seq, M.t'1')
      end
      table.insert(seq, M.i(times + 1, 'x'))
      table.insert(seq, M.i(times + 2)) -- seperator
      for i = 1, times do
        table.insert(seq, M.r(i))
        table.insert(seq, M.t'2')
      end
      table.insert(seq, M.r(times + 1))
      table.insert(seq, M.r(times + 2))
      table.insert(seq, M.t'\\cdots ')
      table.insert(seq, M.r(times + 2))
      table.insert(seq, M.r(1))
      table.insert(seq, M.i(times + 3, 'n'))
      for i = 2, times do
        table.insert(seq, M.r(i))
        table.insert(seq, M.r(times + 3))
      end
      return M.s(nil, seq)
    end)
  }, { condition = M.tex.in_mathzone}),
  M.S({ trig = '(%d+)#revseq', regTrig = true, snippetType = 'autosnippet', priority = 1010 }, {
    M.d(1, function (_, parent)
      local times = tonumber(parent.snippet.captures[1])
      local seq = {}
      table.insert(seq, M.i(1, 'x'))
      table.insert(seq, M.i(times + 3, 'n'))
      for i = 2, times do
        table.insert(seq, M.i(i, 'x'))
        table.insert(seq, M.r(times + 3))
      end
      table.insert(seq, M.i(times + 1, 'x'))
      table.insert(seq, M.i(times + 2)) -- seperator
      for i = 1, times do
        table.insert(seq, M.r(i))
        table.insert(seq, M.r(times + 3))
        table.insert(seq, M.t'-1')
      end
      table.insert(seq, M.r(times + 1))
      table.insert(seq, M.r(times + 2))
      table.insert(seq, M.t'\\cdots ')
      table.insert(seq, M.r(times + 2))
      for i = 1, times do
        table.insert(seq, M.r(i))
        table.insert(seq, M.t'1')
      end
      return M.s(nil, seq)
    end)
  }, { condition = M.tex.in_mathzone}),
}
