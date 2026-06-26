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
  local shadowLayerScratch
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
  local finishImmediateProfile
  local roundRectProfileEndBase
  local setColor
  local appendPoint
  local appendCorner
  local fallbackRoundRectPoints
  local drawFallbackStroke
  local drawRoundRectFallbackPrepared
  local drawRoundRectFallbackRaw
  local effectOffset
  local glowBiasPads
  local innerGlowRaw
  local outerGlowRaw
  local shadowRaw
  local shadowLayersRaw
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
  local drawRoundRectPatternPrepared
  local drawRoundRectPattern
  local radiusWithGrow
  local drawRoundRectInnerGlowRaw
  local drawRoundRectShadowOuterRaw
  local drawRoundRectFusedRaw
  local backdropTintColor
  local drawRoundRectBackdrop
  local drawRoundRectStrokePass
  local drawRoundRectFxPassRaw
  local drawRoundRectPrepared
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
    shadowLayerScratch = {}
    effectExtentRaw = function(width, falloff, spread, defaultWidth)
      if defaultWidth == nil then
        defaultWidth = 18
      end
      do
        local __lux_tmp_width_6 = toNumber(width)
        if __lux_tmp_width_6 == nil then
          __lux_tmp_width_6 = defaultWidth
        end
        width = mathMax(0.001, __lux_tmp_width_6)
      end
      do
        local __lux_tmp_falloff_7 = toNumber(falloff)
        if __lux_tmp_falloff_7 == nil then
          __lux_tmp_falloff_7 = 1.9
        end
        falloff = mathMax(0.35, __lux_tmp_falloff_7)
      end
      local sigma = mathMax(width / mathSqrt(falloff) * 0.72, 0.35)
      local tail = sigma * 3.72
      local __lux_tmp_spread_8 = toNumber(spread)
      if __lux_tmp_spread_8 == nil then
        __lux_tmp_spread_8 = width
      end
      return mathMax(1, __lux_tmp_spread_8, tail)
    end
    defaultInnerGlowFalloff = style.glowSoftnessToFalloff(0.55)
    defaultOuterGlowFalloff = style.glowSoftnessToFalloff(0.54)
    defaultShadowFalloff = style.glowSoftnessToFalloff(0.62)
    defaultOuterGlowExtent = effectExtentRaw(18, defaultOuterGlowFalloff, 18, 18)
    defaultOuterGlowCullSpread = defaultOuterGlowExtent
    defaultShadowExtent = effectExtentRaw(12, defaultShadowFalloff, 12, 12)
    defaultShadowCullSpread = 4 + defaultShadowExtent
    configureRoundRect = function(owner)
      if owner == nil then
        owner = {}
      end
      local materialState = owner._MaterialState
      if materialState == nil then
        materialState = {}
      end
      do
        local __lux_tmp_Materials_9 = owner._Materials
        if __lux_tmp_Materials_9 == nil then
          __lux_tmp_Materials_9 = materialState.materials
        end
        if __lux_tmp_Materials_9 == nil then
          __lux_tmp_Materials_9 = roundRectMaterials
        end
        if __lux_tmp_Materials_9 == nil then
          __lux_tmp_Materials_9 = {}
        end
        roundRectMaterials = __lux_tmp_Materials_9
      end
      do
        local __lux_tmp_BlurRT_10 = owner._BlurRT
        if __lux_tmp_BlurRT_10 == nil then
          __lux_tmp_BlurRT_10 = materialState.blurRT
        end
        if __lux_tmp_BlurRT_10 == nil then
          __lux_tmp_BlurRT_10 = roundRectBlurRT
        end
        roundRectBlurRT = __lux_tmp_BlurRT_10
      end
      do
        local __lux_tmp_MaterialOK_11 = owner.MaterialOK
        if __lux_tmp_MaterialOK_11 == nil then
          __lux_tmp_MaterialOK_11 = materialState.matOK
        end
        if __lux_tmp_MaterialOK_11 == nil then
          __lux_tmp_MaterialOK_11 = roundRectMatOK
        end
        roundRectMatOK = __lux_tmp_MaterialOK_11
      end
      do
        local __lux_tmp_hasShaders_12 = owner.hasShaders
        if __lux_tmp_hasShaders_12 == nil then
          __lux_tmp_hasShaders_12 = roundRectHasShaders
        end
        roundRectHasShaders = __lux_tmp_hasShaders_12
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
          local __lux_tmp_getConVar_13 = getConVar("mgfx_force_fallback")
          if __lux_tmp_getConVar_13 == nil then
            __lux_tmp_getConVar_13 = false
          end
          forceFallbackCvar = __lux_tmp_getConVar_13
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
        local __lux_tmp_colorA_14 = fill.colorA
        if __lux_tmp_colorA_14 == nil then
          __lux_tmp_colorA_14 = fill.color
        end
        if __lux_tmp_colorA_14 == nil then
          __lux_tmp_colorA_14 = fallback
        end
        if __lux_tmp_colorA_14 == nil then
          __lux_tmp_colorA_14 = color_white
        end
        return __lux_tmp_colorA_14
      end
      local __lux_tmp_fallback_15 = fallback
      if __lux_tmp_fallback_15 == nil then
        __lux_tmp_fallback_15 = color_white
      end
      return __lux_tmp_fallback_15
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
        local __lux_tmp_fallback_16 = fallback
        if __lux_tmp_fallback_16 == nil then
          __lux_tmp_fallback_16 = color_white
        end
        color = style.asColor(fill, __lux_tmp_fallback_16)
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
          local __lux_tmp_w_17 = toNumber(w)
          if __lux_tmp_w_17 == nil then
            __lux_tmp_w_17 = 0
          end
          local __lux_tmp_h_18 = toNumber(h)
          if __lux_tmp_h_18 == nil then
            __lux_tmp_h_18 = 0
          end
          maxRadius = mathMin(mathMax(0, __lux_tmp_w_17), mathMax(0, __lux_tmp_h_18)) * 0.5
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
    finishImmediateProfile = function(profiling, totalProfile)
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
    setColor = function(color)
      return style.setDrawColor(color)
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
        local __lux_tmp_radius_19 = toNumber(radius)
        if __lux_tmp_radius_19 == nil then
          __lux_tmp_radius_19 = 0
        end
        radius = mathMin(mathMax(0, __lux_tmp_radius_19), w * 0.5, h * 0.5)
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
        local __lux_tmp_width_20 = toNumber(width)
        if __lux_tmp_width_20 == nil then
          __lux_tmp_width_20 = 1
        end
        width = mathMax(1, __lux_tmp_width_20)
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
    drawRoundRectFallbackPrepared = function(x, y, w, h, radius, fill, hasFill, stroke, strokeWidth, hasStroke)
      if radius == nil then
        radius = 0
      end
      if strokeWidth == nil then
        strokeWidth = 0
      end
      if hasStroke == nil then
        hasStroke = false
      end
      recordFallbacks()
      if hasTransform() then
        local points = fallbackRoundRectPoints(x, y, w, h, radius)
        if hasFill then
          setColor(fillColor(fill))
          drawTransformedPoly(points)
        end
        if hasStroke then
          drawFallbackStroke(points, stroke, mathMax(1, mathFloor(strokeWidth)))
        end
        return
      end
      if hasFill then
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
      if hasStroke then
        setColor(stroke)
        surfaceDrawOutlinedRect(x, y, w, h, mathMax(1, mathFloor(strokeWidth)))
        recordDraws()
      end
    end
    drawRoundRectFallbackRaw = function(x, y, w, h, radius, fillInput, stroke, strokeWidthInput)
      if radius == nil then
        radius = 0
      end
      local fill = hotFillFromStyle(fillInput)
      local strokeWidth = 0
      local hasStroke = false
      if stroke ~= nil then
        strokeWidth = style.strokeWidth(strokeWidthInput, 0)
        hasStroke = strokeWidth > 0 and (stroke.a == nil or stroke.a > 0)
      end
      return drawRoundRectFallbackPrepared(
        x,
        y,
        w,
        h,
        radius,
        fill,
        hotFillVisible(fill),
        stroke,
        strokeWidth,
        hasStroke
      )
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
      local __lux_tmp_x_21 = toNumber(x)
      if __lux_tmp_x_21 == nil then
        __lux_tmp_x_21 = fallbackX
      end
      local __lux_tmp_y_22 = toNumber(y)
      if __lux_tmp_y_22 == nil then
        __lux_tmp_y_22 = fallbackY
      end
      return __lux_tmp_x_21, __lux_tmp_y_22
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
        local __lux_tmp_base_23 = toNumber(base)
        if __lux_tmp_base_23 == nil then
          __lux_tmp_base_23 = minPad
        end
        pad = mathMax(minPad, __lux_tmp_base_23)
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
    innerGlowRaw = function(glow)
      if glow == nil or glow == false then
        return false, 0, 0, 0, 0, 0, 0, 1
      end
      if glow == true then
        local __lux_tmp_r_24 = defaultInnerGlowColor.r
        if __lux_tmp_r_24 == nil then
          __lux_tmp_r_24 = 0
        end
        local __lux_tmp_g_25 = defaultInnerGlowColor.g
        if __lux_tmp_g_25 == nil then
          __lux_tmp_g_25 = 0
        end
        local __lux_tmp_b_26 = defaultInnerGlowColor.b
        if __lux_tmp_b_26 == nil then
          __lux_tmp_b_26 = 0
        end
        local __lux_tmp_a_27 = defaultInnerGlowColor.a
        if __lux_tmp_a_27 == nil then
          __lux_tmp_a_27 = 255
        end
        return true, __lux_tmp_r_24 * inv255, __lux_tmp_g_25 * inv255, __lux_tmp_b_26 * inv255, __lux_tmp_a_27 * inv255, 7, 1, defaultInnerGlowFalloff
      end
      if style.isColor(glow) then
        local __lux_tmp_r_28 = glow.r
        if __lux_tmp_r_28 == nil then
          __lux_tmp_r_28 = 0
        end
        local __lux_tmp_g_29 = glow.g
        if __lux_tmp_g_29 == nil then
          __lux_tmp_g_29 = 0
        end
        local __lux_tmp_b_30 = glow.b
        if __lux_tmp_b_30 == nil then
          __lux_tmp_b_30 = 0
        end
        local __lux_tmp_a_31 = glow.a
        if __lux_tmp_a_31 == nil then
          __lux_tmp_a_31 = 255
        end
        return glow.a == nil or glow.a > 0, __lux_tmp_r_28 * inv255, __lux_tmp_g_29 * inv255, __lux_tmp_b_30 * inv255, __lux_tmp_a_31 * inv255, 7, 1, defaultInnerGlowFalloff
      end
      if typeOf(glow) ~= "table" then
        return false, 0, 0, 0, 0, 0, 0, 1
      end
      local color
      do
        local __lux_tmp_color_32 = glow.color
        if __lux_tmp_color_32 == nil then
          __lux_tmp_color_32 = glow.tint
        end
        color = style.asColor(__lux_tmp_color_32, defaultInnerGlowColor)
      end
      local width
      do
        local __lux_tmp_size_33 = glow.size
        if __lux_tmp_size_33 == nil then
          __lux_tmp_size_33 = glow.width
        end
        local __lux_tmp_size_34 = toNumber(__lux_tmp_size_33)
        if __lux_tmp_size_34 == nil then
          __lux_tmp_size_34 = 7
        end
        width = mathMax(1, __lux_tmp_size_34)
      end
      local strength
      do
        local __lux_tmp_opacity_35 = glow.opacity
        if __lux_tmp_opacity_35 == nil then
          __lux_tmp_opacity_35 = glow.strength
        end
        strength = toNumber(__lux_tmp_opacity_35)
        if strength == nil then
          strength = 1
        end
      end
      local falloff = toNumber(glow.falloff)
      if falloff == nil then
        falloff = style.glowSoftnessToFalloff(glow.softness, 0.55)
      end
      local alpha
      do
        local __lux_tmp_a_36 = color.a
        if __lux_tmp_a_36 == nil then
          __lux_tmp_a_36 = 255
        end
        alpha = __lux_tmp_a_36 * inv255
      end
      local __lux_tmp_r_37 = color.r
      if __lux_tmp_r_37 == nil then
        __lux_tmp_r_37 = 0
      end
      local __lux_tmp_g_38 = color.g
      if __lux_tmp_g_38 == nil then
        __lux_tmp_g_38 = 0
      end
      local __lux_tmp_b_39 = color.b
      if __lux_tmp_b_39 == nil then
        __lux_tmp_b_39 = 0
      end
      return alpha > 0 and strength > 0, __lux_tmp_r_37 * inv255, __lux_tmp_g_38 * inv255, __lux_tmp_b_39 * inv255, alpha, width, strength, falloff
    end
    outerGlowRaw = function(glow)
      if glow == nil or glow == false then
        return false, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0
      end
      if glow == true then
        local __lux_tmp_r_40 = defaultOuterGlowColor.r
        if __lux_tmp_r_40 == nil then
          __lux_tmp_r_40 = 0
        end
        local __lux_tmp_g_41 = defaultOuterGlowColor.g
        if __lux_tmp_g_41 == nil then
          __lux_tmp_g_41 = 0
        end
        local __lux_tmp_b_42 = defaultOuterGlowColor.b
        if __lux_tmp_b_42 == nil then
          __lux_tmp_b_42 = 0
        end
        local __lux_tmp_a_43 = defaultOuterGlowColor.a
        if __lux_tmp_a_43 == nil then
          __lux_tmp_a_43 = 255
        end
        return true, __lux_tmp_r_40 * inv255, __lux_tmp_g_41 * inv255, __lux_tmp_b_42 * inv255, __lux_tmp_a_43 * inv255, 0, 0, 18, 18, 0, 1, defaultOuterGlowFalloff, defaultOuterGlowExtent, defaultOuterGlowCullSpread
      end
      if style.isColor(glow) then
        local width = 18
        local falloff = defaultOuterGlowFalloff
        local extent = effectExtentRaw(width, falloff, width, 18)
        local alpha
        do
          local __lux_tmp_a_44 = glow.a
          if __lux_tmp_a_44 == nil then
            __lux_tmp_a_44 = 255
          end
          alpha = __lux_tmp_a_44 * inv255
        end
        local __lux_tmp_r_45 = glow.r
        if __lux_tmp_r_45 == nil then
          __lux_tmp_r_45 = 0
        end
        local __lux_tmp_g_46 = glow.g
        if __lux_tmp_g_46 == nil then
          __lux_tmp_g_46 = 0
        end
        local __lux_tmp_b_47 = glow.b
        if __lux_tmp_b_47 == nil then
          __lux_tmp_b_47 = 0
        end
        return alpha > 0, __lux_tmp_r_45 * inv255, __lux_tmp_g_46 * inv255, __lux_tmp_b_47 * inv255, alpha, 0, 0, width, width, 0, 1, falloff, extent, extent
      end
      if typeOf(glow) ~= "table" then
        return false, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0
      end
      local x, y = effectOffset(glow, 0, 0)
      local width
      do
        local __lux_tmp_size_48 = glow.size
        if __lux_tmp_size_48 == nil then
          __lux_tmp_size_48 = glow.width
        end
        if __lux_tmp_size_48 == nil then
          __lux_tmp_size_48 = glow.blur
        end
        if __lux_tmp_size_48 == nil then
          __lux_tmp_size_48 = glow.radius
        end
        if __lux_tmp_size_48 == nil then
          __lux_tmp_size_48 = glow.spread
        end
        local __lux_tmp_size_49 = toNumber(__lux_tmp_size_48)
        if __lux_tmp_size_49 == nil then
          __lux_tmp_size_49 = 18
        end
        width = mathMax(1, __lux_tmp_size_49)
      end
      local spread
      do
        local __lux_tmp_spread_50 = toNumber(glow.spread)
        if __lux_tmp_spread_50 == nil then
          __lux_tmp_spread_50 = width
        end
        spread = mathMax(1, __lux_tmp_spread_50)
      end
      local grow
      do
        local __lux_tmp_grow_51 = glow.grow
        if __lux_tmp_grow_51 == nil then
          __lux_tmp_grow_51 = glow.expand
        end
        if __lux_tmp_grow_51 == nil then
          __lux_tmp_grow_51 = glow.shapeSpread
        end
        local __lux_tmp_grow_52 = toNumber(__lux_tmp_grow_51)
        if __lux_tmp_grow_52 == nil then
          __lux_tmp_grow_52 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_52)
      end
      local strength
      do
        local __lux_tmp_opacity_53 = glow.opacity
        if __lux_tmp_opacity_53 == nil then
          __lux_tmp_opacity_53 = glow.strength
        end
        strength = toNumber(__lux_tmp_opacity_53)
        if strength == nil then
          strength = 1
        end
      end
      local falloff = toNumber(glow.falloff)
      if falloff == nil then
        falloff = style.glowSoftnessToFalloff(glow.softness, 0.54)
      end
      local extent = effectExtentRaw(width, falloff, spread, 18)
      local color
      do
        local __lux_tmp_color_54 = glow.color
        if __lux_tmp_color_54 == nil then
          __lux_tmp_color_54 = glow.tint
        end
        color = style.asColor(__lux_tmp_color_54, defaultOuterGlowColor)
      end
      local alpha
      do
        local __lux_tmp_a_55 = color.a
        if __lux_tmp_a_55 == nil then
          __lux_tmp_a_55 = 255
        end
        alpha = __lux_tmp_a_55 * inv255
      end
      local __lux_tmp_r_56 = color.r
      if __lux_tmp_r_56 == nil then
        __lux_tmp_r_56 = 0
      end
      local __lux_tmp_g_57 = color.g
      if __lux_tmp_g_57 == nil then
        __lux_tmp_g_57 = 0
      end
      local __lux_tmp_b_58 = color.b
      if __lux_tmp_b_58 == nil then
        __lux_tmp_b_58 = 0
      end
      return alpha > 0 and strength > 0, __lux_tmp_r_56 * inv255, __lux_tmp_g_57 * inv255, __lux_tmp_b_58 * inv255, alpha, x, y, width, spread, grow, strength, falloff, extent, mathAbs(x) + mathAbs(y) + extent + grow
    end
    shadowRaw = function(shadow)
      if shadow == nil or shadow == false then
        return false, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0
      end
      if shadow == true then
        local __lux_tmp_r_59 = defaultShadowColor.r
        if __lux_tmp_r_59 == nil then
          __lux_tmp_r_59 = 0
        end
        local __lux_tmp_g_60 = defaultShadowColor.g
        if __lux_tmp_g_60 == nil then
          __lux_tmp_g_60 = 0
        end
        local __lux_tmp_b_61 = defaultShadowColor.b
        if __lux_tmp_b_61 == nil then
          __lux_tmp_b_61 = 0
        end
        local __lux_tmp_a_62 = defaultShadowColor.a
        if __lux_tmp_a_62 == nil then
          __lux_tmp_a_62 = 255
        end
        return true, __lux_tmp_r_59 * inv255, __lux_tmp_g_60 * inv255, __lux_tmp_b_61 * inv255, __lux_tmp_a_62 * inv255, 0, 4, 12, 12, 0, 1, defaultShadowFalloff, defaultShadowExtent, defaultShadowCullSpread
      end
      if style.isColor(shadow) then
        local width = 12
        local falloff = defaultShadowFalloff
        local extent = effectExtentRaw(width, falloff, width, 12)
        local alpha
        do
          local __lux_tmp_a_63 = shadow.a
          if __lux_tmp_a_63 == nil then
            __lux_tmp_a_63 = 255
          end
          alpha = __lux_tmp_a_63 * inv255
        end
        local __lux_tmp_r_64 = shadow.r
        if __lux_tmp_r_64 == nil then
          __lux_tmp_r_64 = 0
        end
        local __lux_tmp_g_65 = shadow.g
        if __lux_tmp_g_65 == nil then
          __lux_tmp_g_65 = 0
        end
        local __lux_tmp_b_66 = shadow.b
        if __lux_tmp_b_66 == nil then
          __lux_tmp_b_66 = 0
        end
        return alpha > 0, __lux_tmp_r_64 * inv255, __lux_tmp_g_65 * inv255, __lux_tmp_b_66 * inv255, alpha, 0, 4, width, width, 0, 1, falloff, extent, 4 + extent
      end
      if typeOf(shadow) ~= "table" then
        local width
        do
          local __lux_tmp_shadow_67 = toNumber(shadow)
          if __lux_tmp_shadow_67 == nil then
            __lux_tmp_shadow_67 = 12
          end
          width = mathMax(0.001, __lux_tmp_shadow_67)
        end
        local falloff = defaultShadowFalloff
        local extent = effectExtentRaw(width, falloff, mathMax(1, width), 12)
        local __lux_tmp_r_68 = defaultShadowColor.r
        if __lux_tmp_r_68 == nil then
          __lux_tmp_r_68 = 0
        end
        local __lux_tmp_g_69 = defaultShadowColor.g
        if __lux_tmp_g_69 == nil then
          __lux_tmp_g_69 = 0
        end
        local __lux_tmp_b_70 = defaultShadowColor.b
        if __lux_tmp_b_70 == nil then
          __lux_tmp_b_70 = 0
        end
        local __lux_tmp_a_71 = defaultShadowColor.a
        if __lux_tmp_a_71 == nil then
          __lux_tmp_a_71 = 255
        end
        return true, __lux_tmp_r_68 * inv255, __lux_tmp_g_69 * inv255, __lux_tmp_b_70 * inv255, __lux_tmp_a_71 * inv255, 0, 4, width, mathMax(1, width), 0, 1, falloff, extent, 4 + extent
      end
      local x, y = effectOffset(shadow, 0, 4)
      local width
      do
        local __lux_tmp_blur_72 = shadow.blur
        if __lux_tmp_blur_72 == nil then
          __lux_tmp_blur_72 = shadow.radius
        end
        if __lux_tmp_blur_72 == nil then
          __lux_tmp_blur_72 = shadow.size
        end
        if __lux_tmp_blur_72 == nil then
          __lux_tmp_blur_72 = shadow.width
        end
        local __lux_tmp_blur_73 = toNumber(__lux_tmp_blur_72)
        if __lux_tmp_blur_73 == nil then
          __lux_tmp_blur_73 = 12
        end
        width = mathMax(0.001, __lux_tmp_blur_73)
      end
      local grow
      do
        local __lux_tmp_spread_74 = shadow.spread
        if __lux_tmp_spread_74 == nil then
          __lux_tmp_spread_74 = shadow.grow
        end
        if __lux_tmp_spread_74 == nil then
          __lux_tmp_spread_74 = shadow.expand
        end
        if __lux_tmp_spread_74 == nil then
          __lux_tmp_spread_74 = shadow.shapeSpread
        end
        local __lux_tmp_spread_75 = toNumber(__lux_tmp_spread_74)
        if __lux_tmp_spread_75 == nil then
          __lux_tmp_spread_75 = 0
        end
        grow = mathMax(0, __lux_tmp_spread_75)
      end
      local spread
      do
        local __lux_tmp_extent_76 = shadow.extent
        if __lux_tmp_extent_76 == nil then
          __lux_tmp_extent_76 = shadow.padding
        end
        local __lux_tmp_extent_77 = toNumber(__lux_tmp_extent_76)
        if __lux_tmp_extent_77 == nil then
          __lux_tmp_extent_77 = width
        end
        spread = mathMax(1, __lux_tmp_extent_77)
      end
      local strength
      do
        local __lux_tmp_opacity_78 = shadow.opacity
        if __lux_tmp_opacity_78 == nil then
          __lux_tmp_opacity_78 = shadow.strength
        end
        strength = toNumber(__lux_tmp_opacity_78)
        if strength == nil then
          strength = 1
        end
      end
      local falloff = toNumber(shadow.falloff)
      if falloff == nil then
        falloff = style.glowSoftnessToFalloff(shadow.softness, 0.62)
      end
      local extent = effectExtentRaw(width, falloff, spread, 12)
      local color
      do
        local __lux_tmp_color_79 = shadow.color
        if __lux_tmp_color_79 == nil then
          __lux_tmp_color_79 = shadow.tint
        end
        color = style.asColor(__lux_tmp_color_79, defaultShadowColor)
      end
      local alpha
      do
        local __lux_tmp_a_80 = color.a
        if __lux_tmp_a_80 == nil then
          __lux_tmp_a_80 = 255
        end
        alpha = __lux_tmp_a_80 * inv255
      end
      local __lux_tmp_r_81 = color.r
      if __lux_tmp_r_81 == nil then
        __lux_tmp_r_81 = 0
      end
      local __lux_tmp_g_82 = color.g
      if __lux_tmp_g_82 == nil then
        __lux_tmp_g_82 = 0
      end
      local __lux_tmp_b_83 = color.b
      if __lux_tmp_b_83 == nil then
        __lux_tmp_b_83 = 0
      end
      return alpha > 0 and strength > 0, __lux_tmp_r_81 * inv255, __lux_tmp_g_82 * inv255, __lux_tmp_b_83 * inv255, alpha, x, y, width, spread, grow, strength, falloff, extent, mathAbs(x) + mathAbs(y) + extent + grow
    end
    shadowLayersRaw = function(shadow, out)
      if typeOf(shadow) ~= "table" or typeOf(shadow[1]) ~= "table" then
        return nil, 0, 0
      end
      if out == nil then
        out = {}
      end
      for index = #out, 1, -1 do
        out[index] = nil
      end
      local count = 0
      local maxCullSpread = 0
      for index = 1, #shadow do
        local hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, _, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread = shadowRaw(shadow[index])
        if hasShadow then
          local base = count * 12
          count = count + 1
          out[base + 1] = sr
          out[base + 2] = sg
          out[base + 3] = sb
          out[base + 4] = sa
          out[base + 5] = shadowX
          out[base + 6] = shadowY
          out[base + 7] = shadowWidth
          out[base + 8] = shadowExtent
          out[base + 9] = shadowGrow
          out[base + 10] = shadowStrength
          out[base + 11] = shadowFalloff
          out[base + 12] = shadowCullSpread
          if shadowCullSpread > maxCullSpread then
            maxCullSpread = shadowCullSpread
          end
        end
      end
      return out, count, maxCullSpread
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
        local __lux_match_84 = pattern.kind
        if __lux_match_84 == "stripe" or __lux_match_84 == "smoke" or __lux_match_84 == "worn" then
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
        local __lux_obj_pattern_85 = pattern
        local __lux_val_offset_86 = nil
        if __lux_obj_pattern_85 ~= nil then
          __lux_val_offset_86 = __lux_obj_pattern_85.offset
        end
        offset = toNumber(__lux_val_offset_86)
        if offset == nil then
          offset = 0
        end
      end
      local speed
      do
        local __lux_obj_pattern_87 = pattern
        local __lux_val_speed_88 = nil
        if __lux_obj_pattern_87 ~= nil then
          __lux_val_speed_88 = __lux_obj_pattern_87.speed
        end
        speed = toNumber(__lux_val_speed_88)
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
      local __lux_match_89 = fill
      local __lux_tag_90
      if __lux_match_89 ~= nil then
        __lux_tag_90 = __lux_match_89.kind
      end
      if __lux_tag_90 == style.FILL_LINEAR then
        local x1 = __lux_match_89.x1
        local y1 = __lux_match_89.y1
        local x2 = __lux_match_89.x2
        local y2 = __lux_match_89.y2
        do
          local __lux_tmp_x1_91 = x1
          if __lux_tmp_x1_91 == nil then
            __lux_tmp_x1_91 = 0
          end
          p0 = __lux_tmp_x1_91
        end
        do
          local __lux_tmp_y1_92 = y1
          if __lux_tmp_y1_92 == nil then
            __lux_tmp_y1_92 = 0
          end
          p1 = __lux_tmp_y1_92
        end
        do
          local __lux_tmp_x2_93 = x2
          if __lux_tmp_x2_93 == nil then
            __lux_tmp_x2_93 = 1
          end
          p2 = __lux_tmp_x2_93
        end
        do
          local __lux_tmp_y2_94 = y2
          if __lux_tmp_y2_94 == nil then
            __lux_tmp_y2_94 = 1
          end
          p3 = __lux_tmp_y2_94
        end
        style.bindGradientLut(material, fill)
      elseif __lux_tag_90 == style.FILL_RADIAL then
        local cx = __lux_match_89.cx
        local cy = __lux_match_89.cy
        local radius = __lux_match_89.radius
        do
          local __lux_tmp_cx_95 = cx
          if __lux_tmp_cx_95 == nil then
            __lux_tmp_cx_95 = 0.5
          end
          p0 = __lux_tmp_cx_95
        end
        do
          local __lux_tmp_cy_96 = cy
          if __lux_tmp_cy_96 == nil then
            __lux_tmp_cy_96 = 0.5
          end
          p1 = __lux_tmp_cy_96
        end
        do
          local __lux_tmp_radius_97 = radius
          if __lux_tmp_radius_97 == nil then
            __lux_tmp_radius_97 = 0.5
          end
          p2 = __lux_tmp_radius_97
        end
        p3 = 0
        style.bindGradientLut(material, fill)
      elseif __lux_tag_90 == style.FILL_CONIC then
        local cx = __lux_match_89.cx
        local cy = __lux_match_89.cy
        local rotation = __lux_match_89.rotation
        do
          local __lux_tmp_cx_98 = cx
          if __lux_tmp_cx_98 == nil then
            __lux_tmp_cx_98 = 0.5
          end
          p0 = __lux_tmp_cx_98
        end
        do
          local __lux_tmp_cy_99 = cy
          if __lux_tmp_cy_99 == nil then
            __lux_tmp_cy_99 = 0.5
          end
          p1 = __lux_tmp_cy_99
        end
        p2 = style.normalizedRotation(rotation)
        p3 = 0
        style.bindGradientLut(material, fill)
      else
        local __lux_unused_100 = nil
      end
      return p0, p1, p2, p3
    end
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
        local __lux_tmp_a0_101 = a0
        if __lux_tmp_a0_101 == nil then
          __lux_tmp_a0_101 = 0
        end
        local __lux_tmp_b0_102 = b0
        if __lux_tmp_b0_102 == nil then
          __lux_tmp_b0_102 = 0
        end
        local __lux_tmp_c0_103 = c0
        if __lux_tmp_c0_103 == nil then
          __lux_tmp_c0_103 = 0
        end
        local __lux_tmp_d0_104 = d0
        if __lux_tmp_d0_104 == nil then
          __lux_tmp_d0_104 = 0
        end
        local __lux_tmp_a1_105 = a1
        if __lux_tmp_a1_105 == nil then
          __lux_tmp_a1_105 = 0
        end
        local __lux_tmp_b1_106 = b1
        if __lux_tmp_b1_106 == nil then
          __lux_tmp_b1_106 = 0
        end
        local __lux_tmp_c1_107 = c1
        if __lux_tmp_c1_107 == nil then
          __lux_tmp_c1_107 = 0
        end
        local __lux_tmp_d1_108 = d1
        if __lux_tmp_d1_108 == nil then
          __lux_tmp_d1_108 = 0
        end
        local __lux_tmp_a2_109 = a2
        if __lux_tmp_a2_109 == nil then
          __lux_tmp_a2_109 = 0
        end
        local __lux_tmp_b2_110 = b2
        if __lux_tmp_b2_110 == nil then
          __lux_tmp_b2_110 = 0
        end
        local __lux_tmp_c2_111 = c2
        if __lux_tmp_c2_111 == nil then
          __lux_tmp_c2_111 = 0
        end
        local __lux_tmp_d2_112 = d2
        if __lux_tmp_d2_112 == nil then
          __lux_tmp_d2_112 = 0
        end
        local __lux_tmp_a3_113 = a3
        if __lux_tmp_a3_113 == nil then
          __lux_tmp_a3_113 = 0
        end
        local __lux_tmp_b3_114 = b3
        if __lux_tmp_b3_114 == nil then
          __lux_tmp_b3_114 = 0
        end
        local __lux_tmp_c3_115 = c3
        if __lux_tmp_c3_115 == nil then
          __lux_tmp_c3_115 = 0
        end
        local __lux_tmp_d3_116 = d3
        if __lux_tmp_d3_116 == nil then
          __lux_tmp_d3_116 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_a0_101,
          __lux_tmp_b0_102,
          __lux_tmp_c0_103,
          __lux_tmp_d0_104,
          __lux_tmp_a1_105,
          __lux_tmp_b1_106,
          __lux_tmp_c1_107,
          __lux_tmp_d1_108,
          __lux_tmp_a2_109,
          __lux_tmp_b2_110,
          __lux_tmp_c2_111,
          __lux_tmp_d2_112,
          __lux_tmp_a3_113,
          __lux_tmp_b3_114,
          __lux_tmp_c3_115,
          __lux_tmp_d3_116
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
        local __lux_tmp_a0_117 = a0
        if __lux_tmp_a0_117 == nil then
          __lux_tmp_a0_117 = 0
        end
        local __lux_tmp_b0_118 = b0
        if __lux_tmp_b0_118 == nil then
          __lux_tmp_b0_118 = 0
        end
        local __lux_tmp_c0_119 = c0
        if __lux_tmp_c0_119 == nil then
          __lux_tmp_c0_119 = 0
        end
        local __lux_tmp_d0_120 = d0
        if __lux_tmp_d0_120 == nil then
          __lux_tmp_d0_120 = 0
        end
        local __lux_tmp_a1_121 = a1
        if __lux_tmp_a1_121 == nil then
          __lux_tmp_a1_121 = 0
        end
        local __lux_tmp_b1_122 = b1
        if __lux_tmp_b1_122 == nil then
          __lux_tmp_b1_122 = 0
        end
        local __lux_tmp_c1_123 = c1
        if __lux_tmp_c1_123 == nil then
          __lux_tmp_c1_123 = 0
        end
        local __lux_tmp_d1_124 = d1
        if __lux_tmp_d1_124 == nil then
          __lux_tmp_d1_124 = 0
        end
        local __lux_tmp_a2_125 = a2
        if __lux_tmp_a2_125 == nil then
          __lux_tmp_a2_125 = 0
        end
        local __lux_tmp_b2_126 = b2
        if __lux_tmp_b2_126 == nil then
          __lux_tmp_b2_126 = 0
        end
        local __lux_tmp_c2_127 = c2
        if __lux_tmp_c2_127 == nil then
          __lux_tmp_c2_127 = 0
        end
        local __lux_tmp_d2_128 = d2
        if __lux_tmp_d2_128 == nil then
          __lux_tmp_d2_128 = 0
        end
        local __lux_tmp_a3_129 = a3
        if __lux_tmp_a3_129 == nil then
          __lux_tmp_a3_129 = 0
        end
        local __lux_tmp_b3_130 = b3
        if __lux_tmp_b3_130 == nil then
          __lux_tmp_b3_130 = 0
        end
        local __lux_tmp_c3_131 = c3
        if __lux_tmp_c3_131 == nil then
          __lux_tmp_c3_131 = 0
        end
        local __lux_tmp_d3_132 = d3
        if __lux_tmp_d3_132 == nil then
          __lux_tmp_d3_132 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_a0_117,
          __lux_tmp_b0_118,
          __lux_tmp_c0_119,
          __lux_tmp_d0_120,
          __lux_tmp_a1_121,
          __lux_tmp_b1_122,
          __lux_tmp_c1_123,
          __lux_tmp_d1_124,
          __lux_tmp_a2_125,
          __lux_tmp_b2_126,
          __lux_tmp_c2_127,
          __lux_tmp_d2_128,
          __lux_tmp_a3_129,
          __lux_tmp_b3_130,
          __lux_tmp_c3_131,
          __lux_tmp_d3_132
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
        local __lux_tmp_radius_133 = toNumber(radius)
        if __lux_tmp_radius_133 == nil then
          __lux_tmp_radius_133 = 0
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
          mathMax(0, __lux_tmp_radius_133),
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
        local __lux_tmp_r_134 = colorB.r
        if __lux_tmp_r_134 == nil then
          __lux_tmp_r_134 = 0
        end
        r = __lux_tmp_r_134 * inv255
      end
      local g
      do
        local __lux_tmp_g_135 = colorB.g
        if __lux_tmp_g_135 == nil then
          __lux_tmp_g_135 = 0
        end
        g = __lux_tmp_g_135 * inv255
      end
      local b
      do
        local __lux_tmp_b_136 = colorB.b
        if __lux_tmp_b_136 == nil then
          __lux_tmp_b_136 = 0
        end
        b = __lux_tmp_b_136 * inv255
      end
      local a
      do
        local __lux_tmp_a_137 = colorB.a
        if __lux_tmp_a_137 == nil then
          __lux_tmp_a_137 = 255
        end
        a = __lux_tmp_a_137 * inv255
      end
      local p0, p1, p2, p3 = roundRectFillParams(material, fill)
      local sr = 0
      local sg = 0
      local sb = 0
      local sa = 0
      if strokePx > 0 then
        do
          local __lux_tmp_r_138 = stroke.r
          if __lux_tmp_r_138 == nil then
            __lux_tmp_r_138 = 0
          end
          sr = __lux_tmp_r_138 * inv255
        end
        do
          local __lux_tmp_g_139 = stroke.g
          if __lux_tmp_g_139 == nil then
            __lux_tmp_g_139 = 0
          end
          sg = __lux_tmp_g_139 * inv255
        end
        do
          local __lux_tmp_b_140 = stroke.b
          if __lux_tmp_b_140 == nil then
            __lux_tmp_b_140 = 0
          end
          sb = __lux_tmp_b_140 * inv255
        end
        do
          local __lux_tmp_a_141 = stroke.a
          if __lux_tmp_a_141 == nil then
            __lux_tmp_a_141 = 255
          end
          sa = __lux_tmp_a_141 * inv255
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
        local __lux_tmp_color_142 = pattern.color
        if __lux_tmp_color_142 == nil then
          __lux_tmp_color_142 = pattern.tint
        end
        color = style.asColor(__lux_tmp_color_142, makeColor(255, 255, 255, 24))
      end
      local r, g, b, a = style.color01(color)
      local angle
      do
        local __lux_tmp_angle_143 = toNumber(pattern.angle)
        if __lux_tmp_angle_143 == nil then
          __lux_tmp_angle_143 = 135
        end
        angle = mathRad(__lux_tmp_angle_143)
      end
      local smoke
      local __lux_match_144 = pattern.kind
      if __lux_match_144 == "smoke" then
        smoke = true
      else
        smoke = false
      end
      local worn
      local __lux_match_145 = pattern.kind
      if __lux_match_145 == "worn" then
        worn = true
      else
        worn = false
      end
      local pz = 1
      local pw = 1
      local ox = 0
      local oy = 0
      local oz = 0
      local ow = 0
      if worn then
        do
          local __lux_tmp_scale_146 = toNumber(pattern.scale)
          if __lux_tmp_scale_146 == nil then
            __lux_tmp_scale_146 = 32
          end
          pz = mathMax(1, __lux_tmp_scale_146)
        end
        do
          local __lux_tmp_edgeWidth_147 = toNumber(pattern.edgeWidth)
          if __lux_tmp_edgeWidth_147 == nil then
            __lux_tmp_edgeWidth_147 = 7
          end
          pw = mathMax(0.5, __lux_tmp_edgeWidth_147)
        end
        ox = patternOffset(pattern)
        oy = 2
        do
          local __lux_tmp_softness_148 = toNumber(pattern.softness)
          if __lux_tmp_softness_148 == nil then
            __lux_tmp_softness_148 = 0.10
          end
          oz = mathClamp(__lux_tmp_softness_148, 0.001, 1)
        end
        do
          local __lux_tmp_warp_149 = toNumber(pattern.warp)
          if __lux_tmp_warp_149 == nil then
            __lux_tmp_warp_149 = 0.035
          end
          ow = mathMax(0, __lux_tmp_warp_149)
        end
      else
        if smoke then
          do
            local __lux_tmp_scale_150 = toNumber(pattern.scale)
            if __lux_tmp_scale_150 == nil then
              __lux_tmp_scale_150 = 140
            end
            pz = mathMax(1, __lux_tmp_scale_150)
          end
          do
            local __lux_tmp_density_151 = toNumber(pattern.density)
            if __lux_tmp_density_151 == nil then
              __lux_tmp_density_151 = 0.48
            end
            pw = mathClamp(__lux_tmp_density_151, 0, 1)
          end
          ox = patternOffset(pattern)
          oy = 1
          do
            local __lux_tmp_softness_152 = toNumber(pattern.softness)
            if __lux_tmp_softness_152 == nil then
              __lux_tmp_softness_152 = 0.3
            end
            oz = mathMax(0.001, __lux_tmp_softness_152)
          end
          do
            local __lux_tmp_warp_153 = toNumber(pattern.warp)
            if __lux_tmp_warp_153 == nil then
              __lux_tmp_warp_153 = 0.85
            end
            ow = mathMax(0, __lux_tmp_warp_153)
          end
        else
          do
            local __lux_tmp_spacing_154 = toNumber(pattern.spacing)
            if __lux_tmp_spacing_154 == nil then
              __lux_tmp_spacing_154 = 12
            end
            pz = mathMax(1, __lux_tmp_spacing_154)
          end
          do
            local __lux_tmp_width_155 = toNumber(pattern.width)
            if __lux_tmp_width_155 == nil then
              __lux_tmp_width_155 = 2
            end
            pw = mathMax(0.25, __lux_tmp_width_155)
          end
          ox = patternOffset(pattern)
        end
      end
      do
        local __lux_tmp_156
        if smoke or worn then
          __lux_tmp_156 = toNumber(pattern.seed)
          if __lux_tmp_156 == nil then
            __lux_tmp_156 = 0
          end
        else
          __lux_tmp_156 = 0
        end
        local __lux_tmp_radius_157 = toNumber(radius)
        if __lux_tmp_radius_157 == nil then
          __lux_tmp_radius_157 = 0
        end
        setupParamMatrix(
          material,
          r,
          g,
          b,
          a,
          w,
          h,
          __lux_tmp_156,
          mathMax(0, __lux_tmp_radius_157),
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
      if worn then
        local edgeColor = style.asColor(pattern.edgeColor, makeColor(218, 208, 184, 78))
        local er, eg, eb, ea = style.color01(edgeColor)
        do
          local __lux_tmp_fractal_158 = toNumber(pattern.fractal)
          if __lux_tmp_fractal_158 == nil then
            __lux_tmp_fractal_158 = 0.44
          end
          local __lux_tmp_grain_159 = toNumber(pattern.grain)
          if __lux_tmp_grain_159 == nil then
            __lux_tmp_grain_159 = 0.64
          end
          local __lux_tmp_scratches_160 = pattern.scratches
          if __lux_tmp_scratches_160 == nil then
            __lux_tmp_scratches_160 = pattern.scratch
          end
          local __lux_tmp_scratches_161 = toNumber(__lux_tmp_scratches_160)
          if __lux_tmp_scratches_161 == nil then
            __lux_tmp_scratches_161 = 0.30
          end
          local __lux_tmp_edge_162 = pattern.edge
          if __lux_tmp_edge_162 == nil then
            __lux_tmp_edge_162 = pattern.edgeWear
          end
          local __lux_tmp_edge_163 = toNumber(__lux_tmp_edge_162)
          if __lux_tmp_edge_163 == nil then
            __lux_tmp_edge_163 = 0.54
          end
          local __lux_tmp_grainScale_164 = toNumber(pattern.grainScale)
          if __lux_tmp_grainScale_164 == nil then
            __lux_tmp_grainScale_164 = 5.6
          end
          local __lux_tmp_scratchScale_165 = toNumber(pattern.scratchScale)
          if __lux_tmp_scratchScale_165 == nil then
            __lux_tmp_scratchScale_165 = 26
          end
          local __lux_tmp_scratchWidth_166 = toNumber(pattern.scratchWidth)
          if __lux_tmp_scratchWidth_166 == nil then
            __lux_tmp_scratchWidth_166 = 0.045
          end
          local __lux_tmp_edgeWidth_167 = toNumber(pattern.edgeWidth)
          if __lux_tmp_edgeWidth_167 == nil then
            __lux_tmp_edgeWidth_167 = 7
          end
          local __lux_tmp_softness_168 = toNumber(pattern.softness)
          if __lux_tmp_softness_168 == nil then
            __lux_tmp_softness_168 = 0.10
          end
          local __lux_tmp_warp_169 = toNumber(pattern.warp)
          if __lux_tmp_warp_169 == nil then
            __lux_tmp_warp_169 = 0.035
          end
          setupAuxConstants(
            material,
            er,
            eg,
            eb,
            ea,
            mathClamp(__lux_tmp_fractal_158, 0, 1),
            mathClamp(__lux_tmp_grain_159, 0, 1),
            mathClamp(__lux_tmp_scratches_161, 0, 1),
            mathClamp(__lux_tmp_edge_163, 0, 1),
            mathMax(0.25, __lux_tmp_grainScale_164),
            mathMax(1, __lux_tmp_scratchScale_165),
            mathClamp(__lux_tmp_scratchWidth_166, 0.005, 0.5),
            mathMax(0.5, __lux_tmp_edgeWidth_167),
            mathCos(angle),
            mathSin(angle),
            mathClamp(__lux_tmp_softness_168, 0.001, 1),
            mathMax(0, __lux_tmp_warp_169)
          )
        end
      end
    end
    drawRoundRectFillPass = function(x, y, w, h, radius, fill)
      local material = roundRectMaterials.roundrect
      if not materialOK(material) then
        return false
      end
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
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    drawSolidRectFast = function(x, y, w, h, fill)
      local color = fill.colorA
      if color == nil then
        color = color_white
      end
      do
        local __lux_tmp_r_170 = color.r
        if __lux_tmp_r_170 == nil then
          __lux_tmp_r_170 = 255
        end
        local __lux_tmp_g_171 = color.g
        if __lux_tmp_g_171 == nil then
          __lux_tmp_g_171 = 255
        end
        local __lux_tmp_b_172 = color.b
        if __lux_tmp_b_172 == nil then
          __lux_tmp_b_172 = 255
        end
        local __lux_tmp_a_173 = color.a
        if __lux_tmp_a_173 == nil then
          __lux_tmp_a_173 = 255
        end
        surfaceSetDrawColor(__lux_tmp_r_170, __lux_tmp_g_171, __lux_tmp_b_172, __lux_tmp_a_173)
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
      local color = fill.colorA
      if color == nil then
        color = color_white
      end
      do
        local __lux_tmp_r_174 = color.r
        if __lux_tmp_r_174 == nil then
          __lux_tmp_r_174 = 0
        end
        local __lux_tmp_g_175 = color.g
        if __lux_tmp_g_175 == nil then
          __lux_tmp_g_175 = 0
        end
        local __lux_tmp_b_176 = color.b
        if __lux_tmp_b_176 == nil then
          __lux_tmp_b_176 = 0
        end
        local __lux_tmp_a_177 = color.a
        if __lux_tmp_a_177 == nil then
          __lux_tmp_a_177 = 255
        end
        setupParamMatrixRaw(
          material,
          __lux_tmp_r_174 * inv255,
          __lux_tmp_g_175 * inv255,
          __lux_tmp_b_176 * inv255,
          __lux_tmp_a_177 * inv255,
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
      if profiling then
        roundRectProfileEnd("round.fast.solidRound.setup", setupProfile)
      end
      local drawProfile
      if profiling then
        drawProfile = roundRectProfileStart()
      else
        drawProfile = nil
      end
      drawTexturedQuad(x, y, w, h, material)
      if profiling then
        roundRectProfileEnd("round.fast.solidRound.draw", drawProfile)
      end
      return true
    end
    drawRoundRectPatternPrepared = function(x, y, w, h, radius, spec)
      if spec == nil or not shadersActive() or not materialOK(roundRectMaterials.roundrect_pattern) then
        return false
      end
      local color = spec.color
      if color == nil then
        color = spec.tint
      end
      local __lux_tmp_180 = color ~= nil
      if __lux_tmp_180 then
        local __lux_tmp_a_179 = color.a
        if __lux_tmp_a_179 == nil then
          __lux_tmp_a_179 = 255
        end
        __lux_tmp_180 = __lux_tmp_a_179 <= 0
      end
      if __lux_tmp_180 then
        return false
      end
      local material = roundRectMaterials.roundrect_pattern
      setupPatternConstants(material, w, h, roundRectRadiusScalar(radius, w, h), spec)
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    drawRoundRectPattern = function(x, y, w, h, radius, pattern)
      return drawRoundRectPatternPrepared(x, y, w, h, radius, patternStyle(pattern))
    end
    radiusWithGrow = function(radius, grow)
      do
        local __lux_tmp_grow_181 = toNumber(grow)
        if __lux_tmp_grow_181 == nil then
          __lux_tmp_grow_181 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_181)
      end
      if grow <= 0 then
        return radius
      end
      if typeOf(radius) == "table" and not style.isColor(radius) then
        local __lux_tmp_tl_182 = radius.tl
        if __lux_tmp_tl_182 == nil then
          __lux_tmp_tl_182 = radius[1]
        end
        local __lux_tmp_tl_183 = toNumber(__lux_tmp_tl_182)
        if __lux_tmp_tl_183 == nil then
          __lux_tmp_tl_183 = 0
        end
        local __lux_tmp_tr_184 = radius.tr
        if __lux_tmp_tr_184 == nil then
          __lux_tmp_tr_184 = radius[2]
        end
        if __lux_tmp_tr_184 == nil then
          __lux_tmp_tr_184 = radius.tl
        end
        if __lux_tmp_tr_184 == nil then
          __lux_tmp_tr_184 = radius[1]
        end
        local __lux_tmp_tr_185 = toNumber(__lux_tmp_tr_184)
        if __lux_tmp_tr_185 == nil then
          __lux_tmp_tr_185 = 0
        end
        local __lux_tmp_br_186 = radius.br
        if __lux_tmp_br_186 == nil then
          __lux_tmp_br_186 = radius[3]
        end
        if __lux_tmp_br_186 == nil then
          __lux_tmp_br_186 = radius.tr
        end
        if __lux_tmp_br_186 == nil then
          __lux_tmp_br_186 = radius[2]
        end
        if __lux_tmp_br_186 == nil then
          __lux_tmp_br_186 = radius.tl
        end
        if __lux_tmp_br_186 == nil then
          __lux_tmp_br_186 = radius[1]
        end
        local __lux_tmp_br_187 = toNumber(__lux_tmp_br_186)
        if __lux_tmp_br_187 == nil then
          __lux_tmp_br_187 = 0
        end
        local __lux_tmp_bl_188 = radius.bl
        if __lux_tmp_bl_188 == nil then
          __lux_tmp_bl_188 = radius[4]
        end
        if __lux_tmp_bl_188 == nil then
          __lux_tmp_bl_188 = radius.br
        end
        if __lux_tmp_bl_188 == nil then
          __lux_tmp_bl_188 = radius[3]
        end
        if __lux_tmp_bl_188 == nil then
          __lux_tmp_bl_188 = radius.tr
        end
        if __lux_tmp_bl_188 == nil then
          __lux_tmp_bl_188 = radius[2]
        end
        if __lux_tmp_bl_188 == nil then
          __lux_tmp_bl_188 = radius.tl
        end
        if __lux_tmp_bl_188 == nil then
          __lux_tmp_bl_188 = radius[1]
        end
        local __lux_tmp_bl_189 = toNumber(__lux_tmp_bl_188)
        if __lux_tmp_bl_189 == nil then
          __lux_tmp_bl_189 = 0
        end
        return {
          tl = mathMax(0, __lux_tmp_tl_183) + grow,
          tr = mathMax(0, __lux_tmp_tr_185) + grow,
          br = mathMax(0, __lux_tmp_br_187) + grow,
          bl = mathMax(0, __lux_tmp_bl_189) + grow,
        }
      end
      local __lux_tmp_radius_190 = toNumber(radius)
      if __lux_tmp_radius_190 == nil then
        __lux_tmp_radius_190 = 0
      end
      return __lux_tmp_radius_190 + grow
    end
    drawRoundRectInnerGlowRaw = function(x, y, w, h, radius, enabled, gr, gg, gb, ga, glowWidth, glowStrength, glowFalloff)
      if not enabled or ga <= 0 or glowStrength <= 0 or not shadersActive() or not materialOK(roundRectMaterials.roundrect_innerglow) then
        return false
      end
      local material = roundRectMaterials.roundrect_innerglow
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
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    drawRoundRectShadowOuterRaw = function(x, y, w, h, radius, hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowExtent, shadowGrow, shadowStrength, shadowFalloff, hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerExtent, outerGrow, outerStrength, outerFalloff)
      local profiling = roundRectProfileActive()
      hasShadow = hasShadow and sa > 0 and shadowStrength > 0
      hasOuter = hasOuter and oa > 0 and outerStrength > 0
      if not hasShadow and not hasOuter then
        return false
      end
      if not shadersActive() or not materialOK(roundRectMaterials.roundrect_shadow_outer) then
        return false
      end
      local setupProfile
      if profiling then
        setupProfile = roundRectProfileStart()
      else
        setupProfile = nil
      end
      do
        local __lux_tmp_shadowGrow_191 = shadowGrow
        if __lux_tmp_shadowGrow_191 == nil then
          __lux_tmp_shadowGrow_191 = 0
        end
        shadowGrow = mathMax(0, __lux_tmp_shadowGrow_191)
      end
      do
        local __lux_tmp_outerGrow_192 = outerGrow
        if __lux_tmp_outerGrow_192 == nil then
          __lux_tmp_outerGrow_192 = 0
        end
        outerGrow = mathMax(0, __lux_tmp_outerGrow_192)
      end
      if shadowX == nil then
        shadowX = 0
      end
      if shadowY == nil then
        shadowY = 0
      end
      if outerX == nil then
        outerX = 0
      end
      if outerY == nil then
        outerY = 0
      end
      do
        local __lux_tmp_shadowWidth_193 = shadowWidth
        if __lux_tmp_shadowWidth_193 == nil then
          __lux_tmp_shadowWidth_193 = 1
        end
        shadowWidth = mathMax(0.001, __lux_tmp_shadowWidth_193)
      end
      do
        local __lux_tmp_outerWidth_194 = outerWidth
        if __lux_tmp_outerWidth_194 == nil then
          __lux_tmp_outerWidth_194 = 1
        end
        outerWidth = mathMax(0.001, __lux_tmp_outerWidth_194)
      end
      do
        local __lux_tmp_shadowExtent_195 = shadowExtent
        if __lux_tmp_shadowExtent_195 == nil then
          __lux_tmp_shadowExtent_195 = shadowWidth
        end
        shadowExtent = mathMax(1, __lux_tmp_shadowExtent_195)
      end
      do
        local __lux_tmp_outerExtent_196 = outerExtent
        if __lux_tmp_outerExtent_196 == nil then
          __lux_tmp_outerExtent_196 = outerWidth
        end
        outerExtent = mathMax(1, __lux_tmp_outerExtent_196)
      end
      do
        local __lux_tmp_shadowStrength_197 = shadowStrength
        if __lux_tmp_shadowStrength_197 == nil then
          __lux_tmp_shadowStrength_197 = 0
        end
        shadowStrength = mathMax(0, __lux_tmp_shadowStrength_197)
      end
      do
        local __lux_tmp_outerStrength_198 = outerStrength
        if __lux_tmp_outerStrength_198 == nil then
          __lux_tmp_outerStrength_198 = 0
        end
        outerStrength = mathMax(0, __lux_tmp_outerStrength_198)
      end
      do
        local __lux_tmp_shadowFalloff_199 = shadowFalloff
        if __lux_tmp_shadowFalloff_199 == nil then
          __lux_tmp_shadowFalloff_199 = 1
        end
        shadowFalloff = mathMax(0.001, __lux_tmp_shadowFalloff_199)
      end
      do
        local __lux_tmp_outerFalloff_200 = outerFalloff
        if __lux_tmp_outerFalloff_200 == nil then
          __lux_tmp_outerFalloff_200 = 1
        end
        outerFalloff = mathMax(0.001, __lux_tmp_outerFalloff_200)
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
        local __lux_tmp_201
        if hasShadow then
          __lux_tmp_201 = sr
        else
          __lux_tmp_201 = 0
        end
        local __lux_tmp_202
        if hasShadow then
          __lux_tmp_202 = sg
        else
          __lux_tmp_202 = 0
        end
        local __lux_tmp_203
        if hasShadow then
          __lux_tmp_203 = sb
        else
          __lux_tmp_203 = 0
        end
        local __lux_tmp_204
        if hasShadow then
          __lux_tmp_204 = sa
        else
          __lux_tmp_204 = 0
        end
        local __lux_tmp_205
        if hasShadow then
          __lux_tmp_205 = shadowWidth
        else
          __lux_tmp_205 = 1
        end
        local __lux_tmp_206
        if hasShadow then
          __lux_tmp_206 = shadowStrength
        else
          __lux_tmp_206 = 0
        end
        local __lux_tmp_207
        if hasShadow then
          __lux_tmp_207 = shadowFalloff
        else
          __lux_tmp_207 = 1
        end
        setupParamMatrixRaw(
          material,
          sw,
          sh,
          0,
          0,
          __lux_tmp_201,
          __lux_tmp_202,
          __lux_tmp_203,
          __lux_tmp_204,
          shadowShapeX - sx,
          shadowShapeY - sy,
          shadowGw,
          shadowGh,
          roundRectRadiusScalar(radiusWithGrow(radius, shadowGrow), shadowGw, shadowGh),
          __lux_tmp_205,
          __lux_tmp_206,
          __lux_tmp_207
        )
      end
      do
        local __lux_tmp_208
        if hasOuter then
          __lux_tmp_208 = orr
        else
          __lux_tmp_208 = 0
        end
        local __lux_tmp_209
        if hasOuter then
          __lux_tmp_209 = og
        else
          __lux_tmp_209 = 0
        end
        local __lux_tmp_210
        if hasOuter then
          __lux_tmp_210 = ob
        else
          __lux_tmp_210 = 0
        end
        local __lux_tmp_211
        if hasOuter then
          __lux_tmp_211 = oa
        else
          __lux_tmp_211 = 0
        end
        local __lux_tmp_212
        if hasOuter then
          __lux_tmp_212 = outerWidth
        else
          __lux_tmp_212 = 1
        end
        local __lux_tmp_213
        if hasOuter then
          __lux_tmp_213 = outerStrength
        else
          __lux_tmp_213 = 0
        end
        local __lux_tmp_214
        if hasOuter then
          __lux_tmp_214 = outerFalloff
        else
          __lux_tmp_214 = 1
        end
        setupAuxConstantsRaw(
          material,
          __lux_tmp_208,
          __lux_tmp_209,
          __lux_tmp_210,
          __lux_tmp_211,
          outerShapeX - sx,
          outerShapeY - sy,
          outerGw,
          outerGh,
          roundRectRadiusScalar(radiusWithGrow(radius, outerGrow), outerGw, outerGh),
          __lux_tmp_212,
          __lux_tmp_213,
          __lux_tmp_214,
          0,
          0,
          0,
          0
        )
      end
      if profiling then
        roundRectProfileEnd("round.shadowOuter.setup", setupProfile)
      end
      local bleedProfile
      if profiling then
        bleedProfile = roundRectProfileStart()
      else
        bleedProfile = nil
      end
      local bleedToken = beginPanelEffectDraw(sx, sy, sw, sh)
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
      drawTexturedQuad(sx, sy, sw, sh, material)
      if profiling then
        roundRectProfileEnd("round.shadowOuter.draw", drawProfile)
      end
      do
        local __lux_tmp_215
        if profiling then
          __lux_tmp_215 = roundRectProfileStart()
        else
          __lux_tmp_215 = nil
        end
        bleedProfile = __lux_tmp_215
      end
      endPanelEffectBleed(bleedToken)
      if profiling then
        roundRectProfileEnd("round.shadowOuter.bleedEnd", bleedProfile)
      end
      return true
    end
    drawRoundRectFusedRaw = function(x, y, w, h, radius, fill, stroke, strokeWidth, radiusValue, hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowExtent, shadowGrow, shadowStrength, shadowFalloff, hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerExtent, outerGrow, outerStrength, outerFalloff)
      if w <= 0 or h <= 0 then
        return false
      end
      if drawTexturedQuadUV == nil then
        return false
      end
      if not shadersActive() or not materialOK(roundRectMaterials.roundrect_fused) then
        return false
      end
      hasShadow = hasShadow and sa > 0 and shadowStrength > 0
      hasOuter = hasOuter and oa > 0 and outerStrength > 0
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
      if shadowX == nil then
        shadowX = 0
      end
      if shadowY == nil then
        shadowY = 0
      end
      if outerX == nil then
        outerX = 0
      end
      if outerY == nil then
        outerY = 0
      end
      local sx = x
      local sy = y
      local ex = x + w
      local ey = y + h
      do
        local __lux_tmp_216
        if hasShadow then
          do
            local __lux_tmp_shadowGrow_217 = shadowGrow
            if __lux_tmp_shadowGrow_217 == nil then
              __lux_tmp_shadowGrow_217 = 0
            end
            __lux_tmp_216 = mathMax(0, __lux_tmp_shadowGrow_217)
          end
        else
          __lux_tmp_216 = 0
        end
        shadowGrow = __lux_tmp_216
      end
      do
        local __lux_tmp_218
        if hasShadow then
          do
            local __lux_tmp_shadowWidth_219 = shadowWidth
            if __lux_tmp_shadowWidth_219 == nil then
              __lux_tmp_shadowWidth_219 = 1
            end
            __lux_tmp_218 = mathMax(0.001, __lux_tmp_shadowWidth_219)
          end
        else
          __lux_tmp_218 = 1
        end
        shadowWidth = __lux_tmp_218
      end
      do
        local __lux_tmp_220
        if hasShadow then
          do
            local __lux_tmp_shadowFalloff_221 = shadowFalloff
            if __lux_tmp_shadowFalloff_221 == nil then
              __lux_tmp_shadowFalloff_221 = 1
            end
            __lux_tmp_220 = mathMax(0.001, __lux_tmp_shadowFalloff_221)
          end
        else
          __lux_tmp_220 = 1
        end
        shadowFalloff = __lux_tmp_220
      end
      if hasShadow then
        local spread
        do
          local __lux_tmp_shadowExtent_222 = shadowExtent
          if __lux_tmp_shadowExtent_222 == nil then
            __lux_tmp_shadowExtent_222 = shadowWidth
          end
          spread = mathMax(1, __lux_tmp_shadowExtent_222)
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
        local __lux_tmp_223
        if hasOuter then
          do
            local __lux_tmp_outerGrow_224 = outerGrow
            if __lux_tmp_outerGrow_224 == nil then
              __lux_tmp_outerGrow_224 = 0
            end
            __lux_tmp_223 = mathMax(0, __lux_tmp_outerGrow_224)
          end
        else
          __lux_tmp_223 = 0
        end
        outerGrow = __lux_tmp_223
      end
      do
        local __lux_tmp_225
        if hasOuter then
          do
            local __lux_tmp_outerWidth_226 = outerWidth
            if __lux_tmp_outerWidth_226 == nil then
              __lux_tmp_outerWidth_226 = 1
            end
            __lux_tmp_225 = mathMax(0.001, __lux_tmp_outerWidth_226)
          end
        else
          __lux_tmp_225 = 1
        end
        outerWidth = __lux_tmp_225
      end
      do
        local __lux_tmp_227
        if hasOuter then
          do
            local __lux_tmp_outerFalloff_228 = outerFalloff
            if __lux_tmp_outerFalloff_228 == nil then
              __lux_tmp_outerFalloff_228 = 1
            end
            __lux_tmp_227 = mathMax(0.001, __lux_tmp_outerFalloff_228)
          end
        else
          __lux_tmp_227 = 1
        end
        outerFalloff = __lux_tmp_227
      end
      if hasOuter then
        local spread
        do
          local __lux_tmp_outerExtent_229 = outerExtent
          if __lux_tmp_outerExtent_229 == nil then
            __lux_tmp_outerExtent_229 = outerWidth
          end
          spread = mathMax(1, __lux_tmp_outerExtent_229)
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
      if sw <= 0 or sh <= 0 then
        if profiling then
          roundRectProfileEnd("round.fused.setup", setupProfile)
        end
        return false
      end
      local material = roundRectMaterials.roundrect_fused
      do
        local __lux_tmp_radiusValue_230 = radiusValue
        if __lux_tmp_radiusValue_230 == nil then
          __lux_tmp_radiusValue_230 = roundRectRadiusScalar(radius, w, h)
        end
        setupRoundRectConstants(
          material,
          w,
          h,
          fill,
          stroke,
          strokeWidth,
          __lux_tmp_radiusValue_230
        )
      end
      do
        local __lux_tmp_231
        if hasShadow then
          __lux_tmp_231 = sr
        else
          __lux_tmp_231 = 0
        end
        local __lux_tmp_232
        if hasShadow then
          __lux_tmp_232 = sg
        else
          __lux_tmp_232 = 0
        end
        local __lux_tmp_233
        if hasShadow then
          __lux_tmp_233 = sb
        else
          __lux_tmp_233 = 0
        end
        local __lux_tmp_234
        if hasShadow then
          __lux_tmp_234 = sa * shadowStrength
        else
          __lux_tmp_234 = 0
        end
        local __lux_tmp_235
        if hasOuter then
          __lux_tmp_235 = orr
        else
          __lux_tmp_235 = 0
        end
        local __lux_tmp_236
        if hasOuter then
          __lux_tmp_236 = og
        else
          __lux_tmp_236 = 0
        end
        local __lux_tmp_237
        if hasOuter then
          __lux_tmp_237 = ob
        else
          __lux_tmp_237 = 0
        end
        local __lux_tmp_238
        if hasOuter then
          __lux_tmp_238 = oa * outerStrength
        else
          __lux_tmp_238 = 0
        end
        setupAuxConstantsRaw(
          material,
          __lux_tmp_231,
          __lux_tmp_232,
          __lux_tmp_233,
          __lux_tmp_234,
          shadowX,
          shadowY,
          shadowGrow,
          shadowWidth,
          __lux_tmp_235,
          __lux_tmp_236,
          __lux_tmp_237,
          __lux_tmp_238,
          shadowFalloff,
          outerGrow,
          outerWidth,
          outerFalloff
        )
      end
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      if profiling then
        roundRectProfileEnd("round.fused.setup", setupProfile)
      end
      local bleedProfile
      if profiling then
        bleedProfile = roundRectProfileStart()
      else
        bleedProfile = nil
      end
      local bleedToken = beginPanelEffectDraw(sx, sy, sw, sh)
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
      drawTexturedQuadUV(sx, sy, sw, sh, u0, v0, u1, v1, material)
      if profiling then
        roundRectProfileEnd("round.fused.draw", drawProfile)
      end
      do
        local __lux_tmp_239
        if profiling then
          __lux_tmp_239 = roundRectProfileStart()
        else
          __lux_tmp_239 = nil
        end
        bleedProfile = __lux_tmp_239
      end
      endPanelEffectBleed(bleedToken)
      if profiling then
        roundRectProfileEnd("round.fused.bleedEnd", bleedProfile)
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
        local __lux_tmp_a_240 = tint.a
        if __lux_tmp_a_240 == nil then
          __lux_tmp_a_240 = 255
        end
        local __lux_tmp_opacity_241 = spec.opacity
        if __lux_tmp_opacity_241 == nil then
          __lux_tmp_opacity_241 = 1
        end
        alpha = __lux_tmp_a_240 * __lux_tmp_opacity_241
      end
      if alpha <= 0 then
        return nil
      end
      do
        local __lux_tmp_r_242 = tint.r
        if __lux_tmp_r_242 == nil then
          __lux_tmp_r_242 = 0
        end
        backdropTintScratch.r = __lux_tmp_r_242
      end
      do
        local __lux_tmp_g_243 = tint.g
        if __lux_tmp_g_243 == nil then
          __lux_tmp_g_243 = 0
        end
        backdropTintScratch.g = __lux_tmp_g_243
      end
      do
        local __lux_tmp_b_244 = tint.b
        if __lux_tmp_b_244 == nil then
          __lux_tmp_b_244 = 0
        end
        backdropTintScratch.b = __lux_tmp_b_244
      end
      backdropTintScratch.a = mathFloor(mathClamp(alpha, 0, 255) + 0.5)
      return backdropTintScratch
    end
    drawRoundRectBackdrop = function(x, y, w, h, radius, spec)
      if spec == nil then
        return nil
      end
      local pad
      do
        local __lux_tmp_padding_245 = toNumber(spec.padding)
        if __lux_tmp_padding_245 == nil then
          __lux_tmp_padding_245 = 0
        end
        pad = mathMax(0, __lux_tmp_padding_245)
      end
      local bx = x - pad
      local by = y - pad
      local bw = w + pad * 2
      local bh = h + pad * 2
      local br = radiusWithGrow(radius, pad)
      local tint = backdropTintColor(spec)
      local blurred = false
      if spec.blur > 0 and roundRectBlurRT ~= nil and renderCopyRenderTargetToTexture ~= nil and materialOK(roundRectMaterials.roundrect_blur) then
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
            local __lux_tmp_r_246 = tint.r
            if __lux_tmp_r_246 == nil then
              __lux_tmp_r_246 = 0
            end
            local __lux_tmp_g_247 = tint.g
            if __lux_tmp_g_247 == nil then
              __lux_tmp_g_247 = 0
            end
            local __lux_tmp_b_248 = tint.b
            if __lux_tmp_b_248 == nil then
              __lux_tmp_b_248 = 0
            end
            local __lux_tmp_a_249 = tint.a
            if __lux_tmp_a_249 == nil then
              __lux_tmp_a_249 = 255
            end
            setupAuxConstantsRaw(
              material,
              __lux_tmp_r_246 * inv255,
              __lux_tmp_g_247 * inv255,
              __lux_tmp_b_248 * inv255,
              __lux_tmp_a_249 * inv255,
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
        blurred = true
      end
      if tint ~= nil and not blurred then
        backdropFillScratch._mgfxFillVisible = true
        drawRoundRectFillPass(bx, by, bw, bh, br, backdropFillScratch)
      end
      return spec
    end
    drawRoundRectStrokePass = function(x, y, w, h, radius, stroke, strokeWidth)
      if not style.strokeVisible(stroke, strokeWidth) then
        return false
      end
      if materialOK(roundRectMaterials.roundrect_stroke) then
        local material = roundRectMaterials.roundrect_stroke
        local r, g, b, a = style.color01(stroke)
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
        drawTexturedQuad(x, y, w, h, material)
        return true
      end
      local material = roundRectMaterials.roundrect
      if not materialOK(material) then
        return false
      end
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
      drawTexturedQuad(x, y, w, h, material)
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
          local __lux_tmp_glowWidth_250 = toNumber(glowWidth)
          if __lux_tmp_glowWidth_250 == nil then
            __lux_tmp_glowWidth_250 = 8
          end
          glowWidth = mathMax(0.001, __lux_tmp_glowWidth_250)
        end
        do
          local __lux_tmp_glowStrength_251 = toNumber(glowStrength)
          if __lux_tmp_glowStrength_251 == nil then
            __lux_tmp_glowStrength_251 = 1
          end
          glowStrength = mathMax(0, __lux_tmp_glowStrength_251)
        end
        do
          local __lux_tmp_glowFalloff_252 = toNumber(glowFalloff)
          if __lux_tmp_glowFalloff_252 == nil then
            __lux_tmp_glowFalloff_252 = 1.65
          end
          glowFalloff = mathMax(0.001, __lux_tmp_glowFalloff_252)
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
      if profiling then
        roundRectProfileEnd("round.base.fx.setup", setupProfile)
      end
      local drawProfile
      if profiling then
        drawProfile = roundRectProfileStart()
      else
        drawProfile = nil
      end
      drawTexturedQuad(x, y, w, h, material)
      if profiling then
        roundRectProfileEnd("round.base.fx.draw", drawProfile)
      end
      return true
    end
  end
  do
    drawRoundRectPrepared = function(x, y, w, h, radius, fill, hasFill, strokeValue, strokeWidth, hasStroke, hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread, hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread, hasInner, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff, backdropSpec, patternSpec, profiling, totalProfile, stageProfile, shadowLayers, shadowLayerCount, shadowLayersCullSpread)
      if shadowLayerCount == nil then
        shadowLayerCount = 0
      end
      if shadowLayersCullSpread == nil then
        shadowLayersCullSpread = 0
      end
      if profiling == nil then
        profiling = roundRectProfileActive()
        do
          local __lux_tmp_253
          if profiling then
            __lux_tmp_253 = roundRectProfileStart()
          else
            __lux_tmp_253 = nil
          end
          totalProfile = __lux_tmp_253
        end
        stageProfile = totalProfile
      end
      local shaderReady = shadersActive()
      local transformActive = hasTransform()
      if radius == nil then
        radius = 0
      end
      if fill == nil then
        fill = transparentFill
      end
      hasFill = hasFill == true
      hasStroke = hasStroke == true
      hasShadow = hasShadow == true
      hasOuter = hasOuter == true
      hasInner = hasInner == true
      if shadowLayerCount == nil then
        shadowLayerCount = 0
      end
      local hasShadowLayers = shadowLayers ~= nil and shadowLayerCount > 0
      local noEffects = not hasShadow and not hasShadowLayers and not hasOuter and not hasInner and backdropSpec == nil and patternSpec == nil
      if noEffects and not hasStroke and not transformActive then
        if hasFill and fill.kind == style.FILL_SOLID then
          local radiusValue = roundRectRadiusScalar(radius, w, h)
          if profiling then
            local now = sysTime()
            roundRectProfileRecord("round.prepare", (now - stageProfile) * 1000)
            stageProfile = now
          end
          if frame.isCulled(x, y, w, h) then
            if profiling then
              roundRectProfileRecord("round.cull", (sysTime() - stageProfile) * 1000)
            end
            finishImmediateProfile(profiling, totalProfile)
            return
          end
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
            drawSolidRectFast(x, y, w, h, fill)
            if profiling then
              roundRectProfileEnd("round.fast.solidRect", drawProfile)
            end
            finishImmediateProfile(profiling, totalProfile)
            return
          end
          local drawProfile
          if profiling then
            drawProfile = roundRectProfileStart()
          else
            drawProfile = nil
          end
          if shaderReady and drawSolidRoundFast(x, y, w, h, radiusValue, fill) then
            if profiling then
              roundRectProfileEnd("round.fast.solidRound", drawProfile)
            end
            finishImmediateProfile(profiling, totalProfile)
            return
          end
          if profiling then
            roundRectProfileEnd("round.fast.solidRound.miss", drawProfile)
          end
        end
      end
      if profiling then
        local now = sysTime()
        roundRectProfileRecord("round.prepare", (now - stageProfile) * 1000)
        stageProfile = now
      end
      local cullSpread = 0
      if shaderReady then
        if hasShadow then
          do
            local __lux_tmp_shadowCullSpread_254 = shadowCullSpread
            if __lux_tmp_shadowCullSpread_254 == nil then
              __lux_tmp_shadowCullSpread_254 = 0
            end
            cullSpread = mathMax(cullSpread, __lux_tmp_shadowCullSpread_254)
          end
        end
        if hasShadowLayers then
          do
            local __lux_tmp_shadowLayersCullSpread_255 = shadowLayersCullSpread
            if __lux_tmp_shadowLayersCullSpread_255 == nil then
              __lux_tmp_shadowLayersCullSpread_255 = 0
            end
            cullSpread = mathMax(cullSpread, __lux_tmp_shadowLayersCullSpread_255)
          end
        end
        if hasOuter then
          do
            local __lux_tmp_outerCullSpread_256 = outerCullSpread
            if __lux_tmp_outerCullSpread_256 == nil then
              __lux_tmp_outerCullSpread_256 = 0
            end
            cullSpread = mathMax(cullSpread, __lux_tmp_outerCullSpread_256)
          end
        end
        if backdropSpec ~= nil then
          do
            local __lux_tmp_padding_257 = toNumber(backdropSpec.padding)
            if __lux_tmp_padding_257 == nil then
              __lux_tmp_padding_257 = 0
            end
            cullSpread = mathMax(cullSpread, mathMax(0, __lux_tmp_padding_257))
          end
        end
      end
      if not transformActive and frame.isCulled(x - cullSpread, y - cullSpread, w + cullSpread * 2, h + cullSpread * 2) then
        if profiling then
          roundRectProfileRecord("round.cull", (sysTime() - stageProfile) * 1000)
        end
        finishImmediateProfile(profiling, totalProfile)
        return
      end
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
        drawRoundRectFallbackPrepared(
          x,
          y,
          w,
          h,
          radius,
          fill,
          hasFill,
          strokeValue,
          strokeWidth,
          hasStroke
        )
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
        if profiling then
          roundRectProfileEnd("round.fallback", profile)
        end
        finishImmediateProfile(profiling, totalProfile)
        return
      end
      if profiling then
        stageProfile = sysTime()
      end
      if profiling then
        local now = sysTime()
        roundRectProfileRecord("round.fillPrepare", (now - stageProfile) * 1000)
        stageProfile = now
      end
      local profile = nil
      local canTryFused = backdropSpec == nil and patternSpec == nil and not hasInner and not transformActive and not hasShadowLayers and (hasFill or hasStroke) and (hasShadow or hasOuter)
      if canTryFused then
        do
          local __lux_tmp_258
          if profiling then
            __lux_tmp_258 = roundRectProfileStart()
          else
            __lux_tmp_258 = nil
          end
          profile = __lux_tmp_258
        end
        local radiusValue = roundRectRadiusScalar(radius, w, h)
        local drawFill
        if hasFill then
          drawFill = fill
        else
          drawFill = transparentFill
        end
        if drawRoundRectFusedRaw(
          x,
          y,
          w,
          h,
          radius,
          drawFill,
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
          if profiling then
            roundRectProfileEnd("round.fused", profile)
          end
          finishImmediateProfile(profiling, totalProfile)
          return
        end
        if profiling then
          roundRectProfileEnd("round.fused.miss", profile)
        end
      end
      if hasShadowLayers then
        do
          local __lux_tmp_259
          if profiling then
            __lux_tmp_259 = roundRectProfileStart()
          else
            __lux_tmp_259 = nil
          end
          profile = __lux_tmp_259
        end
        for index = shadowLayerCount, 1, -1 do
          local base = (index - 1) * 12
          drawRoundRectShadowOuterRaw(
            x,
            y,
            w,
            h,
            radius,
            true,
            shadowLayers[base + 1],
            shadowLayers[base + 2],
            shadowLayers[base + 3],
            shadowLayers[base + 4],
            shadowLayers[base + 5],
            shadowLayers[base + 6],
            shadowLayers[base + 7],
            shadowLayers[base + 8],
            shadowLayers[base + 9],
            shadowLayers[base + 10],
            shadowLayers[base + 11],
            false,
            0,
            0,
            0,
            0,
            0,
            0,
            1,
            1,
            0,
            0,
            1
          )
        end
        if profiling then
          roundRectProfileEnd("round.shadowOuter", profile)
        end
      end
      if hasShadow or hasOuter then
        do
          local __lux_tmp_260
          if profiling then
            __lux_tmp_260 = roundRectProfileStart()
          else
            __lux_tmp_260 = nil
          end
          profile = __lux_tmp_260
        end
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
        if profiling then
          roundRectProfileEnd("round.shadowOuter", profile)
        end
      end
      local backdrop = nil
      if backdropSpec ~= nil then
        do
          local __lux_tmp_261
          if profiling then
            __lux_tmp_261 = roundRectProfileStart()
          else
            __lux_tmp_261 = nil
          end
          profile = __lux_tmp_261
        end
        backdrop = drawRoundRectBackdrop(x, y, w, h, radius, backdropSpec)
        if profiling then
          roundRectProfileEnd("round.backdrop", profile)
        end
      end
      local effectOnly = backdrop == nil and not hasStroke and patternSpec == nil and not hasInner and (hasShadow or hasOuter or hasShadowLayers)
      if effectOnly and not hasFill then
        finishImmediateProfile(profiling, totalProfile)
        return
      end
      if backdrop == nil and not hasFill and not hasStroke and patternSpec == nil and not hasInner then
        finishImmediateProfile(profiling, totalProfile)
        return
      end
      local drawFill
      if hasFill then
        drawFill = fill
      else
        drawFill = transparentFill
      end
      local innerGlowDrawn = false
      if patternSpec ~= nil then
        do
          local __lux_tmp_262
          if profiling then
            __lux_tmp_262 = roundRectProfileStart()
          else
            __lux_tmp_262 = nil
          end
          profile = __lux_tmp_262
        end
        if hasFill then
          drawRoundRectFillPass(x, y, w, h, radius, fill)
        end
        drawRoundRectPatternPrepared(x, y, w, h, radius, patternSpec)
        if hasStroke then
          drawRoundRectStrokePass(x, y, w, h, radius, strokeValue, strokeWidth)
        end
        if profiling then
          roundRectProfileEnd("round.layered", profile)
        end
      else
        do
          local __lux_tmp_263
          if profiling then
            __lux_tmp_263 = roundRectProfileStart()
          else
            __lux_tmp_263 = nil
          end
          profile = __lux_tmp_263
        end
        local radiusValue = roundRectRadiusScalar(radius, w, h)
        local baseKind
        if drawFill.kind == style.FILL_LINEAR then
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
        if hasInner and drawRoundRectFxPassRaw(
          x,
          y,
          w,
          h,
          radius,
          drawFill,
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
        ) then
          baseKind = "round.base.fx"
          innerGlowDrawn = true
        else
          if baseKind == "round.base.solidRect" and hasFill and fill.kind == style.FILL_SOLID and not transformActive then
            local drawProfile
            if profiling then
              drawProfile = roundRectProfileStart()
            else
              drawProfile = nil
            end
            drawSolidRectFast(x, y, w, h, fill)
            if profiling then
              roundRectProfileEnd("round.base.draw", drawProfile)
            end
            baseKind = "round.base.solidRectFast"
          else
            if baseKind == "round.base.solidRound" and hasFill and fill.kind == style.FILL_SOLID and drawSolidRoundFast(x, y, w, h, radiusValue, fill) then
              baseKind = "round.base.solidRoundFast"
            else
              if hasFill or hasStroke or backdrop ~= nil then
                local setupProfile
                if profiling then
                  setupProfile = roundRectProfileStart()
                else
                  setupProfile = nil
                end
                setupRoundRectConstants(
                  roundRectMaterials.roundrect,
                  w,
                  h,
                  drawFill,
                  strokeValue,
                  strokeWidth,
                  radiusValue
                )
                surfaceSetMaterial(roundRectMaterials.roundrect)
                surfaceSetDrawColor(255, 255, 255, 255)
                if profiling then
                  roundRectProfileEnd("round.base.setup", setupProfile)
                end
                local drawProfile
                if profiling then
                  drawProfile = roundRectProfileStart()
                else
                  drawProfile = nil
                end
                drawTexturedQuad(x, y, w, h, roundRectMaterials.roundrect)
                if profiling then
                  roundRectProfileEnd("round.base.draw", drawProfile)
                end
              end
            end
          end
        end
        if profiling then
          roundRectProfileEndBase(baseKind, profile)
        end
      end
      if hasInner and not innerGlowDrawn then
        local profile
        if profiling then
          profile = roundRectProfileStart()
        else
          profile = nil
        end
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
        if profiling then
          roundRectProfileEnd("round.innerGlow", profile)
        end
      end
      return finishImmediateProfile(profiling, totalProfile)
    end
    drawRoundRectRaw = function(x, y, w, h, radius, fillInput, strokeValue, strokeWidthInput, shadowValue, outerGlowValue, innerGlowValue, backdropInput, patternValue)
      if radius == nil then
        radius = 0
      end
      local profiling = roundRectProfileActive()
      local totalProfile
      if profiling then
        totalProfile = roundRectProfileStart()
      else
        totalProfile = nil
      end
      local fill = hotFillFromStyle(fillInput)
      local hasFill = hotFillVisible(fill)
      local strokeWidth = 0
      local hasStroke = false
      if strokeValue ~= nil then
        strokeWidth = style.strokeWidth(strokeWidthInput, 0)
        hasStroke = strokeWidth > 0 and (strokeValue.a == nil or strokeValue.a > 0)
      end
      local hasShadow = false
      local sr = 0
      local sg = 0
      local sb = 0
      local sa = 0
      local shadowX = 0
      local shadowY = 0
      local shadowWidth = 1
      local shadowSpread = 1
      local shadowGrow = 0
      local shadowStrength = 0
      local shadowFalloff = 1
      local shadowExtent = 0
      local shadowCullSpread = 0
      local shadowLayers = nil
      local shadowLayerCount = 0
      local shadowLayersCullSpread = 0
      if shadowValue ~= nil and shadowValue ~= false then
        shadowLayers, shadowLayerCount, shadowLayersCullSpread = shadowLayersRaw(shadowValue, shadowLayerScratch)
        if shadowLayers ~= nil then
          if shadowLayerCount == 1 then
            hasShadow = true
            sr = shadowLayers[1]
            sg = shadowLayers[2]
            sb = shadowLayers[3]
            sa = shadowLayers[4]
            shadowX = shadowLayers[5]
            shadowY = shadowLayers[6]
            shadowWidth = shadowLayers[7]
            shadowSpread = shadowWidth
            shadowGrow = shadowLayers[9]
            shadowStrength = shadowLayers[10]
            shadowFalloff = shadowLayers[11]
            shadowExtent = shadowLayers[8]
            shadowCullSpread = shadowLayers[12]
            shadowLayers = nil
            shadowLayerCount = 0
            shadowLayersCullSpread = 0
          else
            if shadowLayerCount <= 0 then
              shadowLayers = nil
            end
          end
        else
          hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread = shadowRaw(shadowValue)
        end
      end
      local hasOuter = false
      local orr = 0
      local og = 0
      local ob = 0
      local oa = 0
      local outerX = 0
      local outerY = 0
      local outerWidth = 1
      local outerSpread = 1
      local outerGrow = 0
      local outerStrength = 0
      local outerFalloff = 1
      local outerExtent = 0
      local outerCullSpread = 0
      if outerGlowValue ~= nil and outerGlowValue ~= false then
        hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread = outerGlowRaw(outerGlowValue)
      end
      local hasInner = false
      local igr = 0
      local igg = 0
      local igb = 0
      local iga = 0
      local innerWidth = 0
      local innerStrength = 0
      local innerFalloff = 1
      if innerGlowValue ~= nil and innerGlowValue ~= false then
        hasInner, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff = innerGlowRaw(innerGlowValue)
      end
      local backdropSpec
      if backdropInput ~= nil and backdropInput ~= false then
        backdropSpec = style.backdropStyle(backdropInput)
      else
        backdropSpec = nil
      end
      local patternSpec
      if patternValue ~= nil and patternValue ~= false then
        patternSpec = patternStyle(patternValue)
      else
        patternSpec = nil
      end
      return drawRoundRectPrepared(
        x,
        y,
        w,
        h,
        radius,
        fill,
        hasFill,
        strokeValue,
        strokeWidth,
        hasStroke,
        hasShadow,
        sr,
        sg,
        sb,
        sa,
        shadowX,
        shadowY,
        shadowWidth,
        shadowSpread,
        shadowGrow,
        shadowStrength,
        shadowFalloff,
        shadowExtent,
        shadowCullSpread,
        hasOuter,
        orr,
        og,
        ob,
        oa,
        outerX,
        outerY,
        outerWidth,
        outerSpread,
        outerGrow,
        outerStrength,
        outerFalloff,
        outerExtent,
        outerCullSpread,
        hasInner,
        igr,
        igg,
        igb,
        iga,
        innerWidth,
        innerStrength,
        innerFalloff,
        backdropSpec,
        patternSpec,
        profiling,
        totalProfile,
        totalProfile,
        shadowLayers,
        shadowLayerCount,
        shadowLayersCullSpread
      )
    end
    drawRoundRectImmediate = function(x, y, w, h, drawStyle)
      local styleValue = drawStyle
      if styleValue == nil then
        styleValue = emptyRoundRectStyle
      end
      local __lux_tmp_radius_264 = styleValue.radius
      if __lux_tmp_radius_264 == nil then
        __lux_tmp_radius_264 = styleValue.r
      end
      if __lux_tmp_radius_264 == nil then
        __lux_tmp_radius_264 = 0
      end
      local __lux_tmp_fill_265 = styleValue.fill
      if __lux_tmp_fill_265 == nil then
        __lux_tmp_fill_265 = styleValue.color
      end
      return drawRoundRectRaw(
        x,
        y,
        w,
        h,
        __lux_tmp_radius_264,
        __lux_tmp_fill_265,
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
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local transform, stripped = splitStyleTransform(resolved)
      if transform == nil then
        local result = drawRoundRectImmediate(x, y, w, h, stripped)
        return result
      end
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
      return result
    end
    roundedBox = function(x, y, w, h, radius, fill, stroke, strokeWidth)
      local result = drawRoundRectRaw(x, y, w, h, radius, fill, stroke, strokeWidth)
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
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
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
            local __lux_tmp_fill_266 = stripped.fill
            if __lux_tmp_fill_266 == nil then
              __lux_tmp_fill_266 = stripped.color
            end
            return drawRoundRectRaw(
              x,
              y,
              size,
              size,
              radius,
              __lux_tmp_fill_266,
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
      local __lux_tmp_fill_267 = stripped.fill
      if __lux_tmp_fill_267 == nil then
        __lux_tmp_fill_267 = stripped.color
      end
      return drawRoundRectRaw(
        x,
        y,
        size,
        size,
        radius,
        __lux_tmp_fill_267,
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
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local transform, stripped = splitStyleTransform(resolved)
      local radius = stripped.radius
      if radius == nil then
        radius = mathMin(w, h) * 0.5
      end
      if transform ~= nil then
        return withTransform(
          transform,
          x,
          y,
          w,
          h,
          function()
            local __lux_tmp_fill_268 = stripped.fill
            if __lux_tmp_fill_268 == nil then
              __lux_tmp_fill_268 = stripped.color
            end
            return drawRoundRectRaw(
              x,
              y,
              w,
              h,
              radius,
              __lux_tmp_fill_268,
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
      local __lux_tmp_fill_269 = stripped.fill
      if __lux_tmp_fill_269 == nil then
        __lux_tmp_fill_269 = stripped.color
      end
      return drawRoundRectRaw(
        x,
        y,
        w,
        h,
        radius,
        __lux_tmp_fill_269,
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
        local __lux_tmp_internal_270 = owner._internal
        if __lux_tmp_internal_270 == nil then
          __lux_tmp_internal_270 = {}
        end
        owner._internal = __lux_tmp_internal_270
      end
      owner._internal.drawRoundRectRaw = drawRoundRectRaw
      owner._internal.drawRoundRectPrepared = drawRoundRectPrepared
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
        shadowLayers = shadowLayersRaw,
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
        drawRoundRectPrepared = drawRoundRectPrepared,
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
  __lux_exports.shadowLayersRaw = shadowLayersRaw
  __lux_exports.patternStyle = patternStyle
  __lux_exports.patternOffset = patternOffset
  __lux_exports.drawRoundRectPrepared = drawRoundRectPrepared
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
