local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RoundManager = require(ServerScriptService:WaitForChild("RoundManager"))

local remotesFolder = ReplicatedStorage:FindFirstChild("Remotes") or Instance.new("Folder")
remotesFolder.Name = "Remotes"
remotesFolder.Parent = ReplicatedStorage

local manager = RoundManager.new()
manager:BuildLobby()
manager:StartIntermission()

print("Pick the Right Door! server booted.")
