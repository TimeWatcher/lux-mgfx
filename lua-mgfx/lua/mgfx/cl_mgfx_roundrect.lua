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
	local fillFromStyle = C.fillFromStyle
	local fillVisible = C.fillVisible
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
local innerGlowStyle
local outerGlowStyle
local shadowStyle

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

local function traceStart(name)
	if profiler and profiler._TraceActive and profiler.TraceStart then
		return profiler.TraceStart(name)
	end
	return nil
end

local function traceEnd(token)
	if token and profiler and profiler.TraceEnd then
		profiler.TraceEnd(token)
	end
end

local function finishImmediateTrace(trace, profiling, totalProfile)
	traceEnd(trace)
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

local function effectExtentFromSpec(spec, defaultWidth)
	defaultWidth = defaultWidth or 18
	if spec and spec._extent ~= nil then return spec._extent end
	local width = math_max(0.001, tonumber(spec and spec.width) or defaultWidth)
	local falloff = math_max(0.35, tonumber(spec and spec.falloff) or 1.9)
	local sigma = math_max(width / math.sqrt(falloff) * 0.72, 0.35)
	local tail = sigma * 3.72
	return math_max(1, tonumber(spec and spec.spread) or width, tail)
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
	local setupTrace = traceStart("round.fast.solidRound.setup")
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
	traceEnd(setupTrace)
	if profiling then profileEnd("round.fast.solidRound.setup", setupProfile) end
	local drawProfile = profiling and profileStart() or nil
	local drawTrace = traceStart("round.fast.solidRound.draw")
	drawTexturedQuad(x, y, w, h, mat)
	traceEnd(drawTrace)
	if profiling then profileEnd("round.fast.solidRound.draw", drawProfile) end
	return true
end

local transparentFillColor = Color(0, 0, 0, 0)
local transparentFill = {kind = FILL_SOLID, colorA = transparentFillColor, colorB = transparentFillColor}
local emptyRoundRectStyle = {}
local solidFillScratch = {kind = FILL_SOLID, colorA = color_white, colorB = color_white}
local fallbackRoundRectVerts = {}
local fallbackStrokeVerts = {{}, {}, {}, {}}
local circleExStyle = {}
local capsuleExStyle = {}
local defaultInnerGlowColor = Color(76, 190, 255, 34)
local defaultOuterGlowColor = Color(76, 190, 255, 88)
local defaultShadowColor = Color(0, 0, 0, 132)
local defaultInnerGlowSpec = {color = defaultInnerGlowColor, width = 7, strength = 1, falloff = glowSoftnessToFalloff(0.55)}
local defaultOuterGlowSpec = {color = defaultOuterGlowColor, x = 0, y = 0, width = 18, spread = 18, grow = 0, strength = 1, falloff = glowSoftnessToFalloff(0.54)}
local defaultShadowSpec = {color = defaultShadowColor, x = 0, y = 4, width = 12, spread = 12, grow = 0, strength = 1, falloff = glowSoftnessToFalloff(0.62)}
defaultOuterGlowSpec._extent = effectExtentFromSpec(defaultOuterGlowSpec, 18)
defaultOuterGlowSpec._cullSpread = defaultOuterGlowSpec._extent
defaultShadowSpec._extent = effectExtentFromSpec(defaultShadowSpec, 12)
defaultShadowSpec._cullSpread = math_abs(defaultShadowSpec.x) + math_abs(defaultShadowSpec.y) + defaultShadowSpec._extent + defaultShadowSpec.grow
local innerGlowColorCache = setmetatable({}, {__mode = "k"})
local outerGlowColorCache = setmetatable({}, {__mode = "k"})
local shadowColorCache = setmetatable({}, {__mode = "k"})
local innerGlowTableCache = setmetatable({}, {__mode = "k"})
local outerGlowTableCache = setmetatable({}, {__mode = "k"})
local shadowTableCache = setmetatable({}, {__mode = "k"})
local shadowNumberCache = {}

local function copyStyleInto(out, style)
	for k in pairs(out) do
		out[k] = nil
	end

	if istable(style) then
		for k, v in pairs(style) do
			out[k] = v
		end
	end

	return out
end

local function hotFillFromStyle(fill, fallback)
	if istable(fill) then
		local kind = fill.kind
		if kind == FILL_SOLID or kind == FILL_LINEAR or kind == FILL_RADIAL or kind == FILL_CONIC then return fill end
		if kind ~= nil then
			solidFillScratch.colorA = transparentFillColor
			solidFillScratch.colorB = transparentFillColor
			return solidFillScratch
		end
		if fill.r ~= nil and fill.g ~= nil and fill.b ~= nil then
			solidFillScratch.colorA = fill
			solidFillScratch.colorB = fill
			return solidFillScratch
		end
	end

	local color = asColor(fill, fallback or color_white)
	solidFillScratch.colorA = color
	solidFillScratch.colorB = color
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

local function drawRoundRectFallback(x, y, w, h, style)
	M.stats.fallbacks = M.stats.fallbacks + 1
	local fillInput = style.fill
	if fillInput == nil then fillInput = style.color end
	local fill = hotFillFromStyle(fillInput)
	local radius = style.radius
	if radius == nil then radius = style.r or 0 end
	if hasTransform() then
		local points = fallbackRoundRectPoints(x, y, w, h, radius)
		if fillVisible(fill) then
			setDrawColor(fill.colorA or color_white)
			drawTransformedPoly(points)
			M.stats.draws = M.stats.draws + 1
		end

		local strokeWidth = strokeWidthValue(style.strokeWidth, 1)
		if strokeVisible(style.stroke, strokeWidth) then
			drawFallbackStroke(points, style.stroke, math_max(1, math_floor(strokeWidth)))
		end
		return
	end

	if fillVisible(fill) then
		draw.RoundedBox(math_floor(tonumber(radius) or 0), x, y, w, h, fill.colorA or color_white)
		M.stats.draws = M.stats.draws + 1
	end

	if strokeVisible(style.stroke, style.strokeWidth) then
		setDrawColor(style.stroke)
		surface.DrawOutlinedRect(x, y, w, h, math_max(1, math_floor(strokeWidthValue(style.strokeWidth, 1))))
		M.stats.draws = M.stats.draws + 1
	end
end

