--[[
    File: card.lua
    Purpose: To represent a physical card the player can interact with.
]]

local Card = {}
Card.__index = Card

local Cards = require("scripts.data.cards")
local GraphicsManager = require("scripts.gfx")

function Card.new(id, x, y)
    local data = Cards[id]
    assert(data, "Invalid Card ID: " .. tostring(id)) -- Never make an invalid card!

    return setmetatable({
        x = x or 0,
        y = y or 0,
        dx = 0,
        dy = 0,
        data = data
    }, Card)
end

function Card:draw()
    GraphicsManager.sprite("cards", self.data.sprite, self.x, self.y)
end

function Card:update(dt)
    -- Friction
    self.dx = self.dx * 0.8
    self.dy = self.dy * 0.8
    
    -- Movement
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

return Card