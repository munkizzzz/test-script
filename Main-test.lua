-- Visual pet hatch simulator with drag, ESP, auto random, pet age loader
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local a1, a2, a3 = "M", "a", "d"

-- 👹 Evil Toggle Button
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "PetHatchGui"
screenGui.Parent = player.PlayerGui

local toggleGUIBtn = Instance.new("TextButton")
toggleGUIBtn.Size = UDim2.new(0, 40, 0, 40)
toggleGUIBtn.Position = UDim2.new(0, 20, 0, 50)
toggleGUIBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
toggleGUIBtn.Text = "☠️"
toggleGUIBtn.Font = Enum.Font.FredokaOne
toggleGUIBtn.TextSize = 24
toggleGUIBtn.TextColor3 = Color3.new(1,1,1)
toggleGUIBtn.Parent = screenGui
Instance.new("UICorner", toggleGUIBtn).CornerRadius = UDim.new(0, 8)
toggleGUIBtn.Position = UDim2.new(0, 20, 0, 50)
toggleGUIBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
toggleGUIBtn.Text = "☠️"
toggleGUIBtn.Font = Enum.Font.FredokaOne
toggleGUIBtn.TextSize = 24
toggleGUIBtn.TextColor3 = Color3.new(1,1,1)
toggleGUIBtn.Parent = screenGui
Instance.new("UICorner", toggleGUIBtn).CornerRadius = UDim.new(0, 8)

local draggingToggle, offsetToggle
toggleGUIBtn.MouseButton1Down:Connect(function()
    draggingToggle = true
    offsetToggle = Vector2.new(mouse.X - toggleGUIBtn.Position.X.Offset, mouse.Y - toggleGUIBtn.Position.Y.Offset)
end)
UserInputService.InputEnded:Connect(function()
    draggingToggle = false
end)
RunService.RenderStepped:Connect(function()
    if draggingToggle then
        toggleGUIBtn.Position = UDim2.new(0, mouse.X - offsetToggle.X, 0, mouse.Y - offsetToggle.Y)
    end
end)

local frameVisible = true
toggleGUIBtn.MouseButton1Click:Connect(function()
    frameVisible = not frameVisible
    frame.Visible = frameVisible
end)

local petTable = {
    ["Common Egg"] = { "Dog", "Bunny", "Golden Lab" },
    ["Uncommon Egg"] = { "Chicken", "Black Bunny", "Cat", "Deer" },
    ["Rare Egg"] = { "Pig", "Monkey", "Rooster", "Orange Tabby", "Spotted Deer" },
    ["Legendary Egg"] = { "Cow", "Polar Bear", "Sea Otter", "Turtle", "Silver Monkey" },
    ["Mythical Egg"] = { "Grey Mouse", "Brown Mouse", "Squirrel", "Red Giant Ant" },
    ["Bug Egg"] = { "Snail", "Caterpillar", "Giant Ant", "Praying Mantis" },
    ["Night Egg"] = { "Frog", "Hedgehog", "Mole", "Echo Frog", "Night Owl", },
    ["Bee Egg"] = { "Bee", "Honey Bee", "Bear Bee", "Petal Bee" },
    ["Anti Bee Egg"] = { "Wasp", "Moth", "Tarantula Hawk" },
    ["Oasis Egg"] = { "Meerkat", "Sand Snake", "Axolotl" },
    ["Paradise Egg"] = { "Ostrich", "Peacock", "Capybara" },
    ["Dinosaur Egg"] = { "Raptor", "Triceratops", "Stegosaurus" },
    ["Primal Egg"] = { "Parasaurolophus", "Iguanodon", "Pachycephalosaurus" },
}

local espEnabled = true
local truePetMap = {}

local function glitchLabelEffect(label)
    coroutine.wrap(function()
        local original = label.TextColor3
        for i = 1, 2 do
            label.TextColor3 = Color3.new(1, 0, 0)
            wait(0.07)
            label.TextColor3 = original
            wait(0.07)
        end
    end)()
end

local a4, a5, a6 = "e", " ", "b"

