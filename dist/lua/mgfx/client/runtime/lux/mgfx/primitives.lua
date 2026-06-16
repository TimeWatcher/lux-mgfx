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
    local __lux_import_1 = __lux_import("lux/mgfx/geometry#client")
    local geometryImport = __lux_import_1
    local __lux_import_2 = __lux_import("lux/mgfx/roundrect#client")
    local roundrectImport = __lux_import_2
    local __lux_import_3 = __lux_import("lux/mgfx/style#client")
    local styleImport = __lux_import_3
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
      local __lux_obj_4 = render
      local __lux_val_5 = nil
      if __lux_obj_4 ~= nil then
        __lux_val_5 = __lux_obj_4.CopyRenderTargetToTexture
      end
      renderCopyRenderTargetToTexture = __lux_val_5
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
    primitiveMaterials = {}
    primitiveBlurRT = nil
    primitiveMatOK = function(material)
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
      do
        local __lux_tmp_11 = owner
        if __lux_tmp_11 == nil then
          __lux_tmp_11 = {}
        end
        owner = __lux_tmp_11
      end
      local materialState
      do
        local __lux_tmp_12 = owner._MaterialState
        if __lux_tmp_12 == nil then
          __lux_tmp_12 = {}
        end
        materialState = __lux_tmp_12
      end
      do
        local __lux_tmp_13 = owner._Materials
        if __lux_tmp_13 == nil then
          local __lux_tmp_14 = materialState.materials
          if __lux_tmp_14 == nil then
            local __lux_tmp_15 = primitiveMaterials
            if __lux_tmp_15 == nil then
              __lux_tmp_15 = {}
            end
            __lux_tmp_14 = __lux_tmp_15
          end
          __lux_tmp_13 = __lux_tmp_14
        end
        primitiveMaterials = __lux_tmp_13
      end
      do
        local __lux_tmp_16 = owner._BlurRT
        if __lux_tmp_16 == nil then
          local __lux_tmp_17 = materialState.blurRT
          if __lux_tmp_17 == nil then
            __lux_tmp_17 = primitiveBlurRT
          end
          __lux_tmp_16 = __lux_tmp_17
        end
        primitiveBlurRT = __lux_tmp_16
      end
      do
        local __lux_tmp_18 = owner.MaterialOK
        if __lux_tmp_18 == nil then
          local __lux_tmp_19 = materialState.matOK
          if __lux_tmp_19 == nil then
            __lux_tmp_19 = primitiveMatOK
          end
          __lux_tmp_18 = __lux_tmp_19
        end
        primitiveMatOK = __lux_tmp_18
      end
      do
        local __lux_tmp_20 = owner.hasShaders
        if __lux_tmp_20 == nil then
          __lux_tmp_20 = primitiveHasShaders
        end
        primitiveHasShaders = __lux_tmp_20
      end
      return true
    end
    materialOK = function(material)
      local __lux_tmp_21 = primitiveMatOK ~= nil
      if __lux_tmp_21 then
        __lux_tmp_21 = primitiveMatOK(material)
      end
      return __lux_tmp_21
    end
    shadersActive = function()
      local __lux_tmp_22 = forceFallbackCvar == nil
      if __lux_tmp_22 then
        __lux_tmp_22 = getConVar ~= nil
      end
      if __lux_tmp_22 then
        do
          local __lux_tmp_23 = getConVar("mgfx_force_fallback")
          if __lux_tmp_23 == nil then
            __lux_tmp_23 = false
          end
          forceFallbackCvar = __lux_tmp_23
        end
      end
      local __lux_tmp_24 = forceFallbackCvar ~= nil
      if __lux_tmp_24 then
        __lux_tmp_24 = forceFallbackCvar ~= false
      end
      local __lux_tmp_25 = __lux_tmp_24
      if __lux_tmp_25 then
        __lux_tmp_25 = forceFallbackCvar:GetBool()
      end
      if __lux_tmp_25 then
        return false
      end
      local __lux_tmp_26 = primitiveHasShaders ~= nil
      if __lux_tmp_26 then
        __lux_tmp_26 = primitiveHasShaders()
      end
      return __lux_tmp_26
    end
    setupParamMatrix = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3)
      local __lux_tmp_27 = material == nil
      if not __lux_tmp_27 then
        __lux_tmp_27 = paramMatrixSetUnpacked == nil
      end
      local __lux_tmp_28 = __lux_tmp_27
      if not __lux_tmp_28 then
        __lux_tmp_28 = matrixCtor == nil
      end
      if __lux_tmp_28 then
        return false
      end
      local matrix = paramMatrices[material]
      if matrix == nil then
        matrix = matrixCtor()
        paramMatrices[material] = matrix
      end
      do
        local __lux_tmp_29 = a0
        if __lux_tmp_29 == nil then
          __lux_tmp_29 = 0
        end
        local __lux_tmp_30 = b0
        if __lux_tmp_30 == nil then
          __lux_tmp_30 = 0
        end
        local __lux_tmp_31 = c0
        if __lux_tmp_31 == nil then
          __lux_tmp_31 = 0
        end
        local __lux_tmp_32 = d0
        if __lux_tmp_32 == nil then
          __lux_tmp_32 = 0
        end
        local __lux_tmp_33 = a1
        if __lux_tmp_33 == nil then
          __lux_tmp_33 = 0
        end
        local __lux_tmp_34 = b1
        if __lux_tmp_34 == nil then
          __lux_tmp_34 = 0
        end
        local __lux_tmp_35 = c1
        if __lux_tmp_35 == nil then
          __lux_tmp_35 = 0
        end
        local __lux_tmp_36 = d1
        if __lux_tmp_36 == nil then
          __lux_tmp_36 = 0
        end
        local __lux_tmp_37 = a2
        if __lux_tmp_37 == nil then
          __lux_tmp_37 = 0
        end
        local __lux_tmp_38 = b2
        if __lux_tmp_38 == nil then
          __lux_tmp_38 = 0
        end
        local __lux_tmp_39 = c2
        if __lux_tmp_39 == nil then
          __lux_tmp_39 = 0
        end
        local __lux_tmp_40 = d2
        if __lux_tmp_40 == nil then
          __lux_tmp_40 = 0
        end
        local __lux_tmp_41 = a3
        if __lux_tmp_41 == nil then
          __lux_tmp_41 = 0
        end
        local __lux_tmp_42 = b3
        if __lux_tmp_42 == nil then
          __lux_tmp_42 = 0
        end
        local __lux_tmp_43 = c3
        if __lux_tmp_43 == nil then
          __lux_tmp_43 = 0
        end
        local __lux_tmp_44 = d3
        if __lux_tmp_44 == nil then
          __lux_tmp_44 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_29,
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
          __lux_tmp_44
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
        local __lux_tmp_45 = fill.colorA
        if __lux_tmp_45 == nil then
          local __lux_tmp_46 = fill.color
          if __lux_tmp_46 == nil then
            local __lux_tmp_47 = fallback
            if __lux_tmp_47 == nil then
              __lux_tmp_47 = color_white
            end
            __lux_tmp_46 = __lux_tmp_47
          end
          __lux_tmp_45 = __lux_tmp_46
        end
        return __lux_tmp_45
      end
      local __lux_tmp_48 = fallback
      if __lux_tmp_48 == nil then
        __lux_tmp_48 = color_white
      end
      return __lux_tmp_48
    end
    pointXY = function(point)
      local __lux_tmp_49 = point.x
      if __lux_tmp_49 == nil then
        __lux_tmp_49 = point[1]
      end
      local __lux_tmp_50 = toNumber(__lux_tmp_49)
      if __lux_tmp_50 == nil then
        __lux_tmp_50 = 0
      end
      local __lux_tmp_51 = point.y
      if __lux_tmp_51 == nil then
        __lux_tmp_51 = point[2]
      end
      local __lux_tmp_52 = toNumber(__lux_tmp_51)
      if __lux_tmp_52 == nil then
        __lux_tmp_52 = 0
      end
      return __lux_tmp_50, __lux_tmp_52
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
          local __lux_tmp_53 = cuts.tl
          if __lux_tmp_53 == nil then
            __lux_tmp_53 = cuts[1]
          end
          local __lux_tmp_54 = toNumber(__lux_tmp_53)
          if __lux_tmp_54 == nil then
            __lux_tmp_54 = 0
          end
          tl = __lux_tmp_54
        end
        do
          local __lux_tmp_55 = cuts.tr
          if __lux_tmp_55 == nil then
            __lux_tmp_55 = cuts[2]
          end
          local __lux_tmp_56 = toNumber(__lux_tmp_55)
          if __lux_tmp_56 == nil then
            __lux_tmp_56 = tl
          end
          tr = __lux_tmp_56
        end
        do
          local __lux_tmp_57 = cuts.br
          if __lux_tmp_57 == nil then
            __lux_tmp_57 = cuts[3]
          end
          local __lux_tmp_58 = toNumber(__lux_tmp_57)
          if __lux_tmp_58 == nil then
            __lux_tmp_58 = tr
          end
          br = __lux_tmp_58
        end
        do
          local __lux_tmp_59 = cuts.bl
          if __lux_tmp_59 == nil then
            __lux_tmp_59 = cuts[4]
          end
          local __lux_tmp_60 = toNumber(__lux_tmp_59)
          if __lux_tmp_60 == nil then
            __lux_tmp_60 = br
          end
          bl = __lux_tmp_60
        end
      else
        do
          local __lux_tmp_61 = toNumber(cuts)
          if __lux_tmp_61 == nil then
            __lux_tmp_61 = 0
          end
          tl = __lux_tmp_61
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
            local __lux_cmp_62 = false
            if mathAbs(last.x - px) ~= nil and 0.001 ~= nil then
              __lux_cmp_62 = mathAbs(last.x - px) < 0.001
            end
            sameX = __lux_cmp_62
          end
          local sameY
          do
            local __lux_cmp_63 = false
            if mathAbs(last.y - py) ~= nil and 0.001 ~= nil then
              __lux_cmp_63 = mathAbs(last.y - py) < 0.001
            end
            sameY = __lux_cmp_63
          end
          local __lux_tmp_64 = sameX
          if __lux_tmp_64 then
            __lux_tmp_64 = sameY
          end
          if __lux_tmp_64 then
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
        local __lux_cmp_65 = false
        if mathAbs(first.x - last.x) ~= nil and 0.001 ~= nil then
          __lux_cmp_65 = mathAbs(first.x - last.x) < 0.001
        end
        local __lux_tmp_66 = __lux_cmp_65
        if __lux_tmp_66 then
          local __lux_cmp_67 = false
          if mathAbs(first.y - last.y) ~= nil and 0.001 ~= nil then
            __lux_cmp_67 = mathAbs(first.y - last.y) < 0.001
          end
          __lux_tmp_66 = __lux_cmp_67
        end
        if __lux_tmp_66 then
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
        local __lux_cmp_68 = false
        if mathAbs(cross) ~= nil and 0.000001 ~= nil then
          __lux_cmp_68 = mathAbs(cross) > 0.000001
        end
        if __lux_cmp_68 then
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
        local __lux_tmp_69 = points
        if __lux_tmp_69 == nil then
          __lux_tmp_69 = {}
        end
        count = #__lux_tmp_69
      end
      local __lux_tmp_70 = count < 3
      if not __lux_tmp_70 then
        __lux_tmp_70 = count > 8
      end
      if __lux_tmp_70 then
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
      local __lux_cmp_71 = false
      if signedArea(ordered) ~= nil and 0 ~= nil then
        __lux_cmp_71 = signedArea(ordered) < 0
      end
      if __lux_cmp_71 then
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
      local __lux_tmp_72 = w <= 0
      if not __lux_tmp_72 then
        __lux_tmp_72 = h <= 0
      end
      if __lux_tmp_72 then
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
      local colorA
      do
        local __lux_tmp_73 = fill.colorA
        if __lux_tmp_73 == nil then
          __lux_tmp_73 = color_white
        end
        colorA = __lux_tmp_73
      end
      local colorB
      do
        local __lux_tmp_74 = fill.colorB
        if __lux_tmp_74 == nil then
          __lux_tmp_74 = colorA
        end
        colorB = __lux_tmp_74
      end
      local r, g, b, a = style.color01(colorA)
      local br, bg, bb, ba = style.color01(colorB)
      setupParamMatrix(material, r, g, b, a, br, bg, bb, ba, 0, 0, 1, 0, 0, 0, 0, 0)
      return style.bindGradientLut(material, fill)
    end
    drawLineShaderVerts = function(verts, fill)
      local material = primitiveMaterials.line
      local __lux_tmp_75 = not shadersActive()
      if not __lux_tmp_75 then
        __lux_tmp_75 = not materialOK(material)
      end
      if __lux_tmp_75 then
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
      local __lux_tmp_76 = resolved.radius ~= nil
      if not __lux_tmp_76 then
        __lux_tmp_76 = resolved.outerGlow ~= nil
      end
      local __lux_tmp_77 = __lux_tmp_76
      if not __lux_tmp_77 then
        __lux_tmp_77 = resolved.backdrop ~= nil
      end
      if __lux_tmp_77 then
        local __lux_tmp_78 = resolved.radius
        if __lux_tmp_78 == nil then
          __lux_tmp_78 = 0
        end
        return roundrect.roundedBoxEx(
          x,
          y,
          w,
          h,
          {
            radius = __lux_tmp_78,
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
      local __lux_tmp_79 = resolved.radius == nil
      if __lux_tmp_79 then
        __lux_tmp_79 = resolved.outerGlow == nil
      end
      local __lux_tmp_80 = __lux_tmp_79
      if __lux_tmp_80 then
        __lux_tmp_80 = drawLineShaderVerts(verts, fill)
      end
      if __lux_tmp_80 then
        return
      end
      local fallbackVerts = lineQuadVertsInto(lineFallbackVertsScratch, x1, y1, x2, y2, strokeWidth, noCaps, 0)
      local __lux_tmp_81 = fallbackVerts
      if __lux_tmp_81 == nil then
        __lux_tmp_81 = verts
      end
      return drawLineFallbackVerts(__lux_tmp_81, fill, nil)
    end
    drawLineImmediate = function(x1, y1, x2, y2, color, width, drawStyle)
      local resolved
      do
        local __lux_tmp_82 = drawStyle
        if __lux_tmp_82 == nil then
          __lux_tmp_82 = {}
        end
        resolved = __lux_tmp_82
      end
      local strokeWidth
      do
        local __lux_tmp_83 = width
        if __lux_tmp_83 == nil then
          local __lux_tmp_84 = resolved.width
          if __lux_tmp_84 == nil then
            __lux_tmp_84 = resolved.strokeWidth
          end
          __lux_tmp_83 = __lux_tmp_84
        end
        strokeWidth = mathMax(0, style.strokeWidth(__lux_tmp_83, 1))
      end
      if strokeWidth <= 0 then
        return
      end
      local fill
      do
        local __lux_tmp_85 = resolved.fill
        if __lux_tmp_85 == nil then
          local __lux_tmp_86 = resolved.color
          if __lux_tmp_86 == nil then
            local __lux_tmp_87 = color
            if __lux_tmp_87 == nil then
              __lux_tmp_87 = defaultLineColor
            end
            __lux_tmp_86 = __lux_tmp_87
          end
          __lux_tmp_85 = __lux_tmp_86
        end
        fill = style.fillFromStyle(__lux_tmp_85)
      end
      local __lux_tmp_88 = not style.fillVisible(fill)
      if __lux_tmp_88 then
        __lux_tmp_88 = resolved.backdrop == nil
      end
      if __lux_tmp_88 then
        return
      end
      local __lux_cmp_89 = false
      if mathAbs(y2 - y1) ~= nil and 0.001 ~= nil then
        __lux_cmp_89 = mathAbs(y2 - y1) < 0.001
      end
      if __lux_cmp_89 then
        local x = mathMin(x1, x2)
        local w = mathAbs(x2 - x1)
        if w <= 0 then
          return
        end
        local y = y1 - strokeWidth * 0.5
        local __lux_tmp_90 = resolved.radius ~= nil
        if not __lux_tmp_90 then
          __lux_tmp_90 = resolved.outerGlow ~= nil
        end
        if __lux_tmp_90 then
          return drawLineRect(x, y, w, strokeWidth, fill, resolved)
        end
      end
      local __lux_cmp_91 = false
      if mathAbs(x2 - x1) ~= nil and 0.001 ~= nil then
        __lux_cmp_91 = mathAbs(x2 - x1) < 0.001
      end
      if __lux_cmp_91 then
        local y = mathMin(y1, y2)
        local h = mathAbs(y2 - y1)
        if h <= 0 then
          return
        end
        local x = x1 - strokeWidth * 0.5
        local __lux_tmp_92 = resolved.radius ~= nil
        if not __lux_tmp_92 then
          __lux_tmp_92 = resolved.outerGlow ~= nil
        end
        if __lux_tmp_92 then
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
      local resolved
      do
        local __lux_tmp_93 = drawStyle
        if __lux_tmp_93 == nil then
          __lux_tmp_93 = {}
        end
        resolved = __lux_tmp_93
      end
      local transform, stripped = splitStyleTransform(resolved)
      if transform == nil then
        return drawLineImmediate(x1, y1, x2, y2, nil, nil, stripped)
      end
      local width
      do
        local __lux_tmp_94 = stripped.width
        if __lux_tmp_94 == nil then
          __lux_tmp_94 = stripped.strokeWidth
        end
        width = mathMax(1, style.strokeWidth(__lux_tmp_94, 1))
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
      local __lux_tmp_95 = vertical
      if __lux_tmp_95 then
        __lux_tmp_95 = 1
      end
      local __lux_tmp_96 = __lux_tmp_95
      if not __lux_tmp_96 then
        __lux_tmp_96 = 0
      end
      local __lux_tmp_97 = intensity
      if __lux_tmp_97 == nil then
        __lux_tmp_97 = 1
      end
      local __lux_tmp_98 = toNumber(radius)
      if __lux_tmp_98 == nil then
        __lux_tmp_98 = 0
      end
      return setupParamMatrix(
        material,
        __lux_tmp_96,
        __lux_tmp_97,
        0,
        0,
        w,
        h,
        0,
        mathMax(0, __lux_tmp_98),
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
      local __lux_tmp_99 = toNumber(amount)
      if __lux_tmp_99 == nil then
        __lux_tmp_99 = 1
      end
      return mathMax(0.001, __lux_tmp_99)
    end
    drawBlurredPoly = function(poly, material, amount)
      local __lux_tmp_100 = material == nil
      if not __lux_tmp_100 then
        __lux_tmp_100 = primitiveBlurRT == nil
      end
      local __lux_tmp_101 = __lux_tmp_100
      if not __lux_tmp_101 then
        __lux_tmp_101 = renderCopyRenderTargetToTexture == nil
      end
      if __lux_tmp_101 then
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
      local __lux_tmp_102 = spec == nil
      if not __lux_tmp_102 then
        __lux_tmp_102 = spec.tint == nil
      end
      if __lux_tmp_102 then
        return nil
      end
      local tint = spec.tint
      local alpha
      do
        local __lux_tmp_103 = tint.a
        if __lux_tmp_103 == nil then
          __lux_tmp_103 = 255
        end
        local __lux_tmp_104 = spec.opacity
        if __lux_tmp_104 == nil then
          __lux_tmp_104 = 1
        end
        alpha = __lux_tmp_103 * __lux_tmp_104
      end
      if alpha <= 0 then
        return nil
      end
      do
        local __lux_tmp_105 = tint.r
        if __lux_tmp_105 == nil then
          __lux_tmp_105 = 0
        end
        polyBackdropTintScratch.r = __lux_tmp_105
      end
      do
        local __lux_tmp_106 = tint.g
        if __lux_tmp_106 == nil then
          __lux_tmp_106 = 0
        end
        polyBackdropTintScratch.g = __lux_tmp_106
      end
      do
        local __lux_tmp_107 = tint.b
        if __lux_tmp_107 == nil then
          __lux_tmp_107 = 0
        end
        polyBackdropTintScratch.b = __lux_tmp_107
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
      local __lux_tmp_108 = spec == nil
      if not __lux_tmp_108 then
        __lux_tmp_108 = not shadersActive()
      end
      local __lux_tmp_109 = __lux_tmp_108
      if not __lux_tmp_109 then
        __lux_tmp_109 = not materialOK(primitiveMaterials.poly_pattern)
      end
      if __lux_tmp_109 then
        return false
      end
      local color
      do
        local __lux_tmp_110 = spec.color
        if __lux_tmp_110 == nil then
          __lux_tmp_110 = spec.tint
        end
        color = __lux_tmp_110
      end
      local __lux_tmp_111 = color ~= nil
      if __lux_tmp_111 then
        local __lux_tmp_112 = color.a
        if __lux_tmp_112 == nil then
          __lux_tmp_112 = 255
        end
        __lux_tmp_111 = __lux_tmp_112 <= 0
      end
      if __lux_tmp_111 then
        return false
      end
      local material = primitiveMaterials.poly_pattern
      local r, g, b, a
      do
        local __lux_tmp_113 = spec.color
        if __lux_tmp_113 == nil then
          __lux_tmp_113 = spec.tint
        end
        r, g, b, a = style.color01(style.asColor(__lux_tmp_113, makeColor(255, 255, 255, 24)))
      end
      local angle
      do
        local __lux_tmp_114 = toNumber(spec.angle)
        if __lux_tmp_114 == nil then
          __lux_tmp_114 = 135
        end
        angle = mathRad(__lux_tmp_114)
      end
      local smoke
      local __lux_match_115 = spec.kind
      if __lux_match_115 == "smoke" then
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
          local __lux_tmp_116 = toNumber(spec.scale)
          if __lux_tmp_116 == nil then
            __lux_tmp_116 = 140
          end
          pz = mathMax(1, __lux_tmp_116)
        end
        do
          local __lux_tmp_117 = toNumber(spec.density)
          if __lux_tmp_117 == nil then
            __lux_tmp_117 = 0.48
          end
          pw = mathClamp(__lux_tmp_117, 0, 1)
        end
        ox = roundrect.patternOffset(spec)
        oy = 1
        do
          local __lux_tmp_118 = toNumber(spec.softness)
          if __lux_tmp_118 == nil then
            __lux_tmp_118 = 0.3
          end
          oz = mathMax(0.001, __lux_tmp_118)
        end
        do
          local __lux_tmp_119 = toNumber(spec.warp)
          if __lux_tmp_119 == nil then
            __lux_tmp_119 = 0.85
          end
          ow = mathMax(0, __lux_tmp_119)
        end
      else
        do
          local __lux_tmp_120 = toNumber(spec.spacing)
          if __lux_tmp_120 == nil then
            __lux_tmp_120 = 12
          end
          pz = mathMax(1, __lux_tmp_120)
        end
        do
          local __lux_tmp_121 = toNumber(spec.width)
          if __lux_tmp_121 == nil then
            __lux_tmp_121 = 2
          end
          pw = mathMax(0.25, __lux_tmp_121)
        end
        ox = roundrect.patternOffset(spec)
      end
      do
        local __lux_tmp_122 = smoke
        if __lux_tmp_122 then
          local __lux_tmp_123 = toNumber(spec.seed)
          if __lux_tmp_123 == nil then
            __lux_tmp_123 = 0
          end
          __lux_tmp_122 = __lux_tmp_123
        end
        local __lux_tmp_124 = __lux_tmp_122
        if not __lux_tmp_124 then
          __lux_tmp_124 = 0
        end
        setupParamMatrix(
          material,
          r,
          g,
          b,
          a,
          poly.w,
          poly.h,
          __lux_tmp_124,
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
      local p4
      do
        local __lux_tmp_125 = poly.points[4]
        if __lux_tmp_125 == nil then
          __lux_tmp_125 = p3
        end
        p4 = __lux_tmp_125
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
      local __lux_tmp_126 = poly.count > 4
      if not __lux_tmp_126 then
        __lux_tmp_126 = not shadersActive()
      end
      local __lux_tmp_127 = __lux_tmp_126
      if not __lux_tmp_127 then
        __lux_tmp_127 = not materialOK(primitiveMaterials.poly_stroke)
      end
      if __lux_tmp_127 then
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
        local __lux_tmp_128 = drawStyle.fill
        if __lux_tmp_128 == nil then
          __lux_tmp_128 = drawStyle.color
        end
        fill = style.fillFromStyle(__lux_tmp_128)
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
            local __lux_tmp_129 = a.x
            if __lux_tmp_129 == nil then
              __lux_tmp_129 = a[1]
            end
            local __lux_tmp_130 = a.y
            if __lux_tmp_130 == nil then
              __lux_tmp_130 = a[2]
            end
            local __lux_tmp_131 = b.x
            if __lux_tmp_131 == nil then
              __lux_tmp_131 = b[1]
            end
            local __lux_tmp_132 = b.y
            if __lux_tmp_132 == nil then
              __lux_tmp_132 = b[2]
            end
            drawLineImmediate(
              __lux_tmp_129,
              __lux_tmp_130,
              __lux_tmp_131,
              __lux_tmp_132,
              nil,
              nil,
              lineStyle
            )
          end
        end
      end
    end
    drawPolyShadow = function(poly, points, shadow)
      local __lux_tmp_133 = shadow == nil
      if not __lux_tmp_133 then
        __lux_tmp_133 = shadow.color == nil
      end
      local __lux_tmp_134 = __lux_tmp_133
      if not __lux_tmp_134 then
        local __lux_tmp_135 = shadow.color.a
        if __lux_tmp_135 == nil then
          __lux_tmp_135 = 255
        end
        __lux_tmp_134 = __lux_tmp_135 <= 0
      end
      if __lux_tmp_134 then
        return false
      end
      local shifted = {}
      local spread
      do
        local __lux_tmp_136 = toNumber(shadow.blur)
        if __lux_tmp_136 == nil then
          __lux_tmp_136 = 12
        end
        spread = mathMax(1, __lux_tmp_136)
      end
      local cx = poly.x + poly.w * 0.5
      local cy = poly.y + poly.h * 0.5
      for index, point in ipairs(points) do
        local px, py = pointXY(point)
        local dx = px - cx
        local dy = py - cy
        local len = mathMax(1, mathSqrt(dx * dx + dy * dy))
        do
          local __lux_tmp_137 = shadow.x
          if __lux_tmp_137 == nil then
            __lux_tmp_137 = 0
          end
          local __lux_tmp_138 = shadow.y
          if __lux_tmp_138 == nil then
            __lux_tmp_138 = 0
          end
          shifted[index] = {
            x = px + __lux_tmp_137 + dx / len * spread,
            y = py + __lux_tmp_138 + dy / len * spread,
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
      local resolved
      do
        local __lux_tmp_139 = drawStyle
        if __lux_tmp_139 == nil then
          __lux_tmp_139 = {}
        end
        resolved = __lux_tmp_139
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
        local __lux_tmp_140 = resolved.fill
        if __lux_tmp_140 == nil then
          __lux_tmp_140 = resolved.color
        end
        fill = style.fillFromStyle(__lux_tmp_140)
      end
      local hasFill = style.fillVisible(fill)
      local strokeWidth = style.strokeWidthValue(resolved.strokeWidth, 0)
      local hasStroke = style.strokeVisible(resolved.stroke, strokeWidth)
      local __lux_tmp_141 = hasFill
      if __lux_tmp_141 then
        __lux_tmp_141 = materialOK(material)
      end
      if __lux_tmp_141 then
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
      local __lux_match_142 = fill
      local __lux_tag_143
      if __lux_match_142 ~= nil then
        __lux_tag_143 = __lux_match_142.kind
      end
      if __lux_tag_143 == style.FILL_LINEAR then
        local x1 = __lux_match_142.x1
        local y1 = __lux_match_142.y1
        local x2 = __lux_match_142.x2
        local y2 = __lux_match_142.y2
        do
          local __lux_tmp_144 = x1
          if __lux_tmp_144 == nil then
            __lux_tmp_144 = 0
          end
          p0 = __lux_tmp_144
        end
        do
          local __lux_tmp_145 = y1
          if __lux_tmp_145 == nil then
            __lux_tmp_145 = 0
          end
          p1 = __lux_tmp_145
        end
        do
          local __lux_tmp_146 = x2
          if __lux_tmp_146 == nil then
            __lux_tmp_146 = 1
          end
          p2 = __lux_tmp_146
        end
        do
          local __lux_tmp_147 = y2
          if __lux_tmp_147 == nil then
            __lux_tmp_147 = 1
          end
          p3 = __lux_tmp_147
        end
        style.bindGradientLut(material, fill)
      elseif __lux_tag_143 == style.FILL_RADIAL then
        local cx = __lux_match_142.cx
        local cy = __lux_match_142.cy
        local radius = __lux_match_142.radius
        do
          local __lux_tmp_148 = cx
          if __lux_tmp_148 == nil then
            __lux_tmp_148 = 0.5
          end
          p0 = __lux_tmp_148
        end
        do
          local __lux_tmp_149 = cy
          if __lux_tmp_149 == nil then
            __lux_tmp_149 = 0.5
          end
          p1 = __lux_tmp_149
        end
        do
          local __lux_tmp_150 = radius
          if __lux_tmp_150 == nil then
            __lux_tmp_150 = 0.5
          end
          p2 = __lux_tmp_150
        end
        p3 = 0
        style.bindGradientLut(material, fill)
      elseif __lux_tag_143 == style.FILL_CONIC then
        local cx = __lux_match_142.cx
        local cy = __lux_match_142.cy
        local rotation = __lux_match_142.rotation
        do
          local __lux_tmp_151 = cx
          if __lux_tmp_151 == nil then
            __lux_tmp_151 = 0.5
          end
          p0 = __lux_tmp_151
        end
        do
          local __lux_tmp_152 = cy
          if __lux_tmp_152 == nil then
            __lux_tmp_152 = 0.5
          end
          p1 = __lux_tmp_152
        end
        p2 = style.normalizedRotation(rotation)
        p3 = 0
        style.bindGradientLut(material, fill)
      else
        local __lux_unused_153 = nil
      end
      return p0, p1, p2, p3
    end
    setupPrimitiveAuxConstants = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3)
      if material == nil then
        return false
      end
      do
        local __lux_tmp_154 = a0
        if __lux_tmp_154 == nil then
          __lux_tmp_154 = 0
        end
        material:SetFloat("$c0_x", __lux_tmp_154)
      end
      do
        local __lux_tmp_155 = a1
        if __lux_tmp_155 == nil then
          __lux_tmp_155 = 0
        end
        material:SetFloat("$c0_y", __lux_tmp_155)
      end
      do
        local __lux_tmp_156 = a2
        if __lux_tmp_156 == nil then
          __lux_tmp_156 = 0
        end
        material:SetFloat("$c0_z", __lux_tmp_156)
      end
      do
        local __lux_tmp_157 = a3
        if __lux_tmp_157 == nil then
          __lux_tmp_157 = 0
        end
        material:SetFloat("$c0_w", __lux_tmp_157)
      end
      do
        local __lux_tmp_158 = b0
        if __lux_tmp_158 == nil then
          __lux_tmp_158 = 0
        end
        material:SetFloat("$c1_x", __lux_tmp_158)
      end
      do
        local __lux_tmp_159 = b1
        if __lux_tmp_159 == nil then
          __lux_tmp_159 = 0
        end
        material:SetFloat("$c1_y", __lux_tmp_159)
      end
      do
        local __lux_tmp_160 = b2
        if __lux_tmp_160 == nil then
          __lux_tmp_160 = 0
        end
        material:SetFloat("$c1_z", __lux_tmp_160)
      end
      do
        local __lux_tmp_161 = b3
        if __lux_tmp_161 == nil then
          __lux_tmp_161 = 0
        end
        material:SetFloat("$c1_w", __lux_tmp_161)
      end
      do
        local __lux_tmp_162 = c0
        if __lux_tmp_162 == nil then
          __lux_tmp_162 = 0
        end
        material:SetFloat("$c2_x", __lux_tmp_162)
      end
      do
        local __lux_tmp_163 = c1
        if __lux_tmp_163 == nil then
          __lux_tmp_163 = 0
        end
        material:SetFloat("$c2_y", __lux_tmp_163)
      end
      do
        local __lux_tmp_164 = c2
        if __lux_tmp_164 == nil then
          __lux_tmp_164 = 0
        end
        material:SetFloat("$c2_z", __lux_tmp_164)
      end
      do
        local __lux_tmp_165 = c3
        if __lux_tmp_165 == nil then
          __lux_tmp_165 = 0
        end
        material:SetFloat("$c2_w", __lux_tmp_165)
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
      do
        local __lux_tmp_166 = fill
        if __lux_tmp_166 == nil then
          __lux_tmp_166 = transparentFill
        end
        fill = __lux_tmp_166
      end
      local colorA
      do
        local __lux_tmp_167 = fill.colorA
        if __lux_tmp_167 == nil then
          __lux_tmp_167 = color_white
        end
        colorA = __lux_tmp_167
      end
      local colorB
      do
        local __lux_tmp_168 = fill.colorB
        if __lux_tmp_168 == nil then
          __lux_tmp_168 = colorA
        end
        colorB = __lux_tmp_168
      end
      local strokeColor
      do
        local __lux_tmp_169 = stroke
        if __lux_tmp_169 == nil then
          __lux_tmp_169 = transparentColor
        end
        strokeColor = __lux_tmp_169
      end
      local fillKind
      do
        local __lux_tmp_170 = fill.kind
        if __lux_tmp_170 == nil then
          __lux_tmp_170 = style.FILL_SOLID
        end
        fillKind = __lux_tmp_170
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
      local __lux_tmp_171 = spec == nil
      if not __lux_tmp_171 then
        __lux_tmp_171 = not shadersActive()
      end
      local __lux_tmp_172 = __lux_tmp_171
      if not __lux_tmp_172 then
        __lux_tmp_172 = not materialOK(primitiveMaterials.chamfer_innerglow)
      end
      if __lux_tmp_172 then
        return false
      end
      local color = spec.color
      local __lux_tmp_173 = color == nil
      if not __lux_tmp_173 then
        local __lux_tmp_174 = color.a
        if __lux_tmp_174 == nil then
          __lux_tmp_174 = 255
        end
        __lux_tmp_173 = __lux_tmp_174 <= 0
      end
      if __lux_tmp_173 then
        return false
      end
      local tl, tr, br, bl = chamferTuple(cuts, w, h)
      local material = primitiveMaterials.chamfer_innerglow
      local r, g, b, a = style.color01(color)
      do
        local __lux_tmp_175 = toNumber(spec.width)
        if __lux_tmp_175 == nil then
          __lux_tmp_175 = 8
        end
        local __lux_tmp_176 = toNumber(spec.strength)
        if __lux_tmp_176 == nil then
          __lux_tmp_176 = 1
        end
        local __lux_tmp_177 = toNumber(spec.falloff)
        if __lux_tmp_177 == nil then
          __lux_tmp_177 = 1.65
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
          mathMax(0.001, __lux_tmp_175),
          mathMax(0, __lux_tmp_176),
          mathMax(0.001, __lux_tmp_177),
          0
        )
      end
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(x, y, w, h)
      return true
    end
    drawChamferOuterGlowSpec = function(x, y, w, h, cuts, spec)
      local __lux_tmp_178 = spec == nil
      if not __lux_tmp_178 then
        __lux_tmp_178 = not shadersActive()
      end
      local __lux_tmp_179 = __lux_tmp_178
      if not __lux_tmp_179 then
        __lux_tmp_179 = not materialOK(primitiveMaterials.chamfer_outerglow)
      end
      if __lux_tmp_179 then
        return false
      end
      local color = spec.color
      local __lux_tmp_180 = color == nil
      if not __lux_tmp_180 then
        local __lux_tmp_181 = color.a
        if __lux_tmp_181 == nil then
          __lux_tmp_181 = 255
        end
        __lux_tmp_180 = __lux_tmp_181 <= 0
      end
      if __lux_tmp_180 then
        return false
      end
      local spread
      do
        local __lux_tmp_182 = spec.spread
        if __lux_tmp_182 == nil then
          __lux_tmp_182 = spec.width
        end
        local __lux_tmp_183 = toNumber(__lux_tmp_182)
        if __lux_tmp_183 == nil then
          __lux_tmp_183 = 18
        end
        spread = mathMax(1, __lux_tmp_183)
      end
      local tl, tr, br, bl = chamferTuple(cuts, w, h)
      local material = primitiveMaterials.chamfer_outerglow
      local r, g, b, a = style.color01(color)
      do
        local __lux_tmp_184 = toNumber(spec.width)
        if __lux_tmp_184 == nil then
          __lux_tmp_184 = spread
        end
        local __lux_tmp_185 = toNumber(spec.strength)
        if __lux_tmp_185 == nil then
          __lux_tmp_185 = 1
        end
        local __lux_tmp_186 = toNumber(spec.falloff)
        if __lux_tmp_186 == nil then
          __lux_tmp_186 = 1.9
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
          mathMax(0.001, __lux_tmp_184),
          mathMax(0, __lux_tmp_185),
          mathMax(0.001, __lux_tmp_186),
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
      local __lux_tmp_187 = spec == nil
      if not __lux_tmp_187 then
        __lux_tmp_187 = not shadersActive()
      end
      local __lux_tmp_188 = __lux_tmp_187
      if not __lux_tmp_188 then
        __lux_tmp_188 = not materialOK(primitiveMaterials.chamfer_pattern)
      end
      if __lux_tmp_188 then
        return false
      end
      local color
      do
        local __lux_tmp_189 = spec.color
        if __lux_tmp_189 == nil then
          __lux_tmp_189 = spec.tint
        end
        color = __lux_tmp_189
      end
      local __lux_tmp_190 = color ~= nil
      if __lux_tmp_190 then
        local __lux_tmp_191 = color.a
        if __lux_tmp_191 == nil then
          __lux_tmp_191 = 255
        end
        __lux_tmp_190 = __lux_tmp_191 <= 0
      end
      if __lux_tmp_190 then
        return false
      end
      local tl, tr, br, bl = chamferTuple(cuts, w, h)
      local angle
      do
        local __lux_tmp_192 = toNumber(spec.angle)
        if __lux_tmp_192 == nil then
          __lux_tmp_192 = 135
        end
        angle = mathRad(__lux_tmp_192)
      end
      local smoke
      local __lux_match_193 = spec.kind
      if __lux_match_193 == "smoke" then
        smoke = true
      else
        smoke = false
      end
      local material = primitiveMaterials.chamfer_pattern
      local r, g, b, a
      do
        local __lux_tmp_194 = spec.color
        if __lux_tmp_194 == nil then
          __lux_tmp_194 = spec.tint
        end
        r, g, b, a = style.color01(style.asColor(__lux_tmp_194, makeColor(255, 255, 255, 24)))
      end
      local pz = 1
      local pw = 1
      if smoke then
        local density
        do
          local __lux_tmp_195 = toNumber(spec.density)
          if __lux_tmp_195 == nil then
            __lux_tmp_195 = 0.48
          end
          density = mathClamp(mathFloor(__lux_tmp_195 * 255 + 0.5), 0, 255)
        end
        local softness
        do
          local __lux_tmp_196 = toNumber(spec.softness)
          if __lux_tmp_196 == nil then
            __lux_tmp_196 = 0.3
          end
          softness = mathClamp(mathFloor(__lux_tmp_196 * 255 + 0.5), 0, 255)
        end
        local warp
        do
          local __lux_tmp_197 = toNumber(spec.warp)
          if __lux_tmp_197 == nil then
            __lux_tmp_197 = 0.85
          end
          warp = mathClamp(mathFloor(__lux_tmp_197 * 255 + 0.5), 0, 255)
        end
        do
          local __lux_tmp_198 = toNumber(spec.scale)
          if __lux_tmp_198 == nil then
            __lux_tmp_198 = 140
          end
          pz = mathMax(1, __lux_tmp_198)
        end
        pw = density + softness * 256 + warp * 65536
      else
        do
          local __lux_tmp_199 = toNumber(spec.spacing)
          if __lux_tmp_199 == nil then
            __lux_tmp_199 = 12
          end
          pz = mathMax(1, __lux_tmp_199)
        end
        do
          local __lux_tmp_200 = toNumber(spec.width)
          if __lux_tmp_200 == nil then
            __lux_tmp_200 = 2
          end
          pw = mathMax(0.25, __lux_tmp_200)
        end
      end
      do
        local __lux_tmp_201 = smoke
        if __lux_tmp_201 then
          __lux_tmp_201 = 1
        end
        local __lux_tmp_202 = __lux_tmp_201
        if not __lux_tmp_202 then
          __lux_tmp_202 = 0
        end
        local __lux_tmp_203 = smoke
        if __lux_tmp_203 then
          local __lux_tmp_204 = toNumber(spec.seed)
          if __lux_tmp_204 == nil then
            __lux_tmp_204 = 0
          end
          __lux_tmp_203 = __lux_tmp_204
        end
        local __lux_tmp_205 = __lux_tmp_203
        if not __lux_tmp_205 then
          __lux_tmp_205 = 0
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
          __lux_tmp_202 + __lux_tmp_205,
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
      local __lux_tmp_206 = not style.strokeVisible(stroke, strokeWidth)
      if not __lux_tmp_206 then
        __lux_tmp_206 = not shadersActive()
      end
      local __lux_tmp_207 = __lux_tmp_206
      if not __lux_tmp_207 then
        __lux_tmp_207 = not materialOK(primitiveMaterials.chamfer_stroke)
      end
      if __lux_tmp_207 then
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
      local __lux_tmp_208 = not shadersActive()
      if not __lux_tmp_208 then
        __lux_tmp_208 = not materialOK(primitiveMaterials.chamfer)
      end
      if __lux_tmp_208 then
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
          local __lux_tmp_209 = innerSpec.color
          if __lux_tmp_209 == nil then
            __lux_tmp_209 = transparentColor
          end
          glowR, glowG, glowB, glowA = style.color01(__lux_tmp_209)
        end
        do
          local __lux_tmp_210 = toNumber(innerSpec.width)
          if __lux_tmp_210 == nil then
            __lux_tmp_210 = 8
          end
          glowWidth = mathMax(0.001, __lux_tmp_210)
        end
        do
          local __lux_tmp_211 = toNumber(innerSpec.strength)
          if __lux_tmp_211 == nil then
            __lux_tmp_211 = 1
          end
          glowStrength = mathMax(0, __lux_tmp_211)
        end
        do
          local __lux_tmp_212 = toNumber(innerSpec.falloff)
          if __lux_tmp_212 == nil then
            __lux_tmp_212 = 1.65
          end
          glowFalloff = mathMax(0.001, __lux_tmp_212)
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
        local __lux_tmp_213 = fill
        if __lux_tmp_213 == nil then
          __lux_tmp_213 = transparentFill
        end
        setupPrimitiveFillConstants(material, w, h, __lux_tmp_213, stroke, strokeWidth, 0)
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
        local __lux_tmp_214 = source
        if __lux_tmp_214 == nil then
          __lux_tmp_214 = {}
        end
        for key, value in pairs(__lux_tmp_214) do
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
      local resolved
      do
        local __lux_tmp_215 = drawStyle
        if __lux_tmp_215 == nil then
          __lux_tmp_215 = {}
        end
        resolved = __lux_tmp_215
      end
      local cuts
      do
        local __lux_tmp_216 = resolvedCuts
        if __lux_tmp_216 == nil then
          local __lux_tmp_217 = resolved.cuts
          if __lux_tmp_217 == nil then
            __lux_tmp_217 = 0
          end
          __lux_tmp_216 = __lux_tmp_217
        end
        cuts = __lux_tmp_216
      end
      local outer = roundrect.outerGlowStyle(resolved.outerGlow)
      if outer ~= nil then
        drawChamferOuterGlowSpec(x, y, w, h, cuts, outer)
      end
      local fill
      do
        local __lux_tmp_218 = resolved.fill
        if __lux_tmp_218 == nil then
          __lux_tmp_218 = resolved.color
        end
        fill = style.fillFromStyle(__lux_tmp_218)
      end
      local strokeWidth = style.strokeWidthValue(resolved.strokeWidth, 0)
      local fillVisible = style.fillVisible(fill)
      local strokeVisible = style.strokeVisible(resolved.stroke, strokeWidth)
      local inner = roundrect.innerGlowStyle(resolved.innerGlow)
      local pattern = resolved.pattern
      local baseDrawn = false
      local baseDrewStroke = false
      local baseDrewInner = false
      local __lux_tmp_219 = resolved.shadow == nil
      if __lux_tmp_219 then
        __lux_tmp_219 = resolved.backdrop == nil
      end
      local __lux_tmp_220 = __lux_tmp_219
      if __lux_tmp_220 then
        local __lux_tmp_221 = fillVisible
        if not __lux_tmp_221 then
          __lux_tmp_221 = strokeVisible
        end
        local __lux_tmp_222 = __lux_tmp_221
        if not __lux_tmp_222 then
          __lux_tmp_222 = inner ~= nil
        end
        __lux_tmp_220 = __lux_tmp_222
      end
      if __lux_tmp_220 then
        if pattern == nil then
          baseDrawn = drawChamferBasePass(x, y, w, h, cuts, fill, resolved.stroke, strokeWidth, inner)
          do
            local __lux_tmp_223 = baseDrawn
            if __lux_tmp_223 then
              __lux_tmp_223 = strokeVisible
            end
            baseDrewStroke = __lux_tmp_223
          end
          do
            local __lux_tmp_224 = baseDrawn
            if __lux_tmp_224 then
              __lux_tmp_224 = inner ~= nil
            end
            baseDrewInner = __lux_tmp_224
          end
        else
          if fillVisible then
            baseDrawn = drawChamferBasePass(x, y, w, h, cuts, fill, nil, 0, nil)
          end
        end
      end
      local __lux_tmp_225 = not baseDrawn
      if __lux_tmp_225 then
        local __lux_tmp_226 = fillVisible
        if not __lux_tmp_226 then
          __lux_tmp_226 = resolved.shadow ~= nil
        end
        local __lux_tmp_227 = __lux_tmp_226
        if not __lux_tmp_227 then
          __lux_tmp_227 = resolved.backdrop ~= nil
        end
        __lux_tmp_225 = __lux_tmp_227
      end
      if __lux_tmp_225 then
        drawChamferFallback(x, y, w, h, cuts, resolved, true)
      end
      if pattern ~= nil then
        drawChamferPattern(x, y, w, h, cuts, pattern)
      end
      local __lux_tmp_228 = strokeVisible
      if __lux_tmp_228 then
        __lux_tmp_228 = not baseDrewStroke
      end
      if __lux_tmp_228 then
        if not drawChamferStroke(x, y, w, h, cuts, resolved.stroke, strokeWidth) then
          drawChamferStrokeFallback(x, y, w, h, cuts, resolved.stroke, strokeWidth)
        end
      end
      local __lux_tmp_229 = inner ~= nil
      if __lux_tmp_229 then
        __lux_tmp_229 = not baseDrewInner
      end
      if __lux_tmp_229 then
        drawChamferInnerGlowSpec(x, y, w, h, cuts, inner)
      end
    end
  end
  do
    polyEx = function(points, drawStyle)
      local resolved
      do
        local __lux_tmp_230 = drawStyle
        if __lux_tmp_230 == nil then
          __lux_tmp_230 = {}
        end
        resolved = __lux_tmp_230
      end
      local transform, stripped = splitStyleTransform(resolved)
      local poly = normalizePoly(points)
      local __lux_tmp_231 = transform ~= nil
      if __lux_tmp_231 then
        __lux_tmp_231 = poly ~= nil
      end
      if __lux_tmp_231 then
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
      local resolved
      do
        local __lux_tmp_232 = drawStyle
        if __lux_tmp_232 == nil then
          __lux_tmp_232 = {}
        end
        resolved = __lux_tmp_232
      end
      local transform, stripped = splitStyleTransform(resolved)
      local cuts
      do
        local __lux_tmp_233 = stripped.cuts
        if __lux_tmp_233 == nil then
          __lux_tmp_233 = 0
        end
        cuts = __lux_tmp_233
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
