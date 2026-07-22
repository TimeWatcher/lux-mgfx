return function(__lux_import)
  local __lux_exports = {}
  local FILL_SOLID
  local FILL_LINEAR
  local FILL_RADIAL
  local FILL_CONIC
  local PATTERN_STRIPE
  local PATTERN_SMOKE
  local PATTERN_WORN
  local bitBor
  local camStart2D
  local camEnd2D
  local getRenderTargetEx
  local makeColor
  local mathAbs
  local mathClamp
  local mathExp
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
  local DEFAULT_PATTERN_COLOR
  local DEFAULT_PATTERN_TRUE_COLOR
  local DEFAULT_WORN_COLOR
  local DEFAULT_WORN_EDGE_COLOR
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
  local GRADIENT_CURVE_LINEAR
  local GRADIENT_CURVE_SMOOTHSTEP
  local GRADIENT_CURVE_SMOOTHERSTEP
  local GRADIENT_CURVE_EASE_IN
  local GRADIENT_CURVE_EASE_OUT
  local GRADIENT_CURVE_EASE_IN_OUT
  local GRADIENT_CURVE_EXPONENTIAL
  local GRADIENT_CURVE_GAUSSIAN
  local GRADIENT_CURVE_INVERSE_SQUARE
  local gradientCurve
  local gradientCurveAmount
  local gradientInputs
  local colorAtStops
  local solid
  local gradient
  local twoColorStops
  local linearGradient
  local linearGradientStops
  local radialGradient
  local ellipticalRadialGradient
  local conicGradient
  local ringRadialGradient
  local sectorRadialGradient
  local shapeAngularGradient
  local ringAngularGradient
  local arcAngularGradient
  local sectorAngularGradient
  local emptyPatternSpec
  local patternSeedCache
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
  local STROKE_SOLID
  local STROKE_DOT
  local STROKE_DASH
  local STROKE_DOT_DASH
  local strokeKindValue
  local strokeRaw
  local strokeColor
  local strokeKind
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
  local compileBackdrop
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
  local channelsAtNormalizedStops
  local splitGradientChannel16
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
    PATTERN_WORN = "worn"
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
    mathExp = math.exp
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
    DEFAULT_PATTERN_COLOR = makeColor(255, 255, 255, 24)
    DEFAULT_PATTERN_TRUE_COLOR = makeColor(255, 255, 255, 20)
    DEFAULT_WORN_COLOR = makeColor(0, 0, 0, 44)
    DEFAULT_WORN_EDGE_COLOR = makeColor(218, 208, 184, 78)
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
    GRADIENT_CURVE_LINEAR = 0
    GRADIENT_CURVE_SMOOTHSTEP = 1
    GRADIENT_CURVE_SMOOTHERSTEP = 2
    GRADIENT_CURVE_EASE_IN = 3
    GRADIENT_CURVE_EASE_OUT = 4
    GRADIENT_CURVE_EASE_IN_OUT = 5
    GRADIENT_CURVE_EXPONENTIAL = 6
    GRADIENT_CURVE_GAUSSIAN = 7
    GRADIENT_CURVE_INVERSE_SQUARE = 8
    gradientCurve = function(value)
      if value == nil then
        value = "linear"
      end
      if typeOf(value) == "table" then
        do
          local __lux_tmp_kind_81 = value.kind
          if __lux_tmp_kind_81 == nil then
            __lux_tmp_kind_81 = value.curve
          end
          if __lux_tmp_kind_81 == nil then
            __lux_tmp_kind_81 = value[1]
          end
          if __lux_tmp_kind_81 == nil then
            __lux_tmp_kind_81 = "linear"
          end
          value = __lux_tmp_kind_81
        end
      end
      if typeOf(value) == "number" then
        local id = mathFloor(value)
        if id >= GRADIENT_CURVE_LINEAR and id <= GRADIENT_CURVE_INVERSE_SQUARE then
          return id
        end
        error("unknown gradient curve id: " .. tostring(value), 3)
      end
      local kind
      do
        local __lux_tmp_value_82 = value
        if __lux_tmp_value_82 == nil then
          __lux_tmp_value_82 = "linear"
        end
        kind = stringLower(toString(__lux_tmp_value_82))
      end
      local __lux_match_83 = kind
      if __lux_match_83 == "linear" then
        return GRADIENT_CURVE_LINEAR
      elseif __lux_match_83 == "smooth" or __lux_match_83 == "smoothstep" then
        return GRADIENT_CURVE_SMOOTHSTEP
      elseif __lux_match_83 == "smoother" or __lux_match_83 == "smootherstep" then
        return GRADIENT_CURVE_SMOOTHERSTEP
      elseif __lux_match_83 == "power" or __lux_match_83 == "pow" or __lux_match_83 == "ease-in" then
        return GRADIENT_CURVE_EASE_IN
      elseif __lux_match_83 == "ease-out" then
        return GRADIENT_CURVE_EASE_OUT
      elseif __lux_match_83 == "ease-in-out" then
        return GRADIENT_CURVE_EASE_IN_OUT
      elseif __lux_match_83 == "exponential" or __lux_match_83 == "exp" then
        return GRADIENT_CURVE_EXPONENTIAL
      elseif __lux_match_83 == "gaussian" or __lux_match_83 == "gauss" then
        return GRADIENT_CURVE_GAUSSIAN
      elseif __lux_match_83 == "inverse-square" or __lux_match_83 == "inverse_square" or __lux_match_83 == "inverse" or __lux_match_83 == "physical" or __lux_match_83 == "light" then
        return GRADIENT_CURVE_INVERSE_SQUARE
      else
        return error("unknown gradient curve kind: " .. tostring(kind), 3)
      end
    end
    gradientCurveAmount = function(curve, t)
      local curveId = gradientCurve(curve)
      local amount
      do
        local __lux_tmp_t_84 = toNumber(t)
        if __lux_tmp_t_84 == nil then
          __lux_tmp_t_84 = 0
        end
        amount = mathClamp(__lux_tmp_t_84, 0, 1)
      end
      if curveId == GRADIENT_CURVE_LINEAR then
        return amount
      end
      if curveId == GRADIENT_CURVE_SMOOTHSTEP then
        return amount * amount * (3 - 2 * amount)
      end
      if curveId == GRADIENT_CURVE_SMOOTHERSTEP then
        return amount * amount * amount * (amount * (amount * 6 - 15) + 10)
      end
      if curveId == GRADIENT_CURVE_EASE_IN then
        return amount * amount
      end
      if curveId == GRADIENT_CURVE_EASE_OUT then
        return 1 - (1 - amount) * (1 - amount)
      end
      if curveId == GRADIENT_CURVE_EASE_IN_OUT then
        if amount < 0.5 then
          return 2 * amount * amount
        else
          return 1 - 2 * (1 - amount) * (1 - amount)
        end
      end
      if curveId == GRADIENT_CURVE_EXPONENTIAL then
        return (1 - mathExp(-2.6 * amount)) / (1 - mathExp(-2.6))
      end
      if curveId == GRADIENT_CURVE_GAUSSIAN then
        return (1 - mathExp(-3 * amount * amount)) / (1 - mathExp(-3))
      end
      local attenuation = 1 / (1 + 8 * amount * amount)
      local edgeAttenuation = 1 / 9(1 - attenuation) / (1 - edgeAttenuation)
    end
    gradientInputs = function(stopsOrColorA, colorB, curve)
      local options = nil
      local stopsInput = stopsOrColorA
      if typeOf(stopsOrColorA) == "table" and not isColor(stopsOrColorA) and stopsOrColorA.stops ~= nil then
        options = stopsOrColorA
        stopsInput = stopsOrColorA.stops
        if curve == nil then
          curve = stopsOrColorA.curve
        end
      end
      local colorA
      local stops
      if typeOf(stopsInput) == "table" and not isColor(stopsInput) then
        if curve == nil and colorB ~= nil and not isColor(colorB) then
          curve = colorB
          colorB = nil
        end
        colorA, colorB, stops = firstLastStops(stopsInput)
      else
        colorA = colorOr(stopsInput)
        colorB = colorOr(colorB, colorA)
        stops = twoColorStops(colorA, colorB)
      end
      return colorA, colorB, stops, gradientCurve(curve)
    end
    colorAtStops = function(stops, t, curve)
      local normalized = normalizeStops(stops)
      if normalized == nil then
        return colorOr(nil)
      end
      local amount = gradientCurveAmount(curve, t)
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
        local __lux_cmp_85 = false
        if alpha(c.a) ~= nil then
          __lux_cmp_85 = alpha(c.a) > 0
        end
        cached = { kind = FILL_SOLID, colorA = c, colorB = c, _mgfxFillVisible = __lux_cmp_85 }
      end
      cache[c] = cached
      return cached
    end
    gradient = function(kind, a, b, stops, curve, extra)
      local base = {
        kind = kind,
        colorA = a,
        colorB = b,
        stops = stops,
        curve = curve,
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
    linearGradient = function(x1, y1, x2, y2, stopsOrColorA, colorB, curve)
      local colorA, resolvedColorB, stops, resolvedCurve = gradientInputs(stopsOrColorA, colorB, curve)
      local __lux_tmp_x1_86 = toNumber(x1)
      if __lux_tmp_x1_86 == nil then
        __lux_tmp_x1_86 = 0
      end
      local __lux_tmp_y1_87 = toNumber(y1)
      if __lux_tmp_y1_87 == nil then
        __lux_tmp_y1_87 = 0
      end
      local __lux_tmp_x2_88 = toNumber(x2)
      if __lux_tmp_x2_88 == nil then
        __lux_tmp_x2_88 = 1
      end
      local __lux_tmp_y2_89 = toNumber(y2)
      if __lux_tmp_y2_89 == nil then
        __lux_tmp_y2_89 = 1
      end
      return gradient(
        FILL_LINEAR,
        colorA,
        resolvedColorB,
        stops,
        resolvedCurve,
        {
          x1 = __lux_tmp_x1_86,
          y1 = __lux_tmp_y1_87,
          x2 = __lux_tmp_x2_88,
          y2 = __lux_tmp_y2_89,
        }
      )
    end
    linearGradientStops = function(x1, y1, x2, y2, stops, curve)
      return linearGradient(x1, y1, x2, y2, stops, curve)
    end
    radialGradient = function(cx, cy, radius, stopsOrColorA, colorB, curve)
      local colorA, resolvedColorB, stops, resolvedCurve = gradientInputs(stopsOrColorA, colorB, curve)
      local __lux_tmp_cx_90 = toNumber(cx)
      if __lux_tmp_cx_90 == nil then
        __lux_tmp_cx_90 = 0.5
      end
      local __lux_tmp_cy_91 = toNumber(cy)
      if __lux_tmp_cy_91 == nil then
        __lux_tmp_cy_91 = 0.5
      end
      local __lux_tmp_radius_92 = toNumber(radius)
      if __lux_tmp_radius_92 == nil then
        __lux_tmp_radius_92 = 0.5
      end
      return gradient(
        FILL_RADIAL,
        colorA,
        resolvedColorB,
        stops,
        resolvedCurve,
        { cx = __lux_tmp_cx_90, cy = __lux_tmp_cy_91, radius = __lux_tmp_radius_92 }
      )
    end
    ellipticalRadialGradient = function(cx, cy, radiusX, radiusY, stopsOrColorA, colorB, curve)
      local colorA, resolvedColorB, stops, resolvedCurve = gradientInputs(stopsOrColorA, colorB, curve)
      local resolvedRadiusX
      do
        local __lux_tmp_radiusX_93 = toNumber(radiusX)
        if __lux_tmp_radiusX_93 == nil then
          __lux_tmp_radiusX_93 = 0.5
        end
        resolvedRadiusX = mathMax(0.001, __lux_tmp_radiusX_93)
      end
      local resolvedRadiusY
      do
        local __lux_tmp_radiusY_94 = toNumber(radiusY)
        if __lux_tmp_radiusY_94 == nil then
          __lux_tmp_radiusY_94 = 0.5
        end
        resolvedRadiusY = mathMax(0.001, __lux_tmp_radiusY_94)
      end
      local __lux_tmp_cx_95 = toNumber(cx)
      if __lux_tmp_cx_95 == nil then
        __lux_tmp_cx_95 = 0.5
      end
      local __lux_tmp_cy_96 = toNumber(cy)
      if __lux_tmp_cy_96 == nil then
        __lux_tmp_cy_96 = 0.5
      end
      return gradient(
        FILL_RADIAL,
        colorA,
        resolvedColorB,
        stops,
        resolvedCurve,
        {
          cx = __lux_tmp_cx_95,
          cy = __lux_tmp_cy_96,
          radius = resolvedRadiusX,
          radiusX = resolvedRadiusX,
          radiusY = resolvedRadiusY,
        }
      )
    end
    conicGradient = function(cx, cy, rotation, stopsOrColorA, colorB, curve)
      local colorA, resolvedColorB, stops, resolvedCurve = gradientInputs(stopsOrColorA, colorB, curve)
      local __lux_tmp_cx_97 = toNumber(cx)
      if __lux_tmp_cx_97 == nil then
        __lux_tmp_cx_97 = 0.5
      end
      local __lux_tmp_cy_98 = toNumber(cy)
      if __lux_tmp_cy_98 == nil then
        __lux_tmp_cy_98 = 0.5
      end
      local __lux_tmp_rotation_99 = toNumber(rotation)
      if __lux_tmp_rotation_99 == nil then
        __lux_tmp_rotation_99 = 0
      end
      return gradient(
        FILL_CONIC,
        colorA,
        resolvedColorB,
        stops,
        resolvedCurve,
        { cx = __lux_tmp_cx_97, cy = __lux_tmp_cy_98, rotation = __lux_tmp_rotation_99 }
      )
    end
    ringRadialGradient = function(stopsOrColorA, colorB, curve)
      do
        local fill = radialGradient(0.5, 0.5, 0.5, stopsOrColorA, colorB, curve)
        fill.radialSpace = "ring"
        fill.localRadial = true
        return fill
      end
    end
    sectorRadialGradient = function(stopsOrColorA, colorB, curve)
      return ringRadialGradient(stopsOrColorA, colorB, curve)
    end
    shapeAngularGradient = function(stopsOrColorA, colorB, rotation, curve)
      if typeOf(stopsOrColorA) == "table" and not isColor(stopsOrColorA) then
        if typeOf(colorB) == "number" then
          if curve == nil and rotation ~= nil and typeOf(rotation) ~= "number" then
            curve = rotation
          end
          rotation = colorB
          colorB = nil
        else
          if colorB ~= nil and not isColor(colorB) then
            if curve == nil then
              curve = colorB
            end
            colorB = nil
          end
        end
      end
      local fill
      do
        local __lux_tmp_rotation_100 = rotation
        if __lux_tmp_rotation_100 == nil then
          __lux_tmp_rotation_100 = 0
        end
        fill = conicGradient(0.5, 0.5, __lux_tmp_rotation_100, stopsOrColorA, colorB, curve)
      end
      fill.angularSpace = "shape"
      fill.localAngular = true
      return fill
    end
    ringAngularGradient = function(stopsOrColorA, colorB, rotation, curve)
      return shapeAngularGradient(stopsOrColorA, colorB, rotation, curve)
    end
    arcAngularGradient = function(stopsOrColorA, colorB, rotation, curve)
      return shapeAngularGradient(stopsOrColorA, colorB, rotation, curve)
    end
    sectorAngularGradient = function(stopsOrColorA, colorB, rotation, curve)
      return shapeAngularGradient(stopsOrColorA, colorB, rotation, curve)
    end
  end
  do
    emptyPatternSpec = {}
    patternSeedCache = {}
    patternSeed = function(seed)
      if seed == nil then
        return 0
      end
      local value = toNumber(seed)
      local stringSeed
      if typeOf(seed) == "string" then
        stringSeed = seed
      else
        stringSeed = nil
      end
      if value == nil and stringSeed ~= nil then
        local cached = patternSeedCache[stringSeed]
        if cached ~= nil then
          return cached
        end
      end
      local utilCrc = utilCRC
      if value == nil and utilCrc ~= nil then
        value = toNumber(utilCrc(toString(seed)))
      end
      do
        local __lux_tmp_value_101 = value
        if __lux_tmp_value_101 == nil then
          __lux_tmp_value_101 = 0
        end
        value = mathAbs(__lux_tmp_value_101) % 65536
      end
      local normalized = value / 65536
      if stringSeed ~= nil then
        patternSeedCache[stringSeed] = normalized
      end
      return normalized
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
        if color._mgfxPatternSpec == true and color.kind == PATTERN_STRIPE then
          return color
        end
        local __lux_tmp_color_102 = color.color
        if __lux_tmp_color_102 == nil then
          __lux_tmp_color_102 = color.tint
        end
        local __lux_tmp_spacing_103 = toNumber(color.spacing)
        if __lux_tmp_spacing_103 == nil then
          __lux_tmp_spacing_103 = 12
        end
        local __lux_tmp_width_104 = toNumber(color.width)
        if __lux_tmp_width_104 == nil then
          __lux_tmp_width_104 = 2
        end
        local __lux_tmp_angle_105 = toNumber(color.angle)
        if __lux_tmp_angle_105 == nil then
          __lux_tmp_angle_105 = 135
        end
        local __lux_tmp_offset_106 = toNumber(color.offset)
        if __lux_tmp_offset_106 == nil then
          __lux_tmp_offset_106 = 0
        end
        return {
          kind = PATTERN_STRIPE,
          _mgfxPatternSpec = true,
          color = colorOr(__lux_tmp_color_102, DEFAULT_PATTERN_COLOR),
          spacing = __lux_tmp_spacing_103,
          width = __lux_tmp_width_104,
          angle = __lux_tmp_angle_105,
          offset = __lux_tmp_offset_106,
        }
      end
      local __lux_tmp_spacing_107 = toNumber(spacing)
      if __lux_tmp_spacing_107 == nil then
        __lux_tmp_spacing_107 = 12
      end
      local __lux_tmp_width_108 = toNumber(width)
      if __lux_tmp_width_108 == nil then
        __lux_tmp_width_108 = 2
      end
      local __lux_tmp_angle_109 = toNumber(angle)
      if __lux_tmp_angle_109 == nil then
        __lux_tmp_angle_109 = 135
      end
      local __lux_tmp_offset_110 = toNumber(offset)
      if __lux_tmp_offset_110 == nil then
        __lux_tmp_offset_110 = 0
      end
      return {
        kind = PATTERN_STRIPE,
        _mgfxPatternSpec = true,
        color = colorOr(color, DEFAULT_PATTERN_COLOR),
        spacing = __lux_tmp_spacing_107,
        width = __lux_tmp_width_108,
        angle = __lux_tmp_angle_109,
        offset = __lux_tmp_offset_110,
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
        if color._mgfxPatternSpec == true and color.kind == PATTERN_SMOKE then
          return color
        end
        local __lux_tmp_color_111 = color.color
        if __lux_tmp_color_111 == nil then
          __lux_tmp_color_111 = color.tint
        end
        local __lux_tmp_scale_112 = toNumber(color.scale)
        if __lux_tmp_scale_112 == nil then
          __lux_tmp_scale_112 = 140
        end
        local __lux_tmp_density_113 = toNumber(color.density)
        if __lux_tmp_density_113 == nil then
          __lux_tmp_density_113 = 0.48
        end
        local __lux_tmp_softness_114 = toNumber(color.softness)
        if __lux_tmp_softness_114 == nil then
          __lux_tmp_softness_114 = 0.3
        end
        local __lux_tmp_angle_115 = toNumber(color.angle)
        if __lux_tmp_angle_115 == nil then
          __lux_tmp_angle_115 = 135
        end
        local __lux_tmp_offset_116 = toNumber(color.offset)
        if __lux_tmp_offset_116 == nil then
          __lux_tmp_offset_116 = 0
        end
        local __lux_tmp_speed_117 = toNumber(color.speed)
        if __lux_tmp_speed_117 == nil then
          __lux_tmp_speed_117 = 0
        end
        local __lux_tmp_warp_118 = toNumber(color.warp)
        if __lux_tmp_warp_118 == nil then
          __lux_tmp_warp_118 = 0.85
        end
        return {
          kind = PATTERN_SMOKE,
          _mgfxPatternSpec = true,
          color = colorOr(__lux_tmp_color_111, DEFAULT_PATTERN_COLOR),
          scale = __lux_tmp_scale_112,
          density = __lux_tmp_density_113,
          softness = __lux_tmp_softness_114,
          angle = __lux_tmp_angle_115,
          offset = __lux_tmp_offset_116,
          speed = __lux_tmp_speed_117,
          warp = __lux_tmp_warp_118,
          seed = patternSeed(color.seed),
        }
      end
      local __lux_tmp_scale_119 = toNumber(scale)
      if __lux_tmp_scale_119 == nil then
        __lux_tmp_scale_119 = 140
      end
      local __lux_tmp_density_120 = toNumber(density)
      if __lux_tmp_density_120 == nil then
        __lux_tmp_density_120 = 0.48
      end
      local __lux_tmp_softness_121 = toNumber(softness)
      if __lux_tmp_softness_121 == nil then
        __lux_tmp_softness_121 = 0.3
      end
      local __lux_tmp_angle_122 = toNumber(angle)
      if __lux_tmp_angle_122 == nil then
        __lux_tmp_angle_122 = 135
      end
      local __lux_tmp_offset_123 = toNumber(offset)
      if __lux_tmp_offset_123 == nil then
        __lux_tmp_offset_123 = 0
      end
      return {
        kind = PATTERN_SMOKE,
        _mgfxPatternSpec = true,
        color = colorOr(color, DEFAULT_PATTERN_COLOR),
        scale = __lux_tmp_scale_119,
        density = __lux_tmp_density_120,
        softness = __lux_tmp_softness_121,
        angle = __lux_tmp_angle_122,
        offset = __lux_tmp_offset_123,
        speed = 0,
        warp = 0.85,
        seed = patternSeed(seed),
      }
    end
    wornPattern = function(spec)
      if typeOf(spec) == "table" and spec._mgfxPatternSpec == true and spec.kind == PATTERN_WORN then
        return spec
      end
      do
        local __lux_tmp_124
        if typeOf(spec) == "table" then
          __lux_tmp_124 = spec
        else
          __lux_tmp_124 = emptyPatternSpec
        end
        spec = __lux_tmp_124
      end
      local __lux_tmp_color_125 = spec.color
      if __lux_tmp_color_125 == nil then
        __lux_tmp_color_125 = spec.tint
      end
      local __lux_tmp_edgeColor_126 = spec.edgeColor
      if __lux_tmp_edgeColor_126 == nil then
        __lux_tmp_edgeColor_126 = spec.highlight
      end
      local __lux_tmp_fractal_127 = toNumber(spec.fractal)
      if __lux_tmp_fractal_127 == nil then
        __lux_tmp_fractal_127 = 0.44
      end
      local __lux_tmp_grain_128 = toNumber(spec.grain)
      if __lux_tmp_grain_128 == nil then
        __lux_tmp_grain_128 = 0.64
      end
      local __lux_tmp_scratches_129 = spec.scratches
      if __lux_tmp_scratches_129 == nil then
        __lux_tmp_scratches_129 = spec.scratch
      end
      local __lux_tmp_scratches_130 = toNumber(__lux_tmp_scratches_129)
      if __lux_tmp_scratches_130 == nil then
        __lux_tmp_scratches_130 = 0.30
      end
      local __lux_tmp_edge_131 = spec.edge
      if __lux_tmp_edge_131 == nil then
        __lux_tmp_edge_131 = spec.edgeWear
      end
      local __lux_tmp_edge_132 = toNumber(__lux_tmp_edge_131)
      if __lux_tmp_edge_132 == nil then
        __lux_tmp_edge_132 = 0.54
      end
      local __lux_tmp_scale_133 = toNumber(spec.scale)
      if __lux_tmp_scale_133 == nil then
        __lux_tmp_scale_133 = 32
      end
      local __lux_tmp_grainScale_134 = toNumber(spec.grainScale)
      if __lux_tmp_grainScale_134 == nil then
        __lux_tmp_grainScale_134 = 5.6
      end
      local __lux_tmp_scratchScale_135 = toNumber(spec.scratchScale)
      if __lux_tmp_scratchScale_135 == nil then
        __lux_tmp_scratchScale_135 = 26
      end
      local __lux_tmp_scratchWidth_136 = toNumber(spec.scratchWidth)
      if __lux_tmp_scratchWidth_136 == nil then
        __lux_tmp_scratchWidth_136 = 0.045
      end
      local __lux_tmp_edgeWidth_137 = toNumber(spec.edgeWidth)
      if __lux_tmp_edgeWidth_137 == nil then
        __lux_tmp_edgeWidth_137 = 7
      end
      local __lux_tmp_softness_138 = toNumber(spec.softness)
      if __lux_tmp_softness_138 == nil then
        __lux_tmp_softness_138 = 0.10
      end
      local __lux_tmp_warp_139 = toNumber(spec.warp)
      if __lux_tmp_warp_139 == nil then
        __lux_tmp_warp_139 = 0.035
      end
      local __lux_tmp_angle_140 = toNumber(spec.angle)
      if __lux_tmp_angle_140 == nil then
        __lux_tmp_angle_140 = -14
      end
      local __lux_tmp_offset_141 = toNumber(spec.offset)
      if __lux_tmp_offset_141 == nil then
        __lux_tmp_offset_141 = 0
      end
      local __lux_tmp_speed_142 = toNumber(spec.speed)
      if __lux_tmp_speed_142 == nil then
        __lux_tmp_speed_142 = 0
      end
      return {
        kind = PATTERN_WORN,
        _mgfxPatternSpec = true,
        color = colorOr(__lux_tmp_color_125, DEFAULT_WORN_COLOR),
        edgeColor = colorOr(__lux_tmp_edgeColor_126, DEFAULT_WORN_EDGE_COLOR),
        fractal = mathClamp(__lux_tmp_fractal_127, 0, 1),
        grain = mathClamp(__lux_tmp_grain_128, 0, 1),
        scratches = mathClamp(__lux_tmp_scratches_130, 0, 1),
        edge = mathClamp(__lux_tmp_edge_132, 0, 1),
        scale = mathMax(1, __lux_tmp_scale_133),
        grainScale = mathMax(0.25, __lux_tmp_grainScale_134),
        scratchScale = mathMax(1, __lux_tmp_scratchScale_135),
        scratchWidth = mathClamp(__lux_tmp_scratchWidth_136, 0.005, 0.5),
        edgeWidth = mathMax(0.5, __lux_tmp_edgeWidth_137),
        softness = mathClamp(__lux_tmp_softness_138, 0.001, 1),
        warp = mathMax(0, __lux_tmp_warp_139),
        angle = __lux_tmp_angle_140,
        offset = __lux_tmp_offset_141,
        speed = __lux_tmp_speed_142,
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
        local __lux_tmp_kind_143 = kind
        if __lux_tmp_kind_143 == nil then
          __lux_tmp_kind_143 = out.kind
        end
        out.kind = __lux_tmp_kind_143
      end
      if out.kind == nil and out.shape ~= nil then
        out.kind = out.shape
      end
      out.__mgfxMask = true
      return out
    end
    roundedMaskStyle = function(resolved)
      local __lux_tmp_radius_144 = resolved.radius
      if __lux_tmp_radius_144 == nil then
        __lux_tmp_radius_144 = 0
      end
      return { kind = "rounded", radius = __lux_tmp_radius_144 }
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
      local __lux_match_145 = kind
      if __lux_match_145 == "round" or __lux_match_145 == "rounded" or __lux_match_145 == "roundedbox" or __lux_match_145 == "roundrect" then
        return roundedMaskStyle(resolved)
      elseif __lux_match_145 == "chamfer" or __lux_match_145 == "bevel" then
        return chamferMaskStyle()
      elseif __lux_match_145 == "circle" then
        return circleMaskStyle()
      elseif __lux_match_145 == "capsule" or __lux_match_145 == "pill" then
        return capsuleMaskStyle()
      else
        return nil
      end
    end
    canonicalMaskKind = function(kind)
      local __lux_match_146 = kind
      if __lux_match_146 == "round" or __lux_match_146 == "roundrect" or __lux_match_146 == "roundedbox" then
        return "rounded"
      elseif __lux_match_146 == "bevel" then
        return "chamfer"
      elseif __lux_match_146 == "pill" then
        return "capsule"
      elseif __lux_match_146 == "alpha" or __lux_match_146 == "image" then
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
        local __lux_tmp_kind_147 = out.kind
        if __lux_tmp_kind_147 == nil then
          __lux_tmp_kind_147 = out.shape
        end
        if __lux_tmp_kind_147 == nil then
          local __lux_tmp_148
          if out.source ~= nil then
            __lux_tmp_148 = "texture"
          else
            __lux_tmp_148 = nil
          end
          __lux_tmp_kind_147 = __lux_tmp_148
        end
        if __lux_tmp_kind_147 == nil then
          local __lux_tmp_149
          if out.material ~= nil then
            __lux_tmp_149 = "texture"
          else
            __lux_tmp_149 = nil
          end
          __lux_tmp_kind_147 = __lux_tmp_149
        end
        if __lux_tmp_kind_147 == nil then
          local __lux_tmp_150
          if out.texture ~= nil then
            __lux_tmp_150 = "texture"
          else
            __lux_tmp_150 = nil
          end
          __lux_tmp_kind_147 = __lux_tmp_150
        end
        out.kind = __lux_tmp_kind_147
      end
      if typeOf(out.kind) == "string" then
        out.kind = canonicalMaskKind(stringLower(out.kind))
      end
      local __lux_match_151 = out.kind
      if __lux_match_151 == "chamfer" then
        if out.cuts == nil then
          out.cuts = 0
        end
      elseif __lux_match_151 == "rounded" then
        if out.radius == nil then
          do
            local __lux_tmp_radius_152 = resolved.radius
            if __lux_tmp_radius_152 == nil then
              __lux_tmp_radius_152 = 0
            end
            out.radius = __lux_tmp_radius_152
          end
        end
      else
        local __lux_unused_153 = nil
      end
      return out
    end
  end
  do
    STROKE_SOLID = 0
    STROKE_DOT = 1
    STROKE_DASH = 2
    STROKE_DOT_DASH = 3
    strokeKindValue = function(value)
      local __lux_match_154 = value
      if __lux_match_154 == nil or __lux_match_154 == "solid" or __lux_match_154 == 0 then
        return 0
      elseif __lux_match_154 == "dot" or __lux_match_154 == 1 then
        return 1
      elseif __lux_match_154 == "dash" or __lux_match_154 == 2 then
        return 2
      elseif __lux_match_154 == "dot-dash" or __lux_match_154 == 3 then
        return 3
      else
        return error("unsupported MGFX stroke kind: " .. tostring(value), 3)
      end
    end
    strokeRaw = function(stroke, widthInput, fallbackWidth)
      if fallbackWidth == nil then
        fallbackWidth = 0
      end
      if stroke == nil or stroke == false then
        return false, nil, 0, 0, 0, 0, 0
      end
      local spec
      if typeOf(stroke) == "table" and not isColor(stroke) then
        spec = stroke
      else
        spec = nil
      end
      local color
      if spec ~= nil then
        color = spec.color
        if color == nil then
          color = spec.tint
          if color == nil then
            color = spec[1]
          end
        end
      else
        color = stroke
      end
      if not isColor(color) then
        error("MGFX stroke must be a Color or a stroke style record containing color", 3)
      end
      local widthSource
      if widthInput ~= nil then
        widthSource = widthInput
      else
        do
          local __lux_obj_spec_155 = spec
          local __lux_val_width_156 = nil
          if __lux_obj_spec_155 ~= nil then
            __lux_val_width_156 = __lux_obj_spec_155.width
          end
          widthSource = __lux_val_width_156
          if widthSource == nil then
            do
              local __lux_obj_spec_157 = spec
              local __lux_val_size_158 = nil
              if __lux_obj_spec_157 ~= nil then
                __lux_val_size_158 = __lux_obj_spec_157.size
              end
              widthSource = __lux_val_size_158
            end
          end
        end
      end
      local width = mathMax(0, strokeWidth(widthSource, fallbackWidth))
      local kind
      do
        local __lux_obj_spec_159 = spec
        local __lux_val_kind_160 = nil
        if __lux_obj_spec_159 ~= nil then
          __lux_val_kind_160 = __lux_obj_spec_159.kind
        end
        kind = strokeKindValue(__lux_val_kind_160)
      end
      local length
      do
        local __lux_obj_spec_161 = spec
        local __lux_tmp_length_162 = nil
        if __lux_obj_spec_161 ~= nil then
          __lux_tmp_length_162 = __lux_obj_spec_161.length
        end
        if __lux_tmp_length_162 == nil then
          local __lux_obj_spec_163 = spec
          local __lux_val_dashLength_164 = nil
          if __lux_obj_spec_163 ~= nil then
            __lux_val_dashLength_164 = __lux_obj_spec_163.dashLength
          end
          __lux_tmp_length_162 = __lux_val_dashLength_164
        end
        local __lux_tmp_length_165 = toNumber(__lux_tmp_length_162)
        if __lux_tmp_length_165 == nil then
          __lux_tmp_length_165 = mathMax(width * 3, 3)
        end
        length = mathMax(0.001, __lux_tmp_length_165)
      end
      local gap
      do
        local __lux_obj_spec_166 = spec
        local __lux_val_gap_167 = nil
        if __lux_obj_spec_166 ~= nil then
          __lux_val_gap_167 = __lux_obj_spec_166.gap
        end
        local __lux_tmp_gap_168 = toNumber(__lux_val_gap_167)
        if __lux_tmp_gap_168 == nil then
          __lux_tmp_gap_168 = mathMax(width * 1.5, 2)
        end
        gap = mathMax(0, __lux_tmp_gap_168)
      end
      local offset
      do
        local __lux_obj_spec_169 = spec
        local __lux_tmp_offset_170 = nil
        if __lux_obj_spec_169 ~= nil then
          __lux_tmp_offset_170 = __lux_obj_spec_169.offset
        end
        if __lux_tmp_offset_170 == nil then
          local __lux_obj_spec_171 = spec
          local __lux_val_phase_172 = nil
          if __lux_obj_spec_171 ~= nil then
            __lux_val_phase_172 = __lux_obj_spec_171.phase
          end
          __lux_tmp_offset_170 = __lux_val_phase_172
        end
        offset = toNumber(__lux_tmp_offset_170)
        if offset == nil then
          offset = 0
        end
      end
      local visible
      do
        local __lux_tmp_174 = width > 0
        if __lux_tmp_174 then
          local __lux_cmp_173 = false
          if alpha(color.a) ~= nil then
            __lux_cmp_173 = alpha(color.a) > 0
          end
          __lux_tmp_174 = __lux_cmp_173
        end
        visible = __lux_tmp_174
      end
      return visible, color, width, kind, length, gap, offset
    end
    strokeColor = function(stroke)
      if stroke == nil or stroke == false then
        return nil
      end
      if isColor(stroke) then
        return stroke
      end
      local color
      if typeOf(stroke) == "table" then
        color = stroke.color
        if color == nil then
          color = stroke.tint
          if color == nil then
            color = stroke[1]
          end
        end
      else
        color = nil
      end
      if not isColor(color) then
        error("MGFX stroke must be a Color or a stroke style record containing color", 3)
      end
      return color
    end
    strokeKind = function(stroke)
      if stroke == nil or stroke == false or isColor(stroke) then
        return 0
      end
      return strokeKindValue(stroke.kind)
    end
  end
  do
    isFillRecord = function(value)
      local __lux_tmp_178 = typeOf(value) == "table"
      if __lux_tmp_178 then
        local __lux_tmp_175
        local __lux_match_176 = value
        local __lux_tag_177
        if __lux_match_176 ~= nil then
          __lux_tag_177 = __lux_match_176.kind
        end
        if __lux_tag_177 == FILL_SOLID or __lux_tag_177 == FILL_LINEAR or __lux_tag_177 == FILL_RADIAL or __lux_tag_177 == FILL_CONIC then
          __lux_tmp_175 = true
        else
          __lux_tmp_175 = false
        end
        __lux_tmp_178 = __lux_tmp_175
      end
      return __lux_tmp_178
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
        return colorAtStops(resolved.stops, t, resolved.curve)
      end
      local __lux_tmp_colorA_179 = resolved.colorA
      if __lux_tmp_colorA_179 == nil then
        __lux_tmp_colorA_179 = color_white
      end
      local __lux_tmp_colorB_180 = resolved.colorB
      if __lux_tmp_colorB_180 == nil then
        __lux_tmp_colorB_180 = resolved.colorA
      end
      if __lux_tmp_colorB_180 == nil then
        __lux_tmp_colorB_180 = color_white
      end
      return lerpColor(
        gradientCurveAmount(resolved.curve, t),
        __lux_tmp_colorA_179,
        __lux_tmp_colorB_180
      )
    end
    fillVisible = function(fill)
      if fill == nil then
        return false
      end
      if isColor(fill) then
        local __lux_cmp_181 = false
        if alpha(fill.a) ~= nil then
          __lux_cmp_181 = alpha(fill.a) > 0
        end
        return __lux_cmp_181
      end
      if typeOf(fill) == "table" and fill._mgfxFillVisible ~= nil then
        return fill._mgfxFillVisible
      end
      return true
    end
    strokeVisible = function(stroke, width)
      local visible = strokeRaw(stroke, width, 1)
      return visible
    end
    normalizedRotation = function(value)
      local rotation
      do
        local __lux_tmp_value_182 = toNumber(value)
        if __lux_tmp_value_182 == nil then
          __lux_tmp_value_182 = 0
        end
        rotation = __lux_tmp_value_182 / 360 % 1
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
        local __lux_tmp_softness_183 = toNumber(softness)
        if __lux_tmp_softness_183 == nil then
          __lux_tmp_softness_183 = defaultSoftness
        end
        if __lux_tmp_softness_183 == nil then
          __lux_tmp_softness_183 = 0.55
        end
        value = mathClamp(__lux_tmp_softness_183, 0, 1)
      end
      return mathClamp(3.25 - value * 2.5, 0.75, 3.25)
    end
    backdropStyle = function(value)
      if value == nil or value == false then
        return nil
      end
      if typeOf(value) == "table" and value._mgfxBackdropSpec == true then
        return value
      end
      if value == true then
        if backdropTrueSpec == nil then
          if transparentColor == nil then
            transparentColor = makeColor(0, 0, 0, 0)
          end
          backdropTrueSpec = {
            blur = 4,
            tint = transparentColor,
            opacity = 1,
            padding = 0,
            recapture = false,
            level = 0,
            _mgfxBackdropSpec = true,
          }
        end
        return backdropTrueSpec
      end
      if typeOf(value) == "number" then
        local blurKey
        do
          local __lux_tmp_value_184 = toNumber(value)
          if __lux_tmp_value_184 == nil then
            __lux_tmp_value_184 = 0
          end
          blurKey = mathMax(0, __lux_tmp_value_184)
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
        cached = {
          blur = blurKey,
          tint = transparentColor,
          opacity = 1,
          padding = 0,
          recapture = false,
          level = 0,
          _mgfxBackdropSpec = true,
        }
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
        cached = {
          blur = 0,
          tint = value,
          opacity = 1,
          padding = 0,
          recapture = false,
          level = 0,
          _mgfxBackdropSpec = true,
        }
        local __lux_cmp_185 = false
        if alpha(value.a) ~= nil then
          __lux_cmp_185 = alpha(value.a) <= 0
        end
        if __lux_cmp_185 then
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
      if cached ~= nil and cached ~= false and cached._blurInput == value.blur and cached._sizeInput == value.size and cached._indexInput == value[1] and cached._tintInput == value.tint and cached._colorInput == value.color and cached._opacityInput == value.opacity and cached._strengthInput == value.strength and cached._paddingInput == value.padding and cached._spreadInput == value.spread and cached._recaptureInput == value.recapture and cached._levelInput == value.level then
        return cached
      end
      if cached == false and value.blur == nil and value.size == nil and value[1] == nil and value.tint == nil and value.color == nil and value.opacity == nil and value.strength == nil and value.padding == nil and value.spread == nil and value.recapture == nil and value.level == nil then
        if cached == false then
          return nil
        else
          return cached
        end
      end
      local blur
      do
        local __lux_tmp_blur_186 = value.blur
        if __lux_tmp_blur_186 == nil then
          __lux_tmp_blur_186 = value.size
        end
        if __lux_tmp_blur_186 == nil then
          __lux_tmp_blur_186 = value[1]
        end
        local __lux_tmp_blur_187 = toNumber(__lux_tmp_blur_186)
        if __lux_tmp_blur_187 == nil then
          __lux_tmp_blur_187 = 0
        end
        blur = mathMax(0, __lux_tmp_blur_187)
      end
      if transparentColor == nil then
        transparentColor = makeColor(0, 0, 0, 0)
      end
      local tint
      do
        local __lux_tmp_tint_188 = value.tint
        if __lux_tmp_tint_188 == nil then
          __lux_tmp_tint_188 = value.color
        end
        tint = colorOr(__lux_tmp_tint_188, transparentColor)
      end
      local opacity
      do
        local __lux_tmp_opacity_189 = value.opacity
        if __lux_tmp_opacity_189 == nil then
          __lux_tmp_opacity_189 = value.strength
        end
        local __lux_tmp_opacity_190 = toNumber(__lux_tmp_opacity_189)
        if __lux_tmp_opacity_190 == nil then
          __lux_tmp_opacity_190 = 1
        end
        opacity = mathClamp(__lux_tmp_opacity_190, 0, 1)
      end
      local padding
      do
        local __lux_tmp_padding_191 = value.padding
        if __lux_tmp_padding_191 == nil then
          __lux_tmp_padding_191 = value.spread
        end
        local __lux_tmp_padding_192 = toNumber(__lux_tmp_padding_191)
        if __lux_tmp_padding_192 == nil then
          __lux_tmp_padding_192 = 0
        end
        padding = mathMax(0, __lux_tmp_padding_192)
      end
      local recapture = value.recapture == true
      local level
      do
        local __lux_tmp_level_193 = toNumber(value.level)
        if __lux_tmp_level_193 == nil then
          __lux_tmp_level_193 = 0
        end
        level = mathFloor(__lux_tmp_level_193)
      end
      local __lux_tmp_196 = blur <= 0
      if __lux_tmp_196 then
        local __lux_cmp_195 = false
        if alpha(tint.a) ~= nil then
          __lux_cmp_195 = alpha(tint.a) <= 0
        end
        __lux_tmp_196 = __lux_cmp_195
      end
      local __lux_tmp_197 = __lux_tmp_196
      if not __lux_tmp_197 then
        __lux_tmp_197 = opacity <= 0
      end
      if __lux_tmp_197 then
        backdropTableCache[value] = false
        return nil
      end
      cached = {
        blur = blur,
        tint = tint,
        opacity = opacity,
        padding = padding,
        recapture = recapture,
        level = level,
        _mgfxBackdropSpec = true,
      }
      cached._blurInput = value.blur
      cached._sizeInput = value.size
      cached._indexInput = value[1]
      cached._tintInput = value.tint
      cached._colorInput = value.color
      cached._opacityInput = value.opacity
      cached._strengthInput = value.strength
      cached._paddingInput = value.padding
      cached._spreadInput = value.spread
      cached._recaptureInput = value.recapture
      cached._levelInput = value.level
      backdropTableCache[value] = cached
      return cached
    end
    backdrop = function(value)
      return backdropStyle(value)
    end
    compileBackdrop = function(value)
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
    gradientLutSchema = "lut-rgba16-rgb-v4"
    do
      local __lux_tmp_198
      if bitBor ~= nil then
        __lux_tmp_198 = bitBor(2, 256, 4, 8)
      else
        __lux_tmp_198 = 270
      end
      gradientLutFlags = __lux_tmp_198
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
        local __lux_obj_gradientLutOwner_199 = gradientLutOwner
        local __lux_val_stats_200 = nil
        if __lux_obj_gradientLutOwner_199 ~= nil then
          __lux_val_stats_200 = __lux_obj_gradientLutOwner_199.stats
        end
        stats = __lux_val_stats_200
      end
      if stats ~= nil then
        do
          local __lux_tmp_key_201 = stats[key]
          if __lux_tmp_key_201 == nil then
            __lux_tmp_key_201 = 0
          end
          stats[key] = __lux_tmp_key_201 + amount
        end
      end
    end
    lutColorKey = function(color)
      local c = asColor(color, color_white)
      local __lux_tmp_r_202 = c.r
      if __lux_tmp_r_202 == nil then
        __lux_tmp_r_202 = 0
      end
      local __lux_tmp_g_203 = c.g
      if __lux_tmp_g_203 == nil then
        __lux_tmp_g_203 = 0
      end
      local __lux_tmp_b_204 = c.b
      if __lux_tmp_b_204 == nil then
        __lux_tmp_b_204 = 0
      end
      local __lux_tmp_a_205 = c.a
      if __lux_tmp_a_205 == nil then
        __lux_tmp_a_205 = 255
      end
      return tableConcat(
        {
          mathFloor(__lux_tmp_r_202),
          mathFloor(__lux_tmp_g_203),
          mathFloor(__lux_tmp_b_204),
          mathFloor(__lux_tmp_a_205),
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
            local __lux_tmp_colorA_206 = fill.colorA
            if __lux_tmp_colorA_206 == nil then
              __lux_tmp_colorA_206 = fill[1]
            end
            colorA = asColor(__lux_tmp_colorA_206, color_white)
          end
          do
            local __lux_tmp_colorB_207 = fill.colorB
            if __lux_tmp_colorB_207 == nil then
              __lux_tmp_colorB_207 = fill[2]
            end
            colorB = asColor(__lux_tmp_colorB_207, colorA)
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
    channelsAtNormalizedStops = function(stops, t)
      if stops == nil or #stops == 0 then
        return 1, 1, 1, 1
      end
      local amount
      do
        local __lux_tmp_t_208 = toNumber(t)
        if __lux_tmp_t_208 == nil then
          __lux_tmp_t_208 = 0
        end
        amount = mathClamp(__lux_tmp_t_208, 0, 1)
      end
      for index = 1, #stops - 1 do
        local a = stops[index]
        local b = stops[index + 1]
        if amount <= b.pos then
          local span = mathMax(0.0001, b.pos - a.pos)
          local mix = mathClamp((amount - a.pos) / span, 0, 1)
          local colorA = asColor(a.color, color_white)
          local colorB = asColor(b.color, colorA)
          local __lux_tmp_r_209 = colorA.r
          if __lux_tmp_r_209 == nil then
            __lux_tmp_r_209 = 255
          end
          local __lux_tmp_r_210 = colorB.r
          if __lux_tmp_r_210 == nil then
            __lux_tmp_r_210 = 255
          end
          local __lux_tmp_r_211 = colorA.r
          if __lux_tmp_r_211 == nil then
            __lux_tmp_r_211 = 255
          end
          local __lux_tmp_g_212 = colorA.g
          if __lux_tmp_g_212 == nil then
            __lux_tmp_g_212 = 255
          end
          local __lux_tmp_g_213 = colorB.g
          if __lux_tmp_g_213 == nil then
            __lux_tmp_g_213 = 255
          end
          local __lux_tmp_g_214 = colorA.g
          if __lux_tmp_g_214 == nil then
            __lux_tmp_g_214 = 255
          end
          local __lux_tmp_b_215 = colorA.b
          if __lux_tmp_b_215 == nil then
            __lux_tmp_b_215 = 255
          end
          local __lux_tmp_b_216 = colorB.b
          if __lux_tmp_b_216 == nil then
            __lux_tmp_b_216 = 255
          end
          local __lux_tmp_b_217 = colorA.b
          if __lux_tmp_b_217 == nil then
            __lux_tmp_b_217 = 255
          end
          local __lux_tmp_a_218 = colorA.a
          if __lux_tmp_a_218 == nil then
            __lux_tmp_a_218 = 255
          end
          local __lux_tmp_a_219 = colorB.a
          if __lux_tmp_a_219 == nil then
            __lux_tmp_a_219 = 255
          end
          local __lux_tmp_a_220 = colorA.a
          if __lux_tmp_a_220 == nil then
            __lux_tmp_a_220 = 255
          end
          return (__lux_tmp_r_209 + (__lux_tmp_r_210 - __lux_tmp_r_211) * mix) / 255, (__lux_tmp_g_212 + (__lux_tmp_g_213 - __lux_tmp_g_214) * mix) / 255, (__lux_tmp_b_215 + (__lux_tmp_b_216 - __lux_tmp_b_217) * mix) / 255, (__lux_tmp_a_218 + (__lux_tmp_a_219 - __lux_tmp_a_220) * mix) / 255
        end
      end
      local color = asColor(stops[#stops].color, color_white)
      local __lux_tmp_r_221 = color.r
      if __lux_tmp_r_221 == nil then
        __lux_tmp_r_221 = 255
      end
      local __lux_tmp_g_222 = color.g
      if __lux_tmp_g_222 == nil then
        __lux_tmp_g_222 = 255
      end
      local __lux_tmp_b_223 = color.b
      if __lux_tmp_b_223 == nil then
        __lux_tmp_b_223 = 255
      end
      local __lux_tmp_a_224 = color.a
      if __lux_tmp_a_224 == nil then
        __lux_tmp_a_224 = 255
      end
      return __lux_tmp_r_221 / 255, __lux_tmp_g_222 / 255, __lux_tmp_b_223 / 255, __lux_tmp_a_224 / 255
    end
    splitGradientChannel16 = function(value)
      local packed = mathClamp(mathFloor(mathClamp(value, 0, 1) * 65535 + 0.5), 0, 65535)
      local high = mathFloor(packed / 256)
      return high, packed - high * 256
    end
    gradientLutKey = function(stops)
      local parts = { gradientLutSchema }
      for index = 1, #stops do
        local stop = stops[index]
        do
          local __lux_tmp_pos_225 = stop.pos
          if __lux_tmp_pos_225 == nil then
            __lux_tmp_pos_225 = 0
          end
          parts[#parts + 1] = stringFormat("%.5f:%s", __lux_tmp_pos_225, lutColorKey(stop.color))
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
      local __lux_tmp_MATERIAL_RT_DEPTH_NONE_226 = MATERIAL_RT_DEPTH_NONE
      if __lux_tmp_MATERIAL_RT_DEPTH_NONE_226 == nil then
        __lux_tmp_MATERIAL_RT_DEPTH_NONE_226 = 0
      end
      return getRenderTargetEx(
        name,
        GRADIENT_LUT_W,
        GRADIENT_LUT_H,
        RT_SIZE_LITERAL,
        __lux_tmp_MATERIAL_RT_DEPTH_NONE_226,
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
        local r, g, b, a = channelsAtNormalizedStops(stops, x / (GRADIENT_LUT_W - 1))
        local rHigh, rLow = splitGradientChannel16(r)
        local gHigh, gLow = splitGradientChannel16(g)
        local bHigh, bLow = splitGradientChannel16(b)
        local aHigh, aLow = splitGradientChannel16(a)
        surfaceSetDrawColor(rHigh, gHigh, bHigh, 255)
        surfaceDrawRect(x, 0, 1, 1)
        surfaceSetDrawColor(rLow, gLow, bLow, 255)
        surfaceDrawRect(x, 1, 1, 1)
        surfaceSetDrawColor(aHigh, aLow, 0, 255)
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
        local __lux_tmp_231 = oldestEntry == nil
        if not __lux_tmp_231 then
          local __lux_tmp_tick_229 = entry.tick
          if __lux_tmp_tick_229 == nil then
            __lux_tmp_tick_229 = 0
          end
          local __lux_tmp_tick_230 = oldestEntry.tick
          if __lux_tmp_tick_230 == nil then
            __lux_tmp_tick_230 = 0
          end
          __lux_tmp_231 = __lux_tmp_tick_229 < __lux_tmp_tick_230
        end
        if __lux_tmp_231 then
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
      owner.GradientCurve = gradientCurve
      owner.LinearGradient = linearGradient
      owner.LinearGradientStops = linearGradientStops
      owner.RadialGradient = radialGradient
      owner.EllipticalRadialGradient = ellipticalRadialGradient
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
      owner.CompileBackdrop = compileBackdrop
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
  __lux_exports.PATTERN_WORN = PATTERN_WORN
  __lux_exports.DEFAULT_PATTERN_COLOR = DEFAULT_PATTERN_COLOR
  __lux_exports.DEFAULT_PATTERN_TRUE_COLOR = DEFAULT_PATTERN_TRUE_COLOR
  __lux_exports.DEFAULT_WORN_COLOR = DEFAULT_WORN_COLOR
  __lux_exports.DEFAULT_WORN_EDGE_COLOR = DEFAULT_WORN_EDGE_COLOR
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
  __lux_exports.GRADIENT_CURVE_LINEAR = GRADIENT_CURVE_LINEAR
  __lux_exports.GRADIENT_CURVE_SMOOTHSTEP = GRADIENT_CURVE_SMOOTHSTEP
  __lux_exports.GRADIENT_CURVE_SMOOTHERSTEP = GRADIENT_CURVE_SMOOTHERSTEP
  __lux_exports.GRADIENT_CURVE_EASE_IN = GRADIENT_CURVE_EASE_IN
  __lux_exports.GRADIENT_CURVE_EASE_OUT = GRADIENT_CURVE_EASE_OUT
  __lux_exports.GRADIENT_CURVE_EASE_IN_OUT = GRADIENT_CURVE_EASE_IN_OUT
  __lux_exports.GRADIENT_CURVE_EXPONENTIAL = GRADIENT_CURVE_EXPONENTIAL
  __lux_exports.GRADIENT_CURVE_GAUSSIAN = GRADIENT_CURVE_GAUSSIAN
  __lux_exports.GRADIENT_CURVE_INVERSE_SQUARE = GRADIENT_CURVE_INVERSE_SQUARE
  __lux_exports.gradientCurve = gradientCurve
  __lux_exports.gradientCurveAmount = gradientCurveAmount
  __lux_exports.colorAtStops = colorAtStops
  __lux_exports.solid = solid
  __lux_exports.linearGradient = linearGradient
  __lux_exports.linearGradientStops = linearGradientStops
  __lux_exports.radialGradient = radialGradient
  __lux_exports.ellipticalRadialGradient = ellipticalRadialGradient
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
  __lux_exports.STROKE_SOLID = STROKE_SOLID
  __lux_exports.STROKE_DOT = STROKE_DOT
  __lux_exports.STROKE_DASH = STROKE_DASH
  __lux_exports.STROKE_DOT_DASH = STROKE_DOT_DASH
  __lux_exports.strokeRaw = strokeRaw
  __lux_exports.strokeColor = strokeColor
  __lux_exports.strokeKind = strokeKind
  __lux_exports.fillFromStyle = fillFromStyle
  __lux_exports.fillFrom = fillFrom
  __lux_exports.colorAtFill = colorAtFill
  __lux_exports.fillVisible = fillVisible
  __lux_exports.strokeVisible = strokeVisible
  __lux_exports.normalizedRotation = normalizedRotation
  __lux_exports.glowSoftnessToFalloff = glowSoftnessToFalloff
  __lux_exports.backdropStyle = backdropStyle
  __lux_exports.backdrop = backdrop
  __lux_exports.compileBackdrop = compileBackdrop
  __lux_exports.gradientLutForFill = gradientLutForFill
  __lux_exports.bindGradientLut = bindGradientLut
  __lux_exports.gradientLutStatus = gradientLutStatus
  __lux_exports.install = install

  return __lux_exports
end