innerGlowStyle = function(glow)
	if not glow then return nil end
	if glow == true then return defaultInnerGlowSpec end

	if istable(glow) and glow.r and glow.g and glow.b then
		local cached = innerGlowColorCache[glow]
		if cached then return cached end
		cached = {
			color = glow,
			width = 7,
			strength = 1,
			falloff = glowSoftnessToFalloff(0.55),
		}
		innerGlowColorCache[glow] = cached
		return cached
	end

	if not istable(glow) then return nil end

	-- Cache normalized specs, but guard on raw inputs so mutating a style table
	-- still takes effect without paying color/number normalization on hits.
	local cached = innerGlowTableCache[glow]
	if cached
		and cached._colorInput == glow.color
		and cached._tintInput == glow.tint
		and cached._sizeInput == glow.size
		and cached._widthInput == glow.width
		and cached._opacityInput == glow.opacity
		and cached._strengthInput == glow.strength
		and cached._falloffInput == glow.falloff
		and cached._softnessInput == glow.softness then
		return cached
	end

	local color = asColor(glow.color or glow.tint, defaultInnerGlowColor)
	local width = math_max(1, tonumber(glow.size) or tonumber(glow.width) or 7)
	local strength = tonumber(glow.opacity) or tonumber(glow.strength) or 1
	local falloff = tonumber(glow.falloff) or glowSoftnessToFalloff(glow.softness, 0.55)

	cached = {}
	cached.color = color
	cached.width = width
	cached.strength = strength
	cached.falloff = falloff
	cached._colorInput = glow.color
	cached._tintInput = glow.tint
	cached._sizeInput = glow.size
	cached._widthInput = glow.width
	cached._opacityInput = glow.opacity
	cached._strengthInput = glow.strength
	cached._falloffInput = glow.falloff
	cached._softnessInput = glow.softness
	innerGlowTableCache[glow] = cached
	return cached
end

outerGlowStyle = function(glow)
	if not glow then return nil end
	if glow == true then return defaultOuterGlowSpec end

	if istable(glow) and glow.r and glow.g and glow.b then
		local cached = outerGlowColorCache[glow]
		if cached then return cached end
		cached = {
			color = glow,
			x = 0,
			y = 0,
			width = 18,
			spread = 18,
			grow = 0,
			strength = 1,
			falloff = glowSoftnessToFalloff(0.54),
		}
		cached._extent = effectExtentFromSpec(cached, 18)
		cached._cullSpread = cached._extent
		outerGlowColorCache[glow] = cached
		return cached
	end

	if not istable(glow) then return nil end

	local cacheable = not istable(glow.offset)
	local cached = cacheable and outerGlowTableCache[glow] or nil
	if cached
		and cached._xInput == glow.x
		and cached._offsetXInput == glow.offsetX
		and cached._dxInput == glow.dx
		and cached._indexXInput == glow[1]
		and cached._yInput == glow.y
		and cached._offsetYInput == glow.offsetY
		and cached._dyInput == glow.dy
		and cached._indexYInput == glow[2]
		and cached._sizeInput == glow.size
		and cached._widthInput == glow.width
		and cached._blurInput == glow.blur
		and cached._radiusInput == glow.radius
		and cached._spreadInput == glow.spread
		and cached._colorInput == glow.color
		and cached._tintInput == glow.tint
		and cached._growInput == glow.grow
		and cached._expandInput == glow.expand
		and cached._shapeSpreadInput == glow.shapeSpread
		and cached._opacityInput == glow.opacity
		and cached._strengthInput == glow.strength
		and cached._falloffInput == glow.falloff
		and cached._softnessInput == glow.softness then
		return cached
	end

	local offset = istable(glow.offset) and glow.offset or nil
	local ox = tonumber(glow.x) or tonumber(glow.offsetX) or tonumber(glow.dx) or tonumber(glow[1]) or (offset and (tonumber(offset.x) or tonumber(offset[1]))) or 0
	local oy = tonumber(glow.y) or tonumber(glow.offsetY) or tonumber(glow.dy) or tonumber(glow[2]) or (offset and (tonumber(offset.y) or tonumber(offset[2]))) or 0
	local width = math_max(1, tonumber(glow.size) or tonumber(glow.width) or tonumber(glow.blur) or tonumber(glow.radius) or tonumber(glow.spread) or 18)
	local color = asColor(glow.color or glow.tint, defaultOuterGlowColor)
	local spread = math_max(1, tonumber(glow.spread) or width)
	local grow = math_max(0, tonumber(glow.grow) or tonumber(glow.expand) or tonumber(glow.shapeSpread) or 0)
	local strength = tonumber(glow.opacity) or tonumber(glow.strength) or 1
	local falloff = tonumber(glow.falloff) or glowSoftnessToFalloff(glow.softness, 0.54)

	cached = {}
	cached.color = color
	cached.x = ox
	cached.y = oy
	cached.width = width
	cached.spread = spread
	cached.grow = grow
	cached.strength = strength
	cached.falloff = falloff
	cached._extent = effectExtentFromSpec(cached, 18)
	cached._cullSpread = math_abs(ox) + math_abs(oy) + cached._extent + grow
	if cacheable then
		cached._xInput = glow.x
		cached._offsetXInput = glow.offsetX
		cached._dxInput = glow.dx
		cached._indexXInput = glow[1]
		cached._yInput = glow.y
		cached._offsetYInput = glow.offsetY
		cached._dyInput = glow.dy
		cached._indexYInput = glow[2]
		cached._sizeInput = glow.size
		cached._widthInput = glow.width
		cached._blurInput = glow.blur
		cached._radiusInput = glow.radius
		cached._spreadInput = glow.spread
		cached._colorInput = glow.color
		cached._tintInput = glow.tint
		cached._growInput = glow.grow
		cached._expandInput = glow.expand
		cached._shapeSpreadInput = glow.shapeSpread
		cached._opacityInput = glow.opacity
		cached._strengthInput = glow.strength
		cached._falloffInput = glow.falloff
		cached._softnessInput = glow.softness
		outerGlowTableCache[glow] = cached
	end
	return cached
end

