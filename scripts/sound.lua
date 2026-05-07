--[[
    File: sound.lua
    Purpose: To handle sound effects and music in the game.
]]

local SoundManager = {}

function SoundManager.loadSound(path, name)
    local sound = love.audio.newSource(path, "static")
    SoundManager[name] = sound
end

function SoundManager.play(name, volume, pitch)
    local sound = SoundManager[name]

    sound:stop() -- Stop the sound if it's already playing to allow retriggering
    
    sound:setVolume(volume or 1)
    sound:setPitch(pitch or 1)

    if sound then
        sound:play()
    end
end

return SoundManager