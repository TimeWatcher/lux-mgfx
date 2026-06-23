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
	local radiusTuple = C.radiusTuple
	local radiusScalar = C.radiusScalar
	local fillFromStyle = C.fillFromStyle
	local fillVisible = C.fillVisible
	local strokeVisible = C.strokeVisible
	local colorAtFill = C.colorAtFill
	local bindGradientLut = C.bindGradientLut or function() end
	local isCulled = C.isCulled
	local normalizedRotation = C.normalizedRotation
	local imageMaskStyle = C.imageMaskStyle or function(mask) return mask end
	local setupParamMatrix = C.setupParamMatrix
	local setupConstants = C.setupConstants
	local drawTexturedQuad = C.drawTexturedQuad
	local withTransform = C.withTransform or function(_, _, _, _, _, fn) return fn() end
	local splitStyleTransform = C.splitStyleTransform or function(style) return nil, style end
	local hasTransform = C.hasTransform or function() return false end
	local drawCreatedMaterialTexturedRectUV = C.drawCreatedMaterialTexturedRectUV
	local imageTint = C.imageTint
	local imageStyle = C.imageStyle
	local imageRadius = C.imageRadius
	local imageUV = C.imageUV
	local imageFitRect = C.imageFitRect
	local drawRoundRectImmediate = C.drawRoundRectImmediate
	local drawRoundRectOuterGlow = C.drawRoundRectOuterGlow
	local innerGlowStyle = C.innerGlowStyle
	local outerGlowStyle = C.outerGlowStyle
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


	local function progressFx(style)
		local fx = istable(style.fx) and style.fx or nil
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

local function canDrawProgressFast(fill, style, inset, strokeWidth)
	if not shadersActive() or not matOK(materials.progress) then return false end
	local flags, ticks = progressFx(style)
	if flags ~= 0 or ticks > 1 then return false end
	if style.shadow or style.backdrop or style.outerGlow or style.innerGlow or style.pattern or style.fillPattern or style.trackPattern then return false end
	if inset ~= math_floor(inset) or strokeWidth ~= math_floor(strokeWidth) then return false end
	if inset < 0 or inset > 31 or strokeWidth < 0 or strokeWidth > 15 then return false end
	if fill.kind == FILL_SOLID then return true end
	if fill.kind ~= FILL_LINEAR then return false end

	return (fill.x1 or 0) == 0
		and (fill.y1 or 0) == 0
		and (fill.x2 or 1) == 1
		and (fill.y2 or 0) == 0
end

local function canDrawProgressFxFast(fill, style, inset, strokeWidth)
	if not shadersActive() or not matOK(materials.progress_fx) then return false end
	if style.shadow or style.backdrop or style.outerGlow or style.innerGlow or style.pattern or style.fillPattern or style.trackPattern then return false end
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

	local packedProgress = math_floor(inset) * 2 + math.Clamp(value, 0, 1)
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

	local packedFx = math.Clamp(value, 0, 1) * 0.5 + flags + ticks * 8
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

local function drawProgressBarFast(x, y, w, h, value, style, fill, radius, inset, track, stroke, strokeWidth)
	if not hasTransform() and isCulled(x, y, w, h) then return end

	local mat = materials.progress
	setupProgressConstants(mat, w, h, value, radius, inset, track, fill, stroke, strokeWidth)
	surface_SetMaterial(mat)
	drawTexturedQuad(x, y, w, h)
end

local function drawProgressBarFxFast(x, y, w, h, value, style, fill, radius, inset, track, stroke, strokeWidth, flags, ticks)
	if not hasTransform() and isCulled(x, y, w, h) then return end

	local mat = materials.progress_fx
	setupProgressFxConstants(mat, w, h, value, radius, inset, track, fill, stroke, strokeWidth, flags, ticks)
	surface_SetMaterial(mat)
	drawTexturedQuad(x, y, w, h)
end

