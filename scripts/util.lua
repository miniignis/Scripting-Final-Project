Util = {}

function Util.lerp(a, b, t)
    return a + (b - a) * t
end

function Util.clamp(x, min, max)
    return math.max(min, math.min(max, x))
end

return Util