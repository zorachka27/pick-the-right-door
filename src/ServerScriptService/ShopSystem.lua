local ShopSystem = {}

local function makeLabel(parent, text, position, size, textColor, textSize)
	local label = Instance.new("TextLabel")
	label.Name = "ShopLabel"
	label.Size = size
	label.Position = position
	label.BackgroundTransparency = 1
	label.Text = text
	label.Font = Enum.Font.GothamBold
	label.TextScaled = false
	label.TextSize = textSize or 18
	label.TextColor3 = textColor or Color3.fromRGB(255, 255, 255)
	label.Parent = parent
	return label
end

function ShopSystem:Build(lobby)
	local shopFolder = lobby:FindFirstChild("Shop") or Instance.new("Folder")
	shopFolder.Name = "Shop"
	shopFolder.Parent = lobby

	for _, obj in ipairs(shopFolder:GetChildren()) do
		obj:Destroy()
	end

	local base = Instance.new("Part")
	base.Name = "ShopBase"
	base.Size = Vector3.new(40, 1, 20)
	base.Position = Vector3.new(0, 2, -18)
	base.Anchored = true
	base.Material = Enum.Material.SmoothPlastic
	base.Color = Color3.fromRGB(45, 70, 110)
	base.Parent = shopFolder

	local sign = Instance.new("Part")
	sign.Name = "ShopSign"
	sign.Size = Vector3.new(12, 4, 1)
	sign.Position = Vector3.new(0, 8, -18)
	sign.Anchored = true
	sign.Parent = shopFolder
	local gui = Instance.new("SurfaceGui")
	gui.Face = Enum.NormalId.Front
	gui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
	gui.PixelsPerStud = 50
	gui.Parent = sign
	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, 0, 1, 0)
	title.BackgroundTransparency = 1
	title.Text = "Cosmetics Shop"
	title.Font = Enum.Font.GothamBlack
	title.TextScaled = true
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.Parent = gui

	local items = { "Door Skins", "Trails", "Effects", "Titles", "Emotes", "Name Colors" }
	for index, item in ipairs(items) do
		local panel = Instance.new("Part")
		panel.Name = "ShopItem_" .. index
		panel.Size = Vector3.new(10, 2, 1)
		panel.Position = Vector3.new(-12 + (index % 3) * 12, 6, -18 + (index > 3 and 4 or -4))
		panel.Anchored = true
		panel.Material = Enum.Material.Neon
		panel.Color = Color3.fromRGB(90, 150, 255)
		panel.Parent = shopFolder
		local panelGui = Instance.new("SurfaceGui")
		panelGui.Face = Enum.NormalId.Front
		panelGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
		panelGui.PixelsPerStud = 40
		panelGui.Parent = panel
		local text = Instance.new("TextLabel")
		text.Size = UDim2.new(1, 0, 1, 0)
		text.BackgroundTransparency = 1
		text.Text = item
		text.Font = Enum.Font.GothamBold
		text.TextScaled = true
		text.TextColor3 = Color3.fromRGB(255, 255, 255)
		text.Parent = panelGui
	end

	return shopFolder
end

return ShopSystem