local function drawProgressBarImmediate(x, y, w, h, value, style)
	local frac = math.Clamp(tonumber(value) or 0, 0, 1)
	local radius = style.radius or math_min(4, h * 0.5)
	local inset = math_max(0, tonumber(style.padding) or 0)
	local track = style.track or defaultProgressTrack
	local fill = fillFromStyle(style.fill or color_white)
	local stroke = style.stroke or defaultProgressStroke
	local strokeWidth = strokeWidthValue(style.strokeWidth, 1)
	local flags, ticks = progressFx(style)
	local hasFx = flags ~= 0 or ticks > 1

	if hasFx and canDrawProgressFxFast(fill, style, inset, strokeWidth) then
		recordDirectImmediate("DrawProgressBar", "progress")
		return drawProgressBarFxFast(x, y, w, h, frac, style, fill, radius, inset, track, stroke, strokeWidth, flags, ticks)
	elseif canDrawProgressFast(fill, style, inset, strokeWidth) then
		recordDirectImmediate("DrawProgressBar", "progress")
		return drawProgressBarFast(x, y, w, h, frac, style, fill, radius, inset, track, stroke, strokeWidth)
	end

	recordDirectImmediate("DrawProgressBar", "progress")
	M.RoundedBoxEx(x, y, w, h, {
		radius = radius,
		fill = M.LinearGradient(0, 0, 0, 1, Color(math_floor(track.r * 0.65), math_floor(track.g * 0.65), math_floor(track.b * 0.65), track.a or 190), track),
		stroke = stroke,
		strokeWidth = strokeWidth,
		shadow = style.shadow,
		outerGlow = style.outerGlow,
		innerGlow = style.innerGlow,
		backdrop = style.backdrop,
		pattern = style.trackPattern,
	})

	local ih = h - inset * 2
	local iw = (w - inset * 2) * frac
	if frac >= 0.999 then iw = w - inset * 2 end
	if ih <= 0 then return end

	if ticks and ticks > 1 then
		local tickColor = Color(255, 255, 255, 18)
		for i = 1, ticks - 1 do
			local tx = x + math_floor(w * i / ticks)
			M.RoundedBoxEx(tx, y + 3, 1, math_max(1, h - 6), {
				radius = 0,
				fill = tickColor,
			})
		end
	end

	if iw <= 0 then return end

	if fxFlag(flags, FX_GLOW) and iw > 4 then
		local glowColor = Color(80, 190, 255, 38)
		M.RoundedBoxEx(x + inset - 2, y + inset - 2, iw + 4, ih + 4, {
			radius = math_min(radius + 2, (ih + 4) * 0.5, (iw + 4) * 0.5),
			fill = glowColor,
		})
	end

	M.RoundedBoxEx(x + inset, y + inset, iw, ih, {
		radius = math_min(math_max(0, radius - inset), ih * 0.5, iw * 0.5),
		fill = fill,
		pattern = style.fillPattern or style.pattern,
	})

	if fxFlag(flags, FX_SHEEN) and iw > 8 then
		M.RoundedBoxEx(x + inset + 1, y + inset + 1, math_max(1, iw - 2), math_max(1, ih * 0.38), {
			radius = math_min(radius, ih * 0.25),
			fill = M.LinearGradient(0, 0, 0, 1, Color(255, 255, 255, 42), Color(255, 255, 255, 0)),
		})
	end

	if fxFlag(flags, FX_MARKER) and iw > 5 then
		local mx = x + inset + iw - 2
		M.RoundedBoxEx(mx, y + 2, 2, h - 4, {
			radius = 1,
			fill = Color(255, 255, 255, 96),
		})
	end
end

function M.ProgressBarEx(x, y, w, h, value, style)
	style = resolveDrawStyle(style, M.TARGET.PROGRESS_BAR)
	local transform
	transform, style = splitStyleTransform(style)

	if not transform then
		return drawProgressBarImmediate(x, y, w, h, value, style)
	end

	return withTransform(transform, x, y, w, h, function()
		return drawProgressBarImmediate(x, y, w, h, value, style)
	end)
end

local progressBarArgStyle = {}

function M.ProgressBar(x, y, w, h, value, radius, track, fill, stroke, strokeWidth)
	progressBarArgStyle.radius = radius
	progressBarArgStyle.track = track
	progressBarArgStyle.fill = fill
	progressBarArgStyle.stroke = stroke
	progressBarArgStyle.strokeWidth = strokeWidth
	progressBarArgStyle.padding = nil
	progressBarArgStyle.fx = nil
	return M.ProgressBarEx(x, y, w, h, value, progressBarArgStyle)
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

