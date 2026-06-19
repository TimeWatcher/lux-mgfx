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
	local radiusTuple = C.radiusTuple
	local radiusScalar = C.radiusScalar
	local fillFromStyle = C.fillFromStyle
	local fillVisible = C.fillVisible
	local backdropStyle = C.backdropStyle or function() return nil end
	local strokeVisible = C.strokeVisible
	local colorAtFill = C.colorAtFill
	local bindGradientLut = C.bindGradientLut or function() end
	local isCulled = C.isCulled
	local normalizedRotation = C.normalizedRotation
	local imageMaskStyle = C.imageMaskStyle or function(mask) return mask end
	local setupConstants = C.setupConstants
	local setupParamMatrix = C.setupParamMatrix
	local drawTexturedQuad = C.drawTexturedQuad
	local withTransform = C.withTransform or function(_, _, _, _, _, fn) return fn() end
	local splitStyleTransform = C.splitStyleTransform or function(style) return nil, style end
	local hasTransform = C.hasTransform or function() return false end
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
	local innerGlowStyle = C.innerGlowStyle
	local outerGlowStyle = C.outerGlowStyle
	local shadowStyle = C.shadowStyle or function() return nil end
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
		return fill.cx or 0.5, fill.cy or 0.5, fill.radius or 0.5, localRadial and 1 or 0
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
		sr, er, modeValue, fill.kind or FILL_SOLID,
		p0, p1, p2, p3
	)
	if (fill.kind or FILL_SOLID) ~= FILL_SOLID then bindGradientLut(mat, fill) end

	setDrawColor(fill.colorA or color_white)
	surface_SetMaterial(mat)
	drawTexturedQuad(x, y, w, h)
end

local function drawRingStrokePass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, stroke, strokeWidth)
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
		0, 0, 0, 0
	)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	drawTexturedQuad(x, y, w, h)
end

local function drawRingFxPass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, fill, stroke, strokeWidth, innerSpec)
	local width = strokeWidthValue(strokeWidth, 0)
	local hasStroke = strokeVisible(stroke, width)

	local gr, gg, gb, ga = 0, 0, 0, 0
	local glowWidth, glowStrength, glowFalloff = 0, 0, 1
	local hasGlow = false
	if innerSpec then
		gr, gg, gb, ga = color01(innerSpec.color or transparentColor)
		glowWidth = math_max(0.001, tonumber(innerSpec.width) or 8)
		glowStrength = math_max(0, tonumber(innerSpec.strength) or 1)
		glowFalloff = math_max(0.001, tonumber(innerSpec.falloff) or 1.65)
		hasGlow = ga > 0 and glowWidth > 0 and glowStrength > 0
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
		sr, er, modeValue, fill.kind or FILL_SOLID,
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
	drawTexturedQuad(x, y, w, h)
	return true
end

local function drawRingInnerGlowPass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, spec)
	if not spec then return end
	if not shadersActive() or not matOK(materials.ring_innerglow) then return end

	local color = spec.color
	if (color.a or 255) <= 0 then return end

	local mat = materials.ring_innerglow
	local r, g, b, a = color01(color)
	local sw, sh, ir, orad, sr, er, modeValue = setupRingShapeConstants(mat, w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
	setupParamMatrix(mat,
		r, g, b, a,
		sw, sh, ir, orad,
		sr, er, modeValue, math_max(0.001, tonumber(spec.width) or 8),
		math_max(0, tonumber(spec.strength) or 1),
		math_max(0.001, tonumber(spec.falloff) or 1.65),
		0, 0
	)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	drawTexturedQuad(x, y, w, h)
end

local function drawRingOuterGlowPass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, glow)
	local spec = glow
	if not spec then return end
	if not shadersActive() or not matOK(materials.ring_outerglow) then return end

	local color = spec.color
	if (color.a or 255) <= 0 then return end

	local grow = math_max(0, tonumber(spec.grow) or tonumber(spec.shapeSpread) or tonumber(spec.expand) or 0)
	local ox = tonumber(spec.x) or tonumber(spec.offsetX) or tonumber(spec.dx) or 0
	local oy = tonumber(spec.y) or tonumber(spec.offsetY) or tonumber(spec.dy) or 0
	local gx = x + ox - grow
	local gy = y + oy - grow
	local gw = w + grow * 2
	local gh = h + grow * 2
	local gi = math_max(0, (tonumber(innerRadius) or 0) - grow)
	local go = math_max(0.001, (tonumber(outerRadius) or math_min(w, h) * 0.5) + grow)
	local spread = math_max(1, tonumber(spec.spread) or tonumber(spec.width) or 18)
	local mat = materials.ring_outerglow
	local r, g, b, a = color01(color)
	local sw, sh, ir, orad, sr, er, modeValue = setupRingShapeConstants(mat, gw, gh, gi, go, startDeg, endDeg, mode)
	setupParamMatrix(mat,
		r, g, b, a,
		sw, sh, ir, orad,
		sr, er, modeValue, spread,
		math_max(0.001, tonumber(spec.width) or spread),
		math_max(0, tonumber(spec.strength) or 1),
		math_max(0.001, tonumber(spec.falloff) or 1.9),
		0
	)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	drawTexturedQuad(gx - spread, gy - spread, gw + spread * 2, gh + spread * 2)
