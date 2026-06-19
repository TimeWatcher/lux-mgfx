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
  local glowBiasPads
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
        local __lux_tmp_base_23 = toNumber(base)
        if __lux_tmp_base_23 == nil then
          __lux_tmp_base_23 = minPad
        end
        pad = mathMax(minPad, __lux_tmp_base_23)
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
        local __lux_tmp_size_24 = glow.size
        if __lux_tmp_size_24 == nil then
          __lux_tmp_size_24 = glow.width
        end
        if __lux_tmp_size_24 == nil then
          __lux_tmp_size_24 = glow.blur
        end
        if __lux_tmp_size_24 == nil then
          __lux_tmp_size_24 = glow.radius
        end
        if __lux_tmp_size_24 == nil then
          __lux_tmp_size_24 = glow.spread
        end
        local __lux_tmp_size_25 = toNumber(__lux_tmp_size_24)
        if __lux_tmp_size_25 == nil then
          __lux_tmp_size_25 = 18
        end
        width = mathMax(1, __lux_tmp_size_25)
      end
      local __lux_tmp_color_26 = glow.color
      if __lux_tmp_color_26 == nil then
        __lux_tmp_color_26 = glow.tint
      end
      local __lux_tmp_spread_27 = toNumber(glow.spread)
      if __lux_tmp_spread_27 == nil then
        __lux_tmp_spread_27 = width
      end
      local __lux_tmp_grow_28 = glow.grow
      if __lux_tmp_grow_28 == nil then
        __lux_tmp_grow_28 = glow.expand
      end
      if __lux_tmp_grow_28 == nil then
        __lux_tmp_grow_28 = glow.shapeSpread
      end
      local __lux_tmp_grow_29 = toNumber(__lux_tmp_grow_28)
      if __lux_tmp_grow_29 == nil then
        __lux_tmp_grow_29 = 0
      end
      local __lux_tmp_opacity_30 = glow.opacity
      if __lux_tmp_opacity_30 == nil then
        __lux_tmp_opacity_30 = glow.strength
      end
      local __lux_tmp_opacity_31 = toNumber(__lux_tmp_opacity_30)
      if __lux_tmp_opacity_31 == nil then
        __lux_tmp_opacity_31 = 1
      end
      local __lux_tmp_falloff_32 = toNumber(glow.falloff)
      if __lux_tmp_falloff_32 == nil then
        __lux_tmp_falloff_32 = style.glowSoftnessToFalloff(glow.softness, 0.54)
      end
      return {
        color = style.asColor(__lux_tmp_color_26, makeColor(76, 190, 255, 88)),
        x = x,
        y = y,
        width = width,
        spread = mathMax(1, __lux_tmp_spread_27),
        grow = mathMax(0, __lux_tmp_grow_29),
        strength = __lux_tmp_opacity_31,
        falloff = __lux_tmp_falloff_32,
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
          local __lux_tmp_shadow_33 = toNumber(shadow)
          if __lux_tmp_shadow_33 == nil then
            __lux_tmp_shadow_33 = 12
          end
          blur = mathMax(0.001, __lux_tmp_shadow_33)
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
        local __lux_tmp_blur_34 = shadow.blur
        if __lux_tmp_blur_34 == nil then
          __lux_tmp_blur_34 = shadow.radius
        end
        if __lux_tmp_blur_34 == nil then
          __lux_tmp_blur_34 = shadow.size
        end
        if __lux_tmp_blur_34 == nil then
          __lux_tmp_blur_34 = shadow.width
        end
        local __lux_tmp_blur_35 = toNumber(__lux_tmp_blur_34)
        if __lux_tmp_blur_35 == nil then
          __lux_tmp_blur_35 = 12
        end
        blur = mathMax(0.001, __lux_tmp_blur_35)
      end
      local grow
      do
        local __lux_tmp_spread_36 = shadow.spread
        if __lux_tmp_spread_36 == nil then
          __lux_tmp_spread_36 = shadow.grow
        end
        if __lux_tmp_spread_36 == nil then
          __lux_tmp_spread_36 = shadow.expand
        end
        if __lux_tmp_spread_36 == nil then
          __lux_tmp_spread_36 = shadow.shapeSpread
        end
        local __lux_tmp_spread_37 = toNumber(__lux_tmp_spread_36)
        if __lux_tmp_spread_37 == nil then
          __lux_tmp_spread_37 = 0
        end
        grow = mathMax(0, __lux_tmp_spread_37)
      end
      local __lux_tmp_color_38 = shadow.color
      if __lux_tmp_color_38 == nil then
        __lux_tmp_color_38 = shadow.tint
      end
      local __lux_tmp_extent_39 = shadow.extent
      if __lux_tmp_extent_39 == nil then
        __lux_tmp_extent_39 = shadow.padding
      end
      local __lux_tmp_extent_40 = toNumber(__lux_tmp_extent_39)
      if __lux_tmp_extent_40 == nil then
        __lux_tmp_extent_40 = blur
      end
      local __lux_tmp_opacity_41 = shadow.opacity
      if __lux_tmp_opacity_41 == nil then
        __lux_tmp_opacity_41 = shadow.strength
      end
      local __lux_tmp_opacity_42 = toNumber(__lux_tmp_opacity_41)
      if __lux_tmp_opacity_42 == nil then
        __lux_tmp_opacity_42 = 1
      end
      local __lux_tmp_falloff_43 = toNumber(shadow.falloff)
      if __lux_tmp_falloff_43 == nil then
        __lux_tmp_falloff_43 = style.glowSoftnessToFalloff(shadow.softness, 0.62)
      end
      return {
        color = style.asColor(__lux_tmp_color_38, makeColor(0, 0, 0, 132)),
        x = x,
        y = y,
        width = blur,
        spread = mathMax(1, __lux_tmp_extent_40),
        grow = grow,
        strength = __lux_tmp_opacity_42,
        falloff = __lux_tmp_falloff_43,
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
        local __lux_match_44 = pattern.kind
        if __lux_match_44 == "stripe" or __lux_match_44 == "smoke" then
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
        local __lux_obj_pattern_45 = pattern
        local __lux_val_offset_46 = nil
        if __lux_obj_pattern_45 ~= nil then
          __lux_val_offset_46 = __lux_obj_pattern_45.offset
        end
        offset = toNumber(__lux_val_offset_46)
        if offset == nil then
          offset = 0
        end
      end
      local speed
      do
        local __lux_obj_pattern_47 = pattern
        local __lux_val_speed_48 = nil
        if __lux_obj_pattern_47 ~= nil then
          __lux_val_speed_48 = __lux_obj_pattern_47.speed
        end
        speed = toNumber(__lux_val_speed_48)
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
      local __lux_match_49 = fill
      local __lux_tag_50
      if __lux_match_49 ~= nil then
        __lux_tag_50 = __lux_match_49.kind
      end
      if __lux_tag_50 == style.FILL_LINEAR then
        local x1 = __lux_match_49.x1
        local y1 = __lux_match_49.y1
        local x2 = __lux_match_49.x2
        local y2 = __lux_match_49.y2
        do
          local __lux_tmp_x1_51 = x1
          if __lux_tmp_x1_51 == nil then
            __lux_tmp_x1_51 = 0
          end
          p0 = __lux_tmp_x1_51
        end
        do
          local __lux_tmp_y1_52 = y1
          if __lux_tmp_y1_52 == nil then
            __lux_tmp_y1_52 = 0
          end
          p1 = __lux_tmp_y1_52
        end
        do
          local __lux_tmp_x2_53 = x2
          if __lux_tmp_x2_53 == nil then
            __lux_tmp_x2_53 = 1
          end
          p2 = __lux_tmp_x2_53
        end
        do
          local __lux_tmp_y2_54 = y2
          if __lux_tmp_y2_54 == nil then
            __lux_tmp_y2_54 = 1
          end
          p3 = __lux_tmp_y2_54
        end
        style.bindGradientLut(material, fill)
      elseif __lux_tag_50 == style.FILL_RADIAL then
        local cx = __lux_match_49.cx
        local cy = __lux_match_49.cy
        local radius = __lux_match_49.radius
        do
          local __lux_tmp_cx_55 = cx
          if __lux_tmp_cx_55 == nil then
            __lux_tmp_cx_55 = 0.5
          end
          p0 = __lux_tmp_cx_55
        end
        do
          local __lux_tmp_cy_56 = cy
          if __lux_tmp_cy_56 == nil then
            __lux_tmp_cy_56 = 0.5
          end
          p1 = __lux_tmp_cy_56
        end
        do
          local __lux_tmp_radius_57 = radius
          if __lux_tmp_radius_57 == nil then
            __lux_tmp_radius_57 = 0.5
          end
          p2 = __lux_tmp_radius_57
        end
        p3 = 0
        style.bindGradientLut(material, fill)
      elseif __lux_tag_50 == style.FILL_CONIC then
        local cx = __lux_match_49.cx
        local cy = __lux_match_49.cy
        local rotation = __lux_match_49.rotation
        do
          local __lux_tmp_cx_58 = cx
          if __lux_tmp_cx_58 == nil then
            __lux_tmp_cx_58 = 0.5
          end
          p0 = __lux_tmp_cx_58
        end
        do
          local __lux_tmp_cy_59 = cy
          if __lux_tmp_cy_59 == nil then
            __lux_tmp_cy_59 = 0.5
          end
          p1 = __lux_tmp_cy_59
        end
        p2 = style.normalizedRotation(rotation)
        p3 = 0
        style.bindGradientLut(material, fill)
      else
        local __lux_unused_60 = nil
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
        local __lux_tmp_a0_61 = a0
        if __lux_tmp_a0_61 == nil then
          __lux_tmp_a0_61 = 0
        end
        local __lux_tmp_b0_62 = b0
        if __lux_tmp_b0_62 == nil then
          __lux_tmp_b0_62 = 0
        end
        local __lux_tmp_c0_63 = c0
        if __lux_tmp_c0_63 == nil then
          __lux_tmp_c0_63 = 0
        end
        local __lux_tmp_d0_64 = d0
        if __lux_tmp_d0_64 == nil then
          __lux_tmp_d0_64 = 0
        end
        local __lux_tmp_a1_65 = a1
        if __lux_tmp_a1_65 == nil then
          __lux_tmp_a1_65 = 0
        end
        local __lux_tmp_b1_66 = b1
        if __lux_tmp_b1_66 == nil then
          __lux_tmp_b1_66 = 0
        end
        local __lux_tmp_c1_67 = c1
        if __lux_tmp_c1_67 == nil then
          __lux_tmp_c1_67 = 0
        end
        local __lux_tmp_d1_68 = d1
        if __lux_tmp_d1_68 == nil then
          __lux_tmp_d1_68 = 0
        end
        local __lux_tmp_a2_69 = a2
        if __lux_tmp_a2_69 == nil then
          __lux_tmp_a2_69 = 0
        end
        local __lux_tmp_b2_70 = b2
        if __lux_tmp_b2_70 == nil then
          __lux_tmp_b2_70 = 0
        end
        local __lux_tmp_c2_71 = c2
        if __lux_tmp_c2_71 == nil then
          __lux_tmp_c2_71 = 0
        end
        local __lux_tmp_d2_72 = d2
        if __lux_tmp_d2_72 == nil then
          __lux_tmp_d2_72 = 0
        end
        local __lux_tmp_a3_73 = a3
        if __lux_tmp_a3_73 == nil then
          __lux_tmp_a3_73 = 0
        end
        local __lux_tmp_b3_74 = b3
        if __lux_tmp_b3_74 == nil then
          __lux_tmp_b3_74 = 0
        end
        local __lux_tmp_c3_75 = c3
        if __lux_tmp_c3_75 == nil then
          __lux_tmp_c3_75 = 0
        end
        local __lux_tmp_d3_76 = d3
        if __lux_tmp_d3_76 == nil then
          __lux_tmp_d3_76 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_a0_61,
          __lux_tmp_b0_62,
          __lux_tmp_c0_63,
          __lux_tmp_d0_64,
          __lux_tmp_a1_65,
          __lux_tmp_b1_66,
          __lux_tmp_c1_67,
          __lux_tmp_d1_68,
          __lux_tmp_a2_69,
          __lux_tmp_b2_70,
          __lux_tmp_c2_71,
          __lux_tmp_d2_72,
          __lux_tmp_a3_73,
          __lux_tmp_b3_74,
          __lux_tmp_c3_75,
          __lux_tmp_d3_76
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
        local __lux_tmp_a0_77 = a0
        if __lux_tmp_a0_77 == nil then
          __lux_tmp_a0_77 = 0
        end
        material:SetFloat("$c0_x", __lux_tmp_a0_77)
      end
      do
        local __lux_tmp_a1_78 = a1
        if __lux_tmp_a1_78 == nil then
          __lux_tmp_a1_78 = 0
        end
        material:SetFloat("$c0_y", __lux_tmp_a1_78)
      end
      do
        local __lux_tmp_a2_79 = a2
        if __lux_tmp_a2_79 == nil then
          __lux_tmp_a2_79 = 0
        end
        material:SetFloat("$c0_z", __lux_tmp_a2_79)
      end
      do
        local __lux_tmp_a3_80 = a3
        if __lux_tmp_a3_80 == nil then
          __lux_tmp_a3_80 = 0
        end
        material:SetFloat("$c0_w", __lux_tmp_a3_80)
      end
      do
        local __lux_tmp_b0_81 = b0
        if __lux_tmp_b0_81 == nil then
          __lux_tmp_b0_81 = 0
        end
        material:SetFloat("$c1_x", __lux_tmp_b0_81)
      end
      do
        local __lux_tmp_b1_82 = b1
        if __lux_tmp_b1_82 == nil then
          __lux_tmp_b1_82 = 0
        end
        material:SetFloat("$c1_y", __lux_tmp_b1_82)
      end
      do
        local __lux_tmp_b2_83 = b2
        if __lux_tmp_b2_83 == nil then
          __lux_tmp_b2_83 = 0
        end
        material:SetFloat("$c1_z", __lux_tmp_b2_83)
      end
      do
        local __lux_tmp_b3_84 = b3
        if __lux_tmp_b3_84 == nil then
          __lux_tmp_b3_84 = 0
        end
        material:SetFloat("$c1_w", __lux_tmp_b3_84)
      end
      do
        local __lux_tmp_c0_85 = c0
        if __lux_tmp_c0_85 == nil then
          __lux_tmp_c0_85 = 0
        end
        material:SetFloat("$c2_x", __lux_tmp_c0_85)
      end
      do
        local __lux_tmp_c1_86 = c1
        if __lux_tmp_c1_86 == nil then
          __lux_tmp_c1_86 = 0
        end
        material:SetFloat("$c2_y", __lux_tmp_c1_86)
      end
      do
        local __lux_tmp_c2_87 = c2
        if __lux_tmp_c2_87 == nil then
          __lux_tmp_c2_87 = 0
        end
        material:SetFloat("$c2_z", __lux_tmp_c2_87)
      end
      do
        local __lux_tmp_c3_88 = c3
        if __lux_tmp_c3_88 == nil then
          __lux_tmp_c3_88 = 0
        end
        material:SetFloat("$c2_w", __lux_tmp_c3_88)
      end
      do
        local __lux_tmp_d0_89 = d0
        if __lux_tmp_d0_89 == nil then
          __lux_tmp_d0_89 = 0
        end
        material:SetFloat("$c3_x", __lux_tmp_d0_89)
      end
      do
        local __lux_tmp_d1_90 = d1
        if __lux_tmp_d1_90 == nil then
          __lux_tmp_d1_90 = 0
        end
        material:SetFloat("$c3_y", __lux_tmp_d1_90)
      end
      do
        local __lux_tmp_d2_91 = d2
        if __lux_tmp_d2_91 == nil then
          __lux_tmp_d2_91 = 0
        end
        material:SetFloat("$c3_z", __lux_tmp_d2_91)
      end
      do
        local __lux_tmp_d3_92 = d3
        if __lux_tmp_d3_92 == nil then
          __lux_tmp_d3_92 = 0
        end
        material:SetFloat("$c3_w", __lux_tmp_d3_92)
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
        local __lux_tmp_radius_93 = toNumber(radius)
        if __lux_tmp_radius_93 == nil then
          __lux_tmp_radius_93 = 0
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
          mathMax(0, __lux_tmp_radius_93),
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
        local __lux_tmp_color_94 = pattern.color
        if __lux_tmp_color_94 == nil then
          __lux_tmp_color_94 = pattern.tint
        end
        color = style.asColor(__lux_tmp_color_94, makeColor(255, 255, 255, 24))
      end
      local r, g, b, a = style.color01(color)
      local angle
      do
        local __lux_tmp_angle_95 = toNumber(pattern.angle)
        if __lux_tmp_angle_95 == nil then
          __lux_tmp_angle_95 = 135
        end
        angle = mathRad(__lux_tmp_angle_95)
      end
      local smoke
      local __lux_match_96 = pattern.kind
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
          local __lux_tmp_scale_97 = toNumber(pattern.scale)
          if __lux_tmp_scale_97 == nil then
            __lux_tmp_scale_97 = 140
          end
          pz = mathMax(1, __lux_tmp_scale_97)
        end
        do
          local __lux_tmp_density_98 = toNumber(pattern.density)
          if __lux_tmp_density_98 == nil then
            __lux_tmp_density_98 = 0.48
          end
          pw = mathClamp(__lux_tmp_density_98, 0, 1)
        end
        ox = patternOffset(pattern)
        oy = 1
        do
          local __lux_tmp_softness_99 = toNumber(pattern.softness)
          if __lux_tmp_softness_99 == nil then
            __lux_tmp_softness_99 = 0.3
          end
          oz = mathMax(0.001, __lux_tmp_softness_99)
        end
        do
          local __lux_tmp_warp_100 = toNumber(pattern.warp)
          if __lux_tmp_warp_100 == nil then
            __lux_tmp_warp_100 = 0.85
          end
          ow = mathMax(0, __lux_tmp_warp_100)
        end
      else
        do
          local __lux_tmp_spacing_101 = toNumber(pattern.spacing)
          if __lux_tmp_spacing_101 == nil then
            __lux_tmp_spacing_101 = 12
          end
          pz = mathMax(1, __lux_tmp_spacing_101)
        end
        do
          local __lux_tmp_width_102 = toNumber(pattern.width)
          if __lux_tmp_width_102 == nil then
            __lux_tmp_width_102 = 2
          end
          pw = mathMax(0.25, __lux_tmp_width_102)
        end
        ox = patternOffset(pattern)
      end
      local __lux_tmp_103
      if smoke then
        __lux_tmp_103 = toNumber(pattern.seed)
        if __lux_tmp_103 == nil then
          __lux_tmp_103 = 0
        end
      else
        __lux_tmp_103 = 0
      end
      local __lux_tmp_radius_104 = toNumber(radius)
      if __lux_tmp_radius_104 == nil then
        __lux_tmp_radius_104 = 0
      end
      return setupParamMatrix(
        material,
        r,
        g,
        b,
        a,
        w,
        h,
        __lux_tmp_103,
        mathMax(0, __lux_tmp_radius_104),
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
      local __lux_tmp_107 = color ~= nil
      if __lux_tmp_107 then
        local __lux_tmp_a_106 = color.a
        if __lux_tmp_a_106 == nil then
          __lux_tmp_a_106 = 255
        end
        __lux_tmp_107 = __lux_tmp_a_106 <= 0
      end
      if __lux_tmp_107 then
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
        local __lux_tmp_grow_108 = toNumber(grow)
        if __lux_tmp_grow_108 == nil then
          __lux_tmp_grow_108 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_108)
      end
      if grow <= 0 then
        return radius
      end
      if typeOf(radius) == "table" and not style.isColor(radius) then
        local __lux_tmp_tl_109 = radius.tl
        if __lux_tmp_tl_109 == nil then
          __lux_tmp_tl_109 = radius[1]
        end
        local __lux_tmp_tl_110 = toNumber(__lux_tmp_tl_109)
        if __lux_tmp_tl_110 == nil then
          __lux_tmp_tl_110 = 0
        end
        local __lux_tmp_tr_111 = radius.tr
        if __lux_tmp_tr_111 == nil then
          __lux_tmp_tr_111 = radius[2]
        end
        if __lux_tmp_tr_111 == nil then
          __lux_tmp_tr_111 = radius.tl
        end
        if __lux_tmp_tr_111 == nil then
          __lux_tmp_tr_111 = radius[1]
        end
        local __lux_tmp_tr_112 = toNumber(__lux_tmp_tr_111)
        if __lux_tmp_tr_112 == nil then
          __lux_tmp_tr_112 = 0
        end
        local __lux_tmp_br_113 = radius.br
        if __lux_tmp_br_113 == nil then
          __lux_tmp_br_113 = radius[3]
        end
        if __lux_tmp_br_113 == nil then
          __lux_tmp_br_113 = radius.tr
        end
        if __lux_tmp_br_113 == nil then
          __lux_tmp_br_113 = radius[2]
        end
        if __lux_tmp_br_113 == nil then
          __lux_tmp_br_113 = radius.tl
        end
        if __lux_tmp_br_113 == nil then
          __lux_tmp_br_113 = radius[1]
        end
        local __lux_tmp_br_114 = toNumber(__lux_tmp_br_113)
        if __lux_tmp_br_114 == nil then
          __lux_tmp_br_114 = 0
        end
        local __lux_tmp_bl_115 = radius.bl
        if __lux_tmp_bl_115 == nil then
          __lux_tmp_bl_115 = radius[4]
        end
        if __lux_tmp_bl_115 == nil then
          __lux_tmp_bl_115 = radius.br
        end
        if __lux_tmp_bl_115 == nil then
          __lux_tmp_bl_115 = radius[3]
        end
        if __lux_tmp_bl_115 == nil then
          __lux_tmp_bl_115 = radius.tr
        end
        if __lux_tmp_bl_115 == nil then
          __lux_tmp_bl_115 = radius[2]
        end
        if __lux_tmp_bl_115 == nil then
          __lux_tmp_bl_115 = radius.tl
        end
        if __lux_tmp_bl_115 == nil then
          __lux_tmp_bl_115 = radius[1]
        end
        local __lux_tmp_bl_116 = toNumber(__lux_tmp_bl_115)
        if __lux_tmp_bl_116 == nil then
          __lux_tmp_bl_116 = 0
        end
        return {
          tl = mathMax(0, __lux_tmp_tl_110) + grow,
          tr = mathMax(0, __lux_tmp_tr_112) + grow,
          br = mathMax(0, __lux_tmp_br_114) + grow,
          bl = mathMax(0, __lux_tmp_bl_116) + grow,
        }
      end
      local __lux_tmp_radius_117 = toNumber(radius)
      if __lux_tmp_radius_117 == nil then
        __lux_tmp_radius_117 = 0
      end
      return __lux_tmp_radius_117 + grow
    end
    drawRoundRectInnerGlowSpec = function(x, y, w, h, radius, spec)
      local __lux_tmp_120 = spec == nil or spec.color == nil
      if not __lux_tmp_120 then
        local __lux_tmp_a_119 = spec.color.a
        if __lux_tmp_a_119 == nil then
          __lux_tmp_a_119 = 255
        end
        __lux_tmp_120 = __lux_tmp_a_119 <= 0
      end
      local __lux_tmp_121 = __lux_tmp_120
      if not __lux_tmp_121 then
        __lux_tmp_121 = not shadersActive()
      end
      local __lux_tmp_122 = __lux_tmp_121
      if not __lux_tmp_122 then
        __lux_tmp_122 = not materialOK(roundRectMaterials.roundrect_innerglow)
      end
      if __lux_tmp_122 then
        return false
      end
      local material = roundRectMaterials.roundrect_innerglow
      local r, g, b, a = style.color01(spec.color)
      do
        local __lux_tmp_width_123 = toNumber(spec.width)
        if __lux_tmp_width_123 == nil then
          __lux_tmp_width_123 = 8
        end
        local __lux_tmp_strength_124 = toNumber(spec.strength)
        if __lux_tmp_strength_124 == nil then
          __lux_tmp_strength_124 = 1
        end
        local __lux_tmp_falloff_125 = toNumber(spec.falloff)
        if __lux_tmp_falloff_125 == nil then
          __lux_tmp_falloff_125 = 1.65
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
          mathMax(0.001, __lux_tmp_width_123),
          mathMax(0, __lux_tmp_strength_124),
          mathMax(0.001, __lux_tmp_falloff_125),
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
    drawRoundRectOuterGlowSpec = function(x, y, w, h, radius, spec, biasOffset)
      if biasOffset == nil then
        biasOffset = false
      end
      local __lux_tmp_128 = spec == nil or spec.color == nil
      if not __lux_tmp_128 then
        local __lux_tmp_a_127 = spec.color.a
        if __lux_tmp_a_127 == nil then
          __lux_tmp_a_127 = 255
        end
        __lux_tmp_128 = __lux_tmp_a_127 <= 0
      end
      local __lux_tmp_129 = __lux_tmp_128
      if not __lux_tmp_129 then
        __lux_tmp_129 = not shadersActive()
      end
      local __lux_tmp_130 = __lux_tmp_129
      if not __lux_tmp_130 then
        __lux_tmp_130 = not materialOK(roundRectMaterials.roundrect_outerglow)
      end
      if __lux_tmp_130 then
        return false
      end
      local grow
      do
        local __lux_tmp_grow_131 = spec.grow
        if __lux_tmp_grow_131 == nil then
          __lux_tmp_grow_131 = spec.shapeSpread
        end
        if __lux_tmp_grow_131 == nil then
          __lux_tmp_grow_131 = spec.expand
        end
        local __lux_tmp_grow_132 = toNumber(__lux_tmp_grow_131)
        if __lux_tmp_grow_132 == nil then
          __lux_tmp_grow_132 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_132)
      end
      local ox
      do
        local __lux_tmp_x_133 = spec.x
        if __lux_tmp_x_133 == nil then
          __lux_tmp_x_133 = spec.offsetX
        end
        if __lux_tmp_x_133 == nil then
          __lux_tmp_x_133 = spec.dx
        end
        ox = toNumber(__lux_tmp_x_133)
        if ox == nil then
          ox = 0
        end
      end
      local oy
      do
        local __lux_tmp_y_134 = spec.y
        if __lux_tmp_y_134 == nil then
          __lux_tmp_y_134 = spec.offsetY
        end
        if __lux_tmp_y_134 == nil then
          __lux_tmp_y_134 = spec.dy
        end
        oy = toNumber(__lux_tmp_y_134)
        if oy == nil then
          oy = 0
        end
      end
      local gw = w + grow * 2
      local gh = h + grow * 2
      local gr = radiusWithGrow(radius, grow)
      local spread
      do
        local __lux_tmp_spread_135 = spec.spread
        if __lux_tmp_spread_135 == nil then
          __lux_tmp_spread_135 = spec.width
        end
        local __lux_tmp_spread_136 = toNumber(__lux_tmp_spread_135)
        if __lux_tmp_spread_136 == nil then
          __lux_tmp_spread_136 = 18
        end
        spread = mathMax(1, __lux_tmp_spread_136)
      end
      local gx = x + ox - grow
      local gy = y + oy - grow
      local left = spread
      local top = spread
      local right = spread
      local bottom = spread
      if biasOffset then
        left, top, right, bottom = glowBiasPads(spread, ox, oy)
        gx = x - grow
        gy = y - grow
      end
      local sw = gw + left + right
      local sh = gh + top + bottom
      local material = roundRectMaterials.roundrect_outerglow
      local r, g, b, a = style.color01(spec.color)
      do
        local __lux_tmp_width_137 = toNumber(spec.width)
        if __lux_tmp_width_137 == nil then
          __lux_tmp_width_137 = spread
        end
        local __lux_tmp_strength_138 = toNumber(spec.strength)
        if __lux_tmp_strength_138 == nil then
          __lux_tmp_strength_138 = 1
        end
        local __lux_tmp_falloff_139 = toNumber(spec.falloff)
        if __lux_tmp_falloff_139 == nil then
          __lux_tmp_falloff_139 = 1.9
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
          left,
          top,
          gw,
          gh,
          style.radiusScalar(gr, gw, gh),
          mathMax(0.001, __lux_tmp_width_137),
          mathMax(0, __lux_tmp_strength_138),
          mathMax(0.001, __lux_tmp_falloff_139)
        )
      end
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(gx - left, gy - top, sw, sh)
      return true
    end
    backdropTintColor = function(spec)
      if spec == nil or spec.tint == nil then
        return nil
      end
      local tint = spec.tint
      local alpha
      do
        local __lux_tmp_a_140 = tint.a
        if __lux_tmp_a_140 == nil then
          __lux_tmp_a_140 = 255
        end
        local __lux_tmp_opacity_141 = spec.opacity
        if __lux_tmp_opacity_141 == nil then
          __lux_tmp_opacity_141 = 1
        end
        alpha = __lux_tmp_a_140 * __lux_tmp_opacity_141
      end
      if alpha <= 0 then
        return nil
      end
      local __lux_tmp_r_142 = tint.r
      if __lux_tmp_r_142 == nil then
        __lux_tmp_r_142 = 0
      end
      local __lux_tmp_g_143 = tint.g
      if __lux_tmp_g_143 == nil then
        __lux_tmp_g_143 = 0
      end
      local __lux_tmp_b_144 = tint.b
      if __lux_tmp_b_144 == nil then
        __lux_tmp_b_144 = 0
      end
      return makeColor(
        __lux_tmp_r_142,
        __lux_tmp_g_143,
        __lux_tmp_b_144,
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
          local __lux_tmp_color_145 = innerSpec.color
          if __lux_tmp_color_145 == nil then
            __lux_tmp_color_145 = transparentColor
          end
          gr, gg, gb, ga = style.color01(__lux_tmp_color_145)
        end
        do
          local __lux_tmp_width_146 = toNumber(innerSpec.width)
          if __lux_tmp_width_146 == nil then
            __lux_tmp_width_146 = 8
          end
          glowWidth = mathMax(0.001, __lux_tmp_width_146)
        end
        do
          local __lux_tmp_strength_147 = toNumber(innerSpec.strength)
          if __lux_tmp_strength_147 == nil then
            __lux_tmp_strength_147 = 1
          end
          glowStrength = mathMax(0, __lux_tmp_strength_147)
        end
        do
          local __lux_tmp_falloff_148 = toNumber(innerSpec.falloff)
          if __lux_tmp_falloff_148 == nil then
            __lux_tmp_falloff_148 = 1.65
          end
          glowFalloff = mathMax(0.001, __lux_tmp_falloff_148)
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
        drawRoundRectOuterGlowSpec(x, y, w, h, radius, outer, true)
      end
      local backdrop = nil
      if drawStyle.backdrop ~= nil then
        backdrop = drawRoundRectBackdrop(x, y, w, h, radius, drawStyle.backdrop)
      end
      local fill
      do
        local __lux_tmp_fill_149 = drawStyle.fill
        if __lux_tmp_fill_149 == nil then
          __lux_tmp_fill_149 = drawStyle.color
        end
        fill = style.fillFromStyle(__lux_tmp_fill_149)
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
        local __lux_tmp_radius_150 = resolved.radius
        if __lux_tmp_radius_150 == nil then
          __lux_tmp_radius_150 = resolved.r
        end
        if __lux_tmp_radius_150 == nil then
          __lux_tmp_radius_150 = 0
        end
        radius = style.radiusScalar(__lux_tmp_radius_150, w, h)
      end
      local fill
      do
        local __lux_tmp_fill_151 = resolved.fill
        if __lux_tmp_fill_151 == nil then
          __lux_tmp_fill_151 = resolved.color
        end
        fill = style.fillFromStyle(__lux_tmp_fill_151)
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
            local __lux_tmp_spread_152 = shadow.spread
            if __lux_tmp_spread_152 == nil then
              __lux_tmp_spread_152 = shadow.width
            end
            local __lux_tmp_spread_153 = toNumber(__lux_tmp_spread_152)
            if __lux_tmp_spread_153 == nil then
              __lux_tmp_spread_153 = 12
            end
            spread = mathMax(1, __lux_tmp_spread_153)
          end
          local grow
          do
            local __lux_tmp_grow_154 = shadow.grow
            if __lux_tmp_grow_154 == nil then
              __lux_tmp_grow_154 = shadow.shapeSpread
            end
            if __lux_tmp_grow_154 == nil then
              __lux_tmp_grow_154 = shadow.expand
            end
            local __lux_tmp_grow_155 = toNumber(__lux_tmp_grow_154)
            if __lux_tmp_grow_155 == nil then
              __lux_tmp_grow_155 = 0
            end
            grow = mathMax(0, __lux_tmp_grow_155)
          end
          local ox
          do
            local __lux_tmp_x_156 = shadow.x
            if __lux_tmp_x_156 == nil then
              __lux_tmp_x_156 = shadow.offsetX
            end
            if __lux_tmp_x_156 == nil then
              __lux_tmp_x_156 = shadow.dx
            end
            ox = toNumber(__lux_tmp_x_156)
            if ox == nil then
              ox = 0
            end
          end
          local oy
          do
            local __lux_tmp_y_157 = shadow.y
            if __lux_tmp_y_157 == nil then
              __lux_tmp_y_157 = shadow.offsetY
            end
            if __lux_tmp_y_157 == nil then
              __lux_tmp_y_157 = shadow.dy
            end
            oy = toNumber(__lux_tmp_y_157)
            if oy == nil then
              oy = 0
            end
          end
          local shadowColor
          do
            local __lux_tmp_strength_158 = toNumber(shadow.strength)
            if __lux_tmp_strength_158 == nil then
              __lux_tmp_strength_158 = 1
            end
            shadowColor = style.withAlpha(
              shadow.color,
              mathFloor(shadowAlpha * mathMax(0, __lux_tmp_strength_158) * 0.38)
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
            local __lux_tmp_spread_159 = outer.spread
            if __lux_tmp_spread_159 == nil then
              __lux_tmp_spread_159 = outer.width
            end
            local __lux_tmp_spread_160 = toNumber(__lux_tmp_spread_159)
            if __lux_tmp_spread_160 == nil then
              __lux_tmp_spread_160 = 18
            end
            spread = mathMax(1, __lux_tmp_spread_160)
          end
          local grow
          do
            local __lux_tmp_grow_161 = outer.grow
            if __lux_tmp_grow_161 == nil then
              __lux_tmp_grow_161 = outer.shapeSpread
            end
            if __lux_tmp_grow_161 == nil then
              __lux_tmp_grow_161 = outer.expand
            end
            local __lux_tmp_grow_162 = toNumber(__lux_tmp_grow_161)
            if __lux_tmp_grow_162 == nil then
              __lux_tmp_grow_162 = 0
            end
            grow = mathMax(0, __lux_tmp_grow_162)
          end
          local ox
          do
            local __lux_tmp_x_163 = outer.x
            if __lux_tmp_x_163 == nil then
              __lux_tmp_x_163 = outer.offsetX
            end
            if __lux_tmp_x_163 == nil then
              __lux_tmp_x_163 = outer.dx
            end
            ox = toNumber(__lux_tmp_x_163)
            if ox == nil then
              ox = 0
            end
          end
          local oy
          do
            local __lux_tmp_y_164 = outer.y
            if __lux_tmp_y_164 == nil then
              __lux_tmp_y_164 = outer.offsetY
            end
            if __lux_tmp_y_164 == nil then
              __lux_tmp_y_164 = outer.dy
            end
            oy = toNumber(__lux_tmp_y_164)
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
        local __lux_tmp_drawStyle_165 = drawStyle
        if __lux_tmp_drawStyle_165 == nil then
          __lux_tmp_drawStyle_165 = {}
        end
        resolved = copyInto(circleStyle, __lux_tmp_drawStyle_165)
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
          local __lux_tmp_drawStyle_166 = drawStyle
          if __lux_tmp_drawStyle_166 == nil then
            __lux_tmp_drawStyle_166 = {}
          end
          resolved = copyInto(capsuleStyle, __lux_tmp_drawStyle_166)
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
  __lux_exports.glowBiasPads = glowBiasPads
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
