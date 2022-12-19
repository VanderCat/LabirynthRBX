workspace.TheEnd:MoveTo(Vector3.new(419.925, -53.015, 574.5))
local Players = game:GetService("Players")
local RemoteStorage = game:GetService("ReplicatedStorage")
workspace.TheEnd.IntroWalls.EmancipationGrill.EmancipationGrillMaterial.kill_Brick.Touched:Connect(function(otherPart)
    if otherPart.Parent:IsA("Model") and otherPart.Parent:FindFirstChild("Humanoid") then
        local Player = Players:GetPlayerFromCharacter(otherPart.Parent)
        if Player then
            RemoteStorage.Events.onMazeComplete:FireClient(Player)
            local leaderstats = Player.leaderstats
            local mazeStat = leaderstats and leaderstats:FindFirstChild("Maze Completed")
            if mazeStat then
                mazeStat.Value = mazeStat.Value + 1
            end
        end
    end
end)