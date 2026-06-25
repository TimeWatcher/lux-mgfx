if SERVER then return end

MGFX = MGFX or {}

function MGFX._InstallRoundRect(C)
	local M = C.M
	local materials = C.materials
	local forceFallback = C.forceFallback
	local recordDirectImmediate = C.recordDirectImmediate or function() end
	local resolveDrawStyle = C.resolveDrawStyle
	local matOK = C.matOK
	local shadersActive = C.shadersActive or function() return not forceFallback:GetBool() and M.hasShaders() end
	local profiler = C.profiler
	local asColor = C.asColor
	local color01 = C.color01
	local setDrawColor = C.setDrawColor
	local strokeWidthValue = C.strokeWidthValue
	local radiusScalar = C.radiusScalar
	local strokeVisible = C.strokeVisible
	local backdropStyle = C.backdropStyle or function() return nil end
	local glowSoftnessToFalloff = C.glowSoftnessToFalloff
	local FILL_SOLID = C.FILL_SOLID
	local FILL_LINEAR = C.FILL_LINEAR
	local FILL_RADIAL = C.FILL_RADIAL
	local FILL_CONIC = C.FILL_CONIC
	local isCulled = C.isCulled
	local normalizedRotation = C.normalizedRotation
	local bindGradientLut = C.bindGradientLut
	local setupParamMatrix = C.setupParamMatrix
	local setupParamMatrixRaw = C.setupParamMatrixRaw or C.setupParamMatrix
	local setupExtraParams = C.setupExtraParams
	local setupExtraParamsRaw = C.setupExtraParamsRaw or C.setupExtraParams
	local drawTexturedQuad = C.drawTexturedQuad
	local drawTexturedQuadUV = C.drawTexturedQuadUV
	local drawTransformedPoly = C.drawTransformedPoly or surface.DrawPoly
	local withTransform = C.withTransform or function(_, _, _, _, _, fn) return fn() end
	local splitStyleTransform = C.splitStyleTransform or function(style) return nil, style end
	local hasTransform = C.hasTransform or function() return false end
	local drawBlurredQuad = C.drawBlurredQuad
	local beginPanelEffectDraw = assert(C.beginPanelEffectDraw, "MGFX panel effect draw helper unavailable")
	local endPanelEffectBleed = assert(C.endPanelEffectBleed, "MGFX panel bleed end helper unavailable")
	local math_floor = math.floor
	local math_abs = math.abs
	local math_max = math.max
	local math_min = math.min
	local math_rad = math.rad
	local math_cos = math.cos
	local math_sin = math.sin
	local SysTime = SysTime
	local surface_SetDrawColor = surface.SetDrawColor
	local surface_SetMaterial = surface.SetMaterial
	local surface_DrawRect = surface.DrawRect

local drawRoundRectImmediate
local drawRoundRectRaw
local drawRoundRectPrepared

local function profileStart()
	if profiler and profiler.Start then return profiler.Start() end
	return nil
end

local function profileEnd(name, started)
	if profiler and profiler.End then profiler.End(name, started) end
end

local function profileRecord(name, elapsed)
	if elapsed and profiler and profiler.Record then profiler.Record(name, elapsed) end
end

local function finishImmediateProfile(profiling, totalProfile)
	if profiling then profileEnd("round.immediate", totalProfile) end
end

local function glowBiasPads(base, x, y, minPad)
	minPad = minPad or 1
	local pad = math_max(minPad, tonumber(base) or minPad)
	local ox = tonumber(x) or 0
	local oy = tonumber(y) or 0

	return math_max(minPad, pad - ox),
		math_max(minPad, pad - oy),
		math_max(minPad, pad + ox),
		math_max(minPad, pad + oy)
end

local inv255 = 1 / 255

local function roundRectFillParams(mat, fill, fillKind)
	if fillKind == FILL_LINEAR then
		bindGradientLut(mat, fill)
		return fill.x1 or 0, fill.y1 or 0, fill.x2 or 1, fill.y2 or 1
	end
	if fillKind == FILL_RADIAL then
		bindGradientLut(mat, fill)
		return fill.cx or 0.5, fill.cy or 0.5, fill.radius or 0.5, 0
	end
	if fillKind == FILL_CONIC then
		bindGradientLut(mat, fill)
		return fill.cx or 0.5, fill.cy or 0.5, normalizedRotation(fill.rotation), 0
	end
	return 0, 0, 1, 0
end

local function setupRoundRectConstants(mat, w, h, fill, stroke, strokeWidth, radius)
	local colorB = fill.colorB or fill.colorA or color_white
	local fillKind = fill.kind or FILL_SOLID
	local strokePx = stroke and strokeWidth or 0
	if strokePx <= 0 or (stroke.a ~= nil and stroke.a <= 0) then
		strokePx = 0
	elseif strokePx > 255 then
		strokePx = 255
	end

	local r = (colorB.r or 0) * inv255
	local g = (colorB.g or 0) * inv255
	local b = (colorB.b or 0) * inv255
	local a = (colorB.a == nil and 255 or colorB.a) * inv255
	local p0, p1, p2, p3 = roundRectFillParams(mat, fill, fillKind)
	local sr, sg, sb, sa = 0, 0, 0, 0
	if strokePx > 0 then
		sr = (stroke.r or 0) * inv255
		sg = (stroke.g or 0) * inv255
		sb = (stroke.b or 0) * inv255
		sa = (stroke.a == nil and 255 or stroke.a) * inv255
	end

	setupParamMatrixRaw(mat,
		r, g, b, a,
		w, h, strokePx + fillKind * 256, radius,
		p0, p1, p2, p3,
		sr, sg, sb, sa
	)
end

local function profileEndBase(kind, started)
	if not started then return end
	local elapsed = (SysTime() - started) * 1000
	if profiler and profiler.Record then
		profiler.Record("round.base", elapsed)
		if kind then profiler.Record(kind, elapsed) end
		return
	end

	local times = M.stats.profileTimes
	if not times then return end
	times["round.base"] = (times["round.base"] or 0) + elapsed
	if kind then times[kind] = (times[kind] or 0) + elapsed end
end

local function drawSolidRectFast(x, y, w, h, fill)
	local color = fill.colorA or color_white
	surface_SetDrawColor(color.r or 255, color.g or 255, color.b or 255, color.a == nil and 255 or color.a)
	surface_DrawRect(x, y, w, h)
	M.stats.draws = M.stats.draws + 1
end

local function drawSolidRoundFast(x, y, w, h, radiusValue, fill)
	local mat = materials.roundrect_solid
	if not matOK(mat) then return false end

	local profiling = profiler and profiler.IsActive and profiler.IsActive()
	local setupProfile = profiling and profileStart() or nil
	local color = fill.colorA or color_white
	setupParamMatrixRaw(mat,
		(color.r or 0) * inv255,
		(color.g or 0) * inv255,
		(color.b or 0) * inv255,
		(color.a == nil and 255 or color.a) * inv255,
		w, h, 0, radiusValue,
		0, 0, 1, 0,
		0, 0, 0, 0
	)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	if profiling then profileEnd("round.fast.solidRound.setup", setupProfile) end
	local drawProfile = profiling and profileStart() or nil
	drawTexturedQuad(x, y, w, h, mat)
	if profiling then profileEnd("round.fast.solidRound.draw", drawProfile) end
	return true
