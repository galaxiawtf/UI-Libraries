-- vars

local lib = {}
local sections = {}
local workareas = {}
local notifs = {}
local visible = true
local dbcooper = false

local function tp(ins, pos, time, thing)
    game:GetService("TweenService"):Create(ins, TweenInfo.new(time, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut),{Position = pos}):Play()
end

function lib:init(ti, dosplash, visiblekey, deleteprevious)
    if syn then
        
         cg = game:GetService("CoreGui")
        if cg:FindFirstChild("ScreenGui") and deleteprevious then
           tp(cg.ScreenGui.main, cg.ScreenGui.main.Position + UDim2.new(0,0,2,0), 0.5)
            game:GetService("Debris"):AddItem(cg.ScreenGui, 1)
      end

         -- main
        scrgui = Instance.new("ScreenGui")
        syn.protect_gui(scrgui)
        scrgui.Parent = game:GetService("CoreGui")
    elseif gethui then
        if gethui():FindFirstChild("ScreenGui") and deleteprevious then
            gethui().ScreenGui.main:TweenPosition(gethui().ScreenGui.main.Position + UDim2.new(0,0,2,0), "InOut", "Quart", 0.5)
            game:GetService("Debris"):AddItem(gethui().ScreenGui, 1)
        end

        -- main
         scrgui = Instance.new("ScreenGui")
        scrgui.Parent = gethui()
    else
        cg = game:GetService("CoreGui")
        if cg:FindFirstChild("ScreenGui") and deleteprevious then
            tp(cg.ScreenGui.main, cg.ScreenGui.main.Position + UDim2.new(0,0,2,0), 0.5)
            game:GetService("Debris"):AddItem(cg.ScreenGui, 1)
        end
         scrgui = Instance.new("ScreenGui")
        scrgui.Parent = cg
    end
        
    
    
    

    if dosplash then
        local splash = Instance.new("Frame")
        splash.Name = "splash"
        splash.Parent = scrgui
        splash.AnchorPoint = Vector2.new(0.5, 0.5)
        splash.BackgroundColor3 = Color3.fromRGB(25,25,25)
        splash.BackgroundTransparency = 0.600
        splash.Position = UDim2.new(0.5, 0, 2, 0)
        splash.Size = UDim2.new(0, 340, 0, 340)
        splash.Visible = true
        splash.ZIndex = 40

        local uc_22 = Instance.new("UICorner")
        uc_22.CornerRadius = UDim.new(0, 18)
        uc_22.Parent = splash

        local sicon = Instance.new("ImageLabel")
        sicon.Name = "sicon"
        sicon.Parent = splash
        sicon.AnchorPoint = Vector2.new(0.5, 0.5)
        sicon.BackgroundColor3 = Color3.fromRGB(25,25,25)
        sicon.BackgroundTransparency = 1
        sicon.Position = UDim2.new(0.5, 0, 0.5, 0)
        sicon.Size = UDim2.new(0, 191, 0, 190)
        sicon.ZIndex = 40
        sicon.Image = "rbxassetid://12621719043"
        sicon.ScaleType = Enum.ScaleType.Fit
        sicon.TileSize = UDim2.new(1, 0, 20, 0)

        local ug = Instance.new("UIGradient")
        ug.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.01, Color3.fromRGB(61, 61, 61)), ColorSequenceKeypoint.new(0.47, Color3.fromRGB(41, 41, 41)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))}
        ug.Rotation = 90
        ug.Parent = sicon

        local sshadow = Instance.new("ImageLabel")
        sshadow.Name = "sshadow"
        sshadow.Parent = splash
        sshadow.AnchorPoint = Vector2.new(0.5, 0.5)
        sshadow.BackgroundTransparency = 1
        sshadow.Position = UDim2.new(0.5, 0, 0.5, 0)
        sshadow.Size = UDim2.new(1.20000005, 0, 1.20000005, 0)
        sshadow.ZIndex = 39
        sshadow.Image = "rbxassetid://313486536"
        sshadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
        sshadow.ImageTransparency = 0.400
        sshadow.TileSize = UDim2.new(0, 1, 0, 1)
        splash:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "InOut", "Quart", 1)
        wait(2)
        splash:TweenPosition(UDim2.new(0.5, 0, 2, 0), "InOut", "Quart", 1)
        game:GetService("Debris"):AddItem(splash, 1)
    end
        

    local main = Instance.new("Frame")
    main.Name = "main"
    main.Parent = scrgui
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = Color3.fromRGB(35,35,35)
    main.BackgroundTransparency = 0.150
    main.Position = UDim2.new(0.5, 0, 2, 0)
    main.Size = UDim2.new(0, 721, 0, 584)

    local uc = Instance.new("UICorner")
    uc.CornerRadius = UDim.new(0, 18)
    uc.Parent = main

    local UserInputService = game:GetService("UserInputService") --- skidded ik
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    main.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    -- workarea right side setup

    local workarea = Instance.new("Frame")
    workarea.Name = "workarea"
    workarea.Parent = main
    workarea.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    workarea.Position = UDim2.new(0.36403501, 0, 0, 0)
    workarea.Size = UDim2.new(0, 458, 0, 584)

    local uc_2 = Instance.new("UICorner")
    uc_2.CornerRadius = UDim.new(0, 18)
    uc_2.Parent = workarea

    local workareacornerhider = Instance.new("Frame")
    workareacornerhider.Name = "workareacornerhider"
    workareacornerhider.Parent = workarea
    workareacornerhider.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    workareacornerhider.BorderSizePixel = 0
    workareacornerhider.Size = UDim2.new(0, 18, 0.99895674, 0)


    -- searchbar

    local search = Instance.new("Frame")
    search.Name = "search"
    search.Parent = main
    search.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    search.Position = UDim2.new(0.0256588068, 0, 0.0958904102, 0)
    search.Size = UDim2.new(0, 225, 0, 34)

    local uc_8 = Instance.new("UICorner")
    uc_8.CornerRadius = UDim.new(0, 9)
    uc_8.Parent = search

    local searchicon = Instance.new("ImageButton")
    searchicon.Name = "searchicon"
    searchicon.Parent = search
    searchicon.BackgroundColor3 = Color3.fromRGB(200,200,200)
    searchicon.BackgroundTransparency = 1
    searchicon.BorderColor3 = Color3.fromRGB(27, 42, 53)
    searchicon.Position = UDim2.new(0.0379999988, -2, 0.138999999, 2)
    searchicon.Size = UDim2.new(0, 24, 0, 21)
    searchicon.Image = "rbxassetid://2804603863"
    searchicon.ImageColor3 = Color3.fromRGB(95, 95, 95)
    searchicon.ScaleType = Enum.ScaleType.Fit

    local searchtextbox = Instance.new("TextBox")
    searchtextbox.Name = "searchtextbox"
    searchtextbox.Parent = search
    searchtextbox.BackgroundColor3 = Color3.fromRGB(35,35,35)
    searchtextbox.BackgroundTransparency = 1
    searchtextbox.ClipsDescendants = true
    searchtextbox.Position = UDim2.new(0.180257514, 0, -0.0162218884, 0)
    searchtextbox.Size = UDim2.new(0, 176, 0, 34)
    searchtextbox.Font = Enum.Font.Gotham
    searchtextbox.LineHeight = 0.870
    searchtextbox.PlaceholderText = "Search"
    searchtextbox.Text = ""
    searchtextbox.TextColor3 = Color3.fromRGB(230,230,230)
    searchtextbox.TextSize = 22
    searchtextbox.TextXAlignment = Enum.TextXAlignment.Left

    searchicon.MouseButton1Click:Connect(function()
        searchtextbox:CaptureFocus()
    end)

    -- sidebar

    local sidebar = Instance.new("ScrollingFrame")
    sidebar.Name = "sidebar"
    sidebar.Parent = main
    sidebar.Active = true
    sidebar.BackgroundColor3 = Color3.fromRGB(30,30,30)
    sidebar.BackgroundTransparency = 1
    sidebar.BorderSizePixel = 0
    sidebar.Position = UDim2.new(0.0249653254, 0, 0.181506842, 0)
    sidebar.Size = UDim2.new(0, 233, 0, 463)
    sidebar.AutomaticCanvasSize = "Y"
    sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
    sidebar.ScrollBarThickness = 2

    local ull_2 = Instance.new("UIListLayout")
    ull_2.Parent = sidebar
    ull_2.SortOrder = Enum.SortOrder.LayoutOrder
    ull_2.Padding = UDim.new(0, 5)

    game:GetService("RunService"):BindToRenderStep("search", 1, function() -- i sure do love skidding
        if not searchtextbox:IsFocused() then 
            for b,v in next, sidebar:GetChildren() do
                if not v:IsA("TextButton") then return end
                v.Visible = true
            end
        end
        local InputText=string.upper(searchtextbox.Text)
        for _,button in pairs(sidebar:GetChildren())do
            if button:IsA("TextButton")then
                if InputText==""or string.find(string.upper(button.Text),InputText)~=nil then
                    button.Visible=true
                else
                    button.Visible=false
                end
            end
        end
    end)
    -- macos style buttons


    local buttons = Instance.new("Frame")
    buttons.Name = "buttons"
    buttons.Parent = main
    buttons.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    buttons.BackgroundTransparency = 1
    buttons.Size = UDim2.new(0, 105, 0, 57)

    local ull_3 = Instance.new("UIListLayout")
    ull_3.Parent = buttons
    ull_3.FillDirection = Enum.FillDirection.Horizontal
    ull_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ull_3.SortOrder = Enum.SortOrder.LayoutOrder
    ull_3.VerticalAlignment = Enum.VerticalAlignment.Center
    ull_3.Padding = UDim.new(0, 10)


    local close = Instance.new("TextButton")
    close.Name = "close"
    close.Parent = buttons
    close.BackgroundColor3 = Color3.fromRGB(40,40,40)
    close.Size = UDim2.new(0, 16, 0, 16)
    close.AutoButtonColor = false
    close.Font = Enum.Font.SourceSans
    close.Text = ""
    close.TextColor3 = Color3.fromRGB(230, 230, 230)
    close.TextSize = 14
    close.MouseButton1Click:Connect(function()
        scrgui:Destroy()
    end)


    local uc_18 = Instance.new("UICorner")
    uc_18.CornerRadius = UDim.new(1, 0)
    uc_18.Parent = close


    local minimize = Instance.new("TextButton")
    minimize.Name = "minimize"
    minimize.Parent = buttons
    minimize.BackgroundColor3 = Color3.fromRGB(40,40,40)
    minimize.Size = UDim2.new(0, 16, 0, 16)
    minimize.AutoButtonColor = false
    minimize.Font = Enum.Font.SourceSans
    minimize.Text = ""
    minimize.TextColor3 = Color3.fromRGB(230,230,230)
    minimize.TextSize = 14


    local uc_19 = Instance.new("UICorner")
    uc_19.CornerRadius = UDim.new(1, 0)
    uc_19.Parent = minimize


