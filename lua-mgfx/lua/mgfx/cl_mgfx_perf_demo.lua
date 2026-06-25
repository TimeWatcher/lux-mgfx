if SERVER then return end

MGFX = MGFX or {}

local PerfPanel
local addCommand = MGFX._AddCommand or concommand.Add

local countCvar = CreateClientConVar("mgfx_perf_count", "120", true, false, "MGFX perf demo workload count.")
local modeCvar = CreateClientConVar("mgfx_perf_mode", "all", true, false, "MGFX perf demo workload filter.")
local warmupCvar = CreateClientConVar("mgfx_perf_warmup", "30", true, false, "MGFX perf demo warmup frames.")
local profileCvarName = "mgfx_profile"

local COLORS = {
	bg = Color(7, 13, 18, 238),
	panel = Color(14, 23, 31, 232),
	panel2 = Color(19, 31, 40, 238),
	line = Color(52, 77, 92, 210),
	text = Color(232, 244, 248),
	muted = Color(146, 169, 178),
	cyan = Color(78, 214, 238),
	green = Color(82, 224, 154),
	gold = Color(255, 202, 92),
	red = Color(255, 103, 92),
	blue = Color(89, 148, 255),
	purple = Color(186, 145, 255),
}

local fontScale = -1
local textFontReady = false

local function ensureFonts()
	local scale = math.Clamp(ScrH() / 1080, 0.85, 1.2)
	scale = math.Round(scale * 100) / 100
	if fontScale == scale then return end
	fontScale = scale

	local function create(name, face, size, weight)
		surface.CreateFont(name, {
			font = face,
			size = math.max(8, math.Round(size * scale)),
			weight = weight,
			antialias = true,
			extended = true,
		})
	end

	create("MGFXPerfTitle", "Bahnschrift", 26, 900)
	create("MGFXPerfHeader", "Bahnschrift", 16, 760)
	create("MGFXPerfText", "Noto Sans SC", 14, 400)
	create("MGFXPerfMono", "Consolas", 13, 500)
	create("MGFXPerfSmall", "Tahoma", 11, 500)
end

local function ensureTextFonts()
	if textFontReady or not MGFX.RegisterTextFont then return end
	textFontReady = true
	MGFX.RegisterTextFont("MGFXPerfTextLarge", {face = "Bahnschrift", size = 26, weight = 850, lineHeight = 32})
	MGFX.RegisterTextFont("MGFXPerfTextSmall", {face = "Noto Sans SC", size = 15, weight = 420, lineHeight = 22})
end

local function drawText(value, font, x, y, color, ax, ay)
	draw.SimpleText(tostring(value or ""), font, x + 1, y + 1, Color(0, 0, 0, 165), ax or TEXT_ALIGN_LEFT, ay or TEXT_ALIGN_TOP)
	draw.SimpleText(tostring(value or ""), font, x, y, color or COLORS.text, ax or TEXT_ALIGN_LEFT, ay or TEXT_ALIGN_TOP)
end

local function ellipsizeText(value, font, maxWidth)
	local text = tostring(value or "")
	maxWidth = math.max(0, tonumber(maxWidth) or 0)
	if maxWidth <= 0 or text == "" then return "" end

	surface.SetFont(font)
	if surface.GetTextSize(text) <= maxWidth then return text end
	local suffix = "..."
	local suffixWidth = surface.GetTextSize(suffix)
	if suffixWidth >= maxWidth then return "" end

	local lo, hi = 0, #text
	while lo < hi do
		local mid = math.ceil((lo + hi) * 0.5)
		local candidate = string.sub(text, 1, mid) .. suffix
		if surface.GetTextSize(candidate) <= maxWidth then
			lo = mid
		else
			hi = mid - 1
		end
	end
	return string.sub(text, 1, lo) .. suffix
end

local function drawCell(value, font, x, y, w, color, align, ay)
	local text = ellipsizeText(value, font, w)
	if text == "" then return end
	local tx = x
	if align == TEXT_ALIGN_RIGHT then
		tx = x + w
	elseif align == TEXT_ALIGN_CENTER then
		tx = x + w * 0.5
	end
	drawText(text, font, tx, y, color, align or TEXT_ALIGN_LEFT, ay)
end

local function setCvarBool(name, enabled)
	local cvar = GetConVar(name)
	if not cvar then return end
	RunConsoleCommand(name, enabled and "1" or "0")
end

local function cvarBool(name)
	local cvar = GetConVar(name)
	return cvar and cvar:GetBool() or false
end

local function cvarInt(cvar, fallback, minValue, maxValue)
	local value = cvar and cvar:GetInt() or fallback
	value = tonumber(value) or fallback
	if minValue then value = math.max(minValue, value) end
	if maxValue then value = math.min(maxValue, value) end
	return math.floor(value)
end

local function cvarString(cvar, fallback)
	local value = cvar and cvar:GetString() or fallback
	if value == nil or value == "" then return fallback end
	return tostring(value)
end

local function resetProfileStats()
	if MGFX._internal and MGFX._internal.ResetStats then
		MGFX._internal.ResetStats()
	end
end

local function cloneProfileTimes()
	local out = {}
	local source = MGFX.stats and MGFX.stats.profileTimes or nil
	if not source then return out end
	for name, value in pairs(source) do
		out[name] = value or 0
	end
	return out
end

local ignoredProfileRows = {
	paintTotal = true,
	paintBuild = true,
	frame = true,
	commandLoop = true,
}

local function visibleProfileRow(name)
	if ignoredProfileRows[name] then return false end
	if string.sub(name, 1, 4) == "cmd." then return false end
	return true
end

