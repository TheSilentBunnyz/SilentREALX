-- Create the UI with better error handling
local success, error = pcall(function()
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    
    local player = Players.LocalPlayer
    local gui = player:WaitForChild("PlayerGui")
    
    -- Clear any existing UI
    if gui:FindFirstChild("UpdateUI") then
        gui:FindFirstChild("UpdateUI"):Destroy()
    end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UpdateUI"
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = gui
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 220)
    mainFrame.Position = UDim2.new(0.5, -200, 0.3, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = mainFrame
    
    -- Title bar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 32)
    titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8, 0, 0)
    titleCorner.Parent = titleBar
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 1, 0)
    title.Position = UDim2.new(0, 12, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Script Updated"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamSemibold
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = titleBar
    
    -- Close button - made more visible
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 24, 0, 24)
    closeBtn.Position = UDim2.new(1, -28, 0, 4)
    closeBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Text = "X"
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 14
    closeBtn.ZIndex = 2
    closeBtn.Parent = titleBar
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 4)
    closeCorner.Parent = closeBtn
    
    -- Content area
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -24, 1, -52)
    content.Position = UDim2.new(0, 12, 0, 40)
    content.BackgroundTransparency = 1
    content.Parent = mainFrame
    
    -- Message
    local message = Instance.new("TextLabel")
    message.Size = UDim2.new(1, 0, 0, 40)
    message.BackgroundTransparency = 1
    message.Text = "The source is outdated, please refer to using the newer one. Security updates only - no new features."
    message.TextColor3 = Color3.fromRGB(200, 200, 200)
    message.Font = Enum.Font.Gotham
    message.TextSize = 12
    message.TextWrapped = true
    message.TextXAlignment = Enum.TextXAlignment.Left
    message.Parent = content
    
    -- Script box
    local scriptBox = Instance.new("Frame")
    scriptBox.Size = UDim2.new(1, 0, 0, 60)
    scriptBox.Position = UDim2.new(0, 0, 0, 50)
    scriptBox.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    scriptBox.BorderSizePixel = 0
    scriptBox.Parent = content
    
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 6)
    boxCorner.Parent = scriptBox
    
    local scriptText = Instance.new("TextLabel")
    scriptText.Size = UDim2.new(1, -12, 1, -12)
    scriptText.Position = UDim2.new(0, 6, 0, 6)
    scriptText.BackgroundTransparency = 1
    scriptText.Text = 'loadstring(game:HttpGet("https://api.junkie-development.de/api/v1/luascripts/public/2402353efa359ea573a3d0e060e57cf9c10435ac0d167e3bc417f351bda74034/download"))()'
    scriptText.TextColor3 = Color3.fromRGB(120, 180, 255)
    scriptText.Font = Enum.Font.Code
    scriptText.TextSize = 11
    scriptText.TextWrapped = true
    scriptText.TextXAlignment = Enum.TextXAlignment.Left
    scriptText.TextYAlignment = Enum.TextYAlignment.Top
    scriptText.Parent = scriptBox
    
    -- Copy button
    local copyBtn = Instance.new("TextButton")
    copyBtn.Size = UDim2.new(1, 0, 0, 36)
    copyBtn.Position = UDim2.new(0, 0, 1, -36)
    copyBtn.BackgroundColor3 = Color3.fromRGB(60, 140, 220)
    copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    copyBtn.Text = "Copy Script"
    copyBtn.Font = Enum.Font.GothamSemibold
    copyBtn.TextSize = 13
    copyBtn.Parent = content
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = copyBtn
    
    -- Dragging functionality
    local dragging = false
    local dragStart, startPos
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Close button functionality
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    -- Copy button functionality
    copyBtn.MouseButton1Click:Connect(function()
        local text = 'loadstring(game:HttpGet("https://api.junkie-development.de/api/v1/luascripts/public/2402353efa359ea573a3d0e060e57cf9c10435ac0d167e3bc417f351bda74034/download"))()'
        
        if setclipboard then
            setclipboard(text)
        end
        
        local originalText = copyBtn.Text
        local originalColor = copyBtn.BackgroundColor3
        
        copyBtn.Text = "Copied!"
        copyBtn.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
        
        wait(1.5)
        
        copyBtn.Text = originalText
        copyBtn.BackgroundColor3 = originalColor
    end)
    
    -- Button hover effects
    closeBtn.MouseEnter:Connect(function()
        closeBtn.BackgroundColor3 = Color3.fromRGB(240, 80, 80)
    end)
    
    closeBtn.MouseLeave:Connect(function()
        closeBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
    end)
    
    copyBtn.MouseEnter:Connect(function()
        copyBtn.BackgroundColor3 = Color3.fromRGB(70, 150, 230)
    end)
    
    copyBtn.MouseLeave:Connect(function()
        copyBtn.BackgroundColor3 = Color3.fromRGB(60, 140, 220)
    end)
    
    print("Update UI loaded successfully!")
end)

if not success then
    warn("Failed to load UI: " .. tostring(error))
end
