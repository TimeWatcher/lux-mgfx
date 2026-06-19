if SERVER then return end

MGFX = MGFX or {}

function MGFX._InstallPrimitives(C)
	local M = C.M
	local materials = C.materials
	local forceFallback = C.forceFallback
	local recordDirectImmediate = C.recordDirectImmediate or function() end
	local profiler = C.profiler
	local copyStyle = C.copyStyle or function(style) return istable(style) and table.Copy(style) or {} end
	local resolveDrawStyle = C.resolveDrawStyle or copyStyle
	local copyPoints = C.copyPoints or function(points) return istable(points) and table.Copy(points) or points end
	local frameState = C.frameState
	local matOK = C.matOK
	local shadersActive = C.shadersActive or function() return not forceFallback:GetBool() and M.hasShaders() end
	local asColor = C.asColor
	local color01 = C.color01
	local setDrawColor = C.setDrawColor
	local strokeWidthValue = C.strokeWidthValue
	local strokeVisible = C.strokeVisible
	local isCulled = C.isCulled
	local radiusScalar = C.radiusScalar
	local fillFromStyle = C.fillFromStyle
	local fillVisible = C.fillVisible
	local backdropStyle = C.backdropStyle or function() return nil end
	local innerGlowStyle = C.innerGlowStyle
	local outerGlowStyle = C.outerGlowStyle
	local shadowStyle = C.shadowStyle or function() return nil end
	local patternStyle = C.patternStyle
	local patternOffset = C.patternOffset
	local drawTexturedQuad = C.drawTexturedQuad
	local drawTransformedPoly = C.drawTransformedPoly or surface.DrawPoly
	local withTransform = C.withTransform or function(_, _, _, _, _, fn) return fn() end
	local splitStyleTransform = C.splitStyleTransform or function(style) return nil, style end
	local hasTransform = C.hasTransform or function() return false end
	local drawRoundRectImmediate = C.drawRoundRectImmediate
	local setupParamMatrix = C.setupParamMatrix
	local setupConstants = C.setupConstants
	local setupExtraParams = C.setupExtraParams
	local setupLineConstants = C.setupLineConstants
	local drawLineShaderVerts = C.drawLineShaderVerts
	local drawBlurredPoly = C.drawBlurredPoly
	local FILL_SOLID = C.FILL_SOLID or 0
	local math_abs = math.abs
	local math_max = math.max
	local math_min = math.min
	local math_floor = math.floor
	local math_rad = math.rad
	local math_cos = math.cos
	local math_sin = math.sin
	local math_sqrt = math.sqrt
	local surface_DrawLine = surface.DrawLine
	local surface_SetDrawColor = surface.SetDrawColor
	local surface_SetMaterial = surface.SetMaterial
	local transparentColor = Color(0, 0, 0, 0)
	local transparentFill = {kind = FILL_SOLID, colorA = transparentColor, colorB = transparentColor}
	local chamferFillFallbackStyle = {}
	local chamferStrokeFallbackStyle = {fill = transparentColor}
	local drawMaterialPoly
	local normalizePoly
	local drawPolyImmediate
local function profileStart()
	if profiler and profiler.Start then return profiler.Start() end
	return nil
end

local function profileEnd(name, started)
	if profiler and profiler.End then profiler.End(name, started) end
end

local function chamferTuple(cuts, w, h)
	local tl, tr, br, bl
	if istable(cuts) then
		tl = tonumber(cuts.tl or cuts[1]) or 0
		tr = tonumber(cuts.tr or cuts[2]) or tl
		br = tonumber(cuts.br or cuts[3]) or tr
		bl = tonumber(cuts.bl or cuts[4]) or br
	else
		tl = tonumber(cuts) or 0
		tr, br, bl = tl, tl, tl
	end

	local limit = math_min(math_abs(w), math_abs(h)) * 0.5
	return math.Clamp(tl, 0, limit),
		math.Clamp(tr, 0, limit),
		math.Clamp(br, 0, limit),
		math.Clamp(bl, 0, limit)
end

