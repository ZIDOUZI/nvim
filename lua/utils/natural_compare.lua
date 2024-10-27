--- this: string
--- other: string
function string.natural_compare(this, other)
  if this == other then
    return false
  end
  for i = 1, math.max(#this, #other), 1 do
    local t = this:sub(i, -1)
    local o = other:sub(i, -1)
    if type(tonumber(t:sub(1, 1))) == "number" and type(tonumber(o:sub(1, 1))) == "number" then
      local t_num = tonumber(t:match("^%d+"))
      local o_num = tonumber(o:match("^%d+"))
      if t_num ~= o_num then
        return t_num < o_num
      end
    elseif t:sub(1, 1) ~= o:sub(1, 1) then
      return t < o
    end
  end
  return true
end
