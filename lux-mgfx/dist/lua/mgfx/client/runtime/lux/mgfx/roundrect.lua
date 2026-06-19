return function(__lux_import)
  local __lux_exports = {}
  local geometry
  local style
  local drawRoundedBox
  local getConVar
  local matrixCtor
  local mathClamp
  local mathCos
  local mathFloor
  local mathMax
  local mathMin
  local mathRad
  local mathSin
  local renderCopyRenderTargetToTexture
  local surfaceDrawOutlinedRect
  local surfaceDrawRect
  local surfaceSetMaterial
  local surfaceSetDrawColor
  local typeOf
  local toNumber
  local makeColor
  local realTime
  local drawTransformedPoly
  local drawTexturedQuad
  local hasTransform
  local recordDraws
  local splitStyleTransform
  local withTransform
  local paramMatrixProbe
  local paramMatrixSetUnpacked
  local paramMatrices
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
  local transparentColor
  local configureRoundRect
  local materialOK
  local shadersActive
  local clearArray
  local fillColor
  local setColor
  local copyInto
  local appendPoint
  local appendCorner
  local fallbackRoundRectPoints
  local drawFallbackStroke
  local innerGlowStyle
  local outerGlowStyle
  local patternStyle
  local patternOffset
  local roundRectFillParams
  local setupParamMatrix
  local setupAuxConstants
  local setupConstants
  local setupPatternConstants
  local drawRoundRectFillPass
  local drawRoundRectPattern
  local drawRoundRectInnerGlowSpec
  local drawRoundRectOuterGlowSpec
  local backdropTintColor
  local drawRoundRectBackdrop
  local drawRoundRectStrokePass
  local drawRoundRectFxPass
  local drawRoundRectShader
  local drawRoundRectImmediate
  local roundedBoxEx
  local roundedBox
  local circle
  local circleEx
  local capsule
  local capsuleEx
  local install
  do
    local geometryImport = __lux_import("lux/mgfx/geometry#client")
    local styleImport = __lux_import("lux/mgfx/style#client")
    geometry = geometryImport
    style = styleImport
    drawRoundedBox = _G.draw.RoundedBox
    getConVar = GetConVar
    matrixCtor = Matrix
    mathClamp = math.Clamp
    mathCos = math.cos
    mathFloor = math.floor
    mathMax = math.max
    mathMin = math.min
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
    surfaceDrawOutlinedRect = surface.DrawOutlinedRect
    surfaceDrawRect = surface.DrawRect
    surfaceSetMaterial = surface.SetMaterial
    surfaceSetDrawColor = surface.SetDrawColor
    typeOf = type
    toNumber = tonumber
    makeColor = Color
    realTime = RealTime
    drawTransformedPoly = geometry.drawTransformedPoly
    drawTexturedQuad = geometry.drawTexturedQuad
    hasTransform = geometry.hasTransform
    recordDraws = geometry.recordDraws
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
    transparentColor = makeColor(0, 0, 0, 0)
    configureRoundRect = function(owner)
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
          __lux_tmp_Materials_6 = roundRectMaterials
        end
        if __lux_tmp_Materials_6 == nil then
          __lux_tmp_Materials_6 = {}
        end
        roundRectMaterials = __lux_tmp_Materials_6
      end
      do
        local __lux_tmp_BlurRT_7 = owner._BlurRT
        if __lux_tmp_BlurRT_7 == nil then
          __lux_tmp_BlurRT_7 = materialState.blurRT
        end
        if __lux_tmp_BlurRT_7 == nil then
          __lux_tmp_BlurRT_7 = roundRectBlurRT
        end
        roundRectBlurRT = __lux_tmp_BlurRT_7
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
        local __lux_tmp_radius_13 = toNumber(radius)
        if __lux_tmp_radius_13 == nil then
          __lux_tmp_radius_13 = 0
        end
        radius = mathMin(mathMax(0, __lux_tmp_radius_13), w * 0.5, h * 0.5)
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
        local __lux_tmp_width_14 = toNumber(width)
        if __lux_tmp_width_14 == nil then
          __lux_tmp_width_14 = 1
        end
        width = mathMax(1, __lux_tmp_width_14)
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
  end
  do
    innerGlowStyle = function(glow)
      if glow == nil or glow == false then
        return nil
      end
      if glow == true then
        return {
          color = makeColor(76, 190, 255, 34),
          width = 7,
          strength = 1,
          falloff = style.glowSoftnessToFalloff(0.55),
        }
      end
      if style.isColor(glow) then
        return { color = glow, width = 7, strength = 1, falloff = style.glowSoftnessToFalloff(0.55) }
      end
      if typeOf(glow) ~= "table" then
        return nil
      end
      local __lux_tmp_color_15 = glow.color
      if __lux_tmp_color_15 == nil then
        __lux_tmp_color_15 = glow.tint
      end
      local __lux_tmp_size_16 = glow.size
      if __lux_tmp_size_16 == nil then
        __lux_tmp_size_16 = glow.width
      end
      local __lux_tmp_size_17 = toNumber(__lux_tmp_size_16)
      if __lux_tmp_size_17 == nil then
        __lux_tmp_size_17 = 7
      end
      local __lux_tmp_opacity_18 = glow.opacity
      if __lux_tmp_opacity_18 == nil then
        __lux_tmp_opacity_18 = glow.strength
      end
      local __lux_tmp_opacity_19 = toNumber(__lux_tmp_opacity_18)
      if __lux_tmp_opacity_19 == nil then
        __lux_tmp_opacity_19 = 1
      end
      local __lux_tmp_falloff_20 = toNumber(glow.falloff)
      if __lux_tmp_falloff_20 == nil then
        __lux_tmp_falloff_20 = style.glowSoftnessToFalloff(glow.softness, 0.55)
      end
      return {
        color = style.asColor(__lux_tmp_color_15, makeColor(76, 190, 255, 34)),
        width = mathMax(1, __lux_tmp_size_17),
        strength = __lux_tmp_opacity_19,
        falloff = __lux_tmp_falloff_20,
      }
    end
    outerGlowStyle = function(glow)
      if glow == nil or glow == false then
        return nil
      end
      if glow == true then
        return {
          color = makeColor(76, 190, 255, 88),
          width = 18,
          spread = 18,
          strength = 1,
          falloff = style.glowSoftnessToFalloff(0.54),
        }
      end
      if style.isColor(glow) then
        return {
          color = glow,
          width = 18,
          spread = 18,
          strength = 1,
          falloff = style.glowSoftnessToFalloff(0.54),
        }
      end
      if typeOf(glow) ~= "table" then
        return nil
      end
      local width
      do
        local __lux_tmp_size_21 = glow.size
        if __lux_tmp_size_21 == nil then
          __lux_tmp_size_21 = glow.width
        end
        if __lux_tmp_size_21 == nil then
          __lux_tmp_size_21 = glow.spread
        end
        local __lux_tmp_size_22 = toNumber(__lux_tmp_size_21)
        if __lux_tmp_size_22 == nil then
          __lux_tmp_size_22 = 18
        end
        width = mathMax(1, __lux_tmp_size_22)
      end
      local __lux_tmp_color_23 = glow.color
      if __lux_tmp_color_23 == nil then
        __lux_tmp_color_23 = glow.tint
      end
      local __lux_tmp_spread_24 = toNumber(glow.spread)
      if __lux_tmp_spread_24 == nil then
        __lux_tmp_spread_24 = width
      end
      local __lux_tmp_opacity_25 = glow.opacity
      if __lux_tmp_opacity_25 == nil then
        __lux_tmp_opacity_25 = glow.strength
      end
      local __lux_tmp_opacity_26 = toNumber(__lux_tmp_opacity_25)
      if __lux_tmp_opacity_26 == nil then
        __lux_tmp_opacity_26 = 1
      end
      local __lux_tmp_falloff_27 = toNumber(glow.falloff)
      if __lux_tmp_falloff_27 == nil then
        __lux_tmp_falloff_27 = style.glowSoftnessToFalloff(glow.softness, 0.54)
      end
      return {
        color = style.asColor(__lux_tmp_color_23, makeColor(76, 190, 255, 88)),
        width = width,
        spread = mathMax(1, __lux_tmp_spread_24),
        strength = __lux_tmp_opacity_26,
        falloff = __lux_tmp_falloff_27,
      }
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
        local __lux_match_28 = pattern.kind
        if __lux_match_28 == "stripe" or __lux_match_28 == "smoke" then
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
        local __lux_obj_pattern_29 = pattern
        local __lux_val_offset_30 = nil
        if __lux_obj_pattern_29 ~= nil then
          __lux_val_offset_30 = __lux_obj_pattern_29.offset
        end
        offset = toNumber(__lux_val_offset_30)
        if offset == nil then
          offset = 0
        end
      end
      local speed
      do
        local __lux_obj_pattern_31 = pattern
        local __lux_val_speed_32 = nil
        if __lux_obj_pattern_31 ~= nil then
          __lux_val_speed_32 = __lux_obj_pattern_31.speed
        end
        speed = toNumber(__lux_val_speed_32)
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
      local __lux_match_33 = fill
      local __lux_tag_34
      if __lux_match_33 ~= nil then
        __lux_tag_34 = __lux_match_33.kind
      end
      if __lux_tag_34 == style.FILL_LINEAR then
        local x1 = __lux_match_33.x1
        local y1 = __lux_match_33.y1
        local x2 = __lux_match_33.x2
        local y2 = __lux_match_33.y2
        do
          local __lux_tmp_x1_35 = x1
          if __lux_tmp_x1_35 == nil then
            __lux_tmp_x1_35 = 0
          end
          p0 = __lux_tmp_x1_35
        end
        do
          local __lux_tmp_y1_36 = y1
          if __lux_tmp_y1_36 == nil then
            __lux_tmp_y1_36 = 0
          end
          p1 = __lux_tmp_y1_36
        end
        do
          local __lux_tmp_x2_37 = x2
          if __lux_tmp_x2_37 == nil then
            __lux_tmp_x2_37 = 1
          end
          p2 = __lux_tmp_x2_37
        end
        do
          local __lux_tmp_y2_38 = y2
          if __lux_tmp_y2_38 == nil then
            __lux_tmp_y2_38 = 1
          end
          p3 = __lux_tmp_y2_38
        end
        style.bindGradientLut(material, fill)
      elseif __lux_tag_34 == style.FILL_RADIAL then
        local cx = __lux_match_33.cx
        local cy = __lux_match_33.cy
        local radius = __lux_match_33.radius
        do
          local __lux_tmp_cx_39 = cx
          if __lux_tmp_cx_39 == nil then
            __lux_tmp_cx_39 = 0.5
          end
          p0 = __lux_tmp_cx_39
        end
        do
          local __lux_tmp_cy_40 = cy
          if __lux_tmp_cy_40 == nil then
            __lux_tmp_cy_40 = 0.5
          end
          p1 = __lux_tmp_cy_40
        end
        do
          local __lux_tmp_radius_41 = radius
          if __lux_tmp_radius_41 == nil then
            __lux_tmp_radius_41 = 0.5
          end
          p2 = __lux_tmp_radius_41
        end
        p3 = 0
        style.bindGradientLut(material, fill)
      elseif __lux_tag_34 == style.FILL_CONIC then
        local cx = __lux_match_33.cx
        local cy = __lux_match_33.cy
        local rotation = __lux_match_33.rotation
        do
          local __lux_tmp_cx_42 = cx
          if __lux_tmp_cx_42 == nil then
            __lux_tmp_cx_42 = 0.5
          end
          p0 = __lux_tmp_cx_42
        end
        do
          local __lux_tmp_cy_43 = cy
          if __lux_tmp_cy_43 == nil then
            __lux_tmp_cy_43 = 0.5
          end
          p1 = __lux_tmp_cy_43
        end
        p2 = style.normalizedRotation(rotation)
        p3 = 0
        style.bindGradientLut(material, fill)
      else
        local __lux_unused_44 = nil
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
        local __lux_tmp_a0_45 = a0
        if __lux_tmp_a0_45 == nil then
          __lux_tmp_a0_45 = 0
        end
        local __lux_tmp_b0_46 = b0
        if __lux_tmp_b0_46 == nil then
          __lux_tmp_b0_46 = 0
        end
        local __lux_tmp_c0_47 = c0
        if __lux_tmp_c0_47 == nil then
          __lux_tmp_c0_47 = 0
        end
        local __lux_tmp_d0_48 = d0
        if __lux_tmp_d0_48 == nil then
          __lux_tmp_d0_48 = 0
        end
        local __lux_tmp_a1_49 = a1
        if __lux_tmp_a1_49 == nil then
          __lux_tmp_a1_49 = 0
        end
        local __lux_tmp_b1_50 = b1
        if __lux_tmp_b1_50 == nil then
          __lux_tmp_b1_50 = 0
        end
        local __lux_tmp_c1_51 = c1
        if __lux_tmp_c1_51 == nil then
          __lux_tmp_c1_51 = 0
        end
        local __lux_tmp_d1_52 = d1
        if __lux_tmp_d1_52 == nil then
          __lux_tmp_d1_52 = 0
        end
        local __lux_tmp_a2_53 = a2
        if __lux_tmp_a2_53 == nil then
          __lux_tmp_a2_53 = 0
        end
        local __lux_tmp_b2_54 = b2
        if __lux_tmp_b2_54 == nil then
          __lux_tmp_b2_54 = 0
        end
        local __lux_tmp_c2_55 = c2
        if __lux_tmp_c2_55 == nil then
          __lux_tmp_c2_55 = 0
        end
        local __lux_tmp_d2_56 = d2
        if __lux_tmp_d2_56 == nil then
          __lux_tmp_d2_56 = 0
        end
        local __lux_tmp_a3_57 = a3
        if __lux_tmp_a3_57 == nil then
          __lux_tmp_a3_57 = 0
        end
        local __lux_tmp_b3_58 = b3
        if __lux_tmp_b3_58 == nil then
          __lux_tmp_b3_58 = 0
        end
        local __lux_tmp_c3_59 = c3
        if __lux_tmp_c3_59 == nil then
          __lux_tmp_c3_59 = 0
        end
        local __lux_tmp_d3_60 = d3
        if __lux_tmp_d3_60 == nil then
          __lux_tmp_d3_60 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_a0_45,
          __lux_tmp_b0_46,
          __lux_tmp_c0_47,
          __lux_tmp_d0_48,
          __lux_tmp_a1_49,
          __lux_tmp_b1_50,
          __lux_tmp_c1_51,
          __lux_tmp_d1_52,
          __lux_tmp_a2_53,
          __lux_tmp_b2_54,
          __lux_tmp_c2_55,
          __lux_tmp_d2_56,
          __lux_tmp_a3_57,
          __lux_tmp_b3_58,
          __lux_tmp_c3_59,
          __lux_tmp_d3_60
        )
      end
      material:SetMatrix("$viewprojmat", matrix)
      return true
    end
    setupAuxConstants = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3)
      if material == nil then
        return false
      end
      do
        local __lux_tmp_a0_61 = a0
        if __lux_tmp_a0_61 == nil then
          __lux_tmp_a0_61 = 0
        end
        material:SetFloat("$c0_x", __lux_tmp_a0_61)
      end
      do
        local __lux_tmp_a1_62 = a1
        if __lux_tmp_a1_62 == nil then
          __lux_tmp_a1_62 = 0
        end
        material:SetFloat("$c0_y", __lux_tmp_a1_62)
      end
      do
        local __lux_tmp_a2_63 = a2
        if __lux_tmp_a2_63 == nil then
          __lux_tmp_a2_63 = 0
        end
        material:SetFloat("$c0_z", __lux_tmp_a2_63)
      end
      do
        local __lux_tmp_a3_64 = a3
        if __lux_tmp_a3_64 == nil then
          __lux_tmp_a3_64 = 0
        end
        material:SetFloat("$c0_w", __lux_tmp_a3_64)
      end
      do
        local __lux_tmp_b0_65 = b0
        if __lux_tmp_b0_65 == nil then
          __lux_tmp_b0_65 = 0
        end
        material:SetFloat("$c1_x", __lux_tmp_b0_65)
      end
      do
        local __lux_tmp_b1_66 = b1
        if __lux_tmp_b1_66 == nil then
          __lux_tmp_b1_66 = 0
        end
        material:SetFloat("$c1_y", __lux_tmp_b1_66)
      end
      do
        local __lux_tmp_b2_67 = b2
        if __lux_tmp_b2_67 == nil then
          __lux_tmp_b2_67 = 0
        end
        material:SetFloat("$c1_z", __lux_tmp_b2_67)
      end
      do
        local __lux_tmp_b3_68 = b3
        if __lux_tmp_b3_68 == nil then
          __lux_tmp_b3_68 = 0
        end
        material:SetFloat("$c1_w", __lux_tmp_b3_68)
      end
      do
        local __lux_tmp_c0_69 = c0
        if __lux_tmp_c0_69 == nil then
          __lux_tmp_c0_69 = 0
        end
        material:SetFloat("$c2_x", __lux_tmp_c0_69)
      end
      do
        local __lux_tmp_c1_70 = c1
        if __lux_tmp_c1_70 == nil then
          __lux_tmp_c1_70 = 0
        end
        material:SetFloat("$c2_y", __lux_tmp_c1_70)
      end
      do
        local __lux_tmp_c2_71 = c2
        if __lux_tmp_c2_71 == nil then
          __lux_tmp_c2_71 = 0
        end
        material:SetFloat("$c2_z", __lux_tmp_c2_71)
      end
      do
        local __lux_tmp_c3_72 = c3
        if __lux_tmp_c3_72 == nil then
          __lux_tmp_c3_72 = 0
        end
        material:SetFloat("$c2_w", __lux_tmp_c3_72)
      end
      do
        local __lux_tmp_d0_73 = d0
        if __lux_tmp_d0_73 == nil then
          __lux_tmp_d0_73 = 0
        end
        material:SetFloat("$c3_x", __lux_tmp_d0_73)
      end
      do
        local __lux_tmp_d1_74 = d1
        if __lux_tmp_d1_74 == nil then
          __lux_tmp_d1_74 = 0
        end
        material:SetFloat("$c3_y", __lux_tmp_d1_74)
      end
      do
        local __lux_tmp_d2_75 = d2
        if __lux_tmp_d2_75 == nil then
          __lux_tmp_d2_75 = 0
        end
        material:SetFloat("$c3_z", __lux_tmp_d2_75)
      end
      do
        local __lux_tmp_d3_76 = d3
        if __lux_tmp_d3_76 == nil then
          __lux_tmp_d3_76 = 0
        end
        material:SetFloat("$c3_w", __lux_tmp_d3_76)
      end
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
        local __lux_tmp_radius_77 = toNumber(radius)
        if __lux_tmp_radius_77 == nil then
          __lux_tmp_radius_77 = 0
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
          mathMax(0, __lux_tmp_radius_77),
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
    setupPatternConstants = function(material, w, h, radius, pattern)
      local color
      do
        local __lux_tmp_color_78 = pattern.color
        if __lux_tmp_color_78 == nil then
          __lux_tmp_color_78 = pattern.tint
        end
        color = style.asColor(__lux_tmp_color_78, makeColor(255, 255, 255, 24))
      end
      local r, g, b, a = style.color01(color)
      local angle
      do
        local __lux_tmp_angle_79 = toNumber(pattern.angle)
        if __lux_tmp_angle_79 == nil then
          __lux_tmp_angle_79 = 135
        end
        angle = mathRad(__lux_tmp_angle_79)
      end
      local smoke
      local __lux_match_80 = pattern.kind
      if __lux_match_80 == "smoke" then
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
          local __lux_tmp_scale_81 = toNumber(pattern.scale)
          if __lux_tmp_scale_81 == nil then
            __lux_tmp_scale_81 = 140
          end
          pz = mathMax(1, __lux_tmp_scale_81)
        end
        do
          local __lux_tmp_density_82 = toNumber(pattern.density)
          if __lux_tmp_density_82 == nil then
            __lux_tmp_density_82 = 0.48
          end
          pw = mathClamp(__lux_tmp_density_82, 0, 1)
        end
        ox = patternOffset(pattern)
        oy = 1
        do
          local __lux_tmp_softness_83 = toNumber(pattern.softness)
          if __lux_tmp_softness_83 == nil then
            __lux_tmp_softness_83 = 0.3
          end
          oz = mathMax(0.001, __lux_tmp_softness_83)
        end
        do
          local __lux_tmp_warp_84 = toNumber(pattern.warp)
          if __lux_tmp_warp_84 == nil then
            __lux_tmp_warp_84 = 0.85
          end
          ow = mathMax(0, __lux_tmp_warp_84)
        end
      else
        do
          local __lux_tmp_spacing_85 = toNumber(pattern.spacing)
          if __lux_tmp_spacing_85 == nil then
            __lux_tmp_spacing_85 = 12
          end
          pz = mathMax(1, __lux_tmp_spacing_85)
        end
        do
          local __lux_tmp_width_86 = toNumber(pattern.width)
          if __lux_tmp_width_86 == nil then
            __lux_tmp_width_86 = 2
          end
          pw = mathMax(0.25, __lux_tmp_width_86)
        end
        ox = patternOffset(pattern)
      end
      local __lux_tmp_87
      if smoke then
        __lux_tmp_87 = toNumber(pattern.seed)
        if __lux_tmp_87 == nil then
          __lux_tmp_87 = 0
        end
      else
        __lux_tmp_87 = 0
      end
      local __lux_tmp_radius_88 = toNumber(radius)
      if __lux_tmp_radius_88 == nil then
        __lux_tmp_radius_88 = 0
      end
      return setupParamMatrix(
        material,
        r,
        g,
        b,
        a,
        w,
        h,
        __lux_tmp_87,
        mathMax(0, __lux_tmp_radius_88),
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
      setupConstants(material, w, h, fill, nil, 0, style.radiusScalar(radius, w, h))
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h)
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
      local __lux_tmp_91 = color ~= nil
      if __lux_tmp_91 then
        local __lux_tmp_a_90 = color.a
        if __lux_tmp_a_90 == nil then
          __lux_tmp_a_90 = 255
        end
        __lux_tmp_91 = __lux_tmp_a_90 <= 0
      end
      if __lux_tmp_91 then
        return false
      end
      local material = roundRectMaterials.roundrect_pattern
      setupPatternConstants(material, w, h, style.radiusScalar(radius, w, h), spec)
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(x, y, w, h)
      return true
    end
    drawRoundRectInnerGlowSpec = function(x, y, w, h, radius, spec)
      local __lux_tmp_94 = spec == nil or spec.color == nil
      if not __lux_tmp_94 then
        local __lux_tmp_a_93 = spec.color.a
        if __lux_tmp_a_93 == nil then
          __lux_tmp_a_93 = 255
        end
        __lux_tmp_94 = __lux_tmp_a_93 <= 0
      end
      local __lux_tmp_95 = __lux_tmp_94
      if not __lux_tmp_95 then
        __lux_tmp_95 = not shadersActive()
      end
      local __lux_tmp_96 = __lux_tmp_95
      if not __lux_tmp_96 then
        __lux_tmp_96 = not materialOK(roundRectMaterials.roundrect_innerglow)
      end
      if __lux_tmp_96 then
        return false
      end
      local material = roundRectMaterials.roundrect_innerglow
      local r, g, b, a = style.color01(spec.color)
      do
        local __lux_tmp_width_97 = toNumber(spec.width)
        if __lux_tmp_width_97 == nil then
          __lux_tmp_width_97 = 8
        end
        local __lux_tmp_strength_98 = toNumber(spec.strength)
        if __lux_tmp_strength_98 == nil then
          __lux_tmp_strength_98 = 1
        end
        local __lux_tmp_falloff_99 = toNumber(spec.falloff)
        if __lux_tmp_falloff_99 == nil then
          __lux_tmp_falloff_99 = 1.65
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
          style.radiusScalar(radius, w, h),
          mathMax(0.001, __lux_tmp_width_97),
          mathMax(0, __lux_tmp_strength_98),
          mathMax(0.001, __lux_tmp_falloff_99),
          0,
          0,
          0,
          0,
          0
        )
      end
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(x, y, w, h)
      return true
    end
    drawRoundRectOuterGlowSpec = function(x, y, w, h, radius, spec)
      local __lux_tmp_102 = spec == nil or spec.color == nil
      if not __lux_tmp_102 then
        local __lux_tmp_a_101 = spec.color.a
        if __lux_tmp_a_101 == nil then
          __lux_tmp_a_101 = 255
        end
        __lux_tmp_102 = __lux_tmp_a_101 <= 0
      end
      local __lux_tmp_103 = __lux_tmp_102
      if not __lux_tmp_103 then
        __lux_tmp_103 = not shadersActive()
      end
      local __lux_tmp_104 = __lux_tmp_103
      if not __lux_tmp_104 then
        __lux_tmp_104 = not materialOK(roundRectMaterials.roundrect_outerglow)
      end
      if __lux_tmp_104 then
        return false
      end
      local spread
      do
        local __lux_tmp_spread_105 = spec.spread
        if __lux_tmp_spread_105 == nil then
          __lux_tmp_spread_105 = spec.width
        end
        local __lux_tmp_spread_106 = toNumber(__lux_tmp_spread_105)
        if __lux_tmp_spread_106 == nil then
          __lux_tmp_spread_106 = 18
        end
        spread = mathMax(1, __lux_tmp_spread_106)
      end
      local sw = w + spread * 2
      local sh = h + spread * 2
      local material = roundRectMaterials.roundrect_outerglow
      local r, g, b, a = style.color01(spec.color)
      do
        local __lux_tmp_width_107 = toNumber(spec.width)
        if __lux_tmp_width_107 == nil then
          __lux_tmp_width_107 = spread
        end
        local __lux_tmp_strength_108 = toNumber(spec.strength)
        if __lux_tmp_strength_108 == nil then
          __lux_tmp_strength_108 = 1
        end
        local __lux_tmp_falloff_109 = toNumber(spec.falloff)
        if __lux_tmp_falloff_109 == nil then
          __lux_tmp_falloff_109 = 1.9
        end
        setupParamMatrix(
          material,
          r,
          g,
          b,
          a,
          sw,
          sh,
          0,
          0,
          spread,
          spread,
          w,
          h,
          style.radiusScalar(radius, w, h),
          mathMax(0.001, __lux_tmp_width_107),
          mathMax(0, __lux_tmp_strength_108),
          mathMax(0.001, __lux_tmp_falloff_109)
        )
      end
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(x - spread, y - spread, sw, sh)
      return true
    end
    backdropTintColor = function(spec)
      if spec == nil or spec.tint == nil then
        return nil
      end
      local tint = spec.tint
      local alpha
      do
        local __lux_tmp_a_110 = tint.a
        if __lux_tmp_a_110 == nil then
          __lux_tmp_a_110 = 255
        end
        local __lux_tmp_opacity_111 = spec.opacity
        if __lux_tmp_opacity_111 == nil then
          __lux_tmp_opacity_111 = 1
        end
        alpha = __lux_tmp_a_110 * __lux_tmp_opacity_111
      end
      if alpha <= 0 then
        return nil
      end
      local __lux_tmp_r_112 = tint.r
      if __lux_tmp_r_112 == nil then
        __lux_tmp_r_112 = 0
      end
      local __lux_tmp_g_113 = tint.g
      if __lux_tmp_g_113 == nil then
        __lux_tmp_g_113 = 0
      end
      local __lux_tmp_b_114 = tint.b
      if __lux_tmp_b_114 == nil then
        __lux_tmp_b_114 = 0
      end
      return makeColor(
        __lux_tmp_r_112,
        __lux_tmp_g_113,
        __lux_tmp_b_114,
        mathFloor(mathClamp(alpha, 0, 255) + 0.5)
      )
    end
    drawRoundRectBackdrop = function(x, y, w, h, radius, backdrop)
      local spec = style.backdropStyle(backdrop)
      if spec == nil then
        return nil
      end
      if spec.blur > 0 and roundRectBlurRT ~= nil and renderCopyRenderTargetToTexture ~= nil and materialOK(roundRectMaterials.roundrect_blur) then
        local material = roundRectMaterials.roundrect_blur
        surfaceSetMaterial(material)
        surfaceSetDrawColor(255, 255, 255, 255)
        renderCopyRenderTargetToTexture(roundRectBlurRT)
        setupParamMatrix(
          material,
          0,
          spec.blur,
          0,
          0,
          w,
          h,
          0,
          style.radiusScalar(radius, w, h),
          0,
          0,
          1,
          0,
          0,
          0,
          0,
          0
        )
        drawTexturedQuad(x, y, w, h)
        renderCopyRenderTargetToTexture(roundRectBlurRT)
        setupParamMatrix(
          material,
          1,
          spec.blur,
          0,
          0,
          w,
          h,
          0,
          style.radiusScalar(radius, w, h),
          0,
          0,
          1,
          0,
          0,
          0,
          0,
          0
        )
        drawTexturedQuad(x, y, w, h)
      end
      local tint = backdropTintColor(spec)
      if tint ~= nil then
        drawRoundRectFillPass(x, y, w, h, radius, style.solid(tint))
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
          style.radiusScalar(radius, w, h),
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
        drawTexturedQuad(x, y, w, h)
        return true
      end
      return drawRoundRectFillPass(x, y, w, h, radius, style.solid(transparentColor))
    end
    drawRoundRectFxPass = function(x, y, w, h, radius, fill, stroke, strokeWidth, innerSpec)
      if not materialOK(roundRectMaterials.roundrect_fx) then
        return false
      end
      local material = roundRectMaterials.roundrect_fx
      local gr = 0
      local gg = 0
      local gb = 0
      local ga = 0
      local glowWidth = 0
      local glowStrength = 0
      local glowFalloff = 1
      if innerSpec ~= nil then
        do
          local __lux_tmp_color_115 = innerSpec.color
          if __lux_tmp_color_115 == nil then
            __lux_tmp_color_115 = transparentColor
          end
          gr, gg, gb, ga = style.color01(__lux_tmp_color_115)
        end
        do
          local __lux_tmp_width_116 = toNumber(innerSpec.width)
          if __lux_tmp_width_116 == nil then
            __lux_tmp_width_116 = 8
          end
          glowWidth = mathMax(0.001, __lux_tmp_width_116)
        end
        do
          local __lux_tmp_strength_117 = toNumber(innerSpec.strength)
          if __lux_tmp_strength_117 == nil then
            __lux_tmp_strength_117 = 1
          end
          glowStrength = mathMax(0, __lux_tmp_strength_117)
        end
        do
          local __lux_tmp_falloff_118 = toNumber(innerSpec.falloff)
          if __lux_tmp_falloff_118 == nil then
            __lux_tmp_falloff_118 = 1.65
          end
          glowFalloff = mathMax(0.001, __lux_tmp_falloff_118)
        end
      end
      setupAuxConstants(
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
      )
      setupConstants(
        material,
        w,
        h,
        fill,
        stroke,
        strokeWidth,
        style.radiusScalar(radius, w, h)
      )
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h)
      return true
    end
    drawRoundRectShader = function(x, y, w, h, drawStyle)
      if not shadersActive() then
        return false
      end
      local radius = drawStyle.radius
      if radius == nil then
        radius = drawStyle.r
        if radius == nil then
          radius = 0
        end
      end
      local outer = outerGlowStyle(drawStyle.outerGlow)
      if outer ~= nil then
        drawRoundRectOuterGlowSpec(x, y, w, h, radius, outer)
      end
      local __lux_tmp_121 = drawStyle.shadow ~= nil and drawStyle.shadow.color ~= nil
      if __lux_tmp_121 then
        local __lux_tmp_a_120 = drawStyle.shadow.color.a
        if __lux_tmp_a_120 == nil then
          __lux_tmp_a_120 = 255
        end
        __lux_tmp_121 = __lux_tmp_a_120 > 0
      end
      if __lux_tmp_121 then
        local shadow = drawStyle.shadow
        local spread
        do
          local __lux_tmp_blur_122 = toNumber(shadow.blur)
          if __lux_tmp_blur_122 == nil then
            __lux_tmp_blur_122 = 12
          end
          spread = mathMax(1, __lux_tmp_blur_122)
        end
        do
          local __lux_tmp_x_123 = shadow.x
          if __lux_tmp_x_123 == nil then
            __lux_tmp_x_123 = 0
          end
          local __lux_tmp_y_124 = shadow.y
          if __lux_tmp_y_124 == nil then
            __lux_tmp_y_124 = 0
          end
          drawRoundRectFillPass(
            x + __lux_tmp_x_123 - spread,
            y + __lux_tmp_y_124 - spread,
            w + spread * 2,
            h + spread * 2,
            radius + spread,
            style.solid(shadow.color)
          )
        end
      end
      local backdrop = nil
      if drawStyle.backdrop ~= nil then
        backdrop = drawRoundRectBackdrop(x, y, w, h, radius, drawStyle.backdrop)
      end
      local fill
      do
        local __lux_tmp_fill_125 = drawStyle.fill
        if __lux_tmp_fill_125 == nil then
          __lux_tmp_fill_125 = drawStyle.color
        end
        fill = style.fillFromStyle(__lux_tmp_fill_125)
      end
      local strokeWidth = style.strokeWidth(drawStyle.strokeWidth, 0)
      local hasFill = style.fillVisible(fill)
      local hasStroke = style.strokeVisible(drawStyle.stroke, strokeWidth)
      local inner = innerGlowStyle(drawStyle.innerGlow)
      if backdrop == nil and not hasFill and not hasStroke and drawStyle.pattern == nil and inner == nil then
        return true
      end
      if drawStyle.pattern ~= nil then
        if hasFill then
          drawRoundRectFillPass(x, y, w, h, radius, fill)
        end
        drawRoundRectPattern(x, y, w, h, radius, drawStyle.pattern)
        if hasStroke then
          drawRoundRectStrokePass(x, y, w, h, radius, drawStyle.stroke, strokeWidth)
        end
      else
        if (hasStroke or inner ~= nil) and drawRoundRectFxPass(x, y, w, h, radius, fill, drawStyle.stroke, strokeWidth, inner) then
          inner = nil
        else
          if hasFill then
            drawRoundRectFillPass(x, y, w, h, radius, fill)
            if hasStroke then
              drawRoundRectStrokePass(x, y, w, h, radius, drawStyle.stroke, strokeWidth)
            end
          else
            if hasStroke then
              drawRoundRectStrokePass(x, y, w, h, radius, drawStyle.stroke, strokeWidth)
            end
          end
        end
      end
      if inner ~= nil then
        drawRoundRectInnerGlowSpec(x, y, w, h, radius, inner)
      end
      return true
    end
  end
  do
    drawRoundRectImmediate = function(x, y, w, h, drawStyle)
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      if drawRoundRectShader(x, y, w, h, resolved) then
        return
      end
      local radius
      do
        local __lux_tmp_radius_126 = resolved.radius
        if __lux_tmp_radius_126 == nil then
          __lux_tmp_radius_126 = resolved.r
        end
        if __lux_tmp_radius_126 == nil then
          __lux_tmp_radius_126 = 0
        end
        radius = style.radiusScalar(__lux_tmp_radius_126, w, h)
      end
      local fill
      do
        local __lux_tmp_fill_127 = resolved.fill
        if __lux_tmp_fill_127 == nil then
          __lux_tmp_fill_127 = resolved.color
        end
        fill = style.fillFromStyle(__lux_tmp_fill_127)
      end
      local fillVisible = style.fillVisible(fill)
      local strokeWidth = style.strokeWidth(resolved.strokeWidth, 0)
      local strokeVisible = style.strokeVisible(resolved.stroke, strokeWidth)
      local outer = outerGlowStyle(resolved.outerGlow)
      if outer ~= nil and outer.color ~= nil then
        local outerAlpha = style.alpha(outer.color.a)
        if outerAlpha > 0 then
          local spread
          do
            local __lux_tmp_spread_128 = outer.spread
            if __lux_tmp_spread_128 == nil then
              __lux_tmp_spread_128 = outer.width
            end
            local __lux_tmp_spread_129 = toNumber(__lux_tmp_spread_128)
            if __lux_tmp_spread_129 == nil then
              __lux_tmp_spread_129 = 18
            end
            spread = mathMax(1, __lux_tmp_spread_129)
          end
          local glow = style.withAlpha(outer.color, mathFloor(outerAlpha * 0.35))
          if hasTransform() then
            local points = fallbackRoundRectPoints(
              x - spread,
              y - spread,
              w + spread * 2,
              h + spread * 2,
              radius + spread
            )
            setColor(glow)
            drawTransformedPoly(points)
          else
            drawRoundedBox(
              mathFloor(radius + spread),
              x - spread,
              y - spread,
              w + spread * 2,
              h + spread * 2,
              glow
            )
            recordDraws()
          end
        end
      end
      if hasTransform() then
        local points = fallbackRoundRectPoints(x, y, w, h, radius)
        if fillVisible then
          setColor(fillColor(fill))
          drawTransformedPoly(points)
        end
        if strokeVisible then
          drawFallbackStroke(points, resolved.stroke, mathMax(1, mathFloor(strokeWidth)))
        end
        return
      end
      if fillVisible then
        if radius <= 0.25 then
          setColor(fillColor(fill))
          surfaceDrawRect(x, y, w, h)
          recordDraws()
        else
          drawRoundedBox(mathFloor(radius), x, y, w, h, fillColor(fill))
          recordDraws()
        end
      end
      if strokeVisible then
        setColor(resolved.stroke)
        surfaceDrawOutlinedRect(x, y, w, h, mathMax(1, mathFloor(strokeWidth)))
        recordDraws()
      end
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
        return drawRoundRectImmediate(x, y, w, h, stripped)
      end
      return withTransform(
        transform,
        x,
        y,
        w,
        h,
        function()
          return drawRoundRectImmediate(x, y, w, h, stripped)
        end
      )
    end
    roundedBox = function(x, y, w, h, radius, fill, stroke, strokeWidth)
      roundedBoxStyle.radius = radius
      roundedBoxStyle.fill = fill
      roundedBoxStyle.stroke = stroke
      roundedBoxStyle.strokeWidth = strokeWidth
      return drawRoundRectImmediate(x, y, w, h, roundedBoxStyle)
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
        local __lux_tmp_drawStyle_130 = drawStyle
        if __lux_tmp_drawStyle_130 == nil then
          __lux_tmp_drawStyle_130 = {}
        end
        resolved = copyInto(circleStyle, __lux_tmp_drawStyle_130)
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
          local __lux_tmp_drawStyle_131 = drawStyle
          if __lux_tmp_drawStyle_131 == nil then
            __lux_tmp_drawStyle_131 = {}
          end
          resolved = copyInto(capsuleStyle, __lux_tmp_drawStyle_131)
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
        patternStyle = patternStyle,
        patternOffset = patternOffset,
      }
      return owner
    end
  end
  
  __lux_exports.fallbackRoundRectPoints = fallbackRoundRectPoints
  __lux_exports.innerGlowStyle = innerGlowStyle
  __lux_exports.outerGlowStyle = outerGlowStyle
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