local resize = Instance.new("TextButton")
resize.Name = "resize"
resize.Parent = buttons
resize.Size = UDim2.new(0, 16, 0, 16)
resize.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- dark mode base
resize.BorderColor3 = Color3.fromRGB(60, 60, 60)
resize.AutoButtonColor = false
resize.Font = Enum.Font.SourceSans
resize.Text = ""
resize.TextColor3 = Color3.fromRGB(230, 230, 230)
resize.TextSize = 14
    
    local uc_20 = Instance.new("UICorner")
    uc_20.CornerRadius = UDim.new(1, 0)
    uc_20.Parent = resize

    -- title text at topbar


local title = Instance.new("TextLabel")
title.Name = "title"
title.Parent = main
title.BackgroundTransparency = 1 -- keep transparent
title.Position = UDim2.new(0.02, 0, 0.03, 0) -- adjust to align left nicely
title.Size = UDim2.new(0, 400, 0, 28)
title.Font = Enum.Font.Gotham
title.TextColor3 = Color3.fromRGB(230, 230, 230) -- light text for dark mode
title.TextSize = 24
title.TextWrapped = true
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextYAlignment = Enum.TextYAlignment.Center
title.LineHeight = 1.2
title.Text = "Your GUI Title" -- set your title text

    -- notif1
  local notif = Instance.new("Frame")
