local UIS = game:GetService("UserInputService")
local Anim = require(script.Animator)

local Widgets = {}

local bold = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
local reg = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)

local function row(parent, order, h)
	local wrap = Instance.new("Frame")
	wrap.Parent = parent
	wrap.BorderSizePixel = 0
	wrap.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
	wrap.Size = UDim2.new(1, 0, 0, h or 38)
	wrap.LayoutOrder = order

	local r = Instance.new("UICorner", wrap)
	r.CornerRadius = UDim.new(0, 6)

	return wrap
end

local function leftTxt(parent, str)
	local lbl = Instance.new("TextLabel")
	lbl.Parent = parent
	lbl.BorderSizePixel = 0
	lbl.BackgroundTransparency = 1
	lbl.TextColor3 = Color3.fromRGB(210, 210, 210)
	lbl.TextSize = 12
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.FontFace = bold
	lbl.Text = str
	lbl.Size = UDim2.new(0.55, -10, 1, 0)
	lbl.Position = UDim2.new(0, 10, 0, 0)
	lbl.TextTruncate = Enum.TextTruncate.AtEnd
	return lbl
end

function Widgets.Section(parent, name, order)
	local sec = {}
	local count = 0

	local wrap = Instance.new("Frame")
	wrap.Parent = parent
	wrap.Name = "Section_" .. name
	wrap.BorderSizePixel = 0
	wrap.BackgroundTransparency = 1
	wrap.Size = UDim2.new(1, 0, 0, 0)
	wrap.AutomaticSize = Enum.AutomaticSize.Y
	wrap.LayoutOrder = order

	local stack = Instance.new("UIListLayout", wrap)
	stack.SortOrder = Enum.SortOrder.LayoutOrder
	stack.Padding = UDim.new(0, 5)

	local head = Instance.new("TextLabel", wrap)
	head.Name = "SectionHead"
	head.BorderSizePixel = 0
	head.BackgroundTransparency = 1
	head.TextColor3 = Color3.fromRGB(150, 150, 150)
	head.TextSize = 11
	head.TextXAlignment = Enum.TextXAlignment.Left
	head.FontFace = bold
	head.Text = name
	head.Size = UDim2.new(1, 0, 0, 16)
	head.LayoutOrder = 1

	local divider = Instance.new("Frame", wrap)
	divider.Name = "Divider"
	divider.BorderSizePixel = 0
	divider.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
	divider.Size = UDim2.new(1, 0, 0, 1)
	divider.LayoutOrder = 2

	local body = Instance.new("Frame", wrap)
	body.Name = "Body"
	body.BorderSizePixel = 0
	body.BackgroundTransparency = 1
	body.Size = UDim2.new(1, 0, 0, 0)
	body.AutomaticSize = Enum.AutomaticSize.Y
	body.LayoutOrder = 3

	local bodyStack = Instance.new("UIListLayout", body)
	bodyStack.SortOrder = Enum.SortOrder.LayoutOrder
	bodyStack.Padding = UDim.new(0, 4)

	local function next()
		count += 1
		return count
	end

	function sec:AddButton(cfg)   return Widgets.Button(body, cfg, next()) end
	function sec:AddToggle(cfg)   return Widgets.Toggle(body, cfg, next()) end
	function sec:AddSlider(cfg)   return Widgets.Slider(body, cfg, next()) end
	function sec:AddDropdown(cfg) return Widgets.Dropdown(body, cfg, next()) end
	function sec:AddInput(cfg)    return Widgets.Input(body, cfg, next()) end
	function sec:AddColorPicker(cfg) return Widgets.ColorPicker(body, cfg, next()) end

	return sec
end

function Widgets.Button(parent, cfg, order)
	local wrap = row(parent, order, 38)
	leftTxt(wrap, cfg.Title or "Button")

	local btn = Instance.new("TextButton", wrap)
	btn.BorderSizePixel = 0
	btn.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
	btn.TextColor3 = Color3.fromRGB(185, 185, 185)
	btn.TextSize = 11
	btn.FontFace = bold
	btn.Text = cfg.Flag or "Click"
	btn.Size = UDim2.new(0.36, 0, 0.6, 0)
	btn.Position = UDim2.new(0.61, 0, 0.2, 0)
	btn.AutoButtonColor = false

	local rc = Instance.new("UICorner", btn)
	rc.CornerRadius = UDim.new(0, 5)

	btn.MouseEnter:Connect(function()
		Anim.ReColor(btn, Color3.fromRGB(65, 65, 65), 0.12)
		Anim.ReColorText(btn, Color3.fromRGB(220, 220, 220), 0.12)
	end)
	btn.MouseLeave:Connect(function()
		Anim.ReColor(btn, Color3.fromRGB(52, 52, 52), 0.12)
		Anim.ReColorText(btn, Color3.fromRGB(185, 185, 185), 0.12)
	end)
	btn.MouseButton1Down:Connect(function()
		Anim.ReColor(btn, Color3.fromRGB(78, 78, 78), 0.08)
	end)
	btn.MouseButton1Up:Connect(function()
		Anim.ReColor(btn, Color3.fromRGB(65, 65, 65), 0.1)
	end)
	btn.MouseButton1Click:Connect(function()
		if cfg.Callback then cfg.Callback() end
	end)
