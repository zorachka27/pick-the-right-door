local RoomBuilder = {}

local Workspace = game:GetService("Workspace")

function RoomBuilder:CreateLobby()
	local lobby = Workspace:FindFirstChild("Lobby") or Instance.new("Folder")
lobby.Name = "Lobby"
	lobby.Parent = Workspace

	for _, child in ipairs(lobby:GetChildren()) do
		child:Destroy()
	end

	local base = Instance.new("Part")
	base.Name = "LobbyBase"
	base.Size = Vector3.new(200, 1, 200)
	base.Position = Vector3.new(0, 0, 0)
	base.Anchored = true
	base.Material = Enum.Material.SmoothPlastic
	base.Color = Color3.fromRGB(40, 46, 58)
	base.Parent = lobby

	local welcomeSign = Instance.new("Part")
	welcomeSign.Name = "WelcomeSign"
	welcomeSign.Size = Vector3.new(34, 10, 1)
	welcomeSign.Position = Vector3.new(0, 12, -18)
	welcomeSign.Anchored = true
	welcomeSign.Material = Enum.Material.SmoothPlastic
	welcomeSign.Color = Color3.fromRGB(90, 90, 90)
	welcomeSign.Parent = lobby

	local surfaceGui = Instance.new("SurfaceGui")
	surfaceGui.Face = Enum.NormalId.Front
	surfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
	surfaceGui.PixelsPerStud = 50
	surfaceGui.Parent = welcomeSign

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = "PICK THE RIGHT DOOR!"
	label.Font = Enum.Font.GothamBlack
	label.TextScaled = true
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.Parent = surfaceGui

	local shopArea = Instance.new("Part")
	shopArea.Name = "ShopArea"
	shopArea.Size = Vector3.new(18, 1, 12)
	shopArea.Position = Vector3.new(-50, 2, 0)
	shopArea.Anchored = true
	shopArea.Material = Enum.Material.Neon
	shopArea.Color = Color3.fromRGB(70, 150, 255)
	shopArea.Parent = lobby

	local rewardArea = Instance.new("Part")
	rewardArea.Name = "RewardArea"
	rewardArea.Size = Vector3.new(18, 1, 12)
	rewardArea.Position = Vector3.new(50, 2, 0)
	rewardArea.Anchored = true
	rewardArea.Material = Enum.Material.Neon
	rewardArea.Color = Color3.fromRGB(255, 175, 0)
	rewardArea.Parent = lobby

	local spectator = Instance.new("Part")
	spectator.Name = "SpectatorArea"
	spectator.Size = Vector3.new(30, 1, 20)
	spectator.Position = Vector3.new(0, 2, 35)
	spectator.Anchored = true
	spectator.Material = Enum.Material.SmoothPlastic
	spectator.Color = Color3.fromRGB(120, 120, 120)
	spectator.Parent = lobby

	return lobby
end

function RoomBuilder:CreateChallengeRoom(theme, roomName)
	local roomsFolder = Workspace:FindFirstChild("ChallengeRooms") or Instance.new("Folder")
	roomsFolder.Name = "ChallengeRooms"
	roomsFolder.Parent = Workspace

	local room = roomsFolder:FindFirstChild(roomName) or Instance.new("Model")
	room.Name = roomName
	room.Parent = roomsFolder
	for _, child in ipairs(room:GetChildren()) do
		child:Destroy()
	end

	local themeConfig = require(script.Parent.GameConfig).RoomThemes[theme]
	local baseColor = themeConfig and themeConfig.Color or Color3.fromRGB(100, 100, 100)

	local floor = Instance.new("Part")
	floor.Name = "Floor"
	floor.Size = Vector3.new(120, 1, 120)
	floor.Position = Vector3.new(0, 0, 0)
	floor.Anchored = true
	floor.Material = Enum.Material.Slate
	floor.Color = baseColor
	floor.Parent = room

	local centerPad = Instance.new("Part")
	centerPad.Name = "CenterPad"
	centerPad.Size = Vector3.new(12, 1, 12)
	centerPad.Position = Vector3.new(0, 1, 0)
	centerPad.Anchored = true
	centerPad.Material = Enum.Material.Neon
	centerPad.Color = Color3.fromRGB(255, 255, 255)
	centerPad.Parent = room

	for _, wallData in ipairs({
		{Vector3.new(0, 6, 60), Vector3.new(120, 12, 1)},
		{Vector3.new(0, 6, -60), Vector3.new(120, 12, 1)},
		{Vector3.new(60, 6, 0), Vector3.new(1, 12, 120)},
		{Vector3.new(-60, 6, 0), Vector3.new(1, 12, 120)},
	}) do
		local wall = Instance.new("Part")
		wall.Name = "Wall"
		wall.Size = wallData[2]
		wall.Position = wallData[1]
		wall.Anchored = true
		wall.Material = Enum.Material.SmoothPlastic
		wall.Color = baseColor:Lerp(Color3.new(1, 1, 1), 0.15)
		wall.Parent = room
	end

	room.PrimaryPart = floor
	return room
end

function RoomBuilder:CreateDoors(room, doorCount, safeIndex, onDoorSelected)
	local doorFolder = room:FindFirstChild("Doors") or Instance.new("Folder")
	doorFolder.Name = "Doors"
	doorFolder.Parent = room

	for _, child in ipairs(doorFolder:GetChildren()) do
		child:Destroy()
	end

	local doors = {}
	local totalWidth = (doorCount - 1) * 12
	local startX = -totalWidth / 2

	for i = 1, doorCount do
		local xPos = startX + (i - 1) * 12
		local position = room.PrimaryPart.Position + Vector3.new(xPos, 4, 0)

		local door = Instance.new("Part")
		door.Name = "Door_" .. i
		door.Anchored = true
		door.Size = Vector3.new(6, 7, 1)
		door.Position = position
		door.Material = Enum.Material.WoodPlanks
		door.Color = i == safeIndex and Color3.fromRGB(110, 230, 120) or Color3.fromRGB(150, 150, 150)
		door.Parent = doorFolder
		door:SetAttribute("IsSafe", i == safeIndex)
		door:SetAttribute("DoorIndex", i)

		local sign = Instance.new("Part")
		sign.Name = "DoorSign"
		sign.Anchored = true
		sign.Size = Vector3.new(4.5, 1.5, 0.2)
		sign.Position = position + Vector3.new(0, 2.5, 0.8)
		sign.Material = Enum.Material.SmoothPlastic
		sign.Color = i == safeIndex and Color3.fromRGB(80, 180, 90) or Color3.fromRGB(200, 80, 80)
		sign.Parent = doorFolder

		local gui = Instance.new("SurfaceGui")
		gui.Face = Enum.NormalId.Front
		gui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
		gui.PixelsPerStud = 50
		gui.Parent = sign

		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(1, 0, 1, 0)
		label.BackgroundTransparency = 1
		label.Text = i == safeIndex and "SAFE" or "TRAP"
		label.TextScaled = true
		label.Font = Enum.Font.GothamBlack
		label.TextColor3 = Color3.fromRGB(255,255,255)
		label.Parent = gui

		local clickDetector = Instance.new("ClickDetector")
		clickDetector.Parent = door
		clickDetector.MouseClick:Connect(function(player)
			if onDoorSelected then
				onDoorSelected(player, i, door)
			end
		end)

		doors[#doors + 1] = door
	end

	return doors
end

return RoomBuilder
