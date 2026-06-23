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
    __lux_module_1.matrixCtor = Matrix
    __lux_module_1.drawSimpleText = _G.draw.SimpleText
    __lux_module_1.drawDrawText = _G.draw.DrawText
    __lux_module_1.errorFn = error
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
    __lux_module_1.atlasNamespace = nil
    do
      local __lux_tmp_54
      if __lux_module_1.matrixCtor ~= nil then
        __lux_tmp_54 = __lux_module_1.matrixCtor()
      else
        __lux_tmp_54 = nil
      end
      __lux_module_1.textParamMatrixProbe = __lux_tmp_54
    end
    do
      local __lux_obj_textParamMatrixProbe_55 = __lux_module_1.textParamMatrixProbe
      local __lux_val_SetUnpacked_56 = nil
      if __lux_obj_textParamMatrixProbe_55 ~= nil then
        __lux_val_SetUnpacked_56 = __lux_obj_textParamMatrixProbe_55.SetUnpacked
      end
      __lux_module_1.textParamMatrixSetUnpacked = __lux_val_SetUnpacked_56
    end
    __lux_module_1.textParamMatrices = {}
    __lux_module_1.MEASURE_LIMIT = 4096
    __lux_module_1.ATLAS_W = 2048
    __lux_module_1.ATLAS_H = 1024
    __lux_module_1.MAX_ATLAS_PAGES = 16
    __lux_module_1.SOFT_ATLAS_PAGES = 14
    __lux_module_1.ATLAS_PAD = 4
    __lux_module_1.CACHE_VERSION = 22
    __lux_module_1.DEFAULT_BUDGET = 6
    __lux_module_1.DEFAULT_CJK_FACE = "Noto Sans SC"
    __lux_module_1.RESOLVED_STYLE_MARK = "__mgfxTextResolved"
    do
      local __lux_tmp_color_white_57 = color_white
      if __lux_tmp_color_white_57 == nil then
        __lux_tmp_color_white_57 = __lux_module_1.makeColor(255, 255, 255, 255)
      end
      __lux_module_1.white = __lux_tmp_color_white_57
    end
    do
      local __lux_tmp_58
      if __lux_module_1.vectorCtor ~= nil then
        __lux_tmp_58 = __lux_module_1.vectorCtor()
      else
        __lux_tmp_58 = nil
      end
      __lux_module_1.textBatchVertex = __lux_tmp_58
    end
    __lux_module_1.atlasQuad = {
      { x = 0, y = 0, u = 0, v = 0 },
      { x = 0, y = 0, u = 1, v = 0 },
      { x = 0, y = 0, u = 1, v = 1 },
      { x = 0, y = 0, u = 0, v = 1 },
    }
    __lux_module_1.profile = { active = false, draws = 0, measures = 0, times = {}, counts = {} }
    __lux_module_1.nextAtlasNamespace = function()
      local root = _G
      local serial
      do
        local __lux_tmp_MGFXTextAtlasSerial_59 = __lux_module_1.toNumber(root.__MGFXTextAtlasSerial)
        if __lux_tmp_MGFXTextAtlasSerial_59 == nil then
          __lux_tmp_MGFXTextAtlasSerial_59 = 0
        end
        serial = __lux_tmp_MGFXTextAtlasSerial_59 + 1
      end
      root.__MGFXTextAtlasSerial = serial
      return "MGFXTextComposeAtlas_" .. __lux_module_1.toString(serial)
    end
    __lux_module_1.textComposerCapable = function()
      return __lux_module_1.renderClear ~= nil and __lux_module_1.renderPushRenderTarget ~= nil and __lux_module_1.renderPopRenderTarget ~= nil and __lux_module_1.camStart2D ~= nil and __lux_module_1.camEnd2D ~= nil
    end
    __lux_module_1.setupTextParamMatrix = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3)
      if material == nil or __lux_module_1.matrixCtor == nil or __lux_module_1.textParamMatrixSetUnpacked == nil then
        __lux_module_1.errorFn("MGFX text compose atlas rect matrix unavailable", 2)
      end
      local matrix = __lux_module_1.textParamMatrices[material]
      if matrix == nil then
        matrix = __lux_module_1.matrixCtor()
        __lux_module_1.textParamMatrices[material] = matrix
      end
      do
        local __lux_tmp_a0_60 = a0
        if __lux_tmp_a0_60 == nil then
          __lux_tmp_a0_60 = 0
        end
        local __lux_tmp_b0_61 = b0
        if __lux_tmp_b0_61 == nil then
          __lux_tmp_b0_61 = 0
        end
        local __lux_tmp_c0_62 = c0
        if __lux_tmp_c0_62 == nil then
          __lux_tmp_c0_62 = 0
        end
        local __lux_tmp_d0_63 = d0
        if __lux_tmp_d0_63 == nil then
          __lux_tmp_d0_63 = 0
        end
        local __lux_tmp_a1_64 = a1
        if __lux_tmp_a1_64 == nil then
          __lux_tmp_a1_64 = 0
        end
        local __lux_tmp_b1_65 = b1
        if __lux_tmp_b1_65 == nil then
          __lux_tmp_b1_65 = 0
        end
        local __lux_tmp_c1_66 = c1
        if __lux_tmp_c1_66 == nil then
          __lux_tmp_c1_66 = 0
        end
        local __lux_tmp_d1_67 = d1
        if __lux_tmp_d1_67 == nil then
          __lux_tmp_d1_67 = 0
        end
        local __lux_tmp_a2_68 = a2
        if __lux_tmp_a2_68 == nil then
          __lux_tmp_a2_68 = 0
        end
        local __lux_tmp_b2_69 = b2
        if __lux_tmp_b2_69 == nil then
          __lux_tmp_b2_69 = 0
        end
        local __lux_tmp_c2_70 = c2
        if __lux_tmp_c2_70 == nil then
          __lux_tmp_c2_70 = 0
        end
        local __lux_tmp_d2_71 = d2
        if __lux_tmp_d2_71 == nil then
          __lux_tmp_d2_71 = 0
        end
        local __lux_tmp_a3_72 = a3
        if __lux_tmp_a3_72 == nil then
          __lux_tmp_a3_72 = 0
        end
        local __lux_tmp_b3_73 = b3
        if __lux_tmp_b3_73 == nil then
          __lux_tmp_b3_73 = 0
        end
        local __lux_tmp_c3_74 = c3
        if __lux_tmp_c3_74 == nil then
          __lux_tmp_c3_74 = 0
        end
        local __lux_tmp_d3_75 = d3
        if __lux_tmp_d3_75 == nil then
          __lux_tmp_d3_75 = 0
        end
        __lux_module_1.textParamMatrixSetUnpacked(
          matrix,
          __lux_tmp_a0_60,
          __lux_tmp_b0_61,
          __lux_tmp_c0_62,
          __lux_tmp_d0_63,
          __lux_tmp_a1_64,
          __lux_tmp_b1_65,
          __lux_tmp_c1_66,
          __lux_tmp_d1_67,
          __lux_tmp_a2_68,
          __lux_tmp_b2_69,
          __lux_tmp_c2_70,
          __lux_tmp_d2_71,
          __lux_tmp_a3_72,
          __lux_tmp_b3_73,
          __lux_tmp_c3_74,
          __lux_tmp_d3_75
        )
      end
      material:SetMatrix("$viewprojmat", matrix)
      return true
    end
    __lux_module_1.configureTextRenderer = function(deps)
      if deps == nil then
        deps = {}
      end
      do
        local __lux_tmp_materials_76 = deps.materials
        if __lux_tmp_materials_76 == nil then
          __lux_tmp_materials_76 = deps.Materials
        end
        if __lux_tmp_materials_76 == nil then
          __lux_tmp_materials_76 = __lux_module_1.materials
        end
        if __lux_tmp_materials_76 == nil then
          __lux_tmp_materials_76 = {}
        end
        __lux_module_1.materials = __lux_tmp_materials_76
      end
      do
        local __lux_tmp_createPageTextMaterials_77 = deps.createPageTextMaterials
        if __lux_tmp_createPageTextMaterials_77 == nil then
          __lux_tmp_createPageTextMaterials_77 = deps.CreatePageTextMaterials
        end
        if __lux_tmp_createPageTextMaterials_77 == nil then
          __lux_tmp_createPageTextMaterials_77 = __lux_module_1.createPageTextMaterials
        end
        __lux_module_1.createPageTextMaterials = __lux_tmp_createPageTextMaterials_77
      end
      do
        local __lux_tmp_profiler_78 = deps.profiler
        if __lux_tmp_profiler_78 == nil then
          __lux_tmp_profiler_78 = deps.Profiler
        end
        if __lux_tmp_profiler_78 == nil then
          __lux_tmp_profiler_78 = __lux_module_1.profiler
        end
        __lux_module_1.profiler = __lux_tmp_profiler_78
      end
      do
        local __lux_tmp_restoreScissor_79 = deps.restoreScissor
        if __lux_tmp_restoreScissor_79 == nil then
          __lux_tmp_restoreScissor_79 = deps.RestoreScissor
        end
        if __lux_tmp_restoreScissor_79 == nil then
          __lux_tmp_restoreScissor_79 = __lux_module_1.restoreScissor
        end
        if __lux_tmp_restoreScissor_79 == nil then
          __lux_tmp_restoreScissor_79 = function()
        end
        end
        __lux_module_1.restoreScissor = __lux_tmp_restoreScissor_79
      end
      do
        local __lux_tmp_gradientLutForFill_80 = deps.gradientLutForFill
        if __lux_tmp_gradientLutForFill_80 == nil then
          __lux_tmp_gradientLutForFill_80 = deps.GradientLutForFill
        end
        if __lux_tmp_gradientLutForFill_80 == nil then
          __lux_tmp_gradientLutForFill_80 = __lux_module_1.gradientLutForFill
        end
        if __lux_tmp_gradientLutForFill_80 == nil then
          __lux_tmp_gradientLutForFill_80 = function()
          return nil
        end
        end
        __lux_module_1.gradientLutForFill = __lux_tmp_gradientLutForFill_80
      end
      do
        local __lux_tmp_matOK_81 = deps.matOK
        if __lux_tmp_matOK_81 == nil then
          __lux_tmp_matOK_81 = deps.MaterialOK
        end
        if __lux_tmp_matOK_81 == nil then
          __lux_tmp_matOK_81 = __lux_module_1.materialOK
        end
        __lux_module_1.materialOK = __lux_tmp_matOK_81
      end
      return true
    end
    __lux_module_1.sharedTextRenderer = function()
      if __lux_module_1.defaultTextRenderer ~= nil then
        return __lux_module_1.defaultTextRenderer
      end
      local factory
      do
        local __lux_obj_MGFX_82 = _G.MGFX
        local __lux_val_CreateTextRenderer_83 = nil
        if __lux_obj_MGFX_82 ~= nil then
          __lux_val_CreateTextRenderer_83 = __lux_obj_MGFX_82._CreateTextRenderer
        end
        factory = __lux_val_CreateTextRenderer_83
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
        local __lux_tmp_text_84 = text
        if __lux_tmp_text_84 == nil then
          __lux_tmp_text_84 = ""
        end
        value = __lux_module_1.toString(__lux_tmp_text_84)
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
        local __lux_tmp_t_85 = t
        if __lux_tmp_t_85 == nil then
          __lux_tmp_t_85 = {}
        end
        for key, _ in pairs(__lux_tmp_t_85) do
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
        local __lux_tmp_fallback_86 = fallback
        if __lux_tmp_fallback_86 == nil then
          __lux_tmp_fallback_86 = 500
        end
        return __lux_tmp_fallback_86
      end
      if weight > 0 and weight <= 10 then
        do
          local __lux_tmp_87
          if weight <= 1 then
            __lux_tmp_87 = 850
          else
            __lux_tmp_87 = weight * 100
          end
          weight = __lux_tmp_87
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
      local __lux_tmp_face_88 = face
      if __lux_tmp_face_88 == nil then
        __lux_tmp_face_88 = ""
      end
      local __lux_tmp_size_89 = size
      if __lux_tmp_size_89 == nil then
        __lux_tmp_size_89 = ""
      end
      local __lux_tmp_weight_90 = weight
      if __lux_tmp_weight_90 == nil then
        __lux_tmp_weight_90 = ""
      end
      local __lux_tmp_91
      if italic == true then
        __lux_tmp_91 = "i"
      else
        __lux_tmp_91 = "n"
      end
      return __lux_module_1.tableConcat(
        {
          __lux_module_1.toString(__lux_tmp_face_88),
          __lux_module_1.toString(__lux_tmp_size_89),
          __lux_module_1.toString(__lux_tmp_weight_90),
          __lux_tmp_91,
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
          local __lux_tmp_face_92 = face
          if __lux_tmp_face_92 == nil then
            __lux_tmp_face_92 = "DermaDefault"
          end
          local __lux_tmp_size_93 = size
          if __lux_tmp_size_93 == nil then
            __lux_tmp_size_93 = 16
          end
          __lux_module_1.surfaceCreateFont(
            name,
            {
              font = __lux_tmp_face_92,
              size = __lux_module_1.mathFloor(__lux_tmp_size_93),
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
          local __lux_tmp_oversample_94 = input.oversample
          if __lux_tmp_oversample_94 == nil then
            __lux_tmp_oversample_94 = __lux_module_1.oversampleForSize(size)
          end
          oversample = __lux_module_1.normalizeOversample(__lux_tmp_oversample_94)
        end
        do
          local __lux_tmp_95
          if face == __lux_module_1.DEFAULT_CJK_FACE then
            __lux_tmp_95 = 400
          else
            __lux_tmp_95 = 500
          end
          weight = __lux_module_1.normalizeFontWeight(weight, __lux_tmp_95)
        end
        sourceFont = __lux_module_1.ensureNativeFont(face, size * oversample, weight, input.italic == true)
      else
        if sourceFont == nil then
          sourceFont = name
        end
      end
      do
        local __lux_tmp_96
        if face ~= nil then
          __lux_tmp_96 = "alias"
        else
          __lux_tmp_96 = "native"
        end
        local __lux_tmp_lineHeight_97 = input.lineHeight
        if __lux_tmp_lineHeight_97 == nil then
          __lux_tmp_lineHeight_97 = input.lineheight
        end
        local __lux_tmp_tracking_98 = input.tracking
        if __lux_tmp_tracking_98 == nil then
          __lux_tmp_tracking_98 = input.letterSpacing
        end
        local __lux_tmp_tracking_99 = __lux_module_1.toNumber(__lux_tmp_tracking_98)
        if __lux_tmp_tracking_99 == nil then
          __lux_tmp_tracking_99 = 0
        end
        local __lux_tmp_100
        if face ~= nil then
          __lux_tmp_100 = "__composed"
        else
          __lux_tmp_100 = "__native"
        end
        __lux_module_1.fonts[name] = {
          mode = __lux_tmp_96,
          sourceFont = sourceFont,
          face = face,
          size = size,
          weight = weight,
          oversample = oversample,
          syntheticWeight = input.syntheticWeight == true or input.allowSyntheticWeight == true,
          lineHeight = __lux_module_1.toNumber(__lux_tmp_lineHeight_97),
          tracking = __lux_tmp_tracking_99,
          atlas = __lux_tmp_100,
        }
      end
      return true
    end
    __lux_module_1.aliasFor = function(font)
      local key
      do
        local __lux_tmp_font_101 = font
        if __lux_tmp_font_101 == nil then
          __lux_tmp_font_101 = ""
        end
        key = __lux_module_1.toString(__lux_tmp_font_101)
      end
      local alias = __lux_module_1.fonts[key]
      if alias ~= nil then
        return alias
      end
      local __lux_tmp_font_102 = font
      if __lux_tmp_font_102 == nil then
        __lux_tmp_font_102 = "DermaDefault"
      end
      return {
        mode = "native",
        sourceFont = __lux_tmp_font_102,
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
        local __lux_tmp_107 = noOversample
        if not __lux_tmp_107 then
          local __lux_obj_textStyle_105 = textStyle
          local __lux_val_mgfxNoOversample_106 = nil
          if __lux_obj_textStyle_105 ~= nil then
            __lux_val_mgfxNoOversample_106 = __lux_obj_textStyle_105.__mgfxNoOversample
          end
          __lux_tmp_107 = __lux_val_mgfxNoOversample_106
        end
        if __lux_tmp_107 then
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
        local __lux_obj_textStyle_108 = textStyle
        local __lux_val_syntheticNativeWeight_109 = nil
        if __lux_obj_textStyle_108 ~= nil then
          __lux_val_syntheticNativeWeight_109 = __lux_obj_textStyle_108.syntheticNativeWeight
        end
        if __lux_val_syntheticNativeWeight_109 == true then
          local __lux_tmp_114 = plainFace ~= true
          if __lux_tmp_114 then
            local __lux_obj_textStyle_112 = textStyle
            local __lux_val_bold_113 = nil
            if __lux_obj_textStyle_112 ~= nil then
              __lux_val_bold_113 = __lux_obj_textStyle_112.bold
            end
            __lux_tmp_114 = __lux_val_bold_113 == true
          end
          if __lux_tmp_114 then
            weight = weight + 220
          end
          local __lux_tmp_119 = plainFace ~= true
          if __lux_tmp_119 then
            local __lux_obj_textStyle_117 = textStyle
            local __lux_val_thin_118 = nil
            if __lux_obj_textStyle_117 ~= nil then
              __lux_val_thin_118 = __lux_obj_textStyle_117.thin
            end
            __lux_tmp_119 = __lux_val_thin_118 == true
          end
          if __lux_tmp_119 then
            weight = __lux_module_1.mathMin(weight, 350)
          end
          local __lux_obj_textStyle_120 = textStyle
          local __lux_val_weight_121 = nil
          if __lux_obj_textStyle_120 ~= nil then
            __lux_val_weight_121 = __lux_obj_textStyle_120.weight
          end
          if __lux_module_1.toNumber(__lux_val_weight_121) ~= nil then
            weight = __lux_module_1.normalizeFontWeight(textStyle.weight, weight)
          end
        end
        local __lux_tmp_size_122 = alias.size
        if __lux_tmp_size_122 == nil then
          __lux_tmp_size_122 = 16
        end
        local __lux_obj_textStyle_123 = textStyle
        local __lux_val_italic_124 = nil
        if __lux_obj_textStyle_123 ~= nil then
          __lux_val_italic_124 = __lux_obj_textStyle_123.italic
        end
        return __lux_module_1.ensureNativeFont(
          alias.face,
          __lux_tmp_size_122 * oversample,
          weight,
          __lux_val_italic_124 == true
        ), alias, oversample
      end
      local __lux_tmp_sourceFont_125 = alias.sourceFont
      if __lux_tmp_sourceFont_125 == nil then
        __lux_tmp_sourceFont_125 = font
      end
      if __lux_tmp_sourceFont_125 == nil then
        __lux_tmp_sourceFont_125 = "DermaDefault"
      end
      return __lux_tmp_sourceFont_125, alias, 1
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
        local __lux_tmp_textStyle_126 = textStyle
        if __lux_tmp_textStyle_126 == nil then
          __lux_tmp_textStyle_126 = {}
        end
        __lux_module_1.styles[__lux_module_1.toString(name)] = __lux_module_1.resolveStyle(__lux_tmp_textStyle_126)
      end
      return __lux_module_1.styles[__lux_module_1.toString(name)]
    end
    __lux_module_1.getStyle = function(name)
      local __lux_tmp_name_127 = name
      if __lux_tmp_name_127 == nil then
        __lux_tmp_name_127 = ""
      end
      return __lux_module_1.styles[__lux_module_1.toString(__lux_tmp_name_127)]
    end
    __lux_module_1.resolveStyle = function(textStyle)
      if __lux_module_1.typeOf(textStyle) == "string" then
        local __lux_tmp_textStyle_128 = __lux_module_1.styles[__lux_module_1.toString(textStyle)]
        if __lux_tmp_textStyle_128 == nil then
          __lux_tmp_textStyle_128 = {}
        end
        return __lux_module_1.copyValue(__lux_tmp_textStyle_128)
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
        local __lux_obj_textStyle_129 = textStyle
        local __lux_val_lineHeight_130 = nil
        if __lux_obj_textStyle_129 ~= nil then
          __lux_val_lineHeight_130 = __lux_obj_textStyle_129.lineHeight
        end
        local __lux_tmp_lineHeight_131 = __lux_val_lineHeight_130
        if __lux_tmp_lineHeight_131 == nil then
          local __lux_obj_textStyle_132 = textStyle
          local __lux_val_lineheight_133 = nil
          if __lux_obj_textStyle_132 ~= nil then
            __lux_val_lineheight_133 = __lux_obj_textStyle_132.lineheight
          end
          __lux_tmp_lineHeight_131 = __lux_val_lineheight_133
        end
        if __lux_tmp_lineHeight_131 == nil then
          local __lux_obj_alias_134 = alias
          local __lux_val_lineHeight_135 = nil
          if __lux_obj_alias_134 ~= nil then
            __lux_val_lineHeight_135 = __lux_obj_alias_134.lineHeight
          end
          __lux_tmp_lineHeight_131 = __lux_val_lineHeight_135
        end
        declared = __lux_module_1.toNumber(__lux_tmp_lineHeight_131)
      end
      if declared ~= nil then
        return declared
      end
      __lux_module_1.setFontSafe(nativeFont)
      local _, h = __lux_module_1.surfaceGetTextSize("Mg")
      local __lux_tmp_h_136 = h
      if __lux_tmp_h_136 == nil then
        __lux_tmp_h_136 = 16
      end
      return __lux_module_1.mathMax(
        1,
        __lux_tmp_h_136 / __lux_module_1.normalizeOversample(oversample)
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
        local __lux_tmp_text_137 = text
        if __lux_tmp_text_137 == nil then
          __lux_tmp_text_137 = ""
        end
        raw = __lux_module_1.toString(__lux_tmp_text_137)
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
        local __lux_tmp_textStyle_138 = textStyle
        if __lux_tmp_textStyle_138 == nil then
          __lux_tmp_textStyle_138 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_textStyle_138)
      end
      local nativeFont, alias, oversample = __lux_module_1.nativeFor(font, resolved, noOversample, plainFace)
      local tracking
      do
        local __lux_tmp_tracking_139 = resolved.tracking
        if __lux_tmp_tracking_139 == nil then
          __lux_tmp_tracking_139 = resolved.letterSpacing
        end
        tracking = __lux_module_1.toNumber(__lux_tmp_tracking_139)
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
        local __lux_tmp_value_140 = value
        if __lux_tmp_value_140 == nil then
          __lux_tmp_value_140 = ""
        end
        lines = __lux_module_1.stringExplode("\n", __lux_module_1.toString(__lux_tmp_value_140), false)
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
        local __lux_tmp_font_141 = font
        if __lux_tmp_font_141 == nil then
          __lux_tmp_font_141 = ""
        end
        local __lux_tmp_value_142 = value
        if __lux_tmp_value_142 == nil then
          __lux_tmp_value_142 = ""
        end
        key = __lux_module_1.tableConcat(
          {
            __lux_module_1.toString(__lux_tmp_font_141),
            nativeFont,
            __lux_module_1.toString(tracking),
            __lux_module_1.toString(oversample),
            __lux_module_1.toString(__lux_tmp_value_142),
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
        local __lux_tmp_value_143 = value
        if __lux_tmp_value_143 == nil then
          __lux_tmp_value_143 = ""
        end
        text = __lux_module_1.toString(__lux_tmp_value_143)
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
        local __lux_tmp_value_144 = value
        if __lux_tmp_value_144 == nil then
          __lux_tmp_value_144 = ""
        end
        text = __lux_module_1.toString(__lux_tmp_value_144)
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
        local __lux_tmp_textStyle_145 = textStyle
        if __lux_tmp_textStyle_145 == nil then
          __lux_tmp_textStyle_145 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_textStyle_145)
      end
      local lines
      do
        local __lux_tmp_font_146 = font
        if __lux_tmp_font_146 == nil then
          __lux_tmp_font_146 = resolved.font
        end
        if __lux_tmp_font_146 == nil then
          __lux_tmp_font_146 = "DermaDefault"
        end
        local __lux_tmp_w_147 = __lux_module_1.toNumber(w)
        if __lux_tmp_w_147 == nil then
          __lux_tmp_w_147 = 0
        end
        lines = __lux_module_1.wrapText(value, __lux_tmp_font_146, __lux_tmp_w_147, resolved.overflow)
      end
      local maxW = 0
      for index = 1, #lines do
        local lw
        do
          local __lux_tmp_font_148 = font
          if __lux_tmp_font_148 == nil then
            __lux_tmp_font_148 = resolved.font
          end
          if __lux_tmp_font_148 == nil then
            __lux_tmp_font_148 = "DermaDefault"
          end
          lw = __lux_module_1.measure(lines[index], __lux_tmp_font_148)
        end
        maxW = __lux_module_1.mathMax(maxW, lw)
      end
      local nativeFont, alias, oversample
      do
        local __lux_tmp_font_149 = font
        if __lux_tmp_font_149 == nil then
          __lux_tmp_font_149 = resolved.font
        end
        if __lux_tmp_font_149 == nil then
          __lux_tmp_font_149 = "DermaDefault"
        end
        nativeFont, alias, oversample = __lux_module_1.nativeFor(__lux_tmp_font_149, resolved)
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
      local __lux_match_150 = value
      if __lux_match_150 == "center" or __lux_match_150 == "middle" then
        return 0.5
      elseif __lux_match_150 == "right" or __lux_match_150 == "bottom" then
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
      local __lux_tmp_colorA_151 = fill.colorA
      if __lux_tmp_colorA_151 == nil then
        __lux_tmp_colorA_151 = fill.color
      end
      if __lux_tmp_colorA_151 == nil then
        __lux_tmp_colorA_151 = fill.fill
      end
      return __lux_module_1.style.colorOr(__lux_tmp_colorA_151, __lux_module_1.white)
    end
    __lux_module_1.setTextColor = function(color)
      local c = __lux_module_1.style.colorOr(color, __lux_module_1.white)
      if __lux_module_1.surfaceSetTextColor ~= nil then
        do
          local __lux_tmp_r_152 = c.r
          if __lux_tmp_r_152 == nil then
            __lux_tmp_r_152 = 255
          end
          local __lux_tmp_g_153 = c.g
          if __lux_tmp_g_153 == nil then
            __lux_tmp_g_153 = 255
          end
          local __lux_tmp_b_154 = c.b
          if __lux_tmp_b_154 == nil then
            __lux_tmp_b_154 = 255
          end
          local __lux_tmp_a_155 = c.a
          if __lux_tmp_a_155 == nil then
            __lux_tmp_a_155 = 255
          end
          __lux_module_1.surfaceSetTextColor(
            __lux_tmp_r_152,
            __lux_tmp_g_153,
            __lux_tmp_b_154,
            __lux_tmp_a_155
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
        local __lux_tmp_text_156 = text
        if __lux_tmp_text_156 == nil then
          __lux_tmp_text_156 = ""
        end
        raw = __lux_module_1.toString(__lux_tmp_text_156)
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
          local __lux_tmp_cw_157 = cw
          if __lux_tmp_cw_157 == nil then
            __lux_tmp_cw_157 = 0
          end
          cursor = cursor + __lux_tmp_cw_157 + extra * __lux_module_1.normalizeOversample(oversample)
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
          local __lux_tmp_fill_158 = fill
          if __lux_tmp_fill_158 == nil then
            __lux_tmp_fill_158 = fallbackColor
          end
          __lux_module_1.drawLineText(
            layout.font,
            line.text,
            x,
            y + line.y * oversample,
            __lux_module_1.colorAtFill(__lux_tmp_fill_158, t),
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
          local __lux_tmp_value_159 = __lux_module_1.toNumber(value)
          if __lux_tmp_value_159 == nil then
            __lux_tmp_value_159 = 0
          end
          value = { blur = __lux_tmp_value_159 }
        end
      end
      local __lux_tmp_x_160 = value.x
      if __lux_tmp_x_160 == nil then
        __lux_tmp_x_160 = value.offsetX
      end
      if __lux_tmp_x_160 == nil then
        __lux_tmp_x_160 = value[1]
      end
      local __lux_tmp_x_161 = __lux_module_1.toNumber(__lux_tmp_x_160)
      if __lux_tmp_x_161 == nil then
        __lux_tmp_x_161 = 1
      end
      local __lux_tmp_y_162 = value.y
      if __lux_tmp_y_162 == nil then
        __lux_tmp_y_162 = value.offsetY
      end
      if __lux_tmp_y_162 == nil then
        __lux_tmp_y_162 = value[2]
      end
      local __lux_tmp_y_163 = __lux_module_1.toNumber(__lux_tmp_y_162)
      if __lux_tmp_y_163 == nil then
        __lux_tmp_y_163 = 1
      end
      local __lux_tmp_blur_164 = value.blur
      if __lux_tmp_blur_164 == nil then
        __lux_tmp_blur_164 = value.radius
      end
      if __lux_tmp_blur_164 == nil then
        __lux_tmp_blur_164 = value[3]
      end
      local __lux_tmp_blur_165 = __lux_module_1.toNumber(__lux_tmp_blur_164)
      if __lux_tmp_blur_165 == nil then
        __lux_tmp_blur_165 = 0
      end
      local __lux_tmp_strength_166 = value.strength
      if __lux_tmp_strength_166 == nil then
        __lux_tmp_strength_166 = value.opacity
      end
      local __lux_tmp_strength_167 = __lux_module_1.toNumber(__lux_tmp_strength_166)
      if __lux_tmp_strength_167 == nil then
        __lux_tmp_strength_167 = 1
      end
      local __lux_tmp_color_168 = value.color
      if __lux_tmp_color_168 == nil then
        __lux_tmp_color_168 = value.tint
      end
      return {
        x = __lux_tmp_x_161,
        y = __lux_tmp_y_163,
        blur = __lux_tmp_blur_165,
        strength = __lux_tmp_strength_167,
        color = __lux_module_1.style.colorOr(
          __lux_tmp_color_168,
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
          local __lux_tmp_value_169 = __lux_module_1.toNumber(value)
          if __lux_tmp_value_169 == nil then
            __lux_tmp_value_169 = 1
          end
          value = { width = __lux_tmp_value_169 }
        end
      end
      local width
      do
        local __lux_tmp_width_170 = value.width
        if __lux_tmp_width_170 == nil then
          __lux_tmp_width_170 = value.size
        end
        if __lux_tmp_width_170 == nil then
          __lux_tmp_width_170 = value[1]
        end
        local __lux_tmp_width_171 = __lux_module_1.toNumber(__lux_tmp_width_170)
        if __lux_tmp_width_171 == nil then
          __lux_tmp_width_171 = 1
        end
        width = __lux_module_1.mathMax(0, __lux_tmp_width_171)
      end
      if width <= 0 then
        return nil
      end
      local __lux_tmp_softness_172 = __lux_module_1.toNumber(value.softness)
      if __lux_tmp_softness_172 == nil then
        __lux_tmp_softness_172 = 0
      end
      local __lux_tmp_color_173 = value.color
      if __lux_tmp_color_173 == nil then
        __lux_tmp_color_173 = value.tint
      end
      return {
        width = width,
        samples = __lux_module_1.mathClamp(__lux_module_1.mathCeil(width * 6), 8, 32),
        softness = __lux_tmp_softness_172,
        color = __lux_module_1.style.colorOr(
          __lux_tmp_color_173,
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
          local __lux_tmp_value_174 = __lux_module_1.toNumber(value)
          if __lux_tmp_value_174 == nil then
            __lux_tmp_value_174 = 6
          end
          value = { width = __lux_tmp_value_174 }
        end
      end
      local width
      do
        local __lux_tmp_width_175 = value.width
        if __lux_tmp_width_175 == nil then
          __lux_tmp_width_175 = value.size
        end
        if __lux_tmp_width_175 == nil then
          __lux_tmp_width_175 = value.radius
        end
        if __lux_tmp_width_175 == nil then
          __lux_tmp_width_175 = value[1]
        end
        local __lux_tmp_width_176 = __lux_module_1.toNumber(__lux_tmp_width_175)
        if __lux_tmp_width_176 == nil then
          __lux_tmp_width_176 = 6
        end
        width = __lux_module_1.mathMax(0, __lux_tmp_width_176)
      end
      if width <= 0 then
        return nil
      end
      local __lux_tmp_strength_177 = value.strength
      if __lux_tmp_strength_177 == nil then
        __lux_tmp_strength_177 = value.opacity
      end
      local __lux_tmp_strength_178 = __lux_module_1.toNumber(__lux_tmp_strength_177)
      if __lux_tmp_strength_178 == nil then
        __lux_tmp_strength_178 = 0.45
      end
      local __lux_tmp_falloff_179 = __lux_module_1.toNumber(value.falloff)
      if __lux_tmp_falloff_179 == nil then
        __lux_tmp_falloff_179 = __lux_module_1.style.glowSoftnessToFalloff(value.softness, 0.58)
      end
      local __lux_tmp_color_180 = value.color
      if __lux_tmp_color_180 == nil then
        __lux_tmp_color_180 = value.tint
      end
      return {
        width = width,
        samples = __lux_module_1.mathClamp(__lux_module_1.mathCeil(width * 2), 8, 36),
        strength = __lux_tmp_strength_178,
        falloff = __lux_tmp_falloff_179,
        color = __lux_module_1.style.colorOr(
          __lux_tmp_color_180,
          __lux_module_1.makeColor(255, 255, 255, 120)
        ),
      }
    end
    __lux_module_1.scaledColor = function(input, scale)
      local color = __lux_module_1.style.colorOr(input, __lux_module_1.white)
      local __lux_tmp_r_181 = color.r
      if __lux_tmp_r_181 == nil then
        __lux_tmp_r_181 = 255
      end
      local __lux_tmp_g_182 = color.g
      if __lux_tmp_g_182 == nil then
        __lux_tmp_g_182 = 255
      end
      local __lux_tmp_b_183 = color.b
      if __lux_tmp_b_183 == nil then
        __lux_tmp_b_183 = 255
      end
      local __lux_tmp_a_184 = color.a
      if __lux_tmp_a_184 == nil then
        __lux_tmp_a_184 = 255
      end
      local __lux_tmp_scale_185 = scale
      if __lux_tmp_scale_185 == nil then
        __lux_tmp_scale_185 = 1
      end
      return __lux_module_1.makeColor(
        __lux_tmp_r_181,
        __lux_tmp_g_182,
        __lux_tmp_b_183,
        __lux_module_1.mathClamp(
          __lux_module_1.mathFloor(__lux_tmp_a_184 * __lux_tmp_scale_185),
          0,
          255
        )
      )
    end
    __lux_module_1.snapTextPos = function(x, y, textStyle)
      local __lux_obj_textStyle_186 = textStyle
      local __lux_val_pixelSnap_187 = nil
      if __lux_obj_textStyle_186 ~= nil then
        __lux_val_pixelSnap_187 = __lux_obj_textStyle_186.pixelSnap
      end
      if __lux_val_pixelSnap_187 == false then
        return x, y
      end
      local __lux_tmp_x_188 = x
      if __lux_tmp_x_188 == nil then
        __lux_tmp_x_188 = 0
      end
      local __lux_tmp_y_189 = y
      if __lux_tmp_y_189 == nil then
        __lux_tmp_y_189 = 0
      end
      return __lux_module_1.mathFloor(__lux_tmp_x_188 + 0.5), __lux_module_1.mathFloor(__lux_tmp_y_189 + 0.5)
    end
    __lux_module_1.drawNativeFallbackRecord = function(record)
      local textStyle = record.style
      if textStyle == nil then
        textStyle = {}
      end
      local layout = __lux_module_1.layoutFor(record.text, record.font, textStyle, true)
      local x
      do
        local __lux_tmp_x_190 = record.x
        if __lux_tmp_x_190 == nil then
          __lux_tmp_x_190 = 0
        end
        x = __lux_tmp_x_190 - layout.w * __lux_module_1.alignFactor(record.alignX)
      end
      local y
      do
        local __lux_tmp_y_191 = record.y
        if __lux_tmp_y_191 == nil then
          __lux_tmp_y_191 = 0
        end
        y = __lux_tmp_y_191 - layout.h * __lux_module_1.alignFactor(record.alignY, true)
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
        local __lux_tmp_stroke_192 = textStyle.stroke
        if __lux_tmp_stroke_192 == nil then
          __lux_tmp_stroke_192 = textStyle.outline
        end
        stroke = __lux_module_1.normalizeStroke(__lux_tmp_stroke_192)
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
        local __lux_tmp_color_193 = record.color
        if __lux_tmp_color_193 == nil then
          __lux_tmp_color_193 = __lux_module_1.white
        end
        __lux_module_1.drawLayout(layout, x, y, fill, __lux_tmp_color_193)
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
          local __lux_tmp_color_194 = record.color
          if __lux_tmp_color_194 == nil then
            __lux_tmp_color_194 = __lux_module_1.white
          end
          fill = __lux_tmp_color_194
        end
      end
      local nativeFont, alias = __lux_module_1.nativeFor(record.font, textStyle, true, true)
      local tracking
      do
        local __lux_tmp_tracking_195 = textStyle.tracking
        if __lux_tmp_tracking_195 == nil then
          __lux_tmp_tracking_195 = textStyle.letterSpacing
        end
        tracking = __lux_module_1.toNumber(__lux_tmp_tracking_195)
        if tracking == nil then
          tracking = alias.tracking
          if tracking == nil then
            tracking = 0
          end
        end
      end
      local raw
      do
        local __lux_tmp_text_196 = record.text
        if __lux_tmp_text_196 == nil then
          __lux_tmp_text_196 = ""
        end
        raw = __lux_module_1.toString(__lux_tmp_text_196)
      end
      if tracking == 0 and __lux_module_1.stringFind(raw, "\n", 1, true) == nil and textStyle.lineHeight == nil and alias.lineHeight == nil and not __lux_module_1.fillNeedsShader(fill) and __lux_module_1.drawSimpleText ~= nil then
        local x, y
        do
          local __lux_tmp_x_197 = record.x
          if __lux_tmp_x_197 == nil then
            __lux_tmp_x_197 = 0
          end
          local __lux_tmp_y_198 = record.y
          if __lux_tmp_y_198 == nil then
            __lux_tmp_y_198 = 0
          end
          x, y = __lux_module_1.snapTextPos(__lux_tmp_x_197, __lux_tmp_y_198, textStyle)
        end
        do
          local __lux_tmp_color_199 = record.color
          if __lux_tmp_color_199 == nil then
            __lux_tmp_color_199 = __lux_module_1.white
          end
          local __lux_tmp_alignX_200 = record.alignX
          if __lux_tmp_alignX_200 == nil then
            __lux_tmp_alignX_200 = TEXT_ALIGN_LEFT
          end
          local __lux_tmp_alignY_201 = record.alignY
          if __lux_tmp_alignY_201 == nil then
            __lux_tmp_alignY_201 = TEXT_ALIGN_TOP
          end
          __lux_module_1.drawSimpleText(
            raw,
            __lux_module_1.setFontSafe(nativeFont),
            x,
            y,
            __lux_module_1.style.colorOr(fill, __lux_tmp_color_199),
            __lux_tmp_alignX_200,
            __lux_tmp_alignY_201
          )
        end
        return record
      end
      local layout = __lux_module_1.layoutFor(raw, record.font, textStyle, true, true)
      local x
      do
        local __lux_tmp_x_202 = record.x
        if __lux_tmp_x_202 == nil then
          __lux_tmp_x_202 = 0
        end
        x = __lux_tmp_x_202 - layout.w * __lux_module_1.alignFactor(record.alignX)
      end
      local y
      do
        local __lux_tmp_y_203 = record.y
        if __lux_tmp_y_203 == nil then
          __lux_tmp_y_203 = 0
        end
        y = __lux_tmp_y_203 - layout.h * __lux_module_1.alignFactor(record.alignY, true)
      end
      x, y = __lux_module_1.snapTextPos(x, y, textStyle)
      do
        local __lux_tmp_color_204 = record.color
        if __lux_tmp_color_204 == nil then
          __lux_tmp_color_204 = __lux_module_1.white
        end
        __lux_module_1.drawLayout(layout, x, y, fill, __lux_tmp_color_204)
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
      local __lux_obj_renderer_205 = renderer
      local __lux_val_DrawTextImmediate_206 = nil
      if __lux_obj_renderer_205 ~= nil then
        __lux_val_DrawTextImmediate_206 = __lux_obj_renderer_205.DrawTextImmediate
      end
      if __lux_val_DrawTextImmediate_206 ~= nil then
        return renderer.DrawTextImmediate(value, font, x, y, color, ax, ay, textStyle)
      end
      local resolved
      do
        local __lux_tmp_textStyle_207 = textStyle
        if __lux_tmp_textStyle_207 == nil then
          __lux_tmp_textStyle_207 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_textStyle_207)
      end
      local record
      do
        local __lux_tmp_value_208 = value
        if __lux_tmp_value_208 == nil then
          __lux_tmp_value_208 = ""
        end
        local __lux_tmp_font_209 = resolved.font
        if __lux_tmp_font_209 == nil then
          __lux_tmp_font_209 = font
        end
        if __lux_tmp_font_209 == nil then
          __lux_tmp_font_209 = "DermaDefault"
        end
        local __lux_tmp_x_210 = __lux_module_1.toNumber(x)
        if __lux_tmp_x_210 == nil then
          __lux_tmp_x_210 = 0
        end
        local __lux_tmp_y_211 = __lux_module_1.toNumber(y)
        if __lux_tmp_y_211 == nil then
          __lux_tmp_y_211 = 0
        end
        local __lux_tmp_color_212 = color
        if __lux_tmp_color_212 == nil then
          __lux_tmp_color_212 = resolved.color
        end
        if __lux_tmp_color_212 == nil then
          __lux_tmp_color_212 = resolved.fill
        end
        local __lux_tmp_alignX_213 = resolved.alignX
        if __lux_tmp_alignX_213 == nil then
          __lux_tmp_alignX_213 = resolved.align
        end
        if __lux_tmp_alignX_213 == nil then
          __lux_tmp_alignX_213 = ax
        end
        if __lux_tmp_alignX_213 == nil then
          __lux_tmp_alignX_213 = TEXT_ALIGN_LEFT
        end
        local __lux_tmp_alignY_214 = resolved.alignY
        if __lux_tmp_alignY_214 == nil then
          __lux_tmp_alignY_214 = resolved.valign
        end
        if __lux_tmp_alignY_214 == nil then
          __lux_tmp_alignY_214 = ay
        end
        if __lux_tmp_alignY_214 == nil then
          __lux_tmp_alignY_214 = TEXT_ALIGN_TOP
        end
        record = {
          text = __lux_module_1.toString(__lux_tmp_value_208),
          font = __lux_tmp_font_209,
          x = __lux_tmp_x_210,
          y = __lux_tmp_y_211,
          color = __lux_module_1.style.colorOr(__lux_tmp_color_212, __lux_module_1.white),
          alignX = __lux_tmp_alignX_213,
          alignY = __lux_tmp_alignY_214,
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
        local __lux_tmp_textStyle_215 = textStyle
        if __lux_tmp_textStyle_215 == nil then
          __lux_tmp_textStyle_215 = {}
        end
        out = __lux_module_1.copyValue(__lux_tmp_textStyle_215)
      end
      out.alignY = TEXT_ALIGN_TOP
      out.valign = TEXT_ALIGN_TOP
      return out
    end
    __lux_module_1.boxEx = function(value, font, x, y, w, h, textStyle)
      local renderer = __lux_module_1.sharedTextRenderer()
      local __lux_obj_renderer_216 = renderer
      local __lux_val_DrawTextBoxImmediate_217 = nil
      if __lux_obj_renderer_216 ~= nil then
        __lux_val_DrawTextBoxImmediate_217 = __lux_obj_renderer_216.DrawTextBoxImmediate
      end
      if __lux_val_DrawTextBoxImmediate_217 ~= nil then
        return renderer.DrawTextBoxImmediate(value, font, x, y, w, h, textStyle)
      end
      local resolved
      do
        local __lux_tmp_textStyle_218 = textStyle
        if __lux_tmp_textStyle_218 == nil then
          __lux_tmp_textStyle_218 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_textStyle_218)
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
        local __lux_tmp_w_219 = __lux_module_1.toNumber(w)
        if __lux_tmp_w_219 == nil then
          __lux_tmp_w_219 = 0
        end
        lines = __lux_module_1.wrapText(value, resolvedFont, __lux_tmp_w_219, resolved.overflow)
      end
      local nativeFont, alias, oversample = __lux_module_1.nativeFor(resolvedFont, resolved)
      local lineHeight = __lux_module_1.lineHeightFor(nativeFont, alias, resolved, oversample)
      local totalH = #lines * lineHeight
      local startY
      do
        local __lux_tmp_y_220 = __lux_module_1.toNumber(y)
        if __lux_tmp_y_220 == nil then
          __lux_tmp_y_220 = 0
        end
        local __lux_tmp_h_221 = __lux_module_1.toNumber(h)
        if __lux_tmp_h_221 == nil then
          __lux_tmp_h_221 = totalH
        end
        local __lux_tmp_alignY_222 = resolved.alignY
        if __lux_tmp_alignY_222 == nil then
          __lux_tmp_alignY_222 = resolved.valign
        end
        if __lux_tmp_alignY_222 == nil then
          __lux_tmp_alignY_222 = TEXT_ALIGN_TOP
        end
        startY = __lux_tmp_y_220 + (__lux_tmp_h_221 - totalH) * __lux_module_1.alignFactor(__lux_tmp_alignY_222, true)
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
        local __lux_tmp_x_223 = __lux_module_1.toNumber(x)
        if __lux_tmp_x_223 == nil then
          __lux_tmp_x_223 = 0
        end
        local __lux_tmp_w_224 = __lux_module_1.toNumber(w)
        if __lux_tmp_w_224 == nil then
          __lux_tmp_w_224 = 0
        end
        tx = __lux_tmp_x_223 + __lux_tmp_w_224 * __lux_module_1.alignFactor(ax)
      end
      local lineStyle = __lux_module_1.textBoxLineStyle(resolved)
      for index = 1, #lines do
        do
          local __lux_tmp_color_225 = lineStyle.color
          if __lux_tmp_color_225 == nil then
            __lux_tmp_color_225 = lineStyle.fill
          end
          __lux_module_1.drawEx(
            lines[index],
            resolvedFont,
            tx,
            startY + (index - 1) * lineHeight,
            __lux_tmp_color_225,
            ax,
            TEXT_ALIGN_TOP,
            lineStyle
          )
        end
      end
    end
    __lux_module_1.batch = function(records)
      local renderer = __lux_module_1.sharedTextRenderer()
      local __lux_obj_renderer_226 = renderer
      local __lux_val_Flush_227 = nil
      if __lux_obj_renderer_226 ~= nil then
        __lux_val_Flush_227 = __lux_obj_renderer_226.Flush
      end
      if __lux_val_Flush_227 ~= nil and renderer.MakeRecord ~= nil then
        local normalized = {}
        do
          local __lux_tmp_records_228 = records
          if __lux_tmp_records_228 == nil then
            __lux_tmp_records_228 = {}
          end
          for index = 1, #__lux_tmp_records_228 do
            local record = records[index]
            if record ~= nil then
              do
                local __lux_tmp_text_229 = record.text
                if __lux_tmp_text_229 == nil then
                  __lux_tmp_text_229 = record.value
                end
                local __lux_tmp_alignX_230 = record.alignX
                if __lux_tmp_alignX_230 == nil then
                  __lux_tmp_alignX_230 = record.ax
                end
                local __lux_tmp_alignY_231 = record.alignY
                if __lux_tmp_alignY_231 == nil then
                  __lux_tmp_alignY_231 = record.ay
                end
                local __lux_tmp_style_232 = record.style
                if __lux_tmp_style_232 == nil then
                  __lux_tmp_style_232 = {}
                end
                normalized[#normalized + 1] = renderer.MakeRecord(
                  __lux_tmp_text_229,
                  record.font,
                  record.x,
                  record.y,
                  record.color,
                  __lux_tmp_alignX_230,
                  __lux_tmp_alignY_231,
                  __lux_tmp_style_232
                )
              end
            end
          end
        end
        return renderer.Flush(normalized, "batch")
      end
      do
        local __lux_tmp_records_233 = records
        if __lux_tmp_records_233 == nil then
          __lux_tmp_records_233 = {}
        end
        for index = 1, #__lux_tmp_records_233 do
          local record = records[index]
          do
            local __lux_tmp_alignX_234 = record.alignX
            if __lux_tmp_alignX_234 == nil then
              __lux_tmp_alignX_234 = record.ax
            end
            local __lux_tmp_alignY_235 = record.alignY
            if __lux_tmp_alignY_235 == nil then
              __lux_tmp_alignY_235 = record.ay
            end
            local __lux_tmp_style_236 = record.style
            if __lux_tmp_style_236 == nil then
              __lux_tmp_style_236 = {}
            end
            __lux_module_1.drawNativeFallbackRecord(
              {
                text = record.text,
                font = record.font,
                x = record.x,
                y = record.y,
                color = record.color,
                alignX = __lux_tmp_alignX_234,
                alignY = __lux_tmp_alignY_235,
                style = __lux_module_1.resolveStyle(__lux_tmp_style_236),
              }
            )
          end
        end
      end
      return records
    end
    __lux_module_1.prewarm = function(value, font, textStyle)
      local renderer = __lux_module_1.sharedTextRenderer()
      local __lux_obj_renderer_237 = renderer
      local __lux_val_PrewarmText_238 = nil
      if __lux_obj_renderer_237 ~= nil then
        __lux_val_PrewarmText_238 = __lux_obj_renderer_237.PrewarmText
      end
      if __lux_val_PrewarmText_238 ~= nil then
        return renderer.PrewarmText(value, font, textStyle)
      end
      local resolved
      do
        local __lux_tmp_textStyle_239 = textStyle
        if __lux_tmp_textStyle_239 == nil then
          __lux_tmp_textStyle_239 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_textStyle_239)
      end
      local layout
      do
        local __lux_tmp_font_240 = font
        if __lux_tmp_font_240 == nil then
          __lux_tmp_font_240 = resolved.font
        end
        if __lux_tmp_font_240 == nil then
          __lux_tmp_font_240 = "DermaDefault"
        end
        layout = __lux_module_1.layoutFor(value, __lux_tmp_font_240, resolved)
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
        local __lux_tmp_times_241 = __lux_module_1.profile.times
        if __lux_tmp_times_241 == nil then
          __lux_tmp_times_241 = {}
        end
        local __lux_tmp_counts_242 = __lux_module_1.profile.counts
        if __lux_tmp_counts_242 == nil then
          __lux_tmp_counts_242 = {}
        end
        out = {
          active = __lux_module_1.profile.active,
          draws = __lux_module_1.profile.draws,
          measures = __lux_module_1.profile.measures,
          times = __lux_module_1.tableCopy(__lux_tmp_times_241),
          counts = __lux_module_1.tableCopy(__lux_tmp_counts_242),
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
        local __lux_tmp_textComposedEntries_243 = stats.textComposedEntries
        if __lux_tmp_textComposedEntries_243 == nil then
          __lux_tmp_textComposedEntries_243 = 0
        end
        stats.textComposedEntries = __lux_tmp_textComposedEntries_243
      end
      do
        local __lux_tmp_textComposedEvicts_244 = stats.textComposedEvicts
        if __lux_tmp_textComposedEvicts_244 == nil then
          __lux_tmp_textComposedEvicts_244 = 0
        end
        stats.textComposedEvicts = __lux_tmp_textComposedEvicts_244
      end
      do
        local __lux_tmp_textMeasureHits_245 = stats.textMeasureHits
        if __lux_tmp_textMeasureHits_245 == nil then
          __lux_tmp_textMeasureHits_245 = 0
        end
        stats.textMeasureHits = __lux_tmp_textMeasureHits_245
      end
      do
        local __lux_tmp_textMeasureMisses_246 = stats.textMeasureMisses
        if __lux_tmp_textMeasureMisses_246 == nil then
          __lux_tmp_textMeasureMisses_246 = 0
        end
        stats.textMeasureMisses = __lux_tmp_textMeasureMisses_246
      end
      do
        local __lux_tmp_textEntryCacheHits_247 = stats.textEntryCacheHits
        if __lux_tmp_textEntryCacheHits_247 == nil then
          __lux_tmp_textEntryCacheHits_247 = 0
        end
        stats.textEntryCacheHits = __lux_tmp_textEntryCacheHits_247
      end
      do
        local __lux_tmp_textEntryCacheMisses_248 = stats.textEntryCacheMisses
        if __lux_tmp_textEntryCacheMisses_248 == nil then
          __lux_tmp_textEntryCacheMisses_248 = 0
        end
        stats.textEntryCacheMisses = __lux_tmp_textEntryCacheMisses_248
      end
      do
        local __lux_tmp_textFallbacks_249 = stats.textFallbacks
        if __lux_tmp_textFallbacks_249 == nil then
          __lux_tmp_textFallbacks_249 = 0
        end
        stats.textFallbacks = __lux_tmp_textFallbacks_249
      end
      stats.textDataDraws = 0
      stats.textDataBatches = 0
      stats.textAtlasUploads = 0
      stats.textAtlasGlyphs = 0
      do
        local __lux_tmp_textAtlasResets_250 = stats.textAtlasResets
        if __lux_tmp_textAtlasResets_250 == nil then
          __lux_tmp_textAtlasResets_250 = 0
        end
        stats.textAtlasResets = __lux_tmp_textAtlasResets_250
      end
      stats.textCacheSize = __lux_module_1.measureOrderCount
      return stats
    end
    __lux_module_1.statAdd = function(stats, key, amount)
      if amount == nil then
        amount = 1
      end
      do
        local __lux_tmp_key_251 = stats[key]
        if __lux_tmp_key_251 == nil then
          __lux_tmp_key_251 = 0
        end
        stats[key] = __lux_tmp_key_251 + amount
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
          local __lux_tmp_getConVar_252 = __lux_module_1.getConVar("mgfx_text_composed")
          if __lux_tmp_getConVar_252 == nil then
            __lux_tmp_getConVar_252 = false
          end
          __lux_module_1.composedCvar = __lux_tmp_getConVar_252
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
          local __lux_tmp_getConVar_253 = __lux_module_1.getConVar("mgfx_text_composed_budget")
          if __lux_tmp_getConVar_253 == nil then
            __lux_tmp_getConVar_253 = false
          end
          __lux_module_1.budgetCvar = __lux_tmp_getConVar_253
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
      if __lux_module_1.renderOverrideAlphaWriteEnable ~= nil then
        __lux_module_1.renderOverrideAlphaWriteEnable(true, true)
      end
      if __lux_module_1.renderOverrideBlend ~= nil then
        __lux_module_1.renderOverrideBlend(
          true,
          BLEND_SRC_ALPHA,
          BLEND_ONE_MINUS_SRC_ALPHA,
          BLENDFUNC_ADD,
          BLEND_ONE,
          BLEND_ONE_MINUS_SRC_ALPHA,
          BLENDFUNC_ADD
        )
      end
      return alpha, cr, cg, cb, blend
    end
    __lux_module_1.endAtlasDraw = function(alpha, cr, cg, cb, blend)
      if __lux_module_1.renderOverrideBlend ~= nil then
        __lux_module_1.renderOverrideBlend(false)
      end
      if __lux_module_1.renderOverrideAlphaWriteEnable ~= nil then
        __lux_module_1.renderOverrideAlphaWriteEnable(false)
      end
      if __lux_module_1.surfaceSetAlphaMultiplier ~= nil then
        do
          local __lux_tmp_alpha_254 = alpha
          if __lux_tmp_alpha_254 == nil then
            __lux_tmp_alpha_254 = 1
          end
          __lux_module_1.surfaceSetAlphaMultiplier(__lux_tmp_alpha_254)
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
        local __lux_tmp_x_255 = x
        if __lux_tmp_x_255 == nil then
          __lux_tmp_x_255 = 0
        end
        x = __lux_module_1.mathFloor(__lux_module_1.mathMax(0, __lux_tmp_x_255))
      end
      do
        local __lux_tmp_y_256 = y
        if __lux_tmp_y_256 == nil then
          __lux_tmp_y_256 = 0
        end
        y = __lux_module_1.mathFloor(__lux_module_1.mathMax(0, __lux_tmp_y_256))
      end
      do
        local __lux_tmp_w_257 = w
        if __lux_tmp_w_257 == nil then
          __lux_tmp_w_257 = 0
        end
        w = __lux_module_1.mathCeil(
          __lux_module_1.mathMin(__lux_module_1.ATLAS_W - x, __lux_tmp_w_257)
        )
      end
      do
        local __lux_tmp_h_258 = h
        if __lux_tmp_h_258 == nil then
          __lux_tmp_h_258 = 0
        end
        h = __lux_module_1.mathCeil(
          __lux_module_1.mathMin(__lux_module_1.ATLAS_H - y, __lux_tmp_h_258)
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
      local baseName
      do
        local __lux_tmp_atlasNamespace_259 = __lux_module_1.atlasNamespace
        if __lux_tmp_atlasNamespace_259 == nil then
          __lux_tmp_atlasNamespace_259 = __lux_module_1.nextAtlasNamespace()
        end
        baseName = __lux_tmp_atlasNamespace_259 ..
          "_" .. __lux_module_1.toString(index) .. "_" .. __lux_module_1.toString(stamp)
      end
      local flags = __lux_module_1.bitBor(256, 4, 8)
      local rt = __lux_module_1.getRenderTargetEx(
        baseName,
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
      local pageMaterial = __lux_module_1.createAtlasMaterial(baseName, rt)
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
          local __lux_obj_mats_260 = mats
          local __lux_val_compose_261 = nil
          if __lux_obj_mats_260 ~= nil then
            __lux_val_compose_261 = __lux_obj_mats_260.compose
          end
          page.composeMat = __lux_val_compose_261
        end
        do
          local __lux_obj_mats_262 = mats
          local __lux_val_face_263 = nil
          if __lux_obj_mats_262 ~= nil then
            __lux_val_face_263 = __lux_obj_mats_262.face
          end
          page.faceMat = __lux_val_face_263
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
        local __lux_tmp_generation_264 = page.generation
        if __lux_tmp_generation_264 == nil then
          __lux_tmp_generation_264 = 0
        end
        page.generation = __lux_tmp_generation_264 + 1
      end
      if page.rt ~= nil then
        do
          local __lux_tmp_w_265 = page.w
          if __lux_tmp_w_265 == nil then
            __lux_tmp_w_265 = __lux_module_1.ATLAS_W
          end
          local __lux_tmp_h_266 = page.h
          if __lux_tmp_h_266 == nil then
            __lux_tmp_h_266 = __lux_module_1.ATLAS_H
          end
          __lux_module_1.clearRenderTargetAlpha(page.rt, __lux_tmp_w_265, __lux_tmp_h_266)
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
        local __lux_obj_atlas_267 = __lux_module_1.atlas
        local __lux_tmp_material_268 = nil
        if __lux_obj_atlas_267 ~= nil then
          __lux_tmp_material_268 = __lux_obj_atlas_267.material
        end
        if __lux_tmp_material_268 == nil then
          __lux_tmp_material_268 = __lux_module_1.atlasMat
        end
        __lux_module_1.atlasMat = __lux_tmp_material_268
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
        local __lux_tmp_gutter_269 = __lux_module_1.toNumber(gutter)
        if __lux_tmp_gutter_269 == nil then
          __lux_tmp_gutter_269 = 0
        end
        gutter = __lux_module_1.mathCeil(__lux_module_1.mathMax(0, __lux_tmp_gutter_269))
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
          local __lux_tmp_h_270 = page.h
          if __lux_tmp_h_270 == nil then
            __lux_tmp_h_270 = __lux_module_1.ATLAS_H
          end
          local __lux_tmp_y_271 = page.y
          if __lux_tmp_y_271 == nil then
            __lux_tmp_y_271 = 0
          end
          local __lux_tmp_rowH_272 = page.rowH
          if __lux_tmp_rowH_272 == nil then
            __lux_tmp_rowH_272 = 0
          end
          usedH = usedH + __lux_module_1.mathMin(__lux_tmp_h_270, __lux_tmp_y_271 + __lux_tmp_rowH_272)
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
      local __lux_tmp_r_273 = c.r
      if __lux_tmp_r_273 == nil then
        __lux_tmp_r_273 = 0
      end
      local __lux_tmp_g_274 = c.g
      if __lux_tmp_g_274 == nil then
        __lux_tmp_g_274 = 0
      end
      local __lux_tmp_b_275 = c.b
      if __lux_tmp_b_275 == nil then
        __lux_tmp_b_275 = 0
      end
      local __lux_tmp_a_276 = c.a
      if __lux_tmp_a_276 == nil then
        __lux_tmp_a_276 = 255
      end
      return __lux_module_1.tableConcat(
        { __lux_tmp_r_273, __lux_tmp_g_274, __lux_tmp_b_275, __lux_tmp_a_276 },
        ","
      )
    end
    __lux_module_1.isColorValue = function(value)
      return __lux_module_1.style.isColor ~= nil and __lux_module_1.style.isColor(value)
    end
    __lux_module_1.fillForRecord = function(record)
      local textStyle
      do
        local __lux_obj_record_277 = record
        local __lux_val_style_278 = nil
        if __lux_obj_record_277 ~= nil then
          __lux_val_style_278 = __lux_obj_record_277.style
        end
        textStyle = __lux_val_style_278
        if textStyle == nil then
          textStyle = {}
        end
      end
      local __lux_tmp_fill_279 = textStyle.fill
      if __lux_tmp_fill_279 == nil then
        __lux_tmp_fill_279 = textStyle.color
      end
      if __lux_tmp_fill_279 == nil then
        local __lux_obj_record_280 = record
        local __lux_val_color_281 = nil
        if __lux_obj_record_280 ~= nil then
          __lux_val_color_281 = __lux_obj_record_280.color
        end
        __lux_tmp_fill_279 = __lux_val_color_281
      end
      if __lux_tmp_fill_279 == nil then
        __lux_tmp_fill_279 = __lux_module_1.white
      end
      return __lux_tmp_fill_279
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
        local __lux_tmp_strength_282 = value.strength
        if __lux_tmp_strength_282 == nil then
          __lux_tmp_strength_282 = value[1]
        end
        local __lux_tmp_strength_283 = __lux_module_1.toNumber(__lux_tmp_strength_282)
        if __lux_tmp_strength_283 == nil then
          __lux_tmp_strength_283 = 0.18
        end
        strength = __lux_module_1.mathClamp(__lux_tmp_strength_283, 0, 1)
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
        local __lux_tmp_stroke_284 = textStyle.stroke
        if __lux_tmp_stroke_284 == nil then
          __lux_tmp_stroke_284 = textStyle.outline
        end
        stroke = __lux_module_1.normalizeStroke(__lux_tmp_stroke_284)
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
      local __lux_tmp_285
      if stroke ~= nil then
        __lux_tmp_285 = stroke.width ..
          ":" ..
            stroke.samples .. ":" .. stroke.softness .. ":" .. __lux_module_1.colorKey(stroke.color)
      else
        __lux_tmp_285 = ""
      end
      local __lux_tmp_286
      if glow ~= nil then
        do
          local __lux_tmp_falloff_287 = glow.falloff
          if __lux_tmp_falloff_287 == nil then
            __lux_tmp_falloff_287 = ""
          end
          __lux_tmp_286 = glow.width ..
            ":" ..
              glow.strength ..
                ":" .. __lux_tmp_falloff_287 .. ":" .. __lux_module_1.colorKey(glow.color)
        end
      else
        __lux_tmp_286 = ""
      end
      local __lux_tmp_288
      if shadow ~= nil then
        __lux_tmp_288 = shadow.x ..
          ":" ..
            shadow.y ..
              ":" ..
                shadow.blur .. ":" .. shadow.strength .. ":" .. __lux_module_1.colorKey(shadow.color)
      else
        __lux_tmp_288 = ""
      end
      local __lux_tmp_289
      if face ~= nil then
        __lux_tmp_289 = __lux_module_1.toString(face.strength)
      else
        __lux_tmp_289 = ""
      end
      local __lux_tmp_weightAdjust_290 = weightAdjust
      if __lux_tmp_weightAdjust_290 == nil then
        __lux_tmp_weightAdjust_290 = 0
      end
      return __lux_module_1.tableConcat(
        {
          __lux_tmp_285,
          __lux_tmp_286,
          __lux_tmp_288,
          __lux_tmp_289,
          __lux_module_1.toString(__lux_tmp_weightAdjust_290),
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
        local __lux_tmp_tracking_291 = textStyle.tracking
        if __lux_tmp_tracking_291 == nil then
          __lux_tmp_tracking_291 = textStyle.letterSpacing
        end
        tracking = __lux_module_1.toNumber(__lux_tmp_tracking_291)
        if tracking == nil then
          tracking = alias.tracking
          if tracking == nil then
            tracking = 0
          end
        end
      end
      local lineHeight = __lux_module_1.lineHeightFor(nativeFont, alias, textStyle, oversample)
      local __lux_tmp_text_292 = record.text
      if __lux_tmp_text_292 == nil then
        __lux_tmp_text_292 = ""
      end
      local __lux_tmp_font_293 = record.font
      if __lux_tmp_font_293 == nil then
        __lux_tmp_font_293 = ""
      end
      local __lux_tmp_nativeFont_294 = nativeFont
      if __lux_tmp_nativeFont_294 == nil then
        __lux_tmp_nativeFont_294 = ""
      end
      local __lux_tmp_oversample_295 = oversample
      if __lux_tmp_oversample_295 == nil then
        __lux_tmp_oversample_295 = 1
      end
      local __lux_obj_info_296 = info
      local __lux_tmp_routeKey_297 = nil
      if __lux_obj_info_296 ~= nil then
        __lux_tmp_routeKey_297 = __lux_obj_info_296.routeKey
      end
      if __lux_tmp_routeKey_297 == nil then
        __lux_tmp_routeKey_297 = ""
      end
      return __lux_module_1.CACHE_VERSION ..
        "30" ..
          __lux_module_1.toString(__lux_tmp_text_292) ..
            "30" ..
              __lux_module_1.toString(__lux_tmp_font_293) ..
                "30" ..
                  __lux_module_1.toString(__lux_tmp_nativeFont_294) ..
                    "30" ..
                      __lux_module_1.toString(__lux_tmp_oversample_295) ..
                        "30" ..
                          __lux_module_1.toString(tracking) ..
                            "30" ..
                              __lux_module_1.toString(lineHeight) ..
                                "30" .. __lux_module_1.toString(__lux_tmp_routeKey_297)
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
        local __lux_tmp_r_298 = c.r
        if __lux_tmp_r_298 == nil then
          __lux_tmp_r_298 = 255
        end
        local __lux_tmp_g_299 = c.g
        if __lux_tmp_g_299 == nil then
          __lux_tmp_g_299 = 255
        end
        local __lux_tmp_b_300 = c.b
        if __lux_tmp_b_300 == nil then
          __lux_tmp_b_300 = 255
        end
        local __lux_tmp_a_301 = c.a
        if __lux_tmp_a_301 == nil then
          __lux_tmp_a_301 = 255
        end
        __lux_module_1.surfaceSetDrawColor(
          __lux_tmp_r_298,
          __lux_tmp_g_299,
          __lux_tmp_b_300,
          __lux_tmp_a_301
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
        local __lux_tmp_305 = shaderCapableFace
        if __lux_tmp_305 then
          local __lux_tmp_304 = face ~= nil
          if not __lux_tmp_304 then
            local __lux_tmp_weightAdjust_302 = weightAdjust
            if __lux_tmp_weightAdjust_302 == nil then
              __lux_tmp_weightAdjust_302 = 0
            end
            local __lux_cmp_303 = false
            if __lux_module_1.mathAbs(__lux_tmp_weightAdjust_302) ~= nil then
              __lux_cmp_303 = __lux_module_1.mathAbs(__lux_tmp_weightAdjust_302) > 0.001
            end
            __lux_tmp_304 = __lux_cmp_303
          end
          __lux_tmp_305 = __lux_tmp_304
        end
        shaderFace = __lux_tmp_305
      end
      if not shaderFace and shaderCapableFace then
        shaderFace = shadow ~= nil or stroke ~= nil or glow ~= nil
      end
      local entry
      do
        local __lux_tmp_weightAdjust_306 = weightAdjust
        if __lux_tmp_weightAdjust_306 == nil then
          __lux_tmp_weightAdjust_306 = 0
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
          weightAdjust = __lux_tmp_weightAdjust_306,
          shaderFace = shaderFace,
          generation = page.generation,
        }
      end
      __lux_module_1.composedCache[key] = entry
      __lux_module_1.composedCacheCount = __lux_module_1.composedCacheCount + 1
      do
        local __lux_tmp_stats_307 = stats
        if __lux_tmp_stats_307 == nil then
          __lux_tmp_stats_307 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_307, "textComposedBakes")
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
          local __lux_tmp_stats_308 = stats
          if __lux_tmp_stats_308 == nil then
            __lux_tmp_stats_308 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_308, "textEntryCacheHits")
        end
        return cached
      end
      do
        local __lux_tmp_stats_309 = stats
        if __lux_tmp_stats_309 == nil then
          __lux_tmp_stats_309 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_309, "textEntryCacheMisses")
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
      local __lux_tmp_312 = info.shadow ~= nil or info.stroke ~= nil or info.glow ~= nil or info.face ~= nil
      if not __lux_tmp_312 then
        local __lux_tmp_weightAdjust_310 = info.weightAdjust
        if __lux_tmp_weightAdjust_310 == nil then
          __lux_tmp_weightAdjust_310 = 0
        end
        local __lux_cmp_311 = false
        if __lux_module_1.mathAbs(__lux_tmp_weightAdjust_310) ~= nil then
          __lux_cmp_311 = __lux_module_1.mathAbs(__lux_tmp_weightAdjust_310) > 0.001
        end
        __lux_tmp_312 = __lux_cmp_311
      end
      local __lux_tmp_313 = __lux_tmp_312
      if not __lux_tmp_313 then
        __lux_tmp_313 = __lux_module_1.fillNeedsShader(__lux_module_1.fillForRecord(record))
      end
      return __lux_tmp_313
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
        local __lux_tmp_records_314 = records
        if __lux_tmp_records_314 == nil then
          __lux_tmp_records_314 = {}
        end
        for _, record in ipairs(__lux_tmp_records_314) do
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
          local __lux_tmp_stats_315 = stats
          if __lux_tmp_stats_315 == nil then
            __lux_tmp_stats_315 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_315, "textComposedPrewarmFails")
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
                local __lux_tmp_stats_316 = stats
                if __lux_tmp_stats_316 == nil then
                  __lux_tmp_stats_316 = {}
                end
                __lux_module_1.statAdd(__lux_tmp_stats_316, "textComposedPrewarmFails")
              end
              return false
            end
            record.__mgfxTextEntry = entry
            if __lux_module_1.atlasEpoch ~= generation then
              do
                local __lux_tmp_stats_317 = stats
                if __lux_tmp_stats_317 == nil then
                  __lux_tmp_stats_317 = {}
                end
                __lux_module_1.statAdd(__lux_tmp_stats_317, "textComposedPrewarmRestarts")
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
        local __lux_tmp_stats_318 = stats
        if __lux_tmp_stats_318 == nil then
          __lux_tmp_stats_318 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_318, "textComposedPrewarmFails")
      end
      return false
    end
    __lux_module_1.hasShaderFx = function(entry)
      local __lux_tmp_321 = entry ~= nil
      if __lux_tmp_321 then
        local __lux_tmp_320 = entry.shadow ~= nil or entry.stroke ~= nil or entry.glow ~= nil or entry.face ~= nil
        if not __lux_tmp_320 then
          local __lux_tmp_weightAdjust_319 = entry.weightAdjust
          if __lux_tmp_weightAdjust_319 == nil then
            __lux_tmp_weightAdjust_319 = 0
          end
          __lux_tmp_320 = __lux_tmp_weightAdjust_319 ~= 0
        end
        __lux_tmp_321 = __lux_tmp_320
      end
      return __lux_tmp_321
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
        local __lux_tmp_color_322 = effect.color
        if __lux_tmp_color_322 == nil then
          __lux_tmp_color_322 = __lux_module_1.white
        end
        r, g, b, a = __lux_module_1.style.color01(__lux_tmp_color_322)
      end
      return r, g, b, __lux_module_1.mathClamp(a * scale, 0, 1)
    end
    __lux_module_1.packShadowParams = function(x, y, stroke)
      do
        local __lux_tmp_x_323 = __lux_module_1.toNumber(x)
        if __lux_tmp_x_323 == nil then
          __lux_tmp_x_323 = 0
        end
        x = __lux_module_1.mathClamp(__lux_tmp_x_323, -64, 63.5)
      end
      do
        local __lux_tmp_y_324 = __lux_module_1.toNumber(y)
        if __lux_tmp_y_324 == nil then
          __lux_tmp_y_324 = 0
        end
        y = __lux_module_1.mathClamp(__lux_tmp_y_324, -64, 63.5)
      end
      local xb = __lux_module_1.mathClamp(__lux_module_1.mathFloor((x + 64) * 2 + 0.5), 0, 255)
      local yb = __lux_module_1.mathClamp(__lux_module_1.mathFloor((y + 64) * 2 + 0.5), 0, 255)
      local softness
      do
        local __lux_obj_stroke_325 = stroke
        local __lux_val_softness_326 = nil
        if __lux_obj_stroke_325 ~= nil then
          __lux_val_softness_326 = __lux_obj_stroke_325.softness
        end
        softness = __lux_val_softness_326
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
        local __lux_obj_shadow_327 = shadow
        local __lux_val_blur_328 = nil
        if __lux_obj_shadow_327 ~= nil then
          __lux_val_blur_328 = __lux_obj_shadow_327.blur
        end
        blur = __lux_val_blur_328
        if blur == nil then
          blur = 0
        end
      end
      local falloff
      do
        local __lux_obj_glow_329 = glow
        local __lux_val_falloff_330 = nil
        if __lux_obj_glow_329 ~= nil then
          __lux_val_falloff_330 = __lux_obj_glow_329.falloff
        end
        falloff = __lux_val_falloff_330
        if falloff == nil then
          falloff = 1.65
        end
      end
      local faceStrength
      do
        local __lux_obj_face_331 = face
        local __lux_val_strength_332 = nil
        if __lux_obj_face_331 ~= nil then
          __lux_val_strength_332 = __lux_obj_face_331.strength
        end
        faceStrength = __lux_val_strength_332
        if faceStrength == nil then
          faceStrength = 0
        end
      end
      local weight
      do
        local __lux_tmp_weightAdjust_333 = __lux_module_1.toNumber(weightAdjust)
        if __lux_tmp_weightAdjust_333 == nil then
          __lux_tmp_weightAdjust_333 = 0
        end
        weight = __lux_module_1.mathClamp(__lux_tmp_weightAdjust_333, -2, 2)
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
    __lux_module_1.setupTextComposeMaterial = function(material, entry, u0, v0, u1, v1)
      local stroke = entry.stroke
      local glow = entry.glow
      local shadow = entry.shadow
      local face = entry.face
      local oversample = __lux_module_1.normalizeOversample(entry.oversample)
      __lux_module_1.setupTextParamMatrix(
        material,
        u0,
        v0,
        u1,
        v1,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0
      )
      local r, g, b, a = __lux_module_1.scaledColor01(stroke, 1)
      material:SetFloat("$c0_x", r)
      material:SetFloat("$c0_y", g)
      material:SetFloat("$c0_z", b)
      material:SetFloat("$c0_w", a)
      do
        local __lux_obj_glow_334 = glow
        local __lux_tmp_strength_335 = nil
        if __lux_obj_glow_334 ~= nil then
          __lux_tmp_strength_335 = __lux_obj_glow_334.strength
        end
        if __lux_tmp_strength_335 == nil then
          __lux_tmp_strength_335 = 1
        end
        r, g, b, a = __lux_module_1.scaledColor01(glow, __lux_tmp_strength_335)
      end
      material:SetFloat("$c1_x", r)
      material:SetFloat("$c1_y", g)
      material:SetFloat("$c1_z", b)
      material:SetFloat("$c1_w", a)
      do
        local __lux_obj_shadow_336 = shadow
        local __lux_tmp_strength_337 = nil
        if __lux_obj_shadow_336 ~= nil then
          __lux_tmp_strength_337 = __lux_obj_shadow_336.strength
        end
        if __lux_tmp_strength_337 == nil then
          __lux_tmp_strength_337 = 1
        end
        r, g, b, a = __lux_module_1.scaledColor01(shadow, __lux_tmp_strength_337)
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
        local __lux_obj_scaledStroke_338 = scaledStroke
        local __lux_tmp_width_339 = nil
        if __lux_obj_scaledStroke_338 ~= nil then
          __lux_tmp_width_339 = __lux_obj_scaledStroke_338.width
        end
        if __lux_tmp_width_339 == nil then
          __lux_tmp_width_339 = 0
        end
        material:SetFloat("$c3_x", __lux_tmp_width_339)
      end
      do
        local __lux_tmp_340
        if glow ~= nil then
          __lux_tmp_340 = glow.width * oversample
        else
          __lux_tmp_340 = 0
        end
        material:SetFloat("$c3_y", __lux_tmp_340)
      end
      do
        local __lux_tmp_weightAdjust_341 = entry.weightAdjust
        if __lux_tmp_weightAdjust_341 == nil then
          __lux_tmp_weightAdjust_341 = 0
        end
        material:SetFloat(
          "$c3_z",
          __lux_module_1.packEffectParams(
            glow,
            scaledShadow,
            face,
            __lux_tmp_weightAdjust_341 * oversample,
            entry.shaderFace
          )
        )
      end
      local __lux_tmp_342
      if scaledShadow ~= nil then
        __lux_tmp_342 = __lux_module_1.packShadowParams(scaledShadow.x, scaledShadow.y, scaledStroke)
      else
        __lux_tmp_342 = __lux_module_1.packShadowParams(0, 0, scaledStroke)
      end
      return material:SetFloat("$c3_w", __lux_tmp_342)
    end
    __lux_module_1.fillEndpointColors = function(fill, fallback)
      if __lux_module_1.isColorValue(fill) then
        return fill, fill
      end
      if __lux_module_1.typeOf(fill) == "table" and __lux_module_1.typeOf(fill.stops) == "table" and #fill.stops > 0 then
        local first = fill.stops[1]
        local last = fill.stops[#fill.stops]
        local __lux_tmp_color_343 = first.color
        if __lux_tmp_color_343 == nil then
          __lux_tmp_color_343 = first[2]
        end
        local __lux_tmp_fallback_344 = fallback
        if __lux_tmp_fallback_344 == nil then
          __lux_tmp_fallback_344 = __lux_module_1.white
        end
        local __lux_tmp_color_345 = last.color
        if __lux_tmp_color_345 == nil then
          __lux_tmp_color_345 = last[2]
        end
        local __lux_tmp_fallback_346 = fallback
        if __lux_tmp_fallback_346 == nil then
          __lux_tmp_fallback_346 = __lux_module_1.white
        end
        return __lux_module_1.style.asColor(__lux_tmp_color_343, __lux_tmp_fallback_344), __lux_module_1.style.asColor(__lux_tmp_color_345, __lux_tmp_fallback_346)
      end
      if __lux_module_1.typeOf(fill) == "table" then
        local a
        do
          local __lux_tmp_colorA_347 = fill.colorA
          if __lux_tmp_colorA_347 == nil then
            __lux_tmp_colorA_347 = fill[1]
          end
          local __lux_tmp_fallback_348 = fallback
          if __lux_tmp_fallback_348 == nil then
            __lux_tmp_fallback_348 = __lux_module_1.white
          end
          a = __lux_module_1.style.asColor(__lux_tmp_colorA_347, __lux_tmp_fallback_348)
        end
        local __lux_tmp_colorB_349 = fill.colorB
        if __lux_tmp_colorB_349 == nil then
          __lux_tmp_colorB_349 = fill[2]
        end
        return a, __lux_module_1.style.asColor(__lux_tmp_colorB_349, a)
      end
      local c
      do
        local __lux_tmp_fallback_350 = fallback
        if __lux_tmp_fallback_350 == nil then
          __lux_tmp_fallback_350 = __lux_module_1.white
        end
        c = __lux_module_1.style.asColor(fill, __lux_tmp_fallback_350)
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
        local __lux_tmp_color_351 = record.color
        if __lux_tmp_color_351 == nil then
          __lux_tmp_color_351 = __lux_module_1.white
        end
        colorA, colorB = __lux_module_1.fillEndpointColors(fill, __lux_tmp_color_351)
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
          local __lux_tmp_x1_352 = __lux_module_1.toNumber(fill.x1)
          if __lux_tmp_x1_352 == nil then
            __lux_tmp_x1_352 = 0
          end
          material:SetFloat("$c3_x", __lux_tmp_x1_352)
        end
        do
          local __lux_tmp_y1_353 = __lux_module_1.toNumber(fill.y1)
          if __lux_tmp_y1_353 == nil then
            __lux_tmp_y1_353 = 0
          end
          material:SetFloat("$c3_y", __lux_tmp_y1_353)
        end
        do
          local __lux_tmp_x2_354 = __lux_module_1.toNumber(fill.x2)
          if __lux_tmp_x2_354 == nil then
            __lux_tmp_x2_354 = 1
          end
          material:SetFloat("$c3_z", __lux_tmp_x2_354)
        end
        local __lux_tmp_y2_355 = __lux_module_1.toNumber(fill.y2)
        if __lux_tmp_y2_355 == nil then
          __lux_tmp_y2_355 = 0
        end
        return material:SetFloat("$c3_w", __lux_tmp_y2_355)
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
        local __lux_obj_entry_356 = entry
        local __lux_val_page_357 = nil
        if __lux_obj_entry_356 ~= nil then
          __lux_val_page_357 = __lux_obj_entry_356.page
        end
        page = __lux_val_page_357
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
        local __lux_tmp_atlasW_358 = entry.atlasW
        if __lux_tmp_atlasW_358 == nil then
          __lux_tmp_atlasW_358 = entry.w
        end
        u1 = (entry.slotX + __lux_tmp_atlasW_358) / page.w
      end
      local v1
      do
        local __lux_tmp_atlasH_359 = entry.atlasH
        if __lux_tmp_atlasH_359 == nil then
          __lux_tmp_atlasH_359 = entry.h
        end
        v1 = (entry.slotY + __lux_tmp_atlasH_359) / page.h
      end
      local fx = __lux_module_1.hasShaderFx(entry)
      local faceMat = __lux_module_1.isMaterialOK(page.faceMat) and page.faceMat or __lux_module_1.isMaterialOK(__lux_module_1.materials.text_face) and __lux_module_1.materials.text_face or page.material or __lux_module_1.atlasMat
      local composeMat = __lux_module_1.isMaterialOK(page.composeMat) and page.composeMat or __lux_module_1.materials.text_compose
      local material = fx and composeMat or faceMat
      if fx and __lux_module_1.isMaterialOK(material) then
        material:SetTexture("$basetexture", page.rt)
        __lux_module_1.setupTextComposeMaterial(material, entry, u0, v0, u1, v1)
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
          local __lux_tmp_fillOverride_360 = fillOverride
          if __lux_tmp_fillOverride_360 == nil then
            __lux_tmp_fillOverride_360 = __lux_module_1.fillForRecord(record)
          end
          local __lux_tmp_color_361 = record.color
          if __lux_tmp_color_361 == nil then
            __lux_tmp_color_361 = __lux_module_1.white
          end
          drawColor = __lux_module_1.style.asColor(__lux_tmp_fillOverride_360, __lux_tmp_color_361)
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
        local __lux_tmp_stats_362 = stats
        if __lux_tmp_stats_362 == nil then
          __lux_tmp_stats_362 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_362, "textComposedBlits", blits)
      end
      if fx then
        do
          local __lux_tmp_stats_363 = stats
          if __lux_tmp_stats_363 == nil then
            __lux_tmp_stats_363 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_363, "textShaderDraws")
        end
      end
      return fx
    end
    __lux_module_1.blitEntry = function(entry, record, stats)
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
        local __lux_tmp_stats_366 = stats
        if __lux_tmp_stats_366 == nil then
          __lux_tmp_stats_366 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_366, "textComposedDraws")
      end
      if fx then
        do
          local __lux_tmp_stats_367 = stats
          if __lux_tmp_stats_367 == nil then
            __lux_tmp_stats_367 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_367, "textComposedFxDraws")
        end
      else
        do
          local __lux_tmp_stats_368 = stats
          if __lux_tmp_stats_368 == nil then
            __lux_tmp_stats_368 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_368, "textComposedFaceDraws")
        end
      end
      return fx
    end
    __lux_module_1.textBatchKey = function(entry, record)
      local page
      do
        local __lux_obj_entry_369 = entry
        local __lux_val_page_370 = nil
        if __lux_obj_entry_369 ~= nil then
          __lux_val_page_370 = __lux_obj_entry_369.page
        end
        page = __lux_val_page_370
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
        local __lux_tmp_index_371 = page.index
        if __lux_tmp_index_371 == nil then
          __lux_tmp_index_371 = 0
        end
        return "plain27" .. __lux_module_1.toString(__lux_tmp_index_371)
      end
      return nil
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
        local __lux_tmp_r_372 = color.r
        if __lux_tmp_r_372 == nil then
          __lux_tmp_r_372 = 255
        end
        local __lux_tmp_g_373 = color.g
        if __lux_tmp_g_373 == nil then
          __lux_tmp_g_373 = 255
        end
        local __lux_tmp_b_374 = color.b
        if __lux_tmp_b_374 == nil then
          __lux_tmp_b_374 = 255
        end
        local __lux_tmp_a_375 = color.a
        if __lux_tmp_a_375 == nil then
          __lux_tmp_a_375 = 255
        end
        __lux_module_1.meshColor(
          __lux_tmp_r_372,
          __lux_tmp_g_373,
          __lux_tmp_b_374,
          __lux_tmp_a_375
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
        local __lux_tmp_atlasW_376 = entry.atlasW
        if __lux_tmp_atlasW_376 == nil then
          __lux_tmp_atlasW_376 = entry.w
        end
        u1 = (entry.slotX + __lux_tmp_atlasW_376) / page.w
      end
      local v1
      do
        local __lux_tmp_atlasH_377 = entry.atlasH
        if __lux_tmp_atlasH_377 == nil then
          __lux_tmp_atlasH_377 = entry.h
        end
        v1 = (entry.slotY + __lux_tmp_atlasH_377) / page.h
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
          local __lux_tmp_stats_378 = stats
          if __lux_tmp_stats_378 == nil then
            __lux_tmp_stats_378 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_378, "textComposedDraws")
        end
        do
          local __lux_tmp_stats_379 = stats
          if __lux_tmp_stats_379 == nil then
            __lux_tmp_stats_379 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_379, "textComposedFxDraws")
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
          local __lux_obj_page_380 = firstEntry.page
          local __lux_val_material_381 = nil
          if __lux_obj_page_380 ~= nil then
            __lux_val_material_381 = __lux_obj_page_380.material
          end
          material = __lux_val_material_381
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
        do
          local __lux_tmp_atlasW_382 = firstEntry.atlasW
          if __lux_tmp_atlasW_382 == nil then
            __lux_tmp_atlasW_382 = firstEntry.w
          end
          local __lux_tmp_atlasH_383 = firstEntry.atlasH
          if __lux_tmp_atlasH_383 == nil then
            __lux_tmp_atlasH_383 = firstEntry.h
          end
          __lux_module_1.setupTextComposeMaterial(
            material,
            firstEntry,
            firstEntry.slotX / firstEntry.page.w,
            firstEntry.slotY / firstEntry.page.h,
            (firstEntry.slotX + __lux_tmp_atlasW_382) / firstEntry.page.w,
            (firstEntry.slotY + __lux_tmp_atlasH_383) / firstEntry.page.h
          )
        end
      end
      __lux_module_1.renderSetMaterial(material)
      __lux_module_1.meshBegin(MATERIAL_TRIANGLES, #batch * 2)
      for _, record in ipairs(batch) do
        __lux_module_1.meshQuad(record)
      end
      __lux_module_1.meshEnd()
      do
        local __lux_tmp_stats_384 = stats
        if __lux_tmp_stats_384 == nil then
          __lux_tmp_stats_384 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_384, "textComposedBlits", #batch)
      end
      do
        local __lux_tmp_stats_385 = stats
        if __lux_tmp_stats_385 == nil then
          __lux_tmp_stats_385 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_385, "textComposedDraws", #batch)
      end
      if fx then
        do
          local __lux_tmp_stats_386 = stats
          if __lux_tmp_stats_386 == nil then
            __lux_tmp_stats_386 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_386, "textShaderDraws")
        end
        do
          local __lux_tmp_stats_387 = stats
          if __lux_tmp_stats_387 == nil then
            __lux_tmp_stats_387 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_387, "textComposedFxDraws", #batch)
        end
      else
        do
          local __lux_tmp_stats_388 = stats
          if __lux_tmp_stats_388 == nil then
            __lux_tmp_stats_388 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_388, "textComposedFaceDraws", #batch)
        end
      end
      do
        local __lux_tmp_stats_389 = stats
        if __lux_tmp_stats_389 == nil then
          __lux_tmp_stats_389 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_389, "textComposedBatchDraws")
      end
      do
        local __lux_tmp_stats_390 = stats
        if __lux_tmp_stats_390 == nil then
          __lux_tmp_stats_390 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_390, "textComposedBatchedRecords", #batch)
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
        local __lux_tmp_x_391 = record.x
        if __lux_tmp_x_391 == nil then
          __lux_tmp_x_391 = 0
        end
        contentX = __lux_tmp_x_391 - entry.contentW * __lux_module_1.alignFactor(record.alignX)
      end
      local contentY
      do
        local __lux_tmp_y_392 = record.y
        if __lux_tmp_y_392 == nil then
          __lux_tmp_y_392 = 0
        end
        contentY = __lux_tmp_y_392 - entry.contentH * __lux_module_1.alignFactor(record.alignY, true)
      end
      local x = contentX - entry.originX
      local y = contentY - entry.originY
      x, y = __lux_module_1.snapTextPos(x, y, record.style)
      local color
      do
        local __lux_tmp_color_393 = record.color
        if __lux_tmp_color_393 == nil then
          __lux_tmp_color_393 = __lux_module_1.white
        end
        color = __lux_module_1.style.asColor(__lux_module_1.fillForRecord(record), __lux_tmp_color_393)
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
          local __lux_tmp_stats_394 = stats
          if __lux_tmp_stats_394 == nil then
            __lux_tmp_stats_394 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_394, "textComposedEvicts")
        end
        __lux_module_1.clearComposedCache()
        do
          local __lux_tmp_records_395 = records
          if __lux_tmp_records_395 == nil then
            __lux_tmp_records_395 = {}
          end
          for _, record in ipairs(__lux_tmp_records_395) do
            record.__mgfxTextEntry = nil
          end
        end
      end
      __lux_module_1.bakesThisFrame = 0
      local composeRequested = __lux_module_1.prepareTextRoutes(records)
      do
        local __lux_tmp_stats_396 = stats
        if __lux_tmp_stats_396 == nil then
          __lux_tmp_stats_396 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_stats_396, "textComposedRequests", composeRequested)
      end
      if composeRequested > 0 then
        do
          local __lux_tmp_stats_397 = stats
          if __lux_tmp_stats_397 == nil then
            __lux_tmp_stats_397 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_stats_397, "textComposedBatches")
        end
      end
      local composerReady = composeRequested <= 0 or __lux_module_1.prewarmFlushRecords(records, stats)
      if composeRequested > 0 then
        if composerReady then
          do
            local __lux_tmp_stats_398 = stats
            if __lux_tmp_stats_398 == nil then
              __lux_tmp_stats_398 = {}
            end
            __lux_module_1.statAdd(__lux_tmp_stats_398, "textComposedReadyBatches")
          end
        end
      end
      local batches = {}
      local order = {}
      do
        local __lux_tmp_records_399 = records
        if __lux_tmp_records_399 == nil then
          __lux_tmp_records_399 = {}
        end
        for _, record in ipairs(__lux_tmp_records_399) do
          do
            local __lux_tmp_stats_400 = stats
            if __lux_tmp_stats_400 == nil then
              __lux_tmp_stats_400 = {}
            end
            __lux_module_1.statAdd(__lux_tmp_stats_400, "textDraws")
          end
          local route = record.__mgfxTextRoute
          if route == "native" then
            __lux_module_1.flushQueuedTextBatches(batches, order, stats)
            do
              local __lux_tmp_stats_401 = stats
              if __lux_tmp_stats_401 == nil then
                __lux_tmp_stats_401 = {}
              end
              __lux_module_1.statAdd(__lux_tmp_stats_401, "textNativeDraws")
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
      __lux_module_1.atlasNamespace = __lux_module_1.nextAtlasNamespace()
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
        local __lux_tmp_spec_402 = spec
        if __lux_tmp_spec_402 == nil then
          __lux_tmp_spec_402 = {}
        end
        return __lux_module_1.registerFont(fontName, __lux_tmp_spec_402)
      end
      renderer.DefineStyle = function(name, textStyle)
        if name == nil then
          return nil
        end
        local __lux_tmp_textStyle_403 = textStyle
        if __lux_tmp_textStyle_403 == nil then
          __lux_tmp_textStyle_403 = {}
        end
        return __lux_module_1.defineStyle(
          __lux_module_1.toString(name),
          renderer.ResolveStyle(__lux_tmp_textStyle_403)
        )
      end
      renderer.GetStyle = function(name)
        local __lux_tmp_name_404 = name
        if __lux_tmp_name_404 == nil then
          __lux_tmp_name_404 = ""
        end
        return __lux_module_1.getStyle(__lux_module_1.toString(__lux_tmp_name_404))
      end
      renderer.PushStyle = function(textStyle)
        do
          local __lux_tmp_textStyle_405 = textStyle
          if __lux_tmp_textStyle_405 == nil then
            __lux_tmp_textStyle_405 = {}
          end
          styleStack[#styleStack + 1] = renderer.ResolveStyle(__lux_tmp_textStyle_405)
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
          local __lux_tmp_textStyle_406 = textStyle
          if __lux_tmp_textStyle_406 == nil then
            __lux_tmp_textStyle_406 = {}
          end
          __lux_module_1.copyStyleInto(resolved, __lux_tmp_textStyle_406)
        end
        resolved[__lux_module_1.RESOLVED_STYLE_MARK] = true
        return resolved
      end
      renderer.MakeRecord = function(value, font, x, y, color, ax, ay, textStyle)
        local resolved
        do
          local __lux_tmp_textStyle_407 = textStyle
          if __lux_tmp_textStyle_407 == nil then
            __lux_tmp_textStyle_407 = {}
          end
          resolved = renderer.ResolveStyle(__lux_tmp_textStyle_407)
        end
        local __lux_tmp_value_408 = value
        if __lux_tmp_value_408 == nil then
          __lux_tmp_value_408 = ""
        end
        local __lux_tmp_font_409 = resolved.font
        if __lux_tmp_font_409 == nil then
          __lux_tmp_font_409 = font
        end
        if __lux_tmp_font_409 == nil then
          __lux_tmp_font_409 = "DermaDefault"
        end
        local __lux_tmp_x_410 = __lux_module_1.toNumber(x)
        if __lux_tmp_x_410 == nil then
          __lux_tmp_x_410 = 0
        end
        local __lux_tmp_y_411 = __lux_module_1.toNumber(y)
        if __lux_tmp_y_411 == nil then
          __lux_tmp_y_411 = 0
        end
        local __lux_tmp_412
        if __lux_module_1.style.asColor ~= nil then
          do
            local __lux_tmp_color_413 = color
            if __lux_tmp_color_413 == nil then
              __lux_tmp_color_413 = resolved.color
            end
            if __lux_tmp_color_413 == nil then
              __lux_tmp_color_413 = resolved.fill
            end
            __lux_tmp_412 = __lux_module_1.style.asColor(__lux_tmp_color_413, __lux_module_1.white)
          end
        else
          do
            local __lux_tmp_color_414 = color
            if __lux_tmp_color_414 == nil then
              __lux_tmp_color_414 = resolved.color
            end
            if __lux_tmp_color_414 == nil then
              __lux_tmp_color_414 = resolved.fill
            end
            __lux_tmp_412 = __lux_module_1.style.colorOr(__lux_tmp_color_414, __lux_module_1.white)
          end
        end
        local __lux_tmp_alignX_415 = resolved.alignX
        if __lux_tmp_alignX_415 == nil then
          __lux_tmp_alignX_415 = resolved.align
        end
        if __lux_tmp_alignX_415 == nil then
          __lux_tmp_alignX_415 = ax
        end
        if __lux_tmp_alignX_415 == nil then
          __lux_tmp_alignX_415 = TEXT_ALIGN_LEFT
        end
        local __lux_tmp_alignY_416 = resolved.alignY
        if __lux_tmp_alignY_416 == nil then
          __lux_tmp_alignY_416 = resolved.valign
        end
        if __lux_tmp_alignY_416 == nil then
          __lux_tmp_alignY_416 = ay
        end
        if __lux_tmp_alignY_416 == nil then
          __lux_tmp_alignY_416 = TEXT_ALIGN_TOP
        end
        return {
          text = __lux_module_1.toString(__lux_tmp_value_408),
          font = __lux_tmp_font_409,
          x = __lux_tmp_x_410,
          y = __lux_tmp_y_411,
          color = __lux_tmp_412,
          alignX = __lux_tmp_alignX_415,
          alignY = __lux_tmp_alignY_416,
          style = resolved,
        }
      end
      renderer.NormalizeRecord = function(record)
        if record == nil then
          return nil
        end
        local resolved
        do
          local __lux_tmp_style_417 = record.style
          if __lux_tmp_style_417 == nil then
            __lux_tmp_style_417 = {}
          end
          resolved = renderer.ResolveStyle(__lux_tmp_style_417)
        end
        do
          local __lux_tmp_text_418 = record.text
          if __lux_tmp_text_418 == nil then
            __lux_tmp_text_418 = record.value
          end
          if __lux_tmp_text_418 == nil then
            __lux_tmp_text_418 = ""
          end
          record.text = __lux_module_1.toString(__lux_tmp_text_418)
        end
        do
          local __lux_tmp_font_419 = resolved.font
          if __lux_tmp_font_419 == nil then
            __lux_tmp_font_419 = record.font
          end
          if __lux_tmp_font_419 == nil then
            __lux_tmp_font_419 = "DermaDefault"
          end
          record.font = __lux_tmp_font_419
        end
        do
          local __lux_tmp_x_420 = __lux_module_1.toNumber(record.x)
          if __lux_tmp_x_420 == nil then
            __lux_tmp_x_420 = 0
          end
          record.x = __lux_tmp_x_420
        end
        do
          local __lux_tmp_y_421 = __lux_module_1.toNumber(record.y)
          if __lux_tmp_y_421 == nil then
            __lux_tmp_y_421 = 0
          end
          record.y = __lux_tmp_y_421
        end
        do
          local __lux_tmp_422
          if __lux_module_1.style.asColor ~= nil then
            do
              local __lux_tmp_color_423 = record.color
              if __lux_tmp_color_423 == nil then
                __lux_tmp_color_423 = resolved.color
              end
              if __lux_tmp_color_423 == nil then
                __lux_tmp_color_423 = resolved.fill
              end
              __lux_tmp_422 = __lux_module_1.style.asColor(__lux_tmp_color_423, __lux_module_1.white)
            end
          else
            do
              local __lux_tmp_color_424 = record.color
              if __lux_tmp_color_424 == nil then
                __lux_tmp_color_424 = resolved.color
              end
              if __lux_tmp_color_424 == nil then
                __lux_tmp_color_424 = resolved.fill
              end
              __lux_tmp_422 = __lux_module_1.style.colorOr(__lux_tmp_color_424, __lux_module_1.white)
            end
          end
          record.color = __lux_tmp_422
        end
        do
          local __lux_tmp_alignX_425 = resolved.alignX
          if __lux_tmp_alignX_425 == nil then
            __lux_tmp_alignX_425 = resolved.align
          end
          if __lux_tmp_alignX_425 == nil then
            __lux_tmp_alignX_425 = record.alignX
          end
          if __lux_tmp_alignX_425 == nil then
            __lux_tmp_alignX_425 = record.ax
          end
          if __lux_tmp_alignX_425 == nil then
            __lux_tmp_alignX_425 = TEXT_ALIGN_LEFT
          end
          record.alignX = __lux_tmp_alignX_425
        end
        do
          local __lux_tmp_alignY_426 = resolved.alignY
          if __lux_tmp_alignY_426 == nil then
            __lux_tmp_alignY_426 = resolved.valign
          end
          if __lux_tmp_alignY_426 == nil then
            __lux_tmp_alignY_426 = record.alignY
          end
          if __lux_tmp_alignY_426 == nil then
            __lux_tmp_alignY_426 = record.ay
          end
          if __lux_tmp_alignY_426 == nil then
            __lux_tmp_alignY_426 = TEXT_ALIGN_TOP
          end
          record.alignY = __lux_tmp_alignY_426
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
          local __lux_tmp_textStyle_427 = textStyle
          if __lux_tmp_textStyle_427 == nil then
            __lux_tmp_textStyle_427 = {}
          end
          resolved = renderer.ResolveStyle(__lux_tmp_textStyle_427)
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
          local __lux_tmp_w_428 = __lux_module_1.toNumber(w)
          if __lux_tmp_w_428 == nil then
            __lux_tmp_w_428 = 0
          end
          lines = __lux_module_1.wrapText(value, resolvedFont, __lux_tmp_w_428, resolved.overflow)
        end
        local nativeFont, alias, oversample = __lux_module_1.nativeFor(resolvedFont, resolved)
        local lineHeight = __lux_module_1.lineHeightFor(nativeFont, alias, resolved, oversample)
        local totalH = #lines * lineHeight
        local startY
        do
          local __lux_tmp_y_429 = __lux_module_1.toNumber(y)
          if __lux_tmp_y_429 == nil then
            __lux_tmp_y_429 = 0
          end
          local __lux_tmp_h_430 = __lux_module_1.toNumber(h)
          if __lux_tmp_h_430 == nil then
            __lux_tmp_h_430 = totalH
          end
          local __lux_tmp_alignY_431 = resolved.alignY
          if __lux_tmp_alignY_431 == nil then
            __lux_tmp_alignY_431 = resolved.valign
          end
          if __lux_tmp_alignY_431 == nil then
            __lux_tmp_alignY_431 = TEXT_ALIGN_TOP
          end
          startY = __lux_tmp_y_429 + (__lux_tmp_h_430 - totalH) * __lux_module_1.alignFactor(__lux_tmp_alignY_431, true)
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
          local __lux_tmp_x_432 = __lux_module_1.toNumber(x)
          if __lux_tmp_x_432 == nil then
            __lux_tmp_x_432 = 0
          end
          local __lux_tmp_w_433 = __lux_module_1.toNumber(w)
          if __lux_tmp_w_433 == nil then
            __lux_tmp_w_433 = 0
          end
          tx = __lux_tmp_x_432 + __lux_tmp_w_433 * __lux_module_1.alignFactor(ax)
        end
        local lineStyle = __lux_module_1.textBoxLineStyle(resolved)
        for index = 1, #lines do
          do
            local __lux_tmp_color_434 = lineStyle.color
            if __lux_tmp_color_434 == nil then
              __lux_tmp_color_434 = lineStyle.fill
            end
            renderer.DrawTextImmediate(
              lines[index],
              resolvedFont,
              tx,
              startY + (index - 1) * lineHeight,
              __lux_tmp_color_434,
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
        local __lux_tmp_textStyle_435 = textStyle
        if __lux_tmp_textStyle_435 == nil then
          __lux_tmp_textStyle_435 = {}
        end
        return __lux_module_1.measureBox(
          value,
          font,
          w,
          renderer.ResolveStyle(__lux_tmp_textStyle_435)
        )
      end
      renderer.PrewarmText = function(value, font, textStyle)
        local record
        do
          local __lux_tmp_textStyle_436 = textStyle
          if __lux_tmp_textStyle_436 == nil then
            __lux_tmp_textStyle_436 = {}
          end
          record = renderer.MakeRecord(
            value,
            font,
            0,
            0,
            nil,
            TEXT_ALIGN_LEFT,
            TEXT_ALIGN_TOP,
            __lux_tmp_textStyle_436
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
          local __lux_tmp_textStyle_437 = textStyle
          if __lux_tmp_textStyle_437 == nil then
            __lux_tmp_textStyle_437 = {}
          end
          record = renderer.MakeRecord(
            value,
            font,
            0,
            0,
            nil,
            TEXT_ALIGN_LEFT,
            TEXT_ALIGN_TOP,
            __lux_tmp_textStyle_437
          )
        end
        local nativeFont, alias, oversample = __lux_module_1.nativeFor(record.font, record.style)
        local layout = __lux_module_1.layoutFor(record.text, record.font, record.style)
        local needsComposed = __lux_module_1.recordNeedsComposedEntry(record)
        local __lux_tmp_438
        if needsComposed then
          __lux_tmp_438 = "__composed"
        else
          __lux_tmp_438 = "__native"
        end
        local __lux_tmp_439
        if needsComposed then
          __lux_tmp_439 = "composed"
        else
          __lux_tmp_439 = "native"
        end
        local __lux_tmp_440
        if needsComposed then
          __lux_tmp_440 = "__composed"
        else
          __lux_tmp_440 = "__native"
        end
        local __lux_tmp_441
        if needsComposed then
          __lux_tmp_441 = "compose"
        else
          __lux_tmp_441 = "native"
        end
        local __lux_tmp_mode_442 = alias.mode
        if __lux_tmp_mode_442 == nil then
          __lux_tmp_mode_442 = "native"
        end
        return {
          text = record.text,
          font = record.font,
          nativeFont = nativeFont,
          atlasKey = __lux_tmp_438,
          kind = __lux_tmp_439,
          routeAtlas = __lux_tmp_440,
          routeKind = __lux_tmp_441,
          mode = __lux_tmp_mode_442,
          missing = {},
          w = layout.w,
          h = layout.h,
          oversample = oversample,
        }
      end
      renderer.Status = function()
        local __lux_obj_atlas_443 = __lux_module_1.atlas
        local __lux_val_rt_444 = nil
        if __lux_obj_atlas_443 ~= nil then
          __lux_val_rt_444 = __lux_obj_atlas_443.rt
        end
        local __lux_obj_atlas_445 = __lux_module_1.atlas
        local __lux_tmp_w_446 = nil
        if __lux_obj_atlas_445 ~= nil then
          __lux_tmp_w_446 = __lux_obj_atlas_445.w
        end
        if __lux_tmp_w_446 == nil then
          __lux_tmp_w_446 = 0
        end
        local __lux_obj_atlas_447 = __lux_module_1.atlas
        local __lux_tmp_h_448 = nil
        if __lux_obj_atlas_447 ~= nil then
          __lux_tmp_h_448 = __lux_obj_atlas_447.h
        end
        if __lux_tmp_h_448 == nil then
          __lux_tmp_h_448 = 0
        end
        local __lux_tmp_textDraws_449 = stats.textDraws
        if __lux_tmp_textDraws_449 == nil then
          __lux_tmp_textDraws_449 = 0
        end
        local __lux_tmp_textNativeDraws_450 = stats.textNativeDraws
        if __lux_tmp_textNativeDraws_450 == nil then
          __lux_tmp_textNativeDraws_450 = 0
        end
        local __lux_tmp_textShaderDraws_451 = stats.textShaderDraws
        if __lux_tmp_textShaderDraws_451 == nil then
          __lux_tmp_textShaderDraws_451 = 0
        end
        local __lux_tmp_textComposedDraws_452 = stats.textComposedDraws
        if __lux_tmp_textComposedDraws_452 == nil then
          __lux_tmp_textComposedDraws_452 = 0
        end
        local __lux_tmp_textComposedBakes_453 = stats.textComposedBakes
        if __lux_tmp_textComposedBakes_453 == nil then
          __lux_tmp_textComposedBakes_453 = 0
        end
        local __lux_tmp_textComposedBlits_454 = stats.textComposedBlits
        if __lux_tmp_textComposedBlits_454 == nil then
          __lux_tmp_textComposedBlits_454 = 0
        end
        local __lux_tmp_textMeasureHits_455 = stats.textMeasureHits
        if __lux_tmp_textMeasureHits_455 == nil then
          __lux_tmp_textMeasureHits_455 = 0
        end
        local __lux_tmp_textMeasureMisses_456 = stats.textMeasureMisses
        if __lux_tmp_textMeasureMisses_456 == nil then
          __lux_tmp_textMeasureMisses_456 = 0
        end
        return {
          mode = "native+composer",
          fontCount = __lux_module_1.countTable(__lux_module_1.fonts),
          styleCount = __lux_module_1.countTable(__lux_module_1.styles),
          styleStackDepth = #styleStack,
          cacheSize = __lux_module_1.measureOrderCount,
          composedEnabled = __lux_module_1.textComposedEnabled(),
          composedAtlas = __lux_val_rt_444,
          composedAtlasW = __lux_tmp_w_446,
          composedAtlasH = __lux_tmp_h_448,
          composedAtlasPages = #__lux_module_1.atlasPages,
          composedAtlasMaxPages = __lux_module_1.MAX_ATLAS_PAGES,
          composedAtlasFill = __lux_module_1.atlasFillRatio(),
          composedEntries = __lux_module_1.composedCacheCount,
          composedFailed = __lux_module_1.atlasFailed,
          draws = __lux_tmp_textDraws_449,
          nativeDraws = __lux_tmp_textNativeDraws_450,
          shaderDraws = __lux_tmp_textShaderDraws_451,
          composedDraws = __lux_tmp_textComposedDraws_452,
          composedBakes = __lux_tmp_textComposedBakes_453,
          composedBlits = __lux_tmp_textComposedBlits_454,
          measureHits = __lux_tmp_textMeasureHits_455,
          measureMisses = __lux_tmp_textMeasureMisses_456,
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
        local __lux_tmp_stats_457 = owner.stats
        if __lux_tmp_stats_457 == nil then
          __lux_tmp_stats_457 = {}
        end
        owner.stats = __lux_tmp_stats_457
      end
      local materialState = owner._MaterialState
      if materialState == nil then
        materialState = {}
      end
      local renderer
      do
        local __lux_tmp_Materials_458 = owner._Materials
        if __lux_tmp_Materials_458 == nil then
          __lux_tmp_Materials_458 = materialState.materials
        end
        if __lux_tmp_Materials_458 == nil then
          __lux_tmp_Materials_458 = {}
        end
        local __lux_tmp_MaterialOK_459 = owner.MaterialOK
        if __lux_tmp_MaterialOK_459 == nil then
          __lux_tmp_MaterialOK_459 = materialState.matOK
        end
        renderer = __lux_module_1.createTextRenderer(
          {
            M = owner,
            owner = owner,
            stats = owner.stats,
            materials = __lux_tmp_Materials_458,
            createPageTextMaterials = materialState.CreatePageTextMaterials,
            matOK = __lux_tmp_MaterialOK_459,
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
