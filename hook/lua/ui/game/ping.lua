-- TimestampedMarkers: appends the game time to the text of a map marker
-- when you place it, e.g. "expand here (05:07)" or after an hour
-- "watch nukes (01:05:12)".
--
-- This file is appended to the game's /lua/ui/game/ping.lua. DoPing() in
-- that file calls NamePing() to show the "Enter Marker Name" dialog and
-- then uses the typed name both for the marker on the map and for the chat
-- message to allies. Wrapping NamePing here changes both at once, and since
-- the time is part of the text itself, allies see it even without this mod.
--
-- Markers placed with empty text are left alone. Markers can't be renamed
-- in the game (only moved or deleted), so the time is added exactly once.

local TimestampedMarkersOriginalNamePing = NamePing

local function TimestampedMarkersFormatTime(seconds)
    seconds = math.floor(seconds or 0)
    if seconds < 0 then seconds = 0 end
    local h = math.floor(seconds / 3600)
    local m = math.floor((seconds - h * 3600) / 60)
    local s = seconds - h * 3600 - m * 60
    if h > 0 then
        return string.format('%02d:%02d:%02d', h, m, s)
    end
    return string.format('%02d:%02d', m, s)
end

NamePing = function(callback, curName)
    return TimestampedMarkersOriginalNamePing(function(name)
        -- Only markers that actually have text get a time stamp.
        if type(name) == 'string' and string.find(name, '%S') then
            local ok, seconds = pcall(GetGameTimeSeconds)
            if ok and seconds then
                name = name .. ' (' .. TimestampedMarkersFormatTime(seconds) .. ')'
            end
        end
        callback(name)
    end, curName)
end
