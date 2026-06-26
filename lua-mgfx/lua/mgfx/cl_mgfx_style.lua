if SERVER then return end

MGFX = MGFX or {}

function MGFX._InstallStyle(owner)
	owner = owner or MGFX

	local math_abs = math.abs
	local math_floor = math.floor
	local math_max = math.max
	local surface_SetDrawColor = surface.SetDrawColor

	local FILL_SOLID = 0
	local FILL_LINEAR = 1
	local FILL_RADIAL = 2
	local FILL_CONIC = 3
	local transparentColor = Color(0, 0, 0, 0)
	local solidColorCache = setmetatable({}, {__mode = "kv"})
	local backdropTableCache = setmetatable({}, {__mode = "k"})
	local backdropColorCache = setmetatable({}, {__mode = "k"})
	local backdropNumberCache = {}
	local backdropTrueSpec

	local function asColor(value, fallback)
		if istable(value) and value.r and value.g and value.b then return value end
		return fallback or color_white
	end

	local function color01(color)
		return math.Clamp((color.r or 0) / 255, 0, 1),
			math.Clamp((color.g or 0) / 255, 0, 1),
			math.Clamp((color.b or 0) / 255, 0, 1),
			math.Clamp((color.a == nil and 255 or color.a) / 255, 0, 1)
	end

	local function setDrawColor(color)
		surface_SetDrawColor(color.r or 255, color.g or 255, color.b or 255, color.a == nil and 255 or color.a)
	end

	local function strokeWidthValue(value, fallback)
		if value == true then return fallback or 1 end
		if isstring(value) then
			local lower = string.lower(value)
			if lower == "hairline" then return 0.75 end
			if lower == "thin" then return 1 end
			if lower == "none" then return 0 end
		end

		return tonumber(value) or fallback or 0
	end

	local function radiusTuple(radius, w, h)
		local tl, tr, br, bl
		if istable(radius) then
			tl = tonumber(radius.tl or radius[1]) or 0
			tr = tonumber(radius.tr or radius[2]) or tl
			br = tonumber(radius.br or radius[3]) or tr
			bl = tonumber(radius.bl or radius[4]) or br
		else
			tl = tonumber(radius) or 0
			tr, br, bl = tl, tl, tl
		end

		tl, tr, br, bl = math_max(0, tl), math_max(0, tr), math_max(0, br), math_max(0, bl)
		local scale = math_max(1, (tl + tr) / w, (bl + br) / w, (tl + bl) / h, (tr + br) / h)
		if scale > 1 then
			tl, tr, br, bl = tl / scale, tr / scale, br / scale, bl / scale
		end

		return tl, tr, br, bl
	end

	local function radiusScalar(radius, w, h)
		local tl, tr, br, bl = radiusTuple(radius, w, h)
		return math_max(tl, tr, br, bl)
	end

	local function normalizeStops(stops)
		if not istable(stops) then return nil end

		local out = {}
		for i, stop in ipairs(stops) do
			if istable(stop) then
				local pos = stop.pos or stop.t or stop.offset or stop[1]
				local color = stop.color or stop[2]
				if color == nil and stop.r then
					color = stop
					pos = (#stops <= 1) and 0 or (i - 1) / (#stops - 1)
				end

				if color ~= nil then
					out[#out + 1] = {
						pos = math.Clamp(tonumber(pos) or ((#stops <= 1) and 0 or (i - 1) / (#stops - 1)), 0, 1),
						color = asColor(color, color_white),
					}
				end
			end
		end

		if #out == 0 then return nil end
		table.sort(out, function(a, b) return a.pos < b.pos end)

		if out[1].pos > 0 then
			table.insert(out, 1, {pos = 0, color = out[1].color})
		end

		if out[#out].pos < 1 then
			out[#out + 1] = {pos = 1, color = out[#out].color}
		end

		return out
	end

	local function firstLastStops(stops)
		stops = normalizeStops(stops)
		local first = stops and stops[1]
		local last = stops and stops[#stops]
		if first and last then
			return first.color, last.color, stops
		end
		return color_white, color_white, nil
	end

	local function stopsVisible(stops)
		for _, stop in ipairs(stops or {}) do
			local color = stop.color or stop[2]
			if color and (color.a == nil or color.a > 0) then return true end
		end
		return false
	end

	local function lerpColor(a, b, t)
		t = math.Clamp(tonumber(t) or 0, 0, 1)
		return Color(
			math_floor((a.r or 0) + ((b.r or 0) - (a.r or 0)) * t + 0.5),
			math_floor((a.g or 0) + ((b.g or 0) - (a.g or 0)) * t + 0.5),
			math_floor((a.b or 0) + ((b.b or 0) - (a.b or 0)) * t + 0.5),
			math_floor((a.a == nil and 255 or a.a) + ((b.a == nil and 255 or b.a) - (a.a == nil and 255 or a.a)) * t + 0.5)
		)
	end

	local function colorAtStops(stops, t)
		stops = normalizeStops(stops)
		if not stops then return color_white end

		t = math.Clamp(tonumber(t) or 0, 0, 1)
		for i = 1, #stops - 1 do
			local a = stops[i]
			local b = stops[i + 1]
			if t <= b.pos then
				local span = math_max(0.0001, b.pos - a.pos)
				return lerpColor(a.color, b.color, (t - a.pos) / span)
			end
		end

		return stops[#stops].color
	end

	function owner.Solid(color)
		color = asColor(color, color_white)
		if istable(color) then
			local cached = solidColorCache[color]
			if cached then return cached end
			cached = {kind = FILL_SOLID, colorA = color, colorB = color, _mgfxFillVisible = (color.a == nil or color.a > 0)}
			solidColorCache[color] = cached
			return cached
		end
		return {kind = FILL_SOLID, colorA = color_white, colorB = color_white, _mgfxFillVisible = true}
	end

	function owner.LinearGradient(x1, y1, x2, y2, stopsOrColorA, colorB)
		local colorA
		local stops
		if istable(stopsOrColorA) and not stopsOrColorA.r then
			colorA, colorB, stops = firstLastStops(stopsOrColorA)
		else
			colorA = asColor(stopsOrColorA, color_white)
			colorB = asColor(colorB, colorA)
			stops = {
				{pos = 0, color = colorA},
				{pos = 1, color = colorB},
			}
		end

		return {
			kind = FILL_LINEAR,
			colorA = colorA,
			colorB = colorB,
			stops = stops,
			_mgfxStopsNormalized = true,
			_mgfxLutCacheSafe = true,
			_mgfxFillVisible = stopsVisible(stops),
			x1 = tonumber(x1) or 0,
			y1 = tonumber(y1) or 0,
			x2 = tonumber(x2) or 1,
			y2 = tonumber(y2) or 1,
		}
	end

	function owner.LinearGradientStops(x1, y1, x2, y2, stops)
		return owner.LinearGradient(x1, y1, x2, y2, stops)
	end

	function owner.RadialGradient(cx, cy, radius, stopsOrColorA, colorB)
		local colorA
		local stops
		if istable(stopsOrColorA) and not stopsOrColorA.r then
			colorA, colorB, stops = firstLastStops(stopsOrColorA)
		else
			colorA = asColor(stopsOrColorA, color_white)
			colorB = asColor(colorB, colorA)
			stops = {
				{pos = 0, color = colorA},
				{pos = 1, color = colorB},
			}
		end

		return {
			kind = FILL_RADIAL,
			colorA = colorA,
			colorB = colorB,
			stops = stops,
			_mgfxStopsNormalized = true,
			_mgfxLutCacheSafe = true,
			_mgfxFillVisible = stopsVisible(stops),
			cx = tonumber(cx) or 0.5,
			cy = tonumber(cy) or 0.5,
			radius = tonumber(radius) or 0.5,
		}
	end

	function owner.RingRadialGradient(stopsOrColorA, colorB)
		local fill = owner.RadialGradient(0.5, 0.5, 0.5, stopsOrColorA, colorB)
		fill.radialSpace = "ring"
		fill.localRadial = true
		return fill
	end

	function owner.SectorRadialGradient(stopsOrColorA, colorB)
		return owner.RingRadialGradient(stopsOrColorA, colorB)
	end

	function owner.ConicGradient(cx, cy, rotation, stopsOrColorA, colorB)
		local colorA
		local stops
		if istable(stopsOrColorA) and not stopsOrColorA.r then
			colorA, colorB, stops = firstLastStops(stopsOrColorA)
		else
			colorA = asColor(stopsOrColorA, color_white)
			colorB = asColor(colorB, colorA)
			stops = {
				{pos = 0, color = colorA},
				{pos = 1, color = colorB},
			}
		end

		return {
			kind = FILL_CONIC,
			colorA = colorA,
			colorB = colorB,
			stops = stops,
			_mgfxStopsNormalized = true,
			_mgfxLutCacheSafe = true,
			_mgfxFillVisible = stopsVisible(stops),
			cx = tonumber(cx) or 0.5,
			cy = tonumber(cy) or 0.5,
			rotation = tonumber(rotation) or 0,
		}
	end

	function owner.ShapeAngularGradient(stopsOrColorA, colorB, rotation)
		if istable(stopsOrColorA) and not stopsOrColorA.r and isnumber(colorB) and rotation == nil then
			rotation = colorB
			colorB = nil
		end

	local fill = owner.ConicGradient(0.5, 0.5, rotation or 0, stopsOrColorA, colorB)
	fill.angularSpace = "shape"
	fill.localAngular = true
	return fill
end

	function owner.RingAngularGradient(stopsOrColorA, colorB, rotation)
		return owner.ShapeAngularGradient(stopsOrColorA, colorB, rotation)
	end

	function owner.ArcAngularGradient(stopsOrColorA, colorB, rotation)
		return owner.ShapeAngularGradient(stopsOrColorA, colorB, rotation)
	end

	function owner.SectorAngularGradient(stopsOrColorA, colorB, rotation)
		return owner.ShapeAngularGradient(stopsOrColorA, colorB, rotation)
	end

	local function patternSeed(seed)
		if seed == nil then return 0 end
		local value = tonumber(seed)
		if not value then
			value = tonumber(util.CRC(tostring(seed))) or 0
		end
		value = math_abs(value) % 65536
		return value / 65536
	end

	function owner.StripePattern(color, spacing, width, angle, offset)
		if istable(color) and not color.r then
			return {
				kind = "stripe",
				color = asColor(color.color or color.tint, Color(255, 255, 255, 24)),
				spacing = tonumber(color.spacing) or 12,
				width = tonumber(color.width) or 2,
				angle = tonumber(color.angle) or 135,
				offset = tonumber(color.offset) or 0,
			}
		end

		return {
			kind = "stripe",
			color = asColor(color, Color(255, 255, 255, 24)),
			spacing = tonumber(spacing) or 12,
			width = tonumber(width) or 2,
			angle = tonumber(angle) or 135,
			offset = tonumber(offset) or 0,
		}
	end

	function owner.SmokePattern(color, scale, density, softness, angle, offset, seed)
		if istable(color) and not color.r then
			return {
				kind = "smoke",
				color = asColor(color.color or color.tint, Color(255, 255, 255, 24)),
				scale = tonumber(color.scale) or 140,
				density = tonumber(color.density) or 0.48,
				softness = tonumber(color.softness) or 0.3,
				angle = tonumber(color.angle) or 135,
				offset = tonumber(color.offset) or 0,
				speed = tonumber(color.speed) or 0,
				warp = tonumber(color.warp) or 0.85,
				seed = patternSeed(color.seed),
			}
		end

		return {
			kind = "smoke",
			color = asColor(color, Color(255, 255, 255, 24)),
			scale = tonumber(scale) or 140,
			density = tonumber(density) or 0.48,
			softness = tonumber(softness) or 0.3,
			angle = tonumber(angle) or 135,
			offset = tonumber(offset) or 0,
			speed = 0,
			warp = 0.85,
			seed = patternSeed(seed),
		}
	end

	function owner.WornPattern(spec)
		spec = istable(spec) and spec or {}
		return {
			kind = "worn",
			color = asColor(spec.color or spec.tint, Color(0, 0, 0, 44)),
			edgeColor = asColor(spec.edgeColor or spec.highlight, Color(218, 208, 184, 78)),
			fractal = math.Clamp(tonumber(spec.fractal) or 0.44, 0, 1),
			grain = math.Clamp(tonumber(spec.grain) or 0.64, 0, 1),
			scratches = math.Clamp(tonumber(spec.scratches) or spec.scratch or 0.30, 0, 1),
			edge = math.Clamp(tonumber(spec.edge) or spec.edgeWear or 0.54, 0, 1),
			scale = math_max(1, tonumber(spec.scale) or 32),
			grainScale = math_max(0.25, tonumber(spec.grainScale) or 5.6),
			scratchScale = math_max(1, tonumber(spec.scratchScale) or 26),
			scratchWidth = math.Clamp(tonumber(spec.scratchWidth) or 0.045, 0.005, 0.5),
			edgeWidth = math_max(0.5, tonumber(spec.edgeWidth) or 7),
			softness = math.Clamp(tonumber(spec.softness) or 0.10, 0.001, 1),
			warp = math_max(0, tonumber(spec.warp) or 0.035),
			angle = tonumber(spec.angle) or -14,
			offset = tonumber(spec.offset) or 0,
			speed = tonumber(spec.speed) or 0,
			seed = patternSeed(spec.seed),
		}
	end

	function owner.Mask(kind, spec)
		if istable(kind) and not kind.r then
			local out = table.Copy(kind)
			if out.kind == nil and out.shape ~= nil then out.kind = out.shape end
			return out
		end

		local out = istable(spec) and table.Copy(spec) or {}
		out.kind = kind or out.kind
		if out.kind == nil and out.shape ~= nil then out.kind = out.shape end
		return out
	end

	local function imageMaskStyle(mask, style)
		style = style or {}
		if mask == false or mask == "none" then return nil end

		if mask == nil then
			if style.radius ~= nil then
				return {kind = "rounded", radius = style.radius}
			end
			return nil
		end

		if isstring(mask) then
			local lower = string.lower(mask)
			if lower == "round" or lower == "rounded" or lower == "roundedbox" or lower == "roundrect" then
				return {kind = "rounded", radius = style.radius or 0}
			end
			if lower == "chamfer" or lower == "bevel" then
				return {kind = "chamfer", cuts = 0}
			end
			if lower == "circle" then
				return {kind = "circle"}
			end
			if lower == "capsule" or lower == "pill" then
				return {kind = "capsule"}
			end
			return nil
		end

		if istable(mask) then
			local out = table.Copy(mask)
			out.kind = out.kind or out.shape or (out.source and "texture") or (out.material and "texture") or (out.texture and "texture")
			if isstring(out.kind) then out.kind = string.lower(out.kind) end
			if out.kind == "round" or out.kind == "roundrect" or out.kind == "roundedbox" then out.kind = "rounded" end
			if out.kind == "bevel" then out.kind = "chamfer" end
			if out.kind == "pill" then out.kind = "capsule" end
			if out.kind == "alpha" or out.kind == "image" then out.kind = "texture" end
			if out.kind == "chamfer" and out.cuts == nil then out.cuts = 0 end
			if out.kind == "rounded" and out.radius == nil then out.radius = style.radius or 0 end
			return out
		end

		return nil
	end

	owner.ImageMaskStyle = imageMaskStyle

	local function fillFromStyle(fill)
		if istable(fill) and (fill.kind == FILL_SOLID or fill.kind == FILL_LINEAR or fill.kind == FILL_RADIAL or fill.kind == FILL_CONIC) then return fill end
		if istable(fill) and fill.kind ~= nil then return owner.Solid(transparentColor) end
		return owner.Solid(asColor(fill, color_white))
	end

	owner.FillFromStyle = fillFromStyle

	local function fillVisible(fill)
		fill = fillFromStyle(fill)
		if fill._mgfxFillVisible ~= nil then return fill._mgfxFillVisible end
		if fill.stops and #fill.stops > 0 then
			for _, stop in ipairs(fill.stops) do
				local color = stop.color or stop[2]
				if color and (color.a == nil or color.a > 0) then return true end
			end
			return false
		end

		local colorA = fill.colorA or color_white
		local colorB = fill.colorB or colorA
		return (colorA.a == nil or colorA.a > 0) or (colorB.a == nil or colorB.a > 0)
	end

	local function colorAtFill(fill, t)
		fill = fillFromStyle(fill)
		if fill.stops and #fill.stops > 0 then
			return colorAtStops(fill.stops, t)
		end
		return lerpColor(fill.colorA or color_white, fill.colorB or fill.colorA or color_white, t)
	end

	owner.ColorAtFill = colorAtFill

	local function normalizedRotation(value)
		value = tonumber(value) or 0
		value = (value / 360) % 1
		if value < 0 then value = value + 1 end
		return value
	end

	owner.NormalizedRotation = normalizedRotation

	local function glowSoftnessToFalloff(softness, defaultSoftness)
		softness = math.Clamp(tonumber(softness) or defaultSoftness or 0.55, 0, 1)
		return math.Clamp(3.25 - softness * 2.5, 0.75, 3.25)
	end

	owner.GlowSoftnessToFalloff = glowSoftnessToFalloff

	local function strokeVisible(stroke, strokeWidth)
		return stroke and strokeWidthValue(strokeWidth, 0) > 0 and (stroke.a == nil or stroke.a > 0)
	end

	local function backdropStyle(value)
		if value == nil or value == false then return nil end

		if value == true then
			if not backdropTrueSpec then
				backdropTrueSpec = {blur = 4, tint = transparentColor, opacity = 1, padding = 0}
			end
			return backdropTrueSpec
		end

		if isnumber(value) then
			local blurKey = math_max(0, tonumber(value) or 0)
			local cached = backdropNumberCache[blurKey]
			if cached ~= nil then return cached ~= false and cached or nil end
			if blurKey <= 0 then
				backdropNumberCache[blurKey] = false
				return nil
			end
			cached = {blur = blurKey, tint = transparentColor, opacity = 1, padding = 0}
			backdropNumberCache[blurKey] = cached
			return cached
		end

		if istable(value) and value.r and value.g and value.b then
			local cached = backdropColorCache[value]
			if cached ~= nil then return cached ~= false and cached or nil end
			if (value.a == nil and 255 or value.a) <= 0 then
				backdropColorCache[value] = false
				return nil
			end
			cached = {blur = 0, tint = value, opacity = 1, padding = 0}
			backdropColorCache[value] = cached
			return cached
		end

		if not istable(value) then
			return nil
		end

		local cached = backdropTableCache[value]
		if cached
			and cached._blurInput == value.blur
			and cached._sizeInput == value.size
			and cached._indexInput == value[1]
			and cached._tintInput == value.tint
			and cached._colorInput == value.color
			and cached._opacityInput == value.opacity
			and cached._strengthInput == value.strength
			and cached._paddingInput == value.padding
			and cached._spreadInput == value.spread then
			return cached
		end
		if cached == false
			and value.blur == nil
			and value.size == nil
			and value[1] == nil
			and value.tint == nil
			and value.color == nil
			and value.opacity == nil
			and value.strength == nil
			and value.padding == nil
			and value.spread == nil then
			return nil
		end

		local blur = math_max(0, tonumber(value.blur or value.size or value[1]) or 0)
		local tint = asColor(value.tint or value.color, transparentColor)
		local opacity = math.Clamp(tonumber(value.opacity or value.strength) or 1, 0, 1)
		local padding = math_max(0, tonumber(value.padding or value.spread) or 0)

		if blur <= 0 and ((tint.a == nil and 255 or tint.a) <= 0 or opacity <= 0) then
			backdropTableCache[value] = false
			return nil
		end

		cached = {
			blur = blur,
			tint = tint,
			opacity = opacity,
			padding = padding,
		}
		cached._blurInput = value.blur
		cached._sizeInput = value.size
		cached._indexInput = value[1]
		cached._tintInput = value.tint
		cached._colorInput = value.color
		cached._opacityInput = value.opacity
		cached._strengthInput = value.strength
		cached._paddingInput = value.padding
		cached._spreadInput = value.spread
		backdropTableCache[value] = cached
		return cached
	end

	function owner.Backdrop(value)
		return backdropStyle(value)
	end

	owner.BackdropStyle = backdropStyle

	return {
		FILL_SOLID = FILL_SOLID,
		FILL_LINEAR = FILL_LINEAR,
		FILL_RADIAL = FILL_RADIAL,
		FILL_CONIC = FILL_CONIC,
		asColor = asColor,
		color01 = color01,
		setDrawColor = setDrawColor,
		strokeWidthValue = strokeWidthValue,
		radiusTuple = radiusTuple,
		radiusScalar = radiusScalar,
		normalizeStops = normalizeStops,
		firstLastStops = firstLastStops,
		lerpColor = lerpColor,
		colorAtStops = colorAtStops,
		fillFromStyle = fillFromStyle,
		fillVisible = fillVisible,
		colorAtFill = colorAtFill,
		normalizedRotation = normalizedRotation,
		glowSoftnessToFalloff = glowSoftnessToFalloff,
		strokeVisible = strokeVisible,
		backdropStyle = backdropStyle,
		imageMaskStyle = imageMaskStyle,
	}
end
