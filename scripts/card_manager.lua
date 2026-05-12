--[[
    File: card_manager.lua
    Purpose: To manage the cards the player owns, along with their interactions.
]]

local CardManager = {}
local Card = require("scripts.card")
local CardData = require("scripts.data.cards")
local PackData = require("scripts.data.packs")
local Combos = require("scripts.data.combos")
local Input = require("scripts.input")
local SoundManager = require("scripts.sound")

local function getHoveredCard()
    local highestIndex = -1
    for k, card in pairs(CardManager.cards) do
        if Input.mouse.x > card.x and Input.mouse.x < card.x + 25 and Input.mouse.y > card.y and Input.mouse.y < card.y + 35 then
            if k > highestIndex then
                highestIndex = k
            end
        end
    end
    return highestIndex
end

function CardManager.load()
    CardManager.grabbedCard = nil
    CardManager.hoveredCard = nil
    CardManager.currentPackIndex = 2
    CardManager.cards = {}
    CardManager.packDiscoveries = {}

    for i = 1, #PackData do
        CardManager.packDiscoveries[i] = {}
        local discoveries = PackData[i].discoveries
        for j = 1, #discoveries do
            CardManager.packDiscoveries[i][discoveries[j]] = false
        end
    end
end

function CardManager.update(dt)

    -- Card Hovering
    CardManager.hoveredCard = getHoveredCard()
    if CardManager.hoveredCard ~= -1 then
        Input.mouse.icon = 2
    else
        Input.mouse.icon = 1
    end

    -- Handle card grabbing and dragging
    if Input.mouse.justPressed then
        local hoveredIndex = getHoveredCard()
        if hoveredIndex ~= -1 then -- Always grab the topmost card if multiple are clicked

            CardManager.cards[hoveredIndex], CardManager.cards[#CardManager.cards] = CardManager.cards[#CardManager.cards], CardManager.cards[hoveredIndex] -- Move to end of list to draw on top
            CardManager.grabbedCard = CardManager.cards[#CardManager.cards]

            SoundManager.play("card_pickup", nil, math.random(0.9, 1.1))
        end
    end

    -- Card dropping and combining
    if Input.mouse.justReleased then
        local grabbed = CardManager.grabbedCard
        local target = nil

        if grabbed then
            SoundManager.play("card_drop", 0.1, math.random(0.9, 1.1))
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
    for _, card in ipairs(CardManager.cards) do
        card:update(dt)
    end
end

function CardManager.draw()
    for index, card in ipairs(CardManager.cards) do

        -- Draw card name on hover.
        if index == CardManager.hoveredCard and not CardManager.grabbedCard then
            local tx, ty = card.x + (25 - #card.data.name * 8 / 2) - 6, card.y - 16
            love.graphics.setColor(0, 0, 0, 0.8)
            love.graphics.print(card.data.name, tx, ty + 1)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.print(card.data.name, tx, ty)
        end

        -- Draw the card itself.
        card:draw()
    end

    -- Draw card discovery progress.
    -- Ideally don't do this math here and just store the counts in a variable, but this is simpler for now.
    local currentPackDiscoveries = CardManager.packDiscoveries[CardManager.currentPackIndex]
    local discoveredCount = 0
    local totalCount = 0
    for _, discovered in pairs(currentPackDiscoveries) do
        totalCount = totalCount + 1
        if discovered then
            discoveredCount = discoveredCount + 1
        end
    end

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", 0, 169, 320, 11)

    love.graphics.setColor(0.1, 0.5, 0.1, 1)
    love.graphics.rectangle("fill", 0, 170, (discoveredCount / totalCount) * 320, 10)
    
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(discoveredCount .. "/" .. totalCount .. " discovered", 112, 167)
end

function CardManager.loadPack(packIndex)
    CardManager.currentPackIndex = packIndex or 1
    local pack = PackData[CardManager.currentPackIndex]

    CardManager.clear() -- Remove all cards before loading new pack.
    for index, card in pairs(pack.cards) do
        CardManager.addCard(CardData.CardsByName[card].id, 320/2 + (index * 32) - 92, 180/2 - 16)
    end
end

function CardManager.addCard(id, x, y)
    local card = Card.new(id, x, y)
    table.insert(CardManager.cards, card)

    -- Also check if this card is a new discovery for the current pack
    local packIndex = CardManager.currentPackIndex
    if CardManager.packDiscoveries[packIndex][card.data.name] == false then
        CardManager.packDiscoveries[packIndex][card.data.name] = true
        SoundManager.play("card_discovered", 0.5, math.random(0.9, 1.1))

        -- Check if the pack is now completed
        local packCompleted = true
        for _, discovered in pairs(CardManager.packDiscoveries[packIndex]) do
            if not discovered then
                packCompleted = false
                break
            end
        end

        -- If the pack IS completed, play the pack completion sound and unlock the next pack
        if packCompleted then
            SoundManager.play("pack_completed", 0.7)
        end
    end
    
    return card
end

function CardManager.resolveCombination(cardA, cardB)
    if cardA.uid == cardB.uid then return end
    if not cardA or not cardB then return end

    local resultName = Combos.getResult(cardA.data.name, cardB.data.name)
    if not resultName then return end

    local resultCard = CardManager.addCard(
        CardData.CardsByName[resultName].id,
        (cardA.x + cardB.x) / 2,
        (cardA.y + cardB.y) / 2
    )

    local velocity = 200
    resultCard.dx = math.random(-velocity, velocity)
    resultCard.dy = math.random(-velocity, velocity)

    SoundManager.play("card_stack")
    --SoundManager.play("card_discovered", 0.5, math.random(0.9, 1.1))
end

function CardManager.clear()
    CardManager.cards = {}
end

return CardManager