local PrizeSystem = {}

local Players = game:GetService("Players")

local function ensureFolder(player, name)
	local folder = player:FindFirstChild(name)
	if folder then
		return folder
	end
	folder = Instance.new("Folder")
	folder.Name = name
	folder.Parent = player
	return folder
end

local function getOrCreateIntValue(parent, name, defaultValue)
	local value = parent:FindFirstChild(name)
	if value and value:IsA("IntValue") then
		return value
	end
	value = Instance.new("IntValue")
	value.Name = name
	value.Value = defaultValue or 0
	value.Parent = parent
	return value
end

function PrizeSystem:SetupPlayer(player)
	local leaderstats = ensureFolder(player, "leaderstats")
	getOrCreateIntValue(leaderstats, "Coins", 0)
	getOrCreateIntValue(leaderstats, "Wins", 0)
	getOrCreateIntValue(leaderstats, "HighestRound", 0)
	getOrCreateIntValue(leaderstats, "DoorsSurvived", 0)
	return leaderstats
end

function PrizeSystem:GetLeaderstats(player)
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then
		return self:SetupPlayer(player)
	end
	return leaderstats
end

function PrizeSystem:AwardCoins(player, amount)
	if not player or not player.Parent then
		return
	end
	local stats = self:GetLeaderstats(player)
	local coins = getOrCreateIntValue(stats, "Coins", 0)
	coins.Value += amount
end

function PrizeSystem:AwardWin(player)
	local stats = self:GetLeaderstats(player)
	local wins = getOrCreateIntValue(stats, "Wins", 0)
	wins.Value += 1
end

function PrizeSystem:UpdateHighestRound(player, roundNumber)
	local stats = self:GetLeaderstats(player)
	local highest = getOrCreateIntValue(stats, "HighestRound", 0)
	highest.Value = math.max(highest.Value, roundNumber)
end

function PrizeSystem:UpdateDoorsSurvived(player, amount)
	local stats = self:GetLeaderstats(player)
	local doors = getOrCreateIntValue(stats, "DoorsSurvived", 0)
	doors.Value += amount
end

function PrizeSystem:GetPlayerStats(player)
	local stats = self:GetLeaderstats(player)
	return {
		Coins = getOrCreateIntValue(stats, "Coins", 0).Value,
		Wins = getOrCreateIntValue(stats, "Wins", 0).Value,
		HighestRound = getOrCreateIntValue(stats, "HighestRound", 0).Value,
		DoorsSurvived = getOrCreateIntValue(stats, "DoorsSurvived", 0).Value,
	}
end

Players.PlayerAdded:Connect(function(player)
	PrizeSystem:SetupPlayer(player)
end)

for _, player in ipairs(Players:GetPlayers()) do
	PrizeSystem:SetupPlayer(player)
end

return PrizeSystem
