local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Events = ReplicatedStorage:WaitForChild("Events")


local player = Players.LocalPlayer

local thisRoundCompleted = false
local function onMazeComplete()
    if not thisRoundCompleted then
        thisRoundCompleted = true
        local sound = Instance.new("Sound", workspace)
        sound.SoundId = "rbxassetid://11860624316"
        sound.SoundGroup = game:GetService("SoundService").Announcer
        sound:Play()
        sound.Ended:Once(function()
            sound:Destroy()
        end)
        local leaderstats = player.leaderstats
        local mazeStat = leaderstats and leaderstats:FindFirstChild("Maze Completed")
        if mazeStat then
            mazeStat.Value = mazeStat.Value + 1
        end
    end
end

local function onPreparationStart()
    thisRoundCompleted = false
end


Events.onMazeComplete.OnClientEvent:Connect(onMazeComplete)
Events.onPreparationStart.OnClientEvent:Connect(onPreparationStart)
