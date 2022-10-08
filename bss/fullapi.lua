api = {
    morphs = {},
    dispensers = {},
    windy = nil,
    vicious = nil,
    windDonate = false,
}

notifications = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jxereas/UI-Libraries/main/notification_gui_library.lua", true))()

function api:MakeNotification(t,b,tt)
    notifications.new(t,b,tt,true,5)
end

for i, v in next, game:GetService("ReplicatedStorage").Morphs:GetChildren() do
    table.insert(api.morphs, v.Name)
end

for i, v in next, workspace.Toys:GetChildren() do
    if string.match(v.Name,"Dispenser") and v.Name ~= "Royal Jelly Dispenser" then
       table.insert(api.dispensers,v.Name)     
    end
end

return api
