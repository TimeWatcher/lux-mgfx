if SERVER then return end

MGFX = MGFX or {}

function MGFX._InstallWidgetRings(C)
	local M = C.M
	local materials = C.materials
	local forceFallback = C.forceFallback
	local recordDirectImmediate = C.recordDirectImmediate or function() end
	local copyStyle = C.copyStyle or function(style) return istable(style) and table.Copy(style) or {} end
	local resolveDrawStyle = C.resolveDrawStyle or copyStyle
	local matOK = C.matOK
	local shadersActive = C.shadersActive or function() return not forceFallback:GetBool() and M.hasShaders() end
	local asColor = C.asColor
	local color01 = C.color01
	local setDrawColor = C.setDrawColor
	local strokeWidthValue = C.strokeWidthValue
	local strokeRaw = C.strokeRaw
	local STROKE_SOLID = C.STROKE_SOLID or 0
	local radiusTuple = C.radiusTuple
	local radiusScalar = C.radiusScalar
	local fillFromStyle = C.fillFromStyle
	local fillVisible = C.fillVisible
	local backdropStyle = C.backdropStyle or function() return nil end
	local defaultPatternColor = C.defaultPatternColor
	local defaultWornEdgeColor = C.defaultWornEdgeColor
	local strokeVisible = C.strokeVisible
	local colorAtFill = C.colorAtFill
	local bindGradientLut = C.bindGradientLut or function() end
	local gradientCurve = C.gradientCurve
	local isCulled = C.isCulled
	local normalizedRotation = C.normalizedRotation
	local imageMaskStyle = C.imageMaskStyle or function(mask) return mask end
	local setupConstants = C.setupConstants
	local setupParamMatrix = C.setupParamMatrix
	local drawTexturedQuad = C.drawTexturedQuad
	local drawTexturedQuadUV = C.drawTexturedQuadUV
	local withTransform = C.withTransform or function(_, _, _, _, _, fn) return fn() end
	local splitStyleTransform = C.splitStyleTransform or function(style) return nil, style end
	local hasTransform = C.hasTransform or function() return false end
	local beginPanelEffectBleed = assert(C.beginPanelEffectBleed, "MGFX panel bleed begin helper unavailable")
	local endPanelEffectBleed = assert(C.endPanelEffectBleed, "MGFX panel bleed end helper unavailable")
	local drawBlurredCustomQuad = C.drawBlurredCustomQuad
	local drawCreatedMaterialTexturedRectUV = C.drawCreatedMaterialTexturedRectUV
	local imageTint = C.imageTint
	local imageStyle = C.imageStyle
	local imageRadius = C.imageRadius
	local imageUV = C.imageUV
	local imageFitRect = C.imageFitRect
	local setupExtraParams = C.setupExtraParams
	local drawRoundRectImmediate = C.drawRoundRectImmediate
	local drawRoundRectOuterGlow = C.drawRoundRectOuterGlow
	local roundRaw = assert(C.roundRaw, "MGFX raw effect helper unavailable")
	local drawStrokePath = assert(C.drawStrokePath, "MGFX stroke path helper unavailable")
	local drawLineRaw = assert(C.drawLineRaw, "MGFX raw line helper unavailable")
	local drawPolyRaw = assert(C.drawPolyRaw, "MGFX raw polygon helper unavailable")
	local chamferTuple = C.chamferTuple
	local drawChamferOuterGlow = C.drawChamferOuterGlow
	local drawChamferPattern = C.drawChamferPattern
	local patternStyle = C.patternStyle
	local patternOffset = C.patternOffset
	local textureFallbackMaterial = C.textureFallbackMaterial
	local materialCache = C.materialCache
	local textRenderer = C.textRenderer
	local FILL_SOLID = C.FILL_SOLID
	local FILL_LINEAR = C.FILL_LINEAR
	local FILL_RADIAL = C.FILL_RADIAL
	local FILL_CONIC = C.FILL_CONIC
	local transparentColor = Color(0, 0, 0, 0)
	local defaultRingFillColor = Color(255, 255, 255, 180)
	local solidFillScratch = {kind = FILL_SOLID, colorA = color_white, colorB = color_white}
	local backdropFillScratch = {kind = FILL_SOLID, colorA = color_white, colorB = color_white}
	local math_abs = math.abs
	local math_max = math.max
	local math_min = math.min
	local math_floor = math.floor
	local math_ceil = math.ceil
	local math_rad = math.rad
	local math_cos = math.cos
	local math_sin = math.sin
	local surface_DrawTexturedRectUV = surface.DrawTexturedRectUV
	local surface_SetDrawColor = surface.SetDrawColor
	local surface_SetMaterial = surface.SetMaterial
	local FX_GLOW = 1
	local FX_SHEEN = 2
	local FX_MARKER = 4
	local MASK_ROUNDED = 0
	local MASK_CHAMFER = 1
	local MASK_CIRCLE = 2
	local MASK_CAPSULE = 3
	local MASK_TEXTURE_A = 10
	local MASK_TEXTURE_R = 11
	local MASK_TEXTURE_G = 12
	local MASK_TEXTURE_B = 13
	local MASK_TEXTURE_LUMA = 14
	local RING_MODE_FULL = 0
	local RING_MODE_ARC = 1
	local RING_MODE_SECTOR = 2

	local function effectBleedFromDrawRect(x, y, w, h, drawX, drawY, drawW, drawH)
		local left = math_max(0, x - drawX)
		local top = math_max(0, y - drawY)
		local right = math_max(0, drawX + drawW - (x + w))
		local bottom = math_max(0, drawY + drawH - (y + h))
		return left, top, right, bottom
	end

	local function hotFillFromStyle(fill, fallback, scratch)
		if istable(fill) then
			local kind = fill.kind
			if kind == FILL_SOLID or kind == FILL_LINEAR or kind == FILL_RADIAL or kind == FILL_CONIC then return fill end
			if kind ~= nil then
				scratch = scratch or solidFillScratch
				scratch.colorA = transparentColor
				scratch.colorB = transparentColor
				return scratch
			end
			if fill.r ~= nil and fill.g ~= nil and fill.b ~= nil then
				scratch = scratch or solidFillScratch
				scratch.colorA = fill
				scratch.colorB = fill
				return scratch
			end
		end

		local color = asColor(fill, fallback or color_white)
		scratch = scratch or solidFillScratch
		scratch.colorA = color
		scratch.colorB = color
		return scratch
	end

