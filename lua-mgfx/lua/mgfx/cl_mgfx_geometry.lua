if SERVER then return end

MGFX = MGFX or {}

function MGFX._CreateGeometryHelpers(deps)
	deps = deps or {}

	local owner = deps.M or MGFX
	local stats = deps.stats or owner.stats or {}
	local profiler = deps.profiler or owner.Profiler
	local asColor = deps.asColor or function(value, fallback) return value or fallback or color_white end
	local copyStyle = deps.copyStyle or function(style) return istable(style) and table.Copy(style) or {} end

	local math_floor = math.floor
	local math_max = math.max
	local math_min = math.min
	local math_abs = math.abs
	local math_cos = math.cos
	local math_rad = math.rad
	local math_sin = math.sin
	local math_tan = math.tan
	local surface_DrawPoly = surface.DrawPoly
	local surface_DrawTexturedRectUV = surface.DrawTexturedRectUV

	local function blurIntensity(value)
		return math.Clamp((tonumber(value) or 16) / 16, 0.001, 4)
	end

	local transformStack = {}
	local transformPolyScratch = {{}, {}, {}, {}, {}, {}, {}, {}}
	local transformQuadVerts = {{}, {}, {}, {}}
	local texturedRectUVCache = setmetatable({}, {__mode = "k"})

	local function traceStart(name)
		if profiler and profiler._TraceActive and profiler.TraceStart then
			return profiler.TraceStart(name)
		end
		return nil
	end

	local function traceEnd(token)
		if token and profiler and profiler.TraceEnd then
			profiler.TraceEnd(token)
		end
	end

	local function isPoint(value)
		return istable(value) and (value.x ~= nil or value[1] ~= nil) and (value.y ~= nil or value[2] ~= nil)
	end

	local function pointXY(value, fallbackX, fallbackY)
		if not istable(value) then return fallbackX or 0, fallbackY or 0 end
		return tonumber(value.x or value[1]) or fallbackX or 0, tonumber(value.y or value[2]) or fallbackY or 0
	end

	local function percentString(value)
		if not isstring(value) then return nil end
		local lower = string.lower(value)
		if lower == "left" or lower == "top" then return 0 end
		if lower == "center" or lower == "middle" then return 0.5 end
		if lower == "right" or lower == "bottom" then return 1 end
		local pct = string.match(lower, "^%s*([%-%d%.]+)%s*%%%s*$")
		if pct then return (tonumber(pct) or 0) / 100 end
		return nil
	end

	local function axisOrigin(value, base, size, fallback)
		local pct = percentString(value)
		if pct ~= nil then return base + size * pct end
		if value == nil then return base + size * (fallback or 0.5) end
		return base + (tonumber(value) or size * (fallback or 0.5))
	end

	local function transformOrigin(spec, x, y, w, h)
		local origin = spec.origin or spec.transformOrigin or spec.anchor
		if isstring(origin) then
			local a, b = string.match(origin, "^%s*([^%s]+)%s+([^%s]+)%s*$")
			if not a then a, b = origin, origin end
			return axisOrigin(a, x, w, 0.5), axisOrigin(b, y, h, 0.5)
		elseif istable(origin) then
			return axisOrigin(origin.x or origin[1], x, w, 0.5), axisOrigin(origin.y or origin[2], y, h, 0.5)
		end
		return x + w * 0.5, y + h * 0.5
	end

	local function num(value, fallback)
		return tonumber(value) or fallback or 0
	end

	local function compileCssTransform(spec, x, y, w, h)
		local ox, oy = transformOrigin(spec, x or 0, y or 0, w or 0, h or 0)
		local scale = spec.scale
		local scaleX = spec.scaleX or (istable(scale) and (scale.x or scale[1])) or scale or 1
		local scaleY = spec.scaleY or (istable(scale) and (scale.y or scale[2])) or scale or 1
		local translate = spec.translate
		local tx = spec.x or spec.translateX or (istable(translate) and (translate.x or translate[1])) or 0
		local ty = spec.y or spec.translateY or (istable(translate) and (translate.y or translate[2])) or 0
		local tz = spec.z or spec.translateZ or (istable(translate) and (translate.z or translate[3])) or 0
		local skew = spec.skew
		local skewX = spec.skewX or (istable(skew) and (skew.x or skew[1])) or 0
		local skewY = spec.skewY or (istable(skew) and (skew.y or skew[2])) or 0
		local rotate = spec.rotate or spec.rotateZ or 0
		local rotateX = spec.rotateX or spec.pitch or 0
		local rotateY = spec.rotateY or spec.yaw or 0
		local perspective = spec.perspective or spec.depth or 0

		return {
			kind = "css",
			originX = ox,
			originY = oy,
			translateX = num(tx, 0),
			translateY = num(ty, 0),
			translateZ = num(tz, 0),
			scaleX = num(scaleX, 1),
			scaleY = num(scaleY, 1),
			skewX = math_tan(math_rad(num(skewX, 0))),
			skewY = math_tan(math_rad(num(skewY, 0))),
			rotate = math_rad(num(rotate, 0)),
			rotateX = math_rad(num(rotateX, 0)),
			rotateY = math_rad(num(rotateY, 0)),
			perspective = math_max(0, num(perspective, 0)),
			steps = math.Clamp(math_floor(num(spec.steps or spec.subdivisions, 0)), 0, 24),
		}
	end

	local function projectedCorner(spec, name, index)
		return pointXY(spec[name] or spec[index], 0, 0)
	end

	local function compileProjectedQuad(spec, x, y, w, h)
		local tlx, tly = projectedCorner(spec, "tl", 1)
		local trx, try = projectedCorner(spec, "tr", 2)
		local brx, bry = projectedCorner(spec, "br", 3)
		local blx, bly = projectedCorner(spec, "bl", 4)
		return {
			kind = "projected",
			x = x or 0,
			y = y or 0,
			w = math_max(0.0001, w or 1),
			h = math_max(0.0001, h or 1),
			tlx = tlx,
			tly = tly,
			trx = trx,
			try = try,
			brx = brx,
			bry = bry,
			blx = blx,
			bly = bly,
			steps = math.Clamp(math_floor(num(spec.steps or spec.subdivisions, 10)), 1, 24),
		}
	end

	local function compilePointerTilt(spec, x, y, w, h)
		if not x or not y or not w or not h then return nil end
		local px = tonumber(spec.pointerX or spec.x or spec[1]) or x + w * 0.5
		local py = tonumber(spec.pointerY or spec.y or spec[2]) or y + h * 0.5
		local strength = math.Clamp(num(spec.strength, 1), 0, 1)
		local nx = math.Clamp((px - (x + w * 0.5)) / math_max(w * 0.5, 0.0001), -1, 1)
		local ny = math.Clamp((py - (y + h * 0.5)) / math_max(h * 0.5, 0.0001), -1, 1)
		local maxX = num(spec.maxRotateX or spec.maxX or spec.max or spec.amount, 6)
		local maxY = num(spec.maxRotateY or spec.maxY or spec.max or spec.amount, 6)

		return compileCssTransform({
			origin = spec.origin or spec.transformOrigin or "50% 50%",
			perspective = spec.perspective or 900,
			rotateX = -ny * maxX * strength,
			rotateY = nx * maxY * strength,
			scale = spec.scale or (1 + strength * num(spec.scaleLift, 0)),
			steps = spec.steps or spec.subdivisions or 10,
		}, x, y, w, h)
	end

	local function compileTransform(spec, x, y, w, h)
		if not istable(spec) then return nil end
		local kind = spec.kind or spec.type
		if kind == "pointerTilt" then
			return compilePointerTilt(spec, x, y, w, h)
		end
		if kind == "projectedQuad" or kind == "projected" or spec.tl or (isPoint(spec[1]) and isPoint(spec[2]) and isPoint(spec[3]) and isPoint(spec[4])) then
			return compileProjectedQuad(spec, x, y, w, h)
		end
		return compileCssTransform(spec, x, y, w, h)
	end

	local function hasTransform()
		return #transformStack > 0
	end

	local function transformNeedsGrid()
		for i = 1, #transformStack do
			local t = transformStack[i]
			if t.kind == "projected" or t.perspective > 0 or math_abs(t.rotateX) > 0.0001 or math_abs(t.rotateY) > 0.0001 or t.steps > 1 then
				return true
			end
		end
		return false
	end

	local function transformSteps()
		local steps = 1
		for i = 1, #transformStack do
			local t = transformStack[i]
			if t.kind == "projected" or t.perspective > 0 or math_abs(t.rotateX) > 0.0001 or math_abs(t.rotateY) > 0.0001 then
				steps = math_max(steps, t.steps > 0 and t.steps or 10)
			else
				steps = math_max(steps, t.steps > 0 and t.steps or 1)
			end
		end
		return math.Clamp(steps, 1, 24)
	end

	local function applyOneTransform(t, x, y)
		if t.kind == "projected" then
			local u = (x - t.x) / t.w
			local v = (y - t.y) / t.h
			local topX = t.tlx + (t.trx - t.tlx) * u
			local topY = t.tly + (t.try - t.tly) * u
			local bottomX = t.blx + (t.brx - t.blx) * u
			local bottomY = t.bly + (t.bry - t.bly) * u
			return topX + (bottomX - topX) * v, topY + (bottomY - topY) * v
		end

		local lx = x - t.originX
		local ly = y - t.originY
		local sx = lx * t.scaleX + ly * t.skewX
		local sy = ly * t.scaleY + lx * t.skewY
		local sz = 0

		if math_abs(t.rotateX) > 0.0001 then
			local c, s = math_cos(t.rotateX), math_sin(t.rotateX)
			sy, sz = sy * c - sz * s, sy * s + sz * c
		end
		if math_abs(t.rotateY) > 0.0001 then
			local c, s = math_cos(t.rotateY), math_sin(t.rotateY)
			sx, sz = sx * c + sz * s, -sx * s + sz * c
		end
		if math_abs(t.rotate) > 0.0001 then
			local c, s = math_cos(t.rotate), math_sin(t.rotate)
			sx, sy = sx * c - sy * s, sx * s + sy * c
		end

		sz = sz + (t.translateZ or 0)

		local p = t.perspective
		if p > 0 then
			local denom = math_max(0.05, p - sz)
			local factor = p / denom
			sx, sy = sx * factor, sy * factor
		end

		return t.originX + sx + t.translateX, t.originY + sy + t.translateY
	end

	local function inverseOneTransform(t, sx, sy, guessX, guessY)
		local x = tonumber(guessX) or sx
		local y = tonumber(guessY) or sy
		local eps = 0.5

		for _ = 1, 10 do
			local fx, fy = applyOneTransform(t, x, y)
			local ex, ey = fx - sx, fy - sy
			if math_abs(ex) + math_abs(ey) < 0.01 then
				return x, y
			end

			local ax, ay = applyOneTransform(t, x + eps, y)
			local bx, by = applyOneTransform(t, x, y + eps)
			local j00, j10 = (ax - fx) / eps, (ay - fy) / eps
			local j01, j11 = (bx - fx) / eps, (by - fy) / eps
			local det = j00 * j11 - j01 * j10
			if math_abs(det) < 0.000001 then
				return x, y
			end

			x = x - (ex * j11 - j01 * ey) / det
			y = y - (j00 * ey - ex * j10) / det
		end

		return x, y
	end

	local function transformPoint(x, y)
		for i = #transformStack, 1, -1 do
			x, y = applyOneTransform(transformStack[i], x, y)
		end
		return x, y
	end

	local function transformSpecPoint(spec, px, py, x, y, w, h)
		local t = compileTransform(spec, x, y, w, h)
		if not t then return px, py end
		return applyOneTransform(t, px, py)
	end

	local function untransformSpecPoint(spec, sx, sy, x, y, w, h)
		local t = compileTransform(spec, x, y, w, h)
		if not t then return sx, sy end
		return inverseOneTransform(t, sx, sy, sx, sy)
	end

	local function untransformPoint(sx, sy)
		for i = 1, #transformStack do
			sx, sy = inverseOneTransform(transformStack[i], sx, sy, sx, sy)
		end
		return sx, sy
	end

	local function transformedVertex(out, x, y, u, v)
		out.x, out.y = transformPoint(x, y)
		out.u, out.v = u, v
		return out
	end

	local function drawTransformedPoly(verts)
		if not hasTransform() then
			surface_DrawPoly(verts)
			return
		end
		local out = transformPolyScratch
		for i = 1, #verts do
			local src = verts[i]
			local dst = out[i] or {}
			out[i] = dst
			dst.x, dst.y = transformPoint(src.x or src[1] or 0, src.y or src[2] or 0)
			dst.u, dst.v = src.u, src.v
			dst.color = src.color
		end
		for i = #verts + 1, #out do
			out[i] = nil
		end
		surface_DrawPoly(out)
	end

	local function pushTransform(spec, x, y, w, h)
		local t = compileTransform(spec, x, y, w, h)
		if not t then return false end
		transformStack[#transformStack + 1] = t
		return true
	end

	local function popTransform()
		transformStack[#transformStack] = nil
	end

	local function withTransform(spec, x, y, w, h, fn)
		if not spec then return fn() end
		if not pushTransform(spec, x, y, w, h) then return fn() end
		local ok, a, b, c, d = pcall(fn)
		popTransform()
		if not ok then error(a, 2) end
		return a, b, c, d
	end

	local function splitStyleTransform(style)
		if not istable(style) then return nil, style end
		local transform = style.transform
		if transform == nil then return nil, style end
		return transform, style
	end

	function owner.Transform(spec)
		return copyStyle(spec or {})
	end

	function owner.ProjectedQuad(spec)
		spec = copyStyle(spec or {})
		spec.kind = "projectedQuad"
		return spec
	end

	function owner.PointerTilt(x, y, spec)
		spec = copyStyle(spec or {})
		spec.kind = "pointerTilt"
		spec.x = x
		spec.y = y
		return spec
	end

	function owner.PushTransform(spec, x, y, w, h)
		return pushTransform(spec, x, y, w, h)
	end

	function owner.PopTransform()
		return popTransform()
	end

	function owner.TransformPoint(px, py, spec, x, y, w, h)
		if spec ~= nil then
			return transformSpecPoint(spec, px, py, x, y, w, h)
		end
		return transformPoint(px, py)
	end

	function owner.UntransformPoint(px, py, spec, x, y, w, h)
		if spec ~= nil then
			return untransformSpecPoint(spec, px, py, x, y, w, h)
		end
		return untransformPoint(px, py)
	end

	local function materialUVCorrection(mat)
		if not mat or not mat.Width or not mat.Height then return nil end

		local cached = texturedRectUVCache[mat]
		if cached then
			return cached.du, cached.dv, cached.denomU, cached.denomV, cached.fullU0, cached.fullV0, cached.fullU1, cached.fullV1
		end

		local mw = tonumber(mat:Width()) or 0
		local mh = tonumber(mat:Height()) or 0
		if mw <= 1 or mh <= 1 then return nil end

		local du = 0.5 / mw
		local dv = 0.5 / mh
		local denomU = 1 - 2 * du
		local denomV = 1 - 2 * dv
		cached = {
			du = du,
			dv = dv,
			denomU = denomU,
			denomV = denomV,
			fullU0 = -du / denomU,
			fullV0 = -dv / denomV,
			fullU1 = (1 - du) / denomU,
			fullV1 = (1 - dv) / denomV,
		}
		texturedRectUVCache[mat] = cached
		return cached.du, cached.dv, cached.denomU, cached.denomV, cached.fullU0, cached.fullV0, cached.fullU1, cached.fullV1
	end

	local function drawTexturedQuadUV(x, y, w, h, u0, v0, u1, v1, mat)
		local trace = traceStart("geometry.drawTexturedQuadUV")
		if not hasTransform() then
			local uvTrace = traceStart("geometry.materialUVCorrection")
			local du, dv, denomU, denomV = materialUVCorrection(mat)
			traceEnd(uvTrace)
			if du then
				local surfaceTrace = traceStart("surface.DrawTexturedRectUV")
				surface_DrawTexturedRectUV(
					x, y, w, h,
					(u0 - du) / denomU, (v0 - dv) / denomV,
					(u1 - du) / denomU, (v1 - dv) / denomV
				)
				traceEnd(surfaceTrace)
				stats.draws = (stats.draws or 0) + 1
				traceEnd(trace)
				return
			end

			local surfaceTrace = traceStart("surface.DrawTexturedRectUV")
			surface_DrawTexturedRectUV(x, y, w, h, u0, v0, u1, v1)
			traceEnd(surfaceTrace)
			stats.draws = (stats.draws or 0) + 1
			traceEnd(trace)
			return
		end

		local transformTrace = traceStart("geometry.transformedGrid")
		local steps = transformNeedsGrid() and transformSteps() or 1
		local draws = 0
		for gy = 0, steps - 1 do
			local yA = y + h * gy / steps
			local yB = y + h * (gy + 1) / steps
			local vA = v0 + (v1 - v0) * gy / steps
			local vB = v0 + (v1 - v0) * (gy + 1) / steps
			for gx = 0, steps - 1 do
				local xA = x + w * gx / steps
				local xB = x + w * (gx + 1) / steps
				local uA = u0 + (u1 - u0) * gx / steps
				local uB = u0 + (u1 - u0) * (gx + 1) / steps
				local verts = transformQuadVerts
				transformedVertex(verts[1], xA, yA, uA, vA)
				transformedVertex(verts[2], xB, yA, uB, vA)
				transformedVertex(verts[3], xB, yB, uB, vB)
				transformedVertex(verts[4], xA, yB, uA, vB)
				surface_DrawPoly(verts)
				draws = draws + 1
			end
		end
		traceEnd(transformTrace)
		stats.draws = (stats.draws or 0) + draws
		traceEnd(trace)
	end

	local function drawTexturedQuad(x, y, w, h, mat)
		if hasTransform() then
			drawTexturedQuadUV(x, y, w, h, 0, 0, 1, 1, mat)
			return
		end

		-- Most MGFX shader passes draw a full-material quad. Keep this path
		-- direct so the hot renderer does not pay the generic UV wrapper cost.
		local du, _dv, _denomU, _denomV, fullU0, fullV0, fullU1, fullV1 = materialUVCorrection(mat)
		if du then
			surface_DrawTexturedRectUV(
				x, y, w, h,
				fullU0, fullV0,
				fullU1, fullV1
			)
		else
			surface_DrawTexturedRectUV(x, y, w, h, 0, 0, 1, 1)
		end
		stats.draws = (stats.draws or 0) + 1
	end

	local function drawCreatedMaterialTexturedRectUV(x, y, w, h, u0, v0, u1, v1)
		-- surface.DrawTexturedRectUV applies a half-pixel correction based on
		-- IMaterial mapping size. CreateMaterial can report the 32x32 error
		-- material size, so pre-cancel that correction for fallback image draws.
		local du = 0.5 / 32
		local dv = 0.5 / 32
		u0, v0 = (u0 - du) / (1 - 2 * du), (v0 - dv) / (1 - 2 * dv)
		u1, v1 = (u1 - du) / (1 - 2 * du), (v1 - dv) / (1 - 2 * dv)
		if hasTransform() then
			drawTexturedQuadUV(x, y, w, h, u0, v0, u1, v1)
		else
			surface_DrawTexturedRectUV(x, y, w, h, u0, v0, u1, v1)
		end
	end

	local function textureSize(texture)
		local tw, th = 1, 1
		if texture and texture.Width then tw = tonumber(texture:Width()) or tw end
		if texture and texture.Height then th = tonumber(texture:Height()) or th end
		return math_max(1, tw), math_max(1, th)
	end

	local imageTintScratch = Color(255, 255, 255, 255)

	local function imageTint(style)
		style = style or {}
		local tint = asColor(style.tint or style.color, color_white)
		local alpha = tint.a == nil and 255 or tint.a
		local opacity = style.alpha

		if opacity == nil then
			return tint
		end

		opacity = tonumber(opacity) or 255
		if opacity <= 1 then
			alpha = alpha * math.Clamp(opacity, 0, 1)
		else
			alpha = alpha * math.Clamp(opacity, 0, 255) / 255
		end

		imageTintScratch.r = tint.r or 255
		imageTintScratch.g = tint.g or 255
		imageTintScratch.b = tint.b or 255
		imageTintScratch.a = math_floor(math.Clamp(alpha, 0, 255))
		return imageTintScratch
	end

	local function imageStyle(style)
		if istable(style) then return style end
		if style ~= nil then return {radius = style} end
		return {}
	end

	local function imageRadius(radius, w, h)
		if radius == true then return math_min(w, h) * 0.5 end
		if isstring(radius) then
			local lower = string.lower(radius)
			if lower == "circle" then return math_min(w, h) * 0.5 end

			local pct = string.match(lower, "^%s*([%d%.]+)%s*%%%s*$")
			if pct then
				return math_min(w, h) * math.Clamp((tonumber(pct) or 0) / 100, 0, 1)
			end

			local px = string.match(lower, "^%s*([%d%.]+)%s*px%s*$")
			if px then return tonumber(px) or 0 end
		end

		return math_max(0, tonumber(radius) or 0)
	end

	local function imageAlign(style)
		local ax = style.alignX
		local ay = style.alignY

		if ax == nil then ax = style.positionX end
		if ay == nil then ay = style.positionY end

		local position = style.position
		if istable(position) then
			if ax == nil then ax = position.x or position[1] end
			if ay == nil then ay = position.y or position[2] end
		end

		return math.Clamp(tonumber(ax) or 0.5, 0, 1), math.Clamp(tonumber(ay) or 0.5, 0, 1)
	end

	local function imageUV(style, texture)
		local u0, v0, u1, v1 = 0, 0, 1, 1
		style = style or {}

		local uv = style.uv
		if istable(uv) then
			u0 = tonumber(uv.u0 or uv.x0 or uv[1]) or u0
			v0 = tonumber(uv.v0 or uv.y0 or uv[2]) or v0
			u1 = tonumber(uv.u1 or uv.x1 or uv[3]) or u1
			v1 = tonumber(uv.v1 or uv.y1 or uv[4]) or v1
		else
			local crop = style.crop
			if istable(crop) then
				local pixels = crop.pixels or crop.pixel or style.cropPixels or style.cropUnit == "px"
				if crop.x ~= nil or crop.y ~= nil or crop.w ~= nil or crop.h ~= nil then
					local x = tonumber(crop.x) or 0
					local y = tonumber(crop.y) or 0
					local w = tonumber(crop.w or crop.width) or 1
					local h = tonumber(crop.h or crop.height) or 1
					if pixels then
						local tw, th = textureSize(texture)
						u0, v0, u1, v1 = x / tw, y / th, (x + w) / tw, (y + h) / th
					else
						u0, v0, u1, v1 = x, y, x + w, y + h
					end
				else
					u0 = tonumber(crop.u0 or crop[1]) or u0
					v0 = tonumber(crop.v0 or crop[2]) or v0
					u1 = tonumber(crop.u1 or crop[3]) or u1
					v1 = tonumber(crop.v1 or crop[4]) or v1
				end
			end
		end

		u0, v0, u1, v1 = math.Clamp(u0, 0, 1), math.Clamp(v0, 0, 1), math.Clamp(u1, 0, 1), math.Clamp(v1, 0, 1)
		if u1 <= u0 then u0, u1 = 0, 1 end
		if v1 <= v0 then v0, v1 = 0, 1 end

		return u0, v0, u1, v1
	end

	local function imageFitRect(x, y, w, h, texture, style, u0, v0, u1, v1)
		local fit = style.fit or style.objectFit or "fill"
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
		local ax, ay = imageAlign(style)

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

	return {
		blurIntensity = blurIntensity,
		drawTexturedQuad = drawTexturedQuad,
		drawTexturedQuadUV = drawTexturedQuadUV,
		drawTransformedPoly = drawTransformedPoly,
		withTransform = withTransform,
		splitStyleTransform = splitStyleTransform,
		pushTransform = pushTransform,
		popTransform = popTransform,
		hasTransform = hasTransform,
		drawCreatedMaterialTexturedRectUV = drawCreatedMaterialTexturedRectUV,
		textureSize = textureSize,
		imageTint = imageTint,
		imageStyle = imageStyle,
		imageRadius = imageRadius,
		imageAlign = imageAlign,
		imageUV = imageUV,
		imageFitRect = imageFitRect,
	}
end
