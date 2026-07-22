if SERVER then return end

MGFX = MGFX or {}

function MGFX._InstallWidgetBars(C)
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
	local strokeVisible = C.strokeVisible
	local colorAtFill = C.colorAtFill
	local bindGradientLut = C.bindGradientLut or function() end
	local gradientCurve = C.gradientCurve
	local isCulled = C.isCulled
	local normalizedRotation = C.normalizedRotation
	local imageMaskStyle = C.imageMaskStyle or function(mask) return mask end
	local setupParamMatrix = C.setupParamMatrix
	local setupConstants = C.setupConstants
	local drawTexturedQuad = C.drawTexturedQuad
	local drawTexturedQuadUV = C.drawTexturedQuadUV
	local withTransform = C.withTransform or function(_, _, _, _, _, fn) return fn() end
	local splitStyleTransform = C.splitStyleTransform or function(style) return nil, style end
	local hasTransform = C.hasTransform or function() return false end
	local drawCreatedMaterialTexturedRectUV = C.drawCreatedMaterialTexturedRectUV
	local imageTint = C.imageTint
	local imageStyle = C.imageStyle
	local imageRadius = C.imageRadius
	local imageUV = C.imageUV
	local imageFitRect = C.imageFitRect
	local drawRoundRectRaw = C.drawRoundRectRaw
	local drawRoundRectPrepared = assert(C.drawRoundRectPrepared, "MGFX roundrect prepared helper unavailable")
	local roundRaw = assert(C.roundRaw, "MGFX raw effect helper unavailable")
	local backdropStyle = C.backdropStyle or function() return nil end
	local drawRoundRectOuterGlow = C.drawRoundRectOuterGlow
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
	local transparentColor = Color(0, 0, 0, 0)
	local defaultProgressTrack = Color(10, 18, 24, 190)
	local defaultProgressStroke = Color(255, 255, 255, 18)
	local defaultSegmentFill = Color(255, 120, 72, 230)
	local defaultSegmentTrack = Color(255, 255, 255, 22)
	local transparentFill = {kind = FILL_SOLID, colorA = transparentColor, colorB = transparentColor, _mgfxFillVisible = false}
	local segmentItemFillScratch = {kind = FILL_SOLID, colorA = transparentColor, colorB = transparentColor, _mgfxFillVisible = false}
	local segmentContainerFillScratch = {kind = FILL_SOLID, colorA = transparentColor, colorB = transparentColor, _mgfxFillVisible = false}
	local progressTrackGradient = M.LinearGradient(0, 0, 0, 1, Color(0, 0, 0, 0), color_white)
	local progressSheenGradient = M.LinearGradient(0, 0, 0, 1, Color(255, 255, 255, 42), Color(255, 255, 255, 0))
	local progressTrackDarkColor = Color(0, 0, 0, 0)
	local tickColor = Color(255, 255, 255, 18)
	local glowColor = Color(80, 190, 255, 38)
	local markerColor = Color(255, 255, 255, 96)
	local progressTickFill = {kind = FILL_SOLID, colorA = tickColor, colorB = tickColor, _mgfxFillVisible = true}
	local progressGlowFill = {kind = FILL_SOLID, colorA = glowColor, colorB = glowColor, _mgfxFillVisible = true}
	local progressMarkerFill = {kind = FILL_SOLID, colorA = markerColor, colorB = markerColor, _mgfxFillVisible = true}

	local function setGradientColors(fill, colorA, colorB)
		fill.colorA = colorA
		fill.colorB = colorB
		fill.stops[1].color = colorA
		fill.stops[2].color = colorB
		fill._mgfxFillVisible = (colorA.a == nil or colorA.a > 0) or (colorB.a == nil or colorB.a > 0)
		fill._mgfxLutCacheSafe = false
		return fill
	end

	local function solidFillInto(out, color)
		local c = color or transparentColor
		out.kind = FILL_SOLID
		out.colorA = c
		out.colorB = c
		out._mgfxFillVisible = c.a == nil or c.a > 0
		return out
	end

	local function preparedStrokeVisible(strokeValue, strokeWidth)
		return strokeValue ~= nil and (strokeValue.a == nil or strokeValue.a > 0) and (strokeWidth or 0) > 0
	end

	local function preparedFillVisible(fill)
		if fill == nil then return false end
		if fill._mgfxFillVisible ~= nil then return fill._mgfxFillVisible end
		if fill.r ~= nil and fill.g ~= nil and fill.b ~= nil then return fill.a == nil or fill.a > 0 end
		return fillVisible(fill)
	end

	local function drawPreparedRoundRectPlain(x, y, w, h, radius, fill, strokeValue, strokeWidth, patternSpec, strokeKind, strokeLength, strokeGap, strokeOffset)
		return drawRoundRectPrepared(
			x, y, w, h, radius,
			fill or transparentFill, preparedFillVisible(fill), strokeValue, strokeWidth or 0, preparedStrokeVisible(strokeValue, strokeWidth),
			strokeKind or STROKE_SOLID, strokeLength or 0, strokeGap or 0, strokeOffset or 0,
			false, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0,
			false, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0,
			false, 0, 0, 0, 0, 0, 0, 1,
			nil, patternSpec
		)
	end

	local function drawPreparedRoundRectEffects(
		x, y, w, h, radius, fill, strokeValue, strokeWidth,
		strokeKind, strokeLength, strokeGap, strokeOffset,
		hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread,
		hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread,
		hasInner, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff,
		backdropSpec, patternSpec
	)
		return drawRoundRectPrepared(
			x, y, w, h, radius,
			fill or transparentFill, preparedFillVisible(fill), strokeValue, strokeWidth or 0, preparedStrokeVisible(strokeValue, strokeWidth),
			strokeKind or STROKE_SOLID, strokeLength or 0, strokeGap or 0, strokeOffset or 0,
			hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread,
			hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread,
			hasInner, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff,
			backdropSpec, patternSpec
		)
	end


	local function progressFx(fxInput)
		local fx = istable(fxInput) and fxInput or nil
		if not fx then return 0, 0 end

		local flags = 0
		if fx.glow == true or istable(fx.glow) then flags = flags + FX_GLOW end
		if fx.sheen == true or istable(fx.sheen) then flags = flags + FX_SHEEN end
		if fx.marker == true or istable(fx.marker) then flags = flags + FX_MARKER end

		local tickSpec = fx.ticks
		local ticks = 0
		if isnumber(tickSpec) then
			ticks = tickSpec
		elseif istable(tickSpec) then
			ticks = tickSpec.count
		end

		return flags, math.Clamp(math_floor(tonumber(ticks) or 0), 0, 31)
	end

	local function fxFlag(flags, bit)
		return math_floor(flags / bit) % 2 == 1
	end

