api = {
    morphs = {},
    dispensers = {},
    fieldboosters = {},
    npcs = {},
    walkspeed = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed,
    jumppower = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower,
}

notifications = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jxereas/UI-Libraries/main/notification_gui_library.lua", true))()

function api:MakeNotification(t,b,tt)
    notifications.new(t,b,tt,true,5)
end

for i, v in next, game:GetService("ReplicatedStorage").Morphs:GetChildren() do
    table.insert(api.morphs, v.Name)
end

for i, v in next, workspace.Toys:GetChildren() do
    if string.match(v.Name,"Dispenser") and v.Name ~= "Royal Jelly Dispenser" and v.Name ~= "Ant Pass Dispenser" then
       table.insert(api.dispensers,v.Name)
    elseif string.match(v.Name,"Field Boost") then
       table.insert(api.fieldboosters,v.Name)   
     end
    end
end

for i,v in next, workspace.NPCS:GetChildren() do
   table.insert(npcs,v.Name)
end

return api
