if SERVER then return end

MGFX = MGFX or {}

function MGFX._InstallWidgetImages(C)
	local M = C.M
	local materials = C.materials
	local forceFallback = C.forceFallback
	local recordDirectImmediate = C.recordDirectImmediate or function() end
	local profiler = C.profiler
	local copyStyle = C.copyStyle or function(style) return istable(style) and table.Copy(style) or {} end
	local resolveDrawStyle = C.resolveDrawStyle or copyStyle
	local matOK = C.matOK
	local shadersActive = C.shadersActive or function() return not forceFallback:GetBool() and M.hasShaders() end
	local asColor = C.asColor
	local color01 = C.color01
	local setDrawColor = C.setDrawColor
	local strokeWidthValue = C.strokeWidthValue
	local strokeRaw = C.strokeRaw
	local strokeKind = C.strokeKind
	local STROKE_SOLID = C.STROKE_SOLID or 0
	local radiusTuple = C.radiusTuple
	local radiusScalar = C.radiusScalar
	local fillFromStyle = C.fillFromStyle
	local fillVisible = C.fillVisible
	local strokeVisible = C.strokeVisible
	local backdropStyle = C.backdropStyle or function() return nil end
	local colorAtFill = C.colorAtFill
	local isCulled = C.isCulled
	local normalizedRotation = C.normalizedRotation
	local imageMaskStyle = C.imageMaskStyle or function(mask) return mask end
	local setupParamMatrix = C.setupParamMatrix
	local setupExtraParams = C.setupExtraParams
	local setupConstants = C.setupConstants
	local drawTexturedQuad = C.drawTexturedQuad
	local drawTexturedQuadUV = C.drawTexturedQuadUV
	local withTransform = C.withTransform or function(_, _, _, _, _, fn) return fn() end
	local splitStyleTransform = C.splitStyleTransform or function(style) return nil, style end
	local hasTransform = C.hasTransform or function() return false end
	local beginPanelEffectBleed = assert(C.beginPanelEffectBleed, "MGFX panel bleed begin helper unavailable")
	local endPanelEffectBleed = assert(C.endPanelEffectBleed, "MGFX panel bleed end helper unavailable")
	local drawBlurredCustomQuad = C.drawBlurredCustomQuad
	local drawCreatedMaterialTexturedRectUV = C.drawCreatedMaterialTexturedRectUV
	local textureSize = C.textureSize
	local imageTint = C.imageTint
	local imageStyle = C.imageStyle
	local imageRadius = C.imageRadius
	local imageUV = C.imageUV
	local imageFitRect = C.imageFitRect
	local drawRoundRectRaw = C.drawRoundRectRaw
	local drawRoundRectPrepared = assert(C.drawRoundRectPrepared, "MGFX roundrect prepared helper unavailable")
	local drawRoundRectOuterGlow = C.drawRoundRectOuterGlow
	local roundRaw = assert(C.roundRaw, "MGFX raw effect helper unavailable")
	local chamferTuple = C.chamferTuple
	local drawChamferBoxRaw = assert(C.drawChamferBoxRaw, "MGFX chamfer raw helper unavailable")
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
	local transparentFill = {kind = FILL_SOLID, colorA = transparentColor, colorB = transparentColor, _mgfxFillVisible = false}
	local sourceAlphaMaskScratch = {kind = "texture", channel = "alpha", sourceAlpha = true}

	local function preparedStrokeVisible(strokeValue, strokeWidth)
		return strokeValue ~= nil and (strokeValue.a == nil or strokeValue.a > 0) and (strokeWidth or 0) > 0
	end

	local function preparedFillVisible(fill)
		if fill == nil then return false end
		if fill._mgfxFillVisible ~= nil then return fill._mgfxFillVisible end
		if fill.r ~= nil and fill.g ~= nil and fill.b ~= nil then return fill.a == nil or fill.a > 0 end
		return fillVisible(fill)
	end

	local function drawPreparedRoundRectPlain(x, y, w, h, radius, fill, strokeValue, strokeWidth, patternSpec)
		return drawRoundRectPrepared(
			x, y, w, h, radius,
			fill or transparentFill, preparedFillVisible(fill), strokeValue, strokeWidth or 0, preparedStrokeVisible(strokeValue, strokeWidth),
			STROKE_SOLID, 0, 0, 0,
			false, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0,
			false, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0,
			false, 0, 0, 0, 0, 0, 0, 1,
			nil, patternSpec
		)
	end

	local function drawPreparedRoundRectEffects(
		x, y, w, h, radius, fill, strokeValue, strokeWidth,
		hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread,
		hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread,
		hasInner, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff,
		backdropSpec, patternSpec
	)
		return drawRoundRectPrepared(
			x, y, w, h, radius,
			fill or transparentFill, preparedFillVisible(fill), strokeValue, strokeWidth or 0, preparedStrokeVisible(strokeValue, strokeWidth),
			STROKE_SOLID, 0, 0, 0,
			hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread,
			hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread,
			hasInner, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff,
			backdropSpec, patternSpec
		)
	end

	local function drawRoundImageEffect(x, y, w, h, radius, fill, shadow, outerGlow, backdrop, stroke, strokeWidth)
		return drawRoundRectRaw(x, y, w, h, radius, fill, stroke, strokeWidth, shadow, outerGlow, nil, backdrop, nil)
	end

	local function drawChamferImageEffect(x, y, w, h, cuts, fill, shadow, outerGlow, backdrop, stroke, strokeWidth)
		return drawChamferBoxRaw(x, y, w, h, cuts, fill, stroke, strokeWidth, shadow, outerGlow, nil, backdrop, nil)
	end

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

