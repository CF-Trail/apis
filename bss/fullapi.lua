getgenv().api = {
    morphs = {},
    windy = nil,
    vicious = nil,
    windDonate = false,
}

for i, v in next, game:GetService("ReplicatedStorage").Morphs:GetChildren() do
    table.insert(api.morphs, v.Name)
end
