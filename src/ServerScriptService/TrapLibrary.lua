local TrapLibrary = {}

TrapLibrary.ThemeTraps = {
	Castle = {
		"Falling Rocks",
		"Spikes",
		"Fire Blast",
		"Falling Floor",
		"Fake Treasure Room",
	},
	Volcano = {
		"Lava Explosion",
		"Falling Rocks",
		"Fire Blast",
		"Lava Floor",
		"Volcano Eruption",
	},
	Laboratory = {
		"Electric Shock",
		"Laser Beam",
		"Exploding Experiment",
		"Poison Gas",
		"Robot Attack",
	},
	Underwater = {
		"Flooding Room",
		"Shark Attack",
		"Broken Glass",
		"Whirlpool",
		"Electric Eel",
	},
	Carnival = {
		"Giant Hammer",
		"Falling Objects",
		"Spinning Platforms",
		"Fake Prize Room",
		"Launching Cannon",
	},
	Alien = {
		"Gravity Warp",
		"Warp Portal",
		"Teleporter Trap",
		"Plasma Burst",
		"Tentacle Grab",
	},
	Space = {
		"Zero-G Station",
		"Airlock Burst",
		"Meteor Shower",
		"Disappearing Floor",
		"Black Hole Flare",
	},
}

function TrapLibrary:GetThemeTraps(theme)
	local traps = self.ThemeTraps[theme]
	if traps then
		return traps
	end

	return {
		"Explosion",
		"Fire Blast",
		"Rock Drop",
		"Floor Collapse",
		"Chicken Attack",
	}
end

function TrapLibrary:GetRandomTrap(theme)
	local traps = self:GetThemeTraps(theme)
	return traps[math.random(1, #traps)]
end

function TrapLibrary:TriggerTrap(player, trapName, room)
	if not player or not player.Parent then
		return
	end

	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end

	local trap = string.lower(trapName)
	local rootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

	if trap:find("explosion") or trap:find("meteor") or trap:find("burst") then
		local effectPart = Instance.new("Part")
		effectPart.Shape = Enum.PartType.Ball
		effectPart.Size = Vector3.new(2, 2, 2)
		effectPart.Material = Enum.Material.Neon
		effectPart.Color = Color3.fromRGB(255, 120, 0)
		effectPart.Anchored = true
		effectPart.CanCollide = false
		effectPart.Position = rootPart and rootPart.Position or Vector3.new(0, 5, 0)
		effectPart.Parent = room or workspace
		game:GetService("Debris"):AddItem(effectPart, 0.6)
		humanoid:TakeDamage(90)
		return
	end

	if trap:find("fire") then
		local fire = Instance.new("ParticleEmitter")
		fire.Color = ColorSequence.new(Color3.fromRGB(255, 100, 0))
		fire.LightEmission = 1
		fire.Speed = NumberRange.new(0.5, 2)
		fire.Rate = 100
		fire.Parent = rootPart
		game:GetService("Debris"):AddItem(fire, 0.8)
		humanoid:TakeDamage(60)
		return
	end

	if trap:find("rock") or trap:find("fall") then
		local rock = Instance.new("Part")
		rock.Shape = Enum.PartType.Cylinder
		rock.Size = Vector3.new(2, 4, 2)
		rock.Material = Enum.Material.SmoothPlastic
		rock.Color = Color3.fromRGB(120, 120, 120)
		rock.CFrame = CFrame.new((rootPart and rootPart.Position or Vector3.zero) + Vector3.new(0, 8, 0))
		rock.Anchored = true
		rock.CanCollide = false
		rock.Parent = room or workspace
		game:GetService("Debris"):AddItem(rock, 1.2)
		humanoid:TakeDamage(70)
		return
	end

	if trap:find("laser") or trap:find("electric") then
		local beam = Instance.new("Beam")
		beam.Width0 = 0.2
		beam.Width1 = 0.2
		beam.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255))
		beam.Parent = rootPart
		game:GetService("Debris"):AddItem(beam, 0.5)
		humanoid:TakeDamage(80)
		return
	end

	if trap:find("shark") or trap:find("tentacle") then
		humanoid:TakeDamage(75)
		return
	end

	if trap:find("launch") or trap:find("portal") or trap:find("warp") then
		if rootPart then
			rootPart.AssemblyLinearVelocity = Vector3.new(0, 40, 0)
		end
		humanoid:TakeDamage(30)
		return
	end

	if trap:find("freeze") or trap:find("whirlpool") then
		if humanoid then
			humanoid.WalkSpeed = 2
			task.delay(1.5, function()
				if humanoid.Parent then
					humanoid.WalkSpeed = 16
				end
			end)
		end
		humanoid:TakeDamage(25)
		return
	end

	if trap:find("chicken") then
		local chicken = Instance.new("Part")
		chicken.Name = "Chicken"
		chicken.Size = Vector3.new(1, 1, 1)
		chicken.Shape = Enum.PartType.Ball
		chicken.Material = Enum.Material.SmoothPlastic
		chicken.Color = Color3.fromRGB(255, 240, 200)
		chicken.Anchored = true
		chicken.CanCollide = false
		chicken.Position = (rootPart and rootPart.Position or Vector3.zero) + Vector3.new(0, 2, 0)
		chicken.Parent = room or workspace
		game:GetService("Debris"):AddItem(chicken, 1)
		humanoid:TakeDamage(20)
		return
	end

	humanoid:TakeDamage(50)
end

return TrapLibrary
