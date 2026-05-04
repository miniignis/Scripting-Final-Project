--[[
    File: card.lua
    Purpose: To represent a physical card the player can interact with.
]]

local Card = {}
Card.__index = Card

local Cards = require("scripts.data.cards")

function Card.new(id, x, y)
    local data = Cards[id]
    assert(data, "Invalid Card ID: " .. tostring(id))

    return setmetatable({
        x = x or 0,
        y = y or 0,
        dx = 0,
        dy = 0,
        data = data
    }, Card)
end

function Card:draw()
    love.graphics.draw()
end

function Card:update(dt)
end

return Card