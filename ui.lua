local Library = {}

local coreGui = game:GetService("CoreGui")
local existingGui = coreGui:FindFirstChild("xdd")
if existingGui then
    existingGui:Destroy()
end

local mainGui = Instance.new("ScreenGui")
mainGui.Parent = coreGui
mainGui.Name = "xdd"

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Consistent Color Palette (Dark Purple Aesthetic Theme) with increased transparency
local Colors = {
    Primary = Color3.fromRGB(140, 70, 255),       -- Rich electric purple
    LightPrimary = Color3.fromRGB(180, 130, 255), -- Soft lavender highlight
    DarkPrimary = Color3.fromRGB(40, 0, 80),      -- Deep violet shadow tone
    Background = Color3.fromRGB(15, 5, 25),       -- Near-black purple background
    Text = Color3.fromRGB(235, 220, 255),         -- Soft glowing white-purple text
    Accent = Color3.fromRGB(160, 100, 255),       -- Muted purple accent
    Success = Color3.fromRGB(100, 230, 150),      -- Cool mint green
    Danger = Color3.fromRGB(230, 70, 70)          -- Deep red danger tone
}

-- Utility Functions
local function addCorner(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = instance
end

local function addStroke(instance, thickness, color)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness
    stroke.Color = color or Colors.Accent
    stroke.Transparency = 0.7 -- Increased transparency for strokes
    stroke.Parent = instance
end

-- Main UI Creation
function Library:CreateUI(title, description)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = mainGui

    local Sound = Instance.new("Sound", game:GetService("SoundService"))
    Sound.SoundId = "rbxassetid://9120129807"
    Sound:Play()

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 590, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -295, 0.5, -150)
    MainFrame.BackgroundColor3 = Colors.Background
    MainFrame.BackgroundTransparency = 0.3 -- Increased transparency
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui
    addCorner(MainFrame, 8)
    addStroke(MainFrame, 2)

    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 60) -- Увеличена высота для размещения описания
    TopBar.BackgroundColor3 = Colors.DarkPrimary
    TopBar.BackgroundTransparency = 0.4 -- Increased transparency
    TopBar.ZIndex = 10
    TopBar.Parent = MainFrame
    addCorner(TopBar, 6)

    local ResizeButton = Instance.new("TextButton")
    ResizeButton.Size = UDim2.new(0, 24, 0, 24)
    ResizeButton.Position = UDim2.new(1, -28, 1, -28)
    ResizeButton.BackgroundColor3 = Colors.LightPrimary
    ResizeButton.BackgroundTransparency = 0.7 -- Increased transparency
    ResizeButton.Text = "↘"
    ResizeButton.TextSize = 14
    ResizeButton.Font = Enum.Font.Gotham
    ResizeButton.TextColor3 = Colors.Text
    ResizeButton.ZIndex = 15
    ResizeButton.Parent = MainFrame
    addCorner(ResizeButton, 4)

    local dragging, startPos, startSize
    ResizeButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startPos = input.Position
            startSize = MainFrame.Size
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - startPos
            MainFrame.Size = UDim2.new(0, math.max(300, startSize.X.Offset + delta.X), 0, math.max(200, startSize.Y.Offset + delta.Y))
        end
    end)

    local BackgroundOverlay = Instance.new("Frame")
    BackgroundOverlay.Size = UDim2.new(1, 0, 1, 0)
    BackgroundOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BackgroundOverlay.BackgroundTransparency = 0.8 -- Increased transparency
    BackgroundOverlay.ZIndex = 18
    BackgroundOverlay.Visible = false
    BackgroundOverlay.Parent = MainFrame
    addCorner(BackgroundOverlay, 8)

    local SettingsFrame = Instance.new("Frame")
    SettingsFrame.Size = UDim2.new(0, 320, 0, 160)
    SettingsFrame.Position = UDim2.new(0.5, -160, 0.5, -80)
    SettingsFrame.BackgroundColor3 = Colors.Background
    SettingsFrame.BackgroundTransparency = 0.4 -- Increased transparency
    SettingsFrame.ZIndex = 19
    SettingsFrame.Parent = BackgroundOverlay
    addCorner(SettingsFrame, 8)
    addStroke(SettingsFrame, 2)

    local SettingsLabel = Instance.new("TextLabel")
    SettingsLabel.Size = UDim2.new(1, 0, 0, 40)
    SettingsLabel.Text = "Settings"
    SettingsLabel.TextSize = 16
    SettingsLabel.Font = Enum.Font.GothamBold
    SettingsLabel.TextColor3 = Colors.Text
    SettingsLabel.BackgroundTransparency = 1
    SettingsLabel.ZIndex = 20
    SettingsLabel.Parent = SettingsFrame

    local Separator = Instance.new("Frame")
    Separator.Size = UDim2.new(1, -20, 0, 2)
    Separator.Position = UDim2.new(0, 10, 0, 40)
    Separator.BackgroundColor3 = Colors.Accent
    Separator.BackgroundTransparency = 0.5 -- Increased transparency
    Separator.ZIndex = 20
    Separator.Parent = SettingsFrame

    local DestroyButton = Instance.new("TextButton")
    DestroyButton.Size = UDim2.new(0, 30, 0, 30)
    DestroyButton.Position = UDim2.new(1, -70, 0, 3)
    DestroyButton.BackgroundColor3 = Colors.Danger
    DestroyButton.BackgroundTransparency = 0.5 -- Increased transparency
    DestroyButton.Text = "X"
    DestroyButton.TextSize = 20
    DestroyButton.Font = Enum.Font.GothamBold
    DestroyButton.TextColor3 = Colors.Text
    DestroyButton.ZIndex = 11
    DestroyButton.Parent = TopBar
    addCorner(DestroyButton, 6)

    local SettingsButton = Instance.new("TextButton")
    SettingsButton.Size = UDim2.new(0, 30, 0, 30)
    SettingsButton.Position = UDim2.new(1, -35, 0, 3)
    SettingsButton.BackgroundColor3 = Colors.Primary
    SettingsButton.BackgroundTransparency = 0.5 -- Increased transparency
    SettingsButton.Text = "⚙️"
    SettingsButton.TextSize = 18
    SettingsButton.Font = Enum.Font.SourceSans
    SettingsButton.TextColor3 = Colors.Text
    SettingsButton.ZIndex = 11
    SettingsButton.Parent = TopBar
    addCorner(SettingsButton, 6)

    local ConfirmationOverlay = Instance.new("Frame")
    ConfirmationOverlay.Size = UDim2.new(1, 0, 1, 0)
    ConfirmationOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ConfirmationOverlay.BackgroundTransparency = 0.8 -- Increased transparency
    ConfirmationOverlay.ZIndex = 18
    ConfirmationOverlay.Visible = false
    ConfirmationOverlay.Parent = MainFrame
    addCorner(ConfirmationOverlay, 8)

    local ConfirmationWindow = Instance.new("Frame")
    ConfirmationWindow.Size = UDim2.new(0, 320, 0, 160)
    ConfirmationWindow.Position = UDim2.new(0.5, -160, 0.5, -80)
    ConfirmationWindow.BackgroundColor3 = Colors.Background
    ConfirmationWindow.BackgroundTransparency = 0.4 -- Increased transparency
    ConfirmationWindow.ZIndex = 19
    ConfirmationWindow.Parent = ConfirmationOverlay
    addCorner(ConfirmationWindow, 8)
    addStroke(ConfirmationWindow, 2)

    local ConfirmationText = Instance.new("TextLabel")
    ConfirmationText.Size = UDim2.new(1, 0, 0, 60)
    ConfirmationText.Text = "Are you sure you want to destroy the GUI?"
    ConfirmationText.TextSize = 14
    ConfirmationText.Font = Enum.Font.Gotham
    ConfirmationText.TextColor3 = Colors.Text
    ConfirmationText.BackgroundTransparency = 1
    ConfirmationText.TextWrapped = true
    ConfirmationText.ZIndex = 20
    ConfirmationText.Parent = ConfirmationWindow

    local ConfirmButton = Instance.new("TextButton")
    ConfirmButton.Size = UDim2.new(0.5, -10, 0, 40)
    ConfirmButton.Position = UDim2.new(0, 5, 1, -45)
    ConfirmButton.BackgroundColor3 = Colors.Danger
    ConfirmButton.BackgroundTransparency = 0.4 -- Increased transparency
    ConfirmButton.Text = "Yes"
    ConfirmButton.TextSize = 16
    ConfirmButton.Font = Enum.Font.Gotham
    ConfirmButton.TextColor3 = Colors.Text
    ConfirmButton.ZIndex = 20
    ConfirmButton.Parent = ConfirmationWindow
    addCorner(ConfirmButton, 6)

    local CancelButton = Instance.new("TextButton")
    CancelButton.Size = UDim2.new(0.5, -10, 0, 40)
    CancelButton.Position = UDim2.new(0.5, 5, 1, -45)
    CancelButton.BackgroundColor3 = Colors.Success
    CancelButton.BackgroundTransparency = 0.4 -- Increased transparency
    CancelButton.Text = "No"
    CancelButton.TextSize = 16
    CancelButton.Font = Enum.Font.Gotham
    CancelButton.TextColor3 = Colors.Text
    CancelButton.ZIndex = 20
    CancelButton.Parent = ConfirmationWindow
    addCorner(CancelButton, 6)

    DestroyButton.MouseButton1Click:Connect(function()
        ConfirmationOverlay.Visible = true
    end)

    ConfirmButton.MouseButton1Click:Connect(function()
        MainFrame:Destroy()
    end)

    CancelButton.MouseButton1Click:Connect(function()
        ConfirmationOverlay.Visible = false
    end)

    SettingsButton.MouseButton1Click:Connect(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://17208399163"
        sound.Volume = 0.5
        sound.PlayOnRemove = true
        sound.Parent = SettingsButton
        sound:Destroy()
        BackgroundOverlay.Visible = not BackgroundOverlay.Visible
    end)

    local ToggleButton = Instance.new("ImageButton")
    ToggleButton.Size = UDim2.new(0, 50, 0, 50)
    ToggleButton.Position = UDim2.new(0.14, 0, 0.1, 0)
    ToggleButton.BackgroundColor3 = Colors.Primary
    ToggleButton.BackgroundTransparency = 0.8 -- Increased transparency
    ToggleButton.Image = "rbxassetid://123500046281559" -- Replace with your image ID (Texture)
    ToggleButton.ScaleType = Enum.ScaleType.Fit
    ToggleButton.Draggable = true
    ToggleButton.Parent = ScreenGui
    addCorner(ToggleButton, 8)
    addStroke(ToggleButton, 2)

    local isActive = true
    ToggleButton.MouseButton1Click:Connect(function()
        isActive = not isActive
        MainFrame.Visible = isActive
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://10066968815"
        sound.Parent = ToggleButton
        sound:Play()
        TweenService:Create(ToggleButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 60, 0, 60)}):Play()
        task.wait(0.2)
        TweenService:Create(ToggleButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 50, 0, 50)}):Play()
    end)

    local Line = Instance.new("Frame")
    Line.Size = UDim2.new(1, 0, 0, 2)
    Line.Position = UDim2.new(0, 0, 1, -2)
    Line.BackgroundColor3 = Colors.Accent
    Line.BackgroundTransparency = 0.5 -- Increased transparency
    Line.ZIndex = 12
    Line.Parent = TopBar

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(0, 300, 0, 20)
    TitleLabel.Position = UDim2.new(0, 10, 0, 5)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextSize = 16
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextColor3 = Colors.Text
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.ZIndex = 11
    TitleLabel.Parent = TopBar

    local DescriptionLabel = Instance.new("TextLabel")
    DescriptionLabel.Size = UDim2.new(0, 300, 0, 20)
    DescriptionLabel.Position = UDim2.new(0, 10, 0, 25)
    DescriptionLabel.BackgroundTransparency = 1
    DescriptionLabel.Text = description
    DescriptionLabel.TextSize = 14
    DescriptionLabel.Font = Enum.Font.Gotham
    DescriptionLabel.TextColor3 = Colors.Text
    DescriptionLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescriptionLabel.ZIndex = 11
    DescriptionLabel.Parent = TopBar

    local TabsContainer = Instance.new("ScrollingFrame")
    TabsContainer.Size = UDim2.new(0.3, 0, 1, -64)
    TabsContainer.Position = UDim2.new(0, 5, 0, 64)
    TabsContainer.BackgroundTransparency = 1
    TabsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabsContainer.ScrollBarThickness = 0
    TabsContainer.Parent = MainFrame
    addCorner(TabsContainer, 6)

    local TabsListLayout = Instance.new("UIListLayout")
    TabsListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabsListLayout.Padding = UDim.new(0, 12)
    TabsListLayout.Parent = TabsContainer

    local Padding = Instance.new("UIPadding")
    Padding.PaddingLeft = UDim.new(0, 8)
    Padding.PaddingRight = UDim.new(0, 8)
    Padding.Parent = TabsContainer

    TabsListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabsContainer.CanvasSize = UDim2.new(0, 0, 0, TabsListLayout.AbsoluteContentSize.Y + 16)
    end)

    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0.7, -10, 1, -64)
    Container.Position = UDim2.new(0.3, 5, 0, 64)
    Container.BackgroundTransparency = 1
    Container.Parent = MainFrame
    addCorner(Container, 6)

    local Tab = {TabsContainer = TabsContainer, Container = Container}

    function Tab:AddTab(isPremium, tabName)
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, -16, 0, 40)
        TabButton.Text = tabName
        TabButton.Font = Enum.Font.Gotham
        TabButton.TextSize = 16
        TabButton.BackgroundColor3 = Colors.Primary
        TabButton.BackgroundTransparency = 0.7 -- Increased transparency
        TabButton.TextColor3 = Colors.Text
        TabButton.Parent = TabsContainer
        addCorner(TabButton, 6)
        addStroke(TabButton, 2)

        local TabFrame = Instance.new("Frame")
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.BackgroundTransparency = 1
        TabFrame.Visible = false
        TabFrame.Parent = Container

        local FrameScroll = Instance.new("ScrollingFrame")
        FrameScroll.Size = UDim2.new(1, -10, 1, -10)
        FrameScroll.Position = UDim2.new(0, 5, 0, 5)
        FrameScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
        FrameScroll.ScrollBarThickness = 0
        FrameScroll.BackgroundTransparency = 1
        FrameScroll.Parent = TabFrame
        addCorner(FrameScroll, 6)

        local ButtonLayout = Instance.new("UIListLayout")
        ButtonLayout.Padding = UDim.new(0, 12)
        ButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ButtonLayout.Parent = FrameScroll

        local Padding = Instance.new("UIPadding")
        Padding.PaddingLeft = UDim.new(0, 8)
        Padding.PaddingRight = UDim.new(0, 8)
        Padding.Parent = FrameScroll

        ButtonLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            FrameScroll.CanvasSize = UDim2.new(0, 0, 0, ButtonLayout.AbsoluteContentSize.Y + 16)
        end)

        TabButton.MouseButton1Click:Connect(function()
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://16480549841"
            sound.Volume = 0.5
            sound.PlayOnRemove = true
            sound.Parent = TabButton
            sound:Destroy()

            for _, button in pairs(TabsContainer:GetChildren()) do
                if button:IsA("TextButton") then
                    button.BackgroundColor3 = Colors.Primary
                    button.BackgroundTransparency = 0.7
                end
            end
            TabButton.BackgroundColor3 = Colors.LightPrimary
            TabButton.BackgroundTransparency = 0.4 -- Increased transparency

            for _, frame in pairs(Container:GetChildren()) do
                if frame:IsA("Frame") then frame.Visible = false end
            end
            TabFrame.Visible = true
        end)

        return FrameScroll
    end

    return Tab
