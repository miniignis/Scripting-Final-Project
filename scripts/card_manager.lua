--[[
    File: card_manager.lua
    Purpose: To manage the cards the player owns, along with their interactions.
]]

local CardManager = {}
local Card = require("scripts.card")
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

    -- Card dropping and combining
    if Input.mouse.justReleased then
        local grabbed = CardManager.grabbedCard
        local target = nil

        if grabbed then
            for _, card in pairs(CardManager.cards) do
                if card ~= grabbed and card:isWithinBounds(Input.mouse.x, Input.mouse.y) then
                    target = card
                    break
                end
            end
            if target then
                CardManager.resolveCombination(target, grabbed)
            end
        end
        CardManager.grabbedCard = nil
        Input.mouse.icon = 2
    end

    if CardManager.grabbedCard then
        Input.mouse.icon = 3
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
    if not cardA or not cardB then return end
    if cardA.uid == cardB.uid then return end

    local min = math.min(cardA.data.id, cardB.data.id)
    local max = math.max(cardA.data.id, cardB.data.id)

    local result = Combos[min] and Combos[min][max] or nil

    if result then -- Only make a card if the combination is valid
       local comboCard = CardManager.addCard(result, (cardA.x + cardB.x) / 2, (cardA.y + cardB.y) / 2)
       local velocity = 200
       comboCard.dx = math.random(-velocity, velocity)
       comboCard.dy = math.random(-velocity, velocity)
    end
end

function CardManager.clear()
    CardManager.cards = {}
end

return CardManager