local function canDrawProgressFast(fill, flags, ticks, inset, strokeWidth, shadow, backdrop, outerGlow, innerGlow, pattern, fillPattern, trackPattern)
	if not shadersActive() or not matOK(materials.progress) then return false end
	if flags ~= 0 or ticks > 1 then return false end
	if shadow or backdrop or outerGlow or innerGlow or pattern or fillPattern or trackPattern then return false end
	if inset ~= math_floor(inset) or strokeWidth ~= math_floor(strokeWidth) then return false end
	if inset < 0 or inset > 31 or strokeWidth < 0 or strokeWidth > 15 then return false end
	if fill.kind == FILL_SOLID then return true end
	if fill.kind ~= FILL_LINEAR then return false end

	return (fill.x1 or 0) == 0
		and (fill.y1 or 0) == 0
		and (fill.x2 or 1) == 1
		and (fill.y2 or 0) == 0
end

local function canDrawProgressFxFast(fill, inset, strokeWidth, shadow, backdrop, outerGlow, innerGlow, pattern, fillPattern, trackPattern)
	if not shadersActive() or not matOK(materials.progress_fx) then return false end
	if shadow or backdrop or outerGlow or innerGlow or pattern or fillPattern or trackPattern then return false end
	if inset ~= math_floor(inset) or strokeWidth ~= math_floor(strokeWidth) then return false end
	if inset < 0 or inset > 31 or strokeWidth < 0 or strokeWidth > 15 then return false end
	if fill.kind == FILL_SOLID then return true end
	if fill.kind ~= FILL_LINEAR then return false end

	return (fill.x1 or 0) == 0
		and (fill.y1 or 0) == 0
		and (fill.x2 or 1) == 1
		and (fill.y2 or 0) == 0
