--[[
    File: main.lua
    Purpose: to serve as the main file running the game, handling updates and draws.
]]

local ScreenManager = require("scripts.screen_manager")
local GraphicsManager = require("scripts.gfx")

function love.load()
    ScreenManager.load(320, 180)
    GraphicsManager.loadSheet("cards", "assets/images/cards.png", 25, 35)

end

function love.update(dt)
end

function love.draw()
    ScreenManager.start()
    
    love.graphics.clear(0.1, 0.1, 0.1)

    ScreenManager.stop()
end