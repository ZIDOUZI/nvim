local M = {}

M.config = {
  is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win32unix") == 1,
  is_wsl = vim.fn.has("wsl") == 1,
  is_macos = vim.fn.has("unix") == 1,
  is_unix = vim.fn.has("unix") == 1,
}

local github = {
  open_fn = function(text, _)
    local github_shorthand = string.match(text, '[%w_%-%.]+/[%w_%-%.]+')
    if github_shorthand == nil then return nil end
    return { "https://github.com/" .. github_shorthand }
  end
}

M.openers = {
  github,
}

local function start_process(uri, opts)
  if #M.config.process.cmd == 0 then
    error("Cannot open file with application.")
    return
  end

  local process = {
    cmd = opts.cmd or M.config.process.cmd,
    args = opts.args or M.config.process.args,
    errors = "\n",
    stderr = vim.loop.new_pipe(false),
  }
  table.insert(process.args, uri)
  process.handle, process.pid = vim.loop.spawn(
    process.cmd,
    { args = process.args, stdio = { nil, nil, process.stderr }, detached = true },
    function(code)
      process.stderr:read_stop()
      process.stderr:close()
      process.handle:close()
      if code ~= 0 then
        process.errors = process.errors .. string.format('open process return code 0x%x.', code)
        error(process.errors)
      end
    end
  )
  table.remove(process.args)
  if not process.handle then
    error("\n" .. process.pid .. "\nopen process failed to spawn process using '" .. process.cmd .. "'.")
    return
  end
  vim.loop.read_start(process.stderr, function(err, data)
    if err then
      return
    end
    if data then
      process.errors = process.errors .. data
    end
  end)
  vim.loop.unref(process.handle)
end

function M.open(text)
  for _, opener in ipairs(M.openers) do
    local result = opener.open_fn(text, {})
    if result == nil then goto continue end
    local len = #result
    if len == 0 then goto continue end

    if len == 1 then
      start_process(result[1], {})
      break
    else
      vim.ui.select(result, {}, function(item, _)
        start_process(item, {})
      end)
      break
    end
    ::continue::
  end
end

function M.open_cword()
  M.open(vim.fn.expand('<cWORD>'))
end

function M.setup(opts)
  opts = opts or {}
  M.config.process = opts.process or {}
  if #M.config.process == 0 then
    if M.config.is_windows or M.config.is_wsl then
      M.config.process = {
        cmd = "cmd.exe",
        args = { "/c", "start", '""' }
      }
    elseif M.config.is_macos then
      M.config.process.cmd = "open"
    elseif M.config.is_unix then
      M.config.process.cmd = "xdg-open"
    end
  end
end

M.setup()
return M
