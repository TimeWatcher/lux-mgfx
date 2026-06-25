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
  local emptyRoundRectStyle
  local transparentColor
  local solidFillScratch
  local backdropTintScratch
  local backdropFillScratch
  local roundRectProfiler
  local defaultInnerGlowColor
  local defaultOuterGlowColor
  local defaultShadowColor
  local inv255
  local effectExtentRaw
  local defaultInnerGlowFalloff
  local defaultOuterGlowFalloff
  local defaultShadowFalloff
  local defaultOuterGlowExtent
  local defaultOuterGlowCullSpread
  local defaultShadowExtent
  local defaultShadowCullSpread
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
  local setColor
  local appendPoint
  local appendCorner
  local fallbackRoundRectPoints
  local drawFallbackStroke
  local drawRoundRectFallbackRaw
  local effectOffset
  local glowBiasPads
  local innerGlowRaw
  local outerGlowRaw
  local shadowRaw
  local patternStyle
  local patternOffset
  local roundRectFillParams
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
  local drawRoundRectInnerGlowRaw
  local drawRoundRectShadowOuterRaw
  local drawRoundRectFusedRaw
  local backdropTintColor
  local drawRoundRectBackdrop
  local drawRoundRectStrokePass
  local drawRoundRectFxPassRaw
  local drawRoundRectRaw
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
    inv255 = 1 / 255
    effectExtentRaw = function(width, falloff, spread, defaultWidth)
      if defaultWidth == nil then
        defaultWidth = 18
      end
      do
        local __lux_tmp_11 = toNumber(width)
        if __lux_tmp_11 == nil then
          __lux_tmp_11 = defaultWidth
        end
        width = mathMax(0.001, __lux_tmp_11)
      end
      do
        local __lux_tmp_12 = toNumber(falloff)
        if __lux_tmp_12 == nil then
          __lux_tmp_12 = 1.9
        end
        falloff = mathMax(0.35, __lux_tmp_12)
      end
      local sigma = mathMax(width / mathSqrt(falloff) * 0.72, 0.35)
      local tail = sigma * 3.72
      local __lux_tmp_13 = toNumber(spread)
      if __lux_tmp_13 == nil then
        __lux_tmp_13 = width
      end
      return mathMax(1, __lux_tmp_13, tail)
    end
    defaultInnerGlowFalloff = style.glowSoftnessToFalloff(0.55)
    defaultOuterGlowFalloff = style.glowSoftnessToFalloff(0.54)
    defaultShadowFalloff = style.glowSoftnessToFalloff(0.62)
    defaultOuterGlowExtent = effectExtentRaw(18, defaultOuterGlowFalloff, 18, 18)
    defaultOuterGlowCullSpread = defaultOuterGlowExtent
    defaultShadowExtent = effectExtentRaw(12, defaultShadowFalloff, 12, 12)
    defaultShadowCullSpread = 4 + defaultShadowExtent
    configureRoundRect = function(owner)
      do
        local __lux_tmp_14 = owner
        if __lux_tmp_14 == nil then
          __lux_tmp_14 = {}
        end
        owner = __lux_tmp_14
      end
      local materialState
      do
        local __lux_tmp_15 = owner._MaterialState
        if __lux_tmp_15 == nil then
          __lux_tmp_15 = {}
        end
        materialState = __lux_tmp_15
      end
      do
        local __lux_tmp_16 = owner._Materials
        if __lux_tmp_16 == nil then
          local __lux_tmp_17 = materialState.materials
          if __lux_tmp_17 == nil then
            local __lux_tmp_18 = roundRectMaterials
            if __lux_tmp_18 == nil then
              __lux_tmp_18 = {}
            end
            __lux_tmp_17 = __lux_tmp_18
          end
          __lux_tmp_16 = __lux_tmp_17
        end
        roundRectMaterials = __lux_tmp_16
      end
      do
        local __lux_tmp_19 = owner._BlurRT
        if __lux_tmp_19 == nil then
          local __lux_tmp_20 = materialState.blurRT
          if __lux_tmp_20 == nil then
            __lux_tmp_20 = roundRectBlurRT
          end
          __lux_tmp_19 = __lux_tmp_20
        end
        roundRectBlurRT = __lux_tmp_19
      end
      do
        local __lux_tmp_21 = owner.MaterialOK
        if __lux_tmp_21 == nil then
          local __lux_tmp_22 = materialState.matOK
          if __lux_tmp_22 == nil then
            __lux_tmp_22 = roundRectMatOK
          end
          __lux_tmp_21 = __lux_tmp_22
        end
        roundRectMatOK = __lux_tmp_21
      end
      do
        local __lux_tmp_23 = owner.hasShaders
        if __lux_tmp_23 == nil then
          __lux_tmp_23 = roundRectHasShaders
        end
        roundRectHasShaders = __lux_tmp_23
      end
      roundRectProfiler = owner.Profiler
      return true
    end
    materialOK = function(material)
      local __lux_tmp_24 = roundRectMatOK ~= nil
      if __lux_tmp_24 then
        __lux_tmp_24 = roundRectMatOK(material)
      end
      return __lux_tmp_24
    end
    shadersActive = function()
      local __lux_tmp_25 = forceFallbackCvar == nil
      if __lux_tmp_25 then
        __lux_tmp_25 = getConVar ~= nil
      end
      if __lux_tmp_25 then
        do
          local __lux_tmp_26 = getConVar("mgfx_force_fallback")
          if __lux_tmp_26 == nil then
            __lux_tmp_26 = false
          end
          forceFallbackCvar = __lux_tmp_26
        end
      end
      local __lux_tmp_27 = forceFallbackCvar ~= nil
      if __lux_tmp_27 then
        __lux_tmp_27 = forceFallbackCvar ~= false
      end
      local __lux_tmp_28 = __lux_tmp_27
      if __lux_tmp_28 then
        __lux_tmp_28 = forceFallbackCvar:GetBool()
      end
      if __lux_tmp_28 then
        return false
      end
      local __lux_tmp_29 = roundRectHasShaders ~= nil
      if __lux_tmp_29 then
        __lux_tmp_29 = roundRectHasShaders()
      end
      return __lux_tmp_29
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
        local __lux_tmp_30 = fill.colorA
        if __lux_tmp_30 == nil then
          local __lux_tmp_31 = fill.color
          if __lux_tmp_31 == nil then
            local __lux_tmp_32 = fallback
            if __lux_tmp_32 == nil then
              __lux_tmp_32 = color_white
            end
            __lux_tmp_31 = __lux_tmp_32
          end
          __lux_tmp_30 = __lux_tmp_31
        end
        return __lux_tmp_30
      end
      local __lux_tmp_33 = fallback
      if __lux_tmp_33 == nil then
        __lux_tmp_33 = color_white
      end
      return __lux_tmp_33
    end
    hotFillFromStyle = function(fill, fallback)
      if typeOf(fill) == "table" then
        local kind = fill.kind
        local __lux_tmp_34 = kind == style.FILL_SOLID
        if not __lux_tmp_34 then
          __lux_tmp_34 = kind == style.FILL_LINEAR
        end
        local __lux_tmp_35 = __lux_tmp_34
        if not __lux_tmp_35 then
          __lux_tmp_35 = kind == style.FILL_RADIAL
        end
        local __lux_tmp_36 = __lux_tmp_35
        if not __lux_tmp_36 then
          __lux_tmp_36 = kind == style.FILL_CONIC
        end
        if __lux_tmp_36 then
          return fill
        end
        if kind ~= nil then
          solidFillScratch.colorA = transparentColor
          solidFillScratch.colorB = transparentColor
          solidFillScratch._mgfxFillVisible = false
          return solidFillScratch
        end
        local __lux_tmp_37 = fill.r ~= nil
        if __lux_tmp_37 then
          __lux_tmp_37 = fill.g ~= nil
        end
        local __lux_tmp_38 = __lux_tmp_37
        if __lux_tmp_38 then
          __lux_tmp_38 = fill.b ~= nil
        end
        if __lux_tmp_38 then
          solidFillScratch.colorA = fill
          solidFillScratch.colorB = fill
          do
            local __lux_tmp_39 = fill.a == nil
            if not __lux_tmp_39 then
              __lux_tmp_39 = fill.a > 0
            end
            solidFillScratch._mgfxFillVisible = __lux_tmp_39
          end
          return solidFillScratch
        end
      end
      local color
      do
        local __lux_tmp_40 = fallback
        if __lux_tmp_40 == nil then
          __lux_tmp_40 = color_white
        end
        color = style.asColor(fill, __lux_tmp_40)
      end
      solidFillScratch.colorA = color
      solidFillScratch.colorB = color
      do
        local __lux_tmp_41 = color.a == nil
        if not __lux_tmp_41 then
          __lux_tmp_41 = color.a > 0
        end
        solidFillScratch._mgfxFillVisible = __lux_tmp_41
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
        local __lux_tmp_42 = fill.a == nil
        if not __lux_tmp_42 then
          __lux_tmp_42 = fill.a > 0
        end
        return __lux_tmp_42
      end
      if fill._mgfxFillVisible ~= nil then
        return fill._mgfxFillVisible
      end
      local kind = fill.kind
      if kind == style.FILL_SOLID then
        local colorA
        do
          local __lux_tmp_43 = fill.colorA
          if __lux_tmp_43 == nil then
            __lux_tmp_43 = color_white
          end
          colorA = __lux_tmp_43
        end
        local colorB
        do
          local __lux_tmp_44 = fill.colorB
          if __lux_tmp_44 == nil then
            __lux_tmp_44 = colorA
          end
          colorB = __lux_tmp_44
        end
        local __lux_tmp_45 = colorA.a == nil
        if not __lux_tmp_45 then
          __lux_tmp_45 = colorA.a > 0
        end
        local __lux_tmp_46 = __lux_tmp_45
        if not __lux_tmp_46 then
          local __lux_tmp_47 = colorB.a == nil
          if not __lux_tmp_47 then
            __lux_tmp_47 = colorB.a > 0
          end
          __lux_tmp_46 = __lux_tmp_47
        end
        return __lux_tmp_46
      end
      local __lux_tmp_48 = kind == style.FILL_LINEAR
      if not __lux_tmp_48 then
        __lux_tmp_48 = kind == style.FILL_RADIAL
      end
      local __lux_tmp_49 = __lux_tmp_48
      if not __lux_tmp_49 then
        __lux_tmp_49 = kind == style.FILL_CONIC
      end
      if __lux_tmp_49 then
        local __lux_tmp_50 = fill.stops ~= nil
        if not __lux_tmp_50 then
          local __lux_tmp_51 = fill.colorA ~= nil
          if __lux_tmp_51 then
            local __lux_tmp_52 = fill.colorA.a == nil
            if not __lux_tmp_52 then
              __lux_tmp_52 = fill.colorA.a > 0
            end
            __lux_tmp_51 = __lux_tmp_52
          end
          __lux_tmp_50 = __lux_tmp_51
        end
        local __lux_tmp_53 = __lux_tmp_50
        if not __lux_tmp_53 then
          local __lux_tmp_54 = fill.colorB ~= nil
          if __lux_tmp_54 then
            local __lux_tmp_55 = fill.colorB.a == nil
            if not __lux_tmp_55 then
              __lux_tmp_55 = fill.colorB.a > 0
            end
            __lux_tmp_54 = __lux_tmp_55
          end
          __lux_tmp_53 = __lux_tmp_54
        end
        return __lux_tmp_53
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
      local __lux_tmp_56 = typeOf(radius) ~= "table"
      if not __lux_tmp_56 then
        __lux_tmp_56 = style.isColor(radius)
      end
      if __lux_tmp_56 then
        local value
        do
          local __lux_tmp_57 = toNumber(radius)
          if __lux_tmp_57 == nil then
            __lux_tmp_57 = 0
          end
          value = __lux_tmp_57
        end
        if value <= 0 then
          return 0
        end
        local maxRadius
        do
          local __lux_tmp_58 = toNumber(w)
          if __lux_tmp_58 == nil then
            __lux_tmp_58 = 0
          end
          local __lux_tmp_59 = toNumber(h)
          if __lux_tmp_59 == nil then
            __lux_tmp_59 = 0
          end
          maxRadius = mathMin(mathMax(0, __lux_tmp_58), mathMax(0, __lux_tmp_59)) * 0.5
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
      local __lux_tmp_60 = roundRectProfiler ~= nil
      if __lux_tmp_60 then
        __lux_tmp_60 = roundRectProfiler.IsActive ~= nil
      end
      local __lux_tmp_61 = __lux_tmp_60
      if __lux_tmp_61 then
        __lux_tmp_61 = roundRectProfiler.IsActive()
      end
      return __lux_tmp_61
    end
    roundRectProfileStart = function()
      local __lux_tmp_62 = roundRectProfiler ~= nil
      if __lux_tmp_62 then
        __lux_tmp_62 = roundRectProfiler.Start ~= nil
      end
      if __lux_tmp_62 then
        return roundRectProfiler.Start()
      end
      return nil
    end
    roundRectProfileEnd = function(name, started)
      local __lux_tmp_63 = started ~= nil
      if __lux_tmp_63 then
        __lux_tmp_63 = roundRectProfiler ~= nil
      end
      local __lux_tmp_64 = __lux_tmp_63
      if __lux_tmp_64 then
        __lux_tmp_64 = roundRectProfiler.End ~= nil
      end
      if __lux_tmp_64 then
        roundRectProfiler.End(name, started)
      end
    end
    roundRectProfileRecord = function(name, elapsed)
      local __lux_tmp_65 = elapsed ~= nil
      if __lux_tmp_65 then
        __lux_tmp_65 = roundRectProfiler ~= nil
      end
      local __lux_tmp_66 = __lux_tmp_65
      if __lux_tmp_66 then
        __lux_tmp_66 = roundRectProfiler.Record ~= nil
      end
      if __lux_tmp_66 then
        roundRectProfiler.Record(name, elapsed)
      end
    end
    roundRectTraceStart = function(name)
      local __lux_tmp_67 = roundRectProfiler ~= nil
      if __lux_tmp_67 then
        __lux_tmp_67 = roundRectProfiler._TraceActive
      end
      local __lux_tmp_68 = __lux_tmp_67
      if __lux_tmp_68 then
        __lux_tmp_68 = roundRectProfiler.TraceStart ~= nil
      end
      if __lux_tmp_68 then
        return roundRectProfiler.TraceStart(name)
      end
      return nil
    end
    roundRectTraceEnd = function(token)
      local __lux_tmp_69 = token ~= nil
      if __lux_tmp_69 then
        __lux_tmp_69 = roundRectProfiler ~= nil
      end
      local __lux_tmp_70 = __lux_tmp_69
      if __lux_tmp_70 then
        __lux_tmp_70 = roundRectProfiler.TraceEnd ~= nil
      end
      if __lux_tmp_70 then
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
      local __lux_tmp_71 = roundRectProfiler ~= nil
      if __lux_tmp_71 then
        __lux_tmp_71 = roundRectProfiler.Record ~= nil
      end
      if __lux_tmp_71 then
        roundRectProfiler.Record("round.base", elapsed)
        if kind ~= nil then
          roundRectProfiler.Record(kind, elapsed)
        end
      end
    end
    setColor = function(color)
      return style.setDrawColor(color)
    end
    appendPoint = function(verts, x, y)
      local index = #verts + 1
      local point
      do
        local __lux_tmp_72 = verts[index]
        if __lux_tmp_72 == nil then
          __lux_tmp_72 = {}
        end
        point = __lux_tmp_72
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
      local __lux_tmp_73 = w <= 0
      if not __lux_tmp_73 then
        __lux_tmp_73 = h <= 0
      end
      if __lux_tmp_73 then
        return verts
      end
      do
        local __lux_tmp_74 = toNumber(radius)
        if __lux_tmp_74 == nil then
          __lux_tmp_74 = 0
        end
        radius = mathMin(mathMax(0, __lux_tmp_74), w * 0.5, h * 0.5)
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
        local __lux_tmp_75 = toNumber(width)
        if __lux_tmp_75 == nil then
          __lux_tmp_75 = 1
        end
        width = mathMax(1, __lux_tmp_75)
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
    drawRoundRectFallbackRaw = function(x, y, w, h, radius, fillInput, stroke, strokeWidthInput)
      if radius == nil then
        radius = 0
      end
      recordFallbacks()
      local fill = hotFillFromStyle(fillInput)
      if hasTransform() then
        local points = fallbackRoundRectPoints(x, y, w, h, radius)
        if style.fillVisible(fill) then
          setColor(fillColor(fill))
          drawTransformedPoly(points)
        end
        local strokeWidth = style.strokeWidth(strokeWidthInput, 1)
        if style.strokeVisible(stroke, strokeWidth) then
          drawFallbackStroke(points, stroke, mathMax(1, mathFloor(strokeWidth)))
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
      if style.strokeVisible(stroke, strokeWidthInput) then
        setColor(stroke)
        surfaceDrawOutlinedRect(
          x,
          y,
          w,
          h,
          mathMax(1, mathFloor(style.strokeWidth(strokeWidthInput, 1)))
        )
        recordDraws()
      end
    end
  end
  do
    effectOffset = function(input, fallbackX, fallbackY)
      if fallbackX == nil then
        fallbackX = 0
      end
      if fallbackY == nil then
        fallbackY = 0
      end
      local x
      do
        local __lux_tmp_76 = input.x
        if __lux_tmp_76 == nil then
          local __lux_tmp_77 = input.offsetX
          if __lux_tmp_77 == nil then
            local __lux_tmp_78 = input.dx
            if __lux_tmp_78 == nil then
              __lux_tmp_78 = input[1]
            end
            __lux_tmp_77 = __lux_tmp_78
          end
          __lux_tmp_76 = __lux_tmp_77
        end
        x = __lux_tmp_76
      end
      local y
      do
        local __lux_tmp_79 = input.y
        if __lux_tmp_79 == nil then
          local __lux_tmp_80 = input.offsetY
          if __lux_tmp_80 == nil then
            local __lux_tmp_81 = input.dy
            if __lux_tmp_81 == nil then
              __lux_tmp_81 = input[2]
            end
            __lux_tmp_80 = __lux_tmp_81
          end
          __lux_tmp_79 = __lux_tmp_80
        end
        y = __lux_tmp_79
      end
      local offset = input.offset
      if typeOf(offset) == "table" then
        do
          local __lux_tmp_82 = x
          if __lux_tmp_82 == nil then
            local __lux_tmp_83 = offset.x
            if __lux_tmp_83 == nil then
              __lux_tmp_83 = offset[1]
            end
            __lux_tmp_82 = __lux_tmp_83
          end
          x = __lux_tmp_82
        end
        do
          local __lux_tmp_84 = y
          if __lux_tmp_84 == nil then
            local __lux_tmp_85 = offset.y
            if __lux_tmp_85 == nil then
              __lux_tmp_85 = offset[2]
            end
            __lux_tmp_84 = __lux_tmp_85
          end
          y = __lux_tmp_84
        end
      end
      local __lux_tmp_86 = toNumber(x)
      if __lux_tmp_86 == nil then
        __lux_tmp_86 = fallbackX
      end
      local __lux_tmp_87 = toNumber(y)
      if __lux_tmp_87 == nil then
        __lux_tmp_87 = fallbackY
      end
      return __lux_tmp_86, __lux_tmp_87
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
        local __lux_tmp_88 = toNumber(base)
        if __lux_tmp_88 == nil then
          __lux_tmp_88 = minPad
        end
        pad = mathMax(minPad, __lux_tmp_88)
      end
      local ox
      do
        local __lux_tmp_89 = toNumber(x)
        if __lux_tmp_89 == nil then
          __lux_tmp_89 = 0
        end
        ox = __lux_tmp_89
      end
      local oy
      do
        local __lux_tmp_90 = toNumber(y)
        if __lux_tmp_90 == nil then
          __lux_tmp_90 = 0
        end
        oy = __lux_tmp_90
      end
      return mathMax(minPad, pad - ox), mathMax(minPad, pad - oy), mathMax(minPad, pad + ox), mathMax(minPad, pad + oy)
    end
    innerGlowRaw = function(glow)
      local __lux_tmp_91 = glow == nil
      if not __lux_tmp_91 then
        __lux_tmp_91 = glow == false
      end
      if __lux_tmp_91 then
        return false, 0, 0, 0, 0, 0, 0, 1
      end
      if glow == true then
        local __lux_tmp_92 = defaultInnerGlowColor.r
        if __lux_tmp_92 == nil then
          __lux_tmp_92 = 0
        end
        local __lux_tmp_93 = defaultInnerGlowColor.g
        if __lux_tmp_93 == nil then
          __lux_tmp_93 = 0
        end
        local __lux_tmp_94 = defaultInnerGlowColor.b
        if __lux_tmp_94 == nil then
          __lux_tmp_94 = 0
        end
        local __lux_tmp_95 = defaultInnerGlowColor.a
        if __lux_tmp_95 == nil then
          __lux_tmp_95 = 255
        end
        return true, __lux_tmp_92 * inv255, __lux_tmp_93 * inv255, __lux_tmp_94 * inv255, __lux_tmp_95 * inv255, 7, 1, defaultInnerGlowFalloff
      end
      if style.isColor(glow) then
        local __lux_tmp_96 = glow.a == nil
        if not __lux_tmp_96 then
          __lux_tmp_96 = glow.a > 0
        end
        local __lux_tmp_97 = glow.r
        if __lux_tmp_97 == nil then
          __lux_tmp_97 = 0
        end
        local __lux_tmp_98 = glow.g
        if __lux_tmp_98 == nil then
          __lux_tmp_98 = 0
        end
        local __lux_tmp_99 = glow.b
        if __lux_tmp_99 == nil then
          __lux_tmp_99 = 0
        end
        local __lux_tmp_100 = glow.a
        if __lux_tmp_100 == nil then
          __lux_tmp_100 = 255
        end
        return __lux_tmp_96, __lux_tmp_97 * inv255, __lux_tmp_98 * inv255, __lux_tmp_99 * inv255, __lux_tmp_100 * inv255, 7, 1, defaultInnerGlowFalloff
      end
      if typeOf(glow) ~= "table" then
        return false, 0, 0, 0, 0, 0, 0, 1
      end
      local color
      do
        local __lux_tmp_101 = glow.color
        if __lux_tmp_101 == nil then
          __lux_tmp_101 = glow.tint
        end
        color = style.asColor(__lux_tmp_101, defaultInnerGlowColor)
      end
      local width
      do
        local __lux_tmp_102 = glow.size
        if __lux_tmp_102 == nil then
          __lux_tmp_102 = glow.width
        end
        local __lux_tmp_103 = toNumber(__lux_tmp_102)
        if __lux_tmp_103 == nil then
          __lux_tmp_103 = 7
        end
        width = mathMax(1, __lux_tmp_103)
      end
      local strength
      do
        local __lux_tmp_104 = glow.opacity
        if __lux_tmp_104 == nil then
          __lux_tmp_104 = glow.strength
        end
        local __lux_tmp_105 = toNumber(__lux_tmp_104)
        if __lux_tmp_105 == nil then
          __lux_tmp_105 = 1
        end
        strength = __lux_tmp_105
      end
      local falloff
      do
        local __lux_tmp_106 = toNumber(glow.falloff)
        if __lux_tmp_106 == nil then
          __lux_tmp_106 = style.glowSoftnessToFalloff(glow.softness, 0.55)
        end
        falloff = __lux_tmp_106
      end
      local alpha
      do
        local __lux_tmp_107 = color.a
        if __lux_tmp_107 == nil then
          __lux_tmp_107 = 255
        end
        alpha = __lux_tmp_107 * inv255
      end
      local __lux_tmp_108 = alpha > 0
      if __lux_tmp_108 then
        __lux_tmp_108 = strength > 0
      end
      local __lux_tmp_109 = color.r
      if __lux_tmp_109 == nil then
        __lux_tmp_109 = 0
      end
      local __lux_tmp_110 = color.g
      if __lux_tmp_110 == nil then
        __lux_tmp_110 = 0
      end
      local __lux_tmp_111 = color.b
      if __lux_tmp_111 == nil then
        __lux_tmp_111 = 0
      end
      return __lux_tmp_108, __lux_tmp_109 * inv255, __lux_tmp_110 * inv255, __lux_tmp_111 * inv255, alpha, width, strength, falloff
    end
    outerGlowRaw = function(glow)
      local __lux_tmp_112 = glow == nil
      if not __lux_tmp_112 then
        __lux_tmp_112 = glow == false
      end
      if __lux_tmp_112 then
        return false, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0
      end
      if glow == true then
        local __lux_tmp_113 = defaultOuterGlowColor.r
        if __lux_tmp_113 == nil then
          __lux_tmp_113 = 0
        end
        local __lux_tmp_114 = defaultOuterGlowColor.g
        if __lux_tmp_114 == nil then
          __lux_tmp_114 = 0
        end
        local __lux_tmp_115 = defaultOuterGlowColor.b
        if __lux_tmp_115 == nil then
          __lux_tmp_115 = 0
        end
        local __lux_tmp_116 = defaultOuterGlowColor.a
        if __lux_tmp_116 == nil then
          __lux_tmp_116 = 255
        end
        return true, __lux_tmp_113 * inv255, __lux_tmp_114 * inv255, __lux_tmp_115 * inv255, __lux_tmp_116 * inv255, 0, 0, 18, 18, 0, 1, defaultOuterGlowFalloff, defaultOuterGlowExtent, defaultOuterGlowCullSpread
      end
      if style.isColor(glow) then
        local width = 18
        local falloff = defaultOuterGlowFalloff
        local extent = effectExtentRaw(width, falloff, width, 18)
        local alpha
        do
          local __lux_tmp_117 = glow.a
          if __lux_tmp_117 == nil then
            __lux_tmp_117 = 255
          end
          alpha = __lux_tmp_117 * inv255
        end
        local __lux_tmp_118 = glow.r
        if __lux_tmp_118 == nil then
          __lux_tmp_118 = 0
        end
        local __lux_tmp_119 = glow.g
        if __lux_tmp_119 == nil then
          __lux_tmp_119 = 0
        end
        local __lux_tmp_120 = glow.b
        if __lux_tmp_120 == nil then
          __lux_tmp_120 = 0
        end
        return alpha > 0, __lux_tmp_118 * inv255, __lux_tmp_119 * inv255, __lux_tmp_120 * inv255, alpha, 0, 0, width, width, 0, 1, falloff, extent, extent
      end
      if typeOf(glow) ~= "table" then
        return false, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0
      end
      local x, y = effectOffset(glow, 0, 0)
      local width
      do
        local __lux_tmp_121 = glow.size
        if __lux_tmp_121 == nil then
          local __lux_tmp_122 = glow.width
          if __lux_tmp_122 == nil then
            local __lux_tmp_123 = glow.blur
            if __lux_tmp_123 == nil then
              local __lux_tmp_124 = glow.radius
              if __lux_tmp_124 == nil then
                __lux_tmp_124 = glow.spread
              end
              __lux_tmp_123 = __lux_tmp_124
            end
            __lux_tmp_122 = __lux_tmp_123
          end
          __lux_tmp_121 = __lux_tmp_122
        end
        local __lux_tmp_125 = toNumber(__lux_tmp_121)
        if __lux_tmp_125 == nil then
          __lux_tmp_125 = 18
        end
        width = mathMax(1, __lux_tmp_125)
      end
      local spread
      do
        local __lux_tmp_126 = toNumber(glow.spread)
        if __lux_tmp_126 == nil then
          __lux_tmp_126 = width
        end
        spread = mathMax(1, __lux_tmp_126)
      end
      local grow
      do
        local __lux_tmp_127 = glow.grow
        if __lux_tmp_127 == nil then
          local __lux_tmp_128 = glow.expand
          if __lux_tmp_128 == nil then
            __lux_tmp_128 = glow.shapeSpread
          end
          __lux_tmp_127 = __lux_tmp_128
        end
        local __lux_tmp_129 = toNumber(__lux_tmp_127)
        if __lux_tmp_129 == nil then
          __lux_tmp_129 = 0
        end
        grow = mathMax(0, __lux_tmp_129)
      end
      local strength
      do
        local __lux_tmp_130 = glow.opacity
        if __lux_tmp_130 == nil then
          __lux_tmp_130 = glow.strength
        end
        local __lux_tmp_131 = toNumber(__lux_tmp_130)
        if __lux_tmp_131 == nil then
          __lux_tmp_131 = 1
        end
        strength = __lux_tmp_131
      end
      local falloff
      do
        local __lux_tmp_132 = toNumber(glow.falloff)
        if __lux_tmp_132 == nil then
          __lux_tmp_132 = style.glowSoftnessToFalloff(glow.softness, 0.54)
        end
        falloff = __lux_tmp_132
      end
      local extent = effectExtentRaw(width, falloff, spread, 18)
      local color
      do
        local __lux_tmp_133 = glow.color
        if __lux_tmp_133 == nil then
          __lux_tmp_133 = glow.tint
        end
        color = style.asColor(__lux_tmp_133, defaultOuterGlowColor)
      end
      local alpha
      do
        local __lux_tmp_134 = color.a
        if __lux_tmp_134 == nil then
          __lux_tmp_134 = 255
        end
        alpha = __lux_tmp_134 * inv255
      end
      local __lux_tmp_135 = alpha > 0
      if __lux_tmp_135 then
        __lux_tmp_135 = strength > 0
      end
      local __lux_tmp_136 = color.r
      if __lux_tmp_136 == nil then
        __lux_tmp_136 = 0
      end
      local __lux_tmp_137 = color.g
      if __lux_tmp_137 == nil then
        __lux_tmp_137 = 0
      end
      local __lux_tmp_138 = color.b
      if __lux_tmp_138 == nil then
        __lux_tmp_138 = 0
      end
      return __lux_tmp_135, __lux_tmp_136 * inv255, __lux_tmp_137 * inv255, __lux_tmp_138 * inv255, alpha, x, y, width, spread, grow, strength, falloff, extent, mathAbs(x) + mathAbs(y) + extent + grow
    end
    shadowRaw = function(shadow)
      local __lux_tmp_139 = shadow == nil
      if not __lux_tmp_139 then
        __lux_tmp_139 = shadow == false
      end
      if __lux_tmp_139 then
        return false, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0
      end
      if shadow == true then
        local __lux_tmp_140 = defaultShadowColor.r
        if __lux_tmp_140 == nil then
          __lux_tmp_140 = 0
        end
        local __lux_tmp_141 = defaultShadowColor.g
        if __lux_tmp_141 == nil then
          __lux_tmp_141 = 0
        end
        local __lux_tmp_142 = defaultShadowColor.b
        if __lux_tmp_142 == nil then
          __lux_tmp_142 = 0
        end
        local __lux_tmp_143 = defaultShadowColor.a
        if __lux_tmp_143 == nil then
          __lux_tmp_143 = 255
        end
        return true, __lux_tmp_140 * inv255, __lux_tmp_141 * inv255, __lux_tmp_142 * inv255, __lux_tmp_143 * inv255, 0, 4, 12, 12, 0, 1, defaultShadowFalloff, defaultShadowExtent, defaultShadowCullSpread
      end
      if style.isColor(shadow) then
        local width = 12
        local falloff = defaultShadowFalloff
        local extent = effectExtentRaw(width, falloff, width, 12)
        local alpha
        do
          local __lux_tmp_144 = shadow.a
          if __lux_tmp_144 == nil then
            __lux_tmp_144 = 255
          end
          alpha = __lux_tmp_144 * inv255
        end
        local __lux_tmp_145 = shadow.r
        if __lux_tmp_145 == nil then
          __lux_tmp_145 = 0
        end
        local __lux_tmp_146 = shadow.g
        if __lux_tmp_146 == nil then
          __lux_tmp_146 = 0
        end
        local __lux_tmp_147 = shadow.b
        if __lux_tmp_147 == nil then
          __lux_tmp_147 = 0
        end
        return alpha > 0, __lux_tmp_145 * inv255, __lux_tmp_146 * inv255, __lux_tmp_147 * inv255, alpha, 0, 4, width, width, 0, 1, falloff, extent, 4 + extent
      end
      if typeOf(shadow) ~= "table" then
        local width
        do
          local __lux_tmp_148 = toNumber(shadow)
          if __lux_tmp_148 == nil then
            __lux_tmp_148 = 12
          end
          width = mathMax(0.001, __lux_tmp_148)
        end
        local falloff = defaultShadowFalloff
        local extent = effectExtentRaw(width, falloff, mathMax(1, width), 12)
        local __lux_tmp_149 = defaultShadowColor.r
        if __lux_tmp_149 == nil then
          __lux_tmp_149 = 0
        end
        local __lux_tmp_150 = defaultShadowColor.g
        if __lux_tmp_150 == nil then
          __lux_tmp_150 = 0
        end
        local __lux_tmp_151 = defaultShadowColor.b
        if __lux_tmp_151 == nil then
          __lux_tmp_151 = 0
        end
        local __lux_tmp_152 = defaultShadowColor.a
        if __lux_tmp_152 == nil then
          __lux_tmp_152 = 255
        end
        return true, __lux_tmp_149 * inv255, __lux_tmp_150 * inv255, __lux_tmp_151 * inv255, __lux_tmp_152 * inv255, 0, 4, width, mathMax(1, width), 0, 1, falloff, extent, 4 + extent
      end
      local x, y = effectOffset(shadow, 0, 4)
      local width
      do
        local __lux_tmp_153 = shadow.blur
        if __lux_tmp_153 == nil then
          local __lux_tmp_154 = shadow.radius
          if __lux_tmp_154 == nil then
            local __lux_tmp_155 = shadow.size
            if __lux_tmp_155 == nil then
              __lux_tmp_155 = shadow.width
            end
            __lux_tmp_154 = __lux_tmp_155
          end
          __lux_tmp_153 = __lux_tmp_154
        end
        local __lux_tmp_156 = toNumber(__lux_tmp_153)
        if __lux_tmp_156 == nil then
          __lux_tmp_156 = 12
        end
        width = mathMax(0.001, __lux_tmp_156)
      end
      local grow
      do
        local __lux_tmp_157 = shadow.spread
        if __lux_tmp_157 == nil then
          local __lux_tmp_158 = shadow.grow
          if __lux_tmp_158 == nil then
            local __lux_tmp_159 = shadow.expand
            if __lux_tmp_159 == nil then
              __lux_tmp_159 = shadow.shapeSpread
            end
            __lux_tmp_158 = __lux_tmp_159
          end
          __lux_tmp_157 = __lux_tmp_158
        end
        local __lux_tmp_160 = toNumber(__lux_tmp_157)
        if __lux_tmp_160 == nil then
          __lux_tmp_160 = 0
        end
        grow = mathMax(0, __lux_tmp_160)
      end
      local spread
      do
        local __lux_tmp_161 = shadow.extent
        if __lux_tmp_161 == nil then
          __lux_tmp_161 = shadow.padding
        end
        local __lux_tmp_162 = toNumber(__lux_tmp_161)
        if __lux_tmp_162 == nil then
          __lux_tmp_162 = width
        end
        spread = mathMax(1, __lux_tmp_162)
      end
      local strength
      do
        local __lux_tmp_163 = shadow.opacity
        if __lux_tmp_163 == nil then
          __lux_tmp_163 = shadow.strength
        end
        local __lux_tmp_164 = toNumber(__lux_tmp_163)
        if __lux_tmp_164 == nil then
          __lux_tmp_164 = 1
        end
        strength = __lux_tmp_164
      end
      local falloff
      do
        local __lux_tmp_165 = toNumber(shadow.falloff)
        if __lux_tmp_165 == nil then
          __lux_tmp_165 = style.glowSoftnessToFalloff(shadow.softness, 0.62)
        end
        falloff = __lux_tmp_165
      end
      local extent = effectExtentRaw(width, falloff, spread, 12)
      local color
      do
        local __lux_tmp_166 = shadow.color
        if __lux_tmp_166 == nil then
          __lux_tmp_166 = shadow.tint
        end
        color = style.asColor(__lux_tmp_166, defaultShadowColor)
      end
      local alpha
      do
        local __lux_tmp_167 = color.a
        if __lux_tmp_167 == nil then
          __lux_tmp_167 = 255
        end
        alpha = __lux_tmp_167 * inv255
      end
      local __lux_tmp_168 = alpha > 0
      if __lux_tmp_168 then
        __lux_tmp_168 = strength > 0
      end
      local __lux_tmp_169 = color.r
      if __lux_tmp_169 == nil then
        __lux_tmp_169 = 0
      end
      local __lux_tmp_170 = color.g
      if __lux_tmp_170 == nil then
        __lux_tmp_170 = 0
      end
      local __lux_tmp_171 = color.b
      if __lux_tmp_171 == nil then
        __lux_tmp_171 = 0
      end
      return __lux_tmp_168, __lux_tmp_169 * inv255, __lux_tmp_170 * inv255, __lux_tmp_171 * inv255, alpha, x, y, width, spread, grow, strength, falloff, extent, mathAbs(x) + mathAbs(y) + extent + grow
    end
    patternStyle = function(pattern)
      local __lux_tmp_172 = pattern == nil
      if not __lux_tmp_172 then
        __lux_tmp_172 = pattern == false
      end
      if __lux_tmp_172 then
        return nil
      end
      if pattern == true then
        return style.stripePattern(makeColor(255, 255, 255, 20), 10, 2, 135)
      end
      if typeOf(pattern) == "table" then
        local knownPattern
        local __lux_match_173 = pattern.kind
        if __lux_match_173 == "stripe" or __lux_match_173 == "smoke" then
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
        local __lux_obj_174 = pattern
        local __lux_val_175 = nil
        if __lux_obj_174 ~= nil then
          __lux_val_175 = __lux_obj_174.offset
        end
        local __lux_tmp_176 = toNumber(__lux_val_175)
        if __lux_tmp_176 == nil then
          __lux_tmp_176 = 0
        end
        offset = __lux_tmp_176
      end
      local speed
      do
        local __lux_obj_177 = pattern
        local __lux_val_178 = nil
        if __lux_obj_177 ~= nil then
          __lux_val_178 = __lux_obj_177.speed
        end
        local __lux_tmp_179 = toNumber(__lux_val_178)
        if __lux_tmp_179 == nil then
          __lux_tmp_179 = 0
        end
        speed = __lux_tmp_179
      end
      local __lux_tmp_180 = speed ~= 0
      if __lux_tmp_180 then
        __lux_tmp_180 = realTime ~= nil
      end
      if __lux_tmp_180 then
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
      local __lux_match_181 = fill
      local __lux_tag_182
      if __lux_match_181 ~= nil then
        __lux_tag_182 = __lux_match_181.kind
      end
      if __lux_tag_182 == style.FILL_LINEAR then
        local x1 = __lux_match_181.x1
        local y1 = __lux_match_181.y1
        local x2 = __lux_match_181.x2
        local y2 = __lux_match_181.y2
        do
          local __lux_tmp_183 = x1
          if __lux_tmp_183 == nil then
            __lux_tmp_183 = 0
          end
          p0 = __lux_tmp_183
        end
        do
          local __lux_tmp_184 = y1
          if __lux_tmp_184 == nil then
            __lux_tmp_184 = 0
          end
          p1 = __lux_tmp_184
        end
        do
          local __lux_tmp_185 = x2
          if __lux_tmp_185 == nil then
            __lux_tmp_185 = 1
          end
          p2 = __lux_tmp_185
        end
        do
          local __lux_tmp_186 = y2
          if __lux_tmp_186 == nil then
            __lux_tmp_186 = 1
          end
          p3 = __lux_tmp_186
        end
        style.bindGradientLut(material, fill)
      elseif __lux_tag_182 == style.FILL_RADIAL then
        local cx = __lux_match_181.cx
        local cy = __lux_match_181.cy
        local radius = __lux_match_181.radius
        do
          local __lux_tmp_187 = cx
          if __lux_tmp_187 == nil then
            __lux_tmp_187 = 0.5
          end
          p0 = __lux_tmp_187
        end
        do
          local __lux_tmp_188 = cy
          if __lux_tmp_188 == nil then
            __lux_tmp_188 = 0.5
          end
          p1 = __lux_tmp_188
        end
        do
          local __lux_tmp_189 = radius
          if __lux_tmp_189 == nil then
            __lux_tmp_189 = 0.5
          end
          p2 = __lux_tmp_189
        end
        p3 = 0
        style.bindGradientLut(material, fill)
      elseif __lux_tag_182 == style.FILL_CONIC then
        local cx = __lux_match_181.cx
        local cy = __lux_match_181.cy
        local rotation = __lux_match_181.rotation
        do
          local __lux_tmp_190 = cx
          if __lux_tmp_190 == nil then
            __lux_tmp_190 = 0.5
          end
          p0 = __lux_tmp_190
        end
        do
          local __lux_tmp_191 = cy
          if __lux_tmp_191 == nil then
            __lux_tmp_191 = 0.5
          end
          p1 = __lux_tmp_191
        end
        p2 = style.normalizedRotation(rotation)
        p3 = 0
        style.bindGradientLut(material, fill)
      else
        local __lux_unused_192 = nil
      end
      return p0, p1, p2, p3
    end
    setupParamMatrix = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3)
      local __lux_tmp_193 = material == nil
      if not __lux_tmp_193 then
        __lux_tmp_193 = paramMatrixSetUnpacked == nil
      end
      local __lux_tmp_194 = __lux_tmp_193
      if not __lux_tmp_194 then
        __lux_tmp_194 = matrixCtor == nil
      end
      if __lux_tmp_194 then
        return false
      end
      local matrix = paramMatrices[material]
      if matrix == nil then
        matrix = matrixCtor()
        paramMatrices[material] = matrix
      end
      do
        local __lux_tmp_195 = a0
        if __lux_tmp_195 == nil then
          __lux_tmp_195 = 0
        end
        local __lux_tmp_196 = b0
        if __lux_tmp_196 == nil then
          __lux_tmp_196 = 0
        end
        local __lux_tmp_197 = c0
        if __lux_tmp_197 == nil then
          __lux_tmp_197 = 0
        end
        local __lux_tmp_198 = d0
        if __lux_tmp_198 == nil then
          __lux_tmp_198 = 0
        end
        local __lux_tmp_199 = a1
        if __lux_tmp_199 == nil then
          __lux_tmp_199 = 0
        end
        local __lux_tmp_200 = b1
        if __lux_tmp_200 == nil then
          __lux_tmp_200 = 0
        end
        local __lux_tmp_201 = c1
        if __lux_tmp_201 == nil then
          __lux_tmp_201 = 0
        end
        local __lux_tmp_202 = d1
        if __lux_tmp_202 == nil then
          __lux_tmp_202 = 0
        end
        local __lux_tmp_203 = a2
        if __lux_tmp_203 == nil then
          __lux_tmp_203 = 0
        end
        local __lux_tmp_204 = b2
        if __lux_tmp_204 == nil then
          __lux_tmp_204 = 0
        end
        local __lux_tmp_205 = c2
        if __lux_tmp_205 == nil then
          __lux_tmp_205 = 0
        end
        local __lux_tmp_206 = d2
        if __lux_tmp_206 == nil then
          __lux_tmp_206 = 0
        end
        local __lux_tmp_207 = a3
        if __lux_tmp_207 == nil then
          __lux_tmp_207 = 0
        end
        local __lux_tmp_208 = b3
        if __lux_tmp_208 == nil then
          __lux_tmp_208 = 0
        end
        local __lux_tmp_209 = c3
        if __lux_tmp_209 == nil then
          __lux_tmp_209 = 0
        end
        local __lux_tmp_210 = d3
        if __lux_tmp_210 == nil then
          __lux_tmp_210 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_195,
          __lux_tmp_196,
          __lux_tmp_197,
          __lux_tmp_198,
          __lux_tmp_199,
          __lux_tmp_200,
          __lux_tmp_201,
          __lux_tmp_202,
          __lux_tmp_203,
          __lux_tmp_204,
          __lux_tmp_205,
          __lux_tmp_206,
          __lux_tmp_207,
          __lux_tmp_208,
          __lux_tmp_209,
          __lux_tmp_210
        )
      end
      material:SetMatrix("$viewprojmat", matrix)
      return true
    end
    setupParamMatrixRaw = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3)
      local state = paramMatrixRawState[material]
      local __lux_tmp_211 = state ~= nil
      if __lux_tmp_211 then
        __lux_tmp_211 = state[1] == a0
      end
      local __lux_tmp_212 = __lux_tmp_211
      if __lux_tmp_212 then
        __lux_tmp_212 = state[2] == a1
      end
      local __lux_tmp_213 = __lux_tmp_212
      if __lux_tmp_213 then
        __lux_tmp_213 = state[3] == a2
      end
      local __lux_tmp_214 = __lux_tmp_213
      if __lux_tmp_214 then
        __lux_tmp_214 = state[4] == a3
      end
      local __lux_tmp_215 = __lux_tmp_214
      if __lux_tmp_215 then
        __lux_tmp_215 = state[5] == b0
      end
      local __lux_tmp_216 = __lux_tmp_215
      if __lux_tmp_216 then
        __lux_tmp_216 = state[6] == b1
      end
      local __lux_tmp_217 = __lux_tmp_216
      if __lux_tmp_217 then
        __lux_tmp_217 = state[7] == b2
      end
      local __lux_tmp_218 = __lux_tmp_217
      if __lux_tmp_218 then
        __lux_tmp_218 = state[8] == b3
      end
      local __lux_tmp_219 = __lux_tmp_218
      if __lux_tmp_219 then
        __lux_tmp_219 = state[9] == c0
      end
      local __lux_tmp_220 = __lux_tmp_219
      if __lux_tmp_220 then
        __lux_tmp_220 = state[10] == c1
      end
      local __lux_tmp_221 = __lux_tmp_220
      if __lux_tmp_221 then
        __lux_tmp_221 = state[11] == c2
      end
      local __lux_tmp_222 = __lux_tmp_221
      if __lux_tmp_222 then
        __lux_tmp_222 = state[12] == c3
      end
      local __lux_tmp_223 = __lux_tmp_222
      if __lux_tmp_223 then
        __lux_tmp_223 = state[13] == d0
      end
      local __lux_tmp_224 = __lux_tmp_223
      if __lux_tmp_224 then
        __lux_tmp_224 = state[14] == d1
      end
      local __lux_tmp_225 = __lux_tmp_224
      if __lux_tmp_225 then
        __lux_tmp_225 = state[15] == d2
      end
      local __lux_tmp_226 = __lux_tmp_225
      if __lux_tmp_226 then
        __lux_tmp_226 = state[16] == d3
      end
      if __lux_tmp_226 then
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
      local __lux_tmp_227 = material == nil
      if not __lux_tmp_227 then
        __lux_tmp_227 = paramMatrixSetUnpacked == nil
      end
      local __lux_tmp_228 = __lux_tmp_227
      if not __lux_tmp_228 then
        __lux_tmp_228 = matrixCtor == nil
      end
      if __lux_tmp_228 then
        return false
      end
      local matrix = auxParamMatrices[material]
      if matrix == nil then
        matrix = matrixCtor()
        auxParamMatrices[material] = matrix
      end
      do
        local __lux_tmp_229 = a0
        if __lux_tmp_229 == nil then
          __lux_tmp_229 = 0
        end
        local __lux_tmp_230 = b0
        if __lux_tmp_230 == nil then
          __lux_tmp_230 = 0
        end
        local __lux_tmp_231 = c0
        if __lux_tmp_231 == nil then
          __lux_tmp_231 = 0
        end
        local __lux_tmp_232 = d0
        if __lux_tmp_232 == nil then
          __lux_tmp_232 = 0
        end
        local __lux_tmp_233 = a1
        if __lux_tmp_233 == nil then
          __lux_tmp_233 = 0
        end
        local __lux_tmp_234 = b1
        if __lux_tmp_234 == nil then
          __lux_tmp_234 = 0
        end
        local __lux_tmp_235 = c1
        if __lux_tmp_235 == nil then
          __lux_tmp_235 = 0
        end
        local __lux_tmp_236 = d1
        if __lux_tmp_236 == nil then
          __lux_tmp_236 = 0
        end
        local __lux_tmp_237 = a2
        if __lux_tmp_237 == nil then
          __lux_tmp_237 = 0
        end
        local __lux_tmp_238 = b2
        if __lux_tmp_238 == nil then
          __lux_tmp_238 = 0
        end
        local __lux_tmp_239 = c2
        if __lux_tmp_239 == nil then
          __lux_tmp_239 = 0
        end
        local __lux_tmp_240 = d2
        if __lux_tmp_240 == nil then
          __lux_tmp_240 = 0
        end
        local __lux_tmp_241 = a3
        if __lux_tmp_241 == nil then
          __lux_tmp_241 = 0
        end
        local __lux_tmp_242 = b3
        if __lux_tmp_242 == nil then
          __lux_tmp_242 = 0
        end
        local __lux_tmp_243 = c3
        if __lux_tmp_243 == nil then
          __lux_tmp_243 = 0
        end
        local __lux_tmp_244 = d3
        if __lux_tmp_244 == nil then
          __lux_tmp_244 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
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
          __lux_tmp_239,
          __lux_tmp_240,
          __lux_tmp_241,
          __lux_tmp_242,
          __lux_tmp_243,
          __lux_tmp_244
        )
      end
      material:SetMatrix("$invviewprojmat", matrix)
      return true
    end
    setupAuxConstantsRaw = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3)
      local state = auxParamMatrixRawState[material]
      local __lux_tmp_245 = state ~= nil
      if __lux_tmp_245 then
        __lux_tmp_245 = state[1] == a0
      end
      local __lux_tmp_246 = __lux_tmp_245
      if __lux_tmp_246 then
        __lux_tmp_246 = state[2] == a1
      end
      local __lux_tmp_247 = __lux_tmp_246
      if __lux_tmp_247 then
        __lux_tmp_247 = state[3] == a2
      end
      local __lux_tmp_248 = __lux_tmp_247
      if __lux_tmp_248 then
        __lux_tmp_248 = state[4] == a3
      end
      local __lux_tmp_249 = __lux_tmp_248
      if __lux_tmp_249 then
        __lux_tmp_249 = state[5] == b0
      end
      local __lux_tmp_250 = __lux_tmp_249
      if __lux_tmp_250 then
        __lux_tmp_250 = state[6] == b1
      end
      local __lux_tmp_251 = __lux_tmp_250
      if __lux_tmp_251 then
        __lux_tmp_251 = state[7] == b2
      end
      local __lux_tmp_252 = __lux_tmp_251
      if __lux_tmp_252 then
        __lux_tmp_252 = state[8] == b3
      end
      local __lux_tmp_253 = __lux_tmp_252
      if __lux_tmp_253 then
        __lux_tmp_253 = state[9] == c0
      end
      local __lux_tmp_254 = __lux_tmp_253
      if __lux_tmp_254 then
        __lux_tmp_254 = state[10] == c1
      end
      local __lux_tmp_255 = __lux_tmp_254
      if __lux_tmp_255 then
        __lux_tmp_255 = state[11] == c2
      end
      local __lux_tmp_256 = __lux_tmp_255
      if __lux_tmp_256 then
        __lux_tmp_256 = state[12] == c3
      end
      local __lux_tmp_257 = __lux_tmp_256
      if __lux_tmp_257 then
        __lux_tmp_257 = state[13] == d0
      end
      local __lux_tmp_258 = __lux_tmp_257
      if __lux_tmp_258 then
        __lux_tmp_258 = state[14] == d1
      end
      local __lux_tmp_259 = __lux_tmp_258
      if __lux_tmp_259 then
        __lux_tmp_259 = state[15] == d2
      end
      local __lux_tmp_260 = __lux_tmp_259
      if __lux_tmp_260 then
        __lux_tmp_260 = state[16] == d3
      end
      if __lux_tmp_260 then
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
        local __lux_tmp_261 = fill
        if __lux_tmp_261 == nil then
          __lux_tmp_261 = style.solid(color_white)
        end
        fill = __lux_tmp_261
      end
      local colorA
      do
        local __lux_tmp_262 = fill.colorA
        if __lux_tmp_262 == nil then
          __lux_tmp_262 = color_white
        end
        colorA = __lux_tmp_262
      end
      local colorB
      do
        local __lux_tmp_263 = fill.colorB
        if __lux_tmp_263 == nil then
          __lux_tmp_263 = colorA
        end
        colorB = __lux_tmp_263
      end
      local strokeColor
      do
        local __lux_tmp_264 = stroke
        if __lux_tmp_264 == nil then
          __lux_tmp_264 = transparentColor
        end
        strokeColor = __lux_tmp_264
      end
      local fillKind
      do
        local __lux_tmp_265 = fill.kind
        if __lux_tmp_265 == nil then
          __lux_tmp_265 = style.FILL_SOLID
        end
        fillKind = __lux_tmp_265
      end
      local packedStyle = mathClamp(style.strokeWidth(strokeWidth, 0), 0, 255) + mathClamp(fillKind, 0, 3) * 256
      local r, g, b, a = style.color01(colorB)
      local p0, p1, p2, p3 = roundRectFillParams(material, fill)
      local sr, sg, sb, sa = style.color01(strokeColor)
      do
        local __lux_tmp_266 = toNumber(radius)
        if __lux_tmp_266 == nil then
          __lux_tmp_266 = 0
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
          mathMax(0, __lux_tmp_266),
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
        local __lux_tmp_267 = fill
        if __lux_tmp_267 == nil then
          __lux_tmp_267 = style.solid(color_white)
        end
        fill = __lux_tmp_267
      end
      local colorB
      do
        local __lux_tmp_268 = fill.colorB
        if __lux_tmp_268 == nil then
          local __lux_tmp_269 = fill.colorA
          if __lux_tmp_269 == nil then
            __lux_tmp_269 = color_white
          end
          __lux_tmp_268 = __lux_tmp_269
        end
        colorB = __lux_tmp_268
      end
      local fillKind
      do
        local __lux_tmp_270 = fill.kind
        if __lux_tmp_270 == nil then
          __lux_tmp_270 = style.FILL_SOLID
        end
        fillKind = __lux_tmp_270
      end
      local strokePx
      if stroke ~= nil then
        strokePx = strokeWidth
      else
        strokePx = 0
      end
      local __lux_tmp_271 = strokePx <= 0
      if not __lux_tmp_271 then
        local __lux_tmp_272 = stroke ~= nil
        if __lux_tmp_272 then
          __lux_tmp_272 = stroke.a ~= nil
        end
        local __lux_tmp_273 = __lux_tmp_272
        if __lux_tmp_273 then
          __lux_tmp_273 = stroke.a <= 0
        end
        __lux_tmp_271 = __lux_tmp_273
      end
      if __lux_tmp_271 then
        strokePx = 0
      else
        if strokePx > 255 then
          strokePx = 255
        end
      end
      local r
      do
        local __lux_tmp_274 = colorB.r
        if __lux_tmp_274 == nil then
          __lux_tmp_274 = 0
        end
        r = __lux_tmp_274 * inv255
      end
      local g
      do
        local __lux_tmp_275 = colorB.g
        if __lux_tmp_275 == nil then
          __lux_tmp_275 = 0
        end
        g = __lux_tmp_275 * inv255
      end
      local b
      do
        local __lux_tmp_276 = colorB.b
        if __lux_tmp_276 == nil then
          __lux_tmp_276 = 0
        end
        b = __lux_tmp_276 * inv255
      end
      local a
      do
        local __lux_tmp_277 = colorB.a
        if __lux_tmp_277 == nil then
          __lux_tmp_277 = 255
        end
        a = __lux_tmp_277 * inv255
      end
      local p0, p1, p2, p3 = roundRectFillParams(material, fill)
      local sr = 0
      local sg = 0
      local sb = 0
      local sa = 0
      if strokePx > 0 then
        do
          local __lux_tmp_278 = stroke.r
          if __lux_tmp_278 == nil then
            __lux_tmp_278 = 0
          end
          sr = __lux_tmp_278 * inv255
        end
        do
          local __lux_tmp_279 = stroke.g
          if __lux_tmp_279 == nil then
            __lux_tmp_279 = 0
          end
          sg = __lux_tmp_279 * inv255
        end
        do
          local __lux_tmp_280 = stroke.b
          if __lux_tmp_280 == nil then
            __lux_tmp_280 = 0
          end
          sb = __lux_tmp_280 * inv255
        end
        do
          local __lux_tmp_281 = stroke.a
          if __lux_tmp_281 == nil then
            __lux_tmp_281 = 255
          end
          sa = __lux_tmp_281 * inv255
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
        local __lux_tmp_282 = pattern.color
        if __lux_tmp_282 == nil then
          __lux_tmp_282 = pattern.tint
        end
        color = style.asColor(__lux_tmp_282, makeColor(255, 255, 255, 24))
      end
      local r, g, b, a = style.color01(color)
      local angle
      do
        local __lux_tmp_283 = toNumber(pattern.angle)
        if __lux_tmp_283 == nil then
          __lux_tmp_283 = 135
        end
        angle = mathRad(__lux_tmp_283)
      end
      local smoke
      local __lux_match_284 = pattern.kind
      if __lux_match_284 == "smoke" then
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
          local __lux_tmp_285 = toNumber(pattern.scale)
          if __lux_tmp_285 == nil then
            __lux_tmp_285 = 140
          end
          pz = mathMax(1, __lux_tmp_285)
        end
        do
          local __lux_tmp_286 = toNumber(pattern.density)
          if __lux_tmp_286 == nil then
            __lux_tmp_286 = 0.48
          end
          pw = mathClamp(__lux_tmp_286, 0, 1)
        end
        ox = patternOffset(pattern)
        oy = 1
        do
          local __lux_tmp_287 = toNumber(pattern.softness)
          if __lux_tmp_287 == nil then
            __lux_tmp_287 = 0.3
          end
          oz = mathMax(0.001, __lux_tmp_287)
        end
        do
          local __lux_tmp_288 = toNumber(pattern.warp)
          if __lux_tmp_288 == nil then
            __lux_tmp_288 = 0.85
          end
          ow = mathMax(0, __lux_tmp_288)
        end
      else
        do
          local __lux_tmp_289 = toNumber(pattern.spacing)
          if __lux_tmp_289 == nil then
            __lux_tmp_289 = 12
          end
          pz = mathMax(1, __lux_tmp_289)
        end
        do
          local __lux_tmp_290 = toNumber(pattern.width)
          if __lux_tmp_290 == nil then
            __lux_tmp_290 = 2
          end
          pw = mathMax(0.25, __lux_tmp_290)
        end
        ox = patternOffset(pattern)
      end
      local __lux_tmp_291
      if smoke then
        do
          local __lux_tmp_292 = toNumber(pattern.seed)
          if __lux_tmp_292 == nil then
            __lux_tmp_292 = 0
          end
          __lux_tmp_291 = __lux_tmp_292
        end
      else
        __lux_tmp_291 = 0
      end
      local __lux_tmp_293 = toNumber(radius)
      if __lux_tmp_293 == nil then
        __lux_tmp_293 = 0
      end
      return setupParamMatrix(
        material,
        r,
        g,
        b,
        a,
        w,
        h,
        __lux_tmp_291,
        mathMax(0, __lux_tmp_293),
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
        local __lux_tmp_294 = fill.colorA
        if __lux_tmp_294 == nil then
          __lux_tmp_294 = color_white
        end
        color = __lux_tmp_294
      end
      do
        local __lux_tmp_295 = color.r
        if __lux_tmp_295 == nil then
          __lux_tmp_295 = 255
        end
        local __lux_tmp_296 = color.g
        if __lux_tmp_296 == nil then
          __lux_tmp_296 = 255
        end
        local __lux_tmp_297 = color.b
        if __lux_tmp_297 == nil then
          __lux_tmp_297 = 255
        end
        local __lux_tmp_298 = color.a
        if __lux_tmp_298 == nil then
          __lux_tmp_298 = 255
        end
        surfaceSetDrawColor(__lux_tmp_295, __lux_tmp_296, __lux_tmp_297, __lux_tmp_298)
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
        local __lux_tmp_299 = fill.colorA
        if __lux_tmp_299 == nil then
          __lux_tmp_299 = color_white
        end
        color = __lux_tmp_299
      end
      do
        local __lux_tmp_300 = color.r
        if __lux_tmp_300 == nil then
          __lux_tmp_300 = 0
        end
        local __lux_tmp_301 = color.g
        if __lux_tmp_301 == nil then
          __lux_tmp_301 = 0
        end
        local __lux_tmp_302 = color.b
        if __lux_tmp_302 == nil then
          __lux_tmp_302 = 0
        end
        local __lux_tmp_303 = color.a
        if __lux_tmp_303 == nil then
          __lux_tmp_303 = 255
        end
        setupParamMatrixRaw(
          material,
          __lux_tmp_300 * inv255,
          __lux_tmp_301 * inv255,
          __lux_tmp_302 * inv255,
          __lux_tmp_303 * inv255,
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
      local __lux_tmp_304 = spec == nil
      if not __lux_tmp_304 then
        __lux_tmp_304 = not shadersActive()
      end
      local __lux_tmp_305 = __lux_tmp_304
      if not __lux_tmp_305 then
        __lux_tmp_305 = not materialOK(roundRectMaterials.roundrect_pattern)
      end
      if __lux_tmp_305 then
        return false
      end
      local color
      do
        local __lux_tmp_306 = spec.color
        if __lux_tmp_306 == nil then
          __lux_tmp_306 = spec.tint
        end
        color = __lux_tmp_306
      end
      local __lux_tmp_307 = color ~= nil
      if __lux_tmp_307 then
        local __lux_tmp_308 = color.a
        if __lux_tmp_308 == nil then
          __lux_tmp_308 = 255
        end
        __lux_tmp_307 = __lux_tmp_308 <= 0
      end
      if __lux_tmp_307 then
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
        local __lux_tmp_309 = toNumber(grow)
        if __lux_tmp_309 == nil then
          __lux_tmp_309 = 0
        end
        grow = mathMax(0, __lux_tmp_309)
      end
      if grow <= 0 then
        return radius
      end
      local __lux_tmp_310 = typeOf(radius) == "table"
      if __lux_tmp_310 then
        __lux_tmp_310 = not style.isColor(radius)
      end
      if __lux_tmp_310 then
        local __lux_tmp_311 = radius.tl
        if __lux_tmp_311 == nil then
          __lux_tmp_311 = radius[1]
        end
        local __lux_tmp_312 = toNumber(__lux_tmp_311)
        if __lux_tmp_312 == nil then
          __lux_tmp_312 = 0
        end
        local __lux_tmp_313 = radius.tr
        if __lux_tmp_313 == nil then
          local __lux_tmp_314 = radius[2]
          if __lux_tmp_314 == nil then
            local __lux_tmp_315 = radius.tl
            if __lux_tmp_315 == nil then
              __lux_tmp_315 = radius[1]
            end
            __lux_tmp_314 = __lux_tmp_315
          end
          __lux_tmp_313 = __lux_tmp_314
        end
        local __lux_tmp_316 = toNumber(__lux_tmp_313)
        if __lux_tmp_316 == nil then
          __lux_tmp_316 = 0
        end
        local __lux_tmp_317 = radius.br
        if __lux_tmp_317 == nil then
          local __lux_tmp_318 = radius[3]
          if __lux_tmp_318 == nil then
            local __lux_tmp_319 = radius.tr
            if __lux_tmp_319 == nil then
              local __lux_tmp_320 = radius[2]
              if __lux_tmp_320 == nil then
                local __lux_tmp_321 = radius.tl
                if __lux_tmp_321 == nil then
                  __lux_tmp_321 = radius[1]
                end
                __lux_tmp_320 = __lux_tmp_321
              end
              __lux_tmp_319 = __lux_tmp_320
            end
            __lux_tmp_318 = __lux_tmp_319
          end
          __lux_tmp_317 = __lux_tmp_318
        end
        local __lux_tmp_322 = toNumber(__lux_tmp_317)
        if __lux_tmp_322 == nil then
          __lux_tmp_322 = 0
        end
        local __lux_tmp_323 = radius.bl
        if __lux_tmp_323 == nil then
          local __lux_tmp_324 = radius[4]
          if __lux_tmp_324 == nil then
            local __lux_tmp_325 = radius.br
            if __lux_tmp_325 == nil then
              local __lux_tmp_326 = radius[3]
              if __lux_tmp_326 == nil then
                local __lux_tmp_327 = radius.tr
                if __lux_tmp_327 == nil then
                  local __lux_tmp_328 = radius[2]
                  if __lux_tmp_328 == nil then
                    local __lux_tmp_329 = radius.tl
                    if __lux_tmp_329 == nil then
                      __lux_tmp_329 = radius[1]
                    end
                    __lux_tmp_328 = __lux_tmp_329
                  end
                  __lux_tmp_327 = __lux_tmp_328
                end
                __lux_tmp_326 = __lux_tmp_327
              end
              __lux_tmp_325 = __lux_tmp_326
            end
            __lux_tmp_324 = __lux_tmp_325
          end
          __lux_tmp_323 = __lux_tmp_324
        end
        local __lux_tmp_330 = toNumber(__lux_tmp_323)
        if __lux_tmp_330 == nil then
          __lux_tmp_330 = 0
        end
        return {
          tl = mathMax(0, __lux_tmp_312) + grow,
          tr = mathMax(0, __lux_tmp_316) + grow,
          br = mathMax(0, __lux_tmp_322) + grow,
          bl = mathMax(0, __lux_tmp_330) + grow,
        }
      end
      local __lux_tmp_331 = toNumber(radius)
      if __lux_tmp_331 == nil then
        __lux_tmp_331 = 0
      end
      return __lux_tmp_331 + grow
    end
    drawRoundRectInnerGlowRaw = function(x, y, w, h, radius, enabled, gr, gg, gb, ga, glowWidth, glowStrength, glowFalloff)
      local __lux_tmp_332 = not enabled
      if not __lux_tmp_332 then
        __lux_tmp_332 = ga <= 0
      end
      local __lux_tmp_333 = __lux_tmp_332
      if not __lux_tmp_333 then
        __lux_tmp_333 = glowStrength <= 0
      end
      local __lux_tmp_334 = __lux_tmp_333
      if not __lux_tmp_334 then
        __lux_tmp_334 = not shadersActive()
      end
      local __lux_tmp_335 = __lux_tmp_334
      if not __lux_tmp_335 then
        __lux_tmp_335 = not materialOK(roundRectMaterials.roundrect_innerglow)
      end
      if __lux_tmp_335 then
        return false
      end
      local material = roundRectMaterials.roundrect_innerglow
      local setupTrace = roundRectTraceStart("round.innerGlow.setup")
      setupParamMatrixRaw(
        material,
        gr,
        gg,
        gb,
        ga,
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
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      roundRectTraceEnd(setupTrace)
      local drawTrace = roundRectTraceStart("round.innerGlow.draw")
      drawTexturedQuad(x, y, w, h, material)
      roundRectTraceEnd(drawTrace)
      return true
    end
    drawRoundRectShadowOuterRaw = function(x, y, w, h, radius, hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowExtent, shadowGrow, shadowStrength, shadowFalloff, hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerExtent, outerGrow, outerStrength, outerFalloff)
      do
        local __lux_tmp_336 = hasShadow
        if __lux_tmp_336 then
          __lux_tmp_336 = sa > 0
        end
        local __lux_tmp_337 = __lux_tmp_336
        if __lux_tmp_337 then
          __lux_tmp_337 = shadowStrength > 0
        end
        hasShadow = __lux_tmp_337
      end
      do
        local __lux_tmp_338 = hasOuter
        if __lux_tmp_338 then
          __lux_tmp_338 = oa > 0
        end
        local __lux_tmp_339 = __lux_tmp_338
        if __lux_tmp_339 then
          __lux_tmp_339 = outerStrength > 0
        end
        hasOuter = __lux_tmp_339
      end
      local __lux_tmp_340 = not hasShadow
      if __lux_tmp_340 then
        __lux_tmp_340 = not hasOuter
      end
      if __lux_tmp_340 then
        return false
      end
      local __lux_tmp_341 = not shadersActive()
      if not __lux_tmp_341 then
        __lux_tmp_341 = not materialOK(roundRectMaterials.roundrect_shadow_outer)
      end
      if __lux_tmp_341 then
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
      do
        local __lux_tmp_342 = shadowGrow
        if __lux_tmp_342 == nil then
          __lux_tmp_342 = 0
        end
        shadowGrow = mathMax(0, __lux_tmp_342)
      end
      do
        local __lux_tmp_343 = outerGrow
        if __lux_tmp_343 == nil then
          __lux_tmp_343 = 0
        end
        outerGrow = mathMax(0, __lux_tmp_343)
      end
      do
        local __lux_tmp_344 = shadowX
        if __lux_tmp_344 == nil then
          __lux_tmp_344 = 0
        end
        shadowX = __lux_tmp_344
      end
      do
        local __lux_tmp_345 = shadowY
        if __lux_tmp_345 == nil then
          __lux_tmp_345 = 0
        end
        shadowY = __lux_tmp_345
      end
      do
        local __lux_tmp_346 = outerX
        if __lux_tmp_346 == nil then
          __lux_tmp_346 = 0
        end
        outerX = __lux_tmp_346
      end
      do
        local __lux_tmp_347 = outerY
        if __lux_tmp_347 == nil then
          __lux_tmp_347 = 0
        end
        outerY = __lux_tmp_347
      end
      do
        local __lux_tmp_348 = shadowWidth
        if __lux_tmp_348 == nil then
          __lux_tmp_348 = 1
        end
        shadowWidth = mathMax(0.001, __lux_tmp_348)
      end
      do
        local __lux_tmp_349 = outerWidth
        if __lux_tmp_349 == nil then
          __lux_tmp_349 = 1
        end
        outerWidth = mathMax(0.001, __lux_tmp_349)
      end
      do
        local __lux_tmp_350 = shadowExtent
        if __lux_tmp_350 == nil then
          __lux_tmp_350 = shadowWidth
        end
        shadowExtent = mathMax(1, __lux_tmp_350)
      end
      do
        local __lux_tmp_351 = outerExtent
        if __lux_tmp_351 == nil then
          __lux_tmp_351 = outerWidth
        end
        outerExtent = mathMax(1, __lux_tmp_351)
      end
      do
        local __lux_tmp_352 = shadowStrength
        if __lux_tmp_352 == nil then
          __lux_tmp_352 = 0
        end
        shadowStrength = mathMax(0, __lux_tmp_352)
      end
      do
        local __lux_tmp_353 = outerStrength
        if __lux_tmp_353 == nil then
          __lux_tmp_353 = 0
        end
        outerStrength = mathMax(0, __lux_tmp_353)
      end
      do
        local __lux_tmp_354 = shadowFalloff
        if __lux_tmp_354 == nil then
          __lux_tmp_354 = 1
        end
        shadowFalloff = mathMax(0.001, __lux_tmp_354)
      end
      do
        local __lux_tmp_355 = outerFalloff
        if __lux_tmp_355 == nil then
          __lux_tmp_355 = 1
        end
        outerFalloff = mathMax(0.001, __lux_tmp_355)
      end
      local shadowGw = w + shadowGrow * 2
      local shadowGh = h + shadowGrow * 2
      local shadowShapeX = x + shadowX - shadowGrow
      local shadowShapeY = y + shadowY - shadowGrow
      local shadowDrawX = shadowShapeX - shadowExtent
      local shadowDrawY = shadowShapeY - shadowExtent
      local shadowDrawW = shadowGw + shadowExtent * 2
      local shadowDrawH = shadowGh + shadowExtent * 2
      local outerGw = w + outerGrow * 2
      local outerGh = h + outerGrow * 2
      local outerLeft, outerTop, outerRight, outerBottom = glowBiasPads(outerExtent, outerX, outerY)
      local outerShapeX = x - outerGrow
      local outerShapeY = y - outerGrow
      local outerDrawX = outerShapeX - outerLeft
      local outerDrawY = outerShapeY - outerTop
      local outerDrawW = outerGw + outerLeft + outerRight
      local outerDrawH = outerGh + outerTop + outerBottom
      local sx = nil
      local sy = nil
      local ex = nil
      local ey = nil
      if hasShadow then
        sx = shadowDrawX
        sy = shadowDrawY
        ex = shadowDrawX + shadowDrawW
        ey = shadowDrawY + shadowDrawH
      end
      if hasOuter then
        if sx == nil then
          sx = outerDrawX
          sy = outerDrawY
          ex = outerDrawX + outerDrawW
          ey = outerDrawY + outerDrawH
        else
          sx = mathMin(sx, outerDrawX)
          sy = mathMin(sy, outerDrawY)
          ex = mathMax(ex, outerDrawX + outerDrawW)
          ey = mathMax(ey, outerDrawY + outerDrawH)
        end
      end
      local sw = ex - sx
      local sh = ey - sy
      local material = roundRectMaterials.roundrect_shadow_outer
      do
        local __lux_tmp_356
        if hasShadow then
          __lux_tmp_356 = sr
        else
          __lux_tmp_356 = 0
        end
        local __lux_tmp_357
        if hasShadow then
          __lux_tmp_357 = sg
        else
          __lux_tmp_357 = 0
        end
        local __lux_tmp_358
        if hasShadow then
          __lux_tmp_358 = sb
        else
          __lux_tmp_358 = 0
        end
        local __lux_tmp_359
        if hasShadow then
          __lux_tmp_359 = sa
        else
          __lux_tmp_359 = 0
        end
        local __lux_tmp_360
        if hasShadow then
          __lux_tmp_360 = shadowWidth
        else
          __lux_tmp_360 = 1
        end
        local __lux_tmp_361
        if hasShadow then
          __lux_tmp_361 = shadowStrength
        else
          __lux_tmp_361 = 0
        end
        local __lux_tmp_362
        if hasShadow then
          __lux_tmp_362 = shadowFalloff
        else
          __lux_tmp_362 = 1
        end
        setupParamMatrixRaw(
          material,
          sw,
          sh,
          0,
          0,
          __lux_tmp_356,
          __lux_tmp_357,
          __lux_tmp_358,
          __lux_tmp_359,
          shadowShapeX - sx,
          shadowShapeY - sy,
          shadowGw,
          shadowGh,
          roundRectRadiusScalar(radiusWithGrow(radius, shadowGrow), shadowGw, shadowGh),
          __lux_tmp_360,
          __lux_tmp_361,
          __lux_tmp_362
        )
      end
      do
        local __lux_tmp_363
        if hasOuter then
          __lux_tmp_363 = orr
        else
          __lux_tmp_363 = 0
        end
        local __lux_tmp_364
        if hasOuter then
          __lux_tmp_364 = og
        else
          __lux_tmp_364 = 0
        end
        local __lux_tmp_365
        if hasOuter then
          __lux_tmp_365 = ob
        else
          __lux_tmp_365 = 0
        end
        local __lux_tmp_366
        if hasOuter then
          __lux_tmp_366 = oa
        else
          __lux_tmp_366 = 0
        end
        local __lux_tmp_367
        if hasOuter then
          __lux_tmp_367 = outerWidth
        else
          __lux_tmp_367 = 1
        end
        local __lux_tmp_368
        if hasOuter then
          __lux_tmp_368 = outerStrength
        else
          __lux_tmp_368 = 0
        end
        local __lux_tmp_369
        if hasOuter then
          __lux_tmp_369 = outerFalloff
        else
          __lux_tmp_369 = 1
        end
        setupAuxConstantsRaw(
          material,
          __lux_tmp_363,
          __lux_tmp_364,
          __lux_tmp_365,
          __lux_tmp_366,
          outerShapeX - sx,
          outerShapeY - sy,
          outerGw,
          outerGh,
          roundRectRadiusScalar(radiusWithGrow(radius, outerGrow), outerGw, outerGh),
          __lux_tmp_367,
          __lux_tmp_368,
          __lux_tmp_369,
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
        local __lux_tmp_370
        if profiling then
          __lux_tmp_370 = roundRectProfileStart()
        else
          __lux_tmp_370 = nil
        end
        bleedProfile = __lux_tmp_370
      end
      bleedTrace = roundRectTraceStart("round.shadowOuter.bleedEnd")
      endPanelEffectBleed(bleedToken)
      roundRectTraceEnd(bleedTrace)
      if profiling then
        roundRectProfileEnd("round.shadowOuter.bleedEnd", bleedProfile)
      end
      return true
    end
    drawRoundRectFusedRaw = function(x, y, w, h, radius, fill, stroke, strokeWidth, radiusValue, hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowExtent, shadowGrow, shadowStrength, shadowFalloff, hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerExtent, outerGrow, outerStrength, outerFalloff)
      local __lux_tmp_371 = w <= 0
      if not __lux_tmp_371 then
        __lux_tmp_371 = h <= 0
      end
      if __lux_tmp_371 then
        return false
      end
      if drawTexturedQuadUV == nil then
        return false
      end
      local __lux_tmp_372 = not shadersActive()
      if not __lux_tmp_372 then
        __lux_tmp_372 = not materialOK(roundRectMaterials.roundrect_fused)
      end
      if __lux_tmp_372 then
        return false
      end
      do
        local __lux_tmp_373 = hasShadow
        if __lux_tmp_373 then
          __lux_tmp_373 = sa > 0
        end
        local __lux_tmp_374 = __lux_tmp_373
        if __lux_tmp_374 then
          __lux_tmp_374 = shadowStrength > 0
        end
        hasShadow = __lux_tmp_374
      end
      do
        local __lux_tmp_375 = hasOuter
        if __lux_tmp_375 then
          __lux_tmp_375 = oa > 0
        end
        local __lux_tmp_376 = __lux_tmp_375
        if __lux_tmp_376 then
          __lux_tmp_376 = outerStrength > 0
        end
        hasOuter = __lux_tmp_376
      end
      local __lux_tmp_377 = not hasShadow
      if __lux_tmp_377 then
        __lux_tmp_377 = not hasOuter
      end
      if __lux_tmp_377 then
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
      do
        local __lux_tmp_378 = shadowX
        if __lux_tmp_378 == nil then
          __lux_tmp_378 = 0
        end
        shadowX = __lux_tmp_378
      end
      do
        local __lux_tmp_379 = shadowY
        if __lux_tmp_379 == nil then
          __lux_tmp_379 = 0
        end
        shadowY = __lux_tmp_379
      end
      do
        local __lux_tmp_380 = outerX
        if __lux_tmp_380 == nil then
          __lux_tmp_380 = 0
        end
        outerX = __lux_tmp_380
      end
      do
        local __lux_tmp_381 = outerY
        if __lux_tmp_381 == nil then
          __lux_tmp_381 = 0
        end
        outerY = __lux_tmp_381
      end
      local sx = x
      local sy = y
      local ex = x + w
      local ey = y + h
      do
        local __lux_tmp_382
        if hasShadow then
          do
            local __lux_tmp_383 = shadowGrow
            if __lux_tmp_383 == nil then
              __lux_tmp_383 = 0
            end
            __lux_tmp_382 = mathMax(0, __lux_tmp_383)
          end
        else
          __lux_tmp_382 = 0
        end
        shadowGrow = __lux_tmp_382
      end
      do
        local __lux_tmp_384
        if hasShadow then
          do
            local __lux_tmp_385 = shadowWidth
            if __lux_tmp_385 == nil then
              __lux_tmp_385 = 1
            end
            __lux_tmp_384 = mathMax(0.001, __lux_tmp_385)
          end
        else
          __lux_tmp_384 = 1
        end
        shadowWidth = __lux_tmp_384
      end
      do
        local __lux_tmp_386
        if hasShadow then
          do
            local __lux_tmp_387 = shadowFalloff
            if __lux_tmp_387 == nil then
              __lux_tmp_387 = 1
            end
            __lux_tmp_386 = mathMax(0.001, __lux_tmp_387)
          end
        else
          __lux_tmp_386 = 1
        end
        shadowFalloff = __lux_tmp_386
      end
      if hasShadow then
        local spread
        do
          local __lux_tmp_388 = shadowExtent
          if __lux_tmp_388 == nil then
            __lux_tmp_388 = shadowWidth
          end
          spread = mathMax(1, __lux_tmp_388)
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
      do
        local __lux_tmp_389
        if hasOuter then
          do
            local __lux_tmp_390 = outerGrow
            if __lux_tmp_390 == nil then
              __lux_tmp_390 = 0
            end
            __lux_tmp_389 = mathMax(0, __lux_tmp_390)
          end
        else
          __lux_tmp_389 = 0
        end
        outerGrow = __lux_tmp_389
      end
      do
        local __lux_tmp_391
        if hasOuter then
          do
            local __lux_tmp_392 = outerWidth
            if __lux_tmp_392 == nil then
              __lux_tmp_392 = 1
            end
            __lux_tmp_391 = mathMax(0.001, __lux_tmp_392)
          end
        else
          __lux_tmp_391 = 1
        end
        outerWidth = __lux_tmp_391
      end
      do
        local __lux_tmp_393
        if hasOuter then
          do
            local __lux_tmp_394 = outerFalloff
            if __lux_tmp_394 == nil then
              __lux_tmp_394 = 1
            end
            __lux_tmp_393 = mathMax(0.001, __lux_tmp_394)
          end
        else
          __lux_tmp_393 = 1
        end
        outerFalloff = __lux_tmp_393
      end
      if hasOuter then
        local spread
        do
          local __lux_tmp_395 = outerExtent
          if __lux_tmp_395 == nil then
            __lux_tmp_395 = outerWidth
          end
          spread = mathMax(1, __lux_tmp_395)
        end
        local left, top, right, bottom = glowBiasPads(spread, outerX, outerY)
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
      local __lux_tmp_396 = sw <= 0
      if not __lux_tmp_396 then
        __lux_tmp_396 = sh <= 0
      end
      if __lux_tmp_396 then
        roundRectTraceEnd(setupTrace)
        if profiling then
          roundRectProfileEnd("round.fused.setup", setupProfile)
        end
        return false
      end
      local material = roundRectMaterials.roundrect_fused
      do
        local __lux_tmp_397 = radiusValue
        if __lux_tmp_397 == nil then
          __lux_tmp_397 = roundRectRadiusScalar(radius, w, h)
        end
        setupRoundRectConstants(material, w, h, fill, stroke, strokeWidth, __lux_tmp_397)
      end
      do
        local __lux_tmp_398
        if hasShadow then
          __lux_tmp_398 = sr
        else
          __lux_tmp_398 = 0
        end
        local __lux_tmp_399
        if hasShadow then
          __lux_tmp_399 = sg
        else
          __lux_tmp_399 = 0
        end
        local __lux_tmp_400
        if hasShadow then
          __lux_tmp_400 = sb
        else
          __lux_tmp_400 = 0
        end
        local __lux_tmp_401
        if hasShadow then
          __lux_tmp_401 = sa * shadowStrength
        else
          __lux_tmp_401 = 0
        end
        local __lux_tmp_402
        if hasOuter then
          __lux_tmp_402 = orr
        else
          __lux_tmp_402 = 0
        end
        local __lux_tmp_403
        if hasOuter then
          __lux_tmp_403 = og
        else
          __lux_tmp_403 = 0
        end
        local __lux_tmp_404
        if hasOuter then
          __lux_tmp_404 = ob
        else
          __lux_tmp_404 = 0
        end
        local __lux_tmp_405
        if hasOuter then
          __lux_tmp_405 = oa * outerStrength
        else
          __lux_tmp_405 = 0
        end
        setupAuxConstantsRaw(
          material,
          __lux_tmp_398,
          __lux_tmp_399,
          __lux_tmp_400,
          __lux_tmp_401,
          shadowX,
          shadowY,
          shadowGrow,
          shadowWidth,
          __lux_tmp_402,
          __lux_tmp_403,
          __lux_tmp_404,
          __lux_tmp_405,
          shadowFalloff,
          outerGrow,
          outerWidth,
          outerFalloff
        )
      end
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
        local __lux_tmp_406
        if profiling then
          __lux_tmp_406 = roundRectProfileStart()
        else
          __lux_tmp_406 = nil
        end
        bleedProfile = __lux_tmp_406
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
      local __lux_tmp_407 = spec == nil
      if not __lux_tmp_407 then
        __lux_tmp_407 = spec.tint == nil
      end
      if __lux_tmp_407 then
        return nil
      end
      local tint = spec.tint
      local alpha
      do
        local __lux_tmp_408 = tint.a
        if __lux_tmp_408 == nil then
          __lux_tmp_408 = 255
        end
        local __lux_tmp_409 = spec.opacity
        if __lux_tmp_409 == nil then
          __lux_tmp_409 = 1
        end
        alpha = __lux_tmp_408 * __lux_tmp_409
      end
      if alpha <= 0 then
        return nil
      end
      do
        local __lux_tmp_410 = tint.r
        if __lux_tmp_410 == nil then
          __lux_tmp_410 = 0
        end
        backdropTintScratch.r = __lux_tmp_410
      end
      do
        local __lux_tmp_411 = tint.g
        if __lux_tmp_411 == nil then
          __lux_tmp_411 = 0
        end
        backdropTintScratch.g = __lux_tmp_411
      end
      do
        local __lux_tmp_412 = tint.b
        if __lux_tmp_412 == nil then
          __lux_tmp_412 = 0
        end
        backdropTintScratch.b = __lux_tmp_412
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
        local __lux_tmp_413 = toNumber(spec.padding)
        if __lux_tmp_413 == nil then
          __lux_tmp_413 = 0
        end
        pad = mathMax(0, __lux_tmp_413)
      end
      local bx = x - pad
      local by = y - pad
      local bw = w + pad * 2
      local bh = h + pad * 2
      local br = radiusWithGrow(radius, pad)
      local tint = backdropTintColor(spec)
      local blurred = false
      local __lux_tmp_414 = spec.blur > 0
      if __lux_tmp_414 then
        __lux_tmp_414 = roundRectBlurRT ~= nil
      end
      local __lux_tmp_415 = __lux_tmp_414
      if __lux_tmp_415 then
        __lux_tmp_415 = renderCopyRenderTargetToTexture ~= nil
      end
      local __lux_tmp_416 = __lux_tmp_415
      if __lux_tmp_416 then
        __lux_tmp_416 = materialOK(roundRectMaterials.roundrect_blur)
      end
      if __lux_tmp_416 then
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
            local __lux_tmp_417 = tint.r
            if __lux_tmp_417 == nil then
              __lux_tmp_417 = 0
            end
            local __lux_tmp_418 = tint.g
            if __lux_tmp_418 == nil then
              __lux_tmp_418 = 0
            end
            local __lux_tmp_419 = tint.b
            if __lux_tmp_419 == nil then
              __lux_tmp_419 = 0
            end
            local __lux_tmp_420 = tint.a
            if __lux_tmp_420 == nil then
              __lux_tmp_420 = 255
            end
            setupAuxConstantsRaw(
              material,
              __lux_tmp_417 * inv255,
              __lux_tmp_418 * inv255,
              __lux_tmp_419 * inv255,
              __lux_tmp_420 * inv255,
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
      local __lux_tmp_421 = tint ~= nil
      if __lux_tmp_421 then
        __lux_tmp_421 = not blurred
      end
      if __lux_tmp_421 then
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
    drawRoundRectFxPassRaw = function(x, y, w, h, radius, fill, stroke, strokeWidth, innerEnabled, gr, gg, gb, ga, glowWidth, glowStrength, glowFalloff)
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
      if not innerEnabled then
        gr = 0
        gg = 0
        gb = 0
        ga = 0
        glowWidth = 0
        glowStrength = 0
        glowFalloff = 1
      else
        do
          local __lux_tmp_422 = toNumber(glowWidth)
          if __lux_tmp_422 == nil then
            __lux_tmp_422 = 8
          end
          glowWidth = mathMax(0.001, __lux_tmp_422)
        end
        do
          local __lux_tmp_423 = toNumber(glowStrength)
          if __lux_tmp_423 == nil then
            __lux_tmp_423 = 1
          end
          glowStrength = mathMax(0, __lux_tmp_423)
        end
        do
          local __lux_tmp_424 = toNumber(glowFalloff)
          if __lux_tmp_424 == nil then
            __lux_tmp_424 = 1.65
          end
          glowFalloff = mathMax(0.001, __lux_tmp_424)
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
    drawRoundRectRaw = function(x, y, w, h, radius, fillInput, strokeValue, strokeWidthInput, shadowValue, outerGlowValue, innerGlowValue, backdropInput, patternValue)
      if radius == nil then
        radius = 0
      end
      local profiling = roundRectProfileActive()
      local trace = roundRectTraceStart("round.immediate")
      local totalProfile
      if profiling then
        totalProfile = roundRectProfileStart()
      else
        totalProfile = nil
      end
      local stageProfile = totalProfile
      local initTrace = roundRectTraceStart("round.init")
      local shaderTrace = roundRectTraceStart("round.init.shader")
      local shaderReady = shadersActive()
      roundRectTraceEnd(shaderTrace)
      local transformTrace = roundRectTraceStart("round.init.transform")
      local transformActive = hasTransform()
      roundRectTraceEnd(transformTrace)
      local radiusTrace = roundRectTraceStart("round.init.radius")
      do
        local __lux_tmp_425 = radius
        if __lux_tmp_425 == nil then
          __lux_tmp_425 = 0
        end
        radius = __lux_tmp_425
      end
      roundRectTraceEnd(radiusTrace)
      local strokeTrace = roundRectTraceStart("round.init.stroke")
      local strokeWidth = 0
      local hasStroke = false
      if strokeValue ~= nil then
        strokeWidth = style.strokeWidth(strokeWidthInput, 0)
        do
          local __lux_tmp_426 = strokeWidth > 0
          if __lux_tmp_426 then
            local __lux_tmp_427 = strokeValue.a == nil
            if not __lux_tmp_427 then
              __lux_tmp_427 = strokeValue.a > 0
            end
            __lux_tmp_426 = __lux_tmp_427
          end
          hasStroke = __lux_tmp_426
        end
      end
      roundRectTraceEnd(strokeTrace)
      roundRectTraceEnd(initTrace)
      local noEffects
      do
        local __lux_tmp_428 = shadowValue == nil
        if __lux_tmp_428 then
          __lux_tmp_428 = outerGlowValue == nil
        end
        local __lux_tmp_429 = __lux_tmp_428
        if __lux_tmp_429 then
          __lux_tmp_429 = innerGlowValue == nil
        end
        local __lux_tmp_430 = __lux_tmp_429
        if __lux_tmp_430 then
          __lux_tmp_430 = backdropInput == nil
        end
        local __lux_tmp_431 = __lux_tmp_430
        if __lux_tmp_431 then
          __lux_tmp_431 = patternValue == nil
        end
        noEffects = __lux_tmp_431
      end
      local __lux_tmp_432 = noEffects
      if __lux_tmp_432 then
        __lux_tmp_432 = not hasStroke
      end
      local __lux_tmp_433 = __lux_tmp_432
      if __lux_tmp_433 then
        __lux_tmp_433 = not transformActive
      end
      if __lux_tmp_433 then
        local fastPrepareTrace = roundRectTraceStart("round.fast.prepare")
        local fill = hotFillFromStyle(fillInput)
        local hasFill = style.fillVisible(fill)
        local __lux_tmp_434 = hasFill
        if __lux_tmp_434 then
          __lux_tmp_434 = fill.kind == style.FILL_SOLID
        end
        if __lux_tmp_434 then
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
          local __lux_tmp_435 = shaderReady
          if __lux_tmp_435 then
            __lux_tmp_435 = drawSolidRoundFast(x, y, w, h, radiusValue, fill)
          end
          if __lux_tmp_435 then
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
      local hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpreadUnused, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread = shadowRaw(shadowValue)
      roundRectTraceEnd(shadowTrace)
      local outerTrace = roundRectTraceStart("style.outerGlow")
      local hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpreadUnused, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread = outerGlowRaw(outerGlowValue)
      roundRectTraceEnd(outerTrace)
      local backdropTrace = roundRectTraceStart("style.backdrop")
      local backdropSpec
      do
        local __lux_tmp_436 = backdropInput ~= nil
        if __lux_tmp_436 then
          __lux_tmp_436 = backdropInput ~= false
        end
        if __lux_tmp_436 then
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
      local cullSpread = 0
      if shaderReady then
        if hasShadow then
          local shadowCullTrace = roundRectTraceStart("round.cullSpread.shadow")
          cullSpread = mathMax(cullSpread, shadowCullSpread)
          roundRectTraceEnd(shadowCullTrace)
        end
        if hasOuter then
          local outerCullTrace = roundRectTraceStart("round.cullSpread.outer")
          cullSpread = mathMax(cullSpread, outerCullSpread)
          roundRectTraceEnd(outerCullTrace)
        end
        if backdropSpec ~= nil then
          local backdropCullTrace = roundRectTraceStart("round.cullSpread.backdrop")
          do
            local __lux_tmp_437 = toNumber(backdropSpec.padding)
            if __lux_tmp_437 == nil then
              __lux_tmp_437 = 0
            end
            cullSpread = mathMax(cullSpread, mathMax(0, __lux_tmp_437))
          end
          roundRectTraceEnd(backdropCullTrace)
        end
      end
      roundRectTraceEnd(cullSpreadTrace)
      local cullTrace = roundRectTraceStart("round.cull")
      local __lux_tmp_438 = not transformActive
      if __lux_tmp_438 then
        __lux_tmp_438 = frame.isCulled(x - cullSpread, y - cullSpread, w + cullSpread * 2, h + cullSpread * 2)
      end
      if __lux_tmp_438 then
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
        drawRoundRectFallbackRaw(x, y, w, h, radius, fillInput, strokeValue, strokeWidthInput)
        local hasInner, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff = innerGlowRaw(innerGlowValue)
        drawRoundRectInnerGlowRaw(
          x,
          y,
          w,
          h,
          radius,
          hasInner,
          igr,
          igg,
          igb,
          iga,
          innerWidth,
          innerStrength,
          innerFalloff
        )
        roundRectTraceEnd(fallbackTrace)
        if profiling then
          roundRectProfileEnd("round.fallback", profile)
        end
        finishImmediateTrace(trace, profiling, totalProfile)
        return
      end
      if profiling then
        stageProfile = sysTime()
      end
      local fillPrepareTrace = roundRectTraceStart("round.fillPrepare")
      local fillTrace = roundRectTraceStart("style.fill")
      local fill = hotFillFromStyle(fillInput)
      roundRectTraceEnd(fillTrace)
      local fillVisibleTrace = roundRectTraceStart("round.fillPrepare.visible")
      local hasFill = style.fillVisible(fill)
      roundRectTraceEnd(fillVisibleTrace)
      local innerTrace = roundRectTraceStart("style.innerGlow")
      local hasInner, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff = innerGlowRaw(innerGlowValue)
      roundRectTraceEnd(innerTrace)
      roundRectTraceEnd(fillPrepareTrace)
      if profiling then
        local now = sysTime()
        roundRectProfileRecord("round.fillPrepare", (now - stageProfile) * 1000)
        stageProfile = now
      end
      local profile = nil
      local __lux_tmp_439 = backdropSpec == nil
      if __lux_tmp_439 then
        __lux_tmp_439 = patternValue == nil
      end
      local __lux_tmp_440 = __lux_tmp_439
      if __lux_tmp_440 then
        __lux_tmp_440 = not hasInner
      end
      local __lux_tmp_441 = __lux_tmp_440
      if __lux_tmp_441 then
        __lux_tmp_441 = not transformActive
      end
      local __lux_tmp_442 = __lux_tmp_441
      if __lux_tmp_442 then
        local __lux_tmp_443 = hasFill
        if not __lux_tmp_443 then
          __lux_tmp_443 = hasStroke
        end
        __lux_tmp_442 = __lux_tmp_443
      end
      local __lux_tmp_444 = __lux_tmp_442
      if __lux_tmp_444 then
        local __lux_tmp_445 = hasShadow
        if not __lux_tmp_445 then
          __lux_tmp_445 = hasOuter
        end
        __lux_tmp_444 = __lux_tmp_445
      end
      if __lux_tmp_444 then
        do
          local __lux_tmp_446
          if profiling then
            __lux_tmp_446 = roundRectProfileStart()
          else
            __lux_tmp_446 = nil
          end
          profile = __lux_tmp_446
        end
        local fusedTrace = roundRectTraceStart("round.fused")
        local radiusValue = roundRectRadiusScalar(radius, w, h)
        if drawRoundRectFusedRaw(
          x,
          y,
          w,
          h,
          radius,
          fill,
          strokeValue,
          strokeWidth,
          radiusValue,
          hasShadow,
          sr,
          sg,
          sb,
          sa,
          shadowX,
          shadowY,
          shadowWidth,
          shadowExtent,
          shadowGrow,
          shadowStrength,
          shadowFalloff,
          hasOuter,
          orr,
          og,
          ob,
          oa,
          outerX,
          outerY,
          outerWidth,
          outerExtent,
          outerGrow,
          outerStrength,
          outerFalloff
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
      local __lux_tmp_447 = hasShadow
      if not __lux_tmp_447 then
        __lux_tmp_447 = hasOuter
      end
      if __lux_tmp_447 then
        do
          local __lux_tmp_448
          if profiling then
            __lux_tmp_448 = roundRectProfileStart()
          else
            __lux_tmp_448 = nil
          end
          profile = __lux_tmp_448
        end
        local shadowOuterTrace = roundRectTraceStart("round.shadowOuter")
        drawRoundRectShadowOuterRaw(
          x,
          y,
          w,
          h,
          radius,
          hasShadow,
          sr,
          sg,
          sb,
          sa,
          shadowX,
          shadowY,
          shadowWidth,
          shadowExtent,
          shadowGrow,
          shadowStrength,
          shadowFalloff,
          hasOuter,
          orr,
          og,
          ob,
          oa,
          outerX,
          outerY,
          outerWidth,
          outerExtent,
          outerGrow,
          outerStrength,
          outerFalloff
        )
        roundRectTraceEnd(shadowOuterTrace)
        if profiling then
          roundRectProfileEnd("round.shadowOuter", profile)
        end
      end
      local backdrop = nil
      if backdropSpec ~= nil then
        do
          local __lux_tmp_449
          if profiling then
            __lux_tmp_449 = roundRectProfileStart()
          else
            __lux_tmp_449 = nil
          end
          profile = __lux_tmp_449
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
        local __lux_tmp_450 = backdrop == nil
        if __lux_tmp_450 then
          __lux_tmp_450 = not hasStroke
        end
        local __lux_tmp_451 = __lux_tmp_450
        if __lux_tmp_451 then
          __lux_tmp_451 = patternValue == nil
        end
        local __lux_tmp_452 = __lux_tmp_451
        if __lux_tmp_452 then
          __lux_tmp_452 = not hasInner
        end
        local __lux_tmp_453 = __lux_tmp_452
        if __lux_tmp_453 then
          local __lux_tmp_454 = hasShadow
          if not __lux_tmp_454 then
            __lux_tmp_454 = hasOuter
          end
          __lux_tmp_453 = __lux_tmp_454
        end
        effectOnly = __lux_tmp_453
      end
      local __lux_tmp_455 = effectOnly
      if __lux_tmp_455 then
        __lux_tmp_455 = not hasFill
      end
      if __lux_tmp_455 then
        finishImmediateTrace(trace, profiling, totalProfile)
        return
      end
      local __lux_tmp_456 = backdrop == nil
      if __lux_tmp_456 then
        __lux_tmp_456 = not hasFill
      end
      local __lux_tmp_457 = __lux_tmp_456
      if __lux_tmp_457 then
        __lux_tmp_457 = not hasStroke
      end
      local __lux_tmp_458 = __lux_tmp_457
      if __lux_tmp_458 then
        __lux_tmp_458 = patternValue == nil
      end
      local __lux_tmp_459 = __lux_tmp_458
      if __lux_tmp_459 then
        __lux_tmp_459 = not hasInner
      end
      if __lux_tmp_459 then
        finishImmediateTrace(trace, profiling, totalProfile)
        return
      end
      local innerGlowDrawn = false
      if patternValue ~= nil then
        do
          local __lux_tmp_460
          if profiling then
            __lux_tmp_460 = roundRectProfileStart()
          else
            __lux_tmp_460 = nil
          end
          profile = __lux_tmp_460
        end
        local layeredTrace = roundRectTraceStart("round.layered")
        if hasFill then
          drawRoundRectFillPass(x, y, w, h, radius, fill)
        end
        drawRoundRectPattern(x, y, w, h, radius, patternValue)
        if hasStroke then
          drawRoundRectStrokePass(x, y, w, h, radius, strokeValue, strokeWidth)
        end
        roundRectTraceEnd(layeredTrace)
        if profiling then
          roundRectProfileEnd("round.layered", profile)
        end
      else
        do
          local __lux_tmp_461
          if profiling then
            __lux_tmp_461 = roundRectProfileStart()
          else
            __lux_tmp_461 = nil
          end
          profile = __lux_tmp_461
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
        local __lux_tmp_462 = hasInner
        if __lux_tmp_462 then
          __lux_tmp_462 = drawRoundRectFxPassRaw(
          x,
          y,
          w,
          h,
          radius,
          fill,
          strokeValue,
          strokeWidth,
          true,
          igr,
          igg,
          igb,
          iga,
          innerWidth,
          innerStrength,
          innerFalloff
        )
        end
        if __lux_tmp_462 then
          baseKind = "round.base.fx"
          innerGlowDrawn = true
        else
          local __lux_tmp_463 = baseKind == "round.base.solidRect"
          if __lux_tmp_463 then
            __lux_tmp_463 = fill.kind == style.FILL_SOLID
          end
          local __lux_tmp_464 = __lux_tmp_463
          if __lux_tmp_464 then
            __lux_tmp_464 = shadowValue == nil
          end
          local __lux_tmp_465 = __lux_tmp_464
          if __lux_tmp_465 then
            __lux_tmp_465 = outerGlowValue == nil
          end
          local __lux_tmp_466 = __lux_tmp_465
          if __lux_tmp_466 then
            __lux_tmp_466 = innerGlowValue == nil
          end
          local __lux_tmp_467 = __lux_tmp_466
          if __lux_tmp_467 then
            __lux_tmp_467 = backdrop == nil
          end
          local __lux_tmp_468 = __lux_tmp_467
          if __lux_tmp_468 then
            __lux_tmp_468 = not transformActive
          end
          if __lux_tmp_468 then
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
            local __lux_tmp_469 = baseKind == "round.base.solidRound"
            if __lux_tmp_469 then
              __lux_tmp_469 = fill.kind == style.FILL_SOLID
            end
            local __lux_tmp_470 = __lux_tmp_469
            if __lux_tmp_470 then
              __lux_tmp_470 = shadowValue == nil
            end
            local __lux_tmp_471 = __lux_tmp_470
            if __lux_tmp_471 then
              __lux_tmp_471 = outerGlowValue == nil
            end
            local __lux_tmp_472 = __lux_tmp_471
            if __lux_tmp_472 then
              __lux_tmp_472 = innerGlowValue == nil
            end
            local __lux_tmp_473 = __lux_tmp_472
            if __lux_tmp_473 then
              __lux_tmp_473 = backdrop == nil
            end
            local __lux_tmp_474 = __lux_tmp_473
            if __lux_tmp_474 then
              __lux_tmp_474 = drawSolidRoundFast(x, y, w, h, radiusValue, fill)
            end
            if __lux_tmp_474 then
              baseKind = "round.base.solidRoundFast"
            else
              local __lux_tmp_475 = hasFill
              if not __lux_tmp_475 then
                __lux_tmp_475 = hasStroke
              end
              local __lux_tmp_476 = __lux_tmp_475
              if not __lux_tmp_476 then
                __lux_tmp_476 = backdrop ~= nil
              end
              if __lux_tmp_476 then
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
                  strokeValue,
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
      local __lux_tmp_477 = hasInner
      if __lux_tmp_477 then
        __lux_tmp_477 = not innerGlowDrawn
      end
      if __lux_tmp_477 then
        local profile
        if profiling then
          profile = roundRectProfileStart()
        else
          profile = nil
        end
        local innerTrace = roundRectTraceStart("round.innerGlow")
        drawRoundRectInnerGlowRaw(
          x,
          y,
          w,
          h,
          radius,
          true,
          igr,
          igg,
          igb,
          iga,
          innerWidth,
          innerStrength,
          innerFalloff
        )
        roundRectTraceEnd(innerTrace)
        if profiling then
          roundRectProfileEnd("round.innerGlow", profile)
        end
      end
      return finishImmediateTrace(trace, profiling, totalProfile)
    end
    drawRoundRectImmediate = function(x, y, w, h, drawStyle)
      local styleValue
      do
        local __lux_tmp_478 = drawStyle
        if __lux_tmp_478 == nil then
          __lux_tmp_478 = emptyRoundRectStyle
        end
        styleValue = __lux_tmp_478
      end
      local __lux_tmp_479 = styleValue.radius
      if __lux_tmp_479 == nil then
        local __lux_tmp_480 = styleValue.r
        if __lux_tmp_480 == nil then
          __lux_tmp_480 = 0
        end
        __lux_tmp_479 = __lux_tmp_480
      end
      local __lux_tmp_481 = styleValue.fill
      if __lux_tmp_481 == nil then
        __lux_tmp_481 = styleValue.color
      end
      return drawRoundRectRaw(
        x,
        y,
        w,
        h,
        __lux_tmp_479,
        __lux_tmp_481,
        styleValue.stroke,
        styleValue.strokeWidth,
        styleValue.shadow,
        styleValue.outerGlow,
        styleValue.innerGlow,
        styleValue.backdrop,
        styleValue.pattern
      )
    end
  end
  do
    roundedBoxEx = function(x, y, w, h, drawStyle)
      local trace = roundRectTraceStart("api.RoundedBoxEx")
      local styleTrace = roundRectTraceStart("api.RoundedBoxEx.resolveDrawStyle")
      local resolved
      do
        local __lux_tmp_482 = drawStyle
        if __lux_tmp_482 == nil then
          __lux_tmp_482 = {}
        end
        resolved = __lux_tmp_482
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
      local result = drawRoundRectRaw(x, y, w, h, radius, fill, stroke, strokeWidth)
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
        local __lux_tmp_483 = drawStyle
        if __lux_tmp_483 == nil then
          __lux_tmp_483 = {}
        end
        resolved = __lux_tmp_483
      end
      local transform, stripped = splitStyleTransform(resolved)
      local x = cx - radius
      local y = cy - radius
      local size = radius * 2
      if transform ~= nil then
        return withTransform(
          transform,
          x,
          y,
          size,
          size,
          function()
            local __lux_tmp_484 = stripped.fill
            if __lux_tmp_484 == nil then
              __lux_tmp_484 = stripped.color
            end
            return drawRoundRectRaw(
              x,
              y,
              size,
              size,
              radius,
              __lux_tmp_484,
              stripped.stroke,
              stripped.strokeWidth,
              stripped.shadow,
              stripped.outerGlow,
              stripped.innerGlow,
              stripped.backdrop,
              stripped.pattern
            )
          end
        )
      end
      local __lux_tmp_485 = stripped.fill
      if __lux_tmp_485 == nil then
        __lux_tmp_485 = stripped.color
      end
      return drawRoundRectRaw(
        x,
        y,
        size,
        size,
        radius,
        __lux_tmp_485,
        stripped.stroke,
        stripped.strokeWidth,
        stripped.shadow,
        stripped.outerGlow,
        stripped.innerGlow,
        stripped.backdrop,
        stripped.pattern
      )
    end
    capsule = function(x, y, w, h, fill, stroke, strokeWidth)
      return drawRoundRectRaw(x, y, w, h, mathMin(w, h) * 0.5, fill, stroke, strokeWidth)
    end
    capsuleEx = function(x, y, w, h, drawStyle)
      local resolved
      do
        local __lux_tmp_486 = drawStyle
        if __lux_tmp_486 == nil then
          __lux_tmp_486 = {}
        end
        resolved = __lux_tmp_486
      end
      local transform, stripped = splitStyleTransform(resolved)
      local radius
      do
        local __lux_tmp_487 = stripped.radius
        if __lux_tmp_487 == nil then
          __lux_tmp_487 = mathMin(w, h) * 0.5
        end
        radius = __lux_tmp_487
      end
      if transform ~= nil then
        return withTransform(
          transform,
          x,
          y,
          w,
          h,
          function()
            local __lux_tmp_488 = stripped.fill
            if __lux_tmp_488 == nil then
              __lux_tmp_488 = stripped.color
            end
            return drawRoundRectRaw(
              x,
              y,
              w,
              h,
              radius,
              __lux_tmp_488,
              stripped.stroke,
              stripped.strokeWidth,
              stripped.shadow,
              stripped.outerGlow,
              stripped.innerGlow,
              stripped.backdrop,
              stripped.pattern
            )
          end
        )
      end
      local __lux_tmp_489 = stripped.fill
      if __lux_tmp_489 == nil then
        __lux_tmp_489 = stripped.color
      end
      return drawRoundRectRaw(
        x,
        y,
        w,
        h,
        radius,
        __lux_tmp_489,
        stripped.stroke,
        stripped.strokeWidth,
        stripped.shadow,
        stripped.outerGlow,
        stripped.innerGlow,
        stripped.backdrop,
        stripped.pattern
      )
    end
  end
  do
    install = function(owner)
      configureRoundRect(owner)
      do
        local __lux_tmp_490 = owner._internal
        if __lux_tmp_490 == nil then
          __lux_tmp_490 = {}
        end
        owner._internal = __lux_tmp_490
      end
      owner._internal.drawRoundRectRaw = drawRoundRectRaw
      owner._internal.drawRoundRectImmediate = drawRoundRectImmediate
      owner._internal.setupParamMatrix = setupParamMatrix
      owner._internal.setupParamMatrixRaw = setupParamMatrixRaw
      owner._internal.setupExtraParams = setupAuxConstants
      owner._internal.setupExtraParamsRaw = setupAuxConstantsRaw
      owner._internal.roundRaw = {
        effectExtent = effectExtentRaw,
        innerGlow = innerGlowRaw,
        outerGlow = outerGlowRaw,
        shadow = shadowRaw,
        drawInnerGlow = drawRoundRectInnerGlowRaw,
        drawShadowOuter = drawRoundRectShadowOuterRaw,
        drawFused = drawRoundRectFusedRaw,
        drawFxPass = drawRoundRectFxPassRaw,
      }
      owner.RoundedBox = roundedBox
      owner.RoundedBoxEx = roundedBoxEx
      owner.Circle = circle
      owner.CircleEx = circleEx
      owner.Capsule = capsule
      owner.CapsuleEx = capsuleEx
      owner._RoundRect = {
        drawRoundRectRaw = drawRoundRectRaw,
        drawRoundRectImmediate = drawRoundRectImmediate,
        fallbackRoundRectPoints = fallbackRoundRectPoints,
        roundRaw = owner._internal.roundRaw,
        patternStyle = patternStyle,
        patternOffset = patternOffset,
      }
      return owner
    end
  end
  
  __lux_exports.effectExtentRaw = effectExtentRaw
  __lux_exports.fallbackRoundRectPoints = fallbackRoundRectPoints
  __lux_exports.glowBiasPads = glowBiasPads
  __lux_exports.innerGlowRaw = innerGlowRaw
  __lux_exports.outerGlowRaw = outerGlowRaw
  __lux_exports.shadowRaw = shadowRaw
  __lux_exports.patternStyle = patternStyle
  __lux_exports.patternOffset = patternOffset
  __lux_exports.drawRoundRectRaw = drawRoundRectRaw
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
