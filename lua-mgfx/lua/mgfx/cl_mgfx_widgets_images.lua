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
	local setupConstants = C.setupConstants
	local drawTexturedQuad = C.drawTexturedQuad
	local drawTexturedQuadUV = C.drawTexturedQuadUV
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

local function profileStart()
	if profiler and profiler.Start then return profiler.Start() end
	return nil
end

local function profileEnd(name, started)
	if profiler and profiler.End then profiler.End(name, started) end
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
	if not material then return end

	local u0, v0, u1, v1 = imageUV(style, texture)
	x, y, w, h, u0, v0, u1, v1 = imageFitRect(x, y, w, h, texture, style, u0, v0, u1, v1)
	if w <= 0 or h <= 0 then return end

	local radius = imageRadius(style.radius, w, h)
	local background = style.fill or style.background
	if background and (background.a or 255) > 0 then
		drawRoundRectImmediate(x, y, w, h, {
			radius = radius,
			fill = background,
		})
	end

	surface_SetMaterial(material)
	setDrawColor(imageTint(style))
	if hasTransform() then
		drawTexturedQuadUV(x, y, w, h, u0, v0, u1, v1)
	elseif createdMaterialFallback then
		drawCreatedMaterialTexturedRectUV(x, y, w, h, u0, v0, u1, v1)
		M.stats.draws = M.stats.draws + 1
	else
		surface_DrawTexturedRectUV(x, y, w, h, u0, v0, u1, v1)
		M.stats.draws = M.stats.draws + 1
	end

	local strokeWidth = strokeWidthValue(style.strokeWidth, 0)
	if style.stroke and strokeWidth > 0 then
		drawRoundRectImmediate(x, y, w, h, {
			radius = radius,
			fill = transparentColor,
			stroke = style.stroke,
			strokeWidth = math_max(1, math_floor(strokeWidth)),
		})
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

local function setupImageMaskConstants(mat, w, h, sourceU0, sourceV0, sourceU1, sourceV1, stroke, strokeWidth, mask, kind, maskTexture)
	local strokeColor = stroke or transparentColor
	local r, g, b, a = color01(strokeColor)
	local sr, sg, sb, sa = r, g, b, a

	local packedKind = kind
	if mask and (mask.invert or mask.inverse) then
		packedKind = packedKind + 128
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

local function drawImageMaskPass(x, y, w, h, texture, u0, v0, u1, v1, tint, stroke, strokeWidth, mask, kind, maskTexture)
	if not texture or not matOK(materials.image_mask) then return false end

	local mat = materials.image_mask
	mat:SetTexture("$basetexture", texture)
	if maskTexture then
		mat:SetTexture("$texture1", maskTexture)
	end

	setupImageMaskConstants(mat, w, h, u0, v0, u1, v1, stroke, strokeWidth, mask, kind, maskTexture)
	setDrawColor(tint or color_white)
	surface_SetMaterial(mat)
	drawTexturedQuad(x, y, w, h)
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

local function setupImageMaskBackdropConstants(mat, w, h, mask, kind, maskTexture, vertical, intensity)
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
		mat:SetTexture("$texture2", maskTexture)
	else
		p0, p1, p2, p3 = 0, 0, 0, 0
	end
	setupParamMatrix(mat,
		vertical and 1 or 0, intensity or 1, 0, 0,
		w, h, packedKind, mask and imageRadius(mask.radius, w, h) or 0,
		0, 0, 1, 1,
		p0, p1, p2, p3
	)
end

local function drawImageMaskBackdrop(x, y, w, h, mask, kind, maskTexture, backdrop)
	local spec = backdropStyle(backdrop)
	if not spec or not istable(mask) or not kind then return nil end
	if kind >= MASK_TEXTURE_A and not maskTexture then return nil end

	if spec.blur > 0 and matOK(materials.image_mask_backdrop) and drawBlurredCustomQuad then
		local mat = materials.image_mask_backdrop
		drawBlurredCustomQuad(mat, x, y, w, h, spec.blur, function(passMat, vertical, intensity)
			setupImageMaskBackdropConstants(passMat, w, h, mask, kind, maskTexture, vertical, intensity)
		end)
	end

	local tint = backdropTintColor(spec)
	if tint then
		local white = getWhiteTexture()
		if white then
			drawImageMaskPass(x, y, w, h, white, 0, 0, 1, 1, tint, nil, 0, mask, kind, maskTexture)
		end
	end

	return spec
end

