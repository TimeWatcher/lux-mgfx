if SERVER then return end

-- MGFX radial menu demo, styled after the classic dark emote wheel:
-- charcoal glass wedges over the live scene, one deep red hovered wedge with
-- an ember glow that bleeds into the hub, white figure icons, and a hub with
-- the action name plus Select / Back mouse hints.
--
-- Rendering rule for this file (see shared docs/API.md): GPU gradients and shader
-- glows, used the cache-friendly way. Static gradient stop tables are reused
-- where possible; the pointer light quantizes opacity so the LUT cache sees a
-- small bounded key set while animation still goes through geometry.
-- Wedges and arcs are SectorEx so every angle shares one convention.
--
-- Input model: a virtual pointer fed by panel cursor events, change-detected
-- polling of gui.MousePos and input.GetCursorPos, and raw CreateMove mouse
-- deltas when the engine refuses to free the cursor.

MGFX = MGFX or {}

if IsValid(MGFX._WheelDemoPanel) then
	MGFX._WheelDemoPanel:Remove()
end

local WheelPanel
local currentFontScale = -1
local addCommand = MGFX._AddCommand or concommand.Add
local debugCvar = CreateClientConVar("mgfx_wheel_debug", "0", true, false, "MGFX wheel demo: show pointer telemetry.")

local COLORS = {
	bg = Color(10, 12, 17, 230),
	wedge = Color(23, 24, 29, 86),
	wedgeSel = Color(30, 31, 37, 100),
	wedgeHot = Color(84, 20, 10, 142),
	wedgePress = Color(116, 26, 8, 160),
	hub = Color(22, 23, 28, 112),
	hubEdge = Color(255, 255, 255, 12),
	ember = Color(232, 58, 18),
	emberHot = Color(255, 110, 48),
	accent = Color(255, 70, 24),
	ink = Color(245, 246, 248, 252),
	muted = Color(170, 174, 182, 205),
	shadow = Color(0, 0, 0, 140),
}

local ACTIONS = {
	{title = "High five", pose = "highfive"},
	{title = "Crouch wave", pose = "crouch"},
	{title = "Arms behind", pose = "behind"},
	{title = "Hands up", pose = "handsup"},
}

local SEG_SPAN = 360 / #ACTIONS
local WHEEL_START = -180 -- first segment is the upper-left quadrant
local SEG_OUTSET_RATIO = 0.026
local SEG_OUTSET_MIN = 5
local SEG_OUTSET_MAX = 9
local HUB_GAP_RATIO = 0.04
local HUB_GAP_MIN = 10
local HUB_GAP_MAX = 15
local LIGHT_ALPHA_STEPS = 16

local math_cos = math.cos
local math_deg = math.deg
local math_exp = math.exp
local math_floor = math.floor
local math_max = math.max
local math_min = math.min
local math_pi = math.pi
local math_rad = math.rad
local math_sin = math.sin
local math_sqrt = math.sqrt

-- atan2 that works no matter which math library variant the branch ships.
local nativeAtan2 = math.atan2
local math_atan = math.atan
local function atan2(y, x)
	if nativeAtan2 then return nativeAtan2(y, x) end
	if x > 0 then return math_atan(y / x) end
	if x < 0 then
		if y >= 0 then return math_atan(y / x) + math_pi end
		return math_atan(y / x) - math_pi
	end
	if y > 0 then return math_pi * 0.5 end
	if y < 0 then return -math_pi * 0.5 end
	return 0
end

local function ensureFonts(scale)
	scale = math.Round(scale * 100) / 100
	if currentFontScale == scale then return end
	currentFontScale = scale

	local function font(name, face, size, weight)
		surface.CreateFont(name, {
			font = face,
			size = math.max(8, math.Round(size * scale)),
			weight = weight,
			antialias = true,
			extended = true,
		})
	end

	font("MGFXWheelTitle", "Bahnschrift", 23, 600)
	font("MGFXWheelHint", "Bahnschrift", 14, 600)
	font("MGFXWheelMonoSmall", "Consolas", 12, 400)
end

local function colorAlpha(color, alpha)
	return Color(color.r or 255, color.g or 255, color.b or 255, math.Clamp(math.Round(alpha or 255), 0, 255))
end

local function mixColor(a, b, t)
	t = math.Clamp(tonumber(t) or 0, 0, 1)
	return Color(
		Lerp(t, a.r or 0, b.r or 0),
		Lerp(t, a.g or 0, b.g or 0),
		Lerp(t, a.b or 0, b.b or 0),
		Lerp(t, a.a == nil and 255 or a.a, b.a == nil and 255 or b.a)
	)
end

local function easeOutCubic(t)
	t = math.Clamp(tonumber(t) or 0, 0, 1)
	local inv = 1 - t
	return 1 - inv * inv * inv
end

local function pulse01(t)
	t = math.Clamp(tonumber(t) or 1, 0, 1)
	return math_sin(t * math_pi) * (1 - t * 0.22)
end

local function quantizedOpacity(value)
	local step = math.Clamp(math_floor((tonumber(value) or 0) * LIGHT_ALPHA_STEPS + 0.5), 0, LIGHT_ALPHA_STEPS)
	return step / LIGHT_ALPHA_STEPS
end

local function pointerLightFill(nx, ny, radius, opacity)
	local o = quantizedOpacity(opacity)
	return MGFX.RadialGradient(nx, ny, radius, {
		{0.00, Color(255, 168, 110, math_floor(98 * o + 0.5))},
		{0.30, Color(255, 92, 42, math_floor(62 * o + 0.5))},
		{0.68, Color(255, 58, 24, math_floor(20 * o + 0.5))},
		{1.00, Color(255, 58, 24, 0)},
	})
