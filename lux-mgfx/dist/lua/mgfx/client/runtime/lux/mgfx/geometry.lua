return function(__lux_import)
  local __lux_exports = {}
  local styleUtil
  local makeColor
  local mathAbs
  local mathClamp
  local mathCos
  local mathFloor
  local mathMax
  local mathMin
  local mathRad
  local mathSin
  local mathTan
  local surfaceDrawPoly
  local surfaceDrawTexturedRectUV
  local stringLower
  local stringMatch
  local tableCopy
  local toNumber
  local typeOf
  local pcallFn
  local errorFn
  local stats
  local geometryProfiler
  local transformStack
  local transformPolyScratch
  local transformQuadVerts
  local texturedRectUVCache
  local imageTintScratch
  local traceStart
  local traceEnd
  local copyStyle
  local isPoint
  local pointXY
  local percentString
  local axisOrigin
  local transformOrigin
  local num
  local compileCssTransform
  local projectedCorner
  local compileProjectedQuad
  local compilePointerTilt
  local compileTransform
  local hasTransform
  local transformNeedsGrid
  local transformSteps
  local applyOneTransform
  local inverseOneTransform
  local transformPoint
  local transformSpecPoint
  local untransformSpecPoint
  local untransformPoint
  local transformedVertex
  local drawTransformedPoly
  local pushTransform
  local popTransform
  local withTransform
  local splitStyleTransform
  local transform
  local projectedQuad
  local pointerTilt
  local materialUVCorrection
  local drawTexturedQuadUV
  local drawTexturedQuad
  local drawCreatedMaterialTexturedRectUV
  local drawTexturedRectUV
  local textureSize
  local imageTint
  local imageStyle
  local imageRadius
  local imageAlign
  local imageUV
  local imageFitRect
  local blurIntensity
  local bindStats
  local resetFrameStats
  local recordDraws
  local recordFallbacks
  local profileSnapshot
  local install
  do
    local styleUtilImport = __lux_import("lux/mgfx/style#client")
    styleUtil = styleUtilImport
    makeColor = Color
    mathAbs = math.abs
    mathClamp = math.Clamp
    mathCos = math.cos
    mathFloor = math.floor
    mathMax = math.max
    mathMin = math.min
    mathRad = math.rad
    mathSin = math.sin
    mathTan = math.tan
    surfaceDrawPoly = surface.DrawPoly
    surfaceDrawTexturedRectUV = surface.DrawTexturedRectUV
    stringLower = string.lower
    stringMatch = string.match
    tableCopy = table.Copy
    toNumber = tonumber
    typeOf = type
    pcallFn = pcall
    errorFn = error
    stats = { draws = 0 }
    geometryProfiler = nil
    transformStack = {}
    transformPolyScratch = { {}, {}, {}, {}, {}, {}, {}, {} }
    transformQuadVerts = { {}, {}, {}, {} }
    texturedRectUVCache = setmetatable({}, { __mode = "k" })
    imageTintScratch = makeColor(255, 255, 255, 255)
    traceStart = function(name)
      if geometryProfiler ~= nil and geometryProfiler._TraceActive and geometryProfiler.TraceStart ~= nil then
        return geometryProfiler.TraceStart(name)
      end
      return nil
    end
    traceEnd = function(token)
      if token ~= nil and geometryProfiler ~= nil and geometryProfiler.TraceEnd ~= nil then
        geometryProfiler.TraceEnd(token)
      end
    end
    copyStyle = function(value)
      if typeOf(value) == "table" then
        return tableCopy(value)
      end
      return {}
    end
    isPoint = function(value)
      return typeOf(value) == "table" and (value.x ~= nil or value[1] ~= nil) and (value.y ~= nil or value[2] ~= nil)
    end
    pointXY = function(value, fallbackX, fallbackY)
      if fallbackX == nil then
        fallbackX = 0
      end
      if fallbackY == nil then
        fallbackY = 0
      end
      if typeOf(value) ~= "table" then
        local __lux_tmp_fallbackX_1 = fallbackX
        if __lux_tmp_fallbackX_1 == nil then
          __lux_tmp_fallbackX_1 = 0
        end
        local __lux_tmp_fallbackY_2 = fallbackY
        if __lux_tmp_fallbackY_2 == nil then
          __lux_tmp_fallbackY_2 = 0
        end
        return __lux_tmp_fallbackX_1, __lux_tmp_fallbackY_2
      end
      local __lux_tmp_x_3 = value.x
      if __lux_tmp_x_3 == nil then
        __lux_tmp_x_3 = value[1]
      end
      local __lux_tmp_x_4 = toNumber(__lux_tmp_x_3)
      if __lux_tmp_x_4 == nil then
        __lux_tmp_x_4 = fallbackX
      end
      if __lux_tmp_x_4 == nil then
        __lux_tmp_x_4 = 0
      end
      local __lux_tmp_y_5 = value.y
      if __lux_tmp_y_5 == nil then
        __lux_tmp_y_5 = value[2]
      end
      local __lux_tmp_y_6 = toNumber(__lux_tmp_y_5)
      if __lux_tmp_y_6 == nil then
        __lux_tmp_y_6 = fallbackY
      end
      if __lux_tmp_y_6 == nil then
        __lux_tmp_y_6 = 0
      end
      return __lux_tmp_x_4, __lux_tmp_y_6
    end
    percentString = function(value)
      if typeOf(value) ~= "string" then
        return nil
      end
      local lower = stringLower(value)
      local alias
      local __lux_match_7 = lower
      if __lux_match_7 == "left" or __lux_match_7 == "top" then
        alias = 0
      elseif __lux_match_7 == "center" or __lux_match_7 == "middle" then
        alias = 0.5
      elseif __lux_match_7 == "right" or __lux_match_7 == "bottom" then
        alias = 1
      else
        alias = nil
      end
      if alias ~= nil then
        return alias
      end
      local pct = stringMatch(lower, "^%s*([%-%d%.]+)%s*%%%s*$")
      if pct ~= nil then
        local __lux_tmp_pct_8 = toNumber(pct)
        if __lux_tmp_pct_8 == nil then
          __lux_tmp_pct_8 = 0
        end
        return __lux_tmp_pct_8 / 100
      end
      return nil
    end
    axisOrigin = function(value, base, size, fallback)
      if fallback == nil then
        fallback = 0.5
      end
      local pct = percentString(value)
      if pct ~= nil then
        return base + size * pct
      end
      if value == nil then
        return base + size * fallback
      end
      local __lux_tmp_value_9 = toNumber(value)
      if __lux_tmp_value_9 == nil then
        __lux_tmp_value_9 = size * fallback
      end
      return base + __lux_tmp_value_9
    end
    transformOrigin = function(spec, x, y, w, h)
      local origin = spec.origin
      if origin == nil then
        origin = spec.transformOrigin
        if origin == nil then
          origin = spec.anchor
        end
      end
      if typeOf(origin) == "string" then
        local a, b = stringMatch(origin, "^%s*([^%s]+)%s+([^%s]+)%s*$")
        if a == nil then
          a = origin
          b = origin
        end
        return axisOrigin(a, x, w, 0.5), axisOrigin(b, y, h, 0.5)
      end
      if typeOf(origin) == "table" then
        local __lux_tmp_x_10 = origin.x
        if __lux_tmp_x_10 == nil then
          __lux_tmp_x_10 = origin[1]
        end
        local __lux_tmp_y_11 = origin.y
        if __lux_tmp_y_11 == nil then
          __lux_tmp_y_11 = origin[2]
        end
        return axisOrigin(__lux_tmp_x_10, x, w, 0.5), axisOrigin(__lux_tmp_y_11, y, h, 0.5)
      end
      return x + w * 0.5, y + h * 0.5
    end
    num = function(value, fallback)
      if fallback == nil then
        fallback = 0
      end
      local __lux_tmp_value_12 = toNumber(value)
      if __lux_tmp_value_12 == nil then
        __lux_tmp_value_12 = fallback
      end
      if __lux_tmp_value_12 == nil then
        __lux_tmp_value_12 = 0
      end
      return __lux_tmp_value_12
    end
    compileCssTransform = function(spec, x, y, w, h)
      if x == nil then
        x = 0
      end
      if y == nil then
        y = 0
      end
      if w == nil then
        w = 0
      end
      if h == nil then
        h = 0
      end
      local ox, oy = transformOrigin(spec, x, y, w, h)
      local scale = spec.scale
      local translate = spec.translate
      local skew = spec.skew
      local scaleX = spec.scaleX
      if scaleX == nil then
        do
          local __lux_tmp_13
          if typeOf(scale) == "table" then
            __lux_tmp_13 = scale.x
            if __lux_tmp_13 == nil then
              __lux_tmp_13 = scale[1]
            end
          else
            __lux_tmp_13 = scale
          end
          scaleX = __lux_tmp_13
          if scaleX == nil then
            scaleX = 1
          end
        end
      end
      local scaleY = spec.scaleY
      if scaleY == nil then
        do
          local __lux_tmp_14
          if typeOf(scale) == "table" then
            __lux_tmp_14 = scale.y
            if __lux_tmp_14 == nil then
              __lux_tmp_14 = scale[2]
            end
          else
            __lux_tmp_14 = scale
          end
          scaleY = __lux_tmp_14
          if scaleY == nil then
            scaleY = 1
          end
        end
      end
      local tx = spec.x
      if tx == nil then
        tx = spec.translateX
        if tx == nil then
          do
            local __lux_tmp_15
            if typeOf(translate) == "table" then
              __lux_tmp_15 = translate.x
              if __lux_tmp_15 == nil then
                __lux_tmp_15 = translate[1]
              end
            else
              __lux_tmp_15 = nil
            end
            tx = __lux_tmp_15
            if tx == nil then
              tx = 0
            end
          end
        end
      end
      local ty = spec.y
      if ty == nil then
        ty = spec.translateY
        if ty == nil then
          do
            local __lux_tmp_16
            if typeOf(translate) == "table" then
              __lux_tmp_16 = translate.y
              if __lux_tmp_16 == nil then
                __lux_tmp_16 = translate[2]
              end
            else
              __lux_tmp_16 = nil
            end
            ty = __lux_tmp_16
            if ty == nil then
              ty = 0
            end
          end
        end
      end
      local tz = spec.z
      if tz == nil then
        tz = spec.translateZ
        if tz == nil then
          do
            local __lux_tmp_17
            if typeOf(translate) == "table" then
              __lux_tmp_17 = translate.z
              if __lux_tmp_17 == nil then
                __lux_tmp_17 = translate[3]
              end
            else
              __lux_tmp_17 = nil
            end
            tz = __lux_tmp_17
            if tz == nil then
              tz = 0
            end
          end
        end
      end
      local skewX = spec.skewX
      if skewX == nil then
        do
          local __lux_tmp_18
          if typeOf(skew) == "table" then
            __lux_tmp_18 = skew.x
            if __lux_tmp_18 == nil then
              __lux_tmp_18 = skew[1]
            end
          else
            __lux_tmp_18 = nil
          end
          skewX = __lux_tmp_18
          if skewX == nil then
            skewX = 0
          end
        end
      end
      local skewY = spec.skewY
      if skewY == nil then
        do
          local __lux_tmp_19
          if typeOf(skew) == "table" then
            __lux_tmp_19 = skew.y
            if __lux_tmp_19 == nil then
              __lux_tmp_19 = skew[2]
            end
          else
            __lux_tmp_19 = nil
          end
          skewY = __lux_tmp_19
          if skewY == nil then
            skewY = 0
          end
        end
      end
      local rotate = spec.rotate
      if rotate == nil then
        rotate = spec.rotateZ
        if rotate == nil then
          rotate = 0
        end
      end
      local rotateX = spec.rotateX
      if rotateX == nil then
        rotateX = spec.pitch
        if rotateX == nil then
          rotateX = 0
        end
      end
      local rotateY = spec.rotateY
      if rotateY == nil then
        rotateY = spec.yaw
        if rotateY == nil then
          rotateY = 0
        end
      end
      local __lux_tmp_perspective_20 = spec.perspective
      if __lux_tmp_perspective_20 == nil then
        __lux_tmp_perspective_20 = spec.depth
      end
      local __lux_tmp_steps_21 = spec.steps
      if __lux_tmp_steps_21 == nil then
        __lux_tmp_steps_21 = spec.subdivisions
      end
      return {
        kind = "css",
        originX = ox,
        originY = oy,
        translateX = num(tx, 0),
        translateY = num(ty, 0),
        translateZ = num(tz, 0),
        scaleX = num(scaleX, 1),
        scaleY = num(scaleY, 1),
        skewX = mathTan(mathRad(num(skewX, 0))),
        skewY = mathTan(mathRad(num(skewY, 0))),
        rotate = mathRad(num(rotate, 0)),
        rotateX = mathRad(num(rotateX, 0)),
        rotateY = mathRad(num(rotateY, 0)),
        perspective = mathMax(0, num(__lux_tmp_perspective_20, 0)),
        steps = mathClamp(mathFloor(num(__lux_tmp_steps_21, 0)), 0, 24),
      }
    end
    projectedCorner = function(spec, name, index)
      local __lux_tmp_name_22 = spec[name]
      if __lux_tmp_name_22 == nil then
        __lux_tmp_name_22 = spec[index]
      end
      return pointXY(__lux_tmp_name_22, 0, 0)
    end
    compileProjectedQuad = function(spec, x, y, w, h)
      if x == nil then
        x = 0
      end
      if y == nil then
        y = 0
      end
      if w == nil then
        w = 1
      end
      if h == nil then
        h = 1
      end
      local tlx, tly = projectedCorner(spec, "tl", 1)
      local trx, try = projectedCorner(spec, "tr", 2)
      local brx, bry = projectedCorner(spec, "br", 3)
      local blx, bly = projectedCorner(spec, "bl", 4)
      local __lux_tmp_steps_23 = spec.steps
      if __lux_tmp_steps_23 == nil then
        __lux_tmp_steps_23 = spec.subdivisions
      end
      return {
        kind = "projected",
        x = x,
        y = y,
        w = mathMax(0.0001, w),
        h = mathMax(0.0001, h),
        tlx = tlx,
        tly = tly,
        trx = trx,
        try = try,
        brx = brx,
        bry = bry,
        blx = blx,
        bly = bly,
        steps = mathClamp(mathFloor(num(__lux_tmp_steps_23, 10)), 1, 24),
      }
    end
    compilePointerTilt = function(spec, x, y, w, h)
      if x == nil or y == nil or w == nil or h == nil then
        return nil
      end
      local px
      do
        local __lux_tmp_pointerX_24 = spec.pointerX
        if __lux_tmp_pointerX_24 == nil then
          __lux_tmp_pointerX_24 = spec.x
        end
        if __lux_tmp_pointerX_24 == nil then
          __lux_tmp_pointerX_24 = spec[1]
        end
        px = toNumber(__lux_tmp_pointerX_24)
        if px == nil then
          px = x + w * 0.5
        end
      end
      local py
      do
        local __lux_tmp_pointerY_25 = spec.pointerY
        if __lux_tmp_pointerY_25 == nil then
          __lux_tmp_pointerY_25 = spec.y
        end
        if __lux_tmp_pointerY_25 == nil then
          __lux_tmp_pointerY_25 = spec[2]
        end
        py = toNumber(__lux_tmp_pointerY_25)
        if py == nil then
          py = y + h * 0.5
        end
      end
      local strength = mathClamp(num(spec.strength, 1), 0, 1)
      local nx = mathClamp((px - (x + w * 0.5)) / mathMax(w * 0.5, 0.0001), -1, 1)
      local ny = mathClamp((py - (y + h * 0.5)) / mathMax(h * 0.5, 0.0001), -1, 1)
      local maxX
      do
        local __lux_tmp_maxRotateX_26 = spec.maxRotateX
        if __lux_tmp_maxRotateX_26 == nil then
          __lux_tmp_maxRotateX_26 = spec.maxX
        end
        if __lux_tmp_maxRotateX_26 == nil then
          __lux_tmp_maxRotateX_26 = spec.max
        end
        if __lux_tmp_maxRotateX_26 == nil then
          __lux_tmp_maxRotateX_26 = spec.amount
        end
        maxX = num(__lux_tmp_maxRotateX_26, 6)
      end
      local maxY
      do
        local __lux_tmp_maxRotateY_27 = spec.maxRotateY
        if __lux_tmp_maxRotateY_27 == nil then
          __lux_tmp_maxRotateY_27 = spec.maxY
        end
        if __lux_tmp_maxRotateY_27 == nil then
          __lux_tmp_maxRotateY_27 = spec.max
        end
        if __lux_tmp_maxRotateY_27 == nil then
          __lux_tmp_maxRotateY_27 = spec.amount
        end
        maxY = num(__lux_tmp_maxRotateY_27, 6)
      end
      local __lux_tmp_origin_28 = spec.origin
      if __lux_tmp_origin_28 == nil then
        __lux_tmp_origin_28 = spec.transformOrigin
      end
      if __lux_tmp_origin_28 == nil then
        __lux_tmp_origin_28 = "50% 50%"
      end
      local __lux_tmp_perspective_29 = spec.perspective
      if __lux_tmp_perspective_29 == nil then
        __lux_tmp_perspective_29 = 900
      end
      local __lux_tmp_scale_30 = spec.scale
      if __lux_tmp_scale_30 == nil then
        __lux_tmp_scale_30 = 1 + strength * num(spec.scaleLift, 0)
      end
      local __lux_tmp_steps_31 = spec.steps
      if __lux_tmp_steps_31 == nil then
        __lux_tmp_steps_31 = spec.subdivisions
      end
      if __lux_tmp_steps_31 == nil then
        __lux_tmp_steps_31 = 10
      end
      return compileCssTransform(
        {
          origin = __lux_tmp_origin_28,
          perspective = __lux_tmp_perspective_29,
          rotateX = -ny * maxX * strength,
          rotateY = nx * maxY * strength,
          scale = __lux_tmp_scale_30,
          steps = __lux_tmp_steps_31,
        },
        x,
        y,
        w,
        h
      )
    end
    compileTransform = function(spec, x, y, w, h)
      if typeOf(spec) ~= "table" then
        return nil
      end
      local kind = spec.kind
      if kind == nil then
        kind = spec.type
      end
      local route
      local __lux_match_32 = kind
      if __lux_match_32 == "pointerTilt" then
        route = 1
      elseif __lux_match_32 == "projectedQuad" or __lux_match_32 == "projected" then
        route = 2
      else
        route = nil
      end
      if route == 1 then
        return compilePointerTilt(spec, x, y, w, h)
      end
      if route == 2 then
        local __lux_tmp_x_33 = x
        if __lux_tmp_x_33 == nil then
          __lux_tmp_x_33 = 0
        end
        local __lux_tmp_y_34 = y
        if __lux_tmp_y_34 == nil then
          __lux_tmp_y_34 = 0
        end
        local __lux_tmp_w_35 = w
        if __lux_tmp_w_35 == nil then
          __lux_tmp_w_35 = 1
        end
        local __lux_tmp_h_36 = h
        if __lux_tmp_h_36 == nil then
          __lux_tmp_h_36 = 1
        end
        return compileProjectedQuad(
          spec,
          __lux_tmp_x_33,
          __lux_tmp_y_34,
          __lux_tmp_w_35,
          __lux_tmp_h_36
        )
      end
      if spec.tl ~= nil or isPoint(spec[1]) and isPoint(spec[2]) and isPoint(spec[3]) and isPoint(spec[4]) then
        local __lux_tmp_x_37 = x
        if __lux_tmp_x_37 == nil then
          __lux_tmp_x_37 = 0
        end
        local __lux_tmp_y_38 = y
        if __lux_tmp_y_38 == nil then
          __lux_tmp_y_38 = 0
        end
        local __lux_tmp_w_39 = w
        if __lux_tmp_w_39 == nil then
          __lux_tmp_w_39 = 1
        end
        local __lux_tmp_h_40 = h
        if __lux_tmp_h_40 == nil then
          __lux_tmp_h_40 = 1
        end
        return compileProjectedQuad(
          spec,
          __lux_tmp_x_37,
          __lux_tmp_y_38,
          __lux_tmp_w_39,
          __lux_tmp_h_40
        )
      end
      local __lux_tmp_x_41 = x
      if __lux_tmp_x_41 == nil then
        __lux_tmp_x_41 = 0
      end
      local __lux_tmp_y_42 = y
      if __lux_tmp_y_42 == nil then
        __lux_tmp_y_42 = 0
      end
      local __lux_tmp_w_43 = w
      if __lux_tmp_w_43 == nil then
        __lux_tmp_w_43 = 0
      end
      local __lux_tmp_h_44 = h
      if __lux_tmp_h_44 == nil then
        __lux_tmp_h_44 = 0
      end
      return compileCssTransform(
        spec,
        __lux_tmp_x_41,
        __lux_tmp_y_42,
        __lux_tmp_w_43,
        __lux_tmp_h_44
      )
    end
  end
  do
    hasTransform = function()
      return #transformStack > 0
    end
    transformNeedsGrid = function()
      for index = 1, #transformStack do
        local t = transformStack[index]
        local __lux_tmp_47 = t.kind == "projected" or t.perspective > 0
        if not __lux_tmp_47 then
          local __lux_cmp_46 = false
          if mathAbs(t.rotateX) ~= nil then
            __lux_cmp_46 = mathAbs(t.rotateX) > 0.0001
          end
          __lux_tmp_47 = __lux_cmp_46
        end
        local __lux_tmp_49 = __lux_tmp_47
        if not __lux_tmp_49 then
          local __lux_cmp_48 = false
          if mathAbs(t.rotateY) ~= nil then
            __lux_cmp_48 = mathAbs(t.rotateY) > 0.0001
          end
          __lux_tmp_49 = __lux_cmp_48
        end
        local __lux_tmp_50 = __lux_tmp_49
        if not __lux_tmp_50 then
          __lux_tmp_50 = t.steps > 1
        end
        if __lux_tmp_50 then
          return true
        end
      end
      return false
    end
    transformSteps = function()
      local steps = 1
      for index = 1, #transformStack do
        local t = transformStack[index]
        do
          local __lux_tmp_53 = t.kind == "projected" or t.perspective > 0
          if not __lux_tmp_53 then
            local __lux_cmp_52 = false
            if mathAbs(t.rotateX) ~= nil then
              __lux_cmp_52 = mathAbs(t.rotateX) > 0.0001
            end
            __lux_tmp_53 = __lux_cmp_52
          end
          local __lux_tmp_55 = __lux_tmp_53
          if not __lux_tmp_55 then
            local __lux_cmp_54 = false
            if mathAbs(t.rotateY) ~= nil then
              __lux_cmp_54 = mathAbs(t.rotateY) > 0.0001
            end
            __lux_tmp_55 = __lux_cmp_54
          end
          if __lux_tmp_55 then
            do
              local __lux_tmp_56
              if t.steps > 0 then
                __lux_tmp_56 = t.steps
              else
                __lux_tmp_56 = 10
              end
              steps = mathMax(steps, __lux_tmp_56)
            end
          else
            do
              local __lux_tmp_57
              if t.steps > 0 then
                __lux_tmp_57 = t.steps
              else
                __lux_tmp_57 = 1
              end
              steps = mathMax(steps, __lux_tmp_57)
            end
          end
        end
      end
      return mathClamp(steps, 1, 24)
    end
    applyOneTransform = function(t, x, y)
      if t.kind == "projected" then
        local u = (x - t.x) / t.w
        local v = (y - t.y) / t.h
        local topX = t.tlx + (t.trx - t.tlx) * u
        local topY = t.tly + (t.try - t.tly) * u
        local bottomX = t.blx + (t.brx - t.blx) * u
        local bottomY = t.bly + (t.bry - t.bly) * u
        return topX + (bottomX - topX) * v, topY + (bottomY - topY) * v
      end
      local lx = x - t.originX
      local ly = y - t.originY
      local sx = lx * t.scaleX + ly * t.skewX
      local sy = ly * t.scaleY + lx * t.skewY
      local sz = 0
      local __lux_cmp_58 = false
      if mathAbs(t.rotateX) ~= nil then
        __lux_cmp_58 = mathAbs(t.rotateX) > 0.0001
      end
      if __lux_cmp_58 then
        local c = mathCos(t.rotateX)
        local s = mathSin(t.rotateX)
        sy, sz = sy * c - sz * s, sy * s + sz * c
      end
      local __lux_cmp_59 = false
      if mathAbs(t.rotateY) ~= nil then
        __lux_cmp_59 = mathAbs(t.rotateY) > 0.0001
      end
      if __lux_cmp_59 then
        local c = mathCos(t.rotateY)
        local s = mathSin(t.rotateY)
        sx, sz = sx * c + sz * s, -sx * s + sz * c
      end
      local __lux_cmp_60 = false
      if mathAbs(t.rotate) ~= nil then
        __lux_cmp_60 = mathAbs(t.rotate) > 0.0001
      end
      if __lux_cmp_60 then
        local c = mathCos(t.rotate)
        local s = mathSin(t.rotate)
        sx, sy = sx * c - sy * s, sx * s + sy * c
      end
      do
        local __lux_tmp_translateZ_61 = t.translateZ
        if __lux_tmp_translateZ_61 == nil then
          __lux_tmp_translateZ_61 = 0
        end
        sz = sz + __lux_tmp_translateZ_61
      end
      local p = t.perspective
      if p > 0 then
        local denom = mathMax(0.05, p - sz)
        local factor = p / denom
        sx = sx * factor
        sy = sy * factor
      end
      return t.originX + sx + t.translateX, t.originY + sy + t.translateY
    end
    inverseOneTransform = function(t, sx, sy, guessX, guessY)
      local x = toNumber(guessX)
      if x == nil then
        x = sx
      end
      local y = toNumber(guessY)
      if y == nil then
        y = sy
      end
      local eps = 0.5
      for _ = 1, 10 do
        local fx, fy = applyOneTransform(t, x, y)
        local ex = fx - sx
        local ey = fy - sy
        if mathAbs(ex) + mathAbs(ey) < 0.01 then
          return x, y
        end
        local ax, ay = applyOneTransform(t, x + eps, y)
        local bx, by = applyOneTransform(t, x, y + eps)
        local j00 = (ax - fx) / eps
        local j10 = (ay - fy) / eps
        local j01 = (bx - fx) / eps
        local j11 = (by - fy) / eps
        local det = j00 * j11 - j01 * j10
        local __lux_cmp_62 = false
        if mathAbs(det) ~= nil then
          __lux_cmp_62 = mathAbs(det) < 0.000001
        end
        if __lux_cmp_62 then
          return x, y
        end
        x = x - (ex * j11 - j01 * ey) / det
        y = y - (j00 * ey - ex * j10) / det
      end
      return x, y
    end
    transformPoint = function(x, y)
      for index = #transformStack, 1, -1 do
        x, y = applyOneTransform(transformStack[index], x, y)
      end
      return x, y
    end
    transformSpecPoint = function(spec, px, py, x, y, w, h)
      local t = compileTransform(spec, x, y, w, h)
      if t == nil then
        return px, py
      end
      return applyOneTransform(t, px, py)
    end
    untransformSpecPoint = function(spec, sx, sy, x, y, w, h)
      local t = compileTransform(spec, x, y, w, h)
      if t == nil then
        return sx, sy
      end
      return inverseOneTransform(t, sx, sy, sx, sy)
    end
    untransformPoint = function(sx, sy)
      for index = 1, #transformStack do
        sx, sy = inverseOneTransform(transformStack[index], sx, sy, sx, sy)
      end
      return sx, sy
    end
    transformedVertex = function(out, x, y, u, v)
      out.x, out.y = transformPoint(x, y)
      out.u = u
      out.v = v
      return out
    end
    drawTransformedPoly = function(verts)
      if not hasTransform() then
        surfaceDrawPoly(verts)
        do
          local __lux_tmp_draws_63 = stats.draws
          if __lux_tmp_draws_63 == nil then
            __lux_tmp_draws_63 = 0
          end
          stats.draws = __lux_tmp_draws_63 + 1
        end
        return
      end
      local out = transformPolyScratch
      for index = 1, #verts do
        local src = verts[index]
        local dst = out[index]
        if dst == nil then
          dst = {}
        end
        out[index] = dst
        do
          local __lux_tmp_x_64 = src.x
          if __lux_tmp_x_64 == nil then
            __lux_tmp_x_64 = src[1]
          end
          if __lux_tmp_x_64 == nil then
            __lux_tmp_x_64 = 0
          end
          local __lux_tmp_y_65 = src.y
          if __lux_tmp_y_65 == nil then
            __lux_tmp_y_65 = src[2]
          end
          if __lux_tmp_y_65 == nil then
            __lux_tmp_y_65 = 0
          end
          dst.x, dst.y = transformPoint(__lux_tmp_x_64, __lux_tmp_y_65)
        end
        dst.u = src.u
        dst.v = src.v
        dst.color = src.color
      end
      for index = #verts + 1, #out do
        out[index] = nil
      end
      surfaceDrawPoly(out)
      do
        local __lux_tmp_draws_66 = stats.draws
        if __lux_tmp_draws_66 == nil then
          __lux_tmp_draws_66 = 0
        end
        stats.draws = __lux_tmp_draws_66 + 1
      end
    end
    pushTransform = function(spec, x, y, w, h)
      local t = compileTransform(spec, x, y, w, h)
      if t == nil then
        return false
      end
      transformStack[#transformStack + 1] = t
      return true
    end
    popTransform = function()
      transformStack[#transformStack] = nil
    end
    withTransform = function(spec, x, y, w, h, callback)
      if spec == nil then
        return callback()
      end
      if not pushTransform(spec, x, y, w, h) then
        return callback()
      end
      local ok, a, b, c, d = pcallFn(callback)
      popTransform()
      if not ok then
        errorFn(a, 2)
      end
      return a, b, c, d
    end
    splitStyleTransform = function(drawStyle)
      if typeOf(drawStyle) ~= "table" then
        return nil, drawStyle
      end
      local nextTransform = drawStyle.transform
      if nextTransform == nil then
        return nil, drawStyle
      end
      local stripped = copyStyle(drawStyle)
      stripped.transform = nil
      return nextTransform, stripped
    end
    transform = function(spec)
      local __lux_tmp_spec_67 = spec
      if __lux_tmp_spec_67 == nil then
        __lux_tmp_spec_67 = {}
      end
      return copyStyle(__lux_tmp_spec_67)
    end
    projectedQuad = function(spec)
      local out
      do
        local __lux_tmp_spec_68 = spec
        if __lux_tmp_spec_68 == nil then
          __lux_tmp_spec_68 = {}
        end
        out = copyStyle(__lux_tmp_spec_68)
      end
      out.kind = "projectedQuad"
      return out
    end
    pointerTilt = function(x, y, spec)
      local out
      do
        local __lux_tmp_spec_69 = spec
        if __lux_tmp_spec_69 == nil then
          __lux_tmp_spec_69 = {}
        end
        out = copyStyle(__lux_tmp_spec_69)
      end
      out.kind = "pointerTilt"
      out.x = x
      out.y = y
      return out
    end
  end
  do
    materialUVCorrection = function(material)
      if material == nil or material.Width == nil or material.Height == nil then
        return nil
      end
      local cached = texturedRectUVCache[material]
      if cached ~= nil then
        return cached.du, cached.dv, cached.denomU, cached.denomV, cached.fullU0, cached.fullV0, cached.fullU1, cached.fullV1
      end
      local mw = toNumber(material:Width())
      if mw == nil then
        mw = 0
      end
      local mh = toNumber(material:Height())
      if mh == nil then
        mh = 0
      end
      if mw <= 1 or mh <= 1 then
        return nil
      end
      local du = 0.5 / mw
      local dv = 0.5 / mh
      local denomU = 1 - 2 * du
      local denomV = 1 - 2 * dv
      cached = {
        du = du,
        dv = dv,
        denomU = denomU,
        denomV = denomV,
        fullU0 = -du / denomU,
        fullV0 = -dv / denomV,
        fullU1 = (1 - du) / denomU,
        fullV1 = (1 - dv) / denomV,
      }
      texturedRectUVCache[material] = cached
      return cached.du, cached.dv, cached.denomU, cached.denomV, cached.fullU0, cached.fullV0, cached.fullU1, cached.fullV1
    end
    drawTexturedQuadUV = function(x, y, w, h, u0, v0, u1, v1, material)
      local trace = traceStart("geometry.drawTexturedQuadUV")
      if not hasTransform() then
        local uvTrace = traceStart("geometry.materialUVCorrection")
        local du, dv, denomU, denomV = materialUVCorrection(material)
        traceEnd(uvTrace)
        if du ~= nil then
          local surfaceTrace = traceStart("surface.DrawTexturedRectUV")
          surfaceDrawTexturedRectUV(
            x,
            y,
            w,
            h,
            (u0 - du) / denomU,
            (v0 - dv) / denomV,
            (u1 - du) / denomU,
            (v1 - dv) / denomV
          )
          traceEnd(surfaceTrace)
          do
            local __lux_tmp_draws_70 = stats.draws
            if __lux_tmp_draws_70 == nil then
              __lux_tmp_draws_70 = 0
            end
            stats.draws = __lux_tmp_draws_70 + 1
          end
          traceEnd(trace)
          return
        end
        local surfaceTrace = traceStart("surface.DrawTexturedRectUV")
        surfaceDrawTexturedRectUV(x, y, w, h, u0, v0, u1, v1)
        traceEnd(surfaceTrace)
        do
          local __lux_tmp_draws_71 = stats.draws
          if __lux_tmp_draws_71 == nil then
            __lux_tmp_draws_71 = 0
          end
          stats.draws = __lux_tmp_draws_71 + 1
        end
        traceEnd(trace)
        return
      end
      local transformTrace = traceStart("geometry.transformedGrid")
      local steps
      if transformNeedsGrid() then
        steps = transformSteps()
      else
        steps = 1
      end
      local draws = 0
      for gy = 0, steps - 1 do
        local yA = y + h * gy / steps
        local yB = y + h * (gy + 1) / steps
        local vA = v0 + (v1 - v0) * gy / steps
        local vB = v0 + (v1 - v0) * (gy + 1) / steps
        for gx = 0, steps - 1 do
          local xA = x + w * gx / steps
          local xB = x + w * (gx + 1) / steps
          local uA = u0 + (u1 - u0) * gx / steps
          local uB = u0 + (u1 - u0) * (gx + 1) / steps
          local verts = transformQuadVerts
          transformedVertex(verts[1], xA, yA, uA, vA)
          transformedVertex(verts[2], xB, yA, uB, vA)
          transformedVertex(verts[3], xB, yB, uB, vB)
          transformedVertex(verts[4], xA, yB, uA, vB)
          surfaceDrawPoly(verts)
          draws = draws + 1
        end
      end
      traceEnd(transformTrace)
      do
        local __lux_tmp_draws_72 = stats.draws
        if __lux_tmp_draws_72 == nil then
          __lux_tmp_draws_72 = 0
        end
        stats.draws = __lux_tmp_draws_72 + draws
      end
      return traceEnd(trace)
    end
    drawTexturedQuad = function(x, y, w, h, material)
      if hasTransform() then
        drawTexturedQuadUV(x, y, w, h, 0, 0, 1, 1, material)
        return
      end
      local du, unusedDv, unusedDenomU, unusedDenomV, fullU0, fullV0, fullU1, fullV1 = materialUVCorrection(material)
      if du ~= nil then
        surfaceDrawTexturedRectUV(x, y, w, h, fullU0, fullV0, fullU1, fullV1)
      else
        surfaceDrawTexturedRectUV(x, y, w, h, 0, 0, 1, 1)
      end
      do
        local __lux_tmp_draws_73 = stats.draws
        if __lux_tmp_draws_73 == nil then
          __lux_tmp_draws_73 = 0
        end
        stats.draws = __lux_tmp_draws_73 + 1
      end
    end
    drawCreatedMaterialTexturedRectUV = function(x, y, w, h, u0, v0, u1, v1)
      local du = 0.5 / 32
      local dv = 0.5 / 32
      u0, v0 = (u0 - du) / (1 - 2 * du), (v0 - dv) / (1 - 2 * dv)
      u1, v1 = (u1 - du) / (1 - 2 * du), (v1 - dv) / (1 - 2 * dv)
      if hasTransform() then
        return drawTexturedQuadUV(x, y, w, h, u0, v0, u1, v1)
      else
        surfaceDrawTexturedRectUV(x, y, w, h, u0, v0, u1, v1)
        do
          local __lux_tmp_draws_74 = stats.draws
          if __lux_tmp_draws_74 == nil then
            __lux_tmp_draws_74 = 0
          end
          stats.draws = __lux_tmp_draws_74 + 1
        end
      end
    end
    drawTexturedRectUV = function(x, y, w, h, u0, v0, u1, v1)
      if hasTransform() then
        return drawTexturedQuadUV(x, y, w, h, u0, v0, u1, v1)
      else
        surfaceDrawTexturedRectUV(x, y, w, h, u0, v0, u1, v1)
        do
          local __lux_tmp_draws_75 = stats.draws
          if __lux_tmp_draws_75 == nil then
            __lux_tmp_draws_75 = 0
          end
          stats.draws = __lux_tmp_draws_75 + 1
        end
      end
    end
    textureSize = function(texture)
      local tw = 1
      local th = 1
      if texture ~= nil and texture.Width ~= nil then
        do
          local __lux_tmp_Width_76 = toNumber(texture:Width())
          if __lux_tmp_Width_76 == nil then
            __lux_tmp_Width_76 = tw
          end
          tw = __lux_tmp_Width_76
        end
      end
      if texture ~= nil and texture.Height ~= nil then
        do
          local __lux_tmp_Height_77 = toNumber(texture:Height())
          if __lux_tmp_Height_77 == nil then
            __lux_tmp_Height_77 = th
          end
          th = __lux_tmp_Height_77
        end
      end
      return mathMax(1, tw), mathMax(1, th)
    end
  end
  do
    imageTint = function(drawStyle)
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local tint
      do
        local __lux_tmp_tint_78 = resolved.tint
        if __lux_tmp_tint_78 == nil then
          __lux_tmp_tint_78 = resolved.color
        end
        tint = styleUtil.asColor(__lux_tmp_tint_78, color_white)
      end
      local alpha
      if tint.a == nil then
        alpha = 255
      else
        alpha = tint.a
      end
      local opacity = resolved.alpha
      if opacity == nil then
        return tint
      end
      do
        local __lux_tmp_opacity_79 = toNumber(opacity)
        if __lux_tmp_opacity_79 == nil then
          __lux_tmp_opacity_79 = 255
        end
        opacity = __lux_tmp_opacity_79
      end
      if opacity <= 1 then
        alpha = alpha * mathClamp(opacity, 0, 1)
      else
        alpha = alpha * mathClamp(opacity, 0, 255) / 255
      end
      do
        local __lux_tmp_r_80 = tint.r
        if __lux_tmp_r_80 == nil then
          __lux_tmp_r_80 = 255
        end
        imageTintScratch.r = __lux_tmp_r_80
      end
      do
        local __lux_tmp_g_81 = tint.g
        if __lux_tmp_g_81 == nil then
          __lux_tmp_g_81 = 255
        end
        imageTintScratch.g = __lux_tmp_g_81
      end
      do
        local __lux_tmp_b_82 = tint.b
        if __lux_tmp_b_82 == nil then
          __lux_tmp_b_82 = 255
        end
        imageTintScratch.b = __lux_tmp_b_82
      end
      imageTintScratch.a = mathFloor(mathClamp(alpha, 0, 255))
      return imageTintScratch
    end
    imageStyle = function(drawStyle)
      if typeOf(drawStyle) == "table" then
        return copyStyle(drawStyle)
      end
      if drawStyle ~= nil then
        return { radius = drawStyle }
      end
      return {}
    end
    imageRadius = function(radius, w, h)
      if radius == true then
        return mathMin(w, h) * 0.5
      end
      if typeOf(radius) == "string" then
        local lower = stringLower(radius)
        if lower == "circle" then
          return mathMin(w, h) * 0.5
        end
        local pct = stringMatch(lower, "^%s*([%d%.]+)%s*%%%s*$")
        if pct ~= nil then
          local __lux_tmp_pct_83 = toNumber(pct)
          if __lux_tmp_pct_83 == nil then
            __lux_tmp_pct_83 = 0
          end
          return mathMin(w, h) * mathClamp(__lux_tmp_pct_83 / 100, 0, 1)
        end
        local px = stringMatch(lower, "^%s*([%d%.]+)%s*px%s*$")
        if px ~= nil then
          local __lux_tmp_px_84 = toNumber(px)
          if __lux_tmp_px_84 == nil then
            __lux_tmp_px_84 = 0
          end
          return __lux_tmp_px_84
        end
      end
      local __lux_tmp_radius_85 = toNumber(radius)
      if __lux_tmp_radius_85 == nil then
        __lux_tmp_radius_85 = 0
      end
      return mathMax(0, __lux_tmp_radius_85)
    end
    imageAlign = function(drawStyle)
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local ax = resolved.alignX
      local ay = resolved.alignY
      if ax == nil then
        ax = resolved.positionX
      end
      if ay == nil then
        ay = resolved.positionY
      end
      local position = resolved.position
      if typeOf(position) == "table" then
        if ax == nil then
          do
            local __lux_tmp_x_86 = position.x
            if __lux_tmp_x_86 == nil then
              __lux_tmp_x_86 = position[1]
            end
            ax = __lux_tmp_x_86
          end
        end
        if ay == nil then
          do
            local __lux_tmp_y_87 = position.y
            if __lux_tmp_y_87 == nil then
              __lux_tmp_y_87 = position[2]
            end
            ay = __lux_tmp_y_87
          end
        end
      end
      local __lux_tmp_ax_88 = toNumber(ax)
      if __lux_tmp_ax_88 == nil then
        __lux_tmp_ax_88 = 0.5
      end
      local __lux_tmp_ay_89 = toNumber(ay)
      if __lux_tmp_ay_89 == nil then
        __lux_tmp_ay_89 = 0.5
      end
      return mathClamp(__lux_tmp_ax_88, 0, 1), mathClamp(__lux_tmp_ay_89, 0, 1)
    end
    imageUV = function(drawStyle, texture)
      local u0 = 0
      local v0 = 0
      local u1 = 1
      local v1 = 1
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local uv = resolved.uv
      if typeOf(uv) == "table" then
        do
          local __lux_tmp_u0_90 = uv.u0
          if __lux_tmp_u0_90 == nil then
            __lux_tmp_u0_90 = uv.x0
          end
          if __lux_tmp_u0_90 == nil then
            __lux_tmp_u0_90 = uv[1]
          end
          local __lux_tmp_u0_91 = toNumber(__lux_tmp_u0_90)
          if __lux_tmp_u0_91 == nil then
            __lux_tmp_u0_91 = u0
          end
          u0 = __lux_tmp_u0_91
        end
        do
          local __lux_tmp_v0_92 = uv.v0
          if __lux_tmp_v0_92 == nil then
            __lux_tmp_v0_92 = uv.y0
          end
          if __lux_tmp_v0_92 == nil then
            __lux_tmp_v0_92 = uv[2]
          end
          local __lux_tmp_v0_93 = toNumber(__lux_tmp_v0_92)
          if __lux_tmp_v0_93 == nil then
            __lux_tmp_v0_93 = v0
          end
          v0 = __lux_tmp_v0_93
        end
        do
          local __lux_tmp_u1_94 = uv.u1
          if __lux_tmp_u1_94 == nil then
            __lux_tmp_u1_94 = uv.x1
          end
          if __lux_tmp_u1_94 == nil then
            __lux_tmp_u1_94 = uv[3]
          end
          local __lux_tmp_u1_95 = toNumber(__lux_tmp_u1_94)
          if __lux_tmp_u1_95 == nil then
            __lux_tmp_u1_95 = u1
          end
          u1 = __lux_tmp_u1_95
        end
        do
          local __lux_tmp_v1_96 = uv.v1
          if __lux_tmp_v1_96 == nil then
            __lux_tmp_v1_96 = uv.y1
          end
          if __lux_tmp_v1_96 == nil then
            __lux_tmp_v1_96 = uv[4]
          end
          local __lux_tmp_v1_97 = toNumber(__lux_tmp_v1_96)
          if __lux_tmp_v1_97 == nil then
            __lux_tmp_v1_97 = v1
          end
          v1 = __lux_tmp_v1_97
        end
      else
        local crop = resolved.crop
        if typeOf(crop) == "table" then
          local pixels = crop.pixels
          if pixels == nil then
            pixels = crop.pixel
            if pixels == nil then
              pixels = resolved.cropPixels
              if pixels == nil then
                pixels = resolved.cropUnit == "px"
              end
            end
          end
          if crop.x ~= nil or crop.y ~= nil or crop.w ~= nil or crop.h ~= nil then
            local x = toNumber(crop.x)
            if x == nil then
              x = 0
            end
            local y = toNumber(crop.y)
            if y == nil then
              y = 0
            end
            local w
            do
              local __lux_tmp_w_98 = crop.w
              if __lux_tmp_w_98 == nil then
                __lux_tmp_w_98 = crop.width
              end
              w = toNumber(__lux_tmp_w_98)
              if w == nil then
                w = 1
              end
            end
            local h
            do
              local __lux_tmp_h_99 = crop.h
              if __lux_tmp_h_99 == nil then
                __lux_tmp_h_99 = crop.height
              end
              h = toNumber(__lux_tmp_h_99)
              if h == nil then
                h = 1
              end
            end
            if pixels then
              local tw, th = textureSize(texture)
              u0, v0, u1, v1 = x / tw, y / th, (x + w) / tw, (y + h) / th
            else
              u0, v0, u1, v1 = x, y, x + w, y + h
            end
          else
            do
              local __lux_tmp_u0_100 = crop.u0
              if __lux_tmp_u0_100 == nil then
                __lux_tmp_u0_100 = crop[1]
              end
              local __lux_tmp_u0_101 = toNumber(__lux_tmp_u0_100)
              if __lux_tmp_u0_101 == nil then
                __lux_tmp_u0_101 = u0
              end
              u0 = __lux_tmp_u0_101
            end
            do
              local __lux_tmp_v0_102 = crop.v0
              if __lux_tmp_v0_102 == nil then
                __lux_tmp_v0_102 = crop[2]
              end
              local __lux_tmp_v0_103 = toNumber(__lux_tmp_v0_102)
              if __lux_tmp_v0_103 == nil then
                __lux_tmp_v0_103 = v0
              end
              v0 = __lux_tmp_v0_103
            end
            do
              local __lux_tmp_u1_104 = crop.u1
              if __lux_tmp_u1_104 == nil then
                __lux_tmp_u1_104 = crop[3]
              end
              local __lux_tmp_u1_105 = toNumber(__lux_tmp_u1_104)
              if __lux_tmp_u1_105 == nil then
                __lux_tmp_u1_105 = u1
              end
              u1 = __lux_tmp_u1_105
            end
            do
              local __lux_tmp_v1_106 = crop.v1
              if __lux_tmp_v1_106 == nil then
                __lux_tmp_v1_106 = crop[4]
              end
              local __lux_tmp_v1_107 = toNumber(__lux_tmp_v1_106)
              if __lux_tmp_v1_107 == nil then
                __lux_tmp_v1_107 = v1
              end
              v1 = __lux_tmp_v1_107
            end
          end
        end
      end
      u0 = mathClamp(u0, 0, 1)
      v0 = mathClamp(v0, 0, 1)
      u1 = mathClamp(u1, 0, 1)
      v1 = mathClamp(v1, 0, 1)
      if u1 <= u0 then
        u0, u1 = 0, 1
      end
      if v1 <= v0 then
        v0, v1 = 0, 1
      end
      return u0, v0, u1, v1
    end
    imageFitRect = function(x, y, w, h, texture, drawStyle, u0, v0, u1, v1)
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local fit = resolved.fit
      if fit == nil then
        fit = resolved.objectFit
        if fit == nil then
          fit = "fill"
        end
      end
      if typeOf(fit) ~= "string" then
        fit = "fill"
      end
      fit = stringLower(fit)
      if fit == "stretch" then
        fit = "fill"
      end
      if fit == "fill" then
        return x, y, w, h, u0, v0, u1, v1
      end
      local tw, th = textureSize(texture)
      local spanU = u1 - u0
      local spanV = v1 - v0
      local sourceW = mathMax(1, tw * spanU)
      local sourceH = mathMax(1, th * spanV)
      local sourceAspect = sourceW / sourceH
      local destAspect = mathMax(1, w) / mathMax(1, h)
      local ax, ay = imageAlign(resolved)
      if fit == "cover" then
        if sourceAspect > destAspect then
          local newSpanU = spanV * th * destAspect / tw
          local extra = spanU - newSpanU
          u0 = u0 + extra * ax
          u1 = u0 + newSpanU
        else
          if sourceAspect < destAspect then
            local newSpanV = spanU * tw / destAspect / th
            local extra = spanV - newSpanV
            v0 = v0 + extra * ay
            v1 = v0 + newSpanV
          end
        end
      else
        if fit == "contain" then
          if sourceAspect > destAspect then
            local nextH = w / sourceAspect
            y = y + (h - nextH) * ay
            h = nextH
          else
            if sourceAspect < destAspect then
              local nextW = h * sourceAspect
              x = x + (w - nextW) * ax
              w = nextW
            end
          end
        end
      end
      return x, y, w, h, u0, v0, u1, v1
    end
  end
  do
    blurIntensity = function(value)
      local __lux_tmp_value_108 = toNumber(value)
      if __lux_tmp_value_108 == nil then
        __lux_tmp_value_108 = 16
      end
      return mathClamp(__lux_tmp_value_108 / 16, 0.001, 4)
    end
    bindStats = function(owner)
      do
        local __lux_tmp_stats_109 = owner.stats
        if __lux_tmp_stats_109 == nil then
          __lux_tmp_stats_109 = {}
        end
        owner.stats = __lux_tmp_stats_109
      end
      local targetStats = owner.stats
      for key, value in pairs(stats) do
        if targetStats[key] == nil then
          targetStats[key] = value
        end
      end
      stats = targetStats
      do
        local __lux_tmp_draws_110 = stats.draws
        if __lux_tmp_draws_110 == nil then
          __lux_tmp_draws_110 = 0
        end
        stats.draws = __lux_tmp_draws_110
      end
      do
        local __lux_tmp_blurPasses_111 = stats.blurPasses
        if __lux_tmp_blurPasses_111 == nil then
          __lux_tmp_blurPasses_111 = 0
        end
        stats.blurPasses = __lux_tmp_blurPasses_111
      end
      do
        local __lux_tmp_fallbacks_112 = stats.fallbacks
        if __lux_tmp_fallbacks_112 == nil then
          __lux_tmp_fallbacks_112 = 0
        end
        stats.fallbacks = __lux_tmp_fallbacks_112
      end
      do
        local __lux_tmp_culled_113 = stats.culled
        if __lux_tmp_culled_113 == nil then
          __lux_tmp_culled_113 = 0
        end
        stats.culled = __lux_tmp_culled_113
      end
      return stats
    end
    resetFrameStats = function()
      stats.draws = 0
      stats.blurPasses = 0
      stats.fallbacks = 0
      stats.culled = 0
      return stats
    end
    recordDraws = function(amount)
      if amount == nil then
        amount = 1
      end
      do
        local __lux_tmp_draws_114 = stats.draws
        if __lux_tmp_draws_114 == nil then
          __lux_tmp_draws_114 = 0
        end
        local __lux_tmp_amount_115 = amount
        if __lux_tmp_amount_115 == nil then
          __lux_tmp_amount_115 = 1
        end
        stats.draws = __lux_tmp_draws_114 + __lux_tmp_amount_115
      end
      return stats.draws
    end
    recordFallbacks = function(amount)
      if amount == nil then
        amount = 1
      end
      do
        local __lux_tmp_fallbacks_116 = stats.fallbacks
        if __lux_tmp_fallbacks_116 == nil then
          __lux_tmp_fallbacks_116 = 0
        end
        local __lux_tmp_amount_117 = amount
        if __lux_tmp_amount_117 == nil then
          __lux_tmp_amount_117 = 1
        end
        stats.fallbacks = __lux_tmp_fallbacks_116 + __lux_tmp_amount_117
      end
      return stats.fallbacks
    end
    profileSnapshot = function(reset)
      if reset == nil then
        reset = false
      end
      local out = tableCopy(stats)
      if reset then
        resetFrameStats()
      end
      return out
    end
    install = function(owner)
      geometryProfiler = owner.Profiler
      bindStats(owner)
      owner.Transform = transform
      owner.ProjectedQuad = projectedQuad
      owner.PointerTilt = pointerTilt
      owner.PushTransform = pushTransform
      owner.PopTransform = popTransform
      owner.TransformPoint = function(px, py, spec, x, y, w, h)
        if spec ~= nil then
          return transformSpecPoint(spec, px, py, x, y, w, h)
        end
        return transformPoint(px, py)
      end
      owner.UntransformPoint = function(px, py, spec, x, y, w, h)
        if spec ~= nil then
          return untransformSpecPoint(spec, px, py, x, y, w, h)
        end
        return untransformPoint(px, py)
      end
      owner.ResetGeometryFrameStats = resetFrameStats
      owner.GetGeometryProfileSnapshot = profileSnapshot
      do
        local __lux_tmp_internal_118 = owner._internal
        if __lux_tmp_internal_118 == nil then
          __lux_tmp_internal_118 = {}
        end
        owner._internal = __lux_tmp_internal_118
      end
      owner._Geometry = {
        blurIntensity = blurIntensity,
        resetFrameStats = resetFrameStats,
        recordDraws = recordDraws,
        recordFallbacks = recordFallbacks,
        drawTexturedQuad = drawTexturedQuad,
        drawTexturedQuadUV = drawTexturedQuadUV,
        drawTransformedPoly = drawTransformedPoly,
        withTransform = withTransform,
        splitStyleTransform = splitStyleTransform,
        pushTransform = pushTransform,
        popTransform = popTransform,
        hasTransform = hasTransform,
        drawCreatedMaterialTexturedRectUV = drawCreatedMaterialTexturedRectUV,
        drawTexturedRectUV = drawTexturedRectUV,
        textureSize = textureSize,
        imageTint = imageTint,
        imageStyle = imageStyle,
        imageRadius = imageRadius,
        imageAlign = imageAlign,
        imageUV = imageUV,
        imageFitRect = imageFitRect,
        profileSnapshot = profileSnapshot,
      }
      owner._internal.drawTexturedQuad = drawTexturedQuad
      owner._internal.drawTexturedQuadUV = drawTexturedQuadUV
      return owner
    end
  end
  
  __lux_exports.hasTransform = hasTransform
  __lux_exports.transformPoint = transformPoint
  __lux_exports.untransformPoint = untransformPoint
  __lux_exports.drawTransformedPoly = drawTransformedPoly
  __lux_exports.pushTransform = pushTransform
  __lux_exports.popTransform = popTransform
  __lux_exports.withTransform = withTransform
  __lux_exports.splitStyleTransform = splitStyleTransform
  __lux_exports.transform = transform
  __lux_exports.projectedQuad = projectedQuad
  __lux_exports.pointerTilt = pointerTilt
  __lux_exports.drawTexturedQuadUV = drawTexturedQuadUV
  __lux_exports.drawTexturedQuad = drawTexturedQuad
  __lux_exports.drawCreatedMaterialTexturedRectUV = drawCreatedMaterialTexturedRectUV
  __lux_exports.drawTexturedRectUV = drawTexturedRectUV
  __lux_exports.textureSize = textureSize
  __lux_exports.imageTint = imageTint
  __lux_exports.imageStyle = imageStyle
  __lux_exports.imageRadius = imageRadius
  __lux_exports.imageAlign = imageAlign
  __lux_exports.imageUV = imageUV
  __lux_exports.imageFitRect = imageFitRect
  __lux_exports.blurIntensity = blurIntensity
  __lux_exports.resetFrameStats = resetFrameStats
  __lux_exports.recordDraws = recordDraws
  __lux_exports.recordFallbacks = recordFallbacks
  __lux_exports.profileSnapshot = profileSnapshot
  __lux_exports.install = install
  
  return __lux_exports
end