end

local function drawRingPatternPass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, pattern)
	local spec = patternStyle(pattern)
	if spec and shadersActive() and matOK(materials.ring_pattern) then
		local pmat = materials.ring_pattern
		local angle = math_rad(tonumber(spec.angle) or 135)
		local smoke = spec.kind == "smoke"
		local pz, pw
		if smoke then
			pz = math_max(1, tonumber(spec.scale) or 140)
			pw = math.Clamp(tonumber(spec.density) or 0.48, 0, 1)
		else
			pz = math_max(1, tonumber(spec.spacing) or 12)
			pw = math_max(0.25, tonumber(spec.width) or 2)
		end
		setupParamMatrix(pmat,
			smoke and (tonumber(spec.seed) or 0) or 0,
			patternOffset(spec),
			smoke and math_max(0.001, tonumber(spec.softness) or 0.3) or 0,
			smoke and math_max(0, tonumber(spec.warp) or 0.85) or 0,
			w, h, math_max(0, tonumber(innerRadius) or 0), math_max(0.001, tonumber(outerRadius) or math_min(w, h) * 0.5),
			math_rad(tonumber(startDeg) or 0), math_rad(tonumber(endDeg) or 360), ringModeValue(mode), smoke and 1 or 0,
			math_cos(angle), math_sin(angle), pz, pw
		)
		setDrawColor(spec.color or spec.tint or Color(255, 255, 255, 24))
		surface_SetMaterial(pmat)
		drawTexturedQuad(x, y, w, h)
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

	if spec.blur > 0 and shadersActive() and matOK(materials.ring_backdrop) and drawBlurredCustomQuad then
		local mat = materials.ring_backdrop
		drawBlurredCustomQuad(mat, x, y, w, h, spec.blur, function(passMat, vertical, intensity)
			setupRingBackdropConstants(passMat, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, vertical, intensity)
		end)
	end

	local tint = backdropTintColor(spec)
	if tint then
		drawRingFillPass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, hotFillFromStyle(tint, nil, backdropFillScratch))
	end

	return spec
end

local function drawRingBox(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, style)
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
	if not hasTransform() and isCulled(x - cullSpread, y - cullSpread, w + cullSpread * 2, h + cullSpread * 2) then return end

	if shadowSpec then
		drawRingOuterGlowPass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, shadowSpec)
	end
	if outerSpec then
		drawRingOuterGlowPass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, outerSpec)
	end
	if style.backdrop ~= nil then
		drawRingBackdropPass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, style.backdrop)
	end
	local fill = hotFillFromStyle(style.fill or style.color, defaultRingFillColor)
	local innerSpec = innerGlowStyle(style.innerGlow)
	local strokeWidth = strokeWidthValue(style.strokeWidth, 0)
	local hasStroke = strokeVisible(style.stroke, strokeWidth)
	if style.pattern == nil and (hasStroke or innerSpec) and drawRingFxPass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, fill, style.stroke, strokeWidth, innerSpec) then
		return
	end

	drawRingFillPass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, fill)
	if style.pattern ~= nil then
		drawRingPatternPass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, style.pattern)
	end
	if innerSpec then
		drawRingInnerGlowPass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, innerSpec)
	end
	if hasStroke then
		drawRingStrokePass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, style.stroke, strokeWidth)
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
		return drawRingBox(bx, by, size, size, innerRadius, outerRadius, 0, 360, RING_MODE_FULL, style)
	end
	return withTransform(transform, bx, by, size, size, function()
		return drawRingBox(bx, by, size, size, innerRadius, outerRadius, 0, 360, RING_MODE_FULL, style)
	end)
end

local ringArgStyle = {}

function M.Ring(x, y, radius, width, fill)
	ringArgStyle.fill = fill
	return M.RingEx(x, y, radius, width, ringArgStyle)
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
		return drawRingBox(bx, by, size, size, innerRadius, outerRadius, startDeg, endDeg, RING_MODE_ARC, style)
	end
	return withTransform(transform, bx, by, size, size, function()
		return drawRingBox(bx, by, size, size, innerRadius, outerRadius, startDeg, endDeg, RING_MODE_ARC, style)
	end)
end

local arcArgStyle = {}

function M.Arc(x, y, radius, startDeg, endDeg, width, fill)
	arcArgStyle.fill = fill
	return M.ArcEx(x, y, radius, width, startDeg, endDeg, arcArgStyle)
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
		return drawRingBox(bx, by, size, size, innerRadius, outerRadius, startDeg, endDeg, RING_MODE_SECTOR, style)
	end
	return withTransform(transform, bx, by, size, size, function()
		return drawRingBox(bx, by, size, size, innerRadius, outerRadius, startDeg, endDeg, RING_MODE_SECTOR, style)
	end)
end

local sectorArgStyle = {}

function M.Sector(x, y, innerRadius, outerRadius, startDeg, endDeg, fill)
	sectorArgStyle.fill = fill
	return M.SectorEx(x, y, innerRadius, outerRadius, startDeg, endDeg, sectorArgStyle)
end


	C.drawRingBox = drawRingBox
end