end

-- UI damping uses real time so the wheel stays fluid even if the game pauses.
local function damp(current, target, speed)
	local amount = 1 - math_exp(-(speed or 12) * RealFrameTime())
	return Lerp(amount, current or target or 0, target or 0)
end

local function normalizeDeg(angle)
	angle = angle % 360
	if angle < 0 then angle = angle + 360 end
	return angle
end

local function angleDelta(fromDeg, toDeg)
	return ((toDeg - fromDeg + 180) % 360) - 180
end

local function dampAngle(current, target, speed)
	current = current or target or 0
	return current + angleDelta(current, target or 0) * (1 - math_exp(-(speed or 12) * RealFrameTime()))
end

local function anglePoint(cx, cy, radius, deg)
	local a = math_rad(deg)
	return cx + math_cos(a) * radius, cy + math_sin(a) * radius
end

local function segmentRange(index)
	local startDeg = WHEEL_START + (index - 1) * SEG_SPAN
	return startDeg, startDeg + SEG_SPAN
end

local function segmentMid(index)
	local startDeg, endDeg = segmentRange(index)
	return (startDeg + endDeg) * 0.5
end

local function segmentCenter(cx, cy, index, outset)
	return anglePoint(cx, cy, outset or 0, segmentMid(index))
end

local function indexFromAngle(deg)
	local relative = normalizeDeg(deg - WHEEL_START)
	return (math_floor(relative / SEG_SPAN) % #ACTIONS) + 1
end

-- Static fill values, built once and reused every frame.
local FILLS
local function ensureFills()
	if FILLS then return FILLS end
	FILLS = {
		hub = COLORS.hub,
	}
	return FILLS
end

local PREVIEW_MODEL_FALLBACK = "models/player/group01/male_07.mdl"
local ZERO_ANGLE = Angle(0, 0, 0)

local PREVIEW_POSES = {
	highfive = {
		["ValveBiped.Bip01_R_UpperArm"] = Angle(-78, -18, 58),
		["ValveBiped.Bip01_R_Forearm"] = Angle(-34, -4, 10),
		["ValveBiped.Bip01_R_Hand"] = Angle(4, 10, 4),
		["ValveBiped.Bip01_L_UpperArm"] = Angle(18, 10, -12),
	},
	crouch = {
		["ValveBiped.Bip01_R_UpperArm"] = Angle(-55, -8, 38),
		["ValveBiped.Bip01_R_Forearm"] = Angle(-24, 0, 6),
		["ValveBiped.Bip01_L_UpperArm"] = Angle(44, 8, -24),
		["ValveBiped.Bip01_L_Forearm"] = Angle(22, 0, -8),
		["ValveBiped.Bip01_R_Thigh"] = Angle(12, 0, 0),
		["ValveBiped.Bip01_L_Thigh"] = Angle(-12, 0, 0),
	},
	behind = {
		["ValveBiped.Bip01_R_UpperArm"] = Angle(58, -18, 30),
		["ValveBiped.Bip01_R_Forearm"] = Angle(56, 0, -8),
		["ValveBiped.Bip01_L_UpperArm"] = Angle(58, 18, -30),
		["ValveBiped.Bip01_L_Forearm"] = Angle(56, 0, 8),
	},
	handsup = {
		["ValveBiped.Bip01_R_UpperArm"] = Angle(-78, -18, 46),
		["ValveBiped.Bip01_R_Forearm"] = Angle(-48, -2, 8),
		["ValveBiped.Bip01_L_UpperArm"] = Angle(-78, 18, -46),
		["ValveBiped.Bip01_L_Forearm"] = Angle(-48, 2, -8),
	},
}

local function resetPreviewBones(ent)
	if not IsValid(ent) or not ent.ManipulateBoneAngles then return end
	for _, name in ipairs({
		"ValveBiped.Bip01_R_UpperArm",
		"ValveBiped.Bip01_R_Forearm",
		"ValveBiped.Bip01_R_Hand",
		"ValveBiped.Bip01_L_UpperArm",
		"ValveBiped.Bip01_L_Forearm",
		"ValveBiped.Bip01_L_Hand",
		"ValveBiped.Bip01_R_Thigh",
		"ValveBiped.Bip01_L_Thigh",
	}) do
		local bone = ent:LookupBone(name)
		if bone then ent:ManipulateBoneAngles(bone, ZERO_ANGLE) end
	end
end

local function applyPreviewPose(ent, pose)
	if not IsValid(ent) or not ent.ManipulateBoneAngles then return end
	resetPreviewBones(ent)
	local spec = PREVIEW_POSES[pose]
	if not spec then return end
	for boneName, ang in pairs(spec) do
		local bone = ent:LookupBone(boneName)
		if bone then ent:ManipulateBoneAngles(bone, ang) end
	end
end

local function poseLine(x1, y1, x2, y2, width, color, alpha)
	MGFX.LineEx(x1, y1, x2, y2, {
		width = width + 2,
		fill = Color(0, 0, 0, math_floor(alpha * 0.18)),
	})
	MGFX.LineEx(x1, y1, x2, y2, {
		width = width,
		fill = colorAlpha(color, alpha),
	})
end

local function drawPoseFigure(x, y, scale, pose, alpha, color)
	alpha = math.Clamp(alpha or 220, 0, 255)
	local col = color or Color(244, 246, 250)
	local width = math_max(2, scale * 0.12)
	local headR = scale * 0.16
	local headY = y - scale * 0.58
	local neckY = y - scale * 0.38
	local hipY = y + scale * 0.18
	local shoulderY = y - scale * 0.28
	local shoulderW = scale * 0.23
	local hipW = scale * 0.15

	MGFX.CircleEx(x, headY, headR + 1.5, {fill = Color(0, 0, 0, math_floor(alpha * 0.16))})
	MGFX.CircleEx(x, headY, headR, {fill = colorAlpha(col, alpha)})
	poseLine(x, neckY, x, hipY, width, col, alpha)

	if pose == "behind" then
		poseLine(x - shoulderW, shoulderY, x - scale * 0.2, headY + scale * 0.02, width, col, alpha)
		poseLine(x + shoulderW, shoulderY, x + scale * 0.2, headY + scale * 0.02, width, col, alpha)
		poseLine(x - scale * 0.2, headY + scale * 0.02, x - scale * 0.06, headY - scale * 0.11, width, col, alpha)
		poseLine(x + scale * 0.2, headY + scale * 0.02, x + scale * 0.06, headY - scale * 0.11, width, col, alpha)
		poseLine(x - hipW, hipY, x - scale * 0.23, y + scale * 0.66, width, col, alpha)
		poseLine(x + hipW, hipY, x + scale * 0.21, y + scale * 0.66, width, col, alpha)
	elseif pose == "crouch" then
		poseLine(x - shoulderW, shoulderY, x - scale * 0.45, y - scale * 0.03, width, col, alpha)
		poseLine(x + shoulderW, shoulderY, x + scale * 0.32, y - scale * 0.58, width, col, alpha)
		poseLine(x + scale * 0.32, y - scale * 0.58, x + scale * 0.31, y - scale * 0.78, width, col, alpha)
		poseLine(x - hipW, hipY, x - scale * 0.46, y + scale * 0.45, width, col, alpha)
		poseLine(x - scale * 0.46, y + scale * 0.45, x - scale * 0.16, y + scale * 0.58, width, col, alpha)
		poseLine(x + hipW, hipY, x + scale * 0.44, y + scale * 0.43, width, col, alpha)
		poseLine(x + scale * 0.44, y + scale * 0.43, x + scale * 0.16, y + scale * 0.58, width, col, alpha)
	elseif pose == "handsup" then
		poseLine(x - shoulderW, shoulderY, x - scale * 0.34, y - scale * 0.72, width, col, alpha)
		poseLine(x + shoulderW, shoulderY, x + scale * 0.34, y - scale * 0.72, width, col, alpha)
		poseLine(x - scale * 0.34, y - scale * 0.72, x - scale * 0.34, y - scale * 0.9, width, col, alpha)
		poseLine(x + scale * 0.34, y - scale * 0.72, x + scale * 0.34, y - scale * 0.9, width, col, alpha)
		poseLine(x - hipW, hipY, x - scale * 0.22, y + scale * 0.67, width, col, alpha)
		poseLine(x + hipW, hipY, x + scale * 0.24, y + scale * 0.67, width, col, alpha)
	elseif pose == "highfive" then
		poseLine(x - shoulderW, shoulderY, x - scale * 0.52, y - scale * 0.08, width, col, alpha)
		poseLine(x + shoulderW, shoulderY, x + scale * 0.38, y - scale * 0.7, width, col, alpha)
		poseLine(x + scale * 0.38, y - scale * 0.7, x + scale * 0.4, y - scale * 0.94, width, col, alpha)
		poseLine(x - hipW, hipY, x - scale * 0.22, y + scale * 0.66, width, col, alpha)
		poseLine(x + hipW, hipY, x + scale * 0.2, y + scale * 0.66, width, col, alpha)
	elseif pose == "point" then
		poseLine(x - shoulderW, shoulderY, x - scale * 0.3, y - scale * 0.02, width, col, alpha)
		poseLine(x + shoulderW, shoulderY, x + scale * 0.62, y - scale * 0.34, width, col, alpha)
		poseLine(x - hipW, hipY, x - scale * 0.22, y + scale * 0.66, width, col, alpha)
		poseLine(x + hipW, hipY, x + scale * 0.2, y + scale * 0.66, width, col, alpha)
	elseif pose == "salute" then
		poseLine(x - shoulderW, shoulderY, x - scale * 0.26, y + scale * 0.05, width, col, alpha)
		poseLine(x + shoulderW, shoulderY, x + scale * 0.42, y - scale * 0.5, width, col, alpha)
		poseLine(x + scale * 0.42, y - scale * 0.5, x + scale * 0.12, y - scale * 0.66, width, col, alpha)
		poseLine(x - hipW, hipY, x - scale * 0.16, y + scale * 0.66, width, col, alpha)
		poseLine(x + hipW, hipY, x + scale * 0.16, y + scale * 0.66, width, col, alpha)
	else -- wave
		poseLine(x - shoulderW, shoulderY, x - scale * 0.56, y - scale * 0.16, width, col, alpha)
		poseLine(x + shoulderW, shoulderY, x + scale * 0.36, y - scale * 0.68, width, col, alpha)
		poseLine(x + scale * 0.36, y - scale * 0.68, x + scale * 0.32, y - scale * 0.88, width, col, alpha)
		poseLine(x - hipW, hipY, x - scale * 0.23, y + scale * 0.66, width, col, alpha)
		poseLine(x + hipW, hipY, x + scale * 0.21, y + scale * 0.66, width, col, alpha)
	end
end

-- Small mouse glyph: rounded body, seam, and the active button filled.
local function drawMouseGlyph(x, y, side, alpha)
	local w, h = 11, 15
	MGFX.RoundedBoxEx(x, y, w, h, {
		radius = 5,
		fill = Color(255, 255, 255, math_floor(18 * alpha)),
		stroke = Color(255, 255, 255, math_floor(150 * alpha)),
		strokeWidth = 1,
	})
	MGFX.LineEx(x + w * 0.5, y + 1.5, x + w * 0.5, y + h * 0.42, {
		width = 1,
		fill = Color(255, 255, 255, math_floor(90 * alpha)),
	})
	local bw, bh = 3.6, 5
	local bx = side == "right" and (x + w * 0.5 + 0.6) or (x + w * 0.5 - 0.6 - bw)
	MGFX.RoundedBoxEx(bx, y + 1.6, bw, bh, {
		radius = 2,
		fill = Color(255, 255, 255, math_floor(215 * alpha)),
	})
end

local function drawGearGlyph(cx, cy, radius, alpha)
	alpha = alpha or 1
	MGFX.CircleEx(cx, cy, radius, {
		fill = Color(255, 255, 255, math_floor(208 * alpha)),
	})
	MGFX.CircleEx(cx, cy, radius * 0.42, {
		fill = Color(34, 36, 42, math_floor(230 * alpha)),
	})
	for i = 0, 7 do
		local deg = i * 45
		local x1, y1 = anglePoint(cx, cy, radius * 0.72, deg)
		local x2, y2 = anglePoint(cx, cy, radius * 1.18, deg)
		MGFX.LineEx(x1, y1, x2, y2, {
			width = 3,
			fill = Color(255, 255, 255, math_floor(208 * alpha)),
		})
	end
end

local function drawText(value, font, x, y, color, ax, ay, alphaMul)
	alphaMul = alphaMul or 1
	draw.SimpleText(value, font, x + 1, y + 1, colorAlpha(COLORS.shadow, (COLORS.shadow.a or 255) * 0.6 * alphaMul), ax or TEXT_ALIGN_LEFT, ay or TEXT_ALIGN_TOP)
	draw.SimpleText(value, font, x, y, colorAlpha(color, (color.a or 255) * alphaMul), ax or TEXT_ALIGN_LEFT, ay or TEXT_ALIGN_TOP)
end

local PANEL = {}

local POINTER_HOOK = "MGFXWheelDemoPointer"

function PANEL:Init()
	self:SetSize(ScrW(), ScrH())
	self:SetPos(0, 0)
	self:MakePopup()
	self:SetKeyboardInputEnabled(true)
	self:SetMouseInputEnabled(true)

	self.Created = RealTime()
	self.SelectedIndex = 1
	self.HoverIndex = nil
	self.SelectPulse = 0
	self.ClickPulse = 0
	self.ClickPulseIndex = nil
	self.MouseDown = false

	local w, h = self:GetSize()
	self.VirtualX = w * 0.5
	self.VirtualY = h * 0.5
	self.PointerSource = "idle"
	self.LastCursorAt = 0
	self.LastGuiX, self.LastGuiY = gui.MousePos()
	if input and input.GetCursorPos then
		self.LastInputX, self.LastInputY = input.GetCursorPos()
	end

	self.SmoothX = self.VirtualX
	self.SmoothY = self.VirtualY
	self.GlowAngle = segmentMid(self.SelectedIndex)
	self.DotAngle = segmentMid(self.SelectedIndex)
	self.LightIndex = self.SelectedIndex

	self.Anims = {}
	for i = 1, #ACTIONS do
		self.Anims[i] = {
			hover = 0,
			selected = i == self.SelectedIndex and 1 or 0,
			press = 0,
		}
	end

	self.ModelPanel = vgui.Create("DModelPanel", self)
	if IsValid(self.ModelPanel) then
		self.ModelPanel:SetVisible(false)
		self.ModelPanel:SetMouseInputEnabled(false)
		self.ModelPanel:SetKeyboardInputEnabled(false)
		self.ModelPanel:SetFOV(25)
		self.ModelPanel:SetCamPos(Vector(58, -138, 60))
		self.ModelPanel:SetLookAt(Vector(0, 0, 48))
		self.ModelPanel.LayoutEntity = function(panel, ent)
			if not IsValid(self) or not IsValid(ent) then return end
			local action = ACTIONS[self.HoverIndex or self.SelectedIndex] or ACTIONS[1]
			ent:SetAngles(Angle(0, 8 + math_sin(RealTime() * 0.55) * 1.5, 0))
			applyPreviewPose(ent, action.pose)
			if panel.RunAnimation then panel:RunAnimation() end
		end
	end

	local panel = self
	hook.Add("CreateMove", POINTER_HOOK, function(cmd)
		if not IsValid(panel) then
			hook.Remove("CreateMove", POINTER_HOOK)
			return
		end
		panel:ApplyAnalogDelta(cmd:GetMouseX(), cmd:GetMouseY())
	end)
end

function PANEL:OnRemove()
	hook.Remove("CreateMove", POINTER_HOOK)
	if MGFX._WheelDemoPanel == self then
		MGFX._WheelDemoPanel = nil
	end
end

function PANEL:UpdatePreviewModel(action)
	local panel = self.ModelPanel
	if not IsValid(panel) then return false end

	local model = PREVIEW_MODEL_FALLBACK
	local ply = LocalPlayer and LocalPlayer()
	if IsValid(ply) and isstring(ply:GetModel()) and ply:GetModel() ~= "" then
		model = ply:GetModel()
	end

	if self.PreviewModel ~= model then
		panel:SetModel(model)
		self.PreviewModel = model
		local ent = panel.Entity
		if IsValid(ent) then
			local seq = ent:LookupSequence("idle_all_01")
			if seq and seq >= 0 then
				ent:ResetSequence(seq)
				ent:SetCycle(0.18)
				ent:SetPlaybackRate(0)
			end
			if IsValid(ply) then
				ent:SetSkin(ply:GetSkin() or 0)
				for i = 0, math_min((ply:GetNumBodyGroups() or 0) - 1, 8) do
					ent:SetBodygroup(i, ply:GetBodygroup(i) or 0)
				end
			end
		end
	end

	local ent = panel.Entity
	if IsValid(ent) and action then
		applyPreviewPose(ent, action.pose)
	end
	return IsValid(ent)
end

function PANEL:LayoutPreview(w, h, action)
	local panel = self.ModelPanel
	if not IsValid(panel) then
		self.PreviewVisible = false
		return false
	end

	local cx, _, outerR = self:WheelMetrics(w, h)
	local available = cx - outerR - 64
	local visible = w >= 1100 and h >= 620 and available > 360
	panel:SetVisible(visible)
	self.PreviewVisible = visible
	if not visible then return false end

	local panelW = math.Clamp(available + w * 0.07, 420, w * 0.58)
	panel:SetPos(math_floor(-w * 0.035), math_floor(-h * 0.02))
	panel:SetSize(math_floor(panelW), math_floor(h * 1.08))
	panel:SetFOV(math.Clamp(27 - (h - 720) * 0.006, 20, 27))
	panel:SetCamPos(Vector(56, -136, 60))
	panel:SetLookAt(Vector(0, 0, 48))
	local ok = self:UpdatePreviewModel(action)
	panel:SetVisible(ok)
	self.PreviewVisible = ok
	return ok
end

function PANEL:AdoptPointer(x, y, source)
	x, y = tonumber(x), tonumber(y)
	if not x or not y then return end
	local w, h = self:GetWide(), self:GetTall()
	self.VirtualX = math.Clamp(x, 0, w)
	self.VirtualY = math.Clamp(y, 0, h)
	self.PointerSource = source
	self.LastCursorAt = RealTime()
end

function PANEL:OnCursorMoved(x, y)
	self:AdoptPointer(x, y, "event")
end

function PANEL:PollCursorSources()
	local px, py = self:GetPos()

	local gx, gy = gui.MousePos()
	if gx ~= self.LastGuiX or gy ~= self.LastGuiY then
		self.LastGuiX, self.LastGuiY = gx, gy
		self:AdoptPointer(gx - px, gy - py, "cursor")
	end

	if input and input.GetCursorPos then
		local ix, iy = input.GetCursorPos()
		if ix ~= self.LastInputX or iy ~= self.LastInputY then
			self.LastInputX, self.LastInputY = ix, iy
			self:AdoptPointer(ix - px, iy - py, "input")
		end
	end
end

-- Raw mouse deltas keep the wheel alive when no cursor source is updating
-- (engine kept the mouse captured). Harmless otherwise: a working popup eats
-- the deltas, so cmd:GetMouseX/Y are zero.
function PANEL:ApplyAnalogDelta(dx, dy)
	dx, dy = tonumber(dx) or 0, tonumber(dy) or 0
	if dx == 0 and dy == 0 then return end
	if vgui.CursorVisible() and RealTime() - (self.LastCursorAt or 0) < 0.25 then return end

	local w, h = self:GetWide(), self:GetTall()
	local cx, cy, outerR = self:WheelMetrics(w, h)
	local nx = (self.VirtualX or cx) + dx * 0.9
	local ny = (self.VirtualY or cy) + dy * 0.9

	local ddx, ddy = nx - cx, ny - cy
	local dist = math_sqrt(ddx * ddx + ddy * ddy)
	local maxR = outerR * 1.25
	if dist > maxR then
		nx = cx + ddx / dist * maxR
		ny = cy + ddy / dist * maxR
	end

	self.VirtualX = math.Clamp(nx, 0, w)
	self.VirtualY = math.Clamp(ny, 0, h)
	self.PointerSource = "analog"
end

function PANEL:WheelMetrics(w, h)
	local outerR = math.Clamp(math_min(w, h) * 0.295, 210, 330)
	local innerR = outerR * 0.525
	local hubGap = math.Clamp(outerR * HUB_GAP_RATIO, HUB_GAP_MIN, HUB_GAP_MAX)
	local hubR = innerR - hubGap
	local cx = w >= 1100 and w * 0.79 or w * 0.5
	local cy = h * 0.51
	return cx, cy, outerR, innerR, hubR
end

function PANEL:HitIndex(mx, my)
	local w, h = self:GetWide(), self:GetTall()
	local cx, cy, _, innerR = self:WheelMetrics(w, h)
	local dx, dy = mx - cx, my - cy
	local dist = math_sqrt(dx * dx + dy * dy)
	if dist < innerR * 0.96 then return nil end
	local deg = math_deg(atan2(dy, dx))
	return indexFromAngle(deg)
end

function PANEL:Think()
	local sw, sh = ScrW(), ScrH()
	if self:GetWide() ~= sw or self:GetTall() ~= sh then
		self:SetSize(sw, sh)
		self:SetPos(0, 0)
	end

	-- Reclaim the popup if something stole focus and the engine re-captured
	-- the mouse (console close, other addons toggling input states).
	if not vgui.CursorVisible() and not gui.IsGameUIVisible() then
		self:MakePopup()
	end

	self:PollCursorSources()
end

function PANEL:OnMousePressed(code)
	if code == MOUSE_RIGHT then
		self:Remove()
		return
	end
	if code ~= MOUSE_LEFT then return end

	self.MouseDown = true
	local hit = self:HitIndex(self.VirtualX or 0, self.VirtualY or 0)
	if hit then
		self.SelectedIndex = hit
		self.SelectPulse = RealTime()
		self.ClickPulse = RealTime()
		self.ClickPulseIndex = hit
	end
end

function PANEL:OnMouseReleased(code)
	if code == MOUSE_LEFT then
		self.MouseDown = false
	end
end

function PANEL:OnMouseWheeled(delta)
	local count = #ACTIONS
	self.SelectedIndex = ((self.SelectedIndex - 1 - delta) % count) + 1
	self.SelectPulse = RealTime()
	return true
end

function PANEL:OnKeyCodePressed(code)
	if code == KEY_ESCAPE or code == KEY_BACKSPACE then
		self:Remove()
		return
	end
	local slot = code - KEY_0
	if slot >= 1 and slot <= #ACTIONS then
		self.SelectedIndex = slot
		self.SelectPulse = RealTime()
	end
end

function PANEL:Paint(w, h)
	ensureFonts(math_min(w / 1280, h / 900))
	self:PollCursorSources()

	local now = RealTime()
	local intro = easeOutCubic((now - (self.Created or now)) / 0.18)

	local cx, cy, outerR, innerR, hubR = self:WheelMetrics(w, h)
	local k = 0.95 + 0.05 * intro
	outerR, innerR, hubR = outerR * k, innerR * k, hubR * k
	local segOutset = math.Clamp(outerR * SEG_OUTSET_RATIO, SEG_OUTSET_MIN, SEG_OUTSET_MAX) * intro

	local mx = math.Clamp(self.VirtualX or cx, 0, w)
	local my = math.Clamp(self.VirtualY or cy, 0, h)
	self.SmoothX = damp(self.SmoothX or mx, mx, 26)
	self.SmoothY = damp(self.SmoothY or my, my, 26)

	local dx, dy = mx - cx, my - cy
	local pointerDist = math_sqrt(dx * dx + dy * dy)
	local pointerAngle = pointerDist > 0.5 and normalizeDeg(math_deg(atan2(dy, dx))) or segmentMid(self.SelectedIndex)

	local hoverIndex = self:HitIndex(mx, my)
	self.HoverIndex = hoverIndex
	if hoverIndex then
		self.LightIndex = hoverIndex
	end
	local activeIndex = hoverIndex or self.SelectedIndex
	local activeAction = ACTIONS[activeIndex] or ACTIONS[1]
	self:LayoutPreview(w, h, activeAction)

	for i = 1, #ACTIONS do
		local anim = self.Anims[i]
		local hovered = i == hoverIndex
		anim.hover = damp(anim.hover, hovered and 1 or 0, hovered and 22 or 13)
		anim.selected = damp(anim.selected, i == self.SelectedIndex and 1 or 0, 10)
		anim.press = damp(anim.press, (self.MouseDown and hovered) and 1 or 0, 26)
	end

	local pulseT = math.Clamp((now - (self.SelectPulse or 0)) / 0.4, 0, 1)
	local flash = 1 - easeOutCubic(pulseT)
	local clickT = math.Clamp((now - (self.ClickPulse or 0)) / 0.36, 0, 1)
	local clickPulse = pulse01(clickT)

	local wheelPad = segOutset + math.Clamp(outerR * 0.06, 10, 22)
	local wheelX = cx - outerR - wheelPad
	local wheelY = cy - outerR - wheelPad
	local wheelSize = outerR * 2 + wheelPad * 2
	local tiltStrength = intro * math.Clamp(pointerDist / math_max(outerR * 0.65, 1), 0, 1) * 0.82
	local wheelTransform = MGFX.PointerTilt and MGFX.PointerTilt(mx, my, {
		origin = "50% 50%",
		perspective = math_max(760, outerR * 4.8),
		maxRotateX = 3.2,
		maxRotateY = 4.8,
		strength = tiltStrength,
		scale = 1 + tiltStrength * 0.008,
		steps = 12,
	}) or nil
	local localMx, localMy = mx, my
	if wheelTransform and MGFX.UntransformPoint then
		localMx, localMy = MGFX.UntransformPoint(mx, my, wheelTransform, wheelX, wheelY, wheelSize, wheelSize)
	end
	local localDx, localDy = localMx - cx, localMy - cy
	local localPointerDist = math_sqrt(localDx * localDx + localDy * localDy)
	local localPointerAngle = localPointerDist > 0.5 and normalizeDeg(math_deg(atan2(localDy, localDx))) or pointerAngle

	-- The ember glow eases toward the pointer, while the selected dot keeps
	-- its own wedge-centered animation.
	local glowTarget = hoverIndex and localPointerAngle or self.GlowAngle or segmentMid(self.SelectedIndex)
	self.GlowAngle = dampAngle(self.GlowAngle, glowTarget, 16)
	self.DotAngle = dampAngle(self.DotAngle, segmentMid(self.SelectedIndex), 14)

	-- Hint row layout is measured up front; glyphs draw in-frame, labels after.
	local hintY = cy + hubR * 0.52
	surface.SetFont("MGFXWheelHint")
	local selectW = surface.GetTextSize("Select")
	local backW = surface.GetTextSize("Back")
	local glyphW, gapIcon, gapItem = 11, 6, 20
	local totalW = glyphW + gapIcon + selectW + gapItem + glyphW + gapIcon + backW
	local rowX = cx - totalW * 0.5

	if MGFX and MGFX.StartPanel then
		surface.SetAlphaMultiplier(intro)
		MGFX.StartPanel(self, w, h)
		local fills = ensureFills()

		MGFX.ArcEx(cx + outerR * 0.58, cy - outerR * 0.02, outerR * 1.62, 1, -158, 100, {
			fill = Color(255, 255, 255, 14),
		})
		MGFX.ArcEx(cx + outerR * 0.72, cy - outerR * 0.02, outerR * 1.86, 1, -156, 92, {
			fill = Color(255, 255, 255, 8),
		})
		MGFX.ArcEx(cx + outerR * 0.64, cy - outerR * 0.04, outerR * 1.36, 1, -148, 70, {
			fill = Color(255, 255, 255, 7),
		})
		MGFX.RoundedBoxEx(w - 104, 52, 64, 64, {
			radius = 4,
			fill = Color(58, 63, 70, 42),
			stroke = Color(255, 255, 255, 9),
			strokeWidth = 1,
		})
		drawGearGlyph(w - 72, 84, 9, 0.82)

		local pushedTransform = wheelTransform and MGFX.PushTransform and MGFX.PushTransform(wheelTransform, wheelX, wheelY, wheelSize, wheelSize)

		-- Wedges: charcoal glass with a static ring-local depth gradient on
		-- top. The hovered wedge turns deep red and carries the ember glows;
		-- the pointer light is drawn later as a sector-clipped overlay.
		local hoverAnim = 0
		for i = 1, #ACTIONS do
			hoverAnim = math_max(hoverAnim, easeOutCubic(self.Anims[i].hover))
		end
		local drawSegment = function(i)
			local anim = self.Anims[i]
			local hover = easeOutCubic(anim.hover)
			local selected = anim.selected
			local press = easeOutCubic(anim.press)

			local startDeg, endDeg = segmentRange(i)
			local segCx, segCy = segmentCenter(cx, cy, i, segOutset)

			local fill = mixColor(COLORS.wedge, COLORS.wedgeSel, selected * 0.62)
			fill = mixColor(fill, COLORS.wedgeHot, hover)
			fill = mixColor(fill, Color(150, 44, 14, 160), hover * press * 0.42)
			fill = mixColor(fill, COLORS.wedgePress, press * 0.42)
			if flash > 0 and i == self.SelectedIndex then
				fill = mixColor(fill, Color(140, 38, 14, 164), flash * 0.55)
			end

			MGFX.SectorEx(segCx, segCy, innerR, outerR, startDeg, endDeg, {
				fill = fill,
				innerGlow = hover > 0.02 and {
					color = COLORS.emberHot,
					size = (outerR - innerR) * 0.55,
					opacity = 0.2 * hover,
					softness = 0.82,
				} or nil,
				outerGlow = hover > 0.02 and {
					color = COLORS.ember,
					size = 18,
					opacity = 0.1 * hover,
					softness = 0.82,
				} or nil,
				stroke = Color(255, 255, 255, 35),
				strokeWidth = 1.5,
				backdrop = true
			})
		end

		for i = 1, #ACTIONS do
			if i ~= hoverIndex then drawSegment(i) end
		end
		if hoverIndex then drawSegment(hoverIndex) end

		-- Ember light follows the cursor in screen space; the sector only clips
		-- what remains visible, so the center may move beyond the wedge bounds.
		local lightIndex = self.LightIndex
		local lightAnim = lightIndex and easeOutCubic(self.Anims[lightIndex].hover) or 0
		if lightIndex and lightAnim > 0.05 then
			local startDeg, endDeg = segmentRange(lightIndex)
			local segCx, segCy = segmentCenter(cx, cy, lightIndex, segOutset)
			local nx = 0.5 + (localMx - segCx) / (outerR * 2)
			local ny = 0.5 + (localMy - segCy) / (outerR * 2)
			local radialR = math.Clamp((outerR - innerR) * 0.86 / (outerR * 2), 0.12, 0.28)
			MGFX.SectorEx(segCx, segCy, innerR, outerR, startDeg, endDeg, {
				fill = pointerLightFill(nx, ny, radialR, lightAnim),
			})
		end

		-- Hub glass is intentionally smaller than the wedge inner radius, so
		-- the live scene remains visible as a clean gap between hub and wedges.
		MGFX.CircleEx(cx, cy, hubR, {
			fill = fills.hub,
			stroke = Color(255, 255, 255, 35),
			strokeWidth = 1.5,
			backdrop = true
		})
		if hoverIndex and hoverAnim > 0.03 then
			local hubGlowRadius = math.Clamp(localPointerDist * 0.2, hubR * 0.18, hubR * 0.5)
			local hx, hy = anglePoint(cx, cy, hubGlowRadius, self.GlowAngle or pointerAngle)
			MGFX.CircleEx(hx, hy, 2.4 + hoverAnim * 2, {
				fill = colorAlpha(COLORS.emberHot, 18 * hoverAnim),
				outerGlow = {
					color = colorAlpha(COLORS.emberHot, 118),
					size = hubR * 0.5,
					spread = hubR * 0.5,
					opacity = 0.22 * hoverAnim,
					softness = 0.91,
				},
			})
		end

		-- Accent line hugging the hub along the hovered wedge span.
		local accentIndex = hoverIndex or (clickPulse > 0.01 and self.ClickPulseIndex) or nil
		local accentAnim = accentIndex and math_max(easeOutCubic(self.Anims[accentIndex].hover), clickPulse) or 0
		if accentIndex and accentAnim > 0.01 then
			local startDeg, endDeg = segmentRange(accentIndex)
			local segCx, segCy = segmentCenter(cx, cy, accentIndex, segOutset)
			local arcPulse = self.ClickPulseIndex == accentIndex and clickPulse or 0
			local arcOffset = arcPulse * math.Clamp((outerR - innerR) * 0.09, 4, 9)
			MGFX.SectorEx(segCx, segCy, innerR + 1.4 + arcOffset, innerR + 4.5 + arcOffset, startDeg, endDeg, {
				fill = colorAlpha(COLORS.accent, 220 * accentAnim),
				outerGlow = {
					color = COLORS.accent,
					size = 8 + 5 * arcPulse,
					opacity = (0.42 + 0.25 * arcPulse) * accentAnim,
					softness = 0.66 + 0.08 * arcPulse,
				},
			})
		end

		if flash > 0.02 then
			local dotR = 2.8 + flash * 2.2
			local dotCx, dotCy = segmentCenter(cx, cy, self.SelectedIndex, segOutset)
			local sx, sy = anglePoint(dotCx, dotCy, innerR + 9, self.DotAngle)
			MGFX.CircleEx(sx, sy, dotR, {
				fill = colorAlpha(COLORS.accent, 210 + 40 * flash),
				outerGlow = {
					color = COLORS.accent,
					size = 6 + 12 * flash,
					opacity = 0.36 + 0.48 * flash,
					softness = 0.6,
				},
			})
		end

		-- Hub furniture: divider plus the Select / Back mouse glyphs.
		MGFX.LineEx(cx - hubR * 0.42, cy + hubR * 0.38, cx + hubR * 0.42, cy + hubR * 0.38, {
			width = 1,
			fill = Color(255, 255, 255, 24),
		})
		drawMouseGlyph(rowX, hintY - 7.5, "left", 1)
		drawMouseGlyph(rowX + glyphW + gapIcon + selectW + gapItem, hintY - 7.5, "right", 1)

		-- Icons.
		local iconR = (outerR + innerR) * 0.5
		local iconScale = outerR * 0.16
		for i, action in ipairs(ACTIONS) do
			local anim = self.Anims[i]
			local hover = easeOutCubic(anim.hover)
			local mid = segmentMid(i)
			local segCx, segCy = segmentCenter(cx, cy, i, segOutset)
			local ix, iy = anglePoint(segCx, segCy, iconR, mid)
			local alpha = Lerp(hover, 212, 255)
			drawPoseFigure(ix, iy + iconScale * 0.12, iconScale * (1 + hover * 0.04), action.pose, alpha)
		end

		if pushedTransform then
			MGFX.PopTransform()
		end

		-- Virtual-pointer cursor: only when the OS cursor is not visible.
		if self.PointerSource == "analog" and not vgui.CursorVisible() then
			MGFX.RingEx(self.SmoothX, self.SmoothY, 7, 1.5, {
				fill = Color(255, 255, 255, 170),
			})
			MGFX.CircleEx(self.SmoothX, self.SmoothY, 1.6, {fill = Color(255, 255, 255, 200)})
		end

		MGFX.EndPanel()
		surface.SetAlphaMultiplier(1)
	else
		draw.RoundedBox(0, 0, 0, w, h, COLORS.bg)
	end

	-- Hub copy: the action name above center, hint labels beside the glyphs.
	local action = ACTIONS[activeIndex] or ACTIONS[1]
	drawText(action.title, "MGFXWheelTitle", cx, cy - hubR * 0.28, COLORS.ink, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, intro)
	drawText("Select", "MGFXWheelHint", rowX + glyphW + gapIcon, hintY, COLORS.ink, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, intro)
	drawText("Back", "MGFXWheelHint", rowX + glyphW + gapIcon + selectW + gapItem + glyphW + gapIcon, hintY, COLORS.ink, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, intro)

	-- Pointer telemetry, opt-in: mgfx_wheel_debug 1
	if debugCvar:GetBool() then
		drawText(string.format("PTR %4d %4d   ANG %5.1f   SRC %s", mx, my, pointerAngle, self.PointerSource or "idle"), "MGFXWheelMonoSmall", 24, h - 46, COLORS.muted, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, intro)
		drawText("HOVER " .. (hoverIndex and ACTIONS[hoverIndex].title or "-") .. "   PICK " .. ACTIONS[self.SelectedIndex].title, "MGFXWheelMonoSmall", 24, h - 30, COLORS.muted, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, intro)
	end
end

vgui.Register("MGFXWheelDemoPanel", PANEL, "EditablePanel")

local function openDemo()
	if IsValid(WheelPanel) then WheelPanel:Remove() end
	if IsValid(MGFX._WheelDemoPanel) then MGFX._WheelDemoPanel:Remove() end
	WheelPanel = vgui.Create("MGFXWheelDemoPanel")
	MGFX._WheelDemoPanel = WheelPanel
	return WheelPanel
end

local function closeDemo()
	if IsValid(WheelPanel) then WheelPanel:Remove() end
	if IsValid(MGFX._WheelDemoPanel) then MGFX._WheelDemoPanel:Remove() end
end

addCommand("mgfx_wheel_demo", function(_, _, args)
	local mode = args and args[1] or ""
	if mode == "0" or mode == "close" then
		closeDemo()
		return
	end
	if mode == "toggle" and IsValid(WheelPanel) then
		closeDemo()
		return
	end
	openDemo()
end)

addCommand("mgfx_wheel_demo_close", closeDemo)
addCommand("mgfx_emote_wheel_demo", openDemo)