end

-- UI Elements
function Library.addButton(container, buttonText, descriptionText, callback)
    if not container then
        error("Container is nil. Please provide a valid container for the button.")
    end

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 50)
    Button.Text = buttonText
    Button.TextSize = 16
    Button.Font = Enum.Font.Gotham
    Button.BackgroundColor3 = Colors.Primary
    Button.BackgroundTransparency = 0.7 -- Increased transparency
    Button.TextColor3 = Colors.Text
    Button.Parent = container
    addCorner(Button, 6)
    addStroke(Button, 2)

    local Description = Instance.new("TextLabel")
    Description.Size = UDim2.new(1, -20, 0, 20)
    Description.Position = UDim2.new(0, 10, 0, 25)
    Description.Text = descriptionText or ""
    Description.TextSize = 12
    Description.Font = Enum.Font.Gotham
    Description.BackgroundTransparency = 1
    Description.TextColor3 = Colors.Text
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.Parent = Button

    Button.MouseEnter:Connect(function()
        Button.BackgroundTransparency = 0.5 -- Increased transparency
    end)
    Button.MouseLeave:Connect(function()
        Button.BackgroundTransparency = 0.7 -- Increased transparency
    end)

    Button.MouseButton1Click:Connect(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://99437156604053"
        sound.Volume = 0.5
        sound.PlayOnRemove = true
        sound.Parent = Button
        sound:Destroy()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Colors.LightPrimary}):Play()
        task.wait(0.2)
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Primary}):Play()
        callback()
    end)

    return Button, Description