local function chamferPoints(x, y, w, h, cuts)
	local tl, tr, br, bl = chamferTuple(cuts, w, h)
	local points = {}

	local function add(px, py)
		local last = points[#points]
		if last and math_abs(last.x - px) < 0.001 and math_abs(last.y - py) < 0.001 then return end
		points[#points + 1] = {x = px, y = py}
	end

	add(x + tl, y)
	add(x + w - tr, y)
	add(x + w, y + tr)
	add(x + w, y + h - br)
	add(x + w - br, y + h)
	add(x + bl, y + h)
	add(x, y + h - bl)
	add(x, y + tl)

	if #points > 1 then
		local first = points[1]
		local last = points[#points]
		if math_abs(first.x - last.x) < 0.001 and math_abs(first.y - last.y) < 0.001 then
			points[#points] = nil
		end
	end

	return points
end

local function drawChamferInnerGlowSpec(x, y, w, h, cuts, spec)
	if not spec then return end
	if not shadersActive() or not matOK(materials.chamfer_innerglow) then return end

	local color = spec.color
	if (color.a or 255) <= 0 then return end

	local tl, tr, br, bl = chamferTuple(cuts, w, h)
	local mat = materials.chamfer_innerglow
	local r, g, b, a = color01(color)
	setupParamMatrix(mat,
		r, g, b, a,
		w, h, 0, 0,
		tl, tr, br, bl,
		math_max(0.001, tonumber(spec.width) or 8),
		math_max(0, tonumber(spec.strength) or 1),
		math_max(0.001, tonumber(spec.falloff) or 1.65),
		0
	)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	drawTexturedQuad(x, y, w, h)
end

local function drawChamferInnerGlow(x, y, w, h, cuts, glow)
	return drawChamferInnerGlowSpec(x, y, w, h, cuts, innerGlowStyle(glow))
end

local function cutsWithGrow(cuts, grow)
	grow = math_max(0, tonumber(grow) or 0)
	if grow <= 0 then return cuts end
	if istable(cuts) and not (cuts.r and cuts.g and cuts.b) then
		return {
			tl = math_max(0, tonumber(cuts.tl) or tonumber(cuts[1]) or 0) + grow,
			tr = math_max(0, tonumber(cuts.tr) or tonumber(cuts[2]) or tonumber(cuts.tl) or tonumber(cuts[1]) or 0) + grow,
			br = math_max(0, tonumber(cuts.br) or tonumber(cuts[3]) or tonumber(cuts.tr) or tonumber(cuts[2]) or tonumber(cuts.tl) or tonumber(cuts[1]) or 0) + grow,
			bl = math_max(0, tonumber(cuts.bl) or tonumber(cuts[4]) or tonumber(cuts.br) or tonumber(cuts[3]) or tonumber(cuts.tr) or tonumber(cuts[2]) or tonumber(cuts.tl) or tonumber(cuts[1]) or 0) + grow,
		}
	end
	return (tonumber(cuts) or 0) + grow
end

local function drawChamferOuterGlowSpec(x, y, w, h, cuts, spec)
	if not spec then return end
	if not shadersActive() or not matOK(materials.chamfer_outerglow) then return end

	local color = spec.color
	if (color.a or 255) <= 0 then return end

	local grow = math_max(0, tonumber(spec.grow) or tonumber(spec.shapeSpread) or tonumber(spec.expand) or 0)
	local ox = tonumber(spec.x) or tonumber(spec.offsetX) or tonumber(spec.dx) or 0
	local oy = tonumber(spec.y) or tonumber(spec.offsetY) or tonumber(spec.dy) or 0
	local gx = x + ox - grow
	local gy = y + oy - grow
	local gw = w + grow * 2
	local gh = h + grow * 2
	local gcuts = cutsWithGrow(cuts, grow)
	local spread = math_max(1, tonumber(spec.spread) or tonumber(spec.width) or 18)
	if not hasTransform() and isCulled(gx - spread, gy - spread, gw + spread * 2, gh + spread * 2) then return end

	local tl, tr, br, bl = chamferTuple(gcuts, gw, gh)
	local mat = materials.chamfer_outerglow
	local r, g, b, a = color01(color)
	setupParamMatrix(mat,
		r, g, b, a,
		gw + spread * 2, gh + spread * 2, spread, spread,
		tl, tr, br, bl,
		math_max(0.001, tonumber(spec.width) or spread),
		math_max(0, tonumber(spec.strength) or 1),
		math_max(0.001, tonumber(spec.falloff) or 1.9),
		0
	)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	drawTexturedQuad(gx - spread, gy - spread, gw + spread * 2, gh + spread * 2)
end

local function drawChamferOuterGlow(x, y, w, h, cuts, glow)
	return drawChamferOuterGlowSpec(x, y, w, h, cuts, outerGlowStyle(glow))
end

local function drawChamferPattern(x, y, w, h, cuts, pattern)
	local spec = patternStyle(pattern)
	if not spec then return end
	if not shadersActive() or not matOK(materials.chamfer_pattern) then return end

	local color = spec.color or spec.tint
	if color and (color.a or 255) <= 0 then return end

	local tl, tr, br, bl = chamferTuple(cuts, w, h)
	local angle = math_rad(tonumber(spec.angle) or 135)
	local smoke = spec.kind == "smoke"
	local mat = materials.chamfer_pattern
	local r, g, b, a = color01(asColor(spec.color or spec.tint, Color(255, 255, 255, 24)))
	local function smokeByte(value, fallback)
		return math.Clamp(math_floor((tonumber(value) or fallback or 0) * 255 + 0.5), 0, 255)
	end
	local pz, pw
	if smoke then
		local density = smokeByte(spec.density, 0.48)
		local softness = smokeByte(spec.softness, 0.3)
		local warp = smokeByte(spec.warp, 0.85)
		pz = math_max(1, tonumber(spec.scale) or 140)
		pw = density + softness * 256 + warp * 65536
	else
		pz = math_max(1, tonumber(spec.spacing) or 12)
		pw = math_max(0.25, tonumber(spec.width) or 2)
	end
	setupParamMatrix(mat,
		r, g, b, a,
		w, h, patternOffset(spec), (smoke and 1 or 0) + (smoke and (tonumber(spec.seed) or 0) or 0),
		math_cos(angle), math_sin(angle), pz, pw,
		tl, tr, br, bl
	)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	drawTexturedQuad(x, y, w, h)
end

local function drawChamferStroke(x, y, w, h, cuts, stroke, strokeWidth)
	if not strokeVisible(stroke, strokeWidth) then return false end
	if not shadersActive() or not matOK(materials.chamfer_stroke) then return false end

	local tl, tr, br, bl = chamferTuple(cuts, w, h)
	local mat = materials.chamfer_stroke
	local r, g, b, a = color01(stroke)
	setupParamMatrix(mat,
		r, g, b, a,
		w, h, math_max(0, strokeWidthValue(strokeWidth, 0)), 0,
		tl, tr, br, bl,
		0, 0, 0, 0
	)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	drawTexturedQuad(x, y, w, h)
	return true
end

local function drawChamferBasePass(x, y, w, h, cuts, fill, stroke, strokeWidth, innerSpec)
	if not shadersActive() or not matOK(materials.chamfer) then return false end

	local tl, tr, br, bl = chamferTuple(cuts, w, h)
	local mat = materials.chamfer
	local gr, gg, gb, ga = 0, 0, 0, 0
	local glowWidth, glowStrength, glowFalloff = 0, 0, 1
	if innerSpec then
		gr, gg, gb, ga = color01(innerSpec.color or transparentColor)
		glowWidth = math_max(0.001, tonumber(innerSpec.width) or 8)
		glowStrength = math_max(0, tonumber(innerSpec.strength) or 1)
		glowFalloff = math_max(0.001, tonumber(innerSpec.falloff) or 1.65)
	end
	if not setupExtraParams or not setupExtraParams(mat,
		tl, tr, br, bl,
		gr, gg, gb, ga,
		glowWidth, glowStrength, glowFalloff, 0
	) then return false end
	setupConstants(mat, w, h, fill or transparentFill, stroke, strokeWidth, 0)
	surface_SetMaterial(mat)
	drawTexturedQuad(x, y, w, h)
	return true
end

local function chamferPointsProfiled(x, y, w, h, cuts, profiling)
	local profile = profiling and profileStart() or nil
	local points = chamferPoints(x, y, w, h, cuts)
	if profiling then profileEnd("chamfer.points", profile) end
	return points
end

local function drawChamferBoxImmediate(x, y, w, h, style, resolvedCuts)
	local profiling = profiler and profiler.IsActive and profiler.IsActive()
	local totalProfile = profiling and profileStart() or nil
	local shadowSpec = shadowStyle(style.shadow)
	local outerSpec = outerGlowStyle(style.outerGlow)
	local cullSpread = 0
	if shadowSpec then
		cullSpread = math_max(cullSpread, math_abs(tonumber(shadowSpec.x) or 0) + math_abs(tonumber(shadowSpec.y) or 0) + (tonumber(shadowSpec.spread) or tonumber(shadowSpec.width) or 0) + (tonumber(shadowSpec.grow) or 0))
	end
	if outerSpec then
		cullSpread = math_max(cullSpread, math_abs(tonumber(outerSpec.x) or 0) + math_abs(tonumber(outerSpec.y) or 0) + (tonumber(outerSpec.spread) or tonumber(outerSpec.width) or 0) + (tonumber(outerSpec.grow) or 0))
	end
	if not hasTransform() and isCulled(x - cullSpread, y - cullSpread, w + cullSpread * 2, h + cullSpread * 2) then
		if profiling then profileEnd("chamfer.immediate", totalProfile) end
		return
	end

	local points

	local profile
	if shadowSpec then
		profile = profiling and profileStart() or nil
		drawChamferOuterGlowSpec(x, y, w, h, resolvedCuts, shadowSpec)
		if profiling then profileEnd("chamfer.shadow", profile) end
	end

	if outerSpec then
		profile = profiling and profileStart() or nil
		drawChamferOuterGlowSpec(x, y, w, h, resolvedCuts, outerSpec)
		if profiling then profileEnd("chamfer.outerGlow", profile) end
	end

	profile = profiling and profileStart() or nil
	local fill = fillFromStyle(style.fill)
	local strokeWidth = strokeWidthValue(style.strokeWidth, 0)
	local pattern = style.pattern
	local strokeIsVisible = strokeVisible(style.stroke, strokeWidth)
	local fillIsVisible = fillVisible(fill)
	local innerSpec = innerGlowStyle(style.innerGlow)
	local baseDrawn = false
	local baseDrewStroke = false
	local baseDrewInnerGlow = false
	if not style.backdrop
		and (fillIsVisible or strokeIsVisible or innerSpec) then
		if pattern == nil then
			baseDrawn = drawChamferBasePass(x, y, w, h, resolvedCuts, fill, style.stroke, strokeWidth, innerSpec)
			baseDrewStroke = baseDrawn and strokeIsVisible
			baseDrewInnerGlow = baseDrawn and innerSpec
		elseif fillIsVisible then
			baseDrawn = drawChamferBasePass(x, y, w, h, resolvedCuts, fill, nil, 0)
		end
	end

	if not baseDrawn and (fillIsVisible or style.backdrop) then
		local fillStyle = chamferFillFallbackStyle
		for k in pairs(fillStyle) do
			fillStyle[k] = nil
		end
		for k, v in pairs(style) do
			fillStyle[k] = v
		end
		fillStyle.stroke = nil
		fillStyle.strokeWidth = 0
		fillStyle.pattern = nil
		points = points or chamferPointsProfiled(x, y, w, h, resolvedCuts, profiling)
		drawPolyImmediate(points, fillStyle)
	end
	if profiling then profileEnd(baseDrawn and "chamfer.fillShader" or "chamfer.fillPoly", profile) end

	if pattern ~= nil then
		profile = profiling and profileStart() or nil
		drawChamferPattern(x, y, w, h, resolvedCuts, pattern)
		if profiling then profileEnd("chamfer.pattern", profile) end
	end

	profile = profiling and profileStart() or nil
	if baseDrewStroke then
		-- Stroke was composited in the base shader to preserve fill/stroke order.
	elseif strokeIsVisible then
		if not drawChamferStroke(x, y, w, h, resolvedCuts, style.stroke, strokeWidth) then
			chamferStrokeFallbackStyle.stroke = style.stroke
			chamferStrokeFallbackStyle.strokeWidth = strokeWidth
			points = points or chamferPointsProfiled(x, y, w, h, resolvedCuts, profiling)
			drawPolyImmediate(points, chamferStrokeFallbackStyle)
		end
	end
	if profiling then profileEnd("chamfer.stroke", profile) end

	if innerSpec and not baseDrewInnerGlow then
		profile = profiling and profileStart() or nil
		drawChamferInnerGlowSpec(x, y, w, h, resolvedCuts, innerSpec)
		if profiling then profileEnd("chamfer.innerGlow", profile) end
	end
	if profiling then profileEnd("chamfer.immediate", totalProfile) end
end

function M.ChamferBoxEx(x, y, w, h, style)
	style = resolveDrawStyle(style, M.TARGET.CHAMFER_BOX)
	local transform
	transform, style = splitStyleTransform(style)
	local resolvedCuts = style.cuts or 0

	recordDirectImmediate("DrawChamferBox", "chamfer")
	if not transform then
		return drawChamferBoxImmediate(x, y, w, h, style, resolvedCuts)
	end
	return withTransform(transform, x, y, w, h, function()
		return drawChamferBoxImmediate(x, y, w, h, style, resolvedCuts)
	end)
end

local chamferBoxArgStyle = {}

function M.ChamferBox(x, y, w, h, cuts, fill, stroke, strokeWidth)
	chamferBoxArgStyle.cuts = cuts
	chamferBoxArgStyle.fill = fill
	chamferBoxArgStyle.stroke = stroke
	chamferBoxArgStyle.strokeWidth = strokeWidth
	return M.ChamferBoxEx(x, y, w, h, chamferBoxArgStyle)
end

local function drawLineRect(x, y, w, h, fill, style)
	if style.radius ~= nil or style.outerGlow or style.backdrop then
		return drawRoundRectImmediate(x, y, w, h, {
			radius = style.radius or 0,
			backdrop = style.backdrop,
			fill = fill,
			outerGlow = style.outerGlow,
		})
	end

	return drawPolyImmediate({
		{x = x, y = y},
		{x = x + w, y = y},
		{x = x + w, y = y + h},
		{x = x, y = y + h},
	}, {
		backdrop = style.backdrop,
		fill = fill,
	})
end

local function lineFallbackVerts(verts, fill, backdrop)
	return drawPolyImmediate({
		{x = verts[1].x, y = verts[1].y},
		{x = verts[2].x, y = verts[2].y},
		{x = verts[3].x, y = verts[3].y},
		{x = verts[4].x, y = verts[4].y},
	}, {
		backdrop = backdrop,
		fill = fill,
	})
end

local lineQuadVertsInto

local function drawLineQuad(x1, y1, x2, y2, strokeWidth, noCaps, verts, fill, style)
	if style.backdrop then
		local backdropVerts = lineQuadVertsInto(lineFallbackVertsScratch, x1, y1, x2, y2, strokeWidth, noCaps, 0)
		if backdropVerts then
			lineFallbackVerts(backdropVerts, transparentColor, style.backdrop)
		end
	end

	if not style.radius and not style.outerGlow and drawLineShaderVerts(verts, fill) then return end
	local fallbackVerts = lineQuadVertsInto(lineFallbackVertsScratch, x1, y1, x2, y2, strokeWidth, noCaps, 0)
	return lineFallbackVerts(fallbackVerts or verts, fill, nil)
end

local drawLineImmediate
local LINE_AA_FRINGE = 1
local LINE_NO_CAPS_UV_OFFSET = 8
local defaultLineColor = Color(255, 255, 255, 32)
local lineVertsScratch = {{}, {}, {}, {}}
local lineFallbackVertsScratch = {{}, {}, {}, {}}

lineQuadVertsInto = function(out, x1, y1, x2, y2, strokeWidth, noCaps, fringeOverride)
	local dx, dy = x2 - x1, y2 - y1
	local len = math_sqrt(dx * dx + dy * dy)
	if len <= 0 then return nil end

	local tx, ty = dx / len, dy / len
	local nx, ny = -ty, tx
	local fringe = fringeOverride == nil and LINE_AA_FRINGE or math_max(0, fringeOverride)
	local capFringe = noCaps and 0 or fringe
	local halfWidth = strokeWidth * 0.5 + fringe
	local u0 = -capFringe / len
	local u1 = 1 + capFringe / len
	local vPad = fringe / math_max(strokeWidth, 0.001)
	local vOffset = noCaps and LINE_NO_CAPS_UV_OFFSET or 0
	local v0 = vOffset - vPad
	local v1 = vOffset + 1 + vPad
	local sx, sy = x1 - tx * capFringe, y1 - ty * capFringe
	local ex, ey = x2 + tx * capFringe, y2 + ty * capFringe

	local v = out[1]
	v.x, v.y, v.u, v.v = sx + nx * halfWidth, sy + ny * halfWidth, u0, v0
	v = out[2]
	v.x, v.y, v.u, v.v = ex + nx * halfWidth, ey + ny * halfWidth, u1, v0
	v = out[3]
	v.x, v.y, v.u, v.v = ex - nx * halfWidth, ey - ny * halfWidth, u1, v1
	v = out[4]
	v.x, v.y, v.u, v.v = sx - nx * halfWidth, sy - ny * halfWidth, u0, v1
	return out
end

local function normalizeLineArgs(color, width, style)
	if istable(color) and color.r == nil and style == nil then
		style = color
		color = nil
	end

	if istable(width) and width.r == nil and style == nil then
		style = width
		width = nil
	end

	return color, width, style or {}
end

drawLineImmediate = function(x1, y1, x2, y2, color, width, style)
	color, width, style = normalizeLineArgs(color, width, style)
	local rawWidth = strokeWidthValue(width or style.width, 1)
	local strokeWidth = math_max(0, rawWidth)
	if strokeWidth <= 0 then return end
	local fill = fillFromStyle(style.fill or style.color or color or defaultLineColor)
	if not fillVisible(fill) and not style.backdrop then return end

	if math_abs(y2 - y1) < 0.001 then
		local x = math_min(x1, x2)
		local w = math_abs(x2 - x1)
		if w <= 0 then return end
		local y = y1 - strokeWidth * 0.5
		if style.radius ~= nil or style.outerGlow then
			return drawLineRect(x, y, w, strokeWidth, fill, style)
		end
	end

	if math_abs(x2 - x1) < 0.001 then
		local y = math_min(y1, y2)
		local h = math_abs(y2 - y1)
		if h <= 0 then return end
		local x = x1 - strokeWidth * 0.5
		if style.radius ~= nil or style.outerGlow then
			return drawLineRect(x, y, strokeWidth, h, fill, style)
		end
	end

	local noCaps = style.noCaps == true
	local verts = lineQuadVertsInto(lineVertsScratch, x1, y1, x2, y2, strokeWidth, noCaps)
	if not verts then return end
	return drawLineQuad(x1, y1, x2, y2, strokeWidth, noCaps, verts, fill, style)
end

function M.LineEx(x1, y1, x2, y2, style)
	style = resolveDrawStyle(style, M.TARGET.LINE)
	local transform
	transform, style = splitStyleTransform(style)

	recordDirectImmediate("DrawLine", "line")
	local width = strokeWidthValue(style.width, 1)
	local pad = math_max(1, width) * 0.5
	local bx = math_min(x1, x2) - pad
	local by = math_min(y1, y2) - pad
	local bw = math_abs(x2 - x1) + pad * 2
	local bh = math_abs(y2 - y1) + pad * 2
	if not transform then
		return drawLineImmediate(x1, y1, x2, y2, nil, nil, style)
	end
	return withTransform(transform, bx, by, bw, bh, function()
		return drawLineImmediate(x1, y1, x2, y2, nil, nil, style)
	end)
end

local lineArgStyle = {}

function M.Line(x1, y1, x2, y2, width, fill)
	lineArgStyle.width = width
	lineArgStyle.fill = fill
	recordDirectImmediate("DrawLine", "line")
	return drawLineImmediate(x1, y1, x2, y2, nil, nil, lineArgStyle)
end

local function pointXY(point)
	return tonumber(point.x or point[1]) or 0, tonumber(point.y or point[2]) or 0
end

local function signedArea(points)
	local area = 0
	for i = 1, #points do
		local ax, ay = pointXY(points[i])
		local bx, by = pointXY(points[i % #points + 1])
		area = area + ax * by - bx * ay
	end
	return area * 0.5
end

local function isConvex(points)
	local sign
	for i = 1, #points do
		local ax, ay = pointXY(points[i])
		local bx, by = pointXY(points[i % #points + 1])
		local cx, cy = pointXY(points[(i + 1) % #points + 1])
		local cross = (bx - ax) * (cy - by) - (by - ay) * (cx - bx)
		if math_abs(cross) > 1e-6 then
			local s = cross > 0
			if sign == nil then
				sign = s
			elseif sign ~= s then
				return false
			end
		end
	end
	return true
end

normalizePoly = function(points)
	local count = #points
	if count < 3 or count > 8 then return nil, "DrawPoly expects 3 to 8 vertices" end
	if not isConvex(points) then return nil, "DrawPoly expects a convex polygon" end

	local ordered = {}
	for i = 1, count do
		local x, y = pointXY(points[i])
		ordered[i] = {x = x, y = y}
	end

	if signedArea(ordered) < 0 then
		local reversed = {}
		for i = count, 1, -1 do
			reversed[#reversed + 1] = ordered[i]
		end
		ordered = reversed
	end

	local minx, miny = ordered[1].x, ordered[1].y
	local maxx, maxy = minx, miny
	for i = 2, count do
		local p = ordered[i]
		minx, miny = math_min(minx, p.x), math_min(miny, p.y)
		maxx, maxy = math_max(maxx, p.x), math_max(maxy, p.y)
	end

	local w, h = maxx - minx, maxy - miny
	if w <= 0 or h <= 0 then return nil, "DrawPoly bounds are empty" end

	for i = 1, count do
		ordered[i] = {x = ordered[i].x - minx, y = ordered[i].y - miny}
	end

	return {
		x = minx,
		y = miny,
		w = w,
		h = h,
		count = count,
		points = ordered,
	}
end

local function polyDrawVerts(poly)
	local verts = {}
	for i, p in ipairs(poly.points) do
		verts[i] = {
			x = poly.x + p.x,
			y = poly.y + p.y,
			u = p.x / poly.w,
			v = p.y / poly.h,
		}
	end
	return verts
end

local function drawPolyStroke(poly, color, strokeWidth)
	strokeWidth = strokeWidthValue(strokeWidth, 1)
	if drawLineImmediate and (shadersActive() or hasTransform()) then
		local style = {
			width = strokeWidth,
			fill = color,
			noCaps = true,
		}
		for i = 1, #poly.points do
			local a = poly.points[i]
			local b = poly.points[i % #poly.points + 1]
			drawLineImmediate(poly.x + a.x, poly.y + a.y, poly.x + b.x, poly.y + b.y, nil, nil, style)
		end
		return
	end

	setDrawColor(color)
	for i = 1, #poly.points do
		local a = poly.points[i]
		local b = poly.points[i % #poly.points + 1]
		surface_DrawLine(poly.x + a.x, poly.y + a.y, poly.x + b.x, poly.y + b.y)
	end
	M.stats.draws = M.stats.draws + #poly.points
end

local function setupPolyStrokeConstants(mat, poly, color, strokeWidth)
	local p1 = poly.points[1]
	local p2 = poly.points[2]
	local p3 = poly.points[3]
	local p4 = poly.points[4] or p3
	local r, g, b, a = color01(color)

	setupParamMatrix(mat,
		p1.x, p1.y, p2.x, p2.y,
		p3.x, p3.y, p4.x, p4.y,
		r, g, b, a,
		poly.w, poly.h, math_max(0, strokeWidthValue(strokeWidth, 0)), poly.count
	)
end

local function drawPolyStrokeShader(poly, color, strokeWidth)
	if poly.count > 4 then return false end

	local mat = materials.poly_stroke
	if not matOK(mat) then return false end

	setupPolyStrokeConstants(mat, poly, color, strokeWidth)
	surface_SetDrawColor(255, 255, 255, 255)
	drawMaterialPoly(poly, mat)
	return true
end

drawMaterialPoly = function(poly, mat)
	surface_SetMaterial(mat)
	drawTransformedPoly(polyDrawVerts(poly))
	M.stats.draws = M.stats.draws + 1
end

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

local function drawPolyBackdrop(poly, backdrop)
	local spec = backdropStyle(backdrop)
	if not spec then return nil end

	if spec.blur > 0 then
		local key = "poly" .. poly.count .. "_blur"
		drawBlurredPoly(poly, materials[key], spec.blur)
	end

	local tint = backdropTintColor(spec)
	if tint then
		local key = "poly" .. poly.count
		setupConstants(materials[key], poly.w, poly.h, M.Solid(tint), nil, 0, 0)
		drawMaterialPoly(poly, materials[key])
	end

	return spec
end

local function polyShadowBounds(poly, shadow)
	if not shadow or not shadow.color or (shadow.color.a or 255) <= 0 then return nil end

	local width = math_max(0.001, tonumber(shadow.width) or 12)
	local grow = math_max(0, tonumber(shadow.grow) or 0)
	local spread = math_max(1, tonumber(shadow.spread) or width)
	local padding = grow + math_max(spread, width)
	local ox = tonumber(shadow.x) or 0
	local oy = tonumber(shadow.y) or 0

	return {
		x = poly.x + ox - padding,
		y = poly.y + oy - padding,
		w = poly.w + padding * 2,
		h = poly.h + padding * 2,
		ox = ox,
		oy = oy,
		width = width,
		grow = grow,
		falloff = math_max(0.001, tonumber(shadow.falloff) or 1.7),
		strength = math_max(0, tonumber(shadow.strength) or 1),
	}
end

local function includeBounds(x, y, w, h, bounds)
	if not bounds then return x, y, w, h end
	local minX = math_min(x, bounds.x)
	local minY = math_min(y, bounds.y)
	local maxX = math_max(x + w, bounds.x + bounds.w)
	local maxY = math_max(y + h, bounds.y + bounds.h)
	return minX, minY, maxX - minX, maxY - minY
end

local function shadowVertex(poly, point, bounds)
	if not point then return 0, 0 end
	return poly.x + point.x + bounds.ox - bounds.x, poly.y + point.y + bounds.oy - bounds.y
end

local function setupPolyShadowConstants(mat, poly, shadow, bounds)
	local p = poly.points
	local x1, y1 = shadowVertex(poly, p[1], bounds)
	local x2, y2 = shadowVertex(poly, p[2], bounds)
	local x3, y3 = shadowVertex(poly, p[3], bounds)
	local x4, y4 = shadowVertex(poly, p[4], bounds)
	local x5, y5 = shadowVertex(poly, p[5], bounds)
	local x6, y6 = shadowVertex(poly, p[6], bounds)
	local x7, y7 = shadowVertex(poly, p[7], bounds)
	local x8, y8 = shadowVertex(poly, p[8], bounds)
	local r, g, b, a = color01(shadow.color)

	setupParamMatrix(mat,
		x1, y1, x2, y2,
		x3, y3, x4, y4,
		x5, y5, x6, y6,
		x7, y7, x8, y8
	)
	setupExtraParams(mat,
		r, g, b, a,
		bounds.w, bounds.h, bounds.width, bounds.falloff,
		bounds.strength, bounds.grow, 0, 0,
		0, 0, 0, 0
	)
end

local function drawPolyShadow(poly, shadow, bounds)
	if not bounds or not setupExtraParams then return false end

	local mat = materials["poly" .. poly.count .. "_shadow"]
	if not matOK(mat) then return false end

	setupPolyShadowConstants(mat, poly, shadow, bounds)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	drawTexturedQuad(bounds.x, bounds.y, bounds.w, bounds.h)
	return true
end

local function drawPolyPattern(poly, pattern)
	local spec = patternStyle(pattern)
	if not spec then return end
	if not shadersActive() or not matOK(materials.poly_pattern) then return end

	local color = spec.color or spec.tint
	if color and (color.a or 255) <= 0 then return end

	local mat = materials.poly_pattern
	local r, g, b, a = color01(asColor(spec.color or spec.tint, Color(255, 255, 255, 24)))
	local angle = math_rad(tonumber(spec.angle) or 135)
	local smoke = spec.kind == "smoke"
	local pz, pw, ox, oy, oz, ow
	if smoke then
		pz = math_max(1, tonumber(spec.scale) or 140)
		pw = math.Clamp(tonumber(spec.density) or 0.48, 0, 1)
		ox, oy, oz, ow = patternOffset(spec), 1, math_max(0.001, tonumber(spec.softness) or 0.3), math_max(0, tonumber(spec.warp) or 0.85)
	else
		pz = math_max(1, tonumber(spec.spacing) or 12)
		pw = math_max(0.25, tonumber(spec.width) or 2)
		ox, oy, oz, ow = patternOffset(spec), 0, 0, 0
	end
	setupParamMatrix(mat,
		r, g, b, a,
		poly.w, poly.h, smoke and (tonumber(spec.seed) or 0) or 0, 0,
		math_cos(angle), math_sin(angle), pz, pw,
		ox, oy, oz, ow
	)

	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	drawTransformedPoly(polyDrawVerts(poly))
	M.stats.draws = M.stats.draws + 1
end

local function drawPolyFallback(points, style)
	M.stats.fallbacks = M.stats.fallbacks + 1
	local fill = fillFromStyle(style.fill)
	local hasFill = fillVisible(fill)
	local strokeWidth = strokeWidthValue(style.strokeWidth, 0)
	local hasStroke = strokeVisible(style.stroke, strokeWidth)

	if hasFill then
		setDrawColor(fill.colorA or color_white)
		drawTransformedPoly(points)
		M.stats.draws = M.stats.draws + 1
	end

	if hasStroke then
		setDrawColor(style.stroke)
		if hasTransform() and drawLineImmediate then
			for i = 1, #points do
				local a = points[i]
				local b = points[i % #points + 1]
				drawLineImmediate(a.x or a[1], a.y or a[2], b.x or b[1], b.y or b[2], nil, nil, {
					width = strokeWidth,
					fill = style.stroke,
					noCaps = true,
				})
			end
		else
			for i = 1, #points do
				local a = points[i]
				local b = points[i % #points + 1]
				surface_DrawLine(a.x or a[1], a.y or a[2], b.x or b[1], b.y or b[2])
			end
			M.stats.draws = M.stats.draws + #points
		end
	end
end

drawPolyImmediate = function(points, style)
	style = style or {}
	local poly, err = normalizePoly(points)
	if not poly then
		if M.debug then print("[MGFX] " .. err) end
		return
	end

	local shadow = shadowStyle(style.shadow)
	local shadowBounds = polyShadowBounds(poly, shadow)
	local cullX, cullY, cullW, cullH = includeBounds(poly.x, poly.y, poly.w, poly.h, shadowBounds)
	if not hasTransform() and isCulled(cullX, cullY, cullW, cullH) then return end

	if not shadersActive() then
		return drawPolyFallback(points, style)
	end

	drawPolyShadow(poly, shadow, shadowBounds)

	local backdrop = drawPolyBackdrop(poly, style.backdrop)

	local key = "poly" .. poly.count
	local mat = materials[key]
	local fill = fillFromStyle(style.fill)
	local hasFill = fillVisible(fill)
	local strokeWidth = strokeWidthValue(style.strokeWidth, 0)
	local hasStroke = strokeVisible(style.stroke, strokeWidth)

	if hasFill then
		setupConstants(mat, poly.w, poly.h, fill, nil, 0, 0)
		drawMaterialPoly(poly, mat)
	end

	drawPolyPattern(poly, style.pattern)

	if hasStroke then
		drawPolyStroke(poly, style.stroke, strokeWidth)
	end
end

function M.PolyEx(points, style)
	style = resolveDrawStyle(style, M.TARGET.POLY)
	local transform
	transform, style = splitStyleTransform(style)

	recordDirectImmediate("DrawPoly", "poly")
	local poly = normalizePoly(points)
	if not poly then return drawPolyImmediate(points, style) end
	if not transform then
		return drawPolyImmediate(points, style)
	end
	return withTransform(transform, poly.x, poly.y, poly.w, poly.h, function()
		return drawPolyImmediate(points, style)
	end)
end

local polyArgStyle = {}
local regularPolyArgStyle = {}
local diamondArgStyle = {}
local caretArgStyle = {}
local regularPolyScratch = {}
local diamondScratch = {{}, {}, {}, {}}
local caretScratch = {{}, {}, {}}

local function clearPoints(points)
	for i = #points, 1, -1 do
		points[i] = nil
	end
	return points
end

local function setPoint(points, index, x, y)
	local point = points[index] or {}
	points[index] = point
	point.x = x
	point.y = y
	point.u = nil
	point.v = nil
	point.color = nil
end

local function regularPolyPoints(cx, cy, radius, sides, rotation)
	local points = clearPoints(regularPolyScratch)
	local count = math.Clamp(math_floor(tonumber(sides) or 3), 3, 8)
	local r = math_max(0, tonumber(radius) or 0)
	local start = math_rad(tonumber(rotation) or -90)
	local step = math_rad(360 / count)

	for i = 1, count do
		local angle = start + (i - 1) * step
		setPoint(points, i, cx + math_cos(angle) * r, cy + math_sin(angle) * r)
	end

	return points
end

local function diamondPoints(x, y, w, h)
	setPoint(diamondScratch, 1, x + w * 0.5, y)
	setPoint(diamondScratch, 2, x + w, y + h * 0.5)
	setPoint(diamondScratch, 3, x + w * 0.5, y + h)
	setPoint(diamondScratch, 4, x, y + h * 0.5)
	return diamondScratch
end

local function caretPoints(x, y, w, h, direction)
	direction = direction or "right"

	if direction == "up" then
		setPoint(caretScratch, 1, x + w * 0.5, y)
		setPoint(caretScratch, 2, x + w, y + h)
		setPoint(caretScratch, 3, x, y + h)
	elseif direction == "down" then
		setPoint(caretScratch, 1, x, y)
		setPoint(caretScratch, 2, x + w, y)
		setPoint(caretScratch, 3, x + w * 0.5, y + h)
	elseif direction == "left" then
		setPoint(caretScratch, 1, x + w, y)
		setPoint(caretScratch, 2, x + w, y + h)
		setPoint(caretScratch, 3, x, y + h * 0.5)
	else
		setPoint(caretScratch, 1, x, y)
		setPoint(caretScratch, 2, x + w, y + h * 0.5)
		setPoint(caretScratch, 3, x, y + h)
	end

	return caretScratch
end

function M.Poly(points, fill, stroke, strokeWidth)
	polyArgStyle.fill = fill
	polyArgStyle.stroke = stroke
	polyArgStyle.strokeWidth = strokeWidth
	return M.PolyEx(points, polyArgStyle)
end

function M.RegularPolyEx(cx, cy, radius, sides, style)
	style = style or {}
	return M.PolyEx(regularPolyPoints(cx, cy, radius, sides, style.rotation or style.angle), style)
end

function M.RegularPoly(cx, cy, radius, sides, rotation, fill, stroke, strokeWidth)
	regularPolyArgStyle.rotation = rotation
	regularPolyArgStyle.fill = fill
	regularPolyArgStyle.stroke = stroke
	regularPolyArgStyle.strokeWidth = strokeWidth
	return M.RegularPolyEx(cx, cy, radius, sides, regularPolyArgStyle)
end

function M.DiamondEx(x, y, w, h, style)
	return M.PolyEx(diamondPoints(x, y, w, h), style)
end

function M.Diamond(x, y, w, h, fill, stroke, strokeWidth)
	diamondArgStyle.fill = fill
	diamondArgStyle.stroke = stroke
	diamondArgStyle.strokeWidth = strokeWidth
	return M.DiamondEx(x, y, w, h, diamondArgStyle)
end

function M.CaretEx(x, y, w, h, style)
	style = style or {}
	return M.PolyEx(caretPoints(x, y, w, h, style.direction or style.dir), style)
end

function M.Caret(x, y, w, h, direction, fill, stroke, strokeWidth)
	caretArgStyle.direction = direction
	caretArgStyle.fill = fill
	caretArgStyle.stroke = stroke
	caretArgStyle.strokeWidth = strokeWidth
	return M.CaretEx(x, y, w, h, caretArgStyle)
end

	C.chamferTuple = chamferTuple
	C.chamferPoints = chamferPoints
	C.drawChamferInnerGlow = drawChamferInnerGlow
	C.drawChamferOuterGlow = drawChamferOuterGlow
	C.drawChamferPattern = drawChamferPattern
	C.drawLineImmediate = drawLineImmediate
	C.normalizePoly = normalizePoly
	C.drawPolyImmediate = drawPolyImmediate
end