local function drawSegmentBarFallback(x, y, w, h, value, style)
	style = style or {}
	local count = math.Clamp(math_floor(tonumber(style.segments) or 10), 1, 128)
	local gap = math_max(0, tonumber(style.gap) or 2)
	local frac = math.Clamp(tonumber(value) or 0, 0, 1)
	local active = math_floor(frac * count + 0.0001)
	local fill = fillFromStyle(style.fill or style.color or defaultSegmentFill)
	local track = style.track or defaultSegmentTrack
	local totalGap = gap * (count - 1)
	local segW = (w - totalGap) / count
	if segW <= 0 or h <= 0 then return end
	local containerRadius = style.backgroundRadius or style.radius or math_min(3, h * 0.5)

	if style.shadow or style.outerGlow or style.innerGlow or style.backdrop or style.background then
		M.RoundedBoxEx(x, y, w, h, {
			radius = containerRadius,
			fill = style.background or transparentColor,
			shadow = style.shadow,
			outerGlow = style.outerGlow,
			innerGlow = style.innerGlow,
			backdrop = style.backdrop,
		})
	end

	for i = 1, count do
		local t = count == 1 and 1 or (i - 1) / (count - 1)
		local sx = x + (i - 1) * (segW + gap)
		local color = i <= active and colorAtFill(fill, t) or track
		local pattern = i <= active and (style.fillPattern or style.pattern) or style.trackPattern
		if (color and (color.a or 255) > 0) or pattern then
			M.RoundedBoxEx(sx, y, segW, h, {
				radius = style.radius == nil and math_min(2, h * 0.35) or style.radius,
				fill = color or transparentColor,
				pattern = pattern,
				stroke = style.stroke,
				strokeWidth = style.strokeWidth or 0,
			})
		end
	end
end

local function drawSegmentBarShader(x, y, w, h, value, style)
	if not shadersActive() or not matOK(materials.segmentbar) then return false end
	if style.background or style.shadow or style.backdrop then return false end
	if strokeVisible(style.stroke, style.strokeWidth) then return false end
	if style.outerGlow or style.innerGlow or style.pattern or style.fillPattern or style.trackPattern then return false end

	local count = math.Clamp(math_floor(tonumber(style.segments) or 10), 1, 128)
	local gap = math_max(0, tonumber(style.gap) or 2)
	local totalGap = gap * (count - 1)
	local segW = (w - totalGap) / count
	if segW <= 0 or h <= 0 then return true end

	local fill = fillFromStyle(style.fill or style.color or defaultSegmentFill)
	local track = asColor(style.track or defaultSegmentTrack, defaultSegmentTrack)
	local fillA, fillB = segmentFillEndpoints(fill)
	local hasFill = fillVisible(fill)
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
		math_max(0, tonumber(style.radius == nil and math_min(2, h * 0.35) or style.radius) or 0),
		0, 0
	)

	bindGradientLut(mat, fill)
	setDrawColor(fillA)
	surface_SetMaterial(mat)
	drawTexturedQuad(x, y, w, h)
	return true
end

local function drawSegmentBarImmediate(x, y, w, h, value, style)
	style = style or {}
	if drawSegmentBarShader(x, y, w, h, value, style) then return end
	return drawSegmentBarFallback(x, y, w, h, value, style)
end

function M.SegmentBarEx(x, y, w, h, value, style)
	style = resolveDrawStyle(style, M.TARGET.SEGMENT_BAR)
	local transform
	transform, style = splitStyleTransform(style)

	recordDirectImmediate("DrawSegmentBar", "segment")
	if not transform then
		return drawSegmentBarImmediate(x, y, w, h, value, style)
	end
	return withTransform(transform, x, y, w, h, function()
		return drawSegmentBarImmediate(x, y, w, h, value, style)
	end)
end

local segmentBarArgStyle = {}

function M.SegmentBar(x, y, w, h, value, segments, fill, track)
	segmentBarArgStyle.segments = segments
	segmentBarArgStyle.fill = fill
	segmentBarArgStyle.track = track
	segmentBarArgStyle.radius = nil
	segmentBarArgStyle.gap = nil
	segmentBarArgStyle.stroke = nil
	segmentBarArgStyle.strokeWidth = nil
	return M.SegmentBarEx(x, y, w, h, value, segmentBarArgStyle)
end


	C.drawProgressBarImmediate = M.ProgressBarEx
	C.drawSegmentBarImmediate = drawSegmentBarImmediate
end
