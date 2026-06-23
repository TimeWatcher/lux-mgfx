if SERVER then return end

MGFX = MGFX or {}

function MGFX._CreateFrameGeometry(C)
	C = C or {}

	local M = C.M or MGFX
	local stats = C.stats or M.stats or {}
	local clipStack = C.clipStack or {}
	local frameState = C.frameState or {}
	local DisableClipping = DisableClipping
	local math_floor = math.floor
	local math_ceil = math.ceil
	local math_max = math.max
	local math_min = math.min

	local function panelClip()
		for i = 1, #clipStack do
			local clip = clipStack[i]
			if clip and clip.frame then
				return clip
			end
		end
		return clipStack[1]
	end

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

	local function withPanelEffectBleed(left, top, right, bottom, fn)
		left = math_max(0, tonumber(left) or 0)
		top = math_max(0, tonumber(top) or 0)
		right = math_max(0, tonumber(right) or 0)
		bottom = math_max(0, tonumber(bottom) or 0)
		if left <= 0 and top <= 0 and right <= 0 and bottom <= 0 then
			return fn()
		end

		local clip = panelClip()
		if not clip then
			return fn()
		end

		local prevClipping
		if DisableClipping then
			prevClipping = DisableClipping(true)
		end

		render.SetScissorRect(
			math_floor(clip.x - left),
			math_floor(clip.y - top),
			math_ceil(clip.x + clip.w + right),
			math_ceil(clip.y + clip.h + bottom),
			true
		)

		local ok, a, b, c, d = pcall(fn)
		restoreScissor()
		if DisableClipping then
			DisableClipping(prevClipping)
		end
		if not ok then
			error(a, 2)
		end
		return a, b, c, d
	end

	return {
		isCulled = isCulled,
		restoreScissor = restoreScissor,
		withLocalScissor = withLocalScissor,
		withScreenScissorPixels = withScreenScissorPixels,
		withPanelEffectBleed = withPanelEffectBleed,
	}
end
