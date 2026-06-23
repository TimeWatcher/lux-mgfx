return function(__lux_import)
  local __lux_exports = {}
  local __lux_module_1 = {}
  do
    local styleImport = __lux_import("lux/mgfx/style#client")
    __lux_module_1.style = styleImport
    do
      local __lux_obj_bit_2 = bit
      local __lux_val_bor_3 = nil
      if __lux_obj_bit_2 ~= nil then
        __lux_val_bor_3 = __lux_obj_bit_2.bor
      end
      __lux_module_1.bitBor = __lux_val_bor_3
    end
    do
      local __lux_obj_cam_4 = cam
      local __lux_val_Start2D_5 = nil
      if __lux_obj_cam_4 ~= nil then
        __lux_val_Start2D_5 = __lux_obj_cam_4.Start2D
      end
      __lux_module_1.camStart2D = __lux_val_Start2D_5
    end
    do
      local __lux_obj_cam_6 = cam
      local __lux_val_End2D_7 = nil
      if __lux_obj_cam_6 ~= nil then
        __lux_val_End2D_7 = __lux_obj_cam_6.End2D
      end
      __lux_module_1.camEnd2D = __lux_val_End2D_7
    end
    __lux_module_1.createMaterial = CreateMaterial
    __lux_module_1.getConVar = GetConVar
    __lux_module_1.getRenderTargetEx = GetRenderTargetEx
    __lux_module_1.makeColor = Color
    __lux_module_1.drawSimpleText = _G.draw.SimpleText
    __lux_module_1.drawDrawText = _G.draw.DrawText
    __lux_module_1.errorNoHaltWithStack = ErrorNoHaltWithStack
    do
      local __lux_obj_mesh_8 = mesh
      local __lux_val_Begin_9 = nil
      if __lux_obj_mesh_8 ~= nil then
        __lux_val_Begin_9 = __lux_obj_mesh_8.Begin
      end
      __lux_module_1.meshBegin = __lux_val_Begin_9
    end
    do
      local __lux_obj_mesh_10 = mesh
      local __lux_val_Color_11 = nil
      if __lux_obj_mesh_10 ~= nil then
        __lux_val_Color_11 = __lux_obj_mesh_10.Color
      end
      __lux_module_1.meshColor = __lux_val_Color_11
    end
    do
      local __lux_obj_mesh_12 = mesh
      local __lux_val_End_13 = nil
      if __lux_obj_mesh_12 ~= nil then
        __lux_val_End_13 = __lux_obj_mesh_12.End
      end
      __lux_module_1.meshEnd = __lux_val_End_13
    end
    do
      local __lux_obj_mesh_14 = mesh
      local __lux_val_Position_15 = nil
      if __lux_obj_mesh_14 ~= nil then
        __lux_val_Position_15 = __lux_obj_mesh_14.Position
      end
      __lux_module_1.meshPosition = __lux_val_Position_15
    end
    do
      local __lux_obj_mesh_16 = mesh
      local __lux_val_TexCoord_17 = nil
      if __lux_obj_mesh_16 ~= nil then
        __lux_val_TexCoord_17 = __lux_obj_mesh_16.TexCoord
      end
      __lux_module_1.meshTexCoord = __lux_val_TexCoord_17
    end
    do
      local __lux_obj_mesh_18 = mesh
      local __lux_val_AdvanceVertex_19 = nil
      if __lux_obj_mesh_18 ~= nil then
        __lux_val_AdvanceVertex_19 = __lux_obj_mesh_18.AdvanceVertex
      end
      __lux_module_1.meshAdvanceVertex = __lux_val_AdvanceVertex_19
    end
    do
      local __lux_obj_render_20 = render
      local __lux_val_Clear_21 = nil
      if __lux_obj_render_20 ~= nil then
        __lux_val_Clear_21 = __lux_obj_render_20.Clear
      end
      __lux_module_1.renderClear = __lux_val_Clear_21
    end
    do
      local __lux_obj_render_22 = render
      local __lux_val_GetBlend_23 = nil
      if __lux_obj_render_22 ~= nil then
        __lux_val_GetBlend_23 = __lux_obj_render_22.GetBlend
      end
      __lux_module_1.renderGetBlend = __lux_val_GetBlend_23
    end
    do
      local __lux_obj_render_24 = render
      local __lux_val_GetColorModulation_25 = nil
      if __lux_obj_render_24 ~= nil then
        __lux_val_GetColorModulation_25 = __lux_obj_render_24.GetColorModulation
      end
      __lux_module_1.renderGetColorModulation = __lux_val_GetColorModulation_25
    end
    do
      local __lux_obj_render_26 = render
      local __lux_val_OverrideAlphaWriteEnable_27 = nil
      if __lux_obj_render_26 ~= nil then
        __lux_val_OverrideAlphaWriteEnable_27 = __lux_obj_render_26.OverrideAlphaWriteEnable
      end
      __lux_module_1.renderOverrideAlphaWriteEnable = __lux_val_OverrideAlphaWriteEnable_27
    end
    do
      local __lux_obj_render_28 = render
      local __lux_val_OverrideBlend_29 = nil
      if __lux_obj_render_28 ~= nil then
        __lux_val_OverrideBlend_29 = __lux_obj_render_28.OverrideBlend
      end
      __lux_module_1.renderOverrideBlend = __lux_val_OverrideBlend_29
    end
    do
      local __lux_obj_render_30 = render
      local __lux_val_PopRenderTarget_31 = nil
      if __lux_obj_render_30 ~= nil then
        __lux_val_PopRenderTarget_31 = __lux_obj_render_30.PopRenderTarget
      end
      __lux_module_1.renderPopRenderTarget = __lux_val_PopRenderTarget_31
    end
    do
      local __lux_obj_render_32 = render
      local __lux_val_PushRenderTarget_33 = nil
      if __lux_obj_render_32 ~= nil then
        __lux_val_PushRenderTarget_33 = __lux_obj_render_32.PushRenderTarget
      end
      __lux_module_1.renderPushRenderTarget = __lux_val_PushRenderTarget_33
    end
    do
      local __lux_obj_render_34 = render
      local __lux_val_SetBlend_35 = nil
      if __lux_obj_render_34 ~= nil then
        __lux_val_SetBlend_35 = __lux_obj_render_34.SetBlend
      end
      __lux_module_1.renderSetBlend = __lux_val_SetBlend_35
    end
    do
      local __lux_obj_render_36 = render
      local __lux_val_SetColorModulation_37 = nil
      if __lux_obj_render_36 ~= nil then
        __lux_val_SetColorModulation_37 = __lux_obj_render_36.SetColorModulation
      end
      __lux_module_1.renderSetColorModulation = __lux_val_SetColorModulation_37
    end
    do
      local __lux_obj_render_38 = render
      local __lux_val_SetMaterial_39 = nil
      if __lux_obj_render_38 ~= nil then
        __lux_val_SetMaterial_39 = __lux_obj_render_38.SetMaterial
      end
      __lux_module_1.renderSetMaterial = __lux_val_SetMaterial_39
    end
    do
      local __lux_obj_render_40 = render
      local __lux_val_SetScissorRect_41 = nil
      if __lux_obj_render_40 ~= nil then
        __lux_val_SetScissorRect_41 = __lux_obj_render_40.SetScissorRect
      end
      __lux_module_1.renderSetScissorRect = __lux_val_SetScissorRect_41
    end
    __lux_module_1.surfaceCreateFont = surface.CreateFont
    do
      local __lux_obj_surface_42 = surface
      local __lux_val_DrawOutlinedRect_43 = nil
      if __lux_obj_surface_42 ~= nil then
        __lux_val_DrawOutlinedRect_43 = __lux_obj_surface_42.DrawOutlinedRect
      end
      __lux_module_1.surfaceDrawOutlinedRect = __lux_val_DrawOutlinedRect_43
    end
    do
      local __lux_obj_surface_44 = surface
      local __lux_val_DrawPoly_45 = nil
      if __lux_obj_surface_44 ~= nil then
        __lux_val_DrawPoly_45 = __lux_obj_surface_44.DrawPoly
      end
      __lux_module_1.surfaceDrawPoly = __lux_val_DrawPoly_45
    end
    __lux_module_1.surfaceDrawRect = surface.DrawRect
    __lux_module_1.surfaceDrawText = surface.DrawText
    do
      local __lux_obj_surface_46 = surface
      local __lux_val_DrawTexturedRect_47 = nil
      if __lux_obj_surface_46 ~= nil then
        __lux_val_DrawTexturedRect_47 = __lux_obj_surface_46.DrawTexturedRect
      end
      __lux_module_1.surfaceDrawTexturedRect = __lux_val_DrawTexturedRect_47
    end
    do
      local __lux_obj_surface_48 = surface
      local __lux_val_GetAlphaMultiplier_49 = nil
      if __lux_obj_surface_48 ~= nil then
        __lux_val_GetAlphaMultiplier_49 = __lux_obj_surface_48.GetAlphaMultiplier
      end
      __lux_module_1.surfaceGetAlphaMultiplier = __lux_val_GetAlphaMultiplier_49
    end
    __lux_module_1.surfaceSetDrawColor = surface.SetDrawColor
    __lux_module_1.surfaceSetFont = surface.SetFont
    __lux_module_1.surfaceSetMaterial = surface.SetMaterial
    __lux_module_1.surfaceSetTextColor = surface.SetTextColor
    __lux_module_1.surfaceSetTextPos = surface.SetTextPos
    do
      local __lux_obj_surface_50 = surface
      local __lux_val_SetAlphaMultiplier_51 = nil
      if __lux_obj_surface_50 ~= nil then
        __lux_val_SetAlphaMultiplier_51 = __lux_obj_surface_50.SetAlphaMultiplier
      end
      __lux_module_1.surfaceSetAlphaMultiplier = __lux_val_SetAlphaMultiplier_51
    end
    __lux_module_1.surfaceGetTextSize = surface.GetTextSize
    __lux_module_1.sysTime = SysTime
    do
      local __lux_obj_util_52 = util
      local __lux_val_CRC_53 = nil
      if __lux_obj_util_52 ~= nil then
        __lux_val_CRC_53 = __lux_obj_util_52.CRC
      end
      __lux_module_1.utilCRC = __lux_val_CRC_53
    end
    __lux_module_1.vectorCtor = Vector
    __lux_module_1.mathAbs = math.abs
    __lux_module_1.mathCeil = math.ceil
    __lux_module_1.mathClamp = math.Clamp
    __lux_module_1.mathCos = math.cos
    __lux_module_1.mathFloor = math.floor
    __lux_module_1.mathMax = math.max
    __lux_module_1.mathMin = math.min
    __lux_module_1.mathSin = math.sin
    __lux_module_1.stringExplode = string.Explode
    __lux_module_1.stringFind = string.find
    __lux_module_1.stringGmatch = string.gmatch
    __lux_module_1.stringSub = string.sub
    __lux_module_1.tableConcat = table.concat
    __lux_module_1.tableCopy = table.Copy
    __lux_module_1.tableCount = table.Count
    __lux_module_1.protectedCall = pcall
    __lux_module_1.toNumber = tonumber
    __lux_module_1.toString = tostring
    __lux_module_1.typeOf = type
    __lux_module_1.styles = {}
    __lux_module_1.fonts = {}
    __lux_module_1.nativeFonts = {}
    __lux_module_1.measureCache = {}
    __lux_module_1.measureOrder = {}
    __lux_module_1.measureOrderHead = 1
    __lux_module_1.measureOrderTail = 0
    __lux_module_1.measureOrderCount = 0
    __lux_module_1.composedCache = {}
    __lux_module_1.composedCacheCount = 0
    __lux_module_1.composedTick = 0
    __lux_module_1.atlasPages = {}
    __lux_module_1.atlas = nil
    __lux_module_1.atlasMat = nil
    __lux_module_1.atlasEpoch = 1
    __lux_module_1.atlasFailed = false
    __lux_module_1.atlasNeedsReset = false
    __lux_module_1.debugViewMat = nil
    __lux_module_1.bakesThisFrame = 0
    __lux_module_1.composedCvar = nil
    __lux_module_1.budgetCvar = nil
    __lux_module_1.materials = {}
    __lux_module_1.createPageTextMaterials = nil
    __lux_module_1.profiler = nil
    __lux_module_1.restoreScissor = function()
    end
    __lux_module_1.gradientLutForFill = function()
      return nil
    end
    __lux_module_1.materialOK = function(material)
      return material ~= nil and material.IsError ~= nil and not material:IsError()
    end
    __lux_module_1.defaultTextRenderer = nil
    __lux_module_1.MEASURE_LIMIT = 4096
    __lux_module_1.ATLAS_W = 2048
    __lux_module_1.ATLAS_H = 1024
    __lux_module_1.MAX_ATLAS_PAGES = 16
    __lux_module_1.SOFT_ATLAS_PAGES = 14
    __lux_module_1.ATLAS_PAD = 4
    __lux_module_1.CACHE_VERSION = 21
    __lux_module_1.DEFAULT_BUDGET = 6
    __lux_module_1.DEFAULT_CJK_FACE = "Noto Sans SC"
    __lux_module_1.RESOLVED_STYLE_MARK = "__mgfxTextResolved"
    do
      local __lux_tmp_color_white_54 = color_white
      if __lux_tmp_color_white_54 == nil then
        __lux_tmp_color_white_54 = __lux_module_1.makeColor(255, 255, 255, 255)
      end
      __lux_module_1.white = __lux_tmp_color_white_54
    end
    do
      local __lux_tmp_55
      if __lux_module_1.vectorCtor ~= nil then
        __lux_tmp_55 = __lux_module_1.vectorCtor()
      else
        __lux_tmp_55 = nil
      end
      __lux_module_1.textBatchVertex = __lux_tmp_55
    end
    __lux_module_1.atlasQuad = {
      { x = 0, y = 0, u = 0, v = 0 },
      { x = 0, y = 0, u = 1, v = 0 },
      { x = 0, y = 0, u = 1, v = 1 },
      { x = 0, y = 0, u = 0, v = 1 },
    }
    __lux_module_1.profile = { active = false, draws = 0, measures = 0, times = {}, counts = {} }
    __lux_module_1.textComposerCapable = function()
      return __lux_module_1.renderClear ~= nil and __lux_module_1.renderPushRenderTarget ~= nil and __lux_module_1.renderPopRenderTarget ~= nil and __lux_module_1.camStart2D ~= nil and __lux_module_1.camEnd2D ~= nil
    end
    __lux_module_1.configureTextRenderer = function(deps)
      if deps == nil then
        deps = {}
      end
      do
        local __lux_tmp_materials_56 = deps.materials
        if __lux_tmp_materials_56 == nil then
          __lux_tmp_materials_56 = deps.Materials
        end
        if __lux_tmp_materials_56 == nil then
          __lux_tmp_materials_56 = __lux_module_1.materials
        end
        if __lux_tmp_materials_56 == nil then
          __lux_tmp_materials_56 = {}
        end
        __lux_module_1.materials = __lux_tmp_materials_56
      end
      do
        local __lux_tmp_createPageTextMaterials_57 = deps.createPageTextMaterials
        if __lux_tmp_createPageTextMaterials_57 == nil then
          __lux_tmp_createPageTextMaterials_57 = deps.CreatePageTextMaterials
        end
        if __lux_tmp_createPageTextMaterials_57 == nil then
          __lux_tmp_createPageTextMaterials_57 = __lux_module_1.createPageTextMaterials
        end
        __lux_module_1.createPageTextMaterials = __lux_tmp_createPageTextMaterials_57
      end
      do
        local __lux_tmp_profiler_58 = deps.profiler
        if __lux_tmp_profiler_58 == nil then
          __lux_tmp_profiler_58 = deps.Profiler
        end
        if __lux_tmp_profiler_58 == nil then
          __lux_tmp_profiler_58 = __lux_module_1.profiler
        end
        __lux_module_1.profiler = __lux_tmp_profiler_58
      end
      do
        local __lux_tmp_restoreScissor_59 = deps.restoreScissor
        if __lux_tmp_restoreScissor_59 == nil then
          __lux_tmp_restoreScissor_59 = deps.RestoreScissor
        end
        if __lux_tmp_restoreScissor_59 == nil then
          __lux_tmp_restoreScissor_59 = __lux_module_1.restoreScissor
        end
        if __lux_tmp_restoreScissor_59 == nil then
          __lux_tmp_restoreScissor_59 = function()
        end
        end
        __lux_module_1.restoreScissor = __lux_tmp_restoreScissor_59
      end
      do
        local __lux_tmp_gradientLutForFill_60 = deps.gradientLutForFill
        if __lux_tmp_gradientLutForFill_60 == nil then
          __lux_tmp_gradientLutForFill_60 = deps.GradientLutForFill
        end
        if __lux_tmp_gradientLutForFill_60 == nil then
          __lux_tmp_gradientLutForFill_60 = __lux_module_1.gradientLutForFill
        end
        if __lux_tmp_gradientLutForFill_60 == nil then
          __lux_tmp_gradientLutForFill_60 = function()
          return nil
        end
        end
        __lux_module_1.gradientLutForFill = __lux_tmp_gradientLutForFill_60
      end
      do
        local __lux_tmp_matOK_61 = deps.matOK
        if __lux_tmp_matOK_61 == nil then
          __lux_tmp_matOK_61 = deps.MaterialOK
        end
        if __lux_tmp_matOK_61 == nil then
          __lux_tmp_matOK_61 = __lux_module_1.materialOK
        end
        __lux_module_1.materialOK = __lux_tmp_matOK_61
      end
      return true
    end
    __lux_module_1.sharedTextRenderer = function()
      if __lux_module_1.defaultTextRenderer ~= nil then
        return __lux_module_1.defaultTextRenderer
      end
      local factory
      do
        local __lux_obj_MGFX_62 = _G.MGFX
        local __lux_val_CreateTextRenderer_63 = nil
        if __lux_obj_MGFX_62 ~= nil then
          __lux_val_CreateTextRenderer_63 = __lux_obj_MGFX_62._CreateTextRenderer
        end
        factory = __lux_val_CreateTextRenderer_63
      end
      if factory ~= nil then
        __lux_module_1.defaultTextRenderer = factory(
          {
            materials = __lux_module_1.materials,
            createPageTextMaterials = __lux_module_1.createPageTextMaterials,
            matOK = __lux_module_1.materialOK,
            profiler = __lux_module_1.profiler,
            restoreScissor = __lux_module_1.restoreScissor,
            gradientLutForFill = __lux_module_1.gradientLutForFill,
          }
        )
      end
      return __lux_module_1.defaultTextRenderer
    end
    __lux_module_1.isMaterialOK = function(material)
      return __lux_module_1.materialOK ~= nil and __lux_module_1.materialOK(material)
    end
    __lux_module_1.textChars = function(text)
      local out = {}
      local value
      do
        local __lux_tmp_text_64 = text
        if __lux_tmp_text_64 == nil then
          __lux_tmp_text_64 = ""
        end
        value = __lux_module_1.toString(__lux_tmp_text_64)
      end
      local matcher = __lux_module_1.stringGmatch
      if matcher == nil then
        for index = 1, #value do
          out[#out + 1] = __lux_module_1.stringSub(value, index, index)
        end
        return out
      end
      for ch in matcher(value, "[%z1-127194-244][128-191]*") do
        out[#out + 1] = ch
      end
      if #out == 0 and value ~= "" then
        for index = 1, #value do
          out[#out + 1] = __lux_module_1.stringSub(value, index, index)
        end
      end
      return out
    end
  end
  do
    __lux_module_1.clearTable = function(t)
      do
        local __lux_tmp_t_65 = t
        if __lux_tmp_t_65 == nil then
          __lux_tmp_t_65 = {}
        end
        for key, _ in pairs(__lux_tmp_t_65) do
          t[key] = nil
        end
      end
      return t
    end
    __lux_module_1.copyValue = function(value)
      if __lux_module_1.typeOf(value) ~= "table" then
        return value
      end
      local out = {}
      for key, item in pairs(value) do
        out[key] = __lux_module_1.copyValue(item)
      end
      return out
    end
    __lux_module_1.copyRawStyleInto = function(out, input)
      if __lux_module_1.typeOf(input) ~= "table" then
        return out
      end
      for key, value in pairs(input) do
        if key ~= "extends" and key ~= "base" and not (__lux_module_1.typeOf(key) == "string" and __lux_module_1.stringSub(key, 1, 6) == "__mgfx") then
          out[key] = __lux_module_1.copyValue(value)
        end
      end
      return out
    end
    __lux_module_1.normalizeFontWeight = function(value, fallback)
      if fallback == nil then
        fallback = 500
      end
      local weight = __lux_module_1.toNumber(value)
      if weight == nil then
        local __lux_tmp_fallback_66 = fallback
        if __lux_tmp_fallback_66 == nil then
          __lux_tmp_fallback_66 = 500
        end
        return __lux_tmp_fallback_66
      end
      if weight > 0 and weight <= 10 then
        do
          local __lux_tmp_67
          if weight <= 1 then
            __lux_tmp_67 = 850
          else
            __lux_tmp_67 = weight * 100
          end
          weight = __lux_tmp_67
        end
      end
      return __lux_module_1.mathClamp(__lux_module_1.mathFloor(weight + 0.5), 100, 1000)
    end
    __lux_module_1.normalizeOversample = function(value)
      local nextValue = __lux_module_1.toNumber(value)
      if nextValue == nil then
        nextValue = 1
      end
      return __lux_module_1.mathClamp(nextValue, 1, 4)
    end
    __lux_module_1.oversampleForSize = function(size)
      local nextSize = __lux_module_1.toNumber(size)
      if nextSize == nil then
        nextSize = 16
      end
      if nextSize >= 28 then
        return 3
      end
      return 2
    end
    __lux_module_1.fontKey = function(face, size, weight, italic)
      local __lux_tmp_face_68 = face
      if __lux_tmp_face_68 == nil then
        __lux_tmp_face_68 = ""
      end
      local __lux_tmp_size_69 = size
      if __lux_tmp_size_69 == nil then
        __lux_tmp_size_69 = ""
      end
      local __lux_tmp_weight_70 = weight
      if __lux_tmp_weight_70 == nil then
        __lux_tmp_weight_70 = ""
      end
      local __lux_tmp_71
      if italic == true then
        __lux_tmp_71 = "i"
      else
        __lux_tmp_71 = "n"
      end
      return __lux_module_1.tableConcat(
        {
          __lux_module_1.toString(__lux_tmp_face_68),
          __lux_module_1.toString(__lux_tmp_size_69),
          __lux_module_1.toString(__lux_tmp_weight_70),
          __lux_tmp_71,
        },
        "31"
      )
    end
    __lux_module_1.ensureNativeFont = function(face, size, weight, italic)
      if italic == nil then
        italic = false
      end
      local key = __lux_module_1.fontKey(face, size, weight, italic)
      local existing = __lux_module_1.nativeFonts[key]
      if existing ~= nil then
        return existing
      end
      local suffix
      if __lux_module_1.utilCRC ~= nil then
        suffix = __lux_module_1.utilCRC(key)
      else
        suffix = __lux_module_1.toString(__lux_module_1.tableCount(__lux_module_1.nativeFonts) + 1)
      end
      local name = "MGFXTextNative_" .. suffix
      __lux_module_1.nativeFonts[key] = name
      if __lux_module_1.surfaceCreateFont ~= nil then
        do
          local __lux_tmp_face_72 = face
          if __lux_tmp_face_72 == nil then
            __lux_tmp_face_72 = "DermaDefault"
          end
          local __lux_tmp_size_73 = size
          if __lux_tmp_size_73 == nil then
            __lux_tmp_size_73 = 16
          end
          __lux_module_1.surfaceCreateFont(
            name,
            {
              font = __lux_tmp_face_72,
              size = __lux_module_1.mathFloor(__lux_tmp_size_73),
              weight = __lux_module_1.normalizeFontWeight(weight, 500),
              antialias = true,
              extended = true,
              italic = italic == true,
            }
          )
        end
      end
      return name
    end
    __lux_module_1.registerFont = function(fontName, spec)
      if fontName == nil then
        return false
      end
      local name = __lux_module_1.toString(fontName)
      local input = spec
      if input == nil then
        input = {}
      end
      local face = input.face
      if face == nil then
        face = input.font
      end
      local size = __lux_module_1.toNumber(input.size)
      local weight = __lux_module_1.toNumber(input.weight)
      local sourceFont = input.sourceFont
      if sourceFont == nil then
        sourceFont = input.nativeFont
      end
      local oversample = 1
      if face ~= nil then
        if size == nil then
          size = 16
        end
        do
          local __lux_tmp_oversample_74 = input.oversample
          if __lux_tmp_oversample_74 == nil then
            __lux_tmp_oversample_74 = __lux_module_1.oversampleForSize(size)
          end
          oversample = __lux_module_1.normalizeOversample(__lux_tmp_oversample_74)
        end
        do
          local __lux_tmp_75
          if face == __lux_module_1.DEFAULT_CJK_FACE then
            __lux_tmp_75 = 400
          else
            __lux_tmp_75 = 500
          end
          weight = __lux_module_1.normalizeFontWeight(weight, __lux_tmp_75)
        end
        sourceFont = __lux_module_1.ensureNativeFont(face, size * oversample, weight, input.italic == true)
      else
        if sourceFont == nil then
          sourceFont = name
        end
      end
      do
        local __lux_tmp_76
        if face ~= nil then
          __lux_tmp_76 = "alias"
        else
          __lux_tmp_76 = "native"
        end
        local __lux_tmp_lineHeight_77 = input.lineHeight
        if __lux_tmp_lineHeight_77 == nil then
          __lux_tmp_lineHeight_77 = input.lineheight
        end
        local __lux_tmp_tracking_78 = input.tracking
        if __lux_tmp_tracking_78 == nil then
          __lux_tmp_tracking_78 = input.letterSpacing
        end
        local __lux_tmp_tracking_79 = __lux_module_1.toNumber(__lux_tmp_tracking_78)
        if __lux_tmp_tracking_79 == nil then
          __lux_tmp_tracking_79 = 0
        end
        local __lux_tmp_80
        if face ~= nil then
          __lux_tmp_80 = "__composed"
        else
          __lux_tmp_80 = "__native"
        end
        __lux_module_1.fonts[name] = {
          mode = __lux_tmp_76,
          sourceFont = sourceFont,
          face = face,
          size = size,
          weight = weight,
          oversample = oversample,
          syntheticWeight = input.syntheticWeight == true or input.allowSyntheticWeight == true,
          lineHeight = __lux_module_1.toNumber(__lux_tmp_lineHeight_77),
          tracking = __lux_tmp_tracking_79,
          atlas = __lux_tmp_80,
        }
      end
      return true
    end
    __lux_module_1.aliasFor = function(font)
      local key
      do
        local __lux_tmp_font_81 = font
        if __lux_tmp_font_81 == nil then
          __lux_tmp_font_81 = ""
        end
        key = __lux_module_1.toString(__lux_tmp_font_81)
      end
      local alias = __lux_module_1.fonts[key]
      if alias ~= nil then
        return alias
      end
      local __lux_tmp_font_82 = font
      if __lux_tmp_font_82 == nil then
        __lux_tmp_font_82 = "DermaDefault"
      end
      return {
        mode = "native",
        sourceFont = __lux_tmp_font_82,
        oversample = 1,
        tracking = 0,
        atlas = "__native",
      }
    end
    __lux_module_1.nativeFor = function(font, textStyle, noOversample, plainFace)
      if noOversample == nil then
        noOversample = false
      end
      if plainFace == nil then
        plainFace = false
      end
      local alias = __lux_module_1.aliasFor(font)
      local oversample
      do
        local __lux_tmp_87 = noOversample
        if not __lux_tmp_87 then
          local __lux_obj_textStyle_85 = textStyle
          local __lux_val_mgfxNoOversample_86 = nil
          if __lux_obj_textStyle_85 ~= nil then
            __lux_val_mgfxNoOversample_86 = __lux_obj_textStyle_85.__mgfxNoOversample
          end
          __lux_tmp_87 = __lux_val_mgfxNoOversample_86
        end
        if __lux_tmp_87 then
          oversample = 1
        else
          oversample = __lux_module_1.normalizeOversample(alias.oversample)
        end
      end
      if alias.face ~= nil then
        local weight = alias.weight
        if weight == nil then
          weight = 500
        end
        local __lux_obj_textStyle_88 = textStyle
        local __lux_val_syntheticNativeWeight_89 = nil
        if __lux_obj_textStyle_88 ~= nil then
          __lux_val_syntheticNativeWeight_89 = __lux_obj_textStyle_88.syntheticNativeWeight
        end
        if __lux_val_syntheticNativeWeight_89 == true then
          local __lux_tmp_94 = plainFace ~= true
          if __lux_tmp_94 then
            local __lux_obj_textStyle_92 = textStyle
            local __lux_val_bold_93 = nil
            if __lux_obj_textStyle_92 ~= nil then
              __lux_val_bold_93 = __lux_obj_textStyle_92.bold
            end
            __lux_tmp_94 = __lux_val_bold_93 == true
          end
          if __lux_tmp_94 then
            weight = weight + 220
          end
          local __lux_tmp_99 = plainFace ~= true
          if __lux_tmp_99 then
            local __lux_obj_textStyle_97 = textStyle
            local __lux_val_thin_98 = nil
            if __lux_obj_textStyle_97 ~= nil then
              __lux_val_thin_98 = __lux_obj_textStyle_97.thin
            end
            __lux_tmp_99 = __lux_val_thin_98 == true
          end
          if __lux_tmp_99 then
            weight = __lux_module_1.mathMin(weight, 350)
          end
          local __lux_obj_textStyle_100 = textStyle
          local __lux_val_weight_101 = nil
          if __lux_obj_textStyle_100 ~= nil then
            __lux_val_weight_101 = __lux_obj_textStyle_100.weight
          end
          if __lux_module_1.toNumber(__lux_val_weight_101) ~= nil then
            weight = __lux_module_1.normalizeFontWeight(textStyle.weight, weight)
          end
        end
        local __lux_tmp_size_102 = alias.size
        if __lux_tmp_size_102 == nil then
          __lux_tmp_size_102 = 16
        end
        local __lux_obj_textStyle_103 = textStyle
        local __lux_val_italic_104 = nil
        if __lux_obj_textStyle_103 ~= nil then
          __lux_val_italic_104 = __lux_obj_textStyle_103.italic
        end
        return __lux_module_1.ensureNativeFont(
          alias.face,
          __lux_tmp_size_102 * oversample,
          weight,
          __lux_val_italic_104 == true
        ), alias, oversample
      end
      local __lux_tmp_sourceFont_105 = alias.sourceFont
      if __lux_tmp_sourceFont_105 == nil then
        __lux_tmp_sourceFont_105 = font
      end
      if __lux_tmp_sourceFont_105 == nil then
        __lux_tmp_sourceFont_105 = "DermaDefault"
      end
      return __lux_tmp_sourceFont_105, alias, 1
    end
    __lux_module_1.copyStyleInto = function(out, input)
      local resolved = __lux_module_1.resolveStyle(input)
      for key, value in pairs(resolved) do
        out[key] = __lux_module_1.copyValue(value)
      end
      return out
    end
    __lux_module_1.defineStyle = function(name, textStyle)
      if name == nil then
        return nil
      end
      do
        local __lux_tmp_textStyle_106 = textStyle
        if __lux_tmp_textStyle_106 == nil then
          __lux_tmp_textStyle_106 = {}
        end
        __lux_module_1.styles[__lux_module_1.toString(name)] = __lux_module_1.resolveStyle(__lux_tmp_textStyle_106)
      end
      return __lux_module_1.styles[__lux_module_1.toString(name)]
    end
    __lux_module_1.getStyle = function(name)
      local __lux_tmp_name_107 = name
      if __lux_tmp_name_107 == nil then
        __lux_tmp_name_107 = ""
      end
      return __lux_module_1.styles[__lux_module_1.toString(__lux_tmp_name_107)]
    end
    __lux_module_1.resolveStyle = function(textStyle)
      if __lux_module_1.typeOf(textStyle) == "string" then
        local __lux_tmp_textStyle_108 = __lux_module_1.styles[__lux_module_1.toString(textStyle)]
        if __lux_tmp_textStyle_108 == nil then
          __lux_tmp_textStyle_108 = {}
        end
        return __lux_module_1.copyValue(__lux_tmp_textStyle_108)
      end
      if __lux_module_1.typeOf(textStyle) ~= "table" then
        return {}
      end
      if textStyle[__lux_module_1.RESOLVED_STYLE_MARK] == true then
        return __lux_module_1.copyValue(textStyle)
      end
      local out = {}
      local base = textStyle.extends
      if base == nil then
        base = textStyle.base
      end
      if base ~= nil then
        if __lux_module_1.typeOf(base) == "table" and base[1] ~= nil and not __lux_module_1.style.isColor(base) then
          for _, item in ipairs(base) do
            __lux_module_1.copyRawStyleInto(out, __lux_module_1.resolveStyle(item))
          end
        else
          __lux_module_1.copyRawStyleInto(out, __lux_module_1.resolveStyle(base))
        end
      end
      __lux_module_1.copyRawStyleInto(out, textStyle)
      out[__lux_module_1.RESOLVED_STYLE_MARK] = true
      return out
    end
  end
  do
    __lux_module_1.compactMeasureOrder = function()
      if __lux_module_1.measureOrderHead <= 128 then
        return
      end
      local write = 1
      for read = __lux_module_1.measureOrderHead, __lux_module_1.measureOrderTail do
        __lux_module_1.measureOrder[write] = __lux_module_1.measureOrder[read]
        if write ~= read then
          __lux_module_1.measureOrder[read] = nil
        end
        write = write + 1
      end
      for index = write, __lux_module_1.measureOrderTail do
        __lux_module_1.measureOrder[index] = nil
      end
      __lux_module_1.measureOrderHead = 1
      __lux_module_1.measureOrderTail = __lux_module_1.measureOrderCount
    end
    __lux_module_1.cacheMeasure = function(key, value)
      __lux_module_1.measureCache[key] = value
      __lux_module_1.measureOrderTail = __lux_module_1.measureOrderTail + 1
      __lux_module_1.measureOrder[__lux_module_1.measureOrderTail] = key
      __lux_module_1.measureOrderCount = __lux_module_1.measureOrderCount + 1
      while __lux_module_1.measureOrderCount > __lux_module_1.MEASURE_LIMIT do
        local oldKey = __lux_module_1.measureOrder[__lux_module_1.measureOrderHead]
        __lux_module_1.measureOrder[__lux_module_1.measureOrderHead] = nil
        __lux_module_1.measureOrderHead = __lux_module_1.measureOrderHead + 1
        __lux_module_1.measureOrderCount = __lux_module_1.measureOrderCount - 1
        if oldKey ~= nil then
          __lux_module_1.measureCache[oldKey] = nil
        end
      end
      return __lux_module_1.compactMeasureOrder()
    end
    __lux_module_1.setFontSafe = function(font)
      if __lux_module_1.surfaceSetFont ~= nil then
        local target = font
        if target == nil then
          target = "DermaDefault"
        end
        if __lux_module_1.protectedCall == nil or __lux_module_1.protectedCall(__lux_module_1.surfaceSetFont, target) then
          return target
        end
        __lux_module_1.surfaceSetFont("DermaDefault")
      end
      return "DermaDefault"
    end
    __lux_module_1.lineHeightFor = function(nativeFont, alias, textStyle, oversample)
      if oversample == nil then
        oversample = 1
      end
      local declared
      do
        local __lux_obj_textStyle_109 = textStyle
        local __lux_val_lineHeight_110 = nil
        if __lux_obj_textStyle_109 ~= nil then
          __lux_val_lineHeight_110 = __lux_obj_textStyle_109.lineHeight
        end
        local __lux_tmp_lineHeight_111 = __lux_val_lineHeight_110
        if __lux_tmp_lineHeight_111 == nil then
          local __lux_obj_textStyle_112 = textStyle
          local __lux_val_lineheight_113 = nil
          if __lux_obj_textStyle_112 ~= nil then
            __lux_val_lineheight_113 = __lux_obj_textStyle_112.lineheight
          end
          __lux_tmp_lineHeight_111 = __lux_val_lineheight_113
        end
        if __lux_tmp_lineHeight_111 == nil then
          local __lux_obj_alias_114 = alias
          local __lux_val_lineHeight_115 = nil
          if __lux_obj_alias_114 ~= nil then
            __lux_val_lineHeight_115 = __lux_obj_alias_114.lineHeight
          end
          __lux_tmp_lineHeight_111 = __lux_val_lineHeight_115
        end
        declared = __lux_module_1.toNumber(__lux_tmp_lineHeight_111)
      end
      if declared ~= nil then
        return declared
      end
      __lux_module_1.setFontSafe(nativeFont)
      local _, h = __lux_module_1.surfaceGetTextSize("Mg")
      local __lux_tmp_h_116 = h
      if __lux_tmp_h_116 == nil then
        __lux_tmp_h_116 = 16
      end
      return __lux_module_1.mathMax(
        1,
        __lux_tmp_h_116 / __lux_module_1.normalizeOversample(oversample)
      )
    end
    __lux_module_1.measureLine = function(nativeFont, text, tracking, oversample)
      if tracking == nil then
        tracking = 0
      end
      if oversample == nil then
        oversample = 1
      end
      __lux_module_1.setFontSafe(nativeFont)
      local raw
      do
        local __lux_tmp_text_117 = text
        if __lux_tmp_text_117 == nil then
          __lux_tmp_text_117 = ""
        end
        raw = __lux_module_1.toString(__lux_tmp_text_117)
      end
      local w, h = __lux_module_1.surfaceGetTextSize(raw)
      local extra = __lux_module_1.toNumber(tracking)
      if extra == nil then
        extra = 0
      end
      if extra ~= 0 and #raw > 1 then
        local chars = __lux_module_1.textChars(raw)
        if #chars > 1 then
          w = w + (#chars - 1) * extra * __lux_module_1.normalizeOversample(oversample)
        end
      end
      return w / __lux_module_1.normalizeOversample(oversample)
    end
    __lux_module_1.layoutFor = function(value, font, textStyle, noOversample, plainFace)
      if font == nil then
        font = "DermaDefault"
      end
      if noOversample == nil then
        noOversample = false
      end
      if plainFace == nil then
        plainFace = false
      end
      local resolved
      do
        local __lux_tmp_textStyle_118 = textStyle
        if __lux_tmp_textStyle_118 == nil then
          __lux_tmp_textStyle_118 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_textStyle_118)
      end
      local nativeFont, alias, oversample = __lux_module_1.nativeFor(font, resolved, noOversample, plainFace)
      local tracking
      do
        local __lux_tmp_tracking_119 = resolved.tracking
        if __lux_tmp_tracking_119 == nil then
          __lux_tmp_tracking_119 = resolved.letterSpacing
        end
        tracking = __lux_module_1.toNumber(__lux_tmp_tracking_119)
        if tracking == nil then
          tracking = alias.tracking
          if tracking == nil then
            tracking = 0
          end
        end
      end
      local lineHeight = __lux_module_1.lineHeightFor(nativeFont, alias, resolved, oversample)
      local lines
      do
        local __lux_tmp_value_120 = value
        if __lux_tmp_value_120 == nil then
          __lux_tmp_value_120 = ""
        end
        lines = __lux_module_1.stringExplode("\n", __lux_module_1.toString(__lux_tmp_value_120), false)
      end
      local maxW = 0
      for index = 1, #lines do
        local text = lines[index]
        local w = __lux_module_1.measureLine(nativeFont, text, tracking, oversample)
        lines[index] = { text = text, w = w, y = (index - 1) * lineHeight }
        maxW = __lux_module_1.mathMax(maxW, w)
      end
      return {
        font = nativeFont,
        alias = alias,
        lines = lines,
        w = maxW,
        h = __lux_module_1.mathMax(lineHeight, #lines * lineHeight),
        lineHeight = lineHeight,
        tracking = tracking,
        oversample = oversample,
      }
    end
    __lux_module_1.measure = function(value, font)
      if font == nil then
        font = "DermaDefault"
      end
      local nativeFont, alias, oversample = __lux_module_1.nativeFor(font)
      local tracking = alias.tracking
      if tracking == nil then
        tracking = 0
      end
      local key
      do
        local __lux_tmp_font_121 = font
        if __lux_tmp_font_121 == nil then
          __lux_tmp_font_121 = ""
        end
        local __lux_tmp_value_122 = value
        if __lux_tmp_value_122 == nil then
          __lux_tmp_value_122 = ""
        end
        key = __lux_module_1.tableConcat(
          {
            __lux_module_1.toString(__lux_tmp_font_121),
            nativeFont,
            __lux_module_1.toString(tracking),
            __lux_module_1.toString(oversample),
            __lux_module_1.toString(__lux_tmp_value_122),
          },
          "31"
        )
      end
      local cached = __lux_module_1.measureCache[key]
      if cached ~= nil then
        __lux_module_1.profile.measures = __lux_module_1.profile.measures + 1
        return cached.w, cached.h
      end
      local layout = __lux_module_1.layoutFor(value, font)
      local out = { w = layout.w, h = layout.h }
      __lux_module_1.cacheMeasure(key, out)
      __lux_module_1.profile.measures = __lux_module_1.profile.measures + 1
      return out.w, out.h
    end
    __lux_module_1.ellipsize = function(value, font, maxW)
      local text
      do
        local __lux_tmp_value_123 = value
        if __lux_tmp_value_123 == nil then
          __lux_tmp_value_123 = ""
        end
        text = __lux_module_1.toString(__lux_tmp_value_123)
      end
      if maxW <= 0 then
        return text
      end
      local w = __lux_module_1.measure(text, font)
      if w <= maxW then
        return text
      end
      local suffix = "..."
      local suffixW = __lux_module_1.measure(suffix, font)
      local lo = 0
      local hi = #text
      while lo < hi do
        local mid = __lux_module_1.mathCeil((lo + hi) / 2)
        local candidate = __lux_module_1.stringSub(text, 1, mid) .. suffix
        local candidateW = __lux_module_1.measure(candidate, font)
        if candidateW <= maxW then
          lo = mid
        else
          hi = mid - 1
        end
      end
      return __lux_module_1.stringSub(text, 1, lo) .. suffix
    end
    __lux_module_1.wrapText = function(value, font, maxW, overflow)
      local text
      do
        local __lux_tmp_value_124 = value
        if __lux_tmp_value_124 == nil then
          __lux_tmp_value_124 = ""
        end
        text = __lux_module_1.toString(__lux_tmp_value_124)
      end
      local width = __lux_module_1.toNumber(maxW)
      if width == nil then
        width = 0
      end
      if width <= 0 then
        return __lux_module_1.stringExplode("\n", text, false)
      end
      if overflow == "ellipsis" or overflow == "truncate" then
        return { __lux_module_1.ellipsize(text, font, width) }
      end
      local out = {}
      local rawLines = __lux_module_1.stringExplode("\n", text, false)
      for rawIndex = 1, #rawLines do
        local words = __lux_module_1.stringExplode(" ", rawLines[rawIndex], false)
        local line = ""
        for index = 1, #words do
          local word = words[index]
          local nextLine
          if line == "" then
            nextLine = word
          else
            nextLine = line .. " " .. word
          end
          local nextW = __lux_module_1.measure(nextLine, font)
          if nextW > width and line ~= "" then
            out[#out + 1] = line
            line = word
          else
            line = nextLine
          end
        end
        out[#out + 1] = line
      end
      return out
    end
    __lux_module_1.measureBox = function(value, font, w, textStyle)
      local resolved
      do
        local __lux_tmp_textStyle_125 = textStyle
        if __lux_tmp_textStyle_125 == nil then
          __lux_tmp_textStyle_125 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_textStyle_125)
      end
      local lines
      do
        local __lux_tmp_font_126 = font
        if __lux_tmp_font_126 == nil then
          __lux_tmp_font_126 = resolved.font
        end
        if __lux_tmp_font_126 == nil then
          __lux_tmp_font_126 = "DermaDefault"
        end
        local __lux_tmp_w_127 = __lux_module_1.toNumber(w)
        if __lux_tmp_w_127 == nil then
          __lux_tmp_w_127 = 0
        end
        lines = __lux_module_1.wrapText(value, __lux_tmp_font_126, __lux_tmp_w_127, resolved.overflow)
      end
      local maxW = 0
      for index = 1, #lines do
        local lw
        do
          local __lux_tmp_font_128 = font
          if __lux_tmp_font_128 == nil then
            __lux_tmp_font_128 = resolved.font
          end
          if __lux_tmp_font_128 == nil then
            __lux_tmp_font_128 = "DermaDefault"
          end
          lw = __lux_module_1.measure(lines[index], __lux_tmp_font_128)
        end
        maxW = __lux_module_1.mathMax(maxW, lw)
      end
      local nativeFont, alias, oversample
      do
        local __lux_tmp_font_129 = font
        if __lux_tmp_font_129 == nil then
          __lux_tmp_font_129 = resolved.font
        end
        if __lux_tmp_font_129 == nil then
          __lux_tmp_font_129 = "DermaDefault"
        end
        nativeFont, alias, oversample = __lux_module_1.nativeFor(__lux_tmp_font_129, resolved)
      end
      local lineHeight = __lux_module_1.lineHeightFor(nativeFont, alias, resolved, oversample)
      return maxW, #lines * lineHeight, lines
    end
    __lux_module_1.clearMeasureCache = function()
      __lux_module_1.clearTable(__lux_module_1.measureCache)
      __lux_module_1.clearTable(__lux_module_1.measureOrder)
      __lux_module_1.measureOrderHead = 1
      __lux_module_1.measureOrderTail = 0
      __lux_module_1.measureOrderCount = 0
    end
  end
  do
    __lux_module_1.alignFactor = function(value, vertical)
      if vertical == nil then
        vertical = false
      end
      local __lux_match_130 = value
      if __lux_match_130 == "center" or __lux_match_130 == "middle" then
        return 0.5
      elseif __lux_match_130 == "right" or __lux_match_130 == "bottom" then
        return 1
      else
        if value == TEXT_ALIGN_CENTER or vertical and value == TEXT_ALIGN_CENTER then
          return 0.5
        end
        if value == TEXT_ALIGN_RIGHT or value == TEXT_ALIGN_BOTTOM then
          return 1
        else
          return 0
        end
      end
    end
    __lux_module_1.colorAtFill = function(fill, t)
      if t == nil then
        t = 0
      end
      if __lux_module_1.typeOf(fill) ~= "table" then
        return __lux_module_1.style.colorOr(fill, __lux_module_1.white)
      end
      if __lux_module_1.style.isColor(fill) then
        return fill
      end
      if __lux_module_1.style.colorAtFill ~= nil then
        return __lux_module_1.style.colorAtFill(fill, t)
      end
      local __lux_tmp_colorA_131 = fill.colorA
      if __lux_tmp_colorA_131 == nil then
        __lux_tmp_colorA_131 = fill.color
      end
      if __lux_tmp_colorA_131 == nil then
        __lux_tmp_colorA_131 = fill.fill
      end
      return __lux_module_1.style.colorOr(__lux_tmp_colorA_131, __lux_module_1.white)
    end
    __lux_module_1.setTextColor = function(color)
      local c = __lux_module_1.style.colorOr(color, __lux_module_1.white)
      if __lux_module_1.surfaceSetTextColor ~= nil then
        do
          local __lux_tmp_r_132 = c.r
          if __lux_tmp_r_132 == nil then
            __lux_tmp_r_132 = 255
          end
          local __lux_tmp_g_133 = c.g
          if __lux_tmp_g_133 == nil then
            __lux_tmp_g_133 = 255
          end
          local __lux_tmp_b_134 = c.b
          if __lux_tmp_b_134 == nil then
            __lux_tmp_b_134 = 255
          end
          local __lux_tmp_a_135 = c.a
          if __lux_tmp_a_135 == nil then
            __lux_tmp_a_135 = 255
          end
          __lux_module_1.surfaceSetTextColor(
            __lux_tmp_r_132,
            __lux_tmp_g_133,
            __lux_tmp_b_134,
            __lux_tmp_a_135
          )
        end
      end
    end
    __lux_module_1.drawLineText = function(nativeFont, text, x, y, color, tracking, oversample)
      if tracking == nil then
        tracking = 0
      end
      if oversample == nil then
        oversample = 1
      end
      __lux_module_1.setFontSafe(nativeFont)
      __lux_module_1.setTextColor(color)
      local raw
      do
        local __lux_tmp_text_136 = text
        if __lux_tmp_text_136 == nil then
          __lux_tmp_text_136 = ""
        end
        raw = __lux_module_1.toString(__lux_tmp_text_136)
      end
      local extra = __lux_module_1.toNumber(tracking)
      if extra == nil then
        extra = 0
      end
      if extra == 0 then
        __lux_module_1.surfaceSetTextPos(x, y)
        __lux_module_1.surfaceDrawText(raw)
        return
      end
      local cursor = x
      local chars = __lux_module_1.textChars(raw)
      for index = 1, #chars do
        local ch = chars[index]
        __lux_module_1.surfaceSetTextPos(cursor, y)
        __lux_module_1.surfaceDrawText(ch)
        local cw = __lux_module_1.surfaceGetTextSize(ch)
        do
          local __lux_tmp_cw_137 = cw
          if __lux_tmp_cw_137 == nil then
            __lux_tmp_cw_137 = 0
          end
          cursor = cursor + __lux_tmp_cw_137 + extra * __lux_module_1.normalizeOversample(oversample)
        end
      end
    end
    __lux_module_1.drawLayout = function(layout, x, y, fill, fallbackColor)
      if fallbackColor == nil then
        fallbackColor = __lux_module_1.white
      end
      local oversample = __lux_module_1.normalizeOversample(layout.oversample)
      for index = 1, #layout.lines do
        local line = layout.lines[index]
        local t
        if #layout.lines <= 1 then
          t = 0
        else
          t = (index - 1) / (#layout.lines - 1)
        end
        do
          local __lux_tmp_fill_138 = fill
          if __lux_tmp_fill_138 == nil then
            __lux_tmp_fill_138 = fallbackColor
          end
          __lux_module_1.drawLineText(
            layout.font,
            line.text,
            x,
            y + line.y * oversample,
            __lux_module_1.colorAtFill(__lux_tmp_fill_138, t),
            layout.tracking,
            oversample
          )
        end
      end
    end
    __lux_module_1.normalizeShadow = function(value)
      if value == nil or value == false then
        return nil
      end
      if value == true then
        value = {}
      end
      if __lux_module_1.typeOf(value) ~= "table" then
        do
          local __lux_tmp_value_139 = __lux_module_1.toNumber(value)
          if __lux_tmp_value_139 == nil then
            __lux_tmp_value_139 = 0
          end
          value = { blur = __lux_tmp_value_139 }
        end
      end
      local __lux_tmp_x_140 = value.x
      if __lux_tmp_x_140 == nil then
        __lux_tmp_x_140 = value.offsetX
      end
      if __lux_tmp_x_140 == nil then
        __lux_tmp_x_140 = value[1]
      end
      local __lux_tmp_x_141 = __lux_module_1.toNumber(__lux_tmp_x_140)
      if __lux_tmp_x_141 == nil then
        __lux_tmp_x_141 = 1
      end
      local __lux_tmp_y_142 = value.y
      if __lux_tmp_y_142 == nil then
        __lux_tmp_y_142 = value.offsetY
      end
      if __lux_tmp_y_142 == nil then
        __lux_tmp_y_142 = value[2]
      end
      local __lux_tmp_y_143 = __lux_module_1.toNumber(__lux_tmp_y_142)
      if __lux_tmp_y_143 == nil then
        __lux_tmp_y_143 = 1
      end
      local __lux_tmp_blur_144 = value.blur
      if __lux_tmp_blur_144 == nil then
        __lux_tmp_blur_144 = value.radius
      end
      if __lux_tmp_blur_144 == nil then
        __lux_tmp_blur_144 = value[3]
      end
      local __lux_tmp_blur_145 = __lux_module_1.toNumber(__lux_tmp_blur_144)
      if __lux_tmp_blur_145 == nil then
        __lux_tmp_blur_145 = 0
      end
      local __lux_tmp_strength_146 = value.strength
      if __lux_tmp_strength_146 == nil then
        __lux_tmp_strength_146 = value.opacity
      end
      local __lux_tmp_strength_147 = __lux_module_1.toNumber(__lux_tmp_strength_146)
      if __lux_tmp_strength_147 == nil then
        __lux_tmp_strength_147 = 1
      end
      local __lux_tmp_color_148 = value.color
      if __lux_tmp_color_148 == nil then
        __lux_tmp_color_148 = value.tint
      end
      return {
        x = __lux_tmp_x_141,
        y = __lux_tmp_y_143,
        blur = __lux_tmp_blur_145,
        strength = __lux_tmp_strength_147,
        color = __lux_module_1.style.colorOr(
          __lux_tmp_color_148,
          __lux_module_1.makeColor(0, 0, 0, 180)
        ),
      }
    end
    __lux_module_1.normalizeStroke = function(value)
      if value == nil or value == false then
        return nil
      end
      if value == true then
        value = {}
      end
      if __lux_module_1.typeOf(value) ~= "table" then
        do
          local __lux_tmp_value_149 = __lux_module_1.toNumber(value)
          if __lux_tmp_value_149 == nil then
            __lux_tmp_value_149 = 1
          end
          value = { width = __lux_tmp_value_149 }
        end
      end
      local width
      do
        local __lux_tmp_width_150 = value.width
        if __lux_tmp_width_150 == nil then
          __lux_tmp_width_150 = value.size
        end
        if __lux_tmp_width_150 == nil then
          __lux_tmp_width_150 = value[1]
        end
        local __lux_tmp_width_151 = __lux_module_1.toNumber(__lux_tmp_width_150)
        if __lux_tmp_width_151 == nil then
          __lux_tmp_width_151 = 1
        end
        width = __lux_module_1.mathMax(0, __lux_tmp_width_151)
      end
      if width <= 0 then
        return nil
      end
      local __lux_tmp_softness_152 = __lux_module_1.toNumber(value.softness)
      if __lux_tmp_softness_152 == nil then
        __lux_tmp_softness_152 = 0
      end
      local __lux_tmp_color_153 = value.color
      if __lux_tmp_color_153 == nil then
        __lux_tmp_color_153 = value.tint
      end
      return {
        width = width,
        samples = __lux_module_1.mathClamp(__lux_module_1.mathCeil(width * 6), 8, 32),
        softness = __lux_tmp_softness_152,
        color = __lux_module_1.style.colorOr(
          __lux_tmp_color_153,
          __lux_module_1.makeColor(0, 0, 0, 220)
        ),
      }
    end
    __lux_module_1.normalizeGlow = function(value)
      if value == nil or value == false then
        return nil
      end
      if value == true then
        value = {}
      end
      if __lux_module_1.typeOf(value) ~= "table" then
        do
          local __lux_tmp_value_154 = __lux_module_1.toNumber(value)
          if __lux_tmp_value_154 == nil then
            __lux_tmp_value_154 = 6
          end
          value = { width = __lux_tmp_value_154 }
        end
      end
      local width
      do
        local __lux_tmp_width_155 = value.width
        if __lux_tmp_width_155 == nil then
          __lux_tmp_width_155 = value.size
        end
        if __lux_tmp_width_155 == nil then
          __lux_tmp_width_155 = value.radius
        end
        if __lux_tmp_width_155 == nil then
          __lux_tmp_width_155 = value[1]
        end
        local __lux_tmp_width_156 = __lux_module_1.toNumber(__lux_tmp_width_155)
        if __lux_tmp_width_156 == nil then
          __lux_tmp_width_156 = 6
        end
        width = __lux_module_1.mathMax(0, __lux_tmp_width_156)
      end
      if width <= 0 then
        return nil
      end
      local __lux_tmp_strength_157 = value.strength
      if __lux_tmp_strength_157 == nil then
        __lux_tmp_strength_157 = value.opacity
      end
      local __lux_tmp_strength_158 = __lux_module_1.toNumber(__lux_tmp_strength_157)
      if __lux_tmp_strength_158 == nil then
        __lux_tmp_strength_158 = 0.45
      end
      local __lux_tmp_falloff_159 = __lux_module_1.toNumber(value.falloff)
      if __lux_tmp_falloff_159 == nil then
        __lux_tmp_falloff_159 = __lux_module_1.style.glowSoftnessToFalloff(value.softness, 0.58)
      end
      local __lux_tmp_color_160 = value.color
      if __lux_tmp_color_160 == nil then
        __lux_tmp_color_160 = value.tint
      end
      return {
        width = width,
        samples = __lux_module_1.mathClamp(__lux_module_1.mathCeil(width * 2), 8, 36),
        strength = __lux_tmp_strength_158,
        falloff = __lux_tmp_falloff_159,
        color = __lux_module_1.style.colorOr(
          __lux_tmp_color_160,
          __lux_module_1.makeColor(255, 255, 255, 120)
        ),
      }
    end
    __lux_module_1.scaledColor = function(input, scale)
      local color = __lux_module_1.style.colorOr(input, __lux_module_1.white)
      local __lux_tmp_r_161 = color.r
      if __lux_tmp_r_161 == nil then
        __lux_tmp_r_161 = 255
      end
      local __lux_tmp_g_162 = color.g
      if __lux_tmp_g_162 == nil then
        __lux_tmp_g_162 = 255
      end
      local __lux_tmp_b_163 = color.b
      if __lux_tmp_b_163 == nil then
        __lux_tmp_b_163 = 255
      end
      local __lux_tmp_a_164 = color.a
      if __lux_tmp_a_164 == nil then
        __lux_tmp_a_164 = 255
      end
      local __lux_tmp_scale_165 = scale
      if __lux_tmp_scale_165 == nil then
        __lux_tmp_scale_165 = 1
      end
      return __lux_module_1.makeColor(
        __lux_tmp_r_161,
        __lux_tmp_g_162,
        __lux_tmp_b_163,
        __lux_module_1.mathClamp(
          __lux_module_1.mathFloor(__lux_tmp_a_164 * __lux_tmp_scale_165),
          0,
          255
        )
      )
    end
    __lux_module_1.snapTextPos = function(x, y, textStyle)
      local __lux_obj_textStyle_166 = textStyle
      local __lux_val_pixelSnap_167 = nil
      if __lux_obj_textStyle_166 ~= nil then
        __lux_val_pixelSnap_167 = __lux_obj_textStyle_166.pixelSnap
      end
      if __lux_val_pixelSnap_167 == false then
        return x, y
      end
      local __lux_tmp_x_168 = x
      if __lux_tmp_x_168 == nil then
        __lux_tmp_x_168 = 0
      end
      local __lux_tmp_y_169 = y
      if __lux_tmp_y_169 == nil then
        __lux_tmp_y_169 = 0
      end
      return __lux_module_1.mathFloor(__lux_tmp_x_168 + 0.5), __lux_module_1.mathFloor(__lux_tmp_y_169 + 0.5)
    end
    __lux_module_1.drawNativeFallbackRecord = function(record)
      local textStyle = record.style
      if textStyle == nil then
        textStyle = {}
      end
      local layout = __lux_module_1.layoutFor(record.text, record.font, textStyle, true)
      local x
      do
        local __lux_tmp_x_170 = record.x
        if __lux_tmp_x_170 == nil then
          __lux_tmp_x_170 = 0
        end
        x = __lux_tmp_x_170 - layout.w * __lux_module_1.alignFactor(record.alignX)
      end
      local y
      do
        local __lux_tmp_y_171 = record.y
        if __lux_tmp_y_171 == nil then
          __lux_tmp_y_171 = 0
        end
        y = __lux_tmp_y_171 - layout.h * __lux_module_1.alignFactor(record.alignY, true)
      end
      x, y = __lux_module_1.snapTextPos(x, y, textStyle)
      local fill = textStyle.fill
      if fill == nil then
        fill = textStyle.color
        if fill == nil then
          fill = record.color
          if fill == nil then
            fill = __lux_module_1.white
          end
        end
      end
      local shadow = __lux_module_1.normalizeShadow(textStyle.shadow)
      local stroke
      do
        local __lux_tmp_stroke_172 = textStyle.stroke
        if __lux_tmp_stroke_172 == nil then
          __lux_tmp_stroke_172 = textStyle.outline
        end
        stroke = __lux_module_1.normalizeStroke(__lux_tmp_stroke_172)
      end
      local glow = __lux_module_1.normalizeGlow(textStyle.glow)
      __lux_module_1.profile.draws = __lux_module_1.profile.draws + 1
      if shadow ~= nil then
        __lux_module_1.drawLayout(
          layout,
          x + shadow.x,
          y + shadow.y,
          __lux_module_1.scaledColor(shadow.color, shadow.strength),
          shadow.color
        )
      end
      if glow ~= nil then
        for index = 1, glow.samples do
          local a = index / glow.samples * math.pi * 2
          local r = glow.width * (0.35 + 0.65 * index / glow.samples)
          __lux_module_1.drawLayout(
            layout,
            x + __lux_module_1.mathCos(a) * r,
            y + __lux_module_1.mathSin(a) * r,
            __lux_module_1.scaledColor(glow.color, glow.strength / glow.samples * 2),
            glow.color
          )
        end
      end
      if stroke ~= nil then
        for index = 1, stroke.samples do
          local a = index / stroke.samples * math.pi * 2
          __lux_module_1.drawLayout(
            layout,
            x + __lux_module_1.mathCos(a) * stroke.width,
            y + __lux_module_1.mathSin(a) * stroke.width,
            stroke.color,
            stroke.color
          )
        end
      end
      do
        local __lux_tmp_color_173 = record.color
        if __lux_tmp_color_173 == nil then
          __lux_tmp_color_173 = __lux_module_1.white
        end
        __lux_module_1.drawLayout(layout, x, y, fill, __lux_tmp_color_173)
      end
      return record
    end
    __lux_module_1.drawNativePlainRecord = function(record)
      local textStyle = record.style
      if textStyle == nil then
        textStyle = {}
      end
      local fill = textStyle.fill
      if fill == nil then
        fill = textStyle.color
        if fill == nil then
          fill = record.color
          if fill == nil then
            fill = __lux_module_1.white
          end
        end
      end
      if __lux_module_1.fillNeedsShader(fill) then
        do
          local __lux_tmp_color_174 = record.color
          if __lux_tmp_color_174 == nil then
            __lux_tmp_color_174 = __lux_module_1.white
          end
          fill = __lux_tmp_color_174
        end
      end
      local nativeFont, alias = __lux_module_1.nativeFor(record.font, textStyle, true, true)
      local tracking
      do
        local __lux_tmp_tracking_175 = textStyle.tracking
        if __lux_tmp_tracking_175 == nil then
          __lux_tmp_tracking_175 = textStyle.letterSpacing
        end
        tracking = __lux_module_1.toNumber(__lux_tmp_tracking_175)
        if tracking == nil then
          tracking = alias.tracking
          if tracking == nil then
            tracking = 0
          end
        end
      end
      local raw
      do
        local __lux_tmp_text_176 = record.text
        if __lux_tmp_text_176 == nil then
          __lux_tmp_text_176 = ""
        end
        raw = __lux_module_1.toString(__lux_tmp_text_176)
      end
      if tracking == 0 and __lux_module_1.stringFind(raw, "\n", 1, true) == nil and textStyle.lineHeight == nil and alias.lineHeight == nil and not __lux_module_1.fillNeedsShader(fill) and __lux_module_1.drawSimpleText ~= nil then
        local x, y
        do
          local __lux_tmp_x_177 = record.x
          if __lux_tmp_x_177 == nil then
            __lux_tmp_x_177 = 0
          end
          local __lux_tmp_y_178 = record.y
          if __lux_tmp_y_178 == nil then
            __lux_tmp_y_178 = 0
          end
          x, y = __lux_module_1.snapTextPos(__lux_tmp_x_177, __lux_tmp_y_178, textStyle)
        end
        do
          local __lux_tmp_color_179 = record.color
          if __lux_tmp_color_179 == nil then
            __lux_tmp_color_179 = __lux_module_1.white
          end
          local __lux_tmp_alignX_180 = record.alignX
          if __lux_tmp_alignX_180 == nil then
            __lux_tmp_alignX_180 = TEXT_ALIGN_LEFT
          end
          local __lux_tmp_alignY_181 = record.alignY
          if __lux_tmp_alignY_181 == nil then
            __lux_tmp_alignY_181 = TEXT_ALIGN_TOP
          end
          __lux_module_1.drawSimpleText(
            raw,
            __lux_module_1.setFontSafe(nativeFont),
            x,
            y,
            __lux_module_1.style.colorOr(fill, __lux_tmp_color_179),
            __lux_tmp_alignX_180,
            __lux_tmp_alignY_181
          )
        end
        return record
      end
      local layout = __lux_module_1.layoutFor(raw, record.font, textStyle, true, true)
      local x
      do
        local __lux_tmp_x_182 = record.x
        if __lux_tmp_x_182 == nil then
          __lux_tmp_x_182 = 0
        end
        x = __lux_tmp_x_182 - layout.w * __lux_module_1.alignFactor(record.alignX)
      end
      local y
      do
        local __lux_tmp_y_183 = record.y
        if __lux_tmp_y_183 == nil then
          __lux_tmp_y_183 = 0
        end
        y = __lux_tmp_y_183 - layout.h * __lux_module_1.alignFactor(record.alignY, true)
      end
      x, y = __lux_module_1.snapTextPos(x, y, textStyle)
      do
        local __lux_tmp_color_184 = record.color
        if __lux_tmp_color_184 == nil then
          __lux_tmp_color_184 = __lux_module_1.white
        end
        __lux_module_1.drawLayout(layout, x, y, fill, __lux_tmp_color_184)
      end
      return record
    end
    __lux_module_1.draw = function(value, font, x, y, color, ax, ay)
      if ax == nil then
        ax = 0
      end
      if ay == nil then
        ay = 0
      end
      return __lux_module_1.drawEx(value, font, x, y, color, ax, ay, nil)
    end
    __lux_module_1.drawEx = function(value, font, x, y, color, ax, ay, textStyle)
      if ax == nil then
        ax = 0
      end
      if ay == nil then
        ay = 0
      end
      local renderer = __lux_module_1.sharedTextRenderer()
      local __lux_obj_renderer_185 = renderer
      local __lux_val_DrawTextImmediate_186 = nil
      if __lux_obj_renderer_185 ~= nil then
        __lux_val_DrawTextImmediate_186 = __lux_obj_renderer_185.DrawTextImmediate
      end
      if __lux_val_DrawTextImmediate_186 ~= nil then
        return renderer.DrawTextImmediate(value, font, x, y, color, ax, ay, textStyle)
      end
      local resolved
      do
        local __lux_tmp_textStyle_187 = textStyle
        if __lux_tmp_textStyle_187 == nil then
          __lux_tmp_textStyle_187 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_textStyle_187)
      end
      local record
      do
        local __lux_tmp_value_188 = value
        if __lux_tmp_value_188 == nil then
          __lux_tmp_value_188 = ""
        end
        local __lux_tmp_font_189 = resolved.font
        if __lux_tmp_font_189 == nil then
          __lux_tmp_font_189 = font
        end
        if __lux_tmp_font_189 == nil then
          __lux_tmp_font_189 = "DermaDefault"
        end
        local __lux_tmp_x_190 = __lux_module_1.toNumber(x)
        if __lux_tmp_x_190 == nil then
          __lux_tmp_x_190 = 0
        end
        local __lux_tmp_y_191 = __lux_module_1.toNumber(y)
        if __lux_tmp_y_191 == nil then
          __lux_tmp_y_191 = 0
        end
        local __lux_tmp_color_192 = color
        if __lux_tmp_color_192 == nil then
          __lux_tmp_color_192 = resolved.color
        end
        if __lux_tmp_color_192 == nil then
          __lux_tmp_color_192 = resolved.fill
        end
        local __lux_tmp_alignX_193 = resolved.alignX
        if __lux_tmp_alignX_193 == nil then
          __lux_tmp_alignX_193 = resolved.align
        end
        if __lux_tmp_alignX_193 == nil then
          __lux_tmp_alignX_193 = ax
        end
        if __lux_tmp_alignX_193 == nil then
          __lux_tmp_alignX_193 = TEXT_ALIGN_LEFT
        end
        local __lux_tmp_alignY_194 = resolved.alignY
        if __lux_tmp_alignY_194 == nil then
          __lux_tmp_alignY_194 = resolved.valign
        end
        if __lux_tmp_alignY_194 == nil then
          __lux_tmp_alignY_194 = ay
        end
        if __lux_tmp_alignY_194 == nil then
          __lux_tmp_alignY_194 = TEXT_ALIGN_TOP
        end
        record = {
          text = __lux_module_1.toString(__lux_tmp_value_188),
          font = __lux_tmp_font_189,
          x = __lux_tmp_x_190,
          y = __lux_tmp_y_191,
          color = __lux_module_1.style.colorOr(__lux_tmp_color_192, __lux_module_1.white),
          alignX = __lux_tmp_alignX_193,
          alignY = __lux_tmp_alignY_194,
          style = resolved,
        }
      end
      return __lux_module_1.drawNativeFallbackRecord(record)
    end
    __lux_module_1.box = function(value, font, x, y, w, h, color, alignX, alignY)
      if alignX == nil then
        alignX = TEXT_ALIGN_LEFT
      end
      if alignY == nil then
        alignY = TEXT_ALIGN_TOP
      end
      return __lux_module_1.boxEx(
        value,
        font,
        x,
        y,
        w,
        h,
        { color = color, alignX = alignX, alignY = alignY }
      )
    end
    __lux_module_1.textBoxLineStyle = function(textStyle)
      local out
      do
        local __lux_tmp_textStyle_195 = textStyle
        if __lux_tmp_textStyle_195 == nil then
          __lux_tmp_textStyle_195 = {}
        end
        out = __lux_module_1.copyValue(__lux_tmp_textStyle_195)
      end
      out.alignY = TEXT_ALIGN_TOP
      out.valign = TEXT_ALIGN_TOP
      return out
    end
    __lux_module_1.boxEx = function(value, font, x, y, w, h, textStyle)
      local renderer = __lux_module_1.sharedTextRenderer()
      local __lux_obj_renderer_196 = renderer
      local __lux_val_DrawTextBoxImmediate_197 = nil
      if __lux_obj_renderer_196 ~= nil then
        __lux_val_DrawTextBoxImmediate_197 = __lux_obj_renderer_196.DrawTextBoxImmediate
      end
      if __lux_val_DrawTextBoxImmediate_197 ~= nil then
        return renderer.DrawTextBoxImmediate(value, font, x, y, w, h, textStyle)
      end
      local resolved
      do
        local __lux_tmp_textStyle_198 = textStyle
        if __lux_tmp_textStyle_198 == nil then
          __lux_tmp_textStyle_198 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_textStyle_198)
      end
      local resolvedFont = resolved.font
      if resolvedFont == nil then
        resolvedFont = font
        if resolvedFont == nil then
          resolvedFont = "DermaDefault"
        end
      end
      local lines
      do
        local __lux_tmp_w_199 = __lux_module_1.toNumber(w)
        if __lux_tmp_w_199 == nil then
          __lux_tmp_w_199 = 0
        end
        lines = __lux_module_1.wrapText(value, resolvedFont, __lux_tmp_w_199, resolved.overflow)
      end
      local nativeFont, alias, oversample = __lux_module_1.nativeFor(resolvedFont, resolved)
      local lineHeight = __lux_module_1.lineHeightFor(nativeFont, alias, resolved, oversample)
      local totalH = #lines * lineHeight
      local startY
      do
        local __lux_tmp_y_200 = __lux_module_1.toNumber(y)
        if __lux_tmp_y_200 == nil then
          __lux_tmp_y_200 = 0
        end
        local __lux_tmp_h_201 = __lux_module_1.toNumber(h)
        if __lux_tmp_h_201 == nil then
          __lux_tmp_h_201 = totalH
        end
        local __lux_tmp_alignY_202 = resolved.alignY
        if __lux_tmp_alignY_202 == nil then
          __lux_tmp_alignY_202 = resolved.valign
        end
        if __lux_tmp_alignY_202 == nil then
          __lux_tmp_alignY_202 = TEXT_ALIGN_TOP
        end
        startY = __lux_tmp_y_200 + (__lux_tmp_h_201 - totalH) * __lux_module_1.alignFactor(__lux_tmp_alignY_202, true)
      end
      local ax = resolved.alignX
      if ax == nil then
        ax = resolved.align
        if ax == nil then
          ax = TEXT_ALIGN_LEFT
        end
      end
      local tx
      do
        local __lux_tmp_x_203 = __lux_module_1.toNumber(x)
        if __lux_tmp_x_203 == nil then
          __lux_tmp_x_203 = 0
        end
        local __lux_tmp_w_204 = __lux_module_1.toNumber(w)
        if __lux_tmp_w_204 == nil then
          __lux_tmp_w_204 = 0
        end
        tx = __lux_tmp_x_203 + __lux_tmp_w_204 * __lux_module_1.alignFactor(ax)
      end
      local lineStyle = __lux_module_1.textBoxLineStyle(resolved)
      for index = 1, #lines do
        do
          local __lux_tmp_color_205 = lineStyle.color
          if __lux_tmp_color_205 == nil then
            __lux_tmp_color_205 = lineStyle.fill
          end
          __lux_module_1.drawEx(
            lines[index],
            resolvedFont,
            tx,
            startY + (index - 1) * lineHeight,
            __lux_tmp_color_205,
            ax,
            TEXT_ALIGN_TOP,
            lineStyle
          )
        end
      end
    end
    __lux_module_1.batch = function(records)
      local renderer = __lux_module_1.sharedTextRenderer()
      local __lux_obj_renderer_206 = renderer
      local __lux_val_Flush_207 = nil
      if __lux_obj_renderer_206 ~= nil then
        __lux_val_Flush_207 = __lux_obj_renderer_206.Flush
      end
      if __lux_val_Flush_207 ~= nil and renderer.MakeRecord ~= nil then
        local normalized = {}
        do
          local __lux_tmp_records_208 = records
          if __lux_tmp_records_208 == nil then
            __lux_tmp_records_208 = {}
          end
          for index = 1, #__lux_tmp_records_208 do
            local record = records[index]
            if record ~= nil then
              do
                local __lux_tmp_text_209 = record.text
                if __lux_tmp_text_209 == nil then
                  __lux_tmp_text_209 = record.value
                end
                local __lux_tmp_alignX_210 = record.alignX
                if __lux_tmp_alignX_210 == nil then
                  __lux_tmp_alignX_210 = record.ax
                end
                local __lux_tmp_alignY_211 = record.alignY
                if __lux_tmp_alignY_211 == nil then
                  __lux_tmp_alignY_211 = record.ay
                end
                local __lux_tmp_style_212 = record.style
                if __lux_tmp_style_212 == nil then
                  __lux_tmp_style_212 = {}
                end
                normalized[#normalized + 1] = renderer.MakeRecord(
                  __lux_tmp_text_209,
                  record.font,
                  record.x,
                  record.y,
                  record.color,
                  __lux_tmp_alignX_210,
                  __lux_tmp_alignY_211,
                  __lux_tmp_style_212
                )
              end
            end
          end
        end
        return renderer.Flush(normalized, "batch")
      end
      do
        local __lux_tmp_records_213 = records
        if __lux_tmp_records_213 == nil then
          __lux_tmp_records_213 = {}
        end
        for index = 1, #__lux_tmp_records_213 do
          local record = records[index]
          do
            local __lux_tmp_alignX_214 = record.alignX
            if __lux_tmp_alignX_214 == nil then
              __lux_tmp_alignX_214 = record.ax
            end
            local __lux_tmp_alignY_215 = record.alignY
            if __lux_tmp_alignY_215 == nil then
              __lux_tmp_alignY_215 = record.ay
            end
            local __lux_tmp_style_216 = record.style
            if __lux_tmp_style_216 == nil then
              __lux_tmp_style_216 = {}
            end
            __lux_module_1.drawNativeFallbackRecord(
              {
                text = record.text,
                font = record.font,
                x = record.x,
                y = record.y,
                color = record.color,
                alignX = __lux_tmp_alignX_214,
                alignY = __lux_tmp_alignY_215,
                style = __lux_module_1.resolveStyle(__lux_tmp_style_216),
              }
            )
          end
        end
      end
      return records
    end
    __lux_module_1.prewarm = function(value, font, textStyle)
      local renderer = __lux_module_1.sharedTextRenderer()
      local __lux_obj_renderer_217 = renderer
      local __lux_val_PrewarmText_218 = nil
      if __lux_obj_renderer_217 ~= nil then
        __lux_val_PrewarmText_218 = __lux_obj_renderer_217.PrewarmText
      end
      if __lux_val_PrewarmText_218 ~= nil then
        return renderer.PrewarmText(value, font, textStyle)
      end
      local resolved
      do
        local __lux_tmp_textStyle_219 = textStyle
        if __lux_tmp_textStyle_219 == nil then
          __lux_tmp_textStyle_219 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_textStyle_219)
      end
      local layout
      do
        local __lux_tmp_font_220 = font
        if __lux_tmp_font_220 == nil then
          __lux_tmp_font_220 = resolved.font
        end
        if __lux_tmp_font_220 == nil then
          __lux_tmp_font_220 = "DermaDefault"
        end
        layout = __lux_module_1.layoutFor(value, __lux_tmp_font_220, resolved)
      end
      return layout ~= nil
    end
  end
  do
    __lux_module_1.setProfileActive = function(active)
      __lux_module_1.profile.active = active == true
      return __lux_module_1.profile.active
    end
    __lux_module_1.resetProfile = function()
      __lux_module_1.profile.draws = 0
      __lux_module_1.profile.measures = 0
      __lux_module_1.clearTable(__lux_module_1.profile.times)
      return __lux_module_1.clearTable(__lux_module_1.profile.counts)
    end
    __lux_module_1.profileSnapshot = function(reset)
      if reset == nil then
        reset = false
      end
      local out
      do
        local __lux_tmp_times_221 = __lux_module_1.profile.times
        if __lux_tmp_times_221 == nil then
          __lux_tmp_times_221 = {}
        end
        local __lux_tmp_counts_222 = __lux_module_1.profile.counts
        if __lux_tmp_counts_222 == nil then
          __lux_tmp_counts_222 = {}
        end
        out = {
          active = __lux_module_1.profile.active,
          draws = __lux_module_1.profile.draws,
          measures = __lux_module_1.profile.measures,
          times = __lux_module_1.tableCopy(__lux_tmp_times_221),
          counts = __lux_module_1.tableCopy(__lux_tmp_counts_222),
        }
      end
      if reset then
        __lux_module_1.resetProfile()
      end
      return out
    end
    __lux_module_1.countTable = function(input)
      if input == nil then
        return 0
      end
      if __lux_module_1.tableCount ~= nil then
        return __lux_module_1.tableCount(input)
      end
      local count = 0
      for _, _ in pairs(input) do
        count = count + 1
      end
      return count
    end
    __lux_module_1.resetRendererFrameStats = function(stats)
      stats.textDraws = 0
      stats.textNativeDraws = 0
      stats.textShaderDraws = 0
      stats.textComposedBakes = 0
      stats.textComposedBlits = 0
      stats.textComposedDraws = 0
      stats.textComposedBatchDraws = 0
      stats.textComposedBatchedRecords = 0
      stats.textComposedFaceDraws = 0
      stats.textComposedFxDraws = 0
      stats.textComposedRequests = 0
      stats.textComposedBatches = 0
      stats.textComposedReadyBatches = 0
      stats.textComposedFallbackBatches = 0
      stats.textComposedFallbackRecords = 0
      stats.textComposedPrewarmFails = 0
      stats.textComposedPrewarmRestarts = 0
      do
        local __lux_tmp_textComposedEntries_223 = stats.textComposedEntries
        if __lux_tmp_textComposedEntries_223 == nil then
          __lux_tmp_textComposedEntries_223 = 0
        end
        stats.textComposedEntries = __lux_tmp_textComposedEntries_223
      end
      do
        local __lux_tmp_textComposedEvicts_224 = stats.textComposedEvicts
        if __lux_tmp_textComposedEvicts_224 == nil then
          __lux_tmp_textComposedEvicts_224 = 0
        end
        stats.textComposedEvicts = __lux_tmp_textComposedEvicts_224
      end
      do
        local __lux_tmp_textMeasureHits_225 = stats.textMeasureHits
        if __lux_tmp_textMeasureHits_225 == nil then
          __lux_tmp_textMeasureHits_225 = 0
        end
        stats.textMeasureHits = __lux_tmp_textMeasureHits_225
      end
      do
        local __lux_tmp_textMeasureMisses_226 = stats.textMeasureMisses
        if __lux_tmp_textMeasureMisses_226 == nil then
          __lux_tmp_textMeasureMisses_226 = 0
        end
        stats.textMeasureMisses = __lux_tmp_textMeasureMisses_226
      end
      do
        local __lux_tmp_textEntryCacheHits_227 = stats.textEntryCacheHits
        if __lux_tmp_textEntryCacheHits_227 == nil then
          __lux_tmp_textEntryCacheHits_227 = 0
        end
        stats.textEntryCacheHits = __lux_tmp_textEntryCacheHits_227
      end
      do
        local __lux_tmp_textEntryCacheMisses_228 = stats.textEntryCacheMisses
        if __lux_tmp_textEntryCacheMisses_228 == nil then
          __lux_tmp_textEntryCacheMisses_228 = 0
        end
        stats.textEntryCacheMisses = __lux_tmp_textEntryCacheMisses_228
      end
      do
        local __lux_tmp_textFallbacks_229 = stats.textFallbacks
        if __lux_tmp_textFallbacks_229 == nil then
          __lux_tmp_textFallbacks_229 = 0
        end
        stats.textFallbacks = __lux_tmp_textFallbacks_229
      end
      stats.textDataDraws = 0
      stats.textDataBatches = 0
      stats.textAtlasUploads = 0
      stats.textAtlasGlyphs = 0
      do
        local __lux_tmp_textAtlasResets_230 = stats.textAtlasResets
        if __lux_tmp_textAtlasResets_230 == nil then
          __lux_tmp_textAtlasResets_230 = 0
        end
        stats.textAtlasResets = __lux_tmp_textAtlasResets_230
      end
      stats.textCacheSize = __lux_module_1.measureOrderCount
      return stats
    end
    __lux_module_1.statAdd = function(stats, key, amount)
      if amount == nil then
        amount = 1
      end
      do
        local __lux_tmp_key_231 = stats[key]
        if __lux_tmp_key_231 == nil then
          __lux_tmp_key_231 = 0
        end
        stats[key] = __lux_tmp_key_231 + amount
      end
      return stats[key]
    end
  end
  do
    __lux_module_1.textComposedEnabled = function()
      if not __lux_module_1.textComposerCapable() or __lux_module_1.atlasFailed then
        return false
      end
      if __lux_module_1.composedCvar == nil and __lux_module_1.getConVar ~= nil then
        do
          local __lux_tmp_getConVar_232 = __lux_module_1.getConVar("mgfx_text_composed")
          if __lux_tmp_getConVar_232 == nil then
            __lux_tmp_getConVar_232 = false
          end
          __lux_module_1.composedCvar = __lux_tmp_getConVar_232
        end
      end
      if __lux_module_1.composedCvar == false or __lux_module_1.composedCvar == nil then
        return true
      end
      return __lux_module_1.composedCvar:GetBool()
    end
    __lux_module_1.textComposeBudget = function()
      if __lux_module_1.budgetCvar == nil and __lux_module_1.getConVar ~= nil then
        do
          local __lux_tmp_getConVar_233 = __lux_module_1.getConVar("mgfx_text_composed_budget")
          if __lux_tmp_getConVar_233 == nil then
            __lux_tmp_getConVar_233 = false
          end
          __lux_module_1.budgetCvar = __lux_tmp_getConVar_233
        end
      end
      if __lux_module_1.budgetCvar == false or __lux_module_1.budgetCvar == nil then
        return __lux_module_1.DEFAULT_BUDGET
      end
      return __lux_module_1.mathMax(0, __lux_module_1.budgetCvar:GetInt())
    end
    __lux_module_1.clearRenderTargetAlpha = function(rt, w, h)
      if w == nil then
        w = __lux_module_1.ATLAS_W
      end
      if h == nil then
        h = __lux_module_1.ATLAS_H
      end
      if rt == nil or __lux_module_1.renderPushRenderTarget == nil or __lux_module_1.renderClear == nil or __lux_module_1.renderPopRenderTarget == nil then
        return false
      end
      __lux_module_1.renderPushRenderTarget(rt, 0, 0, w, h)
      if __lux_module_1.renderSetScissorRect ~= nil then
        __lux_module_1.renderSetScissorRect(0, 0, 0, 0, false)
      end
      if __lux_module_1.renderOverrideAlphaWriteEnable ~= nil then
        __lux_module_1.renderOverrideAlphaWriteEnable(true, true)
      end
      __lux_module_1.renderClear(0, 0, 0, 0, true, true)
      if __lux_module_1.renderOverrideAlphaWriteEnable ~= nil then
        __lux_module_1.renderOverrideAlphaWriteEnable(false)
      end
      __lux_module_1.renderPopRenderTarget()
      __lux_module_1.restoreScissor()
      return true
    end
    __lux_module_1.beginAtlasDraw = function()
      local alpha
      if __lux_module_1.surfaceGetAlphaMultiplier ~= nil then
        alpha = __lux_module_1.surfaceGetAlphaMultiplier()
      else
        alpha = 1
      end
      local cr = nil
      local cg = nil
      local cb = nil
      if __lux_module_1.renderGetColorModulation ~= nil then
        cr, cg, cb = __lux_module_1.renderGetColorModulation()
      end
      local blend
      if __lux_module_1.renderGetBlend ~= nil then
        blend = __lux_module_1.renderGetBlend()
      else
        blend = nil
      end
      if __lux_module_1.surfaceSetAlphaMultiplier ~= nil then
        __lux_module_1.surfaceSetAlphaMultiplier(1)
      end
      if __lux_module_1.renderSetColorModulation ~= nil then
        __lux_module_1.renderSetColorModulation(1, 1, 1)
      end
      if __lux_module_1.renderSetBlend ~= nil then
        __lux_module_1.renderSetBlend(1)
      end
      return alpha, cr, cg, cb, blend
    end
    __lux_module_1.endAtlasDraw = function(alpha, cr, cg, cb, blend)
      if __lux_module_1.surfaceSetAlphaMultiplier ~= nil then
        do
          local __lux_tmp_alpha_234 = alpha
          if __lux_tmp_alpha_234 == nil then
            __lux_tmp_alpha_234 = 1
          end
          __lux_module_1.surfaceSetAlphaMultiplier(__lux_tmp_alpha_234)
        end
      end
      if __lux_module_1.renderSetColorModulation ~= nil and cr ~= nil then
        __lux_module_1.renderSetColorModulation(cr, cg, cb)
      end
      if __lux_module_1.renderSetBlend ~= nil and blend ~= nil then
        __lux_module_1.renderSetBlend(blend)
      end
    end
    __lux_module_1.clearAtlasSlot = function(x, y, w, h)
      if __lux_module_1.surfaceDrawRect == nil or __lux_module_1.surfaceSetDrawColor == nil then
        return false
      end
      do
        local __lux_tmp_x_235 = x
        if __lux_tmp_x_235 == nil then
          __lux_tmp_x_235 = 0
        end
        x = __lux_module_1.mathFloor(__lux_module_1.mathMax(0, __lux_tmp_x_235))
      end
      do
        local __lux_tmp_y_236 = y
        if __lux_tmp_y_236 == nil then
          __lux_tmp_y_236 = 0
        end
        y = __lux_module_1.mathFloor(__lux_module_1.mathMax(0, __lux_tmp_y_236))
      end
      do
        local __lux_tmp_w_237 = w
        if __lux_tmp_w_237 == nil then
          __lux_tmp_w_237 = 0
        end
        w = __lux_module_1.mathCeil(
          __lux_module_1.mathMin(__lux_module_1.ATLAS_W - x, __lux_tmp_w_237)
        )
      end
      do
        local __lux_tmp_h_238 = h
        if __lux_tmp_h_238 == nil then
          __lux_tmp_h_238 = 0
        end
        h = __lux_module_1.mathCeil(
          __lux_module_1.mathMin(__lux_module_1.ATLAS_H - y, __lux_tmp_h_238)
        )
      end
      if w <= 0 or h <= 0 then
        return false
      end
      local cr = nil
      local cg = nil
      local cb = nil
      if __lux_module_1.renderGetColorModulation ~= nil then
        cr, cg, cb = __lux_module_1.renderGetColorModulation()
      end
      local blend
      if __lux_module_1.renderGetBlend ~= nil then
        blend = __lux_module_1.renderGetBlend()
      else
        blend = nil
      end
      local alpha
      if __lux_module_1.surfaceGetAlphaMultiplier ~= nil then
        alpha = __lux_module_1.surfaceGetAlphaMultiplier()
      else
        alpha = 1
      end
      if __lux_module_1.surfaceSetAlphaMultiplier ~= nil then
        __lux_module_1.surfaceSetAlphaMultiplier(1)
      end
      if __lux_module_1.renderSetColorModulation ~= nil then
        __lux_module_1.renderSetColorModulation(1, 1, 1)
      end
      if __lux_module_1.renderSetBlend ~= nil then
        __lux_module_1.renderSetBlend(1)
      end
      if __lux_module_1.renderOverrideAlphaWriteEnable ~= nil then
        __lux_module_1.renderOverrideAlphaWriteEnable(true, true)
      end
      if __lux_module_1.renderOverrideBlend ~= nil then
        __lux_module_1.renderOverrideBlend(
          true,
          BLEND_ONE,
          BLEND_ZERO,
          BLENDFUNC_ADD,
          BLEND_ONE,
          BLEND_ZERO,
          BLENDFUNC_ADD
        )
      end
      __lux_module_1.surfaceSetDrawColor(0, 0, 0, 0)
      __lux_module_1.surfaceDrawRect(x, y, w, h)
      if __lux_module_1.renderOverrideBlend ~= nil then
        __lux_module_1.renderOverrideBlend(false)
      end
      if __lux_module_1.renderOverrideAlphaWriteEnable ~= nil then
        __lux_module_1.renderOverrideAlphaWriteEnable(false)
      end
      if __lux_module_1.surfaceSetAlphaMultiplier ~= nil then
        __lux_module_1.surfaceSetAlphaMultiplier(alpha)
      end
      if __lux_module_1.renderSetColorModulation ~= nil and cr ~= nil then
        __lux_module_1.renderSetColorModulation(cr, cg, cb)
      end
      if __lux_module_1.renderSetBlend ~= nil and blend ~= nil then
        __lux_module_1.renderSetBlend(blend)
      end
      return true
    end
    __lux_module_1.createAtlasMaterial = function(name, rt)
      if __lux_module_1.createMaterial == nil or rt == nil or rt.GetName == nil then
        return nil
      end
      return __lux_module_1.createMaterial(
        name,
        "UnlitGeneric",
        {
          ["$basetexture"] = rt:GetName(),
          ["$translucent"] = 1,
          ["$vertexalpha"] = 1,
          ["$vertexcolor"] = 1,
          ["$ignorez"] = 1,
          ["$nocull"] = 1,
          ["$linearread_basetexture"] = 0,
        }
      )
    end
    __lux_module_1.createAtlasPage = function(index)
      if __lux_module_1.getRenderTargetEx == nil or __lux_module_1.bitBor == nil then
        return nil
      end
      local stamp
      if __lux_module_1.sysTime ~= nil then
        stamp = __lux_module_1.sysTime()
      else
        stamp = index
      end
      local flags = __lux_module_1.bitBor(256, 4, 8)
      local rt = __lux_module_1.getRenderTargetEx(
        "MGFXTextComposeAtlas_" ..
          __lux_module_1.toString(index) .. "_" .. __lux_module_1.toString(stamp),
        __lux_module_1.ATLAS_W,
        __lux_module_1.ATLAS_H,
        RT_SIZE_LITERAL,
        MATERIAL_RT_DEPTH_SEPARATE,
        flags,
        0,
        IMAGE_FORMAT_BGRA8888
      )
      if rt == nil then
        return nil
      end
      local pageMaterial = __lux_module_1.createAtlasMaterial(
        "MGFXTextComposeAtlas_" ..
          __lux_module_1.toString(index) .. "_" .. __lux_module_1.toString(stamp),
        rt
      )
      local page = {
        index = index,
        rt = rt,
        material = pageMaterial,
        w = __lux_module_1.ATLAS_W,
        h = __lux_module_1.ATLAS_H,
        x = 0,
        y = 0,
        rowH = 0,
        generation = 1,
      }
      if __lux_module_1.createPageTextMaterials ~= nil then
        local mats = __lux_module_1.createPageTextMaterials(rt)
        do
          local __lux_obj_mats_239 = mats
          local __lux_val_compose_240 = nil
          if __lux_obj_mats_239 ~= nil then
            __lux_val_compose_240 = __lux_obj_mats_239.compose
          end
          page.composeMat = __lux_val_compose_240
        end
        do
          local __lux_obj_mats_241 = mats
          local __lux_val_face_242 = nil
          if __lux_obj_mats_241 ~= nil then
            __lux_val_face_242 = __lux_obj_mats_241.face
          end
          page.faceMat = __lux_val_face_242
        end
      end
      __lux_module_1.atlasPages[index] = page
      if __lux_module_1.atlas == nil then
        __lux_module_1.atlas = page
      end
      if __lux_module_1.atlasMat == nil then
        __lux_module_1.atlasMat = pageMaterial
      end
      __lux_module_1.clearRenderTargetAlpha(
        rt,
        __lux_module_1.ATLAS_W,
        __lux_module_1.ATLAS_H
      )
      return page
    end
    __lux_module_1.ensureTargets = function()
      if __lux_module_1.atlasPages[1] ~= nil then
        return true
      end
      return __lux_module_1.createAtlasPage(1) ~= nil
    end
    __lux_module_1.resetAtlasPage = function(page)
      if page == nil then
        return nil
      end
      page.x = 0
      page.y = 0
      page.rowH = 0
      do
        local __lux_tmp_generation_243 = page.generation
        if __lux_tmp_generation_243 == nil then
          __lux_tmp_generation_243 = 0
        end
        page.generation = __lux_tmp_generation_243 + 1
      end
      if page.rt ~= nil then
        do
          local __lux_tmp_w_244 = page.w
          if __lux_tmp_w_244 == nil then
            __lux_tmp_w_244 = __lux_module_1.ATLAS_W
          end
          local __lux_tmp_h_245 = page.h
          if __lux_tmp_h_245 == nil then
            __lux_tmp_h_245 = __lux_module_1.ATLAS_H
          end
          __lux_module_1.clearRenderTargetAlpha(page.rt, __lux_tmp_w_244, __lux_tmp_h_245)
        end
      end
      return page
    end
    __lux_module_1.resetAtlasPages = function()
      __lux_module_1.atlasEpoch = __lux_module_1.atlasEpoch + 1
      for _, page in ipairs(__lux_module_1.atlasPages) do
        __lux_module_1.resetAtlasPage(page)
      end
      __lux_module_1.atlas = __lux_module_1.atlasPages[1]
      do
        local __lux_obj_atlas_246 = __lux_module_1.atlas
        local __lux_tmp_material_247 = nil
        if __lux_obj_atlas_246 ~= nil then
          __lux_tmp_material_247 = __lux_obj_atlas_246.material
        end
        if __lux_tmp_material_247 == nil then
          __lux_tmp_material_247 = __lux_module_1.atlasMat
        end
        __lux_module_1.atlasMat = __lux_tmp_material_247
      end
    end
    __lux_module_1.tryAllocOnPage = function(page, w, h, gutter)
      if page == nil then
        return nil
      end
      local cellW = w + gutter * 2
      local cellH = h + gutter * 2
      if cellW > page.w or cellH > page.h then
        return nil
      end
      if page.x + cellW > page.w then
        page.x = 0
        page.y = page.y + page.rowH
        page.rowH = 0
      end
      if page.y + cellH > page.h then
        return nil
      end
      local x = page.x + gutter
      local y = page.y + gutter
      page.x = page.x + cellW
      page.rowH = __lux_module_1.mathMax(page.rowH, cellH)
      return x, y
    end
    __lux_module_1.ensureAtlasPage = function(index)
      if __lux_module_1.atlasPages[index] ~= nil then
        return __lux_module_1.atlasPages[index]
      end
      if index > __lux_module_1.MAX_ATLAS_PAGES then
        return nil
      end
      return __lux_module_1.createAtlasPage(index)
    end
    __lux_module_1.allocAtlasSlot = function(w, h, gutter)
      if not __lux_module_1.ensureTargets() then
        return nil
      end
      w = __lux_module_1.mathCeil(w)
      h = __lux_module_1.mathCeil(h)
      do
        local __lux_tmp_gutter_248 = __lux_module_1.toNumber(gutter)
        if __lux_tmp_gutter_248 == nil then
          __lux_tmp_gutter_248 = 0
        end
        gutter = __lux_module_1.mathCeil(__lux_module_1.mathMax(0, __lux_tmp_gutter_248))
      end
      for index = 1, __lux_module_1.MAX_ATLAS_PAGES do
        local page = __lux_module_1.ensureAtlasPage(index)
        if page == nil then
          break
        end
        local x, y = __lux_module_1.tryAllocOnPage(page, w, h, gutter)
        if x ~= nil then
          if index > __lux_module_1.SOFT_ATLAS_PAGES then
            __lux_module_1.atlasNeedsReset = true
          end
          return page, x, y
        end
      end
      if not __lux_module_1.atlasNeedsReset then
        __lux_module_1.atlasNeedsReset = true
        __lux_module_1.clearComposedCache()
        __lux_module_1.atlasNeedsReset = false
        for index = 1, __lux_module_1.MAX_ATLAS_PAGES do
          local page = __lux_module_1.ensureAtlasPage(index)
          if page == nil then
            break
          end
          local x, y = __lux_module_1.tryAllocOnPage(page, w, h, gutter)
          if x ~= nil then
            return page, x, y
          end
        end
      end
      return nil
    end
    __lux_module_1.clearComposedCache = function()
      __lux_module_1.clearTable(__lux_module_1.composedCache)
      __lux_module_1.composedCacheCount = 0
      __lux_module_1.bakesThisFrame = 0
      __lux_module_1.atlasNeedsReset = false
      __lux_module_1.resetAtlasPages()
      return true
    end
    __lux_module_1.atlasFillRatio = function()
      local usedH = 0
      for _, page in ipairs(__lux_module_1.atlasPages) do
        do
          local __lux_tmp_h_249 = page.h
          if __lux_tmp_h_249 == nil then
            __lux_tmp_h_249 = __lux_module_1.ATLAS_H
          end
          local __lux_tmp_y_250 = page.y
          if __lux_tmp_y_250 == nil then
            __lux_tmp_y_250 = 0
          end
          local __lux_tmp_rowH_251 = page.rowH
          if __lux_tmp_rowH_251 == nil then
            __lux_tmp_rowH_251 = 0
          end
          usedH = usedH + __lux_module_1.mathMin(__lux_tmp_h_249, __lux_tmp_y_250 + __lux_tmp_rowH_251)
        end
      end
      if #__lux_module_1.atlasPages > 0 then
        return usedH / (#__lux_module_1.atlasPages * __lux_module_1.ATLAS_H)
      else
        return 0
      end
    end
  end
  do
    __lux_module_1.colorKey = function(color)
      local c
      if __lux_module_1.style.asColor ~= nil then
        c = __lux_module_1.style.asColor(color, __lux_module_1.white)
      else
        c = __lux_module_1.style.colorOr(color, __lux_module_1.white)
      end
      local __lux_tmp_r_252 = c.r
      if __lux_tmp_r_252 == nil then
        __lux_tmp_r_252 = 0
      end
      local __lux_tmp_g_253 = c.g
      if __lux_tmp_g_253 == nil then
        __lux_tmp_g_253 = 0
      end
      local __lux_tmp_b_254 = c.b
      if __lux_tmp_b_254 == nil then
        __lux_tmp_b_254 = 0
      end
      local __lux_tmp_a_255 = c.a
      if __lux_tmp_a_255 == nil then
        __lux_tmp_a_255 = 255
      end
      return __lux_module_1.tableConcat(
        { __lux_tmp_r_252, __lux_tmp_g_253, __lux_tmp_b_254, __lux_tmp_a_255 },
        ","
      )
    end
    __lux_module_1.isColorValue = function(value)
      return __lux_module_1.style.isColor ~= nil and __lux_module_1.style.isColor(value)
    end
    __lux_module_1.fillForRecord = function(record)
      local textStyle
      do
        local __lux_obj_record_256 = record
        local __lux_val_style_257 = nil
        if __lux_obj_record_256 ~= nil then
          __lux_val_style_257 = __lux_obj_record_256.style
        end
        textStyle = __lux_val_style_257
        if textStyle == nil then
          textStyle = {}
        end
      end
      local __lux_tmp_fill_258 = textStyle.fill
      if __lux_tmp_fill_258 == nil then
        __lux_tmp_fill_258 = textStyle.color
      end
      if __lux_tmp_fill_258 == nil then
        local __lux_obj_record_259 = record
        local __lux_val_color_260 = nil
        if __lux_obj_record_259 ~= nil then
          __lux_val_color_260 = __lux_obj_record_259.color
        end
        __lux_tmp_fill_258 = __lux_val_color_260
      end
      if __lux_tmp_fill_258 == nil then
        __lux_tmp_fill_258 = __lux_module_1.white
      end
      return __lux_tmp_fill_258
    end
    __lux_module_1.fillNeedsShader = function(fill)
      return __lux_module_1.typeOf(fill) == "table" and not __lux_module_1.isColorValue(fill) and fill.kind ~= nil
    end
    __lux_module_1.normalizeSurface = function(value)
      if value == nil or value == false then
        return nil
      end
      if value == true then
        return { strength = 0.18 }
      end
      if __lux_module_1.typeOf(value) == "number" then
        value = { strength = value }
      end
      if __lux_module_1.typeOf(value) ~= "table" then
        return nil
      end
      local strength
      do
        local __lux_tmp_strength_261 = value.strength
        if __lux_tmp_strength_261 == nil then
          __lux_tmp_strength_261 = value[1]
        end
        local __lux_tmp_strength_262 = __lux_module_1.toNumber(__lux_tmp_strength_261)
        if __lux_tmp_strength_262 == nil then
          __lux_tmp_strength_262 = 0.18
        end
        strength = __lux_module_1.mathClamp(__lux_tmp_strength_262, 0, 1)
      end
      if strength <= 0 then
        return nil
      end
      return { strength = strength }
    end
    __lux_module_1.normalizeWeightAdjust = function(textStyle)
      if textStyle == nil then
        textStyle = {}
      end
      if __lux_module_1.toNumber(textStyle.weightAdjust) ~= nil then
        return __lux_module_1.mathClamp(__lux_module_1.toNumber(textStyle.weightAdjust), -2, 2)
      end
      if textStyle.bold then
        return 0.55
      end
      if textStyle.thin then
        return -0.38
      end
      return 0
    end
    __lux_module_1.effectPad = function(textStyle)
      local shadow = __lux_module_1.normalizeShadow(textStyle.shadow)
      local stroke
      do
        local __lux_tmp_stroke_263 = textStyle.stroke
        if __lux_tmp_stroke_263 == nil then
          __lux_tmp_stroke_263 = textStyle.outline
        end
        stroke = __lux_module_1.normalizeStroke(__lux_tmp_stroke_263)
      end
      local glow = __lux_module_1.normalizeGlow(textStyle.glow)
      local face = __lux_module_1.normalizeSurface(textStyle.surface)
      local weightAdjust = __lux_module_1.normalizeWeightAdjust(textStyle)
      local radius = __lux_module_1.ATLAS_PAD
      if weightAdjust > 0 then
        radius = __lux_module_1.mathMax(radius, weightAdjust + 1)
      end
      if stroke ~= nil then
        radius = __lux_module_1.mathMax(radius, stroke.width + 1)
      end
      if glow ~= nil then
        radius = __lux_module_1.mathMax(radius, glow.width + 1)
      end
      if shadow ~= nil then
        radius = __lux_module_1.mathMax(
          radius,
          __lux_module_1.mathMax(
            __lux_module_1.mathAbs(shadow.x),
            __lux_module_1.mathAbs(shadow.y)
          ) + shadow.blur + 1
        )
      end
      local pad = __lux_module_1.mathCeil(radius + 2)
      return pad, pad, shadow, stroke, glow, face, weightAdjust
    end
    __lux_module_1.effectRouteKey = function(stroke, glow, shadow, face, weightAdjust)
      local __lux_tmp_264
      if stroke ~= nil then
        __lux_tmp_264 = stroke.width ..
          ":" ..
            stroke.samples .. ":" .. stroke.softness .. ":" .. __lux_module_1.colorKey(stroke.color)
      else
        __lux_tmp_264 = ""
      end
      local __lux_tmp_265
      if glow ~= nil then
        do
          local __lux_tmp_falloff_266 = glow.falloff
          if __lux_tmp_falloff_266 == nil then
            __lux_tmp_falloff_266 = ""
          end
          __lux_tmp_265 = glow.width ..
            ":" ..
              glow.strength ..
                ":" .. __lux_tmp_falloff_266 .. ":" .. __lux_module_1.colorKey(glow.color)
        end
      else
        __lux_tmp_265 = ""
      end
      local __lux_tmp_267
      if shadow ~= nil then
        __lux_tmp_267 = shadow.x ..
          ":" ..
            shadow.y ..
              ":" ..
                shadow.blur .. ":" .. shadow.strength .. ":" .. __lux_module_1.colorKey(shadow.color)
      else
        __lux_tmp_267 = ""
      end
      local __lux_tmp_268
      if face ~= nil then
        __lux_tmp_268 = __lux_module_1.toString(face.strength)
      else
        __lux_tmp_268 = ""
      end
      local __lux_tmp_weightAdjust_269 = weightAdjust
      if __lux_tmp_weightAdjust_269 == nil then
        __lux_tmp_weightAdjust_269 = 0
      end
      return __lux_module_1.tableConcat(
        {
          __lux_tmp_264,
          __lux_tmp_265,
          __lux_tmp_267,
          __lux_tmp_268,
          __lux_module_1.toString(__lux_tmp_weightAdjust_269),
        },
        "31"
      )
    end
    __lux_module_1.effectInfo = function(textStyle)
      if textStyle == nil then
        textStyle = {}
      end
      if __lux_module_1.typeOf(textStyle) == "table" and textStyle.__mgfxTextEffectInfo ~= nil then
        return textStyle.__mgfxTextEffectInfo
      end
      local pad, gutter, shadow, stroke, glow, face, weightAdjust = __lux_module_1.effectPad(textStyle)
      local info = {
        pad = pad,
        gutter = gutter,
        shadow = shadow,
        stroke = stroke,
        glow = glow,
        face = face,
        weightAdjust = weightAdjust,
        routeKey = __lux_module_1.effectRouteKey(stroke, glow, shadow, face, weightAdjust),
      }
      if __lux_module_1.typeOf(textStyle) == "table" and textStyle[__lux_module_1.RESOLVED_STYLE_MARK] == true then
        textStyle.__mgfxTextEffectInfo = info
      end
      return info
    end
    __lux_module_1.fastEntryKey = function(record, textStyle, info)
      local nativeFont, alias, oversample = __lux_module_1.nativeFor(record.font, textStyle)
      local tracking
      do
        local __lux_tmp_tracking_270 = textStyle.tracking
        if __lux_tmp_tracking_270 == nil then
          __lux_tmp_tracking_270 = textStyle.letterSpacing
        end
        tracking = __lux_module_1.toNumber(__lux_tmp_tracking_270)
        if tracking == nil then
          tracking = alias.tracking
          if tracking == nil then
            tracking = 0
          end
        end
      end
      local lineHeight = __lux_module_1.lineHeightFor(nativeFont, alias, textStyle, oversample)
      local __lux_tmp_text_271 = record.text
      if __lux_tmp_text_271 == nil then
        __lux_tmp_text_271 = ""
      end
      local __lux_tmp_font_272 = record.font
      if __lux_tmp_font_272 == nil then
        __lux_tmp_font_272 = ""
      end
      local __lux_tmp_nativeFont_273 = nativeFont
      if __lux_tmp_nativeFont_273 == nil then
        __lux_tmp_nativeFont_273 = ""
      end
      local __lux_tmp_oversample_274 = oversample
      if __lux_tmp_oversample_274 == nil then
        __lux_tmp_oversample_274 = 1
      end
      local __lux_obj_info_275 = info
      local __lux_tmp_routeKey_276 = nil
      if __lux_obj_info_275 ~= nil then
        __lux_tmp_routeKey_276 = __lux_obj_info_275.routeKey
      end
      if __lux_tmp_routeKey_276 == nil then
        __lux_tmp_routeKey_276 = ""
      end
      return __lux_module_1.CACHE_VERSION ..
        "30" ..
          __lux_module_1.toString(__lux_tmp_text_271) ..
            "30" ..
              __lux_module_1.toString(__lux_tmp_font_272) ..
                "30" ..
                  __lux_module_1.toString(__lux_tmp_nativeFont_273) ..
                    "30" ..
                      __lux_module_1.toString(__lux_tmp_oversample_274) ..
                        "30" ..
                          __lux_module_1.toString(tracking) ..
                            "30" ..
                              __lux_module_1.toString(lineHeight) ..
                                "30" .. __lux_module_1.toString(__lux_tmp_routeKey_276)
    end
    __lux_module_1.drawUV = function(material, x, y, w, h, u0, v0, u1, v1, color)
      if material == nil or __lux_module_1.surfaceSetMaterial == nil or __lux_module_1.surfaceSetDrawColor == nil or __lux_module_1.surfaceDrawPoly == nil then
        return false
      end
      __lux_module_1.atlasQuad[1].x = x
      __lux_module_1.atlasQuad[1].y = y
      __lux_module_1.atlasQuad[1].u = u0
      __lux_module_1.atlasQuad[1].v = v0
      __lux_module_1.atlasQuad[2].x = x + w
      __lux_module_1.atlasQuad[2].y = y
      __lux_module_1.atlasQuad[2].u = u1
      __lux_module_1.atlasQuad[2].v = v0
      __lux_module_1.atlasQuad[3].x = x + w
      __lux_module_1.atlasQuad[3].y = y + h
      __lux_module_1.atlasQuad[3].u = u1
      __lux_module_1.atlasQuad[3].v = v1
      __lux_module_1.atlasQuad[4].x = x
      __lux_module_1.atlasQuad[4].y = y + h
      __lux_module_1.atlasQuad[4].u = u0
      __lux_module_1.atlasQuad[4].v = v1
      __lux_module_1.surfaceSetMaterial(material)
      local c
      if __lux_module_1.style.asColor ~= nil then
        c = __lux_module_1.style.asColor(color, __lux_module_1.white)
      else
        c = __lux_module_1.style.colorOr(color, __lux_module_1.white)
      end
      do
        local __lux_tmp_r_277 = c.r
        if __lux_tmp_r_277 == nil then
          __lux_tmp_r_277 = 255
        end
        local __lux_tmp_g_278 = c.g
        if __lux_tmp_g_278 == nil then
          __lux_tmp_g_278 = 255
        end
        local __lux_tmp_b_279 = c.b
        if __lux_tmp_b_279 == nil then
          __lux_tmp_b_279 = 255
        end
        local __lux_tmp_a_280 = c.a
        if __lux_tmp_a_280 == nil then
          __lux_tmp_a_280 = 255
        end
        __lux_module_1.surfaceSetDrawColor(
          __lux_tmp_r_277,
          __lux_tmp_g_278,
          __lux_tmp_b_279,
          __lux_tmp_a_280
        )
      end
      __lux_module_1.surfaceDrawPoly(__lux_module_1.atlasQuad)
      return true
    end
    __lux_module_1.bakeEntry = function(record, key, layout, shadow, stroke, glow, face, weightAdjust, pad, gutter, stats)
      local oversample = __lux_module_1.normalizeOversample(layout.oversample)
      local atlasW = __lux_module_1.mathCeil((layout.w + pad * 2) * oversample)
      local atlasH = __lux_module_1.mathCeil((layout.h + pad * 2) * oversample)
      if atlasW <= 0 or atlasH <= 0 or atlasW > __lux_module_1.ATLAS_W or atlasH > __lux_module_1.ATLAS_H then
        return nil
      end
      local allocGutter = gutter * oversample
      local page, slotX, slotY = __lux_module_1.allocAtlasSlot(atlasW, atlasH, allocGutter)
      if page == nil or slotX == nil then
        return nil
      end
      __lux_module_1.renderPushRenderTarget(page.rt, 0, 0, page.w, page.h)
      if __lux_module_1.renderSetScissorRect ~= nil then
        __lux_module_1.renderSetScissorRect(0, 0, 0, 0, false)
      end
      __lux_module_1.camStart2D()
      local alpha, cr, cg, cb, blend = __lux_module_1.beginAtlasDraw()
      __lux_module_1.clearAtlasSlot(
        slotX - allocGutter,
        slotY - allocGutter,
        atlasW + allocGutter * 2,
        atlasH + allocGutter * 2
      )
      __lux_module_1.drawLayout(
        layout,
        slotX + pad * oversample,
        slotY + pad * oversample,
        __lux_module_1.white,
        __lux_module_1.white
      )
      __lux_module_1.endAtlasDraw(alpha, cr, cg, cb, blend)
      __lux_module_1.camEnd2D()
      __lux_module_1.renderPopRenderTarget()
      __lux_module_1.restoreScissor()
      local fill = __lux_module_1.fillForRecord(record)
      local shaderCapableFace = not __lux_module_1.fillNeedsShader(fill)
      local shaderFace
      do
        local __lux_tmp_284 = shaderCapableFace
        if __lux_tmp_284 then
          local __lux_tmp_283 = face ~= nil
          if not __lux_tmp_283 then
            local __lux_tmp_weightAdjust_281 = weightAdjust
            if __lux_tmp_weightAdjust_281 == nil then
              __lux_tmp_weightAdjust_281 = 0
            end
            local __lux_cmp_282 = false
            if __lux_module_1.mathAbs(__lux_tmp_weightAdjust_281) ~= nil then
              __lux_cmp_282 = __lux_module_1.mathAbs(__lux_tmp_weightAdjust_281) > 0.001
            end
            __lux_tmp_283 = __lux_cmp_282
          end
          __lux_tmp_284 = __lux_tmp_283
        end
        shaderFace = __lux_tmp_284
      end
      if not shaderFace and shaderCapableFace then
        shaderFace = shadow ~= nil or stroke ~= nil or glow ~= nil
      end
      local entry
      do
        local __lux_tmp_weightAdjust_285 = weightAdjust
        if __lux_tmp_weightAdjust_285 == nil then
          __lux_tmp_weightAdjust_285 = 0
        end
        entry = {
          page = page,
          slotX = slotX,
          slotY = slotY,
          atlasW = atlasW,
          atlasH = atlasH,
          w = atlasW / oversample,
          h = atlasH / oversample,
          originX = pad,
          originY = pad,
          contentW = layout.w,
          contentH = layout.h,
          oversample = oversample,
          shadow = shadow,
          stroke = stroke,
          glow = glow,
          face = face,
          weightAdjust = __lux_tmp_weightAdjust_285,
          shaderFace = shaderFace,
          generation = page.generation,
        }
      end
      __lux_module_1.composedCache[key] = entry
      __lux_module_1.composedCacheCount = __lux_module_1.composedCacheCount + 1
      do
        local __lux_tmp_stats_286 = stats
        if __lux_tmp_stats_286 == nil then
          __lux_tmp_stats_286 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_286, "textComposedBakes")
      end
      if stats ~= nil then
        stats.textComposedEntries = __lux_module_1.composedCacheCount
      end
      return entry
    end
    __lux_module_1.entryFor = function(record, stats, prewarm)
      if prewarm == nil then
        prewarm = false
      end
      if not __lux_module_1.textComposedEnabled() or not __lux_module_1.ensureTargets() then
        return nil
      end
      local textStyle = record.style
      if textStyle == nil then
        textStyle = {}
      end
      if textStyle.noComposed or textStyle.native == true then
        return nil
      end
      local info = __lux_module_1.effectInfo(textStyle)
      local key = record.__mgfxTextEntryKey
      if key == nil then
        key = __lux_module_1.fastEntryKey(record, textStyle, info)
      end
      record.__mgfxTextEntryKey = key
      __lux_module_1.composedTick = __lux_module_1.composedTick + 1
      local cached = __lux_module_1.composedCache[key]
      if cached ~= nil and cached.page ~= nil and cached.generation == cached.page.generation then
        cached.tick = __lux_module_1.composedTick
        do
          local __lux_tmp_stats_287 = stats
          if __lux_tmp_stats_287 == nil then
            __lux_tmp_stats_287 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_287, "textEntryCacheHits")
        end
        return cached
      end
      do
        local __lux_tmp_stats_288 = stats
        if __lux_tmp_stats_288 == nil then
          __lux_tmp_stats_288 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_288, "textEntryCacheMisses")
      end
      local layout = __lux_module_1.layoutFor(record.text, record.font, textStyle)
      __lux_module_1.bakesThisFrame = __lux_module_1.bakesThisFrame + 1
      local ok, entry = __lux_module_1.protectedCall(
        __lux_module_1.bakeEntry,
        record,
        key,
        layout,
        info.shadow,
        info.stroke,
        info.glow,
        info.face,
        info.weightAdjust,
        info.pad,
        info.gutter,
        stats
      )
      if not ok then
        __lux_module_1.atlasFailed = true
        if __lux_module_1.errorNoHaltWithStack ~= nil then
          __lux_module_1.errorNoHaltWithStack(
            "[MGFX] composed text bake failed: " .. __lux_module_1.toString(entry) .. "\n"
          )
        end
        return nil
      end
      return entry
    end
    __lux_module_1.recordHasShaderWork = function(record)
      local textStyle = record.style
      if textStyle == nil then
        textStyle = {}
      end
      local info = __lux_module_1.effectInfo(textStyle)
      local __lux_tmp_291 = info.shadow ~= nil or info.stroke ~= nil or info.glow ~= nil or info.face ~= nil
      if not __lux_tmp_291 then
        local __lux_tmp_weightAdjust_289 = info.weightAdjust
        if __lux_tmp_weightAdjust_289 == nil then
          __lux_tmp_weightAdjust_289 = 0
        end
        local __lux_cmp_290 = false
        if __lux_module_1.mathAbs(__lux_tmp_weightAdjust_289) ~= nil then
          __lux_cmp_290 = __lux_module_1.mathAbs(__lux_tmp_weightAdjust_289) > 0.001
        end
        __lux_tmp_291 = __lux_cmp_290
      end
      local __lux_tmp_292 = __lux_tmp_291
      if not __lux_tmp_292 then
        __lux_tmp_292 = __lux_module_1.fillNeedsShader(__lux_module_1.fillForRecord(record))
      end
      return __lux_tmp_292
    end
    __lux_module_1.recordNeedsComposedEntry = function(record)
      local textStyle = record.style
      if textStyle == nil then
        textStyle = {}
      end
      if textStyle.noComposed or textStyle.native == true then
        return false
      end
      return __lux_module_1.recordHasShaderWork(record)
    end
    __lux_module_1.prepareTextRoutes = function(records)
      local composeCount = 0
      do
        local __lux_tmp_records_293 = records
        if __lux_tmp_records_293 == nil then
          __lux_tmp_records_293 = {}
        end
        for _, record in ipairs(__lux_tmp_records_293) do
          if __lux_module_1.recordNeedsComposedEntry(record) then
            record.__mgfxTextRoute = "compose"
            composeCount = composeCount + 1
          else
            record.__mgfxTextRoute = "native"
          end
        end
      end
      return composeCount
    end
    __lux_module_1.prewarmFlushRecords = function(records, stats)
      if records == nil or #records <= 1 then
        return true
      end
      if not __lux_module_1.textComposedEnabled() or not __lux_module_1.ensureTargets() then
        do
          local __lux_tmp_stats_294 = stats
          if __lux_tmp_stats_294 == nil then
            __lux_tmp_stats_294 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_294, "textComposedPrewarmFails")
        end
        return false
      end
      for attempt = 1, 3 do
        local generation = __lux_module_1.atlasEpoch
        local restarted = false
        for _, record in ipairs(records) do
          if record.__mgfxTextRoute == "compose" then
            local entry = __lux_module_1.entryFor(record, stats, true)
            if entry == nil then
              do
                local __lux_tmp_stats_295 = stats
                if __lux_tmp_stats_295 == nil then
                  __lux_tmp_stats_295 = {}
                end
                __lux_module_1.statAdd(__lux_tmp_stats_295, "textComposedPrewarmFails")
              end
              return false
            end
            record.__mgfxTextEntry = entry
            if __lux_module_1.atlasEpoch ~= generation then
              do
                local __lux_tmp_stats_296 = stats
                if __lux_tmp_stats_296 == nil then
                  __lux_tmp_stats_296 = {}
                end
                __lux_module_1.statAdd(__lux_tmp_stats_296, "textComposedPrewarmRestarts")
              end
              restarted = true
              for _, stale in ipairs(records) do
                stale.__mgfxTextEntry = nil
              end
              break
            end
          end
        end
        if not restarted then
          return true
        end
      end
      do
        local __lux_tmp_stats_297 = stats
        if __lux_tmp_stats_297 == nil then
          __lux_tmp_stats_297 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_297, "textComposedPrewarmFails")
      end
      return false
    end
    __lux_module_1.hasShaderFx = function(entry)
      local __lux_tmp_300 = entry ~= nil
      if __lux_tmp_300 then
        local __lux_tmp_299 = entry.shadow ~= nil or entry.stroke ~= nil or entry.glow ~= nil or entry.face ~= nil
        if not __lux_tmp_299 then
          local __lux_tmp_weightAdjust_298 = entry.weightAdjust
          if __lux_tmp_weightAdjust_298 == nil then
            __lux_tmp_weightAdjust_298 = 0
          end
          __lux_tmp_299 = __lux_tmp_weightAdjust_298 ~= 0
        end
        __lux_tmp_300 = __lux_tmp_299
      end
      return __lux_tmp_300
    end
    __lux_module_1.scaledColor01 = function(effect, scale)
      if scale == nil then
        scale = 1
      end
      if effect == nil then
        return 0, 0, 0, 0
      end
      local r, g, b, a
      do
        local __lux_tmp_color_301 = effect.color
        if __lux_tmp_color_301 == nil then
          __lux_tmp_color_301 = __lux_module_1.white
        end
        r, g, b, a = __lux_module_1.style.color01(__lux_tmp_color_301)
      end
      return r, g, b, __lux_module_1.mathClamp(a * scale, 0, 1)
    end
    __lux_module_1.packShadowParams = function(x, y, stroke)
      do
        local __lux_tmp_x_302 = __lux_module_1.toNumber(x)
        if __lux_tmp_x_302 == nil then
          __lux_tmp_x_302 = 0
        end
        x = __lux_module_1.mathClamp(__lux_tmp_x_302, -64, 63.5)
      end
      do
        local __lux_tmp_y_303 = __lux_module_1.toNumber(y)
        if __lux_tmp_y_303 == nil then
          __lux_tmp_y_303 = 0
        end
        y = __lux_module_1.mathClamp(__lux_tmp_y_303, -64, 63.5)
      end
      local xb = __lux_module_1.mathClamp(__lux_module_1.mathFloor((x + 64) * 2 + 0.5), 0, 255)
      local yb = __lux_module_1.mathClamp(__lux_module_1.mathFloor((y + 64) * 2 + 0.5), 0, 255)
      local softness
      do
        local __lux_obj_stroke_304 = stroke
        local __lux_val_softness_305 = nil
        if __lux_obj_stroke_304 ~= nil then
          __lux_val_softness_305 = __lux_obj_stroke_304.softness
        end
        softness = __lux_val_softness_305
        if softness == nil then
          softness = 0
        end
      end
      local softByte = __lux_module_1.mathClamp(
        __lux_module_1.mathFloor(__lux_module_1.mathClamp(softness, 0, 1) * 255 + 0.5),
        0,
        255
      )
      return xb * 65536 + yb * 256 + softByte
    end
    __lux_module_1.packEffectParams = function(glow, shadow, face, weightAdjust, shaderFace)
      local blur
      do
        local __lux_obj_shadow_306 = shadow
        local __lux_val_blur_307 = nil
        if __lux_obj_shadow_306 ~= nil then
          __lux_val_blur_307 = __lux_obj_shadow_306.blur
        end
        blur = __lux_val_blur_307
        if blur == nil then
          blur = 0
        end
      end
      local falloff
      do
        local __lux_obj_glow_308 = glow
        local __lux_val_falloff_309 = nil
        if __lux_obj_glow_308 ~= nil then
          __lux_val_falloff_309 = __lux_obj_glow_308.falloff
        end
        falloff = __lux_val_falloff_309
        if falloff == nil then
          falloff = 1.65
        end
      end
      local faceStrength
      do
        local __lux_obj_face_310 = face
        local __lux_val_strength_311 = nil
        if __lux_obj_face_310 ~= nil then
          __lux_val_strength_311 = __lux_obj_face_310.strength
        end
        faceStrength = __lux_val_strength_311
        if faceStrength == nil then
          faceStrength = 0
        end
      end
      local weight
      do
        local __lux_tmp_weightAdjust_312 = __lux_module_1.toNumber(weightAdjust)
        if __lux_tmp_weightAdjust_312 == nil then
          __lux_tmp_weightAdjust_312 = 0
        end
        weight = __lux_module_1.mathClamp(__lux_tmp_weightAdjust_312, -2, 2)
      end
      local blurByte = __lux_module_1.mathClamp(
        __lux_module_1.mathFloor(__lux_module_1.mathClamp(blur, 0, 63.5) * 2 + 0.5),
        0,
        127
      )
      local falloffByte = __lux_module_1.mathClamp(
        __lux_module_1.mathFloor(__lux_module_1.mathClamp(falloff, 0.25, 7.875) * 8 + 0.5),
        0,
        63
      )
      local faceByte = 0
      if shaderFace then
        faceByte = 1 + __lux_module_1.mathClamp(
          __lux_module_1.mathFloor(__lux_module_1.mathClamp(faceStrength, 0, 1) * 30 + 0.5),
          0,
          30
        )
      end
      local weightByte = __lux_module_1.mathClamp(__lux_module_1.mathFloor((weight + 2) / 4 * 63 + 0.5), 0, 63)
      return blurByte * 131072 + falloffByte * 2048 + faceByte * 64 + weightByte
    end
    __lux_module_1.setupTextComposeMaterial = function(material, entry)
      local stroke = entry.stroke
      local glow = entry.glow
      local shadow = entry.shadow
      local face = entry.face
      local oversample = __lux_module_1.normalizeOversample(entry.oversample)
      local r, g, b, a = __lux_module_1.scaledColor01(stroke, 1)
      material:SetFloat("$c0_x", r)
      material:SetFloat("$c0_y", g)
      material:SetFloat("$c0_z", b)
      material:SetFloat("$c0_w", a)
      do
        local __lux_obj_glow_313 = glow
        local __lux_tmp_strength_314 = nil
        if __lux_obj_glow_313 ~= nil then
          __lux_tmp_strength_314 = __lux_obj_glow_313.strength
        end
        if __lux_tmp_strength_314 == nil then
          __lux_tmp_strength_314 = 1
        end
        r, g, b, a = __lux_module_1.scaledColor01(glow, __lux_tmp_strength_314)
      end
      material:SetFloat("$c1_x", r)
      material:SetFloat("$c1_y", g)
      material:SetFloat("$c1_z", b)
      material:SetFloat("$c1_w", a)
      do
        local __lux_obj_shadow_315 = shadow
        local __lux_tmp_strength_316 = nil
        if __lux_obj_shadow_315 ~= nil then
          __lux_tmp_strength_316 = __lux_obj_shadow_315.strength
        end
        if __lux_tmp_strength_316 == nil then
          __lux_tmp_strength_316 = 1
        end
        r, g, b, a = __lux_module_1.scaledColor01(shadow, __lux_tmp_strength_316)
      end
      material:SetFloat("$c2_x", r)
      material:SetFloat("$c2_y", g)
      material:SetFloat("$c2_z", b)
      material:SetFloat("$c2_w", a)
      local scaledStroke
      if stroke ~= nil then
        scaledStroke = { width = stroke.width * oversample, softness = stroke.softness }
      else
        scaledStroke = nil
      end
      local scaledShadow
      if shadow ~= nil then
        scaledShadow = {
          x = shadow.x * oversample,
          y = shadow.y * oversample,
          blur = shadow.blur * oversample,
        }
      else
        scaledShadow = nil
      end
      do
        local __lux_obj_scaledStroke_317 = scaledStroke
        local __lux_tmp_width_318 = nil
        if __lux_obj_scaledStroke_317 ~= nil then
          __lux_tmp_width_318 = __lux_obj_scaledStroke_317.width
        end
        if __lux_tmp_width_318 == nil then
          __lux_tmp_width_318 = 0
        end
        material:SetFloat("$c3_x", __lux_tmp_width_318)
      end
      do
        local __lux_tmp_319
        if glow ~= nil then
          __lux_tmp_319 = glow.width * oversample
        else
          __lux_tmp_319 = 0
        end
        material:SetFloat("$c3_y", __lux_tmp_319)
      end
      do
        local __lux_tmp_weightAdjust_320 = entry.weightAdjust
        if __lux_tmp_weightAdjust_320 == nil then
          __lux_tmp_weightAdjust_320 = 0
        end
        material:SetFloat(
          "$c3_z",
          __lux_module_1.packEffectParams(
            glow,
            scaledShadow,
            face,
            __lux_tmp_weightAdjust_320 * oversample,
            entry.shaderFace
          )
        )
      end
      local __lux_tmp_321
      if scaledShadow ~= nil then
        __lux_tmp_321 = __lux_module_1.packShadowParams(scaledShadow.x, scaledShadow.y, scaledStroke)
      else
        __lux_tmp_321 = __lux_module_1.packShadowParams(0, 0, scaledStroke)
      end
      return material:SetFloat("$c3_w", __lux_tmp_321)
    end
    __lux_module_1.fillEndpointColors = function(fill, fallback)
      if __lux_module_1.isColorValue(fill) then
        return fill, fill
      end
      if __lux_module_1.typeOf(fill) == "table" and __lux_module_1.typeOf(fill.stops) == "table" and #fill.stops > 0 then
        local first = fill.stops[1]
        local last = fill.stops[#fill.stops]
        local __lux_tmp_color_322 = first.color
        if __lux_tmp_color_322 == nil then
          __lux_tmp_color_322 = first[2]
        end
        local __lux_tmp_fallback_323 = fallback
        if __lux_tmp_fallback_323 == nil then
          __lux_tmp_fallback_323 = __lux_module_1.white
        end
        local __lux_tmp_color_324 = last.color
        if __lux_tmp_color_324 == nil then
          __lux_tmp_color_324 = last[2]
        end
        local __lux_tmp_fallback_325 = fallback
        if __lux_tmp_fallback_325 == nil then
          __lux_tmp_fallback_325 = __lux_module_1.white
        end
        return __lux_module_1.style.asColor(__lux_tmp_color_322, __lux_tmp_fallback_323), __lux_module_1.style.asColor(__lux_tmp_color_324, __lux_tmp_fallback_325)
      end
      if __lux_module_1.typeOf(fill) == "table" then
        local a
        do
          local __lux_tmp_colorA_326 = fill.colorA
          if __lux_tmp_colorA_326 == nil then
            __lux_tmp_colorA_326 = fill[1]
          end
          local __lux_tmp_fallback_327 = fallback
          if __lux_tmp_fallback_327 == nil then
            __lux_tmp_fallback_327 = __lux_module_1.white
          end
          a = __lux_module_1.style.asColor(__lux_tmp_colorA_326, __lux_tmp_fallback_327)
        end
        local __lux_tmp_colorB_328 = fill.colorB
        if __lux_tmp_colorB_328 == nil then
          __lux_tmp_colorB_328 = fill[2]
        end
        return a, __lux_module_1.style.asColor(__lux_tmp_colorB_328, a)
      end
      local c
      do
        local __lux_tmp_fallback_329 = fallback
        if __lux_tmp_fallback_329 == nil then
          __lux_tmp_fallback_329 = __lux_module_1.white
        end
        c = __lux_module_1.style.asColor(fill, __lux_tmp_fallback_329)
      end
      return c, c
    end
    __lux_module_1.setupTextFaceMaterial = function(material, entry, record, u0, v0, u1, v1, fillOverride)
      local fill = fillOverride
      if fill == nil then
        fill = __lux_module_1.fillForRecord(record)
      end
      local colorA, colorB
      do
        local __lux_tmp_color_330 = record.color
        if __lux_tmp_color_330 == nil then
          __lux_tmp_color_330 = __lux_module_1.white
        end
        colorA, colorB = __lux_module_1.fillEndpointColors(fill, __lux_tmp_color_330)
      end
      local r, g, b, a = __lux_module_1.style.color01(colorA)
      material:SetTexture("$basetexture", entry.page.rt)
      local lut = __lux_module_1.gradientLutForFill(fill)
      if lut ~= nil then
        material:SetTexture("$texture1", lut)
      end
      material:SetFloat("$c0_x", u0)
      material:SetFloat("$c0_y", v0)
      material:SetFloat("$c0_z", u1)
      material:SetFloat("$c0_w", v1)
      material:SetFloat("$c1_x", r)
      material:SetFloat("$c1_y", g)
      material:SetFloat("$c1_z", b)
      material:SetFloat("$c1_w", a)
      r, g, b, a = __lux_module_1.style.color01(colorB)
      material:SetFloat("$c2_x", r)
      material:SetFloat("$c2_y", g)
      material:SetFloat("$c2_z", b)
      material:SetFloat("$c2_w", a)
      if __lux_module_1.typeOf(fill) == "table" and fill.kind == 1 then
        do
          local __lux_tmp_x1_331 = __lux_module_1.toNumber(fill.x1)
          if __lux_tmp_x1_331 == nil then
            __lux_tmp_x1_331 = 0
          end
          material:SetFloat("$c3_x", __lux_tmp_x1_331)
        end
        do
          local __lux_tmp_y1_332 = __lux_module_1.toNumber(fill.y1)
          if __lux_tmp_y1_332 == nil then
            __lux_tmp_y1_332 = 0
          end
          material:SetFloat("$c3_y", __lux_tmp_y1_332)
        end
        do
          local __lux_tmp_x2_333 = __lux_module_1.toNumber(fill.x2)
          if __lux_tmp_x2_333 == nil then
            __lux_tmp_x2_333 = 1
          end
          material:SetFloat("$c3_z", __lux_tmp_x2_333)
        end
        local __lux_tmp_y2_334 = __lux_module_1.toNumber(fill.y2)
        if __lux_tmp_y2_334 == nil then
          __lux_tmp_y2_334 = 0
        end
        return material:SetFloat("$c3_w", __lux_tmp_y2_334)
      else
        material:SetFloat("$c3_x", 0)
        material:SetFloat("$c3_y", 0)
        material:SetFloat("$c3_z", 1)
        return material:SetFloat("$c3_w", 0)
      end
    end
    __lux_module_1.drawEntryAt = function(entry, record, contentX, contentY, fillOverride, stats)
      local page
      do
        local __lux_obj_entry_335 = entry
        local __lux_val_page_336 = nil
        if __lux_obj_entry_335 ~= nil then
          __lux_val_page_336 = __lux_obj_entry_335.page
        end
        page = __lux_val_page_336
        if page == nil then
          page = __lux_module_1.atlas
        end
      end
      if page == nil or entry.generation ~= page.generation then
        return nil
      end
      local x = contentX - entry.originX
      local y = contentY - entry.originY
      x, y = __lux_module_1.snapTextPos(x, y, record.style)
      local u0 = entry.slotX / page.w
      local v0 = entry.slotY / page.h
      local u1
      do
        local __lux_tmp_atlasW_337 = entry.atlasW
        if __lux_tmp_atlasW_337 == nil then
          __lux_tmp_atlasW_337 = entry.w
        end
        u1 = (entry.slotX + __lux_tmp_atlasW_337) / page.w
      end
      local v1
      do
        local __lux_tmp_atlasH_338 = entry.atlasH
        if __lux_tmp_atlasH_338 == nil then
          __lux_tmp_atlasH_338 = entry.h
        end
        v1 = (entry.slotY + __lux_tmp_atlasH_338) / page.h
      end
      local fx = __lux_module_1.hasShaderFx(entry)
      local faceMat = __lux_module_1.isMaterialOK(page.faceMat) and page.faceMat or __lux_module_1.isMaterialOK(__lux_module_1.materials.text_face) and __lux_module_1.materials.text_face or page.material or __lux_module_1.atlasMat
      local composeMat = __lux_module_1.isMaterialOK(page.composeMat) and page.composeMat or __lux_module_1.materials.text_compose
      local material = fx and composeMat or faceMat
      if fx and __lux_module_1.isMaterialOK(material) then
        material:SetTexture("$basetexture", page.rt)
        __lux_module_1.setupTextComposeMaterial(material, entry)
      else
        if fx then
          return nil
        else
          if faceMat ~= nil then
            __lux_module_1.setupTextFaceMaterial(
              faceMat,
              entry,
              record,
              u0,
              v0,
              u1,
              v1,
              fillOverride
            )
            material = faceMat
          end
        end
      end
      local drawColor = __lux_module_1.white
      if fx and entry.shaderFace then
        do
          local __lux_tmp_fillOverride_339 = fillOverride
          if __lux_tmp_fillOverride_339 == nil then
            __lux_tmp_fillOverride_339 = __lux_module_1.fillForRecord(record)
          end
          local __lux_tmp_color_340 = record.color
          if __lux_tmp_color_340 == nil then
            __lux_tmp_color_340 = __lux_module_1.white
          end
          drawColor = __lux_module_1.style.asColor(__lux_tmp_fillOverride_339, __lux_tmp_color_340)
        end
      end
      if not __lux_module_1.drawUV(material, x, y, entry.w, entry.h, u0, v0, u1, v1, drawColor) then
        return nil
      end
      local blits = 1
      if fx and not entry.shaderFace and faceMat ~= nil then
        __lux_module_1.setupTextFaceMaterial(
          faceMat,
          entry,
          record,
          u0,
          v0,
          u1,
          v1,
          fillOverride
        )
        __lux_module_1.drawUV(
          faceMat,
          x,
          y,
          entry.w,
          entry.h,
          u0,
          v0,
          u1,
          v1,
          __lux_module_1.white
        )
        blits = blits + 1
      end
      do
        local __lux_tmp_stats_341 = stats
        if __lux_tmp_stats_341 == nil then
          __lux_tmp_stats_341 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_341, "textComposedBlits", blits)
      end
      if fx then
        do
          local __lux_tmp_stats_342 = stats
          if __lux_tmp_stats_342 == nil then
            __lux_tmp_stats_342 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_342, "textShaderDraws")
        end
      end
      return fx
    end
    __lux_module_1.blitEntry = function(entry, record, stats)
      local contentX
      do
        local __lux_tmp_x_343 = record.x
        if __lux_tmp_x_343 == nil then
          __lux_tmp_x_343 = 0
        end
        contentX = __lux_tmp_x_343 - entry.contentW * __lux_module_1.alignFactor(record.alignX)
      end
      local contentY
      do
        local __lux_tmp_y_344 = record.y
        if __lux_tmp_y_344 == nil then
          __lux_tmp_y_344 = 0
        end
        contentY = __lux_tmp_y_344 - entry.contentH * __lux_module_1.alignFactor(record.alignY, true)
      end
      local fx = __lux_module_1.drawEntryAt(entry, record, contentX, contentY, nil, stats)
      if fx == nil then
        local refreshed = __lux_module_1.entryFor(record, stats, false)
        if refreshed == nil then
          return nil
        end
        fx = __lux_module_1.drawEntryAt(refreshed, record, contentX, contentY, nil, stats)
        if fx == nil then
          return nil
        end
      end
      do
        local __lux_tmp_stats_345 = stats
        if __lux_tmp_stats_345 == nil then
          __lux_tmp_stats_345 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_345, "textComposedDraws")
      end
      if fx then
        do
          local __lux_tmp_stats_346 = stats
          if __lux_tmp_stats_346 == nil then
            __lux_tmp_stats_346 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_346, "textComposedFxDraws")
        end
      else
        do
          local __lux_tmp_stats_347 = stats
          if __lux_tmp_stats_347 == nil then
            __lux_tmp_stats_347 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_347, "textComposedFaceDraws")
        end
      end
      return fx
    end
    __lux_module_1.textBatchKey = function(entry, record)
      local page
      do
        local __lux_obj_entry_348 = entry
        local __lux_val_page_349 = nil
        if __lux_obj_entry_348 ~= nil then
          __lux_val_page_349 = __lux_obj_entry_348.page
        end
        page = __lux_val_page_349
      end
      if page == nil then
        return nil
      end
      local fx = __lux_module_1.hasShaderFx(entry)
      if not fx then
        local fill = __lux_module_1.fillForRecord(record)
        if __lux_module_1.fillNeedsShader(fill) then
          return nil
        end
        local __lux_tmp_index_350 = page.index
        if __lux_tmp_index_350 == nil then
          __lux_tmp_index_350 = 0
        end
        return "plain27" .. __lux_module_1.toString(__lux_tmp_index_350)
      end
      if not entry.shaderFace then
        return nil
      end
      if entry.batchKey ~= nil then
        return entry.batchKey
      end
      do
        local __lux_tmp_index_351 = page.index
        if __lux_tmp_index_351 == nil then
          __lux_tmp_index_351 = 0
        end
        local __lux_tmp_oversample_352 = entry.oversample
        if __lux_tmp_oversample_352 == nil then
          __lux_tmp_oversample_352 = 1
        end
        local __lux_tmp_353
        if entry.stroke ~= nil then
          __lux_tmp_353 = entry.stroke.width ..
            ":" .. entry.stroke.softness .. ":" .. __lux_module_1.colorKey(entry.stroke.color)
        else
          __lux_tmp_353 = ""
        end
        local __lux_tmp_354
        if entry.glow ~= nil then
          do
            local __lux_tmp_falloff_355 = entry.glow.falloff
            if __lux_tmp_falloff_355 == nil then
              __lux_tmp_falloff_355 = ""
            end
            __lux_tmp_354 = entry.glow.width ..
              ":" ..
                entry.glow.strength ..
                  ":" .. __lux_tmp_falloff_355 .. ":" .. __lux_module_1.colorKey(entry.glow.color)
          end
        else
          __lux_tmp_354 = ""
        end
        local __lux_tmp_356
        if entry.shadow ~= nil then
          __lux_tmp_356 = entry.shadow.x ..
            ":" ..
              entry.shadow.y ..
                ":" ..
                  entry.shadow.blur ..
                    ":" .. entry.shadow.strength .. ":" .. __lux_module_1.colorKey(entry.shadow.color)
        else
          __lux_tmp_356 = ""
        end
        local __lux_tmp_357
        if entry.face ~= nil then
          __lux_tmp_357 = __lux_module_1.toString(entry.face.strength)
        else
          __lux_tmp_357 = ""
        end
        local __lux_tmp_weightAdjust_358 = entry.weightAdjust
        if __lux_tmp_weightAdjust_358 == nil then
          __lux_tmp_weightAdjust_358 = 0
        end
        entry.batchKey = __lux_module_1.tableConcat(
          {
            __lux_tmp_index_351,
            __lux_tmp_oversample_352,
            __lux_tmp_353,
            __lux_tmp_354,
            __lux_tmp_356,
            __lux_tmp_357,
            __lux_module_1.toString(__lux_tmp_weightAdjust_358),
          },
          "27"
        )
      end
      return entry.batchKey
    end
    __lux_module_1.meshVertex = function(x, y, u, v, color)
      if __lux_module_1.textBatchVertex == nil then
        return
      end
      __lux_module_1.textBatchVertex.x = x
      __lux_module_1.textBatchVertex.y = y
      __lux_module_1.textBatchVertex.z = 0
      __lux_module_1.meshPosition(__lux_module_1.textBatchVertex)
      do
        local __lux_tmp_r_359 = color.r
        if __lux_tmp_r_359 == nil then
          __lux_tmp_r_359 = 255
        end
        local __lux_tmp_g_360 = color.g
        if __lux_tmp_g_360 == nil then
          __lux_tmp_g_360 = 255
        end
        local __lux_tmp_b_361 = color.b
        if __lux_tmp_b_361 == nil then
          __lux_tmp_b_361 = 255
        end
        local __lux_tmp_a_362 = color.a
        if __lux_tmp_a_362 == nil then
          __lux_tmp_a_362 = 255
        end
        __lux_module_1.meshColor(
          __lux_tmp_r_359,
          __lux_tmp_g_360,
          __lux_tmp_b_361,
          __lux_tmp_a_362
        )
      end
      __lux_module_1.meshTexCoord(0, u, v)
      return __lux_module_1.meshAdvanceVertex()
    end
    __lux_module_1.meshQuad = function(record)
      local entry = record.__mgfxTextEntry
      local page = entry.page
      local x = record.__mgfxBatchX
      local y = record.__mgfxBatchY
      local w = entry.w
      local h = entry.h
      local u0 = entry.slotX / page.w
      local v0 = entry.slotY / page.h
      local u1
      do
        local __lux_tmp_atlasW_363 = entry.atlasW
        if __lux_tmp_atlasW_363 == nil then
          __lux_tmp_atlasW_363 = entry.w
        end
        u1 = (entry.slotX + __lux_tmp_atlasW_363) / page.w
      end
      local v1
      do
        local __lux_tmp_atlasH_364 = entry.atlasH
        if __lux_tmp_atlasH_364 == nil then
          __lux_tmp_atlasH_364 = entry.h
        end
        v1 = (entry.slotY + __lux_tmp_atlasH_364) / page.h
      end
      local c = record.__mgfxBatchColor
      if c == nil then
        c = __lux_module_1.white
      end
      __lux_module_1.meshVertex(x, y, u0, v0, c)
      __lux_module_1.meshVertex(x + w, y, u1, v0, c)
      __lux_module_1.meshVertex(x + w, y + h, u1, v1, c)
      __lux_module_1.meshVertex(x, y, u0, v0, c)
      __lux_module_1.meshVertex(x + w, y + h, u1, v1, c)
      return __lux_module_1.meshVertex(x, y + h, u0, v1, c)
    end
    __lux_module_1.flushTextComposeBatch = function(batch, stats)
      if batch == nil or #batch == 0 then
        return false
      end
      if #batch == 1 then
        local record = batch[1]
        local fx = __lux_module_1.drawEntryAt(
          record.__mgfxTextEntry,
          record,
          record.__mgfxContentX,
          record.__mgfxContentY,
          record.__mgfxBatchColor,
          stats
        )
        if fx == nil then
          local entry = __lux_module_1.entryFor(record, stats, false)
          if entry == nil then
            return false
          end
          fx = __lux_module_1.drawEntryAt(
            entry,
            record,
            record.__mgfxContentX,
            record.__mgfxContentY,
            record.__mgfxBatchColor,
            stats
          )
          if fx == nil then
            return false
          end
        end
        do
          local __lux_tmp_stats_365 = stats
          if __lux_tmp_stats_365 == nil then
            __lux_tmp_stats_365 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_365, "textComposedDraws")
        end
        do
          local __lux_tmp_stats_366 = stats
          if __lux_tmp_stats_366 == nil then
            __lux_tmp_stats_366 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_366, "textComposedFxDraws")
        end
        return true
      end
      local first = batch[1]
      local firstEntry = first.__mgfxTextEntry
      for index = 1, #batch do
        local entry = batch[index].__mgfxTextEntry
        if entry == nil or entry.page == nil or entry.generation ~= entry.page.generation then
          for _, record in ipairs(batch) do
            local refreshed = __lux_module_1.entryFor(record, stats, false)
            if refreshed ~= nil then
              __lux_module_1.blitEntry(refreshed, record, stats)
            end
          end
          return false
        end
      end
      local fx = __lux_module_1.hasShaderFx(firstEntry)
      local material
      if fx then
        material = __lux_module_1.isMaterialOK(firstEntry.page.composeMat) and firstEntry.page.composeMat or __lux_module_1.materials.text_compose
      else
        do
          local __lux_obj_page_367 = firstEntry.page
          local __lux_val_material_368 = nil
          if __lux_obj_page_367 ~= nil then
            __lux_val_material_368 = __lux_obj_page_367.material
          end
          material = __lux_val_material_368
          if material == nil then
            material = __lux_module_1.atlasMat
          end
        end
      end
      if not __lux_module_1.isMaterialOK(material) or __lux_module_1.renderSetMaterial == nil or __lux_module_1.meshBegin == nil or __lux_module_1.meshEnd == nil or __lux_module_1.textBatchVertex == nil then
        for _, record in ipairs(batch) do
          __lux_module_1.blitEntry(record.__mgfxTextEntry, record, stats)
        end
        return false
      end
      if fx then
        material:SetTexture("$basetexture", firstEntry.page.rt)
        __lux_module_1.setupTextComposeMaterial(material, firstEntry)
      end
      __lux_module_1.renderSetMaterial(material)
      __lux_module_1.meshBegin(MATERIAL_TRIANGLES, #batch * 2)
      for _, record in ipairs(batch) do
        __lux_module_1.meshQuad(record)
      end
      __lux_module_1.meshEnd()
      do
        local __lux_tmp_stats_369 = stats
        if __lux_tmp_stats_369 == nil then
          __lux_tmp_stats_369 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_369, "textComposedBlits", #batch)
      end
      do
        local __lux_tmp_stats_370 = stats
        if __lux_tmp_stats_370 == nil then
          __lux_tmp_stats_370 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_370, "textComposedDraws", #batch)
      end
      if fx then
        do
          local __lux_tmp_stats_371 = stats
          if __lux_tmp_stats_371 == nil then
            __lux_tmp_stats_371 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_371, "textShaderDraws")
        end
        do
          local __lux_tmp_stats_372 = stats
          if __lux_tmp_stats_372 == nil then
            __lux_tmp_stats_372 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_372, "textComposedFxDraws", #batch)
        end
      else
        do
          local __lux_tmp_stats_373 = stats
          if __lux_tmp_stats_373 == nil then
            __lux_tmp_stats_373 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_373, "textComposedFaceDraws", #batch)
        end
      end
      do
        local __lux_tmp_stats_374 = stats
        if __lux_tmp_stats_374 == nil then
          __lux_tmp_stats_374 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_374, "textComposedBatchDraws")
      end
      do
        local __lux_tmp_stats_375 = stats
        if __lux_tmp_stats_375 == nil then
          __lux_tmp_stats_375 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_375, "textComposedBatchedRecords", #batch)
      end
      return true
    end
    __lux_module_1.queueTextComposeBatch = function(batches, order, entry, record)
      local key = __lux_module_1.textBatchKey(entry, record)
      if key == nil or not __lux_module_1.isMaterialOK(__lux_module_1.materials.text_compose) then
        return false
      end
      local contentX
      do
        local __lux_tmp_x_376 = record.x
        if __lux_tmp_x_376 == nil then
          __lux_tmp_x_376 = 0
        end
        contentX = __lux_tmp_x_376 - entry.contentW * __lux_module_1.alignFactor(record.alignX)
      end
      local contentY
      do
        local __lux_tmp_y_377 = record.y
        if __lux_tmp_y_377 == nil then
          __lux_tmp_y_377 = 0
        end
        contentY = __lux_tmp_y_377 - entry.contentH * __lux_module_1.alignFactor(record.alignY, true)
      end
      local x = contentX - entry.originX
      local y = contentY - entry.originY
      x, y = __lux_module_1.snapTextPos(x, y, record.style)
      local color
      do
        local __lux_tmp_color_378 = record.color
        if __lux_tmp_color_378 == nil then
          __lux_tmp_color_378 = __lux_module_1.white
        end
        color = __lux_module_1.style.asColor(__lux_module_1.fillForRecord(record), __lux_tmp_color_378)
      end
      record.__mgfxTextEntry = entry
      record.__mgfxContentX = contentX
      record.__mgfxContentY = contentY
      record.__mgfxBatchX = x
      record.__mgfxBatchY = y
      record.__mgfxBatchColor = color
      local batch = batches[key]
      if batch == nil then
        batch = {}
        batches[key] = batch
        order[#order + 1] = batch
      end
      batch[#batch + 1] = record
      return true
    end
    __lux_module_1.flushQueuedTextBatches = function(batches, order, stats)
      if order == nil or #order == 0 then
        return 0
      end
      for _, batch in ipairs(order) do
        __lux_module_1.flushTextComposeBatch(batch, stats)
      end
      local count = #order
      __lux_module_1.clearTable(batches)
      __lux_module_1.clearTable(order)
      return count
    end
    __lux_module_1.flushTextRecords = function(records, stats)
      if __lux_module_1.atlasNeedsReset then
        __lux_module_1.atlasNeedsReset = false
        do
          local __lux_tmp_stats_379 = stats
          if __lux_tmp_stats_379 == nil then
            __lux_tmp_stats_379 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_379, "textComposedEvicts")
        end
        __lux_module_1.clearComposedCache()
        do
          local __lux_tmp_records_380 = records
          if __lux_tmp_records_380 == nil then
            __lux_tmp_records_380 = {}
          end
          for _, record in ipairs(__lux_tmp_records_380) do
            record.__mgfxTextEntry = nil
          end
        end
      end
      __lux_module_1.bakesThisFrame = 0
      local composeRequested = __lux_module_1.prepareTextRoutes(records)
      do
        local __lux_tmp_stats_381 = stats
        if __lux_tmp_stats_381 == nil then
          __lux_tmp_stats_381 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_381, "textComposedRequests", composeRequested)
      end
      if composeRequested > 0 then
        do
          local __lux_tmp_stats_382 = stats
          if __lux_tmp_stats_382 == nil then
            __lux_tmp_stats_382 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_382, "textComposedBatches")
        end
      end
      local composerReady = composeRequested <= 0 or __lux_module_1.prewarmFlushRecords(records, stats)
      if composeRequested > 0 then
        if composerReady then
          do
            local __lux_tmp_stats_383 = stats
            if __lux_tmp_stats_383 == nil then
              __lux_tmp_stats_383 = {}
            end
            __lux_module_1.statAdd(__lux_tmp_stats_383, "textComposedReadyBatches")
          end
        end
      end
      local batches = {}
      local order = {}
      do
        local __lux_tmp_records_384 = records
        if __lux_tmp_records_384 == nil then
          __lux_tmp_records_384 = {}
        end
        for _, record in ipairs(__lux_tmp_records_384) do
          do
            local __lux_tmp_stats_385 = stats
            if __lux_tmp_stats_385 == nil then
              __lux_tmp_stats_385 = {}
            end
            __lux_module_1.statAdd(__lux_tmp_stats_385, "textDraws")
          end
          local route = record.__mgfxTextRoute
          if route == "native" then
            __lux_module_1.flushQueuedTextBatches(batches, order, stats)
            do
              local __lux_tmp_stats_386 = stats
              if __lux_tmp_stats_386 == nil then
                __lux_tmp_stats_386 = {}
              end
              __lux_module_1.statAdd(__lux_tmp_stats_386, "textNativeDraws")
            end
            __lux_module_1.drawNativePlainRecord(record)
          else
            local entry = record.__mgfxTextEntry
            if not (entry ~= nil and entry.page ~= nil and entry.generation == entry.page.generation) then
              entry = __lux_module_1.entryFor(record, stats, false)
            end
            if entry ~= nil then
              if composerReady and __lux_module_1.queueTextComposeBatch(batches, order, entry, record) then
              else
                __lux_module_1.flushQueuedTextBatches(batches, order, stats)
                __lux_module_1.blitEntry(entry, record, stats)
              end
            end
          end
        end
      end
      __lux_module_1.flushQueuedTextBatches(batches, order, stats)
      if stats ~= nil then
        stats.textComposedEntries = __lux_module_1.composedCacheCount
        stats.textCacheSize = __lux_module_1.measureOrderCount
      end
      return records
    end
  end
  do
    __lux_module_1.createTextRenderer = function(deps)
      if deps == nil then
        deps = {}
      end
      __lux_module_1.configureTextRenderer(deps)
      local owner = deps.M
      if owner == nil then
        owner = deps.owner
        if owner == nil then
          owner = {}
        end
      end
      local stats = deps.stats
      if stats == nil then
        stats = owner.stats
        if stats == nil then
          stats = {}
        end
      end
      owner.stats = stats
      local renderer = {}
      local styleStack = {}
      local immediateRecordBatch = {}
      __lux_module_1.resetRendererFrameStats(stats)
      renderer.RegisterFont = function(fontName, spec)
        local __lux_tmp_spec_387 = spec
        if __lux_tmp_spec_387 == nil then
          __lux_tmp_spec_387 = {}
        end
        return __lux_module_1.registerFont(fontName, __lux_tmp_spec_387)
      end
      renderer.DefineStyle = function(name, textStyle)
        if name == nil then
          return nil
        end
        local __lux_tmp_textStyle_388 = textStyle
        if __lux_tmp_textStyle_388 == nil then
          __lux_tmp_textStyle_388 = {}
        end
        return __lux_module_1.defineStyle(
          __lux_module_1.toString(name),
          renderer.ResolveStyle(__lux_tmp_textStyle_388)
        )
      end
      renderer.GetStyle = function(name)
        local __lux_tmp_name_389 = name
        if __lux_tmp_name_389 == nil then
          __lux_tmp_name_389 = ""
        end
        return __lux_module_1.getStyle(__lux_module_1.toString(__lux_tmp_name_389))
      end
      renderer.PushStyle = function(textStyle)
        do
          local __lux_tmp_textStyle_390 = textStyle
          if __lux_tmp_textStyle_390 == nil then
            __lux_tmp_textStyle_390 = {}
          end
          styleStack[#styleStack + 1] = renderer.ResolveStyle(__lux_tmp_textStyle_390)
        end
        return #styleStack
      end
      renderer.PopStyle = function()
        if #styleStack == 0 then
          return false
        end
        styleStack[#styleStack] = nil
        return true
      end
      renderer.ResolveStyle = function(textStyle)
        if __lux_module_1.typeOf(textStyle) == "table" and textStyle[__lux_module_1.RESOLVED_STYLE_MARK] == true then
          return __lux_module_1.tableCopy(textStyle)
        end
        local resolved = {}
        for index = 1, #styleStack do
          __lux_module_1.copyStyleInto(resolved, styleStack[index])
        end
        do
          local __lux_tmp_textStyle_391 = textStyle
          if __lux_tmp_textStyle_391 == nil then
            __lux_tmp_textStyle_391 = {}
          end
          __lux_module_1.copyStyleInto(resolved, __lux_tmp_textStyle_391)
        end
        resolved[__lux_module_1.RESOLVED_STYLE_MARK] = true
        return resolved
      end
      renderer.MakeRecord = function(value, font, x, y, color, ax, ay, textStyle)
        local resolved
        do
          local __lux_tmp_textStyle_392 = textStyle
          if __lux_tmp_textStyle_392 == nil then
            __lux_tmp_textStyle_392 = {}
          end
          resolved = renderer.ResolveStyle(__lux_tmp_textStyle_392)
        end
        local __lux_tmp_value_393 = value
        if __lux_tmp_value_393 == nil then
          __lux_tmp_value_393 = ""
        end
        local __lux_tmp_font_394 = resolved.font
        if __lux_tmp_font_394 == nil then
          __lux_tmp_font_394 = font
        end
        if __lux_tmp_font_394 == nil then
          __lux_tmp_font_394 = "DermaDefault"
        end
        local __lux_tmp_x_395 = __lux_module_1.toNumber(x)
        if __lux_tmp_x_395 == nil then
          __lux_tmp_x_395 = 0
        end
        local __lux_tmp_y_396 = __lux_module_1.toNumber(y)
        if __lux_tmp_y_396 == nil then
          __lux_tmp_y_396 = 0
        end
        local __lux_tmp_397
        if __lux_module_1.style.asColor ~= nil then
          do
            local __lux_tmp_color_398 = color
            if __lux_tmp_color_398 == nil then
              __lux_tmp_color_398 = resolved.color
            end
            if __lux_tmp_color_398 == nil then
              __lux_tmp_color_398 = resolved.fill
            end
            __lux_tmp_397 = __lux_module_1.style.asColor(__lux_tmp_color_398, __lux_module_1.white)
          end
        else
          do
            local __lux_tmp_color_399 = color
            if __lux_tmp_color_399 == nil then
              __lux_tmp_color_399 = resolved.color
            end
            if __lux_tmp_color_399 == nil then
              __lux_tmp_color_399 = resolved.fill
            end
            __lux_tmp_397 = __lux_module_1.style.colorOr(__lux_tmp_color_399, __lux_module_1.white)
          end
        end
        local __lux_tmp_alignX_400 = resolved.alignX
        if __lux_tmp_alignX_400 == nil then
          __lux_tmp_alignX_400 = resolved.align
        end
        if __lux_tmp_alignX_400 == nil then
          __lux_tmp_alignX_400 = ax
        end
        if __lux_tmp_alignX_400 == nil then
          __lux_tmp_alignX_400 = TEXT_ALIGN_LEFT
        end
        local __lux_tmp_alignY_401 = resolved.alignY
        if __lux_tmp_alignY_401 == nil then
          __lux_tmp_alignY_401 = resolved.valign
        end
        if __lux_tmp_alignY_401 == nil then
          __lux_tmp_alignY_401 = ay
        end
        if __lux_tmp_alignY_401 == nil then
          __lux_tmp_alignY_401 = TEXT_ALIGN_TOP
        end
        return {
          text = __lux_module_1.toString(__lux_tmp_value_393),
          font = __lux_tmp_font_394,
          x = __lux_tmp_x_395,
          y = __lux_tmp_y_396,
          color = __lux_tmp_397,
          alignX = __lux_tmp_alignX_400,
          alignY = __lux_tmp_alignY_401,
          style = resolved,
        }
      end
      renderer.NormalizeRecord = function(record)
        if record == nil then
          return nil
        end
        local resolved
        do
          local __lux_tmp_style_402 = record.style
          if __lux_tmp_style_402 == nil then
            __lux_tmp_style_402 = {}
          end
          resolved = renderer.ResolveStyle(__lux_tmp_style_402)
        end
        do
          local __lux_tmp_text_403 = record.text
          if __lux_tmp_text_403 == nil then
            __lux_tmp_text_403 = record.value
          end
          if __lux_tmp_text_403 == nil then
            __lux_tmp_text_403 = ""
          end
          record.text = __lux_module_1.toString(__lux_tmp_text_403)
        end
        do
          local __lux_tmp_font_404 = resolved.font
          if __lux_tmp_font_404 == nil then
            __lux_tmp_font_404 = record.font
          end
          if __lux_tmp_font_404 == nil then
            __lux_tmp_font_404 = "DermaDefault"
          end
          record.font = __lux_tmp_font_404
        end
        do
          local __lux_tmp_x_405 = __lux_module_1.toNumber(record.x)
          if __lux_tmp_x_405 == nil then
            __lux_tmp_x_405 = 0
          end
          record.x = __lux_tmp_x_405
        end
        do
          local __lux_tmp_y_406 = __lux_module_1.toNumber(record.y)
          if __lux_tmp_y_406 == nil then
            __lux_tmp_y_406 = 0
          end
          record.y = __lux_tmp_y_406
        end
        do
          local __lux_tmp_407
          if __lux_module_1.style.asColor ~= nil then
            do
              local __lux_tmp_color_408 = record.color
              if __lux_tmp_color_408 == nil then
                __lux_tmp_color_408 = resolved.color
              end
              if __lux_tmp_color_408 == nil then
                __lux_tmp_color_408 = resolved.fill
              end
              __lux_tmp_407 = __lux_module_1.style.asColor(__lux_tmp_color_408, __lux_module_1.white)
            end
          else
            do
              local __lux_tmp_color_409 = record.color
              if __lux_tmp_color_409 == nil then
                __lux_tmp_color_409 = resolved.color
              end
              if __lux_tmp_color_409 == nil then
                __lux_tmp_color_409 = resolved.fill
              end
              __lux_tmp_407 = __lux_module_1.style.colorOr(__lux_tmp_color_409, __lux_module_1.white)
            end
          end
          record.color = __lux_tmp_407
        end
        do
          local __lux_tmp_alignX_410 = resolved.alignX
          if __lux_tmp_alignX_410 == nil then
            __lux_tmp_alignX_410 = resolved.align
          end
          if __lux_tmp_alignX_410 == nil then
            __lux_tmp_alignX_410 = record.alignX
          end
          if __lux_tmp_alignX_410 == nil then
            __lux_tmp_alignX_410 = record.ax
          end
          if __lux_tmp_alignX_410 == nil then
            __lux_tmp_alignX_410 = TEXT_ALIGN_LEFT
          end
          record.alignX = __lux_tmp_alignX_410
        end
        do
          local __lux_tmp_alignY_411 = resolved.alignY
          if __lux_tmp_alignY_411 == nil then
            __lux_tmp_alignY_411 = resolved.valign
          end
          if __lux_tmp_alignY_411 == nil then
            __lux_tmp_alignY_411 = record.alignY
          end
          if __lux_tmp_alignY_411 == nil then
            __lux_tmp_alignY_411 = record.ay
          end
          if __lux_tmp_alignY_411 == nil then
            __lux_tmp_alignY_411 = TEXT_ALIGN_TOP
          end
          record.alignY = __lux_tmp_alignY_411
        end
        record.style = resolved
        return record
      end
      renderer.Flush = function(records, reason)
        do
          local normalized = records
          if normalized == nil then
            normalized = {}
          end
          for index = 1, #normalized do
            renderer.NormalizeRecord(normalized[index])
          end
          return __lux_module_1.flushTextRecords(normalized, stats)
        end
      end
      renderer.DrawRecordImmediate = function(record)
        if record == nil then
          return nil
        end
        immediateRecordBatch[1] = record
        local out = renderer.Flush(immediateRecordBatch, "immediate")
        immediateRecordBatch[1] = nil
        return out
      end
      renderer.DrawTextImmediate = function(value, font, x, y, color, ax, ay, textStyle)
        return renderer.DrawRecordImmediate(
          renderer.MakeRecord(value, font, x, y, color, ax, ay, textStyle)
        )
      end
      renderer.DrawTextBoxImmediate = function(value, font, x, y, w, h, textStyle)
        local resolved
        do
          local __lux_tmp_textStyle_412 = textStyle
          if __lux_tmp_textStyle_412 == nil then
            __lux_tmp_textStyle_412 = {}
          end
          resolved = renderer.ResolveStyle(__lux_tmp_textStyle_412)
        end
        local resolvedFont = resolved.font
        if resolvedFont == nil then
          resolvedFont = font
          if resolvedFont == nil then
            resolvedFont = "DermaDefault"
          end
        end
        local lines
        do
          local __lux_tmp_w_413 = __lux_module_1.toNumber(w)
          if __lux_tmp_w_413 == nil then
            __lux_tmp_w_413 = 0
          end
          lines = __lux_module_1.wrapText(value, resolvedFont, __lux_tmp_w_413, resolved.overflow)
        end
        local nativeFont, alias, oversample = __lux_module_1.nativeFor(resolvedFont, resolved)
        local lineHeight = __lux_module_1.lineHeightFor(nativeFont, alias, resolved, oversample)
        local totalH = #lines * lineHeight
        local startY
        do
          local __lux_tmp_y_414 = __lux_module_1.toNumber(y)
          if __lux_tmp_y_414 == nil then
            __lux_tmp_y_414 = 0
          end
          local __lux_tmp_h_415 = __lux_module_1.toNumber(h)
          if __lux_tmp_h_415 == nil then
            __lux_tmp_h_415 = totalH
          end
          local __lux_tmp_alignY_416 = resolved.alignY
          if __lux_tmp_alignY_416 == nil then
            __lux_tmp_alignY_416 = resolved.valign
          end
          if __lux_tmp_alignY_416 == nil then
            __lux_tmp_alignY_416 = TEXT_ALIGN_TOP
          end
          startY = __lux_tmp_y_414 + (__lux_tmp_h_415 - totalH) * __lux_module_1.alignFactor(__lux_tmp_alignY_416, true)
        end
        local ax = resolved.alignX
        if ax == nil then
          ax = resolved.align
          if ax == nil then
            ax = TEXT_ALIGN_LEFT
          end
        end
        local tx
        do
          local __lux_tmp_x_417 = __lux_module_1.toNumber(x)
          if __lux_tmp_x_417 == nil then
            __lux_tmp_x_417 = 0
          end
          local __lux_tmp_w_418 = __lux_module_1.toNumber(w)
          if __lux_tmp_w_418 == nil then
            __lux_tmp_w_418 = 0
          end
          tx = __lux_tmp_x_417 + __lux_tmp_w_418 * __lux_module_1.alignFactor(ax)
        end
        local lineStyle = __lux_module_1.textBoxLineStyle(resolved)
        for index = 1, #lines do
          do
            local __lux_tmp_color_419 = lineStyle.color
            if __lux_tmp_color_419 == nil then
              __lux_tmp_color_419 = lineStyle.fill
            end
            renderer.DrawTextImmediate(
              lines[index],
              resolvedFont,
              tx,
              startY + (index - 1) * lineHeight,
              __lux_tmp_color_419,
              ax,
              TEXT_ALIGN_TOP,
              lineStyle
            )
          end
        end
      end
      renderer.MeasureText = function(value, font)
        if font == nil then
          font = "DermaDefault"
        end
        return __lux_module_1.measure(value, font)
      end
      renderer.MeasureTextBox = function(value, font, w, textStyle)
        local __lux_tmp_textStyle_420 = textStyle
        if __lux_tmp_textStyle_420 == nil then
          __lux_tmp_textStyle_420 = {}
        end
        return __lux_module_1.measureBox(
          value,
          font,
          w,
          renderer.ResolveStyle(__lux_tmp_textStyle_420)
        )
      end
      renderer.PrewarmText = function(value, font, textStyle)
        local record
        do
          local __lux_tmp_textStyle_421 = textStyle
          if __lux_tmp_textStyle_421 == nil then
            __lux_tmp_textStyle_421 = {}
          end
          record = renderer.MakeRecord(
            value,
            font,
            0,
            0,
            nil,
            TEXT_ALIGN_LEFT,
            TEXT_ALIGN_TOP,
            __lux_tmp_textStyle_421
          )
        end
        if not __lux_module_1.recordNeedsComposedEntry(record) then
          return false
        end
        return __lux_module_1.entryFor(record, stats, true) ~= nil
      end
      renderer.ClearMeasureCache = function()
        __lux_module_1.clearMeasureCache()
        stats.textCacheSize = 0
        return true
      end
      renderer.ClearComposedCache = function()
        __lux_module_1.clearComposedCache()
        stats.textComposedEntries = 0
        return true
      end
      renderer.ComposedEnabled = function()
        return __lux_module_1.textComposedEnabled()
      end
      renderer.SetBatchBackend = function()
        return false
      end
      renderer.SetProfileActive = function(active)
        return __lux_module_1.setProfileActive(active)
      end
      renderer.ResetProfile = function()
        return __lux_module_1.resetProfile()
      end
      renderer.ProfileSnapshot = function(reset)
        if reset == nil then
          reset = false
        end
        return __lux_module_1.profileSnapshot(reset)
      end
      renderer.ResetFrameStats = function()
        return __lux_module_1.resetRendererFrameStats(stats)
      end
      renderer.DebugResolve = function(value, font, textStyle)
        if font == nil then
          font = "DermaDefault"
        end
        local record
        do
          local __lux_tmp_textStyle_422 = textStyle
          if __lux_tmp_textStyle_422 == nil then
            __lux_tmp_textStyle_422 = {}
          end
          record = renderer.MakeRecord(
            value,
            font,
            0,
            0,
            nil,
            TEXT_ALIGN_LEFT,
            TEXT_ALIGN_TOP,
            __lux_tmp_textStyle_422
          )
        end
        local nativeFont, alias, oversample = __lux_module_1.nativeFor(record.font, record.style)
        local layout = __lux_module_1.layoutFor(record.text, record.font, record.style)
        local needsComposed = __lux_module_1.recordNeedsComposedEntry(record)
        local __lux_tmp_423
        if needsComposed then
          __lux_tmp_423 = "__composed"
        else
          __lux_tmp_423 = "__native"
        end
        local __lux_tmp_424
        if needsComposed then
          __lux_tmp_424 = "composed"
        else
          __lux_tmp_424 = "native"
        end
        local __lux_tmp_425
        if needsComposed then
          __lux_tmp_425 = "__composed"
        else
          __lux_tmp_425 = "__native"
        end
        local __lux_tmp_426
        if needsComposed then
          __lux_tmp_426 = "compose"
        else
          __lux_tmp_426 = "native"
        end
        local __lux_tmp_mode_427 = alias.mode
        if __lux_tmp_mode_427 == nil then
          __lux_tmp_mode_427 = "native"
        end
        return {
          text = record.text,
          font = record.font,
          nativeFont = nativeFont,
          atlasKey = __lux_tmp_423,
          kind = __lux_tmp_424,
          routeAtlas = __lux_tmp_425,
          routeKind = __lux_tmp_426,
          mode = __lux_tmp_mode_427,
          missing = {},
          w = layout.w,
          h = layout.h,
          oversample = oversample,
        }
      end
      renderer.Status = function()
        local __lux_obj_atlas_428 = __lux_module_1.atlas
        local __lux_val_rt_429 = nil
        if __lux_obj_atlas_428 ~= nil then
          __lux_val_rt_429 = __lux_obj_atlas_428.rt
        end
        local __lux_obj_atlas_430 = __lux_module_1.atlas
        local __lux_tmp_w_431 = nil
        if __lux_obj_atlas_430 ~= nil then
          __lux_tmp_w_431 = __lux_obj_atlas_430.w
        end
        if __lux_tmp_w_431 == nil then
          __lux_tmp_w_431 = 0
        end
        local __lux_obj_atlas_432 = __lux_module_1.atlas
        local __lux_tmp_h_433 = nil
        if __lux_obj_atlas_432 ~= nil then
          __lux_tmp_h_433 = __lux_obj_atlas_432.h
        end
        if __lux_tmp_h_433 == nil then
          __lux_tmp_h_433 = 0
        end
        local __lux_tmp_textDraws_434 = stats.textDraws
        if __lux_tmp_textDraws_434 == nil then
          __lux_tmp_textDraws_434 = 0
        end
        local __lux_tmp_textNativeDraws_435 = stats.textNativeDraws
        if __lux_tmp_textNativeDraws_435 == nil then
          __lux_tmp_textNativeDraws_435 = 0
        end
        local __lux_tmp_textShaderDraws_436 = stats.textShaderDraws
        if __lux_tmp_textShaderDraws_436 == nil then
          __lux_tmp_textShaderDraws_436 = 0
        end
        local __lux_tmp_textComposedDraws_437 = stats.textComposedDraws
        if __lux_tmp_textComposedDraws_437 == nil then
          __lux_tmp_textComposedDraws_437 = 0
        end
        local __lux_tmp_textComposedBakes_438 = stats.textComposedBakes
        if __lux_tmp_textComposedBakes_438 == nil then
          __lux_tmp_textComposedBakes_438 = 0
        end
        local __lux_tmp_textComposedBlits_439 = stats.textComposedBlits
        if __lux_tmp_textComposedBlits_439 == nil then
          __lux_tmp_textComposedBlits_439 = 0
        end
        local __lux_tmp_textMeasureHits_440 = stats.textMeasureHits
        if __lux_tmp_textMeasureHits_440 == nil then
          __lux_tmp_textMeasureHits_440 = 0
        end
        local __lux_tmp_textMeasureMisses_441 = stats.textMeasureMisses
        if __lux_tmp_textMeasureMisses_441 == nil then
          __lux_tmp_textMeasureMisses_441 = 0
        end
        return {
          mode = "native+composer",
          fontCount = __lux_module_1.countTable(__lux_module_1.fonts),
          styleCount = __lux_module_1.countTable(__lux_module_1.styles),
          styleStackDepth = #styleStack,
          cacheSize = __lux_module_1.measureOrderCount,
          composedEnabled = __lux_module_1.textComposedEnabled(),
          composedAtlas = __lux_val_rt_429,
          composedAtlasW = __lux_tmp_w_431,
          composedAtlasH = __lux_tmp_h_433,
          composedAtlasPages = #__lux_module_1.atlasPages,
          composedAtlasMaxPages = __lux_module_1.MAX_ATLAS_PAGES,
          composedAtlasFill = __lux_module_1.atlasFillRatio(),
          composedEntries = __lux_module_1.composedCacheCount,
          composedFailed = __lux_module_1.atlasFailed,
          draws = __lux_tmp_textDraws_434,
          nativeDraws = __lux_tmp_textNativeDraws_435,
          shaderDraws = __lux_tmp_textShaderDraws_436,
          composedDraws = __lux_tmp_textComposedDraws_437,
          composedBakes = __lux_tmp_textComposedBakes_438,
          composedBlits = __lux_tmp_textComposedBlits_439,
          measureHits = __lux_tmp_textMeasureHits_440,
          measureMisses = __lux_tmp_textMeasureMisses_441,
          staticAtlasCount = 0,
          declaredAtlasCount = 0,
          atlasCount = 0,
        }
      end
      renderer.DebugDrawAtlas = function()
        if #__lux_module_1.atlasPages == 0 then
          if __lux_module_1.drawSimpleText ~= nil then
            __lux_module_1.drawSimpleText(
              "[MGFX] atlas: no pages allocated yet",
              "DermaDefaultBold",
              20,
              20,
              __lux_module_1.makeColor(255, 120, 120)
            )
          end
          return false
        end
        if __lux_module_1.debugViewMat == nil then
          __lux_module_1.debugViewMat = __lux_module_1.createMaterial(
            "MGFXAtlasDebugView",
            "UnlitGeneric",
            {
              ["$basetexture"] = "color/white",
              ["$translucent"] = "0",
              ["$vertexcolor"] = "1",
              ["$ignorez"] = "1",
            }
          )
        end
        local count = #__lux_module_1.atlasPages
        local cols = __lux_module_1.mathMin(count, 4)
        local pad = 8
        local screenW
        if ScrW ~= nil then
          screenW = ScrW()
        else
          screenW = 1280
        end
        local thumbW = __lux_module_1.mathFloor((screenW - 40 - pad * (cols - 1)) / cols)
        local thumbH = __lux_module_1.mathFloor(thumbW * __lux_module_1.ATLAS_H / __lux_module_1.ATLAS_W)
        local x0 = 20
        local y0 = 40
        if __lux_module_1.drawSimpleText ~= nil then
          __lux_module_1.drawSimpleText(
            "MGFX atlas " ..
              __lux_module_1.ATLAS_W .. "x" .. __lux_module_1.ATLAS_H .. " pages=" .. count,
            "DermaDefaultBold",
            x0,
            14,
            __lux_module_1.makeColor(160, 230, 255)
          )
        end
        for index, page in ipairs(__lux_module_1.atlasPages) do
          local col = (index - 1) % cols
          local row = __lux_module_1.mathFloor((index - 1) / cols)
          local px = x0 + col * (thumbW + pad)
          local py = y0 + row * (thumbH + 20)
          if page.rt ~= nil and __lux_module_1.debugViewMat ~= nil and __lux_module_1.surfaceSetMaterial ~= nil and __lux_module_1.surfaceDrawTexturedRect ~= nil then
            __lux_module_1.debugViewMat:SetTexture("$basetexture", page.rt)
            __lux_module_1.surfaceSetMaterial(__lux_module_1.debugViewMat)
            __lux_module_1.surfaceSetDrawColor(255, 255, 255, 255)
            __lux_module_1.surfaceDrawTexturedRect(px, py, thumbW, thumbH)
          end
          if __lux_module_1.surfaceDrawOutlinedRect ~= nil then
            __lux_module_1.surfaceSetDrawColor(70, 80, 92, 255)
            __lux_module_1.surfaceDrawOutlinedRect(px, py, thumbW, thumbH)
          end
          if __lux_module_1.drawSimpleText ~= nil then
            __lux_module_1.drawSimpleText(
              "page " .. index,
              "DermaDefaultBold",
              px + 2,
              py - 13,
              __lux_module_1.makeColor(255, 220, 120)
            )
          end
        end
        return true
      end
      return renderer
    end
  end
  do
    local frameImport = __lux_import("lux/mgfx/frame#client")
    __lux_module_1.frame = frameImport
    __lux_module_1.install = function(owner)
      do
        local __lux_tmp_stats_442 = owner.stats
        if __lux_tmp_stats_442 == nil then
          __lux_tmp_stats_442 = {}
        end
        owner.stats = __lux_tmp_stats_442
      end
      local materialState = owner._MaterialState
      if materialState == nil then
        materialState = {}
      end
      local renderer
      do
        local __lux_tmp_Materials_443 = owner._Materials
        if __lux_tmp_Materials_443 == nil then
          __lux_tmp_Materials_443 = materialState.materials
        end
        if __lux_tmp_Materials_443 == nil then
          __lux_tmp_Materials_443 = {}
        end
        local __lux_tmp_MaterialOK_444 = owner.MaterialOK
        if __lux_tmp_MaterialOK_444 == nil then
          __lux_tmp_MaterialOK_444 = materialState.matOK
        end
        renderer = __lux_module_1.createTextRenderer(
          {
            M = owner,
            owner = owner,
            stats = owner.stats,
            materials = __lux_tmp_Materials_443,
            createPageTextMaterials = materialState.CreatePageTextMaterials,
            matOK = __lux_tmp_MaterialOK_444,
            profiler = owner.Profiler,
            restoreScissor = __lux_module_1.frame.restoreScissor,
            gradientLutForFill = owner.GradientLutForFill,
          }
        )
      end
      owner.RegisterTextFont = renderer.RegisterFont
      owner.DefineTextStyle = renderer.DefineStyle
      owner.GetTextStyle = renderer.GetStyle
      owner.ResolveTextStyle = renderer.ResolveStyle
      owner.PushTextStyle = renderer.PushStyle
      owner.PopTextStyle = renderer.PopStyle
      owner.MakeTextRecord = renderer.MakeRecord
      owner.MeasureText = renderer.MeasureText
      owner.MeasureTextBox = renderer.MeasureTextBox
      owner.PrewarmText = renderer.PrewarmText
      owner.TextBatchEx = renderer.Flush
      owner.Text = renderer.DrawTextImmediate
      owner.TextEx = renderer.DrawTextImmediate
      owner.TextBox = renderer.DrawTextBoxImmediate
      owner.TextBoxEx = renderer.DrawTextBoxImmediate
      owner.ClearTextMeasureCache = renderer.ClearMeasureCache
      owner.ClearTextComposedCache = renderer.ClearComposedCache
      owner.TextComposedEnabled = renderer.ComposedEnabled
      owner.SetTextProfileActive = renderer.SetProfileActive
      owner.ResetTextProfile = renderer.ResetProfile
      owner.GetTextProfileSnapshot = renderer.ProfileSnapshot
      owner.ResetTextFrameStats = renderer.ResetFrameStats
      owner.GetTextRendererStatus = renderer.Status
      owner.DebugResolveText = renderer.DebugResolve
      owner.DebugDrawTextAtlas = renderer.DebugDrawAtlas
      owner._CreateTextRenderer = __lux_module_1.createTextRenderer
      owner._TextRenderer = renderer
      __lux_module_1.defaultTextRenderer = renderer
      owner._TextStyles = __lux_module_1.styles
      owner._TextFonts = __lux_module_1.fonts
      return owner
    end
  end
  
  __lux_exports.registerFont = __lux_module_1.registerFont
  __lux_exports.defineStyle = __lux_module_1.defineStyle
  __lux_exports.getStyle = __lux_module_1.getStyle
  __lux_exports.resolveStyle = __lux_module_1.resolveStyle
  __lux_exports.measure = __lux_module_1.measure
  __lux_exports.measureBox = __lux_module_1.measureBox
  __lux_exports.draw = __lux_module_1.draw
  __lux_exports.drawEx = __lux_module_1.drawEx
  __lux_exports.box = __lux_module_1.box
  __lux_exports.boxEx = __lux_module_1.boxEx
  __lux_exports.batch = __lux_module_1.batch
  __lux_exports.prewarm = __lux_module_1.prewarm
  __lux_exports.setProfileActive = __lux_module_1.setProfileActive
  __lux_exports.resetProfile = __lux_module_1.resetProfile
  __lux_exports.profileSnapshot = __lux_module_1.profileSnapshot
  __lux_exports.createTextRenderer = __lux_module_1.createTextRenderer
  __lux_exports._CreateTextRenderer = __lux_module_1.createTextRenderer
  __lux_exports.install = __lux_module_1.install
  
  return __lux_exports
end
