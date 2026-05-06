--[[
    File: cards.lua
    Purpose: Holds data of cards (name & sprite).
]]

local function card(name, sprite, price)
    return {name = name, sprite = sprite, price = price}
end

return {
    Energy = card("Energy", 1, 1),
    Space = card("Space", 2, 1),
    Time = card("Time", 3, 1),
    Matter = card("Matter", 4, 1),
    Gravity = card("Gravity", 5, 5),
    Orbit = card("Orbit", 6, 5),
    BlackHole = card("Black Hole", 7, 5),
    Light = card("Light", 8, 5)
}