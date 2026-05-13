--[[
    File: combos.lua
    Purpose: Holds data on card combinations and their worth.
]]

local Combos = {}

local function makeKey(a, b)
    if a < b then
        a, b = b, a
    end

    return a.."|"..b
end

local function addCombo(cardA, cardB, result)
    Combos[makeKey(cardA, cardB)] = result
end

function Combos.getResult(cardA, cardB)
    return Combos[makeKey(cardA, cardB)]
end

-- ASTRONOMY PACK
addCombo("Dust", "Gravity", "Dirt")
addCombo("Dust", "Time", "Gravity")
addCombo("Gravity", "Gravity", "Blackhole")
addCombo("Hydrogen", "Oxygen", "Water")
addCombo("Dirt", "Water", "Water Planet")
addCombo("Water Planet", "Dirt", "Earth")
addCombo("Gravity", "Hydrogen", "Star")
addCombo("Star", "Time", "Red Giant")
addCombo("Red Giant", "Time", "Blackhole")
addCombo("Star", "Star", "Constellation")

-- GARDEN PACK
addCombo("Seed", "Soil", "Sapling")
addCombo("Sapling", "Time", "Tree")
addCombo("Tree", "Time", "Apple")
addCombo("Apple", "Time", "Worm")
addCombo("Time", "Worm", "Death")
addCombo("Worm", "Worm", "Worm")
addCombo("Death", "Death", "Nothing")
addCombo("Tree", "Tree", "Forest")
addCombo("Apple", "Worm", "Soil")

-- COOKING PACK

return Combos