end

function Library.AddColorPicker(container, labelText, defaultColor, callback)
    if not container then
        error("Container is nil. Please provide a valid container for the color picker.")
    end

    local ColorPicker = Instance.new("Frame")
    ColorPicker.Size = UDim2.new(1, 0, 0, 50)
    ColorPicker.BackgroundColor3 = Colors.Background
    ColorPicker.BackgroundTransparency = 0.7 -- Increased transparency
    ColorPicker.Parent = container
    addCorner(ColorPicker, 6)
    addStroke(ColorPicker, 2)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.5, 0, 1, 0)
    Label.Text = labelText
    Label.TextSize = 16
    Label.Font = Enum.Font.Gotham
    Label.TextColor3 = Colors.Text
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Parent = ColorPicker

    local PickerFrame = Instance.new("Frame")
    PickerFrame.Size = UDim2.new(0, 120, 0, 30)
    PickerFrame.Position = UDim2.new(1, -130, 0.5, -15)
    PickerFrame.BackgroundColor3 = defaultColor or Colors.Primary
    PickerFrame.BackgroundTransparency = 0.3 -- Slightly increased transparency
    PickerFrame.Parent = ColorPicker
    addCorner(PickerFrame, 6)

    local OpenButton = Instance.new("TextButton")
    OpenButton.Size = UDim2.new(1, 0, 1, 0)
    OpenButton.Text = ""
    OpenButton.BackgroundTransparency = 1
    OpenButton.Parent = PickerFrame

    local Popup = Instance.new("Frame")
    Popup.Size = UDim2.new(0, 300, 0, 160)
    Popup.Position = UDim2.new(0.5, -150, 0.5, -80)
    Popup.BackgroundColor3 = Colors.Background
    Popup.BackgroundTransparency = 0.4 -- Increased transparency
    Popup.Visible = false
    Popup.ZIndex = 10
    Popup.Parent = container
    addCorner(Popup, 8)
    addStroke(Popup, 2)

    local ColorWheel = Instance.new("ImageLabel")
    ColorWheel.Size = UDim2.new(0, 140, 0, 140)
    ColorWheel.Position = UDim2.new(0.5, -70, 0, 10)
    ColorWheel.Image = "rbxassetid://142488478"
    ColorWheel.BackgroundTransparency = 1
    ColorWheel.Active = true
    ColorWheel.ZIndex = 11
    ColorWheel.Parent = Popup

    local Selector = Instance.new("Frame")
    Selector.Size = UDim2.new(0, 10, 0, 10)
    Selector.BackgroundColor3 = Colors.Text
    Selector.BackgroundTransparency = 0.3 -- Increased transparency
    Selector.ZIndex = 12
    Selector.Parent = ColorWheel
    addCorner(Selector, 5)

    local ConfirmButton = Instance.new("TextButton")
    ConfirmButton.Size = UDim2.new(0.5, -10, 0, 30)
    ConfirmButton.Position = UDim2.new(0, 5, 1, -35)
    ConfirmButton.Text = "Confirm"
    ConfirmButton.TextSize = 14
    ConfirmButton.Font = Enum.Font.Gotham
    ConfirmButton.TextColor3 = Colors.Text
    ConfirmButton.BackgroundColor3 = Colors.Success
    ConfirmButton.BackgroundTransparency = 0.4 -- Increased transparency
    ConfirmButton.ZIndex = 11
    ConfirmButton.Parent = Popup
    addCorner(ConfirmButton, 6)

    local RainbowButton = Instance.new("TextButton")
    RainbowButton.Size = UDim2.new(0.5, -10, 0, 30)
    RainbowButton.Position = UDim2.new(0.5, 5, 1, -35)
    RainbowButton.Text = "Rainbow"
    RainbowButton.TextSize = 14
    RainbowButton.Font = Enum.Font.Gotham
    RainbowButton.TextColor3 = Colors.Text
    RainbowButton.BackgroundColor3 = Colors.Primary
    RainbowButton.BackgroundTransparency = 0.4 -- Increased transparency
    RainbowButton.ZIndex = 11
    RainbowButton.Parent = Popup
    addCorner(RainbowButton, 6)

    local rainbowActive = false
    local rainbowConnection

    local function updateColor(input)
        local pos = Vector2.new(input.Position.X, input.Position.Y) - ColorWheel.AbsolutePosition
        local x = math.clamp(pos.X / ColorWheel.AbsoluteSize.X, 0, 1)
        local y = math.clamp(pos.Y / ColorWheel.AbsoluteSize.Y, 0, 1)
        Selector.Position = UDim2.new(x, -5, y, -5)
        PickerFrame.BackgroundColor3 = Color3.fromHSV(x, 1 - y, 1)
        if callback then callback(PickerFrame.BackgroundColor3) end
    end

    ColorWheel.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            updateColor(input)
            local conn
            conn = UserInputService.InputChanged:Connect(function(moveInput)
                if moveInput.UserInputType == Enum.UserInputType.MouseMovement or moveInput.UserInputType == Enum.UserInputType.Touch then
                    updateColor(moveInput)
                end
            end)
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then conn:Disconnect() end
            end)
        end
    end)

    ConfirmButton.MouseButton1Click:Connect(function()
        Popup.Visible = false
        if callback then callback(PickerFrame.BackgroundColor3) end
    end)

    RainbowButton.MouseButton1Click:Connect(function()
        rainbowActive = not rainbowActive
        RainbowButton.BackgroundColor3 = rainbowActive and Colors.DarkPrimary or Colors.Primary
        if rainbowActive then
            local step = 0
            rainbowConnection = game:GetService("RunService").RenderStepped:Connect(function(delta)
                step = (step + delta * 0.5) % 1
                local color = Color3.fromHSV(step, 1, 1)
                PickerFrame.BackgroundColor3 = color
                if callback then callback(color) end
            end)
        else
            if rainbowConnection then rainbowConnection:Disconnect() end
        end
    end)

    OpenButton.MouseButton1Click:Connect(function()
        Popup.Visible = not Popup.Visible
    end)

    return ColorPicker
end

