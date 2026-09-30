local TrapEffects = {}

local function createParticleBurst(position, color, parent)
	local emitter = Instance.new("ParticleEmitter")
	emitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	emitter.Color = ColorSequence.new(color)
	emitter.LightEmission = 1
	emitter.Speed = NumberRange.new(4, 8)
	emitter.Lifetime = NumberRange.new(0.5, 0.9)
	emitter.Size = NumberSequence.new(0.15, 0.05)
	emitter.Rate = 150
	emitter.Parent = parent
	emitter.Position = position
	return emitter
end

local function createImpactPart(position, color, parent, size)
	local part = Instance.new("Part")
	part.Anchored = true
	part.CanCollide = false
	part.Material = Enum.Material.Neon
	part.Color = color
	part.Shape = Enum.PartType.Cylinder
	part.Size = size or Vector3.new(2, 4, 2)
	part.CFrame = CFrame.new(position)
	part.Parent = parent
	return part
end

function TrapEffects:Execute(player, trapName, roomFolder)
	if not player or not player.Parent then
		return
	end

	local character = player.Character
	if not character then
		return
	end

	local rootPart = character:FindFirstChild("HumanoidRootPart")
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not rootPart or not humanoid then
		return
	end

	local trap = string.lower(trapName or "")
	local hitPosition = rootPart.Position
	local parent = roomFolder or workspace

	if trap:find("explosion") or trap:find("burst") or trap:find("meteor") then
		local impact = createImpactPart(hitPosition + Vector3.new(0, 3, 0), Color3.fromRGB(255, 110, 0), parent, Vector3.new(3, 6, 3))
		createParticleBurst(hitPosition, Color3.fromRGB(255, 120, 0), parent)
		game:GetService("Debris"):AddItem(impact, 1)
		humanoid:TakeDamage(90)
		return
	end

	if trap:find("fire") then
		local fire = createImpactPart(hitPosition + Vector3.new(0, 1, 0), Color3.fromRGB(255, 90, 0), parent, Vector3.new(2, 3, 2))
		createParticleBurst(hitPosition, Color3.fromRGB(255, 120, 30), parent)
		game:GetService("Debris"):AddItem(fire, 1)
		humanoid:TakeDamage(80)
		return
	end

	if trap:find("rock") or trap:find("fall") then
		local rock = createImpactPart(hitPosition + Vector3.new(0, 8, 0), Color3.fromRGB(150, 150, 150), parent, Vector3.new(2.5, 5, 2.5))
		createParticleBurst(hitPosition, Color3.fromRGB(170, 170, 170), parent)
		game:GetService("Debris"):AddItem(rock, 1.2)
		humanoid:TakeDamage(70)
		return
	end

	if trap:find("laser") or trap:find("electric") then
		local beam = Instance.new("Part")
		beam.Anchored = true
		beam.CanCollide = false
		beam.Material = Enum.Material.Neon
		beam.Color = Color3.fromRGB(0, 255, 255)
		beam.Size = Vector3.new(0.4, 0.4, 12)
		beam.CFrame = CFrame.new(hitPosition + Vector3.new(0, 0, -6), hitPosition)
		beam.Parent = parent
		createParticleBurst(hitPosition, Color3.fromRGB(0, 255, 255), parent)
		game:GetService("Debris"):AddItem(beam, 0.7)
		humanoid:TakeDamage(85)
		return
	end

	if trap:find("shark") or trap:find("tentacle") or trap:find("monster") then
		createParticleBurst(hitPosition, Color3.fromRGB(90, 110, 255), parent)
		humanoid:TakeDamage(75)
		return
	end

	if trap:find("portal") or trap:find("warp") or trap:find("teleport") then
		rootPart.AssemblyLinearVelocity = Vector3.new(0, 30, 0)
		createParticleBurst(hitPosition, Color3.fromRGB(200, 100, 255), parent)
		humanoid:TakeDamage(40)
		return
	end

	if trap:find("freeze") or trap:find("whirlpool") then
		local speed = humanoid.WalkSpeed
		humanoid.WalkSpeed = 2
		task.delay(1.4, function()
			if humanoid.Parent then
				humanoid.WalkSpeed = speed
			end
		end)
		createParticleBurst(hitPosition, Color3.fromRGB(150, 220, 255), parent)
		humanoid:TakeDamage(25)
		return
	end

	if trap:find("chicken") then
		local chicken = Instance.new("Part")
		chicken.Shape = Enum.PartType.Ball
		chicken.Size = Vector3.new(1.5, 1.5, 1.5)
		chicken.Material = Enum.Material.SmoothPlastic
		chicken.Color = Color3.fromRGB(250, 240, 200)
		chicken.Anchored = true
		chicken.CanCollide = false
		chicken.CFrame = CFrame.new(hitPosition + Vector3.new(0, 2, 0))
		chicken.Parent = parent
		createParticleBurst(hitPosition, Color3.fromRGB(255, 240, 200), parent)
		game:GetService("Debris"):AddItem(chicken, 1)
		humanoid:TakeDamage(20)
		return
	end

	createParticleBurst(hitPosition, Color3.fromRGB(255, 255, 255), parent)
	humanoid:TakeDamage(55)
end

return TrapEffects
