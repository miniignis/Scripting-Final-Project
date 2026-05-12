--[[
    File: ui.lua
    Purpose: UI related functions and data.
]]

local UI = {}
local Input = require("scripts.input")
local GraphicsManager = require("scripts.gfx")

function UI.load()
    UI.components = {}
end

function UI.draw()
    for _, component in ipairs(UI.components) do
        component:draw()
    end
end

function UI.update(dt)
    for _, component in ipairs(UI.components) do
        component:update(dt)
    end
end

function UI.addPanel(x, y, width, height, color)
    local panel = {
        x = x,
        y = y,
        width = width,
        height = height,
        draw = function(self)
            love.graphics.setColor(color)
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, 5, 5)
            love.graphics.setColor(1, 1, 1)
        end,
        update = function(self, dt) end
    }
    table.insert(UI.components, panel)
end

function UI.addButton(x, y, width, height, text, onClick)
    local button = {
        x = x,
        y = y,
        width = width,
        height = height,
        text = text,
        onClick = onClick,
        hovered = false,
        update = function(self, dt)
            local mouseX, mouseY = Input.getMousePosition()
            self.hovered = mouseX >= self.x and mouseX <= self.x + self.width and
                           mouseY >= self.y and mouseY <= self.y + self.height

            if self.hovered and Input.mouse.justPressed then
                self.onClick()
            end
        end,
        draw = function(self)
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, 5, 5)
            love.graphics.setColor(0, 0, 0)

            love.graphics.print(self.text, self.x + 10, self.y + 7)
            love.graphics.setColor(1, 1, 1)
        end
    }
    table.insert(UI.components, button)
end

function UI.addSpriteButton(sheet, id, x, y, onClick)
    local spr = GraphicsManager.getQuad(sheet, id)
    local _, _, w, h = spr:getViewport()
    local button = {
        x = x,
        y = y,
        sheet = sheet,
        sprite = id,
        width = w,
        height = h,
        onClick = onClick,
        hovered = false,
        update = function(self, dt)
            local mouseX, mouseY = Input.getMousePosition()
            self.hovered = mouseX >= self.x and mouseX <= self.x + self.width and
                           mouseY >= self.y and mouseY <= self.y + self.height

            if self.hovered and Input.mouse.justPressed then
                self.onClick()
            end
        end,
        draw = function(self)
            GraphicsManager.sprite(self.sheet, self.sprite, self.x, self.y + (self.hovered and -1 or 0), 0, 1, 1)
        end
    }
    table.insert(UI.components, button)
end

return UI