local function textureSource(source)
	if isstring(source) then
		local mat = materialCache[source]
		if mat == nil then
			mat = Material(source, "smooth noclamp")
			materialCache[source] = mat and not mat:IsError() and mat or false
		end

		if mat == false then return nil end
		if mat and not mat:IsError() then
			return mat:GetTexture("$basetexture"), mat
		end
		return nil
	end

	if source and source.GetTexture then
		return source:GetTexture("$basetexture"), source
	end

	if source and source.GetName then
		return source, nil
	end
end

local whiteTexture

local function getWhiteTexture()
	if whiteTexture ~= nil then return whiteTexture end
	whiteTexture = textureSource("color/white") or false
	return whiteTexture ~= false and whiteTexture or nil
end

local function fallbackMaterialForTexture(texture)
	if not texture then return nil end

	if not textureFallbackMaterial then
		textureFallbackMaterial = CreateMaterial("mgfx_texture_fallback_" .. SysTime(), "UnlitGeneric", {
			["$basetexture"] = "color/white",
			["$translucent"] = "1",
			["$vertexalpha"] = "1",
			["$vertexcolor"] = "1",
		})
	end

	textureFallbackMaterial:SetTexture("$basetexture", texture)
	return textureFallbackMaterial
end

local function drawImageFallback(x, y, w, h, source, style)
	M.stats.fallbacks = M.stats.fallbacks + 1

	local texture, material = textureSource(source)
	local createdMaterialFallback = not material
	material = material or fallbackMaterialForTexture(texture)
	if not texture or not material or w <= 0 or h <= 0 then return end

	local u0, v0, u1, v1 = imageUV(style, texture)
	x, y, w, h, u0, v0, u1, v1 = imageFitRect(x, y, w, h, texture, style, u0, v0, u1, v1)
	if w <= 0 or h <= 0 then return end

	local radius = imageRadius(style.radius, w, h)
	local background = style.fill or style.background
	if background and (background.a or 255) > 0 then
		drawRoundImageEffect(x, y, w, h, radius, background)
	end

	surface_SetMaterial(material)
	setDrawColor(imageTint(style))
	if hasTransform() then
		drawTexturedQuadUV(x, y, w, h, u0, v0, u1, v1, material)
	elseif createdMaterialFallback then
		drawCreatedMaterialTexturedRectUV(x, y, w, h, u0, v0, u1, v1)
		M.stats.draws = M.stats.draws + 1
	else
		drawTexturedQuadUV(x, y, w, h, u0, v0, u1, v1, material)
	end

	local hasStroke, strokeColor, strokeWidth = strokeRaw(style.stroke, style.strokeWidth, 0)
	if hasStroke then
		drawRoundImageEffect(x, y, w, h, radius, transparentColor, nil, nil, nil, strokeColor, math_max(1, strokeWidth))
	end
end

local function imageFitRectRaw(x, y, w, h, texture, fit, u0, v0, u1, v1)
	if not isstring(fit) then fit = "fill" end
	fit = string.lower(fit)
	if fit == "stretch" then fit = "fill" end
	if fit == "fill" then
		return x, y, w, h, u0, v0, u1, v1
	end

	local tw, th = textureSize(texture)
	local spanU, spanV = u1 - u0, v1 - v0
	local sourceW, sourceH = math_max(1, tw * spanU), math_max(1, th * spanV)
	local sourceAspect = sourceW / sourceH
	local destAspect = math_max(1, w) / math_max(1, h)
	local ax, ay = 0.5, 0.5

	if fit == "cover" then
		if sourceAspect > destAspect then
			local newSpanU = spanV * th * destAspect / tw
			local extra = spanU - newSpanU
			u0 = u0 + extra * ax
			u1 = u0 + newSpanU
		elseif sourceAspect < destAspect then
			local newSpanV = spanU * tw / destAspect / th
			local extra = spanV - newSpanV
			v0 = v0 + extra * ay
			v1 = v0 + newSpanV
		end
	elseif fit == "contain" then
		if sourceAspect > destAspect then
			local newH = w / sourceAspect
			y = y + (h - newH) * ay
			h = newH
		elseif sourceAspect < destAspect then
			local newW = h * sourceAspect
			x = x + (w - newW) * ax
			w = newW
		end
	end

	return x, y, w, h, u0, v0, u1, v1
