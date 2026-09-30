local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Config = require(script.Parent.GameConfig)
local RoomBuilder = require(script.Parent.RoomBuilder)
local PrizeSystem = require(script.Parent.PrizeSystem)
local AdminSystem = require(script.Parent.AdminSystem)
local TrapEffects = require(script.Parent.TrapEffects)
local WorldManager = require(script.Parent.WorldManager)

local RoundManager = {}
RoundManager.__index = RoundManager

function RoundManager.new()
	local self = setmetatable({}, RoundManager)
	self.CurrentRound = 0
	self.ActiveRound = nil
	self.Lobby = nil
	self.RoomsFolder = Workspace:FindFirstChild("ChallengeRooms") or Instance.new("Folder")
	self.RoomsFolder.Name = "ChallengeRooms"
	self.RoomsFolder.Parent = Workspace
	self.Remotes = ReplicatedStorage:FindFirstChild("Remotes") or Instance.new("Folder")
	self.Remotes.Name = "Remotes"
	self.Remotes.Parent = ReplicatedStorage
	self.RoundStateRemote = self.Remotes:FindFirstChild("RoundState") or Instance.new("RemoteEvent")
	self.RoundStateRemote.Name = "RoundState"
	self.RoundStateRemote.Parent = self.Remotes
	self.PlayerChoiceRemote = self.Remotes:FindFirstChild("PlayerChoice") or Instance.new("RemoteEvent")
	self.PlayerChoiceRemote.Name = "PlayerChoice"
	self.PlayerChoiceRemote.Parent = self.Remotes
	self.RiskChoiceRemote = self.Remotes:FindFirstChild("RiskChoice") or Instance.new("RemoteEvent")
	self.RiskChoiceRemote.Name = "RiskChoice"
	self.RiskChoiceRemote.Parent = self.Remotes
	self.AdminSystem = AdminSystem.new(self)
	self.Choices = {}
	self:BuildLobby()
	self:ConnectRemoteEvents()
	self:ConnectPlayerAdded()
	return self
end

function RoundManager:BuildLobby()
	self.Lobby = Workspace:FindFirstChild("Lobby")
	if not self.Lobby then
		self.Lobby = RoomBuilder:CreateLobby()
	end
	for _, player in ipairs(Players:GetPlayers()) do
		if player.Character then
			player.Character:PivotTo(CFrame.new(Config.LobbySpawnPosition))
		end
	end
end

function RoundManager:ConnectPlayerAdded()
	Players.PlayerAdded:Connect(function(player)
		player.CharacterAdded:Connect(function(character)
			character:PivotTo(CFrame.new(Config.LobbySpawnPosition))
		end)
		PrizeSystem:SetupPlayer(player)
	end)
end

function RoundManager:ConnectRemoteEvents()
	self.PlayerChoiceRemote.OnServerEvent:Connect(function(player, doorName)
		if not self.ActiveRound or self.ActiveRound.Status ~= "Choosing" then
			return
		end
		local index = tonumber(string.match(doorName or "", "(%d+)$"))
		if not index then
			return
		end
		if self.ActiveRound.Choices[player.UserId] then
			return
		end
		self.ActiveRound.Choices[player.UserId] = index
		self.RoundStateRemote:FireClient(player, "ChoiceLocked", index)
		self.PlayerChoiceRemote:FireClient(player, "DoorChosen", doorName)
	end)

	self.RiskChoiceRemote.OnServerEvent:Connect(function(player, shouldRisk)
		if not self.ActiveRound or self.ActiveRound.Status ~= "RiskDecision" then
			return
		end
		if self.ActiveRound.RiskChoices == nil then
			self.ActiveRound.RiskChoices = {}
		end
		if self.ActiveRound.RiskChoices[player.UserId] ~= nil then
			return
		end
		self.ActiveRound.RiskChoices[player.UserId] = shouldRisk == true
		self.RiskChoiceRemote:FireClient(player, "RiskRecorded", shouldRisk == true)
	end)
end

function RoundManager:GetRoundConfig(roundNumber)
	local doorCount = math.clamp(3 + math.floor(roundNumber / 3), Config.MinDoors, Config.MaxDoors)
	local timer = math.max(Config.TimerFloor, Config.BaseDecisionTimer - (roundNumber - 1) * Config.TimerReductionPerRound)
	return doorCount, timer
end

function RoundManager:SelectTheme()
	return WorldManager:SelectTheme(self.CurrentRound)
end

function RoundManager:TeleportPlayersToRoom(room)
	for i, player in ipairs(Players:GetPlayers()) do
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local offset = Vector3.new((i - 1) * 8, 5, 0)
			player.Character:PivotTo(CFrame.new(room:GetPivot().Position + offset))
		end
	end
