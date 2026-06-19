if SERVER then return end

local DemoPanel
local currentFontScale = -1
local currentTextFontScale = -1
local iconMaterial
local maskMaterial
local innerGlowCvar = CreateClientConVar("mgfx_demo_innerglow", "1", true, false)
local outerGlowCvar = CreateClientConVar("mgfx_demo_outerglow", "1", true, false)
local addCommand = MGFX._AddCommand or concommand.Add

local COLORS = {
	ink = Color(232, 244, 248),
	muted = Color(138, 162, 170),
	cyan = Color(64, 196, 236),
	blue = Color(35, 126, 255),
	green = Color(68, 232, 146),
	gold = Color(255, 190, 66),
	red = Color(255, 88, 78),
	panel = Color(5, 18, 26, 185),
	track = Color(10, 18, 24, 190),
}

local CJK_FACE = "Noto Sans SC"

local function ensureFonts(scale)
	scale = math.Round(scale * 100) / 100

	if currentFontScale ~= scale then
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

		font("MGFXDemoTitle", "Bahnschrift", 30, 900)
		font("MGFXDemoSub", CJK_FACE, 12, 400)
		font("MGFXDemoLabel", CJK_FACE, 14, 400)
		font("MGFXDemoMetric", "Bahnschrift", 28, 900)
		font("MGFXDemoTiny", "Tahoma", 11, 500)
		font("MGFXDemoTextTitle", "Bahnschrift", 32, 700)
		font("MGFXDemoTextBody", CJK_FACE, 20, 400)
		font("MGFXDemoTextSmall", CJK_FACE, 14, 400)
		font("MGFXDemoTextNum", "Bahnschrift", 34, 780)
	end

	if MGFX and MGFX.RegisterTextFont and currentTextFontScale ~= scale then
		currentTextFontScale = scale

		local function textFont(name, face, size, weight, lineHeight)
			return MGFX.RegisterTextFont(name, {
				face = face,
				size = math.max(8, math.Round(size * scale)),
				weight = weight,
				lineHeight = math.max(8, math.Round(lineHeight * scale)),
			})
		end

		textFont("MGFXDemoTextTitle", "Bahnschrift", 32, 700, 38)
		textFont("MGFXDemoTextBody", CJK_FACE, 20, 400, 27)
		textFont("MGFXDemoTextSmall", CJK_FACE, 14, 400, 20)
		textFont("MGFXDemoTextNum", "Bahnschrift", 34, 780, 40)
	end
end

local function text(value, font, x, y, color, ax, ay)
	draw.SimpleText(value, font, x, y, Color(0, 0, 0, math.min((color.a or 255), 180)), ax or TEXT_ALIGN_LEFT, ay or TEXT_ALIGN_TOP)
	draw.SimpleText(value, font, x, y - 1, color, ax or TEXT_ALIGN_LEFT, ay or TEXT_ALIGN_TOP)
end

local function demoIcon()
	if iconMaterial ~= nil then return iconMaterial end

	iconMaterial = Material("color/white", "smooth noclamp")
	if iconMaterial and not iconMaterial:IsError() then return iconMaterial end

	for _, path in ipairs({
		"icon16/user.png",
		"icon16/star.png",
		"gui/silkicons/user",
	}) do
		local mat = Material(path, "smooth noclamp")
		if mat and not mat:IsError() then
			iconMaterial = mat
			return iconMaterial
		end
	end

	iconMaterial = false
	return iconMaterial
end

local function demoMask()
	if maskMaterial ~= nil then return maskMaterial end

	for _, path in ipairs({
		"vgui/gradient-r",
		"vgui/gradient-u",
		"gui/center_gradient",
		"effects/flashlight001",
		"color/white",
	}) do
		local mat = Material(path, "smooth noclamp")
		if mat and not mat:IsError() then
			maskMaterial = mat
			return maskMaterial
		end
	end

	maskMaterial = false
	return maskMaterial
end

local function waveValue(offset, speed)
	return 0.5 + math.sin(RealTime() * (speed or 1) + (offset or 0)) * 0.5
end

local function mixColor(a, b, t)
	t = math.Clamp(tonumber(t) or 0, 0, 1)
	a = a or color_white
	b = b or a
	return Color(
		Lerp(t, a.r or 0, b.r or 0),
		Lerp(t, a.g or 0, b.g or 0),
		Lerp(t, a.b or 0, b.b or 0),
		Lerp(t, a.a == nil and 255 or a.a, b.a == nil and 255 or b.a)
	)
end

local function approachWeight(current, target, speed)
	return math.Approach(tonumber(current) or 0, tonumber(target) or 0, FrameTime() * (speed or 8))
end

local function updateRuntimeWeight(weights, key, active, speed)
	weights[key] = approachWeight(weights[key] or 0, active and 1 or 0, speed)
	return weights[key]
end

local BUTTON = {}