function Library.addToggle(container, labelText, descriptionText, defaultState, callback)
    if not container then
        error("Container is nil. Please provide a valid container for the toggle.")
    end

    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 50)
    ToggleFrame.BackgroundColor3 = Colors.Background
    ToggleFrame.BackgroundTransparency = 0.7 -- Increased transparency
    ToggleFrame.Parent = container
    addCorner(ToggleFrame, 6)
    addStroke(ToggleFrame, 2)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -80, 0, 20)
    Label.Position = UDim2.new(0, 10, 0, 5)
    Label.Text = labelText
    Label.TextSize = 16
    Label.Font = Enum.Font.Gotham
    Label.TextColor3 = Colors.Text
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame

    local Description = Instance.new("TextLabel")
    Description.Size = UDim2.new(1, -80, 0, 20)
    Description.Position = UDim2.new(0, 10, 0, 25)
    Description.Text = descriptionText or ""
    Description.TextSize = 12
    Description.Font = Enum.Font.Gotham
    Description.BackgroundTransparency = 1
    Description.TextColor3 = Colors.Text
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.Parent = ToggleFrame

    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 50, 0, 24)
    ToggleButton.Position = UDim2.new(1, -60, 0.5, -12)
    ToggleButton.BackgroundColor3 = Colors.Primary
    ToggleButton.BackgroundTransparency = 0.7 -- Increased transparency
    ToggleButton.Text = ""
    ToggleButton.Parent = ToggleFrame
    addCorner(ToggleButton, 12)

    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.new(0, 20, 0, 20)
    Indicator.BackgroundColor3 = defaultState and Colors.Success or Colors.Danger
    Indicator.BackgroundTransparency = 0.3 -- Increased transparency
    Indicator.Position = UDim2.new(defaultState and 0.6 or 0.1, 0, 0.5, -10)
    Indicator.Parent = ToggleButton
    addCorner(Indicator, 10)

    local function updateToggle(state)
        TweenService:Create(Indicator, TweenInfo.new(0.2), {
            Position = UDim2.new(state and 0.6 or 0.1, 0, 0.5, -10),
            BackgroundColor3 = state and Colors.Success or Colors.Danger
        }):Play()
        callback(state)
    end

    ToggleButton.MouseButton1Click:Connect(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://99437156604053"
        sound.Volume = 0.5
        sound.PlayOnRemove = true
        sound.Parent = ToggleButton
        sound:Destroy()
        defaultState = not defaultState
        updateToggle(defaultState)
    end)

    updateToggle(defaultState)
    return ToggleFrame, Description
end

function Library.addSlider(container, name, descriptionText, minValue, maxValue, defaultValue, callback)
    if not container then
        error("Container is nil. Please provide a valid container for the slider.")
    end

    local hasDescription = descriptionText and descriptionText ~= ""
    local frameHeight = hasDescription and 70 or 50

    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, frameHeight)
    SliderFrame.BackgroundColor3 = Colors.Background
    SliderFrame.BackgroundTransparency = 0.7 -- Increased transparency
    SliderFrame.Parent = container
    addCorner(SliderFrame, 6)
    addStroke(SliderFrame, 2)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -80, 0, 20)
    Label.Position = UDim2.new(0, 10, 0, 5)
    Label.Text = name
    Label.TextSize = 16
    Label.Font = Enum.Font.Gotham
    Label.TextColor3 = Colors.Text
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame

    if hasDescription then
        local Description = Instance.new("TextLabel")
        Description.Size = UDim2.new(1, -80, 0, 20)
        Description.Position = UDim2.new(0, 10, 0, 25)
        Description.Text = descriptionText
        Description.TextSize = 12
        Description.Font = Enum.Font.Gotham
        Description.BackgroundTransparency = 1
        Description.TextColor3 = Colors.Text
        Description.TextXAlignment = Enum.TextXAlignment.Left
        Description.Parent = SliderFrame
    end

    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(0, 60, 0, 24)
    TextBox.Position = UDim2.new(1, -70, 0, 5)
    TextBox.Text = tostring(defaultValue)
    TextBox.TextSize = 14
    TextBox.Font = Enum.Font.Gotham
    TextBox.TextColor3 = Colors.Text
    TextBox.BackgroundColor3 = Colors.DarkPrimary
    TextBox.BackgroundTransparency = 0.7 -- Increased transparency
    TextBox.TextXAlignment = Enum.TextXAlignment.Center
    TextBox.Parent = SliderFrame
    addCorner(TextBox, 6)

    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(1, -80, 0, 8)
    Track.Position = UDim2.new(0, 10, 1, hasDescription and -14 or -14)
    Track.BackgroundColor3 = Colors.DarkPrimary
    Track.BackgroundTransparency = 0.7 -- Increased transparency
    Track.Parent = SliderFrame
    addCorner(Track, 4)

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new(0, 0, 1, 0)
    Fill.BackgroundColor3 = Colors.Primary
    Fill.BackgroundTransparency = 0.5 -- Increased transparency
    Fill.Parent = Track
    addCorner(Fill, 4)

    local Thumb = Instance.new("Frame")
    Thumb.Size = UDim2.new(0, 24, 0, 24)
    Thumb.AnchorPoint = Vector2.new(0.5, 0.5)
    Thumb.BackgroundColor3 = Colors.LightPrimary
    Thumb.BackgroundTransparency = 0.5 -- Increased transparency
    Thumb.Position = UDim2.new(0, 0, 0.5, 0)
    Thumb.ZIndex = 2
    Thumb.Parent = Track
    addCorner(Thumb, 12)

    local function update(value)
        value = math.clamp(math.floor(value + 0.5), minValue, maxValue)
        local ratio = (value - minValue) / (maxValue - minValue)
        Fill.Size = UDim2.new(ratio, 0, 1, 0)
        Thumb.Position = UDim2.new(ratio, 0, 0.5, 0)
        TextBox.Text = tostring(value)
        if callback then
            callback(value)
        end
    end

    Track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local function move(moveInput)
                local x = math.clamp((moveInput.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
                update(minValue + x * (maxValue - minValue))
            end
            move(input)
            local conn = UserInputService.InputChanged:Connect(function(moveInput)
                if moveInput.UserInputType == Enum.UserInputType.MouseMovement or moveInput.UserInputType == Enum.UserInputType.Touch then
                    move(moveInput)
                end
            end)
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then conn:Disconnect() end
            end)
        end
    end)

    TextBox.FocusLost:Connect(function()
        local val = tonumber(TextBox.Text)
        if val then
            update(val)
        else
            update(defaultValue)
        end
    end)

    update(defaultValue)
end

