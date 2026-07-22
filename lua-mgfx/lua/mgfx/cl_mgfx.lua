if SERVER then return end

MGFX = MGFX or {}
MGFX.api = MGFX
mgfx = nil

local M = MGFX
local string_sub = string.sub
local bit_bor = bit.bor

M.Backdrop = nil
M.BackdropEx = nil

M.TARGET = {
	ROUNDED_BOX = 1,
	CHAMFER_BOX = 2,
	POLY = 3,
	LINE = 4,
	CIRCLE = 5,
	CAPSULE = 6,
	IMAGE = 8,
	PROGRESS_BAR = 9,
	SEGMENT_BAR = 10,
	RING = 11,
	ARC = 12,
	TEXT = 13,
	SECTOR = 14,
}

M.TARGET_NAME = {}
for name, value in pairs(M.TARGET) do
	M.TARGET_NAME[value] = "MGFX.TARGET." .. name
end

function M._AddCommand(name, callback, autocomplete, helpText, flags)
	if string_sub(tostring(name), 1, 5) == "mgfx_" and concommand and concommand.Remove then
		concommand.Remove(name)
	end
	return concommand.Add(name, callback, autocomplete, helpText, flags)
end

M._BasePath = M._BasePath or "mgfx/"

local function mgfxInclude(name)
	include(M._BasePath .. name)
end

mgfxInclude("cl_mgfx_materials.lua")
mgfxInclude("cl_mgfx_capabilities.lua")
mgfxInclude("cl_mgfx_style.lua")
mgfxInclude("cl_mgfx_geometry.lua")
mgfxInclude("cl_mgfx_frame_geometry.lua")
mgfxInclude("cl_mgfx_commands.lua")
mgfxInclude("cl_mgfx_profiler.lua")
mgfxInclude("cl_mgfx_text.lua")
mgfxInclude("cl_mgfx_roundrect.lua")
mgfxInclude("cl_mgfx_primitives.lua")
mgfxInclude("cl_mgfx_widgets_bars.lua")
mgfxInclude("cl_mgfx_widgets_rings.lua")
mgfxInclude("cl_mgfx_widgets_images.lua")
mgfxInclude("cl_mgfx_widgets_text.lua")
mgfxInclude("cl_mgfx_widgets.lua")
mgfxInclude("cl_mgfx_frame.lua")
mgfxInclude("cl_mgfx_console.lua")

for _, key in ipairs({
	"begin",
	"finish",
	"beginFrame",
	"endFrame",
	"backdrop",
	"roundRect",
	"convexPoly",
	"progressBar",
	"circle",
	"capsule",
	"setClip",
	"endClip",
	"solid",
	"linearGradient",
	"linearGradientStops",
	"radialGradient",
	"conicGradient",
	"stripePattern",
	"segmentBar",
	"ring",
	"arc",
	"sector",
	"debugOverlay",
}) do
	M[key] = nil
end

local math_abs = math.abs
local math_atan2 = math.atan2 or math.atan
local math_max = math.max
local math_min = math.min
local math_sqrt = math.sqrt
local math_floor = math.floor
local math_ceil = math.ceil
local math_rad = math.rad
local math_cos = math.cos
local math_sin = math.sin
local FrameNumber = FrameNumber
local render_CopyRenderTargetToTexture = render.CopyRenderTargetToTexture
local render_DrawScreenQuad = render.DrawScreenQuad
local render_GetBlend = render.GetBlend
local render_GetColorModulation = render.GetColorModulation
local render_OverrideBlend = render.OverrideBlend
local render_OverrideAlphaWriteEnable = render.OverrideAlphaWriteEnable
local render_PopRenderTarget = render.PopRenderTarget
local render_PushRenderTarget = render.PushRenderTarget
local render_SetBlend = render.SetBlend
local render_SetColorModulation = render.SetColorModulation
local render_SetMaterial = render.SetMaterial
local render_SetScissorRect = render.SetScissorRect
local cam_Start2D = cam.Start2D
local cam_End2D = cam.End2D
local surface_GetAlphaMultiplier = surface.GetAlphaMultiplier
local surface_DrawLine = surface.DrawLine
local surface_DrawRect = surface.DrawRect
local surface_SetAlphaMultiplier = surface.SetAlphaMultiplier
local surface_SetDrawColor = surface.SetDrawColor
local surface_SetMaterial = surface.SetMaterial
local transparentColor = Color(0, 0, 0, 0)
local inv255 = 1 / 255

local materialState = assert(M._CreateMaterialState and M._CreateMaterialState(M), "MGFX material module unavailable")
local shaderVersion = materialState.shaderVersion
local shaderMountName = materialState.shaderMountName
local materials = materialState.materials
local blurRT = materialState.blurRT
local backdropBlurHorizontalRT = materialState.backdropBlurHorizontalRT
local backdropBlurRT = materialState.backdropBlurRT
local matOK = materialState.matOK

M.stats = M.stats or {
	draws = 0,
	blurPasses = 0,
	blurCaptures = 0,
	blurReuses = 0,
	fallbacks = 0,
	culled = 0,
	drawCommandCounts = {},
	drawImmediateCounts = {},
	profileTimes = {},
	profileCounts = {},
}
M.stats.drawCommandCounts = M.stats.drawCommandCounts or {}
M.stats.drawImmediateCounts = M.stats.drawImmediateCounts or {}
M.stats.profileTimes = M.stats.profileTimes or {}
M.stats.profileCounts = M.stats.profileCounts or {}
M.stats.blurCaptures = M.stats.blurCaptures or 0
M.stats.blurReuses = M.stats.blurReuses or 0
M._internal = M._internal or {}

local clipStack = {}
local frameState = {w = nil, h = nil, screenX = 0, screenY = 0}
local commandState = {stack = nil, replaying = false}
local commandStackPool = {}
local commandObjectPool = {}
local restoreScissor
local capabilityApi
local commandApi = assert(M._CreateCommandApi and M._CreateCommandApi(), "MGFX command module unavailable")

