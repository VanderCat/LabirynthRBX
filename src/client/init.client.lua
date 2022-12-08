local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Time = game.ReplicatedStorage.TimerValue
local Text = game.ReplicatedStorage.TimerText
local Roact = require(ReplicatedStorage.Common.Roact)

-- Create a function that creates the elements for our UI.
-- Later, we'll use components, which are the best way to organize UI in Roact.
local function clock(currentTime, text)
    return Roact.createElement("ScreenGui", {}, {
        TimeLabel = Roact.createElement("TextLabel", {
            Size = UDim2.new(.2, 0, .1, 0),
            Text = text .. currentTime 
        })
    })
end

local PlayerGui = Players.LocalPlayer.PlayerGui
local handle = Roact.mount(clock(Time.Value, Text.Value), PlayerGui, "Clock UI")
-- Every second, update the UI to show our new time.
while true do
    wait(1)
    handle = Roact.update(handle, clock(Time.Value, Text.Value))
end

