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
  local mathCeil
  local mathFloor
  local mathMax
  local mathMin
  local mathCos
  local mathRad
  local mathSin
  local mathSqrt
  local surfaceDrawLine
  local surfaceSetMaterial
  local surfaceSetDrawColor
  local toNumber
  local typeOf
  local makeColor
  local drawTransformedPoly
  local drawTexturedQuad
  local drawTexturedQuadUV
  local hasTransform
  local prepareBackdropBlur
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
  local primitiveMatOK
  local primitiveHasShaders
  local forceFallbackCvar
  local lineVertsScratch
  local lineFallbackVertsScratch
  local linePolyPointsScratch
  local polyDrawRectScratch
  local defaultLineColor
  local transparentColor
  local primitiveTransparentFill
  local polyBackdropFill
  local LINE_AA_FRINGE
  local LINE_NO_CAPS_UV_OFFSET
  local configurePrimitives
  local materialOK
  local shadersActive
  local setupParamMatrix
  local fillColor
  local hotFillVisible
  local pointXY
  local effectBleedFromDrawRect
  local primitiveStrokeVisible
  local drawPreparedRoundRectPlain
  local drawPreparedRoundRectEffects
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
  local lineNoCaps
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
  local setupPolyWornPatternExtraParams
  local drawPolyPatternPrepared
  local drawPolyPattern
  local setupPolyStrokeConstants
  local drawPolyStrokeShader
  local setupPolyFillConstants
  local drawPolyStroke
  local drawPolyFallbackPrepared
  local drawPolyFallbackRaw
  local drawPolyRawNormalized
  local drawPolyImmediateNormalized
  local drawPolyRaw
  local drawPolyImmediate
  local transparentFill
  local chamferFillParams
  local setupPrimitiveAuxConstants
  local setupPrimitiveFillConstants
  local setupChamferWornPatternExtraParams
  local drawChamferInnerGlowRaw
  local cutsWithGrow
  local chamferEffectBounds
  local drawChamferShadowOuterRaw
  local chamferBackdropTintColor
  local drawChamferBackdrop
  local drawChamferPatternPrepared
  local drawChamferPattern
  local drawChamferQuad
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
    mathCeil = math.ceil
    mathFloor = math.floor
    mathMax = math.max
    mathMin = math.min
    mathCos = math.cos
    mathRad = math.rad
    mathSin = math.sin
    mathSqrt = math.sqrt
    surfaceDrawLine = surface.DrawLine
    surfaceSetMaterial = surface.SetMaterial
    surfaceSetDrawColor = surface.SetDrawColor
    toNumber = tonumber
    typeOf = type
    makeColor = Color
    drawTransformedPoly = geometry.drawTransformedPoly
    drawTexturedQuad = geometry.drawTexturedQuad
    drawTexturedQuadUV = geometry.drawTexturedQuadUV
    hasTransform = geometry.hasTransform
    prepareBackdropBlur = geometry.prepareBackdropBlur
    isCulled = frame.isCulled
    splitStyleTransform = geometry.splitStyleTransform
    withTransform = geometry.withTransform
    beginPanelEffectBleed = frame.beginPanelEffectBleed
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
    auxParamMatrices = {}
    primitiveMaterials = {}
    primitiveMatOK = function(material)
      return material ~= nil and material.IsError ~= nil and not material:IsError()
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
    primitiveTransparentFill = {
      kind = style.FILL_SOLID,
      colorA = transparentColor,
      colorB = transparentColor,
      _mgfxFillVisible = false,
    }
    polyBackdropFill = { kind = style.FILL_SOLID, colorA = transparentColor, colorB = transparentColor }
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
        local __lux_tmp_Materials_4 = owner._Materials
        if __lux_tmp_Materials_4 == nil then
          __lux_tmp_Materials_4 = materialState.materials
        end
        if __lux_tmp_Materials_4 == nil then
          __lux_tmp_Materials_4 = primitiveMaterials
        end
        if __lux_tmp_Materials_4 == nil then
          __lux_tmp_Materials_4 = {}
        end
        primitiveMaterials = __lux_tmp_Materials_4
      end
      do
        local __lux_tmp_MaterialOK_5 = owner.MaterialOK
        if __lux_tmp_MaterialOK_5 == nil then
          __lux_tmp_MaterialOK_5 = materialState.matOK
        end
        if __lux_tmp_MaterialOK_5 == nil then
          __lux_tmp_MaterialOK_5 = primitiveMatOK
        end
        primitiveMatOK = __lux_tmp_MaterialOK_5
      end
      do
        local __lux_tmp_hasShaders_6 = owner.hasShaders
        if __lux_tmp_hasShaders_6 == nil then
          __lux_tmp_hasShaders_6 = primitiveHasShaders
        end
        primitiveHasShaders = __lux_tmp_hasShaders_6
      end
      return true
    end
    materialOK = function(material)
      return primitiveMatOK ~= nil and primitiveMatOK(material)
    end
    shadersActive = function()
      if forceFallbackCvar == nil and getConVar ~= nil then
        do
          local __lux_tmp_getConVar_7 = getConVar("mgfx_force_fallback")
          if __lux_tmp_getConVar_7 == nil then
            __lux_tmp_getConVar_7 = false
          end
          forceFallbackCvar = __lux_tmp_getConVar_7
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
        local __lux_tmp_a0_8 = a0
        if __lux_tmp_a0_8 == nil then
          __lux_tmp_a0_8 = 0
        end
        local __lux_tmp_b0_9 = b0
        if __lux_tmp_b0_9 == nil then
          __lux_tmp_b0_9 = 0
        end
        local __lux_tmp_c0_10 = c0
        if __lux_tmp_c0_10 == nil then
          __lux_tmp_c0_10 = 0
        end
        local __lux_tmp_d0_11 = d0
        if __lux_tmp_d0_11 == nil then
          __lux_tmp_d0_11 = 0
        end
        local __lux_tmp_a1_12 = a1
        if __lux_tmp_a1_12 == nil then
          __lux_tmp_a1_12 = 0
        end
        local __lux_tmp_b1_13 = b1
        if __lux_tmp_b1_13 == nil then
          __lux_tmp_b1_13 = 0
        end
        local __lux_tmp_c1_14 = c1
        if __lux_tmp_c1_14 == nil then
          __lux_tmp_c1_14 = 0
        end
        local __lux_tmp_d1_15 = d1
        if __lux_tmp_d1_15 == nil then
          __lux_tmp_d1_15 = 0
        end
        local __lux_tmp_a2_16 = a2
        if __lux_tmp_a2_16 == nil then
          __lux_tmp_a2_16 = 0
        end
        local __lux_tmp_b2_17 = b2
        if __lux_tmp_b2_17 == nil then
          __lux_tmp_b2_17 = 0
        end
        local __lux_tmp_c2_18 = c2
        if __lux_tmp_c2_18 == nil then
          __lux_tmp_c2_18 = 0
        end
        local __lux_tmp_d2_19 = d2
        if __lux_tmp_d2_19 == nil then
          __lux_tmp_d2_19 = 0
        end
        local __lux_tmp_a3_20 = a3
        if __lux_tmp_a3_20 == nil then
          __lux_tmp_a3_20 = 0
        end
        local __lux_tmp_b3_21 = b3
        if __lux_tmp_b3_21 == nil then
          __lux_tmp_b3_21 = 0
        end
        local __lux_tmp_c3_22 = c3
        if __lux_tmp_c3_22 == nil then
          __lux_tmp_c3_22 = 0
        end
        local __lux_tmp_d3_23 = d3
        if __lux_tmp_d3_23 == nil then
          __lux_tmp_d3_23 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_a0_8,
          __lux_tmp_b0_9,
          __lux_tmp_c0_10,
          __lux_tmp_d0_11,
          __lux_tmp_a1_12,
          __lux_tmp_b1_13,
          __lux_tmp_c1_14,
          __lux_tmp_d1_15,
          __lux_tmp_a2_16,
          __lux_tmp_b2_17,
          __lux_tmp_c2_18,
          __lux_tmp_d2_19,
          __lux_tmp_a3_20,
          __lux_tmp_b3_21,
          __lux_tmp_c3_22,
          __lux_tmp_d3_23
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
        local __lux_tmp_colorA_24 = fill.colorA
        if __lux_tmp_colorA_24 == nil then
          __lux_tmp_colorA_24 = fill.color
        end
        if __lux_tmp_colorA_24 == nil then
          __lux_tmp_colorA_24 = fallback
        end
        if __lux_tmp_colorA_24 == nil then
          __lux_tmp_colorA_24 = color_white
        end
        return __lux_tmp_colorA_24
      end
      local __lux_tmp_fallback_25 = fallback
      if __lux_tmp_fallback_25 == nil then
        __lux_tmp_fallback_25 = color_white
      end
      return __lux_tmp_fallback_25
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
      local colorA = fill.colorA
      if colorA == nil then
        colorA = fill.color
        if colorA == nil then
          colorA = color_white
        end
      end
      local __lux_tmp_colorB_26 = fill.colorB
      if __lux_tmp_colorB_26 == nil then
        __lux_tmp_colorB_26 = colorA(colorA.a == nil or colorA.a > 0)
      end
      local __lux_tmp_27 = __lux_tmp_colorB_26
      if not __lux_tmp_27 then
        __lux_tmp_27 = colorB.a == nil or colorB.a > 0
      end
      local colorB = __lux_tmp_27
    end
    pointXY = function(point)
      local __lux_tmp_x_28 = point.x
      if __lux_tmp_x_28 == nil then
        __lux_tmp_x_28 = point[1]
      end
      local __lux_tmp_x_29 = toNumber(__lux_tmp_x_28)
      if __lux_tmp_x_29 == nil then
        __lux_tmp_x_29 = 0
      end
      local __lux_tmp_y_30 = point.y
      if __lux_tmp_y_30 == nil then
        __lux_tmp_y_30 = point[2]
      end
      local __lux_tmp_y_31 = toNumber(__lux_tmp_y_30)
      if __lux_tmp_y_31 == nil then
        __lux_tmp_y_31 = 0
      end
      return __lux_tmp_x_29, __lux_tmp_y_31
    end
    effectBleedFromDrawRect = function(x, y, w, h, drawX, drawY, drawW, drawH)
      local left = mathMax(0, x - drawX)
      local top = mathMax(0, y - drawY)
      local right = mathMax(0, drawX + drawW - (x + w))
      local bottom = mathMax(0, drawY + drawH - (y + h))
      return left, top, right, bottom
    end
    primitiveStrokeVisible = function(strokeValue, strokeWidth)
      local __lux_tmp_33 = strokeValue ~= nil and (strokeValue.a == nil or strokeValue.a > 0)
      if __lux_tmp_33 then
        local __lux_tmp_strokeWidth_32 = strokeWidth
        if __lux_tmp_strokeWidth_32 == nil then
          __lux_tmp_strokeWidth_32 = 0
        end
        __lux_tmp_33 = __lux_tmp_strokeWidth_32 > 0
      end
      return __lux_tmp_33
    end
    drawPreparedRoundRectPlain = function(x, y, w, h, radius, fill, strokeValue, strokeWidth, patternSpec, strokeKind, strokeLength, strokeGap, strokeOffset)
      if strokeWidth == nil then
        strokeWidth = 0
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
      local __lux_tmp_fill_34 = fill
      if __lux_tmp_fill_34 == nil then
        __lux_tmp_fill_34 = primitiveTransparentFill
      end
      return roundrect.drawRoundRectPrepared(
        x,
        y,
        w,
        h,
        radius,
        __lux_tmp_fill_34,
        hotFillVisible(fill),
        strokeValue,
        strokeWidth,
        primitiveStrokeVisible(strokeValue, strokeWidth),
        strokeKind,
        strokeLength,
        strokeGap,
        strokeOffset,
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
        1,
        0,
        0,
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
        1,
        0,
        0,
        false,
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        nil,
        patternSpec
      )
    end
    drawPreparedRoundRectEffects = function(x, y, w, h, radius, fill, hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread, hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread, backdropSpec)
      local __lux_tmp_fill_35 = fill
      if __lux_tmp_fill_35 == nil then
        __lux_tmp_fill_35 = primitiveTransparentFill
      end
      return roundrect.drawRoundRectPrepared(
        x,
        y,
        w,
        h,
        radius,
        __lux_tmp_fill_35,
        hotFillVisible(fill),
        nil,
        0,
        false,
        style.STROKE_SOLID,
        0,
        0,
        0,
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
        false,
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        backdropSpec,
        nil
      )
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
          local __lux_tmp_tl_36 = cuts.tl
          if __lux_tmp_tl_36 == nil then
            __lux_tmp_tl_36 = cuts[1]
          end
          local __lux_tmp_tl_37 = toNumber(__lux_tmp_tl_36)
          if __lux_tmp_tl_37 == nil then
            __lux_tmp_tl_37 = 0
          end
          tl = __lux_tmp_tl_37
        end
        do
          local __lux_tmp_tr_38 = cuts.tr
          if __lux_tmp_tr_38 == nil then
            __lux_tmp_tr_38 = cuts[2]
          end
          local __lux_tmp_tr_39 = toNumber(__lux_tmp_tr_38)
          if __lux_tmp_tr_39 == nil then
            __lux_tmp_tr_39 = tl
          end
          tr = __lux_tmp_tr_39
        end
        do
          local __lux_tmp_br_40 = cuts.br
          if __lux_tmp_br_40 == nil then
            __lux_tmp_br_40 = cuts[3]
          end
          local __lux_tmp_br_41 = toNumber(__lux_tmp_br_40)
          if __lux_tmp_br_41 == nil then
            __lux_tmp_br_41 = tr
          end
          br = __lux_tmp_br_41
        end
        do
          local __lux_tmp_bl_42 = cuts.bl
          if __lux_tmp_bl_42 == nil then
            __lux_tmp_bl_42 = cuts[4]
          end
          local __lux_tmp_bl_43 = toNumber(__lux_tmp_bl_42)
          if __lux_tmp_bl_43 == nil then
            __lux_tmp_bl_43 = br
          end
          bl = __lux_tmp_bl_43
        end
      else
        do
          local __lux_tmp_cuts_44 = toNumber(cuts)
          if __lux_tmp_cuts_44 == nil then
            __lux_tmp_cuts_44 = 0
          end
          tl = __lux_tmp_cuts_44
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
            local __lux_cmp_45 = false
            if mathAbs(last.x - px) ~= nil then
              __lux_cmp_45 = mathAbs(last.x - px) < 0.001
            end
            sameX = __lux_cmp_45
          end
          local sameY
          do
            local __lux_cmp_46 = false
            if mathAbs(last.y - py) ~= nil then
              __lux_cmp_46 = mathAbs(last.y - py) < 0.001
            end
            sameY = __lux_cmp_46
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
        local __lux_cmp_49 = false
        if mathAbs(first.x - last.x) ~= nil then
          __lux_cmp_49 = mathAbs(first.x - last.x) < 0.001
        end
        local __lux_tmp_51 = __lux_cmp_49
        if __lux_tmp_51 then
          local __lux_cmp_50 = false
          if mathAbs(first.y - last.y) ~= nil then
            __lux_cmp_50 = mathAbs(first.y - last.y) < 0.001
          end
          __lux_tmp_51 = __lux_cmp_50
        end
        if __lux_tmp_51 then
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
        local __lux_cmp_52 = false
        if mathAbs(cross) ~= nil then
          __lux_cmp_52 = mathAbs(cross) > 0.000001
        end
        if __lux_cmp_52 then
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
        local __lux_tmp_points_53 = points
        if __lux_tmp_points_53 == nil then
          __lux_tmp_points_53 = {}
        end
        count = #__lux_tmp_points_53
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
      local __lux_cmp_54 = false
      if signedArea(ordered) ~= nil then
        __lux_cmp_54 = signedArea(ordered) < 0
      end
      if __lux_cmp_54 then
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
      local __lux_cmp_55 = false
      if mathAbs(det) ~= nil then
        __lux_cmp_55 = mathAbs(det) > 0.0001
      end
      if __lux_cmp_55 then
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
        local __lux_tmp_amount_56 = toNumber(amount)
        if __lux_tmp_amount_56 == nil then
          __lux_tmp_amount_56 = 0
        end
        amount = mathMax(0, __lux_tmp_amount_56)
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
      local __lux_tmp_grown_57 = normalizePoly(grown)
      if __lux_tmp_grown_57 == nil then
        __lux_tmp_grown_57 = poly
      end
      return __lux_tmp_grown_57
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
      setupParamMatrix(
        material,
        r,
        g,
        b,
        a,
        br,
        bg,
        bb,
        ba,
        0,
        0,
        1,
        style.gradientCurve(fill.curve),
        0,
        0,
        0,
        0
      )
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
    drawLineRectRaw = function(x, y, w, h, fill, radius, shadow, outerGlow, backdrop)
      if radius ~= nil and shadow == nil and outerGlow == nil and backdrop == nil then
        local __lux_tmp_radius_58 = radius
        if __lux_tmp_radius_58 == nil then
          __lux_tmp_radius_58 = 0
        end
        return drawPreparedRoundRectPlain(x, y, w, h, __lux_tmp_radius_58, fill)
      end
      if radius ~= nil or shadow ~= nil or outerGlow ~= nil or backdrop ~= nil then
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
        if shadow ~= nil and shadow ~= false then
          hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread = roundrect.shadowRaw(shadow)
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
        if outerGlow ~= nil and outerGlow ~= false then
          hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread = roundrect.outerGlowRaw(outerGlow)
        end
        local backdropSpec
        if backdrop ~= nil and backdrop ~= false then
          backdropSpec = style.backdropStyle(backdrop)
        else
          backdropSpec = nil
        end
        local __lux_tmp_radius_59 = radius
        if __lux_tmp_radius_59 == nil then
          __lux_tmp_radius_59 = 0
        end
        return drawPreparedRoundRectEffects(
          x,
          y,
          w,
          h,
          __lux_tmp_radius_59,
          fill,
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
          backdropSpec
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
      if shadow == nil and outerGlow == nil and drawLineShaderVerts(verts, fill) then
        return
      end
      local fallbackVerts = lineQuadVertsInto(lineFallbackVertsScratch, x1, y1, x2, y2, strokeWidth, noCaps, 0)
      local __lux_tmp_fallbackVerts_60 = fallbackVerts
      if __lux_tmp_fallbackVerts_60 == nil then
        __lux_tmp_fallbackVerts_60 = verts
      end
      return drawLineFallbackVerts(__lux_tmp_fallbackVerts_60, fill, nil, shadow, outerGlow)
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
        local __lux_tmp_fillInput_61 = fillInput
        if __lux_tmp_fillInput_61 == nil then
          __lux_tmp_fillInput_61 = defaultLineColor
        end
        fill = style.fillFromStyle(__lux_tmp_fillInput_61)
      end
      if not hotFillVisible(fill) and backdrop == nil then
        return
      end
      local __lux_cmp_62 = false
      if mathAbs(y2 - y1) ~= nil then
        __lux_cmp_62 = mathAbs(y2 - y1) < 0.001
      end
      if __lux_cmp_62 then
        local x = mathMin(x1, x2)
        local w = mathAbs(x2 - x1)
        if w <= 0 then
          return
        end
        local y = y1 - strokeWidth * 0.5
        if radius ~= nil or shadow ~= nil or outerGlow ~= nil then
          return drawLineRectRaw(x, y, w, strokeWidth, fill, radius, shadow, outerGlow, backdrop)
        end
      end
      local __lux_cmp_63 = false
      if mathAbs(x2 - x1) ~= nil then
        __lux_cmp_63 = mathAbs(x2 - x1) < 0.001
      end
      if __lux_cmp_63 then
        local y = mathMin(y1, y2)
        local h = mathAbs(y2 - y1)
        if h <= 0 then
          return
        end
        local x = x1 - strokeWidth * 0.5
        if radius ~= nil or shadow ~= nil or outerGlow ~= nil then
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
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local __lux_tmp_fill_64 = resolved.fill
      if __lux_tmp_fill_64 == nil then
        __lux_tmp_fill_64 = resolved.color
      end
      if __lux_tmp_fill_64 == nil then
        __lux_tmp_fill_64 = color
      end
      local __lux_tmp_width_65 = width
      if __lux_tmp_width_65 == nil then
        __lux_tmp_width_65 = resolved.width
      end
      if __lux_tmp_width_65 == nil then
        __lux_tmp_width_65 = resolved.strokeWidth
      end
      return drawLineRaw(
        x1,
        y1,
        x2,
        y2,
        __lux_tmp_fill_64,
        __lux_tmp_width_65,
        resolved.radius,
        resolved.shadow,
        resolved.outerGlow,
        resolved.backdrop,
        resolved.noCaps == true or resolved.caps == false
      )
    end
    lineEx = function(x1, y1, x2, y2, drawStyle)
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local transform, stripped = splitStyleTransform(resolved)
      if transform == nil then
        local __lux_tmp_fill_66 = stripped.fill
        if __lux_tmp_fill_66 == nil then
          __lux_tmp_fill_66 = stripped.color
        end
        local __lux_tmp_width_67 = stripped.width
        if __lux_tmp_width_67 == nil then
          __lux_tmp_width_67 = stripped.strokeWidth
        end
        return drawLineRaw(
          x1,
          y1,
          x2,
          y2,
          __lux_tmp_fill_66,
          __lux_tmp_width_67,
          stripped.radius,
          stripped.shadow,
          stripped.outerGlow,
          stripped.backdrop,
          stripped.noCaps == true or stripped.caps == false
        )
      end
      local width
      do
        local __lux_tmp_width_68 = stripped.width
        if __lux_tmp_width_68 == nil then
          __lux_tmp_width_68 = stripped.strokeWidth
        end
        width = mathMax(1, style.strokeWidth(__lux_tmp_width_68, 1))
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
          local __lux_tmp_fill_69 = stripped.fill
          if __lux_tmp_fill_69 == nil then
            __lux_tmp_fill_69 = stripped.color
          end
          local __lux_tmp_width_70 = stripped.width
          if __lux_tmp_width_70 == nil then
            __lux_tmp_width_70 = stripped.strokeWidth
          end
          return drawLineRaw(
            x1,
            y1,
            x2,
            y2,
            __lux_tmp_fill_69,
            __lux_tmp_width_70,
            stripped.radius,
            stripped.shadow,
            stripped.outerGlow,
            stripped.backdrop,
            stripped.noCaps == true or stripped.caps == false
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
    lineNoCaps = function(x1, y1, x2, y2, width, fill)
      if width == nil then
        width = 1
      end
      return drawLineRaw(x1, y1, x2, y2, fill, width, nil, nil, nil, nil, true)
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
        local __lux_tmp_pad_71 = toNumber(pad)
        if __lux_tmp_pad_71 == nil then
          __lux_tmp_pad_71 = 1
        end
        pad = mathMax(1, __lux_tmp_pad_71)
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
      local __lux_tmp_intensity_72 = intensity
      if __lux_tmp_intensity_72 == nil then
        __lux_tmp_intensity_72 = 1
      end
      local __lux_tmp_radius_73 = toNumber(radius)
      if __lux_tmp_radius_73 == nil then
        __lux_tmp_radius_73 = 0
      end
      return setupParamMatrix(
        material,
        vertical and 1 or 0,
        __lux_tmp_intensity_72,
        0,
        0,
        w,
        h,
        0,
        mathMax(0, __lux_tmp_radius_73),
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
    drawBlurredPoly = function(poly, material, amount, recapture, level)
      if recapture == nil then
        recapture = false
      end
      if level == nil then
        level = 0
      end
      if material == nil then
        return false
      end
      prepareBackdropBlur(amount, recapture, level)
      surfaceSetDrawColor(255, 255, 255, 255)
      setupPrimitiveBlurConstants(material, poly.w, poly.h, true, 0, 0)
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
        local __lux_tmp_a_74 = tint.a
        if __lux_tmp_a_74 == nil then
          __lux_tmp_a_74 = 255
        end
        local __lux_tmp_opacity_75 = spec.opacity
        if __lux_tmp_opacity_75 == nil then
          __lux_tmp_opacity_75 = 1
        end
        alpha = __lux_tmp_a_74 * __lux_tmp_opacity_75
      end
      if alpha <= 0 then
        return nil
      end
      do
        local __lux_tmp_r_76 = tint.r
        if __lux_tmp_r_76 == nil then
          __lux_tmp_r_76 = 0
        end
        polyBackdropTintScratch.r = __lux_tmp_r_76
      end
      do
        local __lux_tmp_g_77 = tint.g
        if __lux_tmp_g_77 == nil then
          __lux_tmp_g_77 = 0
        end
        polyBackdropTintScratch.g = __lux_tmp_g_77
      end
      do
        local __lux_tmp_b_78 = tint.b
        if __lux_tmp_b_78 == nil then
          __lux_tmp_b_78 = 0
        end
        polyBackdropTintScratch.b = __lux_tmp_b_78
      end
      polyBackdropTintScratch.a = mathFloor(mathClamp(alpha, 0, 255) + 0.5)
      return polyBackdropTintScratch
    end
    drawPolyBackdrop = function(poly, spec)
      if spec == nil then
        return nil
      end
      local pad
      do
        local __lux_tmp_padding_79 = toNumber(spec.padding)
        if __lux_tmp_padding_79 == nil then
          __lux_tmp_padding_79 = 0
        end
        pad = mathMax(0, __lux_tmp_padding_79)
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
          spec.blur,
          spec.recapture,
          spec.level
        )
      end
      local tint = polyBackdropTintColor(spec)
      if tint ~= nil then
        local material = primitiveMaterials[polyMaterialKey(backdropPoly)]
        if materialOK(material) then
          polyBackdropFill.colorA = tint
          polyBackdropFill.colorB = tint
          setupPrimitiveFillConstants(
            material,
            backdropPoly.w,
            backdropPoly.h,
            polyBackdropFill,
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
      if not enabled or alpha <= 0 or strength <= 0 then
        return nil
      end
      do
        local __lux_tmp_width_80 = toNumber(width)
        if __lux_tmp_width_80 == nil then
          __lux_tmp_width_80 = 12
        end
        width = mathMax(0.001, __lux_tmp_width_80)
      end
      do
        local __lux_tmp_grow_81 = toNumber(grow)
        if __lux_tmp_grow_81 == nil then
          __lux_tmp_grow_81 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_81)
      end
      do
        local __lux_tmp_extent_82 = toNumber(extent)
        if __lux_tmp_extent_82 == nil then
          __lux_tmp_extent_82 = width
        end
        extent = mathMax(1, __lux_tmp_extent_82)
      end
      local padding = grow + mathMax(extent, width)
      do
        local __lux_tmp_ox_83 = toNumber(ox)
        if __lux_tmp_ox_83 == nil then
          __lux_tmp_ox_83 = 0
        end
        ox = __lux_tmp_ox_83
      end
      do
        local __lux_tmp_oy_84 = toNumber(oy)
        if __lux_tmp_oy_84 == nil then
          __lux_tmp_oy_84 = 0
        end
        oy = __lux_tmp_oy_84
      end
      do
        local __lux_tmp_falloff_85 = toNumber(falloff)
        if __lux_tmp_falloff_85 == nil then
          __lux_tmp_falloff_85 = 1.7
        end
        falloff = mathMax(0.001, __lux_tmp_falloff_85)
      end
      do
        local __lux_tmp_strength_86 = toNumber(strength)
        if __lux_tmp_strength_86 == nil then
          __lux_tmp_strength_86 = 1
        end
        strength = mathMax(0, __lux_tmp_strength_86)
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
      if material == nil or paramMatrixSetUnpacked == nil or matrixCtor == nil then
        return false
      end
      local matrix = auxParamMatrices[material]
      if matrix == nil then
        matrix = matrixCtor()
        auxParamMatrices[material] = matrix
      end
      do
        local __lux_tmp_a0_87 = a0
        if __lux_tmp_a0_87 == nil then
          __lux_tmp_a0_87 = 0
        end
        local __lux_tmp_b0_88 = b0
        if __lux_tmp_b0_88 == nil then
          __lux_tmp_b0_88 = 0
        end
        local __lux_tmp_c0_89 = c0
        if __lux_tmp_c0_89 == nil then
          __lux_tmp_c0_89 = 0
        end
        local __lux_tmp_d0_90 = d0
        if __lux_tmp_d0_90 == nil then
          __lux_tmp_d0_90 = 0
        end
        local __lux_tmp_a1_91 = a1
        if __lux_tmp_a1_91 == nil then
          __lux_tmp_a1_91 = 0
        end
        local __lux_tmp_b1_92 = b1
        if __lux_tmp_b1_92 == nil then
          __lux_tmp_b1_92 = 0
        end
        local __lux_tmp_c1_93 = c1
        if __lux_tmp_c1_93 == nil then
          __lux_tmp_c1_93 = 0
        end
        local __lux_tmp_d1_94 = d1
        if __lux_tmp_d1_94 == nil then
          __lux_tmp_d1_94 = 0
        end
        local __lux_tmp_a2_95 = a2
        if __lux_tmp_a2_95 == nil then
          __lux_tmp_a2_95 = 0
        end
        local __lux_tmp_b2_96 = b2
        if __lux_tmp_b2_96 == nil then
          __lux_tmp_b2_96 = 0
        end
        local __lux_tmp_c2_97 = c2
        if __lux_tmp_c2_97 == nil then
          __lux_tmp_c2_97 = 0
        end
        local __lux_tmp_d2_98 = d2
        if __lux_tmp_d2_98 == nil then
          __lux_tmp_d2_98 = 0
        end
        local __lux_tmp_a3_99 = a3
        if __lux_tmp_a3_99 == nil then
          __lux_tmp_a3_99 = 0
        end
        local __lux_tmp_b3_100 = b3
        if __lux_tmp_b3_100 == nil then
          __lux_tmp_b3_100 = 0
        end
        local __lux_tmp_c3_101 = c3
        if __lux_tmp_c3_101 == nil then
          __lux_tmp_c3_101 = 0
        end
        local __lux_tmp_d3_102 = d3
        if __lux_tmp_d3_102 == nil then
          __lux_tmp_d3_102 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_a0_87,
          __lux_tmp_b0_88,
          __lux_tmp_c0_89,
          __lux_tmp_d0_90,
          __lux_tmp_a1_91,
          __lux_tmp_b1_92,
          __lux_tmp_c1_93,
          __lux_tmp_d1_94,
          __lux_tmp_a2_95,
          __lux_tmp_b2_96,
          __lux_tmp_c2_97,
          __lux_tmp_d2_98,
          __lux_tmp_a3_99,
          __lux_tmp_b3_100,
          __lux_tmp_c3_101,
          __lux_tmp_d3_102
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
    setupPolyWornPatternExtraParams = function(material, spec, angle)
      local edgeColor = style.asColor(spec.edgeColor, style.DEFAULT_WORN_EDGE_COLOR)
      local er, eg, eb, ea = style.color01(edgeColor)
      local __lux_tmp_fractal_103 = toNumber(spec.fractal)
      if __lux_tmp_fractal_103 == nil then
        __lux_tmp_fractal_103 = 0.44
      end
      local __lux_tmp_grain_104 = toNumber(spec.grain)
      if __lux_tmp_grain_104 == nil then
        __lux_tmp_grain_104 = 0.64
      end
      local __lux_tmp_scratches_105 = spec.scratches
      if __lux_tmp_scratches_105 == nil then
        __lux_tmp_scratches_105 = spec.scratch
      end
      local __lux_tmp_scratches_106 = toNumber(__lux_tmp_scratches_105)
      if __lux_tmp_scratches_106 == nil then
        __lux_tmp_scratches_106 = 0.30
      end
      local __lux_tmp_edge_107 = spec.edge
      if __lux_tmp_edge_107 == nil then
        __lux_tmp_edge_107 = spec.edgeWear
      end
      local __lux_tmp_edge_108 = toNumber(__lux_tmp_edge_107)
      if __lux_tmp_edge_108 == nil then
        __lux_tmp_edge_108 = 0.54
      end
      local __lux_tmp_grainScale_109 = toNumber(spec.grainScale)
      if __lux_tmp_grainScale_109 == nil then
        __lux_tmp_grainScale_109 = 5.6
      end
      local __lux_tmp_scratchScale_110 = toNumber(spec.scratchScale)
      if __lux_tmp_scratchScale_110 == nil then
        __lux_tmp_scratchScale_110 = 26
      end
      local __lux_tmp_scratchWidth_111 = toNumber(spec.scratchWidth)
      if __lux_tmp_scratchWidth_111 == nil then
        __lux_tmp_scratchWidth_111 = 0.045
      end
      local __lux_tmp_edgeWidth_112 = toNumber(spec.edgeWidth)
      if __lux_tmp_edgeWidth_112 == nil then
        __lux_tmp_edgeWidth_112 = 7
      end
      local __lux_tmp_softness_113 = toNumber(spec.softness)
      if __lux_tmp_softness_113 == nil then
        __lux_tmp_softness_113 = 0.10
      end
      local __lux_tmp_warp_114 = toNumber(spec.warp)
      if __lux_tmp_warp_114 == nil then
        __lux_tmp_warp_114 = 0.035
      end
      return setupPolyShadowAuxConstants(
        material,
        er,
        eg,
        eb,
        ea,
        mathClamp(__lux_tmp_fractal_103, 0, 1),
        mathClamp(__lux_tmp_grain_104, 0, 1),
        mathClamp(__lux_tmp_scratches_106, 0, 1),
        mathClamp(__lux_tmp_edge_108, 0, 1),
        mathMax(0.25, __lux_tmp_grainScale_109),
        mathMax(1, __lux_tmp_scratchScale_110),
        mathClamp(__lux_tmp_scratchWidth_111, 0.005, 0.5),
        mathMax(0.5, __lux_tmp_edgeWidth_112),
        mathCos(angle),
        mathSin(angle),
        mathClamp(__lux_tmp_softness_113, 0.001, 1),
        mathMax(0, __lux_tmp_warp_114)
      )
    end
    drawPolyPatternPrepared = function(poly, spec)
      if spec == nil or not shadersActive() or not materialOK(primitiveMaterials.poly_pattern) then
        return false
      end
      local color = spec.color
      if color == nil then
        color = spec.tint
      end
      local __lux_tmp_117 = color ~= nil
      if __lux_tmp_117 then
        local __lux_tmp_a_116 = color.a
        if __lux_tmp_a_116 == nil then
          __lux_tmp_a_116 = 255
        end
        __lux_tmp_117 = __lux_tmp_a_116 <= 0
      end
      if __lux_tmp_117 then
        return false
      end
      local material = primitiveMaterials.poly_pattern
      local r, g, b, a
      do
        local __lux_tmp_color_118 = spec.color
        if __lux_tmp_color_118 == nil then
          __lux_tmp_color_118 = spec.tint
        end
        r, g, b, a = style.color01(style.asColor(__lux_tmp_color_118, style.DEFAULT_PATTERN_COLOR))
      end
      local angle
      do
        local __lux_tmp_angle_119 = toNumber(spec.angle)
        if __lux_tmp_angle_119 == nil then
          __lux_tmp_angle_119 = 135
        end
        angle = mathRad(__lux_tmp_angle_119)
      end
      local smoke
      local __lux_match_120 = spec.kind
      if __lux_match_120 == "smoke" then
        smoke = true
      else
        smoke = false
      end
      local worn
      local __lux_match_121 = spec.kind
      if __lux_match_121 == "worn" then
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
          local __lux_tmp_scale_122 = toNumber(spec.scale)
          if __lux_tmp_scale_122 == nil then
            __lux_tmp_scale_122 = 32
          end
          pz = mathMax(1, __lux_tmp_scale_122)
        end
        do
          local __lux_tmp_edgeWidth_123 = toNumber(spec.edgeWidth)
          if __lux_tmp_edgeWidth_123 == nil then
            __lux_tmp_edgeWidth_123 = 7
          end
          pw = mathMax(0.5, __lux_tmp_edgeWidth_123)
        end
        ox = roundrect.patternOffset(spec)
        oy = 2
        do
          local __lux_tmp_softness_124 = toNumber(spec.softness)
          if __lux_tmp_softness_124 == nil then
            __lux_tmp_softness_124 = 0.10
          end
          oz = mathClamp(__lux_tmp_softness_124, 0.001, 1)
        end
        do
          local __lux_tmp_warp_125 = toNumber(spec.warp)
          if __lux_tmp_warp_125 == nil then
            __lux_tmp_warp_125 = 0.035
          end
          ow = mathMax(0, __lux_tmp_warp_125)
        end
      else
        if smoke then
          do
            local __lux_tmp_scale_126 = toNumber(spec.scale)
            if __lux_tmp_scale_126 == nil then
              __lux_tmp_scale_126 = 140
            end
            pz = mathMax(1, __lux_tmp_scale_126)
          end
          do
            local __lux_tmp_density_127 = toNumber(spec.density)
            if __lux_tmp_density_127 == nil then
              __lux_tmp_density_127 = 0.48
            end
            pw = mathClamp(__lux_tmp_density_127, 0, 1)
          end
          ox = roundrect.patternOffset(spec)
          oy = 1
          do
            local __lux_tmp_softness_128 = toNumber(spec.softness)
            if __lux_tmp_softness_128 == nil then
              __lux_tmp_softness_128 = 0.3
            end
            oz = mathMax(0.001, __lux_tmp_softness_128)
          end
          do
            local __lux_tmp_warp_129 = toNumber(spec.warp)
            if __lux_tmp_warp_129 == nil then
              __lux_tmp_warp_129 = 0.85
            end
            ow = mathMax(0, __lux_tmp_warp_129)
          end
        else
          do
            local __lux_tmp_spacing_130 = toNumber(spec.spacing)
            if __lux_tmp_spacing_130 == nil then
              __lux_tmp_spacing_130 = 12
            end
            pz = mathMax(1, __lux_tmp_spacing_130)
          end
          do
            local __lux_tmp_width_131 = toNumber(spec.width)
            if __lux_tmp_width_131 == nil then
              __lux_tmp_width_131 = 2
            end
            pw = mathMax(0.25, __lux_tmp_width_131)
          end
          ox = roundrect.patternOffset(spec)
        end
      end
      do
        local __lux_tmp_133 = smoke or worn
        if __lux_tmp_133 then
          local __lux_tmp_seed_132 = toNumber(spec.seed)
          if __lux_tmp_seed_132 == nil then
            __lux_tmp_seed_132 = 0
          end
          __lux_tmp_133 = __lux_tmp_seed_132
        end
        local __lux_tmp_134 = __lux_tmp_133
        if not __lux_tmp_134 then
          __lux_tmp_134 = 0
        end
        setupParamMatrix(
          material,
          r,
          g,
          b,
          a,
          poly.w,
          poly.h,
          __lux_tmp_134,
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
      if worn then
        setupPolyWornPatternExtraParams(material, spec, angle)
      end
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTransformedPoly(polyDrawVerts(poly))
      return true
    end
    drawPolyPattern = function(poly, pattern)
      return drawPolyPatternPrepared(poly, roundrect.patternStyle(pattern))
    end
    setupPolyStrokeConstants = function(material, poly, color, strokeWidth, strokeKind, strokeLength, strokeGap, strokeOffset)
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
        strokeKind,
        strokeLength,
        strokeGap,
        strokeOffset,
        0,
        0,
        0,
        0,
        0
      )
      return drawRect
    end
    drawPolyStrokeShader = function(poly, color, strokeWidth, strokeKind, strokeLength, strokeGap, strokeOffset)
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
      if not shadersActive() then
        return false
      end
      local material = primitiveMaterials[polyMaterialKey(poly, "_stroke")]
      if not materialOK(material) then
        return false
      end
      local drawRect = setupPolyStrokeConstants(
        material,
        poly,
        color,
        strokeWidth,
        strokeKind,
        strokeLength,
        strokeGap,
        strokeOffset
      )
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
    drawPolyStroke = function(poly, color, strokeWidth, strokeKind, strokeLength, strokeGap, strokeOffset)
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
      if drawPolyStrokeShader(
        poly,
        color,
        strokeWidth,
        strokeKind,
        strokeLength,
        strokeGap,
        strokeOffset
      ) then
        return
      end
      return roundrect.drawStrokePath(
        poly.points,
        true,
        color,
        strokeWidth,
        strokeKind,
        strokeLength,
        strokeGap,
        strokeOffset,
        poly.x,
        poly.y
      )
    end
    drawPolyFallbackPrepared = function(points, fill, hasFill, stroke, strokeWidth, hasStroke, strokeKind, strokeLength, strokeGap, strokeOffset)
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
      if hasFill then
        style.setDrawColor(fillColor(fill))
        drawTransformedPoly(points)
      end
      if hasStroke then
        roundrect.drawStrokePath(
          points,
          true,
          stroke,
          strokeWidth,
          strokeKind,
          strokeLength,
          strokeGap,
          strokeOffset
        )
      end
    end
    drawPolyFallbackRaw = function(points, fillInput, stroke, strokeWidthInput)
      local fill = style.fillFromStyle(fillInput)
      local hasStroke, strokeColor, strokeWidth, strokeKind, strokeLength, strokeGap, strokeOffset = style.strokeRaw(stroke, strokeWidthInput)
      return drawPolyFallbackPrepared(
        points,
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
    drawPolyRawNormalized = function(points, poly, fillInput, stroke, strokeWidthInput, shadow, outerGlow, backdropInput, pattern)
      local hasShadow = false
      local sr = 0
      local sg = 0
      local sb = 0
      local sa = 0
      local shadowX = 0
      local shadowY = 0
      local shadowWidth = 1
      local shadowGrow = 0
      local shadowStrength = 0
      local shadowFalloff = 1
      local shadowExtent = 0
      if shadow ~= nil and shadow ~= false then
        hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, _, shadowGrow, shadowStrength, shadowFalloff, shadowExtent = roundrect.shadowRaw(shadow)
      end
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
      local hasOuter = false
      local orr = 0
      local og = 0
      local ob = 0
      local oa = 0
      local outerX = 0
      local outerY = 0
      local outerWidth = 1
      local outerGrow = 0
      local outerStrength = 0
      local outerFalloff = 1
      local outerExtent = 0
      if outerGlow ~= nil and outerGlow ~= false then
        hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, _, outerGrow, outerStrength, outerFalloff, outerExtent = roundrect.outerGlowRaw(outerGlow)
      end
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
      local backdrop
      if backdropInput ~= nil and backdropInput ~= false then
        backdrop = style.backdropStyle(backdropInput)
      else
        backdrop = nil
      end
      local patternSpec
      if pattern ~= nil and pattern ~= false then
        patternSpec = roundrect.patternStyle(pattern)
      else
        patternSpec = nil
      end
      local hasStroke, strokeColor, strokeWidth, strokeKind, strokeLength, strokeGap, strokeOffset = style.strokeRaw(stroke, strokeWidthInput)
      local strokePad
      if hasStroke then
        strokePad = strokeWidth * 0.5 + 1
      else
        strokePad = 0
      end
      local cullX = poly.x - strokePad
      local cullY = poly.y - strokePad
      local cullW = poly.w + strokePad * 2
      local cullH = poly.h + strokePad * 2
      cullX, cullY, cullW, cullH = includeBounds(cullX, cullY, cullW, cullH, shadowBounds)
      cullX, cullY, cullW, cullH = includeBounds(cullX, cullY, cullW, cullH, outerBounds)
      if backdrop ~= nil then
        local pad
        do
          local __lux_tmp_padding_135 = toNumber(backdrop.padding)
          if __lux_tmp_padding_135 == nil then
            __lux_tmp_padding_135 = 0
          end
          pad = mathMax(0, __lux_tmp_padding_135)
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
      local fill = style.fillFromStyle(fillInput)
      local hasFill = hotFillVisible(fill)
      if not shadersActive() then
        return drawPolyFallbackPrepared(
          points,
          fill,
          hasFill,
          strokeColor,
          strokeWidth,
          hasStroke,
          strokeKind,
          strokeLength,
          strokeGap,
          strokeOffset
        )
      end
      drawPolyShadow(poly, shadowBounds, sr, sg, sb, sa)
      drawPolyOuterGlow(poly, outerBounds, orr, og, ob, oa)
      drawPolyBackdrop(poly, backdrop)
      local material = primitiveMaterials[polyMaterialKey(poly)]
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
          drawPolyFallbackPrepared(points, fill, true, nil, 0, false)
        end
      end
      drawPolyPatternPrepared(poly, patternSpec)
      if hasStroke then
        drawPolyStroke(
          poly,
          strokeColor,
          strokeWidth,
          strokeKind,
          strokeLength,
          strokeGap,
          strokeOffset
        )
      end
    end
    drawPolyImmediateNormalized = function(points, drawStyle, poly)
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local __lux_tmp_fill_136 = resolved.fill
      if __lux_tmp_fill_136 == nil then
        __lux_tmp_fill_136 = resolved.color
      end
      return drawPolyRawNormalized(
        points,
        poly,
        __lux_tmp_fill_136,
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
      local __lux_match_137 = fill
      local __lux_tag_138
      if __lux_match_137 ~= nil then
        __lux_tag_138 = __lux_match_137.kind
      end
      if __lux_tag_138 == style.FILL_LINEAR then
        local x1 = __lux_match_137.x1
        local y1 = __lux_match_137.y1
        local x2 = __lux_match_137.x2
        local y2 = __lux_match_137.y2
        do
          local __lux_tmp_x1_139 = x1
          if __lux_tmp_x1_139 == nil then
            __lux_tmp_x1_139 = 0
          end
          p0 = __lux_tmp_x1_139
        end
        do
          local __lux_tmp_y1_140 = y1
          if __lux_tmp_y1_140 == nil then
            __lux_tmp_y1_140 = 0
          end
          p1 = __lux_tmp_y1_140
        end
        do
          local __lux_tmp_x2_141 = x2
          if __lux_tmp_x2_141 == nil then
            __lux_tmp_x2_141 = 1
          end
          p2 = __lux_tmp_x2_141
        end
        do
          local __lux_tmp_y2_142 = y2
          if __lux_tmp_y2_142 == nil then
            __lux_tmp_y2_142 = 1
          end
          p3 = __lux_tmp_y2_142
        end
        style.bindGradientLut(material, fill)
      elseif __lux_tag_138 == style.FILL_RADIAL then
        local cx = __lux_match_137.cx
        local cy = __lux_match_137.cy
        local radius = __lux_match_137.radius
        local radiusX = __lux_match_137.radiusX
        local radiusY = __lux_match_137.radiusY
        do
          local __lux_tmp_cx_143 = cx
          if __lux_tmp_cx_143 == nil then
            __lux_tmp_cx_143 = 0.5
          end
          p0 = __lux_tmp_cx_143
        end
        do
          local __lux_tmp_cy_144 = cy
          if __lux_tmp_cy_144 == nil then
            __lux_tmp_cy_144 = 0.5
          end
          p1 = __lux_tmp_cy_144
        end
        do
          local __lux_tmp_radiusX_145 = radiusX
          if __lux_tmp_radiusX_145 == nil then
            __lux_tmp_radiusX_145 = radius
          end
          if __lux_tmp_radiusX_145 == nil then
            __lux_tmp_radiusX_145 = 0.5
          end
          p2 = __lux_tmp_radiusX_145
        end
        do
          local __lux_tmp_radiusY_146 = radiusY
          if __lux_tmp_radiusY_146 == nil then
            __lux_tmp_radiusY_146 = 0
          end
          p3 = __lux_tmp_radiusY_146
        end
        style.bindGradientLut(material, fill)
      elseif __lux_tag_138 == style.FILL_CONIC then
        local cx = __lux_match_137.cx
        local cy = __lux_match_137.cy
        local rotation = __lux_match_137.rotation
        do
          local __lux_tmp_cx_147 = cx
          if __lux_tmp_cx_147 == nil then
            __lux_tmp_cx_147 = 0.5
          end
          p0 = __lux_tmp_cx_147
        end
        do
          local __lux_tmp_cy_148 = cy
          if __lux_tmp_cy_148 == nil then
            __lux_tmp_cy_148 = 0.5
          end
          p1 = __lux_tmp_cy_148
        end
        p2 = style.normalizedRotation(rotation)
        p3 = 0
        style.bindGradientLut(material, fill)
      else
        local __lux_unused_149 = nil
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
        local __lux_tmp_a0_150 = a0
        if __lux_tmp_a0_150 == nil then
          __lux_tmp_a0_150 = 0
        end
        local __lux_tmp_b0_151 = b0
        if __lux_tmp_b0_151 == nil then
          __lux_tmp_b0_151 = 0
        end
        local __lux_tmp_c0_152 = c0
        if __lux_tmp_c0_152 == nil then
          __lux_tmp_c0_152 = 0
        end
        local __lux_tmp_d0_153 = d0
        if __lux_tmp_d0_153 == nil then
          __lux_tmp_d0_153 = 0
        end
        local __lux_tmp_a1_154 = a1
        if __lux_tmp_a1_154 == nil then
          __lux_tmp_a1_154 = 0
        end
        local __lux_tmp_b1_155 = b1
        if __lux_tmp_b1_155 == nil then
          __lux_tmp_b1_155 = 0
        end
        local __lux_tmp_c1_156 = c1
        if __lux_tmp_c1_156 == nil then
          __lux_tmp_c1_156 = 0
        end
        local __lux_tmp_d1_157 = d1
        if __lux_tmp_d1_157 == nil then
          __lux_tmp_d1_157 = 0
        end
        local __lux_tmp_a2_158 = a2
        if __lux_tmp_a2_158 == nil then
          __lux_tmp_a2_158 = 0
        end
        local __lux_tmp_b2_159 = b2
        if __lux_tmp_b2_159 == nil then
          __lux_tmp_b2_159 = 0
        end
        local __lux_tmp_c2_160 = c2
        if __lux_tmp_c2_160 == nil then
          __lux_tmp_c2_160 = 0
        end
        local __lux_tmp_d2_161 = d2
        if __lux_tmp_d2_161 == nil then
          __lux_tmp_d2_161 = 0
        end
        local __lux_tmp_a3_162 = a3
        if __lux_tmp_a3_162 == nil then
          __lux_tmp_a3_162 = 0
        end
        local __lux_tmp_b3_163 = b3
        if __lux_tmp_b3_163 == nil then
          __lux_tmp_b3_163 = 0
        end
        local __lux_tmp_c3_164 = c3
        if __lux_tmp_c3_164 == nil then
          __lux_tmp_c3_164 = 0
        end
        local __lux_tmp_d3_165 = d3
        if __lux_tmp_d3_165 == nil then
          __lux_tmp_d3_165 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_a0_150,
          __lux_tmp_b0_151,
          __lux_tmp_c0_152,
          __lux_tmp_d0_153,
          __lux_tmp_a1_154,
          __lux_tmp_b1_155,
          __lux_tmp_c1_156,
          __lux_tmp_d1_157,
          __lux_tmp_a2_158,
          __lux_tmp_b2_159,
          __lux_tmp_c2_160,
          __lux_tmp_d2_161,
          __lux_tmp_a3_162,
          __lux_tmp_b3_163,
          __lux_tmp_c3_164,
          __lux_tmp_d3_165
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
      local packedStyle = mathClamp(style.strokeWidth(strokeWidth, 0), 0, 255) + mathClamp(fillKind, 0, 3) * 256 + style.gradientCurve(fill.curve) * 1024
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
    setupChamferWornPatternExtraParams = function(material, spec, angle)
      local edgeColor = style.asColor(spec.edgeColor, style.DEFAULT_WORN_EDGE_COLOR)
      local er, eg, eb, ea = style.color01(edgeColor)
      local __lux_tmp_fractal_166 = toNumber(spec.fractal)
      if __lux_tmp_fractal_166 == nil then
        __lux_tmp_fractal_166 = 0.44
      end
      local __lux_tmp_grain_167 = toNumber(spec.grain)
      if __lux_tmp_grain_167 == nil then
        __lux_tmp_grain_167 = 0.64
      end
      local __lux_tmp_scratches_168 = spec.scratches
      if __lux_tmp_scratches_168 == nil then
        __lux_tmp_scratches_168 = spec.scratch
      end
      local __lux_tmp_scratches_169 = toNumber(__lux_tmp_scratches_168)
      if __lux_tmp_scratches_169 == nil then
        __lux_tmp_scratches_169 = 0.30
      end
      local __lux_tmp_edge_170 = spec.edge
      if __lux_tmp_edge_170 == nil then
        __lux_tmp_edge_170 = spec.edgeWear
      end
      local __lux_tmp_edge_171 = toNumber(__lux_tmp_edge_170)
      if __lux_tmp_edge_171 == nil then
        __lux_tmp_edge_171 = 0.54
      end
      local __lux_tmp_grainScale_172 = toNumber(spec.grainScale)
      if __lux_tmp_grainScale_172 == nil then
        __lux_tmp_grainScale_172 = 5.6
      end
      local __lux_tmp_scratchScale_173 = toNumber(spec.scratchScale)
      if __lux_tmp_scratchScale_173 == nil then
        __lux_tmp_scratchScale_173 = 26
      end
      local __lux_tmp_scratchWidth_174 = toNumber(spec.scratchWidth)
      if __lux_tmp_scratchWidth_174 == nil then
        __lux_tmp_scratchWidth_174 = 0.045
      end
      local __lux_tmp_edgeWidth_175 = toNumber(spec.edgeWidth)
      if __lux_tmp_edgeWidth_175 == nil then
        __lux_tmp_edgeWidth_175 = 7
      end
      local __lux_tmp_softness_176 = toNumber(spec.softness)
      if __lux_tmp_softness_176 == nil then
        __lux_tmp_softness_176 = 0.10
      end
      local __lux_tmp_warp_177 = toNumber(spec.warp)
      if __lux_tmp_warp_177 == nil then
        __lux_tmp_warp_177 = 0.035
      end
      return setupPrimitiveAuxConstants(
        material,
        er,
        eg,
        eb,
        ea,
        mathClamp(__lux_tmp_fractal_166, 0, 1),
        mathClamp(__lux_tmp_grain_167, 0, 1),
        mathClamp(__lux_tmp_scratches_169, 0, 1),
        mathClamp(__lux_tmp_edge_171, 0, 1),
        mathMax(0.25, __lux_tmp_grainScale_172),
        mathMax(1, __lux_tmp_scratchScale_173),
        mathClamp(__lux_tmp_scratchWidth_174, 0.005, 0.5),
        mathMax(0.5, __lux_tmp_edgeWidth_175),
        mathCos(angle),
        mathSin(angle),
        mathClamp(__lux_tmp_softness_176, 0.001, 1),
        mathMax(0, __lux_tmp_warp_177)
      )
    end
    drawChamferInnerGlowRaw = function(x, y, w, h, cuts, enabled, gr, gg, gb, ga, glowWidth, glowStrength, glowFalloff)
      if not enabled or ga <= 0 or glowStrength <= 0 or not shadersActive() or not materialOK(primitiveMaterials.chamfer_innerglow) then
        return false
      end
      local tl, tr, br, bl = chamferTuple(cuts, w, h)
      local material = primitiveMaterials.chamfer_innerglow
      do
        local __lux_tmp_glowWidth_178 = toNumber(glowWidth)
        if __lux_tmp_glowWidth_178 == nil then
          __lux_tmp_glowWidth_178 = 8
        end
        local __lux_tmp_glowStrength_179 = toNumber(glowStrength)
        if __lux_tmp_glowStrength_179 == nil then
          __lux_tmp_glowStrength_179 = 1
        end
        local __lux_tmp_glowFalloff_180 = toNumber(glowFalloff)
        if __lux_tmp_glowFalloff_180 == nil then
          __lux_tmp_glowFalloff_180 = 1.65
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
          mathMax(0.001, __lux_tmp_glowWidth_178),
          mathMax(0, __lux_tmp_glowStrength_179),
          mathMax(0.001, __lux_tmp_glowFalloff_180),
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
        local __lux_tmp_grow_181 = toNumber(grow)
        if __lux_tmp_grow_181 == nil then
          __lux_tmp_grow_181 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_181)
      end
      if grow <= 0 then
        return cuts
      end
      if typeOf(cuts) == "table" and not style.isColor(cuts) then
        local __lux_tmp_tl_182 = cuts.tl
        if __lux_tmp_tl_182 == nil then
          __lux_tmp_tl_182 = cuts[1]
        end
        local __lux_tmp_tl_183 = toNumber(__lux_tmp_tl_182)
        if __lux_tmp_tl_183 == nil then
          __lux_tmp_tl_183 = 0
        end
        local __lux_tmp_tr_184 = cuts.tr
        if __lux_tmp_tr_184 == nil then
          __lux_tmp_tr_184 = cuts[2]
        end
        if __lux_tmp_tr_184 == nil then
          __lux_tmp_tr_184 = cuts.tl
        end
        if __lux_tmp_tr_184 == nil then
          __lux_tmp_tr_184 = cuts[1]
        end
        local __lux_tmp_tr_185 = toNumber(__lux_tmp_tr_184)
        if __lux_tmp_tr_185 == nil then
          __lux_tmp_tr_185 = 0
        end
        local __lux_tmp_br_186 = cuts.br
        if __lux_tmp_br_186 == nil then
          __lux_tmp_br_186 = cuts[3]
        end
        if __lux_tmp_br_186 == nil then
          __lux_tmp_br_186 = cuts.tr
        end
        if __lux_tmp_br_186 == nil then
          __lux_tmp_br_186 = cuts[2]
        end
        if __lux_tmp_br_186 == nil then
          __lux_tmp_br_186 = cuts.tl
        end
        if __lux_tmp_br_186 == nil then
          __lux_tmp_br_186 = cuts[1]
        end
        local __lux_tmp_br_187 = toNumber(__lux_tmp_br_186)
        if __lux_tmp_br_187 == nil then
          __lux_tmp_br_187 = 0
        end
        local __lux_tmp_bl_188 = cuts.bl
        if __lux_tmp_bl_188 == nil then
          __lux_tmp_bl_188 = cuts[4]
        end
        if __lux_tmp_bl_188 == nil then
          __lux_tmp_bl_188 = cuts.br
        end
        if __lux_tmp_bl_188 == nil then
          __lux_tmp_bl_188 = cuts[3]
        end
        if __lux_tmp_bl_188 == nil then
          __lux_tmp_bl_188 = cuts.tr
        end
        if __lux_tmp_bl_188 == nil then
          __lux_tmp_bl_188 = cuts[2]
        end
        if __lux_tmp_bl_188 == nil then
          __lux_tmp_bl_188 = cuts.tl
        end
        if __lux_tmp_bl_188 == nil then
          __lux_tmp_bl_188 = cuts[1]
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
      local __lux_tmp_cuts_190 = toNumber(cuts)
      if __lux_tmp_cuts_190 == nil then
        __lux_tmp_cuts_190 = 0
      end
      return __lux_tmp_cuts_190 + grow
    end
    chamferEffectBounds = function(x, y, w, h, cuts, enabled, alpha, ox, oy, width, extent, grow, strength, falloff, biasOffset)
      if biasOffset == nil then
        biasOffset = false
      end
      if not enabled or alpha <= 0 or strength <= 0 then
        return nil
      end
      do
        local __lux_tmp_grow_191 = toNumber(grow)
        if __lux_tmp_grow_191 == nil then
          __lux_tmp_grow_191 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_191)
      end
      do
        local __lux_tmp_ox_192 = toNumber(ox)
        if __lux_tmp_ox_192 == nil then
          __lux_tmp_ox_192 = 0
        end
        ox = __lux_tmp_ox_192
      end
      do
        local __lux_tmp_oy_193 = toNumber(oy)
        if __lux_tmp_oy_193 == nil then
          __lux_tmp_oy_193 = 0
        end
        oy = __lux_tmp_oy_193
      end
      do
        local __lux_tmp_width_194 = toNumber(width)
        if __lux_tmp_width_194 == nil then
          __lux_tmp_width_194 = 18
        end
        width = mathMax(0.001, __lux_tmp_width_194)
      end
      do
        local __lux_tmp_extent_195 = toNumber(extent)
        if __lux_tmp_extent_195 == nil then
          __lux_tmp_extent_195 = width
        end
        extent = mathMax(1, __lux_tmp_extent_195)
      end
      do
        local __lux_tmp_strength_196 = toNumber(strength)
        if __lux_tmp_strength_196 == nil then
          __lux_tmp_strength_196 = 1
        end
        strength = mathMax(0, __lux_tmp_strength_196)
      end
      do
        local __lux_tmp_falloff_197 = toNumber(falloff)
        if __lux_tmp_falloff_197 == nil then
          __lux_tmp_falloff_197 = 1.9
        end
        falloff = mathMax(0.001, __lux_tmp_falloff_197)
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
      if not hasShadow and not hasOuter or not shadersActive() or not materialOK(primitiveMaterials.chamfer_shadow_outer) then
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
      do
        local __lux_tmp_198
        if shadowBounds ~= nil then
          __lux_tmp_198 = shadowBounds.width
        else
          __lux_tmp_198 = 1
        end
        local __lux_tmp_199
        if shadowBounds ~= nil then
          __lux_tmp_199 = shadowBounds.strength
        else
          __lux_tmp_199 = 0
        end
        local __lux_tmp_200
        if shadowBounds ~= nil then
          __lux_tmp_200 = sr
        else
          __lux_tmp_200 = 0
        end
        local __lux_tmp_201
        if shadowBounds ~= nil then
          __lux_tmp_201 = sg
        else
          __lux_tmp_201 = 0
        end
        local __lux_tmp_202
        if shadowBounds ~= nil then
          __lux_tmp_202 = sb
        else
          __lux_tmp_202 = 0
        end
        local __lux_tmp_203
        if shadowBounds ~= nil then
          __lux_tmp_203 = sa
        else
          __lux_tmp_203 = 0
        end
        local __lux_obj_shadowBounds_204 = shadowBounds
        local __lux_tmp_shapeX_205 = nil
        if __lux_obj_shadowBounds_204 ~= nil then
          __lux_tmp_shapeX_205 = __lux_obj_shadowBounds_204.shapeX
        end
        if __lux_tmp_shapeX_205 == nil then
          __lux_tmp_shapeX_205 = x
        end
        local __lux_obj_shadowBounds_206 = shadowBounds
        local __lux_tmp_shapeY_207 = nil
        if __lux_obj_shadowBounds_206 ~= nil then
          __lux_tmp_shapeY_207 = __lux_obj_shadowBounds_206.shapeY
        end
        if __lux_tmp_shapeY_207 == nil then
          __lux_tmp_shapeY_207 = y
        end
        local __lux_obj_shadowBounds_208 = shadowBounds
        local __lux_tmp_shapeW_209 = nil
        if __lux_obj_shadowBounds_208 ~= nil then
          __lux_tmp_shapeW_209 = __lux_obj_shadowBounds_208.shapeW
        end
        if __lux_tmp_shapeW_209 == nil then
          __lux_tmp_shapeW_209 = w
        end
        local __lux_obj_shadowBounds_210 = shadowBounds
        local __lux_tmp_shapeH_211 = nil
        if __lux_obj_shadowBounds_210 ~= nil then
          __lux_tmp_shapeH_211 = __lux_obj_shadowBounds_210.shapeH
        end
        if __lux_tmp_shapeH_211 == nil then
          __lux_tmp_shapeH_211 = h
        end
        local __lux_obj_shadowBounds_212 = shadowBounds
        local __lux_tmp_tl_213 = nil
        if __lux_obj_shadowBounds_212 ~= nil then
          __lux_tmp_tl_213 = __lux_obj_shadowBounds_212.tl
        end
        if __lux_tmp_tl_213 == nil then
          __lux_tmp_tl_213 = 0
        end
        local __lux_obj_shadowBounds_214 = shadowBounds
        local __lux_tmp_tr_215 = nil
        if __lux_obj_shadowBounds_214 ~= nil then
          __lux_tmp_tr_215 = __lux_obj_shadowBounds_214.tr
        end
        if __lux_tmp_tr_215 == nil then
          __lux_tmp_tr_215 = 0
        end
        local __lux_obj_shadowBounds_216 = shadowBounds
        local __lux_tmp_br_217 = nil
        if __lux_obj_shadowBounds_216 ~= nil then
          __lux_tmp_br_217 = __lux_obj_shadowBounds_216.br
        end
        if __lux_tmp_br_217 == nil then
          __lux_tmp_br_217 = 0
        end
        local __lux_obj_shadowBounds_218 = shadowBounds
        local __lux_tmp_bl_219 = nil
        if __lux_obj_shadowBounds_218 ~= nil then
          __lux_tmp_bl_219 = __lux_obj_shadowBounds_218.bl
        end
        if __lux_tmp_bl_219 == nil then
          __lux_tmp_bl_219 = 0
        end
        setupParamMatrix(
          material,
          sw,
          sh,
          __lux_tmp_198,
          __lux_tmp_199,
          __lux_tmp_200,
          __lux_tmp_201,
          __lux_tmp_202,
          __lux_tmp_203,
          __lux_tmp_shapeX_205 - sx,
          __lux_tmp_shapeY_207 - sy,
          __lux_tmp_shapeW_209,
          __lux_tmp_shapeH_211,
          __lux_tmp_tl_213,
          __lux_tmp_tr_215,
          __lux_tmp_br_217,
          __lux_tmp_bl_219
        )
      end
      do
        local __lux_tmp_220
        if outerBounds ~= nil then
          __lux_tmp_220 = orr
        else
          __lux_tmp_220 = 0
        end
        local __lux_tmp_221
        if outerBounds ~= nil then
          __lux_tmp_221 = og
        else
          __lux_tmp_221 = 0
        end
        local __lux_tmp_222
        if outerBounds ~= nil then
          __lux_tmp_222 = ob
        else
          __lux_tmp_222 = 0
        end
        local __lux_tmp_223
        if outerBounds ~= nil then
          __lux_tmp_223 = oa
        else
          __lux_tmp_223 = 0
        end
        local __lux_obj_outerBounds_224 = outerBounds
        local __lux_tmp_shapeX_225 = nil
        if __lux_obj_outerBounds_224 ~= nil then
          __lux_tmp_shapeX_225 = __lux_obj_outerBounds_224.shapeX
        end
        if __lux_tmp_shapeX_225 == nil then
          __lux_tmp_shapeX_225 = x
        end
        local __lux_obj_outerBounds_226 = outerBounds
        local __lux_tmp_shapeY_227 = nil
        if __lux_obj_outerBounds_226 ~= nil then
          __lux_tmp_shapeY_227 = __lux_obj_outerBounds_226.shapeY
        end
        if __lux_tmp_shapeY_227 == nil then
          __lux_tmp_shapeY_227 = y
        end
        local __lux_obj_outerBounds_228 = outerBounds
        local __lux_tmp_shapeW_229 = nil
        if __lux_obj_outerBounds_228 ~= nil then
          __lux_tmp_shapeW_229 = __lux_obj_outerBounds_228.shapeW
        end
        if __lux_tmp_shapeW_229 == nil then
          __lux_tmp_shapeW_229 = w
        end
        local __lux_obj_outerBounds_230 = outerBounds
        local __lux_tmp_shapeH_231 = nil
        if __lux_obj_outerBounds_230 ~= nil then
          __lux_tmp_shapeH_231 = __lux_obj_outerBounds_230.shapeH
        end
        if __lux_tmp_shapeH_231 == nil then
          __lux_tmp_shapeH_231 = h
        end
        local __lux_obj_outerBounds_232 = outerBounds
        local __lux_tmp_tl_233 = nil
        if __lux_obj_outerBounds_232 ~= nil then
          __lux_tmp_tl_233 = __lux_obj_outerBounds_232.tl
        end
        if __lux_tmp_tl_233 == nil then
          __lux_tmp_tl_233 = 0
        end
        local __lux_obj_outerBounds_234 = outerBounds
        local __lux_tmp_tr_235 = nil
        if __lux_obj_outerBounds_234 ~= nil then
          __lux_tmp_tr_235 = __lux_obj_outerBounds_234.tr
        end
        if __lux_tmp_tr_235 == nil then
          __lux_tmp_tr_235 = 0
        end
        local __lux_obj_outerBounds_236 = outerBounds
        local __lux_tmp_br_237 = nil
        if __lux_obj_outerBounds_236 ~= nil then
          __lux_tmp_br_237 = __lux_obj_outerBounds_236.br
        end
        if __lux_tmp_br_237 == nil then
          __lux_tmp_br_237 = 0
        end
        local __lux_obj_outerBounds_238 = outerBounds
        local __lux_tmp_bl_239 = nil
        if __lux_obj_outerBounds_238 ~= nil then
          __lux_tmp_bl_239 = __lux_obj_outerBounds_238.bl
        end
        if __lux_tmp_bl_239 == nil then
          __lux_tmp_bl_239 = 0
        end
        local __lux_tmp_240
        if shadowBounds ~= nil then
          __lux_tmp_240 = shadowBounds.falloff
        else
          __lux_tmp_240 = 1
        end
        local __lux_tmp_241
        if outerBounds ~= nil then
          __lux_tmp_241 = outerBounds.width
        else
          __lux_tmp_241 = 1
        end
        local __lux_tmp_242
        if outerBounds ~= nil then
          __lux_tmp_242 = outerBounds.strength
        else
          __lux_tmp_242 = 0
        end
        local __lux_tmp_243
        if outerBounds ~= nil then
          __lux_tmp_243 = outerBounds.falloff
        else
          __lux_tmp_243 = 1
        end
        setupPrimitiveAuxConstants(
          material,
          __lux_tmp_220,
          __lux_tmp_221,
          __lux_tmp_222,
          __lux_tmp_223,
          __lux_tmp_shapeX_225 - sx,
          __lux_tmp_shapeY_227 - sy,
          __lux_tmp_shapeW_229,
          __lux_tmp_shapeH_231,
          __lux_tmp_tl_233,
          __lux_tmp_tr_235,
          __lux_tmp_br_237,
          __lux_tmp_bl_239,
          __lux_tmp_240,
          __lux_tmp_241,
          __lux_tmp_242,
          __lux_tmp_243
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
        local __lux_tmp_a_244 = tint.a
        if __lux_tmp_a_244 == nil then
          __lux_tmp_a_244 = 255
        end
        local __lux_tmp_opacity_245 = spec.opacity
        if __lux_tmp_opacity_245 == nil then
          __lux_tmp_opacity_245 = 1
        end
        alpha = __lux_tmp_a_244 * __lux_tmp_opacity_245
      end
      if alpha <= 0 then
        return nil
      end
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
      return makeColor(
        __lux_tmp_r_246,
        __lux_tmp_g_247,
        __lux_tmp_b_248,
        mathFloor(mathClamp(alpha, 0, 255) + 0.5)
      )
    end
    drawChamferBackdrop = function(x, y, w, h, cuts, spec)
      if spec == nil or not shadersActive() then
        return nil
      end
      local pad
      do
        local __lux_tmp_padding_249 = toNumber(spec.padding)
        if __lux_tmp_padding_249 == nil then
          __lux_tmp_padding_249 = 0
        end
        pad = mathMax(0, __lux_tmp_padding_249)
      end
      local bx = x - pad
      local by = y - pad
      local bw = w + pad * 2
      local bh = h + pad * 2
      local bcuts = cutsWithGrow(cuts, pad)
      local tl, tr, br, bl = chamferTuple(bcuts, bw, bh)
      if spec.blur > 0 and materialOK(primitiveMaterials.chamfer_backdrop) then
        local material = primitiveMaterials.chamfer_backdrop
        prepareBackdropBlur(spec.blur, spec.recapture, spec.level)
        surfaceSetMaterial(material)
        surfaceSetDrawColor(255, 255, 255, 255)
        setupParamMatrix(material, bw, bh, 0, 0, bw, bh, tl, tr, br, bl, 0, 0, 1, 0, 0, 0)
        drawTexturedQuad(bx, by, bw, bh, material)
      end
      local tint = chamferBackdropTintColor(spec)
      if tint ~= nil then
        drawChamferBasePass(bx, by, bw, bh, bcuts, style.solid(tint), nil, 0, false)
      end
      return true
    end
    drawChamferPatternPrepared = function(x, y, w, h, cuts, spec)
      if spec == nil or not shadersActive() or not materialOK(primitiveMaterials.chamfer_pattern) then
        return false
      end
      local color = spec.color
      if color == nil then
        color = spec.tint
      end
      local __lux_tmp_252 = color ~= nil
      if __lux_tmp_252 then
        local __lux_tmp_a_251 = color.a
        if __lux_tmp_a_251 == nil then
          __lux_tmp_a_251 = 255
        end
        __lux_tmp_252 = __lux_tmp_a_251 <= 0
      end
      if __lux_tmp_252 then
        return false
      end
      local tl, tr, br, bl = chamferTuple(cuts, w, h)
      local angle
      do
        local __lux_tmp_angle_253 = toNumber(spec.angle)
        if __lux_tmp_angle_253 == nil then
          __lux_tmp_angle_253 = 135
        end
        angle = mathRad(__lux_tmp_angle_253)
      end
      local smoke
      local __lux_match_254 = spec.kind
      if __lux_match_254 == "smoke" then
        smoke = true
      else
        smoke = false
      end
      local worn
      local __lux_match_255 = spec.kind
      if __lux_match_255 == "worn" then
        worn = true
      else
        worn = false
      end
      local material = primitiveMaterials.chamfer_pattern
      local r, g, b, a
      do
        local __lux_tmp_color_256 = spec.color
        if __lux_tmp_color_256 == nil then
          __lux_tmp_color_256 = spec.tint
        end
        r, g, b, a = style.color01(style.asColor(__lux_tmp_color_256, style.DEFAULT_PATTERN_COLOR))
      end
      local pz = 1
      local pw = 1
      if worn then
        do
          local __lux_tmp_scale_257 = toNumber(spec.scale)
          if __lux_tmp_scale_257 == nil then
            __lux_tmp_scale_257 = 32
          end
          pz = mathMax(1, __lux_tmp_scale_257)
        end
        do
          local __lux_tmp_edgeWidth_258 = toNumber(spec.edgeWidth)
          if __lux_tmp_edgeWidth_258 == nil then
            __lux_tmp_edgeWidth_258 = 7
          end
          pw = mathMax(0.5, __lux_tmp_edgeWidth_258)
        end
      else
        if smoke then
          local density
          do
            local __lux_tmp_density_259 = toNumber(spec.density)
            if __lux_tmp_density_259 == nil then
              __lux_tmp_density_259 = 0.48
            end
            density = mathClamp(mathFloor(__lux_tmp_density_259 * 255 + 0.5), 0, 255)
          end
          local softness
          do
            local __lux_tmp_softness_260 = toNumber(spec.softness)
            if __lux_tmp_softness_260 == nil then
              __lux_tmp_softness_260 = 0.3
            end
            softness = mathClamp(mathFloor(__lux_tmp_softness_260 * 255 + 0.5), 0, 255)
          end
          local warp
          do
            local __lux_tmp_warp_261 = toNumber(spec.warp)
            if __lux_tmp_warp_261 == nil then
              __lux_tmp_warp_261 = 0.85
            end
            warp = mathClamp(mathFloor(__lux_tmp_warp_261 * 255 + 0.5), 0, 255)
          end
          do
            local __lux_tmp_scale_262 = toNumber(spec.scale)
            if __lux_tmp_scale_262 == nil then
              __lux_tmp_scale_262 = 140
            end
            pz = mathMax(1, __lux_tmp_scale_262)
          end
          pw = density + softness * 256 + warp * 65536
        else
          do
            local __lux_tmp_spacing_263 = toNumber(spec.spacing)
            if __lux_tmp_spacing_263 == nil then
              __lux_tmp_spacing_263 = 12
            end
            pz = mathMax(1, __lux_tmp_spacing_263)
          end
          do
            local __lux_tmp_width_264 = toNumber(spec.width)
            if __lux_tmp_width_264 == nil then
              __lux_tmp_width_264 = 2
            end
            pw = mathMax(0.25, __lux_tmp_width_264)
          end
        end
      end
      do
        local __lux_tmp_266 = smoke or worn
        if __lux_tmp_266 then
          local __lux_tmp_seed_265 = toNumber(spec.seed)
          if __lux_tmp_seed_265 == nil then
            __lux_tmp_seed_265 = 0
          end
          __lux_tmp_266 = __lux_tmp_seed_265
        end
        local __lux_tmp_267 = __lux_tmp_266
        if not __lux_tmp_267 then
          __lux_tmp_267 = 0
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
          (smoke and 1 or 0) + (worn and 2 or 0) + __lux_tmp_267,
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
      if worn then
        setupChamferWornPatternExtraParams(material, spec, angle)
      end
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    drawChamferPattern = function(x, y, w, h, cuts, pattern)
      return drawChamferPatternPrepared(x, y, w, h, cuts, roundrect.patternStyle(pattern))
    end
    drawChamferQuad = function(x, y, w, h, material, strokeWidth)
      if strokeWidth == nil then
        strokeWidth = 0
      end
      local pad
      do
        local __lux_tmp_strokeWidth_268 = toNumber(strokeWidth)
        if __lux_tmp_strokeWidth_268 == nil then
          __lux_tmp_strokeWidth_268 = 0
        end
        pad = mathCeil(mathMax(0, __lux_tmp_strokeWidth_268) * 0.5 + 1)
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
    drawChamferStroke = function(x, y, w, h, cuts, stroke, strokeWidth, strokeKind, strokeLength, strokeGap, strokeOffset)
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
        strokeKind,
        tl,
        tr,
        br,
        bl,
        strokeLength,
        strokeGap,
        strokeOffset,
        0
      )
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawChamferQuad(x, y, w, h, material, strokeWidth)
      return true
    end
    drawChamferBasePass = function(x, y, w, h, cuts, fill, stroke, strokeWidth, innerEnabled, gr, gg, gb, ga, glowWidth, glowStrength, glowFalloff)
      if strokeWidth == nil then
        strokeWidth = 0
      end
      if innerEnabled == nil then
        innerEnabled = false
      end
      if gr == nil then
        gr = 0
      end
      if gg == nil then
        gg = 0
      end
      if gb == nil then
        gb = 0
      end
      if ga == nil then
        ga = 0
      end
      if glowWidth == nil then
        glowWidth = 0
      end
      if glowStrength == nil then
        glowStrength = 0
      end
      if glowFalloff == nil then
        glowFalloff = 1
      end
      if not shadersActive() or not materialOK(primitiveMaterials.chamfer) then
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
          local __lux_tmp_glowWidth_269 = toNumber(glowWidth)
          if __lux_tmp_glowWidth_269 == nil then
            __lux_tmp_glowWidth_269 = 8
          end
          glowWidth = mathMax(0.001, __lux_tmp_glowWidth_269)
        end
        do
          local __lux_tmp_glowStrength_270 = toNumber(glowStrength)
          if __lux_tmp_glowStrength_270 == nil then
            __lux_tmp_glowStrength_270 = 1
          end
          glowStrength = mathMax(0, __lux_tmp_glowStrength_270)
        end
        do
          local __lux_tmp_glowFalloff_271 = toNumber(glowFalloff)
          if __lux_tmp_glowFalloff_271 == nil then
            __lux_tmp_glowFalloff_271 = 1.65
          end
          glowFalloff = mathMax(0.001, __lux_tmp_glowFalloff_271)
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
        local __lux_tmp_fill_272 = fill
        if __lux_tmp_fill_272 == nil then
          __lux_tmp_fill_272 = transparentFill
        end
        setupPrimitiveFillConstants(material, w, h, __lux_tmp_fill_272, stroke, strokeWidth, 0)
      end
      surfaceSetMaterial(material)
      do
        local __lux_tmp_273
        if stroke ~= nil then
          __lux_tmp_273 = strokeWidth
        else
          __lux_tmp_273 = 0
        end
        drawChamferQuad(x, y, w, h, material, __lux_tmp_273)
      end
      return true
    end
    drawChamferBoxRaw = function(x, y, w, h, cuts, fillInput, stroke, strokeWidthInput, shadow, outerGlow, innerGlow, backdropInput, pattern)
      if cuts == nil then
        cuts = 0
      end
      local hasShadow = false
      local sr = 0
      local sg = 0
      local sb = 0
      local sa = 0
      local shadowX = 0
      local shadowY = 0
      local shadowWidth = 1
      local shadowGrow = 0
      local shadowStrength = 0
      local shadowFalloff = 1
      local shadowExtent = 0
      if shadow ~= nil and shadow ~= false then
        hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, _, shadowGrow, shadowStrength, shadowFalloff, shadowExtent = roundrect.shadowRaw(shadow)
      end
      local hasOuter = false
      local orr = 0
      local og = 0
      local ob = 0
      local oa = 0
      local outerX = 0
      local outerY = 0
      local outerWidth = 1
      local outerGrow = 0
      local outerStrength = 0
      local outerFalloff = 1
      local outerExtent = 0
      if outerGlow ~= nil and outerGlow ~= false then
        hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, _, outerGrow, outerStrength, outerFalloff, outerExtent = roundrect.outerGlowRaw(outerGlow)
      end
      local backdropSpec
      if backdropInput ~= nil and backdropInput ~= false then
        backdropSpec = style.backdropStyle(backdropInput)
      else
        backdropSpec = nil
      end
      local patternSpec
      if pattern ~= nil and pattern ~= false then
        patternSpec = roundrect.patternStyle(pattern)
      else
        patternSpec = nil
      end
      if hasShadow or hasOuter then
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
        backdrop = drawChamferBackdrop(x, y, w, h, cuts, backdropSpec)
      end
      local fill = style.fillFromStyle(fillInput)
      local strokeVisible, strokeColor, strokeWidth, strokeKind, strokeLength, strokeGap, strokeOffset = style.strokeRaw(stroke, strokeWidthInput)
      local fillVisible = hotFillVisible(fill)
      local specialStroke = strokeVisible and strokeKind ~= style.STROKE_SOLID
      local baseStrokeVisible = strokeVisible and not specialStroke
      local hasInner = false
      local igr = 0
      local igg = 0
      local igb = 0
      local iga = 0
      local innerWidth = 0
      local innerStrength = 0
      local innerFalloff = 1
      if innerGlow ~= nil and innerGlow ~= false then
        hasInner, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff = roundrect.innerGlowRaw(innerGlow)
      end
      local baseDrawn = false
      local baseDrewStroke = false
      local baseDrewInner = false
      if fillVisible or baseStrokeVisible or hasInner then
        if patternSpec == nil then
          do
            local __lux_tmp_274
            if baseStrokeVisible then
              __lux_tmp_274 = strokeColor
            else
              __lux_tmp_274 = nil
            end
            local __lux_tmp_275
            if baseStrokeVisible then
              __lux_tmp_275 = strokeWidth
            else
              __lux_tmp_275 = 0
            end
            baseDrawn = drawChamferBasePass(
              x,
              y,
              w,
              h,
              cuts,
              fill,
              __lux_tmp_274,
              __lux_tmp_275,
              hasInner,
              igr,
              igg,
              igb,
              iga,
              innerWidth,
              innerStrength,
              innerFalloff
            )
          end
          baseDrewStroke = baseDrawn and baseStrokeVisible
          baseDrewInner = baseDrawn and hasInner
        else
          if fillVisible then
            baseDrawn = drawChamferBasePass(x, y, w, h, cuts, fill, nil, 0, false)
          end
        end
      end
      if not baseDrawn and fillVisible then
        drawPolyRaw(chamferPoints(x, y, w, h, cuts), nil, fill, nil, 0, nil, nil, nil)
      end
      if patternSpec ~= nil then
        drawChamferPatternPrepared(x, y, w, h, cuts, patternSpec)
      end
      if strokeVisible and not baseDrewStroke then
        if not drawChamferStroke(
          x,
          y,
          w,
          h,
          cuts,
          strokeColor,
          strokeWidth,
          strokeKind,
          strokeLength,
          strokeGap,
          strokeOffset
        ) then
          drawPolyRaw(chamferPoints(x, y, w, h, cuts), nil, transparentColor, stroke, strokeWidth)
        end
      end
      if hasInner and not baseDrewInner then
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
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local __lux_tmp_resolvedCuts_276 = resolvedCuts
      if __lux_tmp_resolvedCuts_276 == nil then
        __lux_tmp_resolvedCuts_276 = resolved.cuts
      end
      if __lux_tmp_resolvedCuts_276 == nil then
        __lux_tmp_resolvedCuts_276 = 0
      end
      local __lux_tmp_fill_277 = resolved.fill
      if __lux_tmp_fill_277 == nil then
        __lux_tmp_fill_277 = resolved.color
      end
      return drawChamferBoxRaw(
        x,
        y,
        w,
        h,
        __lux_tmp_resolvedCuts_276,
        __lux_tmp_fill_277,
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
        local __lux_tmp_sides_278 = toNumber(sides)
        if __lux_tmp_sides_278 == nil then
          __lux_tmp_sides_278 = 3
        end
        count = mathClamp(mathFloor(__lux_tmp_sides_278), 3, 8)
      end
      local r
      do
        local __lux_tmp_radius_279 = toNumber(radius)
        if __lux_tmp_radius_279 == nil then
          __lux_tmp_radius_279 = 0
        end
        r = mathMax(0, __lux_tmp_radius_279)
      end
      local start
      do
        local __lux_tmp_rotation_280 = toNumber(rotation)
        if __lux_tmp_rotation_280 == nil then
          __lux_tmp_rotation_280 = -90
        end
        start = mathRad(__lux_tmp_rotation_280)
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
        local __lux_tmp_direction_281 = direction
        if __lux_tmp_direction_281 == nil then
          __lux_tmp_direction_281 = "right"
        end
        local __lux_match_282 = __lux_tmp_direction_281
        if __lux_match_282 == "up" then
          setPoint(caretScratch, 1, x + w * 0.5, y)
          setPoint(caretScratch, 2, x + w, y + h)
          setPoint(caretScratch, 3, x, y + h)
        elseif __lux_match_282 == "down" then
          setPoint(caretScratch, 1, x, y)
          setPoint(caretScratch, 2, x + w, y)
          setPoint(caretScratch, 3, x + w * 0.5, y + h)
        elseif __lux_match_282 == "left" then
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
      local __lux_tmp_rotation_283 = resolved.rotation
      if __lux_tmp_rotation_283 == nil then
        __lux_tmp_rotation_283 = resolved.angle
      end
      return polyEx(regularPolyPoints(cx, cy, radius, sides, __lux_tmp_rotation_283), resolved)
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
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local __lux_tmp_direction_284 = resolved.direction
      if __lux_tmp_direction_284 == nil then
        __lux_tmp_direction_284 = resolved.dir
      end
      return polyEx(caretPoints(x, y, w, h, __lux_tmp_direction_284), resolved)
    end
    caret = function(x, y, w, h, direction, fill, stroke, strokeWidth)
      return drawPolyRaw(caretPoints(x, y, w, h, direction), nil, fill, stroke, strokeWidth)
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
            return drawChamferBoxImmediate(x, y, w, h, stripped, cuts)
          end
        )
      end
      return drawChamferBoxImmediate(x, y, w, h, stripped, cuts)
    end
    chamferBox = function(x, y, w, h, cuts, fill, stroke, strokeWidth)
      local __lux_tmp_cuts_285 = cuts
      if __lux_tmp_cuts_285 == nil then
        __lux_tmp_cuts_285 = 0
      end
      return drawChamferBoxRaw(x, y, w, h, __lux_tmp_cuts_285, fill, stroke, strokeWidth)
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
      owner.LineNoCaps = lineNoCaps
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
  __lux_exports.lineNoCaps = lineNoCaps
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
