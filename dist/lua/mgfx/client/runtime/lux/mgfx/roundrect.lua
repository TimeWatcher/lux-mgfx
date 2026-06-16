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
    local __lux_import_1 = __lux_import("lux/mgfx/geometry#client")
    local geometryImport = __lux_import_1
    local __lux_import_2 = __lux_import("lux/mgfx/style#client")
    local styleImport = __lux_import_2
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
      local __lux_obj_3 = render
      local __lux_val_4 = nil
      if __lux_obj_3 ~= nil then
        __lux_val_4 = __lux_obj_3.CopyRenderTargetToTexture
      end
      renderCopyRenderTargetToTexture = __lux_val_4
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
      local __lux_tmp_5
      if matrixCtor ~= nil then
        __lux_tmp_5 = matrixCtor()
      else
        __lux_tmp_5 = nil
      end
      paramMatrixProbe = __lux_tmp_5
    end
    do
      local __lux_obj_6 = paramMatrixProbe
      local __lux_val_7 = nil
      if __lux_obj_6 ~= nil then
        __lux_val_7 = __lux_obj_6.SetUnpacked
      end
      paramMatrixSetUnpacked = __lux_val_7
    end
    paramMatrices = {}
    roundRectMaterials = {}
    roundRectBlurRT = nil
    roundRectMatOK = function(material)
      local __lux_tmp_8 = material ~= nil
      if __lux_tmp_8 then
        __lux_tmp_8 = material.IsError ~= nil
      end
      local __lux_tmp_9 = __lux_tmp_8
      if __lux_tmp_9 then
        __lux_tmp_9 = not material:IsError()
      end
      return __lux_tmp_9
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
      do
        local __lux_tmp_10 = owner
        if __lux_tmp_10 == nil then
          __lux_tmp_10 = {}
        end
        owner = __lux_tmp_10
      end
      local materialState
      do
        local __lux_tmp_11 = owner._MaterialState
        if __lux_tmp_11 == nil then
          __lux_tmp_11 = {}
        end
        materialState = __lux_tmp_11
      end
      do
        local __lux_tmp_12 = owner._Materials
        if __lux_tmp_12 == nil then
          local __lux_tmp_13 = materialState.materials
          if __lux_tmp_13 == nil then
            local __lux_tmp_14 = roundRectMaterials
            if __lux_tmp_14 == nil then
              __lux_tmp_14 = {}
            end
            __lux_tmp_13 = __lux_tmp_14
          end
          __lux_tmp_12 = __lux_tmp_13
        end
        roundRectMaterials = __lux_tmp_12
      end
      do
        local __lux_tmp_15 = owner._BlurRT
        if __lux_tmp_15 == nil then
          local __lux_tmp_16 = materialState.blurRT
          if __lux_tmp_16 == nil then
            __lux_tmp_16 = roundRectBlurRT
          end
          __lux_tmp_15 = __lux_tmp_16
        end
        roundRectBlurRT = __lux_tmp_15
      end
      do
        local __lux_tmp_17 = owner.MaterialOK
        if __lux_tmp_17 == nil then
          local __lux_tmp_18 = materialState.matOK
          if __lux_tmp_18 == nil then
            __lux_tmp_18 = roundRectMatOK
          end
          __lux_tmp_17 = __lux_tmp_18
        end
        roundRectMatOK = __lux_tmp_17
      end
      do
        local __lux_tmp_19 = owner.hasShaders
        if __lux_tmp_19 == nil then
          __lux_tmp_19 = roundRectHasShaders
        end
        roundRectHasShaders = __lux_tmp_19
      end
      return true
    end
    materialOK = function(material)
      local __lux_tmp_20 = roundRectMatOK ~= nil
      if __lux_tmp_20 then
        __lux_tmp_20 = roundRectMatOK(material)
      end
      return __lux_tmp_20
    end
    shadersActive = function()
      local __lux_tmp_21 = forceFallbackCvar == nil
      if __lux_tmp_21 then
        __lux_tmp_21 = getConVar ~= nil
      end
      if __lux_tmp_21 then
        do
          local __lux_tmp_22 = getConVar("mgfx_force_fallback")
          if __lux_tmp_22 == nil then
            __lux_tmp_22 = false
          end
          forceFallbackCvar = __lux_tmp_22
        end
      end
      local __lux_tmp_23 = forceFallbackCvar ~= nil
      if __lux_tmp_23 then
        __lux_tmp_23 = forceFallbackCvar ~= false
      end
      local __lux_tmp_24 = __lux_tmp_23
      if __lux_tmp_24 then
        __lux_tmp_24 = forceFallbackCvar:GetBool()
      end
      if __lux_tmp_24 then
        return false
      end
      local __lux_tmp_25 = roundRectHasShaders ~= nil
      if __lux_tmp_25 then
        __lux_tmp_25 = roundRectHasShaders()
      end
      return __lux_tmp_25
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
        local __lux_tmp_26 = fill.colorA
        if __lux_tmp_26 == nil then
          local __lux_tmp_27 = fill.color
          if __lux_tmp_27 == nil then
            local __lux_tmp_28 = fallback
            if __lux_tmp_28 == nil then
              __lux_tmp_28 = color_white
            end
            __lux_tmp_27 = __lux_tmp_28
          end
          __lux_tmp_26 = __lux_tmp_27
        end
        return __lux_tmp_26
      end
      local __lux_tmp_29 = fallback
      if __lux_tmp_29 == nil then
        __lux_tmp_29 = color_white
      end
      return __lux_tmp_29
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
      local point
      do
        local __lux_tmp_30 = verts[index]
        if __lux_tmp_30 == nil then
          __lux_tmp_30 = {}
        end
        point = __lux_tmp_30
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
      local __lux_tmp_31 = w <= 0
      if not __lux_tmp_31 then
        __lux_tmp_31 = h <= 0
      end
      if __lux_tmp_31 then
        return verts
      end
      do
        local __lux_tmp_32 = toNumber(radius)
        if __lux_tmp_32 == nil then
          __lux_tmp_32 = 0
        end
        radius = mathMin(mathMax(0, __lux_tmp_32), w * 0.5, h * 0.5)
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
        local __lux_tmp_33 = toNumber(width)
        if __lux_tmp_33 == nil then
          __lux_tmp_33 = 1
        end
        width = mathMax(1, __lux_tmp_33)
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
      local __lux_tmp_34 = glow == nil
      if not __lux_tmp_34 then
        __lux_tmp_34 = glow == false
      end
      if __lux_tmp_34 then
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
      local __lux_tmp_35 = glow.color
      if __lux_tmp_35 == nil then
        __lux_tmp_35 = glow.tint
      end
      local __lux_tmp_36 = glow.size
      if __lux_tmp_36 == nil then
        __lux_tmp_36 = glow.width
      end
      local __lux_tmp_37 = toNumber(__lux_tmp_36)
      if __lux_tmp_37 == nil then
        __lux_tmp_37 = 7
      end
      local __lux_tmp_38 = glow.opacity
      if __lux_tmp_38 == nil then
        __lux_tmp_38 = glow.strength
      end
      local __lux_tmp_39 = toNumber(__lux_tmp_38)
      if __lux_tmp_39 == nil then
        __lux_tmp_39 = 1
      end
      local __lux_tmp_40 = toNumber(glow.falloff)
      if __lux_tmp_40 == nil then
        __lux_tmp_40 = style.glowSoftnessToFalloff(glow.softness, 0.55)
      end
      return {
        color = style.asColor(__lux_tmp_35, makeColor(76, 190, 255, 34)),
        width = mathMax(1, __lux_tmp_37),
        strength = __lux_tmp_39,
        falloff = __lux_tmp_40,
      }
    end
    outerGlowStyle = function(glow)
      local __lux_tmp_41 = glow == nil
      if not __lux_tmp_41 then
        __lux_tmp_41 = glow == false
      end
      if __lux_tmp_41 then
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
        local __lux_tmp_42 = glow.size
        if __lux_tmp_42 == nil then
          local __lux_tmp_43 = glow.width
          if __lux_tmp_43 == nil then
            __lux_tmp_43 = glow.spread
          end
          __lux_tmp_42 = __lux_tmp_43
        end
        local __lux_tmp_44 = toNumber(__lux_tmp_42)
        if __lux_tmp_44 == nil then
          __lux_tmp_44 = 18
        end
        width = mathMax(1, __lux_tmp_44)
      end
      local __lux_tmp_45 = glow.color
      if __lux_tmp_45 == nil then
        __lux_tmp_45 = glow.tint
      end
      local __lux_tmp_46 = toNumber(glow.spread)
      if __lux_tmp_46 == nil then
        __lux_tmp_46 = width
      end
      local __lux_tmp_47 = glow.opacity
      if __lux_tmp_47 == nil then
        __lux_tmp_47 = glow.strength
      end
      local __lux_tmp_48 = toNumber(__lux_tmp_47)
      if __lux_tmp_48 == nil then
        __lux_tmp_48 = 1
      end
      local __lux_tmp_49 = toNumber(glow.falloff)
      if __lux_tmp_49 == nil then
        __lux_tmp_49 = style.glowSoftnessToFalloff(glow.softness, 0.54)
      end
      return {
        color = style.asColor(__lux_tmp_45, makeColor(76, 190, 255, 88)),
        width = width,
        spread = mathMax(1, __lux_tmp_46),
        strength = __lux_tmp_48,
        falloff = __lux_tmp_49,
      }
    end
    patternStyle = function(pattern)
      local __lux_tmp_50 = pattern == nil
      if not __lux_tmp_50 then
        __lux_tmp_50 = pattern == false
      end
      if __lux_tmp_50 then
        return nil
      end
      if pattern == true then
        return style.stripePattern(makeColor(255, 255, 255, 20), 10, 2, 135)
      end
      if typeOf(pattern) == "table" then
        local knownPattern
        local __lux_match_51 = pattern.kind
        if __lux_match_51 == "stripe" or __lux_match_51 == "smoke" then
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
        local __lux_obj_52 = pattern
        local __lux_val_53 = nil
        if __lux_obj_52 ~= nil then
          __lux_val_53 = __lux_obj_52.offset
        end
        local __lux_tmp_54 = toNumber(__lux_val_53)
        if __lux_tmp_54 == nil then
          __lux_tmp_54 = 0
        end
        offset = __lux_tmp_54
      end
      local speed
      do
        local __lux_obj_55 = pattern
        local __lux_val_56 = nil
        if __lux_obj_55 ~= nil then
          __lux_val_56 = __lux_obj_55.speed
        end
        local __lux_tmp_57 = toNumber(__lux_val_56)
        if __lux_tmp_57 == nil then
          __lux_tmp_57 = 0
        end
        speed = __lux_tmp_57
      end
      local __lux_tmp_58 = speed ~= 0
      if __lux_tmp_58 then
        __lux_tmp_58 = realTime ~= nil
      end
      if __lux_tmp_58 then
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
      local __lux_match_59 = fill
      local __lux_tag_60
      if __lux_match_59 ~= nil then
        __lux_tag_60 = __lux_match_59.kind
      end
      if __lux_tag_60 == style.FILL_LINEAR then
        local x1 = __lux_match_59.x1
        local y1 = __lux_match_59.y1
        local x2 = __lux_match_59.x2
        local y2 = __lux_match_59.y2
        do
          local __lux_tmp_61 = x1
          if __lux_tmp_61 == nil then
            __lux_tmp_61 = 0
          end
          p0 = __lux_tmp_61
        end
        do
          local __lux_tmp_62 = y1
          if __lux_tmp_62 == nil then
            __lux_tmp_62 = 0
          end
          p1 = __lux_tmp_62
        end
        do
          local __lux_tmp_63 = x2
          if __lux_tmp_63 == nil then
            __lux_tmp_63 = 1
          end
          p2 = __lux_tmp_63
        end
        do
          local __lux_tmp_64 = y2
          if __lux_tmp_64 == nil then
            __lux_tmp_64 = 1
          end
          p3 = __lux_tmp_64
        end
        style.bindGradientLut(material, fill)
      elseif __lux_tag_60 == style.FILL_RADIAL then
        local cx = __lux_match_59.cx
        local cy = __lux_match_59.cy
        local radius = __lux_match_59.radius
        do
          local __lux_tmp_65 = cx
          if __lux_tmp_65 == nil then
            __lux_tmp_65 = 0.5
          end
          p0 = __lux_tmp_65
        end
        do
          local __lux_tmp_66 = cy
          if __lux_tmp_66 == nil then
            __lux_tmp_66 = 0.5
          end
          p1 = __lux_tmp_66
        end
        do
          local __lux_tmp_67 = radius
          if __lux_tmp_67 == nil then
            __lux_tmp_67 = 0.5
          end
          p2 = __lux_tmp_67
        end
        p3 = 0
        style.bindGradientLut(material, fill)
      elseif __lux_tag_60 == style.FILL_CONIC then
        local cx = __lux_match_59.cx
        local cy = __lux_match_59.cy
        local rotation = __lux_match_59.rotation
        do
          local __lux_tmp_68 = cx
          if __lux_tmp_68 == nil then
            __lux_tmp_68 = 0.5
          end
          p0 = __lux_tmp_68
        end
        do
          local __lux_tmp_69 = cy
          if __lux_tmp_69 == nil then
            __lux_tmp_69 = 0.5
          end
          p1 = __lux_tmp_69
        end
        p2 = style.normalizedRotation(rotation)
        p3 = 0
        style.bindGradientLut(material, fill)
      else
        local __lux_unused_70 = nil
      end
      return p0, p1, p2, p3
    end
    setupParamMatrix = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3)
      local __lux_tmp_71 = material == nil
      if not __lux_tmp_71 then
        __lux_tmp_71 = paramMatrixSetUnpacked == nil
      end
      local __lux_tmp_72 = __lux_tmp_71
      if not __lux_tmp_72 then
        __lux_tmp_72 = matrixCtor == nil
      end
      if __lux_tmp_72 then
        return false
      end
      local matrix = paramMatrices[material]
      if matrix == nil then
        matrix = matrixCtor()
        paramMatrices[material] = matrix
      end
      do
        local __lux_tmp_73 = a0
        if __lux_tmp_73 == nil then
          __lux_tmp_73 = 0
        end
        local __lux_tmp_74 = b0
        if __lux_tmp_74 == nil then
          __lux_tmp_74 = 0
        end
        local __lux_tmp_75 = c0
        if __lux_tmp_75 == nil then
          __lux_tmp_75 = 0
        end
        local __lux_tmp_76 = d0
        if __lux_tmp_76 == nil then
          __lux_tmp_76 = 0
        end
        local __lux_tmp_77 = a1
        if __lux_tmp_77 == nil then
          __lux_tmp_77 = 0
        end
        local __lux_tmp_78 = b1
        if __lux_tmp_78 == nil then
          __lux_tmp_78 = 0
        end
        local __lux_tmp_79 = c1
        if __lux_tmp_79 == nil then
          __lux_tmp_79 = 0
        end
        local __lux_tmp_80 = d1
        if __lux_tmp_80 == nil then
          __lux_tmp_80 = 0
        end
        local __lux_tmp_81 = a2
        if __lux_tmp_81 == nil then
          __lux_tmp_81 = 0
        end
        local __lux_tmp_82 = b2
        if __lux_tmp_82 == nil then
          __lux_tmp_82 = 0
        end
        local __lux_tmp_83 = c2
        if __lux_tmp_83 == nil then
          __lux_tmp_83 = 0
        end
        local __lux_tmp_84 = d2
        if __lux_tmp_84 == nil then
          __lux_tmp_84 = 0
        end
        local __lux_tmp_85 = a3
        if __lux_tmp_85 == nil then
          __lux_tmp_85 = 0
        end
        local __lux_tmp_86 = b3
        if __lux_tmp_86 == nil then
          __lux_tmp_86 = 0
        end
        local __lux_tmp_87 = c3
        if __lux_tmp_87 == nil then
          __lux_tmp_87 = 0
        end
        local __lux_tmp_88 = d3
        if __lux_tmp_88 == nil then
          __lux_tmp_88 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_73,
          __lux_tmp_74,
          __lux_tmp_75,
          __lux_tmp_76,
          __lux_tmp_77,
          __lux_tmp_78,
          __lux_tmp_79,
          __lux_tmp_80,
          __lux_tmp_81,
          __lux_tmp_82,
          __lux_tmp_83,
          __lux_tmp_84,
          __lux_tmp_85,
          __lux_tmp_86,
          __lux_tmp_87,
          __lux_tmp_88
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
        local __lux_tmp_89 = a0
        if __lux_tmp_89 == nil then
          __lux_tmp_89 = 0
        end
        material:SetFloat("$c0_x", __lux_tmp_89)
      end
      do
        local __lux_tmp_90 = a1
        if __lux_tmp_90 == nil then
          __lux_tmp_90 = 0
        end
        material:SetFloat("$c0_y", __lux_tmp_90)
      end
      do
        local __lux_tmp_91 = a2
        if __lux_tmp_91 == nil then
          __lux_tmp_91 = 0
        end
        material:SetFloat("$c0_z", __lux_tmp_91)
      end
      do
        local __lux_tmp_92 = a3
        if __lux_tmp_92 == nil then
          __lux_tmp_92 = 0
        end
        material:SetFloat("$c0_w", __lux_tmp_92)
      end
      do
        local __lux_tmp_93 = b0
        if __lux_tmp_93 == nil then
          __lux_tmp_93 = 0
        end
        material:SetFloat("$c1_x", __lux_tmp_93)
      end
      do
        local __lux_tmp_94 = b1
        if __lux_tmp_94 == nil then
          __lux_tmp_94 = 0
        end
        material:SetFloat("$c1_y", __lux_tmp_94)
      end
      do
        local __lux_tmp_95 = b2
        if __lux_tmp_95 == nil then
          __lux_tmp_95 = 0
        end
        material:SetFloat("$c1_z", __lux_tmp_95)
      end
      do
        local __lux_tmp_96 = b3
        if __lux_tmp_96 == nil then
          __lux_tmp_96 = 0
        end
        material:SetFloat("$c1_w", __lux_tmp_96)
      end
      do
        local __lux_tmp_97 = c0
        if __lux_tmp_97 == nil then
          __lux_tmp_97 = 0
        end
        material:SetFloat("$c2_x", __lux_tmp_97)
      end
      do
        local __lux_tmp_98 = c1
        if __lux_tmp_98 == nil then
          __lux_tmp_98 = 0
        end
        material:SetFloat("$c2_y", __lux_tmp_98)
      end
      do
        local __lux_tmp_99 = c2
        if __lux_tmp_99 == nil then
          __lux_tmp_99 = 0
        end
        material:SetFloat("$c2_z", __lux_tmp_99)
      end
      do
        local __lux_tmp_100 = c3
        if __lux_tmp_100 == nil then
          __lux_tmp_100 = 0
        end
        material:SetFloat("$c2_w", __lux_tmp_100)
      end
      do
        local __lux_tmp_101 = d0
        if __lux_tmp_101 == nil then
          __lux_tmp_101 = 0
        end
        material:SetFloat("$c3_x", __lux_tmp_101)
      end
      do
        local __lux_tmp_102 = d1
        if __lux_tmp_102 == nil then
          __lux_tmp_102 = 0
        end
        material:SetFloat("$c3_y", __lux_tmp_102)
      end
      do
        local __lux_tmp_103 = d2
        if __lux_tmp_103 == nil then
          __lux_tmp_103 = 0
        end
        material:SetFloat("$c3_z", __lux_tmp_103)
      end
      do
        local __lux_tmp_104 = d3
        if __lux_tmp_104 == nil then
          __lux_tmp_104 = 0
        end
        material:SetFloat("$c3_w", __lux_tmp_104)
      end
      return true
    end
    setupConstants = function(material, w, h, fill, stroke, strokeWidth, radius)
      if material == nil then
        return false
      end
      do
        local __lux_tmp_105 = fill
        if __lux_tmp_105 == nil then
          __lux_tmp_105 = style.solid(color_white)
        end
        fill = __lux_tmp_105
      end
      local colorA
      do
        local __lux_tmp_106 = fill.colorA
        if __lux_tmp_106 == nil then
          __lux_tmp_106 = color_white
        end
        colorA = __lux_tmp_106
      end
      local colorB
      do
        local __lux_tmp_107 = fill.colorB
        if __lux_tmp_107 == nil then
          __lux_tmp_107 = colorA
        end
        colorB = __lux_tmp_107
      end
      local strokeColor
      do
        local __lux_tmp_108 = stroke
        if __lux_tmp_108 == nil then
          __lux_tmp_108 = transparentColor
        end
        strokeColor = __lux_tmp_108
      end
      local fillKind
      do
        local __lux_tmp_109 = fill.kind
        if __lux_tmp_109 == nil then
          __lux_tmp_109 = style.FILL_SOLID
        end
        fillKind = __lux_tmp_109
      end
      local packedStyle = mathClamp(style.strokeWidth(strokeWidth, 0), 0, 255) + mathClamp(fillKind, 0, 3) * 256
      local r, g, b, a = style.color01(colorB)
      local p0, p1, p2, p3 = roundRectFillParams(material, fill)
      local sr, sg, sb, sa = style.color01(strokeColor)
      do
        local __lux_tmp_110 = toNumber(radius)
        if __lux_tmp_110 == nil then
          __lux_tmp_110 = 0
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
          mathMax(0, __lux_tmp_110),
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
        local __lux_tmp_111 = pattern.color
        if __lux_tmp_111 == nil then
          __lux_tmp_111 = pattern.tint
        end
        color = style.asColor(__lux_tmp_111, makeColor(255, 255, 255, 24))
      end
      local r, g, b, a = style.color01(color)
      local angle
      do
        local __lux_tmp_112 = toNumber(pattern.angle)
        if __lux_tmp_112 == nil then
          __lux_tmp_112 = 135
        end
        angle = mathRad(__lux_tmp_112)
      end
      local smoke
      local __lux_match_113 = pattern.kind
      if __lux_match_113 == "smoke" then
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
          local __lux_tmp_114 = toNumber(pattern.scale)
          if __lux_tmp_114 == nil then
            __lux_tmp_114 = 140
          end
          pz = mathMax(1, __lux_tmp_114)
        end
        do
          local __lux_tmp_115 = toNumber(pattern.density)
          if __lux_tmp_115 == nil then
            __lux_tmp_115 = 0.48
          end
          pw = mathClamp(__lux_tmp_115, 0, 1)
        end
        ox = patternOffset(pattern)
        oy = 1
        do
          local __lux_tmp_116 = toNumber(pattern.softness)
          if __lux_tmp_116 == nil then
            __lux_tmp_116 = 0.3
          end
          oz = mathMax(0.001, __lux_tmp_116)
        end
        do
          local __lux_tmp_117 = toNumber(pattern.warp)
          if __lux_tmp_117 == nil then
            __lux_tmp_117 = 0.85
          end
          ow = mathMax(0, __lux_tmp_117)
        end
      else
        do
          local __lux_tmp_118 = toNumber(pattern.spacing)
          if __lux_tmp_118 == nil then
            __lux_tmp_118 = 12
          end
          pz = mathMax(1, __lux_tmp_118)
        end
        do
          local __lux_tmp_119 = toNumber(pattern.width)
          if __lux_tmp_119 == nil then
            __lux_tmp_119 = 2
          end
          pw = mathMax(0.25, __lux_tmp_119)
        end
        ox = patternOffset(pattern)
      end
      local __lux_tmp_120
      if smoke then
        do
          local __lux_tmp_121 = toNumber(pattern.seed)
          if __lux_tmp_121 == nil then
            __lux_tmp_121 = 0
          end
          __lux_tmp_120 = __lux_tmp_121
        end
      else
        __lux_tmp_120 = 0
      end
      local __lux_tmp_122 = toNumber(radius)
      if __lux_tmp_122 == nil then
        __lux_tmp_122 = 0
      end
      return setupParamMatrix(
        material,
        r,
        g,
        b,
        a,
        w,
        h,
        __lux_tmp_120,
        mathMax(0, __lux_tmp_122),
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
      local __lux_tmp_123 = spec == nil
      if not __lux_tmp_123 then
        __lux_tmp_123 = not shadersActive()
      end
      local __lux_tmp_124 = __lux_tmp_123
      if not __lux_tmp_124 then
        __lux_tmp_124 = not materialOK(roundRectMaterials.roundrect_pattern)
      end
      if __lux_tmp_124 then
        return false
      end
      local color
      do
        local __lux_tmp_125 = spec.color
        if __lux_tmp_125 == nil then
          __lux_tmp_125 = spec.tint
        end
        color = __lux_tmp_125
      end
      local __lux_tmp_126 = color ~= nil
      if __lux_tmp_126 then
        local __lux_tmp_127 = color.a
        if __lux_tmp_127 == nil then
          __lux_tmp_127 = 255
        end
        __lux_tmp_126 = __lux_tmp_127 <= 0
      end
      if __lux_tmp_126 then
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
      local __lux_tmp_128 = spec == nil
      if not __lux_tmp_128 then
        __lux_tmp_128 = spec.color == nil
      end
      local __lux_tmp_129 = __lux_tmp_128
      if not __lux_tmp_129 then
        local __lux_tmp_130 = spec.color.a
        if __lux_tmp_130 == nil then
          __lux_tmp_130 = 255
        end
        __lux_tmp_129 = __lux_tmp_130 <= 0
      end
      local __lux_tmp_131 = __lux_tmp_129
      if not __lux_tmp_131 then
        __lux_tmp_131 = not shadersActive()
      end
      local __lux_tmp_132 = __lux_tmp_131
      if not __lux_tmp_132 then
        __lux_tmp_132 = not materialOK(roundRectMaterials.roundrect_innerglow)
      end
      if __lux_tmp_132 then
        return false
      end
      local material = roundRectMaterials.roundrect_innerglow
      local r, g, b, a = style.color01(spec.color)
      do
        local __lux_tmp_133 = toNumber(spec.width)
        if __lux_tmp_133 == nil then
          __lux_tmp_133 = 8
        end
        local __lux_tmp_134 = toNumber(spec.strength)
        if __lux_tmp_134 == nil then
          __lux_tmp_134 = 1
        end
        local __lux_tmp_135 = toNumber(spec.falloff)
        if __lux_tmp_135 == nil then
          __lux_tmp_135 = 1.65
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
          mathMax(0.001, __lux_tmp_133),
          mathMax(0, __lux_tmp_134),
          mathMax(0.001, __lux_tmp_135),
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
      local __lux_tmp_136 = spec == nil
      if not __lux_tmp_136 then
        __lux_tmp_136 = spec.color == nil
      end
      local __lux_tmp_137 = __lux_tmp_136
      if not __lux_tmp_137 then
        local __lux_tmp_138 = spec.color.a
        if __lux_tmp_138 == nil then
          __lux_tmp_138 = 255
        end
        __lux_tmp_137 = __lux_tmp_138 <= 0
      end
      local __lux_tmp_139 = __lux_tmp_137
      if not __lux_tmp_139 then
        __lux_tmp_139 = not shadersActive()
      end
      local __lux_tmp_140 = __lux_tmp_139
      if not __lux_tmp_140 then
        __lux_tmp_140 = not materialOK(roundRectMaterials.roundrect_outerglow)
      end
      if __lux_tmp_140 then
        return false
      end
      local spread
      do
        local __lux_tmp_141 = spec.spread
        if __lux_tmp_141 == nil then
          __lux_tmp_141 = spec.width
        end
        local __lux_tmp_142 = toNumber(__lux_tmp_141)
        if __lux_tmp_142 == nil then
          __lux_tmp_142 = 18
        end
        spread = mathMax(1, __lux_tmp_142)
      end
      local sw = w + spread * 2
      local sh = h + spread * 2
      local material = roundRectMaterials.roundrect_outerglow
      local r, g, b, a = style.color01(spec.color)
      do
        local __lux_tmp_143 = toNumber(spec.width)
        if __lux_tmp_143 == nil then
          __lux_tmp_143 = spread
        end
        local __lux_tmp_144 = toNumber(spec.strength)
        if __lux_tmp_144 == nil then
          __lux_tmp_144 = 1
        end
        local __lux_tmp_145 = toNumber(spec.falloff)
        if __lux_tmp_145 == nil then
          __lux_tmp_145 = 1.9
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
          mathMax(0.001, __lux_tmp_143),
          mathMax(0, __lux_tmp_144),
          mathMax(0.001, __lux_tmp_145)
        )
      end
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(x - spread, y - spread, sw, sh)
      return true
    end
    backdropTintColor = function(spec)
      local __lux_tmp_146 = spec == nil
      if not __lux_tmp_146 then
        __lux_tmp_146 = spec.tint == nil
      end
      if __lux_tmp_146 then
        return nil
      end
      local tint = spec.tint
      local alpha
      do
        local __lux_tmp_147 = tint.a
        if __lux_tmp_147 == nil then
          __lux_tmp_147 = 255
        end
        local __lux_tmp_148 = spec.opacity
        if __lux_tmp_148 == nil then
          __lux_tmp_148 = 1
        end
        alpha = __lux_tmp_147 * __lux_tmp_148
      end
      if alpha <= 0 then
        return nil
      end
      local __lux_tmp_149 = tint.r
      if __lux_tmp_149 == nil then
        __lux_tmp_149 = 0
      end
      local __lux_tmp_150 = tint.g
      if __lux_tmp_150 == nil then
        __lux_tmp_150 = 0
      end
      local __lux_tmp_151 = tint.b
      if __lux_tmp_151 == nil then
        __lux_tmp_151 = 0
      end
      return makeColor(
        __lux_tmp_149,
        __lux_tmp_150,
        __lux_tmp_151,
        mathFloor(mathClamp(alpha, 0, 255) + 0.5)
      )
    end
    drawRoundRectBackdrop = function(x, y, w, h, radius, backdrop)
      local spec = style.backdropStyle(backdrop)
      if spec == nil then
        return nil
      end
      local __lux_tmp_152 = spec.blur > 0
      if __lux_tmp_152 then
        __lux_tmp_152 = roundRectBlurRT ~= nil
      end
      local __lux_tmp_153 = __lux_tmp_152
      if __lux_tmp_153 then
        __lux_tmp_153 = renderCopyRenderTargetToTexture ~= nil
      end
      local __lux_tmp_154 = __lux_tmp_153
      if __lux_tmp_154 then
        __lux_tmp_154 = materialOK(roundRectMaterials.roundrect_blur)
      end
      if __lux_tmp_154 then
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
          local __lux_tmp_155 = innerSpec.color
          if __lux_tmp_155 == nil then
            __lux_tmp_155 = transparentColor
          end
          gr, gg, gb, ga = style.color01(__lux_tmp_155)
        end
        do
          local __lux_tmp_156 = toNumber(innerSpec.width)
          if __lux_tmp_156 == nil then
            __lux_tmp_156 = 8
          end
          glowWidth = mathMax(0.001, __lux_tmp_156)
        end
        do
          local __lux_tmp_157 = toNumber(innerSpec.strength)
          if __lux_tmp_157 == nil then
            __lux_tmp_157 = 1
          end
          glowStrength = mathMax(0, __lux_tmp_157)
        end
        do
          local __lux_tmp_158 = toNumber(innerSpec.falloff)
          if __lux_tmp_158 == nil then
            __lux_tmp_158 = 1.65
          end
          glowFalloff = mathMax(0.001, __lux_tmp_158)
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
      local radius
      do
        local __lux_tmp_159 = drawStyle.radius
        if __lux_tmp_159 == nil then
          local __lux_tmp_160 = drawStyle.r
          if __lux_tmp_160 == nil then
            __lux_tmp_160 = 0
          end
          __lux_tmp_159 = __lux_tmp_160
        end
        radius = __lux_tmp_159
      end
      local outer = outerGlowStyle(drawStyle.outerGlow)
      if outer ~= nil then
        drawRoundRectOuterGlowSpec(x, y, w, h, radius, outer)
      end
      local __lux_tmp_161 = drawStyle.shadow ~= nil
      if __lux_tmp_161 then
        __lux_tmp_161 = drawStyle.shadow.color ~= nil
      end
      local __lux_tmp_162 = __lux_tmp_161
      if __lux_tmp_162 then
        local __lux_tmp_163 = drawStyle.shadow.color.a
        if __lux_tmp_163 == nil then
          __lux_tmp_163 = 255
        end
        __lux_tmp_162 = __lux_tmp_163 > 0
      end
      if __lux_tmp_162 then
        local shadow = drawStyle.shadow
        local spread
        do
          local __lux_tmp_164 = toNumber(shadow.blur)
          if __lux_tmp_164 == nil then
            __lux_tmp_164 = 12
          end
          spread = mathMax(1, __lux_tmp_164)
        end
        do
          local __lux_tmp_165 = shadow.x
          if __lux_tmp_165 == nil then
            __lux_tmp_165 = 0
          end
          local __lux_tmp_166 = shadow.y
          if __lux_tmp_166 == nil then
            __lux_tmp_166 = 0
          end
          drawRoundRectFillPass(
            x + __lux_tmp_165 - spread,
            y + __lux_tmp_166 - spread,
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
        local __lux_tmp_167 = drawStyle.fill
        if __lux_tmp_167 == nil then
          __lux_tmp_167 = drawStyle.color
        end
        fill = style.fillFromStyle(__lux_tmp_167)
      end
      local strokeWidth = style.strokeWidth(drawStyle.strokeWidth, 0)
      local hasFill = style.fillVisible(fill)
      local hasStroke = style.strokeVisible(drawStyle.stroke, strokeWidth)
      local inner = innerGlowStyle(drawStyle.innerGlow)
      local __lux_tmp_168 = backdrop == nil
      if __lux_tmp_168 then
        __lux_tmp_168 = not hasFill
      end
      local __lux_tmp_169 = __lux_tmp_168
      if __lux_tmp_169 then
        __lux_tmp_169 = not hasStroke
      end
      local __lux_tmp_170 = __lux_tmp_169
      if __lux_tmp_170 then
        __lux_tmp_170 = drawStyle.pattern == nil
      end
      local __lux_tmp_171 = __lux_tmp_170
      if __lux_tmp_171 then
        __lux_tmp_171 = inner == nil
      end
      if __lux_tmp_171 then
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
        local __lux_tmp_172 = hasStroke
        if not __lux_tmp_172 then
          __lux_tmp_172 = inner ~= nil
        end
        local __lux_tmp_173 = __lux_tmp_172
        if __lux_tmp_173 then
          __lux_tmp_173 = drawRoundRectFxPass(x, y, w, h, radius, fill, drawStyle.stroke, strokeWidth, inner)
        end
        if __lux_tmp_173 then
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
      local resolved
      do
        local __lux_tmp_174 = drawStyle
        if __lux_tmp_174 == nil then
          __lux_tmp_174 = {}
        end
        resolved = __lux_tmp_174
      end
      if drawRoundRectShader(x, y, w, h, resolved) then
        return
      end
      local radius
      do
        local __lux_tmp_175 = resolved.radius
        if __lux_tmp_175 == nil then
          local __lux_tmp_176 = resolved.r
          if __lux_tmp_176 == nil then
            __lux_tmp_176 = 0
          end
          __lux_tmp_175 = __lux_tmp_176
        end
        radius = style.radiusScalar(__lux_tmp_175, w, h)
      end
      local fill
      do
        local __lux_tmp_177 = resolved.fill
        if __lux_tmp_177 == nil then
          __lux_tmp_177 = resolved.color
        end
        fill = style.fillFromStyle(__lux_tmp_177)
      end
      local fillVisible = style.fillVisible(fill)
      local strokeWidth = style.strokeWidth(resolved.strokeWidth, 0)
      local strokeVisible = style.strokeVisible(resolved.stroke, strokeWidth)
      local outer = outerGlowStyle(resolved.outerGlow)
      local __lux_tmp_178 = outer ~= nil
      if __lux_tmp_178 then
        __lux_tmp_178 = outer.color ~= nil
      end
      if __lux_tmp_178 then
        local outerAlpha = style.alpha(outer.color.a)
        if outerAlpha > 0 then
          local spread
          do
            local __lux_tmp_179 = outer.spread
            if __lux_tmp_179 == nil then
              __lux_tmp_179 = outer.width
            end
            local __lux_tmp_180 = toNumber(__lux_tmp_179)
            if __lux_tmp_180 == nil then
              __lux_tmp_180 = 18
            end
            spread = mathMax(1, __lux_tmp_180)
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
      local resolved
      do
        local __lux_tmp_181 = drawStyle
        if __lux_tmp_181 == nil then
          __lux_tmp_181 = {}
        end
        resolved = __lux_tmp_181
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
        local __lux_tmp_182 = drawStyle
        if __lux_tmp_182 == nil then
          __lux_tmp_182 = {}
        end
        resolved = copyInto(circleStyle, __lux_tmp_182)
      end
      resolved.radius = radius
      return roundedBoxEx(cx - radius, cy - radius, radius * 2, radius * 2, resolved)
    end
    capsule = function(x, y, w, h, fill, stroke, strokeWidth)
      return roundedBox(x, y, w, h, mathMin(w, h) * 0.5, fill, stroke, strokeWidth)
    end
    capsuleEx = function(x, y, w, h, drawStyle)
      local resolved = drawStyle
      local __lux_tmp_183 = resolved == nil
      if not __lux_tmp_183 then
        __lux_tmp_183 = resolved.radius == nil
      end
      if __lux_tmp_183 then
        do
          local __lux_tmp_184 = drawStyle
          if __lux_tmp_184 == nil then
            __lux_tmp_184 = {}
          end
          resolved = copyInto(capsuleStyle, __lux_tmp_184)
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
