local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Fusion = require(ReplicatedStorage.Common.Fusion)
local New = Fusion.New
local Children = Fusion.Children

local State = Fusion.State
local Computed = Fusion.Computed

local Time = State(game.ReplicatedStorage.TimerValue.Value)
local Text = State(game.ReplicatedStorage.TimerText.Value)

local Clock = Computed(function()
    return Text:get() .. Time:get()
end)

local gui = New "ScreenGui" {
    Parent = Players.LocalPlayer.PlayerGui,
    Name = "Clock",
    [Children] = New "TextLabel" {
        Size = UDim2.new(.2, 0, .1, 0),
        Text = Clock
    }
}

-- Every second, update the state
while true do
    wait(1)
    Time:set(game.ReplicatedStorage.TimerValue.Value)
    Text:set(game.ReplicatedStorage.TimerText.Value)
end