function Library.addDropdown(container, labelText, buttonText, options, callback)
    if not container then
        error("Container is nil. Please provide a valid container for the dropdown.")
    end

    local Dropdown = Instance.new("Frame")
    Dropdown.Size = UDim2.new(1, 0, 0, 50)
    Dropdown.BackgroundColor3 = Colors.Background
    Dropdown.BackgroundTransparency = 0.7 -- Increased transparency
    Dropdown.Parent = container
    addCorner(Dropdown, 6)
    addStroke(Dropdown, 2)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.5, 0, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = labelText
    Label.TextSize = 16
    Label.Font = Enum.Font.Gotham
    Label.TextColor3 = Colors.Text
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Dropdown

    local DropdownButton = Instance.new("TextButton")
    DropdownButton.Size = UDim2.new(0, 120, 0, 30)
    DropdownButton.Position = UDim2.new(1, -130, 0.5, -15)
    DropdownButton.Text = buttonText
    DropdownButton.TextSize = 14
    DropdownButton.Font = Enum.Font.Gotham
    DropdownButton.TextColor3 = Colors.Text
    DropdownButton.BackgroundColor3 = Colors.Primary
    DropdownButton.BackgroundTransparency = 0.7 -- Increased transparency
    DropdownButton.Parent = Dropdown
    addCorner(DropdownButton, 6)

    local Arrow = Instance.new("TextLabel")
    Arrow.Size = UDim2.new(0, 20, 1, 0)
    Arrow.Position = UDim2.new(1, -20, 0, 0)
    Arrow.Text = "▼"
    Arrow.TextSize = 14
    Arrow.Font = Enum.Font.Gotham
    Arrow.TextColor3 = Colors.Text
    Arrow.BackgroundTransparency = 1
    Arrow.Parent = DropdownButton

    local DropdownList = Instance.new("Frame")
    DropdownList.Size = UDim2.new(0, 120, 0, 0)
    DropdownList.BackgroundColor3 = Colors.DarkPrimary
    DropdownList.BackgroundTransparency = 0.4 -- Increased transparency
    DropdownList.ClipsDescendants = true
    DropdownList.Visible = false
    DropdownList.Parent = container
    addCorner(DropdownList, 6)

    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.ScrollBarThickness = 0
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollFrame.Parent = DropdownList

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 4)
    Layout.Parent = ScrollFrame

    local function updateSize()
        local height = math.min(Layout.AbsoluteContentSize.Y, 120)
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y)
        return height
    end

    local function createOptions(options)
        for _, child in pairs(ScrollFrame:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end
        for _, option in pairs(options) do
            local OptionButton = Instance.new("TextButton")
            OptionButton.Size = UDim2.new(1, 0, 0, 30)
            OptionButton.Text = option
            OptionButton.TextSize = 14
            OptionButton.Font = Enum.Font.Gotham
            OptionButton.TextColor3 = Colors.Text
            OptionButton.BackgroundColor3 = Colors.Primary
            OptionButton.BackgroundTransparency = 0.7 -- Increased transparency
            OptionButton.Parent = ScrollFrame
            addCorner(OptionButton, 4)

            OptionButton.MouseEnter:Connect(function()
                OptionButton.BackgroundTransparency = 0.5 -- Increased transparency
            end)
            OptionButton.MouseLeave:Connect(function()
                OptionButton.BackgroundTransparency = 0.7 -- Increased transparency
            end)

            OptionButton.MouseButton1Click:Connect(function()
                DropdownButton.Text = option
                DropdownList.Visible = false
                Arrow.Text = "▼"
                if callback then callback(option) end
            end)
        end
    end

    createOptions(options)

    DropdownButton.MouseButton1Click:Connect(function()
        if DropdownList.Visible then
            TweenService:Create(DropdownList, TweenInfo.new(0.3), {Size = UDim2.new(0, 120, 0, 0)}):Play()
            task.wait(0.3)
            DropdownList.Visible = false
            Arrow.Text = "▼"
        else
            local absPos = Dropdown.AbsolutePosition
            DropdownList.Position = UDim2.new(0, absPos.X + Dropdown.Size.X.Offset - 130, 0, absPos.Y + 50)
            DropdownList.Visible = true
            local height = updateSize()
            TweenService:Create(DropdownList, TweenInfo.new(0.3), {Size = UDim2.new(0, 120, 0, height)}):Play()
            Arrow.Text = "▲"
        end
    end)

    function Library.updateDropdownOptions(newOptions)
        createOptions(newOptions)
    end
end

function Library.addTextbox(container, labelText, placeholderText, defaultText, callback)
    if not container then
        error("Container is nil. Please provide a valid container for the textbox.")
    end

    local TextboxFrame = Instance.new("Frame")
    TextboxFrame.Size = UDim2.new(1, 0, 0, 50)
    TextboxFrame.BackgroundColor3 = Colors.Background
    TextboxFrame.BackgroundTransparency = 0.7 -- Increased transparency
    TextboxFrame.Parent = container
    addCorner(TextboxFrame, 6)
    addStroke(TextboxFrame, 2)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.5, 0, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = labelText
    Label.TextSize = 16
    Label.Font = Enum.Font.Gotham
    Label.TextColor3 = Colors.Text
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = TextboxFrame

    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(0, 120, 0, 30)
    TextBox.Position = UDim2.new(1, -130, 0.5, -15)
    TextBox.Text = defaultText
    TextBox.PlaceholderText = placeholderText
    TextBox.TextSize = 14
    TextBox.Font = Enum.Font.Gotham
    TextBox.TextColor3 = Colors.Text
    TextBox.BackgroundColor3 = Colors.DarkPrimary
    TextBox.BackgroundTransparency = 0.7 -- Increased transparency
    TextBox.Parent = TextboxFrame
    addCorner(TextBox, 6)

    TextBox.FocusLost:Connect(function(enterPressed)
        if enterPressed and callback then callback(TextBox.Text) end
    end)
end

function Library.addLivePlayerInfo(container)
    local Players = game:GetService("Players")
    local Stats = game:GetService("Stats")
    local RunService = game:GetService("RunService")
    
    local player = Players.LocalPlayer
    repeat task.wait() until player and player.UserId > 0

    -- Create the paragraph once
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, 0, 0, 150)
    section.BackgroundColor3 = Colors.DarkPrimary
    section.BackgroundTransparency = 0.7
    section.Parent = container
    addCorner(section, 6)

    -- Thumbnail (headshot)
    local thumb = Instance.new("ImageLabel")
    thumb.Size = UDim2.new(0, 80, 0, 80)
    thumb.Position = UDim2.new(0, 10, 0, 35)
    thumb.BackgroundTransparency = 1
    thumb.Image = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=80&h=80"
    thumb.Parent = section
    addCorner(thumb, 40)

    -- Live text label
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -100, 0, 80)
    textLabel.Position = UDim2.new(0, 100, 0, 35)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Colors.Text
    textLabel.TextSize = 14
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextYAlignment = Enum.TextYAlignment.Top
    textLabel.TextWrapped = true
    textLabel.Parent = section

    -- Title label (optional)
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 0, 25)
    title.Position = UDim2.new(0, 10, 0, 5)
    title.Text = "Player Info"
    title.TextSize = 18
    title.Font = Enum.Font.GothamBold
    title.TextColor3 = Colors.Text
    title.BackgroundTransparency = 1
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = section

    -- Live update loop
    task.spawn(function()
        while task.wait(1) do
            local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue() + 0.5)
            local fps = math.floor(1 / RunService.Heartbeat:Wait())

            textLabel.Text = string.format(
                "Good evening, %s\n@%s\nPing: %dms • FPS: %d",
                player.DisplayName,
                player.Name,
                ping,
                fps
            )
        end
    end)

    return section
end

function Library.addParagraph2(container, title, description)
    if not container then
        error("Container is nil. Please provide a valid container for the section.")
    end

    -- Main Section Frame
    local Section = Instance.new("Frame")
    Section.Size = UDim2.new(1, 0, 0, 100) -- Reduced height since no image
    Section.BackgroundColor3 = Colors.DarkPrimary
    Section.BackgroundTransparency = 0.7
    Section.Parent = container
    addCorner(Section, 6)

    -- Section Title (Centered)
    local SectionLabel = Instance.new("TextLabel")
    SectionLabel.Size = UDim2.new(1, -20, 0, 25) -- Full width with padding
    SectionLabel.Position = UDim2.new(0, 10, 0, 5) -- Top with padding
    SectionLabel.Text = title or "Section"
    SectionLabel.TextSize = 18 -- Slightly bigger than description
    SectionLabel.Font = Enum.Font.GothamBold
    SectionLabel.TextColor3 = Colors.Text
    SectionLabel.BackgroundTransparency = 1
    SectionLabel.TextXAlignment = Enum.TextXAlignment.Center -- Center alignment
    SectionLabel.TextWrapped = true -- Wrap long titles
    SectionLabel.Parent = Section

    -- Description Label (Centered below title)
    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -20, 0, 65) -- Full width with padding
    DescLabel.Position = UDim2.new(0, 10, 0, 30) -- Positioned below title
    DescLabel.Text = description or "Description goes here."
    DescLabel.TextSize = 14
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextColor3 = Colors.Text
    DescLabel.BackgroundTransparency = 1
    DescLabel.TextXAlignment = Enum.TextXAlignment.Center -- Center alignment
    DescLabel.TextWrapped = true -- Ensures text wraps to multiple lines
    DescLabel.Parent = Section