end

local function setupProgressConstants(mat, w, h, value, radius, inset, track, fill, stroke, strokeWidth)
	local fillA = fill.colorA or color_white
	local fillB = fill.colorB or fillA

	local r, g, b, a = color01(fillB)
	local br, bg, bb, ba = r, g, b, a

	local packedProgress = math_floor(inset) * 2 + math.Clamp(value, 0, 1) + gradientCurve(fill.curve) * 64
	local packedRadius = math_max(0, radius) + math.Clamp(strokeWidth, 0, 15) * 256

	r, g, b, a = color01(fillA)
	local ar, ag, ab, aa = r, g, b, a

	r, g, b, a = color01(stroke or transparentColor)
	setupParamMatrix(mat,
		br, bg, bb, ba,
		w, h, packedProgress, packedRadius,
		ar, ag, ab, aa,
		r, g, b, a
	)

	bindGradientLut(mat, fill)
	setDrawColor(track)
end

local function setupProgressFxConstants(mat, w, h, value, radius, inset, track, fill, stroke, strokeWidth, flags, ticks)
	local fillA = fill.colorA or color_white
	local fillB = fill.colorB or fillA

	flags = math.Clamp(math_floor(tonumber(flags) or 0), 0, 7)
	ticks = math.Clamp(math_floor(tonumber(ticks) or 0), 0, 31)
	radius = math.Clamp(tonumber(radius) or 0, 0, 255)
	inset = math.Clamp(math_floor(tonumber(inset) or 0), 0, 31)
	strokeWidth = math.Clamp(math_floor(tonumber(strokeWidth) or 0), 0, 15)

	local r, g, b, a = color01(fillB)
	local br, bg, bb, ba = r, g, b, a

	local packedFx = math.Clamp(value, 0, 1) * 0.5 + flags + ticks * 8 + gradientCurve(fill.curve) * 256
	local packedLayout = radius + strokeWidth * 256 + inset * 4096

	r, g, b, a = color01(fillA)
	local ar, ag, ab, aa = r, g, b, a

	r, g, b, a = color01(stroke or transparentColor)
	setupParamMatrix(mat,
		br, bg, bb, ba,
		w, h, packedFx, packedLayout,
		ar, ag, ab, aa,
		r, g, b, a
	)

	bindGradientLut(mat, fill)
	setDrawColor(track)
end

local function drawProgressBarFast(x, y, w, h, value, fill, radius, inset, track, stroke, strokeWidth)
	local pad = math_ceil(math_max(0, strokeWidth) * 0.5 + 1)
	if not hasTransform() and isCulled(x - pad, y - pad, w + pad * 2, h + pad * 2) then return end

	local mat = materials.progress
	setupProgressConstants(mat, w, h, value, radius, inset, track, fill, stroke, strokeWidth)
	surface_SetMaterial(mat)
	if pad > 1 and w > 0 and h > 0 then
		drawTexturedQuadUV(x - pad, y - pad, w + pad * 2, h + pad * 2, -pad / w, -pad / h, 1 + pad / w, 1 + pad / h, mat)
	else
		drawTexturedQuad(x, y, w, h, mat)
	end
end

local function drawProgressBarFxFast(x, y, w, h, value, fill, radius, inset, track, stroke, strokeWidth, flags, ticks)
	local pad = math_ceil(math_max(0, strokeWidth) * 0.5 + 1)
	if not hasTransform() and isCulled(x - pad, y - pad, w + pad * 2, h + pad * 2) then return end

	local mat = materials.progress_fx
	setupProgressFxConstants(mat, w, h, value, radius, inset, track, fill, stroke, strokeWidth, flags, ticks)
	surface_SetMaterial(mat)
	if pad > 1 and w > 0 and h > 0 then
		drawTexturedQuadUV(x - pad, y - pad, w + pad * 2, h + pad * 2, -pad / w, -pad / h, 1 + pad / w, 1 + pad / h, mat)
	else
		drawTexturedQuad(x, y, w, h, mat)
	end