local function ringModeValue(mode)
	if mode == true then return RING_MODE_ARC end
	return tonumber(mode) or RING_MODE_FULL
end

local function setupRingShapeConstants(mat, w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
	return w,
		h,
		math_max(0, tonumber(innerRadius) or 0),
		math_max(0.001, tonumber(outerRadius) or math_min(w, h) * 0.5),
		math_rad(tonumber(startDeg) or 0),
		math_rad(tonumber(endDeg) or 360),
		ringModeValue(mode)
end

local function drawRingFallbackRaw(cx, cy, outerRadius, arcWidth, startDeg, endDeg, mode, innerRadiusInput, fill, stroke, strokeWidth, shadow, outerGlow, backdrop)
	local sweep = math_abs((tonumber(endDeg) or 360) - (tonumber(startDeg) or 0))
	local segments = math.Clamp(math_floor(sweep / 360 * 64), 3, 64)
	local startRad = math_rad(tonumber(startDeg) or 0)
	local endRad = math_rad(tonumber(endDeg) or 360)
	local hasStroke, strokeColor, resolvedStrokeWidth, strokeKind, strokeLength, strokeGap, strokeOffset = strokeRaw(stroke, strokeWidth, 0)
	local innerRadius = math.Clamp(tonumber(innerRadiusInput) or math_max(0, outerRadius - arcWidth), 0, outerRadius)

	if mode == RING_MODE_SECTOR then
		local points = {}
		for index = 1, segments + 1 do
			local t = (index - 1) / segments
			local angle = startRad + (endRad - startRad) * t
			points[#points + 1] = {x = cx + math_cos(angle) * outerRadius, y = cy + math_sin(angle) * outerRadius}
		end
		for index = segments + 1, 1, -1 do
			local t = (index - 1) / segments
			local angle = startRad + (endRad - startRad) * t
			points[#points + 1] = {x = cx + math_cos(angle) * innerRadius, y = cy + math_sin(angle) * innerRadius}
		end
		return drawPolyRaw(points, nil, fill, stroke, strokeWidth, shadow, outerGlow, backdrop, nil)
	end

	local outerPoints, innerPoints = {}, {}
	for index = 1, segments do
		local t1, t2 = (index - 1) / segments, index / segments
		local a1 = startRad + (endRad - startRad) * t1
		local a2 = startRad + (endRad - startRad) * t2
		drawLineRaw(
			cx + math_cos(a1) * outerRadius, cy + math_sin(a1) * outerRadius,
			cx + math_cos(a2) * outerRadius, cy + math_sin(a2) * outerRadius,
			fill, arcWidth, nil, nil, outerGlow, backdrop, false
		)
	end

	if hasStroke then
		for index = 0, segments do
			local t = index / segments
			local angle = startRad + (endRad - startRad) * t
			outerPoints[#outerPoints + 1] = {x = cx + math_cos(angle) * outerRadius, y = cy + math_sin(angle) * outerRadius}
			innerPoints[#innerPoints + 1] = {x = cx + math_cos(angle) * innerRadius, y = cy + math_sin(angle) * innerRadius}
		end
		if mode == RING_MODE_FULL then
			drawStrokePath(outerPoints, true, strokeColor, resolvedStrokeWidth, strokeKind, strokeLength, strokeGap, strokeOffset)
			if innerRadius > 0.001 then
				drawStrokePath(innerPoints, true, strokeColor, resolvedStrokeWidth, strokeKind, strokeLength, strokeGap, strokeOffset)
			end
		else
			for index = #innerPoints, 1, -1 do outerPoints[#outerPoints + 1] = innerPoints[index] end
			drawStrokePath(outerPoints, true, strokeColor, resolvedStrokeWidth, strokeKind, strokeLength, strokeGap, strokeOffset)
		end
	end
end

local function ringFillParams(fill)
	if fill.kind == FILL_LINEAR then
		return fill.x1 or 0, fill.y1 or 0, fill.x2 or 1, fill.y2 or 0
	elseif fill.kind == FILL_RADIAL then
		local localRadial = fill.localRadial or fill.ringRadial or fill.sectorRadial
		if not localRadial then
			local radialSpace = fill.radialSpace or fill.space or fill.mapping
			if isstring(radialSpace) then radialSpace = string.lower(radialSpace) end
			localRadial = radialSpace == "ring" or radialSpace == "sector"
		end
		return fill.cx or 0.5, fill.cy or 0.5, fill.radiusX or fill.radius or 0.5, localRadial and -1 or (fill.radiusY or 0)
	elseif fill.kind == FILL_CONIC then
		local localAngular = fill.localAngular or fill.shapeAngular
		if not localAngular then
			local angularSpace = fill.angularSpace or fill.space or fill.mapping
			if isstring(angularSpace) then angularSpace = string.lower(angularSpace) end
			localAngular = angularSpace == "shape" or angularSpace == "ring" or angularSpace == "sector"
		end
		return fill.cx or 0.5, fill.cy or 0.5, normalizedRotation(fill.rotation), localAngular and 1 or 0
	else
		return 0, 0, 1, 0
	end
end

local function drawRingFillPass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, fill)
	if not fillVisible(fill) then return end
	if not shadersActive() or not matOK(materials.ring) then
		M.stats.fallbacks = M.stats.fallbacks + 1
		return M.CircleEx(x + w * 0.5, y + h * 0.5, outerRadius, {
			fill = fill.colorA or color_white,
		})
	end

	local mat = materials.ring
	local colorB = fill.colorB or fill.colorA or color_white
	local r, g, b, a = color01(colorB)
	local sw, sh, ir, orad, sr, er, modeValue = setupRingShapeConstants(mat, w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
	local p0, p1, p2, p3 = ringFillParams(fill)
	setupParamMatrix(mat,
		r, g, b, a,
		sw, sh, ir, orad,
		sr, er, modeValue, (fill.kind or FILL_SOLID) + gradientCurve(fill.curve) * 4,
		p0, p1, p2, p3
	)
	if (fill.kind or FILL_SOLID) ~= FILL_SOLID then bindGradientLut(mat, fill) end

	setDrawColor(fill.colorA or color_white)
	surface_SetMaterial(mat)
	drawTexturedQuad(x, y, w, h, mat)
end

local function drawRingStrokeQuad(x, y, w, h, mat, strokeWidth)
	local pad = math_ceil(math_max(0, tonumber(strokeWidth) or 0) * 0.5 + 1)
	if pad <= 1 or w <= 0 or h <= 0 then
		drawTexturedQuad(x, y, w, h, mat)
		return
	end
	drawTexturedQuadUV(
		x - pad, y - pad, w + pad * 2, h + pad * 2,
		-pad / w, -pad / h, 1 + pad / w, 1 + pad / h,
		mat
	)
end

local function drawRingStrokePass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, stroke, strokeWidth, strokeKind, strokeLength, strokeGap, strokeOffset)
	local width = strokeWidthValue(strokeWidth, 0)
	if not strokeVisible(stroke, width) then return end
	if not shadersActive() or not matOK(materials.ring_stroke) then return end

	local mat = materials.ring_stroke
	local r, g, b, a = color01(stroke)
	local sw, sh, ir, orad, sr, er, modeValue = setupRingShapeConstants(mat, w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
	setupParamMatrix(mat,
		r, g, b, a,
		sw, sh, ir, orad,
		sr, er, modeValue, math_max(0, width),
		strokeKind or STROKE_SOLID, strokeLength or 0, strokeGap or 0, strokeOffset or 0
	)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	drawRingStrokeQuad(x, y, w, h, mat, width)
end

local function drawRingFxPass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, fill, stroke, strokeWidth, innerEnabled, gr, gg, gb, ga, glowWidth, glowStrength, glowFalloff)
	local width = strokeWidthValue(strokeWidth, 0)
	local hasStroke = strokeVisible(stroke, width)

	local hasGlow = innerEnabled and ga > 0 and glowStrength > 0
	if hasGlow then
		glowWidth = math_max(0.001, tonumber(glowWidth) or 8)
		glowStrength = math_max(0, tonumber(glowStrength) or 1)
		glowFalloff = math_max(0.001, tonumber(glowFalloff) or 1.65)
	else
		gr, gg, gb, ga = 0, 0, 0, 0
		glowWidth, glowStrength, glowFalloff = 0, 0, 1
	end

	if not hasStroke and not hasGlow then return false end
	if not setupExtraParams or not shadersActive() or not matOK(materials.ring_fx) then return false end

	local mat = materials.ring_fx
	local colorB = fill.colorB or fill.colorA or color_white
	local r, g, b, a = color01(colorB)
	local sw, sh, ir, orad, sr, er, modeValue = setupRingShapeConstants(mat, w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
	local p0, p1, p2, p3 = ringFillParams(fill)
	setupParamMatrix(mat,
		r, g, b, a,
		sw, sh, ir, orad,
		sr, er, modeValue, (fill.kind or FILL_SOLID) + gradientCurve(fill.curve) * 4,
		p0, p1, p2, p3
	)
	if (fill.kind or FILL_SOLID) ~= FILL_SOLID then bindGradientLut(mat, fill) end

	local sr, sg, sb, sa = 0, 0, 0, 0
	if hasStroke then
		sr, sg, sb, sa = color01(stroke)
	end

	if not setupExtraParams(mat,
		sr, sg, sb, sa,
		math_max(0, width), glowWidth, glowStrength, glowFalloff,
		gr, gg, gb, ga
	) then return false end

	setDrawColor(fill.colorA or color_white)
	surface_SetMaterial(mat)
	drawTexturedQuad(x, y, w, h, mat)
	return true
end

local function drawRingInnerGlowPass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, enabled, gr, gg, gb, ga, glowWidth, glowStrength, glowFalloff)
	if not enabled or ga <= 0 or glowStrength <= 0 then return end
	if not shadersActive() or not matOK(materials.ring_innerglow) then return end

	local mat = materials.ring_innerglow
	local sw, sh, ir, orad, sr, er, modeValue = setupRingShapeConstants(mat, w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
	setupParamMatrix(mat,
		gr, gg, gb, ga,
		sw, sh, ir, orad,
		sr, er, modeValue, math_max(0.001, tonumber(glowWidth) or 8),
		math_max(0, tonumber(glowStrength) or 1),
		math_max(0.001, tonumber(glowFalloff) or 1.65),
		0, 0
	)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	drawTexturedQuad(x, y, w, h, mat)
end

local function ringEffectBounds(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, enabled, alpha, ox, oy, width, extent, grow, strength, falloff)
	if not enabled or alpha <= 0 or strength <= 0 then return nil end

	grow = math_max(0, tonumber(grow) or 0)
	ox = tonumber(ox) or 0
	oy = tonumber(oy) or 0
	width = math_max(0.001, tonumber(width) or 18)
	extent = math_max(1, tonumber(extent) or width)
	strength = math_max(0, tonumber(strength) or 1)
	falloff = math_max(0.001, tonumber(falloff) or 1.9)
	local gx = x + ox - grow
	local gy = y + oy - grow
	local gw = w + grow * 2
	local gh = h + grow * 2
	local gi = math_max(0, (tonumber(innerRadius) or 0) - grow)
	local go = math_max(0.001, (tonumber(outerRadius) or math_min(w, h) * 0.5) + grow)
	local spread = extent

	return {
		x = gx - spread,
		y = gy - spread,
		w = gw + spread * 2,
		h = gh + spread * 2,
		shapeX = spread,
		shapeY = spread,
		inner = gi,
		outer = go,
		start = math_rad(tonumber(startDeg) or 0),
		finish = math_rad(tonumber(endDeg) or 360),
		mode = ringModeValue(mode),
		width = width,
		strength = strength,
		falloff = falloff,
	}
end

local function drawRingShadowOuterPass(
	x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode,
	hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowExtent, shadowGrow, shadowStrength, shadowFalloff,
	hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerExtent, outerGrow, outerStrength, outerFalloff
)
	if (not hasShadow and not hasOuter) or not setupExtraParams then return false end
	if not shadersActive() or not matOK(materials.ring_shadow_outer) then return false end

	local shadowBounds = ringEffectBounds(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, hasShadow, sa, shadowX, shadowY, shadowWidth, shadowExtent, shadowGrow, shadowStrength, shadowFalloff)
	local outerBounds = ringEffectBounds(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, hasOuter, oa, outerX, outerY, outerWidth, outerExtent, outerGrow, outerStrength, outerFalloff)
	if not shadowBounds and not outerBounds then return false end

	local baseBounds = shadowBounds or outerBounds
	local sx = baseBounds.x
	local sy = baseBounds.y
	local ex = baseBounds.x + baseBounds.w
	local ey = baseBounds.y + baseBounds.h
	if shadowBounds then
		sx = math_min(sx, shadowBounds.x)
		sy = math_min(sy, shadowBounds.y)
		ex = math_max(ex, shadowBounds.x + shadowBounds.w)
		ey = math_max(ey, shadowBounds.y + shadowBounds.h)
	end
	if outerBounds then
		sx = math_min(sx, outerBounds.x)
		sy = math_min(sy, outerBounds.y)
		ex = math_max(ex, outerBounds.x + outerBounds.w)
		ey = math_max(ey, outerBounds.y + outerBounds.h)
	end

	local drawW = ex - sx
	local drawH = ey - sy
	local mat = materials.ring_shadow_outer

	setupParamMatrix(mat,
		drawW, drawH, 0, 0,
		shadowBounds and sr or 0, shadowBounds and sg or 0, shadowBounds and sb or 0, shadowBounds and sa or 0,
		(shadowBounds and shadowBounds.x or x) + (shadowBounds and shadowBounds.shapeX or 0) + (shadowBounds and shadowBounds.outer or 0) - sx,
		(shadowBounds and shadowBounds.y or y) + (shadowBounds and shadowBounds.shapeY or 0) + (shadowBounds and shadowBounds.outer or 0) - sy,
		shadowBounds and shadowBounds.inner or 0,
		shadowBounds and shadowBounds.outer or 1,
		shadowBounds and shadowBounds.start or 0,
		shadowBounds and shadowBounds.finish or math_rad(360),
		shadowBounds and shadowBounds.mode or RING_MODE_FULL,
		shadowBounds and shadowBounds.width or 1
	)

	if not setupExtraParams(mat,
		outerBounds and orr or 0, outerBounds and og or 0, outerBounds and ob or 0, outerBounds and oa or 0,
		(outerBounds and outerBounds.x or x) + (outerBounds and outerBounds.shapeX or 0) + (outerBounds and outerBounds.outer or 0) - sx,
		(outerBounds and outerBounds.y or y) + (outerBounds and outerBounds.shapeY or 0) + (outerBounds and outerBounds.outer or 0) - sy,
		outerBounds and outerBounds.inner or 0,
		outerBounds and outerBounds.outer or 1,
		outerBounds and outerBounds.start or 0,
		outerBounds and outerBounds.finish or math_rad(360),
		outerBounds and outerBounds.mode or RING_MODE_FULL,
		outerBounds and outerBounds.width or 1,
		shadowBounds and shadowBounds.falloff or 1,
		shadowBounds and shadowBounds.strength or 0,
		outerBounds and outerBounds.falloff or 1,
		outerBounds and outerBounds.strength or 0
	) then return false end

	local bleedLeft, bleedTop, bleedRight, bleedBottom = effectBleedFromDrawRect(x, y, w, h, sx, sy, drawW, drawH)
	local bleedToken = beginPanelEffectBleed(bleedLeft, bleedTop, bleedRight, bleedBottom)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	drawTexturedQuad(sx, sy, drawW, drawH, mat)
	endPanelEffectBleed(bleedToken)
	return true
end

local function drawRingPatternPass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, pattern)
	local spec = patternStyle(pattern)
	if spec and shadersActive() and matOK(materials.ring_pattern) then
		local pmat = materials.ring_pattern
		local angle = math_rad(tonumber(spec.angle) or 135)
		local smoke = spec.kind == "smoke"
		local worn = spec.kind == "worn"
		local pz, pw
		if worn then
			pz = math_max(1, tonumber(spec.scale) or 32)
			pw = math_max(0.5, tonumber(spec.edgeWidth) or 7)
		elseif smoke then
			pz = math_max(1, tonumber(spec.scale) or 140)
			pw = math.Clamp(tonumber(spec.density) or 0.48, 0, 1)
		else
			pz = math_max(1, tonumber(spec.spacing) or 12)
			pw = math_max(0.25, tonumber(spec.width) or 2)
		end
		setupParamMatrix(pmat,
			(smoke or worn) and (tonumber(spec.seed) or 0) or 0,
			patternOffset(spec),
			(smoke or worn) and math_max(0.001, tonumber(spec.softness) or (worn and 0.10 or 0.3)) or 0,
			(smoke or worn) and math_max(0, tonumber(spec.warp) or (worn and 0.035 or 0.85)) or 0,
			w, h, math_max(0, tonumber(innerRadius) or 0), math_max(0.001, tonumber(outerRadius) or math_min(w, h) * 0.5),
			math_rad(tonumber(startDeg) or 0), math_rad(tonumber(endDeg) or 360), ringModeValue(mode), smoke and 1 or (worn and 2 or 0),
			math_cos(angle), math_sin(angle), pz, pw
		)
		if worn and setupExtraParams then
			local edgeColor = asColor(spec.edgeColor, defaultWornEdgeColor)
			local er, eg, eb, ea = color01(edgeColor)
			setupExtraParams(pmat,
				er, eg, eb, ea,
				math.Clamp(tonumber(spec.fractal) or 0.44, 0, 1),
				math.Clamp(tonumber(spec.grain) or 0.64, 0, 1),
				math.Clamp(tonumber(spec.scratches) or tonumber(spec.scratch) or 0.30, 0, 1),
				math.Clamp(tonumber(spec.edge) or tonumber(spec.edgeWear) or 0.54, 0, 1),
				math_max(0.25, tonumber(spec.grainScale) or 5.6),
				math_max(1, tonumber(spec.scratchScale) or 26),
				math.Clamp(tonumber(spec.scratchWidth) or 0.045, 0.005, 0.5),
				math_max(0.5, tonumber(spec.edgeWidth) or 7),
				math_cos(angle),
				math_sin(angle),
				math.Clamp(tonumber(spec.softness) or 0.10, 0.001, 1),
				math_max(0, tonumber(spec.warp) or 0.035)
			)
		end
		setDrawColor(spec.color or spec.tint or defaultPatternColor)
		surface_SetMaterial(pmat)
		drawTexturedQuad(x, y, w, h, pmat)
	end
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

local function setupRingBackdropConstants(mat, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, vertical, intensity)
	local sw, sh, ir, orad, sr, er, modeValue = setupRingShapeConstants(mat, w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
	setupParamMatrix(mat,
		vertical and 1 or 0, intensity or 1, 0, 0,
		sw, sh, ir, orad,
		sr, er, modeValue, 0,
		0, 0, 0, 0
	)
end

local function drawRingBackdropPass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, backdrop)
	local spec = backdropStyle(backdrop)
	if not spec then return nil end
	local pad = math_max(0, tonumber(spec.padding) or 0)
	local bx = x - pad
	local by = y - pad
	local bw = w + pad * 2
	local bh = h + pad * 2
	local bi = math_max(0, (tonumber(innerRadius) or 0) - pad)
	local bo = math_max(0.001, (tonumber(outerRadius) or math_min(w, h) * 0.5) + pad)

	if spec.blur > 0 and shadersActive() and matOK(materials.ring_backdrop) and drawBlurredCustomQuad then
		local mat = materials.ring_backdrop
		drawBlurredCustomQuad(mat, bx, by, bw, bh, spec.blur, function(passMat, vertical, intensity)
			setupRingBackdropConstants(passMat, bw, bh, bi, bo, startDeg, endDeg, mode, vertical, intensity)
		end, spec.recapture, spec.level)
	end

	local tint = backdropTintColor(spec)
	if tint then
		drawRingFillPass(bx, by, bw, bh, bi, bo, startDeg, endDeg, mode, hotFillFromStyle(tint, nil, backdropFillScratch))
	end

	return spec
end

local function drawRingBoxRaw(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, fillInput, colorInput, stroke, strokeWidthInput, shadow, outerGlow, innerGlow, backdrop, pattern)
	local hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, _, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread = roundRaw.shadow(shadow)
	local hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, _, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread = roundRaw.outerGlow(outerGlow)
	local backdropSpec = backdropStyle(backdrop)
	local fill = hotFillFromStyle(fillInput or colorInput, defaultRingFillColor)
	local hasStroke, strokeColor, strokeWidth, strokeKind, strokeLength, strokeGap, strokeOffset = strokeRaw(stroke, strokeWidthInput, 0)
	local specialStroke = hasStroke and strokeKind ~= STROKE_SOLID
	local baseStroke = hasStroke and not specialStroke
	local shaderReady = shadersActive()
	local cullSpread = hasStroke and (strokeWidth * 0.5 + 1) or 0
	if shaderReady then
		if hasShadow then
			cullSpread = math_max(cullSpread, shadowCullSpread)
		end
		if hasOuter then
			cullSpread = math_max(cullSpread, outerCullSpread)
		end
		if backdropSpec then
			cullSpread = math_max(cullSpread, math_max(0, tonumber(backdropSpec.padding) or 0))
		end
	end
	if not hasTransform() and isCulled(x - cullSpread, y - cullSpread, w + cullSpread * 2, h + cullSpread * 2) then return end
	if not shaderReady or not matOK(materials.ring) then
		return drawRingFallbackRaw(x + w * 0.5, y + h * 0.5, outerRadius, outerRadius - innerRadius, startDeg, endDeg, mode, innerRadius, fill, stroke, strokeWidthInput, shadow, outerGlow, backdrop)
	end

	if hasShadow or hasOuter then
		drawRingShadowOuterPass(
			x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode,
			hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowExtent, shadowGrow, shadowStrength, shadowFalloff,
			hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerExtent, outerGrow, outerStrength, outerFalloff
		)
	end
	if backdrop ~= nil then
		drawRingBackdropPass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, backdrop)
	end
	local hasInner, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff = roundRaw.innerGlow(innerGlow)
	local baseStrokeColor = baseStroke and strokeColor or nil
	local baseStrokeWidth = baseStroke and strokeWidth or 0
	if pattern == nil and (baseStroke or hasInner) and drawRingFxPass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, fill, baseStrokeColor, baseStrokeWidth, hasInner, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff) then
		if specialStroke then
			drawRingStrokePass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, strokeColor, strokeWidth, strokeKind, strokeLength, strokeGap, strokeOffset)
		end
		return
	end

	drawRingFillPass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, fill)
	if pattern ~= nil then
		drawRingPatternPass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, pattern)
	end
	if hasInner then
		drawRingInnerGlowPass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, true, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff)
	end
	if hasStroke then
		drawRingStrokePass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, strokeColor, strokeWidth, strokeKind, strokeLength, strokeGap, strokeOffset)
	end