notif.Name = "notif"
notif.Parent = main
notif.AnchorPoint = Vector2.new(0.5, 0.5)
notif.Position = UDim2.new(0.5, 0, 0.5, 0)
notif.Size = UDim2.new(0, 304, 0, 362)
notif.Visible = false
notif.ZIndex = 3
notif.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- dark background
notif.BorderColor3 = Color3.fromRGB(60, 60, 60) -- subtle border

    local uc_11 = Instance.new("UICorner")
    uc_11.CornerRadius = UDim.new(0, 18)
    uc_11.Parent = notif

   -- Notification Icon
local notificon = Instance.new("ImageLabel")
notificon.Name = "notificon"
notificon.Parent = notif
notificon.BackgroundTransparency = 1
notificon.Position = UDim2.new(0.335, 0, 0.1, 0)
notificon.Size = UDim2.new(0, 100, 0, 100)
notificon.ZIndex = 3
notificon.Image = "rbxassetid://4871684504" -- your icon
notificon.ImageColor3 = Color3.fromRGB(200, 200, 200) -- light gray for dark mode

-- Notification Button
local notifbutton1 = Instance.new("TextButton")
notifbutton1.Name = "notifbutton1"
notifbutton1.Parent = notif
notifbutton1.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- dark mode base
notifbutton1.Position = UDim2.new(0.05, 0, 0.82, 0)
notifbutton1.Size = UDim2.new(0, 270, 0, 50)
notifbutton1.ZIndex = 3
notifbutton1.Font = Enum.Font.Gotham
notifbutton1.Text = "OK"
notifbutton1.TextColor3 = Color3.fromRGB(230, 230, 230)
notifbutton1.TextSize = 21
notifbutton1.AutoButtonColor = false

    local uc_12 = Instance.new("UICorner")
    uc_12.CornerRadius = UDim.new(0, 9)
    uc_12.Parent = notifbutton1

