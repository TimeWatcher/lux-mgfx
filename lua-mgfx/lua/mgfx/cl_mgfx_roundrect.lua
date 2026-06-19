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
	local setupParamMatrix = C.setupParamMatrix
	local setupConstants = C.setupConstants
	local setupExtraParams = C.setupExtraParams
	local drawTexturedQuad = C.drawTexturedQuad
	local drawTransformedPoly = C.drawTransformedPoly or surface.DrawPoly
	local withTransform = C.withTransform or function(_, _, _, _, _, fn) return fn() end
	local splitStyleTransform = C.splitStyleTransform or function(style) return nil, style end
	local hasTransform = C.hasTransform or function() return false end
	local drawBlurredQuad = C.drawBlurredQuad
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

	local color = fill.colorA or color_white
	local r, g, b, a = color01(color)
	setupParamMatrix(mat,
		r, g, b, a,
		w, h, 0, radiusValue,
		0, 0, 1, 0,
		0, 0, 0, 0
	)
	surface_SetDrawColor(color.r or 255, color.g or 255, color.b or 255, color.a == nil and 255 or color.a)
	surface_SetMaterial(mat)
	drawTexturedQuad(x, y, w, h)
	return true
end

local transparentFillColor = Color(0, 0, 0, 0)
local transparentFill = {kind = FILL_SOLID, colorA = transparentFillColor, colorB = transparentFillColor}
local solidFillScratch = {kind = FILL_SOLID, colorA = color_white, colorB = color_white}
local fallbackRoundRectVerts = {}
local fallbackStrokeVerts = {{}, {}, {}, {}}
local circleExStyle = {}
local capsuleExStyle = {}

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
	local fill = hotFillFromStyle(style.fill)
	local radius = style.radius or 0
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
	if glow == true then
		return {
			color = Color(76, 190, 255, 34),
			width = 7,
			strength = 1,
			falloff = glowSoftnessToFalloff(0.55),
		}
	end

	if istable(glow) and glow.r and glow.g and glow.b then
		return {
			color = glow,
			width = 7,
			strength = 1,
			falloff = glowSoftnessToFalloff(0.55),
		}
	end

	if not istable(glow) then return nil end

	return {
		color = asColor(glow.color or glow.tint, Color(76, 190, 255, 34)),
		width = math_max(1, tonumber(glow.size) or tonumber(glow.width) or 7),
		strength = tonumber(glow.opacity) or tonumber(glow.strength) or 1,
		falloff = tonumber(glow.falloff) or glowSoftnessToFalloff(glow.softness, 0.55),
	}
end

outerGlowStyle = function(glow)
	if not glow then return nil end
	if glow == true then
		return {
			color = Color(76, 190, 255, 88),
			x = 0,
			y = 0,
			width = 18,
			spread = 18,
			grow = 0,
			strength = 1,
			falloff = glowSoftnessToFalloff(0.54),
		}
	end

	if istable(glow) and glow.r and glow.g and glow.b then
		return {
			color = glow,
			x = 0,
			y = 0,
			width = 18,
			spread = 18,
			grow = 0,
			strength = 1,
			falloff = glowSoftnessToFalloff(0.54),
		}
	end

	if not istable(glow) then return nil end

	local offset = istable(glow.offset) and glow.offset or nil
	local ox = tonumber(glow.x) or tonumber(glow.offsetX) or tonumber(glow.dx) or tonumber(glow[1]) or (offset and (tonumber(offset.x) or tonumber(offset[1]))) or 0
	local oy = tonumber(glow.y) or tonumber(glow.offsetY) or tonumber(glow.dy) or tonumber(glow[2]) or (offset and (tonumber(offset.y) or tonumber(offset[2]))) or 0
	local width = math_max(1, tonumber(glow.size) or tonumber(glow.width) or tonumber(glow.blur) or tonumber(glow.radius) or tonumber(glow.spread) or 18)
	return {
		color = asColor(glow.color or glow.tint, Color(76, 190, 255, 88)),
		x = ox,
		y = oy,
		width = width,
		spread = math_max(1, tonumber(glow.spread) or width),
		grow = math_max(0, tonumber(glow.grow) or tonumber(glow.expand) or tonumber(glow.shapeSpread) or 0),
		strength = tonumber(glow.opacity) or tonumber(glow.strength) or 1,
		falloff = tonumber(glow.falloff) or glowSoftnessToFalloff(glow.softness, 0.54),
	}
end

