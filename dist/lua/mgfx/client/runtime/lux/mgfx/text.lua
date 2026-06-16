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
    __lux_module_1.drawSimpleText = _G.draw.SimpleText
    __lux_module_1.drawDrawText = _G.draw.DrawText
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
    do
      local __lux_obj_45 = surface
      local __lux_val_46 = nil
      if __lux_obj_45 ~= nil then
        __lux_val_46 = __lux_obj_45.DrawPoly
      end
      __lux_module_1.surfaceDrawPoly = __lux_val_46
    end
    __lux_module_1.surfaceDrawRect = surface.DrawRect
    __lux_module_1.surfaceDrawText = surface.DrawText
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
      local __lux_tmp_57 = color_white
      if __lux_tmp_57 == nil then
        __lux_tmp_57 = __lux_module_1.makeColor(255, 255, 255, 255)
      end
      __lux_module_1.white = __lux_tmp_57
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
    __lux_module_1.textComposerCapable = function()
      local __lux_tmp_59 = __lux_module_1.renderClear ~= nil
      if __lux_tmp_59 then
        __lux_tmp_59 = __lux_module_1.renderPushRenderTarget ~= nil
      end
      local __lux_tmp_60 = __lux_tmp_59
      if __lux_tmp_60 then
        __lux_tmp_60 = __lux_module_1.renderPopRenderTarget ~= nil
      end
      local __lux_tmp_61 = __lux_tmp_60
      if __lux_tmp_61 then
        __lux_tmp_61 = __lux_module_1.camStart2D ~= nil
      end
      local __lux_tmp_62 = __lux_tmp_61
      if __lux_tmp_62 then
        __lux_tmp_62 = __lux_module_1.camEnd2D ~= nil
      end
      return __lux_tmp_62
    end
    __lux_module_1.configureTextRenderer = function(deps)
      do
        local __lux_tmp_63 = deps
        if __lux_tmp_63 == nil then
          __lux_tmp_63 = {}
        end
        deps = __lux_tmp_63
      end
      do
        local __lux_tmp_64 = deps.materials
        if __lux_tmp_64 == nil then
          local __lux_tmp_65 = deps.Materials
          if __lux_tmp_65 == nil then
            local __lux_tmp_66 = __lux_module_1.materials
            if __lux_tmp_66 == nil then
              __lux_tmp_66 = {}
            end
            __lux_tmp_65 = __lux_tmp_66
          end
          __lux_tmp_64 = __lux_tmp_65
        end
        __lux_module_1.materials = __lux_tmp_64
      end
      do
        local __lux_tmp_67 = deps.createPageTextMaterials
        if __lux_tmp_67 == nil then
          local __lux_tmp_68 = deps.CreatePageTextMaterials
          if __lux_tmp_68 == nil then
            __lux_tmp_68 = __lux_module_1.createPageTextMaterials
          end
          __lux_tmp_67 = __lux_tmp_68
        end
        __lux_module_1.createPageTextMaterials = __lux_tmp_67
      end
      do
        local __lux_tmp_69 = deps.profiler
        if __lux_tmp_69 == nil then
          local __lux_tmp_70 = deps.Profiler
          if __lux_tmp_70 == nil then
            __lux_tmp_70 = __lux_module_1.profiler
          end
          __lux_tmp_69 = __lux_tmp_70
        end
        __lux_module_1.profiler = __lux_tmp_69
      end
      do
        local __lux_tmp_71 = deps.restoreScissor
        if __lux_tmp_71 == nil then
          local __lux_tmp_72 = deps.RestoreScissor
          if __lux_tmp_72 == nil then
            local __lux_tmp_73 = __lux_module_1.restoreScissor
            if __lux_tmp_73 == nil then
              __lux_tmp_73 = function()
        end
            end
            __lux_tmp_72 = __lux_tmp_73
          end
          __lux_tmp_71 = __lux_tmp_72
        end
        __lux_module_1.restoreScissor = __lux_tmp_71
      end
      do
        local __lux_tmp_74 = deps.gradientLutForFill
        if __lux_tmp_74 == nil then
          local __lux_tmp_75 = deps.GradientLutForFill
          if __lux_tmp_75 == nil then
            local __lux_tmp_76 = __lux_module_1.gradientLutForFill
            if __lux_tmp_76 == nil then
              __lux_tmp_76 = function()
          return nil
        end
            end
            __lux_tmp_75 = __lux_tmp_76
          end
          __lux_tmp_74 = __lux_tmp_75
        end
        __lux_module_1.gradientLutForFill = __lux_tmp_74
      end
      do
        local __lux_tmp_77 = deps.matOK
        if __lux_tmp_77 == nil then
          local __lux_tmp_78 = deps.MaterialOK
          if __lux_tmp_78 == nil then
            __lux_tmp_78 = __lux_module_1.materialOK
          end
          __lux_tmp_77 = __lux_tmp_78
        end
        __lux_module_1.materialOK = __lux_tmp_77
      end
      return true
    end
    __lux_module_1.isMaterialOK = function(material)
      local __lux_tmp_79 = __lux_module_1.materialOK ~= nil
      if __lux_tmp_79 then
        __lux_tmp_79 = __lux_module_1.materialOK(material)
      end
      return __lux_tmp_79
    end
    __lux_module_1.textChars = function(text)
      local out = {}
      local value
      do
        local __lux_tmp_80 = text
        if __lux_tmp_80 == nil then
          __lux_tmp_80 = ""
        end
        value = __lux_module_1.toString(__lux_tmp_80)
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
      local __lux_tmp_81 = #out == 0
      if __lux_tmp_81 then
        __lux_tmp_81 = value ~= ""
      end
      if __lux_tmp_81 then
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
        local __lux_tmp_82 = t
        if __lux_tmp_82 == nil then
          __lux_tmp_82 = {}
        end
        for key, _ in pairs(__lux_tmp_82) do
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
        local __lux_tmp_83 = key ~= "extends"
        if __lux_tmp_83 then
          __lux_tmp_83 = key ~= "base"
        end
        local __lux_tmp_84 = __lux_tmp_83
        if __lux_tmp_84 then
          local __lux_tmp_85 = __lux_module_1.typeOf(key) == "string"
          if __lux_tmp_85 then
            __lux_tmp_85 = __lux_module_1.stringSub(key, 1, 6) == "__mgfx"
          end
          __lux_tmp_84 = not __lux_tmp_85
        end
        if __lux_tmp_84 then
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
        local __lux_tmp_86 = fallback
        if __lux_tmp_86 == nil then
          __lux_tmp_86 = 500
        end
        return __lux_tmp_86
      end
      local __lux_tmp_87 = weight > 0
      if __lux_tmp_87 then
        __lux_tmp_87 = weight <= 10
      end
      if __lux_tmp_87 then
        do
          local __lux_tmp_88
          if weight <= 1 then
            __lux_tmp_88 = 850
          else
            __lux_tmp_88 = weight * 100
          end
          weight = __lux_tmp_88
        end
      end
      return __lux_module_1.mathClamp(__lux_module_1.mathFloor(weight + 0.5), 100, 1000)
    end
    __lux_module_1.normalizeOversample = function(value)
      local nextValue
      do
        local __lux_tmp_89 = __lux_module_1.toNumber(value)
        if __lux_tmp_89 == nil then
          __lux_tmp_89 = 1
        end
        nextValue = __lux_tmp_89
      end
      return __lux_module_1.mathClamp(nextValue, 1, 4)
    end
    __lux_module_1.oversampleForSize = function(size)
      local nextSize
      do
        local __lux_tmp_90 = __lux_module_1.toNumber(size)
        if __lux_tmp_90 == nil then
          __lux_tmp_90 = 16
        end
        nextSize = __lux_tmp_90
      end
      if nextSize >= 28 then
        return 3
      end
      return 2
    end
    __lux_module_1.fontKey = function(face, size, weight, italic)
      local __lux_tmp_91 = face
      if __lux_tmp_91 == nil then
        __lux_tmp_91 = ""
      end
      local __lux_tmp_92 = size
      if __lux_tmp_92 == nil then
        __lux_tmp_92 = ""
      end
      local __lux_tmp_93 = weight
      if __lux_tmp_93 == nil then
        __lux_tmp_93 = ""
      end
      local __lux_tmp_94
      if italic == true then
        __lux_tmp_94 = "i"
      else
        __lux_tmp_94 = "n"
      end
      return __lux_module_1.tableConcat(
        {
          __lux_module_1.toString(__lux_tmp_91),
          __lux_module_1.toString(__lux_tmp_92),
          __lux_module_1.toString(__lux_tmp_93),
          __lux_tmp_94,
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
          local __lux_tmp_95 = face
          if __lux_tmp_95 == nil then
            __lux_tmp_95 = "DermaDefault"
          end
          local __lux_tmp_96 = size
          if __lux_tmp_96 == nil then
            __lux_tmp_96 = 16
          end
          __lux_module_1.surfaceCreateFont(
            name,
            {
              font = __lux_tmp_95,
              size = __lux_module_1.mathFloor(__lux_tmp_96),
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
        local __lux_tmp_97 = spec
        if __lux_tmp_97 == nil then
          __lux_tmp_97 = {}
        end
        input = __lux_tmp_97
      end
      local face
      do
        local __lux_tmp_98 = input.face
        if __lux_tmp_98 == nil then
          __lux_tmp_98 = input.font
        end
        face = __lux_tmp_98
      end
      local size = __lux_module_1.toNumber(input.size)
      local weight = __lux_module_1.toNumber(input.weight)
      local sourceFont
      do
        local __lux_tmp_99 = input.sourceFont
        if __lux_tmp_99 == nil then
          __lux_tmp_99 = input.nativeFont
        end
        sourceFont = __lux_tmp_99
      end
      local oversample = 1
      if face ~= nil then
        do
          local __lux_tmp_100 = size
          if __lux_tmp_100 == nil then
            __lux_tmp_100 = 16
          end
          size = __lux_tmp_100
        end
        do
          local __lux_tmp_101 = input.oversample
          if __lux_tmp_101 == nil then
            __lux_tmp_101 = __lux_module_1.oversampleForSize(size)
          end
          oversample = __lux_module_1.normalizeOversample(__lux_tmp_101)
        end
        do
          local __lux_tmp_102
          if face == __lux_module_1.DEFAULT_CJK_FACE then
            __lux_tmp_102 = 400
          else
            __lux_tmp_102 = 500
          end
          weight = __lux_module_1.normalizeFontWeight(weight, __lux_tmp_102)
        end
        sourceFont = __lux_module_1.ensureNativeFont(face, size * oversample, weight, input.italic == true)
      else
        do
          local __lux_tmp_103 = sourceFont
          if __lux_tmp_103 == nil then
            __lux_tmp_103 = name
          end
          sourceFont = __lux_tmp_103
        end
      end
      do
        local __lux_tmp_104
        if face ~= nil then
          __lux_tmp_104 = "alias"
        else
          __lux_tmp_104 = "native"
        end
        local __lux_tmp_105 = input.syntheticWeight == true
        if not __lux_tmp_105 then
          __lux_tmp_105 = input.allowSyntheticWeight == true
        end
        local __lux_tmp_106 = input.lineHeight
        if __lux_tmp_106 == nil then
          __lux_tmp_106 = input.lineheight
        end
        local __lux_tmp_107 = input.tracking
        if __lux_tmp_107 == nil then
          __lux_tmp_107 = input.letterSpacing
        end
        local __lux_tmp_108 = __lux_module_1.toNumber(__lux_tmp_107)
        if __lux_tmp_108 == nil then
          __lux_tmp_108 = 0
        end
        local __lux_tmp_109
        if face ~= nil then
          __lux_tmp_109 = "__composed"
        else
          __lux_tmp_109 = "__native"
        end
        __lux_module_1.fonts[name] = {
          mode = __lux_tmp_104,
          sourceFont = sourceFont,
          face = face,
          size = size,
          weight = weight,
          oversample = oversample,
          syntheticWeight = __lux_tmp_105,
          lineHeight = __lux_module_1.toNumber(__lux_tmp_106),
          tracking = __lux_tmp_108,
          atlas = __lux_tmp_109,
        }
      end
      return true
    end
    __lux_module_1.aliasFor = function(font)
      local key
      do
        local __lux_tmp_110 = font
        if __lux_tmp_110 == nil then
          __lux_tmp_110 = ""
        end
        key = __lux_module_1.toString(__lux_tmp_110)
      end
      local alias = __lux_module_1.fonts[key]
      if alias ~= nil then
        return alias
      end
      local __lux_tmp_111 = font
      if __lux_tmp_111 == nil then
        __lux_tmp_111 = "DermaDefault"
      end
      return {
        mode = "native",
        sourceFont = __lux_tmp_111,
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
        local __lux_tmp_112 = noOversample
        if not __lux_tmp_112 then
          local __lux_obj_113 = textStyle
          local __lux_val_114 = nil
          if __lux_obj_113 ~= nil then
            __lux_val_114 = __lux_obj_113.__mgfxNoOversample
          end
          __lux_tmp_112 = __lux_val_114
        end
        if __lux_tmp_112 then
          oversample = 1
        else
          oversample = __lux_module_1.normalizeOversample(alias.oversample)
        end
      end
      if alias.face ~= nil then
        local weight
        do
          local __lux_tmp_115 = alias.weight
          if __lux_tmp_115 == nil then
            __lux_tmp_115 = 500
          end
          weight = __lux_tmp_115
        end
        local __lux_obj_116 = textStyle
        local __lux_val_117 = nil
        if __lux_obj_116 ~= nil then
          __lux_val_117 = __lux_obj_116.syntheticNativeWeight
        end
        if __lux_val_117 == true then
          local __lux_tmp_118 = plainFace ~= true
          if __lux_tmp_118 then
            local __lux_obj_119 = textStyle
            local __lux_val_120 = nil
            if __lux_obj_119 ~= nil then
              __lux_val_120 = __lux_obj_119.bold
            end
            __lux_tmp_118 = __lux_val_120 == true
          end
          if __lux_tmp_118 then
            weight = weight + 220
          end
          local __lux_tmp_121 = plainFace ~= true
          if __lux_tmp_121 then
            local __lux_obj_122 = textStyle
            local __lux_val_123 = nil
            if __lux_obj_122 ~= nil then
              __lux_val_123 = __lux_obj_122.thin
            end
            __lux_tmp_121 = __lux_val_123 == true
          end
          if __lux_tmp_121 then
            weight = __lux_module_1.mathMin(weight, 350)
          end
          local __lux_obj_124 = textStyle
          local __lux_val_125 = nil
          if __lux_obj_124 ~= nil then
            __lux_val_125 = __lux_obj_124.weight
          end
          if __lux_module_1.toNumber(__lux_val_125) ~= nil then
            weight = __lux_module_1.normalizeFontWeight(textStyle.weight, weight)
          end
        end
        local __lux_tmp_126 = alias.size
        if __lux_tmp_126 == nil then
          __lux_tmp_126 = 16
        end
        local __lux_obj_127 = textStyle
        local __lux_val_128 = nil
        if __lux_obj_127 ~= nil then
          __lux_val_128 = __lux_obj_127.italic
        end
        return __lux_module_1.ensureNativeFont(
          alias.face,
          __lux_tmp_126 * oversample,
          weight,
          __lux_val_128 == true
        ), alias, oversample
      end
      local __lux_tmp_129 = alias.sourceFont
      if __lux_tmp_129 == nil then
        local __lux_tmp_130 = font
        if __lux_tmp_130 == nil then
          __lux_tmp_130 = "DermaDefault"
        end
        __lux_tmp_129 = __lux_tmp_130
      end
      return __lux_tmp_129, alias, 1
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
        local __lux_tmp_131 = textStyle
        if __lux_tmp_131 == nil then
          __lux_tmp_131 = {}
        end
        __lux_module_1.styles[__lux_module_1.toString(name)] = __lux_module_1.resolveStyle(__lux_tmp_131)
      end
      return __lux_module_1.styles[__lux_module_1.toString(name)]
    end
    __lux_module_1.getStyle = function(name)
      local __lux_tmp_132 = name
      if __lux_tmp_132 == nil then
        __lux_tmp_132 = ""
      end
      return __lux_module_1.styles[__lux_module_1.toString(__lux_tmp_132)]
    end
    __lux_module_1.resolveStyle = function(textStyle)
      if __lux_module_1.typeOf(textStyle) == "string" then
        local __lux_tmp_133 = __lux_module_1.styles[__lux_module_1.toString(textStyle)]
        if __lux_tmp_133 == nil then
          __lux_tmp_133 = {}
        end
        return __lux_module_1.copyValue(__lux_tmp_133)
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
        local __lux_tmp_134 = textStyle.extends
        if __lux_tmp_134 == nil then
          __lux_tmp_134 = textStyle.base
        end
        base = __lux_tmp_134
      end
      if base ~= nil then
        local __lux_tmp_135 = __lux_module_1.typeOf(base) == "table"
        if __lux_tmp_135 then
          __lux_tmp_135 = base[1] ~= nil
        end
        local __lux_tmp_136 = __lux_tmp_135
        if __lux_tmp_136 then
          __lux_tmp_136 = not __lux_module_1.style.isColor(base)
        end
        if __lux_tmp_136 then
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
          local __lux_tmp_137 = font
          if __lux_tmp_137 == nil then
            __lux_tmp_137 = "DermaDefault"
          end
          target = __lux_tmp_137
        end
        local __lux_tmp_138 = __lux_module_1.protectedCall == nil
        if not __lux_tmp_138 then
          __lux_tmp_138 = __lux_module_1.protectedCall(__lux_module_1.surfaceSetFont, target)
        end
        if __lux_tmp_138 then
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
        local __lux_obj_139 = textStyle
        local __lux_val_140 = nil
        if __lux_obj_139 ~= nil then
          __lux_val_140 = __lux_obj_139.lineHeight
        end
        local __lux_tmp_141 = __lux_val_140
        if __lux_tmp_141 == nil then
          local __lux_obj_142 = textStyle
          local __lux_val_143 = nil
          if __lux_obj_142 ~= nil then
            __lux_val_143 = __lux_obj_142.lineheight
          end
          local __lux_tmp_144 = __lux_val_143
          if __lux_tmp_144 == nil then
            local __lux_obj_145 = alias
            local __lux_val_146 = nil
            if __lux_obj_145 ~= nil then
              __lux_val_146 = __lux_obj_145.lineHeight
            end
            __lux_tmp_144 = __lux_val_146
          end
          __lux_tmp_141 = __lux_tmp_144
        end
        declared = __lux_module_1.toNumber(__lux_tmp_141)
      end
      if declared ~= nil then
        return declared
      end
      __lux_module_1.setFontSafe(nativeFont)
      local _, h = __lux_module_1.surfaceGetTextSize("Mg")
      local __lux_tmp_147 = h
      if __lux_tmp_147 == nil then
        __lux_tmp_147 = 16
      end
      return __lux_module_1.mathMax(
        1,
        __lux_tmp_147 / __lux_module_1.normalizeOversample(oversample)
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
        local __lux_tmp_148 = text
        if __lux_tmp_148 == nil then
          __lux_tmp_148 = ""
        end
        raw = __lux_module_1.toString(__lux_tmp_148)
      end
      local w, h = __lux_module_1.surfaceGetTextSize(raw)
      local extra
      do
        local __lux_tmp_149 = __lux_module_1.toNumber(tracking)
        if __lux_tmp_149 == nil then
          __lux_tmp_149 = 0
        end
        extra = __lux_tmp_149
      end
      local __lux_tmp_150 = extra ~= 0
      if __lux_tmp_150 then
        __lux_tmp_150 = #raw > 1
      end
      if __lux_tmp_150 then
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
        local __lux_tmp_151 = textStyle
        if __lux_tmp_151 == nil then
          __lux_tmp_151 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_151)
      end
      local nativeFont, alias, oversample = __lux_module_1.nativeFor(font, resolved, noOversample, plainFace)
      local tracking
      do
        local __lux_tmp_152 = resolved.tracking
        if __lux_tmp_152 == nil then
          __lux_tmp_152 = resolved.letterSpacing
        end
        local __lux_tmp_153 = __lux_module_1.toNumber(__lux_tmp_152)
        if __lux_tmp_153 == nil then
          local __lux_tmp_154 = alias.tracking
          if __lux_tmp_154 == nil then
            __lux_tmp_154 = 0
          end
          __lux_tmp_153 = __lux_tmp_154
        end
        tracking = __lux_tmp_153
      end
      local lineHeight = __lux_module_1.lineHeightFor(nativeFont, alias, resolved, oversample)
      local lines
      do
        local __lux_tmp_155 = value
        if __lux_tmp_155 == nil then
          __lux_tmp_155 = ""
        end
        lines = __lux_module_1.stringExplode("\n", __lux_module_1.toString(__lux_tmp_155), false)
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
        local __lux_tmp_156 = alias.tracking
        if __lux_tmp_156 == nil then
          __lux_tmp_156 = 0
        end
        tracking = __lux_tmp_156
      end
      local key
      do
        local __lux_tmp_157 = font
        if __lux_tmp_157 == nil then
          __lux_tmp_157 = ""
        end
        local __lux_tmp_158 = value
        if __lux_tmp_158 == nil then
          __lux_tmp_158 = ""
        end
        key = __lux_module_1.tableConcat(
          {
            __lux_module_1.toString(__lux_tmp_157),
            nativeFont,
            __lux_module_1.toString(tracking),
            __lux_module_1.toString(oversample),
            __lux_module_1.toString(__lux_tmp_158),
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
        local __lux_tmp_159 = value
        if __lux_tmp_159 == nil then
          __lux_tmp_159 = ""
        end
        text = __lux_module_1.toString(__lux_tmp_159)
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
        local __lux_tmp_160 = value
        if __lux_tmp_160 == nil then
          __lux_tmp_160 = ""
        end
        text = __lux_module_1.toString(__lux_tmp_160)
      end
      local width
      do
        local __lux_tmp_161 = __lux_module_1.toNumber(maxW)
        if __lux_tmp_161 == nil then
          __lux_tmp_161 = 0
        end
        width = __lux_tmp_161
      end
      if width <= 0 then
        return __lux_module_1.stringExplode("\n", text, false)
      end
      local __lux_tmp_162 = overflow == "ellipsis"
      if not __lux_tmp_162 then
        __lux_tmp_162 = overflow == "truncate"
      end
      if __lux_tmp_162 then
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
          local __lux_tmp_163 = nextW > width
          if __lux_tmp_163 then
            __lux_tmp_163 = line ~= ""
          end
          if __lux_tmp_163 then
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
        local __lux_tmp_164 = textStyle
        if __lux_tmp_164 == nil then
          __lux_tmp_164 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_164)
      end
      local lines
      do
        local __lux_tmp_165 = font
        if __lux_tmp_165 == nil then
          local __lux_tmp_166 = resolved.font
          if __lux_tmp_166 == nil then
            __lux_tmp_166 = "DermaDefault"
          end
          __lux_tmp_165 = __lux_tmp_166
        end
        local __lux_tmp_167 = __lux_module_1.toNumber(w)
        if __lux_tmp_167 == nil then
          __lux_tmp_167 = 0
        end
        lines = __lux_module_1.wrapText(value, __lux_tmp_165, __lux_tmp_167, resolved.overflow)
      end
      local maxW = 0
      for index = 1, #lines do
        local lw
        do
          local __lux_tmp_168 = font
          if __lux_tmp_168 == nil then
            local __lux_tmp_169 = resolved.font
            if __lux_tmp_169 == nil then
              __lux_tmp_169 = "DermaDefault"
            end
            __lux_tmp_168 = __lux_tmp_169
          end
          lw = __lux_module_1.measure(lines[index], __lux_tmp_168)
        end
        maxW = __lux_module_1.mathMax(maxW, lw)
      end
      local nativeFont, alias, oversample
      do
        local __lux_tmp_170 = font
        if __lux_tmp_170 == nil then
          local __lux_tmp_171 = resolved.font
          if __lux_tmp_171 == nil then
            __lux_tmp_171 = "DermaDefault"
          end
          __lux_tmp_170 = __lux_tmp_171
        end
        nativeFont, alias, oversample = __lux_module_1.nativeFor(__lux_tmp_170, resolved)
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
      local __lux_match_172 = value
      if __lux_match_172 == "center" or __lux_match_172 == "middle" then
        return 0.5
      elseif __lux_match_172 == "right" or __lux_match_172 == "bottom" then
        return 1
      else
        local __lux_tmp_173 = value == TEXT_ALIGN_CENTER
        if not __lux_tmp_173 then
          local __lux_tmp_174 = vertical
          if __lux_tmp_174 then
            __lux_tmp_174 = value == TEXT_ALIGN_CENTER
          end
          __lux_tmp_173 = __lux_tmp_174
        end
        if __lux_tmp_173 then
          return 0.5
        end
        do
          local __lux_tmp_175 = value == TEXT_ALIGN_RIGHT
          if not __lux_tmp_175 then
            __lux_tmp_175 = value == TEXT_ALIGN_BOTTOM
          end
          if __lux_tmp_175 then
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
      local __lux_tmp_176 = fill.colorA
      if __lux_tmp_176 == nil then
        local __lux_tmp_177 = fill.color
        if __lux_tmp_177 == nil then
          __lux_tmp_177 = fill.fill
        end
        __lux_tmp_176 = __lux_tmp_177
      end
      return __lux_module_1.style.colorOr(__lux_tmp_176, __lux_module_1.white)
    end
    __lux_module_1.setTextColor = function(color)
      local c = __lux_module_1.style.colorOr(color, __lux_module_1.white)
      if __lux_module_1.surfaceSetTextColor ~= nil then
        do
          local __lux_tmp_178 = c.r
          if __lux_tmp_178 == nil then
            __lux_tmp_178 = 255
          end
          local __lux_tmp_179 = c.g
          if __lux_tmp_179 == nil then
            __lux_tmp_179 = 255
          end
          local __lux_tmp_180 = c.b
          if __lux_tmp_180 == nil then
            __lux_tmp_180 = 255
          end
          local __lux_tmp_181 = c.a
          if __lux_tmp_181 == nil then
            __lux_tmp_181 = 255
          end
          __lux_module_1.surfaceSetTextColor(
            __lux_tmp_178,
            __lux_tmp_179,
            __lux_tmp_180,
            __lux_tmp_181
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
        local __lux_tmp_182 = text
        if __lux_tmp_182 == nil then
          __lux_tmp_182 = ""
        end
        raw = __lux_module_1.toString(__lux_tmp_182)
      end
      local extra
      do
        local __lux_tmp_183 = __lux_module_1.toNumber(tracking)
        if __lux_tmp_183 == nil then
          __lux_tmp_183 = 0
        end
        extra = __lux_tmp_183
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
          local __lux_tmp_184 = cw
          if __lux_tmp_184 == nil then
            __lux_tmp_184 = 0
          end
          cursor = cursor + __lux_tmp_184 + extra * __lux_module_1.normalizeOversample(oversample)
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
          local __lux_tmp_185 = fill
          if __lux_tmp_185 == nil then
            __lux_tmp_185 = fallbackColor
          end
          __lux_module_1.drawLineText(
            layout.font,
            line.text,
            x,
            y + line.y * oversample,
            __lux_module_1.colorAtFill(__lux_tmp_185, t),
            layout.tracking,
            oversample
          )
        end
      end
    end
    __lux_module_1.normalizeShadow = function(value)
      local __lux_tmp_186 = value == nil
      if not __lux_tmp_186 then
        __lux_tmp_186 = value == false
      end
      if __lux_tmp_186 then
        return nil
      end
      if value == true then
        value = {}
      end
      if __lux_module_1.typeOf(value) ~= "table" then
        do
          local __lux_tmp_187 = __lux_module_1.toNumber(value)
          if __lux_tmp_187 == nil then
            __lux_tmp_187 = 0
          end
          value = { blur = __lux_tmp_187 }
        end
      end
      local __lux_tmp_188 = value.x
      if __lux_tmp_188 == nil then
        local __lux_tmp_189 = value.offsetX
        if __lux_tmp_189 == nil then
          __lux_tmp_189 = value[1]
        end
        __lux_tmp_188 = __lux_tmp_189
      end
      local __lux_tmp_190 = __lux_module_1.toNumber(__lux_tmp_188)
      if __lux_tmp_190 == nil then
        __lux_tmp_190 = 1
      end
      local __lux_tmp_191 = value.y
      if __lux_tmp_191 == nil then
        local __lux_tmp_192 = value.offsetY
        if __lux_tmp_192 == nil then
          __lux_tmp_192 = value[2]
        end
        __lux_tmp_191 = __lux_tmp_192
      end
      local __lux_tmp_193 = __lux_module_1.toNumber(__lux_tmp_191)
      if __lux_tmp_193 == nil then
        __lux_tmp_193 = 1
      end
      local __lux_tmp_194 = value.blur
      if __lux_tmp_194 == nil then
        local __lux_tmp_195 = value.radius
        if __lux_tmp_195 == nil then
          __lux_tmp_195 = value[3]
        end
        __lux_tmp_194 = __lux_tmp_195
      end
      local __lux_tmp_196 = __lux_module_1.toNumber(__lux_tmp_194)
      if __lux_tmp_196 == nil then
        __lux_tmp_196 = 0
      end
      local __lux_tmp_197 = value.strength
      if __lux_tmp_197 == nil then
        __lux_tmp_197 = value.opacity
      end
      local __lux_tmp_198 = __lux_module_1.toNumber(__lux_tmp_197)
      if __lux_tmp_198 == nil then
        __lux_tmp_198 = 1
      end
      local __lux_tmp_199 = value.color
      if __lux_tmp_199 == nil then
        __lux_tmp_199 = value.tint
      end
      return {
        x = __lux_tmp_190,
        y = __lux_tmp_193,
        blur = __lux_tmp_196,
        strength = __lux_tmp_198,
        color = __lux_module_1.style.colorOr(__lux_tmp_199, __lux_module_1.makeColor(0, 0, 0, 180)),
      }
    end
    __lux_module_1.normalizeStroke = function(value)
      local __lux_tmp_200 = value == nil
      if not __lux_tmp_200 then
        __lux_tmp_200 = value == false
      end
      if __lux_tmp_200 then
        return nil
      end
      if value == true then
        value = {}
      end
      if __lux_module_1.typeOf(value) ~= "table" then
        do
          local __lux_tmp_201 = __lux_module_1.toNumber(value)
          if __lux_tmp_201 == nil then
            __lux_tmp_201 = 1
          end
          value = { width = __lux_tmp_201 }
        end
      end
      local width
      do
        local __lux_tmp_202 = value.width
        if __lux_tmp_202 == nil then
          local __lux_tmp_203 = value.size
          if __lux_tmp_203 == nil then
            __lux_tmp_203 = value[1]
          end
          __lux_tmp_202 = __lux_tmp_203
        end
        local __lux_tmp_204 = __lux_module_1.toNumber(__lux_tmp_202)
        if __lux_tmp_204 == nil then
          __lux_tmp_204 = 1
        end
        width = __lux_module_1.mathMax(0, __lux_tmp_204)
      end
      if width <= 0 then
        return nil
      end
      local __lux_tmp_205 = __lux_module_1.toNumber(value.softness)
      if __lux_tmp_205 == nil then
        __lux_tmp_205 = 0
      end
      local __lux_tmp_206 = value.color
      if __lux_tmp_206 == nil then
        __lux_tmp_206 = value.tint
      end
      return {
        width = width,
        samples = __lux_module_1.mathClamp(__lux_module_1.mathCeil(width * 6), 8, 32),
        softness = __lux_tmp_205,
        color = __lux_module_1.style.colorOr(__lux_tmp_206, __lux_module_1.makeColor(0, 0, 0, 220)),
      }
    end
    __lux_module_1.normalizeGlow = function(value)
      local __lux_tmp_207 = value == nil
      if not __lux_tmp_207 then
        __lux_tmp_207 = value == false
      end
      if __lux_tmp_207 then
        return nil
      end
      if value == true then
        value = {}
      end
      if __lux_module_1.typeOf(value) ~= "table" then
        do
          local __lux_tmp_208 = __lux_module_1.toNumber(value)
          if __lux_tmp_208 == nil then
            __lux_tmp_208 = 6
          end
          value = { width = __lux_tmp_208 }
        end
      end
      local width
      do
        local __lux_tmp_209 = value.width
        if __lux_tmp_209 == nil then
          local __lux_tmp_210 = value.radius
          if __lux_tmp_210 == nil then
            __lux_tmp_210 = value[1]
          end
          __lux_tmp_209 = __lux_tmp_210
        end
        local __lux_tmp_211 = __lux_module_1.toNumber(__lux_tmp_209)
        if __lux_tmp_211 == nil then
          __lux_tmp_211 = 6
        end
        width = __lux_module_1.mathMax(0, __lux_tmp_211)
      end
      if width <= 0 then
        return nil
      end
      local __lux_tmp_212 = value.strength
      if __lux_tmp_212 == nil then
        __lux_tmp_212 = value.opacity
      end
      local __lux_tmp_213 = __lux_module_1.toNumber(__lux_tmp_212)
      if __lux_tmp_213 == nil then
        __lux_tmp_213 = 0.45
      end
      local __lux_tmp_214 = value.color
      if __lux_tmp_214 == nil then
        __lux_tmp_214 = value.tint
      end
      return {
        width = width,
        samples = __lux_module_1.mathClamp(__lux_module_1.mathCeil(width * 2), 8, 36),
        strength = __lux_tmp_213,
        color = __lux_module_1.style.colorOr(
          __lux_tmp_214,
          __lux_module_1.makeColor(255, 255, 255, 120)
        ),
      }
    end
    __lux_module_1.scaledColor = function(input, scale)
      local color = __lux_module_1.style.colorOr(input, __lux_module_1.white)
      local __lux_tmp_215 = color.r
      if __lux_tmp_215 == nil then
        __lux_tmp_215 = 255
      end
      local __lux_tmp_216 = color.g
      if __lux_tmp_216 == nil then
        __lux_tmp_216 = 255
      end
      local __lux_tmp_217 = color.b
      if __lux_tmp_217 == nil then
        __lux_tmp_217 = 255
      end
      local __lux_tmp_218 = color.a
      if __lux_tmp_218 == nil then
        __lux_tmp_218 = 255
      end
      local __lux_tmp_219 = scale
      if __lux_tmp_219 == nil then
        __lux_tmp_219 = 1
      end
      return __lux_module_1.makeColor(
        __lux_tmp_215,
        __lux_tmp_216,
        __lux_tmp_217,
        __lux_module_1.mathClamp(
          __lux_module_1.mathFloor(__lux_tmp_218 * __lux_tmp_219),
          0,
          255
        )
      )
    end
    __lux_module_1.snapTextPos = function(x, y, textStyle)
      local __lux_obj_220 = textStyle
      local __lux_val_221 = nil
      if __lux_obj_220 ~= nil then
        __lux_val_221 = __lux_obj_220.pixelSnap
      end
      if __lux_val_221 == false then
        return x, y
      end
      local __lux_tmp_222 = x
      if __lux_tmp_222 == nil then
        __lux_tmp_222 = 0
      end
      local __lux_tmp_223 = y
      if __lux_tmp_223 == nil then
        __lux_tmp_223 = 0
      end
      return __lux_module_1.mathFloor(__lux_tmp_222 + 0.5), __lux_module_1.mathFloor(__lux_tmp_223 + 0.5)
    end
    __lux_module_1.drawNativeFallbackRecord = function(record)
      local textStyle
      do
        local __lux_tmp_224 = record.style
        if __lux_tmp_224 == nil then
          __lux_tmp_224 = {}
        end
        textStyle = __lux_tmp_224
      end
      local layout = __lux_module_1.layoutFor(record.text, record.font, textStyle, true)
      local x
      do
        local __lux_tmp_225 = record.x
        if __lux_tmp_225 == nil then
          __lux_tmp_225 = 0
        end
        x = __lux_tmp_225 - layout.w * __lux_module_1.alignFactor(record.alignX)
      end
      local y
      do
        local __lux_tmp_226 = record.y
        if __lux_tmp_226 == nil then
          __lux_tmp_226 = 0
        end
        y = __lux_tmp_226 - layout.h * __lux_module_1.alignFactor(record.alignY, true)
      end
      x, y = __lux_module_1.snapTextPos(x, y, textStyle)
      local fill
      do
        local __lux_tmp_227 = textStyle.fill
        if __lux_tmp_227 == nil then
          local __lux_tmp_228 = textStyle.color
          if __lux_tmp_228 == nil then
            local __lux_tmp_229 = record.color
            if __lux_tmp_229 == nil then
              __lux_tmp_229 = __lux_module_1.white
            end
            __lux_tmp_228 = __lux_tmp_229
          end
          __lux_tmp_227 = __lux_tmp_228
        end
        fill = __lux_tmp_227
      end
      local shadow = __lux_module_1.normalizeShadow(textStyle.shadow)
      local stroke
      do
        local __lux_tmp_230 = textStyle.stroke
        if __lux_tmp_230 == nil then
          __lux_tmp_230 = textStyle.outline
        end
        stroke = __lux_module_1.normalizeStroke(__lux_tmp_230)
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
        local __lux_tmp_231 = record.color
        if __lux_tmp_231 == nil then
          __lux_tmp_231 = __lux_module_1.white
        end
        __lux_module_1.drawLayout(layout, x, y, fill, __lux_tmp_231)
      end
      return record
    end
    __lux_module_1.drawNativePlainRecord = function(record)
      local textStyle
      do
        local __lux_tmp_232 = record.style
        if __lux_tmp_232 == nil then
          __lux_tmp_232 = {}
        end
        textStyle = __lux_tmp_232
      end
      local fill
      do
        local __lux_tmp_233 = textStyle.fill
        if __lux_tmp_233 == nil then
          local __lux_tmp_234 = textStyle.color
          if __lux_tmp_234 == nil then
            local __lux_tmp_235 = record.color
            if __lux_tmp_235 == nil then
              __lux_tmp_235 = __lux_module_1.white
            end
            __lux_tmp_234 = __lux_tmp_235
          end
          __lux_tmp_233 = __lux_tmp_234
        end
        fill = __lux_tmp_233
      end
      if __lux_module_1.fillNeedsShader(fill) then
        do
          local __lux_tmp_236 = record.color
          if __lux_tmp_236 == nil then
            __lux_tmp_236 = __lux_module_1.white
          end
          fill = __lux_tmp_236
        end
      end
      local nativeFont, alias = __lux_module_1.nativeFor(record.font, textStyle, true, true)
      local tracking
      do
        local __lux_tmp_237 = textStyle.tracking
        if __lux_tmp_237 == nil then
          __lux_tmp_237 = textStyle.letterSpacing
        end
        local __lux_tmp_238 = __lux_module_1.toNumber(__lux_tmp_237)
        if __lux_tmp_238 == nil then
          local __lux_tmp_239 = alias.tracking
          if __lux_tmp_239 == nil then
            __lux_tmp_239 = 0
          end
          __lux_tmp_238 = __lux_tmp_239
        end
        tracking = __lux_tmp_238
      end
      local raw
      do
        local __lux_tmp_240 = record.text
        if __lux_tmp_240 == nil then
          __lux_tmp_240 = ""
        end
        raw = __lux_module_1.toString(__lux_tmp_240)
      end
      local __lux_tmp_241 = tracking == 0
      if __lux_tmp_241 then
        __lux_tmp_241 = __lux_module_1.stringFind(raw, "\n", 1, true) == nil
      end
      local __lux_tmp_242 = __lux_tmp_241
      if __lux_tmp_242 then
        __lux_tmp_242 = textStyle.lineHeight == nil
      end
      local __lux_tmp_243 = __lux_tmp_242
      if __lux_tmp_243 then
        __lux_tmp_243 = alias.lineHeight == nil
      end
      local __lux_tmp_244 = __lux_tmp_243
      if __lux_tmp_244 then
        __lux_tmp_244 = not __lux_module_1.fillNeedsShader(fill)
      end
      local __lux_tmp_245 = __lux_tmp_244
      if __lux_tmp_245 then
        __lux_tmp_245 = __lux_module_1.drawSimpleText ~= nil
      end
      if __lux_tmp_245 then
        local x, y
        do
          local __lux_tmp_246 = record.x
          if __lux_tmp_246 == nil then
            __lux_tmp_246 = 0
          end
          local __lux_tmp_247 = record.y
          if __lux_tmp_247 == nil then
            __lux_tmp_247 = 0
          end
          x, y = __lux_module_1.snapTextPos(__lux_tmp_246, __lux_tmp_247, textStyle)
        end
        do
          local __lux_tmp_248 = record.color
          if __lux_tmp_248 == nil then
            __lux_tmp_248 = __lux_module_1.white
          end
          local __lux_tmp_249 = record.alignX
          if __lux_tmp_249 == nil then
            __lux_tmp_249 = TEXT_ALIGN_LEFT
          end
          local __lux_tmp_250 = record.alignY
          if __lux_tmp_250 == nil then
            __lux_tmp_250 = TEXT_ALIGN_TOP
          end
          __lux_module_1.drawSimpleText(
            raw,
            __lux_module_1.setFontSafe(nativeFont),
            x,
            y,
            __lux_module_1.style.colorOr(fill, __lux_tmp_248),
            __lux_tmp_249,
            __lux_tmp_250
          )
        end
        return record
      end
      local layout = __lux_module_1.layoutFor(raw, record.font, textStyle, true, true)
      local x
      do
        local __lux_tmp_251 = record.x
        if __lux_tmp_251 == nil then
          __lux_tmp_251 = 0
        end
        x = __lux_tmp_251 - layout.w * __lux_module_1.alignFactor(record.alignX)
      end
      local y
      do
        local __lux_tmp_252 = record.y
        if __lux_tmp_252 == nil then
          __lux_tmp_252 = 0
        end
        y = __lux_tmp_252 - layout.h * __lux_module_1.alignFactor(record.alignY, true)
      end
      x, y = __lux_module_1.snapTextPos(x, y, textStyle)
      do
        local __lux_tmp_253 = record.color
        if __lux_tmp_253 == nil then
          __lux_tmp_253 = __lux_module_1.white
        end
        __lux_module_1.drawLayout(layout, x, y, fill, __lux_tmp_253)
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
        local __lux_tmp_254 = textStyle
        if __lux_tmp_254 == nil then
          __lux_tmp_254 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_254)
      end
      local record
      do
        local __lux_tmp_255 = value
        if __lux_tmp_255 == nil then
          __lux_tmp_255 = ""
        end
        local __lux_tmp_256 = resolved.font
        if __lux_tmp_256 == nil then
          local __lux_tmp_257 = font
          if __lux_tmp_257 == nil then
            __lux_tmp_257 = "DermaDefault"
          end
          __lux_tmp_256 = __lux_tmp_257
        end
        local __lux_tmp_258 = __lux_module_1.toNumber(x)
        if __lux_tmp_258 == nil then
          __lux_tmp_258 = 0
        end
        local __lux_tmp_259 = __lux_module_1.toNumber(y)
        if __lux_tmp_259 == nil then
          __lux_tmp_259 = 0
        end
        local __lux_tmp_260 = color
        if __lux_tmp_260 == nil then
          local __lux_tmp_261 = resolved.color
          if __lux_tmp_261 == nil then
            __lux_tmp_261 = resolved.fill
          end
          __lux_tmp_260 = __lux_tmp_261
        end
        local __lux_tmp_262 = resolved.alignX
        if __lux_tmp_262 == nil then
          local __lux_tmp_263 = resolved.align
          if __lux_tmp_263 == nil then
            local __lux_tmp_264 = ax
            if __lux_tmp_264 == nil then
              __lux_tmp_264 = TEXT_ALIGN_LEFT
            end
            __lux_tmp_263 = __lux_tmp_264
          end
          __lux_tmp_262 = __lux_tmp_263
        end
        local __lux_tmp_265 = resolved.alignY
        if __lux_tmp_265 == nil then
          local __lux_tmp_266 = resolved.valign
          if __lux_tmp_266 == nil then
            local __lux_tmp_267 = ay
            if __lux_tmp_267 == nil then
              __lux_tmp_267 = TEXT_ALIGN_TOP
            end
            __lux_tmp_266 = __lux_tmp_267
          end
          __lux_tmp_265 = __lux_tmp_266
        end
        record = {
          text = __lux_module_1.toString(__lux_tmp_255),
          font = __lux_tmp_256,
          x = __lux_tmp_258,
          y = __lux_tmp_259,
          color = __lux_module_1.style.colorOr(__lux_tmp_260, __lux_module_1.white),
          alignX = __lux_tmp_262,
          alignY = __lux_tmp_265,
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
        local __lux_tmp_268 = textStyle
        if __lux_tmp_268 == nil then
          __lux_tmp_268 = {}
        end
        out = __lux_module_1.copyValue(__lux_tmp_268)
      end
      out.alignY = TEXT_ALIGN_TOP
      out.valign = TEXT_ALIGN_TOP
      return out
    end
    __lux_module_1.boxEx = function(value, font, x, y, w, h, textStyle)
      local resolved
      do
        local __lux_tmp_269 = textStyle
        if __lux_tmp_269 == nil then
          __lux_tmp_269 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_269)
      end
      local resolvedFont
      do
        local __lux_tmp_270 = resolved.font
        if __lux_tmp_270 == nil then
          local __lux_tmp_271 = font
          if __lux_tmp_271 == nil then
            __lux_tmp_271 = "DermaDefault"
          end
          __lux_tmp_270 = __lux_tmp_271
        end
        resolvedFont = __lux_tmp_270
      end
      local lines
      do
        local __lux_tmp_272 = __lux_module_1.toNumber(w)
        if __lux_tmp_272 == nil then
          __lux_tmp_272 = 0
        end
        lines = __lux_module_1.wrapText(value, resolvedFont, __lux_tmp_272, resolved.overflow)
      end
      local nativeFont, alias, oversample = __lux_module_1.nativeFor(resolvedFont, resolved)
      local lineHeight = __lux_module_1.lineHeightFor(nativeFont, alias, resolved, oversample)
      local totalH = #lines * lineHeight
      local startY
      do
        local __lux_tmp_273 = __lux_module_1.toNumber(y)
        if __lux_tmp_273 == nil then
          __lux_tmp_273 = 0
        end
        local __lux_tmp_274 = __lux_module_1.toNumber(h)
        if __lux_tmp_274 == nil then
          __lux_tmp_274 = totalH
        end
        local __lux_tmp_275 = resolved.alignY
        if __lux_tmp_275 == nil then
          local __lux_tmp_276 = resolved.valign
          if __lux_tmp_276 == nil then
            __lux_tmp_276 = TEXT_ALIGN_TOP
          end
          __lux_tmp_275 = __lux_tmp_276
        end
        startY = __lux_tmp_273 + (__lux_tmp_274 - totalH) * __lux_module_1.alignFactor(__lux_tmp_275, true)
      end
      local ax
      do
        local __lux_tmp_277 = resolved.alignX
        if __lux_tmp_277 == nil then
          local __lux_tmp_278 = resolved.align
          if __lux_tmp_278 == nil then
            __lux_tmp_278 = TEXT_ALIGN_LEFT
          end
          __lux_tmp_277 = __lux_tmp_278
        end
        ax = __lux_tmp_277
      end
      local tx
      do
        local __lux_tmp_279 = __lux_module_1.toNumber(x)
        if __lux_tmp_279 == nil then
          __lux_tmp_279 = 0
        end
        local __lux_tmp_280 = __lux_module_1.toNumber(w)
        if __lux_tmp_280 == nil then
          __lux_tmp_280 = 0
        end
        tx = __lux_tmp_279 + __lux_tmp_280 * __lux_module_1.alignFactor(ax)
      end
      local lineStyle = __lux_module_1.textBoxLineStyle(resolved)
      for index = 1, #lines do
        do
          local __lux_tmp_281 = lineStyle.color
          if __lux_tmp_281 == nil then
            __lux_tmp_281 = lineStyle.fill
          end
          __lux_module_1.drawEx(
            lines[index],
            resolvedFont,
            tx,
            startY + (index - 1) * lineHeight,
            __lux_tmp_281,
            ax,
            TEXT_ALIGN_TOP,
            lineStyle
          )
        end
      end
    end
    __lux_module_1.batch = function(records)
      do
        local __lux_tmp_282 = records
        if __lux_tmp_282 == nil then
          __lux_tmp_282 = {}
        end
        for index = 1, #__lux_tmp_282 do
          local record = records[index]
          do
            local __lux_tmp_283 = record.alignX
            if __lux_tmp_283 == nil then
              __lux_tmp_283 = record.ax
            end
            local __lux_tmp_284 = record.alignY
            if __lux_tmp_284 == nil then
              __lux_tmp_284 = record.ay
            end
            local __lux_tmp_285 = record.style
            if __lux_tmp_285 == nil then
              __lux_tmp_285 = {}
            end
            __lux_module_1.drawNativeFallbackRecord(
              {
                text = record.text,
                font = record.font,
                x = record.x,
                y = record.y,
                color = record.color,
                alignX = __lux_tmp_283,
                alignY = __lux_tmp_284,
                style = __lux_module_1.resolveStyle(__lux_tmp_285),
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
        local __lux_tmp_286 = textStyle
        if __lux_tmp_286 == nil then
          __lux_tmp_286 = {}
        end
        resolved = __lux_module_1.resolveStyle(__lux_tmp_286)
      end
      local layout
      do
        local __lux_tmp_287 = font
        if __lux_tmp_287 == nil then
          local __lux_tmp_288 = resolved.font
          if __lux_tmp_288 == nil then
            __lux_tmp_288 = "DermaDefault"
          end
          __lux_tmp_287 = __lux_tmp_288
        end
        layout = __lux_module_1.layoutFor(value, __lux_tmp_287, resolved)
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
        local __lux_tmp_289 = __lux_module_1.profile.times
        if __lux_tmp_289 == nil then
          __lux_tmp_289 = {}
        end
        local __lux_tmp_290 = __lux_module_1.profile.counts
        if __lux_tmp_290 == nil then
          __lux_tmp_290 = {}
        end
        out = {
          active = __lux_module_1.profile.active,
          draws = __lux_module_1.profile.draws,
          measures = __lux_module_1.profile.measures,
          times = __lux_module_1.tableCopy(__lux_tmp_289),
          counts = __lux_module_1.tableCopy(__lux_tmp_290),
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
        local __lux_tmp_291 = stats.textComposedEntries
        if __lux_tmp_291 == nil then
          __lux_tmp_291 = 0
        end
        stats.textComposedEntries = __lux_tmp_291
      end
      do
        local __lux_tmp_292 = stats.textComposedEvicts
        if __lux_tmp_292 == nil then
          __lux_tmp_292 = 0
        end
        stats.textComposedEvicts = __lux_tmp_292
      end
      do
        local __lux_tmp_293 = stats.textMeasureHits
        if __lux_tmp_293 == nil then
          __lux_tmp_293 = 0
        end
        stats.textMeasureHits = __lux_tmp_293
      end
      do
        local __lux_tmp_294 = stats.textMeasureMisses
        if __lux_tmp_294 == nil then
          __lux_tmp_294 = 0
        end
        stats.textMeasureMisses = __lux_tmp_294
      end
      do
        local __lux_tmp_295 = stats.textEntryCacheHits
        if __lux_tmp_295 == nil then
          __lux_tmp_295 = 0
        end
        stats.textEntryCacheHits = __lux_tmp_295
      end
      do
        local __lux_tmp_296 = stats.textEntryCacheMisses
        if __lux_tmp_296 == nil then
          __lux_tmp_296 = 0
        end
        stats.textEntryCacheMisses = __lux_tmp_296
      end
      do
        local __lux_tmp_297 = stats.textFallbacks
        if __lux_tmp_297 == nil then
          __lux_tmp_297 = 0
        end
        stats.textFallbacks = __lux_tmp_297
      end
      stats.textDataDraws = 0
      stats.textDataBatches = 0
      stats.textAtlasUploads = 0
      stats.textAtlasGlyphs = 0
      do
        local __lux_tmp_298 = stats.textAtlasResets
        if __lux_tmp_298 == nil then
          __lux_tmp_298 = 0
        end
        stats.textAtlasResets = __lux_tmp_298
      end
      stats.textCacheSize = __lux_module_1.measureOrderCount
      return stats
    end
    __lux_module_1.statAdd = function(stats, key, amount)
      if amount == nil then
        amount = 1
      end
      do
        local __lux_tmp_299 = stats[key]
        if __lux_tmp_299 == nil then
          __lux_tmp_299 = 0
        end
        stats[key] = __lux_tmp_299 + amount
      end
      return stats[key]
    end
  end
  do
    __lux_module_1.textComposedEnabled = function()
      local __lux_tmp_300 = not __lux_module_1.textComposerCapable()
      if not __lux_tmp_300 then
        __lux_tmp_300 = __lux_module_1.atlasFailed
      end
      if __lux_tmp_300 then
        return false
      end
      local __lux_tmp_301 = __lux_module_1.composedCvar == nil
      if __lux_tmp_301 then
        __lux_tmp_301 = __lux_module_1.getConVar ~= nil
      end
      if __lux_tmp_301 then
        do
          local __lux_tmp_302 = __lux_module_1.getConVar("mgfx_text_composed")
          if __lux_tmp_302 == nil then
            __lux_tmp_302 = false
          end
          __lux_module_1.composedCvar = __lux_tmp_302
        end
      end
      local __lux_tmp_303 = __lux_module_1.composedCvar == false
      if not __lux_tmp_303 then
        __lux_tmp_303 = __lux_module_1.composedCvar == nil
      end
      if __lux_tmp_303 then
        return true
      end
      return __lux_module_1.composedCvar:GetBool()
    end
    __lux_module_1.textComposeBudget = function()
      local __lux_tmp_304 = __lux_module_1.budgetCvar == nil
      if __lux_tmp_304 then
        __lux_tmp_304 = __lux_module_1.getConVar ~= nil
      end
      if __lux_tmp_304 then
        do
          local __lux_tmp_305 = __lux_module_1.getConVar("mgfx_text_composed_budget")
          if __lux_tmp_305 == nil then
            __lux_tmp_305 = false
          end
          __lux_module_1.budgetCvar = __lux_tmp_305
        end
      end
      local __lux_tmp_306 = __lux_module_1.budgetCvar == false
      if not __lux_tmp_306 then
        __lux_tmp_306 = __lux_module_1.budgetCvar == nil
      end
      if __lux_tmp_306 then
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
      local __lux_tmp_307 = rt == nil
      if not __lux_tmp_307 then
        __lux_tmp_307 = __lux_module_1.renderPushRenderTarget == nil
      end
      local __lux_tmp_308 = __lux_tmp_307
      if not __lux_tmp_308 then
        __lux_tmp_308 = __lux_module_1.renderClear == nil
      end
      local __lux_tmp_309 = __lux_tmp_308
      if not __lux_tmp_309 then
        __lux_tmp_309 = __lux_module_1.renderPopRenderTarget == nil
      end
      if __lux_tmp_309 then
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
          local __lux_tmp_310 = alpha
          if __lux_tmp_310 == nil then
            __lux_tmp_310 = 1
          end
          __lux_module_1.surfaceSetAlphaMultiplier(__lux_tmp_310)
        end
      end
      local __lux_tmp_311 = __lux_module_1.renderSetColorModulation ~= nil
      if __lux_tmp_311 then
        __lux_tmp_311 = cr ~= nil
      end
      if __lux_tmp_311 then
        __lux_module_1.renderSetColorModulation(cr, cg, cb)
      end
      local __lux_tmp_312 = __lux_module_1.renderSetBlend ~= nil
      if __lux_tmp_312 then
        __lux_tmp_312 = blend ~= nil
      end
      if __lux_tmp_312 then
        __lux_module_1.renderSetBlend(blend)
      end
    end
    __lux_module_1.clearAtlasSlot = function(x, y, w, h)
      local __lux_tmp_313 = __lux_module_1.surfaceDrawRect == nil
      if not __lux_tmp_313 then
        __lux_tmp_313 = __lux_module_1.surfaceSetDrawColor == nil
      end
      if __lux_tmp_313 then
        return false
      end
      do
        local __lux_tmp_314 = x
        if __lux_tmp_314 == nil then
          __lux_tmp_314 = 0
        end
        x = __lux_module_1.mathFloor(__lux_module_1.mathMax(0, __lux_tmp_314))
      end
      do
        local __lux_tmp_315 = y
        if __lux_tmp_315 == nil then
          __lux_tmp_315 = 0
        end
        y = __lux_module_1.mathFloor(__lux_module_1.mathMax(0, __lux_tmp_315))
      end
      do
        local __lux_tmp_316 = w
        if __lux_tmp_316 == nil then
          __lux_tmp_316 = 0
        end
        w = __lux_module_1.mathCeil(
          __lux_module_1.mathMin(__lux_module_1.ATLAS_W - x, __lux_tmp_316)
        )
      end
      do
        local __lux_tmp_317 = h
        if __lux_tmp_317 == nil then
          __lux_tmp_317 = 0
        end
        h = __lux_module_1.mathCeil(
          __lux_module_1.mathMin(__lux_module_1.ATLAS_H - y, __lux_tmp_317)
        )
      end
      local __lux_tmp_318 = w <= 0
      if not __lux_tmp_318 then
        __lux_tmp_318 = h <= 0
      end
      if __lux_tmp_318 then
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
      local __lux_tmp_319 = __lux_module_1.renderSetColorModulation ~= nil
      if __lux_tmp_319 then
        __lux_tmp_319 = cr ~= nil
      end
      if __lux_tmp_319 then
        __lux_module_1.renderSetColorModulation(cr, cg, cb)
      end
      local __lux_tmp_320 = __lux_module_1.renderSetBlend ~= nil
      if __lux_tmp_320 then
        __lux_tmp_320 = blend ~= nil
      end
      if __lux_tmp_320 then
        __lux_module_1.renderSetBlend(blend)
      end
      return true
    end
    __lux_module_1.createAtlasMaterial = function(name, rt)
      local __lux_tmp_321 = __lux_module_1.createMaterial == nil
      if not __lux_tmp_321 then
        __lux_tmp_321 = rt == nil
      end
      local __lux_tmp_322 = __lux_tmp_321
      if not __lux_tmp_322 then
        __lux_tmp_322 = rt.GetName == nil
      end
      if __lux_tmp_322 then
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
      local __lux_tmp_323 = __lux_module_1.getRenderTargetEx == nil
      if not __lux_tmp_323 then
        __lux_tmp_323 = __lux_module_1.bitBor == nil
      end
      if __lux_tmp_323 then
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
          local __lux_obj_324 = mats
          local __lux_val_325 = nil
          if __lux_obj_324 ~= nil then
            __lux_val_325 = __lux_obj_324.compose
          end
          page.composeMat = __lux_val_325
        end
        do
          local __lux_obj_326 = mats
          local __lux_val_327 = nil
          if __lux_obj_326 ~= nil then
            __lux_val_327 = __lux_obj_326.face
          end
          page.faceMat = __lux_val_327
        end
      end
      __lux_module_1.atlasPages[index] = page
      do
        local __lux_tmp_328 = __lux_module_1.atlas
        if __lux_tmp_328 == nil then
          __lux_tmp_328 = page
        end
        __lux_module_1.atlas = __lux_tmp_328
      end
      do
        local __lux_tmp_329 = __lux_module_1.atlasMat
        if __lux_tmp_329 == nil then
          __lux_tmp_329 = pageMaterial
        end
        __lux_module_1.atlasMat = __lux_tmp_329
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
        local __lux_tmp_330 = page.generation
        if __lux_tmp_330 == nil then
          __lux_tmp_330 = 0
        end
        page.generation = __lux_tmp_330 + 1
      end
      if page.rt ~= nil then
        do
          local __lux_tmp_331 = page.w
          if __lux_tmp_331 == nil then
            __lux_tmp_331 = __lux_module_1.ATLAS_W
          end
          local __lux_tmp_332 = page.h
          if __lux_tmp_332 == nil then
            __lux_tmp_332 = __lux_module_1.ATLAS_H
          end
          __lux_module_1.clearRenderTargetAlpha(page.rt, __lux_tmp_331, __lux_tmp_332)
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
        local __lux_obj_333 = __lux_module_1.atlas
        local __lux_val_334 = nil
        if __lux_obj_333 ~= nil then
          __lux_val_334 = __lux_obj_333.material
        end
        local __lux_tmp_335 = __lux_val_334
        if __lux_tmp_335 == nil then
          __lux_tmp_335 = __lux_module_1.atlasMat
        end
        __lux_module_1.atlasMat = __lux_tmp_335
      end
    end
    __lux_module_1.tryAllocOnPage = function(page, w, h, gutter)
      if page == nil then
        return nil
      end
      local cellW = w + gutter * 2
      local cellH = h + gutter * 2
      local __lux_tmp_336 = cellW > page.w
      if not __lux_tmp_336 then
        __lux_tmp_336 = cellH > page.h
      end
      if __lux_tmp_336 then
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
        local __lux_tmp_337 = __lux_module_1.toNumber(gutter)
        if __lux_tmp_337 == nil then
          __lux_tmp_337 = 0
        end
        gutter = __lux_module_1.mathCeil(__lux_module_1.mathMax(0, __lux_tmp_337))
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
          local __lux_tmp_338 = page.h
          if __lux_tmp_338 == nil then
            __lux_tmp_338 = __lux_module_1.ATLAS_H
          end
          local __lux_tmp_339 = page.y
          if __lux_tmp_339 == nil then
            __lux_tmp_339 = 0
          end
          local __lux_tmp_340 = page.rowH
          if __lux_tmp_340 == nil then
            __lux_tmp_340 = 0
          end
          usedH = usedH + __lux_module_1.mathMin(__lux_tmp_338, __lux_tmp_339 + __lux_tmp_340)
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
      local __lux_tmp_341 = c.r
      if __lux_tmp_341 == nil then
        __lux_tmp_341 = 0
      end
      local __lux_tmp_342 = c.g
      if __lux_tmp_342 == nil then
        __lux_tmp_342 = 0
      end
      local __lux_tmp_343 = c.b
      if __lux_tmp_343 == nil then
        __lux_tmp_343 = 0
      end
      local __lux_tmp_344 = c.a
      if __lux_tmp_344 == nil then
        __lux_tmp_344 = 255
      end
      return __lux_module_1.tableConcat(
        { __lux_tmp_341, __lux_tmp_342, __lux_tmp_343, __lux_tmp_344 },
        ","
      )
    end
    __lux_module_1.isColorValue = function(value)
      local __lux_tmp_345 = __lux_module_1.style.isColor ~= nil
      if __lux_tmp_345 then
        __lux_tmp_345 = __lux_module_1.style.isColor(value)
      end
      return __lux_tmp_345
    end
    __lux_module_1.fillForRecord = function(record)
      local textStyle
      do
        local __lux_obj_346 = record
        local __lux_val_347 = nil
        if __lux_obj_346 ~= nil then
          __lux_val_347 = __lux_obj_346.style
        end
        local __lux_tmp_348 = __lux_val_347
        if __lux_tmp_348 == nil then
          __lux_tmp_348 = {}
        end
        textStyle = __lux_tmp_348
      end
      local __lux_tmp_349 = textStyle.fill
      if __lux_tmp_349 == nil then
        local __lux_tmp_350 = textStyle.color
        if __lux_tmp_350 == nil then
          local __lux_obj_351 = record
          local __lux_val_352 = nil
          if __lux_obj_351 ~= nil then
            __lux_val_352 = __lux_obj_351.color
          end
          local __lux_tmp_353 = __lux_val_352
          if __lux_tmp_353 == nil then
            __lux_tmp_353 = __lux_module_1.white
          end
          __lux_tmp_350 = __lux_tmp_353
        end
        __lux_tmp_349 = __lux_tmp_350
      end
      return __lux_tmp_349
    end
    __lux_module_1.fillNeedsShader = function(fill)
      local __lux_tmp_354 = __lux_module_1.typeOf(fill) == "table"
      if __lux_tmp_354 then
        __lux_tmp_354 = not __lux_module_1.isColorValue(fill)
      end
      local __lux_tmp_355 = __lux_tmp_354
      if __lux_tmp_355 then
        __lux_tmp_355 = fill.kind ~= nil
      end
      return __lux_tmp_355
    end
    __lux_module_1.normalizeSurface = function(value)
      local __lux_tmp_356 = value == nil
      if not __lux_tmp_356 then
        __lux_tmp_356 = value == false
      end
      if __lux_tmp_356 then
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
        local __lux_tmp_357 = value.strength
        if __lux_tmp_357 == nil then
          __lux_tmp_357 = value[1]
        end
        local __lux_tmp_358 = __lux_module_1.toNumber(__lux_tmp_357)
        if __lux_tmp_358 == nil then
          __lux_tmp_358 = 0.18
        end
        strength = __lux_module_1.mathClamp(__lux_tmp_358, 0, 1)
      end
      if strength <= 0 then
        return nil
      end
      return { strength = strength }
    end
    __lux_module_1.normalizeWeightAdjust = function(textStyle)
      do
        local __lux_tmp_359 = textStyle
        if __lux_tmp_359 == nil then
          __lux_tmp_359 = {}
        end
        textStyle = __lux_tmp_359
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
        local __lux_tmp_360 = textStyle.stroke
        if __lux_tmp_360 == nil then
          __lux_tmp_360 = textStyle.outline
        end
        stroke = __lux_module_1.normalizeStroke(__lux_tmp_360)
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
      local __lux_tmp_361
      if stroke ~= nil then
        __lux_tmp_361 = stroke.width ..
          ":" ..
            stroke.samples .. ":" .. stroke.softness .. ":" .. __lux_module_1.colorKey(stroke.color)
      else
        __lux_tmp_361 = ""
      end
      local __lux_tmp_362
      if glow ~= nil then
        do
          local __lux_tmp_363 = glow.falloff
          if __lux_tmp_363 == nil then
            __lux_tmp_363 = ""
          end
          __lux_tmp_362 = glow.width ..
            ":" ..
              glow.strength .. ":" .. __lux_tmp_363 .. ":" .. __lux_module_1.colorKey(glow.color)
        end
      else
        __lux_tmp_362 = ""
      end
      local __lux_tmp_364
      if shadow ~= nil then
        __lux_tmp_364 = shadow.x ..
          ":" ..
            shadow.y ..
              ":" ..
                shadow.blur .. ":" .. shadow.strength .. ":" .. __lux_module_1.colorKey(shadow.color)
      else
        __lux_tmp_364 = ""
      end
      local __lux_tmp_365
      if face ~= nil then
        __lux_tmp_365 = __lux_module_1.toString(face.strength)
      else
        __lux_tmp_365 = ""
      end
      local __lux_tmp_366 = weightAdjust
      if __lux_tmp_366 == nil then
        __lux_tmp_366 = 0
      end
      return __lux_module_1.tableConcat(
        {
          __lux_tmp_361,
          __lux_tmp_362,
          __lux_tmp_364,
          __lux_tmp_365,
          __lux_module_1.toString(__lux_tmp_366),
        },
        "31"
      )
    end
    __lux_module_1.effectInfo = function(textStyle)
      do
        local __lux_tmp_367 = textStyle
        if __lux_tmp_367 == nil then
          __lux_tmp_367 = {}
        end
        textStyle = __lux_tmp_367
      end
      local __lux_tmp_368 = __lux_module_1.typeOf(textStyle) == "table"
      if __lux_tmp_368 then
        __lux_tmp_368 = textStyle.__mgfxTextEffectInfo ~= nil
      end
      if __lux_tmp_368 then
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
      local __lux_tmp_369 = __lux_module_1.typeOf(textStyle) == "table"
      if __lux_tmp_369 then
        __lux_tmp_369 = textStyle[__lux_module_1.RESOLVED_STYLE_MARK] == true
      end
      if __lux_tmp_369 then
        textStyle.__mgfxTextEffectInfo = info
      end
      return info
    end
    __lux_module_1.fastEntryKey = function(record, textStyle, info)
      local nativeFont, alias, oversample = __lux_module_1.nativeFor(record.font, textStyle)
      local tracking
      do
        local __lux_tmp_370 = textStyle.tracking
        if __lux_tmp_370 == nil then
          __lux_tmp_370 = textStyle.letterSpacing
        end
        local __lux_tmp_371 = __lux_module_1.toNumber(__lux_tmp_370)
        if __lux_tmp_371 == nil then
          local __lux_tmp_372 = alias.tracking
          if __lux_tmp_372 == nil then
            __lux_tmp_372 = 0
          end
          __lux_tmp_371 = __lux_tmp_372
        end
        tracking = __lux_tmp_371
      end
      local lineHeight = __lux_module_1.lineHeightFor(nativeFont, alias, textStyle, oversample)
      local __lux_tmp_373 = record.text
      if __lux_tmp_373 == nil then
        __lux_tmp_373 = ""
      end
      local __lux_tmp_374 = record.font
      if __lux_tmp_374 == nil then
        __lux_tmp_374 = ""
      end
      local __lux_tmp_375 = nativeFont
      if __lux_tmp_375 == nil then
        __lux_tmp_375 = ""
      end
      local __lux_tmp_376 = oversample
      if __lux_tmp_376 == nil then
        __lux_tmp_376 = 1
      end
      local __lux_obj_377 = info
      local __lux_val_378 = nil
      if __lux_obj_377 ~= nil then
        __lux_val_378 = __lux_obj_377.routeKey
      end
      local __lux_tmp_379 = __lux_val_378
      if __lux_tmp_379 == nil then
        __lux_tmp_379 = ""
      end
      return __lux_module_1.CACHE_VERSION ..
        "30" ..
          __lux_module_1.toString(__lux_tmp_373) ..
            "30" ..
              __lux_module_1.toString(__lux_tmp_374) ..
                "30" ..
                  __lux_module_1.toString(__lux_tmp_375) ..
                    "30" ..
                      __lux_module_1.toString(__lux_tmp_376) ..
                        "30" ..
                          __lux_module_1.toString(tracking) ..
                            "30" ..
                              __lux_module_1.toString(lineHeight) .. "30" .. __lux_module_1.toString(__lux_tmp_379)
    end
    __lux_module_1.drawUV = function(material, x, y, w, h, u0, v0, u1, v1, color)
      local __lux_tmp_380 = material == nil
      if not __lux_tmp_380 then
        __lux_tmp_380 = __lux_module_1.surfaceSetMaterial == nil
      end
      local __lux_tmp_381 = __lux_tmp_380
      if not __lux_tmp_381 then
        __lux_tmp_381 = __lux_module_1.surfaceSetDrawColor == nil
      end
      local __lux_tmp_382 = __lux_tmp_381
      if not __lux_tmp_382 then
        __lux_tmp_382 = __lux_module_1.surfaceDrawPoly == nil
      end
      if __lux_tmp_382 then
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
        local __lux_tmp_383 = c.r
        if __lux_tmp_383 == nil then
          __lux_tmp_383 = 255
        end
        local __lux_tmp_384 = c.g
        if __lux_tmp_384 == nil then
          __lux_tmp_384 = 255
        end
        local __lux_tmp_385 = c.b
        if __lux_tmp_385 == nil then
          __lux_tmp_385 = 255
        end
        local __lux_tmp_386 = c.a
        if __lux_tmp_386 == nil then
          __lux_tmp_386 = 255
        end
        __lux_module_1.surfaceSetDrawColor(
          __lux_tmp_383,
          __lux_tmp_384,
          __lux_tmp_385,
          __lux_tmp_386
        )
      end
      __lux_module_1.surfaceDrawPoly(__lux_module_1.atlasQuad)
      return true
    end
    __lux_module_1.bakeEntry = function(record, key, layout, shadow, stroke, glow, face, weightAdjust, pad, gutter, stats)
      local oversample = __lux_module_1.normalizeOversample(layout.oversample)
      local atlasW = __lux_module_1.mathCeil((layout.w + pad * 2) * oversample)
      local atlasH = __lux_module_1.mathCeil((layout.h + pad * 2) * oversample)
      local __lux_tmp_387 = atlasW <= 0
      if not __lux_tmp_387 then
        __lux_tmp_387 = atlasH <= 0
      end
      local __lux_tmp_388 = __lux_tmp_387
      if not __lux_tmp_388 then
        __lux_tmp_388 = atlasW > __lux_module_1.ATLAS_W
      end
      local __lux_tmp_389 = __lux_tmp_388
      if not __lux_tmp_389 then
        __lux_tmp_389 = atlasH > __lux_module_1.ATLAS_H
      end
      if __lux_tmp_389 then
        return nil
      end
      local allocGutter = gutter * oversample
      local page, slotX, slotY = __lux_module_1.allocAtlasSlot(atlasW, atlasH, allocGutter)
      local __lux_tmp_390 = page == nil
      if not __lux_tmp_390 then
        __lux_tmp_390 = slotX == nil
      end
      if __lux_tmp_390 then
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
        local __lux_tmp_391 = shaderCapableFace
        if __lux_tmp_391 then
          local __lux_tmp_392 = face ~= nil
          if not __lux_tmp_392 then
            local __lux_tmp_393 = weightAdjust
            if __lux_tmp_393 == nil then
              __lux_tmp_393 = 0
            end
            local __lux_cmp_394 = false
            if __lux_module_1.mathAbs(__lux_tmp_393) ~= nil and 0.001 ~= nil then
              __lux_cmp_394 = __lux_module_1.mathAbs(__lux_tmp_393) > 0.001
            end
            __lux_tmp_392 = __lux_cmp_394
          end
          __lux_tmp_391 = __lux_tmp_392
        end
        shaderFace = __lux_tmp_391
      end
      local __lux_tmp_395 = not shaderFace
      if __lux_tmp_395 then
        __lux_tmp_395 = shaderCapableFace
      end
      if __lux_tmp_395 then
        do
          local __lux_tmp_396 = shadow ~= nil
          if not __lux_tmp_396 then
            __lux_tmp_396 = stroke ~= nil
          end
          local __lux_tmp_397 = __lux_tmp_396
          if not __lux_tmp_397 then
            __lux_tmp_397 = glow ~= nil
          end
          shaderFace = __lux_tmp_397
        end
      end
      local entry
      do
        local __lux_tmp_398 = weightAdjust
        if __lux_tmp_398 == nil then
          __lux_tmp_398 = 0
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
          weightAdjust = __lux_tmp_398,
          shaderFace = shaderFace,
          generation = page.generation,
        }
      end
      __lux_module_1.composedCache[key] = entry
      __lux_module_1.composedCacheCount = __lux_module_1.composedCacheCount + 1
      do
        local __lux_tmp_399 = stats
        if __lux_tmp_399 == nil then
          __lux_tmp_399 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_399, "textComposedBakes")
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
      local __lux_tmp_400 = not __lux_module_1.textComposedEnabled()
      if not __lux_tmp_400 then
        __lux_tmp_400 = not __lux_module_1.ensureTargets()
      end
      if __lux_tmp_400 then
        return nil
      end
      local textStyle
      do
        local __lux_tmp_401 = record.style
        if __lux_tmp_401 == nil then
          __lux_tmp_401 = {}
        end
        textStyle = __lux_tmp_401
      end
      local __lux_tmp_402 = textStyle.noComposed
      if not __lux_tmp_402 then
        __lux_tmp_402 = textStyle.native == true
      end
      if __lux_tmp_402 then
        return nil
      end
      local info = __lux_module_1.effectInfo(textStyle)
      local key
      do
        local __lux_tmp_403 = record.__mgfxTextEntryKey
        if __lux_tmp_403 == nil then
          __lux_tmp_403 = __lux_module_1.fastEntryKey(record, textStyle, info)
        end
        key = __lux_tmp_403
      end
      record.__mgfxTextEntryKey = key
      __lux_module_1.composedTick = __lux_module_1.composedTick + 1
      local cached = __lux_module_1.composedCache[key]
      local __lux_tmp_404 = cached ~= nil
      if __lux_tmp_404 then
        __lux_tmp_404 = cached.page ~= nil
      end
      local __lux_tmp_405 = __lux_tmp_404
      if __lux_tmp_405 then
        __lux_tmp_405 = cached.generation == cached.page.generation
      end
      if __lux_tmp_405 then
        cached.tick = __lux_module_1.composedTick
        do
          local __lux_tmp_406 = stats
          if __lux_tmp_406 == nil then
            __lux_tmp_406 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_406, "textEntryCacheHits")
        end
        return cached
      end
      do
        local __lux_tmp_407 = stats
        if __lux_tmp_407 == nil then
          __lux_tmp_407 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_407, "textEntryCacheMisses")
      end
      local __lux_tmp_408 = not prewarm
      if __lux_tmp_408 then
        local __lux_cmp_409 = false
        if __lux_module_1.bakesThisFrame ~= nil and __lux_module_1.textComposeBudget() ~= nil then
          __lux_cmp_409 = __lux_module_1.bakesThisFrame >= __lux_module_1.textComposeBudget()
        end
        __lux_tmp_408 = __lux_cmp_409
      end
      if __lux_tmp_408 then
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
      local textStyle
      do
        local __lux_tmp_410 = record.style
        if __lux_tmp_410 == nil then
          __lux_tmp_410 = {}
        end
        textStyle = __lux_tmp_410
      end
      local info = __lux_module_1.effectInfo(textStyle)
      local __lux_tmp_411 = info.shadow ~= nil
      if not __lux_tmp_411 then
        __lux_tmp_411 = info.stroke ~= nil
      end
      local __lux_tmp_412 = __lux_tmp_411
      if not __lux_tmp_412 then
        __lux_tmp_412 = info.glow ~= nil
      end
      local __lux_tmp_413 = __lux_tmp_412
      if not __lux_tmp_413 then
        __lux_tmp_413 = info.face ~= nil
      end
      local __lux_tmp_414 = __lux_tmp_413
      if not __lux_tmp_414 then
        local __lux_tmp_415 = info.weightAdjust
        if __lux_tmp_415 == nil then
          __lux_tmp_415 = 0
        end
        local __lux_cmp_416 = false
        if __lux_module_1.mathAbs(__lux_tmp_415) ~= nil and 0.001 ~= nil then
          __lux_cmp_416 = __lux_module_1.mathAbs(__lux_tmp_415) > 0.001
        end
        __lux_tmp_414 = __lux_cmp_416
      end
      local __lux_tmp_417 = __lux_tmp_414
      if not __lux_tmp_417 then
        __lux_tmp_417 = __lux_module_1.fillNeedsShader(__lux_module_1.fillForRecord(record))
      end
      return __lux_tmp_417
    end
    __lux_module_1.recordNeedsComposedEntry = function(record)
      local textStyle
      do
        local __lux_tmp_418 = record.style
        if __lux_tmp_418 == nil then
          __lux_tmp_418 = {}
        end
        textStyle = __lux_tmp_418
      end
      local __lux_tmp_419 = textStyle.noComposed
      if not __lux_tmp_419 then
        __lux_tmp_419 = textStyle.native == true
      end
      if __lux_tmp_419 then
        return false
      end
      return __lux_module_1.recordHasShaderWork(record)
    end
    __lux_module_1.prepareTextRoutes = function(records)
      local composeCount = 0
      do
        local __lux_tmp_420 = records
        if __lux_tmp_420 == nil then
          __lux_tmp_420 = {}
        end
        for _, record in ipairs(__lux_tmp_420) do
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
      local __lux_tmp_421 = records == nil
      if not __lux_tmp_421 then
        __lux_tmp_421 = #records <= 1
      end
      if __lux_tmp_421 then
        return true
      end
      local __lux_tmp_422 = not __lux_module_1.textComposedEnabled()
      if not __lux_tmp_422 then
        __lux_tmp_422 = not __lux_module_1.ensureTargets()
      end
      if __lux_tmp_422 then
        do
          local __lux_tmp_423 = stats
          if __lux_tmp_423 == nil then
            __lux_tmp_423 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_423, "textComposedPrewarmFails")
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
                local __lux_tmp_424 = stats
                if __lux_tmp_424 == nil then
                  __lux_tmp_424 = {}
                end
                __lux_module_1.statAdd(__lux_tmp_424, "textComposedPrewarmFails")
              end
              return false
            end
            record.__mgfxTextEntry = entry
            if __lux_module_1.atlasEpoch ~= generation then
              do
                local __lux_tmp_425 = stats
                if __lux_tmp_425 == nil then
                  __lux_tmp_425 = {}
                end
                __lux_module_1.statAdd(__lux_tmp_425, "textComposedPrewarmRestarts")
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
        local __lux_tmp_426 = stats
        if __lux_tmp_426 == nil then
          __lux_tmp_426 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_426, "textComposedPrewarmFails")
      end
      return false
    end
    __lux_module_1.hasShaderFx = function(entry)
      local __lux_tmp_427 = entry ~= nil
      if __lux_tmp_427 then
        local __lux_tmp_428 = entry.shadow ~= nil
        if not __lux_tmp_428 then
          __lux_tmp_428 = entry.stroke ~= nil
        end
        local __lux_tmp_429 = __lux_tmp_428
        if not __lux_tmp_429 then
          __lux_tmp_429 = entry.glow ~= nil
        end
        local __lux_tmp_430 = __lux_tmp_429
        if not __lux_tmp_430 then
          __lux_tmp_430 = entry.face ~= nil
        end
        local __lux_tmp_431 = __lux_tmp_430
        if not __lux_tmp_431 then
          local __lux_tmp_432 = entry.weightAdjust
          if __lux_tmp_432 == nil then
            __lux_tmp_432 = 0
          end
          __lux_tmp_431 = __lux_tmp_432 ~= 0
        end
        __lux_tmp_427 = __lux_tmp_431
      end
      return __lux_tmp_427
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
        local __lux_tmp_433 = effect.color
        if __lux_tmp_433 == nil then
          __lux_tmp_433 = __lux_module_1.white
        end
        r, g, b, a = __lux_module_1.style.color01(__lux_tmp_433)
      end
      return r, g, b, __lux_module_1.mathClamp(a * scale, 0, 1)
    end
    __lux_module_1.packShadowParams = function(x, y, stroke)
      do
        local __lux_tmp_434 = __lux_module_1.toNumber(x)
        if __lux_tmp_434 == nil then
          __lux_tmp_434 = 0
        end
        x = __lux_module_1.mathClamp(__lux_tmp_434, -64, 63.5)
      end
      do
        local __lux_tmp_435 = __lux_module_1.toNumber(y)
        if __lux_tmp_435 == nil then
          __lux_tmp_435 = 0
        end
        y = __lux_module_1.mathClamp(__lux_tmp_435, -64, 63.5)
      end
      local xb = __lux_module_1.mathClamp(__lux_module_1.mathFloor((x + 64) * 2 + 0.5), 0, 255)
      local yb = __lux_module_1.mathClamp(__lux_module_1.mathFloor((y + 64) * 2 + 0.5), 0, 255)
      local softness
      do
        local __lux_obj_436 = stroke
        local __lux_val_437 = nil
        if __lux_obj_436 ~= nil then
          __lux_val_437 = __lux_obj_436.softness
        end
        local __lux_tmp_438 = __lux_val_437
        if __lux_tmp_438 == nil then
          __lux_tmp_438 = 0
        end
        softness = __lux_tmp_438
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
        local __lux_obj_439 = shadow
        local __lux_val_440 = nil
        if __lux_obj_439 ~= nil then
          __lux_val_440 = __lux_obj_439.blur
        end
        local __lux_tmp_441 = __lux_val_440
        if __lux_tmp_441 == nil then
          __lux_tmp_441 = 0
        end
        blur = __lux_tmp_441
      end
      local falloff
      do
        local __lux_obj_442 = glow
        local __lux_val_443 = nil
        if __lux_obj_442 ~= nil then
          __lux_val_443 = __lux_obj_442.falloff
        end
        local __lux_tmp_444 = __lux_val_443
        if __lux_tmp_444 == nil then
          __lux_tmp_444 = 1.65
        end
        falloff = __lux_tmp_444
      end
      local faceStrength
      do
        local __lux_obj_445 = face
        local __lux_val_446 = nil
        if __lux_obj_445 ~= nil then
          __lux_val_446 = __lux_obj_445.strength
        end
        local __lux_tmp_447 = __lux_val_446
        if __lux_tmp_447 == nil then
          __lux_tmp_447 = 0
        end
        faceStrength = __lux_tmp_447
      end
      local weight
      do
        local __lux_tmp_448 = __lux_module_1.toNumber(weightAdjust)
        if __lux_tmp_448 == nil then
          __lux_tmp_448 = 0
        end
        weight = __lux_module_1.mathClamp(__lux_tmp_448, -2, 2)
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
        local __lux_obj_449 = glow
        local __lux_val_450 = nil
        if __lux_obj_449 ~= nil then
          __lux_val_450 = __lux_obj_449.strength
        end
        local __lux_tmp_451 = __lux_val_450
        if __lux_tmp_451 == nil then
          __lux_tmp_451 = 1
        end
        r, g, b, a = __lux_module_1.scaledColor01(glow, __lux_tmp_451)
      end
      material:SetFloat("$c1_x", r)
      material:SetFloat("$c1_y", g)
      material:SetFloat("$c1_z", b)
      material:SetFloat("$c1_w", a)
      do
        local __lux_obj_452 = shadow
        local __lux_val_453 = nil
        if __lux_obj_452 ~= nil then
          __lux_val_453 = __lux_obj_452.strength
        end
        local __lux_tmp_454 = __lux_val_453
        if __lux_tmp_454 == nil then
          __lux_tmp_454 = 1
        end
        r, g, b, a = __lux_module_1.scaledColor01(shadow, __lux_tmp_454)
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
        local __lux_obj_455 = scaledStroke
        local __lux_val_456 = nil
        if __lux_obj_455 ~= nil then
          __lux_val_456 = __lux_obj_455.width
        end
        local __lux_tmp_457 = __lux_val_456
        if __lux_tmp_457 == nil then
          __lux_tmp_457 = 0
        end
        material:SetFloat("$c3_x", __lux_tmp_457)
      end
      do
        local __lux_tmp_458
        if glow ~= nil then
          __lux_tmp_458 = glow.width * oversample
        else
          __lux_tmp_458 = 0
        end
        material:SetFloat("$c3_y", __lux_tmp_458)
      end
      do
        local __lux_tmp_459 = entry.weightAdjust
        if __lux_tmp_459 == nil then
          __lux_tmp_459 = 0
        end
        material:SetFloat(
          "$c3_z",
          __lux_module_1.packEffectParams(
            glow,
            scaledShadow,
            face,
            __lux_tmp_459 * oversample,
            entry.shaderFace
          )
        )
      end
      local __lux_tmp_460
      if scaledShadow ~= nil then
        __lux_tmp_460 = __lux_module_1.packShadowParams(scaledShadow.x, scaledShadow.y, scaledStroke)
      else
        __lux_tmp_460 = __lux_module_1.packShadowParams(0, 0, scaledStroke)
      end
      return material:SetFloat("$c3_w", __lux_tmp_460)
    end
    __lux_module_1.fillEndpointColors = function(fill, fallback)
      if __lux_module_1.isColorValue(fill) then
        return fill, fill
      end
      local __lux_tmp_461 = __lux_module_1.typeOf(fill) == "table"
      if __lux_tmp_461 then
        __lux_tmp_461 = __lux_module_1.typeOf(fill.stops) == "table"
      end
      local __lux_tmp_462 = __lux_tmp_461
      if __lux_tmp_462 then
        __lux_tmp_462 = #fill.stops > 0
      end
      if __lux_tmp_462 then
        local first = fill.stops[1]
        local last = fill.stops[#fill.stops]
        local __lux_tmp_463 = first.color
        if __lux_tmp_463 == nil then
          __lux_tmp_463 = first[2]
        end
        local __lux_tmp_464 = fallback
        if __lux_tmp_464 == nil then
          __lux_tmp_464 = __lux_module_1.white
        end
        local __lux_tmp_465 = last.color
        if __lux_tmp_465 == nil then
          __lux_tmp_465 = last[2]
        end
        local __lux_tmp_466 = fallback
        if __lux_tmp_466 == nil then
          __lux_tmp_466 = __lux_module_1.white
        end
        return __lux_module_1.style.asColor(__lux_tmp_463, __lux_tmp_464), __lux_module_1.style.asColor(__lux_tmp_465, __lux_tmp_466)
      end
      if __lux_module_1.typeOf(fill) == "table" then
        local a
        do
          local __lux_tmp_467 = fill.colorA
          if __lux_tmp_467 == nil then
            __lux_tmp_467 = fill[1]
          end
          local __lux_tmp_468 = fallback
          if __lux_tmp_468 == nil then
            __lux_tmp_468 = __lux_module_1.white
          end
          a = __lux_module_1.style.asColor(__lux_tmp_467, __lux_tmp_468)
        end
        local __lux_tmp_469 = fill.colorB
        if __lux_tmp_469 == nil then
          __lux_tmp_469 = fill[2]
        end
        return a, __lux_module_1.style.asColor(__lux_tmp_469, a)
      end
      local c
      do
        local __lux_tmp_470 = fallback
        if __lux_tmp_470 == nil then
          __lux_tmp_470 = __lux_module_1.white
        end
        c = __lux_module_1.style.asColor(fill, __lux_tmp_470)
      end
      return c, c
    end
    __lux_module_1.setupTextFaceMaterial = function(material, entry, record, u0, v0, u1, v1, fillOverride)
      local fill
      do
        local __lux_tmp_471 = fillOverride
        if __lux_tmp_471 == nil then
          __lux_tmp_471 = __lux_module_1.fillForRecord(record)
        end
        fill = __lux_tmp_471
      end
      local colorA, colorB
      do
        local __lux_tmp_472 = record.color
        if __lux_tmp_472 == nil then
          __lux_tmp_472 = __lux_module_1.white
        end
        colorA, colorB = __lux_module_1.fillEndpointColors(fill, __lux_tmp_472)
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
      local __lux_tmp_473 = __lux_module_1.typeOf(fill) == "table"
      if __lux_tmp_473 then
        __lux_tmp_473 = fill.kind == 1
      end
      if __lux_tmp_473 then
        do
          local __lux_tmp_474 = __lux_module_1.toNumber(fill.x1)
          if __lux_tmp_474 == nil then
            __lux_tmp_474 = 0
          end
          material:SetFloat("$c3_x", __lux_tmp_474)
        end
        do
          local __lux_tmp_475 = __lux_module_1.toNumber(fill.y1)
          if __lux_tmp_475 == nil then
            __lux_tmp_475 = 0
          end
          material:SetFloat("$c3_y", __lux_tmp_475)
        end
        do
          local __lux_tmp_476 = __lux_module_1.toNumber(fill.x2)
          if __lux_tmp_476 == nil then
            __lux_tmp_476 = 1
          end
          material:SetFloat("$c3_z", __lux_tmp_476)
        end
        do
          local __lux_tmp_477 = __lux_module_1.toNumber(fill.y2)
          if __lux_tmp_477 == nil then
            __lux_tmp_477 = 0
          end
          material:SetFloat("$c3_w", __lux_tmp_477)
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
        local __lux_obj_478 = entry
        local __lux_val_479 = nil
        if __lux_obj_478 ~= nil then
          __lux_val_479 = __lux_obj_478.page
        end
        local __lux_tmp_480 = __lux_val_479
        if __lux_tmp_480 == nil then
          __lux_tmp_480 = __lux_module_1.atlas
        end
        page = __lux_tmp_480
      end
      local __lux_tmp_481 = page == nil
      if not __lux_tmp_481 then
        __lux_tmp_481 = entry.generation ~= page.generation
      end
      if __lux_tmp_481 then
        return nil
      end
      local x = contentX - entry.originX
      local y = contentY - entry.originY
      x, y = __lux_module_1.snapTextPos(x, y, record.style)
      local u0 = entry.slotX / page.w
      local v0 = entry.slotY / page.h
      local u1
      do
        local __lux_tmp_482 = entry.atlasW
        if __lux_tmp_482 == nil then
          __lux_tmp_482 = entry.w
        end
        u1 = (entry.slotX + __lux_tmp_482) / page.w
      end
      local v1
      do
        local __lux_tmp_483 = entry.atlasH
        if __lux_tmp_483 == nil then
          __lux_tmp_483 = entry.h
        end
        v1 = (entry.slotY + __lux_tmp_483) / page.h
      end
      local fx = __lux_module_1.hasShaderFx(entry)
      local faceMat
      do
        local __lux_tmp_484 = __lux_module_1.isMaterialOK(page.faceMat)
        if __lux_tmp_484 then
          __lux_tmp_484 = page.faceMat
        end
        local __lux_tmp_485 = __lux_tmp_484
        if not __lux_tmp_485 then
          local __lux_tmp_486 = __lux_module_1.isMaterialOK(__lux_module_1.materials.text_face)
          if __lux_tmp_486 then
            __lux_tmp_486 = __lux_module_1.materials.text_face
          end
          __lux_tmp_485 = __lux_tmp_486
        end
        local __lux_tmp_487 = __lux_tmp_485
        if not __lux_tmp_487 then
          __lux_tmp_487 = page.material
        end
        local __lux_tmp_488 = __lux_tmp_487
        if not __lux_tmp_488 then
          __lux_tmp_488 = __lux_module_1.atlasMat
        end
        faceMat = __lux_tmp_488
      end
      local composeMat
      do
        local __lux_tmp_489 = __lux_module_1.isMaterialOK(page.composeMat)
        if __lux_tmp_489 then
          __lux_tmp_489 = page.composeMat
        end
        local __lux_tmp_490 = __lux_tmp_489
        if not __lux_tmp_490 then
          __lux_tmp_490 = __lux_module_1.materials.text_compose
        end
        composeMat = __lux_tmp_490
      end
      local material
      do
        local __lux_tmp_491 = fx
        if __lux_tmp_491 then
          __lux_tmp_491 = composeMat
        end
        local __lux_tmp_492 = __lux_tmp_491
        if not __lux_tmp_492 then
          __lux_tmp_492 = faceMat
        end
        material = __lux_tmp_492
      end
      local __lux_tmp_493 = fx
      if __lux_tmp_493 then
        __lux_tmp_493 = __lux_module_1.isMaterialOK(material)
      end
      if __lux_tmp_493 then
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
      local __lux_tmp_494 = fx
      if __lux_tmp_494 then
        __lux_tmp_494 = entry.shaderFace
      end
      if __lux_tmp_494 then
        do
          local __lux_tmp_495 = fillOverride
          if __lux_tmp_495 == nil then
            __lux_tmp_495 = __lux_module_1.fillForRecord(record)
          end
          local __lux_tmp_496 = record.color
          if __lux_tmp_496 == nil then
            __lux_tmp_496 = __lux_module_1.white
          end
          drawColor = __lux_module_1.style.asColor(__lux_tmp_495, __lux_tmp_496)
        end
      end
      if not __lux_module_1.drawUV(material, x, y, entry.w, entry.h, u0, v0, u1, v1, drawColor) then
        return nil
      end
      local blits = 1
      local __lux_tmp_497 = fx
      if __lux_tmp_497 then
        __lux_tmp_497 = not entry.shaderFace
      end
      local __lux_tmp_498 = __lux_tmp_497
      if __lux_tmp_498 then
        __lux_tmp_498 = faceMat ~= nil
      end
      if __lux_tmp_498 then
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
        local __lux_tmp_499 = stats
        if __lux_tmp_499 == nil then
          __lux_tmp_499 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_499, "textComposedBlits", blits)
      end
      if fx then
        do
          local __lux_tmp_500 = stats
          if __lux_tmp_500 == nil then
            __lux_tmp_500 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_500, "textShaderDraws")
        end
      end
      return fx
    end
    __lux_module_1.blitEntry = function(entry, record, stats)
      local contentX
      do
        local __lux_tmp_501 = record.x
        if __lux_tmp_501 == nil then
          __lux_tmp_501 = 0
        end
        contentX = __lux_tmp_501 - entry.contentW * __lux_module_1.alignFactor(record.alignX)
      end
      local contentY
      do
        local __lux_tmp_502 = record.y
        if __lux_tmp_502 == nil then
          __lux_tmp_502 = 0
        end
        contentY = __lux_tmp_502 - entry.contentH * __lux_module_1.alignFactor(record.alignY, true)
      end
      local fx = __lux_module_1.drawEntryAt(entry, record, contentX, contentY, nil, stats)
      if fx == nil then
        __lux_module_1.drawNativeFallbackRecord(record)
        do
          local __lux_tmp_503 = stats
          if __lux_tmp_503 == nil then
            __lux_tmp_503 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_503, "textComposedFallbackRecords")
        end
        return nil
      end
      do
        local __lux_tmp_504 = stats
        if __lux_tmp_504 == nil then
          __lux_tmp_504 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_504, "textComposedDraws")
      end
      if fx then
        do
          local __lux_tmp_505 = stats
          if __lux_tmp_505 == nil then
            __lux_tmp_505 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_505, "textComposedFxDraws")
        end
      else
        do
          local __lux_tmp_506 = stats
          if __lux_tmp_506 == nil then
            __lux_tmp_506 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_506, "textComposedFaceDraws")
        end
      end
      return fx
    end
    __lux_module_1.textBatchKey = function(entry, record)
      local page
      do
        local __lux_obj_507 = entry
        local __lux_val_508 = nil
        if __lux_obj_507 ~= nil then
          __lux_val_508 = __lux_obj_507.page
        end
        page = __lux_val_508
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
        local __lux_tmp_509 = page.index
        if __lux_tmp_509 == nil then
          __lux_tmp_509 = 0
        end
        return "plain27" .. __lux_module_1.toString(__lux_tmp_509)
      end
      if not entry.shaderFace then
        return nil
      end
      if entry.batchKey ~= nil then
        return entry.batchKey
      end
      do
        local __lux_tmp_510 = page.index
        if __lux_tmp_510 == nil then
          __lux_tmp_510 = 0
        end
        local __lux_tmp_511 = entry.oversample
        if __lux_tmp_511 == nil then
          __lux_tmp_511 = 1
        end
        local __lux_tmp_512
        if entry.stroke ~= nil then
          __lux_tmp_512 = entry.stroke.width ..
            ":" .. entry.stroke.softness .. ":" .. __lux_module_1.colorKey(entry.stroke.color)
        else
          __lux_tmp_512 = ""
        end
        local __lux_tmp_513
        if entry.glow ~= nil then
          do
            local __lux_tmp_514 = entry.glow.falloff
            if __lux_tmp_514 == nil then
              __lux_tmp_514 = ""
            end
            __lux_tmp_513 = entry.glow.width ..
              ":" ..
                entry.glow.strength ..
                  ":" .. __lux_tmp_514 .. ":" .. __lux_module_1.colorKey(entry.glow.color)
          end
        else
          __lux_tmp_513 = ""
        end
        local __lux_tmp_515
        if entry.shadow ~= nil then
          __lux_tmp_515 = entry.shadow.x ..
            ":" ..
              entry.shadow.y ..
                ":" ..
                  entry.shadow.blur ..
                    ":" .. entry.shadow.strength .. ":" .. __lux_module_1.colorKey(entry.shadow.color)
        else
          __lux_tmp_515 = ""
        end
        local __lux_tmp_516
        if entry.face ~= nil then
          __lux_tmp_516 = __lux_module_1.toString(entry.face.strength)
        else
          __lux_tmp_516 = ""
        end
        local __lux_tmp_517 = entry.weightAdjust
        if __lux_tmp_517 == nil then
          __lux_tmp_517 = 0
        end
        entry.batchKey = __lux_module_1.tableConcat(
          {
            __lux_tmp_510,
            __lux_tmp_511,
            __lux_tmp_512,
            __lux_tmp_513,
            __lux_tmp_515,
            __lux_tmp_516,
            __lux_module_1.toString(__lux_tmp_517),
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
        local __lux_tmp_518 = color.r
        if __lux_tmp_518 == nil then
          __lux_tmp_518 = 255
        end
        local __lux_tmp_519 = color.g
        if __lux_tmp_519 == nil then
          __lux_tmp_519 = 255
        end
        local __lux_tmp_520 = color.b
        if __lux_tmp_520 == nil then
          __lux_tmp_520 = 255
        end
        local __lux_tmp_521 = color.a
        if __lux_tmp_521 == nil then
          __lux_tmp_521 = 255
        end
        __lux_module_1.meshColor(__lux_tmp_518, __lux_tmp_519, __lux_tmp_520, __lux_tmp_521)
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
        local __lux_tmp_522 = entry.atlasW
        if __lux_tmp_522 == nil then
          __lux_tmp_522 = entry.w
        end
        u1 = (entry.slotX + __lux_tmp_522) / page.w
      end
      local v1
      do
        local __lux_tmp_523 = entry.atlasH
        if __lux_tmp_523 == nil then
          __lux_tmp_523 = entry.h
        end
        v1 = (entry.slotY + __lux_tmp_523) / page.h
      end
      local c
      do
        local __lux_tmp_524 = record.__mgfxBatchColor
        if __lux_tmp_524 == nil then
          __lux_tmp_524 = __lux_module_1.white
        end
        c = __lux_tmp_524
      end
      __lux_module_1.meshVertex(x, y, u0, v0, c)
      __lux_module_1.meshVertex(x + w, y, u1, v0, c)
      __lux_module_1.meshVertex(x + w, y + h, u1, v1, c)
      __lux_module_1.meshVertex(x, y, u0, v0, c)
      __lux_module_1.meshVertex(x + w, y + h, u1, v1, c)
      return __lux_module_1.meshVertex(x, y + h, u0, v1, c)
    end
    __lux_module_1.flushTextComposeBatch = function(batch, stats)
      local __lux_tmp_525 = batch == nil
      if not __lux_tmp_525 then
        __lux_tmp_525 = #batch == 0
      end
      if __lux_tmp_525 then
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
          local __lux_tmp_526 = stats
          if __lux_tmp_526 == nil then
            __lux_tmp_526 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_526, "textComposedDraws")
        end
        do
          local __lux_tmp_527 = stats
          if __lux_tmp_527 == nil then
            __lux_tmp_527 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_527, "textComposedFxDraws")
        end
        return true
      end
      local first = batch[1]
      local firstEntry = first.__mgfxTextEntry
      for index = 1, #batch do
        local entry = batch[index].__mgfxTextEntry
        local __lux_tmp_528 = entry == nil
        if not __lux_tmp_528 then
          __lux_tmp_528 = entry.page == nil
        end
        local __lux_tmp_529 = __lux_tmp_528
        if not __lux_tmp_529 then
          __lux_tmp_529 = entry.generation ~= entry.page.generation
        end
        if __lux_tmp_529 then
          for _, record in ipairs(batch) do
            __lux_module_1.blitEntry(record.__mgfxTextEntry, record, stats)
          end
          return false
        end
      end
      local fx = __lux_module_1.hasShaderFx(firstEntry)
      local material
      if fx then
        do
          local __lux_tmp_530 = __lux_module_1.isMaterialOK(firstEntry.page.composeMat)
          if __lux_tmp_530 then
            __lux_tmp_530 = firstEntry.page.composeMat
          end
          local __lux_tmp_531 = __lux_tmp_530
          if not __lux_tmp_531 then
            __lux_tmp_531 = __lux_module_1.materials.text_compose
          end
          material = __lux_tmp_531
        end
      else
        do
          local __lux_obj_532 = firstEntry.page
          local __lux_val_533 = nil
          if __lux_obj_532 ~= nil then
            __lux_val_533 = __lux_obj_532.material
          end
          local __lux_tmp_534 = __lux_val_533
          if __lux_tmp_534 == nil then
            __lux_tmp_534 = __lux_module_1.atlasMat
          end
          material = __lux_tmp_534
        end
      end
      local __lux_tmp_535 = not __lux_module_1.isMaterialOK(material)
      if not __lux_tmp_535 then
        __lux_tmp_535 = __lux_module_1.renderSetMaterial == nil
      end
      local __lux_tmp_536 = __lux_tmp_535
      if not __lux_tmp_536 then
        __lux_tmp_536 = __lux_module_1.meshBegin == nil
      end
      local __lux_tmp_537 = __lux_tmp_536
      if not __lux_tmp_537 then
        __lux_tmp_537 = __lux_module_1.meshEnd == nil
      end
      local __lux_tmp_538 = __lux_tmp_537
      if not __lux_tmp_538 then
        __lux_tmp_538 = __lux_module_1.textBatchVertex == nil
      end
      if __lux_tmp_538 then
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
        local __lux_tmp_539 = stats
        if __lux_tmp_539 == nil then
          __lux_tmp_539 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_539, "textComposedBlits", #batch)
      end
      do
        local __lux_tmp_540 = stats
        if __lux_tmp_540 == nil then
          __lux_tmp_540 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_540, "textComposedDraws", #batch)
      end
      if fx then
        do
          local __lux_tmp_541 = stats
          if __lux_tmp_541 == nil then
            __lux_tmp_541 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_541, "textShaderDraws")
        end
        do
          local __lux_tmp_542 = stats
          if __lux_tmp_542 == nil then
            __lux_tmp_542 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_542, "textComposedFxDraws", #batch)
        end
      else
        do
          local __lux_tmp_543 = stats
          if __lux_tmp_543 == nil then
            __lux_tmp_543 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_543, "textComposedFaceDraws", #batch)
        end
      end
      do
        local __lux_tmp_544 = stats
        if __lux_tmp_544 == nil then
          __lux_tmp_544 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_544, "textComposedBatchDraws")
      end
      do
        local __lux_tmp_545 = stats
        if __lux_tmp_545 == nil then
          __lux_tmp_545 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_545, "textComposedBatchedRecords", #batch)
      end
      return true
    end
    __lux_module_1.queueTextComposeBatch = function(batches, order, entry, record)
      local key = __lux_module_1.textBatchKey(entry, record)
      local __lux_tmp_546 = key == nil
      if not __lux_tmp_546 then
        __lux_tmp_546 = not __lux_module_1.isMaterialOK(__lux_module_1.materials.text_compose)
      end
      if __lux_tmp_546 then
        return false
      end
      local contentX
      do
        local __lux_tmp_547 = record.x
        if __lux_tmp_547 == nil then
          __lux_tmp_547 = 0
        end
        contentX = __lux_tmp_547 - entry.contentW * __lux_module_1.alignFactor(record.alignX)
      end
      local contentY
      do
        local __lux_tmp_548 = record.y
        if __lux_tmp_548 == nil then
          __lux_tmp_548 = 0
        end
        contentY = __lux_tmp_548 - entry.contentH * __lux_module_1.alignFactor(record.alignY, true)
      end
      local x = contentX - entry.originX
      local y = contentY - entry.originY
      x, y = __lux_module_1.snapTextPos(x, y, record.style)
      local color
      do
        local __lux_tmp_549 = record.color
        if __lux_tmp_549 == nil then
          __lux_tmp_549 = __lux_module_1.white
        end
        color = __lux_module_1.style.asColor(__lux_module_1.fillForRecord(record), __lux_tmp_549)
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
      local __lux_tmp_550 = order == nil
      if not __lux_tmp_550 then
        __lux_tmp_550 = #order == 0
      end
      if __lux_tmp_550 then
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
          local __lux_tmp_551 = stats
          if __lux_tmp_551 == nil then
            __lux_tmp_551 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_551, "textComposedEvicts")
        end
        __lux_module_1.clearComposedCache()
        do
          local __lux_tmp_552 = records
          if __lux_tmp_552 == nil then
            __lux_tmp_552 = {}
          end
          for _, record in ipairs(__lux_tmp_552) do
            record.__mgfxTextEntry = nil
          end
        end
      end
      __lux_module_1.bakesThisFrame = 0
      local composeRequested = __lux_module_1.prepareTextRoutes(records)
      do
        local __lux_tmp_553 = stats
        if __lux_tmp_553 == nil then
          __lux_tmp_553 = {}
        end
        __lux_module_1.statAdd(__lux_tmp_553, "textComposedRequests", composeRequested)
      end
      if composeRequested > 0 then
        do
          local __lux_tmp_554 = stats
          if __lux_tmp_554 == nil then
            __lux_tmp_554 = {}
          end
          __lux_module_1.statAdd(__lux_tmp_554, "textComposedBatches")
        end
      end
      local composerReady
      do
        local __lux_tmp_555 = composeRequested <= 0
        if not __lux_tmp_555 then
          __lux_tmp_555 = __lux_module_1.prewarmFlushRecords(records, stats)
        end
        composerReady = __lux_tmp_555
      end
      if composeRequested > 0 then
        if composerReady then
          do
            local __lux_tmp_556 = stats
            if __lux_tmp_556 == nil then
              __lux_tmp_556 = {}
            end
            __lux_module_1.statAdd(__lux_tmp_556, "textComposedReadyBatches")
          end
        else
          do
            local __lux_tmp_557 = stats
            if __lux_tmp_557 == nil then
              __lux_tmp_557 = {}
            end
            __lux_module_1.statAdd(__lux_tmp_557, "textComposedFallbackBatches")
          end
          do
            local __lux_tmp_558 = stats
            if __lux_tmp_558 == nil then
              __lux_tmp_558 = {}
            end
            __lux_module_1.statAdd(__lux_tmp_558, "textComposedFallbackRecords", composeRequested)
          end
        end
      end
      local batches = {}
      local order = {}
      do
        local __lux_tmp_559 = records
        if __lux_tmp_559 == nil then
          __lux_tmp_559 = {}
        end
        for _, record in ipairs(__lux_tmp_559) do
          do
            local __lux_tmp_560 = stats
            if __lux_tmp_560 == nil then
              __lux_tmp_560 = {}
            end
            __lux_module_1.statAdd(__lux_tmp_560, "textDraws")
          end
          local route = record.__mgfxTextRoute
          if route == "native" then
            __lux_module_1.flushQueuedTextBatches(batches, order, stats)
            do
              local __lux_tmp_561 = stats
              if __lux_tmp_561 == nil then
                __lux_tmp_561 = {}
              end
              __lux_module_1.statAdd(__lux_tmp_561, "textNativeDraws")
            end
            __lux_module_1.drawNativePlainRecord(record)
          else
            local __lux_tmp_562 = route == "nativeFallback"
            if not __lux_tmp_562 then
              __lux_tmp_562 = not composerReady
            end
            if __lux_tmp_562 then
              __lux_module_1.flushQueuedTextBatches(batches, order, stats)
              do
                local __lux_tmp_563 = stats
                if __lux_tmp_563 == nil then
                  __lux_tmp_563 = {}
                end
                __lux_module_1.statAdd(__lux_tmp_563, "textNativeDraws")
              end
              do
                local __lux_tmp_564 = stats
                if __lux_tmp_564 == nil then
                  __lux_tmp_564 = {}
                end
                __lux_module_1.statAdd(__lux_tmp_564, "textFallbacks")
              end
              __lux_module_1.drawNativeFallbackRecord(record)
            else
              local entry = record.__mgfxTextEntry
              local __lux_tmp_565 = entry ~= nil
              if __lux_tmp_565 then
                __lux_tmp_565 = entry.page ~= nil
              end
              local __lux_tmp_566 = __lux_tmp_565
              if __lux_tmp_566 then
                __lux_tmp_566 = entry.generation == entry.page.generation
              end
              if not __lux_tmp_566 then
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
                  local __lux_tmp_567 = stats
                  if __lux_tmp_567 == nil then
                    __lux_tmp_567 = {}
                  end
                  __lux_module_1.statAdd(__lux_tmp_567, "textComposedFallbackRecords")
                end
                do
                  local __lux_tmp_568 = stats
                  if __lux_tmp_568 == nil then
                    __lux_tmp_568 = {}
                  end
                  __lux_module_1.statAdd(__lux_tmp_568, "textNativeDraws")
                end
                do
                  local __lux_tmp_569 = stats
                  if __lux_tmp_569 == nil then
                    __lux_tmp_569 = {}
                  end
                  __lux_module_1.statAdd(__lux_tmp_569, "textFallbacks")
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
      do
        local __lux_tmp_570 = deps
        if __lux_tmp_570 == nil then
          __lux_tmp_570 = {}
        end
        deps = __lux_tmp_570
      end
      __lux_module_1.configureTextRenderer(deps)
      local owner
      do
        local __lux_tmp_571 = deps.M
        if __lux_tmp_571 == nil then
          local __lux_tmp_572 = deps.owner
          if __lux_tmp_572 == nil then
            __lux_tmp_572 = {}
          end
          __lux_tmp_571 = __lux_tmp_572
        end
        owner = __lux_tmp_571
      end
      local stats
      do
        local __lux_tmp_573 = deps.stats
        if __lux_tmp_573 == nil then
          local __lux_tmp_574 = owner.stats
          if __lux_tmp_574 == nil then
            __lux_tmp_574 = {}
          end
          __lux_tmp_573 = __lux_tmp_574
        end
        stats = __lux_tmp_573
      end
      owner.stats = stats
      local renderer = {}
      local styleStack = {}
      local immediateRecordBatch = {}
      __lux_module_1.resetRendererFrameStats(stats)
      renderer.RegisterFont = function(fontName, spec)
        local __lux_tmp_575 = spec
        if __lux_tmp_575 == nil then
          __lux_tmp_575 = {}
        end
        return __lux_module_1.registerFont(fontName, __lux_tmp_575)
      end
      renderer.DefineStyle = function(name, textStyle)
        if name == nil then
          return nil
        end
        local __lux_tmp_576 = textStyle
        if __lux_tmp_576 == nil then
          __lux_tmp_576 = {}
        end
        return __lux_module_1.defineStyle(
          __lux_module_1.toString(name),
          renderer.ResolveStyle(__lux_tmp_576)
        )
      end
      renderer.GetStyle = function(name)
        local __lux_tmp_577 = name
        if __lux_tmp_577 == nil then
          __lux_tmp_577 = ""
        end
        return __lux_module_1.getStyle(__lux_module_1.toString(__lux_tmp_577))
      end
      renderer.PushStyle = function(textStyle)
        do
          local __lux_tmp_578 = textStyle
          if __lux_tmp_578 == nil then
            __lux_tmp_578 = {}
          end
          styleStack[#styleStack + 1] = renderer.ResolveStyle(__lux_tmp_578)
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
        local __lux_tmp_579 = __lux_module_1.typeOf(textStyle) == "table"
        if __lux_tmp_579 then
          __lux_tmp_579 = textStyle[__lux_module_1.RESOLVED_STYLE_MARK] == true
        end
        if __lux_tmp_579 then
          return __lux_module_1.tableCopy(textStyle)
        end
        local resolved = {}
        for index = 1, #styleStack do
          __lux_module_1.copyStyleInto(resolved, styleStack[index])
        end
        do
          local __lux_tmp_580 = textStyle
          if __lux_tmp_580 == nil then
            __lux_tmp_580 = {}
          end
          __lux_module_1.copyStyleInto(resolved, __lux_tmp_580)
        end
        resolved[__lux_module_1.RESOLVED_STYLE_MARK] = true
        return resolved
      end
      renderer.MakeRecord = function(value, font, x, y, color, ax, ay, textStyle)
        local resolved
        do
          local __lux_tmp_581 = textStyle
          if __lux_tmp_581 == nil then
            __lux_tmp_581 = {}
          end
          resolved = renderer.ResolveStyle(__lux_tmp_581)
        end
        local __lux_tmp_582 = value
        if __lux_tmp_582 == nil then
          __lux_tmp_582 = ""
        end
        local __lux_tmp_583 = resolved.font
        if __lux_tmp_583 == nil then
          local __lux_tmp_584 = font
          if __lux_tmp_584 == nil then
            __lux_tmp_584 = "DermaDefault"
          end
          __lux_tmp_583 = __lux_tmp_584
        end
        local __lux_tmp_585 = __lux_module_1.toNumber(x)
        if __lux_tmp_585 == nil then
          __lux_tmp_585 = 0
        end
        local __lux_tmp_586 = __lux_module_1.toNumber(y)
        if __lux_tmp_586 == nil then
          __lux_tmp_586 = 0
        end
        local __lux_tmp_587
        if __lux_module_1.style.asColor ~= nil then
          do
            local __lux_tmp_588 = color
            if __lux_tmp_588 == nil then
              local __lux_tmp_589 = resolved.color
              if __lux_tmp_589 == nil then
                __lux_tmp_589 = resolved.fill
              end
              __lux_tmp_588 = __lux_tmp_589
            end
            __lux_tmp_587 = __lux_module_1.style.asColor(__lux_tmp_588, __lux_module_1.white)
          end
        else
          do
            local __lux_tmp_590 = color
            if __lux_tmp_590 == nil then
              local __lux_tmp_591 = resolved.color
              if __lux_tmp_591 == nil then
                __lux_tmp_591 = resolved.fill
              end
              __lux_tmp_590 = __lux_tmp_591
            end
            __lux_tmp_587 = __lux_module_1.style.colorOr(__lux_tmp_590, __lux_module_1.white)
          end
        end
        local __lux_tmp_592 = resolved.alignX
        if __lux_tmp_592 == nil then
          local __lux_tmp_593 = resolved.align
          if __lux_tmp_593 == nil then
            local __lux_tmp_594 = ax
            if __lux_tmp_594 == nil then
              __lux_tmp_594 = TEXT_ALIGN_LEFT
            end
            __lux_tmp_593 = __lux_tmp_594
          end
          __lux_tmp_592 = __lux_tmp_593
        end
        local __lux_tmp_595 = resolved.alignY
        if __lux_tmp_595 == nil then
          local __lux_tmp_596 = resolved.valign
          if __lux_tmp_596 == nil then
            local __lux_tmp_597 = ay
            if __lux_tmp_597 == nil then
              __lux_tmp_597 = TEXT_ALIGN_TOP
            end
            __lux_tmp_596 = __lux_tmp_597
          end
          __lux_tmp_595 = __lux_tmp_596
        end
        return {
          text = __lux_module_1.toString(__lux_tmp_582),
          font = __lux_tmp_583,
          x = __lux_tmp_585,
          y = __lux_tmp_586,
          color = __lux_tmp_587,
          alignX = __lux_tmp_592,
          alignY = __lux_tmp_595,
          style = resolved,
        }
      end
      renderer.NormalizeRecord = function(record)
        if record == nil then
          return nil
        end
        local resolved
        do
          local __lux_tmp_598 = record.style
          if __lux_tmp_598 == nil then
            __lux_tmp_598 = {}
          end
          resolved = renderer.ResolveStyle(__lux_tmp_598)
        end
        do
          local __lux_tmp_599 = record.text
          if __lux_tmp_599 == nil then
            local __lux_tmp_600 = record.value
            if __lux_tmp_600 == nil then
              __lux_tmp_600 = ""
            end
            __lux_tmp_599 = __lux_tmp_600
          end
          record.text = __lux_module_1.toString(__lux_tmp_599)
        end
        do
          local __lux_tmp_601 = resolved.font
          if __lux_tmp_601 == nil then
            local __lux_tmp_602 = record.font
            if __lux_tmp_602 == nil then
              __lux_tmp_602 = "DermaDefault"
            end
            __lux_tmp_601 = __lux_tmp_602
          end
          record.font = __lux_tmp_601
        end
        do
          local __lux_tmp_603 = __lux_module_1.toNumber(record.x)
          if __lux_tmp_603 == nil then
            __lux_tmp_603 = 0
          end
          record.x = __lux_tmp_603
        end
        do
          local __lux_tmp_604 = __lux_module_1.toNumber(record.y)
          if __lux_tmp_604 == nil then
            __lux_tmp_604 = 0
          end
          record.y = __lux_tmp_604
        end
        do
          local __lux_tmp_605
          if __lux_module_1.style.asColor ~= nil then
            do
              local __lux_tmp_606 = record.color
              if __lux_tmp_606 == nil then
                local __lux_tmp_607 = resolved.color
                if __lux_tmp_607 == nil then
                  __lux_tmp_607 = resolved.fill
                end
                __lux_tmp_606 = __lux_tmp_607
              end
              __lux_tmp_605 = __lux_module_1.style.asColor(__lux_tmp_606, __lux_module_1.white)
            end
          else
            do
              local __lux_tmp_608 = record.color
              if __lux_tmp_608 == nil then
                local __lux_tmp_609 = resolved.color
                if __lux_tmp_609 == nil then
                  __lux_tmp_609 = resolved.fill
                end
                __lux_tmp_608 = __lux_tmp_609
              end
              __lux_tmp_605 = __lux_module_1.style.colorOr(__lux_tmp_608, __lux_module_1.white)
            end
          end
          record.color = __lux_tmp_605
        end
        do
          local __lux_tmp_610 = resolved.alignX
          if __lux_tmp_610 == nil then
            local __lux_tmp_611 = resolved.align
            if __lux_tmp_611 == nil then
              local __lux_tmp_612 = record.alignX
              if __lux_tmp_612 == nil then
                local __lux_tmp_613 = record.ax
                if __lux_tmp_613 == nil then
                  __lux_tmp_613 = TEXT_ALIGN_LEFT
                end
                __lux_tmp_612 = __lux_tmp_613
              end
              __lux_tmp_611 = __lux_tmp_612
            end
            __lux_tmp_610 = __lux_tmp_611
          end
          record.alignX = __lux_tmp_610
        end
        do
          local __lux_tmp_614 = resolved.alignY
          if __lux_tmp_614 == nil then
            local __lux_tmp_615 = resolved.valign
            if __lux_tmp_615 == nil then
              local __lux_tmp_616 = record.alignY
              if __lux_tmp_616 == nil then
                local __lux_tmp_617 = record.ay
                if __lux_tmp_617 == nil then
                  __lux_tmp_617 = TEXT_ALIGN_TOP
                end
                __lux_tmp_616 = __lux_tmp_617
              end
              __lux_tmp_615 = __lux_tmp_616
            end
            __lux_tmp_614 = __lux_tmp_615
          end
          record.alignY = __lux_tmp_614
        end
        record.style = resolved
        return record
      end
      renderer.Flush = function(records, reason)
        do
          local normalized
          do
            local __lux_tmp_618 = records
            if __lux_tmp_618 == nil then
              __lux_tmp_618 = {}
            end
            normalized = __lux_tmp_618
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
          local __lux_tmp_619 = textStyle
          if __lux_tmp_619 == nil then
            __lux_tmp_619 = {}
          end
          resolved = renderer.ResolveStyle(__lux_tmp_619)
        end
        local resolvedFont
        do
          local __lux_tmp_620 = resolved.font
          if __lux_tmp_620 == nil then
            local __lux_tmp_621 = font
            if __lux_tmp_621 == nil then
              __lux_tmp_621 = "DermaDefault"
            end
            __lux_tmp_620 = __lux_tmp_621
          end
          resolvedFont = __lux_tmp_620
        end
        local lines
        do
          local __lux_tmp_622 = __lux_module_1.toNumber(w)
          if __lux_tmp_622 == nil then
            __lux_tmp_622 = 0
          end
          lines = __lux_module_1.wrapText(value, resolvedFont, __lux_tmp_622, resolved.overflow)
        end
        local nativeFont, alias, oversample = __lux_module_1.nativeFor(resolvedFont, resolved)
        local lineHeight = __lux_module_1.lineHeightFor(nativeFont, alias, resolved, oversample)
        local totalH = #lines * lineHeight
        local startY
        do
          local __lux_tmp_623 = __lux_module_1.toNumber(y)
          if __lux_tmp_623 == nil then
            __lux_tmp_623 = 0
          end
          local __lux_tmp_624 = __lux_module_1.toNumber(h)
          if __lux_tmp_624 == nil then
            __lux_tmp_624 = totalH
          end
          local __lux_tmp_625 = resolved.alignY
          if __lux_tmp_625 == nil then
            local __lux_tmp_626 = resolved.valign
            if __lux_tmp_626 == nil then
              __lux_tmp_626 = TEXT_ALIGN_TOP
            end
            __lux_tmp_625 = __lux_tmp_626
          end
          startY = __lux_tmp_623 + (__lux_tmp_624 - totalH) * __lux_module_1.alignFactor(__lux_tmp_625, true)
        end
        local ax
        do
          local __lux_tmp_627 = resolved.alignX
          if __lux_tmp_627 == nil then
            local __lux_tmp_628 = resolved.align
            if __lux_tmp_628 == nil then
              __lux_tmp_628 = TEXT_ALIGN_LEFT
            end
            __lux_tmp_627 = __lux_tmp_628
          end
          ax = __lux_tmp_627
        end
        local tx
        do
          local __lux_tmp_629 = __lux_module_1.toNumber(x)
          if __lux_tmp_629 == nil then
            __lux_tmp_629 = 0
          end
          local __lux_tmp_630 = __lux_module_1.toNumber(w)
          if __lux_tmp_630 == nil then
            __lux_tmp_630 = 0
          end
          tx = __lux_tmp_629 + __lux_tmp_630 * __lux_module_1.alignFactor(ax)
        end
        local lineStyle = __lux_module_1.textBoxLineStyle(resolved)
        for index = 1, #lines do
          do
            local __lux_tmp_631 = lineStyle.color
            if __lux_tmp_631 == nil then
              __lux_tmp_631 = lineStyle.fill
            end
            renderer.DrawTextImmediate(
              lines[index],
              resolvedFont,
              tx,
              startY + (index - 1) * lineHeight,
              __lux_tmp_631,
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
        local __lux_tmp_632 = textStyle
        if __lux_tmp_632 == nil then
          __lux_tmp_632 = {}
        end
        return __lux_module_1.measureBox(value, font, w, renderer.ResolveStyle(__lux_tmp_632))
      end
      renderer.PrewarmText = function(value, font, textStyle)
        local record
        do
          local __lux_tmp_633 = textStyle
          if __lux_tmp_633 == nil then
            __lux_tmp_633 = {}
          end
          record = renderer.MakeRecord(
            value,
            font,
            0,
            0,
            nil,
            TEXT_ALIGN_LEFT,
            TEXT_ALIGN_TOP,
            __lux_tmp_633
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
          local __lux_tmp_634 = textStyle
          if __lux_tmp_634 == nil then
            __lux_tmp_634 = {}
          end
          record = renderer.MakeRecord(
            value,
            font,
            0,
            0,
            nil,
            TEXT_ALIGN_LEFT,
            TEXT_ALIGN_TOP,
            __lux_tmp_634
          )
        end
        local nativeFont, alias, oversample = __lux_module_1.nativeFor(record.font, record.style)
        local layout = __lux_module_1.layoutFor(record.text, record.font, record.style)
        local needsComposed = __lux_module_1.recordNeedsComposedEntry(record)
        local __lux_tmp_635
        if needsComposed then
          __lux_tmp_635 = "__composed"
        else
          __lux_tmp_635 = "__native"
        end
        local __lux_tmp_636
        if needsComposed then
          __lux_tmp_636 = "composed"
        else
          __lux_tmp_636 = "native"
        end
        local __lux_tmp_637
        if needsComposed then
          __lux_tmp_637 = "__composed"
        else
          __lux_tmp_637 = "__native"
        end
        local __lux_tmp_638
        if needsComposed then
          __lux_tmp_638 = "compose"
        else
          __lux_tmp_638 = "native"
        end
        local __lux_tmp_639 = alias.mode
        if __lux_tmp_639 == nil then
          __lux_tmp_639 = "native"
        end
        return {
          text = record.text,
          font = record.font,
          nativeFont = nativeFont,
          atlasKey = __lux_tmp_635,
          kind = __lux_tmp_636,
          routeAtlas = __lux_tmp_637,
          routeKind = __lux_tmp_638,
          mode = __lux_tmp_639,
          missing = {},
          w = layout.w,
          h = layout.h,
          oversample = oversample,
        }
      end
      renderer.Status = function()
        local __lux_obj_640 = __lux_module_1.atlas
        local __lux_val_641 = nil
        if __lux_obj_640 ~= nil then
          __lux_val_641 = __lux_obj_640.rt
        end
        local __lux_obj_642 = __lux_module_1.atlas
        local __lux_val_643 = nil
        if __lux_obj_642 ~= nil then
          __lux_val_643 = __lux_obj_642.w
        end
        local __lux_tmp_644 = __lux_val_643
        if __lux_tmp_644 == nil then
          __lux_tmp_644 = 0
        end
        local __lux_obj_645 = __lux_module_1.atlas
        local __lux_val_646 = nil
        if __lux_obj_645 ~= nil then
          __lux_val_646 = __lux_obj_645.h
        end
        local __lux_tmp_647 = __lux_val_646
        if __lux_tmp_647 == nil then
          __lux_tmp_647 = 0
        end
        local __lux_tmp_648 = stats.textDraws
        if __lux_tmp_648 == nil then
          __lux_tmp_648 = 0
        end
        local __lux_tmp_649 = stats.textNativeDraws
        if __lux_tmp_649 == nil then
          __lux_tmp_649 = 0
        end
        local __lux_tmp_650 = stats.textShaderDraws
        if __lux_tmp_650 == nil then
          __lux_tmp_650 = 0
        end
        local __lux_tmp_651 = stats.textComposedDraws
        if __lux_tmp_651 == nil then
          __lux_tmp_651 = 0
        end
        local __lux_tmp_652 = stats.textComposedBakes
        if __lux_tmp_652 == nil then
          __lux_tmp_652 = 0
        end
        local __lux_tmp_653 = stats.textComposedBlits
        if __lux_tmp_653 == nil then
          __lux_tmp_653 = 0
        end
        local __lux_tmp_654 = stats.textMeasureHits
        if __lux_tmp_654 == nil then
          __lux_tmp_654 = 0
        end
        local __lux_tmp_655 = stats.textMeasureMisses
        if __lux_tmp_655 == nil then
          __lux_tmp_655 = 0
        end
        return {
          mode = "native+composer",
          fontCount = __lux_module_1.countTable(__lux_module_1.fonts),
          styleCount = __lux_module_1.countTable(__lux_module_1.styles),
          styleStackDepth = #styleStack,
          cacheSize = __lux_module_1.measureOrderCount,
          composedEnabled = __lux_module_1.textComposedEnabled(),
          composedAtlas = __lux_val_641,
          composedAtlasW = __lux_tmp_644,
          composedAtlasH = __lux_tmp_647,
          composedAtlasPages = #__lux_module_1.atlasPages,
          composedAtlasMaxPages = __lux_module_1.MAX_ATLAS_PAGES,
          composedAtlasFill = __lux_module_1.atlasFillRatio(),
          composedEntries = __lux_module_1.composedCacheCount,
          composedFailed = __lux_module_1.atlasFailed,
          draws = __lux_tmp_648,
          nativeDraws = __lux_tmp_649,
          shaderDraws = __lux_tmp_650,
          composedDraws = __lux_tmp_651,
          composedBakes = __lux_tmp_652,
          composedBlits = __lux_tmp_653,
          measureHits = __lux_tmp_654,
          measureMisses = __lux_tmp_655,
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
          local __lux_tmp_656 = __lux_module_1.debugViewMat
          if __lux_tmp_656 == nil then
            __lux_tmp_656 = __lux_module_1.createMaterial(
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
          __lux_module_1.debugViewMat = __lux_tmp_656
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
          local __lux_tmp_657 = page.rt ~= nil
          if __lux_tmp_657 then
            __lux_tmp_657 = __lux_module_1.debugViewMat ~= nil
          end
          local __lux_tmp_658 = __lux_tmp_657
          if __lux_tmp_658 then
            __lux_tmp_658 = __lux_module_1.surfaceSetMaterial ~= nil
          end
          local __lux_tmp_659 = __lux_tmp_658
          if __lux_tmp_659 then
            __lux_tmp_659 = __lux_module_1.surfaceDrawTexturedRect ~= nil
          end
          if __lux_tmp_659 then
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
    local __lux_import_660 = __lux_import("lux/mgfx/frame#client")
    local frameImport = __lux_import_660
    __lux_module_1.frame = frameImport
    __lux_module_1.install = function(owner)
      do
        local __lux_tmp_661 = owner.stats
        if __lux_tmp_661 == nil then
          __lux_tmp_661 = {}
        end
        owner.stats = __lux_tmp_661
      end
      local materialState
      do
        local __lux_tmp_662 = owner._MaterialState
        if __lux_tmp_662 == nil then
          __lux_tmp_662 = {}
        end
        materialState = __lux_tmp_662
      end
      local renderer
      do
        local __lux_tmp_663 = owner._Materials
        if __lux_tmp_663 == nil then
          local __lux_tmp_664 = materialState.materials
          if __lux_tmp_664 == nil then
            __lux_tmp_664 = {}
          end
          __lux_tmp_663 = __lux_tmp_664
        end
        local __lux_tmp_665 = owner.MaterialOK
        if __lux_tmp_665 == nil then
          __lux_tmp_665 = materialState.matOK
        end
        renderer = __lux_module_1.createTextRenderer(
          {
            M = owner,
            owner = owner,
            stats = owner.stats,
            materials = __lux_tmp_663,
            createPageTextMaterials = materialState.CreatePageTextMaterials,
            matOK = __lux_tmp_665,
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