end

local function drawImageRawFallback(x, y, w, h, source, radius, tint, fit)
	M.stats.fallbacks = M.stats.fallbacks + 1

	local texture, material = textureSource(source)
	local createdMaterialFallback = not material
	material = material or fallbackMaterialForTexture(texture)
	if not material then return end

	local u0, v0, u1, v1 = 0, 0, 1, 1
	x, y, w, h, u0, v0, u1, v1 = imageFitRectRaw(x, y, w, h, texture, fit, u0, v0, u1, v1)
	if w <= 0 or h <= 0 then return end

	surface_SetMaterial(material)
	setDrawColor(asColor(tint, color_white))
	if hasTransform() then
		drawTexturedQuadUV(x, y, w, h, u0, v0, u1, v1, material)
	elseif createdMaterialFallback then
		drawCreatedMaterialTexturedRectUV(x, y, w, h, u0, v0, u1, v1)
		M.stats.draws = M.stats.draws + 1
	else
		drawTexturedQuadUV(x, y, w, h, u0, v0, u1, v1, material)
	end
end

local function imageChamferCuts(style, mask)
	if not istable(style) then return nil end
	mask = mask or imageMaskStyle(style.mask, style)
	if istable(mask) and mask.kind == "chamfer" then
		return mask.cuts or 0
	end
	return nil
end

local function maskKindValue(mask)
	if not istable(mask) then return nil end
	local kind = mask.kind or mask.shape
	if not isstring(kind) then return nil end

	kind = string.lower(kind)
	if kind == "round" or kind == "rounded" or kind == "roundedbox" or kind == "roundrect" then return MASK_ROUNDED end
	if kind == "chamfer" or kind == "bevel" then return MASK_CHAMFER end
	if kind == "circle" then return MASK_CIRCLE end
	if kind == "capsule" or kind == "pill" then return MASK_CAPSULE end
	if kind == "texture" or kind == "alpha" or kind == "image" then return MASK_TEXTURE_A end
	return nil
end

local function maskTextureChannelKind(channel)
	if channel == nil then return MASK_TEXTURE_A end
	channel = string.lower(tostring(channel))
	if channel == "a" or channel == "alpha" then return MASK_TEXTURE_A end
	if channel == "r" or channel == "red" then return MASK_TEXTURE_R end
	if channel == "g" or channel == "green" then return MASK_TEXTURE_G end
	if channel == "b" or channel == "blue" then return MASK_TEXTURE_B end
	if channel == "luma" or channel == "lum" or channel == "luminance" or channel == "rgb" then return MASK_TEXTURE_LUMA end
	return nil
end

local function maskTextureSource(mask)
	if not istable(mask) then return nil end
	local source = mask.source or mask.material or mask.texture or mask.image
	if source == nil then return nil end
	return textureSource(source)
end

local function resolveMaskTexture(mask, kind)
	if kind >= MASK_TEXTURE_A then
		local resolvedKind = maskTextureChannelKind(mask.channel)
		if not resolvedKind then return nil, nil end

		local texture = maskTextureSource(mask)
		if not texture then return nil, nil end
		return resolvedKind, texture
	end

	return kind, nil
end

local function maskTextureUV(mask, texture)
	if not istable(mask) then return 0, 0, 1, 1 end
	if istable(mask.uv) or istable(mask.crop) then
		return imageUV(mask, texture)
	end

	local u0 = tonumber(mask.u0 or mask.x0 or mask[1]) or 0
	local v0 = tonumber(mask.v0 or mask.y0 or mask[2]) or 0
	local u1 = tonumber(mask.u1 or mask.x1 or mask[3]) or 1
	local v1 = tonumber(mask.v1 or mask.y1 or mask[4]) or 1

	u0, v0, u1, v1 = math.Clamp(u0, 0, 1), math.Clamp(v0, 0, 1), math.Clamp(u1, 0, 1), math.Clamp(v1, 0, 1)
	if u1 <= u0 then u0, u1 = 0, 1 end
	if v1 <= v0 then v0, v1 = 0, 1 end
	return u0, v0, u1, v1
end

