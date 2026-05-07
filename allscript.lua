-- === BAD RUDY FLY UI ===
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RudyFlyUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 280, 0, 220)
frame.Position = UDim2.new(0.5, -140, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
title.Text = "🚀 BAD RUDY FLY"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0.9, 0, 0, 50)
toggleBtn.Position = UDim2.new(0.05, 0, 0.3, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
toggleBtn.Text = "NYALAKAN FLY (F)"
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.TextScaled = true
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.Parent = frame

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0.9, 0, 0, 30)
speedLabel.Position = UDim2.new(0.05, 0, 0.55, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Speed: 50"
speedLabel.TextColor3 = Color3.new(1,1,1)
speedLabel.TextScaled = true
speedLabel.Font = Enum.Font.Gotham
speedLabel.Parent = frame

local speedSlider = Instance.new("TextBox")
speedSlider.Size = UDim2.new(0.9, 0, 0, 40)
speedSlider.Position = UDim2.new(0.05, 0, 0.7, 0)
speedSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
speedSlider.Text = "50"
speedSlider.TextColor3 = Color3.new(1,1,1)
speedSlider.TextScaled = true
speedSlider.Font = Enum.Font.Gotham
speedSlider.Parent = frame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextScaled = true
closeBtn.Parent = frame

local flying = false
local speed = 50
local bv = nil
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function startFly()
    if flying then return end
    flying = true
    toggleBtn.Text = "MATIKAN FLY"
    toggleBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    bv = Instance.new("BodyVelocity")
    bv.Name = "RudyFly"
    bv.MaxForce = Vector3.new(400000, 400000, 400000)
    bv.Velocity = Vector3.new(0,0,0)
    bv.Parent = root
    humanoid.PlatformStand = true
end

local function stopFly()
    if not flying then return end
    flying = false
    toggleBtn.Text = "NYALAKAN FLY (F)"
    toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    if bv then bv:Destroy() end
    humanoid.PlatformStand = false
end

toggleBtn.MouseButton1Click:Connect(function()
    if flying then stopFly() else startFly() end
end)

speedSlider.FocusLost:Connect(function()
    local ns = tonumber(speedSlider.Text)
    if ns then
        speed = math.clamp(ns, 10, 500)
        speedSlider.Text = tostring(speed)
        speedLabel.Text = "Speed: " .. speed
    end
end)

closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.F then
        if flying then stopFly() else startFly() end
    end
end)

RunService.Heartbeat:Connect(function()
    if not flying or not bv then return end
    local md = Vector3.new(0,0,0)
    local cam = workspace.CurrentCamera
    if UIS:IsKeyDown(Enum.KeyCode.W) then md += cam.CFrame.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.S) then md -= cam.CFrame.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.A) then md -= cam.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.D) then md += cam.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.Space) then md += Vector3.new(0,1,0) end
