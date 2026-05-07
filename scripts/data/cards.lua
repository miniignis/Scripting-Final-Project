--[[
    File: cards.lua
    Purpose: Holds data of cards (name & sprite).
]]

local Cards = {}

local nextIndex = 0
local function card(name, sprite, price)
    Cards[nextIndex] = {id = nextIndex, name = name, sprite = sprite, price = price}
    nextIndex = nextIndex + 1
end

card("Matter", 1, 1)
card("Time", 2, 1)
card("Heat", 3, 1)
card("Cold", 4, 1)
card("Gravity", 5, 5)
card("Blackhole", 6, 10)
card("Planet", 7, 10)
card("Water", 8, 10)
card("Steam", 9, 20)
card("Ice", 10, 20)

return Cards