-- Notification Shadow (glow/soft shadow)
local notifshadow = Instance.new("ImageLabel")
notifshadow.Name = "notifshadow"
notifshadow.Parent = notif
notifshadow.AnchorPoint = Vector2.new(0.5, 0.5)
notifshadow.BackgroundTransparency = 1
notifshadow.Position = UDim2.new(0.5, 0, 0.5, 0)
notifshadow.Size = UDim2.new(1.2, 0, 1.2, 0)
notifshadow.Image = "rbxassetid://313486536" -- soft shadow image
notifshadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
notifshadow.ImageTransparency = 0.5 -- subtle shadow

-- Dark overlay behind notification
local notifdarkness = Instance.new("Frame")
notifdarkness.Name = "notifdarkness"
notifdarkness.Parent = notif
notifdarkness.AnchorPoint = Vector2.new(0.5, 0.5)
notifdarkness.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
notifdarkness.BackgroundTransparency = 0.6 -- semi-transparent
notifdarkness.Position = UDim2.new(0.5, 0, 0.5, 0)
notifdarkness.Size = UDim2.new(0, 721, 0, 584)
notifdarkness.ZIndex = 2

    local uc_13 = Instance.new("UICorner")
    uc_13.CornerRadius = UDim.new(0, 18)
    uc_13.Parent = notifdarkness

  -- Notification Title
local notiftitle = Instance.new("TextLabel")
notiftitle.Name = "notiftitle"
notiftitle.Parent = notif
notiftitle.BackgroundTransparency = 1
notiftitle.Position = UDim2.new(0.17, 0, 0.38, 0)
notiftitle.Size = UDim2.new(0, 200, 0, 50)
notiftitle.ZIndex = 3
notiftitle.Font = Enum.Font.GothamMedium
notiftitle.Text = "Notice"
notiftitle.TextColor3 = Color3.fromRGB(230, 230, 230) -- light text
notiftitle.TextSize = 24
notiftitle.TextXAlignment = Enum.TextXAlignment.Center
notiftitle.TextYAlignment = Enum.TextYAlignment.Center

