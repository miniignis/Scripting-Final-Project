--[[
    File: packs.lua
    Purpose: To hold data on the card packs that can be opened. Handles card rarity.
]]

Cards = require("scripts.data.cards")
local Packs = {}

local nextIndex = 0
local function pack(name, cards, discoveries)
    
    local data = {
        sprite = nextIndex,
        name = name,
        cards = cards,
        discoveries = discoveries
    }
    
    nextIndex = nextIndex + 1

    return data
  end

Packs = {
    pack("Astronomy Pack", {"Dust", "Time", "Hydrogen", "Oxygen"}, {"Gravity", "Blackhole", "Dirt", "Water", "Water Planet", "Earth", "Star", "Red Giant", "Constellation"}),
    pack("Gardening Pack", {"Seed", "Soil", "Time"}, {"Tree", "Apple", "Worm", "Death", "Nothingness", "Forest"}),
    pack("Cooking Pack", {"Flour", "Eggs", "Milk", "Butter"}, {})
}

return Packs