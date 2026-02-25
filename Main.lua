local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")

local Anim = require(Elements.Animator" )
local Icons = require(Elements.Icons")
local Widgets = require(Elements.Widgets")

local Library = {}

local GRAY = Color3.fromRGB(99, 99, 99)
local WHITE = Color3.fromRGB(255, 255, 255)
local BG = Color3.fromRGB(30, 30, 30)
local FULL = UDim2.new(0.60508, 0, 0.89269, 0)
local bold = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)

function Library:Window(cfg)
	local hub = {}

	local screen = Instance.new("ScreenGui")
	screen.Name = "SolV2"
	screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screen.ResetOnSpawn = false
	screen.IgnoreGuiInset = true
	screen.Parent = CoreGui

	local win = Instance.new("Frame", screen)
	win.Name = "Window"
	win.BorderSizePixel = 0
	win.BackgroundColor3 = BG
	win.Size = FULL
	win.Position = UDim2.new(0.20092, 0, 0.04782, 0)
	win.ClipsDescendants = true

	local winC = Instance.new("UICorner", win)
	winC.CornerRadius = UDim.new(0, 8)

	local topbar = Instance.new("Frame", win)
	topbar.Name = "Topbar"
	topbar.BorderSizePixel = 0
	topbar.BackgroundTransparency = 1
	topbar.Size = UDim2.new(0.98473, 0, 0.10714, 0)
	topbar.Position = UDim2.new(0.00763, 0, 0.0119, 0)

	local hubIcon = Instance.new("ImageLabel", topbar)
	hubIcon.Name = "Icon"
	hubIcon.BorderSizePixel = 0
	hubIcon.BackgroundTransparency = 1
	hubIcon.Size = UDim2.new(0.0814, 0, 1, 0)
	hubIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
	hubIcon.Image = cfg.Icon and Icons.Get(cfg.Icon) or ""

	local hubTitle = Instance.new("TextLabel", topbar)
	hubTitle.Name = "HubTitle"
	hubTitle.BorderSizePixel = 0
	hubTitle.TextSize = 14
	hubTitle.TextXAlignment = Enum.TextXAlignment.Left
	hubTitle.BackgroundTransparency = 1
	hubTitle.FontFace = bold
	hubTitle.TextColor3 = WHITE
	hubTitle.Size = UDim2.new(0.24419, 0, 0.44444, 0)
	hubTitle.Text = cfg.Title or "Hub"
	hubTitle.Position = UDim2.new(0.08527, 0, 0.05556, 0)

	local hubSub = Instance.new("TextLabel", topbar)
	hubSub.Name = "HubSub"
	hubSub.BorderSizePixel = 0
	hubSub.TextXAlignment = Enum.TextXAlignment.Left
	hubSub.BackgroundTransparency = 1
	hubSub.FontFace = bold
	hubSub.TextColor3 = Color3.fromRGB(69, 69, 69)
	hubSub.Size = UDim2.new(0.24419, 0, 0.44444, 0)
	hubSub.Text = cfg.SubTitle or ""
	hubSub.Position = UDim2.new(0.08527, 0, 0.33333, 0)

	local closeX = Instance.new("TextButton", topbar)
	closeX.Name = "Close"
	closeX.BorderSizePixel = 0
	closeX.BackgroundTransparency = 1
	closeX.Size = UDim2.new(0, 24, 0, 24)
	closeX.Position = UDim2.new(1, -28, 0.5, -12)
	closeX.Text = "✕"
	closeX.TextSize = 13
	closeX.TextColor3 = Color3.fromRGB(140, 140, 140)
	closeX.FontFace = bold
	closeX.AutoButtonColor = false

	local minBtn = Instance.new("TextButton", topbar)
	minBtn.Name = "Minimize"
	minBtn.BorderSizePixel = 0
	minBtn.BackgroundTransparency = 1
	minBtn.Size = UDim2.new(0, 24, 0, 24)
	minBtn.Position = UDim2.new(1, -56, 0.5, -12)
	minBtn.Text = "─"
	minBtn.TextSize = 13
	minBtn.TextColor3 = Color3.fromRGB(140, 140, 140)
	minBtn.FontFace = bold
	minBtn.AutoButtonColor = false

	local divider = Instance.new("Frame", win)
	divider.Name = "Divider"
	divider.BorderSizePixel = 0
	divider.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
	divider.Size = UDim2.new(0.001, 0, 0.86, 0)
	divider.Position = UDim2.new(0.285, 0, 0.126, 0)

	local sidebar = Instance.new("Frame", win)
	sidebar.Name = "Sidebar"
	sidebar.BorderSizePixel = 0
	sidebar.BackgroundTransparency = 1
	sidebar.Size = UDim2.new(0.275, 0, 0.86, 0)
	sidebar.Position = UDim2.new(0.006, 0, 0.126, 0)

	local sideStack = Instance.new("UIListLayout", sidebar)
	sideStack.SortOrder = Enum.SortOrder.LayoutOrder
	sideStack.Padding = UDim.new(0, 3)

	local sidePad = Instance.new("UIPadding", sidebar)
	sidePad.PaddingTop = UDim.new(0, 4)

	local pages = Instance.new("Frame", win)
	pages.Name = "Pages"
	pages.BorderSizePixel = 0
	pages.BackgroundTransparency = 1
	pages.Size = UDim2.new(0.705, 0, 0.86, 0)
	pages.Position = UDim2.new(0.292, 0, 0.126, 0)

	local notifStack = Instance.new("Frame", screen)
	notifStack.Name = "NotifStack"
	notifStack.BorderSizePixel = 0
	notifStack.BackgroundTransparency = 1
	notifStack.AnchorPoint = Vector2.new(1, 1)
	notifStack.Size = UDim2.new(0.22, 0, 0.5, 0)
	notifStack.Position = UDim2.new(1, -12, 1, -12)

	local notifLayout = Instance.new("UIListLayout", notifStack)
	notifLayout.SortOrder = Enum.SortOrder.LayoutOrder
	notifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	notifLayout.Padding = UDim.new(0, 6)
	notifLayout.FillDirection = Enum.FillDirection.Vertical

	local dragging = false
	local dragOrigin = nil
	local winOrigin = nil
	local shrunk = false
	local current = nil
	local tabList = {}
	local nCount = 0

	topbar.InputBegan:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragOrigin = inp.Position
			winOrigin = win.Position
		end
	end)
	topbar.InputEnded:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
	end)
	UIS.InputChanged:Connect(function(inp)
		if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = inp.Position - dragOrigin
			win.Position = UDim2.new(
				winOrigin.X.Scale, winOrigin.X.Offset + delta.X,
				winOrigin.Y.Scale, winOrigin.Y.Offset + delta.Y
			)
		end
	end)

	closeX.MouseEnter:Connect(function() Anim.ReColorText(closeX, Color3.fromRGB(255, 75, 75), 0.14) end)
	closeX.MouseLeave:Connect(function() Anim.ReColorText(closeX, Color3.fromRGB(140, 140, 140), 0.14) end)
	closeX.MouseButton1Click:Connect(function()
		local shut = TS:Create(win, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
			Size = UDim2.new(FULL.X.Scale, 0, 0, 0),
		})
		shut:Play()
		shut.Completed:Connect(function() screen:Destroy() end)
	end)

	minBtn.MouseEnter:Connect(function() Anim.ReColorText(minBtn, Color3.fromRGB(255, 210, 50), 0.14) end)
	minBtn.MouseLeave:Connect(function() Anim.ReColorText(minBtn, Color3.fromRGB(140, 140, 140), 0.14) end)
	minBtn.MouseButton1Click:Connect(function()
		shrunk = not shrunk
		Anim.Resize(win, shrunk and UDim2.new(FULL.X.Scale, 0, 0.12, 0) or FULL, 0.3)
	end)

	local function swap(tab)
		if current == tab then return end
		if current then
			current.page.Visible = false
			Anim.ReColorText(current.name, GRAY, 0.18)
			Anim.Tween(current.pip, { BackgroundTransparency = 1 }, 0.18)
			Anim.ReColor(current.btn, Color3.fromRGB(38, 38, 38), 0.18)
			Anim.Fade(current.btn, 1, 0.18)
			if current.img then Anim.ReColorImage(current.img, GRAY, 0.18) end
		end
		current = tab
		tab.page.Visible = true
		Anim.ReColorText(tab.name, WHITE, 0.18)
		Anim.Tween(tab.pip, { BackgroundTransparency = 0 }, 0.18)
		Anim.ReColor(tab.btn, Color3.fromRGB(42, 42, 42), 0.18)
		Anim.Fade(tab.btn, 0, 0.18)
		if tab.img then Anim.ReColorImage(tab.img, WHITE, 0.18) end
	end

	function hub:AddTab(tabCfg)
		local data = {}
		local idx = #tabList + 1

		local btn = Instance.new("TextButton", sidebar)
		btn.Name = tabCfg.Title or ("Tab" .. idx)
		btn.BorderSizePixel = 0
		btn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
		btn.BackgroundTransparency = 1
		btn.Size = UDim2.new(1, 0, 0, 34)
		btn.Text = ""
		btn.LayoutOrder = idx
		btn.AutoButtonColor = false

		local btnC = Instance.new("UICorner", btn)
		btnC.CornerRadius = UDim.new(0, 6)

		local pip = Instance.new("Frame", btn)
		pip.Name = "Pip"
		pip.BorderSizePixel = 0
		pip.BackgroundColor3 = WHITE
		pip.BackgroundTransparency = 1
		pip.Size = UDim2.new(0, 3, 0.55, 0)
		pip.Position = UDim2.new(0, 6, 0.225, 0)

		local pipC = Instance.new("UICorner", pip)
		pipC.CornerRadius = UDim.new(1, 0)

		local tabImg = nil
		local txtOffset = 16

		if tabCfg.Icon then
			tabImg = Instance.new("ImageLabel", btn)
			tabImg.Name = "Img"
			tabImg.BorderSizePixel = 0
			tabImg.BackgroundTransparency = 1
			tabImg.Size = UDim2.new(0, 16, 0, 16)
			tabImg.Position = UDim2.new(0, 22, 0.5, -8)
			tabImg.ImageColor3 = GRAY
			tabImg.Image = Icons.Get(tabCfg.Icon)
			txtOffset = 44
		end

		local tabName = Instance.new("TextLabel", btn)
		tabName.Name = "Name"
		tabName.BorderSizePixel = 0
		tabName.BackgroundTransparency = 1
		tabName.TextColor3 = GRAY
		tabName.TextSize = 12
		tabName.TextXAlignment = Enum.TextXAlignment.Left
		tabName.FontFace = bold
		tabName.Text = tabCfg.Title or "Tab"
		tabName.Size = UDim2.new(1, -(txtOffset + 10), 1, 0)
		tabName.Position = UDim2.new(0, txtOffset, 0, 0)

		local page = Instance.new("ScrollingFrame", pages)
		page.Name = "Page_" .. (tabCfg.Title or tostring(idx))
		page.BorderSizePixel = 0
		page.BackgroundTransparency = 1
		page.Size = UDim2.new(1, 0, 1, 0)
		page.ScrollBarThickness = 3
		page.ScrollBarImageColor3 = Color3.fromRGB(70, 70, 70)
		page.CanvasSize = UDim2.new(0, 0, 0, 0)
		page.AutomaticCanvasSize = Enum.AutomaticSize.Y
		page.Visible = false

		local pageStack = Instance.new("UIListLayout", page)
		pageStack.SortOrder = Enum.SortOrder.LayoutOrder
		pageStack.Padding = UDim.new(0, 8)

		local pagePad = Instance.new("UIPadding", page)
		pagePad.PaddingTop = UDim.new(0, 8)
		pagePad.PaddingLeft = UDim.new(0, 6)
		pagePad.PaddingRight = UDim.new(0, 8)
		pagePad.PaddingBottom = UDim.new(0, 8)

		data.btn = btn
		data.pip = pip
		data.name = tabName
		data.page = page
		data.img = tabImg
		data.secs = 0

		btn.MouseEnter:Connect(function()
			if current ~= data then Anim.Fade(btn, 0, 0.14) end
		end)
		btn.MouseLeave:Connect(function()
			if current ~= data then Anim.Fade(btn, 1, 0.14) end
		end)
		btn.MouseButton1Click:Connect(function() swap(data) end)

		tabList[idx] = data
		if idx == 1 then swap(data) end

		function data:AddSection(secName)
			self.secs += 1
			return Widgets.Section(page, secName, self.secs)
		end

		return data
	end

	function hub:Notify(nCfg)
		nCount += 1

		local dot = ({
			Green  = Color3.fromRGB(46, 213, 115),
			Red    = Color3.fromRGB(255, 71, 87),
			Yellow = Color3.fromRGB(255, 204, 0),
		})[nCfg.Type] or Color3.fromRGB(46, 213, 115)

		local card = Instance.new("Frame", notifStack)
		card.Name = "Notif_" .. nCount
		card.BorderSizePixel = 0
		card.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
		card.BackgroundTransparency = 1
		card.Size = UDim2.new(1, 0, 0, 68)
		card.LayoutOrder = nCount

		local cardC = Instance.new("UICorner", card)
		cardC.CornerRadius = UDim.new(0, 8)

		local cardStroke = Instance.new("UIStroke", card)
		cardStroke.Color = Color3.fromRGB(55, 55, 55)
		cardStroke.Thickness = 1

		local stripe = Instance.new("Frame", card)
		stripe.Name = "Stripe"
		stripe.BorderSizePixel = 0
		stripe.BackgroundColor3 = dot
		stripe.Size = UDim2.new(0, 3, 0.6, 0)
		stripe.Position = UDim2.new(0, 10, 0.2, 0)

		local stripeC = Instance.new("UICorner", stripe)
		stripeC.CornerRadius = UDim.new(1, 0)

		local heading = Instance.new("TextLabel", card)
		heading.BorderSizePixel = 0
		heading.BackgroundTransparency = 1
		heading.TextColor3 = WHITE
		heading.TextTransparency = 1
		heading.TextSize = 12
		heading.TextXAlignment = Enum.TextXAlignment.Left
		heading.FontFace = bold
		heading.Text = nCfg.Title or ""
		heading.Size = UDim2.new(0.85, 0, 0.45, 0)
		heading.Position = UDim2.new(0, 22, 0.06, 0)
		heading.TextTruncate = Enum.TextTruncate.AtEnd

		local sub = Instance.new("TextLabel", card)
		sub.BorderSizePixel = 0
		sub.BackgroundTransparency = 1
		sub.TextColor3 = Color3.fromRGB(130, 130, 130)
		sub.TextTransparency = 1
		sub.TextSize = 10
		sub.TextXAlignment = Enum.TextXAlignment.Left
		sub.TextWrapped = true
		sub.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		sub.Text = nCfg.Description or ""
		sub.Size = UDim2.new(0.85, 0, 0.42, 0)
		sub.Position = UDim2.new(0, 22, 0.5, 0)

		local timerBg = Instance.new("Frame", card)
		timerBg.Name = "TimerBg"
		timerBg.BorderSizePixel = 0
		timerBg.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
		timerBg.BackgroundTransparency = 1
		timerBg.Size = UDim2.new(1, -20, 0, 2)
		timerBg.Position = UDim2.new(0, 10, 1, -6)

		local timerBgC = Instance.new("UICorner", timerBg)
		timerBgC.CornerRadius = UDim.new(1, 0)

		local timer = Instance.new("Frame", timerBg)
		timer.Name = "Timer"
		timer.BorderSizePixel = 0
		timer.BackgroundColor3 = dot
		timer.Size = UDim2.new(1, 0, 1, 0)

		local timerC = Instance.new("UICorner", timer)
		timerC.CornerRadius = UDim.new(1, 0)

		Anim.Fade(card, 0, 0.25)
		Anim.FadeText(heading, 0, 0.25)
		Anim.FadeText(sub, 0, 0.25)
		Anim.Tween(timerBg, { BackgroundTransparency = 0 }, 0.25)

		local dur = nCfg.Duration or 4
		TS:Create(timer, TweenInfo.new(dur, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 0, 1, 0)
		}):Play()

		task.delay(dur, function()
			Anim.Fade(card, 1, 0.25)
			Anim.FadeText(heading, 1, 0.25)
			Anim.FadeText(sub, 1, 0.25).Completed:Connect(function()
				card:Destroy()
			end)
		end)
	end

	return hub
end

return Library