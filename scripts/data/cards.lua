--[[
    File: cards.lua
    Purpose: Holds data of cards (name & sprite).
]]

local function card(name, sprite, price)
    return {
        name = name,
        sprite = sprite,
        price = price,
    }
end

return {
    [1] = card("Stardust",  1, 1),
    [2] = card("Heat", 2, 1),
    [3] = card("Cold", 3, 1),
    [4] = card("Gravity", 4, 1),
}