local function chamferMaskTuple(mask, style, w, h)
	local cuts = mask and mask.cuts or 0
	return chamferTuple(cuts, w, h)
end

local function setupImageMaskConstants(mat, w, h, sourceU0, sourceV0, sourceU1, sourceV1, stroke, strokeWidth, mask, kind, maskTexture, sourceAlphaBase)
	local strokeColor = stroke or transparentColor
	local r, g, b, a = color01(strokeColor)
	local sr, sg, sb, sa = r, g, b, a

	local packedKind = kind
	if mask and (mask.invert or mask.inverse) then
		packedKind = packedKind + 128
	end
	if sourceAlphaBase then
		packedKind = packedKind + 65536
	end
	packedKind = packedKind + math.Clamp(math_floor(strokeWidthValue(strokeWidth, 0)), 0, 255) * 256

	local p0, p1, p2, p3
	if kind == MASK_CHAMFER then
		local tl, tr, br, bl = chamferMaskTuple(mask, {}, w, h)
		p0, p1, p2, p3 = tl, tr, br, bl
	elseif kind >= MASK_TEXTURE_A then
		local mu0, mv0, mu1, mv1 = maskTextureUV(mask, maskTexture)
		p0, p1, p2, p3 = mu0, mv0, mu1, mv1
	else
		p0, p1, p2, p3 = 0, 0, 0, 0
	end
	setupParamMatrix(mat,
		sr, sg, sb, sa,
		w, h, packedKind, mask and imageRadius(mask.radius, w, h) or 0,
		sourceU0, sourceV0, sourceU1, sourceV1,
		p0, p1, p2, p3
	)
end

local function drawImageMaskPass(x, y, w, h, texture, u0, v0, u1, v1, tint, stroke, strokeWidth, mask, kind, maskTexture, sourceAlphaBase)
	if not texture or not matOK(materials.image_mask) then return false end

	local mat = materials.image_mask
	-- Keep $basetexture fixed so DrawTexturedRectUV's local UV correction stays stable.
	mat:SetTexture("$texture1", texture)
	if maskTexture then
		mat:SetTexture("$texture2", maskTexture)
	end

	setupImageMaskConstants(mat, w, h, u0, v0, u1, v1, stroke, strokeWidth, mask, kind, maskTexture, sourceAlphaBase == true)
	setDrawColor(tint or color_white)
	surface_SetMaterial(mat)
	drawTexturedQuad(x, y, w, h, mat)
	return true
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

local function setupImageMaskBackdropConstants(mat, drawW, drawH, shapeW, shapeH, mask, kind, maskTexture, vertical, intensity)
	local packedKind = kind
	if mask and (mask.invert or mask.inverse) then
		packedKind = packedKind + 128
	end

	local p0, p1, p2, p3
	if kind == MASK_CHAMFER then
		local tl, tr, br, bl = chamferMaskTuple(mask, {}, shapeW, shapeH)
		p0, p1, p2, p3 = tl, tr, br, bl
	elseif kind >= MASK_TEXTURE_A then
		local mu0, mv0, mu1, mv1 = maskTextureUV(mask, maskTexture)
		p0, p1, p2, p3 = mu0, mv0, mu1, mv1
		mat:SetTexture("$texture2", maskTexture)
	else
		p0, p1, p2, p3 = 0, 0, 0, 0
	end
	setupParamMatrix(mat,
		vertical and 1 or 0, intensity or 1, drawW, drawH,
		shapeW, shapeH, packedKind, mask and imageRadius(mask.radius, shapeW, shapeH) or 0,
		0, 0, 0, 0,
		p0, p1, p2, p3
	)