end

	local function drawProgressBarRaw(x, y, w, h, value, radiusInput, trackInput, fillInput, strokeInput, strokeWidthInput, paddingInput, fxInput, shadow, outerGlow, innerGlow, backdrop, pattern, fillPattern, trackPattern)
		local frac = math.Clamp(tonumber(value) or 0, 0, 1)
		local radius = radiusInput or math_min(4, h * 0.5)
		local inset = math_max(0, tonumber(paddingInput) or 0)
		local track = trackInput or defaultProgressTrack
		local fill = fillFromStyle(fillInput or color_white)
		local stroke = strokeInput or defaultProgressStroke
		local _, strokeColor, strokeWidth, strokeKind, strokeLength, strokeGap, strokeOffset = strokeRaw(stroke, strokeWidthInput, 1)
		local flags, ticks = progressFx(fxInput)
		local hasFx = flags ~= 0 or ticks > 1
		recordDirectImmediate("DrawProgressBar", "progress")

	if strokeKind == STROKE_SOLID and hasFx and canDrawProgressFxFast(fill, inset, strokeWidth, shadow, backdrop, outerGlow, innerGlow, pattern, fillPattern, trackPattern) then
		return drawProgressBarFxFast(x, y, w, h, frac, fill, radius, inset, track, strokeColor, strokeWidth, flags, ticks)
		elseif strokeKind == STROKE_SOLID and canDrawProgressFast(fill, flags, ticks, inset, strokeWidth, shadow, backdrop, outerGlow, innerGlow, pattern, fillPattern, trackPattern) then
			return drawProgressBarFast(x, y, w, h, frac, fill, radius, inset, track, strokeColor, strokeWidth)
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
		local backdropSpec = backdrop ~= nil and backdrop ~= false and backdropStyle(backdrop) or nil
		local patternSpec = pattern ~= nil and pattern ~= false and patternStyle(pattern) or nil
		local fillPatternSpec = fillPattern ~= nil and fillPattern ~= false and patternStyle(fillPattern) or patternSpec
		local trackPatternSpec = trackPattern ~= nil and trackPattern ~= false and patternStyle(trackPattern) or nil

		progressTrackDarkColor.r = math_floor(track.r * 0.65)
		progressTrackDarkColor.g = math_floor(track.g * 0.65)
		progressTrackDarkColor.b = math_floor(track.b * 0.65)
		progressTrackDarkColor.a = track.a or 190
		local trackFill = setGradientColors(progressTrackGradient, progressTrackDarkColor, track)
			drawPreparedRoundRectEffects(
				x, y, w, h, radius,
				trackFill, strokeColor, strokeWidth,
				strokeKind, strokeLength, strokeGap, strokeOffset,
			hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread,
			hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread,
			hasInner, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff,
			backdropSpec, trackPatternSpec
		)

	local ih = h - inset * 2
	local iw = (w - inset * 2) * frac
	if frac >= 0.999 then iw = w - inset * 2 end
	if ih <= 0 then return end

		if ticks and ticks > 1 then
			for i = 1, ticks - 1 do
				local tx = x + math_floor(w * i / ticks)
				drawPreparedRoundRectPlain(tx, y + 3, 1, math_max(1, h - 6), 0, progressTickFill)
			end
		end

	if iw <= 0 then return end

		if fxFlag(flags, FX_GLOW) and iw > 4 then
			local glowRadius = math_min(radius + 2, (ih + 4) * 0.5, (iw + 4) * 0.5)
			drawPreparedRoundRectPlain(x + inset - 2, y + inset - 2, iw + 4, ih + 4, glowRadius, progressGlowFill)
		end

		local fillRadius = math_min(math_max(0, radius - inset), ih * 0.5, iw * 0.5)
		drawPreparedRoundRectPlain(x + inset, y + inset, iw, ih, fillRadius, fill, nil, nil, fillPatternSpec)

		if fxFlag(flags, FX_SHEEN) and iw > 8 then
			local sheenRadius = math_min(radius, ih * 0.25)
			drawPreparedRoundRectPlain(x + inset + 1, y + inset + 1, math_max(1, iw - 2), math_max(1, ih * 0.38), sheenRadius, progressSheenGradient)
		end

		if fxFlag(flags, FX_MARKER) and iw > 5 then
			local mx = x + inset + iw - 2
			drawPreparedRoundRectPlain(mx, y + 2, 2, h - 4, 1, progressMarkerFill)
		end
	end

