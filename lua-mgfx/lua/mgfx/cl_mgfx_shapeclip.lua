if SERVER then return end

MGFX = MGFX or {}

function MGFX._InstallShapeClip(C)
	local M = C.M
	local INSTALL_VERSION = "coverage-v2.3"
	local installed = M._internal and M._internal.clipInstall
	if installed then
		if installed.version == INSTALL_VERSION then return M end
		error("MGFX Clip runtime changed during hot reload; perform a full client Lua refresh before installing the new version", 2)
	end
	local materials = C.materials
	local matOK = C.matOK
	local shadersActive = C.shadersActive
	local setupParamMatrix = C.setupParamMatrix
	local drawTexturedQuadUV = C.drawTexturedQuadUV
	local chamferTuple = C.chamferTuple
	local clipStack = C.clipStack
	local frameState = C.frameState
	local renderModeState = C.renderModeState or {}
	local hasTransform = C.hasTransform or function() return false end
	local render_CopyRenderTargetToTexture = C.renderCopyRenderTargetToTexture
	local render_CopyTexture = C.renderCopyTexture
	local render_PushRenderTarget = C.renderPushRenderTarget
	local render_PopRenderTarget = C.renderPopRenderTarget
	local render_GetBlend = C.renderGetBlend
	local render_GetColorModulation = C.renderGetColorModulation
	local render_OverrideBlend = C.renderOverrideBlend
	local render_OverrideAlphaWriteEnable = C.renderOverrideAlphaWriteEnable
	local render_SetBlend = C.renderSetBlend
	local render_SetColorModulation = C.renderSetColorModulation
	local render_SetScissorRect = C.renderSetScissorRect
	local surface_SetDrawColor = C.surfaceSetDrawColor
	local surface_SetMaterial = C.surfaceSetMaterial
	local surface_GetAlphaMultiplier = surface.GetAlphaMultiplier
	local surface_SetAlphaMultiplier = surface.SetAlphaMultiplier
	local surface_DrawRect = surface.DrawRect
	local surface_DrawTexturedRectUV = surface.DrawTexturedRectUV
	local cam_Start2D = cam.Start2D
	local cam_End2D = cam.End2D
	local cam_PushModelMatrix = cam.PushModelMatrix
	local cam_PopModelMatrix = cam.PopModelMatrix
	local ScrW = ScrW
	local ScrH = ScrH
	local bit_bor = bit.bor
	local math_ceil = math.ceil
	local math_abs = math.abs
	local math_floor = math.floor
	local math_max = math.max
	local math_min = math.min
	local unpack = unpack
	local select = select
	local MAX_CLIP_DEPTH = 4
	local MAX_CLIP_VALUE = 1048576
	local transparent = Color(0, 0, 0, 0)
	local shapeClipStack = {}
	local recordPool = {}
	local beforeTargets = {}
	local workTargets = {}
	local coverageTargetBuckets = {}
	local sourceMaterials = {}
	local maskSlots = {}
	local contextMatrices = {}
	local contextOffsets = {}
	local coverageMatrices = {}
	local coverageOffsets = {}
	local coverageRecorders = {}
	local namespace
	local activeRecorder
	local maskState = setmetatable({}, {__mode = "k"})

	local function pack(...)
		return {n = select("#", ...), ...}
	end

	assert(type(chamferTuple) == "function", "MGFX Clip requires chamfer support")
	assert(type(drawTexturedQuadUV) == "function", "MGFX Clip requires textured-quad support")
	assert(type(render_CopyRenderTargetToTexture) == "function", "MGFX Clip requires render.CopyRenderTargetToTexture")
	assert(type(render_CopyTexture) == "function", "MGFX Clip requires render.CopyTexture")
	assert(type(render_PushRenderTarget) == "function" and type(render_PopRenderTarget) == "function", "MGFX Clip requires render-target stack support")
	assert(type(cam_Start2D) == "function" and type(cam_End2D) == "function", "MGFX Clip requires a 2D render context")
	assert(type(cam_PushModelMatrix) == "function" and type(cam_PopModelMatrix) == "function", "MGFX Clip requires model-matrix stack support")
	assert(type(render_GetBlend) == "function" and type(render_GetColorModulation) == "function", "MGFX Clip requires render state queries")
	assert(type(render_OverrideBlend) == "function" and type(render_OverrideAlphaWriteEnable) == "function", "MGFX Clip requires blend overrides")
	assert(type(render_SetBlend) == "function" and type(render_SetColorModulation) == "function", "MGFX Clip requires render state setters")
	assert(type(render_SetScissorRect) == "function", "MGFX Clip requires scissor support")
	assert(type(surface_SetDrawColor) == "function" and type(surface_SetMaterial) == "function", "MGFX Clip requires surface material support")

	local function traceback(message)
		if debug and debug.traceback then
			return debug.traceback(tostring(message), 2)
		end
		return tostring(message)
	end

	local function restoreParentScissor()
		local parent = clipStack[#clipStack]
		if parent then
			render_SetScissorRect(parent.x, parent.y, parent.x + parent.w, parent.y + parent.h, true)
		else
			render_SetScissorRect(0, 0, 0, 0, false)
		end
	end

	local function acquireRecord()
		local index = #recordPool
		local record = recordPool[index]
		if record then
			recordPool[index] = nil
			return record
		end
		return {}
	end

	local function releaseRecord(record)
		if not record then return end
		for key in pairs(record) do record[key] = nil end
		recordPool[#recordPool + 1] = record
	end

	local function ensureNamespace()
		if namespace then return namespace end
		namespace = tostring(C.shaderVersion or "dev") .. "_" .. tostring(math_floor(SysTime() * 1000000))
		return namespace
	end

	local function createTarget(name)
		if not GetRenderTargetEx then
			error("MGFX Clip requires full-frame render-target support", 3)
		end
		local target = GetRenderTargetEx(
			name,
			-1,
			-1,
			RT_SIZE_FULL_FRAME_BUFFER,
			MATERIAL_RT_DEPTH_NONE,
			bit_bor(2, 256, 4, 8),
			0,
			IMAGE_FORMAT_BGRA8888
		)
		if not target then
			error("MGFX Clip failed to allocate a full-frame render target", 3)
		end
		return target
	end

	local function createCoverageTarget(name, width, height)
		if not GetRenderTargetEx then
			error("MGFX Clip requires render-target support", 3)
		end
		local target = GetRenderTargetEx(
			name,
			width,
			height,
			RT_SIZE_LITERAL,
			MATERIAL_RT_DEPTH_NONE,
			bit_bor(2, 256, 4, 8),
			0,
			IMAGE_FORMAT_BGRA8888
		)
		if not target then
			error("MGFX Clip failed to allocate a local coverage render target", 3)
		end
		return target
	end

	local function createSourceMaterial(target, role, depth)
		local material = CreateMaterial(
			"mgfx_clip_source_" .. role .. depth .. "_" .. ensureNamespace(),
			"UnlitGeneric",
			{
				["$basetexture"] = target:GetName(),
				["$translucent"] = "1",
				["$vertexcolor"] = "1",
				["$vertexalpha"] = "1",
				["$ignorez"] = "1",
			}
		)
		if not material or material:IsError() then
			error("MGFX Clip failed to create a coverage source material", 3)
		end
		return material
	end

	local function ensureTargets(depth)
		local ns = ensureNamespace()
		if not beforeTargets[depth] then
			local before = createTarget("mgfxsc_b" .. depth .. "_" .. ns)
			beforeTargets[depth] = before
		end
		if not workTargets[depth] then
			local work = createTarget("mgfxsc_w" .. depth .. "_" .. ns)
			local sourceMaterial = createSourceMaterial(work, "work", depth)
			workTargets[depth] = work
			sourceMaterials[work] = sourceMaterial
		end
		return beforeTargets[depth], workTargets[depth]
	end

	local function coverageBucketSize(required, screenSize)
		local maximum = math_ceil(screenSize) + 4
		local size = math_min(32, maximum)
		while size < required do
			size = math_min(size * 2, maximum)
			if size == maximum then break end
		end
		return size
	end

	local function ensureCoverageTargets(depth, rasterW, rasterH, screenW, screenH)
		-- One transparent guard texel after the raster prevents the right/bottom
		-- composite bleed sample from touching uncleared or unrelated texture data.
		local targetW = coverageBucketSize(rasterW + 1, screenW)
		local targetH = coverageBucketSize(rasterH + 1, screenH)
		local key = targetW .. "x" .. targetH
		local buckets = coverageTargetBuckets[depth]
		local pair = buckets and buckets[key]
		if pair then
			return pair.accumulator, pair.scratch, targetW, targetH
		end

		local ns = ensureNamespace()
		local accumulator = createCoverageTarget("mgfxsc_ma" .. depth .. "_" .. key .. "_" .. ns, targetW, targetH)
		local scratch = createCoverageTarget("mgfxsc_ms" .. depth .. "_" .. key .. "_" .. ns, targetW, targetH)
		local sourceMaterial = createSourceMaterial(scratch, "mask_scratch_" .. key .. "_", depth)
		pair = {
			accumulator = accumulator,
			scratch = scratch,
		}
		if not buckets then
			buckets = {}
			coverageTargetBuckets[depth] = buckets
		end
		buckets[key] = pair
		sourceMaterials[scratch] = sourceMaterial
		return accumulator, scratch, targetW, targetH
	end

	local function contextTransform(depth, x, y)
		local matrix = contextMatrices[depth]
		if not matrix then
			matrix = Matrix()
			contextMatrices[depth] = matrix
		end
		local offset = contextOffsets[depth]
		if not offset then
			offset = Vector()
			contextOffsets[depth] = offset
		end
		offset:SetUnpacked(x, y, 0)
		matrix:SetTranslation(offset)
		return matrix
	end

	local function coverageTransform(depth, x, y)
		local matrix = coverageMatrices[depth]
		if not matrix then
			matrix = Matrix()
			coverageMatrices[depth] = matrix
		end
		local offset = coverageOffsets[depth]
		if not offset then
			offset = Vector()
			coverageOffsets[depth] = offset
		end
		offset:SetUnpacked(x, y, 0)
		matrix:SetTranslation(offset)
		return matrix
	end

	local function setNeutralRenderState()
		if surface_SetAlphaMultiplier then surface_SetAlphaMultiplier(1) end
		render_SetColorModulation(1, 1, 1)
		render_SetBlend(1)
		render_OverrideAlphaWriteEnable(true, true)
	end

	local function appendCleanupError(current, label, callback)
		local ok, message = pcall(callback)
		if ok then return current end
		local detail = label .. ": " .. tostring(message)
		return current and (current .. "\n" .. detail) or detail
	end

	local function finishScope(results, cleanupError, level)
		if not results[1] then
			local message = tostring(results[2])
			if cleanupError then message = message .. "\nMGFX Clip cleanup failed: " .. cleanupError end
			error(message, level or 3)
		end
		if cleanupError then error("MGFX Clip cleanup failed: " .. cleanupError, level or 3) end
		return unpack(results, 2, results.n)
	end

	local function withRenderState(callback)
		local previousR, previousG, previousB = render_GetColorModulation()
		local previousBlend = render_GetBlend()
		local previousAlphaMultiplier = surface_GetAlphaMultiplier and surface_GetAlphaMultiplier() or 1
		local results = pack(xpcall(callback, traceback))
		local cleanupError
		-- GMod exposes no getter for either override descriptor. Clip therefore owns
		-- this override scope and must be entered outside caller-managed overrides.
		cleanupError = appendCleanupError(cleanupError, "blend override", function() render_OverrideBlend(false) end)
		cleanupError = appendCleanupError(cleanupError, "alpha-write override", function() render_OverrideAlphaWriteEnable(false) end)
		cleanupError = appendCleanupError(cleanupError, "color modulation", function() render_SetColorModulation(previousR, previousG, previousB) end)
		cleanupError = appendCleanupError(cleanupError, "blend", function() render_SetBlend(previousBlend) end)
		if surface_SetAlphaMultiplier then
			cleanupError = appendCleanupError(cleanupError, "surface alpha", function() surface_SetAlphaMultiplier(previousAlphaMultiplier) end)
		end
		return finishScope(results, cleanupError, 4)
	end

	local function withRenderTarget2D(target, targetW, targetH, callback)
		local targetPushed = false
		local contextStarted = false
		local results = pack(xpcall(function()
			render_PushRenderTarget(target, 0, 0, targetW, targetH)
			targetPushed = true
			cam_Start2D()
			contextStarted = true
			return callback()
		end, traceback))
		local cleanupError
		if contextStarted then cleanupError = appendCleanupError(cleanupError, "cam.End2D", cam_End2D) end
		if targetPushed then cleanupError = appendCleanupError(cleanupError, "render.PopRenderTarget", render_PopRenderTarget) end
		cleanupError = appendCleanupError(cleanupError, "scissor restore", restoreParentScissor)
		return finishScope(results, cleanupError, 4)
	end

	local function withModelMatrix(matrix, callback)
		local pushed = false
		local results = pack(xpcall(function()
			cam_PushModelMatrix(matrix)
			pushed = true
			return callback()
		end, traceback))
		local cleanupError
		if pushed then cleanupError = appendCleanupError(cleanupError, "cam.PopModelMatrix", cam_PopModelMatrix) end
		return finishScope(results, cleanupError, 4)
	end

	local function clearCoverageTarget(target, targetW, targetH)
		return withRenderTarget2D(target, targetW, targetH, function()
			render_SetScissorRect(0, 0, targetW, targetH, true)
			return withRenderState(function()
				setNeutralRenderState()
				render_OverrideBlend(true, BLEND_ZERO, BLEND_ZERO, BLENDFUNC_ADD, BLEND_ZERO, BLEND_ZERO, BLENDFUNC_ADD)
				surface_SetDrawColor(255, 255, 255, 255)
				surface_DrawRect(0, 0, targetW, targetH)
			end)
		end)
	end

	local function drawCoverageSource(source, rasterW, rasterH, targetW, targetH)
		local material = sourceMaterials[source]
		if not material then
			error("MGFX Clip has no coverage source material for an internal target", 3)
		end
		surface_SetMaterial(material)
		surface_SetDrawColor(255, 255, 255, 255)
		surface_DrawTexturedRectUV(0, 0, rasterW, rasterH, 0, 0, rasterW / targetW, rasterH / targetH)
	end

	local function combineCoverage(destination, source, sourceAlphaFactor, destinationAlphaFactor, blendFunction, rasterW, rasterH, targetW, targetH)
		return withRenderTarget2D(destination, targetW, targetH, function()
			render_SetScissorRect(0, 0, rasterW, rasterH, true)
			return withRenderState(function()
				setNeutralRenderState()
				render_OverrideBlend(true, BLEND_ZERO, BLEND_ZERO, BLENDFUNC_ADD, sourceAlphaFactor, destinationAlphaFactor, blendFunction)
				drawCoverageSource(source, rasterW, rasterH, targetW, targetH)
			end)
		end)
	end

	local function invertCoverage(target, w, h, rasterW, rasterH, targetW, targetH, padLeft, padTop)
		return withRenderTarget2D(target, targetW, targetH, function()
			render_SetScissorRect(0, 0, rasterW, rasterH, true)
			return withRenderState(function()
				setNeutralRenderState()
				render_OverrideBlend(true, BLEND_ZERO, BLEND_ZERO, BLENDFUNC_ADD, BLEND_ONE_MINUS_DST_ALPHA, BLEND_ZERO, BLENDFUNC_ADD)
				surface_SetDrawColor(255, 255, 255, 255)
				surface_DrawRect(padLeft, padTop, w, h)
			end)
		end)
	end

	local Recorder = {}
	Recorder.__index = Recorder

	local function requireActiveRecorder(recorder, method)
		if activeRecorder ~= recorder or not recorder.active then
			error("MGFX Mask recorder:" .. method .. " can only be used while its painter is running", 3)
		end
		if recorder.inOperation then
			error("MGFX Mask recorder operations cannot be nested", 3)
		end
	end

	local function drawOperationCoverage(recorder, callback)
		if not isfunction(callback) then
			error("MGFX Mask coverage operations require a callback", 3)
		end
		clearCoverageTarget(recorder.scratch, recorder.targetW, recorder.targetH)

		local results = pack(xpcall(function()
			return withRenderTarget2D(recorder.scratch, recorder.targetW, recorder.targetH, function()
				return withModelMatrix(coverageTransform(recorder.depth, recorder.padLeft, recorder.padTop), function()
					renderModeState.coverage = true
					renderModeState.coverageDrawing = true
					renderModeState.coverageX = 0
					renderModeState.coverageY = 0
					renderModeState.coverageW = recorder.rasterW
					renderModeState.coverageH = recorder.rasterH
					renderModeState.coverageOffsetX = recorder.padLeft
					renderModeState.coverageOffsetY = recorder.padTop
					render_SetScissorRect(0, 0, recorder.rasterW, recorder.rasterH, true)
					return withRenderState(function()
						setNeutralRenderState()
						render_OverrideBlend(true, BLEND_ZERO, BLEND_ZERO, BLENDFUNC_ADD, BLEND_ONE, BLEND_ONE, BLENDFUNC_MAX)
						return callback()
					end)
				end)
			end)
		end, traceback))
		renderModeState.coverageDrawing = false
		renderModeState.coverage = false
		finishScope(results, nil, 3)
		M.stats.maskOperations = (M.stats.maskOperations or 0) + 1
	end

	function Recorder:_combine(operation, callback)
		requireActiveRecorder(self, operation)
		self.inOperation = true
		local ok, message = xpcall(function()
			drawOperationCoverage(self, callback)
			if operation == "union" then
				combineCoverage(self.accumulator, self.scratch, BLEND_ONE, BLEND_ONE, BLENDFUNC_MAX, self.rasterW, self.rasterH, self.targetW, self.targetH)
			elseif operation == "subtract" then
				combineCoverage(self.accumulator, self.scratch, BLEND_ZERO, BLEND_ONE_MINUS_SRC_ALPHA, BLENDFUNC_ADD, self.rasterW, self.rasterH, self.targetW, self.targetH)
			elseif operation == "intersect" then
				combineCoverage(self.accumulator, self.scratch, BLEND_ZERO, BLEND_SRC_ALPHA, BLENDFUNC_ADD, self.rasterW, self.rasterH, self.targetW, self.targetH)
			elseif operation == "xor" then
				combineCoverage(self.accumulator, self.scratch, BLEND_ONE_MINUS_DST_ALPHA, BLEND_ONE_MINUS_SRC_ALPHA, BLENDFUNC_ADD, self.rasterW, self.rasterH, self.targetW, self.targetH)
			else
				error("MGFX Mask encountered an unsupported coverage operation", 2)
			end
		end, traceback)
		self.inOperation = false
		if not ok then error(message, 3) end
		return self
	end

	function Recorder:Draw(callback)
		return self:_combine("union", callback)
	end

	function Recorder:Union(callback)
		return self:_combine("union", callback)
	end

	function Recorder:Subtract(callback)
		return self:_combine("subtract", callback)
	end

	function Recorder:Intersect(callback)
		return self:_combine("intersect", callback)
	end

	function Recorder:Xor(callback)
		return self:_combine("xor", callback)
	end

	function Recorder:Invert()
		requireActiveRecorder(self, "Invert")
		self.inOperation = true
		local ok, message = xpcall(function()
			invertCoverage(self.accumulator, self.w, self.h, self.rasterW, self.rasterH, self.targetW, self.targetH, self.padLeft, self.padTop)
		end, traceback)
		self.inOperation = false
		if not ok then error(message, 3) end
		M.stats.maskOperations = (M.stats.maskOperations or 0) + 1
		return self
	end

	local MaskMethods = {}
	MaskMethods.__index = MaskMethods
	MaskMethods.__newindex = function()
		error("MGFX Mask objects are immutable; update captured painter state and call mask:Invalidate()", 2)
	end

	function MaskMethods:Invalidate()
		local state = maskState[self]
		if not state then error("MGFX received an invalid Mask object", 2) end
		if state.type == "preset" then
			error("MGFX preset Masks are immutable", 2)
		end
		state.revision = state.revision + 1
		return self
	end

	function MaskMethods:Clip(x, y, w, h, callback)
		return M.Clip(self, x, y, w, h, callback)
	end

	local function customMask(painter)
		if not isfunction(painter) then
			error("MGFX.Mask requires a painter function", 3)
		end
		local mask = setmetatable({}, MaskMethods)
		maskState[mask] = {
			type = "custom",
			revision = 1,
			painter = painter,
		}
		return mask
	end

	local function presetMask(kind, options)
		local mask = setmetatable({}, MaskMethods)
		local values = istable(options) and table.Copy(options) or {}
		if not istable(options) and options ~= nil then
			values.radius = options
		end
		maskState[mask] = {
			type = "preset",
			kind = kind,
			values = values,
		}
		return mask
	end

	M.Mask = customMask
	M.Masks = {
		Circle = presetMask("circle"),
		Capsule = presetMask("capsule"),
		Rounded = function(options)
			return presetMask("rounded", options)
		end,
		Chamfer = function(options)
			return presetMask("chamfer", options)
		end,
	}

	local function rasterizeCustomMask(mask, state, w, h, phaseX, phaseY, depth, screenW, screenH)
		local rasterW = math_ceil(w + phaseX) + 2
		local rasterH = math_ceil(h + phaseY) + 2
		local extraX = math_max(0, rasterW - w - phaseX)
		local extraY = math_max(0, rasterH - h - phaseY)
		local padLeft = math_min(1, extraX * 0.5)
		local padTop = math_min(1, extraY * 0.5)
		local originX = padLeft + phaseX
		local originY = padTop + phaseY
		local padRight = math_min(1, math_max(0, rasterW - originX - w))
		local padBottom = math_min(1, math_max(0, rasterH - originY - h))
		local accumulator, scratch, targetW, targetH = ensureCoverageTargets(depth, rasterW, rasterH, screenW, screenH)

		local slot = maskSlots[depth]
		if not slot then
			slot = {maskRef = setmetatable({}, {__mode = "v"})}
			maskSlots[depth] = slot
		end
		local revision = state.revision
		if slot.maskRef[1] == mask and slot.revision == revision and slot.w == w and slot.h == h
			and slot.phaseX == phaseX and slot.phaseY == phaseY
			and slot.target == accumulator and slot.targetW == targetW and slot.targetH == targetH then
			M.stats.maskCacheHits = (M.stats.maskCacheHits or 0) + 1
			return accumulator,
				originX / targetW, originY / targetH,
				(originX + w) / targetW, (originY + h) / targetH,
				originX, originY, padRight, padBottom
		end

		clearCoverageTarget(accumulator, targetW, targetH)
		local recorder = coverageRecorders[depth]
		if not recorder then
			recorder = setmetatable({}, Recorder)
			coverageRecorders[depth] = recorder
		end
		recorder.active = true
		recorder.inOperation = false
		recorder.depth = depth
		recorder.w = w
		recorder.h = h
		recorder.rasterW = rasterW
		recorder.rasterH = rasterH
		recorder.targetW = targetW
		recorder.targetH = targetH
		recorder.accumulator = accumulator
		recorder.scratch = scratch
		recorder.padLeft = originX
		recorder.padTop = originY
		activeRecorder = recorder
		renderModeState.coverage = true
		renderModeState.coverageDrawing = false

		local ok, message = xpcall(function()
			state.painter(recorder, w, h)
		end, traceback)

		renderModeState.coverageDrawing = false
		renderModeState.coverage = false
		activeRecorder = nil
		recorder.active = false
		recorder.inOperation = false
		if not ok then error(message, 3) end

		slot.maskRef[1] = mask
		slot.target = accumulator
		slot.revision = revision
		slot.w = w
		slot.h = h
		slot.phaseX = phaseX
		slot.phaseY = phaseY
		slot.targetW = targetW
		slot.targetH = targetH
		M.stats.maskRasterizations = (M.stats.maskRasterizations or 0) + 1
		return accumulator,
			originX / targetW, originY / targetH,
			(originX + w) / targetW, (originY + h) / targetH,
			originX, originY, padRight, padBottom
	end

	local function finiteNumber(value, label, default)
		if value == nil and default ~= nil then return default end
		if type(value) ~= "number" or value ~= value or value == math.huge or value == -math.huge or math_abs(value) > MAX_CLIP_VALUE then
			error("MGFX Clip requires a finite " .. label, 3)
		end
		return value
	end

	local function relativeValue(value, units, w, h)
		local number = finiteNumber(value, "Mask radius", 0)
		if units == nil or units == "local" then
			return math_min(math_max(0, number), math_min(w, h) * 0.5)
		end
		if units == "bounds" then
			return math_min(math_max(0, number) * math_min(w, h), math_min(w, h) * 0.5)
		end
		error("MGFX Mask uses an unsupported units value: " .. tostring(units), 3)
	end

	local function relativeCuts(cuts, units, w, h)
		local scale = units == "bounds" and math_min(w, h) or 1
		local limit = math_min(w, h)
		if units ~= nil and units ~= "local" and units ~= "bounds" then
			error("MGFX Mask uses an unsupported units value: " .. tostring(units), 3)
		end
		if not istable(cuts) then return math_min(math_max(0, finiteNumber(cuts, "Mask cuts", 0) * scale), limit) end
		return {
			tl = math_min(math_max(0, finiteNumber(cuts.tl or cuts[1], "Mask top-left cut", 0) * scale), limit),
			tr = math_min(math_max(0, finiteNumber(cuts.tr or cuts[2], "Mask top-right cut", 0) * scale), limit),
			br = math_min(math_max(0, finiteNumber(cuts.br or cuts[3], "Mask bottom-right cut", 0) * scale), limit),
			bl = math_min(math_max(0, finiteNumber(cuts.bl or cuts[4], "Mask bottom-left cut", 0) * scale), limit),
		}
	end

	local function resolveMask(mask, w, h, phaseX, phaseY, depth, screenW, screenH)
		if not istable(mask) then
			error("MGFX.Clip requires an MGFX Mask or preset", 3)
		end
		local state = maskState[mask]
		if not state then
			error("MGFX.Clip requires an MGFX Mask or preset", 3)
		end
		if state.type == "custom" then
			local texture, u0, v0, u1, v1, bleedLeft, bleedTop, bleedRight, bleedBottom = rasterizeCustomMask(mask, state, w, h, phaseX, phaseY, depth, screenW, screenH)
			return 10, 0, u0, v0, u1, v1, texture, bleedLeft, bleedTop, bleedRight, bleedBottom
		end
		local values = state.values

		if state.kind == "rounded" then
			return 0, relativeValue(values.radius, values.units, w, h), 0, 0, 0, 0, nil, 1, 1, 1, 1
		end
		if state.kind == "chamfer" then
			local p0, p1, p2, p3 = chamferTuple(relativeCuts(values.cuts, values.units, w, h), w, h)
			return 1, 0, p0, p1, p2, p3, nil, 1, 1, 1, 1
		end
		if state.kind == "circle" then return 2, 0, 0, 0, 0, 0, nil, 1, 1, 1, 1 end
		if state.kind == "capsule" then return 3, 0, 0, 0, 0, 0, nil, 1, 1, 1, 1 end
		error("MGFX.Clip received an unsupported Mask preset", 3)
	end

	local rawPushClip = M.PushClip
	local rawPopClip = M.PopClip

	local function cleanupRecord(record)
		local cleanupError
		while #clipStack > record.clipDepth do
			local ok, message = pcall(rawPopClip)
			if not ok then
				cleanupError = message
				break
			end
		end
		if record.targetPushed then
			if record.modelPushed then
				local ok, message = pcall(cam_PopModelMatrix)
				record.modelPushed = false
				if not ok and not cleanupError then cleanupError = message end
			end
			if record.contextStarted then
				local ok, message = pcall(cam_End2D)
				record.contextStarted = false
				if not ok and not cleanupError then cleanupError = message end
			end
			local ok, message = pcall(render_PopRenderTarget)
			record.targetPushed = false
			if not ok and not cleanupError then cleanupError = message end
		end
		local ok, message = pcall(restoreParentScissor)
		if not ok and not cleanupError then cleanupError = message end
		return cleanupError
	end

	local function throwWithCleanup(primary, cleanupError)
		if cleanupError then
			error(tostring(primary) .. "\nMGFX Clip cleanup failed: " .. tostring(cleanupError), 2)
		end
		error(primary, 2)
	end

	local function composite(record)
		local material = materials.shape_clip
		if not shadersActive() or not matOK(material) then
			error("MGFX Clip requires the shape_clip shader", 3)
		end

		material:SetTexture("$texture3", record.beforeRT)
		material:SetTexture("$texture1", record.workRT)
		if record.maskTexture then material:SetTexture("$texture2", record.maskTexture) end
		setupParamMatrix(material,
			record.screenU, record.screenV, record.screenUW, record.screenVH,
			record.w, record.h, record.kind, record.radius,
			record.p0, record.p1, record.p2, record.p3,
			0, 0, 0, 0
		)

		return withRenderState(function()
			setNeutralRenderState()
			render_OverrideBlend(true, BLEND_ONE, BLEND_ZERO, BLENDFUNC_ADD, BLEND_ONE, BLEND_ZERO, BLENDFUNC_ADD)
			surface_SetMaterial(material)
			surface_SetDrawColor(255, 255, 255, 255)
			return drawTexturedQuadUV(
				record.localX - record.bleedLeft,
				record.localY - record.bleedTop,
				record.w + record.bleedLeft + record.bleedRight,
				record.h + record.bleedTop + record.bleedBottom,
				-record.bleedLeft / record.w,
				-record.bleedTop / record.h,
				1 + record.bleedRight / record.w,
				1 + record.bleedBottom / record.h,
				material
			)
		end)
	end

	local function retireRecord(depth, record)
		shapeClipStack[depth] = nil
		local wasCommands = record.wasCommands
		releaseRecord(record)
		M._ResumeCommands(wasCommands)
	end

	local function pushMaskClip(mask, x, y, w, h)
		if activeRecorder then
			error("MGFX.Clip cannot be used while recording Mask coverage", 3)
		end
		if frameState.w == nil or frameState.h == nil then
			error("MGFX.Clip requires an active StartPanel/StartScreen frame", 3)
		end
		if not istable(mask) or not maskState[mask] then
			error("MGFX.Clip requires an MGFX Mask or preset", 3)
		end
		if hasTransform() then
			error("MGFX.Clip does not support an active MGFX transform; screen-space coverage requires an axis-aligned frame", 3)
		end
		x = finiteNumber(x, "x", 0)
		y = finiteNumber(y, "y", 0)
		w = finiteNumber(w, "width")
		h = finiteNumber(h, "height")
		if w <= 0 or h <= 0 then
			error("MGFX.Clip requires positive width and height", 3)
		end

		local screenW = finiteNumber(ScrW(), "screen width")
		local screenH = finiteNumber(ScrH(), "screen height")
		if screenW <= 0 or screenH <= 0 then
			error("MGFX.Clip requires a valid screen size", 3)
		end
		if w > screenW or h > screenH then
			error("MGFX.Clip bounds cannot exceed the framebuffer dimensions", 3)
		end
		local depth = #shapeClipStack + 1
		if depth > MAX_CLIP_DEPTH then
			error("MGFX.Clip exceeds the maximum nesting depth of " .. MAX_CLIP_DEPTH, 3)
		end
		local before, work = ensureTargets(depth)
		local record = acquireRecord()
		record.wasCommands = M._SuspendCommands()
		record.clipDepth = #clipStack

		local ok, message = xpcall(function()
			local sx = finiteNumber(finiteNumber(frameState.screenX, "frame screen x", 0) + x, "screen x")
			local sy = finiteNumber(finiteNumber(frameState.screenY, "frame screen y", 0) + y, "screen y")
			local phaseX = sx - math_floor(sx)
			local phaseY = sy - math_floor(sy)
			local kind, radius, p0, p1, p2, p3, maskTexture, bleedLeft, bleedTop, bleedRight, bleedBottom = resolveMask(mask, w, h, phaseX, phaseY, depth, screenW, screenH)
			record.localX, record.localY, record.w, record.h = x, y, w, h
			record.screenU, record.screenV = sx / screenW, sy / screenH
			record.screenUW, record.screenVH = w / screenW, h / screenH
			record.kind, record.radius = kind, radius
			record.p0, record.p1, record.p2, record.p3 = p0, p1, p2, p3
			record.maskTexture = maskTexture
			record.bleedLeft, record.bleedTop = bleedLeft, bleedTop
			record.bleedRight, record.bleedBottom = bleedRight, bleedBottom
			record.beforeRT = before
			record.workRT = work

			render_CopyRenderTargetToTexture(before)
			render_CopyTexture(before, work)
			render_PushRenderTarget(work, 0, 0, screenW, screenH)
			record.targetPushed = true
			cam_Start2D()
			record.contextStarted = true
			cam_PushModelMatrix(contextTransform(depth, frameState.screenX or 0, frameState.screenY or 0))
			record.modelPushed = true
			restoreParentScissor()
			rawPushClip(x - bleedLeft, y - bleedTop, w + bleedLeft + bleedRight, h + bleedTop + bleedBottom)
		end, traceback)
		if not ok then
			local cleanupError = cleanupRecord(record)
			local wasCommands = record.wasCommands
			releaseRecord(record)
			M._ResumeCommands(wasCommands)
			throwWithCleanup(message, cleanupError)
		end

		shapeClipStack[depth] = record
		M.stats.shapeClipCaptures = (M.stats.shapeClipCaptures or 0) + 1
		M.stats.shapeClipDepthMax = math_max(M.stats.shapeClipDepthMax or 0, depth)
	end

	local function popMaskClip()
		local depth = #shapeClipStack
		if depth <= 0 then
			error("MGFX internal Clip scope mismatch", 3)
		end
		local record = shapeClipStack[depth]
		local ok, message = xpcall(function()
			if #clipStack ~= record.clipDepth + 1 then
				error("MGFX Clip contains unbalanced PushClip/PopClip calls", 2)
			end
			rawPopClip()
			cam_PopModelMatrix()
			record.modelPushed = false
			cam_End2D()
			record.contextStarted = false
			render_PopRenderTarget()
			record.targetPushed = false
			restoreParentScissor()
			composite(record)
		end, traceback)
		if not ok then
			local cleanupError = cleanupRecord(record)
			retireRecord(depth, record)
			throwWithCleanup(message, cleanupError)
		end

		retireRecord(depth, record)
		M.stats.shapeClipComposites = (M.stats.shapeClipComposites or 0) + 1
	end

	function M.Clip(mask, x, y, w, h, callback)
		if not isfunction(callback) then
			error("MGFX.Clip requires a callback", 2)
		end
		pushMaskClip(mask, x, y, w, h)
		local results = pack(xpcall(callback, traceback))
		local popOk, popError = pcall(popMaskClip)
		if not results[1] then
			if not popOk then
				error(tostring(results[2]) .. "\nMGFX Clip cleanup failed: " .. tostring(popError), 2)
			end
			error(results[2], 2)
		end
		if not popOk then error(popError, 2) end
		return unpack(results, 2, results.n)
	end

	local forbiddenStyleKeys = {
		"backdrop",
		"shadow",
		"outerGlow",
		"innerGlow",
	}

	local function validateCoverageStyle(name, style)
		if not istable(style) then return end
		for index = 1, #forbiddenStyleKeys do
			local key = forbiddenStyleKeys[index]
			if style[key] ~= nil and style[key] ~= false then
				error("MGFX Mask coverage does not support " .. name .. " style." .. key, 3)
			end
		end
	end

	local styleArgument = {
		RoundedBoxEx = 5,
		CircleEx = 4,
		CapsuleEx = 5,
		ChamferBoxEx = 5,
		LineEx = 5,
		PolyEx = 2,
		RegularPolyEx = 5,
		DiamondEx = 5,
		CaretEx = 5,
		TextEx = 8,
		TextBoxEx = 7,
		RingEx = 5,
		ArcEx = 7,
		SectorEx = 7,
		ImageEx = 6,
		IconEx = 6,
		ProgressBarEx = 6,
		SegmentBarEx = 6,
	}

	local drawApiNames = {
		"RoundedBox", "RoundedBoxEx", "Circle", "CircleEx", "Capsule", "CapsuleEx",
		"ChamferBox", "ChamferBoxEx", "Line", "LineNoCaps", "LineEx", "Poly", "PolyEx",
		"RegularPoly", "RegularPolyEx", "Diamond", "DiamondEx", "Caret", "CaretEx",
		"Ring", "RingEx", "Arc", "ArcEx", "Sector", "SectorEx",
		"Image", "ImageUV", "ImageEx", "Icon", "IconEx",
		"Text", "TextEx", "TextBox", "TextBoxEx",
		"ProgressBar", "ProgressBarEx", "SegmentBar", "SegmentBarEx",
	}

	local function restoreRecorderBlend()
		if not activeRecorder or not renderModeState.coverageDrawing then return end
		setNeutralRenderState()
		render_OverrideBlend(true, BLEND_ZERO, BLEND_ZERO, BLENDFUNC_ADD, BLEND_ONE, BLEND_ONE, BLENDFUNC_MAX)
	end

	for index = 1, #drawApiNames do
		local name = drawApiNames[index]
		local original = M[name]
		if isfunction(original) then
			local styleIndex = styleArgument[name]
			M[name] = function(...)
				if not activeRecorder then return original(...) end
				if not renderModeState.coverageDrawing then
					error("MGFX drawing commands must be inside m:Draw/Union/Subtract/Intersect/Xor", 2)
				end
				if styleIndex then validateCoverageStyle(name, select(styleIndex, ...)) end
				local arguments = pack(...)
				local results = pack(xpcall(function()
					return original(unpack(arguments, 1, arguments.n))
				end, traceback))
				restoreRecorderBlend()
				if not results[1] then error(results[2], 2) end
				return unpack(results, 2, results.n)
			end
		end
	end

	local rawRoundedBoxBackdrop = M.RoundedBoxBackdrop
	if isfunction(rawRoundedBoxBackdrop) then
		M.RoundedBoxBackdrop = function(...)
			if activeRecorder then
				error("MGFX Mask coverage does not support backdrop drawing", 2)
			end
			return rawRoundedBoxBackdrop(...)
		end
	end

	local rawTextBatchEx = M.TextBatchEx
	if isfunction(rawTextBatchEx) then
		M.TextBatchEx = function(...)
			if activeRecorder then
				error("MGFX Mask coverage does not support TextBatchEx; draw text records explicitly", 2)
			end
			return rawTextBatchEx(...)
		end
	end

	M.PushClip = function(...)
		if activeRecorder then
			error("MGFX Mask coverage cannot contain nested Clip scopes", 2)
		end
		return rawPushClip(...)
	end
	M.PopClip = function(...)
		if activeRecorder then
			error("MGFX Mask coverage cannot contain nested Clip scopes", 2)
		end
		return rawPopClip(...)
	end

	local selfRoundedPreset = presetMask("rounded")
	local selfCirclePreset = M.Masks.Circle
	local selfCapsulePreset = M.Masks.Capsule
	local selfChamferPreset = presetMask("chamfer")

	local function validateSelfClip(children, style, shapeName)
		if not isfunction(children) then
			error("MGFX." .. shapeName .. " children must be a callback", 3)
		end
		if hasTransform() then
			error("MGFX " .. shapeName .. " self clipping does not support an active MGFX transform", 3)
		end
		if istable(style) and style.transform ~= nil and style.transform ~= false then
			error("MGFX " .. shapeName .. " self clipping does not support a transformed shape", 3)
		end
	end

	local function splitSelfClipStyle(style, shapeField)
		if not istable(style) or style.stroke == nil or style.stroke == false then
			return style
		end
		local background = {}
		for key, value in pairs(style) do background[key] = value end
		background.stroke = nil
		background.strokeWidth = nil
		local foreground = {
			fill = transparent,
			stroke = style.stroke,
			strokeWidth = style.strokeWidth,
		}
		if shapeField then foreground[shapeField] = style[shapeField] end
		return background, foreground
	end

	local function checkedSelfClipBounds(x, y, w, h)
		x = finiteNumber(x, "self-clip x", 0)
		y = finiteNumber(y, "self-clip y", 0)
		w = finiteNumber(w, "self-clip width")
		h = finiteNumber(h, "self-clip height")
		if w <= 0 or h <= 0 then
			error("MGFX self clipping requires positive width and height", 3)
		end
		if w > finiteNumber(ScrW(), "screen width") or h > finiteNumber(ScrH(), "screen height") then
			error("MGFX self-clip bounds cannot exceed the framebuffer dimensions", 3)
		end
		return x, y, w, h
	end

	local drawRoundedBoxEx = M.RoundedBoxEx
	M.RoundedBoxEx = function(x, y, w, h, style, children)
		if children == nil then return drawRoundedBoxEx(x, y, w, h, style) end
		validateSelfClip(children, style, "RoundedBoxEx")
		x, y, w, h = checkedSelfClipBounds(x, y, w, h)
		local radius = istable(style) and (style.radius ~= nil and style.radius or style.r) or 0
		if istable(radius) then
			error("MGFX RoundedBoxEx self clipping currently requires a scalar radius", 2)
		end
		radius = finiteNumber(radius, "self-clip radius", 0)
		local values = maskState[selfRoundedPreset].values
		values.radius = radius
		values.units = "local"
		local background, foreground = splitSelfClipStyle(style)
		if foreground then foreground.radius = radius end
		local results = pack(drawRoundedBoxEx(x, y, w, h, background))
		M.Clip(selfRoundedPreset, x, y, w, h, function()
			children(x, y, w, h)
		end)
		if foreground then drawRoundedBoxEx(x, y, w, h, foreground) end
		return unpack(results, 1, results.n)
	end

	local drawCircleEx = M.CircleEx
	M.CircleEx = function(cx, cy, radius, style, children)
		if children == nil then return drawCircleEx(cx, cy, radius, style) end
		validateSelfClip(children, style, "CircleEx")
		cx = finiteNumber(cx, "self-clip center x", 0)
		cy = finiteNumber(cy, "self-clip center y", 0)
		radius = finiteNumber(radius, "self-clip radius")
		if radius <= 0 then error("MGFX CircleEx self clipping requires a positive radius", 2) end
		local size = radius * 2
		local x, y = cx - radius, cy - radius
		x, y, size = checkedSelfClipBounds(x, y, size, size)
		local background, foreground = splitSelfClipStyle(style)
		local results = pack(drawCircleEx(cx, cy, radius, background))
		M.Clip(selfCirclePreset, x, y, size, size, function()
			children(x, y, size, size)
		end)
		if foreground then drawCircleEx(cx, cy, radius, foreground) end
		return unpack(results, 1, results.n)
	end

	local drawCapsuleEx = M.CapsuleEx
	M.CapsuleEx = function(x, y, w, h, style, children)
		if children == nil then return drawCapsuleEx(x, y, w, h, style) end
		validateSelfClip(children, style, "CapsuleEx")
		x, y, w, h = checkedSelfClipBounds(x, y, w, h)
		local background, foreground = splitSelfClipStyle(style)
		local results = pack(drawCapsuleEx(x, y, w, h, background))
		M.Clip(selfCapsulePreset, x, y, w, h, function()
			children(x, y, w, h)
		end)
		if foreground then drawCapsuleEx(x, y, w, h, foreground) end
		return unpack(results, 1, results.n)
	end

	local drawChamferBoxEx = M.ChamferBoxEx
	M.ChamferBoxEx = function(x, y, w, h, style, children)
		if children == nil then return drawChamferBoxEx(x, y, w, h, style) end
		validateSelfClip(children, style, "ChamferBoxEx")
		x, y, w, h = checkedSelfClipBounds(x, y, w, h)
		local cuts = relativeCuts(istable(style) and style.cuts or 0, "local", w, h)
		local values = maskState[selfChamferPreset].values
		values.cuts = cuts
		values.units = "local"
		local background, foreground = splitSelfClipStyle(style, "cuts")
		local results = pack(drawChamferBoxEx(x, y, w, h, background))
		M.Clip(selfChamferPreset, x, y, w, h, function()
			children(x, y, w, h)
		end)
		if foreground then drawChamferBoxEx(x, y, w, h, foreground) end
		return unpack(results, 1, results.n)
	end

	M.PushShapeClip = nil
	M.PopShapeClip = nil
	M.WithShapeClip = nil
	M.ShapeClip = nil

	local rawEndPanel = M.EndPanel
	local rawEndScreen = M.EndScreen
	local function clearRecords()
		local cleanupError
		for index = #shapeClipStack, 1, -1 do
			local record = shapeClipStack[index]
			local message = cleanupRecord(record)
			if message and not cleanupError then cleanupError = message end
			retireRecord(index, record)
		end
		return cleanupError
	end
	local function endClipFrame(rawEnd, label)
		local unclosed = #shapeClipStack
		if unclosed <= 0 then return rawEnd() end

		local closeError
		while #shapeClipStack > 0 and not closeError do
			local ok, message = pcall(popMaskClip)
			if not ok then closeError = message end
		end
		if closeError then
			local cleanupError = clearRecords()
			if cleanupError then
				closeError = tostring(closeError) .. "\nMGFX Clip cleanup failed: " .. tostring(cleanupError)
			end
		end
		rawEnd()
		if closeError then
			error("MGFX " .. label .. " recovered an invalid Clip scope: " .. tostring(closeError), 2)
		end
		error("MGFX " .. label .. " found " .. unclosed .. " unclosed Clip scope(s)", 2)
	end
	M.EndPanel = function() return endClipFrame(rawEndPanel, "EndPanel") end
	M.EndScreen = function() return endClipFrame(rawEndScreen, "EndScreen") end
	M._internal.clipInstall = {
		version = INSTALL_VERSION,
	}
	return M
end