shadowStyle = function(shadow)
	if not shadow then return nil end
	if shadow == true then
		return {
			color = Color(0, 0, 0, 132),
			x = 0,
			y = 4,
			width = 12,
			spread = 12,
			grow = 0,
			strength = 1,
			falloff = glowSoftnessToFalloff(0.62),
		}
	end

	if istable(shadow) and shadow.r and shadow.g and shadow.b then
		return {
			color = shadow,
			x = 0,
			y = 4,
			width = 12,
			spread = 12,
			grow = 0,
			strength = 1,
			falloff = glowSoftnessToFalloff(0.62),
		}
	end

	if not istable(shadow) then
		local blur = math_max(0.001, tonumber(shadow) or 12)
		return {
			color = Color(0, 0, 0, 132),
			x = 0,
			y = 4,
			width = blur,
			spread = math_max(1, blur),
			grow = 0,
			strength = 1,
			falloff = glowSoftnessToFalloff(0.62),
		}
	end

	local offset = istable(shadow.offset) and shadow.offset or nil
	local ox = tonumber(shadow.x) or tonumber(shadow.offsetX) or tonumber(shadow.dx) or tonumber(shadow[1]) or (offset and (tonumber(offset.x) or tonumber(offset[1]))) or 0
	local oy = tonumber(shadow.y) or tonumber(shadow.offsetY) or tonumber(shadow.dy) or tonumber(shadow[2]) or (offset and (tonumber(offset.y) or tonumber(offset[2]))) or 4
	local blur = math_max(0.001, tonumber(shadow.blur) or tonumber(shadow.radius) or tonumber(shadow.size) or tonumber(shadow.width) or 12)
	local grow = math_max(0, tonumber(shadow.spread) or tonumber(shadow.grow) or tonumber(shadow.expand) or tonumber(shadow.shapeSpread) or 0)
	return {
		color = asColor(shadow.color or shadow.tint, Color(0, 0, 0, 132)),
		x = ox,
		y = oy,
		width = blur,
		spread = math_max(1, tonumber(shadow.extent) or tonumber(shadow.padding) or blur),
		grow = grow,
		strength = tonumber(shadow.opacity) or tonumber(shadow.strength) or 1,
		falloff = tonumber(shadow.falloff) or glowSoftnessToFalloff(shadow.softness, 0.62),
	}
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
	setupPatternConstants(mat, w, h, radiusScalar(radius, w, h), spec)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	drawTexturedQuad(x, y, w, h)
end

local function drawRoundRectInnerGlowSpec(x, y, w, h, radius, spec)
	if not spec then return end

	local color = spec.color
	if (color.a or 255) <= 0 then return end
	if not shadersActive() or not matOK(materials.roundrect_innerglow) then return end

	local mat = materials.roundrect_innerglow
	local r, g, b, a = color01(color)
	setupParamMatrix(mat,
		r, g, b, a,
		w, h, 0, radiusScalar(radius, w, h),
		math_max(0.001, tonumber(spec.width) or 8),
		math_max(0, tonumber(spec.strength) or 1),
		math_max(0.001, tonumber(spec.falloff) or 1.65),
		0,
		0, 0, 0, 0
	)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	drawTexturedQuad(x, y, w, h)
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

local function drawRoundRectOuterGlowSpec(x, y, w, h, radius, spec)
	if not spec then return end

	local color = spec.color
	if (color.a or 255) <= 0 then return end
	if not shadersActive() or not matOK(materials.roundrect_outerglow) then return end

	local grow = math_max(0, tonumber(spec.grow) or tonumber(spec.shapeSpread) or tonumber(spec.expand) or 0)
	local ox = tonumber(spec.x) or tonumber(spec.offsetX) or tonumber(spec.dx) or 0
	local oy = tonumber(spec.y) or tonumber(spec.offsetY) or tonumber(spec.dy) or 0
	local gx = x + ox - grow
	local gy = y + oy - grow
	local gw = w + grow * 2
	local gh = h + grow * 2
	local gr = radiusWithGrow(radius, grow)
	local spread = math_max(1, tonumber(spec.spread) or tonumber(spec.width) or 18)
	local sx, sy = gx - spread, gy - spread
	local sw, sh = gw + spread * 2, gh + spread * 2
	local mat = materials.roundrect_outerglow
	local r, g, b, a = color01(color)

	setupParamMatrix(mat,
		r, g, b, a,
		sw, sh, 0, 0,
		spread, spread, gw, gh,
		radiusScalar(gr, gw, gh),
		math_max(0.001, tonumber(spec.width) or spread),
		math_max(0, tonumber(spec.strength) or 1),
		math_max(0.001, tonumber(spec.falloff) or 1.9)
	)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	drawTexturedQuad(sx, sy, sw, sh)
