local ServerScriptService = game:GetService("ServerScriptService")

local RoundManager = require(ServerScriptService:WaitForChild("RoundManager"))

local manager = RoundManager.new()
manager:StartIntermission()

print("Pick the Right Door! server started.")
