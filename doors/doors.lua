func = {}

function func:WalkTo(pos)
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

    followPath(pos)
end

function func:FirePrompt(path)
   fireproximityprompt(path) 
end

return func