end

local function drawRoundRectOuterGlow(x, y, w, h, radius, glow)
	return drawRoundRectOuterGlowSpec(x, y, w, h, radius, outerGlowStyle(glow))
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

local function drawRoundRectBackdrop(x, y, w, h, radius, backdrop)
	local spec = backdropStyle(backdrop)
	if not spec then return nil end

	if spec.blur > 0 then
		drawBlurredQuad(materials.roundrect_blur, x, y, w, h, radiusScalar(radius, w, h), spec.blur)
	end

	local tint = backdropTintColor(spec)
	if tint then
		drawRoundRectFillPass(x, y, w, h, radius, hotFillFromStyle(tint))
	end

	return spec
end

drawRoundRectFillPass = function(x, y, w, h, radius, fill)
	local mat = materials.roundrect
	setupConstants(mat, w, h, fill, nil, 0, radiusScalar(radius, w, h))
	surface_SetMaterial(mat)
	drawTexturedQuad(x, y, w, h)
end

local function drawRoundRectStrokePass(x, y, w, h, radius, stroke, strokeWidth)
	if not strokeVisible(stroke, strokeWidth) then return end
	if shadersActive() and matOK(materials.roundrect_stroke) then
		local mat = materials.roundrect_stroke
		local r, g, b, a = color01(stroke)
		setupParamMatrix(mat,
			r, g, b, a,
			w, h, math_max(0, strokeWidthValue(strokeWidth, 0)), radiusScalar(radius, w, h),
			0, 0, 1, 0,
			0, 0, 0, 0
		)
		surface_SetMaterial(mat)
		surface_SetDrawColor(255, 255, 255, 255)
		drawTexturedQuad(x, y, w, h)
		return
	end

	local mat = materials.roundrect
	setupConstants(mat, w, h, transparentFill, stroke, strokeWidth, radiusScalar(radius, w, h))
	surface_SetMaterial(mat)
	drawTexturedQuad(x, y, w, h)
end

local function drawRoundRectFxPass(x, y, w, h, radius, fill, stroke, strokeWidth, innerSpec)
	if not setupExtraParams or not matOK(materials.roundrect_fx) then return false end

	local mat = materials.roundrect_fx
	local gr, gg, gb, ga = 0, 0, 0, 0
	local glowWidth, glowStrength, glowFalloff = 0, 0, 1
	if innerSpec then
		gr, gg, gb, ga = color01(innerSpec.color or transparentFillColor)
		glowWidth = math_max(0.001, tonumber(innerSpec.width) or 8)
		glowStrength = math_max(0, tonumber(innerSpec.strength) or 1)
		glowFalloff = math_max(0.001, tonumber(innerSpec.falloff) or 1.65)
	end

	if not setupExtraParams(mat,
		gr, gg, gb, ga,
		glowWidth, glowStrength, glowFalloff, 0
	) then return false end

	setupConstants(mat, w, h, fill, stroke, strokeWidth, radiusScalar(radius, w, h))
	surface_SetMaterial(mat)
	drawTexturedQuad(x, y, w, h)
	return true
end