end

	local function drawImageMaskBackdrop(x, y, w, h, mask, kind, maskTexture, spec)
		if not spec or not istable(mask) or not kind then return nil end
		if kind >= MASK_TEXTURE_A and not maskTexture then return nil end
	local pad = math_max(0, tonumber(spec.padding) or 0)
	local bx = x - pad
	local by = y - pad
	local bw = w + pad * 2
	local bh = h + pad * 2

	if spec.blur > 0 and matOK(materials.image_mask_backdrop) and drawBlurredCustomQuad then
		local mat = materials.image_mask_backdrop
		drawBlurredCustomQuad(mat, bx, by, bw, bh, spec.blur, function(passMat, vertical, intensity)
			setupImageMaskBackdropConstants(passMat, bw, bh, w, h, mask, kind, maskTexture, vertical, intensity)
		end, spec.recapture, spec.level)
	end

	local tint = backdropTintColor(spec)
	if tint and matOK(materials.image_mask_backdrop_fill) then
		local mat = materials.image_mask_backdrop_fill
		surface_SetMaterial(mat)
		setDrawColor(tint)
		setupImageMaskBackdropConstants(mat, bw, bh, w, h, mask, kind, maskTexture, false, 0)
		drawTexturedQuad(bx, by, bw, bh, mat)
	end

		return spec
	end

	local function drawImageMaskShader(x, y, w, h, texture, u0, v0, u1, v1, tint, background, stroke, strokeWidth, mask, kind)
		if not istable(mask) then return false end
		kind = kind or maskKindValue(mask)
	if not kind then return false end
	if not matOK(materials.image_mask) then return true end

	local maskTexture
	if kind >= MASK_TEXTURE_A then
		kind = maskTextureChannelKind(mask.channel)
		if not kind then return true end

		maskTexture = maskTextureSource(mask)
		if not maskTexture then return true end
	end

		if background and background.r and (background.a == nil or background.a > 0) then
			local white = getWhiteTexture()
			if white then
				drawImageMaskPass(x, y, w, h, white, 0, 0, 1, 1, background, nil, 0, mask, kind, maskTexture)
			end
		end

		return drawImageMaskPass(x, y, w, h, texture, u0, v0, u1, v1, tint, stroke, strokeWidth, mask, kind, maskTexture, mask.sourceAlpha == true)
	end

local function setupImageMaskEffectParams(
	mat, w, h, mask, kind, maskTexture, drawW, drawH, shadowX, shadowY, outerX, outerY,
	hasShadow, sr, sg, sb, sa, shadowWidth, shadowStrength, shadowFalloff, shadowExtent,
	hasOuter, orr, og, ob, oa, outerWidth, outerStrength, outerFalloff, outerExtent
)
	if not setupExtraParams then return false end

	local packedKind = kind
	if mask and (mask.invert or mask.inverse) then
		packedKind = packedKind + 128
	end

	local p0, p1, p2, p3
	if kind == MASK_CHAMFER then
		local tl, tr, br, bl = chamferMaskTuple(mask, {}, w, h)
		p0, p1, p2, p3 = tl, tr, br, bl
	elseif kind >= MASK_TEXTURE_A then
		local mu0, mv0, mu1, mv1 = maskTextureUV(mask, maskTexture)
		p0, p1, p2, p3 = mu0, mv0, mu1, mv1
		mat:SetTexture("$texture1", maskTexture)
	else
		p0, p1, p2, p3 = 0, 0, 0, 0
	end

	setupParamMatrix(mat,
		drawW, drawH, w, h,
		packedKind, mask and imageRadius(mask.radius, w, h) or 0, hasShadow and shadowExtent or 0, hasOuter and outerExtent or 0,
		hasShadow and sr or 0, hasShadow and sg or 0, hasShadow and sb or 0, hasShadow and sa or 0,
		shadowX, shadowY, hasShadow and math_max(0.001, tonumber(shadowWidth) or 18) or 1, hasShadow and math_max(0, tonumber(shadowStrength) or 1) or 0
	)
	return setupExtraParams(mat,
		hasOuter and orr or 0, hasOuter and og or 0, hasOuter and ob or 0, hasOuter and oa or 0,
		outerX, outerY, hasOuter and math_max(0.001, tonumber(outerWidth) or 18) or 1, hasOuter and math_max(0, tonumber(outerStrength) or 1) or 0,
		hasShadow and math.Clamp(1 / math_max(tonumber(shadowFalloff) or 1.8, 0.001), 0.1, 1) or 1,
		hasOuter and math.Clamp(1 / math_max(tonumber(outerFalloff) or 1.8, 0.001), 0.1, 1) or 1,
		0, 0,
		p0, p1, p2, p3
	)
end

