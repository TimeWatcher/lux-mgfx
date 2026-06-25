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
  local lineRoundRectStyle
  local linePolyStyle
  local linePolyPointsScratch
  local polyLineStrokeStyle
  local polyFallbackLineStyle
  local polyDrawRectScratch
  local chamferStyle
  local lineStyle
  local polyStyle
  local regularPolyStyle
  local diamondStyle
  local caretStyle
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
  local drawLineRect
  local drawLineFallbackVerts
  local drawLineQuad
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
  local polyShadowBounds
  local includeBounds
  local shadowVertex
  local setupPolyShadowAuxConstants
  local setupPolyShadowConstants
  local drawPolyShadow
  local drawPolyOuterGlow
  local drawPolyPattern
  local setupPolyStrokeConstants
  local drawPolyStrokeShader
  local setupPolyFillConstants
  local drawPolyStroke
  local drawPolyFallback
  local drawPolyImmediateNormalized
  local drawPolyImmediate
  local chamferFillFallbackStyle
  local chamferStrokeFallbackStyle
  local transparentFill
  local chamferFillParams
  local setupPrimitiveAuxConstants
  local setupPrimitiveFillConstants
  local drawChamferInnerGlowSpec
  local cutsWithGrow
  local chamferEffectBounds
  local drawChamferShadowOuterSpec
  local chamferBackdropTintColor
  local drawChamferBackdrop
  local drawChamferPattern
  local drawChamferStroke
  local drawChamferBasePass
  local copyChamferStyleInto
  local drawChamferFallback
  local drawChamferStrokeFallback
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
    local frameImport = __lux_import("lux/mgfx/frame#client")
    local geometryImport = __lux_import("lux/mgfx/geometry#client")
    local roundrectImport = __lux_import("lux/mgfx/roundrect#client")
    local styleImport = __lux_import("lux/mgfx/style#client")
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
      local __lux_obj_render_1 = render
      local __lux_val_CopyRenderTargetToTexture_2 = nil
      if __lux_obj_render_1 ~= nil then
        __lux_val_CopyRenderTargetToTexture_2 = __lux_obj_render_1.CopyRenderTargetToTexture
      end
      renderCopyRenderTargetToTexture = __lux_val_CopyRenderTargetToTexture_2
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
    auxParamMatrices = {}
    primitiveMaterials = {}
    primitiveBlurRT = nil
    primitiveMatOK = function(material)
      return material ~= nil and material.IsError ~= nil and not material:IsError()
    end
    primitiveHasShaders = function()
      return false
    end
    forceFallbackCvar = nil
    lineVertsScratch = { {}, {}, {}, {} }
    lineFallbackVertsScratch = { {}, {}, {}, {} }
    lineRoundRectStyle = { radius = 0 }
    linePolyStyle = {}
    linePolyPointsScratch = { {}, {}, {}, {} }
    polyLineStrokeStyle = { noCaps = true }
    polyFallbackLineStyle = { noCaps = true }
    polyDrawRectScratch = {}
    chamferStyle = {}
    lineStyle = {}
    polyStyle = {}
    regularPolyStyle = {}
    diamondStyle = {}
    caretStyle = {}
    defaultLineColor = makeColor(255, 255, 255, 32)
    transparentColor = makeColor(0, 0, 0, 0)
    LINE_AA_FRINGE = 1
    LINE_NO_CAPS_UV_OFFSET = 8
    configurePrimitives = function(owner)
      if owner == nil then
        owner = {}
      end
      local materialState = owner._MaterialState
      if materialState == nil then
        materialState = {}
      end
      do
        local __lux_tmp_Materials_6 = owner._Materials
        if __lux_tmp_Materials_6 == nil then
          __lux_tmp_Materials_6 = materialState.materials
        end
        if __lux_tmp_Materials_6 == nil then
          __lux_tmp_Materials_6 = primitiveMaterials
        end
        if __lux_tmp_Materials_6 == nil then
          __lux_tmp_Materials_6 = {}
        end
        primitiveMaterials = __lux_tmp_Materials_6
      end
      do
        local __lux_tmp_BlurRT_7 = owner._BlurRT
        if __lux_tmp_BlurRT_7 == nil then
          __lux_tmp_BlurRT_7 = materialState.blurRT
        end
        if __lux_tmp_BlurRT_7 == nil then
          __lux_tmp_BlurRT_7 = primitiveBlurRT
        end
        primitiveBlurRT = __lux_tmp_BlurRT_7
      end
      do
        local __lux_tmp_MaterialOK_8 = owner.MaterialOK
        if __lux_tmp_MaterialOK_8 == nil then
          __lux_tmp_MaterialOK_8 = materialState.matOK
        end
        if __lux_tmp_MaterialOK_8 == nil then
          __lux_tmp_MaterialOK_8 = primitiveMatOK
        end
        primitiveMatOK = __lux_tmp_MaterialOK_8
      end
      do
        local __lux_tmp_hasShaders_9 = owner.hasShaders
        if __lux_tmp_hasShaders_9 == nil then
          __lux_tmp_hasShaders_9 = primitiveHasShaders
        end
        primitiveHasShaders = __lux_tmp_hasShaders_9
      end
      return true
    end
    materialOK = function(material)
      return primitiveMatOK ~= nil and primitiveMatOK(material)
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
      return primitiveHasShaders ~= nil and primitiveHasShaders()
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
        local __lux_tmp_a0_11 = a0
        if __lux_tmp_a0_11 == nil then
          __lux_tmp_a0_11 = 0
        end
        local __lux_tmp_b0_12 = b0
        if __lux_tmp_b0_12 == nil then
          __lux_tmp_b0_12 = 0
        end
        local __lux_tmp_c0_13 = c0
        if __lux_tmp_c0_13 == nil then
          __lux_tmp_c0_13 = 0
        end
        local __lux_tmp_d0_14 = d0
        if __lux_tmp_d0_14 == nil then
          __lux_tmp_d0_14 = 0
        end
        local __lux_tmp_a1_15 = a1
        if __lux_tmp_a1_15 == nil then
          __lux_tmp_a1_15 = 0
        end
        local __lux_tmp_b1_16 = b1
        if __lux_tmp_b1_16 == nil then
          __lux_tmp_b1_16 = 0
        end
        local __lux_tmp_c1_17 = c1
        if __lux_tmp_c1_17 == nil then
          __lux_tmp_c1_17 = 0
        end
        local __lux_tmp_d1_18 = d1
        if __lux_tmp_d1_18 == nil then
          __lux_tmp_d1_18 = 0
        end
        local __lux_tmp_a2_19 = a2
        if __lux_tmp_a2_19 == nil then
          __lux_tmp_a2_19 = 0
        end
        local __lux_tmp_b2_20 = b2
        if __lux_tmp_b2_20 == nil then
          __lux_tmp_b2_20 = 0
        end
        local __lux_tmp_c2_21 = c2
        if __lux_tmp_c2_21 == nil then
          __lux_tmp_c2_21 = 0
        end
        local __lux_tmp_d2_22 = d2
        if __lux_tmp_d2_22 == nil then
          __lux_tmp_d2_22 = 0
        end
        local __lux_tmp_a3_23 = a3
        if __lux_tmp_a3_23 == nil then
          __lux_tmp_a3_23 = 0
        end
        local __lux_tmp_b3_24 = b3
        if __lux_tmp_b3_24 == nil then
          __lux_tmp_b3_24 = 0
        end
        local __lux_tmp_c3_25 = c3
        if __lux_tmp_c3_25 == nil then
          __lux_tmp_c3_25 = 0
        end
        local __lux_tmp_d3_26 = d3
        if __lux_tmp_d3_26 == nil then
          __lux_tmp_d3_26 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_a0_11,
          __lux_tmp_b0_12,
          __lux_tmp_c0_13,
          __lux_tmp_d0_14,
          __lux_tmp_a1_15,
          __lux_tmp_b1_16,
          __lux_tmp_c1_17,
          __lux_tmp_d1_18,
          __lux_tmp_a2_19,
          __lux_tmp_b2_20,
          __lux_tmp_c2_21,
          __lux_tmp_d2_22,
          __lux_tmp_a3_23,
          __lux_tmp_b3_24,
          __lux_tmp_c3_25,
          __lux_tmp_d3_26
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
        local __lux_tmp_colorA_27 = fill.colorA
        if __lux_tmp_colorA_27 == nil then
          __lux_tmp_colorA_27 = fill.color
        end
        if __lux_tmp_colorA_27 == nil then
          __lux_tmp_colorA_27 = fallback
        end
        if __lux_tmp_colorA_27 == nil then
          __lux_tmp_colorA_27 = color_white
        end
        return __lux_tmp_colorA_27
      end
      local __lux_tmp_fallback_28 = fallback
      if __lux_tmp_fallback_28 == nil then
        __lux_tmp_fallback_28 = color_white
      end
      return __lux_tmp_fallback_28
    end
    pointXY = function(point)
      local __lux_tmp_x_29 = point.x
      if __lux_tmp_x_29 == nil then
        __lux_tmp_x_29 = point[1]
      end
      local __lux_tmp_x_30 = toNumber(__lux_tmp_x_29)
      if __lux_tmp_x_30 == nil then
        __lux_tmp_x_30 = 0
      end
      local __lux_tmp_y_31 = point.y
      if __lux_tmp_y_31 == nil then
        __lux_tmp_y_31 = point[2]
      end
      local __lux_tmp_y_32 = toNumber(__lux_tmp_y_31)
      if __lux_tmp_y_32 == nil then
        __lux_tmp_y_32 = 0
      end
      return __lux_tmp_x_30, __lux_tmp_y_32
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
          local __lux_tmp_tl_33 = cuts.tl
          if __lux_tmp_tl_33 == nil then
            __lux_tmp_tl_33 = cuts[1]
          end
          local __lux_tmp_tl_34 = toNumber(__lux_tmp_tl_33)
          if __lux_tmp_tl_34 == nil then
            __lux_tmp_tl_34 = 0
          end
          tl = __lux_tmp_tl_34
        end
        do
          local __lux_tmp_tr_35 = cuts.tr
          if __lux_tmp_tr_35 == nil then
            __lux_tmp_tr_35 = cuts[2]
          end
          local __lux_tmp_tr_36 = toNumber(__lux_tmp_tr_35)
          if __lux_tmp_tr_36 == nil then
            __lux_tmp_tr_36 = tl
          end
          tr = __lux_tmp_tr_36
        end
        do
          local __lux_tmp_br_37 = cuts.br
          if __lux_tmp_br_37 == nil then
            __lux_tmp_br_37 = cuts[3]
          end
          local __lux_tmp_br_38 = toNumber(__lux_tmp_br_37)
          if __lux_tmp_br_38 == nil then
            __lux_tmp_br_38 = tr
          end
          br = __lux_tmp_br_38
        end
        do
          local __lux_tmp_bl_39 = cuts.bl
          if __lux_tmp_bl_39 == nil then
            __lux_tmp_bl_39 = cuts[4]
          end
          local __lux_tmp_bl_40 = toNumber(__lux_tmp_bl_39)
          if __lux_tmp_bl_40 == nil then
            __lux_tmp_bl_40 = br
          end
          bl = __lux_tmp_bl_40
        end
      else
        do
          local __lux_tmp_cuts_41 = toNumber(cuts)
          if __lux_tmp_cuts_41 == nil then
            __lux_tmp_cuts_41 = 0
          end
          tl = __lux_tmp_cuts_41
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
            local __lux_cmp_42 = false
            if mathAbs(last.x - px) ~= nil then
              __lux_cmp_42 = mathAbs(last.x - px) < 0.001
            end
            sameX = __lux_cmp_42
          end
          local sameY
          do
            local __lux_cmp_43 = false
            if mathAbs(last.y - py) ~= nil then
              __lux_cmp_43 = mathAbs(last.y - py) < 0.001
            end
            sameY = __lux_cmp_43
          end
          if sameX and sameY then
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
        local __lux_cmp_46 = false
        if mathAbs(first.x - last.x) ~= nil then
          __lux_cmp_46 = mathAbs(first.x - last.x) < 0.001
        end
        local __lux_tmp_48 = __lux_cmp_46
        if __lux_tmp_48 then
          local __lux_cmp_47 = false
          if mathAbs(first.y - last.y) ~= nil then
            __lux_cmp_47 = mathAbs(first.y - last.y) < 0.001
          end
          __lux_tmp_48 = __lux_cmp_47
        end
        if __lux_tmp_48 then
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
        local __lux_cmp_49 = false
        if mathAbs(cross) ~= nil then
          __lux_cmp_49 = mathAbs(cross) > 0.000001
        end
        if __lux_cmp_49 then
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
        local __lux_tmp_points_50 = points
        if __lux_tmp_points_50 == nil then
          __lux_tmp_points_50 = {}
        end
        count = #__lux_tmp_points_50
      end
      if count < 3 or count > 8 then
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
      local __lux_cmp_51 = false
      if signedArea(ordered) ~= nil then
        __lux_cmp_51 = signedArea(ordered) < 0
      end
      if __lux_cmp_51 then
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
      if w <= 0 or h <= 0 then
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
      local __lux_cmp_52 = false
      if mathAbs(det) ~= nil then
        __lux_cmp_52 = mathAbs(det) > 0.0001
      end
      if __lux_cmp_52 then
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
        local __lux_tmp_amount_53 = toNumber(amount)
        if __lux_tmp_amount_53 == nil then
          __lux_tmp_amount_53 = 0
        end
        amount = mathMax(0, __lux_tmp_amount_53)
      end
      if poly == nil or amount <= 0 then
        return poly
      end
      local absolute = {}
      local count = poly.count
      if count == nil then
        count = #poly.points
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
      local __lux_tmp_grown_54 = normalizePoly(grown)
      if __lux_tmp_grown_54 == nil then
        __lux_tmp_grown_54 = poly
      end
      return __lux_tmp_grown_54
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
      local colorA = fill.colorA
      if colorA == nil then
        colorA = color_white
      end
      local colorB = fill.colorB
      if colorB == nil then
        colorB = colorA
      end
      local r, g, b, a = style.color01(colorA)
      local br, bg, bb, ba = style.color01(colorB)
      setupParamMatrix(material, r, g, b, a, br, bg, bb, ba, 0, 0, 1, 0, 0, 0, 0, 0)
      return style.bindGradientLut(material, fill)
    end
    drawLineShaderVerts = function(verts, fill)
      local material = primitiveMaterials.line
      if not shadersActive() or not materialOK(material) then
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
    drawLineRect = function(x, y, w, h, fill, resolved)
      if resolved.radius ~= nil or resolved.shadow ~= nil or resolved.outerGlow ~= nil or resolved.backdrop ~= nil then
        do
          local __lux_tmp_radius_55 = resolved.radius
          if __lux_tmp_radius_55 == nil then
            __lux_tmp_radius_55 = 0
          end
          lineRoundRectStyle.radius = __lux_tmp_radius_55
        end
        lineRoundRectStyle.backdrop = resolved.backdrop
        lineRoundRectStyle.fill = fill
        lineRoundRectStyle.shadow = resolved.shadow
        lineRoundRectStyle.outerGlow = resolved.outerGlow
        return roundrect.drawRoundRectImmediate(x, y, w, h, lineRoundRectStyle)
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
      linePolyStyle.backdrop = resolved.backdrop
      linePolyStyle.fill = fill
      linePolyStyle.shadow = nil
      linePolyStyle.outerGlow = nil
      return drawPolyImmediate(points, linePolyStyle)
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
      linePolyStyle.backdrop = backdrop
      linePolyStyle.fill = fill
      linePolyStyle.shadow = shadow
      linePolyStyle.outerGlow = outerGlow
      return drawPolyImmediate(points, linePolyStyle)
    end
    drawLineQuad = function(x1, y1, x2, y2, strokeWidth, noCaps, verts, fill, resolved)
      if resolved.backdrop ~= nil then
        local backdropVerts = lineQuadVertsInto(lineFallbackVertsScratch, x1, y1, x2, y2, strokeWidth, noCaps, 0)
        if backdropVerts ~= nil then
          drawLineFallbackVerts(
            backdropVerts,
            style.solid(makeColor(0, 0, 0, 0)),
            resolved.backdrop
          )
        end
      end
      if resolved.radius == nil and resolved.shadow == nil and resolved.outerGlow == nil and drawLineShaderVerts(verts, fill) then
        return
      end
      local fallbackVerts = lineQuadVertsInto(lineFallbackVertsScratch, x1, y1, x2, y2, strokeWidth, noCaps, 0)
      local __lux_tmp_fallbackVerts_56 = fallbackVerts
      if __lux_tmp_fallbackVerts_56 == nil then
        __lux_tmp_fallbackVerts_56 = verts
      end
      return drawLineFallbackVerts(
        __lux_tmp_fallbackVerts_56,
        fill,
        nil,
        resolved.shadow,
        resolved.outerGlow
      )
    end
    drawLineImmediate = function(x1, y1, x2, y2, color, width, drawStyle)
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local strokeWidth
      do
        local __lux_tmp_width_57 = width
        if __lux_tmp_width_57 == nil then
          __lux_tmp_width_57 = resolved.width
        end
        if __lux_tmp_width_57 == nil then
          __lux_tmp_width_57 = resolved.strokeWidth
        end
        strokeWidth = mathMax(0, style.strokeWidth(__lux_tmp_width_57, 1))
      end
      if strokeWidth <= 0 then
        return
      end
      local fill
      do
        local __lux_tmp_fill_58 = resolved.fill
        if __lux_tmp_fill_58 == nil then
          __lux_tmp_fill_58 = resolved.color
        end
        if __lux_tmp_fill_58 == nil then
          __lux_tmp_fill_58 = color
        end
        if __lux_tmp_fill_58 == nil then
          __lux_tmp_fill_58 = defaultLineColor
        end
        fill = style.fillFromStyle(__lux_tmp_fill_58)
      end
      if not style.fillVisible(fill) and resolved.backdrop == nil then
        return
      end
      local __lux_cmp_59 = false
      if mathAbs(y2 - y1) ~= nil then
        __lux_cmp_59 = mathAbs(y2 - y1) < 0.001
      end
      if __lux_cmp_59 then
        local x = mathMin(x1, x2)
        local w = mathAbs(x2 - x1)
        if w <= 0 then
          return
        end
        local y = y1 - strokeWidth * 0.5
        if resolved.radius ~= nil or resolved.shadow ~= nil or resolved.outerGlow ~= nil then
          return drawLineRect(x, y, w, strokeWidth, fill, resolved)
        end
      end
      local __lux_cmp_60 = false
      if mathAbs(x2 - x1) ~= nil then
        __lux_cmp_60 = mathAbs(x2 - x1) < 0.001
      end
      if __lux_cmp_60 then
        local y = mathMin(y1, y2)
        local h = mathAbs(y2 - y1)
        if h <= 0 then
          return
        end
        local x = x1 - strokeWidth * 0.5
        if resolved.radius ~= nil or resolved.shadow ~= nil or resolved.outerGlow ~= nil then
          return drawLineRect(x, y, strokeWidth, h, fill, resolved)
        end
      end
      local noCaps = resolved.noCaps == true or resolved.caps == false
      local verts = lineQuadVertsInto(lineVertsScratch, x1, y1, x2, y2, strokeWidth, noCaps)
      if verts == nil then
        return
      end
      return drawLineQuad(x1, y1, x2, y2, strokeWidth, noCaps, verts, fill, resolved)
    end
    lineEx = function(x1, y1, x2, y2, drawStyle)
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local transform, stripped = splitStyleTransform(resolved)
      if transform == nil then
        return drawLineImmediate(x1, y1, x2, y2, nil, nil, stripped)
      end
      local width
      do
        local __lux_tmp_width_61 = stripped.width
        if __lux_tmp_width_61 == nil then
          __lux_tmp_width_61 = stripped.strokeWidth
        end
        width = mathMax(1, style.strokeWidth(__lux_tmp_width_61, 1))
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
          return drawLineImmediate(x1, y1, x2, y2, nil, nil, stripped)
        end
      )
    end
    line = function(x1, y1, x2, y2, width, fill)
      if width == nil then
        width = 1
      end
      lineStyle.width = width
      lineStyle.fill = fill
      return drawLineImmediate(x1, y1, x2, y2, nil, nil, lineStyle)
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
        local __lux_tmp_pad_62 = toNumber(pad)
        if __lux_tmp_pad_62 == nil then
          __lux_tmp_pad_62 = 1
        end
        pad = mathMax(1, __lux_tmp_pad_62)
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
      local __lux_tmp_intensity_63 = intensity
      if __lux_tmp_intensity_63 == nil then
        __lux_tmp_intensity_63 = 1
      end
      local __lux_tmp_radius_64 = toNumber(radius)
      if __lux_tmp_radius_64 == nil then
        __lux_tmp_radius_64 = 0
      end
      return setupParamMatrix(
        material,
        vertical and 1 or 0,
        __lux_tmp_intensity_63,
        0,
        0,
        w,
        h,
        0,
        mathMax(0, __lux_tmp_radius_64),
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
      if material == nil or primitiveBlurRT == nil or renderCopyRenderTargetToTexture == nil then
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
      if spec == nil or spec.tint == nil then
        return nil
      end
      local tint = spec.tint
      local alpha
      do
        local __lux_tmp_a_65 = tint.a
        if __lux_tmp_a_65 == nil then
          __lux_tmp_a_65 = 255
        end
        local __lux_tmp_opacity_66 = spec.opacity
        if __lux_tmp_opacity_66 == nil then
          __lux_tmp_opacity_66 = 1
        end
        alpha = __lux_tmp_a_65 * __lux_tmp_opacity_66
      end
      if alpha <= 0 then
        return nil
      end
      do
        local __lux_tmp_r_67 = tint.r
        if __lux_tmp_r_67 == nil then
          __lux_tmp_r_67 = 0
        end
        polyBackdropTintScratch.r = __lux_tmp_r_67
      end
      do
        local __lux_tmp_g_68 = tint.g
        if __lux_tmp_g_68 == nil then
          __lux_tmp_g_68 = 0
        end
        polyBackdropTintScratch.g = __lux_tmp_g_68
      end
      do
        local __lux_tmp_b_69 = tint.b
        if __lux_tmp_b_69 == nil then
          __lux_tmp_b_69 = 0
        end
        polyBackdropTintScratch.b = __lux_tmp_b_69
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
        local __lux_tmp_padding_70 = toNumber(spec.padding)
        if __lux_tmp_padding_70 == nil then
          __lux_tmp_padding_70 = 0
        end
        pad = mathMax(0, __lux_tmp_padding_70)
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
    polyShadowBounds = function(poly, shadow, biasOffset)
      if biasOffset == nil then
        biasOffset = false
      end
      local __lux_tmp_73 = shadow == nil or shadow.color == nil
      if not __lux_tmp_73 then
        local __lux_tmp_a_72 = shadow.color.a
        if __lux_tmp_a_72 == nil then
          __lux_tmp_a_72 = 255
        end
        __lux_tmp_73 = __lux_tmp_a_72 <= 0
      end
      if __lux_tmp_73 then
        return nil
      end
      local width
      do
        local __lux_tmp_width_74 = toNumber(shadow.width)
        if __lux_tmp_width_74 == nil then
          __lux_tmp_width_74 = 12
        end
        width = mathMax(0.001, __lux_tmp_width_74)
      end
      local grow
      do
        local __lux_tmp_grow_75 = toNumber(shadow.grow)
        if __lux_tmp_grow_75 == nil then
          __lux_tmp_grow_75 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_75)
      end
      local spread = roundrect.effectExtentFromSpec(shadow, 12)
      local padding = grow + mathMax(spread, width)
      local ox = toNumber(shadow.x)
      if ox == nil then
        ox = 0
      end
      local oy = toNumber(shadow.y)
      if oy == nil then
        oy = 0
      end
      if biasOffset then
        local left, top, right, bottom = roundrect.glowBiasPads(padding, ox, oy, 0.001)
        local __lux_tmp_falloff_76 = toNumber(shadow.falloff)
        if __lux_tmp_falloff_76 == nil then
          __lux_tmp_falloff_76 = 1.7
        end
        local __lux_tmp_strength_77 = toNumber(shadow.strength)
        if __lux_tmp_strength_77 == nil then
          __lux_tmp_strength_77 = 1
        end
        return {
          x = poly.x - left,
          y = poly.y - top,
          w = poly.w + left + right,
          h = poly.h + top + bottom,
          ox = 0,
          oy = 0,
          width = width,
          grow = grow,
          falloff = mathMax(0.001, __lux_tmp_falloff_76),
          strength = mathMax(0, __lux_tmp_strength_77),
        }
      end
      local __lux_tmp_falloff_78 = toNumber(shadow.falloff)
      if __lux_tmp_falloff_78 == nil then
        __lux_tmp_falloff_78 = 1.7
      end
      local __lux_tmp_strength_79 = toNumber(shadow.strength)
      if __lux_tmp_strength_79 == nil then
        __lux_tmp_strength_79 = 1
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
        falloff = mathMax(0.001, __lux_tmp_falloff_78),
        strength = mathMax(0, __lux_tmp_strength_79),
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
      if material == nil or paramMatrixSetUnpacked == nil or matrixCtor == nil then
        return false
      end
      local matrix = auxParamMatrices[material]
      if matrix == nil then
        matrix = matrixCtor()
        auxParamMatrices[material] = matrix
      end
      do
        local __lux_tmp_a0_80 = a0
        if __lux_tmp_a0_80 == nil then
          __lux_tmp_a0_80 = 0
        end
        local __lux_tmp_b0_81 = b0
        if __lux_tmp_b0_81 == nil then
          __lux_tmp_b0_81 = 0
        end
        local __lux_tmp_c0_82 = c0
        if __lux_tmp_c0_82 == nil then
          __lux_tmp_c0_82 = 0
        end
        local __lux_tmp_d0_83 = d0
        if __lux_tmp_d0_83 == nil then
          __lux_tmp_d0_83 = 0
        end
        local __lux_tmp_a1_84 = a1
        if __lux_tmp_a1_84 == nil then
          __lux_tmp_a1_84 = 0
        end
        local __lux_tmp_b1_85 = b1
        if __lux_tmp_b1_85 == nil then
          __lux_tmp_b1_85 = 0
        end
        local __lux_tmp_c1_86 = c1
        if __lux_tmp_c1_86 == nil then
          __lux_tmp_c1_86 = 0
        end
        local __lux_tmp_d1_87 = d1
        if __lux_tmp_d1_87 == nil then
          __lux_tmp_d1_87 = 0
        end
        local __lux_tmp_a2_88 = a2
        if __lux_tmp_a2_88 == nil then
          __lux_tmp_a2_88 = 0
        end
        local __lux_tmp_b2_89 = b2
        if __lux_tmp_b2_89 == nil then
          __lux_tmp_b2_89 = 0
        end
        local __lux_tmp_c2_90 = c2
        if __lux_tmp_c2_90 == nil then
          __lux_tmp_c2_90 = 0
        end
        local __lux_tmp_d2_91 = d2
        if __lux_tmp_d2_91 == nil then
          __lux_tmp_d2_91 = 0
        end
        local __lux_tmp_a3_92 = a3
        if __lux_tmp_a3_92 == nil then
          __lux_tmp_a3_92 = 0
        end
        local __lux_tmp_b3_93 = b3
        if __lux_tmp_b3_93 == nil then
          __lux_tmp_b3_93 = 0
        end
        local __lux_tmp_c3_94 = c3
        if __lux_tmp_c3_94 == nil then
          __lux_tmp_c3_94 = 0
        end
        local __lux_tmp_d3_95 = d3
        if __lux_tmp_d3_95 == nil then
          __lux_tmp_d3_95 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_a0_80,
          __lux_tmp_b0_81,
          __lux_tmp_c0_82,
          __lux_tmp_d0_83,
          __lux_tmp_a1_84,
          __lux_tmp_b1_85,
          __lux_tmp_c1_86,
          __lux_tmp_d1_87,
          __lux_tmp_a2_88,
          __lux_tmp_b2_89,
          __lux_tmp_c2_90,
          __lux_tmp_d2_91,
          __lux_tmp_a3_92,
          __lux_tmp_b3_93,
          __lux_tmp_c3_94,
          __lux_tmp_d3_95
        )
      end
      material:SetMatrix("$invviewprojmat", matrix)
      return true
    end
    setupPolyShadowConstants = function(material, poly, shadow, bounds)
      local points = poly.points
      local x1, y1 = shadowVertex(poly, points[1], bounds)
      local x2, y2 = shadowVertex(poly, points[2], bounds)
      local x3, y3 = shadowVertex(poly, points[3], bounds)
      local x4, y4 = shadowVertex(poly, points[4], bounds)
      local x5, y5 = shadowVertex(poly, points[5], bounds)
      local x6, y6 = shadowVertex(poly, points[6], bounds)
      local x7, y7 = shadowVertex(poly, points[7], bounds)
      local x8, y8 = shadowVertex(poly, points[8], bounds)
      local r, g, b, a = style.color01(shadow.color)
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
    drawPolyShadow = function(poly, shadow, bounds)
      if bounds == nil then
        return false
      end
      local material = primitiveMaterials[polyMaterialKey(poly, "_shadow")]
      if not materialOK(material) then
        return false
      end
      setupPolyShadowConstants(material, poly, shadow, bounds)
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
    drawPolyOuterGlow = function(poly, glow, bounds)
      if bounds == nil then
        return false
      end
      local material = primitiveMaterials[polyMaterialKey(poly, "_outerglow")]
      if not materialOK(material) then
        return false
      end
      setupPolyShadowConstants(material, poly, glow, bounds)
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
      if spec == nil or not shadersActive() or not materialOK(primitiveMaterials.poly_pattern) then
        return false
      end
      local color = spec.color
      if color == nil then
        color = spec.tint
      end
      local __lux_tmp_98 = color ~= nil
      if __lux_tmp_98 then
        local __lux_tmp_a_97 = color.a
        if __lux_tmp_a_97 == nil then
          __lux_tmp_a_97 = 255
        end
        __lux_tmp_98 = __lux_tmp_a_97 <= 0
      end
      if __lux_tmp_98 then
        return false
      end
      local material = primitiveMaterials.poly_pattern
      local r, g, b, a
      do
        local __lux_tmp_color_99 = spec.color
        if __lux_tmp_color_99 == nil then
          __lux_tmp_color_99 = spec.tint
        end
        r, g, b, a = style.color01(style.asColor(__lux_tmp_color_99, makeColor(255, 255, 255, 24)))
      end
      local angle
      do
        local __lux_tmp_angle_100 = toNumber(spec.angle)
        if __lux_tmp_angle_100 == nil then
          __lux_tmp_angle_100 = 135
        end
        angle = mathRad(__lux_tmp_angle_100)
      end
      local smoke
      local __lux_match_101 = spec.kind
      if __lux_match_101 == "smoke" then
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
          local __lux_tmp_scale_102 = toNumber(spec.scale)
          if __lux_tmp_scale_102 == nil then
            __lux_tmp_scale_102 = 140
          end
          pz = mathMax(1, __lux_tmp_scale_102)
        end
        do
          local __lux_tmp_density_103 = toNumber(spec.density)
          if __lux_tmp_density_103 == nil then
            __lux_tmp_density_103 = 0.48
          end
          pw = mathClamp(__lux_tmp_density_103, 0, 1)
        end
        ox = roundrect.patternOffset(spec)
        oy = 1
        do
          local __lux_tmp_softness_104 = toNumber(spec.softness)
          if __lux_tmp_softness_104 == nil then
            __lux_tmp_softness_104 = 0.3
          end
          oz = mathMax(0.001, __lux_tmp_softness_104)
        end
        do
          local __lux_tmp_warp_105 = toNumber(spec.warp)
          if __lux_tmp_warp_105 == nil then
            __lux_tmp_warp_105 = 0.85
          end
          ow = mathMax(0, __lux_tmp_warp_105)
        end
      else
        do
          local __lux_tmp_spacing_106 = toNumber(spec.spacing)
          if __lux_tmp_spacing_106 == nil then
            __lux_tmp_spacing_106 = 12
          end
          pz = mathMax(1, __lux_tmp_spacing_106)
        end
        do
          local __lux_tmp_width_107 = toNumber(spec.width)
          if __lux_tmp_width_107 == nil then
            __lux_tmp_width_107 = 2
          end
          pw = mathMax(0.25, __lux_tmp_width_107)
        end
        ox = roundrect.patternOffset(spec)
      end
      do
        local __lux_tmp_109 = smoke
        if __lux_tmp_109 then
          local __lux_tmp_seed_108 = toNumber(spec.seed)
          if __lux_tmp_seed_108 == nil then
            __lux_tmp_seed_108 = 0
          end
          __lux_tmp_109 = __lux_tmp_seed_108
        end
        local __lux_tmp_110 = __lux_tmp_109
        if not __lux_tmp_110 then
          __lux_tmp_110 = 0
        end
        setupParamMatrix(
          material,
          r,
          g,
          b,
          a,
          poly.w,
          poly.h,
          __lux_tmp_110,
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
      local p4 = points[4]
      if p4 == nil then
        p4 = p3
      end
      local p5 = points[5]
      if p5 == nil then
        p5 = p4
      end
      local p6 = points[6]
      if p6 == nil then
        p6 = p5
      end
      local p7 = points[7]
      if p7 == nil then
        p7 = p6
      end
      local p8 = points[8]
      if p8 == nil then
        p8 = p7
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
      local p4 = points[4]
      if p4 == nil then
        p4 = p3
      end
      local p5 = points[5]
      if p5 == nil then
        p5 = p4
      end
      local p6 = points[6]
      if p6 == nil then
        p6 = p5
      end
      local p7 = points[7]
      if p7 == nil then
        p7 = p6
      end
      local p8 = points[8]
      if p8 == nil then
        p8 = p7
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
      local lineStyle = polyLineStrokeStyle
      lineStyle.width = style.strokeWidthValue(strokeWidth, 1)
      lineStyle.fill = color
      for index = 1, #poly.points do
        local a = poly.points[index]
        local b = poly.points[index % #poly.points + 1]
        drawLineImmediate(
          poly.x + a.x,
          poly.y + a.y,
          poly.x + b.x,
          poly.y + b.y,
          nil,
          nil,
          lineStyle
        )
      end
    end
    drawPolyFallback = function(points, drawStyle)
      local fill
      do
        local __lux_tmp_fill_111 = drawStyle.fill
        if __lux_tmp_fill_111 == nil then
          __lux_tmp_fill_111 = drawStyle.color
        end
        fill = style.fillFromStyle(__lux_tmp_fill_111)
      end
      local hasFill = style.fillVisible(fill)
      local strokeWidth = style.strokeWidthValue(drawStyle.strokeWidth, 0)
      local hasStroke = style.strokeVisible(drawStyle.stroke, strokeWidth)
      if hasFill then
        style.setDrawColor(fillColor(fill))
        drawTransformedPoly(points)
      end
      if hasStroke then
        local lineStyle = polyFallbackLineStyle
        lineStyle.width = strokeWidth
        lineStyle.fill = drawStyle.stroke
        for index = 1, #points do
          local a = points[index]
          local b = points[index % #points + 1]
          do
            local __lux_tmp_x_112 = a.x
            if __lux_tmp_x_112 == nil then
              __lux_tmp_x_112 = a[1]
            end
            local __lux_tmp_y_113 = a.y
            if __lux_tmp_y_113 == nil then
              __lux_tmp_y_113 = a[2]
            end
            local __lux_tmp_x_114 = b.x
            if __lux_tmp_x_114 == nil then
              __lux_tmp_x_114 = b[1]
            end
            local __lux_tmp_y_115 = b.y
            if __lux_tmp_y_115 == nil then
              __lux_tmp_y_115 = b[2]
            end
            drawLineImmediate(
              __lux_tmp_x_112,
              __lux_tmp_y_113,
              __lux_tmp_x_114,
              __lux_tmp_y_115,
              nil,
              nil,
              lineStyle
            )
          end
        end
      end
    end
    drawPolyImmediateNormalized = function(points, drawStyle, poly)
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local shadow = roundrect.shadowStyle(resolved.shadow)
      local shadowBounds = polyShadowBounds(poly, shadow)
      local outer = roundrect.outerGlowStyle(resolved.outerGlow)
      local outerBounds = polyShadowBounds(poly, outer, true)
      local backdrop = style.backdropStyle(resolved.backdrop)
      local cullX = poly.x
      local cullY = poly.y
      local cullW = poly.w
      local cullH = poly.h
      cullX, cullY, cullW, cullH = includeBounds(cullX, cullY, cullW, cullH, shadowBounds)
      cullX, cullY, cullW, cullH = includeBounds(cullX, cullY, cullW, cullH, outerBounds)
      if backdrop ~= nil then
        local pad
        do
          local __lux_tmp_padding_116 = toNumber(backdrop.padding)
          if __lux_tmp_padding_116 == nil then
            __lux_tmp_padding_116 = 0
          end
          pad = mathMax(0, __lux_tmp_padding_116)
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
      if not hasTransform() and isCulled(cullX, cullY, cullW, cullH) then
        return
      end
      if not shadersActive() then
        return drawPolyFallback(points, resolved)
      end
      drawPolyShadow(poly, shadow, shadowBounds)
      drawPolyOuterGlow(poly, outer, outerBounds)
      drawPolyBackdrop(poly, resolved.backdrop)
      local material = primitiveMaterials[polyMaterialKey(poly)]
      local fill
      do
        local __lux_tmp_fill_117 = resolved.fill
        if __lux_tmp_fill_117 == nil then
          __lux_tmp_fill_117 = resolved.color
        end
        fill = style.fillFromStyle(__lux_tmp_fill_117)
      end
      local hasFill = style.fillVisible(fill)
      local strokeWidth = style.strokeWidthValue(resolved.strokeWidth, 0)
      local hasStroke = style.strokeVisible(resolved.stroke, strokeWidth)
      if hasFill and materialOK(material) then
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
          drawPolyFallback(points, { fill = fill })
        end
      end
      drawPolyPattern(poly, resolved.pattern)
      if hasStroke then
        drawPolyStroke(poly, resolved.stroke, strokeWidth)
      end
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
    chamferFillFallbackStyle = {}
    chamferStrokeFallbackStyle = { fill = transparentColor }
    transparentFill = { kind = style.FILL_SOLID, colorA = transparentColor, colorB = transparentColor }
    chamferFillParams = function(material, fill)
      local p0 = 0
      local p1 = 0
      local p2 = 1
      local p3 = 0
      local __lux_match_118 = fill
      local __lux_tag_119
      if __lux_match_118 ~= nil then
        __lux_tag_119 = __lux_match_118.kind
      end
      if __lux_tag_119 == style.FILL_LINEAR then
        local x1 = __lux_match_118.x1
        local y1 = __lux_match_118.y1
        local x2 = __lux_match_118.x2
        local y2 = __lux_match_118.y2
        do
          local __lux_tmp_x1_120 = x1
          if __lux_tmp_x1_120 == nil then
            __lux_tmp_x1_120 = 0
          end
          p0 = __lux_tmp_x1_120
        end
        do
          local __lux_tmp_y1_121 = y1
          if __lux_tmp_y1_121 == nil then
            __lux_tmp_y1_121 = 0
          end
          p1 = __lux_tmp_y1_121
        end
        do
          local __lux_tmp_x2_122 = x2
          if __lux_tmp_x2_122 == nil then
            __lux_tmp_x2_122 = 1
          end
          p2 = __lux_tmp_x2_122
        end
        do
          local __lux_tmp_y2_123 = y2
          if __lux_tmp_y2_123 == nil then
            __lux_tmp_y2_123 = 1
          end
          p3 = __lux_tmp_y2_123
        end
        style.bindGradientLut(material, fill)
      elseif __lux_tag_119 == style.FILL_RADIAL then
        local cx = __lux_match_118.cx
        local cy = __lux_match_118.cy
        local radius = __lux_match_118.radius
        do
          local __lux_tmp_cx_124 = cx
          if __lux_tmp_cx_124 == nil then
            __lux_tmp_cx_124 = 0.5
          end
          p0 = __lux_tmp_cx_124
        end
        do
          local __lux_tmp_cy_125 = cy
          if __lux_tmp_cy_125 == nil then
            __lux_tmp_cy_125 = 0.5
          end
          p1 = __lux_tmp_cy_125
        end
        do
          local __lux_tmp_radius_126 = radius
          if __lux_tmp_radius_126 == nil then
            __lux_tmp_radius_126 = 0.5
          end
          p2 = __lux_tmp_radius_126
        end
        p3 = 0
        style.bindGradientLut(material, fill)
      elseif __lux_tag_119 == style.FILL_CONIC then
        local cx = __lux_match_118.cx
        local cy = __lux_match_118.cy
        local rotation = __lux_match_118.rotation
        do
          local __lux_tmp_cx_127 = cx
          if __lux_tmp_cx_127 == nil then
            __lux_tmp_cx_127 = 0.5
          end
          p0 = __lux_tmp_cx_127
        end
        do
          local __lux_tmp_cy_128 = cy
          if __lux_tmp_cy_128 == nil then
            __lux_tmp_cy_128 = 0.5
          end
          p1 = __lux_tmp_cy_128
        end
        p2 = style.normalizedRotation(rotation)
        p3 = 0
        style.bindGradientLut(material, fill)
      else
        local __lux_unused_129 = nil
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
      if material == nil or paramMatrixSetUnpacked == nil or matrixCtor == nil then
        return false
      end
      local matrix = auxParamMatrices[material]
      if matrix == nil then
        matrix = matrixCtor()
        auxParamMatrices[material] = matrix
      end
      do
        local __lux_tmp_a0_130 = a0
        if __lux_tmp_a0_130 == nil then
          __lux_tmp_a0_130 = 0
        end
        local __lux_tmp_b0_131 = b0
        if __lux_tmp_b0_131 == nil then
          __lux_tmp_b0_131 = 0
        end
        local __lux_tmp_c0_132 = c0
        if __lux_tmp_c0_132 == nil then
          __lux_tmp_c0_132 = 0
        end
        local __lux_tmp_d0_133 = d0
        if __lux_tmp_d0_133 == nil then
          __lux_tmp_d0_133 = 0
        end
        local __lux_tmp_a1_134 = a1
        if __lux_tmp_a1_134 == nil then
          __lux_tmp_a1_134 = 0
        end
        local __lux_tmp_b1_135 = b1
        if __lux_tmp_b1_135 == nil then
          __lux_tmp_b1_135 = 0
        end
        local __lux_tmp_c1_136 = c1
        if __lux_tmp_c1_136 == nil then
          __lux_tmp_c1_136 = 0
        end
        local __lux_tmp_d1_137 = d1
        if __lux_tmp_d1_137 == nil then
          __lux_tmp_d1_137 = 0
        end
        local __lux_tmp_a2_138 = a2
        if __lux_tmp_a2_138 == nil then
          __lux_tmp_a2_138 = 0
        end
        local __lux_tmp_b2_139 = b2
        if __lux_tmp_b2_139 == nil then
          __lux_tmp_b2_139 = 0
        end
        local __lux_tmp_c2_140 = c2
        if __lux_tmp_c2_140 == nil then
          __lux_tmp_c2_140 = 0
        end
        local __lux_tmp_d2_141 = d2
        if __lux_tmp_d2_141 == nil then
          __lux_tmp_d2_141 = 0
        end
        local __lux_tmp_a3_142 = a3
        if __lux_tmp_a3_142 == nil then
          __lux_tmp_a3_142 = 0
        end
        local __lux_tmp_b3_143 = b3
        if __lux_tmp_b3_143 == nil then
          __lux_tmp_b3_143 = 0
        end
        local __lux_tmp_c3_144 = c3
        if __lux_tmp_c3_144 == nil then
          __lux_tmp_c3_144 = 0
        end
        local __lux_tmp_d3_145 = d3
        if __lux_tmp_d3_145 == nil then
          __lux_tmp_d3_145 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_a0_130,
          __lux_tmp_b0_131,
          __lux_tmp_c0_132,
          __lux_tmp_d0_133,
          __lux_tmp_a1_134,
          __lux_tmp_b1_135,
          __lux_tmp_c1_136,
          __lux_tmp_d1_137,
          __lux_tmp_a2_138,
          __lux_tmp_b2_139,
          __lux_tmp_c2_140,
          __lux_tmp_d2_141,
          __lux_tmp_a3_142,
          __lux_tmp_b3_143,
          __lux_tmp_c3_144,
          __lux_tmp_d3_145
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
      if fill == nil then
        fill = transparentFill
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
    drawChamferInnerGlowSpec = function(x, y, w, h, cuts, spec)
      if spec == nil or not shadersActive() or not materialOK(primitiveMaterials.chamfer_innerglow) then
        return false
      end
      local color = spec.color
      local __lux_tmp_148 = color == nil
      if not __lux_tmp_148 then
        local __lux_tmp_a_147 = color.a
        if __lux_tmp_a_147 == nil then
          __lux_tmp_a_147 = 255
        end
        __lux_tmp_148 = __lux_tmp_a_147 <= 0
      end
      if __lux_tmp_148 then
        return false
      end
      local tl, tr, br, bl = chamferTuple(cuts, w, h)
      local material = primitiveMaterials.chamfer_innerglow
      local r, g, b, a = style.color01(color)
      do
        local __lux_tmp_width_149 = toNumber(spec.width)
        if __lux_tmp_width_149 == nil then
          __lux_tmp_width_149 = 8
        end
        local __lux_tmp_strength_150 = toNumber(spec.strength)
        if __lux_tmp_strength_150 == nil then
          __lux_tmp_strength_150 = 1
        end
        local __lux_tmp_falloff_151 = toNumber(spec.falloff)
        if __lux_tmp_falloff_151 == nil then
          __lux_tmp_falloff_151 = 1.65
        end
        setupParamMatrix(
          material,
          r,
          g,
          b,
          a,
          w,
          h,
          0,
          0,
          tl,
          tr,
          br,
          bl,
          mathMax(0.001, __lux_tmp_width_149),
          mathMax(0, __lux_tmp_strength_150),
          mathMax(0.001, __lux_tmp_falloff_151),
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
        local __lux_tmp_grow_152 = toNumber(grow)
        if __lux_tmp_grow_152 == nil then
          __lux_tmp_grow_152 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_152)
      end
      if grow <= 0 then
        return cuts
      end
      if typeOf(cuts) == "table" and not style.isColor(cuts) then
        local __lux_tmp_tl_153 = cuts.tl
        if __lux_tmp_tl_153 == nil then
          __lux_tmp_tl_153 = cuts[1]
        end
        local __lux_tmp_tl_154 = toNumber(__lux_tmp_tl_153)
        if __lux_tmp_tl_154 == nil then
          __lux_tmp_tl_154 = 0
        end
        local __lux_tmp_tr_155 = cuts.tr
        if __lux_tmp_tr_155 == nil then
          __lux_tmp_tr_155 = cuts[2]
        end
        if __lux_tmp_tr_155 == nil then
          __lux_tmp_tr_155 = cuts.tl
        end
        if __lux_tmp_tr_155 == nil then
          __lux_tmp_tr_155 = cuts[1]
        end
        local __lux_tmp_tr_156 = toNumber(__lux_tmp_tr_155)
        if __lux_tmp_tr_156 == nil then
          __lux_tmp_tr_156 = 0
        end
        local __lux_tmp_br_157 = cuts.br
        if __lux_tmp_br_157 == nil then
          __lux_tmp_br_157 = cuts[3]
        end
        if __lux_tmp_br_157 == nil then
          __lux_tmp_br_157 = cuts.tr
        end
        if __lux_tmp_br_157 == nil then
          __lux_tmp_br_157 = cuts[2]
        end
        if __lux_tmp_br_157 == nil then
          __lux_tmp_br_157 = cuts.tl
        end
        if __lux_tmp_br_157 == nil then
          __lux_tmp_br_157 = cuts[1]
        end
        local __lux_tmp_br_158 = toNumber(__lux_tmp_br_157)
        if __lux_tmp_br_158 == nil then
          __lux_tmp_br_158 = 0
        end
        local __lux_tmp_bl_159 = cuts.bl
        if __lux_tmp_bl_159 == nil then
          __lux_tmp_bl_159 = cuts[4]
        end
        if __lux_tmp_bl_159 == nil then
          __lux_tmp_bl_159 = cuts.br
        end
        if __lux_tmp_bl_159 == nil then
          __lux_tmp_bl_159 = cuts[3]
        end
        if __lux_tmp_bl_159 == nil then
          __lux_tmp_bl_159 = cuts.tr
        end
        if __lux_tmp_bl_159 == nil then
          __lux_tmp_bl_159 = cuts[2]
        end
        if __lux_tmp_bl_159 == nil then
          __lux_tmp_bl_159 = cuts.tl
        end
        if __lux_tmp_bl_159 == nil then
          __lux_tmp_bl_159 = cuts[1]
        end
        local __lux_tmp_bl_160 = toNumber(__lux_tmp_bl_159)
        if __lux_tmp_bl_160 == nil then
          __lux_tmp_bl_160 = 0
        end
        return {
          tl = mathMax(0, __lux_tmp_tl_154) + grow,
          tr = mathMax(0, __lux_tmp_tr_156) + grow,
          br = mathMax(0, __lux_tmp_br_158) + grow,
          bl = mathMax(0, __lux_tmp_bl_160) + grow,
        }
      end
      local __lux_tmp_cuts_161 = toNumber(cuts)
      if __lux_tmp_cuts_161 == nil then
        __lux_tmp_cuts_161 = 0
      end
      return __lux_tmp_cuts_161 + grow
    end
    chamferEffectBounds = function(x, y, w, h, cuts, spec, biasOffset)
      if biasOffset == nil then
        biasOffset = false
      end
      local __lux_tmp_164 = spec == nil or spec.color == nil
      if not __lux_tmp_164 then
        local __lux_tmp_a_163 = spec.color.a
        if __lux_tmp_a_163 == nil then
          __lux_tmp_a_163 = 255
        end
        __lux_tmp_164 = __lux_tmp_a_163 <= 0
      end
      if __lux_tmp_164 then
        return nil
      end
      local grow
      do
        local __lux_tmp_grow_165 = spec.grow
        if __lux_tmp_grow_165 == nil then
          __lux_tmp_grow_165 = spec.shapeSpread
        end
        if __lux_tmp_grow_165 == nil then
          __lux_tmp_grow_165 = spec.expand
        end
        local __lux_tmp_grow_166 = toNumber(__lux_tmp_grow_165)
        if __lux_tmp_grow_166 == nil then
          __lux_tmp_grow_166 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_166)
      end
      local ox
      do
        local __lux_tmp_x_167 = spec.x
        if __lux_tmp_x_167 == nil then
          __lux_tmp_x_167 = spec.offsetX
        end
        if __lux_tmp_x_167 == nil then
          __lux_tmp_x_167 = spec.dx
        end
        ox = toNumber(__lux_tmp_x_167)
        if ox == nil then
          ox = 0
        end
      end
      local oy
      do
        local __lux_tmp_y_168 = spec.y
        if __lux_tmp_y_168 == nil then
          __lux_tmp_y_168 = spec.offsetY
        end
        if __lux_tmp_y_168 == nil then
          __lux_tmp_y_168 = spec.dy
        end
        oy = toNumber(__lux_tmp_y_168)
        if oy == nil then
          oy = 0
        end
      end
      local gx = x + ox - grow
      local gy = y + oy - grow
      local gw = w + grow * 2
      local gh = h + grow * 2
      local gcuts = cutsWithGrow(cuts, grow)
      local spread = roundrect.effectExtentFromSpec(spec, 18)
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
      local __lux_tmp_width_169 = toNumber(spec.width)
      if __lux_tmp_width_169 == nil then
        __lux_tmp_width_169 = 18
      end
      local __lux_tmp_strength_170 = toNumber(spec.strength)
      if __lux_tmp_strength_170 == nil then
        __lux_tmp_strength_170 = 1
      end
      local __lux_tmp_falloff_171 = toNumber(spec.falloff)
      if __lux_tmp_falloff_171 == nil then
        __lux_tmp_falloff_171 = 1.9
      end
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
        width = mathMax(0.001, __lux_tmp_width_169),
        strength = mathMax(0, __lux_tmp_strength_170),
        falloff = mathMax(0.001, __lux_tmp_falloff_171),
      }
    end
    drawChamferShadowOuterSpec = function(x, y, w, h, cuts, shadowSpec, outerSpec)
      if shadowSpec == nil and outerSpec == nil or not shadersActive() or not materialOK(primitiveMaterials.chamfer_shadow_outer) then
        return false
      end
      local shadowBounds = chamferEffectBounds(x, y, w, h, cuts, shadowSpec, false)
      local outerBounds = chamferEffectBounds(x, y, w, h, cuts, outerSpec, true)
      if shadowBounds == nil and outerBounds == nil then
        return false
      end
      local baseBounds = shadowBounds
      if baseBounds == nil then
        baseBounds = outerBounds
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
      local shadowColor
      do
        local __lux_obj_shadowSpec_172 = shadowSpec
        local __lux_val_color_173 = nil
        if __lux_obj_shadowSpec_172 ~= nil then
          __lux_val_color_173 = __lux_obj_shadowSpec_172.color
        end
        shadowColor = __lux_val_color_173
        if shadowColor == nil then
          shadowColor = transparentColor
        end
      end
      local outerColor
      do
        local __lux_obj_outerSpec_174 = outerSpec
        local __lux_val_color_175 = nil
        if __lux_obj_outerSpec_174 ~= nil then
          __lux_val_color_175 = __lux_obj_outerSpec_174.color
        end
        outerColor = __lux_val_color_175
        if outerColor == nil then
          outerColor = transparentColor
        end
      end
      do
        local __lux_tmp_176
        if shadowBounds ~= nil then
          __lux_tmp_176 = shadowBounds.width
        else
          __lux_tmp_176 = 1
        end
        local __lux_tmp_177
        if shadowBounds ~= nil then
          __lux_tmp_177 = shadowBounds.strength
        else
          __lux_tmp_177 = 0
        end
        local __lux_tmp_r_178 = shadowColor.r
        if __lux_tmp_r_178 == nil then
          __lux_tmp_r_178 = 0
        end
        local __lux_tmp_g_179 = shadowColor.g
        if __lux_tmp_g_179 == nil then
          __lux_tmp_g_179 = 0
        end
        local __lux_tmp_b_180 = shadowColor.b
        if __lux_tmp_b_180 == nil then
          __lux_tmp_b_180 = 0
        end
        local __lux_tmp_181
        if shadowBounds ~= nil then
          do
            local __lux_tmp_a_182 = shadowColor.a
            if __lux_tmp_a_182 == nil then
              __lux_tmp_a_182 = 255
            end
            __lux_tmp_181 = __lux_tmp_a_182 / 255
          end
        else
          __lux_tmp_181 = 0
        end
        local __lux_obj_shadowBounds_183 = shadowBounds
        local __lux_tmp_shapeX_184 = nil
        if __lux_obj_shadowBounds_183 ~= nil then
          __lux_tmp_shapeX_184 = __lux_obj_shadowBounds_183.shapeX
        end
        if __lux_tmp_shapeX_184 == nil then
          __lux_tmp_shapeX_184 = x
        end
        local __lux_obj_shadowBounds_185 = shadowBounds
        local __lux_tmp_shapeY_186 = nil
        if __lux_obj_shadowBounds_185 ~= nil then
          __lux_tmp_shapeY_186 = __lux_obj_shadowBounds_185.shapeY
        end
        if __lux_tmp_shapeY_186 == nil then
          __lux_tmp_shapeY_186 = y
        end
        local __lux_obj_shadowBounds_187 = shadowBounds
        local __lux_tmp_shapeW_188 = nil
        if __lux_obj_shadowBounds_187 ~= nil then
          __lux_tmp_shapeW_188 = __lux_obj_shadowBounds_187.shapeW
        end
        if __lux_tmp_shapeW_188 == nil then
          __lux_tmp_shapeW_188 = w
        end
        local __lux_obj_shadowBounds_189 = shadowBounds
        local __lux_tmp_shapeH_190 = nil
        if __lux_obj_shadowBounds_189 ~= nil then
          __lux_tmp_shapeH_190 = __lux_obj_shadowBounds_189.shapeH
        end
        if __lux_tmp_shapeH_190 == nil then
          __lux_tmp_shapeH_190 = h
        end
        local __lux_obj_shadowBounds_191 = shadowBounds
        local __lux_tmp_tl_192 = nil
        if __lux_obj_shadowBounds_191 ~= nil then
          __lux_tmp_tl_192 = __lux_obj_shadowBounds_191.tl
        end
        if __lux_tmp_tl_192 == nil then
          __lux_tmp_tl_192 = 0
        end
        local __lux_obj_shadowBounds_193 = shadowBounds
        local __lux_tmp_tr_194 = nil
        if __lux_obj_shadowBounds_193 ~= nil then
          __lux_tmp_tr_194 = __lux_obj_shadowBounds_193.tr
        end
        if __lux_tmp_tr_194 == nil then
          __lux_tmp_tr_194 = 0
        end
        local __lux_obj_shadowBounds_195 = shadowBounds
        local __lux_tmp_br_196 = nil
        if __lux_obj_shadowBounds_195 ~= nil then
          __lux_tmp_br_196 = __lux_obj_shadowBounds_195.br
        end
        if __lux_tmp_br_196 == nil then
          __lux_tmp_br_196 = 0
        end
        local __lux_obj_shadowBounds_197 = shadowBounds
        local __lux_tmp_bl_198 = nil
        if __lux_obj_shadowBounds_197 ~= nil then
          __lux_tmp_bl_198 = __lux_obj_shadowBounds_197.bl
        end
        if __lux_tmp_bl_198 == nil then
          __lux_tmp_bl_198 = 0
        end
        setupParamMatrix(
          material,
          sw,
          sh,
          __lux_tmp_176,
          __lux_tmp_177,
          __lux_tmp_r_178 / 255,
          __lux_tmp_g_179 / 255,
          __lux_tmp_b_180 / 255,
          __lux_tmp_181,
          __lux_tmp_shapeX_184 - sx,
          __lux_tmp_shapeY_186 - sy,
          __lux_tmp_shapeW_188,
          __lux_tmp_shapeH_190,
          __lux_tmp_tl_192,
          __lux_tmp_tr_194,
          __lux_tmp_br_196,
          __lux_tmp_bl_198
        )
      end
      do
        local __lux_tmp_r_199 = outerColor.r
        if __lux_tmp_r_199 == nil then
          __lux_tmp_r_199 = 0
        end
        local __lux_tmp_g_200 = outerColor.g
        if __lux_tmp_g_200 == nil then
          __lux_tmp_g_200 = 0
        end
        local __lux_tmp_b_201 = outerColor.b
        if __lux_tmp_b_201 == nil then
          __lux_tmp_b_201 = 0
        end
        local __lux_tmp_202
        if outerBounds ~= nil then
          do
            local __lux_tmp_a_203 = outerColor.a
            if __lux_tmp_a_203 == nil then
              __lux_tmp_a_203 = 255
            end
            __lux_tmp_202 = __lux_tmp_a_203 / 255
          end
        else
          __lux_tmp_202 = 0
        end
        local __lux_obj_outerBounds_204 = outerBounds
        local __lux_tmp_shapeX_205 = nil
        if __lux_obj_outerBounds_204 ~= nil then
          __lux_tmp_shapeX_205 = __lux_obj_outerBounds_204.shapeX
        end
        if __lux_tmp_shapeX_205 == nil then
          __lux_tmp_shapeX_205 = x
        end
        local __lux_obj_outerBounds_206 = outerBounds
        local __lux_tmp_shapeY_207 = nil
        if __lux_obj_outerBounds_206 ~= nil then
          __lux_tmp_shapeY_207 = __lux_obj_outerBounds_206.shapeY
        end
        if __lux_tmp_shapeY_207 == nil then
          __lux_tmp_shapeY_207 = y
        end
        local __lux_obj_outerBounds_208 = outerBounds
        local __lux_tmp_shapeW_209 = nil
        if __lux_obj_outerBounds_208 ~= nil then
          __lux_tmp_shapeW_209 = __lux_obj_outerBounds_208.shapeW
        end
        if __lux_tmp_shapeW_209 == nil then
          __lux_tmp_shapeW_209 = w
        end
        local __lux_obj_outerBounds_210 = outerBounds
        local __lux_tmp_shapeH_211 = nil
        if __lux_obj_outerBounds_210 ~= nil then
          __lux_tmp_shapeH_211 = __lux_obj_outerBounds_210.shapeH
        end
        if __lux_tmp_shapeH_211 == nil then
          __lux_tmp_shapeH_211 = h
        end
        local __lux_obj_outerBounds_212 = outerBounds
        local __lux_tmp_tl_213 = nil
        if __lux_obj_outerBounds_212 ~= nil then
          __lux_tmp_tl_213 = __lux_obj_outerBounds_212.tl
        end
        if __lux_tmp_tl_213 == nil then
          __lux_tmp_tl_213 = 0
        end
        local __lux_obj_outerBounds_214 = outerBounds
        local __lux_tmp_tr_215 = nil
        if __lux_obj_outerBounds_214 ~= nil then
          __lux_tmp_tr_215 = __lux_obj_outerBounds_214.tr
        end
        if __lux_tmp_tr_215 == nil then
          __lux_tmp_tr_215 = 0
        end
        local __lux_obj_outerBounds_216 = outerBounds
        local __lux_tmp_br_217 = nil
        if __lux_obj_outerBounds_216 ~= nil then
          __lux_tmp_br_217 = __lux_obj_outerBounds_216.br
        end
        if __lux_tmp_br_217 == nil then
          __lux_tmp_br_217 = 0
        end
        local __lux_obj_outerBounds_218 = outerBounds
        local __lux_tmp_bl_219 = nil
        if __lux_obj_outerBounds_218 ~= nil then
          __lux_tmp_bl_219 = __lux_obj_outerBounds_218.bl
        end
        if __lux_tmp_bl_219 == nil then
          __lux_tmp_bl_219 = 0
        end
        local __lux_tmp_220
        if shadowBounds ~= nil then
          __lux_tmp_220 = shadowBounds.falloff
        else
          __lux_tmp_220 = 1
        end
        local __lux_tmp_221
        if outerBounds ~= nil then
          __lux_tmp_221 = outerBounds.width
        else
          __lux_tmp_221 = 1
        end
        local __lux_tmp_222
        if outerBounds ~= nil then
          __lux_tmp_222 = outerBounds.strength
        else
          __lux_tmp_222 = 0
        end
        local __lux_tmp_223
        if outerBounds ~= nil then
          __lux_tmp_223 = outerBounds.falloff
        else
          __lux_tmp_223 = 1
        end
        setupPrimitiveAuxConstants(
          material,
          __lux_tmp_r_199 / 255,
          __lux_tmp_g_200 / 255,
          __lux_tmp_b_201 / 255,
          __lux_tmp_202,
          __lux_tmp_shapeX_205 - sx,
          __lux_tmp_shapeY_207 - sy,
          __lux_tmp_shapeW_209,
          __lux_tmp_shapeH_211,
          __lux_tmp_tl_213,
          __lux_tmp_tr_215,
          __lux_tmp_br_217,
          __lux_tmp_bl_219,
          __lux_tmp_220,
          __lux_tmp_221,
          __lux_tmp_222,
          __lux_tmp_223
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
      if spec == nil or spec.tint == nil then
        return nil
      end
      local tint = spec.tint
      local alpha
      do
        local __lux_tmp_a_224 = tint.a
        if __lux_tmp_a_224 == nil then
          __lux_tmp_a_224 = 255
        end
        local __lux_tmp_opacity_225 = spec.opacity
        if __lux_tmp_opacity_225 == nil then
          __lux_tmp_opacity_225 = 1
        end
        alpha = __lux_tmp_a_224 * __lux_tmp_opacity_225
      end
      if alpha <= 0 then
        return nil
      end
      local __lux_tmp_r_226 = tint.r
      if __lux_tmp_r_226 == nil then
        __lux_tmp_r_226 = 0
      end
      local __lux_tmp_g_227 = tint.g
      if __lux_tmp_g_227 == nil then
        __lux_tmp_g_227 = 0
      end
      local __lux_tmp_b_228 = tint.b
      if __lux_tmp_b_228 == nil then
        __lux_tmp_b_228 = 0
      end
      return makeColor(
        __lux_tmp_r_226,
        __lux_tmp_g_227,
        __lux_tmp_b_228,
        mathFloor(mathClamp(alpha, 0, 255) + 0.5)
      )
    end
    drawChamferBackdrop = function(x, y, w, h, cuts, backdrop)
      local spec = style.backdropStyle(backdrop)
      if spec == nil or not shadersActive() then
        return nil
      end
      local pad
      do
        local __lux_tmp_padding_229 = toNumber(spec.padding)
        if __lux_tmp_padding_229 == nil then
          __lux_tmp_padding_229 = 0
        end
        pad = mathMax(0, __lux_tmp_padding_229)
      end
      local bx = x - pad
      local by = y - pad
      local bw = w + pad * 2
      local bh = h + pad * 2
      local bcuts = cutsWithGrow(cuts, pad)
      local tl, tr, br, bl = chamferTuple(bcuts, bw, bh)
      if spec.blur > 0 and primitiveBlurRT ~= nil and renderCopyRenderTargetToTexture ~= nil and materialOK(primitiveMaterials.chamfer_backdrop) then
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
        drawChamferBasePass(bx, by, bw, bh, bcuts, style.solid(tint), nil, 0, nil)
      end
      return true
    end
    drawChamferPattern = function(x, y, w, h, cuts, pattern)
      local spec = roundrect.patternStyle(pattern)
      if spec == nil or not shadersActive() or not materialOK(primitiveMaterials.chamfer_pattern) then
        return false
      end
      local color = spec.color
      if color == nil then
        color = spec.tint
      end
      local __lux_tmp_232 = color ~= nil
      if __lux_tmp_232 then
        local __lux_tmp_a_231 = color.a
        if __lux_tmp_a_231 == nil then
          __lux_tmp_a_231 = 255
        end
        __lux_tmp_232 = __lux_tmp_a_231 <= 0
      end
      if __lux_tmp_232 then
        return false
      end
      local tl, tr, br, bl = chamferTuple(cuts, w, h)
      local angle
      do
        local __lux_tmp_angle_233 = toNumber(spec.angle)
        if __lux_tmp_angle_233 == nil then
          __lux_tmp_angle_233 = 135
        end
        angle = mathRad(__lux_tmp_angle_233)
      end
      local smoke
      local __lux_match_234 = spec.kind
      if __lux_match_234 == "smoke" then
        smoke = true
      else
        smoke = false
      end
      local material = primitiveMaterials.chamfer_pattern
      local r, g, b, a
      do
        local __lux_tmp_color_235 = spec.color
        if __lux_tmp_color_235 == nil then
          __lux_tmp_color_235 = spec.tint
        end
        r, g, b, a = style.color01(style.asColor(__lux_tmp_color_235, makeColor(255, 255, 255, 24)))
      end
      local pz = 1
      local pw = 1
      if smoke then
        local density
        do
          local __lux_tmp_density_236 = toNumber(spec.density)
          if __lux_tmp_density_236 == nil then
            __lux_tmp_density_236 = 0.48
          end
          density = mathClamp(mathFloor(__lux_tmp_density_236 * 255 + 0.5), 0, 255)
        end
        local softness
        do
          local __lux_tmp_softness_237 = toNumber(spec.softness)
          if __lux_tmp_softness_237 == nil then
            __lux_tmp_softness_237 = 0.3
          end
          softness = mathClamp(mathFloor(__lux_tmp_softness_237 * 255 + 0.5), 0, 255)
        end
        local warp
        do
          local __lux_tmp_warp_238 = toNumber(spec.warp)
          if __lux_tmp_warp_238 == nil then
            __lux_tmp_warp_238 = 0.85
          end
          warp = mathClamp(mathFloor(__lux_tmp_warp_238 * 255 + 0.5), 0, 255)
        end
        do
          local __lux_tmp_scale_239 = toNumber(spec.scale)
          if __lux_tmp_scale_239 == nil then
            __lux_tmp_scale_239 = 140
          end
          pz = mathMax(1, __lux_tmp_scale_239)
        end
        pw = density + softness * 256 + warp * 65536
      else
        do
          local __lux_tmp_spacing_240 = toNumber(spec.spacing)
          if __lux_tmp_spacing_240 == nil then
            __lux_tmp_spacing_240 = 12
          end
          pz = mathMax(1, __lux_tmp_spacing_240)
        end
        do
          local __lux_tmp_width_241 = toNumber(spec.width)
          if __lux_tmp_width_241 == nil then
            __lux_tmp_width_241 = 2
          end
          pw = mathMax(0.25, __lux_tmp_width_241)
        end
      end
      do
        local __lux_tmp_243 = smoke
        if __lux_tmp_243 then
          local __lux_tmp_seed_242 = toNumber(spec.seed)
          if __lux_tmp_seed_242 == nil then
            __lux_tmp_seed_242 = 0
          end
          __lux_tmp_243 = __lux_tmp_seed_242
        end
        local __lux_tmp_244 = __lux_tmp_243
        if not __lux_tmp_244 then
          __lux_tmp_244 = 0
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
          (smoke and 1 or 0) + __lux_tmp_244,
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
      if not style.strokeVisible(stroke, strokeWidth) or not shadersActive() or not materialOK(primitiveMaterials.chamfer_stroke) then
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
    drawChamferBasePass = function(x, y, w, h, cuts, fill, stroke, strokeWidth, innerSpec)
      if not shadersActive() or not materialOK(primitiveMaterials.chamfer) then
        return false
      end
      local tl, tr, br, bl = chamferTuple(cuts, w, h)
      local material = primitiveMaterials.chamfer
      local glowR = 0
      local glowG = 0
      local glowB = 0
      local glowA = 0
      local glowWidth = 0
      local glowStrength = 0
      local glowFalloff = 1
      if innerSpec ~= nil then
        do
          local __lux_tmp_color_245 = innerSpec.color
          if __lux_tmp_color_245 == nil then
            __lux_tmp_color_245 = transparentColor
          end
          glowR, glowG, glowB, glowA = style.color01(__lux_tmp_color_245)
        end
        do
          local __lux_tmp_width_246 = toNumber(innerSpec.width)
          if __lux_tmp_width_246 == nil then
            __lux_tmp_width_246 = 8
          end
          glowWidth = mathMax(0.001, __lux_tmp_width_246)
        end
        do
          local __lux_tmp_strength_247 = toNumber(innerSpec.strength)
          if __lux_tmp_strength_247 == nil then
            __lux_tmp_strength_247 = 1
          end
          glowStrength = mathMax(0, __lux_tmp_strength_247)
        end
        do
          local __lux_tmp_falloff_248 = toNumber(innerSpec.falloff)
          if __lux_tmp_falloff_248 == nil then
            __lux_tmp_falloff_248 = 1.65
          end
          glowFalloff = mathMax(0.001, __lux_tmp_falloff_248)
        end
      end
      setupPrimitiveAuxConstants(
        material,
        tl,
        tr,
        br,
        bl,
        glowR,
        glowG,
        glowB,
        glowA,
        glowWidth,
        glowStrength,
        glowFalloff,
        0
      )
      do
        local __lux_tmp_fill_249 = fill
        if __lux_tmp_fill_249 == nil then
          __lux_tmp_fill_249 = transparentFill
        end
        setupPrimitiveFillConstants(material, w, h, __lux_tmp_fill_249, stroke, strokeWidth, 0)
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    copyChamferStyleInto = function(out, source, fillOnly)
      for key, _ in pairs(out) do
        out[key] = nil
      end
      do
        local __lux_tmp_source_250 = source
        if __lux_tmp_source_250 == nil then
          __lux_tmp_source_250 = {}
        end
        for key, value in pairs(__lux_tmp_source_250) do
          out[key] = value
        end
      end
      if fillOnly then
        out.stroke = nil
        out.strokeWidth = 0
        out.pattern = nil
      end
      return out
    end
    drawChamferFallback = function(x, y, w, h, cuts, drawStyle, fillOnly)
      if fillOnly == nil then
        fillOnly = false
      end
      local fallback = copyChamferStyleInto(chamferFillFallbackStyle, drawStyle, fillOnly)
      return polyEx(chamferPoints(x, y, w, h, cuts), fallback)
    end
    drawChamferStrokeFallback = function(x, y, w, h, cuts, stroke, strokeWidth)
      chamferStrokeFallbackStyle.stroke = stroke
      chamferStrokeFallbackStyle.strokeWidth = strokeWidth
      return polyEx(chamferPoints(x, y, w, h, cuts), chamferStrokeFallbackStyle)
    end
    drawChamferBoxImmediate = function(x, y, w, h, drawStyle, resolvedCuts)
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local cuts = resolvedCuts
      if cuts == nil then
        cuts = resolved.cuts
        if cuts == nil then
          cuts = 0
        end
      end
      local shadow = roundrect.shadowStyle(resolved.shadow)
      local outer = roundrect.outerGlowStyle(resolved.outerGlow)
      if shadow ~= nil or outer ~= nil then
        drawChamferShadowOuterSpec(x, y, w, h, cuts, shadow, outer)
      end
      local backdrop = nil
      if resolved.backdrop ~= nil then
        backdrop = drawChamferBackdrop(x, y, w, h, cuts, resolved.backdrop)
      end
      local fill
      do
        local __lux_tmp_fill_251 = resolved.fill
        if __lux_tmp_fill_251 == nil then
          __lux_tmp_fill_251 = resolved.color
        end
        fill = style.fillFromStyle(__lux_tmp_fill_251)
      end
      local strokeWidth = style.strokeWidthValue(resolved.strokeWidth, 0)
      local fillVisible = style.fillVisible(fill)
      local strokeVisible = style.strokeVisible(resolved.stroke, strokeWidth)
      local inner = roundrect.innerGlowStyle(resolved.innerGlow)
      local pattern = resolved.pattern
      local baseDrawn = false
      local baseDrewStroke = false
      local baseDrewInner = false
      if fillVisible or strokeVisible or inner ~= nil then
        if pattern == nil then
          baseDrawn = drawChamferBasePass(x, y, w, h, cuts, fill, resolved.stroke, strokeWidth, inner)
          baseDrewStroke = baseDrawn and strokeVisible
          baseDrewInner = baseDrawn and inner ~= nil
        else
          if fillVisible then
            baseDrawn = drawChamferBasePass(x, y, w, h, cuts, fill, nil, 0, nil)
          end
        end
      end
      if not baseDrawn and fillVisible then
        drawChamferFallback(x, y, w, h, cuts, resolved, true)
      end
      if pattern ~= nil then
        drawChamferPattern(x, y, w, h, cuts, pattern)
      end
      if strokeVisible and not baseDrewStroke then
        if not drawChamferStroke(x, y, w, h, cuts, resolved.stroke, strokeWidth) then
          drawChamferStrokeFallback(x, y, w, h, cuts, resolved.stroke, strokeWidth)
        end
      end
      if inner ~= nil and not baseDrewInner then
        drawChamferInnerGlowSpec(x, y, w, h, cuts, inner)
      end
    end
  end
  do
    polyEx = function(points, drawStyle)
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
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
      polyStyle.fill = fill
      polyStyle.stroke = stroke
      polyStyle.strokeWidth = strokeWidth
      return polyEx(points, polyStyle)
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
      local point = points[index]
      if point == nil then
        point = {}
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
        local __lux_tmp_sides_252 = toNumber(sides)
        if __lux_tmp_sides_252 == nil then
          __lux_tmp_sides_252 = 3
        end
        count = mathClamp(mathFloor(__lux_tmp_sides_252), 3, 8)
      end
      local r
      do
        local __lux_tmp_radius_253 = toNumber(radius)
        if __lux_tmp_radius_253 == nil then
          __lux_tmp_radius_253 = 0
        end
        r = mathMax(0, __lux_tmp_radius_253)
      end
      local start
      do
        local __lux_tmp_rotation_254 = toNumber(rotation)
        if __lux_tmp_rotation_254 == nil then
          __lux_tmp_rotation_254 = -90
        end
        start = mathRad(__lux_tmp_rotation_254)
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
        local __lux_tmp_direction_255 = direction
        if __lux_tmp_direction_255 == nil then
          __lux_tmp_direction_255 = "right"
        end
        local __lux_match_256 = __lux_tmp_direction_255
        if __lux_match_256 == "up" then
          setPoint(caretScratch, 1, x + w * 0.5, y)
          setPoint(caretScratch, 2, x + w, y + h)
          setPoint(caretScratch, 3, x, y + h)
        elseif __lux_match_256 == "down" then
          setPoint(caretScratch, 1, x, y)
          setPoint(caretScratch, 2, x + w, y)
          setPoint(caretScratch, 3, x + w * 0.5, y + h)
        elseif __lux_match_256 == "left" then
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
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local __lux_tmp_rotation_257 = resolved.rotation
      if __lux_tmp_rotation_257 == nil then
        __lux_tmp_rotation_257 = resolved.angle
      end
      return polyEx(regularPolyPoints(cx, cy, radius, sides, __lux_tmp_rotation_257), resolved)
    end
    regularPoly = function(cx, cy, radius, sides, rotation, fill, stroke, strokeWidth)
      regularPolyStyle.rotation = rotation
      regularPolyStyle.fill = fill
      regularPolyStyle.stroke = stroke
      regularPolyStyle.strokeWidth = strokeWidth
      return regularPolyEx(cx, cy, radius, sides, regularPolyStyle)
    end
    diamondEx = function(x, y, w, h, drawStyle)
      return polyEx(diamondPoints(x, y, w, h), drawStyle)
    end
    diamond = function(x, y, w, h, fill, stroke, strokeWidth)
      diamondStyle.fill = fill
      diamondStyle.stroke = stroke
      diamondStyle.strokeWidth = strokeWidth
      return diamondEx(x, y, w, h, diamondStyle)
    end
    caretEx = function(x, y, w, h, drawStyle)
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local __lux_tmp_direction_258 = resolved.direction
      if __lux_tmp_direction_258 == nil then
        __lux_tmp_direction_258 = resolved.dir
      end
      return polyEx(caretPoints(x, y, w, h, __lux_tmp_direction_258), resolved)
    end
    caret = function(x, y, w, h, direction, fill, stroke, strokeWidth)
      caretStyle.direction = direction
      caretStyle.fill = fill
      caretStyle.stroke = stroke
      caretStyle.strokeWidth = strokeWidth
      return caretEx(x, y, w, h, caretStyle)
    end
    chamferBoxEx = function(x, y, w, h, drawStyle)
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local transform, stripped = splitStyleTransform(resolved)
      local cuts = stripped.cuts
      if cuts == nil then
        cuts = 0
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
      chamferStyle.cuts = cuts
      chamferStyle.fill = fill
      chamferStyle.stroke = stroke
      chamferStyle.strokeWidth = strokeWidth
      return chamferBoxEx(x, y, w, h, chamferStyle)
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
  __lux_exports.drawLineImmediate = drawLineImmediate
  __lux_exports.lineEx = lineEx
  __lux_exports.line = line
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
