--Table
local WindFc = {}
--Main
function WindFc:SetLibrary(library)
    self.Library = library
    return WindFc
end

function WindFc:SetUIToggle(data)
    local ParentUI = data.Window
    self.Library:SetToggleKey(data.KeyCode)
    return WindFc
end

return WindFc