function M.ProgressBarEx(x, y, w, h, value, style)
	style = resolveDrawStyle(style, M.TARGET.PROGRESS_BAR)
	local transform
	transform, style = splitStyleTransform(style)

	if not transform then
		return drawProgressBarRaw(x, y, w, h, value, style.radius, style.track, style.fill or style.color, style.stroke, style.strokeWidth, style.padding, style.fx, style.shadow, style.outerGlow, style.innerGlow, style.backdrop, style.pattern, style.fillPattern, style.trackPattern)
	end

	return withTransform(transform, x, y, w, h, function()
		return drawProgressBarRaw(x, y, w, h, value, style.radius, style.track, style.fill or style.color, style.stroke, style.strokeWidth, style.padding, style.fx, style.shadow, style.outerGlow, style.innerGlow, style.backdrop, style.pattern, style.fillPattern, style.trackPattern)
	end)
end

function M.ProgressBar(x, y, w, h, value, radius, track, fill, stroke, strokeWidth)
	return drawProgressBarRaw(x, y, w, h, value, radius, track, fill, stroke, strokeWidth, nil, nil, nil, nil, nil, nil, nil, nil, nil)
end

local function segmentFillEndpoints(fill)
	if fill.stops and #fill.stops > 0 then
		local first
		local last
		for _, stop in ipairs(fill.stops) do
			local color = stop.color or stop[2]
			if color and (color.a == nil or color.a > 0) then
				first = first or color
				last = color
			end
		end

		if first and last then return first, last end
	end

	return fill.colorA or color_white, fill.colorB or fill.colorA or color_white
end

	local function drawSegmentBarFallbackRaw(x, y, w, h, value, segments, fillInput, colorInput, trackInput, radiusInput, gapInput, backgroundRadius, background, stroke, strokeWidthInput, shadow, outerGlow, innerGlow, backdrop, pattern, fillPattern, trackPattern)
		local count = math.Clamp(math_floor(tonumber(segments) or 10), 1, 128)
		local gap = math_max(0, tonumber(gapInput) or 2)
		local frac = math.Clamp(tonumber(value) or 0, 0, 1)
		local active = math_floor(frac * count + 0.0001)
		local fill = fillFromStyle(fillInput or colorInput or defaultSegmentFill)
		local track = trackInput or defaultSegmentTrack
		local _, strokeColor, strokeWidth, strokeKind, strokeLength, strokeGap, strokeOffset = strokeRaw(stroke, strokeWidthInput, 0)
		local totalGap = gap * (count - 1)
		local segW = (w - totalGap) / count
		if segW <= 0 or h <= 0 then return end
		local containerRadius = backgroundRadius or radiusInput or math_min(3, h * 0.5)

		if shadow or outerGlow or innerGlow or backdrop or background then
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
			local backdropSpec = backdrop ~= nil and backdrop ~= false and backdropStyle(backdrop) or nil
			local backgroundFill = background ~= nil and fillFromStyle(background) or solidFillInto(segmentContainerFillScratch, transparentColor)
			drawPreparedRoundRectEffects(
				x, y, w, h, containerRadius,
				backgroundFill, nil, 0,
				STROKE_SOLID, 0, 0, 0,
				hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread,
				hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread,
				hasInner, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff,
				backdropSpec, nil
			)
		end

		local itemRadius = radiusInput == nil and math_min(2, h * 0.35) or radiusInput
		local trackFill = fillFromStyle(track)
		local patternSpec = pattern ~= nil and pattern ~= false and patternStyle(pattern) or nil
		local fillPatternSpec = fillPattern ~= nil and fillPattern ~= false and patternStyle(fillPattern) or patternSpec
		local trackPatternSpec = trackPattern ~= nil and trackPattern ~= false and patternStyle(trackPattern) or nil
		for i = 1, count do
			local t = count == 1 and 1 or (i - 1) / (count - 1)
			local sx = x + (i - 1) * (segW + gap)
			local color = i <= active and colorAtFill(fill, t) or track
			local itemFill = i <= active and solidFillInto(segmentItemFillScratch, color) or trackFill
			local itemPattern = i <= active and fillPatternSpec or trackPatternSpec
			if preparedFillVisible(itemFill) or itemPattern then
				drawPreparedRoundRectPlain(sx, y, segW, h, itemRadius, itemFill, strokeColor, strokeWidth, itemPattern, strokeKind, strokeLength, strokeGap, strokeOffset)
			end
		end
	end

