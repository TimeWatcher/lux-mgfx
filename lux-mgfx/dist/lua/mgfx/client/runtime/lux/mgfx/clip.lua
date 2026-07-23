return function(__lux_import)
  local __lux_exports = {}
  local typeOf
  local install
  do
    local frame = __lux_import("lux/mgfx/frame#client")
    local geometry = __lux_import("lux/mgfx/geometry#client")
    local primitives = __lux_import("lux/mgfx/primitives#client")
    typeOf = type
    install = function(M)
      local acquireRecord
      local appendCleanupError
      local checkedSelfClipBounds
      local cleanupRecord
      local clearCoverageTarget
      local clearRecords
      local combineCoverage
      local composite
      local contextTransform
      local coverageTransform
      local createSourceMaterial
      local createTarget
      local customMask
      local drawCoverageSource
      local drawOperationCoverage
      local endClipFrame
      local ensureMaskTarget
      local ensureNamespace
      local ensureTargets
      local finishScope
      local finiteNumber
      local invertCoverage
      local pack
      local popMaskClip
      local presetMask
      local pushMaskClip
      local rasterizeCustomMask
      local relativeCuts
      local relativeValue
      local releaseRecord
      local requireActiveRecorder
      local resolveMask
      local restoreParentScissor
      local restoreRecorderBlend
      local retireRecord
      local setNeutralRenderState
      local splitSelfClipStyle
      local throwWithCleanup
      local traceback
      local validateCoverageStyle
      local validateSelfClip
      local withModelMatrix
      local withRenderState
      local withRenderTarget2D

      local installVersion = "coverage-v2"
      local installed
      do
        local __lux_obj_internal_1 = M._internal
        local __lux_val_clipInstall_2 = nil
        if __lux_obj_internal_1 ~= nil then
          __lux_val_clipInstall_2 = __lux_obj_internal_1.clipInstall
        end
        installed = __lux_val_clipInstall_2
      end
      if installed ~= nil then
        if installed.version == installVersion and installed.clip == M.Clip and installed.roundedBoxEx == M.RoundedBoxEx and installed.endPanel == M.EndPanel then
          return M
        end
        error(
          "MGFX Clip runtime changed during hot reload; perform a full client Lua refresh before installing the new version",
          2
        )
      end
      local materials = M._Materials
      local materialOK = M.MaterialOK
      local shadersActive = M.hasShaders
      local setupParamMatrix
      do
        local __lux_obj_internal_3 = M._internal
        local __lux_val_setupParamMatrix_4 = nil
        if __lux_obj_internal_3 ~= nil then
          __lux_val_setupParamMatrix_4 = __lux_obj_internal_3.setupParamMatrix
        end
        setupParamMatrix = __lux_val_setupParamMatrix_4
      end
      local drawTexturedQuadUV = geometry.drawTexturedQuadUV
      local chamferTuple = primitives.chamferTuple
      local frameState = frame.current()
      local shapeClipStack = {}
      local recordPool = {}
      local beforeTargets = {}
      local workTargets = {}
      local maskTargets = {}
      local sourceMaterials = {}
      local maskSlots = {}
      local contextMatrices = {}
      local contextOffsets = {}
      local coverageMatrices = {}
      local coverageOffsets = {}
      local coverageRecorders = {}
      local namespace = nil
      local activeRecorder = nil
      local maskState = setmetatable({}, { __mode = "k" })
      local surfaceGetAlphaMultiplier = surface.GetAlphaMultiplier
      local surfaceSetAlphaMultiplier = surface.SetAlphaMultiplier
      local maxClipDepth = 4
      local maxClipValue = 1048576
      local transparent = Color(0, 0, 0, 0)
      pack = function(...)
        return { n = select("#", ...), ... }
      end
      if typeOf(chamferTuple) ~= "function" or typeOf(drawTexturedQuadUV) ~= "function" then
        error("MGFX Clip requires geometry and chamfer support", 2)
      end
      if typeOf(setupParamMatrix) ~= "function" then
        error("MGFX Clip requires matrix shader parameters", 2)
      end
      traceback = function(message)
        if debug ~= nil and debug.traceback ~= nil then
          return debug.traceback(tostring(message), 2)
        end
        return tostring(message)
      end
      restoreParentScissor = function()
        return frame.restoreScissor()
      end
      acquireRecord = function()
        local index = #recordPool
        local record = recordPool[index]
        if record ~= nil then
          recordPool[index] = nil
          return record
        end
        return {}
      end
      releaseRecord = function(record)
        if record == nil then
          return
        end
        for key in pairs(record) do
          record[key] = nil
        end
        recordPool[#recordPool + 1] = record
      end
      ensureNamespace = function()
        if namespace == nil then
          do
            local __lux_obj_M_5 = M._MaterialState
            local __lux_tmp_shaderVersion_6 = nil
            if __lux_obj_M_5 ~= nil then
              __lux_tmp_shaderVersion_6 = __lux_obj_M_5.shaderVersion
            end
            if __lux_tmp_shaderVersion_6 == nil then
              __lux_tmp_shaderVersion_6 = "dev"
            end
            namespace = tostring(__lux_tmp_shaderVersion_6) .. "_" .. tostring(math.floor(SysTime() * 1000000))
          end
        end
        return namespace
      end
      createTarget = function(name)
        if GetRenderTargetEx == nil or bit == nil or bit.bor == nil then
          error("MGFX Clip requires full-frame render-target support", 3)
        end
        local target = GetRenderTargetEx(
          name,
          -1,
          -1,
          RT_SIZE_FULL_FRAME_BUFFER,
          MATERIAL_RT_DEPTH_NONE,
          bit.bor(2, 256, 4, 8),
          0,
          IMAGE_FORMAT_BGRA8888
        )
        if target == nil then
          error("MGFX Clip failed to allocate a full-frame render target", 3)
        end
        return target
      end
      createSourceMaterial = function(target, role, depth)
        local material = CreateMaterial(
          "mgfx_clip_source_" .. role .. tostring(depth) .. "_" .. ensureNamespace(),
          "UnlitGeneric",
          {
            ["$basetexture"] = target:GetName(),
            ["$translucent"] = "1",
            ["$vertexcolor"] = "1",
            ["$vertexalpha"] = "1",
            ["$ignorez"] = "1",
          }
        )
        if material == nil or material:IsError() then
          error("MGFX Clip failed to create a coverage source material", 3)
        end
        return material
      end
      ensureTargets = function(depth)
        local ns = ensureNamespace()
        if beforeTargets[depth] == nil then
          beforeTargets[depth] = createTarget("mgfxsc_b" .. tostring(depth) .. "_" .. ns)
        end
        if workTargets[depth] == nil then
          local work = createTarget("mgfxsc_w" .. tostring(depth) .. "_" .. ns)
          local sourceMaterial = createSourceMaterial(work, "work", depth)
          workTargets[depth] = work
          sourceMaterials[work] = sourceMaterial
        end
        return beforeTargets[depth], workTargets[depth]
      end
      ensureMaskTarget = function(depth)
        local target = maskTargets[depth]
        if target == nil then
          target = createTarget("mgfxsc_m" .. tostring(depth) .. "_" .. ensureNamespace())
          maskTargets[depth] = target
        end
        return target
      end
      contextTransform = function(depth, x, y)
        local matrix = contextMatrices[depth]
        if matrix == nil then
          matrix = Matrix()
          contextMatrices[depth] = matrix
        end
        local offset = contextOffsets[depth]
        if offset == nil then
          offset = Vector()
          contextOffsets[depth] = offset
        end
        offset:SetUnpacked(x, y, 0)
        matrix:SetTranslation(offset)
        return matrix
      end
      coverageTransform = function(depth, x, y)
        local matrix = coverageMatrices[depth]
        if matrix == nil then
          matrix = Matrix()
          coverageMatrices[depth] = matrix
        end
        local offset = coverageOffsets[depth]
        if offset == nil then
          offset = Vector()
          coverageOffsets[depth] = offset
        end
        offset:SetUnpacked(x, y, 0)
        matrix:SetTranslation(offset)
        return matrix
      end
      setNeutralRenderState = function()
        if surfaceSetAlphaMultiplier ~= nil then
          surfaceSetAlphaMultiplier(1)
        end
        render.SetColorModulation(1, 1, 1)
        render.SetBlend(1)
        return render.OverrideAlphaWriteEnable(true, true)
      end
      appendCleanupError = function(current, label, callback)
        local ok, message = pcall(callback)
        if ok then
          return current
        end
        local detail = label .. ": " .. tostring(message)
        if current ~= nil then
          return current .. "\n" .. detail
        else
          return detail
        end
      end
      finishScope = function(results, cleanupError, level)
        if level == nil then
          level = 3
        end
        if not results[1] then
          local message = tostring(results[2])
          if cleanupError ~= nil then
            message = message .. "\nMGFX Clip cleanup failed: " .. cleanupError
          end
          error(message, level)
        end
        if cleanupError ~= nil then
          error("MGFX Clip cleanup failed: " .. cleanupError, level)
        end
        return unpack(results, 2, results.n)
      end
      withRenderState = function(callback)
        local previousR, previousG, previousB = render.GetColorModulation()
        local previousBlend = render.GetBlend()
        local previousAlphaMultiplier
        if surfaceGetAlphaMultiplier ~= nil then
          previousAlphaMultiplier = surfaceGetAlphaMultiplier()
        else
          previousAlphaMultiplier = 1
        end
        local results = pack(xpcall(callback, traceback))
        local cleanupError = nil
        cleanupError = appendCleanupError(
          cleanupError,
          "blend override",
          function()
            return render.OverrideBlend(false)
          end
        )
        cleanupError = appendCleanupError(
          cleanupError,
          "alpha-write override",
          function()
            return render.OverrideAlphaWriteEnable(false)
          end
        )
        cleanupError = appendCleanupError(
          cleanupError,
          "color modulation",
          function()
            return render.SetColorModulation(previousR, previousG, previousB)
          end
        )
        cleanupError = appendCleanupError(
          cleanupError,
          "blend",
          function()
            return render.SetBlend(previousBlend)
          end
        )
        if surfaceSetAlphaMultiplier ~= nil then
          cleanupError = appendCleanupError(
            cleanupError,
            "surface alpha",
            function()
              return surfaceSetAlphaMultiplier(previousAlphaMultiplier)
            end
          )
        end
        return finishScope(results, cleanupError, 4)
      end
      withRenderTarget2D = function(target, screenW, screenH, callback)
        local targetPushed = false
        local contextStarted = false
        local results = pack(
          xpcall(
            function()
              render.PushRenderTarget(target, 0, 0, screenW, screenH)
              targetPushed = true
              cam.Start2D()
              contextStarted = true
              return callback()
            end,
            traceback
          )
        )
        local cleanupError = nil
        if contextStarted then
          cleanupError = appendCleanupError(cleanupError, "cam.End2D", cam.End2D)
        end
        if targetPushed then
          cleanupError = appendCleanupError(cleanupError, "render.PopRenderTarget", render.PopRenderTarget)
        end
        cleanupError = appendCleanupError(cleanupError, "scissor restore", restoreParentScissor)
        return finishScope(results, cleanupError, 4)
      end
      withModelMatrix = function(matrix, callback)
        local pushed = false
        local results = pack(
          xpcall(
            function()
              cam.PushModelMatrix(matrix)
              pushed = true
              return callback()
            end,
            traceback
          )
        )
        local cleanupError = nil
        if pushed then
          cleanupError = appendCleanupError(cleanupError, "cam.PopModelMatrix", cam.PopModelMatrix)
        end
        return finishScope(results, cleanupError, 4)
      end
      clearCoverageTarget = function(target, rasterW, rasterH, screenW, screenH)
        return withRenderTarget2D(
          target,
          screenW,
          screenH,
          function()
            render.SetScissorRect(0, 0, rasterW, rasterH, true)
            return withRenderState(
              function()
                setNeutralRenderState()
                render.OverrideBlend(
                  true,
                  BLEND_ZERO,
                  BLEND_ZERO,
                  BLENDFUNC_ADD,
                  BLEND_ZERO,
                  BLEND_ZERO,
                  BLENDFUNC_ADD
                )
                surface.SetDrawColor(255, 255, 255, 255)
                return surface.DrawRect(0, 0, rasterW, rasterH)
              end
            )
          end
        )
      end
      drawCoverageSource = function(source, rasterW, rasterH, screenW, screenH)
        local material = sourceMaterials[source]
        if material == nil then
          error("MGFX Clip has no coverage source material for an internal target", 3)
        end
        surface.SetMaterial(material)
        surface.SetDrawColor(255, 255, 255, 255)
        return surface.DrawTexturedRectUV(
          0,
          0,
          rasterW,
          rasterH,
          0,
          0,
          rasterW / screenW,
          rasterH / screenH
        )
      end
      combineCoverage = function(destination, source, sourceAlphaFactor, destinationAlphaFactor, blendFunction, rasterW, rasterH, screenW, screenH)
        return withRenderTarget2D(
          destination,
          screenW,
          screenH,
          function()
            render.SetScissorRect(0, 0, rasterW, rasterH, true)
            return withRenderState(
              function()
                setNeutralRenderState()
                render.OverrideBlend(
                  true,
                  BLEND_ZERO,
                  BLEND_ZERO,
                  BLENDFUNC_ADD,
                  sourceAlphaFactor,
                  destinationAlphaFactor,
                  blendFunction
                )
                return drawCoverageSource(source, rasterW, rasterH, screenW, screenH)
              end
            )
          end
        )
      end
      invertCoverage = function(target, w, h, rasterW, rasterH, screenW, screenH, padLeft, padTop)
        return withRenderTarget2D(
          target,
          screenW,
          screenH,
          function()
            render.SetScissorRect(0, 0, rasterW, rasterH, true)
            return withRenderState(
              function()
                setNeutralRenderState()
                render.OverrideBlend(
                  true,
                  BLEND_ZERO,
                  BLEND_ZERO,
                  BLENDFUNC_ADD,
                  BLEND_ONE_MINUS_DST_ALPHA,
                  BLEND_ZERO,
                  BLENDFUNC_ADD
                )
                surface.SetDrawColor(255, 255, 255, 255)
                return surface.DrawRect(padLeft, padTop, w, h)
              end
            )
          end
        )
      end
      local Recorder = {}
      Recorder.__index = Recorder
      requireActiveRecorder = function(recorder, method)
        if activeRecorder ~= recorder or not recorder.active then
          error(
            "MGFX Mask recorder:" .. method .. " can only be used while its painter is running",
            3
          )
        end
        if recorder.inOperation then
          error("MGFX Mask recorder operations cannot be nested", 3)
        end
      end
      drawOperationCoverage = function(recorder, callback)
        if typeOf(callback) ~= "function" then
          error("MGFX Mask coverage operations require a callback", 3)
        end
        clearCoverageTarget(
          recorder.scratch,
          recorder.rasterW,
          recorder.rasterH,
          recorder.screenW,
          recorder.screenH
        )
        local results = pack(
          xpcall(
            function()
              return withRenderTarget2D(
                recorder.scratch,
                recorder.screenW,
                recorder.screenH,
                function()
                  return withModelMatrix(
                    coverageTransform(recorder.depth, recorder.padLeft, recorder.padTop),
                    function()
                      frameState.coverage = true
                      frameState.coverageDrawing = true
                      frameState.coverageX = 0
                      frameState.coverageY = 0
                      frameState.coverageW = recorder.rasterW
                      frameState.coverageH = recorder.rasterH
                      frameState.coverageOffsetX = recorder.padLeft
                      frameState.coverageOffsetY = recorder.padTop
                      render.SetScissorRect(0, 0, recorder.rasterW, recorder.rasterH, true)
                      return withRenderState(
                        function()
                          setNeutralRenderState()
                          render.OverrideBlend(
                            true,
                            BLEND_ZERO,
                            BLEND_ZERO,
                            BLENDFUNC_ADD,
                            BLEND_ONE,
                            BLEND_ONE,
                            BLENDFUNC_MAX
                          )
                          return callback()
                        end
                      )
                    end
                  )
                end
              )
            end,
            traceback
          )
        )
        frameState.coverageDrawing = false
        frameState.coverage = false
        finishScope(results, nil, 3)
        do
          local __lux_tmp_maskOperations_7 = M.stats.maskOperations
          if __lux_tmp_maskOperations_7 == nil then
            __lux_tmp_maskOperations_7 = 0
          end
          M.stats.maskOperations = __lux_tmp_maskOperations_7 + 1
        end
      end
      function Recorder:_combine(operation, callback)
        requireActiveRecorder(self, operation)
        self.inOperation = true
        local ok, message = xpcall(
          function()
            drawOperationCoverage(self, callback)
            local __lux_match_8 = operation
            if __lux_match_8 == "union" then
              return combineCoverage(
                self.accumulator,
                self.scratch,
                BLEND_ONE,
                BLEND_ONE,
                BLENDFUNC_MAX,
                self.rasterW,
                self.rasterH,
                self.screenW,
                self.screenH
              )
            elseif __lux_match_8 == "subtract" then
              return combineCoverage(
                self.accumulator,
                self.scratch,
                BLEND_ZERO,
                BLEND_ONE_MINUS_SRC_ALPHA,
                BLENDFUNC_ADD,
                self.rasterW,
                self.rasterH,
                self.screenW,
                self.screenH
              )
            elseif __lux_match_8 == "intersect" then
              return combineCoverage(
                self.accumulator,
                self.scratch,
                BLEND_ZERO,
                BLEND_SRC_ALPHA,
                BLENDFUNC_ADD,
                self.rasterW,
                self.rasterH,
                self.screenW,
                self.screenH
              )
            elseif __lux_match_8 == "xor" then
              return combineCoverage(
                self.accumulator,
                self.scratch,
                BLEND_ONE_MINUS_DST_ALPHA,
                BLEND_ONE_MINUS_SRC_ALPHA,
                BLENDFUNC_ADD,
                self.rasterW,
                self.rasterH,
                self.screenW,
                self.screenH
              )
            else
              return error("MGFX Mask encountered an unsupported coverage operation", 2)
            end
          end,
          traceback
        )
        self.inOperation = false
        if not ok then
          error(message, 3)
        end
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
        local ok, message = xpcall(
          function()
            return invertCoverage(
              self.accumulator,
              self.w,
              self.h,
              self.rasterW,
              self.rasterH,
              self.screenW,
              self.screenH,
              self.padLeft,
              self.padTop
            )
          end,
          traceback
        )
        self.inOperation = false
        if not ok then
          error(message, 3)
        end
        do
          local __lux_tmp_maskOperations_9 = M.stats.maskOperations
          if __lux_tmp_maskOperations_9 == nil then
            __lux_tmp_maskOperations_9 = 0
          end
          M.stats.maskOperations = __lux_tmp_maskOperations_9 + 1
        end
        return self
      end
      local MaskMethods = {}
      MaskMethods.__index = MaskMethods
      MaskMethods.__newindex = function()
        return error(
          "MGFX Mask objects are immutable; update captured painter state and call mask:Invalidate()",
          2
        )
      end
      function MaskMethods:Invalidate()
        local state = maskState[self]
        if state == nil then
          error("MGFX received an invalid Mask object", 2)
        end
        if state.type == "preset" then
          error("MGFX preset Masks are immutable", 2)
        end
        state.revision = state.revision + 1
        return self
      end
      function MaskMethods:Clip(x, y, w, h, callback)
        return M.Clip(self, x, y, w, h, callback)
      end
      customMask = function(painter)
        if typeOf(painter) ~= "function" then
          error("MGFX.Mask requires a painter function", 3)
        end
        local mask = setmetatable({}, MaskMethods)
        maskState[mask] = { type = "custom", revision = 1, painter = painter }
        return mask
      end
      presetMask = function(kind, options)
        local mask = setmetatable({}, MaskMethods)
        local values
        if typeOf(options) == "table" then
          values = table.Copy(options)
        else
          values = {}
        end
        if typeOf(options) ~= "table" and options ~= nil then
          values.radius = options
        end
        maskState[mask] = { type = "preset", kind = kind, values = values }
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
      rasterizeCustomMask = function(mask, state, w, h, phaseX, phaseY, depth, accumulator, scratch, screenW, screenH)
        local rasterW = math.min(screenW, math.ceil(w + phaseX) + 2)
        local rasterH = math.min(screenH, math.ceil(h + phaseY) + 2)
        local extraX = math.max(0, rasterW - w - phaseX)
        local extraY = math.max(0, rasterH - h - phaseY)
        local padLeft = math.min(1, extraX * 0.5)
        local padTop = math.min(1, extraY * 0.5)
        local originX = padLeft + phaseX
        local originY = padTop + phaseY
        local padRight = math.min(1, math.max(0, rasterW - originX - w))
        local padBottom = math.min(1, math.max(0, rasterH - originY - h))
        local target = ensureMaskTarget(depth)
        local slot = maskSlots[depth]
        if slot == nil then
          slot = { maskRef = setmetatable({}, { __mode = "v" }) }
          maskSlots[depth] = slot
        end
        local revision = state.revision
        if slot.maskRef[1] == mask and slot.revision == revision and slot.w == w and slot.h == h and slot.phaseX == phaseX and slot.phaseY == phaseY and slot.screenW == screenW and slot.screenH == screenH then
          do
            local __lux_tmp_maskCacheHits_10 = M.stats.maskCacheHits
            if __lux_tmp_maskCacheHits_10 == nil then
              __lux_tmp_maskCacheHits_10 = 0
            end
            M.stats.maskCacheHits = __lux_tmp_maskCacheHits_10 + 1
          end
          return target, originX / screenW, originY / screenH, (originX + w) / screenW, (originY + h) / screenH, originX, originY, padRight, padBottom
        end
        clearCoverageTarget(accumulator, rasterW, rasterH, screenW, screenH)
        local recorder = coverageRecorders[depth]
        if recorder == nil then
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
        recorder.screenW = screenW
        recorder.screenH = screenH
        recorder.accumulator = accumulator
        recorder.scratch = scratch
        recorder.padLeft = originX
        recorder.padTop = originY
        activeRecorder = recorder
        frameState.coverage = true
        frameState.coverageDrawing = false
        local ok, message = xpcall(
          function()
            return state.painter(recorder, w, h)
          end,
          traceback
        )
        frameState.coverageDrawing = false
        frameState.coverage = false
        activeRecorder = nil
        recorder.active = false
        recorder.inOperation = false
        if not ok then
          error(message, 3)
        end
        render.CopyTexture(accumulator, target)
        slot.maskRef[1] = mask
        slot.revision = revision
        slot.w = w
        slot.h = h
        slot.phaseX = phaseX
        slot.phaseY = phaseY
        slot.screenW = screenW
        slot.screenH = screenH
        do
          local __lux_tmp_maskRasterizations_11 = M.stats.maskRasterizations
          if __lux_tmp_maskRasterizations_11 == nil then
            __lux_tmp_maskRasterizations_11 = 0
          end
          M.stats.maskRasterizations = __lux_tmp_maskRasterizations_11 + 1
        end
        return target, originX / screenW, originY / screenH, (originX + w) / screenW, (originY + h) / screenH, originX, originY, padRight, padBottom
      end
      finiteNumber = function(value, label, defaultValue)
        if value == nil and defaultValue ~= nil then
          return defaultValue
        end
        local __lux_tmp_14 = typeOf(value) ~= "number" or value ~= value or value == math.huge or value == -math.huge
        if not __lux_tmp_14 then
          local __lux_cmp_13 = false
          if math.abs(value) ~= nil then
            __lux_cmp_13 = math.abs(value) > maxClipValue
          end
          __lux_tmp_14 = __lux_cmp_13
        end
        if __lux_tmp_14 then
          error("MGFX Clip requires a finite " .. label, 3)
        end
        return value
      end
      relativeValue = function(value, units, w, h)
        local number = finiteNumber(value, "Mask radius", 0)
        if units == nil or units == "local" then
          return math.min(math.max(0, number), math.min(w, h) * 0.5)
        end
        if units == "bounds" then
          return math.min(math.max(0, number) * math.min(w, h), math.min(w, h) * 0.5)
        end
        return error("MGFX Mask uses an unsupported units value: " .. tostring(units), 3)
      end
      relativeCuts = function(cuts, units, w, h)
        local scale
        if units == "bounds" then
          scale = math.min(w, h)
        else
          scale = 1
        end
        local limit = math.min(w, h)
        if units ~= nil and units ~= "local" and units ~= "bounds" then
          error("MGFX Mask uses an unsupported units value: " .. tostring(units), 3)
        end
        if typeOf(cuts) ~= "table" then
          return math.min(math.max(0, finiteNumber(cuts, "Mask cuts", 0) * scale), limit)
        end
        local __lux_tmp_tl_15 = cuts.tl
        if __lux_tmp_tl_15 == nil then
          __lux_tmp_tl_15 = cuts[1]
        end
        local __lux_tmp_tr_16 = cuts.tr
        if __lux_tmp_tr_16 == nil then
          __lux_tmp_tr_16 = cuts[2]
        end
        local __lux_tmp_br_17 = cuts.br
        if __lux_tmp_br_17 == nil then
          __lux_tmp_br_17 = cuts[3]
        end
        local __lux_tmp_bl_18 = cuts.bl
        if __lux_tmp_bl_18 == nil then
          __lux_tmp_bl_18 = cuts[4]
        end
        return {
          tl = math.min(
            math.max(0, finiteNumber(__lux_tmp_tl_15, "Mask top-left cut", 0) * scale),
            limit
          ),
          tr = math.min(
            math.max(0, finiteNumber(__lux_tmp_tr_16, "Mask top-right cut", 0) * scale),
            limit
          ),
          br = math.min(
            math.max(0, finiteNumber(__lux_tmp_br_17, "Mask bottom-right cut", 0) * scale),
            limit
          ),
          bl = math.min(
            math.max(0, finiteNumber(__lux_tmp_bl_18, "Mask bottom-left cut", 0) * scale),
            limit
          ),
        }
      end
      resolveMask = function(mask, w, h, phaseX, phaseY, depth, accumulator, scratch, screenW, screenH)
        if typeOf(mask) ~= "table" then
          error("MGFX.Clip requires an MGFX Mask or preset", 3)
        end
        local state = maskState[mask]
        if state == nil then
          error("MGFX.Clip requires an MGFX Mask or preset", 3)
        end
        if state.type == "custom" then
          local texture, u0, v0, u1, v1, bleedLeft, bleedTop, bleedRight, bleedBottom = rasterizeCustomMask(
            mask,
            state,
            w,
            h,
            phaseX,
            phaseY,
            depth,
            accumulator,
            scratch,
            screenW,
            screenH
          )
          return 10, 0, u0, v0, u1, v1, texture, bleedLeft, bleedTop, bleedRight, bleedBottom
        end
        local values = state.values
        local __lux_match_19 = state.kind
        if __lux_match_19 == "rounded" then
          return 0, relativeValue(values.radius, values.units, w, h), 0, 0, 0, 0, nil, 1, 1, 1, 1
        elseif __lux_match_19 == "chamfer" then
          local p0, p1, p2, p3 = chamferTuple(relativeCuts(values.cuts, values.units, w, h), w, h)
          return 1, 0, p0, p1, p2, p3, nil, 1, 1, 1, 1
        elseif __lux_match_19 == "circle" then
          return 2, 0, 0, 0, 0, 0, nil, 1, 1, 1, 1
        elseif __lux_match_19 == "capsule" then
          return 3, 0, 0, 0, 0, 0, nil, 1, 1, 1, 1
        else
          return error("MGFX.Clip received an unsupported Mask preset", 3)
        end
      end
      cleanupRecord = function(record)
        local cleanupError = nil
        while #frameState.clipStack > record.clipDepth do
          local ok, message = pcall(frame.popClip)
          if not ok then
            cleanupError = message
            break
          end
        end
        if record.targetPushed then
          if record.modelPushed then
            local ok, message = pcall(cam.PopModelMatrix)
            record.modelPushed = false
            if not ok and cleanupError == nil then
              cleanupError = message
            end
          end
          if record.contextStarted then
            local ok, message = pcall(cam.End2D)
            record.contextStarted = false
            if not ok and cleanupError == nil then
              cleanupError = message
            end
          end
          local ok, message = pcall(render.PopRenderTarget)
          record.targetPushed = false
          if not ok and cleanupError == nil then
            cleanupError = message
          end
        end
        local ok, message = pcall(restoreParentScissor)
        if not ok and cleanupError == nil then
          cleanupError = message
        end
        return cleanupError
      end
      throwWithCleanup = function(primary, cleanupError)
        if cleanupError ~= nil then
          error(tostring(primary) .. "\nMGFX Clip cleanup failed: " .. tostring(cleanupError), 2)
        end
        return error(primary, 2)
      end
      composite = function(record)
        local material = materials.shape_clip
        if not shadersActive() or not materialOK(material) then
          error("MGFX Clip requires the shape_clip shader", 3)
        end
        material:SetTexture("$texture3", record.beforeRT)
        material:SetTexture("$texture1", record.workRT)
        if record.maskTexture ~= nil then
          material:SetTexture("$texture2", record.maskTexture)
        end
        setupParamMatrix(
          material,
          record.screenU,
          record.screenV,
          record.screenUW,
          record.screenVH,
          record.w,
          record.h,
          record.kind,
          record.radius,
          record.p0,
          record.p1,
          record.p2,
          record.p3,
          0,
          0,
          0,
          0
        )
        return withRenderState(
          function()
            setNeutralRenderState()
            render.OverrideBlend(
              true,
              BLEND_ONE,
              BLEND_ZERO,
              BLENDFUNC_ADD,
              BLEND_ONE,
              BLEND_ZERO,
              BLENDFUNC_ADD
            )
            surface.SetMaterial(material)
            surface.SetDrawColor(255, 255, 255, 255)
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
          end
        )
      end
      retireRecord = function(depth, record)
        shapeClipStack[depth] = nil
        local wasCommands = record.wasCommands
        releaseRecord(record)
        return frame.resumeCommands(wasCommands)
      end
      pushMaskClip = function(mask, x, y, w, h)
        if activeRecorder ~= nil then
          error("MGFX.Clip cannot be used while recording Mask coverage", 3)
        end
        if not frameState.active then
          error("MGFX.Clip requires an active StartPanel/StartScreen frame", 3)
        end
        if typeOf(mask) ~= "table" or maskState[mask] == nil then
          error("MGFX.Clip requires an MGFX Mask or preset", 3)
        end
        if geometry.hasTransform() then
          error(
            "MGFX.Clip does not support an active MGFX transform; screen-space coverage requires an axis-aligned frame",
            3
          )
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
        if depth > maxClipDepth then
          error("MGFX.Clip exceeds the maximum nesting depth of " .. tostring(maxClipDepth), 3)
        end
        local frameX = finiteNumber(frameState.screenX, "frame screen x", 0)
        local frameY = finiteNumber(frameState.screenY, "frame screen y", 0)
        local before, work = ensureTargets(depth)
        local record = acquireRecord()
        record.wasCommands = frame.suspendCommands()
        record.clipDepth = #frameState.clipStack
        local ok, message = xpcall(
          function()
            local sx = finiteNumber(frameX + x, "screen x")
            local sy = finiteNumber(frameY + y, "screen y")
            local phaseX = sx - math.floor(sx)
            local phaseY = sy - math.floor(sy)
            local kind, radius, p0, p1, p2, p3, maskTexture, bleedLeft, bleedTop, bleedRight, bleedBottom = resolveMask(mask, w, h, phaseX, phaseY, depth, before, work, screenW, screenH)
            record.localX = x
            record.localY = y
            record.w = w
            record.h = h
            record.screenU = sx / screenW
            record.screenV = sy / screenH
            record.screenUW = w / screenW
            record.screenVH = h / screenH
            record.kind = kind
            record.radius = radius
            record.p0 = p0
            record.p1 = p1
            record.p2 = p2
            record.p3 = p3
            record.maskTexture = maskTexture
            record.bleedLeft = bleedLeft
            record.bleedTop = bleedTop
            record.bleedRight = bleedRight
            record.bleedBottom = bleedBottom
            record.beforeRT = before
            record.workRT = work
            render.CopyRenderTargetToTexture(before)
            render.CopyTexture(before, work)
            render.PushRenderTarget(work, 0, 0, screenW, screenH)
            record.targetPushed = true
            cam.Start2D()
            record.contextStarted = true
            cam.PushModelMatrix(contextTransform(depth, frameX, frameY))
            record.modelPushed = true
            restoreParentScissor()
            return frame.pushClip(
              x - bleedLeft,
              y - bleedTop,
              w + bleedLeft + bleedRight,
              h + bleedTop + bleedBottom
            )
          end,
          traceback
        )
        if not ok then
          local cleanupError = cleanupRecord(record)
          local wasCommands = record.wasCommands
          releaseRecord(record)
          frame.resumeCommands(wasCommands)
          throwWithCleanup(message, cleanupError)
        end
        shapeClipStack[depth] = record
        do
          local __lux_tmp_shapeClipCaptures_20 = M.stats.shapeClipCaptures
          if __lux_tmp_shapeClipCaptures_20 == nil then
            __lux_tmp_shapeClipCaptures_20 = 0
          end
          M.stats.shapeClipCaptures = __lux_tmp_shapeClipCaptures_20 + 1
        end
        do
          local __lux_tmp_shapeClipDepthMax_21 = M.stats.shapeClipDepthMax
          if __lux_tmp_shapeClipDepthMax_21 == nil then
            __lux_tmp_shapeClipDepthMax_21 = 0
          end
          M.stats.shapeClipDepthMax = math.max(__lux_tmp_shapeClipDepthMax_21, depth)
        end
      end
      popMaskClip = function()
        local depth = #shapeClipStack
        if depth <= 0 then
          error("MGFX internal Clip scope mismatch", 3)
        end
        local record = shapeClipStack[depth]
        local ok, message = xpcall(
          function()
            if #frameState.clipStack ~= record.clipDepth + 1 then
              error("MGFX Clip contains unbalanced PushClip/PopClip calls", 2)
            end
            frame.popClip()
            cam.PopModelMatrix()
            record.modelPushed = false
            cam.End2D()
            record.contextStarted = false
            render.PopRenderTarget()
            record.targetPushed = false
            restoreParentScissor()
            return composite(record)
          end,
          traceback
        )
        if not ok then
          local cleanupError = cleanupRecord(record)
          retireRecord(depth, record)
          throwWithCleanup(message, cleanupError)
        end
        retireRecord(depth, record)
        do
          local __lux_tmp_shapeClipComposites_22 = M.stats.shapeClipComposites
          if __lux_tmp_shapeClipComposites_22 == nil then
            __lux_tmp_shapeClipComposites_22 = 0
          end
          M.stats.shapeClipComposites = __lux_tmp_shapeClipComposites_22 + 1
        end
      end
      M.Clip = function(mask, x, y, w, h, callback)
        if typeOf(callback) ~= "function" then
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
        if not popOk then
          error(popError, 2)
        end
        return unpack(results, 2, results.n)
      end
      local forbiddenStyleKeys = { "backdrop", "shadow", "outerGlow", "innerGlow" }
      validateCoverageStyle = function(name, drawStyle)
        if typeOf(drawStyle) ~= "table" then
          return
        end
        for index = 1, #forbiddenStyleKeys do
          local key = forbiddenStyleKeys[index]
          if drawStyle[key] ~= nil and drawStyle[key] ~= false then
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
        "RoundedBox",
        "RoundedBoxEx",
        "Circle",
        "CircleEx",
        "Capsule",
        "CapsuleEx",
        "ChamferBox",
        "ChamferBoxEx",
        "Line",
        "LineNoCaps",
        "LineEx",
        "Poly",
        "PolyEx",
        "RegularPoly",
        "RegularPolyEx",
        "Diamond",
        "DiamondEx",
        "Caret",
        "CaretEx",
        "Ring",
        "RingEx",
        "Arc",
        "ArcEx",
        "Sector",
        "SectorEx",
        "Image",
        "ImageUV",
        "ImageEx",
        "Icon",
        "IconEx",
        "Text",
        "TextEx",
        "TextBox",
        "TextBoxEx",
        "ProgressBar",
        "ProgressBarEx",
        "SegmentBar",
        "SegmentBarEx",
      }
      restoreRecorderBlend = function()
        if activeRecorder == nil or not frameState.coverageDrawing then
          return
        end
        setNeutralRenderState()
        return render.OverrideBlend(
          true,
          BLEND_ZERO,
          BLEND_ZERO,
          BLENDFUNC_ADD,
          BLEND_ONE,
          BLEND_ONE,
          BLENDFUNC_MAX
        )
      end
      for index = 1, #drawApiNames do
        local name = drawApiNames[index]
        local original = M[name]
        if typeOf(original) == "function" then
          local styleIndex = styleArgument[name]
          M[name] = function(...)
            if activeRecorder == nil then
              return original(...)
            end
            if not frameState.coverageDrawing then
              error("MGFX drawing commands must be inside m:Draw/Union/Subtract/Intersect/Xor", 2)
            end
            if styleIndex ~= nil then
              validateCoverageStyle(name, select(styleIndex, ...))
            end
            local arguments = pack(...)
            local results = pack(
              xpcall(
                function()
                  return original(unpack(arguments, 1, arguments.n))
                end,
                traceback
              )
            )
            restoreRecorderBlend()
            if not results[1] then
              error(results[2], 2)
            end
            return unpack(results, 2, results.n)
          end
        end
      end
      local rawRoundedBoxBackdrop = M.RoundedBoxBackdrop
      if typeOf(rawRoundedBoxBackdrop) == "function" then
        M.RoundedBoxBackdrop = function(...)
          if activeRecorder ~= nil then
            error("MGFX Mask coverage does not support backdrop drawing", 2)
          end
          return rawRoundedBoxBackdrop(...)
        end
      end
      local rawTextBatchEx = M.TextBatchEx
      if typeOf(rawTextBatchEx) == "function" then
        M.TextBatchEx = function(...)
          if activeRecorder ~= nil then
            error(
              "MGFX Mask coverage does not support TextBatchEx; draw text records explicitly",
              2
            )
          end
          return rawTextBatchEx(...)
        end
      end
      local rawPushClip = M.PushClip
      local rawPopClip = M.PopClip
      M.PushClip = function(...)
        if activeRecorder ~= nil then
          error("MGFX Mask coverage cannot contain nested Clip scopes", 2)
        end
        return rawPushClip(...)
      end
      M.PopClip = function(...)
        if activeRecorder ~= nil then
          error("MGFX Mask coverage cannot contain nested Clip scopes", 2)
        end
        return rawPopClip(...)
      end
      local selfRoundedPreset = presetMask("rounded")
      local selfCirclePreset = M.Masks.Circle
      local selfCapsulePreset = M.Masks.Capsule
      local selfChamferPreset = presetMask("chamfer")
      validateSelfClip = function(children, drawStyle, shapeName)
        if typeOf(children) ~= "function" then
          error("MGFX." .. shapeName .. " children must be a callback", 3)
        end
        if geometry.hasTransform() then
          error(
            "MGFX " .. shapeName .. " self clipping does not support an active MGFX transform",
            3
          )
        end
        if typeOf(drawStyle) == "table" and drawStyle.transform ~= nil and drawStyle.transform ~= false then
          error("MGFX " .. shapeName .. " self clipping does not support a transformed shape", 3)
        end
      end
      splitSelfClipStyle = function(drawStyle, shapeField)
        if typeOf(drawStyle) ~= "table" or drawStyle.stroke == nil or drawStyle.stroke == false then
          return drawStyle
        end
        local background
        do
          local __lux_table_23 = {}
          local __lux_spread_24 = drawStyle
          if __lux_spread_24 ~= nil then
            for __lux_k_25, __lux_v_26 in pairs(__lux_spread_24) do
              __lux_table_23[__lux_k_25] = __lux_v_26
            end
          end
          background = __lux_table_23
        end
        background.stroke = nil
        background.strokeWidth = nil
        local foreground = { fill = transparent, stroke = drawStyle.stroke, strokeWidth = drawStyle.strokeWidth }
        if shapeField ~= nil then
          foreground[shapeField] = drawStyle[shapeField]
        end
        return background, foreground
      end
      checkedSelfClipBounds = function(x, y, w, h)
        x = finiteNumber(x, "self-clip x", 0)
        y = finiteNumber(y, "self-clip y", 0)
        w = finiteNumber(w, "self-clip width")
        h = finiteNumber(h, "self-clip height")
        if w <= 0 or h <= 0 then
          error("MGFX self clipping requires positive width and height", 3)
        end
        local __lux_cmp_29 = false
        if finiteNumber(ScrW(), "screen width") ~= nil then
          __lux_cmp_29 = w > finiteNumber(ScrW(), "screen width")
        end
        local __lux_tmp_31 = __lux_cmp_29
        if not __lux_tmp_31 then
          local __lux_cmp_30 = false
          if finiteNumber(ScrH(), "screen height") ~= nil then
            __lux_cmp_30 = h > finiteNumber(ScrH(), "screen height")
          end
          __lux_tmp_31 = __lux_cmp_30
        end
        if __lux_tmp_31 then
          error("MGFX self-clip bounds cannot exceed the framebuffer dimensions", 3)
        end
        return x, y, w, h
      end
      local drawRoundedBoxEx = M.RoundedBoxEx
      M.RoundedBoxEx = function(x, y, w, h, drawStyle, children)
        if children == nil then
          return drawRoundedBoxEx(x, y, w, h, drawStyle)
        end
        validateSelfClip(children, drawStyle, "RoundedBoxEx")
        x, y, w, h = checkedSelfClipBounds(x, y, w, h)
        local radius
        if typeOf(drawStyle) == "table" then
          radius = drawStyle.radius
          if radius == nil then
            radius = drawStyle.r
            if radius == nil then
              radius = 0
            end
          end
        else
          radius = 0
        end
        if typeOf(radius) == "table" then
          error("MGFX RoundedBoxEx self clipping currently requires a scalar radius", 2)
        end
        radius = finiteNumber(radius, "self-clip radius", 0)
        local values = maskState[selfRoundedPreset].values
        values.radius = radius
        values.units = "local"
        local background, foreground = splitSelfClipStyle(drawStyle)
        if foreground ~= nil then
          foreground.radius = radius
        end
        local results = pack(drawRoundedBoxEx(x, y, w, h, background))
        M.Clip(
          selfRoundedPreset,
          x,
          y,
          w,
          h,
          function()
            return children(x, y, w, h)
          end
        )
        if foreground ~= nil then
          drawRoundedBoxEx(x, y, w, h, foreground)
        end
        return unpack(results, 1, results.n)
      end
      local drawCircleEx = M.CircleEx
      M.CircleEx = function(cx, cy, radius, drawStyle, children)
        if children == nil then
          return drawCircleEx(cx, cy, radius, drawStyle)
        end
        validateSelfClip(children, drawStyle, "CircleEx")
        cx = finiteNumber(cx, "self-clip center x", 0)
        cy = finiteNumber(cy, "self-clip center y", 0)
        radius = finiteNumber(radius, "self-clip radius")
        if radius <= 0 then
          error("MGFX CircleEx self clipping requires a positive radius", 2)
        end
        local size = radius * 2
        local x = cx - radius
        local y = cy - radius
        x, y, size = checkedSelfClipBounds(x, y, size, size)
        local background, foreground = splitSelfClipStyle(drawStyle)
        local results = pack(drawCircleEx(cx, cy, radius, background))
        M.Clip(
          selfCirclePreset,
          x,
          y,
          size,
          size,
          function()
            return children(x, y, size, size)
          end
        )
        if foreground ~= nil then
          drawCircleEx(cx, cy, radius, foreground)
        end
        return unpack(results, 1, results.n)
      end
      local drawCapsuleEx = M.CapsuleEx
      M.CapsuleEx = function(x, y, w, h, drawStyle, children)
        if children == nil then
          return drawCapsuleEx(x, y, w, h, drawStyle)
        end
        validateSelfClip(children, drawStyle, "CapsuleEx")
        x, y, w, h = checkedSelfClipBounds(x, y, w, h)
        local background, foreground = splitSelfClipStyle(drawStyle)
        local results = pack(drawCapsuleEx(x, y, w, h, background))
        M.Clip(
          selfCapsulePreset,
          x,
          y,
          w,
          h,
          function()
            return children(x, y, w, h)
          end
        )
        if foreground ~= nil then
          drawCapsuleEx(x, y, w, h, foreground)
        end
        return unpack(results, 1, results.n)
      end
      local drawChamferBoxEx = M.ChamferBoxEx
      M.ChamferBoxEx = function(x, y, w, h, drawStyle, children)
        if children == nil then
          return drawChamferBoxEx(x, y, w, h, drawStyle)
        end
        validateSelfClip(children, drawStyle, "ChamferBoxEx")
        x, y, w, h = checkedSelfClipBounds(x, y, w, h)
        local cuts
        do
          local __lux_tmp_32
          if typeOf(drawStyle) == "table" then
            __lux_tmp_32 = drawStyle.cuts
            if __lux_tmp_32 == nil then
              __lux_tmp_32 = 0
            end
          else
            __lux_tmp_32 = 0
          end
          cuts = relativeCuts(__lux_tmp_32, "local", w, h)
        end
        local values = maskState[selfChamferPreset].values
        values.cuts = cuts
        values.units = "local"
        local background, foreground = splitSelfClipStyle(drawStyle, "cuts")
        local results = pack(drawChamferBoxEx(x, y, w, h, background))
        M.Clip(
          selfChamferPreset,
          x,
          y,
          w,
          h,
          function()
            return children(x, y, w, h)
          end
        )
        if foreground ~= nil then
          drawChamferBoxEx(x, y, w, h, foreground)
        end
        return unpack(results, 1, results.n)
      end
      M.PushShapeClip = nil
      M.PopShapeClip = nil
      M.WithShapeClip = nil
      M.ShapeClip = nil
      clearRecords = function()
        local cleanupError = nil
        for index = #shapeClipStack, 1, -1 do
          local record = shapeClipStack[index]
          local message = cleanupRecord(record)
          if message ~= nil and cleanupError == nil then
            cleanupError = message
          end
          retireRecord(index, record)
        end
        return cleanupError
      end
      endClipFrame = function(rawEnd, label)
        local unclosed = #shapeClipStack
        if unclosed <= 0 then
          return rawEnd()
        end
        local closeError = nil
        while #shapeClipStack > 0 and closeError == nil do
          local ok, message = pcall(popMaskClip)
          if not ok then
            closeError = message
          end
        end
        if closeError ~= nil then
          local cleanupError = clearRecords()
          if cleanupError ~= nil then
            closeError = tostring(closeError) .. "\nMGFX Clip cleanup failed: " .. tostring(cleanupError)
          end
        end
        rawEnd()
        if closeError ~= nil then
          error(
            "MGFX " .. label .. " recovered an invalid Clip scope: " .. tostring(closeError),
            2
          )
        end
        return error(
          "MGFX " .. label .. " found " .. tostring(unclosed) .. " unclosed Clip scope(s)",
          2
        )
      end
      local rawEndPanel = M.EndPanel
      local rawEndScreen = M.EndScreen
      M.EndPanel = function()
        return endClipFrame(rawEndPanel, "EndPanel")
      end
      M.EndScreen = function()
        return endClipFrame(rawEndScreen, "EndScreen")
      end
      M._internal.clipInstall = {
        version = installVersion,
        clip = M.Clip,
        roundedBoxEx = M.RoundedBoxEx,
        endPanel = M.EndPanel,
      }
      return M
    end
  end

  __lux_exports.install = install

  return __lux_exports
end
