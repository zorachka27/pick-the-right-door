local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local GameConfig = require(script.Parent.GameConfig)
local DoorFactory = require(script.Parent.DoorFactory)
local TrapLibrary = require(script.Parent.TrapLibrary)

local RoundManager = {}
RoundManager.__index = RoundManager

function RoundManager.new()
	local self = setmetatable({}, RoundManager)
	self.CurrentRound = 0
	self.IntermissionActive = false
	self.RoomFolder = Workspace:FindFirstChild("ChallengeRooms") or Instance.new("Folder")
	self.RoomFolder.Name = "ChallengeRooms"
	self.RoomFolder.Parent = Workspace
	self.LobbyFolder = Workspace:FindFirstChild("Lobby") or Instance.new("Folder")
	self.LobbyFolder.Name = "Lobby"
	self.LobbyFolder.Parent = Workspace
	self.PlayerData = {}
	self.Remotes = ReplicatedStorage:FindFirstChild("Remotes") or Instance.new("Folder")
	self.Remotes.Name = "Remotes"
	self.Remotes.Parent = ReplicatedStorage
	self.RoundStartRemote = self.Remotes:FindFirstChild("RoundStart") or Instance.new("RemoteEvent")
	self.RoundStartRemote.Name = "RoundStart"
	self.RoundStartRemote.Parent = self.Remotes
	self.ChooseDoorRemote = self.Remotes:FindFirstChild("ChooseDoor") or Instance.new("RemoteEvent")
	self.ChooseDoorRemote.Name = "ChooseDoor"
	self.ChooseDoorRemote.Parent = self.Remotes
	self.RoundStateRemote = self.Remotes:FindFirstChild("RoundState") or Instance.new("RemoteEvent")
	self.RoundStateRemote.Name = "RoundState"
	self.RoundStateRemote.Parent = self.Remotes
	self.ChoiceReceived = {}
	self.ActiveDoors = {}
	self.LobbyBuilt = false
	self:BuildLobby()
	self:ConnectClientEvents()
	return self
end

function RoundManager:BuildLobby()
	if self.LobbyBuilt then
		return
	end

	local base = Instance.new("Part")
	base.Name = "LobbyBase"
	base.Size = Vector3.new(200, 1, 200)
	base.Position = Vector3.new(0, 0, 0)
	base.Anchored = true
	base.Material = Enum.Material.SmoothPlastic
	base.Color = Color3.fromRGB(38, 45, 55)
	base.Parent = self.LobbyFolder

	local sign = Instance.new("Part")
	sign.Name = "Sign"
	sign.Size = Vector3.new(30, 10, 1)
	sign.Position = Vector3.new(0, 12, -18)
	sign.Anchored = true
	sign.Material = Enum.Material.SmoothPlastic
	sign.Color = Color3.fromRGB(80, 80, 80)
	sign.Parent = self.LobbyFolder

	local gui = Instance.new("SurfaceGui")
	gui.Face = Enum.NormalId.Front
	gui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
	gui.PixelsPerStud = 50
	gui.Parent = sign

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = "PICK THE RIGHT DOOR!"
	label.TextScaled = true
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.Font = Enum.Font.GothamBlack
	label.Parent = gui

	for _, player in ipairs(Players:GetPlayers()) do
		if player.Character then
			player.Character:PivotTo(CFrame.new(GameConfig.LobbySpawn))
		end
	end

	self.LobbyBuilt = true
end

function RoundManager:ConnectClientEvents()
	self.ChooseDoorRemote.OnServerEvent:Connect(function(player, doorName)
		if not self.ActiveRound or self.ActiveRound.Status ~= "Choosing" then
			return
		end

		if self.ActiveRound.Selections[player.UserId] then
			return
		end

		local doorIndex = tonumber(string.match(doorName or "", "(%d+)$")) or 0
		self.ActiveRound.Selections[player.UserId] = doorIndex
		self.RoundStateRemote:FireClient(player, "ChoiceLocked", doorIndex)
	end)
end

function RoundManager:GetRoundSettings(round)
	local doorCount = math.min(GameConfig.MinDoors + math.floor(round / 3), GameConfig.MaxDoors)
	local timer = math.max(GameConfig.TimerFloor, GameConfig.BaseDecisionTimer - (round - 1) * GameConfig.TimerReductionPerRound)
	return doorCount, timer
end

