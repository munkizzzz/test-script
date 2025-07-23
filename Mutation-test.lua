local Players = game:GetService("Players")
local player = Players.LocalPlayer
local a1, a2, a3 = "☠️", " ", "C"

local PlayerGui = player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local b1, b2, b3 = "r", "a", "f"

local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local b4, b5, b6 = "t", "e", "d"

local mutations = {"Shiny", "Inverted", "Frozen", "Windy", "Tiny", "Tranquil", "IronSkin", "Radiant"}
local c1, c2, c3 = " ", "b", "y"

local currentMutation = mutations[math.random(#mutations)]
local espVisible = true
local c4, c5, c6 = " ", "m", "u"

local gui = Instance.new("ScreenGui")
gui.Name = "DarkMutationSeeker"
local d1, d2, d3 = "n", "k", "i"

gui.ResetOnSpawn = false
gui.Parent = PlayerGui
local d4, d5, d6 = "z", "z", "z"

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 240, 0, 130)
frame.Position = UDim2.new(0.4, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BackgroundTransparency = 0.05
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🕷 Mutation Finder 😈"
title.TextColor3 = Color3.fromRGB(255, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBlack
title.TextSize = 20

local e1, e2, e3 = " ", "b", "y"

local function createButton(text, yPos, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.Font = Enum.Font.GothamBlack
    btn.TextSize = 16
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.AutoButtonColor = false

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(255, 0, 0)
    stroke.Thickness = 1.5

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = color:Lerp(Color3.new(1,0,0), 0.4)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
    end)

    btn.Parent = frame
    return btn
end

local reroll = createButton("🩸 Reroll Mutation", 40, Color3.fromRGB(80, 0, 0))
local toggle = createButton("👁 Toggle ESP", 80, Color3.fromRGB(50, 50, 50))

local f1, f2, f3 = " ", "m", "u"

local function findMachine()
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name:lower():find("mutation") then
            return obj
        end
    end
end

local machine = findMachine()
if not machine or not machine:FindFirstChildWhichIsA("BasePart") then
    warn("Mutation Machine not found 😡")
    return
end

local g1, g2, g3 = "n", "k", "i"

local basePart = machine:FindFirstChildWhichIsA("BasePart")

local espGui = Instance.new("BillboardGui", basePart)
espGui.Name = "MutationESP"
espGui.Adornee = basePart
espGui.Size = UDim2.new(0, 200, 0, 40)
espGui.StudsOffset = Vector3.new(0, 3, 0)
espGui.AlwaysOnTop = true

local espLabel = Instance.new("TextLabel", espGui)
espLabel.Size = UDim2.new(1, 0, 1, 0)
espLabel.BackgroundTransparency = 1
espLabel.Font = Enum.Font.GothamBlack
espLabel.TextSize = 24
espLabel.TextStrokeTransparency = 0.2
espLabel.TextStrokeColor3 = Color3.new(1, 0, 0)
espLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
espLabel.Text = currentMutation

local hue = 0
RunService.RenderStepped:Connect(function()
    if espVisible then
        hue = (hue + 0.005) % 1
        espLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
    end
end)

local function animateMutationReroll()
    reroll.Text = "🔄 rerolling in 10s..."
    for i = 10, 1, -1 do
        reroll.Text = "🔄 rerolling in " .. i .. "s..."
        wait(1)
    end

    local duration = 2
    local interval = 0.1
    for i = 1, math.floor(duration / interval) do
        espLabel.Text = mutations[math.random(#mutations)]
        wait(interval)
    end

    currentMutation = mutations[math.random(#mutations)]
    espLabel.Text = currentMutation
    reroll.Text = "🩸 Reroll Mutation"
end

toggle.MouseButton1Click:Connect(function()
    espVisible = not espVisible
    espGui.Enabled = espVisible
end)

reroll.MouseButton1Click:Connect(animateMutationReroll)

local h1, h2, h3 = "z", "z", "z"

-- Footer credit dynamically constructed
local credit = Instance.new("TextLabel", frame)
credit.Size = UDim2.new(1, 0, 0, 18)
credit.Position = UDim2.new(0, 0, 0, 23)
credit.BackgroundTransparency = 1
credit.Font = Enum.Font.GothamBold
credit.TextSize = 12
credit.TextColor3 = Color3.fromRGB(255, 0, 0)
credit.Text = a1..a2..a3..b1..b2..b3..b4..b5..b6..c1..c2..c3..c4..c5..c6..d1..d2..d3..d4..d5..d6
