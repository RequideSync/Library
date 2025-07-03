local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

if CoreGui:FindFirstChild("SiratamaFadeUI") then
    CoreGui:FindFirstChild("SiratamaFadeUI"):Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SiratamaFadeUI"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.BackgroundColor3 = Color3.new(0, 0, 0) 
frame.Size = UDim2.new(1, 0, 1, 0) 
frame.BackgroundTransparency = 1 
frame.Parent = screenGui

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
textLabel.TextScaled = true
textLabel.Font = Enum.Font.Code 
textLabel.Text = "Thanks for Using Script ( >_- )\nProvided by Siratama Script"
textLabel.TextStrokeTransparency = 0.5
textLabel.TextWrapped = true
textLabel.Parent = frame

TweenService:Create(frame, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()
TweenService:Create(textLabel, TweenInfo.new(1), {TextTransparency = 0}):Play()

task.wait(3)

TweenService:Create(frame, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
TweenService:Create(textLabel, TweenInfo.new(1), {TextTransparency = 1}):Play()

-- 少し待ってから削除
task.wait(1.5)
screenGui:Destroy()
