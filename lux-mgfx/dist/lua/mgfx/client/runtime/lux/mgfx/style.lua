return function(__lux_import)
  local __lux_exports = {}
  local FILL_SOLID
  local FILL_LINEAR
  local FILL_RADIAL
  local FILL_CONIC
  local PATTERN_STRIPE
  local PATTERN_SMOKE
  local bitBor
  local camStart2D
  local camEnd2D
  local getRenderTargetEx
  local makeColor
  local mathAbs
  local mathClamp
  local mathFloor
  local mathMax
  local renderClear
  local renderGetBlend
  local renderGetColorModulation
  local renderOverrideAlphaWriteEnable
  local renderOverrideBlend
  local renderPopRenderTarget
  local renderPushRenderTarget
  local renderSetBlend
  local renderSetColorModulation
  local renderSetScissorRect
  local stringLower
  local stringFormat
  local surfaceDrawRect
  local surfaceGetAlphaMultiplier
  local surfaceSetAlphaMultiplier
  local surfaceSetDrawColor
  local tableConcat
  local tableCopy
  local tableInsert
  local tableSort
  local toNumber
  local toString
  local typeOf
  local utilCRC
  local solidCache
  local transparentColor
  local gradientLutOwner
  local backdropTableCache
  local backdropTrueSpec
  local backdropNumberCache
  local backdropColorCache
  local ensureSolidCache
  local isColor
  local byte
  local alpha
  local colorOr
  local asColor
  local color01
  local setDrawColor
  local copyColor
  local withAlpha
  local lerpColor
  local strokeWidth
  local strokeWidthValue
  local radiusTuple
  local radiusScalar
  local normalizeStops
  local stopsVisible
  local firstLastStops
  local colorAtStops
  local solid
  local gradient
  local twoColorStops
  local linearGradient
  local linearGradientStops
  local radialGradient
  local conicGradient
  local ringRadialGradient
  local sectorRadialGradient
  local shapeAngularGradient
  local ringAngularGradient
  local arcAngularGradient
  local sectorAngularGradient
  local patternSeed
  local stripePattern
  local smokePattern
  local mask
  local roundedMaskStyle
  local chamferMaskStyle
  local circleMaskStyle
  local capsuleMaskStyle
  local stringMaskStyle
  local canonicalMaskKind
  local imageMaskStyle
  local isFillRecord
  local fillFromStyle
  local fillFrom
  local colorAtFill
  local fillVisible
  local strokeVisible
  local normalizedRotation
  local glowSoftnessToFalloff
  local backdropStyle
  local backdrop
  local GRADIENT_LUT_W
  local GRADIENT_LUT_H
  local GRADIENT_LUT_CACHE_LIMIT
  local gradientLutCache
  local gradientFillLutCache
  local gradientLutBound
  local gradientLutCacheCount
  local gradientLutClock
  local gradientLutSerial
  local gradientLutSchema
  local gradientLutFlags
  local setGradientLutOwner
  local gradientLutStat
  local lutColorKey
  local normalizedGradientStops
  local gradientFillCacheEntry
  local rememberGradientFill
  local colorAtNormalizedStops
  local gradientLutKey
  local createGradientLutTexture
  local writeGradientLut
  local acquireGradientLutEntry
  local gradientLutForFill
  local bindGradientLut
  local gradientLutStatus
  local install
  do
    FILL_SOLID = 0
    FILL_LINEAR = 1
    FILL_RADIAL = 2
    FILL_CONIC = 3
    PATTERN_STRIPE = "stripe"
    PATTERN_SMOKE = "smoke"
    do
      local __lux_obj_1 = bit
      local __lux_val_2 = nil
      if __lux_obj_1 ~= nil then
        __lux_val_2 = __lux_obj_1.bor
      end
      bitBor = __lux_val_2
    end
    do
      local __lux_obj_3 = cam
      local __lux_val_4 = nil
      if __lux_obj_3 ~= nil then
        __lux_val_4 = __lux_obj_3.Start2D
      end
      camStart2D = __lux_val_4
    end
    do
      local __lux_obj_5 = cam
      local __lux_val_6 = nil
      if __lux_obj_5 ~= nil then
        __lux_val_6 = __lux_obj_5.End2D
      end
      camEnd2D = __lux_val_6
    end
    getRenderTargetEx = GetRenderTargetEx
    makeColor = Color
    mathAbs = math.abs
    mathClamp = math.Clamp
    mathFloor = math.floor
    mathMax = math.max
    do
      local __lux_obj_7 = render
      local __lux_val_8 = nil
      if __lux_obj_7 ~= nil then
        __lux_val_8 = __lux_obj_7.Clear
      end
      renderClear = __lux_val_8
    end
    do
      local __lux_obj_9 = render
      local __lux_val_10 = nil
      if __lux_obj_9 ~= nil then
        __lux_val_10 = __lux_obj_9.GetBlend
      end
      renderGetBlend = __lux_val_10
    end
    do
      local __lux_obj_11 = render
      local __lux_val_12 = nil
      if __lux_obj_11 ~= nil then
        __lux_val_12 = __lux_obj_11.GetColorModulation
      end
      renderGetColorModulation = __lux_val_12
    end
    do
      local __lux_obj_13 = render
      local __lux_val_14 = nil
      if __lux_obj_13 ~= nil then
        __lux_val_14 = __lux_obj_13.OverrideAlphaWriteEnable
      end
      renderOverrideAlphaWriteEnable = __lux_val_14
    end
    do
      local __lux_obj_15 = render
      local __lux_val_16 = nil
      if __lux_obj_15 ~= nil then
        __lux_val_16 = __lux_obj_15.OverrideBlend
      end
      renderOverrideBlend = __lux_val_16
    end
    do
      local __lux_obj_17 = render
      local __lux_val_18 = nil
      if __lux_obj_17 ~= nil then
        __lux_val_18 = __lux_obj_17.PopRenderTarget
      end
      renderPopRenderTarget = __lux_val_18
    end
    do
      local __lux_obj_19 = render
      local __lux_val_20 = nil
      if __lux_obj_19 ~= nil then
        __lux_val_20 = __lux_obj_19.PushRenderTarget
      end
      renderPushRenderTarget = __lux_val_20
    end
    do
      local __lux_obj_21 = render
      local __lux_val_22 = nil
      if __lux_obj_21 ~= nil then
        __lux_val_22 = __lux_obj_21.SetBlend
      end
      renderSetBlend = __lux_val_22
    end
    do
      local __lux_obj_23 = render
      local __lux_val_24 = nil
      if __lux_obj_23 ~= nil then
        __lux_val_24 = __lux_obj_23.SetColorModulation
      end
      renderSetColorModulation = __lux_val_24
    end
    do
      local __lux_obj_25 = render
      local __lux_val_26 = nil
      if __lux_obj_25 ~= nil then
        __lux_val_26 = __lux_obj_25.SetScissorRect
      end
      renderSetScissorRect = __lux_val_26
    end
    stringLower = string.lower
    stringFormat = string.format
    do
      local __lux_obj_27 = surface
      local __lux_val_28 = nil
      if __lux_obj_27 ~= nil then
        __lux_val_28 = __lux_obj_27.DrawRect
      end
      surfaceDrawRect = __lux_val_28
    end
    do
      local __lux_obj_29 = surface
      local __lux_val_30 = nil
      if __lux_obj_29 ~= nil then
        __lux_val_30 = __lux_obj_29.GetAlphaMultiplier
      end
      surfaceGetAlphaMultiplier = __lux_val_30
    end
    do
      local __lux_obj_31 = surface
      local __lux_val_32 = nil
      if __lux_obj_31 ~= nil then
        __lux_val_32 = __lux_obj_31.SetAlphaMultiplier
      end
      surfaceSetAlphaMultiplier = __lux_val_32
    end
    do
      local __lux_obj_33 = surface
      local __lux_val_34 = nil
      if __lux_obj_33 ~= nil then
        __lux_val_34 = __lux_obj_33.SetDrawColor
      end
      surfaceSetDrawColor = __lux_val_34
    end
    tableConcat = table.concat
    tableCopy = table.Copy
    tableInsert = table.insert
    tableSort = table.sort
    toNumber = tonumber
    toString = tostring
    typeOf = type
    do
      local __lux_obj_35 = util
      local __lux_val_36 = nil
      if __lux_obj_35 ~= nil then
        __lux_val_36 = __lux_obj_35.CRC
      end
      utilCRC = __lux_val_36
    end
    solidCache = nil
    transparentColor = nil
    gradientLutOwner = nil
    backdropTableCache = setmetatable({}, { __mode = "k" })
    backdropTrueSpec = nil
    backdropNumberCache = {}
    backdropColorCache = setmetatable({}, { __mode = "k" })
    ensureSolidCache = function()
      if solidCache == nil then
        solidCache = setmetatable({}, { __mode = "kv" })
      end
      return solidCache
    end
    isColor = function(value)
      local __lux_tmp_37 = typeOf(value) == "table"
      if __lux_tmp_37 then
        __lux_tmp_37 = value.r ~= nil
      end
      local __lux_tmp_38 = __lux_tmp_37
      if __lux_tmp_38 then
        __lux_tmp_38 = value.g ~= nil
      end
      local __lux_tmp_39 = __lux_tmp_38
      if __lux_tmp_39 then
        __lux_tmp_39 = value.b ~= nil
      end
      return __lux_tmp_39
    end
    byte = function(value, fallback)
      if fallback == nil then
        fallback = 0
      end
      local nextValue
      do
        local __lux_tmp_40 = toNumber(value)
        if __lux_tmp_40 == nil then
          __lux_tmp_40 = fallback
        end
        nextValue = __lux_tmp_40
      end
      nextValue = mathFloor(nextValue + 0.5)
      if nextValue < 0 then
        return 0
      end
      if nextValue > 255 then
        return 255
      end
      return nextValue
    end
    alpha = function(value, fallback)
      if fallback == nil then
        fallback = 255
      end
      if value == nil then
        return fallback
      end
      return value
    end
    colorOr = function(value, fallback)
      if isColor(value) then
        return value
      end
      local __lux_tmp_41 = fallback
      if __lux_tmp_41 == nil then
        local __lux_tmp_42 = color_white
        if __lux_tmp_42 == nil then
          __lux_tmp_42 = makeColor(255, 255, 255, 255)
        end
        __lux_tmp_41 = __lux_tmp_42
      end
      return __lux_tmp_41
    end
    asColor = function(value, fallback)
      return colorOr(value, fallback)
    end
    color01 = function(color)
      local c = colorOr(color)
      local __lux_tmp_43 = c.r
      if __lux_tmp_43 == nil then
        __lux_tmp_43 = 0
      end
      local __lux_tmp_44 = c.g
      if __lux_tmp_44 == nil then
        __lux_tmp_44 = 0
      end
      local __lux_tmp_45 = c.b
      if __lux_tmp_45 == nil then
        __lux_tmp_45 = 0
      end
      return mathClamp(__lux_tmp_43 / 255, 0, 1), mathClamp(__lux_tmp_44 / 255, 0, 1), mathClamp(__lux_tmp_45 / 255, 0, 1), mathClamp(alpha(c.a) / 255, 0, 1)
    end
    setDrawColor = function(color)
      local c = colorOr(color)
      local __lux_tmp_46 = c.r
      if __lux_tmp_46 == nil then
        __lux_tmp_46 = 255
      end
      local __lux_tmp_47 = c.g
      if __lux_tmp_47 == nil then
        __lux_tmp_47 = 255
      end
      local __lux_tmp_48 = c.b
      if __lux_tmp_48 == nil then
        __lux_tmp_48 = 255
      end
      return surfaceSetDrawColor(__lux_tmp_46, __lux_tmp_47, __lux_tmp_48, alpha(c.a))
    end
    copyColor = function(color)
      local c = colorOr(color)
      local __lux_tmp_49 = c.r
      if __lux_tmp_49 == nil then
        __lux_tmp_49 = 255
      end
      local __lux_tmp_50 = c.g
      if __lux_tmp_50 == nil then
        __lux_tmp_50 = 255
      end
      local __lux_tmp_51 = c.b
      if __lux_tmp_51 == nil then
        __lux_tmp_51 = 255
      end
      return makeColor(__lux_tmp_49, __lux_tmp_50, __lux_tmp_51, alpha(c.a))
    end
    withAlpha = function(color, nextAlpha)
      local c = colorOr(color)
      local __lux_tmp_52 = c.r
      if __lux_tmp_52 == nil then
        __lux_tmp_52 = 255
      end
      local __lux_tmp_53 = c.g
      if __lux_tmp_53 == nil then
        __lux_tmp_53 = 255
      end
      local __lux_tmp_54 = c.b
      if __lux_tmp_54 == nil then
        __lux_tmp_54 = 255
      end
      return makeColor(__lux_tmp_52, __lux_tmp_53, __lux_tmp_54, byte(nextAlpha, alpha(c.a)))
    end
    lerpColor = function(t, from, to)
      local a = colorOr(from)
      local b = colorOr(to, a)
      local amount
      do
        local __lux_tmp_55 = toNumber(t)
        if __lux_tmp_55 == nil then
          __lux_tmp_55 = 0
        end
        amount = mathClamp(__lux_tmp_55, 0, 1)
      end
      local __lux_tmp_56 = a.r
      if __lux_tmp_56 == nil then
        __lux_tmp_56 = 0
      end
      local __lux_tmp_57 = b.r
      if __lux_tmp_57 == nil then
        __lux_tmp_57 = 0
      end
      local __lux_tmp_58 = a.r
      if __lux_tmp_58 == nil then
        __lux_tmp_58 = 0
      end
      local __lux_tmp_59 = a.g
      if __lux_tmp_59 == nil then
        __lux_tmp_59 = 0
      end
      local __lux_tmp_60 = b.g
      if __lux_tmp_60 == nil then
        __lux_tmp_60 = 0
      end
      local __lux_tmp_61 = a.g
      if __lux_tmp_61 == nil then
        __lux_tmp_61 = 0
      end
      local __lux_tmp_62 = a.b
      if __lux_tmp_62 == nil then
        __lux_tmp_62 = 0
      end
      local __lux_tmp_63 = b.b
      if __lux_tmp_63 == nil then
        __lux_tmp_63 = 0
      end
      local __lux_tmp_64 = a.b
      if __lux_tmp_64 == nil then
        __lux_tmp_64 = 0
      end
      return makeColor(
        byte(__lux_tmp_56 + (__lux_tmp_57 - __lux_tmp_58) * amount),
        byte(__lux_tmp_59 + (__lux_tmp_60 - __lux_tmp_61) * amount),
        byte(__lux_tmp_62 + (__lux_tmp_63 - __lux_tmp_64) * amount),
        byte(alpha(a.a) + (alpha(b.a) - alpha(a.a)) * amount)
      )
    end
    strokeWidth = function(value, fallback)
      if fallback == nil then
        fallback = 0
      end
      if value == true then
        local __lux_tmp_65 = fallback
        if __lux_tmp_65 == nil then
          __lux_tmp_65 = 1
        end
        return __lux_tmp_65
      end
      if typeOf(value) == "string" then
        local alias
        local __lux_match_66 = stringLower(value)
        if __lux_match_66 == "hairline" then
          alias = 0.75
        elseif __lux_match_66 == "thin" then
          alias = 1
        elseif __lux_match_66 == "none" then
          alias = 0
        else
          alias = nil
        end
        if alias ~= nil then
          return alias
        end
      end
      local __lux_tmp_67 = toNumber(value)
      if __lux_tmp_67 == nil then
        local __lux_tmp_68 = fallback
        if __lux_tmp_68 == nil then
          __lux_tmp_68 = 0
        end
        __lux_tmp_67 = __lux_tmp_68
      end
      return __lux_tmp_67
    end
    strokeWidthValue = function(value, fallback)
      if fallback == nil then
        fallback = 0
      end
      return strokeWidth(value, fallback)
    end
    radiusTuple = function(radius, w, h)
      if w == nil then
        w = 0
      end
      if h == nil then
        h = 0
      end
      local tl
      local tr
      local br
      local bl
      local __lux_tmp_69 = typeOf(radius) == "table"
      if __lux_tmp_69 then
        __lux_tmp_69 = not isColor(radius)
      end
      if __lux_tmp_69 then
        do
          local __lux_tmp_70 = radius.tl
          if __lux_tmp_70 == nil then
            __lux_tmp_70 = radius[1]
          end
          local __lux_tmp_71 = toNumber(__lux_tmp_70)
          if __lux_tmp_71 == nil then
            __lux_tmp_71 = 0
          end
          tl = __lux_tmp_71
        end
        do
          local __lux_tmp_72 = radius.tr
          if __lux_tmp_72 == nil then
            __lux_tmp_72 = radius[2]
          end
          local __lux_tmp_73 = toNumber(__lux_tmp_72)
          if __lux_tmp_73 == nil then
            __lux_tmp_73 = tl
          end
          tr = __lux_tmp_73
        end
        do
          local __lux_tmp_74 = radius.br
          if __lux_tmp_74 == nil then
            __lux_tmp_74 = radius[3]
          end
          local __lux_tmp_75 = toNumber(__lux_tmp_74)
          if __lux_tmp_75 == nil then
            __lux_tmp_75 = tr
          end
          br = __lux_tmp_75
        end
        do
          local __lux_tmp_76 = radius.bl
          if __lux_tmp_76 == nil then
            __lux_tmp_76 = radius[4]
          end
          local __lux_tmp_77 = toNumber(__lux_tmp_76)
          if __lux_tmp_77 == nil then
            __lux_tmp_77 = br
          end
          bl = __lux_tmp_77
        end
      else
        do
          local __lux_tmp_78 = toNumber(radius)
          if __lux_tmp_78 == nil then
            __lux_tmp_78 = 0
          end
          tl = __lux_tmp_78
        end
        tr = tl
        br = tl
        bl = tl
      end
      tl = mathMax(0, tl)
      tr = mathMax(0, tr)
      br = mathMax(0, br)
      bl = mathMax(0, bl)
      local width
      do
        local __lux_tmp_79 = toNumber(w)
        if __lux_tmp_79 == nil then
          __lux_tmp_79 = 0.0001
        end
        width = mathMax(0.0001, __lux_tmp_79)
      end
      local height
      do
        local __lux_tmp_80 = toNumber(h)
        if __lux_tmp_80 == nil then
          __lux_tmp_80 = 0.0001
        end
        height = mathMax(0.0001, __lux_tmp_80)
      end
      local scale = mathMax(1, (tl + tr) / width, (bl + br) / width, (tl + bl) / height, (tr + br) / height)
      if scale > 1 then
        tl = tl / scale
        tr = tr / scale
        br = br / scale
        bl = bl / scale
      end
      return tl, tr, br, bl
    end
    radiusScalar = function(radius, w, h)
      if w == nil then
        w = 0
      end
      if h == nil then
        h = 0
      end
      local tl, tr, br, bl = radiusTuple(radius, w, h)
      return mathMax(tl, tr, br, bl)
    end
  end
  do
    normalizeStops = function(stops)
      if typeOf(stops) ~= "table" then
        return nil
      end
      local out = {}
      for index, stop in ipairs(stops) do
        local position = nil
        local color = nil
        if isColor(stop) then
          color = stop
          do
            local __lux_tmp_81
            if #stops <= 1 then
              __lux_tmp_81 = 0
            else
              __lux_tmp_81 = (index - 1) / (#stops - 1)
            end
            position = __lux_tmp_81
          end
        else
          if typeOf(stop) == "table" then
            do
              local __lux_tmp_82 = stop.pos
              if __lux_tmp_82 == nil then
                local __lux_tmp_83 = stop.t
                if __lux_tmp_83 == nil then
                  local __lux_tmp_84 = stop.offset
                  if __lux_tmp_84 == nil then
                    __lux_tmp_84 = stop[1]
                  end
                  __lux_tmp_83 = __lux_tmp_84
                end
                __lux_tmp_82 = __lux_tmp_83
              end
              position = __lux_tmp_82
            end
            do
              local __lux_tmp_85 = stop.color
              if __lux_tmp_85 == nil then
                __lux_tmp_85 = stop[2]
              end
              color = __lux_tmp_85
            end
          end
        end
        if color ~= nil then
          do
            local __lux_tmp_86 = toNumber(position)
            if __lux_tmp_86 == nil then
              local __lux_tmp_87
              if #stops <= 1 then
                __lux_tmp_87 = 0
              else
                __lux_tmp_87 = (index - 1) / (#stops - 1)
              end
              __lux_tmp_86 = __lux_tmp_87
            end
            out[#out + 1] = { pos = mathClamp(__lux_tmp_86, 0, 1), color = colorOr(color) }
          end
        end
      end
      if #out == 0 then
        return nil
      end
      tableSort(
        out,
        function(a, b)
          return a.pos < b.pos
        end
      )
      if out[1].pos > 0 then
        tableInsert(out, 1, { pos = 0, color = out[1].color })
      end
      if out[#out].pos < 1 then
        out[#out + 1] = { pos = 1, color = out[#out].color }
      end
      return out
    end
    stopsVisible = function(stops)
      do
        local __lux_tmp_88 = stops
        if __lux_tmp_88 == nil then
          __lux_tmp_88 = {}
        end
        for _, stop in ipairs(__lux_tmp_88) do
          local color
          do
            local __lux_tmp_89 = stop.color
            if __lux_tmp_89 == nil then
              __lux_tmp_89 = stop[2]
            end
            color = __lux_tmp_89
          end
          if color ~= nil then
            local __lux_cmp_90 = false
            if alpha(color.a) ~= nil and 0 ~= nil then
              __lux_cmp_90 = alpha(color.a) > 0
            end
            if __lux_cmp_90 then
              return true
            end
          end
        end
      end
      return false
    end
    firstLastStops = function(stops)
      local normalized = normalizeStops(stops)
      if normalized == nil then
        return colorOr(nil), colorOr(nil), nil
      end
      return normalized[1].color, normalized[#normalized].color, normalized
    end
    colorAtStops = function(stops, t)
      local normalized = normalizeStops(stops)
      if normalized == nil then
        return colorOr(nil)
      end
      local amount
      do
        local __lux_tmp_91 = toNumber(t)
        if __lux_tmp_91 == nil then
          __lux_tmp_91 = 0
        end
        amount = mathClamp(__lux_tmp_91, 0, 1)
      end
      for index = 1, #normalized - 1 do
        local a = normalized[index]
        local b = normalized[index + 1]
        if amount <= b.pos then
          local span = mathMax(0.0001, b.pos - a.pos)
          return lerpColor((amount - a.pos) / span, a.color, b.color)
        end
      end
      return normalized[#normalized].color
    end
    solid = function(color)
      local c = colorOr(color)
      local cache = ensureSolidCache()
      local cached = cache[c]
      if cached ~= nil then
        return cached
      end
      do
        local __lux_cmp_92 = false
        if alpha(c.a) ~= nil and 0 ~= nil then
          __lux_cmp_92 = alpha(c.a) > 0
        end
        cached = { kind = FILL_SOLID, colorA = c, colorB = c, _mgfxFillVisible = __lux_cmp_92 }
      end
      cache[c] = cached
      return cached
    end
    gradient = function(kind, a, b, stops, extra)
      local base = {
        kind = kind,
        colorA = a,
        colorB = b,
        stops = stops,
        _mgfxStopsNormalized = true,
        _mgfxLutCacheSafe = true,
        _mgfxFillVisible = stopsVisible(stops),
      }
      if extra ~= nil then
        for key, value in pairs(extra) do
          base[key] = value
        end
      end
      return base
    end
    twoColorStops = function(a, b)
      return { { pos = 0, color = a }, { pos = 1, color = b } }
    end
    linearGradient = function(x1, y1, x2, y2, stopsOrColorA, colorB)
      local colorA
      local stops
      local __lux_tmp_93 = typeOf(stopsOrColorA) == "table"
      if __lux_tmp_93 then
        __lux_tmp_93 = not isColor(stopsOrColorA)
      end
      if __lux_tmp_93 then
        colorA, colorB, stops = firstLastStops(stopsOrColorA)
      else
        colorA = colorOr(stopsOrColorA)
        colorB = colorOr(colorB, colorA)
        stops = twoColorStops(colorA, colorB)
      end
      local __lux_tmp_94 = toNumber(x1)
      if __lux_tmp_94 == nil then
        __lux_tmp_94 = 0
      end
      local __lux_tmp_95 = toNumber(y1)
      if __lux_tmp_95 == nil then
        __lux_tmp_95 = 0
      end
      local __lux_tmp_96 = toNumber(x2)
      if __lux_tmp_96 == nil then
        __lux_tmp_96 = 1
      end
      local __lux_tmp_97 = toNumber(y2)
      if __lux_tmp_97 == nil then
        __lux_tmp_97 = 1
      end
      return gradient(
        FILL_LINEAR,
        colorA,
        colorB,
        stops,
        { x1 = __lux_tmp_94, y1 = __lux_tmp_95, x2 = __lux_tmp_96, y2 = __lux_tmp_97 }
      )
    end
    linearGradientStops = function(x1, y1, x2, y2, stops)
      return linearGradient(x1, y1, x2, y2, stops, nil)
    end
    radialGradient = function(cx, cy, radius, stopsOrColorA, colorB)
      local colorA
      local stops
      local __lux_tmp_98 = typeOf(stopsOrColorA) == "table"
      if __lux_tmp_98 then
        __lux_tmp_98 = not isColor(stopsOrColorA)
      end
      if __lux_tmp_98 then
        colorA, colorB, stops = firstLastStops(stopsOrColorA)
      else
        colorA = colorOr(stopsOrColorA)
        colorB = colorOr(colorB, colorA)
        stops = twoColorStops(colorA, colorB)
      end
      local __lux_tmp_99 = toNumber(cx)
      if __lux_tmp_99 == nil then
        __lux_tmp_99 = 0.5
      end
      local __lux_tmp_100 = toNumber(cy)
      if __lux_tmp_100 == nil then
        __lux_tmp_100 = 0.5
      end
      local __lux_tmp_101 = toNumber(radius)
      if __lux_tmp_101 == nil then
        __lux_tmp_101 = 0.5
      end
      return gradient(
        FILL_RADIAL,
        colorA,
        colorB,
        stops,
        { cx = __lux_tmp_99, cy = __lux_tmp_100, radius = __lux_tmp_101 }
      )
    end
    conicGradient = function(cx, cy, rotation, stopsOrColorA, colorB)
      local colorA
      local stops
      local __lux_tmp_102 = typeOf(stopsOrColorA) == "table"
      if __lux_tmp_102 then
        __lux_tmp_102 = not isColor(stopsOrColorA)
      end
      if __lux_tmp_102 then
        colorA, colorB, stops = firstLastStops(stopsOrColorA)
      else
        colorA = colorOr(stopsOrColorA)
        colorB = colorOr(colorB, colorA)
        stops = twoColorStops(colorA, colorB)
      end
      local __lux_tmp_103 = toNumber(cx)
      if __lux_tmp_103 == nil then
        __lux_tmp_103 = 0.5
      end
      local __lux_tmp_104 = toNumber(cy)
      if __lux_tmp_104 == nil then
        __lux_tmp_104 = 0.5
      end
      local __lux_tmp_105 = toNumber(rotation)
      if __lux_tmp_105 == nil then
        __lux_tmp_105 = 0
      end
      return gradient(
        FILL_CONIC,
        colorA,
        colorB,
        stops,
        { cx = __lux_tmp_103, cy = __lux_tmp_104, rotation = __lux_tmp_105 }
      )
    end
    ringRadialGradient = function(stopsOrColorA, colorB)
      do
        local fill = radialGradient(0.5, 0.5, 0.5, stopsOrColorA, colorB)
        fill.radialSpace = "ring"
        fill.localRadial = true
        return fill
      end
    end
    sectorRadialGradient = function(stopsOrColorA, colorB)
      return ringRadialGradient(stopsOrColorA, colorB)
    end
    shapeAngularGradient = function(stopsOrColorA, colorB, rotation)
      local __lux_tmp_106 = typeOf(stopsOrColorA) == "table"
      if __lux_tmp_106 then
        __lux_tmp_106 = not isColor(stopsOrColorA)
      end
      local __lux_tmp_107 = __lux_tmp_106
      if __lux_tmp_107 then
        __lux_tmp_107 = typeOf(colorB) == "number"
      end
      local __lux_tmp_108 = __lux_tmp_107
      if __lux_tmp_108 then
        __lux_tmp_108 = rotation == nil
      end
      if __lux_tmp_108 then
        rotation = colorB
        colorB = nil
      end
      local fill
      do
        local __lux_tmp_109 = rotation
        if __lux_tmp_109 == nil then
          __lux_tmp_109 = 0
        end
        fill = conicGradient(0.5, 0.5, __lux_tmp_109, stopsOrColorA, colorB)
      end
      fill.angularSpace = "shape"
      fill.localAngular = true
      return fill
    end
    ringAngularGradient = function(stopsOrColorA, colorB, rotation)
      if rotation == nil then
        rotation = 0
      end
      return shapeAngularGradient(stopsOrColorA, colorB, rotation)
    end
    arcAngularGradient = function(stopsOrColorA, colorB, rotation)
      if rotation == nil then
        rotation = 0
      end
      return shapeAngularGradient(stopsOrColorA, colorB, rotation)
    end
    sectorAngularGradient = function(stopsOrColorA, colorB, rotation)
      if rotation == nil then
        rotation = 0
      end
      return shapeAngularGradient(stopsOrColorA, colorB, rotation)
    end
  end
  do
    patternSeed = function(seed)
      if seed == nil then
        return 0
      end
      local value = toNumber(seed)
      local utilCrc
      do
        local __lux_obj_110 = util
        local __lux_val_111 = nil
        if __lux_obj_110 ~= nil then
          __lux_val_111 = __lux_obj_110.CRC
        end
        utilCrc = __lux_val_111
      end
      local __lux_tmp_112 = value == nil
      if __lux_tmp_112 then
        __lux_tmp_112 = utilCrc ~= nil
      end
      if __lux_tmp_112 then
        value = toNumber(utilCrc(toString(seed)))
      end
      do
        local __lux_tmp_113 = value
        if __lux_tmp_113 == nil then
          __lux_tmp_113 = 0
        end
        value = mathAbs(__lux_tmp_113) % 65536
      end
      return value / 65536
    end
    stripePattern = function(color, spacing, width, angle, offset)
      if spacing == nil then
        spacing = 12
      end
      if width == nil then
        width = 2
      end
      if angle == nil then
        angle = 135
      end
      if offset == nil then
        offset = 0
      end
      local __lux_tmp_114 = typeOf(color) == "table"
      if __lux_tmp_114 then
        __lux_tmp_114 = not isColor(color)
      end
      if __lux_tmp_114 then
        local __lux_tmp_115 = color.color
        if __lux_tmp_115 == nil then
          __lux_tmp_115 = color.tint
        end
        local __lux_tmp_116 = toNumber(color.spacing)
        if __lux_tmp_116 == nil then
          __lux_tmp_116 = 12
        end
        local __lux_tmp_117 = toNumber(color.width)
        if __lux_tmp_117 == nil then
          __lux_tmp_117 = 2
        end
        local __lux_tmp_118 = toNumber(color.angle)
        if __lux_tmp_118 == nil then
          __lux_tmp_118 = 135
        end
        local __lux_tmp_119 = toNumber(color.offset)
        if __lux_tmp_119 == nil then
          __lux_tmp_119 = 0
        end
        return {
          kind = PATTERN_STRIPE,
          color = colorOr(__lux_tmp_115, makeColor(255, 255, 255, 24)),
          spacing = __lux_tmp_116,
          width = __lux_tmp_117,
          angle = __lux_tmp_118,
          offset = __lux_tmp_119,
        }
      end
      local __lux_tmp_120 = toNumber(spacing)
      if __lux_tmp_120 == nil then
        __lux_tmp_120 = 12
      end
      local __lux_tmp_121 = toNumber(width)
      if __lux_tmp_121 == nil then
        __lux_tmp_121 = 2
      end
      local __lux_tmp_122 = toNumber(angle)
      if __lux_tmp_122 == nil then
        __lux_tmp_122 = 135
      end
      local __lux_tmp_123 = toNumber(offset)
      if __lux_tmp_123 == nil then
        __lux_tmp_123 = 0
      end
      return {
        kind = PATTERN_STRIPE,
        color = colorOr(color, makeColor(255, 255, 255, 24)),
        spacing = __lux_tmp_120,
        width = __lux_tmp_121,
        angle = __lux_tmp_122,
        offset = __lux_tmp_123,
      }
    end
    smokePattern = function(color, scale, density, softness, angle, offset, seed)
      if scale == nil then
        scale = 140
      end
      if density == nil then
        density = 0.48
      end
      if softness == nil then
        softness = 0.3
      end
      if angle == nil then
        angle = 135
      end
      if offset == nil then
        offset = 0
      end
      if seed == nil then
        seed = 0
      end
      local __lux_tmp_124 = typeOf(color) == "table"
      if __lux_tmp_124 then
        __lux_tmp_124 = not isColor(color)
      end
      if __lux_tmp_124 then
        local __lux_tmp_125 = color.color
        if __lux_tmp_125 == nil then
          __lux_tmp_125 = color.tint
        end
        local __lux_tmp_126 = toNumber(color.scale)
        if __lux_tmp_126 == nil then
          __lux_tmp_126 = 140
        end
        local __lux_tmp_127 = toNumber(color.density)
        if __lux_tmp_127 == nil then
          __lux_tmp_127 = 0.48
        end
        local __lux_tmp_128 = toNumber(color.softness)
        if __lux_tmp_128 == nil then
          __lux_tmp_128 = 0.3
        end
        local __lux_tmp_129 = toNumber(color.angle)
        if __lux_tmp_129 == nil then
          __lux_tmp_129 = 135
        end
        local __lux_tmp_130 = toNumber(color.offset)
        if __lux_tmp_130 == nil then
          __lux_tmp_130 = 0
        end
        local __lux_tmp_131 = toNumber(color.speed)
        if __lux_tmp_131 == nil then
          __lux_tmp_131 = 0
        end
        local __lux_tmp_132 = toNumber(color.warp)
        if __lux_tmp_132 == nil then
          __lux_tmp_132 = 0.85
        end
        return {
          kind = PATTERN_SMOKE,
          color = colorOr(__lux_tmp_125, makeColor(255, 255, 255, 24)),
          scale = __lux_tmp_126,
          density = __lux_tmp_127,
          softness = __lux_tmp_128,
          angle = __lux_tmp_129,
          offset = __lux_tmp_130,
          speed = __lux_tmp_131,
          warp = __lux_tmp_132,
          seed = patternSeed(color.seed),
        }
      end
      local __lux_tmp_133 = toNumber(scale)
      if __lux_tmp_133 == nil then
        __lux_tmp_133 = 140
      end
      local __lux_tmp_134 = toNumber(density)
      if __lux_tmp_134 == nil then
        __lux_tmp_134 = 0.48
      end
      local __lux_tmp_135 = toNumber(softness)
      if __lux_tmp_135 == nil then
        __lux_tmp_135 = 0.3
      end
      local __lux_tmp_136 = toNumber(angle)
      if __lux_tmp_136 == nil then
        __lux_tmp_136 = 135
      end
      local __lux_tmp_137 = toNumber(offset)
      if __lux_tmp_137 == nil then
        __lux_tmp_137 = 0
      end
      return {
        kind = PATTERN_SMOKE,
        color = colorOr(color, makeColor(255, 255, 255, 24)),
        scale = __lux_tmp_133,
        density = __lux_tmp_134,
        softness = __lux_tmp_135,
        angle = __lux_tmp_136,
        offset = __lux_tmp_137,
        speed = 0,
        warp = 0.85,
        seed = patternSeed(seed),
      }
    end
  end
  do
    mask = function(kind, spec)
      if typeOf(kind) == "table" then
        local out = tableCopy(kind)
        local __lux_tmp_138 = out.kind == nil
        if __lux_tmp_138 then
          __lux_tmp_138 = out.shape ~= nil
        end
        if __lux_tmp_138 then
          out.kind = out.shape
        end
        out.__mgfxMask = true
        return out
      end
      local out
      if typeOf(spec) == "table" then
        out = tableCopy(spec)
      else
        out = {}
      end
      do
        local __lux_tmp_139 = kind
        if __lux_tmp_139 == nil then
          __lux_tmp_139 = out.kind
        end
        out.kind = __lux_tmp_139
      end
      local __lux_tmp_140 = out.kind == nil
      if __lux_tmp_140 then
        __lux_tmp_140 = out.shape ~= nil
      end
      if __lux_tmp_140 then
        out.kind = out.shape
      end
      out.__mgfxMask = true
      return out
    end
    roundedMaskStyle = function(resolved)
      local __lux_tmp_141 = resolved.radius
      if __lux_tmp_141 == nil then
        __lux_tmp_141 = 0
      end
      return { kind = "rounded", radius = __lux_tmp_141 }
    end
    chamferMaskStyle = function()
      return { kind = "chamfer", cuts = 0 }
    end
    circleMaskStyle = function()
      return { kind = "circle" }
    end
    capsuleMaskStyle = function()
      return { kind = "capsule" }
    end
    stringMaskStyle = function(kind, resolved)
      local __lux_match_142 = kind
      if __lux_match_142 == "round" or __lux_match_142 == "rounded" or __lux_match_142 == "roundedbox" or __lux_match_142 == "roundrect" then
        return roundedMaskStyle(resolved)
      elseif __lux_match_142 == "chamfer" or __lux_match_142 == "bevel" then
        return chamferMaskStyle()
      elseif __lux_match_142 == "circle" then
        return circleMaskStyle()
      elseif __lux_match_142 == "capsule" or __lux_match_142 == "pill" then
        return capsuleMaskStyle()
      else
        return nil
      end
    end
    canonicalMaskKind = function(kind)
      local __lux_match_143 = kind
      if __lux_match_143 == "round" or __lux_match_143 == "roundrect" or __lux_match_143 == "roundedbox" then
        return "rounded"
      elseif __lux_match_143 == "bevel" then
        return "chamfer"
      elseif __lux_match_143 == "pill" then
        return "capsule"
      elseif __lux_match_143 == "alpha" or __lux_match_143 == "image" then
        return "texture"
      else
        return kind
      end
    end
    imageMaskStyle = function(maskValue, drawStyle)
      local resolved
      do
        local __lux_tmp_144 = drawStyle
        if __lux_tmp_144 == nil then
          __lux_tmp_144 = {}
        end
        resolved = __lux_tmp_144
      end
      local __lux_tmp_145 = maskValue == false
      if not __lux_tmp_145 then
        __lux_tmp_145 = maskValue == "none"
      end
      if __lux_tmp_145 then
        return nil
      end
      if maskValue == nil then
        if resolved.radius ~= nil then
          return roundedMaskStyle(resolved)
        else
          return nil
        end
      end
      if typeOf(maskValue) == "string" then
        return stringMaskStyle(stringLower(maskValue), resolved)
      end
      if typeOf(maskValue) ~= "table" then
        return nil
      end
      local out = tableCopy(maskValue)
      do
        local __lux_tmp_146 = out.kind
        if __lux_tmp_146 == nil then
          local __lux_tmp_147 = out.shape
          if __lux_tmp_147 == nil then
            local __lux_tmp_148
            if out.source ~= nil then
              __lux_tmp_148 = "texture"
            else
              __lux_tmp_148 = nil
            end
            local __lux_tmp_149 = __lux_tmp_148
            if __lux_tmp_149 == nil then
              local __lux_tmp_150
              if out.material ~= nil then
                __lux_tmp_150 = "texture"
              else
                __lux_tmp_150 = nil
              end
              local __lux_tmp_151 = __lux_tmp_150
              if __lux_tmp_151 == nil then
                local __lux_tmp_152
                if out.texture ~= nil then
                  __lux_tmp_152 = "texture"
                else
                  __lux_tmp_152 = nil
                end
                __lux_tmp_151 = __lux_tmp_152
              end
              __lux_tmp_149 = __lux_tmp_151
            end
            __lux_tmp_147 = __lux_tmp_149
          end
          __lux_tmp_146 = __lux_tmp_147
        end
        out.kind = __lux_tmp_146
      end
      if typeOf(out.kind) == "string" then
        out.kind = canonicalMaskKind(stringLower(out.kind))
      end
      local __lux_match_153 = out.kind
      if __lux_match_153 == "chamfer" then
        if out.cuts == nil then
          out.cuts = 0
        end
      elseif __lux_match_153 == "rounded" then
        if out.radius == nil then
          do
            local __lux_tmp_154 = resolved.radius
            if __lux_tmp_154 == nil then
              __lux_tmp_154 = 0
            end
            out.radius = __lux_tmp_154
          end
        end
      else
        local __lux_unused_155 = nil
      end
      return out
    end
  end
  do
    isFillRecord = function(value)
      local __lux_tmp_156 = typeOf(value) == "table"
      if __lux_tmp_156 then
        local __lux_tmp_157
        local __lux_match_158 = value
        local __lux_tag_159
        if __lux_match_158 ~= nil then
          __lux_tag_159 = __lux_match_158.kind
        end
        if __lux_tag_159 == FILL_SOLID or __lux_tag_159 == FILL_LINEAR or __lux_tag_159 == FILL_RADIAL or __lux_tag_159 == FILL_CONIC then
          __lux_tmp_157 = true
        else
          __lux_tmp_157 = false
        end
        __lux_tmp_156 = __lux_tmp_157
      end
      return __lux_tmp_156
    end
    fillFromStyle = function(fill)
      if isFillRecord(fill) then
        return fill
      end
      local __lux_tmp_160 = typeOf(fill) == "table"
      if __lux_tmp_160 then
        __lux_tmp_160 = fill.kind ~= nil
      end
      if __lux_tmp_160 then
        do
          local __lux_tmp_161 = transparentColor
          if __lux_tmp_161 == nil then
            __lux_tmp_161 = makeColor(0, 0, 0, 0)
          end
          transparentColor = __lux_tmp_161
        end
        return solid(transparentColor)
      end
      return solid(colorOr(fill))
    end
    fillFrom = function(value)
      return fillFromStyle(value)
    end
    colorAtFill = function(fill, t)
      local resolved = fillFromStyle(fill)
      local __lux_tmp_162 = resolved.stops ~= nil
      if __lux_tmp_162 then
        __lux_tmp_162 = #resolved.stops > 0
      end
      if __lux_tmp_162 then
        return colorAtStops(resolved.stops, t)
      end
      local __lux_tmp_163 = resolved.colorA
      if __lux_tmp_163 == nil then
        __lux_tmp_163 = color_white
      end
      local __lux_tmp_164 = resolved.colorB
      if __lux_tmp_164 == nil then
        local __lux_tmp_165 = resolved.colorA
        if __lux_tmp_165 == nil then
          __lux_tmp_165 = color_white
        end
        __lux_tmp_164 = __lux_tmp_165
      end
      return lerpColor(t, __lux_tmp_163, __lux_tmp_164)
    end
    fillVisible = function(fill)
      if fill == nil then
        return false
      end
      if isColor(fill) then
        local __lux_cmp_166 = false
        if alpha(fill.a) ~= nil and 0 ~= nil then
          __lux_cmp_166 = alpha(fill.a) > 0
        end
        return __lux_cmp_166
      end
      local __lux_tmp_167 = typeOf(fill) == "table"
      if __lux_tmp_167 then
        __lux_tmp_167 = fill._mgfxFillVisible ~= nil
      end
      if __lux_tmp_167 then
        return fill._mgfxFillVisible
      end
      return true
    end
    strokeVisible = function(stroke, width)
      if stroke == nil then
        return false
      end
      local __lux_cmp_168 = false
      if alpha(stroke.a) ~= nil and 0 ~= nil then
        __lux_cmp_168 = alpha(stroke.a) <= 0
      end
      if __lux_cmp_168 then
        return false
      end
      local __lux_cmp_169 = false
      if strokeWidth(width, 1) ~= nil and 0 ~= nil then
        __lux_cmp_169 = strokeWidth(width, 1) > 0
      end
      return __lux_cmp_169
    end
    normalizedRotation = function(value)
      local rotation
      do
        local __lux_tmp_170 = toNumber(value)
        if __lux_tmp_170 == nil then
          __lux_tmp_170 = 0
        end
        rotation = __lux_tmp_170 / 360 % 1
      end
      if rotation < 0 then
        rotation = rotation + 1
      end
      return rotation
    end
    glowSoftnessToFalloff = function(softness, defaultSoftness)
      if defaultSoftness == nil then
        defaultSoftness = 0.55
      end
      local value
      do
        local __lux_tmp_171 = toNumber(softness)
        if __lux_tmp_171 == nil then
          local __lux_tmp_172 = defaultSoftness
          if __lux_tmp_172 == nil then
            __lux_tmp_172 = 0.55
          end
          __lux_tmp_171 = __lux_tmp_172
        end
        value = mathClamp(__lux_tmp_171, 0, 1)
      end
      return mathClamp(3.25 - value * 2.5, 0.75, 3.25)
    end
    backdropStyle = function(value)
      local __lux_tmp_173 = value == nil
      if not __lux_tmp_173 then
        __lux_tmp_173 = value == false
      end
      if __lux_tmp_173 then
        return nil
      end
      if value == true then
        if backdropTrueSpec == nil then
          do
            local __lux_tmp_174 = transparentColor
            if __lux_tmp_174 == nil then
              __lux_tmp_174 = makeColor(0, 0, 0, 0)
            end
            transparentColor = __lux_tmp_174
          end
          backdropTrueSpec = { blur = 4, tint = transparentColor, opacity = 1, padding = 0 }
        end
        return backdropTrueSpec
      end
      if typeOf(value) == "number" then
        local blurKey
        do
          local __lux_tmp_175 = toNumber(value)
          if __lux_tmp_175 == nil then
            __lux_tmp_175 = 0
          end
          blurKey = mathMax(0, __lux_tmp_175)
        end
        local cached = backdropNumberCache[blurKey]
        if cached ~= nil then
          if cached == false then
            return nil
          else
            return cached
          end
        end
        if blurKey <= 0 then
          backdropNumberCache[blurKey] = false
          return nil
        end
        do
          local __lux_tmp_176 = transparentColor
          if __lux_tmp_176 == nil then
            __lux_tmp_176 = makeColor(0, 0, 0, 0)
          end
          transparentColor = __lux_tmp_176
        end
        cached = { blur = blurKey, tint = transparentColor, opacity = 1, padding = 0 }
        backdropNumberCache[blurKey] = cached
        return cached
      end
      if isColor(value) then
        local cached = backdropColorCache[value]
        if cached ~= nil then
          if cached == false then
            return nil
          else
            return cached
          end
        end
        cached = { blur = 0, tint = value, opacity = 1, padding = 0 }
        local __lux_cmp_177 = false
        if alpha(value.a) ~= nil and 0 ~= nil then
          __lux_cmp_177 = alpha(value.a) <= 0
        end
        if __lux_cmp_177 then
          cached = false
        end
        backdropColorCache[value] = cached
        if cached == false then
          return nil
        else
          return cached
        end
      end
      if typeOf(value) ~= "table" then
        return nil
      end
      local cached = backdropTableCache[value]
      local __lux_tmp_178 = cached ~= nil
      if __lux_tmp_178 then
        __lux_tmp_178 = cached ~= false
      end
      local __lux_tmp_179 = __lux_tmp_178
      if __lux_tmp_179 then
        __lux_tmp_179 = cached._blurInput == value.blur
      end
      local __lux_tmp_180 = __lux_tmp_179
      if __lux_tmp_180 then
        __lux_tmp_180 = cached._sizeInput == value.size
      end
      local __lux_tmp_181 = __lux_tmp_180
      if __lux_tmp_181 then
        __lux_tmp_181 = cached._indexInput == value[1]
      end
      local __lux_tmp_182 = __lux_tmp_181
      if __lux_tmp_182 then
        __lux_tmp_182 = cached._tintInput == value.tint
      end
      local __lux_tmp_183 = __lux_tmp_182
      if __lux_tmp_183 then
        __lux_tmp_183 = cached._colorInput == value.color
      end
      local __lux_tmp_184 = __lux_tmp_183
      if __lux_tmp_184 then
        __lux_tmp_184 = cached._opacityInput == value.opacity
      end
      local __lux_tmp_185 = __lux_tmp_184
      if __lux_tmp_185 then
        __lux_tmp_185 = cached._strengthInput == value.strength
      end
      local __lux_tmp_186 = __lux_tmp_185
      if __lux_tmp_186 then
        __lux_tmp_186 = cached._paddingInput == value.padding
      end
      local __lux_tmp_187 = __lux_tmp_186
      if __lux_tmp_187 then
        __lux_tmp_187 = cached._spreadInput == value.spread
      end
      if __lux_tmp_187 then
        return cached
      end
      local __lux_tmp_188 = cached == false
      if __lux_tmp_188 then
        __lux_tmp_188 = value.blur == nil
      end
      local __lux_tmp_189 = __lux_tmp_188
      if __lux_tmp_189 then
        __lux_tmp_189 = value.size == nil
      end
      local __lux_tmp_190 = __lux_tmp_189
      if __lux_tmp_190 then
        __lux_tmp_190 = value[1] == nil
      end
      local __lux_tmp_191 = __lux_tmp_190
      if __lux_tmp_191 then
        __lux_tmp_191 = value.tint == nil
      end
      local __lux_tmp_192 = __lux_tmp_191
      if __lux_tmp_192 then
        __lux_tmp_192 = value.color == nil
      end
      local __lux_tmp_193 = __lux_tmp_192
      if __lux_tmp_193 then
        __lux_tmp_193 = value.opacity == nil
      end
      local __lux_tmp_194 = __lux_tmp_193
      if __lux_tmp_194 then
        __lux_tmp_194 = value.strength == nil
      end
      local __lux_tmp_195 = __lux_tmp_194
      if __lux_tmp_195 then
        __lux_tmp_195 = value.padding == nil
      end
      local __lux_tmp_196 = __lux_tmp_195
      if __lux_tmp_196 then
        __lux_tmp_196 = value.spread == nil
      end
      if __lux_tmp_196 then
        if cached == false then
          return nil
        else
          return cached
        end
      end
      local blur
      do
        local __lux_tmp_197 = value.blur
        if __lux_tmp_197 == nil then
          local __lux_tmp_198 = value.size
          if __lux_tmp_198 == nil then
            __lux_tmp_198 = value[1]
          end
          __lux_tmp_197 = __lux_tmp_198
        end
        local __lux_tmp_199 = toNumber(__lux_tmp_197)
        if __lux_tmp_199 == nil then
          __lux_tmp_199 = 0
        end
        blur = mathMax(0, __lux_tmp_199)
      end
      do
        local __lux_tmp_200 = transparentColor
        if __lux_tmp_200 == nil then
          __lux_tmp_200 = makeColor(0, 0, 0, 0)
        end
        transparentColor = __lux_tmp_200
      end
      local tint
      do
        local __lux_tmp_201 = value.tint
        if __lux_tmp_201 == nil then
          __lux_tmp_201 = value.color
        end
        tint = colorOr(__lux_tmp_201, transparentColor)
      end
      local opacity
      do
        local __lux_tmp_202 = value.opacity
        if __lux_tmp_202 == nil then
          __lux_tmp_202 = value.strength
        end
        local __lux_tmp_203 = toNumber(__lux_tmp_202)
        if __lux_tmp_203 == nil then
          __lux_tmp_203 = 1
        end
        opacity = mathClamp(__lux_tmp_203, 0, 1)
      end
      local padding
      do
        local __lux_tmp_204 = value.padding
        if __lux_tmp_204 == nil then
          __lux_tmp_204 = value.spread
        end
        local __lux_tmp_205 = toNumber(__lux_tmp_204)
        if __lux_tmp_205 == nil then
          __lux_tmp_205 = 0
        end
        padding = mathMax(0, __lux_tmp_205)
      end
      local __lux_tmp_206 = blur <= 0
      if __lux_tmp_206 then
        local __lux_cmp_207 = false
        if alpha(tint.a) ~= nil and 0 ~= nil then
          __lux_cmp_207 = alpha(tint.a) <= 0
        end
        __lux_tmp_206 = __lux_cmp_207
      end
      local __lux_tmp_208 = __lux_tmp_206
      if not __lux_tmp_208 then
        __lux_tmp_208 = opacity <= 0
      end
      if __lux_tmp_208 then
        backdropTableCache[value] = false
        return nil
      end
      cached = { blur = blur, tint = tint, opacity = opacity, padding = padding }
      cached._blurInput = value.blur
      cached._sizeInput = value.size
      cached._indexInput = value[1]
      cached._tintInput = value.tint
      cached._colorInput = value.color
      cached._opacityInput = value.opacity
      cached._strengthInput = value.strength
      cached._paddingInput = value.padding
      cached._spreadInput = value.spread
      backdropTableCache[value] = cached
      return cached
    end
    backdrop = function(value)
      return backdropStyle(value)
    end
  end
  do
    GRADIENT_LUT_W = 256
    GRADIENT_LUT_H = 4
    GRADIENT_LUT_CACHE_LIMIT = 128
    gradientLutCache = {}
    gradientFillLutCache = setmetatable({}, { __mode = "k" })
    gradientLutBound = setmetatable({}, { __mode = "k" })
    gradientLutCacheCount = 0
    gradientLutClock = 0
    gradientLutSerial = 0
    gradientLutSchema = "lut-alpha-rgb-v3"
    do
      local __lux_tmp_209
      if bitBor ~= nil then
        __lux_tmp_209 = bitBor(2, 256, 4, 8)
      else
        __lux_tmp_209 = 270
      end
      gradientLutFlags = __lux_tmp_209
    end
    setGradientLutOwner = function(owner)
      gradientLutOwner = owner
      return owner
    end
    gradientLutStat = function(key, amount)
      if amount == nil then
        amount = 1
      end
      local stats
      do
        local __lux_obj_210 = gradientLutOwner
        local __lux_val_211 = nil
        if __lux_obj_210 ~= nil then
          __lux_val_211 = __lux_obj_210.stats
        end
        stats = __lux_val_211
      end
      if stats ~= nil then
        do
          local __lux_tmp_212 = stats[key]
          if __lux_tmp_212 == nil then
            __lux_tmp_212 = 0
          end
          stats[key] = __lux_tmp_212 + amount
        end
      end
    end
    lutColorKey = function(color)
      local c = asColor(color, color_white)
      local __lux_tmp_213 = c.r
      if __lux_tmp_213 == nil then
        __lux_tmp_213 = 0
      end
      local __lux_tmp_214 = c.g
      if __lux_tmp_214 == nil then
        __lux_tmp_214 = 0
      end
      local __lux_tmp_215 = c.b
      if __lux_tmp_215 == nil then
        __lux_tmp_215 = 0
      end
      local __lux_tmp_216 = c.a
      if __lux_tmp_216 == nil then
        __lux_tmp_216 = 255
      end
      return tableConcat(
        {
          mathFloor(__lux_tmp_213),
          mathFloor(__lux_tmp_214),
          mathFloor(__lux_tmp_215),
          mathFloor(__lux_tmp_216),
        },
        ","
      )
    end
    normalizedGradientStops = function(fill)
      local __lux_tmp_217 = typeOf(fill) == "table"
      if __lux_tmp_217 then
        __lux_tmp_217 = fill.stops ~= nil
      end
      local __lux_tmp_218 = __lux_tmp_217
      if __lux_tmp_218 then
        __lux_tmp_218 = #fill.stops > 0
      end
      if __lux_tmp_218 then
        if fill._mgfxStopsNormalized then
          return fill.stops
        end
        return normalizeStops(fill.stops)
      end
      local colorA = nil
      local colorB = nil
      if isColor(fill) then
        colorA = asColor(fill, color_white)
        colorB = colorA
      else
        if typeOf(fill) == "table" then
          do
            local __lux_tmp_219 = fill.colorA
            if __lux_tmp_219 == nil then
              __lux_tmp_219 = fill[1]
            end
            colorA = asColor(__lux_tmp_219, color_white)
          end
          do
            local __lux_tmp_220 = fill.colorB
            if __lux_tmp_220 == nil then
              __lux_tmp_220 = fill[2]
            end
            colorB = asColor(__lux_tmp_220, colorA)
          end
        else
          colorA = asColor(fill, color_white)
          colorB = colorA
        end
      end
      return normalizeStops({ { 0, colorA }, { 1, colorB } })
    end
    gradientFillCacheEntry = function(fill)
      local __lux_tmp_221 = typeOf(fill) ~= "table"
      if not __lux_tmp_221 then
        __lux_tmp_221 = not fill._mgfxLutCacheSafe
      end
      if __lux_tmp_221 then
        return nil
      end
      local cached = gradientFillLutCache[fill]
      if cached == nil then
        return nil
      end
      local entry = cached.entry
      local __lux_tmp_222 = cached.schema ~= gradientLutSchema
      if not __lux_tmp_222 then
        __lux_tmp_222 = entry == nil
      end
      local __lux_tmp_223 = __lux_tmp_222
      if not __lux_tmp_223 then
        __lux_tmp_223 = entry.key ~= cached.key
      end
      if __lux_tmp_223 then
        return nil
      end
      gradientLutClock = gradientLutClock + 1
      entry.tick = gradientLutClock
      gradientLutStat("gradientLutFillHits")
      return entry.texture
    end
    rememberGradientFill = function(fill, key, entry)
      local __lux_tmp_224 = typeOf(fill) ~= "table"
      if not __lux_tmp_224 then
        __lux_tmp_224 = not fill._mgfxLutCacheSafe
      end
      local __lux_tmp_225 = __lux_tmp_224
      if not __lux_tmp_225 then
        __lux_tmp_225 = entry == nil
      end
      if __lux_tmp_225 then
        return nil
      end
      gradientFillLutCache[fill] = { schema = gradientLutSchema, key = key, entry = entry }
    end
    colorAtNormalizedStops = function(stops, t)
      local __lux_tmp_226 = stops == nil
      if not __lux_tmp_226 then
        __lux_tmp_226 = #stops == 0
      end
      if __lux_tmp_226 then
        return color_white
      end
      local amount
      do
        local __lux_tmp_227 = toNumber(t)
        if __lux_tmp_227 == nil then
          __lux_tmp_227 = 0
        end
        amount = mathClamp(__lux_tmp_227, 0, 1)
      end
      for index = 1, #stops - 1 do
        local a = stops[index]
        local b = stops[index + 1]
        if amount <= b.pos then
          local span = mathMax(0.0001, b.pos - a.pos)
          return lerpColor((amount - a.pos) / span, a.color, b.color)
        end
      end
      local __lux_tmp_228 = stops[#stops].color
      if __lux_tmp_228 == nil then
        __lux_tmp_228 = color_white
      end
      return __lux_tmp_228
    end
    gradientLutKey = function(stops)
      local parts = { gradientLutSchema }
      for index = 1, #stops do
        local stop = stops[index]
        do
          local __lux_tmp_229 = stop.pos
          if __lux_tmp_229 == nil then
            __lux_tmp_229 = 0
          end
          parts[#parts + 1] = stringFormat("%.5f:%s", __lux_tmp_229, lutColorKey(stop.color))
        end
      end
      return tableConcat(parts, "|")
    end
    createGradientLutTexture = function(key)
      if getRenderTargetEx == nil then
        return nil
      end
      gradientLutSerial = gradientLutSerial + 1
      local suffix
      if utilCRC ~= nil then
        suffix = utilCRC(key)
      else
        suffix = toString(gradientLutSerial)
      end
      local name = "MGFXGradLUT_" .. toString(gradientLutSerial) .. "_" .. suffix
      local __lux_tmp_230 = MATERIAL_RT_DEPTH_NONE
      if __lux_tmp_230 == nil then
        __lux_tmp_230 = 0
      end
      return getRenderTargetEx(
        name,
        GRADIENT_LUT_W,
        GRADIENT_LUT_H,
        RT_SIZE_LITERAL,
        __lux_tmp_230,
        gradientLutFlags,
        0,
        IMAGE_FORMAT_BGRA8888
      )
    end
    writeGradientLut = function(rt, stops)
      local __lux_tmp_231 = rt == nil
      if not __lux_tmp_231 then
        __lux_tmp_231 = renderPushRenderTarget == nil
      end
      local __lux_tmp_232 = __lux_tmp_231
      if not __lux_tmp_232 then
        __lux_tmp_232 = renderClear == nil
      end
      local __lux_tmp_233 = __lux_tmp_232
      if not __lux_tmp_233 then
        __lux_tmp_233 = camStart2D == nil
      end
      local __lux_tmp_234 = __lux_tmp_233
      if not __lux_tmp_234 then
        __lux_tmp_234 = camEnd2D == nil
      end
      local __lux_tmp_235 = __lux_tmp_234
      if not __lux_tmp_235 then
        __lux_tmp_235 = surfaceSetDrawColor == nil
      end
      local __lux_tmp_236 = __lux_tmp_235
      if not __lux_tmp_236 then
        __lux_tmp_236 = surfaceDrawRect == nil
      end
      if __lux_tmp_236 then
        return false
      end
      renderPushRenderTarget(rt, 0, 0, GRADIENT_LUT_W, GRADIENT_LUT_H)
      if renderSetScissorRect ~= nil then
        renderSetScissorRect(0, 0, 0, 0, false)
      end
      local cr = nil
      local cg = nil
      local cb = nil
      if renderGetColorModulation ~= nil then
        cr, cg, cb = renderGetColorModulation()
      end
      local blend
      if renderGetBlend ~= nil then
        blend = renderGetBlend()
      else
        blend = nil
      end
      local alpha
      if surfaceGetAlphaMultiplier ~= nil then
        alpha = surfaceGetAlphaMultiplier()
      else
        alpha = 1
      end
      if surfaceSetAlphaMultiplier ~= nil then
        surfaceSetAlphaMultiplier(1)
      end
      if renderSetColorModulation ~= nil then
        renderSetColorModulation(1, 1, 1)
      end
      if renderSetBlend ~= nil then
        renderSetBlend(1)
      end
      if renderOverrideAlphaWriteEnable ~= nil then
        renderOverrideAlphaWriteEnable(true, true)
      end
      if renderOverrideBlend ~= nil then
        renderOverrideBlend(
          true,
          BLEND_ONE,
          BLEND_ZERO,
          BLENDFUNC_ADD,
          BLEND_ONE,
          BLEND_ZERO,
          BLENDFUNC_ADD
        )
      end
      renderClear(0, 0, 0, 0, true, true)
      camStart2D()
      for x = 0, GRADIENT_LUT_W - 1 do
        local color = colorAtNormalizedStops(stops, x / (GRADIENT_LUT_W - 1))
        local alphaByte
        do
          local __lux_tmp_237 = color.a
          if __lux_tmp_237 == nil then
            __lux_tmp_237 = 255
          end
          alphaByte = mathClamp(mathFloor(__lux_tmp_237), 0, 255)
        end
        do
          local __lux_tmp_238 = color.r
          if __lux_tmp_238 == nil then
            __lux_tmp_238 = 255
          end
          local __lux_tmp_239 = color.g
          if __lux_tmp_239 == nil then
            __lux_tmp_239 = 255
          end
          local __lux_tmp_240 = color.b
          if __lux_tmp_240 == nil then
            __lux_tmp_240 = 255
          end
          surfaceSetDrawColor(__lux_tmp_238, __lux_tmp_239, __lux_tmp_240, 255)
        end
        surfaceDrawRect(x, 0, 1, 2)
        surfaceSetDrawColor(alphaByte, alphaByte, alphaByte, 255)
        surfaceDrawRect(x, 2, 1, 2)
      end
      camEnd2D()
      if renderOverrideBlend ~= nil then
        renderOverrideBlend(false)
      end
      if renderOverrideAlphaWriteEnable ~= nil then
        renderOverrideAlphaWriteEnable(false)
      end
      if surfaceSetAlphaMultiplier ~= nil then
        surfaceSetAlphaMultiplier(alpha)
      end
      local __lux_tmp_241 = renderSetColorModulation ~= nil
      if __lux_tmp_241 then
        __lux_tmp_241 = cr ~= nil
      end
      if __lux_tmp_241 then
        renderSetColorModulation(cr, cg, cb)
      end
      local __lux_tmp_242 = renderSetBlend ~= nil
      if __lux_tmp_242 then
        __lux_tmp_242 = blend ~= nil
      end
      if __lux_tmp_242 then
        renderSetBlend(blend)
      end
      renderPopRenderTarget()
      gradientLutStat("gradientLutWrites")
      return true
    end
    acquireGradientLutEntry = function(key)
      local cached = gradientLutCache[key]
      if cached ~= nil then
        return cached
      end
      if gradientLutCacheCount < GRADIENT_LUT_CACHE_LIMIT then
        local texture = createGradientLutTexture(key)
        if texture == nil then
          return nil
        end
        cached = { texture = texture }
        gradientLutCache[key] = cached
        gradientLutCacheCount = gradientLutCacheCount + 1
        gradientLutStat("gradientLutCreates")
        return cached
      end
      local oldestKey = nil
      local oldestEntry = nil
      for entryKey, entry in pairs(gradientLutCache) do
        local __lux_tmp_243 = oldestEntry == nil
        if not __lux_tmp_243 then
          local __lux_tmp_244 = entry.tick
          if __lux_tmp_244 == nil then
            __lux_tmp_244 = 0
          end
          local __lux_tmp_245 = oldestEntry.tick
          if __lux_tmp_245 == nil then
            __lux_tmp_245 = 0
          end
          __lux_tmp_243 = __lux_tmp_244 < __lux_tmp_245
        end
        if __lux_tmp_243 then
          oldestKey = entryKey
          oldestEntry = entry
        end
      end
      if oldestEntry == nil then
        return nil
      end
      gradientLutCache[oldestKey] = nil
      gradientLutCache[key] = oldestEntry
      gradientLutStat("gradientLutReuses")
      return oldestEntry
    end
    gradientLutForFill = function(fill)
      local cached = gradientFillCacheEntry(fill)
      if cached ~= nil then
        return cached
      end
      local stops = normalizedGradientStops(fill)
      if stops == nil then
        return nil
      end
      local key = gradientLutKey(stops)
      gradientLutClock = gradientLutClock + 1
      local entry = acquireGradientLutEntry(key)
      if entry == nil then
        return nil
      end
      if entry.key ~= key then
        writeGradientLut(entry.texture, stops)
        entry.key = key
      end
      entry.tick = gradientLutClock
      rememberGradientFill(fill, key, entry)
      return entry.texture
    end
    bindGradientLut = function(material, fill)
      local __lux_tmp_246 = material == nil
      if not __lux_tmp_246 then
        __lux_tmp_246 = material.SetTexture == nil
      end
      if __lux_tmp_246 then
        return nil
      end
      local lut = gradientLutForFill(fill)
      local __lux_tmp_247 = lut ~= nil
      if __lux_tmp_247 then
        __lux_tmp_247 = gradientLutBound[material] ~= lut
      end
      if __lux_tmp_247 then
        material:SetTexture("$texture1", lut)
        gradientLutBound[material] = lut
      end
      return lut
    end
    gradientLutStatus = function()
      return {
        count = gradientLutCacheCount,
        limit = GRADIENT_LUT_CACHE_LIMIT,
        clock = gradientLutClock,
        schema = gradientLutSchema,
      }
    end
  end
  do
    install = function(owner)
      setGradientLutOwner(owner)
      owner.Solid = solid
      owner.LinearGradient = linearGradient
      owner.LinearGradientStops = linearGradientStops
      owner.RadialGradient = radialGradient
      owner.RingRadialGradient = ringRadialGradient
      owner.SectorRadialGradient = sectorRadialGradient
      owner.ConicGradient = conicGradient
      owner.ShapeAngularGradient = shapeAngularGradient
      owner.RingAngularGradient = ringAngularGradient
      owner.ArcAngularGradient = arcAngularGradient
      owner.SectorAngularGradient = sectorAngularGradient
      owner.StripePattern = stripePattern
      owner.SmokePattern = smokePattern
      owner.Mask = mask
      owner.Backdrop = backdrop
      owner.ImageMaskStyle = imageMaskStyle
      owner.FillFromStyle = fillFromStyle
      owner.ColorAtFill = colorAtFill
      owner.NormalizedRotation = normalizedRotation
      owner.GlowSoftnessToFalloff = glowSoftnessToFalloff
      owner.BackdropStyle = backdropStyle
      owner.GradientLutForFill = gradientLutForFill
      owner.BindGradientLut = bindGradientLut
      owner.GradientLutStatus = gradientLutStatus
      return owner
    end
  end
  
  __lux_exports.FILL_SOLID = FILL_SOLID
  __lux_exports.FILL_LINEAR = FILL_LINEAR
  __lux_exports.FILL_RADIAL = FILL_RADIAL
  __lux_exports.FILL_CONIC = FILL_CONIC
  __lux_exports.PATTERN_STRIPE = PATTERN_STRIPE
  __lux_exports.PATTERN_SMOKE = PATTERN_SMOKE
  __lux_exports.isColor = isColor
  __lux_exports.byte = byte
  __lux_exports.alpha = alpha
  __lux_exports.colorOr = colorOr
  __lux_exports.asColor = asColor
  __lux_exports.color01 = color01
  __lux_exports.setDrawColor = setDrawColor
  __lux_exports.copyColor = copyColor
  __lux_exports.withAlpha = withAlpha
  __lux_exports.lerpColor = lerpColor
  __lux_exports.strokeWidth = strokeWidth
  __lux_exports.strokeWidthValue = strokeWidthValue
  __lux_exports.radiusTuple = radiusTuple
  __lux_exports.radiusScalar = radiusScalar
  __lux_exports.normalizeStops = normalizeStops
  __lux_exports.stopsVisible = stopsVisible
  __lux_exports.firstLastStops = firstLastStops
  __lux_exports.colorAtStops = colorAtStops
  __lux_exports.solid = solid
  __lux_exports.linearGradient = linearGradient
  __lux_exports.linearGradientStops = linearGradientStops
  __lux_exports.radialGradient = radialGradient
  __lux_exports.conicGradient = conicGradient
  __lux_exports.ringRadialGradient = ringRadialGradient
  __lux_exports.sectorRadialGradient = sectorRadialGradient
  __lux_exports.shapeAngularGradient = shapeAngularGradient
  __lux_exports.ringAngularGradient = ringAngularGradient
  __lux_exports.arcAngularGradient = arcAngularGradient
  __lux_exports.sectorAngularGradient = sectorAngularGradient
  __lux_exports.stripePattern = stripePattern
  __lux_exports.smokePattern = smokePattern
  __lux_exports.mask = mask
  __lux_exports.imageMaskStyle = imageMaskStyle
  __lux_exports.fillFromStyle = fillFromStyle
  __lux_exports.fillFrom = fillFrom
  __lux_exports.colorAtFill = colorAtFill
  __lux_exports.fillVisible = fillVisible
  __lux_exports.strokeVisible = strokeVisible
  __lux_exports.normalizedRotation = normalizedRotation
  __lux_exports.glowSoftnessToFalloff = glowSoftnessToFalloff
  __lux_exports.backdropStyle = backdropStyle
  __lux_exports.backdrop = backdrop
  __lux_exports.gradientLutForFill = gradientLutForFill
  __lux_exports.bindGradientLut = bindGradientLut
  __lux_exports.gradientLutStatus = gradientLutStatus
  __lux_exports.install = install
  
  return __lux_exports
end