end

function Widgets.Toggle(parent, cfg, order)
	local obj = {}
	local on = cfg.Default or false

	local wrap = row(parent, order, 38)
	leftTxt(wrap, cfg.Title or "Toggle")

	local box = Instance.new("Frame", wrap)
	box.Name = "Checkbox"
	box.BorderSizePixel = 0
	box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	box.Size = UDim2.new(0, 20, 0, 20)
	box.Position = UDim2.new(1, -34, 0.5, -10)

	local bc = Instance.new("UICorner", box)
	bc.CornerRadius = UDim.new(0, 4)

	local border = Instance.new("UIStroke", box)
	border.Color = Color3.fromRGB(185, 185, 185)
	border.Thickness = 2

	local cube = Instance.new("Frame", box)
	cube.Name = "Cube"
	cube.BorderSizePixel = 0
	cube.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	cube.Size = UDim2.new(0.65, 0, 0.65, 0)
	cube.Position = UDim2.new(0.175, 0, 0.175, 0)
	cube.BackgroundTransparency = on and 0 or 1

	local cubeC = Instance.new("UICorner", cube)
	cubeC.CornerRadius = UDim.new(0, 3)

	local hit = Instance.new("TextButton", wrap)
	hit.BorderSizePixel = 0
	hit.BackgroundTransparency = 1
	hit.Size = UDim2.new(1, 0, 1, 0)
	hit.Text = ""
	hit.AutoButtonColor = false

	hit.MouseButton1Click:Connect(function()
		on = not on
		Anim.Tween(cube, { BackgroundTransparency = on and 0 or 1 }, 0.18)
		if on then
			Anim.Spring(cube, { Size = UDim2.new(0.7, 0, 0.7, 0), Position = UDim2.new(0.15, 0, 0.15, 0) }, 0.25)
		else
			Anim.Resize(cube, UDim2.new(0.65, 0, 0.65, 0), 0.15)
			cube.Position = UDim2.new(0.175, 0, 0.175, 0)
		end
		if cfg.Callback then cfg.Callback(on) end
	end)

	function obj:Set(val) on = val; cube.BackgroundTransparency = on and 0 or 1 end
	function obj:Get() return on end

	return obj
end

function Widgets.Slider(parent, cfg, order)
	local obj = {}
	local lo = cfg.Minimum or 0
	local hi = cfg.Maximum or 100
	local val = math.clamp(cfg.Default or lo, lo, hi)
	local held = false

	local wrap = row(parent, order, 54)
	wrap.ClipsDescendants = false
	leftTxt(wrap, cfg.Title or "Slider")

	local readout = Instance.new("TextLabel", wrap)
	readout.BorderSizePixel = 0
	readout.BackgroundTransparency = 1
	readout.TextColor3 = Color3.fromRGB(180, 180, 180)
	readout.TextSize = 11
	readout.TextXAlignment = Enum.TextXAlignment.Right
	readout.FontFace = bold
	readout.Text = tostring(val)
	readout.Size = UDim2.new(0.35, -10, 0.5, 0)
	readout.Position = UDim2.new(0.61, 0, 0, 0)

	local rail = Instance.new("Frame", wrap)
	rail.Name = "Rail"
	rail.BorderSizePixel = 0
	rail.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
	rail.Size = UDim2.new(1, -20, 0, 4)
	rail.Position = UDim2.new(0, 10, 0, 40)

	local railC = Instance.new("UICorner", rail)
	railC.CornerRadius = UDim.new(1, 0)

	local filled = Instance.new("Frame", rail)
	filled.Name = "Filled"
	filled.BorderSizePixel = 0
	filled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	filled.Size = UDim2.new((val - lo) / (hi - lo), 0, 1, 0)

	local filledC = Instance.new("UICorner", filled)
	filledC.CornerRadius = UDim.new(1, 0)

	local knob = Instance.new("Frame", rail)
	knob.Name = "Knob"
	knob.BorderSizePixel = 0
	knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	knob.Size = UDim2.new(0, 12, 0, 12)
	knob.Position = UDim2.new((val - lo) / (hi - lo), -6, 0.5, -6)

	local knobC = Instance.new("UICorner", knob)
	knobC.CornerRadius = UDim.new(1, 0)

	local knobStroke = Instance.new("UIStroke", knob)
	knobStroke.Color = Color3.fromRGB(80, 80, 80)
	knobStroke.Thickness = 1

	local function drag(pos)
		local pct = math.clamp((pos.X - rail.AbsolutePosition.X) / rail.AbsoluteSize.X, 0, 1)
		val = math.round(lo + (hi - lo) * pct)
		local p = (val - lo) / (hi - lo)
		filled.Size = UDim2.new(p, 0, 1, 0)
		knob.Position = UDim2.new(p, -6, 0.5, -6)
		readout.Text = tostring(val)
		if cfg.Callback then cfg.Callback(val) end
	end

	rail.InputBegan:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 then
			held = true
			drag(inp.Position)
		end
	end)
	UIS.InputChanged:Connect(function(inp)
		if held and inp.UserInputType == Enum.UserInputType.MouseMovement then
			drag(inp.Position)
		end
	end)
	UIS.InputEnded:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 then held = false end
	end)

	function obj:Set(v)
		val = math.clamp(v, lo, hi)
		local p = (val - lo) / (hi - lo)
		filled.Size = UDim2.new(p, 0, 1, 0)
		knob.Position = UDim2.new(p, -6, 0.5, -6)
		readout.Text = tostring(val)
	end
	function obj:Get() return val end

	return obj
