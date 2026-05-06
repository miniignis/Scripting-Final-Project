--[[
    File: card_manager.lua
    Purpose: To manage the cards the player owns, along with their interactions.
]]

local CardManager = {}
local Card = require("scripts.card")
--local Cards = require("scripts.data.cards")
local Combos = require("scripts.data.combos")
local Input = require("scripts.input")

function CardManager.load()
    CardManager.grabbedCard = nil
    CardManager.cards = {}
end

function CardManager.update(dt)

    -- Handle card grabbing and dragging
    if Input.mouse.justPressed then
        local highestIndex = -1
        for k, card in pairs(CardManager.cards) do
            if Input.mouse.x > card.x and Input.mouse.x < card.x + 25 and Input.mouse.y > card.y and Input.mouse.y < card.y + 35 then
                if k > highestIndex then
                    highestIndex = k
                end
            end
        end
        
        if highestIndex ~= -1 then -- Always grab the topmost card if multiple are clicked
            CardManager.cards[highestIndex], CardManager.cards[#CardManager.cards] = CardManager.cards[#CardManager.cards], CardManager.cards[highestIndex] -- Move to end of list to draw on top
            CardManager.grabbedCard = CardManager.cards[#CardManager.cards]
        end
    end

    if Input.mouse.justReleased then
        local grabbed = CardManager.grabbedCard
        local target = nil

        if grabbed then
            for _, card in pairs(CardManager.cards) do
                if card ~= grabbed and Input.mouse.x > card.x and Input.mouse.x < card.x + 25 and Input.mouse.y > card.y and Input.mouse.y < card.y + 35 then
                    target = card
                    break
                end
            end
            if target then
                CardManager.resolveCombination(grabbed, target)
            end
        end

        CardManager.grabbedCard = nil
    end

    if CardManager.grabbedCard then
        CardManager.grabbedCard.x = Input.mouse.x - 12.5
        CardManager.grabbedCard.y = Input.mouse.y - 17.5
        CardManager.grabbedCard.scale = 1.5
        CardManager.grabbedCard.rotation = CardManager.grabbedCard.rotation + (Input.mouse.deltaX * 0.2) * dt
    end
    
    --[[
    if love.keyboard.isDown("space") then
        CardManager.clear()
    end
    ]]

    -- Update all cards
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


end

function CardManager.clear()
    CardManager.cards = {}
end

return CardManager