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
	local glowBiasPads = C.glowBiasPads or function(base, x, y, minPad)
		minPad = minPad or 1
		local pad = math.max(minPad, tonumber(base) or minPad)
		local ox = tonumber(x) or 0
		local oy = tonumber(y) or 0
		return math.max(minPad, pad - ox), math.max(minPad, pad - oy), math.max(minPad, pad + ox), math.max(minPad, pad + oy)
	end
	local effectExtentFromSpec = C.effectExtentFromSpec or function(spec, defaultWidth)
		local width = math.max(0.001, tonumber(spec and spec.width) or defaultWidth or 18)
		local falloff = math.max(0.35, tonumber(spec and spec.falloff) or 1.9)
		local sigma = math.max(width / math.sqrt(falloff) * 0.72, 0.35)
		return math.max(1, tonumber(spec and spec.spread) or width, sigma * 3.72)
	end
	local patternStyle = C.patternStyle
	local patternOffset = C.patternOffset
	local drawTexturedQuad = C.drawTexturedQuad
	local drawTexturedQuadUV = C.drawTexturedQuadUV
	local drawTransformedPoly = C.drawTransformedPoly or surface.DrawPoly
	local withTransform = C.withTransform or function(_, _, _, _, _, fn) return fn() end
	local splitStyleTransform = C.splitStyleTransform or function(style) return nil, style end
	local hasTransform = C.hasTransform or function() return false end
	local withPanelEffectBleed = assert(C.withPanelEffectBleed, "MGFX panel bleed helper unavailable")
	local drawRoundRectImmediate = C.drawRoundRectImmediate
	local setupParamMatrix = C.setupParamMatrix
	local setupConstants = C.setupConstants
	local setupExtraParams = C.setupExtraParams
	local setupLineConstants = C.setupLineConstants
	local drawLineShaderVerts = C.drawLineShaderVerts
	local drawBlurredCustomQuad = C.drawBlurredCustomQuad
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

local function effectBleedFromDrawRect(x, y, w, h, drawX, drawY, drawW, drawH)
	local left = math_max(0, x - drawX)
	local top = math_max(0, y - drawY)
	local right = math_max(0, drawX + drawW - (x + w))
	local bottom = math_max(0, drawY + drawH - (y + h))
	return left, top, right, bottom
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

local function drawChamferOuterGlowSpec(x, y, w, h, cuts, spec, biasOffset)
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
	local width = math_max(0.001, tonumber(spec.width) or 18)
	local spread = effectExtentFromSpec(spec, 18)
	local left = spread
	local top = spread
	local right = spread
	local bottom = spread
	if biasOffset then
		left, top, right, bottom = glowBiasPads(spread, ox, oy)
		gx = x - grow
		gy = y - grow
	end
	local sw = gw + left + right
	local sh = gh + top + bottom
	if not hasTransform() and isCulled(gx - left, gy - top, sw, sh) then return end

	local tl, tr, br, bl = chamferTuple(gcuts, gw, gh)
	local mat = materials.chamfer_outerglow
	setupParamMatrix(mat,
		sw, sh, left, top,
		gw, gh, tl, tr,
		br, bl, width, math_max(0.001, tonumber(spec.falloff) or 1.9),
		math_max(0, tonumber(spec.strength) or 1), 0, 0, 0
	)
	local sx, sy = gx - left, gy - top
	local bleedLeft, bleedTop, bleedRight, bleedBottom = effectBleedFromDrawRect(x, y, w, h, sx, sy, sw, sh)
	withPanelEffectBleed(bleedLeft, bleedTop, bleedRight, bleedBottom, function()
		surface_SetMaterial(mat)
		setDrawColor(color)
		drawTexturedQuad(sx, sy, sw, sh)
	end)
end

