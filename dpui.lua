-- StarterPlayerScripts LocalScript

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AdminGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Create a Frame to hold TextBox and Delete Button
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 120)
mainFrame.Position = UDim2.new(0.5, -110, 0.4, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
mainFrame.Parent = screenGui

-- Create TextBox
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0, 200, 0, 40)
textBox.Position = UDim2.new(0, 10, 0, 10)
textBox.PlaceholderText = "Enter player name"
textBox.ClearTextOnFocus = true
textBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
textBox.TextColor3 = Color3.fromRGB(255,255,255)
textBox.Parent = mainFrame

-- Create Delete Button
local deleteButton = Instance.new("TextButton")
deleteButton.Size = UDim2.new(0, 200, 0, 40)
deleteButton.Position = UDim2.new(0, 10, 0, 60)
deleteButton.Text = "Delete PlayerGui"
deleteButton.BackgroundColor3 = Color3.fromRGB(200,50,50)
deleteButton.TextColor3 = Color3.fromRGB(255,255,255)
deleteButton.Parent = mainFrame

-- Delete button functionality
deleteButton.MouseButton1Click:Connect(function()
	local targetName = textBox.Text
	if targetName == "" then return end

	local targetPlayer = Players:FindFirstChild(targetName)
	if targetPlayer and targetPlayer:FindFirstChild("PlayerGui") then
		for _, gui in ipairs(targetPlayer.PlayerGui:GetChildren()) do
			gui:Destroy()
		end
		print("Deleted PlayerGui of " .. targetName)
	else
		warn("Player not found or has no PlayerGui")
	end
end)

-- Create Toggle Button
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 120, 0, 40)
toggleButton.Position = UDim2.new(0.5, -60, 0.3, 0)
toggleButton.Text = "Toggle GUI"
toggleButton.BackgroundColor3 = Color3.fromRGB(50,150,50)
toggleButton.TextColor3 = Color3.fromRGB(255,255,255)
toggleButton.Parent = screenGui

-- Toggle functionality
toggleButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)
