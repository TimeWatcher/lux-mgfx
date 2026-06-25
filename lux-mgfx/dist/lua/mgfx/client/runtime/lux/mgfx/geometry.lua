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
    local __lux_import_1 = __lux_import("lux/mgfx/style#client")
    local styleUtilImport = __lux_import_1
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
      local __lux_tmp_2 = geometryProfiler ~= nil
      if __lux_tmp_2 then
        __lux_tmp_2 = geometryProfiler._TraceActive
      end
      local __lux_tmp_3 = __lux_tmp_2
      if __lux_tmp_3 then
        __lux_tmp_3 = geometryProfiler.TraceStart ~= nil
      end
      if __lux_tmp_3 then
        return geometryProfiler.TraceStart(name)
      end
      return nil
    end
    traceEnd = function(token)
      local __lux_tmp_4 = token ~= nil
      if __lux_tmp_4 then
        __lux_tmp_4 = geometryProfiler ~= nil
      end
      local __lux_tmp_5 = __lux_tmp_4
      if __lux_tmp_5 then
        __lux_tmp_5 = geometryProfiler.TraceEnd ~= nil
      end
      if __lux_tmp_5 then
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
      local __lux_tmp_6 = typeOf(value) == "table"
      if __lux_tmp_6 then
        local __lux_tmp_7 = value.x ~= nil
        if not __lux_tmp_7 then
          __lux_tmp_7 = value[1] ~= nil
        end
        __lux_tmp_6 = __lux_tmp_7
      end
      local __lux_tmp_8 = __lux_tmp_6
      if __lux_tmp_8 then
        local __lux_tmp_9 = value.y ~= nil
        if not __lux_tmp_9 then
          __lux_tmp_9 = value[2] ~= nil
        end
        __lux_tmp_8 = __lux_tmp_9
      end
      return __lux_tmp_8
    end
    pointXY = function(value, fallbackX, fallbackY)
      if fallbackX == nil then
        fallbackX = 0
      end
      if fallbackY == nil then
        fallbackY = 0
      end
      if typeOf(value) ~= "table" then
        local __lux_tmp_10 = fallbackX
        if __lux_tmp_10 == nil then
          __lux_tmp_10 = 0
        end
        local __lux_tmp_11 = fallbackY
        if __lux_tmp_11 == nil then
          __lux_tmp_11 = 0
        end
        return __lux_tmp_10, __lux_tmp_11
      end
      local __lux_tmp_12 = value.x
      if __lux_tmp_12 == nil then
        __lux_tmp_12 = value[1]
      end
      local __lux_tmp_13 = toNumber(__lux_tmp_12)
      if __lux_tmp_13 == nil then
        local __lux_tmp_14 = fallbackX
        if __lux_tmp_14 == nil then
          __lux_tmp_14 = 0
        end
        __lux_tmp_13 = __lux_tmp_14
      end
      local __lux_tmp_15 = value.y
      if __lux_tmp_15 == nil then
        __lux_tmp_15 = value[2]
      end
      local __lux_tmp_16 = toNumber(__lux_tmp_15)
      if __lux_tmp_16 == nil then
        local __lux_tmp_17 = fallbackY
        if __lux_tmp_17 == nil then
          __lux_tmp_17 = 0
        end
        __lux_tmp_16 = __lux_tmp_17
      end
      return __lux_tmp_13, __lux_tmp_16
    end
    percentString = function(value)
      if typeOf(value) ~= "string" then
        return nil
      end
      local lower = stringLower(value)
      local alias
      local __lux_match_18 = lower
      if __lux_match_18 == "left" or __lux_match_18 == "top" then
        alias = 0
      elseif __lux_match_18 == "center" or __lux_match_18 == "middle" then
        alias = 0.5
      elseif __lux_match_18 == "right" or __lux_match_18 == "bottom" then
        alias = 1
      else
        alias = nil
      end
      if alias ~= nil then
        return alias
      end
      local pct = stringMatch(lower, "^%s*([%-%d%.]+)%s*%%%s*$")
      if pct ~= nil then
        local __lux_tmp_19 = toNumber(pct)
        if __lux_tmp_19 == nil then
          __lux_tmp_19 = 0
        end
        return __lux_tmp_19 / 100
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
      local __lux_tmp_20 = toNumber(value)
      if __lux_tmp_20 == nil then
        __lux_tmp_20 = size * fallback
      end
      return base + __lux_tmp_20
    end
    transformOrigin = function(spec, x, y, w, h)
      local origin
      do
        local __lux_tmp_21 = spec.origin
        if __lux_tmp_21 == nil then
          local __lux_tmp_22 = spec.transformOrigin
          if __lux_tmp_22 == nil then
            __lux_tmp_22 = spec.anchor
          end
          __lux_tmp_21 = __lux_tmp_22
        end
        origin = __lux_tmp_21
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
        local __lux_tmp_23 = origin.x
        if __lux_tmp_23 == nil then
          __lux_tmp_23 = origin[1]
        end
        local __lux_tmp_24 = origin.y
        if __lux_tmp_24 == nil then
          __lux_tmp_24 = origin[2]
        end
        return axisOrigin(__lux_tmp_23, x, w, 0.5), axisOrigin(__lux_tmp_24, y, h, 0.5)
      end
      return x + w * 0.5, y + h * 0.5
    end
    num = function(value, fallback)
      if fallback == nil then
        fallback = 0
      end
      local __lux_tmp_25 = toNumber(value)
      if __lux_tmp_25 == nil then
        local __lux_tmp_26 = fallback
        if __lux_tmp_26 == nil then
          __lux_tmp_26 = 0
        end
        __lux_tmp_25 = __lux_tmp_26
      end
      return __lux_tmp_25
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
      local scaleX
      do
        local __lux_tmp_27 = spec.scaleX
        if __lux_tmp_27 == nil then
          local __lux_tmp_28
          if typeOf(scale) == "table" then
            do
              local __lux_tmp_29 = scale.x
              if __lux_tmp_29 == nil then
                __lux_tmp_29 = scale[1]
              end
              __lux_tmp_28 = __lux_tmp_29
            end
          else
            __lux_tmp_28 = scale
          end
          local __lux_tmp_30 = __lux_tmp_28
          if __lux_tmp_30 == nil then
            __lux_tmp_30 = 1
          end
          __lux_tmp_27 = __lux_tmp_30
        end
        scaleX = __lux_tmp_27
      end
      local scaleY
      do
        local __lux_tmp_31 = spec.scaleY
        if __lux_tmp_31 == nil then
          local __lux_tmp_32
          if typeOf(scale) == "table" then
            do
              local __lux_tmp_33 = scale.y
              if __lux_tmp_33 == nil then
                __lux_tmp_33 = scale[2]
              end
              __lux_tmp_32 = __lux_tmp_33
            end
          else
            __lux_tmp_32 = scale
          end
          local __lux_tmp_34 = __lux_tmp_32
          if __lux_tmp_34 == nil then
            __lux_tmp_34 = 1
          end
          __lux_tmp_31 = __lux_tmp_34
        end
        scaleY = __lux_tmp_31
      end
      local tx
      do
        local __lux_tmp_35 = spec.x
        if __lux_tmp_35 == nil then
          local __lux_tmp_36 = spec.translateX
          if __lux_tmp_36 == nil then
            local __lux_tmp_37
            if typeOf(translate) == "table" then
              do
                local __lux_tmp_38 = translate.x
                if __lux_tmp_38 == nil then
                  __lux_tmp_38 = translate[1]
                end
                __lux_tmp_37 = __lux_tmp_38
              end
            else
              __lux_tmp_37 = nil
            end
            local __lux_tmp_39 = __lux_tmp_37
            if __lux_tmp_39 == nil then
              __lux_tmp_39 = 0
            end
            __lux_tmp_36 = __lux_tmp_39
          end
          __lux_tmp_35 = __lux_tmp_36
        end
        tx = __lux_tmp_35
      end
      local ty
      do
        local __lux_tmp_40 = spec.y
        if __lux_tmp_40 == nil then
          local __lux_tmp_41 = spec.translateY
          if __lux_tmp_41 == nil then
            local __lux_tmp_42
            if typeOf(translate) == "table" then
              do
                local __lux_tmp_43 = translate.y
                if __lux_tmp_43 == nil then
                  __lux_tmp_43 = translate[2]
                end
                __lux_tmp_42 = __lux_tmp_43
              end
            else
              __lux_tmp_42 = nil
            end
            local __lux_tmp_44 = __lux_tmp_42
            if __lux_tmp_44 == nil then
              __lux_tmp_44 = 0
            end
            __lux_tmp_41 = __lux_tmp_44
          end
          __lux_tmp_40 = __lux_tmp_41
        end
        ty = __lux_tmp_40
      end
      local tz
      do
        local __lux_tmp_45 = spec.z
        if __lux_tmp_45 == nil then
          local __lux_tmp_46 = spec.translateZ
          if __lux_tmp_46 == nil then
            local __lux_tmp_47
            if typeOf(translate) == "table" then
              do
                local __lux_tmp_48 = translate.z
                if __lux_tmp_48 == nil then
                  __lux_tmp_48 = translate[3]
                end
                __lux_tmp_47 = __lux_tmp_48
              end
            else
              __lux_tmp_47 = nil
            end
            local __lux_tmp_49 = __lux_tmp_47
            if __lux_tmp_49 == nil then
              __lux_tmp_49 = 0
            end
            __lux_tmp_46 = __lux_tmp_49
          end
          __lux_tmp_45 = __lux_tmp_46
        end
        tz = __lux_tmp_45
      end
      local skewX
      do
        local __lux_tmp_50 = spec.skewX
        if __lux_tmp_50 == nil then
          local __lux_tmp_51
          if typeOf(skew) == "table" then
            do
              local __lux_tmp_52 = skew.x
              if __lux_tmp_52 == nil then
                __lux_tmp_52 = skew[1]
              end
              __lux_tmp_51 = __lux_tmp_52
            end
          else
            __lux_tmp_51 = nil
          end
          local __lux_tmp_53 = __lux_tmp_51
          if __lux_tmp_53 == nil then
            __lux_tmp_53 = 0
          end
          __lux_tmp_50 = __lux_tmp_53
        end
        skewX = __lux_tmp_50
      end
      local skewY
      do
        local __lux_tmp_54 = spec.skewY
        if __lux_tmp_54 == nil then
          local __lux_tmp_55
          if typeOf(skew) == "table" then
            do
              local __lux_tmp_56 = skew.y
              if __lux_tmp_56 == nil then
                __lux_tmp_56 = skew[2]
              end
              __lux_tmp_55 = __lux_tmp_56
            end
          else
            __lux_tmp_55 = nil
          end
          local __lux_tmp_57 = __lux_tmp_55
          if __lux_tmp_57 == nil then
            __lux_tmp_57 = 0
          end
          __lux_tmp_54 = __lux_tmp_57
        end
        skewY = __lux_tmp_54
      end
      local rotate
      do
        local __lux_tmp_58 = spec.rotate
        if __lux_tmp_58 == nil then
          local __lux_tmp_59 = spec.rotateZ
          if __lux_tmp_59 == nil then
            __lux_tmp_59 = 0
          end
          __lux_tmp_58 = __lux_tmp_59
        end
        rotate = __lux_tmp_58
      end
      local rotateX
      do
        local __lux_tmp_60 = spec.rotateX
        if __lux_tmp_60 == nil then
          local __lux_tmp_61 = spec.pitch
          if __lux_tmp_61 == nil then
            __lux_tmp_61 = 0
          end
          __lux_tmp_60 = __lux_tmp_61
        end
        rotateX = __lux_tmp_60
      end
      local rotateY
      do
        local __lux_tmp_62 = spec.rotateY
        if __lux_tmp_62 == nil then
          local __lux_tmp_63 = spec.yaw
          if __lux_tmp_63 == nil then
            __lux_tmp_63 = 0
          end
          __lux_tmp_62 = __lux_tmp_63
        end
        rotateY = __lux_tmp_62
      end
      local __lux_tmp_64 = spec.perspective
      if __lux_tmp_64 == nil then
        __lux_tmp_64 = spec.depth
      end
      local __lux_tmp_65 = spec.steps
      if __lux_tmp_65 == nil then
        __lux_tmp_65 = spec.subdivisions
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
        perspective = mathMax(0, num(__lux_tmp_64, 0)),
        steps = mathClamp(mathFloor(num(__lux_tmp_65, 0)), 0, 24),
      }
    end
    projectedCorner = function(spec, name, index)
      local __lux_tmp_66 = spec[name]
      if __lux_tmp_66 == nil then
        __lux_tmp_66 = spec[index]
      end
      return pointXY(__lux_tmp_66, 0, 0)
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
      local __lux_tmp_67 = spec.steps
      if __lux_tmp_67 == nil then
        __lux_tmp_67 = spec.subdivisions
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
        steps = mathClamp(mathFloor(num(__lux_tmp_67, 10)), 1, 24),
      }
    end
    compilePointerTilt = function(spec, x, y, w, h)
      local __lux_tmp_68 = x == nil
      if not __lux_tmp_68 then
        __lux_tmp_68 = y == nil
      end
      local __lux_tmp_69 = __lux_tmp_68
      if not __lux_tmp_69 then
        __lux_tmp_69 = w == nil
      end
      local __lux_tmp_70 = __lux_tmp_69
      if not __lux_tmp_70 then
        __lux_tmp_70 = h == nil
      end
      if __lux_tmp_70 then
        return nil
      end
      local px
      do
        local __lux_tmp_71 = spec.pointerX
        if __lux_tmp_71 == nil then
          local __lux_tmp_72 = spec.x
          if __lux_tmp_72 == nil then
            __lux_tmp_72 = spec[1]
          end
          __lux_tmp_71 = __lux_tmp_72
        end
        local __lux_tmp_73 = toNumber(__lux_tmp_71)
        if __lux_tmp_73 == nil then
          __lux_tmp_73 = x + w * 0.5
        end
        px = __lux_tmp_73
      end
      local py
      do
        local __lux_tmp_74 = spec.pointerY
        if __lux_tmp_74 == nil then
          local __lux_tmp_75 = spec.y
          if __lux_tmp_75 == nil then
            __lux_tmp_75 = spec[2]
          end
          __lux_tmp_74 = __lux_tmp_75
        end
        local __lux_tmp_76 = toNumber(__lux_tmp_74)
        if __lux_tmp_76 == nil then
          __lux_tmp_76 = y + h * 0.5
        end
        py = __lux_tmp_76
      end
      local strength = mathClamp(num(spec.strength, 1), 0, 1)
      local nx = mathClamp((px - (x + w * 0.5)) / mathMax(w * 0.5, 0.0001), -1, 1)
      local ny = mathClamp((py - (y + h * 0.5)) / mathMax(h * 0.5, 0.0001), -1, 1)
      local maxX
      do
        local __lux_tmp_77 = spec.maxRotateX
        if __lux_tmp_77 == nil then
          local __lux_tmp_78 = spec.maxX
          if __lux_tmp_78 == nil then
            local __lux_tmp_79 = spec.max
            if __lux_tmp_79 == nil then
              __lux_tmp_79 = spec.amount
            end
            __lux_tmp_78 = __lux_tmp_79
          end
          __lux_tmp_77 = __lux_tmp_78
        end
        maxX = num(__lux_tmp_77, 6)
      end
      local maxY
      do
        local __lux_tmp_80 = spec.maxRotateY
        if __lux_tmp_80 == nil then
          local __lux_tmp_81 = spec.maxY
          if __lux_tmp_81 == nil then
            local __lux_tmp_82 = spec.max
            if __lux_tmp_82 == nil then
              __lux_tmp_82 = spec.amount
            end
            __lux_tmp_81 = __lux_tmp_82
          end
          __lux_tmp_80 = __lux_tmp_81
        end
        maxY = num(__lux_tmp_80, 6)
      end
      local __lux_tmp_83 = spec.origin
      if __lux_tmp_83 == nil then
        local __lux_tmp_84 = spec.transformOrigin
        if __lux_tmp_84 == nil then
          __lux_tmp_84 = "50% 50%"
        end
        __lux_tmp_83 = __lux_tmp_84
      end
      local __lux_tmp_85 = spec.perspective
      if __lux_tmp_85 == nil then
        __lux_tmp_85 = 900
      end
      local __lux_tmp_86 = spec.scale
      if __lux_tmp_86 == nil then
        __lux_tmp_86 = 1 + strength * num(spec.scaleLift, 0)
      end
      local __lux_tmp_87 = spec.steps
      if __lux_tmp_87 == nil then
        local __lux_tmp_88 = spec.subdivisions
        if __lux_tmp_88 == nil then
          __lux_tmp_88 = 10
        end
        __lux_tmp_87 = __lux_tmp_88
      end
      return compileCssTransform(
        {
          origin = __lux_tmp_83,
          perspective = __lux_tmp_85,
          rotateX = -ny * maxX * strength,
          rotateY = nx * maxY * strength,
          scale = __lux_tmp_86,
          steps = __lux_tmp_87,
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
      local kind
      do
        local __lux_tmp_89 = spec.kind
        if __lux_tmp_89 == nil then
          __lux_tmp_89 = spec.type
        end
        kind = __lux_tmp_89
      end
      local route
      local __lux_match_90 = kind
      if __lux_match_90 == "pointerTilt" then
        route = 1
      elseif __lux_match_90 == "projectedQuad" or __lux_match_90 == "projected" then
        route = 2
      else
        route = nil
      end
      if route == 1 then
        return compilePointerTilt(spec, x, y, w, h)
      end
      if route == 2 then
        local __lux_tmp_91 = x
        if __lux_tmp_91 == nil then
          __lux_tmp_91 = 0
        end
        local __lux_tmp_92 = y
        if __lux_tmp_92 == nil then
          __lux_tmp_92 = 0
        end
        local __lux_tmp_93 = w
        if __lux_tmp_93 == nil then
          __lux_tmp_93 = 1
        end
        local __lux_tmp_94 = h
        if __lux_tmp_94 == nil then
          __lux_tmp_94 = 1
        end
        return compileProjectedQuad(spec, __lux_tmp_91, __lux_tmp_92, __lux_tmp_93, __lux_tmp_94)
      end
      local __lux_tmp_95 = spec.tl ~= nil
      if not __lux_tmp_95 then
        local __lux_tmp_96 = isPoint(spec[1])
        if __lux_tmp_96 then
          __lux_tmp_96 = isPoint(spec[2])
        end
        local __lux_tmp_97 = __lux_tmp_96
        if __lux_tmp_97 then
          __lux_tmp_97 = isPoint(spec[3])
        end
        local __lux_tmp_98 = __lux_tmp_97
        if __lux_tmp_98 then
          __lux_tmp_98 = isPoint(spec[4])
        end
        __lux_tmp_95 = __lux_tmp_98
      end
      if __lux_tmp_95 then
        local __lux_tmp_99 = x
        if __lux_tmp_99 == nil then
          __lux_tmp_99 = 0
        end
        local __lux_tmp_100 = y
        if __lux_tmp_100 == nil then
          __lux_tmp_100 = 0
        end
        local __lux_tmp_101 = w
        if __lux_tmp_101 == nil then
          __lux_tmp_101 = 1
        end
        local __lux_tmp_102 = h
        if __lux_tmp_102 == nil then
          __lux_tmp_102 = 1
        end
        return compileProjectedQuad(spec, __lux_tmp_99, __lux_tmp_100, __lux_tmp_101, __lux_tmp_102)
      end
      local __lux_tmp_103 = x
      if __lux_tmp_103 == nil then
        __lux_tmp_103 = 0
      end
      local __lux_tmp_104 = y
      if __lux_tmp_104 == nil then
        __lux_tmp_104 = 0
      end
      local __lux_tmp_105 = w
      if __lux_tmp_105 == nil then
        __lux_tmp_105 = 0
      end
      local __lux_tmp_106 = h
      if __lux_tmp_106 == nil then
        __lux_tmp_106 = 0
      end
      return compileCssTransform(spec, __lux_tmp_103, __lux_tmp_104, __lux_tmp_105, __lux_tmp_106)
    end
  end
  do
    hasTransform = function()
      return #transformStack > 0
    end
    transformNeedsGrid = function()
      for index = 1, #transformStack do
        local t = transformStack[index]
        local __lux_tmp_107 = t.kind == "projected"
        if not __lux_tmp_107 then
          __lux_tmp_107 = t.perspective > 0
        end
        local __lux_tmp_108 = __lux_tmp_107
        if not __lux_tmp_108 then
          local __lux_cmp_109 = false
          if mathAbs(t.rotateX) ~= nil and 0.0001 ~= nil then
            __lux_cmp_109 = mathAbs(t.rotateX) > 0.0001
          end
          __lux_tmp_108 = __lux_cmp_109
        end
        local __lux_tmp_110 = __lux_tmp_108
        if not __lux_tmp_110 then
          local __lux_cmp_111 = false
          if mathAbs(t.rotateY) ~= nil and 0.0001 ~= nil then
            __lux_cmp_111 = mathAbs(t.rotateY) > 0.0001
          end
          __lux_tmp_110 = __lux_cmp_111
        end
        local __lux_tmp_112 = __lux_tmp_110
        if not __lux_tmp_112 then
          __lux_tmp_112 = t.steps > 1
        end
        if __lux_tmp_112 then
          return true
        end
      end
      return false
    end
    transformSteps = function()
      local steps = 1
      for index = 1, #transformStack do
        local t = transformStack[index]
        local __lux_tmp_113 = t.kind == "projected"
        if not __lux_tmp_113 then
          __lux_tmp_113 = t.perspective > 0
        end
        local __lux_tmp_114 = __lux_tmp_113
        if not __lux_tmp_114 then
          local __lux_cmp_115 = false
          if mathAbs(t.rotateX) ~= nil and 0.0001 ~= nil then
            __lux_cmp_115 = mathAbs(t.rotateX) > 0.0001
          end
          __lux_tmp_114 = __lux_cmp_115
        end
        local __lux_tmp_116 = __lux_tmp_114
        if not __lux_tmp_116 then
          local __lux_cmp_117 = false
          if mathAbs(t.rotateY) ~= nil and 0.0001 ~= nil then
            __lux_cmp_117 = mathAbs(t.rotateY) > 0.0001
          end
          __lux_tmp_116 = __lux_cmp_117
        end
        if __lux_tmp_116 then
          do
            local __lux_tmp_118
            if t.steps > 0 then
              __lux_tmp_118 = t.steps
            else
              __lux_tmp_118 = 10
            end
            steps = mathMax(steps, __lux_tmp_118)
          end
        else
          do
            local __lux_tmp_119
            if t.steps > 0 then
              __lux_tmp_119 = t.steps
            else
              __lux_tmp_119 = 1
            end
            steps = mathMax(steps, __lux_tmp_119)
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
      local __lux_cmp_120 = false
      if mathAbs(t.rotateX) ~= nil and 0.0001 ~= nil then
        __lux_cmp_120 = mathAbs(t.rotateX) > 0.0001
      end
      if __lux_cmp_120 then
        local c = mathCos(t.rotateX)
        local s = mathSin(t.rotateX)
        sy, sz = sy * c - sz * s, sy * s + sz * c
      end
      local __lux_cmp_121 = false
      if mathAbs(t.rotateY) ~= nil and 0.0001 ~= nil then
        __lux_cmp_121 = mathAbs(t.rotateY) > 0.0001
      end
      if __lux_cmp_121 then
        local c = mathCos(t.rotateY)
        local s = mathSin(t.rotateY)
        sx, sz = sx * c + sz * s, -sx * s + sz * c
      end
      local __lux_cmp_122 = false
      if mathAbs(t.rotate) ~= nil and 0.0001 ~= nil then
        __lux_cmp_122 = mathAbs(t.rotate) > 0.0001
      end
      if __lux_cmp_122 then
        local c = mathCos(t.rotate)
        local s = mathSin(t.rotate)
        sx, sy = sx * c - sy * s, sx * s + sy * c
      end
      do
        local __lux_tmp_123 = t.translateZ
        if __lux_tmp_123 == nil then
          __lux_tmp_123 = 0
        end
        sz = sz + __lux_tmp_123
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
      local x
      do
        local __lux_tmp_124 = toNumber(guessX)
        if __lux_tmp_124 == nil then
          __lux_tmp_124 = sx
        end
        x = __lux_tmp_124
      end
      local y
      do
        local __lux_tmp_125 = toNumber(guessY)
        if __lux_tmp_125 == nil then
          __lux_tmp_125 = sy
        end
        y = __lux_tmp_125
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
        local __lux_cmp_126 = false
        if mathAbs(det) ~= nil and 0.000001 ~= nil then
          __lux_cmp_126 = mathAbs(det) < 0.000001
        end
        if __lux_cmp_126 then
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
          local __lux_tmp_127 = stats.draws
          if __lux_tmp_127 == nil then
            __lux_tmp_127 = 0
          end
          stats.draws = __lux_tmp_127 + 1
        end
        return
      end
      local out = transformPolyScratch
      for index = 1, #verts do
        local src = verts[index]
        local dst
        do
          local __lux_tmp_128 = out[index]
          if __lux_tmp_128 == nil then
            __lux_tmp_128 = {}
          end
          dst = __lux_tmp_128
        end
        out[index] = dst
        do
          local __lux_tmp_129 = src.x
          if __lux_tmp_129 == nil then
            local __lux_tmp_130 = src[1]
            if __lux_tmp_130 == nil then
              __lux_tmp_130 = 0
            end
            __lux_tmp_129 = __lux_tmp_130
          end
          local __lux_tmp_131 = src.y
          if __lux_tmp_131 == nil then
            local __lux_tmp_132 = src[2]
            if __lux_tmp_132 == nil then
              __lux_tmp_132 = 0
            end
            __lux_tmp_131 = __lux_tmp_132
          end
          dst.x, dst.y = transformPoint(__lux_tmp_129, __lux_tmp_131)
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
        local __lux_tmp_133 = stats.draws
        if __lux_tmp_133 == nil then
          __lux_tmp_133 = 0
        end
        stats.draws = __lux_tmp_133 + 1
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
      local __lux_tmp_134 = spec
      if __lux_tmp_134 == nil then
        __lux_tmp_134 = {}
      end
      return copyStyle(__lux_tmp_134)
    end
    projectedQuad = function(spec)
      local out
      do
        local __lux_tmp_135 = spec
        if __lux_tmp_135 == nil then
          __lux_tmp_135 = {}
        end
        out = copyStyle(__lux_tmp_135)
      end
      out.kind = "projectedQuad"
      return out
    end
    pointerTilt = function(x, y, spec)
      local out
      do
        local __lux_tmp_136 = spec
        if __lux_tmp_136 == nil then
          __lux_tmp_136 = {}
        end
        out = copyStyle(__lux_tmp_136)
      end
      out.kind = "pointerTilt"
      out.x = x
      out.y = y
      return out
    end
  end
  do
    materialUVCorrection = function(material)
      local __lux_tmp_137 = material == nil
      if not __lux_tmp_137 then
        __lux_tmp_137 = material.Width == nil
      end
      local __lux_tmp_138 = __lux_tmp_137
      if not __lux_tmp_138 then
        __lux_tmp_138 = material.Height == nil
      end
      if __lux_tmp_138 then
        return nil
      end
      local cached = texturedRectUVCache[material]
      if cached ~= nil then
        return cached.du, cached.dv, cached.denomU, cached.denomV, cached.fullU0, cached.fullV0, cached.fullU1, cached.fullV1
      end
      local mw
      do
        local __lux_tmp_139 = toNumber(material:Width())
        if __lux_tmp_139 == nil then
          __lux_tmp_139 = 0
        end
        mw = __lux_tmp_139
      end
      local mh
      do
        local __lux_tmp_140 = toNumber(material:Height())
        if __lux_tmp_140 == nil then
          __lux_tmp_140 = 0
        end
        mh = __lux_tmp_140
      end
      local __lux_tmp_141 = mw <= 1
      if not __lux_tmp_141 then
        __lux_tmp_141 = mh <= 1
      end
      if __lux_tmp_141 then
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
            local __lux_tmp_142 = stats.draws
            if __lux_tmp_142 == nil then
              __lux_tmp_142 = 0
            end
            stats.draws = __lux_tmp_142 + 1
          end
          traceEnd(trace)
          return
        end
        local surfaceTrace = traceStart("surface.DrawTexturedRectUV")
        surfaceDrawTexturedRectUV(x, y, w, h, u0, v0, u1, v1)
        traceEnd(surfaceTrace)
        do
          local __lux_tmp_143 = stats.draws
          if __lux_tmp_143 == nil then
            __lux_tmp_143 = 0
          end
          stats.draws = __lux_tmp_143 + 1
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
        local __lux_tmp_144 = stats.draws
        if __lux_tmp_144 == nil then
          __lux_tmp_144 = 0
        end
        stats.draws = __lux_tmp_144 + draws
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
        local __lux_tmp_145 = stats.draws
        if __lux_tmp_145 == nil then
          __lux_tmp_145 = 0
        end
        stats.draws = __lux_tmp_145 + 1
      end
    end
    drawCreatedMaterialTexturedRectUV = function(x, y, w, h, u0, v0, u1, v1)
      local du = 0.5 / 32
      local dv = 0.5 / 32
      u0, v0 = (u0 - du) / (1 - 2 * du), (v0 - dv) / (1 - 2 * dv)
      u1, v1 = (u1 - du) / (1 - 2 * du), (v1 - dv) / (1 - 2 * dv)
      if hasTransform() then
        drawTexturedQuadUV(x, y, w, h, u0, v0, u1, v1)
      else
        surfaceDrawTexturedRectUV(x, y, w, h, u0, v0, u1, v1)
        do
          local __lux_tmp_146 = stats.draws
          if __lux_tmp_146 == nil then
            __lux_tmp_146 = 0
          end
          stats.draws = __lux_tmp_146 + 1
        end
      end
    end
    drawTexturedRectUV = function(x, y, w, h, u0, v0, u1, v1)
      if hasTransform() then
        drawTexturedQuadUV(x, y, w, h, u0, v0, u1, v1)
      else
        surfaceDrawTexturedRectUV(x, y, w, h, u0, v0, u1, v1)
        do
          local __lux_tmp_147 = stats.draws
          if __lux_tmp_147 == nil then
            __lux_tmp_147 = 0
          end
          stats.draws = __lux_tmp_147 + 1
        end
      end
    end
    textureSize = function(texture)
      local tw = 1
      local th = 1
      local __lux_tmp_148 = texture ~= nil
      if __lux_tmp_148 then
        __lux_tmp_148 = texture.Width ~= nil
      end
      if __lux_tmp_148 then
        do
          local __lux_tmp_149 = toNumber(texture:Width())
          if __lux_tmp_149 == nil then
            __lux_tmp_149 = tw
          end
          tw = __lux_tmp_149
        end
      end
      local __lux_tmp_150 = texture ~= nil
      if __lux_tmp_150 then
        __lux_tmp_150 = texture.Height ~= nil
      end
      if __lux_tmp_150 then
        do
          local __lux_tmp_151 = toNumber(texture:Height())
          if __lux_tmp_151 == nil then
            __lux_tmp_151 = th
          end
          th = __lux_tmp_151
        end
      end
      return mathMax(1, tw), mathMax(1, th)
    end
  end
  do
    imageTint = function(drawStyle)
      local resolved
      do
        local __lux_tmp_152 = drawStyle
        if __lux_tmp_152 == nil then
          __lux_tmp_152 = {}
        end
        resolved = __lux_tmp_152
      end
      local tint
      do
        local __lux_tmp_153 = resolved.tint
        if __lux_tmp_153 == nil then
          __lux_tmp_153 = resolved.color
        end
        tint = styleUtil.asColor(__lux_tmp_153, color_white)
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
        local __lux_tmp_154 = toNumber(opacity)
        if __lux_tmp_154 == nil then
          __lux_tmp_154 = 255
        end
        opacity = __lux_tmp_154
      end
      if opacity <= 1 then
        alpha = alpha * mathClamp(opacity, 0, 1)
      else
        alpha = alpha * mathClamp(opacity, 0, 255) / 255
      end
      do
        local __lux_tmp_155 = tint.r
        if __lux_tmp_155 == nil then
          __lux_tmp_155 = 255
        end
        imageTintScratch.r = __lux_tmp_155
      end
      do
        local __lux_tmp_156 = tint.g
        if __lux_tmp_156 == nil then
          __lux_tmp_156 = 255
        end
        imageTintScratch.g = __lux_tmp_156
      end
      do
        local __lux_tmp_157 = tint.b
        if __lux_tmp_157 == nil then
          __lux_tmp_157 = 255
        end
        imageTintScratch.b = __lux_tmp_157
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
          local __lux_tmp_158 = toNumber(pct)
          if __lux_tmp_158 == nil then
            __lux_tmp_158 = 0
          end
          return mathMin(w, h) * mathClamp(__lux_tmp_158 / 100, 0, 1)
        end
        local px = stringMatch(lower, "^%s*([%d%.]+)%s*px%s*$")
        if px ~= nil then
          local __lux_tmp_159 = toNumber(px)
          if __lux_tmp_159 == nil then
            __lux_tmp_159 = 0
          end
          return __lux_tmp_159
        end
      end
      local __lux_tmp_160 = toNumber(radius)
      if __lux_tmp_160 == nil then
        __lux_tmp_160 = 0
      end
      return mathMax(0, __lux_tmp_160)
    end
    imageAlign = function(drawStyle)
      local resolved
      do
        local __lux_tmp_161 = drawStyle
        if __lux_tmp_161 == nil then
          __lux_tmp_161 = {}
        end
        resolved = __lux_tmp_161
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
            local __lux_tmp_162 = position.x
            if __lux_tmp_162 == nil then
              __lux_tmp_162 = position[1]
            end
            ax = __lux_tmp_162
          end
        end
        if ay == nil then
          do
            local __lux_tmp_163 = position.y
            if __lux_tmp_163 == nil then
              __lux_tmp_163 = position[2]
            end
            ay = __lux_tmp_163
          end
        end
      end
      local __lux_tmp_164 = toNumber(ax)
      if __lux_tmp_164 == nil then
        __lux_tmp_164 = 0.5
      end
      local __lux_tmp_165 = toNumber(ay)
      if __lux_tmp_165 == nil then
        __lux_tmp_165 = 0.5
      end
      return mathClamp(__lux_tmp_164, 0, 1), mathClamp(__lux_tmp_165, 0, 1)
    end
    imageUV = function(drawStyle, texture)
      local u0 = 0
      local v0 = 0
      local u1 = 1
      local v1 = 1
      local resolved
      do
        local __lux_tmp_166 = drawStyle
        if __lux_tmp_166 == nil then
          __lux_tmp_166 = {}
        end
        resolved = __lux_tmp_166
      end
      local uv = resolved.uv
      if typeOf(uv) == "table" then
        do
          local __lux_tmp_167 = uv.u0
          if __lux_tmp_167 == nil then
            local __lux_tmp_168 = uv.x0
            if __lux_tmp_168 == nil then
              __lux_tmp_168 = uv[1]
            end
            __lux_tmp_167 = __lux_tmp_168
          end
          local __lux_tmp_169 = toNumber(__lux_tmp_167)
          if __lux_tmp_169 == nil then
            __lux_tmp_169 = u0
          end
          u0 = __lux_tmp_169
        end
        do
          local __lux_tmp_170 = uv.v0
          if __lux_tmp_170 == nil then
            local __lux_tmp_171 = uv.y0
            if __lux_tmp_171 == nil then
              __lux_tmp_171 = uv[2]
            end
            __lux_tmp_170 = __lux_tmp_171
          end
          local __lux_tmp_172 = toNumber(__lux_tmp_170)
          if __lux_tmp_172 == nil then
            __lux_tmp_172 = v0
          end
          v0 = __lux_tmp_172
        end
        do
          local __lux_tmp_173 = uv.u1
          if __lux_tmp_173 == nil then
            local __lux_tmp_174 = uv.x1
            if __lux_tmp_174 == nil then
              __lux_tmp_174 = uv[3]
            end
            __lux_tmp_173 = __lux_tmp_174
          end
          local __lux_tmp_175 = toNumber(__lux_tmp_173)
          if __lux_tmp_175 == nil then
            __lux_tmp_175 = u1
          end
          u1 = __lux_tmp_175
        end
        do
          local __lux_tmp_176 = uv.v1
          if __lux_tmp_176 == nil then
            local __lux_tmp_177 = uv.y1
            if __lux_tmp_177 == nil then
              __lux_tmp_177 = uv[4]
            end
            __lux_tmp_176 = __lux_tmp_177
          end
          local __lux_tmp_178 = toNumber(__lux_tmp_176)
          if __lux_tmp_178 == nil then
            __lux_tmp_178 = v1
          end
          v1 = __lux_tmp_178
        end
      else
        local crop = resolved.crop
        if typeOf(crop) == "table" then
          local pixels
          do
            local __lux_tmp_179 = crop.pixels
            if __lux_tmp_179 == nil then
              local __lux_tmp_180 = crop.pixel
              if __lux_tmp_180 == nil then
                local __lux_tmp_181 = resolved.cropPixels
                if __lux_tmp_181 == nil then
                  __lux_tmp_181 = resolved.cropUnit == "px"
                end
                __lux_tmp_180 = __lux_tmp_181
              end
              __lux_tmp_179 = __lux_tmp_180
            end
            pixels = __lux_tmp_179
          end
          local __lux_tmp_182 = crop.x ~= nil
          if not __lux_tmp_182 then
            __lux_tmp_182 = crop.y ~= nil
          end
          local __lux_tmp_183 = __lux_tmp_182
          if not __lux_tmp_183 then
            __lux_tmp_183 = crop.w ~= nil
          end
          local __lux_tmp_184 = __lux_tmp_183
          if not __lux_tmp_184 then
            __lux_tmp_184 = crop.h ~= nil
          end
          if __lux_tmp_184 then
            local x
            do
              local __lux_tmp_185 = toNumber(crop.x)
              if __lux_tmp_185 == nil then
                __lux_tmp_185 = 0
              end
              x = __lux_tmp_185
            end
            local y
            do
              local __lux_tmp_186 = toNumber(crop.y)
              if __lux_tmp_186 == nil then
                __lux_tmp_186 = 0
              end
              y = __lux_tmp_186
            end
            local w
            do
              local __lux_tmp_187 = crop.w
              if __lux_tmp_187 == nil then
                __lux_tmp_187 = crop.width
              end
              local __lux_tmp_188 = toNumber(__lux_tmp_187)
              if __lux_tmp_188 == nil then
                __lux_tmp_188 = 1
              end
              w = __lux_tmp_188
            end
            local h
            do
              local __lux_tmp_189 = crop.h
              if __lux_tmp_189 == nil then
                __lux_tmp_189 = crop.height
              end
              local __lux_tmp_190 = toNumber(__lux_tmp_189)
              if __lux_tmp_190 == nil then
                __lux_tmp_190 = 1
              end
              h = __lux_tmp_190
            end
            if pixels then
              local tw, th = textureSize(texture)
              u0, v0, u1, v1 = x / tw, y / th, (x + w) / tw, (y + h) / th
            else
              u0, v0, u1, v1 = x, y, x + w, y + h
            end
          else
            do
              local __lux_tmp_191 = crop.u0
              if __lux_tmp_191 == nil then
                __lux_tmp_191 = crop[1]
              end
              local __lux_tmp_192 = toNumber(__lux_tmp_191)
              if __lux_tmp_192 == nil then
                __lux_tmp_192 = u0
              end
              u0 = __lux_tmp_192
            end
            do
              local __lux_tmp_193 = crop.v0
              if __lux_tmp_193 == nil then
                __lux_tmp_193 = crop[2]
              end
              local __lux_tmp_194 = toNumber(__lux_tmp_193)
              if __lux_tmp_194 == nil then
                __lux_tmp_194 = v0
              end
              v0 = __lux_tmp_194
            end
            do
              local __lux_tmp_195 = crop.u1
              if __lux_tmp_195 == nil then
                __lux_tmp_195 = crop[3]
              end
              local __lux_tmp_196 = toNumber(__lux_tmp_195)
              if __lux_tmp_196 == nil then
                __lux_tmp_196 = u1
              end
              u1 = __lux_tmp_196
            end
            do
              local __lux_tmp_197 = crop.v1
              if __lux_tmp_197 == nil then
                __lux_tmp_197 = crop[4]
              end
              local __lux_tmp_198 = toNumber(__lux_tmp_197)
              if __lux_tmp_198 == nil then
                __lux_tmp_198 = v1
              end
              v1 = __lux_tmp_198
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
      local resolved
      do
        local __lux_tmp_199 = drawStyle
        if __lux_tmp_199 == nil then
          __lux_tmp_199 = {}
        end
        resolved = __lux_tmp_199
      end
      local fit
      do
        local __lux_tmp_200 = resolved.fit
        if __lux_tmp_200 == nil then
          local __lux_tmp_201 = resolved.objectFit
          if __lux_tmp_201 == nil then
            __lux_tmp_201 = "fill"
          end
          __lux_tmp_200 = __lux_tmp_201
        end
        fit = __lux_tmp_200
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
      local __lux_tmp_202 = toNumber(value)
      if __lux_tmp_202 == nil then
        __lux_tmp_202 = 16
      end
      return mathClamp(__lux_tmp_202 / 16, 0.001, 4)
    end
    bindStats = function(owner)
      do
        local __lux_tmp_203 = owner.stats
        if __lux_tmp_203 == nil then
          __lux_tmp_203 = {}
        end
        owner.stats = __lux_tmp_203
      end
      local targetStats = owner.stats
      for key, value in pairs(stats) do
        if targetStats[key] == nil then
          targetStats[key] = value
        end
      end
      stats = targetStats
      do
        local __lux_tmp_204 = stats.draws
        if __lux_tmp_204 == nil then
          __lux_tmp_204 = 0
        end
        stats.draws = __lux_tmp_204
      end
      do
        local __lux_tmp_205 = stats.blurPasses
        if __lux_tmp_205 == nil then
          __lux_tmp_205 = 0
        end
        stats.blurPasses = __lux_tmp_205
      end
      do
        local __lux_tmp_206 = stats.fallbacks
        if __lux_tmp_206 == nil then
          __lux_tmp_206 = 0
        end
        stats.fallbacks = __lux_tmp_206
      end
      do
        local __lux_tmp_207 = stats.culled
        if __lux_tmp_207 == nil then
          __lux_tmp_207 = 0
        end
        stats.culled = __lux_tmp_207
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
        local __lux_tmp_208 = stats.draws
        if __lux_tmp_208 == nil then
          __lux_tmp_208 = 0
        end
        local __lux_tmp_209 = amount
        if __lux_tmp_209 == nil then
          __lux_tmp_209 = 1
        end
        stats.draws = __lux_tmp_208 + __lux_tmp_209
      end
      return stats.draws
    end
    recordFallbacks = function(amount)
      if amount == nil then
        amount = 1
      end
      do
        local __lux_tmp_210 = stats.fallbacks
        if __lux_tmp_210 == nil then
          __lux_tmp_210 = 0
        end
        local __lux_tmp_211 = amount
        if __lux_tmp_211 == nil then
          __lux_tmp_211 = 1
        end
        stats.fallbacks = __lux_tmp_210 + __lux_tmp_211
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
        local __lux_tmp_212 = owner._internal
        if __lux_tmp_212 == nil then
          __lux_tmp_212 = {}
        end
        owner._internal = __lux_tmp_212
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
