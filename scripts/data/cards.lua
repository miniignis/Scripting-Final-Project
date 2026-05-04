--[[
    File: cards.lua
    Purpose: Holds data of cards (name & sprite).
]]

local Cards = {}

local nextIndex = 0

local function card(name, sprite, price)
    nextIndex = nextIndex + 1
    Cards[nextIndex] = {
        name = name,
        sprite = sprite,
        price = price,
    }
end

-- Pack 1
card("Energy", 1, 1)
card("Space", 2, 1)
card("Time", 3, 1)
card("Matter", 4, 1)

-- Pack 1 Combination Cards
card("Gravity", 5, 5)
card("Orbit", 6, 5)
card("Black Hole", 7, 5)
card("Light", 8, 5)
card("")

return Cards