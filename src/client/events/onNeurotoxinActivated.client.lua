local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local remoteEvent = ReplicatedStorage.Events:WaitForChild("onNeurotoxinActivated")

local player = Players.LocalPlayer
local atmosphere = game.Lighting.Atmosphere
local atmosphereGlare =  atmosphere.Glare
local atmosphereColor = atmosphere.Color
local neourotoxinColor = Color3.fromRGB(51, 67, 27)
local neourotoxinGlare = 7


local function onNeurotoxinActivated(timeLeft:number)
    print("всем привет с вами влад кот")
    local beginTweenInfo = TweenInfo.new(timeLeft, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
    local endTweenInfo = TweenInfo.new(5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local beginTween = TweenService:Create(atmosphere, beginTweenInfo, {Color = neourotoxinColor, Decay = neourotoxinColor, Glare=neourotoxinGlare})
    local endTween = TweenService:Create(atmosphere, endTweenInfo, {Color = atmosphereColor, Decay = atmosphereColor, Glare=atmosphereGlare})
    beginTween.Completed:Once(function()
        endTween:Play()
    end)
    beginTween:Play()
end


remoteEvent.OnClientEvent:Connect(onNeurotoxinActivated)