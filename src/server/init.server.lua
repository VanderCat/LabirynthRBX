local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local rs = game:GetService("ReplicatedStorage")

local maze = require(ServerScriptService.Server.mazegen)
local passagePart = require(rs.Common.models.passage.list)

local Time = game.ReplicatedStorage.TimerValue
local Text = game.ReplicatedStorage.TimerText

local size = 16
---Generate random part according to model list
---@param parent Instance
---@param maze any
---@param x number
---@param y number
local function generatePart(parent: Instance, maze, x:number, y:number)
    local n = maze:getNeighbours(x, y)
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
        part:PivotTo(modelCFrame * CFrame.Angles(0, math.rad(90)+modelRotatation.Y, 0) ) --i think i also need to keep all other rotattions. not sure
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
---Generate debug parts
---Buggy and not optimized. Do NOT use in production.
---@param parent Instance
---@param maze any
---@param x number
---@param y number
local function generateDebugPart(parent:Instance, maze, x:number, y:number)
    local n = maze:getNeighbours(x, y)

    local partPosition = Vector3.new(x*size+size/3, -size, y*size+size/3)
    local partSize = Vector3.new(size/3, size, size/3)
    local partColor = Color3.new(x/maze.width, y/maze.height, 0)

    local debugPart = Instance.new("Part", parent)
    debugPart.Color = partColor
    debugPart.Name = maze:getId(x,y).."("..x..","..y..")"
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

local function startGame(width, height)
    local Model = Instance.new("Model")
    Model.Name = "Labirynth"
    Model.Parent = workspace
    local newMaze = maze:init(width, height)
    newMaze:carve(2, 2)
    newMaze[newMaze:getId(2,1)] = 0
    newMaze[newMaze:getId(width-3,height-2)] = 0
    print(newMaze)
    for y = 1, height - 2 do
        for x = 1, width - 2 do
            if newMaze[newMaze:getId(x,y)] == 0 then
                generatePart(Model, newMaze, x, y)
                --generateDebugPart(Model, newMaze, x, y)
            end
        end
    end
end

local width, height = 31, 31
--startGame(width, height)

--TODO: make a better timer system.
local function onPreparationEnded()
    Text.Value = "Time to End: "
    startGame(width, height)
end
local function onGameEnded()
    workspace.Labirynth:Destroy()
end
local function onGameLastMinutes()
    print("Neurotoxin should be activated")
end

local preparationEnded = false
local function restartTimers()
    Text.Value = "Time to Start: "
    local min = 0
    local sec = 10
    while true do
        sec -= 1
        if min <= 0 and sec <= 0 then
            onPreparationEnded()
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

        wait(1)
    end
    
    --Update local timer value
    min = 15 -- i would just endup with seconds and then convert them to minutes tbh but whatever
    sec = 00 -- TODO: acrtually make it seconds based
    
    local lastMinutes = min/5
    local lastSeconds = (lastMinutes%1)*60
    while true do
    
        sec -= 1
        if min <= 0 and sec <= 0 then
            onGameEnded()
            break
        end
        if min < lastMinutes and sec <= lastSeconds then
            onGameLastMinutes()
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
end

while true do
    restartTimers() -- to avoid stackoverflow
end