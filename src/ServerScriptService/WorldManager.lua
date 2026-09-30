local WorldManager = {}

function WorldManager:GetAvailableWorlds(roundNumber)
	local available = {}
	for _, world in ipairs(require(script.Parent.GameConfig).Worlds) do
		if roundNumber >= world.RequiredWins then
			available[#available + 1] = world
		end
	end
	return available
end

function WorldManager:SelectTheme(roundNumber)
	local worlds = self:GetAvailableWorlds(roundNumber)
	local pool = {}
	for _, world in ipairs(worlds) do
		for _, theme in ipairs(world.Themes) do
			pool[#pool + 1] = theme
		end
	end
	if #pool == 0 then
		return "Castle"
	end
	return pool[math.random(1, #pool)]
end

return WorldManager
