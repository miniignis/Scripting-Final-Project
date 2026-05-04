--[[
    File: gfx.lua
    Purpose: Handles sprite loading and drawing.
]]

local gfx = {}

local atlas
local quads = {}

function gfx.load(path, tileW, tileH)
    atlas = love.graphics.newImage(path)

    local w, h = atlas:getDimensions()

    local id = 1
    for y = 0, h - tileH, tileH do
        for x = 0, w - tileW, tileW do
            quads[id] = love.graphics.newQuad(x, y, tileW, tileH, w, h)
            id = id + 1
        end
    end
end

function gfx.sprite(id, x, y)
    local q = quads[id]
    if not q then return end

    love.graphics.draw(atlas, q, x, y)
end

return gfx