local function drawImageMaskShadowOuter(
	x, y, w, h, mask, kind,
	hasShadow, sr, sg, sb, sa, shadowOffsetX, shadowOffsetY, shadowWidth, shadowExtent, shadowGrow, shadowStrength, shadowFalloff,
	hasOuter, orr, og, ob, oa, outerOffsetX, outerOffsetY, outerWidth, outerExtent, outerGrow, outerStrength, outerFalloff
)
	if (not hasShadow and not hasOuter) or not istable(mask) or not shadersActive() or not matOK(materials.image_mask_shadow_outer) then return false end

	kind = kind or maskKindValue(mask)
	if not kind then return false end
	local maskTexture
	kind, maskTexture = resolveMaskTexture(mask, kind)
	if not kind then return false end

	hasShadow = hasShadow and sa > 0 and shadowStrength > 0
	hasOuter = hasOuter and oa > 0 and outerStrength > 0
	if not hasShadow and not hasOuter then return false end

	shadowExtent = math_max(0, tonumber(shadowExtent) or 0)
	outerExtent = math_max(0, tonumber(outerExtent) or 0)
	local shadowX = hasShadow and (x + (tonumber(shadowOffsetX) or 0) - shadowExtent) or x
	local shadowY = hasShadow and (y + (tonumber(shadowOffsetY) or 0) - shadowExtent) or y
	local outerX = hasOuter and (x + (tonumber(outerOffsetX) or 0) - outerExtent) or x
	local outerY = hasOuter and (y + (tonumber(outerOffsetY) or 0) - outerExtent) or y
	local sx = math_min(hasShadow and shadowX or outerX, hasOuter and outerX or shadowX)
	local sy = math_min(hasShadow and shadowY or outerY, hasOuter and outerY or shadowY)
	local ex = math_max(
		hasShadow and (shadowX + w + shadowExtent * 2) or (outerX + w + outerExtent * 2),
		hasOuter and (outerX + w + outerExtent * 2) or (shadowX + w + shadowExtent * 2)
	)
	local ey = math_max(
		hasShadow and (shadowY + h + shadowExtent * 2) or (outerY + h + outerExtent * 2),
		hasOuter and (outerY + h + outerExtent * 2) or (shadowY + h + shadowExtent * 2)
	)
	local drawW = ex - sx
	local drawH = ey - sy
	local mat = materials.image_mask_shadow_outer

	if not setupImageMaskEffectParams(
		mat, w, h, mask, kind, maskTexture, drawW, drawH, x - sx, y - sy, x - sx, y - sy,
		hasShadow, sr, sg, sb, sa, shadowWidth, shadowStrength, shadowFalloff, shadowExtent,
		hasOuter, orr, og, ob, oa, outerWidth, outerStrength, outerFalloff, outerExtent
	) then
		return false
	end

	local bleedLeft, bleedTop, bleedRight, bleedBottom = effectBleedFromDrawRect(x, y, w, h, sx, sy, drawW, drawH)
	local bleedToken = beginPanelEffectBleed(bleedLeft, bleedTop, bleedRight, bleedBottom)
	surface_SetDrawColor(255, 255, 255, 255)
	surface_SetMaterial(mat)
	drawTexturedQuad(sx, sy, drawW, drawH, mat)
	endPanelEffectBleed(bleedToken)
	return true