-- Notification Text
local notiftext = Instance.new("TextLabel")
notiftext.Name = "notiftext"
notiftext.Parent = notif
notiftext.BackgroundTransparency = 1
notiftext.Position = UDim2.new(0.08, 0, 0.52, 0)
notiftext.Size = UDim2.new(0, 254, 0, 66)
notiftext.ZIndex = 3
notiftext.Font = Enum.Font.Gotham
notiftext.Text = "We would like to contact you regarding your car's extended warranty."
notiftext.TextColor3 = Color3.fromRGB(200, 200, 200) -- slightly lighter gray
notiftext.TextSize = 16
notiftext.TextWrapped = true
notiftext.TextXAlignment = Enum.TextXAlignment.Center
notiftext.TextYAlignment = Enum.TextYAlignment.Top

-- Notification 2 (for two-button layout)
local notif2 = Instance.new("Frame")
notif2.Name = "notif2"
notif2.Parent = main
notif2.AnchorPoint = Vector2.new(0.5, 0.5)
notif2.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- dark background
notif2.Position = UDim2.new(0.5, 0, 0.5, 0)
notif2.Size = UDim2.new(0, 304, 0, 362)
notif2.Visible = false
notif2.ZIndex = 3


    local uc_14 = Instance.new("UICorner")
    uc_14.CornerRadius = UDim.new(0, 18)
    uc_14.Parent = notif2

 -- Notification Icon
local notif2icon = Instance.new("ImageLabel")
notif2icon.Name = "notif2icon"
notif2icon.Parent = notif2
notif2icon.BackgroundTransparency = 1
notif2icon.Position = UDim2.new(0.335, 0, 0.1, 0)
notif2icon.Size = UDim2.new(0, 100, 0, 100)
notif2icon.ZIndex = 3
notif2icon.Image = "rbxassetid://12608260095"
notif2icon.ImageColor3 = Color3.fromRGB(200, 200, 200) -- light gray

-- Notification Title
local notif2title = Instance.new("TextLabel")
notif2title.Name = "notif2title"
notif2title.Parent = notif2
notif2title.BackgroundTransparency = 1
notif2title.Position = UDim2.new(0.17, 0, 0.38, 0)
notif2title.Size = UDim2.new(0, 200, 0, 50)
notif2title.ZIndex = 3
notif2title.Font = Enum.Font.GothamMedium
notif2title.Text = "Notice"
notif2title.TextColor3 = Color3.fromRGB(230, 230, 230)
notif2title.TextSize = 24
notif2title.TextXAlignment = Enum.TextXAlignment.Center
notif2title.TextYAlignment = Enum.TextYAlignment.Center

-- Notification Text
local notif2text = Instance.new("TextLabel")
notif2text.Name = "notif2text"
notif2text.Parent = notif2
notif2text.BackgroundTransparency = 1
notif2text.Position = UDim2.new(0.08, 0, 0.52, 0)
notif2text.Size = UDim2.new(0, 254, 0, 66)
notif2text.ZIndex = 3
notif2text.Font = Enum.Font.Gotham
notif2text.Text = "We would like to contact you regarding your car's extended warranty."
notif2text.TextColor3 = Color3.fromRGB(200, 200, 200)
notif2text.TextSize = 16
notif2text.TextWrapped = true
notif2text.TextXAlignment = Enum.TextXAlignment.Center
notif2text.TextYAlignment = Enum.TextYAlignment.Top

-- Notification Button
local notif2button1 = Instance.new("TextButton")
notif2button1.Name = "notif2button1"
notif2button1.Parent = notif2
notif2button1.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- dark mode base
notif2button1.Position = UDim2.new(0.056, 0, 0.715, 0)
notif2button1.Size = UDim2.new(0, 270, 0, 40)
notif2button1.ZIndex = 3
notif2button1.Font = Enum.Font.Gotham
notif2button1.Text = "Sure!"
notif2button1.TextColor3 = Color3.fromRGB(230, 230, 230)
notif2button1.TextSize = 21
notif2button1.AutoButtonColor = false

    local uc_15 = Instance.new("UICorner")
    uc_15.CornerRadius = UDim.new(0, 9)
    uc_15.Parent = notif2button1


 -- Notification 2 Shadow (soft glow)
