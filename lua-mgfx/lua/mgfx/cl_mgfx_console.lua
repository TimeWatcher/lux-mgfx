if SERVER then return end

MGFX = MGFX or {}

function MGFX._InstallConsole(C)
	local M = C.M
	local materials = C.materials
	local matOK = C.matOK
	local shaderVersion = C.shaderVersion
	local forceFallback = C.forceFallback
	local drawCountsEnabled = C.drawCountsEnabled
	local drawTexturedQuad = C.drawTexturedQuad
	local textRenderer = C.textRenderer
	local profiler = C.profiler
	local math_min = math.min
	local math_sin = math.sin
	local addCommand = M._AddCommand or concommand.Add
	local surface_SetDrawColor = surface.SetDrawColor
	local surface_SetMaterial = surface.SetMaterial

	local function reloadMGFX()
		local basePath = M._BasePath or "mgfx/"
		local files = {
			basePath .. "cl_mgfx_shaderpack.lua",
			basePath .. "cl_mgfx.lua",
		}
		local demoCvar = GetConVar("mgfx_enable_demos")
		if (demoCvar and demoCvar:GetBool()) or MGFX_INCLUDE_DEMOS == true then
			files[#files + 1] = basePath .. "cl_mgfx_demo.lua"
			files[#files + 1] = basePath .. "cl_mgfx_wheel_demo.lua"
		end

		print("[MGFX] reload begin")
		for _, path in ipairs(files) do
			local ok, err = pcall(include, path)
			if not ok then
				print("[MGFX] reload failed: " .. tostring(path) .. ": " .. tostring(err))
				return
			end
		end

		local status = MGFX and MGFX.shaderStatus and MGFX.shaderStatus()
		print("[MGFX] reload end version=" .. tostring(status and status.version) .. " shaders=" .. tostring(status and status.loaded))
	end

addCommand("mgfx_reload", reloadMGFX)
addCommand("mgfx_hot_reload", reloadMGFX)

addCommand("mgfx_status", function()
	local status = M.shaderStatus()
	local function countsLine(label, counts)
		local parts = {}
		for key, value in pairs(counts or {}) do
			if value and value ~= 0 then
				parts[#parts + 1] = tostring(key) .. "=" .. tostring(value)
			end
		end
		table.sort(parts)
		print("[MGFX] " .. label .. ": " .. (#parts > 0 and table.concat(parts, " ") or "none"))
	end

	print("[MGFX] shaders: " .. (status.loaded and "loaded" or "fallback"))
	print("[MGFX] version: " .. tostring(status.version))
	print("[MGFX] mount: " .. tostring(status.mount))
	print("[MGFX] force fallback: " .. tostring(forceFallback:GetBool()))
	print("[MGFX] draw counts: " .. tostring(drawCountsEnabled and drawCountsEnabled:GetBool() or false))
	print("[MGFX] stats draws=" .. tostring(M.stats.draws) .. " blur=" .. tostring(M.stats.blurPasses or 0) .. " fallback=" .. tostring(M.stats.fallbacks or 0) .. " culled=" .. tostring(M.stats.culled or 0))
	print("[MGFX] gradient LUT fill-cache hits=" .. tostring(M.stats.gradientLutFillHits or 0))
	countsLine("draw commands", M.stats.drawCommandCounts)
	countsLine("immediate draws", M.stats.drawImmediateCounts)
	countsLine("profile ms", M.stats.profileTimes)
	print("[MGFX] text draws=" .. tostring(M.stats.textDraws or 0) .. " native=" .. tostring(M.stats.textNativeDraws or 0) .. " composed=" .. tostring(M.stats.textShaderDraws or 0) .. " bakes=" .. tostring(M.stats.textComposedBakes or 0) .. " blits=" .. tostring(M.stats.textComposedBlits or 0) .. " batchDraws=" .. tostring(M.stats.textComposedBatchDraws or 0) .. " batchedRecords=" .. tostring(M.stats.textComposedBatchedRecords or 0) .. " entries=" .. tostring(M.stats.textComposedEntries or 0) .. " evicts=" .. tostring(M.stats.textComposedEvicts or 0) .. " fallback=" .. tostring(M.stats.textFallbacks or 0) .. " measure hit/miss=" .. tostring(M.stats.textMeasureHits or 0) .. "/" .. tostring(M.stats.textMeasureMisses or 0))
	local textStatus = textRenderer and textRenderer.Status and textRenderer.Status()
	if textStatus then
		print("[MGFX] text composer: enabled=" .. tostring(textStatus.composedEnabled) .. " aliases=" .. tostring(textStatus.fontCount) .. " cache=" .. tostring(textStatus.cacheSize) .. " entries=" .. tostring(textStatus.composedEntries) .. " atlas=" .. tostring(textStatus.composedAtlasW) .. "x" .. tostring(textStatus.composedAtlasH) .. " styles=" .. tostring(textStatus.styleCount) .. " stack=" .. tostring(textStatus.styleStackDepth) .. " failed=" .. tostring(textStatus.composedFailed))
	end
	print("[MGFX] roundrect material: " .. tostring(status.roundrect))
	print("[MGFX] roundrect fx material: " .. tostring(status.roundrectFx))
	print("[MGFX] roundrect solid material: " .. tostring(status.roundrectSolid))
	print("[MGFX] roundrect stroke material: " .. tostring(status.roundrectStroke))
	print("[MGFX] param probe material: " .. tostring(status.paramProbe))
	print("[MGFX] blur material: " .. tostring(status.blur))
	print("[MGFX] chamfer material: " .. tostring(status.chamfer))
	print("[MGFX] chamfer image material: " .. tostring(status.chamferImage))
	print("[MGFX] image mask material: " .. tostring(status.imageMask))
	print("[MGFX] image mask outerglow material: " .. tostring(status.imageMaskOuterGlow))
	print("[MGFX] chamfer stroke material: " .. tostring(status.chamferStroke))
	print("[MGFX] inner glow material: " .. tostring(status.innerGlow))
	print("[MGFX] chamfer inner glow material: " .. tostring(status.chamferInnerGlow))
	print("[MGFX] outer glow material: " .. tostring(status.outerGlow))
	print("[MGFX] chamfer outer glow material: " .. tostring(status.chamferOuterGlow))
	print("[MGFX] progress fx material: " .. tostring(status.progressFx))
	print("[MGFX] segmentbar material: " .. tostring(status.segmentbar))
	print("[MGFX] line material: " .. tostring(status.line))
	print("[MGFX] text compose material: " .. tostring(status.textCompose))
	print("[MGFX] pattern material: " .. tostring(status.pattern))
	print("[MGFX] chamfer pattern material: " .. tostring(status.chamferPattern))
	print("[MGFX] poly pattern material: " .. tostring(status.polyPattern))
	print("[MGFX] ring material: " .. tostring(status.ring))
	print("[MGFX] ring fx material: " .. tostring(status.ringFx))
	print("[MGFX] ring stroke material: " .. tostring(status.ringStroke))
	print("[MGFX] ring inner glow material: " .. tostring(status.ringInnerGlow))
	print("[MGFX] ring outer glow material: " .. tostring(status.ringOuterGlow))
	print("[MGFX] ring pattern material: " .. tostring(status.ringPattern))
	print("[MGFX] poly stroke material: " .. tostring(status.polyStroke))
end)

local paramProbeOn = false
local paramProbeMatrix = Matrix and Matrix() or nil
local matrixSetUnpacked = paramProbeMatrix and paramProbeMatrix.SetUnpacked or nil

local function setupParamProbeMatrix(mat, columnPacked)
	if not matOK(mat) or not paramProbeMatrix or not matrixSetUnpacked then return false end

	local pulse = math_sin(RealTime() * 2.2) * 0.2 + 0.2
	if columnPacked then
		matrixSetUnpacked(paramProbeMatrix,
			1.0, 0.05, 0.05, 1.0,
			0.05, 1.0, 0.05, 1.0,
			0.05, 0.05, 1.0, pulse,
			1.0, 1.0, 1.0, 1.0
		)
	else
		matrixSetUnpacked(paramProbeMatrix,
			1.0, 0.05, 0.05, 1.0,
			0.05, 1.0, 0.05, 1.0,
			0.05, 0.05, 1.0, 1.0,
			1.0, 1.0, pulse, 1.0
		)
	end
	mat:SetMatrix("$viewprojmat", paramProbeMatrix)
	return true
end

local function drawParamProbeBlock(mat, x, y, w, h, columnPacked)
	if not setupParamProbeMatrix(mat, columnPacked) then return false end
	surface_SetMaterial(mat)
	surface_SetDrawColor(255, 255, 255, 255)
	if drawTexturedQuad then
		drawTexturedQuad(x, y, w, h)
	else
		surface.DrawTexturedRectUV(x, y, w, h, -0.015625, -0.015625, 1.015625, 1.015625)
	end
	return true
end

local function drawParamProbe()
	local mat = materials.param_probe
	local x, y, w, h = 42, 128, 360, 76
	if not matOK(mat) or not paramProbeMatrix or not matrixSetUnpacked then
		draw.SimpleText("MGFX param probe unavailable", "DermaDefaultBold", x, y, Color(255, 90, 90))
		return
	end

	draw.SimpleText("row-packed control: expected to match the old screenshot", "DermaDefaultBold", x, y - 16, color_white)
	drawParamProbeBlock(mat, x, y, w, h, false)

	local y2 = y + h + 42
	draw.SimpleText("column-packed candidate: expected red / green / blue / yellow", "DermaDefaultBold", x, y2 - 16, color_white)
	drawParamProbeBlock(mat, x, y2, w, h, true)
	draw.SimpleText("if the lower block is correct, Matrix:SetUnpacked reaches HLSL matrix[n] by columns", "DermaDefault", x, y2 + h + 6, Color(210, 230, 240))
end

addCommand("mgfx_param_probe", function()
	paramProbeOn = not paramProbeOn
	hook.Remove("HUDPaint", "MGFXParamProbe")
	if paramProbeOn then
		hook.Add("HUDPaint", "MGFXParamProbe", drawParamProbe)
		print("[MGFX] param probe ON: compare row-packed control with column-packed candidate")
	else
		print("[MGFX] param probe OFF")
	end
end)

local paramBenchMatrix = Matrix and Matrix() or nil
local paramBenchSetUnpacked = paramBenchMatrix and paramBenchMatrix.SetUnpacked or nil
local paramBenchTimer = "MGFXParamBench"

local function printBenchResult(name, iterations, elapsedMs, emptyMs, sink)
	local netMs = math.max(0, elapsedMs - (emptyMs or 0))
	print(string.format("[MGFX] param bench %-26s raw=%8.3fms net=%8.3fms %.3fus/iter sink=%.3f",
		name, elapsedMs, netMs, netMs * 1000 / math.max(1, iterations), sink))
end

local function runParamBenchSlice(test, mat, matrix, setUnpacked, first, last)
	local sink = 0
	if test == "empty" then
		for i = first, last do
			local v = (i % 1024) * 0.0009765625
			sink = sink + v
		end
	elseif test == "SetFloat x8" then
		for i = first, last do
			local v = (i % 1024) * 0.0009765625
			mat:SetFloat("$c0_x", v)
			mat:SetFloat("$c0_y", v + 0.01)
			mat:SetFloat("$c0_z", v + 0.02)
			mat:SetFloat("$c0_w", v + 0.03)
			mat:SetFloat("$c1_x", v + 0.04)
			mat:SetFloat("$c1_y", v + 0.05)
			mat:SetFloat("$c1_z", v + 0.06)
			mat:SetFloat("$c1_w", v + 0.07)
			sink = sink + v
		end
	elseif test == "SetFloat x16" then
		for i = first, last do
			local v = (i % 1024) * 0.0009765625
			mat:SetFloat("$c0_x", v)
			mat:SetFloat("$c0_y", v + 0.01)
			mat:SetFloat("$c0_z", v + 0.02)
			mat:SetFloat("$c0_w", v + 0.03)
			mat:SetFloat("$c1_x", v + 0.04)
			mat:SetFloat("$c1_y", v + 0.05)
			mat:SetFloat("$c1_z", v + 0.06)
			mat:SetFloat("$c1_w", v + 0.07)
			mat:SetFloat("$c2_x", v + 0.08)
			mat:SetFloat("$c2_y", v + 0.09)
			mat:SetFloat("$c2_z", v + 0.10)
			mat:SetFloat("$c2_w", v + 0.11)
			mat:SetFloat("$c3_x", v + 0.12)
			mat:SetFloat("$c3_y", v + 0.13)
			mat:SetFloat("$c3_z", v + 0.14)
			mat:SetFloat("$c3_w", v + 0.15)
			sink = sink + v
		end
	elseif test == "SetUnpacked only" then
		for i = first, last do
			local v = (i % 1024) * 0.0009765625
			setUnpacked(matrix,
				v, v + 0.04, v + 0.08, v + 0.12,
				v + 0.01, v + 0.05, v + 0.09, v + 0.13,
				v + 0.02, v + 0.06, v + 0.10, v + 0.14,
				v + 0.03, v + 0.07, v + 0.11, v + 0.15
			)
			sink = sink + v
		end
	elseif test == "SetMatrix only" then
		for i = first, last do
			local v = (i % 1024) * 0.0009765625
			mat:SetMatrix("$viewprojmat", matrix)
			sink = sink + v
		end
	elseif test == "SetUnpacked + SetMatrix" then
		for i = first, last do
			local v = (i % 1024) * 0.0009765625
			setUnpacked(matrix,
				v, v + 0.04, v + 0.08, v + 0.12,
				v + 0.01, v + 0.05, v + 0.09, v + 0.13,
				v + 0.02, v + 0.06, v + 0.10, v + 0.14,
				v + 0.03, v + 0.07, v + 0.11, v + 0.15
			)
			mat:SetMatrix("$viewprojmat", matrix)
			sink = sink + v
		end
	end
	return sink
end

addCommand("mgfx_param_bench_stop", function()
	timer.Remove(paramBenchTimer)
	print("[MGFX] param bench stopped")
end)

addCommand("mgfx_param_bench", function(_, _, args)
	local mat = materials.param_probe or materials.roundrect
	if not matOK(mat) then
		print("[MGFX] param bench unavailable: material error")
		return
	end

	local iterations = math.Clamp(tonumber(args and args[1]) or 3000, 250, 10000)
	local roundCount = math.Clamp(tonumber(args and args[2]) or 2, 1, 5)
	local batchSize = math.Clamp(tonumber(args and args[3]) or 100, 10, 250)
	local matrix = paramBenchMatrix
	local setUnpacked = paramBenchSetUnpacked
	if not matrix or not setUnpacked then
		print("[MGFX] param bench unavailable: Matrix:SetUnpacked missing")
		return
	end

	timer.Remove(paramBenchTimer)

	local tests = {
		"empty",
		"SetFloat x8",
		"SetFloat x16",
		"SetUnpacked only",
		"SetMatrix only",
		"SetUnpacked + SetMatrix"
	}
	local state = {
		round = 1,
		testIndex = 1,
		iter = 1,
		elapsedMs = 0,
		emptyMs = 0,
		sink = 0
	}

	print(string.format("[MGFX] param bench begin iterations=%d rounds=%d batch=%d material=%s", iterations, roundCount, batchSize, tostring(mat)))
	print("[MGFX] param bench note: sliced across frames; use mgfx_param_bench_stop to cancel.")

	timer.Create(paramBenchTimer, 0, 0, function()
		local testName = tests[state.testIndex]
		if not testName then
			print("[MGFX] param bench end")
			timer.Remove(paramBenchTimer)
			return
		end

		local last = math.min(iterations, state.iter + batchSize - 1)
		local started = SysTime()
		state.sink = state.sink + runParamBenchSlice(testName, mat, matrix, setUnpacked, state.iter, last)
		state.elapsedMs = state.elapsedMs + (SysTime() - started) * 1000
		state.iter = last + 1

		if state.iter <= iterations then return end

		if testName == "empty" then
			state.emptyMs = state.elapsedMs
			printBenchResult(testName, iterations, state.elapsedMs, 0, state.sink)
		else
			printBenchResult(testName, iterations, state.elapsedMs, state.emptyMs, state.sink)
		end

		state.testIndex = state.testIndex + 1
		state.iter = 1
		state.elapsedMs = 0
		state.sink = 0

		if state.testIndex > #tests then
			state.round = state.round + 1
			if state.round > roundCount then
				print("[MGFX] param bench end")
				timer.Remove(paramBenchTimer)
				return
			end
			state.testIndex = 1
			state.emptyMs = 0
			print(string.format("[MGFX] param bench round %d/%d", state.round, roundCount))
		end
	end)
end)

local function printProfileRows(label, rows, rollingRows)
	print("[MGFX] " .. label)
	if not rows or #rows == 0 then
		print("[MGFX]   none")
		return
	end

	local formatted = profiler and profiler.FormatRows and profiler.FormatRows(rows, rollingRows) or {}
	for _, line in ipairs(formatted) do
		print("[MGFX]   " .. line)
	end
end

addCommand("mgfx_profile_status", function()
	local enabled = GetConVar("mgfx_profile")
	local window = GetConVar("mgfx_profile_window")
	local top = GetConVar("mgfx_profile_top")
	print("[MGFX] profiler enabled=" .. tostring(enabled and enabled:GetBool() or false)
		.. " window=" .. tostring(window and window:GetInt() or "n/a")
		.. " top=" .. tostring(top and top:GetInt() or "n/a"))

	if not profiler then
		print("[MGFX] profiler unavailable")
		return
	end

	printProfileRows("profile current", profiler.CurrentRows and profiler.CurrentRows() or nil, false)
	printProfileRows("profile rolling", profiler.Snapshot and profiler.Snapshot() or nil, true)
end)

addCommand("mgfx_profile_reset", function()
	if profiler and profiler.Reset then profiler.Reset() end
	print("[MGFX] profiler reset")
end)

addCommand("mgfx_text_status", function()
	local textStatus = textRenderer and textRenderer.Status and textRenderer.Status()
	print("[MGFX] text draws=" .. tostring(M.stats.textDraws or 0) .. " native=" .. tostring(M.stats.textNativeDraws or 0) .. " composedDraws=" .. tostring(M.stats.textComposedDraws or 0) .. " face=" .. tostring(M.stats.textComposedFaceDraws or 0) .. " fx=" .. tostring(M.stats.textComposedFxDraws or 0) .. " bakes=" .. tostring(M.stats.textComposedBakes or 0) .. " blits=" .. tostring(M.stats.textComposedBlits or 0) .. " entries=" .. tostring(M.stats.textComposedEntries or 0) .. " evicts=" .. tostring(M.stats.textComposedEvicts or 0) .. " fallback=" .. tostring(M.stats.textFallbacks or 0))
	print("[MGFX] text queued batches=" .. tostring(M.stats.textQueuedBatches or 0) .. " records=" .. tostring(M.stats.textQueuedRecords or 0))
	print("[MGFX] text batch draws=" .. tostring(M.stats.textComposedBatchDraws or 0) .. " records=" .. tostring(M.stats.textComposedBatchedRecords or 0))
	print("[MGFX] text composer route requests=" .. tostring(M.stats.textComposedRequests or 0) .. " batches=" .. tostring(M.stats.textComposedBatches or 0) .. " readyBatches=" .. tostring(M.stats.textComposedReadyBatches or 0) .. " fallbackBatches=" .. tostring(M.stats.textComposedFallbackBatches or 0) .. " fallbackRecords=" .. tostring(M.stats.textComposedFallbackRecords or 0) .. " prewarmFails=" .. tostring(M.stats.textComposedPrewarmFails or 0) .. " prewarmRestarts=" .. tostring(M.stats.textComposedPrewarmRestarts or 0))
	print("[MGFX] text entry cache hit/miss=" .. tostring(M.stats.textEntryCacheHits or 0) .. "/" .. tostring(M.stats.textEntryCacheMisses or 0))
	print("[MGFX] text measure hit/miss=" .. tostring(M.stats.textMeasureHits or 0) .. "/" .. tostring(M.stats.textMeasureMisses or 0) .. " cache=" .. tostring(M.stats.textCacheSize or 0))
	if textStatus then
		local fillPct = math.floor((tonumber(textStatus.composedAtlasFill) or 0) * 100 + 0.5)
		print("[MGFX] text composer enabled=" .. tostring(textStatus.composedEnabled) .. " aliases=" .. tostring(textStatus.fontCount) .. " atlas=" .. tostring(textStatus.composedAtlasW) .. "x" .. tostring(textStatus.composedAtlasH) .. " pages=" .. tostring(textStatus.composedAtlasPages or 0) .. "/" .. tostring(textStatus.composedAtlasMaxPages or 0) .. " fill=" .. tostring(fillPct) .. "% entries=" .. tostring(textStatus.composedEntries) .. " styles=" .. tostring(textStatus.styleCount) .. " stack=" .. tostring(textStatus.styleStackDepth) .. " failed=" .. tostring(textStatus.composedFailed))
	else
		print("[MGFX] text renderer unavailable")
	end
end)

addCommand("mgfx_text_cache_clear", function()
	if textRenderer and textRenderer.ClearMeasureCache then textRenderer.ClearMeasureCache() end
	print("[MGFX] text measure cache cleared")
end)

addCommand("mgfx_text_composed_clear", function()
	local ok = textRenderer and textRenderer.ClearComposedCache and textRenderer.ClearComposedCache()
	print("[MGFX] text composer cache clear: " .. tostring(ok == true))
end)

local atlasDebugOn = false
addCommand("mgfx_text_atlas", function()
	atlasDebugOn = not atlasDebugOn
	hook.Remove("HUDPaint", "MGFXTextAtlasDebug")
	if atlasDebugOn and textRenderer and textRenderer.DebugDrawAtlas then
		hook.Add("HUDPaint", "MGFXTextAtlasDebug", function()
			textRenderer.DebugDrawAtlas()
		end)
		print("[MGFX] atlas debug overlay ON (run again to hide)")
	else
		print("[MGFX] atlas debug overlay OFF")
	end
end)

-- Self-contained reproduction: hammers the batched->prewarmed FX composer path
-- with many changing numbers per frame so
-- fresh-bake blanks surface on demand, no scoreboard needed. Pair with
-- mgfx_text_atlas to see whether a blank cell's atlas slot is empty (bake failed)
-- or populated (blit failed).
local stressOn = false
addCommand("mgfx_text_stress", function()
	stressOn = not stressOn
	hook.Remove("HUDPaint", "MGFXTextStress")
	if not stressOn then
		print("[MGFX] text stress OFF")
		return
	end
	if M.RegisterTextFont then
		M.RegisterTextFont("MGFXStressNum", {face = "Bahnschrift", size = 40, weight = 900, lineHeight = 48})
	end
	local style = {
		stroke = {width = 1, color = Color(0, 0, 0, 190), samples = 10},
		shadow = {x = 1, y = 1, blur = 2, color = Color(0, 0, 0, 150)},
	}
	local cols, rows, cw, ch, x0, y0 = 8, 5, 168, 76, 40, 150
	hook.Add("HUDPaint", "MGFXTextStress", function()
		local fc = (FrameNumber and FrameNumber()) or math.floor(SysTime() * 60)
		for i = 0, cols * rows - 1 do
			local cx = x0 + (i % cols) * cw
			local cy = y0 + math.floor(i / cols) * ch
			surface.SetDrawColor(18, 22, 28, 235)
			surface.DrawRect(cx, cy, cw - 6, ch - 6)
			surface.SetDrawColor(60, 70, 84, 255)
			surface.DrawOutlinedRect(cx, cy, cw - 6, ch - 6)
		end
		if M.StartScreen then M.StartScreen(ScrW(), ScrH()) end
		for i = 0, cols * rows - 1 do
			local v = string.format("%02d:%02d", (fc + i * 7) % 100, (fc * (i + 1)) % 100)
			local cx = x0 + (i % cols) * cw + (cw - 6) * 0.5
			local cy = y0 + math.floor(i / cols) * ch + (ch - 6) * 0.5
			if M.TextEx then
				M.TextEx(v, "MGFXStressNum", cx, cy, Color(130, 230, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, style)
			end
		end
		if M.EndScreen then M.EndScreen() end
		draw.SimpleText("MGFX stress: " .. (cols * rows) .. " changing FX-composed numbers/frame -- watch for BLANK cells (toggle mgfx_text_atlas to inspect slots)", "DermaDefaultBold", x0, y0 - 18, Color(255, 220, 120))
	end)
	print("[MGFX] text stress ON (run again to hide)")
end)

hook.Remove("HUDPaint", "MGFXTextDemo")
local textDemoEnabled = false
local textDemoFontsReady = false
local textDemoFx = CreateClientConVar("mgfx_text_demo_fx", "1", true, false, "MGFX text demo effect intensity.")
local TEXT_DEMO_CJK_FACE = "Noto Sans SC"
M._internal.TextDemoStrings = {
	{"MGFX TEXT FX", "MGFXTextDemoTitle"},
	{"gradient face / outline / glow / shadow / numeric / cjk", "MGFXTextDemoSmall"},
	{"OUTLINE 128,450 中文描边", "MGFXTextDemoCJK"},
	{"GLOW 外发光 soft halo", "MGFXTextDemoCJK"},
	{"SHADOW 软阴影不走整段文字 RT", "MGFXTextDemoCJK"},
	{"FACE polish Aa 123 中文正常", "MGFXTextDemoCJK"},
	{"SOLID clean fill 中文纯色 Aa123", "MGFXTextDemoCJK"},
	{"128,450  +100 XP", "MGFXTextDemoNum"},
	{"Bold  Thin  Italic  Slanted", "MGFXTextDemoBody"},
	{"TextBox: 自动测量、ellipsis、矩形锚定，表格和栏位不再手写每个字符 baseline。", "MGFXTextDemoSmall"},
}
local function ensureTextDemoFonts()
	if textDemoFontsReady or not M.RegisterTextFont then return end
	surface.CreateFont("MGFXTextDemoNativeCJK", {
		font = TEXT_DEMO_CJK_FACE,
		size = 18,
		weight = 400,
		antialias = true,
		extended = true,
	})
	local ok = true
	ok = M.RegisterTextFont("MGFXTextDemoTitle", {face = "Bahnschrift", size = 34, weight = 650, lineHeight = 42}) and ok
	ok = M.RegisterTextFont("MGFXTextDemoBody", {face = "Bahnschrift", size = 18, weight = 520, lineHeight = 24}) and ok
	ok = M.RegisterTextFont("MGFXTextDemoSmall", {face = TEXT_DEMO_CJK_FACE, size = 15, weight = 400, lineHeight = 22}) and ok
	ok = M.RegisterTextFont("MGFXTextDemoCJK", {face = TEXT_DEMO_CJK_FACE, size = 18, weight = 400, lineHeight = 26}) and ok
	ok = M.RegisterTextFont("MGFXTextDemoNum", {face = "Bahnschrift", size = 26, weight = 700, lineHeight = 32}) and ok
	textDemoFontsReady = ok
end

local function drawTextDemo()
	ensureTextDemoFonts()
	local sw, sh = ScrW(), ScrH()
	local strong = textDemoFx:GetBool()
	local glowW = strong and 7 or 4
	local strokeW = strong and 1.05 or 0.8
	local panelW = math_min(840, sw - 96)
	M.StartScreen(sw, sh)
	M.RoundedBoxEx(48, 48, panelW, 430, {
		radius = 10,
		fill = Color(4, 14, 20, 220),
		stroke = Color(90, 190, 255, 60),
		strokeWidth = 1,
		innerGlow = {color = Color(80, 200, 255, 24), size = 16, opacity = 0.5},
	})
	M.TextEx("MGFX TEXT FX", "MGFXTextDemoTitle", 76, 83, nil, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, {
		fill = M.LinearGradient(0, 0, 1, 0, {
			{0, Color(104, 210, 255, 255)},
			{0.55, Color(238, 248, 255, 255)},
			{1, Color(255, 204, 112, 255)},
		}),
		stroke = {width = 0.9, softness = 0.55, color = Color(2, 9, 12, 185)},
		shadow = {x = 0, y = 2, blur = 5, color = Color(0, 0, 0, 145)},
		glow = {size = glowW, color = Color(66, 188, 255, 64), opacity = 0.58, softness = 0.56},
		surface = {strength = 0.14},
	})
	M.TextEx("gradient face / outline / glow / shadow / numeric / cjk", "MGFXTextDemoSmall", 78, 116, Color(178, 204, 214), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, {
		shadow = {x = 0, y = 1, blur = 2, color = Color(0, 0, 0, 110)},
	})

	M.TextEx("OUTLINE", "MGFXTextDemoBody", 78, 160, Color(238, 246, 252), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, {
		stroke = {width = strokeW, softness = 0.58, color = Color(0, 0, 0, 178)},
		shadow = {x = 0, y = 2, blur = 4, color = Color(0, 0, 0, 125)},
	})
	M.TextEx("128,450 中文描边", "MGFXTextDemoCJK", 178, 160, Color(246, 250, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, {
		stroke = {width = strokeW, softness = 0.62, color = Color(0, 0, 0, 164)},
		shadow = {x = 0, y = 2, blur = 4, color = Color(0, 0, 0, 115)},
	})

	M.TextEx("GLOW", "MGFXTextDemoBody", 78, 204, Color(205, 244, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, {
		stroke = {width = 0.65, softness = 0.58, color = Color(2, 10, 16, 142)},
		glow = {size = glowW + 1, color = Color(70, 205, 255, 88), opacity = 0.72, softness = 0.62},
		surface = {strength = 0.08},
	})
	M.TextEx("外发光 / soft halo", "MGFXTextDemoCJK", 178, 204, Color(211, 245, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, {
		stroke = {width = 0.65, softness = 0.60, color = Color(2, 10, 16, 136)},
		glow = {size = glowW + 1, color = Color(70, 205, 255, 86), opacity = 0.70, softness = 0.62},
		surface = {strength = 0.06},
	})

	M.TextEx("SHADOW", "MGFXTextDemoBody", 78, 248, Color(255, 222, 166), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, {
		shadow = {x = 4, y = 5, blur = 8, color = Color(0, 0, 0, 175)},
		stroke = {width = 0.55, softness = 0.65, color = Color(46, 24, 2, 110)},
	})
	M.TextEx("软阴影不走整段文字 RT", "MGFXTextDemoCJK", 178, 248, Color(255, 224, 178), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, {
		shadow = {x = 4, y = 5, blur = 8, color = Color(0, 0, 0, 165)},
		stroke = {width = 0.55, softness = 0.65, color = Color(46, 24, 2, 105)},
	})

	M.TextEx("FACE", "MGFXTextDemoBody", 78, 292, Color(232, 240, 245), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, {
		stroke = {width = 0.55, softness = 0.64, color = Color(0, 0, 0, 108)},
		surface = {strength = 0.16},
		shadow = {x = 0, y = 2, blur = 4, color = Color(0, 0, 0, 105)},
	})
	M.TextEx("polish Aa 123 中文正常", "MGFXTextDemoCJK", 178, 292, Color(232, 242, 246), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, {
		stroke = {width = 0.50, softness = 0.66, color = Color(0, 0, 0, 96)},
		surface = {strength = 0.08},
		shadow = {x = 0, y = 2, blur = 4, color = Color(0, 0, 0, 100)},
	})

	M.TextEx("SOLID", "MGFXTextDemoBody", 78, 326, Color(232, 238, 242), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	M.TextEx("clean fill 中文纯色 Aa123", "MGFXTextDemoCJK", 178, 326, Color(232, 238, 242), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	M.TextEx("NATIVE", "MGFXTextDemoBody", 78, 354, Color(190, 222, 230), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	M.TextEx("plain TextEx route 中文 Aa123", "MGFXTextDemoCJK", 178, 354, Color(220, 238, 240), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

	M.TextEx("128,450", "MGFXTextDemoNum", 514, 160, Color(232, 248, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, {
		stroke = {width = 0.65, softness = 0.58, color = Color(0, 0, 0, 148)},
		glow = {size = 5, color = Color(66, 190, 255, 44), opacity = 0.55, softness = 0.5},
		shadow = {x = 0, y = 2, blur = 5, color = Color(0, 0, 0, 135)},
		surface = {strength = 0.12},
	})
	M.TextEx("+100 XP", "MGFXTextDemoNum", 514, 194, Color(178, 221, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, {
		stroke = {width = 0.55, softness = 0.60, color = Color(0, 0, 0, 130)},
		shadow = {x = 0, y = 2, blur = 4, color = Color(0, 0, 0, 120)},
	})

	M.TextEx("Bold", "MGFXTextDemoBody", 514, 246, Color(238, 245, 249), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, {
		bold = true,
		stroke = {width = 0.50, softness = 0.62, color = Color(0, 0, 0, 105)},
		shadow = {x = 0, y = 2, blur = 4, color = Color(0, 0, 0, 110)},
	})
	M.TextEx("Thin", "MGFXTextDemoBody", 594, 246, Color(190, 228, 238), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, {
		thin = true,
		stroke = {width = 0.30, softness = 0.68, color = Color(0, 0, 0, 72)},
		shadow = {x = 0, y = 1, blur = 3, color = Color(0, 0, 0, 85)},
	})
	M.TextEx("Italic", "MGFXTextDemoBody", 664, 246, Color(238, 245, 249), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, {
		italic = true,
		stroke = {width = 0.42, softness = 0.64, color = Color(0, 0, 0, 96)},
		shadow = {x = 0, y = 2, blur = 4, color = Color(0, 0, 0, 105)},
	})

	M.TextEx("bold / thin 中文", "MGFXTextDemoSmall", 514, 292, Color(178, 222, 234), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, {
		bold = true,
		stroke = {width = 0.22, softness = 0.70, color = Color(0, 0, 0, 60)},
		glow = {size = 3, color = Color(90, 210, 255, 38), opacity = 0.42, softness = 0.46},
		shadow = {x = 0, y = 1, blur = 3, color = Color(0, 0, 0, 78)},
	})

	M.TextBoxEx("TextBox: 自动测量、ellipsis、矩形锚定，表格和栏位不再手写每个字符 baseline。", "MGFXTextDemoSmall", 78, 394, panelW - 156, 42, {
		color = Color(214, 226, 220),
		alignX = "left",
		alignY = "center",
		overflow = "ellipsis",
		stroke = {width = 0.22, softness = 0.70, color = Color(0, 0, 0, 58)},
		shadow = {x = 0, y = 1, blur = 3, color = Color(0, 0, 0, 95)},
	})
	M.EndScreen()

	draw.SimpleText("NATIVE", "DermaDefault", 78, 374, Color(190, 222, 230), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.SimpleText("native compare 中文 Aa123", "MGFXTextDemoNativeCJK", 178, 374, Color(220, 238, 240), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

	local textStatus = textRenderer and textRenderer.Status and textRenderer.Status()
	draw.SimpleText(string.format("text composed:%d native:%d bakes:%d blits:%d entries:%d fx:%s",
		M.stats.textShaderDraws or 0,
		M.stats.textNativeDraws or 0,
		M.stats.textComposedBakes or 0,
		M.stats.textComposedBlits or 0,
		textStatus and textStatus.composedEntries or 0,
		strong and "strong" or "normal"
	), "DermaDefault", 56, 500, Color(210, 230, 235))
	draw.SimpleText(string.format("composed bakes:%d blits:%d entries:%d evicts:%d  (mgfx_text_composed %s)",
		M.stats.textComposedBakes or 0,
		M.stats.textComposedBlits or 0,
		M.stats.textComposedEntries or 0,
		M.stats.textComposedEvicts or 0,
		(textRenderer and textRenderer.ComposedEnabled and textRenderer.ComposedEnabled()) and "on" or "off"
	), "DermaDefault", 56, 514, Color(170, 230, 200))
end

addCommand("mgfx_text_demo", function(_, _, args)
	local mode = args and args[1] or "toggle"
	if mode == "0" or mode == "off" or mode == "close" then
		hook.Remove("HUDPaint", "MGFXTextDemo")
		textDemoEnabled = false
		print("[MGFX] text demo off")
		return
	end

	if mode == "toggle" and textDemoEnabled then
		hook.Remove("HUDPaint", "MGFXTextDemo")
		textDemoEnabled = false
		print("[MGFX] text demo off")
		return
	end

	hook.Add("HUDPaint", "MGFXTextDemo", drawTextDemo)
	textDemoEnabled = true
	print("[MGFX] text demo on")
end)

addCommand("mgfx_text_trace_demo", function()
	ensureTextDemoFonts()
	if not textRenderer or not textRenderer.DebugResolve then
		print("[MGFX] text trace unavailable")
		return
	end
	for index, item in ipairs(M._internal.TextDemoStrings or {}) do
		local info = textRenderer.DebugResolve(item[1], item[2])
		local missing = info and info.missing or {}
		print(string.format("[MGFX] demo text %d font=%s atlas=%s kind=%s route=%s routeKind=%s missing=%d",
			index,
			tostring(item[2]),
			tostring(info and info.atlasKey),
			tostring(info and info.kind),
			tostring(info and info.routeAtlas),
			tostring(info and info.routeKind),
			#missing
		))
		if #missing > 0 then
			print("[MGFX]   missing chars: " .. table.concat(missing, ""))
		end
	end
end)

addCommand("mgfx_selftest", function()
	local requiredMaterials = {
		"roundrect",
		"roundrect_fx",
		"roundrect_solid",
		"roundrect_stroke",
		"roundrect_texture",
		"param_probe",
		"chamfer",
		"chamfer_texture",
		"image_mask",
		"image_mask_outerglow",
		"image_mask_backdrop",
		"chamfer_stroke",
		"roundrect_blur",
		"roundrect_innerglow",
		"chamfer_innerglow",
		"roundrect_outerglow",
		"chamfer_outerglow",
		"progress",
		"progress_fx",
		"segmentbar",
		"line",
		"text_face",
		"text_compose",
		"roundrect_pattern",
		"chamfer_pattern",
		"poly_pattern",
		"ring",
		"ring_fx",
		"ring_backdrop",
		"ring_stroke",
		"ring_innerglow",
		"ring_outerglow",
		"ring_pattern",
		"poly_stroke",
		"poly3",
		"poly4",
		"poly5",
		"poly6",
		"poly7",
		"poly8",
		"poly3_blur",
		"poly4_blur",
		"poly5_blur",
		"poly6_blur",
		"poly7_blur",
		"poly8_blur",
	}

	local requiredApis = {
		"StartPanel",
		"EndPanel",
		"StartScreen",
		"EndScreen",
		"RoundedBox",
		"RoundedBoxEx",
		"ChamferBox",
		"ChamferBoxEx",
		"Poly",
		"PolyEx",
		"Image",
		"ImageEx",
		"Icon",
		"IconEx",
		"Text",
		"TextEx",
		"TextBox",
		"TextBoxEx",
		"MeasureText",
		"MeasureTextBox",
		"DefineTextStyle",
		"GetTextStyle",
		"ResolveTextStyle",
		"RegisterTextFont",
		"PrewarmText",
		"GetCapabilities",
		"Supports",
		"Transform",
		"ProjectedQuad",
		"PointerTilt",
		"PushTransform",
		"PopTransform",
		"TransformPoint",
		"UntransformPoint",
		"ProgressBar",
		"ProgressBarEx",
		"SegmentBar",
		"SegmentBarEx",
		"Line",
		"LineEx",
		"Ring",
		"RingEx",
		"Arc",
		"ArcEx",
		"Sector",
		"SectorEx",
		"Circle",
		"CircleEx",
		"Capsule",
		"CapsuleEx",
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
		"Mask",
		"DebugOverlay",
	}

	local requiredTargets = {
		"ROUNDED_BOX",
		"CHAMFER_BOX",
		"POLY",
		"LINE",
		"CIRCLE",
		"CAPSULE",
		"IMAGE",
		"PROGRESS_BAR",
		"SEGMENT_BAR",
		"RING",
		"ARC",
		"SECTOR",
		"TEXT",
	}

	print("[MGFX] selftest begin")
	print("[MGFX] version: " .. tostring(shaderVersion))
	print("[MGFX] shaders: " .. (M.hasShaders() and "loaded" or "fallback"))

	for _, key in ipairs(requiredMaterials) do
		print("[MGFX] material " .. key .. ": " .. (matOK(materials[key]) and "ok" or "error"))
	end

	for _, key in ipairs(requiredApis) do
		print("[MGFX] api " .. key .. ": " .. (isfunction(M[key]) and "ok" or "missing"))
	end

	for _, key in ipairs(requiredTargets) do
		print("[MGFX] target " .. key .. ": " .. (M.TARGET and M.TARGET[key] and "ok" or "missing"))
	end

	print("[MGFX] selftest end")
end)

end
