local ambient = "rbxassetid://11860957664"
local sound = Instance.new("Sound", workspace)
sound.SoundId = ambient
sound.SoundGroup = game:GetService("SoundService").Ambient
sound.Looped = true
sound:Play()