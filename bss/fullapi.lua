getgenv().api = {
morphs = {},
}

for i,v in next, game:GetService("ReplicatedStorage").Morphs:GetChildren() do
table.insert(api.morphs,v.Name)
end