local notif2shadow = Instance.new("ImageLabel")
notif2shadow.Name = "notif2shadow"
notif2shadow.Parent = notif2
notif2shadow.AnchorPoint = Vector2.new(0.5, 0.5)
notif2shadow.BackgroundTransparency = 1
notif2shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
notif2shadow.Size = UDim2.new(1.2, 0, 1.2, 0)
notif2shadow.Image = "rbxassetid://313486536"
notif2shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
notif2shadow.ImageTransparency = 0.5 -- subtle shadow effect

-- Notification 2 Dark overlay (dim background)
local notif2darkness = Instance.new("Frame")
notif2darkness.Name = "notif2darkness"
notif2darkness.Parent = notif2
notif2darkness.AnchorPoint = Vector2.new(0.5, 0.5)
notif2darkness.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
notif2darkness.BackgroundTransparency = 0.6 -- semi-transparent
notif2darkness.Position = UDim2.new(0.5, 0, 0.5, 0)
notif2darkness.Size = UDim2.new(0, 721, 0, 584)
notif2darkness.ZIndex = 2


-- Notification text labels (dark mode)
t2.TextColor3 = Color3.fromRGB(230, 230, 230)
t1.TextColor3 = Color3.fromRGB(230, 230, 230)
ticon.ImageColor3 = Color3.fromRGB(200, 200, 200) -- slightly dimmer icon for dark mode
tshadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
tshadow.ImageTransparency = 0.6

-- Notify functions
function window:Notify(txt1, txt2, b1, icohn, callback)
    if notif.Visible == true or notif2.Visible == true then return "Already visible" end
    notiftitle.Text = txt1
    notiftext.Text = txt2
    notificon.Image = icohn
    notificon.ImageColor3 = Color3.fromRGB(200, 200, 200)
    notif.Visible = true
    notifbutton1.Text = b1
    notifbutton1.BackgroundColor3 = Color3.fromRGB(21, 103, 251)
    notifbutton1.TextColor3 = Color3.fromRGB(255, 255, 255)
    if callback then
        con1 = notifbutton1.MouseButton1Click:Connect(function()
            con1:Disconnect()
            callback()
            notif.Visible = false
        end)
    end
end

function window:Notify2(txt1, txt2, b1, b2, icohn, callback, callback2)
    if notif.Visible == true or notif2.Visible == true then return "Already visible" end
    notif2title.Text = txt1
    notif2text.Text = txt2
    notif2icon.Image = icohn
    notif2icon.ImageColor3 = Color3.fromRGB(200, 200, 200)
    notif2.Visible = true
    notif2button1.Text = b1
    notif2button2.Text = b2
    notif2button1.BackgroundColor3 = Color3.fromRGB(21, 103, 251)
    notif2button2.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    notif2button1.TextColor3 = Color3.fromRGB(255, 255, 255)
    notif2button2.TextColor3 = Color3.fromRGB(230, 230, 230)
    if callback and callback2 then
        con1 = notif2button1.MouseButton1Click:Connect(function()
            con1:Disconnect()
            con2:Disconnect()
            callback()
            notif2.Visible = false
        end)
        con2 = notif2button2.MouseButton1Click:Connect(function()
            con1:Disconnect()
            con2:Disconnect()
            callback2()
            notif2.Visible = false
        end)
    end
end

-- Sidebar / workarea dark mode
sidebar2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
sidebar2.TextColor3 = Color3.fromRGB(230, 230, 230)
workareamain.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

-- Section labels inside workarea
section.TextColor3 = Color3.fromRGB(230, 230, 230)

-- Buttons in dark mode
button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
button.TextColor3 = Color3.fromRGB(21, 103, 251)
us.Color = Color3.fromRGB(21, 103, 251)

-- Labels in dark mode
label.TextColor3 = Color3.fromRGB(230, 230, 230)

-- Switch / Toggle dark mode
toggleswitch.TextColor3 = Color3.fromRGB(230, 230, 230)
Frame.BackgroundColor3 = defaultmode and Color3.fromRGB(21, 103, 251) or Color3.fromRGB(60, 60, 60)
TextButton.BackgroundColor3 = defaultmode and Color3.fromRGB(21, 103, 251) or Color3.fromRGB(70, 70, 70)
TextButton.TextColor3 = Color3.fromRGB(230, 230, 230)


        local uc_21 = Instance.new("UICorner")
        uc_21.CornerRadius = UDim.new(0, 18)
        uc_21.Parent = tempnotif

