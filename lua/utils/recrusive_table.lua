local M = {}

--- set metatable for a exist table.
---@param lambda function
---@return table self given table
local function set(lambda, ...)
  local t = {}
  local arg = {...}
  setmetatable(t, {
    __index = function () return t end,
    __call = function ()
      pcall(lambda, table.unpack(arg))
      return t
    end
  })
  return t
end

--- set metatable for a exist table.
---@param t table
---@param lambda function
---@return table self given table
function M.set(t, lambda, ...)
  local arg = {...}
  setmetatable(t, {
    __index = function () return t end,
    __call = function ()
      pcall(lambda, table.unpack(arg))
      return t
    end
  })
  return t
end

--- create a new table.
---@param lambda function
---@return table
function M.new(lambda, ...)
  local t = {}
  local arg = {...}
  return M.set(t, lambda, table.unpack(arg))
end

return M