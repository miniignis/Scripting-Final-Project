--[[
    File: gfx.lua
    Purpose: Handles sprite loading and drawing.
]]

local gfx = {}

gfx.sheets = {}
gfx.quads = {}

function gfx.loadSheet(name, path, tileW, tileH)
    local sheet = love.graphics.newImage(path) -- Load atlas

    gfx.sheets[name] = sheet -- Setup sheets & quads to store new atlas.
    gfx.quads[name] = {}

    -- Loop through the atlas using the dimensions and setup quads for every sprite. Mark by ID.
    local w, h = sheet:getDimensions()
    local id = 1
    for y = 0, h - tileH, tileH do
        for x = 0, w - tileW, tileW do
            gfx.quads[name][id] = love.graphics.newQuad(x, y, tileW, tileH, w, h)
            id = id + 1
        end
    end
end

function gfx.getQuad(sheet, id)
    return gfx.quads[sheet][id]
end

function gfx.sprite(sheet, id, x, y, rot, sx, sy, ox, oy)
    rot = rot or 0
    sx = sx or 1
    sy = sy or 1
    ox = ox or 0
    oy = oy or 0

    local sh = gfx.sheets[sheet]
    local quad = gfx.quads[sheet][id]
    if not quad or not sh then return end

    love.graphics.draw(sh, quad, x, y, rot, sx, sy, ox, oy)
end

return gfx