end

local transparentFillColor = Color(0, 0, 0, 0)
local transparentFill = {kind = FILL_SOLID, colorA = transparentFillColor, colorB = transparentFillColor}
local emptyRoundRectStyle = {}
local solidFillScratch = {kind = FILL_SOLID, colorA = color_white, colorB = color_white}
local fallbackRoundRectVerts = {}
local fallbackStrokeVerts = {{}, {}, {}, {}}
local roundRaw = {}
local defaultInnerGlowColor = Color(76, 190, 255, 34)
local defaultOuterGlowColor = Color(76, 190, 255, 88)
local defaultShadowColor = Color(0, 0, 0, 132)
local defaultInnerGlowFalloff = glowSoftnessToFalloff(0.55)
local defaultOuterGlowFalloff = glowSoftnessToFalloff(0.54)
local defaultShadowFalloff = glowSoftnessToFalloff(0.62)
function roundRaw.effectExtent(width, falloff, spread, defaultWidth)
	width = math_max(0.001, tonumber(width) or defaultWidth or 18)
	falloff = math_max(0.35, tonumber(falloff) or 1.9)
	local sigma = math_max(width / math.sqrt(falloff) * 0.72, 0.35)
	local tail = sigma * 3.72
	return math_max(1, tonumber(spread) or width, tail)
end
local defaultOuterGlowExtent = roundRaw.effectExtent(18, defaultOuterGlowFalloff, 18, 18)
local defaultOuterGlowCullSpread = defaultOuterGlowExtent
local defaultShadowExtent = roundRaw.effectExtent(12, defaultShadowFalloff, 12, 12)
local defaultShadowCullSpread = 4 + defaultShadowExtent

local function hotFillFromStyle(fill, fallback)
	if istable(fill) then
		local kind = fill.kind
		if kind == FILL_SOLID or kind == FILL_LINEAR or kind == FILL_RADIAL or kind == FILL_CONIC then return fill end
		if kind ~= nil then
			solidFillScratch.colorA = transparentFillColor
			solidFillScratch.colorB = transparentFillColor
			solidFillScratch._mgfxFillVisible = false
			return solidFillScratch
		end
		if fill.r ~= nil and fill.g ~= nil and fill.b ~= nil then
			solidFillScratch.colorA = fill
			solidFillScratch.colorB = fill
			solidFillScratch._mgfxFillVisible = fill.a == nil or fill.a > 0
			return solidFillScratch
		end
	end

	local color = asColor(fill, fallback or color_white)
	solidFillScratch.colorA = color
	solidFillScratch.colorB = color
	solidFillScratch._mgfxFillVisible = color.a == nil or color.a > 0
	return solidFillScratch
end

local function hotFillVisible(fill)
	if fill == nil then return false end
	if not istable(fill) then return true end
	if fill.r ~= nil and fill.g ~= nil and fill.b ~= nil then
		return fill.a == nil or fill.a > 0
	end
	local visible = fill._mgfxFillVisible
	if visible ~= nil then return visible end
	local kind = fill.kind
	if kind == FILL_SOLID then
		local colorA = fill.colorA or color_white
		local colorB = fill.colorB or colorA
		return (colorA.a == nil or colorA.a > 0) or (colorB.a == nil or colorB.a > 0)
	end
	if kind == FILL_LINEAR or kind == FILL_RADIAL or kind == FILL_CONIC then
		return fill.stops ~= nil
			or (fill.colorA ~= nil and (fill.colorA.a == nil or fill.colorA.a > 0))
			or (fill.colorB ~= nil and (fill.colorB.a == nil or fill.colorB.a > 0))
	end
	return false
end

local function roundRectRadiusScalar(radius, w, h)
	if not istable(radius) or (radius.r ~= nil and radius.g ~= nil and radius.b ~= nil) then
		local value = tonumber(radius) or 0
		if value <= 0 then return 0 end
		local maxRadius = math_min(math_max(0, tonumber(w) or 0), math_max(0, tonumber(h) or 0)) * 0.5
		if maxRadius <= 0 then return 0 end
		if value > maxRadius then return maxRadius end
		return value
	end

	return radiusScalar(radius, w, h)
end

local function clearVerts(verts)
	for i = #verts, 1, -1 do
		verts[i] = nil
	end
end

local function appendFallbackPoint(verts, x, y)
	local i = #verts + 1
	local v = verts[i] or {}
	verts[i] = v
	v.x = x
	v.y = y
	v.u = nil
	v.v = nil
	v.color = nil
end

local function appendFallbackCorner(verts, cx, cy, radius, fromDeg, toDeg, steps)
	for i = 0, steps do
		local t = i / steps
		local a = math_rad(fromDeg + (toDeg - fromDeg) * t)
		appendFallbackPoint(verts, cx + math_cos(a) * radius, cy + math_sin(a) * radius)
	end
end

local function fallbackRoundRectPoints(x, y, w, h, radius)
	local verts = fallbackRoundRectVerts
	clearVerts(verts)

	if w <= 0 or h <= 0 then return verts end
	radius = math_min(math_max(0, tonumber(radius) or 0), w * 0.5, h * 0.5)
	if radius <= 0.25 then
		appendFallbackPoint(verts, x, y)
		appendFallbackPoint(verts, x + w, y)
		appendFallbackPoint(verts, x + w, y + h)
		appendFallbackPoint(verts, x, y + h)
		return verts
	end

	local steps = math.Clamp(math_floor(radius / 5), 4, 10)
	appendFallbackCorner(verts, x + w - radius, y + radius, radius, -90, 0, steps)
	appendFallbackCorner(verts, x + w - radius, y + h - radius, radius, 0, 90, steps)
	appendFallbackCorner(verts, x + radius, y + h - radius, radius, 90, 180, steps)
	appendFallbackCorner(verts, x + radius, y + radius, radius, 180, 270, steps)
	return verts
end

