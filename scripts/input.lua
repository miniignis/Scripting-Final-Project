--[[
    File: input.lua
    Purpose: To handle player input.
]]

local Input = {}

Input.mouse = {
    x = 0,
    y = 0,
    pressed = false,
    justPressed = false,
    justReleased = false,
}

function Input.mousePressed(button)
    if button ~= 1 then return end
    Input.mouse.pressed = true
    Input.mouse.justPressed = true
end

function Input.mouseReleased(button)
    if button ~= 1 then return end
    Input.mouse.pressed = false
    Input.mouse.justReleased = true
end

function Input.update()
    Input.mouse.x, Input.mouse.y = love.mouse.getPosition()
    
    -- Reset justPressed and justReleased after processing
    Input.mouse.justPressed = false
    Input.mouse.justReleased = false
end

return Input