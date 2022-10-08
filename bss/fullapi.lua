api = {
    morphs = {},
    windy = nil,
    vicious = nil,
    windDonate = false,
}

function api:MakeNotification(t,b,tt)
    notifs.new(t,b,tt)
end

for i, v in next, game:GetService("ReplicatedStorage").Morphs:GetChildren() do
    table.insert(api.morphs, v.Name)
end

return api
