return function(__lux_import)
  local __lux_exports = {}
  local frame
  local geometry
  local roundrect
  local style
  local getConVar
  local matrixCtor
  local mathAbs
  local mathClamp
  local mathFloor
  local mathMax
  local mathMin
  local mathCos
  local mathRad
  local mathSin
  local mathSqrt
  local renderCopyRenderTargetToTexture
  local surfaceDrawLine
  local surfaceSetMaterial
  local surfaceSetDrawColor
  local toNumber
  local typeOf
  local makeColor
  local drawTransformedPoly
  local drawTexturedQuad
  local drawTexturedQuadUV
  local backdropBlurIntensity
  local hasTransform
  local isCulled
  local splitStyleTransform
  local withTransform
  local beginPanelEffectBleed
  local endPanelEffectBleed
  local withPanelEffectBleed
  local paramMatrixProbe
  local paramMatrixSetUnpacked
  local paramMatrices
  local auxParamMatrices
  local primitiveMaterials
  local primitiveBlurRT
  local primitiveMatOK
  local primitiveHasShaders
  local forceFallbackCvar
  local lineVertsScratch
  local lineFallbackVertsScratch
  local linePolyPointsScratch
  local polyDrawRectScratch
  local defaultLineColor
  local transparentColor
  local LINE_AA_FRINGE
  local LINE_NO_CAPS_UV_OFFSET
  local configurePrimitives
  local materialOK
  local shadersActive
  local setupParamMatrix
  local fillColor
  local pointXY
  local effectBleedFromDrawRect
  local chamferTuple
  local chamferPoints
  local signedArea
  local isConvex
  local normalizePoly
  local offsetEdgeLine
  local offsetLineIntersection
  local growConvexPoly
  local polyDrawVerts
  local setupLineConstants
  local drawLineShaderVerts
  local lineQuadVertsInto
  local drawLineRectRaw
  local drawLineFallbackVerts
  local drawLineQuadRaw
  local drawLineRaw
  local drawLineImmediate
  local lineEx
  local line
  local polyBackdropTintScratch
  local polyMaterialKey
  local drawMaterialPoly
  local polyDrawRect
  local setupPrimitiveBlurConstants
  local drawBlurredPoly
  local polyBackdropTintColor
  local drawPolyBackdrop
  local polyEffectBounds
  local includeBounds
  local shadowVertex
  local setupPolyShadowAuxConstants
  local setupPolyEffectConstants
  local drawPolyShadow
  local drawPolyOuterGlow
  local drawPolyPattern
  local setupPolyStrokeConstants
  local drawPolyStrokeShader
  local setupPolyFillConstants
  local drawPolyStroke
  local drawPolyFallbackRaw
  local drawPolyRawNormalized
  local drawPolyImmediateNormalized
  local drawPolyRaw
  local drawPolyImmediate
  local transparentFill
  local chamferFillParams
  local setupPrimitiveAuxConstants
  local setupPrimitiveFillConstants
  local drawChamferInnerGlowRaw
  local cutsWithGrow
  local chamferEffectBounds
  local drawChamferShadowOuterRaw
  local chamferBackdropTintColor
  local drawChamferBackdrop
  local drawChamferPattern
  local drawChamferStroke
  local drawChamferBasePass
  local drawChamferBoxRaw
  local drawChamferBoxImmediate
  local polyEx
  local poly
  local regularPolyScratch
  local diamondScratch
  local caretScratch
  local clearPoints
  local setPoint
  local regularPolyPoints
  local diamondPoints
  local caretPoints
  local regularPolyEx
  local regularPoly
  local diamondEx
  local diamond
  local caretEx
  local caret
  local chamferBoxEx
  local chamferBox
  local install
  do
    local __lux_import_1 = __lux_import("lux/mgfx/frame#client")
    local frameImport = __lux_import_1
    local __lux_import_2 = __lux_import("lux/mgfx/geometry#client")
    local geometryImport = __lux_import_2
    local __lux_import_3 = __lux_import("lux/mgfx/roundrect#client")
    local roundrectImport = __lux_import_3
    local __lux_import_4 = __lux_import("lux/mgfx/style#client")
    local styleImport = __lux_import_4
    frame = frameImport
    geometry = geometryImport
    roundrect = roundrectImport
    style = styleImport
    getConVar = GetConVar
    matrixCtor = Matrix
    mathAbs = math.abs
    mathClamp = math.Clamp
    mathFloor = math.floor
    mathMax = math.max
    mathMin = math.min
    mathCos = math.cos
    mathRad = math.rad
    mathSin = math.sin
    mathSqrt = math.sqrt
    do
      local __lux_obj_5 = render
      local __lux_val_6 = nil
      if __lux_obj_5 ~= nil then
        __lux_val_6 = __lux_obj_5.CopyRenderTargetToTexture
      end
      renderCopyRenderTargetToTexture = __lux_val_6
    end
    surfaceDrawLine = surface.DrawLine
    surfaceSetMaterial = surface.SetMaterial
    surfaceSetDrawColor = surface.SetDrawColor
    toNumber = tonumber
    typeOf = type
    makeColor = Color
    drawTransformedPoly = geometry.drawTransformedPoly
    drawTexturedQuad = geometry.drawTexturedQuad
    drawTexturedQuadUV = geometry.drawTexturedQuadUV
    backdropBlurIntensity = geometry.blurIntensity
    hasTransform = geometry.hasTransform
    isCulled = frame.isCulled
    splitStyleTransform = geometry.splitStyleTransform
    withTransform = geometry.withTransform
    beginPanelEffectBleed = frame.beginPanelEffectBleed
    endPanelEffectBleed = frame.endPanelEffectBleed
    withPanelEffectBleed = frame.withPanelEffectBleed
    do
      local __lux_tmp_7
      if matrixCtor ~= nil then
        __lux_tmp_7 = matrixCtor()
      else
        __lux_tmp_7 = nil
      end
      paramMatrixProbe = __lux_tmp_7
    end
    do
      local __lux_obj_8 = paramMatrixProbe
      local __lux_val_9 = nil
      if __lux_obj_8 ~= nil then
        __lux_val_9 = __lux_obj_8.SetUnpacked
      end
      paramMatrixSetUnpacked = __lux_val_9
    end
    paramMatrices = {}
    auxParamMatrices = {}
    primitiveMaterials = {}
    primitiveBlurRT = nil
    primitiveMatOK = function(material)
      local __lux_tmp_10 = material ~= nil
      if __lux_tmp_10 then
        __lux_tmp_10 = material.IsError ~= nil
      end
      local __lux_tmp_11 = __lux_tmp_10
      if __lux_tmp_11 then
        __lux_tmp_11 = not material:IsError()
      end
      return __lux_tmp_11
    end
    primitiveHasShaders = function()
      return false
    end
    forceFallbackCvar = nil
    lineVertsScratch = { {}, {}, {}, {} }
    lineFallbackVertsScratch = { {}, {}, {}, {} }
    linePolyPointsScratch = { {}, {}, {}, {} }
    polyDrawRectScratch = {}
    defaultLineColor = makeColor(255, 255, 255, 32)
    transparentColor = makeColor(0, 0, 0, 0)
    LINE_AA_FRINGE = 1
    LINE_NO_CAPS_UV_OFFSET = 8
    configurePrimitives = function(owner)
      do
        local __lux_tmp_12 = owner
        if __lux_tmp_12 == nil then
          __lux_tmp_12 = {}
        end
        owner = __lux_tmp_12
      end
      local materialState
      do
        local __lux_tmp_13 = owner._MaterialState
        if __lux_tmp_13 == nil then
          __lux_tmp_13 = {}
        end
        materialState = __lux_tmp_13
      end
      do
        local __lux_tmp_14 = owner._Materials
        if __lux_tmp_14 == nil then
          local __lux_tmp_15 = materialState.materials
          if __lux_tmp_15 == nil then
            local __lux_tmp_16 = primitiveMaterials
            if __lux_tmp_16 == nil then
              __lux_tmp_16 = {}
            end
            __lux_tmp_15 = __lux_tmp_16
          end
          __lux_tmp_14 = __lux_tmp_15
        end
        primitiveMaterials = __lux_tmp_14
      end
      do
        local __lux_tmp_17 = owner._BlurRT
        if __lux_tmp_17 == nil then
          local __lux_tmp_18 = materialState.blurRT
          if __lux_tmp_18 == nil then
            __lux_tmp_18 = primitiveBlurRT
          end
          __lux_tmp_17 = __lux_tmp_18
        end
        primitiveBlurRT = __lux_tmp_17
      end
      do
        local __lux_tmp_19 = owner.MaterialOK
        if __lux_tmp_19 == nil then
          local __lux_tmp_20 = materialState.matOK
          if __lux_tmp_20 == nil then
            __lux_tmp_20 = primitiveMatOK
          end
          __lux_tmp_19 = __lux_tmp_20
        end
        primitiveMatOK = __lux_tmp_19
      end
      do
        local __lux_tmp_21 = owner.hasShaders
        if __lux_tmp_21 == nil then
          __lux_tmp_21 = primitiveHasShaders
        end
        primitiveHasShaders = __lux_tmp_21
      end
      return true
    end
    materialOK = function(material)
      local __lux_tmp_22 = primitiveMatOK ~= nil
      if __lux_tmp_22 then
        __lux_tmp_22 = primitiveMatOK(material)
      end
      return __lux_tmp_22
    end
    shadersActive = function()
      local __lux_tmp_23 = forceFallbackCvar == nil
      if __lux_tmp_23 then
        __lux_tmp_23 = getConVar ~= nil
      end
      if __lux_tmp_23 then
        do
          local __lux_tmp_24 = getConVar("mgfx_force_fallback")
          if __lux_tmp_24 == nil then
            __lux_tmp_24 = false
          end
          forceFallbackCvar = __lux_tmp_24
        end
      end
      local __lux_tmp_25 = forceFallbackCvar ~= nil
      if __lux_tmp_25 then
        __lux_tmp_25 = forceFallbackCvar ~= false
      end
      local __lux_tmp_26 = __lux_tmp_25
      if __lux_tmp_26 then
        __lux_tmp_26 = forceFallbackCvar:GetBool()
      end
      if __lux_tmp_26 then
        return false
      end
      local __lux_tmp_27 = primitiveHasShaders ~= nil
      if __lux_tmp_27 then
        __lux_tmp_27 = primitiveHasShaders()
      end
      return __lux_tmp_27
    end
    setupParamMatrix = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3)
      local __lux_tmp_28 = material == nil
      if not __lux_tmp_28 then
        __lux_tmp_28 = paramMatrixSetUnpacked == nil
      end
      local __lux_tmp_29 = __lux_tmp_28
      if not __lux_tmp_29 then
        __lux_tmp_29 = matrixCtor == nil
      end
      if __lux_tmp_29 then
        return false
      end
      local matrix = paramMatrices[material]
      if matrix == nil then
        matrix = matrixCtor()
        paramMatrices[material] = matrix
      end
      do
        local __lux_tmp_30 = a0
        if __lux_tmp_30 == nil then
          __lux_tmp_30 = 0
        end
        local __lux_tmp_31 = b0
        if __lux_tmp_31 == nil then
          __lux_tmp_31 = 0
        end
        local __lux_tmp_32 = c0
        if __lux_tmp_32 == nil then
          __lux_tmp_32 = 0
        end
        local __lux_tmp_33 = d0
        if __lux_tmp_33 == nil then
          __lux_tmp_33 = 0
        end
        local __lux_tmp_34 = a1
        if __lux_tmp_34 == nil then
          __lux_tmp_34 = 0
        end
        local __lux_tmp_35 = b1
        if __lux_tmp_35 == nil then
          __lux_tmp_35 = 0
        end
        local __lux_tmp_36 = c1
        if __lux_tmp_36 == nil then
          __lux_tmp_36 = 0
        end
        local __lux_tmp_37 = d1
        if __lux_tmp_37 == nil then
          __lux_tmp_37 = 0
        end
        local __lux_tmp_38 = a2
        if __lux_tmp_38 == nil then
          __lux_tmp_38 = 0
        end
        local __lux_tmp_39 = b2
        if __lux_tmp_39 == nil then
          __lux_tmp_39 = 0
        end
        local __lux_tmp_40 = c2
        if __lux_tmp_40 == nil then
          __lux_tmp_40 = 0
        end
        local __lux_tmp_41 = d2
        if __lux_tmp_41 == nil then
          __lux_tmp_41 = 0
        end
        local __lux_tmp_42 = a3
        if __lux_tmp_42 == nil then
          __lux_tmp_42 = 0
        end
        local __lux_tmp_43 = b3
        if __lux_tmp_43 == nil then
          __lux_tmp_43 = 0
        end
        local __lux_tmp_44 = c3
        if __lux_tmp_44 == nil then
          __lux_tmp_44 = 0
        end
        local __lux_tmp_45 = d3
        if __lux_tmp_45 == nil then
          __lux_tmp_45 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_30,
          __lux_tmp_31,
          __lux_tmp_32,
          __lux_tmp_33,
          __lux_tmp_34,
          __lux_tmp_35,
          __lux_tmp_36,
          __lux_tmp_37,
          __lux_tmp_38,
          __lux_tmp_39,
          __lux_tmp_40,
          __lux_tmp_41,
          __lux_tmp_42,
          __lux_tmp_43,
          __lux_tmp_44,
          __lux_tmp_45
        )
      end
      material:SetMatrix("$viewprojmat", matrix)
      return true
    end
    fillColor = function(fill, fallback)
      if style.isColor(fill) then
        return fill
      end
      if typeOf(fill) == "table" then
        local __lux_tmp_46 = fill.colorA
        if __lux_tmp_46 == nil then
          local __lux_tmp_47 = fill.color
          if __lux_tmp_47 == nil then
            local __lux_tmp_48 = fallback
            if __lux_tmp_48 == nil then
              __lux_tmp_48 = color_white
            end
            __lux_tmp_47 = __lux_tmp_48
          end
          __lux_tmp_46 = __lux_tmp_47
        end
        return __lux_tmp_46
      end
      local __lux_tmp_49 = fallback
      if __lux_tmp_49 == nil then
        __lux_tmp_49 = color_white
      end
      return __lux_tmp_49
    end
    pointXY = function(point)
      local __lux_tmp_50 = point.x
      if __lux_tmp_50 == nil then
        __lux_tmp_50 = point[1]
      end
      local __lux_tmp_51 = toNumber(__lux_tmp_50)
      if __lux_tmp_51 == nil then
        __lux_tmp_51 = 0
      end
      local __lux_tmp_52 = point.y
      if __lux_tmp_52 == nil then
        __lux_tmp_52 = point[2]
      end
      local __lux_tmp_53 = toNumber(__lux_tmp_52)
      if __lux_tmp_53 == nil then
        __lux_tmp_53 = 0
      end
      return __lux_tmp_51, __lux_tmp_53
    end
    effectBleedFromDrawRect = function(x, y, w, h, drawX, drawY, drawW, drawH)
      local left = mathMax(0, x - drawX)
      local top = mathMax(0, y - drawY)
      local right = mathMax(0, drawX + drawW - (x + w))
      local bottom = mathMax(0, drawY + drawH - (y + h))
      return left, top, right, bottom
    end
  end
  do
    chamferTuple = function(cuts, w, h)
      local tl
      local tr
      local br
      local bl
      if typeOf(cuts) == "table" then
        do
          local __lux_tmp_54 = cuts.tl
          if __lux_tmp_54 == nil then
            __lux_tmp_54 = cuts[1]
          end
          local __lux_tmp_55 = toNumber(__lux_tmp_54)
          if __lux_tmp_55 == nil then
            __lux_tmp_55 = 0
          end
          tl = __lux_tmp_55
        end
        do
          local __lux_tmp_56 = cuts.tr
          if __lux_tmp_56 == nil then
            __lux_tmp_56 = cuts[2]
          end
          local __lux_tmp_57 = toNumber(__lux_tmp_56)
          if __lux_tmp_57 == nil then
            __lux_tmp_57 = tl
          end
          tr = __lux_tmp_57
        end
        do
          local __lux_tmp_58 = cuts.br
          if __lux_tmp_58 == nil then
            __lux_tmp_58 = cuts[3]
          end
          local __lux_tmp_59 = toNumber(__lux_tmp_58)
          if __lux_tmp_59 == nil then
            __lux_tmp_59 = tr
          end
          br = __lux_tmp_59
        end
        do
          local __lux_tmp_60 = cuts.bl
          if __lux_tmp_60 == nil then
            __lux_tmp_60 = cuts[4]
          end
          local __lux_tmp_61 = toNumber(__lux_tmp_60)
          if __lux_tmp_61 == nil then
            __lux_tmp_61 = br
          end
          bl = __lux_tmp_61
        end
      else
        do
          local __lux_tmp_62 = toNumber(cuts)
          if __lux_tmp_62 == nil then
            __lux_tmp_62 = 0
          end
          tl = __lux_tmp_62
        end
        tr = tl
        br = tl
        bl = tl
      end
      local limit = mathMin(mathAbs(w), mathAbs(h)) * 0.5
      return mathClamp(tl, 0, limit), mathClamp(tr, 0, limit), mathClamp(br, 0, limit), mathClamp(bl, 0, limit)
    end
    chamferPoints = function(x, y, w, h, cuts)
      local tl, tr, br, bl = chamferTuple(cuts, w, h)
      local points = {}
      local add = function(px, py)
        local last = points[#points]
        if last ~= nil then
          local sameX
          do
            local __lux_cmp_63 = false
            if mathAbs(last.x - px) ~= nil and 0.001 ~= nil then
              __lux_cmp_63 = mathAbs(last.x - px) < 0.001
            end
            sameX = __lux_cmp_63
          end
          local sameY
          do
            local __lux_cmp_64 = false
            if mathAbs(last.y - py) ~= nil and 0.001 ~= nil then
              __lux_cmp_64 = mathAbs(last.y - py) < 0.001
            end
            sameY = __lux_cmp_64
          end
          local __lux_tmp_65 = sameX
          if __lux_tmp_65 then
            __lux_tmp_65 = sameY
          end
          if __lux_tmp_65 then
            return
          end
        end
        points[#points + 1] = { x = px, y = py }
      end
      add(x + tl, y)
      add(x + w - tr, y)
      add(x + w, y + tr)
      add(x + w, y + h - br)
      add(x + w - br, y + h)
      add(x + bl, y + h)
      add(x, y + h - bl)
      add(x, y + tl)
      if #points > 1 then
        local first = points[1]
        local last = points[#points]
        local __lux_cmp_66 = false
        if mathAbs(first.x - last.x) ~= nil and 0.001 ~= nil then
          __lux_cmp_66 = mathAbs(first.x - last.x) < 0.001
        end
        local __lux_tmp_67 = __lux_cmp_66
        if __lux_tmp_67 then
          local __lux_cmp_68 = false
          if mathAbs(first.y - last.y) ~= nil and 0.001 ~= nil then
            __lux_cmp_68 = mathAbs(first.y - last.y) < 0.001
          end
          __lux_tmp_67 = __lux_cmp_68
        end
        if __lux_tmp_67 then
          points[#points] = nil
        end
      end
      return points
    end
    signedArea = function(points)
      local area = 0
      for index = 1, #points do
        local ax, ay = pointXY(points[index])
        local bx, by = pointXY(points[index % #points + 1])
        area = area + ax * by - bx * ay
      end
      return area * 0.5
    end
    isConvex = function(points)
      local sign = nil
      for index = 1, #points do
        local ax, ay = pointXY(points[index])
        local bx, by = pointXY(points[index % #points + 1])
        local cx, cy = pointXY(points[(index + 1) % #points + 1])
        local cross = (bx - ax) * (cy - by) - (by - ay) * (cx - bx)
        local __lux_cmp_69 = false
        if mathAbs(cross) ~= nil and 0.000001 ~= nil then
          __lux_cmp_69 = mathAbs(cross) > 0.000001
        end
        if __lux_cmp_69 then
          local current = cross > 0
          if sign == nil then
            sign = current
          else
            if sign ~= current then
              return false
            end
          end
        end
      end
      return true
    end
    normalizePoly = function(points)
      local count
      do
        local __lux_tmp_70 = points
        if __lux_tmp_70 == nil then
          __lux_tmp_70 = {}
        end
        count = #__lux_tmp_70
      end
      local __lux_tmp_71 = count < 3
      if not __lux_tmp_71 then
        __lux_tmp_71 = count > 8
      end
      if __lux_tmp_71 then
        return nil, "DrawPoly expects 3 to 8 vertices"
      end
      if not isConvex(points) then
        return nil, "DrawPoly expects a convex polygon"
      end
      local ordered = {}
      for index = 1, count do
        local x, y = pointXY(points[index])
        ordered[index] = { x = x, y = y }
      end
      local __lux_cmp_72 = false
      if signedArea(ordered) ~= nil and 0 ~= nil then
        __lux_cmp_72 = signedArea(ordered) < 0
      end
      if __lux_cmp_72 then
        local reversed = {}
        for index = count, 1, -1 do
          reversed[#reversed + 1] = ordered[index]
        end
        ordered = reversed
      end
      local minX = ordered[1].x
      local minY = ordered[1].y
      local maxX = minX
      local maxY = minY
      for index = 2, count do
        local point = ordered[index]
        minX = mathMin(minX, point.x)
        minY = mathMin(minY, point.y)
        maxX = mathMax(maxX, point.x)
        maxY = mathMax(maxY, point.y)
      end
      local w = maxX - minX
      local h = maxY - minY
      local __lux_tmp_73 = w <= 0
      if not __lux_tmp_73 then
        __lux_tmp_73 = h <= 0
      end
      if __lux_tmp_73 then
        return nil, "DrawPoly bounds are empty"
      end
      for index = 1, count do
        ordered[index] = { x = ordered[index].x - minX, y = ordered[index].y - minY }
      end
      return { x = minX, y = minY, w = w, h = h, count = count, points = ordered }
    end
    offsetEdgeLine = function(ax, ay, bx, by, amount)
      local dx = bx - ax
      local dy = by - ay
      local length = mathMax(0.0001, mathSqrt(dx * dx + dy * dy))
      local nx = dy / length
      local ny = -dx / length
      return nx, ny, nx * ax + ny * ay + amount
    end
    offsetLineIntersection = function(px, py, n1x, n1y, c1, n2x, n2y, c2, amount)
      local det = n1x * n2y - n1y * n2x
      local __lux_cmp_74 = false
      if mathAbs(det) ~= nil and 0.0001 ~= nil then
        __lux_cmp_74 = mathAbs(det) > 0.0001
      end
      if __lux_cmp_74 then
        return (c1 * n2y - n1y * c2) / det, (n1x * c2 - c1 * n2x) / det
      end
      local ax = n1x + n2x
      local ay = n1y + n2y
      local alen = mathMax(0.0001, mathSqrt(ax * ax + ay * ay))
      ax = ax / alen
      ay = ay / alen
      local scale = amount / mathMax(0.001, ax * n1x + ay * n1y)
      return px + ax * scale, py + ay * scale
    end
    growConvexPoly = function(poly, amount)
      do
        local __lux_tmp_75 = toNumber(amount)
        if __lux_tmp_75 == nil then
          __lux_tmp_75 = 0
        end
        amount = mathMax(0, __lux_tmp_75)
      end
      local __lux_tmp_76 = poly == nil
      if not __lux_tmp_76 then
        __lux_tmp_76 = amount <= 0
      end
      if __lux_tmp_76 then
        return poly
      end
      local absolute = {}
      local count
      do
        local __lux_tmp_77 = poly.count
        if __lux_tmp_77 == nil then
          __lux_tmp_77 = #poly.points
        end
        count = __lux_tmp_77
      end
      for index = 1, count do
        local point = poly.points[index]
        absolute[index] = { x = poly.x + point.x, y = poly.y + point.y }
      end
      local grown = {}
      for index = 1, count do
        local prev = absolute[(index - 2 + count) % count + 1]
        local point = absolute[index]
        local next = absolute[index % count + 1]
        local n1x, n1y, c1 = offsetEdgeLine(prev.x, prev.y, point.x, point.y, amount)
        local n2x, n2y, c2 = offsetEdgeLine(point.x, point.y, next.x, next.y, amount)
        local gx, gy = offsetLineIntersection(point.x, point.y, n1x, n1y, c1, n2x, n2y, c2, amount)
        grown[index] = { x = gx, y = gy }
      end
      local __lux_tmp_78 = normalizePoly(grown)
      if __lux_tmp_78 == nil then
        __lux_tmp_78 = poly
      end
      return __lux_tmp_78
    end
    polyDrawVerts = function(poly)
      local verts = {}
      for index, point in ipairs(poly.points) do
        verts[index] = {
          x = poly.x + point.x,
          y = poly.y + point.y,
          u = point.x / poly.w,
          v = point.y / poly.h,
        }
      end
      return verts
    end
  end
  do
    setupLineConstants = function(material, fill)
      local colorA
      do
        local __lux_tmp_79 = fill.colorA
        if __lux_tmp_79 == nil then
          __lux_tmp_79 = color_white
        end
        colorA = __lux_tmp_79
      end
      local colorB
      do
        local __lux_tmp_80 = fill.colorB
        if __lux_tmp_80 == nil then
          __lux_tmp_80 = colorA
        end
        colorB = __lux_tmp_80
      end
      local r, g, b, a = style.color01(colorA)
      local br, bg, bb, ba = style.color01(colorB)
      setupParamMatrix(material, r, g, b, a, br, bg, bb, ba, 0, 0, 1, 0, 0, 0, 0, 0)
      return style.bindGradientLut(material, fill)
    end
    drawLineShaderVerts = function(verts, fill)
      local material = primitiveMaterials.line
      local __lux_tmp_81 = not shadersActive()
      if not __lux_tmp_81 then
        __lux_tmp_81 = not materialOK(material)
      end
      if __lux_tmp_81 then
        return false
      end
      setupLineConstants(material, fill)
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTransformedPoly(verts)
      return true
    end
    lineQuadVertsInto = function(out, x1, y1, x2, y2, strokeWidth, noCaps, fringeOverride)
      local dx = x2 - x1
      local dy = y2 - y1
      local len = mathSqrt(dx * dx + dy * dy)
      if len <= 0 then
        return nil
      end
      local tx = dx / len
      local ty = dy / len
      local nx = -ty
      local ny = tx
      local fringe
      if fringeOverride == nil then
        fringe = LINE_AA_FRINGE
      else
        fringe = mathMax(0, fringeOverride)
      end
      local capFringe
      if noCaps then
        capFringe = 0
      else
        capFringe = fringe
      end
      local halfWidth = strokeWidth * 0.5 + fringe
      local u0 = -capFringe / len
      local u1 = 1 + capFringe / len
      local vPad = fringe / mathMax(strokeWidth, 0.001)
      local vOffset
      if noCaps then
        vOffset = LINE_NO_CAPS_UV_OFFSET
      else
        vOffset = 0
      end
      local v0 = vOffset - vPad
      local v1 = vOffset + 1 + vPad
      local sx = x1 - tx * capFringe
      local sy = y1 - ty * capFringe
      local ex = x2 + tx * capFringe
      local ey = y2 + ty * capFringe
      out[1].x = sx + nx * halfWidth
      out[1].y = sy + ny * halfWidth
      out[1].u = u0
      out[1].v = v0
      out[2].x = ex + nx * halfWidth
      out[2].y = ey + ny * halfWidth
      out[2].u = u1
      out[2].v = v0
      out[3].x = ex - nx * halfWidth
      out[3].y = ey - ny * halfWidth
      out[3].u = u1
      out[3].v = v1
      out[4].x = sx - nx * halfWidth
      out[4].y = sy - ny * halfWidth
      out[4].u = u0
      out[4].v = v1
      return out
    end
    drawLineRectRaw = function(x, y, w, h, fill, radius, shadow, outerGlow, backdrop)
      local __lux_tmp_82 = radius ~= nil
      if not __lux_tmp_82 then
        __lux_tmp_82 = shadow ~= nil
      end
      local __lux_tmp_83 = __lux_tmp_82
      if not __lux_tmp_83 then
        __lux_tmp_83 = outerGlow ~= nil
      end
      local __lux_tmp_84 = __lux_tmp_83
      if not __lux_tmp_84 then
        __lux_tmp_84 = backdrop ~= nil
      end
      if __lux_tmp_84 then
        local __lux_tmp_85 = radius
        if __lux_tmp_85 == nil then
          __lux_tmp_85 = 0
        end
        return roundrect.drawRoundRectRaw(
          x,
          y,
          w,
          h,
          __lux_tmp_85,
          fill,
          nil,
          nil,
          shadow,
          outerGlow,
          nil,
          backdrop
        )
      end
      local points = linePolyPointsScratch
      points[1].x = x
      points[1].y = y
      points[2].x = x + w
      points[2].y = y
      points[3].x = x + w
      points[3].y = y + h
      points[4].x = x
      points[4].y = y + h
      return drawPolyRaw(points, nil, fill, nil, 0)
    end
    drawLineFallbackVerts = function(verts, fill, backdrop, shadow, outerGlow)
      local points = linePolyPointsScratch
      points[1].x = verts[1].x
      points[1].y = verts[1].y
      points[2].x = verts[2].x
      points[2].y = verts[2].y
      points[3].x = verts[3].x
      points[3].y = verts[3].y
      points[4].x = verts[4].x
      points[4].y = verts[4].y
      return drawPolyRaw(points, nil, fill, nil, 0, shadow, outerGlow, backdrop)
    end
    drawLineQuadRaw = function(x1, y1, x2, y2, strokeWidth, noCaps, verts, fill, shadow, outerGlow, backdrop)
      if backdrop ~= nil then
        local backdropVerts = lineQuadVertsInto(lineFallbackVertsScratch, x1, y1, x2, y2, strokeWidth, noCaps, 0)
        if backdropVerts ~= nil then
          drawLineFallbackVerts(backdropVerts, style.solid(makeColor(0, 0, 0, 0)), backdrop)
        end
      end
      local __lux_tmp_86 = shadow == nil
      if __lux_tmp_86 then
        __lux_tmp_86 = outerGlow == nil
      end
      local __lux_tmp_87 = __lux_tmp_86
      if __lux_tmp_87 then
        __lux_tmp_87 = drawLineShaderVerts(verts, fill)
      end
      if __lux_tmp_87 then
        return
      end
      local fallbackVerts = lineQuadVertsInto(lineFallbackVertsScratch, x1, y1, x2, y2, strokeWidth, noCaps, 0)
      local __lux_tmp_88 = fallbackVerts
      if __lux_tmp_88 == nil then
        __lux_tmp_88 = verts
      end
      return drawLineFallbackVerts(__lux_tmp_88, fill, nil, shadow, outerGlow)
    end
    drawLineRaw = function(x1, y1, x2, y2, fillInput, widthInput, radius, shadow, outerGlow, backdrop, noCaps)
      if noCaps == nil then
        noCaps = false
      end
      local strokeWidth = mathMax(0, style.strokeWidth(widthInput, 1))
      if strokeWidth <= 0 then
        return
      end
      local fill
      do
        local __lux_tmp_89 = fillInput
        if __lux_tmp_89 == nil then
          __lux_tmp_89 = defaultLineColor
        end
        fill = style.fillFromStyle(__lux_tmp_89)
      end
      local __lux_tmp_90 = not style.fillVisible(fill)
      if __lux_tmp_90 then
        __lux_tmp_90 = backdrop == nil
      end
      if __lux_tmp_90 then
        return
      end
      local __lux_cmp_91 = false
      if mathAbs(y2 - y1) ~= nil and 0.001 ~= nil then
        __lux_cmp_91 = mathAbs(y2 - y1) < 0.001
      end
      if __lux_cmp_91 then
        local x = mathMin(x1, x2)
        local w = mathAbs(x2 - x1)
        if w <= 0 then
          return
        end
        local y = y1 - strokeWidth * 0.5
        local __lux_tmp_92 = radius ~= nil
        if not __lux_tmp_92 then
          __lux_tmp_92 = shadow ~= nil
        end
        local __lux_tmp_93 = __lux_tmp_92
        if not __lux_tmp_93 then
          __lux_tmp_93 = outerGlow ~= nil
        end
        if __lux_tmp_93 then
          return drawLineRectRaw(x, y, w, strokeWidth, fill, radius, shadow, outerGlow, backdrop)
        end
      end
      local __lux_cmp_94 = false
      if mathAbs(x2 - x1) ~= nil and 0.001 ~= nil then
        __lux_cmp_94 = mathAbs(x2 - x1) < 0.001
      end
      if __lux_cmp_94 then
        local y = mathMin(y1, y2)
        local h = mathAbs(y2 - y1)
        if h <= 0 then
          return
        end
        local x = x1 - strokeWidth * 0.5
        local __lux_tmp_95 = radius ~= nil
        if not __lux_tmp_95 then
          __lux_tmp_95 = shadow ~= nil
        end
        local __lux_tmp_96 = __lux_tmp_95
        if not __lux_tmp_96 then
          __lux_tmp_96 = outerGlow ~= nil
        end
        if __lux_tmp_96 then
          return drawLineRectRaw(x, y, strokeWidth, h, fill, radius, shadow, outerGlow, backdrop)
        end
      end
      local verts = lineQuadVertsInto(lineVertsScratch, x1, y1, x2, y2, strokeWidth, noCaps)
      if verts == nil then
        return
      end
      return drawLineQuadRaw(
        x1,
        y1,
        x2,
        y2,
        strokeWidth,
        noCaps,
        verts,
        fill,
        shadow,
        outerGlow,
        backdrop
      )
    end
    drawLineImmediate = function(x1, y1, x2, y2, color, width, drawStyle)
      local resolved
      do
        local __lux_tmp_97 = drawStyle
        if __lux_tmp_97 == nil then
          __lux_tmp_97 = {}
        end
        resolved = __lux_tmp_97
      end
      local __lux_tmp_98 = resolved.fill
      if __lux_tmp_98 == nil then
        local __lux_tmp_99 = resolved.color
        if __lux_tmp_99 == nil then
          __lux_tmp_99 = color
        end
        __lux_tmp_98 = __lux_tmp_99
      end
      local __lux_tmp_100 = width
      if __lux_tmp_100 == nil then
        local __lux_tmp_101 = resolved.width
        if __lux_tmp_101 == nil then
          __lux_tmp_101 = resolved.strokeWidth
        end
        __lux_tmp_100 = __lux_tmp_101
      end
      local __lux_tmp_102 = resolved.noCaps == true
      if not __lux_tmp_102 then
        __lux_tmp_102 = resolved.caps == false
      end
      return drawLineRaw(
        x1,
        y1,
        x2,
        y2,
        __lux_tmp_98,
        __lux_tmp_100,
        resolved.radius,
        resolved.shadow,
        resolved.outerGlow,
        resolved.backdrop,
        __lux_tmp_102
      )
    end
    lineEx = function(x1, y1, x2, y2, drawStyle)
      local resolved
      do
        local __lux_tmp_103 = drawStyle
        if __lux_tmp_103 == nil then
          __lux_tmp_103 = {}
        end
        resolved = __lux_tmp_103
      end
      local transform, stripped = splitStyleTransform(resolved)
      if transform == nil then
        local __lux_tmp_104 = stripped.fill
        if __lux_tmp_104 == nil then
          __lux_tmp_104 = stripped.color
        end
        local __lux_tmp_105 = stripped.width
        if __lux_tmp_105 == nil then
          __lux_tmp_105 = stripped.strokeWidth
        end
        local __lux_tmp_106 = stripped.noCaps == true
        if not __lux_tmp_106 then
          __lux_tmp_106 = stripped.caps == false
        end
        return drawLineRaw(
          x1,
          y1,
          x2,
          y2,
          __lux_tmp_104,
          __lux_tmp_105,
          stripped.radius,
          stripped.shadow,
          stripped.outerGlow,
          stripped.backdrop,
          __lux_tmp_106
        )
      end
      local width
      do
        local __lux_tmp_107 = stripped.width
        if __lux_tmp_107 == nil then
          __lux_tmp_107 = stripped.strokeWidth
        end
        width = mathMax(1, style.strokeWidth(__lux_tmp_107, 1))
      end
      local pad = width * 0.5
      local bx = mathMin(x1, x2) - pad
      local by = mathMin(y1, y2) - pad
      local bw = mathAbs(x2 - x1) + pad * 2
      local bh = mathAbs(y2 - y1) + pad * 2
      return withTransform(
        transform,
        bx,
        by,
        bw,
        bh,
        function()
          local __lux_tmp_108 = stripped.fill
          if __lux_tmp_108 == nil then
            __lux_tmp_108 = stripped.color
          end
          local __lux_tmp_109 = stripped.width
          if __lux_tmp_109 == nil then
            __lux_tmp_109 = stripped.strokeWidth
          end
          local __lux_tmp_110 = stripped.noCaps == true
          if not __lux_tmp_110 then
            __lux_tmp_110 = stripped.caps == false
          end
          return drawLineRaw(
            x1,
            y1,
            x2,
            y2,
            __lux_tmp_108,
            __lux_tmp_109,
            stripped.radius,
            stripped.shadow,
            stripped.outerGlow,
            stripped.backdrop,
            __lux_tmp_110
          )
        end
      )
    end
    line = function(x1, y1, x2, y2, width, fill)
      if width == nil then
        width = 1
      end
      return drawLineRaw(x1, y1, x2, y2, fill, width, nil, nil, nil, nil, false)
    end
  end
  do
    polyBackdropTintScratch = makeColor(0, 0, 0, 0)
    polyMaterialKey = function(poly, suffix)
      if suffix == nil then
        suffix = ""
      end
      return "poly" .. poly.count .. suffix
    end
    drawMaterialPoly = function(poly, material)
      if material == nil then
        return false
      end
      surfaceSetMaterial(material)
      drawTransformedPoly(polyDrawVerts(poly))
      return true
    end
    polyDrawRect = function(poly, pad)
      if pad == nil then
        pad = 1
      end
      do
        local __lux_tmp_111 = toNumber(pad)
        if __lux_tmp_111 == nil then
          __lux_tmp_111 = 1
        end
        pad = mathMax(1, __lux_tmp_111)
      end
      local invW = 1 / poly.w
      local invH = 1 / poly.h
      local out = polyDrawRectScratch
      out.x = poly.x - pad
      out.y = poly.y - pad
      out.w = poly.w + pad * 2
      out.h = poly.h + pad * 2
      out.pad = pad
      out.u0 = -pad * invW
      out.v0 = -pad * invH
      out.u1 = 1 + pad * invW
      out.v1 = 1 + pad * invH
      return out
    end
    setupPrimitiveBlurConstants = function(material, w, h, vertical, intensity, radius)
      if radius == nil then
        radius = 0
      end
      local __lux_tmp_112 = vertical
      if __lux_tmp_112 then
        __lux_tmp_112 = 1
      end
      local __lux_tmp_113 = __lux_tmp_112
      if not __lux_tmp_113 then
        __lux_tmp_113 = 0
      end
      local __lux_tmp_114 = intensity
      if __lux_tmp_114 == nil then
        __lux_tmp_114 = 1
      end
      local __lux_tmp_115 = toNumber(radius)
      if __lux_tmp_115 == nil then
        __lux_tmp_115 = 0
      end
      return setupParamMatrix(
        material,
        __lux_tmp_113,
        __lux_tmp_114,
        0,
        0,
        w,
        h,
        0,
        mathMax(0, __lux_tmp_115),
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
    drawBlurredPoly = function(poly, material, amount)
      local __lux_tmp_116 = material == nil
      if not __lux_tmp_116 then
        __lux_tmp_116 = primitiveBlurRT == nil
      end
      local __lux_tmp_117 = __lux_tmp_116
      if not __lux_tmp_117 then
        __lux_tmp_117 = renderCopyRenderTargetToTexture == nil
      end
      if __lux_tmp_117 then
        return false
      end
      local intensity = backdropBlurIntensity(amount)
      surfaceSetDrawColor(255, 255, 255, 255)
      renderCopyRenderTargetToTexture(primitiveBlurRT)
      setupPrimitiveBlurConstants(material, poly.w, poly.h, false, intensity, 0)
      drawMaterialPoly(poly, material)
      renderCopyRenderTargetToTexture(primitiveBlurRT)
      setupPrimitiveBlurConstants(material, poly.w, poly.h, true, intensity, 0)
      drawMaterialPoly(poly, material)
      return true
    end
    polyBackdropTintColor = function(spec)
      local __lux_tmp_118 = spec == nil
      if not __lux_tmp_118 then
        __lux_tmp_118 = spec.tint == nil
      end
      if __lux_tmp_118 then
        return nil
      end
      local tint = spec.tint
      local alpha
      do
        local __lux_tmp_119 = tint.a
        if __lux_tmp_119 == nil then
          __lux_tmp_119 = 255
        end
        local __lux_tmp_120 = spec.opacity
        if __lux_tmp_120 == nil then
          __lux_tmp_120 = 1
        end
        alpha = __lux_tmp_119 * __lux_tmp_120
      end
      if alpha <= 0 then
        return nil
      end
      do
        local __lux_tmp_121 = tint.r
        if __lux_tmp_121 == nil then
          __lux_tmp_121 = 0
        end
        polyBackdropTintScratch.r = __lux_tmp_121
      end
      do
        local __lux_tmp_122 = tint.g
        if __lux_tmp_122 == nil then
          __lux_tmp_122 = 0
        end
        polyBackdropTintScratch.g = __lux_tmp_122
      end
      do
        local __lux_tmp_123 = tint.b
        if __lux_tmp_123 == nil then
          __lux_tmp_123 = 0
        end
        polyBackdropTintScratch.b = __lux_tmp_123
      end
      polyBackdropTintScratch.a = mathFloor(mathClamp(alpha, 0, 255) + 0.5)
      return polyBackdropTintScratch
    end
    drawPolyBackdrop = function(poly, backdrop)
      local spec = style.backdropStyle(backdrop)
      if spec == nil then
        return nil
      end
      local pad
      do
        local __lux_tmp_124 = toNumber(spec.padding)
        if __lux_tmp_124 == nil then
          __lux_tmp_124 = 0
        end
        pad = mathMax(0, __lux_tmp_124)
      end
      local backdropPoly
      if pad > 0 then
        backdropPoly = growConvexPoly(poly, pad)
      else
        backdropPoly = poly
      end
      if spec.blur > 0 then
        drawBlurredPoly(
          backdropPoly,
          primitiveMaterials[polyMaterialKey(backdropPoly, "_blur")],
          spec.blur
        )
      end
      local tint = polyBackdropTintColor(spec)
      if tint ~= nil then
        local material = primitiveMaterials[polyMaterialKey(backdropPoly)]
        if materialOK(material) then
          setupPrimitiveFillConstants(
            material,
            backdropPoly.w,
            backdropPoly.h,
            style.solid(tint),
            nil,
            0,
            0
          )
          drawMaterialPoly(backdropPoly, material)
        end
      end
      return spec
    end
    polyEffectBounds = function(poly, enabled, alpha, ox, oy, width, extent, grow, strength, falloff, biasOffset)
      if biasOffset == nil then
        biasOffset = false
      end
      local __lux_tmp_125 = not enabled
      if not __lux_tmp_125 then
        __lux_tmp_125 = alpha <= 0
      end
      local __lux_tmp_126 = __lux_tmp_125
      if not __lux_tmp_126 then
        __lux_tmp_126 = strength <= 0
      end
      if __lux_tmp_126 then
        return nil
      end
      do
        local __lux_tmp_127 = toNumber(width)
        if __lux_tmp_127 == nil then
          __lux_tmp_127 = 12
        end
        width = mathMax(0.001, __lux_tmp_127)
      end
      do
        local __lux_tmp_128 = toNumber(grow)
        if __lux_tmp_128 == nil then
          __lux_tmp_128 = 0
        end
        grow = mathMax(0, __lux_tmp_128)
      end
      do
        local __lux_tmp_129 = toNumber(extent)
        if __lux_tmp_129 == nil then
          __lux_tmp_129 = width
        end
        extent = mathMax(1, __lux_tmp_129)
      end
      local padding = grow + mathMax(extent, width)
      do
        local __lux_tmp_130 = toNumber(ox)
        if __lux_tmp_130 == nil then
          __lux_tmp_130 = 0
        end
        ox = __lux_tmp_130
      end
      do
        local __lux_tmp_131 = toNumber(oy)
        if __lux_tmp_131 == nil then
          __lux_tmp_131 = 0
        end
        oy = __lux_tmp_131
      end
      do
        local __lux_tmp_132 = toNumber(falloff)
        if __lux_tmp_132 == nil then
          __lux_tmp_132 = 1.7
        end
        falloff = mathMax(0.001, __lux_tmp_132)
      end
      do
        local __lux_tmp_133 = toNumber(strength)
        if __lux_tmp_133 == nil then
          __lux_tmp_133 = 1
        end
        strength = mathMax(0, __lux_tmp_133)
      end
      if biasOffset then
        local left, top, right, bottom = roundrect.glowBiasPads(padding, ox, oy, 0.001)
        return {
          x = poly.x - left,
          y = poly.y - top,
          w = poly.w + left + right,
          h = poly.h + top + bottom,
          ox = 0,
          oy = 0,
          width = width,
          grow = grow,
          falloff = falloff,
          strength = strength,
        }
      end
      return {
        x = poly.x + ox - padding,
        y = poly.y + oy - padding,
        w = poly.w + padding * 2,
        h = poly.h + padding * 2,
        ox = ox,
        oy = oy,
        width = width,
        grow = grow,
        falloff = falloff,
        strength = strength,
      }
    end
    includeBounds = function(x, y, w, h, bounds)
      if bounds == nil then
        return x, y, w, h
      end
      local minX = mathMin(x, bounds.x)
      local minY = mathMin(y, bounds.y)
      local maxX = mathMax(x + w, bounds.x + bounds.w)
      local maxY = mathMax(y + h, bounds.y + bounds.h)
      return minX, minY, maxX - minX, maxY - minY
    end
    shadowVertex = function(poly, point, bounds)
      if point == nil then
        return 0, 0
      end
      return poly.x + point.x + bounds.ox - bounds.x, poly.y + point.y + bounds.oy - bounds.y
    end
    setupPolyShadowAuxConstants = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3)
      local __lux_tmp_134 = material == nil
      if not __lux_tmp_134 then
        __lux_tmp_134 = paramMatrixSetUnpacked == nil
      end
      local __lux_tmp_135 = __lux_tmp_134
      if not __lux_tmp_135 then
        __lux_tmp_135 = matrixCtor == nil
      end
      if __lux_tmp_135 then
        return false
      end
      local matrix = auxParamMatrices[material]
      if matrix == nil then
        matrix = matrixCtor()
        auxParamMatrices[material] = matrix
      end
      do
        local __lux_tmp_136 = a0
        if __lux_tmp_136 == nil then
          __lux_tmp_136 = 0
        end
        local __lux_tmp_137 = b0
        if __lux_tmp_137 == nil then
          __lux_tmp_137 = 0
        end
        local __lux_tmp_138 = c0
        if __lux_tmp_138 == nil then
          __lux_tmp_138 = 0
        end
        local __lux_tmp_139 = d0
        if __lux_tmp_139 == nil then
          __lux_tmp_139 = 0
        end
        local __lux_tmp_140 = a1
        if __lux_tmp_140 == nil then
          __lux_tmp_140 = 0
        end
        local __lux_tmp_141 = b1
        if __lux_tmp_141 == nil then
          __lux_tmp_141 = 0
        end
        local __lux_tmp_142 = c1
        if __lux_tmp_142 == nil then
          __lux_tmp_142 = 0
        end
        local __lux_tmp_143 = d1
        if __lux_tmp_143 == nil then
          __lux_tmp_143 = 0
        end
        local __lux_tmp_144 = a2
        if __lux_tmp_144 == nil then
          __lux_tmp_144 = 0
        end
        local __lux_tmp_145 = b2
        if __lux_tmp_145 == nil then
          __lux_tmp_145 = 0
        end
        local __lux_tmp_146 = c2
        if __lux_tmp_146 == nil then
          __lux_tmp_146 = 0
        end
        local __lux_tmp_147 = d2
        if __lux_tmp_147 == nil then
          __lux_tmp_147 = 0
        end
        local __lux_tmp_148 = a3
        if __lux_tmp_148 == nil then
          __lux_tmp_148 = 0
        end
        local __lux_tmp_149 = b3
        if __lux_tmp_149 == nil then
          __lux_tmp_149 = 0
        end
        local __lux_tmp_150 = c3
        if __lux_tmp_150 == nil then
          __lux_tmp_150 = 0
        end
        local __lux_tmp_151 = d3
        if __lux_tmp_151 == nil then
          __lux_tmp_151 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_136,
          __lux_tmp_137,
          __lux_tmp_138,
          __lux_tmp_139,
          __lux_tmp_140,
          __lux_tmp_141,
          __lux_tmp_142,
          __lux_tmp_143,
          __lux_tmp_144,
          __lux_tmp_145,
          __lux_tmp_146,
          __lux_tmp_147,
          __lux_tmp_148,
          __lux_tmp_149,
          __lux_tmp_150,
          __lux_tmp_151
        )
      end
      material:SetMatrix("$invviewprojmat", matrix)
      return true
    end
    setupPolyEffectConstants = function(material, poly, bounds, r, g, b, a)
      local points = poly.points
      local x1, y1 = shadowVertex(poly, points[1], bounds)
      local x2, y2 = shadowVertex(poly, points[2], bounds)
      local x3, y3 = shadowVertex(poly, points[3], bounds)
      local x4, y4 = shadowVertex(poly, points[4], bounds)
      local x5, y5 = shadowVertex(poly, points[5], bounds)
      local x6, y6 = shadowVertex(poly, points[6], bounds)
      local x7, y7 = shadowVertex(poly, points[7], bounds)
      local x8, y8 = shadowVertex(poly, points[8], bounds)
      setupParamMatrix(
        material,
        x1,
        y1,
        x2,
        y2,
        x3,
        y3,
        x4,
        y4,
        x5,
        y5,
        x6,
        y6,
        x7,
        y7,
        x8,
        y8
      )
      return setupPolyShadowAuxConstants(
        material,
        r,
        g,
        b,
        a,
        bounds.w,
        bounds.h,
        bounds.width,
        bounds.falloff,
        bounds.strength,
        bounds.grow,
        0,
        0,
        0,
        0,
        0,
        0
      )
    end
    drawPolyShadow = function(poly, bounds, r, g, b, a)
      if bounds == nil then
        return false
      end
      local material = primitiveMaterials[polyMaterialKey(poly, "_shadow")]
      if not materialOK(material) then
        return false
      end
      setupPolyEffectConstants(material, poly, bounds, r, g, b, a)
      local bleedLeft, bleedTop, bleedRight, bleedBottom = effectBleedFromDrawRect(
        poly.x,
        poly.y,
        poly.w,
        poly.h,
        bounds.x,
        bounds.y,
        bounds.w,
        bounds.h
      )
      local bleedToken = beginPanelEffectBleed(bleedLeft, bleedTop, bleedRight, bleedBottom)
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(bounds.x, bounds.y, bounds.w, bounds.h, material)
      endPanelEffectBleed(bleedToken)
      return true
    end
    drawPolyOuterGlow = function(poly, bounds, r, g, b, a)
      if bounds == nil then
        return false
      end
      local material = primitiveMaterials[polyMaterialKey(poly, "_outerglow")]
      if not materialOK(material) then
        return false
      end
      setupPolyEffectConstants(material, poly, bounds, r, g, b, a)
      local bleedLeft, bleedTop, bleedRight, bleedBottom = effectBleedFromDrawRect(
        poly.x,
        poly.y,
        poly.w,
        poly.h,
        bounds.x,
        bounds.y,
        bounds.w,
        bounds.h
      )
      local bleedToken = beginPanelEffectBleed(bleedLeft, bleedTop, bleedRight, bleedBottom)
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(bounds.x, bounds.y, bounds.w, bounds.h, material)
      endPanelEffectBleed(bleedToken)
      return true
    end
    drawPolyPattern = function(poly, pattern)
      local spec = roundrect.patternStyle(pattern)
      local __lux_tmp_152 = spec == nil
      if not __lux_tmp_152 then
        __lux_tmp_152 = not shadersActive()
      end
      local __lux_tmp_153 = __lux_tmp_152
      if not __lux_tmp_153 then
        __lux_tmp_153 = not materialOK(primitiveMaterials.poly_pattern)
      end
      if __lux_tmp_153 then
        return false
      end
      local color
      do
        local __lux_tmp_154 = spec.color
        if __lux_tmp_154 == nil then
          __lux_tmp_154 = spec.tint
        end
        color = __lux_tmp_154
      end
      local __lux_tmp_155 = color ~= nil
      if __lux_tmp_155 then
        local __lux_tmp_156 = color.a
        if __lux_tmp_156 == nil then
          __lux_tmp_156 = 255
        end
        __lux_tmp_155 = __lux_tmp_156 <= 0
      end
      if __lux_tmp_155 then
        return false
      end
      local material = primitiveMaterials.poly_pattern
      local r, g, b, a
      do
        local __lux_tmp_157 = spec.color
        if __lux_tmp_157 == nil then
          __lux_tmp_157 = spec.tint
        end
        r, g, b, a = style.color01(style.asColor(__lux_tmp_157, makeColor(255, 255, 255, 24)))
      end
      local angle
      do
        local __lux_tmp_158 = toNumber(spec.angle)
        if __lux_tmp_158 == nil then
          __lux_tmp_158 = 135
        end
        angle = mathRad(__lux_tmp_158)
      end
      local smoke
      local __lux_match_159 = spec.kind
      if __lux_match_159 == "smoke" then
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
          local __lux_tmp_160 = toNumber(spec.scale)
          if __lux_tmp_160 == nil then
            __lux_tmp_160 = 140
          end
          pz = mathMax(1, __lux_tmp_160)
        end
        do
          local __lux_tmp_161 = toNumber(spec.density)
          if __lux_tmp_161 == nil then
            __lux_tmp_161 = 0.48
          end
          pw = mathClamp(__lux_tmp_161, 0, 1)
        end
        ox = roundrect.patternOffset(spec)
        oy = 1
        do
          local __lux_tmp_162 = toNumber(spec.softness)
          if __lux_tmp_162 == nil then
            __lux_tmp_162 = 0.3
          end
          oz = mathMax(0.001, __lux_tmp_162)
        end
        do
          local __lux_tmp_163 = toNumber(spec.warp)
          if __lux_tmp_163 == nil then
            __lux_tmp_163 = 0.85
          end
          ow = mathMax(0, __lux_tmp_163)
        end
      else
        do
          local __lux_tmp_164 = toNumber(spec.spacing)
          if __lux_tmp_164 == nil then
            __lux_tmp_164 = 12
          end
          pz = mathMax(1, __lux_tmp_164)
        end
        do
          local __lux_tmp_165 = toNumber(spec.width)
          if __lux_tmp_165 == nil then
            __lux_tmp_165 = 2
          end
          pw = mathMax(0.25, __lux_tmp_165)
        end
        ox = roundrect.patternOffset(spec)
      end
      do
        local __lux_tmp_166 = smoke
        if __lux_tmp_166 then
          local __lux_tmp_167 = toNumber(spec.seed)
          if __lux_tmp_167 == nil then
            __lux_tmp_167 = 0
          end
          __lux_tmp_166 = __lux_tmp_167
        end
        local __lux_tmp_168 = __lux_tmp_166
        if not __lux_tmp_168 then
          __lux_tmp_168 = 0
        end
        setupParamMatrix(
          material,
          r,
          g,
          b,
          a,
          poly.w,
          poly.h,
          __lux_tmp_168,
          0,
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
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTransformedPoly(polyDrawVerts(poly))
      return true
    end
    setupPolyStrokeConstants = function(material, poly, color, strokeWidth)
      local drawRect = polyDrawRect(poly, mathMax(2, style.strokeWidthValue(strokeWidth, 0) + 2))
      local points = poly.points
      local p1 = points[1]
      local p2 = points[2]
      local p3 = points[3]
      local p4
      do
        local __lux_tmp_169 = points[4]
        if __lux_tmp_169 == nil then
          __lux_tmp_169 = p3
        end
        p4 = __lux_tmp_169
      end
      local p5
      do
        local __lux_tmp_170 = points[5]
        if __lux_tmp_170 == nil then
          __lux_tmp_170 = p4
        end
        p5 = __lux_tmp_170
      end
      local p6
      do
        local __lux_tmp_171 = points[6]
        if __lux_tmp_171 == nil then
          __lux_tmp_171 = p5
        end
        p6 = __lux_tmp_171
      end
      local p7
      do
        local __lux_tmp_172 = points[7]
        if __lux_tmp_172 == nil then
          __lux_tmp_172 = p6
        end
        p7 = __lux_tmp_172
      end
      local p8
      do
        local __lux_tmp_173 = points[8]
        if __lux_tmp_173 == nil then
          __lux_tmp_173 = p7
        end
        p8 = __lux_tmp_173
      end
      local r, g, b, a = style.color01(color)
      setupParamMatrix(
        material,
        p1.x,
        p1.y,
        p2.x,
        p2.y,
        p3.x,
        p3.y,
        p4.x,
        p4.y,
        p5.x,
        p5.y,
        p6.x,
        p6.y,
        p7.x,
        p7.y,
        p8.x,
        p8.y
      )
      setupPolyShadowAuxConstants(
        material,
        r,
        g,
        b,
        a,
        poly.w,
        poly.h,
        mathMax(0, style.strokeWidthValue(strokeWidth, 0)),
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
      return drawRect
    end
    drawPolyStrokeShader = function(poly, color, strokeWidth)
      if not shadersActive() then
        return false
      end
      local material = primitiveMaterials[polyMaterialKey(poly, "_stroke")]
      if not materialOK(material) then
        return false
      end
      local drawRect = setupPolyStrokeConstants(material, poly, color, strokeWidth)
      surfaceSetDrawColor(255, 255, 255, 255)
      surfaceSetMaterial(material)
      drawTexturedQuadUV(
        drawRect.x,
        drawRect.y,
        drawRect.w,
        drawRect.h,
        drawRect.u0,
        drawRect.v0,
        drawRect.u1,
        drawRect.v1,
        material
      )
      return true
    end
    setupPolyFillConstants = function(material, poly, fill)
      local drawRect = polyDrawRect(poly, 2)
      local points = poly.points
      local p1 = points[1]
      local p2 = points[2]
      local p3 = points[3]
      local p4
      do
        local __lux_tmp_174 = points[4]
        if __lux_tmp_174 == nil then
          __lux_tmp_174 = p3
        end
        p4 = __lux_tmp_174
      end
      local p5
      do
        local __lux_tmp_175 = points[5]
        if __lux_tmp_175 == nil then
          __lux_tmp_175 = p4
        end
        p5 = __lux_tmp_175
      end
      local p6
      do
        local __lux_tmp_176 = points[6]
        if __lux_tmp_176 == nil then
          __lux_tmp_176 = p5
        end
        p6 = __lux_tmp_176
      end
      local p7
      do
        local __lux_tmp_177 = points[7]
        if __lux_tmp_177 == nil then
          __lux_tmp_177 = p6
        end
        p7 = __lux_tmp_177
      end
      local p8
      do
        local __lux_tmp_178 = points[8]
        if __lux_tmp_178 == nil then
          __lux_tmp_178 = p7
        end
        p8 = __lux_tmp_178
      end
      setupPrimitiveFillConstants(material, poly.w, poly.h, fill, nil, 0, 0)
      setupPolyShadowAuxConstants(
        material,
        p1.x,
        p1.y,
        p2.x,
        p2.y,
        p3.x,
        p3.y,
        p4.x,
        p4.y,
        p5.x,
        p5.y,
        p6.x,
        p6.y,
        p7.x,
        p7.y,
        p8.x,
        p8.y
      )
      return drawRect
    end
    drawPolyStroke = function(poly, color, strokeWidth)
      if drawPolyStrokeShader(poly, color, strokeWidth) then
        return
      end
      for index = 1, #poly.points do
        local a = poly.points[index]
        local b = poly.points[index % #poly.points + 1]
        drawLineRaw(
          poly.x + a.x,
          poly.y + a.y,
          poly.x + b.x,
          poly.y + b.y,
          color,
          style.strokeWidthValue(strokeWidth, 1),
          nil,
          nil,
          nil,
          nil,
          true
        )
      end
    end
    drawPolyFallbackRaw = function(points, fillInput, stroke, strokeWidthInput)
      local fill = style.fillFromStyle(fillInput)
      local hasFill = style.fillVisible(fill)
      local strokeWidth = style.strokeWidthValue(strokeWidthInput, 0)
      local hasStroke = style.strokeVisible(stroke, strokeWidth)
      if hasFill then
        style.setDrawColor(fillColor(fill))
        drawTransformedPoly(points)
      end
      if hasStroke then
        for index = 1, #points do
          local a = points[index]
          local b = points[index % #points + 1]
          do
            local __lux_tmp_179 = a.x
            if __lux_tmp_179 == nil then
              __lux_tmp_179 = a[1]
            end
            local __lux_tmp_180 = a.y
            if __lux_tmp_180 == nil then
              __lux_tmp_180 = a[2]
            end
            local __lux_tmp_181 = b.x
            if __lux_tmp_181 == nil then
              __lux_tmp_181 = b[1]
            end
            local __lux_tmp_182 = b.y
            if __lux_tmp_182 == nil then
              __lux_tmp_182 = b[2]
            end
            drawLineRaw(
              __lux_tmp_179,
              __lux_tmp_180,
              __lux_tmp_181,
              __lux_tmp_182,
              stroke,
              strokeWidth,
              nil,
              nil,
              nil,
              nil,
              true
            )
          end
        end
      end
    end
    drawPolyRawNormalized = function(points, poly, fillInput, stroke, strokeWidthInput, shadow, outerGlow, backdropInput, pattern)
      local hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpreadUnused, shadowGrow, shadowStrength, shadowFalloff, shadowExtent = roundrect.shadowRaw(shadow)
      local shadowBounds = polyEffectBounds(
        poly,
        hasShadow,
        sa,
        shadowX,
        shadowY,
        shadowWidth,
        shadowExtent,
        shadowGrow,
        shadowStrength,
        shadowFalloff
      )
      local hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpreadUnused, outerGrow, outerStrength, outerFalloff, outerExtent = roundrect.outerGlowRaw(outerGlow)
      local outerBounds = polyEffectBounds(
        poly,
        hasOuter,
        oa,
        outerX,
        outerY,
        outerWidth,
        outerExtent,
        outerGrow,
        outerStrength,
        outerFalloff,
        true
      )
      local backdrop = style.backdropStyle(backdropInput)
      local cullX = poly.x
      local cullY = poly.y
      local cullW = poly.w
      local cullH = poly.h
      cullX, cullY, cullW, cullH = includeBounds(cullX, cullY, cullW, cullH, shadowBounds)
      cullX, cullY, cullW, cullH = includeBounds(cullX, cullY, cullW, cullH, outerBounds)
      if backdrop ~= nil then
        local pad
        do
          local __lux_tmp_183 = toNumber(backdrop.padding)
          if __lux_tmp_183 == nil then
            __lux_tmp_183 = 0
          end
          pad = mathMax(0, __lux_tmp_183)
        end
        if pad > 0 then
          local bounds = polyDrawRectScratch
          bounds.x = poly.x - pad
          bounds.y = poly.y - pad
          bounds.w = poly.w + pad * 2
          bounds.h = poly.h + pad * 2
          cullX, cullY, cullW, cullH = includeBounds(cullX, cullY, cullW, cullH, bounds)
        end
      end
      local __lux_tmp_184 = not hasTransform()
      if __lux_tmp_184 then
        __lux_tmp_184 = isCulled(cullX, cullY, cullW, cullH)
      end
      if __lux_tmp_184 then
        return
      end
      if not shadersActive() then
        return drawPolyFallbackRaw(points, fillInput, stroke, strokeWidthInput)
      end
      drawPolyShadow(poly, shadowBounds, sr, sg, sb, sa)
      drawPolyOuterGlow(poly, outerBounds, orr, og, ob, oa)
      drawPolyBackdrop(poly, backdropInput)
      local material = primitiveMaterials[polyMaterialKey(poly)]
      local fill = style.fillFromStyle(fillInput)
      local hasFill = style.fillVisible(fill)
      local strokeWidth = style.strokeWidthValue(strokeWidthInput, 0)
      local hasStroke = style.strokeVisible(stroke, strokeWidth)
      local __lux_tmp_185 = hasFill
      if __lux_tmp_185 then
        __lux_tmp_185 = materialOK(material)
      end
      if __lux_tmp_185 then
        local drawRect = setupPolyFillConstants(material, poly, fill)
        surfaceSetMaterial(material)
        drawTexturedQuadUV(
          drawRect.x,
          drawRect.y,
          drawRect.w,
          drawRect.h,
          drawRect.u0,
          drawRect.v0,
          drawRect.u1,
          drawRect.v1,
          material
        )
      else
        if hasFill then
          drawPolyFallbackRaw(points, fill, nil, 0)
        end
      end
      drawPolyPattern(poly, pattern)
      if hasStroke then
        drawPolyStroke(poly, stroke, strokeWidth)
      end
    end
    drawPolyImmediateNormalized = function(points, drawStyle, poly)
      local resolved
      do
        local __lux_tmp_186 = drawStyle
        if __lux_tmp_186 == nil then
          __lux_tmp_186 = {}
        end
        resolved = __lux_tmp_186
      end
      local __lux_tmp_187 = resolved.fill
      if __lux_tmp_187 == nil then
        __lux_tmp_187 = resolved.color
      end
      return drawPolyRawNormalized(
        points,
        poly,
        __lux_tmp_187,
        resolved.stroke,
        resolved.strokeWidth,
        resolved.shadow,
        resolved.outerGlow,
        resolved.backdrop,
        resolved.pattern
      )
    end
    drawPolyRaw = function(points, poly, fill, stroke, strokeWidth, shadow, outerGlow, backdrop, pattern)
      if poly == nil then
        poly = normalizePoly(points)
        if poly == nil then
          return
        end
      end
      return drawPolyRawNormalized(
        points,
        poly,
        fill,
        stroke,
        strokeWidth,
        shadow,
        outerGlow,
        backdrop,
        pattern
      )
    end
    drawPolyImmediate = function(points, drawStyle)
      local poly = normalizePoly(points)
      if poly == nil then
        return
      end
      return drawPolyImmediateNormalized(points, drawStyle, poly)
    end
  end
  do
    transparentFill = { kind = style.FILL_SOLID, colorA = transparentColor, colorB = transparentColor }
    chamferFillParams = function(material, fill)
      local p0 = 0
      local p1 = 0
      local p2 = 1
      local p3 = 0
      local __lux_match_188 = fill
      local __lux_tag_189
      if __lux_match_188 ~= nil then
        __lux_tag_189 = __lux_match_188.kind
      end
      if __lux_tag_189 == style.FILL_LINEAR then
        local x1 = __lux_match_188.x1
        local y1 = __lux_match_188.y1
        local x2 = __lux_match_188.x2
        local y2 = __lux_match_188.y2
        do
          local __lux_tmp_190 = x1
          if __lux_tmp_190 == nil then
            __lux_tmp_190 = 0
          end
          p0 = __lux_tmp_190
        end
        do
          local __lux_tmp_191 = y1
          if __lux_tmp_191 == nil then
            __lux_tmp_191 = 0
          end
          p1 = __lux_tmp_191
        end
        do
          local __lux_tmp_192 = x2
          if __lux_tmp_192 == nil then
            __lux_tmp_192 = 1
          end
          p2 = __lux_tmp_192
        end
        do
          local __lux_tmp_193 = y2
          if __lux_tmp_193 == nil then
            __lux_tmp_193 = 1
          end
          p3 = __lux_tmp_193
        end
        style.bindGradientLut(material, fill)
      elseif __lux_tag_189 == style.FILL_RADIAL then
        local cx = __lux_match_188.cx
        local cy = __lux_match_188.cy
        local radius = __lux_match_188.radius
        do
          local __lux_tmp_194 = cx
          if __lux_tmp_194 == nil then
            __lux_tmp_194 = 0.5
          end
          p0 = __lux_tmp_194
        end
        do
          local __lux_tmp_195 = cy
          if __lux_tmp_195 == nil then
            __lux_tmp_195 = 0.5
          end
          p1 = __lux_tmp_195
        end
        do
          local __lux_tmp_196 = radius
          if __lux_tmp_196 == nil then
            __lux_tmp_196 = 0.5
          end
          p2 = __lux_tmp_196
        end
        p3 = 0
        style.bindGradientLut(material, fill)
      elseif __lux_tag_189 == style.FILL_CONIC then
        local cx = __lux_match_188.cx
        local cy = __lux_match_188.cy
        local rotation = __lux_match_188.rotation
        do
          local __lux_tmp_197 = cx
          if __lux_tmp_197 == nil then
            __lux_tmp_197 = 0.5
          end
          p0 = __lux_tmp_197
        end
        do
          local __lux_tmp_198 = cy
          if __lux_tmp_198 == nil then
            __lux_tmp_198 = 0.5
          end
          p1 = __lux_tmp_198
        end
        p2 = style.normalizedRotation(rotation)
        p3 = 0
        style.bindGradientLut(material, fill)
      else
        local __lux_unused_199 = nil
      end
      return p0, p1, p2, p3
    end
    setupPrimitiveAuxConstants = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3)
      if d0 == nil then
        d0 = 0
      end
      if d1 == nil then
        d1 = 0
      end
      if d2 == nil then
        d2 = 0
      end
      if d3 == nil then
        d3 = 0
      end
      local __lux_tmp_200 = material == nil
      if not __lux_tmp_200 then
        __lux_tmp_200 = paramMatrixSetUnpacked == nil
      end
      local __lux_tmp_201 = __lux_tmp_200
      if not __lux_tmp_201 then
        __lux_tmp_201 = matrixCtor == nil
      end
      if __lux_tmp_201 then
        return false
      end
      local matrix = auxParamMatrices[material]
      if matrix == nil then
        matrix = matrixCtor()
        auxParamMatrices[material] = matrix
      end
      do
        local __lux_tmp_202 = a0
        if __lux_tmp_202 == nil then
          __lux_tmp_202 = 0
        end
        local __lux_tmp_203 = b0
        if __lux_tmp_203 == nil then
          __lux_tmp_203 = 0
        end
        local __lux_tmp_204 = c0
        if __lux_tmp_204 == nil then
          __lux_tmp_204 = 0
        end
        local __lux_tmp_205 = d0
        if __lux_tmp_205 == nil then
          __lux_tmp_205 = 0
        end
        local __lux_tmp_206 = a1
        if __lux_tmp_206 == nil then
          __lux_tmp_206 = 0
        end
        local __lux_tmp_207 = b1
        if __lux_tmp_207 == nil then
          __lux_tmp_207 = 0
        end
        local __lux_tmp_208 = c1
        if __lux_tmp_208 == nil then
          __lux_tmp_208 = 0
        end
        local __lux_tmp_209 = d1
        if __lux_tmp_209 == nil then
          __lux_tmp_209 = 0
        end
        local __lux_tmp_210 = a2
        if __lux_tmp_210 == nil then
          __lux_tmp_210 = 0
        end
        local __lux_tmp_211 = b2
        if __lux_tmp_211 == nil then
          __lux_tmp_211 = 0
        end
        local __lux_tmp_212 = c2
        if __lux_tmp_212 == nil then
          __lux_tmp_212 = 0
        end
        local __lux_tmp_213 = d2
        if __lux_tmp_213 == nil then
          __lux_tmp_213 = 0
        end
        local __lux_tmp_214 = a3
        if __lux_tmp_214 == nil then
          __lux_tmp_214 = 0
        end
        local __lux_tmp_215 = b3
        if __lux_tmp_215 == nil then
          __lux_tmp_215 = 0
        end
        local __lux_tmp_216 = c3
        if __lux_tmp_216 == nil then
          __lux_tmp_216 = 0
        end
        local __lux_tmp_217 = d3
        if __lux_tmp_217 == nil then
          __lux_tmp_217 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_202,
          __lux_tmp_203,
          __lux_tmp_204,
          __lux_tmp_205,
          __lux_tmp_206,
          __lux_tmp_207,
          __lux_tmp_208,
          __lux_tmp_209,
          __lux_tmp_210,
          __lux_tmp_211,
          __lux_tmp_212,
          __lux_tmp_213,
          __lux_tmp_214,
          __lux_tmp_215,
          __lux_tmp_216,
          __lux_tmp_217
        )
      end
      material:SetMatrix("$invviewprojmat", matrix)
      return true
    end
    setupPrimitiveFillConstants = function(material, w, h, fill, stroke, strokeWidth, radius)
      if radius == nil then
        radius = 0
      end
      if material == nil then
        return false
      end
      do
        local __lux_tmp_218 = fill
        if __lux_tmp_218 == nil then
          __lux_tmp_218 = transparentFill
        end
        fill = __lux_tmp_218
      end
      local colorA
      do
        local __lux_tmp_219 = fill.colorA
        if __lux_tmp_219 == nil then
          __lux_tmp_219 = color_white
        end
        colorA = __lux_tmp_219
      end
      local colorB
      do
        local __lux_tmp_220 = fill.colorB
        if __lux_tmp_220 == nil then
          __lux_tmp_220 = colorA
        end
        colorB = __lux_tmp_220
      end
      local strokeColor
      do
        local __lux_tmp_221 = stroke
        if __lux_tmp_221 == nil then
          __lux_tmp_221 = transparentColor
        end
        strokeColor = __lux_tmp_221
      end
      local fillKind
      do
        local __lux_tmp_222 = fill.kind
        if __lux_tmp_222 == nil then
          __lux_tmp_222 = style.FILL_SOLID
        end
        fillKind = __lux_tmp_222
      end
      local packedStyle = mathClamp(style.strokeWidth(strokeWidth, 0), 0, 255) + mathClamp(fillKind, 0, 3) * 256
      local r, g, b, a = style.color01(colorB)
      local p0, p1, p2, p3 = chamferFillParams(material, fill)
      local sr, sg, sb, sa = style.color01(strokeColor)
      setupParamMatrix(
        material,
        r,
        g,
        b,
        a,
        w,
        h,
        packedStyle,
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
      style.setDrawColor(colorA)
      return true
    end
    drawChamferInnerGlowRaw = function(x, y, w, h, cuts, enabled, gr, gg, gb, ga, glowWidth, glowStrength, glowFalloff)
      local __lux_tmp_223 = not enabled
      if not __lux_tmp_223 then
        __lux_tmp_223 = ga <= 0
      end
      local __lux_tmp_224 = __lux_tmp_223
      if not __lux_tmp_224 then
        __lux_tmp_224 = glowStrength <= 0
      end
      local __lux_tmp_225 = __lux_tmp_224
      if not __lux_tmp_225 then
        __lux_tmp_225 = not shadersActive()
      end
      local __lux_tmp_226 = __lux_tmp_225
      if not __lux_tmp_226 then
        __lux_tmp_226 = not materialOK(primitiveMaterials.chamfer_innerglow)
      end
      if __lux_tmp_226 then
        return false
      end
      local tl, tr, br, bl = chamferTuple(cuts, w, h)
      local material = primitiveMaterials.chamfer_innerglow
      do
        local __lux_tmp_227 = toNumber(glowWidth)
        if __lux_tmp_227 == nil then
          __lux_tmp_227 = 8
        end
        local __lux_tmp_228 = toNumber(glowStrength)
        if __lux_tmp_228 == nil then
          __lux_tmp_228 = 1
        end
        local __lux_tmp_229 = toNumber(glowFalloff)
        if __lux_tmp_229 == nil then
          __lux_tmp_229 = 1.65
        end
        setupParamMatrix(
          material,
          gr,
          gg,
          gb,
          ga,
          w,
          h,
          0,
          0,
          tl,
          tr,
          br,
          bl,
          mathMax(0.001, __lux_tmp_227),
          mathMax(0, __lux_tmp_228),
          mathMax(0.001, __lux_tmp_229),
          0
        )
      end
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    cutsWithGrow = function(cuts, grow)
      do
        local __lux_tmp_230 = toNumber(grow)
        if __lux_tmp_230 == nil then
          __lux_tmp_230 = 0
        end
        grow = mathMax(0, __lux_tmp_230)
      end
      if grow <= 0 then
        return cuts
      end
      local __lux_tmp_231 = typeOf(cuts) == "table"
      if __lux_tmp_231 then
        __lux_tmp_231 = not style.isColor(cuts)
      end
      if __lux_tmp_231 then
        local __lux_tmp_232 = cuts.tl
        if __lux_tmp_232 == nil then
          __lux_tmp_232 = cuts[1]
        end
        local __lux_tmp_233 = toNumber(__lux_tmp_232)
        if __lux_tmp_233 == nil then
          __lux_tmp_233 = 0
        end
        local __lux_tmp_234 = cuts.tr
        if __lux_tmp_234 == nil then
          local __lux_tmp_235 = cuts[2]
          if __lux_tmp_235 == nil then
            local __lux_tmp_236 = cuts.tl
            if __lux_tmp_236 == nil then
              __lux_tmp_236 = cuts[1]
            end
            __lux_tmp_235 = __lux_tmp_236
          end
          __lux_tmp_234 = __lux_tmp_235
        end
        local __lux_tmp_237 = toNumber(__lux_tmp_234)
        if __lux_tmp_237 == nil then
          __lux_tmp_237 = 0
        end
        local __lux_tmp_238 = cuts.br
        if __lux_tmp_238 == nil then
          local __lux_tmp_239 = cuts[3]
          if __lux_tmp_239 == nil then
            local __lux_tmp_240 = cuts.tr
            if __lux_tmp_240 == nil then
              local __lux_tmp_241 = cuts[2]
              if __lux_tmp_241 == nil then
                local __lux_tmp_242 = cuts.tl
                if __lux_tmp_242 == nil then
                  __lux_tmp_242 = cuts[1]
                end
                __lux_tmp_241 = __lux_tmp_242
              end
              __lux_tmp_240 = __lux_tmp_241
            end
            __lux_tmp_239 = __lux_tmp_240
          end
          __lux_tmp_238 = __lux_tmp_239
        end
        local __lux_tmp_243 = toNumber(__lux_tmp_238)
        if __lux_tmp_243 == nil then
          __lux_tmp_243 = 0
        end
        local __lux_tmp_244 = cuts.bl
        if __lux_tmp_244 == nil then
          local __lux_tmp_245 = cuts[4]
          if __lux_tmp_245 == nil then
            local __lux_tmp_246 = cuts.br
            if __lux_tmp_246 == nil then
              local __lux_tmp_247 = cuts[3]
              if __lux_tmp_247 == nil then
                local __lux_tmp_248 = cuts.tr
                if __lux_tmp_248 == nil then
                  local __lux_tmp_249 = cuts[2]
                  if __lux_tmp_249 == nil then
                    local __lux_tmp_250 = cuts.tl
                    if __lux_tmp_250 == nil then
                      __lux_tmp_250 = cuts[1]
                    end
                    __lux_tmp_249 = __lux_tmp_250
                  end
                  __lux_tmp_248 = __lux_tmp_249
                end
                __lux_tmp_247 = __lux_tmp_248
              end
              __lux_tmp_246 = __lux_tmp_247
            end
            __lux_tmp_245 = __lux_tmp_246
          end
          __lux_tmp_244 = __lux_tmp_245
        end
        local __lux_tmp_251 = toNumber(__lux_tmp_244)
        if __lux_tmp_251 == nil then
          __lux_tmp_251 = 0
        end
        return {
          tl = mathMax(0, __lux_tmp_233) + grow,
          tr = mathMax(0, __lux_tmp_237) + grow,
          br = mathMax(0, __lux_tmp_243) + grow,
          bl = mathMax(0, __lux_tmp_251) + grow,
        }
      end
      local __lux_tmp_252 = toNumber(cuts)
      if __lux_tmp_252 == nil then
        __lux_tmp_252 = 0
      end
      return __lux_tmp_252 + grow
    end
    chamferEffectBounds = function(x, y, w, h, cuts, enabled, alpha, ox, oy, width, extent, grow, strength, falloff, biasOffset)
      if biasOffset == nil then
        biasOffset = false
      end
      local __lux_tmp_253 = not enabled
      if not __lux_tmp_253 then
        __lux_tmp_253 = alpha <= 0
      end
      local __lux_tmp_254 = __lux_tmp_253
      if not __lux_tmp_254 then
        __lux_tmp_254 = strength <= 0
      end
      if __lux_tmp_254 then
        return nil
      end
      do
        local __lux_tmp_255 = toNumber(grow)
        if __lux_tmp_255 == nil then
          __lux_tmp_255 = 0
        end
        grow = mathMax(0, __lux_tmp_255)
      end
      do
        local __lux_tmp_256 = toNumber(ox)
        if __lux_tmp_256 == nil then
          __lux_tmp_256 = 0
        end
        ox = __lux_tmp_256
      end
      do
        local __lux_tmp_257 = toNumber(oy)
        if __lux_tmp_257 == nil then
          __lux_tmp_257 = 0
        end
        oy = __lux_tmp_257
      end
      do
        local __lux_tmp_258 = toNumber(width)
        if __lux_tmp_258 == nil then
          __lux_tmp_258 = 18
        end
        width = mathMax(0.001, __lux_tmp_258)
      end
      do
        local __lux_tmp_259 = toNumber(extent)
        if __lux_tmp_259 == nil then
          __lux_tmp_259 = width
        end
        extent = mathMax(1, __lux_tmp_259)
      end
      do
        local __lux_tmp_260 = toNumber(strength)
        if __lux_tmp_260 == nil then
          __lux_tmp_260 = 1
        end
        strength = mathMax(0, __lux_tmp_260)
      end
      do
        local __lux_tmp_261 = toNumber(falloff)
        if __lux_tmp_261 == nil then
          __lux_tmp_261 = 1.9
        end
        falloff = mathMax(0.001, __lux_tmp_261)
      end
      local gx = x + ox - grow
      local gy = y + oy - grow
      local gw = w + grow * 2
      local gh = h + grow * 2
      local gcuts = cutsWithGrow(cuts, grow)
      local spread = extent
      local left = spread
      local top = spread
      local right = spread
      local bottom = spread
      if biasOffset then
        left, top, right, bottom = roundrect.glowBiasPads(spread, ox, oy)
        gx = x - grow
        gy = y - grow
      end
      local sx = gx - left
      local sy = gy - top
      local sw = gw + left + right
      local sh = gh + top + bottom
      local tl, tr, br, bl = chamferTuple(gcuts, gw, gh)
      return {
        x = sx,
        y = sy,
        w = sw,
        h = sh,
        shapeX = gx,
        shapeY = gy,
        shapeW = gw,
        shapeH = gh,
        tl = tl,
        tr = tr,
        br = br,
        bl = bl,
        width = width,
        strength = strength,
        falloff = falloff,
      }
    end
    drawChamferShadowOuterRaw = function(x, y, w, h, cuts, hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowExtent, shadowGrow, shadowStrength, shadowFalloff, hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerExtent, outerGrow, outerStrength, outerFalloff)
      local __lux_tmp_262 = not hasShadow
      if __lux_tmp_262 then
        __lux_tmp_262 = not hasOuter
      end
      local __lux_tmp_263 = __lux_tmp_262
      if not __lux_tmp_263 then
        __lux_tmp_263 = not shadersActive()
      end
      local __lux_tmp_264 = __lux_tmp_263
      if not __lux_tmp_264 then
        __lux_tmp_264 = not materialOK(primitiveMaterials.chamfer_shadow_outer)
      end
      if __lux_tmp_264 then
        return false
      end
      local shadowBounds = chamferEffectBounds(
        x,
        y,
        w,
        h,
        cuts,
        hasShadow,
        sa,
        shadowX,
        shadowY,
        shadowWidth,
        shadowExtent,
        shadowGrow,
        shadowStrength,
        shadowFalloff,
        false
      )
      local outerBounds = chamferEffectBounds(
        x,
        y,
        w,
        h,
        cuts,
        hasOuter,
        oa,
        outerX,
        outerY,
        outerWidth,
        outerExtent,
        outerGrow,
        outerStrength,
        outerFalloff,
        true
      )
      local __lux_tmp_265 = shadowBounds == nil
      if __lux_tmp_265 then
        __lux_tmp_265 = outerBounds == nil
      end
      if __lux_tmp_265 then
        return false
      end
      local baseBounds
      do
        local __lux_tmp_266 = shadowBounds
        if __lux_tmp_266 == nil then
          __lux_tmp_266 = outerBounds
        end
        baseBounds = __lux_tmp_266
      end
      local sx = baseBounds.x
      local sy = baseBounds.y
      local ex = baseBounds.x + baseBounds.w
      local ey = baseBounds.y + baseBounds.h
      if shadowBounds ~= nil then
        sx = mathMin(sx, shadowBounds.x)
        sy = mathMin(sy, shadowBounds.y)
        ex = mathMax(ex, shadowBounds.x + shadowBounds.w)
        ey = mathMax(ey, shadowBounds.y + shadowBounds.h)
      end
      if outerBounds ~= nil then
        sx = mathMin(sx, outerBounds.x)
        sy = mathMin(sy, outerBounds.y)
        ex = mathMax(ex, outerBounds.x + outerBounds.w)
        ey = mathMax(ey, outerBounds.y + outerBounds.h)
      end
      local sw = ex - sx
      local sh = ey - sy
      local material = primitiveMaterials.chamfer_shadow_outer
      do
        local __lux_tmp_267
        if shadowBounds ~= nil then
          __lux_tmp_267 = shadowBounds.width
        else
          __lux_tmp_267 = 1
        end
        local __lux_tmp_268
        if shadowBounds ~= nil then
          __lux_tmp_268 = shadowBounds.strength
        else
          __lux_tmp_268 = 0
        end
        local __lux_tmp_269
        if shadowBounds ~= nil then
          __lux_tmp_269 = sr
        else
          __lux_tmp_269 = 0
        end
        local __lux_tmp_270
        if shadowBounds ~= nil then
          __lux_tmp_270 = sg
        else
          __lux_tmp_270 = 0
        end
        local __lux_tmp_271
        if shadowBounds ~= nil then
          __lux_tmp_271 = sb
        else
          __lux_tmp_271 = 0
        end
        local __lux_tmp_272
        if shadowBounds ~= nil then
          __lux_tmp_272 = sa
        else
          __lux_tmp_272 = 0
        end
        local __lux_obj_273 = shadowBounds
        local __lux_val_274 = nil
        if __lux_obj_273 ~= nil then
          __lux_val_274 = __lux_obj_273.shapeX
        end
        local __lux_tmp_275 = __lux_val_274
        if __lux_tmp_275 == nil then
          __lux_tmp_275 = x
        end
        local __lux_obj_276 = shadowBounds
        local __lux_val_277 = nil
        if __lux_obj_276 ~= nil then
          __lux_val_277 = __lux_obj_276.shapeY
        end
        local __lux_tmp_278 = __lux_val_277
        if __lux_tmp_278 == nil then
          __lux_tmp_278 = y
        end
        local __lux_obj_279 = shadowBounds
        local __lux_val_280 = nil
        if __lux_obj_279 ~= nil then
          __lux_val_280 = __lux_obj_279.shapeW
        end
        local __lux_tmp_281 = __lux_val_280
        if __lux_tmp_281 == nil then
          __lux_tmp_281 = w
        end
        local __lux_obj_282 = shadowBounds
        local __lux_val_283 = nil
        if __lux_obj_282 ~= nil then
          __lux_val_283 = __lux_obj_282.shapeH
        end
        local __lux_tmp_284 = __lux_val_283
        if __lux_tmp_284 == nil then
          __lux_tmp_284 = h
        end
        local __lux_obj_285 = shadowBounds
        local __lux_val_286 = nil
        if __lux_obj_285 ~= nil then
          __lux_val_286 = __lux_obj_285.tl
        end
        local __lux_tmp_287 = __lux_val_286
        if __lux_tmp_287 == nil then
          __lux_tmp_287 = 0
        end
        local __lux_obj_288 = shadowBounds
        local __lux_val_289 = nil
        if __lux_obj_288 ~= nil then
          __lux_val_289 = __lux_obj_288.tr
        end
        local __lux_tmp_290 = __lux_val_289
        if __lux_tmp_290 == nil then
          __lux_tmp_290 = 0
        end
        local __lux_obj_291 = shadowBounds
        local __lux_val_292 = nil
        if __lux_obj_291 ~= nil then
          __lux_val_292 = __lux_obj_291.br
        end
        local __lux_tmp_293 = __lux_val_292
        if __lux_tmp_293 == nil then
          __lux_tmp_293 = 0
        end
        local __lux_obj_294 = shadowBounds
        local __lux_val_295 = nil
        if __lux_obj_294 ~= nil then
          __lux_val_295 = __lux_obj_294.bl
        end
        local __lux_tmp_296 = __lux_val_295
        if __lux_tmp_296 == nil then
          __lux_tmp_296 = 0
        end
        setupParamMatrix(
          material,
          sw,
          sh,
          __lux_tmp_267,
          __lux_tmp_268,
          __lux_tmp_269,
          __lux_tmp_270,
          __lux_tmp_271,
          __lux_tmp_272,
          __lux_tmp_275 - sx,
          __lux_tmp_278 - sy,
          __lux_tmp_281,
          __lux_tmp_284,
          __lux_tmp_287,
          __lux_tmp_290,
          __lux_tmp_293,
          __lux_tmp_296
        )
      end
      do
        local __lux_tmp_297
        if outerBounds ~= nil then
          __lux_tmp_297 = orr
        else
          __lux_tmp_297 = 0
        end
        local __lux_tmp_298
        if outerBounds ~= nil then
          __lux_tmp_298 = og
        else
          __lux_tmp_298 = 0
        end
        local __lux_tmp_299
        if outerBounds ~= nil then
          __lux_tmp_299 = ob
        else
          __lux_tmp_299 = 0
        end
        local __lux_tmp_300
        if outerBounds ~= nil then
          __lux_tmp_300 = oa
        else
          __lux_tmp_300 = 0
        end
        local __lux_obj_301 = outerBounds
        local __lux_val_302 = nil
        if __lux_obj_301 ~= nil then
          __lux_val_302 = __lux_obj_301.shapeX
        end
        local __lux_tmp_303 = __lux_val_302
        if __lux_tmp_303 == nil then
          __lux_tmp_303 = x
        end
        local __lux_obj_304 = outerBounds
        local __lux_val_305 = nil
        if __lux_obj_304 ~= nil then
          __lux_val_305 = __lux_obj_304.shapeY
        end
        local __lux_tmp_306 = __lux_val_305
        if __lux_tmp_306 == nil then
          __lux_tmp_306 = y
        end
        local __lux_obj_307 = outerBounds
        local __lux_val_308 = nil
        if __lux_obj_307 ~= nil then
          __lux_val_308 = __lux_obj_307.shapeW
        end
        local __lux_tmp_309 = __lux_val_308
        if __lux_tmp_309 == nil then
          __lux_tmp_309 = w
        end
        local __lux_obj_310 = outerBounds
        local __lux_val_311 = nil
        if __lux_obj_310 ~= nil then
          __lux_val_311 = __lux_obj_310.shapeH
        end
        local __lux_tmp_312 = __lux_val_311
        if __lux_tmp_312 == nil then
          __lux_tmp_312 = h
        end
        local __lux_obj_313 = outerBounds
        local __lux_val_314 = nil
        if __lux_obj_313 ~= nil then
          __lux_val_314 = __lux_obj_313.tl
        end
        local __lux_tmp_315 = __lux_val_314
        if __lux_tmp_315 == nil then
          __lux_tmp_315 = 0
        end
        local __lux_obj_316 = outerBounds
        local __lux_val_317 = nil
        if __lux_obj_316 ~= nil then
          __lux_val_317 = __lux_obj_316.tr
        end
        local __lux_tmp_318 = __lux_val_317
        if __lux_tmp_318 == nil then
          __lux_tmp_318 = 0
        end
        local __lux_obj_319 = outerBounds
        local __lux_val_320 = nil
        if __lux_obj_319 ~= nil then
          __lux_val_320 = __lux_obj_319.br
        end
        local __lux_tmp_321 = __lux_val_320
        if __lux_tmp_321 == nil then
          __lux_tmp_321 = 0
        end
        local __lux_obj_322 = outerBounds
        local __lux_val_323 = nil
        if __lux_obj_322 ~= nil then
          __lux_val_323 = __lux_obj_322.bl
        end
        local __lux_tmp_324 = __lux_val_323
        if __lux_tmp_324 == nil then
          __lux_tmp_324 = 0
        end
        local __lux_tmp_325
        if shadowBounds ~= nil then
          __lux_tmp_325 = shadowBounds.falloff
        else
          __lux_tmp_325 = 1
        end
        local __lux_tmp_326
        if outerBounds ~= nil then
          __lux_tmp_326 = outerBounds.width
        else
          __lux_tmp_326 = 1
        end
        local __lux_tmp_327
        if outerBounds ~= nil then
          __lux_tmp_327 = outerBounds.strength
        else
          __lux_tmp_327 = 0
        end
        local __lux_tmp_328
        if outerBounds ~= nil then
          __lux_tmp_328 = outerBounds.falloff
        else
          __lux_tmp_328 = 1
        end
        setupPrimitiveAuxConstants(
          material,
          __lux_tmp_297,
          __lux_tmp_298,
          __lux_tmp_299,
          __lux_tmp_300,
          __lux_tmp_303 - sx,
          __lux_tmp_306 - sy,
          __lux_tmp_309,
          __lux_tmp_312,
          __lux_tmp_315,
          __lux_tmp_318,
          __lux_tmp_321,
          __lux_tmp_324,
          __lux_tmp_325,
          __lux_tmp_326,
          __lux_tmp_327,
          __lux_tmp_328
        )
      end
      local bleedLeft, bleedTop, bleedRight, bleedBottom = effectBleedFromDrawRect(x, y, w, h, sx, sy, sw, sh)
      local bleedToken = beginPanelEffectBleed(bleedLeft, bleedTop, bleedRight, bleedBottom)
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(sx, sy, sw, sh, material)
      endPanelEffectBleed(bleedToken)
      return true
    end
    chamferBackdropTintColor = function(spec)
      local __lux_tmp_329 = spec == nil
      if not __lux_tmp_329 then
        __lux_tmp_329 = spec.tint == nil
      end
      if __lux_tmp_329 then
        return nil
      end
      local tint = spec.tint
      local alpha
      do
        local __lux_tmp_330 = tint.a
        if __lux_tmp_330 == nil then
          __lux_tmp_330 = 255
        end
        local __lux_tmp_331 = spec.opacity
        if __lux_tmp_331 == nil then
          __lux_tmp_331 = 1
        end
        alpha = __lux_tmp_330 * __lux_tmp_331
      end
      if alpha <= 0 then
        return nil
      end
      local __lux_tmp_332 = tint.r
      if __lux_tmp_332 == nil then
        __lux_tmp_332 = 0
      end
      local __lux_tmp_333 = tint.g
      if __lux_tmp_333 == nil then
        __lux_tmp_333 = 0
      end
      local __lux_tmp_334 = tint.b
      if __lux_tmp_334 == nil then
        __lux_tmp_334 = 0
      end
      return makeColor(
        __lux_tmp_332,
        __lux_tmp_333,
        __lux_tmp_334,
        mathFloor(mathClamp(alpha, 0, 255) + 0.5)
      )
    end
    drawChamferBackdrop = function(x, y, w, h, cuts, backdrop)
      local spec = style.backdropStyle(backdrop)
      local __lux_tmp_335 = spec == nil
      if not __lux_tmp_335 then
        __lux_tmp_335 = not shadersActive()
      end
      if __lux_tmp_335 then
        return nil
      end
      local pad
      do
        local __lux_tmp_336 = toNumber(spec.padding)
        if __lux_tmp_336 == nil then
          __lux_tmp_336 = 0
        end
        pad = mathMax(0, __lux_tmp_336)
      end
      local bx = x - pad
      local by = y - pad
      local bw = w + pad * 2
      local bh = h + pad * 2
      local bcuts = cutsWithGrow(cuts, pad)
      local tl, tr, br, bl = chamferTuple(bcuts, bw, bh)
      local __lux_tmp_337 = spec.blur > 0
      if __lux_tmp_337 then
        __lux_tmp_337 = primitiveBlurRT ~= nil
      end
      local __lux_tmp_338 = __lux_tmp_337
      if __lux_tmp_338 then
        __lux_tmp_338 = renderCopyRenderTargetToTexture ~= nil
      end
      local __lux_tmp_339 = __lux_tmp_338
      if __lux_tmp_339 then
        __lux_tmp_339 = materialOK(primitiveMaterials.chamfer_backdrop)
      end
      if __lux_tmp_339 then
        local material = primitiveMaterials.chamfer_backdrop
        local intensity = backdropBlurIntensity(spec.blur)
        surfaceSetMaterial(material)
        surfaceSetDrawColor(255, 255, 255, 255)
        renderCopyRenderTargetToTexture(primitiveBlurRT)
        setupParamMatrix(
          material,
          bw,
          bh,
          0,
          0,
          bw,
          bh,
          tl,
          tr,
          br,
          bl,
          0,
          0,
          0,
          intensity,
          0,
          0
        )
        drawTexturedQuad(bx, by, bw, bh, material)
        renderCopyRenderTargetToTexture(primitiveBlurRT)
        setupParamMatrix(
          material,
          bw,
          bh,
          0,
          0,
          bw,
          bh,
          tl,
          tr,
          br,
          bl,
          0,
          0,
          1,
          intensity,
          0,
          0
        )
        drawTexturedQuad(bx, by, bw, bh, material)
      end
      local tint = chamferBackdropTintColor(spec)
      if tint ~= nil then
        drawChamferBasePass(bx, by, bw, bh, bcuts, style.solid(tint), nil, 0, false)
      end
      return true
    end
    drawChamferPattern = function(x, y, w, h, cuts, pattern)
      local spec = roundrect.patternStyle(pattern)
      local __lux_tmp_340 = spec == nil
      if not __lux_tmp_340 then
        __lux_tmp_340 = not shadersActive()
      end
      local __lux_tmp_341 = __lux_tmp_340
      if not __lux_tmp_341 then
        __lux_tmp_341 = not materialOK(primitiveMaterials.chamfer_pattern)
      end
      if __lux_tmp_341 then
        return false
      end
      local color
      do
        local __lux_tmp_342 = spec.color
        if __lux_tmp_342 == nil then
          __lux_tmp_342 = spec.tint
        end
        color = __lux_tmp_342
      end
      local __lux_tmp_343 = color ~= nil
      if __lux_tmp_343 then
        local __lux_tmp_344 = color.a
        if __lux_tmp_344 == nil then
          __lux_tmp_344 = 255
        end
        __lux_tmp_343 = __lux_tmp_344 <= 0
      end
      if __lux_tmp_343 then
        return false
      end
      local tl, tr, br, bl = chamferTuple(cuts, w, h)
      local angle
      do
        local __lux_tmp_345 = toNumber(spec.angle)
        if __lux_tmp_345 == nil then
          __lux_tmp_345 = 135
        end
        angle = mathRad(__lux_tmp_345)
      end
      local smoke
      local __lux_match_346 = spec.kind
      if __lux_match_346 == "smoke" then
        smoke = true
      else
        smoke = false
      end
      local material = primitiveMaterials.chamfer_pattern
      local r, g, b, a
      do
        local __lux_tmp_347 = spec.color
        if __lux_tmp_347 == nil then
          __lux_tmp_347 = spec.tint
        end
        r, g, b, a = style.color01(style.asColor(__lux_tmp_347, makeColor(255, 255, 255, 24)))
      end
      local pz = 1
      local pw = 1
      if smoke then
        local density
        do
          local __lux_tmp_348 = toNumber(spec.density)
          if __lux_tmp_348 == nil then
            __lux_tmp_348 = 0.48
          end
          density = mathClamp(mathFloor(__lux_tmp_348 * 255 + 0.5), 0, 255)
        end
        local softness
        do
          local __lux_tmp_349 = toNumber(spec.softness)
          if __lux_tmp_349 == nil then
            __lux_tmp_349 = 0.3
          end
          softness = mathClamp(mathFloor(__lux_tmp_349 * 255 + 0.5), 0, 255)
        end
        local warp
        do
          local __lux_tmp_350 = toNumber(spec.warp)
          if __lux_tmp_350 == nil then
            __lux_tmp_350 = 0.85
          end
          warp = mathClamp(mathFloor(__lux_tmp_350 * 255 + 0.5), 0, 255)
        end
        do
          local __lux_tmp_351 = toNumber(spec.scale)
          if __lux_tmp_351 == nil then
            __lux_tmp_351 = 140
          end
          pz = mathMax(1, __lux_tmp_351)
        end
        pw = density + softness * 256 + warp * 65536
      else
        do
          local __lux_tmp_352 = toNumber(spec.spacing)
          if __lux_tmp_352 == nil then
            __lux_tmp_352 = 12
          end
          pz = mathMax(1, __lux_tmp_352)
        end
        do
          local __lux_tmp_353 = toNumber(spec.width)
          if __lux_tmp_353 == nil then
            __lux_tmp_353 = 2
          end
          pw = mathMax(0.25, __lux_tmp_353)
        end
      end
      do
        local __lux_tmp_354 = smoke
        if __lux_tmp_354 then
          __lux_tmp_354 = 1
        end
        local __lux_tmp_355 = __lux_tmp_354
        if not __lux_tmp_355 then
          __lux_tmp_355 = 0
        end
        local __lux_tmp_356 = smoke
        if __lux_tmp_356 then
          local __lux_tmp_357 = toNumber(spec.seed)
          if __lux_tmp_357 == nil then
            __lux_tmp_357 = 0
          end
          __lux_tmp_356 = __lux_tmp_357
        end
        local __lux_tmp_358 = __lux_tmp_356
        if not __lux_tmp_358 then
          __lux_tmp_358 = 0
        end
        setupParamMatrix(
          material,
          r,
          g,
          b,
          a,
          w,
          h,
          roundrect.patternOffset(spec),
          __lux_tmp_355 + __lux_tmp_358,
          mathCos(angle),
          mathSin(angle),
          pz,
          pw,
          tl,
          tr,
          br,
          bl
        )
      end
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    drawChamferStroke = function(x, y, w, h, cuts, stroke, strokeWidth)
      local __lux_tmp_359 = not style.strokeVisible(stroke, strokeWidth)
      if not __lux_tmp_359 then
        __lux_tmp_359 = not shadersActive()
      end
      local __lux_tmp_360 = __lux_tmp_359
      if not __lux_tmp_360 then
        __lux_tmp_360 = not materialOK(primitiveMaterials.chamfer_stroke)
      end
      if __lux_tmp_360 then
        return false
      end
      local tl, tr, br, bl = chamferTuple(cuts, w, h)
      local material = primitiveMaterials.chamfer_stroke
      local r, g, b, a = style.color01(stroke)
      setupParamMatrix(
        material,
        r,
        g,
        b,
        a,
        w,
        h,
        mathMax(0, style.strokeWidthValue(strokeWidth, 0)),
        0,
        tl,
        tr,
        br,
        bl,
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
    drawChamferBasePass = function(x, y, w, h, cuts, fill, stroke, strokeWidth, innerEnabled, gr, gg, gb, ga, glowWidth, glowStrength, glowFalloff)
      local __lux_tmp_361 = not shadersActive()
      if not __lux_tmp_361 then
        __lux_tmp_361 = not materialOK(primitiveMaterials.chamfer)
      end
      if __lux_tmp_361 then
        return false
      end
      local tl, tr, br, bl = chamferTuple(cuts, w, h)
      local material = primitiveMaterials.chamfer
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
          local __lux_tmp_362 = toNumber(glowWidth)
          if __lux_tmp_362 == nil then
            __lux_tmp_362 = 8
          end
          glowWidth = mathMax(0.001, __lux_tmp_362)
        end
        do
          local __lux_tmp_363 = toNumber(glowStrength)
          if __lux_tmp_363 == nil then
            __lux_tmp_363 = 1
          end
          glowStrength = mathMax(0, __lux_tmp_363)
        end
        do
          local __lux_tmp_364 = toNumber(glowFalloff)
          if __lux_tmp_364 == nil then
            __lux_tmp_364 = 1.65
          end
          glowFalloff = mathMax(0.001, __lux_tmp_364)
        end
      end
      setupPrimitiveAuxConstants(
        material,
        tl,
        tr,
        br,
        bl,
        gr,
        gg,
        gb,
        ga,
        glowWidth,
        glowStrength,
        glowFalloff,
        0
      )
      do
        local __lux_tmp_365 = fill
        if __lux_tmp_365 == nil then
          __lux_tmp_365 = transparentFill
        end
        setupPrimitiveFillConstants(material, w, h, __lux_tmp_365, stroke, strokeWidth, 0)
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    drawChamferBoxRaw = function(x, y, w, h, cuts, fillInput, stroke, strokeWidthInput, shadow, outerGlow, innerGlow, backdropInput, pattern)
      if cuts == nil then
        cuts = 0
      end
      local hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpreadUnused, shadowGrow, shadowStrength, shadowFalloff, shadowExtent = roundrect.shadowRaw(shadow)
      local hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpreadUnused, outerGrow, outerStrength, outerFalloff, outerExtent = roundrect.outerGlowRaw(outerGlow)
      local __lux_tmp_366 = hasShadow
      if not __lux_tmp_366 then
        __lux_tmp_366 = hasOuter
      end
      if __lux_tmp_366 then
        drawChamferShadowOuterRaw(
          x,
          y,
          w,
          h,
          cuts,
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
      end
      local backdrop = nil
      if backdropInput ~= nil then
        backdrop = drawChamferBackdrop(x, y, w, h, cuts, backdropInput)
      end
      local fill = style.fillFromStyle(fillInput)
      local strokeWidth = style.strokeWidthValue(strokeWidthInput, 0)
      local fillVisible = style.fillVisible(fill)
      local strokeVisible = style.strokeVisible(stroke, strokeWidth)
      local hasInner, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff = roundrect.innerGlowRaw(innerGlow)
      local baseDrawn = false
      local baseDrewStroke = false
      local baseDrewInner = false
      local __lux_tmp_367 = fillVisible
      if not __lux_tmp_367 then
        __lux_tmp_367 = strokeVisible
      end
      local __lux_tmp_368 = __lux_tmp_367
      if not __lux_tmp_368 then
        __lux_tmp_368 = hasInner
      end
      if __lux_tmp_368 then
        if pattern == nil then
          baseDrawn = drawChamferBasePass(
            x,
            y,
            w,
            h,
            cuts,
            fill,
            stroke,
            strokeWidth,
            hasInner,
            igr,
            igg,
            igb,
            iga,
            innerWidth,
            innerStrength,
            innerFalloff
          )
          do
            local __lux_tmp_369 = baseDrawn
            if __lux_tmp_369 then
              __lux_tmp_369 = strokeVisible
            end
            baseDrewStroke = __lux_tmp_369
          end
          do
            local __lux_tmp_370 = baseDrawn
            if __lux_tmp_370 then
              __lux_tmp_370 = hasInner
            end
            baseDrewInner = __lux_tmp_370
          end
        else
          if fillVisible then
            baseDrawn = drawChamferBasePass(x, y, w, h, cuts, fill, nil, 0, false)
          end
        end
      end
      local __lux_tmp_371 = not baseDrawn
      if __lux_tmp_371 then
        __lux_tmp_371 = fillVisible
      end
      if __lux_tmp_371 then
        drawPolyRaw(
          chamferPoints(x, y, w, h, cuts),
          nil,
          fillInput,
          nil,
          0,
          shadow,
          outerGlow,
          backdropInput
        )
      end
      if pattern ~= nil then
        drawChamferPattern(x, y, w, h, cuts, pattern)
      end
      local __lux_tmp_372 = strokeVisible
      if __lux_tmp_372 then
        __lux_tmp_372 = not baseDrewStroke
      end
      if __lux_tmp_372 then
        if not drawChamferStroke(x, y, w, h, cuts, stroke, strokeWidth) then
          drawPolyRaw(chamferPoints(x, y, w, h, cuts), nil, transparentColor, stroke, strokeWidth)
        end
      end
      local __lux_tmp_373 = hasInner
      if __lux_tmp_373 then
        __lux_tmp_373 = not baseDrewInner
      end
      if __lux_tmp_373 then
        drawChamferInnerGlowRaw(
          x,
          y,
          w,
          h,
          cuts,
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
    end
    drawChamferBoxImmediate = function(x, y, w, h, drawStyle, resolvedCuts)
      local resolved
      do
        local __lux_tmp_374 = drawStyle
        if __lux_tmp_374 == nil then
          __lux_tmp_374 = {}
        end
        resolved = __lux_tmp_374
      end
      local __lux_tmp_375 = resolvedCuts
      if __lux_tmp_375 == nil then
        local __lux_tmp_376 = resolved.cuts
        if __lux_tmp_376 == nil then
          __lux_tmp_376 = 0
        end
        __lux_tmp_375 = __lux_tmp_376
      end
      local __lux_tmp_377 = resolved.fill
      if __lux_tmp_377 == nil then
        __lux_tmp_377 = resolved.color
      end
      return drawChamferBoxRaw(
        x,
        y,
        w,
        h,
        __lux_tmp_375,
        __lux_tmp_377,
        resolved.stroke,
        resolved.strokeWidth,
        resolved.shadow,
        resolved.outerGlow,
        resolved.innerGlow,
        resolved.backdrop,
        resolved.pattern
      )
    end
  end
  do
    polyEx = function(points, drawStyle)
      local resolved
      do
        local __lux_tmp_378 = drawStyle
        if __lux_tmp_378 == nil then
          __lux_tmp_378 = {}
        end
        resolved = __lux_tmp_378
      end
      local transform, stripped = splitStyleTransform(resolved)
      local poly = normalizePoly(points)
      if poly == nil then
        return
      end
      if transform ~= nil then
        return withTransform(
          transform,
          poly.x,
          poly.y,
          poly.w,
          poly.h,
          function()
            return drawPolyImmediateNormalized(points, stripped, poly)
          end
        )
      end
      return drawPolyImmediateNormalized(points, stripped, poly)
    end
    poly = function(points, fill, stroke, strokeWidth)
      return drawPolyRaw(points, nil, fill, stroke, strokeWidth)
    end
    regularPolyScratch = {}
    diamondScratch = { {}, {}, {}, {} }
    caretScratch = { {}, {}, {} }
    clearPoints = function(points)
      for index = #points, 1, -1 do
        points[index] = nil
      end
      return points
    end
    setPoint = function(points, index, x, y)
      local point
      do
        local __lux_tmp_379 = points[index]
        if __lux_tmp_379 == nil then
          __lux_tmp_379 = {}
        end
        point = __lux_tmp_379
      end
      points[index] = point
      point.x = x
      point.y = y
      point.u = nil
      point.v = nil
      point.color = nil
    end
    regularPolyPoints = function(cx, cy, radius, sides, rotation)
      local points = clearPoints(regularPolyScratch)
      local count
      do
        local __lux_tmp_380 = toNumber(sides)
        if __lux_tmp_380 == nil then
          __lux_tmp_380 = 3
        end
        count = mathClamp(mathFloor(__lux_tmp_380), 3, 8)
      end
      local r
      do
        local __lux_tmp_381 = toNumber(radius)
        if __lux_tmp_381 == nil then
          __lux_tmp_381 = 0
        end
        r = mathMax(0, __lux_tmp_381)
      end
      local start
      do
        local __lux_tmp_382 = toNumber(rotation)
        if __lux_tmp_382 == nil then
          __lux_tmp_382 = -90
        end
        start = mathRad(__lux_tmp_382)
      end
      local step = mathRad(360 / count)
      for index = 1, count do
        local angle = start + (index - 1) * step
        setPoint(points, index, cx + mathCos(angle) * r, cy + mathSin(angle) * r)
      end
      return points
    end
    diamondPoints = function(x, y, w, h)
      setPoint(diamondScratch, 1, x + w * 0.5, y)
      setPoint(diamondScratch, 2, x + w, y + h * 0.5)
      setPoint(diamondScratch, 3, x + w * 0.5, y + h)
      setPoint(diamondScratch, 4, x, y + h * 0.5)
      return diamondScratch
    end
    caretPoints = function(x, y, w, h, direction)
      do
        local __lux_tmp_383 = direction
        if __lux_tmp_383 == nil then
          __lux_tmp_383 = "right"
        end
        local __lux_match_384 = __lux_tmp_383
        if __lux_match_384 == "up" then
          setPoint(caretScratch, 1, x + w * 0.5, y)
          setPoint(caretScratch, 2, x + w, y + h)
          setPoint(caretScratch, 3, x, y + h)
        elseif __lux_match_384 == "down" then
          setPoint(caretScratch, 1, x, y)
          setPoint(caretScratch, 2, x + w, y)
          setPoint(caretScratch, 3, x + w * 0.5, y + h)
        elseif __lux_match_384 == "left" then
          setPoint(caretScratch, 1, x + w, y)
          setPoint(caretScratch, 2, x + w, y + h)
          setPoint(caretScratch, 3, x, y + h * 0.5)
        else
          setPoint(caretScratch, 1, x, y)
          setPoint(caretScratch, 2, x + w, y + h * 0.5)
          setPoint(caretScratch, 3, x, y + h)
        end
      end
      return caretScratch
    end
    regularPolyEx = function(cx, cy, radius, sides, drawStyle)
      local resolved
      do
        local __lux_tmp_385 = drawStyle
        if __lux_tmp_385 == nil then
          __lux_tmp_385 = {}
        end
        resolved = __lux_tmp_385
      end
      local __lux_tmp_386 = resolved.rotation
      if __lux_tmp_386 == nil then
        __lux_tmp_386 = resolved.angle
      end
      return polyEx(regularPolyPoints(cx, cy, radius, sides, __lux_tmp_386), resolved)
    end
    regularPoly = function(cx, cy, radius, sides, rotation, fill, stroke, strokeWidth)
      return drawPolyRaw(
        regularPolyPoints(cx, cy, radius, sides, rotation),
        nil,
        fill,
        stroke,
        strokeWidth
      )
    end
    diamondEx = function(x, y, w, h, drawStyle)
      return polyEx(diamondPoints(x, y, w, h), drawStyle)
    end
    diamond = function(x, y, w, h, fill, stroke, strokeWidth)
      return drawPolyRaw(diamondPoints(x, y, w, h), nil, fill, stroke, strokeWidth)
    end
    caretEx = function(x, y, w, h, drawStyle)
      local resolved
      do
        local __lux_tmp_387 = drawStyle
        if __lux_tmp_387 == nil then
          __lux_tmp_387 = {}
        end
        resolved = __lux_tmp_387
      end
      local __lux_tmp_388 = resolved.direction
      if __lux_tmp_388 == nil then
        __lux_tmp_388 = resolved.dir
      end
      return polyEx(caretPoints(x, y, w, h, __lux_tmp_388), resolved)
    end
    caret = function(x, y, w, h, direction, fill, stroke, strokeWidth)
      return drawPolyRaw(caretPoints(x, y, w, h, direction), nil, fill, stroke, strokeWidth)
    end
    chamferBoxEx = function(x, y, w, h, drawStyle)
      local resolved
      do
        local __lux_tmp_389 = drawStyle
        if __lux_tmp_389 == nil then
          __lux_tmp_389 = {}
        end
        resolved = __lux_tmp_389
      end
      local transform, stripped = splitStyleTransform(resolved)
      local cuts
      do
        local __lux_tmp_390 = stripped.cuts
        if __lux_tmp_390 == nil then
          __lux_tmp_390 = 0
        end
        cuts = __lux_tmp_390
      end
      if transform ~= nil then
        return withTransform(
          transform,
          x,
          y,
          w,
          h,
          function()
            return chamferBoxEx(x, y, w, h, stripped)
          end
        )
      end
      return drawChamferBoxImmediate(x, y, w, h, stripped, cuts)
    end
    chamferBox = function(x, y, w, h, cuts, fill, stroke, strokeWidth)
      local __lux_tmp_391 = cuts
      if __lux_tmp_391 == nil then
        __lux_tmp_391 = 0
      end
      return drawChamferBoxRaw(x, y, w, h, __lux_tmp_391, fill, stroke, strokeWidth)
    end
  end
  do
    install = function(owner)
      configurePrimitives(owner)
      owner.ChamferBox = chamferBox
      owner.ChamferBoxEx = chamferBoxEx
      owner.RegularPoly = regularPoly
      owner.RegularPolyEx = regularPolyEx
      owner.Diamond = diamond
      owner.DiamondEx = diamondEx
      owner.Caret = caret
      owner.CaretEx = caretEx
      owner.Line = line
      owner.LineEx = lineEx
      owner.Poly = poly
      owner.PolyEx = polyEx
      owner._Primitives = {
        chamferTuple = chamferTuple,
        chamferPoints = chamferPoints,
        growConvexPoly = growConvexPoly,
        normalizePoly = normalizePoly,
        drawChamferBoxRaw = drawChamferBoxRaw,
        drawChamferBoxImmediate = drawChamferBoxImmediate,
        drawLineImmediate = drawLineImmediate,
      }
      return owner
    end
  end
  
  __lux_exports.chamferTuple = chamferTuple
  __lux_exports.chamferPoints = chamferPoints
  __lux_exports.normalizePoly = normalizePoly
  __lux_exports.growConvexPoly = growConvexPoly
  __lux_exports.drawLineRaw = drawLineRaw
  __lux_exports.drawLineImmediate = drawLineImmediate
  __lux_exports.lineEx = lineEx
  __lux_exports.line = line
  __lux_exports.drawPolyRaw = drawPolyRaw
  __lux_exports.drawChamferBoxRaw = drawChamferBoxRaw
  __lux_exports.drawChamferBoxImmediate = drawChamferBoxImmediate
  __lux_exports.polyEx = polyEx
  __lux_exports.poly = poly
  __lux_exports.regularPolyEx = regularPolyEx
  __lux_exports.regularPoly = regularPoly
  __lux_exports.diamondEx = diamondEx
  __lux_exports.diamond = diamond
  __lux_exports.caretEx = caretEx
  __lux_exports.caret = caret
  __lux_exports.chamferBoxEx = chamferBoxEx
  __lux_exports.chamferBox = chamferBox
  __lux_exports.install = install
  
  return __lux_exports
end