local function drawChamferShadowSpec(x, y, w, h, cuts, spec)
	if not spec then return end
	if not shadersActive() or not matOK(materials.chamfer_shadow) then return end

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
	local width = math_max(0.001, tonumber(spec.width) or 18)
	local spread = effectExtentFromSpec(spec, 18)
	local sw = gw + spread * 2
	local sh = gh + spread * 2
	local tl, tr, br, bl = chamferTuple(gcuts, gw, gh)
	local mat = materials.chamfer_shadow
	setupParamMatrix(mat,
		sw, sh, spread, spread,
		gw, gh, tl, tr,
		br, bl, width, math_max(0.001, tonumber(spec.falloff) or 1.9),
		math_max(0, tonumber(spec.strength) or 1), 0, 0, 0
	)
	local sx, sy = gx - spread, gy - spread
	local bleedLeft, bleedTop, bleedRight, bleedBottom = effectBleedFromDrawRect(x, y, w, h, sx, sy, sw, sh)
	withPanelEffectBleed(bleedLeft, bleedTop, bleedRight, bleedBottom, function()
		surface_SetMaterial(mat)
		setDrawColor(color)
		drawTexturedQuad(sx, sy, sw, sh)
	end)
end

local function chamferBackdropTintColor(spec)
	if not spec or not spec.tint then return nil end
	local tint = spec.tint
	local alpha = (tint.a == nil and 255 or tint.a) * (spec.opacity == nil and 1 or spec.opacity)
	if alpha <= 0 then return nil end
	return Color(
		tint.r or 0,
		tint.g or 0,
		tint.b or 0,
		math_floor(math.Clamp(alpha, 0, 255) + 0.5)
	)
end

local drawChamferBasePass

local function drawChamferBackdrop(x, y, w, h, cuts, backdrop)
	local spec = backdropStyle(backdrop)
	if not spec then return nil end
	if not shadersActive() then return nil end

	local pad = math_max(0, tonumber(spec.padding) or 0)
	local bx = x - pad
	local by = y - pad
	local bw = w + pad * 2
	local bh = h + pad * 2
	local bcuts = cutsWithGrow(cuts, pad)
	local tl, tr, br, bl = chamferTuple(bcuts, bw, bh)

	if spec.blur > 0 and matOK(materials.chamfer_backdrop) and drawBlurredCustomQuad then
		local mat = materials.chamfer_backdrop
		drawBlurredCustomQuad(mat, bx, by, bw, bh, spec.blur, function(passMat, vertical, intensity)
			setupParamMatrix(passMat,
				bw, bh, 0, 0,
				bw, bh, tl, tr,
				br, bl, 0, 0,
				vertical and 1 or 0, intensity or 1, 0, 0
			)
		end)
	end

	local tint = chamferBackdropTintColor(spec)
	if tint then
		drawChamferBasePass(bx, by, bw, bh, bcuts, fillFromStyle(tint), nil, 0, nil)
	end

	return spec
end

local function drawChamferOuterGlow(x, y, w, h, cuts, glow)
	return drawChamferOuterGlowSpec(x, y, w, h, cuts, outerGlowStyle(glow), true)
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

