local ReplicatedStorage = game:GetService("ReplicatedStorage")

local folder = Instance.new("Folder", ReplicatedStorage)
folder.Name = "Events"
local onNeurotoxinActivated = Instance.new("RemoteEvent", folder)
onNeurotoxinActivated.Name = "onNeurotoxinActivated"
local onMazeComplete = Instance.new("RemoteEvent", folder)
onMazeComplete.Name = "onMazeComplete"
local onPreparationStart = Instance.new("RemoteEvent", folder)
onPreparationStart.Name = "onPreparationStart"

--local
local ServerStorage = game:GetService("ServerStorage")

local folder = Instance.new("Folder", ServerStorage)
folder.Name = "Events"
local onNeurotoxinActivatedServer = Instance.new("BindableEvent", folder)
onNeurotoxinActivatedServer.Name = "onNeurotoxinActivated"

local onPreparationStartServer = Instance.new("BindableEvent", folder)
onPreparationStartServer.Name = "onPreparationStart"

local onGameStart = Instance.new("BindableEvent", folder)
onGameStart.Name = "onGameStart"