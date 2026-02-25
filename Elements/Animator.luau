-- Yep Im just too pro
local ts = game:GetService("TweenService")

local Animator = {}

local function info(spd, sty, dir)
	return TweenInfo.new(
		spd or 0.2,
		sty or Enum.EasingStyle.Quart,
		dir or Enum.EasingDirection.Out
	)
end

function Animator.Tween(obj, props, spd, sty, dir)
	local tw = ts:Create(obj, info(spd, sty, dir), props)
	tw:Play()
	return tw
end

function Animator.Fade(obj, to, spd)
	return Animator.Tween(obj, { BackgroundTransparency = to }, spd)
end

function Animator.FadeText(obj, to, spd)
	return Animator.Tween(obj, { TextTransparency = to }, spd)
end

function Animator.Move(obj, pos, spd)
	return Animator.Tween(obj, { Position = pos }, spd)
end

function Animator.Resize(obj, sz, spd)
	return Animator.Tween(obj, { Size = sz }, spd)
end

function Animator.ReColor(obj, col, spd)
	return Animator.Tween(obj, { BackgroundColor3 = col }, spd)
end

function Animator.ReColorText(obj, col, spd)
	return Animator.Tween(obj, { TextColor3 = col }, spd)
end

function Animator.ReColorImage(obj, col, spd)
	return Animator.Tween(obj, { ImageColor3 = col }, spd)
end

function Animator.Spring(obj, props, spd)
	return Animator.Tween(obj, props, spd, Enum.EasingStyle.Spring, Enum.EasingDirection.Out)
end

function Animator.Slide(obj, pos, spd)
	return Animator.Tween(obj, { Position = pos }, spd, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
end

return Animator
