return function(__lux_import)
  local __lux_exports = {}
  local __lux_module_1 = {}
  do
    local __lux_import_2 = __lux_import("lux/mgfx/style#client")
    local styleImport = __lux_import_2
    __lux_module_1.style = styleImport
    do
      local __lux_obj_3 = bit
      local __lux_val_4 = nil
      if __lux_obj_3 ~= nil then
        __lux_val_4 = __lux_obj_3.bor
      end
      __lux_module_1.bitBor = __lux_val_4
    end
    do
      local __lux_obj_5 = cam
      local __lux_val_6 = nil
      if __lux_obj_5 ~= nil then
        __lux_val_6 = __lux_obj_5.Start2D
      end
      __lux_module_1.camStart2D = __lux_val_6
    end
    do
      local __lux_obj_7 = cam
      local __lux_val_8 = nil
      if __lux_obj_7 ~= nil then
        __lux_val_8 = __lux_obj_7.End2D
      end
      __lux_module_1.camEnd2D = __lux_val_8
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
      local __lux_obj_9 = mesh
      local __lux_val_10 = nil
      if __lux_obj_9 ~= nil then
        __lux_val_10 = __lux_obj_9.Begin
      end
      __lux_module_1.meshBegin = __lux_val_10
    end
    do
      local __lux_obj_11 = mesh
      local __lux_val_12 = nil
      if __lux_obj_11 ~= nil then
        __lux_val_12 = __lux_obj_11.Color
      end
      __lux_module_1.meshColor = __lux_val_12
    end
    do
      local __lux_obj_13 = mesh
      local __lux_val_14 = nil
      if __lux_obj_13 ~= nil then
        __lux_val_14 = __lux_obj_13.End
      end
      __lux_module_1.meshEnd = __lux_val_14
    end
    do
      local __lux_obj_15 = mesh
      local __lux_val_16 = nil
      if __lux_obj_15 ~= nil then
        __lux_val_16 = __lux_obj_15.Position
      end
      __lux_module_1.meshPosition = __lux_val_16
    end
    do
      local __lux_obj_17 = mesh
      local __lux_val_18 = nil
      if __lux_obj_17 ~= nil then
        __lux_val_18 = __lux_obj_17.TexCoord
      end
      __lux_module_1.meshTexCoord = __lux_val_18
    end
    do
      local __lux_obj_19 = mesh
      local __lux_val_20 = nil
      if __lux_obj_19 ~= nil then
        __lux_val_20 = __lux_obj_19.AdvanceVertex
      end
      __lux_module_1.meshAdvanceVertex = __lux_val_20
    end
    do
      local __lux_obj_21 = render
      local __lux_val_22 = nil
      if __lux_obj_21 ~= nil then
        __lux_val_22 = __lux_obj_21.Clear
      end
      __lux_module_1.renderClear = __lux_val_22
    end
    do
      local __lux_obj_23 = render
      local __lux_val_24 = nil
      if __lux_obj_23 ~= nil then
        __lux_val_24 = __lux_obj_23.GetBlend
      end
      __lux_module_1.renderGetBlend = __lux_val_24
    end
    do
      local __lux_obj_25 = render
      local __lux_val_26 = nil
      if __lux_obj_25 ~= nil then
        __lux_val_26 = __lux_obj_25.GetColorModulation
      end
      __lux_module_1.renderGetColorModulation = __lux_val_26
    end
    do
      local __lux_obj_27 = render
      local __lux_val_28 = nil
      if __lux_obj_27 ~= nil then
        __lux_val_28 = __lux_obj_27.OverrideAlphaWriteEnable
      end
      __lux_module_1.renderOverrideAlphaWriteEnable = __lux_val_28
    end
    do
      local __lux_obj_29 = render
      local __lux_val_30 = nil
      if __lux_obj_29 ~= nil then
        __lux_val_30 = __lux_obj_29.OverrideBlend
      end
      __lux_module_1.renderOverrideBlend = __lux_val_30
    end
    do
      local __lux_obj_31 = render
      local __lux_val_32 = nil
      if __lux_obj_31 ~= nil then
        __lux_val_32 = __lux_obj_31.PopRenderTarget
      end
      __lux_module_1.renderPopRenderTarget = __lux_val_32
    end
    do
      local __lux_obj_33 = render
      local __lux_val_34 = nil
      if __lux_obj_33 ~= nil then
        __lux_val_34 = __lux_obj_33.PushRenderTarget
      end
      __lux_module_1.renderPushRenderTarget = __lux_val_34
    end
    do
      local __lux_obj_35 = render
      local __lux_val_36 = nil
      if __lux_obj_35 ~= nil then
        __lux_val_36 = __lux_obj_35.SetBlend
      end
      __lux_module_1.renderSetBlend = __lux_val_36
    end
    do
      local __lux_obj_37 = render
      local __lux_val_38 = nil
      if __lux_obj_37 ~= nil then
        __lux_val_38 = __lux_obj_37.SetColorModulation
      end
      __lux_module_1.renderSetColorModulation = __lux_val_38
    end
    do
      local __lux_obj_39 = render
      local __lux_val_40 = nil
      if __lux_obj_39 ~= nil then
        __lux_val_40 = __lux_obj_39.SetMaterial
      end
      __lux_module_1.renderSetMaterial = __lux_val_40
    end
    do
      local __lux_obj_41 = render
      local __lux_val_42 = nil
      if __lux_obj_41 ~= nil then
        __lux_val_42 = __lux_obj_41.SetScissorRect
      end
      __lux_module_1.renderSetScissorRect = __lux_val_42
    end
    __lux_module_1.surfaceCreateFont = surface.CreateFont
    do
      local __lux_obj_43 = surface
      local __lux_val_44 = nil
      if __lux_obj_43 ~= nil then
        __lux_val_44 = __lux_obj_43.DrawOutlinedRect
      end
      __lux_module_1.surfaceDrawOutlinedRect = __lux_val_44
    end
    __lux_module_1.surfaceDrawRect = surface.DrawRect
    __lux_module_1.surfaceDrawText = surface.DrawText
    do
      local __lux_obj_45 = surface
      local __lux_val_46 = nil
      if __lux_obj_45 ~= nil then
        __lux_val_46 = __lux_obj_45.DrawTexturedRectUV
      end
      __lux_module_1.surfaceDrawTexturedRectUV = __lux_val_46
    end
    do
      local __lux_obj_47 = surface
      local __lux_val_48 = nil
      if __lux_obj_47 ~= nil then
        __lux_val_48 = __lux_obj_47.DrawTexturedRect
      end
      __lux_module_1.surfaceDrawTexturedRect = __lux_val_48
    end
    do
      local __lux_obj_49 = surface
      local __lux_val_50 = nil
      if __lux_obj_49 ~= nil then
        __lux_val_50 = __lux_obj_49.GetAlphaMultiplier
      end
      __lux_module_1.surfaceGetAlphaMultiplier = __lux_val_50
    end
    __lux_module_1.surfaceSetDrawColor = surface.SetDrawColor
    __lux_module_1.surfaceSetFont = surface.SetFont
    __lux_module_1.surfaceSetMaterial = surface.SetMaterial
    __lux_module_1.surfaceSetTextColor = surface.SetTextColor
    __lux_module_1.surfaceSetTextPos = surface.SetTextPos
    do
      local __lux_obj_51 = surface
      local __lux_val_52 = nil
      if __lux_obj_51 ~= nil then
        __lux_val_52 = __lux_obj_51.SetAlphaMultiplier
      end
      __lux_module_1.surfaceSetAlphaMultiplier = __lux_val_52
    end
    __lux_module_1.surfaceGetTextSize = surface.GetTextSize
    __lux_module_1.sysTime = SysTime
    do
      local __lux_obj_53 = util
      local __lux_val_54 = nil
      if __lux_obj_53 ~= nil then
        __lux_val_54 = __lux_obj_53.CRC
      end
      __lux_module_1.utilCRC = __lux_val_54
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
      local __lux_tmp_55 = material ~= nil
      if __lux_tmp_55 then
        __lux_tmp_55 = material.IsError ~= nil
      end
      local __lux_tmp_56 = __lux_tmp_55
      if __lux_tmp_56 then
        __lux_tmp_56 = not material:IsError()
      end
      return __lux_tmp_56
    end
    __lux_module_1.defaultTextRenderer = nil
    __lux_module_1.atlasNamespace = nil
    do
      local __lux_tmp_57
      if __lux_module_1.matrixCtor ~= nil then
        __lux_tmp_57 = __lux_module_1.matrixCtor()
      else
        __lux_tmp_57 = nil
      end
      __lux_module_1.textParamMatrixProbe = __lux_tmp_57
    end
    do
      local __lux_obj_58 = __lux_module_1.textParamMatrixProbe
      local __lux_val_59 = nil
      if __lux_obj_58 ~= nil then
        __lux_val_59 = __lux_obj_58.SetUnpacked
      end
      __lux_module_1.textParamMatrixSetUnpacked = __lux_val_59
    end
    __lux_module_1.textParamMatrices = {}
    __lux_module_1.textAuxParamMatrices = {}
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
      local __lux_tmp_60 = color_white
      if __lux_tmp_60 == nil then
        __lux_tmp_60 = __lux_module_1.makeColor(255, 255, 255, 255)
      end
      __lux_module_1.white = __lux_tmp_60
    end
    do
      local __lux_tmp_61
      if __lux_module_1.vectorCtor ~= nil then
        __lux_tmp_61 = __lux_module_1.vectorCtor()
      else
        __lux_tmp_61 = nil
      end
      __lux_module_1.textBatchVertex = __lux_tmp_61
    end
    __lux_module_1.profile = { active = false, draws = 0, measures = 0, times = {}, counts = {} }
    __lux_module_1.nextAtlasNamespace = function()
      local root = _G
      local serial
      do
        local __lux_tmp_62 = __lux_module_1.toNumber(root.__MGFXTextAtlasSerial)
        if __lux_tmp_62 == nil then
          __lux_tmp_62 = 0
        end
        serial = __lux_tmp_62 + 1
      end
      root.__MGFXTextAtlasSerial = serial
      return "MGFXTextComposeAtlas_" .. __lux_module_1.toString(serial)
    end
    __lux_module_1.textComposerCapable = function()
      local __lux_tmp_63 = __lux_module_1.renderClear ~= nil
      if __lux_tmp_63 then
        __lux_tmp_63 = __lux_module_1.renderPushRenderTarget ~= nil
      end
      local __lux_tmp_64 = __lux_tmp_63
      if __lux_tmp_64 then
        __lux_tmp_64 = __lux_module_1.renderPopRenderTarget ~= nil
      end
      local __lux_tmp_65 = __lux_tmp_64
      if __lux_tmp_65 then
        __lux_tmp_65 = __lux_module_1.camStart2D ~= nil
      end
      local __lux_tmp_66 = __lux_tmp_65
      if __lux_tmp_66 then
        __lux_tmp_66 = __lux_module_1.camEnd2D ~= nil
      end
      return __lux_tmp_66
    end
    __lux_module_1.setupTextParamMatrix = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3)
      local __lux_tmp_67 = material == nil
      if not __lux_tmp_67 then
        __lux_tmp_67 = __lux_module_1.matrixCtor == nil
      end
      local __lux_tmp_68 = __lux_tmp_67
      if not __lux_tmp_68 then
        __lux_tmp_68 = __lux_module_1.textParamMatrixSetUnpacked == nil
      end
      if __lux_tmp_68 then
        __lux_module_1.errorFn("MGFX text compose atlas rect matrix unavailable", 2)
      end
      local matrix = __lux_module_1.textParamMatrices[material]
      if matrix == nil then
        matrix = __lux_module_1.matrixCtor()
        __lux_module_1.textParamMatrices[material] = matrix
      end
      do
        local __lux_tmp_69 = a0
        if __lux_tmp_69 == nil then
          __lux_tmp_69 = 0
        end
        local __lux_tmp_70 = b0
        if __lux_tmp_70 == nil then
          __lux_tmp_70 = 0
        end
        local __lux_tmp_71 = c0
        if __lux_tmp_71 == nil then
          __lux_tmp_71 = 0
        end
        local __lux_tmp_72 = d0
        if __lux_tmp_72 == nil then
          __lux_tmp_72 = 0
        end
        local __lux_tmp_73 = a1
        if __lux_tmp_73 == nil then
          __lux_tmp_73 = 0
        end
        local __lux_tmp_74 = b1
        if __lux_tmp_74 == nil then
          __lux_tmp_74 = 0
        end
        local __lux_tmp_75 = c1
        if __lux_tmp_75 == nil then
          __lux_tmp_75 = 0
        end
        local __lux_tmp_76 = d1
        if __lux_tmp_76 == nil then
          __lux_tmp_76 = 0
        end
        local __lux_tmp_77 = a2
        if __lux_tmp_77 == nil then
          __lux_tmp_77 = 0
        end
        local __lux_tmp_78 = b2
        if __lux_tmp_78 == nil then
          __lux_tmp_78 = 0
        end
        local __lux_tmp_79 = c2
        if __lux_tmp_79 == nil then
          __lux_tmp_79 = 0
        end
        local __lux_tmp_80 = d2
        if __lux_tmp_80 == nil then
          __lux_tmp_80 = 0
        end
        local __lux_tmp_81 = a3
        if __lux_tmp_81 == nil then
          __lux_tmp_81 = 0
        end
        local __lux_tmp_82 = b3
        if __lux_tmp_82 == nil then
          __lux_tmp_82 = 0
        end
        local __lux_tmp_83 = c3
        if __lux_tmp_83 == nil then
          __lux_tmp_83 = 0
        end
        local __lux_tmp_84 = d3
        if __lux_tmp_84 == nil then
          __lux_tmp_84 = 0
        end
        __lux_module_1.textParamMatrixSetUnpacked(
          matrix,
          __lux_tmp_69,
          __lux_tmp_70,
          __lux_tmp_71,
          __lux_tmp_72,
          __lux_tmp_73,
          __lux_tmp_74,
          __lux_tmp_75,
          __lux_tmp_76,
          __lux_tmp_77,
          __lux_tmp_78,
          __lux_tmp_79,
          __lux_tmp_80,
          __lux_tmp_81,
          __lux_tmp_82,
          __lux_tmp_83,
          __lux_tmp_84
        )
      end
      material:SetMatrix("$viewprojmat", matrix)
      return true
    end
    __lux_module_1.setupTextAuxParamMatrix = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3)
      local __lux_tmp_85 = material == nil
      if not __lux_tmp_85 then
        __lux_tmp_85 = __lux_module_1.matrixCtor == nil
      end
      local __lux_tmp_86 = __lux_tmp_85
      if not __lux_tmp_86 then
        __lux_tmp_86 = __lux_module_1.textParamMatrixSetUnpacked == nil
      end
      if __lux_tmp_86 then
        __lux_module_1.errorFn("MGFX text compose auxiliary matrix unavailable", 2)
      end
      local matrix = __lux_module_1.textAuxParamMatrices[material]
      if matrix == nil then
        matrix = __lux_module_1.matrixCtor()
        __lux_module_1.textAuxParamMatrices[material] = matrix
      end
      do
        local __lux_tmp_87 = a0
        if __lux_tmp_87 == nil then
          __lux_tmp_87 = 0
        end
        local __lux_tmp_88 = b0
        if __lux_tmp_88 == nil then
          __lux_tmp_88 = 0
        end
        local __lux_tmp_89 = c0
        if __lux_tmp_89 == nil then
          __lux_tmp_89 = 0
        end
        local __lux_tmp_90 = d0
        if __lux_tmp_90 == nil then
          __lux_tmp_90 = 0
        end
        local __lux_tmp_91 = a1
        if __lux_tmp_91 == nil then
          __lux_tmp_91 = 0
        end
        local __lux_tmp_92 = b1
        if __lux_tmp_92 == nil then
          __lux_tmp_92 = 0
        end
        local __lux_tmp_93 = c1
        if __lux_tmp_93 == nil then
          __lux_tmp_93 = 0
        end
        local __lux_tmp_94 = d1
        if __lux_tmp_94 == nil then
          __lux_tmp_94 = 0
        end
        local __lux_tmp_95 = a2
        if __lux_tmp_95 == nil then
          __lux_tmp_95 = 0
        end
        local __lux_tmp_96 = b2
        if __lux_tmp_96 == nil then
          __lux_tmp_96 = 0
        end
        local __lux_tmp_97 = c2
        if __lux_tmp_97 == nil then
          __lux_tmp_97 = 0
        end
        local __lux_tmp_98 = d2
        if __lux_tmp_98 == nil then
          __lux_tmp_98 = 0
        end
        local __lux_tmp_99 = a3
        if __lux_tmp_99 == nil then
          __lux_tmp_99 = 0
        end
        local __lux_tmp_100 = b3
        if __lux_tmp_100 == nil then
          __lux_tmp_100 = 0
        end
        local __lux_tmp_101 = c3
        if __lux_tmp_101 == nil then
          __lux_tmp_101 = 0
        end
        local __lux_tmp_102 = d3
        if __lux_tmp_102 == nil then
          __lux_tmp_102 = 0
        end
        __lux_module_1.textParamMatrixSetUnpacked(
          matrix,
          __lux_tmp_87,
          __lux_tmp_88,
          __lux_tmp_89,
          __lux_tmp_90,
          __lux_tmp_91,
          __lux_tmp_92,
          __lux_tmp_93,
          __lux_tmp_94,
          __lux_tmp_95,
          __lux_tmp_96,
          __lux_tmp_97,
          __lux_tmp_98,
          __lux_tmp_99,
          __lux_tmp_100,
          __lux_tmp_101,
          __lux_tmp_102
        )
      end
      material:SetMatrix("$invviewprojmat", matrix)
      return true
    end
    __lux_module_1.configureTextRenderer = function(deps)
      do
        local __lux_tmp_103 = deps
        if __lux_tmp_103 == nil then
          __lux_tmp_103 = {}
        end
        deps = __lux_tmp_103
      end
      do
        local __lux_tmp_104 = deps.materials
        if __lux_tmp_104 == nil then
          local __lux_tmp_105 = deps.Materials
          if __lux_tmp_105 == nil then
            local __lux_tmp_106 = __lux_module_1.materials
            if __lux_tmp_106 == nil then
              __lux_tmp_106 = {}
            end
            __lux_tmp_105 = __lux_tmp_106
          end
          __lux_tmp_104 = __lux_tmp_105
        end
        __lux_module_1.materials = __lux_tmp_104
      end
      do
        local __lux_tmp_107 = deps.createPageTextMaterials
        if __lux_tmp_107 == nil then
          local __lux_tmp_108 = deps.CreatePageTextMaterials
          if __lux_tmp_108 == nil then
            __lux_tmp_108 = __lux_module_1.createPageTextMaterials
          end
          __lux_tmp_107 = __lux_tmp_108
        end
        __lux_module_1.createPageTextMaterials = __lux_tmp_107
      end
      do
        local __lux_tmp_109 = deps.profiler
        if __lux_tmp_109 == nil then
          local __lux_tmp_110 = deps.Profiler
          if __lux_tmp_110 == nil then
            __lux_tmp_110 = __lux_module_1.profiler
          end
          __lux_tmp_109 = __lux_tmp_110
        end
        __lux_module_1.profiler = __lux_tmp_109
      end
      do
        local __lux_tmp_111 = deps.restoreScissor
        if __lux_tmp_111 == nil then
          local __lux_tmp_112 = deps.RestoreScissor
          if __lux_tmp_112 == nil then
            local __lux_tmp_113 = __lux_module_1.restoreScissor
            if __lux_tmp_113 == nil then
              __lux_tmp_113 = function()
        end
            end
            __lux_tmp_112 = __lux_tmp_113
          end
          __lux_tmp_111 = __lux_tmp_112
        end
        __lux_module_1.restoreScissor = __lux_tmp_111
      end
      do
        local __lux_tmp_114 = deps.gradientLutForFill
        if __lux_tmp_114 == nil then
          local __lux_tmp_115 = deps.GradientLutForFill
          if __lux_tmp_115 == nil then
            local __lux_tmp_116 = __lux_module_1.gradientLutForFill
            if __lux_tmp_116 == nil then
              __lux_tmp_116 = function()
          return nil
        end
            end
            __lux_tmp_115 = __lux_tmp_116
          end
          __lux_tmp_114 = __lux_tmp_115
        end
        __lux_module_1.gradientLutForFill = __lux_tmp_114
      end
      do
        local __lux_tmp_117 = deps.matOK
        if __lux_tmp_117 == nil then
          local __lux_tmp_118 = deps.MaterialOK
          if __lux_tmp_118 == nil then
            __lux_tmp_118 = __lux_module_1.materialOK
          end
          __lux_tmp_117 = __lux_tmp_118
        end
        __lux_module_1.materialOK = __lux_tmp_117
      end
      return true
    end
    __lux_module_1.sharedTextRenderer = function()
      if __lux_module_1.defaultTextRenderer ~= nil then
        return __lux_module_1.defaultTextRenderer
      end
      local factory
      do
        local __lux_obj_119 = _G.MGFX
        local __lux_val_120 = nil
        if __lux_obj_119 ~= nil then
          __lux_val_120 = __lux_obj_119._CreateTextRenderer
        end
        factory = __lux_val_120
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
      local __lux_tmp_121 = __lux_module_1.materialOK ~= nil
      if __lux_tmp_121 then
        __lux_tmp_121 = __lux_module_1.materialOK(material)
      end
      return __lux_tmp_121
    end
    __lux_module_1.textChars = function(text)
      local out = {}
      local value
      do
        local __lux_tmp_122 = text
        if __lux_tmp_122 == nil then
          __lux_tmp_122 = ""
        end
        value = __lux_module_1.toString(__lux_tmp_122)
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
      local __lux_tmp_123 = #out == 0
      if __lux_tmp_123 then
        __lux_tmp_123 = value ~= ""
      end
      if __lux_tmp_123 then
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
        local __lux_tmp_124 = t
        if __lux_tmp_124 == nil then
          __lux_tmp_124 = {}
        end
        for key, _ in pairs(__lux_tmp_124) do
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
        local __lux_tmp_125 = key ~= "extends"
        if __lux_tmp_125 then
          __lux_tmp_125 = key ~= "base"
        end
        local __lux_tmp_126 = __lux_tmp_125
        if __lux_tmp_126 then
          local __lux_tmp_127 = __lux_module_1.typeOf(key) == "string"
          if __lux_tmp_127 then
            __lux_tmp_127 = __lux_module_1.stringSub(key, 1, 6) == "__mgfx"
          end
          __lux_tmp_126 = not __lux_tmp_127
        end
        if __lux_tmp_126 then
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
        local __lux_tmp_128 = fallback
        if __lux_tmp_128 == nil then
          __lux_tmp_128 = 500
        end
        return __lux_tmp_128
      end
      local __lux_tmp_129 = weight > 0
      if __lux_tmp_129 then
        __lux_tmp_129 = weight <= 10
      end
      if __lux_tmp_129 then
        do
          local __lux_tmp_130
          if weight <= 1 then
            __lux_tmp_130 = 850
          else
            __lux_tmp_130 = weight * 100
          end
          weight = __lux_tmp_130
        end
      end
      return __lux_module_1.mathClamp(__lux_module_1.mathFloor(weight + 0.5), 100, 1000)
    end
    __lux_module_1.normalizeOversample = function(value)
      local nextValue
      do
        local __lux_tmp_131 = __lux_module_1.toNumber(value)
        if __lux_tmp_131 == nil then
          __lux_tmp_131 = 1
        end
        nextValue = __lux_tmp_131
      end
      return __lux_module_1.mathClamp(nextValue, 1, 4)
    end
    __lux_module_1.oversampleForSize = function(size)
      local nextSize
      do
        local __lux_tmp_132 = __lux_module_1.toNumber(size)
        if __lux_tmp_132 == nil then
          __lux_tmp_132 = 16
        end
        nextSize = __lux_tmp_132
      end
      if nextSize >= 28 then
        return 3
      end
      return 2
    end
    __lux_module_1.fontKey = function(face, size, weight, italic)
      local __lux_tmp_133 = face
      if __lux_tmp_133 == nil then
        __lux_tmp_133 = ""
      end
      local __lux_tmp_134 = size
      if __lux_tmp_134 == nil then
        __lux_tmp_134 = ""
      end
      local __lux_tmp_135 = weight
      if __lux_tmp_135 == nil then
        __lux_tmp_135 = ""
      end
      local __lux_tmp_136
      if italic == true then
        __lux_tmp_136 = "i"
      else
        __lux_tmp_136 = "n"
      end
      return __lux_module_1.tableConcat(
        {
          __lux_module_1.toString(__lux_tmp_133),
          __lux_module_1.toString(__lux_tmp_134),
          __lux_module_1.toString(__lux_tmp_135),
          __lux_tmp_136,
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
          local __lux_tmp_137 = face
          if __lux_tmp_137 == nil then
            __lux_tmp_137 = "DermaDefault"
          end
          local __lux_tmp_138 = size
          if __lux_tmp_138 == nil then
            __lux_tmp_138 = 16
          end
          __lux_module_1.surfaceCreateFont(
            name,
            {
              font = __lux_tmp_137,
              size = __lux_module_1.mathFloor(__lux_tmp_138),
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
      local input
      do
        local __lux_tmp_139 = spec
        if __lux_tmp_139 == nil then
          __lux_tmp_139 = {}
        end
        input = __lux_tmp_139
      end
      local face
      do
        local __lux_tmp_140 = input.face
        if __lux_tmp_140 == nil then
          __lux_tmp_140 = input.font
        end
        face = __lux_tmp_140
      end
      local size = __lux_module_1.toNumber(input.size)
      local weight = __lux_module_1.toNumber(input.weight)
      local sourceFont
      do
        local __lux_tmp_141 = input.sourceFont
        if __lux_tmp_141 == nil then
          __lux_tmp_141 = input.nativeFont
        end
        sourceFont = __lux_tmp_141
      end
      local oversample = 1
      if face ~= nil then
        do
          local __lux_tmp_142 = size
          if __lux_tmp_142 == nil then
            __lux_tmp_142 = 16
          end
          size = __lux_tmp_142
        end
        do
          local __lux_tmp_143 = input.oversample
          if __lux_tmp_143 == nil then
            __lux_tmp_143 = __lux_module_1.oversampleForSize(size)
          end
          oversample = __lux_module_1.normalizeOversample(__lux_tmp_143)
        end
        do
          local __lux_tmp_144
          if face == __lux_module_1.DEFAULT_CJK_FACE then
            __lux_tmp_144 = 400
          else
            __lux_tmp_144 = 500
          end
          weight = __lux_module_1.normalizeFontWeight(weight, __lux_tmp_144)
        end
        sourceFont = __lux_module_1.ensureNativeFont(face, size * oversample, weight, input.italic == true)
      else
        do
          local __lux_tmp_145 = sourceFont
          if __lux_tmp_145 == nil then
            __lux_tmp_145 = name
          end
          sourceFont = __lux_tmp_145
        end
      end
      do
        local __lux_tmp_146
        if face ~= nil then
          __lux_tmp_146 = "alias"
        else
          __lux_tmp_146 = "native"
        end
        local __lux_tmp_147 = input.syntheticWeight == true
        if not __lux_tmp_147 then
          __lux_tmp_147 = input.allowSyntheticWeight == true
        end
        local __lux_tmp_148 = input.lineHeight
        if __lux_tmp_148 == nil then
          __lux_tmp_148 = input.lineheight
        end
        local __lux_tmp_149 = input.tracking
        if __lux_tmp_149 == nil then
          __lux_tmp_149 = input.letterSpacing
        end
        local __lux_tmp_150 = __lux_module_1.toNumber(__lux_tmp_149)
        if __lux_tmp_150 == nil then
          __lux_tmp_150 = 0
        end
        local __lux_tmp_151
        if face ~= nil then
          __lux_tmp_151 = "__composed"
        else
          __lux_tmp_151 = "__native"
        end
        __lux_module_1.fonts[name] = {
          mode = __lux_tmp_146,
          sourceFont = sourceFont,
          face = face,
          size = size,
          weight = weight,
          oversample = oversample,
          syntheticWeight = __lux_tmp_147,
          lineHeight = __lux_module_1.toNumber(__lux_tmp_148),
          tracking = __lux_tmp_150,
          atlas = __lux_tmp_151,
        }
      end
      return true
    end
    __lux_module_1.aliasFor = function(font)
      local key
      do
        local __lux_tmp_152 = font
        if __lux_tmp_152 == nil then
          __lux_tmp_152 = ""
        end
        key = __lux_module_1.toString(__lux_tmp_152)
      end
      local alias = __lux_module_1.fonts[key]
      if alias ~= nil then
        return alias
      end
      local __lux_tmp_153 = font
      if __lux_tmp_153 == nil then
        __lux_tmp_153 = "DermaDefault"
      end
      return {
        mode = "native",
        sourceFont = __lux_tmp_153,
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
        local __lux_tmp_154 = noOversample
        if not __lux_tmp_154 then
          local __lux_obj_155 = textStyle
          local __lux_val_156 = nil
          if __lux_obj_155 ~= nil then
            __lux_val_156 = __lux_obj_155.__mgfxNoOversample
          end
          __lux_tmp_154 = __lux_val_156
        end
        if __lux_tmp_154 then
          oversample = 1
        else
          oversample = __lux_module_1.normalizeOversample(alias.oversample)
        end
      end
      if alias.face ~= nil then
        local weight
        do
          local __lux_tmp_157 = alias.weight
          if __lux_tmp_157 == nil then
            __lux_tmp_157 = 500
          end
          weight = __lux_tmp_157
        end
        local __lux_obj_158 = textStyle
        local __lux_val_159 = nil
        if __lux_obj_158 ~= nil then
          __lux_val_159 = __lux_obj_158.syntheticNativeWeight
        end
        if __lux_val_159 == true then
          local __lux_tmp_160 = plainFace ~= true
          if __lux_tmp_160 then
            local __lux_obj_161 = textStyle
            local __lux_val_162 = nil
            if __lux_obj_161 ~= nil then
              __lux_val_162 = __lux_obj_161.bold
            end
            __lux_tmp_160 = __lux_val_162 == true
          end
          if __lux_tmp_160 then
            weight = weight + 220
          end
          local __lux_tmp_163 = plainFace ~= true
          if __lux_tmp_163 then
            local __lux_obj_164 = textStyle
            local __lux_val_165 = nil
            if __lux_obj_164 ~= nil then
              __lux_val_165 = __lux_obj_164.thin
            end
            __lux_tmp_163 = __lux_val_165 == true
          end
          if __lux_tmp_163 then
            weight = __lux_module_1.mathMin(weight, 350)
          end
          local __lux_obj_166 = textStyle
          local __lux_val_167 = nil
          if __lux_obj_166 ~= nil then
            __lux_val_167 = __lux_obj_166.weight
          end
          if __lux_module_1.toNumber(__lux_val_167) ~= nil then
            weight = __lux_module_1.normalizeFontWeight(textStyle.weight, weight)
          end
        end
        local __lux_tmp_168 = alias.size
        if __lux_tmp_168 == nil then
          __lux_tmp_168 = 16
        end
        local __lux_obj_169 = textStyle
        local __lux_val_170 = nil
        if __lux_obj_169 ~= nil then
          __lux_val_170 = __lux_obj_169.italic
        end
        return __lux_module_1.ensureNativeFont(
          alias.face,
          __lux_tmp_168 * oversample,
          weight,
          __lux_val_170 == true
        ), alias, oversample
      end
      local __lux_tmp_171 = alias.sourceFont
      if __lux_tmp_171 == nil then
        local __lux_tmp_172 = font
        if __lux_tmp_172 == nil then
          __lux_tmp_172 = "DermaDefault"
        end
        __lux_tmp_171 = __lux_tmp_172
      end
      return __lux_tmp_171, alias, 1
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
        local __lux_tmp_173 = textStyle
        if __lux_tmp_173 == nil then
          __lux_tmp_173 = {}
        end
        __lux_module_1.styles[__lux_module_1.toString(name)] = __lux_module_1.resolveStyle(__lux_tmp_173)
      end
      return __lux_module_1.styles[__lux_module_1.toString(name)]
    end
    __lux_module_1.getStyle = function(name)
      local __lux_tmp_174 = name
      if __lux_tmp_174 == nil then
        __lux_tmp_174 = ""
      end
      return __lux_module_1.styles[__lux_module_1.toString(__lux_tmp_174)]
    end
    __lux_module_1.resolveStyle = function(textStyle)
      if __lux_module_1.typeOf(textStyle) == "string" then
        local __lux_tmp_175 = __lux_module_1.styles[__lux_module_1.toString(textStyle)]
        if __lux_tmp_175 == nil then
          __lux_tmp_175 = {}
        end
        return __lux_module_1.copyValue(__lux_tmp_175)
      end
      if __lux_module_1.typeOf(textStyle) ~= "table" then
        return {}
      end
      if textStyle[__lux_module_1.RESOLVED_STYLE_MARK] == true then
        return __lux_module_1.copyValue(textStyle)
      end
      local out = {}
      local base
      do
        local __lux_tmp_176 = textStyle.extends
        if __lux_tmp_176 == nil then
          __lux_tmp_176 = textStyle.base
        end
        base = __lux_tmp_176
      end
      if base ~= nil then
        local __lux_tmp_177 = __lux_module_1.typeOf(base) == "table"
        if __lux_tmp_177 then
          __lux_tmp_177 = base[1] ~= nil
        end
        local __lux_tmp_178 = __lux_tmp_177
        if __lux_tmp_178 then
          __lux_tmp_178 = not __lux_module_1.style.isColor(base)
        end
        if __lux_tmp_178 then
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
        local target
        do
          local __lux_tmp_179 = font
          if __lux_tmp_179 == nil then
            __lux_tmp_179 = "DermaDefault"
          end
          target = __lux_tmp_179
        end
        local __lux_tmp_180 = __lux_module_1.protectedCall == nil
        if not __lux_tmp_180 then
          __lux_tmp_180 = __lux_module_1.protectedCall(__lux_module_1.surfaceSetFont, target)
        end
        if __lux_tmp_180 then
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
        local __lux_obj_181 = textStyle
        local __lux_val_182 = nil
        if __lux_obj_181 ~= nil then
          __lux_val_182 = __lux_obj_181.lineHeight
        end
        local __lux_tmp_183 = __lux_val_182
        if __lux_tmp_183 == nil then
          local __lux_obj_184 = textStyle
          local __lux_val_185 = nil
          if __lux_obj_184 ~= nil then
            __lux_val_185 = __lux_obj_184.lineheight
          end
          local __lux_tmp_186 = __lux_val_185
          if __lux_tmp_186 == nil then
            local __lux_obj_187 = alias
            local __lux_val_188 = nil
            if __lux_obj_187 ~= nil then
              __lux_val_188 = __lux_obj_187.lineHeight
            end
            __lux_tmp_186 = __lux_val_188
          end
          __lux_tmp_183 = __lux_tmp_186
        end
        declared = __lux_module_1.toNumber(__lux_tmp_183)
      end
      if declared ~= nil then
        return declared
      end
      __lux_module_1.setFontSafe(nativeFont)
      local _, h = __lux_module_1.surfaceGetTextSize("Mg")
      local __lux_tmp_189 = h
      if __lux_tmp_189 == nil then
        __lux_tmp_189 = 16
      end
      return __lux_module_1.mathMax(
        1,
        __lux_tmp_189 / __lux_module_1.normalizeOversample(oversample)
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
        local __lux_tmp_190 = text
        if __lux_tmp_190 == nil then
          __lux_tmp_190 = ""
        end
        raw = __lux_module_1.toString(__lux_tmp_190)
      end
      local w, h = __lux_module_1.surfaceGetTextSize(raw)
      local extra
      do
        local __lux_tmp_191 = __lux_module_1.toNumber(tracking)
        if __lux_tmp_191 == nil then
          __lux_tmp_191 = 0
        end
        extra = __lux_tmp_191
      end
      local __lux_tmp_192 = extra ~= 0
      if __lux_tmp_192 then
        __lux_tmp_192 = #raw > 1
      end
      if __lux_tmp_192 then
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
        local __lux_tmp_193 = textStyle
        if __lux_tmp_193 == nil then
          __lux_tmp_193 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_193)
      end
      local nativeFont, alias, oversample = __lux_module_1.nativeFor(font, resolved, noOversample, plainFace)
      local tracking
      do
        local __lux_tmp_194 = resolved.tracking
        if __lux_tmp_194 == nil then
          __lux_tmp_194 = resolved.letterSpacing
        end
        local __lux_tmp_195 = __lux_module_1.toNumber(__lux_tmp_194)
        if __lux_tmp_195 == nil then
          local __lux_tmp_196 = alias.tracking
          if __lux_tmp_196 == nil then
            __lux_tmp_196 = 0
          end
          __lux_tmp_195 = __lux_tmp_196
        end
        tracking = __lux_tmp_195
      end
      local lineHeight = __lux_module_1.lineHeightFor(nativeFont, alias, resolved, oversample)
      local lines
      do
        local __lux_tmp_197 = value
        if __lux_tmp_197 == nil then
          __lux_tmp_197 = ""
        end
        lines = __lux_module_1.stringExplode("\n", __lux_module_1.toString(__lux_tmp_197), false)
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
      local tracking
      do
        local __lux_tmp_198 = alias.tracking
        if __lux_tmp_198 == nil then
          __lux_tmp_198 = 0
        end
        tracking = __lux_tmp_198
      end
      local key
      do
        local __lux_tmp_199 = font
        if __lux_tmp_199 == nil then
          __lux_tmp_199 = ""
        end
        local __lux_tmp_200 = value
        if __lux_tmp_200 == nil then
          __lux_tmp_200 = ""
        end
        key = __lux_module_1.tableConcat(
          {
            __lux_module_1.toString(__lux_tmp_199),
            nativeFont,
            __lux_module_1.toString(tracking),
            __lux_module_1.toString(oversample),
            __lux_module_1.toString(__lux_tmp_200),
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
        local __lux_tmp_201 = value
        if __lux_tmp_201 == nil then
          __lux_tmp_201 = ""
        end
        text = __lux_module_1.toString(__lux_tmp_201)
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
        local __lux_tmp_202 = value
        if __lux_tmp_202 == nil then
          __lux_tmp_202 = ""
        end
        text = __lux_module_1.toString(__lux_tmp_202)
      end
      local width
      do
        local __lux_tmp_203 = __lux_module_1.toNumber(maxW)
        if __lux_tmp_203 == nil then
          __lux_tmp_203 = 0
        end
        width = __lux_tmp_203
      end
      if width <= 0 then
        return __lux_module_1.stringExplode("\n", text, false)
      end
      local __lux_tmp_204 = overflow == "ellipsis"
      if not __lux_tmp_204 then
        __lux_tmp_204 = overflow == "truncate"
      end
      if __lux_tmp_204 then
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
          local __lux_tmp_205 = nextW > width
          if __lux_tmp_205 then
            __lux_tmp_205 = line ~= ""
          end
          if __lux_tmp_205 then
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
        local __lux_tmp_206 = textStyle
        if __lux_tmp_206 == nil then
          __lux_tmp_206 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_206)
      end
      local lines
      do
        local __lux_tmp_207 = font
        if __lux_tmp_207 == nil then
          local __lux_tmp_208 = resolved.font
          if __lux_tmp_208 == nil then
            __lux_tmp_208 = "DermaDefault"
          end
          __lux_tmp_207 = __lux_tmp_208
        end
        local __lux_tmp_209 = __lux_module_1.toNumber(w)
        if __lux_tmp_209 == nil then
          __lux_tmp_209 = 0
        end
        lines = __lux_module_1.wrapText(value, __lux_tmp_207, __lux_tmp_209, resolved.overflow)
      end
      local maxW = 0
      for index = 1, #lines do
        local lw
        do
          local __lux_tmp_210 = font
          if __lux_tmp_210 == nil then
            local __lux_tmp_211 = resolved.font
            if __lux_tmp_211 == nil then
              __lux_tmp_211 = "DermaDefault"
            end
            __lux_tmp_210 = __lux_tmp_211
          end
          lw = __lux_module_1.measure(lines[index], __lux_tmp_210)
        end
        maxW = __lux_module_1.mathMax(maxW, lw)
      end
      local nativeFont, alias, oversample
      do
        local __lux_tmp_212 = font
        if __lux_tmp_212 == nil then
          local __lux_tmp_213 = resolved.font
          if __lux_tmp_213 == nil then
            __lux_tmp_213 = "DermaDefault"
          end
          __lux_tmp_212 = __lux_tmp_213
        end
        nativeFont, alias, oversample = __lux_module_1.nativeFor(__lux_tmp_212, resolved)
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
      local __lux_match_214 = value
      if __lux_match_214 == "center" or __lux_match_214 == "middle" then
        return 0.5
      elseif __lux_match_214 == "right" or __lux_match_214 == "bottom" then
        return 1
      else
        local __lux_tmp_215 = value == TEXT_ALIGN_CENTER
        if not __lux_tmp_215 then
          local __lux_tmp_216 = vertical
          if __lux_tmp_216 then
            __lux_tmp_216 = value == TEXT_ALIGN_CENTER
          end
          __lux_tmp_215 = __lux_tmp_216
        end
        if __lux_tmp_215 then
          return 0.5
        end
        do
          local __lux_tmp_217 = value == TEXT_ALIGN_RIGHT
          if not __lux_tmp_217 then
            __lux_tmp_217 = value == TEXT_ALIGN_BOTTOM
          end
          if __lux_tmp_217 then
            return 1
          else
            return 0
          end
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
      local __lux_tmp_218 = fill.colorA
      if __lux_tmp_218 == nil then
        local __lux_tmp_219 = fill.color
        if __lux_tmp_219 == nil then
          __lux_tmp_219 = fill.fill
        end
        __lux_tmp_218 = __lux_tmp_219
      end
      return __lux_module_1.style.colorOr(__lux_tmp_218, __lux_module_1.white)
    end
    __lux_module_1.setTextColor = function(color)
      local c = __lux_module_1.style.colorOr(color, __lux_module_1.white)
      if __lux_module_1.surfaceSetTextColor ~= nil then
        do
          local __lux_tmp_220 = c.r
          if __lux_tmp_220 == nil then
            __lux_tmp_220 = 255
          end
          local __lux_tmp_221 = c.g
          if __lux_tmp_221 == nil then
            __lux_tmp_221 = 255
          end
          local __lux_tmp_222 = c.b
          if __lux_tmp_222 == nil then
            __lux_tmp_222 = 255
          end
          local __lux_tmp_223 = c.a
          if __lux_tmp_223 == nil then
            __lux_tmp_223 = 255
          end
          __lux_module_1.surfaceSetTextColor(
            __lux_tmp_220,
            __lux_tmp_221,
            __lux_tmp_222,
            __lux_tmp_223
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
        local __lux_tmp_224 = text
        if __lux_tmp_224 == nil then
          __lux_tmp_224 = ""
        end
        raw = __lux_module_1.toString(__lux_tmp_224)
      end
      local extra
      do
        local __lux_tmp_225 = __lux_module_1.toNumber(tracking)
        if __lux_tmp_225 == nil then
          __lux_tmp_225 = 0
        end
        extra = __lux_tmp_225
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
          local __lux_tmp_226 = cw
          if __lux_tmp_226 == nil then
            __lux_tmp_226 = 0
          end
          cursor = cursor + __lux_tmp_226 + extra * __lux_module_1.normalizeOversample(oversample)
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
          local __lux_tmp_227 = fill
          if __lux_tmp_227 == nil then
            __lux_tmp_227 = fallbackColor
          end
          __lux_module_1.drawLineText(
            layout.font,
            line.text,
            x,
            y + line.y * oversample,
            __lux_module_1.colorAtFill(__lux_tmp_227, t),
            layout.tracking,
            oversample
          )
        end
      end
    end
    __lux_module_1.normalizeShadow = function(value)
      local __lux_tmp_228 = value == nil
      if not __lux_tmp_228 then
        __lux_tmp_228 = value == false
      end
      if __lux_tmp_228 then
        return nil
      end
      if value == true then
        value = {}
      end
      if __lux_module_1.typeOf(value) ~= "table" then
        do
          local __lux_tmp_229 = __lux_module_1.toNumber(value)
          if __lux_tmp_229 == nil then
            __lux_tmp_229 = 0
          end
          value = { blur = __lux_tmp_229 }
        end
      end
      local __lux_tmp_230 = value.x
      if __lux_tmp_230 == nil then
        local __lux_tmp_231 = value.offsetX
        if __lux_tmp_231 == nil then
          __lux_tmp_231 = value[1]
        end
        __lux_tmp_230 = __lux_tmp_231
      end
      local __lux_tmp_232 = __lux_module_1.toNumber(__lux_tmp_230)
      if __lux_tmp_232 == nil then
        __lux_tmp_232 = 1
      end
      local __lux_tmp_233 = value.y
      if __lux_tmp_233 == nil then
        local __lux_tmp_234 = value.offsetY
        if __lux_tmp_234 == nil then
          __lux_tmp_234 = value[2]
        end
        __lux_tmp_233 = __lux_tmp_234
      end
      local __lux_tmp_235 = __lux_module_1.toNumber(__lux_tmp_233)
      if __lux_tmp_235 == nil then
        __lux_tmp_235 = 1
      end
      local __lux_tmp_236 = value.blur
      if __lux_tmp_236 == nil then
        local __lux_tmp_237 = value.radius
        if __lux_tmp_237 == nil then
          __lux_tmp_237 = value[3]
        end
        __lux_tmp_236 = __lux_tmp_237
      end
      local __lux_tmp_238 = __lux_module_1.toNumber(__lux_tmp_236)
      if __lux_tmp_238 == nil then
        __lux_tmp_238 = 0
      end
      local __lux_tmp_239 = value.strength
      if __lux_tmp_239 == nil then
        __lux_tmp_239 = value.opacity
      end
      local __lux_tmp_240 = __lux_module_1.toNumber(__lux_tmp_239)
      if __lux_tmp_240 == nil then
        __lux_tmp_240 = 1
      end
      local __lux_tmp_241 = value.color
      if __lux_tmp_241 == nil then
        __lux_tmp_241 = value.tint
      end
      return {
        x = __lux_tmp_232,
        y = __lux_tmp_235,
        blur = __lux_tmp_238,
        strength = __lux_tmp_240,
        color = __lux_module_1.style.colorOr(__lux_tmp_241, __lux_module_1.makeColor(0, 0, 0, 180)),
      }
    end
    __lux_module_1.normalizeStroke = function(value)
      local __lux_tmp_242 = value == nil
      if not __lux_tmp_242 then
        __lux_tmp_242 = value == false
      end
      if __lux_tmp_242 then
        return nil
      end
      if value == true then
        value = {}
      end
      if __lux_module_1.typeOf(value) ~= "table" then
        do
          local __lux_tmp_243 = __lux_module_1.toNumber(value)
          if __lux_tmp_243 == nil then
            __lux_tmp_243 = 1
          end
          value = { width = __lux_tmp_243 }
        end
      end
      local width
      do
        local __lux_tmp_244 = value.width
        if __lux_tmp_244 == nil then
          local __lux_tmp_245 = value.size
          if __lux_tmp_245 == nil then
            __lux_tmp_245 = value[1]
          end
          __lux_tmp_244 = __lux_tmp_245
        end
        local __lux_tmp_246 = __lux_module_1.toNumber(__lux_tmp_244)
        if __lux_tmp_246 == nil then
          __lux_tmp_246 = 1
        end
        width = __lux_module_1.mathMax(0, __lux_tmp_246)
      end
      if width <= 0 then
        return nil
      end
      local __lux_tmp_247 = __lux_module_1.toNumber(value.softness)
      if __lux_tmp_247 == nil then
        __lux_tmp_247 = 0
      end
      local __lux_tmp_248 = value.color
      if __lux_tmp_248 == nil then
        __lux_tmp_248 = value.tint
      end
      return {
        width = width,
        samples = __lux_module_1.mathClamp(__lux_module_1.mathCeil(width * 6), 8, 32),
        softness = __lux_tmp_247,
        color = __lux_module_1.style.colorOr(__lux_tmp_248, __lux_module_1.makeColor(0, 0, 0, 220)),
      }
    end
    __lux_module_1.normalizeGlow = function(value)
      local __lux_tmp_249 = value == nil
      if not __lux_tmp_249 then
        __lux_tmp_249 = value == false
      end
      if __lux_tmp_249 then
        return nil
      end
      if value == true then
        value = {}
      end
      if __lux_module_1.typeOf(value) ~= "table" then
        do
          local __lux_tmp_250 = __lux_module_1.toNumber(value)
          if __lux_tmp_250 == nil then
            __lux_tmp_250 = 6
          end
          value = { width = __lux_tmp_250 }
        end
      end
      local width
      do
        local __lux_tmp_251 = value.width
        if __lux_tmp_251 == nil then
          local __lux_tmp_252 = value.size
          if __lux_tmp_252 == nil then
            local __lux_tmp_253 = value.radius
            if __lux_tmp_253 == nil then
              __lux_tmp_253 = value[1]
            end
            __lux_tmp_252 = __lux_tmp_253
          end
          __lux_tmp_251 = __lux_tmp_252
        end
        local __lux_tmp_254 = __lux_module_1.toNumber(__lux_tmp_251)
        if __lux_tmp_254 == nil then
          __lux_tmp_254 = 6
        end
        width = __lux_module_1.mathMax(0, __lux_tmp_254)
      end
      if width <= 0 then
        return nil
      end
      local __lux_tmp_255 = value.strength
      if __lux_tmp_255 == nil then
        __lux_tmp_255 = value.opacity
      end
      local __lux_tmp_256 = __lux_module_1.toNumber(__lux_tmp_255)
      if __lux_tmp_256 == nil then
        __lux_tmp_256 = 0.45
      end
      local __lux_tmp_257 = __lux_module_1.toNumber(value.falloff)
      if __lux_tmp_257 == nil then
        __lux_tmp_257 = __lux_module_1.style.glowSoftnessToFalloff(value.softness, 0.58)
      end
      local __lux_tmp_258 = value.color
      if __lux_tmp_258 == nil then
        __lux_tmp_258 = value.tint
      end
      return {
        width = width,
        samples = __lux_module_1.mathClamp(__lux_module_1.mathCeil(width * 2), 8, 36),
        strength = __lux_tmp_256,
        falloff = __lux_tmp_257,
        color = __lux_module_1.style.colorOr(
          __lux_tmp_258,
          __lux_module_1.makeColor(255, 255, 255, 120)
        ),
      }
    end
    __lux_module_1.scaledColor = function(input, scale)
      local color = __lux_module_1.style.colorOr(input, __lux_module_1.white)
      local __lux_tmp_259 = color.r
      if __lux_tmp_259 == nil then
        __lux_tmp_259 = 255
      end
      local __lux_tmp_260 = color.g
      if __lux_tmp_260 == nil then
        __lux_tmp_260 = 255
      end
      local __lux_tmp_261 = color.b
      if __lux_tmp_261 == nil then
        __lux_tmp_261 = 255
      end
      local __lux_tmp_262 = color.a
      if __lux_tmp_262 == nil then
        __lux_tmp_262 = 255
      end
      local __lux_tmp_263 = scale
      if __lux_tmp_263 == nil then
        __lux_tmp_263 = 1
      end
      return __lux_module_1.makeColor(
        __lux_tmp_259,
        __lux_tmp_260,
        __lux_tmp_261,
        __lux_module_1.mathClamp(
          __lux_module_1.mathFloor(__lux_tmp_262 * __lux_tmp_263),
          0,
          255
        )
      )
    end
    __lux_module_1.snapTextPos = function(x, y, textStyle)
      local __lux_obj_264 = textStyle
      local __lux_val_265 = nil
      if __lux_obj_264 ~= nil then
        __lux_val_265 = __lux_obj_264.pixelSnap
      end
      if __lux_val_265 == false then
        return x, y
      end
      local __lux_tmp_266 = x
      if __lux_tmp_266 == nil then
        __lux_tmp_266 = 0
      end
      local __lux_tmp_267 = y
      if __lux_tmp_267 == nil then
        __lux_tmp_267 = 0
      end
      return __lux_module_1.mathFloor(__lux_tmp_266 + 0.5), __lux_module_1.mathFloor(__lux_tmp_267 + 0.5)
    end
    __lux_module_1.drawNativeFallbackRecord = function(record)
      local textStyle
      do
        local __lux_tmp_268 = record.style
        if __lux_tmp_268 == nil then
          __lux_tmp_268 = {}
        end
        textStyle = __lux_tmp_268
      end
      local layout = __lux_module_1.layoutFor(record.text, record.font, textStyle, true)
      local x
      do
        local __lux_tmp_269 = record.x
        if __lux_tmp_269 == nil then
          __lux_tmp_269 = 0
        end
        x = __lux_tmp_269 - layout.w * __lux_module_1.alignFactor(record.alignX)
      end
      local y
      do
        local __lux_tmp_270 = record.y
        if __lux_tmp_270 == nil then
          __lux_tmp_270 = 0
        end
        y = __lux_tmp_270 - layout.h * __lux_module_1.alignFactor(record.alignY, true)
      end
      x, y = __lux_module_1.snapTextPos(x, y, textStyle)
      local fill
      do
        local __lux_tmp_271 = textStyle.fill
        if __lux_tmp_271 == nil then
          local __lux_tmp_272 = textStyle.color
          if __lux_tmp_272 == nil then
            local __lux_tmp_273 = record.color
            if __lux_tmp_273 == nil then
              __lux_tmp_273 = __lux_module_1.white
            end
            __lux_tmp_272 = __lux_tmp_273
          end
          __lux_tmp_271 = __lux_tmp_272
        end
        fill = __lux_tmp_271
      end
      local shadow = __lux_module_1.normalizeShadow(textStyle.shadow)
      local stroke
      do
        local __lux_tmp_274 = textStyle.stroke
        if __lux_tmp_274 == nil then
          __lux_tmp_274 = textStyle.outline
        end
        stroke = __lux_module_1.normalizeStroke(__lux_tmp_274)
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
        local __lux_tmp_275 = record.color
        if __lux_tmp_275 == nil then
          __lux_tmp_275 = __lux_module_1.white
        end
        __lux_module_1.drawLayout(layout, x, y, fill, __lux_tmp_275)
      end
      return record
    end
    __lux_module_1.drawNativePlainRecord = function(record)
      local textStyle
      do
        local __lux_tmp_276 = record.style
        if __lux_tmp_276 == nil then
          __lux_tmp_276 = {}
        end
        textStyle = __lux_tmp_276
      end
      local fill
      do
        local __lux_tmp_277 = textStyle.fill
        if __lux_tmp_277 == nil then
          local __lux_tmp_278 = textStyle.color
          if __lux_tmp_278 == nil then
            local __lux_tmp_279 = record.color
            if __lux_tmp_279 == nil then
              __lux_tmp_279 = __lux_module_1.white
            end
            __lux_tmp_278 = __lux_tmp_279
          end
          __lux_tmp_277 = __lux_tmp_278
        end
        fill = __lux_tmp_277
      end
      if __lux_module_1.fillNeedsShader(fill) then
        do
          local __lux_tmp_280 = record.color
          if __lux_tmp_280 == nil then
            __lux_tmp_280 = __lux_module_1.white
          end
          fill = __lux_tmp_280
        end
      end
      local nativeFont, alias = __lux_module_1.nativeFor(record.font, textStyle, true, true)
      local tracking
      do
        local __lux_tmp_281 = textStyle.tracking
        if __lux_tmp_281 == nil then
          __lux_tmp_281 = textStyle.letterSpacing
        end
        local __lux_tmp_282 = __lux_module_1.toNumber(__lux_tmp_281)
        if __lux_tmp_282 == nil then
          local __lux_tmp_283 = alias.tracking
          if __lux_tmp_283 == nil then
            __lux_tmp_283 = 0
          end
          __lux_tmp_282 = __lux_tmp_283
        end
        tracking = __lux_tmp_282
      end
      local raw
      do
        local __lux_tmp_284 = record.text
        if __lux_tmp_284 == nil then
          __lux_tmp_284 = ""
        end
        raw = __lux_module_1.toString(__lux_tmp_284)
      end
      local __lux_tmp_285 = tracking == 0
      if __lux_tmp_285 then
        __lux_tmp_285 = __lux_module_1.stringFind(raw, "\n", 1, true) == nil
      end
      local __lux_tmp_286 = __lux_tmp_285
      if __lux_tmp_286 then
        __lux_tmp_286 = textStyle.lineHeight == nil
      end
      local __lux_tmp_287 = __lux_tmp_286
      if __lux_tmp_287 then
        __lux_tmp_287 = alias.lineHeight == nil
      end
      local __lux_tmp_288 = __lux_tmp_287
      if __lux_tmp_288 then
        __lux_tmp_288 = not __lux_module_1.fillNeedsShader(fill)
      end
      local __lux_tmp_289 = __lux_tmp_288
      if __lux_tmp_289 then
        __lux_tmp_289 = __lux_module_1.drawSimpleText ~= nil
      end
      if __lux_tmp_289 then
        local x, y
        do
          local __lux_tmp_290 = record.x
          if __lux_tmp_290 == nil then
            __lux_tmp_290 = 0
          end
          local __lux_tmp_291 = record.y
          if __lux_tmp_291 == nil then
            __lux_tmp_291 = 0
          end
          x, y = __lux_module_1.snapTextPos(__lux_tmp_290, __lux_tmp_291, textStyle)
        end
        do
          local __lux_tmp_292 = record.color
          if __lux_tmp_292 == nil then
            __lux_tmp_292 = __lux_module_1.white
          end
          local __lux_tmp_293 = record.alignX
          if __lux_tmp_293 == nil then
            __lux_tmp_293 = TEXT_ALIGN_LEFT
          end
          local __lux_tmp_294 = record.alignY
          if __lux_tmp_294 == nil then
            __lux_tmp_294 = TEXT_ALIGN_TOP
          end
          __lux_module_1.drawSimpleText(
            raw,
            __lux_module_1.setFontSafe(nativeFont),
            x,
            y,
            __lux_module_1.style.colorOr(fill, __lux_tmp_292),
            __lux_tmp_293,
            __lux_tmp_294
          )
        end
        return record
      end
      local layout = __lux_module_1.layoutFor(raw, record.font, textStyle, true, true)
      local x
      do
        local __lux_tmp_295 = record.x
        if __lux_tmp_295 == nil then
          __lux_tmp_295 = 0
        end
        x = __lux_tmp_295 - layout.w * __lux_module_1.alignFactor(record.alignX)
      end
      local y
      do
        local __lux_tmp_296 = record.y
        if __lux_tmp_296 == nil then
          __lux_tmp_296 = 0
        end
        y = __lux_tmp_296 - layout.h * __lux_module_1.alignFactor(record.alignY, true)
      end
      x, y = __lux_module_1.snapTextPos(x, y, textStyle)
      do
        local __lux_tmp_297 = record.color
        if __lux_tmp_297 == nil then
          __lux_tmp_297 = __lux_module_1.white
        end
        __lux_module_1.drawLayout(layout, x, y, fill, __lux_tmp_297)
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
      local __lux_obj_298 = renderer
      local __lux_val_299 = nil
      if __lux_obj_298 ~= nil then
        __lux_val_299 = __lux_obj_298.DrawTextImmediate
      end
      if __lux_val_299 ~= nil then
        return renderer.DrawTextImmediate(value, font, x, y, color, ax, ay, textStyle)
      end
      local resolved
      do
        local __lux_tmp_300 = textStyle
        if __lux_tmp_300 == nil then
          __lux_tmp_300 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_300)
      end
      local record
      do
        local __lux_tmp_301 = value
        if __lux_tmp_301 == nil then
          __lux_tmp_301 = ""
        end
        local __lux_tmp_302 = resolved.font
        if __lux_tmp_302 == nil then
          local __lux_tmp_303 = font
          if __lux_tmp_303 == nil then
            __lux_tmp_303 = "DermaDefault"
          end
          __lux_tmp_302 = __lux_tmp_303
        end
        local __lux_tmp_304 = __lux_module_1.toNumber(x)
        if __lux_tmp_304 == nil then
          __lux_tmp_304 = 0
        end
        local __lux_tmp_305 = __lux_module_1.toNumber(y)
        if __lux_tmp_305 == nil then
          __lux_tmp_305 = 0
        end
        local __lux_tmp_306 = color
        if __lux_tmp_306 == nil then
          local __lux_tmp_307 = resolved.color
          if __lux_tmp_307 == nil then
            __lux_tmp_307 = resolved.fill
          end
          __lux_tmp_306 = __lux_tmp_307
        end
        local __lux_tmp_308 = resolved.alignX
        if __lux_tmp_308 == nil then
          local __lux_tmp_309 = resolved.align
          if __lux_tmp_309 == nil then
            local __lux_tmp_310 = ax
            if __lux_tmp_310 == nil then
              __lux_tmp_310 = TEXT_ALIGN_LEFT
            end
            __lux_tmp_309 = __lux_tmp_310
          end
          __lux_tmp_308 = __lux_tmp_309
        end
        local __lux_tmp_311 = resolved.alignY
        if __lux_tmp_311 == nil then
          local __lux_tmp_312 = resolved.valign
          if __lux_tmp_312 == nil then
            local __lux_tmp_313 = ay
            if __lux_tmp_313 == nil then
              __lux_tmp_313 = TEXT_ALIGN_TOP
            end
            __lux_tmp_312 = __lux_tmp_313
          end
          __lux_tmp_311 = __lux_tmp_312
        end
        record = {
          text = __lux_module_1.toString(__lux_tmp_301),
          font = __lux_tmp_302,
          x = __lux_tmp_304,
          y = __lux_tmp_305,
          color = __lux_module_1.style.colorOr(__lux_tmp_306, __lux_module_1.white),
          alignX = __lux_tmp_308,
          alignY = __lux_tmp_311,
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
        local __lux_tmp_314 = textStyle
        if __lux_tmp_314 == nil then
          __lux_tmp_314 = {}
        end
        out = __lux_module_1.copyValue(__lux_tmp_314)
      end
      out.alignY = TEXT_ALIGN_TOP
      out.valign = TEXT_ALIGN_TOP
      return out
    end
    __lux_module_1.boxEx = function(value, font, x, y, w, h, textStyle)
      local renderer = __lux_module_1.sharedTextRenderer()
      local __lux_obj_315 = renderer
      local __lux_val_316 = nil
      if __lux_obj_315 ~= nil then
        __lux_val_316 = __lux_obj_315.DrawTextBoxImmediate
      end
      if __lux_val_316 ~= nil then
        return renderer.DrawTextBoxImmediate(value, font, x, y, w, h, textStyle)
      end
      local resolved
      do
        local __lux_tmp_317 = textStyle
        if __lux_tmp_317 == nil then
          __lux_tmp_317 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_317)
      end
      local resolvedFont
      do
        local __lux_tmp_318 = resolved.font
        if __lux_tmp_318 == nil then
          local __lux_tmp_319 = font
          if __lux_tmp_319 == nil then
            __lux_tmp_319 = "DermaDefault"
          end
          __lux_tmp_318 = __lux_tmp_319
        end
        resolvedFont = __lux_tmp_318
      end
      local lines
      do
        local __lux_tmp_320 = __lux_module_1.toNumber(w)
        if __lux_tmp_320 == nil then
          __lux_tmp_320 = 0
        end
        lines = __lux_module_1.wrapText(value, resolvedFont, __lux_tmp_320, resolved.overflow)
      end
      local nativeFont, alias, oversample = __lux_module_1.nativeFor(resolvedFont, resolved)
      local lineHeight = __lux_module_1.lineHeightFor(nativeFont, alias, resolved, oversample)
      local totalH = #lines * lineHeight
      local startY
      do
        local __lux_tmp_321 = __lux_module_1.toNumber(y)
        if __lux_tmp_321 == nil then
          __lux_tmp_321 = 0
        end
        local __lux_tmp_322 = __lux_module_1.toNumber(h)
        if __lux_tmp_322 == nil then
          __lux_tmp_322 = totalH
        end
        local __lux_tmp_323 = resolved.alignY
        if __lux_tmp_323 == nil then
          local __lux_tmp_324 = resolved.valign
          if __lux_tmp_324 == nil then
            __lux_tmp_324 = TEXT_ALIGN_TOP
          end
          __lux_tmp_323 = __lux_tmp_324
        end
        startY = __lux_tmp_321 + (__lux_tmp_322 - totalH) * __lux_module_1.alignFactor(__lux_tmp_323, true)
      end
      local ax
      do
        local __lux_tmp_325 = resolved.alignX
        if __lux_tmp_325 == nil then
          local __lux_tmp_326 = resolved.align
          if __lux_tmp_326 == nil then
            __lux_tmp_326 = TEXT_ALIGN_LEFT
          end
          __lux_tmp_325 = __lux_tmp_326
        end
        ax = __lux_tmp_325
      end
      local tx
      do
        local __lux_tmp_327 = __lux_module_1.toNumber(x)
        if __lux_tmp_327 == nil then
          __lux_tmp_327 = 0
        end
        local __lux_tmp_328 = __lux_module_1.toNumber(w)
        if __lux_tmp_328 == nil then
          __lux_tmp_328 = 0
        end
        tx = __lux_tmp_327 + __lux_tmp_328 * __lux_module_1.alignFactor(ax)
      end
      local lineStyle = __lux_module_1.textBoxLineStyle(resolved)
      for index = 1, #lines do
        do
          local __lux_tmp_329 = lineStyle.color
          if __lux_tmp_329 == nil then
            __lux_tmp_329 = lineStyle.fill
          end
          __lux_module_1.drawEx(
            lines[index],
            resolvedFont,
            tx,
            startY + (index - 1) * lineHeight,
            __lux_tmp_329,
            ax,
            TEXT_ALIGN_TOP,
            lineStyle
          )
        end
      end
    end
    __lux_module_1.batch = function(records)
      local renderer = __lux_module_1.sharedTextRenderer()
      local __lux_obj_330 = renderer
      local __lux_val_331 = nil
      if __lux_obj_330 ~= nil then
        __lux_val_331 = __lux_obj_330.Flush
      end
      local __lux_tmp_332 = __lux_val_331 ~= nil
      if __lux_tmp_332 then
        __lux_tmp_332 = renderer.MakeRecord ~= nil
      end
      if __lux_tmp_332 then
        local normalized = {}
        do
          local __lux_tmp_333 = records
          if __lux_tmp_333 == nil then
            __lux_tmp_333 = {}
          end
          for index = 1, #__lux_tmp_333 do
            local record = records[index]
            if record ~= nil then
              do
                local __lux_tmp_334 = record.text
                if __lux_tmp_334 == nil then
                  __lux_tmp_334 = record.value
                end
                local __lux_tmp_335 = record.alignX
                if __lux_tmp_335 == nil then
                  __lux_tmp_335 = record.ax
                end
                local __lux_tmp_336 = record.alignY
                if __lux_tmp_336 == nil then
                  __lux_tmp_336 = record.ay
                end
                local __lux_tmp_337 = record.style
                if __lux_tmp_337 == nil then
                  __lux_tmp_337 = {}
                end
                normalized[#normalized + 1] = renderer.MakeRecord(
                  __lux_tmp_334,
                  record.font,
                  record.x,
                  record.y,
                  record.color,
                  __lux_tmp_335,
                  __lux_tmp_336,
                  __lux_tmp_337
                )
              end
            end
          end
        end
        return renderer.Flush(normalized, "batch")
      end
      do
        local __lux_tmp_338 = records
        if __lux_tmp_338 == nil then
          __lux_tmp_338 = {}
        end
        for index = 1, #__lux_tmp_338 do
          local record = records[index]
          do
            local __lux_tmp_339 = record.alignX
            if __lux_tmp_339 == nil then
              __lux_tmp_339 = record.ax
            end
            local __lux_tmp_340 = record.alignY
            if __lux_tmp_340 == nil then
              __lux_tmp_340 = record.ay
            end
            local __lux_tmp_341 = record.style
            if __lux_tmp_341 == nil then
              __lux_tmp_341 = {}
            end
            __lux_module_1.drawNativeFallbackRecord(
              {
                text = record.text,
                font = record.font,
                x = record.x,
                y = record.y,
                color = record.color,
                alignX = __lux_tmp_339,
                alignY = __lux_tmp_340,
                style = __lux_module_1.resolveStyle(__lux_tmp_341),
              }
            )
          end
        end
      end
      return records
    end
    __lux_module_1.prewarm = function(value, font, textStyle)
      local renderer = __lux_module_1.sharedTextRenderer()
      local __lux_obj_342 = renderer
      local __lux_val_343 = nil
      if __lux_obj_342 ~= nil then
        __lux_val_343 = __lux_obj_342.PrewarmText
      end
      if __lux_val_343 ~= nil then
        return renderer.PrewarmText(value, font, textStyle)
      end
      local resolved
      do
        local __lux_tmp_344 = textStyle
        if __lux_tmp_344 == nil then
          __lux_tmp_344 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_344)
      end
      local layout
      do
        local __lux_tmp_345 = font
        if __lux_tmp_345 == nil then
          local __lux_tmp_346 = resolved.font
          if __lux_tmp_346 == nil then
            __lux_tmp_346 = "DermaDefault"
          end
          __lux_tmp_345 = __lux_tmp_346
        end
        layout = __lux_module_1.layoutFor(value, __lux_tmp_345, resolved)
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
        local __lux_tmp_347 = __lux_module_1.profile.times
        if __lux_tmp_347 == nil then
          __lux_tmp_347 = {}
        end
        local __lux_tmp_348 = __lux_module_1.profile.counts
        if __lux_tmp_348 == nil then
          __lux_tmp_348 = {}
        end
        out = {
          active = __lux_module_1.profile.active,
          draws = __lux_module_1.profile.draws,
          measures = __lux_module_1.profile.measures,
          times = __lux_module_1.tableCopy(__lux_tmp_347),
          counts = __lux_module_1.tableCopy(__lux_tmp_348),
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
      stats.textQueuedBatches = 0
      stats.textQueuedRecords = 0
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
        local __lux_tmp_349 = stats.textComposedEntries
        if __lux_tmp_349 == nil then
          __lux_tmp_349 = 0
        end
        stats.textComposedEntries = __lux_tmp_349
      end
      do
        local __lux_tmp_350 = stats.textComposedEvicts
        if __lux_tmp_350 == nil then
          __lux_tmp_350 = 0
        end
        stats.textComposedEvicts = __lux_tmp_350
      end
      do
        local __lux_tmp_351 = stats.textMeasureHits
        if __lux_tmp_351 == nil then
          __lux_tmp_351 = 0
        end
        stats.textMeasureHits = __lux_tmp_351
      end
      do
        local __lux_tmp_352 = stats.textMeasureMisses
        if __lux_tmp_352 == nil then
          __lux_tmp_352 = 0
        end
        stats.textMeasureMisses = __lux_tmp_352
      end
      do
        local __lux_tmp_353 = stats.textEntryCacheHits
        if __lux_tmp_353 == nil then
          __lux_tmp_353 = 0
        end
        stats.textEntryCacheHits = __lux_tmp_353
      end
      do
        local __lux_tmp_354 = stats.textEntryCacheMisses
        if __lux_tmp_354 == nil then
          __lux_tmp_354 = 0
        end
        stats.textEntryCacheMisses = __lux_tmp_354
      end
      do
        local __lux_tmp_355 = stats.textFallbacks
        if __lux_tmp_355 == nil then
          __lux_tmp_355 = 0
        end
        stats.textFallbacks = __lux_tmp_355
      end
      stats.textDataDraws = 0
      stats.textDataBatches = 0
      stats.textAtlasUploads = 0
      stats.textAtlasGlyphs = 0
      do
        local __lux_tmp_356 = stats.textAtlasResets
        if __lux_tmp_356 == nil then
          __lux_tmp_356 = 0
        end
        stats.textAtlasResets = __lux_tmp_356
      end
      stats.textCacheSize = __lux_module_1.measureOrderCount
      return stats
    end
    __lux_module_1.statAdd = function(stats, key, amount)
      if amount == nil then
        amount = 1
      end
      do
        local __lux_tmp_357 = stats[key]
        if __lux_tmp_357 == nil then
          __lux_tmp_357 = 0
        end
        stats[key] = __lux_tmp_357 + amount
      end
      return stats[key]
    end
  end
  do
    __lux_module_1.textComposedEnabled = function()
      local __lux_tmp_358 = not __lux_module_1.textComposerCapable()
      if not __lux_tmp_358 then
        __lux_tmp_358 = __lux_module_1.atlasFailed
      end
      if __lux_tmp_358 then
        return false
      end
      local __lux_tmp_359 = __lux_module_1.composedCvar == nil
      if __lux_tmp_359 then
        __lux_tmp_359 = __lux_module_1.getConVar ~= nil
      end
      if __lux_tmp_359 then
        do
          local __lux_tmp_360 = __lux_module_1.getConVar("mgfx_text_composed")
          if __lux_tmp_360 == nil then
            __lux_tmp_360 = false
          end
          __lux_module_1.composedCvar = __lux_tmp_360
        end
      end
      local __lux_tmp_361 = __lux_module_1.composedCvar == false
      if not __lux_tmp_361 then
        __lux_tmp_361 = __lux_module_1.composedCvar == nil
      end
      if __lux_tmp_361 then
        return true
      end
      return __lux_module_1.composedCvar:GetBool()
    end
    __lux_module_1.textComposeBudget = function()
      local __lux_tmp_362 = __lux_module_1.budgetCvar == nil
      if __lux_tmp_362 then
        __lux_tmp_362 = __lux_module_1.getConVar ~= nil
      end
      if __lux_tmp_362 then
        do
          local __lux_tmp_363 = __lux_module_1.getConVar("mgfx_text_composed_budget")
          if __lux_tmp_363 == nil then
            __lux_tmp_363 = false
          end
          __lux_module_1.budgetCvar = __lux_tmp_363
        end
      end
      local __lux_tmp_364 = __lux_module_1.budgetCvar == false
      if not __lux_tmp_364 then
        __lux_tmp_364 = __lux_module_1.budgetCvar == nil
      end
      if __lux_tmp_364 then
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
      local __lux_tmp_365 = rt == nil
      if not __lux_tmp_365 then
        __lux_tmp_365 = __lux_module_1.renderPushRenderTarget == nil
      end
      local __lux_tmp_366 = __lux_tmp_365
      if not __lux_tmp_366 then
        __lux_tmp_366 = __lux_module_1.renderClear == nil
      end
      local __lux_tmp_367 = __lux_tmp_366
      if not __lux_tmp_367 then
        __lux_tmp_367 = __lux_module_1.renderPopRenderTarget == nil
      end
      if __lux_tmp_367 then
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
          local __lux_tmp_368 = alpha
          if __lux_tmp_368 == nil then
            __lux_tmp_368 = 1
          end
          __lux_module_1.surfaceSetAlphaMultiplier(__lux_tmp_368)
        end
      end
      local __lux_tmp_369 = __lux_module_1.renderSetColorModulation ~= nil
      if __lux_tmp_369 then
        __lux_tmp_369 = cr ~= nil
      end
      if __lux_tmp_369 then
        __lux_module_1.renderSetColorModulation(cr, cg, cb)
      end
      local __lux_tmp_370 = __lux_module_1.renderSetBlend ~= nil
      if __lux_tmp_370 then
        __lux_tmp_370 = blend ~= nil
      end
      if __lux_tmp_370 then
        __lux_module_1.renderSetBlend(blend)
      end
    end
    __lux_module_1.clearAtlasSlot = function(x, y, w, h)
      local __lux_tmp_371 = __lux_module_1.surfaceDrawRect == nil
      if not __lux_tmp_371 then
        __lux_tmp_371 = __lux_module_1.surfaceSetDrawColor == nil
      end
      if __lux_tmp_371 then
        return false
      end
      do
        local __lux_tmp_372 = x
        if __lux_tmp_372 == nil then
          __lux_tmp_372 = 0
        end
        x = __lux_module_1.mathFloor(__lux_module_1.mathMax(0, __lux_tmp_372))
      end
      do
        local __lux_tmp_373 = y
        if __lux_tmp_373 == nil then
          __lux_tmp_373 = 0
        end
        y = __lux_module_1.mathFloor(__lux_module_1.mathMax(0, __lux_tmp_373))
      end
      do
        local __lux_tmp_374 = w
        if __lux_tmp_374 == nil then
          __lux_tmp_374 = 0
        end
        w = __lux_module_1.mathCeil(
          __lux_module_1.mathMin(__lux_module_1.ATLAS_W - x, __lux_tmp_374)
        )
      end
      do
        local __lux_tmp_375 = h
        if __lux_tmp_375 == nil then
          __lux_tmp_375 = 0
        end
        h = __lux_module_1.mathCeil(
          __lux_module_1.mathMin(__lux_module_1.ATLAS_H - y, __lux_tmp_375)
        )
      end
      local __lux_tmp_376 = w <= 0
      if not __lux_tmp_376 then
        __lux_tmp_376 = h <= 0
      end
      if __lux_tmp_376 then
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
      local __lux_tmp_377 = __lux_module_1.renderSetColorModulation ~= nil
      if __lux_tmp_377 then
        __lux_tmp_377 = cr ~= nil
      end
      if __lux_tmp_377 then
        __lux_module_1.renderSetColorModulation(cr, cg, cb)
      end
      local __lux_tmp_378 = __lux_module_1.renderSetBlend ~= nil
      if __lux_tmp_378 then
        __lux_tmp_378 = blend ~= nil
      end
      if __lux_tmp_378 then
        __lux_module_1.renderSetBlend(blend)
      end
      return true
    end
    __lux_module_1.createAtlasMaterial = function(name, rt)
      local __lux_tmp_379 = __lux_module_1.createMaterial == nil
      if not __lux_tmp_379 then
        __lux_tmp_379 = rt == nil
      end
      local __lux_tmp_380 = __lux_tmp_379
      if not __lux_tmp_380 then
        __lux_tmp_380 = rt.GetName == nil
      end
      if __lux_tmp_380 then
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
      local __lux_tmp_381 = __lux_module_1.getRenderTargetEx == nil
      if not __lux_tmp_381 then
        __lux_tmp_381 = __lux_module_1.bitBor == nil
      end
      if __lux_tmp_381 then
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
        local __lux_tmp_382 = __lux_module_1.atlasNamespace
        if __lux_tmp_382 == nil then
          __lux_tmp_382 = __lux_module_1.nextAtlasNamespace()
        end
        baseName = __lux_tmp_382 ..
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
          local __lux_obj_383 = mats
          local __lux_val_384 = nil
          if __lux_obj_383 ~= nil then
            __lux_val_384 = __lux_obj_383.compose
          end
          page.composeMat = __lux_val_384
        end
        do
          local __lux_obj_385 = mats
          local __lux_val_386 = nil
          if __lux_obj_385 ~= nil then
            __lux_val_386 = __lux_obj_385.face
          end
          page.faceMat = __lux_val_386
        end
      end
      __lux_module_1.atlasPages[index] = page
      do
        local __lux_tmp_387 = __lux_module_1.atlas
        if __lux_tmp_387 == nil then
          __lux_tmp_387 = page
        end
        __lux_module_1.atlas = __lux_tmp_387
      end
      do
        local __lux_tmp_388 = __lux_module_1.atlasMat
        if __lux_tmp_388 == nil then
          __lux_tmp_388 = pageMaterial
        end
        __lux_module_1.atlasMat = __lux_tmp_388
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
        local __lux_tmp_389 = page.generation
        if __lux_tmp_389 == nil then
          __lux_tmp_389 = 0
        end
        page.generation = __lux_tmp_389 + 1
      end
      if page.rt ~= nil then
        do
          local __lux_tmp_390 = page.w
          if __lux_tmp_390 == nil then
            __lux_tmp_390 = __lux_module_1.ATLAS_W
          end
          local __lux_tmp_391 = page.h
          if __lux_tmp_391 == nil then
            __lux_tmp_391 = __lux_module_1.ATLAS_H
          end
          __lux_module_1.clearRenderTargetAlpha(page.rt, __lux_tmp_390, __lux_tmp_391)
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
        local __lux_obj_392 = __lux_module_1.atlas
        local __lux_val_393 = nil
        if __lux_obj_392 ~= nil then
          __lux_val_393 = __lux_obj_392.material
        end
        local __lux_tmp_394 = __lux_val_393
        if __lux_tmp_394 == nil then
          __lux_tmp_394 = __lux_module_1.atlasMat
        end
        __lux_module_1.atlasMat = __lux_tmp_394
      end
    end
    __lux_module_1.tryAllocOnPage = function(page, w, h, gutter)
      if page == nil then
        return nil
      end
      local cellW = w + gutter * 2
      local cellH = h + gutter * 2
      local __lux_tmp_395 = cellW > page.w
      if not __lux_tmp_395 then
        __lux_tmp_395 = cellH > page.h
      end
      if __lux_tmp_395 then
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
        local __lux_tmp_396 = __lux_module_1.toNumber(gutter)
        if __lux_tmp_396 == nil then
          __lux_tmp_396 = 0
        end
        gutter = __lux_module_1.mathCeil(__lux_module_1.mathMax(0, __lux_tmp_396))
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
          local __lux_tmp_397 = page.h
          if __lux_tmp_397 == nil then
            __lux_tmp_397 = __lux_module_1.ATLAS_H
          end
          local __lux_tmp_398 = page.y
          if __lux_tmp_398 == nil then
            __lux_tmp_398 = 0
          end
          local __lux_tmp_399 = page.rowH
          if __lux_tmp_399 == nil then
            __lux_tmp_399 = 0
          end
          usedH = usedH + __lux_module_1.mathMin(__lux_tmp_397, __lux_tmp_398 + __lux_tmp_399)
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
      local __lux_tmp_400 = c.r
      if __lux_tmp_400 == nil then
        __lux_tmp_400 = 0
      end
      local __lux_tmp_401 = c.g
      if __lux_tmp_401 == nil then
        __lux_tmp_401 = 0
      end
      local __lux_tmp_402 = c.b
      if __lux_tmp_402 == nil then
        __lux_tmp_402 = 0
      end
      local __lux_tmp_403 = c.a
      if __lux_tmp_403 == nil then
        __lux_tmp_403 = 255
      end
      return __lux_module_1.tableConcat(
        { __lux_tmp_400, __lux_tmp_401, __lux_tmp_402, __lux_tmp_403 },
        ","
      )
    end
    __lux_module_1.isColorValue = function(value)
      local __lux_tmp_404 = __lux_module_1.style.isColor ~= nil
      if __lux_tmp_404 then
        __lux_tmp_404 = __lux_module_1.style.isColor(value)
      end
      return __lux_tmp_404
    end
    __lux_module_1.fillForRecord = function(record)
      local textStyle
      do
        local __lux_obj_405 = record
        local __lux_val_406 = nil
        if __lux_obj_405 ~= nil then
          __lux_val_406 = __lux_obj_405.style
        end
        local __lux_tmp_407 = __lux_val_406
        if __lux_tmp_407 == nil then
          __lux_tmp_407 = {}
        end
        textStyle = __lux_tmp_407
      end
      local __lux_tmp_408 = textStyle.fill
      if __lux_tmp_408 == nil then
        local __lux_tmp_409 = textStyle.color
        if __lux_tmp_409 == nil then
          local __lux_obj_410 = record
          local __lux_val_411 = nil
          if __lux_obj_410 ~= nil then
            __lux_val_411 = __lux_obj_410.color
          end
          local __lux_tmp_412 = __lux_val_411
          if __lux_tmp_412 == nil then
            __lux_tmp_412 = __lux_module_1.white
          end
          __lux_tmp_409 = __lux_tmp_412
        end
        __lux_tmp_408 = __lux_tmp_409
      end
      return __lux_tmp_408
    end
    __lux_module_1.fillNeedsShader = function(fill)
      local __lux_tmp_413 = __lux_module_1.typeOf(fill) == "table"
      if __lux_tmp_413 then
        __lux_tmp_413 = not __lux_module_1.isColorValue(fill)
      end
      local __lux_tmp_414 = __lux_tmp_413
      if __lux_tmp_414 then
        __lux_tmp_414 = fill.kind ~= nil
      end
      return __lux_tmp_414
    end
    __lux_module_1.normalizeSurface = function(value)
      local __lux_tmp_415 = value == nil
      if not __lux_tmp_415 then
        __lux_tmp_415 = value == false
      end
      if __lux_tmp_415 then
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
        local __lux_tmp_416 = value.strength
        if __lux_tmp_416 == nil then
          __lux_tmp_416 = value[1]
        end
        local __lux_tmp_417 = __lux_module_1.toNumber(__lux_tmp_416)
        if __lux_tmp_417 == nil then
          __lux_tmp_417 = 0.18
        end
        strength = __lux_module_1.mathClamp(__lux_tmp_417, 0, 1)
      end
      if strength <= 0 then
        return nil
      end
      return { strength = strength }
    end
    __lux_module_1.normalizeWeightAdjust = function(textStyle)
      do
        local __lux_tmp_418 = textStyle
        if __lux_tmp_418 == nil then
          __lux_tmp_418 = {}
        end
        textStyle = __lux_tmp_418
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
        local __lux_tmp_419 = textStyle.stroke
        if __lux_tmp_419 == nil then
          __lux_tmp_419 = textStyle.outline
        end
        stroke = __lux_module_1.normalizeStroke(__lux_tmp_419)
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
      local __lux_tmp_420
      if stroke ~= nil then
        __lux_tmp_420 = stroke.width ..
          ":" ..
            stroke.samples .. ":" .. stroke.softness .. ":" .. __lux_module_1.colorKey(stroke.color)
      else
        __lux_tmp_420 = ""
      end
      local __lux_tmp_421
      if glow ~= nil then
        do
          local __lux_tmp_422 = glow.falloff
          if __lux_tmp_422 == nil then
            __lux_tmp_422 = ""
          end
          __lux_tmp_421 = glow.width ..
            ":" ..
              glow.strength .. ":" .. __lux_tmp_422 .. ":" .. __lux_module_1.colorKey(glow.color)
        end
      else
        __lux_tmp_421 = ""
      end
      local __lux_tmp_423
      if shadow ~= nil then
        __lux_tmp_423 = shadow.x ..
          ":" ..
            shadow.y ..
              ":" ..
                shadow.blur .. ":" .. shadow.strength .. ":" .. __lux_module_1.colorKey(shadow.color)
      else
        __lux_tmp_423 = ""
      end
      local __lux_tmp_424
      if face ~= nil then
        __lux_tmp_424 = __lux_module_1.toString(face.strength)
      else
        __lux_tmp_424 = ""
      end
      local __lux_tmp_425 = weightAdjust
      if __lux_tmp_425 == nil then
        __lux_tmp_425 = 0
      end
      return __lux_module_1.tableConcat(
        {
          __lux_tmp_420,
          __lux_tmp_421,
          __lux_tmp_423,
          __lux_tmp_424,
          __lux_module_1.toString(__lux_tmp_425),
        },
        "31"
      )
    end
    __lux_module_1.effectInfo = function(textStyle)
      do
        local __lux_tmp_426 = textStyle
        if __lux_tmp_426 == nil then
          __lux_tmp_426 = {}
        end
        textStyle = __lux_tmp_426
      end
      local __lux_tmp_427 = __lux_module_1.typeOf(textStyle) == "table"
      if __lux_tmp_427 then
        __lux_tmp_427 = textStyle.__mgfxTextEffectInfo ~= nil
      end
      if __lux_tmp_427 then
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
      local __lux_tmp_428 = __lux_module_1.typeOf(textStyle) == "table"
      if __lux_tmp_428 then
        __lux_tmp_428 = textStyle[__lux_module_1.RESOLVED_STYLE_MARK] == true
      end
      if __lux_tmp_428 then
        textStyle.__mgfxTextEffectInfo = info
      end
      return info
    end
    __lux_module_1.fastEntryKey = function(record, textStyle, info)
      local nativeFont, alias, oversample = __lux_module_1.nativeFor(record.font, textStyle)
      local tracking
      do
        local __lux_tmp_429 = textStyle.tracking
        if __lux_tmp_429 == nil then
          __lux_tmp_429 = textStyle.letterSpacing
        end
        local __lux_tmp_430 = __lux_module_1.toNumber(__lux_tmp_429)
        if __lux_tmp_430 == nil then
          local __lux_tmp_431 = alias.tracking
          if __lux_tmp_431 == nil then
            __lux_tmp_431 = 0
          end
          __lux_tmp_430 = __lux_tmp_431
        end
        tracking = __lux_tmp_430
      end
      local lineHeight = __lux_module_1.lineHeightFor(nativeFont, alias, textStyle, oversample)
      local __lux_tmp_432 = record.text
      if __lux_tmp_432 == nil then
        __lux_tmp_432 = ""
      end
      local __lux_tmp_433 = record.font
      if __lux_tmp_433 == nil then
        __lux_tmp_433 = ""
      end
      local __lux_tmp_434 = nativeFont
      if __lux_tmp_434 == nil then
        __lux_tmp_434 = ""
      end
      local __lux_tmp_435 = oversample
      if __lux_tmp_435 == nil then
        __lux_tmp_435 = 1
      end
      local __lux_obj_436 = info
      local __lux_val_437 = nil
      if __lux_obj_436 ~= nil then
        __lux_val_437 = __lux_obj_436.routeKey
      end
      local __lux_tmp_438 = __lux_val_437
      if __lux_tmp_438 == nil then
        __lux_tmp_438 = ""
      end
      return __lux_module_1.CACHE_VERSION ..
        "30" ..
          __lux_module_1.toString(__lux_tmp_432) ..
            "30" ..
              __lux_module_1.toString(__lux_tmp_433) ..
                "30" ..
                  __lux_module_1.toString(__lux_tmp_434) ..
                    "30" ..
                      __lux_module_1.toString(__lux_tmp_435) ..
                        "30" ..
                          __lux_module_1.toString(tracking) ..
                            "30" ..
                              __lux_module_1.toString(lineHeight) .. "30" .. __lux_module_1.toString(__lux_tmp_438)
    end
    __lux_module_1.drawUV = function(material, x, y, w, h, u0, v0, u1, v1, color, pageW, pageH)
      if pageW == nil then
        pageW = __lux_module_1.ATLAS_W
      end
      if pageH == nil then
        pageH = __lux_module_1.ATLAS_H
      end
      local __lux_tmp_439 = material == nil
      if not __lux_tmp_439 then
        __lux_tmp_439 = __lux_module_1.surfaceSetMaterial == nil
      end
      local __lux_tmp_440 = __lux_tmp_439
      if not __lux_tmp_440 then
        __lux_tmp_440 = __lux_module_1.surfaceSetDrawColor == nil
      end
      local __lux_tmp_441 = __lux_tmp_440
      if not __lux_tmp_441 then
        __lux_tmp_441 = __lux_module_1.surfaceDrawTexturedRectUV == nil
      end
      if __lux_tmp_441 then
        return false
      end
      local du = 0.5 / __lux_module_1.mathMax(1, pageW)
      local dv = 0.5 / __lux_module_1.mathMax(1, pageH)
      local denomU = 1 - 2 * du
      local denomV = 1 - 2 * dv
      __lux_module_1.surfaceSetMaterial(material)
      local c
      if __lux_module_1.style.asColor ~= nil then
        c = __lux_module_1.style.asColor(color, __lux_module_1.white)
      else
        c = __lux_module_1.style.colorOr(color, __lux_module_1.white)
      end
      do
        local __lux_tmp_442 = c.r
        if __lux_tmp_442 == nil then
          __lux_tmp_442 = 255
        end
        local __lux_tmp_443 = c.g
        if __lux_tmp_443 == nil then
          __lux_tmp_443 = 255
        end
        local __lux_tmp_444 = c.b
        if __lux_tmp_444 == nil then
          __lux_tmp_444 = 255
        end
        local __lux_tmp_445 = c.a
        if __lux_tmp_445 == nil then
          __lux_tmp_445 = 255
        end
        __lux_module_1.surfaceSetDrawColor(
          __lux_tmp_442,
          __lux_tmp_443,
          __lux_tmp_444,
          __lux_tmp_445
        )
      end
      __lux_module_1.surfaceDrawTexturedRectUV(
        x,
        y,
        w,
        h,
        (u0 - du) / denomU,
        (v0 - dv) / denomV,
        (u1 - du) / denomU,
        (v1 - dv) / denomV
      )
      return true
    end
    __lux_module_1.bakeEntry = function(record, key, layout, shadow, stroke, glow, face, weightAdjust, pad, gutter, stats)
      local oversample = __lux_module_1.normalizeOversample(layout.oversample)
      local atlasW = __lux_module_1.mathCeil((layout.w + pad * 2) * oversample)
      local atlasH = __lux_module_1.mathCeil((layout.h + pad * 2) * oversample)
      local __lux_tmp_446 = atlasW <= 0
      if not __lux_tmp_446 then
        __lux_tmp_446 = atlasH <= 0
      end
      local __lux_tmp_447 = __lux_tmp_446
      if not __lux_tmp_447 then
        __lux_tmp_447 = atlasW > __lux_module_1.ATLAS_W
      end
      local __lux_tmp_448 = __lux_tmp_447
      if not __lux_tmp_448 then
        __lux_tmp_448 = atlasH > __lux_module_1.ATLAS_H
      end
      if __lux_tmp_448 then
        return nil
      end
      local allocGutter = gutter * oversample
      local page, slotX, slotY = __lux_module_1.allocAtlasSlot(atlasW, atlasH, allocGutter)
      local __lux_tmp_449 = page == nil
      if not __lux_tmp_449 then
        __lux_tmp_449 = slotX == nil
      end
      if __lux_tmp_449 then
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
        local __lux_tmp_450 = shaderCapableFace
        if __lux_tmp_450 then
          local __lux_tmp_451 = face ~= nil
          if not __lux_tmp_451 then
            local __lux_tmp_452 = weightAdjust
            if __lux_tmp_452 == nil then
              __lux_tmp_452 = 0
            end
            local __lux_cmp_453 = false
            if __lux_module_1.mathAbs(__lux_tmp_452) ~= nil and 0.001 ~= nil then
              __lux_cmp_453 = __lux_module_1.mathAbs(__lux_tmp_452) > 0.001
            end
            __lux_tmp_451 = __lux_cmp_453
          end
          __lux_tmp_450 = __lux_tmp_451
        end
        shaderFace = __lux_tmp_450
      end
      local __lux_tmp_454 = not shaderFace
      if __lux_tmp_454 then
        __lux_tmp_454 = shaderCapableFace
      end
      if __lux_tmp_454 then
        do
          local __lux_tmp_455 = shadow ~= nil
          if not __lux_tmp_455 then
            __lux_tmp_455 = stroke ~= nil
          end
          local __lux_tmp_456 = __lux_tmp_455
          if not __lux_tmp_456 then
            __lux_tmp_456 = glow ~= nil
          end
          shaderFace = __lux_tmp_456
        end
      end
      local entry
      do
        local __lux_tmp_457 = weightAdjust
        if __lux_tmp_457 == nil then
          __lux_tmp_457 = 0
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
          weightAdjust = __lux_tmp_457,
          shaderFace = shaderFace,
          generation = page.generation,
        }
      end
      __lux_module_1.composedCache[key] = entry
      __lux_module_1.composedCacheCount = __lux_module_1.composedCacheCount + 1
      do
        local __lux_tmp_458 = stats
        if __lux_tmp_458 == nil then
          __lux_tmp_458 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_458, "textComposedBakes")
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
      local __lux_tmp_459 = not __lux_module_1.textComposedEnabled()
      if not __lux_tmp_459 then
        __lux_tmp_459 = not __lux_module_1.ensureTargets()
      end
      if __lux_tmp_459 then
        return nil
      end
      local textStyle
      do
        local __lux_tmp_460 = record.style
        if __lux_tmp_460 == nil then
          __lux_tmp_460 = {}
        end
        textStyle = __lux_tmp_460
      end
      local __lux_tmp_461 = textStyle.noComposed
      if not __lux_tmp_461 then
        __lux_tmp_461 = textStyle.native == true
      end
      if __lux_tmp_461 then
        return nil
      end
      local info = __lux_module_1.effectInfo(textStyle)
      local key
      do
        local __lux_tmp_462 = record.__mgfxTextEntryKey
        if __lux_tmp_462 == nil then
          __lux_tmp_462 = __lux_module_1.fastEntryKey(record, textStyle, info)
        end
        key = __lux_tmp_462
      end
      record.__mgfxTextEntryKey = key
      __lux_module_1.composedTick = __lux_module_1.composedTick + 1
      local cached = __lux_module_1.composedCache[key]
      local __lux_tmp_463 = cached ~= nil
      if __lux_tmp_463 then
        __lux_tmp_463 = cached.page ~= nil
      end
      local __lux_tmp_464 = __lux_tmp_463
      if __lux_tmp_464 then
        __lux_tmp_464 = cached.generation == cached.page.generation
      end
      if __lux_tmp_464 then
        cached.tick = __lux_module_1.composedTick
        do
          local __lux_tmp_465 = stats
          if __lux_tmp_465 == nil then
            __lux_tmp_465 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_465, "textEntryCacheHits")
        end
        return cached
      end
      do
        local __lux_tmp_466 = stats
        if __lux_tmp_466 == nil then
          __lux_tmp_466 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_466, "textEntryCacheMisses")
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
      local textStyle
      do
        local __lux_tmp_467 = record.style
        if __lux_tmp_467 == nil then
          __lux_tmp_467 = {}
        end
        textStyle = __lux_tmp_467
      end
      local info = __lux_module_1.effectInfo(textStyle)
      local __lux_tmp_468 = info.shadow ~= nil
      if not __lux_tmp_468 then
        __lux_tmp_468 = info.stroke ~= nil
      end
      local __lux_tmp_469 = __lux_tmp_468
      if not __lux_tmp_469 then
        __lux_tmp_469 = info.glow ~= nil
      end
      local __lux_tmp_470 = __lux_tmp_469
      if not __lux_tmp_470 then
        __lux_tmp_470 = info.face ~= nil
      end
      local __lux_tmp_471 = __lux_tmp_470
      if not __lux_tmp_471 then
        local __lux_tmp_472 = info.weightAdjust
        if __lux_tmp_472 == nil then
          __lux_tmp_472 = 0
        end
        local __lux_cmp_473 = false
        if __lux_module_1.mathAbs(__lux_tmp_472) ~= nil and 0.001 ~= nil then
          __lux_cmp_473 = __lux_module_1.mathAbs(__lux_tmp_472) > 0.001
        end
        __lux_tmp_471 = __lux_cmp_473
      end
      local __lux_tmp_474 = __lux_tmp_471
      if not __lux_tmp_474 then
        __lux_tmp_474 = __lux_module_1.fillNeedsShader(__lux_module_1.fillForRecord(record))
      end
      return __lux_tmp_474
    end
    __lux_module_1.recordNeedsComposedEntry = function(record)
      local textStyle
      do
        local __lux_tmp_475 = record.style
        if __lux_tmp_475 == nil then
          __lux_tmp_475 = {}
        end
        textStyle = __lux_tmp_475
      end
      local __lux_tmp_476 = textStyle.noComposed
      if not __lux_tmp_476 then
        __lux_tmp_476 = textStyle.native == true
      end
      if __lux_tmp_476 then
        return false
      end
      return __lux_module_1.recordHasShaderWork(record)
    end
    __lux_module_1.prepareTextRoutes = function(records)
      local composeCount = 0
      do
        local __lux_tmp_477 = records
        if __lux_tmp_477 == nil then
          __lux_tmp_477 = {}
        end
        for _, record in ipairs(__lux_tmp_477) do
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
      local __lux_tmp_478 = records == nil
      if not __lux_tmp_478 then
        __lux_tmp_478 = #records <= 1
      end
      if __lux_tmp_478 then
        return true
      end
      local __lux_tmp_479 = not __lux_module_1.textComposedEnabled()
      if not __lux_tmp_479 then
        __lux_tmp_479 = not __lux_module_1.ensureTargets()
      end
      if __lux_tmp_479 then
        do
          local __lux_tmp_480 = stats
          if __lux_tmp_480 == nil then
            __lux_tmp_480 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_480, "textComposedPrewarmFails")
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
                local __lux_tmp_481 = stats
                if __lux_tmp_481 == nil then
                  __lux_tmp_481 = {}
                end
                __lux_module_1.statAdd(__lux_tmp_481, "textComposedPrewarmFails")
              end
              return false
            end
            record.__mgfxTextEntry = entry
            if __lux_module_1.atlasEpoch ~= generation then
              do
                local __lux_tmp_482 = stats
                if __lux_tmp_482 == nil then
                  __lux_tmp_482 = {}
                end
                __lux_module_1.statAdd(__lux_tmp_482, "textComposedPrewarmRestarts")
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
        local __lux_tmp_483 = stats
        if __lux_tmp_483 == nil then
          __lux_tmp_483 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_483, "textComposedPrewarmFails")
      end
      return false
    end
    __lux_module_1.hasShaderFx = function(entry)
      local __lux_tmp_484 = entry ~= nil
      if __lux_tmp_484 then
        local __lux_tmp_485 = entry.shadow ~= nil
        if not __lux_tmp_485 then
          __lux_tmp_485 = entry.stroke ~= nil
        end
        local __lux_tmp_486 = __lux_tmp_485
        if not __lux_tmp_486 then
          __lux_tmp_486 = entry.glow ~= nil
        end
        local __lux_tmp_487 = __lux_tmp_486
        if not __lux_tmp_487 then
          __lux_tmp_487 = entry.face ~= nil
        end
        local __lux_tmp_488 = __lux_tmp_487
        if not __lux_tmp_488 then
          local __lux_tmp_489 = entry.weightAdjust
          if __lux_tmp_489 == nil then
            __lux_tmp_489 = 0
          end
          __lux_tmp_488 = __lux_tmp_489 ~= 0
        end
        __lux_tmp_484 = __lux_tmp_488
      end
      return __lux_tmp_484
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
        local __lux_tmp_490 = effect.color
        if __lux_tmp_490 == nil then
          __lux_tmp_490 = __lux_module_1.white
        end
        r, g, b, a = __lux_module_1.style.color01(__lux_tmp_490)
      end
      return r, g, b, __lux_module_1.mathClamp(a * scale, 0, 1)
    end
    __lux_module_1.packShadowParams = function(x, y, stroke)
      do
        local __lux_tmp_491 = __lux_module_1.toNumber(x)
        if __lux_tmp_491 == nil then
          __lux_tmp_491 = 0
        end
        x = __lux_module_1.mathClamp(__lux_tmp_491, -64, 63.5)
      end
      do
        local __lux_tmp_492 = __lux_module_1.toNumber(y)
        if __lux_tmp_492 == nil then
          __lux_tmp_492 = 0
        end
        y = __lux_module_1.mathClamp(__lux_tmp_492, -64, 63.5)
      end
      local xb = __lux_module_1.mathClamp(__lux_module_1.mathFloor((x + 64) * 2 + 0.5), 0, 255)
      local yb = __lux_module_1.mathClamp(__lux_module_1.mathFloor((y + 64) * 2 + 0.5), 0, 255)
      local softness
      do
        local __lux_obj_493 = stroke
        local __lux_val_494 = nil
        if __lux_obj_493 ~= nil then
          __lux_val_494 = __lux_obj_493.softness
        end
        local __lux_tmp_495 = __lux_val_494
        if __lux_tmp_495 == nil then
          __lux_tmp_495 = 0
        end
        softness = __lux_tmp_495
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
        local __lux_obj_496 = shadow
        local __lux_val_497 = nil
        if __lux_obj_496 ~= nil then
          __lux_val_497 = __lux_obj_496.blur
        end
        local __lux_tmp_498 = __lux_val_497
        if __lux_tmp_498 == nil then
          __lux_tmp_498 = 0
        end
        blur = __lux_tmp_498
      end
      local falloff
      do
        local __lux_obj_499 = glow
        local __lux_val_500 = nil
        if __lux_obj_499 ~= nil then
          __lux_val_500 = __lux_obj_499.falloff
        end
        local __lux_tmp_501 = __lux_val_500
        if __lux_tmp_501 == nil then
          __lux_tmp_501 = 1.65
        end
        falloff = __lux_tmp_501
      end
      local faceStrength
      do
        local __lux_obj_502 = face
        local __lux_val_503 = nil
        if __lux_obj_502 ~= nil then
          __lux_val_503 = __lux_obj_502.strength
        end
        local __lux_tmp_504 = __lux_val_503
        if __lux_tmp_504 == nil then
          __lux_tmp_504 = 0
        end
        faceStrength = __lux_tmp_504
      end
      local weight
      do
        local __lux_tmp_505 = __lux_module_1.toNumber(weightAdjust)
        if __lux_tmp_505 == nil then
          __lux_tmp_505 = 0
        end
        weight = __lux_module_1.mathClamp(__lux_tmp_505, -2, 2)
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
      local sr, sg, sb, sa = __lux_module_1.scaledColor01(stroke, 1)
      local gr, gg, gb, ga
      do
        local __lux_obj_506 = glow
        local __lux_val_507 = nil
        if __lux_obj_506 ~= nil then
          __lux_val_507 = __lux_obj_506.strength
        end
        local __lux_tmp_508 = __lux_val_507
        if __lux_tmp_508 == nil then
          __lux_tmp_508 = 1
        end
        gr, gg, gb, ga = __lux_module_1.scaledColor01(glow, __lux_tmp_508)
      end
      local shr, shg, shb, sha
      do
        local __lux_obj_509 = shadow
        local __lux_val_510 = nil
        if __lux_obj_509 ~= nil then
          __lux_val_510 = __lux_obj_509.strength
        end
        local __lux_tmp_511 = __lux_val_510
        if __lux_tmp_511 == nil then
          __lux_tmp_511 = 1
        end
        shr, shg, shb, sha = __lux_module_1.scaledColor01(shadow, __lux_tmp_511)
      end
      local __lux_obj_512 = scaledStroke
      local __lux_val_513 = nil
      if __lux_obj_512 ~= nil then
        __lux_val_513 = __lux_obj_512.width
      end
      local __lux_tmp_514 = __lux_val_513
      if __lux_tmp_514 == nil then
        __lux_tmp_514 = 0
      end
      local __lux_tmp_515
      if glow ~= nil then
        __lux_tmp_515 = glow.width * oversample
      else
        __lux_tmp_515 = 0
      end
      local __lux_tmp_516 = entry.weightAdjust
      if __lux_tmp_516 == nil then
        __lux_tmp_516 = 0
      end
      local __lux_tmp_517
      if scaledShadow ~= nil then
        __lux_tmp_517 = __lux_module_1.packShadowParams(scaledShadow.x, scaledShadow.y, scaledStroke)
      else
        __lux_tmp_517 = __lux_module_1.packShadowParams(0, 0, scaledStroke)
      end
      return __lux_module_1.setupTextAuxParamMatrix(
        material,
        sr,
        sg,
        sb,
        sa,
        gr,
        gg,
        gb,
        ga,
        shr,
        shg,
        shb,
        sha,
        __lux_tmp_514,
        __lux_tmp_515,
        __lux_module_1.packEffectParams(
          glow,
          scaledShadow,
          face,
          __lux_tmp_516 * oversample,
          entry.shaderFace
        ),
        __lux_tmp_517
      )
    end
    __lux_module_1.fillEndpointColors = function(fill, fallback)
      if __lux_module_1.isColorValue(fill) then
        return fill, fill
      end
      local __lux_tmp_518 = __lux_module_1.typeOf(fill) == "table"
      if __lux_tmp_518 then
        __lux_tmp_518 = __lux_module_1.typeOf(fill.stops) == "table"
      end
      local __lux_tmp_519 = __lux_tmp_518
      if __lux_tmp_519 then
        __lux_tmp_519 = #fill.stops > 0
      end
      if __lux_tmp_519 then
        local first = fill.stops[1]
        local last = fill.stops[#fill.stops]
        local __lux_tmp_520 = first.color
        if __lux_tmp_520 == nil then
          __lux_tmp_520 = first[2]
        end
        local __lux_tmp_521 = fallback
        if __lux_tmp_521 == nil then
          __lux_tmp_521 = __lux_module_1.white
        end
        local __lux_tmp_522 = last.color
        if __lux_tmp_522 == nil then
          __lux_tmp_522 = last[2]
        end
        local __lux_tmp_523 = fallback
        if __lux_tmp_523 == nil then
          __lux_tmp_523 = __lux_module_1.white
        end
        return __lux_module_1.style.asColor(__lux_tmp_520, __lux_tmp_521), __lux_module_1.style.asColor(__lux_tmp_522, __lux_tmp_523)
      end
      if __lux_module_1.typeOf(fill) == "table" then
        local a
        do
          local __lux_tmp_524 = fill.colorA
          if __lux_tmp_524 == nil then
            __lux_tmp_524 = fill[1]
          end
          local __lux_tmp_525 = fallback
          if __lux_tmp_525 == nil then
            __lux_tmp_525 = __lux_module_1.white
          end
          a = __lux_module_1.style.asColor(__lux_tmp_524, __lux_tmp_525)
        end
        local __lux_tmp_526 = fill.colorB
        if __lux_tmp_526 == nil then
          __lux_tmp_526 = fill[2]
        end
        return a, __lux_module_1.style.asColor(__lux_tmp_526, a)
      end
      local c
      do
        local __lux_tmp_527 = fallback
        if __lux_tmp_527 == nil then
          __lux_tmp_527 = __lux_module_1.white
        end
        c = __lux_module_1.style.asColor(fill, __lux_tmp_527)
      end
      return c, c
    end
    __lux_module_1.setupTextFaceMaterial = function(material, entry, record, u0, v0, u1, v1, fillOverride)
      local fill
      do
        local __lux_tmp_528 = fillOverride
        if __lux_tmp_528 == nil then
          __lux_tmp_528 = __lux_module_1.fillForRecord(record)
        end
        fill = __lux_tmp_528
      end
      local colorA, colorB
      do
        local __lux_tmp_529 = record.color
        if __lux_tmp_529 == nil then
          __lux_tmp_529 = __lux_module_1.white
        end
        colorA, colorB = __lux_module_1.fillEndpointColors(fill, __lux_tmp_529)
      end
      local r, g, b, a = __lux_module_1.style.color01(colorA)
      material:SetTexture("$basetexture", entry.page.rt)
      local lut = __lux_module_1.gradientLutForFill(fill)
      if lut ~= nil then
        material:SetTexture("$texture1", lut)
      end
      local r2, g2, b2, a2 = __lux_module_1.style.color01(colorB)
      local x1 = 0
      local y1 = 0
      local x2 = 1
      local y2 = 0
      local __lux_tmp_530 = __lux_module_1.typeOf(fill) == "table"
      if __lux_tmp_530 then
        __lux_tmp_530 = fill.kind == 1
      end
      if __lux_tmp_530 then
        do
          local __lux_tmp_531 = __lux_module_1.toNumber(fill.x1)
          if __lux_tmp_531 == nil then
            __lux_tmp_531 = 0
          end
          x1 = __lux_tmp_531
        end
        do
          local __lux_tmp_532 = __lux_module_1.toNumber(fill.y1)
          if __lux_tmp_532 == nil then
            __lux_tmp_532 = 0
          end
          y1 = __lux_tmp_532
        end
        do
          local __lux_tmp_533 = __lux_module_1.toNumber(fill.x2)
          if __lux_tmp_533 == nil then
            __lux_tmp_533 = 1
          end
          x2 = __lux_tmp_533
        end
        do
          local __lux_tmp_534 = __lux_module_1.toNumber(fill.y2)
          if __lux_tmp_534 == nil then
            __lux_tmp_534 = 0
          end
          y2 = __lux_tmp_534
        end
      end
      return __lux_module_1.setupTextAuxParamMatrix(
        material,
        u0,
        v0,
        u1,
        v1,
        r,
        g,
        b,
        a,
        r2,
        g2,
        b2,
        a2,
        x1,
        y1,
        x2,
        y2
      )
    end
    __lux_module_1.drawEntryAt = function(entry, record, contentX, contentY, fillOverride, stats)
      local page
      do
        local __lux_obj_535 = entry
        local __lux_val_536 = nil
        if __lux_obj_535 ~= nil then
          __lux_val_536 = __lux_obj_535.page
        end
        local __lux_tmp_537 = __lux_val_536
        if __lux_tmp_537 == nil then
          __lux_tmp_537 = __lux_module_1.atlas
        end
        page = __lux_tmp_537
      end
      local __lux_tmp_538 = page == nil
      if not __lux_tmp_538 then
        __lux_tmp_538 = entry.generation ~= page.generation
      end
      if __lux_tmp_538 then
        return nil
      end
      local x = contentX - entry.originX
      local y = contentY - entry.originY
      x, y = __lux_module_1.snapTextPos(x, y, record.style)
      local u0 = entry.slotX / page.w
      local v0 = entry.slotY / page.h
      local u1
      do
        local __lux_tmp_539 = entry.atlasW
        if __lux_tmp_539 == nil then
          __lux_tmp_539 = entry.w
        end
        u1 = (entry.slotX + __lux_tmp_539) / page.w
      end
      local v1
      do
        local __lux_tmp_540 = entry.atlasH
        if __lux_tmp_540 == nil then
          __lux_tmp_540 = entry.h
        end
        v1 = (entry.slotY + __lux_tmp_540) / page.h
      end
      local fx = __lux_module_1.hasShaderFx(entry)
      local faceMat
      do
        local __lux_tmp_541 = __lux_module_1.isMaterialOK(page.faceMat)
        if __lux_tmp_541 then
          __lux_tmp_541 = page.faceMat
        end
        local __lux_tmp_542 = __lux_tmp_541
        if not __lux_tmp_542 then
          local __lux_tmp_543 = __lux_module_1.isMaterialOK(__lux_module_1.materials.text_face)
          if __lux_tmp_543 then
            __lux_tmp_543 = __lux_module_1.materials.text_face
          end
          __lux_tmp_542 = __lux_tmp_543
        end
        local __lux_tmp_544 = __lux_tmp_542
        if not __lux_tmp_544 then
          __lux_tmp_544 = page.material
        end
        local __lux_tmp_545 = __lux_tmp_544
        if not __lux_tmp_545 then
          __lux_tmp_545 = __lux_module_1.atlasMat
        end
        faceMat = __lux_tmp_545
      end
      local composeMat
      do
        local __lux_tmp_546 = __lux_module_1.isMaterialOK(page.composeMat)
        if __lux_tmp_546 then
          __lux_tmp_546 = page.composeMat
        end
        local __lux_tmp_547 = __lux_tmp_546
        if not __lux_tmp_547 then
          __lux_tmp_547 = __lux_module_1.materials.text_compose
        end
        composeMat = __lux_tmp_547
      end
      local material
      do
        local __lux_tmp_548 = fx
        if __lux_tmp_548 then
          __lux_tmp_548 = composeMat
        end
        local __lux_tmp_549 = __lux_tmp_548
        if not __lux_tmp_549 then
          __lux_tmp_549 = faceMat
        end
        material = __lux_tmp_549
      end
      local __lux_tmp_550 = fx
      if __lux_tmp_550 then
        __lux_tmp_550 = __lux_module_1.isMaterialOK(material)
      end
      if __lux_tmp_550 then
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
      local __lux_tmp_551 = fx
      if __lux_tmp_551 then
        __lux_tmp_551 = entry.shaderFace
      end
      if __lux_tmp_551 then
        do
          local __lux_tmp_552 = fillOverride
          if __lux_tmp_552 == nil then
            __lux_tmp_552 = __lux_module_1.fillForRecord(record)
          end
          local __lux_tmp_553 = record.color
          if __lux_tmp_553 == nil then
            __lux_tmp_553 = __lux_module_1.white
          end
          drawColor = __lux_module_1.style.asColor(__lux_tmp_552, __lux_tmp_553)
        end
      end
      if not __lux_module_1.drawUV(
        material,
        x,
        y,
        entry.w,
        entry.h,
        u0,
        v0,
        u1,
        v1,
        drawColor,
        page.w,
        page.h
      ) then
        return nil
      end
      local blits = 1
      local __lux_tmp_554 = fx
      if __lux_tmp_554 then
        __lux_tmp_554 = not entry.shaderFace
      end
      local __lux_tmp_555 = __lux_tmp_554
      if __lux_tmp_555 then
        __lux_tmp_555 = faceMat ~= nil
      end
      if __lux_tmp_555 then
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
          __lux_module_1.white,
          page.w,
          page.h
        )
        blits = blits + 1
      end
      do
        local __lux_tmp_556 = stats
        if __lux_tmp_556 == nil then
          __lux_tmp_556 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_556, "textComposedBlits", blits)
      end
      if fx then
        do
          local __lux_tmp_557 = stats
          if __lux_tmp_557 == nil then
            __lux_tmp_557 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_557, "textShaderDraws")
        end
      end
      return fx
    end
    __lux_module_1.blitEntry = function(entry, record, stats)
      local contentX
      do
        local __lux_tmp_558 = record.x
        if __lux_tmp_558 == nil then
          __lux_tmp_558 = 0
        end
        contentX = __lux_tmp_558 - entry.contentW * __lux_module_1.alignFactor(record.alignX)
      end
      local contentY
      do
        local __lux_tmp_559 = record.y
        if __lux_tmp_559 == nil then
          __lux_tmp_559 = 0
        end
        contentY = __lux_tmp_559 - entry.contentH * __lux_module_1.alignFactor(record.alignY, true)
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
        local __lux_tmp_560 = stats
        if __lux_tmp_560 == nil then
          __lux_tmp_560 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_560, "textComposedDraws")
      end
      if fx then
        do
          local __lux_tmp_561 = stats
          if __lux_tmp_561 == nil then
            __lux_tmp_561 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_561, "textComposedFxDraws")
        end
      else
        do
          local __lux_tmp_562 = stats
          if __lux_tmp_562 == nil then
            __lux_tmp_562 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_562, "textComposedFaceDraws")
        end
      end
      return fx
    end
    __lux_module_1.textBatchKey = function(entry, record)
      local page
      do
        local __lux_obj_563 = entry
        local __lux_val_564 = nil
        if __lux_obj_563 ~= nil then
          __lux_val_564 = __lux_obj_563.page
        end
        page = __lux_val_564
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
        local __lux_tmp_565 = page.index
        if __lux_tmp_565 == nil then
          __lux_tmp_565 = 0
        end
        return "plain27" .. __lux_module_1.toString(__lux_tmp_565)
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
        local __lux_tmp_566 = color.r
        if __lux_tmp_566 == nil then
          __lux_tmp_566 = 255
        end
        local __lux_tmp_567 = color.g
        if __lux_tmp_567 == nil then
          __lux_tmp_567 = 255
        end
        local __lux_tmp_568 = color.b
        if __lux_tmp_568 == nil then
          __lux_tmp_568 = 255
        end
        local __lux_tmp_569 = color.a
        if __lux_tmp_569 == nil then
          __lux_tmp_569 = 255
        end
        __lux_module_1.meshColor(__lux_tmp_566, __lux_tmp_567, __lux_tmp_568, __lux_tmp_569)
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
        local __lux_tmp_570 = entry.atlasW
        if __lux_tmp_570 == nil then
          __lux_tmp_570 = entry.w
        end
        u1 = (entry.slotX + __lux_tmp_570) / page.w
      end
      local v1
      do
        local __lux_tmp_571 = entry.atlasH
        if __lux_tmp_571 == nil then
          __lux_tmp_571 = entry.h
        end
        v1 = (entry.slotY + __lux_tmp_571) / page.h
      end
      local c
      do
        local __lux_tmp_572 = record.__mgfxBatchColor
        if __lux_tmp_572 == nil then
          __lux_tmp_572 = __lux_module_1.white
        end
        c = __lux_tmp_572
      end
      __lux_module_1.meshVertex(x, y, u0, v0, c)
      __lux_module_1.meshVertex(x + w, y, u1, v0, c)
      __lux_module_1.meshVertex(x + w, y + h, u1, v1, c)
      __lux_module_1.meshVertex(x, y, u0, v0, c)
      __lux_module_1.meshVertex(x + w, y + h, u1, v1, c)
      return __lux_module_1.meshVertex(x, y + h, u0, v1, c)
    end
    __lux_module_1.flushTextComposeBatch = function(batch, stats)
      local __lux_tmp_573 = batch == nil
      if not __lux_tmp_573 then
        __lux_tmp_573 = #batch == 0
      end
      if __lux_tmp_573 then
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
          local __lux_tmp_574 = stats
          if __lux_tmp_574 == nil then
            __lux_tmp_574 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_574, "textComposedDraws")
        end
        do
          local __lux_tmp_575 = stats
          if __lux_tmp_575 == nil then
            __lux_tmp_575 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_575, "textComposedFxDraws")
        end
        return true
      end
      local first = batch[1]
      local firstEntry = first.__mgfxTextEntry
      for index = 1, #batch do
        local entry = batch[index].__mgfxTextEntry
        local __lux_tmp_576 = entry == nil
        if not __lux_tmp_576 then
          __lux_tmp_576 = entry.page == nil
        end
        local __lux_tmp_577 = __lux_tmp_576
        if not __lux_tmp_577 then
          __lux_tmp_577 = entry.generation ~= entry.page.generation
        end
        if __lux_tmp_577 then
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
        do
          local __lux_tmp_578 = __lux_module_1.isMaterialOK(firstEntry.page.composeMat)
          if __lux_tmp_578 then
            __lux_tmp_578 = firstEntry.page.composeMat
          end
          local __lux_tmp_579 = __lux_tmp_578
          if not __lux_tmp_579 then
            __lux_tmp_579 = __lux_module_1.materials.text_compose
          end
          material = __lux_tmp_579
        end
      else
        do
          local __lux_obj_580 = firstEntry.page
          local __lux_val_581 = nil
          if __lux_obj_580 ~= nil then
            __lux_val_581 = __lux_obj_580.material
          end
          local __lux_tmp_582 = __lux_val_581
          if __lux_tmp_582 == nil then
            __lux_tmp_582 = __lux_module_1.atlasMat
          end
          material = __lux_tmp_582
        end
      end
      local __lux_tmp_583 = not __lux_module_1.isMaterialOK(material)
      if not __lux_tmp_583 then
        __lux_tmp_583 = __lux_module_1.renderSetMaterial == nil
      end
      local __lux_tmp_584 = __lux_tmp_583
      if not __lux_tmp_584 then
        __lux_tmp_584 = __lux_module_1.meshBegin == nil
      end
      local __lux_tmp_585 = __lux_tmp_584
      if not __lux_tmp_585 then
        __lux_tmp_585 = __lux_module_1.meshEnd == nil
      end
      local __lux_tmp_586 = __lux_tmp_585
      if not __lux_tmp_586 then
        __lux_tmp_586 = __lux_module_1.textBatchVertex == nil
      end
      if __lux_tmp_586 then
        for _, record in ipairs(batch) do
          __lux_module_1.blitEntry(record.__mgfxTextEntry, record, stats)
        end
        return false
      end
      if fx then
        material:SetTexture("$basetexture", firstEntry.page.rt)
        do
          local __lux_tmp_587 = firstEntry.atlasW
          if __lux_tmp_587 == nil then
            __lux_tmp_587 = firstEntry.w
          end
          local __lux_tmp_588 = firstEntry.atlasH
          if __lux_tmp_588 == nil then
            __lux_tmp_588 = firstEntry.h
          end
          __lux_module_1.setupTextComposeMaterial(
            material,
            firstEntry,
            firstEntry.slotX / firstEntry.page.w,
            firstEntry.slotY / firstEntry.page.h,
            (firstEntry.slotX + __lux_tmp_587) / firstEntry.page.w,
            (firstEntry.slotY + __lux_tmp_588) / firstEntry.page.h
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
        local __lux_tmp_589 = stats
        if __lux_tmp_589 == nil then
          __lux_tmp_589 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_589, "textComposedBlits", #batch)
      end
      do
        local __lux_tmp_590 = stats
        if __lux_tmp_590 == nil then
          __lux_tmp_590 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_590, "textComposedDraws", #batch)
      end
      if fx then
        do
          local __lux_tmp_591 = stats
          if __lux_tmp_591 == nil then
            __lux_tmp_591 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_591, "textShaderDraws")
        end
        do
          local __lux_tmp_592 = stats
          if __lux_tmp_592 == nil then
            __lux_tmp_592 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_592, "textComposedFxDraws", #batch)
        end
      else
        do
          local __lux_tmp_593 = stats
          if __lux_tmp_593 == nil then
            __lux_tmp_593 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_593, "textComposedFaceDraws", #batch)
        end
      end
      do
        local __lux_tmp_594 = stats
        if __lux_tmp_594 == nil then
          __lux_tmp_594 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_594, "textComposedBatchDraws")
      end
      do
        local __lux_tmp_595 = stats
        if __lux_tmp_595 == nil then
          __lux_tmp_595 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_595, "textComposedBatchedRecords", #batch)
      end
      return true
    end
    __lux_module_1.queueTextComposeBatch = function(batches, order, entry, record)
      local key = __lux_module_1.textBatchKey(entry, record)
      local __lux_tmp_596 = key == nil
      if not __lux_tmp_596 then
        __lux_tmp_596 = not __lux_module_1.isMaterialOK(__lux_module_1.materials.text_compose)
      end
      if __lux_tmp_596 then
        return false
      end
      local contentX
      do
        local __lux_tmp_597 = record.x
        if __lux_tmp_597 == nil then
          __lux_tmp_597 = 0
        end
        contentX = __lux_tmp_597 - entry.contentW * __lux_module_1.alignFactor(record.alignX)
      end
      local contentY
      do
        local __lux_tmp_598 = record.y
        if __lux_tmp_598 == nil then
          __lux_tmp_598 = 0
        end
        contentY = __lux_tmp_598 - entry.contentH * __lux_module_1.alignFactor(record.alignY, true)
      end
      local x = contentX - entry.originX
      local y = contentY - entry.originY
      x, y = __lux_module_1.snapTextPos(x, y, record.style)
      local color
      do
        local __lux_tmp_599 = record.color
        if __lux_tmp_599 == nil then
          __lux_tmp_599 = __lux_module_1.white
        end
        color = __lux_module_1.style.asColor(__lux_module_1.fillForRecord(record), __lux_tmp_599)
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
      local __lux_tmp_600 = order == nil
      if not __lux_tmp_600 then
        __lux_tmp_600 = #order == 0
      end
      if __lux_tmp_600 then
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
          local __lux_tmp_601 = stats
          if __lux_tmp_601 == nil then
            __lux_tmp_601 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_601, "textComposedEvicts")
        end
        __lux_module_1.clearComposedCache()
        do
          local __lux_tmp_602 = records
          if __lux_tmp_602 == nil then
            __lux_tmp_602 = {}
          end
          for _, record in ipairs(__lux_tmp_602) do
            record.__mgfxTextEntry = nil
          end
        end
      end
      __lux_module_1.bakesThisFrame = 0
      local composeRequested = __lux_module_1.prepareTextRoutes(records)
      do
        local __lux_tmp_603 = stats
        if __lux_tmp_603 == nil then
          __lux_tmp_603 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_603, "textComposedRequests", composeRequested)
      end
      if composeRequested > 0 then
        do
          local __lux_tmp_604 = stats
          if __lux_tmp_604 == nil then
            __lux_tmp_604 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_604, "textComposedBatches")
        end
      end
      local composerReady
      do
        local __lux_tmp_605 = composeRequested <= 0
        if not __lux_tmp_605 then
          __lux_tmp_605 = __lux_module_1.prewarmFlushRecords(records, stats)
        end
        composerReady = __lux_tmp_605
      end
      if composeRequested > 0 then
        if composerReady then
          do
            local __lux_tmp_606 = stats
            if __lux_tmp_606 == nil then
              __lux_tmp_606 = {}
            end
            __lux_module_1.statAdd(__lux_tmp_606, "textComposedReadyBatches")
          end
        end
      end
      local batches = {}
      local order = {}
      do
        local __lux_tmp_607 = records
        if __lux_tmp_607 == nil then
          __lux_tmp_607 = {}
        end
        for _, record in ipairs(__lux_tmp_607) do
          do
            local __lux_tmp_608 = stats
            if __lux_tmp_608 == nil then
              __lux_tmp_608 = {}
            end
            __lux_module_1.statAdd(__lux_tmp_608, "textDraws")
          end
          local route = record.__mgfxTextRoute
          if route == "native" then
            __lux_module_1.flushQueuedTextBatches(batches, order, stats)
            do
              local __lux_tmp_609 = stats
              if __lux_tmp_609 == nil then
                __lux_tmp_609 = {}
              end
              __lux_module_1.statAdd(__lux_tmp_609, "textNativeDraws")
            end
            __lux_module_1.drawNativePlainRecord(record)
          else
            local entry = record.__mgfxTextEntry
            local __lux_tmp_610 = entry ~= nil
            if __lux_tmp_610 then
              __lux_tmp_610 = entry.page ~= nil
            end
            local __lux_tmp_611 = __lux_tmp_610
            if __lux_tmp_611 then
              __lux_tmp_611 = entry.generation == entry.page.generation
            end
            if not __lux_tmp_611 then
              entry = __lux_module_1.entryFor(record, stats, false)
            end
            if entry ~= nil then
              local __lux_tmp_612 = composerReady
              if __lux_tmp_612 then
                __lux_tmp_612 = __lux_module_1.queueTextComposeBatch(batches, order, entry, record)
              end
              if __lux_tmp_612 then
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
      do
        local __lux_tmp_613 = deps
        if __lux_tmp_613 == nil then
          __lux_tmp_613 = {}
        end
        deps = __lux_tmp_613
      end
      __lux_module_1.configureTextRenderer(deps)
      __lux_module_1.atlasNamespace = __lux_module_1.nextAtlasNamespace()
      local owner
      do
        local __lux_tmp_614 = deps.M
        if __lux_tmp_614 == nil then
          local __lux_tmp_615 = deps.owner
          if __lux_tmp_615 == nil then
            __lux_tmp_615 = {}
          end
          __lux_tmp_614 = __lux_tmp_615
        end
        owner = __lux_tmp_614
      end
      local stats
      do
        local __lux_tmp_616 = deps.stats
        if __lux_tmp_616 == nil then
          local __lux_tmp_617 = owner.stats
          if __lux_tmp_617 == nil then
            __lux_tmp_617 = {}
          end
          __lux_tmp_616 = __lux_tmp_617
        end
        stats = __lux_tmp_616
      end
      owner.stats = stats
      local renderer = {}
      local styleStack = {}
      local immediateRecordBatch = {}
      __lux_module_1.resetRendererFrameStats(stats)
      renderer.RegisterFont = function(fontName, spec)
        local __lux_tmp_618 = spec
        if __lux_tmp_618 == nil then
          __lux_tmp_618 = {}
        end
        return __lux_module_1.registerFont(fontName, __lux_tmp_618)
      end
      renderer.DefineStyle = function(name, textStyle)
        if name == nil then
          return nil
        end
        local __lux_tmp_619 = textStyle
        if __lux_tmp_619 == nil then
          __lux_tmp_619 = {}
        end
        return __lux_module_1.defineStyle(
          __lux_module_1.toString(name),
          renderer.ResolveStyle(__lux_tmp_619)
        )
      end
      renderer.GetStyle = function(name)
        local __lux_tmp_620 = name
        if __lux_tmp_620 == nil then
          __lux_tmp_620 = ""
        end
        return __lux_module_1.getStyle(__lux_module_1.toString(__lux_tmp_620))
      end
      renderer.PushStyle = function(textStyle)
        do
          local __lux_tmp_621 = textStyle
          if __lux_tmp_621 == nil then
            __lux_tmp_621 = {}
          end
          styleStack[#styleStack + 1] = renderer.ResolveStyle(__lux_tmp_621)
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
        local __lux_tmp_622 = __lux_module_1.typeOf(textStyle) == "table"
        if __lux_tmp_622 then
          __lux_tmp_622 = textStyle[__lux_module_1.RESOLVED_STYLE_MARK] == true
        end
        if __lux_tmp_622 then
          return __lux_module_1.tableCopy(textStyle)
        end
        local resolved = {}
        for index = 1, #styleStack do
          __lux_module_1.copyStyleInto(resolved, styleStack[index])
        end
        do
          local __lux_tmp_623 = textStyle
          if __lux_tmp_623 == nil then
            __lux_tmp_623 = {}
          end
          __lux_module_1.copyStyleInto(resolved, __lux_tmp_623)
        end
        resolved[__lux_module_1.RESOLVED_STYLE_MARK] = true
        return resolved
      end
      renderer.MakeRecord = function(value, font, x, y, color, ax, ay, textStyle)
        local resolved
        do
          local __lux_tmp_624 = textStyle
          if __lux_tmp_624 == nil then
            __lux_tmp_624 = {}
          end
          resolved = renderer.ResolveStyle(__lux_tmp_624)
        end
        local __lux_tmp_625 = value
        if __lux_tmp_625 == nil then
          __lux_tmp_625 = ""
        end
        local __lux_tmp_626 = resolved.font
        if __lux_tmp_626 == nil then
          local __lux_tmp_627 = font
          if __lux_tmp_627 == nil then
            __lux_tmp_627 = "DermaDefault"
          end
          __lux_tmp_626 = __lux_tmp_627
        end
        local __lux_tmp_628 = __lux_module_1.toNumber(x)
        if __lux_tmp_628 == nil then
          __lux_tmp_628 = 0
        end
        local __lux_tmp_629 = __lux_module_1.toNumber(y)
        if __lux_tmp_629 == nil then
          __lux_tmp_629 = 0
        end
        local __lux_tmp_630
        if __lux_module_1.style.asColor ~= nil then
          do
            local __lux_tmp_631 = color
            if __lux_tmp_631 == nil then
              local __lux_tmp_632 = resolved.color
              if __lux_tmp_632 == nil then
                __lux_tmp_632 = resolved.fill
              end
              __lux_tmp_631 = __lux_tmp_632
            end
            __lux_tmp_630 = __lux_module_1.style.asColor(__lux_tmp_631, __lux_module_1.white)
          end
        else
          do
            local __lux_tmp_633 = color
            if __lux_tmp_633 == nil then
              local __lux_tmp_634 = resolved.color
              if __lux_tmp_634 == nil then
                __lux_tmp_634 = resolved.fill
              end
              __lux_tmp_633 = __lux_tmp_634
            end
            __lux_tmp_630 = __lux_module_1.style.colorOr(__lux_tmp_633, __lux_module_1.white)
          end
        end
        local __lux_tmp_635 = resolved.alignX
        if __lux_tmp_635 == nil then
          local __lux_tmp_636 = resolved.align
          if __lux_tmp_636 == nil then
            local __lux_tmp_637 = ax
            if __lux_tmp_637 == nil then
              __lux_tmp_637 = TEXT_ALIGN_LEFT
            end
            __lux_tmp_636 = __lux_tmp_637
          end
          __lux_tmp_635 = __lux_tmp_636
        end
        local __lux_tmp_638 = resolved.alignY
        if __lux_tmp_638 == nil then
          local __lux_tmp_639 = resolved.valign
          if __lux_tmp_639 == nil then
            local __lux_tmp_640 = ay
            if __lux_tmp_640 == nil then
              __lux_tmp_640 = TEXT_ALIGN_TOP
            end
            __lux_tmp_639 = __lux_tmp_640
          end
          __lux_tmp_638 = __lux_tmp_639
        end
        return {
          text = __lux_module_1.toString(__lux_tmp_625),
          font = __lux_tmp_626,
          x = __lux_tmp_628,
          y = __lux_tmp_629,
          color = __lux_tmp_630,
          alignX = __lux_tmp_635,
          alignY = __lux_tmp_638,
          style = resolved,
        }
      end
      renderer.NormalizeRecord = function(record)
        if record == nil then
          return nil
        end
        local resolved
        do
          local __lux_tmp_641 = record.style
          if __lux_tmp_641 == nil then
            __lux_tmp_641 = {}
          end
          resolved = renderer.ResolveStyle(__lux_tmp_641)
        end
        do
          local __lux_tmp_642 = record.text
          if __lux_tmp_642 == nil then
            local __lux_tmp_643 = record.value
            if __lux_tmp_643 == nil then
              __lux_tmp_643 = ""
            end
            __lux_tmp_642 = __lux_tmp_643
          end
          record.text = __lux_module_1.toString(__lux_tmp_642)
        end
        do
          local __lux_tmp_644 = resolved.font
          if __lux_tmp_644 == nil then
            local __lux_tmp_645 = record.font
            if __lux_tmp_645 == nil then
              __lux_tmp_645 = "DermaDefault"
            end
            __lux_tmp_644 = __lux_tmp_645
          end
          record.font = __lux_tmp_644
        end
        do
          local __lux_tmp_646 = __lux_module_1.toNumber(record.x)
          if __lux_tmp_646 == nil then
            __lux_tmp_646 = 0
          end
          record.x = __lux_tmp_646
        end
        do
          local __lux_tmp_647 = __lux_module_1.toNumber(record.y)
          if __lux_tmp_647 == nil then
            __lux_tmp_647 = 0
          end
          record.y = __lux_tmp_647
        end
        do
          local __lux_tmp_648
          if __lux_module_1.style.asColor ~= nil then
            do
              local __lux_tmp_649 = record.color
              if __lux_tmp_649 == nil then
                local __lux_tmp_650 = resolved.color
                if __lux_tmp_650 == nil then
                  __lux_tmp_650 = resolved.fill
                end
                __lux_tmp_649 = __lux_tmp_650
              end
              __lux_tmp_648 = __lux_module_1.style.asColor(__lux_tmp_649, __lux_module_1.white)
            end
          else
            do
              local __lux_tmp_651 = record.color
              if __lux_tmp_651 == nil then
                local __lux_tmp_652 = resolved.color
                if __lux_tmp_652 == nil then
                  __lux_tmp_652 = resolved.fill
                end
                __lux_tmp_651 = __lux_tmp_652
              end
              __lux_tmp_648 = __lux_module_1.style.colorOr(__lux_tmp_651, __lux_module_1.white)
            end
          end
          record.color = __lux_tmp_648
        end
        do
          local __lux_tmp_653 = resolved.alignX
          if __lux_tmp_653 == nil then
            local __lux_tmp_654 = resolved.align
            if __lux_tmp_654 == nil then
              local __lux_tmp_655 = record.alignX
              if __lux_tmp_655 == nil then
                local __lux_tmp_656 = record.ax
                if __lux_tmp_656 == nil then
                  __lux_tmp_656 = TEXT_ALIGN_LEFT
                end
                __lux_tmp_655 = __lux_tmp_656
              end
              __lux_tmp_654 = __lux_tmp_655
            end
            __lux_tmp_653 = __lux_tmp_654
          end
          record.alignX = __lux_tmp_653
        end
        do
          local __lux_tmp_657 = resolved.alignY
          if __lux_tmp_657 == nil then
            local __lux_tmp_658 = resolved.valign
            if __lux_tmp_658 == nil then
              local __lux_tmp_659 = record.alignY
              if __lux_tmp_659 == nil then
                local __lux_tmp_660 = record.ay
                if __lux_tmp_660 == nil then
                  __lux_tmp_660 = TEXT_ALIGN_TOP
                end
                __lux_tmp_659 = __lux_tmp_660
              end
              __lux_tmp_658 = __lux_tmp_659
            end
            __lux_tmp_657 = __lux_tmp_658
          end
          record.alignY = __lux_tmp_657
        end
        record.style = resolved
        return record
      end
      renderer.Flush = function(records, reason)
        do
          local normalized
          do
            local __lux_tmp_661 = records
            if __lux_tmp_661 == nil then
              __lux_tmp_661 = {}
            end
            normalized = __lux_tmp_661
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
          local __lux_tmp_662 = textStyle
          if __lux_tmp_662 == nil then
            __lux_tmp_662 = {}
          end
          resolved = renderer.ResolveStyle(__lux_tmp_662)
        end
        local resolvedFont
        do
          local __lux_tmp_663 = resolved.font
          if __lux_tmp_663 == nil then
            local __lux_tmp_664 = font
            if __lux_tmp_664 == nil then
              __lux_tmp_664 = "DermaDefault"
            end
            __lux_tmp_663 = __lux_tmp_664
          end
          resolvedFont = __lux_tmp_663
        end
        local lines
        do
          local __lux_tmp_665 = __lux_module_1.toNumber(w)
          if __lux_tmp_665 == nil then
            __lux_tmp_665 = 0
          end
          lines = __lux_module_1.wrapText(value, resolvedFont, __lux_tmp_665, resolved.overflow)
        end
        local nativeFont, alias, oversample = __lux_module_1.nativeFor(resolvedFont, resolved)
        local lineHeight = __lux_module_1.lineHeightFor(nativeFont, alias, resolved, oversample)
        local totalH = #lines * lineHeight
        local startY
        do
          local __lux_tmp_666 = __lux_module_1.toNumber(y)
          if __lux_tmp_666 == nil then
            __lux_tmp_666 = 0
          end
          local __lux_tmp_667 = __lux_module_1.toNumber(h)
          if __lux_tmp_667 == nil then
            __lux_tmp_667 = totalH
          end
          local __lux_tmp_668 = resolved.alignY
          if __lux_tmp_668 == nil then
            local __lux_tmp_669 = resolved.valign
            if __lux_tmp_669 == nil then
              __lux_tmp_669 = TEXT_ALIGN_TOP
            end
            __lux_tmp_668 = __lux_tmp_669
          end
          startY = __lux_tmp_666 + (__lux_tmp_667 - totalH) * __lux_module_1.alignFactor(__lux_tmp_668, true)
        end
        local ax
        do
          local __lux_tmp_670 = resolved.alignX
          if __lux_tmp_670 == nil then
            local __lux_tmp_671 = resolved.align
            if __lux_tmp_671 == nil then
              __lux_tmp_671 = TEXT_ALIGN_LEFT
            end
            __lux_tmp_670 = __lux_tmp_671
          end
          ax = __lux_tmp_670
        end
        local tx
        do
          local __lux_tmp_672 = __lux_module_1.toNumber(x)
          if __lux_tmp_672 == nil then
            __lux_tmp_672 = 0
          end
          local __lux_tmp_673 = __lux_module_1.toNumber(w)
          if __lux_tmp_673 == nil then
            __lux_tmp_673 = 0
          end
          tx = __lux_tmp_672 + __lux_tmp_673 * __lux_module_1.alignFactor(ax)
        end
        local lineStyle = __lux_module_1.textBoxLineStyle(resolved)
        for index = 1, #lines do
          do
            local __lux_tmp_674 = lineStyle.color
            if __lux_tmp_674 == nil then
              __lux_tmp_674 = lineStyle.fill
            end
            renderer.DrawTextImmediate(
              lines[index],
              resolvedFont,
              tx,
              startY + (index - 1) * lineHeight,
              __lux_tmp_674,
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
        local __lux_tmp_675 = textStyle
        if __lux_tmp_675 == nil then
          __lux_tmp_675 = {}
        end
        return __lux_module_1.measureBox(value, font, w, renderer.ResolveStyle(__lux_tmp_675))
      end
      renderer.PrewarmText = function(value, font, textStyle)
        local record
        do
          local __lux_tmp_676 = textStyle
          if __lux_tmp_676 == nil then
            __lux_tmp_676 = {}
          end
          record = renderer.MakeRecord(
            value,
            font,
            0,
            0,
            nil,
            TEXT_ALIGN_LEFT,
            TEXT_ALIGN_TOP,
            __lux_tmp_676
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
          local __lux_tmp_677 = textStyle
          if __lux_tmp_677 == nil then
            __lux_tmp_677 = {}
          end
          record = renderer.MakeRecord(
            value,
            font,
            0,
            0,
            nil,
            TEXT_ALIGN_LEFT,
            TEXT_ALIGN_TOP,
            __lux_tmp_677
          )
        end
        local nativeFont, alias, oversample = __lux_module_1.nativeFor(record.font, record.style)
        local layout = __lux_module_1.layoutFor(record.text, record.font, record.style)
        local needsComposed = __lux_module_1.recordNeedsComposedEntry(record)
        local __lux_tmp_678
        if needsComposed then
          __lux_tmp_678 = "__composed"
        else
          __lux_tmp_678 = "__native"
        end
        local __lux_tmp_679
        if needsComposed then
          __lux_tmp_679 = "composed"
        else
          __lux_tmp_679 = "native"
        end
        local __lux_tmp_680
        if needsComposed then
          __lux_tmp_680 = "__composed"
        else
          __lux_tmp_680 = "__native"
        end
        local __lux_tmp_681
        if needsComposed then
          __lux_tmp_681 = "compose"
        else
          __lux_tmp_681 = "native"
        end
        local __lux_tmp_682 = alias.mode
        if __lux_tmp_682 == nil then
          __lux_tmp_682 = "native"
        end
        return {
          text = record.text,
          font = record.font,
          nativeFont = nativeFont,
          atlasKey = __lux_tmp_678,
          kind = __lux_tmp_679,
          routeAtlas = __lux_tmp_680,
          routeKind = __lux_tmp_681,
          mode = __lux_tmp_682,
          missing = {},
          w = layout.w,
          h = layout.h,
          oversample = oversample,
        }
      end
      renderer.Status = function()
        local __lux_obj_683 = __lux_module_1.atlas
        local __lux_val_684 = nil
        if __lux_obj_683 ~= nil then
          __lux_val_684 = __lux_obj_683.rt
        end
        local __lux_obj_685 = __lux_module_1.atlas
        local __lux_val_686 = nil
        if __lux_obj_685 ~= nil then
          __lux_val_686 = __lux_obj_685.w
        end
        local __lux_tmp_687 = __lux_val_686
        if __lux_tmp_687 == nil then
          __lux_tmp_687 = 0
        end
        local __lux_obj_688 = __lux_module_1.atlas
        local __lux_val_689 = nil
        if __lux_obj_688 ~= nil then
          __lux_val_689 = __lux_obj_688.h
        end
        local __lux_tmp_690 = __lux_val_689
        if __lux_tmp_690 == nil then
          __lux_tmp_690 = 0
        end
        local __lux_tmp_691 = stats.textDraws
        if __lux_tmp_691 == nil then
          __lux_tmp_691 = 0
        end
        local __lux_tmp_692 = stats.textNativeDraws
        if __lux_tmp_692 == nil then
          __lux_tmp_692 = 0
        end
        local __lux_tmp_693 = stats.textShaderDraws
        if __lux_tmp_693 == nil then
          __lux_tmp_693 = 0
        end
        local __lux_tmp_694 = stats.textComposedDraws
        if __lux_tmp_694 == nil then
          __lux_tmp_694 = 0
        end
        local __lux_tmp_695 = stats.textComposedBakes
        if __lux_tmp_695 == nil then
          __lux_tmp_695 = 0
        end
        local __lux_tmp_696 = stats.textComposedBlits
        if __lux_tmp_696 == nil then
          __lux_tmp_696 = 0
        end
        local __lux_tmp_697 = stats.textMeasureHits
        if __lux_tmp_697 == nil then
          __lux_tmp_697 = 0
        end
        local __lux_tmp_698 = stats.textMeasureMisses
        if __lux_tmp_698 == nil then
          __lux_tmp_698 = 0
        end
        return {
          mode = "native+composer",
          fontCount = __lux_module_1.countTable(__lux_module_1.fonts),
          styleCount = __lux_module_1.countTable(__lux_module_1.styles),
          styleStackDepth = #styleStack,
          cacheSize = __lux_module_1.measureOrderCount,
          composedEnabled = __lux_module_1.textComposedEnabled(),
          composedAtlas = __lux_val_684,
          composedAtlasW = __lux_tmp_687,
          composedAtlasH = __lux_tmp_690,
          composedAtlasPages = #__lux_module_1.atlasPages,
          composedAtlasMaxPages = __lux_module_1.MAX_ATLAS_PAGES,
          composedAtlasFill = __lux_module_1.atlasFillRatio(),
          composedEntries = __lux_module_1.composedCacheCount,
          composedFailed = __lux_module_1.atlasFailed,
          draws = __lux_tmp_691,
          nativeDraws = __lux_tmp_692,
          shaderDraws = __lux_tmp_693,
          composedDraws = __lux_tmp_694,
          composedBakes = __lux_tmp_695,
          composedBlits = __lux_tmp_696,
          measureHits = __lux_tmp_697,
          measureMisses = __lux_tmp_698,
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
        do
          local __lux_tmp_699 = __lux_module_1.debugViewMat
          if __lux_tmp_699 == nil then
            __lux_tmp_699 = __lux_module_1.createMaterial(
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
          __lux_module_1.debugViewMat = __lux_tmp_699
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
          local __lux_tmp_700 = page.rt ~= nil
          if __lux_tmp_700 then
            __lux_tmp_700 = __lux_module_1.debugViewMat ~= nil
          end
          local __lux_tmp_701 = __lux_tmp_700
          if __lux_tmp_701 then
            __lux_tmp_701 = __lux_module_1.surfaceSetMaterial ~= nil
          end
          local __lux_tmp_702 = __lux_tmp_701
          if __lux_tmp_702 then
            __lux_tmp_702 = __lux_module_1.surfaceDrawTexturedRect ~= nil
          end
          if __lux_tmp_702 then
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
    local __lux_import_703 = __lux_import("lux/mgfx/frame#client")
    local frameImport = __lux_import_703
    __lux_module_1.frame = frameImport
    __lux_module_1.queuedTextBatch = function(owner, records)
      local state
      do
        local __lux_obj_704 = owner
        local __lux_val_705 = nil
        if __lux_obj_704 ~= nil then
          __lux_val_705 = __lux_obj_704._FrameState
        end
        state = __lux_val_705
      end
      local __lux_tmp_706 = state == nil
      if not __lux_tmp_706 then
        __lux_tmp_706 = state.commandStack == nil
      end
      local __lux_tmp_707 = __lux_tmp_706
      if not __lux_tmp_707 then
        __lux_tmp_707 = state.replaying
      end
      if __lux_tmp_707 then
        return false
      end
      state.commandStack[#state.commandStack + 1] = { op = "DrawTextBatch", records = records }
      do
        local __lux_tmp_708 = owner.stats
        if __lux_tmp_708 == nil then
          __lux_tmp_708 = {}
        end
        owner.stats = __lux_tmp_708
      end
      do
        local __lux_tmp_709 = owner.stats.textQueuedBatches
        if __lux_tmp_709 == nil then
          __lux_tmp_709 = 0
        end
        owner.stats.textQueuedBatches = __lux_tmp_709 + 1
      end
      do
        local __lux_tmp_710 = owner.stats.textQueuedRecords
        if __lux_tmp_710 == nil then
          __lux_tmp_710 = 0
        end
        local __lux_tmp_711 = records
        if __lux_tmp_711 == nil then
          __lux_tmp_711 = {}
        end
        owner.stats.textQueuedRecords = __lux_tmp_710 + #__lux_tmp_711
      end
      return true
    end
    __lux_module_1.queuedTextRecord = function(owner, record)
      local state
      do
        local __lux_obj_712 = owner
        local __lux_val_713 = nil
        if __lux_obj_712 ~= nil then
          __lux_val_713 = __lux_obj_712._FrameState
        end
        state = __lux_val_713
      end
      local __lux_tmp_714 = state == nil
      if not __lux_tmp_714 then
        __lux_tmp_714 = state.commandStack == nil
      end
      local __lux_tmp_715 = __lux_tmp_714
      if not __lux_tmp_715 then
        __lux_tmp_715 = state.replaying
      end
      if __lux_tmp_715 then
        return false
      end
      local stack = state.commandStack
      local last = stack[#stack]
      local __lux_tmp_716 = last ~= nil
      if __lux_tmp_716 then
        __lux_tmp_716 = last.op == "DrawTextBatch"
      end
      if __lux_tmp_716 then
        last.records[#last.records + 1] = record
      else
        stack[#stack + 1] = { op = "DrawTextBatch", records = { record } }
        do
          local __lux_tmp_717 = owner.stats
          if __lux_tmp_717 == nil then
            __lux_tmp_717 = {}
          end
          owner.stats = __lux_tmp_717
        end
        do
          local __lux_tmp_718 = owner.stats.textQueuedBatches
          if __lux_tmp_718 == nil then
            __lux_tmp_718 = 0
          end
          owner.stats.textQueuedBatches = __lux_tmp_718 + 1
        end
      end
      do
        local __lux_tmp_719 = owner.stats
        if __lux_tmp_719 == nil then
          __lux_tmp_719 = {}
        end
        owner.stats = __lux_tmp_719
      end
      do
        local __lux_tmp_720 = owner.stats.textQueuedRecords
        if __lux_tmp_720 == nil then
          __lux_tmp_720 = 0
        end
        owner.stats.textQueuedRecords = __lux_tmp_720 + 1
      end
      return true
    end
    __lux_module_1.queuedTextBox = function(owner, textValue, font, x, y, w, h, textStyle)
      local state
      do
        local __lux_obj_721 = owner
        local __lux_val_722 = nil
        if __lux_obj_721 ~= nil then
          __lux_val_722 = __lux_obj_721._FrameState
        end
        state = __lux_val_722
      end
      local __lux_tmp_723 = state == nil
      if not __lux_tmp_723 then
        __lux_tmp_723 = state.commandStack == nil
      end
      local __lux_tmp_724 = __lux_tmp_723
      if not __lux_tmp_724 then
        __lux_tmp_724 = state.replaying
      end
      if __lux_tmp_724 then
        return false
      end
      state.commandStack[#state.commandStack + 1] = {
        op = "DrawTextBox",
        text = textValue,
        font = font,
        x = x,
        y = y,
        w = w,
        h = h,
        style = textStyle,
      }
      return true
    end
    __lux_module_1.install = function(owner)
      do
        local __lux_tmp_725 = owner.stats
        if __lux_tmp_725 == nil then
          __lux_tmp_725 = {}
        end
        owner.stats = __lux_tmp_725
      end
      local materialState
      do
        local __lux_tmp_726 = owner._MaterialState
        if __lux_tmp_726 == nil then
          __lux_tmp_726 = {}
        end
        materialState = __lux_tmp_726
      end
      local renderer
      do
        local __lux_tmp_727 = owner._Materials
        if __lux_tmp_727 == nil then
          local __lux_tmp_728 = materialState.materials
          if __lux_tmp_728 == nil then
            __lux_tmp_728 = {}
          end
          __lux_tmp_727 = __lux_tmp_728
        end
        local __lux_tmp_729 = owner.MaterialOK
        if __lux_tmp_729 == nil then
          __lux_tmp_729 = materialState.matOK
        end
        renderer = __lux_module_1.createTextRenderer(
          {
            M = owner,
            owner = owner,
            stats = owner.stats,
            materials = __lux_tmp_727,
            createPageTextMaterials = materialState.CreatePageTextMaterials,
            matOK = __lux_tmp_729,
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
      owner.TextBatchEx = function(records, reason)
        local __lux_tmp_730 = records
        if __lux_tmp_730 == nil then
          __lux_tmp_730 = {}
        end
        if __lux_module_1.queuedTextBatch(owner, __lux_tmp_730) then
          return
        end
        local __lux_tmp_731 = reason
        if __lux_tmp_731 == nil then
          __lux_tmp_731 = "batch"
        end
        return renderer.Flush(records, __lux_tmp_731)
      end
      owner.Text = function(value, font, x, y, color, ax, ay)
        return owner.TextEx(value, font, x, y, color, ax, ay, nil)
      end
      owner.TextEx = function(value, font, x, y, color, ax, ay, textStyle)
        local record
        do
          local __lux_tmp_732 = textStyle
          if __lux_tmp_732 == nil then
            __lux_tmp_732 = {}
          end
          record = renderer.MakeRecord(value, font, x, y, color, ax, ay, __lux_tmp_732)
        end
        if __lux_module_1.queuedTextRecord(owner, record) then
          return
        end
        return renderer.DrawRecordImmediate(record)
      end
      owner.TextBox = function(value, font, x, y, w, h, color, alignX, alignY)
        if alignX == nil then
          alignX = TEXT_ALIGN_LEFT
        end
        if alignY == nil then
          alignY = TEXT_ALIGN_TOP
        end
        return owner.TextBoxEx(
          value,
          font,
          x,
          y,
          w,
          h,
          { color = color, alignX = alignX, alignY = alignY }
        )
      end
      owner.TextBoxEx = function(value, font, x, y, w, h, textStyle)
        local resolved
        do
          local __lux_tmp_733 = textStyle
          if __lux_tmp_733 == nil then
            __lux_tmp_733 = {}
          end
          resolved = renderer.ResolveStyle(__lux_tmp_733)
        end
        if __lux_module_1.queuedTextBox(owner, value, font, x, y, w, h, resolved) then
          return
        end
        return renderer.DrawTextBoxImmediate(value, font, x, y, w, h, resolved)
      end
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
