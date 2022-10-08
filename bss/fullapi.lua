api = {
    morphs = {},
    windy = nil,
    vicious = nil,
    windDonate = false,
}

notifications = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jxereas/UI-Libraries/main/notification_gui_library.lua", true))()

function api:MakeNotification(t,b,tt)
    notifications.new(t,b,tt)
end

for i, v in next, game:GetService("ReplicatedStorage").Morphs:GetChildren() do
    table.insert(api.morphs, v.Name)
end

return api
