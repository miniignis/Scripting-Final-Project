--[[
    File: screen_manager.lua
    Purpose: To handle the resolution and window of the game.
]]

local ScreenManager = {}

function ScreenManager.load(resolutionX, resolutionY)
    
    love.graphics.setDefaultFilter("nearest", "nearest")

    ScreenManager.baseWidth = resolutionX
    ScreenManager.baseHeight = resolutionY
    ScreenManager.canvas = love.graphics.newCanvas(resolutionX, resolutionY)
end

function ScreenManager.start()
    love.graphics.clear()
    love.graphics.setCanvas(ScreenManager.canvas)
end

function ScreenManager.stop()

    local winW, winH = love.graphics.getDimensions()
    local scale = math.min(winW / ScreenManager.baseWidth, winH / ScreenManager.baseHeight)

    local drawW = ScreenManager.baseWidth * scale
    local drawH = ScreenManager.baseHeight * scale

    local x = (winW - drawW) / 2
    local y = (winH - drawH) / 2
    
    love.graphics.setCanvas()
    love.graphics.draw(ScreenManager.canvas, x, y, 0, scale, scale)
end

return ScreenManager