end

function RoundManager:StartIntermission()
	self.CurrentRound += 1
	self.RoundStateRemote:FireAllClients("Intermission", {
		Round = self.CurrentRound,
		Seconds = Config.IntermissionDuration,
	})
	for second = Config.IntermissionDuration, 1, -1 do
		self.RoundStateRemote:FireAllClients("IntermissionTick", second)
		task.wait(1)
	end
	self:StartRound()
end

function RoundManager:StartRound()
	local theme = self:SelectTheme()
	local room = RoomBuilder:CreateChallengeRoom(theme, "Round_" .. self.CurrentRound)
	local doorCount, timer = self:GetRoundConfig(self.CurrentRound)
	local safeIndex = math.random(1, doorCount)
	self.ActiveRound = {
		Round = self.CurrentRound,
		Theme = theme,
		DoorCount = doorCount,
		Timer = timer,
		SafeIndex = safeIndex,
		Choices = {},
		Status = "Choosing",
		Room = room,
		RiskChoices = {},
		RiskReward = 0,
	}
	self:TeleportPlayersToRoom(room)
	self.RoundStateRemote:FireAllClients("RoundStart", {
		Round = self.CurrentRound,
		Theme = theme,
		Timer = timer,
		DoorCount = doorCount,
	})

	RoomBuilder:CreateDoors(room, doorCount, safeIndex, function(player, index, door)
		if self.ActiveRound and self.ActiveRound.Status == "Choosing" and not self.ActiveRound.Choices[player.UserId] then
			self.ActiveRound.Choices[player.UserId] = index
			self.PlayerChoiceRemote:FireClient(player, "DoorChosen", door.Name)
			self.RoundStateRemote:FireAllClients("DoorPicked", {
				PlayerName = player.Name,
				DoorIndex = index,
			})
		end
	end)

	for second = timer, 1, -1 do
		if not self.ActiveRound or self.ActiveRound.Status ~= "Choosing" then
			return
		end
		self.RoundStateRemote:FireAllClients("TimerTick", second)
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
		local selected = self.ActiveRound.Choices[player.UserId]
		if selected == self.ActiveRound.SafeIndex then
			survivors[#survivors + 1] = player
			PrizeSystem:UpdateDoorsSurvived(player, 1)
			PrizeSystem:UpdateHighestRound(player, self.CurrentRound)
		else
			local character = player.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				local trapName = Config.RoomThemes[self.ActiveRound.Theme].Traps[math.random(1, #Config.RoomThemes[self.ActiveRound.Theme].Traps)]
				TrapEffects:Execute(player, trapName, self.ActiveRound.Room)
			end
		end
	end

	local reward = Config.Rewards.RoundSurvival + math.floor(self.CurrentRound * 1.4)
	if #survivors > 0 then
		for _, player in ipairs(survivors) do
			if player:GetAttribute("DoubleOrNothing") == true then
				reward = reward * 2
			end
			PrizeSystem:AwardCoins(player, reward)
			PrizeSystem:UpdateHighestRound(player, self.CurrentRound)
			self.RiskChoiceRemote:FireClient(player, "RiskOffer", { Reward = reward, Mode = "DoubleOrNothing" })
		end
		self.RoundStateRemote:FireAllClients("RoundResult", {
			Status = "Survivors",
			SafeIndex = self.ActiveRound.SafeIndex,
			Count = #survivors,
			Reward = reward,
		})
		self.ActiveRound.Status = "RiskDecision"
		self.ActiveRound.RiskChoices = {}
		self.ActiveRound.RiskReward = reward
		for second = 5, 1, -1 do
			if not self.ActiveRound or self.ActiveRound.Status ~= "RiskDecision" then
				return
			end
			self.RoundStateRemote:FireAllClients("RiskTimer", second)
			task.wait(1)
		end
		for _, player in ipairs(survivors) do
			local risk = self.ActiveRound.RiskChoices[player.UserId] == true
			player:SetAttribute("DoubleOrNothing", risk)
		end
	else
		self.RoundStateRemote:FireAllClients("RoundResult", {
			Status = "NoSurvivors",
			SafeIndex = self.ActiveRound.SafeIndex,
			Count = 0,
		})
	end

	task.wait(2)
	for _, player in ipairs(Players:GetPlayers()) do
		if player.Character then
			player.Character:PivotTo(CFrame.new(Config.LobbySpawnPosition))
		end
	end
	self.ActiveRound = nil
	self:StartIntermission()
end

return RoundManager