end

function Library.addSection(container, title)
    if not container then
        error("Container is nil. Please provide a valid container for the section.")
    end

    local Section = Instance.new("Frame")
    Section.Size = UDim2.new(1, 0, 0, 40)
    Section.BackgroundColor3 = Colors.DarkPrimary
    Section.BackgroundTransparency = 0.7 -- Increased transparency
    Section.Parent = container
    addCorner(Section, 6)

    local SectionLabel = Instance.new("TextLabel")
    SectionLabel.Size = UDim2.new(1, 0, 1, 0)
    SectionLabel.Text = title or "Section"
    SectionLabel.TextSize = 16
    SectionLabel.Font = Enum.Font.GothamBold
    SectionLabel.TextColor3 = Colors.Text
    SectionLabel.BackgroundTransparency = 1
    SectionLabel.TextXAlignment = Enum.TextXAlignment.Center
    SectionLabel.Parent = Section
end

function Library.addParagraph3(container, title, description)
    if not container then
        error("Container is nil. Please provide a valid container for the section.")
    end

    -- Main Section Frame
    local Section = Instance.new("Frame")
    Section.Size = UDim2.new(1, 0, 0, 100) -- Reduced height since no image
    Section.BackgroundColor3 = Colors.DarkPrimary
    Section.BackgroundTransparency = 0.7
    Section.Parent = container
    addCorner(Section, 6)

    -- Section Title (Centered)
    local SectionLabel = Instance.new("TextLabel")
    SectionLabel.Size = UDim2.new(1, -20, 0, 25) -- Full width with padding
    SectionLabel.Position = UDim2.new(0, 10, 0, 5) -- Top with padding
    SectionLabel.Text = title or "Section"
    SectionLabel.TextSize = 18 -- Slightly bigger than description
    SectionLabel.Font = Enum.Font.GothamBold
    SectionLabel.TextColor3 = Colors.Text
    SectionLabel.BackgroundTransparency = 1
    SectionLabel.TextXAlignment = Enum.TextXAlignment.Center -- Center alignment
    SectionLabel.TextWrapped = true -- Wrap long titles
    SectionLabel.Parent = Section

    -- Description Label (Left-aligned below title)
    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -20, 0, 65) -- Full width with padding
    DescLabel.Position = UDim2.new(0, 10, 0, 30) -- Positioned below title
    DescLabel.Text = description or "Description goes here."
    DescLabel.TextSize = 14
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextColor3 = Colors.Text
    DescLabel.BackgroundTransparency = 1
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left -- Left alignment
    DescLabel.TextWrapped = true -- Ensures text wraps to multiple lines
    DescLabel.Parent = Section
end

function Library.addLabel(container, text)
    if not container then
        error("Container is nil. Please provide a valid container for the label.")
    end

    local LabelFrame = Instance.new("Frame")
    LabelFrame.Size = UDim2.new(1, 0, 0, 50)
    LabelFrame.BackgroundColor3 = Colors.Background
    LabelFrame.BackgroundTransparency = 0.7 -- Increased transparency
    LabelFrame.Parent = container
    addCorner(LabelFrame, 6)
    addStroke(LabelFrame, 2)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = text
    Label.TextSize = 14
    Label.Font = Enum.Font.Gotham
    Label.TextColor3 = Colors.Text
    Label.BackgroundTransparency = 1
    Label.Parent = LabelFrame

    local labelObject = {Label = Label}
    function labelObject:Set(newText)
        self.Label.Text = newText
    end
    return labelObject
end

function Library.AddKeybind(container, text, defaultKey, callback)
    if not container then
        error("Container is nil. Please provide a valid container for the keybind.")
    end

    local KeybindFrame = Instance.new("Frame")
    KeybindFrame.Size = UDim2.new(1, 0, 0, 50)
    KeybindFrame.BackgroundColor3 = Colors.Background
    KeybindFrame.BackgroundTransparency = 0.7 -- Increased transparency
    KeybindFrame.Parent = container
    addCorner(KeybindFrame, 6)
    addStroke(KeybindFrame, 2)

    local KeybindTitle = Instance.new("TextLabel")
    KeybindTitle.Size = UDim2.new(0.5, 0, 1, 0)
    KeybindTitle.Position = UDim2.new(0, 10, 0, 0)
    KeybindTitle.Text = text
    KeybindTitle.TextSize = 16
    KeybindTitle.Font = Enum.Font.Gotham
    KeybindTitle.TextColor3 = Colors.Text
    KeybindTitle.BackgroundTransparency = 1
    KeybindTitle.TextXAlignment = Enum.TextXAlignment.Left
    KeybindTitle.Parent = KeybindFrame

    local KeybindButton = Instance.new("TextButton")
    KeybindButton.Size = UDim2.new(0, 120, 0, 30)
    KeybindButton.Position = UDim2.new(1, -130, 0.5, -15)
    KeybindButton.Text = defaultKey.Name
    KeybindButton.TextSize = 14
    KeybindButton.Font = Enum.Font.Gotham
    KeybindButton.TextColor3 = Colors.Text
    KeybindButton.BackgroundColor3 = Colors.Primary
    KeybindButton.BackgroundTransparency = 0.7 -- Increased transparency
    KeybindButton.Parent = KeybindFrame
    addCorner(KeybindButton, 6)

    local listening = false
    KeybindButton.MouseButton1Click:Connect(function()
        listening = true
        KeybindButton.Text = "Press a key..."
    end)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if listening and not gameProcessed then
            local key = input.KeyCode.Name
            KeybindButton.Text = key
            callback(key)
            listening = false
        end
    end)
end

-- Remove all the predefined notification types at the bottom and replace with this:

-- Notification System (Simplified)
local Notifications = Instance.new("Frame")
Notifications.Name = "Notifications"
Notifications.Size = UDim2.new(0, 400, 1, -20)
Notifications.Position = UDim2.new(1, -410, 0, 10)
Notifications.BackgroundTransparency = 1
Notifications.Parent = mainGui

local NotificationsLayout = Instance.new("UIListLayout")
NotificationsLayout.SortOrder = Enum.SortOrder.LayoutOrder
NotificationsLayout.Padding = UDim.new(0, 10)
NotificationsLayout.Parent = Notifications

-- Store active notifications for management
Library.ActiveNotifications = {}

