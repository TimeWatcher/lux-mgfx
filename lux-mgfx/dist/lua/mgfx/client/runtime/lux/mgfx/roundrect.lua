return function(__lux_import)
  local __lux_exports = {}
  local frame
  local geometry
  local style
  local drawRoundedBox
  local getConVar
  local matrixCtor
  local mathAbs
  local mathClamp
  local mathCos
  local mathFloor
  local mathMax
  local mathMin
  local mathRad
  local mathSin
  local mathSqrt
  local renderCopyRenderTargetToTexture
  local surfaceDrawOutlinedRect
  local surfaceDrawRect
  local surfaceSetMaterial
  local surfaceSetDrawColor
  local typeOf
  local toNumber
  local makeColor
  local realTime
  local sysTime
  local drawTransformedPoly
  local drawTexturedQuad
  local drawTexturedQuadUV
  local blurIntensity
  local hasTransform
  local recordDraws
  local recordFallbacks
  local splitStyleTransform
  local withTransform
  local beginPanelEffectDraw
  local endPanelEffectBleed
  local withPanelEffectBleed
  local paramMatrixProbe
  local paramMatrixSetUnpacked
  local paramMatrices
  local paramMatrixRawState
  local auxParamMatrices
  local auxParamMatrixRawState
  local roundRectMaterials
  local roundRectBlurRT
  local roundRectMatOK
  local roundRectHasShaders
  local forceFallbackCvar
  local fallbackRoundRectVerts
  local fallbackStrokeVerts
  local circleStyle
  local capsuleStyle
  local roundedBoxStyle
  local emptyRoundRectStyle
  local transparentColor
  local solidFillScratch
  local backdropTintScratch
  local backdropFillScratch
  local roundRectProfiler
  local defaultInnerGlowColor
  local defaultOuterGlowColor
  local defaultShadowColor
  local effectExtentFromSpec
  local defaultInnerGlowSpec
  local defaultOuterGlowSpec
  local defaultShadowSpec
  local innerGlowColorCache
  local outerGlowColorCache
  local shadowColorCache
  local innerGlowTableCache
  local outerGlowTableCache
  local shadowTableCache
  local shadowNumberCache
  local configureRoundRect
  local materialOK
  local shadersActive
  local clearArray
  local fillColor
  local hotFillFromStyle
  local hotFillVisible
  local roundRectRadiusScalar
  local roundRectProfileActive
  local roundRectProfileStart
  local roundRectProfileEnd
  local roundRectProfileRecord
  local roundRectTraceStart
  local roundRectTraceEnd
  local finishImmediateTrace
  local roundRectProfileEndBase
  local roundRectCullSpread
  local setColor
  local copyInto
  local appendPoint
  local appendCorner
  local fallbackRoundRectPoints
  local drawFallbackStroke
  local drawRoundRectFallback
  local innerGlowStyle
  local effectOffset
  local glowBiasPads
  local outerGlowStyle
  local shadowStyle
  local patternStyle
  local patternOffset
  local roundRectFillParams
  local inv255
  local setupParamMatrix
  local setupParamMatrixRaw
  local setupAuxConstants
  local setupAuxConstantsRaw
  local setupConstants
  local setupRoundRectConstants
  local setupPatternConstants
  local drawRoundRectFillPass
  local drawSolidRectFast
  local drawSolidRoundFast
  local drawRoundRectPattern
  local radiusWithGrow
  local effectExtent
  local drawRoundRectInnerGlowSpec
  local drawRoundRectShadowOuterSpec
  local effectColorPacked
  local drawRoundRectFusedSpec
  local backdropTintColor
  local drawRoundRectBackdrop
  local drawRoundRectStrokePass
  local drawRoundRectFxPass
  local drawRoundRectImmediate
  local roundedBoxEx
  local roundedBox
  local circle
  local circleEx
  local capsule
  local capsuleEx
  local install
  do
    local __lux_import_1 = __lux_import("lux/mgfx/frame#client")
    local frameImport = __lux_import_1
    local __lux_import_2 = __lux_import("lux/mgfx/geometry#client")
    local geometryImport = __lux_import_2
    local __lux_import_3 = __lux_import("lux/mgfx/style#client")
    local styleImport = __lux_import_3
    frame = frameImport
    geometry = geometryImport
    style = styleImport
    drawRoundedBox = _G.draw.RoundedBox
    getConVar = GetConVar
    matrixCtor = Matrix
    mathAbs = math.abs
    mathClamp = math.Clamp
    mathCos = math.cos
    mathFloor = math.floor
    mathMax = math.max
    mathMin = math.min
    mathRad = math.rad
    mathSin = math.sin
    mathSqrt = math.sqrt
    do
      local __lux_obj_4 = render
      local __lux_val_5 = nil
      if __lux_obj_4 ~= nil then
        __lux_val_5 = __lux_obj_4.CopyRenderTargetToTexture
      end
      renderCopyRenderTargetToTexture = __lux_val_5
    end
    surfaceDrawOutlinedRect = surface.DrawOutlinedRect
    surfaceDrawRect = surface.DrawRect
    surfaceSetMaterial = surface.SetMaterial
    surfaceSetDrawColor = surface.SetDrawColor
    typeOf = type
    toNumber = tonumber
    makeColor = Color
    realTime = RealTime
    sysTime = SysTime
    drawTransformedPoly = geometry.drawTransformedPoly
    drawTexturedQuad = geometry.drawTexturedQuad
    drawTexturedQuadUV = geometry.drawTexturedQuadUV
    blurIntensity = geometry.blurIntensity
    hasTransform = geometry.hasTransform
    recordDraws = geometry.recordDraws
    recordFallbacks = geometry.recordFallbacks
    splitStyleTransform = geometry.splitStyleTransform
    withTransform = geometry.withTransform
    beginPanelEffectDraw = frame.beginPanelEffectDraw
    endPanelEffectBleed = frame.endPanelEffectBleed
    withPanelEffectBleed = frame.withPanelEffectBleed
    do
      local __lux_tmp_6
      if matrixCtor ~= nil then
        __lux_tmp_6 = matrixCtor()
      else
        __lux_tmp_6 = nil
      end
      paramMatrixProbe = __lux_tmp_6
    end
    do
      local __lux_obj_7 = paramMatrixProbe
      local __lux_val_8 = nil
      if __lux_obj_7 ~= nil then
        __lux_val_8 = __lux_obj_7.SetUnpacked
      end
      paramMatrixSetUnpacked = __lux_val_8
    end
    paramMatrices = {}
    paramMatrixRawState = {}
    auxParamMatrices = {}
    auxParamMatrixRawState = {}
    roundRectMaterials = {}
    roundRectBlurRT = nil
    roundRectMatOK = function(material)
      local __lux_tmp_9 = material ~= nil
      if __lux_tmp_9 then
        __lux_tmp_9 = material.IsError ~= nil
      end
      local __lux_tmp_10 = __lux_tmp_9
      if __lux_tmp_10 then
        __lux_tmp_10 = not material:IsError()
      end
      return __lux_tmp_10
    end
    roundRectHasShaders = function()
      return false
    end
    forceFallbackCvar = nil
    fallbackRoundRectVerts = {}
    fallbackStrokeVerts = { {}, {}, {}, {} }
    circleStyle = {}
    capsuleStyle = {}
    roundedBoxStyle = {}
    emptyRoundRectStyle = {}
    transparentColor = makeColor(0, 0, 0, 0)
    solidFillScratch = { kind = style.FILL_SOLID, colorA = color_white, colorB = color_white }
    backdropTintScratch = makeColor(0, 0, 0, 0)
    backdropFillScratch = {
      kind = style.FILL_SOLID,
      colorA = backdropTintScratch,
      colorB = backdropTintScratch,
      _mgfxFillVisible = false,
    }
    roundRectProfiler = nil
    defaultInnerGlowColor = makeColor(76, 190, 255, 34)
    defaultOuterGlowColor = makeColor(76, 190, 255, 88)
    defaultShadowColor = makeColor(0, 0, 0, 132)
    effectExtentFromSpec = function(spec, defaultWidth)
      if defaultWidth == nil then
        defaultWidth = 18
      end
      local __lux_tmp_11 = spec ~= nil
      if __lux_tmp_11 then
        __lux_tmp_11 = spec._extent ~= nil
      end
      if __lux_tmp_11 then
        return spec._extent
      end
      local width
      do
        local __lux_obj_12 = spec
        local __lux_val_13 = nil
        if __lux_obj_12 ~= nil then
          __lux_val_13 = __lux_obj_12.width
        end
        local __lux_tmp_14 = toNumber(__lux_val_13)
        if __lux_tmp_14 == nil then
          __lux_tmp_14 = defaultWidth
        end
        width = mathMax(0.001, __lux_tmp_14)
      end
      local falloff
      do
        local __lux_obj_15 = spec
        local __lux_val_16 = nil
        if __lux_obj_15 ~= nil then
          __lux_val_16 = __lux_obj_15.falloff
        end
        local __lux_tmp_17 = toNumber(__lux_val_16)
        if __lux_tmp_17 == nil then
          __lux_tmp_17 = 1.9
        end
        falloff = mathMax(0.35, __lux_tmp_17)
      end
      local sigma = mathMax(width / mathSqrt(falloff) * 0.72, 0.35)
      local tail = sigma * 3.72
      local __lux_obj_18 = spec
      local __lux_val_19 = nil
      if __lux_obj_18 ~= nil then
        __lux_val_19 = __lux_obj_18.spread
      end
      local __lux_tmp_20 = toNumber(__lux_val_19)
      if __lux_tmp_20 == nil then
        __lux_tmp_20 = width
      end
      return mathMax(1, __lux_tmp_20, tail)
    end
    defaultInnerGlowSpec = {
      color = defaultInnerGlowColor,
      width = 7,
      strength = 1,
      falloff = style.glowSoftnessToFalloff(0.55),
    }
    defaultOuterGlowSpec = {
      color = defaultOuterGlowColor,
      x = 0,
      y = 0,
      width = 18,
      spread = 18,
      grow = 0,
      strength = 1,
      falloff = style.glowSoftnessToFalloff(0.54),
    }
    defaultShadowSpec = {
      color = defaultShadowColor,
      x = 0,
      y = 4,
      width = 12,
      spread = 12,
      grow = 0,
      strength = 1,
      falloff = style.glowSoftnessToFalloff(0.62),
    }
    defaultOuterGlowSpec._extent = effectExtentFromSpec(defaultOuterGlowSpec, 18)
    defaultOuterGlowSpec._cullSpread = defaultOuterGlowSpec._extent
    defaultShadowSpec._extent = effectExtentFromSpec(defaultShadowSpec, 12)
    defaultShadowSpec._cullSpread = mathAbs(defaultShadowSpec.x) + mathAbs(defaultShadowSpec.y) + defaultShadowSpec._extent + defaultShadowSpec.grow
    innerGlowColorCache = setmetatable({}, { __mode = "k" })
    outerGlowColorCache = setmetatable({}, { __mode = "k" })
    shadowColorCache = setmetatable({}, { __mode = "k" })
    innerGlowTableCache = setmetatable({}, { __mode = "k" })
    outerGlowTableCache = setmetatable({}, { __mode = "k" })
    shadowTableCache = setmetatable({}, { __mode = "k" })
    shadowNumberCache = {}
    configureRoundRect = function(owner)
      do
        local __lux_tmp_21 = owner
        if __lux_tmp_21 == nil then
          __lux_tmp_21 = {}
        end
        owner = __lux_tmp_21
      end
      local materialState
      do
        local __lux_tmp_22 = owner._MaterialState
        if __lux_tmp_22 == nil then
          __lux_tmp_22 = {}
        end
        materialState = __lux_tmp_22
      end
      do
        local __lux_tmp_23 = owner._Materials
        if __lux_tmp_23 == nil then
          local __lux_tmp_24 = materialState.materials
          if __lux_tmp_24 == nil then
            local __lux_tmp_25 = roundRectMaterials
            if __lux_tmp_25 == nil then
              __lux_tmp_25 = {}
            end
            __lux_tmp_24 = __lux_tmp_25
          end
          __lux_tmp_23 = __lux_tmp_24
        end
        roundRectMaterials = __lux_tmp_23
      end
      do
        local __lux_tmp_26 = owner._BlurRT
        if __lux_tmp_26 == nil then
          local __lux_tmp_27 = materialState.blurRT
          if __lux_tmp_27 == nil then
            __lux_tmp_27 = roundRectBlurRT
          end
          __lux_tmp_26 = __lux_tmp_27
        end
        roundRectBlurRT = __lux_tmp_26
      end
      do
        local __lux_tmp_28 = owner.MaterialOK
        if __lux_tmp_28 == nil then
          local __lux_tmp_29 = materialState.matOK
          if __lux_tmp_29 == nil then
            __lux_tmp_29 = roundRectMatOK
          end
          __lux_tmp_28 = __lux_tmp_29
        end
        roundRectMatOK = __lux_tmp_28
      end
      do
        local __lux_tmp_30 = owner.hasShaders
        if __lux_tmp_30 == nil then
          __lux_tmp_30 = roundRectHasShaders
        end
        roundRectHasShaders = __lux_tmp_30
      end
      roundRectProfiler = owner.Profiler
      return true
    end
    materialOK = function(material)
      local __lux_tmp_31 = roundRectMatOK ~= nil
      if __lux_tmp_31 then
        __lux_tmp_31 = roundRectMatOK(material)
      end
      return __lux_tmp_31
    end
    shadersActive = function()
      local __lux_tmp_32 = forceFallbackCvar == nil
      if __lux_tmp_32 then
        __lux_tmp_32 = getConVar ~= nil
      end
      if __lux_tmp_32 then
        do
          local __lux_tmp_33 = getConVar("mgfx_force_fallback")
          if __lux_tmp_33 == nil then
            __lux_tmp_33 = false
          end
          forceFallbackCvar = __lux_tmp_33
        end
      end
      local __lux_tmp_34 = forceFallbackCvar ~= nil
      if __lux_tmp_34 then
        __lux_tmp_34 = forceFallbackCvar ~= false
      end
      local __lux_tmp_35 = __lux_tmp_34
      if __lux_tmp_35 then
        __lux_tmp_35 = forceFallbackCvar:GetBool()
      end
      if __lux_tmp_35 then
        return false
      end
      local __lux_tmp_36 = roundRectHasShaders ~= nil
      if __lux_tmp_36 then
        __lux_tmp_36 = roundRectHasShaders()
      end
      return __lux_tmp_36
    end
    clearArray = function(items)
      for index = #items, 1, -1 do
        items[index] = nil
      end
      return items
    end
    fillColor = function(fill, fallback)
      if style.isColor(fill) then
        return fill
      end
      if typeOf(fill) == "table" then
        local __lux_tmp_37 = fill.colorA
        if __lux_tmp_37 == nil then
          local __lux_tmp_38 = fill.color
          if __lux_tmp_38 == nil then
            local __lux_tmp_39 = fallback
            if __lux_tmp_39 == nil then
              __lux_tmp_39 = color_white
            end
            __lux_tmp_38 = __lux_tmp_39
          end
          __lux_tmp_37 = __lux_tmp_38
        end
        return __lux_tmp_37
      end
      local __lux_tmp_40 = fallback
      if __lux_tmp_40 == nil then
        __lux_tmp_40 = color_white
      end
      return __lux_tmp_40
    end
    hotFillFromStyle = function(fill, fallback)
      if typeOf(fill) == "table" then
        local kind = fill.kind
        local __lux_tmp_41 = kind == style.FILL_SOLID
        if not __lux_tmp_41 then
          __lux_tmp_41 = kind == style.FILL_LINEAR
        end
        local __lux_tmp_42 = __lux_tmp_41
        if not __lux_tmp_42 then
          __lux_tmp_42 = kind == style.FILL_RADIAL
        end
        local __lux_tmp_43 = __lux_tmp_42
        if not __lux_tmp_43 then
          __lux_tmp_43 = kind == style.FILL_CONIC
        end
        if __lux_tmp_43 then
          return fill
        end
        if kind ~= nil then
          solidFillScratch.colorA = transparentColor
          solidFillScratch.colorB = transparentColor
          solidFillScratch._mgfxFillVisible = false
          return solidFillScratch
        end
        local __lux_tmp_44 = fill.r ~= nil
        if __lux_tmp_44 then
          __lux_tmp_44 = fill.g ~= nil
        end
        local __lux_tmp_45 = __lux_tmp_44
        if __lux_tmp_45 then
          __lux_tmp_45 = fill.b ~= nil
        end
        if __lux_tmp_45 then
          solidFillScratch.colorA = fill
          solidFillScratch.colorB = fill
          do
            local __lux_tmp_46 = fill.a == nil
            if not __lux_tmp_46 then
              __lux_tmp_46 = fill.a > 0
            end
            solidFillScratch._mgfxFillVisible = __lux_tmp_46
          end
          return solidFillScratch
        end
      end
      local color
      do
        local __lux_tmp_47 = fallback
        if __lux_tmp_47 == nil then
          __lux_tmp_47 = color_white
        end
        color = style.asColor(fill, __lux_tmp_47)
      end
      solidFillScratch.colorA = color
      solidFillScratch.colorB = color
      do
        local __lux_tmp_48 = color.a == nil
        if not __lux_tmp_48 then
          __lux_tmp_48 = color.a > 0
        end
        solidFillScratch._mgfxFillVisible = __lux_tmp_48
      end
      return solidFillScratch
    end
    hotFillVisible = function(fill)
      if fill == nil then
        return false
      end
      if typeOf(fill) ~= "table" then
        return true
      end
      if style.isColor(fill) then
        local __lux_tmp_49 = fill.a == nil
        if not __lux_tmp_49 then
          __lux_tmp_49 = fill.a > 0
        end
        return __lux_tmp_49
      end
      if fill._mgfxFillVisible ~= nil then
        return fill._mgfxFillVisible
      end
      local kind = fill.kind
      if kind == style.FILL_SOLID then
        local colorA
        do
          local __lux_tmp_50 = fill.colorA
          if __lux_tmp_50 == nil then
            __lux_tmp_50 = color_white
          end
          colorA = __lux_tmp_50
        end
        local colorB
        do
          local __lux_tmp_51 = fill.colorB
          if __lux_tmp_51 == nil then
            __lux_tmp_51 = colorA
          end
          colorB = __lux_tmp_51
        end
        local __lux_tmp_52 = colorA.a == nil
        if not __lux_tmp_52 then
          __lux_tmp_52 = colorA.a > 0
        end
        local __lux_tmp_53 = __lux_tmp_52
        if not __lux_tmp_53 then
          local __lux_tmp_54 = colorB.a == nil
          if not __lux_tmp_54 then
            __lux_tmp_54 = colorB.a > 0
          end
          __lux_tmp_53 = __lux_tmp_54
        end
        return __lux_tmp_53
      end
      local __lux_tmp_55 = kind == style.FILL_LINEAR
      if not __lux_tmp_55 then
        __lux_tmp_55 = kind == style.FILL_RADIAL
      end
      local __lux_tmp_56 = __lux_tmp_55
      if not __lux_tmp_56 then
        __lux_tmp_56 = kind == style.FILL_CONIC
      end
      if __lux_tmp_56 then
        local __lux_tmp_57 = fill.stops ~= nil
        if not __lux_tmp_57 then
          local __lux_tmp_58 = fill.colorA ~= nil
          if __lux_tmp_58 then
            local __lux_tmp_59 = fill.colorA.a == nil
            if not __lux_tmp_59 then
              __lux_tmp_59 = fill.colorA.a > 0
            end
            __lux_tmp_58 = __lux_tmp_59
          end
          __lux_tmp_57 = __lux_tmp_58
        end
        local __lux_tmp_60 = __lux_tmp_57
        if not __lux_tmp_60 then
          local __lux_tmp_61 = fill.colorB ~= nil
          if __lux_tmp_61 then
            local __lux_tmp_62 = fill.colorB.a == nil
            if not __lux_tmp_62 then
              __lux_tmp_62 = fill.colorB.a > 0
            end
            __lux_tmp_61 = __lux_tmp_62
          end
          __lux_tmp_60 = __lux_tmp_61
        end
        return __lux_tmp_60
      end
      return false
    end
    roundRectRadiusScalar = function(radius, w, h)
      if w == nil then
        w = 0
      end
      if h == nil then
        h = 0
      end
      local __lux_tmp_63 = typeOf(radius) ~= "table"
      if not __lux_tmp_63 then
        __lux_tmp_63 = style.isColor(radius)
      end
      if __lux_tmp_63 then
        local value
        do
          local __lux_tmp_64 = toNumber(radius)
          if __lux_tmp_64 == nil then
            __lux_tmp_64 = 0
          end
          value = __lux_tmp_64
        end
        if value <= 0 then
          return 0
        end
        local maxRadius
        do
          local __lux_tmp_65 = toNumber(w)
          if __lux_tmp_65 == nil then
            __lux_tmp_65 = 0
          end
          local __lux_tmp_66 = toNumber(h)
          if __lux_tmp_66 == nil then
            __lux_tmp_66 = 0
          end
          maxRadius = mathMin(mathMax(0, __lux_tmp_65), mathMax(0, __lux_tmp_66)) * 0.5
        end
        if maxRadius <= 0 then
          return 0
        end
        if value > maxRadius then
          return maxRadius
        end
        return value
      end
      return style.radiusScalar(radius, w, h)
    end
    roundRectProfileActive = function()
      local __lux_tmp_67 = roundRectProfiler ~= nil
      if __lux_tmp_67 then
        __lux_tmp_67 = roundRectProfiler.IsActive ~= nil
      end
      local __lux_tmp_68 = __lux_tmp_67
      if __lux_tmp_68 then
        __lux_tmp_68 = roundRectProfiler.IsActive()
      end
      return __lux_tmp_68
    end
    roundRectProfileStart = function()
      local __lux_tmp_69 = roundRectProfiler ~= nil
      if __lux_tmp_69 then
        __lux_tmp_69 = roundRectProfiler.Start ~= nil
      end
      if __lux_tmp_69 then
        return roundRectProfiler.Start()
      end
      return nil
    end
    roundRectProfileEnd = function(name, started)
      local __lux_tmp_70 = started ~= nil
      if __lux_tmp_70 then
        __lux_tmp_70 = roundRectProfiler ~= nil
      end
      local __lux_tmp_71 = __lux_tmp_70
      if __lux_tmp_71 then
        __lux_tmp_71 = roundRectProfiler.End ~= nil
      end
      if __lux_tmp_71 then
        roundRectProfiler.End(name, started)
      end
    end
    roundRectProfileRecord = function(name, elapsed)
      local __lux_tmp_72 = elapsed ~= nil
      if __lux_tmp_72 then
        __lux_tmp_72 = roundRectProfiler ~= nil
      end
      local __lux_tmp_73 = __lux_tmp_72
      if __lux_tmp_73 then
        __lux_tmp_73 = roundRectProfiler.Record ~= nil
      end
      if __lux_tmp_73 then
        roundRectProfiler.Record(name, elapsed)
      end
    end
    roundRectTraceStart = function(name)
      local __lux_tmp_74 = roundRectProfiler ~= nil
      if __lux_tmp_74 then
        __lux_tmp_74 = roundRectProfiler._TraceActive
      end
      local __lux_tmp_75 = __lux_tmp_74
      if __lux_tmp_75 then
        __lux_tmp_75 = roundRectProfiler.TraceStart ~= nil
      end
      if __lux_tmp_75 then
        return roundRectProfiler.TraceStart(name)
      end
      return nil
    end
    roundRectTraceEnd = function(token)
      local __lux_tmp_76 = token ~= nil
      if __lux_tmp_76 then
        __lux_tmp_76 = roundRectProfiler ~= nil
      end
      local __lux_tmp_77 = __lux_tmp_76
      if __lux_tmp_77 then
        __lux_tmp_77 = roundRectProfiler.TraceEnd ~= nil
      end
      if __lux_tmp_77 then
        roundRectProfiler.TraceEnd(token)
      end
    end
    finishImmediateTrace = function(trace, profiling, totalProfile)
      roundRectTraceEnd(trace)
      if profiling then
        roundRectProfileEnd("round.immediate", totalProfile)
      end
    end
    roundRectProfileEndBase = function(kind, started)
      if started == nil then
        return
      end
      local elapsed = (sysTime() - started) * 1000
      local __lux_tmp_78 = roundRectProfiler ~= nil
      if __lux_tmp_78 then
        __lux_tmp_78 = roundRectProfiler.Record ~= nil
      end
      if __lux_tmp_78 then
        roundRectProfiler.Record("round.base", elapsed)
        if kind ~= nil then
          roundRectProfiler.Record(kind, elapsed)
        end
      end
    end
    roundRectCullSpread = function(shadowSpec, outerSpec, backdropSpec, shaderReady)
      if not shaderReady then
        return 0
      end
      local spread = 0
      if shadowSpec ~= nil then
        local shadowSpread
        do
          local __lux_tmp_79 = shadowSpec._cullSpread
          if __lux_tmp_79 == nil then
            local __lux_tmp_80 = toNumber(shadowSpec.x)
            if __lux_tmp_80 == nil then
              __lux_tmp_80 = 0
            end
            local __lux_tmp_81 = toNumber(shadowSpec.y)
            if __lux_tmp_81 == nil then
              __lux_tmp_81 = 0
            end
            local __lux_tmp_82 = toNumber(shadowSpec.grow)
            if __lux_tmp_82 == nil then
              __lux_tmp_82 = 0
            end
            __lux_tmp_79 = mathAbs(__lux_tmp_80) + mathAbs(__lux_tmp_81) + effectExtentFromSpec(shadowSpec, 12) + __lux_tmp_82
          end
          shadowSpread = __lux_tmp_79
        end
        spread = mathMax(spread, shadowSpread)
      end
      if outerSpec ~= nil then
        local outerSpread
        do
          local __lux_tmp_83 = outerSpec._cullSpread
          if __lux_tmp_83 == nil then
            local __lux_tmp_84 = toNumber(outerSpec.x)
            if __lux_tmp_84 == nil then
              __lux_tmp_84 = 0
            end
            local __lux_tmp_85 = toNumber(outerSpec.y)
            if __lux_tmp_85 == nil then
              __lux_tmp_85 = 0
            end
            local __lux_tmp_86 = toNumber(outerSpec.grow)
            if __lux_tmp_86 == nil then
              __lux_tmp_86 = 0
            end
            __lux_tmp_83 = mathAbs(__lux_tmp_84) + mathAbs(__lux_tmp_85) + effectExtentFromSpec(outerSpec, 18) + __lux_tmp_86
          end
          outerSpread = __lux_tmp_83
        end
        spread = mathMax(spread, outerSpread)
      end
      if backdropSpec ~= nil then
        do
          local __lux_tmp_87 = toNumber(backdropSpec.padding)
          if __lux_tmp_87 == nil then
            __lux_tmp_87 = 0
          end
          spread = mathMax(spread, mathMax(0, __lux_tmp_87))
        end
      end
      return spread
    end
    setColor = function(color)
      return style.setDrawColor(color)
    end
    copyInto = function(out, value)
      for key, _ in pairs(out) do
        out[key] = nil
      end
      if typeOf(value) == "table" then
        for key, item in pairs(value) do
          out[key] = item
        end
      end
      return out
    end
    appendPoint = function(verts, x, y)
      local index = #verts + 1
      local point
      do
        local __lux_tmp_88 = verts[index]
        if __lux_tmp_88 == nil then
          __lux_tmp_88 = {}
        end
        point = __lux_tmp_88
      end
      verts[index] = point
      point.x = x
      point.y = y
      point.u = nil
      point.v = nil
      point.color = nil
    end
    appendCorner = function(verts, cx, cy, radius, fromDeg, toDeg, steps)
      for index = 0, steps do
        local t = index / steps
        local angle = mathRad(fromDeg + (toDeg - fromDeg) * t)
        appendPoint(verts, cx + mathCos(angle) * radius, cy + mathSin(angle) * radius)
      end
    end
    fallbackRoundRectPoints = function(x, y, w, h, radius)
      local verts = clearArray(fallbackRoundRectVerts)
      local __lux_tmp_89 = w <= 0
      if not __lux_tmp_89 then
        __lux_tmp_89 = h <= 0
      end
      if __lux_tmp_89 then
        return verts
      end
      do
        local __lux_tmp_90 = toNumber(radius)
        if __lux_tmp_90 == nil then
          __lux_tmp_90 = 0
        end
        radius = mathMin(mathMax(0, __lux_tmp_90), w * 0.5, h * 0.5)
      end
      if radius <= 0.25 then
        appendPoint(verts, x, y)
        appendPoint(verts, x + w, y)
        appendPoint(verts, x + w, y + h)
        appendPoint(verts, x, y + h)
        return verts
      end
      local steps = mathClamp(mathFloor(radius / 5), 4, 10)
      appendCorner(verts, x + w - radius, y + radius, radius, -90, 0, steps)
      appendCorner(verts, x + w - radius, y + h - radius, radius, 0, 90, steps)
      appendCorner(verts, x + radius, y + h - radius, radius, 90, 180, steps)
      appendCorner(verts, x + radius, y + radius, radius, 180, 270, steps)
      return verts
    end
    drawFallbackStroke = function(points, color, width)
      do
        local __lux_tmp_91 = toNumber(width)
        if __lux_tmp_91 == nil then
          __lux_tmp_91 = 1
        end
        width = mathMax(1, __lux_tmp_91)
      end
      setColor(color)
      for index = 1, #points do
        local a = points[index]
        local b = points[index % #points + 1]
        local dx = b.x - a.x
        local dy = b.y - a.y
        local len = mathMax(0.0001, (dx * dx + dy * dy) ^ 0.5)
        local nx = -dy / len * width * 0.5
        local ny = dx / len * width * 0.5
        local verts = fallbackStrokeVerts
        verts[1].x = a.x + nx
        verts[1].y = a.y + ny
        verts[2].x = b.x + nx
        verts[2].y = b.y + ny
        verts[3].x = b.x - nx
        verts[3].y = b.y - ny
        verts[4].x = a.x - nx
        verts[4].y = a.y - ny
        drawTransformedPoly(verts)
      end
    end
    drawRoundRectFallback = function(x, y, w, h, drawStyle)
      recordFallbacks()
      local fill
      do
        local __lux_tmp_92 = drawStyle.fill
        if __lux_tmp_92 == nil then
          __lux_tmp_92 = drawStyle.color
        end
        fill = hotFillFromStyle(__lux_tmp_92)
      end
      local radius
      do
        local __lux_tmp_93 = drawStyle.radius
        if __lux_tmp_93 == nil then
          local __lux_tmp_94 = drawStyle.r
          if __lux_tmp_94 == nil then
            __lux_tmp_94 = 0
          end
          __lux_tmp_93 = __lux_tmp_94
        end
        radius = __lux_tmp_93
      end
      if hasTransform() then
        local points = fallbackRoundRectPoints(x, y, w, h, radius)
        if style.fillVisible(fill) then
          setColor(fillColor(fill))
          drawTransformedPoly(points)
        end
        local strokeWidth = style.strokeWidth(drawStyle.strokeWidth, 1)
        if style.strokeVisible(drawStyle.stroke, strokeWidth) then
          drawFallbackStroke(points, drawStyle.stroke, mathMax(1, mathFloor(strokeWidth)))
        end
        return
      end
      if style.fillVisible(fill) then
        local radiusValue = roundRectRadiusScalar(radius, w, h)
        if radiusValue <= 0.25 then
          setColor(fillColor(fill))
          surfaceDrawRect(x, y, w, h)
          recordDraws()
        else
          drawRoundedBox(mathFloor(radiusValue), x, y, w, h, fillColor(fill))
          recordDraws()
        end
      end
      if style.strokeVisible(drawStyle.stroke, drawStyle.strokeWidth) then
        setColor(drawStyle.stroke)
        surfaceDrawOutlinedRect(
          x,
          y,
          w,
          h,
          mathMax(1, mathFloor(style.strokeWidth(drawStyle.strokeWidth, 1)))
        )
        recordDraws()
      end
    end
  end
  do
    innerGlowStyle = function(glow)
      local __lux_tmp_95 = glow == nil
      if not __lux_tmp_95 then
        __lux_tmp_95 = glow == false
      end
      if __lux_tmp_95 then
        return nil
      end
      if glow == true then
        return defaultInnerGlowSpec
      end
      if style.isColor(glow) then
        local cached = innerGlowColorCache[glow]
        if cached ~= nil then
          return cached
        end
        cached = { color = glow, width = 7, strength = 1, falloff = style.glowSoftnessToFalloff(0.55) }
        innerGlowColorCache[glow] = cached
        return cached
      end
      if typeOf(glow) ~= "table" then
        return nil
      end
      local cached = innerGlowTableCache[glow]
      local __lux_tmp_96 = cached ~= nil
      if __lux_tmp_96 then
        __lux_tmp_96 = cached._colorInput == glow.color
      end
      local __lux_tmp_97 = __lux_tmp_96
      if __lux_tmp_97 then
        __lux_tmp_97 = cached._tintInput == glow.tint
      end
      local __lux_tmp_98 = __lux_tmp_97
      if __lux_tmp_98 then
        __lux_tmp_98 = cached._sizeInput == glow.size
      end
      local __lux_tmp_99 = __lux_tmp_98
      if __lux_tmp_99 then
        __lux_tmp_99 = cached._widthInput == glow.width
      end
      local __lux_tmp_100 = __lux_tmp_99
      if __lux_tmp_100 then
        __lux_tmp_100 = cached._opacityInput == glow.opacity
      end
      local __lux_tmp_101 = __lux_tmp_100
      if __lux_tmp_101 then
        __lux_tmp_101 = cached._strengthInput == glow.strength
      end
      local __lux_tmp_102 = __lux_tmp_101
      if __lux_tmp_102 then
        __lux_tmp_102 = cached._falloffInput == glow.falloff
      end
      local __lux_tmp_103 = __lux_tmp_102
      if __lux_tmp_103 then
        __lux_tmp_103 = cached._softnessInput == glow.softness
      end
      if __lux_tmp_103 then
        return cached
      end
      local color
      do
        local __lux_tmp_104 = glow.color
        if __lux_tmp_104 == nil then
          __lux_tmp_104 = glow.tint
        end
        color = style.asColor(__lux_tmp_104, defaultInnerGlowColor)
      end
      local width
      do
        local __lux_tmp_105 = glow.size
        if __lux_tmp_105 == nil then
          __lux_tmp_105 = glow.width
        end
        local __lux_tmp_106 = toNumber(__lux_tmp_105)
        if __lux_tmp_106 == nil then
          __lux_tmp_106 = 7
        end
        width = mathMax(1, __lux_tmp_106)
      end
      local strength
      do
        local __lux_tmp_107 = glow.opacity
        if __lux_tmp_107 == nil then
          __lux_tmp_107 = glow.strength
        end
        local __lux_tmp_108 = toNumber(__lux_tmp_107)
        if __lux_tmp_108 == nil then
          __lux_tmp_108 = 1
        end
        strength = __lux_tmp_108
      end
      local falloff
      do
        local __lux_tmp_109 = toNumber(glow.falloff)
        if __lux_tmp_109 == nil then
          __lux_tmp_109 = style.glowSoftnessToFalloff(glow.softness, 0.55)
        end
        falloff = __lux_tmp_109
      end
      cached = {}
      cached.color = color
      cached.width = width
      cached.strength = strength
      cached.falloff = falloff
      cached._colorInput = glow.color
      cached._tintInput = glow.tint
      cached._sizeInput = glow.size
      cached._widthInput = glow.width
      cached._opacityInput = glow.opacity
      cached._strengthInput = glow.strength
      cached._falloffInput = glow.falloff
      cached._softnessInput = glow.softness
      innerGlowTableCache[glow] = cached
      return cached
    end
    effectOffset = function(input, fallbackX, fallbackY)
      if fallbackX == nil then
        fallbackX = 0
      end
      if fallbackY == nil then
        fallbackY = 0
      end
      local x
      do
        local __lux_tmp_110 = input.x
        if __lux_tmp_110 == nil then
          local __lux_tmp_111 = input.offsetX
          if __lux_tmp_111 == nil then
            local __lux_tmp_112 = input.dx
            if __lux_tmp_112 == nil then
              __lux_tmp_112 = input[1]
            end
            __lux_tmp_111 = __lux_tmp_112
          end
          __lux_tmp_110 = __lux_tmp_111
        end
        x = __lux_tmp_110
      end
      local y
      do
        local __lux_tmp_113 = input.y
        if __lux_tmp_113 == nil then
          local __lux_tmp_114 = input.offsetY
          if __lux_tmp_114 == nil then
            local __lux_tmp_115 = input.dy
            if __lux_tmp_115 == nil then
              __lux_tmp_115 = input[2]
            end
            __lux_tmp_114 = __lux_tmp_115
          end
          __lux_tmp_113 = __lux_tmp_114
        end
        y = __lux_tmp_113
      end
      local offset = input.offset
      if typeOf(offset) == "table" then
        do
          local __lux_tmp_116 = x
          if __lux_tmp_116 == nil then
            local __lux_tmp_117 = offset.x
            if __lux_tmp_117 == nil then
              __lux_tmp_117 = offset[1]
            end
            __lux_tmp_116 = __lux_tmp_117
          end
          x = __lux_tmp_116
        end
        do
          local __lux_tmp_118 = y
          if __lux_tmp_118 == nil then
            local __lux_tmp_119 = offset.y
            if __lux_tmp_119 == nil then
              __lux_tmp_119 = offset[2]
            end
            __lux_tmp_118 = __lux_tmp_119
          end
          y = __lux_tmp_118
        end
      end
      local __lux_tmp_120 = toNumber(x)
      if __lux_tmp_120 == nil then
        __lux_tmp_120 = fallbackX
      end
      local __lux_tmp_121 = toNumber(y)
      if __lux_tmp_121 == nil then
        __lux_tmp_121 = fallbackY
      end
      return __lux_tmp_120, __lux_tmp_121
    end
    glowBiasPads = function(base, x, y, minPad)
      if x == nil then
        x = 0
      end
      if y == nil then
        y = 0
      end
      if minPad == nil then
        minPad = 1
      end
      local pad
      do
        local __lux_tmp_122 = toNumber(base)
        if __lux_tmp_122 == nil then
          __lux_tmp_122 = minPad
        end
        pad = mathMax(minPad, __lux_tmp_122)
      end
      local ox
      do
        local __lux_tmp_123 = toNumber(x)
        if __lux_tmp_123 == nil then
          __lux_tmp_123 = 0
        end
        ox = __lux_tmp_123
      end
      local oy
      do
        local __lux_tmp_124 = toNumber(y)
        if __lux_tmp_124 == nil then
          __lux_tmp_124 = 0
        end
        oy = __lux_tmp_124
      end
      return mathMax(minPad, pad - ox), mathMax(minPad, pad - oy), mathMax(minPad, pad + ox), mathMax(minPad, pad + oy)
    end
    outerGlowStyle = function(glow)
      local __lux_tmp_125 = glow == nil
      if not __lux_tmp_125 then
        __lux_tmp_125 = glow == false
      end
      if __lux_tmp_125 then
        return nil
      end
      if glow == true then
        return defaultOuterGlowSpec
      end
      if style.isColor(glow) then
        local cached = outerGlowColorCache[glow]
        if cached ~= nil then
          return cached
        end
        cached = {
          color = glow,
          x = 0,
          y = 0,
          width = 18,
          spread = 18,
          grow = 0,
          strength = 1,
          falloff = style.glowSoftnessToFalloff(0.54),
        }
        cached._extent = effectExtentFromSpec(cached, 18)
        cached._cullSpread = cached._extent
        outerGlowColorCache[glow] = cached
        return cached
      end
      if typeOf(glow) ~= "table" then
        return nil
      end
      local cacheable = typeOf(glow.offset) ~= "table"
      local cached
      if cacheable then
        cached = outerGlowTableCache[glow]
      else
        cached = nil
      end
      local __lux_tmp_126 = cached ~= nil
      if __lux_tmp_126 then
        __lux_tmp_126 = cached._xInput == glow.x
      end
      local __lux_tmp_127 = __lux_tmp_126
      if __lux_tmp_127 then
        __lux_tmp_127 = cached._offsetXInput == glow.offsetX
      end
      local __lux_tmp_128 = __lux_tmp_127
      if __lux_tmp_128 then
        __lux_tmp_128 = cached._dxInput == glow.dx
      end
      local __lux_tmp_129 = __lux_tmp_128
      if __lux_tmp_129 then
        __lux_tmp_129 = cached._indexXInput == glow[1]
      end
      local __lux_tmp_130 = __lux_tmp_129
      if __lux_tmp_130 then
        __lux_tmp_130 = cached._yInput == glow.y
      end
      local __lux_tmp_131 = __lux_tmp_130
      if __lux_tmp_131 then
        __lux_tmp_131 = cached._offsetYInput == glow.offsetY
      end
      local __lux_tmp_132 = __lux_tmp_131
      if __lux_tmp_132 then
        __lux_tmp_132 = cached._dyInput == glow.dy
      end
      local __lux_tmp_133 = __lux_tmp_132
      if __lux_tmp_133 then
        __lux_tmp_133 = cached._indexYInput == glow[2]
      end
      local __lux_tmp_134 = __lux_tmp_133
      if __lux_tmp_134 then
        __lux_tmp_134 = cached._sizeInput == glow.size
      end
      local __lux_tmp_135 = __lux_tmp_134
      if __lux_tmp_135 then
        __lux_tmp_135 = cached._widthInput == glow.width
      end
      local __lux_tmp_136 = __lux_tmp_135
      if __lux_tmp_136 then
        __lux_tmp_136 = cached._blurInput == glow.blur
      end
      local __lux_tmp_137 = __lux_tmp_136
      if __lux_tmp_137 then
        __lux_tmp_137 = cached._radiusInput == glow.radius
      end
      local __lux_tmp_138 = __lux_tmp_137
      if __lux_tmp_138 then
        __lux_tmp_138 = cached._spreadInput == glow.spread
      end
      local __lux_tmp_139 = __lux_tmp_138
      if __lux_tmp_139 then
        __lux_tmp_139 = cached._colorInput == glow.color
      end
      local __lux_tmp_140 = __lux_tmp_139
      if __lux_tmp_140 then
        __lux_tmp_140 = cached._tintInput == glow.tint
      end
      local __lux_tmp_141 = __lux_tmp_140
      if __lux_tmp_141 then
        __lux_tmp_141 = cached._growInput == glow.grow
      end
      local __lux_tmp_142 = __lux_tmp_141
      if __lux_tmp_142 then
        __lux_tmp_142 = cached._expandInput == glow.expand
      end
      local __lux_tmp_143 = __lux_tmp_142
      if __lux_tmp_143 then
        __lux_tmp_143 = cached._shapeSpreadInput == glow.shapeSpread
      end
      local __lux_tmp_144 = __lux_tmp_143
      if __lux_tmp_144 then
        __lux_tmp_144 = cached._opacityInput == glow.opacity
      end
      local __lux_tmp_145 = __lux_tmp_144
      if __lux_tmp_145 then
        __lux_tmp_145 = cached._strengthInput == glow.strength
      end
      local __lux_tmp_146 = __lux_tmp_145
      if __lux_tmp_146 then
        __lux_tmp_146 = cached._falloffInput == glow.falloff
      end
      local __lux_tmp_147 = __lux_tmp_146
      if __lux_tmp_147 then
        __lux_tmp_147 = cached._softnessInput == glow.softness
      end
      if __lux_tmp_147 then
        return cached
      end
      local x, y = effectOffset(glow, 0, 0)
      local width
      do
        local __lux_tmp_148 = glow.size
        if __lux_tmp_148 == nil then
          local __lux_tmp_149 = glow.width
          if __lux_tmp_149 == nil then
            local __lux_tmp_150 = glow.blur
            if __lux_tmp_150 == nil then
              local __lux_tmp_151 = glow.radius
              if __lux_tmp_151 == nil then
                __lux_tmp_151 = glow.spread
              end
              __lux_tmp_150 = __lux_tmp_151
            end
            __lux_tmp_149 = __lux_tmp_150
          end
          __lux_tmp_148 = __lux_tmp_149
        end
        local __lux_tmp_152 = toNumber(__lux_tmp_148)
        if __lux_tmp_152 == nil then
          __lux_tmp_152 = 18
        end
        width = mathMax(1, __lux_tmp_152)
      end
      local color
      do
        local __lux_tmp_153 = glow.color
        if __lux_tmp_153 == nil then
          __lux_tmp_153 = glow.tint
        end
        color = style.asColor(__lux_tmp_153, defaultOuterGlowColor)
      end
      local spread
      do
        local __lux_tmp_154 = toNumber(glow.spread)
        if __lux_tmp_154 == nil then
          __lux_tmp_154 = width
        end
        spread = mathMax(1, __lux_tmp_154)
      end
      local grow
      do
        local __lux_tmp_155 = glow.grow
        if __lux_tmp_155 == nil then
          local __lux_tmp_156 = glow.expand
          if __lux_tmp_156 == nil then
            __lux_tmp_156 = glow.shapeSpread
          end
          __lux_tmp_155 = __lux_tmp_156
        end
        local __lux_tmp_157 = toNumber(__lux_tmp_155)
        if __lux_tmp_157 == nil then
          __lux_tmp_157 = 0
        end
        grow = mathMax(0, __lux_tmp_157)
      end
      local strength
      do
        local __lux_tmp_158 = glow.opacity
        if __lux_tmp_158 == nil then
          __lux_tmp_158 = glow.strength
        end
        local __lux_tmp_159 = toNumber(__lux_tmp_158)
        if __lux_tmp_159 == nil then
          __lux_tmp_159 = 1
        end
        strength = __lux_tmp_159
      end
      local falloff
      do
        local __lux_tmp_160 = toNumber(glow.falloff)
        if __lux_tmp_160 == nil then
          __lux_tmp_160 = style.glowSoftnessToFalloff(glow.softness, 0.54)
        end
        falloff = __lux_tmp_160
      end
      cached = {}
      cached.color = color
      cached.x = x
      cached.y = y
      cached.width = width
      cached.spread = spread
      cached.grow = grow
      cached.strength = strength
      cached.falloff = falloff
      cached._extent = effectExtentFromSpec(cached, 18)
      cached._cullSpread = mathAbs(x) + mathAbs(y) + cached._extent + grow
      if cacheable then
        cached._xInput = glow.x
        cached._offsetXInput = glow.offsetX
        cached._dxInput = glow.dx
        cached._indexXInput = glow[1]
        cached._yInput = glow.y
        cached._offsetYInput = glow.offsetY
        cached._dyInput = glow.dy
        cached._indexYInput = glow[2]
        cached._sizeInput = glow.size
        cached._widthInput = glow.width
        cached._blurInput = glow.blur
        cached._radiusInput = glow.radius
        cached._spreadInput = glow.spread
        cached._colorInput = glow.color
        cached._tintInput = glow.tint
        cached._growInput = glow.grow
        cached._expandInput = glow.expand
        cached._shapeSpreadInput = glow.shapeSpread
        cached._opacityInput = glow.opacity
        cached._strengthInput = glow.strength
        cached._falloffInput = glow.falloff
        cached._softnessInput = glow.softness
        outerGlowTableCache[glow] = cached
      end
      return cached
    end
    shadowStyle = function(shadow)
      local __lux_tmp_161 = shadow == nil
      if not __lux_tmp_161 then
        __lux_tmp_161 = shadow == false
      end
      if __lux_tmp_161 then
        return nil
      end
      if shadow == true then
        return defaultShadowSpec
      end
      if style.isColor(shadow) then
        local cached = shadowColorCache[shadow]
        if cached ~= nil then
          return cached
        end
        cached = {
          color = shadow,
          x = 0,
          y = 4,
          width = 12,
          spread = 12,
          grow = 0,
          strength = 1,
          falloff = style.glowSoftnessToFalloff(0.62),
        }
        cached._extent = effectExtentFromSpec(cached, 12)
        cached._cullSpread = mathAbs(cached.x) + mathAbs(cached.y) + cached._extent + cached.grow
        shadowColorCache[shadow] = cached
        return cached
      end
      if typeOf(shadow) ~= "table" then
        local blur
        do
          local __lux_tmp_162 = toNumber(shadow)
          if __lux_tmp_162 == nil then
            __lux_tmp_162 = 12
          end
          blur = mathMax(0.001, __lux_tmp_162)
        end
        local cached = shadowNumberCache[blur]
        if cached ~= nil then
          return cached
        end
        cached = {
          color = defaultShadowColor,
          x = 0,
          y = 4,
          width = blur,
          spread = mathMax(1, blur),
          grow = 0,
          strength = 1,
          falloff = style.glowSoftnessToFalloff(0.62),
        }
        cached._extent = effectExtentFromSpec(cached, 12)
        cached._cullSpread = mathAbs(cached.x) + mathAbs(cached.y) + cached._extent + cached.grow
        shadowNumberCache[blur] = cached
        return cached
      end
      local cacheable = typeOf(shadow.offset) ~= "table"
      local cached
      if cacheable then
        cached = shadowTableCache[shadow]
      else
        cached = nil
      end
      local __lux_tmp_163 = cached ~= nil
      if __lux_tmp_163 then
        __lux_tmp_163 = cached._xInput == shadow.x
      end
      local __lux_tmp_164 = __lux_tmp_163
      if __lux_tmp_164 then
        __lux_tmp_164 = cached._offsetXInput == shadow.offsetX
      end
      local __lux_tmp_165 = __lux_tmp_164
      if __lux_tmp_165 then
        __lux_tmp_165 = cached._dxInput == shadow.dx
      end
      local __lux_tmp_166 = __lux_tmp_165
      if __lux_tmp_166 then
        __lux_tmp_166 = cached._indexXInput == shadow[1]
      end
      local __lux_tmp_167 = __lux_tmp_166
      if __lux_tmp_167 then
        __lux_tmp_167 = cached._yInput == shadow.y
      end
      local __lux_tmp_168 = __lux_tmp_167
      if __lux_tmp_168 then
        __lux_tmp_168 = cached._offsetYInput == shadow.offsetY
      end
      local __lux_tmp_169 = __lux_tmp_168
      if __lux_tmp_169 then
        __lux_tmp_169 = cached._dyInput == shadow.dy
      end
      local __lux_tmp_170 = __lux_tmp_169
      if __lux_tmp_170 then
        __lux_tmp_170 = cached._indexYInput == shadow[2]
      end
      local __lux_tmp_171 = __lux_tmp_170
      if __lux_tmp_171 then
        __lux_tmp_171 = cached._blurInput == shadow.blur
      end
      local __lux_tmp_172 = __lux_tmp_171
      if __lux_tmp_172 then
        __lux_tmp_172 = cached._radiusInput == shadow.radius
      end
      local __lux_tmp_173 = __lux_tmp_172
      if __lux_tmp_173 then
        __lux_tmp_173 = cached._sizeInput == shadow.size
      end
      local __lux_tmp_174 = __lux_tmp_173
      if __lux_tmp_174 then
        __lux_tmp_174 = cached._widthInput == shadow.width
      end
      local __lux_tmp_175 = __lux_tmp_174
      if __lux_tmp_175 then
        __lux_tmp_175 = cached._spreadInput == shadow.spread
      end
      local __lux_tmp_176 = __lux_tmp_175
      if __lux_tmp_176 then
        __lux_tmp_176 = cached._growInput == shadow.grow
      end
      local __lux_tmp_177 = __lux_tmp_176
      if __lux_tmp_177 then
        __lux_tmp_177 = cached._expandInput == shadow.expand
      end
      local __lux_tmp_178 = __lux_tmp_177
      if __lux_tmp_178 then
        __lux_tmp_178 = cached._shapeSpreadInput == shadow.shapeSpread
      end
      local __lux_tmp_179 = __lux_tmp_178
      if __lux_tmp_179 then
        __lux_tmp_179 = cached._colorInput == shadow.color
      end
      local __lux_tmp_180 = __lux_tmp_179
      if __lux_tmp_180 then
        __lux_tmp_180 = cached._tintInput == shadow.tint
      end
      local __lux_tmp_181 = __lux_tmp_180
      if __lux_tmp_181 then
        __lux_tmp_181 = cached._extentInput == shadow.extent
      end
      local __lux_tmp_182 = __lux_tmp_181
      if __lux_tmp_182 then
        __lux_tmp_182 = cached._paddingInput == shadow.padding
      end
      local __lux_tmp_183 = __lux_tmp_182
      if __lux_tmp_183 then
        __lux_tmp_183 = cached._opacityInput == shadow.opacity
      end
      local __lux_tmp_184 = __lux_tmp_183
      if __lux_tmp_184 then
        __lux_tmp_184 = cached._strengthInput == shadow.strength
      end
      local __lux_tmp_185 = __lux_tmp_184
      if __lux_tmp_185 then
        __lux_tmp_185 = cached._falloffInput == shadow.falloff
      end
      local __lux_tmp_186 = __lux_tmp_185
      if __lux_tmp_186 then
        __lux_tmp_186 = cached._softnessInput == shadow.softness
      end
      if __lux_tmp_186 then
        return cached
      end
      local x, y = effectOffset(shadow, 0, 4)
      local blur
      do
        local __lux_tmp_187 = shadow.blur
        if __lux_tmp_187 == nil then
          local __lux_tmp_188 = shadow.radius
          if __lux_tmp_188 == nil then
            local __lux_tmp_189 = shadow.size
            if __lux_tmp_189 == nil then
              __lux_tmp_189 = shadow.width
            end
            __lux_tmp_188 = __lux_tmp_189
          end
          __lux_tmp_187 = __lux_tmp_188
        end
        local __lux_tmp_190 = toNumber(__lux_tmp_187)
        if __lux_tmp_190 == nil then
          __lux_tmp_190 = 12
        end
        blur = mathMax(0.001, __lux_tmp_190)
      end
      local grow
      do
        local __lux_tmp_191 = shadow.spread
        if __lux_tmp_191 == nil then
          local __lux_tmp_192 = shadow.grow
          if __lux_tmp_192 == nil then
            local __lux_tmp_193 = shadow.expand
            if __lux_tmp_193 == nil then
              __lux_tmp_193 = shadow.shapeSpread
            end
            __lux_tmp_192 = __lux_tmp_193
          end
          __lux_tmp_191 = __lux_tmp_192
        end
        local __lux_tmp_194 = toNumber(__lux_tmp_191)
        if __lux_tmp_194 == nil then
          __lux_tmp_194 = 0
        end
        grow = mathMax(0, __lux_tmp_194)
      end
      local color
      do
        local __lux_tmp_195 = shadow.color
        if __lux_tmp_195 == nil then
          __lux_tmp_195 = shadow.tint
        end
        color = style.asColor(__lux_tmp_195, defaultShadowColor)
      end
      local spread
      do
        local __lux_tmp_196 = shadow.extent
        if __lux_tmp_196 == nil then
          __lux_tmp_196 = shadow.padding
        end
        local __lux_tmp_197 = toNumber(__lux_tmp_196)
        if __lux_tmp_197 == nil then
          __lux_tmp_197 = blur
        end
        spread = mathMax(1, __lux_tmp_197)
      end
      local strength
      do
        local __lux_tmp_198 = shadow.opacity
        if __lux_tmp_198 == nil then
          __lux_tmp_198 = shadow.strength
        end
        local __lux_tmp_199 = toNumber(__lux_tmp_198)
        if __lux_tmp_199 == nil then
          __lux_tmp_199 = 1
        end
        strength = __lux_tmp_199
      end
      local falloff
      do
        local __lux_tmp_200 = toNumber(shadow.falloff)
        if __lux_tmp_200 == nil then
          __lux_tmp_200 = style.glowSoftnessToFalloff(shadow.softness, 0.62)
        end
        falloff = __lux_tmp_200
      end
      cached = {}
      cached.color = color
      cached.x = x
      cached.y = y
      cached.width = blur
      cached.spread = spread
      cached.grow = grow
      cached.strength = strength
      cached.falloff = falloff
      cached._extent = effectExtentFromSpec(cached, 12)
      cached._cullSpread = mathAbs(x) + mathAbs(y) + cached._extent + grow
      if cacheable then
        cached._xInput = shadow.x
        cached._offsetXInput = shadow.offsetX
        cached._dxInput = shadow.dx
        cached._indexXInput = shadow[1]
        cached._yInput = shadow.y
        cached._offsetYInput = shadow.offsetY
        cached._dyInput = shadow.dy
        cached._indexYInput = shadow[2]
        cached._blurInput = shadow.blur
        cached._radiusInput = shadow.radius
        cached._sizeInput = shadow.size
        cached._widthInput = shadow.width
        cached._spreadInput = shadow.spread
        cached._growInput = shadow.grow
        cached._expandInput = shadow.expand
        cached._shapeSpreadInput = shadow.shapeSpread
        cached._colorInput = shadow.color
        cached._tintInput = shadow.tint
        cached._extentInput = shadow.extent
        cached._paddingInput = shadow.padding
        cached._opacityInput = shadow.opacity
        cached._strengthInput = shadow.strength
        cached._falloffInput = shadow.falloff
        cached._softnessInput = shadow.softness
        shadowTableCache[shadow] = cached
      end
      return cached
    end
    patternStyle = function(pattern)
      local __lux_tmp_201 = pattern == nil
      if not __lux_tmp_201 then
        __lux_tmp_201 = pattern == false
      end
      if __lux_tmp_201 then
        return nil
      end
      if pattern == true then
        return style.stripePattern(makeColor(255, 255, 255, 20), 10, 2, 135)
      end
      if typeOf(pattern) == "table" then
        local knownPattern
        local __lux_match_202 = pattern.kind
        if __lux_match_202 == "stripe" or __lux_match_202 == "smoke" then
          knownPattern = true
        else
          knownPattern = false
        end
        if knownPattern then
          return pattern
        end
        return style.stripePattern(pattern)
      end
      return nil
    end
    patternOffset = function(pattern)
      local offset
      do
        local __lux_obj_203 = pattern
        local __lux_val_204 = nil
        if __lux_obj_203 ~= nil then
          __lux_val_204 = __lux_obj_203.offset
        end
        local __lux_tmp_205 = toNumber(__lux_val_204)
        if __lux_tmp_205 == nil then
          __lux_tmp_205 = 0
        end
        offset = __lux_tmp_205
      end
      local speed
      do
        local __lux_obj_206 = pattern
        local __lux_val_207 = nil
        if __lux_obj_206 ~= nil then
          __lux_val_207 = __lux_obj_206.speed
        end
        local __lux_tmp_208 = toNumber(__lux_val_207)
        if __lux_tmp_208 == nil then
          __lux_tmp_208 = 0
        end
        speed = __lux_tmp_208
      end
      local __lux_tmp_209 = speed ~= 0
      if __lux_tmp_209 then
        __lux_tmp_209 = realTime ~= nil
      end
      if __lux_tmp_209 then
        offset = offset + realTime() * speed
      end
      return offset
    end
  end
  do
    roundRectFillParams = function(material, fill)
      local p0 = 0
      local p1 = 0
      local p2 = 1
      local p3 = 0
      local __lux_match_210 = fill
      local __lux_tag_211
      if __lux_match_210 ~= nil then
        __lux_tag_211 = __lux_match_210.kind
      end
      if __lux_tag_211 == style.FILL_LINEAR then
        local x1 = __lux_match_210.x1
        local y1 = __lux_match_210.y1
        local x2 = __lux_match_210.x2
        local y2 = __lux_match_210.y2
        do
          local __lux_tmp_212 = x1
          if __lux_tmp_212 == nil then
            __lux_tmp_212 = 0
          end
          p0 = __lux_tmp_212
        end
        do
          local __lux_tmp_213 = y1
          if __lux_tmp_213 == nil then
            __lux_tmp_213 = 0
          end
          p1 = __lux_tmp_213
        end
        do
          local __lux_tmp_214 = x2
          if __lux_tmp_214 == nil then
            __lux_tmp_214 = 1
          end
          p2 = __lux_tmp_214
        end
        do
          local __lux_tmp_215 = y2
          if __lux_tmp_215 == nil then
            __lux_tmp_215 = 1
          end
          p3 = __lux_tmp_215
        end
        style.bindGradientLut(material, fill)
      elseif __lux_tag_211 == style.FILL_RADIAL then
        local cx = __lux_match_210.cx
        local cy = __lux_match_210.cy
        local radius = __lux_match_210.radius
        do
          local __lux_tmp_216 = cx
          if __lux_tmp_216 == nil then
            __lux_tmp_216 = 0.5
          end
          p0 = __lux_tmp_216
        end
        do
          local __lux_tmp_217 = cy
          if __lux_tmp_217 == nil then
            __lux_tmp_217 = 0.5
          end
          p1 = __lux_tmp_217
        end
        do
          local __lux_tmp_218 = radius
          if __lux_tmp_218 == nil then
            __lux_tmp_218 = 0.5
          end
          p2 = __lux_tmp_218
        end
        p3 = 0
        style.bindGradientLut(material, fill)
      elseif __lux_tag_211 == style.FILL_CONIC then
        local cx = __lux_match_210.cx
        local cy = __lux_match_210.cy
        local rotation = __lux_match_210.rotation
        do
          local __lux_tmp_219 = cx
          if __lux_tmp_219 == nil then
            __lux_tmp_219 = 0.5
          end
          p0 = __lux_tmp_219
        end
        do
          local __lux_tmp_220 = cy
          if __lux_tmp_220 == nil then
            __lux_tmp_220 = 0.5
          end
          p1 = __lux_tmp_220
        end
        p2 = style.normalizedRotation(rotation)
        p3 = 0
        style.bindGradientLut(material, fill)
      else
        local __lux_unused_221 = nil
      end
      return p0, p1, p2, p3
    end
    inv255 = 1 / 255
    setupParamMatrix = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3)
      local __lux_tmp_222 = material == nil
      if not __lux_tmp_222 then
        __lux_tmp_222 = paramMatrixSetUnpacked == nil
      end
      local __lux_tmp_223 = __lux_tmp_222
      if not __lux_tmp_223 then
        __lux_tmp_223 = matrixCtor == nil
      end
      if __lux_tmp_223 then
        return false
      end
      local matrix = paramMatrices[material]
      if matrix == nil then
        matrix = matrixCtor()
        paramMatrices[material] = matrix
      end
      do
        local __lux_tmp_224 = a0
        if __lux_tmp_224 == nil then
          __lux_tmp_224 = 0
        end
        local __lux_tmp_225 = b0
        if __lux_tmp_225 == nil then
          __lux_tmp_225 = 0
        end
        local __lux_tmp_226 = c0
        if __lux_tmp_226 == nil then
          __lux_tmp_226 = 0
        end
        local __lux_tmp_227 = d0
        if __lux_tmp_227 == nil then
          __lux_tmp_227 = 0
        end
        local __lux_tmp_228 = a1
        if __lux_tmp_228 == nil then
          __lux_tmp_228 = 0
        end
        local __lux_tmp_229 = b1
        if __lux_tmp_229 == nil then
          __lux_tmp_229 = 0
        end
        local __lux_tmp_230 = c1
        if __lux_tmp_230 == nil then
          __lux_tmp_230 = 0
        end
        local __lux_tmp_231 = d1
        if __lux_tmp_231 == nil then
          __lux_tmp_231 = 0
        end
        local __lux_tmp_232 = a2
        if __lux_tmp_232 == nil then
          __lux_tmp_232 = 0
        end
        local __lux_tmp_233 = b2
        if __lux_tmp_233 == nil then
          __lux_tmp_233 = 0
        end
        local __lux_tmp_234 = c2
        if __lux_tmp_234 == nil then
          __lux_tmp_234 = 0
        end
        local __lux_tmp_235 = d2
        if __lux_tmp_235 == nil then
          __lux_tmp_235 = 0
        end
        local __lux_tmp_236 = a3
        if __lux_tmp_236 == nil then
          __lux_tmp_236 = 0
        end
        local __lux_tmp_237 = b3
        if __lux_tmp_237 == nil then
          __lux_tmp_237 = 0
        end
        local __lux_tmp_238 = c3
        if __lux_tmp_238 == nil then
          __lux_tmp_238 = 0
        end
        local __lux_tmp_239 = d3
        if __lux_tmp_239 == nil then
          __lux_tmp_239 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_224,
          __lux_tmp_225,
          __lux_tmp_226,
          __lux_tmp_227,
          __lux_tmp_228,
          __lux_tmp_229,
          __lux_tmp_230,
          __lux_tmp_231,
          __lux_tmp_232,
          __lux_tmp_233,
          __lux_tmp_234,
          __lux_tmp_235,
          __lux_tmp_236,
          __lux_tmp_237,
          __lux_tmp_238,
          __lux_tmp_239
        )
      end
      material:SetMatrix("$viewprojmat", matrix)
      return true
    end
    setupParamMatrixRaw = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3)
      local state = paramMatrixRawState[material]
      local __lux_tmp_240 = state ~= nil
      if __lux_tmp_240 then
        __lux_tmp_240 = state[1] == a0
      end
      local __lux_tmp_241 = __lux_tmp_240
      if __lux_tmp_241 then
        __lux_tmp_241 = state[2] == a1
      end
      local __lux_tmp_242 = __lux_tmp_241
      if __lux_tmp_242 then
        __lux_tmp_242 = state[3] == a2
      end
      local __lux_tmp_243 = __lux_tmp_242
      if __lux_tmp_243 then
        __lux_tmp_243 = state[4] == a3
      end
      local __lux_tmp_244 = __lux_tmp_243
      if __lux_tmp_244 then
        __lux_tmp_244 = state[5] == b0
      end
      local __lux_tmp_245 = __lux_tmp_244
      if __lux_tmp_245 then
        __lux_tmp_245 = state[6] == b1
      end
      local __lux_tmp_246 = __lux_tmp_245
      if __lux_tmp_246 then
        __lux_tmp_246 = state[7] == b2
      end
      local __lux_tmp_247 = __lux_tmp_246
      if __lux_tmp_247 then
        __lux_tmp_247 = state[8] == b3
      end
      local __lux_tmp_248 = __lux_tmp_247
      if __lux_tmp_248 then
        __lux_tmp_248 = state[9] == c0
      end
      local __lux_tmp_249 = __lux_tmp_248
      if __lux_tmp_249 then
        __lux_tmp_249 = state[10] == c1
      end
      local __lux_tmp_250 = __lux_tmp_249
      if __lux_tmp_250 then
        __lux_tmp_250 = state[11] == c2
      end
      local __lux_tmp_251 = __lux_tmp_250
      if __lux_tmp_251 then
        __lux_tmp_251 = state[12] == c3
      end
      local __lux_tmp_252 = __lux_tmp_251
      if __lux_tmp_252 then
        __lux_tmp_252 = state[13] == d0
      end
      local __lux_tmp_253 = __lux_tmp_252
      if __lux_tmp_253 then
        __lux_tmp_253 = state[14] == d1
      end
      local __lux_tmp_254 = __lux_tmp_253
      if __lux_tmp_254 then
        __lux_tmp_254 = state[15] == d2
      end
      local __lux_tmp_255 = __lux_tmp_254
      if __lux_tmp_255 then
        __lux_tmp_255 = state[16] == d3
      end
      if __lux_tmp_255 then
        return
      end
      if state == nil then
        state = {}
        paramMatrixRawState[material] = state
      end
      state[1] = a0
      state[2] = a1
      state[3] = a2
      state[4] = a3
      state[5] = b0
      state[6] = b1
      state[7] = b2
      state[8] = b3
      state[9] = c0
      state[10] = c1
      state[11] = c2
      state[12] = c3
      state[13] = d0
      state[14] = d1
      state[15] = d2
      state[16] = d3
      local matrix = paramMatrices[material]
      if matrix == nil then
        matrix = matrixCtor()
        paramMatrices[material] = matrix
      end
      paramMatrixSetUnpacked(
        matrix,
        a0,
        b0,
        c0,
        d0,
        a1,
        b1,
        c1,
        d1,
        a2,
        b2,
        c2,
        d2,
        a3,
        b3,
        c3,
        d3
      )
      return material:SetMatrix("$viewprojmat", matrix)
    end
    setupAuxConstants = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3)
      local __lux_tmp_256 = material == nil
      if not __lux_tmp_256 then
        __lux_tmp_256 = paramMatrixSetUnpacked == nil
      end
      local __lux_tmp_257 = __lux_tmp_256
      if not __lux_tmp_257 then
        __lux_tmp_257 = matrixCtor == nil
      end
      if __lux_tmp_257 then
        return false
      end
      local matrix = auxParamMatrices[material]
      if matrix == nil then
        matrix = matrixCtor()
        auxParamMatrices[material] = matrix
      end
      do
        local __lux_tmp_258 = a0
        if __lux_tmp_258 == nil then
          __lux_tmp_258 = 0
        end
        local __lux_tmp_259 = b0
        if __lux_tmp_259 == nil then
          __lux_tmp_259 = 0
        end
        local __lux_tmp_260 = c0
        if __lux_tmp_260 == nil then
          __lux_tmp_260 = 0
        end
        local __lux_tmp_261 = d0
        if __lux_tmp_261 == nil then
          __lux_tmp_261 = 0
        end
        local __lux_tmp_262 = a1
        if __lux_tmp_262 == nil then
          __lux_tmp_262 = 0
        end
        local __lux_tmp_263 = b1
        if __lux_tmp_263 == nil then
          __lux_tmp_263 = 0
        end
        local __lux_tmp_264 = c1
        if __lux_tmp_264 == nil then
          __lux_tmp_264 = 0
        end
        local __lux_tmp_265 = d1
        if __lux_tmp_265 == nil then
          __lux_tmp_265 = 0
        end
        local __lux_tmp_266 = a2
        if __lux_tmp_266 == nil then
          __lux_tmp_266 = 0
        end
        local __lux_tmp_267 = b2
        if __lux_tmp_267 == nil then
          __lux_tmp_267 = 0
        end
        local __lux_tmp_268 = c2
        if __lux_tmp_268 == nil then
          __lux_tmp_268 = 0
        end
        local __lux_tmp_269 = d2
        if __lux_tmp_269 == nil then
          __lux_tmp_269 = 0
        end
        local __lux_tmp_270 = a3
        if __lux_tmp_270 == nil then
          __lux_tmp_270 = 0
        end
        local __lux_tmp_271 = b3
        if __lux_tmp_271 == nil then
          __lux_tmp_271 = 0
        end
        local __lux_tmp_272 = c3
        if __lux_tmp_272 == nil then
          __lux_tmp_272 = 0
        end
        local __lux_tmp_273 = d3
        if __lux_tmp_273 == nil then
          __lux_tmp_273 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_258,
          __lux_tmp_259,
          __lux_tmp_260,
          __lux_tmp_261,
          __lux_tmp_262,
          __lux_tmp_263,
          __lux_tmp_264,
          __lux_tmp_265,
          __lux_tmp_266,
          __lux_tmp_267,
          __lux_tmp_268,
          __lux_tmp_269,
          __lux_tmp_270,
          __lux_tmp_271,
          __lux_tmp_272,
          __lux_tmp_273
        )
      end
      material:SetMatrix("$invviewprojmat", matrix)
      return true
    end
    setupAuxConstantsRaw = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3)
      local state = auxParamMatrixRawState[material]
      local __lux_tmp_274 = state ~= nil
      if __lux_tmp_274 then
        __lux_tmp_274 = state[1] == a0
      end
      local __lux_tmp_275 = __lux_tmp_274
      if __lux_tmp_275 then
        __lux_tmp_275 = state[2] == a1
      end
      local __lux_tmp_276 = __lux_tmp_275
      if __lux_tmp_276 then
        __lux_tmp_276 = state[3] == a2
      end
      local __lux_tmp_277 = __lux_tmp_276
      if __lux_tmp_277 then
        __lux_tmp_277 = state[4] == a3
      end
      local __lux_tmp_278 = __lux_tmp_277
      if __lux_tmp_278 then
        __lux_tmp_278 = state[5] == b0
      end
      local __lux_tmp_279 = __lux_tmp_278
      if __lux_tmp_279 then
        __lux_tmp_279 = state[6] == b1
      end
      local __lux_tmp_280 = __lux_tmp_279
      if __lux_tmp_280 then
        __lux_tmp_280 = state[7] == b2
      end
      local __lux_tmp_281 = __lux_tmp_280
      if __lux_tmp_281 then
        __lux_tmp_281 = state[8] == b3
      end
      local __lux_tmp_282 = __lux_tmp_281
      if __lux_tmp_282 then
        __lux_tmp_282 = state[9] == c0
      end
      local __lux_tmp_283 = __lux_tmp_282
      if __lux_tmp_283 then
        __lux_tmp_283 = state[10] == c1
      end
      local __lux_tmp_284 = __lux_tmp_283
      if __lux_tmp_284 then
        __lux_tmp_284 = state[11] == c2
      end
      local __lux_tmp_285 = __lux_tmp_284
      if __lux_tmp_285 then
        __lux_tmp_285 = state[12] == c3
      end
      local __lux_tmp_286 = __lux_tmp_285
      if __lux_tmp_286 then
        __lux_tmp_286 = state[13] == d0
      end
      local __lux_tmp_287 = __lux_tmp_286
      if __lux_tmp_287 then
        __lux_tmp_287 = state[14] == d1
      end
      local __lux_tmp_288 = __lux_tmp_287
      if __lux_tmp_288 then
        __lux_tmp_288 = state[15] == d2
      end
      local __lux_tmp_289 = __lux_tmp_288
      if __lux_tmp_289 then
        __lux_tmp_289 = state[16] == d3
      end
      if __lux_tmp_289 then
        return true
      end
      if state == nil then
        state = {}
        auxParamMatrixRawState[material] = state
      end
      state[1] = a0
      state[2] = a1
      state[3] = a2
      state[4] = a3
      state[5] = b0
      state[6] = b1
      state[7] = b2
      state[8] = b3
      state[9] = c0
      state[10] = c1
      state[11] = c2
      state[12] = c3
      state[13] = d0
      state[14] = d1
      state[15] = d2
      state[16] = d3
      local matrix = auxParamMatrices[material]
      if matrix == nil then
        matrix = matrixCtor()
        auxParamMatrices[material] = matrix
      end
      paramMatrixSetUnpacked(
        matrix,
        a0,
        b0,
        c0,
        d0,
        a1,
        b1,
        c1,
        d1,
        a2,
        b2,
        c2,
        d2,
        a3,
        b3,
        c3,
        d3
      )
      material:SetMatrix("$invviewprojmat", matrix)
      return true
    end
    setupConstants = function(material, w, h, fill, stroke, strokeWidth, radius)
      if material == nil then
        return false
      end
      do
        local __lux_tmp_290 = fill
        if __lux_tmp_290 == nil then
          __lux_tmp_290 = style.solid(color_white)
        end
        fill = __lux_tmp_290
      end
      local colorA
      do
        local __lux_tmp_291 = fill.colorA
        if __lux_tmp_291 == nil then
          __lux_tmp_291 = color_white
        end
        colorA = __lux_tmp_291
      end
      local colorB
      do
        local __lux_tmp_292 = fill.colorB
        if __lux_tmp_292 == nil then
          __lux_tmp_292 = colorA
        end
        colorB = __lux_tmp_292
      end
      local strokeColor
      do
        local __lux_tmp_293 = stroke
        if __lux_tmp_293 == nil then
          __lux_tmp_293 = transparentColor
        end
        strokeColor = __lux_tmp_293
      end
      local fillKind
      do
        local __lux_tmp_294 = fill.kind
        if __lux_tmp_294 == nil then
          __lux_tmp_294 = style.FILL_SOLID
        end
        fillKind = __lux_tmp_294
      end
      local packedStyle = mathClamp(style.strokeWidth(strokeWidth, 0), 0, 255) + mathClamp(fillKind, 0, 3) * 256
      local r, g, b, a = style.color01(colorB)
      local p0, p1, p2, p3 = roundRectFillParams(material, fill)
      local sr, sg, sb, sa = style.color01(strokeColor)
      do
        local __lux_tmp_295 = toNumber(radius)
        if __lux_tmp_295 == nil then
          __lux_tmp_295 = 0
        end
        setupParamMatrix(
          material,
          r,
          g,
          b,
          a,
          w,
          h,
          packedStyle,
          mathMax(0, __lux_tmp_295),
          p0,
          p1,
          p2,
          p3,
          sr,
          sg,
          sb,
          sa
        )
      end
      setColor(colorA)
      return true
    end
    setupRoundRectConstants = function(material, w, h, fill, stroke, strokeWidth, radius)
      if material == nil then
        return false
      end
      do
        local __lux_tmp_296 = fill
        if __lux_tmp_296 == nil then
          __lux_tmp_296 = style.solid(color_white)
        end
        fill = __lux_tmp_296
      end
      local colorB
      do
        local __lux_tmp_297 = fill.colorB
        if __lux_tmp_297 == nil then
          local __lux_tmp_298 = fill.colorA
          if __lux_tmp_298 == nil then
            __lux_tmp_298 = color_white
          end
          __lux_tmp_297 = __lux_tmp_298
        end
        colorB = __lux_tmp_297
      end
      local fillKind
      do
        local __lux_tmp_299 = fill.kind
        if __lux_tmp_299 == nil then
          __lux_tmp_299 = style.FILL_SOLID
        end
        fillKind = __lux_tmp_299
      end
      local strokePx
      if stroke ~= nil then
        strokePx = strokeWidth
      else
        strokePx = 0
      end
      local __lux_tmp_300 = strokePx <= 0
      if not __lux_tmp_300 then
        local __lux_tmp_301 = stroke ~= nil
        if __lux_tmp_301 then
          __lux_tmp_301 = stroke.a ~= nil
        end
        local __lux_tmp_302 = __lux_tmp_301
        if __lux_tmp_302 then
          __lux_tmp_302 = stroke.a <= 0
        end
        __lux_tmp_300 = __lux_tmp_302
      end
      if __lux_tmp_300 then
        strokePx = 0
      else
        if strokePx > 255 then
          strokePx = 255
        end
      end
      local r
      do
        local __lux_tmp_303 = colorB.r
        if __lux_tmp_303 == nil then
          __lux_tmp_303 = 0
        end
        r = __lux_tmp_303 * inv255
      end
      local g
      do
        local __lux_tmp_304 = colorB.g
        if __lux_tmp_304 == nil then
          __lux_tmp_304 = 0
        end
        g = __lux_tmp_304 * inv255
      end
      local b
      do
        local __lux_tmp_305 = colorB.b
        if __lux_tmp_305 == nil then
          __lux_tmp_305 = 0
        end
        b = __lux_tmp_305 * inv255
      end
      local a
      do
        local __lux_tmp_306 = colorB.a
        if __lux_tmp_306 == nil then
          __lux_tmp_306 = 255
        end
        a = __lux_tmp_306 * inv255
      end
      local p0, p1, p2, p3 = roundRectFillParams(material, fill)
      local sr = 0
      local sg = 0
      local sb = 0
      local sa = 0
      if strokePx > 0 then
        do
          local __lux_tmp_307 = stroke.r
          if __lux_tmp_307 == nil then
            __lux_tmp_307 = 0
          end
          sr = __lux_tmp_307 * inv255
        end
        do
          local __lux_tmp_308 = stroke.g
          if __lux_tmp_308 == nil then
            __lux_tmp_308 = 0
          end
          sg = __lux_tmp_308 * inv255
        end
        do
          local __lux_tmp_309 = stroke.b
          if __lux_tmp_309 == nil then
            __lux_tmp_309 = 0
          end
          sb = __lux_tmp_309 * inv255
        end
        do
          local __lux_tmp_310 = stroke.a
          if __lux_tmp_310 == nil then
            __lux_tmp_310 = 255
          end
          sa = __lux_tmp_310 * inv255
        end
      end
      setupParamMatrixRaw(
        material,
        r,
        g,
        b,
        a,
        w,
        h,
        strokePx + fillKind * 256,
        radius,
        p0,
        p1,
        p2,
        p3,
        sr,
        sg,
        sb,
        sa
      )
      return true
    end
    setupPatternConstants = function(material, w, h, radius, pattern)
      local color
      do
        local __lux_tmp_311 = pattern.color
        if __lux_tmp_311 == nil then
          __lux_tmp_311 = pattern.tint
        end
        color = style.asColor(__lux_tmp_311, makeColor(255, 255, 255, 24))
      end
      local r, g, b, a = style.color01(color)
      local angle
      do
        local __lux_tmp_312 = toNumber(pattern.angle)
        if __lux_tmp_312 == nil then
          __lux_tmp_312 = 135
        end
        angle = mathRad(__lux_tmp_312)
      end
      local smoke
      local __lux_match_313 = pattern.kind
      if __lux_match_313 == "smoke" then
        smoke = true
      else
        smoke = false
      end
      local pz = 1
      local pw = 1
      local ox = 0
      local oy = 0
      local oz = 0
      local ow = 0
      if smoke then
        do
          local __lux_tmp_314 = toNumber(pattern.scale)
          if __lux_tmp_314 == nil then
            __lux_tmp_314 = 140
          end
          pz = mathMax(1, __lux_tmp_314)
        end
        do
          local __lux_tmp_315 = toNumber(pattern.density)
          if __lux_tmp_315 == nil then
            __lux_tmp_315 = 0.48
          end
          pw = mathClamp(__lux_tmp_315, 0, 1)
        end
        ox = patternOffset(pattern)
        oy = 1
        do
          local __lux_tmp_316 = toNumber(pattern.softness)
          if __lux_tmp_316 == nil then
            __lux_tmp_316 = 0.3
          end
          oz = mathMax(0.001, __lux_tmp_316)
        end
        do
          local __lux_tmp_317 = toNumber(pattern.warp)
          if __lux_tmp_317 == nil then
            __lux_tmp_317 = 0.85
          end
          ow = mathMax(0, __lux_tmp_317)
        end
      else
        do
          local __lux_tmp_318 = toNumber(pattern.spacing)
          if __lux_tmp_318 == nil then
            __lux_tmp_318 = 12
          end
          pz = mathMax(1, __lux_tmp_318)
        end
        do
          local __lux_tmp_319 = toNumber(pattern.width)
          if __lux_tmp_319 == nil then
            __lux_tmp_319 = 2
          end
          pw = mathMax(0.25, __lux_tmp_319)
        end
        ox = patternOffset(pattern)
      end
      local __lux_tmp_320
      if smoke then
        do
          local __lux_tmp_321 = toNumber(pattern.seed)
          if __lux_tmp_321 == nil then
            __lux_tmp_321 = 0
          end
          __lux_tmp_320 = __lux_tmp_321
        end
      else
        __lux_tmp_320 = 0
      end
      local __lux_tmp_322 = toNumber(radius)
      if __lux_tmp_322 == nil then
        __lux_tmp_322 = 0
      end
      return setupParamMatrix(
        material,
        r,
        g,
        b,
        a,
        w,
        h,
        __lux_tmp_320,
        mathMax(0, __lux_tmp_322),
        mathCos(angle),
        mathSin(angle),
        pz,
        pw,
        ox,
        oy,
        oz,
        ow
      )
    end
    drawRoundRectFillPass = function(x, y, w, h, radius, fill)
      local material = roundRectMaterials.roundrect
      if not materialOK(material) then
        return false
      end
      local setupTrace = roundRectTraceStart("round.fillPass.setup")
      setupRoundRectConstants(
        material,
        w,
        h,
        fill,
        nil,
        0,
        roundRectRadiusScalar(radius, w, h)
      )
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      roundRectTraceEnd(setupTrace)
      local drawTrace = roundRectTraceStart("round.fillPass.draw")
      drawTexturedQuad(x, y, w, h, material)
      roundRectTraceEnd(drawTrace)
      return true
    end
    drawSolidRectFast = function(x, y, w, h, fill)
      local color
      do
        local __lux_tmp_323 = fill.colorA
        if __lux_tmp_323 == nil then
          __lux_tmp_323 = color_white
        end
        color = __lux_tmp_323
      end
      do
        local __lux_tmp_324 = color.r
        if __lux_tmp_324 == nil then
          __lux_tmp_324 = 255
        end
        local __lux_tmp_325 = color.g
        if __lux_tmp_325 == nil then
          __lux_tmp_325 = 255
        end
        local __lux_tmp_326 = color.b
        if __lux_tmp_326 == nil then
          __lux_tmp_326 = 255
        end
        local __lux_tmp_327 = color.a
        if __lux_tmp_327 == nil then
          __lux_tmp_327 = 255
        end
        surfaceSetDrawColor(__lux_tmp_324, __lux_tmp_325, __lux_tmp_326, __lux_tmp_327)
      end
      surfaceDrawRect(x, y, w, h)
      recordDraws()
      return true
    end
    drawSolidRoundFast = function(x, y, w, h, radiusValue, fill)
      local material = roundRectMaterials.roundrect_solid
      if not materialOK(material) then
        return false
      end
      local profiling = roundRectProfileActive()
      local setupProfile
      if profiling then
        setupProfile = roundRectProfileStart()
      else
        setupProfile = nil
      end
      local setupTrace = roundRectTraceStart("round.fast.solidRound.setup")
      local color
      do
        local __lux_tmp_328 = fill.colorA
        if __lux_tmp_328 == nil then
          __lux_tmp_328 = color_white
        end
        color = __lux_tmp_328
      end
      do
        local __lux_tmp_329 = color.r
        if __lux_tmp_329 == nil then
          __lux_tmp_329 = 0
        end
        local __lux_tmp_330 = color.g
        if __lux_tmp_330 == nil then
          __lux_tmp_330 = 0
        end
        local __lux_tmp_331 = color.b
        if __lux_tmp_331 == nil then
          __lux_tmp_331 = 0
        end
        local __lux_tmp_332 = color.a
        if __lux_tmp_332 == nil then
          __lux_tmp_332 = 255
        end
        setupParamMatrixRaw(
          material,
          __lux_tmp_329 * inv255,
          __lux_tmp_330 * inv255,
          __lux_tmp_331 * inv255,
          __lux_tmp_332 * inv255,
          w,
          h,
          0,
          radiusValue,
          0,
          0,
          1,
          0,
          0,
          0,
          0,
          0
        )
      end
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      roundRectTraceEnd(setupTrace)
      if profiling then
        roundRectProfileEnd("round.fast.solidRound.setup", setupProfile)
      end
      local drawProfile
      if profiling then
        drawProfile = roundRectProfileStart()
      else
        drawProfile = nil
      end
      local drawTrace = roundRectTraceStart("round.fast.solidRound.draw")
      drawTexturedQuad(x, y, w, h, material)
      roundRectTraceEnd(drawTrace)
      if profiling then
        roundRectProfileEnd("round.fast.solidRound.draw", drawProfile)
      end
      return true
    end
    drawRoundRectPattern = function(x, y, w, h, radius, pattern)
      local spec = patternStyle(pattern)
      local __lux_tmp_333 = spec == nil
      if not __lux_tmp_333 then
        __lux_tmp_333 = not shadersActive()
      end
      local __lux_tmp_334 = __lux_tmp_333
      if not __lux_tmp_334 then
        __lux_tmp_334 = not materialOK(roundRectMaterials.roundrect_pattern)
      end
      if __lux_tmp_334 then
        return false
      end
      local color
      do
        local __lux_tmp_335 = spec.color
        if __lux_tmp_335 == nil then
          __lux_tmp_335 = spec.tint
        end
        color = __lux_tmp_335
      end
      local __lux_tmp_336 = color ~= nil
      if __lux_tmp_336 then
        local __lux_tmp_337 = color.a
        if __lux_tmp_337 == nil then
          __lux_tmp_337 = 255
        end
        __lux_tmp_336 = __lux_tmp_337 <= 0
      end
      if __lux_tmp_336 then
        return false
      end
      local material = roundRectMaterials.roundrect_pattern
      local setupTrace = roundRectTraceStart("round.pattern.setup")
      setupPatternConstants(material, w, h, roundRectRadiusScalar(radius, w, h), spec)
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      roundRectTraceEnd(setupTrace)
      local drawTrace = roundRectTraceStart("round.pattern.draw")
      drawTexturedQuad(x, y, w, h, material)
      roundRectTraceEnd(drawTrace)
      return true
    end
    radiusWithGrow = function(radius, grow)
      do
        local __lux_tmp_338 = toNumber(grow)
        if __lux_tmp_338 == nil then
          __lux_tmp_338 = 0
        end
        grow = mathMax(0, __lux_tmp_338)
      end
      if grow <= 0 then
        return radius
      end
      local __lux_tmp_339 = typeOf(radius) == "table"
      if __lux_tmp_339 then
        __lux_tmp_339 = not style.isColor(radius)
      end
      if __lux_tmp_339 then
        local __lux_tmp_340 = radius.tl
        if __lux_tmp_340 == nil then
          __lux_tmp_340 = radius[1]
        end
        local __lux_tmp_341 = toNumber(__lux_tmp_340)
        if __lux_tmp_341 == nil then
          __lux_tmp_341 = 0
        end
        local __lux_tmp_342 = radius.tr
        if __lux_tmp_342 == nil then
          local __lux_tmp_343 = radius[2]
          if __lux_tmp_343 == nil then
            local __lux_tmp_344 = radius.tl
            if __lux_tmp_344 == nil then
              __lux_tmp_344 = radius[1]
            end
            __lux_tmp_343 = __lux_tmp_344
          end
          __lux_tmp_342 = __lux_tmp_343
        end
        local __lux_tmp_345 = toNumber(__lux_tmp_342)
        if __lux_tmp_345 == nil then
          __lux_tmp_345 = 0
        end
        local __lux_tmp_346 = radius.br
        if __lux_tmp_346 == nil then
          local __lux_tmp_347 = radius[3]
          if __lux_tmp_347 == nil then
            local __lux_tmp_348 = radius.tr
            if __lux_tmp_348 == nil then
              local __lux_tmp_349 = radius[2]
              if __lux_tmp_349 == nil then
                local __lux_tmp_350 = radius.tl
                if __lux_tmp_350 == nil then
                  __lux_tmp_350 = radius[1]
                end
                __lux_tmp_349 = __lux_tmp_350
              end
              __lux_tmp_348 = __lux_tmp_349
            end
            __lux_tmp_347 = __lux_tmp_348
          end
          __lux_tmp_346 = __lux_tmp_347
        end
        local __lux_tmp_351 = toNumber(__lux_tmp_346)
        if __lux_tmp_351 == nil then
          __lux_tmp_351 = 0
        end
        local __lux_tmp_352 = radius.bl
        if __lux_tmp_352 == nil then
          local __lux_tmp_353 = radius[4]
          if __lux_tmp_353 == nil then
            local __lux_tmp_354 = radius.br
            if __lux_tmp_354 == nil then
              local __lux_tmp_355 = radius[3]
              if __lux_tmp_355 == nil then
                local __lux_tmp_356 = radius.tr
                if __lux_tmp_356 == nil then
                  local __lux_tmp_357 = radius[2]
                  if __lux_tmp_357 == nil then
                    local __lux_tmp_358 = radius.tl
                    if __lux_tmp_358 == nil then
                      __lux_tmp_358 = radius[1]
                    end
                    __lux_tmp_357 = __lux_tmp_358
                  end
                  __lux_tmp_356 = __lux_tmp_357
                end
                __lux_tmp_355 = __lux_tmp_356
              end
              __lux_tmp_354 = __lux_tmp_355
            end
            __lux_tmp_353 = __lux_tmp_354
          end
          __lux_tmp_352 = __lux_tmp_353
        end
        local __lux_tmp_359 = toNumber(__lux_tmp_352)
        if __lux_tmp_359 == nil then
          __lux_tmp_359 = 0
        end
        return {
          tl = mathMax(0, __lux_tmp_341) + grow,
          tr = mathMax(0, __lux_tmp_345) + grow,
          br = mathMax(0, __lux_tmp_351) + grow,
          bl = mathMax(0, __lux_tmp_359) + grow,
        }
      end
      local __lux_tmp_360 = toNumber(radius)
      if __lux_tmp_360 == nil then
        __lux_tmp_360 = 0
      end
      return __lux_tmp_360 + grow
    end
    effectExtent = function(spec, defaultWidth)
      if defaultWidth == nil then
        defaultWidth = 18
      end
      return effectExtentFromSpec(spec, defaultWidth)
    end
    drawRoundRectInnerGlowSpec = function(x, y, w, h, radius, spec)
      local __lux_tmp_361 = spec == nil
      if not __lux_tmp_361 then
        __lux_tmp_361 = spec.color == nil
      end
      local __lux_tmp_362 = __lux_tmp_361
      if not __lux_tmp_362 then
        local __lux_tmp_363 = spec.color.a
        if __lux_tmp_363 == nil then
          __lux_tmp_363 = 255
        end
        __lux_tmp_362 = __lux_tmp_363 <= 0
      end
      local __lux_tmp_364 = __lux_tmp_362
      if not __lux_tmp_364 then
        __lux_tmp_364 = not shadersActive()
      end
      local __lux_tmp_365 = __lux_tmp_364
      if not __lux_tmp_365 then
        __lux_tmp_365 = not materialOK(roundRectMaterials.roundrect_innerglow)
      end
      if __lux_tmp_365 then
        return false
      end
      local material = roundRectMaterials.roundrect_innerglow
      local color = spec.color
      local glowWidth
      do
        local __lux_tmp_366 = spec.width
        if __lux_tmp_366 == nil then
          __lux_tmp_366 = 8
        end
        glowWidth = __lux_tmp_366
      end
      local glowStrength
      do
        local __lux_tmp_367 = spec.strength
        if __lux_tmp_367 == nil then
          __lux_tmp_367 = 1
        end
        glowStrength = __lux_tmp_367
      end
      local glowFalloff
      do
        local __lux_tmp_368 = spec.falloff
        if __lux_tmp_368 == nil then
          __lux_tmp_368 = 1.65
        end
        glowFalloff = __lux_tmp_368
      end
      local setupTrace = roundRectTraceStart("round.innerGlow.setup")
      do
        local __lux_tmp_369 = color.r
        if __lux_tmp_369 == nil then
          __lux_tmp_369 = 0
        end
        local __lux_tmp_370 = color.g
        if __lux_tmp_370 == nil then
          __lux_tmp_370 = 0
        end
        local __lux_tmp_371 = color.b
        if __lux_tmp_371 == nil then
          __lux_tmp_371 = 0
        end
        local __lux_tmp_372 = color.a
        if __lux_tmp_372 == nil then
          __lux_tmp_372 = 255
        end
        setupParamMatrixRaw(
          material,
          __lux_tmp_369 * inv255,
          __lux_tmp_370 * inv255,
          __lux_tmp_371 * inv255,
          __lux_tmp_372 * inv255,
          w,
          h,
          0,
          roundRectRadiusScalar(radius, w, h),
          glowWidth,
          glowStrength,
          glowFalloff,
          0,
          0,
          0,
          0,
          0
        )
      end
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      roundRectTraceEnd(setupTrace)
      local drawTrace = roundRectTraceStart("round.innerGlow.draw")
      drawTexturedQuad(x, y, w, h, material)
      roundRectTraceEnd(drawTrace)
      return true
    end
    drawRoundRectShadowOuterSpec = function(x, y, w, h, radius, shadowSpec, outerSpec)
      local __lux_tmp_373 = shadowSpec == nil
      if __lux_tmp_373 then
        __lux_tmp_373 = outerSpec == nil
      end
      local __lux_tmp_374 = __lux_tmp_373
      if not __lux_tmp_374 then
        __lux_tmp_374 = not shadersActive()
      end
      local __lux_tmp_375 = __lux_tmp_374
      if not __lux_tmp_375 then
        __lux_tmp_375 = not materialOK(roundRectMaterials.roundrect_shadow_outer)
      end
      if __lux_tmp_375 then
        return false
      end
      local shadowColor
      do
        local __lux_obj_376 = shadowSpec
        local __lux_val_377 = nil
        if __lux_obj_376 ~= nil then
          __lux_val_377 = __lux_obj_376.color
        end
        shadowColor = __lux_val_377
      end
      local outerColor
      do
        local __lux_obj_378 = outerSpec
        local __lux_val_379 = nil
        if __lux_obj_378 ~= nil then
          __lux_val_379 = __lux_obj_378.color
        end
        outerColor = __lux_val_379
      end
      local hasShadow
      do
        local __lux_tmp_380 = shadowColor ~= nil
        if __lux_tmp_380 then
          local __lux_tmp_381 = shadowColor.a
          if __lux_tmp_381 == nil then
            __lux_tmp_381 = 255
          end
          __lux_tmp_380 = __lux_tmp_381 > 0
        end
        hasShadow = __lux_tmp_380
      end
      local hasOuter
      do
        local __lux_tmp_382 = outerColor ~= nil
        if __lux_tmp_382 then
          local __lux_tmp_383 = outerColor.a
          if __lux_tmp_383 == nil then
            __lux_tmp_383 = 255
          end
          __lux_tmp_382 = __lux_tmp_383 > 0
        end
        hasOuter = __lux_tmp_382
      end
      local __lux_tmp_384 = not hasShadow
      if __lux_tmp_384 then
        __lux_tmp_384 = not hasOuter
      end
      if __lux_tmp_384 then
        return false
      end
      local profiling = roundRectProfileActive()
      local setupProfile
      if profiling then
        setupProfile = roundRectProfileStart()
      else
        setupProfile = nil
      end
      local setupTrace = roundRectTraceStart("round.shadowOuter.setup")
      local shadowSource
      do
        local __lux_tmp_385 = shadowSpec
        if __lux_tmp_385 == nil then
          __lux_tmp_385 = outerSpec
        end
        shadowSource = __lux_tmp_385
      end
      local outerSource
      do
        local __lux_tmp_386 = outerSpec
        if __lux_tmp_386 == nil then
          __lux_tmp_386 = shadowSpec
        end
        outerSource = __lux_tmp_386
      end
      local shadowGrow
      do
        local __lux_tmp_387 = shadowSource.grow
        if __lux_tmp_387 == nil then
          __lux_tmp_387 = 0
        end
        shadowGrow = __lux_tmp_387
      end
      local shadowGw = w + shadowGrow * 2
      local shadowGh = h + shadowGrow * 2
      local shadowSpread
      do
        local __lux_tmp_388 = shadowSource._extent
        if __lux_tmp_388 == nil then
          local __lux_tmp_389 = shadowSource.spread
          if __lux_tmp_389 == nil then
            local __lux_tmp_390 = shadowSource.width
            if __lux_tmp_390 == nil then
              __lux_tmp_390 = 18
            end
            __lux_tmp_389 = __lux_tmp_390
          end
          __lux_tmp_388 = __lux_tmp_389
        end
        shadowSpread = __lux_tmp_388
      end
      local shadowShapeX
      do
        local __lux_tmp_391
        if hasShadow then
          do
            local __lux_tmp_392 = shadowSource.x
            if __lux_tmp_392 == nil then
              __lux_tmp_392 = 0
            end
            __lux_tmp_391 = __lux_tmp_392
          end
        else
          __lux_tmp_391 = 0
        end
        shadowShapeX = x + __lux_tmp_391 - shadowGrow
      end
      local shadowShapeY
      do
        local __lux_tmp_393
        if hasShadow then
          do
            local __lux_tmp_394 = shadowSource.y
            if __lux_tmp_394 == nil then
              __lux_tmp_394 = 0
            end
            __lux_tmp_393 = __lux_tmp_394
          end
        else
          __lux_tmp_393 = 0
        end
        shadowShapeY = y + __lux_tmp_393 - shadowGrow
      end
      local shadowDrawX = shadowShapeX - shadowSpread
      local shadowDrawY = shadowShapeY - shadowSpread
      local shadowDrawW = shadowGw + shadowSpread * 2
      local shadowDrawH = shadowGh + shadowSpread * 2
      local outerGrow
      do
        local __lux_tmp_395 = outerSource.grow
        if __lux_tmp_395 == nil then
          __lux_tmp_395 = 0
        end
        outerGrow = __lux_tmp_395
      end
      local outerGw = w + outerGrow * 2
      local outerGh = h + outerGrow * 2
      local outerSpread
      do
        local __lux_tmp_396 = outerSource._extent
        if __lux_tmp_396 == nil then
          local __lux_tmp_397 = outerSource.spread
          if __lux_tmp_397 == nil then
            local __lux_tmp_398 = outerSource.width
            if __lux_tmp_398 == nil then
              __lux_tmp_398 = 18
            end
            __lux_tmp_397 = __lux_tmp_398
          end
          __lux_tmp_396 = __lux_tmp_397
        end
        outerSpread = __lux_tmp_396
      end
      local outerOx
      if hasOuter then
        do
          local __lux_tmp_399 = outerSource.x
          if __lux_tmp_399 == nil then
            __lux_tmp_399 = 0
          end
          outerOx = __lux_tmp_399
        end
      else
        outerOx = 0
      end
      local outerOy
      if hasOuter then
        do
          local __lux_tmp_400 = outerSource.y
          if __lux_tmp_400 == nil then
            __lux_tmp_400 = 0
          end
          outerOy = __lux_tmp_400
        end
      else
        outerOy = 0
      end
      local outerLeft, outerTop, outerRight, outerBottom = glowBiasPads(outerSpread, outerOx, outerOy)
      local outerShapeX = x - outerGrow
      local outerShapeY = y - outerGrow
      local outerDrawX = outerShapeX - outerLeft
      local outerDrawY = outerShapeY - outerTop
      local outerDrawW = outerGw + outerLeft + outerRight
      local outerDrawH = outerGh + outerTop + outerBottom
      local sx = mathMin(shadowDrawX, outerDrawX)
      local sy = mathMin(shadowDrawY, outerDrawY)
      local ex = mathMax(shadowDrawX + shadowDrawW, outerDrawX + outerDrawW)
      local ey = mathMax(shadowDrawY + shadowDrawH, outerDrawY + outerDrawH)
      local sw = ex - sx
      local sh = ey - sy
      local material = roundRectMaterials.roundrect_shadow_outer
      do
        local __lux_tmp_401
        if hasShadow then
          do
            local __lux_tmp_402 = shadowColor.r
            if __lux_tmp_402 == nil then
              __lux_tmp_402 = 0
            end
            __lux_tmp_401 = __lux_tmp_402 * inv255
          end
        else
          __lux_tmp_401 = 0
        end
        local __lux_tmp_403
        if hasShadow then
          do
            local __lux_tmp_404 = shadowColor.g
            if __lux_tmp_404 == nil then
              __lux_tmp_404 = 0
            end
            __lux_tmp_403 = __lux_tmp_404 * inv255
          end
        else
          __lux_tmp_403 = 0
        end
        local __lux_tmp_405
        if hasShadow then
          do
            local __lux_tmp_406 = shadowColor.b
            if __lux_tmp_406 == nil then
              __lux_tmp_406 = 0
            end
            __lux_tmp_405 = __lux_tmp_406 * inv255
          end
        else
          __lux_tmp_405 = 0
        end
        local __lux_tmp_407
        if hasShadow then
          do
            local __lux_tmp_408 = shadowColor.a
            if __lux_tmp_408 == nil then
              __lux_tmp_408 = 255
            end
            __lux_tmp_407 = __lux_tmp_408 * inv255
          end
        else
          __lux_tmp_407 = 0
        end
        local __lux_tmp_409
        if hasShadow then
          do
            local __lux_tmp_410 = shadowSource.width
            if __lux_tmp_410 == nil then
              __lux_tmp_410 = 18
            end
            __lux_tmp_409 = __lux_tmp_410
          end
        else
          __lux_tmp_409 = 1
        end
        local __lux_tmp_411
        if hasShadow then
          do
            local __lux_tmp_412 = shadowSource.strength
            if __lux_tmp_412 == nil then
              __lux_tmp_412 = 1
            end
            __lux_tmp_411 = __lux_tmp_412
          end
        else
          __lux_tmp_411 = 0
        end
        local __lux_tmp_413
        if hasShadow then
          do
            local __lux_tmp_414 = shadowSource.falloff
            if __lux_tmp_414 == nil then
              __lux_tmp_414 = 1.9
            end
            __lux_tmp_413 = __lux_tmp_414
          end
        else
          __lux_tmp_413 = 1
        end
        setupParamMatrixRaw(
          material,
          sw,
          sh,
          0,
          0,
          __lux_tmp_401,
          __lux_tmp_403,
          __lux_tmp_405,
          __lux_tmp_407,
          shadowShapeX - sx,
          shadowShapeY - sy,
          shadowGw,
          shadowGh,
          roundRectRadiusScalar(radiusWithGrow(radius, shadowGrow), shadowGw, shadowGh),
          __lux_tmp_409,
          __lux_tmp_411,
          __lux_tmp_413
        )
      end
      do
        local __lux_tmp_415
        if hasOuter then
          do
            local __lux_tmp_416 = outerColor.r
            if __lux_tmp_416 == nil then
              __lux_tmp_416 = 0
            end
            __lux_tmp_415 = __lux_tmp_416 * inv255
          end
        else
          __lux_tmp_415 = 0
        end
        local __lux_tmp_417
        if hasOuter then
          do
            local __lux_tmp_418 = outerColor.g
            if __lux_tmp_418 == nil then
              __lux_tmp_418 = 0
            end
            __lux_tmp_417 = __lux_tmp_418 * inv255
          end
        else
          __lux_tmp_417 = 0
        end
        local __lux_tmp_419
        if hasOuter then
          do
            local __lux_tmp_420 = outerColor.b
            if __lux_tmp_420 == nil then
              __lux_tmp_420 = 0
            end
            __lux_tmp_419 = __lux_tmp_420 * inv255
          end
        else
          __lux_tmp_419 = 0
        end
        local __lux_tmp_421
        if hasOuter then
          do
            local __lux_tmp_422 = outerColor.a
            if __lux_tmp_422 == nil then
              __lux_tmp_422 = 255
            end
            __lux_tmp_421 = __lux_tmp_422 * inv255
          end
        else
          __lux_tmp_421 = 0
        end
        local __lux_tmp_423
        if hasOuter then
          do
            local __lux_tmp_424 = outerSource.width
            if __lux_tmp_424 == nil then
              __lux_tmp_424 = 18
            end
            __lux_tmp_423 = __lux_tmp_424
          end
        else
          __lux_tmp_423 = 1
        end
        local __lux_tmp_425
        if hasOuter then
          do
            local __lux_tmp_426 = outerSource.strength
            if __lux_tmp_426 == nil then
              __lux_tmp_426 = 1
            end
            __lux_tmp_425 = __lux_tmp_426
          end
        else
          __lux_tmp_425 = 0
        end
        local __lux_tmp_427
        if hasOuter then
          do
            local __lux_tmp_428 = outerSource.falloff
            if __lux_tmp_428 == nil then
              __lux_tmp_428 = 1.9
            end
            __lux_tmp_427 = __lux_tmp_428
          end
        else
          __lux_tmp_427 = 1
        end
        setupAuxConstantsRaw(
          material,
          __lux_tmp_415,
          __lux_tmp_417,
          __lux_tmp_419,
          __lux_tmp_421,
          outerShapeX - sx,
          outerShapeY - sy,
          outerGw,
          outerGh,
          roundRectRadiusScalar(radiusWithGrow(radius, outerGrow), outerGw, outerGh),
          __lux_tmp_423,
          __lux_tmp_425,
          __lux_tmp_427,
          0,
          0,
          0,
          0
        )
      end
      roundRectTraceEnd(setupTrace)
      if profiling then
        roundRectProfileEnd("round.shadowOuter.setup", setupProfile)
      end
      local bleedProfile
      if profiling then
        bleedProfile = roundRectProfileStart()
      else
        bleedProfile = nil
      end
      local bleedTrace = roundRectTraceStart("round.shadowOuter.bleedBegin")
      local bleedToken = beginPanelEffectDraw(sx, sy, sw, sh)
      roundRectTraceEnd(bleedTrace)
      if profiling then
        roundRectProfileEnd("round.shadowOuter.bleedBegin", bleedProfile)
      end
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      local drawProfile
      if profiling then
        drawProfile = roundRectProfileStart()
      else
        drawProfile = nil
      end
      local drawTrace = roundRectTraceStart("round.shadowOuter.draw")
      drawTexturedQuad(sx, sy, sw, sh, material)
      roundRectTraceEnd(drawTrace)
      if profiling then
        roundRectProfileEnd("round.shadowOuter.draw", drawProfile)
      end
      do
        local __lux_tmp_429
        if profiling then
          __lux_tmp_429 = roundRectProfileStart()
        else
          __lux_tmp_429 = nil
        end
        bleedProfile = __lux_tmp_429
      end
      bleedTrace = roundRectTraceStart("round.shadowOuter.bleedEnd")
      endPanelEffectBleed(bleedToken)
      roundRectTraceEnd(bleedTrace)
      if profiling then
        roundRectProfileEnd("round.shadowOuter.bleedEnd", bleedProfile)
      end
      return true
    end
    effectColorPacked = function(spec)
      local __lux_tmp_430 = spec == nil
      if not __lux_tmp_430 then
        __lux_tmp_430 = spec.color == nil
      end
      if __lux_tmp_430 then
        return 0, 0, 0, 0
      end
      local color = spec.color
      local alpha
      do
        local __lux_tmp_431 = color.a
        if __lux_tmp_431 == nil then
          __lux_tmp_431 = 255
        end
        alpha = __lux_tmp_431 * inv255
      end
      if alpha <= 0 then
        return 0, 0, 0, 0
      end
      local strength
      do
        local __lux_tmp_432 = toNumber(spec.strength)
        if __lux_tmp_432 == nil then
          __lux_tmp_432 = 1
        end
        strength = mathMax(0, __lux_tmp_432)
      end
      if strength <= 0 then
        return 0, 0, 0, 0
      end
      local __lux_tmp_433 = color.r
      if __lux_tmp_433 == nil then
        __lux_tmp_433 = 0
      end
      local __lux_tmp_434 = color.g
      if __lux_tmp_434 == nil then
        __lux_tmp_434 = 0
      end
      local __lux_tmp_435 = color.b
      if __lux_tmp_435 == nil then
        __lux_tmp_435 = 0
      end
      return __lux_tmp_433 * inv255, __lux_tmp_434 * inv255, __lux_tmp_435 * inv255, alpha * strength
    end
    drawRoundRectFusedSpec = function(x, y, w, h, radius, fill, stroke, strokeWidth, shadowSpec, outerSpec, radiusValue)
      local __lux_tmp_436 = w <= 0
      if not __lux_tmp_436 then
        __lux_tmp_436 = h <= 0
      end
      if __lux_tmp_436 then
        return false
      end
      local __lux_tmp_437 = shadowSpec == nil
      if __lux_tmp_437 then
        __lux_tmp_437 = outerSpec == nil
      end
      local __lux_tmp_438 = __lux_tmp_437
      if not __lux_tmp_438 then
        __lux_tmp_438 = not materialOK(roundRectMaterials.roundrect_fused)
      end
      if __lux_tmp_438 then
        return false
      end
      local shadowColor
      do
        local __lux_obj_439 = shadowSpec
        local __lux_val_440 = nil
        if __lux_obj_439 ~= nil then
          __lux_val_440 = __lux_obj_439.color
        end
        shadowColor = __lux_val_440
      end
      local outerColor
      do
        local __lux_obj_441 = outerSpec
        local __lux_val_442 = nil
        if __lux_obj_441 ~= nil then
          __lux_val_442 = __lux_obj_441.color
        end
        outerColor = __lux_val_442
      end
      local hasShadow
      do
        local __lux_tmp_443 = shadowColor ~= nil
        if __lux_tmp_443 then
          local __lux_tmp_444 = shadowColor.a
          if __lux_tmp_444 == nil then
            __lux_tmp_444 = 255
          end
          __lux_tmp_443 = __lux_tmp_444 > 0
        end
        local __lux_tmp_445 = __lux_tmp_443
        if __lux_tmp_445 then
          local __lux_tmp_446 = shadowSpec.strength
          if __lux_tmp_446 == nil then
            __lux_tmp_446 = 1
          end
          __lux_tmp_445 = __lux_tmp_446 > 0
        end
        hasShadow = __lux_tmp_445
      end
      local hasOuter
      do
        local __lux_tmp_447 = outerColor ~= nil
        if __lux_tmp_447 then
          local __lux_tmp_448 = outerColor.a
          if __lux_tmp_448 == nil then
            __lux_tmp_448 = 255
          end
          __lux_tmp_447 = __lux_tmp_448 > 0
        end
        local __lux_tmp_449 = __lux_tmp_447
        if __lux_tmp_449 then
          local __lux_tmp_450 = outerSpec.strength
          if __lux_tmp_450 == nil then
            __lux_tmp_450 = 1
          end
          __lux_tmp_449 = __lux_tmp_450 > 0
        end
        hasOuter = __lux_tmp_449
      end
      local __lux_tmp_451 = not hasShadow
      if __lux_tmp_451 then
        __lux_tmp_451 = not hasOuter
      end
      if __lux_tmp_451 then
        return false
      end
      local profiling = roundRectProfileActive()
      local setupProfile
      if profiling then
        setupProfile = roundRectProfileStart()
      else
        setupProfile = nil
      end
      local setupTrace = roundRectTraceStart("round.fused.setup")
      local sx = x
      local sy = y
      local ex = x + w
      local ey = y + h
      local shadowGrow = 0
      local shadowWidth = 1
      local shadowFalloff = 1
      local shadowX = 0
      local shadowY = 0
      if hasShadow then
        do
          local __lux_tmp_452 = shadowSpec.grow
          if __lux_tmp_452 == nil then
            __lux_tmp_452 = 0
          end
          shadowGrow = __lux_tmp_452
        end
        do
          local __lux_tmp_453 = shadowSpec.width
          if __lux_tmp_453 == nil then
            __lux_tmp_453 = 18
          end
          shadowWidth = __lux_tmp_453
        end
        do
          local __lux_tmp_454 = shadowSpec.falloff
          if __lux_tmp_454 == nil then
            __lux_tmp_454 = 1.9
          end
          shadowFalloff = __lux_tmp_454
        end
        do
          local __lux_tmp_455 = shadowSpec.x
          if __lux_tmp_455 == nil then
            __lux_tmp_455 = 0
          end
          shadowX = __lux_tmp_455
        end
        do
          local __lux_tmp_456 = shadowSpec.y
          if __lux_tmp_456 == nil then
            __lux_tmp_456 = 0
          end
          shadowY = __lux_tmp_456
        end
        local spread
        do
          local __lux_tmp_457 = shadowSpec._extent
          if __lux_tmp_457 == nil then
            local __lux_tmp_458 = shadowSpec.spread
            if __lux_tmp_458 == nil then
              __lux_tmp_458 = shadowWidth
            end
            __lux_tmp_457 = __lux_tmp_458
          end
          spread = __lux_tmp_457
        end
        local drawX = x + shadowX - shadowGrow - spread
        local drawY = y + shadowY - shadowGrow - spread
        local drawW = w + shadowGrow * 2 + spread * 2
        local drawH = h + shadowGrow * 2 + spread * 2
        sx = mathMin(sx, drawX)
        sy = mathMin(sy, drawY)
        ex = mathMax(ex, drawX + drawW)
        ey = mathMax(ey, drawY + drawH)
      end
      local outerGrow = 0
      local outerWidth = 1
      local outerFalloff = 1
      if hasOuter then
        do
          local __lux_tmp_459 = outerSpec.grow
          if __lux_tmp_459 == nil then
            __lux_tmp_459 = 0
          end
          outerGrow = __lux_tmp_459
        end
        do
          local __lux_tmp_460 = outerSpec.width
          if __lux_tmp_460 == nil then
            __lux_tmp_460 = 18
          end
          outerWidth = __lux_tmp_460
        end
        do
          local __lux_tmp_461 = outerSpec.falloff
          if __lux_tmp_461 == nil then
            __lux_tmp_461 = 1.9
          end
          outerFalloff = __lux_tmp_461
        end
        local spread
        do
          local __lux_tmp_462 = outerSpec._extent
          if __lux_tmp_462 == nil then
            local __lux_tmp_463 = outerSpec.spread
            if __lux_tmp_463 == nil then
              __lux_tmp_463 = outerWidth
            end
            __lux_tmp_462 = __lux_tmp_463
          end
          spread = __lux_tmp_462
        end
        local left, top, right, bottom
        do
          local __lux_tmp_464 = outerSpec.x
          if __lux_tmp_464 == nil then
            __lux_tmp_464 = 0
          end
          local __lux_tmp_465 = outerSpec.y
          if __lux_tmp_465 == nil then
            __lux_tmp_465 = 0
          end
          left, top, right, bottom = glowBiasPads(spread, __lux_tmp_464, __lux_tmp_465)
        end
        local drawX = x - outerGrow - left
        local drawY = y - outerGrow - top
        local drawW = w + outerGrow * 2 + left + right
        local drawH = h + outerGrow * 2 + top + bottom
        sx = mathMin(sx, drawX)
        sy = mathMin(sy, drawY)
        ex = mathMax(ex, drawX + drawW)
        ey = mathMax(ey, drawY + drawH)
      end
      local sw = ex - sx
      local sh = ey - sy
      local __lux_tmp_466 = sw <= 0
      if not __lux_tmp_466 then
        __lux_tmp_466 = sh <= 0
      end
      if __lux_tmp_466 then
        roundRectTraceEnd(setupTrace)
        if profiling then
          roundRectProfileEnd("round.fused.setup", setupProfile)
        end
        return false
      end
      local material = roundRectMaterials.roundrect_fused
      do
        local __lux_tmp_467 = radiusValue
        if __lux_tmp_467 == nil then
          __lux_tmp_467 = roundRectRadiusScalar(radius, w, h)
        end
        setupRoundRectConstants(material, w, h, fill, stroke, strokeWidth, __lux_tmp_467)
      end
      local shadowPacked
      if hasShadow then
        shadowPacked = shadowSpec
      else
        shadowPacked = nil
      end
      local outerPacked
      if hasOuter then
        outerPacked = outerSpec
      else
        outerPacked = nil
      end
      local sr, sg, sb, sa = effectColorPacked(shadowPacked)
      local orr, og, ob, oa = effectColorPacked(outerPacked)
      setupAuxConstantsRaw(
        material,
        sr,
        sg,
        sb,
        sa,
        shadowX,
        shadowY,
        shadowGrow,
        shadowWidth,
        orr,
        og,
        ob,
        oa,
        shadowFalloff,
        outerGrow,
        outerWidth,
        outerFalloff
      )
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      roundRectTraceEnd(setupTrace)
      if profiling then
        roundRectProfileEnd("round.fused.setup", setupProfile)
      end
      local bleedProfile
      if profiling then
        bleedProfile = roundRectProfileStart()
      else
        bleedProfile = nil
      end
      local bleedTrace = roundRectTraceStart("round.fused.bleedBegin")
      local bleedToken = beginPanelEffectDraw(sx, sy, sw, sh)
      roundRectTraceEnd(bleedTrace)
      if profiling then
        roundRectProfileEnd("round.fused.bleedBegin", bleedProfile)
      end
      local u0 = (sx - x) / w
      local v0 = (sy - y) / h
      local u1 = (ex - x) / w
      local v1 = (ey - y) / h
      local drawProfile
      if profiling then
        drawProfile = roundRectProfileStart()
      else
        drawProfile = nil
      end
      local drawTrace = roundRectTraceStart("round.fused.draw")
      drawTexturedQuadUV(sx, sy, sw, sh, u0, v0, u1, v1, material)
      roundRectTraceEnd(drawTrace)
      if profiling then
        roundRectProfileEnd("round.fused.draw", drawProfile)
      end
      do
        local __lux_tmp_468
        if profiling then
          __lux_tmp_468 = roundRectProfileStart()
        else
          __lux_tmp_468 = nil
        end
        bleedProfile = __lux_tmp_468
      end
      bleedTrace = roundRectTraceStart("round.fused.bleedEnd")
      endPanelEffectBleed(bleedToken)
      roundRectTraceEnd(bleedTrace)
      if profiling then
        roundRectProfileEnd("round.fused.bleedEnd", bleedProfile)
      end
      return true
    end
    backdropTintColor = function(spec)
      local __lux_tmp_469 = spec == nil
      if not __lux_tmp_469 then
        __lux_tmp_469 = spec.tint == nil
      end
      if __lux_tmp_469 then
        return nil
      end
      local tint = spec.tint
      local alpha
      do
        local __lux_tmp_470 = tint.a
        if __lux_tmp_470 == nil then
          __lux_tmp_470 = 255
        end
        local __lux_tmp_471 = spec.opacity
        if __lux_tmp_471 == nil then
          __lux_tmp_471 = 1
        end
        alpha = __lux_tmp_470 * __lux_tmp_471
      end
      if alpha <= 0 then
        return nil
      end
      do
        local __lux_tmp_472 = tint.r
        if __lux_tmp_472 == nil then
          __lux_tmp_472 = 0
        end
        backdropTintScratch.r = __lux_tmp_472
      end
      do
        local __lux_tmp_473 = tint.g
        if __lux_tmp_473 == nil then
          __lux_tmp_473 = 0
        end
        backdropTintScratch.g = __lux_tmp_473
      end
      do
        local __lux_tmp_474 = tint.b
        if __lux_tmp_474 == nil then
          __lux_tmp_474 = 0
        end
        backdropTintScratch.b = __lux_tmp_474
      end
      backdropTintScratch.a = mathFloor(mathClamp(alpha, 0, 255) + 0.5)
      return backdropTintScratch
    end
    drawRoundRectBackdrop = function(x, y, w, h, radius, spec)
      if spec == nil then
        return nil
      end
      local trace = roundRectTraceStart("round.backdrop.pass")
      local pad
      do
        local __lux_tmp_475 = toNumber(spec.padding)
        if __lux_tmp_475 == nil then
          __lux_tmp_475 = 0
        end
        pad = mathMax(0, __lux_tmp_475)
      end
      local bx = x - pad
      local by = y - pad
      local bw = w + pad * 2
      local bh = h + pad * 2
      local br = radiusWithGrow(radius, pad)
      local tint = backdropTintColor(spec)
      local blurred = false
      local __lux_tmp_476 = spec.blur > 0
      if __lux_tmp_476 then
        __lux_tmp_476 = roundRectBlurRT ~= nil
      end
      local __lux_tmp_477 = __lux_tmp_476
      if __lux_tmp_477 then
        __lux_tmp_477 = renderCopyRenderTargetToTexture ~= nil
      end
      local __lux_tmp_478 = __lux_tmp_477
      if __lux_tmp_478 then
        __lux_tmp_478 = materialOK(roundRectMaterials.roundrect_blur)
      end
      if __lux_tmp_478 then
        local blurTrace = roundRectTraceStart("round.backdrop.blur")
        local material = roundRectMaterials.roundrect_blur
        local intensity = blurIntensity(spec.blur)
        surfaceSetMaterial(material)
        surfaceSetDrawColor(255, 255, 255, 255)
        setupAuxConstantsRaw(material, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        renderCopyRenderTargetToTexture(roundRectBlurRT)
        setupParamMatrix(
          material,
          0,
          intensity,
          0,
          0,
          bw,
          bh,
          0,
          roundRectRadiusScalar(br, bw, bh),
          0,
          0,
          1,
          1,
          0,
          0,
          0,
          0
        )
        drawTexturedQuad(bx, by, bw, bh, material)
        if tint ~= nil then
          do
            local __lux_tmp_479 = tint.r
            if __lux_tmp_479 == nil then
              __lux_tmp_479 = 0
            end
            local __lux_tmp_480 = tint.g
            if __lux_tmp_480 == nil then
              __lux_tmp_480 = 0
            end
            local __lux_tmp_481 = tint.b
            if __lux_tmp_481 == nil then
              __lux_tmp_481 = 0
            end
            local __lux_tmp_482 = tint.a
            if __lux_tmp_482 == nil then
              __lux_tmp_482 = 255
            end
            setupAuxConstantsRaw(
              material,
              __lux_tmp_479 * inv255,
              __lux_tmp_480 * inv255,
              __lux_tmp_481 * inv255,
              __lux_tmp_482 * inv255,
              1,
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
          end
        else
          setupAuxConstantsRaw(material, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        end
        renderCopyRenderTargetToTexture(roundRectBlurRT)
        setupParamMatrix(
          material,
          1,
          intensity,
          0,
          0,
          bw,
          bh,
          0,
          roundRectRadiusScalar(br, bw, bh),
          0,
          0,
          1,
          1,
          0,
          0,
          0,
          0
        )
        drawTexturedQuad(bx, by, bw, bh, material)
        roundRectTraceEnd(blurTrace)
        blurred = true
      end
      local __lux_tmp_483 = tint ~= nil
      if __lux_tmp_483 then
        __lux_tmp_483 = not blurred
      end
      if __lux_tmp_483 then
        local tintTrace = roundRectTraceStart("round.backdrop.tint")
        backdropFillScratch._mgfxFillVisible = true
        drawRoundRectFillPass(bx, by, bw, bh, br, backdropFillScratch)
        roundRectTraceEnd(tintTrace)
      end
      roundRectTraceEnd(trace)
      return spec
    end
    drawRoundRectStrokePass = function(x, y, w, h, radius, stroke, strokeWidth)
      if not style.strokeVisible(stroke, strokeWidth) then
        return false
      end
      if materialOK(roundRectMaterials.roundrect_stroke) then
        local material = roundRectMaterials.roundrect_stroke
        local r, g, b, a = style.color01(stroke)
        local setupTrace = roundRectTraceStart("round.strokePass.setup")
        setupParamMatrix(
          material,
          r,
          g,
          b,
          a,
          w,
          h,
          mathMax(0, style.strokeWidth(strokeWidth, 0)),
          roundRectRadiusScalar(radius, w, h),
          0,
          0,
          1,
          0,
          0,
          0,
          0,
          0
        )
        surfaceSetMaterial(material)
        surfaceSetDrawColor(255, 255, 255, 255)
        roundRectTraceEnd(setupTrace)
        local drawTrace = roundRectTraceStart("round.strokePass.draw")
        drawTexturedQuad(x, y, w, h, material)
        roundRectTraceEnd(drawTrace)
        return true
      end
      local material = roundRectMaterials.roundrect
      if not materialOK(material) then
        return false
      end
      local setupTrace = roundRectTraceStart("round.strokePass.setup")
      setupRoundRectConstants(
        material,
        w,
        h,
        transparentFill,
        stroke,
        strokeWidth,
        roundRectRadiusScalar(radius, w, h)
      )
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      roundRectTraceEnd(setupTrace)
      local drawTrace = roundRectTraceStart("round.strokePass.draw")
      drawTexturedQuad(x, y, w, h, material)
      roundRectTraceEnd(drawTrace)
      return true
    end
    drawRoundRectFxPass = function(x, y, w, h, radius, fill, stroke, strokeWidth, innerSpec)
      if not materialOK(roundRectMaterials.roundrect_fx) then
        return false
      end
      local profiling = roundRectProfileActive()
      local setupProfile
      if profiling then
        setupProfile = roundRectProfileStart()
      else
        setupProfile = nil
      end
      local setupTrace = roundRectTraceStart("round.base.fx.setup")
      local material = roundRectMaterials.roundrect_fx
      local gr = 0
      local gg = 0
      local gb = 0
      local ga = 0
      local glowWidth = 0
      local glowStrength = 0
      local glowFalloff = 1
      if innerSpec ~= nil then
        local color
        do
          local __lux_tmp_484 = innerSpec.color
          if __lux_tmp_484 == nil then
            __lux_tmp_484 = transparentColor
          end
          color = __lux_tmp_484
        end
        do
          local __lux_tmp_485 = color.r
          if __lux_tmp_485 == nil then
            __lux_tmp_485 = 0
          end
          gr = __lux_tmp_485 * inv255
        end
        do
          local __lux_tmp_486 = color.g
          if __lux_tmp_486 == nil then
            __lux_tmp_486 = 0
          end
          gg = __lux_tmp_486 * inv255
        end
        do
          local __lux_tmp_487 = color.b
          if __lux_tmp_487 == nil then
            __lux_tmp_487 = 0
          end
          gb = __lux_tmp_487 * inv255
        end
        do
          local __lux_tmp_488 = color.a
          if __lux_tmp_488 == nil then
            __lux_tmp_488 = 255
          end
          ga = __lux_tmp_488 * inv255
        end
        do
          local __lux_tmp_489 = toNumber(innerSpec.width)
          if __lux_tmp_489 == nil then
            __lux_tmp_489 = 8
          end
          glowWidth = mathMax(0.001, __lux_tmp_489)
        end
        do
          local __lux_tmp_490 = toNumber(innerSpec.strength)
          if __lux_tmp_490 == nil then
            __lux_tmp_490 = 1
          end
          glowStrength = mathMax(0, __lux_tmp_490)
        end
        do
          local __lux_tmp_491 = toNumber(innerSpec.falloff)
          if __lux_tmp_491 == nil then
            __lux_tmp_491 = 1.65
          end
          glowFalloff = mathMax(0.001, __lux_tmp_491)
        end
      end
      if not setupAuxConstantsRaw(
        material,
        gr,
        gg,
        gb,
        ga,
        glowWidth,
        glowStrength,
        glowFalloff,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0
      ) then
        roundRectTraceEnd(setupTrace)
        if profiling then
          roundRectProfileEnd("round.base.fx.setup", setupProfile)
        end
        return false
      end
      setupRoundRectConstants(
        material,
        w,
        h,
        fill,
        stroke,
        strokeWidth,
        roundRectRadiusScalar(radius, w, h)
      )
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      roundRectTraceEnd(setupTrace)
      if profiling then
        roundRectProfileEnd("round.base.fx.setup", setupProfile)
      end
      local drawProfile
      if profiling then
        drawProfile = roundRectProfileStart()
      else
        drawProfile = nil
      end
      local drawTrace = roundRectTraceStart("round.base.fx.draw")
      drawTexturedQuad(x, y, w, h, material)
      roundRectTraceEnd(drawTrace)
      if profiling then
        roundRectProfileEnd("round.base.fx.draw", drawProfile)
      end
      return true
    end
  end
  do
    drawRoundRectImmediate = function(x, y, w, h, drawStyle)
      local profiling = roundRectProfileActive()
      local trace = roundRectTraceStart("round.immediate")
      local totalProfile
      if profiling then
        totalProfile = roundRectProfileStart()
      else
        totalProfile = nil
      end
      local stageProfile = totalProfile
      local styleValue
      do
        local __lux_tmp_492 = drawStyle
        if __lux_tmp_492 == nil then
          __lux_tmp_492 = emptyRoundRectStyle
        end
        styleValue = __lux_tmp_492
      end
      local initTrace = roundRectTraceStart("round.init")
      local shaderReady = shadersActive()
      local transformActive = hasTransform()
      local radius
      do
        local __lux_tmp_493 = styleValue.radius
        if __lux_tmp_493 == nil then
          local __lux_tmp_494 = styleValue.r
          if __lux_tmp_494 == nil then
            __lux_tmp_494 = 0
          end
          __lux_tmp_493 = __lux_tmp_494
        end
        radius = __lux_tmp_493
      end
      local strokeValue = styleValue.stroke
      local strokeWidth = 0
      local hasStroke = false
      if strokeValue ~= nil then
        strokeWidth = style.strokeWidth(styleValue.strokeWidth, 0)
        do
          local __lux_tmp_495 = strokeWidth > 0
          if __lux_tmp_495 then
            local __lux_tmp_496 = strokeValue.a == nil
            if not __lux_tmp_496 then
              __lux_tmp_496 = strokeValue.a > 0
            end
            __lux_tmp_495 = __lux_tmp_496
          end
          hasStroke = __lux_tmp_495
        end
      end
      roundRectTraceEnd(initTrace)
      local noEffects
      do
        local __lux_tmp_497 = styleValue.shadow == nil
        if __lux_tmp_497 then
          __lux_tmp_497 = styleValue.outerGlow == nil
        end
        local __lux_tmp_498 = __lux_tmp_497
        if __lux_tmp_498 then
          __lux_tmp_498 = styleValue.innerGlow == nil
        end
        local __lux_tmp_499 = __lux_tmp_498
        if __lux_tmp_499 then
          __lux_tmp_499 = styleValue.backdrop == nil
        end
        local __lux_tmp_500 = __lux_tmp_499
        if __lux_tmp_500 then
          __lux_tmp_500 = styleValue.pattern == nil
        end
        noEffects = __lux_tmp_500
      end
      local __lux_tmp_501 = noEffects
      if __lux_tmp_501 then
        __lux_tmp_501 = not hasStroke
      end
      local __lux_tmp_502 = __lux_tmp_501
      if __lux_tmp_502 then
        __lux_tmp_502 = not transformActive
      end
      if __lux_tmp_502 then
        local fastPrepareTrace = roundRectTraceStart("round.fast.prepare")
        local fill
        do
          local __lux_tmp_503 = styleValue.fill
          if __lux_tmp_503 == nil then
            __lux_tmp_503 = styleValue.color
          end
          fill = hotFillFromStyle(__lux_tmp_503)
        end
        local hasFill = style.fillVisible(fill)
        local __lux_tmp_504 = hasFill
        if __lux_tmp_504 then
          __lux_tmp_504 = fill.kind == style.FILL_SOLID
        end
        if __lux_tmp_504 then
          local radiusValue = roundRectRadiusScalar(radius, w, h)
          roundRectTraceEnd(fastPrepareTrace)
          if profiling then
            local now = sysTime()
            roundRectProfileRecord("round.prepare", (now - stageProfile) * 1000)
            stageProfile = now
          end
          local cullTrace = roundRectTraceStart("round.cull")
          if frame.isCulled(x, y, w, h) then
            roundRectTraceEnd(cullTrace)
            if profiling then
              roundRectProfileRecord("round.cull", (sysTime() - stageProfile) * 1000)
            end
            finishImmediateTrace(trace, profiling, totalProfile)
            return
          end
          roundRectTraceEnd(cullTrace)
          if profiling then
            local now = sysTime()
            roundRectProfileRecord("round.cull", (now - stageProfile) * 1000)
            stageProfile = now
          end
          if radiusValue <= 0 then
            local drawProfile
            if profiling then
              drawProfile = roundRectProfileStart()
            else
              drawProfile = nil
            end
            local drawTrace = roundRectTraceStart("round.fast.solidRect")
            drawSolidRectFast(x, y, w, h, fill)
            roundRectTraceEnd(drawTrace)
            if profiling then
              roundRectProfileEnd("round.fast.solidRect", drawProfile)
            end
            finishImmediateTrace(trace, profiling, totalProfile)
            return
          end
          local drawProfile
          if profiling then
            drawProfile = roundRectProfileStart()
          else
            drawProfile = nil
          end
          local fastTrace = roundRectTraceStart("round.fast.solidRound")
          local __lux_tmp_505 = shaderReady
          if __lux_tmp_505 then
            __lux_tmp_505 = drawSolidRoundFast(x, y, w, h, radiusValue, fill)
          end
          if __lux_tmp_505 then
            roundRectTraceEnd(fastTrace)
            if profiling then
              roundRectProfileEnd("round.fast.solidRound", drawProfile)
            end
            finishImmediateTrace(trace, profiling, totalProfile)
            return
          end
          roundRectTraceEnd(fastTrace)
          if profiling then
            roundRectProfileEnd("round.fast.solidRound.miss", drawProfile)
          end
        else
          roundRectTraceEnd(fastPrepareTrace)
        end
      end
      local effectTrace = roundRectTraceStart("round.normalizeEffects")
      local shadowTrace = roundRectTraceStart("style.shadow")
      local shadowSpec = shadowStyle(styleValue.shadow)
      roundRectTraceEnd(shadowTrace)
      local outerTrace = roundRectTraceStart("style.outerGlow")
      local outerSpec = outerGlowStyle(styleValue.outerGlow)
      roundRectTraceEnd(outerTrace)
      local backdropInput = styleValue.backdrop
      local backdropTrace = roundRectTraceStart("style.backdrop")
      local backdropSpec
      do
        local __lux_tmp_506 = backdropInput ~= nil
        if __lux_tmp_506 then
          __lux_tmp_506 = backdropInput ~= false
        end
        if __lux_tmp_506 then
          backdropSpec = style.backdropStyle(backdropInput)
        else
          backdropSpec = nil
        end
      end
      roundRectTraceEnd(backdropTrace)
      roundRectTraceEnd(effectTrace)
      if profiling then
        local now = sysTime()
        roundRectProfileRecord("round.prepare", (now - stageProfile) * 1000)
        stageProfile = now
      end
      local cullSpreadTrace = roundRectTraceStart("round.cullSpread")
      local cullSpread = roundRectCullSpread(shadowSpec, outerSpec, backdropSpec, shaderReady)
      roundRectTraceEnd(cullSpreadTrace)
      local cullTrace = roundRectTraceStart("round.cull")
      local __lux_tmp_507 = not transformActive
      if __lux_tmp_507 then
        __lux_tmp_507 = frame.isCulled(x - cullSpread, y - cullSpread, w + cullSpread * 2, h + cullSpread * 2)
      end
      if __lux_tmp_507 then
        roundRectTraceEnd(cullTrace)
        if profiling then
          roundRectProfileRecord("round.cull", (sysTime() - stageProfile) * 1000)
        end
        finishImmediateTrace(trace, profiling, totalProfile)
        return
      end
      roundRectTraceEnd(cullTrace)
      if profiling then
        local now = sysTime()
        roundRectProfileRecord("round.cull", (now - stageProfile) * 1000)
        stageProfile = now
      end
      if not shaderReady then
        local profile
        if profiling then
          profile = roundRectProfileStart()
        else
          profile = nil
        end
        local fallbackTrace = roundRectTraceStart("round.fallback")
        drawRoundRectFallback(x, y, w, h, styleValue)
        drawRoundRectInnerGlowSpec(x, y, w, h, radius, innerGlowStyle(styleValue.innerGlow))
        roundRectTraceEnd(fallbackTrace)
        if profiling then
          roundRectProfileEnd("round.fallback", profile)
        end
        finishImmediateTrace(trace, profiling, totalProfile)
        return
      end
      local fillInput
      do
        local __lux_tmp_508 = styleValue.fill
        if __lux_tmp_508 == nil then
          __lux_tmp_508 = styleValue.color
        end
        fillInput = __lux_tmp_508
      end
      if profiling then
        stageProfile = sysTime()
      end
      local fillPrepareTrace = roundRectTraceStart("round.fillPrepare")
      local fill = hotFillFromStyle(fillInput)
      local hasFill = style.fillVisible(fill)
      local innerSpec = innerGlowStyle(styleValue.innerGlow)
      roundRectTraceEnd(fillPrepareTrace)
      if profiling then
        local now = sysTime()
        roundRectProfileRecord("round.fillPrepare", (now - stageProfile) * 1000)
        stageProfile = now
      end
      local profile = nil
      local __lux_tmp_509 = backdropSpec == nil
      if __lux_tmp_509 then
        __lux_tmp_509 = styleValue.pattern == nil
      end
      local __lux_tmp_510 = __lux_tmp_509
      if __lux_tmp_510 then
        __lux_tmp_510 = innerSpec == nil
      end
      local __lux_tmp_511 = __lux_tmp_510
      if __lux_tmp_511 then
        __lux_tmp_511 = not transformActive
      end
      local __lux_tmp_512 = __lux_tmp_511
      if __lux_tmp_512 then
        local __lux_tmp_513 = hasFill
        if not __lux_tmp_513 then
          __lux_tmp_513 = hasStroke
        end
        __lux_tmp_512 = __lux_tmp_513
      end
      local __lux_tmp_514 = __lux_tmp_512
      if __lux_tmp_514 then
        local __lux_tmp_515 = shadowSpec ~= nil
        if not __lux_tmp_515 then
          __lux_tmp_515 = outerSpec ~= nil
        end
        __lux_tmp_514 = __lux_tmp_515
      end
      if __lux_tmp_514 then
        do
          local __lux_tmp_516
          if profiling then
            __lux_tmp_516 = roundRectProfileStart()
          else
            __lux_tmp_516 = nil
          end
          profile = __lux_tmp_516
        end
        local fusedTrace = roundRectTraceStart("round.fused")
        local radiusValue = roundRectRadiusScalar(radius, w, h)
        if drawRoundRectFusedSpec(
          x,
          y,
          w,
          h,
          radius,
          fill,
          styleValue.stroke,
          strokeWidth,
          shadowSpec,
          outerSpec,
          radiusValue
        ) then
          roundRectTraceEnd(fusedTrace)
          if profiling then
            roundRectProfileEnd("round.fused", profile)
          end
          finishImmediateTrace(trace, profiling, totalProfile)
          return
        end
        roundRectTraceEnd(fusedTrace)
        if profiling then
          roundRectProfileEnd("round.fused.miss", profile)
        end
      end
      local __lux_tmp_517 = shadowSpec ~= nil
      if not __lux_tmp_517 then
        __lux_tmp_517 = outerSpec ~= nil
      end
      if __lux_tmp_517 then
        do
          local __lux_tmp_518
          if profiling then
            __lux_tmp_518 = roundRectProfileStart()
          else
            __lux_tmp_518 = nil
          end
          profile = __lux_tmp_518
        end
        local shadowOuterTrace = roundRectTraceStart("round.shadowOuter")
        drawRoundRectShadowOuterSpec(x, y, w, h, radius, shadowSpec, outerSpec)
        roundRectTraceEnd(shadowOuterTrace)
        if profiling then
          roundRectProfileEnd("round.shadowOuter", profile)
        end
      end
      local backdrop = nil
      if backdropSpec ~= nil then
        do
          local __lux_tmp_519
          if profiling then
            __lux_tmp_519 = roundRectProfileStart()
          else
            __lux_tmp_519 = nil
          end
          profile = __lux_tmp_519
        end
        local backdropPassTrace = roundRectTraceStart("round.backdrop")
        backdrop = drawRoundRectBackdrop(x, y, w, h, radius, backdropSpec)
        roundRectTraceEnd(backdropPassTrace)
        if profiling then
          roundRectProfileEnd("round.backdrop", profile)
        end
      end
      local effectOnly
      do
        local __lux_tmp_520 = backdrop == nil
        if __lux_tmp_520 then
          __lux_tmp_520 = not hasStroke
        end
        local __lux_tmp_521 = __lux_tmp_520
        if __lux_tmp_521 then
          __lux_tmp_521 = styleValue.pattern == nil
        end
        local __lux_tmp_522 = __lux_tmp_521
        if __lux_tmp_522 then
          __lux_tmp_522 = innerSpec == nil
        end
        local __lux_tmp_523 = __lux_tmp_522
        if __lux_tmp_523 then
          local __lux_tmp_524 = shadowSpec ~= nil
          if not __lux_tmp_524 then
            __lux_tmp_524 = outerSpec ~= nil
          end
          __lux_tmp_523 = __lux_tmp_524
        end
        effectOnly = __lux_tmp_523
      end
      local __lux_tmp_525 = effectOnly
      if __lux_tmp_525 then
        __lux_tmp_525 = not hasFill
      end
      if __lux_tmp_525 then
        finishImmediateTrace(trace, profiling, totalProfile)
        return
      end
      local __lux_tmp_526 = backdrop == nil
      if __lux_tmp_526 then
        __lux_tmp_526 = not hasFill
      end
      local __lux_tmp_527 = __lux_tmp_526
      if __lux_tmp_527 then
        __lux_tmp_527 = not hasStroke
      end
      local __lux_tmp_528 = __lux_tmp_527
      if __lux_tmp_528 then
        __lux_tmp_528 = styleValue.pattern == nil
      end
      local __lux_tmp_529 = __lux_tmp_528
      if __lux_tmp_529 then
        __lux_tmp_529 = innerSpec == nil
      end
      if __lux_tmp_529 then
        finishImmediateTrace(trace, profiling, totalProfile)
        return
      end
      local innerGlowDrawn = false
      if styleValue.pattern ~= nil then
        do
          local __lux_tmp_530
          if profiling then
            __lux_tmp_530 = roundRectProfileStart()
          else
            __lux_tmp_530 = nil
          end
          profile = __lux_tmp_530
        end
        local layeredTrace = roundRectTraceStart("round.layered")
        if hasFill then
          drawRoundRectFillPass(x, y, w, h, radius, fill)
        end
        drawRoundRectPattern(x, y, w, h, radius, styleValue.pattern)
        if hasStroke then
          drawRoundRectStrokePass(x, y, w, h, radius, styleValue.stroke, strokeWidth)
        end
        roundRectTraceEnd(layeredTrace)
        if profiling then
          roundRectProfileEnd("round.layered", profile)
        end
      else
        do
          local __lux_tmp_531
          if profiling then
            __lux_tmp_531 = roundRectProfileStart()
          else
            __lux_tmp_531 = nil
          end
          profile = __lux_tmp_531
        end
        local baseTrace = roundRectTraceStart("round.base")
        local radiusTrace = roundRectTraceStart("round.base.radius")
        local radiusValue = roundRectRadiusScalar(radius, w, h)
        roundRectTraceEnd(radiusTrace)
        local baseKind
        if fill.kind == style.FILL_LINEAR then
          baseKind = "round.base.gradient"
        else
          if hasStroke then
            baseKind = "round.base.stroke"
          else
            if radiusValue <= 0 then
              baseKind = "round.base.solidRect"
            else
              baseKind = "round.base.solidRound"
            end
          end
        end
        local __lux_tmp_532 = innerSpec ~= nil
        if __lux_tmp_532 then
          __lux_tmp_532 = drawRoundRectFxPass(x, y, w, h, radius, fill, styleValue.stroke, strokeWidth, innerSpec)
        end
        if __lux_tmp_532 then
          baseKind = "round.base.fx"
          innerGlowDrawn = true
        else
          local __lux_tmp_533 = baseKind == "round.base.solidRect"
          if __lux_tmp_533 then
            __lux_tmp_533 = fill.kind == style.FILL_SOLID
          end
          local __lux_tmp_534 = __lux_tmp_533
          if __lux_tmp_534 then
            __lux_tmp_534 = styleValue.shadow == nil
          end
          local __lux_tmp_535 = __lux_tmp_534
          if __lux_tmp_535 then
            __lux_tmp_535 = styleValue.outerGlow == nil
          end
          local __lux_tmp_536 = __lux_tmp_535
          if __lux_tmp_536 then
            __lux_tmp_536 = styleValue.innerGlow == nil
          end
          local __lux_tmp_537 = __lux_tmp_536
          if __lux_tmp_537 then
            __lux_tmp_537 = backdrop == nil
          end
          local __lux_tmp_538 = __lux_tmp_537
          if __lux_tmp_538 then
            __lux_tmp_538 = not transformActive
          end
          if __lux_tmp_538 then
            local drawProfile
            if profiling then
              drawProfile = roundRectProfileStart()
            else
              drawProfile = nil
            end
            local drawTrace = roundRectTraceStart("round.base.draw")
            drawSolidRectFast(x, y, w, h, fill)
            roundRectTraceEnd(drawTrace)
            if profiling then
              roundRectProfileEnd("round.base.draw", drawProfile)
            end
            baseKind = "round.base.solidRectFast"
          else
            local __lux_tmp_539 = baseKind == "round.base.solidRound"
            if __lux_tmp_539 then
              __lux_tmp_539 = fill.kind == style.FILL_SOLID
            end
            local __lux_tmp_540 = __lux_tmp_539
            if __lux_tmp_540 then
              __lux_tmp_540 = styleValue.shadow == nil
            end
            local __lux_tmp_541 = __lux_tmp_540
            if __lux_tmp_541 then
              __lux_tmp_541 = styleValue.outerGlow == nil
            end
            local __lux_tmp_542 = __lux_tmp_541
            if __lux_tmp_542 then
              __lux_tmp_542 = styleValue.innerGlow == nil
            end
            local __lux_tmp_543 = __lux_tmp_542
            if __lux_tmp_543 then
              __lux_tmp_543 = backdrop == nil
            end
            local __lux_tmp_544 = __lux_tmp_543
            if __lux_tmp_544 then
              __lux_tmp_544 = drawSolidRoundFast(x, y, w, h, radiusValue, fill)
            end
            if __lux_tmp_544 then
              baseKind = "round.base.solidRoundFast"
            else
              local __lux_tmp_545 = hasFill
              if not __lux_tmp_545 then
                __lux_tmp_545 = hasStroke
              end
              local __lux_tmp_546 = __lux_tmp_545
              if not __lux_tmp_546 then
                __lux_tmp_546 = backdrop ~= nil
              end
              if __lux_tmp_546 then
                local setupProfile
                if profiling then
                  setupProfile = roundRectProfileStart()
                else
                  setupProfile = nil
                end
                local setupTrace = roundRectTraceStart("round.base.setup")
                setupRoundRectConstants(
                  roundRectMaterials.roundrect,
                  w,
                  h,
                  fill,
                  styleValue.stroke,
                  strokeWidth,
                  radiusValue
                )
                surfaceSetMaterial(roundRectMaterials.roundrect)
                surfaceSetDrawColor(255, 255, 255, 255)
                roundRectTraceEnd(setupTrace)
                if profiling then
                  roundRectProfileEnd("round.base.setup", setupProfile)
                end
                local drawProfile
                if profiling then
                  drawProfile = roundRectProfileStart()
                else
                  drawProfile = nil
                end
                local drawTrace = roundRectTraceStart("round.base.draw")
                drawTexturedQuad(x, y, w, h, roundRectMaterials.roundrect)
                roundRectTraceEnd(drawTrace)
                if profiling then
                  roundRectProfileEnd("round.base.draw", drawProfile)
                end
              end
            end
          end
        end
        roundRectTraceEnd(baseTrace)
        if profiling then
          roundRectProfileEndBase(baseKind, profile)
        end
      end
      local __lux_tmp_547 = innerSpec ~= nil
      if __lux_tmp_547 then
        __lux_tmp_547 = not innerGlowDrawn
      end
      if __lux_tmp_547 then
        local profile
        if profiling then
          profile = roundRectProfileStart()
        else
          profile = nil
        end
        local innerTrace = roundRectTraceStart("round.innerGlow")
        drawRoundRectInnerGlowSpec(x, y, w, h, radius, innerSpec)
        roundRectTraceEnd(innerTrace)
        if profiling then
          roundRectProfileEnd("round.innerGlow", profile)
        end
      end
      return finishImmediateTrace(trace, profiling, totalProfile)
    end
  end
  do
    roundedBoxEx = function(x, y, w, h, drawStyle)
      local trace = roundRectTraceStart("api.RoundedBoxEx")
      local styleTrace = roundRectTraceStart("api.RoundedBoxEx.resolveDrawStyle")
      local resolved
      do
        local __lux_tmp_548 = drawStyle
        if __lux_tmp_548 == nil then
          __lux_tmp_548 = {}
        end
        resolved = __lux_tmp_548
      end
      roundRectTraceEnd(styleTrace)
      local transformTrace = roundRectTraceStart("api.RoundedBoxEx.splitStyleTransform")
      local transform, stripped = splitStyleTransform(resolved)
      roundRectTraceEnd(transformTrace)
      if transform == nil then
        local result = drawRoundRectImmediate(x, y, w, h, stripped)
        roundRectTraceEnd(trace)
        return result
      end
      local withTransformTrace = roundRectTraceStart("api.RoundedBoxEx.withTransform")
      local result = withTransform(
        transform,
        x,
        y,
        w,
        h,
        function()
          return drawRoundRectImmediate(x, y, w, h, stripped)
        end
      )
      roundRectTraceEnd(withTransformTrace)
      roundRectTraceEnd(trace)
      return result
    end
    roundedBox = function(x, y, w, h, radius, fill, stroke, strokeWidth)
      local trace = roundRectTraceStart("api.RoundedBox")
      roundedBoxStyle.radius = radius
      roundedBoxStyle.fill = fill
      roundedBoxStyle.stroke = stroke
      roundedBoxStyle.strokeWidth = strokeWidth
      local result = drawRoundRectImmediate(x, y, w, h, roundedBoxStyle)
      roundRectTraceEnd(trace)
      return result
    end
    circle = function(cx, cy, radius, fill, stroke, strokeWidth)
      return roundedBox(
        cx - radius,
        cy - radius,
        radius * 2,
        radius * 2,
        radius,
        fill,
        stroke,
        strokeWidth
      )
    end
    circleEx = function(cx, cy, radius, drawStyle)
      local resolved
      do
        local __lux_tmp_549 = drawStyle
        if __lux_tmp_549 == nil then
          __lux_tmp_549 = {}
        end
        resolved = copyInto(circleStyle, __lux_tmp_549)
      end
      resolved.radius = radius
      return roundedBoxEx(cx - radius, cy - radius, radius * 2, radius * 2, resolved)
    end
    capsule = function(x, y, w, h, fill, stroke, strokeWidth)
      return roundedBox(x, y, w, h, mathMin(w, h) * 0.5, fill, stroke, strokeWidth)
    end
    capsuleEx = function(x, y, w, h, drawStyle)
      local resolved = drawStyle
      local __lux_tmp_550 = resolved == nil
      if not __lux_tmp_550 then
        __lux_tmp_550 = resolved.radius == nil
      end
      if __lux_tmp_550 then
        do
          local __lux_tmp_551 = drawStyle
          if __lux_tmp_551 == nil then
            __lux_tmp_551 = {}
          end
          resolved = copyInto(capsuleStyle, __lux_tmp_551)
        end
        resolved.radius = mathMin(w, h) * 0.5
      end
      return roundedBoxEx(x, y, w, h, resolved)
    end
  end
  do
    install = function(owner)
      configureRoundRect(owner)
      owner.RoundedBox = roundedBox
      owner.RoundedBoxEx = roundedBoxEx
      owner.Circle = circle
      owner.CircleEx = circleEx
      owner.Capsule = capsule
      owner.CapsuleEx = capsuleEx
      owner._RoundRect = {
        drawRoundRectImmediate = drawRoundRectImmediate,
        fallbackRoundRectPoints = fallbackRoundRectPoints,
        innerGlowStyle = innerGlowStyle,
        outerGlowStyle = outerGlowStyle,
        shadowStyle = shadowStyle,
        patternStyle = patternStyle,
        patternOffset = patternOffset,
      }
      return owner
    end
  end
  
  __lux_exports.effectExtentFromSpec = effectExtentFromSpec
  __lux_exports.fallbackRoundRectPoints = fallbackRoundRectPoints
  __lux_exports.innerGlowStyle = innerGlowStyle
  __lux_exports.glowBiasPads = glowBiasPads
  __lux_exports.outerGlowStyle = outerGlowStyle
  __lux_exports.shadowStyle = shadowStyle
  __lux_exports.patternStyle = patternStyle
  __lux_exports.patternOffset = patternOffset
  __lux_exports.drawRoundRectImmediate = drawRoundRectImmediate
  __lux_exports.roundedBoxEx = roundedBoxEx
  __lux_exports.roundedBox = roundedBox
  __lux_exports.circle = circle
  __lux_exports.circleEx = circleEx
  __lux_exports.capsule = capsule
  __lux_exports.capsuleEx = capsuleEx
  __lux_exports.install = install
  
  return __lux_exports
end