end

function M.RingEx(x, y, radius, width, style)
	style = resolveDrawStyle(style, M.TARGET.RING)
	local transform
	transform, style = splitStyleTransform(style)
	local outerRadius = math_max(0.001, tonumber(radius) or 0)
	local ringWidth = math_max(0.001, tonumber(width) or math_max(1, outerRadius * 0.18))
	local innerRadius = math_max(0, outerRadius - ringWidth)
	local bx, by, size = x - outerRadius, y - outerRadius, outerRadius * 2

	recordDirectImmediate("DrawRing", "ring")
	if not transform then
		return drawRingBoxRaw(bx, by, size, size, innerRadius, outerRadius, 0, 360, RING_MODE_FULL, style.fill, style.color, style.stroke, style.strokeWidth, style.shadow, style.outerGlow, style.innerGlow, style.backdrop, style.pattern)
	end
	return withTransform(transform, bx, by, size, size, function()
		return drawRingBoxRaw(bx, by, size, size, innerRadius, outerRadius, 0, 360, RING_MODE_FULL, style.fill, style.color, style.stroke, style.strokeWidth, style.shadow, style.outerGlow, style.innerGlow, style.backdrop, style.pattern)
	end)
end

function M.Ring(x, y, radius, width, fill)
	local outerRadius = math_max(0.001, tonumber(radius) or 0)
	local ringWidth = math_max(0.001, tonumber(width) or math_max(1, outerRadius * 0.18))
	local innerRadius = math_max(0, outerRadius - ringWidth)
	local bx, by, size = x - outerRadius, y - outerRadius, outerRadius * 2
	recordDirectImmediate("DrawRing", "ring")
	return drawRingBoxRaw(bx, by, size, size, innerRadius, outerRadius, 0, 360, RING_MODE_FULL, fill, nil, nil, nil, nil, nil, nil, nil, nil)