-- Icon Module (Material Icons from Luna)
local IconModule = {
    Material = {
        -- Info & Status
        ["info"] = "http://www.roblox.com/asset/?id=6026568227",
        ["warning"] = "http://www.roblox.com/asset/?id=6031071053",
        ["error"] = "http://www.roblox.com/asset/?id=6031071057",
        ["success"] = "http://www.roblox.com/asset/?id=6023426945",
        ["check_circle"] = "http://www.roblox.com/asset/?id=6023426945",
        ["error_outline"] = "http://www.roblox.com/asset/?id=6031071050",
        ["notification_important"] = "http://www.roblox.com/asset/?id=6031071056",
        
        -- General
        ["home"] = "http://www.roblox.com/asset/?id=6026568195",
        ["settings"] = "http://www.roblox.com/asset/?id=6031280882",
        ["menu"] = "http://www.roblox.com/asset/?id=6031097225",
        ["close"] = "http://www.roblox.com/asset/?id=6031094678",
        ["search"] = "http://www.roblox.com/asset/?id=6031154871",
        ["refresh"] = "http://www.roblox.com/asset/?id=6031097226",
        ["download"] = "http://www.roblox.com/asset/?id=6031302931",
        ["upload"] = "http://www.roblox.com/asset/?id=6031302959",
        
        -- Actions
        ["add"] = "http://www.roblox.com/asset/?id=6035047377",
        ["remove"] = "http://www.roblox.com/asset/?id=6035067836",
        ["delete"] = "http://www.roblox.com/asset/?id=6022668885",
        ["edit"] = "http://www.roblox.com/asset/?id=6034328955",
        ["save"] = "http://www.roblox.com/asset/?id=6035067857",
        ["cancel"] = "http://www.roblox.com/asset/?id=6031094677",
        ["done"] = "http://www.roblox.com/asset/?id=6023426926",
        ["clear"] = "http://www.roblox.com/asset/?id=6035047409",
        
        -- Media
        ["play_arrow"] = "http://www.roblox.com/asset/?id=6026663699",
        ["pause"] = "http://www.roblox.com/asset/?id=6026663719",
        ["stop"] = "http://www.roblox.com/asset/?id=6026681576",
        ["volume_up"] = "http://www.roblox.com/asset/?id=6026671215",
        ["volume_off"] = "http://www.roblox.com/asset/?id=6026671224",
        
        -- Communication
        ["mail"] = "http://www.roblox.com/asset/?id=6035056477",
        ["chat"] = "http://www.roblox.com/asset/?id=6035173838",
        ["call"] = "http://www.roblox.com/asset/?id=6035173859",
        ["message"] = "http://www.roblox.com/asset/?id=6035202033",
        
        -- Content
        ["copy"] = "http://www.roblox.com/asset/?id=6035053278",
        ["cut"] = "http://www.roblox.com/asset/?id=6035053280",
        ["paste"] = "http://www.roblox.com/asset/?id=6035053285",
        ["link"] = "http://www.roblox.com/asset/?id=6035056475",
        ["attachment"] = "http://www.roblox.com/asset/?id=6031302921",
        
        -- Navigation
        ["arrow_back"] = "http://www.roblox.com/asset/?id=6031091000",
        ["arrow_forward"] = "http://www.roblox.com/asset/?id=6031090995",
        ["arrow_upward"] = "http://www.roblox.com/asset/?id=6031090997",
        ["arrow_downward"] = "http://www.roblox.com/asset/?id=6031090991",
        ["chevron_left"] = "http://www.roblox.com/asset/?id=6031094670",
        ["chevron_right"] = "http://www.roblox.com/asset/?id=6031094680",
        ["expand_more"] = "http://www.roblox.com/asset/?id=6031094687",
        ["expand_less"] = "http://www.roblox.com/asset/?id=6031094679",
        
        -- Toggle
        ["check_box"] = "http://www.roblox.com/asset/?id=6031068421",
        ["check_box_outline_blank"] = "http://www.roblox.com/asset/?id=6031068420",
        ["radio_button_checked"] = "http://www.roblox.com/asset/?id=6031068426",
        ["radio_button_unchecked"] = "http://www.roblox.com/asset/?id=6031068433",
        ["star"] = "http://www.roblox.com/asset/?id=6031068423",
        ["star_border"] = "http://www.roblox.com/asset/?id=6031068425",
        ["toggle_on"] = "http://www.roblox.com/asset/?id=6031068430",
        ["toggle_off"] = "http://www.roblox.com/asset/?id=6031068429",
        
        -- Social
        ["person"] = "http://www.roblox.com/asset/?id=6034287594",
        ["group"] = "http://www.roblox.com/asset/?id=6034281901",
        ["share"] = "http://www.roblox.com/asset/?id=6034230648",
        ["thumb_up"] = "http://www.roblox.com/asset/?id=6031229347",
        ["thumb_down"] = "http://www.roblox.com/asset/?id=6031229336",
        ["favorite"] = "http://www.roblox.com/asset/?id=6023426974",
        
        -- Files & Folders
        ["folder"] = "http://www.roblox.com/asset/?id=6031302932",
        ["folder_open"] = "http://www.roblox.com/asset/?id=6031302934",
        ["insert_drive_file"] = "http://www.roblox.com/asset/?id=6034941697",
        ["cloud"] = "http://www.roblox.com/asset/?id=6031302918",
        ["cloud_download"] = "http://www.roblox.com/asset/?id=6031302917",
        ["cloud_upload"] = "http://www.roblox.com/asset/?id=6031302992",
        
        -- Devices
        ["computer"] = "http://www.roblox.com/asset/?id=6034789874",
        ["smartphone"] = "http://www.roblox.com/asset/?id=6034848731",
        ["headset"] = "http://www.roblox.com/asset/?id=6034789880",
        ["watch"] = "http://www.roblox.com/asset/?id=6034848747",
        ["gamepad"] = "http://www.roblox.com/asset/?id=6034789879",
        
        -- Special & Decorative
        ["sparkle"] = "http://www.roblox.com/asset/?id=4483362748",
        ["star_rate"] = "http://www.roblox.com/asset/?id=6031265978",
        ["whatshot"] = "http://www.roblox.com/asset/?id=6034287525",
        ["emoji_events"] = "http://www.roblox.com/asset/?id=6034275726",
        ["celebration"] = "http://www.roblox.com/asset/?id=6034767613",
        ["military_tech"] = "http://www.roblox.com/asset/?id=6034295711",
        ["workspace_premium"] = "http://www.roblox.com/asset/?id=6031302952",
        
        -- Security
        ["lock"] = "http://www.roblox.com/asset/?id=6026568224",
        ["lock_open"] = "http://www.roblox.com/asset/?id=6026568220",
        ["security"] = "http://www.roblox.com/asset/?id=6034837802",
        ["shield"] = "http://www.roblox.com/asset/?id=6035078889",
        ["vpn_key"] = "http://www.roblox.com/asset/?id=6035202034",
        
        -- Time
        ["schedule"] = "http://www.roblox.com/asset/?id=6031260808",
        ["alarm"] = "http://www.roblox.com/asset/?id=6023426910",
        ["timer"] = "http://www.roblox.com/asset/?id=6031754564",
        ["history"] = "http://www.roblox.com/asset/?id=6026568197",
        
        -- Maps & Location
        ["location_on"] = "http://www.roblox.com/asset/?id=6035190846",
        ["map"] = "http://www.roblox.com/asset/?id=6034684930",
        ["navigation"] = "http://www.roblox.com/asset/?id=6034509984",
        ["pin_drop"] = "http://www.roblox.com/asset/?id=6034470807",
        
        -- Image & Media
        ["image"] = "http://www.roblox.com/asset/?id=6034407078",
        ["photo_camera"] = "http://www.roblox.com/asset/?id=6031770997",
        ["videocam"] = "http://www.roblox.com/asset/?id=6026671213",
        ["music_note"] = "http://www.roblox.com/asset/?id=6034323673",
        
        -- Shopping
        ["shopping_cart"] = "http://www.roblox.com/asset/?id=6031265976",
        ["payment"] = "http://www.roblox.com/asset/?id=6031084751",
        ["credit_card"] = "http://www.roblox.com/asset/?id=6023426942",
        ["receipt"] = "http://www.roblox.com/asset/?id=6031086173",
        
        -- Transportation
        ["directions_car"] = "http://www.roblox.com/asset/?id=6034754441",
        ["flight"] = "http://www.roblox.com/asset/?id=6034744030",
        ["train"] = "http://www.roblox.com/asset/?id=6034467803",
        ["directions_bus"] = "http://www.roblox.com/asset/?id=6034754434",
        
        -- Weather
        ["wb_sunny"] = "http://www.roblox.com/asset/?id=6034412758",
        ["cloudy"] = "http://www.roblox.com/asset/?id=6031734907",
        ["flash_on"] = "http://www.roblox.com/asset/?id=6034333271",
        ["ac_unit"] = "http://www.roblox.com/asset/?id=6035107929",
        
        -- Food
        ["restaurant"] = "http://www.roblox.com/asset/?id=6034503366",
        ["local_cafe"] = "http://www.roblox.com/asset/?id=6034687954",
        ["cake"] = "http://www.roblox.com/asset/?id=6034295702",
        ["local_bar"] = "http://www.roblox.com/asset/?id=6034687950",
        
        -- Sports
        ["sports_esports"] = "http://www.roblox.com/asset/?id=6034227061",
        ["sports_soccer"] = "http://www.roblox.com/asset/?id=6034227075",
        ["sports_basketball"] = "http://www.roblox.com/asset/?id=6034230649",
        ["fitness_center"] = "http://www.roblox.com/asset/?id=6035121907"
    }
}