function BUTTON:Paint(w, h)
	local active = self.Active and self:Active() or false
	local fill = active and Color(28, 86, 110, 210) or Color(5, 22, 30, self.Hovered and 230 or 190)
	local stroke = active and Color(90, 220, 255, 92) or Color(255, 255, 255, self.Hovered and 38 or 18)

	if MGFX and MGFX.RoundedBoxEx then
		MGFX.RoundedBoxEx(0, 0, w, h, {
			radius = 4,
			fill = fill,
			stroke = stroke,
			strokeWidth = 1,
		})
	else
		draw.RoundedBox(4, 0, 0, w, h, fill)
	end

	text(self:GetText(), "MGFXDemoTiny", w * 0.5, h * 0.5, self.Hovered and COLORS.ink or COLORS.muted, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	return true
end

vgui.Register("MGFXDemoButton", BUTTON, "DButton")

local PANEL = {}

function PANEL:Init()
	self:SetSize(math.min(ScrW() * 0.9, 1160), math.min(ScrH() * 0.82, 720))
	self:Center()
	self:MakePopup()
	self:SetKeyboardInputEnabled(false)
	self:SetMouseInputEnabled(true)

	self.Created = RealTime()
	self.RuntimeWeights = {}
	for i = 1, 4 do
		self.RuntimeWeights[i] = {hover = 0, selected = i == 2 and 1 or 0, pressed = 0, disabled = 0}
	end
	self.RuntimeProgressWeights = {hover = 0, selected = 0, pressed = 0, disabled = 0}
	self.RuntimeRingWeights = {hover = 0, selected = 0, pressed = 0, disabled = 0}
	self.RuntimeSelected = 2
	self.RuntimeDisabled = false
	self.RuntimePulseUntil = 0
	self.RuntimePulseStart = 0
	self.RuntimePulseDuration = 1.15
	self.RuntimeActionMessage = "ready"
	self.RuntimeActionUntil = 0
	self.RuntimeActionId = ""
	self.RuntimeMouseDown = false
	self.ShowGradientShowcase = true

	self.CloseButton = vgui.Create("MGFXDemoButton", self)
	self.CloseButton:SetText("CLOSE")
	self.CloseButton.DoClick = function()
		self:Remove()
	end

	self.FallbackButton = vgui.Create("MGFXDemoButton", self)
	self.FallbackButton:SetText("FALLBACK")
	self.FallbackButton.Active = function()
		local cvar = GetConVar("mgfx_force_fallback")
		return cvar and cvar:GetBool()
	end
	self.FallbackButton.DoClick = function()
		local cvar = GetConVar("mgfx_force_fallback")
		RunConsoleCommand("mgfx_force_fallback", cvar and cvar:GetBool() and "0" or "1")
	end

	self.GlowButton = vgui.Create("MGFXDemoButton", self)
	self.GlowButton:SetText("GLOW")
	self.GlowButton.Active = function()
		return innerGlowCvar and innerGlowCvar:GetBool()
	end
	self.GlowButton.DoClick = function()
		RunConsoleCommand("mgfx_demo_innerglow", innerGlowCvar and innerGlowCvar:GetBool() and "0" or "1")
	end

	self.OuterGlowButton = vgui.Create("MGFXDemoButton", self)
	self.OuterGlowButton:SetText("OUTER")
	self.OuterGlowButton.Active = function()
		return outerGlowCvar and outerGlowCvar:GetBool()
	end
	self.OuterGlowButton.DoClick = function()
		RunConsoleCommand("mgfx_demo_outerglow", outerGlowCvar and outerGlowCvar:GetBool() and "0" or "1")
	end

	self.ViewButton = vgui.Create("MGFXDemoButton", self)
	self.ViewButton:SetText("MATRIX")
	self.ViewButton.Active = function()
		return self.ShowGradientShowcase
	end
	self.ViewButton.DoClick = function()
		self.ShowGradientShowcase = not self.ShowGradientShowcase
		self.ViewButton:SetText(self.ShowGradientShowcase and "MATRIX" or "GRADIENTS")
	end

end

function PANEL:PerformLayout(w, h)
	self.CloseButton:SetSize(72, 24)
	self.CloseButton:SetPos(w - 92, 18)

	self.FallbackButton:SetSize(92, 24)
	self.FallbackButton:SetPos(w - 194, 18)

	self.GlowButton:SetSize(72, 24)
	self.GlowButton:SetPos(w - 276, 18)

	self.OuterGlowButton:SetSize(72, 24)
	self.OuterGlowButton:SetPos(w - 358, 18)

	self.ViewButton:SetSize(96, 24)
	self.ViewButton:SetPos(w - 464, 18)
end

function PANEL:Paint(w, h)
	local scale = math.min(w / 980, h / 620)
	ensureFonts(scale)

	local shaderStatus = MGFX and MGFX.shaderStatus and MGFX.shaderStatus() or {}
	local loaded = shaderStatus.loaded
	local fallback = GetConVar("mgfx_force_fallback") and GetConVar("mgfx_force_fallback"):GetBool()
	local showInnerGlow = innerGlowCvar and innerGlowCvar:GetBool()
	local showOuterGlow = outerGlowCvar and outerGlowCvar:GetBool()
	local left = 28
	local top = 24
	local headerH = 96
	local gap = 12
	local gridX = left
	local gridY = headerH + 20
	local gridW = w - left * 2
	local gridH = h - gridY - 30
	local cardW = (gridW - gap * 3) / 4
	local cardH = (gridH - gap * 2) / 3
	local mat = demoIcon()
	local maskMat = demoMask()
	local labels = {}
	local runtimeHitboxes = {}
	local runtimeActionHitboxes = {}

	local function addText(value, font, x, y, color, ax, ay)
		labels[#labels + 1] = {value, font, x, y, color, ax, ay}
	end

	local function card(index, title, subtitle, accent)
		local col = (index - 1) % 4
		local row = math.floor((index - 1) / 4)
		local x = gridX + col * (cardW + gap)
		local y = gridY + row * (cardH + gap)

		MGFX.RoundedBoxEx(x, y, cardW, cardH, {
			radius = 8,
			fill = Color(10, 15, 18, 188),
			stroke = Color(accent.r, accent.g, accent.b, 58),
			strokeWidth = "hairline",
		})
		MGFX.LineEx(x + 14, y + 34, x + cardW - 14, y + 34, {
			width = "hairline",
			fill = MGFX.LinearGradient(0, 0, 1, 0, Color(accent.r, accent.g, accent.b, 0), Color(accent.r, accent.g, accent.b, 92)),
		})

		addText(title, "MGFXDemoLabel", x + 14, y + 12, COLORS.ink)
		if subtitle and subtitle ~= "" then
			addText(subtitle, "MGFXDemoTiny", x + 14, y + cardH - 22, COLORS.muted)
		end
		return x, y, cardW, cardH, accent
	end

	local function drawGradientShowcase()
		self.RuntimeHitboxes = {}
		self.RuntimeActionHitboxes = {}

		local px, py, pw, ph = gridX, gridY, gridW, gridH
		local spectrumStops = {
			{0.00, Color(64, 196, 236, 240)},
			{0.22, Color(68, 232, 146, 235)},
			{0.46, Color(255, 218, 92, 238)},
			{0.68, Color(255, 96, 78, 238)},
			{1.00, Color(134, 92, 255, 235)},
		}
		local radialStops = {
			{0.00, Color(248, 252, 255, 245)},
			{0.28, Color(94, 218, 255, 225)},
			{0.62, Color(32, 88, 192, 178)},
			{1.00, Color(4, 12, 20, 40)},
		}
		local warmStops = {
			{0.00, Color(255, 236, 146, 240)},
			{0.34, Color(255, 160, 78, 235)},
			{0.70, Color(255, 82, 96, 232)},
			{1.00, Color(108, 64, 210, 220)},
		}
		local deepStops = {
			{0.00, Color(6, 18, 26, 236)},
			{0.40, Color(24, 92, 138, 224)},
			{0.72, Color(66, 214, 180, 218)},
			{1.00, Color(255, 210, 110, 230)},
		}
		local linearStops = MGFX.LinearGradientStops or MGFX.LinearGradient

		local function stopRail(x, y, ww, stops)
			MGFX.RoundedBoxEx(x, y, ww, 9, {
				radius = 4,
				fill = linearStops(0, 0, 1, 0, stops),
				stroke = Color(255, 255, 255, 30),
				strokeWidth = "hairline",
			})
			for _, stop in ipairs(stops) do
				local sx = x + ww * (stop[1] or stop.pos or 0)
				MGFX.LineEx(sx, y - 3, sx, y + 12, {
					width = "hairline",
					fill = Color(255, 255, 255, 118),
				})
			end
		end

		MGFX.RoundedBoxEx(px, py, pw, ph, {
			radius = 10,
			fill = Color(3, 9, 13, 122),
			stroke = Color(80, 210, 255, 22),
			strokeWidth = "hairline",
		})

		local headY = py + 10
		addText("Gradient Stops Showcase", "MGFXDemoTitle", px + 18, headY, COLORS.ink)
		addText("shared stop LUT across primitive, shape-local, and text surfaces", "MGFXDemoTiny", px + 20, headY + 34, COLORS.muted)
		local headerRailW = math.min(320, math.max(220, pw * 0.28))
		stopRail(px + pw - 18 - headerRailW, headY + 18, headerRailW, spectrumStops)

		local bodyY = py + 68
		local rowGap = 14
		local availableH = math.max(300, ph - 68 - rowGap * 2)
		local primitiveH = math.max(120, math.floor(availableH * 0.28))
		local outputH = math.max(86, math.floor(availableH * 0.18))
		local shapeH = availableH - primitiveH - outputH

		local function section(x, y, ww, hh, title, subtitle, accent)
			MGFX.RoundedBoxEx(x, y, ww, hh, {
				radius = 8,
				fill = Color(4, 11, 15, 156),
				stroke = Color(accent.r, accent.g, accent.b, 34),
				strokeWidth = "hairline",
			})
			addText(title, "MGFXDemoLabel", x + 14, y + 10, COLORS.ink)
			if subtitle and subtitle ~= "" then
				addText(subtitle, "MGFXDemoTiny", x + ww - 14, y + 18, COLORS.muted, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
			end
			MGFX.LineEx(x + 14, y + 32, x + ww - 14, y + 32, {
				width = "hairline",
				fill = MGFX.LinearGradient(0, 0, 1, 0, Color(accent.r, accent.g, accent.b, 42), Color(accent.r, accent.g, accent.b, 0)),
			})
		end

		local function caption(value, x, y)
			addText(value, "MGFXDemoTiny", x, y, COLORS.muted, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		local primitiveY = bodyY
		section(px, primitiveY, pw, primitiveH, "Gradient Primitives", "linear / radial / conic", COLORS.cyan)
		local cellGap = 18
		local cellW = (pw - 36 - cellGap * 2) / 3
		local cellY = primitiveY + 44
		local cellH = math.max(42, primitiveH - 68)
		local cell1X = px + 18
		local cell2X = cell1X + cellW + cellGap
		local cell3X = cell2X + cellW + cellGap
		MGFX.RoundedBoxEx(cell1X, cellY, cellW, cellH - 18, {
			radius = 7,
			fill = linearStops(0, 0, 1, 0, spectrumStops),
			stroke = Color(255, 255, 255, 34),
			strokeWidth = 1,
		})
		stopRail(cell1X, cellY + cellH - 10, cellW, spectrumStops)
		caption("LinearGradientStops", cell1X + cellW * 0.5, primitiveY + primitiveH - 14)
		MGFX.RoundedBoxEx(cell2X, cellY, cellW, cellH, {
			radius = 7,
			fill = MGFX.RadialGradient(0.32, 0.42, 0.92, radialStops),
			stroke = Color(255, 255, 255, 34),
			strokeWidth = 1,
		})
		caption("RadialGradient", cell2X + cellW * 0.5, primitiveY + primitiveH - 14)
		MGFX.RoundedBoxEx(cell3X, cellY, cellW, cellH, {
			radius = 7,
			fill = MGFX.ConicGradient(0.5, 0.5, RealTime() * 18, spectrumStops),
			stroke = Color(255, 255, 255, 34),
			strokeWidth = 1,
		})
		caption("ConicGradient", cell3X + cellW * 0.5, primitiveY + primitiveH - 14)

		local shapeY = primitiveY + primitiveH + rowGap
		section(px, shapeY, pw, shapeH, "Shape Local Space", "ring / arc / sector gradient coordinates", COLORS.green)
		local innerX = px + 18
		local innerY = shapeY + 52
		local innerW = pw - 36
		local captionY = shapeY + shapeH - 18
		local visualTop = innerY + 4
		local visualBottom = captionY - 24
		local visualH = math.max(80, visualBottom - visualTop)
		local shapeCenterY = visualTop + visualH * 0.5
		local groupGap = 32
		local ringW = math.floor(innerW * 0.42)
		local sectorW = innerW - ringW - groupGap
		local ringX = innerX
		local sectorX = innerX + ringW + groupGap
		MGFX.LineEx(sectorX - groupGap * 0.5, visualTop, sectorX - groupGap * 0.5, visualBottom, {
			width = "hairline",
			fill = Color(255, 255, 255, 18),
		})
		addText("Ring-local", "MGFXDemoTiny", ringX, innerY - 15, COLORS.green)
		addText("Arc / Sector-local", "MGFXDemoTiny", sectorX, innerY - 15, COLORS.green)

		local r = math.min(74, ringW * 0.2, visualH * 0.43)
		local ringY = shapeCenterY
		local ring1X = ringX + ringW * 0.33
		local ring2X = ringX + ringW * 0.72
		MGFX.RingEx(ring1X, ringY, r, r * 0.38, {
			fill = MGFX.RingRadialGradient(radialStops),
			stroke = Color(255, 255, 255, 42),
			strokeWidth = 1,
			outerGlow = showOuterGlow and {color = Color(64, 196, 236, 50), size = 14, opacity = 0.65, softness = 0.64} or nil,
		})
		MGFX.RingEx(ring2X, ringY, r, r * 0.26, {
			fill = MGFX.RingAngularGradient(spectrumStops, -90),
			stroke = Color(255, 255, 255, 42),
			strokeWidth = 1,
			innerGlow = showInnerGlow and {color = Color(255, 255, 255, 52), size = 8, opacity = 0.45, softness = 0.7} or nil,
		})
		caption("RingRadialGradient", ring1X, captionY)
		caption("RingAngularGradient", ring2X, captionY)

		local sr = math.min(78, sectorW * 0.14, visualH * 0.43)
		local arcX = sectorX + sectorW * 0.21
		local sector1X = sectorX + sectorW * 0.53
		local sector2X = sectorX + sectorW * 0.8
		MGFX.ArcEx(arcX, shapeCenterY, sr + 22, 15, 205, 340, {
			fill = (MGFX.ArcAngularGradient or MGFX.ShapeAngularGradient)(warmStops),
			stroke = Color(255, 255, 255, 46),
			strokeWidth = 1,
			outerGlow = showOuterGlow and {color = Color(255, 96, 78, 46), size = 13, opacity = 0.65, softness = 0.64} or nil,
		})
		MGFX.SectorEx(sector1X, shapeCenterY, sr * 0.38, sr, -132, 10, {
			fill = MGFX.SectorRadialGradient(radialStops),
			stroke = Color(255, 255, 255, 44),
			strokeWidth = 1,
		})
		MGFX.SectorEx(sector2X, shapeCenterY, sr * 0.38, sr, 18, 142, {
			fill = MGFX.SectorAngularGradient(spectrumStops),
			stroke = Color(255, 255, 255, 44),
			strokeWidth = 1,
		})
		caption("ArcAngularGradient", arcX, captionY)
		caption("SectorRadialGradient", sector1X, captionY)
		caption("SectorAngularGradient", sector2X, captionY)

		local outputY = shapeY + shapeH + rowGap
		section(px, outputY, pw, outputH, "Output Surfaces", "widgets / composed text", COLORS.gold)
		local widgetW = math.floor((pw - 58) * 0.54)
		local textX = px + 40 + widgetW
		local textW = pw - widgetW - 58
		local textCenterX = textX + textW * 0.5
		local outputContentY = outputY + 42
		MGFX.ProgressBarEx(px + 18, outputContentY, widgetW, 16, 0.82, {
			radius = 8,
			padding = 2,
			track = Color(4, 12, 17, 220),
			fill = linearStops(0, 0, 1, 0, deepStops),
			stroke = Color(80, 210, 255, 40),
			strokeWidth = 1,
			fx = {glow = true, sheen = true, marker = true, ticks = 8},
		})
		MGFX.SegmentBarEx(px + 18, outputContentY + 28, widgetW, 14, 0.76, {
			segments = 22,
			gap = 3,
			radius = 3,
			track = Color(255, 255, 255, 20),
			fill = linearStops(0, 0, 1, 0, spectrumStops),
		})
		MGFX.TextEx("STOPS LUT", "MGFXDemoTextTitle", textCenterX, outputY + outputH * 0.62, nil, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, {
			fill = linearStops(0, 0, 1, 0, spectrumStops),
			stroke = {width = 0.62, softness = 0.68, color = Color(0, 0, 0, 140)},
			shadow = {x = 0, y = 2, blur = 6, color = Color(0, 0, 0, 132)},
			glow = showOuterGlow and {size = 8, color = Color(70, 205, 255, 58), opacity = 0.62, softness = 0.58} or nil,
		})
	end

	if MGFX and MGFX.StartPanel then
		MGFX.StartPanel(self, w, h)

		MGFX.RoundedBoxEx(0, 0, w, h, {
			radius = 26,
			fill = Color(0, 0, 0, 0),
			backdrop = {
				blur = 3,
				tint = Color(0, 0, 0, 102),
			},
		})

		MGFX.RoundedBoxEx(0, 0, w, h, {
			radius = 26,
			fill = MGFX.RadialGradient(0.5, 0.5, 0.82, {
				{0, Color(0, 0, 0, 0)},
				{1, Color(0, 0, 0, 31)},
			}),
		})

		MGFX.RoundedBoxEx(0, 0, w, h, {
			radius = 26,
			fill = MGFX.LinearGradient(0, 0, 0, 1, Color(16, 19, 21, 224), Color(28, 33, 35, 204)),
			stroke = Color(110, 220, 255, 34),
			strokeWidth = 1,
		})

		MGFX.PolyEx({
			{x = 0, y = 0},
			{x = 210, y = 0},
			{x = 168, y = 72},
			{x = 0, y = 58},
		}, {
			fill = MGFX.LinearGradient(0, 0, 1, 0, {
				{0, Color(8, 28, 42, 220)},
				{1, Color(8, 16, 22, 180)},
			}),
			stroke = Color(80, 170, 230, 80),
			strokeWidth = 1,
		})

		MGFX.PolyEx({
			{x = w, y = 0},
			{x = w - 244, y = 0},
			{x = w - 206, y = 78},
			{x = w, y = 62},
		}, {
			fill = MGFX.LinearGradient(1, 0, 0, 0, Color(42, 22, 10, 198), Color(7, 16, 19, 132)),
			stroke = Color(255, 190, 66, 64),
			strokeWidth = 1,
		})

		if self.ShowGradientShowcase ~= false then
			drawGradientShowcase()
		else
		local x, y, cw, ch
		x, y, cw, ch = card(1, "Immediate Shapes", "RegularPoly / Diamond / Caret", COLORS.green)
		for row = 0, 2 do
			for col = 0, 6 do
				local t = (row * 7 + col) / 20
				local px = x + 18 + col * ((cw - 36) / 7)
				local py = y + 46 + row * 16
				local pw = math.max(12, (cw - 54) / 7)
				MGFX.RoundedBoxEx(px, py, pw, 9, {
					radius = 5,
					fill = Color(28 + 160 * t, 118 + 64 * math.sin(t * 6), 220 - 150 * t, 205),
					stroke = Color(255, 255, 255, 28),
					strokeWidth = 1,
				})
			end
		end
		for i = 0, 4 do
			local ly = y + 96 + i * 5
			MGFX.LineEx(x + 18, ly, x + cw - 72, ly, {
				width = 2,
				fill = MGFX.LinearGradient(0, 0, 1, 0, Color(80, 220, 255, 210), Color(255, 190, 66, 180)),
			})
		end
		MGFX.RegularPolyEx(x + cw - 54, y + 106, 10, 5, {
			rotation = -90,
			fill = Color(68, 232, 146, 218),
			stroke = Color(255, 255, 255, 44),
			strokeWidth = 1,
			shadow = {x = 0, y = 4, blur = 10, spread = 1, color = Color(0, 0, 0, 148), softness = 0.7},
		})
		MGFX.DiamondEx(x + cw - 42, y + 97, 18, 18, {
			fill = MGFX.LinearGradient(0, 0, 1, 1, Color(80, 220, 255, 224), Color(255, 190, 66, 208)),
			stroke = Color(255, 255, 255, 48),
			strokeWidth = 1,
			shadow = {x = 0, y = 4, blur = 9, spread = 1, color = Color(0, 0, 0, 122), softness = 0.72},
			outerGlow = showOuterGlow and {color = Color(80, 220, 255, 58), size = 8, opacity = 0.72, softness = 0.64} or nil,
		})
		MGFX.CaretEx(x + cw - 17, y + 98, 17, 17, {
			direction = "right",
			fill = Color(255, 112, 92, 220),
			stroke = Color(255, 255, 255, 42),
			strokeWidth = 1,
			shadow = {x = 0, y = 4, blur = 8, color = Color(0, 0, 0, 116), softness = 0.7},
		})

		x, y, cw, ch = card(2, "Multi-stop Gradient", "LinearGradientStops + LineEx", COLORS.cyan)

		local linearStops = MGFX and (MGFX.LinearGradientStops or MGFX.LinearGradient)
		if linearStops then
			MGFX.RoundedBoxEx(x + 22, y + 52, cw - 44, 16, {
				radius = 4,
				fill = linearStops(0, 0, 1, 0, {
					{0, Color(255, 0, 0, 238)},
					{0.35, Color(255, 0, 170, 238)},
					{0.68, Color(36, 40, 255, 238)},
					{1, Color(0, 210, 255, 238)},
				}),
				stroke = Color(255, 255, 255, 34),
				strokeWidth = 1,
			})

			MGFX.RoundedBoxEx(x + 22, y + 76, cw - 44, 32, {
				radius = 7,
				fill = linearStops(0, 0, 1, 0, {
					{0, Color(30, 112, 255, 238)},
					{0.34, Color(58, 220, 190, 238)},
					{0.67, Color(255, 190, 66, 238)},
					{1, Color(255, 78, 82, 238)},
				}),
				stroke = Color(255, 255, 255, 34),
				strokeWidth = 1,
			})
			MGFX.LineEx(x + 24, y + 116, x + cw - 24, y + 116, {
				width = 4,
				fill = linearStops(0, 0, 1, 0, {
					{0, Color(255, 0, 0, 0)},
					{0.28, Color(255, 0, 0, 255)},
					{0.72, Color(70, 210, 255, 255)},
					{1, Color(70, 210, 255, 0)},
				}),
			})
		else
			addText("MGFX.LinearGradientStops not available", "MGFXDemoTiny", x + cw * 0.5, y + 70, COLORS.red, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		x, y, cw, ch = card(3, "Pattern", "StripePattern / SmokePattern", COLORS.green)
		MGFX.RoundedBoxEx(x + 26, y + 48, cw - 52, 42, {
			radius = 10,
			fill = Color(4, 18, 22, 220),
			pattern = MGFX.StripePattern(Color(88, 230, 160, 100), 9, 2, 135, 2),
			stroke = Color(88, 230, 160, 80),
			strokeWidth = 1,
		})
		MGFX.ChamferBoxEx(x + 36, y + 100, cw - 72, 28, {
			cuts = {tl = 12, tr = 3, br = 12, bl = 3},
			fill = Color(14, 24, 18, 220),
			pattern = MGFX.SmokePattern({
				color = Color(255, 190, 66, 86),
				scale = 80,
				density = 0.47,
				softness = 0.32,
				angle = 24,
				offset = 1.25,
				seed = "demo-smoke",
				speed = 1,
			}),
			stroke = Color(255, 190, 66, 76),
			strokeWidth = "hairline",
		})

		x, y, cw, ch = card(4, "Image Masks", "rounded / chamfer / circle / texture", COLORS.gold)
		if mat then
			local size = math.min(48, cw * 0.24)
			local leftX = x + 28
			local rightX = x + cw - 28 - size
			local topY = y + 46
			local bottomY = y + 96

			MGFX.ImageEx(leftX, topY, size, size, mat, {
				mask = MGFX.Mask("rounded", {radius = 11}),
				fit = "cover",
				tint = Color(42, 150, 255, 238),
				stroke = Color(255, 255, 255, 46),
				strokeWidth = 1,
				fill = Color(4, 18, 26, 220),
			})
			MGFX.ImageEx(rightX, topY, size, size, mat, {
				mask = MGFX.Mask("circle"),
				fit = "cover",
				tint = Color(72, 224, 170, 238),
				stroke = Color(70, 210, 255, 88),
				strokeWidth = 1,
				fill = Color(4, 18, 26, 220),
			})
			MGFX.ImageEx(leftX, bottomY, size, size, mat, {
				mask = MGFX.Mask("chamfer", {cuts = {tl = 14, tr = 3, br = 14, bl = 3}}),
				fit = "cover",
				tint = Color(255, 190, 66, 235),
				stroke = Color(255, 190, 66, 90),
				strokeWidth = 1,
				fill = Color(24, 14, 8, 220),
			})
			MGFX.ImageEx(rightX, bottomY, size, size, mat, {
				mask = MGFX.Mask("texture", {
					source = maskMat or mat,
					channel = "luma",
				}),
				fit = "cover",
				tint = Color(255, 112, 92, 238),
				stroke = Color(255, 255, 255, 58),
				strokeWidth = 1,
				fill = Color(24, 10, 8, 220),
				outerGlow = showOuterGlow and {
					color = Color(255, 190, 66, 118),
					size = 14,
					opacity = 1.15,
					softness = 0.62,
				} or nil,
			})

			addText("rounded", "MGFXDemoTiny", leftX + size * 0.5, topY + size + 4, COLORS.muted, TEXT_ALIGN_CENTER)
			addText("circle", "MGFXDemoTiny", rightX + size * 0.5, topY + size + 4, COLORS.muted, TEXT_ALIGN_CENTER)
			addText("chamfer", "MGFXDemoTiny", leftX + size * 0.5, bottomY + size + 4, COLORS.muted, TEXT_ALIGN_CENTER)
			addText("texture", "MGFXDemoTiny", rightX + size * 0.5, bottomY + size + 4, COLORS.muted, TEXT_ALIGN_CENTER)
		end

		x, y, cw, ch = card(5, "Segment Bar", "SegmentBarEx: scoreboard threat", COLORS.red)
		MGFX.SegmentBarEx(x + 24, y + 58, cw - 48, 14, 0.72, {
			segments = 18,
			gap = 3,
			radius = 2,
			track = Color(255, 255, 255, 22),
			trackPattern = MGFX.StripePattern(Color(255, 255, 255, 24), 7, 1, 90, 0),
			fill = MGFX.LinearGradient(0, 0, 1, 0, {
				{0, Color(255, 150, 78, 235)},
				{0.55, Color(255, 92, 74, 235)},
				{1, Color(255, 52, 64, 235)},
			}),
			fillPattern = MGFX.StripePattern(Color(255, 255, 255, 54), 8, 1.25, 135, 1),
			outerGlow = showOuterGlow and {
				color = Color(255, 88, 78, 64),
				size = 12,
				opacity = 0.85,
				softness = 0.68,
			} or nil,
		})
		MGFX.SegmentBarEx(x + 24, y + 94, cw - 48, 10, 0.38, {
			segments = 12,
			gap = 4,
			radius = 2,
			track = Color(255, 255, 255, 18),
			trackPattern = MGFX.StripePattern(Color(255, 255, 255, 18), 9, 1, 90, 2),
			fill = Color(70, 210, 255, 230),
			fillPattern = MGFX.StripePattern(Color(255, 255, 255, 42), 9, 1.25, 35, 2),
		})

		x, y, cw, ch = card(6, "Ring / Arc", "RingEx + ArcEx + SectorEx", COLORS.cyan)
		MGFX.RingEx(x + cw * 0.32, y + 82, 36, 12, {
			fill = MGFX.ConicGradient(0.5, 0.5, 0.08, Color(70, 210, 255, 210), Color(255, 190, 66, 210)),
			stroke = Color(255, 255, 255, 68),
			strokeWidth = 1,
			pattern = MGFX.StripePattern(Color(255, 255, 255, 44), 9, 1.5, 35, 2),
			outerGlow = showOuterGlow and {
				color = Color(70, 210, 255, 120),
				size = 16,
				opacity = 1.1,
				softness = 0.62,
			} or nil,
			innerGlow = showInnerGlow and {
				color = Color(255, 32, 32, 140),
				size = 16,
				opacity = 0.68,
				softness = 0.72,
			} or nil,
		})
		MGFX.ArcEx(x + cw * 0.68, y + 82, 42, 9, -135, 130, {
			fill = MGFX.LinearGradient(0, 0, 1, 1, Color(255, 190, 66, 230), Color(255, 82, 78, 220)),
			stroke = Color(255, 255, 255, 58),
			strokeWidth = 1,
			pattern = MGFX.SmokePattern({
				color = Color(255, 255, 255, 42),
				scale = 52,
				density = 0.48,
				softness = 0.28,
				warp = 0.72,
				angle = 20,
				offset = 0.75,
				seed = "demo-arc-smoke",
				speed = 4,
			}),
			outerGlow = showOuterGlow and {
				color = Color(255, 100, 78, 92),
				size = 14,
				opacity = 1,
				softness = 0.66,
			} or nil,
		})
		MGFX.SectorEx(x + cw * 0.68, y + 82, 12, 25, 145, 310, {
			fill = MGFX.SectorAngularGradient({
				{0, Color(80, 210, 255, 210)},
				{0.48, Color(68, 232, 146, 215)},
				{1, Color(255, 82, 78, 220)},
			}),
			stroke = Color(255, 255, 255, 46),
			strokeWidth = 1,
		})

		x, y, cw, ch = card(7, "Glow Layers", "innerGlow / outerGlow isolated", COLORS.gold)
		MGFX.RoundedBoxEx(x + 30, y + 50, cw - 60, 30, {
			radius = 8,
			fill = Color(8, 18, 24, 220),
			stroke = Color(80, 210, 255, 70),
			strokeWidth = 1,
			outerGlow = showOuterGlow and {
				color = Color(80, 210, 255, 135),
				size = 24,
				opacity = 1.35,
				softness = 0.58,
			} or nil,
		})
		MGFX.RoundedBoxEx(x + 30, y + 96, cw - 60, 30, {
			radius = 8,
			fill = Color(24, 14, 8, 220),
			stroke = Color(255, 190, 66, 70),
			strokeWidth = 1,
			innerGlow = showInnerGlow and {
				color = Color(255, 190, 66, 210),
				size = 13,
				opacity = 1.6,
				softness = 0.64,
			} or nil,
		})

		x, y, cw, ch = card(8, "Progress Bar", "track / fill / ticks / sheen", COLORS.green)
		MGFX.ProgressBarEx(x + 24, y + 54, cw - 48, 16, 0.68, {
			radius = 8,
			track = Color(5, 12, 17, 220),
			trackPattern = MGFX.StripePattern(Color(255, 255, 255, 26), 11, 1, 90, 0),
			fill = MGFX.LinearGradient(0, 0, 1, 0, Color(24, 96, 212, 238), Color(38, 178, 230, 238)),
			fillPattern = MGFX.StripePattern(Color(255, 255, 255, 44), 10, 1.5, 135, 2),
			stroke = Color(72, 180, 230, 34),
			strokeWidth = 1,
			padding = 2,
		})
		MGFX.ProgressBarEx(x + 24, y + 96, cw - 48, 16, 0.78, {
			radius = 8,
			track = Color(5, 12, 17, 220),
			fill = MGFX.LinearGradient(0, 0, 1, 0, {
				{0, Color(28, 110, 230, 238)},
				{0.55, Color(72, 220, 245, 238)},
				{1, Color(255, 210, 86, 238)},
			}),
			stroke = Color(80, 200, 255, 38),
			strokeWidth = 1,
			padding = 2,
			fx = {
				glow = true,
				sheen = true,
				marker = true,
				ticks = 6,
			},
		})

		x, y, cw, ch = card(9, "Advanced Gradients", "Radial / Multi-Stop / Layered", COLORS.cyan)

		-- Radial gradient spotlight
		addText("Radial: cx/cy/radius", "MGFXDemoTiny", x + cw * 0.5, y + 46, COLORS.muted, TEXT_ALIGN_CENTER)
		MGFX.RoundedBoxEx(x + 14, y + 56, cw - 28, 24, {
			radius = 4,
			fill = MGFX.RadialGradient(0.7, 0.4, 1.5, {
				{0, Color(220, 240, 255, 240)},
				{0.42, Color(80, 220, 255, 218)},
				{1, Color(30, 40, 50, 200)},
			}),
			stroke = Color(80, 180, 255, 100),
			strokeWidth = 1,
		})

		-- Multi-stop gradient
		addText("4-stop linear", "MGFXDemoTiny", x + cw * 0.5, y + 88, COLORS.muted, TEXT_ALIGN_CENTER)
		MGFX.RoundedBoxEx(x + 14, y + 98, cw - 28, 18, {
			radius = 4,
			fill = (MGFX.LinearGradientStops or MGFX.LinearGradient)(0, 0, 1, 0, {
				{0, Color(255, 100, 100, 240)},
				{0.33, Color(255, 200, 100, 240)},
				{0.66, Color(100, 255, 180, 240)},
				{1, Color(100, 150, 255, 240)},
			}),
			stroke = Color(200, 200, 200, 80),
			strokeWidth = 1,
		})

		-- Layered off-center glows
		addText("Layered radial overlays", "MGFXDemoTiny", x + cw * 0.5, y + 124, COLORS.muted, TEXT_ALIGN_CENTER)
		local lw, lh = cw - 28, 32
		local lx, ly = x + 14, y + 134
		MGFX.RoundedBoxEx(lx, ly, lw, lh, {
			radius = 5,
			fill = Color(47, 125, 174, 230),
			stroke = Color(120, 190, 230, 92),
			strokeWidth = 1,
		})
		MGFX.RoundedBoxEx(lx, ly, lw, lh, {
			radius = 5,
			fill = MGFX.RadialGradient(0.78, 0.24, 1.75, {
				{0, Color(180, 232, 255, 172)},
				{0.28, Color(90, 190, 255, 118)},
				{0.68, Color(44, 126, 220, 42)},
				{1, Color(44, 126, 220, 0)},
			}),
		})
		MGFX.RoundedBoxEx(lx, ly, lw, lh, {
			radius = 5,
			fill = MGFX.RadialGradient(0.18, 0.78, 1.55, {
				{0, Color(255, 148, 112, 150)},
				{0.38, Color(255, 82, 92, 82)},
				{0.72, Color(170, 38, 96, 24)},
				{1, Color(170, 38, 96, 0)},
			}),
		})

		x, y, cw, ch = card(10, "Text FX", "", COLORS.gold)
		MGFX.RoundedBoxEx(x + 18, y + 44, cw - 36, ch - 58, {
			radius = 9,
			fill = Color(3, 11, 16, 214),
			stroke = Color(255, 190, 66, 46),
			strokeWidth = "hairline",
			innerGlow = showInnerGlow and {
				color = Color(255, 190, 66, 58),
				size = 12,
				opacity = 0.55,
				softness = 0.68,
			} or nil,
		})
		MGFX.TextEx("TEXT FX", "MGFXDemoTextTitle", x + cw * 0.5, y + 66, nil, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, {
			fill = MGFX.LinearGradient(0, 0, 1, 0, {
				{0, Color(104, 210, 255, 255)},
				{0.58, Color(238, 248, 255, 255)},
				{1, Color(255, 204, 112, 255)},
			}),
			stroke = {width = 0.72, softness = 0.64, color = Color(0, 5, 8, 150)},
			shadow = {x = 0, y = 2, blur = 6, color = Color(0, 0, 0, 132)},
			glow = showOuterGlow and {size = 8, color = Color(70, 205, 255, 60), opacity = 0.62, softness = 0.58} or nil,
		})
		MGFX.TextEx("中文描边 Aa123", "MGFXDemoTextBody", x + cw * 0.5, y + 100, Color(232, 242, 246), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, {
			stroke = {width = 0.28, softness = 0.72, color = Color(0, 0, 0, 72)},
			shadow = {x = 0, y = 2, blur = 4, color = Color(0, 0, 0, 92)},
		})
		MGFX.TextEx("128,450", "MGFXDemoTextNum", x + 28, y + 126, Color(236, 248, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, {
			stroke = {width = 0.38, softness = 0.68, color = Color(0, 0, 0, 104)},
			shadow = {x = 0, y = 2, blur = 5, color = Color(0, 0, 0, 126)},
			glow = showOuterGlow and {size = 5, color = Color(255, 190, 66, 42), opacity = 0.5, softness = 0.52} or nil,
		})
		MGFX.TextEx("+100 XP", "MGFXDemoTextBody", x + cw - 28, y + 126, Color(178, 222, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, {
			stroke = {width = 0.24, softness = 0.72, color = Color(0, 0, 0, 64)},
			shadow = {x = 0, y = 2, blur = 4, color = Color(0, 0, 0, 88)},
		})
		if ch >= 170 then
			MGFX.TextBoxEx("TextBox 自动测量 / ellipsis / anchored layout", "MGFXDemoTextSmall", x + 28, y + ch - 36, cw - 56, 22, {
				color = Color(205, 224, 226),
				alignX = "left",
				alignY = "center",
				overflow = "ellipsis",
				stroke = {width = 0.12, softness = 0.78, color = Color(0, 0, 0, 44)},
				shadow = {x = 0, y = 1, blur = 2, color = Color(0, 0, 0, 68)},
			})
		end

		x, y, cw, ch = card(11, "Explicit State Args", "", COLORS.cyan)
		local mx, my = self:CursorPos()
		local now = RealTime()
		local mouseDown = self.RuntimeMouseDown == true
		local pulseDuration = math.max(0.01, self.RuntimePulseDuration or 1.15)
		local pulseLeft = math.Clamp((self.RuntimePulseUntil or 0) - now, 0, pulseDuration)
		local pulse = pulseLeft > 0
		local pulsePhase = pulse and (1 - pulseLeft / pulseDuration) or 0
		local pulseWeight = pulse and math.sin(math.Clamp(pulsePhase, 0, 1) * math.pi) or 0
		local pulseRow = self.RuntimeSelected ~= 0 and self.RuntimeSelected or 1
		local rowLabels = {"base / hover", "selected", "compound", "disabled"}
		for i = 1, 4 do
			local rx = x + 18
			local ry = y + 44 + (i - 1) * 25
			local rw = cw - 44
			local rh = 20
			local hovered = mx >= rx and mx <= rx + rw and my >= ry and my <= ry + rh
			runtimeHitboxes[i] = {x = rx, y = ry, w = rw, h = rh}
			local weights = self.RuntimeWeights and self.RuntimeWeights[i]
			if not weights then
				weights = {hover = 0, selected = 0, pressed = 0, disabled = 0}
				self.RuntimeWeights = self.RuntimeWeights or {}
				self.RuntimeWeights[i] = weights
			end
			local pressedTarget = hovered and mouseDown and 1 or (pulse and i == pulseRow and pulseWeight or 0)
			local hoverWeight = updateRuntimeWeight(weights, "hover", hovered, 10)
			local selectedWeight = updateRuntimeWeight(weights, "selected", i == self.RuntimeSelected, 8)
			local disabledWeight = updateRuntimeWeight(weights, "disabled", i == 4 and self.RuntimeDisabled, 7)
			weights.pressed = approachWeight(weights.pressed or 0, pressedTarget, 13)
			local pressedWeight = weights.pressed
			local compoundWeight = math.min(hoverWeight, selectedWeight)
			local fill = mixColor(Color(5, 16, 22, 205), Color(8, 28, 36, 224), selectedWeight)
			fill = mixColor(fill, Color(9, 34, 44, 232), hoverWeight)
			fill = mixColor(fill, Color(3, 12, 18, 238), pressedWeight)
			fill = mixColor(fill, Color(8, 10, 12, 152), disabledWeight)
			local stroke = mixColor(Color(70, 150, 190, 44), Color(84, 210, 255, 96), selectedWeight)
			stroke = mixColor(stroke, Color(112, 228, 255, 116), hoverWeight)
			stroke = mixColor(stroke, Color(255, 190, 66, 122), pressedWeight)
			stroke = mixColor(stroke, Color(150, 236, 255, 150), compoundWeight)
			stroke = mixColor(stroke, Color(110, 128, 136, 28), disabledWeight)
			local glowWeight = math.max(hoverWeight, compoundWeight)
			MGFX.RoundedBoxEx(rx, ry, rw, rh, {
				radius = 7,
				fill = fill,
				stroke = stroke,
				strokeWidth = 1,
				outerGlow = glowWeight > 0.01 and disabledWeight < 0.95 and {
					color = Color(112, 224, 255, math.floor(Lerp(compoundWeight, 74, 130) * glowWeight)),
					size = Lerp(compoundWeight, 16, 20),
					opacity = Lerp(compoundWeight, 0.72, 1.05) * glowWeight,
					softness = 0.64,
				} or nil,
			})
			addText(rowLabels[i], "MGFXDemoTiny", rx + 10, ry + rh * 0.5, COLORS.ink, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			addText(string.format("h %.2f  s %.2f  p %.2f  d %.2f", hoverWeight, selectedWeight, pressedWeight, disabledWeight), "MGFXDemoTiny", rx + rw - 8, ry + rh * 0.5, COLORS.muted, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		end
		self.RuntimeHitboxes = runtimeHitboxes
		addText("click row; hold/pulse = pressed weight", "MGFXDemoTiny", x + 18, y + ch - 22, COLORS.muted)

		x, y, cw, ch = card(12, "Mutable Draw Params", "", COLORS.green)
		local hoverPanel = mx >= x + 20 and mx <= x + cw - 20 and my >= y + 44 and my <= y + 128
		local pressedPanel = hoverPanel and mouseDown
		local selectedPanel = self.RuntimeSelected == 3
		local actionActive = now < (self.RuntimeActionUntil or 0)
		local actionAccent = COLORS.muted
		if self.RuntimeActionId == "clear" then
			actionAccent = COLORS.cyan
		elseif self.RuntimeActionId == "instant" then
			actionAccent = COLORS.gold
		elseif self.RuntimeActionId == "disable" then
			actionAccent = COLORS.red
		elseif self.RuntimeActionId == "pulse" then
			actionAccent = COLORS.green
		end

		MGFX.RoundedBoxEx(x + 16, y + 42, cw - 32, 22, {
			radius = 6,
			fill = Color(actionAccent.r, actionAccent.g, actionAccent.b, actionActive and 32 or 14),
			stroke = Color(actionAccent.r, actionAccent.g, actionAccent.b, actionActive and 92 or 34),
			strokeWidth = "hairline",
		})
		addText(self.RuntimeActionMessage or "ready", "MGFXDemoTiny", x + 24, y + 53, actionActive and COLORS.ink or COLORS.muted, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		addText(string.format("row %s  disabled %s", self.RuntimeSelected == 0 and "-" or tostring(self.RuntimeSelected), self.RuntimeDisabled and "on" or "off"), "MGFXDemoTiny", x + cw - 24, y + 53, COLORS.muted, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

		local progressWeights = self.RuntimeProgressWeights or {hover = 0, selected = 0, pressed = 0, disabled = 0}
		self.RuntimeProgressWeights = progressWeights
		local progressHover = updateRuntimeWeight(progressWeights, "hover", hoverPanel, 9)
		local progressSelected = updateRuntimeWeight(progressWeights, "selected", selectedPanel, 7)
		local progressDisabled = updateRuntimeWeight(progressWeights, "disabled", self.RuntimeDisabled, 7)
		progressWeights.pressed = approachWeight(progressWeights.pressed or 0, pressedPanel and 1 or pulseWeight, 12)
		local progressPressed = progressWeights.pressed
		local progressFill = mixColor(Color(32, 138, 232, 232), Color(255, 190, 66, 238), progressSelected)
		progressFill = mixColor(progressFill, Color(70, 230, 176, 238), progressHover)
		progressFill = mixColor(progressFill, Color(255, 100, 86, 240), progressPressed)
		progressFill = mixColor(progressFill, Color(92, 104, 112, 132), progressDisabled)
		local progressStroke = mixColor(Color(72, 180, 230, 36), Color(255, 210, 100, 92), progressSelected)
		progressStroke = mixColor(progressStroke, Color(120, 248, 206, 104), progressHover)
		progressStroke = mixColor(progressStroke, Color(150, 158, 164, 30), progressDisabled)
		local value = pulse and (0.38 + pulseWeight * 0.5) or (0.34 + waveValue(1.4, 0.8) * 0.48)
		MGFX.ProgressBarEx(x + 22, y + 72, cw - 78, 16, value, {
			radius = 7,
			padding = 2,
			track = mixColor(Color(4, 11, 16, 220), Color(5, 8, 10, 218), progressDisabled),
			fill = progressFill,
			stroke = progressStroke,
			strokeWidth = 1,
			fx = {
				glow = progressHover > 0.05 or progressSelected > 0.2,
				sheen = progressDisabled < 0.5,
				marker = progressPressed > 0.1 or progressSelected > 0.5,
				ticks = progressSelected > 0.55 and 8 or 0,
			},
		})
		addText(string.format("progress h %.2f s %.2f p %.2f d %.2f", progressHover, progressSelected, progressPressed, progressDisabled), "MGFXDemoTiny", x + 22, y + 96, COLORS.muted)

		local ringWeights = self.RuntimeRingWeights or {hover = 0, selected = 0, pressed = 0, disabled = 0}
		self.RuntimeRingWeights = ringWeights
		local ringHover = updateRuntimeWeight(ringWeights, "hover", hoverPanel, 9)
		local ringSelected = updateRuntimeWeight(ringWeights, "selected", selectedPanel, 7)
		local ringDisabled = updateRuntimeWeight(ringWeights, "disabled", self.RuntimeDisabled, 7)
		ringWeights.pressed = approachWeight(ringWeights.pressed or 0, pressedPanel and 1 or pulseWeight, 12)
		local ringPressed = ringWeights.pressed
		local ringFill = mixColor(Color(64, 196, 236, 190), Color(255, 190, 66, 225), ringSelected)
		ringFill = mixColor(ringFill, Color(88, 230, 160, 230), ringHover)
		ringFill = mixColor(ringFill, Color(255, 88, 78, 236), ringPressed)
		ringFill = mixColor(ringFill, Color(106, 120, 126, 118), ringDisabled)
		MGFX.RingEx(x + cw - 42, y + 80, 22, Lerp(math.max(ringHover, ringSelected, ringPressed), 4, 9), {
			fill = ringFill,
		})
		addText(string.format("ring h %.2f p %.2f", ringHover, ringPressed), "MGFXDemoTiny", x + cw - 78, y + 110, COLORS.muted)

		MGFX.RoundedBoxEx(x + 22, y + 106, cw - 96, 6, {
			radius = 3,
			fill = Color(4, 10, 14, 176),
			stroke = Color(255, 255, 255, 16),
			strokeWidth = "hairline",
		})
		if pulse then
			MGFX.RoundedBoxEx(x + 22, y + 106, (cw - 96) * (pulseLeft / pulseDuration), 6, {
				radius = 3,
				fill = MGFX.LinearGradient(0, 0, 1, 0, Color(255, 96, 78, 220), Color(68, 232, 146, 230)),
			})
		end

		local actions = {
			{"clear", "CLEAR", COLORS.muted},
			{"instant", "INSTANT", COLORS.gold},
			{"disable", self.RuntimeDisabled and "ENABLE" or "DISABLE", COLORS.red},
			{"pulse", "PULSE", COLORS.green},
		}
		local aw = (cw - 52) / 4
		for i, action in ipairs(actions) do
			local ax = x + 16 + (i - 1) * (aw + 7)
			local ay = y + ch - 52
			local ah = 24
			local hot = mx >= ax and mx <= ax + aw and my >= ay and my <= ay + ah
			local active = (action[1] == "disable" and self.RuntimeDisabled) or (action[1] == "pulse" and pulse) or (self.RuntimeActionId == action[1] and actionActive)
			runtimeActionHitboxes[#runtimeActionHitboxes + 1] = {id = action[1], x = ax, y = ay, w = aw, h = ah}
			MGFX.RoundedBoxEx(ax, ay, aw, ah, {
				radius = 5,
				fill = active and Color(action[3].r, action[3].g, action[3].b, 38) or (hot and Color(12, 34, 40, 232) or Color(4, 14, 20, 196)),
				stroke = Color(action[3].r, action[3].g, action[3].b, active and 142 or (hot and 110 or 58)),
				strokeWidth = 1,
			})
			if active then
				MGFX.LineEx(ax + 7, ay + ah - 4, ax + aw - 7, ay + ah - 4, {
					width = 2,
					fill = Color(action[3].r, action[3].g, action[3].b, 170),
				})
			end
			addText(action[2], "MGFXDemoTiny", ax + aw * 0.5, ay + ah * 0.5, hot and COLORS.ink or action[3], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		self.RuntimeActionHitboxes = runtimeActionHitboxes
		addText(string.format("row 3 drives explicit selected; pulse %.2f", pulseWeight), "MGFXDemoTiny", x + 16, y + ch - 22, COLORS.muted)
		end

		MGFX.EndPanel()
	else
		draw.RoundedBox(18, 0, 0, w, h, Color(4, 15, 22, 226))
	end

	text("MGFX", "MGFXDemoTitle", left, top + 4, COLORS.ink)
	text(self.ShowGradientShowcase ~= false and "Gradient Stops / full-size render surfaces" or "Feature Matrix / immediate telemetry", "MGFXDemoSub", left + 2, top + 42, COLORS.muted)
	local statusText = table.concat({
		loaded and "SHADER ONLINE" or "SHADER FALLBACK",
		fallback and "FORCED SOFTWARE" or "GPU PATH",
		showInnerGlow and "INNER ON" or "INNER OFF",
		showOuterGlow and "OUTER ON" or "OUTER OFF",
	}, "   ")
	text(statusText, "MGFXDemoTiny", left + 2, top + 62, loaded and COLORS.green or COLORS.red)

	local stats = MGFX and MGFX.stats or {}
	text(string.format("draws %d   blur %d   fallback %d   culled %d", stats.draws or 0, stats.blurPasses or 0, stats.fallbacks or 0, stats.culled or 0), "MGFXDemoTiny", left + 2, h - 30, COLORS.muted)
	text(string.format("text composed draws %d   bakes %d   blits %d", stats.textShaderDraws or 0, stats.textComposedBakes or 0, stats.textComposedBlits or 0), "MGFXDemoTiny", left + 2, h - 16, Color(170, 230, 200))

	for _, item in ipairs(labels) do
		text(item[1], item[2], item[3], item[4], item[5], item[6], item[7])
	end

end

function PANEL:SetRuntimeAction(id, message, duration)
	self.RuntimeActionId = id or ""
	self.RuntimeActionMessage = message or "ready"
	self.RuntimeActionUntil = RealTime() + (duration or 0.9)
end

function PANEL:ClearRuntimeStateWeights(instant)
	local function clear(weights)
		if not weights then return end
		for key in pairs(weights) do
			weights[key] = instant and 0 or weights[key]
		end
	end

	for _, weights in ipairs(self.RuntimeWeights or {}) do
		clear(weights)
	end
	clear(self.RuntimeProgressWeights)
	clear(self.RuntimeRingWeights)
end

function PANEL:OnMousePressed(code)
	if code ~= MOUSE_LEFT then return end

	self.RuntimeMouseDown = true
	self:MouseCapture(true)

	local x, y = self:CursorPos()
	for _, box in ipairs(self.RuntimeActionHitboxes or {}) do
		if x >= box.x and x <= box.x + box.w and y >= box.y and y <= box.y + box.h then
			local now = RealTime()
			if box.id == "clear" then
				self.RuntimeSelected = 0
				self.RuntimeDisabled = false
				self.RuntimePulseUntil = 0
				self:ClearRuntimeStateWeights(false)
				self:SetRuntimeAction("clear", "Clear: easing out", 1.25)
			elseif box.id == "instant" then
				self.RuntimeSelected = 3
				self.RuntimeDisabled = false
				self.RuntimePulseUntil = 0
				self:ClearRuntimeStateWeights(true)
				if self.RuntimeWeights and self.RuntimeWeights[3] then
					self.RuntimeWeights[3].selected = 1
				end
				if self.RuntimeProgressWeights then self.RuntimeProgressWeights.selected = 1 end
				if self.RuntimeRingWeights then self.RuntimeRingWeights.selected = 1 end
				self:SetRuntimeAction("instant", "Instant: row 3 jump", 1.25)
			elseif box.id == "disable" then
				self.RuntimeDisabled = not self.RuntimeDisabled
				self:SetRuntimeAction("disable", self.RuntimeDisabled and "Disabled ON" or "Disabled OFF", 1.25)
			elseif box.id == "pulse" then
				if self.RuntimeSelected == 0 then
					self.RuntimeSelected = 3
				end
				self.RuntimePulseStart = now
				self.RuntimePulseDuration = 1.15
				self.RuntimePulseUntil = now + self.RuntimePulseDuration
				self:SetRuntimeAction("pulse", "Pulse: pressed weight", 1.35)
			end
			return
		end
	end

	for i, box in ipairs(self.RuntimeHitboxes or {}) do
		if x >= box.x and x <= box.x + box.w and y >= box.y and y <= box.y + box.h then
			self.RuntimeSelected = i
			self:SetRuntimeAction("row", string.format("row %d selected", i), 0.95)
			return
		end
	end

	if y > 80 then return end

	local px, py = self:GetPos()
	self.Dragging = {
		mousex = gui.MouseX(),
		mousey = gui.MouseY(),
		x = px,
		y = py,
	}
end

function PANEL:OnMouseReleased()
	self.Dragging = nil
	self.RuntimeMouseDown = false
	self:MouseCapture(false)
end

function PANEL:Think()
	if not self.Dragging then return end

	local dx = gui.MouseX() - self.Dragging.mousex
	local dy = gui.MouseY() - self.Dragging.mousey
	self:SetPos(self.Dragging.x + dx, self.Dragging.y + dy)
end

vgui.Register("MGFXDemoPanel", PANEL, "Panel")

local function openDemo()
	if IsValid(DemoPanel) then
		DemoPanel:Remove()
	end

	DemoPanel = vgui.Create("MGFXDemoPanel")
	return DemoPanel
end

local function closeDemo()
	if IsValid(DemoPanel) then
		DemoPanel:Remove()
	end
end

addCommand("mgfx_demo", function(_, _, args)
	local mode = args and args[1] or ""

	if mode == "0" or mode == "close" then
		closeDemo()
		return
	end

	if mode == "toggle" and IsValid(DemoPanel) then
		closeDemo()
		return
	end

	openDemo()
end)

addCommand("mgfx_demo_close", closeDemo)