shadowStyle = function(shadow)
	if not shadow then return nil end
	if shadow == true then return defaultShadowSpec end

	if istable(shadow) and shadow.r and shadow.g and shadow.b then
		local cached = shadowColorCache[shadow]
		if cached then return cached end
		cached = {
			color = shadow,
			x = 0,
			y = 4,
			width = 12,
			spread = 12,
			grow = 0,
			strength = 1,
			falloff = glowSoftnessToFalloff(0.62),
		}
		cached._extent = effectExtentFromSpec(cached, 12)
		cached._cullSpread = math_abs(cached.x) + math_abs(cached.y) + cached._extent + cached.grow
		shadowColorCache[shadow] = cached
		return cached
	end

	if not istable(shadow) then
		local blur = math_max(0.001, tonumber(shadow) or 12)
		local cached = shadowNumberCache[blur]
		if cached then return cached end
		cached = {
			color = defaultShadowColor,
			x = 0,
			y = 4,
			width = blur,
			spread = math_max(1, blur),
			grow = 0,
			strength = 1,
			falloff = glowSoftnessToFalloff(0.62),
		}
		cached._extent = effectExtentFromSpec(cached, 12)
		cached._cullSpread = math_abs(cached.x) + math_abs(cached.y) + cached._extent + cached.grow
		shadowNumberCache[blur] = cached
		return cached
	end

	local cacheable = not istable(shadow.offset)
	local cached = cacheable and shadowTableCache[shadow] or nil
	if cached
		and cached._xInput == shadow.x
		and cached._offsetXInput == shadow.offsetX
		and cached._dxInput == shadow.dx
		and cached._indexXInput == shadow[1]
		and cached._yInput == shadow.y
		and cached._offsetYInput == shadow.offsetY
		and cached._dyInput == shadow.dy
		and cached._indexYInput == shadow[2]
		and cached._blurInput == shadow.blur
		and cached._radiusInput == shadow.radius
		and cached._sizeInput == shadow.size
		and cached._widthInput == shadow.width
		and cached._spreadInput == shadow.spread
		and cached._growInput == shadow.grow
		and cached._expandInput == shadow.expand
		and cached._shapeSpreadInput == shadow.shapeSpread
		and cached._colorInput == shadow.color
		and cached._tintInput == shadow.tint
		and cached._extentInput == shadow.extent
		and cached._paddingInput == shadow.padding
		and cached._opacityInput == shadow.opacity
		and cached._strengthInput == shadow.strength
		and cached._falloffInput == shadow.falloff
		and cached._softnessInput == shadow.softness then
		return cached
	end

	local offset = istable(shadow.offset) and shadow.offset or nil
	local ox = tonumber(shadow.x) or tonumber(shadow.offsetX) or tonumber(shadow.dx) or tonumber(shadow[1]) or (offset and (tonumber(offset.x) or tonumber(offset[1]))) or 0
	local oy = tonumber(shadow.y) or tonumber(shadow.offsetY) or tonumber(shadow.dy) or tonumber(shadow[2]) or (offset and (tonumber(offset.y) or tonumber(offset[2]))) or 4
	local blur = math_max(0.001, tonumber(shadow.blur) or tonumber(shadow.radius) or tonumber(shadow.size) or tonumber(shadow.width) or 12)
	local grow = math_max(0, tonumber(shadow.spread) or tonumber(shadow.grow) or tonumber(shadow.expand) or tonumber(shadow.shapeSpread) or 0)
	local color = asColor(shadow.color or shadow.tint, defaultShadowColor)
	local spread = math_max(1, tonumber(shadow.extent) or tonumber(shadow.padding) or blur)
	local strength = tonumber(shadow.opacity) or tonumber(shadow.strength) or 1
	local falloff = tonumber(shadow.falloff) or glowSoftnessToFalloff(shadow.softness, 0.62)

	cached = {}
	cached.color = color
	cached.x = ox
	cached.y = oy
	cached.width = blur
	cached.spread = spread
	cached.grow = grow
	cached.strength = strength
	cached.falloff = falloff
	cached._extent = effectExtentFromSpec(cached, 12)
	cached._cullSpread = math_abs(ox) + math_abs(oy) + cached._extent + grow
	if cacheable then
		cached._xInput = shadow.x
		cached._offsetXInput = shadow.offsetX
		cached._dxInput = shadow.dx
		cached._indexXInput = shadow[1]
		cached._yInput = shadow.y
		cached._offsetYInput = shadow.offsetY
		cached._dyInput = shadow.dy
		cached._indexYInput = shadow[2]
		cached._blurInput = shadow.blur
		cached._radiusInput = shadow.radius
		cached._sizeInput = shadow.size
		cached._widthInput = shadow.width
		cached._spreadInput = shadow.spread
		cached._growInput = shadow.grow
		cached._expandInput = shadow.expand
		cached._shapeSpreadInput = shadow.shapeSpread
		cached._colorInput = shadow.color
		cached._tintInput = shadow.tint
		cached._extentInput = shadow.extent
		cached._paddingInput = shadow.padding
		cached._opacityInput = shadow.opacity
		cached._strengthInput = shadow.strength
		cached._falloffInput = shadow.falloff
		cached._softnessInput = shadow.softness
		shadowTableCache[shadow] = cached
	end
	return cached
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

local function drawRoundRectPattern(x, y, w, h, radius, pattern)
	local spec = patternStyle(pattern)
	if not spec then return end
	if not shadersActive() or not matOK(materials.roundrect_pattern) then return end

	local color = spec.color or spec.tint
	if color and (color.a or 255) <= 0 then return end

	local mat = materials.roundrect_pattern
	local setupTrace = traceStart("round.pattern.setup")
	setupPatternConstants(mat, w, h, roundRectRadiusScalar(radius, w, h), spec)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	traceEnd(setupTrace)
	local drawTrace = traceStart("round.pattern.draw")
	drawTexturedQuad(x, y, w, h, mat)
	traceEnd(drawTrace)
end

local function drawRoundRectInnerGlowSpec(x, y, w, h, radius, spec)
	if not spec then return end

	local color = spec.color
	if (color.a or 255) <= 0 then return end
	if not shadersActive() or not matOK(materials.roundrect_innerglow) then return end

	local setupTrace = traceStart("round.innerGlow.setup")
	local mat = materials.roundrect_innerglow
	local glowWidth = spec.width or 8
	local glowStrength = spec.strength or 1
	local glowFalloff = spec.falloff or 1.65
	setupParamMatrixRaw(mat,
		(color.r or 0) * inv255,
		(color.g or 0) * inv255,
		(color.b or 0) * inv255,
		(color.a == nil and 255 or color.a) * inv255,
		w, h, 0, roundRectRadiusScalar(radius, w, h),
		glowWidth,
		glowStrength,
		glowFalloff,
		0,
		0, 0, 0, 0
	)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	traceEnd(setupTrace)
	local drawTrace = traceStart("round.innerGlow.draw")
	drawTexturedQuad(x, y, w, h, mat)
	traceEnd(drawTrace)
end