end

function M.ArcEx(x, y, radius, width, startDeg, endDeg, style)
	style = resolveDrawStyle(style, M.TARGET.ARC)
	local transform
	transform, style = splitStyleTransform(style)
	local outerRadius = math_max(0.001, tonumber(radius) or 0)
	local arcWidth = math_max(0.001, tonumber(width) or math_max(1, outerRadius * 0.18))
	local innerRadius = math_max(0, outerRadius - arcWidth)
	local bx, by, size = x - outerRadius, y - outerRadius, outerRadius * 2

	recordDirectImmediate("DrawArc", "arc")
	if not transform then
		return drawRingBoxRaw(bx, by, size, size, innerRadius, outerRadius, startDeg, endDeg, RING_MODE_ARC, style.fill, style.color, style.stroke, style.strokeWidth, style.shadow, style.outerGlow, style.innerGlow, style.backdrop, style.pattern)
	end
	return withTransform(transform, bx, by, size, size, function()
		return drawRingBoxRaw(bx, by, size, size, innerRadius, outerRadius, startDeg, endDeg, RING_MODE_ARC, style.fill, style.color, style.stroke, style.strokeWidth, style.shadow, style.outerGlow, style.innerGlow, style.backdrop, style.pattern)
	end)
end

function M.Arc(x, y, radius, startDeg, endDeg, width, fill)
	local outerRadius = math_max(0.001, tonumber(radius) or 0)
	local arcWidth = math_max(0.001, tonumber(width) or math_max(1, outerRadius * 0.18))
	local innerRadius = math_max(0, outerRadius - arcWidth)
	local bx, by, size = x - outerRadius, y - outerRadius, outerRadius * 2
	recordDirectImmediate("DrawArc", "arc")
	return drawRingBoxRaw(bx, by, size, size, innerRadius, outerRadius, startDeg, endDeg, RING_MODE_ARC, fill, nil, nil, nil, nil, nil, nil, nil, nil)
