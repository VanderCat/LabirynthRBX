local game = remodel.readPlaceFile("temp/models.rbxl")

-- If the directory does not exist yet, we'll create it.
remodel.createDirAll("src/shared/models/passage")

local Models = game.Workspace.devParts

for _, model in ipairs(Models:GetChildren()) do
	-- Save out each child as an rbxmx model
	remodel.writeModelFile("src/shared/models/passage/" .. model.Name .. ".rbxmx", model)
end