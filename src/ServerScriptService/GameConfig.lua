local Config = {
	GameName = "Pick the Right Door!",
	LobbySpawnPosition = Vector3.new(0, 6, 18),
	IntermissionDuration = 10,
	MinDoors = 3,
	MaxDoors = 10,
	BaseDecisionTimer = 10,
	TimerReductionPerRound = 0.2,
	TimerFloor = 5,
	DoorSpacing = 12,
	SafeDoorBonus = 2,
	RewardMultiplier = 1,
	Worlds = {
		{
			Name = "The Beginning",
			RequiredWins = 0,
			Themes = { "Castle", "Carnival" },
			DoorCountRange = { 3, 4 },
		},
		{
			Name = "Medieval",
			RequiredWins = 5,
			Themes = { "Castle", "Carnival" },
			DoorCountRange = { 4, 5 },
		},
		{
			Name = "Volcano",
			RequiredWins = 10,
			Themes = { "Volcano" },
			DoorCountRange = { 5, 6 },
		},
		{
			Name = "Laboratory",
			RequiredWins = 15,
			Themes = { "Laboratory" },
			DoorCountRange = { 6, 7 },
		},
		{
			Name = "Alien Planet",
			RequiredWins = 20,
			Themes = { "Alien" },
			DoorCountRange = { 7, 8 },
		},
		{
			Name = "Space",
			RequiredWins = 30,
			Themes = { "Space" },
			DoorCountRange = { 8, 10 },
		},
	},
	RoomThemes = {
		Castle = {
			Color = Color3.fromRGB(165, 130, 90),
			Traps = { "Falling Rocks", "Spikes", "Fire Blast", "Falling Floor", "Fake Treasure Room" },
		},
		Volcano = {
			Color = Color3.fromRGB(200, 90, 40),
			Traps = { "Lava Explosion", "Falling Rocks", "Fire Blast", "Lava Floor", "Volcano Eruption" },
		},
		Laboratory = {
			Color = Color3.fromRGB(70, 120, 200),
			Traps = { "Electric Shock", "Laser Beam", "Exploding Experiment", "Poison Gas", "Robot Attack" },
		},
		Underwater = {
			Color = Color3.fromRGB(45, 125, 175),
			Traps = { "Flooding Room", "Shark Attack", "Broken Glass", "Whirlpool", "Electric Eel" },
		},
		Carnival = {
			Color = Color3.fromRGB(235, 115, 180),
			Traps = { "Giant Hammer", "Falling Objects", "Spinning Platforms", "Fake Prize Room", "Launching Cannon" },
		},
		Alien = {
			Color = Color3.fromRGB(80, 180, 135),
			Traps = { "Gravity Warp", "Warp Portal", "Teleporter Trap", "Plasma Burst", "Tentacle Grab" },
		},
		Space = {
			Color = Color3.fromRGB(45, 45, 85),
			Traps = { "Zero-G Station", "Airlock Burst", "Meteor Shower", "Disappearing Floor", "Black Hole Flare" },
		},
	},
	Rewards = {
		RoundSurvival = 10,
		FiveRoundBonus = 50,
		TenRoundBonus = 150,
		WinGame = 500,
		DailyRewardMin = 100,
		DailyRewardMax = 1000,
	},
	Leaderstats = {
		"Wins",
		"Coins",
		"HighestRound",
		"DoorsSurvived",
	},
	Cosmetics = {
		DoorSkins = { "Wooden", "Gold", "Lava", "Galaxy", "Neon", "Rainbow", "Secret" },
		Effects = { "Fire Aura", "Lightning Aura", "Smoke", "Stars", "Glowing Outline" },
		EliminationEffects = { "Explosion", "Smoke Cloud", "Confetti", "Portal Drop", "Cartoon Stars" },
	},
	Shop = {
		GamePasses = {
			{ Name = "VIP", Cost = 399, Perks = { "VIP chat tag", "VIP lobby area", "exclusive door skins" } },
			{ Name = "2x Coins", Cost = 199, Perks = { "double coin rewards" } },
			{ Name = "Lucky Choice", Cost = 249, Perks = { "hints toward the safe door" } },
			{ Name = "Extra Life", Cost = 149, Perks = { "extra survival life" } },
			{ Name = "Fast Vote", Cost = 99, Perks = { "extra decision time" } },
		},
		DeveloperProducts = {
			{ Name = "100 Coins", Cost = 25 },
			{ Name = "500 Coins", Cost = 75 },
			{ Name = "1500 Coins", Cost = 150 },
			{ Name = "5000 Coins", Cost = 350 },
			{ Name = "Revive", Cost = 49 },
			{ Name = "Random Cosmetic", Cost = 39 },
		},
	},
	Events = {
		"Double Coins Weekend",
		"Chaos Mode",
		"10 Door Challenge",
		"Admin Mayhem",
	},
}

return Config
