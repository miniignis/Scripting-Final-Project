--[[
    File: card_manager.lua
    Purpose: To manage the cards the player owns, along with their interactions.
]]

local CardManager = {}
local Card = require("scripts.card")
local Combos = require("scripts.data.combos")
local Input = require("scripts.input")

function CardManager.load()
    CardManager.cards = {}
end

function CardManager.update(dt)

    --[[
    if Input.mouse.justPressed then
        CardManager.addCard(1, Input.mouse.x, Input.mouse.y)
    end
    ]]

    for _, card in pairs(CardManager.cards) do
        card:update(dt)
    end
end

function CardManager.draw()
    for _, card in pairs(CardManager.cards) do
        card:draw()
    end
end

function CardManager.addCard(id, x, y)
    local card = Card.new(id, x, y)
    table.insert(CardManager.cards, card)
    return card
end

function CardManager.resolveCombination(cardA, cardB)
    if cardA.uid == cardB.uid then return end
    
    local combo = Combos[cardA.id]
end

function CardManager.clear()
    CardManager.cards = {}
end

return CardManager