local function applyEggESP(eggModel, petName)
    local existingLabel = eggModel:FindFirstChild("PetBillboard", true)
    if existingLabel then existingLabel:Destroy() end
    local existingHighlight = eggModel:FindFirstChild("ESPHighlight")
    if existingHighlight then existingHighlight:Destroy() end
    if not espEnabled then return end

    local basePart
    for _, desc in ipairs(eggModel:GetDescendants()) do
        if desc:IsA("BasePart") then
            basePart = desc
            break
        end
    end
    if not basePart then return end

    local hatchReady = true
    local hatchTime = eggModel:FindFirstChild("HatchTime")
    local readyFlag = eggModel:FindFirstChild("ReadyToHatch")

    if hatchTime and hatchTime:IsA("NumberValue") and hatchTime.Value > 0 then
        hatchReady = false
    elseif readyFlag and readyFlag:IsA("BoolValue") and not readyFlag.Value then
        hatchReady = false
    end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PetBillboard"
    billboard.Size = UDim2.new(0, 270, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 4.5, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 500
    billboard.Parent = basePart

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "🥚 " .. eggModel.Name .. " | 🐾 " .. petName
label.TextColor3 = Color3.fromRGB(200, 50, 255) -- Purple-pink
label.TextStrokeTransparency = 0.3
label.TextStrokeColor3 = Color3.fromRGB(0,0,0)
label.Font = Enum.Font.GothamBold
label.TextSize = 24
label.TextWrapped = true
label.TextScaled = true
label.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
label.BackgroundTransparency = 0.4
label.BorderSizePixel = 0
    label.TextWrapped = true
    label.Parent = billboard

    glitchLabelEffect(label)

    local highlight = Instance.new("Highlight")
    highlight.Name = "ESPHighlight"
    highlight.FillColor = Color3.fromRGB(255, 200, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.7
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = eggModel
    highlight.Parent = eggModel
end

local function removeEggESP(eggModel)
    local label = eggModel:FindFirstChild("PetBillboard", true)
    if label then label:Destroy() end
    local highlight = eggModel:FindFirstChild("ESPHighlight")
    if highlight then highlight:Destroy() end
end

local function getPlayerGardenEggs(radius)
    local eggs = {}
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return eggs end

    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and petTable[obj.Name] then
            local dist = (obj:GetModelCFrame().Position - root.Position).Magnitude
            if dist <= (radius or 60) then
                if not truePetMap[obj] then
                    local pets = petTable[obj.Name]
                    local chosen = pets[math.random(1, #pets)]
                    truePetMap[obj] = chosen
                end
                table.insert(eggs, obj)
            end
        end
    end
    return eggs
end

local function randomizeNearbyEggs()
    local eggs = getPlayerGardenEggs(60)
    for _, egg in ipairs(eggs) do
        local pets = petTable[egg.Name]
        local chosen = pets[math.random(1, #pets)]
        truePetMap[egg] = chosen
        applyEggESP(egg, chosen)
    end
    print("Randomized", #eggs, "eggs.")
end

local a7, a8, a9 = "y", " ", "m"

local function flashEffect(button)
    local originalColor = button.BackgroundColor3
    for i = 1, 3 do
        button.BackgroundColor3 = Color3.new(1, 1, 1)
        wait(0.05)
        button.BackgroundColor3 = originalColor
        wait(0.05)
    end
end

local function countdownAndRandomize(button)
    for i = 10, 1, -1 do
        button.Text = "🎲 Randomize in: " .. i
        wait(1)
    end
    flashEffect(button)
    randomizeNearbyEggs()
    button.Text = "🎲 Randomize Pets"
end

-- 🌿 GUI Setup
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "PetHatchGui"

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 300)
frame.Position = UDim2.new(0, 20, 0, 80)
frame.BackgroundColor3 = Color3.fromRGB(20, 0, 40) -- Darker evil theme
frame.BackgroundTransparency = 0.1
frame.BorderSizePixel = 0
frame.Parent = screenGui
frame.Parent = screenGui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local shadow = Instance.new("UIStroke", frame)
shadow.Color = Color3.fromRGB(255, 0, 100)
shadow.Thickness = 2
shadow.Transparency = 0

local b1, b2, b3 = "u", "n", "k"

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "👹 Egg Randomizer 👁️"
title.Font = Enum.Font.FredokaOne
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(255, 0, 100)

-- 👇 Dragging
local drag = Instance.new("TextButton", title)
drag.Size = UDim2.new(1, 0, 1, 0)
drag.Text = ""
drag.BackgroundTransparency = 1

local dragging, offset
drag.MouseButton1Down:Connect(function()
    dragging = true
    offset = Vector2.new(mouse.X - frame.Position.X.Offset, mouse.Y - frame.Position.Y.Offset)
end)
UserInputService.InputEnded:Connect(function()
    dragging = false
end)
RunService.RenderStepped:Connect(function()
    if dragging then
        frame.Position = UDim2.new(0, mouse.X - offset.X, 0, mouse.Y - offset.Y)
    end
end)

-- 🎲 Randomize Button
local randomizeBtn = Instance.new("TextButton", frame)
randomizeBtn.Size = UDim2.new(1, -20, 0, 50)
randomizeBtn.Position = UDim2.new(0, 10, 0, 40)
randomizeBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
randomizeBtn.Text = "🐣 Hatch Random Pets"
randomizeBtn.BackgroundColor3 = Color3.fromRGB(128, 0, 128) -- Purple
randomizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
randomizeBtn.Font = Enum.Font.GothamBold
randomizeBtn.TextSize = 18
Instance.new("UICorner", randomizeBtn).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new("UIStroke", randomizeBtn)
stroke.Color = Color3.fromRGB(255, 0, 100)
stroke.Thickness = 2
stroke.Transparency = 0
randomizeBtn.MouseButton1Click:Connect(function()
    countdownAndRandomize(randomizeBtn)
end)

-- 👁️ ESP Toggle
local toggleBtn = Instance.new("TextButton", frame)
toggleBtn.Size = UDim2.new(1, -20, 0, 40)
toggleBtn.Position = UDim2.new(0, 10, 0, 100)
toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggleBtn.Text = "🧿 ESP: ON"
toggleBtn.TextSize = 18
toggleBtn.Font = Enum.Font.FredokaOne
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    toggleBtn.Text = espEnabled and "🧿 ESP: ON" or "🧿 ESP: OFF"
    for _, egg in pairs(getPlayerGardenEggs(60)) do
        if espEnabled then
            applyEggESP(egg, truePetMap[egg])
        else
            removeEggESP(egg)
        end
    end
end)

-- 🟣 Initial ESP
for _, egg in pairs(getPlayerGardenEggs(60)) do
    applyEggESP(egg, truePetMap[egg])
end

-- 🔁 Auto Randomize Button
local autoBtn = Instance.new("TextButton", frame)
autoBtn.Size = UDim2.new(1, -20, 0, 30)
autoBtn.Position = UDim2.new(0, 10, 0, 145)
autoBtn.BackgroundColor3 = Color3.fromRGB(80, 150, 60)
autoBtn.Text = "🔁 Auto Randomize: OFF"
autoBtn.TextSize = 16
autoBtn.Font = Enum.Font.FredokaOne
autoBtn.TextColor3 = Color3.new(1, 1, 1)

local autoRunning = false
local bestPets = {
    ["Raccoon"] = true, ["Dragonfly"] = true, ["Queen Bee"] = true,
    ["Disco Bee"] = true, ["Fennec Fox"] = true, ["Fox"] = true,
    ["Mimic Octopus"] = true
}

autoBtn.MouseButton1Click:Connect(function()
    autoRunning = not autoRunning
    autoBtn.Text = autoRunning and "🔁 Auto Randomize: ON" or "🔁 Auto Randomize: OFF"
    coroutine.wrap(function()
        while autoRunning do
            countdownAndRandomize(randomizeBtn)
            for _, petName in pairs(truePetMap) do
                if bestPets[petName] then
                    autoRunning = false
                    autoBtn.Text = "🔁 Auto Randomize: OFF"
                    return
                end
            end
            wait(1)
        end
    end)()
end)

-- 🕷️Load Pet Age Script Button
local loadAgeBtn = Instance.new("TextButton", frame)
loadAgeBtn.Size = UDim2.new(1, -20, 0, 40)
loadAgeBtn.Position = UDim2.new(0, 10, 0, 190)
loadAgeBtn.BackgroundColor3 = Color3.fromRGB(40, 43, 74) -- Dark purple
loadAgeBtn.Text = "🕷️ Load Pet Age 50 Script"
loadAgeBtn.TextSize = 16
loadAgeBtn.Font = Enum.Font.FredokaOne
loadAgeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

loadAgeBtn.MouseButton1Click:Connect(function()
 -- Put your Lvl 50 Pet Age Loader Here

end)

-- 💀 Pet Mutation Finder Button
local mutationBtn = Instance.new("TextButton", frame)
mutationBtn.Size = UDim2.new(1, -20, 0, 40)
mutationBtn.Position = UDim2.new(0, 10, 0, 240)
mutationBtn.BackgroundColor3 = Color3.fromRGB(216, 148, 169) -- Pink
mutationBtn.Text = " 💀 Pet Mutation Finder"
mutationBtn.TextSize = 16
mutationBtn.Font = Enum.Font.FredokaOne
mutationBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

mutationBtn.MouseButton1Click:Connect(function()
 -- Put your Pet Mutation Loader Here loadstring(game:HttpGet("https://raw.githubusercontent.com/munkizzzz/test-script/refs/heads/main/Mutation-test.lua"))()
end)

local b4, b5, b6 = "i", "z", "z"
local c1 = "z"

local credit = Instance.new("TextLabel", frame)
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Position = UDim2.new(0, 0, 0, 22)
credit.BackgroundTransparency = 1
credit.Font = Enum.Font.FredokaOne
credit.TextSize = 14
credit.TextColor3 = Color3.fromRGB(200, 200, 200)
credit.Text = a1..a2..a3..a4..a5..a6..a7..a8..a9..b1..b2..b3..b4..b5..b6..c1