local function drawImageMaskShader(x, y, w, h, texture, u0, v0, u1, v1, style, mask, kind)
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

	local background = style.fill or style.background
	if background and background.r and (background.a == nil or background.a > 0) then
		local white = getWhiteTexture()
		if white then
			drawImageMaskPass(x, y, w, h, white, 0, 0, 1, 1, background, nil, 0, mask, kind, maskTexture)
		end
	end

	return drawImageMaskPass(x, y, w, h, texture, u0, v0, u1, v1, imageTint(style), style.stroke, style.strokeWidth, mask, kind, maskTexture)
end

local function drawImageMaskOuterGlow(x, y, w, h, mask, kind, glow)
	local spec = glow
	if not spec or not istable(mask) or not matOK(materials.image_mask_outerglow) then return false end

	kind = kind or maskKindValue(mask)
	if not kind then return false end

	local maskTexture
	if kind >= MASK_TEXTURE_A then
		kind = maskTextureChannelKind(mask.channel)
		if not kind then return false end

		maskTexture = maskTextureSource(mask)
		if not maskTexture then return false end
	end

	local spread = math_max(1, tonumber(spec.spread) or tonumber(spec.width) or 18)
	local ox = tonumber(spec.x) or tonumber(spec.offsetX) or tonumber(spec.dx) or 0
	local oy = tonumber(spec.y) or tonumber(spec.offsetY) or tonumber(spec.dy) or 0
	local mat = materials.image_mask_outerglow
	local r, g, b, a = color01(spec.color or Color(76, 190, 255, 88))
	local gr, gg, gb, ga = r, g, b, a

	local packedKind = kind
	if mask.invert or mask.inverse then
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
		gr, gg, gb, ga,
		w, h, packedKind, mask and imageRadius(mask.radius, w, h) or 0,
		spread,
		math_max(0, tonumber(spec.strength) or tonumber(spec.opacity) or 1),
		math.Clamp(1 / math_max(tonumber(spec.falloff) or 1.8, 0.001), 0.1, 1),
		0,
		p0, p1, p2, p3
	)

	surface_SetDrawColor(255, 255, 255, 255)
	surface_SetMaterial(mat)
	drawTexturedQuad(x + ox - spread, y + oy - spread, w + spread * 2, h + spread * 2)
	return true
end

local function drawImageChamfer(x, y, w, h, texture, u0, v0, u1, v1, style, cuts)
	if not matOK(materials.chamfer_texture) then return false end

	if style.shadow then
		M.ChamferBoxEx(x, y, w, h, {
			cuts = cuts,
			fill = transparentColor,
			shadow = style.shadow,
		})
	end

	drawChamferOuterGlow(x, y, w, h, cuts, style.outerGlow)
	if style.backdrop then
		M.ChamferBoxEx(x, y, w, h, {
			cuts = cuts,
			backdrop = style.backdrop,
			fill = transparentColor,
		})
	end

	local background = style.fill or style.background
	if background and (background.a or 255) > 0 then
		M.ChamferBoxEx(x, y, w, h, {
			cuts = cuts,
			fill = background,
		})
	end

	local tl, tr, br, bl = chamferTuple(cuts, w, h)
	local mat = materials.chamfer_texture
	local r, g, b, a = color01(imageTint(style))
	mat:SetTexture("$basetexture", texture)
	setupParamMatrix(mat,
		r, g, b, a,
		w, h, 0, 0,
		u0, v0, u1, v1,
		tl, tr, br, bl
	)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	drawTexturedQuad(x, y, w, h)

	if style.pattern then
		drawChamferPattern(x, y, w, h, cuts, style.pattern)
	end

	if strokeVisible(style.stroke, style.strokeWidth) then
		M.ChamferBoxEx(x, y, w, h, {
			cuts = cuts,
			fill = transparentColor,
			stroke = style.stroke,
			strokeWidth = style.strokeWidth,
		})
	end

	return true
end

