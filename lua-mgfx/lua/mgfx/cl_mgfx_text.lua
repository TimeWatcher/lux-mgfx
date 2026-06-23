if SERVER then return end

MGFX = MGFX or {}

local M = MGFX

function M._CreateTextRenderer(deps)
	deps = deps or {}

	local owner = deps.M or M
	local stats = deps.stats or owner.stats or {}
	local materials = deps.materials or {}
	local createPageTextMaterials = deps.createPageTextMaterials
	local matOK = deps.matOK or function(mat) return mat and not mat:IsError() end
	local profiler = deps.profiler
	local getFrameOffset = deps.getFrameOffset or function() return 0, 0 end
	local restoreScissor = deps.restoreScissor or function() end
	local gradientLutForFill = deps.gradientLutForFill or function() return nil end
	local asColor = deps.asColor or function(value, fallback)
		if istable(value) and value.r and value.g and value.b then return value end
		return fallback or color_white
	end
	local color01 = deps.color01 or function(color)
		color = asColor(color, color_white)
		return math.Clamp((color.r or 0) / 255, 0, 1),
			math.Clamp((color.g or 0) / 255, 0, 1),
			math.Clamp((color.b or 0) / 255, 0, 1),
			math.Clamp((color.a == nil and 255 or color.a) / 255, 0, 1)
	end
	local glowSoftnessToFalloff = deps.glowSoftnessToFalloff or function(softness, defaultSoftness)
		softness = math.Clamp(tonumber(softness) or defaultSoftness or 0.55, 0, 1)
		return math.Clamp(3.25 - softness * 2.5, 0.75, 3.25)
	end

	local math_abs = math.abs
	local math_ceil = math.ceil
	local math_floor = math.floor
	local math_max = math.max
	local math_min = math.min
	local math_sin = math.sin
	local math_cos = math.cos
	local render_Clear = render.Clear
	local render_OverrideBlend = render.OverrideBlend
	local render_OverrideAlphaWriteEnable = render.OverrideAlphaWriteEnable
	local render_PopRenderTarget = render.PopRenderTarget
	local render_PushRenderTarget = render.PushRenderTarget
	local render_SetScissorRect = render.SetScissorRect
	local render_SetColorModulation = render.SetColorModulation
	local render_GetColorModulation = render.GetColorModulation
	local render_SetBlend = render.SetBlend
	local render_GetBlend = render.GetBlend
	local surface_SetAlphaMultiplier = surface.SetAlphaMultiplier
	local surface_GetAlphaMultiplier = surface.GetAlphaMultiplier
	local cam_Start2D = cam.Start2D
	local cam_End2D = cam.End2D
	local surface_CreateFont = surface.CreateFont
	local surface_DrawPoly = surface.DrawPoly
	local surface_DrawRect = surface.DrawRect
	local surface_DrawText = surface.DrawText
	local surface_GetTextSize = surface.GetTextSize
	local surface_SetDrawColor = surface.SetDrawColor
	local surface_SetFont = surface.SetFont
	local surface_SetMaterial = surface.SetMaterial
	local surface_SetTextColor = surface.SetTextColor
	local surface_SetTextPos = surface.SetTextPos

	local renderer = {}
	local measureCache = {}
	local measureOrder = {}
	local measureOrderHead = 1
	local measureOrderTail = 0
	local measureOrderCount = 0
	local namedStyles = {}
	local styleStack = {}
	local fontAliases = {}
	local nativeFonts = {}
	local atlas
	local atlasPages = {}
	local atlasMat
	local atlasEpoch = 1
	local cache = {}
	local cacheCount = 0
	local tick = 0
	local bakesThisFrame = 0
	local failed = false
	local needsReset = false
	local composedCvar
	local budgetCvar

	local ATLAS_W = 2048
	local ATLAS_H = 1024
	local MAX_ATLAS_PAGES = 16
	-- Once allocation spills past this many pages the atlas is "nearly full". We
	-- flag a reset for the next flush boundary (never mid-flush) and the remaining
	-- pages are headroom so the current flush can still finish without overflowing.
	local SOFT_ATLAS_PAGES = MAX_ATLAS_PAGES - 2
	local PAD = 4
	local CACHE_VERSION = 20
	local MEASURE_LIMIT = 4096
	local DEFAULT_BUDGET = 6
	local DEFAULT_CJK_FACE = "Noto Sans SC"
	local RESOLVED_STYLE_MARK = "__mgfxTextResolved"
	local white = Color(255, 255, 255, 255)

	local function compactOrder(order, head, tail, count)
		if head <= 128 then return head, tail end

		local write = 1
		for read = head, tail do
			order[write] = order[read]
			if write ~= read then order[read] = nil end
			write = write + 1
		end

		for i = write, tail do
			order[i] = nil
		end

		return 1, count
	end

	local function profileStart()
		if profiler and profiler.Start then
			local started = profiler.Start()
			if started then return started end
		end
		if stats.textProfileActive then return SysTime() end
		return nil
	end

	local function profileEnd(name, started, count)
		if not started then return end
		local elapsed = (SysTime() - started) * 1000
		if profiler and profiler.Record then profiler.Record(name, elapsed, count) end
		if stats.textProfileActive then
			local times = stats.textProfileTimes
			local counts = stats.textProfileCounts
			if not times then
				times = {}
				stats.textProfileTimes = times
			end
			if not counts then
				counts = {}
				stats.textProfileCounts = counts
			end
			times[name] = (times[name] or 0) + elapsed
			counts[name] = (counts[name] or 0) + (count or 1)
		end
	end

	local canCompose = render_Clear ~= nil
		and render_PushRenderTarget ~= nil
		and render_PopRenderTarget ~= nil
		and cam_Start2D ~= nil
		and cam_End2D ~= nil

	local quad = {
		{x = 0, y = 0, u = 0, v = 0},
		{x = 0, y = 0, u = 1, v = 0},
		{x = 0, y = 0, u = 1, v = 1},
		{x = 0, y = 0, u = 0, v = 1},
	}

	local function initStats()
		stats.textDraws = stats.textDraws or 0
		stats.textNativeDraws = stats.textNativeDraws or 0
		stats.textShaderDraws = stats.textShaderDraws or 0
		stats.textComposedBakes = stats.textComposedBakes or 0
		stats.textComposedBlits = stats.textComposedBlits or 0
		stats.textComposedDraws = stats.textComposedDraws or 0
		stats.textComposedBatchDraws = stats.textComposedBatchDraws or 0
		stats.textComposedBatchedRecords = stats.textComposedBatchedRecords or 0
		stats.textComposedFaceDraws = stats.textComposedFaceDraws or 0
		stats.textComposedFxDraws = stats.textComposedFxDraws or 0
		stats.textComposedRequests = stats.textComposedRequests or 0
		stats.textComposedBatches = stats.textComposedBatches or 0
		stats.textComposedReadyBatches = stats.textComposedReadyBatches or 0
		stats.textComposedFallbackBatches = stats.textComposedFallbackBatches or 0
		stats.textComposedFallbackRecords = stats.textComposedFallbackRecords or 0
		stats.textComposedPrewarmFails = stats.textComposedPrewarmFails or 0
		stats.textComposedPrewarmRestarts = stats.textComposedPrewarmRestarts or 0
		stats.textComposedEntries = stats.textComposedEntries or 0
		stats.textComposedEvicts = stats.textComposedEvicts or 0
		stats.textMeasureHits = stats.textMeasureHits or 0
		stats.textMeasureMisses = stats.textMeasureMisses or 0
		stats.textCacheSize = stats.textCacheSize or 0
		stats.textFallbacks = stats.textFallbacks or 0
		stats.textDataDraws = 0
		stats.textDataBatches = 0
		stats.textAtlasUploads = 0
		stats.textAtlasGlyphs = 0
		stats.textAtlasResets = 0
		stats.textEntryCacheHits = stats.textEntryCacheHits or 0
		stats.textEntryCacheMisses = stats.textEntryCacheMisses or 0
		stats.textProfileActive = stats.textProfileActive or false
		stats.textProfileTimes = stats.textProfileTimes or {}
		stats.textProfileCounts = stats.textProfileCounts or {}
	end

	initStats()

	function renderer.SetProfileActive(active)
		stats.textProfileActive = active and true or false
	end

	function renderer.ResetProfile()
		table.Empty(stats.textProfileTimes)
		table.Empty(stats.textProfileCounts)
	end

	function renderer.ProfileSnapshot(reset)
		local times = {}
		local counts = {}
		for name, value in pairs(stats.textProfileTimes or {}) do
			times[name] = value
		end
		for name, value in pairs(stats.textProfileCounts or {}) do
			counts[name] = value
		end
		if reset then renderer.ResetProfile() end
		return times, counts
	end

	function renderer.ResetFrameStats()
		stats.textDraws = 0
		stats.textNativeDraws = 0
		stats.textShaderDraws = 0
		stats.textComposedBakes = 0
		stats.textComposedBlits = 0
		stats.textComposedDraws = 0
		stats.textComposedBatchDraws = 0
		stats.textComposedBatchedRecords = 0
		stats.textComposedFaceDraws = 0
		stats.textComposedFxDraws = 0
		stats.textComposedRequests = 0
		stats.textComposedBatches = 0
		stats.textComposedReadyBatches = 0
		stats.textComposedFallbackBatches = 0
		stats.textComposedFallbackRecords = 0
		stats.textComposedPrewarmFails = 0
		stats.textComposedPrewarmRestarts = 0
		stats.textComposedEntries = cacheCount
		stats.textComposedEvicts = 0
		stats.textMeasureHits = 0
		stats.textMeasureMisses = 0
		stats.textCacheSize = measureOrderCount
		stats.textFallbacks = 0
		stats.textDataDraws = 0
		stats.textDataBatches = 0
		stats.textAtlasUploads = 0
		stats.textAtlasGlyphs = 0
		stats.textAtlasResets = 0
		stats.textEntryCacheHits = 0
		stats.textEntryCacheMisses = 0
		bakesThisFrame = 0
	end

	local function textChars(text)
		local chars = {}
		for ch in string.gmatch(tostring(text or ""), "[%z\1-\127\194-\244][\128-\191]*") do
			chars[#chars + 1] = ch
		end
		return chars
	end

	local function copyValue(value)
		if istable(value) and value.r ~= nil and value.g ~= nil and value.b ~= nil then return value end
		if istable(value) then return table.Copy(value) end
		return value
	end

	local function copyStyleInto(dst, src)
		if not istable(src) then return dst end
		for k, v in pairs(src) do
			if k ~= "extends" and k ~= "base" and not (isstring(k) and string.sub(k, 1, 6) == "__mgfx") then
				dst[k] = copyValue(v)
			end
		end
		return dst
	end

	local function appendStyle(dst, style, depth)
		if not style then return dst end
		depth = (depth or 0) + 1
		if depth > 8 then return dst end
		if isstring(style) then return appendStyle(dst, namedStyles[style], depth) end
		if not istable(style) then return dst end

		local base = style.extends or style.base
		if istable(base) and base[1] and not base.r then
			for _, item in ipairs(base) do appendStyle(dst, item, depth) end
		else
			appendStyle(dst, base, depth)
		end

		return copyStyleInto(dst, style)
	end

	function renderer.ResolveStyle(style)
		if istable(style) and style[RESOLVED_STYLE_MARK] == true then return style end
		local resolved = {}
		for _, item in ipairs(styleStack) do appendStyle(resolved, item) end
		appendStyle(resolved, style)
		resolved[RESOLVED_STYLE_MARK] = true
		return resolved
	end

	function renderer.DefineStyle(name, style)
		if not name then return nil end
		local key = tostring(name)
		namedStyles[key] = renderer.ResolveStyle(style or {})
		return table.Copy(namedStyles[key])
	end

	function renderer.GetStyle(name)
		local style = namedStyles[tostring(name or "")]
		return style and table.Copy(style) or nil
	end

	function renderer.PushStyle(style)
		styleStack[#styleStack + 1] = renderer.ResolveStyle(style or {})
		return #styleStack
	end

	function renderer.PopStyle()
		if #styleStack == 0 then return false end
		styleStack[#styleStack] = nil
		return true
	end

	function renderer.SetBatchBackend() end

	local function colorKey(color)
		color = asColor(color, white)
		return table.concat({color.r or 0, color.g or 0, color.b or 0, color.a == nil and 255 or color.a}, ",")
	end

	local function normalizeShadow(value)
		if value == nil or value == false then return nil end
		if value == true then value = {} end
		if not istable(value) then value = {blur = tonumber(value) or 0} end
		return {
			x = tonumber(value.x or value.offsetX or value[1]) or 1,
			y = tonumber(value.y or value.offsetY or value[2]) or 1,
			blur = math_max(0, tonumber(value.blur or value.radius or value[3]) or 0),
			strength = tonumber(value.strength or value.opacity) or 1,
			color = asColor(value.color or value.tint, Color(0, 0, 0, 180)),
		}
	end

	local function normalizeStroke(value)
		if value == nil or value == false then return nil end
		if value == true then value = {} end
		if not istable(value) then value = {width = tonumber(value) or 1} end
		local width = math_max(0, tonumber(value.width or value.size or value[1]) or 1)
		if width <= 0 then return nil end
		return {
			width = width,
			samples = math.Clamp(math_ceil(width * 6), 8, 32),
			softness = tonumber(value.softness) or 0,
			color = asColor(value.color or value.tint, Color(0, 0, 0, 220)),
		}
	end

	local function normalizeGlow(value)
		if value == nil or value == false then return nil end
		if value == true then value = {} end
		if not istable(value) then value = {width = tonumber(value) or 6} end
		local width = math_max(0, tonumber(value.width or value.size or value.radius or value[1]) or 6)
		if width <= 0 then return nil end
		return {
			width = width,
			samples = math.Clamp(math_ceil(width * 2), 8, 36),
			strength = tonumber(value.strength or value.opacity) or 0.45,
			falloff = tonumber(value.falloff) or glowSoftnessToFalloff(value.softness, 0.58),
			color = asColor(value.color or value.tint, Color(255, 255, 255, 120)),
		}
	end

	local function normalizeSurface(value)
		if not value then return nil end
		if value == true then return {strength = 0.18} end
		if isnumber(value) then value = {strength = value} end
		if not istable(value) then return nil end
		local strength = math.Clamp(tonumber(value.strength or value[1]) or 0.18, 0, 1)
		if strength <= 0 then return nil end
		return {
			strength = strength,
		}
	end

	local function normalizeWeightAdjust(style)
		style = style or {}
		if tonumber(style.weightAdjust) then
			return math.Clamp(tonumber(style.weightAdjust), -2, 2)
		end
		if style.bold then return 0.55 end
		if style.thin then return -0.38 end
		return 0
	end

	local function fontKey(face, size, weight, italic)
		return table.concat({face, size, weight, italic and 1 or 0}, ":")
	end

	local function normalizeFontWeight(value, fallback)
		local weight = tonumber(value)
		if not weight then return fallback or 500 end
		if weight > 0 and weight <= 10 then
			return weight <= 1 and 850 or weight * 100
		end
		return weight
	end

	local function normalizeOversample(value)
		return math.Clamp(tonumber(value) or 1, 1, 3)
	end

	local function oversampleForSize(size)
		size = tonumber(size) or 16
		if size >= 28 then return 3 end
		return 2
	end

	local function ensureNativeFont(face, size, weight, italic)
		face = tostring(face or DEFAULT_CJK_FACE)
		size = math_max(1, math_floor(tonumber(size) or 16))
		local fallbackWeight = face == DEFAULT_CJK_FACE and 400 or 500
		weight = math.Clamp(math_floor(normalizeFontWeight(weight, fallbackWeight)), 100, 1200)
		italic = italic == true
		local key = fontKey(face, size, weight, italic)
		local name = nativeFonts[key]
		if name then return name end
		name = "MGFXTextNative_" .. util.CRC(key)
		surface_CreateFont(name, {
			font = face,
			size = size,
			weight = weight,
			antialias = true,
			extended = true,
			italic = italic,
		})
		nativeFonts[key] = name
		return name
	end

	function renderer.RegisterFont(fontName, spec)
		if not fontName then return false end
		spec = spec or {}

		local name = tostring(fontName)
		local face = spec.face or spec.font
		local size = tonumber(spec.size)
		local weight = tonumber(spec.weight)
		local sourceFont = spec.sourceFont or spec.nativeFont
		local oversample = 1

		if face then
			size = size or 16
			oversample = oversampleForSize(size)
			weight = normalizeFontWeight(weight, face == DEFAULT_CJK_FACE and 400 or 500)
			sourceFont = ensureNativeFont(face, size * oversample, weight, spec.italic == true)
		else
			sourceFont = sourceFont or name
		end

		fontAliases[name] = {
			mode = "alias",
			sourceFont = sourceFont,
			face = face,
			size = size,
			weight = weight,
			oversample = oversample,
			syntheticWeight = spec.syntheticWeight == true or spec.allowSyntheticWeight == true,
			lineHeight = tonumber(spec.lineHeight or spec.lineheight),
			tracking = tonumber(spec.tracking or spec.letterSpacing) or 0,
			atlas = "__composed",
		}
		return true
	end

	local function aliasFor(font)
		return fontAliases[tostring(font or "")] or {
			mode = "native",
			sourceFont = font or "DermaDefault",
			oversample = 1,
			tracking = 0,
			atlas = "__native",
		}
	end

	local function nativeFor(font, style, noOversample, plainFace)
		local alias = aliasFor(font)
		local oversample = (noOversample or (style and style.__mgfxNoOversample)) and 1 or normalizeOversample(alias.oversample)
		if alias.face then
			local weight = alias.weight or 500
			if style and style.syntheticNativeWeight == true then
				if not plainFace and style and style.bold then weight = weight + 220 end
				if not plainFace and style and style.thin then weight = math_min(weight, 350) end
				if style and tonumber(style.weight) then weight = normalizeFontWeight(style.weight, weight) end
			end
			return ensureNativeFont(alias.face, (alias.size or 16) * oversample, weight, style and style.italic and true or false), alias, oversample
		end
		return alias.sourceFont or font or "DermaDefault", alias, 1
	end

	local function setFontSafe(font)
		font = font or "DermaDefault"
		if pcall(surface_SetFont, font) then return font end
		surface_SetFont("DermaDefault")
		return "DermaDefault"
	end

	local function lineHeightFor(nativeFont, alias, style, oversample)
		if style and tonumber(style.lineHeight) then return tonumber(style.lineHeight) end
		if alias and alias.lineHeight then return alias.lineHeight end
		setFontSafe(nativeFont)
		local _, h = surface_GetTextSize("Hg")
		return math_max(1, (h or 16) / normalizeOversample(oversample))
	end

	local function measureLine(nativeFont, text, tracking, oversample)
		oversample = normalizeOversample(oversample)
		setFontSafe(nativeFont)
		local w, h = surface_GetTextSize(tostring(text or ""))
		w = (w or 0) / oversample
		h = (h or 0) / oversample
		if tracking and tracking ~= 0 then
			local count = #textChars(text)
			if count > 1 then w = w + tracking * (count - 1) end
		end
		return math_max(0, w), math_max(0, h)
	end

	local function cacheMeasure(key, value)
		if measureCache[key] == nil then
			measureOrderTail = measureOrderTail + 1
			measureOrder[measureOrderTail] = key
			measureOrderCount = measureOrderCount + 1
			if measureOrderCount > MEASURE_LIMIT then
				local old = measureOrder[measureOrderHead]
				measureOrder[measureOrderHead] = nil
				measureOrderHead = measureOrderHead + 1
				measureOrderCount = measureOrderCount - 1
				measureCache[old] = nil
			end
			measureOrderHead, measureOrderTail = compactOrder(measureOrder, measureOrderHead, measureOrderTail, measureOrderCount)
		end
		measureCache[key] = value
		stats.textCacheSize = measureOrderCount
	end

	function renderer.MeasureText(text, font)
		local nativeFont, alias, oversample = nativeFor(font)
		local tracking = alias.tracking or 0
		local key = table.concat({tostring(font or ""), nativeFont, tostring(tracking), tostring(oversample), tostring(text or "")}, "\31")
		local cached = measureCache[key]
		if cached then
			stats.textMeasureHits = stats.textMeasureHits + 1
			return cached.w, cached.h
		end

		stats.textMeasureMisses = stats.textMeasureMisses + 1
		local maxW = 0
		local lines = string.Explode("\n", tostring(text or ""), false)
		local lineHeight = lineHeightFor(nativeFont, alias, nil, oversample)
		for _, line in ipairs(lines) do
			local w = measureLine(nativeFont, line, tracking, oversample)
			maxW = math_max(maxW, w)
		end
		local h = math_max(lineHeight, #lines * lineHeight)
		local out = {w = maxW, h = h}
		cacheMeasure(key, out)
		return maxW, h
	end

	local function layoutFor(text, font, style, noOversample, plainFace)
		local profile = profileStart()
		style = style or {}
		local nativeFont, alias, oversample = nativeFor(font, style, noOversample, plainFace)
		local tracking = tonumber(style.tracking or style.letterSpacing) or alias.tracking or 0
		local lineHeight = lineHeightFor(nativeFont, alias, style, oversample)
		local lines = string.Explode("\n", tostring(text or ""), false)
		local maxW = 0
		for i, line in ipairs(lines) do
			local w = measureLine(nativeFont, line, tracking, oversample)
			lines[i] = {text = line, w = w, y = (i - 1) * lineHeight}
			maxW = math_max(maxW, w)
		end
		local layout = {
			font = nativeFont,
			alias = alias,
			lines = lines,
			w = maxW,
			h = math_max(lineHeight, #lines * lineHeight),
			lineHeight = lineHeight,
			tracking = tracking,
			oversample = oversample,
		}
		profileEnd("text.layoutFor", profile)
		return layout
	end

	local function alignFactor(value, vertical)
		if value == TEXT_ALIGN_CENTER or value == "center" or value == "middle" then return 0.5 end
		if value == TEXT_ALIGN_RIGHT or value == TEXT_ALIGN_BOTTOM or value == "right" or value == "bottom" then return 1 end
		if vertical and (value == TEXT_ALIGN_CENTER or value == "center") then return 0.5 end
		return 0
	end

	local function colorAtFill(fill, t)
		if not istable(fill) then return asColor(fill, white) end
		if fill.r ~= nil and fill.g ~= nil and fill.b ~= nil then return fill end
		local stops = fill.stops
		if istable(stops) and #stops > 0 then
			local prev = stops[1]
			for i = 2, #stops do
				local nextStop = stops[i]
				local ap = tonumber(prev.pos or prev[1]) or 0
				local bp = tonumber(nextStop.pos or nextStop[1]) or 1
				if t <= bp then
					local f = bp > ap and math.Clamp((t - ap) / (bp - ap), 0, 1) or 0
					local ac = asColor(prev.color or prev[2], white)
					local bc = asColor(nextStop.color or nextStop[2], ac)
					return Color(
						ac.r + (bc.r - ac.r) * f,
						ac.g + (bc.g - ac.g) * f,
						ac.b + (bc.b - ac.b) * f,
						(ac.a == nil and 255 or ac.a) + ((bc.a == nil and 255 or bc.a) - (ac.a == nil and 255 or ac.a)) * f
					)
				end
				prev = nextStop
			end
			return asColor(prev.color or prev[2], white)
		end
		local a = asColor(fill.colorA or fill[1], white)
		local b = asColor(fill.colorB or fill[2], a)
		return Color(
			a.r + (b.r - a.r) * t,
			a.g + (b.g - a.g) * t,
			a.b + (b.b - a.b) * t,
			(a.a == nil and 255 or a.a) + ((b.a == nil and 255 or b.a) - (a.a == nil and 255 or a.a)) * t
		)
	end

	local function setTextColor(color)
		color = asColor(color, white)
		surface_SetTextColor(color.r or 255, color.g or 255, color.b or 255, color.a == nil and 255 or color.a)
	end

	local function drawLayout(layout, x, y, fill, fallbackColor)
		setFontSafe(layout.font)
		local oversample = normalizeOversample(layout.oversample)
		for _, line in ipairs(layout.lines) do
			local lx = x
			local ly = y + line.y * oversample
			if layout.tracking == 0 and not (istable(fill) and fill.kind) then
				setTextColor(fallbackColor or fill or white)
				surface_SetTextPos(lx, ly)
				surface_DrawText(line.text)
			else
				local chars = textChars(line.text)
				local advance = 0
				for i, ch in ipairs(chars) do
					local t = line.w > 0 and advance / line.w or 0
					setTextColor(istable(fill) and colorAtFill(fill, t) or (fallbackColor or fill or white))
					surface_SetTextPos(lx, ly)
					surface_DrawText(ch)
					local cw = surface_GetTextSize(ch)
					cw = cw or 0
					lx = lx + cw + layout.tracking * oversample
					advance = advance + cw / oversample + layout.tracking
				end
			end
		end
	end

	local function drawUV(mat, x, y, w, h, u0, v0, u1, v1, color)
		quad[1].x, quad[1].y, quad[1].u, quad[1].v = x, y, u0, v0
		quad[2].x, quad[2].y, quad[2].u, quad[2].v = x + w, y, u1, v0
		quad[3].x, quad[3].y, quad[3].u, quad[3].v = x + w, y + h, u1, v1
		quad[4].x, quad[4].y, quad[4].u, quad[4].v = x, y + h, u0, v1
		surface_SetMaterial(mat)
		color = asColor(color, white)
		surface_SetDrawColor(color.r or 255, color.g or 255, color.b or 255, color.a == nil and 255 or color.a)
		surface_DrawPoly(quad)
	end

	local function snapTextPos(x, y, style)
		style = style or {}
		if style.pixelSnap == false or style.snap == false then return x, y end
		return math_floor(x + 0.5), math_floor(y + 0.5)
	end

	local function enabled()
		if not canCompose or failed then return false end
		if composedCvar == nil then composedCvar = GetConVar("mgfx_text_composed") or false end
		if composedCvar == false then return true end
		return composedCvar:GetBool()
	end

	local function budget()
		if budgetCvar == nil then budgetCvar = GetConVar("mgfx_text_composed_budget") or false end
		if budgetCvar == false then return DEFAULT_BUDGET end
		return math_max(0, budgetCvar:GetInt())
	end

	local function clearRenderTargetAlpha(rt, w, h)
		render_PushRenderTarget(rt, 0, 0, w or ATLAS_W, h or ATLAS_H)
		render_SetScissorRect(0, 0, 0, 0, false)
		if render_OverrideAlphaWriteEnable then render_OverrideAlphaWriteEnable(true, true) end
		render_Clear(0, 0, 0, 0, true, true)
		if render_OverrideAlphaWriteEnable then render_OverrideAlphaWriteEnable(false) end
		render_PopRenderTarget()
		restoreScissor()
	end

	-- Bakes render glyphs into the atlas RT from inside the host's VGUI Paint /
	-- HUDPaint pass, so the surface library's AMBIENT modulation is still live:
	-- the panel's alpha multiplier (e.g. a scoreboard AlphaTo fade-in), a render
	-- color modulation, or a render blend factor. surface.DrawText honours the
	-- alpha multiplier, so a glyph that first bakes during a fade is written into
	-- the atlas FAINT, and one that bakes on an alpha-0 frame is written BLANK --
	-- then cached forever (the half-drawn / missing digits seen in the atlas dump).
	-- We force neutral modulation for the bake so the atlas always stores the glyph
	-- at full opacity; the on-screen fade is re-applied later at blit time.
	local function beginAtlasDraw()
		local am = surface_GetAlphaMultiplier and surface_GetAlphaMultiplier() or 1
		local cr, cg, cb
		if render_GetColorModulation then cr, cg, cb = render_GetColorModulation() end
		local blend = render_GetBlend and render_GetBlend() or nil
		if surface_SetAlphaMultiplier then surface_SetAlphaMultiplier(1) end
		if render_SetColorModulation then render_SetColorModulation(1, 1, 1) end
		if render_SetBlend then render_SetBlend(1) end
		return am, cr, cg, cb, blend
	end

	local function endAtlasDraw(am, cr, cg, cb, blend)
		if surface_SetAlphaMultiplier then surface_SetAlphaMultiplier(am or 1) end
		if render_SetColorModulation and cr ~= nil then render_SetColorModulation(cr, cg, cb) end
		if render_SetBlend and blend ~= nil then render_SetBlend(blend) end
	end

	local function clearAtlasSlot(x, y, w, h)
		if not surface_DrawRect then return end

		x = math_floor(math_max(0, x))
		y = math_floor(math_max(0, y))
		w = math_ceil(math_min(ATLAS_W - x, w))
		h = math_ceil(math_min(ATLAS_H - y, h))
		if w <= 0 or h <= 0 then return end

		-- Save current render state to restore after clear
		local prevR, prevG, prevB
		if render_GetColorModulation then
			prevR, prevG, prevB = render_GetColorModulation()
		end
		local prevBlend = render_GetBlend and render_GetBlend() or nil
		local prevAlphaMult = surface_GetAlphaMultiplier and surface_GetAlphaMultiplier() or 1

		-- Force render state for a proper clear: full alpha write, replace blend, no modulation
		if surface_SetAlphaMultiplier then surface_SetAlphaMultiplier(1) end
		if render_SetColorModulation then render_SetColorModulation(1, 1, 1) end
		if render_SetBlend then render_SetBlend(1) end
		if render_OverrideAlphaWriteEnable then render_OverrideAlphaWriteEnable(true, true) end
		if render_OverrideBlend then
			render_OverrideBlend(true, BLEND_ONE, BLEND_ZERO, BLENDFUNC_ADD, BLEND_ONE, BLEND_ZERO, BLENDFUNC_ADD)
		end

		surface_SetDrawColor(0, 0, 0, 0)
		surface_DrawRect(x, y, w, h)

		-- Restore render state
		if render_OverrideBlend then render_OverrideBlend(false) end
		if render_OverrideAlphaWriteEnable then render_OverrideAlphaWriteEnable(false) end
		if surface_SetAlphaMultiplier then surface_SetAlphaMultiplier(prevAlphaMult) end
		if render_SetColorModulation and prevR then render_SetColorModulation(prevR, prevG, prevB) end
		if render_SetBlend and prevBlend then render_SetBlend(prevBlend) end
	end

	local function createAtlasPage(index)
		-- Text atlas must stay filterable. POINTSAMPLE is correct for data RTs,
		-- but it destroys native glyph antialiasing during the compose blit.
		local flags = bit.bor(256, 4, 8)
		local art = GetRenderTargetEx("MGFXTextComposeAtlas_" .. tostring(index) .. "_" .. SysTime(), ATLAS_W, ATLAS_H, RT_SIZE_LITERAL, MATERIAL_RT_DEPTH_SEPARATE, flags, 0, IMAGE_FORMAT_BGRA8888)
		if not art then return false end

		local pageMat = CreateMaterial("MGFXTextComposeAtlas_" .. tostring(index) .. "_" .. SysTime(), "UnlitGeneric", {
			["$basetexture"] = art:GetName(),
			["$translucent"] = 1,
			["$vertexalpha"] = 1,
			["$vertexcolor"] = 1,
			["$ignorez"] = 1,
			["$nocull"] = 1,
			["$linearread_basetexture"] = 0,
		})
		local page = {index = index, rt = art, material = pageMat, w = ATLAS_W, h = ATLAS_H, x = 0, y = 0, rowH = 0, generation = 1}
		-- Dedicated compose/face shader materials bound to THIS page's RT, so the
		-- blit never rebinds $basetexture on a shared material across pages (which
		-- Source ignores, sampling the previously-bound page -> blank text).
		if createPageTextMaterials then
			local tm = createPageTextMaterials(art)
			page.composeMat = tm and tm.compose
			page.faceMat = tm and tm.face
		end
		atlasPages[index] = page
		atlas = atlas or page
		atlasMat = atlasMat or pageMat
		clearRenderTargetAlpha(art, ATLAS_W, ATLAS_H)
		return page
	end

	local function ensureTargets()
		if atlasPages[1] then return true end
		return createAtlasPage(1) ~= nil
	end

	local function resetAtlasPage(page)
		if not page then return end
		page.x, page.y, page.rowH = 0, 0, 0
		page.generation = (page.generation or 0) + 1
		-- MUST clear the RT when resetting. The old comment claimed clearAtlasSlot
		-- would handle per-slot clearing, but if slots aren't being cleared properly,
		-- old glyphs remain and cause UV sampling corruption. Full RT clear ensures
		-- a clean slate for the new generation.
		if page.rt then
			clearRenderTargetAlpha(page.rt, page.w or ATLAS_W, page.h or ATLAS_H)
		end
	end

	local function resetAtlasPages()
		atlasEpoch = atlasEpoch + 1
		for _, page in ipairs(atlasPages) do
			resetAtlasPage(page)
		end
		atlas = atlasPages[1]
		atlasMat = atlas and atlas.material or atlasMat
	end

	local function tryAllocOnPage(page, w, h, gutter)
		if not page then return nil end
		local cellW = w + gutter * 2
		local cellH = h + gutter * 2
		if cellW > page.w or cellH > page.h then return nil end
		if page.x + cellW > page.w then
			page.x = 0
			page.y = page.y + page.rowH
			page.rowH = 0
		end
		if page.y + cellH > page.h then return nil end
		local x, y = page.x + gutter, page.y + gutter
		page.x = page.x + cellW
		page.rowH = math_max(page.rowH, cellH)
		return x, y
	end

	local function ensureAtlasPage(index)
		if atlasPages[index] then return atlasPages[index] end
		if index > MAX_ATLAS_PAGES then return nil end
		return createAtlasPage(index)
	end

	local clearCache

	local function alloc(w, h, gutter)
		if not ensureTargets() then return nil end
		w = math_ceil(w)
		h = math_ceil(h)
		gutter = math_ceil(math_max(0, tonumber(gutter) or 0))

		for i = 1, MAX_ATLAS_PAGES do
			local page = ensureAtlasPage(i)
			if not page then break end
			local x, y = tryAllocOnPage(page, w, h, gutter)
			if x then
				-- Spilling into the reserved tail pages means accumulation is high.
				-- Flag a reset for the next flush boundary -- never clear here, mid
				-- flush, which would invalidate glyph entries already resolved for
				-- the current draw and blit garbage from their reused slots.
				if i > SOFT_ATLAS_PAGES then needsReset = true end
				return page, x, y
			end
		end

		-- Genuinely out of atlas space within a single flush. This happens when
		-- the working set is huge or we're cycling through all pages. Force an
		-- immediate cache clear and atlas reset, then retry ONCE. This prevents
		-- stale entries from accumulating across the full/reset boundary.
		if not needsReset then
			needsReset = true
			stats.textComposedEvicts = stats.textComposedEvicts + 1
			clearCache()
			needsReset = false
			-- Retry allocation after reset
			for i = 1, MAX_ATLAS_PAGES do
				local page = ensureAtlasPage(i)
				if not page then break end
				local x, y = tryAllocOnPage(page, w, h, gutter)
				if x then return page, x, y end
			end
		end
		-- Still couldn't allocate after reset - fail this allocation
		return nil
	end

	clearCache = function()
		cache = {}
		cacheCount = 0
		stats.textComposedEntries = 0
		if not ensureTargets() then return false end
		resetAtlasPages()
		return true
	end

	local function effectPad(style)
		local shadow = normalizeShadow(style.shadow)
		local stroke = normalizeStroke(style.stroke or style.outline)
		local glow = normalizeGlow(style.glow)
		local face = normalizeSurface(style.surface)
		local weightAdjust = normalizeWeightAdjust(style)
		local radius = PAD
		if weightAdjust > 0 then radius = math_max(radius, weightAdjust + 1) end
		if stroke then radius = math_max(radius, stroke.width + 1) end
		if glow then radius = math_max(radius, glow.width + 1) end
		if shadow then radius = math_max(radius, math_max(math_abs(shadow.x), math_abs(shadow.y)) + shadow.blur + 1) end
		local pad = math_ceil(radius + 2)
		return pad, pad, shadow, stroke, glow, face, weightAdjust
	end

	local function effectRouteKey(stroke, glow, shadow, face, weightAdjust)
		return table.concat({
			stroke and (stroke.width .. ":" .. stroke.samples .. ":" .. stroke.softness .. ":" .. colorKey(stroke.color)) or "",
			glow and (glow.width .. ":" .. glow.strength .. ":" .. glow.falloff .. ":" .. colorKey(glow.color)) or "",
			shadow and (shadow.x .. ":" .. shadow.y .. ":" .. shadow.blur .. ":" .. shadow.strength .. ":" .. colorKey(shadow.color)) or "",
			face and tostring(face.strength) or "",
			tostring(weightAdjust or 0),
		}, "\31")
	end

	local function effectInfo(style)
		style = style or {}
		if istable(style) and style.__mgfxTextEffectInfo then return style.__mgfxTextEffectInfo end
		local pad, gutter, shadow, stroke, glow, face, weightAdjust = effectPad(style)
		local info = {
			pad = pad,
			gutter = gutter,
			shadow = shadow,
			stroke = stroke,
			glow = glow,
			face = face,
			weightAdjust = weightAdjust,
			routeKey = effectRouteKey(stroke, glow, shadow, face, weightAdjust),
		}
		if istable(style) and style[RESOLVED_STYLE_MARK] == true then
			style.__mgfxTextEffectInfo = info
		end
		return info
	end

	local function fastEntryKey(record, style, info)
		local nativeFont, alias, oversample = nativeFor(record.font, style)
		local tracking = tonumber(style.tracking or style.letterSpacing) or alias.tracking or 0
		local lineHeight = lineHeightFor(nativeFont, alias, style, oversample)
		return tostring(CACHE_VERSION) .. "\30"
			.. tostring(record.text or "") .. "\30"
			.. tostring(record.font or "") .. "\30"
			.. tostring(nativeFont or "") .. "\30"
			.. tostring(oversample or 1) .. "\30"
			.. tostring(tracking) .. "\30"
			.. tostring(lineHeight) .. "\30"
			.. tostring(info and info.routeKey or "")
	end

	local isColorValue
	local fillForRecord
	local fillNeedsShader

	local function bake(record, key, layout, shadow, stroke, glow, face, weightAdjust, pad, gutter)
		if pad == nil or gutter == nil then
			pad, gutter = effectPad(record.style or {})
		end
		local oversample = normalizeOversample(layout.oversample)
		local atlasW = math_ceil((layout.w + pad * 2) * oversample)
		local atlasH = math_ceil((layout.h + pad * 2) * oversample)
		if atlasW <= 0 or atlasH <= 0 or atlasW > ATLAS_W or atlasH > ATLAS_H then return nil end

		local allocGutter = gutter * oversample
		local page, slotX, slotY = alloc(atlasW, atlasH, allocGutter)
		if not page or not slotX then return nil end

		local originX = pad
		local originY = pad

		render_PushRenderTarget(page.rt, 0, 0, page.w, page.h)
		render_SetScissorRect(0, 0, 0, 0, false)
		cam_Start2D()
		local am, cr, cg, cb, bl = beginAtlasDraw()
		clearAtlasSlot(slotX - allocGutter, slotY - allocGutter, atlasW + allocGutter * 2, atlasH + allocGutter * 2)
		drawLayout(layout, slotX + originX * oversample, slotY + originY * oversample, white, white)
		endAtlasDraw(am, cr, cg, cb, bl)
		cam_End2D()
		render_PopRenderTarget()
		restoreScissor()

		local fill = fillForRecord(record)
		local shaderCapableFace = not fillNeedsShader(fill)
		local shaderFace = shaderCapableFace and (face ~= nil or math_abs(weightAdjust or 0) > 0.001)
		if not shaderFace and shaderCapableFace then
			shaderFace = shadow ~= nil or stroke ~= nil or glow ~= nil
		end

		local entry = {
			page = page,
			slotX = slotX,
			slotY = slotY,
			atlasW = atlasW,
			atlasH = atlasH,
			w = atlasW / oversample,
			h = atlasH / oversample,
			originX = originX,
			originY = originY,
			contentW = layout.w,
			contentH = layout.h,
			oversample = oversample,
			shadow = shadow,
			stroke = stroke,
			glow = glow,
			face = face,
			weightAdjust = weightAdjust or 0,
			shaderFace = shaderFace,
			generation = page.generation,
		}
		cache[key] = entry
		cacheCount = cacheCount + 1
		stats.textComposedBakes = stats.textComposedBakes + 1
		stats.textComposedEntries = cacheCount
		return entry
	end

	function isColorValue(value)
		return istable(value) and value.r ~= nil and value.g ~= nil and value.b ~= nil
	end

	function fillForRecord(record)
		local style = record.style or {}
		return style.fill or style.color or record.color or white
	end

	function fillNeedsShader(fill)
		return istable(fill) and not isColorValue(fill) and fill.kind ~= nil
	end

	local function scaledColor(input, scale)
		local color = asColor(input, white)
		return Color(
			color.r or 255,
			color.g or 255,
			color.b or 255,
			math.Clamp(math_floor((color.a == nil and 255 or color.a) * (scale or 1)), 0, 255)
		)
	end

	local function drawNativeFallback(record)
		local profile = profileStart()
		local style = record.style or {}
		local layout = layoutFor(record.text, record.font, style, true)
		local x = (record.x or 0) - layout.w * alignFactor(record.alignX)
		local y = (record.y or 0) - layout.h * alignFactor(record.alignY, true)
		x, y = snapTextPos(x, y, style)
		local fill = style.fill or style.color or record.color or white
		local shadow = normalizeShadow(style.shadow)
		local stroke = normalizeStroke(style.stroke or style.outline)
		local glow = normalizeGlow(style.glow)

		stats.textFallbacks = stats.textFallbacks + 1
		stats.textNativeDraws = stats.textNativeDraws + 1
		if shadow then
			drawLayout(layout, x + shadow.x, y + shadow.y, scaledColor(shadow.color, shadow.strength), shadow.color)
		end
		if glow then
			for i = 1, glow.samples do
				local ang = i / glow.samples * math.pi * 2
				local radius = glow.width * (0.35 + 0.65 * i / glow.samples)
				drawLayout(layout, x + math_cos(ang) * radius, y + math_sin(ang) * radius, scaledColor(glow.color, glow.strength / glow.samples * 2), glow.color)
			end
		end
		if stroke then
			for i = 1, stroke.samples do
				local ang = i / stroke.samples * math.pi * 2
				drawLayout(layout, x + math_cos(ang) * stroke.width, y + math_sin(ang) * stroke.width, stroke.color, stroke.color)
			end
		end
		drawLayout(layout, x, y, fill, record.color or white)
		profileEnd("text.nativeFallback", profile)
	end

	local function drawNativePlain(record)
		local profile = profileStart()
		local style = record.style or {}
		local fill = fillForRecord(record)
		if fillNeedsShader(fill) then fill = record.color or white end
		stats.textNativeDraws = stats.textNativeDraws + 1
		local nativeFont, alias = nativeFor(record.font, style, true, true)
		local tracking = tonumber(style.tracking or style.letterSpacing) or alias.tracking or 0
		local text = tostring(record.text or "")
		if tracking == 0
			and not string.find(text, "\n", 1, true)
			and not style.lineHeight
			and not alias.lineHeight
			and not fillNeedsShader(fill) then
			local x, y = snapTextPos(record.x or 0, record.y or 0, style)
			draw.SimpleText(text, setFontSafe(nativeFont), x, y, asColor(fill, record.color or white), record.alignX or TEXT_ALIGN_LEFT, record.alignY or TEXT_ALIGN_TOP)
			profileEnd("text.nativePlain", profile)
			return
		end

		local layout = layoutFor(text, record.font, style, true, true)
		local x = (record.x or 0) - layout.w * alignFactor(record.alignX)
		local y = (record.y or 0) - layout.h * alignFactor(record.alignY, true)
		x, y = snapTextPos(x, y, style)
		drawLayout(layout, x, y, fill, record.color or white)
		profileEnd("text.nativePlain", profile)
	end

	local function entryFor(record, prewarm)
		local profile = profileStart()
		if not enabled() or not ensureTargets() then
			profileEnd("text.entryFor", profile)
			return nil
		end
		local style = record.style or {}
		if style.noComposed or style.native == true then
			profileEnd("text.entryFor", profile)
			return nil
		end

		local info = effectInfo(style)
		local shadow = info.shadow
		local stroke = info.stroke
		local glow = info.glow
		local face = info.face
		local weightAdjust = info.weightAdjust
		local key = record.__mgfxTextEntryKey or fastEntryKey(record, style, info)
		record.__mgfxTextEntryKey = key
		local layout
		tick = tick + 1
		local cached = cache[key]
		if cached and cached.page and cached.generation == cached.page.generation then
			cached.tick = tick
			stats.textEntryCacheHits = stats.textEntryCacheHits + 1
			profileEnd("text.entryFor", profile)
			return cached, nil
		end
		stats.textEntryCacheMisses = stats.textEntryCacheMisses + 1
		layout = layoutFor(record.text, record.font, style)
		bakesThisFrame = bakesThisFrame + 1
		local ok, entry = pcall(bake, record, key, layout, shadow, stroke, glow, face, weightAdjust, info.pad, info.gutter)
		if not ok then
			failed = true
			ErrorNoHaltWithStack("[MGFX] composed text bake failed: " .. tostring(entry) .. "\n")
			profileEnd("text.entryFor", profile)
			return nil, layout
		end
		profileEnd("text.entryFor", profile)
		return entry, layout
	end

	local function recordHasShaderWork(record)
		local style = record.style or {}
		local info = effectInfo(style)
		return info.shadow ~= nil
			or info.stroke ~= nil
			or info.glow ~= nil
			or info.face ~= nil
			or math_abs(info.weightAdjust or 0) > 0.001
			or fillNeedsShader(fillForRecord(record))
	end

	local function recordNeedsComposedEntry(record)
		local style = record.style or {}
		if style.noComposed or style.native == true then return false end
		return recordHasShaderWork(record)
	end

	local function prepareTextRoutes(records)
		local composeCount = 0
		for _, record in ipairs(records or {}) do
			if recordNeedsComposedEntry(record) then
				record.__mgfxTextRoute = "compose"
				composeCount = composeCount + 1
			else
				record.__mgfxTextRoute = "native"
			end
		end
		return composeCount
	end

	local function prewarmFlushRecords(records)
		if not records or #records <= 1 then return true end
		if not enabled() or not ensureTargets() then
			stats.textComposedPrewarmFails = stats.textComposedPrewarmFails + 1
			return false
		end

		for _ = 1, 3 do
			local generation = atlasEpoch
			local restarted = false
			for _, record in ipairs(records) do
				if record.__mgfxTextRoute == "compose" then
					local entry = entryFor(record, true)
					if not entry then
						stats.textComposedPrewarmFails = stats.textComposedPrewarmFails + 1
						return false
					end
					record.__mgfxTextEntry = entry
					if atlasEpoch ~= generation then
						stats.textComposedPrewarmRestarts = stats.textComposedPrewarmRestarts + 1
						restarted = true
						-- Clear all cached entries since the atlas was reset
						for _, r in ipairs(records) do
							r.__mgfxTextEntry = nil
						end
						break
					end
				end
			end

			if not restarted then
				return true
			end
		end

		stats.textComposedPrewarmFails = stats.textComposedPrewarmFails + 1
		return false
	end

	local function hasShaderFx(entry)
		return entry and (entry.shadow ~= nil or entry.stroke ~= nil or entry.glow ~= nil or entry.face ~= nil or (entry.weightAdjust or 0) ~= 0)
	end

	local function scaledColor01(effect, scale)
		if not effect then return 0, 0, 0, 0 end
		local r, g, b, a = color01(effect.color or color_white)
		return r, g, b, math.Clamp(a * (scale or 1), 0, 1)
	end

	local function packShadowParams(x, y, stroke)
		x = math.Clamp(tonumber(x) or 0, -64, 63.5)
		y = math.Clamp(tonumber(y) or 0, -64, 63.5)
		local xb = math.Clamp(math_floor((x + 64) * 2 + 0.5), 0, 255)
		local yb = math.Clamp(math_floor((y + 64) * 2 + 0.5), 0, 255)
		local softness = stroke and stroke.softness or 0
		local softByte = math.Clamp(math_floor(math.Clamp(softness, 0, 1) * 255 + 0.5), 0, 255)
		return xb * 65536 + yb * 256 + softByte
	end

	local function packEffectParams(glow, shadow, face, weightAdjust, shaderFace)
		local blur = shadow and shadow.blur or 0
		local falloff = glow and glow.falloff or 1.65
		local faceStrength = face and face.strength or 0
		local weight = math.Clamp(tonumber(weightAdjust) or 0, -2, 2)
		local blurByte = math.Clamp(math_floor(math.Clamp(blur, 0, 63.5) * 2 + 0.5), 0, 127)
		local falloffByte = math.Clamp(math_floor(math.Clamp(falloff, 0.25, 7.875) * 8 + 0.5), 0, 63)
		local faceByte = 0
		if shaderFace then
			faceByte = 1 + math.Clamp(math_floor(math.Clamp(faceStrength, 0, 1) * 30 + 0.5), 0, 30)
		end
		local weightByte = math.Clamp(math_floor(((weight + 2) / 4) * 63 + 0.5), 0, 63)
		return blurByte * 131072 + falloffByte * 2048 + faceByte * 64 + weightByte
	end

	local function setupTextComposeMaterial(mat, entry)
		local stroke = entry.stroke
		local glow = entry.glow
		local shadow = entry.shadow
		local face = entry.face
		local weightAdjust = entry.weightAdjust or 0
		local oversample = normalizeOversample(entry.oversample)
		local r, g, b, a = scaledColor01(stroke, 1)
		mat:SetFloat("$c0_x", r)
		mat:SetFloat("$c0_y", g)
		mat:SetFloat("$c0_z", b)
		mat:SetFloat("$c0_w", a)

		r, g, b, a = scaledColor01(glow, glow and glow.strength or 1)
		mat:SetFloat("$c1_x", r)
		mat:SetFloat("$c1_y", g)
		mat:SetFloat("$c1_z", b)
		mat:SetFloat("$c1_w", a)

		r, g, b, a = scaledColor01(shadow, shadow and shadow.strength or 1)
		mat:SetFloat("$c2_x", r)
		mat:SetFloat("$c2_y", g)
		mat:SetFloat("$c2_z", b)
		mat:SetFloat("$c2_w", a)

		local scaledStroke = stroke and {
			width = stroke.width * oversample,
			softness = stroke.softness,
		} or nil
		local scaledShadow = shadow and {
			x = shadow.x * oversample,
			y = shadow.y * oversample,
			blur = shadow.blur * oversample,
		} or nil

		mat:SetFloat("$c3_x", scaledStroke and scaledStroke.width or 0)
		mat:SetFloat("$c3_y", glow and glow.width * oversample or 0)
		mat:SetFloat("$c3_z", packEffectParams(glow, scaledShadow, face, weightAdjust * oversample, entry.shaderFace))
		mat:SetFloat("$c3_w", scaledShadow and packShadowParams(scaledShadow.x, scaledShadow.y, scaledStroke) or packShadowParams(0, 0, scaledStroke))
	end

	local function fillEndpointColors(fill, fallback)
		if isColorValue(fill) then return fill, fill end
		if istable(fill) and istable(fill.stops) and #fill.stops > 0 then
			local first = fill.stops[1]
			local last = fill.stops[#fill.stops]
			return asColor(first.color or first[2], fallback or white), asColor(last.color or last[2], fallback or white)
		end
		if istable(fill) then
			local a = asColor(fill.colorA or fill[1], fallback or white)
			return a, asColor(fill.colorB or fill[2], a)
		end
		local c = asColor(fill, fallback or white)
		return c, c
	end

	local function setupTextFaceMaterial(mat, entry, record, u0, v0, u1, v1, fillOverride)
		local fill = fillOverride or fillForRecord(record)
		local colorA, colorB = fillEndpointColors(fill, record.color or white)
		local r, g, b, a = color01(colorA)
		mat:SetTexture("$basetexture", entry.page.rt)
		local lut = gradientLutForFill(fill)
		if lut then mat:SetTexture("$texture1", lut) end
		mat:SetFloat("$c0_x", u0)
		mat:SetFloat("$c0_y", v0)
		mat:SetFloat("$c0_z", u1)
		mat:SetFloat("$c0_w", v1)
		mat:SetFloat("$c1_x", r)
		mat:SetFloat("$c1_y", g)
		mat:SetFloat("$c1_z", b)
		mat:SetFloat("$c1_w", a)
		r, g, b, a = color01(colorB)
		mat:SetFloat("$c2_x", r)
		mat:SetFloat("$c2_y", g)
		mat:SetFloat("$c2_z", b)
		mat:SetFloat("$c2_w", a)
		if istable(fill) and fill.kind == 1 then
			mat:SetFloat("$c3_x", tonumber(fill.x1) or 0)
			mat:SetFloat("$c3_y", tonumber(fill.y1) or 0)
			mat:SetFloat("$c3_z", tonumber(fill.x2) or 1)
			mat:SetFloat("$c3_w", tonumber(fill.y2) or 0)
		else
			mat:SetFloat("$c3_x", 0)
			mat:SetFloat("$c3_y", 0)
			mat:SetFloat("$c3_z", 1)
			mat:SetFloat("$c3_w", 0)
		end
	end

	local function drawEntryAt(entry, record, contentX, contentY, fillOverride)
		local page = entry.page or atlas
		if not page then
			return nil
		end
		-- The atlas slot this entry points at may have been evicted by a mid-flush
		-- atlas reset (alloc -> resetAtlasPages bumps page.generation and clears the
		-- RT). Blitting from a stale slot samples whatever glyph now occupies it --
		-- the intermittent "garbled digit" artifact. Bail so the caller can re-bake
		-- the entry against the current atlas generation.
		if entry.generation ~= page.generation then
			return nil
		end
		local x = contentX - entry.originX
		local y = contentY - entry.originY
		x, y = snapTextPos(x, y, record.style)
		local u0 = entry.slotX / page.w
		local v0 = entry.slotY / page.h
		local u1 = (entry.slotX + (entry.atlasW or entry.w)) / page.w
		local v1 = (entry.slotY + (entry.atlasH or entry.h)) / page.h
		local fx = hasShaderFx(entry)
		-- Prefer this page's own compose/face materials (fixed $basetexture) so the
		-- draw never rebinds a shared material's texture across pages.
		local faceMat = (matOK(page.faceMat) and page.faceMat) or (matOK(materials.text_face) and materials.text_face) or page.material or atlasMat
		local composeMat = (matOK(page.composeMat) and page.composeMat) or materials.text_compose
		local mat = fx and composeMat or faceMat
		if fx and matOK(mat) then
			mat:SetTexture("$basetexture", page.rt)
			setupTextComposeMaterial(mat, entry)
		elseif fx then
			return nil
		elseif faceMat then
			setupTextFaceMaterial(faceMat, entry, record, u0, v0, u1, v1, fillOverride)
			mat = faceMat
		end
		local drawColor = white
		if fx and entry.shaderFace then
			drawColor = asColor(fillOverride or fillForRecord(record), record.color or white)
		end
		drawUV(mat, x, y, entry.w, entry.h, u0, v0, u1, v1, drawColor)
		local blits = 1
		if fx and not entry.shaderFace and faceMat then
			setupTextFaceMaterial(faceMat, entry, record, u0, v0, u1, v1, fillOverride)
			drawUV(faceMat, x, y, entry.w, entry.h, u0, v0, u1, v1, white)
			blits = blits + 1
		end
		stats.textComposedBlits = stats.textComposedBlits + blits
		if fx then stats.textShaderDraws = stats.textShaderDraws + 1 end
		return fx
	end

	local function blit(entry, record)
		local contentX = (record.x or 0) - entry.contentW * alignFactor(record.alignX)
		local contentY = (record.y or 0) - entry.contentH * alignFactor(record.alignY, true)
		local fx = drawEntryAt(entry, record, contentX, contentY)
		if fx == nil then
			local refreshed = entryFor(record, false)
			if not refreshed then return nil end
			fx = drawEntryAt(refreshed, record, contentX, contentY)
			if fx == nil then return nil end
		end
		stats.textComposedDraws = stats.textComposedDraws + 1
		if fx then
			stats.textComposedFxDraws = stats.textComposedFxDraws + 1
		else
			stats.textComposedFaceDraws = stats.textComposedFaceDraws + 1
		end
		return fx
	end

	local function textBatchKey(entry, record)
		local page = entry and entry.page
		if not page then return nil end
		local fx = hasShaderFx(entry)
		if not fx then
			local fill = fillForRecord(record)
			if fillNeedsShader(fill) then return nil end
			return "plain\27" .. tostring(page.index or 0)
		end
		if not entry.shaderFace then return nil end
		if entry.batchKey then return entry.batchKey end
		entry.batchKey = table.concat({
			page.index or 0,
			tostring(entry.oversample or 1),
			entry.stroke and (entry.stroke.width .. ":" .. entry.stroke.softness .. ":" .. colorKey(entry.stroke.color)) or "",
			entry.glow and (entry.glow.width .. ":" .. entry.glow.strength .. ":" .. entry.glow.falloff .. ":" .. colorKey(entry.glow.color)) or "",
			entry.shadow and (entry.shadow.x .. ":" .. entry.shadow.y .. ":" .. entry.shadow.blur .. ":" .. entry.shadow.strength .. ":" .. colorKey(entry.shadow.color)) or "",
			entry.face and tostring(entry.face.strength) or "",
			tostring(entry.weightAdjust or 0),
		}, "\27")
		return entry.batchKey
	end

	local textBatchVertex = Vector()

	local function meshVertex(x, y, u, v, color)
		textBatchVertex.x = x
		textBatchVertex.y = y
		textBatchVertex.z = 0
		mesh.Position(textBatchVertex)
		mesh.Color(color.r or 255, color.g or 255, color.b or 255, color.a == nil and 255 or color.a)
		mesh.TexCoord(0, u, v)
		mesh.AdvanceVertex()
	end

	local function meshQuad(record)
		local e = record.__mgfxTextEntry
		local page = e.page
		local x = record.__mgfxBatchX
		local y = record.__mgfxBatchY
		local w = e.w
		local h = e.h
		local u0 = e.slotX / page.w
		local v0 = e.slotY / page.h
		local u1 = (e.slotX + (e.atlasW or e.w)) / page.w
		local v1 = (e.slotY + (e.atlasH or e.h)) / page.h
		local c = record.__mgfxBatchColor or white

		meshVertex(x, y, u0, v0, c)
		meshVertex(x + w, y, u1, v0, c)
		meshVertex(x + w, y + h, u1, v1, c)
		meshVertex(x, y, u0, v0, c)
		meshVertex(x + w, y + h, u1, v1, c)
		meshVertex(x, y + h, u0, v1, c)
	end

	local function flushTextComposeBatch(batch)
		if not batch or #batch == 0 then return end
		local profile = profileStart()
		if #batch == 1 then
			local record = batch[1]
			local fx = drawEntryAt(record.__mgfxTextEntry, record, record.__mgfxContentX, record.__mgfxContentY, record.__mgfxBatchColor)
			if fx == nil then
				local entry = entryFor(record, false)
				if not entry then
					profileEnd("text.composeBatch", profile)
					return
				end
				fx = drawEntryAt(entry, record, record.__mgfxContentX, record.__mgfxContentY, record.__mgfxBatchColor)
				if fx == nil then
					profileEnd("text.composeBatch", profile)
					return
				end
			end
			stats.textComposedDraws = stats.textComposedDraws + 1
			stats.textComposedFxDraws = stats.textComposedFxDraws + 1
			profileEnd("text.composeBatch", profile)
			return
		end

		local first = batch[1]
		local firstEntry = first.__mgfxTextEntry
		-- A mid-flush atlas reset can have invalidated entries queued earlier in this
		-- batch (their slots now hold different glyphs). The mesh path blits straight
		-- from the slots, so guard here: if any entry went stale, switch to per-record
		-- blits so each entry can be refreshed against the current atlas generation.
		for i = 1, #batch do
			local e = batch[i].__mgfxTextEntry
			if not e or not e.page or e.generation ~= e.page.generation then
				for _, record in ipairs(batch) do
					local refreshed = entryFor(record, false)
					if refreshed then
						blit(refreshed, record)
					end
				end
				profileEnd("text.composeBatch", profile)
				return
			end
		end
		local fx = hasShaderFx(firstEntry)
		-- Use this page's own compose material, not the shared one, so drawing
		-- multiple pages in a frame never rebinds a shared $basetexture (which
		-- Source ignores -> later pages sample the wrong RT and blank).
		local mat
		if fx then
			mat = (matOK(firstEntry.page.composeMat) and firstEntry.page.composeMat) or materials.text_compose
		else
			mat = (firstEntry.page and firstEntry.page.material) or atlasMat
		end
		if not matOK(mat) then
			for _, record in ipairs(batch) do blit(record.__mgfxTextEntry, record) end
			profileEnd("text.composeBatch", profile)
			return
		end

		if fx then
			mat:SetTexture("$basetexture", firstEntry.page.rt)
			setupTextComposeMaterial(mat, firstEntry)
		end
		render.SetMaterial(mat)
		mesh.Begin(MATERIAL_TRIANGLES, #batch * 2)
		for _, record in ipairs(batch) do
			meshQuad(record)
		end
		mesh.End()

		stats.textComposedBlits = stats.textComposedBlits + #batch
		stats.textComposedDraws = stats.textComposedDraws + #batch
		if fx then
			stats.textShaderDraws = stats.textShaderDraws + 1
			stats.textComposedFxDraws = stats.textComposedFxDraws + #batch
		else
			stats.textComposedFaceDraws = stats.textComposedFaceDraws + #batch
		end
		stats.textComposedBatchDraws = stats.textComposedBatchDraws + 1
		stats.textComposedBatchedRecords = stats.textComposedBatchedRecords + #batch
		profileEnd("text.composeBatch", profile)
	end

	local function queueTextComposeBatch(batches, order, entry, record)
		local key = textBatchKey(entry, record)
		if not key or not matOK(materials.text_compose) then return false end
		local contentX = (record.x or 0) - entry.contentW * alignFactor(record.alignX)
		local contentY = (record.y or 0) - entry.contentH * alignFactor(record.alignY, true)
		local x = contentX - entry.originX
		local y = contentY - entry.originY
		x, y = snapTextPos(x, y, record.style)
		local color = asColor(fillForRecord(record), record.color or white)
		record.__mgfxTextEntry = entry
		record.__mgfxContentX = contentX
		record.__mgfxContentY = contentY
		record.__mgfxBatchX = x
		record.__mgfxBatchY = y
		record.__mgfxBatchColor = color
		local batch = batches[key]
		if not batch then
			batch = {}
			batches[key] = batch
			order[#order + 1] = batch
		end
		batch[#batch + 1] = record
		return true
	end

	function renderer.MakeRecord(text, font, x, y, color, ax, ay, style)
		local profile = profileStart()
		local record = {
			text = tostring(text or ""),
			font = font or "DermaDefault",
			x = tonumber(x) or 0,
			y = tonumber(y) or 0,
			color = asColor(color or (style and style.color) or (style and style.fill), white),
			alignX = ax or TEXT_ALIGN_LEFT,
			alignY = ay or TEXT_ALIGN_TOP,
			style = renderer.ResolveStyle(style or {}),
		}
		profileEnd("text.makeRecord", profile)
		return record
	end

	function renderer.Flush(records)
		-- A flush boundary is the only safe point to reset the atlas: the previous
		-- flush has fully drawn and this one has not resolved any entries yet, so
		-- clearing the cache + RTs here can never strand an in-flight glyph. Resets
		-- are flagged (proactively, with page headroom) by alloc and executed here.
		if needsReset then
			needsReset = false
			stats.textComposedEvicts = stats.textComposedEvicts + 1
			clearCache()
			-- Clear all cached entries on records from previous frames
			for _, record in ipairs(records or {}) do
				record.__mgfxTextEntry = nil
			end
		end

		local totalProfile = profileStart()
		local routeProfile = profileStart()
		local prepareProfile = profileStart()
		local composeRequested = prepareTextRoutes(records)
		profileEnd("text.prepareRoutes", prepareProfile)
		stats.textComposedRequests = stats.textComposedRequests + composeRequested
		if composeRequested > 0 then stats.textComposedBatches = stats.textComposedBatches + 1 end
		local prewarmProfile = profileStart()
		local composerReady = composeRequested <= 0 or prewarmFlushRecords(records)
		profileEnd("text.prewarm", prewarmProfile)
		if composeRequested > 0 and composerReady then
			stats.textComposedReadyBatches = stats.textComposedReadyBatches + 1
		end
		profileEnd("text.route", routeProfile)

		local textBatches = {}
		local textBatchOrder = {}
		local function flushQueuedTextBatches()
			if #textBatchOrder == 0 then return end
			for _, batch in ipairs(textBatchOrder) do
				flushTextComposeBatch(batch)
			end
			textBatches = {}
			textBatchOrder = {}
		end

		local dispatchProfile = profileStart()
		for _, record in ipairs(records or {}) do
			stats.textDraws = stats.textDraws + 1
			local route = record.__mgfxTextRoute
			if route == "native" then
				flushQueuedTextBatches()
				drawNativePlain(record)
			else
				local entry = record.__mgfxTextEntry
				if not (entry and entry.page and entry.generation == entry.page.generation) then
					entry = entryFor(record, false)
				end
				if entry then
					if composerReady and queueTextComposeBatch(textBatches, textBatchOrder, entry, record) then
					else
						flushQueuedTextBatches()
						blit(entry, record)
					end
				end
			end
		end
		profileEnd("text.dispatch", dispatchProfile)
		flushQueuedTextBatches()
		profileEnd("text.flushInternal", totalProfile)
	end

	local immediateRecordBatch = {}

	function renderer.DrawRecordImmediate(record)
		local profile = profileStart()
		immediateRecordBatch[1] = record
		local out = renderer.Flush(immediateRecordBatch)
		immediateRecordBatch[1] = nil
		profileEnd("text.drawImmediate", profile)
		return out
	end

	function renderer.DrawTextImmediate(text, font, x, y, color, ax, ay, style)
		local record = renderer.MakeRecord(text, font, x, y, color, ax, ay, style)
		return renderer.DrawRecordImmediate(record)
	end

	local function ellipsize(text, font, maxW)
		text = tostring(text or "")
		if renderer.MeasureText(text, font) <= maxW then return text end
		local ell = "..."
		local ellW = renderer.MeasureText(ell, font)
		local out = ""
		for _, ch in ipairs(textChars(text)) do
			if renderer.MeasureText(out .. ch, font) + ellW > maxW then break end
			out = out .. ch
		end
		return out .. ell
	end

	local function wrapText(text, font, maxW, overflow)
		text = tostring(text or "")
		if maxW <= 0 then return {""} end
		if overflow == "ellipsis" then return {ellipsize(text, font, maxW)} end
		local lines = {}
		for _, raw in ipairs(string.Explode("\n", text, false)) do
			local current = ""
			for _, ch in ipairs(textChars(raw)) do
				local nextValue = current .. ch
				if current ~= "" and renderer.MeasureText(nextValue, font) > maxW then
					lines[#lines + 1] = current
					current = ch
				else
					current = nextValue
				end
			end
			lines[#lines + 1] = current
		end
		return lines
	end

	local function textBoxLineStyle(style)
		local lineStyle = {}
		for k, v in pairs(style or {}) do
			if k ~= "align"
				and k ~= "alignX"
				and k ~= "alignY"
				and k ~= "valign"
				and k ~= "overflow"
				and k ~= "ellipsis"
				and k ~= "maxLines" then
				lineStyle[k] = v
			end
		end
		return lineStyle
	end

	function renderer.MeasureTextBox(text, font, w, style)
		style = style or {}
		local lines = wrapText(text, font, tonumber(w) or 0, style.overflow)
		local maxW = 0
		for _, line in ipairs(lines) do
			local lw = renderer.MeasureText(line, font)
			maxW = math_max(maxW, lw)
		end
		local nativeFont, alias, oversample = nativeFor(font, style)
		local lineHeight = lineHeightFor(nativeFont, alias, style, oversample)
		return maxW, #lines * lineHeight, lines
	end

	function renderer.DrawTextBoxImmediate(text, font, x, y, w, h, style)
		style = renderer.ResolveStyle(style or {})
		local lines = wrapText(text, font, tonumber(w) or 0, style.overflow)
		local nativeFont, alias, oversample = nativeFor(font, style)
		local lineHeight = lineHeightFor(nativeFont, alias, style, oversample)
		local totalH = #lines * lineHeight
		local fy = alignFactor(style.alignY or style.valign or TEXT_ALIGN_TOP, true)
		local startY = (tonumber(y) or 0) + ((tonumber(h) or totalH) - totalH) * fy
		local ax = style.alignX or style.align or TEXT_ALIGN_LEFT
		local fx = alignFactor(ax)
		local tx = (tonumber(x) or 0) + (tonumber(w) or 0) * fx
		local lineStyle = textBoxLineStyle(style)

		for i, line in ipairs(lines) do
			renderer.DrawTextImmediate(line, font, tx, startY + (i - 1) * lineHeight, lineStyle.color or lineStyle.fill, ax, TEXT_ALIGN_TOP, lineStyle)
		end
	end

	function renderer.PrewarmText(text, font, style)
		local record = renderer.MakeRecord(text, font, 0, 0, nil, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, style or {})
		if not recordNeedsComposedEntry(record) then return false end
		return entryFor(record, true) ~= nil
	end

	function renderer.ClearMeasureCache()
		measureCache = {}
		measureOrder = {}
		measureOrderHead = 1
		measureOrderTail = 0
		measureOrderCount = 0
		stats.textCacheSize = 0
	end

	renderer.ClearComposedCache = clearCache
	renderer.ComposedEnabled = enabled

	function renderer.DebugResolve(text, font)
		local nativeFont, alias = nativeFor(font)
		return {
			text = tostring(text or ""),
			font = font,
			nativeFont = nativeFont,
			atlasKey = "__native",
			kind = "native",
			routeAtlas = "__native",
			routeKind = "native",
			mode = alias.mode or "native",
			missing = {},
		}
	end

	function renderer.Status()
		local usedH = 0
		for _, page in ipairs(atlasPages) do
			usedH = usedH + math_min(page.h or ATLAS_H, (page.y or 0) + (page.rowH or 0))
		end
		local fill = #atlasPages > 0 and usedH / (#atlasPages * ATLAS_H) or 0
		return {
			mode = "native+composer",
			fontCount = table.Count(fontAliases),
			styleCount = table.Count(namedStyles),
			styleStackDepth = #styleStack,
			cacheSize = measureOrderCount,
			composedEnabled = enabled(),
			composedAtlas = atlas and atlas.rt or nil,
			composedAtlasW = atlas and atlas.w or 0,
			composedAtlasH = atlas and atlas.h or 0,
			composedAtlasPages = #atlasPages,
			composedAtlasMaxPages = MAX_ATLAS_PAGES,
			composedAtlasFill = fill,
			composedEntries = cacheCount,
			composedFailed = failed,
			staticAtlasCount = 0,
			declaredAtlasCount = 0,
			atlasCount = 0,
		}
	end

	-- Debug: thumbnail every atlas page, drawn OPAQUE so the baked glyph RGB shows
	-- (white on black) regardless of the stored alpha. This reveals whether bakes
	-- actually wrote pixels: thumbnails with glyphs => atlas is fine and a blank is
	-- a blit-side failure; black thumbnails while pages are allocated => the bakes
	-- themselves are writing nothing. Laid out as a grid to fit the screen.
	local debugViewMat
	function renderer.DebugDrawAtlas()
		if #atlasPages == 0 then
			draw.SimpleText("[MGFX] atlas: no pages allocated yet", "DermaDefaultBold", 20, 20, Color(255, 120, 120))
			return
		end
		debugViewMat = debugViewMat or CreateMaterial("MGFXAtlasDebugView", "UnlitGeneric", {
			["$basetexture"] = "color/white",
			["$translucent"] = "0",
			["$vertexcolor"] = "1",
			["$ignorez"] = "1",
		})
		local n = #atlasPages
		local cols = math_min(n, 4)
		local pad = 8
		local thumbW = math_floor((ScrW() - 40 - pad * (cols - 1)) / cols)
		local thumbH = math_floor(thumbW * ATLAS_H / ATLAS_W)
		local x0, y0 = 20, 40
		draw.SimpleText("MGFX atlas " .. ATLAS_W .. "x" .. ATLAS_H .. "  pages=" .. n .. "   opaque view: WHITE = baked glyph RGB, BLACK = empty", "DermaDefaultBold", x0, 14, Color(160, 230, 255))
		for i, page in ipairs(atlasPages) do
			local col = (i - 1) % cols
			local row = math_floor((i - 1) / cols)
			local px = x0 + col * (thumbW + pad)
			local py = y0 + row * (thumbH + 20)
			if page.rt then
				debugViewMat:SetTexture("$basetexture", page.rt)
				surface_SetMaterial(debugViewMat)
				surface_SetDrawColor(255, 255, 255, 255)
				surface.DrawTexturedRect(px, py, thumbW, thumbH)
			end
			surface_SetDrawColor(70, 80, 92, 255)
			surface.DrawOutlinedRect(px, py, thumbW, thumbH)
			draw.SimpleText("page " .. i, "DermaDefaultBold", px + 2, py - 13, Color(255, 220, 120))
		end
	end

	return renderer
end
