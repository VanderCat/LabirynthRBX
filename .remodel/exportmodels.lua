print(args[1])
local game = remodel.readPlaceFile(args)

-- If the directory does not exist yet, we'll create it.
remodel.createDirAll("models")

local Models = game.ReplicatedStorage

for _, model in ipairs(Models:GetChildren()) do
	-- Save out each child as an rbxmx model
	remodel.writeModelFile("models/" .. model.Name .. ".rbxmx", model)
end