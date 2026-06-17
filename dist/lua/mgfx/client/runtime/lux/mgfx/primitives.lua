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
  local drawPolyPattern
  local setupPolyStrokeConstants
  local drawPolyStrokeShader
  local drawPolyStroke
  local drawPolyFallback
  local drawPolyShadow
  local drawPolyImmediate
  local chamferFillFallbackStyle
  local chamferStrokeFallbackStyle
  local transparentFill
  local chamferFillParams
  local setupPrimitiveAuxConstants
  local setupPrimitiveFillConstants
  local drawChamferInnerGlowSpec
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
    drawPolyPattern = function(poly, pattern)
      local spec = roundrect.patternStyle(pattern)
      if spec == nil or not shadersActive() or not materialOK(primitiveMaterials.poly_pattern) then
        return false
      end
      local color = spec.color
      if color == nil then
        color = spec.tint
      end
      local __lux_tmp_69 = color ~= nil
      if __lux_tmp_69 then
        local __lux_tmp_a_68 = color.a
        if __lux_tmp_a_68 == nil then
          __lux_tmp_a_68 = 255
        end
        __lux_tmp_69 = __lux_tmp_a_68 <= 0
      end
      if __lux_tmp_69 then
        return false
      end
      local material = primitiveMaterials.poly_pattern
      local r, g, b, a
      do
        local __lux_tmp_color_70 = spec.color
        if __lux_tmp_color_70 == nil then
          __lux_tmp_color_70 = spec.tint
        end
        r, g, b, a = style.color01(style.asColor(__lux_tmp_color_70, makeColor(255, 255, 255, 24)))
      end
      local angle
      do
        local __lux_tmp_angle_71 = toNumber(spec.angle)
        if __lux_tmp_angle_71 == nil then
          __lux_tmp_angle_71 = 135
        end
        angle = mathRad(__lux_tmp_angle_71)
      end
      local smoke
      local __lux_match_72 = spec.kind
      if __lux_match_72 == "smoke" then
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
          local __lux_tmp_scale_73 = toNumber(spec.scale)
          if __lux_tmp_scale_73 == nil then
            __lux_tmp_scale_73 = 140
          end
          pz = mathMax(1, __lux_tmp_scale_73)
        end
        do
          local __lux_tmp_density_74 = toNumber(spec.density)
          if __lux_tmp_density_74 == nil then
            __lux_tmp_density_74 = 0.48
          end
          pw = mathClamp(__lux_tmp_density_74, 0, 1)
        end
        ox = roundrect.patternOffset(spec)
        oy = 1
        do
          local __lux_tmp_softness_75 = toNumber(spec.softness)
          if __lux_tmp_softness_75 == nil then
            __lux_tmp_softness_75 = 0.3
          end
          oz = mathMax(0.001, __lux_tmp_softness_75)
        end
        do
          local __lux_tmp_warp_76 = toNumber(spec.warp)
          if __lux_tmp_warp_76 == nil then
            __lux_tmp_warp_76 = 0.85
          end
          ow = mathMax(0, __lux_tmp_warp_76)
        end
      else
        do
          local __lux_tmp_spacing_77 = toNumber(spec.spacing)
          if __lux_tmp_spacing_77 == nil then
            __lux_tmp_spacing_77 = 12
          end
          pz = mathMax(1, __lux_tmp_spacing_77)
        end
        do
          local __lux_tmp_width_78 = toNumber(spec.width)
          if __lux_tmp_width_78 == nil then
            __lux_tmp_width_78 = 2
          end
          pw = mathMax(0.25, __lux_tmp_width_78)
        end
        ox = roundrect.patternOffset(spec)
      end
      do
        local __lux_tmp_80 = smoke
        if __lux_tmp_80 then
          local __lux_tmp_seed_79 = toNumber(spec.seed)
          if __lux_tmp_seed_79 == nil then
            __lux_tmp_seed_79 = 0
          end
          __lux_tmp_80 = __lux_tmp_seed_79
        end
        local __lux_tmp_81 = __lux_tmp_80
        if not __lux_tmp_81 then
          __lux_tmp_81 = 0
        end
        setupParamMatrix(
          material,
          r,
          g,
          b,
          a,
          poly.w,
          poly.h,
          __lux_tmp_81,
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
        local __lux_tmp_fill_82 = drawStyle.fill
        if __lux_tmp_fill_82 == nil then
          __lux_tmp_fill_82 = drawStyle.color
        end
        fill = style.fillFromStyle(__lux_tmp_fill_82)
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
            local __lux_tmp_x_83 = a.x
            if __lux_tmp_x_83 == nil then
              __lux_tmp_x_83 = a[1]
            end
            local __lux_tmp_y_84 = a.y
            if __lux_tmp_y_84 == nil then
              __lux_tmp_y_84 = a[2]
            end
            local __lux_tmp_x_85 = b.x
            if __lux_tmp_x_85 == nil then
              __lux_tmp_x_85 = b[1]
            end
            local __lux_tmp_y_86 = b.y
            if __lux_tmp_y_86 == nil then
              __lux_tmp_y_86 = b[2]
            end
            drawLineImmediate(
              __lux_tmp_x_83,
              __lux_tmp_y_84,
              __lux_tmp_x_85,
              __lux_tmp_y_86,
              nil,
              nil,
              lineStyle
            )
          end
        end
      end
    end
    drawPolyShadow = function(poly, points, shadow)
      local __lux_tmp_89 = shadow == nil or shadow.color == nil
      if not __lux_tmp_89 then
        local __lux_tmp_a_88 = shadow.color.a
        if __lux_tmp_a_88 == nil then
          __lux_tmp_a_88 = 255
        end
        __lux_tmp_89 = __lux_tmp_a_88 <= 0
      end
      if __lux_tmp_89 then
        return false
      end
      local shifted = {}
      local spread
      do
        local __lux_tmp_blur_90 = toNumber(shadow.blur)
        if __lux_tmp_blur_90 == nil then
          __lux_tmp_blur_90 = 12
        end
        spread = mathMax(1, __lux_tmp_blur_90)
      end
      local cx = poly.x + poly.w * 0.5
      local cy = poly.y + poly.h * 0.5
      for index, point in ipairs(points) do
        local px, py = pointXY(point)
        local dx = px - cx
        local dy = py - cy
        local len = mathMax(1, mathSqrt(dx * dx + dy * dy))
        do
          local __lux_tmp_x_91 = shadow.x
          if __lux_tmp_x_91 == nil then
            __lux_tmp_x_91 = 0
          end
          local __lux_tmp_y_92 = shadow.y
          if __lux_tmp_y_92 == nil then
            __lux_tmp_y_92 = 0
          end
          shifted[index] = {
            x = px + __lux_tmp_x_91 + dx / len * spread,
            y = py + __lux_tmp_y_92 + dy / len * spread,
          }
        end
      end
      local shadowPoly = normalizePoly(shifted)
      if shadowPoly == nil then
        return false
      end
      local material = primitiveMaterials[polyMaterialKey(shadowPoly)]
      if not materialOK(material) then
        return false
      end
      setupPrimitiveFillConstants(
        material,
        shadowPoly.w,
        shadowPoly.h,
        style.solid(shadow.color),
        nil,
        0,
        0
      )
      return drawMaterialPoly(shadowPoly, material)
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
      if not shadersActive() then
        return drawPolyFallback(points, resolved)
      end
      drawPolyShadow(poly, points, resolved.shadow)
      drawPolyBackdrop(poly, resolved.backdrop)
      local material = primitiveMaterials[polyMaterialKey(poly)]
      local fill
      do
        local __lux_tmp_fill_93 = resolved.fill
        if __lux_tmp_fill_93 == nil then
          __lux_tmp_fill_93 = resolved.color
        end
        fill = style.fillFromStyle(__lux_tmp_fill_93)
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
      local __lux_match_94 = fill
      local __lux_tag_95
      if __lux_match_94 ~= nil then
        __lux_tag_95 = __lux_match_94.kind
      end
      if __lux_tag_95 == style.FILL_LINEAR then
        local x1 = __lux_match_94.x1
        local y1 = __lux_match_94.y1
        local x2 = __lux_match_94.x2
        local y2 = __lux_match_94.y2
        do
          local __lux_tmp_x1_96 = x1
          if __lux_tmp_x1_96 == nil then
            __lux_tmp_x1_96 = 0
          end
          p0 = __lux_tmp_x1_96
        end
        do
          local __lux_tmp_y1_97 = y1
          if __lux_tmp_y1_97 == nil then
            __lux_tmp_y1_97 = 0
          end
          p1 = __lux_tmp_y1_97
        end
        do
          local __lux_tmp_x2_98 = x2
          if __lux_tmp_x2_98 == nil then
            __lux_tmp_x2_98 = 1
          end
          p2 = __lux_tmp_x2_98
        end
        do
          local __lux_tmp_y2_99 = y2
          if __lux_tmp_y2_99 == nil then
            __lux_tmp_y2_99 = 1
          end
          p3 = __lux_tmp_y2_99
        end
        style.bindGradientLut(material, fill)
      elseif __lux_tag_95 == style.FILL_RADIAL then
        local cx = __lux_match_94.cx
        local cy = __lux_match_94.cy
        local radius = __lux_match_94.radius
        do
          local __lux_tmp_cx_100 = cx
          if __lux_tmp_cx_100 == nil then
            __lux_tmp_cx_100 = 0.5
          end
          p0 = __lux_tmp_cx_100
        end
        do
          local __lux_tmp_cy_101 = cy
          if __lux_tmp_cy_101 == nil then
            __lux_tmp_cy_101 = 0.5
          end
          p1 = __lux_tmp_cy_101
        end
        do
          local __lux_tmp_radius_102 = radius
          if __lux_tmp_radius_102 == nil then
            __lux_tmp_radius_102 = 0.5
          end
          p2 = __lux_tmp_radius_102
        end
        p3 = 0
        style.bindGradientLut(material, fill)
      elseif __lux_tag_95 == style.FILL_CONIC then
        local cx = __lux_match_94.cx
        local cy = __lux_match_94.cy
        local rotation = __lux_match_94.rotation
        do
          local __lux_tmp_cx_103 = cx
          if __lux_tmp_cx_103 == nil then
            __lux_tmp_cx_103 = 0.5
          end
          p0 = __lux_tmp_cx_103
        end
        do
          local __lux_tmp_cy_104 = cy
          if __lux_tmp_cy_104 == nil then
            __lux_tmp_cy_104 = 0.5
          end
          p1 = __lux_tmp_cy_104
        end
        p2 = style.normalizedRotation(rotation)
        p3 = 0
        style.bindGradientLut(material, fill)
      else
        local __lux_unused_105 = nil
      end
      return p0, p1, p2, p3
    end
    setupPrimitiveAuxConstants = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3)
      if material == nil then
        return false
      end
      do
        local __lux_tmp_a0_106 = a0
        if __lux_tmp_a0_106 == nil then
          __lux_tmp_a0_106 = 0
        end
        material:SetFloat("$c0_x", __lux_tmp_a0_106)
      end
      do
        local __lux_tmp_a1_107 = a1
        if __lux_tmp_a1_107 == nil then
          __lux_tmp_a1_107 = 0
        end
        material:SetFloat("$c0_y", __lux_tmp_a1_107)
      end
      do
        local __lux_tmp_a2_108 = a2
        if __lux_tmp_a2_108 == nil then
          __lux_tmp_a2_108 = 0
        end
        material:SetFloat("$c0_z", __lux_tmp_a2_108)
      end
      do
        local __lux_tmp_a3_109 = a3
        if __lux_tmp_a3_109 == nil then
          __lux_tmp_a3_109 = 0
        end
        material:SetFloat("$c0_w", __lux_tmp_a3_109)
      end
      do
        local __lux_tmp_b0_110 = b0
        if __lux_tmp_b0_110 == nil then
          __lux_tmp_b0_110 = 0
        end
        material:SetFloat("$c1_x", __lux_tmp_b0_110)
      end
      do
        local __lux_tmp_b1_111 = b1
        if __lux_tmp_b1_111 == nil then
          __lux_tmp_b1_111 = 0
        end
        material:SetFloat("$c1_y", __lux_tmp_b1_111)
      end
      do
        local __lux_tmp_b2_112 = b2
        if __lux_tmp_b2_112 == nil then
          __lux_tmp_b2_112 = 0
        end
        material:SetFloat("$c1_z", __lux_tmp_b2_112)
      end
      do
        local __lux_tmp_b3_113 = b3
        if __lux_tmp_b3_113 == nil then
          __lux_tmp_b3_113 = 0
        end
        material:SetFloat("$c1_w", __lux_tmp_b3_113)
      end
      do
        local __lux_tmp_c0_114 = c0
        if __lux_tmp_c0_114 == nil then
          __lux_tmp_c0_114 = 0
        end
        material:SetFloat("$c2_x", __lux_tmp_c0_114)
      end
      do
        local __lux_tmp_c1_115 = c1
        if __lux_tmp_c1_115 == nil then
          __lux_tmp_c1_115 = 0
        end
        material:SetFloat("$c2_y", __lux_tmp_c1_115)
      end
      do
        local __lux_tmp_c2_116 = c2
        if __lux_tmp_c2_116 == nil then
          __lux_tmp_c2_116 = 0
        end
        material:SetFloat("$c2_z", __lux_tmp_c2_116)
      end
      do
        local __lux_tmp_c3_117 = c3
        if __lux_tmp_c3_117 == nil then
          __lux_tmp_c3_117 = 0
        end
        material:SetFloat("$c2_w", __lux_tmp_c3_117)
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
      local __lux_tmp_120 = color == nil
      if not __lux_tmp_120 then
        local __lux_tmp_a_119 = color.a
        if __lux_tmp_a_119 == nil then
          __lux_tmp_a_119 = 255
        end
        __lux_tmp_120 = __lux_tmp_a_119 <= 0
      end
      if __lux_tmp_120 then
        return false
      end
      local tl, tr, br, bl = chamferTuple(cuts, w, h)
      local material = primitiveMaterials.chamfer_innerglow
      local r, g, b, a = style.color01(color)
      do
        local __lux_tmp_width_121 = toNumber(spec.width)
        if __lux_tmp_width_121 == nil then
          __lux_tmp_width_121 = 8
        end
        local __lux_tmp_strength_122 = toNumber(spec.strength)
        if __lux_tmp_strength_122 == nil then
          __lux_tmp_strength_122 = 1
        end
        local __lux_tmp_falloff_123 = toNumber(spec.falloff)
        if __lux_tmp_falloff_123 == nil then
          __lux_tmp_falloff_123 = 1.65
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
          mathMax(0.001, __lux_tmp_width_121),
          mathMax(0, __lux_tmp_strength_122),
          mathMax(0.001, __lux_tmp_falloff_123),
          0
        )
      end
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(x, y, w, h)
      return true
    end
    drawChamferOuterGlowSpec = function(x, y, w, h, cuts, spec)
      if spec == nil or not shadersActive() or not materialOK(primitiveMaterials.chamfer_outerglow) then
        return false
      end
      local color = spec.color
      local __lux_tmp_126 = color == nil
      if not __lux_tmp_126 then
        local __lux_tmp_a_125 = color.a
        if __lux_tmp_a_125 == nil then
          __lux_tmp_a_125 = 255
        end
        __lux_tmp_126 = __lux_tmp_a_125 <= 0
      end
      if __lux_tmp_126 then
        return false
      end
      local spread
      do
        local __lux_tmp_spread_127 = spec.spread
        if __lux_tmp_spread_127 == nil then
          __lux_tmp_spread_127 = spec.width
        end
        local __lux_tmp_spread_128 = toNumber(__lux_tmp_spread_127)
        if __lux_tmp_spread_128 == nil then
          __lux_tmp_spread_128 = 18
        end
        spread = mathMax(1, __lux_tmp_spread_128)
      end
      local tl, tr, br, bl = chamferTuple(cuts, w, h)
      local material = primitiveMaterials.chamfer_outerglow
      local r, g, b, a = style.color01(color)
      do
        local __lux_tmp_width_129 = toNumber(spec.width)
        if __lux_tmp_width_129 == nil then
          __lux_tmp_width_129 = spread
        end
        local __lux_tmp_strength_130 = toNumber(spec.strength)
        if __lux_tmp_strength_130 == nil then
          __lux_tmp_strength_130 = 1
        end
        local __lux_tmp_falloff_131 = toNumber(spec.falloff)
        if __lux_tmp_falloff_131 == nil then
          __lux_tmp_falloff_131 = 1.9
        end
        setupParamMatrix(
          material,
          r,
          g,
          b,
          a,
          w + spread * 2,
          h + spread * 2,
          spread,
          spread,
          tl,
          tr,
          br,
          bl,
          mathMax(0.001, __lux_tmp_width_129),
          mathMax(0, __lux_tmp_strength_130),
          mathMax(0.001, __lux_tmp_falloff_131),
          0
        )
      end
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(x - spread, y - spread, w + spread * 2, h + spread * 2)
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
      local __lux_tmp_134 = color ~= nil
      if __lux_tmp_134 then
        local __lux_tmp_a_133 = color.a
        if __lux_tmp_a_133 == nil then
          __lux_tmp_a_133 = 255
        end
        __lux_tmp_134 = __lux_tmp_a_133 <= 0
      end
      if __lux_tmp_134 then
        return false
      end
      local tl, tr, br, bl = chamferTuple(cuts, w, h)
      local angle
      do
        local __lux_tmp_angle_135 = toNumber(spec.angle)
        if __lux_tmp_angle_135 == nil then
          __lux_tmp_angle_135 = 135
        end
        angle = mathRad(__lux_tmp_angle_135)
      end
      local smoke
      local __lux_match_136 = spec.kind
      if __lux_match_136 == "smoke" then
        smoke = true
      else
        smoke = false
      end
      local material = primitiveMaterials.chamfer_pattern
      local r, g, b, a
      do
        local __lux_tmp_color_137 = spec.color
        if __lux_tmp_color_137 == nil then
          __lux_tmp_color_137 = spec.tint
        end
        r, g, b, a = style.color01(style.asColor(__lux_tmp_color_137, makeColor(255, 255, 255, 24)))
      end
      local pz = 1
      local pw = 1
      if smoke then
        local density
        do
          local __lux_tmp_density_138 = toNumber(spec.density)
          if __lux_tmp_density_138 == nil then
            __lux_tmp_density_138 = 0.48
          end
          density = mathClamp(mathFloor(__lux_tmp_density_138 * 255 + 0.5), 0, 255)
        end
        local softness
        do
          local __lux_tmp_softness_139 = toNumber(spec.softness)
          if __lux_tmp_softness_139 == nil then
            __lux_tmp_softness_139 = 0.3
          end
          softness = mathClamp(mathFloor(__lux_tmp_softness_139 * 255 + 0.5), 0, 255)
        end
        local warp
        do
          local __lux_tmp_warp_140 = toNumber(spec.warp)
          if __lux_tmp_warp_140 == nil then
            __lux_tmp_warp_140 = 0.85
          end
          warp = mathClamp(mathFloor(__lux_tmp_warp_140 * 255 + 0.5), 0, 255)
        end
        do
          local __lux_tmp_scale_141 = toNumber(spec.scale)
          if __lux_tmp_scale_141 == nil then
            __lux_tmp_scale_141 = 140
          end
          pz = mathMax(1, __lux_tmp_scale_141)
        end
        pw = density + softness * 256 + warp * 65536
      else
        do
          local __lux_tmp_spacing_142 = toNumber(spec.spacing)
          if __lux_tmp_spacing_142 == nil then
            __lux_tmp_spacing_142 = 12
          end
          pz = mathMax(1, __lux_tmp_spacing_142)
        end
        do
          local __lux_tmp_width_143 = toNumber(spec.width)
          if __lux_tmp_width_143 == nil then
            __lux_tmp_width_143 = 2
          end
          pw = mathMax(0.25, __lux_tmp_width_143)
        end
      end
      do
        local __lux_tmp_145 = smoke
        if __lux_tmp_145 then
          local __lux_tmp_seed_144 = toNumber(spec.seed)
          if __lux_tmp_seed_144 == nil then
            __lux_tmp_seed_144 = 0
          end
          __lux_tmp_145 = __lux_tmp_seed_144
        end
        local __lux_tmp_146 = __lux_tmp_145
        if not __lux_tmp_146 then
          __lux_tmp_146 = 0
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
          (smoke and 1 or 0) + __lux_tmp_146,
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
          local __lux_tmp_color_147 = innerSpec.color
          if __lux_tmp_color_147 == nil then
            __lux_tmp_color_147 = transparentColor
          end
          glowR, glowG, glowB, glowA = style.color01(__lux_tmp_color_147)
        end
        do
          local __lux_tmp_width_148 = toNumber(innerSpec.width)
          if __lux_tmp_width_148 == nil then
            __lux_tmp_width_148 = 8
          end
          glowWidth = mathMax(0.001, __lux_tmp_width_148)
        end
        do
          local __lux_tmp_strength_149 = toNumber(innerSpec.strength)
          if __lux_tmp_strength_149 == nil then
            __lux_tmp_strength_149 = 1
          end
          glowStrength = mathMax(0, __lux_tmp_strength_149)
        end
        do
          local __lux_tmp_falloff_150 = toNumber(innerSpec.falloff)
          if __lux_tmp_falloff_150 == nil then
            __lux_tmp_falloff_150 = 1.65
          end
          glowFalloff = mathMax(0.001, __lux_tmp_falloff_150)
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
        local __lux_tmp_fill_151 = fill
        if __lux_tmp_fill_151 == nil then
          __lux_tmp_fill_151 = transparentFill
        end
        setupPrimitiveFillConstants(material, w, h, __lux_tmp_fill_151, stroke, strokeWidth, 0)
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
        local __lux_tmp_source_152 = source
        if __lux_tmp_source_152 == nil then
          __lux_tmp_source_152 = {}
        end
        for key, value in pairs(__lux_tmp_source_152) do
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
      local outer = roundrect.outerGlowStyle(resolved.outerGlow)
      if outer ~= nil then
        drawChamferOuterGlowSpec(x, y, w, h, cuts, outer)
      end
      local fill
      do
        local __lux_tmp_fill_153 = resolved.fill
        if __lux_tmp_fill_153 == nil then
          __lux_tmp_fill_153 = resolved.color
        end
        fill = style.fillFromStyle(__lux_tmp_fill_153)
      end
      local strokeWidth = style.strokeWidthValue(resolved.strokeWidth, 0)
      local fillVisible = style.fillVisible(fill)
      local strokeVisible = style.strokeVisible(resolved.stroke, strokeWidth)
      local inner = roundrect.innerGlowStyle(resolved.innerGlow)
      local pattern = resolved.pattern
      local baseDrawn = false
      local baseDrewStroke = false
      local baseDrewInner = false
      if resolved.shadow == nil and resolved.backdrop == nil and (fillVisible or strokeVisible or inner ~= nil) then
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
      if not baseDrawn and (fillVisible or resolved.shadow ~= nil or resolved.backdrop ~= nil) then
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
  __lux_exports.chamferBoxEx = chamferBoxEx
  __lux_exports.chamferBox = chamferBox
  __lux_exports.install = install
  
  return __lux_exports
end