-- Notification text labels (dark mode)
t2.TextColor3 = Color3.fromRGB(230, 230, 230)
t1.TextColor3 = Color3.fromRGB(230, 230, 230)
ticon.ImageColor3 = Color3.fromRGB(200, 200, 200) -- slightly dimmer icon for dark mode
tshadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
tshadow.ImageTransparency = 0.6

-- Notify functions
function window:Notify(txt1, txt2, b1, icohn, callback)
    if notif.Visible == true or notif2.Visible == true then return "Already visible" end
    notiftitle.Text = txt1
    notiftext.Text = txt2
    notificon.Image = icohn
    notificon.ImageColor3 = Color3.fromRGB(200, 200, 200)
    notif.Visible = true
    notifbutton1.Text = b1
    notifbutton1.BackgroundColor3 = Color3.fromRGB(21, 103, 251)
    notifbutton1.TextColor3 = Color3.fromRGB(255, 255, 255)
    if callback then
        con1 = notifbutton1.MouseButton1Click:Connect(function()
            con1:Disconnect()
            callback()
            notif.Visible = false
        end)
    end
end

function window:Notify2(txt1, txt2, b1, b2, icohn, callback, callback2)
    if notif.Visible == true or notif2.Visible == true then return "Already visible" end
    notif2title.Text = txt1
    notif2text.Text = txt2
    notif2icon.Image = icohn
    notif2icon.ImageColor3 = Color3.fromRGB(200, 200, 200)
    notif2.Visible = true
    notif2button1.Text = b1
    notif2button2.Text = b2
    notif2button1.BackgroundColor3 = Color3.fromRGB(21, 103, 251)
    notif2button2.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    notif2button1.TextColor3 = Color3.fromRGB(255, 255, 255)
    notif2button2.TextColor3 = Color3.fromRGB(230, 230, 230)
    if callback and callback2 then
        con1 = notif2button1.MouseButton1Click:Connect(function()
            con1:Disconnect()
            con2:Disconnect()
            callback()
            notif2.Visible = false
        end)
        con2 = notif2button2.MouseButton1Click:Connect(function()
            con1:Disconnect()
            con2:Disconnect()
            callback2()
            notif2.Visible = false
        end)
    end
end

-- Sidebar / workarea dark mode
sidebar2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
sidebar2.TextColor3 = Color3.fromRGB(230, 230, 230)
workareamain.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

-- Section labels inside workarea
section.TextColor3 = Color3.fromRGB(230, 230, 230)

-- Buttons in dark mode
button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
button.TextColor3 = Color3.fromRGB(21, 103, 251)
us.Color = Color3.fromRGB(21, 103, 251)

-- Labels in dark mode
label.TextColor3 = Color3.fromRGB(230, 230, 230)

-- Switch / Toggle dark mode
toggleswitch.TextColor3 = Color3.fromRGB(230, 230, 230)
Frame.BackgroundColor3 = defaultmode and Color3.fromRGB(21, 103, 251) or Color3.fromRGB(60, 60, 60)
TextButton.BackgroundColor3 = defaultmode and Color3.fromRGB(21, 103, 251) or Color3.fromRGB(70, 70, 70)
TextButton.TextColor3 = Color3.fromRGB(230, 230, 230)


            local uc_4 = Instance.new("UICorner")
            uc_4.CornerRadius = UDim.new(5, 0)
            uc_4.Parent = Frame

local TextButton = Instance.new("TextButton")
TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60) -- dark base
TextButton.Size = UDim2.new(0, 34, 0, 34)
TextButton.AutoButtonColor = false
TextButton.Text = ""
TextButton.TextColor3 = Color3.fromRGB(230, 230, 230) -- light text (if any)

local uc_5 = Instance.new("UICorner")
uc_5.CornerRadius = UDim.new(0, 5)
uc_5.Parent = TextButton

if defaultmode == false then
    TextButton.Position = UDim2.new(0, 1, 0, 1)
    Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- dark inactive background