end

function M.SectorEx(x, y, innerRadius, outerRadius, startDeg, endDeg, style)
	style = resolveDrawStyle(style, M.TARGET.SECTOR)
	local transform
	transform, style = splitStyleTransform(style)
	outerRadius = math_max(0.001, tonumber(outerRadius) or 0)
	innerRadius = math.Clamp(tonumber(innerRadius) or 0, 0, outerRadius)
	local bx, by, size = x - outerRadius, y - outerRadius, outerRadius * 2

	recordDirectImmediate("DrawSector", "sector")
	if not transform then
		return drawRingBoxRaw(bx, by, size, size, innerRadius, outerRadius, startDeg, endDeg, RING_MODE_SECTOR, style.fill, style.color, style.stroke, style.strokeWidth, style.shadow, style.outerGlow, style.innerGlow, style.backdrop, style.pattern)
	end
	return withTransform(transform, bx, by, size, size, function()
		return drawRingBoxRaw(bx, by, size, size, innerRadius, outerRadius, startDeg, endDeg, RING_MODE_SECTOR, style.fill, style.color, style.stroke, style.strokeWidth, style.shadow, style.outerGlow, style.innerGlow, style.backdrop, style.pattern)
	end)
end

function M.Sector(x, y, innerRadius, outerRadius, startDeg, endDeg, fill)
	outerRadius = math_max(0.001, tonumber(outerRadius) or 0)
	innerRadius = math.Clamp(tonumber(innerRadius) or 0, 0, outerRadius)
	local bx, by, size = x - outerRadius, y - outerRadius, outerRadius * 2
	recordDirectImmediate("DrawSector", "sector")
	return drawRingBoxRaw(bx, by, size, size, innerRadius, outerRadius, startDeg, endDeg, RING_MODE_SECTOR, fill, nil, nil, nil, nil, nil, nil, nil, nil)
end


	C.drawRingBox = drawRingBoxRaw
end