local function drawSegmentBarShaderRaw(x, y, w, h, value, segments, fillInput, colorInput, trackInput, radiusInput, gapInput, background, stroke, strokeWidthInput, shadow, outerGlow, innerGlow, backdrop, pattern, fillPattern, trackPattern)
	if not shadersActive() or not matOK(materials.segmentbar) then return false end
	if background or shadow or backdrop then return false end
	if strokeVisible(stroke, strokeWidthInput) then return false end
	if outerGlow or innerGlow or pattern or fillPattern or trackPattern then return false end

	local count = math.Clamp(math_floor(tonumber(segments) or 10), 1, 128)
	local gap = math_max(0, tonumber(gapInput) or 2)
	local totalGap = gap * (count - 1)
	local segW = (w - totalGap) / count
	if segW <= 0 or h <= 0 then return true end

	local fill = fillFromStyle(fillInput or colorInput or defaultSegmentFill)
	local track = asColor(trackInput or defaultSegmentTrack, defaultSegmentTrack)
	local fillA, fillB = segmentFillEndpoints(fill)
	local hasFill = preparedFillVisible(fill)
	local hasTrack = track.a == nil or track.a > 0
	if not hasFill and not hasTrack then return true end

	local mat = materials.segmentbar
	local r, g, b, a = color01(fillB)
	local fr, fg, fb, fa = r, g, b, a

	r, g, b, a = color01(track)
	setupParamMatrix(mat,
		fr, fg, fb, fa,
		r, g, b, a,
		w, h, count, gap,
		math.Clamp(tonumber(value) or 0, 0, 1),
		math_max(0, tonumber(radiusInput == nil and math_min(2, h * 0.35) or radiusInput) or 0),
		gradientCurve(fill.curve), 0
	)

	bindGradientLut(mat, fill)
	setDrawColor(fillA)
	surface_SetMaterial(mat)
	drawTexturedQuad(x, y, w, h, mat)
	return true
end

local function drawSegmentBarRaw(x, y, w, h, value, segments, fill, color, track, radius, gap, backgroundRadius, background, stroke, strokeWidth, shadow, outerGlow, innerGlow, backdrop, pattern, fillPattern, trackPattern)
	if drawSegmentBarShaderRaw(x, y, w, h, value, segments, fill, color, track, radius, gap, background, stroke, strokeWidth, shadow, outerGlow, innerGlow, backdrop, pattern, fillPattern, trackPattern) then return end
	return drawSegmentBarFallbackRaw(x, y, w, h, value, segments, fill, color, track, radius, gap, backgroundRadius, background, stroke, strokeWidth, shadow, outerGlow, innerGlow, backdrop, pattern, fillPattern, trackPattern)
end

function M.SegmentBarEx(x, y, w, h, value, style)
	style = resolveDrawStyle(style, M.TARGET.SEGMENT_BAR)
	local transform
	transform, style = splitStyleTransform(style)

	recordDirectImmediate("DrawSegmentBar", "segment")
	if not transform then
		return drawSegmentBarRaw(x, y, w, h, value, style.segments, style.fill, style.color, style.track, style.radius, style.gap, style.backgroundRadius, style.background, style.stroke, style.strokeWidth, style.shadow, style.outerGlow, style.innerGlow, style.backdrop, style.pattern, style.fillPattern, style.trackPattern)
	end
	return withTransform(transform, x, y, w, h, function()
		return drawSegmentBarRaw(x, y, w, h, value, style.segments, style.fill, style.color, style.track, style.radius, style.gap, style.backgroundRadius, style.background, style.stroke, style.strokeWidth, style.shadow, style.outerGlow, style.innerGlow, style.backdrop, style.pattern, style.fillPattern, style.trackPattern)
	end)
end

function M.SegmentBar(x, y, w, h, value, segments, fill, track)
	recordDirectImmediate("DrawSegmentBar", "segment")
	return drawSegmentBarRaw(x, y, w, h, value, segments, fill, nil, track, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)
end


	C.drawProgressBarImmediate = M.ProgressBarEx
	C.drawSegmentBarImmediate = drawSegmentBarRaw
end