local function drawFallbackStroke(points, color, width)
	width = math_max(1, tonumber(width) or 1)
	setDrawColor(color)

	for i = 1, #points do
		local a = points[i]
		local b = points[i % #points + 1]
		local dx, dy = b.x - a.x, b.y - a.y
		local len = math_max(0.0001, (dx * dx + dy * dy) ^ 0.5)
		local nx, ny = -dy / len * width * 0.5, dx / len * width * 0.5
		local verts = fallbackStrokeVerts
		verts[1].x, verts[1].y = a.x + nx, a.y + ny
		verts[2].x, verts[2].y = b.x + nx, b.y + ny
		verts[3].x, verts[3].y = b.x - nx, b.y - ny
		verts[4].x, verts[4].y = a.x - nx, a.y - ny
		drawTransformedPoly(verts)
		M.stats.draws = M.stats.draws + 1
	end
end

local function drawRoundRectFallbackPrepared(x, y, w, h, radius, fill, hasFill, stroke, strokeWidth, hasStroke)
	M.stats.fallbacks = M.stats.fallbacks + 1
	radius = radius or 0
	if hasTransform() then
		local points = fallbackRoundRectPoints(x, y, w, h, radius)
		if hasFill then
			setDrawColor(fill.colorA or color_white)
			drawTransformedPoly(points)
			M.stats.draws = M.stats.draws + 1
		end

		if hasStroke then
			drawFallbackStroke(points, stroke, math_max(1, math_floor(strokeWidth)))
		end
		return
	end

	if hasFill then
		draw.RoundedBox(math_floor(tonumber(radius) or 0), x, y, w, h, fill.colorA or color_white)
		M.stats.draws = M.stats.draws + 1
	end

	if hasStroke then
		setDrawColor(stroke)
		surface.DrawOutlinedRect(x, y, w, h, math_max(1, math_floor(strokeWidth)))
		M.stats.draws = M.stats.draws + 1
	end
end

local function drawRoundRectFallbackRaw(x, y, w, h, radius, fillInput, stroke, strokeWidthInput)
	local fill = hotFillFromStyle(fillInput)
	local strokeWidth = 0
	local hasStroke = false
	if stroke then
		strokeWidth = strokeWidthValue(strokeWidthInput, 0)
		hasStroke = strokeWidth > 0 and (stroke.a == nil or stroke.a > 0)
	end
	return drawRoundRectFallbackPrepared(x, y, w, h, radius, fill, hotFillVisible(fill), stroke, strokeWidth, hasStroke)
end

function roundRaw.innerGlow(glow)
	if not glow then
		return false, 0, 0, 0, 0, 0, 0, 1
	end

	if glow == true then
		return true,
			(defaultInnerGlowColor.r or 0) * inv255,
			(defaultInnerGlowColor.g or 0) * inv255,
			(defaultInnerGlowColor.b or 0) * inv255,
			(defaultInnerGlowColor.a == nil and 255 or defaultInnerGlowColor.a) * inv255,
			7,
			1,
			defaultInnerGlowFalloff
	end

	if istable(glow) and glow.r and glow.g and glow.b then
		return (glow.a == nil or glow.a > 0),
			(glow.r or 0) * inv255,
			(glow.g or 0) * inv255,
			(glow.b or 0) * inv255,
			(glow.a == nil and 255 or glow.a) * inv255,
			7,
			1,
			defaultInnerGlowFalloff
	end

	if not istable(glow) then
		return false, 0, 0, 0, 0, 0, 0, 1
	end

	local color = asColor(glow.color or glow.tint, defaultInnerGlowColor)
	local width = math_max(1, tonumber(glow.size) or tonumber(glow.width) or 7)
	local strength = tonumber(glow.opacity) or tonumber(glow.strength) or 1
	local falloff = tonumber(glow.falloff) or glowSoftnessToFalloff(glow.softness, 0.55)
	local alpha = (color.a == nil and 255 or color.a) * inv255
	return alpha > 0 and strength > 0,
		(color.r or 0) * inv255,
		(color.g or 0) * inv255,
		(color.b or 0) * inv255,
		alpha,
		width,
		strength,
		falloff
end

function roundRaw.outerGlow(glow)
	if not glow then
		return false, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0
	end

	if glow == true then
		return true,
			(defaultOuterGlowColor.r or 0) * inv255,
			(defaultOuterGlowColor.g or 0) * inv255,
			(defaultOuterGlowColor.b or 0) * inv255,
			(defaultOuterGlowColor.a == nil and 255 or defaultOuterGlowColor.a) * inv255,
			0,
			0,
			18,
			18,
			0,
			1,
			defaultOuterGlowFalloff,
			defaultOuterGlowExtent,
			defaultOuterGlowCullSpread
	end

	if istable(glow) and glow.r and glow.g and glow.b then
		local width = 18
		local falloff = defaultOuterGlowFalloff
		local extent = roundRaw.effectExtent(width, falloff, width, 18)
		local alpha = (glow.a == nil and 255 or glow.a) * inv255
		return alpha > 0,
			(glow.r or 0) * inv255,
			(glow.g or 0) * inv255,
			(glow.b or 0) * inv255,
			alpha,
			0,
			0,
			width,
			width,
			0,
			1,
			falloff,
			extent,
			extent
	end

	if not istable(glow) then
		return false, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0
	end

	local offset = istable(glow.offset) and glow.offset or nil
	local ox = tonumber(glow.x) or tonumber(glow.offsetX) or tonumber(glow.dx) or tonumber(glow[1]) or (offset and (tonumber(offset.x) or tonumber(offset[1]))) or 0
	local oy = tonumber(glow.y) or tonumber(glow.offsetY) or tonumber(glow.dy) or tonumber(glow[2]) or (offset and (tonumber(offset.y) or tonumber(offset[2]))) or 0
	local width = math_max(1, tonumber(glow.size) or tonumber(glow.width) or tonumber(glow.blur) or tonumber(glow.radius) or tonumber(glow.spread) or 18)
	local spread = math_max(1, tonumber(glow.spread) or width)
	local grow = math_max(0, tonumber(glow.grow) or tonumber(glow.expand) or tonumber(glow.shapeSpread) or 0)
	local strength = tonumber(glow.opacity) or tonumber(glow.strength) or 1
	local falloff = tonumber(glow.falloff) or glowSoftnessToFalloff(glow.softness, 0.54)
	local extent = roundRaw.effectExtent(width, falloff, spread, 18)
	local color = asColor(glow.color or glow.tint, defaultOuterGlowColor)
	local alpha = (color.a == nil and 255 or color.a) * inv255
	return alpha > 0 and strength > 0,
		(color.r or 0) * inv255,
		(color.g or 0) * inv255,
		(color.b or 0) * inv255,
		alpha,
		ox,
		oy,
		width,
		spread,
		grow,
		strength,
		falloff,
		extent,
		math_abs(ox) + math_abs(oy) + extent + grow
end

function roundRaw.shadow(shadow)
	if not shadow then
		return false, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0
	end

	if shadow == true then
		return true,
			(defaultShadowColor.r or 0) * inv255,
			(defaultShadowColor.g or 0) * inv255,
			(defaultShadowColor.b or 0) * inv255,
			(defaultShadowColor.a == nil and 255 or defaultShadowColor.a) * inv255,
			0,
			4,
			12,
			12,
			0,
			1,
			defaultShadowFalloff,
			defaultShadowExtent,
			defaultShadowCullSpread
	end

	if istable(shadow) and shadow.r and shadow.g and shadow.b then
		local width = 12
		local falloff = defaultShadowFalloff
		local extent = roundRaw.effectExtent(width, falloff, width, 12)
		local alpha = (shadow.a == nil and 255 or shadow.a) * inv255
		return alpha > 0,
			(shadow.r or 0) * inv255,
			(shadow.g or 0) * inv255,
			(shadow.b or 0) * inv255,
			alpha,
			0,
			4,
			width,
			width,
			0,
			1,
			falloff,
			extent,
			4 + extent
	end

	if not istable(shadow) then
		local width = math_max(0.001, tonumber(shadow) or 12)
		local falloff = defaultShadowFalloff
		local extent = roundRaw.effectExtent(width, falloff, math_max(1, width), 12)
		return true,
			(defaultShadowColor.r or 0) * inv255,
			(defaultShadowColor.g or 0) * inv255,
			(defaultShadowColor.b or 0) * inv255,
			(defaultShadowColor.a == nil and 255 or defaultShadowColor.a) * inv255,
			0,
			4,
			width,
			math_max(1, width),
			0,
			1,
			falloff,
			extent,
			4 + extent
	end

	local offset = istable(shadow.offset) and shadow.offset or nil
	local ox = tonumber(shadow.x) or tonumber(shadow.offsetX) or tonumber(shadow.dx) or tonumber(shadow[1]) or (offset and (tonumber(offset.x) or tonumber(offset[1]))) or 0
	local oy = tonumber(shadow.y) or tonumber(shadow.offsetY) or tonumber(shadow.dy) or tonumber(shadow[2]) or (offset and (tonumber(offset.y) or tonumber(offset[2]))) or 4
	local width = math_max(0.001, tonumber(shadow.blur) or tonumber(shadow.radius) or tonumber(shadow.size) or tonumber(shadow.width) or 12)
	local grow = math_max(0, tonumber(shadow.spread) or tonumber(shadow.grow) or tonumber(shadow.expand) or tonumber(shadow.shapeSpread) or 0)
	local spread = math_max(1, tonumber(shadow.extent) or tonumber(shadow.padding) or width)
	local strength = tonumber(shadow.opacity) or tonumber(shadow.strength) or 1
	local falloff = tonumber(shadow.falloff) or glowSoftnessToFalloff(shadow.softness, 0.62)
	local extent = roundRaw.effectExtent(width, falloff, spread, 12)
	local color = asColor(shadow.color or shadow.tint, defaultShadowColor)
	local alpha = (color.a == nil and 255 or color.a) * inv255
	return alpha > 0 and strength > 0,
		(color.r or 0) * inv255,
		(color.g or 0) * inv255,
		(color.b or 0) * inv255,
		alpha,
		ox,
		oy,
		width,
		spread,
		grow,
		strength,
		falloff,
		extent,
		math_abs(ox) + math_abs(oy) + extent + grow
end

local function patternStyle(pattern)
	if not pattern then return nil end
	if pattern == true then return M.StripePattern(Color(255, 255, 255, 20), 10, 2, 135) end
	if istable(pattern) and (pattern.kind == "stripe" or pattern.kind == "smoke") then return pattern end
	if istable(pattern) then return M.StripePattern(pattern) end
	return nil
end

local function patternOffset(pattern)
	local offset = tonumber(pattern.offset) or 0
	local speed = tonumber(pattern.speed) or 0
	if speed ~= 0 and isfunction(RealTime) then offset = offset + RealTime() * speed end
	return offset
end

local function setupPatternConstants(mat, w, h, radius, pattern)
	local color = asColor(pattern.color or pattern.tint, Color(255, 255, 255, 24))
	local r, g, b, a = color01(color)
	local angle = math_rad(tonumber(pattern.angle) or 135)
	local smoke = pattern.kind == "smoke"
	local pz, pw, ox, oy, oz, ow
	if smoke then
		pz = math_max(1, tonumber(pattern.scale) or 140)
		pw = math.Clamp(tonumber(pattern.density) or 0.48, 0, 1)
		ox, oy, oz, ow = patternOffset(pattern), 1, math_max(0.001, tonumber(pattern.softness) or 0.3), math_max(0, tonumber(pattern.warp) or 0.85)
	else
		pz = math_max(1, tonumber(pattern.spacing) or 12)
		pw = math_max(0.25, tonumber(pattern.width) or 2)
		ox, oy, oz, ow = patternOffset(pattern), 0, 0, 0
	end
	setupParamMatrix(mat,
		r, g, b, a,
		w, h, smoke and (tonumber(pattern.seed) or 0) or 0, math_max(0, tonumber(radius) or 0),
		math_cos(angle), math_sin(angle), pz, pw,
		ox, oy, oz, ow
	)
end

local function drawRoundRectPatternPrepared(x, y, w, h, radius, spec)
	if not spec then return end
	if not shadersActive() or not matOK(materials.roundrect_pattern) then return end

	local color = spec.color or spec.tint
	if color and (color.a or 255) <= 0 then return end

	local mat = materials.roundrect_pattern
	setupPatternConstants(mat, w, h, roundRectRadiusScalar(radius, w, h), spec)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	drawTexturedQuad(x, y, w, h, mat)
end

local function drawRoundRectPattern(x, y, w, h, radius, pattern)
	return drawRoundRectPatternPrepared(x, y, w, h, radius, patternStyle(pattern))
end

function roundRaw.drawInnerGlow(x, y, w, h, radius, enabled, gr, gg, gb, ga, glowWidth, glowStrength, glowFalloff)
	if not enabled or ga <= 0 or glowStrength <= 0 then return false end
	if not shadersActive() or not matOK(materials.roundrect_innerglow) then return end

	local mat = materials.roundrect_innerglow
	setupParamMatrixRaw(mat,
		gr, gg, gb, ga,
		w, h, 0, roundRectRadiusScalar(radius, w, h),
		glowWidth,
		glowStrength,
		glowFalloff,
		0,
		0, 0, 0, 0
	)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	drawTexturedQuad(x, y, w, h, mat)
	return true
end

local function drawRoundRectInnerGlow(x, y, w, h, radius, glow)
	local enabled, gr, gg, gb, ga, glowWidth, glowStrength, glowFalloff = roundRaw.innerGlow(glow)
	return roundRaw.drawInnerGlow(x, y, w, h, radius, enabled, gr, gg, gb, ga, glowWidth, glowStrength, glowFalloff)
end

local function radiusWithGrow(radius, grow)
	grow = math_max(0, tonumber(grow) or 0)
	if grow <= 0 then return radius end
	if istable(radius) and not (radius.r and radius.g and radius.b) then
		return {
			tl = math_max(0, tonumber(radius.tl) or tonumber(radius[1]) or 0) + grow,
			tr = math_max(0, tonumber(radius.tr) or tonumber(radius[2]) or tonumber(radius.tl) or tonumber(radius[1]) or 0) + grow,
			br = math_max(0, tonumber(radius.br) or tonumber(radius[3]) or tonumber(radius.tr) or tonumber(radius[2]) or tonumber(radius.tl) or tonumber(radius[1]) or 0) + grow,
			bl = math_max(0, tonumber(radius.bl) or tonumber(radius[4]) or tonumber(radius.br) or tonumber(radius[3]) or tonumber(radius.tr) or tonumber(radius[2]) or tonumber(radius.tl) or tonumber(radius[1]) or 0) + grow,
		}
	end
	return (tonumber(radius) or 0) + grow
end

function roundRaw.drawShadowOuter(
	x, y, w, h, radius,
	hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowExtent, shadowGrow, shadowStrength, shadowFalloff,
	hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerExtent, outerGrow, outerStrength, outerFalloff
)
	local profiling = profiler and profiler.IsActive and profiler.IsActive()
	hasShadow = hasShadow and sa > 0 and shadowStrength > 0
	hasOuter = hasOuter and oa > 0 and outerStrength > 0
	if not hasShadow and not hasOuter then
		return false
	end
	if not shadersActive() or not matOK(materials.roundrect_shadow_outer) then
		return false
	end

	local setupProfile = profiling and profileStart() or nil

	shadowGrow = math_max(0, shadowGrow or 0)
	outerGrow = math_max(0, outerGrow or 0)
	shadowX = shadowX or 0
	shadowY = shadowY or 0
	outerX = outerX or 0
	outerY = outerY or 0
	shadowWidth = math_max(0.001, shadowWidth or 1)
	outerWidth = math_max(0.001, outerWidth or 1)
	shadowExtent = math_max(1, shadowExtent or shadowWidth)
	outerExtent = math_max(1, outerExtent or outerWidth)
	shadowStrength = math_max(0, shadowStrength or 0)
	outerStrength = math_max(0, outerStrength or 0)
	shadowFalloff = math_max(0.001, shadowFalloff or 1)
	outerFalloff = math_max(0.001, outerFalloff or 1)

	local shadowGw = w + shadowGrow * 2
	local shadowGh = h + shadowGrow * 2
	local shadowShapeX = x + shadowX - shadowGrow
	local shadowShapeY = y + shadowY - shadowGrow
	local shadowDrawX = shadowShapeX - shadowExtent
	local shadowDrawY = shadowShapeY - shadowExtent
	local shadowDrawW = shadowGw + shadowExtent * 2
	local shadowDrawH = shadowGh + shadowExtent * 2

	local outerGw = w + outerGrow * 2
	local outerGh = h + outerGrow * 2
	local outerLeft, outerTop, outerRight, outerBottom = glowBiasPads(outerExtent, outerX, outerY)
	local outerShapeX = x - outerGrow
	local outerShapeY = y - outerGrow
	local outerDrawX = outerShapeX - outerLeft
	local outerDrawY = outerShapeY - outerTop
	local outerDrawW = outerGw + outerLeft + outerRight
	local outerDrawH = outerGh + outerTop + outerBottom

	local sx, sy, ex, ey
	if hasShadow then
		sx = shadowDrawX
		sy = shadowDrawY
		ex = shadowDrawX + shadowDrawW
		ey = shadowDrawY + shadowDrawH
	end
	if hasOuter then
		if sx == nil then
			sx = outerDrawX
			sy = outerDrawY
			ex = outerDrawX + outerDrawW
			ey = outerDrawY + outerDrawH
		else
			sx = math_min(sx, outerDrawX)
			sy = math_min(sy, outerDrawY)
			ex = math_max(ex, outerDrawX + outerDrawW)
			ey = math_max(ey, outerDrawY + outerDrawH)
		end
	end
	local sw = ex - sx
	local sh = ey - sy
	local mat = materials.roundrect_shadow_outer

	setupParamMatrixRaw(mat,
		sw, sh, 0, 0,
		hasShadow and sr or 0,
		hasShadow and sg or 0,
		hasShadow and sb or 0,
		hasShadow and sa or 0,
		shadowShapeX - sx, shadowShapeY - sy, shadowGw, shadowGh,
		roundRectRadiusScalar(radiusWithGrow(radius, shadowGrow), shadowGw, shadowGh),
		hasShadow and shadowWidth or 1,
		hasShadow and shadowStrength or 0,
		hasShadow and shadowFalloff or 1
	)
	setupExtraParamsRaw(mat,
		hasOuter and orr or 0,
		hasOuter and og or 0,
		hasOuter and ob or 0,
		hasOuter and oa or 0,
		outerShapeX - sx, outerShapeY - sy, outerGw, outerGh,
		roundRectRadiusScalar(radiusWithGrow(radius, outerGrow), outerGw, outerGh),
		hasOuter and outerWidth or 1,
		hasOuter and outerStrength or 0,
		hasOuter and outerFalloff or 1,
		0, 0, 0, 0
	)
	if profiling then profileEnd("round.shadowOuter.setup", setupProfile) end

	local bleedProfile = profiling and profileStart() or nil
	local bleedToken = beginPanelEffectDraw(sx, sy, sw, sh)
	if profiling then profileEnd("round.shadowOuter.bleedBegin", bleedProfile) end

	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	local drawProfile = profiling and profileStart() or nil
	drawTexturedQuad(sx, sy, sw, sh, mat)
	if profiling then profileEnd("round.shadowOuter.draw", drawProfile) end

	bleedProfile = profiling and profileStart() or nil
	endPanelEffectBleed(bleedToken)
	if profiling then profileEnd("round.shadowOuter.bleedEnd", bleedProfile) end
	return true
end

function roundRaw.drawFused(
	x, y, w, h, radius, fill, stroke, strokeWidth, radiusValue,
	hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowExtent, shadowGrow, shadowStrength, shadowFalloff,
	hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerExtent, outerGrow, outerStrength, outerFalloff
)
	if w <= 0 or h <= 0 then return false end
	if not drawTexturedQuadUV then return false end
	if not shadersActive() or not matOK(materials.roundrect_fused) then return false end

	hasShadow = hasShadow and sa > 0 and shadowStrength > 0
	hasOuter = hasOuter and oa > 0 and outerStrength > 0
	if not hasShadow and not hasOuter then return false end

	local profiling = profiler and profiler.IsActive and profiler.IsActive()
	local setupProfile = profiling and profileStart() or nil

	shadowX = shadowX or 0
	shadowY = shadowY or 0
	outerX = outerX or 0
	outerY = outerY or 0
	local sx = x
	local sy = y
	local ex = x + w
	local ey = y + h

	shadowGrow = hasShadow and math_max(0, shadowGrow or 0) or 0
	shadowWidth = hasShadow and math_max(0.001, shadowWidth or 1) or 1
	shadowFalloff = hasShadow and math_max(0.001, shadowFalloff or 1) or 1
	if hasShadow then
		local spread = math_max(1, shadowExtent or shadowWidth)
		local drawX = x + shadowX - shadowGrow - spread
		local drawY = y + shadowY - shadowGrow - spread
		local drawW = w + shadowGrow * 2 + spread * 2
		local drawH = h + shadowGrow * 2 + spread * 2
		sx = math_min(sx, drawX)
		sy = math_min(sy, drawY)
		ex = math_max(ex, drawX + drawW)
		ey = math_max(ey, drawY + drawH)
	end

	outerGrow = hasOuter and math_max(0, outerGrow or 0) or 0
	outerWidth = hasOuter and math_max(0.001, outerWidth or 1) or 1
	outerFalloff = hasOuter and math_max(0.001, outerFalloff or 1) or 1
	if hasOuter then
		local spread = math_max(1, outerExtent or outerWidth)
		local left, top, right, bottom = glowBiasPads(spread, outerX, outerY)
		local drawX = x - outerGrow - left
		local drawY = y - outerGrow - top
		local drawW = w + outerGrow * 2 + left + right
		local drawH = h + outerGrow * 2 + top + bottom
		sx = math_min(sx, drawX)
		sy = math_min(sy, drawY)
		ex = math_max(ex, drawX + drawW)
		ey = math_max(ey, drawY + drawH)
	end

	local sw = ex - sx
	local sh = ey - sy
	if sw <= 0 or sh <= 0 then
		if profiling then profileEnd("round.fused.setup", setupProfile) end
		return false
	end

	local mat = materials.roundrect_fused
	setupRoundRectConstants(mat, w, h, fill, stroke, strokeWidth, radiusValue or roundRectRadiusScalar(radius, w, h))
	setupExtraParamsRaw(mat,
		hasShadow and sr or 0,
		hasShadow and sg or 0,
		hasShadow and sb or 0,
		hasShadow and (sa * shadowStrength) or 0,
		shadowX, shadowY, shadowGrow, shadowWidth,
		hasOuter and orr or 0,
		hasOuter and og or 0,
		hasOuter and ob or 0,
		hasOuter and (oa * outerStrength) or 0,
		shadowFalloff, outerGrow, outerWidth, outerFalloff
	)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	if profiling then profileEnd("round.fused.setup", setupProfile) end

	local bleedProfile = profiling and profileStart() or nil
	local bleedToken = beginPanelEffectDraw(sx, sy, sw, sh)
	if profiling then profileEnd("round.fused.bleedBegin", bleedProfile) end

	local u0 = (sx - x) / w
	local v0 = (sy - y) / h
	local u1 = (ex - x) / w
	local v1 = (ey - y) / h
	local drawProfile = profiling and profileStart() or nil
	drawTexturedQuadUV(sx, sy, sw, sh, u0, v0, u1, v1, mat)
	if profiling then profileEnd("round.fused.draw", drawProfile) end

	bleedProfile = profiling and profileStart() or nil
	endPanelEffectBleed(bleedToken)
	if profiling then profileEnd("round.fused.bleedEnd", bleedProfile) end
	return true
end

local function drawRoundRectOuterGlow(x, y, w, h, radius, glow)
	local hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, _, outerGrow, outerStrength, outerFalloff, outerExtent = roundRaw.outerGlow(glow)
	return roundRaw.drawShadowOuter(
		x, y, w, h, radius,
		false, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1,
		hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerExtent, outerGrow, outerStrength, outerFalloff
	)
end

local drawRoundRectFillPass

local backdropTintScratch = Color(0, 0, 0, 0)
local backdropFillScratch = {kind = FILL_SOLID, colorA = backdropTintScratch, colorB = backdropTintScratch, _mgfxFillVisible = false}

local function backdropTintColor(spec)
	if not spec or not spec.tint then return nil end
	local tint = spec.tint
	local alpha = (tint.a == nil and 255 or tint.a) * (spec.opacity == nil and 1 or spec.opacity)
	if alpha <= 0 then return nil end
	backdropTintScratch.r = tint.r or 0
	backdropTintScratch.g = tint.g or 0
	backdropTintScratch.b = tint.b or 0
	backdropTintScratch.a = math_floor(math.Clamp(alpha, 0, 255) + 0.5)
	return backdropTintScratch
end

local function drawRoundRectBackdrop(x, y, w, h, radius, spec)
	if not spec then return nil end
	local pad = math_max(0, tonumber(spec.padding) or 0)
	local bx = x - pad
	local by = y - pad
	local bw = w + pad * 2
	local bh = h + pad * 2
	local br = radiusWithGrow(radius, pad)
	local tint = backdropTintColor(spec)
	local blurred = false

	if spec.blur > 0 and shadersActive() and matOK(materials.roundrect_blur) and drawBlurredQuad then
		drawBlurredQuad(materials.roundrect_blur, bx, by, bw, bh, roundRectRadiusScalar(br, bw, bh), spec.blur, tint)
		blurred = true
	end

	if tint and not blurred then
		backdropFillScratch._mgfxFillVisible = true
		drawRoundRectFillPass(bx, by, bw, bh, br, backdropFillScratch)
	end

	return spec
end

drawRoundRectFillPass = function(x, y, w, h, radius, fill)
	local mat = materials.roundrect
	setupRoundRectConstants(mat, w, h, fill, nil, 0, roundRectRadiusScalar(radius, w, h))
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	drawTexturedQuad(x, y, w, h, mat)
end

local function drawRoundRectStrokePass(x, y, w, h, radius, stroke, strokeWidth)
	if not strokeVisible(stroke, strokeWidth) then return end
	if shadersActive() and matOK(materials.roundrect_stroke) then
		local mat = materials.roundrect_stroke
		local r, g, b, a = color01(stroke)
		setupParamMatrix(mat,
			r, g, b, a,
			w, h, math_max(0, strokeWidthValue(strokeWidth, 0)), roundRectRadiusScalar(radius, w, h),
			0, 0, 1, 0,
			0, 0, 0, 0
		)
		surface_SetMaterial(mat)
		surface_SetDrawColor(255, 255, 255, 255)
		drawTexturedQuad(x, y, w, h, mat)
		return
	end

	local mat = materials.roundrect
	setupRoundRectConstants(mat, w, h, transparentFill, stroke, strokeWidth, roundRectRadiusScalar(radius, w, h))
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	drawTexturedQuad(x, y, w, h, mat)
end

function roundRaw.drawFxPass(x, y, w, h, radius, fill, stroke, strokeWidth, innerEnabled, gr, gg, gb, ga, glowWidth, glowStrength, glowFalloff)
	if not setupExtraParams or not matOK(materials.roundrect_fx) then return false end

	local profiling = profiler and profiler.IsActive and profiler.IsActive()
	local setupProfile = profiling and profileStart() or nil
	local mat = materials.roundrect_fx
	if not innerEnabled then
		gr, gg, gb, ga = 0, 0, 0, 0
		glowWidth, glowStrength, glowFalloff = 0, 0, 1
	else
		glowWidth = math_max(0.001, tonumber(glowWidth) or 8)
		glowStrength = math_max(0, tonumber(glowStrength) or 1)
		glowFalloff = math_max(0.001, tonumber(glowFalloff) or 1.65)
	end

	if not setupExtraParamsRaw(mat,
		gr, gg, gb, ga,
		glowWidth, glowStrength, glowFalloff, 0,
		0, 0, 0, 0,
		0, 0, 0, 0
	) then
		if profiling then profileEnd("round.base.fx.setup", setupProfile) end
		return false
	end

	setupRoundRectConstants(mat, w, h, fill, stroke, strokeWidth, roundRectRadiusScalar(radius, w, h))
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	if profiling then profileEnd("round.base.fx.setup", setupProfile) end
	local drawProfile = profiling and profileStart() or nil
	drawTexturedQuad(x, y, w, h, mat)
	if profiling then profileEnd("round.base.fx.draw", drawProfile) end
	return true
end

drawRoundRectPrepared = function(
	x, y, w, h, radius,
	fill, hasFill,
	stroke, strokeWidth, hasStroke,
	hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread,
	hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread,
	hasInner, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff,
	backdropSpec, patternSpec,
	profiling, totalProfile, stageProfile
)
	if profiling == nil then
		profiling = profiler and profiler.IsActive and profiler.IsActive()
		totalProfile = profiling and profileStart() or nil
		stageProfile = totalProfile
	end

	local shaderReady = shadersActive()
	local transformActive = hasTransform()
	if radius == nil then radius = 0 end
	fill = fill or transparentFill
	hasFill = hasFill == true
	hasStroke = hasStroke == true
	hasShadow = hasShadow == true
	hasOuter = hasOuter == true
	hasInner = hasInner == true

	local noEffects = not hasShadow
		and not hasOuter
		and not hasInner
		and backdropSpec == nil
		and patternSpec == nil

	if noEffects
		and not hasStroke
		and not transformActive then
		if hasFill and fill.kind == FILL_SOLID then
			local radiusValue = roundRectRadiusScalar(radius, w, h)
			if profiling then
				local now = SysTime()
				profileRecord("round.prepare", (now - stageProfile) * 1000)
				stageProfile = now
			end
			if isCulled(x, y, w, h) then
				if profiling then
					profileRecord("round.cull", (SysTime() - stageProfile) * 1000)
				end
				finishImmediateProfile(profiling, totalProfile)
				return
			end
			if profiling then
				local now = SysTime()
				profileRecord("round.cull", (now - stageProfile) * 1000)
				stageProfile = now
			end
			if radiusValue <= 0 then
				local drawProfile = profiling and profileStart() or nil
				drawSolidRectFast(x, y, w, h, fill)
				if profiling then profileEnd("round.fast.solidRect", drawProfile) end
				finishImmediateProfile(profiling, totalProfile)
				return
			end
			local drawProfile = profiling and profileStart() or nil
			if shaderReady and drawSolidRoundFast(x, y, w, h, radiusValue, fill) then
				if profiling then
					profileEnd("round.fast.solidRound", drawProfile)
				end
				finishImmediateProfile(profiling, totalProfile)
				return
			end
			if profiling then profileEnd("round.fast.solidRound.miss", drawProfile) end
		end
	end

	if profiling then
		local now = SysTime()
		profileRecord("round.prepare", (now - stageProfile) * 1000)
		stageProfile = now
	end
	local cullSpread = 0
	if shaderReady then
		if hasShadow then
			cullSpread = math_max(cullSpread, shadowCullSpread or 0)
		end
		if hasOuter then
			cullSpread = math_max(cullSpread, outerCullSpread or 0)
		end
		if backdropSpec then
			cullSpread = math_max(cullSpread, math_max(0, tonumber(backdropSpec.padding) or 0))
		end
	end
	if not transformActive and isCulled(x - cullSpread, y - cullSpread, w + cullSpread * 2, h + cullSpread * 2) then
		if profiling then profileRecord("round.cull", (SysTime() - stageProfile) * 1000) end
		finishImmediateProfile(profiling, totalProfile)
		return
	end
	if profiling then
		local now = SysTime()
		profileRecord("round.cull", (now - stageProfile) * 1000)
		stageProfile = now
	end

	if not shaderReady then
		local profile = profiling and profileStart() or nil
		drawRoundRectFallbackPrepared(x, y, w, h, radius, fill, hasFill, stroke, strokeWidth, hasStroke)
		roundRaw.drawInnerGlow(x, y, w, h, radius, hasInner, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff)
		if profiling then
			profileEnd("round.fallback", profile)
		end
		finishImmediateProfile(profiling, totalProfile)
		return
	end

	if profiling then stageProfile = SysTime() end
	if profiling then
		local now = SysTime()
		profileRecord("round.fillPrepare", (now - stageProfile) * 1000)
		stageProfile = now
	end

	local profile
	local canTryFused = backdropSpec == nil
		and patternSpec == nil
		and not hasInner
		and not transformActive
		and (hasFill or hasStroke)
		and (hasShadow or hasOuter)
	if canTryFused then
		profile = profiling and profileStart() or nil
		local radiusValue = roundRectRadiusScalar(radius, w, h)
		if roundRaw.drawFused(
			x, y, w, h, radius, hasFill and fill or transparentFill, stroke, strokeWidth, radiusValue,
			hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowExtent, shadowGrow, shadowStrength, shadowFalloff,
			hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerExtent, outerGrow, outerStrength, outerFalloff
		) then
			if profiling then profileEnd("round.fused", profile) end
			finishImmediateProfile(profiling, totalProfile)
			return
		end
		if profiling then profileEnd("round.fused.miss", profile) end
	end

	if hasShadow or hasOuter then
		local shadowOuterProfile = profiling and profileStart() or nil
		roundRaw.drawShadowOuter(
			x, y, w, h, radius,
			hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowExtent, shadowGrow, shadowStrength, shadowFalloff,
			hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerExtent, outerGrow, outerStrength, outerFalloff
		)
		if profiling then profileEnd("round.shadowOuter", shadowOuterProfile) end
	end

	local backdrop
	if backdropSpec then
		profile = profiling and profileStart() or nil
		backdrop = drawRoundRectBackdrop(x, y, w, h, radius, backdropSpec)
		if profiling then profileEnd("round.backdrop", profile) end
	end

	if backdrop then
		-- Backdrop alone is a valid shape pass; fill/stroke may be fully transparent.
	end

	local effectOnly = not backdrop
		and not hasStroke
		and patternSpec == nil
		and not hasInner
		and (hasShadow or hasOuter)
	if effectOnly and not hasFill then
		finishImmediateProfile(profiling, totalProfile)
		return
	end

	if not backdrop and not hasFill and not hasStroke and patternSpec == nil and not hasInner then
		finishImmediateProfile(profiling, totalProfile)
		return
	end

	local drawFill = hasFill and fill or transparentFill
	local mat = materials.roundrect
	local useLayered = patternSpec ~= nil
	local innerGlowDrawn = false
	if useLayered then
		profile = profiling and profileStart() or nil
		if hasFill then
			drawRoundRectFillPass(x, y, w, h, radius, fill)
		end
		drawRoundRectPatternPrepared(x, y, w, h, radius, patternSpec)
		if hasStroke then
			drawRoundRectStrokePass(x, y, w, h, radius, stroke, strokeWidth)
		end
		if profiling then profileEnd("round.layered", profile) end
	else
		profile = profiling and profileStart() or nil
		local radiusValue = roundRectRadiusScalar(radius, w, h)
		local baseKind
		if drawFill.kind == FILL_LINEAR then
			baseKind = "round.base.gradient"
		elseif hasStroke then
			baseKind = "round.base.stroke"
		elseif radiusValue <= 0 then
			baseKind = "round.base.solidRect"
		else
			baseKind = "round.base.solidRound"
		end
		if hasInner and roundRaw.drawFxPass(x, y, w, h, radius, drawFill, stroke, strokeWidth, true, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff) then
			baseKind = "round.base.fx"
			innerGlowDrawn = true
		elseif baseKind == "round.base.solidRect"
			and hasFill
			and fill.kind == FILL_SOLID
			and not transformActive then
			local drawProfile = profiling and profileStart() or nil
			drawSolidRectFast(x, y, w, h, fill)
			if profiling then profileEnd("round.base.draw", drawProfile) end
			baseKind = "round.base.solidRectFast"
		elseif baseKind == "round.base.solidRound"
			and hasFill
			and fill.kind == FILL_SOLID
			and drawSolidRoundFast(x, y, w, h, radiusValue, fill) then
			baseKind = "round.base.solidRoundFast"
		else
			local setupProfile = profiling and profileStart() or nil
			setupRoundRectConstants(mat, w, h, drawFill, stroke, strokeWidth, radiusValue)
			surface_SetMaterial(mat)
			surface_SetDrawColor(255, 255, 255, 255)
			if profiling then profileEnd("round.base.setup", setupProfile) end
			local drawProfile = profiling and profileStart() or nil
			drawTexturedQuad(x, y, w, h, mat)
			if profiling then profileEnd("round.base.draw", drawProfile) end
		end
		if profiling then profileEndBase(baseKind, profile) end
	end

	if hasInner and not innerGlowDrawn then
		profile = profiling and profileStart() or nil
		roundRaw.drawInnerGlow(x, y, w, h, radius, true, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff)
		if profiling then profileEnd("round.innerGlow", profile) end
	end
	finishImmediateProfile(profiling, totalProfile)
end

drawRoundRectRaw = function(x, y, w, h, radius, fillInput, stroke, strokeWidthInput, shadow, outerGlow, innerGlow, backdropInput, pattern)
	-- Parse friendly public style tables once at the boundary. The hot draw
	-- core below only receives scalar effect parameters and already-normalized
	-- fill/stroke state.
	local profiling = profiler and profiler.IsActive and profiler.IsActive()
	local totalProfile = profiling and profileStart() or nil
	local fill = hotFillFromStyle(fillInput)
	local hasFill = hotFillVisible(fill)
	local strokeWidth = 0
	local hasStroke = false
	if stroke then
		strokeWidth = strokeWidthValue(strokeWidthInput, 0)
		hasStroke = strokeWidth > 0 and (stroke.a == nil or stroke.a > 0)
	end

	local hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread = false, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0
	if shadow ~= nil and shadow ~= false then
		hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread = roundRaw.shadow(shadow)
	end

	local hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread = false, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0
	if outerGlow ~= nil and outerGlow ~= false then
		hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread = roundRaw.outerGlow(outerGlow)
	end

	local hasInner, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff = false, 0, 0, 0, 0, 0, 0, 1
	if innerGlow ~= nil and innerGlow ~= false then
		hasInner, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff = roundRaw.innerGlow(innerGlow)
	end

	local backdropSpec = nil
	if backdropInput ~= nil and backdropInput ~= false then
		backdropSpec = backdropStyle(backdropInput)
	end

	local patternSpec = nil
	if pattern ~= nil and pattern ~= false then
		patternSpec = patternStyle(pattern)
	end

	return drawRoundRectPrepared(
		x, y, w, h, radius,
		fill, hasFill,
		stroke, strokeWidth, hasStroke,
		hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread,
		hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread,
		hasInner, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff,
		backdropSpec, patternSpec,
		profiling, totalProfile, totalProfile
	)
end

drawRoundRectImmediate = function(x, y, w, h, style)
	style = style or emptyRoundRectStyle
	local fillInput = style.fill
	if fillInput == nil then fillInput = style.color end
	local radius = style.radius
	if radius == nil then radius = style.r or 0 end
	return drawRoundRectRaw(x, y, w, h, radius, fillInput, style.stroke, style.strokeWidth, style.shadow, style.outerGlow, style.innerGlow, style.backdrop, style.pattern)
end

function M.RoundedBoxEx(x, y, w, h, style)
	style = resolveDrawStyle(style, M.TARGET.ROUNDED_BOX)
	local transform
	transform, style = splitStyleTransform(style)
	recordDirectImmediate("DrawRoundedBox", "round")
	if not transform then
		local result = drawRoundRectImmediate(x, y, w, h, style)
		return result
	end
	local result = withTransform(transform, x, y, w, h, function()
		return drawRoundRectImmediate(x, y, w, h, style)
	end)
	return result
end

function M.RoundedBox(x, y, w, h, radius, fill, stroke, strokeWidth)
	recordDirectImmediate("DrawRoundedBox", "round")
	local result = drawRoundRectRaw(x, y, w, h, radius, fill, stroke, strokeWidth, nil, nil, nil, nil, nil)
	return result
end

function M.Circle(cx, cy, radius, fill, stroke, strokeWidth)
	return M.RoundedBox(cx - radius, cy - radius, radius * 2, radius * 2, radius, fill, stroke, strokeWidth)
end

function M.CircleEx(cx, cy, radius, style)
	style = resolveDrawStyle(style, M.TARGET.CIRCLE)
	local transform
	transform, style = splitStyleTransform(style)
	recordDirectImmediate("DrawRoundedBox", "round")
	local x, y, size = cx - radius, cy - radius, radius * 2
	if not transform then
		return drawRoundRectRaw(x, y, size, size, radius, style.fill or style.color, style.stroke, style.strokeWidth, style.shadow, style.outerGlow, style.innerGlow, style.backdrop, style.pattern)
	end
	return withTransform(transform, x, y, size, size, function()
		return drawRoundRectRaw(x, y, size, size, radius, style.fill or style.color, style.stroke, style.strokeWidth, style.shadow, style.outerGlow, style.innerGlow, style.backdrop, style.pattern)
	end)
end

function M.Capsule(x, y, w, h, fill, stroke, strokeWidth)
	recordDirectImmediate("DrawRoundedBox", "round")
	return drawRoundRectRaw(x, y, w, h, math_min(w, h) * 0.5, fill, stroke, strokeWidth, nil, nil, nil, nil, nil)
end

function M.CapsuleEx(x, y, w, h, style)
	style = resolveDrawStyle(style, M.TARGET.CAPSULE)
	local transform
	transform, style = splitStyleTransform(style)
	local radius = style.radius or math_min(w, h) * 0.5
	recordDirectImmediate("DrawRoundedBox", "round")
	if not transform then
		return drawRoundRectRaw(x, y, w, h, radius, style.fill or style.color, style.stroke, style.strokeWidth, style.shadow, style.outerGlow, style.innerGlow, style.backdrop, style.pattern)
	end
	return withTransform(transform, x, y, w, h, function()
		return drawRoundRectRaw(x, y, w, h, radius, style.fill or style.color, style.stroke, style.strokeWidth, style.shadow, style.outerGlow, style.innerGlow, style.backdrop, style.pattern)
	end)
end


	return {
		drawRoundRectFallback = drawRoundRectFallbackRaw,
		patternStyle = patternStyle,
		patternOffset = patternOffset,
		setupPatternConstants = setupPatternConstants,
		drawRoundRectPattern = drawRoundRectPattern,
		drawRoundRectInnerGlow = drawRoundRectInnerGlow,
		drawRoundRectOuterGlow = drawRoundRectOuterGlow,
		drawRoundRectFillPass = drawRoundRectFillPass,
		drawRoundRectStrokePass = drawRoundRectStrokePass,
		drawRoundRectRaw = drawRoundRectRaw,
		drawRoundRectPrepared = drawRoundRectPrepared,
		drawRoundRectImmediate = drawRoundRectImmediate,
		roundRaw = roundRaw,
		glowBiasPads = glowBiasPads,
	}
end
