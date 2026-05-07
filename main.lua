--[[
    File: main.lua
    Purpose: To serve as the main file running the game, handling updates and draws.
]]

local ScreenManager = require("scripts.screen_manager")
local GraphicsManager = require("scripts.gfx")
local InputManager = require("scripts.input")
local CardManager = require("scripts.card_manager")
local Cards = require("scripts.data.cards")

function love.load()
    ScreenManager.load(320, 180)
    GraphicsManager.loadSheet("cards", "assets/images/cards.png", 25, 35)
    GraphicsManager.loadSheet("mouse", "assets/images/mouse.png", 16, 16)
    CardManager.load()

    for i = 0, 3 do
        CardManager.addCard(i, 320/2, 180/2)
    end
end

function love.update(dt)
    InputManager.update()
    
    CardManager.update(dt)

    InputManager.postUpdate()
end

function love.draw()
    ScreenManager.start()
    
    love.graphics.clear(0.1, 0.1, 0.1)
    CardManager.draw()

    -- Draw mouse cursor over everything else
    GraphicsManager.sprite("mouse", InputManager.mouse.icon, InputManager.mouse.x - 4, InputManager.mouse.y - 4)

    ScreenManager.stop()
end

function love.mousepressed(x, y, button)
    InputManager.mousePressed(button)
end

function love.mousereleased(x, y, button)
    InputManager.mouseReleased(button)
end

function love.mousemoved(x, y, dx, dy)
    InputManager.mouseMoved(x, y, dx, dy)
end

function love.keypressed(key)
    if key == "escape" then
        local fullscreen = love.window.getFullscreen()
        love.window.setFullscreen(not fullscreen, "desktop")
    end
end