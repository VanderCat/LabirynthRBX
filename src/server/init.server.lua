local ServerScriptService = game:GetService("ServerScriptService")
local rs = game:GetService("ReplicatedStorage")
local maze = require(ServerScriptService.Server.mazegen)
local passagePart = require(rs.Common.models.passage.list)
local ArrPlayers = Players:GetPlayers()
local Time = game.ReplicatedStorage.TimerValue
local Text = game.ReplicatedStorage.TimerText

--[[
    local timerStart = os.time()
    local timerEnd = timerStart+900
    while True do 
        local elapsedTime = timerEnd-os.time()
        wait(1)
    end
]]
local width, height = 31, 31
local size = 16

local function getId(x, y)
    return y*width+x
end
local function getNeighbours(maze, x, y) 
    return {
        up = maze[getId(x,y+1)]==0,
        down = maze[getId(x,y-1)]==0,
        left = maze[getId(x+1,y)]==0,
        right = maze[getId(x-1,y)]==0,
    }
end
local function generatePart(parent: Instance, maze, x, y)
    local n = getNeighbours(maze, x, y)
    local part: Model
    local rotation = CFrame.Angles(0, math.rad(90), 0) --alwaysCreate just in case

    --HALLWAY
    if (n.left and n.right) and not (n.up or n.down) then
        part = passagePart:getRandomPassage("way"):Clone()
    elseif (n.up and n.down) and not (n.left or n.right) then
        part = passagePart:getRandomPassage("way"):Clone()
        local modelCFrame = part:GetPivot()  --TODO: Refactor
        part:PivotTo(modelCFrame * rotation)
    --TURN
    elseif (n.down and n.right) and not (n.left or n.up) then
        part = passagePart:getRandomPassage("rWay"):Clone()
    elseif (n.down and n.left) and not (n.up or n.right) then
        part = passagePart:getRandomPassage("rWayF"):Clone()
    elseif (n.up and n.right) and not (n.down or n.left) then
        part = passagePart:getRandomPassage("rWayR"):Clone()
    elseif (n.up and n.left) and not (n.down or n.right) then
        part = passagePart:getRandomPassage("rWayFR"):Clone()
    --THREEWAY
    elseif (n.down and n.up and n.right) and not (n.left) then
        print(x, y, n)
        part = passagePart:getRandomPassage("tWayR"):Clone()
    elseif (n.down and n.up and n.left) and not (n.right) then
        part = passagePart:getRandomPassage("tWayRF"):Clone()
    elseif (n.up and n.left and n.right) and not (n.down) then
        part = passagePart:getRandomPassage("tWayF"):Clone()
    elseif (n.down and n.left and n.right) and not (n.up) then
        part = passagePart:getRandomPassage("tWay"):Clone()
    --DEADEND 
    elseif n.left and not (n.down or n.right or n.up) then
        part = passagePart:getRandomPassage("nWay"):Clone()
    elseif n.up and not (n.down or n.right or n.left) then
        part = passagePart:getRandomPassage("nWayF"):Clone()
        local modelCFrame = part:GetPivot()
        local modelRotatation = part:GetPivot().Rotation
        part:PivotTo(modelCFrame * CFrame.Angles(0, math.rad(90)+modelRotatation.Y, 0) )
    elseif n.right and not (n.down or n.left or n.up) then
        part = passagePart:getRandomPassage("nWayF"):Clone()
    elseif n.down and not (n.up or n.right or n.left) then
        part = passagePart:getRandomPassage("nWay"):Clone()
        local modelCFrame = part:GetPivot()
        local modelRotatation = part:GetPivot().Rotation
        part:PivotTo(modelCFrame * CFrame.Angles(0, math.rad(90)+modelRotatation.Y, 0) )
        --]]
    -- 4-WAY
    else
        part = passagePart:getRandomPassage("cWay"):Clone()
    end
    part.Parent = parent
    local modelCFrame = part:GetPivot()
    part:PivotTo(CFrame.new(x*size, size, y*size)*modelCFrame.Rotation)
end

local function generateDebugPart(parent, maze, x, y)
    local n = getNeighbours(maze, x, y)

    local partPosition = Vector3.new(x*size+size/3, -size, y*size+size/3)
    local partSize = Vector3.new(size/3, size, size/3)
    local partColor = Color3.new(x/width, y/height, 0)

    local debugPart = Instance.new("Part", parent)
    debugPart.Color = partColor
    debugPart.Name = getId(x,y).."("..x..","..y..")"
    debugPart.Anchored = true
    debugPart.Position = partPosition
    debugPart.Size=partSize
    if n.up then
        local sidePart = debugPart:Clone()
        sidePart.Parent = debugPart
        sidePart.Color = Color3.new(1, 0, 0)
        sidePart.Position = sidePart.Position+Vector3.zAxis*(size/3)
    end
    if n.down then
        local sidePart = debugPart:Clone()
        sidePart.Parent = debugPart
        sidePart.Color = Color3.new(0, 1, 0)
        sidePart.Position = sidePart.Position-Vector3.zAxis*(size/3)
    end
    if n.right then
        local sidePart = debugPart:Clone()
        sidePart.Parent = debugPart
        sidePart.Color = Color3.new(0, 0, 1)
        sidePart.Position = sidePart.Position-Vector3.xAxis*(size/3)
    end
    if n.left then
        local sidePart = debugPart:Clone()
        sidePart.Parent = debugPart
        sidePart.Color = Color3.new(1, 0, 1)
        sidePart.Position = sidePart.Position+Vector3.xAxis*(size/3)
    end
end

local function startGame()
    local Model = Instance.new("Model")
    Model.Parent = workspace
    local newMaze = maze:init(width, height)
    maze:carve(newMaze, width, height, 2, 2)
    newMaze[width + 2] = 0
    newMaze[(height - 2) * width + width - 3] = 0
    for y = 0, height - 1 do
        for x = 0, width - 1 do
            if newMaze[getId(x,y)] == 0 then
                local part = generateDebugPart(Model, newMaze, x, y)
                generatePart(Model, newMaze, x, y)
            end
        end
    end
end
startGame()

local min = 2
local sec = 00

while true do
    sec -= 1
    if min == 0 and sec == 0 then
        Text.Value = "Time to End: "
        break
    end
    if sec < 10 and sec >= 0 then
        sec = "0"..sec
    end
    
    CheckSec = tonumber(sec) --we need to check int, otherwise crash
    if  CheckSec < 0 then
        sec = 59
        min -=1
    end

    Time.Value = min..":"..sec --Update replicated timer value
    local DoOnce = false
        if not DoOnce then
            DoOnce = true
            Text.Value = "Time to Start: "
        end
    wait(1)
end

--Update local timer value
min = 15
sec = 00

while true do

    sec -= 1
    if min < 0 and sec < 0 then
        break
    end
    if sec < 10 and sec >= 0 then
        sec = "0"..sec
    end
    
    CheckSec = tonumber(sec)
    if  CheckSec < 0 then
        sec = 59
        min -=1
    end

    Time.Value = min..":"..sec --Update replicated timer value
    wait(1)
end