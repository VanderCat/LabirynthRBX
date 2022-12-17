local ReplicatedStorage = game:GetService("ReplicatedStorage")

local folder = Instance.new("Folder", ReplicatedStorage)
folder.Name = "Events"
local onNeurotoxinActivated = Instance.new("RemoteEvent", folder)
onNeurotoxinActivated.Name = "onNeurotoxinActivated"
local onGameEnded = Instance.new("RemoteEvent", folder)
onGameEnded.Name = "onGameEnded"
local onGameStart = Instance.new("RemoteEvent", folder)
onGameStart.Name = "onGameStart"