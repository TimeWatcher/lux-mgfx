return function(__lux_import)
  local __lux_exports = {}
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
  local renderCopyRenderTargetToTexture
  local surfaceDrawLine
  local surfaceSetMaterial
  local surfaceSetDrawColor
  local toNumber
  local typeOf
  local makeColor
  local drawTransformedPoly
  local drawTexturedQuad
  local hasTransform
  local splitStyleTransform
  local withTransform
  local paramMatrixProbe
  local paramMatrixSetUnpacked
  local paramMatrices
  local primitiveMaterials
  local primitiveBlurRT
  local primitiveMatOK
  local primitiveHasShaders
  local forceFallbackCvar
  local lineVertsScratch
  local lineFallbackVertsScratch
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
  local chamferTuple
  local chamferPoints
  local signedArea
  local isConvex
  local normalizePoly
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
  local setupPrimitiveBlurConstants
  local blurIntensity
  local drawBlurredPoly
  local polyBackdropTintColor
  local drawPolyBackdrop
  local polyShadowBounds
  local shadowVertex
  local setupPolyShadowAuxConstants
  local setupPolyShadowConstants
  local drawPolyShadow
  local drawPolyPattern
  local setupPolyStrokeConstants
  local drawPolyStrokeShader
  local drawPolyStroke
  local drawPolyFallback
  local drawPolyImmediate
  local chamferFillFallbackStyle
  local chamferStrokeFallbackStyle
  local transparentFill
  local chamferFillParams
  local setupPrimitiveAuxConstants
  local setupPrimitiveFillConstants
  local drawChamferInnerGlowSpec
  local cutsWithGrow
  local drawChamferOuterGlowSpec
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
    local geometryImport = __lux_import("lux/mgfx/geometry#client")
    local roundrectImport = __lux_import("lux/mgfx/roundrect#client")
    local styleImport = __lux_import("lux/mgfx/style#client")
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
    hasTransform = geometry.hasTransform
    splitStyleTransform = geometry.splitStyleTransform
    withTransform = geometry.withTransform
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
      if resolved.radius ~= nil or resolved.outerGlow ~= nil or resolved.backdrop ~= nil then
        local __lux_tmp_radius_52 = resolved.radius
        if __lux_tmp_radius_52 == nil then
          __lux_tmp_radius_52 = 0
        end
        return roundrect.roundedBoxEx(
          x,
          y,
          w,
          h,
          {
            radius = __lux_tmp_radius_52,
            backdrop = resolved.backdrop,
            fill = fill,
            outerGlow = resolved.outerGlow,
          }
        )
      end
      return drawTransformedPoly(
        {
          { x = x, y = y },
          { x = x + w, y = y },
          { x = x + w, y = y + h },
          { x = x, y = y + h },
        }
      )
    end
    drawLineFallbackVerts = function(verts, fill, backdrop)
      return polyEx(
        {
          { x = verts[1].x, y = verts[1].y },
          { x = verts[2].x, y = verts[2].y },
          { x = verts[3].x, y = verts[3].y },
          { x = verts[4].x, y = verts[4].y },
        },
        { backdrop = backdrop, fill = fill }
      )
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
      if resolved.radius == nil and resolved.outerGlow == nil and drawLineShaderVerts(verts, fill) then
        return
      end
      local fallbackVerts = lineQuadVertsInto(lineFallbackVertsScratch, x1, y1, x2, y2, strokeWidth, noCaps, 0)
      local __lux_tmp_fallbackVerts_53 = fallbackVerts
      if __lux_tmp_fallbackVerts_53 == nil then
        __lux_tmp_fallbackVerts_53 = verts
      end
      return drawLineFallbackVerts(__lux_tmp_fallbackVerts_53, fill, nil)
    end
    drawLineImmediate = function(x1, y1, x2, y2, color, width, drawStyle)
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local strokeWidth
      do
        local __lux_tmp_width_54 = width
        if __lux_tmp_width_54 == nil then
          __lux_tmp_width_54 = resolved.width
        end
        if __lux_tmp_width_54 == nil then
          __lux_tmp_width_54 = resolved.strokeWidth
        end
        strokeWidth = mathMax(0, style.strokeWidth(__lux_tmp_width_54, 1))
      end
      if strokeWidth <= 0 then
        return
      end
      local fill
      do
        local __lux_tmp_fill_55 = resolved.fill
        if __lux_tmp_fill_55 == nil then
          __lux_tmp_fill_55 = resolved.color
        end
        if __lux_tmp_fill_55 == nil then
          __lux_tmp_fill_55 = color
        end
        if __lux_tmp_fill_55 == nil then
          __lux_tmp_fill_55 = defaultLineColor
        end
        fill = style.fillFromStyle(__lux_tmp_fill_55)
      end
      if not style.fillVisible(fill) and resolved.backdrop == nil then
        return
      end
      local __lux_cmp_56 = false
      if mathAbs(y2 - y1) ~= nil then
        __lux_cmp_56 = mathAbs(y2 - y1) < 0.001
      end
      if __lux_cmp_56 then
        local x = mathMin(x1, x2)
        local w = mathAbs(x2 - x1)
        if w <= 0 then
          return
        end
        local y = y1 - strokeWidth * 0.5
        if resolved.radius ~= nil or resolved.outerGlow ~= nil then
          return drawLineRect(x, y, w, strokeWidth, fill, resolved)
        end
      end
      local __lux_cmp_57 = false
      if mathAbs(x2 - x1) ~= nil then
        __lux_cmp_57 = mathAbs(x2 - x1) < 0.001
      end
      if __lux_cmp_57 then
        local y = mathMin(y1, y2)
        local h = mathAbs(y2 - y1)
        if h <= 0 then
          return
        end
        local x = x1 - strokeWidth * 0.5
        if resolved.radius ~= nil or resolved.outerGlow ~= nil then
          return drawLineRect(x, y, strokeWidth, h, fill, resolved)
        end
      end
      local noCaps = resolved.noCaps == true
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
        local __lux_tmp_width_58 = stripped.width
        if __lux_tmp_width_58 == nil then
          __lux_tmp_width_58 = stripped.strokeWidth
        end
        width = mathMax(1, style.strokeWidth(__lux_tmp_width_58, 1))
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
    setupPrimitiveBlurConstants = function(material, w, h, vertical, intensity, radius)
      if radius == nil then
        radius = 0
      end
      local __lux_tmp_intensity_59 = intensity
      if __lux_tmp_intensity_59 == nil then
        __lux_tmp_intensity_59 = 1
      end
      local __lux_tmp_radius_60 = toNumber(radius)
      if __lux_tmp_radius_60 == nil then
        __lux_tmp_radius_60 = 0
      end
      return setupParamMatrix(
        material,
        vertical and 1 or 0,
        __lux_tmp_intensity_59,
        0,
        0,
        w,
        h,
        0,
        mathMax(0, __lux_tmp_radius_60),
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
    blurIntensity = function(amount)
      local __lux_tmp_amount_61 = toNumber(amount)
      if __lux_tmp_amount_61 == nil then
        __lux_tmp_amount_61 = 1
      end
      return mathMax(0.001, __lux_tmp_amount_61)
    end
    drawBlurredPoly = function(poly, material, amount)
      if material == nil or primitiveBlurRT == nil or renderCopyRenderTargetToTexture == nil then
        return false
      end
      surfaceSetDrawColor(255, 255, 255, 255)
      renderCopyRenderTargetToTexture(primitiveBlurRT)
      setupPrimitiveBlurConstants(material, poly.w, poly.h, false, blurIntensity(amount), 0)
      drawMaterialPoly(poly, material)
      renderCopyRenderTargetToTexture(primitiveBlurRT)
      setupPrimitiveBlurConstants(material, poly.w, poly.h, true, blurIntensity(amount), 0)
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
        local __lux_tmp_a_62 = tint.a
        if __lux_tmp_a_62 == nil then
          __lux_tmp_a_62 = 255
        end
        local __lux_tmp_opacity_63 = spec.opacity
        if __lux_tmp_opacity_63 == nil then
          __lux_tmp_opacity_63 = 1
        end
        alpha = __lux_tmp_a_62 * __lux_tmp_opacity_63
      end
      if alpha <= 0 then
        return nil
      end
      do
        local __lux_tmp_r_64 = tint.r
        if __lux_tmp_r_64 == nil then
          __lux_tmp_r_64 = 0
        end
        polyBackdropTintScratch.r = __lux_tmp_r_64
      end
      do
        local __lux_tmp_g_65 = tint.g
        if __lux_tmp_g_65 == nil then
          __lux_tmp_g_65 = 0
        end
        polyBackdropTintScratch.g = __lux_tmp_g_65
      end
      do
        local __lux_tmp_b_66 = tint.b
        if __lux_tmp_b_66 == nil then
          __lux_tmp_b_66 = 0
        end
        polyBackdropTintScratch.b = __lux_tmp_b_66
      end
      polyBackdropTintScratch.a = mathFloor(mathClamp(alpha, 0, 255) + 0.5)
      return polyBackdropTintScratch
    end
    drawPolyBackdrop = function(poly, backdrop)
      local spec = style.backdropStyle(backdrop)
      if spec == nil then
        return nil
      end
      if spec.blur > 0 then
        drawBlurredPoly(poly, primitiveMaterials[polyMaterialKey(poly, "_blur")], spec.blur)
      end
      local tint = polyBackdropTintColor(spec)
      if tint ~= nil then
        local material = primitiveMaterials[polyMaterialKey(poly)]
        if materialOK(material) then
          setupPrimitiveFillConstants(material, poly.w, poly.h, style.solid(tint), nil, 0, 0)
          drawMaterialPoly(poly, material)
        end
      end
      return spec
    end
    polyShadowBounds = function(poly, shadow)
      local __lux_tmp_69 = shadow == nil or shadow.color == nil
      if not __lux_tmp_69 then
        local __lux_tmp_a_68 = shadow.color.a
        if __lux_tmp_a_68 == nil then
          __lux_tmp_a_68 = 255
        end
        __lux_tmp_69 = __lux_tmp_a_68 <= 0
      end
      if __lux_tmp_69 then
        return nil
      end
      local width
      do
        local __lux_tmp_width_70 = toNumber(shadow.width)
        if __lux_tmp_width_70 == nil then
          __lux_tmp_width_70 = 12
        end
        width = mathMax(0.001, __lux_tmp_width_70)
      end
      local grow
      do
        local __lux_tmp_grow_71 = toNumber(shadow.grow)
        if __lux_tmp_grow_71 == nil then
          __lux_tmp_grow_71 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_71)
      end
      local spread
      do
        local __lux_tmp_spread_72 = toNumber(shadow.spread)
        if __lux_tmp_spread_72 == nil then
          __lux_tmp_spread_72 = width
        end
        spread = mathMax(1, __lux_tmp_spread_72)
      end
      local padding = grow + mathMax(spread, width)
      local ox = toNumber(shadow.x)
      if ox == nil then
        ox = 0
      end
      local oy = toNumber(shadow.y)
      if oy == nil then
        oy = 0
      end
      local __lux_tmp_falloff_73 = toNumber(shadow.falloff)
      if __lux_tmp_falloff_73 == nil then
        __lux_tmp_falloff_73 = 1.7
      end
      local __lux_tmp_strength_74 = toNumber(shadow.strength)
      if __lux_tmp_strength_74 == nil then
        __lux_tmp_strength_74 = 1
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
        falloff = mathMax(0.001, __lux_tmp_falloff_73),
        strength = mathMax(0, __lux_tmp_strength_74),
      }
    end
    shadowVertex = function(poly, point, bounds)
      if point == nil then
        return 0, 0
      end
      return poly.x + point.x + bounds.ox - bounds.x, poly.y + point.y + bounds.oy - bounds.y
    end
    setupPolyShadowAuxConstants = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3)
      if material == nil then
        return false
      end
      do
        local __lux_tmp_a0_75 = a0
        if __lux_tmp_a0_75 == nil then
          __lux_tmp_a0_75 = 0
        end
        material:SetFloat("$c0_x", __lux_tmp_a0_75)
      end
      do
        local __lux_tmp_a1_76 = a1
        if __lux_tmp_a1_76 == nil then
          __lux_tmp_a1_76 = 0
        end
        material:SetFloat("$c0_y", __lux_tmp_a1_76)
      end
      do
        local __lux_tmp_a2_77 = a2
        if __lux_tmp_a2_77 == nil then
          __lux_tmp_a2_77 = 0
        end
        material:SetFloat("$c0_z", __lux_tmp_a2_77)
      end
      do
        local __lux_tmp_a3_78 = a3
        if __lux_tmp_a3_78 == nil then
          __lux_tmp_a3_78 = 0
        end
        material:SetFloat("$c0_w", __lux_tmp_a3_78)
      end
      do
        local __lux_tmp_b0_79 = b0
        if __lux_tmp_b0_79 == nil then
          __lux_tmp_b0_79 = 0
        end
        material:SetFloat("$c1_x", __lux_tmp_b0_79)
      end
      do
        local __lux_tmp_b1_80 = b1
        if __lux_tmp_b1_80 == nil then
          __lux_tmp_b1_80 = 0
        end
        material:SetFloat("$c1_y", __lux_tmp_b1_80)
      end
      do
        local __lux_tmp_b2_81 = b2
        if __lux_tmp_b2_81 == nil then
          __lux_tmp_b2_81 = 0
        end
        material:SetFloat("$c1_z", __lux_tmp_b2_81)
      end
      do
        local __lux_tmp_b3_82 = b3
        if __lux_tmp_b3_82 == nil then
          __lux_tmp_b3_82 = 0
        end
        material:SetFloat("$c1_w", __lux_tmp_b3_82)
      end
      do
        local __lux_tmp_c0_83 = c0
        if __lux_tmp_c0_83 == nil then
          __lux_tmp_c0_83 = 0
        end
        material:SetFloat("$c2_x", __lux_tmp_c0_83)
      end
      do
        local __lux_tmp_c1_84 = c1
        if __lux_tmp_c1_84 == nil then
          __lux_tmp_c1_84 = 0
        end
        material:SetFloat("$c2_y", __lux_tmp_c1_84)
      end
      do
        local __lux_tmp_c2_85 = c2
        if __lux_tmp_c2_85 == nil then
          __lux_tmp_c2_85 = 0
        end
        material:SetFloat("$c2_z", __lux_tmp_c2_85)
      end
      do
        local __lux_tmp_c3_86 = c3
        if __lux_tmp_c3_86 == nil then
          __lux_tmp_c3_86 = 0
        end
        material:SetFloat("$c2_w", __lux_tmp_c3_86)
      end
      do
        local __lux_tmp_d0_87 = d0
        if __lux_tmp_d0_87 == nil then
          __lux_tmp_d0_87 = 0
        end
        material:SetFloat("$c3_x", __lux_tmp_d0_87)
      end
      do
        local __lux_tmp_d1_88 = d1
        if __lux_tmp_d1_88 == nil then
          __lux_tmp_d1_88 = 0
        end
        material:SetFloat("$c3_y", __lux_tmp_d1_88)
      end
      do
        local __lux_tmp_d2_89 = d2
        if __lux_tmp_d2_89 == nil then
          __lux_tmp_d2_89 = 0
        end
        material:SetFloat("$c3_z", __lux_tmp_d2_89)
      end
      do
        local __lux_tmp_d3_90 = d3
        if __lux_tmp_d3_90 == nil then
          __lux_tmp_d3_90 = 0
        end
        material:SetFloat("$c3_w", __lux_tmp_d3_90)
      end
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
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(bounds.x, bounds.y, bounds.w, bounds.h)
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
      local __lux_tmp_93 = color ~= nil
      if __lux_tmp_93 then
        local __lux_tmp_a_92 = color.a
        if __lux_tmp_a_92 == nil then
          __lux_tmp_a_92 = 255
        end
        __lux_tmp_93 = __lux_tmp_a_92 <= 0
      end
      if __lux_tmp_93 then
        return false
      end
      local material = primitiveMaterials.poly_pattern
      local r, g, b, a
      do
        local __lux_tmp_color_94 = spec.color
        if __lux_tmp_color_94 == nil then
          __lux_tmp_color_94 = spec.tint
        end
        r, g, b, a = style.color01(style.asColor(__lux_tmp_color_94, makeColor(255, 255, 255, 24)))
      end
      local angle
      do
        local __lux_tmp_angle_95 = toNumber(spec.angle)
        if __lux_tmp_angle_95 == nil then
          __lux_tmp_angle_95 = 135
        end
        angle = mathRad(__lux_tmp_angle_95)
      end
      local smoke
      local __lux_match_96 = spec.kind
      if __lux_match_96 == "smoke" then
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
          local __lux_tmp_scale_97 = toNumber(spec.scale)
          if __lux_tmp_scale_97 == nil then
            __lux_tmp_scale_97 = 140
          end
          pz = mathMax(1, __lux_tmp_scale_97)
        end
        do
          local __lux_tmp_density_98 = toNumber(spec.density)
          if __lux_tmp_density_98 == nil then
            __lux_tmp_density_98 = 0.48
          end
          pw = mathClamp(__lux_tmp_density_98, 0, 1)
        end
        ox = roundrect.patternOffset(spec)
        oy = 1
        do
          local __lux_tmp_softness_99 = toNumber(spec.softness)
          if __lux_tmp_softness_99 == nil then
            __lux_tmp_softness_99 = 0.3
          end
          oz = mathMax(0.001, __lux_tmp_softness_99)
        end
        do
          local __lux_tmp_warp_100 = toNumber(spec.warp)
          if __lux_tmp_warp_100 == nil then
            __lux_tmp_warp_100 = 0.85
          end
          ow = mathMax(0, __lux_tmp_warp_100)
        end
      else
        do
          local __lux_tmp_spacing_101 = toNumber(spec.spacing)
          if __lux_tmp_spacing_101 == nil then
            __lux_tmp_spacing_101 = 12
          end
          pz = mathMax(1, __lux_tmp_spacing_101)
        end
        do
          local __lux_tmp_width_102 = toNumber(spec.width)
          if __lux_tmp_width_102 == nil then
            __lux_tmp_width_102 = 2
          end
          pw = mathMax(0.25, __lux_tmp_width_102)
        end
        ox = roundrect.patternOffset(spec)
      end
      do
        local __lux_tmp_104 = smoke
        if __lux_tmp_104 then
          local __lux_tmp_seed_103 = toNumber(spec.seed)
          if __lux_tmp_seed_103 == nil then
            __lux_tmp_seed_103 = 0
          end
          __lux_tmp_104 = __lux_tmp_seed_103
        end
        local __lux_tmp_105 = __lux_tmp_104
        if not __lux_tmp_105 then
          __lux_tmp_105 = 0
        end
        setupParamMatrix(
          material,
          r,
          g,
          b,
          a,
          poly.w,
          poly.h,
          __lux_tmp_105,
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
      local p1 = poly.points[1]
      local p2 = poly.points[2]
      local p3 = poly.points[3]
      local p4 = poly.points[4]
      if p4 == nil then
        p4 = p3
      end
      local r, g, b, a = style.color01(color)
      return setupParamMatrix(
        material,
        p1.x,
        p1.y,
        p2.x,
        p2.y,
        p3.x,
        p3.y,
        p4.x,
        p4.y,
        r,
        g,
        b,
        a,
        poly.w,
        poly.h,
        mathMax(0, style.strokeWidthValue(strokeWidth, 0)),
        poly.count
      )
    end
    drawPolyStrokeShader = function(poly, color, strokeWidth)
      if poly.count > 4 or not shadersActive() or not materialOK(primitiveMaterials.poly_stroke) then
        return false
      end
      local material = primitiveMaterials.poly_stroke
      setupPolyStrokeConstants(material, poly, color, strokeWidth)
      surfaceSetDrawColor(255, 255, 255, 255)
      return drawMaterialPoly(poly, material)
    end
    drawPolyStroke = function(poly, color, strokeWidth)
      if drawPolyStrokeShader(poly, color, strokeWidth) then
        return
      end
      local lineStyle = { width = style.strokeWidthValue(strokeWidth, 1), fill = color, noCaps = true }
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
        local __lux_tmp_fill_106 = drawStyle.fill
        if __lux_tmp_fill_106 == nil then
          __lux_tmp_fill_106 = drawStyle.color
        end
        fill = style.fillFromStyle(__lux_tmp_fill_106)
      end
      local hasFill = style.fillVisible(fill)
      local strokeWidth = style.strokeWidthValue(drawStyle.strokeWidth, 0)
      local hasStroke = style.strokeVisible(drawStyle.stroke, strokeWidth)
      if hasFill then
        style.setDrawColor(fillColor(fill))
        drawTransformedPoly(points)
      end
      if hasStroke then
        local lineStyle = { width = strokeWidth, fill = drawStyle.stroke, noCaps = true }
        for index = 1, #points do
          local a = points[index]
          local b = points[index % #points + 1]
          do
            local __lux_tmp_x_107 = a.x
            if __lux_tmp_x_107 == nil then
              __lux_tmp_x_107 = a[1]
            end
            local __lux_tmp_y_108 = a.y
            if __lux_tmp_y_108 == nil then
              __lux_tmp_y_108 = a[2]
            end
            local __lux_tmp_x_109 = b.x
            if __lux_tmp_x_109 == nil then
              __lux_tmp_x_109 = b[1]
            end
            local __lux_tmp_y_110 = b.y
            if __lux_tmp_y_110 == nil then
              __lux_tmp_y_110 = b[2]
            end
            drawLineImmediate(
              __lux_tmp_x_107,
              __lux_tmp_y_108,
              __lux_tmp_x_109,
              __lux_tmp_y_110,
              nil,
              nil,
              lineStyle
            )
          end
        end
      end
    end
    drawPolyImmediate = function(points, drawStyle)
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local poly = normalizePoly(points)
      if poly == nil then
        return
      end
      local shadow = roundrect.shadowStyle(resolved.shadow)
      local shadowBounds = polyShadowBounds(poly, shadow)
      if not shadersActive() then
        return drawPolyFallback(points, resolved)
      end
      drawPolyShadow(poly, shadow, shadowBounds)
      drawPolyBackdrop(poly, resolved.backdrop)
      local material = primitiveMaterials[polyMaterialKey(poly)]
      local fill
      do
        local __lux_tmp_fill_111 = resolved.fill
        if __lux_tmp_fill_111 == nil then
          __lux_tmp_fill_111 = resolved.color
        end
        fill = style.fillFromStyle(__lux_tmp_fill_111)
      end
      local hasFill = style.fillVisible(fill)
      local strokeWidth = style.strokeWidthValue(resolved.strokeWidth, 0)
      local hasStroke = style.strokeVisible(resolved.stroke, strokeWidth)
      if hasFill and materialOK(material) then
        setupPrimitiveFillConstants(material, poly.w, poly.h, fill, nil, 0, 0)
        drawMaterialPoly(poly, material)
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
      local __lux_match_112 = fill
      local __lux_tag_113
      if __lux_match_112 ~= nil then
        __lux_tag_113 = __lux_match_112.kind
      end
      if __lux_tag_113 == style.FILL_LINEAR then
        local x1 = __lux_match_112.x1
        local y1 = __lux_match_112.y1
        local x2 = __lux_match_112.x2
        local y2 = __lux_match_112.y2
        do
          local __lux_tmp_x1_114 = x1
          if __lux_tmp_x1_114 == nil then
            __lux_tmp_x1_114 = 0
          end
          p0 = __lux_tmp_x1_114
        end
        do
          local __lux_tmp_y1_115 = y1
          if __lux_tmp_y1_115 == nil then
            __lux_tmp_y1_115 = 0
          end
          p1 = __lux_tmp_y1_115
        end
        do
          local __lux_tmp_x2_116 = x2
          if __lux_tmp_x2_116 == nil then
            __lux_tmp_x2_116 = 1
          end
          p2 = __lux_tmp_x2_116
        end
        do
          local __lux_tmp_y2_117 = y2
          if __lux_tmp_y2_117 == nil then
            __lux_tmp_y2_117 = 1
          end
          p3 = __lux_tmp_y2_117
        end
        style.bindGradientLut(material, fill)
      elseif __lux_tag_113 == style.FILL_RADIAL then
        local cx = __lux_match_112.cx
        local cy = __lux_match_112.cy
        local radius = __lux_match_112.radius
        do
          local __lux_tmp_cx_118 = cx
          if __lux_tmp_cx_118 == nil then
            __lux_tmp_cx_118 = 0.5
          end
          p0 = __lux_tmp_cx_118
        end
        do
          local __lux_tmp_cy_119 = cy
          if __lux_tmp_cy_119 == nil then
            __lux_tmp_cy_119 = 0.5
          end
          p1 = __lux_tmp_cy_119
        end
        do
          local __lux_tmp_radius_120 = radius
          if __lux_tmp_radius_120 == nil then
            __lux_tmp_radius_120 = 0.5
          end
          p2 = __lux_tmp_radius_120
        end
        p3 = 0
        style.bindGradientLut(material, fill)
      elseif __lux_tag_113 == style.FILL_CONIC then
        local cx = __lux_match_112.cx
        local cy = __lux_match_112.cy
        local rotation = __lux_match_112.rotation
        do
          local __lux_tmp_cx_121 = cx
          if __lux_tmp_cx_121 == nil then
            __lux_tmp_cx_121 = 0.5
          end
          p0 = __lux_tmp_cx_121
        end
        do
          local __lux_tmp_cy_122 = cy
          if __lux_tmp_cy_122 == nil then
            __lux_tmp_cy_122 = 0.5
          end
          p1 = __lux_tmp_cy_122
        end
        p2 = style.normalizedRotation(rotation)
        p3 = 0
        style.bindGradientLut(material, fill)
      else
        local __lux_unused_123 = nil
      end
      return p0, p1, p2, p3
    end
    setupPrimitiveAuxConstants = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3)
      if material == nil then
        return false
      end
      do
        local __lux_tmp_a0_124 = a0
        if __lux_tmp_a0_124 == nil then
          __lux_tmp_a0_124 = 0
        end
        material:SetFloat("$c0_x", __lux_tmp_a0_124)
      end
      do
        local __lux_tmp_a1_125 = a1
        if __lux_tmp_a1_125 == nil then
          __lux_tmp_a1_125 = 0
        end
        material:SetFloat("$c0_y", __lux_tmp_a1_125)
      end
      do
        local __lux_tmp_a2_126 = a2
        if __lux_tmp_a2_126 == nil then
          __lux_tmp_a2_126 = 0
        end
        material:SetFloat("$c0_z", __lux_tmp_a2_126)
      end
      do
        local __lux_tmp_a3_127 = a3
        if __lux_tmp_a3_127 == nil then
          __lux_tmp_a3_127 = 0
        end
        material:SetFloat("$c0_w", __lux_tmp_a3_127)
      end
      do
        local __lux_tmp_b0_128 = b0
        if __lux_tmp_b0_128 == nil then
          __lux_tmp_b0_128 = 0
        end
        material:SetFloat("$c1_x", __lux_tmp_b0_128)
      end
      do
        local __lux_tmp_b1_129 = b1
        if __lux_tmp_b1_129 == nil then
          __lux_tmp_b1_129 = 0
        end
        material:SetFloat("$c1_y", __lux_tmp_b1_129)
      end
      do
        local __lux_tmp_b2_130 = b2
        if __lux_tmp_b2_130 == nil then
          __lux_tmp_b2_130 = 0
        end
        material:SetFloat("$c1_z", __lux_tmp_b2_130)
      end
      do
        local __lux_tmp_b3_131 = b3
        if __lux_tmp_b3_131 == nil then
          __lux_tmp_b3_131 = 0
        end
        material:SetFloat("$c1_w", __lux_tmp_b3_131)
      end
      do
        local __lux_tmp_c0_132 = c0
        if __lux_tmp_c0_132 == nil then
          __lux_tmp_c0_132 = 0
        end
        material:SetFloat("$c2_x", __lux_tmp_c0_132)
      end
      do
        local __lux_tmp_c1_133 = c1
        if __lux_tmp_c1_133 == nil then
          __lux_tmp_c1_133 = 0
        end
        material:SetFloat("$c2_y", __lux_tmp_c1_133)
      end
      do
        local __lux_tmp_c2_134 = c2
        if __lux_tmp_c2_134 == nil then
          __lux_tmp_c2_134 = 0
        end
        material:SetFloat("$c2_z", __lux_tmp_c2_134)
      end
      do
        local __lux_tmp_c3_135 = c3
        if __lux_tmp_c3_135 == nil then
          __lux_tmp_c3_135 = 0
        end
        material:SetFloat("$c2_w", __lux_tmp_c3_135)
      end
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
      local __lux_tmp_138 = color == nil
      if not __lux_tmp_138 then
        local __lux_tmp_a_137 = color.a
        if __lux_tmp_a_137 == nil then
          __lux_tmp_a_137 = 255
        end
        __lux_tmp_138 = __lux_tmp_a_137 <= 0
      end
      if __lux_tmp_138 then
        return false
      end
      local tl, tr, br, bl = chamferTuple(cuts, w, h)
      local material = primitiveMaterials.chamfer_innerglow
      local r, g, b, a = style.color01(color)
      do
        local __lux_tmp_width_139 = toNumber(spec.width)
        if __lux_tmp_width_139 == nil then
          __lux_tmp_width_139 = 8
        end
        local __lux_tmp_strength_140 = toNumber(spec.strength)
        if __lux_tmp_strength_140 == nil then
          __lux_tmp_strength_140 = 1
        end
        local __lux_tmp_falloff_141 = toNumber(spec.falloff)
        if __lux_tmp_falloff_141 == nil then
          __lux_tmp_falloff_141 = 1.65
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
          mathMax(0.001, __lux_tmp_width_139),
          mathMax(0, __lux_tmp_strength_140),
          mathMax(0.001, __lux_tmp_falloff_141),
          0
        )
      end
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(x, y, w, h)
      return true
    end
    cutsWithGrow = function(cuts, grow)
      do
        local __lux_tmp_grow_142 = toNumber(grow)
        if __lux_tmp_grow_142 == nil then
          __lux_tmp_grow_142 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_142)
      end
      if grow <= 0 then
        return cuts
      end
      if typeOf(cuts) == "table" and not style.isColor(cuts) then
        local __lux_tmp_tl_143 = cuts.tl
        if __lux_tmp_tl_143 == nil then
          __lux_tmp_tl_143 = cuts[1]
        end
        local __lux_tmp_tl_144 = toNumber(__lux_tmp_tl_143)
        if __lux_tmp_tl_144 == nil then
          __lux_tmp_tl_144 = 0
        end
        local __lux_tmp_tr_145 = cuts.tr
        if __lux_tmp_tr_145 == nil then
          __lux_tmp_tr_145 = cuts[2]
        end
        if __lux_tmp_tr_145 == nil then
          __lux_tmp_tr_145 = cuts.tl
        end
        if __lux_tmp_tr_145 == nil then
          __lux_tmp_tr_145 = cuts[1]
        end
        local __lux_tmp_tr_146 = toNumber(__lux_tmp_tr_145)
        if __lux_tmp_tr_146 == nil then
          __lux_tmp_tr_146 = 0
        end
        local __lux_tmp_br_147 = cuts.br
        if __lux_tmp_br_147 == nil then
          __lux_tmp_br_147 = cuts[3]
        end
        if __lux_tmp_br_147 == nil then
          __lux_tmp_br_147 = cuts.tr
        end
        if __lux_tmp_br_147 == nil then
          __lux_tmp_br_147 = cuts[2]
        end
        if __lux_tmp_br_147 == nil then
          __lux_tmp_br_147 = cuts.tl
        end
        if __lux_tmp_br_147 == nil then
          __lux_tmp_br_147 = cuts[1]
        end
        local __lux_tmp_br_148 = toNumber(__lux_tmp_br_147)
        if __lux_tmp_br_148 == nil then
          __lux_tmp_br_148 = 0
        end
        local __lux_tmp_bl_149 = cuts.bl
        if __lux_tmp_bl_149 == nil then
          __lux_tmp_bl_149 = cuts[4]
        end
        if __lux_tmp_bl_149 == nil then
          __lux_tmp_bl_149 = cuts.br
        end
        if __lux_tmp_bl_149 == nil then
          __lux_tmp_bl_149 = cuts[3]
        end
        if __lux_tmp_bl_149 == nil then
          __lux_tmp_bl_149 = cuts.tr
        end
        if __lux_tmp_bl_149 == nil then
          __lux_tmp_bl_149 = cuts[2]
        end
        if __lux_tmp_bl_149 == nil then
          __lux_tmp_bl_149 = cuts.tl
        end
        if __lux_tmp_bl_149 == nil then
          __lux_tmp_bl_149 = cuts[1]
        end
        local __lux_tmp_bl_150 = toNumber(__lux_tmp_bl_149)
        if __lux_tmp_bl_150 == nil then
          __lux_tmp_bl_150 = 0
        end
        return {
          tl = mathMax(0, __lux_tmp_tl_144) + grow,
          tr = mathMax(0, __lux_tmp_tr_146) + grow,
          br = mathMax(0, __lux_tmp_br_148) + grow,
          bl = mathMax(0, __lux_tmp_bl_150) + grow,
        }
      end
      local __lux_tmp_cuts_151 = toNumber(cuts)
      if __lux_tmp_cuts_151 == nil then
        __lux_tmp_cuts_151 = 0
      end
      return __lux_tmp_cuts_151 + grow
    end
    drawChamferOuterGlowSpec = function(x, y, w, h, cuts, spec)
      if spec == nil or not shadersActive() or not materialOK(primitiveMaterials.chamfer_outerglow) then
        return false
      end
      local color = spec.color
      local __lux_tmp_154 = color == nil
      if not __lux_tmp_154 then
        local __lux_tmp_a_153 = color.a
        if __lux_tmp_a_153 == nil then
          __lux_tmp_a_153 = 255
        end
        __lux_tmp_154 = __lux_tmp_a_153 <= 0
      end
      if __lux_tmp_154 then
        return false
      end
      local grow
      do
        local __lux_tmp_grow_155 = spec.grow
        if __lux_tmp_grow_155 == nil then
          __lux_tmp_grow_155 = spec.shapeSpread
        end
        if __lux_tmp_grow_155 == nil then
          __lux_tmp_grow_155 = spec.expand
        end
        local __lux_tmp_grow_156 = toNumber(__lux_tmp_grow_155)
        if __lux_tmp_grow_156 == nil then
          __lux_tmp_grow_156 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_156)
      end
      local ox
      do
        local __lux_tmp_x_157 = spec.x
        if __lux_tmp_x_157 == nil then
          __lux_tmp_x_157 = spec.offsetX
        end
        if __lux_tmp_x_157 == nil then
          __lux_tmp_x_157 = spec.dx
        end
        ox = toNumber(__lux_tmp_x_157)
        if ox == nil then
          ox = 0
        end
      end
      local oy
      do
        local __lux_tmp_y_158 = spec.y
        if __lux_tmp_y_158 == nil then
          __lux_tmp_y_158 = spec.offsetY
        end
        if __lux_tmp_y_158 == nil then
          __lux_tmp_y_158 = spec.dy
        end
        oy = toNumber(__lux_tmp_y_158)
        if oy == nil then
          oy = 0
        end
      end
      local gx = x + ox - grow
      local gy = y + oy - grow
      local gw = w + grow * 2
      local gh = h + grow * 2
      local gcuts = cutsWithGrow(cuts, grow)
      local spread
      do
        local __lux_tmp_spread_159 = spec.spread
        if __lux_tmp_spread_159 == nil then
          __lux_tmp_spread_159 = spec.width
        end
        local __lux_tmp_spread_160 = toNumber(__lux_tmp_spread_159)
        if __lux_tmp_spread_160 == nil then
          __lux_tmp_spread_160 = 18
        end
        spread = mathMax(1, __lux_tmp_spread_160)
      end
      local tl, tr, br, bl = chamferTuple(gcuts, gw, gh)
      local material = primitiveMaterials.chamfer_outerglow
      local r, g, b, a = style.color01(color)
      do
        local __lux_tmp_width_161 = toNumber(spec.width)
        if __lux_tmp_width_161 == nil then
          __lux_tmp_width_161 = spread
        end
        local __lux_tmp_strength_162 = toNumber(spec.strength)
        if __lux_tmp_strength_162 == nil then
          __lux_tmp_strength_162 = 1
        end
        local __lux_tmp_falloff_163 = toNumber(spec.falloff)
        if __lux_tmp_falloff_163 == nil then
          __lux_tmp_falloff_163 = 1.9
        end
        setupParamMatrix(
          material,
          r,
          g,
          b,
          a,
          gw + spread * 2,
          gh + spread * 2,
          spread,
          spread,
          tl,
          tr,
          br,
          bl,
          mathMax(0.001, __lux_tmp_width_161),
          mathMax(0, __lux_tmp_strength_162),
          mathMax(0.001, __lux_tmp_falloff_163),
          0
        )
      end
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(gx - spread, gy - spread, gw + spread * 2, gh + spread * 2)
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
      local __lux_tmp_166 = color ~= nil
      if __lux_tmp_166 then
        local __lux_tmp_a_165 = color.a
        if __lux_tmp_a_165 == nil then
          __lux_tmp_a_165 = 255
        end
        __lux_tmp_166 = __lux_tmp_a_165 <= 0
      end
      if __lux_tmp_166 then
        return false
      end
      local tl, tr, br, bl = chamferTuple(cuts, w, h)
      local angle
      do
        local __lux_tmp_angle_167 = toNumber(spec.angle)
        if __lux_tmp_angle_167 == nil then
          __lux_tmp_angle_167 = 135
        end
        angle = mathRad(__lux_tmp_angle_167)
      end
      local smoke
      local __lux_match_168 = spec.kind
      if __lux_match_168 == "smoke" then
        smoke = true
      else
        smoke = false
      end
      local material = primitiveMaterials.chamfer_pattern
      local r, g, b, a
      do
        local __lux_tmp_color_169 = spec.color
        if __lux_tmp_color_169 == nil then
          __lux_tmp_color_169 = spec.tint
        end
        r, g, b, a = style.color01(style.asColor(__lux_tmp_color_169, makeColor(255, 255, 255, 24)))
      end
      local pz = 1
      local pw = 1
      if smoke then
        local density
        do
          local __lux_tmp_density_170 = toNumber(spec.density)
          if __lux_tmp_density_170 == nil then
            __lux_tmp_density_170 = 0.48
          end
          density = mathClamp(mathFloor(__lux_tmp_density_170 * 255 + 0.5), 0, 255)
        end
        local softness
        do
          local __lux_tmp_softness_171 = toNumber(spec.softness)
          if __lux_tmp_softness_171 == nil then
            __lux_tmp_softness_171 = 0.3
          end
          softness = mathClamp(mathFloor(__lux_tmp_softness_171 * 255 + 0.5), 0, 255)
        end
        local warp
        do
          local __lux_tmp_warp_172 = toNumber(spec.warp)
          if __lux_tmp_warp_172 == nil then
            __lux_tmp_warp_172 = 0.85
          end
          warp = mathClamp(mathFloor(__lux_tmp_warp_172 * 255 + 0.5), 0, 255)
        end
        do
          local __lux_tmp_scale_173 = toNumber(spec.scale)
          if __lux_tmp_scale_173 == nil then
            __lux_tmp_scale_173 = 140
          end
          pz = mathMax(1, __lux_tmp_scale_173)
        end
        pw = density + softness * 256 + warp * 65536
      else
        do
          local __lux_tmp_spacing_174 = toNumber(spec.spacing)
          if __lux_tmp_spacing_174 == nil then
            __lux_tmp_spacing_174 = 12
          end
          pz = mathMax(1, __lux_tmp_spacing_174)
        end
        do
          local __lux_tmp_width_175 = toNumber(spec.width)
          if __lux_tmp_width_175 == nil then
            __lux_tmp_width_175 = 2
          end
          pw = mathMax(0.25, __lux_tmp_width_175)
        end
      end
      do
        local __lux_tmp_177 = smoke
        if __lux_tmp_177 then
          local __lux_tmp_seed_176 = toNumber(spec.seed)
          if __lux_tmp_seed_176 == nil then
            __lux_tmp_seed_176 = 0
          end
          __lux_tmp_177 = __lux_tmp_seed_176
        end
        local __lux_tmp_178 = __lux_tmp_177
        if not __lux_tmp_178 then
          __lux_tmp_178 = 0
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
          (smoke and 1 or 0) + __lux_tmp_178,
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
      drawTexturedQuad(x, y, w, h)
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
      drawTexturedQuad(x, y, w, h)
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
          local __lux_tmp_color_179 = innerSpec.color
          if __lux_tmp_color_179 == nil then
            __lux_tmp_color_179 = transparentColor
          end
          glowR, glowG, glowB, glowA = style.color01(__lux_tmp_color_179)
        end
        do
          local __lux_tmp_width_180 = toNumber(innerSpec.width)
          if __lux_tmp_width_180 == nil then
            __lux_tmp_width_180 = 8
          end
          glowWidth = mathMax(0.001, __lux_tmp_width_180)
        end
        do
          local __lux_tmp_strength_181 = toNumber(innerSpec.strength)
          if __lux_tmp_strength_181 == nil then
            __lux_tmp_strength_181 = 1
          end
          glowStrength = mathMax(0, __lux_tmp_strength_181)
        end
        do
          local __lux_tmp_falloff_182 = toNumber(innerSpec.falloff)
          if __lux_tmp_falloff_182 == nil then
            __lux_tmp_falloff_182 = 1.65
          end
          glowFalloff = mathMax(0.001, __lux_tmp_falloff_182)
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
        local __lux_tmp_fill_183 = fill
        if __lux_tmp_fill_183 == nil then
          __lux_tmp_fill_183 = transparentFill
        end
        setupPrimitiveFillConstants(material, w, h, __lux_tmp_fill_183, stroke, strokeWidth, 0)
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h)
      return true
    end
    copyChamferStyleInto = function(out, source, fillOnly)
      for key, _ in pairs(out) do
        out[key] = nil
      end
      do
        local __lux_tmp_source_184 = source
        if __lux_tmp_source_184 == nil then
          __lux_tmp_source_184 = {}
        end
        for key, value in pairs(__lux_tmp_source_184) do
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
      if shadow ~= nil then
        drawChamferOuterGlowSpec(x, y, w, h, cuts, shadow)
      end
      local outer = roundrect.outerGlowStyle(resolved.outerGlow)
      if outer ~= nil then
        drawChamferOuterGlowSpec(x, y, w, h, cuts, outer)
      end
      local fill
      do
        local __lux_tmp_fill_185 = resolved.fill
        if __lux_tmp_fill_185 == nil then
          __lux_tmp_fill_185 = resolved.color
        end
        fill = style.fillFromStyle(__lux_tmp_fill_185)
      end
      local strokeWidth = style.strokeWidthValue(resolved.strokeWidth, 0)
      local fillVisible = style.fillVisible(fill)
      local strokeVisible = style.strokeVisible(resolved.stroke, strokeWidth)
      local inner = roundrect.innerGlowStyle(resolved.innerGlow)
      local pattern = resolved.pattern
      local baseDrawn = false
      local baseDrewStroke = false
      local baseDrewInner = false
      if resolved.backdrop == nil and (fillVisible or strokeVisible or inner ~= nil) then
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
      if not baseDrawn and (fillVisible or resolved.backdrop ~= nil) then
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
      if transform ~= nil and poly ~= nil then
        return withTransform(
          transform,
          poly.x,
          poly.y,
          poly.w,
          poly.h,
          function()
            return polyEx(points, stripped)
          end
        )
      end
      return drawPolyImmediate(points, stripped)
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
        local __lux_tmp_sides_186 = toNumber(sides)
        if __lux_tmp_sides_186 == nil then
          __lux_tmp_sides_186 = 3
        end
        count = mathClamp(mathFloor(__lux_tmp_sides_186), 3, 8)
      end
      local r
      do
        local __lux_tmp_radius_187 = toNumber(radius)
        if __lux_tmp_radius_187 == nil then
          __lux_tmp_radius_187 = 0
        end
        r = mathMax(0, __lux_tmp_radius_187)
      end
      local start
      do
        local __lux_tmp_rotation_188 = toNumber(rotation)
        if __lux_tmp_rotation_188 == nil then
          __lux_tmp_rotation_188 = -90
        end
        start = mathRad(__lux_tmp_rotation_188)
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
        local __lux_tmp_direction_189 = direction
        if __lux_tmp_direction_189 == nil then
          __lux_tmp_direction_189 = "right"
        end
        local __lux_match_190 = __lux_tmp_direction_189
        if __lux_match_190 == "up" then
          setPoint(caretScratch, 1, x + w * 0.5, y)
          setPoint(caretScratch, 2, x + w, y + h)
          setPoint(caretScratch, 3, x, y + h)
        elseif __lux_match_190 == "down" then
          setPoint(caretScratch, 1, x, y)
          setPoint(caretScratch, 2, x + w, y)
          setPoint(caretScratch, 3, x + w * 0.5, y + h)
        elseif __lux_match_190 == "left" then
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
      local __lux_tmp_rotation_191 = resolved.rotation
      if __lux_tmp_rotation_191 == nil then
        __lux_tmp_rotation_191 = resolved.angle
      end
      return polyEx(regularPolyPoints(cx, cy, radius, sides, __lux_tmp_rotation_191), resolved)
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
      local __lux_tmp_direction_192 = resolved.direction
      if __lux_tmp_direction_192 == nil then
        __lux_tmp_direction_192 = resolved.dir
      end
      return polyEx(caretPoints(x, y, w, h, __lux_tmp_direction_192), resolved)
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
        normalizePoly = normalizePoly,
        drawLineImmediate = drawLineImmediate,
      }
      return owner
    end
  end
  
  __lux_exports.chamferTuple = chamferTuple
  __lux_exports.chamferPoints = chamferPoints
  __lux_exports.normalizePoly = normalizePoly
  __lux_exports.drawLineImmediate = drawLineImmediate
  __lux_exports.lineEx = lineEx
  __lux_exports.line = line
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
