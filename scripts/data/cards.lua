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
    [0] = card("Stardust", 0, 1),
    [1] = card("Gravity", 1, 1),
    [2] = card("Heat", 2, 1),
    [3] = card("Cold", 3, 1),
}