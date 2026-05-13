--[[
    File: cards.lua
    Purpose: Holds data of cards (name & sprite).
]]

local Cards = {}
local CardsByName = {}

local nextIndex = 1
local function addCard(name)
    local card = {id = nextIndex, name = name, sprite = nextIndex}
    
    Cards[nextIndex] = card
    CardsByName[name] = card

    nextIndex = nextIndex + 1
end

-- ASTRONOMY PACK
addCard("Dust")
addCard("Time")
addCard("Hydrogen")
addCard("Oxygen")

addCard("Gravity")
addCard("Blackhole")
addCard("Dirt")
addCard("Water")
addCard("Water Planet")
addCard("Earth")
addCard("Star")
addCard("Red Giant")
addCard("Constellation")

-- GARDEN PACK
addCard("Seed")
addCard("Soil")
addCard("Sapling")

addCard("Tree")
addCard("Apple")
addCard("Worm")
addCard("Death")
addCard("Nothing")
addCard("Forest")
-- Time is shared with Astronomy Pack.

-- Temporary End pack card, to be replaced with actual cards.
addCard("You Win!")

-- COOKING PACK
-- Not implemented yet due to time constraints, but possibly added in the future?

return {
    Cards = Cards,
    CardsByName = CardsByName
}