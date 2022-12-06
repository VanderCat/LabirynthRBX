local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local maze = require(ServerScriptService.Server.mazegen)

--[[
    local timerStart = os.time()
    local timerEnd = timerStart+900
    while True do 
        local elapsedTime = timerEnd-os.time()
        wait(1)
    end
]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local function startGame()
    local Model = Instance.new("Model")
    Model.Parent = workspace
    local width, height = 51, 51
    local newMaze = maze:init(width, height)
    maze:carve(newMaze, width, height, 2, 2)
    newMaze[width + 2] = 0
    newMaze[(height - 2) * width + width - 3] = 0
    local size = 12
    for y = 0, height - 1 do
        for x = 0, width - 1 do
            local id = y * width + x
            local part = Instance.new("Part")
            part.Name = "mazePart" .. id
            part.Anchored = true
            part.Color = Color3.new(1, 1, 1)
            part.Parent = Model
            for texNum = 0, 5, 1 do
                local texture = Instance.new("Texture")
                texture.Parent=part
                if texNum == 1 or texNum == 4 then
                    texture.Texture = "http://www.roblox.com/asset/?id=48888238"
                    texture.StudsPerTileU = 8
                    texture.StudsPerTileV = 8
                else
                    texture.Texture = "http://www.roblox.com/asset/?id=48888249"
                    texture.StudsPerTileU = 12
                    texture.StudsPerTileV = 8
                    texture.OffsetStudsV = -4
                end
                texture.Face = texNum
            end
            if newMaze[id] == 1 then
                part.Position = Vector3.new(x*size, size, y*size)
                part.Size = Vector3.new(size, size*3, size)
            else 
                part.Position = Vector3.new(x*size, -size, y*size)
                part.Size = Vector3.new(size, size, size)
            end
        end
    end
end
startGame()