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
    local frameImport = __lux_import("lux/mgfx/frame#client")
    local geometryImport = __lux_import("lux/mgfx/geometry#client")
    local styleImport = __lux_import("lux/mgfx/style#client")
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
      local __lux_obj_render_1 = render
      local __lux_val_CopyRenderTargetToTexture_2 = nil
      if __lux_obj_render_1 ~= nil then
        __lux_val_CopyRenderTargetToTexture_2 = __lux_obj_render_1.CopyRenderTargetToTexture
      end
      renderCopyRenderTargetToTexture = __lux_val_CopyRenderTargetToTexture_2
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
      local __lux_tmp_3
      if matrixCtor ~= nil then
        __lux_tmp_3 = matrixCtor()
      else
        __lux_tmp_3 = nil
      end
      paramMatrixProbe = __lux_tmp_3
    end
    do
      local __lux_obj_paramMatrixProbe_4 = paramMatrixProbe
      local __lux_val_SetUnpacked_5 = nil
      if __lux_obj_paramMatrixProbe_4 ~= nil then
        __lux_val_SetUnpacked_5 = __lux_obj_paramMatrixProbe_4.SetUnpacked
      end
      paramMatrixSetUnpacked = __lux_val_SetUnpacked_5
    end
    paramMatrices = {}
    paramMatrixRawState = {}
    auxParamMatrices = {}
    auxParamMatrixRawState = {}
    roundRectMaterials = {}
    roundRectBlurRT = nil
    roundRectMatOK = function(material)
      return material ~= nil and material.IsError ~= nil and not material:IsError()
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
      if spec ~= nil and spec._extent ~= nil then
        return spec._extent
      end
      local width
      do
        local __lux_obj_spec_6 = spec
        local __lux_val_width_7 = nil
        if __lux_obj_spec_6 ~= nil then
          __lux_val_width_7 = __lux_obj_spec_6.width
        end
        local __lux_tmp_width_8 = toNumber(__lux_val_width_7)
        if __lux_tmp_width_8 == nil then
          __lux_tmp_width_8 = defaultWidth
        end
        width = mathMax(0.001, __lux_tmp_width_8)
      end
      local falloff
      do
        local __lux_obj_spec_9 = spec
        local __lux_val_falloff_10 = nil
        if __lux_obj_spec_9 ~= nil then
          __lux_val_falloff_10 = __lux_obj_spec_9.falloff
        end
        local __lux_tmp_falloff_11 = toNumber(__lux_val_falloff_10)
        if __lux_tmp_falloff_11 == nil then
          __lux_tmp_falloff_11 = 1.9
        end
        falloff = mathMax(0.35, __lux_tmp_falloff_11)
      end
      local sigma = mathMax(width / mathSqrt(falloff) * 0.72, 0.35)
      local tail = sigma * 3.72
      local __lux_obj_spec_12 = spec
      local __lux_val_spread_13 = nil
      if __lux_obj_spec_12 ~= nil then
        __lux_val_spread_13 = __lux_obj_spec_12.spread
      end
      local __lux_tmp_spread_14 = toNumber(__lux_val_spread_13)
      if __lux_tmp_spread_14 == nil then
        __lux_tmp_spread_14 = width
      end
      return mathMax(1, __lux_tmp_spread_14, tail)
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
      if owner == nil then
        owner = {}
      end
      local materialState = owner._MaterialState
      if materialState == nil then
        materialState = {}
      end
      do
        local __lux_tmp_Materials_15 = owner._Materials
        if __lux_tmp_Materials_15 == nil then
          __lux_tmp_Materials_15 = materialState.materials
        end
        if __lux_tmp_Materials_15 == nil then
          __lux_tmp_Materials_15 = roundRectMaterials
        end
        if __lux_tmp_Materials_15 == nil then
          __lux_tmp_Materials_15 = {}
        end
        roundRectMaterials = __lux_tmp_Materials_15
      end
      do
        local __lux_tmp_BlurRT_16 = owner._BlurRT
        if __lux_tmp_BlurRT_16 == nil then
          __lux_tmp_BlurRT_16 = materialState.blurRT
        end
        if __lux_tmp_BlurRT_16 == nil then
          __lux_tmp_BlurRT_16 = roundRectBlurRT
        end
        roundRectBlurRT = __lux_tmp_BlurRT_16
      end
      do
        local __lux_tmp_MaterialOK_17 = owner.MaterialOK
        if __lux_tmp_MaterialOK_17 == nil then
          __lux_tmp_MaterialOK_17 = materialState.matOK
        end
        if __lux_tmp_MaterialOK_17 == nil then
          __lux_tmp_MaterialOK_17 = roundRectMatOK
        end
        roundRectMatOK = __lux_tmp_MaterialOK_17
      end
      do
        local __lux_tmp_hasShaders_18 = owner.hasShaders
        if __lux_tmp_hasShaders_18 == nil then
          __lux_tmp_hasShaders_18 = roundRectHasShaders
        end
        roundRectHasShaders = __lux_tmp_hasShaders_18
      end
      roundRectProfiler = owner.Profiler
      return true
    end
    materialOK = function(material)
      return roundRectMatOK ~= nil and roundRectMatOK(material)
    end
    shadersActive = function()
      if forceFallbackCvar == nil and getConVar ~= nil then
        do
          local __lux_tmp_getConVar_19 = getConVar("mgfx_force_fallback")
          if __lux_tmp_getConVar_19 == nil then
            __lux_tmp_getConVar_19 = false
          end
          forceFallbackCvar = __lux_tmp_getConVar_19
        end
      end
      if forceFallbackCvar ~= nil and forceFallbackCvar ~= false and forceFallbackCvar:GetBool() then
        return false
      end
      return roundRectHasShaders ~= nil and roundRectHasShaders()
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
        local __lux_tmp_colorA_20 = fill.colorA
        if __lux_tmp_colorA_20 == nil then
          __lux_tmp_colorA_20 = fill.color
        end
        if __lux_tmp_colorA_20 == nil then
          __lux_tmp_colorA_20 = fallback
        end
        if __lux_tmp_colorA_20 == nil then
          __lux_tmp_colorA_20 = color_white
        end
        return __lux_tmp_colorA_20
      end
      local __lux_tmp_fallback_21 = fallback
      if __lux_tmp_fallback_21 == nil then
        __lux_tmp_fallback_21 = color_white
      end
      return __lux_tmp_fallback_21
    end
    hotFillFromStyle = function(fill, fallback)
      if typeOf(fill) == "table" then
        local kind = fill.kind
        if kind == style.FILL_SOLID or kind == style.FILL_LINEAR or kind == style.FILL_RADIAL or kind == style.FILL_CONIC then
          return fill
        end
        if kind ~= nil then
          solidFillScratch.colorA = transparentColor
          solidFillScratch.colorB = transparentColor
          solidFillScratch._mgfxFillVisible = false
          return solidFillScratch
        end
        if fill.r ~= nil and fill.g ~= nil and fill.b ~= nil then
          solidFillScratch.colorA = fill
          solidFillScratch.colorB = fill
          solidFillScratch._mgfxFillVisible = fill.a == nil or fill.a > 0
          return solidFillScratch
        end
      end
      local color
      do
        local __lux_tmp_fallback_22 = fallback
        if __lux_tmp_fallback_22 == nil then
          __lux_tmp_fallback_22 = color_white
        end
        color = style.asColor(fill, __lux_tmp_fallback_22)
      end
      solidFillScratch.colorA = color
      solidFillScratch.colorB = color
      solidFillScratch._mgfxFillVisible = color.a == nil or color.a > 0
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
        return fill.a == nil or fill.a > 0
      end
      if fill._mgfxFillVisible ~= nil then
        return fill._mgfxFillVisible
      end
      local kind = fill.kind
      if kind == style.FILL_SOLID then
        local colorA = fill.colorA
        if colorA == nil then
          colorA = color_white
        end
        local colorB = fill.colorB
        if colorB == nil then
          colorB = colorA
        end
        return colorA.a == nil or colorA.a > 0 or (colorB.a == nil or colorB.a > 0)
      end
      if kind == style.FILL_LINEAR or kind == style.FILL_RADIAL or kind == style.FILL_CONIC then
        return fill.stops ~= nil or fill.colorA ~= nil and (fill.colorA.a == nil or fill.colorA.a > 0) or fill.colorB ~= nil and (fill.colorB.a == nil or fill.colorB.a > 0)
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
      if typeOf(radius) ~= "table" or style.isColor(radius) then
        local value = toNumber(radius)
        if value == nil then
          value = 0
        end
        if value <= 0 then
          return 0
        end
        local maxRadius
        do
          local __lux_tmp_w_23 = toNumber(w)
          if __lux_tmp_w_23 == nil then
            __lux_tmp_w_23 = 0
          end
          local __lux_tmp_h_24 = toNumber(h)
          if __lux_tmp_h_24 == nil then
            __lux_tmp_h_24 = 0
          end
          maxRadius = mathMin(mathMax(0, __lux_tmp_w_23), mathMax(0, __lux_tmp_h_24)) * 0.5
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
      return roundRectProfiler ~= nil and roundRectProfiler.IsActive ~= nil and roundRectProfiler.IsActive()
    end
    roundRectProfileStart = function()
      if roundRectProfiler ~= nil and roundRectProfiler.Start ~= nil then
        return roundRectProfiler.Start()
      end
      return nil
    end
    roundRectProfileEnd = function(name, started)
      if started ~= nil and roundRectProfiler ~= nil and roundRectProfiler.End ~= nil then
        roundRectProfiler.End(name, started)
      end
    end
    roundRectProfileRecord = function(name, elapsed)
      if elapsed ~= nil and roundRectProfiler ~= nil and roundRectProfiler.Record ~= nil then
        roundRectProfiler.Record(name, elapsed)
      end
    end
    roundRectTraceStart = function(name)
      if roundRectProfiler ~= nil and roundRectProfiler._TraceActive and roundRectProfiler.TraceStart ~= nil then
        return roundRectProfiler.TraceStart(name)
      end
      return nil
    end
    roundRectTraceEnd = function(token)
      if token ~= nil and roundRectProfiler ~= nil and roundRectProfiler.TraceEnd ~= nil then
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
      if roundRectProfiler ~= nil and roundRectProfiler.Record ~= nil then
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
        local shadowSpread = shadowSpec._cullSpread
        if shadowSpread == nil then
          do
            local __lux_tmp_x_25 = toNumber(shadowSpec.x)
            if __lux_tmp_x_25 == nil then
              __lux_tmp_x_25 = 0
            end
            local __lux_tmp_y_26 = toNumber(shadowSpec.y)
            if __lux_tmp_y_26 == nil then
              __lux_tmp_y_26 = 0
            end
            local __lux_tmp_grow_27 = toNumber(shadowSpec.grow)
            if __lux_tmp_grow_27 == nil then
              __lux_tmp_grow_27 = 0
            end
            shadowSpread = mathAbs(__lux_tmp_x_25) + mathAbs(__lux_tmp_y_26) + effectExtentFromSpec(shadowSpec, 12) + __lux_tmp_grow_27
          end
        end
        spread = mathMax(spread, shadowSpread)
      end
      if outerSpec ~= nil then
        local outerSpread = outerSpec._cullSpread
        if outerSpread == nil then
          do
            local __lux_tmp_x_28 = toNumber(outerSpec.x)
            if __lux_tmp_x_28 == nil then
              __lux_tmp_x_28 = 0
            end
            local __lux_tmp_y_29 = toNumber(outerSpec.y)
            if __lux_tmp_y_29 == nil then
              __lux_tmp_y_29 = 0
            end
            local __lux_tmp_grow_30 = toNumber(outerSpec.grow)
            if __lux_tmp_grow_30 == nil then
              __lux_tmp_grow_30 = 0
            end
            outerSpread = mathAbs(__lux_tmp_x_28) + mathAbs(__lux_tmp_y_29) + effectExtentFromSpec(outerSpec, 18) + __lux_tmp_grow_30
          end
        end
        spread = mathMax(spread, outerSpread)
      end
      if backdropSpec ~= nil then
        do
          local __lux_tmp_padding_31 = toNumber(backdropSpec.padding)
          if __lux_tmp_padding_31 == nil then
            __lux_tmp_padding_31 = 0
          end
          spread = mathMax(spread, mathMax(0, __lux_tmp_padding_31))
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
      local point = verts[index]
      if point == nil then
        point = {}
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
      if w <= 0 or h <= 0 then
        return verts
      end
      do
        local __lux_tmp_radius_32 = toNumber(radius)
        if __lux_tmp_radius_32 == nil then
          __lux_tmp_radius_32 = 0
        end
        radius = mathMin(mathMax(0, __lux_tmp_radius_32), w * 0.5, h * 0.5)
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
        local __lux_tmp_width_33 = toNumber(width)
        if __lux_tmp_width_33 == nil then
          __lux_tmp_width_33 = 1
        end
        width = mathMax(1, __lux_tmp_width_33)
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
        local __lux_tmp_fill_34 = drawStyle.fill
        if __lux_tmp_fill_34 == nil then
          __lux_tmp_fill_34 = drawStyle.color
        end
        fill = hotFillFromStyle(__lux_tmp_fill_34)
      end
      local radius = drawStyle.radius
      if radius == nil then
        radius = drawStyle.r
        if radius == nil then
          radius = 0
        end
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
      if glow == nil or glow == false then
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
      if cached ~= nil and cached._colorInput == glow.color and cached._tintInput == glow.tint and cached._sizeInput == glow.size and cached._widthInput == glow.width and cached._opacityInput == glow.opacity and cached._strengthInput == glow.strength and cached._falloffInput == glow.falloff and cached._softnessInput == glow.softness then
        return cached
      end
      local color
      do
        local __lux_tmp_color_35 = glow.color
        if __lux_tmp_color_35 == nil then
          __lux_tmp_color_35 = glow.tint
        end
        color = style.asColor(__lux_tmp_color_35, defaultInnerGlowColor)
      end
      local width
      do
        local __lux_tmp_size_36 = glow.size
        if __lux_tmp_size_36 == nil then
          __lux_tmp_size_36 = glow.width
        end
        local __lux_tmp_size_37 = toNumber(__lux_tmp_size_36)
        if __lux_tmp_size_37 == nil then
          __lux_tmp_size_37 = 7
        end
        width = mathMax(1, __lux_tmp_size_37)
      end
      local strength
      do
        local __lux_tmp_opacity_38 = glow.opacity
        if __lux_tmp_opacity_38 == nil then
          __lux_tmp_opacity_38 = glow.strength
        end
        strength = toNumber(__lux_tmp_opacity_38)
        if strength == nil then
          strength = 1
        end
      end
      local falloff = toNumber(glow.falloff)
      if falloff == nil then
        falloff = style.glowSoftnessToFalloff(glow.softness, 0.55)
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
      local x = input.x
      if x == nil then
        x = input.offsetX
        if x == nil then
          x = input.dx
          if x == nil then
            x = input[1]
          end
        end
      end
      local y = input.y
      if y == nil then
        y = input.offsetY
        if y == nil then
          y = input.dy
          if y == nil then
            y = input[2]
          end
        end
      end
      local offset = input.offset
      if typeOf(offset) == "table" then
        if x == nil then
          x = offset.x
          if x == nil then
            x = offset[1]
          end
        end
        if y == nil then
          y = offset.y
          if y == nil then
            y = offset[2]
          end
        end
      end
      local __lux_tmp_x_39 = toNumber(x)
      if __lux_tmp_x_39 == nil then
        __lux_tmp_x_39 = fallbackX
      end
      local __lux_tmp_y_40 = toNumber(y)
      if __lux_tmp_y_40 == nil then
        __lux_tmp_y_40 = fallbackY
      end
      return __lux_tmp_x_39, __lux_tmp_y_40
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
        local __lux_tmp_base_41 = toNumber(base)
        if __lux_tmp_base_41 == nil then
          __lux_tmp_base_41 = minPad
        end
        pad = mathMax(minPad, __lux_tmp_base_41)
      end
      local ox = toNumber(x)
      if ox == nil then
        ox = 0
      end
      local oy = toNumber(y)
      if oy == nil then
        oy = 0
      end
      return mathMax(minPad, pad - ox), mathMax(minPad, pad - oy), mathMax(minPad, pad + ox), mathMax(minPad, pad + oy)
    end
    outerGlowStyle = function(glow)
      if glow == nil or glow == false then
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
      if cached ~= nil and cached._xInput == glow.x and cached._offsetXInput == glow.offsetX and cached._dxInput == glow.dx and cached._indexXInput == glow[1] and cached._yInput == glow.y and cached._offsetYInput == glow.offsetY and cached._dyInput == glow.dy and cached._indexYInput == glow[2] and cached._sizeInput == glow.size and cached._widthInput == glow.width and cached._blurInput == glow.blur and cached._radiusInput == glow.radius and cached._spreadInput == glow.spread and cached._colorInput == glow.color and cached._tintInput == glow.tint and cached._growInput == glow.grow and cached._expandInput == glow.expand and cached._shapeSpreadInput == glow.shapeSpread and cached._opacityInput == glow.opacity and cached._strengthInput == glow.strength and cached._falloffInput == glow.falloff and cached._softnessInput == glow.softness then
        return cached
      end
      local x, y = effectOffset(glow, 0, 0)
      local width
      do
        local __lux_tmp_size_42 = glow.size
        if __lux_tmp_size_42 == nil then
          __lux_tmp_size_42 = glow.width
        end
        if __lux_tmp_size_42 == nil then
          __lux_tmp_size_42 = glow.blur
        end
        if __lux_tmp_size_42 == nil then
          __lux_tmp_size_42 = glow.radius
        end
        if __lux_tmp_size_42 == nil then
          __lux_tmp_size_42 = glow.spread
        end
        local __lux_tmp_size_43 = toNumber(__lux_tmp_size_42)
        if __lux_tmp_size_43 == nil then
          __lux_tmp_size_43 = 18
        end
        width = mathMax(1, __lux_tmp_size_43)
      end
      local color
      do
        local __lux_tmp_color_44 = glow.color
        if __lux_tmp_color_44 == nil then
          __lux_tmp_color_44 = glow.tint
        end
        color = style.asColor(__lux_tmp_color_44, defaultOuterGlowColor)
      end
      local spread
      do
        local __lux_tmp_spread_45 = toNumber(glow.spread)
        if __lux_tmp_spread_45 == nil then
          __lux_tmp_spread_45 = width
        end
        spread = mathMax(1, __lux_tmp_spread_45)
      end
      local grow
      do
        local __lux_tmp_grow_46 = glow.grow
        if __lux_tmp_grow_46 == nil then
          __lux_tmp_grow_46 = glow.expand
        end
        if __lux_tmp_grow_46 == nil then
          __lux_tmp_grow_46 = glow.shapeSpread
        end
        local __lux_tmp_grow_47 = toNumber(__lux_tmp_grow_46)
        if __lux_tmp_grow_47 == nil then
          __lux_tmp_grow_47 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_47)
      end
      local strength
      do
        local __lux_tmp_opacity_48 = glow.opacity
        if __lux_tmp_opacity_48 == nil then
          __lux_tmp_opacity_48 = glow.strength
        end
        strength = toNumber(__lux_tmp_opacity_48)
        if strength == nil then
          strength = 1
        end
      end
      local falloff = toNumber(glow.falloff)
      if falloff == nil then
        falloff = style.glowSoftnessToFalloff(glow.softness, 0.54)
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
      if shadow == nil or shadow == false then
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
          local __lux_tmp_shadow_49 = toNumber(shadow)
          if __lux_tmp_shadow_49 == nil then
            __lux_tmp_shadow_49 = 12
          end
          blur = mathMax(0.001, __lux_tmp_shadow_49)
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
      if cached ~= nil and cached._xInput == shadow.x and cached._offsetXInput == shadow.offsetX and cached._dxInput == shadow.dx and cached._indexXInput == shadow[1] and cached._yInput == shadow.y and cached._offsetYInput == shadow.offsetY and cached._dyInput == shadow.dy and cached._indexYInput == shadow[2] and cached._blurInput == shadow.blur and cached._radiusInput == shadow.radius and cached._sizeInput == shadow.size and cached._widthInput == shadow.width and cached._spreadInput == shadow.spread and cached._growInput == shadow.grow and cached._expandInput == shadow.expand and cached._shapeSpreadInput == shadow.shapeSpread and cached._colorInput == shadow.color and cached._tintInput == shadow.tint and cached._extentInput == shadow.extent and cached._paddingInput == shadow.padding and cached._opacityInput == shadow.opacity and cached._strengthInput == shadow.strength and cached._falloffInput == shadow.falloff and cached._softnessInput == shadow.softness then
        return cached
      end
      local x, y = effectOffset(shadow, 0, 4)
      local blur
      do
        local __lux_tmp_blur_50 = shadow.blur
        if __lux_tmp_blur_50 == nil then
          __lux_tmp_blur_50 = shadow.radius
        end
        if __lux_tmp_blur_50 == nil then
          __lux_tmp_blur_50 = shadow.size
        end
        if __lux_tmp_blur_50 == nil then
          __lux_tmp_blur_50 = shadow.width
        end
        local __lux_tmp_blur_51 = toNumber(__lux_tmp_blur_50)
        if __lux_tmp_blur_51 == nil then
          __lux_tmp_blur_51 = 12
        end
        blur = mathMax(0.001, __lux_tmp_blur_51)
      end
      local grow
      do
        local __lux_tmp_spread_52 = shadow.spread
        if __lux_tmp_spread_52 == nil then
          __lux_tmp_spread_52 = shadow.grow
        end
        if __lux_tmp_spread_52 == nil then
          __lux_tmp_spread_52 = shadow.expand
        end
        if __lux_tmp_spread_52 == nil then
          __lux_tmp_spread_52 = shadow.shapeSpread
        end
        local __lux_tmp_spread_53 = toNumber(__lux_tmp_spread_52)
        if __lux_tmp_spread_53 == nil then
          __lux_tmp_spread_53 = 0
        end
        grow = mathMax(0, __lux_tmp_spread_53)
      end
      local color
      do
        local __lux_tmp_color_54 = shadow.color
        if __lux_tmp_color_54 == nil then
          __lux_tmp_color_54 = shadow.tint
        end
        color = style.asColor(__lux_tmp_color_54, defaultShadowColor)
      end
      local spread
      do
        local __lux_tmp_extent_55 = shadow.extent
        if __lux_tmp_extent_55 == nil then
          __lux_tmp_extent_55 = shadow.padding
        end
        local __lux_tmp_extent_56 = toNumber(__lux_tmp_extent_55)
        if __lux_tmp_extent_56 == nil then
          __lux_tmp_extent_56 = blur
        end
        spread = mathMax(1, __lux_tmp_extent_56)
      end
      local strength
      do
        local __lux_tmp_opacity_57 = shadow.opacity
        if __lux_tmp_opacity_57 == nil then
          __lux_tmp_opacity_57 = shadow.strength
        end
        strength = toNumber(__lux_tmp_opacity_57)
        if strength == nil then
          strength = 1
        end
      end
      local falloff = toNumber(shadow.falloff)
      if falloff == nil then
        falloff = style.glowSoftnessToFalloff(shadow.softness, 0.62)
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
      if pattern == nil or pattern == false then
        return nil
      end
      if pattern == true then
        return style.stripePattern(makeColor(255, 255, 255, 20), 10, 2, 135)
      end
      if typeOf(pattern) == "table" then
        local knownPattern
        local __lux_match_58 = pattern.kind
        if __lux_match_58 == "stripe" or __lux_match_58 == "smoke" then
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
        local __lux_obj_pattern_59 = pattern
        local __lux_val_offset_60 = nil
        if __lux_obj_pattern_59 ~= nil then
          __lux_val_offset_60 = __lux_obj_pattern_59.offset
        end
        offset = toNumber(__lux_val_offset_60)
        if offset == nil then
          offset = 0
        end
      end
      local speed
      do
        local __lux_obj_pattern_61 = pattern
        local __lux_val_speed_62 = nil
        if __lux_obj_pattern_61 ~= nil then
          __lux_val_speed_62 = __lux_obj_pattern_61.speed
        end
        speed = toNumber(__lux_val_speed_62)
        if speed == nil then
          speed = 0
        end
      end
      if speed ~= 0 and realTime ~= nil then
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
      local __lux_match_63 = fill
      local __lux_tag_64
      if __lux_match_63 ~= nil then
        __lux_tag_64 = __lux_match_63.kind
      end
      if __lux_tag_64 == style.FILL_LINEAR then
        local x1 = __lux_match_63.x1
        local y1 = __lux_match_63.y1
        local x2 = __lux_match_63.x2
        local y2 = __lux_match_63.y2
        do
          local __lux_tmp_x1_65 = x1
          if __lux_tmp_x1_65 == nil then
            __lux_tmp_x1_65 = 0
          end
          p0 = __lux_tmp_x1_65
        end
        do
          local __lux_tmp_y1_66 = y1
          if __lux_tmp_y1_66 == nil then
            __lux_tmp_y1_66 = 0
          end
          p1 = __lux_tmp_y1_66
        end
        do
          local __lux_tmp_x2_67 = x2
          if __lux_tmp_x2_67 == nil then
            __lux_tmp_x2_67 = 1
          end
          p2 = __lux_tmp_x2_67
        end
        do
          local __lux_tmp_y2_68 = y2
          if __lux_tmp_y2_68 == nil then
            __lux_tmp_y2_68 = 1
          end
          p3 = __lux_tmp_y2_68
        end
        style.bindGradientLut(material, fill)
      elseif __lux_tag_64 == style.FILL_RADIAL then
        local cx = __lux_match_63.cx
        local cy = __lux_match_63.cy
        local radius = __lux_match_63.radius
        do
          local __lux_tmp_cx_69 = cx
          if __lux_tmp_cx_69 == nil then
            __lux_tmp_cx_69 = 0.5
          end
          p0 = __lux_tmp_cx_69
        end
        do
          local __lux_tmp_cy_70 = cy
          if __lux_tmp_cy_70 == nil then
            __lux_tmp_cy_70 = 0.5
          end
          p1 = __lux_tmp_cy_70
        end
        do
          local __lux_tmp_radius_71 = radius
          if __lux_tmp_radius_71 == nil then
            __lux_tmp_radius_71 = 0.5
          end
          p2 = __lux_tmp_radius_71
        end
        p3 = 0
        style.bindGradientLut(material, fill)
      elseif __lux_tag_64 == style.FILL_CONIC then
        local cx = __lux_match_63.cx
        local cy = __lux_match_63.cy
        local rotation = __lux_match_63.rotation
        do
          local __lux_tmp_cx_72 = cx
          if __lux_tmp_cx_72 == nil then
            __lux_tmp_cx_72 = 0.5
          end
          p0 = __lux_tmp_cx_72
        end
        do
          local __lux_tmp_cy_73 = cy
          if __lux_tmp_cy_73 == nil then
            __lux_tmp_cy_73 = 0.5
          end
          p1 = __lux_tmp_cy_73
        end
        p2 = style.normalizedRotation(rotation)
        p3 = 0
        style.bindGradientLut(material, fill)
      else
        local __lux_unused_74 = nil
      end
      return p0, p1, p2, p3
    end
    inv255 = 1 / 255
    setupParamMatrix = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3)
      if material == nil or paramMatrixSetUnpacked == nil or matrixCtor == nil then
        return false
      end
      local matrix = paramMatrices[material]
      if matrix == nil then
        matrix = matrixCtor()
        paramMatrices[material] = matrix
      end
      do
        local __lux_tmp_a0_75 = a0
        if __lux_tmp_a0_75 == nil then
          __lux_tmp_a0_75 = 0
        end
        local __lux_tmp_b0_76 = b0
        if __lux_tmp_b0_76 == nil then
          __lux_tmp_b0_76 = 0
        end
        local __lux_tmp_c0_77 = c0
        if __lux_tmp_c0_77 == nil then
          __lux_tmp_c0_77 = 0
        end
        local __lux_tmp_d0_78 = d0
        if __lux_tmp_d0_78 == nil then
          __lux_tmp_d0_78 = 0
        end
        local __lux_tmp_a1_79 = a1
        if __lux_tmp_a1_79 == nil then
          __lux_tmp_a1_79 = 0
        end
        local __lux_tmp_b1_80 = b1
        if __lux_tmp_b1_80 == nil then
          __lux_tmp_b1_80 = 0
        end
        local __lux_tmp_c1_81 = c1
        if __lux_tmp_c1_81 == nil then
          __lux_tmp_c1_81 = 0
        end
        local __lux_tmp_d1_82 = d1
        if __lux_tmp_d1_82 == nil then
          __lux_tmp_d1_82 = 0
        end
        local __lux_tmp_a2_83 = a2
        if __lux_tmp_a2_83 == nil then
          __lux_tmp_a2_83 = 0
        end
        local __lux_tmp_b2_84 = b2
        if __lux_tmp_b2_84 == nil then
          __lux_tmp_b2_84 = 0
        end
        local __lux_tmp_c2_85 = c2
        if __lux_tmp_c2_85 == nil then
          __lux_tmp_c2_85 = 0
        end
        local __lux_tmp_d2_86 = d2
        if __lux_tmp_d2_86 == nil then
          __lux_tmp_d2_86 = 0
        end
        local __lux_tmp_a3_87 = a3
        if __lux_tmp_a3_87 == nil then
          __lux_tmp_a3_87 = 0
        end
        local __lux_tmp_b3_88 = b3
        if __lux_tmp_b3_88 == nil then
          __lux_tmp_b3_88 = 0
        end
        local __lux_tmp_c3_89 = c3
        if __lux_tmp_c3_89 == nil then
          __lux_tmp_c3_89 = 0
        end
        local __lux_tmp_d3_90 = d3
        if __lux_tmp_d3_90 == nil then
          __lux_tmp_d3_90 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_a0_75,
          __lux_tmp_b0_76,
          __lux_tmp_c0_77,
          __lux_tmp_d0_78,
          __lux_tmp_a1_79,
          __lux_tmp_b1_80,
          __lux_tmp_c1_81,
          __lux_tmp_d1_82,
          __lux_tmp_a2_83,
          __lux_tmp_b2_84,
          __lux_tmp_c2_85,
          __lux_tmp_d2_86,
          __lux_tmp_a3_87,
          __lux_tmp_b3_88,
          __lux_tmp_c3_89,
          __lux_tmp_d3_90
        )
      end
      material:SetMatrix("$viewprojmat", matrix)
      return true
    end
    setupParamMatrixRaw = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3)
      local state = paramMatrixRawState[material]
      if state ~= nil and state[1] == a0 and state[2] == a1 and state[3] == a2 and state[4] == a3 and state[5] == b0 and state[6] == b1 and state[7] == b2 and state[8] == b3 and state[9] == c0 and state[10] == c1 and state[11] == c2 and state[12] == c3 and state[13] == d0 and state[14] == d1 and state[15] == d2 and state[16] == d3 then
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
      if material == nil or paramMatrixSetUnpacked == nil or matrixCtor == nil then
        return false
      end
      local matrix = auxParamMatrices[material]
      if matrix == nil then
        matrix = matrixCtor()
        auxParamMatrices[material] = matrix
      end
      do
        local __lux_tmp_a0_91 = a0
        if __lux_tmp_a0_91 == nil then
          __lux_tmp_a0_91 = 0
        end
        local __lux_tmp_b0_92 = b0
        if __lux_tmp_b0_92 == nil then
          __lux_tmp_b0_92 = 0
        end
        local __lux_tmp_c0_93 = c0
        if __lux_tmp_c0_93 == nil then
          __lux_tmp_c0_93 = 0
        end
        local __lux_tmp_d0_94 = d0
        if __lux_tmp_d0_94 == nil then
          __lux_tmp_d0_94 = 0
        end
        local __lux_tmp_a1_95 = a1
        if __lux_tmp_a1_95 == nil then
          __lux_tmp_a1_95 = 0
        end
        local __lux_tmp_b1_96 = b1
        if __lux_tmp_b1_96 == nil then
          __lux_tmp_b1_96 = 0
        end
        local __lux_tmp_c1_97 = c1
        if __lux_tmp_c1_97 == nil then
          __lux_tmp_c1_97 = 0
        end
        local __lux_tmp_d1_98 = d1
        if __lux_tmp_d1_98 == nil then
          __lux_tmp_d1_98 = 0
        end
        local __lux_tmp_a2_99 = a2
        if __lux_tmp_a2_99 == nil then
          __lux_tmp_a2_99 = 0
        end
        local __lux_tmp_b2_100 = b2
        if __lux_tmp_b2_100 == nil then
          __lux_tmp_b2_100 = 0
        end
        local __lux_tmp_c2_101 = c2
        if __lux_tmp_c2_101 == nil then
          __lux_tmp_c2_101 = 0
        end
        local __lux_tmp_d2_102 = d2
        if __lux_tmp_d2_102 == nil then
          __lux_tmp_d2_102 = 0
        end
        local __lux_tmp_a3_103 = a3
        if __lux_tmp_a3_103 == nil then
          __lux_tmp_a3_103 = 0
        end
        local __lux_tmp_b3_104 = b3
        if __lux_tmp_b3_104 == nil then
          __lux_tmp_b3_104 = 0
        end
        local __lux_tmp_c3_105 = c3
        if __lux_tmp_c3_105 == nil then
          __lux_tmp_c3_105 = 0
        end
        local __lux_tmp_d3_106 = d3
        if __lux_tmp_d3_106 == nil then
          __lux_tmp_d3_106 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_a0_91,
          __lux_tmp_b0_92,
          __lux_tmp_c0_93,
          __lux_tmp_d0_94,
          __lux_tmp_a1_95,
          __lux_tmp_b1_96,
          __lux_tmp_c1_97,
          __lux_tmp_d1_98,
          __lux_tmp_a2_99,
          __lux_tmp_b2_100,
          __lux_tmp_c2_101,
          __lux_tmp_d2_102,
          __lux_tmp_a3_103,
          __lux_tmp_b3_104,
          __lux_tmp_c3_105,
          __lux_tmp_d3_106
        )
      end
      material:SetMatrix("$invviewprojmat", matrix)
      return true
    end
    setupAuxConstantsRaw = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3)
      local state = auxParamMatrixRawState[material]
      if state ~= nil and state[1] == a0 and state[2] == a1 and state[3] == a2 and state[4] == a3 and state[5] == b0 and state[6] == b1 and state[7] == b2 and state[8] == b3 and state[9] == c0 and state[10] == c1 and state[11] == c2 and state[12] == c3 and state[13] == d0 and state[14] == d1 and state[15] == d2 and state[16] == d3 then
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
      if fill == nil then
        fill = style.solid(color_white)
      end
      local colorA = fill.colorA
      if colorA == nil then
        colorA = color_white
      end
      local colorB = fill.colorB
      if colorB == nil then
        colorB = colorA
      end
      local strokeColor = stroke
      if strokeColor == nil then
        strokeColor = transparentColor
      end
      local fillKind = fill.kind
      if fillKind == nil then
        fillKind = style.FILL_SOLID
      end
      local packedStyle = mathClamp(style.strokeWidth(strokeWidth, 0), 0, 255) + mathClamp(fillKind, 0, 3) * 256
      local r, g, b, a = style.color01(colorB)
      local p0, p1, p2, p3 = roundRectFillParams(material, fill)
      local sr, sg, sb, sa = style.color01(strokeColor)
      do
        local __lux_tmp_radius_107 = toNumber(radius)
        if __lux_tmp_radius_107 == nil then
          __lux_tmp_radius_107 = 0
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
          mathMax(0, __lux_tmp_radius_107),
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
      if fill == nil then
        fill = style.solid(color_white)
      end
      local colorB = fill.colorB
      if colorB == nil then
        colorB = fill.colorA
        if colorB == nil then
          colorB = color_white
        end
      end
      local fillKind = fill.kind
      if fillKind == nil then
        fillKind = style.FILL_SOLID
      end
      local strokePx
      if stroke ~= nil then
        strokePx = strokeWidth
      else
        strokePx = 0
      end
      if strokePx <= 0 or stroke ~= nil and stroke.a ~= nil and stroke.a <= 0 then
        strokePx = 0
      else
        if strokePx > 255 then
          strokePx = 255
        end
      end
      local r
      do
        local __lux_tmp_r_108 = colorB.r
        if __lux_tmp_r_108 == nil then
          __lux_tmp_r_108 = 0
        end
        r = __lux_tmp_r_108 * inv255
      end
      local g
      do
        local __lux_tmp_g_109 = colorB.g
        if __lux_tmp_g_109 == nil then
          __lux_tmp_g_109 = 0
        end
        g = __lux_tmp_g_109 * inv255
      end
      local b
      do
        local __lux_tmp_b_110 = colorB.b
        if __lux_tmp_b_110 == nil then
          __lux_tmp_b_110 = 0
        end
        b = __lux_tmp_b_110 * inv255
      end
      local a
      do
        local __lux_tmp_a_111 = colorB.a
        if __lux_tmp_a_111 == nil then
          __lux_tmp_a_111 = 255
        end
        a = __lux_tmp_a_111 * inv255
      end
      local p0, p1, p2, p3 = roundRectFillParams(material, fill)
      local sr = 0
      local sg = 0
      local sb = 0
      local sa = 0
      if strokePx > 0 then
        do
          local __lux_tmp_r_112 = stroke.r
          if __lux_tmp_r_112 == nil then
            __lux_tmp_r_112 = 0
          end
          sr = __lux_tmp_r_112 * inv255
        end
        do
          local __lux_tmp_g_113 = stroke.g
          if __lux_tmp_g_113 == nil then
            __lux_tmp_g_113 = 0
          end
          sg = __lux_tmp_g_113 * inv255
        end
        do
          local __lux_tmp_b_114 = stroke.b
          if __lux_tmp_b_114 == nil then
            __lux_tmp_b_114 = 0
          end
          sb = __lux_tmp_b_114 * inv255
        end
        do
          local __lux_tmp_a_115 = stroke.a
          if __lux_tmp_a_115 == nil then
            __lux_tmp_a_115 = 255
          end
          sa = __lux_tmp_a_115 * inv255
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
        local __lux_tmp_color_116 = pattern.color
        if __lux_tmp_color_116 == nil then
          __lux_tmp_color_116 = pattern.tint
        end
        color = style.asColor(__lux_tmp_color_116, makeColor(255, 255, 255, 24))
      end
      local r, g, b, a = style.color01(color)
      local angle
      do
        local __lux_tmp_angle_117 = toNumber(pattern.angle)
        if __lux_tmp_angle_117 == nil then
          __lux_tmp_angle_117 = 135
        end
        angle = mathRad(__lux_tmp_angle_117)
      end
      local smoke
      local __lux_match_118 = pattern.kind
      if __lux_match_118 == "smoke" then
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
          local __lux_tmp_scale_119 = toNumber(pattern.scale)
          if __lux_tmp_scale_119 == nil then
            __lux_tmp_scale_119 = 140
          end
          pz = mathMax(1, __lux_tmp_scale_119)
        end
        do
          local __lux_tmp_density_120 = toNumber(pattern.density)
          if __lux_tmp_density_120 == nil then
            __lux_tmp_density_120 = 0.48
          end
          pw = mathClamp(__lux_tmp_density_120, 0, 1)
        end
        ox = patternOffset(pattern)
        oy = 1
        do
          local __lux_tmp_softness_121 = toNumber(pattern.softness)
          if __lux_tmp_softness_121 == nil then
            __lux_tmp_softness_121 = 0.3
          end
          oz = mathMax(0.001, __lux_tmp_softness_121)
        end
        do
          local __lux_tmp_warp_122 = toNumber(pattern.warp)
          if __lux_tmp_warp_122 == nil then
            __lux_tmp_warp_122 = 0.85
          end
          ow = mathMax(0, __lux_tmp_warp_122)
        end
      else
        do
          local __lux_tmp_spacing_123 = toNumber(pattern.spacing)
          if __lux_tmp_spacing_123 == nil then
            __lux_tmp_spacing_123 = 12
          end
          pz = mathMax(1, __lux_tmp_spacing_123)
        end
        do
          local __lux_tmp_width_124 = toNumber(pattern.width)
          if __lux_tmp_width_124 == nil then
            __lux_tmp_width_124 = 2
          end
          pw = mathMax(0.25, __lux_tmp_width_124)
        end
        ox = patternOffset(pattern)
      end
      local __lux_tmp_125
      if smoke then
        __lux_tmp_125 = toNumber(pattern.seed)
        if __lux_tmp_125 == nil then
          __lux_tmp_125 = 0
        end
      else
        __lux_tmp_125 = 0
      end
      local __lux_tmp_radius_126 = toNumber(radius)
      if __lux_tmp_radius_126 == nil then
        __lux_tmp_radius_126 = 0
      end
      return setupParamMatrix(
        material,
        r,
        g,
        b,
        a,
        w,
        h,
        __lux_tmp_125,
        mathMax(0, __lux_tmp_radius_126),
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
      local color = fill.colorA
      if color == nil then
        color = color_white
      end
      do
        local __lux_tmp_r_127 = color.r
        if __lux_tmp_r_127 == nil then
          __lux_tmp_r_127 = 255
        end
        local __lux_tmp_g_128 = color.g
        if __lux_tmp_g_128 == nil then
          __lux_tmp_g_128 = 255
        end
        local __lux_tmp_b_129 = color.b
        if __lux_tmp_b_129 == nil then
          __lux_tmp_b_129 = 255
        end
        local __lux_tmp_a_130 = color.a
        if __lux_tmp_a_130 == nil then
          __lux_tmp_a_130 = 255
        end
        surfaceSetDrawColor(__lux_tmp_r_127, __lux_tmp_g_128, __lux_tmp_b_129, __lux_tmp_a_130)
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
      local color = fill.colorA
      if color == nil then
        color = color_white
      end
      do
        local __lux_tmp_r_131 = color.r
        if __lux_tmp_r_131 == nil then
          __lux_tmp_r_131 = 0
        end
        local __lux_tmp_g_132 = color.g
        if __lux_tmp_g_132 == nil then
          __lux_tmp_g_132 = 0
        end
        local __lux_tmp_b_133 = color.b
        if __lux_tmp_b_133 == nil then
          __lux_tmp_b_133 = 0
        end
        local __lux_tmp_a_134 = color.a
        if __lux_tmp_a_134 == nil then
          __lux_tmp_a_134 = 255
        end
        setupParamMatrixRaw(
          material,
          __lux_tmp_r_131 * inv255,
          __lux_tmp_g_132 * inv255,
          __lux_tmp_b_133 * inv255,
          __lux_tmp_a_134 * inv255,
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
      if spec == nil or not shadersActive() or not materialOK(roundRectMaterials.roundrect_pattern) then
        return false
      end
      local color = spec.color
      if color == nil then
        color = spec.tint
      end
      local __lux_tmp_137 = color ~= nil
      if __lux_tmp_137 then
        local __lux_tmp_a_136 = color.a
        if __lux_tmp_a_136 == nil then
          __lux_tmp_a_136 = 255
        end
        __lux_tmp_137 = __lux_tmp_a_136 <= 0
      end
      if __lux_tmp_137 then
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
        local __lux_tmp_grow_138 = toNumber(grow)
        if __lux_tmp_grow_138 == nil then
          __lux_tmp_grow_138 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_138)
      end
      if grow <= 0 then
        return radius
      end
      if typeOf(radius) == "table" and not style.isColor(radius) then
        local __lux_tmp_tl_139 = radius.tl
        if __lux_tmp_tl_139 == nil then
          __lux_tmp_tl_139 = radius[1]
        end
        local __lux_tmp_tl_140 = toNumber(__lux_tmp_tl_139)
        if __lux_tmp_tl_140 == nil then
          __lux_tmp_tl_140 = 0
        end
        local __lux_tmp_tr_141 = radius.tr
        if __lux_tmp_tr_141 == nil then
          __lux_tmp_tr_141 = radius[2]
        end
        if __lux_tmp_tr_141 == nil then
          __lux_tmp_tr_141 = radius.tl
        end
        if __lux_tmp_tr_141 == nil then
          __lux_tmp_tr_141 = radius[1]
        end
        local __lux_tmp_tr_142 = toNumber(__lux_tmp_tr_141)
        if __lux_tmp_tr_142 == nil then
          __lux_tmp_tr_142 = 0
        end
        local __lux_tmp_br_143 = radius.br
        if __lux_tmp_br_143 == nil then
          __lux_tmp_br_143 = radius[3]
        end
        if __lux_tmp_br_143 == nil then
          __lux_tmp_br_143 = radius.tr
        end
        if __lux_tmp_br_143 == nil then
          __lux_tmp_br_143 = radius[2]
        end
        if __lux_tmp_br_143 == nil then
          __lux_tmp_br_143 = radius.tl
        end
        if __lux_tmp_br_143 == nil then
          __lux_tmp_br_143 = radius[1]
        end
        local __lux_tmp_br_144 = toNumber(__lux_tmp_br_143)
        if __lux_tmp_br_144 == nil then
          __lux_tmp_br_144 = 0
        end
        local __lux_tmp_bl_145 = radius.bl
        if __lux_tmp_bl_145 == nil then
          __lux_tmp_bl_145 = radius[4]
        end
        if __lux_tmp_bl_145 == nil then
          __lux_tmp_bl_145 = radius.br
        end
        if __lux_tmp_bl_145 == nil then
          __lux_tmp_bl_145 = radius[3]
        end
        if __lux_tmp_bl_145 == nil then
          __lux_tmp_bl_145 = radius.tr
        end
        if __lux_tmp_bl_145 == nil then
          __lux_tmp_bl_145 = radius[2]
        end
        if __lux_tmp_bl_145 == nil then
          __lux_tmp_bl_145 = radius.tl
        end
        if __lux_tmp_bl_145 == nil then
          __lux_tmp_bl_145 = radius[1]
        end
        local __lux_tmp_bl_146 = toNumber(__lux_tmp_bl_145)
        if __lux_tmp_bl_146 == nil then
          __lux_tmp_bl_146 = 0
        end
        return {
          tl = mathMax(0, __lux_tmp_tl_140) + grow,
          tr = mathMax(0, __lux_tmp_tr_142) + grow,
          br = mathMax(0, __lux_tmp_br_144) + grow,
          bl = mathMax(0, __lux_tmp_bl_146) + grow,
        }
      end
      local __lux_tmp_radius_147 = toNumber(radius)
      if __lux_tmp_radius_147 == nil then
        __lux_tmp_radius_147 = 0
      end
      return __lux_tmp_radius_147 + grow
    end
    effectExtent = function(spec, defaultWidth)
      if defaultWidth == nil then
        defaultWidth = 18
      end
      return effectExtentFromSpec(spec, defaultWidth)
    end
    drawRoundRectInnerGlowSpec = function(x, y, w, h, radius, spec)
      local __lux_tmp_150 = spec == nil or spec.color == nil
      if not __lux_tmp_150 then
        local __lux_tmp_a_149 = spec.color.a
        if __lux_tmp_a_149 == nil then
          __lux_tmp_a_149 = 255
        end
        __lux_tmp_150 = __lux_tmp_a_149 <= 0
      end
      local __lux_tmp_151 = __lux_tmp_150
      if not __lux_tmp_151 then
        __lux_tmp_151 = not shadersActive()
      end
      local __lux_tmp_152 = __lux_tmp_151
      if not __lux_tmp_152 then
        __lux_tmp_152 = not materialOK(roundRectMaterials.roundrect_innerglow)
      end
      if __lux_tmp_152 then
        return false
      end
      local material = roundRectMaterials.roundrect_innerglow
      local color = spec.color
      local glowWidth = spec.width
      if glowWidth == nil then
        glowWidth = 8
      end
      local glowStrength = spec.strength
      if glowStrength == nil then
        glowStrength = 1
      end
      local glowFalloff = spec.falloff
      if glowFalloff == nil then
        glowFalloff = 1.65
      end
      local setupTrace = roundRectTraceStart("round.innerGlow.setup")
      do
        local __lux_tmp_r_153 = color.r
        if __lux_tmp_r_153 == nil then
          __lux_tmp_r_153 = 0
        end
        local __lux_tmp_g_154 = color.g
        if __lux_tmp_g_154 == nil then
          __lux_tmp_g_154 = 0
        end
        local __lux_tmp_b_155 = color.b
        if __lux_tmp_b_155 == nil then
          __lux_tmp_b_155 = 0
        end
        local __lux_tmp_a_156 = color.a
        if __lux_tmp_a_156 == nil then
          __lux_tmp_a_156 = 255
        end
        setupParamMatrixRaw(
          material,
          __lux_tmp_r_153 * inv255,
          __lux_tmp_g_154 * inv255,
          __lux_tmp_b_155 * inv255,
          __lux_tmp_a_156 * inv255,
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
      if shadowSpec == nil and outerSpec == nil or not shadersActive() or not materialOK(roundRectMaterials.roundrect_shadow_outer) then
        return false
      end
      local shadowColor
      do
        local __lux_obj_shadowSpec_157 = shadowSpec
        local __lux_val_color_158 = nil
        if __lux_obj_shadowSpec_157 ~= nil then
          __lux_val_color_158 = __lux_obj_shadowSpec_157.color
        end
        shadowColor = __lux_val_color_158
      end
      local outerColor
      do
        local __lux_obj_outerSpec_159 = outerSpec
        local __lux_val_color_160 = nil
        if __lux_obj_outerSpec_159 ~= nil then
          __lux_val_color_160 = __lux_obj_outerSpec_159.color
        end
        outerColor = __lux_val_color_160
      end
      local hasShadow
      do
        local __lux_tmp_162 = shadowColor ~= nil
        if __lux_tmp_162 then
          local __lux_tmp_a_161 = shadowColor.a
          if __lux_tmp_a_161 == nil then
            __lux_tmp_a_161 = 255
          end
          __lux_tmp_162 = __lux_tmp_a_161 > 0
        end
        hasShadow = __lux_tmp_162
      end
      local hasOuter
      do
        local __lux_tmp_164 = outerColor ~= nil
        if __lux_tmp_164 then
          local __lux_tmp_a_163 = outerColor.a
          if __lux_tmp_a_163 == nil then
            __lux_tmp_a_163 = 255
          end
          __lux_tmp_164 = __lux_tmp_a_163 > 0
        end
        hasOuter = __lux_tmp_164
      end
      if not hasShadow and not hasOuter then
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
      local shadowSource = shadowSpec
      if shadowSource == nil then
        shadowSource = outerSpec
      end
      local outerSource = outerSpec
      if outerSource == nil then
        outerSource = shadowSpec
      end
      local shadowGrow = shadowSource.grow
      if shadowGrow == nil then
        shadowGrow = 0
      end
      local shadowGw = w + shadowGrow * 2
      local shadowGh = h + shadowGrow * 2
      local shadowSpread = shadowSource._extent
      if shadowSpread == nil then
        shadowSpread = shadowSource.spread
        if shadowSpread == nil then
          shadowSpread = shadowSource.width
          if shadowSpread == nil then
            shadowSpread = 18
          end
        end
      end
      local shadowShapeX
      do
        local __lux_tmp_165
        if hasShadow then
          __lux_tmp_165 = shadowSource.x
          if __lux_tmp_165 == nil then
            __lux_tmp_165 = 0
          end
        else
          __lux_tmp_165 = 0
        end
        shadowShapeX = x + __lux_tmp_165 - shadowGrow
      end
      local shadowShapeY
      do
        local __lux_tmp_166
        if hasShadow then
          __lux_tmp_166 = shadowSource.y
          if __lux_tmp_166 == nil then
            __lux_tmp_166 = 0
          end
        else
          __lux_tmp_166 = 0
        end
        shadowShapeY = y + __lux_tmp_166 - shadowGrow
      end
      local shadowDrawX = shadowShapeX - shadowSpread
      local shadowDrawY = shadowShapeY - shadowSpread
      local shadowDrawW = shadowGw + shadowSpread * 2
      local shadowDrawH = shadowGh + shadowSpread * 2
      local outerGrow = outerSource.grow
      if outerGrow == nil then
        outerGrow = 0
      end
      local outerGw = w + outerGrow * 2
      local outerGh = h + outerGrow * 2
      local outerSpread = outerSource._extent
      if outerSpread == nil then
        outerSpread = outerSource.spread
        if outerSpread == nil then
          outerSpread = outerSource.width
          if outerSpread == nil then
            outerSpread = 18
          end
        end
      end
      local outerOx
      if hasOuter then
        outerOx = outerSource.x
        if outerOx == nil then
          outerOx = 0
        end
      else
        outerOx = 0
      end
      local outerOy
      if hasOuter then
        outerOy = outerSource.y
        if outerOy == nil then
          outerOy = 0
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
        local __lux_tmp_167
        if hasShadow then
          do
            local __lux_tmp_r_168 = shadowColor.r
            if __lux_tmp_r_168 == nil then
              __lux_tmp_r_168 = 0
            end
            __lux_tmp_167 = __lux_tmp_r_168 * inv255
          end
        else
          __lux_tmp_167 = 0
        end
        local __lux_tmp_169
        if hasShadow then
          do
            local __lux_tmp_g_170 = shadowColor.g
            if __lux_tmp_g_170 == nil then
              __lux_tmp_g_170 = 0
            end
            __lux_tmp_169 = __lux_tmp_g_170 * inv255
          end
        else
          __lux_tmp_169 = 0
        end
        local __lux_tmp_171
        if hasShadow then
          do
            local __lux_tmp_b_172 = shadowColor.b
            if __lux_tmp_b_172 == nil then
              __lux_tmp_b_172 = 0
            end
            __lux_tmp_171 = __lux_tmp_b_172 * inv255
          end
        else
          __lux_tmp_171 = 0
        end
        local __lux_tmp_173
        if hasShadow then
          do
            local __lux_tmp_a_174 = shadowColor.a
            if __lux_tmp_a_174 == nil then
              __lux_tmp_a_174 = 255
            end
            __lux_tmp_173 = __lux_tmp_a_174 * inv255
          end
        else
          __lux_tmp_173 = 0
        end
        local __lux_tmp_175
        if hasShadow then
          __lux_tmp_175 = shadowSource.width
          if __lux_tmp_175 == nil then
            __lux_tmp_175 = 18
          end
        else
          __lux_tmp_175 = 1
        end
        local __lux_tmp_176
        if hasShadow then
          __lux_tmp_176 = shadowSource.strength
          if __lux_tmp_176 == nil then
            __lux_tmp_176 = 1
          end
        else
          __lux_tmp_176 = 0
        end
        local __lux_tmp_177
        if hasShadow then
          __lux_tmp_177 = shadowSource.falloff
          if __lux_tmp_177 == nil then
            __lux_tmp_177 = 1.9
          end
        else
          __lux_tmp_177 = 1
        end
        setupParamMatrixRaw(
          material,
          sw,
          sh,
          0,
          0,
          __lux_tmp_167,
          __lux_tmp_169,
          __lux_tmp_171,
          __lux_tmp_173,
          shadowShapeX - sx,
          shadowShapeY - sy,
          shadowGw,
          shadowGh,
          roundRectRadiusScalar(radiusWithGrow(radius, shadowGrow), shadowGw, shadowGh),
          __lux_tmp_175,
          __lux_tmp_176,
          __lux_tmp_177
        )
      end
      do
        local __lux_tmp_178
        if hasOuter then
          do
            local __lux_tmp_r_179 = outerColor.r
            if __lux_tmp_r_179 == nil then
              __lux_tmp_r_179 = 0
            end
            __lux_tmp_178 = __lux_tmp_r_179 * inv255
          end
        else
          __lux_tmp_178 = 0
        end
        local __lux_tmp_180
        if hasOuter then
          do
            local __lux_tmp_g_181 = outerColor.g
            if __lux_tmp_g_181 == nil then
              __lux_tmp_g_181 = 0
            end
            __lux_tmp_180 = __lux_tmp_g_181 * inv255
          end
        else
          __lux_tmp_180 = 0
        end
        local __lux_tmp_182
        if hasOuter then
          do
            local __lux_tmp_b_183 = outerColor.b
            if __lux_tmp_b_183 == nil then
              __lux_tmp_b_183 = 0
            end
            __lux_tmp_182 = __lux_tmp_b_183 * inv255
          end
        else
          __lux_tmp_182 = 0
        end
        local __lux_tmp_184
        if hasOuter then
          do
            local __lux_tmp_a_185 = outerColor.a
            if __lux_tmp_a_185 == nil then
              __lux_tmp_a_185 = 255
            end
            __lux_tmp_184 = __lux_tmp_a_185 * inv255
          end
        else
          __lux_tmp_184 = 0
        end
        local __lux_tmp_186
        if hasOuter then
          __lux_tmp_186 = outerSource.width
          if __lux_tmp_186 == nil then
            __lux_tmp_186 = 18
          end
        else
          __lux_tmp_186 = 1
        end
        local __lux_tmp_187
        if hasOuter then
          __lux_tmp_187 = outerSource.strength
          if __lux_tmp_187 == nil then
            __lux_tmp_187 = 1
          end
        else
          __lux_tmp_187 = 0
        end
        local __lux_tmp_188
        if hasOuter then
          __lux_tmp_188 = outerSource.falloff
          if __lux_tmp_188 == nil then
            __lux_tmp_188 = 1.9
          end
        else
          __lux_tmp_188 = 1
        end
        setupAuxConstantsRaw(
          material,
          __lux_tmp_178,
          __lux_tmp_180,
          __lux_tmp_182,
          __lux_tmp_184,
          outerShapeX - sx,
          outerShapeY - sy,
          outerGw,
          outerGh,
          roundRectRadiusScalar(radiusWithGrow(radius, outerGrow), outerGw, outerGh),
          __lux_tmp_186,
          __lux_tmp_187,
          __lux_tmp_188,
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
        local __lux_tmp_189
        if profiling then
          __lux_tmp_189 = roundRectProfileStart()
        else
          __lux_tmp_189 = nil
        end
        bleedProfile = __lux_tmp_189
      end
      bleedTrace = roundRectTraceStart("round.shadowOuter.bleedEnd")
      endPanelEffectBleed(bleedToken)
      roundRectTraceEnd(bleedTrace)
      if profiling then
        roundRectProfileEnd("round.shadowOuter.bleedEnd", bleedProfile)
      end
      return true
    end
    backdropTintColor = function(spec)
      if spec == nil or spec.tint == nil then
        return nil
      end
      local tint = spec.tint
      local alpha
      do
        local __lux_tmp_a_190 = tint.a
        if __lux_tmp_a_190 == nil then
          __lux_tmp_a_190 = 255
        end
        local __lux_tmp_opacity_191 = spec.opacity
        if __lux_tmp_opacity_191 == nil then
          __lux_tmp_opacity_191 = 1
        end
        alpha = __lux_tmp_a_190 * __lux_tmp_opacity_191
      end
      if alpha <= 0 then
        return nil
      end
      do
        local __lux_tmp_r_192 = tint.r
        if __lux_tmp_r_192 == nil then
          __lux_tmp_r_192 = 0
        end
        backdropTintScratch.r = __lux_tmp_r_192
      end
      do
        local __lux_tmp_g_193 = tint.g
        if __lux_tmp_g_193 == nil then
          __lux_tmp_g_193 = 0
        end
        backdropTintScratch.g = __lux_tmp_g_193
      end
      do
        local __lux_tmp_b_194 = tint.b
        if __lux_tmp_b_194 == nil then
          __lux_tmp_b_194 = 0
        end
        backdropTintScratch.b = __lux_tmp_b_194
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
        local __lux_tmp_padding_195 = toNumber(spec.padding)
        if __lux_tmp_padding_195 == nil then
          __lux_tmp_padding_195 = 0
        end
        pad = mathMax(0, __lux_tmp_padding_195)
      end
      local bx = x - pad
      local by = y - pad
      local bw = w + pad * 2
      local bh = h + pad * 2
      local br = radiusWithGrow(radius, pad)
      local tint = backdropTintColor(spec)
      local blurred = false
      if spec.blur > 0 and roundRectBlurRT ~= nil and renderCopyRenderTargetToTexture ~= nil and materialOK(roundRectMaterials.roundrect_blur) then
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
            local __lux_tmp_r_196 = tint.r
            if __lux_tmp_r_196 == nil then
              __lux_tmp_r_196 = 0
            end
            local __lux_tmp_g_197 = tint.g
            if __lux_tmp_g_197 == nil then
              __lux_tmp_g_197 = 0
            end
            local __lux_tmp_b_198 = tint.b
            if __lux_tmp_b_198 == nil then
              __lux_tmp_b_198 = 0
            end
            local __lux_tmp_a_199 = tint.a
            if __lux_tmp_a_199 == nil then
              __lux_tmp_a_199 = 255
            end
            setupAuxConstantsRaw(
              material,
              __lux_tmp_r_196 * inv255,
              __lux_tmp_g_197 * inv255,
              __lux_tmp_b_198 * inv255,
              __lux_tmp_a_199 * inv255,
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
      if tint ~= nil and not blurred then
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
        local color = innerSpec.color
        if color == nil then
          color = transparentColor
        end
        do
          local __lux_tmp_r_200 = color.r
          if __lux_tmp_r_200 == nil then
            __lux_tmp_r_200 = 0
          end
          gr = __lux_tmp_r_200 * inv255
        end
        do
          local __lux_tmp_g_201 = color.g
          if __lux_tmp_g_201 == nil then
            __lux_tmp_g_201 = 0
          end
          gg = __lux_tmp_g_201 * inv255
        end
        do
          local __lux_tmp_b_202 = color.b
          if __lux_tmp_b_202 == nil then
            __lux_tmp_b_202 = 0
          end
          gb = __lux_tmp_b_202 * inv255
        end
        do
          local __lux_tmp_a_203 = color.a
          if __lux_tmp_a_203 == nil then
            __lux_tmp_a_203 = 255
          end
          ga = __lux_tmp_a_203 * inv255
        end
        do
          local __lux_tmp_width_204 = toNumber(innerSpec.width)
          if __lux_tmp_width_204 == nil then
            __lux_tmp_width_204 = 8
          end
          glowWidth = mathMax(0.001, __lux_tmp_width_204)
        end
        do
          local __lux_tmp_strength_205 = toNumber(innerSpec.strength)
          if __lux_tmp_strength_205 == nil then
            __lux_tmp_strength_205 = 1
          end
          glowStrength = mathMax(0, __lux_tmp_strength_205)
        end
        do
          local __lux_tmp_falloff_206 = toNumber(innerSpec.falloff)
          if __lux_tmp_falloff_206 == nil then
            __lux_tmp_falloff_206 = 1.65
          end
          glowFalloff = mathMax(0.001, __lux_tmp_falloff_206)
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
      local styleValue = drawStyle
      if styleValue == nil then
        styleValue = emptyRoundRectStyle
      end
      local initTrace = roundRectTraceStart("round.init")
      local shaderReady = shadersActive()
      local transformActive = hasTransform()
      local radius = styleValue.radius
      if radius == nil then
        radius = styleValue.r
        if radius == nil then
          radius = 0
        end
      end
      local strokeValue = styleValue.stroke
      local strokeWidth = 0
      local hasStroke = false
      if strokeValue ~= nil then
        strokeWidth = style.strokeWidth(styleValue.strokeWidth, 0)
        hasStroke = strokeWidth > 0 and (strokeValue.a == nil or strokeValue.a > 0)
      end
      roundRectTraceEnd(initTrace)
      local noEffects = styleValue.shadow == nil and styleValue.outerGlow == nil and styleValue.innerGlow == nil and styleValue.backdrop == nil and styleValue.pattern == nil
      if noEffects and not hasStroke and not transformActive then
        local fastPrepareTrace = roundRectTraceStart("round.fast.prepare")
        local fill
        do
          local __lux_tmp_fill_207 = styleValue.fill
          if __lux_tmp_fill_207 == nil then
            __lux_tmp_fill_207 = styleValue.color
          end
          fill = hotFillFromStyle(__lux_tmp_fill_207)
        end
        local hasFill = style.fillVisible(fill)
        if hasFill and fill.kind == style.FILL_SOLID then
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
          if shaderReady and drawSolidRoundFast(x, y, w, h, radiusValue, fill) then
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
      if backdropInput ~= nil and backdropInput ~= false then
        backdropSpec = style.backdropStyle(backdropInput)
      else
        backdropSpec = nil
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
      if not transformActive and frame.isCulled(x - cullSpread, y - cullSpread, w + cullSpread * 2, h + cullSpread * 2) then
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
      if shadowSpec ~= nil or outerSpec ~= nil then
        local profile
        if profiling then
          profile = roundRectProfileStart()
        else
          profile = nil
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
        local profile
        if profiling then
          profile = roundRectProfileStart()
        else
          profile = nil
        end
        local backdropPassTrace = roundRectTraceStart("round.backdrop")
        backdrop = drawRoundRectBackdrop(x, y, w, h, radius, backdropSpec)
        roundRectTraceEnd(backdropPassTrace)
        if profiling then
          roundRectProfileEnd("round.backdrop", profile)
        end
      end
      local effectOnly = backdrop == nil and not hasStroke and styleValue.pattern == nil and styleValue.innerGlow == nil and (shadowSpec ~= nil or outerSpec ~= nil)
      local fillInput = styleValue.fill
      if fillInput == nil then
        fillInput = styleValue.color
      end
      if effectOnly and not hotFillVisible(fillInput) then
        if profiling then
          finishImmediateTrace(trace, profiling, totalProfile)
        else
          finishImmediateTrace(trace, profiling, totalProfile)
        end
        return
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
      if backdrop == nil and not hasFill and not hasStroke and styleValue.pattern == nil and innerSpec == nil then
        finishImmediateTrace(trace, profiling, totalProfile)
        return
      end
      local innerGlowDrawn = false
      if styleValue.pattern ~= nil then
        local profile
        if profiling then
          profile = roundRectProfileStart()
        else
          profile = nil
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
        local profile
        if profiling then
          profile = roundRectProfileStart()
        else
          profile = nil
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
        if innerSpec ~= nil and drawRoundRectFxPass(x, y, w, h, radius, fill, styleValue.stroke, strokeWidth, innerSpec) then
          baseKind = "round.base.fx"
          innerGlowDrawn = true
        else
          if baseKind == "round.base.solidRect" and fill.kind == style.FILL_SOLID and styleValue.shadow == nil and styleValue.outerGlow == nil and styleValue.innerGlow == nil and backdrop == nil and not transformActive then
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
            if baseKind == "round.base.solidRound" and fill.kind == style.FILL_SOLID and styleValue.shadow == nil and styleValue.outerGlow == nil and styleValue.innerGlow == nil and backdrop == nil and drawSolidRoundFast(x, y, w, h, radiusValue, fill) then
              baseKind = "round.base.solidRoundFast"
            else
              if hasFill or hasStroke or backdrop ~= nil then
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
      if innerSpec ~= nil and not innerGlowDrawn then
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
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
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
        local __lux_tmp_drawStyle_208 = drawStyle
        if __lux_tmp_drawStyle_208 == nil then
          __lux_tmp_drawStyle_208 = {}
        end
        resolved = copyInto(circleStyle, __lux_tmp_drawStyle_208)
      end
      resolved.radius = radius
      return roundedBoxEx(cx - radius, cy - radius, radius * 2, radius * 2, resolved)
    end
    capsule = function(x, y, w, h, fill, stroke, strokeWidth)
      return roundedBox(x, y, w, h, mathMin(w, h) * 0.5, fill, stroke, strokeWidth)
    end
    capsuleEx = function(x, y, w, h, drawStyle)
      local resolved = drawStyle
      if resolved == nil or resolved.radius == nil then
        do
          local __lux_tmp_drawStyle_209 = drawStyle
          if __lux_tmp_drawStyle_209 == nil then
            __lux_tmp_drawStyle_209 = {}
          end
          resolved = copyInto(capsuleStyle, __lux_tmp_drawStyle_209)
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