local function GetIcon(icon, source)
    if source == "Material" and IconModule.Material[icon] then
        return IconModule.Material[icon]
    end
    -- Default icon if not found
    return IconModule.Material["info"]
end

local function Kwargify(defaults, passed)
    for i, v in pairs(defaults) do
        if passed[i] == nil then
            passed[i] = v
        end
    end
    return passed
end

-- Overload function to handle different parameter formats
function Library:Notify(...)
    local args = {...}
    local data
    
    -- Handle different calling formats
    if type(args[1]) == "table" then
        -- Table format: Library:Notify({Title = "Hello", Content = "World"})
        data = args[1]
    elseif type(args[1]) == "string" and type(args[2]) == "string" then
        -- Simple format: Library:Notify("Title", "Content", 5)
        data = {
            Title = args[1],
            Content = args[2],
            Duration = args[3] or 5
        }
    elseif type(args[1]) == "string" then
        -- Minimal format: Library:Notify("Message")
        data = {
            Title = "Notification",
            Content = args[1],
            Duration = args[2] or 5
        }
    else
        -- Default
        data = {}
    end
    
    task.spawn(function()
        data = Kwargify({
            Title = "Notification",
            Content = "This is a notification",
            Icon = nil, -- No icon by default
            ImageSource = "Material",
            Duration = 5
        }, data)
        
        -- Create notification template
        local NotificationTemplate = Instance.new("Frame")
        NotificationTemplate.Size = UDim2.new(1, 0, 0, 80)
        NotificationTemplate.BackgroundColor3 = Colors.DarkPrimary
        NotificationTemplate.BackgroundTransparency = 0.3
        NotificationTemplate.Parent = Notifications
        NotificationTemplate.ClipsDescendants = true
        addCorner(NotificationTemplate, 8)
        addStroke(NotificationTemplate, 2, Colors.Primary)
        
        -- Store reference
        local notificationId = #Library.ActiveNotifications + 1
        Library.ActiveNotifications[notificationId] = NotificationTemplate
        
        -- Icon (only if provided)
        local Icon
        if data.Icon then
            Icon = Instance.new("ImageLabel")
            Icon.Size = UDim2.new(0, 24, 0, 24)
            Icon.Position = UDim2.new(0, 12, 0, 12)
            Icon.BackgroundTransparency = 1
            Icon.Image = GetIcon(data.Icon, data.ImageSource)
            Icon.ImageColor3 = Colors.Text
            Icon.Parent = NotificationTemplate
        end
        
        -- Title
        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, data.Icon and -50 or -30, 0, 20)
        Title.Position = UDim2.new(0, data.Icon and 45 or 15, 0, 10)
        Title.Text = data.Title
        Title.TextSize = 14
        Title.Font = Enum.Font.GothamBold
        Title.TextColor3 = Colors.Text
        Title.BackgroundTransparency = 1
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.Parent = NotificationTemplate
        
        -- Content
        local Content = Instance.new("TextLabel")
        Content.Size = UDim2.new(1, data.Icon and -50 or -30, 0, 40)
        Content.Position = UDim2.new(0, data.Icon and 45 or 15, 0, 30)
        Content.Text = data.Content
        Content.TextSize = 12
        Content.Font = Enum.Font.Gotham
        Content.TextColor3 = Colors.Text
        Content.BackgroundTransparency = 1
        Content.TextXAlignment = Enum.TextXAlignment.Left
        Content.TextWrapped = true
        Content.TextYAlignment = Enum.TextYAlignment.Top
        Content.Parent = NotificationTemplate
        
        -- Close button
        local CloseButton = Instance.new("TextButton")
        CloseButton.Size = UDim2.new(0, 20, 0, 20)
        CloseButton.Position = UDim2.new(1, -25, 0, 8)
        CloseButton.Text = "×"
        CloseButton.TextSize = 16
        CloseButton.Font = Enum.Font.GothamBold
        CloseButton.TextColor3 = Colors.Text
        CloseButton.BackgroundColor3 = Colors.Danger
        CloseButton.BackgroundTransparency = 0.7
        CloseButton.Parent = NotificationTemplate
        addCorner(CloseButton, 4)
        
        -- Auto-calculate size based on content
        local textSize = game:GetService("TextService"):GetTextSize(
            data.Content,
            12,
            Enum.Font.Gotham,
            Vector2.new(Content.AbsoluteSize.X, math.huge)
        )
        
        local requiredHeight = math.max(80, textSize.Y + 50)
        NotificationTemplate.Size = UDim2.new(1, 0, 0, requiredHeight)
        Content.Size = UDim2.new(1, data.Icon and -50 or -30, 0, requiredHeight - 40)
        
        -- Animation in (slide from right)
        NotificationTemplate.Position = UDim2.new(1, 0, 0, 0) -- Start off-screen to the right
        NotificationTemplate.BackgroundTransparency = 1
        Title.TextTransparency = 1
        Content.TextTransparency = 1
        if Icon then
            Icon.ImageTransparency = 1
        end
        CloseButton.BackgroundTransparency = 1
        CloseButton.TextTransparency = 1
        
        -- Slide in animation
        TweenService:Create(NotificationTemplate, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 0.3
        }):Play()
        
        TweenService:Create(Title, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        TweenService:Create(Content, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        if Icon then
            TweenService:Create(Icon, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()
        end
        TweenService:Create(CloseButton, TweenInfo.new(0.3), {
            BackgroundTransparency = 0.7,
            TextTransparency = 0
        }):Play()
        
        -- Close button functionality
        CloseButton.MouseButton1Click:Connect(function()
            Library:CloseNotification(NotificationTemplate, notificationId)
        end)
        
        -- Auto-close after duration
        local autoClose = task.delay(data.Duration, function()
            Library:CloseNotification(NotificationTemplate, notificationId)
        end)
        
        -- Store reference for manual closing
        NotificationTemplate.Close = function()
            task.cancel(autoClose)
            Library:CloseNotification(NotificationTemplate, notificationId)
        end
        
        return NotificationTemplate
    end)
end

function Library:CloseNotification(notification, notificationId)
    if not notification or notification.Parent == nil then return end
    
    -- Remove from active notifications
    if notificationId then
        Library.ActiveNotifications[notificationId] = nil
    end
    
    -- Slide out animation (slide to the right)
    TweenService:Create(notification, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2.new(1, 0, 0, 0), -- Move off-screen to the right
        BackgroundTransparency = 1
    }):Play()
    
    -- Fade out all children
    for _, child in pairs(notification:GetChildren()) do
        if child:IsA("TextLabel") then
            TweenService:Create(child, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
        elseif child:IsA("TextButton") then
            TweenService:Create(child, TweenInfo.new(0.3), {
                TextTransparency = 1,
                BackgroundTransparency = 1
            }):Play()
        elseif child:IsA("ImageLabel") then
            TweenService:Create(child, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
        end
    end
    
    -- Destroy after animation completes
    task.delay(0.35, function()
        if notification and notification.Parent then
            notification:Destroy()
        end
    end)
end

function Library:ClearAllNotifications()
    for id, notification in pairs(Library.ActiveNotifications) do
        if notification and notification.Parent then
            self:CloseNotification(notification, id)
        end
    end
    Library.ActiveNotifications = {}
end

return Library