drawRoundRectImmediate = function(x, y, w, h, style)
	local profiling = profiler and profiler.IsActive and profiler.IsActive()
	local totalProfile = profiling and profileStart() or nil
	style = style or {}
	local shadowSpec = shadowStyle(style.shadow)
	local outerSpec = outerGlowStyle(style.outerGlow)
	local shaderReady = shadersActive()
	local cullSpread = 0
	if shaderReady then
		if shadowSpec then
			cullSpread = math_max(cullSpread, math_abs(tonumber(shadowSpec.x) or 0) + math_abs(tonumber(shadowSpec.y) or 0) + (tonumber(shadowSpec.spread) or tonumber(shadowSpec.width) or 0) + (tonumber(shadowSpec.grow) or 0))
		end
		if outerSpec then
			cullSpread = math_max(cullSpread, math_abs(tonumber(outerSpec.x) or 0) + math_abs(tonumber(outerSpec.y) or 0) + (tonumber(outerSpec.spread) or tonumber(outerSpec.width) or 0) + (tonumber(outerSpec.grow) or 0))
		end
	end
	if not hasTransform() and isCulled(x - cullSpread, y - cullSpread, w + cullSpread * 2, h + cullSpread * 2) then
		if profiling then profileEnd("round.immediate", totalProfile) end
		return
	end

	if not shaderReady then
		local profile = profiling and profileStart() or nil
		drawRoundRectFallback(x, y, w, h, style)
		drawRoundRectInnerGlow(x, y, w, h, style.radius or 0, style.innerGlow)
		if profiling then
			profileEnd("round.fallback", profile)
			profileEnd("round.immediate", totalProfile)
		end
		return
	end

	local radius = style.radius or 0
	if shadowSpec then
		local profile = profiling and profileStart() or nil
		drawRoundRectOuterGlowSpec(x, y, w, h, radius, shadowSpec)
		if profiling then profileEnd("round.shadow", profile) end
	end

	local profile
	if outerSpec then
		profile = profiling and profileStart() or nil
		drawRoundRectOuterGlowSpec(x, y, w, h, radius, outerSpec)
		if profiling then profileEnd("round.outerGlow", profile) end
	end

	local backdrop
	if style.backdrop ~= nil then
		profile = profiling and profileStart() or nil
		backdrop = drawRoundRectBackdrop(x, y, w, h, radius, style.backdrop)
		if profiling then profileEnd("round.backdrop", profile) end
	end

	if backdrop then
		-- Backdrop alone is a valid shape pass; fill/stroke may be fully transparent.
	end

	local fill = hotFillFromStyle(style.fill)
	local strokeWidth = strokeWidthValue(style.strokeWidth, 0)
	local innerSpec = innerGlowStyle(style.innerGlow)
	local hasFill = fillVisible(fill)
	local hasStroke = strokeVisible(style.stroke, strokeWidth)
	if not backdrop and not hasFill and not hasStroke and style.pattern == nil and not innerSpec then
		if profiling then profileEnd("round.immediate", totalProfile) end
		return
	end

	local mat = materials.roundrect
	local useLayered = style.pattern ~= nil
	local innerGlowDrawn = false
	if useLayered then
		profile = profiling and profileStart() or nil
		if hasFill then
			drawRoundRectFillPass(x, y, w, h, radius, fill)
		end
		drawRoundRectPattern(x, y, w, h, radius, style.pattern)
		if hasStroke then
			drawRoundRectStrokePass(x, y, w, h, radius, style.stroke, strokeWidth)
		end
		if profiling then profileEnd("round.layered", profile) end
	else
		profile = profiling and profileStart() or nil
		local radiusValue = radiusScalar(radius, w, h)
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
		if (hasStroke or innerSpec) and drawRoundRectFxPass(x, y, w, h, radius, fill, style.stroke, strokeWidth, innerSpec) then
			baseKind = "round.base.fx"
			innerGlowDrawn = true
		elseif baseKind == "round.base.solidRect"
			and fill.kind == FILL_SOLID
			and style.shadow == nil
			and style.outerGlow == nil
			and style.innerGlow == nil
			and backdrop == nil
			and not hasTransform() then
			drawSolidRectFast(x, y, w, h, fill)
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
			setupConstants(mat, w, h, fill, style.stroke, strokeWidth, radiusValue)
			surface_SetMaterial(mat)
			drawTexturedQuad(x, y, w, h)
		end
		if profiling then profileEndBase(baseKind, profile) end
	end

	if innerSpec and not innerGlowDrawn then
		profile = profiling and profileStart() or nil
		drawRoundRectInnerGlowSpec(x, y, w, h, radius, innerSpec)
		if profiling then profileEnd("round.innerGlow", profile) end
	end
	if profiling then profileEnd("round.immediate", totalProfile) end
end

function M.RoundedBoxEx(x, y, w, h, style)
	style = resolveDrawStyle(style, M.TARGET.ROUNDED_BOX)
	local transform
	transform, style = splitStyleTransform(style)
	recordDirectImmediate("DrawRoundedBox", "round")
	if not transform then
		return drawRoundRectImmediate(x, y, w, h, style)
	end
	return withTransform(transform, x, y, w, h, function()
		return drawRoundRectImmediate(x, y, w, h, style)
	end)
end

local roundedBoxArgStyle = {}

function M.RoundedBox(x, y, w, h, radius, fill, stroke, strokeWidth)
	roundedBoxArgStyle.radius = radius
	roundedBoxArgStyle.fill = fill
	roundedBoxArgStyle.stroke = stroke
	roundedBoxArgStyle.strokeWidth = strokeWidth
	recordDirectImmediate("DrawRoundedBox", "round")
	return drawRoundRectImmediate(x, y, w, h, roundedBoxArgStyle)
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
	}
end
