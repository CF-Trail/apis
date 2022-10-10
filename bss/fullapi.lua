api = {
    ver = "1.0",
    morphs = {},
    dispensers = {},
    fieldboosters = {},
    npcs = {},
    amulets = {},
    toyRequirements = {},
    codes = {
        "2Billion",
        "FrozenBugReboot",
        "5MFavorites",
        "DarzethDoodads",
        "Thnxcyastoybox",
        "WalmartToys",
        "FourYearFiesta",
        "10mMembers",
        "1MLikes",
        "PlushFriday",
        "BANNED",
        "Cubly",
        "Teespring",
        "BeesBuzz123",
        "500mil",
        "Marshmallow",
        "ClubConverters",
        "Sure",
        "GumdropsForScience",
        "SecretProfileCode",
        "ClubBean",
        "Wink",
        "38217",
        "Bopmaster",
        "Buzz",
        "Cog",
        "Connoisseur",
        "Crawlers",
        "Nectar",
        "Roof",
        "Wax"
    },
    sounds = {},
    fields = {},
    walkspeed = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed,
    jumppower = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower
}

notifications =
    loadstring(
    game:HttpGet("https://raw.githubusercontent.com/Jxereas/UI-Libraries/main/notification_gui_library.lua", true)
)()

function api:MakeNotification(t, b, tt)
    notifications.new(t, b, tt, true, 5)
end

function api:AntiSleep()
    local Hum = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
    Hum:GetPropertyChangedSignal("Health"):Connect(
        function()
            if Hum.Health <= 25 then
                Hum.Parent = nil
                Hum.Parent = game.Players.LocalPlayer.Character
            end
        end
    )
end

function api:WalkTo(destination, walkspeed)
    local PathfindingService = game:GetService("PathfindingService")
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")

    local path = PathfindingService:CreatePath()

    local player = Players.LocalPlayer
    local character = player.Character
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.WalkSpeed = walkspeed
    for i,v in next, character:GetChildren() do
       if v.IsA(v,"BasePart") then
           v.CanCollide = false     
       end
    end
    local desti = destination

    local waypoints
    local nextWaypointIndex
    local reachedConnection
    local blockedConnection

    local function followPath(destination)
        local success, errorMessage =
            pcall(
            function()
                path:ComputeAsync(character.PrimaryPart.Position, destination)
            end
        )

        if success and path.Status == Enum.PathStatus.Success then
            waypoints = path:GetWaypoints()

            blockedConnection =
                path.Blocked:Connect(
                function(blockedWaypointIndex)
                    if blockedWaypointIndex >= nextWaypointIndex then
                        blockedConnection:Disconnect()
                        followPath(destination)
                    end
                end
            )

            if not reachedConnection then
                reachedConnection =
                    humanoid.MoveToFinished:Connect(
                    function(reached)
                        if reached and nextWaypointIndex < #waypoints then
                            nextWaypointIndex = nextWaypointIndex + 1
                            humanoid:MoveTo(waypoints[nextWaypointIndex].Position)
                        else
                            reachedConnection:Disconnect()
                            blockedConnection:Disconnect()
                        end
                    end
                )
            end
            nextWaypointIndex = 2
            humanoid:MoveTo(waypoints[nextWaypointIndex].Position)
        else
            warn("Path not computed!", errorMessage)
        end
    end

    followPath(desti)
end

for i, v in next, game:GetService("ReplicatedStorage").Morphs:GetChildren() do
    table.insert(api.morphs, v.Name)
end

for i, v in next, workspace.Toys:GetChildren() do
    if string.match(v.Name, "Dispenser") and v.Name ~= "Royal Jelly Dispenser" and v.Name ~= "Ant Pass Dispenser" then
        table.insert(api.dispensers, v.Name)
    elseif string.match(v.Name, "Field Boost") then
        table.insert(api.fieldboosters, v.Name)
    end
end

for i, v in next, workspace.NPCs:GetChildren() do
    table.insert(api.npcs, v.Name)
end

for i, v in next, workspace.Amulets:GetChildren() do
    table.insert(api.amulets, v.Name)
end

for i, v in next, workspace.Toys:GetDescendants() do
    if v.Name == "Requirements" and v.IsA(v, "ModuleScript") then
        table.insert(api.toyRequirements, v)
    end
end

for i, v in next, game.ReplicatedStorage.MusicPlayer:GetDescendants() do
    if v.IsA(v, "Sound") and v.Name == "Sound" then
        table.insert(api.sounds, v)
    end
end

for i, v in next, workspace.FlowerZones:GetChildren() do
    table.insert(api.fields, v)
end

return api
