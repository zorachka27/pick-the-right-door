local Config = {
	GameName = "Pick the Right Door!",
	IntermissionDuration = 10,
	MinDoors = 3,
	MaxDoors = 10,
	BaseDecisionTimer = 10,
	TimerReductionPerRound = 0.2,
	DoorSpacing = 12,
	LobbySpawn = Vector3.new(0, 5, 0),
	TimerFloor = 5,
	RoomThemes = {
		"Castle",
		"Volcano",
		"Laboratory",
		"Underwater",
		"Carnival",
		"Alien",
		"Space",
	},
	Worlds = {
		{
			Name = "The Beginning",
			RequiredWins = 0,
			ThemePool = { "Castle", "Carnival" },
			DoorCount = { 3, 4 },
		},
		{
			Name = "Medieval",
			RequiredWins = 5,
			ThemePool = { "Castle", "Carnival" },
			DoorCount = { 4, 5 },
		},
		{
			Name = "Volcano",
			RequiredWins = 10,
			ThemePool = { "Volcano" },
			DoorCount = { 5, 6 },
		},
		{
			Name = "Laboratory",
			RequiredWins = 15,
			ThemePool = { "Laboratory" },
			DoorCount = { 6, 7 },
		},
		{
			Name = "Alien Planet",
			RequiredWins = 20,
			ThemePool = { "Alien" },
			DoorCount = { 7, 8 },
		},
		{
			Name = "Space",
			RequiredWins = 30,
			ThemePool = { "Space" },
			DoorCount = { 8, 10 },
		},
	},
	Rewards = {
		SurviveRound = 10,
		SurviveFiveRounds = 50,
		SurviveTenRounds = 150,
		WinGame = 500,
		DailyReward = 100,
	},
	LeaderboardStats = {
		"Wins",
		"HighestRound",
		"Coins",
		"DoorsSurvived",
	},
}

return Config