end

	local function drawImageChamfer(x, y, w, h, texture, u0, v0, u1, v1, tint, background, stroke, strokeWidth, shadow, outerGlow, backdrop, cuts)
		if not matOK(materials.chamfer_texture) then return false end

		if shadow or outerGlow then
			drawChamferImageEffect(x, y, w, h, cuts, transparentColor, shadow, outerGlow)
		end
		if backdrop then
			drawChamferImageEffect(x, y, w, h, cuts, transparentColor, nil, nil, backdrop)
		end

		if background and (background.a or 255) > 0 then
			drawChamferImageEffect(x, y, w, h, cuts, background)
		end

		local tl, tr, br, bl = chamferTuple(cuts, w, h)
		local mat = materials.chamfer_texture
		local r, g, b, a = color01(tint)
	mat:SetTexture("$basetexture", texture)
	setupParamMatrix(mat,
		r, g, b, a,
		w, h, 0, 0,
		u0, v0, u1, v1,
		tl, tr, br, bl
	)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	drawTexturedQuad(x, y, w, h, mat)

		if strokeVisible(stroke, strokeWidth) then
			drawChamferImageEffect(x, y, w, h, cuts, transparentColor, nil, nil, nil, stroke, strokeWidth)
		end

		return true
	end

	local function imageRoundedRadius(radiusInput, mask, maskKind, w, h)
		if maskKind == MASK_CIRCLE or maskKind == MASK_CAPSULE then
			return math_min(w, h) * 0.5
		elseif maskKind == MASK_ROUNDED and mask and mask.radius ~= nil then
			return imageRadius(mask.radius, w, h)
		end
		return imageRadius(radiusInput, w, h)
	end

	local function imageUsesSourceAlphaEffectMaskPrepared(maskInput, radiusInput, hasShadow, hasOuter, backdropSpec)
		if maskInput ~= nil then return false end
		if radiusInput ~= nil then return false end
		return hasShadow or hasOuter or backdropSpec ~= nil
	end

	local function drawRoundImageShadowOuterPrepared(
		x, y, w, h, radius,
		hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread,
		hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread
	)
		return drawPreparedRoundRectEffects(
			x, y, w, h, radius,
			transparentFill, nil, 0,
			hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread,
			hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread,
			false, 0, 0, 0, 0, 0, 0, 1,
			nil, nil
		)
	end

	local function drawImageImmediate(x, y, w, h, source, style)
		local totalProfile = profileStart()
		if not istable(style) then style = imageStyle(style) end
		if strokeKind(style.stroke) ~= STROKE_SOLID then
			error("patterned strokes are supported by MGFX shapes, not image masks", 2)
		end
		local shadow = style.shadow
		local outerGlow = style.outerGlow
		local backdropInput = style.backdrop
		local radiusInput = style.radius
		local maskInput = style.mask
		local tint = imageTint(style)
		local background = style.fill or style.background
		local _, stroke, strokeWidth = strokeRaw(style.stroke, style.strokeWidth, 0)
		local hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread = false, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0
		if shadow ~= nil and shadow ~= false then
			hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread = roundRaw.shadow(shadow)
		end
		local hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread = false, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0
		if outerGlow ~= nil and outerGlow ~= false then
			hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread = roundRaw.outerGlow(outerGlow)
		end
		local backdropSpec = nil
		if backdropInput ~= nil and backdropInput ~= false then
			backdropSpec = backdropStyle(backdropInput)
		end
	local shaderReady = shadersActive()
	local cullSpread = 0
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
	if not hasTransform() and isCulled(x - cullSpread, y - cullSpread, w + cullSpread * 2, h + cullSpread * 2) then
		profileEnd("image.immediate", totalProfile)
		return
	end

	local profile = profileStart()
	local texture = textureSource(source)
	profileEnd("image.textureSource", profile)
	if not texture then
		profileEnd("image.immediate", totalProfile)
		return
	end

	if not shaderReady or not matOK(materials.roundrect_texture) then
		profile = profileStart()
		drawImageFallback(x, y, w, h, source, style)
		profileEnd("image.fallback", profile)
		profileEnd("image.immediate", totalProfile)
		return
	end

	profile = profileStart()
	local u0, v0, u1, v1 = imageUV(style, texture)
	x, y, w, h, u0, v0, u1, v1 = imageFitRect(x, y, w, h, texture, style, u0, v0, u1, v1)
	profileEnd("image.layout", profile)
	if w <= 0 or h <= 0 then
		profileEnd("image.immediate", totalProfile)
		return
	end

	local mask
	local maskKind
		if imageUsesSourceAlphaEffectMaskPrepared(maskInput, radiusInput, hasShadow, hasOuter, backdropSpec) then
			mask = sourceAlphaMaskScratch
			mask.source = source
		mask.u0 = u0
		mask.v0 = v0
		mask.u1 = u1
		mask.v1 = v1
		maskKind = MASK_TEXTURE_A
		else
			mask = imageMaskStyle(maskInput, style)
			maskKind = maskKindValue(mask)
		end

	if maskKind == MASK_CIRCLE or (maskKind and maskKind >= MASK_TEXTURE_A) then
		profile = profileStart()
		local maskTexture
		local backdropMaskKind = maskKind
		if maskKind >= MASK_TEXTURE_A then
			maskTexture = maskTextureSource(mask)
			backdropMaskKind = maskTextureChannelKind(mask.channel) or maskKind
		end
		if hasShadow or hasOuter then
			drawImageMaskShadowOuter(
				x, y, w, h, mask, maskKind,
				hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowExtent, shadowGrow, shadowStrength, shadowFalloff,
				hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerExtent, outerGrow, outerStrength, outerFalloff
			)
		end
			drawImageMaskBackdrop(x, y, w, h, mask, backdropMaskKind, maskTexture, backdropSpec)
			if drawImageMaskShader(x, y, w, h, texture, u0, v0, u1, v1, tint, background, stroke, strokeWidth, mask, maskKind) then
				profileEnd("image.mask", profile)
				profileEnd("image.immediate", totalProfile)
			return
		end
		profileEnd("image.mask", profile)
	end

		local cuts = imageChamferCuts(style, mask)
		profile = profileStart()
		if cuts and drawImageChamfer(x, y, w, h, texture, u0, v0, u1, v1, tint, background, stroke, strokeWidth, hasShadow and shadow or nil, hasOuter and outerGlow or nil, backdropSpec and backdropInput or nil, cuts) then
			profileEnd("image.chamfer", profile)
			profileEnd("image.immediate", totalProfile)
		return
	end
	profileEnd("image.chamfer", profile)

		local radius = imageRoundedRadius(radiusInput, mask, maskKind, w, h)
		if hasShadow or hasOuter then
			profile = profileStart()
			drawRoundImageShadowOuterPrepared(
				x, y, w, h, radius,
				hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread,
				hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread
			)
			profileEnd("image.shadowOuter", profile)
		end

		if backdropSpec then
			profile = profileStart()
			drawPreparedRoundRectEffects(
				x, y, w, h, radius,
				transparentFill, nil, 0,
				false, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0,
				false, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0,
				false, 0, 0, 0, 0, 0, 0, 1,
				backdropSpec, nil
			)
			profileEnd("image.backdrop", profile)
		end

		if background and (background.a or 255) > 0 then
			profile = profileStart()
			drawPreparedRoundRectPlain(x, y, w, h, radius, fillFromStyle(background))
			profileEnd("image.background", profile)
		end

	profile = profileStart()
	local mat = materials.roundrect_texture
	mat:SetTexture("$basetexture", texture)
		stroke = stroke or transparentColor
		local packedStyle = math.Clamp(strokeWidth, 0, 255)
		local sr, sg, sb, sa = color01(stroke)
	setupParamMatrix(mat,
		0, 0, 0, 0,
		w, h, packedStyle, radius,
		u0, v0, u1, v1,
		sr, sg, sb, sa
	)
	setDrawColor(tint)
	surface_SetMaterial(mat)
	drawTexturedQuad(x, y, w, h, mat)
	profileEnd("image.base", profile)
	profileEnd("image.immediate", totalProfile)
