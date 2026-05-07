--[[
    File: combos.lua
    Purpose: Holds data on card combinations and their worth.
]]

local Combos = {}

local function combo(cardA, cardB, result)
    local min = math.min(cardA, cardB)
    local max = math.max(cardA, cardB)
    Combos[min] = {} or Combos[min]
    Combos[min][max] = result
end

combo(0, 1, 5)
combo(0, 5, 6)
combo(5, 5, 6)

return Combos