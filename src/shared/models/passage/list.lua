local rs = game:GetService("ReplicatedStorage")
local passage = rs.Common.models.passage
local models = {
    nWay = {passage.nWay_a, passage.nWay_b},
    nWayF = {passage.nWayF_a, passage.nWayF_b},
    rWay = {passage.rWay_a, passage.rWay_b},
    rWayF = {passage.rWayF_a},
    rWayFR = {passage.rWayRF_a},
    rWayR = {passage.rWayR_a},
    tWay = {passage.tWay_a},
    tWayF = {passage.tWayF_a},
    tWayR = {passage.tWayR_a},
    tWayRF = {passage.tWayRF_a},
    way = {passage.way_a,passage.way_b,passage.way_c,passage.way_d},
    cWay = {passage.cWay_a},
}

function models:getRandomPassage(name:string)
    local variants = models[name]
    local id = math.random(1, #variants)
    return variants[id]
end

return models