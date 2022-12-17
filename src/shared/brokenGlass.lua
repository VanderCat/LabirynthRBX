local regenTime = 6999999999
local shards = 9
local soundid = "rbxassetid://2731462191"
local volume = 2

return function(parent)
    local broken = false
    local sound = Instance.new("Sound",parent)
    sound.SoundId = soundid
    sound.Volume = volume
    parent.Touched:Connect(function(part)
        if not broken then
            sound:Play()
            for i = 1,shards do
                local shard = Instance.new("Part")
                shard.Size = Vector3.new(
                    parent.Size.X/math.random(2,5),
                    parent.Size.Y/math.random(2,5),
                    parent.Size.Z/math.random(2,5)
                )
                shard.Position = parent.Position - Vector3.new(
                    math.random(-parent.Size.X/2,parent.Size.X/2),
                    math.random(-parent.Size.Y/2,parent.Size.Y/2),
                    math.random(-parent.Size.Z/2,parent.Size.Z/2)
                )
                shard.Orientation = Vector3.new(
                    math.random(-360,360),
                    math.random(-360,360),
                    math.random(-360,360)
                )
                shard.Parent = parent
                shard.Material = parent.Material
                shard.Color = parent.Color
                shard.Transparency = parent.Transparency
                game.Debris:AddItem(shard,regenTime)
            end
            parent.Transparency = 1
            parent.CanCollide = false
            broken = true
        end
    end)
end