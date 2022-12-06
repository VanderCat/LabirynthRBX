local maze = {}

function maze:init(width, height)
    local result = {}
    for y = 0, height - 1 do
        for x = 0, width - 1 do
            result[y * width + x] = 1
        end
        result[y * width + 0] = 0
        result[y * width + width - 1] = 0
    end
    for x = 0, width - 1 do
        result[0 * width + x] = 0
        result[(height - 1) * width + x] = 0
    end
    return result
end

-- Carve the maze starting at x, y.
function maze:carve(maze, width, height, x, y)
    local r = math.random(0, 3)
    maze[y * width + x] = 0
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
        if maze[ny * width + nx] == 1 then
            if maze[ny2 * width + nx2] == 1 then
                maze[ny * width + nx] = 0
                self:carve(maze, width, height, nx2, ny2)
            end
        end
    end
end

return maze