local function drawRoundRectInnerGlow(x, y, w, h, radius, glow)
	return drawRoundRectInnerGlowSpec(x, y, w, h, radius, innerGlowStyle(glow))
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

local function effectExtent(spec, defaultWidth)
	return effectExtentFromSpec(spec, defaultWidth)
end

local function drawRoundRectShadowOuterSpec(x, y, w, h, radius, shadowSpec, outerSpec)
	if not shadowSpec and not outerSpec then return false end
	if not shadersActive() or not matOK(materials.roundrect_shadow_outer) then return false end

	local shadowColor = shadowSpec and shadowSpec.color or nil
	local outerColor = outerSpec and outerSpec.color or nil
	local hasShadow = shadowColor ~= nil and (shadowColor.a or 255) > 0
	local hasOuter = outerColor ~= nil and (outerColor.a or 255) > 0
	if not hasShadow and not hasOuter then return false end

	local profiling = profiler and profiler.IsActive and profiler.IsActive()
	local setupProfile = profiling and profileStart() or nil
	local setupTrace = traceStart("round.shadowOuter.setup")

	local shadowSource = shadowSpec or outerSpec
	local outerSource = outerSpec or shadowSpec
	local shadowGrow = shadowSource.grow or 0
	local shadowGw = w + shadowGrow * 2
	local shadowGh = h + shadowGrow * 2
	local shadowSpread = shadowSource._extent or shadowSource.spread or shadowSource.width or 18
	local shadowShapeX = x + (hasShadow and (shadowSource.x or 0) or 0) - shadowGrow
	local shadowShapeY = y + (hasShadow and (shadowSource.y or 0) or 0) - shadowGrow
	local shadowDrawX = shadowShapeX - shadowSpread
	local shadowDrawY = shadowShapeY - shadowSpread
	local shadowDrawW = shadowGw + shadowSpread * 2
	local shadowDrawH = shadowGh + shadowSpread * 2

	local outerGrow = outerSource.grow or 0
	local outerGw = w + outerGrow * 2
	local outerGh = h + outerGrow * 2
	local outerSpread = outerSource._extent or outerSource.spread or outerSource.width or 18
	local outerOx = hasOuter and (outerSource.x or 0) or 0
	local outerOy = hasOuter and (outerSource.y or 0) or 0
	local outerLeft, outerTop, outerRight, outerBottom = glowBiasPads(outerSpread, outerOx, outerOy)
	local outerShapeX = x - outerGrow
	local outerShapeY = y - outerGrow
	local outerDrawX = outerShapeX - outerLeft
	local outerDrawY = outerShapeY - outerTop
	local outerDrawW = outerGw + outerLeft + outerRight
	local outerDrawH = outerGh + outerTop + outerBottom

	local sx = math_min(shadowDrawX, outerDrawX)
	local sy = math_min(shadowDrawY, outerDrawY)
	local ex = math_max(shadowDrawX + shadowDrawW, outerDrawX + outerDrawW)
	local ey = math_max(shadowDrawY + shadowDrawH, outerDrawY + outerDrawH)
	local sw = ex - sx
	local sh = ey - sy
	local mat = materials.roundrect_shadow_outer

	setupParamMatrixRaw(mat,
		sw, sh, 0, 0,
		hasShadow and (shadowColor.r or 0) * inv255 or 0,
		hasShadow and (shadowColor.g or 0) * inv255 or 0,
		hasShadow and (shadowColor.b or 0) * inv255 or 0,
		hasShadow and (shadowColor.a == nil and 255 or shadowColor.a) * inv255 or 0,
		shadowShapeX - sx, shadowShapeY - sy, shadowGw, shadowGh,
		roundRectRadiusScalar(radiusWithGrow(radius, shadowGrow), shadowGw, shadowGh),
		hasShadow and (shadowSource.width or 18) or 1,
		hasShadow and (shadowSource.strength or 1) or 0,
		hasShadow and (shadowSource.falloff or 1.9) or 1
	)
	setupExtraParamsRaw(mat,
		hasOuter and (outerColor.r or 0) * inv255 or 0,
		hasOuter and (outerColor.g or 0) * inv255 or 0,
		hasOuter and (outerColor.b or 0) * inv255 or 0,
		hasOuter and (outerColor.a == nil and 255 or outerColor.a) * inv255 or 0,
		outerShapeX - sx, outerShapeY - sy, outerGw, outerGh,
		roundRectRadiusScalar(radiusWithGrow(radius, outerGrow), outerGw, outerGh),
		hasOuter and (outerSource.width or 18) or 1,
		hasOuter and (outerSource.strength or 1) or 0,
		hasOuter and (outerSource.falloff or 1.9) or 1,
		0, 0, 0, 0
	)
	traceEnd(setupTrace)
	if profiling then profileEnd("round.shadowOuter.setup", setupProfile) end

	local bleedProfile = profiling and profileStart() or nil
	local bleedTrace = traceStart("round.shadowOuter.bleedBegin")
	local bleedToken = beginPanelEffectDraw(sx, sy, sw, sh)
	traceEnd(bleedTrace)
	if profiling then profileEnd("round.shadowOuter.bleedBegin", bleedProfile) end

	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	local drawProfile = profiling and profileStart() or nil
	local drawTrace = traceStart("round.shadowOuter.draw")
	drawTexturedQuad(sx, sy, sw, sh, mat)
	traceEnd(drawTrace)
	if profiling then profileEnd("round.shadowOuter.draw", drawProfile) end

	bleedProfile = profiling and profileStart() or nil
	bleedTrace = traceStart("round.shadowOuter.bleedEnd")
	endPanelEffectBleed(bleedToken)
	traceEnd(bleedTrace)
	if profiling then profileEnd("round.shadowOuter.bleedEnd", bleedProfile) end
	return true
end

local function effectColorPacked(spec)
	if not spec then return 0, 0, 0, 0 end
	local color = spec.color
	if not color then return 0, 0, 0, 0 end
	local alpha = (color.a == nil and 255 or color.a) * inv255
	if alpha <= 0 then return 0, 0, 0, 0 end
	local strength = math_max(0, tonumber(spec.strength) or 1)
	if strength <= 0 then return 0, 0, 0, 0 end
	return (color.r or 0) * inv255,
		(color.g or 0) * inv255,
		(color.b or 0) * inv255,
		alpha * strength
end

