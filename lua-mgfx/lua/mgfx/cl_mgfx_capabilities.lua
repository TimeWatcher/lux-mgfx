if SERVER then return end

MGFX = MGFX or {}

function MGFX._InstallCapabilities(owner)
	owner = owner or MGFX

	local TARGET = owner.TARGET or {}

	local function set(list)
		local out = {}
		for _, key in ipairs(list or {}) do
			out[key] = true
		end
		return out
	end

	local shapeKeys = {
		"fill",
		"stroke",
		"strokeWidth",
		"shadow",
		"outerGlow",
		"innerGlow",
		"backdrop",
		"pattern",
		"transform",
	}

	local caps = {
		[TARGET.ROUNDED_BOX] = {
			family = "shape",
			coverage = "roundedBox",
			keys = set(shapeKeys),
		},
		[TARGET.CIRCLE] = {
			family = "shape",
			coverage = "circle",
			keys = set(shapeKeys),
		},
		[TARGET.CAPSULE] = {
			family = "shape",
			coverage = "capsule",
			keys = set(shapeKeys),
		},
		[TARGET.CHAMFER_BOX] = {
			family = "shape",
			coverage = "chamferBox",
			keys = set({
				"fill",
				"stroke",
				"strokeWidth",
				"shadow",
				"outerGlow",
				"innerGlow",
				"backdrop",
				"pattern",
				"cuts",
				"transform",
			}),
		},
		[TARGET.POLY] = {
			family = "shape",
			coverage = "convexPoly",
			keys = set({
				"fill",
				"stroke",
				"strokeWidth",
				"shadow",
				"outerGlow",
				"backdrop",
				"pattern",
				"transform",
			}),
		},
		[TARGET.LINE] = {
			family = "shape",
			coverage = "line",
			keys = set({
				"fill",
				"color",
				"width",
				"radius",
				"caps",
				"noCaps",
				"outerGlow",
				"backdrop",
				"transform",
			}),
		},
		[TARGET.RING] = {
			family = "shape",
			coverage = "ring",
			keys = set({
				"fill",
				"color",
				"stroke",
				"strokeWidth",
				"shadow",
				"outerGlow",
				"innerGlow",
				"backdrop",
				"pattern",
				"transform",
			}),
		},
		[TARGET.ARC] = {
			family = "shape",
			coverage = "arc",
			keys = set({
				"fill",
				"color",
				"stroke",
				"strokeWidth",
				"shadow",
				"outerGlow",
				"innerGlow",
				"backdrop",
				"pattern",
				"transform",
			}),
		},
		[TARGET.SECTOR] = {
			family = "shape",
			coverage = "sector",
			keys = set({
				"fill",
				"color",
				"stroke",
				"strokeWidth",
				"shadow",
				"outerGlow",
				"innerGlow",
				"backdrop",
				"pattern",
				"transform",
			}),
		},
		[TARGET.IMAGE] = {
			family = "content",
			coverage = "imageMask",
			keys = set({
				"source",
				"fill",
				"background",
				"stroke",
				"strokeWidth",
				"shadow",
				"outerGlow",
				"backdrop",
				"mask",
				"radius",
				"tint",
				"color",
				"alpha",
				"fit",
				"objectFit",
				"position",
				"positionX",
				"positionY",
				"alignX",
				"alignY",
				"crop",
				"uv",
				"transform",
			}),
		},
		[TARGET.PROGRESS_BAR] = {
			family = "compound",
			coverage = "progress",
			keys = set({
				"track",
				"fill",
				"stroke",
				"strokeWidth",
				"radius",
				"padding",
				"shadow",
				"outerGlow",
				"innerGlow",
				"backdrop",
				"fillPattern",
				"trackPattern",
				"pattern",
				"fx",
				"transform",
			}),
		},
		[TARGET.SEGMENT_BAR] = {
			family = "compound",
			coverage = "segmentBar",
			keys = set({
				"segments",
				"gap",
				"track",
				"fill",
				"stroke",
				"strokeWidth",
				"radius",
				"background",
				"backgroundRadius",
				"shadow",
				"outerGlow",
				"innerGlow",
				"backdrop",
				"fillPattern",
				"trackPattern",
				"pattern",
				"transform",
			}),
		},
		[TARGET.TEXT] = {
			family = "text",
			coverage = "glyph",
			keys = set({
				"fill",
				"color",
				"alignX",
				"alignY",
				"valign",
				"shadow",
				"stroke",
				"glow",
				"weight",
				"italic",
				"letterSpacing",
				"lineHeight",
			}),
		},
	}

	local function targetCaps(target)
		return caps[target]
	end

	local function isPattern(value)
		return istable(value) and (value.kind == "stripe" or value.kind == "smoke")
	end

	local function isFill(value)
		if not istable(value) then return true end
		return value.r ~= nil or value.kind == 0 or value.kind == 1 or value.kind == 2 or value.kind == 3
	end

	local function normalizePaintSlots(style, target)
		if not istable(style) then return style end
		if not isPattern(style.fill) then return style end

		if target == TARGET.PROGRESS_BAR or target == TARGET.SEGMENT_BAR then
			style = table.Copy(style)
			if style.fillPattern == nil then style.fillPattern = style.fill end
			style.fill = style.fillBase or style.baseFill or nil
			return style
		end

		local cap = targetCaps(target)
		if cap and cap.keys and cap.keys.pattern and style.pattern == nil then
			style = table.Copy(style)
			style.pattern = style.fill
			style.fill = style.patternBase or style.baseFill or Color(0, 0, 0, 0)
		end

		return style
	end

	local function normalizeStyle(style, target)
		if not istable(style) then return style end
		return normalizePaintSlots(style, target)
	end

	function owner.GetCapabilities(target)
		return targetCaps(target)
	end

	function owner.Supports(target, key)
		local cap = targetCaps(target)
		return cap and cap.keys and cap.keys[key] == true or false
	end

	return {
		caps = caps,
		targetCaps = targetCaps,
		isPattern = isPattern,
		isFill = isFill,
		normalizeStyle = normalizeStyle,
	}
end
