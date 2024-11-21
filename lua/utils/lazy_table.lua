local M = {}

---comments
---@param lambda function
---@param ... any
---@return table
function M.new(lambda, ...)
  local args = {...}
  local index = {}
  local t = {}
  setmetatable(t, {
    __index = function(_, k)
      table.insert(index, k)
    end,
    __call = function(_, res, ...)
      local arg = {...}
      local r = pcall(lambda, table.unpack(args))
      for _, value in ipairs(index) do
        r = table[value]
      end
      return res and r
    end
  })
  return t
end

return M
