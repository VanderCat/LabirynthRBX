local ReplicatedStorage = game:GetService("ReplicatedStorage")

local folder = Instance.new("Folder", ReplicatedStorage)
folder.Name = "Events"
local onNeurotoxinActivated = Instance.new("RemoteEvent", folder)
onNeurotoxinActivated.Name = "onNeurotoxinActivated"

--local
local ServerStorage = game:GetService("ServerStorage")

local folder = Instance.new("Folder", ServerStorage)
folder.Name = "Events"
local onNeurotoxinActivated = Instance.new("BindableEvent", folder)
onNeurotoxinActivated.Name = "onNeurotoxinActivated"

local onPreparationStart = Instance.new("BindableEvent", folder)
onPreparationStart.Name = "onPreparationStart"

local onGameStart = Instance.new("BindableEvent", folder)
onGameStart.Name = "onGameStart"