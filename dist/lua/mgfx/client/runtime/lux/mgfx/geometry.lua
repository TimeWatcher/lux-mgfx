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
  local quadVerts
  local transformStack
  local transformPolyScratch
  local transformQuadVerts
  local imageTintScratch
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
    quadVerts = {
      { x = 0, y = 0, u = 0, v = 0 },
      { x = 0, y = 0, u = 1, v = 0 },
      { x = 0, y = 0, u = 1, v = 1 },
      { x = 0, y = 0, u = 0, v = 1 },
    }
    transformStack = {}
    transformPolyScratch = { {}, {}, {}, {}, {}, {}, {}, {} }
    transformQuadVerts = { {}, {}, {}, {} }
    imageTintScratch = makeColor(255, 255, 255, 255)
    copyStyle = function(value)
      if typeOf(value) == "table" then
        return tableCopy(value)
      end
      return {}
    end
    isPoint = function(value)
      local __lux_tmp_2 = typeOf(value) == "table"
      if __lux_tmp_2 then
        local __lux_tmp_3 = value.x ~= nil
        if not __lux_tmp_3 then
          __lux_tmp_3 = value[1] ~= nil
        end
        __lux_tmp_2 = __lux_tmp_3
      end
      local __lux_tmp_4 = __lux_tmp_2
      if __lux_tmp_4 then
        local __lux_tmp_5 = value.y ~= nil
        if not __lux_tmp_5 then
          __lux_tmp_5 = value[2] ~= nil
        end
        __lux_tmp_4 = __lux_tmp_5
      end
      return __lux_tmp_4
    end
    pointXY = function(value, fallbackX, fallbackY)
      if fallbackX == nil then
        fallbackX = 0
      end
      if fallbackY == nil then
        fallbackY = 0
      end
      if typeOf(value) ~= "table" then
        local __lux_tmp_6 = fallbackX
        if __lux_tmp_6 == nil then
          __lux_tmp_6 = 0
        end
        local __lux_tmp_7 = fallbackY
        if __lux_tmp_7 == nil then
          __lux_tmp_7 = 0
        end
        return __lux_tmp_6, __lux_tmp_7
      end
      local __lux_tmp_8 = value.x
      if __lux_tmp_8 == nil then
        __lux_tmp_8 = value[1]
      end
      local __lux_tmp_9 = toNumber(__lux_tmp_8)
      if __lux_tmp_9 == nil then
        local __lux_tmp_10 = fallbackX
        if __lux_tmp_10 == nil then
          __lux_tmp_10 = 0
        end
        __lux_tmp_9 = __lux_tmp_10
      end
      local __lux_tmp_11 = value.y
      if __lux_tmp_11 == nil then
        __lux_tmp_11 = value[2]
      end
      local __lux_tmp_12 = toNumber(__lux_tmp_11)
      if __lux_tmp_12 == nil then
        local __lux_tmp_13 = fallbackY
        if __lux_tmp_13 == nil then
          __lux_tmp_13 = 0
        end
        __lux_tmp_12 = __lux_tmp_13
      end
      return __lux_tmp_9, __lux_tmp_12
    end
    percentString = function(value)
      if typeOf(value) ~= "string" then
        return nil
      end
      local lower = stringLower(value)
      local alias
      local __lux_match_14 = lower
      if __lux_match_14 == "left" or __lux_match_14 == "top" then
        alias = 0
      elseif __lux_match_14 == "center" or __lux_match_14 == "middle" then
        alias = 0.5
      elseif __lux_match_14 == "right" or __lux_match_14 == "bottom" then
        alias = 1
      else
        alias = nil
      end
      if alias ~= nil then
        return alias
      end
      local pct = stringMatch(lower, "^%s*([%-%d%.]+)%s*%%%s*$")
      if pct ~= nil then
        local __lux_tmp_15 = toNumber(pct)
        if __lux_tmp_15 == nil then
          __lux_tmp_15 = 0
        end
        return __lux_tmp_15 / 100
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
      local __lux_tmp_16 = toNumber(value)
      if __lux_tmp_16 == nil then
        __lux_tmp_16 = size * fallback
      end
      return base + __lux_tmp_16
    end
    transformOrigin = function(spec, x, y, w, h)
      local origin
      do
        local __lux_tmp_17 = spec.origin
        if __lux_tmp_17 == nil then
          local __lux_tmp_18 = spec.transformOrigin
          if __lux_tmp_18 == nil then
            __lux_tmp_18 = spec.anchor
          end
          __lux_tmp_17 = __lux_tmp_18
        end
        origin = __lux_tmp_17
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
        local __lux_tmp_19 = origin.x
        if __lux_tmp_19 == nil then
          __lux_tmp_19 = origin[1]
        end
        local __lux_tmp_20 = origin.y
        if __lux_tmp_20 == nil then
          __lux_tmp_20 = origin[2]
        end
        return axisOrigin(__lux_tmp_19, x, w, 0.5), axisOrigin(__lux_tmp_20, y, h, 0.5)
      end
      return x + w * 0.5, y + h * 0.5
    end
    num = function(value, fallback)
      if fallback == nil then
        fallback = 0
      end
      local __lux_tmp_21 = toNumber(value)
      if __lux_tmp_21 == nil then
        local __lux_tmp_22 = fallback
        if __lux_tmp_22 == nil then
          __lux_tmp_22 = 0
        end
        __lux_tmp_21 = __lux_tmp_22
      end
      return __lux_tmp_21
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
        local __lux_tmp_23 = spec.scaleX
        if __lux_tmp_23 == nil then
          local __lux_tmp_24
          if typeOf(scale) == "table" then
            do
              local __lux_tmp_25 = scale.x
              if __lux_tmp_25 == nil then
                __lux_tmp_25 = scale[1]
              end
              __lux_tmp_24 = __lux_tmp_25
            end
          else
            __lux_tmp_24 = scale
          end
          local __lux_tmp_26 = __lux_tmp_24
          if __lux_tmp_26 == nil then
            __lux_tmp_26 = 1
          end
          __lux_tmp_23 = __lux_tmp_26
        end
        scaleX = __lux_tmp_23
      end
      local scaleY
      do
        local __lux_tmp_27 = spec.scaleY
        if __lux_tmp_27 == nil then
          local __lux_tmp_28
          if typeOf(scale) == "table" then
            do
              local __lux_tmp_29 = scale.y
              if __lux_tmp_29 == nil then
                __lux_tmp_29 = scale[2]
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
        scaleY = __lux_tmp_27
      end
      local tx
      do
        local __lux_tmp_31 = spec.x
        if __lux_tmp_31 == nil then
          local __lux_tmp_32 = spec.translateX
          if __lux_tmp_32 == nil then
            local __lux_tmp_33
            if typeOf(translate) == "table" then
              do
                local __lux_tmp_34 = translate.x
                if __lux_tmp_34 == nil then
                  __lux_tmp_34 = translate[1]
                end
                __lux_tmp_33 = __lux_tmp_34
              end
            else
              __lux_tmp_33 = nil
            end
            local __lux_tmp_35 = __lux_tmp_33
            if __lux_tmp_35 == nil then
              __lux_tmp_35 = 0
            end
            __lux_tmp_32 = __lux_tmp_35
          end
          __lux_tmp_31 = __lux_tmp_32
        end
        tx = __lux_tmp_31
      end
      local ty
      do
        local __lux_tmp_36 = spec.y
        if __lux_tmp_36 == nil then
          local __lux_tmp_37 = spec.translateY
          if __lux_tmp_37 == nil then
            local __lux_tmp_38
            if typeOf(translate) == "table" then
              do
                local __lux_tmp_39 = translate.y
                if __lux_tmp_39 == nil then
                  __lux_tmp_39 = translate[2]
                end
                __lux_tmp_38 = __lux_tmp_39
              end
            else
              __lux_tmp_38 = nil
            end
            local __lux_tmp_40 = __lux_tmp_38
            if __lux_tmp_40 == nil then
              __lux_tmp_40 = 0
            end
            __lux_tmp_37 = __lux_tmp_40
          end
          __lux_tmp_36 = __lux_tmp_37
        end
        ty = __lux_tmp_36
      end
      local tz
      do
        local __lux_tmp_41 = spec.z
        if __lux_tmp_41 == nil then
          local __lux_tmp_42 = spec.translateZ
          if __lux_tmp_42 == nil then
            local __lux_tmp_43
            if typeOf(translate) == "table" then
              do
                local __lux_tmp_44 = translate.z
                if __lux_tmp_44 == nil then
                  __lux_tmp_44 = translate[3]
                end
                __lux_tmp_43 = __lux_tmp_44
              end
            else
              __lux_tmp_43 = nil
            end
            local __lux_tmp_45 = __lux_tmp_43
            if __lux_tmp_45 == nil then
              __lux_tmp_45 = 0
            end
            __lux_tmp_42 = __lux_tmp_45
          end
          __lux_tmp_41 = __lux_tmp_42
        end
        tz = __lux_tmp_41
      end
      local skewX
      do
        local __lux_tmp_46 = spec.skewX
        if __lux_tmp_46 == nil then
          local __lux_tmp_47
          if typeOf(skew) == "table" then
            do
              local __lux_tmp_48 = skew.x
              if __lux_tmp_48 == nil then
                __lux_tmp_48 = skew[1]
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
        skewX = __lux_tmp_46
      end
      local skewY
      do
        local __lux_tmp_50 = spec.skewY
        if __lux_tmp_50 == nil then
          local __lux_tmp_51
          if typeOf(skew) == "table" then
            do
              local __lux_tmp_52 = skew.y
              if __lux_tmp_52 == nil then
                __lux_tmp_52 = skew[2]
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
        skewY = __lux_tmp_50
      end
      local rotate
      do
        local __lux_tmp_54 = spec.rotate
        if __lux_tmp_54 == nil then
          local __lux_tmp_55 = spec.rotateZ
          if __lux_tmp_55 == nil then
            __lux_tmp_55 = 0
          end
          __lux_tmp_54 = __lux_tmp_55
        end
        rotate = __lux_tmp_54
      end
      local rotateX
      do
        local __lux_tmp_56 = spec.rotateX
        if __lux_tmp_56 == nil then
          local __lux_tmp_57 = spec.pitch
          if __lux_tmp_57 == nil then
            __lux_tmp_57 = 0
          end
          __lux_tmp_56 = __lux_tmp_57
        end
        rotateX = __lux_tmp_56
      end
      local rotateY
      do
        local __lux_tmp_58 = spec.rotateY
        if __lux_tmp_58 == nil then
          local __lux_tmp_59 = spec.yaw
          if __lux_tmp_59 == nil then
            __lux_tmp_59 = 0
          end
          __lux_tmp_58 = __lux_tmp_59
        end
        rotateY = __lux_tmp_58
      end
      local __lux_tmp_60 = spec.perspective
      if __lux_tmp_60 == nil then
        __lux_tmp_60 = spec.depth
      end
      local __lux_tmp_61 = spec.steps
      if __lux_tmp_61 == nil then
        __lux_tmp_61 = spec.subdivisions
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
        perspective = mathMax(0, num(__lux_tmp_60, 0)),
        steps = mathClamp(mathFloor(num(__lux_tmp_61, 0)), 0, 24),
      }
    end
    projectedCorner = function(spec, name, index)
      local __lux_tmp_62 = spec[name]
      if __lux_tmp_62 == nil then
        __lux_tmp_62 = spec[index]
      end
      return pointXY(__lux_tmp_62, 0, 0)
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
      local __lux_tmp_63 = spec.steps
      if __lux_tmp_63 == nil then
        __lux_tmp_63 = spec.subdivisions
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
        steps = mathClamp(mathFloor(num(__lux_tmp_63, 10)), 1, 24),
      }
    end
    compilePointerTilt = function(spec, x, y, w, h)
      local __lux_tmp_64 = x == nil
      if not __lux_tmp_64 then
        __lux_tmp_64 = y == nil
      end
      local __lux_tmp_65 = __lux_tmp_64
      if not __lux_tmp_65 then
        __lux_tmp_65 = w == nil
      end
      local __lux_tmp_66 = __lux_tmp_65
      if not __lux_tmp_66 then
        __lux_tmp_66 = h == nil
      end
      if __lux_tmp_66 then
        return nil
      end
      local px
      do
        local __lux_tmp_67 = spec.pointerX
        if __lux_tmp_67 == nil then
          local __lux_tmp_68 = spec.x
          if __lux_tmp_68 == nil then
            __lux_tmp_68 = spec[1]
          end
          __lux_tmp_67 = __lux_tmp_68
        end
        local __lux_tmp_69 = toNumber(__lux_tmp_67)
        if __lux_tmp_69 == nil then
          __lux_tmp_69 = x + w * 0.5
        end
        px = __lux_tmp_69
      end
      local py
      do
        local __lux_tmp_70 = spec.pointerY
        if __lux_tmp_70 == nil then
          local __lux_tmp_71 = spec.y
          if __lux_tmp_71 == nil then
            __lux_tmp_71 = spec[2]
          end
          __lux_tmp_70 = __lux_tmp_71
        end
        local __lux_tmp_72 = toNumber(__lux_tmp_70)
        if __lux_tmp_72 == nil then
          __lux_tmp_72 = y + h * 0.5
        end
        py = __lux_tmp_72
      end
      local strength = mathClamp(num(spec.strength, 1), 0, 1)
      local nx = mathClamp((px - (x + w * 0.5)) / mathMax(w * 0.5, 0.0001), -1, 1)
      local ny = mathClamp((py - (y + h * 0.5)) / mathMax(h * 0.5, 0.0001), -1, 1)
      local maxX
      do
        local __lux_tmp_73 = spec.maxRotateX
        if __lux_tmp_73 == nil then
          local __lux_tmp_74 = spec.maxX
          if __lux_tmp_74 == nil then
            local __lux_tmp_75 = spec.max
            if __lux_tmp_75 == nil then
              __lux_tmp_75 = spec.amount
            end
            __lux_tmp_74 = __lux_tmp_75
          end
          __lux_tmp_73 = __lux_tmp_74
        end
        maxX = num(__lux_tmp_73, 6)
      end
      local maxY
      do
        local __lux_tmp_76 = spec.maxRotateY
        if __lux_tmp_76 == nil then
          local __lux_tmp_77 = spec.maxY
          if __lux_tmp_77 == nil then
            local __lux_tmp_78 = spec.max
            if __lux_tmp_78 == nil then
              __lux_tmp_78 = spec.amount
            end
            __lux_tmp_77 = __lux_tmp_78
          end
          __lux_tmp_76 = __lux_tmp_77
        end
        maxY = num(__lux_tmp_76, 6)
      end
      local __lux_tmp_79 = spec.origin
      if __lux_tmp_79 == nil then
        local __lux_tmp_80 = spec.transformOrigin
        if __lux_tmp_80 == nil then
          __lux_tmp_80 = "50% 50%"
        end
        __lux_tmp_79 = __lux_tmp_80
      end
      local __lux_tmp_81 = spec.perspective
      if __lux_tmp_81 == nil then
        __lux_tmp_81 = 900
      end
      local __lux_tmp_82 = spec.scale
      if __lux_tmp_82 == nil then
        __lux_tmp_82 = 1 + strength * num(spec.scaleLift, 0)
      end
      local __lux_tmp_83 = spec.steps
      if __lux_tmp_83 == nil then
        local __lux_tmp_84 = spec.subdivisions
        if __lux_tmp_84 == nil then
          __lux_tmp_84 = 10
        end
        __lux_tmp_83 = __lux_tmp_84
      end
      return compileCssTransform(
        {
          origin = __lux_tmp_79,
          perspective = __lux_tmp_81,
          rotateX = -ny * maxX * strength,
          rotateY = nx * maxY * strength,
          scale = __lux_tmp_82,
          steps = __lux_tmp_83,
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
        local __lux_tmp_85 = spec.kind
        if __lux_tmp_85 == nil then
          __lux_tmp_85 = spec.type
        end
        kind = __lux_tmp_85
      end
      local route
      local __lux_match_86 = kind
      if __lux_match_86 == "pointerTilt" then
        route = 1
      elseif __lux_match_86 == "projectedQuad" or __lux_match_86 == "projected" then
        route = 2
      else
        route = nil
      end
      if route == 1 then
        return compilePointerTilt(spec, x, y, w, h)
      end
      if route == 2 then
        local __lux_tmp_87 = x
        if __lux_tmp_87 == nil then
          __lux_tmp_87 = 0
        end
        local __lux_tmp_88 = y
        if __lux_tmp_88 == nil then
          __lux_tmp_88 = 0
        end
        local __lux_tmp_89 = w
        if __lux_tmp_89 == nil then
          __lux_tmp_89 = 1
        end
        local __lux_tmp_90 = h
        if __lux_tmp_90 == nil then
          __lux_tmp_90 = 1
        end
        return compileProjectedQuad(spec, __lux_tmp_87, __lux_tmp_88, __lux_tmp_89, __lux_tmp_90)
      end
      local __lux_tmp_91 = spec.tl ~= nil
      if not __lux_tmp_91 then
        local __lux_tmp_92 = isPoint(spec[1])
        if __lux_tmp_92 then
          __lux_tmp_92 = isPoint(spec[2])
        end
        local __lux_tmp_93 = __lux_tmp_92
        if __lux_tmp_93 then
          __lux_tmp_93 = isPoint(spec[3])
        end
        local __lux_tmp_94 = __lux_tmp_93
        if __lux_tmp_94 then
          __lux_tmp_94 = isPoint(spec[4])
        end
        __lux_tmp_91 = __lux_tmp_94
      end
      if __lux_tmp_91 then
        local __lux_tmp_95 = x
        if __lux_tmp_95 == nil then
          __lux_tmp_95 = 0
        end
        local __lux_tmp_96 = y
        if __lux_tmp_96 == nil then
          __lux_tmp_96 = 0
        end
        local __lux_tmp_97 = w
        if __lux_tmp_97 == nil then
          __lux_tmp_97 = 1
        end
        local __lux_tmp_98 = h
        if __lux_tmp_98 == nil then
          __lux_tmp_98 = 1
        end
        return compileProjectedQuad(spec, __lux_tmp_95, __lux_tmp_96, __lux_tmp_97, __lux_tmp_98)
      end
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
        __lux_tmp_101 = 0
      end
      local __lux_tmp_102 = h
      if __lux_tmp_102 == nil then
        __lux_tmp_102 = 0
      end
      return compileCssTransform(spec, __lux_tmp_99, __lux_tmp_100, __lux_tmp_101, __lux_tmp_102)
    end
  end
  do
    hasTransform = function()
      return #transformStack > 0
    end
    transformNeedsGrid = function()
      for index = 1, #transformStack do
        local t = transformStack[index]
        local __lux_tmp_103 = t.kind == "projected"
        if not __lux_tmp_103 then
          __lux_tmp_103 = t.perspective > 0
        end
        local __lux_tmp_104 = __lux_tmp_103
        if not __lux_tmp_104 then
          local __lux_cmp_105 = false
          if mathAbs(t.rotateX) ~= nil and 0.0001 ~= nil then
            __lux_cmp_105 = mathAbs(t.rotateX) > 0.0001
          end
          __lux_tmp_104 = __lux_cmp_105
        end
        local __lux_tmp_106 = __lux_tmp_104
        if not __lux_tmp_106 then
          local __lux_cmp_107 = false
          if mathAbs(t.rotateY) ~= nil and 0.0001 ~= nil then
            __lux_cmp_107 = mathAbs(t.rotateY) > 0.0001
          end
          __lux_tmp_106 = __lux_cmp_107
        end
        local __lux_tmp_108 = __lux_tmp_106
        if not __lux_tmp_108 then
          __lux_tmp_108 = t.steps > 1
        end
        if __lux_tmp_108 then
          return true
        end
      end
      return false
    end
    transformSteps = function()
      local steps = 1
      for index = 1, #transformStack do
        local t = transformStack[index]
        local __lux_tmp_109 = t.kind == "projected"
        if not __lux_tmp_109 then
          __lux_tmp_109 = t.perspective > 0
        end
        local __lux_tmp_110 = __lux_tmp_109
        if not __lux_tmp_110 then
          local __lux_cmp_111 = false
          if mathAbs(t.rotateX) ~= nil and 0.0001 ~= nil then
            __lux_cmp_111 = mathAbs(t.rotateX) > 0.0001
          end
          __lux_tmp_110 = __lux_cmp_111
        end
        local __lux_tmp_112 = __lux_tmp_110
        if not __lux_tmp_112 then
          local __lux_cmp_113 = false
          if mathAbs(t.rotateY) ~= nil and 0.0001 ~= nil then
            __lux_cmp_113 = mathAbs(t.rotateY) > 0.0001
          end
          __lux_tmp_112 = __lux_cmp_113
        end
        if __lux_tmp_112 then
          do
            local __lux_tmp_114
            if t.steps > 0 then
              __lux_tmp_114 = t.steps
            else
              __lux_tmp_114 = 10
            end
            steps = mathMax(steps, __lux_tmp_114)
          end
        else
          do
            local __lux_tmp_115
            if t.steps > 0 then
              __lux_tmp_115 = t.steps
            else
              __lux_tmp_115 = 1
            end
            steps = mathMax(steps, __lux_tmp_115)
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
      local __lux_cmp_116 = false
      if mathAbs(t.rotateX) ~= nil and 0.0001 ~= nil then
        __lux_cmp_116 = mathAbs(t.rotateX) > 0.0001
      end
      if __lux_cmp_116 then
        local c = mathCos(t.rotateX)
        local s = mathSin(t.rotateX)
        sy, sz = sy * c - sz * s, sy * s + sz * c
      end
      local __lux_cmp_117 = false
      if mathAbs(t.rotateY) ~= nil and 0.0001 ~= nil then
        __lux_cmp_117 = mathAbs(t.rotateY) > 0.0001
      end
      if __lux_cmp_117 then
        local c = mathCos(t.rotateY)
        local s = mathSin(t.rotateY)
        sx, sz = sx * c + sz * s, -sx * s + sz * c
      end
      local __lux_cmp_118 = false
      if mathAbs(t.rotate) ~= nil and 0.0001 ~= nil then
        __lux_cmp_118 = mathAbs(t.rotate) > 0.0001
      end
      if __lux_cmp_118 then
        local c = mathCos(t.rotate)
        local s = mathSin(t.rotate)
        sx, sy = sx * c - sy * s, sx * s + sy * c
      end
      do
        local __lux_tmp_119 = t.translateZ
        if __lux_tmp_119 == nil then
          __lux_tmp_119 = 0
        end
        sz = sz + __lux_tmp_119
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
        local __lux_tmp_120 = toNumber(guessX)
        if __lux_tmp_120 == nil then
          __lux_tmp_120 = sx
        end
        x = __lux_tmp_120
      end
      local y
      do
        local __lux_tmp_121 = toNumber(guessY)
        if __lux_tmp_121 == nil then
          __lux_tmp_121 = sy
        end
        y = __lux_tmp_121
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
        local __lux_cmp_122 = false
        if mathAbs(det) ~= nil and 0.000001 ~= nil then
          __lux_cmp_122 = mathAbs(det) < 0.000001
        end
        if __lux_cmp_122 then
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
          local __lux_tmp_123 = stats.draws
          if __lux_tmp_123 == nil then
            __lux_tmp_123 = 0
          end
          stats.draws = __lux_tmp_123 + 1
        end
        return
      end
      local out = transformPolyScratch
      for index = 1, #verts do
        local src = verts[index]
        local dst
        do
          local __lux_tmp_124 = out[index]
          if __lux_tmp_124 == nil then
            __lux_tmp_124 = {}
          end
          dst = __lux_tmp_124
        end
        out[index] = dst
        do
          local __lux_tmp_125 = src.x
          if __lux_tmp_125 == nil then
            local __lux_tmp_126 = src[1]
            if __lux_tmp_126 == nil then
              __lux_tmp_126 = 0
            end
            __lux_tmp_125 = __lux_tmp_126
          end
          local __lux_tmp_127 = src.y
          if __lux_tmp_127 == nil then
            local __lux_tmp_128 = src[2]
            if __lux_tmp_128 == nil then
              __lux_tmp_128 = 0
            end
            __lux_tmp_127 = __lux_tmp_128
          end
          dst.x, dst.y = transformPoint(__lux_tmp_125, __lux_tmp_127)
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
        local __lux_tmp_129 = stats.draws
        if __lux_tmp_129 == nil then
          __lux_tmp_129 = 0
        end
        stats.draws = __lux_tmp_129 + 1
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
      local __lux_tmp_130 = spec
      if __lux_tmp_130 == nil then
        __lux_tmp_130 = {}
      end
      return copyStyle(__lux_tmp_130)
    end
    projectedQuad = function(spec)
      local out
      do
        local __lux_tmp_131 = spec
        if __lux_tmp_131 == nil then
          __lux_tmp_131 = {}
        end
        out = copyStyle(__lux_tmp_131)
      end
      out.kind = "projectedQuad"
      return out
    end
    pointerTilt = function(x, y, spec)
      local out
      do
        local __lux_tmp_132 = spec
        if __lux_tmp_132 == nil then
          __lux_tmp_132 = {}
        end
        out = copyStyle(__lux_tmp_132)
      end
      out.kind = "pointerTilt"
      out.x = x
      out.y = y
      return out
    end
  end
  do
    drawTexturedQuadUV = function(x, y, w, h, u0, v0, u1, v1)
      if not hasTransform() then
        local verts = quadVerts
        verts[1].x = x
        verts[1].y = y
        verts[1].u = u0
        verts[1].v = v0
        verts[2].x = x + w
        verts[2].y = y
        verts[2].u = u1
        verts[2].v = v0
        verts[3].x = x + w
        verts[3].y = y + h
        verts[3].u = u1
        verts[3].v = v1
        verts[4].x = x
        verts[4].y = y + h
        verts[4].u = u0
        verts[4].v = v1
        surfaceDrawPoly(verts)
        do
          local __lux_tmp_133 = stats.draws
          if __lux_tmp_133 == nil then
            __lux_tmp_133 = 0
          end
          stats.draws = __lux_tmp_133 + 1
        end
        return
      end
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
      do
        local __lux_tmp_134 = stats.draws
        if __lux_tmp_134 == nil then
          __lux_tmp_134 = 0
        end
        stats.draws = __lux_tmp_134 + draws
      end
    end
    drawTexturedQuad = function(x, y, w, h)
      return drawTexturedQuadUV(x, y, w, h, 0, 0, 1, 1)
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
          local __lux_tmp_135 = stats.draws
          if __lux_tmp_135 == nil then
            __lux_tmp_135 = 0
          end
          stats.draws = __lux_tmp_135 + 1
        end
      end
    end
    drawTexturedRectUV = function(x, y, w, h, u0, v0, u1, v1)
      if hasTransform() then
        drawTexturedQuadUV(x, y, w, h, u0, v0, u1, v1)
      else
        surfaceDrawTexturedRectUV(x, y, w, h, u0, v0, u1, v1)
        do
          local __lux_tmp_136 = stats.draws
          if __lux_tmp_136 == nil then
            __lux_tmp_136 = 0
          end
          stats.draws = __lux_tmp_136 + 1
        end
      end
    end
    textureSize = function(texture)
      local tw = 1
      local th = 1
      local __lux_tmp_137 = texture ~= nil
      if __lux_tmp_137 then
        __lux_tmp_137 = texture.Width ~= nil
      end
      if __lux_tmp_137 then
        do
          local __lux_tmp_138 = toNumber(texture:Width())
          if __lux_tmp_138 == nil then
            __lux_tmp_138 = tw
          end
          tw = __lux_tmp_138
        end
      end
      local __lux_tmp_139 = texture ~= nil
      if __lux_tmp_139 then
        __lux_tmp_139 = texture.Height ~= nil
      end
      if __lux_tmp_139 then
        do
          local __lux_tmp_140 = toNumber(texture:Height())
          if __lux_tmp_140 == nil then
            __lux_tmp_140 = th
          end
          th = __lux_tmp_140
        end
      end
      return mathMax(1, tw), mathMax(1, th)
    end
  end
  do
    imageTint = function(drawStyle)
      local resolved
      do
        local __lux_tmp_141 = drawStyle
        if __lux_tmp_141 == nil then
          __lux_tmp_141 = {}
        end
        resolved = __lux_tmp_141
      end
      local tint
      do
        local __lux_tmp_142 = resolved.tint
        if __lux_tmp_142 == nil then
          __lux_tmp_142 = resolved.color
        end
        tint = styleUtil.asColor(__lux_tmp_142, color_white)
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
        local __lux_tmp_143 = toNumber(opacity)
        if __lux_tmp_143 == nil then
          __lux_tmp_143 = 255
        end
        opacity = __lux_tmp_143
      end
      if opacity <= 1 then
        alpha = alpha * mathClamp(opacity, 0, 1)
      else
        alpha = alpha * mathClamp(opacity, 0, 255) / 255
      end
      do
        local __lux_tmp_144 = tint.r
        if __lux_tmp_144 == nil then
          __lux_tmp_144 = 255
        end
        imageTintScratch.r = __lux_tmp_144
      end
      do
        local __lux_tmp_145 = tint.g
        if __lux_tmp_145 == nil then
          __lux_tmp_145 = 255
        end
        imageTintScratch.g = __lux_tmp_145
      end
      do
        local __lux_tmp_146 = tint.b
        if __lux_tmp_146 == nil then
          __lux_tmp_146 = 255
        end
        imageTintScratch.b = __lux_tmp_146
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
          local __lux_tmp_147 = toNumber(pct)
          if __lux_tmp_147 == nil then
            __lux_tmp_147 = 0
          end
          return mathMin(w, h) * mathClamp(__lux_tmp_147 / 100, 0, 1)
        end
        local px = stringMatch(lower, "^%s*([%d%.]+)%s*px%s*$")
        if px ~= nil then
          local __lux_tmp_148 = toNumber(px)
          if __lux_tmp_148 == nil then
            __lux_tmp_148 = 0
          end
          return __lux_tmp_148
        end
      end
      local __lux_tmp_149 = toNumber(radius)
      if __lux_tmp_149 == nil then
        __lux_tmp_149 = 0
      end
      return mathMax(0, __lux_tmp_149)
    end
    imageAlign = function(drawStyle)
      local resolved
      do
        local __lux_tmp_150 = drawStyle
        if __lux_tmp_150 == nil then
          __lux_tmp_150 = {}
        end
        resolved = __lux_tmp_150
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
            local __lux_tmp_151 = position.x
            if __lux_tmp_151 == nil then
              __lux_tmp_151 = position[1]
            end
            ax = __lux_tmp_151
          end
        end
        if ay == nil then
          do
            local __lux_tmp_152 = position.y
            if __lux_tmp_152 == nil then
              __lux_tmp_152 = position[2]
            end
            ay = __lux_tmp_152
          end
        end
      end
      local __lux_tmp_153 = toNumber(ax)
      if __lux_tmp_153 == nil then
        __lux_tmp_153 = 0.5
      end
      local __lux_tmp_154 = toNumber(ay)
      if __lux_tmp_154 == nil then
        __lux_tmp_154 = 0.5
      end
      return mathClamp(__lux_tmp_153, 0, 1), mathClamp(__lux_tmp_154, 0, 1)
    end
    imageUV = function(drawStyle, texture)
      local u0 = 0
      local v0 = 0
      local u1 = 1
      local v1 = 1
      local resolved
      do
        local __lux_tmp_155 = drawStyle
        if __lux_tmp_155 == nil then
          __lux_tmp_155 = {}
        end
        resolved = __lux_tmp_155
      end
      local uv = resolved.uv
      if typeOf(uv) == "table" then
        do
          local __lux_tmp_156 = uv.u0
          if __lux_tmp_156 == nil then
            local __lux_tmp_157 = uv.x0
            if __lux_tmp_157 == nil then
              __lux_tmp_157 = uv[1]
            end
            __lux_tmp_156 = __lux_tmp_157
          end
          local __lux_tmp_158 = toNumber(__lux_tmp_156)
          if __lux_tmp_158 == nil then
            __lux_tmp_158 = u0
          end
          u0 = __lux_tmp_158
        end
        do
          local __lux_tmp_159 = uv.v0
          if __lux_tmp_159 == nil then
            local __lux_tmp_160 = uv.y0
            if __lux_tmp_160 == nil then
              __lux_tmp_160 = uv[2]
            end
            __lux_tmp_159 = __lux_tmp_160
          end
          local __lux_tmp_161 = toNumber(__lux_tmp_159)
          if __lux_tmp_161 == nil then
            __lux_tmp_161 = v0
          end
          v0 = __lux_tmp_161
        end
        do
          local __lux_tmp_162 = uv.u1
          if __lux_tmp_162 == nil then
            local __lux_tmp_163 = uv.x1
            if __lux_tmp_163 == nil then
              __lux_tmp_163 = uv[3]
            end
            __lux_tmp_162 = __lux_tmp_163
          end
          local __lux_tmp_164 = toNumber(__lux_tmp_162)
          if __lux_tmp_164 == nil then
            __lux_tmp_164 = u1
          end
          u1 = __lux_tmp_164
        end
        do
          local __lux_tmp_165 = uv.v1
          if __lux_tmp_165 == nil then
            local __lux_tmp_166 = uv.y1
            if __lux_tmp_166 == nil then
              __lux_tmp_166 = uv[4]
            end
            __lux_tmp_165 = __lux_tmp_166
          end
          local __lux_tmp_167 = toNumber(__lux_tmp_165)
          if __lux_tmp_167 == nil then
            __lux_tmp_167 = v1
          end
          v1 = __lux_tmp_167
        end
      else
        local crop = resolved.crop
        if typeOf(crop) == "table" then
          local pixels
          do
            local __lux_tmp_168 = crop.pixels
            if __lux_tmp_168 == nil then
              local __lux_tmp_169 = crop.pixel
              if __lux_tmp_169 == nil then
                local __lux_tmp_170 = resolved.cropPixels
                if __lux_tmp_170 == nil then
                  __lux_tmp_170 = resolved.cropUnit == "px"
                end
                __lux_tmp_169 = __lux_tmp_170
              end
              __lux_tmp_168 = __lux_tmp_169
            end
            pixels = __lux_tmp_168
          end
          local __lux_tmp_171 = crop.x ~= nil
          if not __lux_tmp_171 then
            __lux_tmp_171 = crop.y ~= nil
          end
          local __lux_tmp_172 = __lux_tmp_171
          if not __lux_tmp_172 then
            __lux_tmp_172 = crop.w ~= nil
          end
          local __lux_tmp_173 = __lux_tmp_172
          if not __lux_tmp_173 then
            __lux_tmp_173 = crop.h ~= nil
          end
          if __lux_tmp_173 then
            local x
            do
              local __lux_tmp_174 = toNumber(crop.x)
              if __lux_tmp_174 == nil then
                __lux_tmp_174 = 0
              end
              x = __lux_tmp_174
            end
            local y
            do
              local __lux_tmp_175 = toNumber(crop.y)
              if __lux_tmp_175 == nil then
                __lux_tmp_175 = 0
              end
              y = __lux_tmp_175
            end
            local w
            do
              local __lux_tmp_176 = crop.w
              if __lux_tmp_176 == nil then
                __lux_tmp_176 = crop.width
              end
              local __lux_tmp_177 = toNumber(__lux_tmp_176)
              if __lux_tmp_177 == nil then
                __lux_tmp_177 = 1
              end
              w = __lux_tmp_177
            end
            local h
            do
              local __lux_tmp_178 = crop.h
              if __lux_tmp_178 == nil then
                __lux_tmp_178 = crop.height
              end
              local __lux_tmp_179 = toNumber(__lux_tmp_178)
              if __lux_tmp_179 == nil then
                __lux_tmp_179 = 1
              end
              h = __lux_tmp_179
            end
            if pixels then
              local tw, th = textureSize(texture)
              u0, v0, u1, v1 = x / tw, y / th, (x + w) / tw, (y + h) / th
            else
              u0, v0, u1, v1 = x, y, x + w, y + h
            end
          else
            do
              local __lux_tmp_180 = crop.u0
              if __lux_tmp_180 == nil then
                __lux_tmp_180 = crop[1]
              end
              local __lux_tmp_181 = toNumber(__lux_tmp_180)
              if __lux_tmp_181 == nil then
                __lux_tmp_181 = u0
              end
              u0 = __lux_tmp_181
            end
            do
              local __lux_tmp_182 = crop.v0
              if __lux_tmp_182 == nil then
                __lux_tmp_182 = crop[2]
              end
              local __lux_tmp_183 = toNumber(__lux_tmp_182)
              if __lux_tmp_183 == nil then
                __lux_tmp_183 = v0
              end
              v0 = __lux_tmp_183
            end
            do
              local __lux_tmp_184 = crop.u1
              if __lux_tmp_184 == nil then
                __lux_tmp_184 = crop[3]
              end
              local __lux_tmp_185 = toNumber(__lux_tmp_184)
              if __lux_tmp_185 == nil then
                __lux_tmp_185 = u1
              end
              u1 = __lux_tmp_185
            end
            do
              local __lux_tmp_186 = crop.v1
              if __lux_tmp_186 == nil then
                __lux_tmp_186 = crop[4]
              end
              local __lux_tmp_187 = toNumber(__lux_tmp_186)
              if __lux_tmp_187 == nil then
                __lux_tmp_187 = v1
              end
              v1 = __lux_tmp_187
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
        local __lux_tmp_188 = drawStyle
        if __lux_tmp_188 == nil then
          __lux_tmp_188 = {}
        end
        resolved = __lux_tmp_188
      end
      local fit
      do
        local __lux_tmp_189 = resolved.fit
        if __lux_tmp_189 == nil then
          local __lux_tmp_190 = resolved.objectFit
          if __lux_tmp_190 == nil then
            __lux_tmp_190 = "fill"
          end
          __lux_tmp_189 = __lux_tmp_190
        end
        fit = __lux_tmp_189
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
      local __lux_tmp_191 = toNumber(value)
      if __lux_tmp_191 == nil then
        __lux_tmp_191 = 16
      end
      return mathClamp(__lux_tmp_191 / 16, 0.25, 4)
    end
    bindStats = function(owner)
      do
        local __lux_tmp_192 = owner.stats
        if __lux_tmp_192 == nil then
          __lux_tmp_192 = {}
        end
        owner.stats = __lux_tmp_192
      end
      local targetStats = owner.stats
      for key, value in pairs(stats) do
        if targetStats[key] == nil then
          targetStats[key] = value
        end
      end
      stats = targetStats
      do
        local __lux_tmp_193 = stats.draws
        if __lux_tmp_193 == nil then
          __lux_tmp_193 = 0
        end
        stats.draws = __lux_tmp_193
      end
      do
        local __lux_tmp_194 = stats.blurPasses
        if __lux_tmp_194 == nil then
          __lux_tmp_194 = 0
        end
        stats.blurPasses = __lux_tmp_194
      end
      do
        local __lux_tmp_195 = stats.fallbacks
        if __lux_tmp_195 == nil then
          __lux_tmp_195 = 0
        end
        stats.fallbacks = __lux_tmp_195
      end
      do
        local __lux_tmp_196 = stats.culled
        if __lux_tmp_196 == nil then
          __lux_tmp_196 = 0
        end
        stats.culled = __lux_tmp_196
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
        local __lux_tmp_197 = stats.draws
        if __lux_tmp_197 == nil then
          __lux_tmp_197 = 0
        end
        local __lux_tmp_198 = amount
        if __lux_tmp_198 == nil then
          __lux_tmp_198 = 1
        end
        stats.draws = __lux_tmp_197 + __lux_tmp_198
      end
      return stats.draws
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
      owner._Geometry = {
        blurIntensity = blurIntensity,
        resetFrameStats = resetFrameStats,
        recordDraws = recordDraws,
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
  __lux_exports.profileSnapshot = profileSnapshot
  __lux_exports.install = install
  
  return __lux_exports
end
