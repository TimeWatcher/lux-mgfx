if SERVER then return end

MGFX = MGFX or {}

function MGFX._CreateFrameGeometry(C)
	C = C or {}

	local M = C.M or MGFX
	local stats = C.stats or M.stats or {}
	local clipStack = C.clipStack or {}
	local frameState = C.frameState or {}
	local math_floor = math.floor
	local math_ceil = math.ceil
	local math_max = math.max
	local math_min = math.min

	local function isCulled(x, y, w, h)
		if w <= 0 or h <= 0 then
			stats.culled = (stats.culled or 0) + 1
			return true
		end

		local clip = clipStack[#clipStack]
		if not clip then return false end
		if (clip.w or 0) <= 0 or (clip.h or 0) <= 0 then
			stats.culled = (stats.culled or 0) + 1
			return true
		end
		if x + w < clip.localX or y + h < clip.localY or x > clip.localX + clip.w or y > clip.localY + clip.h then
			stats.culled = (stats.culled or 0) + 1
			return true
		end

		return false
	end

	local function restoreScissor()
		local clip = clipStack[#clipStack]
		if clip then
			render.SetScissorRect(clip.x, clip.y, clip.x + clip.w, clip.y + clip.h, true)
		else
			render.SetScissorRect(0, 0, 0, 0, false)
		end
	end

	local function withLocalScissor(x, y, w, h, fn)
		if w <= 0 or h <= 0 then return end

		local sx = frameState.screenX + x
		local sy = frameState.screenY + y
		local ex = sx + w
		local ey = sy + h
		local clip = clipStack[#clipStack]

		if clip then
			sx = math_max(sx, clip.x)
			sy = math_max(sy, clip.y)
			ex = math_min(ex, clip.x + clip.w)
			ey = math_min(ey, clip.y + clip.h)
		end

		if ex <= sx or ey <= sy then return end

		render.SetScissorRect(math_floor(sx), math_floor(sy), math_ceil(ex), math_ceil(ey), true)
		fn()
		restoreScissor()
	end

	local function withScreenScissorPixels(sx, sy, ex, ey, fn)
		if ex <= sx or ey <= sy then return end

		local clip = clipStack[#clipStack]
		if clip then
			sx = math_max(sx, clip.x)
			sy = math_max(sy, clip.y)
			ex = math_min(ex, clip.x + clip.w)
			ey = math_min(ey, clip.y + clip.h)
		end

		if ex <= sx or ey <= sy then return end

		render.SetScissorRect(sx, sy, ex, ey, true)
		fn()
		restoreScissor()
	end

	return {
		isCulled = isCulled,
		restoreScissor = restoreScissor,
		withLocalScissor = withLocalScissor,
		withScreenScissorPixels = withScreenScissorPixels,
	}
end
