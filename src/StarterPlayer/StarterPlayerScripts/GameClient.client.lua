local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local remotes = ReplicatedStorage:FindFirstChild("Remotes") or Instance.new("Folder")
remotes.Name = "Remotes"
remotes.Parent = ReplicatedStorage

local roundState = remotes:FindFirstChild("RoundState") or Instance.new("RemoteEvent")
roundState.Name = "RoundState"
roundState.Parent = remotes

local playerChoice = remotes:FindFirstChild("PlayerChoice") or Instance.new("RemoteEvent")
playerChoice.Name = "PlayerChoice"
playerChoice.Parent = remotes

local riskChoice = remotes:FindFirstChild("RiskChoice") or Instance.new("RemoteEvent")
riskChoice.Name = "RiskChoice"
riskChoice.Parent = remotes

local localPlayer = Players.LocalPlayer
local playerGui = Instance.new("ScreenGui")
playerGui.Name = "GameHUD"
playerGui.ResetOnSpawn = true
playerGui.Parent = localPlayer:WaitForChild("PlayerGui")

local root = Instance.new("Frame")
root.Size = UDim2.new(0, 440, 0, 220)
root.Position = UDim2.new(0.5, -220, 0, 20)
root.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
root.BackgroundTransparency = 0.2
root.BorderSizePixel = 0
root.Parent = playerGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -30, 0, 38)
title.Position = UDim2.new(0, 15, 0, 10)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBlack
title.Text = "PICK THE RIGHT DOOR!"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Parent = root

local roundLabel = Instance.new("TextLabel")
roundLabel.Size = UDim2.new(0.5, -20, 0, 28)
roundLabel.Position = UDim2.new(0, 15, 0, 58)
roundLabel.BackgroundTransparency = 1
roundLabel.Font = Enum.Font.GothamBold
roundLabel.Text = "Round: 1"
roundLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
roundLabel.TextSize = 18
roundLabel.Parent = root

local timerLabel = Instance.new("TextLabel")
timerLabel.Size = UDim2.new(0.5, -20, 0, 28)
timerLabel.Position = UDim2.new(0.5, 0, 0, 58)
timerLabel.BackgroundTransparency = 1
timerLabel.Font = Enum.Font.GothamBold
timerLabel.Text = "Timer: 10"
timerLabel.TextColor3 = Color3.fromRGB(190, 255, 80)
timerLabel.TextSize = 18
timerLabel.Parent = root

local stateLabel = Instance.new("TextLabel")
stateLabel.Size = UDim2.new(1, -30, 0, 34)
stateLabel.Position = UDim2.new(0, 15, 0, 92)
stateLabel.BackgroundTransparency = 1
stateLabel.Font = Enum.Font.GothamSemibold
stateLabel.Text = "Waiting for the next round..."
stateLabel.TextColor3 = Color3.fromRGB(255, 210, 100)
stateLabel.TextSize = 20
stateLabel.Parent = root

local rewardLabel = Instance.new("TextLabel")
rewardLabel.Size = UDim2.new(1, -30, 0, 24)
rewardLabel.Position = UDim2.new(0, 15, 0, 130)
rewardLabel.BackgroundTransparency = 1
rewardLabel.Font = Enum.Font.GothamMedium
rewardLabel.Text = "Reward: 10"
rewardLabel.TextColor3 = Color3.fromRGB(255, 215, 120)
rewardLabel.TextSize = 16
rewardLabel.Parent = root

local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, -30, 0, 28)
infoLabel.Position = UDim2.new(0, 15, 0, 160)
infoLabel.BackgroundTransparency = 1
infoLabel.Font = Enum.Font.GothamMedium
infoLabel.Text = "Choose the single safe door."
infoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
infoLabel.TextSize = 16
infoLabel.Parent = root

local riskLabel = Instance.new("TextLabel")
riskLabel.Size = UDim2.new(1, -30, 0, 24)
riskLabel.Position = UDim2.new(0, 15, 0, 188)
riskLabel.BackgroundTransparency = 1
riskLabel.Font = Enum.Font.GothamBold
riskLabel.Text = "Press R to risk for 2x next round"
riskLabel.TextColor3 = Color3.fromRGB(255, 120, 120)
riskLabel.TextSize = 14
riskLabel.Visible = false
riskLabel.Parent = root

local riskChoiceActive = false
local riskReward = 0

local function updateText(state, roundNumber, timerValue)
	if state == "Intermission" then
		stateLabel.Text = "Next round starts soon..."
	elseif state == "RoundStart" then
		stateLabel.Text = "Choose a door!"
	elseif state == "RoundResult" then
		stateLabel.Text = "Round resolved!"
	else
		stateLabel.Text = state or "Waiting..."
	end

	if roundNumber ~= nil then
		roundLabel.Text = "Round: " .. tostring(roundNumber)
	end
	if timerValue ~= nil then
		timerLabel.Text = "Timer: " .. tostring(timerValue)
	end
end

local function handleRoundState(eventName, payload)
	if eventName == "Intermission" then
		updateText("Intermission", payload.Round, payload.Seconds)
	elseif eventName == "IntermissionTick" then
		updateText("Intermission", nil, payload)
	elseif eventName == "RoundStart" then
		updateText("RoundStart", payload.Round, payload.Timer)
		rewardLabel.Text = "Reward: " .. tostring(payload.Timer)
	elseif eventName == "TimerTick" then
		updateText("RoundStart", nil, payload)
	elseif eventName == "RoundResult" then
		updateText("RoundResult", nil, payload.Count)
		if payload.Status == "Survivors" then
			infoLabel.Text = "Survivors earned " .. tostring(payload.Reward) .. " coins."
			rewardLabel.Text = "Reward: " .. tostring(payload.Reward)
		elseif payload.Status == "NoSurvivors" then
			infoLabel.Text = "Nobody survived this round."
		end
	elseif eventName == "ChoiceLocked" then
		infoLabel.Text = "Choice locked in: Door " .. tostring(payload)
	elseif eventName == "DoorPicked" then
		infoLabel.Text = payload.PlayerName .. " picked Door " .. tostring(payload.DoorIndex)
	elseif eventName == "RiskTimer" then
		riskLabel.Text = "Risk timer: " .. tostring(payload) .. "s"
	elseif eventName == "RiskOffer" then
		riskReward = payload.Reward
		riskChoiceActive = true
		riskLabel.Visible = true
		riskLabel.Text = "Press R to risk for 2x on the next round (current: " .. tostring(payload.Reward) .. ")"
		infoLabel.Text = "Double or Nothing available. Press R to risk or T to keep it."
	end
end

roundState.OnClientEvent:Connect(function(eventName, payload)
	handleRoundState(eventName, payload)
end)

playerChoice.OnClientEvent:Connect(function(eventName, payload)
	if eventName == "DoorChosen" then
		infoLabel.Text = "Door selected: " .. tostring(payload)
	end
end)

riskChoice.OnClientEvent:Connect(function(eventName, payload)
	if eventName == "RiskRecorded" then
		riskLabel.Visible = false
		riskChoiceActive = false
		infoLabel.Text = payload and "Risk accepted. Good luck!" or "You kept your reward."
	end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end
	if input.KeyCode == Enum.KeyCode.R and riskChoiceActive then
		riskChoice:FireServer(true)
	elseif input.KeyCode == Enum.KeyCode.T and riskChoiceActive then
		riskChoice:FireServer(false)
	end
end)

updateText("Waiting", 1, 10)