end

function Widgets.Dropdown(parent, cfg, order)
	local obj = {}
	local picked = cfg.Default or "none"
	local opts = cfg.Options or {}
	local open = false
	local closedH = 38
	local openH = closedH + 8 + (#opts * 28)

	local wrap = Instance.new("Frame", parent)
	wrap.Name = "Dropdown"
	wrap.BorderSizePixel = 0
	wrap.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
	wrap.Size = UDim2.new(1, 0, 0, closedH)
	wrap.LayoutOrder = order
	wrap.ClipsDescendants = true

	local wc = Instance.new("UICorner", wrap)
	wc.CornerRadius = UDim.new(0, 6)

	leftTxt(wrap, cfg.Title or "Dropdown")

	local pill = Instance.new("TextButton", wrap)
	pill.BorderSizePixel = 0
	pill.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
	pill.TextColor3 = Color3.fromRGB(185, 185, 185)
	pill.TextSize = 11
	pill.FontFace = bold
	pill.Text = picked .. " ▾"
	pill.Size = UDim2.new(0.38, 0, 0.6, 0)
	pill.Position = UDim2.new(0.59, 0, 0.2, 0)
	pill.AutoButtonColor = false

	local pc = Instance.new("UICorner", pill)
	pc.CornerRadius = UDim.new(0, 5)

	local sheet = Instance.new("Frame", wrap)
	sheet.Name = "Sheet"
	sheet.BorderSizePixel = 0
	sheet.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
	sheet.Position = UDim2.new(0, 0, 0, closedH + 4)
	sheet.Size = UDim2.new(1, 0, 0, #opts * 28)

	local sc = Instance.new("UICorner", sheet)
	sc.CornerRadius = UDim.new(0, 6)

	local sheetStack = Instance.new("UIListLayout", sheet)
	sheetStack.SortOrder = Enum.SortOrder.LayoutOrder

	local function buildOpts(list)
		for _, ch in ipairs(sheet:GetChildren()) do
			if ch:IsA("TextButton") then ch:Destroy() end
		end
		for i, opt in ipairs(list) do
			local entry = Instance.new("TextButton", sheet)
			entry.BorderSizePixel = 0
			entry.BackgroundTransparency = 1
			entry.TextColor3 = Color3.fromRGB(185, 185, 185)
			entry.TextSize = 11
			entry.TextXAlignment = Enum.TextXAlignment.Left
			entry.FontFace = reg
			entry.Text = "   " .. opt
			entry.Size = UDim2.new(1, 0, 0, 28)
			entry.LayoutOrder = i
			entry.AutoButtonColor = false
			entry.MouseEnter:Connect(function() Anim.Fade(entry, 0.75, 0.1) end)
			entry.MouseLeave:Connect(function() Anim.Fade(entry, 1, 0.1) end)
			entry.MouseButton1Click:Connect(function()
				picked = opt
				pill.Text = picked .. " ▾"
				open = false
				Anim.Resize(wrap, UDim2.new(1, 0, 0, closedH), 0.2).Completed:Connect(function()
					wrap.ClipsDescendants = true
				end)
				if cfg.Callback then cfg.Callback(picked) end
			end)
		end
	end

	buildOpts(opts)

	pill.MouseEnter:Connect(function() Anim.ReColor(pill, Color3.fromRGB(65, 65, 65), 0.12) end)
	pill.MouseLeave:Connect(function() Anim.ReColor(pill, Color3.fromRGB(52, 52, 52), 0.12) end)
	pill.MouseButton1Click:Connect(function()
		open = not open
		if open then
			wrap.ClipsDescendants = false
			Anim.Resize(wrap, UDim2.new(1, 0, 0, openH), 0.22)
		else
			Anim.Resize(wrap, UDim2.new(1, 0, 0, closedH), 0.2).Completed:Connect(function()
				wrap.ClipsDescendants = true
			end)
		end
	end)

	function obj:Set(v) picked = v; pill.Text = picked .. " ▾" end
	function obj:Get() return picked end
	function obj:SetOptions(list)
		opts = list
		openH = closedH + 8 + (#opts * 28)
		sheet.Size = UDim2.new(1, 0, 0, #opts * 28)
		buildOpts(opts)
	end

	return obj
end

function Widgets.Input(parent, cfg, order)
	local obj = {}
	local stored = cfg.Default or ""

	local wrap = row(parent, order, 38)
	leftTxt(wrap, cfg.Title or "Input")

	local field = Instance.new("TextBox", wrap)
	field.BorderSizePixel = 0
	field.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
	field.TextColor3 = Color3.fromRGB(210, 210, 210)
	field.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
	field.TextSize = 11
	field.FontFace = reg
	field.Text = stored
	field.PlaceholderText = cfg.Placeholder or "..."
	field.ClearTextOnFocus = false
	field.Size = UDim2.new(0.38, 0, 0.6, 0)
	field.Position = UDim2.new(0.59, 0, 0.2, 0)

	local fc = Instance.new("UICorner", field)
	fc.CornerRadius = UDim.new(0, 5)

	local fp = Instance.new("UIPadding", field)
	fp.PaddingLeft = UDim.new(0, 6)
	fp.PaddingRight = UDim.new(0, 6)

	field.Focused:Connect(function()
		Anim.ReColor(field, Color3.fromRGB(65, 65, 65), 0.12)
	end)
	field.FocusLost:Connect(function(enter)
		stored = field.Text
		Anim.ReColor(field, Color3.fromRGB(52, 52, 52), 0.12)
		if cfg.Callback then cfg.Callback(stored, enter) end
	end)

	function obj:Set(v) stored = v; field.Text = v end
	function obj:Get() return stored end

	return obj
end

function Widgets.ColorPicker(parent, cfg, order)
	local obj = {}
	local col = cfg.Default or Color3.fromRGB(255, 255, 255)
	local h, s, v = Color3.toHSV(col)
	local showing = false
	local dragHue = false
	local dragSV = false
	local closedH = 38
	local openH = 38 + 6 + 130

	local wrap = Instance.new("Frame", parent)
	wrap.Name = "ColorPicker"
	wrap.BorderSizePixel = 0
	wrap.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
	wrap.Size = UDim2.new(1, 0, 0, closedH)
	wrap.LayoutOrder = order
	wrap.ClipsDescendants = true

	local wc = Instance.new("UICorner", wrap)
	wc.CornerRadius = UDim.new(0, 6)

	leftTxt(wrap, cfg.Title or "Color")

	local swatch = Instance.new("TextButton", wrap)
	swatch.Name = "Swatch"
	swatch.BorderSizePixel = 0
	swatch.BackgroundColor3 = col
	swatch.Text = ""
	swatch.Size = UDim2.new(0, 30, 0, 22)
	swatch.Position = UDim2.new(1, -40, 0.5, -11)
	swatch.AutoButtonColor = false

	local swatchC = Instance.new("UICorner", swatch)
	swatchC.CornerRadius = UDim.new(0, 5)

	local swatchStroke = Instance.new("UIStroke", swatch)
	swatchStroke.Color = Color3.fromRGB(80, 80, 80)
	swatchStroke.Thickness = 1

	local picker = Instance.new("Frame", wrap)
	picker.Name = "Picker"
	picker.BorderSizePixel = 0
	picker.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
	picker.Size = UDim2.new(1, 0, 0, 130)
	picker.Position = UDim2.new(0, 0, 0, closedH + 6)

	local pickerC = Instance.new("UICorner", picker)
	pickerC.CornerRadius = UDim.new(0, 6)

	local svBox = Instance.new("ImageLabel", picker)
	svBox.Name = "SVBox"
	svBox.BorderSizePixel = 0
	svBox.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
	svBox.Size = UDim2.new(0.88, 0, 0, 75)
	svBox.Position = UDim2.new(0.06, 0, 0, 8)
	svBox.Image = "rbxassetid://4155801252"

	local svBoxC = Instance.new("UICorner", svBox)
	svBoxC.CornerRadius = UDim.new(0, 4)

	local dot = Instance.new("Frame", svBox)
	dot.Name = "Dot"
	dot.BorderSizePixel = 0
	dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	dot.Size = UDim2.new(0, 10, 0, 10)
	dot.Position = UDim2.new(s, -5, 1 - v, -5)

	local dotC = Instance.new("UICorner", dot)
	dotC.CornerRadius = UDim.new(1, 0)

	local dotStroke = Instance.new("UIStroke", dot)
	dotStroke.Color = Color3.fromRGB(0, 0, 0)
	dotStroke.Thickness = 1.5

	local hueStrip = Instance.new("Frame", picker)
	hueStrip.Name = "HueStrip"
	hueStrip.BorderSizePixel = 0
	hueStrip.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	hueStrip.Size = UDim2.new(0.88, 0, 0, 12)
	hueStrip.Position = UDim2.new(0.06, 0, 0, 92)

	local hueStripC = Instance.new("UICorner", hueStrip)
	hueStripC.CornerRadius = UDim.new(1, 0)

	local hueGrad = Instance.new("UIGradient", hueStrip)
	hueGrad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
		ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
		ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
		ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
		ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
	})

	local huePip = Instance.new("Frame", hueStrip)
	huePip.Name = "HuePip"
	huePip.BorderSizePixel = 0
	huePip.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	huePip.Size = UDim2.new(0, 8, 0, 16)
	huePip.Position = UDim2.new(h, -4, 0.5, -8)

	local huePipC = Instance.new("UICorner", huePip)
	huePipC.CornerRadius = UDim.new(1, 0)

	local huePipStroke = Instance.new("UIStroke", huePip)
	huePipStroke.Color = Color3.fromRGB(0, 0, 0)
	huePipStroke.Thickness = 1.5

	local function push()
		col = Color3.fromHSV(h, s, v)
		swatch.BackgroundColor3 = col
		svBox.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
		huePip.Position = UDim2.new(h, -4, 0.5, -8)
		dot.Position = UDim2.new(s, -5, 1 - v, -5)
		if cfg.Callback then cfg.Callback(col) end
	end

	hueStrip.InputBegan:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 then
			dragHue = true
			h = math.clamp((inp.Position.X - hueStrip.AbsolutePosition.X) / hueStrip.AbsoluteSize.X, 0, 1)
			push()
		end
	end)
	svBox.InputBegan:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 then
			dragSV = true
			s = math.clamp((inp.Position.X - svBox.AbsolutePosition.X) / svBox.AbsoluteSize.X, 0, 1)
			v = 1 - math.clamp((inp.Position.Y - svBox.AbsolutePosition.Y) / svBox.AbsoluteSize.Y, 0, 1)
			push()
		end
	end)
	UIS.InputChanged:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseMovement then
			if dragHue then
				h = math.clamp((inp.Position.X - hueStrip.AbsolutePosition.X) / hueStrip.AbsoluteSize.X, 0, 1)
				push()
			elseif dragSV then
				s = math.clamp((inp.Position.X - svBox.AbsolutePosition.X) / svBox.AbsoluteSize.X, 0, 1)
				v = 1 - math.clamp((inp.Position.Y - svBox.AbsolutePosition.Y) / svBox.AbsoluteSize.Y, 0, 1)
				push()
			end
		end
	end)
	UIS.InputEnded:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 then
			dragHue = false
			dragSV = false
		end
	end)

	swatch.MouseButton1Click:Connect(function()
		showing = not showing
		if showing then
			wrap.ClipsDescendants = false
			Anim.Resize(wrap, UDim2.new(1, 0, 0, openH), 0.22)
		else
			Anim.Resize(wrap, UDim2.new(1, 0, 0, closedH), 0.2).Completed:Connect(function()
				wrap.ClipsDescendants = true
			end)
		end
	end)

	function obj:Set(c)
		col = c
		h, s, v = Color3.toHSV(col)
		swatch.BackgroundColor3 = col
		svBox.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
		huePip.Position = UDim2.new(h, -4, 0.5, -8)
		dot.Position = UDim2.new(s, -5, 1 - v, -5)
	end
	function obj:Get() return col end

	return obj
end

return Widgets