else
    TextButton.Position = UDim2.new(0, 35, 0, 1)
    Frame.BackgroundColor3 = Color3.fromRGB(21, 103, 251) -- active accent
end

-- Optional: hover effect
TextButton.MouseEnter:Connect(function()
    if TextButton.Position == UDim2.new(0,1,0,1) then
        TextButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end
end)
TextButton.MouseLeave:Connect(function()
    if TextButton.Position == UDim2.new(0,1,0,1) then
        TextButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end
end)

            Frame.MouseButton1Click:Connect(function()
                mode = not mode

                if callback then
                    callback(mode)
                        
                endif mode then
    TextButton:TweenPosition(UDim2.new(0, 35, 0, 1), "In", "Sine", 0.1, true)
    Frame.BackgroundColor3 = Color3.fromRGB(21, 103, 251) -- active toggle color
else
    TextButton:TweenPosition(UDim2.new(0, 1, 0, 1), "In", "Sine", 0.1, true)
    Frame.BackgroundColor3 = Color3.fromRGB(60, 60, 60) -- dark gray for inactive
end

            TextButton.MouseButton1Click:Connect(function()
                mode = not mode

                if callback then
                    callback(mode)
                end

function sec:TextField(name, placeholder, callback)
    local textfield = Instance.new("TextLabel")
    textfield.Name = "textfield"
    textfield.Parent = workareamain
    textfield.BackgroundTransparency = 1
    textfield.BorderSizePixel = 0
    textfield.Size = UDim2.new(0, 418, 0, 37)
    textfield.Font = Enum.Font.Gotham
    textfield.Text = name
    textfield.TextColor3 = Color3.fromRGB(230, 230, 230) -- light text for dark mode
    textfield.TextSize = 21
    textfield.TextWrapped = true
    textfield.TextXAlignment = Enum.TextXAlignment.Left

    local Frame_2 = Instance.new("Frame")
    Frame_2.Parent = textfield
    Frame_2.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- dark background for input
    Frame_2.Position = UDim2.new(0.4419, 0, 0.027, 0)
    Frame_2.Size = UDim2.new(0, 233, 0, 34)
    Frame_2.BorderSizePixel = 0
                        
    -- TextBox inside the frame
    local TextBox = Instance.new("TextBox")
    TextBox.Parent = Frame_2
    TextBox.BackgroundTransparency = 1
    TextBox.Size = UDim2.new(1, -10, 1, 0)
    TextBox.Position = UDim2.new(0, 5, 0, 0)
    TextBox.ClearTextOnFocus = false
    TextBox.Font = Enum.Font.Gotham
    TextBox.PlaceholderColor3 = Color3.fromRGB(160, 160, 160)
    TextBox.PlaceholderText = placeholder or "Type..."
    TextBox.Text = ""
    TextBox.TextColor3 = Color3.fromRGB(230, 230, 230)
    TextBox.TextSize = 21
    TextBox.TextXAlignment = Enum.TextXAlignment.Left
end


            local uc_6 = Instance.new("UICorner")
            uc_6.CornerRadius = UDim.new(0, 9)
            uc_6.Parent = Frame_2

          local TextBox = Instance.new("TextBox")
TextBox.Parent = Frame_2
TextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- dark background
TextBox.BorderSizePixel = 0
TextBox.ClipsDescendants = true
TextBox.Position = UDim2.new(0.064, 0, 0, -2)
TextBox.Size = UDim2.new(0, 203, 0, 34)
TextBox.ClearTextOnFocus = false
TextBox.Font = Enum.Font.Gotham
TextBox.LineHeight = 0.87
TextBox.PlaceholderColor3 = Color3.fromRGB(160, 160, 160) -- lighter placeholder
TextBox.PlaceholderText = placeholder or "Type..."
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(230, 230, 230) -- light text
TextBox.TextSize = 21
TextBox.TextXAlignment = Enum.TextXAlignment.Left

            if callback then
                TextBox.FocusLost:Connect(function()
                    callback(TextBox.Text)
                end)
            end
        end

        sidebar2.MouseButton1Click:Connect(function()
            sec:Select()
        end)

        return sec
    end

    return window
end

return lib
