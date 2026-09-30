local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local remotes = ReplicatedStorage:FindFirstChild("Remotes") or Instance.new("Folder")
remotes.Name = "Remotes"
remotes.Parent = ReplicatedStorage

local roundState = remotes:FindFirstChild("RoundState") or Instance.new("RemoteEvent")
roundState.Name = "RoundState"
roundState.Parent = remotes

local playerChoice = remotes:FindFirstChild("PlayerChoice") or Instance.new("RemoteEvent")
playerChoice.Name = "PlayerChoice"
playerChoice.Parent = remotes

local localPlayer = Players.LocalPlayer
local playerGui = Instance.new("ScreenGui")
playerGui.Name = "GameHUD"
playerGui.ResetOnSpawn = true
playerGui.Parent = localPlayer:WaitForChild("PlayerGui")

local root = Instance.new("Frame")
root.Size = UDim2.new(0, 420, 0, 180)
root.Position = UDim2.new(0.5, -210, 0, 20)
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

local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, -30, 0, 28)
infoLabel.Position = UDim2.new(0, 15, 0, 130)
infoLabel.BackgroundTransparency = 1
infoLabel.Font = Enum.Font.GothamMedium
infoLabel.Text = "Choose the single safe door."
infoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
infoLabel.TextSize = 16
infoLabel.Parent = root

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
	elseif eventName == "TimerTick" then
		updateText("RoundStart", nil, payload)
	elseif eventName == "RoundResult" then
		updateText("RoundResult", nil, payload.Count)
		if payload.Status == "Survivors" then
			infoLabel.Text = "Survivors earned " .. tostring(payload.Reward) .. " coins."
		elseif payload.Status == "NoSurvivors" then
			infoLabel.Text = "Nobody survived this round."
		end
	elseif eventName == "ChoiceLocked" then
		infoLabel.Text = "Choice locked in: Door " .. tostring(payload)
	elseif eventName == "DoorPicked" then
		infoLabel.Text = payload.PlayerName .. " picked Door " .. tostring(payload.DoorIndex)
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

updateText("Waiting", 1, 10)