local function drawRoundRectFusedSpec(x, y, w, h, radius, fill, stroke, strokeWidth, shadowSpec, outerSpec, radiusValue)
	if w <= 0 or h <= 0 then return false end
	if (not shadowSpec and not outerSpec) or not drawTexturedQuadUV then return false end
	if not shadersActive() or not matOK(materials.roundrect_fused) then return false end

	local shadowColor = shadowSpec and shadowSpec.color or nil
	local outerColor = outerSpec and outerSpec.color or nil
	local hasShadow = shadowColor ~= nil and (shadowColor.a or 255) > 0 and (shadowSpec.strength or 1) > 0
	local hasOuter = outerColor ~= nil and (outerColor.a or 255) > 0 and (outerSpec.strength or 1) > 0
	if not hasShadow and not hasOuter then return false end

	local profiling = profiler and profiler.IsActive and profiler.IsActive()
	local setupProfile = profiling and profileStart() or nil
	local setupTrace = traceStart("round.fused.setup")

	local sx = x
	local sy = y
	local ex = x + w
	local ey = y + h

	local shadowGrow, shadowWidth, shadowFalloff, shadowX, shadowY = 0, 1, 1, 0, 0
	if hasShadow then
		shadowGrow = shadowSpec.grow or 0
		shadowWidth = shadowSpec.width or 18
		shadowFalloff = shadowSpec.falloff or 1.9
		shadowX = shadowSpec.x or 0
		shadowY = shadowSpec.y or 0
		local spread = shadowSpec._extent or shadowSpec.spread or shadowWidth
		local drawX = x + shadowX - shadowGrow - spread
		local drawY = y + shadowY - shadowGrow - spread
		local drawW = w + shadowGrow * 2 + spread * 2
		local drawH = h + shadowGrow * 2 + spread * 2
		sx = math_min(sx, drawX)
		sy = math_min(sy, drawY)
		ex = math_max(ex, drawX + drawW)
		ey = math_max(ey, drawY + drawH)
	end

	local outerGrow, outerWidth, outerFalloff = 0, 1, 1
	if hasOuter then
		outerGrow = outerSpec.grow or 0
		outerWidth = outerSpec.width or 18
		outerFalloff = outerSpec.falloff or 1.9
		local spread = outerSpec._extent or outerSpec.spread or outerWidth
		local left, top, right, bottom = glowBiasPads(spread, outerSpec.x or 0, outerSpec.y or 0)
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
		traceEnd(setupTrace)
		if profiling then profileEnd("round.fused.setup", setupProfile) end
		return false
	end

	local mat = materials.roundrect_fused
	setupRoundRectConstants(mat, w, h, fill, stroke, strokeWidth, radiusValue or roundRectRadiusScalar(radius, w, h))
	local sr, sg, sb, sa = effectColorPacked(hasShadow and shadowSpec or nil)
	local orr, og, ob, oa = effectColorPacked(hasOuter and outerSpec or nil)
	setupExtraParamsRaw(mat,
		sr, sg, sb, sa,
		shadowX, shadowY, shadowGrow, shadowWidth,
		orr, og, ob, oa,
		shadowFalloff, outerGrow, outerWidth, outerFalloff
	)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	traceEnd(setupTrace)
	if profiling then profileEnd("round.fused.setup", setupProfile) end

	local bleedProfile = profiling and profileStart() or nil
	local bleedTrace = traceStart("round.fused.bleedBegin")
	local bleedToken = beginPanelEffectDraw(sx, sy, sw, sh)
	traceEnd(bleedTrace)
	if profiling then profileEnd("round.fused.bleedBegin", bleedProfile) end

	local u0 = (sx - x) / w
	local v0 = (sy - y) / h
	local u1 = (ex - x) / w
	local v1 = (ey - y) / h
	local drawProfile = profiling and profileStart() or nil
	local drawTrace = traceStart("round.fused.draw")
	drawTexturedQuadUV(sx, sy, sw, sh, u0, v0, u1, v1, mat)
	traceEnd(drawTrace)
	if profiling then profileEnd("round.fused.draw", drawProfile) end

	bleedProfile = profiling and profileStart() or nil
	bleedTrace = traceStart("round.fused.bleedEnd")
	endPanelEffectBleed(bleedToken)
	traceEnd(bleedTrace)
	if profiling then profileEnd("round.fused.bleedEnd", bleedProfile) end
	return true
end

local function drawRoundRectOuterGlow(x, y, w, h, radius, glow)
	return drawRoundRectShadowOuterSpec(x, y, w, h, radius, nil, outerGlowStyle(glow))
end

local drawRoundRectFillPass

local backdropTintScratch = Color(0, 0, 0, 0)

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
	local trace = traceStart("round.backdrop.pass")
	local pad = math_max(0, tonumber(spec.padding) or 0)
	local bx = x - pad
	local by = y - pad
	local bw = w + pad * 2
	local bh = h + pad * 2
	local br = radiusWithGrow(radius, pad)
	local tint = backdropTintColor(spec)
	local blurred = false

	if spec.blur > 0 and shadersActive() and matOK(materials.roundrect_blur) and drawBlurredQuad then
		local blurTrace = traceStart("round.backdrop.blur")
		drawBlurredQuad(materials.roundrect_blur, bx, by, bw, bh, roundRectRadiusScalar(br, bw, bh), spec.blur, tint)
		traceEnd(blurTrace)
		blurred = true
	end

	if tint and not blurred then
		local tintTrace = traceStart("round.backdrop.tint")
		drawRoundRectFillPass(bx, by, bw, bh, br, hotFillFromStyle(tint))
		traceEnd(tintTrace)
	end

	traceEnd(trace)
	return spec
end

drawRoundRectFillPass = function(x, y, w, h, radius, fill)
	local mat = materials.roundrect
	local setupTrace = traceStart("round.fillPass.setup")
	setupRoundRectConstants(mat, w, h, fill, nil, 0, roundRectRadiusScalar(radius, w, h))
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	traceEnd(setupTrace)
	local drawTrace = traceStart("round.fillPass.draw")
	drawTexturedQuad(x, y, w, h, mat)
	traceEnd(drawTrace)
end

