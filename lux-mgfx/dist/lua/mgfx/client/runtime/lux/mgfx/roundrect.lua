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
  local effectOffset
  local outerGlowStyle
  local shadowStyle
  local patternStyle
  local patternOffset
  local roundRectFillParams
  local setupParamMatrix
  local setupAuxConstants
  local setupConstants
  local setupPatternConstants
  local drawRoundRectFillPass
  local drawRoundRectPattern
  local radiusWithGrow
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
    outerGlowStyle = function(glow)
      if glow == nil or glow == false then
        return nil
      end
      if glow == true then
        return {
          color = makeColor(76, 190, 255, 88),
          x = 0,
          y = 0,
          width = 18,
          spread = 18,
          grow = 0,
          strength = 1,
          falloff = style.glowSoftnessToFalloff(0.54),
        }
      end
      if style.isColor(glow) then
        return {
          color = glow,
          x = 0,
          y = 0,
          width = 18,
          spread = 18,
          grow = 0,
          strength = 1,
          falloff = style.glowSoftnessToFalloff(0.54),
        }
      end
      if typeOf(glow) ~= "table" then
        return nil
      end
      local x, y = effectOffset(glow, 0, 0)
      local width
      do
        local __lux_tmp_size_23 = glow.size
        if __lux_tmp_size_23 == nil then
          __lux_tmp_size_23 = glow.width
        end
        if __lux_tmp_size_23 == nil then
          __lux_tmp_size_23 = glow.blur
        end
        if __lux_tmp_size_23 == nil then
          __lux_tmp_size_23 = glow.radius
        end
        if __lux_tmp_size_23 == nil then
          __lux_tmp_size_23 = glow.spread
        end
        local __lux_tmp_size_24 = toNumber(__lux_tmp_size_23)
        if __lux_tmp_size_24 == nil then
          __lux_tmp_size_24 = 18
        end
        width = mathMax(1, __lux_tmp_size_24)
      end
      local __lux_tmp_color_25 = glow.color
      if __lux_tmp_color_25 == nil then
        __lux_tmp_color_25 = glow.tint
      end
      local __lux_tmp_spread_26 = toNumber(glow.spread)
      if __lux_tmp_spread_26 == nil then
        __lux_tmp_spread_26 = width
      end
      local __lux_tmp_grow_27 = glow.grow
      if __lux_tmp_grow_27 == nil then
        __lux_tmp_grow_27 = glow.expand
      end
      if __lux_tmp_grow_27 == nil then
        __lux_tmp_grow_27 = glow.shapeSpread
      end
      local __lux_tmp_grow_28 = toNumber(__lux_tmp_grow_27)
      if __lux_tmp_grow_28 == nil then
        __lux_tmp_grow_28 = 0
      end
      local __lux_tmp_opacity_29 = glow.opacity
      if __lux_tmp_opacity_29 == nil then
        __lux_tmp_opacity_29 = glow.strength
      end
      local __lux_tmp_opacity_30 = toNumber(__lux_tmp_opacity_29)
      if __lux_tmp_opacity_30 == nil then
        __lux_tmp_opacity_30 = 1
      end
      local __lux_tmp_falloff_31 = toNumber(glow.falloff)
      if __lux_tmp_falloff_31 == nil then
        __lux_tmp_falloff_31 = style.glowSoftnessToFalloff(glow.softness, 0.54)
      end
      return {
        color = style.asColor(__lux_tmp_color_25, makeColor(76, 190, 255, 88)),
        x = x,
        y = y,
        width = width,
        spread = mathMax(1, __lux_tmp_spread_26),
        grow = mathMax(0, __lux_tmp_grow_28),
        strength = __lux_tmp_opacity_30,
        falloff = __lux_tmp_falloff_31,
      }
    end
    shadowStyle = function(shadow)
      if shadow == nil or shadow == false then
        return nil
      end
      if shadow == true then
        return {
          color = makeColor(0, 0, 0, 132),
          x = 0,
          y = 4,
          width = 12,
          spread = 12,
          grow = 0,
          strength = 1,
          falloff = style.glowSoftnessToFalloff(0.62),
        }
      end
      if style.isColor(shadow) then
        return {
          color = shadow,
          x = 0,
          y = 4,
          width = 12,
          spread = 12,
          grow = 0,
          strength = 1,
          falloff = style.glowSoftnessToFalloff(0.62),
        }
      end
      if typeOf(shadow) ~= "table" then
        local blur
        do
          local __lux_tmp_shadow_32 = toNumber(shadow)
          if __lux_tmp_shadow_32 == nil then
            __lux_tmp_shadow_32 = 12
          end
          blur = mathMax(0.001, __lux_tmp_shadow_32)
        end
        return {
          color = makeColor(0, 0, 0, 132),
          x = 0,
          y = 4,
          width = blur,
          spread = mathMax(1, blur),
          grow = 0,
          strength = 1,
          falloff = style.glowSoftnessToFalloff(0.62),
        }
      end
      local x, y = effectOffset(shadow, 0, 4)
      local blur
      do
        local __lux_tmp_blur_33 = shadow.blur
        if __lux_tmp_blur_33 == nil then
          __lux_tmp_blur_33 = shadow.radius
        end
        if __lux_tmp_blur_33 == nil then
          __lux_tmp_blur_33 = shadow.size
        end
        if __lux_tmp_blur_33 == nil then
          __lux_tmp_blur_33 = shadow.width
        end
        local __lux_tmp_blur_34 = toNumber(__lux_tmp_blur_33)
        if __lux_tmp_blur_34 == nil then
          __lux_tmp_blur_34 = 12
        end
        blur = mathMax(0.001, __lux_tmp_blur_34)
      end
      local grow
      do
        local __lux_tmp_spread_35 = shadow.spread
        if __lux_tmp_spread_35 == nil then
          __lux_tmp_spread_35 = shadow.grow
        end
        if __lux_tmp_spread_35 == nil then
          __lux_tmp_spread_35 = shadow.expand
        end
        if __lux_tmp_spread_35 == nil then
          __lux_tmp_spread_35 = shadow.shapeSpread
        end
        local __lux_tmp_spread_36 = toNumber(__lux_tmp_spread_35)
        if __lux_tmp_spread_36 == nil then
          __lux_tmp_spread_36 = 0
        end
        grow = mathMax(0, __lux_tmp_spread_36)
      end
      local __lux_tmp_color_37 = shadow.color
      if __lux_tmp_color_37 == nil then
        __lux_tmp_color_37 = shadow.tint
      end
      local __lux_tmp_extent_38 = shadow.extent
      if __lux_tmp_extent_38 == nil then
        __lux_tmp_extent_38 = shadow.padding
      end
      local __lux_tmp_extent_39 = toNumber(__lux_tmp_extent_38)
      if __lux_tmp_extent_39 == nil then
        __lux_tmp_extent_39 = blur
      end
      local __lux_tmp_opacity_40 = shadow.opacity
      if __lux_tmp_opacity_40 == nil then
        __lux_tmp_opacity_40 = shadow.strength
      end
      local __lux_tmp_opacity_41 = toNumber(__lux_tmp_opacity_40)
      if __lux_tmp_opacity_41 == nil then
        __lux_tmp_opacity_41 = 1
      end
      local __lux_tmp_falloff_42 = toNumber(shadow.falloff)
      if __lux_tmp_falloff_42 == nil then
        __lux_tmp_falloff_42 = style.glowSoftnessToFalloff(shadow.softness, 0.62)
      end
      return {
        color = style.asColor(__lux_tmp_color_37, makeColor(0, 0, 0, 132)),
        x = x,
        y = y,
        width = blur,
        spread = mathMax(1, __lux_tmp_extent_39),
        grow = grow,
        strength = __lux_tmp_opacity_41,
        falloff = __lux_tmp_falloff_42,
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
        local __lux_match_43 = pattern.kind
        if __lux_match_43 == "stripe" or __lux_match_43 == "smoke" then
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
        local __lux_obj_pattern_44 = pattern
        local __lux_val_offset_45 = nil
        if __lux_obj_pattern_44 ~= nil then
          __lux_val_offset_45 = __lux_obj_pattern_44.offset
        end
        offset = toNumber(__lux_val_offset_45)
        if offset == nil then
          offset = 0
        end
      end
      local speed
      do
        local __lux_obj_pattern_46 = pattern
        local __lux_val_speed_47 = nil
        if __lux_obj_pattern_46 ~= nil then
          __lux_val_speed_47 = __lux_obj_pattern_46.speed
        end
        speed = toNumber(__lux_val_speed_47)
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
      local __lux_match_48 = fill
      local __lux_tag_49
      if __lux_match_48 ~= nil then
        __lux_tag_49 = __lux_match_48.kind
      end
      if __lux_tag_49 == style.FILL_LINEAR then
        local x1 = __lux_match_48.x1
        local y1 = __lux_match_48.y1
        local x2 = __lux_match_48.x2
        local y2 = __lux_match_48.y2
        do
          local __lux_tmp_x1_50 = x1
          if __lux_tmp_x1_50 == nil then
            __lux_tmp_x1_50 = 0
          end
          p0 = __lux_tmp_x1_50
        end
        do
          local __lux_tmp_y1_51 = y1
          if __lux_tmp_y1_51 == nil then
            __lux_tmp_y1_51 = 0
          end
          p1 = __lux_tmp_y1_51
        end
        do
          local __lux_tmp_x2_52 = x2
          if __lux_tmp_x2_52 == nil then
            __lux_tmp_x2_52 = 1
          end
          p2 = __lux_tmp_x2_52
        end
        do
          local __lux_tmp_y2_53 = y2
          if __lux_tmp_y2_53 == nil then
            __lux_tmp_y2_53 = 1
          end
          p3 = __lux_tmp_y2_53
        end
        style.bindGradientLut(material, fill)
      elseif __lux_tag_49 == style.FILL_RADIAL then
        local cx = __lux_match_48.cx
        local cy = __lux_match_48.cy
        local radius = __lux_match_48.radius
        do
          local __lux_tmp_cx_54 = cx
          if __lux_tmp_cx_54 == nil then
            __lux_tmp_cx_54 = 0.5
          end
          p0 = __lux_tmp_cx_54
        end
        do
          local __lux_tmp_cy_55 = cy
          if __lux_tmp_cy_55 == nil then
            __lux_tmp_cy_55 = 0.5
          end
          p1 = __lux_tmp_cy_55
        end
        do
          local __lux_tmp_radius_56 = radius
          if __lux_tmp_radius_56 == nil then
            __lux_tmp_radius_56 = 0.5
          end
          p2 = __lux_tmp_radius_56
        end
        p3 = 0
        style.bindGradientLut(material, fill)
      elseif __lux_tag_49 == style.FILL_CONIC then
        local cx = __lux_match_48.cx
        local cy = __lux_match_48.cy
        local rotation = __lux_match_48.rotation
        do
          local __lux_tmp_cx_57 = cx
          if __lux_tmp_cx_57 == nil then
            __lux_tmp_cx_57 = 0.5
          end
          p0 = __lux_tmp_cx_57
        end
        do
          local __lux_tmp_cy_58 = cy
          if __lux_tmp_cy_58 == nil then
            __lux_tmp_cy_58 = 0.5
          end
          p1 = __lux_tmp_cy_58
        end
        p2 = style.normalizedRotation(rotation)
        p3 = 0
        style.bindGradientLut(material, fill)
      else
        local __lux_unused_59 = nil
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
        local __lux_tmp_a0_60 = a0
        if __lux_tmp_a0_60 == nil then
          __lux_tmp_a0_60 = 0
        end
        local __lux_tmp_b0_61 = b0
        if __lux_tmp_b0_61 == nil then
          __lux_tmp_b0_61 = 0
        end
        local __lux_tmp_c0_62 = c0
        if __lux_tmp_c0_62 == nil then
          __lux_tmp_c0_62 = 0
        end
        local __lux_tmp_d0_63 = d0
        if __lux_tmp_d0_63 == nil then
          __lux_tmp_d0_63 = 0
        end
        local __lux_tmp_a1_64 = a1
        if __lux_tmp_a1_64 == nil then
          __lux_tmp_a1_64 = 0
        end
        local __lux_tmp_b1_65 = b1
        if __lux_tmp_b1_65 == nil then
          __lux_tmp_b1_65 = 0
        end
        local __lux_tmp_c1_66 = c1
        if __lux_tmp_c1_66 == nil then
          __lux_tmp_c1_66 = 0
        end
        local __lux_tmp_d1_67 = d1
        if __lux_tmp_d1_67 == nil then
          __lux_tmp_d1_67 = 0
        end
        local __lux_tmp_a2_68 = a2
        if __lux_tmp_a2_68 == nil then
          __lux_tmp_a2_68 = 0
        end
        local __lux_tmp_b2_69 = b2
        if __lux_tmp_b2_69 == nil then
          __lux_tmp_b2_69 = 0
        end
        local __lux_tmp_c2_70 = c2
        if __lux_tmp_c2_70 == nil then
          __lux_tmp_c2_70 = 0
        end
        local __lux_tmp_d2_71 = d2
        if __lux_tmp_d2_71 == nil then
          __lux_tmp_d2_71 = 0
        end
        local __lux_tmp_a3_72 = a3
        if __lux_tmp_a3_72 == nil then
          __lux_tmp_a3_72 = 0
        end
        local __lux_tmp_b3_73 = b3
        if __lux_tmp_b3_73 == nil then
          __lux_tmp_b3_73 = 0
        end
        local __lux_tmp_c3_74 = c3
        if __lux_tmp_c3_74 == nil then
          __lux_tmp_c3_74 = 0
        end
        local __lux_tmp_d3_75 = d3
        if __lux_tmp_d3_75 == nil then
          __lux_tmp_d3_75 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_a0_60,
          __lux_tmp_b0_61,
          __lux_tmp_c0_62,
          __lux_tmp_d0_63,
          __lux_tmp_a1_64,
          __lux_tmp_b1_65,
          __lux_tmp_c1_66,
          __lux_tmp_d1_67,
          __lux_tmp_a2_68,
          __lux_tmp_b2_69,
          __lux_tmp_c2_70,
          __lux_tmp_d2_71,
          __lux_tmp_a3_72,
          __lux_tmp_b3_73,
          __lux_tmp_c3_74,
          __lux_tmp_d3_75
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
        local __lux_tmp_a0_76 = a0
        if __lux_tmp_a0_76 == nil then
          __lux_tmp_a0_76 = 0
        end
        material:SetFloat("$c0_x", __lux_tmp_a0_76)
      end
      do
        local __lux_tmp_a1_77 = a1
        if __lux_tmp_a1_77 == nil then
          __lux_tmp_a1_77 = 0
        end
        material:SetFloat("$c0_y", __lux_tmp_a1_77)
      end
      do
        local __lux_tmp_a2_78 = a2
        if __lux_tmp_a2_78 == nil then
          __lux_tmp_a2_78 = 0
        end
        material:SetFloat("$c0_z", __lux_tmp_a2_78)
      end
      do
        local __lux_tmp_a3_79 = a3
        if __lux_tmp_a3_79 == nil then
          __lux_tmp_a3_79 = 0
        end
        material:SetFloat("$c0_w", __lux_tmp_a3_79)
      end
      do
        local __lux_tmp_b0_80 = b0
        if __lux_tmp_b0_80 == nil then
          __lux_tmp_b0_80 = 0
        end
        material:SetFloat("$c1_x", __lux_tmp_b0_80)
      end
      do
        local __lux_tmp_b1_81 = b1
        if __lux_tmp_b1_81 == nil then
          __lux_tmp_b1_81 = 0
        end
        material:SetFloat("$c1_y", __lux_tmp_b1_81)
      end
      do
        local __lux_tmp_b2_82 = b2
        if __lux_tmp_b2_82 == nil then
          __lux_tmp_b2_82 = 0
        end
        material:SetFloat("$c1_z", __lux_tmp_b2_82)
      end
      do
        local __lux_tmp_b3_83 = b3
        if __lux_tmp_b3_83 == nil then
          __lux_tmp_b3_83 = 0
        end
        material:SetFloat("$c1_w", __lux_tmp_b3_83)
      end
      do
        local __lux_tmp_c0_84 = c0
        if __lux_tmp_c0_84 == nil then
          __lux_tmp_c0_84 = 0
        end
        material:SetFloat("$c2_x", __lux_tmp_c0_84)
      end
      do
        local __lux_tmp_c1_85 = c1
        if __lux_tmp_c1_85 == nil then
          __lux_tmp_c1_85 = 0
        end
        material:SetFloat("$c2_y", __lux_tmp_c1_85)
      end
      do
        local __lux_tmp_c2_86 = c2
        if __lux_tmp_c2_86 == nil then
          __lux_tmp_c2_86 = 0
        end
        material:SetFloat("$c2_z", __lux_tmp_c2_86)
      end
      do
        local __lux_tmp_c3_87 = c3
        if __lux_tmp_c3_87 == nil then
          __lux_tmp_c3_87 = 0
        end
        material:SetFloat("$c2_w", __lux_tmp_c3_87)
      end
      do
        local __lux_tmp_d0_88 = d0
        if __lux_tmp_d0_88 == nil then
          __lux_tmp_d0_88 = 0
        end
        material:SetFloat("$c3_x", __lux_tmp_d0_88)
      end
      do
        local __lux_tmp_d1_89 = d1
        if __lux_tmp_d1_89 == nil then
          __lux_tmp_d1_89 = 0
        end
        material:SetFloat("$c3_y", __lux_tmp_d1_89)
      end
      do
        local __lux_tmp_d2_90 = d2
        if __lux_tmp_d2_90 == nil then
          __lux_tmp_d2_90 = 0
        end
        material:SetFloat("$c3_z", __lux_tmp_d2_90)
      end
      do
        local __lux_tmp_d3_91 = d3
        if __lux_tmp_d3_91 == nil then
          __lux_tmp_d3_91 = 0
        end
        material:SetFloat("$c3_w", __lux_tmp_d3_91)
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
        local __lux_tmp_radius_92 = toNumber(radius)
        if __lux_tmp_radius_92 == nil then
          __lux_tmp_radius_92 = 0
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
          mathMax(0, __lux_tmp_radius_92),
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
        local __lux_tmp_color_93 = pattern.color
        if __lux_tmp_color_93 == nil then
          __lux_tmp_color_93 = pattern.tint
        end
        color = style.asColor(__lux_tmp_color_93, makeColor(255, 255, 255, 24))
      end
      local r, g, b, a = style.color01(color)
      local angle
      do
        local __lux_tmp_angle_94 = toNumber(pattern.angle)
        if __lux_tmp_angle_94 == nil then
          __lux_tmp_angle_94 = 135
        end
        angle = mathRad(__lux_tmp_angle_94)
      end
      local smoke
      local __lux_match_95 = pattern.kind
      if __lux_match_95 == "smoke" then
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
          local __lux_tmp_scale_96 = toNumber(pattern.scale)
          if __lux_tmp_scale_96 == nil then
            __lux_tmp_scale_96 = 140
          end
          pz = mathMax(1, __lux_tmp_scale_96)
        end
        do
          local __lux_tmp_density_97 = toNumber(pattern.density)
          if __lux_tmp_density_97 == nil then
            __lux_tmp_density_97 = 0.48
          end
          pw = mathClamp(__lux_tmp_density_97, 0, 1)
        end
        ox = patternOffset(pattern)
        oy = 1
        do
          local __lux_tmp_softness_98 = toNumber(pattern.softness)
          if __lux_tmp_softness_98 == nil then
            __lux_tmp_softness_98 = 0.3
          end
          oz = mathMax(0.001, __lux_tmp_softness_98)
        end
        do
          local __lux_tmp_warp_99 = toNumber(pattern.warp)
          if __lux_tmp_warp_99 == nil then
            __lux_tmp_warp_99 = 0.85
          end
          ow = mathMax(0, __lux_tmp_warp_99)
        end
      else
        do
          local __lux_tmp_spacing_100 = toNumber(pattern.spacing)
          if __lux_tmp_spacing_100 == nil then
            __lux_tmp_spacing_100 = 12
          end
          pz = mathMax(1, __lux_tmp_spacing_100)
        end
        do
          local __lux_tmp_width_101 = toNumber(pattern.width)
          if __lux_tmp_width_101 == nil then
            __lux_tmp_width_101 = 2
          end
          pw = mathMax(0.25, __lux_tmp_width_101)
        end
        ox = patternOffset(pattern)
      end
      local __lux_tmp_102
      if smoke then
        __lux_tmp_102 = toNumber(pattern.seed)
        if __lux_tmp_102 == nil then
          __lux_tmp_102 = 0
        end
      else
        __lux_tmp_102 = 0
      end
      local __lux_tmp_radius_103 = toNumber(radius)
      if __lux_tmp_radius_103 == nil then
        __lux_tmp_radius_103 = 0
      end
      return setupParamMatrix(
        material,
        r,
        g,
        b,
        a,
        w,
        h,
        __lux_tmp_102,
        mathMax(0, __lux_tmp_radius_103),
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
      local __lux_tmp_106 = color ~= nil
      if __lux_tmp_106 then
        local __lux_tmp_a_105 = color.a
        if __lux_tmp_a_105 == nil then
          __lux_tmp_a_105 = 255
        end
        __lux_tmp_106 = __lux_tmp_a_105 <= 0
      end
      if __lux_tmp_106 then
        return false
      end
      local material = roundRectMaterials.roundrect_pattern
      setupPatternConstants(material, w, h, style.radiusScalar(radius, w, h), spec)
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(x, y, w, h)
      return true
    end
    radiusWithGrow = function(radius, grow)
      do
        local __lux_tmp_grow_107 = toNumber(grow)
        if __lux_tmp_grow_107 == nil then
          __lux_tmp_grow_107 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_107)
      end
      if grow <= 0 then
        return radius
      end
      if typeOf(radius) == "table" and not style.isColor(radius) then
        local __lux_tmp_tl_108 = radius.tl
        if __lux_tmp_tl_108 == nil then
          __lux_tmp_tl_108 = radius[1]
        end
        local __lux_tmp_tl_109 = toNumber(__lux_tmp_tl_108)
        if __lux_tmp_tl_109 == nil then
          __lux_tmp_tl_109 = 0
        end
        local __lux_tmp_tr_110 = radius.tr
        if __lux_tmp_tr_110 == nil then
          __lux_tmp_tr_110 = radius[2]
        end
        if __lux_tmp_tr_110 == nil then
          __lux_tmp_tr_110 = radius.tl
        end
        if __lux_tmp_tr_110 == nil then
          __lux_tmp_tr_110 = radius[1]
        end
        local __lux_tmp_tr_111 = toNumber(__lux_tmp_tr_110)
        if __lux_tmp_tr_111 == nil then
          __lux_tmp_tr_111 = 0
        end
        local __lux_tmp_br_112 = radius.br
        if __lux_tmp_br_112 == nil then
          __lux_tmp_br_112 = radius[3]
        end
        if __lux_tmp_br_112 == nil then
          __lux_tmp_br_112 = radius.tr
        end
        if __lux_tmp_br_112 == nil then
          __lux_tmp_br_112 = radius[2]
        end
        if __lux_tmp_br_112 == nil then
          __lux_tmp_br_112 = radius.tl
        end
        if __lux_tmp_br_112 == nil then
          __lux_tmp_br_112 = radius[1]
        end
        local __lux_tmp_br_113 = toNumber(__lux_tmp_br_112)
        if __lux_tmp_br_113 == nil then
          __lux_tmp_br_113 = 0
        end
        local __lux_tmp_bl_114 = radius.bl
        if __lux_tmp_bl_114 == nil then
          __lux_tmp_bl_114 = radius[4]
        end
        if __lux_tmp_bl_114 == nil then
          __lux_tmp_bl_114 = radius.br
        end
        if __lux_tmp_bl_114 == nil then
          __lux_tmp_bl_114 = radius[3]
        end
        if __lux_tmp_bl_114 == nil then
          __lux_tmp_bl_114 = radius.tr
        end
        if __lux_tmp_bl_114 == nil then
          __lux_tmp_bl_114 = radius[2]
        end
        if __lux_tmp_bl_114 == nil then
          __lux_tmp_bl_114 = radius.tl
        end
        if __lux_tmp_bl_114 == nil then
          __lux_tmp_bl_114 = radius[1]
        end
        local __lux_tmp_bl_115 = toNumber(__lux_tmp_bl_114)
        if __lux_tmp_bl_115 == nil then
          __lux_tmp_bl_115 = 0
        end
        return {
          tl = mathMax(0, __lux_tmp_tl_109) + grow,
          tr = mathMax(0, __lux_tmp_tr_111) + grow,
          br = mathMax(0, __lux_tmp_br_113) + grow,
          bl = mathMax(0, __lux_tmp_bl_115) + grow,
        }
      end
      local __lux_tmp_radius_116 = toNumber(radius)
      if __lux_tmp_radius_116 == nil then
        __lux_tmp_radius_116 = 0
      end
      return __lux_tmp_radius_116 + grow
    end
    drawRoundRectInnerGlowSpec = function(x, y, w, h, radius, spec)
      local __lux_tmp_119 = spec == nil or spec.color == nil
      if not __lux_tmp_119 then
        local __lux_tmp_a_118 = spec.color.a
        if __lux_tmp_a_118 == nil then
          __lux_tmp_a_118 = 255
        end
        __lux_tmp_119 = __lux_tmp_a_118 <= 0
      end
      local __lux_tmp_120 = __lux_tmp_119
      if not __lux_tmp_120 then
        __lux_tmp_120 = not shadersActive()
      end
      local __lux_tmp_121 = __lux_tmp_120
      if not __lux_tmp_121 then
        __lux_tmp_121 = not materialOK(roundRectMaterials.roundrect_innerglow)
      end
      if __lux_tmp_121 then
        return false
      end
      local material = roundRectMaterials.roundrect_innerglow
      local r, g, b, a = style.color01(spec.color)
      do
        local __lux_tmp_width_122 = toNumber(spec.width)
        if __lux_tmp_width_122 == nil then
          __lux_tmp_width_122 = 8
        end
        local __lux_tmp_strength_123 = toNumber(spec.strength)
        if __lux_tmp_strength_123 == nil then
          __lux_tmp_strength_123 = 1
        end
        local __lux_tmp_falloff_124 = toNumber(spec.falloff)
        if __lux_tmp_falloff_124 == nil then
          __lux_tmp_falloff_124 = 1.65
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
          mathMax(0.001, __lux_tmp_width_122),
          mathMax(0, __lux_tmp_strength_123),
          mathMax(0.001, __lux_tmp_falloff_124),
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
      local __lux_tmp_127 = spec == nil or spec.color == nil
      if not __lux_tmp_127 then
        local __lux_tmp_a_126 = spec.color.a
        if __lux_tmp_a_126 == nil then
          __lux_tmp_a_126 = 255
        end
        __lux_tmp_127 = __lux_tmp_a_126 <= 0
      end
      local __lux_tmp_128 = __lux_tmp_127
      if not __lux_tmp_128 then
        __lux_tmp_128 = not shadersActive()
      end
      local __lux_tmp_129 = __lux_tmp_128
      if not __lux_tmp_129 then
        __lux_tmp_129 = not materialOK(roundRectMaterials.roundrect_outerglow)
      end
      if __lux_tmp_129 then
        return false
      end
      local grow
      do
        local __lux_tmp_grow_130 = spec.grow
        if __lux_tmp_grow_130 == nil then
          __lux_tmp_grow_130 = spec.shapeSpread
        end
        if __lux_tmp_grow_130 == nil then
          __lux_tmp_grow_130 = spec.expand
        end
        local __lux_tmp_grow_131 = toNumber(__lux_tmp_grow_130)
        if __lux_tmp_grow_131 == nil then
          __lux_tmp_grow_131 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_131)
      end
      local ox
      do
        local __lux_tmp_x_132 = spec.x
        if __lux_tmp_x_132 == nil then
          __lux_tmp_x_132 = spec.offsetX
        end
        if __lux_tmp_x_132 == nil then
          __lux_tmp_x_132 = spec.dx
        end
        ox = toNumber(__lux_tmp_x_132)
        if ox == nil then
          ox = 0
        end
      end
      local oy
      do
        local __lux_tmp_y_133 = spec.y
        if __lux_tmp_y_133 == nil then
          __lux_tmp_y_133 = spec.offsetY
        end
        if __lux_tmp_y_133 == nil then
          __lux_tmp_y_133 = spec.dy
        end
        oy = toNumber(__lux_tmp_y_133)
        if oy == nil then
          oy = 0
        end
      end
      local gx = x + ox - grow
      local gy = y + oy - grow
      local gw = w + grow * 2
      local gh = h + grow * 2
      local gr = radiusWithGrow(radius, grow)
      local spread
      do
        local __lux_tmp_spread_134 = spec.spread
        if __lux_tmp_spread_134 == nil then
          __lux_tmp_spread_134 = spec.width
        end
        local __lux_tmp_spread_135 = toNumber(__lux_tmp_spread_134)
        if __lux_tmp_spread_135 == nil then
          __lux_tmp_spread_135 = 18
        end
        spread = mathMax(1, __lux_tmp_spread_135)
      end
      local sw = gw + spread * 2
      local sh = gh + spread * 2
      local material = roundRectMaterials.roundrect_outerglow
      local r, g, b, a = style.color01(spec.color)
      do
        local __lux_tmp_width_136 = toNumber(spec.width)
        if __lux_tmp_width_136 == nil then
          __lux_tmp_width_136 = spread
        end
        local __lux_tmp_strength_137 = toNumber(spec.strength)
        if __lux_tmp_strength_137 == nil then
          __lux_tmp_strength_137 = 1
        end
        local __lux_tmp_falloff_138 = toNumber(spec.falloff)
        if __lux_tmp_falloff_138 == nil then
          __lux_tmp_falloff_138 = 1.9
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
          gw,
          gh,
          style.radiusScalar(gr, gw, gh),
          mathMax(0.001, __lux_tmp_width_136),
          mathMax(0, __lux_tmp_strength_137),
          mathMax(0.001, __lux_tmp_falloff_138)
        )
      end
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(gx - spread, gy - spread, sw, sh)
      return true
    end
    backdropTintColor = function(spec)
      if spec == nil or spec.tint == nil then
        return nil
      end
      local tint = spec.tint
      local alpha
      do
        local __lux_tmp_a_139 = tint.a
        if __lux_tmp_a_139 == nil then
          __lux_tmp_a_139 = 255
        end
        local __lux_tmp_opacity_140 = spec.opacity
        if __lux_tmp_opacity_140 == nil then
          __lux_tmp_opacity_140 = 1
        end
        alpha = __lux_tmp_a_139 * __lux_tmp_opacity_140
      end
      if alpha <= 0 then
        return nil
      end
      local __lux_tmp_r_141 = tint.r
      if __lux_tmp_r_141 == nil then
        __lux_tmp_r_141 = 0
      end
      local __lux_tmp_g_142 = tint.g
      if __lux_tmp_g_142 == nil then
        __lux_tmp_g_142 = 0
      end
      local __lux_tmp_b_143 = tint.b
      if __lux_tmp_b_143 == nil then
        __lux_tmp_b_143 = 0
      end
      return makeColor(
        __lux_tmp_r_141,
        __lux_tmp_g_142,
        __lux_tmp_b_143,
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
          local __lux_tmp_color_144 = innerSpec.color
          if __lux_tmp_color_144 == nil then
            __lux_tmp_color_144 = transparentColor
          end
          gr, gg, gb, ga = style.color01(__lux_tmp_color_144)
        end
        do
          local __lux_tmp_width_145 = toNumber(innerSpec.width)
          if __lux_tmp_width_145 == nil then
            __lux_tmp_width_145 = 8
          end
          glowWidth = mathMax(0.001, __lux_tmp_width_145)
        end
        do
          local __lux_tmp_strength_146 = toNumber(innerSpec.strength)
          if __lux_tmp_strength_146 == nil then
            __lux_tmp_strength_146 = 1
          end
          glowStrength = mathMax(0, __lux_tmp_strength_146)
        end
        do
          local __lux_tmp_falloff_147 = toNumber(innerSpec.falloff)
          if __lux_tmp_falloff_147 == nil then
            __lux_tmp_falloff_147 = 1.65
          end
          glowFalloff = mathMax(0.001, __lux_tmp_falloff_147)
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
      local shadow = shadowStyle(drawStyle.shadow)
      if shadow ~= nil then
        drawRoundRectOuterGlowSpec(x, y, w, h, radius, shadow)
      end
      local outer = outerGlowStyle(drawStyle.outerGlow)
      if outer ~= nil then
        drawRoundRectOuterGlowSpec(x, y, w, h, radius, outer)
      end
      local backdrop = nil
      if drawStyle.backdrop ~= nil then
        backdrop = drawRoundRectBackdrop(x, y, w, h, radius, drawStyle.backdrop)
      end
      local fill
      do
        local __lux_tmp_fill_148 = drawStyle.fill
        if __lux_tmp_fill_148 == nil then
          __lux_tmp_fill_148 = drawStyle.color
        end
        fill = style.fillFromStyle(__lux_tmp_fill_148)
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
        local __lux_tmp_radius_149 = resolved.radius
        if __lux_tmp_radius_149 == nil then
          __lux_tmp_radius_149 = resolved.r
        end
        if __lux_tmp_radius_149 == nil then
          __lux_tmp_radius_149 = 0
        end
        radius = style.radiusScalar(__lux_tmp_radius_149, w, h)
      end
      local fill
      do
        local __lux_tmp_fill_150 = resolved.fill
        if __lux_tmp_fill_150 == nil then
          __lux_tmp_fill_150 = resolved.color
        end
        fill = style.fillFromStyle(__lux_tmp_fill_150)
      end
      local fillVisible = style.fillVisible(fill)
      local strokeWidth = style.strokeWidth(resolved.strokeWidth, 0)
      local strokeVisible = style.strokeVisible(resolved.stroke, strokeWidth)
      local shadow = shadowStyle(resolved.shadow)
      if shadow ~= nil and shadow.color ~= nil then
        local shadowAlpha = style.alpha(shadow.color.a)
        if shadowAlpha > 0 then
          local spread
          do
            local __lux_tmp_spread_151 = shadow.spread
            if __lux_tmp_spread_151 == nil then
              __lux_tmp_spread_151 = shadow.width
            end
            local __lux_tmp_spread_152 = toNumber(__lux_tmp_spread_151)
            if __lux_tmp_spread_152 == nil then
              __lux_tmp_spread_152 = 12
            end
            spread = mathMax(1, __lux_tmp_spread_152)
          end
          local grow
          do
            local __lux_tmp_grow_153 = shadow.grow
            if __lux_tmp_grow_153 == nil then
              __lux_tmp_grow_153 = shadow.shapeSpread
            end
            if __lux_tmp_grow_153 == nil then
              __lux_tmp_grow_153 = shadow.expand
            end
            local __lux_tmp_grow_154 = toNumber(__lux_tmp_grow_153)
            if __lux_tmp_grow_154 == nil then
              __lux_tmp_grow_154 = 0
            end
            grow = mathMax(0, __lux_tmp_grow_154)
          end
          local ox
          do
            local __lux_tmp_x_155 = shadow.x
            if __lux_tmp_x_155 == nil then
              __lux_tmp_x_155 = shadow.offsetX
            end
            if __lux_tmp_x_155 == nil then
              __lux_tmp_x_155 = shadow.dx
            end
            ox = toNumber(__lux_tmp_x_155)
            if ox == nil then
              ox = 0
            end
          end
          local oy
          do
            local __lux_tmp_y_156 = shadow.y
            if __lux_tmp_y_156 == nil then
              __lux_tmp_y_156 = shadow.offsetY
            end
            if __lux_tmp_y_156 == nil then
              __lux_tmp_y_156 = shadow.dy
            end
            oy = toNumber(__lux_tmp_y_156)
            if oy == nil then
              oy = 0
            end
          end
          local shadowColor
          do
            local __lux_tmp_strength_157 = toNumber(shadow.strength)
            if __lux_tmp_strength_157 == nil then
              __lux_tmp_strength_157 = 1
            end
            shadowColor = style.withAlpha(
              shadow.color,
              mathFloor(shadowAlpha * mathMax(0, __lux_tmp_strength_157) * 0.38)
            )
          end
          local sx = x + ox - spread - grow
          local sy = y + oy - spread - grow
          local sw = w + (spread + grow) * 2
          local sh = h + (spread + grow) * 2
          local sr = radius + spread + grow
          if hasTransform() then
            local points = fallbackRoundRectPoints(sx, sy, sw, sh, sr)
            setColor(shadowColor)
            drawTransformedPoly(points)
          else
            drawRoundedBox(mathFloor(sr), sx, sy, sw, sh, shadowColor)
            recordDraws()
          end
        end
      end
      local outer = outerGlowStyle(resolved.outerGlow)
      if outer ~= nil and outer.color ~= nil then
        local outerAlpha = style.alpha(outer.color.a)
        if outerAlpha > 0 then
          local spread
          do
            local __lux_tmp_spread_158 = outer.spread
            if __lux_tmp_spread_158 == nil then
              __lux_tmp_spread_158 = outer.width
            end
            local __lux_tmp_spread_159 = toNumber(__lux_tmp_spread_158)
            if __lux_tmp_spread_159 == nil then
              __lux_tmp_spread_159 = 18
            end
            spread = mathMax(1, __lux_tmp_spread_159)
          end
          local grow
          do
            local __lux_tmp_grow_160 = outer.grow
            if __lux_tmp_grow_160 == nil then
              __lux_tmp_grow_160 = outer.shapeSpread
            end
            if __lux_tmp_grow_160 == nil then
              __lux_tmp_grow_160 = outer.expand
            end
            local __lux_tmp_grow_161 = toNumber(__lux_tmp_grow_160)
            if __lux_tmp_grow_161 == nil then
              __lux_tmp_grow_161 = 0
            end
            grow = mathMax(0, __lux_tmp_grow_161)
          end
          local ox
          do
            local __lux_tmp_x_162 = outer.x
            if __lux_tmp_x_162 == nil then
              __lux_tmp_x_162 = outer.offsetX
            end
            if __lux_tmp_x_162 == nil then
              __lux_tmp_x_162 = outer.dx
            end
            ox = toNumber(__lux_tmp_x_162)
            if ox == nil then
              ox = 0
            end
          end
          local oy
          do
            local __lux_tmp_y_163 = outer.y
            if __lux_tmp_y_163 == nil then
              __lux_tmp_y_163 = outer.offsetY
            end
            if __lux_tmp_y_163 == nil then
              __lux_tmp_y_163 = outer.dy
            end
            oy = toNumber(__lux_tmp_y_163)
            if oy == nil then
              oy = 0
            end
          end
          local glow = style.withAlpha(outer.color, mathFloor(outerAlpha * 0.35))
          if hasTransform() then
            local points = fallbackRoundRectPoints(
              x + ox - spread - grow,
              y + oy - spread - grow,
              w + (spread + grow) * 2,
              h + (spread + grow) * 2,
              radius + spread + grow
            )
            setColor(glow)
            drawTransformedPoly(points)
          else
            drawRoundedBox(
              mathFloor(radius + spread + grow),
              x + ox - spread - grow,
              y + oy - spread - grow,
              w + (spread + grow) * 2,
              h + (spread + grow) * 2,
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
        local __lux_tmp_drawStyle_164 = drawStyle
        if __lux_tmp_drawStyle_164 == nil then
          __lux_tmp_drawStyle_164 = {}
        end
        resolved = copyInto(circleStyle, __lux_tmp_drawStyle_164)
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
          local __lux_tmp_drawStyle_165 = drawStyle
          if __lux_tmp_drawStyle_165 == nil then
            __lux_tmp_drawStyle_165 = {}
          end
          resolved = copyInto(capsuleStyle, __lux_tmp_drawStyle_165)
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
        shadowStyle = shadowStyle,
        patternStyle = patternStyle,
        patternOffset = patternOffset,
      }
      return owner
    end
  end
  
  __lux_exports.fallbackRoundRectPoints = fallbackRoundRectPoints
  __lux_exports.innerGlowStyle = innerGlowStyle
  __lux_exports.outerGlowStyle = outerGlowStyle
  __lux_exports.shadowStyle = shadowStyle
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