end

local function drawImageRaw(x, y, w, h, source, radius, tint, fit)
	local texture = textureSource(source)
	if not texture then return end

	if not shadersActive() or not matOK(materials.roundrect_texture) then
		drawImageRawFallback(x, y, w, h, source, radius, tint, fit)
		return
	end

	local u0, v0, u1, v1 = 0, 0, 1, 1
	x, y, w, h, u0, v0, u1, v1 = imageFitRectRaw(x, y, w, h, texture, fit, u0, v0, u1, v1)
	if w <= 0 or h <= 0 then return end

	local mat = materials.roundrect_texture
	local resolvedRadius = imageRadius(radius, w, h)
	mat:SetTexture("$basetexture", texture)
	setupParamMatrix(mat,
		0, 0, 0, 0,
		w, h, 0, resolvedRadius,
		u0, v0, u1, v1,
		0, 0, 0, 0
	)
	setDrawColor(asColor(tint, color_white))
	surface_SetMaterial(mat)
	drawTexturedQuad(x, y, w, h, mat)
end

function M.ImageEx(x, y, w, h, source, style)
	style = resolveDrawStyle(style, M.TARGET.IMAGE)
	local transform
	transform, style = splitStyleTransform(style)

	recordDirectImmediate("DrawImage", "image")
	if not transform then
		return drawImageImmediate(x, y, w, h, source, style)
	end
	return withTransform(transform, x, y, w, h, function()
		return drawImageImmediate(x, y, w, h, source, style)
	end)
end

function M.Image(x, y, w, h, source, radius, tint)
	recordDirectImmediate("DrawImage", "image")
	return drawImageRaw(x, y, w, h, source, radius, tint)
end

function M.ImageUV(x, y, w, h, source, u0, v0, u1, v1, tint)
	recordDirectImmediate("DrawImage", "image")
	local texture, material = textureSource(source)
	local createdMaterialFallback = not material
	material = material or fallbackMaterialForTexture(texture)
	if not texture or not material or w <= 0 or h <= 0 then return end
	u0, v0, u1, v1 = u0 or 0, v0 or 0, u1 or 1, v1 or 1

	surface_SetMaterial(material)
	setDrawColor(asColor(tint, color_white))
	if hasTransform() then
		drawTexturedQuadUV(x, y, w, h, u0, v0, u1, v1, material)
	elseif createdMaterialFallback then
		drawCreatedMaterialTexturedRectUV(x, y, w, h, u0, v0, u1, v1)
		M.stats.draws = M.stats.draws + 1
	else
		drawTexturedQuadUV(x, y, w, h, u0, v0, u1, v1, material)
	end
end

function M.IconEx(x, y, w, h, source, style)
	local resolvedStyle = imageStyle(resolveDrawStyle(style, M.TARGET.IMAGE))
	local iconStyle = resolvedStyle
	if resolvedStyle.fit == nil and resolvedStyle.objectFit == nil then
		iconStyle = {}
		for key, value in pairs(resolvedStyle) do iconStyle[key] = value end
		iconStyle.fit = "contain"
	end
	local transform
	transform, iconStyle = splitStyleTransform(iconStyle)

	recordDirectImmediate("DrawImage", "image")
	if not transform then
		return drawImageImmediate(x, y, w, h, source, iconStyle)
	end
	return withTransform(transform, x, y, w, h, function()
		return drawImageImmediate(x, y, w, h, source, iconStyle)
	end)
end

function M.Icon(x, y, w, h, source, tint)
	recordDirectImmediate("DrawImage", "image")
	return drawImageRaw(x, y, w, h, source, nil, tint, "contain")
end


	C.drawImageImmediate = drawImageImmediate
end
