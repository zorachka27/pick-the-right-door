local SpecialEvents = {}

local function createEventBoard(parent, name, position)
	local board = Instance.new("Part")
	board.Name = name
	board.Size = Vector3.new(16, 2, 1)
	board.Position = position
	board.Anchored = true
	board.Material = Enum.Material.SmoothPlastic
	board.Color = Color3.fromRGB(70, 80, 80)
	board.Parent = parent

	local gui = Instance.new("SurfaceGui")
	gui.Face = Enum.NormalId.Front
	gui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
	gui.PixelsPerStud = 40
	gui.Parent = board

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = name
	label.Font = Enum.Font.GothamBold
	label.TextScaled = true
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.Parent = gui

	return board
end

function SpecialEvents:Build(lobby)
	local eventFolder = lobby:FindFirstChild("SpecialEvents") or Instance.new("Folder")
	eventFolder.Name = "SpecialEvents"
	eventFolder.Parent = lobby
	for _, child in ipairs(eventFolder:GetChildren()) do
		child:Destroy()
	end

	local base = Instance.new("Part")
	base.Name = "EventBase"
	base.Size = Vector3.new(45, 1, 14)
	base.Position = Vector3.new(0, 2, 18)
	base.Anchored = true
	base.Material = Enum.Material.SmoothPlastic
	base.Color = Color3.fromRGB(32, 32, 38)
	base.Parent = eventFolder

	local title = createEventBoard(eventFolder, "SPECIAL EVENTS", Vector3.new(0, 8, 18))
	local events = {
		"Double Coins Weekend",
		"Chaos Mode",
		"10 Door Challenge",
		"Admin Mayhem",
	}
	for i, eventName in ipairs(events) do
		local pos = Vector3.new(-16 + ((i - 1) % 2) * 16, 5.5 - (math.floor((i - 1) / 2) * 2), 18)
		createEventBoard(eventFolder, eventName, pos)
	end

	return eventFolder
end

return SpecialEvents
