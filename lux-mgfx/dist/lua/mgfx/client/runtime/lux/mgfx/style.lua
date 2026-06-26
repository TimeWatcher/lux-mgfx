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
  local wornPattern
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
      local __lux_obj_bit_1 = bit
      local __lux_val_bor_2 = nil
      if __lux_obj_bit_1 ~= nil then
        __lux_val_bor_2 = __lux_obj_bit_1.bor
      end
      bitBor = __lux_val_bor_2
    end
    do
      local __lux_obj_cam_3 = cam
      local __lux_val_Start2D_4 = nil
      if __lux_obj_cam_3 ~= nil then
        __lux_val_Start2D_4 = __lux_obj_cam_3.Start2D
      end
      camStart2D = __lux_val_Start2D_4
    end
    do
      local __lux_obj_cam_5 = cam
      local __lux_val_End2D_6 = nil
      if __lux_obj_cam_5 ~= nil then
        __lux_val_End2D_6 = __lux_obj_cam_5.End2D
      end
      camEnd2D = __lux_val_End2D_6
    end
    getRenderTargetEx = GetRenderTargetEx
    makeColor = Color
    mathAbs = math.abs
    mathClamp = math.Clamp
    mathFloor = math.floor
    mathMax = math.max
    do
      local __lux_obj_render_7 = render
      local __lux_val_Clear_8 = nil
      if __lux_obj_render_7 ~= nil then
        __lux_val_Clear_8 = __lux_obj_render_7.Clear
      end
      renderClear = __lux_val_Clear_8
    end
    do
      local __lux_obj_render_9 = render
      local __lux_val_GetBlend_10 = nil
      if __lux_obj_render_9 ~= nil then
        __lux_val_GetBlend_10 = __lux_obj_render_9.GetBlend
      end
      renderGetBlend = __lux_val_GetBlend_10
    end
    do
      local __lux_obj_render_11 = render
      local __lux_val_GetColorModulation_12 = nil
      if __lux_obj_render_11 ~= nil then
        __lux_val_GetColorModulation_12 = __lux_obj_render_11.GetColorModulation
      end
      renderGetColorModulation = __lux_val_GetColorModulation_12
    end
    do
      local __lux_obj_render_13 = render
      local __lux_val_OverrideAlphaWriteEnable_14 = nil
      if __lux_obj_render_13 ~= nil then
        __lux_val_OverrideAlphaWriteEnable_14 = __lux_obj_render_13.OverrideAlphaWriteEnable
      end
      renderOverrideAlphaWriteEnable = __lux_val_OverrideAlphaWriteEnable_14
    end
    do
      local __lux_obj_render_15 = render
      local __lux_val_OverrideBlend_16 = nil
      if __lux_obj_render_15 ~= nil then
        __lux_val_OverrideBlend_16 = __lux_obj_render_15.OverrideBlend
      end
      renderOverrideBlend = __lux_val_OverrideBlend_16
    end
    do
      local __lux_obj_render_17 = render
      local __lux_val_PopRenderTarget_18 = nil
      if __lux_obj_render_17 ~= nil then
        __lux_val_PopRenderTarget_18 = __lux_obj_render_17.PopRenderTarget
      end
      renderPopRenderTarget = __lux_val_PopRenderTarget_18
    end
    do
      local __lux_obj_render_19 = render
      local __lux_val_PushRenderTarget_20 = nil
      if __lux_obj_render_19 ~= nil then
        __lux_val_PushRenderTarget_20 = __lux_obj_render_19.PushRenderTarget
      end
      renderPushRenderTarget = __lux_val_PushRenderTarget_20
    end
    do
      local __lux_obj_render_21 = render
      local __lux_val_SetBlend_22 = nil
      if __lux_obj_render_21 ~= nil then
        __lux_val_SetBlend_22 = __lux_obj_render_21.SetBlend
      end
      renderSetBlend = __lux_val_SetBlend_22
    end
    do
      local __lux_obj_render_23 = render
      local __lux_val_SetColorModulation_24 = nil
      if __lux_obj_render_23 ~= nil then
        __lux_val_SetColorModulation_24 = __lux_obj_render_23.SetColorModulation
      end
      renderSetColorModulation = __lux_val_SetColorModulation_24
    end
    do
      local __lux_obj_render_25 = render
      local __lux_val_SetScissorRect_26 = nil
      if __lux_obj_render_25 ~= nil then
        __lux_val_SetScissorRect_26 = __lux_obj_render_25.SetScissorRect
      end
      renderSetScissorRect = __lux_val_SetScissorRect_26
    end
    stringLower = string.lower
    stringFormat = string.format
    do
      local __lux_obj_surface_27 = surface
      local __lux_val_DrawRect_28 = nil
      if __lux_obj_surface_27 ~= nil then
        __lux_val_DrawRect_28 = __lux_obj_surface_27.DrawRect
      end
      surfaceDrawRect = __lux_val_DrawRect_28
    end
    do
      local __lux_obj_surface_29 = surface
      local __lux_val_GetAlphaMultiplier_30 = nil
      if __lux_obj_surface_29 ~= nil then
        __lux_val_GetAlphaMultiplier_30 = __lux_obj_surface_29.GetAlphaMultiplier
      end
      surfaceGetAlphaMultiplier = __lux_val_GetAlphaMultiplier_30
    end
    do
      local __lux_obj_surface_31 = surface
      local __lux_val_SetAlphaMultiplier_32 = nil
      if __lux_obj_surface_31 ~= nil then
        __lux_val_SetAlphaMultiplier_32 = __lux_obj_surface_31.SetAlphaMultiplier
      end
      surfaceSetAlphaMultiplier = __lux_val_SetAlphaMultiplier_32
    end
    do
      local __lux_obj_surface_33 = surface
      local __lux_val_SetDrawColor_34 = nil
      if __lux_obj_surface_33 ~= nil then
        __lux_val_SetDrawColor_34 = __lux_obj_surface_33.SetDrawColor
      end
      surfaceSetDrawColor = __lux_val_SetDrawColor_34
    end
    tableConcat = table.concat
    tableCopy = table.Copy
    tableInsert = table.insert
    tableSort = table.sort
    toNumber = tonumber
    toString = tostring
    typeOf = type
    do
      local __lux_obj_util_35 = util
      local __lux_val_CRC_36 = nil
      if __lux_obj_util_35 ~= nil then
        __lux_val_CRC_36 = __lux_obj_util_35.CRC
      end
      utilCRC = __lux_val_CRC_36
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
      return typeOf(value) == "table" and value.r ~= nil and value.g ~= nil and value.b ~= nil
    end
    byte = function(value, fallback)
      if fallback == nil then
        fallback = 0
      end
      local nextValue = toNumber(value)
      if nextValue == nil then
        nextValue = fallback
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
      local __lux_tmp_fallback_37 = fallback
      if __lux_tmp_fallback_37 == nil then
        __lux_tmp_fallback_37 = color_white
      end
      if __lux_tmp_fallback_37 == nil then
        __lux_tmp_fallback_37 = makeColor(255, 255, 255, 255)
      end
      return __lux_tmp_fallback_37
    end
    asColor = function(value, fallback)
      return colorOr(value, fallback)
    end
    color01 = function(color)
      local c = colorOr(color)
      local __lux_tmp_r_38 = c.r
      if __lux_tmp_r_38 == nil then
        __lux_tmp_r_38 = 0
      end
      local __lux_tmp_g_39 = c.g
      if __lux_tmp_g_39 == nil then
        __lux_tmp_g_39 = 0
      end
      local __lux_tmp_b_40 = c.b
      if __lux_tmp_b_40 == nil then
        __lux_tmp_b_40 = 0
      end
      return mathClamp(__lux_tmp_r_38 / 255, 0, 1), mathClamp(__lux_tmp_g_39 / 255, 0, 1), mathClamp(__lux_tmp_b_40 / 255, 0, 1), mathClamp(alpha(c.a) / 255, 0, 1)
    end
    setDrawColor = function(color)
      local c = colorOr(color)
      local __lux_tmp_r_41 = c.r
      if __lux_tmp_r_41 == nil then
        __lux_tmp_r_41 = 255
      end
      local __lux_tmp_g_42 = c.g
      if __lux_tmp_g_42 == nil then
        __lux_tmp_g_42 = 255
      end
      local __lux_tmp_b_43 = c.b
      if __lux_tmp_b_43 == nil then
        __lux_tmp_b_43 = 255
      end
      return surfaceSetDrawColor(__lux_tmp_r_41, __lux_tmp_g_42, __lux_tmp_b_43, alpha(c.a))
    end
    copyColor = function(color)
      local c = colorOr(color)
      local __lux_tmp_r_44 = c.r
      if __lux_tmp_r_44 == nil then
        __lux_tmp_r_44 = 255
      end
      local __lux_tmp_g_45 = c.g
      if __lux_tmp_g_45 == nil then
        __lux_tmp_g_45 = 255
      end
      local __lux_tmp_b_46 = c.b
      if __lux_tmp_b_46 == nil then
        __lux_tmp_b_46 = 255
      end
      return makeColor(__lux_tmp_r_44, __lux_tmp_g_45, __lux_tmp_b_46, alpha(c.a))
    end
    withAlpha = function(color, nextAlpha)
      local c = colorOr(color)
      local __lux_tmp_r_47 = c.r
      if __lux_tmp_r_47 == nil then
        __lux_tmp_r_47 = 255
      end
      local __lux_tmp_g_48 = c.g
      if __lux_tmp_g_48 == nil then
        __lux_tmp_g_48 = 255
      end
      local __lux_tmp_b_49 = c.b
      if __lux_tmp_b_49 == nil then
        __lux_tmp_b_49 = 255
      end
      return makeColor(__lux_tmp_r_47, __lux_tmp_g_48, __lux_tmp_b_49, byte(nextAlpha, alpha(c.a)))
    end
    lerpColor = function(t, from, to)
      local a = colorOr(from)
      local b = colorOr(to, a)
      local amount
      do
        local __lux_tmp_t_50 = toNumber(t)
        if __lux_tmp_t_50 == nil then
          __lux_tmp_t_50 = 0
        end
        amount = mathClamp(__lux_tmp_t_50, 0, 1)
      end
      local __lux_tmp_r_51 = a.r
      if __lux_tmp_r_51 == nil then
        __lux_tmp_r_51 = 0
      end
      local __lux_tmp_r_52 = b.r
      if __lux_tmp_r_52 == nil then
        __lux_tmp_r_52 = 0
      end
      local __lux_tmp_r_53 = a.r
      if __lux_tmp_r_53 == nil then
        __lux_tmp_r_53 = 0
      end
      local __lux_tmp_g_54 = a.g
      if __lux_tmp_g_54 == nil then
        __lux_tmp_g_54 = 0
      end
      local __lux_tmp_g_55 = b.g
      if __lux_tmp_g_55 == nil then
        __lux_tmp_g_55 = 0
      end
      local __lux_tmp_g_56 = a.g
      if __lux_tmp_g_56 == nil then
        __lux_tmp_g_56 = 0
      end
      local __lux_tmp_b_57 = a.b
      if __lux_tmp_b_57 == nil then
        __lux_tmp_b_57 = 0
      end
      local __lux_tmp_b_58 = b.b
      if __lux_tmp_b_58 == nil then
        __lux_tmp_b_58 = 0
      end
      local __lux_tmp_b_59 = a.b
      if __lux_tmp_b_59 == nil then
        __lux_tmp_b_59 = 0
      end
      return makeColor(
        byte(__lux_tmp_r_51 + (__lux_tmp_r_52 - __lux_tmp_r_53) * amount),
        byte(__lux_tmp_g_54 + (__lux_tmp_g_55 - __lux_tmp_g_56) * amount),
        byte(__lux_tmp_b_57 + (__lux_tmp_b_58 - __lux_tmp_b_59) * amount),
        byte(alpha(a.a) + (alpha(b.a) - alpha(a.a)) * amount)
      )
    end
    strokeWidth = function(value, fallback)
      if fallback == nil then
        fallback = 0
      end
      if value == true then
        local __lux_tmp_fallback_60 = fallback
        if __lux_tmp_fallback_60 == nil then
          __lux_tmp_fallback_60 = 1
        end
        return __lux_tmp_fallback_60
      end
      if typeOf(value) == "string" then
        local alias
        local __lux_match_61 = stringLower(value)
        if __lux_match_61 == "hairline" then
          alias = 0.75
        elseif __lux_match_61 == "thin" then
          alias = 1
        elseif __lux_match_61 == "none" then
          alias = 0
        else
          alias = nil
        end
        if alias ~= nil then
          return alias
        end
      end
      local __lux_tmp_value_62 = toNumber(value)
      if __lux_tmp_value_62 == nil then
        __lux_tmp_value_62 = fallback
      end
      if __lux_tmp_value_62 == nil then
        __lux_tmp_value_62 = 0
      end
      return __lux_tmp_value_62
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
      if typeOf(radius) == "table" and not isColor(radius) then
        do
          local __lux_tmp_tl_63 = radius.tl
          if __lux_tmp_tl_63 == nil then
            __lux_tmp_tl_63 = radius[1]
          end
          local __lux_tmp_tl_64 = toNumber(__lux_tmp_tl_63)
          if __lux_tmp_tl_64 == nil then
            __lux_tmp_tl_64 = 0
          end
          tl = __lux_tmp_tl_64
        end
        do
          local __lux_tmp_tr_65 = radius.tr
          if __lux_tmp_tr_65 == nil then
            __lux_tmp_tr_65 = radius[2]
          end
          local __lux_tmp_tr_66 = toNumber(__lux_tmp_tr_65)
          if __lux_tmp_tr_66 == nil then
            __lux_tmp_tr_66 = tl
          end
          tr = __lux_tmp_tr_66
        end
        do
          local __lux_tmp_br_67 = radius.br
          if __lux_tmp_br_67 == nil then
            __lux_tmp_br_67 = radius[3]
          end
          local __lux_tmp_br_68 = toNumber(__lux_tmp_br_67)
          if __lux_tmp_br_68 == nil then
            __lux_tmp_br_68 = tr
          end
          br = __lux_tmp_br_68
        end
        do
          local __lux_tmp_bl_69 = radius.bl
          if __lux_tmp_bl_69 == nil then
            __lux_tmp_bl_69 = radius[4]
          end
          local __lux_tmp_bl_70 = toNumber(__lux_tmp_bl_69)
          if __lux_tmp_bl_70 == nil then
            __lux_tmp_bl_70 = br
          end
          bl = __lux_tmp_bl_70
        end
      else
        do
          local __lux_tmp_radius_71 = toNumber(radius)
          if __lux_tmp_radius_71 == nil then
            __lux_tmp_radius_71 = 0
          end
          tl = __lux_tmp_radius_71
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
        local __lux_tmp_w_72 = toNumber(w)
        if __lux_tmp_w_72 == nil then
          __lux_tmp_w_72 = 0.0001
        end
        width = mathMax(0.0001, __lux_tmp_w_72)
      end
      local height
      do
        local __lux_tmp_h_73 = toNumber(h)
        if __lux_tmp_h_73 == nil then
          __lux_tmp_h_73 = 0.0001
        end
        height = mathMax(0.0001, __lux_tmp_h_73)
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
            local __lux_tmp_74
            if #stops <= 1 then
              __lux_tmp_74 = 0
            else
              __lux_tmp_74 = (index - 1) / (#stops - 1)
            end
            position = __lux_tmp_74
          end
        else
          if typeOf(stop) == "table" then
            do
              local __lux_tmp_pos_75 = stop.pos
              if __lux_tmp_pos_75 == nil then
                __lux_tmp_pos_75 = stop.t
              end
              if __lux_tmp_pos_75 == nil then
                __lux_tmp_pos_75 = stop.offset
              end
              if __lux_tmp_pos_75 == nil then
                __lux_tmp_pos_75 = stop[1]
              end
              position = __lux_tmp_pos_75
            end
            do
              local __lux_tmp_color_76 = stop.color
              if __lux_tmp_color_76 == nil then
                __lux_tmp_color_76 = stop[2]
              end
              color = __lux_tmp_color_76
            end
          end
        end
        if color ~= nil then
          do
            local __lux_tmp_position_77 = toNumber(position)
            if __lux_tmp_position_77 == nil then
              local __lux_tmp_78
              if #stops <= 1 then
                __lux_tmp_78 = 0
              else
                __lux_tmp_78 = (index - 1) / (#stops - 1)
              end
              __lux_tmp_position_77 = __lux_tmp_78
            end
            out[#out + 1] = { pos = mathClamp(__lux_tmp_position_77, 0, 1), color = colorOr(color) }
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
        local __lux_tmp_stops_79 = stops
        if __lux_tmp_stops_79 == nil then
          __lux_tmp_stops_79 = {}
        end
        for _, stop in ipairs(__lux_tmp_stops_79) do
          local color = stop.color
          if color == nil then
            color = stop[2]
          end
          if color ~= nil then
            local __lux_cmp_80 = false
            if alpha(color.a) ~= nil then
              __lux_cmp_80 = alpha(color.a) > 0
            end
            if __lux_cmp_80 then
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
        local __lux_tmp_t_81 = toNumber(t)
        if __lux_tmp_t_81 == nil then
          __lux_tmp_t_81 = 0
        end
        amount = mathClamp(__lux_tmp_t_81, 0, 1)
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
        local __lux_cmp_82 = false
        if alpha(c.a) ~= nil then
          __lux_cmp_82 = alpha(c.a) > 0
        end
        cached = { kind = FILL_SOLID, colorA = c, colorB = c, _mgfxFillVisible = __lux_cmp_82 }
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
      if typeOf(stopsOrColorA) == "table" and not isColor(stopsOrColorA) then
        colorA, colorB, stops = firstLastStops(stopsOrColorA)
      else
        colorA = colorOr(stopsOrColorA)
        colorB = colorOr(colorB, colorA)
        stops = twoColorStops(colorA, colorB)
      end
      local __lux_tmp_x1_83 = toNumber(x1)
      if __lux_tmp_x1_83 == nil then
        __lux_tmp_x1_83 = 0
      end
      local __lux_tmp_y1_84 = toNumber(y1)
      if __lux_tmp_y1_84 == nil then
        __lux_tmp_y1_84 = 0
      end
      local __lux_tmp_x2_85 = toNumber(x2)
      if __lux_tmp_x2_85 == nil then
        __lux_tmp_x2_85 = 1
      end
      local __lux_tmp_y2_86 = toNumber(y2)
      if __lux_tmp_y2_86 == nil then
        __lux_tmp_y2_86 = 1
      end
      return gradient(
        FILL_LINEAR,
        colorA,
        colorB,
        stops,
        {
          x1 = __lux_tmp_x1_83,
          y1 = __lux_tmp_y1_84,
          x2 = __lux_tmp_x2_85,
          y2 = __lux_tmp_y2_86,
        }
      )
    end
    linearGradientStops = function(x1, y1, x2, y2, stops)
      return linearGradient(x1, y1, x2, y2, stops, nil)
    end
    radialGradient = function(cx, cy, radius, stopsOrColorA, colorB)
      local colorA
      local stops
      if typeOf(stopsOrColorA) == "table" and not isColor(stopsOrColorA) then
        colorA, colorB, stops = firstLastStops(stopsOrColorA)
      else
        colorA = colorOr(stopsOrColorA)
        colorB = colorOr(colorB, colorA)
        stops = twoColorStops(colorA, colorB)
      end
      local __lux_tmp_cx_87 = toNumber(cx)
      if __lux_tmp_cx_87 == nil then
        __lux_tmp_cx_87 = 0.5
      end
      local __lux_tmp_cy_88 = toNumber(cy)
      if __lux_tmp_cy_88 == nil then
        __lux_tmp_cy_88 = 0.5
      end
      local __lux_tmp_radius_89 = toNumber(radius)
      if __lux_tmp_radius_89 == nil then
        __lux_tmp_radius_89 = 0.5
      end
      return gradient(
        FILL_RADIAL,
        colorA,
        colorB,
        stops,
        { cx = __lux_tmp_cx_87, cy = __lux_tmp_cy_88, radius = __lux_tmp_radius_89 }
      )
    end
    conicGradient = function(cx, cy, rotation, stopsOrColorA, colorB)
      local colorA
      local stops
      if typeOf(stopsOrColorA) == "table" and not isColor(stopsOrColorA) then
        colorA, colorB, stops = firstLastStops(stopsOrColorA)
      else
        colorA = colorOr(stopsOrColorA)
        colorB = colorOr(colorB, colorA)
        stops = twoColorStops(colorA, colorB)
      end
      local __lux_tmp_cx_90 = toNumber(cx)
      if __lux_tmp_cx_90 == nil then
        __lux_tmp_cx_90 = 0.5
      end
      local __lux_tmp_cy_91 = toNumber(cy)
      if __lux_tmp_cy_91 == nil then
        __lux_tmp_cy_91 = 0.5
      end
      local __lux_tmp_rotation_92 = toNumber(rotation)
      if __lux_tmp_rotation_92 == nil then
        __lux_tmp_rotation_92 = 0
      end
      return gradient(
        FILL_CONIC,
        colorA,
        colorB,
        stops,
        { cx = __lux_tmp_cx_90, cy = __lux_tmp_cy_91, rotation = __lux_tmp_rotation_92 }
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
      if typeOf(stopsOrColorA) == "table" and not isColor(stopsOrColorA) and typeOf(colorB) == "number" and rotation == nil then
        rotation = colorB
        colorB = nil
      end
      local fill
      do
        local __lux_tmp_rotation_93 = rotation
        if __lux_tmp_rotation_93 == nil then
          __lux_tmp_rotation_93 = 0
        end
        fill = conicGradient(0.5, 0.5, __lux_tmp_rotation_93, stopsOrColorA, colorB)
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
        local __lux_obj_util_94 = util
        local __lux_val_CRC_95 = nil
        if __lux_obj_util_94 ~= nil then
          __lux_val_CRC_95 = __lux_obj_util_94.CRC
        end
        utilCrc = __lux_val_CRC_95
      end
      if value == nil and utilCrc ~= nil then
        value = toNumber(utilCrc(toString(seed)))
      end
      do
        local __lux_tmp_value_96 = value
        if __lux_tmp_value_96 == nil then
          __lux_tmp_value_96 = 0
        end
        value = mathAbs(__lux_tmp_value_96) % 65536
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
      if typeOf(color) == "table" and not isColor(color) then
        local __lux_tmp_color_97 = color.color
        if __lux_tmp_color_97 == nil then
          __lux_tmp_color_97 = color.tint
        end
        local __lux_tmp_spacing_98 = toNumber(color.spacing)
        if __lux_tmp_spacing_98 == nil then
          __lux_tmp_spacing_98 = 12
        end
        local __lux_tmp_width_99 = toNumber(color.width)
        if __lux_tmp_width_99 == nil then
          __lux_tmp_width_99 = 2
        end
        local __lux_tmp_angle_100 = toNumber(color.angle)
        if __lux_tmp_angle_100 == nil then
          __lux_tmp_angle_100 = 135
        end
        local __lux_tmp_offset_101 = toNumber(color.offset)
        if __lux_tmp_offset_101 == nil then
          __lux_tmp_offset_101 = 0
        end
        return {
          kind = PATTERN_STRIPE,
          color = colorOr(__lux_tmp_color_97, makeColor(255, 255, 255, 24)),
          spacing = __lux_tmp_spacing_98,
          width = __lux_tmp_width_99,
          angle = __lux_tmp_angle_100,
          offset = __lux_tmp_offset_101,
        }
      end
      local __lux_tmp_spacing_102 = toNumber(spacing)
      if __lux_tmp_spacing_102 == nil then
        __lux_tmp_spacing_102 = 12
      end
      local __lux_tmp_width_103 = toNumber(width)
      if __lux_tmp_width_103 == nil then
        __lux_tmp_width_103 = 2
      end
      local __lux_tmp_angle_104 = toNumber(angle)
      if __lux_tmp_angle_104 == nil then
        __lux_tmp_angle_104 = 135
      end
      local __lux_tmp_offset_105 = toNumber(offset)
      if __lux_tmp_offset_105 == nil then
        __lux_tmp_offset_105 = 0
      end
      return {
        kind = PATTERN_STRIPE,
        color = colorOr(color, makeColor(255, 255, 255, 24)),
        spacing = __lux_tmp_spacing_102,
        width = __lux_tmp_width_103,
        angle = __lux_tmp_angle_104,
        offset = __lux_tmp_offset_105,
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
      if typeOf(color) == "table" and not isColor(color) then
        local __lux_tmp_color_106 = color.color
        if __lux_tmp_color_106 == nil then
          __lux_tmp_color_106 = color.tint
        end
        local __lux_tmp_scale_107 = toNumber(color.scale)
        if __lux_tmp_scale_107 == nil then
          __lux_tmp_scale_107 = 140
        end
        local __lux_tmp_density_108 = toNumber(color.density)
        if __lux_tmp_density_108 == nil then
          __lux_tmp_density_108 = 0.48
        end
        local __lux_tmp_softness_109 = toNumber(color.softness)
        if __lux_tmp_softness_109 == nil then
          __lux_tmp_softness_109 = 0.3
        end
        local __lux_tmp_angle_110 = toNumber(color.angle)
        if __lux_tmp_angle_110 == nil then
          __lux_tmp_angle_110 = 135
        end
        local __lux_tmp_offset_111 = toNumber(color.offset)
        if __lux_tmp_offset_111 == nil then
          __lux_tmp_offset_111 = 0
        end
        local __lux_tmp_speed_112 = toNumber(color.speed)
        if __lux_tmp_speed_112 == nil then
          __lux_tmp_speed_112 = 0
        end
        local __lux_tmp_warp_113 = toNumber(color.warp)
        if __lux_tmp_warp_113 == nil then
          __lux_tmp_warp_113 = 0.85
        end
        return {
          kind = PATTERN_SMOKE,
          color = colorOr(__lux_tmp_color_106, makeColor(255, 255, 255, 24)),
          scale = __lux_tmp_scale_107,
          density = __lux_tmp_density_108,
          softness = __lux_tmp_softness_109,
          angle = __lux_tmp_angle_110,
          offset = __lux_tmp_offset_111,
          speed = __lux_tmp_speed_112,
          warp = __lux_tmp_warp_113,
          seed = patternSeed(color.seed),
        }
      end
      local __lux_tmp_scale_114 = toNumber(scale)
      if __lux_tmp_scale_114 == nil then
        __lux_tmp_scale_114 = 140
      end
      local __lux_tmp_density_115 = toNumber(density)
      if __lux_tmp_density_115 == nil then
        __lux_tmp_density_115 = 0.48
      end
      local __lux_tmp_softness_116 = toNumber(softness)
      if __lux_tmp_softness_116 == nil then
        __lux_tmp_softness_116 = 0.3
      end
      local __lux_tmp_angle_117 = toNumber(angle)
      if __lux_tmp_angle_117 == nil then
        __lux_tmp_angle_117 = 135
      end
      local __lux_tmp_offset_118 = toNumber(offset)
      if __lux_tmp_offset_118 == nil then
        __lux_tmp_offset_118 = 0
      end
      return {
        kind = PATTERN_SMOKE,
        color = colorOr(color, makeColor(255, 255, 255, 24)),
        scale = __lux_tmp_scale_114,
        density = __lux_tmp_density_115,
        softness = __lux_tmp_softness_116,
        angle = __lux_tmp_angle_117,
        offset = __lux_tmp_offset_118,
        speed = 0,
        warp = 0.85,
        seed = patternSeed(seed),
      }
    end
    wornPattern = function(spec)
      do
        local __lux_tmp_119
        if typeOf(spec) == "table" then
          __lux_tmp_119 = spec
        else
          __lux_tmp_119 = {}
        end
        spec = __lux_tmp_119
      end
      local __lux_tmp_color_120 = spec.color
      if __lux_tmp_color_120 == nil then
        __lux_tmp_color_120 = spec.tint
      end
      local __lux_tmp_edgeColor_121 = spec.edgeColor
      if __lux_tmp_edgeColor_121 == nil then
        __lux_tmp_edgeColor_121 = spec.highlight
      end
      local __lux_tmp_fractal_122 = toNumber(spec.fractal)
      if __lux_tmp_fractal_122 == nil then
        __lux_tmp_fractal_122 = 0.44
      end
      local __lux_tmp_grain_123 = toNumber(spec.grain)
      if __lux_tmp_grain_123 == nil then
        __lux_tmp_grain_123 = 0.64
      end
      local __lux_tmp_scratches_124 = spec.scratches
      if __lux_tmp_scratches_124 == nil then
        __lux_tmp_scratches_124 = spec.scratch
      end
      local __lux_tmp_scratches_125 = toNumber(__lux_tmp_scratches_124)
      if __lux_tmp_scratches_125 == nil then
        __lux_tmp_scratches_125 = 0.30
      end
      local __lux_tmp_edge_126 = spec.edge
      if __lux_tmp_edge_126 == nil then
        __lux_tmp_edge_126 = spec.edgeWear
      end
      local __lux_tmp_edge_127 = toNumber(__lux_tmp_edge_126)
      if __lux_tmp_edge_127 == nil then
        __lux_tmp_edge_127 = 0.54
      end
      local __lux_tmp_scale_128 = toNumber(spec.scale)
      if __lux_tmp_scale_128 == nil then
        __lux_tmp_scale_128 = 32
      end
      local __lux_tmp_grainScale_129 = toNumber(spec.grainScale)
      if __lux_tmp_grainScale_129 == nil then
        __lux_tmp_grainScale_129 = 5.6
      end
      local __lux_tmp_scratchScale_130 = toNumber(spec.scratchScale)
      if __lux_tmp_scratchScale_130 == nil then
        __lux_tmp_scratchScale_130 = 26
      end
      local __lux_tmp_scratchWidth_131 = toNumber(spec.scratchWidth)
      if __lux_tmp_scratchWidth_131 == nil then
        __lux_tmp_scratchWidth_131 = 0.045
      end
      local __lux_tmp_edgeWidth_132 = toNumber(spec.edgeWidth)
      if __lux_tmp_edgeWidth_132 == nil then
        __lux_tmp_edgeWidth_132 = 7
      end
      local __lux_tmp_softness_133 = toNumber(spec.softness)
      if __lux_tmp_softness_133 == nil then
        __lux_tmp_softness_133 = 0.10
      end
      local __lux_tmp_warp_134 = toNumber(spec.warp)
      if __lux_tmp_warp_134 == nil then
        __lux_tmp_warp_134 = 0.035
      end
      local __lux_tmp_angle_135 = toNumber(spec.angle)
      if __lux_tmp_angle_135 == nil then
        __lux_tmp_angle_135 = -14
      end
      local __lux_tmp_offset_136 = toNumber(spec.offset)
      if __lux_tmp_offset_136 == nil then
        __lux_tmp_offset_136 = 0
      end
      local __lux_tmp_speed_137 = toNumber(spec.speed)
      if __lux_tmp_speed_137 == nil then
        __lux_tmp_speed_137 = 0
      end
      return {
        kind = "worn",
        color = colorOr(__lux_tmp_color_120, makeColor(0, 0, 0, 44)),
        edgeColor = colorOr(__lux_tmp_edgeColor_121, makeColor(218, 208, 184, 78)),
        fractal = mathClamp(__lux_tmp_fractal_122, 0, 1),
        grain = mathClamp(__lux_tmp_grain_123, 0, 1),
        scratches = mathClamp(__lux_tmp_scratches_125, 0, 1),
        edge = mathClamp(__lux_tmp_edge_127, 0, 1),
        scale = mathMax(1, __lux_tmp_scale_128),
        grainScale = mathMax(0.25, __lux_tmp_grainScale_129),
        scratchScale = mathMax(1, __lux_tmp_scratchScale_130),
        scratchWidth = mathClamp(__lux_tmp_scratchWidth_131, 0.005, 0.5),
        edgeWidth = mathMax(0.5, __lux_tmp_edgeWidth_132),
        softness = mathClamp(__lux_tmp_softness_133, 0.001, 1),
        warp = mathMax(0, __lux_tmp_warp_134),
        angle = __lux_tmp_angle_135,
        offset = __lux_tmp_offset_136,
        speed = __lux_tmp_speed_137,
        seed = patternSeed(spec.seed),
      }
    end
  end
  do
    mask = function(kind, spec)
      if typeOf(kind) == "table" then
        local out = tableCopy(kind)
        if out.kind == nil and out.shape ~= nil then
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
        local __lux_tmp_kind_138 = kind
        if __lux_tmp_kind_138 == nil then
          __lux_tmp_kind_138 = out.kind
        end
        out.kind = __lux_tmp_kind_138
      end
      if out.kind == nil and out.shape ~= nil then
        out.kind = out.shape
      end
      out.__mgfxMask = true
      return out
    end
    roundedMaskStyle = function(resolved)
      local __lux_tmp_radius_139 = resolved.radius
      if __lux_tmp_radius_139 == nil then
        __lux_tmp_radius_139 = 0
      end
      return { kind = "rounded", radius = __lux_tmp_radius_139 }
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
      local __lux_match_140 = kind
      if __lux_match_140 == "round" or __lux_match_140 == "rounded" or __lux_match_140 == "roundedbox" or __lux_match_140 == "roundrect" then
        return roundedMaskStyle(resolved)
      elseif __lux_match_140 == "chamfer" or __lux_match_140 == "bevel" then
        return chamferMaskStyle()
      elseif __lux_match_140 == "circle" then
        return circleMaskStyle()
      elseif __lux_match_140 == "capsule" or __lux_match_140 == "pill" then
        return capsuleMaskStyle()
      else
        return nil
      end
    end
    canonicalMaskKind = function(kind)
      local __lux_match_141 = kind
      if __lux_match_141 == "round" or __lux_match_141 == "roundrect" or __lux_match_141 == "roundedbox" then
        return "rounded"
      elseif __lux_match_141 == "bevel" then
        return "chamfer"
      elseif __lux_match_141 == "pill" then
        return "capsule"
      elseif __lux_match_141 == "alpha" or __lux_match_141 == "image" then
        return "texture"
      else
        return kind
      end
    end
    imageMaskStyle = function(maskValue, drawStyle)
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      if maskValue == false or maskValue == "none" then
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
        local __lux_tmp_kind_142 = out.kind
        if __lux_tmp_kind_142 == nil then
          __lux_tmp_kind_142 = out.shape
        end
        if __lux_tmp_kind_142 == nil then
          local __lux_tmp_143
          if out.source ~= nil then
            __lux_tmp_143 = "texture"
          else
            __lux_tmp_143 = nil
          end
          __lux_tmp_kind_142 = __lux_tmp_143
        end
        if __lux_tmp_kind_142 == nil then
          local __lux_tmp_144
          if out.material ~= nil then
            __lux_tmp_144 = "texture"
          else
            __lux_tmp_144 = nil
          end
          __lux_tmp_kind_142 = __lux_tmp_144
        end
        if __lux_tmp_kind_142 == nil then
          local __lux_tmp_145
          if out.texture ~= nil then
            __lux_tmp_145 = "texture"
          else
            __lux_tmp_145 = nil
          end
          __lux_tmp_kind_142 = __lux_tmp_145
        end
        out.kind = __lux_tmp_kind_142
      end
      if typeOf(out.kind) == "string" then
        out.kind = canonicalMaskKind(stringLower(out.kind))
      end
      local __lux_match_146 = out.kind
      if __lux_match_146 == "chamfer" then
        if out.cuts == nil then
          out.cuts = 0
        end
      elseif __lux_match_146 == "rounded" then
        if out.radius == nil then
          do
            local __lux_tmp_radius_147 = resolved.radius
            if __lux_tmp_radius_147 == nil then
              __lux_tmp_radius_147 = 0
            end
            out.radius = __lux_tmp_radius_147
          end
        end
      else
        local __lux_unused_148 = nil
      end
      return out
    end
  end
  do
    isFillRecord = function(value)
      local __lux_tmp_152 = typeOf(value) == "table"
      if __lux_tmp_152 then
        local __lux_tmp_149
        local __lux_match_150 = value
        local __lux_tag_151
        if __lux_match_150 ~= nil then
          __lux_tag_151 = __lux_match_150.kind
        end
        if __lux_tag_151 == FILL_SOLID or __lux_tag_151 == FILL_LINEAR or __lux_tag_151 == FILL_RADIAL or __lux_tag_151 == FILL_CONIC then
          __lux_tmp_149 = true
        else
          __lux_tmp_149 = false
        end
        __lux_tmp_152 = __lux_tmp_149
      end
      return __lux_tmp_152
    end
    fillFromStyle = function(fill)
      if isFillRecord(fill) then
        return fill
      end
      if typeOf(fill) == "table" and fill.kind ~= nil then
        if transparentColor == nil then
          transparentColor = makeColor(0, 0, 0, 0)
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
      if resolved.stops ~= nil and #resolved.stops > 0 then
        return colorAtStops(resolved.stops, t)
      end
      local __lux_tmp_colorA_153 = resolved.colorA
      if __lux_tmp_colorA_153 == nil then
        __lux_tmp_colorA_153 = color_white
      end
      local __lux_tmp_colorB_154 = resolved.colorB
      if __lux_tmp_colorB_154 == nil then
        __lux_tmp_colorB_154 = resolved.colorA
      end
      if __lux_tmp_colorB_154 == nil then
        __lux_tmp_colorB_154 = color_white
      end
      return lerpColor(t, __lux_tmp_colorA_153, __lux_tmp_colorB_154)
    end
    fillVisible = function(fill)
      if fill == nil then
        return false
      end
      if isColor(fill) then
        local __lux_cmp_155 = false
        if alpha(fill.a) ~= nil then
          __lux_cmp_155 = alpha(fill.a) > 0
        end
        return __lux_cmp_155
      end
      if typeOf(fill) == "table" and fill._mgfxFillVisible ~= nil then
        return fill._mgfxFillVisible
      end
      return true
    end
    strokeVisible = function(stroke, width)
      if stroke == nil then
        return false
      end
      local __lux_cmp_156 = false
      if alpha(stroke.a) ~= nil then
        __lux_cmp_156 = alpha(stroke.a) <= 0
      end
      if __lux_cmp_156 then
        return false
      end
      local __lux_cmp_157 = false
      if strokeWidth(width, 1) ~= nil then
        __lux_cmp_157 = strokeWidth(width, 1) > 0
      end
      return __lux_cmp_157
    end
    normalizedRotation = function(value)
      local rotation
      do
        local __lux_tmp_value_158 = toNumber(value)
        if __lux_tmp_value_158 == nil then
          __lux_tmp_value_158 = 0
        end
        rotation = __lux_tmp_value_158 / 360 % 1
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
        local __lux_tmp_softness_159 = toNumber(softness)
        if __lux_tmp_softness_159 == nil then
          __lux_tmp_softness_159 = defaultSoftness
        end
        if __lux_tmp_softness_159 == nil then
          __lux_tmp_softness_159 = 0.55
        end
        value = mathClamp(__lux_tmp_softness_159, 0, 1)
      end
      return mathClamp(3.25 - value * 2.5, 0.75, 3.25)
    end
    backdropStyle = function(value)
      if value == nil or value == false then
        return nil
      end
      if value == true then
        if backdropTrueSpec == nil then
          if transparentColor == nil then
            transparentColor = makeColor(0, 0, 0, 0)
          end
          backdropTrueSpec = { blur = 4, tint = transparentColor, opacity = 1, padding = 0 }
        end
        return backdropTrueSpec
      end
      if typeOf(value) == "number" then
        local blurKey
        do
          local __lux_tmp_value_160 = toNumber(value)
          if __lux_tmp_value_160 == nil then
            __lux_tmp_value_160 = 0
          end
          blurKey = mathMax(0, __lux_tmp_value_160)
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
        if transparentColor == nil then
          transparentColor = makeColor(0, 0, 0, 0)
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
        local __lux_cmp_161 = false
        if alpha(value.a) ~= nil then
          __lux_cmp_161 = alpha(value.a) <= 0
        end
        if __lux_cmp_161 then
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
      if cached ~= nil and cached ~= false and cached._blurInput == value.blur and cached._sizeInput == value.size and cached._indexInput == value[1] and cached._tintInput == value.tint and cached._colorInput == value.color and cached._opacityInput == value.opacity and cached._strengthInput == value.strength and cached._paddingInput == value.padding and cached._spreadInput == value.spread then
        return cached
      end
      if cached == false and value.blur == nil and value.size == nil and value[1] == nil and value.tint == nil and value.color == nil and value.opacity == nil and value.strength == nil and value.padding == nil and value.spread == nil then
        if cached == false then
          return nil
        else
          return cached
        end
      end
      local blur
      do
        local __lux_tmp_blur_162 = value.blur
        if __lux_tmp_blur_162 == nil then
          __lux_tmp_blur_162 = value.size
        end
        if __lux_tmp_blur_162 == nil then
          __lux_tmp_blur_162 = value[1]
        end
        local __lux_tmp_blur_163 = toNumber(__lux_tmp_blur_162)
        if __lux_tmp_blur_163 == nil then
          __lux_tmp_blur_163 = 0
        end
        blur = mathMax(0, __lux_tmp_blur_163)
      end
      if transparentColor == nil then
        transparentColor = makeColor(0, 0, 0, 0)
      end
      local tint
      do
        local __lux_tmp_tint_164 = value.tint
        if __lux_tmp_tint_164 == nil then
          __lux_tmp_tint_164 = value.color
        end
        tint = colorOr(__lux_tmp_tint_164, transparentColor)
      end
      local opacity
      do
        local __lux_tmp_opacity_165 = value.opacity
        if __lux_tmp_opacity_165 == nil then
          __lux_tmp_opacity_165 = value.strength
        end
        local __lux_tmp_opacity_166 = toNumber(__lux_tmp_opacity_165)
        if __lux_tmp_opacity_166 == nil then
          __lux_tmp_opacity_166 = 1
        end
        opacity = mathClamp(__lux_tmp_opacity_166, 0, 1)
      end
      local padding
      do
        local __lux_tmp_padding_167 = value.padding
        if __lux_tmp_padding_167 == nil then
          __lux_tmp_padding_167 = value.spread
        end
        local __lux_tmp_padding_168 = toNumber(__lux_tmp_padding_167)
        if __lux_tmp_padding_168 == nil then
          __lux_tmp_padding_168 = 0
        end
        padding = mathMax(0, __lux_tmp_padding_168)
      end
      local __lux_tmp_171 = blur <= 0
      if __lux_tmp_171 then
        local __lux_cmp_170 = false
        if alpha(tint.a) ~= nil then
          __lux_cmp_170 = alpha(tint.a) <= 0
        end
        __lux_tmp_171 = __lux_cmp_170
      end
      local __lux_tmp_172 = __lux_tmp_171
      if not __lux_tmp_172 then
        __lux_tmp_172 = opacity <= 0
      end
      if __lux_tmp_172 then
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
      local __lux_tmp_173
      if bitBor ~= nil then
        __lux_tmp_173 = bitBor(2, 256, 4, 8)
      else
        __lux_tmp_173 = 270
      end
      gradientLutFlags = __lux_tmp_173
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
        local __lux_obj_gradientLutOwner_174 = gradientLutOwner
        local __lux_val_stats_175 = nil
        if __lux_obj_gradientLutOwner_174 ~= nil then
          __lux_val_stats_175 = __lux_obj_gradientLutOwner_174.stats
        end
        stats = __lux_val_stats_175
      end
      if stats ~= nil then
        do
          local __lux_tmp_key_176 = stats[key]
          if __lux_tmp_key_176 == nil then
            __lux_tmp_key_176 = 0
          end
          stats[key] = __lux_tmp_key_176 + amount
        end
      end
    end
    lutColorKey = function(color)
      local c = asColor(color, color_white)
      local __lux_tmp_r_177 = c.r
      if __lux_tmp_r_177 == nil then
        __lux_tmp_r_177 = 0
      end
      local __lux_tmp_g_178 = c.g
      if __lux_tmp_g_178 == nil then
        __lux_tmp_g_178 = 0
      end
      local __lux_tmp_b_179 = c.b
      if __lux_tmp_b_179 == nil then
        __lux_tmp_b_179 = 0
      end
      local __lux_tmp_a_180 = c.a
      if __lux_tmp_a_180 == nil then
        __lux_tmp_a_180 = 255
      end
      return tableConcat(
        {
          mathFloor(__lux_tmp_r_177),
          mathFloor(__lux_tmp_g_178),
          mathFloor(__lux_tmp_b_179),
          mathFloor(__lux_tmp_a_180),
        },
        ","
      )
    end
    normalizedGradientStops = function(fill)
      if typeOf(fill) == "table" and fill.stops ~= nil and #fill.stops > 0 then
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
            local __lux_tmp_colorA_181 = fill.colorA
            if __lux_tmp_colorA_181 == nil then
              __lux_tmp_colorA_181 = fill[1]
            end
            colorA = asColor(__lux_tmp_colorA_181, color_white)
          end
          do
            local __lux_tmp_colorB_182 = fill.colorB
            if __lux_tmp_colorB_182 == nil then
              __lux_tmp_colorB_182 = fill[2]
            end
            colorB = asColor(__lux_tmp_colorB_182, colorA)
          end
        else
          colorA = asColor(fill, color_white)
          colorB = colorA
        end
      end
      return normalizeStops({ { 0, colorA }, { 1, colorB } })
    end
    gradientFillCacheEntry = function(fill)
      if typeOf(fill) ~= "table" or not fill._mgfxLutCacheSafe then
        return nil
      end
      local cached = gradientFillLutCache[fill]
      if cached == nil then
        return nil
      end
      local entry = cached.entry
      if cached.schema ~= gradientLutSchema or entry == nil or entry.key ~= cached.key then
        return nil
      end
      gradientLutClock = gradientLutClock + 1
      entry.tick = gradientLutClock
      gradientLutStat("gradientLutFillHits")
      return entry.texture
    end
    rememberGradientFill = function(fill, key, entry)
      if typeOf(fill) ~= "table" or not fill._mgfxLutCacheSafe or entry == nil then
        return nil
      end
      gradientFillLutCache[fill] = { schema = gradientLutSchema, key = key, entry = entry }
    end
    colorAtNormalizedStops = function(stops, t)
      if stops == nil or #stops == 0 then
        return color_white
      end
      local amount
      do
        local __lux_tmp_t_183 = toNumber(t)
        if __lux_tmp_t_183 == nil then
          __lux_tmp_t_183 = 0
        end
        amount = mathClamp(__lux_tmp_t_183, 0, 1)
      end
      for index = 1, #stops - 1 do
        local a = stops[index]
        local b = stops[index + 1]
        if amount <= b.pos then
          local span = mathMax(0.0001, b.pos - a.pos)
          return lerpColor((amount - a.pos) / span, a.color, b.color)
        end
      end
      local __lux_tmp_color_184 = stops[#stops].color
      if __lux_tmp_color_184 == nil then
        __lux_tmp_color_184 = color_white
      end
      return __lux_tmp_color_184
    end
    gradientLutKey = function(stops)
      local parts = { gradientLutSchema }
      for index = 1, #stops do
        local stop = stops[index]
        do
          local __lux_tmp_pos_185 = stop.pos
          if __lux_tmp_pos_185 == nil then
            __lux_tmp_pos_185 = 0
          end
          parts[#parts + 1] = stringFormat("%.5f:%s", __lux_tmp_pos_185, lutColorKey(stop.color))
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
      local __lux_tmp_MATERIAL_RT_DEPTH_NONE_186 = MATERIAL_RT_DEPTH_NONE
      if __lux_tmp_MATERIAL_RT_DEPTH_NONE_186 == nil then
        __lux_tmp_MATERIAL_RT_DEPTH_NONE_186 = 0
      end
      return getRenderTargetEx(
        name,
        GRADIENT_LUT_W,
        GRADIENT_LUT_H,
        RT_SIZE_LITERAL,
        __lux_tmp_MATERIAL_RT_DEPTH_NONE_186,
        gradientLutFlags,
        0,
        IMAGE_FORMAT_BGRA8888
      )
    end
    writeGradientLut = function(rt, stops)
      if rt == nil or renderPushRenderTarget == nil or renderClear == nil or camStart2D == nil or camEnd2D == nil or surfaceSetDrawColor == nil or surfaceDrawRect == nil then
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
          local __lux_tmp_a_187 = color.a
          if __lux_tmp_a_187 == nil then
            __lux_tmp_a_187 = 255
          end
          alphaByte = mathClamp(mathFloor(__lux_tmp_a_187), 0, 255)
        end
        do
          local __lux_tmp_r_188 = color.r
          if __lux_tmp_r_188 == nil then
            __lux_tmp_r_188 = 255
          end
          local __lux_tmp_g_189 = color.g
          if __lux_tmp_g_189 == nil then
            __lux_tmp_g_189 = 255
          end
          local __lux_tmp_b_190 = color.b
          if __lux_tmp_b_190 == nil then
            __lux_tmp_b_190 = 255
          end
          surfaceSetDrawColor(__lux_tmp_r_188, __lux_tmp_g_189, __lux_tmp_b_190, 255)
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
      if renderSetColorModulation ~= nil and cr ~= nil then
        renderSetColorModulation(cr, cg, cb)
      end
      if renderSetBlend ~= nil and blend ~= nil then
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
        local __lux_tmp_195 = oldestEntry == nil
        if not __lux_tmp_195 then
          local __lux_tmp_tick_193 = entry.tick
          if __lux_tmp_tick_193 == nil then
            __lux_tmp_tick_193 = 0
          end
          local __lux_tmp_tick_194 = oldestEntry.tick
          if __lux_tmp_tick_194 == nil then
            __lux_tmp_tick_194 = 0
          end
          __lux_tmp_195 = __lux_tmp_tick_193 < __lux_tmp_tick_194
        end
        if __lux_tmp_195 then
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
      if material == nil or material.SetTexture == nil then
        return nil
      end
      local lut = gradientLutForFill(fill)
      if lut ~= nil and gradientLutBound[material] ~= lut then
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
      owner.WornPattern = wornPattern
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
  __lux_exports.wornPattern = wornPattern
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