function RoundManager:CreateRoom(theme)
	local roomFolder = self.RoomFolder:FindFirstChild(theme) or Instance.new("Model")
	roomFolder.Name = theme
	roomFolder.Parent = self.RoomFolder

	for _, part in ipairs(roomFolder:GetChildren()) do
		part:Destroy()
	end

	local floor = Instance.new("Part")
	floor.Name = "Floor"
	floor.Size = Vector3.new(120, 1, 120)
	floor.Position = Vector3.new(0, 0, 0)
	floor.Anchored = true
	floor.Material = Enum.Material.Slate
	floor.Color = Color3.fromRGB(70, 80, 90)
	floor.Parent = roomFolder

	local center = Instance.new("Part")
	center.Name = "CenterPad"
	center.Size = Vector3.new(10, 1, 10)
	center.Position = Vector3.new(0, 1, 0)
	center.Anchored = true
	center.Material = Enum.Material.Neon
	center.Color = Color3.fromRGB(95, 95, 95)
	center.Parent = roomFolder

	local roomThemeColor = {
		Castle = Color3.fromRGB(120, 90, 60),
		Volcano = Color3.fromRGB(180, 70, 40),
		Laboratory = Color3.fromRGB(60, 110, 180),
		Underwater = Color3.fromRGB(35, 110, 160),
		Carnival = Color3.fromRGB(200, 100, 160),
		Alien = Color3.fromRGB(70, 180, 120),
		Space = Color3.fromRGB(30, 30, 60),
	}[theme] or Color3.fromRGB(120, 120, 120)

	for i = -1, 1 do
		local wall = Instance.new("Part")
		wall.Name = "Wall"
		wall.Size = Vector3.new(120, 12, 1)
		wall.Position = Vector3.new(0, 6, 58 * i)
		wall.Anchored = true
		wall.Material = Enum.Material.SmoothPlastic
		wall.Color = roomThemeColor
		wall.Parent = roomFolder
	end

	for i = -1, 1 do
		local wall = Instance.new("Part")
		wall.Name = "Wall"
		wall.Size = Vector3.new(1, 12, 120)
		wall.Position = Vector3.new(58 * i, 6, 0)
		wall.Anchored = true
		wall.Material = Enum.Material.SmoothPlastic
		wall.Color = roomThemeColor
		wall.Parent = roomFolder
	end

	roomFolder.PrimaryPart = floor
	return roomFolder
end

function RoundManager:TeleportPlayersToRoom(room)
	local spawnPositions = {}
	for i, player in ipairs(Players:GetPlayers()) do
		if player.Character then
			local pos = Vector3.new((i - 1) * 8, 5, 5)
			spawnPositions[player.UserId] = pos
			player.Character:PivotTo(CFrame.new(pos + room:GetPivot().Position))
		end
	end
	return spawnPositions
end

function RoundManager:StartIntermission()
	self.IntermissionActive = true
	self.CurrentRound += 1
	self.RoundStartRemote:FireAllClients("Intermission", self.CurrentRound)
	for i = GameConfig.IntermissionDuration, 1, -1 do
		self.RoundStateRemote:FireAllClients("Countdown", i)
		if i <= 0 then
			break
		end
		task.wait(1)
	end
	self.IntermissionActive = false
	self:StartRound()
end

function RoundManager:StartRound()
	local themePool = GameConfig.RoomThemes
	local theme = themePool[math.random(1, #themePool)]
	local room = self:CreateRoom(theme)
	local doorCount, timer = self:GetRoundSettings(self.CurrentRound)
	local safeIndex = math.random(1, doorCount)

	self.ActiveRound = {
		Theme = theme,
		DoorCount = doorCount,
		Timer = timer,
		Status = "Choosing",
		SafeIndex = safeIndex,
		Selections = {},
		Room = room,
	}

	self:TeleportPlayersToRoom(room)
	self.RoundStartRemote:FireAllClients("RoundStart", { theme = theme, round = self.CurrentRound, timer = timer })
	self.ActiveDoors = DoorFactory:CreateDoors(room, doorCount, safeIndex, function(player, doorModel)
		if self.ActiveRound and self.ActiveRound.Status == "Choosing" then
			self.ChooseDoorRemote:FireClient(player, "DoorPicked", doorModel.Name)
			self.ActiveRound.Selections[player.UserId] = tonumber(string.match(doorModel.Name, "(%d+)$"))
		end
	end)

	for countdown = timer, 1, -1 do
		if not self.ActiveRound or self.ActiveRound.Status ~= "Choosing" then
			return
		end
		self.RoundStateRemote:FireAllClients("Timer", countdown)
		task.wait(1)
	end

	self:ResolveRound()
end

function RoundManager:ResolveRound()
	if not self.ActiveRound then
		return
	end

	self.ActiveRound.Status = "Resolving"
	local survivors = {}
	for _, player in ipairs(Players:GetPlayers()) do
		local selectedDoor = self.ActiveRound.Selections[player.UserId]
		if selectedDoor == self.ActiveRound.SafeIndex then
			survivors[#survivors + 1] = player
		else
			local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				local trapName = TrapLibrary:GetRandomTrap(self.ActiveRound.Theme)
				TrapLibrary:TriggerTrap(player, trapName, self.ActiveRound.Room)
			end
		end
	end

	if #survivors > 0 then
		for _, player in ipairs(survivors) do
			local coins = GameConfig.Rewards.SurviveRound + math.floor(self.CurrentRound * 1.5)
			local leaderstats = player:FindFirstChild("leaderstats")
			if not leaderstats then
				leaderstats = Instance.new("Folder")
				leaderstats.Name = "leaderstats"
				leaderstats.Parent = player
			end
			local coinsValue = leaderstats:FindFirstChild("Coins") or Instance.new("IntValue")
			coinsValue.Name = "Coins"
			coinsValue.Value += coins
			coinsValue.Parent = leaderstats
		end
		self.RoundStateRemote:FireAllClients("RoundResult", { survivors = #survivors, safeDoor = self.ActiveRound.SafeIndex })
	else
		self.RoundStateRemote:FireAllClients("RoundResult", { survivors = 0, safeDoor = self.ActiveRound.SafeIndex })
	end

	task.wait(3)
	self.ActiveRound = nil
	self:StartIntermission()
end

return RoundManager