local function acquireCommandStack()
	local stack = commandStackPool[#commandStackPool]
	if stack then
		commandStackPool[#commandStackPool] = nil
		return stack
	end
	return {}
end

local function releaseCommandStack(stack)
	if not stack then return end
	for i = 1, #stack do
		local command = stack[i]
		if command and command._mgfxPooled then
			table.Empty(command)
			command._mgfxPooled = true
			commandObjectPool[#commandObjectPool + 1] = command
		end
	end
	table.Empty(stack)
	commandStackPool[#commandStackPool + 1] = stack
end

local function acquireCommandObject(op)
	local command = commandObjectPool[#commandObjectPool]
	if command then
		commandObjectPool[#commandObjectPool] = nil
	else
		command = {_mgfxPooled = true}
	end
	command.op = op
	command[1] = op
	return command
end

local emptyDrawStyle = {}
local colorDrawStyleCache = setmetatable({}, {__mode = "k"})

local function copyStyle(style)
	if not istable(style) then
		return {}
	end

	if style.r ~= nil and style.g ~= nil and style.b ~= nil then
		return {fill = style}
	end

	return table.Copy(style)
end

local function resolveDrawStyle(style, target)
	if style == nil then return emptyDrawStyle end
	if not istable(style) then return emptyDrawStyle end
	if style._mgfxCompiledStyle == true then return style end
	if style.r ~= nil and style.g ~= nil and style.b ~= nil then
		local cached = colorDrawStyleCache[style]
		if cached then return cached end
		cached = {fill = style}
		colorDrawStyleCache[style] = cached
		return cached
	end

	local fill = style.fill
	local fillKind = istable(fill) and fill.kind or nil
	if fillKind ~= "stripe" and fillKind ~= "smoke" then return style end

	if capabilityApi and capabilityApi.normalizeStyle then
		return capabilityApi.normalizeStyle(style, target) or emptyDrawStyle
	end
	return style
end

local function copyPoints(points)
	return istable(points) and table.Copy(points) or points
end

local directImmediateNames = {
	DrawChamferBox = "chamfer",
	DrawImage = "image",
	DrawLine = "line",
	DrawPoly = "poly",
	DrawProgressBar = "progress",
	DrawRoundedBox = "round",
	DrawSegmentBar = "segment",
	DrawRing = "ring",
	DrawArc = "arc",
	DrawSector = "sector",
}
local drawCommandCounts = M.stats.drawCommandCounts
local drawImmediateCounts = M.stats.drawImmediateCounts

local function addStat(tableName, key, amount)
	local t = M.stats[tableName]
	if not t then return end
	key = key or "unknown"
	t[key] = (t[key] or 0) + (amount or 1)
end

local function recordDirectImmediate(commandName, immediateName, count)
	if commandState.replaying or not frameState.drawCountsActive then return end
	count = count or 1
	drawCommandCounts[commandName] = (drawCommandCounts[commandName] or 0) + count
	local key = immediateName or directImmediateNames[commandName] or commandName
	drawImmediateCounts[key] = (drawImmediateCounts[key] or 0) + count
end

local function queueCommand(command, a, b, c, d, e, f, g, h)
	if commandState.stack and not commandState.replaying then
		local op = isstring(command) and command or (command and (command.op or command[1]))
		if isstring(command) then
			if op ~= "PushClip" and op ~= "PopClip" then return false end
			command = acquireCommandObject(op)
			if op == "PushClip" then
				command.x, command.y, command.w, command.h = a, b, c, d
			end
		elseif op ~= "DrawText" and op ~= "DrawTextBatch" and op ~= "DrawTextBox" then
			return false
		end
		commandState.stack[#commandState.stack + 1] = command
		return true
	end
	return false
end

local function queueTextRecord(record)
	if commandState.stack and not commandState.replaying then
		local stack = commandState.stack
		local last = stack[#stack]
		if last and last.op == "DrawTextBatch" then
			local records = last.records
			records[#records + 1] = record
		else
			stack[#stack + 1] = {op = "DrawTextBatch", records = {record}}
			M.stats.textQueuedBatches = (M.stats.textQueuedBatches or 0) + 1
		end
		M.stats.textQueuedRecords = (M.stats.textQueuedRecords or 0) + 1
		return true
	end
	return false
end

local function queueTextBatch(records)
	if commandState.stack and not commandState.replaying then
		commandState.stack[#commandState.stack + 1] = {op = "DrawTextBatch", records = records}
		M.stats.textQueuedBatches = (M.stats.textQueuedBatches or 0) + 1
		M.stats.textQueuedRecords = (M.stats.textQueuedRecords or 0) + #(records or {})
		return true
	end
	return false
end
local textureFallbackMaterial
local materialCache = {}
local forceFallback = CreateClientConVar("mgfx_force_fallback", "0", true, false)
local profileEnabled = CreateClientConVar("mgfx_profile", "0", true, false, "MGFX: collect per-frame CPU timing stats for renderer stages.")
local drawCountsEnabled = CreateClientConVar("mgfx_draw_counts", "0", true, false, "MGFX: collect per-family draw counters for mgfx_status diagnostics.")
CreateClientConVar("mgfx_text_composed", "1", true, false, "MGFX: enable native-raster text composer for shader text effects.")
CreateClientConVar("mgfx_text_composed_budget", "6", true, false, "MGFX: max shader text bakes per frame (amortizes first-paint cost).")
local textRenderer
local profiler = assert(M._CreateProfiler and M._CreateProfiler({
	M = M,
	enabledConVar = profileEnabled,
}), "MGFX profiler module unavailable")
M.Profiler = profiler
M.BeginProfileFrame = profiler.BeginFrame
M.EndProfileFrame = profiler.EndFrame
M.GetProfileRows = profiler.Snapshot
M.GetCurrentProfileRows = profiler.CurrentRows
M.GetProfileScopeRows = profiler.ScopeRows
M.GetRecentProfileScopes = profiler.RecentScopes
M.GetProfileInstanceRows = profiler.InstanceRows
M.FormatProfileRows = profiler.FormatRows
M.FormatProfileScopeRows = profiler.FormatScopeRows
M.ResetProfile = profiler.Reset
M.InstallApiWrappers = profiler.InstallApiWrappers
M.BeginTrace = profiler.BeginTrace
M.EndTrace = profiler.EndTrace
M.TraceStart = profiler.TraceStart
M.TraceEnd = profiler.TraceEnd

local function shadersActive()
	local cached = frameState.shadersActive
	if cached ~= nil then return cached end
	return not forceFallback:GetBool() and M.hasShaders()
end

local function resetStats()
	M.stats.draws = 0
	M.stats.blurPasses = 0
	M.stats.blurCaptures = 0
	M.stats.blurReuses = 0
	M.stats.fallbacks = 0
	M.stats.culled = 0
	M.stats.gradientLutFillHits = 0
	M.stats.textQueuedBatches = 0
	M.stats.textQueuedRecords = 0
	table.Empty(M.stats.drawCommandCounts)
	table.Empty(M.stats.drawImmediateCounts)
	table.Empty(M.stats.profileTimes)
	table.Empty(M.stats.profileCounts)
	if textRenderer and textRenderer.ResetFrameStats then
		textRenderer.ResetFrameStats()
	end
end

capabilityApi = assert(M._InstallCapabilities and M._InstallCapabilities(M), "MGFX capabilities module unavailable")
local styleApi = assert(M._InstallStyle and M._InstallStyle(M), "MGFX style module unavailable")
local asColor = styleApi.asColor
local color01 = styleApi.color01
local setDrawColor = styleApi.setDrawColor
local strokeWidthValue = styleApi.strokeWidthValue
local strokeRaw = styleApi.strokeRaw
local strokeColor = styleApi.strokeColor
local strokeKind = styleApi.strokeKind
local radiusTuple = styleApi.radiusTuple
local radiusScalar = styleApi.radiusScalar
local normalizeStops = styleApi.normalizeStops
local firstLastStops = styleApi.firstLastStops
local lerpColor = styleApi.lerpColor
local colorAtStops = styleApi.colorAtStops
local fillFromStyle = styleApi.fillFromStyle
local fillVisible = styleApi.fillVisible
local colorAtFill = styleApi.colorAtFill
local normalizedRotation = styleApi.normalizedRotation
local glowSoftnessToFalloff = styleApi.glowSoftnessToFalloff
local strokeVisible = styleApi.strokeVisible
local backdropStyle = styleApi.backdropStyle
local defaultPatternColor = styleApi.defaultPatternColor
local defaultPatternTrueColor = styleApi.defaultPatternTrueColor
local defaultWornEdgeColor = styleApi.defaultWornEdgeColor
local imageMaskStyle = styleApi.imageMaskStyle
local FILL_SOLID = styleApi.FILL_SOLID
local FILL_LINEAR = styleApi.FILL_LINEAR
local FILL_RADIAL = styleApi.FILL_RADIAL
local FILL_CONIC = styleApi.FILL_CONIC
local STROKE_SOLID = styleApi.STROKE_SOLID
local STROKE_DOT = styleApi.STROKE_DOT
local STROKE_DASH = styleApi.STROKE_DASH
local STROKE_DOT_DASH = styleApi.STROKE_DOT_DASH

local GRADIENT_LUT_W = 256
local GRADIENT_LUT_H = 4
local GRADIENT_LUT_CACHE_LIMIT = 128
local gradientLutCache = {}
local gradientFillLutCache = setmetatable({}, {__mode = "k"})
local gradientLutBound = setmetatable({}, {__mode = "k"})
local gradientLutCacheCount = 0
local gradientLutClock = 0
local gradientLutSerial = 0
local gradientLutSchema = "lut-alpha-rgb-v3"
local gradientLutFlags = bit_bor(2, 256, 4, 8)

local function colorKey(color)
	color = asColor(color, color_white)
	return table.concat({
		math_floor(color.r or 0),
		math_floor(color.g or 0),
		math_floor(color.b or 0),
		math_floor(color.a == nil and 255 or color.a),
	}, ",")
end

local function normalizedGradientStops(fill)
	if istable(fill) and fill.stops and #fill.stops > 0 then
		if fill._mgfxStopsNormalized then return fill.stops end
		return normalizeStops(fill.stops)
	end

	local colorA
	local colorB
	if istable(fill) and fill.r ~= nil then
		colorA = asColor(fill, color_white)
		colorB = colorA
	elseif istable(fill) then
		colorA = asColor(fill.colorA or fill[1], color_white)
		colorB = asColor(fill.colorB or fill[2], colorA)
	else
		colorA = asColor(fill, color_white)
		colorB = colorA
	end

	return normalizeStops({
		{0, colorA},
		{1, colorB},
	})
end

local function gradientFillCacheEntry(fill)
	if not istable(fill) or not fill._mgfxLutCacheSafe then return nil end
	local cached = gradientFillLutCache[fill]
	if not cached then return nil end

	local entry = cached.entry
	if cached.schema ~= gradientLutSchema or not entry or entry.key ~= cached.key then return nil end

	gradientLutClock = gradientLutClock + 1
	entry.tick = gradientLutClock
	M.stats.gradientLutFillHits = (M.stats.gradientLutFillHits or 0) + 1
	return entry.texture
end

local function rememberGradientFill(fill, key, entry)
	if not istable(fill) or not fill._mgfxLutCacheSafe or not entry then return end
	gradientFillLutCache[fill] = {
		schema = gradientLutSchema,
		key = key,
		entry = entry,
	}
end

local function colorAtNormalizedStops(stops, t)
	if not stops or #stops == 0 then return color_white end
	t = math.Clamp(tonumber(t) or 0, 0, 1)

	for i = 1, #stops - 1 do
		local a = stops[i]
		local b = stops[i + 1]
		if t <= b.pos then
			local span = math_max(0.0001, b.pos - a.pos)
			return lerpColor(a.color, b.color, (t - a.pos) / span)
		end
	end

	return stops[#stops].color or color_white
end

local function gradientLutKey(stops)
	local parts = {gradientLutSchema}
	for i = 1, #stops do
		local stop = stops[i]
		parts[#parts + 1] = string.format("%.5f:%s", stop.pos or 0, colorKey(stop.color))
	end
	return table.concat(parts, "|")
end

local function createGradientLutTexture(key)
	gradientLutSerial = gradientLutSerial + 1
	local name = "MGFXGradLUT_" .. tostring(shaderVersion or "dev") .. "_" .. gradientLutSerial .. "_" .. util.CRC(key)
	return GetRenderTargetEx(
		name,
		GRADIENT_LUT_W,
		GRADIENT_LUT_H,
		RT_SIZE_LITERAL,
		MATERIAL_RT_DEPTH_NONE or 0,
		gradientLutFlags,
		0,
		IMAGE_FORMAT_BGRA8888
	)
end

local function writeGradientLut(rt, stops)
	if not rt then return end
	render_PushRenderTarget(rt, 0, 0, GRADIENT_LUT_W, GRADIENT_LUT_H)
	render_SetScissorRect(0, 0, 0, 0, false)
	local prevR, prevG, prevB
	if render_GetColorModulation then
		prevR, prevG, prevB = render_GetColorModulation()
	end
	local prevBlend = render_GetBlend and render_GetBlend() or nil
	local prevAlphaMult = surface_GetAlphaMultiplier and surface_GetAlphaMultiplier() or 1
	if surface_SetAlphaMultiplier then surface_SetAlphaMultiplier(1) end
	if render_SetColorModulation then render_SetColorModulation(1, 1, 1) end
	if render_SetBlend then render_SetBlend(1) end
	if render_OverrideAlphaWriteEnable then render_OverrideAlphaWriteEnable(true, true) end
	if render_OverrideBlend then
		render_OverrideBlend(true, BLEND_ONE, BLEND_ZERO, BLENDFUNC_ADD, BLEND_ONE, BLEND_ZERO, BLENDFUNC_ADD)
	end
	render.Clear(0, 0, 0, 0, true, true)
	cam_Start2D()
	for x = 0, GRADIENT_LUT_W - 1 do
		local color = colorAtNormalizedStops(stops, x / (GRADIENT_LUT_W - 1))
		local alpha = math.Clamp(math_floor(color.a == nil and 255 or color.a), 0, 255)
		surface_SetDrawColor(color.r or 255, color.g or 255, color.b or 255, 255)
		surface_DrawRect(x, 0, 1, 2)
		surface_SetDrawColor(alpha, alpha, alpha, 255)
		surface_DrawRect(x, 2, 1, 2)
	end
	cam_End2D()
	if render_OverrideBlend then render_OverrideBlend(false) end
	if render_OverrideAlphaWriteEnable then render_OverrideAlphaWriteEnable(false) end
	if surface_SetAlphaMultiplier then surface_SetAlphaMultiplier(prevAlphaMult) end
	if render_SetColorModulation and prevR ~= nil then render_SetColorModulation(prevR, prevG, prevB) end
	if render_SetBlend and prevBlend ~= nil then render_SetBlend(prevBlend) end
	render_PopRenderTarget()
	if restoreScissor then restoreScissor() end
end

local function acquireGradientLutEntry(key)
	local cached = gradientLutCache[key]
	if cached then return cached end

	if gradientLutCacheCount < GRADIENT_LUT_CACHE_LIMIT then
		local texture = createGradientLutTexture(key)
		if not texture then return nil end
		cached = {texture = texture}
		gradientLutCache[key] = cached
		gradientLutCacheCount = gradientLutCacheCount + 1
		return cached
	end

	local oldestKey
	local oldestEntry
	for entryKey, entry in pairs(gradientLutCache) do
		if not oldestEntry or (entry.tick or 0) < (oldestEntry.tick or 0) then
			oldestKey = entryKey
			oldestEntry = entry
		end
	end

	if not oldestEntry then return nil end
	gradientLutCache[oldestKey] = nil
	gradientLutCache[key] = oldestEntry
	return oldestEntry
end

local function gradientLutForFill(fill)
	local cached = gradientFillCacheEntry(fill)
	if cached then return cached end

	local stops = normalizedGradientStops(fill)
	if not stops then return nil end

	local key = gradientLutKey(stops)
	gradientLutClock = gradientLutClock + 1
	local entry = acquireGradientLutEntry(key)
	if not entry then return nil end
	if entry.key ~= key then
		writeGradientLut(entry.texture, stops)
		entry.key = key
	end
	entry.tick = gradientLutClock
	rememberGradientFill(fill, key, entry)
	return entry.texture
end

local function bindGradientLut(mat, fill)
	if not mat or not mat.SetTexture then return nil end
	local lut = gradientLutForFill(fill)
	if lut and gradientLutBound[mat] ~= lut then
		mat:SetTexture("$texture1", lut)
		gradientLutBound[mat] = lut
	end
	return lut
end

function M.GradientLutForFill(fill)
	return gradientLutForFill(fill)
end

function M.BindGradientLut(mat, fill)
	return bindGradientLut(mat, fill)
end

function M.GradientLutStatus()
	return {
		count = gradientLutCacheCount,
		limit = GRADIENT_LUT_CACHE_LIMIT,
		serial = gradientLutSerial,
	}
end

local geometryApi = assert(M._CreateGeometryHelpers and M._CreateGeometryHelpers({
	M = M,
	stats = M.stats,
	profiler = profiler,
	asColor = asColor,
	copyStyle = copyStyle,
}), "MGFX geometry module unavailable")
local blurIntensity = geometryApi.blurIntensity
local drawTexturedQuad = geometryApi.drawTexturedQuad
local drawTexturedQuadUV = geometryApi.drawTexturedQuadUV
local drawTransformedPoly = geometryApi.drawTransformedPoly
local withTransform = geometryApi.withTransform
local splitStyleTransform = geometryApi.splitStyleTransform
local hasTransform = geometryApi.hasTransform
local drawCreatedMaterialTexturedRectUV = geometryApi.drawCreatedMaterialTexturedRectUV
local textureSize = geometryApi.textureSize
local imageTint = geometryApi.imageTint
local imageStyle = geometryApi.imageStyle
local imageRadius = geometryApi.imageRadius
local imageAlign = geometryApi.imageAlign
local imageUV = geometryApi.imageUV
local imageFitRect = geometryApi.imageFitRect
M._Geometry = geometryApi
M._internal.drawTexturedQuad = drawTexturedQuad
M._internal.drawTexturedQuadUV = drawTexturedQuadUV

local frameGeometryApi = assert(M._CreateFrameGeometry and M._CreateFrameGeometry({
	M = M,
	stats = M.stats,
	clipStack = clipStack,
	frameState = frameState,
}), "MGFX frame geometry module unavailable")
local isCulled = frameGeometryApi.isCulled
local withLocalScissor = frameGeometryApi.withLocalScissor
local withScreenScissorPixels = frameGeometryApi.withScreenScissorPixels
local withPanelEffectBleed = frameGeometryApi.withPanelEffectBleed
restoreScissor = frameGeometryApi.restoreScissor

local paramMatrices = {}
local paramMatrixRawState = {}
local auxParamMatrices = {}
local auxParamMatrixRawState = {}
local paramMatrixSetUnpacked
do
	local probeMatrix = Matrix and Matrix() or nil
	paramMatrixSetUnpacked = probeMatrix and probeMatrix.SetUnpacked or nil
end

local function setupParamMatrix(mat,
	a0, a1, a2, a3,
	b0, b1, b2, b3,
	c0, c1, c2, c3,
	d0, d1, d2, d3)
	if not mat or not paramMatrixSetUnpacked then return false end

	local matrix = paramMatrices[mat]
	if not matrix then
		matrix = Matrix()
		paramMatrices[mat] = matrix
	end

	paramMatrixSetUnpacked(matrix,
		a0 or 0, b0 or 0, c0 or 0, d0 or 0,
		a1 or 0, b1 or 0, c1 or 0, d1 or 0,
		a2 or 0, b2 or 0, c2 or 0, d2 or 0,
		a3 or 0, b3 or 0, c3 or 0, d3 or 0
	)
	mat:SetMatrix("$viewprojmat", matrix)
	return true
end

local function setupParamMatrixRaw(mat,
	a0, a1, a2, a3,
	b0, b1, b2, b3,
	c0, c1, c2, c3,
	d0, d1, d2, d3)
	local state = paramMatrixRawState[mat]
	if state
		and state[1] == a0 and state[2] == a1 and state[3] == a2 and state[4] == a3
		and state[5] == b0 and state[6] == b1 and state[7] == b2 and state[8] == b3
		and state[9] == c0 and state[10] == c1 and state[11] == c2 and state[12] == c3
		and state[13] == d0 and state[14] == d1 and state[15] == d2 and state[16] == d3 then
		return
	end
	if not state then
		state = {}
		paramMatrixRawState[mat] = state
	end
	state[1], state[2], state[3], state[4] = a0, a1, a2, a3
	state[5], state[6], state[7], state[8] = b0, b1, b2, b3
	state[9], state[10], state[11], state[12] = c0, c1, c2, c3
	state[13], state[14], state[15], state[16] = d0, d1, d2, d3

	local matrix = paramMatrices[mat]
	if not matrix then
		matrix = Matrix()
		paramMatrices[mat] = matrix
	end

	paramMatrixSetUnpacked(matrix,
		a0, b0, c0, d0,
		a1, b1, c1, d1,
		a2, b2, c2, d2,
		a3, b3, c3, d3
	)
	mat:SetMatrix("$viewprojmat", matrix)
end

local function setupAuxConstants(mat,
	a0, a1, a2, a3,
	b0, b1, b2, b3,
	c0, c1, c2, c3,
	d0, d1, d2, d3)
	if not mat or not paramMatrixSetUnpacked then return false end

	local matrix = auxParamMatrices[mat]
	if not matrix then
		matrix = Matrix()
		auxParamMatrices[mat] = matrix
	end

	paramMatrixSetUnpacked(matrix,
		a0 or 0, b0 or 0, c0 or 0, d0 or 0,
		a1 or 0, b1 or 0, c1 or 0, d1 or 0,
		a2 or 0, b2 or 0, c2 or 0, d2 or 0,
		a3 or 0, b3 or 0, c3 or 0, d3 or 0
	)
	mat:SetMatrix("$invviewprojmat", matrix)
	return true
end

local function setupAuxConstantsRaw(mat,
	a0, a1, a2, a3,
	b0, b1, b2, b3,
	c0, c1, c2, c3,
	d0, d1, d2, d3)
	local state = auxParamMatrixRawState[mat]
	if state
		and state[1] == a0 and state[2] == a1 and state[3] == a2 and state[4] == a3
		and state[5] == b0 and state[6] == b1 and state[7] == b2 and state[8] == b3
		and state[9] == c0 and state[10] == c1 and state[11] == c2 and state[12] == c3
		and state[13] == d0 and state[14] == d1 and state[15] == d2 and state[16] == d3 then
		return true
	end
	if not state then
		state = {}
		auxParamMatrixRawState[mat] = state
	end
	state[1], state[2], state[3], state[4] = a0, a1, a2, a3
	state[5], state[6], state[7], state[8] = b0, b1, b2, b3
	state[9], state[10], state[11], state[12] = c0, c1, c2, c3
	state[13], state[14], state[15], state[16] = d0, d1, d2, d3

	local matrix = auxParamMatrices[mat]
	if not matrix then
		matrix = Matrix()
		auxParamMatrices[mat] = matrix
	end

	paramMatrixSetUnpacked(matrix,
		a0, b0, c0, d0,
		a1, b1, c1, d1,
		a2, b2, c2, d2,
		a3, b3, c3, d3
	)
	mat:SetMatrix("$invviewprojmat", matrix)
	return true
end

local function setupConstants(mat, w, h, fill, stroke, strokeWidth, radius)
	local colorA = fill.colorA or color_white
	local colorB = fill.colorB or colorA
	local strokeColor = stroke or transparentColor
	local fillKind = fill.kind or FILL_SOLID
	local packedStyle = math.Clamp(strokeWidthValue(strokeWidth, 0), 0, 255) + math.Clamp(fillKind, 0, 3) * 256

	local r, g, b, a = color01(colorB)
	local p0, p1, p2, p3

	if fillKind == FILL_LINEAR then
		p0, p1, p2, p3 = fill.x1 or 0, fill.y1 or 0, fill.x2 or 1, fill.y2 or 1
		bindGradientLut(mat, fill)
	elseif fillKind == FILL_RADIAL then
		p0, p1, p2, p3 = fill.cx or 0.5, fill.cy or 0.5, fill.radius or 0.5, 0
		bindGradientLut(mat, fill)
	elseif fillKind == FILL_CONIC then
		p0, p1, p2, p3 = fill.cx or 0.5, fill.cy or 0.5, normalizedRotation(fill.rotation), 0
		bindGradientLut(mat, fill)
	else
		p0, p1, p2, p3 = 0, 0, 1, 0
	end

	local sr, sg, sb, sa = color01(strokeColor)
	setupParamMatrix(mat,
		r, g, b, a,
		w, h, packedStyle, math_max(0, tonumber(radius) or 0),
		p0, p1, p2, p3,
		sr, sg, sb, sa
	)

	setDrawColor(colorA)
end

local function setupExtraParams(mat,
	a0, a1, a2, a3,
	b0, b1, b2, b3,
	c0, c1, c2, c3,
	d0, d1, d2, d3)
	return setupAuxConstants(mat,
		a0, a1, a2, a3,
		b0, b1, b2, b3,
		c0, c1, c2, c3,
		d0, d1, d2, d3)
end

local function setupBlurConstants(mat, w, h, vertical, intensity, radius)
	setupParamMatrix(mat,
		vertical and 1 or 0, intensity or 1, 0, 0,
		w, h, 0, math_max(0, tonumber(radius) or 0),
		0, 0, 1, 0,
		0, 0, 0, 0
	)
end

local drawMaterialPoly

drawMaterialPoly = function(poly, mat)
	if not poly or not mat then return false end

	local verts = {}
	for i, p in ipairs(poly.points or {}) do
		verts[i] = {
			x = poly.x + p.x,
			y = poly.y + p.y,
			u = poly.w ~= 0 and p.x / poly.w or 0,
			v = poly.h ~= 0 and p.y / poly.h or 0,
		}
	end

	if #verts < 3 then return false end

	surface_SetMaterial(mat)
	drawTransformedPoly(verts)
	M.stats.draws = M.stats.draws + 1
	return true
end

local textRendererFactory = M._CreateTextRenderer
if type(textRendererFactory) == "function" then
	textRenderer = textRendererFactory({
		M = M,
		stats = M.stats,
		materials = materials,
		createPageTextMaterials = materialState.CreatePageTextMaterials,
		matOK = matOK,
		profiler = profiler,
		asColor = asColor,
		color01 = color01,
		gradientLutForFill = gradientLutForFill,
		getFrameOffset = function()
			return frameState.screenX or 0, frameState.screenY or 0
		end,
		getFrameSize = function()
			return frameState.w or ScrW(), frameState.h or ScrH()
		end,
		hasClip = function()
			return #clipStack > 0
		end,
		restoreScissor = function()
			if restoreScissor then restoreScissor() end
		end,
	})
else
	print("[MGFX] text renderer unavailable")
end

local function setupLineConstants(mat, fill)
	local colorA = fill.colorA or color_white
	local colorB = fill.colorB or colorA
	local r, g, b, a = color01(colorA)
	local br, bg, bb, ba = color01(colorB)
	setupParamMatrix(mat,
		r, g, b, a,
		br, bg, bb, ba,
		0, 0, 1, 0,
		0, 0, 0, 0
	)
	bindGradientLut(mat, fill)
end

local function drawLineShaderVerts(verts, fill)
	local mat = materials.line
	if not shadersActive() or not matOK(mat) then return false end

	setupLineConstants(mat, fill)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	drawTransformedPoly(verts)
	M.stats.draws = M.stats.draws + 1
	return true
end

local backdropBlurPreparedFrame = -1
local backdropBlurPreparedIntensity = 0
local backdropBlurPreparedLevel = nil

-- The raw capture is reused while intensity changes only rerun the separable
-- passes. A new level captures the framebuffer again so higher UI layers can
-- include content already drawn below them.
local function prepareBackdropBlur(amount, recapture, level)
	local frame = FrameNumber()
	local intensity = blurIntensity(amount)
	level = math_floor(tonumber(level) or 0)
	local sameFrame = backdropBlurPreparedFrame == frame
	local sameLevel = backdropBlurPreparedLevel == level
	if not recapture and sameFrame and sameLevel
		and math_abs(backdropBlurPreparedIntensity - intensity) < 0.0001 then
		M.stats.blurReuses = M.stats.blurReuses + 1
		return backdropBlurPreparedIntensity
	end

	local sw, sh = ScrW(), ScrH()
	local horizontalMat = materials.backdrop_blur_horizontal
	local verticalMat = materials.backdrop_blur_vertical
	local prevR, prevG, prevB = render_GetColorModulation()
	local prevBlend = render_GetBlend()
	local captureSource = recapture or not sameFrame or not sameLevel

	if captureSource then
		render_CopyRenderTargetToTexture(blurRT)
		M.stats.blurCaptures = M.stats.blurCaptures + 1
	end
	render_PushRenderTarget(backdropBlurHorizontalRT)
	render_SetScissorRect(0, 0, 0, 0, false)
	render_SetColorModulation(1, 1, 1)
	render_SetBlend(1)
	render_OverrideAlphaWriteEnable(true, true)
	render_OverrideBlend(true, BLEND_ONE, BLEND_ZERO, BLENDFUNC_ADD, BLEND_ONE, BLEND_ZERO, BLENDFUNC_ADD)
	setupBlurConstants(horizontalMat, sw, sh, false, intensity, 0)
	render_SetMaterial(horizontalMat)
	render_DrawScreenQuad()
	M.stats.draws = M.stats.draws + 1
	render_PopRenderTarget()

	render_PushRenderTarget(backdropBlurRT)
	setupBlurConstants(verticalMat, sw, sh, true, intensity, 0)
	render_SetMaterial(verticalMat)
	render_DrawScreenQuad()
	M.stats.draws = M.stats.draws + 1
	render_OverrideBlend(false)
	render_OverrideAlphaWriteEnable(false)
	render_SetColorModulation(prevR, prevG, prevB)
	render_SetBlend(prevBlend)
	render_PopRenderTarget()
	restoreScissor()

	backdropBlurPreparedFrame = frame
	backdropBlurPreparedIntensity = intensity
	backdropBlurPreparedLevel = level
	M.stats.blurPasses = M.stats.blurPasses + 2
	return intensity
end

local function drawBlurredQuad(mat, x, y, w, h, radius, amount, tint, recapture, level)
	prepareBackdropBlur(amount, recapture, level)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)

	if tint then
		setupAuxConstantsRaw(mat,
			(tint.r or 0) * inv255,
			(tint.g or 0) * inv255,
			(tint.b or 0) * inv255,
			(tint.a == nil and 255 or tint.a) * inv255,
			1, 0, 0, 0,
			0, 0, 0, 0,
			0, 0, 0, 0
		)
	else
		setupAuxConstantsRaw(mat,
			0, 0, 0, 0,
			0, 0, 0, 0,
			0, 0, 0, 0,
			0, 0, 0, 0
		)
	end
	setupBlurConstants(mat, w, h, true, 0, radius)
	drawTexturedQuad(x, y, w, h, mat)
end

local function drawBlurredCustomQuad(mat, x, y, w, h, amount, setup, recapture, level)
	prepareBackdropBlur(amount, recapture, level)
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	setup(mat, true, 0)
	drawTexturedQuad(x, y, w, h, mat)
end

local function drawBlurredPoly(poly, mat, amount, recapture, level)
	if not poly or not mat then return false end

	prepareBackdropBlur(amount, recapture, level)
	surface_SetDrawColor(255, 255, 255, 255)
	setupBlurConstants(mat, poly.w, poly.h, true, 0, 0)
	drawMaterialPoly(poly, mat)
	return true
end

local roundRectApi = assert(M._InstallRoundRect and M._InstallRoundRect({
	M = M,
	materials = materials,
	forceFallback = forceFallback,
	queueCommand = queueCommand,
	recordDirectImmediate = recordDirectImmediate,
	resolveDrawStyle = resolveDrawStyle,
	matOK = matOK,
	profiler = profiler,
	asColor = asColor,
	color01 = color01,
	setDrawColor = setDrawColor,
	strokeWidthValue = strokeWidthValue,
	strokeRaw = strokeRaw,
	strokeColor = strokeColor,
	strokeKind = strokeKind,
	STROKE_SOLID = STROKE_SOLID,
	STROKE_DOT = STROKE_DOT,
	STROKE_DASH = STROKE_DASH,
	STROKE_DOT_DASH = STROKE_DOT_DASH,
	radiusScalar = radiusScalar,
	fillFromStyle = fillFromStyle,
	fillVisible = fillVisible,
	strokeVisible = strokeVisible,
	backdropStyle = backdropStyle,
	defaultPatternColor = defaultPatternColor,
	defaultPatternTrueColor = defaultPatternTrueColor,
	defaultWornEdgeColor = defaultWornEdgeColor,
	glowSoftnessToFalloff = glowSoftnessToFalloff,
	FILL_SOLID = FILL_SOLID,
	FILL_LINEAR = FILL_LINEAR,
	FILL_RADIAL = FILL_RADIAL,
	FILL_CONIC = FILL_CONIC,
	isCulled = isCulled,
	normalizedRotation = normalizedRotation,
	bindGradientLut = bindGradientLut,
	setupParamMatrix = setupParamMatrix,
	setupParamMatrixRaw = setupParamMatrixRaw,
	setupConstants = setupConstants,
	setupExtraParams = setupExtraParams,
	setupExtraParamsRaw = setupAuxConstantsRaw,
	drawTexturedQuad = drawTexturedQuad,
	drawTexturedQuadUV = drawTexturedQuadUV,
	drawTransformedPoly = drawTransformedPoly,
	withTransform = withTransform,
	splitStyleTransform = splitStyleTransform,
	hasTransform = hasTransform,
	beginPanelEffectBleed = frameGeometryApi.beginPanelEffectBleed,
	beginPanelEffectDraw = frameGeometryApi.beginPanelEffectDraw,
	endPanelEffectBleed = frameGeometryApi.endPanelEffectBleed,
	withPanelEffectBleed = withPanelEffectBleed,
	drawBlurredQuad = drawBlurredQuad,
}), "MGFX roundrect module unavailable")
local drawRoundRectFallback = roundRectApi.drawRoundRectFallback
local drawStrokePath = roundRectApi.drawStrokePath
local patternStyle = roundRectApi.patternStyle
local patternOffset = roundRectApi.patternOffset
local setupPatternConstants = roundRectApi.setupPatternConstants
local drawRoundRectPattern = roundRectApi.drawRoundRectPattern
local drawRoundRectInnerGlow = roundRectApi.drawRoundRectInnerGlow
local drawRoundRectOuterGlow = roundRectApi.drawRoundRectOuterGlow
local drawRoundRectFillPass = roundRectApi.drawRoundRectFillPass
local drawRoundRectStrokePass = roundRectApi.drawRoundRectStrokePass
local drawRoundRectRaw = roundRectApi.drawRoundRectRaw
local drawRoundRectPrepared = roundRectApi.drawRoundRectPrepared
local drawRoundRectImmediate = roundRectApi.drawRoundRectImmediate
local roundRaw = roundRectApi.roundRaw
local glowBiasPads = roundRectApi.glowBiasPads

function M.CompileStyle(style, target)
	if style == nil then return nil end
	if not istable(style) then return nil end
	if style.r ~= nil and style.g ~= nil and style.b ~= nil then
		return resolveDrawStyle(style, target)
	end
	if style._mgfxCompiledStyle == true then return style end

	local normalized = resolveDrawStyle(style, target)
	local out = {}
	for key, value in pairs(normalized) do out[key] = value end
	if out.backdrop ~= nil and out.backdrop ~= false then
		out.backdrop = backdropStyle(out.backdrop)
	end
	if out.pattern ~= nil and out.pattern ~= false then
		out.pattern = patternStyle(out.pattern)
	end
	if out.fillPattern ~= nil and out.fillPattern ~= false then
		out.fillPattern = patternStyle(out.fillPattern)
	end
	if out.trackPattern ~= nil and out.trackPattern ~= false then
		out.trackPattern = patternStyle(out.trackPattern)
	end
	out._mgfxCompiledStyle = true
	return out
end
M._internal.drawRoundRectRaw = drawRoundRectRaw
M._internal.drawRoundRectPrepared = drawRoundRectPrepared
M._internal.drawRoundRectImmediate = drawRoundRectImmediate
M._internal.setupParamMatrix = setupParamMatrix
M._internal.setupParamMatrixRaw = setupParamMatrixRaw
M._internal.setupExtraParams = setupExtraParams
M._internal.setupExtraParamsRaw = setupAuxConstantsRaw
M._internal.roundRaw = roundRaw

local context = {
	M = M,
	materials = materials,
	forceFallback = forceFallback,
	profileEnabled = profileEnabled,
	drawCountsEnabled = drawCountsEnabled,
	profiler = profiler,
	clipStack = clipStack,
	frameState = frameState,
	commandState = commandState,
	commandApi = commandApi,
	acquireCommandStack = acquireCommandStack,
	releaseCommandStack = releaseCommandStack,
	acquireCommandObject = acquireCommandObject,
	queueCommand = queueCommand,
	queueTextRecord = queueTextRecord,
	queueTextBatch = queueTextBatch,
	recordDirectImmediate = recordDirectImmediate,
	copyStyle = copyStyle,
	resolveDrawStyle = resolveDrawStyle,
	targetCaps = capabilityApi.targetCaps,
	isPattern = capabilityApi.isPattern,
	isFill = capabilityApi.isFill,
	copyPoints = copyPoints,
	shaderVersion = shaderVersion,
	shaderMountName = shaderMountName,
	FILL_SOLID = FILL_SOLID,
	FILL_LINEAR = FILL_LINEAR,
	FILL_RADIAL = FILL_RADIAL,
	FILL_CONIC = FILL_CONIC,
	matOK = matOK,
	shadersActive = shadersActive,
	resetStats = resetStats,
	asColor = asColor,
	color01 = color01,
	setDrawColor = setDrawColor,
	strokeWidthValue = strokeWidthValue,
	strokeRaw = strokeRaw,
	strokeColor = strokeColor,
	strokeKind = strokeKind,
	STROKE_SOLID = STROKE_SOLID,
	STROKE_DOT = STROKE_DOT,
	STROKE_DASH = STROKE_DASH,
	STROKE_DOT_DASH = STROKE_DOT_DASH,
	radiusTuple = radiusTuple,
	radiusScalar = radiusScalar,
	normalizeStops = normalizeStops,
	firstLastStops = firstLastStops,
	lerpColor = lerpColor,
	colorAtStops = colorAtStops,
	colorAtFill = colorAtFill,
	normalizedRotation = normalizedRotation,
	gradientLutForFill = gradientLutForFill,
	bindGradientLut = bindGradientLut,
	glowSoftnessToFalloff = glowSoftnessToFalloff,
	strokeVisible = strokeVisible,
	backdropStyle = backdropStyle,
	defaultPatternColor = defaultPatternColor,
	defaultPatternTrueColor = defaultPatternTrueColor,
	defaultWornEdgeColor = defaultWornEdgeColor,
	imageMaskStyle = imageMaskStyle,
	fillFromStyle = fillFromStyle,
	fillVisible = fillVisible,
	isCulled = isCulled,
	setupParamMatrix = setupParamMatrix,
	setupConstants = setupConstants,
	setupExtraParams = setupExtraParams,
	setupBlurConstants = setupBlurConstants,
	blurIntensity = blurIntensity,
	drawTexturedQuad = drawTexturedQuad,
	drawTexturedQuadUV = drawTexturedQuadUV,
	withLocalScissor = withLocalScissor,
	withScreenScissorPixels = withScreenScissorPixels,
	beginPanelEffectBleed = frameGeometryApi.beginPanelEffectBleed,
	beginPanelEffectDraw = frameGeometryApi.beginPanelEffectDraw,
	endPanelEffectBleed = frameGeometryApi.endPanelEffectBleed,
	withPanelEffectBleed = withPanelEffectBleed,
	setupLineConstants = setupLineConstants,
	drawLineShaderVerts = drawLineShaderVerts,
	drawCreatedMaterialTexturedRectUV = drawCreatedMaterialTexturedRectUV,
	drawTransformedPoly = drawTransformedPoly,
	withTransform = withTransform,
	splitStyleTransform = splitStyleTransform,
	hasTransform = hasTransform,
	drawBlurredQuad = drawBlurredQuad,
	drawBlurredCustomQuad = drawBlurredCustomQuad,
	drawBlurredPoly = drawBlurredPoly,
	textureSize = textureSize,
	imageTint = imageTint,
	imageStyle = imageStyle,
	imageRadius = imageRadius,
	imageAlign = imageAlign,
	imageUV = imageUV,
	imageFitRect = imageFitRect,
	drawRoundRectFallback = drawRoundRectFallback,
	patternStyle = patternStyle,
	patternOffset = patternOffset,
	setupPatternConstants = setupPatternConstants,
	drawRoundRectPattern = drawRoundRectPattern,
	drawRoundRectInnerGlow = drawRoundRectInnerGlow,
	drawRoundRectOuterGlow = drawRoundRectOuterGlow,
	drawRoundRectFillPass = drawRoundRectFillPass,
	drawRoundRectStrokePass = drawRoundRectStrokePass,
	drawRoundRectRaw = drawRoundRectRaw,
	drawRoundRectPrepared = drawRoundRectPrepared,
	drawRoundRectImmediate = drawRoundRectImmediate,
	drawStrokePath = drawStrokePath,
	roundRaw = roundRaw,
	glowBiasPads = glowBiasPads,
	textureFallbackMaterial = textureFallbackMaterial,
	materialCache = materialCache,
	textRenderer = textRenderer,
	getRestoreScissor = function() return restoreScissor end,
	setRestoreScissor = function(fn) restoreScissor = fn end,
}

if type(M._InstallPrimitives) == "function" then
	M._InstallPrimitives(context)
else
	print("[MGFX] primitive module unavailable")
end

if type(M._InstallWidgets) == "function" then
	M._InstallWidgets(context)
else
	print("[MGFX] widget module unavailable")
end

if type(M._InstallFrame) == "function" then
	M._InstallFrame(context)
else
	print("[MGFX] frame module unavailable")
end

if profiler and profiler.InstallApiWrappers then
	profiler.InstallApiWrappers(M, {
		"RoundedBox",
		"RoundedBoxBackdrop",
		"RoundedBoxEx",
		"ChamferBox",
		"ChamferBoxEx",
		"RegularPoly",
		"RegularPolyEx",
		"Diamond",
		"DiamondEx",
		"Caret",
		"CaretEx",
		"Poly",
		"PolyEx",
		"Image",
		"ImageUV",
		"ImageEx",
		"Icon",
		"IconEx",
		"Text",
		"TextEx",
		"TextBatchEx",
		"TextBox",
		"TextBoxEx",
		"ProgressBar",
		"ProgressBarEx",
		"SegmentBar",
		"SegmentBarEx",
		"Line",
		"LineNoCaps",
		"LineEx",
		"Ring",
		"RingEx",
		"Arc",
		"ArcEx",
		"Circle",
		"CircleEx",
		"Capsule",
		"CapsuleEx",
		"StartPanel",
		"EndPanel",
		"StartScreen",
		"EndScreen",
		"PushClip",
		"PopClip",
		"Solid",
		"LinearGradient",
		"LinearGradientStops",
		"RadialGradient",
		"RingRadialGradient",
		"SectorRadialGradient",
		"ConicGradient",
		"ShapeAngularGradient",
		"RingAngularGradient",
		"ArcAngularGradient",
		"SectorAngularGradient",
		"StripePattern",
		"SmokePattern",
		"WornPattern",
		"Mask",
		"Backdrop",
		"CompileBackdrop",
		"CompileStyle",
		"ImageMaskStyle",
		"BackdropStyle",
		"FillFromStyle",
		"ColorAtFill",
		"NormalizedRotation",
		"GlowSoftnessToFalloff",
		"GradientLutForFill",
		"BindGradientLut",
		"GradientLutStatus",
		"GetCapabilities",
		"Supports",
		"NormalizeStyle",
		"Transform",
		"ProjectedQuad",
		"PointerTilt",
		"PushTransform",
		"PopTransform",
		"TransformPoint",
		"UntransformPoint",
		"RegisterTextFont",
		"DefineTextStyle",
		"GetTextStyle",
		"ResolveTextStyle",
		"MeasureText",
		"MeasureTextBox",
		"PrewarmText",
		"DebugOverlay",
	}, function()
		return commandState and commandState.replaying == true
	end)
end

if type(M._InstallConsole) == "function" then
	M._InstallConsole(context)
else
	print("[MGFX] console module unavailable")
end
