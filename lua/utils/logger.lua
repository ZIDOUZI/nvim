local L = {
  ---@type (file*|nil)
  file = nil,
}

function L:line(...)
  if self.file then
    self.file:write(..., '\n')
  end
end

---comments
---@param path any
---@return table
function L.new(path)
  local self = setmetatable({}, { __index = L })
  self.file = io.open(path, 'a+')
  return self
end

return L