local function drawRoundRectStrokePass(x, y, w, h, radius, stroke, strokeWidth)
	if not strokeVisible(stroke, strokeWidth) then return end
	if shadersActive() and matOK(materials.roundrect_stroke) then
		local mat = materials.roundrect_stroke
		local r, g, b, a = color01(stroke)
		local setupTrace = traceStart("round.strokePass.setup")
		setupParamMatrix(mat,
			r, g, b, a,
			w, h, math_max(0, strokeWidthValue(strokeWidth, 0)), roundRectRadiusScalar(radius, w, h),
			0, 0, 1, 0,
			0, 0, 0, 0
		)
		surface_SetMaterial(mat)
		surface_SetDrawColor(255, 255, 255, 255)
		traceEnd(setupTrace)
		local drawTrace = traceStart("round.strokePass.draw")
		drawTexturedQuad(x, y, w, h, mat)
		traceEnd(drawTrace)
		return
	end

	local mat = materials.roundrect
	local setupTrace = traceStart("round.strokePass.setup")
	setupRoundRectConstants(mat, w, h, transparentFill, stroke, strokeWidth, roundRectRadiusScalar(radius, w, h))
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	traceEnd(setupTrace)
	local drawTrace = traceStart("round.strokePass.draw")
	drawTexturedQuad(x, y, w, h, mat)
	traceEnd(drawTrace)
end

local function drawRoundRectFxPass(x, y, w, h, radius, fill, stroke, strokeWidth, innerSpec)
	if not setupExtraParams or not matOK(materials.roundrect_fx) then return false end

	local profiling = profiler and profiler.IsActive and profiler.IsActive()
	local setupProfile = profiling and profileStart() or nil
	local setupTrace = traceStart("round.base.fx.setup")
	local mat = materials.roundrect_fx
	local gr, gg, gb, ga = 0, 0, 0, 0
	local glowWidth, glowStrength, glowFalloff = 0, 0, 1
	if innerSpec then
		local color = innerSpec.color or transparentFillColor
		gr = (color.r or 0) * inv255
		gg = (color.g or 0) * inv255
		gb = (color.b or 0) * inv255
		ga = (color.a == nil and 255 or color.a) * inv255
		glowWidth = math_max(0.001, tonumber(innerSpec.width) or 8)
		glowStrength = math_max(0, tonumber(innerSpec.strength) or 1)
		glowFalloff = math_max(0.001, tonumber(innerSpec.falloff) or 1.65)
	end

	if not setupExtraParamsRaw(mat,
		gr, gg, gb, ga,
		glowWidth, glowStrength, glowFalloff, 0,
		0, 0, 0, 0,
		0, 0, 0, 0
	) then
		traceEnd(setupTrace)
		if profiling then profileEnd("round.base.fx.setup", setupProfile) end
		return false
	end

	setupRoundRectConstants(mat, w, h, fill, stroke, strokeWidth, roundRectRadiusScalar(radius, w, h))
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	traceEnd(setupTrace)
	if profiling then profileEnd("round.base.fx.setup", setupProfile) end
	local drawProfile = profiling and profileStart() or nil
	local drawTrace = traceStart("round.base.fx.draw")
	drawTexturedQuad(x, y, w, h, mat)
	traceEnd(drawTrace)
	if profiling then profileEnd("round.base.fx.draw", drawProfile) end
	return true
end

