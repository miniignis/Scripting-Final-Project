--[[
    File: packs.lua
    Purpose: To hold data on the card packs that can be opened. Handles card rarity.
]]

Cards = require("scripts.data.cards")

local function pack(sprite, name, cards, cost)
    return {
        sprite = sprite,
        name = name,
        cards = cards,
        cost = cost
    }
end

return {}