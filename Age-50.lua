-- LocalScript (put in StarterPlayerScripts or StarterGui)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FakeAgeChanger"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 370, 0, 190)
frame.Position = UDim2.new(0.5, -185, 0.5, -95)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

-- Evil neon stroke
local shadow = Instance.new("UIStroke", frame)
shadow.Color = Color3.fromRGB(255, 0, 100)
shadow.Thickness = 3
shadow.Transparency = 0.2

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

-- Title
local title = Instance.new("TextLabel")
title.Text = "😈 Set Equipped Pet Age to 50 😈"
title.Font = Enum.Font.FredokaOne
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255, 0, 150)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 40)
title.Parent = frame

-- Pet info
local petInfo = Instance.new("TextLabel")
petInfo.Text = "Equipped Pet: [None]"
petInfo.Font = Enum.Font.Gotham
petInfo.TextSize = 18
petInfo.TextColor3 = Color3.fromRGB(255, 255, 150)
petInfo.BackgroundTransparency = 1
petInfo.Position = UDim2.new(0, 0, 0, 42)
petInfo.Size = UDim2.new(1, 0, 0, 30)
petInfo.Parent = frame

-- Button
local button = Instance.new("TextButton")
button.Text = "⚡ Set Age to 50 ⚡"
button.Font = Enum.Font.FredokaOne
button.TextSize = 20
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
button.Position = UDim2.new(0.5, -120, 1, -60)
button.Size = UDim2.new(0, 240, 0, 45)
button.Parent = frame

Instance.new("UICorner", button)

local buttonStroke = Instance.new("UIStroke", button)
buttonStroke.Color = Color3.fromRGB(255, 0, 150)
buttonStroke.Thickness = 2
buttonStroke.Transparency = 0.1

-- Function to get equipped pet tool
local function getEquippedPetTool()
	character = player.Character or player.CharacterAdded:Wait()
	for _, child in pairs(character:GetChildren()) do
		if child:IsA("Tool") and child.Name:find("Age") then
			return child
		end
	end
	return nil
end

-- Update GUI pet info
local function updateGUI()
	local pet = getEquippedPetTool()
	if pet then
		petInfo.Text = "Equipped Pet: " .. pet.Name
	else
		petInfo.Text = "Equipped Pet: [None]"
	end
end

-- Button click logic
button.MouseButton1Click:Connect(function()
	local tool = getEquippedPetTool()
	if tool then
		for i = 20, 1, -1 do
			button.Text = "Changing Age in " .. i .. "..."
			task.wait(1)
		end
		local newName = tool.Name:gsub("%[Age%s%d+%]", "[Age 50]")
		tool.Name = newName
		petInfo.Text = "Equipped Pet: " .. tool.Name
		button.Text = "⚡ Set Age to 50 ⚡"
	else
		button.Text = "No Pet Equipped!"
		task.wait(2)
		button.Text = "⚡ Set Age to 50 ⚡"
	end
end)

-- Constant GUI refresh
while true do
	task.wait(1)
	updateGUI()
end
