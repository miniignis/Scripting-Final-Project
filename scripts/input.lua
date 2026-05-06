--[[
    File: input.lua
    Purpose: To handle player input.
]]

local Input = {}
local ScreenManager = require("scripts.screen_manager")

Input.mouse = {
    x = 0,
    y = 0,
    deltaX = 0,
    deltaY = 0,
    pressed = false,
    justPressed = false,
    justReleased = false,
}

function Input.mousePressed(button)
    if button ~= 1 then return end
    Input.mouse.pressed = true
    Input.mouse.justPressed = true
end

function Input.mouseMoved(x, y, dx, dy)
    Input.mouse.deltaX = dx
    Input.mouse.deltaY = dy
end

function Input.mouseReleased(button)
    if button ~= 1 then return end
    Input.mouse.pressed = false
    Input.mouse.justReleased = true
end

function Input.update()
    Input.mouse.x, Input.mouse.y = ScreenManager.toWorldCoords(love.mouse.getPosition())
end

function Input.postUpdate()
    Input.mouse.justPressed = false
    Input.mouse.justReleased = false
end

return Input