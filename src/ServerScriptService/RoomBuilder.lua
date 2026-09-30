local RoomBuilder = {}

local Workspace = game:GetService("Workspace")
local ShopSystem = require(script.Parent.ShopSystem)
local SpecialEvents = require(script.Parent.SpecialEvents)

local function createBillboard(parent, size, position, title, body)
	local part = Instance.new("Part")
	part.Name = title .. "Board"
	part.Anchored = true
	part.Size = size
	part.Position = position
	part.Material = Enum.Material.SmoothPlastic
	part.Color = Color3.fromRGB(35, 40, 50)
	part.Parent = parent

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "Info"
	billboard.Size = UDim2.new(0, 260, 0, 120)
	billboard.StudsOffset = Vector3.new(0, 2, 0)
	billboard.Adornee = part
	billboard.Parent = part

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = title .. "\n" .. body
	label.TextScaled = true
	label.Font = Enum.Font.GothamBold
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextWrapped = true
	label.Parent = billboard

	return part
end

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

	local sign = Instance.new("Part")
	sign.Name = "WelcomeSign"
	sign.Size = Vector3.new(34, 10, 1)
	sign.Position = Vector3.new(0, 12, -18)
	sign.Anchored = true
	sign.Material = Enum.Material.SmoothPlastic
	sign.Color = Color3.fromRGB(90, 90, 90)
	sign.Parent = lobby

	local surfaceGui = Instance.new("SurfaceGui")
	surfaceGui.Face = Enum.NormalId.Front
	surfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
	surfaceGui.PixelsPerStud = 50
	surfaceGui.Parent = sign

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = "PICK THE RIGHT DOOR!"
	label.Font = Enum.Font.GothamBlack
	label.TextScaled = true
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.Parent = surfaceGui

	local coinPad = Instance.new("Part")
	coinPad.Name = "CoinDisplayPad"
	coinPad.Size = Vector3.new(18, 1, 12)
	coinPad.Position = Vector3.new(-52, 2, -20)
	coinPad.Anchored = true
	coinPad.Material = Enum.Material.Neon
	coinPad.Color = Color3.fromRGB(255, 190, 60)
	coinPad.Parent = lobby
	createBillboard(lobby, Vector3.new(6, 2, 1), coinPad.Position + Vector3.new(0, 3, 0), "Coins", "Spend and win more!")

	local winsPad = Instance.new("Part")
	winsPad.Name = "WinsLeaderboardPad"
	winsPad.Size = Vector3.new(18, 1, 12)
	winsPad.Position = Vector3.new(52, 2, -20)
	winsPad.Anchored = true
	winsPad.Material = Enum.Material.Neon
	winsPad.Color = Color3.fromRGB(105, 255, 150)
	winsPad.Parent = lobby
	createBillboard(lobby, Vector3.new(6, 2, 1), winsPad.Position + Vector3.new(0, 3, 0), "Most Wins", "Top players")

	local roundPad = Instance.new("Part")
	roundPad.Name = "RoundLeaderboardPad"
	roundPad.Size = Vector3.new(18, 1, 12)
	roundPad.Position = Vector3.new(-52, 2, 20)
	roundPad.Anchored = true
	roundPad.Material = Enum.Material.Neon
	roundPad.Color = Color3.fromRGB(140, 120, 255)
	roundPad.Parent = lobby
	createBillboard(lobby, Vector3.new(6, 2, 1), roundPad.Position + Vector3.new(0, 3, 0), "Highest Round", "How far you survived")

	local shopPad = Instance.new("Part")
	shopPad.Name = "ShopPad"
	shopPad.Size = Vector3.new(18, 1, 12)
	shopPad.Position = Vector3.new(52, 2, 20)
	shopPad.Anchored = true
	shopPad.Material = Enum.Material.Neon
	shopPad.Color = Color3.fromRGB(70, 150, 255)
	shopPad.Parent = lobby
	createBillboard(lobby, Vector3.new(6, 2, 1), shopPad.Position + Vector3.new(0, 3, 0), "Shop", "Skins, trails, effects")

	local spectatorPad = Instance.new("Part")
	spectatorPad.Name = "SpectatorArea"
	spectatorPad.Size = Vector3.new(30, 1, 20)
	spectatorPad.Position = Vector3.new(0, 2, 35)
	spectatorPad.Anchored = true
	spectatorPad.Material = Enum.Material.SmoothPlastic
	spectatorPad.Color = Color3.fromRGB(120, 120, 120)
	spectatorPad.Parent = lobby
	createBillboard(lobby, Vector3.new(8, 2, 1), spectatorPad.Position + Vector3.new(0, 3, 0), "Spectators", "Watch the next round")

	local npc = Instance.new("Model")
	npc.Name = "GuideNPC"
	local torso = Instance.new("Part")
	torso.Name = "Torso"
	torso.Size = Vector3.new(2, 3, 1)
	torso.Position = Vector3.new(0, 4, -8)
	torso.Anchored = true
	torso.Parent = npc
	local head = Instance.new("Part")
	head.Name = "Head"
	head.Size = Vector3.new(2, 2, 2)
	head.Position = Vector3.new(0, 7, -8)
	head.Anchored = true
	head.Parent = npc
	local hint = Instance.new("Part")
	hint.Name = "HintBoard"
	hint.Size = Vector3.new(6, 2, 0.5)
	hint.Position = Vector3.new(0, 9, -8)
	hint.Anchored = true
	hint.Parent = npc
	local hintGui = Instance.new("SurfaceGui")
	hintGui.Face = Enum.NormalId.Front
	hintGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
	hintGui.PixelsPerStud = 30
	hintGui.Parent = hint
	local hintLabel = Instance.new("TextLabel")
	hintLabel.Size = UDim2.new(1, 0, 1, 0)
	hintLabel.BackgroundTransparency = 1
	hintLabel.Text = "Choose wisely!"
	hintLabel.Font = Enum.Font.GothamBold
	hintLabel.TextScaled = true
	hintLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	hintLabel.Parent = hintGui
	npc.Parent = lobby

	ShopSystem:Build(lobby)
	SpecialEvents:Build(lobby)

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

	if theme == "Castle" then
		for _, torchPos in ipairs({Vector3.new(-40, 6, 40), Vector3.new(40, 6, 40), Vector3.new(-40, 6, -40), Vector3.new(40, 6, -40)}) do
			local torch = Instance.new("Part")
			torch.Name = "Torch"
			torch.Size = Vector3.new(1, 4, 1)
			torch.Position = torchPos
			torch.Anchored = true
			torch.Material = Enum.Material.Metal
			torch.Color = Color3.fromRGB(120, 70, 10)
			torch.Parent = room
		end
	elseif theme == "Volcano" then
		for _, lavaPos in ipairs({Vector3.new(-35, 1, 0), Vector3.new(35, 1, 0), Vector3.new(0, 1, -35), Vector3.new(0, 1, 35)}) do
			local lava = Instance.new("Part")
			lava.Name = "LavaPatch"
			lava.Size = Vector3.new(12, 1, 12)
			lava.Position = lavaPos
			lava.Anchored = true
			lava.Material = Enum.Material.Neon
			lava.Color = Color3.fromRGB(255, 90, 20)
			lava.Parent = room
		end
	elseif theme == "Laboratory" then
		for _, machinePos in ipairs({Vector3.new(-20, 3, 0), Vector3.new(20, 3, 0), Vector3.new(0, 3, -20), Vector3.new(0, 3, 20)}) do
			local machine = Instance.new("Part")
			machine.Name = "Machine"
			machine.Size = Vector3.new(5, 5, 5)
			machine.Position = machinePos
			machine.Anchored = true
			machine.Material = Enum.Material.SmoothPlastic
			machine.Color = Color3.fromRGB(90, 90, 110)
			machine.Parent = room
		end
	elseif theme == "Underwater" then
		for _, bubblePos in ipairs({Vector3.new(-30, 4, 0), Vector3.new(30, 4, 0), Vector3.new(0, 4, -30), Vector3.new(0, 4, 30)}) do
			local bubble = Instance.new("Part")
			bubble.Name = "Bubble"
			bubble.Size = Vector3.new(2, 2, 2)
			bubble.Position = bubblePos
			bubble.Anchored = true
			bubble.Material = Enum.Material.Neon
			bubble.Color = Color3.fromRGB(120, 210, 255)
			bubble.Parent = room
		end
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
		label.TextColor3 = Color3.fromRGB(255, 255, 255)
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
