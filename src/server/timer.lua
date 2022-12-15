local http = game:GetService("HttpService")
local shared = game:GetService("ReplicatedStorage")

local timer = {}
timer.__index = timer -- OOP

---Internal. Do NOT use
function timer._createFolder()
    local timers = Instance.new("Folder", shared)
    timers.Name = "Timers"
    return timers
end

function timer:init(seconds:number)
    local uuid = http:GenerateGUID()
    local result = {
        startTime = seconds,
        time = seconds,
        uuid = uuid
    }
    setmetatable(result, self)

    local timers = shared.Timers
    if not shared.Timers then
        timers = timer._createFolder()
    end

    local stringValue = Instance.new("StringValue", timers)

    return result
end

function timer:update(dt)
    self.time = self.time-dt
end

function timer.inject(timer)
    local rs = game:GetService("RunService")
    rs.Heartbeat:Connect(function(_, dt)
        timer:update(dt)
    end)
end

function timer:__tostring()
    local mins = math.floor(self.time/60)
    local seconds = self.time%60
    return mins..":"..seconds
end

return timer

--[[
    I actually would continue work on it  but i don't know when. I don't think hypecomplex
    and non hardcorde timer is necessary atm.
]]