drawRoundRectImmediate = function(x, y, w, h, style)
	-- API wrappers accept friendly call shapes; the draw core keeps field reads
	-- explicit so hot paths do not rebuild cached style records every frame.
	local profiling = profiler and profiler.IsActive and profiler.IsActive()
	local trace = traceStart("round.immediate")
	local totalProfile = profiling and profileStart() or nil
	local stageProfile = totalProfile
	style = style or emptyRoundRectStyle
	local initTrace = traceStart("round.init")
	local shaderReady = shadersActive()
	local transformActive = hasTransform()
	local radius = style.radius
	if radius == nil then radius = style.r or 0 end
	local stroke = style.stroke
	local strokeWidth = 0
	local hasStroke = false
	if stroke then
		strokeWidth = strokeWidthValue(style.strokeWidth, 0)
		hasStroke = strokeWidth > 0 and (stroke.a == nil or stroke.a > 0)
	end
	traceEnd(initTrace)

	if style.shadow == nil
		and style.outerGlow == nil
		and style.innerGlow == nil
		and style.backdrop == nil
		and style.pattern == nil
		and not hasStroke
		and not transformActive then
		local fillInput = style.fill
		if fillInput == nil then fillInput = style.color end
		local fastPrepareTrace = traceStart("round.fast.prepare")
		local fill = hotFillFromStyle(fillInput)
		local hasFill = fillVisible(fill)
		if fill.kind == FILL_SOLID and hasFill then
			local radiusValue = roundRectRadiusScalar(radius, w, h)
			traceEnd(fastPrepareTrace)
			if profiling then
				local now = SysTime()
				profileRecord("round.prepare", (now - stageProfile) * 1000)
				stageProfile = now
			end
			local cullTrace = traceStart("round.cull")
			if isCulled(x, y, w, h) then
				traceEnd(cullTrace)
				if profiling then
					profileRecord("round.cull", (SysTime() - stageProfile) * 1000)
				end
				finishImmediateTrace(trace, profiling, totalProfile)
				return
			end
			traceEnd(cullTrace)
			if profiling then
				local now = SysTime()
				profileRecord("round.cull", (now - stageProfile) * 1000)
				stageProfile = now
			end
			if radiusValue <= 0 then
				local drawProfile = profiling and profileStart() or nil
				local drawTrace = traceStart("round.fast.solidRect")
				drawSolidRectFast(x, y, w, h, fill)
				traceEnd(drawTrace)
				if profiling then profileEnd("round.fast.solidRect", drawProfile) end
				finishImmediateTrace(trace, profiling, totalProfile)
				return
			end
			local drawProfile = profiling and profileStart() or nil
			local fastTrace = traceStart("round.fast.solidRound")
			if shaderReady and drawSolidRoundFast(x, y, w, h, radiusValue, fill) then
				traceEnd(fastTrace)
				if profiling then
					profileEnd("round.fast.solidRound", drawProfile)
				end
				finishImmediateTrace(trace, profiling, totalProfile)
				return
			end
			traceEnd(fastTrace)
			if profiling then profileEnd("round.fast.solidRound.miss", drawProfile) end
		else
			traceEnd(fastPrepareTrace)
		end
	end

	local effectTrace = traceStart("round.normalizeEffects")
	local shadowTrace = traceStart("style.shadow")
	local shadowSpec = shadowStyle(style.shadow)
	traceEnd(shadowTrace)
	local outerTrace = traceStart("style.outerGlow")
	local outerSpec = outerGlowStyle(style.outerGlow)
	traceEnd(outerTrace)
	local backdropInput = style.backdrop
	local backdropTrace = traceStart("style.backdrop")
	local backdropSpec = backdropInput ~= nil and backdropInput ~= false and backdropStyle(backdropInput) or nil
	traceEnd(backdropTrace)
	traceEnd(effectTrace)
	if profiling then
		local now = SysTime()
		profileRecord("round.prepare", (now - stageProfile) * 1000)
		stageProfile = now
	end
	local cullSpreadTrace = traceStart("round.cullSpread")
	local cullSpread = 0
	if shaderReady then
		if shadowSpec then
			cullSpread = math_max(cullSpread, shadowSpec._cullSpread or (math_abs(tonumber(shadowSpec.x) or 0) + math_abs(tonumber(shadowSpec.y) or 0) + effectExtentFromSpec(shadowSpec, 12) + (tonumber(shadowSpec.grow) or 0)))
		end
		if outerSpec then
			cullSpread = math_max(cullSpread, outerSpec._cullSpread or (math_abs(tonumber(outerSpec.x) or 0) + math_abs(tonumber(outerSpec.y) or 0) + effectExtentFromSpec(outerSpec, 18) + (tonumber(outerSpec.grow) or 0)))
		end
		if backdropSpec then
			cullSpread = math_max(cullSpread, math_max(0, tonumber(backdropSpec.padding) or 0))
		end
	end
	traceEnd(cullSpreadTrace)
	local cullTrace = traceStart("round.cull")
	if not transformActive and isCulled(x - cullSpread, y - cullSpread, w + cullSpread * 2, h + cullSpread * 2) then
		traceEnd(cullTrace)
		if profiling then profileRecord("round.cull", (SysTime() - stageProfile) * 1000) end
		finishImmediateTrace(trace, profiling, totalProfile)
		return
	end
	traceEnd(cullTrace)
	if profiling then
		local now = SysTime()
		profileRecord("round.cull", (now - stageProfile) * 1000)
		stageProfile = now
	end

	if not shaderReady then
		local profile = profiling and profileStart() or nil
		local fallbackTrace = traceStart("round.fallback")
		drawRoundRectFallback(x, y, w, h, style)
		drawRoundRectInnerGlow(x, y, w, h, style.radius or 0, style.innerGlow)
		traceEnd(fallbackTrace)
		if profiling then
			profileEnd("round.fallback", profile)
		end
		finishImmediateTrace(trace, profiling, totalProfile)
		return
	end

	local fillInput = style.fill
	if fillInput == nil then fillInput = style.color end

	if profiling then stageProfile = SysTime() end
	local fillPrepareTrace = traceStart("round.fillPrepare")
	local fill = hotFillFromStyle(fillInput)
	local hasFill = fillVisible(fill)
	local innerSpec = innerGlowStyle(style.innerGlow)
	traceEnd(fillPrepareTrace)
	if profiling then
		local now = SysTime()
		profileRecord("round.fillPrepare", (now - stageProfile) * 1000)
		stageProfile = now
	end

	local profile
	if backdropSpec == nil
		and style.pattern == nil
		and innerSpec == nil
		and not transformActive
		and (hasFill or hasStroke)
		and (shadowSpec ~= nil or outerSpec ~= nil) then
		profile = profiling and profileStart() or nil
		local fusedTrace = traceStart("round.fused")
		local radiusValue = roundRectRadiusScalar(radius, w, h)
		if drawRoundRectFusedSpec(x, y, w, h, radius, fill, style.stroke, strokeWidth, shadowSpec, outerSpec, radiusValue) then
			traceEnd(fusedTrace)
			if profiling then profileEnd("round.fused", profile) end
			finishImmediateTrace(trace, profiling, totalProfile)
			return
		end
		traceEnd(fusedTrace)
		if profiling then profileEnd("round.fused.miss", profile) end
	end

	if shadowSpec or outerSpec then
		local shadowOuterProfile = profiling and profileStart() or nil
		local shadowOuterTrace = traceStart("round.shadowOuter")
		drawRoundRectShadowOuterSpec(x, y, w, h, radius, shadowSpec, outerSpec)
		traceEnd(shadowOuterTrace)
		if profiling then profileEnd("round.shadowOuter", shadowOuterProfile) end
	end

	local backdrop
	if backdropSpec then
		profile = profiling and profileStart() or nil
		local backdropPassTrace = traceStart("round.backdrop")
		backdrop = drawRoundRectBackdrop(x, y, w, h, radius, backdropSpec)
		traceEnd(backdropPassTrace)
		if profiling then profileEnd("round.backdrop", profile) end
	end

	if backdrop then
		-- Backdrop alone is a valid shape pass; fill/stroke may be fully transparent.
	end

	local effectOnly = not backdrop
		and not hasStroke
		and style.pattern == nil
		and innerSpec == nil
		and (shadowSpec ~= nil or outerSpec ~= nil)
	if effectOnly and not hasFill then
		finishImmediateTrace(trace, profiling, totalProfile)
		return
	end

	if not backdrop and not hasFill and not hasStroke and style.pattern == nil and not innerSpec then
		finishImmediateTrace(trace, profiling, totalProfile)
		return
	end

	local mat = materials.roundrect
	local useLayered = style.pattern ~= nil
	local innerGlowDrawn = false
	if useLayered then
		profile = profiling and profileStart() or nil
		local layeredTrace = traceStart("round.layered")
		if hasFill then
			drawRoundRectFillPass(x, y, w, h, radius, fill)
		end
		drawRoundRectPattern(x, y, w, h, radius, style.pattern)
		if hasStroke then
			drawRoundRectStrokePass(x, y, w, h, radius, style.stroke, strokeWidth)
		end
		traceEnd(layeredTrace)
		if profiling then profileEnd("round.layered", profile) end
	else
		profile = profiling and profileStart() or nil
		local baseTrace = traceStart("round.base")
		local radiusTrace = traceStart("round.base.radius")
		local radiusValue = roundRectRadiusScalar(radius, w, h)
		traceEnd(radiusTrace)
		local baseKind
		if fill.kind == FILL_LINEAR then
			baseKind = "round.base.gradient"
		elseif hasStroke then
			baseKind = "round.base.stroke"
		elseif radiusValue <= 0 then
			baseKind = "round.base.solidRect"
		else
			baseKind = "round.base.solidRound"
		end
		if innerSpec and drawRoundRectFxPass(x, y, w, h, radius, fill, style.stroke, strokeWidth, innerSpec) then
			baseKind = "round.base.fx"
			innerGlowDrawn = true
		elseif baseKind == "round.base.solidRect"
			and fill.kind == FILL_SOLID
			and style.shadow == nil
			and style.outerGlow == nil
			and style.innerGlow == nil
			and backdrop == nil
			and not hasTransform() then
			local drawProfile = profiling and profileStart() or nil
			local drawTrace = traceStart("round.base.draw")
			drawSolidRectFast(x, y, w, h, fill)
			traceEnd(drawTrace)
			if profiling then profileEnd("round.base.draw", drawProfile) end
			baseKind = "round.base.solidRectFast"
		elseif baseKind == "round.base.solidRound"
			and fill.kind == FILL_SOLID
			and style.shadow == nil
			and style.outerGlow == nil
			and style.innerGlow == nil
			and backdrop == nil
			and drawSolidRoundFast(x, y, w, h, radiusValue, fill) then
			baseKind = "round.base.solidRoundFast"
		else
			local setupProfile = profiling and profileStart() or nil
			local setupTrace = traceStart("round.base.setup")
			setupRoundRectConstants(mat, w, h, fill, style.stroke, strokeWidth, radiusValue)
			surface_SetMaterial(mat)
			surface_SetDrawColor(255, 255, 255, 255)
			traceEnd(setupTrace)
			if profiling then profileEnd("round.base.setup", setupProfile) end
			local drawProfile = profiling and profileStart() or nil
			local drawTrace = traceStart("round.base.draw")
			drawTexturedQuad(x, y, w, h, mat)
			traceEnd(drawTrace)
			if profiling then profileEnd("round.base.draw", drawProfile) end
		end
		traceEnd(baseTrace)
		if profiling then profileEndBase(baseKind, profile) end
	end

	if innerSpec and not innerGlowDrawn then
		profile = profiling and profileStart() or nil
		local innerTrace = traceStart("round.innerGlow")
		drawRoundRectInnerGlowSpec(x, y, w, h, radius, innerSpec)
		traceEnd(innerTrace)
		if profiling then profileEnd("round.innerGlow", profile) end
	end
	finishImmediateTrace(trace, profiling, totalProfile)
