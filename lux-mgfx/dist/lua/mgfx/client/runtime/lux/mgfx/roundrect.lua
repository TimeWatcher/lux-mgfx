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
  local mathCeil
  local mathCos
  local mathFloor
  local mathMax
  local mathMin
  local mathRad
  local mathSin
  local mathSqrt
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
  local hasTransform
  local prepareBackdropBlur
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
  local roundRectMatOK
  local roundRectHasShaders
  local forceFallbackCvar
  local fallbackRoundRectVerts
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
  local drawRoundRectFallbackPrepared
  local drawRoundRectFallbackRaw
  local strokeCircleVerts
  local strokePathLengths
  local STROKE_CIRCLE_STEPS
  local strokePathPoint
  local drawStrokeCircle
  local drawStrokeCapsule
  local strokePathMeasure
  local drawStrokePathRange
  local drawStrokePathDot
  local fittedStrokeGap
  local drawStrokePath
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
  local drawRoundRectBaseQuad
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
  local roundedBoxBackdrop
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
    mathCeil = math.ceil
    mathCos = math.cos
    mathFloor = math.floor
    mathMax = math.max
    mathMin = math.min
    mathRad = math.rad
    mathSin = math.sin
    mathSqrt = math.sqrt
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
    hasTransform = geometry.hasTransform
    prepareBackdropBlur = geometry.prepareBackdropBlur
    recordDraws = geometry.recordDraws
    recordFallbacks = geometry.recordFallbacks
    splitStyleTransform = geometry.splitStyleTransform
    withTransform = geometry.withTransform
    beginPanelEffectDraw = frame.beginPanelEffectDraw
    endPanelEffectBleed = frame.endPanelEffectBleed
    withPanelEffectBleed = frame.withPanelEffectBleed
    do
      local __lux_tmp_1
      if matrixCtor ~= nil then
        __lux_tmp_1 = matrixCtor()
      else
        __lux_tmp_1 = nil
      end
      paramMatrixProbe = __lux_tmp_1
    end
    do
      local __lux_obj_paramMatrixProbe_2 = paramMatrixProbe
      local __lux_val_SetUnpacked_3 = nil
      if __lux_obj_paramMatrixProbe_2 ~= nil then
        __lux_val_SetUnpacked_3 = __lux_obj_paramMatrixProbe_2.SetUnpacked
      end
      paramMatrixSetUnpacked = __lux_val_SetUnpacked_3
    end
    paramMatrices = {}
    paramMatrixRawState = {}
    auxParamMatrices = {}
    auxParamMatrixRawState = {}
    roundRectMaterials = {}
    roundRectMatOK = function(material)
      return material ~= nil and material.IsError ~= nil and not material:IsError()
    end
    roundRectHasShaders = function()
      return false
    end
    forceFallbackCvar = nil
    fallbackRoundRectVerts = {}
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
        local __lux_tmp_width_4 = toNumber(width)
        if __lux_tmp_width_4 == nil then
          __lux_tmp_width_4 = defaultWidth
        end
        width = mathMax(0.001, __lux_tmp_width_4)
      end
      do
        local __lux_tmp_falloff_5 = toNumber(falloff)
        if __lux_tmp_falloff_5 == nil then
          __lux_tmp_falloff_5 = 1.9
        end
        falloff = mathMax(0.35, __lux_tmp_falloff_5)
      end
      local sigma = mathMax(width / mathSqrt(falloff) * 0.72, 0.35)
      local tail = sigma * 3.72
      local __lux_tmp_spread_6 = toNumber(spread)
      if __lux_tmp_spread_6 == nil then
        __lux_tmp_spread_6 = width
      end
      return mathMax(1, __lux_tmp_spread_6, tail)
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
        local __lux_tmp_Materials_7 = owner._Materials
        if __lux_tmp_Materials_7 == nil then
          __lux_tmp_Materials_7 = materialState.materials
        end
        if __lux_tmp_Materials_7 == nil then
          __lux_tmp_Materials_7 = roundRectMaterials
        end
        if __lux_tmp_Materials_7 == nil then
          __lux_tmp_Materials_7 = {}
        end
        roundRectMaterials = __lux_tmp_Materials_7
      end
      do
        local __lux_tmp_MaterialOK_8 = owner.MaterialOK
        if __lux_tmp_MaterialOK_8 == nil then
          __lux_tmp_MaterialOK_8 = materialState.matOK
        end
        if __lux_tmp_MaterialOK_8 == nil then
          __lux_tmp_MaterialOK_8 = roundRectMatOK
        end
        roundRectMatOK = __lux_tmp_MaterialOK_8
      end
      do
        local __lux_tmp_hasShaders_9 = owner.hasShaders
        if __lux_tmp_hasShaders_9 == nil then
          __lux_tmp_hasShaders_9 = roundRectHasShaders
        end
        roundRectHasShaders = __lux_tmp_hasShaders_9
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
          local __lux_tmp_getConVar_10 = getConVar("mgfx_force_fallback")
          if __lux_tmp_getConVar_10 == nil then
            __lux_tmp_getConVar_10 = false
          end
          forceFallbackCvar = __lux_tmp_getConVar_10
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
        local __lux_tmp_colorA_11 = fill.colorA
        if __lux_tmp_colorA_11 == nil then
          __lux_tmp_colorA_11 = fill.color
        end
        if __lux_tmp_colorA_11 == nil then
          __lux_tmp_colorA_11 = fallback
        end
        if __lux_tmp_colorA_11 == nil then
          __lux_tmp_colorA_11 = color_white
        end
        return __lux_tmp_colorA_11
      end
      local __lux_tmp_fallback_12 = fallback
      if __lux_tmp_fallback_12 == nil then
        __lux_tmp_fallback_12 = color_white
      end
      return __lux_tmp_fallback_12
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
        local __lux_tmp_fallback_13 = fallback
        if __lux_tmp_fallback_13 == nil then
          __lux_tmp_fallback_13 = color_white
        end
        color = style.asColor(fill, __lux_tmp_fallback_13)
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
          local __lux_tmp_w_14 = toNumber(w)
          if __lux_tmp_w_14 == nil then
            __lux_tmp_w_14 = 0
          end
          local __lux_tmp_h_15 = toNumber(h)
          if __lux_tmp_h_15 == nil then
            __lux_tmp_h_15 = 0
          end
          maxRadius = mathMin(mathMax(0, __lux_tmp_w_14), mathMax(0, __lux_tmp_h_15)) * 0.5
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
        local __lux_tmp_radius_16 = toNumber(radius)
        if __lux_tmp_radius_16 == nil then
          __lux_tmp_radius_16 = 0
        end
        radius = mathMin(mathMax(0, __lux_tmp_radius_16), w * 0.5, h * 0.5)
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
    drawRoundRectFallbackPrepared = function(x, y, w, h, radius, fill, hasFill, stroke, strokeWidth, hasStroke, strokeKind, strokeLength, strokeGap, strokeOffset)
      if radius == nil then
        radius = 0
      end
      if strokeWidth == nil then
        strokeWidth = 0
      end
      if hasStroke == nil then
        hasStroke = false
      end
      if strokeKind == nil then
        strokeKind = style.STROKE_SOLID
      end
      if strokeLength == nil then
        strokeLength = 0
      end
      if strokeGap == nil then
        strokeGap = 0
      end
      if strokeOffset == nil then
        strokeOffset = 0
      end
      recordFallbacks()
      if hasTransform() then
        local points = fallbackRoundRectPoints(x, y, w, h, radius)
        if hasFill then
          setColor(fillColor(fill))
          drawTransformedPoly(points)
        end
        if hasStroke then
          drawStrokePath(
            points,
            true,
            stroke,
            mathMax(1, strokeWidth),
            strokeKind,
            strokeLength,
            strokeGap,
            strokeOffset
          )
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
        drawStrokePath(
          fallbackRoundRectPoints(x, y, w, h, radius),
          true,
          stroke,
          mathMax(1, strokeWidth),
          strokeKind,
          strokeLength,
          strokeGap,
          strokeOffset
        )
      end
    end
    drawRoundRectFallbackRaw = function(x, y, w, h, radius, fillInput, stroke, strokeWidthInput)
      if radius == nil then
        radius = 0
      end
      local fill = hotFillFromStyle(fillInput)
      local hasStroke, strokeColor, strokeWidth, strokeKind, strokeLength, strokeGap, strokeOffset = style.strokeRaw(stroke, strokeWidthInput)
      return drawRoundRectFallbackPrepared(
        x,
        y,
        w,
        h,
        radius,
        fill,
        hotFillVisible(fill),
        strokeColor,
        strokeWidth,
        hasStroke,
        strokeKind,
        strokeLength,
        strokeGap,
        strokeOffset
      )
    end
  end
  do
    strokeCircleVerts = { {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {} }
    strokePathLengths = {}
    STROKE_CIRCLE_STEPS = #strokeCircleVerts
    strokePathPoint = function(point, offsetX, offsetY)
      local __lux_tmp_x_17 = point.x
      if __lux_tmp_x_17 == nil then
        __lux_tmp_x_17 = point[1]
      end
      local __lux_tmp_x_18 = toNumber(__lux_tmp_x_17)
      if __lux_tmp_x_18 == nil then
        __lux_tmp_x_18 = 0
      end
      local __lux_tmp_y_19 = point.y
      if __lux_tmp_y_19 == nil then
        __lux_tmp_y_19 = point[2]
      end
      local __lux_tmp_y_20 = toNumber(__lux_tmp_y_19)
      if __lux_tmp_y_20 == nil then
        __lux_tmp_y_20 = 0
      end
      return __lux_tmp_x_18 + offsetX, __lux_tmp_y_20 + offsetY
    end
    drawStrokeCircle = function(x, y, radius, color)
      if radius <= 0 then
        return
      end
      for index = 1, STROKE_CIRCLE_STEPS do
        local angle = (index - 1) / STROKE_CIRCLE_STEPS * math.pi * 2
        local point = strokeCircleVerts[index]
        point.x = x + mathCos(angle) * radius
        point.y = y + mathSin(angle) * radius
        point.u = nil
        point.v = nil
        point.color = nil
      end
      setColor(color)
      return drawTransformedPoly(strokeCircleVerts)
    end
    drawStrokeCapsule = function(ax, ay, bx, by, width, color)
      local dx = bx - ax
      local dy = by - ay
      local length = mathSqrt(dx * dx + dy * dy)
      local halfWidth = width * 0.5
      if length <= 0.0001 then
        drawStrokeCircle(ax, ay, halfWidth, color)
        return
      end
      local nx = -dy / length * halfWidth
      local ny = dx / length * halfWidth
      local verts = fallbackStrokeVerts
      verts[1].x = ax + nx
      verts[1].y = ay + ny
      verts[2].x = bx + nx
      verts[2].y = by + ny
      verts[3].x = bx - nx
      verts[3].y = by - ny
      verts[4].x = ax - nx
      verts[4].y = ay - ny
      setColor(color)
      drawTransformedPoly(verts)
      drawStrokeCircle(ax, ay, halfWidth, color)
      return drawStrokeCircle(bx, by, halfWidth, color)
    end
    strokePathMeasure = function(points, closed)
      local count
      do
        local __lux_tmp_points_21 = points
        if __lux_tmp_points_21 == nil then
          __lux_tmp_points_21 = {}
        end
        count = #__lux_tmp_points_21
      end
      local edgeCount
      if closed then
        edgeCount = count
      else
        edgeCount = mathMax(0, count - 1)
      end
      local total = 0
      for index = 1, edgeCount do
        local ax, ay = strokePathPoint(points[index], 0, 0)
        local bx, by = strokePathPoint(points[index % count + 1], 0, 0)
        local dx = bx - ax
        local dy = by - ay
        local length = mathSqrt(dx * dx + dy * dy)
        strokePathLengths[index] = length
        total = total + length
      end
      for index = edgeCount + 1, #strokePathLengths do
        strokePathLengths[index] = nil
      end
      return total, edgeCount
    end
    drawStrokePathRange = function(points, edgeCount, fromDistance, toDistance, color, width, offsetX, offsetY)
      if toDistance <= fromDistance then
        return
      end
      local cursor = 0
      local count = #points
      for index = 1, edgeCount do
        local edgeLength = strokePathLengths[index]
        local edgeEnd = cursor + edgeLength
        if edgeLength > 0.0001 and toDistance > cursor and fromDistance < edgeEnd then
          local localStart = mathClamp((mathMax(fromDistance, cursor) - cursor) / edgeLength, 0, 1)
          local localEnd = mathClamp((mathMin(toDistance, edgeEnd) - cursor) / edgeLength, 0, 1)
          local ax, ay = strokePathPoint(points[index], offsetX, offsetY)
          local bx, by = strokePathPoint(points[index % count + 1], offsetX, offsetY)
          drawStrokeCapsule(
            ax + (bx - ax) * localStart,
            ay + (by - ay) * localStart,
            ax + (bx - ax) * localEnd,
            ay + (by - ay) * localEnd,
            width,
            color
          )
        end
        cursor = edgeEnd
      end
    end
    drawStrokePathDot = function(points, edgeCount, distance, color, width, offsetX, offsetY)
      local cursor = 0
      local count = #points
      for index = 1, edgeCount do
        local edgeLength = strokePathLengths[index]
        local edgeEnd = cursor + edgeLength
        if distance <= edgeEnd or index == edgeCount then
          local t
          if edgeLength > 0.0001 then
            t = mathClamp((distance - cursor) / edgeLength, 0, 1)
          else
            t = 0
          end
          local ax, ay = strokePathPoint(points[index], offsetX, offsetY)
          local bx, by = strokePathPoint(points[index % count + 1], offsetX, offsetY)
          drawStrokeCircle(ax + (bx - ax) * t, ay + (by - ay) * t, width * 0.5, color)
          return
        end
        cursor = edgeEnd
      end
    end
    fittedStrokeGap = function(total, closed, visibleLength, gap, gapCount)
      if not closed or total <= 0.001 or gap <= 0.001 then
        return gap
      end
      local safeVisible = mathMax(visibleLength, 0.001)
      local safeGapCount = mathMax(gapCount, 1)
      local nominalPeriod = safeVisible + gap * safeGapCount
      local cycles = mathMax(mathFloor(total / nominalPeriod + 0.5), 1)
      local maxCycles = mathMax(mathFloor(total / safeVisible), 1)
      cycles = mathMin(cycles, maxCycles)
      return mathMax((total / cycles - safeVisible) / safeGapCount, 0)
    end
    drawStrokePath = function(points, closed, color, width, kind, dashLength, gap, offset, offsetX, offsetY)
      if kind == nil then
        kind = style.STROKE_SOLID
      end
      if dashLength == nil then
        dashLength = 0
      end
      if gap == nil then
        gap = 0
      end
      if offset == nil then
        offset = 0
      end
      if offsetX == nil then
        offsetX = 0
      end
      if offsetY == nil then
        offsetY = 0
      end
      do
        local __lux_tmp_width_22 = toNumber(width)
        if __lux_tmp_width_22 == nil then
          __lux_tmp_width_22 = 0
        end
        width = mathMax(0, __lux_tmp_width_22)
      end
      if width <= 0 or color == nil or #points < 2 then
        return false
      end
      local pathClosed = closed == true
      local total, edgeCount = strokePathMeasure(points, pathClosed)
      if total <= 0 or edgeCount <= 0 then
        return false
      end
      do
        local __lux_tmp_offsetX_23 = toNumber(offsetX)
        if __lux_tmp_offsetX_23 == nil then
          __lux_tmp_offsetX_23 = 0
        end
        offsetX = __lux_tmp_offsetX_23
      end
      do
        local __lux_tmp_offsetY_24 = toNumber(offsetY)
        if __lux_tmp_offsetY_24 == nil then
          __lux_tmp_offsetY_24 = 0
        end
        offsetY = __lux_tmp_offsetY_24
      end
      do
        local __lux_tmp_dashLength_25 = toNumber(dashLength)
        if __lux_tmp_dashLength_25 == nil then
          __lux_tmp_dashLength_25 = width * 3
        end
        dashLength = mathMax(width, __lux_tmp_dashLength_25)
      end
      do
        local __lux_tmp_gap_26 = toNumber(gap)
        if __lux_tmp_gap_26 == nil then
          __lux_tmp_gap_26 = width * 1.5
        end
        gap = mathMax(0, __lux_tmp_gap_26)
      end
      do
        local __lux_tmp_offset_27 = toNumber(offset)
        if __lux_tmp_offset_27 == nil then
          __lux_tmp_offset_27 = 0
        end
        offset = __lux_tmp_offset_27
      end
      if kind == style.STROKE_SOLID then
        drawStrokePathRange(points, edgeCount, 0, total, color, width, offsetX, offsetY)
        return true
      end
      if kind == style.STROKE_DOT then
        gap = fittedStrokeGap(total, pathClosed, width, gap, 1)
        local period = mathMax(width + gap, width)
        local center = -offset % period
        local limit
        if pathClosed then
          limit = total - 0.0001
        else
          limit = total
        end
        while center <= limit do
          drawStrokePathDot(points, edgeCount, center, color, width, offsetX, offsetY)
          center = center + period
        end
        return true
      end
      if kind == style.STROKE_DASH then
        gap = fittedStrokeGap(total, pathClosed, dashLength, gap, 1)
        local period = mathMax(dashLength + gap, dashLength)
        local center = -offset % period - period
        while center - dashLength * 0.5 <= total do
          drawStrokePathRange(
            points,
            edgeCount,
            mathMax(0, center - dashLength * 0.5),
            mathMin(total, center + dashLength * 0.5),
            color,
            width,
            offsetX,
            offsetY
          )
          center = center + period
        end
        return true
      end
      gap = fittedStrokeGap(total, pathClosed, width + dashLength, gap, 2)
      local period = mathMax(width + dashLength + gap * 2, width + dashLength)
      local base = -offset % period - period
      local dotLimit
      if pathClosed then
        dotLimit = total - 0.0001
      else
        dotLimit = total
      end
      while base - width * 0.5 <= total do
        if base >= 0 and base <= dotLimit then
          drawStrokePathDot(points, edgeCount, base, color, width, offsetX, offsetY)
        end
        local dashCenter = base + width * 0.5 + gap + dashLength * 0.5
        drawStrokePathRange(
          points,
          edgeCount,
          mathMax(0, dashCenter - dashLength * 0.5),
          mathMin(total, dashCenter + dashLength * 0.5),
          color,
          width,
          offsetX,
          offsetY
        )
        base = base + period
      end
      return true
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
      local __lux_tmp_x_28 = toNumber(x)
      if __lux_tmp_x_28 == nil then
        __lux_tmp_x_28 = fallbackX
      end
      local __lux_tmp_y_29 = toNumber(y)
      if __lux_tmp_y_29 == nil then
        __lux_tmp_y_29 = fallbackY
      end
      return __lux_tmp_x_28, __lux_tmp_y_29
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
        local __lux_tmp_base_30 = toNumber(base)
        if __lux_tmp_base_30 == nil then
          __lux_tmp_base_30 = minPad
        end
        pad = mathMax(minPad, __lux_tmp_base_30)
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
        local __lux_tmp_r_31 = defaultInnerGlowColor.r
        if __lux_tmp_r_31 == nil then
          __lux_tmp_r_31 = 0
        end
        local __lux_tmp_g_32 = defaultInnerGlowColor.g
        if __lux_tmp_g_32 == nil then
          __lux_tmp_g_32 = 0
        end
        local __lux_tmp_b_33 = defaultInnerGlowColor.b
        if __lux_tmp_b_33 == nil then
          __lux_tmp_b_33 = 0
        end
        local __lux_tmp_a_34 = defaultInnerGlowColor.a
        if __lux_tmp_a_34 == nil then
          __lux_tmp_a_34 = 255
        end
        return true, __lux_tmp_r_31 * inv255, __lux_tmp_g_32 * inv255, __lux_tmp_b_33 * inv255, __lux_tmp_a_34 * inv255, 7, 1, defaultInnerGlowFalloff
      end
      if style.isColor(glow) then
        local __lux_tmp_r_35 = glow.r
        if __lux_tmp_r_35 == nil then
          __lux_tmp_r_35 = 0
        end
        local __lux_tmp_g_36 = glow.g
        if __lux_tmp_g_36 == nil then
          __lux_tmp_g_36 = 0
        end
        local __lux_tmp_b_37 = glow.b
        if __lux_tmp_b_37 == nil then
          __lux_tmp_b_37 = 0
        end
        local __lux_tmp_a_38 = glow.a
        if __lux_tmp_a_38 == nil then
          __lux_tmp_a_38 = 255
        end
        return glow.a == nil or glow.a > 0, __lux_tmp_r_35 * inv255, __lux_tmp_g_36 * inv255, __lux_tmp_b_37 * inv255, __lux_tmp_a_38 * inv255, 7, 1, defaultInnerGlowFalloff
      end
      if typeOf(glow) ~= "table" then
        return false, 0, 0, 0, 0, 0, 0, 1
      end
      local color
      do
        local __lux_tmp_color_39 = glow.color
        if __lux_tmp_color_39 == nil then
          __lux_tmp_color_39 = glow.tint
        end
        color = style.asColor(__lux_tmp_color_39, defaultInnerGlowColor)
      end
      local width
      do
        local __lux_tmp_size_40 = glow.size
        if __lux_tmp_size_40 == nil then
          __lux_tmp_size_40 = glow.width
        end
        local __lux_tmp_size_41 = toNumber(__lux_tmp_size_40)
        if __lux_tmp_size_41 == nil then
          __lux_tmp_size_41 = 7
        end
        width = mathMax(1, __lux_tmp_size_41)
      end
      local strength
      do
        local __lux_tmp_opacity_42 = glow.opacity
        if __lux_tmp_opacity_42 == nil then
          __lux_tmp_opacity_42 = glow.strength
        end
        strength = toNumber(__lux_tmp_opacity_42)
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
        local __lux_tmp_a_43 = color.a
        if __lux_tmp_a_43 == nil then
          __lux_tmp_a_43 = 255
        end
        alpha = __lux_tmp_a_43 * inv255
      end
      local __lux_tmp_r_44 = color.r
      if __lux_tmp_r_44 == nil then
        __lux_tmp_r_44 = 0
      end
      local __lux_tmp_g_45 = color.g
      if __lux_tmp_g_45 == nil then
        __lux_tmp_g_45 = 0
      end
      local __lux_tmp_b_46 = color.b
      if __lux_tmp_b_46 == nil then
        __lux_tmp_b_46 = 0
      end
      return alpha > 0 and strength > 0, __lux_tmp_r_44 * inv255, __lux_tmp_g_45 * inv255, __lux_tmp_b_46 * inv255, alpha, width, strength, falloff
    end
    outerGlowRaw = function(glow)
      if glow == nil or glow == false then
        return false, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0
      end
      if glow == true then
        local __lux_tmp_r_47 = defaultOuterGlowColor.r
        if __lux_tmp_r_47 == nil then
          __lux_tmp_r_47 = 0
        end
        local __lux_tmp_g_48 = defaultOuterGlowColor.g
        if __lux_tmp_g_48 == nil then
          __lux_tmp_g_48 = 0
        end
        local __lux_tmp_b_49 = defaultOuterGlowColor.b
        if __lux_tmp_b_49 == nil then
          __lux_tmp_b_49 = 0
        end
        local __lux_tmp_a_50 = defaultOuterGlowColor.a
        if __lux_tmp_a_50 == nil then
          __lux_tmp_a_50 = 255
        end
        return true, __lux_tmp_r_47 * inv255, __lux_tmp_g_48 * inv255, __lux_tmp_b_49 * inv255, __lux_tmp_a_50 * inv255, 0, 0, 18, 18, 0, 1, defaultOuterGlowFalloff, defaultOuterGlowExtent, defaultOuterGlowCullSpread
      end
      if style.isColor(glow) then
        local width = 18
        local falloff = defaultOuterGlowFalloff
        local extent = effectExtentRaw(width, falloff, width, 18)
        local alpha
        do
          local __lux_tmp_a_51 = glow.a
          if __lux_tmp_a_51 == nil then
            __lux_tmp_a_51 = 255
          end
          alpha = __lux_tmp_a_51 * inv255
        end
        local __lux_tmp_r_52 = glow.r
        if __lux_tmp_r_52 == nil then
          __lux_tmp_r_52 = 0
        end
        local __lux_tmp_g_53 = glow.g
        if __lux_tmp_g_53 == nil then
          __lux_tmp_g_53 = 0
        end
        local __lux_tmp_b_54 = glow.b
        if __lux_tmp_b_54 == nil then
          __lux_tmp_b_54 = 0
        end
        return alpha > 0, __lux_tmp_r_52 * inv255, __lux_tmp_g_53 * inv255, __lux_tmp_b_54 * inv255, alpha, 0, 0, width, width, 0, 1, falloff, extent, extent
      end
      if typeOf(glow) ~= "table" then
        return false, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0
      end
      local x, y = effectOffset(glow, 0, 0)
      local width
      do
        local __lux_tmp_size_55 = glow.size
        if __lux_tmp_size_55 == nil then
          __lux_tmp_size_55 = glow.width
        end
        if __lux_tmp_size_55 == nil then
          __lux_tmp_size_55 = glow.blur
        end
        if __lux_tmp_size_55 == nil then
          __lux_tmp_size_55 = glow.radius
        end
        if __lux_tmp_size_55 == nil then
          __lux_tmp_size_55 = glow.spread
        end
        local __lux_tmp_size_56 = toNumber(__lux_tmp_size_55)
        if __lux_tmp_size_56 == nil then
          __lux_tmp_size_56 = 18
        end
        width = mathMax(1, __lux_tmp_size_56)
      end
      local spread
      do
        local __lux_tmp_spread_57 = toNumber(glow.spread)
        if __lux_tmp_spread_57 == nil then
          __lux_tmp_spread_57 = width
        end
        spread = mathMax(1, __lux_tmp_spread_57)
      end
      local grow
      do
        local __lux_tmp_grow_58 = glow.grow
        if __lux_tmp_grow_58 == nil then
          __lux_tmp_grow_58 = glow.expand
        end
        if __lux_tmp_grow_58 == nil then
          __lux_tmp_grow_58 = glow.shapeSpread
        end
        local __lux_tmp_grow_59 = toNumber(__lux_tmp_grow_58)
        if __lux_tmp_grow_59 == nil then
          __lux_tmp_grow_59 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_59)
      end
      local strength
      do
        local __lux_tmp_opacity_60 = glow.opacity
        if __lux_tmp_opacity_60 == nil then
          __lux_tmp_opacity_60 = glow.strength
        end
        strength = toNumber(__lux_tmp_opacity_60)
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
        local __lux_tmp_color_61 = glow.color
        if __lux_tmp_color_61 == nil then
          __lux_tmp_color_61 = glow.tint
        end
        color = style.asColor(__lux_tmp_color_61, defaultOuterGlowColor)
      end
      local alpha
      do
        local __lux_tmp_a_62 = color.a
        if __lux_tmp_a_62 == nil then
          __lux_tmp_a_62 = 255
        end
        alpha = __lux_tmp_a_62 * inv255
      end
      local __lux_tmp_r_63 = color.r
      if __lux_tmp_r_63 == nil then
        __lux_tmp_r_63 = 0
      end
      local __lux_tmp_g_64 = color.g
      if __lux_tmp_g_64 == nil then
        __lux_tmp_g_64 = 0
      end
      local __lux_tmp_b_65 = color.b
      if __lux_tmp_b_65 == nil then
        __lux_tmp_b_65 = 0
      end
      return alpha > 0 and strength > 0, __lux_tmp_r_63 * inv255, __lux_tmp_g_64 * inv255, __lux_tmp_b_65 * inv255, alpha, x, y, width, spread, grow, strength, falloff, extent, mathAbs(x) + mathAbs(y) + extent + grow
    end
    shadowRaw = function(shadow)
      if shadow == nil or shadow == false then
        return false, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0
      end
      if shadow == true then
        local __lux_tmp_r_66 = defaultShadowColor.r
        if __lux_tmp_r_66 == nil then
          __lux_tmp_r_66 = 0
        end
        local __lux_tmp_g_67 = defaultShadowColor.g
        if __lux_tmp_g_67 == nil then
          __lux_tmp_g_67 = 0
        end
        local __lux_tmp_b_68 = defaultShadowColor.b
        if __lux_tmp_b_68 == nil then
          __lux_tmp_b_68 = 0
        end
        local __lux_tmp_a_69 = defaultShadowColor.a
        if __lux_tmp_a_69 == nil then
          __lux_tmp_a_69 = 255
        end
        return true, __lux_tmp_r_66 * inv255, __lux_tmp_g_67 * inv255, __lux_tmp_b_68 * inv255, __lux_tmp_a_69 * inv255, 0, 4, 12, 12, 0, 1, defaultShadowFalloff, defaultShadowExtent, defaultShadowCullSpread
      end
      if style.isColor(shadow) then
        local width = 12
        local falloff = defaultShadowFalloff
        local extent = effectExtentRaw(width, falloff, width, 12)
        local alpha
        do
          local __lux_tmp_a_70 = shadow.a
          if __lux_tmp_a_70 == nil then
            __lux_tmp_a_70 = 255
          end
          alpha = __lux_tmp_a_70 * inv255
        end
        local __lux_tmp_r_71 = shadow.r
        if __lux_tmp_r_71 == nil then
          __lux_tmp_r_71 = 0
        end
        local __lux_tmp_g_72 = shadow.g
        if __lux_tmp_g_72 == nil then
          __lux_tmp_g_72 = 0
        end
        local __lux_tmp_b_73 = shadow.b
        if __lux_tmp_b_73 == nil then
          __lux_tmp_b_73 = 0
        end
        return alpha > 0, __lux_tmp_r_71 * inv255, __lux_tmp_g_72 * inv255, __lux_tmp_b_73 * inv255, alpha, 0, 4, width, width, 0, 1, falloff, extent, 4 + extent
      end
      if typeOf(shadow) ~= "table" then
        local width
        do
          local __lux_tmp_shadow_74 = toNumber(shadow)
          if __lux_tmp_shadow_74 == nil then
            __lux_tmp_shadow_74 = 12
          end
          width = mathMax(0.001, __lux_tmp_shadow_74)
        end
        local falloff = defaultShadowFalloff
        local extent = effectExtentRaw(width, falloff, mathMax(1, width), 12)
        local __lux_tmp_r_75 = defaultShadowColor.r
        if __lux_tmp_r_75 == nil then
          __lux_tmp_r_75 = 0
        end
        local __lux_tmp_g_76 = defaultShadowColor.g
        if __lux_tmp_g_76 == nil then
          __lux_tmp_g_76 = 0
        end
        local __lux_tmp_b_77 = defaultShadowColor.b
        if __lux_tmp_b_77 == nil then
          __lux_tmp_b_77 = 0
        end
        local __lux_tmp_a_78 = defaultShadowColor.a
        if __lux_tmp_a_78 == nil then
          __lux_tmp_a_78 = 255
        end
        return true, __lux_tmp_r_75 * inv255, __lux_tmp_g_76 * inv255, __lux_tmp_b_77 * inv255, __lux_tmp_a_78 * inv255, 0, 4, width, mathMax(1, width), 0, 1, falloff, extent, 4 + extent
      end
      local x, y = effectOffset(shadow, 0, 4)
      local width
      do
        local __lux_tmp_blur_79 = shadow.blur
        if __lux_tmp_blur_79 == nil then
          __lux_tmp_blur_79 = shadow.radius
        end
        if __lux_tmp_blur_79 == nil then
          __lux_tmp_blur_79 = shadow.size
        end
        if __lux_tmp_blur_79 == nil then
          __lux_tmp_blur_79 = shadow.width
        end
        local __lux_tmp_blur_80 = toNumber(__lux_tmp_blur_79)
        if __lux_tmp_blur_80 == nil then
          __lux_tmp_blur_80 = 12
        end
        width = mathMax(0.001, __lux_tmp_blur_80)
      end
      local grow
      do
        local __lux_tmp_spread_81 = shadow.spread
        if __lux_tmp_spread_81 == nil then
          __lux_tmp_spread_81 = shadow.grow
        end
        if __lux_tmp_spread_81 == nil then
          __lux_tmp_spread_81 = shadow.expand
        end
        if __lux_tmp_spread_81 == nil then
          __lux_tmp_spread_81 = shadow.shapeSpread
        end
        local __lux_tmp_spread_82 = toNumber(__lux_tmp_spread_81)
        if __lux_tmp_spread_82 == nil then
          __lux_tmp_spread_82 = 0
        end
        grow = mathMax(0, __lux_tmp_spread_82)
      end
      local spread
      do
        local __lux_tmp_extent_83 = shadow.extent
        if __lux_tmp_extent_83 == nil then
          __lux_tmp_extent_83 = shadow.padding
        end
        local __lux_tmp_extent_84 = toNumber(__lux_tmp_extent_83)
        if __lux_tmp_extent_84 == nil then
          __lux_tmp_extent_84 = width
        end
        spread = mathMax(1, __lux_tmp_extent_84)
      end
      local strength
      do
        local __lux_tmp_opacity_85 = shadow.opacity
        if __lux_tmp_opacity_85 == nil then
          __lux_tmp_opacity_85 = shadow.strength
        end
        strength = toNumber(__lux_tmp_opacity_85)
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
        local __lux_tmp_color_86 = shadow.color
        if __lux_tmp_color_86 == nil then
          __lux_tmp_color_86 = shadow.tint
        end
        color = style.asColor(__lux_tmp_color_86, defaultShadowColor)
      end
      local alpha
      do
        local __lux_tmp_a_87 = color.a
        if __lux_tmp_a_87 == nil then
          __lux_tmp_a_87 = 255
        end
        alpha = __lux_tmp_a_87 * inv255
      end
      local __lux_tmp_r_88 = color.r
      if __lux_tmp_r_88 == nil then
        __lux_tmp_r_88 = 0
      end
      local __lux_tmp_g_89 = color.g
      if __lux_tmp_g_89 == nil then
        __lux_tmp_g_89 = 0
      end
      local __lux_tmp_b_90 = color.b
      if __lux_tmp_b_90 == nil then
        __lux_tmp_b_90 = 0
      end
      return alpha > 0 and strength > 0, __lux_tmp_r_88 * inv255, __lux_tmp_g_89 * inv255, __lux_tmp_b_90 * inv255, alpha, x, y, width, spread, grow, strength, falloff, extent, mathAbs(x) + mathAbs(y) + extent + grow
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
        return style.stripePattern(style.DEFAULT_PATTERN_TRUE_COLOR, 10, 2, 135)
      end
      if typeOf(pattern) == "table" then
        if pattern._mgfxPatternSpec == true then
          return pattern
        end
        local knownPattern
        local __lux_match_91 = pattern.kind
        if __lux_match_91 == "stripe" or __lux_match_91 == "smoke" or __lux_match_91 == "worn" then
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
        local __lux_obj_pattern_92 = pattern
        local __lux_val_offset_93 = nil
        if __lux_obj_pattern_92 ~= nil then
          __lux_val_offset_93 = __lux_obj_pattern_92.offset
        end
        offset = toNumber(__lux_val_offset_93)
        if offset == nil then
          offset = 0
        end
      end
      local speed
      do
        local __lux_obj_pattern_94 = pattern
        local __lux_val_speed_95 = nil
        if __lux_obj_pattern_94 ~= nil then
          __lux_val_speed_95 = __lux_obj_pattern_94.speed
        end
        speed = toNumber(__lux_val_speed_95)
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
      local __lux_match_96 = fill
      local __lux_tag_97
      if __lux_match_96 ~= nil then
        __lux_tag_97 = __lux_match_96.kind
      end
      if __lux_tag_97 == style.FILL_LINEAR then
        local x1 = __lux_match_96.x1
        local y1 = __lux_match_96.y1
        local x2 = __lux_match_96.x2
        local y2 = __lux_match_96.y2
        do
          local __lux_tmp_x1_98 = x1
          if __lux_tmp_x1_98 == nil then
            __lux_tmp_x1_98 = 0
          end
          p0 = __lux_tmp_x1_98
        end
        do
          local __lux_tmp_y1_99 = y1
          if __lux_tmp_y1_99 == nil then
            __lux_tmp_y1_99 = 0
          end
          p1 = __lux_tmp_y1_99
        end
        do
          local __lux_tmp_x2_100 = x2
          if __lux_tmp_x2_100 == nil then
            __lux_tmp_x2_100 = 1
          end
          p2 = __lux_tmp_x2_100
        end
        do
          local __lux_tmp_y2_101 = y2
          if __lux_tmp_y2_101 == nil then
            __lux_tmp_y2_101 = 1
          end
          p3 = __lux_tmp_y2_101
        end
        style.bindGradientLut(material, fill)
      elseif __lux_tag_97 == style.FILL_RADIAL then
        local cx = __lux_match_96.cx
        local cy = __lux_match_96.cy
        local radius = __lux_match_96.radius
        local radiusX = __lux_match_96.radiusX
        local radiusY = __lux_match_96.radiusY
        do
          local __lux_tmp_cx_102 = cx
          if __lux_tmp_cx_102 == nil then
            __lux_tmp_cx_102 = 0.5
          end
          p0 = __lux_tmp_cx_102
        end
        do
          local __lux_tmp_cy_103 = cy
          if __lux_tmp_cy_103 == nil then
            __lux_tmp_cy_103 = 0.5
          end
          p1 = __lux_tmp_cy_103
        end
        do
          local __lux_tmp_radiusX_104 = radiusX
          if __lux_tmp_radiusX_104 == nil then
            __lux_tmp_radiusX_104 = radius
          end
          if __lux_tmp_radiusX_104 == nil then
            __lux_tmp_radiusX_104 = 0.5
          end
          p2 = __lux_tmp_radiusX_104
        end
        do
          local __lux_tmp_radiusY_105 = radiusY
          if __lux_tmp_radiusY_105 == nil then
            __lux_tmp_radiusY_105 = 0
          end
          p3 = __lux_tmp_radiusY_105
        end
        style.bindGradientLut(material, fill)
      elseif __lux_tag_97 == style.FILL_CONIC then
        local cx = __lux_match_96.cx
        local cy = __lux_match_96.cy
        local rotation = __lux_match_96.rotation
        do
          local __lux_tmp_cx_106 = cx
          if __lux_tmp_cx_106 == nil then
            __lux_tmp_cx_106 = 0.5
          end
          p0 = __lux_tmp_cx_106
        end
        do
          local __lux_tmp_cy_107 = cy
          if __lux_tmp_cy_107 == nil then
            __lux_tmp_cy_107 = 0.5
          end
          p1 = __lux_tmp_cy_107
        end
        p2 = style.normalizedRotation(rotation)
        p3 = 0
        style.bindGradientLut(material, fill)
      else
        local __lux_unused_108 = nil
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
        local __lux_tmp_a0_109 = a0
        if __lux_tmp_a0_109 == nil then
          __lux_tmp_a0_109 = 0
        end
        local __lux_tmp_b0_110 = b0
        if __lux_tmp_b0_110 == nil then
          __lux_tmp_b0_110 = 0
        end
        local __lux_tmp_c0_111 = c0
        if __lux_tmp_c0_111 == nil then
          __lux_tmp_c0_111 = 0
        end
        local __lux_tmp_d0_112 = d0
        if __lux_tmp_d0_112 == nil then
          __lux_tmp_d0_112 = 0
        end
        local __lux_tmp_a1_113 = a1
        if __lux_tmp_a1_113 == nil then
          __lux_tmp_a1_113 = 0
        end
        local __lux_tmp_b1_114 = b1
        if __lux_tmp_b1_114 == nil then
          __lux_tmp_b1_114 = 0
        end
        local __lux_tmp_c1_115 = c1
        if __lux_tmp_c1_115 == nil then
          __lux_tmp_c1_115 = 0
        end
        local __lux_tmp_d1_116 = d1
        if __lux_tmp_d1_116 == nil then
          __lux_tmp_d1_116 = 0
        end
        local __lux_tmp_a2_117 = a2
        if __lux_tmp_a2_117 == nil then
          __lux_tmp_a2_117 = 0
        end
        local __lux_tmp_b2_118 = b2
        if __lux_tmp_b2_118 == nil then
          __lux_tmp_b2_118 = 0
        end
        local __lux_tmp_c2_119 = c2
        if __lux_tmp_c2_119 == nil then
          __lux_tmp_c2_119 = 0
        end
        local __lux_tmp_d2_120 = d2
        if __lux_tmp_d2_120 == nil then
          __lux_tmp_d2_120 = 0
        end
        local __lux_tmp_a3_121 = a3
        if __lux_tmp_a3_121 == nil then
          __lux_tmp_a3_121 = 0
        end
        local __lux_tmp_b3_122 = b3
        if __lux_tmp_b3_122 == nil then
          __lux_tmp_b3_122 = 0
        end
        local __lux_tmp_c3_123 = c3
        if __lux_tmp_c3_123 == nil then
          __lux_tmp_c3_123 = 0
        end
        local __lux_tmp_d3_124 = d3
        if __lux_tmp_d3_124 == nil then
          __lux_tmp_d3_124 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_a0_109,
          __lux_tmp_b0_110,
          __lux_tmp_c0_111,
          __lux_tmp_d0_112,
          __lux_tmp_a1_113,
          __lux_tmp_b1_114,
          __lux_tmp_c1_115,
          __lux_tmp_d1_116,
          __lux_tmp_a2_117,
          __lux_tmp_b2_118,
          __lux_tmp_c2_119,
          __lux_tmp_d2_120,
          __lux_tmp_a3_121,
          __lux_tmp_b3_122,
          __lux_tmp_c3_123,
          __lux_tmp_d3_124
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
        local __lux_tmp_a0_125 = a0
        if __lux_tmp_a0_125 == nil then
          __lux_tmp_a0_125 = 0
        end
        local __lux_tmp_b0_126 = b0
        if __lux_tmp_b0_126 == nil then
          __lux_tmp_b0_126 = 0
        end
        local __lux_tmp_c0_127 = c0
        if __lux_tmp_c0_127 == nil then
          __lux_tmp_c0_127 = 0
        end
        local __lux_tmp_d0_128 = d0
        if __lux_tmp_d0_128 == nil then
          __lux_tmp_d0_128 = 0
        end
        local __lux_tmp_a1_129 = a1
        if __lux_tmp_a1_129 == nil then
          __lux_tmp_a1_129 = 0
        end
        local __lux_tmp_b1_130 = b1
        if __lux_tmp_b1_130 == nil then
          __lux_tmp_b1_130 = 0
        end
        local __lux_tmp_c1_131 = c1
        if __lux_tmp_c1_131 == nil then
          __lux_tmp_c1_131 = 0
        end
        local __lux_tmp_d1_132 = d1
        if __lux_tmp_d1_132 == nil then
          __lux_tmp_d1_132 = 0
        end
        local __lux_tmp_a2_133 = a2
        if __lux_tmp_a2_133 == nil then
          __lux_tmp_a2_133 = 0
        end
        local __lux_tmp_b2_134 = b2
        if __lux_tmp_b2_134 == nil then
          __lux_tmp_b2_134 = 0
        end
        local __lux_tmp_c2_135 = c2
        if __lux_tmp_c2_135 == nil then
          __lux_tmp_c2_135 = 0
        end
        local __lux_tmp_d2_136 = d2
        if __lux_tmp_d2_136 == nil then
          __lux_tmp_d2_136 = 0
        end
        local __lux_tmp_a3_137 = a3
        if __lux_tmp_a3_137 == nil then
          __lux_tmp_a3_137 = 0
        end
        local __lux_tmp_b3_138 = b3
        if __lux_tmp_b3_138 == nil then
          __lux_tmp_b3_138 = 0
        end
        local __lux_tmp_c3_139 = c3
        if __lux_tmp_c3_139 == nil then
          __lux_tmp_c3_139 = 0
        end
        local __lux_tmp_d3_140 = d3
        if __lux_tmp_d3_140 == nil then
          __lux_tmp_d3_140 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_a0_125,
          __lux_tmp_b0_126,
          __lux_tmp_c0_127,
          __lux_tmp_d0_128,
          __lux_tmp_a1_129,
          __lux_tmp_b1_130,
          __lux_tmp_c1_131,
          __lux_tmp_d1_132,
          __lux_tmp_a2_133,
          __lux_tmp_b2_134,
          __lux_tmp_c2_135,
          __lux_tmp_d2_136,
          __lux_tmp_a3_137,
          __lux_tmp_b3_138,
          __lux_tmp_c3_139,
          __lux_tmp_d3_140
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
      local packedStyle = mathClamp(style.strokeWidth(strokeWidth, 0), 0, 255) + mathClamp(fillKind, 0, 3) * 256 + style.gradientCurve(fill.curve) * 1024
      local r, g, b, a = style.color01(colorB)
      local p0, p1, p2, p3 = roundRectFillParams(material, fill)
      local sr, sg, sb, sa = style.color01(strokeColor)
      do
        local __lux_tmp_radius_141 = toNumber(radius)
        if __lux_tmp_radius_141 == nil then
          __lux_tmp_radius_141 = 0
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
          mathMax(0, __lux_tmp_radius_141),
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
        local __lux_tmp_r_142 = colorB.r
        if __lux_tmp_r_142 == nil then
          __lux_tmp_r_142 = 0
        end
        r = __lux_tmp_r_142 * inv255
      end
      local g
      do
        local __lux_tmp_g_143 = colorB.g
        if __lux_tmp_g_143 == nil then
          __lux_tmp_g_143 = 0
        end
        g = __lux_tmp_g_143 * inv255
      end
      local b
      do
        local __lux_tmp_b_144 = colorB.b
        if __lux_tmp_b_144 == nil then
          __lux_tmp_b_144 = 0
        end
        b = __lux_tmp_b_144 * inv255
      end
      local a
      do
        local __lux_tmp_a_145 = colorB.a
        if __lux_tmp_a_145 == nil then
          __lux_tmp_a_145 = 255
        end
        a = __lux_tmp_a_145 * inv255
      end
      local p0, p1, p2, p3 = roundRectFillParams(material, fill)
      local sr = 0
      local sg = 0
      local sb = 0
      local sa = 0
      if strokePx > 0 then
        do
          local __lux_tmp_r_146 = stroke.r
          if __lux_tmp_r_146 == nil then
            __lux_tmp_r_146 = 0
          end
          sr = __lux_tmp_r_146 * inv255
        end
        do
          local __lux_tmp_g_147 = stroke.g
          if __lux_tmp_g_147 == nil then
            __lux_tmp_g_147 = 0
          end
          sg = __lux_tmp_g_147 * inv255
        end
        do
          local __lux_tmp_b_148 = stroke.b
          if __lux_tmp_b_148 == nil then
            __lux_tmp_b_148 = 0
          end
          sb = __lux_tmp_b_148 * inv255
        end
        do
          local __lux_tmp_a_149 = stroke.a
          if __lux_tmp_a_149 == nil then
            __lux_tmp_a_149 = 255
          end
          sa = __lux_tmp_a_149 * inv255
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
        strokePx + fillKind * 256 + style.gradientCurve(fill.curve) * 1024,
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
    drawRoundRectBaseQuad = function(x, y, w, h, material, strokeWidth)
      if strokeWidth == nil then
        strokeWidth = 0
      end
      local pad
      do
        local __lux_tmp_strokeWidth_150 = toNumber(strokeWidth)
        if __lux_tmp_strokeWidth_150 == nil then
          __lux_tmp_strokeWidth_150 = 0
        end
        pad = mathCeil(mathMax(0, __lux_tmp_strokeWidth_150) * 0.5 + 1)
      end
      if pad <= 1 or w <= 0 or h <= 0 then
        drawTexturedQuad(x, y, w, h, material)
        return
      end
      return drawTexturedQuadUV(
        x - pad,
        y - pad,
        w + pad * 2,
        h + pad * 2,
        -pad / w,
        -pad / h,
        1 + pad / w,
        1 + pad / h,
        material
      )
    end
    setupPatternConstants = function(material, w, h, radius, pattern)
      local color
      do
        local __lux_tmp_color_151 = pattern.color
        if __lux_tmp_color_151 == nil then
          __lux_tmp_color_151 = pattern.tint
        end
        color = style.asColor(__lux_tmp_color_151, style.DEFAULT_PATTERN_COLOR)
      end
      local r, g, b, a = style.color01(color)
      local angle
      do
        local __lux_tmp_angle_152 = toNumber(pattern.angle)
        if __lux_tmp_angle_152 == nil then
          __lux_tmp_angle_152 = 135
        end
        angle = mathRad(__lux_tmp_angle_152)
      end
      local smoke
      local __lux_match_153 = pattern.kind
      if __lux_match_153 == "smoke" then
        smoke = true
      else
        smoke = false
      end
      local worn
      local __lux_match_154 = pattern.kind
      if __lux_match_154 == "worn" then
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
          local __lux_tmp_scale_155 = toNumber(pattern.scale)
          if __lux_tmp_scale_155 == nil then
            __lux_tmp_scale_155 = 32
          end
          pz = mathMax(1, __lux_tmp_scale_155)
        end
        do
          local __lux_tmp_edgeWidth_156 = toNumber(pattern.edgeWidth)
          if __lux_tmp_edgeWidth_156 == nil then
            __lux_tmp_edgeWidth_156 = 7
          end
          pw = mathMax(0.5, __lux_tmp_edgeWidth_156)
        end
        ox = patternOffset(pattern)
        oy = 2
        do
          local __lux_tmp_softness_157 = toNumber(pattern.softness)
          if __lux_tmp_softness_157 == nil then
            __lux_tmp_softness_157 = 0.10
          end
          oz = mathClamp(__lux_tmp_softness_157, 0.001, 1)
        end
        do
          local __lux_tmp_warp_158 = toNumber(pattern.warp)
          if __lux_tmp_warp_158 == nil then
            __lux_tmp_warp_158 = 0.035
          end
          ow = mathMax(0, __lux_tmp_warp_158)
        end
      else
        if smoke then
          do
            local __lux_tmp_scale_159 = toNumber(pattern.scale)
            if __lux_tmp_scale_159 == nil then
              __lux_tmp_scale_159 = 140
            end
            pz = mathMax(1, __lux_tmp_scale_159)
          end
          do
            local __lux_tmp_density_160 = toNumber(pattern.density)
            if __lux_tmp_density_160 == nil then
              __lux_tmp_density_160 = 0.48
            end
            pw = mathClamp(__lux_tmp_density_160, 0, 1)
          end
          ox = patternOffset(pattern)
          oy = 1
          do
            local __lux_tmp_softness_161 = toNumber(pattern.softness)
            if __lux_tmp_softness_161 == nil then
              __lux_tmp_softness_161 = 0.3
            end
            oz = mathMax(0.001, __lux_tmp_softness_161)
          end
          do
            local __lux_tmp_warp_162 = toNumber(pattern.warp)
            if __lux_tmp_warp_162 == nil then
              __lux_tmp_warp_162 = 0.85
            end
            ow = mathMax(0, __lux_tmp_warp_162)
          end
        else
          do
            local __lux_tmp_spacing_163 = toNumber(pattern.spacing)
            if __lux_tmp_spacing_163 == nil then
              __lux_tmp_spacing_163 = 12
            end
            pz = mathMax(1, __lux_tmp_spacing_163)
          end
          do
            local __lux_tmp_width_164 = toNumber(pattern.width)
            if __lux_tmp_width_164 == nil then
              __lux_tmp_width_164 = 2
            end
            pw = mathMax(0.25, __lux_tmp_width_164)
          end
          ox = patternOffset(pattern)
        end
      end
      do
        local __lux_tmp_165
        if smoke or worn then
          __lux_tmp_165 = toNumber(pattern.seed)
          if __lux_tmp_165 == nil then
            __lux_tmp_165 = 0
          end
        else
          __lux_tmp_165 = 0
        end
        local __lux_tmp_radius_166 = toNumber(radius)
        if __lux_tmp_radius_166 == nil then
          __lux_tmp_radius_166 = 0
        end
        setupParamMatrix(
          material,
          r,
          g,
          b,
          a,
          w,
          h,
          __lux_tmp_165,
          mathMax(0, __lux_tmp_radius_166),
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
        local edgeColor = style.asColor(pattern.edgeColor, style.DEFAULT_WORN_EDGE_COLOR)
        local er, eg, eb, ea = style.color01(edgeColor)
        do
          local __lux_tmp_fractal_167 = toNumber(pattern.fractal)
          if __lux_tmp_fractal_167 == nil then
            __lux_tmp_fractal_167 = 0.44
          end
          local __lux_tmp_grain_168 = toNumber(pattern.grain)
          if __lux_tmp_grain_168 == nil then
            __lux_tmp_grain_168 = 0.64
          end
          local __lux_tmp_scratches_169 = pattern.scratches
          if __lux_tmp_scratches_169 == nil then
            __lux_tmp_scratches_169 = pattern.scratch
          end
          local __lux_tmp_scratches_170 = toNumber(__lux_tmp_scratches_169)
          if __lux_tmp_scratches_170 == nil then
            __lux_tmp_scratches_170 = 0.30
          end
          local __lux_tmp_edge_171 = pattern.edge
          if __lux_tmp_edge_171 == nil then
            __lux_tmp_edge_171 = pattern.edgeWear
          end
          local __lux_tmp_edge_172 = toNumber(__lux_tmp_edge_171)
          if __lux_tmp_edge_172 == nil then
            __lux_tmp_edge_172 = 0.54
          end
          local __lux_tmp_grainScale_173 = toNumber(pattern.grainScale)
          if __lux_tmp_grainScale_173 == nil then
            __lux_tmp_grainScale_173 = 5.6
          end
          local __lux_tmp_scratchScale_174 = toNumber(pattern.scratchScale)
          if __lux_tmp_scratchScale_174 == nil then
            __lux_tmp_scratchScale_174 = 26
          end
          local __lux_tmp_scratchWidth_175 = toNumber(pattern.scratchWidth)
          if __lux_tmp_scratchWidth_175 == nil then
            __lux_tmp_scratchWidth_175 = 0.045
          end
          local __lux_tmp_edgeWidth_176 = toNumber(pattern.edgeWidth)
          if __lux_tmp_edgeWidth_176 == nil then
            __lux_tmp_edgeWidth_176 = 7
          end
          local __lux_tmp_softness_177 = toNumber(pattern.softness)
          if __lux_tmp_softness_177 == nil then
            __lux_tmp_softness_177 = 0.10
          end
          local __lux_tmp_warp_178 = toNumber(pattern.warp)
          if __lux_tmp_warp_178 == nil then
            __lux_tmp_warp_178 = 0.035
          end
          setupAuxConstants(
            material,
            er,
            eg,
            eb,
            ea,
            mathClamp(__lux_tmp_fractal_167, 0, 1),
            mathClamp(__lux_tmp_grain_168, 0, 1),
            mathClamp(__lux_tmp_scratches_170, 0, 1),
            mathClamp(__lux_tmp_edge_172, 0, 1),
            mathMax(0.25, __lux_tmp_grainScale_173),
            mathMax(1, __lux_tmp_scratchScale_174),
            mathClamp(__lux_tmp_scratchWidth_175, 0.005, 0.5),
            mathMax(0.5, __lux_tmp_edgeWidth_176),
            mathCos(angle),
            mathSin(angle),
            mathClamp(__lux_tmp_softness_177, 0.001, 1),
            mathMax(0, __lux_tmp_warp_178)
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
        local __lux_tmp_r_179 = color.r
        if __lux_tmp_r_179 == nil then
          __lux_tmp_r_179 = 255
        end
        local __lux_tmp_g_180 = color.g
        if __lux_tmp_g_180 == nil then
          __lux_tmp_g_180 = 255
        end
        local __lux_tmp_b_181 = color.b
        if __lux_tmp_b_181 == nil then
          __lux_tmp_b_181 = 255
        end
        local __lux_tmp_a_182 = color.a
        if __lux_tmp_a_182 == nil then
          __lux_tmp_a_182 = 255
        end
        surfaceSetDrawColor(__lux_tmp_r_179, __lux_tmp_g_180, __lux_tmp_b_181, __lux_tmp_a_182)
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
        local __lux_tmp_r_183 = color.r
        if __lux_tmp_r_183 == nil then
          __lux_tmp_r_183 = 0
        end
        local __lux_tmp_g_184 = color.g
        if __lux_tmp_g_184 == nil then
          __lux_tmp_g_184 = 0
        end
        local __lux_tmp_b_185 = color.b
        if __lux_tmp_b_185 == nil then
          __lux_tmp_b_185 = 0
        end
        local __lux_tmp_a_186 = color.a
        if __lux_tmp_a_186 == nil then
          __lux_tmp_a_186 = 255
        end
        setupParamMatrixRaw(
          material,
          __lux_tmp_r_183 * inv255,
          __lux_tmp_g_184 * inv255,
          __lux_tmp_b_185 * inv255,
          __lux_tmp_a_186 * inv255,
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
      local __lux_tmp_189 = color ~= nil
      if __lux_tmp_189 then
        local __lux_tmp_a_188 = color.a
        if __lux_tmp_a_188 == nil then
          __lux_tmp_a_188 = 255
        end
        __lux_tmp_189 = __lux_tmp_a_188 <= 0
      end
      if __lux_tmp_189 then
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
        local __lux_tmp_grow_190 = toNumber(grow)
        if __lux_tmp_grow_190 == nil then
          __lux_tmp_grow_190 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_190)
      end
      if grow <= 0 then
        return radius
      end
      if typeOf(radius) == "table" and not style.isColor(radius) then
        local __lux_tmp_tl_191 = radius.tl
        if __lux_tmp_tl_191 == nil then
          __lux_tmp_tl_191 = radius[1]
        end
        local __lux_tmp_tl_192 = toNumber(__lux_tmp_tl_191)
        if __lux_tmp_tl_192 == nil then
          __lux_tmp_tl_192 = 0
        end
        local __lux_tmp_tr_193 = radius.tr
        if __lux_tmp_tr_193 == nil then
          __lux_tmp_tr_193 = radius[2]
        end
        if __lux_tmp_tr_193 == nil then
          __lux_tmp_tr_193 = radius.tl
        end
        if __lux_tmp_tr_193 == nil then
          __lux_tmp_tr_193 = radius[1]
        end
        local __lux_tmp_tr_194 = toNumber(__lux_tmp_tr_193)
        if __lux_tmp_tr_194 == nil then
          __lux_tmp_tr_194 = 0
        end
        local __lux_tmp_br_195 = radius.br
        if __lux_tmp_br_195 == nil then
          __lux_tmp_br_195 = radius[3]
        end
        if __lux_tmp_br_195 == nil then
          __lux_tmp_br_195 = radius.tr
        end
        if __lux_tmp_br_195 == nil then
          __lux_tmp_br_195 = radius[2]
        end
        if __lux_tmp_br_195 == nil then
          __lux_tmp_br_195 = radius.tl
        end
        if __lux_tmp_br_195 == nil then
          __lux_tmp_br_195 = radius[1]
        end
        local __lux_tmp_br_196 = toNumber(__lux_tmp_br_195)
        if __lux_tmp_br_196 == nil then
          __lux_tmp_br_196 = 0
        end
        local __lux_tmp_bl_197 = radius.bl
        if __lux_tmp_bl_197 == nil then
          __lux_tmp_bl_197 = radius[4]
        end
        if __lux_tmp_bl_197 == nil then
          __lux_tmp_bl_197 = radius.br
        end
        if __lux_tmp_bl_197 == nil then
          __lux_tmp_bl_197 = radius[3]
        end
        if __lux_tmp_bl_197 == nil then
          __lux_tmp_bl_197 = radius.tr
        end
        if __lux_tmp_bl_197 == nil then
          __lux_tmp_bl_197 = radius[2]
        end
        if __lux_tmp_bl_197 == nil then
          __lux_tmp_bl_197 = radius.tl
        end
        if __lux_tmp_bl_197 == nil then
          __lux_tmp_bl_197 = radius[1]
        end
        local __lux_tmp_bl_198 = toNumber(__lux_tmp_bl_197)
        if __lux_tmp_bl_198 == nil then
          __lux_tmp_bl_198 = 0
        end
        return {
          tl = mathMax(0, __lux_tmp_tl_192) + grow,
          tr = mathMax(0, __lux_tmp_tr_194) + grow,
          br = mathMax(0, __lux_tmp_br_196) + grow,
          bl = mathMax(0, __lux_tmp_bl_198) + grow,
        }
      end
      local __lux_tmp_radius_199 = toNumber(radius)
      if __lux_tmp_radius_199 == nil then
        __lux_tmp_radius_199 = 0
      end
      return __lux_tmp_radius_199 + grow
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
        local __lux_tmp_shadowGrow_200 = shadowGrow
        if __lux_tmp_shadowGrow_200 == nil then
          __lux_tmp_shadowGrow_200 = 0
        end
        shadowGrow = mathMax(0, __lux_tmp_shadowGrow_200)
      end
      do
        local __lux_tmp_outerGrow_201 = outerGrow
        if __lux_tmp_outerGrow_201 == nil then
          __lux_tmp_outerGrow_201 = 0
        end
        outerGrow = mathMax(0, __lux_tmp_outerGrow_201)
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
        local __lux_tmp_shadowWidth_202 = shadowWidth
        if __lux_tmp_shadowWidth_202 == nil then
          __lux_tmp_shadowWidth_202 = 1
        end
        shadowWidth = mathMax(0.001, __lux_tmp_shadowWidth_202)
      end
      do
        local __lux_tmp_outerWidth_203 = outerWidth
        if __lux_tmp_outerWidth_203 == nil then
          __lux_tmp_outerWidth_203 = 1
        end
        outerWidth = mathMax(0.001, __lux_tmp_outerWidth_203)
      end
      do
        local __lux_tmp_shadowExtent_204 = shadowExtent
        if __lux_tmp_shadowExtent_204 == nil then
          __lux_tmp_shadowExtent_204 = shadowWidth
        end
        shadowExtent = mathMax(1, __lux_tmp_shadowExtent_204)
      end
      do
        local __lux_tmp_outerExtent_205 = outerExtent
        if __lux_tmp_outerExtent_205 == nil then
          __lux_tmp_outerExtent_205 = outerWidth
        end
        outerExtent = mathMax(1, __lux_tmp_outerExtent_205)
      end
      do
        local __lux_tmp_shadowStrength_206 = shadowStrength
        if __lux_tmp_shadowStrength_206 == nil then
          __lux_tmp_shadowStrength_206 = 0
        end
        shadowStrength = mathMax(0, __lux_tmp_shadowStrength_206)
      end
      do
        local __lux_tmp_outerStrength_207 = outerStrength
        if __lux_tmp_outerStrength_207 == nil then
          __lux_tmp_outerStrength_207 = 0
        end
        outerStrength = mathMax(0, __lux_tmp_outerStrength_207)
      end
      do
        local __lux_tmp_shadowFalloff_208 = shadowFalloff
        if __lux_tmp_shadowFalloff_208 == nil then
          __lux_tmp_shadowFalloff_208 = 1
        end
        shadowFalloff = mathMax(0.001, __lux_tmp_shadowFalloff_208)
      end
      do
        local __lux_tmp_outerFalloff_209 = outerFalloff
        if __lux_tmp_outerFalloff_209 == nil then
          __lux_tmp_outerFalloff_209 = 1
        end
        outerFalloff = mathMax(0.001, __lux_tmp_outerFalloff_209)
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
        local __lux_tmp_210
        if hasShadow then
          __lux_tmp_210 = sr
        else
          __lux_tmp_210 = 0
        end
        local __lux_tmp_211
        if hasShadow then
          __lux_tmp_211 = sg
        else
          __lux_tmp_211 = 0
        end
        local __lux_tmp_212
        if hasShadow then
          __lux_tmp_212 = sb
        else
          __lux_tmp_212 = 0
        end
        local __lux_tmp_213
        if hasShadow then
          __lux_tmp_213 = sa
        else
          __lux_tmp_213 = 0
        end
        local __lux_tmp_214
        if hasShadow then
          __lux_tmp_214 = shadowWidth
        else
          __lux_tmp_214 = 1
        end
        local __lux_tmp_215
        if hasShadow then
          __lux_tmp_215 = shadowStrength
        else
          __lux_tmp_215 = 0
        end
        local __lux_tmp_216
        if hasShadow then
          __lux_tmp_216 = shadowFalloff
        else
          __lux_tmp_216 = 1
        end
        setupParamMatrixRaw(
          material,
          sw,
          sh,
          0,
          0,
          __lux_tmp_210,
          __lux_tmp_211,
          __lux_tmp_212,
          __lux_tmp_213,
          shadowShapeX - sx,
          shadowShapeY - sy,
          shadowGw,
          shadowGh,
          roundRectRadiusScalar(radiusWithGrow(radius, shadowGrow), shadowGw, shadowGh),
          __lux_tmp_214,
          __lux_tmp_215,
          __lux_tmp_216
        )
      end
      do
        local __lux_tmp_217
        if hasOuter then
          __lux_tmp_217 = orr
        else
          __lux_tmp_217 = 0
        end
        local __lux_tmp_218
        if hasOuter then
          __lux_tmp_218 = og
        else
          __lux_tmp_218 = 0
        end
        local __lux_tmp_219
        if hasOuter then
          __lux_tmp_219 = ob
        else
          __lux_tmp_219 = 0
        end
        local __lux_tmp_220
        if hasOuter then
          __lux_tmp_220 = oa
        else
          __lux_tmp_220 = 0
        end
        local __lux_tmp_221
        if hasOuter then
          __lux_tmp_221 = outerWidth
        else
          __lux_tmp_221 = 1
        end
        local __lux_tmp_222
        if hasOuter then
          __lux_tmp_222 = outerStrength
        else
          __lux_tmp_222 = 0
        end
        local __lux_tmp_223
        if hasOuter then
          __lux_tmp_223 = outerFalloff
        else
          __lux_tmp_223 = 1
        end
        setupAuxConstantsRaw(
          material,
          __lux_tmp_217,
          __lux_tmp_218,
          __lux_tmp_219,
          __lux_tmp_220,
          outerShapeX - sx,
          outerShapeY - sy,
          outerGw,
          outerGh,
          roundRectRadiusScalar(radiusWithGrow(radius, outerGrow), outerGw, outerGh),
          __lux_tmp_221,
          __lux_tmp_222,
          __lux_tmp_223,
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
        local __lux_tmp_224
        if profiling then
          __lux_tmp_224 = roundRectProfileStart()
        else
          __lux_tmp_224 = nil
        end
        bleedProfile = __lux_tmp_224
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
      local strokePad
      if stroke ~= nil then
        do
          local __lux_tmp_strokeWidth_225 = toNumber(strokeWidth)
          if __lux_tmp_strokeWidth_225 == nil then
            __lux_tmp_strokeWidth_225 = 0
          end
          strokePad = mathCeil(mathMax(0, __lux_tmp_strokeWidth_225) * 0.5 + 1)
        end
      else
        strokePad = 0
      end
      local sx = x - strokePad
      local sy = y - strokePad
      local ex = x + w + strokePad
      local ey = y + h + strokePad
      do
        local __lux_tmp_226
        if hasShadow then
          do
            local __lux_tmp_shadowGrow_227 = shadowGrow
            if __lux_tmp_shadowGrow_227 == nil then
              __lux_tmp_shadowGrow_227 = 0
            end
            __lux_tmp_226 = mathMax(0, __lux_tmp_shadowGrow_227)
          end
        else
          __lux_tmp_226 = 0
        end
        shadowGrow = __lux_tmp_226
      end
      do
        local __lux_tmp_228
        if hasShadow then
          do
            local __lux_tmp_shadowWidth_229 = shadowWidth
            if __lux_tmp_shadowWidth_229 == nil then
              __lux_tmp_shadowWidth_229 = 1
            end
            __lux_tmp_228 = mathMax(0.001, __lux_tmp_shadowWidth_229)
          end
        else
          __lux_tmp_228 = 1
        end
        shadowWidth = __lux_tmp_228
      end
      do
        local __lux_tmp_230
        if hasShadow then
          do
            local __lux_tmp_shadowFalloff_231 = shadowFalloff
            if __lux_tmp_shadowFalloff_231 == nil then
              __lux_tmp_shadowFalloff_231 = 1
            end
            __lux_tmp_230 = mathMax(0.001, __lux_tmp_shadowFalloff_231)
          end
        else
          __lux_tmp_230 = 1
        end
        shadowFalloff = __lux_tmp_230
      end
      if hasShadow then
        local spread
        do
          local __lux_tmp_shadowExtent_232 = shadowExtent
          if __lux_tmp_shadowExtent_232 == nil then
            __lux_tmp_shadowExtent_232 = shadowWidth
          end
          spread = mathMax(1, __lux_tmp_shadowExtent_232)
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
        local __lux_tmp_233
        if hasOuter then
          do
            local __lux_tmp_outerGrow_234 = outerGrow
            if __lux_tmp_outerGrow_234 == nil then
              __lux_tmp_outerGrow_234 = 0
            end
            __lux_tmp_233 = mathMax(0, __lux_tmp_outerGrow_234)
          end
        else
          __lux_tmp_233 = 0
        end
        outerGrow = __lux_tmp_233
      end
      do
        local __lux_tmp_235
        if hasOuter then
          do
            local __lux_tmp_outerWidth_236 = outerWidth
            if __lux_tmp_outerWidth_236 == nil then
              __lux_tmp_outerWidth_236 = 1
            end
            __lux_tmp_235 = mathMax(0.001, __lux_tmp_outerWidth_236)
          end
        else
          __lux_tmp_235 = 1
        end
        outerWidth = __lux_tmp_235
      end
      do
        local __lux_tmp_237
        if hasOuter then
          do
            local __lux_tmp_outerFalloff_238 = outerFalloff
            if __lux_tmp_outerFalloff_238 == nil then
              __lux_tmp_outerFalloff_238 = 1
            end
            __lux_tmp_237 = mathMax(0.001, __lux_tmp_outerFalloff_238)
          end
        else
          __lux_tmp_237 = 1
        end
        outerFalloff = __lux_tmp_237
      end
      if hasOuter then
        local spread
        do
          local __lux_tmp_outerExtent_239 = outerExtent
          if __lux_tmp_outerExtent_239 == nil then
            __lux_tmp_outerExtent_239 = outerWidth
          end
          spread = mathMax(1, __lux_tmp_outerExtent_239)
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
        local __lux_tmp_radiusValue_240 = radiusValue
        if __lux_tmp_radiusValue_240 == nil then
          __lux_tmp_radiusValue_240 = roundRectRadiusScalar(radius, w, h)
        end
        setupRoundRectConstants(
          material,
          w,
          h,
          fill,
          stroke,
          strokeWidth,
          __lux_tmp_radiusValue_240
        )
      end
      do
        local __lux_tmp_241
        if hasShadow then
          __lux_tmp_241 = sr
        else
          __lux_tmp_241 = 0
        end
        local __lux_tmp_242
        if hasShadow then
          __lux_tmp_242 = sg
        else
          __lux_tmp_242 = 0
        end
        local __lux_tmp_243
        if hasShadow then
          __lux_tmp_243 = sb
        else
          __lux_tmp_243 = 0
        end
        local __lux_tmp_244
        if hasShadow then
          __lux_tmp_244 = sa * shadowStrength
        else
          __lux_tmp_244 = 0
        end
        local __lux_tmp_245
        if hasOuter then
          __lux_tmp_245 = orr
        else
          __lux_tmp_245 = 0
        end
        local __lux_tmp_246
        if hasOuter then
          __lux_tmp_246 = og
        else
          __lux_tmp_246 = 0
        end
        local __lux_tmp_247
        if hasOuter then
          __lux_tmp_247 = ob
        else
          __lux_tmp_247 = 0
        end
        local __lux_tmp_248
        if hasOuter then
          __lux_tmp_248 = oa * outerStrength
        else
          __lux_tmp_248 = 0
        end
        setupAuxConstantsRaw(
          material,
          __lux_tmp_241,
          __lux_tmp_242,
          __lux_tmp_243,
          __lux_tmp_244,
          shadowX,
          shadowY,
          shadowGrow,
          shadowWidth,
          __lux_tmp_245,
          __lux_tmp_246,
          __lux_tmp_247,
          __lux_tmp_248,
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
        local __lux_tmp_249
        if profiling then
          __lux_tmp_249 = roundRectProfileStart()
        else
          __lux_tmp_249 = nil
        end
        bleedProfile = __lux_tmp_249
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
        local __lux_tmp_a_250 = tint.a
        if __lux_tmp_a_250 == nil then
          __lux_tmp_a_250 = 255
        end
        local __lux_tmp_opacity_251 = spec.opacity
        if __lux_tmp_opacity_251 == nil then
          __lux_tmp_opacity_251 = 1
        end
        alpha = __lux_tmp_a_250 * __lux_tmp_opacity_251
      end
      if alpha <= 0 then
        return nil
      end
      do
        local __lux_tmp_r_252 = tint.r
        if __lux_tmp_r_252 == nil then
          __lux_tmp_r_252 = 0
        end
        backdropTintScratch.r = __lux_tmp_r_252
      end
      do
        local __lux_tmp_g_253 = tint.g
        if __lux_tmp_g_253 == nil then
          __lux_tmp_g_253 = 0
        end
        backdropTintScratch.g = __lux_tmp_g_253
      end
      do
        local __lux_tmp_b_254 = tint.b
        if __lux_tmp_b_254 == nil then
          __lux_tmp_b_254 = 0
        end
        backdropTintScratch.b = __lux_tmp_b_254
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
        local __lux_tmp_padding_255 = toNumber(spec.padding)
        if __lux_tmp_padding_255 == nil then
          __lux_tmp_padding_255 = 0
        end
        pad = mathMax(0, __lux_tmp_padding_255)
      end
      local bx = x - pad
      local by = y - pad
      local bw = w + pad * 2
      local bh = h + pad * 2
      local br = radiusWithGrow(radius, pad)
      local tint = backdropTintColor(spec)
      local blurred = false
      if spec.blur > 0 and materialOK(roundRectMaterials.roundrect_blur) then
        local material = roundRectMaterials.roundrect_blur
        prepareBackdropBlur(spec.blur, spec.recapture, spec.level)
        surfaceSetMaterial(material)
        surfaceSetDrawColor(255, 255, 255, 255)
        setupAuxConstantsRaw(material, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        setupParamMatrix(
          material,
          1,
          0,
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
        if tint ~= nil then
          do
            local __lux_tmp_r_256 = tint.r
            if __lux_tmp_r_256 == nil then
              __lux_tmp_r_256 = 0
            end
            local __lux_tmp_g_257 = tint.g
            if __lux_tmp_g_257 == nil then
              __lux_tmp_g_257 = 0
            end
            local __lux_tmp_b_258 = tint.b
            if __lux_tmp_b_258 == nil then
              __lux_tmp_b_258 = 0
            end
            local __lux_tmp_a_259 = tint.a
            if __lux_tmp_a_259 == nil then
              __lux_tmp_a_259 = 255
            end
            setupAuxConstantsRaw(
              material,
              __lux_tmp_r_256 * inv255,
              __lux_tmp_g_257 * inv255,
              __lux_tmp_b_258 * inv255,
              __lux_tmp_a_259 * inv255,
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
        drawTexturedQuad(bx, by, bw, bh, material)
        blurred = true
      end
      if tint ~= nil and not blurred then
        backdropFillScratch._mgfxFillVisible = true
        drawRoundRectFillPass(bx, by, bw, bh, br, backdropFillScratch)
      end
      return spec
    end
    drawRoundRectStrokePass = function(x, y, w, h, radius, stroke, strokeWidth, strokeKind, strokeLength, strokeGap, strokeOffset)
      if strokeKind == nil then
        strokeKind = style.STROKE_SOLID
      end
      if strokeLength == nil then
        strokeLength = 0
      end
      if strokeGap == nil then
        strokeGap = 0
      end
      if strokeOffset == nil then
        strokeOffset = 0
      end
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
          strokeKind,
          strokeLength,
          strokeGap,
          strokeOffset,
          0,
          0,
          0,
          0
        )
        surfaceSetMaterial(material)
        surfaceSetDrawColor(255, 255, 255, 255)
        drawRoundRectBaseQuad(x, y, w, h, material, strokeWidth)
        return true
      end
      if strokeKind ~= style.STROKE_SOLID then
        drawRoundRectFallbackPrepared(
          x,
          y,
          w,
          h,
          radius,
          transparentFill,
          false,
          stroke,
          strokeWidth,
          true,
          strokeKind,
          strokeLength,
          strokeGap,
          strokeOffset
        )
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
      drawRoundRectBaseQuad(x, y, w, h, material, strokeWidth)
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
          local __lux_tmp_glowWidth_260 = toNumber(glowWidth)
          if __lux_tmp_glowWidth_260 == nil then
            __lux_tmp_glowWidth_260 = 8
          end
          glowWidth = mathMax(0.001, __lux_tmp_glowWidth_260)
        end
        do
          local __lux_tmp_glowStrength_261 = toNumber(glowStrength)
          if __lux_tmp_glowStrength_261 == nil then
            __lux_tmp_glowStrength_261 = 1
          end
          glowStrength = mathMax(0, __lux_tmp_glowStrength_261)
        end
        do
          local __lux_tmp_glowFalloff_262 = toNumber(glowFalloff)
          if __lux_tmp_glowFalloff_262 == nil then
            __lux_tmp_glowFalloff_262 = 1.65
          end
          glowFalloff = mathMax(0.001, __lux_tmp_glowFalloff_262)
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
      do
        local __lux_tmp_263
        if stroke ~= nil then
          __lux_tmp_263 = strokeWidth
        else
          __lux_tmp_263 = 0
        end
        drawRoundRectBaseQuad(x, y, w, h, material, __lux_tmp_263)
      end
      if profiling then
        roundRectProfileEnd("round.base.fx.draw", drawProfile)
      end
      return true
    end
  end
  do
    drawRoundRectPrepared = function(x, y, w, h, radius, fill, hasFill, strokeValue, strokeWidth, hasStroke, strokeKind, strokeLength, strokeGap, strokeOffset, hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread, hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread, hasInner, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff, backdropSpec, patternSpec, profiling, totalProfile, stageProfile, shadowLayers, shadowLayerCount, shadowLayersCullSpread)
      if shadowLayerCount == nil then
        shadowLayerCount = 0
      end
      if shadowLayersCullSpread == nil then
        shadowLayersCullSpread = 0
      end
      if profiling == nil then
        profiling = roundRectProfileActive()
        do
          local __lux_tmp_264
          if profiling then
            __lux_tmp_264 = roundRectProfileStart()
          else
            __lux_tmp_264 = nil
          end
          totalProfile = __lux_tmp_264
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
      if strokeKind == nil then
        strokeKind = style.STROKE_SOLID
      end
      local specialStroke = hasStroke and strokeKind ~= style.STROKE_SOLID
      local baseHasStroke = hasStroke and not specialStroke
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
      if hasStroke then
        cullSpread = mathMax(cullSpread, strokeWidth * 0.5 + 1)
      end
      if shaderReady then
        if hasShadow then
          do
            local __lux_tmp_shadowCullSpread_265 = shadowCullSpread
            if __lux_tmp_shadowCullSpread_265 == nil then
              __lux_tmp_shadowCullSpread_265 = 0
            end
            cullSpread = mathMax(cullSpread, __lux_tmp_shadowCullSpread_265)
          end
        end
        if hasShadowLayers then
          do
            local __lux_tmp_shadowLayersCullSpread_266 = shadowLayersCullSpread
            if __lux_tmp_shadowLayersCullSpread_266 == nil then
              __lux_tmp_shadowLayersCullSpread_266 = 0
            end
            cullSpread = mathMax(cullSpread, __lux_tmp_shadowLayersCullSpread_266)
          end
        end
        if hasOuter then
          do
            local __lux_tmp_outerCullSpread_267 = outerCullSpread
            if __lux_tmp_outerCullSpread_267 == nil then
              __lux_tmp_outerCullSpread_267 = 0
            end
            cullSpread = mathMax(cullSpread, __lux_tmp_outerCullSpread_267)
          end
        end
        if backdropSpec ~= nil then
          do
            local __lux_tmp_padding_268 = toNumber(backdropSpec.padding)
            if __lux_tmp_padding_268 == nil then
              __lux_tmp_padding_268 = 0
            end
            cullSpread = mathMax(cullSpread, mathMax(0, __lux_tmp_padding_268))
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
          hasStroke,
          strokeKind,
          strokeLength,
          strokeGap,
          strokeOffset
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
      local canTryFused = backdropSpec == nil and patternSpec == nil and not hasInner and not specialStroke and not transformActive and not hasShadowLayers and (hasFill or baseHasStroke) and (hasShadow or hasOuter)
      if canTryFused then
        do
          local __lux_tmp_269
          if profiling then
            __lux_tmp_269 = roundRectProfileStart()
          else
            __lux_tmp_269 = nil
          end
          profile = __lux_tmp_269
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
          local __lux_tmp_270
          if profiling then
            __lux_tmp_270 = roundRectProfileStart()
          else
            __lux_tmp_270 = nil
          end
          profile = __lux_tmp_270
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
          local __lux_tmp_271
          if profiling then
            __lux_tmp_271 = roundRectProfileStart()
          else
            __lux_tmp_271 = nil
          end
          profile = __lux_tmp_271
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
      if backdropSpec ~= nil then
        do
          local __lux_tmp_272
          if profiling then
            __lux_tmp_272 = roundRectProfileStart()
          else
            __lux_tmp_272 = nil
          end
          profile = __lux_tmp_272
        end
        drawRoundRectBackdrop(x, y, w, h, radius, backdropSpec)
        if profiling then
          roundRectProfileEnd("round.backdrop", profile)
        end
      end
      if not hasFill and not hasStroke and patternSpec == nil and not hasInner then
        finishImmediateProfile(profiling, totalProfile)
        return
      end
      local drawFill
      if hasFill then
        drawFill = fill
      else
        drawFill = transparentFill
      end
      local baseStrokeValue
      if baseHasStroke then
        baseStrokeValue = strokeValue
      else
        baseStrokeValue = nil
      end
      local baseStrokeWidth
      if baseHasStroke then
        baseStrokeWidth = strokeWidth
      else
        baseStrokeWidth = 0
      end
      local innerGlowDrawn = false
      if patternSpec ~= nil then
        do
          local __lux_tmp_273
          if profiling then
            __lux_tmp_273 = roundRectProfileStart()
          else
            __lux_tmp_273 = nil
          end
          profile = __lux_tmp_273
        end
        if hasFill then
          drawRoundRectFillPass(x, y, w, h, radius, fill)
        end
        drawRoundRectPatternPrepared(x, y, w, h, radius, patternSpec)
        if hasStroke then
          drawRoundRectStrokePass(
            x,
            y,
            w,
            h,
            radius,
            strokeValue,
            strokeWidth,
            strokeKind,
            strokeLength,
            strokeGap,
            strokeOffset
          )
        end
        if profiling then
          roundRectProfileEnd("round.layered", profile)
        end
      else
        do
          local __lux_tmp_274
          if profiling then
            __lux_tmp_274 = roundRectProfileStart()
          else
            __lux_tmp_274 = nil
          end
          profile = __lux_tmp_274
        end
        local radiusValue = roundRectRadiusScalar(radius, w, h)
        local baseKind
        if drawFill.kind == style.FILL_LINEAR then
          baseKind = "round.base.gradient"
        else
          if baseHasStroke then
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
          baseStrokeValue,
          baseStrokeWidth,
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
              if hasFill or baseHasStroke then
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
                  baseStrokeValue,
                  baseStrokeWidth,
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
                drawRoundRectBaseQuad(x, y, w, h, roundRectMaterials.roundrect, baseStrokeWidth)
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
        if specialStroke then
          drawRoundRectStrokePass(
            x,
            y,
            w,
            h,
            radius,
            strokeValue,
            strokeWidth,
            strokeKind,
            strokeLength,
            strokeGap,
            strokeOffset
          )
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
      local hasStroke, strokeColor, strokeWidth, strokeKind, strokeLength, strokeGap, strokeOffset = style.strokeRaw(strokeValue, strokeWidthInput)
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
        strokeColor,
        strokeWidth,
        hasStroke,
        strokeKind,
        strokeLength,
        strokeGap,
        strokeOffset,
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
      local __lux_tmp_radius_275 = styleValue.radius
      if __lux_tmp_radius_275 == nil then
        __lux_tmp_radius_275 = styleValue.r
      end
      if __lux_tmp_radius_275 == nil then
        __lux_tmp_radius_275 = 0
      end
      local __lux_tmp_fill_276 = styleValue.fill
      if __lux_tmp_fill_276 == nil then
        __lux_tmp_fill_276 = styleValue.color
      end
      return drawRoundRectRaw(
        x,
        y,
        w,
        h,
        __lux_tmp_radius_275,
        __lux_tmp_fill_276,
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
    roundedBoxBackdrop = function(x, y, w, h, radius, backdrop)
      return drawRoundRectRaw(x, y, w, h, radius, transparentColor, nil, 0, nil, nil, nil, backdrop)
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
            local __lux_tmp_fill_277 = stripped.fill
            if __lux_tmp_fill_277 == nil then
              __lux_tmp_fill_277 = stripped.color
            end
            return drawRoundRectRaw(
              x,
              y,
              size,
              size,
              radius,
              __lux_tmp_fill_277,
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
      local __lux_tmp_fill_278 = stripped.fill
      if __lux_tmp_fill_278 == nil then
        __lux_tmp_fill_278 = stripped.color
      end
      return drawRoundRectRaw(
        x,
        y,
        size,
        size,
        radius,
        __lux_tmp_fill_278,
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
            local __lux_tmp_fill_279 = stripped.fill
            if __lux_tmp_fill_279 == nil then
              __lux_tmp_fill_279 = stripped.color
            end
            return drawRoundRectRaw(
              x,
              y,
              w,
              h,
              radius,
              __lux_tmp_fill_279,
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
      local __lux_tmp_fill_280 = stripped.fill
      if __lux_tmp_fill_280 == nil then
        __lux_tmp_fill_280 = stripped.color
      end
      return drawRoundRectRaw(
        x,
        y,
        w,
        h,
        radius,
        __lux_tmp_fill_280,
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
        local __lux_tmp_internal_281 = owner._internal
        if __lux_tmp_internal_281 == nil then
          __lux_tmp_internal_281 = {}
        end
        owner._internal = __lux_tmp_internal_281
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
      owner.RoundedBoxBackdrop = roundedBoxBackdrop
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
  __lux_exports.drawStrokePath = drawStrokePath
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
  __lux_exports.roundedBoxBackdrop = roundedBoxBackdrop
  __lux_exports.circle = circle
  __lux_exports.circleEx = circleEx
  __lux_exports.capsule = capsule
  __lux_exports.capsuleEx = capsuleEx
  __lux_exports.install = install

  return __lux_exports
end
