--[[
    File: card_manager.lua
    Purpose: To manage the cards the player owns, along with their interactions.
]]

local CardManager = {}

function CardManager.load()
    CardManager.inventory = {} -- Cards in inventory.
    CardManager.hand = {} -- Cards interactable.
end

function CardManager.verifyCombos()
end

return CardManager