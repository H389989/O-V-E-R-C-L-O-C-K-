-- Tool Collector (PlayerScripts Only) - Mobile Draggable

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local Backpack = player:WaitForChild("Backpack")

-- ===== GUI =====
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.fromScale(0.32, 0.09)
button.Position = UDim2.fromScale(0.34, 0.8)
button.TextScaled = true
button.Text = "COLLECT: OFF"
button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.AutoButtonColor = false
button.Parent = gui

button.ZIndex = 10
button.Active = true
button.Draggable = false -- custom drag for mobile

-- ===== STATE =====
local enabled = false
local connection

-- ===== TOOL COLLECTOR =====
local function collectTools()
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("Tool") then
			pcall(function()
				obj.Parent = Backpack
			end)
		end
	end
end

-- ===== TOGGLE =====
button.MouseButton1Click:Connect(function()
	enabled = not enabled
	button.Text = enabled and "COLLECT: ON" or "COLLECT: OFF"
	button.BackgroundColor3 = enabled
		and Color3.fromRGB(170, 40, 40)
		or Color3.fromRGB(30, 30, 30)

	if enabled then
		connection = RunService.Heartbeat:Connect(collectTools)
	else
		if connection then
			connection:Disconnect()
			connection = nil
		end
	end
end)

-- ===== DRAG SYSTEM (MOBILE + PC) =====
local dragging = false
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	button.Position = UDim2.fromOffset(
		startPos.X.Offset + delta.X,
		startPos.Y.Offset + delta.Y
	)
end

button.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = button.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

button.InputChanged:Connect(function(input)
	if dragging and (
		input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
	) then
		update(input)
	end
end)
