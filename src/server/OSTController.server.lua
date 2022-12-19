local ServerStorage = game:GetService("ServerStorage")
local Events = ServerStorage:WaitForChild("Events")

local songs = {
    intro = {
        "rbxassetid://11860852793",
        "rbxassetid://11860855964"
    },
    game = {
        "rbxassetid://11860851508",
        "rbxassetid://11860855964",
        "rbxassetid://11860859072"
    },
    neurotoxin = {
        "rbxassetid://11860851508",
        "rbxassetid://11860857018"
    }
}

local sound = Instance.new("Sound", workspace)
sound.Name = "OST"
sound.SoundGroup = game:GetService("SoundService").Music
sound.Looped = true

local function getCurrentSoundbank()
    return songs[sound:GetAttribute("soundBank")]
end

local function getRandomSound()
    local variants = getCurrentSoundbank()
    local id = math.random(1, #variants)
    return variants[id]
end

local function stopAndPlay(id)
    sound:Stop()
    sound.SoundId = id
    sound:Play()
end

sound.DidLoop:Connect(function(soundId)
    local next = soundId
    while next == soundId and #getCurrentSoundbank() > 1 do
        next = getRandomSound()
    end
end)

Events.onGameStart.Event:Connect(function()
    sound:SetAttribute("soundBank", "game")
    stopAndPlay(getRandomSound())
end)
Events.onPreparationStart.Event:Connect(function()
    sound:SetAttribute("soundBank", "intro")
    stopAndPlay(getRandomSound())
end)
Events.onNeurotoxinActivated.Event:Connect(function()
    sound:SetAttribute("soundBank", "neurotoxin")
    stopAndPlay(getRandomSound())
end)