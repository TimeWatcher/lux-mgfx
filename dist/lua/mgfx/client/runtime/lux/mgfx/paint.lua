return function(__lux_import)
  local __lux_exports = {}
  local frame
  local geometry
  local style
  local geometryDrawTexturedRectUV
  local geometryDrawTransformedPoly
  local geometryImageFitRect
  local geometryImageStyle
  local geometryImageTint
  local geometryImageUV
  local drawRoundedBox
  local surfaceSetDrawColor
  local surfaceDrawOutlinedRect
  local surfaceDrawRect
  local surfaceDrawLine
  local surfaceSetMaterial
  local mathClamp
  local mathCos
  local mathFloor
  local mathMax
  local mathMin
  local mathPi
  local mathRad
  local mathSin
  local mathSqrt
  local makeColor
  local makeMaterial
  local toNumber
  local typeOf
  local fillColor
  local setColor
  local strokeRect
  local rectFill
  local circlePoly
  local roundedBoxEx
  local roundedBox
  local chamferBoxEx
  local chamferBox
  local polyEx
  local poly
  local lineEx
  local line
  local circleEx
  local circle
  local capsuleEx
  local capsule
  local progressBarEx
  local progressBar
  local segmentBarEx
  local segmentBar
  local ringEx
  local ring
  local arcEx
  local arc
  local sectorEx
  local sector
  local imageEx
  local image
  local iconEx
  local icon
  local install
  do
    local __lux_import_1 = __lux_import("lux/mgfx/frame#client")
    local frameImport = __lux_import_1
    local __lux_import_2 = __lux_import("lux/mgfx/geometry#client")
    local geometryImport = __lux_import_2
    local __lux_import_3 = __lux_import("lux/mgfx/style#client")
    local styleImport = __lux_import_3
    frame = frameImport
    geometry = geometryImport
    style = styleImport
    geometryDrawTexturedRectUV = geometry.drawTexturedRectUV
    geometryDrawTransformedPoly = geometry.drawTransformedPoly
    geometryImageFitRect = geometry.imageFitRect
    geometryImageStyle = geometry.imageStyle
    geometryImageTint = geometry.imageTint
    geometryImageUV = geometry.imageUV
    drawRoundedBox = _G.draw.RoundedBox
    surfaceSetDrawColor = surface.SetDrawColor
    surfaceDrawOutlinedRect = surface.DrawOutlinedRect
    surfaceDrawRect = surface.DrawRect
    surfaceDrawLine = surface.DrawLine
    surfaceSetMaterial = surface.SetMaterial
    mathClamp = math.Clamp
    mathCos = math.cos
    mathFloor = math.floor
    mathMax = math.max
    mathMin = math.min
    mathPi = math.pi
    mathRad = math.rad
    mathSin = math.sin
    mathSqrt = math.sqrt
    makeColor = Color
    makeMaterial = Material
    toNumber = tonumber
    typeOf = type
    fillColor = function(fill, fallback)
      if style.isColor(fill) then
        return fill
      end
      if typeOf(fill) == "table" then
        local __lux_tmp_4 = fill.colorA
        if __lux_tmp_4 == nil then
          local __lux_tmp_5 = fill.color
          if __lux_tmp_5 == nil then
            local __lux_tmp_6 = fallback
            if __lux_tmp_6 == nil then
              __lux_tmp_6 = color_white
            end
            __lux_tmp_5 = __lux_tmp_6
          end
          __lux_tmp_4 = __lux_tmp_5
        end
        return __lux_tmp_4
      end
      local __lux_tmp_7 = fallback
      if __lux_tmp_7 == nil then
        __lux_tmp_7 = color_white
      end
      return __lux_tmp_7
    end
    setColor = function(color)
      local c = style.colorOr(color)
      local __lux_tmp_8 = c.r
      if __lux_tmp_8 == nil then
        __lux_tmp_8 = 255
      end
      local __lux_tmp_9 = c.g
      if __lux_tmp_9 == nil then
        __lux_tmp_9 = 255
      end
      local __lux_tmp_10 = c.b
      if __lux_tmp_10 == nil then
        __lux_tmp_10 = 255
      end
      return surfaceSetDrawColor(__lux_tmp_8, __lux_tmp_9, __lux_tmp_10, style.alpha(c.a))
    end
    strokeRect = function(x, y, w, h, stroke, width)
      local strokeW = mathFloor(style.strokeWidth(width, 1))
      if not style.strokeVisible(stroke, strokeW) then
        return
      end
      setColor(stroke)
      for index = 0, strokeW - 1 do
        surfaceDrawOutlinedRect(x + index, y + index, w - index * 2, h - index * 2)
      end
    end
    rectFill = function(x, y, w, h, fill)
      if not style.fillVisible(fill) then
        return
      end
      setColor(fillColor(fill))
      return surfaceDrawRect(x, y, w, h)
    end
    circlePoly = function(cx, cy, radius, segments)
      if segments == nil then
        segments = 48
      end
      local out = {}
      for index = 1, segments do
        local angle = mathRad((index - 1) / segments * 360)
        out[index] = { x = cx + mathCos(angle) * radius, y = cy + mathSin(angle) * radius }
      end
      return out
    end
  end
  do
    roundedBoxEx = function(x, y, w, h, drawStyle)
      local resolved
      do
        local __lux_tmp_11 = drawStyle
        if __lux_tmp_11 == nil then
          __lux_tmp_11 = {}
        end
        resolved = __lux_tmp_11
      end
      local radius
      do
        local __lux_tmp_12 = resolved.radius
        if __lux_tmp_12 == nil then
          local __lux_tmp_13 = resolved.r
          if __lux_tmp_13 == nil then
            __lux_tmp_13 = 0
          end
          __lux_tmp_12 = __lux_tmp_13
        end
        radius = style.radiusScalar(__lux_tmp_12, w, h)
      end
      local fill
      do
        local __lux_tmp_14 = resolved.fill
        if __lux_tmp_14 == nil then
          __lux_tmp_14 = resolved.color
        end
        fill = __lux_tmp_14
      end
      local stroke = resolved.stroke
      local strokeWidth = resolved.strokeWidth
      if style.fillVisible(fill) then
        drawRoundedBox(radius, x, y, w, h, fillColor(fill))
      end
      return strokeRect(x, y, w, h, stroke, strokeWidth)
    end
    roundedBox = function(x, y, w, h, radius, fill, stroke, strokeWidth)
      return roundedBoxEx(
        x,
        y,
        w,
        h,
        { radius = radius, fill = fill, stroke = stroke, strokeWidth = strokeWidth }
      )
    end
    chamferBoxEx = function(x, y, w, h, drawStyle)
      local resolved
      do
        local __lux_tmp_15 = drawStyle
        if __lux_tmp_15 == nil then
          __lux_tmp_15 = {}
        end
        resolved = __lux_tmp_15
      end
      local cuts
      do
        local __lux_tmp_16 = resolved.cuts
        if __lux_tmp_16 == nil then
          __lux_tmp_16 = 0
        end
        cuts = __lux_tmp_16
      end
      local tl, tr, br, bl = style.radiusTuple(cuts, w, h)
      local points = {
        { x = x + tl, y = y },
        { x = x + w - tr, y = y },
        { x = x + w, y = y + tr },
        { x = x + w, y = y + h - br },
        { x = x + w - br, y = y + h },
        { x = x + bl, y = y + h },
        { x = x, y = y + h - bl },
        { x = x, y = y + tl },
      }
      return polyEx(points, resolved)
    end
    chamferBox = function(x, y, w, h, cuts, fill, stroke, strokeWidth)
      return chamferBoxEx(
        x,
        y,
        w,
        h,
        { cuts = cuts, fill = fill, stroke = stroke, strokeWidth = strokeWidth }
      )
    end
    polyEx = function(points, drawStyle)
      local resolved
      do
        local __lux_tmp_17 = drawStyle
        if __lux_tmp_17 == nil then
          __lux_tmp_17 = {}
        end
        resolved = __lux_tmp_17
      end
      local fill
      do
        local __lux_tmp_18 = resolved.fill
        if __lux_tmp_18 == nil then
          __lux_tmp_18 = resolved.color
        end
        fill = __lux_tmp_18
      end
      if style.fillVisible(fill) then
        setColor(fillColor(fill))
        geometryDrawTransformedPoly(points)
      end
    end
    poly = function(points, fill, stroke, strokeWidth)
      return polyEx(points, { fill = fill, stroke = stroke, strokeWidth = strokeWidth })
    end
    lineEx = function(x1, y1, x2, y2, drawStyle)
      local resolved
      do
        local __lux_tmp_19 = drawStyle
        if __lux_tmp_19 == nil then
          __lux_tmp_19 = {}
        end
        resolved = __lux_tmp_19
      end
      local width
      do
        local __lux_tmp_20 = resolved.width
        if __lux_tmp_20 == nil then
          __lux_tmp_20 = resolved.strokeWidth
        end
        width = mathMax(1, mathFloor(style.strokeWidth(__lux_tmp_20, 1)))
      end
      local fill
      do
        local __lux_tmp_21 = resolved.fill
        if __lux_tmp_21 == nil then
          local __lux_tmp_22 = resolved.color
          if __lux_tmp_22 == nil then
            __lux_tmp_22 = resolved.stroke
          end
          __lux_tmp_21 = __lux_tmp_22
        end
        fill = fillColor(__lux_tmp_21)
      end
      setColor(fill)
      if width <= 1 then
        surfaceDrawLine(x1, y1, x2, y2)
        return
      end
      local dx = x2 - x1
      local dy = y2 - y1
      local len = mathMax(0.0001, mathSqrt(dx * dx + dy * dy))
      local nx = -dy / len * width * 0.5
      local ny = dx / len * width * 0.5
      return geometryDrawTransformedPoly(
        {
          { x = x1 + nx, y = y1 + ny },
          { x = x2 + nx, y = y2 + ny },
          { x = x2 - nx, y = y2 - ny },
          { x = x1 - nx, y = y1 - ny },
        }
      )
    end
    line = function(x1, y1, x2, y2, width, fill)
      if width == nil then
        width = 1
      end
      return lineEx(x1, y1, x2, y2, { width = width, fill = fill })
    end
    circleEx = function(cx, cy, radius, drawStyle)
      local resolved
      do
        local __lux_tmp_23 = drawStyle
        if __lux_tmp_23 == nil then
          __lux_tmp_23 = {}
        end
        resolved = __lux_tmp_23
      end
      local points
      do
        local __lux_tmp_24 = resolved.segments
        if __lux_tmp_24 == nil then
          __lux_tmp_24 = 48
        end
        points = circlePoly(cx, cy, radius, __lux_tmp_24)
      end
      return polyEx(points, resolved)
    end
    circle = function(cx, cy, radius, fill, stroke, strokeWidth)
      return circleEx(cx, cy, radius, { fill = fill, stroke = stroke, strokeWidth = strokeWidth })
    end
    capsuleEx = function(x, y, w, h, drawStyle)
      local radius = mathMin(w, h) * 0.5
      local __lux_table_25 = {}
      local __lux_tmp_26 = drawStyle
      if __lux_tmp_26 == nil then
        __lux_tmp_26 = {}
      end
      local __lux_spread_27 = __lux_tmp_26
      if __lux_spread_27 ~= nil then
        for __lux_k_28, __lux_v_29 in pairs(__lux_spread_27) do
          __lux_table_25[__lux_k_28] = __lux_v_29
        end
      end
      __lux_table_25.radius = radius
      return roundedBoxEx(x, y, w, h, __lux_table_25)
    end
    capsule = function(x, y, w, h, fill, stroke, strokeWidth)
      return capsuleEx(x, y, w, h, { fill = fill, stroke = stroke, strokeWidth = strokeWidth })
    end
  end
  do
    progressBarEx = function(x, y, w, h, value, drawStyle)
      local resolved
      do
        local __lux_tmp_30 = drawStyle
        if __lux_tmp_30 == nil then
          __lux_tmp_30 = {}
        end
        resolved = __lux_tmp_30
      end
      local amount
      do
        local __lux_tmp_31 = toNumber(value)
        if __lux_tmp_31 == nil then
          __lux_tmp_31 = 0
        end
        amount = mathClamp(__lux_tmp_31, 0, 1)
      end
      local radius
      do
        local __lux_tmp_32 = resolved.radius
        if __lux_tmp_32 == nil then
          __lux_tmp_32 = h * 0.5
        end
        radius = __lux_tmp_32
      end
      do
        local __lux_tmp_33 = resolved.track
        if __lux_tmp_33 == nil then
          __lux_tmp_33 = makeColor(0, 0, 0, 120)
        end
        roundedBox(x, y, w, h, radius, __lux_tmp_33, resolved.stroke, resolved.strokeWidth)
      end
      if amount > 0 then
        do
          local __lux_tmp_34 = resolved.fill
          if __lux_tmp_34 == nil then
            __lux_tmp_34 = color_white
          end
          roundedBox(x, y, w * amount, h, radius, __lux_tmp_34)
        end
      end
    end
    progressBar = function(x, y, w, h, value, radius, track, fill, stroke, strokeWidth)
      return progressBarEx(
        x,
        y,
        w,
        h,
        value,
        {
          radius = radius,
          track = track,
          fill = fill,
          stroke = stroke,
          strokeWidth = strokeWidth,
        }
      )
    end
    segmentBarEx = function(x, y, w, h, value, drawStyle)
      local resolved
      do
        local __lux_tmp_35 = drawStyle
        if __lux_tmp_35 == nil then
          __lux_tmp_35 = {}
        end
        resolved = __lux_tmp_35
      end
      local segments
      do
        local __lux_tmp_36 = resolved.segments
        if __lux_tmp_36 == nil then
          __lux_tmp_36 = 10
        end
        segments = mathMax(1, mathFloor(__lux_tmp_36))
      end
      local gap
      do
        local __lux_tmp_37 = toNumber(resolved.gap)
        if __lux_tmp_37 == nil then
          __lux_tmp_37 = 2
        end
        gap = __lux_tmp_37
      end
      local amount
      do
        local __lux_tmp_38 = toNumber(value)
        if __lux_tmp_38 == nil then
          __lux_tmp_38 = 0
        end
        amount = mathClamp(__lux_tmp_38, 0, 1)
      end
      local segmentW = (w - gap * (segments - 1)) / segments
      for index = 1, segments do
        local sx = x + (index - 1) * (segmentW + gap)
        local filled = index / segments <= amount
        do
          local __lux_tmp_39 = resolved.radius
          if __lux_tmp_39 == nil then
            __lux_tmp_39 = h * 0.5
          end
          local __lux_tmp_40
          if filled then
            do
              local __lux_tmp_41 = resolved.fill
              if __lux_tmp_41 == nil then
                __lux_tmp_41 = color_white
              end
              __lux_tmp_40 = __lux_tmp_41
            end
          else
            do
              local __lux_tmp_42 = resolved.track
              if __lux_tmp_42 == nil then
                __lux_tmp_42 = makeColor(0, 0, 0, 100)
              end
              __lux_tmp_40 = __lux_tmp_42
            end
          end
          roundedBox(sx, y, segmentW, h, __lux_tmp_39, __lux_tmp_40)
        end
      end
    end
    segmentBar = function(x, y, w, h, value, segments, fill, track)
      return segmentBarEx(x, y, w, h, value, { segments = segments, fill = fill, track = track })
    end
    ringEx = function(cx, cy, radius, width, drawStyle)
      local resolved
      do
        local __lux_tmp_43 = drawStyle
        if __lux_tmp_43 == nil then
          __lux_tmp_43 = {}
        end
        resolved = __lux_tmp_43
      end
      local segments
      do
        local __lux_tmp_44 = resolved.segments
        if __lux_tmp_44 == nil then
          __lux_tmp_44 = 96
        end
        segments = mathFloor(__lux_tmp_44)
      end
      local fill
      do
        local __lux_tmp_45 = resolved.fill
        if __lux_tmp_45 == nil then
          __lux_tmp_45 = resolved.color
        end
        fill = fillColor(__lux_tmp_45)
      end
      for index = 1, segments do
        local a1 = (index - 1) / segments * mathPi * 2
        local a2 = index / segments * mathPi * 2
        lineEx(
          cx + mathCos(a1) * radius,
          cy + mathSin(a1) * radius,
          cx + mathCos(a2) * radius,
          cy + mathSin(a2) * radius,
          { width = width, fill = fill }
        )
      end
    end
    ring = function(cx, cy, radius, width, fill)
      return ringEx(cx, cy, radius, width, { fill = fill })
    end
    arcEx = function(cx, cy, radius, width, startDeg, endDeg, drawStyle)
      local resolved
      do
        local __lux_tmp_46 = drawStyle
        if __lux_tmp_46 == nil then
          __lux_tmp_46 = {}
        end
        resolved = __lux_tmp_46
      end
      local segments
      do
        local __lux_tmp_47 = resolved.segments
        if __lux_tmp_47 == nil then
          __lux_tmp_47 = 64
        end
        segments = mathMax(1, mathFloor(__lux_tmp_47))
      end
      local startRad
      do
        local __lux_tmp_48 = startDeg
        if __lux_tmp_48 == nil then
          __lux_tmp_48 = 0
        end
        startRad = mathRad(__lux_tmp_48)
      end
      local endRad
      do
        local __lux_tmp_49 = endDeg
        if __lux_tmp_49 == nil then
          __lux_tmp_49 = 360
        end
        endRad = mathRad(__lux_tmp_49)
      end
      local fill
      do
        local __lux_tmp_50 = resolved.fill
        if __lux_tmp_50 == nil then
          __lux_tmp_50 = resolved.color
        end
        fill = fillColor(__lux_tmp_50)
      end
      for index = 1, segments do
        local t1 = (index - 1) / segments
        local t2 = index / segments
        local a1 = startRad + (endRad - startRad) * t1
        local a2 = startRad + (endRad - startRad) * t2
        lineEx(
          cx + mathCos(a1) * radius,
          cy + mathSin(a1) * radius,
          cx + mathCos(a2) * radius,
          cy + mathSin(a2) * radius,
          { width = width, fill = fill }
        )
      end
    end
    arc = function(cx, cy, radius, startDeg, endDeg, width, fill)
      return arcEx(cx, cy, radius, width, startDeg, endDeg, { fill = fill })
    end
    sectorEx = function(cx, cy, innerRadius, outerRadius, startDeg, endDeg, drawStyle)
      local resolved
      do
        local __lux_tmp_51 = drawStyle
        if __lux_tmp_51 == nil then
          __lux_tmp_51 = {}
        end
        resolved = __lux_tmp_51
      end
      local segments
      do
        local __lux_tmp_52 = resolved.segments
        if __lux_tmp_52 == nil then
          __lux_tmp_52 = 64
        end
        segments = mathMax(3, mathFloor(__lux_tmp_52))
      end
      local startRad
      do
        local __lux_tmp_53 = startDeg
        if __lux_tmp_53 == nil then
          __lux_tmp_53 = 0
        end
        startRad = mathRad(__lux_tmp_53)
      end
      local endRad
      do
        local __lux_tmp_54 = endDeg
        if __lux_tmp_54 == nil then
          __lux_tmp_54 = 360
        end
        endRad = mathRad(__lux_tmp_54)
      end
      local points = {}
      for index = 1, segments + 1 do
        local t = (index - 1) / segments
        local a = startRad + (endRad - startRad) * t
        points[#points + 1] = { x = cx + mathCos(a) * outerRadius, y = cy + mathSin(a) * outerRadius }
      end
      for index = segments + 1, 1, -1 do
        local t = (index - 1) / segments
        local a = startRad + (endRad - startRad) * t
        points[#points + 1] = { x = cx + mathCos(a) * innerRadius, y = cy + mathSin(a) * innerRadius }
      end
      return polyEx(points, resolved)
    end
    sector = function(cx, cy, innerRadius, outerRadius, startDeg, endDeg, fill)
      return sectorEx(cx, cy, innerRadius, outerRadius, startDeg, endDeg, { fill = fill })
    end
  end
  do
    imageEx = function(x, y, w, h, source, drawStyle)
      local resolved = geometryImageStyle(drawStyle)
      local material = source
      if typeOf(source) == "string" then
        do
          local __lux_tmp_55 = resolved.materialFlags
          if __lux_tmp_55 == nil then
            __lux_tmp_55 = "smooth"
          end
          material = makeMaterial(source, __lux_tmp_55)
        end
      end
      if material == nil then
        do
          local __lux_tmp_56 = resolved.fill
          if __lux_tmp_56 == nil then
            __lux_tmp_56 = makeColor(255, 255, 255, 32)
          end
          rectFill(x, y, w, h, __lux_tmp_56)
        end
        return
      end
      local u0, v0, u1, v1 = geometryImageUV(resolved, material)
      x, y, w, h, u0, v0, u1, v1 = geometryImageFitRect(x, y, w, h, material, resolved, u0, v0, u1, v1)
      surfaceSetMaterial(material)
      setColor(geometryImageTint(resolved))
      return geometryDrawTexturedRectUV(x, y, w, h, u0, v0, u1, v1)
    end
    image = function(x, y, w, h, source, radius, tint)
      return imageEx(x, y, w, h, source, { radius = radius, tint = tint })
    end
    iconEx = function(x, y, w, h, source, drawStyle)
      return imageEx(x, y, w, h, source, drawStyle)
    end
    icon = function(x, y, w, h, source, tint)
      return iconEx(x, y, w, h, source, { tint = tint })
    end
  end
  do
    install = function(owner)
      owner.RoundedBox = roundedBox
      owner.RoundedBoxEx = roundedBoxEx
      owner.ChamferBox = chamferBox
      owner.ChamferBoxEx = chamferBoxEx
      owner.Poly = poly
      owner.PolyEx = polyEx
      owner.Line = line
      owner.LineEx = lineEx
      owner.Circle = circle
      owner.CircleEx = circleEx
      owner.Capsule = capsule
      owner.CapsuleEx = capsuleEx
      owner.ProgressBar = progressBar
      owner.ProgressBarEx = progressBarEx
      owner.SegmentBar = segmentBar
      owner.SegmentBarEx = segmentBarEx
      owner.Ring = ring
      owner.RingEx = ringEx
      owner.Arc = arc
      owner.ArcEx = arcEx
      owner.Sector = sector
      owner.SectorEx = sectorEx
      owner.Image = image
      owner.ImageEx = imageEx
      owner.Icon = icon
      owner.IconEx = iconEx
      return owner
    end
  end
  
  __lux_exports.roundedBoxEx = roundedBoxEx
  __lux_exports.roundedBox = roundedBox
  __lux_exports.chamferBoxEx = chamferBoxEx
  __lux_exports.chamferBox = chamferBox
  __lux_exports.polyEx = polyEx
  __lux_exports.poly = poly
  __lux_exports.lineEx = lineEx
  __lux_exports.line = line
  __lux_exports.circleEx = circleEx
  __lux_exports.circle = circle
  __lux_exports.capsuleEx = capsuleEx
  __lux_exports.capsule = capsule
  __lux_exports.progressBarEx = progressBarEx
  __lux_exports.progressBar = progressBar
  __lux_exports.segmentBarEx = segmentBarEx
  __lux_exports.segmentBar = segmentBar
  __lux_exports.ringEx = ringEx
  __lux_exports.ring = ring
  __lux_exports.arcEx = arcEx
  __lux_exports.arc = arc
  __lux_exports.sectorEx = sectorEx
  __lux_exports.sector = sector
  __lux_exports.imageEx = imageEx
  __lux_exports.image = image
  __lux_exports.iconEx = iconEx
  __lux_exports.icon = icon
  __lux_exports.install = install
  
  return __lux_exports
end
