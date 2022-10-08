api = {
    morphs = {},
    dispensers = {},
    fieldboosters = {},
    npcs = {},
    amulets = {},
    fasttravel = {"Slingshot","Red Cannon","Yellow Cannon","Blue Cannon"},
    walkspeed = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed,
    jumppower = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower,
}

notifications = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jxereas/UI-Libraries/main/notification_gui_library.lua", true))()

function api:MakeNotification(t,b,tt)
    notifications.new(t,b,tt,true,5)
end

function api:AntiSleep()
    local Hum = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
    Hum:GetPropertyChangedSignal("Health"):Connect(function()
    if Hum.Health <= 25 then
    Hum.Parent = nil;
    Hum.Parent = game.Players.LocalPlayer.Character;
    end
end)    
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

for i,v in next, workspace.NPCs:GetChildren() do
   table.insert(api.npcs,v.Name)
end

for i,v in next, workspace.Amulets:GetChildren() do
   table.insert(api.amulets,v.Name)    
end

return api
