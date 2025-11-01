-- misc.lua (修正版)
local misc = {}

-- safe get_service: use game:GetService to avoid returning wrong objects
rawset(misc, "get_service", newcclosure(function(serviceName)
    -- prefer game:GetService (robust & standard)
    local ok, svc = pcall(function()
        return game:GetService(serviceName)
    end)
    if not ok or not svc then
        -- fallback: try legacy cloneref/GetService if your environment needs it
        if typeof(cloneref) == "function" and type(UserSettings) == "function" then
            -- last-resort fallback; normally shouldn't be needed
            local succ, val = pcall(function()
                return cloneref(UserSettings().GetService(game, serviceName))
            end)
            if succ and val then
                return val
            end
        end
        error(("get_service failed to obtain service '%s'"):format(tostring(serviceName)))
    end
    return svc
end))

-- to_view_point that always uses current camera
rawset(misc, "to_view_point", newcclosure(function(pos)
    local cam = workspace.CurrentCamera or camera
    if not cam then
        return Vector2.new(0,0), false
    end
    local p3, on = cam:WorldToViewportPoint(pos)
    return Vector2.new(p3.X, p3.Y), on
end))

return misc
