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
      local __lux_tmp_colorB_29 = fill.colorB
      if __lux_tmp_colorB_29 == nil then
        __lux_tmp_colorB_29 = colorA(colorA.a == nil or colorA.a > 0)
      end
      local __lux_tmp_30 = __lux_tmp_colorB_29
      if not __lux_tmp_30 then
        __lux_tmp_30 = colorB.a == nil or colorB.a > 0
      end
      local colorB = __lux_tmp_30
    end
    pointXY = function(point)
      local __lux_tmp_x_31 = point.x
      if __lux_tmp_x_31 == nil then
        __lux_tmp_x_31 = point[1]
      end
      local __lux_tmp_x_32 = toNumber(__lux_tmp_x_31)
      if __lux_tmp_x_32 == nil then
        __lux_tmp_x_32 = 0
      end
      local __lux_tmp_y_33 = point.y
      if __lux_tmp_y_33 == nil then
        __lux_tmp_y_33 = point[2]
      end
      local __lux_tmp_y_34 = toNumber(__lux_tmp_y_33)
      if __lux_tmp_y_34 == nil then
        __lux_tmp_y_34 = 0
      end
      return __lux_tmp_x_32, __lux_tmp_y_34
    end
    effectBleedFromDrawRect = function(x, y, w, h, drawX, drawY, drawW, drawH)
      local left = mathMax(0, x - drawX)
      local top = mathMax(0, y - drawY)
      local right = mathMax(0, drawX + drawW - (x + w))
      local bottom = mathMax(0, drawY + drawH - (y + h))
      return left, top, right, bottom
    end
    primitiveStrokeVisible = function(strokeValue, strokeWidth)
      local __lux_tmp_36 = strokeValue ~= nil and (strokeValue.a == nil or strokeValue.a > 0)
      if __lux_tmp_36 then
        local __lux_tmp_strokeWidth_35 = strokeWidth
        if __lux_tmp_strokeWidth_35 == nil then
          __lux_tmp_strokeWidth_35 = 0
        end
        __lux_tmp_36 = __lux_tmp_strokeWidth_35 > 0
      end
      return __lux_tmp_36
    end
    drawPreparedRoundRectPlain = function(x, y, w, h, radius, fill, strokeValue, strokeWidth, patternSpec)
      if strokeWidth == nil then
        strokeWidth = 0
      end
      local __lux_tmp_fill_37 = fill
      if __lux_tmp_fill_37 == nil then
        __lux_tmp_fill_37 = primitiveTransparentFill
      end
      return roundrect.drawRoundRectPrepared(
        x,
        y,
        w,
        h,
        radius,
        __lux_tmp_fill_37,
        hotFillVisible(fill),
        strokeValue,
        strokeWidth,
        primitiveStrokeVisible(strokeValue, strokeWidth),
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
      local __lux_tmp_fill_38 = fill
      if __lux_tmp_fill_38 == nil then
        __lux_tmp_fill_38 = primitiveTransparentFill
      end
      return roundrect.drawRoundRectPrepared(
        x,
        y,
        w,
        h,
        radius,
        __lux_tmp_fill_38,
        hotFillVisible(fill),
        nil,
        0,
        false,
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
          local __lux_tmp_tl_39 = cuts.tl
          if __lux_tmp_tl_39 == nil then
            __lux_tmp_tl_39 = cuts[1]
          end
          local __lux_tmp_tl_40 = toNumber(__lux_tmp_tl_39)
          if __lux_tmp_tl_40 == nil then
            __lux_tmp_tl_40 = 0
          end
          tl = __lux_tmp_tl_40
        end
        do
          local __lux_tmp_tr_41 = cuts.tr
          if __lux_tmp_tr_41 == nil then
            __lux_tmp_tr_41 = cuts[2]
          end
          local __lux_tmp_tr_42 = toNumber(__lux_tmp_tr_41)
          if __lux_tmp_tr_42 == nil then
            __lux_tmp_tr_42 = tl
          end
          tr = __lux_tmp_tr_42
        end
        do
          local __lux_tmp_br_43 = cuts.br
          if __lux_tmp_br_43 == nil then
            __lux_tmp_br_43 = cuts[3]
          end
          local __lux_tmp_br_44 = toNumber(__lux_tmp_br_43)
          if __lux_tmp_br_44 == nil then
            __lux_tmp_br_44 = tr
          end
          br = __lux_tmp_br_44
        end
        do
          local __lux_tmp_bl_45 = cuts.bl
          if __lux_tmp_bl_45 == nil then
            __lux_tmp_bl_45 = cuts[4]
          end
          local __lux_tmp_bl_46 = toNumber(__lux_tmp_bl_45)
          if __lux_tmp_bl_46 == nil then
            __lux_tmp_bl_46 = br
          end
          bl = __lux_tmp_bl_46
        end
      else
        do
          local __lux_tmp_cuts_47 = toNumber(cuts)
          if __lux_tmp_cuts_47 == nil then
            __lux_tmp_cuts_47 = 0
          end
          tl = __lux_tmp_cuts_47
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
            local __lux_cmp_48 = false
            if mathAbs(last.x - px) ~= nil then
              __lux_cmp_48 = mathAbs(last.x - px) < 0.001
            end
            sameX = __lux_cmp_48
          end
          local sameY
          do
            local __lux_cmp_49 = false
            if mathAbs(last.y - py) ~= nil then
              __lux_cmp_49 = mathAbs(last.y - py) < 0.001
            end
            sameY = __lux_cmp_49
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
        local __lux_cmp_52 = false
        if mathAbs(first.x - last.x) ~= nil then
          __lux_cmp_52 = mathAbs(first.x - last.x) < 0.001
        end
        local __lux_tmp_54 = __lux_cmp_52
        if __lux_tmp_54 then
          local __lux_cmp_53 = false
          if mathAbs(first.y - last.y) ~= nil then
            __lux_cmp_53 = mathAbs(first.y - last.y) < 0.001
          end
          __lux_tmp_54 = __lux_cmp_53
        end
        if __lux_tmp_54 then
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
        local __lux_cmp_55 = false
        if mathAbs(cross) ~= nil then
          __lux_cmp_55 = mathAbs(cross) > 0.000001
        end
        if __lux_cmp_55 then
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
        local __lux_tmp_points_56 = points
        if __lux_tmp_points_56 == nil then
          __lux_tmp_points_56 = {}
        end
        count = #__lux_tmp_points_56
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
      local __lux_cmp_57 = false
      if signedArea(ordered) ~= nil then
        __lux_cmp_57 = signedArea(ordered) < 0
      end
      if __lux_cmp_57 then
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
      local __lux_cmp_58 = false
      if mathAbs(det) ~= nil then
        __lux_cmp_58 = mathAbs(det) > 0.0001
      end
      if __lux_cmp_58 then
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
        local __lux_tmp_amount_59 = toNumber(amount)
        if __lux_tmp_amount_59 == nil then
          __lux_tmp_amount_59 = 0
        end
        amount = mathMax(0, __lux_tmp_amount_59)
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
      local __lux_tmp_grown_60 = normalizePoly(grown)
      if __lux_tmp_grown_60 == nil then
        __lux_tmp_grown_60 = poly
      end
      return __lux_tmp_grown_60
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
    drawLineRectRaw = function(x, y, w, h, fill, radius, shadow, outerGlow, backdrop)
      if radius ~= nil and shadow == nil and outerGlow == nil and backdrop == nil then
        local __lux_tmp_radius_61 = radius
        if __lux_tmp_radius_61 == nil then
          __lux_tmp_radius_61 = 0
        end
        return drawPreparedRoundRectPlain(x, y, w, h, __lux_tmp_radius_61, fill)
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
        local __lux_tmp_radius_62 = radius
        if __lux_tmp_radius_62 == nil then
          __lux_tmp_radius_62 = 0
        end
        return drawPreparedRoundRectEffects(
          x,
          y,
          w,
          h,
          __lux_tmp_radius_62,
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
      local __lux_tmp_fallbackVerts_63 = fallbackVerts
      if __lux_tmp_fallbackVerts_63 == nil then
        __lux_tmp_fallbackVerts_63 = verts
      end
      return drawLineFallbackVerts(__lux_tmp_fallbackVerts_63, fill, nil, shadow, outerGlow)
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
        local __lux_tmp_fillInput_64 = fillInput
        if __lux_tmp_fillInput_64 == nil then
          __lux_tmp_fillInput_64 = defaultLineColor
        end
        fill = style.fillFromStyle(__lux_tmp_fillInput_64)
      end
      if not hotFillVisible(fill) and backdrop == nil then
        return
      end
      local __lux_cmp_65 = false
      if mathAbs(y2 - y1) ~= nil then
        __lux_cmp_65 = mathAbs(y2 - y1) < 0.001
      end
      if __lux_cmp_65 then
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
      local __lux_cmp_66 = false
      if mathAbs(x2 - x1) ~= nil then
        __lux_cmp_66 = mathAbs(x2 - x1) < 0.001
      end
      if __lux_cmp_66 then
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
      local __lux_tmp_fill_67 = resolved.fill
      if __lux_tmp_fill_67 == nil then
        __lux_tmp_fill_67 = resolved.color
      end
      if __lux_tmp_fill_67 == nil then
        __lux_tmp_fill_67 = color
      end
      local __lux_tmp_width_68 = width
      if __lux_tmp_width_68 == nil then
        __lux_tmp_width_68 = resolved.width
      end
      if __lux_tmp_width_68 == nil then
        __lux_tmp_width_68 = resolved.strokeWidth
      end
      return drawLineRaw(
        x1,
        y1,
        x2,
        y2,
        __lux_tmp_fill_67,
        __lux_tmp_width_68,
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
      local width
      do
        local __lux_tmp_width_71 = stripped.width
        if __lux_tmp_width_71 == nil then
          __lux_tmp_width_71 = stripped.strokeWidth
        end
        width = mathMax(1, style.strokeWidth(__lux_tmp_width_71, 1))
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
          local __lux_tmp_fill_72 = stripped.fill
          if __lux_tmp_fill_72 == nil then
            __lux_tmp_fill_72 = stripped.color
          end
          local __lux_tmp_width_73 = stripped.width
          if __lux_tmp_width_73 == nil then
            __lux_tmp_width_73 = stripped.strokeWidth
          end
          return drawLineRaw(
            x1,
            y1,
            x2,
            y2,
            __lux_tmp_fill_72,
            __lux_tmp_width_73,
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
        local __lux_tmp_pad_74 = toNumber(pad)
        if __lux_tmp_pad_74 == nil then
          __lux_tmp_pad_74 = 1
        end
        pad = mathMax(1, __lux_tmp_pad_74)
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
      local __lux_tmp_intensity_75 = intensity
      if __lux_tmp_intensity_75 == nil then
        __lux_tmp_intensity_75 = 1
      end
      local __lux_tmp_radius_76 = toNumber(radius)
      if __lux_tmp_radius_76 == nil then
        __lux_tmp_radius_76 = 0
      end
      return setupParamMatrix(
        material,
        vertical and 1 or 0,
        __lux_tmp_intensity_75,
        0,
        0,
        w,
        h,
        0,
        mathMax(0, __lux_tmp_radius_76),
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
        local __lux_tmp_a_77 = tint.a
        if __lux_tmp_a_77 == nil then
          __lux_tmp_a_77 = 255
        end
        local __lux_tmp_opacity_78 = spec.opacity
        if __lux_tmp_opacity_78 == nil then
          __lux_tmp_opacity_78 = 1
        end
        alpha = __lux_tmp_a_77 * __lux_tmp_opacity_78
      end
      if alpha <= 0 then
        return nil
      end
      do
        local __lux_tmp_r_79 = tint.r
        if __lux_tmp_r_79 == nil then
          __lux_tmp_r_79 = 0
        end
        polyBackdropTintScratch.r = __lux_tmp_r_79
      end
      do
        local __lux_tmp_g_80 = tint.g
        if __lux_tmp_g_80 == nil then
          __lux_tmp_g_80 = 0
        end
        polyBackdropTintScratch.g = __lux_tmp_g_80
      end
      do
        local __lux_tmp_b_81 = tint.b
        if __lux_tmp_b_81 == nil then
          __lux_tmp_b_81 = 0
        end
        polyBackdropTintScratch.b = __lux_tmp_b_81
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
        local __lux_tmp_padding_82 = toNumber(spec.padding)
        if __lux_tmp_padding_82 == nil then
          __lux_tmp_padding_82 = 0
        end
        pad = mathMax(0, __lux_tmp_padding_82)
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
        local __lux_tmp_width_83 = toNumber(width)
        if __lux_tmp_width_83 == nil then
          __lux_tmp_width_83 = 12
        end
        width = mathMax(0.001, __lux_tmp_width_83)
      end
      do
        local __lux_tmp_grow_84 = toNumber(grow)
        if __lux_tmp_grow_84 == nil then
          __lux_tmp_grow_84 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_84)
      end
      do
        local __lux_tmp_extent_85 = toNumber(extent)
        if __lux_tmp_extent_85 == nil then
          __lux_tmp_extent_85 = width
        end
        extent = mathMax(1, __lux_tmp_extent_85)
      end
      local padding = grow + mathMax(extent, width)
      do
        local __lux_tmp_ox_86 = toNumber(ox)
        if __lux_tmp_ox_86 == nil then
          __lux_tmp_ox_86 = 0
        end
        ox = __lux_tmp_ox_86
      end
      do
        local __lux_tmp_oy_87 = toNumber(oy)
        if __lux_tmp_oy_87 == nil then
          __lux_tmp_oy_87 = 0
        end
        oy = __lux_tmp_oy_87
      end
      do
        local __lux_tmp_falloff_88 = toNumber(falloff)
        if __lux_tmp_falloff_88 == nil then
          __lux_tmp_falloff_88 = 1.7
        end
        falloff = mathMax(0.001, __lux_tmp_falloff_88)
      end
      do
        local __lux_tmp_strength_89 = toNumber(strength)
        if __lux_tmp_strength_89 == nil then
          __lux_tmp_strength_89 = 1
        end
        strength = mathMax(0, __lux_tmp_strength_89)
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
        local __lux_tmp_a0_90 = a0
        if __lux_tmp_a0_90 == nil then
          __lux_tmp_a0_90 = 0
        end
        local __lux_tmp_b0_91 = b0
        if __lux_tmp_b0_91 == nil then
          __lux_tmp_b0_91 = 0
        end
        local __lux_tmp_c0_92 = c0
        if __lux_tmp_c0_92 == nil then
          __lux_tmp_c0_92 = 0
        end
        local __lux_tmp_d0_93 = d0
        if __lux_tmp_d0_93 == nil then
          __lux_tmp_d0_93 = 0
        end
        local __lux_tmp_a1_94 = a1
        if __lux_tmp_a1_94 == nil then
          __lux_tmp_a1_94 = 0
        end
        local __lux_tmp_b1_95 = b1
        if __lux_tmp_b1_95 == nil then
          __lux_tmp_b1_95 = 0
        end
        local __lux_tmp_c1_96 = c1
        if __lux_tmp_c1_96 == nil then
          __lux_tmp_c1_96 = 0
        end
        local __lux_tmp_d1_97 = d1
        if __lux_tmp_d1_97 == nil then
          __lux_tmp_d1_97 = 0
        end
        local __lux_tmp_a2_98 = a2
        if __lux_tmp_a2_98 == nil then
          __lux_tmp_a2_98 = 0
        end
        local __lux_tmp_b2_99 = b2
        if __lux_tmp_b2_99 == nil then
          __lux_tmp_b2_99 = 0
        end
        local __lux_tmp_c2_100 = c2
        if __lux_tmp_c2_100 == nil then
          __lux_tmp_c2_100 = 0
        end
        local __lux_tmp_d2_101 = d2
        if __lux_tmp_d2_101 == nil then
          __lux_tmp_d2_101 = 0
        end
        local __lux_tmp_a3_102 = a3
        if __lux_tmp_a3_102 == nil then
          __lux_tmp_a3_102 = 0
        end
        local __lux_tmp_b3_103 = b3
        if __lux_tmp_b3_103 == nil then
          __lux_tmp_b3_103 = 0
        end
        local __lux_tmp_c3_104 = c3
        if __lux_tmp_c3_104 == nil then
          __lux_tmp_c3_104 = 0
        end
        local __lux_tmp_d3_105 = d3
        if __lux_tmp_d3_105 == nil then
          __lux_tmp_d3_105 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_a0_90,
          __lux_tmp_b0_91,
          __lux_tmp_c0_92,
          __lux_tmp_d0_93,
          __lux_tmp_a1_94,
          __lux_tmp_b1_95,
          __lux_tmp_c1_96,
          __lux_tmp_d1_97,
          __lux_tmp_a2_98,
          __lux_tmp_b2_99,
          __lux_tmp_c2_100,
          __lux_tmp_d2_101,
          __lux_tmp_a3_102,
          __lux_tmp_b3_103,
          __lux_tmp_c3_104,
          __lux_tmp_d3_105
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
      local edgeColor = style.asColor(spec.edgeColor, makeColor(218, 208, 184, 78))
      local er, eg, eb, ea = style.color01(edgeColor)
      local __lux_tmp_fractal_106 = toNumber(spec.fractal)
      if __lux_tmp_fractal_106 == nil then
        __lux_tmp_fractal_106 = 0.44
      end
      local __lux_tmp_grain_107 = toNumber(spec.grain)
      if __lux_tmp_grain_107 == nil then
        __lux_tmp_grain_107 = 0.64
      end
      local __lux_tmp_scratches_108 = spec.scratches
      if __lux_tmp_scratches_108 == nil then
        __lux_tmp_scratches_108 = spec.scratch
      end
      local __lux_tmp_scratches_109 = toNumber(__lux_tmp_scratches_108)
      if __lux_tmp_scratches_109 == nil then
        __lux_tmp_scratches_109 = 0.30
      end
      local __lux_tmp_edge_110 = spec.edge
      if __lux_tmp_edge_110 == nil then
        __lux_tmp_edge_110 = spec.edgeWear
      end
      local __lux_tmp_edge_111 = toNumber(__lux_tmp_edge_110)
      if __lux_tmp_edge_111 == nil then
        __lux_tmp_edge_111 = 0.54
      end
      local __lux_tmp_grainScale_112 = toNumber(spec.grainScale)
      if __lux_tmp_grainScale_112 == nil then
        __lux_tmp_grainScale_112 = 5.6
      end
      local __lux_tmp_scratchScale_113 = toNumber(spec.scratchScale)
      if __lux_tmp_scratchScale_113 == nil then
        __lux_tmp_scratchScale_113 = 26
      end
      local __lux_tmp_scratchWidth_114 = toNumber(spec.scratchWidth)
      if __lux_tmp_scratchWidth_114 == nil then
        __lux_tmp_scratchWidth_114 = 0.045
      end
      local __lux_tmp_edgeWidth_115 = toNumber(spec.edgeWidth)
      if __lux_tmp_edgeWidth_115 == nil then
        __lux_tmp_edgeWidth_115 = 7
      end
      local __lux_tmp_softness_116 = toNumber(spec.softness)
      if __lux_tmp_softness_116 == nil then
        __lux_tmp_softness_116 = 0.10
      end
      local __lux_tmp_warp_117 = toNumber(spec.warp)
      if __lux_tmp_warp_117 == nil then
        __lux_tmp_warp_117 = 0.035
      end
      return setupPolyShadowAuxConstants(
        material,
        er,
        eg,
        eb,
        ea,
        mathClamp(__lux_tmp_fractal_106, 0, 1),
        mathClamp(__lux_tmp_grain_107, 0, 1),
        mathClamp(__lux_tmp_scratches_109, 0, 1),
        mathClamp(__lux_tmp_edge_111, 0, 1),
        mathMax(0.25, __lux_tmp_grainScale_112),
        mathMax(1, __lux_tmp_scratchScale_113),
        mathClamp(__lux_tmp_scratchWidth_114, 0.005, 0.5),
        mathMax(0.5, __lux_tmp_edgeWidth_115),
        mathCos(angle),
        mathSin(angle),
        mathClamp(__lux_tmp_softness_116, 0.001, 1),
        mathMax(0, __lux_tmp_warp_117)
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
      local __lux_tmp_120 = color ~= nil
      if __lux_tmp_120 then
        local __lux_tmp_a_119 = color.a
        if __lux_tmp_a_119 == nil then
          __lux_tmp_a_119 = 255
        end
        __lux_tmp_120 = __lux_tmp_a_119 <= 0
      end
      if __lux_tmp_120 then
        return false
      end
      local material = primitiveMaterials.poly_pattern
      local r, g, b, a
      do
        local __lux_tmp_color_121 = spec.color
        if __lux_tmp_color_121 == nil then
          __lux_tmp_color_121 = spec.tint
        end
        r, g, b, a = style.color01(style.asColor(__lux_tmp_color_121, makeColor(255, 255, 255, 24)))
      end
      local angle
      do
        local __lux_tmp_angle_122 = toNumber(spec.angle)
        if __lux_tmp_angle_122 == nil then
          __lux_tmp_angle_122 = 135
        end
        angle = mathRad(__lux_tmp_angle_122)
      end
      local smoke
      local __lux_match_123 = spec.kind
      if __lux_match_123 == "smoke" then
        smoke = true
      else
        smoke = false
      end
      local worn
      local __lux_match_124 = spec.kind
      if __lux_match_124 == "worn" then
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
          local __lux_tmp_scale_125 = toNumber(spec.scale)
          if __lux_tmp_scale_125 == nil then
            __lux_tmp_scale_125 = 32
          end
          pz = mathMax(1, __lux_tmp_scale_125)
        end
        do
          local __lux_tmp_edgeWidth_126 = toNumber(spec.edgeWidth)
          if __lux_tmp_edgeWidth_126 == nil then
            __lux_tmp_edgeWidth_126 = 7
          end
          pw = mathMax(0.5, __lux_tmp_edgeWidth_126)
        end
        ox = roundrect.patternOffset(spec)
        oy = 2
        do
          local __lux_tmp_softness_127 = toNumber(spec.softness)
          if __lux_tmp_softness_127 == nil then
            __lux_tmp_softness_127 = 0.10
          end
          oz = mathClamp(__lux_tmp_softness_127, 0.001, 1)
        end
        do
          local __lux_tmp_warp_128 = toNumber(spec.warp)
          if __lux_tmp_warp_128 == nil then
            __lux_tmp_warp_128 = 0.035
          end
          ow = mathMax(0, __lux_tmp_warp_128)
        end
      else
        if smoke then
          do
            local __lux_tmp_scale_129 = toNumber(spec.scale)
            if __lux_tmp_scale_129 == nil then
              __lux_tmp_scale_129 = 140
            end
            pz = mathMax(1, __lux_tmp_scale_129)
          end
          do
            local __lux_tmp_density_130 = toNumber(spec.density)
            if __lux_tmp_density_130 == nil then
              __lux_tmp_density_130 = 0.48
            end
            pw = mathClamp(__lux_tmp_density_130, 0, 1)
          end
          ox = roundrect.patternOffset(spec)
          oy = 1
          do
            local __lux_tmp_softness_131 = toNumber(spec.softness)
            if __lux_tmp_softness_131 == nil then
              __lux_tmp_softness_131 = 0.3
            end
            oz = mathMax(0.001, __lux_tmp_softness_131)
          end
          do
            local __lux_tmp_warp_132 = toNumber(spec.warp)
            if __lux_tmp_warp_132 == nil then
              __lux_tmp_warp_132 = 0.85
            end
            ow = mathMax(0, __lux_tmp_warp_132)
          end
        else
          do
            local __lux_tmp_spacing_133 = toNumber(spec.spacing)
            if __lux_tmp_spacing_133 == nil then
              __lux_tmp_spacing_133 = 12
            end
            pz = mathMax(1, __lux_tmp_spacing_133)
          end
          do
            local __lux_tmp_width_134 = toNumber(spec.width)
            if __lux_tmp_width_134 == nil then
              __lux_tmp_width_134 = 2
            end
            pw = mathMax(0.25, __lux_tmp_width_134)
          end
          ox = roundrect.patternOffset(spec)
        end
      end
      do
        local __lux_tmp_136 = smoke or worn
        if __lux_tmp_136 then
          local __lux_tmp_seed_135 = toNumber(spec.seed)
          if __lux_tmp_seed_135 == nil then
            __lux_tmp_seed_135 = 0
          end
          __lux_tmp_136 = __lux_tmp_seed_135
        end
        local __lux_tmp_137 = __lux_tmp_136
        if not __lux_tmp_137 then
          __lux_tmp_137 = 0
        end
        setupParamMatrix(
          material,
          r,
          g,
          b,
          a,
          poly.w,
          poly.h,
          __lux_tmp_137,
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
    drawPolyFallbackPrepared = function(points, fill, hasFill, stroke, strokeWidth, hasStroke)
      if hasFill then
        style.setDrawColor(fillColor(fill))
        drawTransformedPoly(points)
      end
      if hasStroke then
        for index = 1, #points do
          local a = points[index]
          local b = points[index % #points + 1]
          do
            local __lux_tmp_x_138 = a.x
            if __lux_tmp_x_138 == nil then
              __lux_tmp_x_138 = a[1]
            end
            local __lux_tmp_y_139 = a.y
            if __lux_tmp_y_139 == nil then
              __lux_tmp_y_139 = a[2]
            end
            local __lux_tmp_x_140 = b.x
            if __lux_tmp_x_140 == nil then
              __lux_tmp_x_140 = b[1]
            end
            local __lux_tmp_y_141 = b.y
            if __lux_tmp_y_141 == nil then
              __lux_tmp_y_141 = b[2]
            end
            drawLineRaw(
              __lux_tmp_x_138,
              __lux_tmp_y_139,
              __lux_tmp_x_140,
              __lux_tmp_y_141,
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
    drawPolyFallbackRaw = function(points, fillInput, stroke, strokeWidthInput)
      local fill = style.fillFromStyle(fillInput)
      local strokeWidth = style.strokeWidthValue(strokeWidthInput, 0)
      local hasStroke = style.strokeVisible(stroke, strokeWidth)
      return drawPolyFallbackPrepared(
        points,
        fill,
        hotFillVisible(fill),
        stroke,
        strokeWidth,
        hasStroke
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
      local cullX = poly.x
      local cullY = poly.y
      local cullW = poly.w
      local cullH = poly.h
      cullX, cullY, cullW, cullH = includeBounds(cullX, cullY, cullW, cullH, shadowBounds)
      cullX, cullY, cullW, cullH = includeBounds(cullX, cullY, cullW, cullH, outerBounds)
      if backdrop ~= nil then
        local pad
        do
          local __lux_tmp_padding_142 = toNumber(backdrop.padding)
          if __lux_tmp_padding_142 == nil then
            __lux_tmp_padding_142 = 0
          end
          pad = mathMax(0, __lux_tmp_padding_142)
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
      local strokeWidth = style.strokeWidthValue(strokeWidthInput, 0)
      local hasStroke = style.strokeVisible(stroke, strokeWidth)
      if not shadersActive() then
        return drawPolyFallbackPrepared(points, fill, hasFill, stroke, strokeWidth, hasStroke)
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
        drawPolyStroke(poly, stroke, strokeWidth)
      end
    end
    drawPolyImmediateNormalized = function(points, drawStyle, poly)
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local __lux_tmp_fill_143 = resolved.fill
      if __lux_tmp_fill_143 == nil then
        __lux_tmp_fill_143 = resolved.color
      end
      return drawPolyRawNormalized(
        points,
        poly,
        __lux_tmp_fill_143,
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
      local __lux_match_144 = fill
      local __lux_tag_145
      if __lux_match_144 ~= nil then
        __lux_tag_145 = __lux_match_144.kind
      end
      if __lux_tag_145 == style.FILL_LINEAR then
        local x1 = __lux_match_144.x1
        local y1 = __lux_match_144.y1
        local x2 = __lux_match_144.x2
        local y2 = __lux_match_144.y2
        do
          local __lux_tmp_x1_146 = x1
          if __lux_tmp_x1_146 == nil then
            __lux_tmp_x1_146 = 0
          end
          p0 = __lux_tmp_x1_146
        end
        do
          local __lux_tmp_y1_147 = y1
          if __lux_tmp_y1_147 == nil then
            __lux_tmp_y1_147 = 0
          end
          p1 = __lux_tmp_y1_147
        end
        do
          local __lux_tmp_x2_148 = x2
          if __lux_tmp_x2_148 == nil then
            __lux_tmp_x2_148 = 1
          end
          p2 = __lux_tmp_x2_148
        end
        do
          local __lux_tmp_y2_149 = y2
          if __lux_tmp_y2_149 == nil then
            __lux_tmp_y2_149 = 1
          end
          p3 = __lux_tmp_y2_149
        end
        style.bindGradientLut(material, fill)
      elseif __lux_tag_145 == style.FILL_RADIAL then
        local cx = __lux_match_144.cx
        local cy = __lux_match_144.cy
        local radius = __lux_match_144.radius
        do
          local __lux_tmp_cx_150 = cx
          if __lux_tmp_cx_150 == nil then
            __lux_tmp_cx_150 = 0.5
          end
          p0 = __lux_tmp_cx_150
        end
        do
          local __lux_tmp_cy_151 = cy
          if __lux_tmp_cy_151 == nil then
            __lux_tmp_cy_151 = 0.5
          end
          p1 = __lux_tmp_cy_151
        end
        do
          local __lux_tmp_radius_152 = radius
          if __lux_tmp_radius_152 == nil then
            __lux_tmp_radius_152 = 0.5
          end
          p2 = __lux_tmp_radius_152
        end
        p3 = 0
        style.bindGradientLut(material, fill)
      elseif __lux_tag_145 == style.FILL_CONIC then
        local cx = __lux_match_144.cx
        local cy = __lux_match_144.cy
        local rotation = __lux_match_144.rotation
        do
          local __lux_tmp_cx_153 = cx
          if __lux_tmp_cx_153 == nil then
            __lux_tmp_cx_153 = 0.5
          end
          p0 = __lux_tmp_cx_153
        end
        do
          local __lux_tmp_cy_154 = cy
          if __lux_tmp_cy_154 == nil then
            __lux_tmp_cy_154 = 0.5
          end
          p1 = __lux_tmp_cy_154
        end
        p2 = style.normalizedRotation(rotation)
        p3 = 0
        style.bindGradientLut(material, fill)
      else
        local __lux_unused_155 = nil
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
        local __lux_tmp_a0_156 = a0
        if __lux_tmp_a0_156 == nil then
          __lux_tmp_a0_156 = 0
        end
        local __lux_tmp_b0_157 = b0
        if __lux_tmp_b0_157 == nil then
          __lux_tmp_b0_157 = 0
        end
        local __lux_tmp_c0_158 = c0
        if __lux_tmp_c0_158 == nil then
          __lux_tmp_c0_158 = 0
        end
        local __lux_tmp_d0_159 = d0
        if __lux_tmp_d0_159 == nil then
          __lux_tmp_d0_159 = 0
        end
        local __lux_tmp_a1_160 = a1
        if __lux_tmp_a1_160 == nil then
          __lux_tmp_a1_160 = 0
        end
        local __lux_tmp_b1_161 = b1
        if __lux_tmp_b1_161 == nil then
          __lux_tmp_b1_161 = 0
        end
        local __lux_tmp_c1_162 = c1
        if __lux_tmp_c1_162 == nil then
          __lux_tmp_c1_162 = 0
        end
        local __lux_tmp_d1_163 = d1
        if __lux_tmp_d1_163 == nil then
          __lux_tmp_d1_163 = 0
        end
        local __lux_tmp_a2_164 = a2
        if __lux_tmp_a2_164 == nil then
          __lux_tmp_a2_164 = 0
        end
        local __lux_tmp_b2_165 = b2
        if __lux_tmp_b2_165 == nil then
          __lux_tmp_b2_165 = 0
        end
        local __lux_tmp_c2_166 = c2
        if __lux_tmp_c2_166 == nil then
          __lux_tmp_c2_166 = 0
        end
        local __lux_tmp_d2_167 = d2
        if __lux_tmp_d2_167 == nil then
          __lux_tmp_d2_167 = 0
        end
        local __lux_tmp_a3_168 = a3
        if __lux_tmp_a3_168 == nil then
          __lux_tmp_a3_168 = 0
        end
        local __lux_tmp_b3_169 = b3
        if __lux_tmp_b3_169 == nil then
          __lux_tmp_b3_169 = 0
        end
        local __lux_tmp_c3_170 = c3
        if __lux_tmp_c3_170 == nil then
          __lux_tmp_c3_170 = 0
        end
        local __lux_tmp_d3_171 = d3
        if __lux_tmp_d3_171 == nil then
          __lux_tmp_d3_171 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_a0_156,
          __lux_tmp_b0_157,
          __lux_tmp_c0_158,
          __lux_tmp_d0_159,
          __lux_tmp_a1_160,
          __lux_tmp_b1_161,
          __lux_tmp_c1_162,
          __lux_tmp_d1_163,
          __lux_tmp_a2_164,
          __lux_tmp_b2_165,
          __lux_tmp_c2_166,
          __lux_tmp_d2_167,
          __lux_tmp_a3_168,
          __lux_tmp_b3_169,
          __lux_tmp_c3_170,
          __lux_tmp_d3_171
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
    setupChamferWornPatternExtraParams = function(material, spec, angle)
      local edgeColor = style.asColor(spec.edgeColor, makeColor(218, 208, 184, 78))
      local er, eg, eb, ea = style.color01(edgeColor)
      local __lux_tmp_fractal_172 = toNumber(spec.fractal)
      if __lux_tmp_fractal_172 == nil then
        __lux_tmp_fractal_172 = 0.44
      end
      local __lux_tmp_grain_173 = toNumber(spec.grain)
      if __lux_tmp_grain_173 == nil then
        __lux_tmp_grain_173 = 0.64
      end
      local __lux_tmp_scratches_174 = spec.scratches
      if __lux_tmp_scratches_174 == nil then
        __lux_tmp_scratches_174 = spec.scratch
      end
      local __lux_tmp_scratches_175 = toNumber(__lux_tmp_scratches_174)
      if __lux_tmp_scratches_175 == nil then
        __lux_tmp_scratches_175 = 0.30
      end
      local __lux_tmp_edge_176 = spec.edge
      if __lux_tmp_edge_176 == nil then
        __lux_tmp_edge_176 = spec.edgeWear
      end
      local __lux_tmp_edge_177 = toNumber(__lux_tmp_edge_176)
      if __lux_tmp_edge_177 == nil then
        __lux_tmp_edge_177 = 0.54
      end
      local __lux_tmp_grainScale_178 = toNumber(spec.grainScale)
      if __lux_tmp_grainScale_178 == nil then
        __lux_tmp_grainScale_178 = 5.6
      end
      local __lux_tmp_scratchScale_179 = toNumber(spec.scratchScale)
      if __lux_tmp_scratchScale_179 == nil then
        __lux_tmp_scratchScale_179 = 26
      end
      local __lux_tmp_scratchWidth_180 = toNumber(spec.scratchWidth)
      if __lux_tmp_scratchWidth_180 == nil then
        __lux_tmp_scratchWidth_180 = 0.045
      end
      local __lux_tmp_edgeWidth_181 = toNumber(spec.edgeWidth)
      if __lux_tmp_edgeWidth_181 == nil then
        __lux_tmp_edgeWidth_181 = 7
      end
      local __lux_tmp_softness_182 = toNumber(spec.softness)
      if __lux_tmp_softness_182 == nil then
        __lux_tmp_softness_182 = 0.10
      end
      local __lux_tmp_warp_183 = toNumber(spec.warp)
      if __lux_tmp_warp_183 == nil then
        __lux_tmp_warp_183 = 0.035
      end
      return setupPrimitiveAuxConstants(
        material,
        er,
        eg,
        eb,
        ea,
        mathClamp(__lux_tmp_fractal_172, 0, 1),
        mathClamp(__lux_tmp_grain_173, 0, 1),
        mathClamp(__lux_tmp_scratches_175, 0, 1),
        mathClamp(__lux_tmp_edge_177, 0, 1),
        mathMax(0.25, __lux_tmp_grainScale_178),
        mathMax(1, __lux_tmp_scratchScale_179),
        mathClamp(__lux_tmp_scratchWidth_180, 0.005, 0.5),
        mathMax(0.5, __lux_tmp_edgeWidth_181),
        mathCos(angle),
        mathSin(angle),
        mathClamp(__lux_tmp_softness_182, 0.001, 1),
        mathMax(0, __lux_tmp_warp_183)
      )
    end
    drawChamferInnerGlowRaw = function(x, y, w, h, cuts, enabled, gr, gg, gb, ga, glowWidth, glowStrength, glowFalloff)
      if not enabled or ga <= 0 or glowStrength <= 0 or not shadersActive() or not materialOK(primitiveMaterials.chamfer_innerglow) then
        return false
      end
      local tl, tr, br, bl = chamferTuple(cuts, w, h)
      local material = primitiveMaterials.chamfer_innerglow
      do
        local __lux_tmp_glowWidth_184 = toNumber(glowWidth)
        if __lux_tmp_glowWidth_184 == nil then
          __lux_tmp_glowWidth_184 = 8
        end
        local __lux_tmp_glowStrength_185 = toNumber(glowStrength)
        if __lux_tmp_glowStrength_185 == nil then
          __lux_tmp_glowStrength_185 = 1
        end
        local __lux_tmp_glowFalloff_186 = toNumber(glowFalloff)
        if __lux_tmp_glowFalloff_186 == nil then
          __lux_tmp_glowFalloff_186 = 1.65
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
          mathMax(0.001, __lux_tmp_glowWidth_184),
          mathMax(0, __lux_tmp_glowStrength_185),
          mathMax(0.001, __lux_tmp_glowFalloff_186),
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
        local __lux_tmp_grow_187 = toNumber(grow)
        if __lux_tmp_grow_187 == nil then
          __lux_tmp_grow_187 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_187)
      end
      if grow <= 0 then
        return cuts
      end
      if typeOf(cuts) == "table" and not style.isColor(cuts) then
        local __lux_tmp_tl_188 = cuts.tl
        if __lux_tmp_tl_188 == nil then
          __lux_tmp_tl_188 = cuts[1]
        end
        local __lux_tmp_tl_189 = toNumber(__lux_tmp_tl_188)
        if __lux_tmp_tl_189 == nil then
          __lux_tmp_tl_189 = 0
        end
        local __lux_tmp_tr_190 = cuts.tr
        if __lux_tmp_tr_190 == nil then
          __lux_tmp_tr_190 = cuts[2]
        end
        if __lux_tmp_tr_190 == nil then
          __lux_tmp_tr_190 = cuts.tl
        end
        if __lux_tmp_tr_190 == nil then
          __lux_tmp_tr_190 = cuts[1]
        end
        local __lux_tmp_tr_191 = toNumber(__lux_tmp_tr_190)
        if __lux_tmp_tr_191 == nil then
          __lux_tmp_tr_191 = 0
        end
        local __lux_tmp_br_192 = cuts.br
        if __lux_tmp_br_192 == nil then
          __lux_tmp_br_192 = cuts[3]
        end
        if __lux_tmp_br_192 == nil then
          __lux_tmp_br_192 = cuts.tr
        end
        if __lux_tmp_br_192 == nil then
          __lux_tmp_br_192 = cuts[2]
        end
        if __lux_tmp_br_192 == nil then
          __lux_tmp_br_192 = cuts.tl
        end
        if __lux_tmp_br_192 == nil then
          __lux_tmp_br_192 = cuts[1]
        end
        local __lux_tmp_br_193 = toNumber(__lux_tmp_br_192)
        if __lux_tmp_br_193 == nil then
          __lux_tmp_br_193 = 0
        end
        local __lux_tmp_bl_194 = cuts.bl
        if __lux_tmp_bl_194 == nil then
          __lux_tmp_bl_194 = cuts[4]
        end
        if __lux_tmp_bl_194 == nil then
          __lux_tmp_bl_194 = cuts.br
        end
        if __lux_tmp_bl_194 == nil then
          __lux_tmp_bl_194 = cuts[3]
        end
        if __lux_tmp_bl_194 == nil then
          __lux_tmp_bl_194 = cuts.tr
        end
        if __lux_tmp_bl_194 == nil then
          __lux_tmp_bl_194 = cuts[2]
        end
        if __lux_tmp_bl_194 == nil then
          __lux_tmp_bl_194 = cuts.tl
        end
        if __lux_tmp_bl_194 == nil then
          __lux_tmp_bl_194 = cuts[1]
        end
        local __lux_tmp_bl_195 = toNumber(__lux_tmp_bl_194)
        if __lux_tmp_bl_195 == nil then
          __lux_tmp_bl_195 = 0
        end
        return {
          tl = mathMax(0, __lux_tmp_tl_189) + grow,
          tr = mathMax(0, __lux_tmp_tr_191) + grow,
          br = mathMax(0, __lux_tmp_br_193) + grow,
          bl = mathMax(0, __lux_tmp_bl_195) + grow,
        }
      end
      local __lux_tmp_cuts_196 = toNumber(cuts)
      if __lux_tmp_cuts_196 == nil then
        __lux_tmp_cuts_196 = 0
      end
      return __lux_tmp_cuts_196 + grow
    end
    chamferEffectBounds = function(x, y, w, h, cuts, enabled, alpha, ox, oy, width, extent, grow, strength, falloff, biasOffset)
      if biasOffset == nil then
        biasOffset = false
      end
      if not enabled or alpha <= 0 or strength <= 0 then
        return nil
      end
      do
        local __lux_tmp_grow_197 = toNumber(grow)
        if __lux_tmp_grow_197 == nil then
          __lux_tmp_grow_197 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_197)
      end
      do
        local __lux_tmp_ox_198 = toNumber(ox)
        if __lux_tmp_ox_198 == nil then
          __lux_tmp_ox_198 = 0
        end
        ox = __lux_tmp_ox_198
      end
      do
        local __lux_tmp_oy_199 = toNumber(oy)
        if __lux_tmp_oy_199 == nil then
          __lux_tmp_oy_199 = 0
        end
        oy = __lux_tmp_oy_199
      end
      do
        local __lux_tmp_width_200 = toNumber(width)
        if __lux_tmp_width_200 == nil then
          __lux_tmp_width_200 = 18
        end
        width = mathMax(0.001, __lux_tmp_width_200)
      end
      do
        local __lux_tmp_extent_201 = toNumber(extent)
        if __lux_tmp_extent_201 == nil then
          __lux_tmp_extent_201 = width
        end
        extent = mathMax(1, __lux_tmp_extent_201)
      end
      do
        local __lux_tmp_strength_202 = toNumber(strength)
        if __lux_tmp_strength_202 == nil then
          __lux_tmp_strength_202 = 1
        end
        strength = mathMax(0, __lux_tmp_strength_202)
      end
      do
        local __lux_tmp_falloff_203 = toNumber(falloff)
        if __lux_tmp_falloff_203 == nil then
          __lux_tmp_falloff_203 = 1.9
        end
        falloff = mathMax(0.001, __lux_tmp_falloff_203)
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
        local __lux_tmp_204
        if shadowBounds ~= nil then
          __lux_tmp_204 = shadowBounds.width
        else
          __lux_tmp_204 = 1
        end
        local __lux_tmp_205
        if shadowBounds ~= nil then
          __lux_tmp_205 = shadowBounds.strength
        else
          __lux_tmp_205 = 0
        end
        local __lux_tmp_206
        if shadowBounds ~= nil then
          __lux_tmp_206 = sr
        else
          __lux_tmp_206 = 0
        end
        local __lux_tmp_207
        if shadowBounds ~= nil then
          __lux_tmp_207 = sg
        else
          __lux_tmp_207 = 0
        end
        local __lux_tmp_208
        if shadowBounds ~= nil then
          __lux_tmp_208 = sb
        else
          __lux_tmp_208 = 0
        end
        local __lux_tmp_209
        if shadowBounds ~= nil then
          __lux_tmp_209 = sa
        else
          __lux_tmp_209 = 0
        end
        local __lux_obj_shadowBounds_210 = shadowBounds
        local __lux_tmp_shapeX_211 = nil
        if __lux_obj_shadowBounds_210 ~= nil then
          __lux_tmp_shapeX_211 = __lux_obj_shadowBounds_210.shapeX
        end
        if __lux_tmp_shapeX_211 == nil then
          __lux_tmp_shapeX_211 = x
        end
        local __lux_obj_shadowBounds_212 = shadowBounds
        local __lux_tmp_shapeY_213 = nil
        if __lux_obj_shadowBounds_212 ~= nil then
          __lux_tmp_shapeY_213 = __lux_obj_shadowBounds_212.shapeY
        end
        if __lux_tmp_shapeY_213 == nil then
          __lux_tmp_shapeY_213 = y
        end
        local __lux_obj_shadowBounds_214 = shadowBounds
        local __lux_tmp_shapeW_215 = nil
        if __lux_obj_shadowBounds_214 ~= nil then
          __lux_tmp_shapeW_215 = __lux_obj_shadowBounds_214.shapeW
        end
        if __lux_tmp_shapeW_215 == nil then
          __lux_tmp_shapeW_215 = w
        end
        local __lux_obj_shadowBounds_216 = shadowBounds
        local __lux_tmp_shapeH_217 = nil
        if __lux_obj_shadowBounds_216 ~= nil then
          __lux_tmp_shapeH_217 = __lux_obj_shadowBounds_216.shapeH
        end
        if __lux_tmp_shapeH_217 == nil then
          __lux_tmp_shapeH_217 = h
        end
        local __lux_obj_shadowBounds_218 = shadowBounds
        local __lux_tmp_tl_219 = nil
        if __lux_obj_shadowBounds_218 ~= nil then
          __lux_tmp_tl_219 = __lux_obj_shadowBounds_218.tl
        end
        if __lux_tmp_tl_219 == nil then
          __lux_tmp_tl_219 = 0
        end
        local __lux_obj_shadowBounds_220 = shadowBounds
        local __lux_tmp_tr_221 = nil
        if __lux_obj_shadowBounds_220 ~= nil then
          __lux_tmp_tr_221 = __lux_obj_shadowBounds_220.tr
        end
        if __lux_tmp_tr_221 == nil then
          __lux_tmp_tr_221 = 0
        end
        local __lux_obj_shadowBounds_222 = shadowBounds
        local __lux_tmp_br_223 = nil
        if __lux_obj_shadowBounds_222 ~= nil then
          __lux_tmp_br_223 = __lux_obj_shadowBounds_222.br
        end
        if __lux_tmp_br_223 == nil then
          __lux_tmp_br_223 = 0
        end
        local __lux_obj_shadowBounds_224 = shadowBounds
        local __lux_tmp_bl_225 = nil
        if __lux_obj_shadowBounds_224 ~= nil then
          __lux_tmp_bl_225 = __lux_obj_shadowBounds_224.bl
        end
        if __lux_tmp_bl_225 == nil then
          __lux_tmp_bl_225 = 0
        end
        setupParamMatrix(
          material,
          sw,
          sh,
          __lux_tmp_204,
          __lux_tmp_205,
          __lux_tmp_206,
          __lux_tmp_207,
          __lux_tmp_208,
          __lux_tmp_209,
          __lux_tmp_shapeX_211 - sx,
          __lux_tmp_shapeY_213 - sy,
          __lux_tmp_shapeW_215,
          __lux_tmp_shapeH_217,
          __lux_tmp_tl_219,
          __lux_tmp_tr_221,
          __lux_tmp_br_223,
          __lux_tmp_bl_225
        )
      end
      do
        local __lux_tmp_226
        if outerBounds ~= nil then
          __lux_tmp_226 = orr
        else
          __lux_tmp_226 = 0
        end
        local __lux_tmp_227
        if outerBounds ~= nil then
          __lux_tmp_227 = og
        else
          __lux_tmp_227 = 0
        end
        local __lux_tmp_228
        if outerBounds ~= nil then
          __lux_tmp_228 = ob
        else
          __lux_tmp_228 = 0
        end
        local __lux_tmp_229
        if outerBounds ~= nil then
          __lux_tmp_229 = oa
        else
          __lux_tmp_229 = 0
        end
        local __lux_obj_outerBounds_230 = outerBounds
        local __lux_tmp_shapeX_231 = nil
        if __lux_obj_outerBounds_230 ~= nil then
          __lux_tmp_shapeX_231 = __lux_obj_outerBounds_230.shapeX
        end
        if __lux_tmp_shapeX_231 == nil then
          __lux_tmp_shapeX_231 = x
        end
        local __lux_obj_outerBounds_232 = outerBounds
        local __lux_tmp_shapeY_233 = nil
        if __lux_obj_outerBounds_232 ~= nil then
          __lux_tmp_shapeY_233 = __lux_obj_outerBounds_232.shapeY
        end
        if __lux_tmp_shapeY_233 == nil then
          __lux_tmp_shapeY_233 = y
        end
        local __lux_obj_outerBounds_234 = outerBounds
        local __lux_tmp_shapeW_235 = nil
        if __lux_obj_outerBounds_234 ~= nil then
          __lux_tmp_shapeW_235 = __lux_obj_outerBounds_234.shapeW
        end
        if __lux_tmp_shapeW_235 == nil then
          __lux_tmp_shapeW_235 = w
        end
        local __lux_obj_outerBounds_236 = outerBounds
        local __lux_tmp_shapeH_237 = nil
        if __lux_obj_outerBounds_236 ~= nil then
          __lux_tmp_shapeH_237 = __lux_obj_outerBounds_236.shapeH
        end
        if __lux_tmp_shapeH_237 == nil then
          __lux_tmp_shapeH_237 = h
        end
        local __lux_obj_outerBounds_238 = outerBounds
        local __lux_tmp_tl_239 = nil
        if __lux_obj_outerBounds_238 ~= nil then
          __lux_tmp_tl_239 = __lux_obj_outerBounds_238.tl
        end
        if __lux_tmp_tl_239 == nil then
          __lux_tmp_tl_239 = 0
        end
        local __lux_obj_outerBounds_240 = outerBounds
        local __lux_tmp_tr_241 = nil
        if __lux_obj_outerBounds_240 ~= nil then
          __lux_tmp_tr_241 = __lux_obj_outerBounds_240.tr
        end
        if __lux_tmp_tr_241 == nil then
          __lux_tmp_tr_241 = 0
        end
        local __lux_obj_outerBounds_242 = outerBounds
        local __lux_tmp_br_243 = nil
        if __lux_obj_outerBounds_242 ~= nil then
          __lux_tmp_br_243 = __lux_obj_outerBounds_242.br
        end
        if __lux_tmp_br_243 == nil then
          __lux_tmp_br_243 = 0
        end
        local __lux_obj_outerBounds_244 = outerBounds
        local __lux_tmp_bl_245 = nil
        if __lux_obj_outerBounds_244 ~= nil then
          __lux_tmp_bl_245 = __lux_obj_outerBounds_244.bl
        end
        if __lux_tmp_bl_245 == nil then
          __lux_tmp_bl_245 = 0
        end
        local __lux_tmp_246
        if shadowBounds ~= nil then
          __lux_tmp_246 = shadowBounds.falloff
        else
          __lux_tmp_246 = 1
        end
        local __lux_tmp_247
        if outerBounds ~= nil then
          __lux_tmp_247 = outerBounds.width
        else
          __lux_tmp_247 = 1
        end
        local __lux_tmp_248
        if outerBounds ~= nil then
          __lux_tmp_248 = outerBounds.strength
        else
          __lux_tmp_248 = 0
        end
        local __lux_tmp_249
        if outerBounds ~= nil then
          __lux_tmp_249 = outerBounds.falloff
        else
          __lux_tmp_249 = 1
        end
        setupPrimitiveAuxConstants(
          material,
          __lux_tmp_226,
          __lux_tmp_227,
          __lux_tmp_228,
          __lux_tmp_229,
          __lux_tmp_shapeX_231 - sx,
          __lux_tmp_shapeY_233 - sy,
          __lux_tmp_shapeW_235,
          __lux_tmp_shapeH_237,
          __lux_tmp_tl_239,
          __lux_tmp_tr_241,
          __lux_tmp_br_243,
          __lux_tmp_bl_245,
          __lux_tmp_246,
          __lux_tmp_247,
          __lux_tmp_248,
          __lux_tmp_249
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
      local __lux_tmp_r_252 = tint.r
      if __lux_tmp_r_252 == nil then
        __lux_tmp_r_252 = 0
      end
      local __lux_tmp_g_253 = tint.g
      if __lux_tmp_g_253 == nil then
        __lux_tmp_g_253 = 0
      end
      local __lux_tmp_b_254 = tint.b
      if __lux_tmp_b_254 == nil then
        __lux_tmp_b_254 = 0
      end
      return makeColor(
        __lux_tmp_r_252,
        __lux_tmp_g_253,
        __lux_tmp_b_254,
        mathFloor(mathClamp(alpha, 0, 255) + 0.5)
      )
    end
    drawChamferBackdrop = function(x, y, w, h, cuts, spec)
      if spec == nil or not shadersActive() then
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
      local __lux_tmp_258 = color ~= nil
      if __lux_tmp_258 then
        local __lux_tmp_a_257 = color.a
        if __lux_tmp_a_257 == nil then
          __lux_tmp_a_257 = 255
        end
        __lux_tmp_258 = __lux_tmp_a_257 <= 0
      end
      if __lux_tmp_258 then
        return false
      end
      local tl, tr, br, bl = chamferTuple(cuts, w, h)
      local angle
      do
        local __lux_tmp_angle_259 = toNumber(spec.angle)
        if __lux_tmp_angle_259 == nil then
          __lux_tmp_angle_259 = 135
        end
        angle = mathRad(__lux_tmp_angle_259)
      end
      local smoke
      local __lux_match_260 = spec.kind
      if __lux_match_260 == "smoke" then
        smoke = true
      else
        smoke = false
      end
      local worn
      local __lux_match_261 = spec.kind
      if __lux_match_261 == "worn" then
        worn = true
      else
        worn = false
      end
      local material = primitiveMaterials.chamfer_pattern
      local r, g, b, a
      do
        local __lux_tmp_color_262 = spec.color
        if __lux_tmp_color_262 == nil then
          __lux_tmp_color_262 = spec.tint
        end
        r, g, b, a = style.color01(style.asColor(__lux_tmp_color_262, makeColor(255, 255, 255, 24)))
      end
      local pz = 1
      local pw = 1
      if worn then
        do
          local __lux_tmp_scale_263 = toNumber(spec.scale)
          if __lux_tmp_scale_263 == nil then
            __lux_tmp_scale_263 = 32
          end
          pz = mathMax(1, __lux_tmp_scale_263)
        end
        do
          local __lux_tmp_edgeWidth_264 = toNumber(spec.edgeWidth)
          if __lux_tmp_edgeWidth_264 == nil then
            __lux_tmp_edgeWidth_264 = 7
          end
          pw = mathMax(0.5, __lux_tmp_edgeWidth_264)
        end
      else
        if smoke then
          local density
          do
            local __lux_tmp_density_265 = toNumber(spec.density)
            if __lux_tmp_density_265 == nil then
              __lux_tmp_density_265 = 0.48
            end
            density = mathClamp(mathFloor(__lux_tmp_density_265 * 255 + 0.5), 0, 255)
          end
          local softness
          do
            local __lux_tmp_softness_266 = toNumber(spec.softness)
            if __lux_tmp_softness_266 == nil then
              __lux_tmp_softness_266 = 0.3
            end
            softness = mathClamp(mathFloor(__lux_tmp_softness_266 * 255 + 0.5), 0, 255)
          end
          local warp
          do
            local __lux_tmp_warp_267 = toNumber(spec.warp)
            if __lux_tmp_warp_267 == nil then
              __lux_tmp_warp_267 = 0.85
            end
            warp = mathClamp(mathFloor(__lux_tmp_warp_267 * 255 + 0.5), 0, 255)
          end
          do
            local __lux_tmp_scale_268 = toNumber(spec.scale)
            if __lux_tmp_scale_268 == nil then
              __lux_tmp_scale_268 = 140
            end
            pz = mathMax(1, __lux_tmp_scale_268)
          end
          pw = density + softness * 256 + warp * 65536
        else
          do
            local __lux_tmp_spacing_269 = toNumber(spec.spacing)
            if __lux_tmp_spacing_269 == nil then
              __lux_tmp_spacing_269 = 12
            end
            pz = mathMax(1, __lux_tmp_spacing_269)
          end
          do
            local __lux_tmp_width_270 = toNumber(spec.width)
            if __lux_tmp_width_270 == nil then
              __lux_tmp_width_270 = 2
            end
            pw = mathMax(0.25, __lux_tmp_width_270)
          end
        end
      end
      do
        local __lux_tmp_272 = smoke or worn
        if __lux_tmp_272 then
          local __lux_tmp_seed_271 = toNumber(spec.seed)
          if __lux_tmp_seed_271 == nil then
            __lux_tmp_seed_271 = 0
          end
          __lux_tmp_272 = __lux_tmp_seed_271
        end
        local __lux_tmp_273 = __lux_tmp_272
        if not __lux_tmp_273 then
          __lux_tmp_273 = 0
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
          (smoke and 1 or 0) + (worn and 2 or 0) + __lux_tmp_273,
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
          local __lux_tmp_glowWidth_274 = toNumber(glowWidth)
          if __lux_tmp_glowWidth_274 == nil then
            __lux_tmp_glowWidth_274 = 8
          end
          glowWidth = mathMax(0.001, __lux_tmp_glowWidth_274)
        end
        do
          local __lux_tmp_glowStrength_275 = toNumber(glowStrength)
          if __lux_tmp_glowStrength_275 == nil then
            __lux_tmp_glowStrength_275 = 1
          end
          glowStrength = mathMax(0, __lux_tmp_glowStrength_275)
        end
        do
          local __lux_tmp_glowFalloff_276 = toNumber(glowFalloff)
          if __lux_tmp_glowFalloff_276 == nil then
            __lux_tmp_glowFalloff_276 = 1.65
          end
          glowFalloff = mathMax(0.001, __lux_tmp_glowFalloff_276)
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
        local __lux_tmp_fill_277 = fill
        if __lux_tmp_fill_277 == nil then
          __lux_tmp_fill_277 = transparentFill
        end
        setupPrimitiveFillConstants(material, w, h, __lux_tmp_fill_277, stroke, strokeWidth, 0)
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h, material)
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
      local strokeWidth = style.strokeWidthValue(strokeWidthInput, 0)
      local fillVisible = hotFillVisible(fill)
      local strokeVisible = style.strokeVisible(stroke, strokeWidth)
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
      if fillVisible or strokeVisible or hasInner then
        if patternSpec == nil then
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
          baseDrewStroke = baseDrawn and strokeVisible
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
        if not drawChamferStroke(x, y, w, h, cuts, stroke, strokeWidth) then
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
      local __lux_tmp_resolvedCuts_278 = resolvedCuts
      if __lux_tmp_resolvedCuts_278 == nil then
        __lux_tmp_resolvedCuts_278 = resolved.cuts
      end
      if __lux_tmp_resolvedCuts_278 == nil then
        __lux_tmp_resolvedCuts_278 = 0
      end
      local __lux_tmp_fill_279 = resolved.fill
      if __lux_tmp_fill_279 == nil then
        __lux_tmp_fill_279 = resolved.color
      end
      return drawChamferBoxRaw(
        x,
        y,
        w,
        h,
        __lux_tmp_resolvedCuts_278,
        __lux_tmp_fill_279,
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
        local __lux_tmp_sides_280 = toNumber(sides)
        if __lux_tmp_sides_280 == nil then
          __lux_tmp_sides_280 = 3
        end
        count = mathClamp(mathFloor(__lux_tmp_sides_280), 3, 8)
      end
      local r
      do
        local __lux_tmp_radius_281 = toNumber(radius)
        if __lux_tmp_radius_281 == nil then
          __lux_tmp_radius_281 = 0
        end
        r = mathMax(0, __lux_tmp_radius_281)
      end
      local start
      do
        local __lux_tmp_rotation_282 = toNumber(rotation)
        if __lux_tmp_rotation_282 == nil then
          __lux_tmp_rotation_282 = -90
        end
        start = mathRad(__lux_tmp_rotation_282)
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
        local __lux_tmp_direction_283 = direction
        if __lux_tmp_direction_283 == nil then
          __lux_tmp_direction_283 = "right"
        end
        local __lux_match_284 = __lux_tmp_direction_283
        if __lux_match_284 == "up" then
          setPoint(caretScratch, 1, x + w * 0.5, y)
          setPoint(caretScratch, 2, x + w, y + h)
          setPoint(caretScratch, 3, x, y + h)
        elseif __lux_match_284 == "down" then
          setPoint(caretScratch, 1, x, y)
          setPoint(caretScratch, 2, x + w, y)
          setPoint(caretScratch, 3, x + w * 0.5, y + h)
        elseif __lux_match_284 == "left" then
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
      local __lux_tmp_rotation_285 = resolved.rotation
      if __lux_tmp_rotation_285 == nil then
        __lux_tmp_rotation_285 = resolved.angle
      end
      return polyEx(regularPolyPoints(cx, cy, radius, sides, __lux_tmp_rotation_285), resolved)
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
      local __lux_tmp_direction_286 = resolved.direction
      if __lux_tmp_direction_286 == nil then
        __lux_tmp_direction_286 = resolved.dir
      end
      return polyEx(caretPoints(x, y, w, h, __lux_tmp_direction_286), resolved)
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
            return chamferBoxEx(x, y, w, h, stripped)
          end
        )
      end
      return drawChamferBoxImmediate(x, y, w, h, stripped, cuts)
    end
    chamferBox = function(x, y, w, h, cuts, fill, stroke, strokeWidth)
      local __lux_tmp_cuts_287 = cuts
      if __lux_tmp_cuts_287 == nil then
        __lux_tmp_cuts_287 = 0
      end
      return drawChamferBoxRaw(x, y, w, h, __lux_tmp_cuts_287, fill, stroke, strokeWidth)
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
