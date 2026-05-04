--[[
    File: main.lua
    Purpose: to serve as the main file running the game, handling updates and draws.
]]

ScreenManager = require("scripts.screen_manager")
gfx = require("scripts.gfx")

function love.load()
    ScreenManager.load(320, 180)
end

function love.update(dt)

end

function love.draw()
    ScreenManager.start()
    
    love.graphics.clear(0.1, 0.1, 0.1)

    ScreenManager.stop()
end