local function profileDelta(before, after)
	local rows = {}
	for name, value in pairs(after or {}) do
		local delta = (value or 0) - (before and before[name] or 0)
		if delta > 0.001 and visibleProfileRow(name) then
			rows[#rows + 1] = {name = name, ms = delta}
		end
	end
	table.sort(rows, function(a, b)
		if a.ms == b.ms then return a.name < b.name end
		return a.ms > b.ms
	end)
	while #rows > 14 do rows[#rows] = nil end
	return rows
end

local function rowHasProfileName(rows, name)
	for i = 1, #rows do
		if rows[i].name == name then return true end
	end
	return false
end

local function displayProfileRows(item, rows)
	if not rows or #rows == 0 then return rows or {} end
	if not item or item.group ~= "direct" then return rows end

	local out = {}
	local limit = 5
	for i = 1, #rows do
		local name = rows[i].name
		if (name == "round.immediate" or string.sub(tostring(name), 1, 4) == "api.")
			and not rowHasProfileName(out, name) then
			out[#out + 1] = rows[i]
			break
		end
	end

	for i = 1, #rows do
		local name = rows[i].name or ""
		if (string.find(name, ".setup", 1, true)
			or string.find(name, ".draw", 1, true)
			or string.find(name, ".bleed", 1, true))
			and not rowHasProfileName(out, name) then
			out[#out + 1] = rows[i]
			if #out >= limit then break end
		end
	end

	for i = 1, math.min(2, #rows) do
		if #out >= limit then break end
		if not rowHasProfileName(out, rows[i].name) then
			out[#out + 1] = rows[i]
		end
	end

	for i = 1, #rows do
		if #out >= limit then break end
		if not rowHasProfileName(out, rows[i].name) then
			out[#out + 1] = rows[i]
		end
	end

	return out
end

local compactProfileNames = {
	["round.immediate"] = "immediate",
	["round.fast.solidRound"] = "fast",
	["round.fast.solidRound.setup"] = "fast.setup",
	["round.fast.solidRound.draw"] = "fast.draw",
	["round.base"] = "base",
	["round.base.gradient"] = "base.grad",
	["round.base.fx"] = "base.fx",
	["round.base.stroke"] = "base.stroke",
	["round.shadowOuter"] = "shadowOuter",
	["round.shadowOuter.setup"] = "shadowOuter.setup",
	["round.shadowOuter.draw"] = "shadowOuter.draw",
	["round.shadowOuter.bleedBegin"] = "shadowOuter.bleedB",
	["round.shadowOuter.bleedEnd"] = "shadowOuter.bleedE",
	["round.backdrop"] = "backdrop",
	["round.normalizeEffects"] = "normalize",
	["style.shadow"] = "style.shadow",
	["style.outerGlow"] = "style.outer",
	["style.backdrop"] = "style.backdrop",
	["style.innerGlow"] = "style.inner",
	["round.cullSpread"] = "cullSpread",
	["round.fillPrepare"] = "fillPrepare",
}

local function profileLabel(row, compact)
	local name = row and row.name or "unknown"
	if compact then
		if compactProfileNames[name] then return compactProfileNames[name] end
		if string.sub(name, 1, 4) == "api." then return string.sub(name, 5) end
		if string.sub(name, 1, 6) == "round." then return string.sub(name, 7) end
	end
	return name
end

local function profileSegmentText(row, compact)
	return string.format("%s %.3f", profileLabel(row, compact), row.ms or 0)
end

local function profileSegmentMaxWidth(compact)
	return compact and 122 or 190
end

local function profileSegmentLimit(item)
	return item and item.group == "direct" and 6 or 6
end

local function profileRowsCompact(item)
	return item and item.group == "direct"
end

local statKeys = {
	"textQueuedRecords",
	"textQueuedBatches",
	"textDraws",
	"textComposedBakes",
	"textComposedBlits",
	"textComposedBatchDraws",
	"textComposedBatchedRecords",
	"textEntryCacheHits",
	"textEntryCacheMisses",
	"textMeasureHits",
	"textMeasureMisses",
	"textFallbacks",
}

local function cloneStats()
	local out = {}
	local source = MGFX.stats or {}
	for i = 1, #statKeys do
		local key = statKeys[i]
		out[key] = tonumber(source[key]) or 0
	end
	return out
end

local function statDelta(before, after)
	local out = {}
	for i = 1, #statKeys do
		local key = statKeys[i]
		local delta = (after and after[key] or 0) - (before and before[key] or 0)
		if delta ~= 0 then out[key] = delta end
	end
	return out
end

local function formatStatDelta(delta, force)
	if not delta then return "" end
	if not force and not next(delta) then return "" end
	local parts = {
		"q=" .. tostring(delta.textQueuedRecords or 0) .. "/" .. tostring(delta.textQueuedBatches or 0),
		"d=" .. tostring(delta.textDraws or 0),
	}
	if delta.textComposedBakes then parts[#parts + 1] = "bk=" .. tostring(delta.textComposedBakes) end
	if delta.textComposedBlits then parts[#parts + 1] = "bl=" .. tostring(delta.textComposedBlits) end
	if delta.textComposedBatchDraws or delta.textComposedBatchedRecords then
		parts[#parts + 1] = "mesh=" .. tostring(delta.textComposedBatchDraws or 0) .. "/" .. tostring(delta.textComposedBatchedRecords or 0)
	end
	if delta.textFallbacks then parts[#parts + 1] = "fb=" .. tostring(delta.textFallbacks) end
	return table.concat(parts, " ")
end

local function fmt(ms)
	return string.format("%.3f", tonumber(ms) or 0)
end

local function flattenTraceRows(node, depth, out)
	if not node then return out end
	out = out or {}
	out[#out + 1] = {
		name = node.name or "unknown",
		depth = depth or 0,
		total = tonumber(node.total) or 0,
		self = tonumber(node.self) or 0,
		count = tonumber(node.count) or 0,
		max = tonumber(node.max) or 0,
		selfMax = tonumber(node.selfMax) or 0,
	}
	for i = 1, #(node.children or {}) do
		flattenTraceRows(node.children[i], (depth or 0) + 1, out)
	end
	return out
end

local function traceAvg(row)
	local count = tonumber(row and row.count) or 0
	if count <= 0 then return 0 end
	return (tonumber(row.total) or 0) / count
end

local function makeStops(a, b, c)
	return {
		{0.0, a},
		{0.52, b},
		{1.0, c},
	}
end

local linearGradient = assert(MGFX.LinearGradient, "MGFX perf demo requires MGFX.LinearGradient")
local ringAngularGradient = assert(MGFX.RingAngularGradient, "MGFX perf demo requires MGFX.RingAngularGradient")

local fills = {
	solidA = Color(42, 140, 214, 235),
	solidB = Color(20, 29, 39, 238),
	round = linearGradient(0, 0, 1, 1, makeStops(Color(60, 198, 226), Color(43, 98, 218), Color(192, 92, 224))),
	ring = ringAngularGradient(makeStops(Color(70, 220, 172), Color(76, 174, 244), Color(240, 170, 78))),
	poly = linearGradient(0, 0, 1, 0, makeStops(Color(255, 205, 94), Color(82, 219, 161), Color(82, 150, 255))),
	line = linearGradient(0, 0, 1, 0, makeStops(Color(89, 210, 255), Color(255, 217, 106), Color(80, 228, 166))),
	text = linearGradient(0, 0, 1, 0, makeStops(Color(250, 252, 255), Color(117, 216, 250), Color(255, 208, 102))),
}

local roundStyleFx = {
	radius = 10,
	fill = fills.round,
	stroke = Color(130, 224, 255, 210),
	strokeWidth = 1.4,
	innerGlow = {color = Color(106, 226, 255, 92), width = 9, strength = 1.15, falloff = 1.7},
}

local roundStyleFillOnly = {
	radius = 10,
	fill = fills.round,
}

local roundStyleLayerStroke = {
	radius = 10,
	fill = Color(0, 0, 0, 0),
	stroke = Color(130, 224, 255, 210),
	strokeWidth = 1.4,
}

local roundStyleLayerGlow = {
	radius = 10,
	fill = Color(0, 0, 0, 0),
	innerGlow = {color = Color(106, 226, 255, 92), width = 9, strength = 1.15, falloff = 1.7},
}

local ringStyleFx = {
	fill = fills.ring,
	stroke = Color(238, 249, 255, 190),
	strokeWidth = 1.5,
	innerGlow = {color = Color(85, 224, 255, 95), width = 8, strength = 1.1, falloff = 1.7},
}

local ringStyleFillOnly = {
	fill = fills.ring,
}

local ringStyleLayerStroke = {
	fill = Color(0, 0, 0, 0),
	stroke = Color(238, 249, 255, 190),
	strokeWidth = 1.5,
}

local ringStyleLayerGlow = {
	fill = Color(0, 0, 0, 0),
	innerGlow = {color = Color(85, 224, 255, 95), width = 8, strength = 1.1, falloff = 1.7},
}

local polyStyleFx = {
	fill = fills.poly,
	stroke = Color(255, 255, 255, 190),
	strokeWidth = 1.25,
	outerGlow = {color = Color(70, 208, 255, 58), width = 10, strength = 0.75, falloff = 1.8},
}

local polyStyleFill = {
	fill = fills.poly,
}

local lineStyle = {
	width = 4,
	fill = fills.line,
}

local textStyleFx = {
	fill = fills.text,
	stroke = {color = Color(10, 28, 38, 230), width = 2.1},
	shadow = {color = Color(0, 0, 0, 160), x = 2, y = 3, width = 7, strength = 0.95},
	glow = {color = Color(83, 220, 255, 105), width = 7, strength = 0.85},
}

local textStyleGradient = {
	fill = fills.text,
}

local textStyleStroke = {
	fill = Color(232, 244, 248),
	stroke = {color = Color(10, 28, 38, 230), width = 2.1},
}

local textStyleGlow = {
	fill = Color(232, 244, 248),
	glow = {color = Color(83, 220, 255, 105), width = 7, strength = 0.85},
}

local textStyleShadow = {
	fill = Color(232, 244, 248),
	shadow = {color = Color(0, 0, 0, 160), x = 2, y = 3, width = 7, strength = 0.95},
}

local textStylePlain = {
	fill = Color(232, 244, 248),
}

local blurStyle = {
	radius = 12,
	backdrop = {
		blur = 9,
		padding = 8,
		tint = Color(10, 20, 26, 94),
		opacity = 1,
	},
	fill = Color(20, 36, 46, 120),
	stroke = Color(132, 221, 255, 90),
	strokeWidth = 1,
}

local roundChainStyle = {
	radius = 12,
	fill = fills.round,
	stroke = Color(132, 221, 255, 190),
	strokeWidth = 1.4,
	innerGlow = {color = Color(106, 226, 255, 92), width = 9, strength = 1.15, falloff = 1.7},
	shadow = {color = Color(0, 0, 0, 132), x = 2, y = 4, width = 12, strength = 1, falloff = 1.6},
	outerGlow = {color = Color(70, 208, 255, 70), x = 0, y = 0, width = 14, strength = 0.9, falloff = 1.8},
	backdrop = {blur = 6, padding = 6, tint = Color(10, 20, 26, 82), opacity = 1},
}

local function seededCell(index, columns, x, y, cellW, cellH, ox, oy)
	local col = (index - 1) % columns
	local row = math.floor((index - 1) / columns)
	return (ox or 0) + x + col * cellW, (oy or 0) + y + row * cellH, col, row
end

local function drawBackgroundPattern(x, y, w, h)
	if h == nil then
		w, h = x, y
		x, y = 0, 0
	end
	surface.SetDrawColor(20, 34, 42, 255)
	surface.DrawRect(x, y, w, h)
	for i = 0, 18 do
		local bx = (i * 97 + 23) % math.max(1, w)
		surface.SetDrawColor(30 + (i % 4) * 12, 70 + (i % 5) * 18, 82 + (i % 3) * 20, 90)
		surface.DrawRect(x + bx, y, 18 + (i % 5) * 12, h)
	end
	for i = 0, 9 do
		local by = (i * 61 + 17) % math.max(1, h)
		surface.SetDrawColor(85, 112, 128, 35)
		surface.DrawRect(x, y + by, w, 2)
	end
end

local DIRECT_BOX_W = 52
local DIRECT_BOX_H = 22
local DIRECT_RADIUS = 8
local DIRECT_CELL_W = 64
local DIRECT_CELL_H = 30
local DIRECT_COLOR = Color(72, 198, 235, 224)
local DIRECT_STROKE_COLOR = Color(220, 248, 255, 205)
local DIRECT_GLOW_COLOR = Color(106, 226, 255, 92)
local DIRECT_SHADOW_COLOR = Color(0, 0, 0, 132)
local DIRECT_OUTER_COLOR = Color(70, 208, 255, 70)
local DIRECT_BACKDROP_TINT = Color(10, 20, 26, 94)
local DIRECT_GRADIENT_END = Color(192, 92, 224)
local DIRECT_GRADIENT_FILL = linearGradient(0, 0, 1, 1, makeStops(Color(60, 198, 226), Color(43, 98, 218), Color(192, 92, 224)))
local DIRECT_API_STYLE = {
	radius = DIRECT_RADIUS,
	fill = DIRECT_COLOR,
}
local DIRECT_API_GRADIENT_STYLE = {
	radius = DIRECT_RADIUS,
	fill = DIRECT_GRADIENT_FILL,
}
local DIRECT_API_FX_STYLE = {
	radius = DIRECT_RADIUS,
	fill = DIRECT_COLOR,
	stroke = DIRECT_STROKE_COLOR,
	strokeWidth = 1.4,
	innerGlow = {color = DIRECT_GLOW_COLOR, width = 9, strength = 1.15, falloff = 1.7},
}
local DIRECT_API_STROKE_STYLE = {
	radius = DIRECT_RADIUS,
	fill = Color(0, 0, 0, 0),
	stroke = DIRECT_STROKE_COLOR,
	strokeWidth = 1.4,
}
local DIRECT_API_SHADOW_STYLE = {
	radius = DIRECT_RADIUS,
	fill = Color(0, 0, 0, 0),
	shadow = {color = DIRECT_SHADOW_COLOR, x = 2, y = 4, width = 12, strength = 1, falloff = 1.6},
}
local DIRECT_API_OUTER_STYLE = {
	radius = DIRECT_RADIUS,
	fill = Color(0, 0, 0, 0),
	outerGlow = {color = DIRECT_OUTER_COLOR, x = 0, y = 0, width = 14, strength = 0.9, falloff = 1.8},
}
local DIRECT_API_FUSED_STYLE = {
	radius = DIRECT_RADIUS,
	fill = DIRECT_GRADIENT_FILL,
	stroke = DIRECT_STROKE_COLOR,
	strokeWidth = 1.4,
	shadow = {color = DIRECT_SHADOW_COLOR, x = 2, y = 4, width = 12, strength = 1, falloff = 1.6},
	outerGlow = {color = DIRECT_OUTER_COLOR, x = 0, y = 0, width = 14, strength = 0.9, falloff = 1.8},
}
local DIRECT_API_BACKDROP_STYLE = {
	radius = DIRECT_RADIUS,
	fill = Color(20, 36, 46, 120),
	backdrop = {blur = 9, padding = 8, tint = DIRECT_BACKDROP_TINT, opacity = 1},
}
local cpu = {
	repeatCount = 64,
	sink = 0,
	shadowProbe = {color = DIRECT_SHADOW_COLOR, x = 2, y = 4, width = 12, strength = 1, falloff = 1.6},
	outerProbe = {color = DIRECT_OUTER_COLOR, x = 0, y = 0, width = 14, strength = 0.9, falloff = 1.8},
	innerProbe = {color = DIRECT_GLOW_COLOR, width = 9, strength = 1.15, falloff = 1.7},
	callProbe = {},
}

function cpu.leaf(a, b, c, d)
	return a + b + c + d
end

function cpu.wrapper(a, b, c, d)
	return cpu.leaf(a, b, c, d)
end
cpu.callProbe.leaf = cpu.leaf
local directMatrix = Matrix and Matrix() or nil
local directAuxMatrix = Matrix and Matrix() or nil
local directMatrixSetUnpacked = directMatrix and directMatrix.SetUnpacked or nil
local directMaterials = {}
local directShaderWarned = false
local directUvMat
local directU0 = 0
local directV0 = 0
local directU1 = 1
local directV1 = 1
local directUvReady = false

local function directMaterialOK(mat)
	return mat and mat.IsError and not mat:IsError()
end

local function directStatusMaterial(key)
	local cached = directMaterials[key]
	if directMaterialOK(cached) then return cached end

	local status = MGFX.shaderStatus and MGFX.shaderStatus()
	local mat = status and status[key] or nil
	if directMaterialOK(mat) then
		directMaterials[key] = mat
		return mat
	end

	if not directShaderWarned then
		directShaderWarned = true
		print("[MGFX] perf direct shader unavailable: " .. tostring(key) .. " material is missing or errored")
	end
	return nil
end

local function directColor01(color)
	local inv = 1 / 255
	return (color.r or 255) * inv, (color.g or 255) * inv, (color.b or 255) * inv, (color.a == nil and 255 or color.a) * inv
end

local function setDirectMatrix(mat,
	a0, a1, a2, a3,
	b0, b1, b2, b3,
	c0, c1, c2, c3,
	d0, d1, d2, d3)
	if not mat or not directMatrix or not directMatrixSetUnpacked then return false end

	-- Match MGFX's c11 packing exactly: SetUnpacked writes columns, while
	-- the shader reads EXTRA0..EXTRA3 as logical rows.
	directMatrixSetUnpacked(directMatrix,
		a0 or 0, b0 or 0, c0 or 0, d0 or 0,
		a1 or 0, b1 or 0, c1 or 0, d1 or 0,
		a2 or 0, b2 or 0, c2 or 0, d2 or 0,
		a3 or 0, b3 or 0, c3 or 0, d3 or 0
	)
	mat:SetMatrix("$viewprojmat", directMatrix)
	return true
end

local function setDirectAuxMatrix(mat,
	a0, a1, a2, a3,
	b0, b1, b2, b3,
	c0, c1, c2, c3,
	d0, d1, d2, d3)
	if not mat or not directAuxMatrix or not directMatrixSetUnpacked then return false end

	directMatrixSetUnpacked(directAuxMatrix,
		a0 or 0, b0 or 0, c0 or 0, d0 or 0,
		a1 or 0, b1 or 0, c1 or 0, d1 or 0,
		a2 or 0, b2 or 0, c2 or 0, d2 or 0,
		a3 or 0, b3 or 0, c3 or 0, d3 or 0
	)
	mat:SetMatrix("$invviewprojmat", directAuxMatrix)
	return true
end

local function setupDirectSolidMatrix(mat)
	local r, g, b, a = directColor01(DIRECT_COLOR)
	return setDirectMatrix(mat,
		r, g, b, a,
		DIRECT_BOX_W, DIRECT_BOX_H, 0, DIRECT_RADIUS,
		0, 0, 1, 0,
		0, 0, 0, 0
	)
end

local function setupDirectGradientMatrix(mat)
	local r, g, b, a = directColor01(DIRECT_GRADIENT_END)
	if MGFX.BindGradientLut then
		MGFX.BindGradientLut(mat, DIRECT_GRADIENT_FILL)
	end
	surface.SetDrawColor(60, 198, 226, 255)
	return setDirectMatrix(mat,
		r, g, b, a,
		DIRECT_BOX_W, DIRECT_BOX_H, 256, DIRECT_RADIUS,
		0, 0, 1, 1,
		0, 0, 0, 0
	)
end

local function setupDirectFxMatrix(mat)
	local r, g, b, a = directColor01(DIRECT_COLOR)
	local sr, sg, sb, sa = directColor01(DIRECT_STROKE_COLOR)
	local gr, gg, gb, ga = directColor01(DIRECT_GLOW_COLOR)
	if not setDirectAuxMatrix(mat,
		gr, gg, gb, ga,
		9, 1.15, 1.7, 0,
		0, 0, 0, 0,
		0, 0, 0, 0
	) then return false end
	surface.SetDrawColor(DIRECT_COLOR)
	return setDirectMatrix(mat,
		r, g, b, a,
		DIRECT_BOX_W, DIRECT_BOX_H, 1.4, DIRECT_RADIUS,
		0, 0, 1, 0,
		sr, sg, sb, sa
	)
end

local function setupDirectStrokeMatrix(mat)
	local r, g, b, a = directColor01(DIRECT_STROKE_COLOR)
	surface.SetDrawColor(255, 255, 255, 255)
	return setDirectMatrix(mat,
		r, g, b, a,
		DIRECT_BOX_W, DIRECT_BOX_H, 1.4, DIRECT_RADIUS,
		0, 0, 0, 0,
		0, 0, 0, 0
	)
end

local function setupDirectShadowOuterMatrix(mat, shadowOnly)
	local spread = shadowOnly and 12 or 14
	local drawW = DIRECT_BOX_W + spread * 2
	local drawH = DIRECT_BOX_H + spread * 2
	local sr, sg, sb, sa = directColor01(DIRECT_SHADOW_COLOR)
	local orr, og, ob, oa = directColor01(DIRECT_OUTER_COLOR)

	if not setDirectAuxMatrix(mat,
		shadowOnly and 0 or orr, shadowOnly and 0 or og, shadowOnly and 0 or ob, shadowOnly and 0 or oa,
		spread, spread, DIRECT_BOX_W, DIRECT_BOX_H,
		DIRECT_RADIUS, 14, shadowOnly and 0 or 0.9, 1.8,
		0, 0, 0, 0
	) then return false end

	return setDirectMatrix(mat,
		drawW, drawH, 0, 0,
		shadowOnly and sr or 0, shadowOnly and sg or 0, shadowOnly and sb or 0, shadowOnly and sa or 0,
		spread, spread, DIRECT_BOX_W, DIRECT_BOX_H,
		DIRECT_RADIUS, 12, shadowOnly and 1 or 0, 1.6
	)
end

local function updateDirectMaterialUV(mat)
	if mat == directUvMat then return end

	directUvMat = mat
	local mw = mat and mat.Width and tonumber(mat:Width()) or 1
	local mh = mat and mat.Height and tonumber(mat:Height()) or 1
	if mw <= 1 or mh <= 1 then
		directUvReady = false
		print("[MGFX] perf direct shader rect unavailable: material mapping size is " .. tostring(mw) .. "x" .. tostring(mh))
		return
	end

	local du = 0.5 / mw
	local dv = 0.5 / mh
	directU0, directV0 = -du / (1 - 2 * du), -dv / (1 - 2 * dv)
	directU1, directV1 = (1 - du) / (1 - 2 * du), (1 - dv) / (1 - 2 * dv)
	directUvReady = true
end

local function directCell(index, stageW, stageH, ox, oy)
	local usableW = math.max(DIRECT_CELL_W, (stageW or 0) - 36)
	local usableH = math.max(DIRECT_CELL_H, (stageH or 0) - 34)
	local columns = math.max(1, math.floor(usableW / DIRECT_CELL_W))
	local rows = math.max(1, math.floor(usableH / DIRECT_CELL_H))
	local slot = (index - 1) % math.max(1, columns * rows)
	local col = slot % columns
	local row = math.floor(slot / columns)
	return (ox or 0) + 18 + col * DIRECT_CELL_W, (oy or 0) + 18 + row * DIRECT_CELL_H
end

local function drawDirectShaderRect(x, y)
	surface.DrawTexturedRectUV(x, y, DIRECT_BOX_W, DIRECT_BOX_H, directU0, directV0, directU1, directV1)
end

local function drawDirectShaderRectSized(x, y, w, h)
	surface.DrawTexturedRectUV(x, y, w, h, directU0, directV0, directU1, directV1)
end

local function directTexturedQuad()
	return assert(MGFX._internal and MGFX._internal.drawTexturedQuad, "MGFX direct quad probe unavailable")
end

local function workloadEmpty(panel, count, w, h, ox, oy)
end

local function workloadDirectEmpty(panel, count, w, h, ox, oy)
end

local function workloadDirectNativeRect(panel, count, w, h, ox, oy)
	surface.SetDrawColor(DIRECT_COLOR)
	for i = 1, count do
		local x, y = directCell(i, w, h, ox, oy)
		surface.DrawRect(x, y, DIRECT_BOX_W, DIRECT_BOX_H)
	end
end

local function workloadDirectShaderRectStatic(panel, count, w, h, ox, oy)
	local mat = directStatusMaterial("roundrectSolid")
	if not mat or not setupDirectSolidMatrix(mat) then return end

	updateDirectMaterialUV(mat)
	if not directUvReady then return end
	surface.SetMaterial(mat)
	surface.SetDrawColor(255, 255, 255, 255)
	for i = 1, count do
		local x, y = directCell(i, w, h, ox, oy)
		drawDirectShaderRect(x, y)
	end
end

local function workloadDirectShaderRectPerDraw(panel, count, w, h, ox, oy)
	local mat = directStatusMaterial("roundrectSolid")
	if not mat then return end

	updateDirectMaterialUV(mat)
	if not directUvReady then return end
	surface.SetMaterial(mat)
	surface.SetDrawColor(255, 255, 255, 255)
	for i = 1, count do
		if not setupDirectSolidMatrix(mat) then return end
		local x, y = directCell(i, w, h, ox, oy)
		drawDirectShaderRect(x, y)
	end
end

local function workloadDirectMgfxQuadStatic(panel, count, w, h, ox, oy)
	local mat = directStatusMaterial("roundrectSolid")
	if not mat or not setupDirectSolidMatrix(mat) then return end

	local drawQuad = directTexturedQuad()
	surface.SetMaterial(mat)
	surface.SetDrawColor(255, 255, 255, 255)
	for i = 1, count do
		local x, y = directCell(i, w, h, ox, oy)
		drawQuad(x, y, DIRECT_BOX_W, DIRECT_BOX_H, mat)
	end
end

local function workloadDirectMgfxQuadPerDraw(panel, count, w, h, ox, oy)
	local mat = directStatusMaterial("roundrectSolid")
	if not mat then return end

	local drawQuad = directTexturedQuad()
	surface.SetMaterial(mat)
	surface.SetDrawColor(255, 255, 255, 255)
	for i = 1, count do
		if not setupDirectSolidMatrix(mat) then return end
		local x, y = directCell(i, w, h, ox, oy)
		drawQuad(x, y, DIRECT_BOX_W, DIRECT_BOX_H, mat)
	end
end

local function workloadDirectShaderGradient(panel, count, w, h, ox, oy)
	local mat = directStatusMaterial("roundrect")
	if not mat or not setupDirectGradientMatrix(mat) then return end

	updateDirectMaterialUV(mat)
	if not directUvReady then return end
	surface.SetMaterial(mat)
	for i = 1, count do
		local x, y = directCell(i, w, h, ox, oy)
		drawDirectShaderRect(x, y)
	end
end

local function workloadDirectShaderFx(panel, count, w, h, ox, oy)
	local mat = directStatusMaterial("roundrectFx")
	if not mat or not setupDirectFxMatrix(mat) then return end

	updateDirectMaterialUV(mat)
	if not directUvReady then return end
	surface.SetMaterial(mat)
	for i = 1, count do
		local x, y = directCell(i, w, h, ox, oy)
		drawDirectShaderRect(x, y)
	end
end

local function workloadDirectShaderFxPerDraw(panel, count, w, h, ox, oy)
	local mat = directStatusMaterial("roundrectFx")
	if not mat then return end

	updateDirectMaterialUV(mat)
	if not directUvReady then return end
	surface.SetMaterial(mat)
	for i = 1, count do
		if not setupDirectFxMatrix(mat) then return end
		local x, y = directCell(i, w, h, ox, oy)
		drawDirectShaderRect(x, y)
	end
end

local function workloadDirectShaderStroke(panel, count, w, h, ox, oy)
	local mat = directStatusMaterial("roundrectStroke")
	if not mat or not setupDirectStrokeMatrix(mat) then return end

	updateDirectMaterialUV(mat)
	if not directUvReady then return end
	surface.SetMaterial(mat)
	for i = 1, count do
		local x, y = directCell(i, w, h, ox, oy)
		drawDirectShaderRect(x, y)
	end
end

local function workloadDirectShaderShadow(panel, count, w, h, ox, oy)
	local mat = directStatusMaterial("shadowOuter")
	if not mat or not setupDirectShadowOuterMatrix(mat, true) then return end

	updateDirectMaterialUV(mat)
	if not directUvReady then return end
	surface.SetMaterial(mat)
	surface.SetDrawColor(255, 255, 255, 255)
	local spread = 12
	for i = 1, count do
		local x, y = directCell(i, w, h, ox, oy)
		drawDirectShaderRectSized(x + 2 - spread, y + 4 - spread, DIRECT_BOX_W + spread * 2, DIRECT_BOX_H + spread * 2)
	end
end

local function workloadDirectShaderOuter(panel, count, w, h, ox, oy)
	local mat = directStatusMaterial("shadowOuter")
	if not mat or not setupDirectShadowOuterMatrix(mat, false) then return end

	updateDirectMaterialUV(mat)
	if not directUvReady then return end
	surface.SetMaterial(mat)
	surface.SetDrawColor(255, 255, 255, 255)
	local spread = 14
	for i = 1, count do
		local x, y = directCell(i, w, h, ox, oy)
		drawDirectShaderRectSized(x - spread, y - spread, DIRECT_BOX_W + spread * 2, DIRECT_BOX_H + spread * 2)
	end
end

local function workloadDirectApiRoundedGradient(panel, count, w, h, ox, oy)
	for i = 1, count do
		local x, y = directCell(i, w, h, ox, oy)
		MGFX.RoundedBoxEx(x, y, DIRECT_BOX_W, DIRECT_BOX_H, DIRECT_API_GRADIENT_STYLE)
	end
end

local function workloadDirectApiRoundedFx(panel, count, w, h, ox, oy)
	for i = 1, count do
		local x, y = directCell(i, w, h, ox, oy)
		MGFX.RoundedBoxEx(x, y, DIRECT_BOX_W, DIRECT_BOX_H, DIRECT_API_FX_STYLE)
	end
end

local function workloadDirectApiRoundedStroke(panel, count, w, h, ox, oy)
	for i = 1, count do
		local x, y = directCell(i, w, h, ox, oy)
		MGFX.RoundedBoxEx(x, y, DIRECT_BOX_W, DIRECT_BOX_H, DIRECT_API_STROKE_STYLE)
	end
end

local function workloadDirectApiRoundedShadow(panel, count, w, h, ox, oy)
	for i = 1, count do
		local x, y = directCell(i, w, h, ox, oy)
		MGFX.RoundedBoxEx(x, y, DIRECT_BOX_W, DIRECT_BOX_H, DIRECT_API_SHADOW_STYLE)
	end
end

local function workloadDirectApiRoundedOuter(panel, count, w, h, ox, oy)
	for i = 1, count do
		local x, y = directCell(i, w, h, ox, oy)
		MGFX.RoundedBoxEx(x, y, DIRECT_BOX_W, DIRECT_BOX_H, DIRECT_API_OUTER_STYLE)
	end
end

local function workloadDirectApiRoundedFused(panel, count, w, h, ox, oy)
	for i = 1, count do
		local x, y = directCell(i, w, h, ox, oy)
		MGFX.RoundedBoxEx(x, y, DIRECT_BOX_W, DIRECT_BOX_H, DIRECT_API_FUSED_STYLE)
	end
end

local function workloadDirectApiRoundedBackdrop(panel, count, w, h, ox, oy)
	local capped = math.min(count, 42)
	for i = 1, capped do
		local x, y = directCell(i, w, h, ox, oy)
		MGFX.RoundedBoxEx(x, y, DIRECT_BOX_W, DIRECT_BOX_H, DIRECT_API_BACKDROP_STYLE)
	end
end

local function workloadDirectApiRoundedBox(panel, count, w, h, ox, oy)
	for i = 1, count do
		local x, y = directCell(i, w, h, ox, oy)
		MGFX.RoundedBoxEx(x, y, DIRECT_BOX_W, DIRECT_BOX_H, DIRECT_API_STYLE)
	end
end

local function directRoundImmediate()
	return assert(MGFX._internal and MGFX._internal.drawRoundRectImmediate, "MGFX direct immediate probe unavailable")
end

local function workloadDirectImmediateRoundedBox(panel, count, w, h, ox, oy)
	local drawImmediate = directRoundImmediate()
	for i = 1, count do
		local x, y = directCell(i, w, h, ox, oy)
		drawImmediate(x, y, DIRECT_BOX_W, DIRECT_BOX_H, DIRECT_API_STYLE)
	end
end

local function workloadDirectImmediateGradient(panel, count, w, h, ox, oy)
	local drawImmediate = directRoundImmediate()
	for i = 1, count do
		local x, y = directCell(i, w, h, ox, oy)
		drawImmediate(x, y, DIRECT_BOX_W, DIRECT_BOX_H, DIRECT_API_GRADIENT_STYLE)
	end
end

local function workloadDirectImmediateFx(panel, count, w, h, ox, oy)
	local drawImmediate = directRoundImmediate()
	for i = 1, count do
		local x, y = directCell(i, w, h, ox, oy)
		drawImmediate(x, y, DIRECT_BOX_W, DIRECT_BOX_H, DIRECT_API_FX_STYLE)
	end
end

local function workloadDirectImmediateStroke(panel, count, w, h, ox, oy)
	local drawImmediate = directRoundImmediate()
	for i = 1, count do
		local x, y = directCell(i, w, h, ox, oy)
		drawImmediate(x, y, DIRECT_BOX_W, DIRECT_BOX_H, DIRECT_API_STROKE_STYLE)
	end
end

local function workloadDirectImmediateShadow(panel, count, w, h, ox, oy)
	local drawImmediate = directRoundImmediate()
	for i = 1, count do
		local x, y = directCell(i, w, h, ox, oy)
		drawImmediate(x, y, DIRECT_BOX_W, DIRECT_BOX_H, DIRECT_API_SHADOW_STYLE)
	end
end

local function workloadDirectImmediateOuter(panel, count, w, h, ox, oy)
	local drawImmediate = directRoundImmediate()
	for i = 1, count do
		local x, y = directCell(i, w, h, ox, oy)
		drawImmediate(x, y, DIRECT_BOX_W, DIRECT_BOX_H, DIRECT_API_OUTER_STYLE)
	end
end

local function workloadDirectImmediateFused(panel, count, w, h, ox, oy)
	local drawImmediate = directRoundImmediate()
	for i = 1, count do
		local x, y = directCell(i, w, h, ox, oy)
		drawImmediate(x, y, DIRECT_BOX_W, DIRECT_BOX_H, DIRECT_API_FUSED_STYLE)
	end
end

local function workloadDirectImmediateBackdrop(panel, count, w, h, ox, oy)
	local drawImmediate = directRoundImmediate()
	local capped = math.min(count, 42)
	for i = 1, capped do
		local x, y = directCell(i, w, h, ox, oy)
		drawImmediate(x, y, DIRECT_BOX_W, DIRECT_BOX_H, DIRECT_API_BACKDROP_STYLE)
	end
end

function cpu.loops(count)
	return math.max(1, math.floor(tonumber(count) or 1) * cpu.repeatCount)
end

function cpu.internal(name)
	local internal = assert(MGFX._internal, "MGFX internal probe table unavailable")
	return assert(internal[name], "MGFX internal probe unavailable: " .. tostring(name))
end

function cpu.matrixMaterial()
	return assert(directStatusMaterial("roundrectSolid"), "MGFX roundrectSolid material unavailable for CPU probe")
end

function cpu.empty(panel, count, w, h, ox, oy)
	local loops = cpu.loops(count)
	for i = 1, loops do
	end
	cpu.sink = cpu.sink + loops
end

function cpu.matrixDirect(panel, count, w, h, ox, oy)
	local mat = cpu.matrixMaterial()
	local loops = cpu.loops(count)
	for i = 1, loops do
		if not setDirectMatrix(mat,
			0.282, 0.776, 0.921, 0.878,
			DIRECT_BOX_W, DIRECT_BOX_H, 0, DIRECT_RADIUS,
			0, 0, 1, 0,
			0, 0, 0, 0
		) then
			error("MGFX direct matrix probe failed")
		end
	end
	cpu.sink = cpu.sink + loops
end

function cpu.matrixCore(panel, count, w, h, ox, oy)
	local mat = cpu.matrixMaterial()
	local setup = cpu.internal("setupParamMatrix")
	local loops = cpu.loops(count)
	for i = 1, loops do
		setup(mat,
			0.282, 0.776, 0.921, 0.878,
			DIRECT_BOX_W, DIRECT_BOX_H, 0, DIRECT_RADIUS,
			0, 0, 1, 0,
			0, 0, 0, 0
		)
	end
	cpu.sink = cpu.sink + loops
end

function cpu.matrixRawHit(panel, count, w, h, ox, oy)
	local mat = cpu.matrixMaterial()
	local setup = cpu.internal("setupParamMatrixRaw")
	local loops = cpu.loops(count)
	setup(mat,
		0.282, 0.776, 0.921, 0.878,
		DIRECT_BOX_W, DIRECT_BOX_H, 0, DIRECT_RADIUS,
		0, 0, 1, 0,
		0, 0, 0, 0
	)
	for i = 1, loops do
		setup(mat,
			0.282, 0.776, 0.921, 0.878,
			DIRECT_BOX_W, DIRECT_BOX_H, 0, DIRECT_RADIUS,
			0, 0, 1, 0,
			0, 0, 0, 0
		)
	end
	cpu.sink = cpu.sink + loops
end

function cpu.matrixRawMiss(panel, count, w, h, ox, oy)
	local mat = cpu.matrixMaterial()
	local setup = cpu.internal("setupParamMatrixRaw")
	local loops = cpu.loops(count)
	for i = 1, loops do
		local wobble = (i % 2) * 0.001
		setup(mat,
			0.282 + wobble, 0.776, 0.921, 0.878,
			DIRECT_BOX_W, DIRECT_BOX_H, 0, DIRECT_RADIUS,
			0, 0, 1, 0,
			0, 0, 0, 0
		)
	end
	cpu.sink = cpu.sink + loops
end

function cpu.matrixRawMissLast(panel, count, w, h, ox, oy)
	local mat = cpu.matrixMaterial()
	local setup = cpu.internal("setupParamMatrixRaw")
	local loops = cpu.loops(count)
	for i = 1, loops do
		local wobble = (i % 2) * 0.001
		setup(mat,
			0.282, 0.776, 0.921, 0.878,
			DIRECT_BOX_W, DIRECT_BOX_H, 0, DIRECT_RADIUS,
			0, 0, 1, 0,
			0, 0, 0, wobble
		)
	end
	cpu.sink = cpu.sink + loops
end

function cpu.auxRawHit(panel, count, w, h, ox, oy)
	local mat = cpu.matrixMaterial()
	local setup = cpu.internal("setupExtraParamsRaw")
	local loops = cpu.loops(count)
	setup(mat,
		0.416, 0.886, 1, 0.361,
		9, 1.15, 1.7, 0,
		0, 0, 0, 0,
		0, 0, 0, 0
	)
	for i = 1, loops do
		setup(mat,
			0.416, 0.886, 1, 0.361,
			9, 1.15, 1.7, 0,
			0, 0, 0, 0,
			0, 0, 0, 0
		)
	end
	cpu.sink = cpu.sink + loops
end

function cpu.auxRawMiss(panel, count, w, h, ox, oy)
	local mat = cpu.matrixMaterial()
	local setup = cpu.internal("setupExtraParamsRaw")
	local loops = cpu.loops(count)
	for i = 1, loops do
		local wobble = (i % 2) * 0.001
		setup(mat,
			0.416 + wobble, 0.886, 1, 0.361,
			9, 1.15, 1.7, 0,
			0, 0, 0, 0,
			0, 0, 0, 0
		)
	end
	cpu.sink = cpu.sink + loops
end

function cpu.rawShadowStable(panel, count, w, h, ox, oy)
	local roundRaw = cpu.internal("roundRaw")
	local normalize = roundRaw.shadow
	local style = DIRECT_API_FUSED_STYLE.shadow
	local loops = cpu.loops(count)
	local enabled, r, g, b, a, sx, sy, width
	for i = 1, loops do
		enabled, r, g, b, a, sx, sy, width = normalize(style)
	end
	cpu.sink = cpu.sink + (enabled and (r + g + b + a + sx + sy + width) or 0)
end

function cpu.rawShadowChanging(panel, count, w, h, ox, oy)
	local roundRaw = cpu.internal("roundRaw")
	local normalize = roundRaw.shadow
	local style = cpu.shadowProbe
	local loops = cpu.loops(count)
	local enabled, r, g, b, a, sx
	for i = 1, loops do
		style.x = 2 + (i % 2)
		enabled, r, g, b, a, sx = normalize(style)
	end
	cpu.sink = cpu.sink + (enabled and (r + g + b + a + sx) or 0)
end

function cpu.rawOuterStable(panel, count, w, h, ox, oy)
	local roundRaw = cpu.internal("roundRaw")
	local normalize = roundRaw.outerGlow
	local style = DIRECT_API_FUSED_STYLE.outerGlow
	local loops = cpu.loops(count)
	local enabled, r, g, b, a, sx, sy, width
	for i = 1, loops do
		enabled, r, g, b, a, sx, sy, width = normalize(style)
	end
	cpu.sink = cpu.sink + (enabled and (r + g + b + a + sx + sy + width) or 0)
end

function cpu.rawOuterChanging(panel, count, w, h, ox, oy)
	local roundRaw = cpu.internal("roundRaw")
	local normalize = roundRaw.outerGlow
	local style = cpu.outerProbe
	local loops = cpu.loops(count)
	local enabled, r, g, b, a, sx, sy, width
	for i = 1, loops do
		style.width = 14 + (i % 2)
		enabled, r, g, b, a, sx, sy, width = normalize(style)
	end
	cpu.sink = cpu.sink + (enabled and (r + g + b + a + sx + sy + width) or 0)
end

function cpu.rawInnerStable(panel, count, w, h, ox, oy)
	local roundRaw = cpu.internal("roundRaw")
	local normalize = roundRaw.innerGlow
	local style = DIRECT_API_FX_STYLE.innerGlow
	local loops = cpu.loops(count)
	local enabled, r, g, b, a, width
	for i = 1, loops do
		enabled, r, g, b, a, width = normalize(style)
	end
	cpu.sink = cpu.sink + (enabled and (r + g + b + a + width) or 0)
end

function cpu.rawInnerChanging(panel, count, w, h, ox, oy)
	local roundRaw = cpu.internal("roundRaw")
	local normalize = roundRaw.innerGlow
	local style = cpu.innerProbe
	local loops = cpu.loops(count)
	local enabled, r, g, b, a, width
	for i = 1, loops do
		style.width = 9 + (i % 2)
		enabled, r, g, b, a, width = normalize(style)
	end
	cpu.sink = cpu.sink + (enabled and (r + g + b + a + width) or 0)
end

function cpu.styleTableReads(panel, count, w, h, ox, oy)
	local style = DIRECT_API_FUSED_STYLE
	local loops = cpu.loops(count)
	local sum = 0
	for i = 1, loops do
		local shadow = style.shadow
		local outer = style.outerGlow
		sum = sum
			+ (style.radius or 0)
			+ (style.strokeWidth or 0)
			+ (shadow and shadow.width or 0)
			+ (shadow and shadow.x or 0)
			+ (shadow and shadow.y or 0)
			+ (outer and outer.width or 0)
			+ (outer and outer.strength or 0)
	end
	cpu.sink = cpu.sink + sum
end

function cpu.styleLocalReads(panel, count, w, h, ox, oy)
	local style = DIRECT_API_FUSED_STYLE
	local radius = style.radius or 0
	local strokeWidth = style.strokeWidth or 0
	local shadow = style.shadow
	local outer = style.outerGlow
	local shadowWidth = shadow and shadow.width or 0
	local shadowX = shadow and shadow.x or 0
	local shadowY = shadow and shadow.y or 0
	local outerWidth = outer and outer.width or 0
	local outerStrength = outer and outer.strength or 0
	local loops = cpu.loops(count)
	local sum = 0
	for i = 1, loops do
		sum = sum + radius + strokeWidth + shadowWidth + shadowX + shadowY + outerWidth + outerStrength
	end
	cpu.sink = cpu.sink + sum
end

function cpu.callLocal(panel, count, w, h, ox, oy)
	local fn = cpu.leaf
	local loops = cpu.loops(count)
	local sum = 0
	for i = 1, loops do
		sum = sum + fn(1, 2, 3, 4)
	end
	cpu.sink = cpu.sink + sum
end

function cpu.callTable(panel, count, w, h, ox, oy)
	local probe = cpu.callProbe
	local loops = cpu.loops(count)
	local sum = 0
	for i = 1, loops do
		sum = sum + probe.leaf(1, 2, 3, 4)
	end
	cpu.sink = cpu.sink + sum
end

function cpu.callWrapper(panel, count, w, h, ox, oy)
	local fn = cpu.wrapper
	local loops = cpu.loops(count)
	local sum = 0
	for i = 1, loops do
		sum = sum + fn(1, 2, 3, 4)
	end
	cpu.sink = cpu.sink + sum
end

local function workloadRoundFill(panel, count, w, h, ox, oy)
	local columns = 12
	for i = 1, count do
		local x, y, col, row = seededCell(i, columns, 22, 28, 66, 34, ox, oy)
		MGFX.RoundedBoxEx(x, y, 48 + (col % 3) * 4, 20 + (row % 2) * 5, roundStyleFillOnly)
	end
end

local function workloadRoundFx(panel, count, w, h, ox, oy)
	local columns = 12
	for i = 1, count do
		local x, y, col, row = seededCell(i, columns, 22, 28, 66, 34, ox, oy)
		MGFX.RoundedBoxEx(x, y, 48 + (col % 3) * 4, 20 + (row % 2) * 5, roundStyleFx)
	end
end

local function workloadRoundLayered(panel, count, w, h, ox, oy)
	local columns = 12
	for i = 1, count do
		local x, y, col, row = seededCell(i, columns, 22, 28, 66, 34, ox, oy)
		local bw = 48 + (col % 3) * 4
		local bh = 20 + (row % 2) * 5
		MGFX.RoundedBoxEx(x, y, bw, bh, roundStyleFillOnly)
		MGFX.RoundedBoxEx(x, y, bw, bh, roundStyleLayerGlow)
		MGFX.RoundedBoxEx(x, y, bw, bh, roundStyleLayerStroke)
	end
end

local function workloadRoundChain(count, w, h, ox, oy)
	local columns = 10
	local rows = math.max(1, math.floor(math.max(42, (h or 0) - 54) / 42))
	local slots = math.max(1, columns * rows)
	for i = 1, count do
		local slot = (i - 1) % slots + 1
		local x, y, col, row = seededCell(slot, columns, 26, 30, 82, 42, ox, oy)
		MGFX.RoundedBoxEx(x, y, 58 + (col % 3) * 5, 24 + (row % 2) * 4, roundChainStyle)
	end
end

local function workloadRingFill(panel, count, w, h, ox, oy)
	local columns = 14
	for i = 1, count do
		local x, y, col = seededCell(i, columns, 40, 42, 56, 50, ox, oy)
		MGFX.RingEx(x + 18, y + 14, 15 + (col % 3), 5, ringStyleFillOnly)
	end
end

local function workloadRingFx(panel, count, w, h, ox, oy)
	local columns = 14
	for i = 1, count do
		local x, y, col = seededCell(i, columns, 40, 42, 56, 50, ox, oy)
		MGFX.RingEx(x + 18, y + 14, 15 + (col % 3), 5, ringStyleFx)
	end
end

local function workloadRingLayered(panel, count, w, h, ox, oy)
	local columns = 14
	for i = 1, count do
		local x, y, col = seededCell(i, columns, 40, 42, 56, 50, ox, oy)
		local r = 15 + (col % 3)
		MGFX.RingEx(x + 18, y + 14, r, 5, ringStyleFillOnly)
		MGFX.RingEx(x + 18, y + 14, r, 5, ringStyleLayerGlow)
		MGFX.RingEx(x + 18, y + 14, r, 5, ringStyleLayerStroke)
	end
end

local polyPointCache = {}

local function polyCacheKey(count, ox, oy)
	return tostring(count) .. ":" .. tostring(math.floor((ox or 0) * 10 + 0.5)) .. ":" .. tostring(math.floor((oy or 0) * 10 + 0.5))
end

local function polyPointsFor(count, ox, oy)
	local key = polyCacheKey(count, ox, oy)
	local cached = polyPointCache[key]
	if cached then return cached end

	cached = {}
	local columns = 12
	for i = 1, count do
		local x, y, col, row = seededCell(i, columns, 28, 32, 64, 42, ox, oy)
		local rw = 36 + (col % 3) * 4
		local rh = 23 + (row % 2) * 5
		cached[i] = {
			{x = x + 5, y = y},
			{x = x + rw, y = y + 4},
			{x = x + rw - 7, y = y + rh},
			{x = x, y = y + rh - 3},
		}
	end

	polyPointCache[key] = cached
	return cached
end

local function workloadPolyFill(panel, count, w, h, ox, oy)
	local points = polyPointsFor(count, ox, oy)
	for i = 1, count do
		MGFX.PolyEx(points[i], polyStyleFill)
	end
end

local function workloadPolyFx(panel, count, w, h, ox, oy)
	local points = polyPointsFor(count, ox, oy)
	for i = 1, count do
		MGFX.PolyEx(points[i], polyStyleFx)
	end
end

local function workloadLineGradient(panel, count, w, h, ox, oy)
	local columns = 10
	for i = 1, count do
		local x, y, col, row = seededCell(i, columns, 34, 40, 76, 32, ox, oy)
		local x2 = x + 46 + (col % 4) * 4
		local y2 = y + ((row % 3) - 1) * 7
		MGFX.LineEx(x, y, x2, y2, lineStyle)
	end
end

local textBatchRecords = {}

local function drawNativeTextRecords(count, ox, oy)
	local columns = 5
	for i = 1, count do
		local x, y, col = seededCell(i, columns, 36, 44, 154, 38, ox, oy)
		local value = (col % 2 == 0) and "PROFIT" or "初始商店"
		draw.SimpleText(value, "MGFXPerfText", x, y, Color(232, 244, 248), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end
end

local function drawTextRecords(count, ox, oy, style, batch)
	ensureTextFonts()
	local columns = 5
	if batch then
		table.Empty(textBatchRecords)
	end
	for i = 1, count do
		local x, y, col = seededCell(i, columns, 36, 44, 154, 38, ox, oy)
		local value = (col % 2 == 0) and "PROFIT" or "初始商店"
		if batch then
			textBatchRecords[#textBatchRecords + 1] = {
				text = value,
				font = "MGFXPerfTextSmall",
				x = x,
				y = y,
				color = Color(232, 244, 248),
				ax = TEXT_ALIGN_LEFT,
				ay = TEXT_ALIGN_CENTER,
				style = style,
			}
		else
			MGFX.TextEx(value, "MGFXPerfTextSmall", x, y, Color(232, 244, 248), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, style)
		end
	end

	if batch and MGFX.TextBatchEx then
		MGFX.TextBatchEx(textBatchRecords)
	end
end

local function workloadTextNative(panel, count, w, h, ox, oy)
	drawNativeTextRecords(count, ox, oy)
end

local function workloadTextPlain(panel, count, w, h, ox, oy)
	drawTextRecords(count, ox, oy, textStylePlain, false)
end

local function workloadTextGradient(panel, count, w, h, ox, oy)
	drawTextRecords(count, ox, oy, textStyleGradient, false)
end

local function workloadTextStroke(panel, count, w, h, ox, oy)
	drawTextRecords(count, ox, oy, textStyleStroke, false)
end

local function workloadTextGlow(panel, count, w, h, ox, oy)
	drawTextRecords(count, ox, oy, textStyleGlow, false)
end

local function workloadTextShadow(panel, count, w, h, ox, oy)
	drawTextRecords(count, ox, oy, textStyleShadow, false)
end

local function workloadTextFx(panel, count, w, h, ox, oy)
	drawTextRecords(count, ox, oy, textStyleFx, false)
end

local function workloadTextFxBatch(panel, count, w, h, ox, oy)
	drawTextRecords(count, ox, oy, textStyleFx, true)
end

local function workloadBlur(panel, count, w, h, ox, oy)
	local columns = 7
	local blurCount = math.min(count, 42)
	for i = 1, blurCount do
		local x, y, col, row = seededCell(i, columns, 28, 36, 108, 58, ox, oy)
		MGFX.RoundedBoxEx(x, y, 82 + (col % 3) * 7, 36 + (row % 2) * 5, blurStyle)
	end
end

local workloads = {
	{name = "empty", group = "base", title = "Empty frame", baseline = nil, color = COLORS.muted, fn = workloadEmpty, profileTop = false},
	{name = "direct.empty", group = "direct", title = "Raw surface empty baseline", baseline = nil, color = COLORS.muted, fn = workloadDirectEmpty, profileTop = false, hiddenFromAll = true, rawSurface = true},
	{name = "direct.native.rect", group = "direct", title = "Native surface.DrawRect only", baseline = "direct.empty", color = COLORS.green, fn = workloadDirectNativeRect, profileTop = false, hiddenFromAll = true, rawSurface = true},
	{name = "direct.shader.rect", group = "direct", title = "Bare roundrect_solid via DrawTexturedRectUV; matrix once", baseline = "direct.empty", color = COLORS.cyan, fn = workloadDirectShaderRectStatic, profileTop = false, hiddenFromAll = true, rawSurface = true},
	{name = "direct.shader.perdraw", group = "direct", title = "Bare roundrect_solid; matrix write every draw", baseline = "direct.empty", color = COLORS.gold, fn = workloadDirectShaderRectPerDraw, profileTop = false, hiddenFromAll = true, rawSurface = true},
	{name = "direct.mgfx.quad", group = "direct", title = "MGFX drawTexturedQuad helper; matrix once", baseline = "direct.empty", color = COLORS.cyan, fn = workloadDirectMgfxQuadStatic, profileTop = false, hiddenFromAll = true, rawSurface = true},
	{name = "direct.mgfx.quad.perdraw", group = "direct", title = "MGFX drawTexturedQuad helper; matrix every draw", baseline = "direct.empty", color = COLORS.gold, fn = workloadDirectMgfxQuadPerDraw, profileTop = false, hiddenFromAll = true, rawSurface = true},
	{name = "direct.shader.gradient", group = "direct", title = "Bare roundrect gradient base shader", baseline = "direct.empty", color = COLORS.blue, fn = workloadDirectShaderGradient, profileTop = false, hiddenFromAll = true, rawSurface = true},
	{name = "direct.shader.fx", group = "direct", title = "Bare roundrect_fx fill+stroke+innerGlow", baseline = "direct.empty", color = COLORS.purple, fn = workloadDirectShaderFx, profileTop = false, hiddenFromAll = true, rawSurface = true},
	{name = "direct.shader.fx.perdraw", group = "direct", title = "Bare roundrect_fx; matrices every draw", baseline = "direct.empty", color = COLORS.red, fn = workloadDirectShaderFxPerDraw, profileTop = false, hiddenFromAll = true, rawSurface = true},
	{name = "direct.shader.stroke", group = "direct", title = "Bare roundrect_stroke only", baseline = "direct.empty", color = COLORS.green, fn = workloadDirectShaderStroke, profileTop = false, hiddenFromAll = true, rawSurface = true},
	{name = "direct.shader.shadow", group = "direct", title = "Bare roundrect_shadow_outer shadow-only pass", baseline = "direct.empty", color = COLORS.muted, fn = workloadDirectShaderShadow, profileTop = false, hiddenFromAll = true, rawSurface = true},
	{name = "direct.shader.outer", group = "direct", title = "Bare roundrect_shadow_outer outer-only pass", baseline = "direct.empty", color = COLORS.cyan, fn = workloadDirectShaderOuter, profileTop = false, hiddenFromAll = true, rawSurface = true},
	{name = "direct.mgfx.empty", group = "direct", title = "MGFX StartPanel/clip empty baseline", baseline = nil, color = COLORS.muted, fn = workloadDirectEmpty, profileTop = false, hiddenFromAll = true},
	{name = "direct.immediate.rounded", group = "direct", title = "drawRoundRectImmediate same solid style", baseline = "direct.mgfx.empty", color = COLORS.red, fn = workloadDirectImmediateRoundedBox, hiddenFromAll = true},
	{name = "direct.immediate.gradient", group = "direct", title = "drawRoundRectImmediate gradient style", baseline = "direct.mgfx.empty", color = COLORS.blue, fn = workloadDirectImmediateGradient, hiddenFromAll = true},
	{name = "direct.immediate.fx", group = "direct", title = "drawRoundRectImmediate fill+stroke+innerGlow", baseline = "direct.mgfx.empty", color = COLORS.purple, fn = workloadDirectImmediateFx, hiddenFromAll = true},
	{name = "direct.immediate.stroke", group = "direct", title = "drawRoundRectImmediate stroke only", baseline = "direct.mgfx.empty", color = COLORS.green, fn = workloadDirectImmediateStroke, hiddenFromAll = true},
	{name = "direct.immediate.shadow", group = "direct", title = "drawRoundRectImmediate shadow only", baseline = "direct.mgfx.empty", color = COLORS.muted, fn = workloadDirectImmediateShadow, hiddenFromAll = true},
	{name = "direct.immediate.outer", group = "direct", title = "drawRoundRectImmediate outerGlow only", baseline = "direct.mgfx.empty", color = COLORS.cyan, fn = workloadDirectImmediateOuter, hiddenFromAll = true},
	{name = "direct.immediate.fused", group = "direct", title = "drawRoundRectImmediate fill+stroke+shadow+outer", baseline = "direct.mgfx.empty", color = COLORS.blue, fn = workloadDirectImmediateFused, hiddenFromAll = true},
	{name = "direct.immediate.backdrop", group = "direct", title = "drawRoundRectImmediate backdrop blur capped", baseline = "direct.mgfx.empty", color = COLORS.gold, fn = workloadDirectImmediateBackdrop, hiddenFromAll = true},
	{name = "direct.api.rounded", group = "direct", title = "MGFX.RoundedBoxEx same geometry/style", baseline = "direct.mgfx.empty", color = COLORS.red, fn = workloadDirectApiRoundedBox, hiddenFromAll = true},
	{name = "direct.api.gradient", group = "direct", title = "MGFX.RoundedBoxEx gradient style", baseline = "direct.mgfx.empty", color = COLORS.blue, fn = workloadDirectApiRoundedGradient, hiddenFromAll = true},
	{name = "direct.api.fx", group = "direct", title = "MGFX.RoundedBoxEx fill+stroke+innerGlow", baseline = "direct.mgfx.empty", color = COLORS.purple, fn = workloadDirectApiRoundedFx, hiddenFromAll = true},
	{name = "direct.api.stroke", group = "direct", title = "MGFX.RoundedBoxEx stroke only", baseline = "direct.mgfx.empty", color = COLORS.green, fn = workloadDirectApiRoundedStroke, hiddenFromAll = true},
	{name = "direct.api.shadow", group = "direct", title = "MGFX.RoundedBoxEx shadow only", baseline = "direct.mgfx.empty", color = COLORS.muted, fn = workloadDirectApiRoundedShadow, hiddenFromAll = true},
	{name = "direct.api.outer", group = "direct", title = "MGFX.RoundedBoxEx outerGlow only", baseline = "direct.mgfx.empty", color = COLORS.cyan, fn = workloadDirectApiRoundedOuter, hiddenFromAll = true},
	{name = "direct.api.fused", group = "direct", title = "MGFX.RoundedBoxEx fill+stroke+shadow+outer", baseline = "direct.mgfx.empty", color = COLORS.blue, fn = workloadDirectApiRoundedFused, hiddenFromAll = true},
	{name = "direct.api.backdrop", group = "direct", title = "MGFX.RoundedBoxEx backdrop blur capped", baseline = "direct.mgfx.empty", color = COLORS.gold, fn = workloadDirectApiRoundedBackdrop, hiddenFromAll = true},
	{name = "cpu.empty", group = "cpu", title = "Lua empty baseline; count x64 iterations", baseline = nil, color = COLORS.muted, fn = cpu.empty, profileTop = false, hiddenFromAll = true, rawSurface = true, countScale = cpu.repeatCount},
	{name = "cpu.matrix.direct", group = "cpu", title = "Direct Matrix:SetUnpacked + SetMatrix", baseline = "cpu.empty", color = COLORS.green, fn = cpu.matrixDirect, profileTop = false, hiddenFromAll = true, rawSurface = true, countScale = cpu.repeatCount},
	{name = "cpu.matrix.core", group = "cpu", title = "MGFX setupParamMatrix no raw-state cache", baseline = "cpu.empty", color = COLORS.cyan, fn = cpu.matrixCore, profileTop = false, hiddenFromAll = true, rawSurface = true, countScale = cpu.repeatCount},
	{name = "cpu.matrix.raw.hit", group = "cpu", title = "MGFX setupParamMatrixRaw same values", baseline = "cpu.empty", color = COLORS.blue, fn = cpu.matrixRawHit, profileTop = false, hiddenFromAll = true, rawSurface = true, countScale = cpu.repeatCount},
	{name = "cpu.matrix.raw.miss1", group = "cpu", title = "MGFX setupParamMatrixRaw mismatch at first slot", baseline = "cpu.empty", color = COLORS.gold, fn = cpu.matrixRawMiss, profileTop = false, hiddenFromAll = true, rawSurface = true, countScale = cpu.repeatCount},
	{name = "cpu.matrix.raw.miss16", group = "cpu", title = "MGFX setupParamMatrixRaw mismatch at final slot", baseline = "cpu.empty", color = COLORS.red, fn = cpu.matrixRawMissLast, profileTop = false, hiddenFromAll = true, rawSurface = true, countScale = cpu.repeatCount},
	{name = "cpu.aux.raw.hit", group = "cpu", title = "MGFX setupExtraParamsRaw same values", baseline = "cpu.empty", color = COLORS.blue, fn = cpu.auxRawHit, profileTop = false, hiddenFromAll = true, rawSurface = true, countScale = cpu.repeatCount},
	{name = "cpu.aux.raw.miss", group = "cpu", title = "MGFX setupExtraParamsRaw alternating values", baseline = "cpu.empty", color = COLORS.gold, fn = cpu.auxRawMiss, profileTop = false, hiddenFromAll = true, rawSurface = true, countScale = cpu.repeatCount},
	{name = "cpu.style.table", group = "cpu", title = "Repeated nested table reads from style", baseline = "cpu.empty", color = COLORS.red, fn = cpu.styleTableReads, profileTop = false, hiddenFromAll = true, rawSurface = true, countScale = cpu.repeatCount},
	{name = "cpu.style.locals", group = "cpu", title = "Same values hoisted into locals", baseline = "cpu.empty", color = COLORS.green, fn = cpu.styleLocalReads, profileTop = false, hiddenFromAll = true, rawSurface = true, countScale = cpu.repeatCount},
	{name = "cpu.call.local", group = "cpu", title = "Local function call per iteration", baseline = "cpu.empty", color = COLORS.green, fn = cpu.callLocal, profileTop = false, hiddenFromAll = true, rawSurface = true, countScale = cpu.repeatCount},
	{name = "cpu.call.table", group = "cpu", title = "Table function lookup + call per iteration", baseline = "cpu.empty", color = COLORS.gold, fn = cpu.callTable, profileTop = false, hiddenFromAll = true, rawSurface = true, countScale = cpu.repeatCount},
	{name = "cpu.call.wrapper", group = "cpu", title = "One wrapper layer around local function", baseline = "cpu.empty", color = COLORS.red, fn = cpu.callWrapper, profileTop = false, hiddenFromAll = true, rawSurface = true, countScale = cpu.repeatCount},
	{name = "cpu.raw.shadow.stable", group = "cpu", title = "roundRaw.shadow stable style table", baseline = "cpu.empty", color = COLORS.muted, fn = cpu.rawShadowStable, profileTop = false, hiddenFromAll = true, rawSurface = true, countScale = cpu.repeatCount},
	{name = "cpu.raw.shadow.changing", group = "cpu", title = "roundRaw.shadow changing table values", baseline = "cpu.empty", color = COLORS.red, fn = cpu.rawShadowChanging, profileTop = false, hiddenFromAll = true, rawSurface = true, countScale = cpu.repeatCount},
	{name = "cpu.raw.outer.stable", group = "cpu", title = "roundRaw.outerGlow stable style table", baseline = "cpu.empty", color = COLORS.cyan, fn = cpu.rawOuterStable, profileTop = false, hiddenFromAll = true, rawSurface = true, countScale = cpu.repeatCount},
	{name = "cpu.raw.outer.changing", group = "cpu", title = "roundRaw.outerGlow changing table values", baseline = "cpu.empty", color = COLORS.red, fn = cpu.rawOuterChanging, profileTop = false, hiddenFromAll = true, rawSurface = true, countScale = cpu.repeatCount},
	{name = "cpu.raw.inner.stable", group = "cpu", title = "roundRaw.innerGlow stable style table", baseline = "cpu.empty", color = COLORS.purple, fn = cpu.rawInnerStable, profileTop = false, hiddenFromAll = true, rawSurface = true, countScale = cpu.repeatCount},
	{name = "cpu.raw.inner.changing", group = "cpu", title = "roundRaw.innerGlow changing table values", baseline = "cpu.empty", color = COLORS.red, fn = cpu.rawInnerChanging, profileTop = false, hiddenFromAll = true, rawSurface = true, countScale = cpu.repeatCount},
	{name = "round.fill", group = "round", title = "RoundedBox fill only", baseline = "empty", color = COLORS.blue, fn = workloadRoundFill},
	{name = "round.fx", group = "round", title = "RoundedBox fill+stroke+innerGlow", baseline = "round.fill", color = COLORS.cyan, fn = workloadRoundFx},
	{name = "round.layered", group = "round", title = "RoundedBox same FX split into 3 calls", baseline = "round.fill", color = COLORS.purple, fn = workloadRoundLayered},
	{name = "ring.fill", group = "ring", title = "Ring fill only", baseline = "empty", color = COLORS.green, fn = workloadRingFill},
	{name = "ring.fx", group = "ring", title = "Ring fill+stroke+innerGlow", baseline = "ring.fill", color = COLORS.cyan, fn = workloadRingFx},
	{name = "ring.layered", group = "ring", title = "Ring same FX split into 3 calls", baseline = "ring.fill", color = COLORS.purple, fn = workloadRingLayered},
	{name = "poly.fill", group = "poly", title = "Poly fill shader", baseline = "empty", color = COLORS.gold, fn = workloadPolyFill},
	{name = "poly.fx", group = "poly", title = "Poly fill+stroke+outerGlow", baseline = "poly.fill", color = COLORS.cyan, fn = workloadPolyFx},
	{name = "line.gradient", group = "line", title = "Line gradient", baseline = "empty", color = COLORS.green, fn = workloadLineGradient},
	{name = "text.native", group = "text", title = "GMod draw.SimpleText baseline", baseline = "empty", color = COLORS.muted, fn = workloadTextNative},
	{name = "text.plain", group = "text", title = "MGFX TextEx plain route", baseline = "text.native", color = COLORS.muted, fn = workloadTextPlain},
	{name = "text.gradient", group = "text", title = "Text gradient fill only", baseline = "text.plain", color = COLORS.blue, fn = workloadTextGradient},
	{name = "text.stroke", group = "text", title = "Text fill+stroke", baseline = "text.plain", color = COLORS.purple, fn = workloadTextStroke},
	{name = "text.glow", group = "text", title = "Text fill+glow", baseline = "text.plain", color = COLORS.cyan, fn = workloadTextGlow},
	{name = "text.shadow", group = "text", title = "Text fill+shadow", baseline = "text.plain", color = COLORS.green, fn = workloadTextShadow},
	{name = "text.fx", group = "text", title = "Text stroke+glow+shadow", baseline = "text.plain", color = COLORS.gold, fn = workloadTextFx},
	{name = "text.fx.batch", group = "text", title = "Text same FX through TextBatchEx", baseline = "text.plain", color = COLORS.red, fn = workloadTextFxBatch},
	{name = "blur.round", group = "blur", title = "Backdrop blur rounded boxes", baseline = "empty", color = COLORS.red, fn = workloadBlur},
}

local workloadByName = {}
for _, item in ipairs(workloads) do
	workloadByName[item.name] = item
end

local PANEL = {}

function PANEL:Init()
	self:SetTitle("")
	self:ShowCloseButton(false)
	self:SetDraggable(true)
	self:SetSizable(true)
	self:SetMinWidth(math.min(ScrW() - 8, 1280))
	self:SetMinHeight(math.min(ScrH() - 6, 900))
	local frameW = math.min(ScrW() - 8, 1840)
	local frameH = math.min(ScrH() - 6, 1200)
	self:SetSize(frameW, frameH)
	self:SetPos(math.max(4, math.floor((ScrW() - frameW) * 0.5)), 3)
	self:MakePopup()
	self:SetKeyboardInputEnabled(true)
	self:SetAlpha(0)
	self:AlphaTo(255, 0.12, 0)

	self.samples = {}
	self.roundChainSample = nil
	self.frameIndex = 0
	self.lastProfileRows = {}
	self.previousProfile = cvarBool(profileCvarName)
	self.profileForced = false
	self.activeMode = cvarString(modeCvar, "all")
	self.lastCount = cvarInt(countCvar, 120, 1, 800)
	self.warmupFrames = cvarInt(warmupCvar, 30, 0, 300)
	self.rowScroll = 0

	setCvarBool(profileCvarName, true)
	self.profileForced = true

	self.closeButton = vgui.Create("DButton", self)
	self.closeButton:SetText("")
	self.closeButton.DoClick = function()
		self:Close()
	end
	self.closeButton.Paint = function(_, w, h)
		surface.SetDrawColor(44, 59, 68, 235)
		surface.DrawRect(0, 0, w, h)
		drawText("X", "MGFXPerfHeader", w * 0.5, h * 0.5 - 1, COLORS.text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	self.resetButton = vgui.Create("DButton", self)
	self.resetButton:SetText("")
	self.resetButton.DoClick = function()
		self:ResetSamples()
	end
	self.resetButton.Paint = function(_, w, h)
		surface.SetDrawColor(28, 51, 62, 235)
		surface.DrawRect(0, 0, w, h)
		drawText("RESET", "MGFXPerfHeader", w * 0.5, h * 0.5 - 1, COLORS.cyan, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	self:MakeModeButtons()
	self:InvalidateLayout(true)
	self:ResetSamples()
end

function PANEL:MakeModeButtons()
	self.modeButtons = {}
	local modes = {
		{"all", "ALL"},
		{"chain", "CHAIN"},
		{"direct", "DIRECT"},
		{"cpu", "CPU"},
		{"round", "ROUND"},
		{"ring", "RING"},
		{"poly", "POLY"},
		{"line", "LINE"},
		{"text", "TEXT"},
		{"blur", "BLUR"},
	}
	for _, mode in ipairs(modes) do
		local button = vgui.Create("DButton", self)
		button:SetText("")
		button._mode = mode[1]
		button._label = mode[2]
		button.DoClick = function()
			self.activeMode = button._mode
			RunConsoleCommand("mgfx_perf_mode", button._mode)
			self:ResetSamples()
		end
		button.Paint = function(btn, w, h)
			local active = self.activeMode == btn._mode
			surface.SetDrawColor(active and COLORS.cyan or Color(31, 48, 58, 235))
			surface.DrawRect(0, 0, w, h)
			drawText(btn._label, "MGFXPerfSmall", w * 0.5, h * 0.5 - 1, active and Color(3, 17, 23) or COLORS.text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		self.modeButtons[#self.modeButtons + 1] = button
	end
end

function PANEL:PerformLayout(w, h)
	if not self.closeButton or not self.resetButton or not self.modeButtons then return end

	self.closeButton:SetPos(w - 44, 12)
	self.closeButton:SetSize(30, 26)
	self.resetButton:SetPos(w - 120, 12)
	self.resetButton:SetSize(66, 26)
	local x = 30
	for _, button in ipairs(self.modeButtons or {}) do
		button:SetPos(x, 70)
		button:SetSize(72, 24)
		x = x + 78
	end
end

function PANEL:ResetSamples()
	self.samples = {}
	self.roundChainSample = nil
	self.frameIndex = 0
	self.lastProfileRows = {}
	self.rowScroll = 0
	if MGFX._internal and MGFX._internal.ResetStats then
		MGFX._internal.ResetStats()
	end
	RunConsoleCommand("mgfx_profile_reset")
end

function PANEL:OnMouseWheeled(delta)
	self.rowScroll = math.max(0, (self.rowScroll or 0) - delta * 3)
	return true
end

function PANEL:OnRemove()
	if self.profileForced then
		setCvarBool(profileCvarName, self.previousProfile)
	end
end

function PANEL:Close()
	self:Remove()
	if PerfPanel == self then
		PerfPanel = nil
	end
end

function PANEL:ActiveWorkloads()
	local mode = cvarString(modeCvar, self.activeMode or "all")
	if mode ~= self.activeMode then
		self.activeMode = mode
		self:ResetSamples()
	end
	local out = {}
	local included = {}
	local function addItem(item)
		if not item or included[item.name] then return end
		if item.baseline then
			addItem(workloadByName[item.baseline])
		end
		included[item.name] = true
		out[#out + 1] = item
	end

	if mode ~= "all" and mode ~= "direct" and mode ~= "cpu" then
		addItem(workloads[1])
	end

	for _, item in ipairs(workloads) do
		if (mode == "all" and not item.hiddenFromAll) or item.group == mode or item.name == mode then
			addItem(item)
		end
	end
	return out
end

function PANEL:RecordSample(item, elapsedMs, netMs, profileRows, statRows, count)
	local name = item and item.name
	if not name then return end
	local sample = self.samples[name]
	if not sample then
		sample = {
			last = 0,
			net = 0,
			avg = 0,
			netAvg = 0,
			min = math.huge,
			max = 0,
			n = 0,
			count = count or 0,
			profileRows = {},
			statRows = {},
		}
		self.samples[name] = sample
	end

	sample.last = elapsedMs
	sample.net = netMs
	sample.count = (count or sample.count or 0) * (item and item.countScale or 1)
	sample.profileRows = profileRows or sample.profileRows or {}
	sample.statRows = statRows or sample.statRows or {}
	if self.frameIndex <= self.warmupFrames then
		return
	end

	sample.n = sample.n + 1
	local alpha = sample.n == 1 and 1 or 0.07
	sample.avg = Lerp(alpha, sample.avg, elapsedMs)
	sample.netAvg = Lerp(alpha, sample.netAvg, netMs)
	sample.min = math.min(sample.min, elapsedMs)
	sample.max = math.max(sample.max, elapsedMs)
end

function PANEL:RunTimedWorkload(item, count, stageX, stageY, stageW, stageH)
	resetProfileStats()
	local before = cloneProfileTimes()
	local statBefore = cloneStats()
	local t0 = SysTime()
	if item.rawSurface then
		item.fn(self, count, stageW, stageH, stageX, stageY)
	else
		MGFX.StartPanel(self, self:GetWide(), self:GetTall())
		MGFX.PushClip(stageX, stageY, stageW, stageH)
		item.fn(self, count, stageW, stageH, stageX, stageY)
		MGFX.PopClip()
		MGFX.EndPanel()
	end
	local elapsed = (SysTime() - t0) * 1000
	local after = cloneProfileTimes()
	local statAfter = cloneStats()
	return elapsed, profileDelta(before, after), statDelta(statBefore, statAfter)
end

function PANEL:RunRoundChainTrace(count, stageX, stageY, stageW, stageH)
	local profiler = MGFX.Profiler
	if not profiler or not profiler.BeginTrace or not profiler.EndTrace then
		return 0, nil
	end

	resetProfileStats()
	MGFX.StartPanel(self, self:GetWide(), self:GetTall())
	MGFX.PushClip(stageX, stageY, stageW, stageH)

	local t0 = SysTime()
	profiler.BeginTrace("roundrect.fullChain")
	local workloadTrace = profiler.TraceStart and profiler.TraceStart("perf.workload.roundrect")
	workloadRoundChain(count, stageW, stageH, stageX, stageY)
	if workloadTrace and profiler.TraceEnd then profiler.TraceEnd(workloadTrace) end
	local trace = profiler.EndTrace()
	local elapsed = (SysTime() - t0) * 1000

	MGFX.PopClip()
	MGFX.EndPanel()
	return elapsed, trace
end

function PANEL:RecordRoundChainSample(elapsedMs, trace, count)
	local sample = self.roundChainSample
	if not sample then
		sample = {
			last = 0,
			avg = 0,
			min = math.huge,
			max = 0,
			n = 0,
			count = count or 0,
			trace = nil,
		}
		self.roundChainSample = sample
	end

	sample.last = elapsedMs
	sample.count = count or sample.count
	sample.trace = trace or sample.trace
	if self.frameIndex <= self.warmupFrames then
		return
	end

	sample.n = sample.n + 1
	local alpha = sample.n == 1 and 1 or 0.07
	sample.avg = Lerp(alpha, sample.avg, elapsedMs)
	sample.min = math.min(sample.min, elapsedMs)
	sample.max = math.max(sample.max, elapsedMs)
end

function PANEL:PaintRoundChain(w, h, count, warmup)
	local stageX, stageY = 30, 108
	local stageW = math.max(360, w - 60)
	local stageH = 86

	surface.SetDrawColor(COLORS.panel)
	surface.DrawRect(22, stageY - 8, stageW + 16, stageH + 16)
	surface.SetDrawColor(COLORS.line)
	surface.DrawOutlinedRect(22, stageY - 8, stageW + 16, stageH + 16, 1)
	drawBackgroundPattern(stageX, stageY, stageW, stageH)

	local elapsed, trace = self:RunRoundChainTrace(count, stageX, stageY, stageW, stageH)
	self:RecordRoundChainSample(elapsed, trace, count)

	local sample = self.roundChainSample or {}
	local titleY = stageY + stageH + 12
	drawText("roundrect full chain", "MGFXPerfHeader", 30, titleY, COLORS.text)
	drawText(
		"one RoundedBoxEx workload traced as a parent/child span tree; total is inclusive, self excludes child spans",
		"MGFXPerfText",
		30,
		titleY + 24,
		COLORS.muted
	)
	drawText(
		"count " .. tostring(count)
			.. "  last " .. fmt(sample.last or 0)
			.. "  avg " .. (sample.n and sample.n > 0 and fmt(sample.avg) or "--")
			.. "  min/max " .. ((sample.min and sample.min ~= math.huge) and fmt(sample.min) or "--") .. "/" .. ((sample.max and sample.max > 0) and fmt(sample.max) or "--"),
		"MGFXPerfMono",
		w - 34,
		titleY + 2,
		COLORS.cyan,
		TEXT_ALIGN_RIGHT
	)

	local treeX = 30
	local treeY = titleY + 50
	local treeW = w - 60
	local treeH = h - treeY - 28
	self:PaintRoundChainTree(treeX, treeY, treeW, treeH, sample.trace)

	local warmupLeft = math.max(0, (warmup or 0) - (self.frameIndex or 0))
	if warmupLeft > 0 then
		drawText("warming " .. tostring(warmupLeft), "MGFXPerfHeader", treeX + treeW - 6, treeY - 28, COLORS.gold, TEXT_ALIGN_RIGHT)
	end
end

function PANEL:PaintRoundChainTree(x, y, w, h, trace)
	surface.SetDrawColor(COLORS.panel2)
	surface.DrawRect(x - 8, y - 8, w + 16, h + 16)
	surface.SetDrawColor(COLORS.line)
	surface.DrawOutlinedRect(x - 8, y - 8, w + 16, h + 16, 1)

	local rows = flattenTraceRows(trace) or {}
	local rowHeight = 18
	local headerHeight = 24
	local visibleRows = math.max(1, math.floor((h - headerHeight - 6) / rowHeight))
	local maxScroll = math.max(0, #rows - visibleRows)
	self.rowScroll = math.Clamp(math.floor(self.rowScroll or 0), 0, maxScroll)

	local countW = 82
	local numW = 86
	local maxW = 86
	local avgW = 86
	local gap = 12
	local right = x + w
	local maxX = right - maxW
	local avgX = maxX - gap - avgW
	local countX = avgX - gap - countW
	local selfX = countX - gap - numW
	local totalX = selfX - gap - numW
	local spanW = math.max(220, totalX - x - gap)

	drawCell("span", "MGFXPerfHeader", x + 10, y, spanW, COLORS.text)
	drawCell("total", "MGFXPerfHeader", totalX, y, numW, COLORS.text, TEXT_ALIGN_RIGHT)
	drawCell("self", "MGFXPerfHeader", selfX, y, numW, COLORS.text, TEXT_ALIGN_RIGHT)
	drawCell("count", "MGFXPerfHeader", countX, y, countW, COLORS.text, TEXT_ALIGN_RIGHT)
	drawCell("avg", "MGFXPerfHeader", avgX, y, avgW, COLORS.text, TEXT_ALIGN_RIGHT)
	drawCell("max", "MGFXPerfHeader", maxX, y, maxW, COLORS.text, TEXT_ALIGN_RIGHT)

	if #rows == 0 then
		drawText("trace unavailable", "MGFXPerfText", x + 10, y + headerHeight, COLORS.muted)
		return
	end

	local rowY = y + headerHeight
	for i = self.rowScroll + 1, math.min(#rows, self.rowScroll + visibleRows) do
		local row = rows[i]
		local indent = math.min(180, (row.depth or 0) * 16)
		local color = row.depth == 0 and COLORS.cyan or ((row.self or 0) > 0.05 and COLORS.text or COLORS.muted)
		if i % 2 == 0 then
			surface.SetDrawColor(255, 255, 255, 6)
			surface.DrawRect(x - 2, rowY - 2, w + 4, rowHeight)
		end
		drawCell(row.name, "MGFXPerfSmall", x + 10 + indent, rowY, spanW - indent, color)
		drawCell(fmt(row.total), "MGFXPerfSmall", totalX, rowY, numW, COLORS.text, TEXT_ALIGN_RIGHT)
		drawCell(fmt(row.self), "MGFXPerfSmall", selfX, rowY, numW, row.self > 0.05 and COLORS.gold or COLORS.muted, TEXT_ALIGN_RIGHT)
		drawCell(tostring(row.count), "MGFXPerfSmall", countX, rowY, countW, COLORS.muted, TEXT_ALIGN_RIGHT)
		drawCell(fmt(traceAvg(row)), "MGFXPerfSmall", avgX, rowY, avgW, COLORS.cyan, TEXT_ALIGN_RIGHT)
		drawCell(fmt(row.max), "MGFXPerfSmall", maxX, rowY, maxW, COLORS.muted, TEXT_ALIGN_RIGHT)
		rowY = rowY + rowHeight
	end

	if maxScroll > 0 then
		drawText("scroll " .. tostring(self.rowScroll + 1) .. "/" .. tostring(maxScroll + 1), "MGFXPerfSmall", x + w - 6, y + h - 18, COLORS.muted, TEXT_ALIGN_RIGHT)
	end
end

function PANEL:Paint(w, h)
	ensureFonts()
	ensureTextFonts()

	local count = cvarInt(countCvar, 120, 1, 800)
	local warmup = cvarInt(warmupCvar, 30, 0, 300)
	if count ~= self.lastCount or warmup ~= self.warmupFrames then
		self.lastCount = count
		self.warmupFrames = warmup
		self:ResetSamples()
	end
	local mode = cvarString(modeCvar, self.activeMode or "all")
	if mode ~= self.activeMode then
		self.activeMode = mode
		self:ResetSamples()
	end

	self.frameIndex = self.frameIndex + 1

	surface.SetDrawColor(COLORS.bg)
	surface.DrawRect(0, 0, w, h)
	surface.SetDrawColor(0, 0, 0, 80)
	surface.DrawOutlinedRect(0, 0, w, h, 1)

	drawText("MGFX real-time profile", "MGFXPerfTitle", 28, 18, COLORS.text)
	drawText("SysTime wraps real StartPanel / draw workload / EndPanel. Warmup frames are ignored in rolling averages.", "MGFXPerfText", 30, 46, COLORS.muted)
	drawText("count " .. tostring(count) .. "  warmup " .. tostring(warmup) .. "  mgfx_profile " .. tostring(cvarBool(profileCvarName)), "MGFXPerfMono", w - 150, 48, COLORS.muted, TEXT_ALIGN_RIGHT)

	if self.activeMode == "chain" then
		self:PaintRoundChain(w, h, count, warmup)
		return
	end

	local active = self:ActiveWorkloads()
	local stageX, stageY = 30, 108
	local stageW = math.max(360, w - 60)
	local stageH = (self.activeMode == "text" or self.activeMode == "cpu") and 178 or 238

	surface.SetDrawColor(COLORS.panel)
	surface.DrawRect(22, stageY - 8, stageW + 16, stageH + 16)
	surface.SetDrawColor(COLORS.line)
	surface.DrawOutlinedRect(22, stageY - 8, stageW + 16, stageH + 16, 1)

	local baselineElapsed = {}
	for _, item in ipairs(active) do
		drawBackgroundPattern(stageX, stageY, stageW, stageH)
		local elapsed, profileRows, statRows = self:RunTimedWorkload(item, count, stageX, stageY, stageW, stageH)
		baselineElapsed[item.name] = elapsed
		local base = item.baseline and baselineElapsed[item.baseline]
		local net = base and (elapsed - base) or elapsed
		self:RecordSample(item, elapsed, net, profileRows, statRows, count)
	end

	drawText("measurement stage", "MGFXPerfSmall", 30, stageY + stageH + 14, COLORS.muted)

	local listY = stageY + stageH + 42
	self:PaintRows(30, listY, w - 60, h - listY - 24, active)
end

function PANEL:PaintRows(x, y, w, h, active)
	surface.SetDrawColor(COLORS.panel2)
	surface.DrawRect(x - 8, y - 8, w + 16, h + 16)
	surface.SetDrawColor(COLORS.line)
	surface.DrawOutlinedRect(x - 8, y - 8, w + 16, h + 16, 1)

	local rowCount = 0
	for _, item in ipairs(active) do
		if self.samples[item.name] then rowCount = rowCount + 1 end
	end
	local rowHeight = 38
	local headerHeight = 30
	local visibleRows = math.max(1, math.floor((h - headerHeight - 6) / rowHeight))
	local maxScroll = math.max(0, rowCount - visibleRows)
	self.rowScroll = math.Clamp(math.floor(self.rowScroll or 0), 0, maxScroll)

	local statsW = math.max(120, math.min(190, w * 0.12))
	local numW = 70
	local minMaxW = 118
	local gap = 14
	local right = x + w
	local statsX = right - statsW
	local minMaxX = statsX - gap - minMaxW
	local netX = minMaxX - gap - numW
	local avgX = netX - gap - numW
	local lastX = avgX - gap - numW
	local profileX = math.max(x + 360, lastX - gap - math.max(260, w * 0.24))
	local nameW = math.max(320, profileX - x - gap)
	local profileW = math.max(120, lastX - gap - profileX)

	self.rowLayout = {
		rowHeight = rowHeight,
		nameX = x + 10,
		nameW = nameW - 10,
		profileX = profileX,
		profileW = profileW,
		lastX = lastX,
		avgX = avgX,
		netX = netX,
		minMaxX = minMaxX,
		statsX = statsX,
		statsW = statsW,
		numW = numW,
		minMaxW = minMaxW,
	}

	drawCell("workload", "MGFXPerfHeader", x + 10, y, nameW - 10, COLORS.text)
	drawCell("profile top real ms", "MGFXPerfHeader", profileX, y, profileW, COLORS.text)
	drawCell("last", "MGFXPerfHeader", lastX, y, numW, COLORS.text, TEXT_ALIGN_RIGHT)
	drawCell("avg", "MGFXPerfHeader", avgX, y, numW, COLORS.text, TEXT_ALIGN_RIGHT)
	drawCell("net avg", "MGFXPerfHeader", netX, y, numW, COLORS.text, TEXT_ALIGN_RIGHT)
	drawCell("min/max", "MGFXPerfHeader", minMaxX, y, minMaxW, COLORS.text, TEXT_ALIGN_RIGHT)
	drawCell("stats", "MGFXPerfHeader", statsX, y, statsW, COLORS.text)

	local warmupLeft = math.max(0, (self.warmupFrames or 0) - (self.frameIndex or 0))
	if warmupLeft > 0 then
		drawText("warming " .. tostring(warmupLeft), "MGFXPerfHeader", x + w - 6, y, COLORS.gold, TEXT_ALIGN_RIGHT)
	end

	local rowY = y + headerHeight
	local rowIndex = 0
	for _, item in ipairs(active) do
		local sample = self.samples[item.name]
		if sample then
			if rowIndex >= self.rowScroll and rowIndex < self.rowScroll + visibleRows then
				self:PaintRow(item, sample, x, rowY, w)
				rowY = rowY + rowHeight
			end
			rowIndex = rowIndex + 1
		end
	end

	if maxScroll > 0 then
		drawText("scroll " .. tostring(self.rowScroll + 1) .. "/" .. tostring(maxScroll + 1), "MGFXPerfSmall", x + w - 6, y + h - 18, COLORS.muted, TEXT_ALIGN_RIGHT)
	end
end

function PANEL:PaintRow(item, sample, x, y, w)
	local color = item.color or COLORS.text
	surface.SetDrawColor(255, 255, 255, 8)
	surface.DrawRect(x - 2, y - 4, w + 4, 35)
	surface.SetDrawColor(color.r, color.g, color.b, 190)
	surface.DrawRect(x - 2, y - 4, 3, 35)

	local layout = self.rowLayout or {}
	local numW = layout.numW or 70
	local minMaxW = layout.minMaxW or 118
	local nameX = layout.nameX or x + 10
	local nameW = layout.nameW or 300
	local profileX = layout.profileX or x + 700
	local profileW = layout.profileW or 300

	drawCell(item.name, "MGFXPerfMono", nameX, y - 1, math.min(250, nameW), color)
	local title = item.title
	if item.countScale then
		title = title .. "  n=" .. tostring(sample.count or 0)
	end
	drawCell(title, "MGFXPerfSmall", nameX, y + 16, nameW, COLORS.muted)
	drawCell(fmt(sample.last), "MGFXPerfMono", layout.lastX or x + 300, y - 1, numW, COLORS.text, TEXT_ALIGN_RIGHT)
	drawCell(sample.n > 0 and fmt(sample.avg) or "--", "MGFXPerfMono", layout.avgX or x + 390, y - 1, numW, sample.n > 0 and COLORS.cyan or COLORS.muted, TEXT_ALIGN_RIGHT)
	drawCell(sample.n > 0 and fmt(sample.netAvg) or "--", "MGFXPerfMono", layout.netX or x + 486, y - 1, numW, sample.netAvg > 0 and COLORS.gold or COLORS.green, TEXT_ALIGN_RIGHT)

	local minValue = sample.min ~= math.huge and fmt(sample.min) or "--"
	local maxValue = sample.max > 0 and fmt(sample.max) or "--"
	drawCell(minValue .. "/" .. maxValue, "MGFXPerfMono", layout.minMaxX or x + 610, y - 1, minMaxW, COLORS.muted, TEXT_ALIGN_RIGHT)

	local statsText = formatStatDelta(sample.statRows, item.group == "text")
	if statsText ~= "" then
		drawCell(statsText, "MGFXPerfSmall", layout.statsX or x + 632, y + 1, layout.statsW or 160, COLORS.cyan)
	end

	local rows = displayProfileRows(item, sample.profileRows or {})
	if #rows == 0 then
		drawCell("none", "MGFXPerfSmall", profileX, y + 1, profileW, COLORS.muted)
		return
	end
	local px = profileX
	local maxRight = profileX + profileW
	local compact = profileRowsCompact(item)
	for i = 1, math.min(profileSegmentLimit(item), #rows) do
		local row = rows[i]
		local segment = profileSegmentText(row, compact)
		surface.SetFont("MGFXPerfSmall")
		local segmentW = math.min(profileSegmentMaxWidth(compact), surface.GetTextSize(segment) + 14)
		if px + segmentW > maxRight then
			if i == 1 then
				drawCell(segment, "MGFXPerfSmall", px, y + 1, math.max(20, maxRight - px), COLORS.green)
			end
			break
		end
		drawCell(segment, "MGFXPerfSmall", px, y + 1, segmentW, i == 1 and COLORS.green or COLORS.muted)
		surface.SetFont("MGFXPerfSmall")
		px = px + segmentW + 8
	end
end

vgui.Register("MGFXPerfDemoPanel", PANEL, "DFrame")

local function openPerfDemo()
	if IsValid(PerfPanel) then
		PerfPanel:Remove()
	end
	PerfPanel = vgui.Create("MGFXPerfDemoPanel")
	print("[MGFX] perf demo opened: mgfx_perf_count controls load, mgfx_perf_mode filters groups")
end

local function closePerfDemo()
	if IsValid(PerfPanel) then
		PerfPanel:Close()
	end
end

addCommand("mgfx_perf_demo", openPerfDemo)
addCommand("mgfx_perf_demo_close", closePerfDemo)