end

function M.RoundedBoxEx(x, y, w, h, style)
	local trace = traceStart("api.RoundedBoxEx")
	local styleTrace = traceStart("api.RoundedBoxEx.resolveDrawStyle")
	style = resolveDrawStyle(style, M.TARGET.ROUNDED_BOX)
	traceEnd(styleTrace)
	local transform
	local transformTrace = traceStart("api.RoundedBoxEx.splitStyleTransform")
	transform, style = splitStyleTransform(style)
	traceEnd(transformTrace)
	local recordTrace = traceStart("api.RoundedBoxEx.record")
	recordDirectImmediate("DrawRoundedBox", "round")
	traceEnd(recordTrace)
	if not transform then
		local result = drawRoundRectImmediate(x, y, w, h, style)
		traceEnd(trace)
		return result
	end
	local withTransformTrace = traceStart("api.RoundedBoxEx.withTransform")
	local result = withTransform(transform, x, y, w, h, function()
		return drawRoundRectImmediate(x, y, w, h, style)
	end)
	traceEnd(withTransformTrace)
	traceEnd(trace)
	return result
end

local roundedBoxArgStyle = {}

function M.RoundedBox(x, y, w, h, radius, fill, stroke, strokeWidth)
	local trace = traceStart("api.RoundedBox")
	roundedBoxArgStyle.radius = radius
	roundedBoxArgStyle.fill = fill
	roundedBoxArgStyle.stroke = stroke
	roundedBoxArgStyle.strokeWidth = strokeWidth
	recordDirectImmediate("DrawRoundedBox", "round")
	local result = drawRoundRectImmediate(x, y, w, h, roundedBoxArgStyle)
	traceEnd(trace)
	return result
end

function M.Circle(cx, cy, radius, fill, stroke, strokeWidth)
	return M.RoundedBox(cx - radius, cy - radius, radius * 2, radius * 2, radius, fill, stroke, strokeWidth)
end

function M.CircleEx(cx, cy, radius, style)
	style = resolveDrawStyle(style, M.TARGET.CIRCLE)
	local transform
	transform, style = splitStyleTransform(style)
	style = copyStyleInto(circleExStyle, style)
	style.radius = radius
	recordDirectImmediate("DrawRoundedBox", "round")
	local x, y, size = cx - radius, cy - radius, radius * 2
	if not transform then
		return drawRoundRectImmediate(x, y, size, size, style)
	end
	return withTransform(transform, x, y, size, size, function()
		return drawRoundRectImmediate(x, y, size, size, style)
	end)
end

local capsuleArgStyle = {}

function M.Capsule(x, y, w, h, fill, stroke, strokeWidth)
	capsuleArgStyle.radius = math_min(w, h) * 0.5
	capsuleArgStyle.fill = fill
	capsuleArgStyle.stroke = stroke
	capsuleArgStyle.strokeWidth = strokeWidth
	recordDirectImmediate("DrawRoundedBox", "round")
	return drawRoundRectImmediate(x, y, w, h, capsuleArgStyle)
end

function M.CapsuleEx(x, y, w, h, style)
	style = resolveDrawStyle(style, M.TARGET.CAPSULE)
	local transform
	transform, style = splitStyleTransform(style)
	if style.radius == nil then
		style = copyStyleInto(capsuleExStyle, style)
		style.radius = math_min(w, h) * 0.5
	end
	recordDirectImmediate("DrawRoundedBox", "round")
	if not transform then
		return drawRoundRectImmediate(x, y, w, h, style)
	end
	return withTransform(transform, x, y, w, h, function()
		return drawRoundRectImmediate(x, y, w, h, style)
	end)
end


	return {
		drawRoundRectFallback = drawRoundRectFallback,
		patternStyle = patternStyle,
		patternOffset = patternOffset,
		setupPatternConstants = setupPatternConstants,
		drawRoundRectPattern = drawRoundRectPattern,
		drawRoundRectInnerGlow = drawRoundRectInnerGlow,
		drawRoundRectOuterGlow = drawRoundRectOuterGlow,
		drawRoundRectFillPass = drawRoundRectFillPass,
		drawRoundRectStrokePass = drawRoundRectStrokePass,
		drawRoundRectImmediate = drawRoundRectImmediate,
		innerGlowStyle = innerGlowStyle,
		outerGlowStyle = outerGlowStyle,
		shadowStyle = shadowStyle,
		glowBiasPads = glowBiasPads,
		effectExtentFromSpec = effectExtentFromSpec,
	}
end
