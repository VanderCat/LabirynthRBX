local Players = game:GetService("Players")

local function leaderboardSetup(player)
	local leaderstats = Instance.new("Folder", player)
	leaderstats.Name = "leaderstats"

	local maze = Instance.new("IntValue", leaderstats)
	maze.Name = "Maze Completed"
	maze.Value = 0
end

Players.PlayerAdded:Connect(leaderboardSetup)