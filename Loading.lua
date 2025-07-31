local Players = game:GetService("Players")
local d4, e5, f6 = "Y", "o", "u"
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local g7, h8, i9 = "t", "u", "b"
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
screenGui.Name = "MunkizzzLoading"
local j1, k2, l3 = "e", ":", " "
local loadingFrame = Instance.new("Frame", screenGui)
loadingFrame.Size = UDim2.new(0, 320, 0, 90)
loadingFrame.Position = UDim2.new(0.5, -160, 0.5, -45)
local m4, n5, o6 = "m", "u", "n"
loadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
loadingFrame.BorderSizePixel = 0
Instance.new("UICorner", loadingFrame).CornerRadius = UDim.new(0, 25)
local p7, q8, r9 = "k", "i", "z"
local label = Instance.new("TextLabel", loadingFrame)
label.Size = UDim2.new(1, 0, 0.35, 0)
label.Position = UDim2.new(0,0,0,0)
label.Text = "😈 Activating MUNKIZZZ script 😈"
local s1, t2, u3 = "z", "z", " "
label.Font = Enum.Font.Arcade
label.TextColor3 = Color3.new(1,0,0)
label.TextScaled = true
label.BackgroundTransparency = 1
local v4, w5, x6 = "|", " ", "S"

local progressBarBG = Instance.new("Frame", loadingFrame)
progressBarBG.Size = UDim2.new(0.9, 0, 0.2, 0)
progressBarBG.Position = UDim2.new(0.05, 0, 0.45, 0)
progressBarBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
progressBarBG.BorderSizePixel = 0
Instance.new("UICorner", progressBarBG).CornerRadius = UDim.new(0, 8)
local y7, z1, a2 = "u", "b", "s"

local progressBar = Instance.new("Frame", progressBarBG)
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
progressBar.BorderSizePixel = 0
Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 8)
local b3, c4, d5 = "c", "r", "i"

local ytLabel = Instance.new("TextLabel", loadingFrame)
ytLabel.Size = UDim2.new(1,0,0,20)
ytLabel.Position = UDim2.new(0,0,1,-20)
local e6, f7, g8 = "b", "e", " "
local h9, i0, j0 = "f", "o", "r"
local k3, l4, m5 = " ", "P", "o"
local n6, o7, p8 = "w", "e", "r"
local q9, r0, s0 = "!", " ", "🔥"

ytLabel.Text = d4..e5..f6..g7..h8..i9..j1..k2..l3
ytLabel.Text = ytLabel.Text..m4..n5..o6..p7..q8..r9..s1..t2..u3..v4..w5..x6
ytLabel.Text = ytLabel.Text..y7..z1..a2..b3..c4..d5..e6..f7..g8..h9..i0..j0
ytLabel.Text = ytLabel.Text..k3..l4..m5..n6..o7..p8..q9..r0..s0

ytLabel.Font = Enum.Font.GothamBold
ytLabel.TextColor3 = Color3.new(1,1,1)
ytLabel.TextScaled = true
ytLabel.BackgroundTransparency = 1

local pulseConnection
pulseConnection = RunService.RenderStepped:Connect(function()
    local time = tick()
    local pulse = (math.sin(time * 5) + 1) / 2
    progressBar.BackgroundColor3 = Color3.new(1, pulse * 0.2, pulse * 0.2)
end)

local tween = TweenService:Create(progressBar, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Size = UDim2.new(1, 0, 1, 0)
})
tween:Play()

tween.Completed:Connect(function()
    pulseConnection:Disconnect()
    local fadeTween = TweenService:Create(loadingFrame, TweenInfo.new(1), {BackgroundTransparency = 1})
    fadeTween:Play()
    fadeTween.Completed:Connect(function()
        screenGui:Destroy()
        -- 
loadstring(game:HttpGet("https://raw.githubusercontent.com/munkizzzz/test-script/refs/heads/main/Main-test.lua"))()
    end)
end)
