--[[
    File: combos.lua
    Purpose: Holds data on card combinations and their worth.
]]
local Combos = {}


local function combo(a, b, results)
    local min = math.min(a, b)
    local max = math.max(a, b)

    Combos[min] = Combos[min] or {}
    Combos[min][max] = results
end

combo(1, 4, {7}) -- Stardust + Gravity = Star

return Combos