local function drawImageImmediate(x, y, w, h, source, style)
	local totalProfile = profileStart()
	if not istable(style) then style = imageStyle(style) end
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

	local mask = imageMaskStyle(style.mask, style)
	local maskKind = maskKindValue(mask)
	local backdrop = backdropStyle(style.backdrop)
	if backdrop and not mask then
		mask = {kind = "texture", source = source, channel = "alpha"}
		maskKind = MASK_TEXTURE_A
	end
	if maskKind == MASK_TEXTURE_A or maskKind == MASK_TEXTURE_R or maskKind == MASK_TEXTURE_G or maskKind == MASK_TEXTURE_B or maskKind == MASK_TEXTURE_LUMA then
		profile = profileStart()
		local maskTexture = maskTextureSource(mask)
		local backdropMaskKind = maskTextureChannelKind(mask.channel) or maskKind
		drawImageMaskOuterGlow(x, y, w, h, mask, maskKind, shadowSpec)
		drawImageMaskOuterGlow(x, y, w, h, mask, maskKind, outerSpec)
		drawImageMaskBackdrop(x, y, w, h, mask, backdropMaskKind, maskTexture, style.backdrop)
		if drawImageMaskShader(x, y, w, h, texture, u0, v0, u1, v1, style, mask, maskKind) then
			profileEnd("image.mask", profile)
			profileEnd("image.immediate", totalProfile)
			return
		end
		profileEnd("image.mask", profile)
	end

	local cuts = imageChamferCuts(style, mask)
	profile = profileStart()
	if cuts and drawImageChamfer(x, y, w, h, texture, u0, v0, u1, v1, style, cuts) then
		profileEnd("image.chamfer", profile)
		profileEnd("image.immediate", totalProfile)
		return
	end
	profileEnd("image.chamfer", profile)

	local radius
	if maskKind == MASK_CIRCLE then
		radius = math_min(w, h) * 0.5
	elseif maskKind == MASK_CAPSULE then
		radius = math_min(w, h) * 0.5
	elseif maskKind == MASK_ROUNDED and mask and mask.radius ~= nil then
		radius = imageRadius(mask.radius, w, h)
	else
		radius = imageRadius(style.radius, w, h)
	end
	if style.shadow then
		profile = profileStart()
		drawRoundRectImmediate(x, y, w, h, {
			radius = radius,
			fill = transparentColor,
			shadow = style.shadow,
		})
		profileEnd("image.shadow", profile)
	end

	profile = profileStart()
	drawRoundRectOuterGlow(x, y, w, h, radius, outerSpec)
	profileEnd("image.outerGlow", profile)

	if style.backdrop then
		profile = profileStart()
		drawRoundRectImmediate(x, y, w, h, {
			radius = radius,
			backdrop = style.backdrop,
			fill = transparentColor,
		})
		profileEnd("image.backdrop", profile)
	end

	local background = style.fill or style.background
	if background and (background.a or 255) > 0 then
		profile = profileStart()
		drawRoundRectImmediate(x, y, w, h, {
			radius = radius,
			fill = background,
		})
		profileEnd("image.background", profile)
	end

	profile = profileStart()
	local mat = materials.roundrect_texture
	mat:SetTexture("$basetexture", texture)
	local tint = imageTint(style)
	local stroke = style.stroke or transparentColor
	local strokeWidth = strokeWidthValue(style.strokeWidth, 0)
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
	drawTexturedQuad(x, y, w, h)
	profileEnd("image.base", profile)
	profileEnd("image.immediate", totalProfile)
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

local imageArgStyle = {}

function M.Image(x, y, w, h, source, radius, tint)
	imageArgStyle.radius = radius
	imageArgStyle.tint = tint
	imageArgStyle.alpha = nil
	imageArgStyle.fit = nil
	imageArgStyle.objectFit = nil
	imageArgStyle.uv = nil
	imageArgStyle.stroke = nil
	imageArgStyle.strokeWidth = nil
	imageArgStyle.fill = nil
	imageArgStyle.background = nil
	imageArgStyle.mask = nil
	imageArgStyle.outerGlow = nil
	recordDirectImmediate("DrawImage", "image")
	return drawImageImmediate(x, y, w, h, source, imageArgStyle)
end

function M.IconEx(x, y, w, h, source, style)
	local iconStyle = table.Copy(imageStyle(resolveDrawStyle(style, M.TARGET.IMAGE)))
	local transform
	transform, iconStyle = splitStyleTransform(iconStyle)
	if iconStyle.fit == nil and iconStyle.objectFit == nil then
		iconStyle.fit = "contain"
	end

	recordDirectImmediate("DrawImage", "image")
	if not transform then
		return drawImageImmediate(x, y, w, h, source, iconStyle)
	end
	return withTransform(transform, x, y, w, h, function()
		return drawImageImmediate(x, y, w, h, source, iconStyle)
	end)
end

local iconArgStyle = {}

function M.Icon(x, y, w, h, source, tint)
	iconArgStyle.tint = tint
	iconArgStyle.fit = "contain"
	iconArgStyle.radius = nil
	iconArgStyle.alpha = nil
	iconArgStyle.objectFit = nil
	iconArgStyle.uv = nil
	iconArgStyle.stroke = nil
	iconArgStyle.strokeWidth = nil
	iconArgStyle.fill = nil
	iconArgStyle.background = nil
	iconArgStyle.mask = nil
	iconArgStyle.outerGlow = nil
	recordDirectImmediate("DrawImage", "image")
	return drawImageImmediate(x, y, w, h, source, iconArgStyle)
end


	C.drawImageImmediate = drawImageImmediate
end
