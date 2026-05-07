--[[
    File: card.lua
    Purpose: To represent a physical card the player can interact with.
]]

local Card = {}
Card.__index = Card

local Cards = require("scripts.data.cards")
local GraphicsManager = require("scripts.gfx")
local Util = require("scripts.util")

local nextId = 0
function Card.new(id, x, y)
    nextId = nextId + 1
    local data = Cards[id]
    return setmetatable({
        uid = nextId,
        x = x or 0,
        y = y or 0,
        dx = 0,
        dy = 0,
        scale = 1,
        rotation = 0,
        data = data
    }, Card)
end

function Card:isWithinBounds(x, y)
    return x > self.x and x < self.x + 25 and y > self.y and y < self.y + 35
end

function Card:draw()
    local ox, oy = 12.5, 17.5
    GraphicsManager.sprite("cards", self.data.sprite, self.x + ox, self.y + oy, self.rotation, self.scale, self.scale, ox, oy)
end

function Card:update(dt)
    self.scale = Util.lerp(self.scale, 1, dt * 10)
    self.rotation = Util.lerp(self.rotation, 0, dt * 10)

    -- Friction
    self.dx = self.dx * 0.95
    self.dy = self.dy * 0.95
    
    -- Movement
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

return Card