drawChamferBasePass = function(x, y, w, h, cuts, fill, stroke, strokeWidth, innerSpec)
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
	local backdropSpec = backdropStyle(style.backdrop)
	local cullSpread = 0
	if shadowSpec then
		cullSpread = math_max(cullSpread, math_abs(tonumber(shadowSpec.x) or 0) + math_abs(tonumber(shadowSpec.y) or 0) + effectExtentFromSpec(shadowSpec, 12) + (tonumber(shadowSpec.grow) or 0))
	end
	if outerSpec then
		cullSpread = math_max(cullSpread, math_abs(tonumber(outerSpec.x) or 0) + math_abs(tonumber(outerSpec.y) or 0) + effectExtentFromSpec(outerSpec, 18) + (tonumber(outerSpec.grow) or 0))
	end
	if backdropSpec then
		cullSpread = math_max(cullSpread, math_max(0, tonumber(backdropSpec.padding) or 0))
	end
	if not hasTransform() and isCulled(x - cullSpread, y - cullSpread, w + cullSpread * 2, h + cullSpread * 2) then
		if profiling then profileEnd("chamfer.immediate", totalProfile) end
		return
	end

	local points

	local profile
	if shadowSpec then
		profile = profiling and profileStart() or nil
		drawChamferShadowSpec(x, y, w, h, resolvedCuts, shadowSpec)
		if profiling then profileEnd("chamfer.shadow", profile) end
	end

	if outerSpec then
		profile = profiling and profileStart() or nil
		drawChamferOuterGlowSpec(x, y, w, h, resolvedCuts, outerSpec, true)
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
	if fillIsVisible or strokeIsVisible or innerSpec then
		if pattern == nil then
			baseDrawn = drawChamferBasePass(x, y, w, h, resolvedCuts, fill, style.stroke, strokeWidth, innerSpec)
			baseDrewStroke = baseDrawn and strokeIsVisible
			baseDrewInnerGlow = baseDrawn and innerSpec
		elseif fillIsVisible then
			baseDrawn = drawChamferBasePass(x, y, w, h, resolvedCuts, fill, nil, 0)
		end
	end

	if style.backdrop ~= nil then
		profile = profiling and profileStart() or nil
		drawChamferBackdrop(x, y, w, h, resolvedCuts, style.backdrop)
		if profiling then profileEnd("chamfer.backdrop", profile) end
	end

	if not baseDrawn and fillIsVisible then
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
	if style.radius ~= nil or style.shadow or style.outerGlow or style.backdrop then
		return drawRoundRectImmediate(x, y, w, h, {
			radius = style.radius or 0,
			backdrop = style.backdrop,
			fill = fill,
			shadow = style.shadow,
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

local function lineFallbackVerts(verts, fill, backdrop, shadow, outerGlow)
	return drawPolyImmediate({
		{x = verts[1].x, y = verts[1].y},
		{x = verts[2].x, y = verts[2].y},
		{x = verts[3].x, y = verts[3].y},
		{x = verts[4].x, y = verts[4].y},
	}, {
		backdrop = backdrop,
		fill = fill,
		shadow = shadow,
		outerGlow = outerGlow,
	})
end

local lineQuadVertsInto
local drawLineImmediate
local LINE_AA_FRINGE = 1
local LINE_NO_CAPS_UV_OFFSET = 8
local defaultLineColor = Color(255, 255, 255, 32)
local lineVertsScratch = {{}, {}, {}, {}}
local lineFallbackVertsScratch = {{}, {}, {}, {}}

local function drawLineQuad(x1, y1, x2, y2, strokeWidth, noCaps, verts, fill, style)
	if style.backdrop then
		local backdropVerts = lineQuadVertsInto(lineFallbackVertsScratch, x1, y1, x2, y2, strokeWidth, noCaps, 0)
		if backdropVerts then
			lineFallbackVerts(backdropVerts, transparentColor, style.backdrop)
		end
	end

	if not style.radius and not style.shadow and not style.outerGlow and drawLineShaderVerts(verts, fill) then return end
	local fallbackVerts = lineQuadVertsInto(lineFallbackVertsScratch, x1, y1, x2, y2, strokeWidth, noCaps, 0)
	return lineFallbackVerts(fallbackVerts or verts, fill, nil, style.shadow, style.outerGlow)
end

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
		if style.radius ~= nil or style.shadow or style.outerGlow then
			return drawLineRect(x, y, w, strokeWidth, fill, style)
		end
	end

	if math_abs(x2 - x1) < 0.001 then
		local y = math_min(y1, y2)
		local h = math_abs(y2 - y1)
		if h <= 0 then return end
		local x = x1 - strokeWidth * 0.5
		if style.radius ~= nil or style.shadow or style.outerGlow then
			return drawLineRect(x, y, strokeWidth, h, fill, style)
		end
	end

	local noCaps = style.noCaps == true or style.caps == false
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

local function offsetEdgeLine(ax, ay, bx, by, amount)
	local dx = bx - ax
	local dy = by - ay
	local length = math_max(0.0001, math_sqrt(dx * dx + dy * dy))
	local nx = dy / length
	local ny = -dx / length
	return nx, ny, nx * ax + ny * ay + amount
end

local function offsetLineIntersection(px, py, n1x, n1y, c1, n2x, n2y, c2, amount)
	local det = n1x * n2y - n1y * n2x
	if math_abs(det) > 0.0001 then
		return (c1 * n2y - n1y * c2) / det,
			(n1x * c2 - c1 * n2x) / det
	end

	local ax = n1x + n2x
	local ay = n1y + n2y
	local alen = math_max(0.0001, math_sqrt(ax * ax + ay * ay))
	ax = ax / alen
	ay = ay / alen
	local scale = amount / math_max(0.001, ax * n1x + ay * n1y)
	return px + ax * scale, py + ay * scale
end

local function growConvexPoly(poly, amount)
	amount = math_max(0, tonumber(amount) or 0)
	if not poly or amount <= 0 then return poly end

	local absolute = {}
	local count = poly.count or #poly.points
	for index = 1, count do
		local point = poly.points[index]
		absolute[index] = {
			x = poly.x + point.x,
			y = poly.y + point.y,
		}
	end

	local grown = {}
	for index = 1, count do
		local prev = absolute[(index - 2 + count) % count + 1]
		local point = absolute[index]
		local nextPoint = absolute[index % count + 1]
		local n1x, n1y, c1 = offsetEdgeLine(prev.x, prev.y, point.x, point.y, amount)
		local n2x, n2y, c2 = offsetEdgeLine(point.x, point.y, nextPoint.x, nextPoint.y, amount)
		local gx, gy = offsetLineIntersection(point.x, point.y, n1x, n1y, c1, n2x, n2y, c2, amount)
		grown[index] = {x = gx, y = gy}
	end

	return normalizePoly(grown) or poly
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

local function polyDrawRect(poly, pad)
	pad = math_max(1, tonumber(pad) or 1)
	local invW = 1 / poly.w
	local invH = 1 / poly.h
	return {
		x = poly.x - pad,
		y = poly.y - pad,
		w = poly.w + pad * 2,
		h = poly.h + pad * 2,
		pad = pad,
		u0 = -pad * invW,
		v0 = -pad * invH,
		u1 = 1 + pad * invW,
		v1 = 1 + pad * invH,
	}
end

local drawPolyStrokeShader

local function drawPolyStroke(poly, color, strokeWidth)
	strokeWidth = strokeWidthValue(strokeWidth, 1)
	if shadersActive() and drawPolyStrokeShader(poly, color, strokeWidth) then
		return
	end
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
	local drawRect = polyDrawRect(poly, math_max(2, strokeWidthValue(strokeWidth, 0) + 2))
	local p1 = poly.points[1]
	local p2 = poly.points[2]
	local p3 = poly.points[3]
	local p4 = poly.points[4] or p3
	local p5 = poly.points[5] or p4
	local p6 = poly.points[6] or p5
	local p7 = poly.points[7] or p6
	local p8 = poly.points[8] or p7
	local r, g, b, a = color01(color)

	setupParamMatrix(mat,
		p1.x, p1.y, p2.x, p2.y,
		p3.x, p3.y, p4.x, p4.y,
		p5.x, p5.y, p6.x, p6.y,
		p7.x, p7.y, p8.x, p8.y
	)
	setupExtraParams(mat,
		r, g, b, a,
		poly.w, poly.h, math_max(0, strokeWidthValue(strokeWidth, 0)), 0,
		0, 0, 0, 0,
		0, 0, 0, 0
	)

	return drawRect
end

drawPolyStrokeShader = function(poly, color, strokeWidth)
	local mat = materials["poly" .. poly.count .. "_stroke"]
	if not matOK(mat) then return false end

	local drawRect = setupPolyStrokeConstants(mat, poly, color, strokeWidth)
	surface_SetDrawColor(255, 255, 255, 255)
	surface_SetMaterial(mat)
	drawTexturedQuadUV(drawRect.x, drawRect.y, drawRect.w, drawRect.h, drawRect.u0, drawRect.v0, drawRect.u1, drawRect.v1)
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
	local pad = math_max(0, tonumber(spec.padding) or 0)
	local backdropPoly = pad > 0 and growConvexPoly(poly, pad) or poly

	if spec.blur > 0 then
		local key = "poly" .. backdropPoly.count .. "_blur"
		drawBlurredPoly(backdropPoly, materials[key], spec.blur)
	end

	local tint = backdropTintColor(spec)
	if tint then
		local key = "poly" .. backdropPoly.count
		local mat = materials[key]
		if matOK(mat) then
			setupConstants(mat, backdropPoly.w, backdropPoly.h, M.Solid(tint), nil, 0, 0)
			drawMaterialPoly(backdropPoly, mat)
		end
	end

	return spec
end

local function polyShadowBounds(poly, shadow, biasOffset)
	if not shadow or not shadow.color or (shadow.color.a or 255) <= 0 then return nil end

	local width = math_max(0.001, tonumber(shadow.width) or 12)
	local grow = math_max(0, tonumber(shadow.grow) or 0)
	local spread = effectExtentFromSpec(shadow, 12)
	local padding = grow + math_max(spread, width)
	local ox = tonumber(shadow.x) or 0
	local oy = tonumber(shadow.y) or 0

	if biasOffset then
		local left, top, right, bottom = glowBiasPads(padding, ox, oy, 0.001)
		return {
			x = poly.x - left,
			y = poly.y - top,
			w = poly.w + left + right,
			h = poly.h + top + bottom,
			ox = 0,
			oy = 0,
			width = width,
			grow = grow,
			falloff = math_max(0.001, tonumber(shadow.falloff) or 1.7),
			strength = math_max(0, tonumber(shadow.strength) or 1),
		}
	end

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
	local bleedLeft, bleedTop, bleedRight, bleedBottom = effectBleedFromDrawRect(poly.x, poly.y, poly.w, poly.h, bounds.x, bounds.y, bounds.w, bounds.h)
	withPanelEffectBleed(bleedLeft, bleedTop, bleedRight, bleedBottom, function()
		surface_SetMaterial(mat)
		surface_SetDrawColor(255, 255, 255, 255)
		drawTexturedQuad(bounds.x, bounds.y, bounds.w, bounds.h)
	end)
	return true
end

local function drawPolyOuterGlow(poly, glow, bounds)
	if not bounds or not setupExtraParams then return false end

	local mat = materials["poly" .. poly.count .. "_outerglow"]
	if not matOK(mat) then return false end

	setupPolyShadowConstants(mat, poly, glow, bounds)
	local bleedLeft, bleedTop, bleedRight, bleedBottom = effectBleedFromDrawRect(poly.x, poly.y, poly.w, poly.h, bounds.x, bounds.y, bounds.w, bounds.h)
	withPanelEffectBleed(bleedLeft, bleedTop, bleedRight, bleedBottom, function()
		surface_SetMaterial(mat)
		surface_SetDrawColor(255, 255, 255, 255)
		drawTexturedQuad(bounds.x, bounds.y, bounds.w, bounds.h)
	end)
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

local function setupPolyFillConstants(mat, poly, fill)
	local drawRect = polyDrawRect(poly, 2)
	local p1 = poly.points[1]
	local p2 = poly.points[2]
	local p3 = poly.points[3]
	local p4 = poly.points[4] or p3
	local p5 = poly.points[5] or p4
	local p6 = poly.points[6] or p5
	local p7 = poly.points[7] or p6
	local p8 = poly.points[8] or p7

	setupConstants(mat, poly.w, poly.h, fill, nil, 0, 0)
	setupExtraParams(mat,
		p1.x, p1.y, p2.x, p2.y,
		p3.x, p3.y, p4.x, p4.y,
		p5.x, p5.y, p6.x, p6.y,
		p7.x, p7.y, p8.x, p8.y
	)

	return drawRect
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
	local outer = outerGlowStyle(style.outerGlow)
	local outerBounds = polyShadowBounds(poly, outer, true)
	local backdropSpec = backdropStyle(style.backdrop)
	local cullX, cullY, cullW, cullH = includeBounds(poly.x, poly.y, poly.w, poly.h, shadowBounds)
	cullX, cullY, cullW, cullH = includeBounds(cullX, cullY, cullW, cullH, outerBounds)
	if backdropSpec ~= nil then
		local pad = math_max(0, tonumber(backdropSpec.padding) or 0)
		if pad > 0 then
			cullX, cullY, cullW, cullH = includeBounds(cullX, cullY, cullW, cullH, {
				x = poly.x - pad,
				y = poly.y - pad,
				w = poly.w + pad * 2,
				h = poly.h + pad * 2,
			})
		end
	end
	if not hasTransform() and isCulled(cullX, cullY, cullW, cullH) then return end

	if not shadersActive() then
		return drawPolyFallback(points, style)
	end

	drawPolyShadow(poly, shadow, shadowBounds)
	drawPolyOuterGlow(poly, outer, outerBounds)

	local backdrop = drawPolyBackdrop(poly, style.backdrop)

	local key = "poly" .. poly.count
	local mat = materials[key]
	local fill = fillFromStyle(style.fill)
	local hasFill = fillVisible(fill)
	local strokeWidth = strokeWidthValue(style.strokeWidth, 0)
	local hasStroke = strokeVisible(style.stroke, strokeWidth)

	if hasFill then
		local drawRect = setupPolyFillConstants(mat, poly, fill)
		surface_SetMaterial(mat)
		drawTexturedQuadUV(drawRect.x, drawRect.y, drawRect.w, drawRect.h, drawRect.u0, drawRect.v0, drawRect.u1, drawRect.v1)
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
