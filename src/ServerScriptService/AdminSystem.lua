local AdminSystem = {}
AdminSystem.__index = AdminSystem

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

function AdminSystem.new(roundManager)
	local self = setmetatable({}, AdminSystem)
	self.Manager = roundManager
	self.AdminRemote = nil
	self:SetupRemote()
	return self
end

function AdminSystem:SetupRemote()
	local remotesFolder = ReplicatedStorage:FindFirstChild("Remotes") or Instance.new("Folder")
	remotesFolder.Name = "Remotes"
	remotesFolder.Parent = ReplicatedStorage

	self.AdminRemote = remotesFolder:FindFirstChild("AdminCommand") or Instance.new("RemoteEvent")
	self.AdminRemote.Name = "AdminCommand"
	self.AdminRemote.Parent = remotesFolder

	self.AdminRemote.OnServerEvent:Connect(function(player, command, value)
		if not self:IsAuthorized(player) then
			return
		end

		if command == "StartRound" then
			if self.Manager then
				self.Manager:StartIntermission()
			end
		elseif command == "SkipRound" then
			if self.Manager and self.Manager.ActiveRound then
				self.Manager.ActiveRound.Status = "Resolving"
			end
		elseif command == "GiveCoins" then
			local amount = tonumber(value) or 0
			if amount > 0 then
				local leaderstats = player:FindFirstChild("leaderstats")
				if leaderstats then
					local coins = leaderstats:FindFirstChild("Coins")
					if coins and coins:IsA("IntValue") then
						coins.Value += amount
					end
				end
			end
		elseif command == "Announce" then
			if typeof(value) == "string" then
				self:Announce(value)
			end
		elseif command == "Kick" then
			if typeof(value) == "string" then
				local target = self:FindPlayerByName(value)
				if target then
					target:Kick("Kicked by an admin.")
				end
			end
		end
	end)
end

function AdminSystem:IsAuthorized(player)
	if not player then
		return false
	end

	if player.UserId == game.CreatorId then
		return true
	end

	return player:GetAttribute("IsAdmin") == true
end

function AdminSystem:FindPlayerByName(name)
	if typeof(name) ~= "string" then
		return nil
	end

	local targetName = string.lower(name)
	for _, player in ipairs(Players:GetPlayers()) do
		if string.lower(player.Name) == targetName then
			return player
		end
	end
	return nil
end

function AdminSystem:Announce(message)
	if typeof(message) ~= "string" then
		return
	end

	for _, player in ipairs(Players:GetPlayers()) do
		local gui = player:FindFirstChildOfClass("PlayerGui")
		if gui then
			local billboard = gui:FindFirstChild("AdminAnnouncement")
			if not billboard then
				billboard = Instance.new("ScreenGui")
				billboard.Name = "AdminAnnouncement"
				billboard.ResetOnSpawn = false
				billboard.Parent = gui
			end

			local frame = billboard:FindFirstChild("Frame") or Instance.new("Frame")
			frame.Name = "Frame"
			frame.Size = UDim2.new(0.5, 0, 0, 80)
			frame.Position = UDim2.new(0.25, 0, 0.12, 0)
			frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			frame.BorderSizePixel = 0
			frame.Parent = billboard

			local label = frame:FindFirstChild("Label") or Instance.new("TextLabel")
			label.Name = "Label"
			label.Size = UDim2.new(1, -20, 1, -20)
			label.Position = UDim2.new(0, 10, 0, 10)
			label.BackgroundTransparency = 1
			label.Text = message
			label.Font = Enum.Font.GothamBold
			label.TextScaled = true
			label.TextColor3 = Color3.fromRGB(255, 220, 120)
			label.Parent = frame

			frame.Parent = billboard
		end
	end
end

return AdminSystem
