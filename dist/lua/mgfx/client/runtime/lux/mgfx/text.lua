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
    __lux_module_1.isMaterialOK = function(material)
      return __lux_module_1.materialOK ~= nil and __lux_module_1.materialOK(material)
    end
    __lux_module_1.textChars = function(text)
      local out = {}
      local value
      do
        local __lux_tmp_text_62 = text
        if __lux_tmp_text_62 == nil then
          __lux_tmp_text_62 = ""
        end
        value = __lux_module_1.toString(__lux_tmp_text_62)
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
        local __lux_tmp_t_63 = t
        if __lux_tmp_t_63 == nil then
          __lux_tmp_t_63 = {}
        end
        for key, _ in pairs(__lux_tmp_t_63) do
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
        local __lux_tmp_fallback_64 = fallback
        if __lux_tmp_fallback_64 == nil then
          __lux_tmp_fallback_64 = 500
        end
        return __lux_tmp_fallback_64
      end
      if weight > 0 and weight <= 10 then
        do
          local __lux_tmp_65
          if weight <= 1 then
            __lux_tmp_65 = 850
          else
            __lux_tmp_65 = weight * 100
          end
          weight = __lux_tmp_65
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
      local __lux_tmp_face_66 = face
      if __lux_tmp_face_66 == nil then
        __lux_tmp_face_66 = ""
      end
      local __lux_tmp_size_67 = size
      if __lux_tmp_size_67 == nil then
        __lux_tmp_size_67 = ""
      end
      local __lux_tmp_weight_68 = weight
      if __lux_tmp_weight_68 == nil then
        __lux_tmp_weight_68 = ""
      end
      local __lux_tmp_69
      if italic == true then
        __lux_tmp_69 = "i"
      else
        __lux_tmp_69 = "n"
      end
      return __lux_module_1.tableConcat(
        {
          __lux_module_1.toString(__lux_tmp_face_66),
          __lux_module_1.toString(__lux_tmp_size_67),
          __lux_module_1.toString(__lux_tmp_weight_68),
          __lux_tmp_69,
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
          local __lux_tmp_face_70 = face
          if __lux_tmp_face_70 == nil then
            __lux_tmp_face_70 = "DermaDefault"
          end
          local __lux_tmp_size_71 = size
          if __lux_tmp_size_71 == nil then
            __lux_tmp_size_71 = 16
          end
          __lux_module_1.surfaceCreateFont(
            name,
            {
              font = __lux_tmp_face_70,
              size = __lux_module_1.mathFloor(__lux_tmp_size_71),
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
          local __lux_tmp_oversample_72 = input.oversample
          if __lux_tmp_oversample_72 == nil then
            __lux_tmp_oversample_72 = __lux_module_1.oversampleForSize(size)
          end
          oversample = __lux_module_1.normalizeOversample(__lux_tmp_oversample_72)
        end
        do
          local __lux_tmp_73
          if face == __lux_module_1.DEFAULT_CJK_FACE then
            __lux_tmp_73 = 400
          else
            __lux_tmp_73 = 500
          end
          weight = __lux_module_1.normalizeFontWeight(weight, __lux_tmp_73)
        end
        sourceFont = __lux_module_1.ensureNativeFont(face, size * oversample, weight, input.italic == true)
      else
        if sourceFont == nil then
          sourceFont = name
        end
      end
      do
        local __lux_tmp_74
        if face ~= nil then
          __lux_tmp_74 = "alias"
        else
          __lux_tmp_74 = "native"
        end
        local __lux_tmp_lineHeight_75 = input.lineHeight
        if __lux_tmp_lineHeight_75 == nil then
          __lux_tmp_lineHeight_75 = input.lineheight
        end
        local __lux_tmp_tracking_76 = input.tracking
        if __lux_tmp_tracking_76 == nil then
          __lux_tmp_tracking_76 = input.letterSpacing
        end
        local __lux_tmp_tracking_77 = __lux_module_1.toNumber(__lux_tmp_tracking_76)
        if __lux_tmp_tracking_77 == nil then
          __lux_tmp_tracking_77 = 0
        end
        local __lux_tmp_78
        if face ~= nil then
          __lux_tmp_78 = "__composed"
        else
          __lux_tmp_78 = "__native"
        end
        __lux_module_1.fonts[name] = {
          mode = __lux_tmp_74,
          sourceFont = sourceFont,
          face = face,
          size = size,
          weight = weight,
          oversample = oversample,
          syntheticWeight = input.syntheticWeight == true or input.allowSyntheticWeight == true,
          lineHeight = __lux_module_1.toNumber(__lux_tmp_lineHeight_75),
          tracking = __lux_tmp_tracking_77,
          atlas = __lux_tmp_78,
        }
      end
      return true
    end
    __lux_module_1.aliasFor = function(font)
      local key
      do
        local __lux_tmp_font_79 = font
        if __lux_tmp_font_79 == nil then
          __lux_tmp_font_79 = ""
        end
        key = __lux_module_1.toString(__lux_tmp_font_79)
      end
      local alias = __lux_module_1.fonts[key]
      if alias ~= nil then
        return alias
      end
      local __lux_tmp_font_80 = font
      if __lux_tmp_font_80 == nil then
        __lux_tmp_font_80 = "DermaDefault"
      end
      return {
        mode = "native",
        sourceFont = __lux_tmp_font_80,
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
        local __lux_tmp_85 = noOversample
        if not __lux_tmp_85 then
          local __lux_obj_textStyle_83 = textStyle
          local __lux_val_mgfxNoOversample_84 = nil
          if __lux_obj_textStyle_83 ~= nil then
            __lux_val_mgfxNoOversample_84 = __lux_obj_textStyle_83.__mgfxNoOversample
          end
          __lux_tmp_85 = __lux_val_mgfxNoOversample_84
        end
        if __lux_tmp_85 then
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
        local __lux_obj_textStyle_86 = textStyle
        local __lux_val_syntheticNativeWeight_87 = nil
        if __lux_obj_textStyle_86 ~= nil then
          __lux_val_syntheticNativeWeight_87 = __lux_obj_textStyle_86.syntheticNativeWeight
        end
        if __lux_val_syntheticNativeWeight_87 == true then
          local __lux_tmp_92 = plainFace ~= true
          if __lux_tmp_92 then
            local __lux_obj_textStyle_90 = textStyle
            local __lux_val_bold_91 = nil
            if __lux_obj_textStyle_90 ~= nil then
              __lux_val_bold_91 = __lux_obj_textStyle_90.bold
            end
            __lux_tmp_92 = __lux_val_bold_91 == true
          end
          if __lux_tmp_92 then
            weight = weight + 220
          end
          local __lux_tmp_97 = plainFace ~= true
          if __lux_tmp_97 then
            local __lux_obj_textStyle_95 = textStyle
            local __lux_val_thin_96 = nil
            if __lux_obj_textStyle_95 ~= nil then
              __lux_val_thin_96 = __lux_obj_textStyle_95.thin
            end
            __lux_tmp_97 = __lux_val_thin_96 == true
          end
          if __lux_tmp_97 then
            weight = __lux_module_1.mathMin(weight, 350)
          end
          local __lux_obj_textStyle_98 = textStyle
          local __lux_val_weight_99 = nil
          if __lux_obj_textStyle_98 ~= nil then
            __lux_val_weight_99 = __lux_obj_textStyle_98.weight
          end
          if __lux_module_1.toNumber(__lux_val_weight_99) ~= nil then
            weight = __lux_module_1.normalizeFontWeight(textStyle.weight, weight)
          end
        end
        local __lux_tmp_size_100 = alias.size
        if __lux_tmp_size_100 == nil then
          __lux_tmp_size_100 = 16
        end
        local __lux_obj_textStyle_101 = textStyle
        local __lux_val_italic_102 = nil
        if __lux_obj_textStyle_101 ~= nil then
          __lux_val_italic_102 = __lux_obj_textStyle_101.italic
        end
        return __lux_module_1.ensureNativeFont(
          alias.face,
          __lux_tmp_size_100 * oversample,
          weight,
          __lux_val_italic_102 == true
        ), alias, oversample
      end
      local __lux_tmp_sourceFont_103 = alias.sourceFont
      if __lux_tmp_sourceFont_103 == nil then
        __lux_tmp_sourceFont_103 = font
      end
      if __lux_tmp_sourceFont_103 == nil then
        __lux_tmp_sourceFont_103 = "DermaDefault"
      end
      return __lux_tmp_sourceFont_103, alias, 1
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
        local __lux_tmp_textStyle_104 = textStyle
        if __lux_tmp_textStyle_104 == nil then
          __lux_tmp_textStyle_104 = {}
        end
        __lux_module_1.styles[__lux_module_1.toString(name)] = __lux_module_1.resolveStyle(__lux_tmp_textStyle_104)
      end
      return __lux_module_1.styles[__lux_module_1.toString(name)]
    end
    __lux_module_1.getStyle = function(name)
      local __lux_tmp_name_105 = name
      if __lux_tmp_name_105 == nil then
        __lux_tmp_name_105 = ""
      end
      return __lux_module_1.styles[__lux_module_1.toString(__lux_tmp_name_105)]
    end
    __lux_module_1.resolveStyle = function(textStyle)
      if __lux_module_1.typeOf(textStyle) == "string" then
        local __lux_tmp_textStyle_106 = __lux_module_1.styles[__lux_module_1.toString(textStyle)]
        if __lux_tmp_textStyle_106 == nil then
          __lux_tmp_textStyle_106 = {}
        end
        return __lux_module_1.copyValue(__lux_tmp_textStyle_106)
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
        local __lux_obj_textStyle_107 = textStyle
        local __lux_val_lineHeight_108 = nil
        if __lux_obj_textStyle_107 ~= nil then
          __lux_val_lineHeight_108 = __lux_obj_textStyle_107.lineHeight
        end
        local __lux_tmp_lineHeight_109 = __lux_val_lineHeight_108
        if __lux_tmp_lineHeight_109 == nil then
          local __lux_obj_textStyle_110 = textStyle
          local __lux_val_lineheight_111 = nil
          if __lux_obj_textStyle_110 ~= nil then
            __lux_val_lineheight_111 = __lux_obj_textStyle_110.lineheight
          end
          __lux_tmp_lineHeight_109 = __lux_val_lineheight_111
        end
        if __lux_tmp_lineHeight_109 == nil then
          local __lux_obj_alias_112 = alias
          local __lux_val_lineHeight_113 = nil
          if __lux_obj_alias_112 ~= nil then
            __lux_val_lineHeight_113 = __lux_obj_alias_112.lineHeight
          end
          __lux_tmp_lineHeight_109 = __lux_val_lineHeight_113
        end
        declared = __lux_module_1.toNumber(__lux_tmp_lineHeight_109)
      end
      if declared ~= nil then
        return declared
      end
      __lux_module_1.setFontSafe(nativeFont)
      local _, h = __lux_module_1.surfaceGetTextSize("Mg")
      local __lux_tmp_h_114 = h
      if __lux_tmp_h_114 == nil then
        __lux_tmp_h_114 = 16
      end
      return __lux_module_1.mathMax(
        1,
        __lux_tmp_h_114 / __lux_module_1.normalizeOversample(oversample)
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
        local __lux_tmp_text_115 = text
        if __lux_tmp_text_115 == nil then
          __lux_tmp_text_115 = ""
        end
        raw = __lux_module_1.toString(__lux_tmp_text_115)
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
        local __lux_tmp_textStyle_116 = textStyle
        if __lux_tmp_textStyle_116 == nil then
          __lux_tmp_textStyle_116 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_textStyle_116)
      end
      local nativeFont, alias, oversample = __lux_module_1.nativeFor(font, resolved, noOversample, plainFace)
      local tracking
      do
        local __lux_tmp_tracking_117 = resolved.tracking
        if __lux_tmp_tracking_117 == nil then
          __lux_tmp_tracking_117 = resolved.letterSpacing
        end
        tracking = __lux_module_1.toNumber(__lux_tmp_tracking_117)
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
        local __lux_tmp_value_118 = value
        if __lux_tmp_value_118 == nil then
          __lux_tmp_value_118 = ""
        end
        lines = __lux_module_1.stringExplode("\n", __lux_module_1.toString(__lux_tmp_value_118), false)
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
        local __lux_tmp_font_119 = font
        if __lux_tmp_font_119 == nil then
          __lux_tmp_font_119 = ""
        end
        local __lux_tmp_value_120 = value
        if __lux_tmp_value_120 == nil then
          __lux_tmp_value_120 = ""
        end
        key = __lux_module_1.tableConcat(
          {
            __lux_module_1.toString(__lux_tmp_font_119),
            nativeFont,
            __lux_module_1.toString(tracking),
            __lux_module_1.toString(oversample),
            __lux_module_1.toString(__lux_tmp_value_120),
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
        local __lux_tmp_value_121 = value
        if __lux_tmp_value_121 == nil then
          __lux_tmp_value_121 = ""
        end
        text = __lux_module_1.toString(__lux_tmp_value_121)
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
        local __lux_tmp_value_122 = value
        if __lux_tmp_value_122 == nil then
          __lux_tmp_value_122 = ""
        end
        text = __lux_module_1.toString(__lux_tmp_value_122)
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
        local __lux_tmp_textStyle_123 = textStyle
        if __lux_tmp_textStyle_123 == nil then
          __lux_tmp_textStyle_123 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_textStyle_123)
      end
      local lines
      do
        local __lux_tmp_font_124 = font
        if __lux_tmp_font_124 == nil then
          __lux_tmp_font_124 = resolved.font
        end
        if __lux_tmp_font_124 == nil then
          __lux_tmp_font_124 = "DermaDefault"
        end
        local __lux_tmp_w_125 = __lux_module_1.toNumber(w)
        if __lux_tmp_w_125 == nil then
          __lux_tmp_w_125 = 0
        end
        lines = __lux_module_1.wrapText(value, __lux_tmp_font_124, __lux_tmp_w_125, resolved.overflow)
      end
      local maxW = 0
      for index = 1, #lines do
        local lw
        do
          local __lux_tmp_font_126 = font
          if __lux_tmp_font_126 == nil then
            __lux_tmp_font_126 = resolved.font
          end
          if __lux_tmp_font_126 == nil then
            __lux_tmp_font_126 = "DermaDefault"
          end
          lw = __lux_module_1.measure(lines[index], __lux_tmp_font_126)
        end
        maxW = __lux_module_1.mathMax(maxW, lw)
      end
      local nativeFont, alias, oversample
      do
        local __lux_tmp_font_127 = font
        if __lux_tmp_font_127 == nil then
          __lux_tmp_font_127 = resolved.font
        end
        if __lux_tmp_font_127 == nil then
          __lux_tmp_font_127 = "DermaDefault"
        end
        nativeFont, alias, oversample = __lux_module_1.nativeFor(__lux_tmp_font_127, resolved)
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
      local __lux_match_128 = value
      if __lux_match_128 == "center" or __lux_match_128 == "middle" then
        return 0.5
      elseif __lux_match_128 == "right" or __lux_match_128 == "bottom" then
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
      local __lux_tmp_colorA_129 = fill.colorA
      if __lux_tmp_colorA_129 == nil then
        __lux_tmp_colorA_129 = fill.color
      end
      if __lux_tmp_colorA_129 == nil then
        __lux_tmp_colorA_129 = fill.fill
      end
      return __lux_module_1.style.colorOr(__lux_tmp_colorA_129, __lux_module_1.white)
    end
    __lux_module_1.setTextColor = function(color)
      local c = __lux_module_1.style.colorOr(color, __lux_module_1.white)
      if __lux_module_1.surfaceSetTextColor ~= nil then
        do
          local __lux_tmp_r_130 = c.r
          if __lux_tmp_r_130 == nil then
            __lux_tmp_r_130 = 255
          end
          local __lux_tmp_g_131 = c.g
          if __lux_tmp_g_131 == nil then
            __lux_tmp_g_131 = 255
          end
          local __lux_tmp_b_132 = c.b
          if __lux_tmp_b_132 == nil then
            __lux_tmp_b_132 = 255
          end
          local __lux_tmp_a_133 = c.a
          if __lux_tmp_a_133 == nil then
            __lux_tmp_a_133 = 255
          end
          __lux_module_1.surfaceSetTextColor(
            __lux_tmp_r_130,
            __lux_tmp_g_131,
            __lux_tmp_b_132,
            __lux_tmp_a_133
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
        local __lux_tmp_text_134 = text
        if __lux_tmp_text_134 == nil then
          __lux_tmp_text_134 = ""
        end
        raw = __lux_module_1.toString(__lux_tmp_text_134)
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
          local __lux_tmp_cw_135 = cw
          if __lux_tmp_cw_135 == nil then
            __lux_tmp_cw_135 = 0
          end
          cursor = cursor + __lux_tmp_cw_135 + extra * __lux_module_1.normalizeOversample(oversample)
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
          local __lux_tmp_fill_136 = fill
          if __lux_tmp_fill_136 == nil then
            __lux_tmp_fill_136 = fallbackColor
          end
          __lux_module_1.drawLineText(
            layout.font,
            line.text,
            x,
            y + line.y * oversample,
            __lux_module_1.colorAtFill(__lux_tmp_fill_136, t),
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
          local __lux_tmp_value_137 = __lux_module_1.toNumber(value)
          if __lux_tmp_value_137 == nil then
            __lux_tmp_value_137 = 0
          end
          value = { blur = __lux_tmp_value_137 }
        end
      end
      local __lux_tmp_x_138 = value.x
      if __lux_tmp_x_138 == nil then
        __lux_tmp_x_138 = value.offsetX
      end
      if __lux_tmp_x_138 == nil then
        __lux_tmp_x_138 = value[1]
      end
      local __lux_tmp_x_139 = __lux_module_1.toNumber(__lux_tmp_x_138)
      if __lux_tmp_x_139 == nil then
        __lux_tmp_x_139 = 1
      end
      local __lux_tmp_y_140 = value.y
      if __lux_tmp_y_140 == nil then
        __lux_tmp_y_140 = value.offsetY
      end
      if __lux_tmp_y_140 == nil then
        __lux_tmp_y_140 = value[2]
      end
      local __lux_tmp_y_141 = __lux_module_1.toNumber(__lux_tmp_y_140)
      if __lux_tmp_y_141 == nil then
        __lux_tmp_y_141 = 1
      end
      local __lux_tmp_blur_142 = value.blur
      if __lux_tmp_blur_142 == nil then
        __lux_tmp_blur_142 = value.radius
      end
      if __lux_tmp_blur_142 == nil then
        __lux_tmp_blur_142 = value[3]
      end
      local __lux_tmp_blur_143 = __lux_module_1.toNumber(__lux_tmp_blur_142)
      if __lux_tmp_blur_143 == nil then
        __lux_tmp_blur_143 = 0
      end
      local __lux_tmp_strength_144 = value.strength
      if __lux_tmp_strength_144 == nil then
        __lux_tmp_strength_144 = value.opacity
      end
      local __lux_tmp_strength_145 = __lux_module_1.toNumber(__lux_tmp_strength_144)
      if __lux_tmp_strength_145 == nil then
        __lux_tmp_strength_145 = 1
      end
      local __lux_tmp_color_146 = value.color
      if __lux_tmp_color_146 == nil then
        __lux_tmp_color_146 = value.tint
      end
      return {
        x = __lux_tmp_x_139,
        y = __lux_tmp_y_141,
        blur = __lux_tmp_blur_143,
        strength = __lux_tmp_strength_145,
        color = __lux_module_1.style.colorOr(
          __lux_tmp_color_146,
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
          local __lux_tmp_value_147 = __lux_module_1.toNumber(value)
          if __lux_tmp_value_147 == nil then
            __lux_tmp_value_147 = 1
          end
          value = { width = __lux_tmp_value_147 }
        end
      end
      local width
      do
        local __lux_tmp_width_148 = value.width
        if __lux_tmp_width_148 == nil then
          __lux_tmp_width_148 = value.size
        end
        if __lux_tmp_width_148 == nil then
          __lux_tmp_width_148 = value[1]
        end
        local __lux_tmp_width_149 = __lux_module_1.toNumber(__lux_tmp_width_148)
        if __lux_tmp_width_149 == nil then
          __lux_tmp_width_149 = 1
        end
        width = __lux_module_1.mathMax(0, __lux_tmp_width_149)
      end
      if width <= 0 then
        return nil
      end
      local __lux_tmp_softness_150 = __lux_module_1.toNumber(value.softness)
      if __lux_tmp_softness_150 == nil then
        __lux_tmp_softness_150 = 0
      end
      local __lux_tmp_color_151 = value.color
      if __lux_tmp_color_151 == nil then
        __lux_tmp_color_151 = value.tint
      end
      return {
        width = width,
        samples = __lux_module_1.mathClamp(__lux_module_1.mathCeil(width * 6), 8, 32),
        softness = __lux_tmp_softness_150,
        color = __lux_module_1.style.colorOr(
          __lux_tmp_color_151,
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
          local __lux_tmp_value_152 = __lux_module_1.toNumber(value)
          if __lux_tmp_value_152 == nil then
            __lux_tmp_value_152 = 6
          end
          value = { width = __lux_tmp_value_152 }
        end
      end
      local width
      do
        local __lux_tmp_width_153 = value.width
        if __lux_tmp_width_153 == nil then
          __lux_tmp_width_153 = value.radius
        end
        if __lux_tmp_width_153 == nil then
          __lux_tmp_width_153 = value[1]
        end
        local __lux_tmp_width_154 = __lux_module_1.toNumber(__lux_tmp_width_153)
        if __lux_tmp_width_154 == nil then
          __lux_tmp_width_154 = 6
        end
        width = __lux_module_1.mathMax(0, __lux_tmp_width_154)
      end
      if width <= 0 then
        return nil
      end
      local __lux_tmp_strength_155 = value.strength
      if __lux_tmp_strength_155 == nil then
        __lux_tmp_strength_155 = value.opacity
      end
      local __lux_tmp_strength_156 = __lux_module_1.toNumber(__lux_tmp_strength_155)
      if __lux_tmp_strength_156 == nil then
        __lux_tmp_strength_156 = 0.45
      end
      local __lux_tmp_color_157 = value.color
      if __lux_tmp_color_157 == nil then
        __lux_tmp_color_157 = value.tint
      end
      return {
        width = width,
        samples = __lux_module_1.mathClamp(__lux_module_1.mathCeil(width * 2), 8, 36),
        strength = __lux_tmp_strength_156,
        color = __lux_module_1.style.colorOr(
          __lux_tmp_color_157,
          __lux_module_1.makeColor(255, 255, 255, 120)
        ),
      }
    end
    __lux_module_1.scaledColor = function(input, scale)
      local color = __lux_module_1.style.colorOr(input, __lux_module_1.white)
      local __lux_tmp_r_158 = color.r
      if __lux_tmp_r_158 == nil then
        __lux_tmp_r_158 = 255
      end
      local __lux_tmp_g_159 = color.g
      if __lux_tmp_g_159 == nil then
        __lux_tmp_g_159 = 255
      end
      local __lux_tmp_b_160 = color.b
      if __lux_tmp_b_160 == nil then
        __lux_tmp_b_160 = 255
      end
      local __lux_tmp_a_161 = color.a
      if __lux_tmp_a_161 == nil then
        __lux_tmp_a_161 = 255
      end
      local __lux_tmp_scale_162 = scale
      if __lux_tmp_scale_162 == nil then
        __lux_tmp_scale_162 = 1
      end
      return __lux_module_1.makeColor(
        __lux_tmp_r_158,
        __lux_tmp_g_159,
        __lux_tmp_b_160,
        __lux_module_1.mathClamp(
          __lux_module_1.mathFloor(__lux_tmp_a_161 * __lux_tmp_scale_162),
          0,
          255
        )
      )
    end
    __lux_module_1.snapTextPos = function(x, y, textStyle)
      local __lux_obj_textStyle_163 = textStyle
      local __lux_val_pixelSnap_164 = nil
      if __lux_obj_textStyle_163 ~= nil then
        __lux_val_pixelSnap_164 = __lux_obj_textStyle_163.pixelSnap
      end
      if __lux_val_pixelSnap_164 == false then
        return x, y
      end
      local __lux_tmp_x_165 = x
      if __lux_tmp_x_165 == nil then
        __lux_tmp_x_165 = 0
      end
      local __lux_tmp_y_166 = y
      if __lux_tmp_y_166 == nil then
        __lux_tmp_y_166 = 0
      end
      return __lux_module_1.mathFloor(__lux_tmp_x_165 + 0.5), __lux_module_1.mathFloor(__lux_tmp_y_166 + 0.5)
    end
    __lux_module_1.drawNativeFallbackRecord = function(record)
      local textStyle = record.style
      if textStyle == nil then
        textStyle = {}
      end
      local layout = __lux_module_1.layoutFor(record.text, record.font, textStyle, true)
      local x
      do
        local __lux_tmp_x_167 = record.x
        if __lux_tmp_x_167 == nil then
          __lux_tmp_x_167 = 0
        end
        x = __lux_tmp_x_167 - layout.w * __lux_module_1.alignFactor(record.alignX)
      end
      local y
      do
        local __lux_tmp_y_168 = record.y
        if __lux_tmp_y_168 == nil then
          __lux_tmp_y_168 = 0
        end
        y = __lux_tmp_y_168 - layout.h * __lux_module_1.alignFactor(record.alignY, true)
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
        local __lux_tmp_stroke_169 = textStyle.stroke
        if __lux_tmp_stroke_169 == nil then
          __lux_tmp_stroke_169 = textStyle.outline
        end
        stroke = __lux_module_1.normalizeStroke(__lux_tmp_stroke_169)
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
        local __lux_tmp_color_170 = record.color
        if __lux_tmp_color_170 == nil then
          __lux_tmp_color_170 = __lux_module_1.white
        end
        __lux_module_1.drawLayout(layout, x, y, fill, __lux_tmp_color_170)
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
          local __lux_tmp_color_171 = record.color
          if __lux_tmp_color_171 == nil then
            __lux_tmp_color_171 = __lux_module_1.white
          end
          fill = __lux_tmp_color_171
        end
      end
      local nativeFont, alias = __lux_module_1.nativeFor(record.font, textStyle, true, true)
      local tracking
      do
        local __lux_tmp_tracking_172 = textStyle.tracking
        if __lux_tmp_tracking_172 == nil then
          __lux_tmp_tracking_172 = textStyle.letterSpacing
        end
        tracking = __lux_module_1.toNumber(__lux_tmp_tracking_172)
        if tracking == nil then
          tracking = alias.tracking
          if tracking == nil then
            tracking = 0
          end
        end
      end
      local raw
      do
        local __lux_tmp_text_173 = record.text
        if __lux_tmp_text_173 == nil then
          __lux_tmp_text_173 = ""
        end
        raw = __lux_module_1.toString(__lux_tmp_text_173)
      end
      if tracking == 0 and __lux_module_1.stringFind(raw, "\n", 1, true) == nil and textStyle.lineHeight == nil and alias.lineHeight == nil and not __lux_module_1.fillNeedsShader(fill) and __lux_module_1.drawSimpleText ~= nil then
        local x, y
        do
          local __lux_tmp_x_174 = record.x
          if __lux_tmp_x_174 == nil then
            __lux_tmp_x_174 = 0
          end
          local __lux_tmp_y_175 = record.y
          if __lux_tmp_y_175 == nil then
            __lux_tmp_y_175 = 0
          end
          x, y = __lux_module_1.snapTextPos(__lux_tmp_x_174, __lux_tmp_y_175, textStyle)
        end
        do
          local __lux_tmp_color_176 = record.color
          if __lux_tmp_color_176 == nil then
            __lux_tmp_color_176 = __lux_module_1.white
          end
          local __lux_tmp_alignX_177 = record.alignX
          if __lux_tmp_alignX_177 == nil then
            __lux_tmp_alignX_177 = TEXT_ALIGN_LEFT
          end
          local __lux_tmp_alignY_178 = record.alignY
          if __lux_tmp_alignY_178 == nil then
            __lux_tmp_alignY_178 = TEXT_ALIGN_TOP
          end
          __lux_module_1.drawSimpleText(
            raw,
            __lux_module_1.setFontSafe(nativeFont),
            x,
            y,
            __lux_module_1.style.colorOr(fill, __lux_tmp_color_176),
            __lux_tmp_alignX_177,
            __lux_tmp_alignY_178
          )
        end
        return record
      end
      local layout = __lux_module_1.layoutFor(raw, record.font, textStyle, true, true)
      local x
      do
        local __lux_tmp_x_179 = record.x
        if __lux_tmp_x_179 == nil then
          __lux_tmp_x_179 = 0
        end
        x = __lux_tmp_x_179 - layout.w * __lux_module_1.alignFactor(record.alignX)
      end
      local y
      do
        local __lux_tmp_y_180 = record.y
        if __lux_tmp_y_180 == nil then
          __lux_tmp_y_180 = 0
        end
        y = __lux_tmp_y_180 - layout.h * __lux_module_1.alignFactor(record.alignY, true)
      end
      x, y = __lux_module_1.snapTextPos(x, y, textStyle)
      do
        local __lux_tmp_color_181 = record.color
        if __lux_tmp_color_181 == nil then
          __lux_tmp_color_181 = __lux_module_1.white
        end
        __lux_module_1.drawLayout(layout, x, y, fill, __lux_tmp_color_181)
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
      local resolved
      do
        local __lux_tmp_textStyle_182 = textStyle
        if __lux_tmp_textStyle_182 == nil then
          __lux_tmp_textStyle_182 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_textStyle_182)
      end
      local record
      do
        local __lux_tmp_value_183 = value
        if __lux_tmp_value_183 == nil then
          __lux_tmp_value_183 = ""
        end
        local __lux_tmp_font_184 = resolved.font
        if __lux_tmp_font_184 == nil then
          __lux_tmp_font_184 = font
        end
        if __lux_tmp_font_184 == nil then
          __lux_tmp_font_184 = "DermaDefault"
        end
        local __lux_tmp_x_185 = __lux_module_1.toNumber(x)
        if __lux_tmp_x_185 == nil then
          __lux_tmp_x_185 = 0
        end
        local __lux_tmp_y_186 = __lux_module_1.toNumber(y)
        if __lux_tmp_y_186 == nil then
          __lux_tmp_y_186 = 0
        end
        local __lux_tmp_color_187 = color
        if __lux_tmp_color_187 == nil then
          __lux_tmp_color_187 = resolved.color
        end
        if __lux_tmp_color_187 == nil then
          __lux_tmp_color_187 = resolved.fill
        end
        local __lux_tmp_alignX_188 = resolved.alignX
        if __lux_tmp_alignX_188 == nil then
          __lux_tmp_alignX_188 = resolved.align
        end
        if __lux_tmp_alignX_188 == nil then
          __lux_tmp_alignX_188 = ax
        end
        if __lux_tmp_alignX_188 == nil then
          __lux_tmp_alignX_188 = TEXT_ALIGN_LEFT
        end
        local __lux_tmp_alignY_189 = resolved.alignY
        if __lux_tmp_alignY_189 == nil then
          __lux_tmp_alignY_189 = resolved.valign
        end
        if __lux_tmp_alignY_189 == nil then
          __lux_tmp_alignY_189 = ay
        end
        if __lux_tmp_alignY_189 == nil then
          __lux_tmp_alignY_189 = TEXT_ALIGN_TOP
        end
        record = {
          text = __lux_module_1.toString(__lux_tmp_value_183),
          font = __lux_tmp_font_184,
          x = __lux_tmp_x_185,
          y = __lux_tmp_y_186,
          color = __lux_module_1.style.colorOr(__lux_tmp_color_187, __lux_module_1.white),
          alignX = __lux_tmp_alignX_188,
          alignY = __lux_tmp_alignY_189,
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
        local __lux_tmp_textStyle_190 = textStyle
        if __lux_tmp_textStyle_190 == nil then
          __lux_tmp_textStyle_190 = {}
        end
        out = __lux_module_1.copyValue(__lux_tmp_textStyle_190)
      end
      out.alignY = TEXT_ALIGN_TOP
      out.valign = TEXT_ALIGN_TOP
      return out
    end
    __lux_module_1.boxEx = function(value, font, x, y, w, h, textStyle)
      local resolved
      do
        local __lux_tmp_textStyle_191 = textStyle
        if __lux_tmp_textStyle_191 == nil then
          __lux_tmp_textStyle_191 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_textStyle_191)
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
        local __lux_tmp_w_192 = __lux_module_1.toNumber(w)
        if __lux_tmp_w_192 == nil then
          __lux_tmp_w_192 = 0
        end
        lines = __lux_module_1.wrapText(value, resolvedFont, __lux_tmp_w_192, resolved.overflow)
      end
      local nativeFont, alias, oversample = __lux_module_1.nativeFor(resolvedFont, resolved)
      local lineHeight = __lux_module_1.lineHeightFor(nativeFont, alias, resolved, oversample)
      local totalH = #lines * lineHeight
      local startY
      do
        local __lux_tmp_y_193 = __lux_module_1.toNumber(y)
        if __lux_tmp_y_193 == nil then
          __lux_tmp_y_193 = 0
        end
        local __lux_tmp_h_194 = __lux_module_1.toNumber(h)
        if __lux_tmp_h_194 == nil then
          __lux_tmp_h_194 = totalH
        end
        local __lux_tmp_alignY_195 = resolved.alignY
        if __lux_tmp_alignY_195 == nil then
          __lux_tmp_alignY_195 = resolved.valign
        end
        if __lux_tmp_alignY_195 == nil then
          __lux_tmp_alignY_195 = TEXT_ALIGN_TOP
        end
        startY = __lux_tmp_y_193 + (__lux_tmp_h_194 - totalH) * __lux_module_1.alignFactor(__lux_tmp_alignY_195, true)
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
        local __lux_tmp_x_196 = __lux_module_1.toNumber(x)
        if __lux_tmp_x_196 == nil then
          __lux_tmp_x_196 = 0
        end
        local __lux_tmp_w_197 = __lux_module_1.toNumber(w)
        if __lux_tmp_w_197 == nil then
          __lux_tmp_w_197 = 0
        end
        tx = __lux_tmp_x_196 + __lux_tmp_w_197 * __lux_module_1.alignFactor(ax)
      end
      local lineStyle = __lux_module_1.textBoxLineStyle(resolved)
      for index = 1, #lines do
        do
          local __lux_tmp_color_198 = lineStyle.color
          if __lux_tmp_color_198 == nil then
            __lux_tmp_color_198 = lineStyle.fill
          end
          __lux_module_1.drawEx(
            lines[index],
            resolvedFont,
            tx,
            startY + (index - 1) * lineHeight,
            __lux_tmp_color_198,
            ax,
            TEXT_ALIGN_TOP,
            lineStyle
          )
        end
      end
    end
    __lux_module_1.batch = function(records)
      do
        local __lux_tmp_records_199 = records
        if __lux_tmp_records_199 == nil then
          __lux_tmp_records_199 = {}
        end
        for index = 1, #__lux_tmp_records_199 do
          local record = records[index]
          do
            local __lux_tmp_alignX_200 = record.alignX
            if __lux_tmp_alignX_200 == nil then
              __lux_tmp_alignX_200 = record.ax
            end
            local __lux_tmp_alignY_201 = record.alignY
            if __lux_tmp_alignY_201 == nil then
              __lux_tmp_alignY_201 = record.ay
            end
            local __lux_tmp_style_202 = record.style
            if __lux_tmp_style_202 == nil then
              __lux_tmp_style_202 = {}
            end
            __lux_module_1.drawNativeFallbackRecord(
              {
                text = record.text,
                font = record.font,
                x = record.x,
                y = record.y,
                color = record.color,
                alignX = __lux_tmp_alignX_200,
                alignY = __lux_tmp_alignY_201,
                style = __lux_module_1.resolveStyle(__lux_tmp_style_202),
              }
            )
          end
        end
      end
      return records
    end
    __lux_module_1.prewarm = function(value, font, textStyle)
      local resolved
      do
        local __lux_tmp_textStyle_203 = textStyle
        if __lux_tmp_textStyle_203 == nil then
          __lux_tmp_textStyle_203 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_textStyle_203)
      end
      local layout
      do
        local __lux_tmp_font_204 = font
        if __lux_tmp_font_204 == nil then
          __lux_tmp_font_204 = resolved.font
        end
        if __lux_tmp_font_204 == nil then
          __lux_tmp_font_204 = "DermaDefault"
        end
        layout = __lux_module_1.layoutFor(value, __lux_tmp_font_204, resolved)
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
        local __lux_tmp_times_205 = __lux_module_1.profile.times
        if __lux_tmp_times_205 == nil then
          __lux_tmp_times_205 = {}
        end
        local __lux_tmp_counts_206 = __lux_module_1.profile.counts
        if __lux_tmp_counts_206 == nil then
          __lux_tmp_counts_206 = {}
        end
        out = {
          active = __lux_module_1.profile.active,
          draws = __lux_module_1.profile.draws,
          measures = __lux_module_1.profile.measures,
          times = __lux_module_1.tableCopy(__lux_tmp_times_205),
          counts = __lux_module_1.tableCopy(__lux_tmp_counts_206),
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
        local __lux_tmp_textComposedEntries_207 = stats.textComposedEntries
        if __lux_tmp_textComposedEntries_207 == nil then
          __lux_tmp_textComposedEntries_207 = 0
        end
        stats.textComposedEntries = __lux_tmp_textComposedEntries_207
      end
      do
        local __lux_tmp_textComposedEvicts_208 = stats.textComposedEvicts
        if __lux_tmp_textComposedEvicts_208 == nil then
          __lux_tmp_textComposedEvicts_208 = 0
        end
        stats.textComposedEvicts = __lux_tmp_textComposedEvicts_208
      end
      do
        local __lux_tmp_textMeasureHits_209 = stats.textMeasureHits
        if __lux_tmp_textMeasureHits_209 == nil then
          __lux_tmp_textMeasureHits_209 = 0
        end
        stats.textMeasureHits = __lux_tmp_textMeasureHits_209
      end
      do
        local __lux_tmp_textMeasureMisses_210 = stats.textMeasureMisses
        if __lux_tmp_textMeasureMisses_210 == nil then
          __lux_tmp_textMeasureMisses_210 = 0
        end
        stats.textMeasureMisses = __lux_tmp_textMeasureMisses_210
      end
      do
        local __lux_tmp_textEntryCacheHits_211 = stats.textEntryCacheHits
        if __lux_tmp_textEntryCacheHits_211 == nil then
          __lux_tmp_textEntryCacheHits_211 = 0
        end
        stats.textEntryCacheHits = __lux_tmp_textEntryCacheHits_211
      end
      do
        local __lux_tmp_textEntryCacheMisses_212 = stats.textEntryCacheMisses
        if __lux_tmp_textEntryCacheMisses_212 == nil then
          __lux_tmp_textEntryCacheMisses_212 = 0
        end
        stats.textEntryCacheMisses = __lux_tmp_textEntryCacheMisses_212
      end
      do
        local __lux_tmp_textFallbacks_213 = stats.textFallbacks
        if __lux_tmp_textFallbacks_213 == nil then
          __lux_tmp_textFallbacks_213 = 0
        end
        stats.textFallbacks = __lux_tmp_textFallbacks_213
      end
      stats.textDataDraws = 0
      stats.textDataBatches = 0
      stats.textAtlasUploads = 0
      stats.textAtlasGlyphs = 0
      do
        local __lux_tmp_textAtlasResets_214 = stats.textAtlasResets
        if __lux_tmp_textAtlasResets_214 == nil then
          __lux_tmp_textAtlasResets_214 = 0
        end
        stats.textAtlasResets = __lux_tmp_textAtlasResets_214
      end
      stats.textCacheSize = __lux_module_1.measureOrderCount
      return stats
    end
    __lux_module_1.statAdd = function(stats, key, amount)
      if amount == nil then
        amount = 1
      end
      do
        local __lux_tmp_key_215 = stats[key]
        if __lux_tmp_key_215 == nil then
          __lux_tmp_key_215 = 0
        end
        stats[key] = __lux_tmp_key_215 + amount
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
          local __lux_tmp_getConVar_216 = __lux_module_1.getConVar("mgfx_text_composed")
          if __lux_tmp_getConVar_216 == nil then
            __lux_tmp_getConVar_216 = false
          end
          __lux_module_1.composedCvar = __lux_tmp_getConVar_216
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
          local __lux_tmp_getConVar_217 = __lux_module_1.getConVar("mgfx_text_composed_budget")
          if __lux_tmp_getConVar_217 == nil then
            __lux_tmp_getConVar_217 = false
          end
          __lux_module_1.budgetCvar = __lux_tmp_getConVar_217
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
          local __lux_tmp_alpha_218 = alpha
          if __lux_tmp_alpha_218 == nil then
            __lux_tmp_alpha_218 = 1
          end
          __lux_module_1.surfaceSetAlphaMultiplier(__lux_tmp_alpha_218)
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
        local __lux_tmp_x_219 = x
        if __lux_tmp_x_219 == nil then
          __lux_tmp_x_219 = 0
        end
        x = __lux_module_1.mathFloor(__lux_module_1.mathMax(0, __lux_tmp_x_219))
      end
      do
        local __lux_tmp_y_220 = y
        if __lux_tmp_y_220 == nil then
          __lux_tmp_y_220 = 0
        end
        y = __lux_module_1.mathFloor(__lux_module_1.mathMax(0, __lux_tmp_y_220))
      end
      do
        local __lux_tmp_w_221 = w
        if __lux_tmp_w_221 == nil then
          __lux_tmp_w_221 = 0
        end
        w = __lux_module_1.mathCeil(
          __lux_module_1.mathMin(__lux_module_1.ATLAS_W - x, __lux_tmp_w_221)
        )
      end
      do
        local __lux_tmp_h_222 = h
        if __lux_tmp_h_222 == nil then
          __lux_tmp_h_222 = 0
        end
        h = __lux_module_1.mathCeil(
          __lux_module_1.mathMin(__lux_module_1.ATLAS_H - y, __lux_tmp_h_222)
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
          local __lux_obj_mats_223 = mats
          local __lux_val_compose_224 = nil
          if __lux_obj_mats_223 ~= nil then
            __lux_val_compose_224 = __lux_obj_mats_223.compose
          end
          page.composeMat = __lux_val_compose_224
        end
        do
          local __lux_obj_mats_225 = mats
          local __lux_val_face_226 = nil
          if __lux_obj_mats_225 ~= nil then
            __lux_val_face_226 = __lux_obj_mats_225.face
          end
          page.faceMat = __lux_val_face_226
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
        local __lux_tmp_generation_227 = page.generation
        if __lux_tmp_generation_227 == nil then
          __lux_tmp_generation_227 = 0
        end
        page.generation = __lux_tmp_generation_227 + 1
      end
      if page.rt ~= nil then
        do
          local __lux_tmp_w_228 = page.w
          if __lux_tmp_w_228 == nil then
            __lux_tmp_w_228 = __lux_module_1.ATLAS_W
          end
          local __lux_tmp_h_229 = page.h
          if __lux_tmp_h_229 == nil then
            __lux_tmp_h_229 = __lux_module_1.ATLAS_H
          end
          __lux_module_1.clearRenderTargetAlpha(page.rt, __lux_tmp_w_228, __lux_tmp_h_229)
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
        local __lux_obj_atlas_230 = __lux_module_1.atlas
        local __lux_tmp_material_231 = nil
        if __lux_obj_atlas_230 ~= nil then
          __lux_tmp_material_231 = __lux_obj_atlas_230.material
        end
        if __lux_tmp_material_231 == nil then
          __lux_tmp_material_231 = __lux_module_1.atlasMat
        end
        __lux_module_1.atlasMat = __lux_tmp_material_231
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
        local __lux_tmp_gutter_232 = __lux_module_1.toNumber(gutter)
        if __lux_tmp_gutter_232 == nil then
          __lux_tmp_gutter_232 = 0
        end
        gutter = __lux_module_1.mathCeil(__lux_module_1.mathMax(0, __lux_tmp_gutter_232))
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
          local __lux_tmp_h_233 = page.h
          if __lux_tmp_h_233 == nil then
            __lux_tmp_h_233 = __lux_module_1.ATLAS_H
          end
          local __lux_tmp_y_234 = page.y
          if __lux_tmp_y_234 == nil then
            __lux_tmp_y_234 = 0
          end
          local __lux_tmp_rowH_235 = page.rowH
          if __lux_tmp_rowH_235 == nil then
            __lux_tmp_rowH_235 = 0
          end
          usedH = usedH + __lux_module_1.mathMin(__lux_tmp_h_233, __lux_tmp_y_234 + __lux_tmp_rowH_235)
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
      local __lux_tmp_r_236 = c.r
      if __lux_tmp_r_236 == nil then
        __lux_tmp_r_236 = 0
      end
      local __lux_tmp_g_237 = c.g
      if __lux_tmp_g_237 == nil then
        __lux_tmp_g_237 = 0
      end
      local __lux_tmp_b_238 = c.b
      if __lux_tmp_b_238 == nil then
        __lux_tmp_b_238 = 0
      end
      local __lux_tmp_a_239 = c.a
      if __lux_tmp_a_239 == nil then
        __lux_tmp_a_239 = 255
      end
      return __lux_module_1.tableConcat(
        { __lux_tmp_r_236, __lux_tmp_g_237, __lux_tmp_b_238, __lux_tmp_a_239 },
        ","
      )
    end
    __lux_module_1.isColorValue = function(value)
      return __lux_module_1.style.isColor ~= nil and __lux_module_1.style.isColor(value)
    end
    __lux_module_1.fillForRecord = function(record)
      local textStyle
      do
        local __lux_obj_record_240 = record
        local __lux_val_style_241 = nil
        if __lux_obj_record_240 ~= nil then
          __lux_val_style_241 = __lux_obj_record_240.style
        end
        textStyle = __lux_val_style_241
        if textStyle == nil then
          textStyle = {}
        end
      end
      local __lux_tmp_fill_242 = textStyle.fill
      if __lux_tmp_fill_242 == nil then
        __lux_tmp_fill_242 = textStyle.color
      end
      if __lux_tmp_fill_242 == nil then
        local __lux_obj_record_243 = record
        local __lux_val_color_244 = nil
        if __lux_obj_record_243 ~= nil then
          __lux_val_color_244 = __lux_obj_record_243.color
        end
        __lux_tmp_fill_242 = __lux_val_color_244
      end
      if __lux_tmp_fill_242 == nil then
        __lux_tmp_fill_242 = __lux_module_1.white
      end
      return __lux_tmp_fill_242
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
        local __lux_tmp_strength_245 = value.strength
        if __lux_tmp_strength_245 == nil then
          __lux_tmp_strength_245 = value[1]
        end
        local __lux_tmp_strength_246 = __lux_module_1.toNumber(__lux_tmp_strength_245)
        if __lux_tmp_strength_246 == nil then
          __lux_tmp_strength_246 = 0.18
        end
        strength = __lux_module_1.mathClamp(__lux_tmp_strength_246, 0, 1)
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
        local __lux_tmp_stroke_247 = textStyle.stroke
        if __lux_tmp_stroke_247 == nil then
          __lux_tmp_stroke_247 = textStyle.outline
        end
        stroke = __lux_module_1.normalizeStroke(__lux_tmp_stroke_247)
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
      local __lux_tmp_248
      if stroke ~= nil then
        __lux_tmp_248 = stroke.width ..
          ":" ..
            stroke.samples .. ":" .. stroke.softness .. ":" .. __lux_module_1.colorKey(stroke.color)
      else
        __lux_tmp_248 = ""
      end
      local __lux_tmp_249
      if glow ~= nil then
        do
          local __lux_tmp_falloff_250 = glow.falloff
          if __lux_tmp_falloff_250 == nil then
            __lux_tmp_falloff_250 = ""
          end
          __lux_tmp_249 = glow.width ..
            ":" ..
              glow.strength ..
                ":" .. __lux_tmp_falloff_250 .. ":" .. __lux_module_1.colorKey(glow.color)
        end
      else
        __lux_tmp_249 = ""
      end
      local __lux_tmp_251
      if shadow ~= nil then
        __lux_tmp_251 = shadow.x ..
          ":" ..
            shadow.y ..
              ":" ..
                shadow.blur .. ":" .. shadow.strength .. ":" .. __lux_module_1.colorKey(shadow.color)
      else
        __lux_tmp_251 = ""
      end
      local __lux_tmp_252
      if face ~= nil then
        __lux_tmp_252 = __lux_module_1.toString(face.strength)
      else
        __lux_tmp_252 = ""
      end
      local __lux_tmp_weightAdjust_253 = weightAdjust
      if __lux_tmp_weightAdjust_253 == nil then
        __lux_tmp_weightAdjust_253 = 0
      end
      return __lux_module_1.tableConcat(
        {
          __lux_tmp_248,
          __lux_tmp_249,
          __lux_tmp_251,
          __lux_tmp_252,
          __lux_module_1.toString(__lux_tmp_weightAdjust_253),
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
        local __lux_tmp_tracking_254 = textStyle.tracking
        if __lux_tmp_tracking_254 == nil then
          __lux_tmp_tracking_254 = textStyle.letterSpacing
        end
        tracking = __lux_module_1.toNumber(__lux_tmp_tracking_254)
        if tracking == nil then
          tracking = alias.tracking
          if tracking == nil then
            tracking = 0
          end
        end
      end
      local lineHeight = __lux_module_1.lineHeightFor(nativeFont, alias, textStyle, oversample)
      local __lux_tmp_text_255 = record.text
      if __lux_tmp_text_255 == nil then
        __lux_tmp_text_255 = ""
      end
      local __lux_tmp_font_256 = record.font
      if __lux_tmp_font_256 == nil then
        __lux_tmp_font_256 = ""
      end
      local __lux_tmp_nativeFont_257 = nativeFont
      if __lux_tmp_nativeFont_257 == nil then
        __lux_tmp_nativeFont_257 = ""
      end
      local __lux_tmp_oversample_258 = oversample
      if __lux_tmp_oversample_258 == nil then
        __lux_tmp_oversample_258 = 1
      end
      local __lux_obj_info_259 = info
      local __lux_tmp_routeKey_260 = nil
      if __lux_obj_info_259 ~= nil then
        __lux_tmp_routeKey_260 = __lux_obj_info_259.routeKey
      end
      if __lux_tmp_routeKey_260 == nil then
        __lux_tmp_routeKey_260 = ""
      end
      return __lux_module_1.CACHE_VERSION ..
        "30" ..
          __lux_module_1.toString(__lux_tmp_text_255) ..
            "30" ..
              __lux_module_1.toString(__lux_tmp_font_256) ..
                "30" ..
                  __lux_module_1.toString(__lux_tmp_nativeFont_257) ..
                    "30" ..
                      __lux_module_1.toString(__lux_tmp_oversample_258) ..
                        "30" ..
                          __lux_module_1.toString(tracking) ..
                            "30" ..
                              __lux_module_1.toString(lineHeight) ..
                                "30" .. __lux_module_1.toString(__lux_tmp_routeKey_260)
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
        local __lux_tmp_r_261 = c.r
        if __lux_tmp_r_261 == nil then
          __lux_tmp_r_261 = 255
        end
        local __lux_tmp_g_262 = c.g
        if __lux_tmp_g_262 == nil then
          __lux_tmp_g_262 = 255
        end
        local __lux_tmp_b_263 = c.b
        if __lux_tmp_b_263 == nil then
          __lux_tmp_b_263 = 255
        end
        local __lux_tmp_a_264 = c.a
        if __lux_tmp_a_264 == nil then
          __lux_tmp_a_264 = 255
        end
        __lux_module_1.surfaceSetDrawColor(
          __lux_tmp_r_261,
          __lux_tmp_g_262,
          __lux_tmp_b_263,
          __lux_tmp_a_264
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
        local __lux_tmp_268 = shaderCapableFace
        if __lux_tmp_268 then
          local __lux_tmp_267 = face ~= nil
          if not __lux_tmp_267 then
            local __lux_tmp_weightAdjust_265 = weightAdjust
            if __lux_tmp_weightAdjust_265 == nil then
              __lux_tmp_weightAdjust_265 = 0
            end
            local __lux_cmp_266 = false
            if __lux_module_1.mathAbs(__lux_tmp_weightAdjust_265) ~= nil then
              __lux_cmp_266 = __lux_module_1.mathAbs(__lux_tmp_weightAdjust_265) > 0.001
            end
            __lux_tmp_267 = __lux_cmp_266
          end
          __lux_tmp_268 = __lux_tmp_267
        end
        shaderFace = __lux_tmp_268
      end
      if not shaderFace and shaderCapableFace then
        shaderFace = shadow ~= nil or stroke ~= nil or glow ~= nil
      end
      local entry
      do
        local __lux_tmp_weightAdjust_269 = weightAdjust
        if __lux_tmp_weightAdjust_269 == nil then
          __lux_tmp_weightAdjust_269 = 0
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
          weightAdjust = __lux_tmp_weightAdjust_269,
          shaderFace = shaderFace,
          generation = page.generation,
        }
      end
      __lux_module_1.composedCache[key] = entry
      __lux_module_1.composedCacheCount = __lux_module_1.composedCacheCount + 1
      do
        local __lux_tmp_stats_270 = stats
        if __lux_tmp_stats_270 == nil then
          __lux_tmp_stats_270 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_270, "textComposedBakes")
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
          local __lux_tmp_stats_271 = stats
          if __lux_tmp_stats_271 == nil then
            __lux_tmp_stats_271 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_271, "textEntryCacheHits")
        end
        return cached
      end
      do
        local __lux_tmp_stats_272 = stats
        if __lux_tmp_stats_272 == nil then
          __lux_tmp_stats_272 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_272, "textEntryCacheMisses")
      end
      local __lux_tmp_275 = not prewarm
      if __lux_tmp_275 then
        local __lux_cmp_274 = false
        if __lux_module_1.textComposeBudget() ~= nil then
          __lux_cmp_274 = __lux_module_1.bakesThisFrame >= __lux_module_1.textComposeBudget()
        end
        __lux_tmp_275 = __lux_cmp_274
      end
      if __lux_tmp_275 then
        return nil
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
      local __lux_tmp_278 = info.shadow ~= nil or info.stroke ~= nil or info.glow ~= nil or info.face ~= nil
      if not __lux_tmp_278 then
        local __lux_tmp_weightAdjust_276 = info.weightAdjust
        if __lux_tmp_weightAdjust_276 == nil then
          __lux_tmp_weightAdjust_276 = 0
        end
        local __lux_cmp_277 = false
        if __lux_module_1.mathAbs(__lux_tmp_weightAdjust_276) ~= nil then
          __lux_cmp_277 = __lux_module_1.mathAbs(__lux_tmp_weightAdjust_276) > 0.001
        end
        __lux_tmp_278 = __lux_cmp_277
      end
      local __lux_tmp_279 = __lux_tmp_278
      if not __lux_tmp_279 then
        __lux_tmp_279 = __lux_module_1.fillNeedsShader(__lux_module_1.fillForRecord(record))
      end
      return __lux_tmp_279
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
        local __lux_tmp_records_280 = records
        if __lux_tmp_records_280 == nil then
          __lux_tmp_records_280 = {}
        end
        for _, record in ipairs(__lux_tmp_records_280) do
          if __lux_module_1.recordNeedsComposedEntry(record) then
            record.__mgfxTextRoute = "compose"
            composeCount = composeCount + 1
          else
            if __lux_module_1.recordHasShaderWork(record) then
              record.__mgfxTextRoute = "nativeFallback"
            else
              record.__mgfxTextRoute = "native"
            end
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
          local __lux_tmp_stats_281 = stats
          if __lux_tmp_stats_281 == nil then
            __lux_tmp_stats_281 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_281, "textComposedPrewarmFails")
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
                local __lux_tmp_stats_282 = stats
                if __lux_tmp_stats_282 == nil then
                  __lux_tmp_stats_282 = {}
                end
                __lux_module_1.statAdd(__lux_tmp_stats_282, "textComposedPrewarmFails")
              end
              return false
            end
            record.__mgfxTextEntry = entry
            if __lux_module_1.atlasEpoch ~= generation then
              do
                local __lux_tmp_stats_283 = stats
                if __lux_tmp_stats_283 == nil then
                  __lux_tmp_stats_283 = {}
                end
                __lux_module_1.statAdd(__lux_tmp_stats_283, "textComposedPrewarmRestarts")
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
        local __lux_tmp_stats_284 = stats
        if __lux_tmp_stats_284 == nil then
          __lux_tmp_stats_284 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_284, "textComposedPrewarmFails")
      end
      return false
    end
    __lux_module_1.hasShaderFx = function(entry)
      local __lux_tmp_287 = entry ~= nil
      if __lux_tmp_287 then
        local __lux_tmp_286 = entry.shadow ~= nil or entry.stroke ~= nil or entry.glow ~= nil or entry.face ~= nil
        if not __lux_tmp_286 then
          local __lux_tmp_weightAdjust_285 = entry.weightAdjust
          if __lux_tmp_weightAdjust_285 == nil then
            __lux_tmp_weightAdjust_285 = 0
          end
          __lux_tmp_286 = __lux_tmp_weightAdjust_285 ~= 0
        end
        __lux_tmp_287 = __lux_tmp_286
      end
      return __lux_tmp_287
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
        local __lux_tmp_color_288 = effect.color
        if __lux_tmp_color_288 == nil then
          __lux_tmp_color_288 = __lux_module_1.white
        end
        r, g, b, a = __lux_module_1.style.color01(__lux_tmp_color_288)
      end
      return r, g, b, __lux_module_1.mathClamp(a * scale, 0, 1)
    end
    __lux_module_1.packShadowParams = function(x, y, stroke)
      do
        local __lux_tmp_x_289 = __lux_module_1.toNumber(x)
        if __lux_tmp_x_289 == nil then
          __lux_tmp_x_289 = 0
        end
        x = __lux_module_1.mathClamp(__lux_tmp_x_289, -64, 63.5)
      end
      do
        local __lux_tmp_y_290 = __lux_module_1.toNumber(y)
        if __lux_tmp_y_290 == nil then
          __lux_tmp_y_290 = 0
        end
        y = __lux_module_1.mathClamp(__lux_tmp_y_290, -64, 63.5)
      end
      local xb = __lux_module_1.mathClamp(__lux_module_1.mathFloor((x + 64) * 2 + 0.5), 0, 255)
      local yb = __lux_module_1.mathClamp(__lux_module_1.mathFloor((y + 64) * 2 + 0.5), 0, 255)
      local softness
      do
        local __lux_obj_stroke_291 = stroke
        local __lux_val_softness_292 = nil
        if __lux_obj_stroke_291 ~= nil then
          __lux_val_softness_292 = __lux_obj_stroke_291.softness
        end
        softness = __lux_val_softness_292
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
        local __lux_obj_shadow_293 = shadow
        local __lux_val_blur_294 = nil
        if __lux_obj_shadow_293 ~= nil then
          __lux_val_blur_294 = __lux_obj_shadow_293.blur
        end
        blur = __lux_val_blur_294
        if blur == nil then
          blur = 0
        end
      end
      local falloff
      do
        local __lux_obj_glow_295 = glow
        local __lux_val_falloff_296 = nil
        if __lux_obj_glow_295 ~= nil then
          __lux_val_falloff_296 = __lux_obj_glow_295.falloff
        end
        falloff = __lux_val_falloff_296
        if falloff == nil then
          falloff = 1.65
        end
      end
      local faceStrength
      do
        local __lux_obj_face_297 = face
        local __lux_val_strength_298 = nil
        if __lux_obj_face_297 ~= nil then
          __lux_val_strength_298 = __lux_obj_face_297.strength
        end
        faceStrength = __lux_val_strength_298
        if faceStrength == nil then
          faceStrength = 0
        end
      end
      local weight
      do
        local __lux_tmp_weightAdjust_299 = __lux_module_1.toNumber(weightAdjust)
        if __lux_tmp_weightAdjust_299 == nil then
          __lux_tmp_weightAdjust_299 = 0
        end
        weight = __lux_module_1.mathClamp(__lux_tmp_weightAdjust_299, -2, 2)
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
        local __lux_obj_glow_300 = glow
        local __lux_tmp_strength_301 = nil
        if __lux_obj_glow_300 ~= nil then
          __lux_tmp_strength_301 = __lux_obj_glow_300.strength
        end
        if __lux_tmp_strength_301 == nil then
          __lux_tmp_strength_301 = 1
        end
        r, g, b, a = __lux_module_1.scaledColor01(glow, __lux_tmp_strength_301)
      end
      material:SetFloat("$c1_x", r)
      material:SetFloat("$c1_y", g)
      material:SetFloat("$c1_z", b)
      material:SetFloat("$c1_w", a)
      do
        local __lux_obj_shadow_302 = shadow
        local __lux_tmp_strength_303 = nil
        if __lux_obj_shadow_302 ~= nil then
          __lux_tmp_strength_303 = __lux_obj_shadow_302.strength
        end
        if __lux_tmp_strength_303 == nil then
          __lux_tmp_strength_303 = 1
        end
        r, g, b, a = __lux_module_1.scaledColor01(shadow, __lux_tmp_strength_303)
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
        local __lux_obj_scaledStroke_304 = scaledStroke
        local __lux_tmp_width_305 = nil
        if __lux_obj_scaledStroke_304 ~= nil then
          __lux_tmp_width_305 = __lux_obj_scaledStroke_304.width
        end
        if __lux_tmp_width_305 == nil then
          __lux_tmp_width_305 = 0
        end
        material:SetFloat("$c3_x", __lux_tmp_width_305)
      end
      do
        local __lux_tmp_306
        if glow ~= nil then
          __lux_tmp_306 = glow.width * oversample
        else
          __lux_tmp_306 = 0
        end
        material:SetFloat("$c3_y", __lux_tmp_306)
      end
      do
        local __lux_tmp_weightAdjust_307 = entry.weightAdjust
        if __lux_tmp_weightAdjust_307 == nil then
          __lux_tmp_weightAdjust_307 = 0
        end
        material:SetFloat(
          "$c3_z",
          __lux_module_1.packEffectParams(
            glow,
            scaledShadow,
            face,
            __lux_tmp_weightAdjust_307 * oversample,
            entry.shaderFace
          )
        )
      end
      local __lux_tmp_308
      if scaledShadow ~= nil then
        __lux_tmp_308 = __lux_module_1.packShadowParams(scaledShadow.x, scaledShadow.y, scaledStroke)
      else
        __lux_tmp_308 = __lux_module_1.packShadowParams(0, 0, scaledStroke)
      end
      return material:SetFloat("$c3_w", __lux_tmp_308)
    end
    __lux_module_1.fillEndpointColors = function(fill, fallback)
      if __lux_module_1.isColorValue(fill) then
        return fill, fill
      end
      if __lux_module_1.typeOf(fill) == "table" and __lux_module_1.typeOf(fill.stops) == "table" and #fill.stops > 0 then
        local first = fill.stops[1]
        local last = fill.stops[#fill.stops]
        local __lux_tmp_color_309 = first.color
        if __lux_tmp_color_309 == nil then
          __lux_tmp_color_309 = first[2]
        end
        local __lux_tmp_fallback_310 = fallback
        if __lux_tmp_fallback_310 == nil then
          __lux_tmp_fallback_310 = __lux_module_1.white
        end
        local __lux_tmp_color_311 = last.color
        if __lux_tmp_color_311 == nil then
          __lux_tmp_color_311 = last[2]
        end
        local __lux_tmp_fallback_312 = fallback
        if __lux_tmp_fallback_312 == nil then
          __lux_tmp_fallback_312 = __lux_module_1.white
        end
        return __lux_module_1.style.asColor(__lux_tmp_color_309, __lux_tmp_fallback_310), __lux_module_1.style.asColor(__lux_tmp_color_311, __lux_tmp_fallback_312)
      end
      if __lux_module_1.typeOf(fill) == "table" then
        local a
        do
          local __lux_tmp_colorA_313 = fill.colorA
          if __lux_tmp_colorA_313 == nil then
            __lux_tmp_colorA_313 = fill[1]
          end
          local __lux_tmp_fallback_314 = fallback
          if __lux_tmp_fallback_314 == nil then
            __lux_tmp_fallback_314 = __lux_module_1.white
          end
          a = __lux_module_1.style.asColor(__lux_tmp_colorA_313, __lux_tmp_fallback_314)
        end
        local __lux_tmp_colorB_315 = fill.colorB
        if __lux_tmp_colorB_315 == nil then
          __lux_tmp_colorB_315 = fill[2]
        end
        return a, __lux_module_1.style.asColor(__lux_tmp_colorB_315, a)
      end
      local c
      do
        local __lux_tmp_fallback_316 = fallback
        if __lux_tmp_fallback_316 == nil then
          __lux_tmp_fallback_316 = __lux_module_1.white
        end
        c = __lux_module_1.style.asColor(fill, __lux_tmp_fallback_316)
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
        local __lux_tmp_color_317 = record.color
        if __lux_tmp_color_317 == nil then
          __lux_tmp_color_317 = __lux_module_1.white
        end
        colorA, colorB = __lux_module_1.fillEndpointColors(fill, __lux_tmp_color_317)
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
          local __lux_tmp_x1_318 = __lux_module_1.toNumber(fill.x1)
          if __lux_tmp_x1_318 == nil then
            __lux_tmp_x1_318 = 0
          end
          material:SetFloat("$c3_x", __lux_tmp_x1_318)
        end
        do
          local __lux_tmp_y1_319 = __lux_module_1.toNumber(fill.y1)
          if __lux_tmp_y1_319 == nil then
            __lux_tmp_y1_319 = 0
          end
          material:SetFloat("$c3_y", __lux_tmp_y1_319)
        end
        do
          local __lux_tmp_x2_320 = __lux_module_1.toNumber(fill.x2)
          if __lux_tmp_x2_320 == nil then
            __lux_tmp_x2_320 = 1
          end
          material:SetFloat("$c3_z", __lux_tmp_x2_320)
        end
        do
          local __lux_tmp_y2_321 = __lux_module_1.toNumber(fill.y2)
          if __lux_tmp_y2_321 == nil then
            __lux_tmp_y2_321 = 0
          end
          material:SetFloat("$c3_w", __lux_tmp_y2_321)
        end
      else
        material:SetFloat("$c3_x", 0)
        material:SetFloat("$c3_y", 0)
        material:SetFloat("$c3_z", 1)
        material:SetFloat("$c3_w", 0)
      end
    end
    __lux_module_1.drawEntryAt = function(entry, record, contentX, contentY, fillOverride, stats)
      local page
      do
        local __lux_obj_entry_322 = entry
        local __lux_val_page_323 = nil
        if __lux_obj_entry_322 ~= nil then
          __lux_val_page_323 = __lux_obj_entry_322.page
        end
        page = __lux_val_page_323
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
        local __lux_tmp_atlasW_324 = entry.atlasW
        if __lux_tmp_atlasW_324 == nil then
          __lux_tmp_atlasW_324 = entry.w
        end
        u1 = (entry.slotX + __lux_tmp_atlasW_324) / page.w
      end
      local v1
      do
        local __lux_tmp_atlasH_325 = entry.atlasH
        if __lux_tmp_atlasH_325 == nil then
          __lux_tmp_atlasH_325 = entry.h
        end
        v1 = (entry.slotY + __lux_tmp_atlasH_325) / page.h
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
          local __lux_tmp_fillOverride_326 = fillOverride
          if __lux_tmp_fillOverride_326 == nil then
            __lux_tmp_fillOverride_326 = __lux_module_1.fillForRecord(record)
          end
          local __lux_tmp_color_327 = record.color
          if __lux_tmp_color_327 == nil then
            __lux_tmp_color_327 = __lux_module_1.white
          end
          drawColor = __lux_module_1.style.asColor(__lux_tmp_fillOverride_326, __lux_tmp_color_327)
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
        local __lux_tmp_stats_328 = stats
        if __lux_tmp_stats_328 == nil then
          __lux_tmp_stats_328 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_328, "textComposedBlits", blits)
      end
      if fx then
        do
          local __lux_tmp_stats_329 = stats
          if __lux_tmp_stats_329 == nil then
            __lux_tmp_stats_329 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_329, "textShaderDraws")
        end
      end
      return fx
    end
    __lux_module_1.blitEntry = function(entry, record, stats)
      local contentX
      do
        local __lux_tmp_x_330 = record.x
        if __lux_tmp_x_330 == nil then
          __lux_tmp_x_330 = 0
        end
        contentX = __lux_tmp_x_330 - entry.contentW * __lux_module_1.alignFactor(record.alignX)
      end
      local contentY
      do
        local __lux_tmp_y_331 = record.y
        if __lux_tmp_y_331 == nil then
          __lux_tmp_y_331 = 0
        end
        contentY = __lux_tmp_y_331 - entry.contentH * __lux_module_1.alignFactor(record.alignY, true)
      end
      local fx = __lux_module_1.drawEntryAt(entry, record, contentX, contentY, nil, stats)
      if fx == nil then
        __lux_module_1.drawNativeFallbackRecord(record)
        do
          local __lux_tmp_stats_332 = stats
          if __lux_tmp_stats_332 == nil then
            __lux_tmp_stats_332 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_332, "textComposedFallbackRecords")
        end
        return nil
      end
      do
        local __lux_tmp_stats_333 = stats
        if __lux_tmp_stats_333 == nil then
          __lux_tmp_stats_333 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_333, "textComposedDraws")
      end
      if fx then
        do
          local __lux_tmp_stats_334 = stats
          if __lux_tmp_stats_334 == nil then
            __lux_tmp_stats_334 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_334, "textComposedFxDraws")
        end
      else
        do
          local __lux_tmp_stats_335 = stats
          if __lux_tmp_stats_335 == nil then
            __lux_tmp_stats_335 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_335, "textComposedFaceDraws")
        end
      end
      return fx
    end
    __lux_module_1.textBatchKey = function(entry, record)
      local page
      do
        local __lux_obj_entry_336 = entry
        local __lux_val_page_337 = nil
        if __lux_obj_entry_336 ~= nil then
          __lux_val_page_337 = __lux_obj_entry_336.page
        end
        page = __lux_val_page_337
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
        local __lux_tmp_index_338 = page.index
        if __lux_tmp_index_338 == nil then
          __lux_tmp_index_338 = 0
        end
        return "plain27" .. __lux_module_1.toString(__lux_tmp_index_338)
      end
      if not entry.shaderFace then
        return nil
      end
      if entry.batchKey ~= nil then
        return entry.batchKey
      end
      do
        local __lux_tmp_index_339 = page.index
        if __lux_tmp_index_339 == nil then
          __lux_tmp_index_339 = 0
        end
        local __lux_tmp_oversample_340 = entry.oversample
        if __lux_tmp_oversample_340 == nil then
          __lux_tmp_oversample_340 = 1
        end
        local __lux_tmp_341
        if entry.stroke ~= nil then
          __lux_tmp_341 = entry.stroke.width ..
            ":" .. entry.stroke.softness .. ":" .. __lux_module_1.colorKey(entry.stroke.color)
        else
          __lux_tmp_341 = ""
        end
        local __lux_tmp_342
        if entry.glow ~= nil then
          do
            local __lux_tmp_falloff_343 = entry.glow.falloff
            if __lux_tmp_falloff_343 == nil then
              __lux_tmp_falloff_343 = ""
            end
            __lux_tmp_342 = entry.glow.width ..
              ":" ..
                entry.glow.strength ..
                  ":" .. __lux_tmp_falloff_343 .. ":" .. __lux_module_1.colorKey(entry.glow.color)
          end
        else
          __lux_tmp_342 = ""
        end
        local __lux_tmp_344
        if entry.shadow ~= nil then
          __lux_tmp_344 = entry.shadow.x ..
            ":" ..
              entry.shadow.y ..
                ":" ..
                  entry.shadow.blur ..
                    ":" .. entry.shadow.strength .. ":" .. __lux_module_1.colorKey(entry.shadow.color)
        else
          __lux_tmp_344 = ""
        end
        local __lux_tmp_345
        if entry.face ~= nil then
          __lux_tmp_345 = __lux_module_1.toString(entry.face.strength)
        else
          __lux_tmp_345 = ""
        end
        local __lux_tmp_weightAdjust_346 = entry.weightAdjust
        if __lux_tmp_weightAdjust_346 == nil then
          __lux_tmp_weightAdjust_346 = 0
        end
        entry.batchKey = __lux_module_1.tableConcat(
          {
            __lux_tmp_index_339,
            __lux_tmp_oversample_340,
            __lux_tmp_341,
            __lux_tmp_342,
            __lux_tmp_344,
            __lux_tmp_345,
            __lux_module_1.toString(__lux_tmp_weightAdjust_346),
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
        local __lux_tmp_r_347 = color.r
        if __lux_tmp_r_347 == nil then
          __lux_tmp_r_347 = 255
        end
        local __lux_tmp_g_348 = color.g
        if __lux_tmp_g_348 == nil then
          __lux_tmp_g_348 = 255
        end
        local __lux_tmp_b_349 = color.b
        if __lux_tmp_b_349 == nil then
          __lux_tmp_b_349 = 255
        end
        local __lux_tmp_a_350 = color.a
        if __lux_tmp_a_350 == nil then
          __lux_tmp_a_350 = 255
        end
        __lux_module_1.meshColor(
          __lux_tmp_r_347,
          __lux_tmp_g_348,
          __lux_tmp_b_349,
          __lux_tmp_a_350
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
        local __lux_tmp_atlasW_351 = entry.atlasW
        if __lux_tmp_atlasW_351 == nil then
          __lux_tmp_atlasW_351 = entry.w
        end
        u1 = (entry.slotX + __lux_tmp_atlasW_351) / page.w
      end
      local v1
      do
        local __lux_tmp_atlasH_352 = entry.atlasH
        if __lux_tmp_atlasH_352 == nil then
          __lux_tmp_atlasH_352 = entry.h
        end
        v1 = (entry.slotY + __lux_tmp_atlasH_352) / page.h
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
          __lux_module_1.drawNativeFallbackRecord(record)
          return false
        end
        do
          local __lux_tmp_stats_353 = stats
          if __lux_tmp_stats_353 == nil then
            __lux_tmp_stats_353 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_353, "textComposedDraws")
        end
        do
          local __lux_tmp_stats_354 = stats
          if __lux_tmp_stats_354 == nil then
            __lux_tmp_stats_354 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_354, "textComposedFxDraws")
        end
        return true
      end
      local first = batch[1]
      local firstEntry = first.__mgfxTextEntry
      for index = 1, #batch do
        local entry = batch[index].__mgfxTextEntry
        if entry == nil or entry.page == nil or entry.generation ~= entry.page.generation then
          for _, record in ipairs(batch) do
            __lux_module_1.blitEntry(record.__mgfxTextEntry, record, stats)
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
          local __lux_obj_page_355 = firstEntry.page
          local __lux_val_material_356 = nil
          if __lux_obj_page_355 ~= nil then
            __lux_val_material_356 = __lux_obj_page_355.material
          end
          material = __lux_val_material_356
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
        local __lux_tmp_stats_357 = stats
        if __lux_tmp_stats_357 == nil then
          __lux_tmp_stats_357 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_357, "textComposedBlits", #batch)
      end
      do
        local __lux_tmp_stats_358 = stats
        if __lux_tmp_stats_358 == nil then
          __lux_tmp_stats_358 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_358, "textComposedDraws", #batch)
      end
      if fx then
        do
          local __lux_tmp_stats_359 = stats
          if __lux_tmp_stats_359 == nil then
            __lux_tmp_stats_359 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_359, "textShaderDraws")
        end
        do
          local __lux_tmp_stats_360 = stats
          if __lux_tmp_stats_360 == nil then
            __lux_tmp_stats_360 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_360, "textComposedFxDraws", #batch)
        end
      else
        do
          local __lux_tmp_stats_361 = stats
          if __lux_tmp_stats_361 == nil then
            __lux_tmp_stats_361 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_361, "textComposedFaceDraws", #batch)
        end
      end
      do
        local __lux_tmp_stats_362 = stats
        if __lux_tmp_stats_362 == nil then
          __lux_tmp_stats_362 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_362, "textComposedBatchDraws")
      end
      do
        local __lux_tmp_stats_363 = stats
        if __lux_tmp_stats_363 == nil then
          __lux_tmp_stats_363 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_363, "textComposedBatchedRecords", #batch)
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
        local __lux_tmp_x_364 = record.x
        if __lux_tmp_x_364 == nil then
          __lux_tmp_x_364 = 0
        end
        contentX = __lux_tmp_x_364 - entry.contentW * __lux_module_1.alignFactor(record.alignX)
      end
      local contentY
      do
        local __lux_tmp_y_365 = record.y
        if __lux_tmp_y_365 == nil then
          __lux_tmp_y_365 = 0
        end
        contentY = __lux_tmp_y_365 - entry.contentH * __lux_module_1.alignFactor(record.alignY, true)
      end
      local x = contentX - entry.originX
      local y = contentY - entry.originY
      x, y = __lux_module_1.snapTextPos(x, y, record.style)
      local color
      do
        local __lux_tmp_color_366 = record.color
        if __lux_tmp_color_366 == nil then
          __lux_tmp_color_366 = __lux_module_1.white
        end
        color = __lux_module_1.style.asColor(__lux_module_1.fillForRecord(record), __lux_tmp_color_366)
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
          local __lux_tmp_stats_367 = stats
          if __lux_tmp_stats_367 == nil then
            __lux_tmp_stats_367 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_367, "textComposedEvicts")
        end
        __lux_module_1.clearComposedCache()
        do
          local __lux_tmp_records_368 = records
          if __lux_tmp_records_368 == nil then
            __lux_tmp_records_368 = {}
          end
          for _, record in ipairs(__lux_tmp_records_368) do
            record.__mgfxTextEntry = nil
          end
        end
      end
      __lux_module_1.bakesThisFrame = 0
      local composeRequested = __lux_module_1.prepareTextRoutes(records)
      do
        local __lux_tmp_stats_369 = stats
        if __lux_tmp_stats_369 == nil then
          __lux_tmp_stats_369 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_369, "textComposedRequests", composeRequested)
      end
      if composeRequested > 0 then
        do
          local __lux_tmp_stats_370 = stats
          if __lux_tmp_stats_370 == nil then
            __lux_tmp_stats_370 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_370, "textComposedBatches")
        end
      end
      local composerReady = composeRequested <= 0 or __lux_module_1.prewarmFlushRecords(records, stats)
      if composeRequested > 0 then
        if composerReady then
          do
            local __lux_tmp_stats_371 = stats
            if __lux_tmp_stats_371 == nil then
              __lux_tmp_stats_371 = {}
            end
            __lux_module_1.statAdd(__lux_tmp_stats_371, "textComposedReadyBatches")
          end
        else
          do
            local __lux_tmp_stats_372 = stats
            if __lux_tmp_stats_372 == nil then
              __lux_tmp_stats_372 = {}
            end
            __lux_module_1.statAdd(__lux_tmp_stats_372, "textComposedFallbackBatches")
          end
          do
            local __lux_tmp_stats_373 = stats
            if __lux_tmp_stats_373 == nil then
              __lux_tmp_stats_373 = {}
            end
            __lux_module_1.statAdd(
              __lux_tmp_stats_373,
              "textComposedFallbackRecords",
              composeRequested
            )
          end
        end
      end
      local batches = {}
      local order = {}
      do
        local __lux_tmp_records_374 = records
        if __lux_tmp_records_374 == nil then
          __lux_tmp_records_374 = {}
        end
        for _, record in ipairs(__lux_tmp_records_374) do
          do
            local __lux_tmp_stats_375 = stats
            if __lux_tmp_stats_375 == nil then
              __lux_tmp_stats_375 = {}
            end
            __lux_module_1.statAdd(__lux_tmp_stats_375, "textDraws")
          end
          local route = record.__mgfxTextRoute
          if route == "native" then
            __lux_module_1.flushQueuedTextBatches(batches, order, stats)
            do
              local __lux_tmp_stats_376 = stats
              if __lux_tmp_stats_376 == nil then
                __lux_tmp_stats_376 = {}
              end
              __lux_module_1.statAdd(__lux_tmp_stats_376, "textNativeDraws")
            end
            __lux_module_1.drawNativePlainRecord(record)
          else
            if route == "nativeFallback" or not composerReady then
              __lux_module_1.flushQueuedTextBatches(batches, order, stats)
              do
                local __lux_tmp_stats_377 = stats
                if __lux_tmp_stats_377 == nil then
                  __lux_tmp_stats_377 = {}
                end
                __lux_module_1.statAdd(__lux_tmp_stats_377, "textNativeDraws")
              end
              do
                local __lux_tmp_stats_378 = stats
                if __lux_tmp_stats_378 == nil then
                  __lux_tmp_stats_378 = {}
                end
                __lux_module_1.statAdd(__lux_tmp_stats_378, "textFallbacks")
              end
              __lux_module_1.drawNativeFallbackRecord(record)
            else
              local entry = record.__mgfxTextEntry
              if not (entry ~= nil and entry.page ~= nil and entry.generation == entry.page.generation) then
                entry = __lux_module_1.entryFor(record, stats, false)
              end
              if entry ~= nil then
                if not __lux_module_1.queueTextComposeBatch(batches, order, entry, record) then
                  __lux_module_1.flushQueuedTextBatches(batches, order, stats)
                  __lux_module_1.blitEntry(entry, record, stats)
                end
              else
                __lux_module_1.flushQueuedTextBatches(batches, order, stats)
                do
                  local __lux_tmp_stats_379 = stats
                  if __lux_tmp_stats_379 == nil then
                    __lux_tmp_stats_379 = {}
                  end
                  __lux_module_1.statAdd(__lux_tmp_stats_379, "textComposedFallbackRecords")
                end
                do
                  local __lux_tmp_stats_380 = stats
                  if __lux_tmp_stats_380 == nil then
                    __lux_tmp_stats_380 = {}
                  end
                  __lux_module_1.statAdd(__lux_tmp_stats_380, "textNativeDraws")
                end
                do
                  local __lux_tmp_stats_381 = stats
                  if __lux_tmp_stats_381 == nil then
                    __lux_tmp_stats_381 = {}
                  end
                  __lux_module_1.statAdd(__lux_tmp_stats_381, "textFallbacks")
                end
                __lux_module_1.drawNativeFallbackRecord(record)
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
        local __lux_tmp_spec_382 = spec
        if __lux_tmp_spec_382 == nil then
          __lux_tmp_spec_382 = {}
        end
        return __lux_module_1.registerFont(fontName, __lux_tmp_spec_382)
      end
      renderer.DefineStyle = function(name, textStyle)
        if name == nil then
          return nil
        end
        local __lux_tmp_textStyle_383 = textStyle
        if __lux_tmp_textStyle_383 == nil then
          __lux_tmp_textStyle_383 = {}
        end
        return __lux_module_1.defineStyle(
          __lux_module_1.toString(name),
          renderer.ResolveStyle(__lux_tmp_textStyle_383)
        )
      end
      renderer.GetStyle = function(name)
        local __lux_tmp_name_384 = name
        if __lux_tmp_name_384 == nil then
          __lux_tmp_name_384 = ""
        end
        return __lux_module_1.getStyle(__lux_module_1.toString(__lux_tmp_name_384))
      end
      renderer.PushStyle = function(textStyle)
        do
          local __lux_tmp_textStyle_385 = textStyle
          if __lux_tmp_textStyle_385 == nil then
            __lux_tmp_textStyle_385 = {}
          end
          styleStack[#styleStack + 1] = renderer.ResolveStyle(__lux_tmp_textStyle_385)
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
          local __lux_tmp_textStyle_386 = textStyle
          if __lux_tmp_textStyle_386 == nil then
            __lux_tmp_textStyle_386 = {}
          end
          __lux_module_1.copyStyleInto(resolved, __lux_tmp_textStyle_386)
        end
        resolved[__lux_module_1.RESOLVED_STYLE_MARK] = true
        return resolved
      end
      renderer.MakeRecord = function(value, font, x, y, color, ax, ay, textStyle)
        local resolved
        do
          local __lux_tmp_textStyle_387 = textStyle
          if __lux_tmp_textStyle_387 == nil then
            __lux_tmp_textStyle_387 = {}
          end
          resolved = renderer.ResolveStyle(__lux_tmp_textStyle_387)
        end
        local __lux_tmp_value_388 = value
        if __lux_tmp_value_388 == nil then
          __lux_tmp_value_388 = ""
        end
        local __lux_tmp_font_389 = resolved.font
        if __lux_tmp_font_389 == nil then
          __lux_tmp_font_389 = font
        end
        if __lux_tmp_font_389 == nil then
          __lux_tmp_font_389 = "DermaDefault"
        end
        local __lux_tmp_x_390 = __lux_module_1.toNumber(x)
        if __lux_tmp_x_390 == nil then
          __lux_tmp_x_390 = 0
        end
        local __lux_tmp_y_391 = __lux_module_1.toNumber(y)
        if __lux_tmp_y_391 == nil then
          __lux_tmp_y_391 = 0
        end
        local __lux_tmp_392
        if __lux_module_1.style.asColor ~= nil then
          do
            local __lux_tmp_color_393 = color
            if __lux_tmp_color_393 == nil then
              __lux_tmp_color_393 = resolved.color
            end
            if __lux_tmp_color_393 == nil then
              __lux_tmp_color_393 = resolved.fill
            end
            __lux_tmp_392 = __lux_module_1.style.asColor(__lux_tmp_color_393, __lux_module_1.white)
          end
        else
          do
            local __lux_tmp_color_394 = color
            if __lux_tmp_color_394 == nil then
              __lux_tmp_color_394 = resolved.color
            end
            if __lux_tmp_color_394 == nil then
              __lux_tmp_color_394 = resolved.fill
            end
            __lux_tmp_392 = __lux_module_1.style.colorOr(__lux_tmp_color_394, __lux_module_1.white)
          end
        end
        local __lux_tmp_alignX_395 = resolved.alignX
        if __lux_tmp_alignX_395 == nil then
          __lux_tmp_alignX_395 = resolved.align
        end
        if __lux_tmp_alignX_395 == nil then
          __lux_tmp_alignX_395 = ax
        end
        if __lux_tmp_alignX_395 == nil then
          __lux_tmp_alignX_395 = TEXT_ALIGN_LEFT
        end
        local __lux_tmp_alignY_396 = resolved.alignY
        if __lux_tmp_alignY_396 == nil then
          __lux_tmp_alignY_396 = resolved.valign
        end
        if __lux_tmp_alignY_396 == nil then
          __lux_tmp_alignY_396 = ay
        end
        if __lux_tmp_alignY_396 == nil then
          __lux_tmp_alignY_396 = TEXT_ALIGN_TOP
        end
        return {
          text = __lux_module_1.toString(__lux_tmp_value_388),
          font = __lux_tmp_font_389,
          x = __lux_tmp_x_390,
          y = __lux_tmp_y_391,
          color = __lux_tmp_392,
          alignX = __lux_tmp_alignX_395,
          alignY = __lux_tmp_alignY_396,
          style = resolved,
        }
      end
      renderer.NormalizeRecord = function(record)
        if record == nil then
          return nil
        end
        local resolved
        do
          local __lux_tmp_style_397 = record.style
          if __lux_tmp_style_397 == nil then
            __lux_tmp_style_397 = {}
          end
          resolved = renderer.ResolveStyle(__lux_tmp_style_397)
        end
        do
          local __lux_tmp_text_398 = record.text
          if __lux_tmp_text_398 == nil then
            __lux_tmp_text_398 = record.value
          end
          if __lux_tmp_text_398 == nil then
            __lux_tmp_text_398 = ""
          end
          record.text = __lux_module_1.toString(__lux_tmp_text_398)
        end
        do
          local __lux_tmp_font_399 = resolved.font
          if __lux_tmp_font_399 == nil then
            __lux_tmp_font_399 = record.font
          end
          if __lux_tmp_font_399 == nil then
            __lux_tmp_font_399 = "DermaDefault"
          end
          record.font = __lux_tmp_font_399
        end
        do
          local __lux_tmp_x_400 = __lux_module_1.toNumber(record.x)
          if __lux_tmp_x_400 == nil then
            __lux_tmp_x_400 = 0
          end
          record.x = __lux_tmp_x_400
        end
        do
          local __lux_tmp_y_401 = __lux_module_1.toNumber(record.y)
          if __lux_tmp_y_401 == nil then
            __lux_tmp_y_401 = 0
          end
          record.y = __lux_tmp_y_401
        end
        do
          local __lux_tmp_402
          if __lux_module_1.style.asColor ~= nil then
            do
              local __lux_tmp_color_403 = record.color
              if __lux_tmp_color_403 == nil then
                __lux_tmp_color_403 = resolved.color
              end
              if __lux_tmp_color_403 == nil then
                __lux_tmp_color_403 = resolved.fill
              end
              __lux_tmp_402 = __lux_module_1.style.asColor(__lux_tmp_color_403, __lux_module_1.white)
            end
          else
            do
              local __lux_tmp_color_404 = record.color
              if __lux_tmp_color_404 == nil then
                __lux_tmp_color_404 = resolved.color
              end
              if __lux_tmp_color_404 == nil then
                __lux_tmp_color_404 = resolved.fill
              end
              __lux_tmp_402 = __lux_module_1.style.colorOr(__lux_tmp_color_404, __lux_module_1.white)
            end
          end
          record.color = __lux_tmp_402
        end
        do
          local __lux_tmp_alignX_405 = resolved.alignX
          if __lux_tmp_alignX_405 == nil then
            __lux_tmp_alignX_405 = resolved.align
          end
          if __lux_tmp_alignX_405 == nil then
            __lux_tmp_alignX_405 = record.alignX
          end
          if __lux_tmp_alignX_405 == nil then
            __lux_tmp_alignX_405 = record.ax
          end
          if __lux_tmp_alignX_405 == nil then
            __lux_tmp_alignX_405 = TEXT_ALIGN_LEFT
          end
          record.alignX = __lux_tmp_alignX_405
        end
        do
          local __lux_tmp_alignY_406 = resolved.alignY
          if __lux_tmp_alignY_406 == nil then
            __lux_tmp_alignY_406 = resolved.valign
          end
          if __lux_tmp_alignY_406 == nil then
            __lux_tmp_alignY_406 = record.alignY
          end
          if __lux_tmp_alignY_406 == nil then
            __lux_tmp_alignY_406 = record.ay
          end
          if __lux_tmp_alignY_406 == nil then
            __lux_tmp_alignY_406 = TEXT_ALIGN_TOP
          end
          record.alignY = __lux_tmp_alignY_406
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
          local __lux_tmp_textStyle_407 = textStyle
          if __lux_tmp_textStyle_407 == nil then
            __lux_tmp_textStyle_407 = {}
          end
          resolved = renderer.ResolveStyle(__lux_tmp_textStyle_407)
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
          local __lux_tmp_w_408 = __lux_module_1.toNumber(w)
          if __lux_tmp_w_408 == nil then
            __lux_tmp_w_408 = 0
          end
          lines = __lux_module_1.wrapText(value, resolvedFont, __lux_tmp_w_408, resolved.overflow)
        end
        local nativeFont, alias, oversample = __lux_module_1.nativeFor(resolvedFont, resolved)
        local lineHeight = __lux_module_1.lineHeightFor(nativeFont, alias, resolved, oversample)
        local totalH = #lines * lineHeight
        local startY
        do
          local __lux_tmp_y_409 = __lux_module_1.toNumber(y)
          if __lux_tmp_y_409 == nil then
            __lux_tmp_y_409 = 0
          end
          local __lux_tmp_h_410 = __lux_module_1.toNumber(h)
          if __lux_tmp_h_410 == nil then
            __lux_tmp_h_410 = totalH
          end
          local __lux_tmp_alignY_411 = resolved.alignY
          if __lux_tmp_alignY_411 == nil then
            __lux_tmp_alignY_411 = resolved.valign
          end
          if __lux_tmp_alignY_411 == nil then
            __lux_tmp_alignY_411 = TEXT_ALIGN_TOP
          end
          startY = __lux_tmp_y_409 + (__lux_tmp_h_410 - totalH) * __lux_module_1.alignFactor(__lux_tmp_alignY_411, true)
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
          local __lux_tmp_x_412 = __lux_module_1.toNumber(x)
          if __lux_tmp_x_412 == nil then
            __lux_tmp_x_412 = 0
          end
          local __lux_tmp_w_413 = __lux_module_1.toNumber(w)
          if __lux_tmp_w_413 == nil then
            __lux_tmp_w_413 = 0
          end
          tx = __lux_tmp_x_412 + __lux_tmp_w_413 * __lux_module_1.alignFactor(ax)
        end
        local lineStyle = __lux_module_1.textBoxLineStyle(resolved)
        for index = 1, #lines do
          do
            local __lux_tmp_color_414 = lineStyle.color
            if __lux_tmp_color_414 == nil then
              __lux_tmp_color_414 = lineStyle.fill
            end
            renderer.DrawTextImmediate(
              lines[index],
              resolvedFont,
              tx,
              startY + (index - 1) * lineHeight,
              __lux_tmp_color_414,
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
        local __lux_tmp_textStyle_415 = textStyle
        if __lux_tmp_textStyle_415 == nil then
          __lux_tmp_textStyle_415 = {}
        end
        return __lux_module_1.measureBox(
          value,
          font,
          w,
          renderer.ResolveStyle(__lux_tmp_textStyle_415)
        )
      end
      renderer.PrewarmText = function(value, font, textStyle)
        local record
        do
          local __lux_tmp_textStyle_416 = textStyle
          if __lux_tmp_textStyle_416 == nil then
            __lux_tmp_textStyle_416 = {}
          end
          record = renderer.MakeRecord(
            value,
            font,
            0,
            0,
            nil,
            TEXT_ALIGN_LEFT,
            TEXT_ALIGN_TOP,
            __lux_tmp_textStyle_416
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
          local __lux_tmp_textStyle_417 = textStyle
          if __lux_tmp_textStyle_417 == nil then
            __lux_tmp_textStyle_417 = {}
          end
          record = renderer.MakeRecord(
            value,
            font,
            0,
            0,
            nil,
            TEXT_ALIGN_LEFT,
            TEXT_ALIGN_TOP,
            __lux_tmp_textStyle_417
          )
        end
        local nativeFont, alias, oversample = __lux_module_1.nativeFor(record.font, record.style)
        local layout = __lux_module_1.layoutFor(record.text, record.font, record.style)
        local needsComposed = __lux_module_1.recordNeedsComposedEntry(record)
        local __lux_tmp_418
        if needsComposed then
          __lux_tmp_418 = "__composed"
        else
          __lux_tmp_418 = "__native"
        end
        local __lux_tmp_419
        if needsComposed then
          __lux_tmp_419 = "composed"
        else
          __lux_tmp_419 = "native"
        end
        local __lux_tmp_420
        if needsComposed then
          __lux_tmp_420 = "__composed"
        else
          __lux_tmp_420 = "__native"
        end
        local __lux_tmp_421
        if needsComposed then
          __lux_tmp_421 = "compose"
        else
          __lux_tmp_421 = "native"
        end
        local __lux_tmp_mode_422 = alias.mode
        if __lux_tmp_mode_422 == nil then
          __lux_tmp_mode_422 = "native"
        end
        return {
          text = record.text,
          font = record.font,
          nativeFont = nativeFont,
          atlasKey = __lux_tmp_418,
          kind = __lux_tmp_419,
          routeAtlas = __lux_tmp_420,
          routeKind = __lux_tmp_421,
          mode = __lux_tmp_mode_422,
          missing = {},
          w = layout.w,
          h = layout.h,
          oversample = oversample,
        }
      end
      renderer.Status = function()
        local __lux_obj_atlas_423 = __lux_module_1.atlas
        local __lux_val_rt_424 = nil
        if __lux_obj_atlas_423 ~= nil then
          __lux_val_rt_424 = __lux_obj_atlas_423.rt
        end
        local __lux_obj_atlas_425 = __lux_module_1.atlas
        local __lux_tmp_w_426 = nil
        if __lux_obj_atlas_425 ~= nil then
          __lux_tmp_w_426 = __lux_obj_atlas_425.w
        end
        if __lux_tmp_w_426 == nil then
          __lux_tmp_w_426 = 0
        end
        local __lux_obj_atlas_427 = __lux_module_1.atlas
        local __lux_tmp_h_428 = nil
        if __lux_obj_atlas_427 ~= nil then
          __lux_tmp_h_428 = __lux_obj_atlas_427.h
        end
        if __lux_tmp_h_428 == nil then
          __lux_tmp_h_428 = 0
        end
        local __lux_tmp_textDraws_429 = stats.textDraws
        if __lux_tmp_textDraws_429 == nil then
          __lux_tmp_textDraws_429 = 0
        end
        local __lux_tmp_textNativeDraws_430 = stats.textNativeDraws
        if __lux_tmp_textNativeDraws_430 == nil then
          __lux_tmp_textNativeDraws_430 = 0
        end
        local __lux_tmp_textShaderDraws_431 = stats.textShaderDraws
        if __lux_tmp_textShaderDraws_431 == nil then
          __lux_tmp_textShaderDraws_431 = 0
        end
        local __lux_tmp_textComposedDraws_432 = stats.textComposedDraws
        if __lux_tmp_textComposedDraws_432 == nil then
          __lux_tmp_textComposedDraws_432 = 0
        end
        local __lux_tmp_textComposedBakes_433 = stats.textComposedBakes
        if __lux_tmp_textComposedBakes_433 == nil then
          __lux_tmp_textComposedBakes_433 = 0
        end
        local __lux_tmp_textComposedBlits_434 = stats.textComposedBlits
        if __lux_tmp_textComposedBlits_434 == nil then
          __lux_tmp_textComposedBlits_434 = 0
        end
        local __lux_tmp_textMeasureHits_435 = stats.textMeasureHits
        if __lux_tmp_textMeasureHits_435 == nil then
          __lux_tmp_textMeasureHits_435 = 0
        end
        local __lux_tmp_textMeasureMisses_436 = stats.textMeasureMisses
        if __lux_tmp_textMeasureMisses_436 == nil then
          __lux_tmp_textMeasureMisses_436 = 0
        end
        return {
          mode = "native+composer",
          fontCount = __lux_module_1.countTable(__lux_module_1.fonts),
          styleCount = __lux_module_1.countTable(__lux_module_1.styles),
          styleStackDepth = #styleStack,
          cacheSize = __lux_module_1.measureOrderCount,
          composedEnabled = __lux_module_1.textComposedEnabled(),
          composedAtlas = __lux_val_rt_424,
          composedAtlasW = __lux_tmp_w_426,
          composedAtlasH = __lux_tmp_h_428,
          composedAtlasPages = #__lux_module_1.atlasPages,
          composedAtlasMaxPages = __lux_module_1.MAX_ATLAS_PAGES,
          composedAtlasFill = __lux_module_1.atlasFillRatio(),
          composedEntries = __lux_module_1.composedCacheCount,
          composedFailed = __lux_module_1.atlasFailed,
          draws = __lux_tmp_textDraws_429,
          nativeDraws = __lux_tmp_textNativeDraws_430,
          shaderDraws = __lux_tmp_textShaderDraws_431,
          composedDraws = __lux_tmp_textComposedDraws_432,
          composedBakes = __lux_tmp_textComposedBakes_433,
          composedBlits = __lux_tmp_textComposedBlits_434,
          measureHits = __lux_tmp_textMeasureHits_435,
          measureMisses = __lux_tmp_textMeasureMisses_436,
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
        local __lux_tmp_stats_437 = owner.stats
        if __lux_tmp_stats_437 == nil then
          __lux_tmp_stats_437 = {}
        end
        owner.stats = __lux_tmp_stats_437
      end
      local materialState = owner._MaterialState
      if materialState == nil then
        materialState = {}
      end
      local renderer
      do
        local __lux_tmp_Materials_438 = owner._Materials
        if __lux_tmp_Materials_438 == nil then
          __lux_tmp_Materials_438 = materialState.materials
        end
        if __lux_tmp_Materials_438 == nil then
          __lux_tmp_Materials_438 = {}
        end
        local __lux_tmp_MaterialOK_439 = owner.MaterialOK
        if __lux_tmp_MaterialOK_439 == nil then
          __lux_tmp_MaterialOK_439 = materialState.matOK
        end
        renderer = __lux_module_1.createTextRenderer(
          {
            M = owner,
            owner = owner,
            stats = owner.stats,
            materials = __lux_tmp_Materials_438,
            createPageTextMaterials = materialState.CreatePageTextMaterials,
            matOK = __lux_tmp_MaterialOK_439,
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
