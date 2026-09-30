local DoorFactory = {}

local function createDoorModel(position, name, isSafe, trapName, callback)
	local model = Instance.new("Model")
	model.Name = name
	model:SetAttribute("IsSafe", isSafe)
	model:SetAttribute("TrapName", trapName)
	model:SetAttribute("DoorIndex", tonumber(string.split(name, "_")[2]))

	local frame = Instance.new("Part")
	frame.Name = "DoorFrame"
	frame.Size = Vector3.new(6, 8, 1)
	frame.Position = position
	frame.Anchored = true
	frame.Material = Enum.Material.WoodPlanks
	frame.Color = isSafe and Color3.fromRGB(120, 255, 120) or Color3.fromRGB(150, 150, 150)
	frame.Parent = model

	local sign = Instance.new("Part")
	sign.Name = "DoorSign"
	sign.Size = Vector3.new(4.5, 1.5, 0.2)
	sign.Position = position + Vector3.new(0, 1.5, 0.6)
	sign.Anchored = true
	sign.Material = Enum.Material.SmoothPlastic
	sign.Color = isSafe and Color3.fromRGB(80, 200, 80) or Color3.fromRGB(220, 90, 90)
	sign.Parent = model

	local surfaceGui = Instance.new("SurfaceGui")
	surfaceGui.Face = Enum.NormalId.Front
	surfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
	surfaceGui.PixelsPerStud = 50
	surfaceGui.Parent = sign

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = isSafe and "SAFE" or trapName
	label.TextScaled = true
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Font = Enum.Font.GothamBold
	label.Parent = surfaceGui

	local clickDetector = Instance.new("ClickDetector")
	clickDetector.Parent = frame
	clickDetector.MouseClick:Connect(function(player)
		if callback then
			callback(player, model)
		end
	end)

	model.Parent = workspace:FindFirstChild("ChallengeDoors") or workspace
	return model
end

function DoorFactory:CreateDoors(roomFolder, doorCount, safeIndex, callback)
	local container = workspace:FindFirstChild("ChallengeDoors")
	if not container then
		container = Instance.new("Folder")
		container.Name = "ChallengeDoors"
		container.Parent = workspace
	end

	for _, child in ipairs(container:GetChildren()) do
		child:Destroy()
	end

	local doors = {}
	local half = (doorCount - 1) / 2
	for i = 1, doorCount do
		local offset = (i - (half + 1)) * 12
		local position = roomFolder and roomFolder.PrimaryPart and roomFolder.PrimaryPart.Position + Vector3.new(offset, 0, 0)
		if not position then
			position = Vector3.new(offset, 5, 0)
		end

		local trapName = "Trap " .. i
		local isSafe = i == safeIndex
		if not isSafe then
			trapName = "Random Trap"
		end

		local door = createDoorModel(position, "Door_" .. i, isSafe, trapName, callback)
		doors[#doors + 1] = door
	end

	return doors
end

return DoorFactory
