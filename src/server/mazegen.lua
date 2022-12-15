local maze = {}
maze.__index = maze

function maze:getId(x, y)
    return y*self.width+x
end

function maze:getNeighbours(x, y)
    return {
        up = self[self:getId(x,y+1)]==0,
        down = self[self:getId(x,y-1)]==0,
        left = self[self:getId(x+1,y)]==0,
        right = self[self:getId(x-1,y)]==0,
    }
end

function maze:generateBounds()
    for y = 0, self.height - 1 do
        for x = 0, self.width - 1 do
            self[self:getId(x, y)] = 1
        end
        --self[y * self.width] = 0
        --self[y * self.width + self.width - 1] = 0
        self[self:getId(0, y)] = 0
        self[self:getId(self.width-1, y)] = 0
    end
    for x = 0, self.width - 1 do
        --self[0 * self.width + x] = 0
        --self[(self.height - 1) * self.width + x] = 0
        self[self:getId(x, 0)] = 0
        self[self:getId(x, self.height - 1)] = 0
    end
end

function maze:init(width, height)
    local result = {width=width, height=height}
    setmetatable(result, self)
    result:generateBounds()
    return result
end

-- Carve the maze starting at x, y.
function maze:carve(x, y)
    local r = math.random(0, 3)
    self[self:getId(x,y)] = 0
    for i = 0, 3 do
        local d = (i + r) % 4
        local dx = 0
        local dy = 0
        if d == 0 then
            dx = 1
        elseif d == 1 then
            dx = -1
        elseif d == 2 then
            dy = 1
        else
            dy = -1
        end
        local nx = x + dx
        local ny = y + dy
        local nx2 = nx + dx
        local ny2 = ny + dy
        if self[self:getId(nx,ny)] == 1 then
            if self[self:getId(nx2,ny2)] == 1 then
                self[self:getId(nx,ny)] = 0
                self:carve(nx2, ny2)
            end
        end
    end
end

function maze:__tostring()
    local string = "\n"
    for y = self.height - 1, 0, -1 do
        for x = self.width - 1, 0, -1  do
            if self[self:getId(x, y)] == 0 then
                string=string.."[]"
            else
                string=string.."  "
            end
        end
        string=string.."\n"
    end
    return string
end

return maze