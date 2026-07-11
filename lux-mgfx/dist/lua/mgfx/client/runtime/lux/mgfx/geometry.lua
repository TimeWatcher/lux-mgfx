return function(__lux_import)
  local __lux_exports = {}
  local frame
  local styleUtil
  local frameNumber
  local makeColor
  local matrixCtor
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
  local renderCopyRenderTargetToTexture
  local renderDrawScreenQuad
  local renderGetBlend
  local renderGetColorModulation
  local renderOverrideAlphaWriteEnable
  local renderOverrideBlend
  local renderPopRenderTarget
  local renderPushRenderTarget
  local renderSetBlend
  local renderSetColorModulation
  local renderSetMaterial
  local renderSetScissorRect
  local stats
  local geometryProfiler
  local geometryOwner
  local backdropBlurPreparedFrame
  local backdropBlurPreparedIntensity
  local backdropBlurParamMatrices
  local backdropBlurMatrixProbe
  local backdropBlurMatrixSetUnpacked
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
  local setupBackdropBlurConstants
  local prepareBackdropBlur
  local bindStats
  local resetFrameStats
  local recordDraws
  local recordFallbacks
  local profileSnapshot
  local install
  do
    local frameImport = __lux_import("lux/mgfx/frame#client")
    local styleUtilImport = __lux_import("lux/mgfx/style#client")
    frame = frameImport
    styleUtil = styleUtilImport
    frameNumber = FrameNumber
    makeColor = Color
    matrixCtor = Matrix
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
    renderCopyRenderTargetToTexture = render.CopyRenderTargetToTexture
    renderDrawScreenQuad = render.DrawScreenQuad
    renderGetBlend = render.GetBlend
    renderGetColorModulation = render.GetColorModulation
    renderOverrideAlphaWriteEnable = render.OverrideAlphaWriteEnable
    renderOverrideBlend = render.OverrideBlend
    renderPopRenderTarget = render.PopRenderTarget
    renderPushRenderTarget = render.PushRenderTarget
    renderSetBlend = render.SetBlend
    renderSetColorModulation = render.SetColorModulation
    renderSetMaterial = render.SetMaterial
    renderSetScissorRect = render.SetScissorRect
    stats = { draws = 0, blurPasses = 0, blurCaptures = 0, blurReuses = 0 }
    geometryProfiler = nil
    geometryOwner = nil
    backdropBlurPreparedFrame = -1
    backdropBlurPreparedIntensity = 0
    backdropBlurParamMatrices = {}
    do
      local __lux_tmp_1
      if matrixCtor ~= nil then
        __lux_tmp_1 = matrixCtor()
      else
        __lux_tmp_1 = nil
      end
      backdropBlurMatrixProbe = __lux_tmp_1
    end
    do
      local __lux_obj_backdropBlurMatrixProbe_2 = backdropBlurMatrixProbe
      local __lux_val_SetUnpacked_3 = nil
      if __lux_obj_backdropBlurMatrixProbe_2 ~= nil then
        __lux_val_SetUnpacked_3 = __lux_obj_backdropBlurMatrixProbe_2.SetUnpacked
      end
      backdropBlurMatrixSetUnpacked = __lux_val_SetUnpacked_3
    end
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
        local __lux_tmp_fallbackX_4 = fallbackX
        if __lux_tmp_fallbackX_4 == nil then
          __lux_tmp_fallbackX_4 = 0
        end
        local __lux_tmp_fallbackY_5 = fallbackY
        if __lux_tmp_fallbackY_5 == nil then
          __lux_tmp_fallbackY_5 = 0
        end
        return __lux_tmp_fallbackX_4, __lux_tmp_fallbackY_5
      end
      local __lux_tmp_x_6 = value.x
      if __lux_tmp_x_6 == nil then
        __lux_tmp_x_6 = value[1]
      end
      local __lux_tmp_x_7 = toNumber(__lux_tmp_x_6)
      if __lux_tmp_x_7 == nil then
        __lux_tmp_x_7 = fallbackX
      end
      if __lux_tmp_x_7 == nil then
        __lux_tmp_x_7 = 0
      end
      local __lux_tmp_y_8 = value.y
      if __lux_tmp_y_8 == nil then
        __lux_tmp_y_8 = value[2]
      end
      local __lux_tmp_y_9 = toNumber(__lux_tmp_y_8)
      if __lux_tmp_y_9 == nil then
        __lux_tmp_y_9 = fallbackY
      end
      if __lux_tmp_y_9 == nil then
        __lux_tmp_y_9 = 0
      end
      return __lux_tmp_x_7, __lux_tmp_y_9
    end
    percentString = function(value)
      if typeOf(value) ~= "string" then
        return nil
      end
      local lower = stringLower(value)
      local alias
      local __lux_match_10 = lower
      if __lux_match_10 == "left" or __lux_match_10 == "top" then
        alias = 0
      elseif __lux_match_10 == "center" or __lux_match_10 == "middle" then
        alias = 0.5
      elseif __lux_match_10 == "right" or __lux_match_10 == "bottom" then
        alias = 1
      else
        alias = nil
      end
      if alias ~= nil then
        return alias
      end
      local pct = stringMatch(lower, "^%s*([%-%d%.]+)%s*%%%s*$")
      if pct ~= nil then
        local __lux_tmp_pct_11 = toNumber(pct)
        if __lux_tmp_pct_11 == nil then
          __lux_tmp_pct_11 = 0
        end
        return __lux_tmp_pct_11 / 100
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
      local __lux_tmp_value_12 = toNumber(value)
      if __lux_tmp_value_12 == nil then
        __lux_tmp_value_12 = size * fallback
      end
      return base + __lux_tmp_value_12
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
        local __lux_tmp_x_13 = origin.x
        if __lux_tmp_x_13 == nil then
          __lux_tmp_x_13 = origin[1]
        end
        local __lux_tmp_y_14 = origin.y
        if __lux_tmp_y_14 == nil then
          __lux_tmp_y_14 = origin[2]
        end
        return axisOrigin(__lux_tmp_x_13, x, w, 0.5), axisOrigin(__lux_tmp_y_14, y, h, 0.5)
      end
      return x + w * 0.5, y + h * 0.5
    end
    num = function(value, fallback)
      if fallback == nil then
        fallback = 0
      end
      local __lux_tmp_value_15 = toNumber(value)
      if __lux_tmp_value_15 == nil then
        __lux_tmp_value_15 = fallback
      end
      if __lux_tmp_value_15 == nil then
        __lux_tmp_value_15 = 0
      end
      return __lux_tmp_value_15
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
          local __lux_tmp_16
          if typeOf(scale) == "table" then
            __lux_tmp_16 = scale.x
            if __lux_tmp_16 == nil then
              __lux_tmp_16 = scale[1]
            end
          else
            __lux_tmp_16 = scale
          end
          scaleX = __lux_tmp_16
          if scaleX == nil then
            scaleX = 1
          end
        end
      end
      local scaleY = spec.scaleY
      if scaleY == nil then
        do
          local __lux_tmp_17
          if typeOf(scale) == "table" then
            __lux_tmp_17 = scale.y
            if __lux_tmp_17 == nil then
              __lux_tmp_17 = scale[2]
            end
          else
            __lux_tmp_17 = scale
          end
          scaleY = __lux_tmp_17
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
            local __lux_tmp_18
            if typeOf(translate) == "table" then
              __lux_tmp_18 = translate.x
              if __lux_tmp_18 == nil then
                __lux_tmp_18 = translate[1]
              end
            else
              __lux_tmp_18 = nil
            end
            tx = __lux_tmp_18
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
            local __lux_tmp_19
            if typeOf(translate) == "table" then
              __lux_tmp_19 = translate.y
              if __lux_tmp_19 == nil then
                __lux_tmp_19 = translate[2]
              end
            else
              __lux_tmp_19 = nil
            end
            ty = __lux_tmp_19
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
            local __lux_tmp_20
            if typeOf(translate) == "table" then
              __lux_tmp_20 = translate.z
              if __lux_tmp_20 == nil then
                __lux_tmp_20 = translate[3]
              end
            else
              __lux_tmp_20 = nil
            end
            tz = __lux_tmp_20
            if tz == nil then
              tz = 0
            end
          end
        end
      end
      local skewX = spec.skewX
      if skewX == nil then
        do
          local __lux_tmp_21
          if typeOf(skew) == "table" then
            __lux_tmp_21 = skew.x
            if __lux_tmp_21 == nil then
              __lux_tmp_21 = skew[1]
            end
          else
            __lux_tmp_21 = nil
          end
          skewX = __lux_tmp_21
          if skewX == nil then
            skewX = 0
          end
        end
      end
      local skewY = spec.skewY
      if skewY == nil then
        do
          local __lux_tmp_22
          if typeOf(skew) == "table" then
            __lux_tmp_22 = skew.y
            if __lux_tmp_22 == nil then
              __lux_tmp_22 = skew[2]
            end
          else
            __lux_tmp_22 = nil
          end
          skewY = __lux_tmp_22
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
      local __lux_tmp_perspective_23 = spec.perspective
      if __lux_tmp_perspective_23 == nil then
        __lux_tmp_perspective_23 = spec.depth
      end
      local __lux_tmp_steps_24 = spec.steps
      if __lux_tmp_steps_24 == nil then
        __lux_tmp_steps_24 = spec.subdivisions
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
        perspective = mathMax(0, num(__lux_tmp_perspective_23, 0)),
        steps = mathClamp(mathFloor(num(__lux_tmp_steps_24, 0)), 0, 24),
      }
    end
    projectedCorner = function(spec, name, index)
      local __lux_tmp_name_25 = spec[name]
      if __lux_tmp_name_25 == nil then
        __lux_tmp_name_25 = spec[index]
      end
      return pointXY(__lux_tmp_name_25, 0, 0)
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
      local __lux_tmp_steps_26 = spec.steps
      if __lux_tmp_steps_26 == nil then
        __lux_tmp_steps_26 = spec.subdivisions
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
        steps = mathClamp(mathFloor(num(__lux_tmp_steps_26, 10)), 1, 24),
      }
    end
    compilePointerTilt = function(spec, x, y, w, h)
      if x == nil or y == nil or w == nil or h == nil then
        return nil
      end
      local px
      do
        local __lux_tmp_pointerX_27 = spec.pointerX
        if __lux_tmp_pointerX_27 == nil then
          __lux_tmp_pointerX_27 = spec.x
        end
        if __lux_tmp_pointerX_27 == nil then
          __lux_tmp_pointerX_27 = spec[1]
        end
        px = toNumber(__lux_tmp_pointerX_27)
        if px == nil then
          px = x + w * 0.5
        end
      end
      local py
      do
        local __lux_tmp_pointerY_28 = spec.pointerY
        if __lux_tmp_pointerY_28 == nil then
          __lux_tmp_pointerY_28 = spec.y
        end
        if __lux_tmp_pointerY_28 == nil then
          __lux_tmp_pointerY_28 = spec[2]
        end
        py = toNumber(__lux_tmp_pointerY_28)
        if py == nil then
          py = y + h * 0.5
        end
      end
      local strength = mathClamp(num(spec.strength, 1), 0, 1)
      local nx = mathClamp((px - (x + w * 0.5)) / mathMax(w * 0.5, 0.0001), -1, 1)
      local ny = mathClamp((py - (y + h * 0.5)) / mathMax(h * 0.5, 0.0001), -1, 1)
      local maxX
      do
        local __lux_tmp_maxRotateX_29 = spec.maxRotateX
        if __lux_tmp_maxRotateX_29 == nil then
          __lux_tmp_maxRotateX_29 = spec.maxX
        end
        if __lux_tmp_maxRotateX_29 == nil then
          __lux_tmp_maxRotateX_29 = spec.max
        end
        if __lux_tmp_maxRotateX_29 == nil then
          __lux_tmp_maxRotateX_29 = spec.amount
        end
        maxX = num(__lux_tmp_maxRotateX_29, 6)
      end
      local maxY
      do
        local __lux_tmp_maxRotateY_30 = spec.maxRotateY
        if __lux_tmp_maxRotateY_30 == nil then
          __lux_tmp_maxRotateY_30 = spec.maxY
        end
        if __lux_tmp_maxRotateY_30 == nil then
          __lux_tmp_maxRotateY_30 = spec.max
        end
        if __lux_tmp_maxRotateY_30 == nil then
          __lux_tmp_maxRotateY_30 = spec.amount
        end
        maxY = num(__lux_tmp_maxRotateY_30, 6)
      end
      local __lux_tmp_origin_31 = spec.origin
      if __lux_tmp_origin_31 == nil then
        __lux_tmp_origin_31 = spec.transformOrigin
      end
      if __lux_tmp_origin_31 == nil then
        __lux_tmp_origin_31 = "50% 50%"
      end
      local __lux_tmp_perspective_32 = spec.perspective
      if __lux_tmp_perspective_32 == nil then
        __lux_tmp_perspective_32 = 900
      end
      local __lux_tmp_scale_33 = spec.scale
      if __lux_tmp_scale_33 == nil then
        __lux_tmp_scale_33 = 1 + strength * num(spec.scaleLift, 0)
      end
      local __lux_tmp_steps_34 = spec.steps
      if __lux_tmp_steps_34 == nil then
        __lux_tmp_steps_34 = spec.subdivisions
      end
      if __lux_tmp_steps_34 == nil then
        __lux_tmp_steps_34 = 10
      end
      return compileCssTransform(
        {
          origin = __lux_tmp_origin_31,
          perspective = __lux_tmp_perspective_32,
          rotateX = -ny * maxX * strength,
          rotateY = nx * maxY * strength,
          scale = __lux_tmp_scale_33,
          steps = __lux_tmp_steps_34,
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
      local __lux_match_35 = kind
      if __lux_match_35 == "pointerTilt" then
        route = 1
      elseif __lux_match_35 == "projectedQuad" or __lux_match_35 == "projected" then
        route = 2
      else
        route = nil
      end
      if route == 1 then
        return compilePointerTilt(spec, x, y, w, h)
      end
      if route == 2 then
        local __lux_tmp_x_36 = x
        if __lux_tmp_x_36 == nil then
          __lux_tmp_x_36 = 0
        end
        local __lux_tmp_y_37 = y
        if __lux_tmp_y_37 == nil then
          __lux_tmp_y_37 = 0
        end
        local __lux_tmp_w_38 = w
        if __lux_tmp_w_38 == nil then
          __lux_tmp_w_38 = 1
        end
        local __lux_tmp_h_39 = h
        if __lux_tmp_h_39 == nil then
          __lux_tmp_h_39 = 1
        end
        return compileProjectedQuad(
          spec,
          __lux_tmp_x_36,
          __lux_tmp_y_37,
          __lux_tmp_w_38,
          __lux_tmp_h_39
        )
      end
      if spec.tl ~= nil or isPoint(spec[1]) and isPoint(spec[2]) and isPoint(spec[3]) and isPoint(spec[4]) then
        local __lux_tmp_x_40 = x
        if __lux_tmp_x_40 == nil then
          __lux_tmp_x_40 = 0
        end
        local __lux_tmp_y_41 = y
        if __lux_tmp_y_41 == nil then
          __lux_tmp_y_41 = 0
        end
        local __lux_tmp_w_42 = w
        if __lux_tmp_w_42 == nil then
          __lux_tmp_w_42 = 1
        end
        local __lux_tmp_h_43 = h
        if __lux_tmp_h_43 == nil then
          __lux_tmp_h_43 = 1
        end
        return compileProjectedQuad(
          spec,
          __lux_tmp_x_40,
          __lux_tmp_y_41,
          __lux_tmp_w_42,
          __lux_tmp_h_43
        )
      end
      local __lux_tmp_x_44 = x
      if __lux_tmp_x_44 == nil then
        __lux_tmp_x_44 = 0
      end
      local __lux_tmp_y_45 = y
      if __lux_tmp_y_45 == nil then
        __lux_tmp_y_45 = 0
      end
      local __lux_tmp_w_46 = w
      if __lux_tmp_w_46 == nil then
        __lux_tmp_w_46 = 0
      end
      local __lux_tmp_h_47 = h
      if __lux_tmp_h_47 == nil then
        __lux_tmp_h_47 = 0
      end
      return compileCssTransform(
        spec,
        __lux_tmp_x_44,
        __lux_tmp_y_45,
        __lux_tmp_w_46,
        __lux_tmp_h_47
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
        local __lux_tmp_50 = t.kind == "projected" or t.perspective > 0
        if not __lux_tmp_50 then
          local __lux_cmp_49 = false
          if mathAbs(t.rotateX) ~= nil then
            __lux_cmp_49 = mathAbs(t.rotateX) > 0.0001
          end
          __lux_tmp_50 = __lux_cmp_49
        end
        local __lux_tmp_52 = __lux_tmp_50
        if not __lux_tmp_52 then
          local __lux_cmp_51 = false
          if mathAbs(t.rotateY) ~= nil then
            __lux_cmp_51 = mathAbs(t.rotateY) > 0.0001
          end
          __lux_tmp_52 = __lux_cmp_51
        end
        local __lux_tmp_53 = __lux_tmp_52
        if not __lux_tmp_53 then
          __lux_tmp_53 = t.steps > 1
        end
        if __lux_tmp_53 then
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
          local __lux_tmp_56 = t.kind == "projected" or t.perspective > 0
          if not __lux_tmp_56 then
            local __lux_cmp_55 = false
            if mathAbs(t.rotateX) ~= nil then
              __lux_cmp_55 = mathAbs(t.rotateX) > 0.0001
            end
            __lux_tmp_56 = __lux_cmp_55
          end
          local __lux_tmp_58 = __lux_tmp_56
          if not __lux_tmp_58 then
            local __lux_cmp_57 = false
            if mathAbs(t.rotateY) ~= nil then
              __lux_cmp_57 = mathAbs(t.rotateY) > 0.0001
            end
            __lux_tmp_58 = __lux_cmp_57
          end
          if __lux_tmp_58 then
            do
              local __lux_tmp_59
              if t.steps > 0 then
                __lux_tmp_59 = t.steps
              else
                __lux_tmp_59 = 10
              end
              steps = mathMax(steps, __lux_tmp_59)
            end
          else
            do
              local __lux_tmp_60
              if t.steps > 0 then
                __lux_tmp_60 = t.steps
              else
                __lux_tmp_60 = 1
              end
              steps = mathMax(steps, __lux_tmp_60)
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
      local __lux_cmp_61 = false
      if mathAbs(t.rotateX) ~= nil then
        __lux_cmp_61 = mathAbs(t.rotateX) > 0.0001
      end
      if __lux_cmp_61 then
        local c = mathCos(t.rotateX)
        local s = mathSin(t.rotateX)
        sy, sz = sy * c - sz * s, sy * s + sz * c
      end
      local __lux_cmp_62 = false
      if mathAbs(t.rotateY) ~= nil then
        __lux_cmp_62 = mathAbs(t.rotateY) > 0.0001
      end
      if __lux_cmp_62 then
        local c = mathCos(t.rotateY)
        local s = mathSin(t.rotateY)
        sx, sz = sx * c + sz * s, -sx * s + sz * c
      end
      local __lux_cmp_63 = false
      if mathAbs(t.rotate) ~= nil then
        __lux_cmp_63 = mathAbs(t.rotate) > 0.0001
      end
      if __lux_cmp_63 then
        local c = mathCos(t.rotate)
        local s = mathSin(t.rotate)
        sx, sy = sx * c - sy * s, sx * s + sy * c
      end
      do
        local __lux_tmp_translateZ_64 = t.translateZ
        if __lux_tmp_translateZ_64 == nil then
          __lux_tmp_translateZ_64 = 0
        end
        sz = sz + __lux_tmp_translateZ_64
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
        local __lux_cmp_65 = false
        if mathAbs(det) ~= nil then
          __lux_cmp_65 = mathAbs(det) < 0.000001
        end
        if __lux_cmp_65 then
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
          local __lux_tmp_draws_66 = stats.draws
          if __lux_tmp_draws_66 == nil then
            __lux_tmp_draws_66 = 0
          end
          stats.draws = __lux_tmp_draws_66 + 1
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
          local __lux_tmp_x_67 = src.x
          if __lux_tmp_x_67 == nil then
            __lux_tmp_x_67 = src[1]
          end
          if __lux_tmp_x_67 == nil then
            __lux_tmp_x_67 = 0
          end
          local __lux_tmp_y_68 = src.y
          if __lux_tmp_y_68 == nil then
            __lux_tmp_y_68 = src[2]
          end
          if __lux_tmp_y_68 == nil then
            __lux_tmp_y_68 = 0
          end
          dst.x, dst.y = transformPoint(__lux_tmp_x_67, __lux_tmp_y_68)
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
        local __lux_tmp_draws_69 = stats.draws
        if __lux_tmp_draws_69 == nil then
          __lux_tmp_draws_69 = 0
        end
        stats.draws = __lux_tmp_draws_69 + 1
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
      local __lux_tmp_spec_70 = spec
      if __lux_tmp_spec_70 == nil then
        __lux_tmp_spec_70 = {}
      end
      return copyStyle(__lux_tmp_spec_70)
    end
    projectedQuad = function(spec)
      local out
      do
        local __lux_tmp_spec_71 = spec
        if __lux_tmp_spec_71 == nil then
          __lux_tmp_spec_71 = {}
        end
        out = copyStyle(__lux_tmp_spec_71)
      end
      out.kind = "projectedQuad"
      return out
    end
    pointerTilt = function(x, y, spec)
      local out
      do
        local __lux_tmp_spec_72 = spec
        if __lux_tmp_spec_72 == nil then
          __lux_tmp_spec_72 = {}
        end
        out = copyStyle(__lux_tmp_spec_72)
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
            local __lux_tmp_draws_73 = stats.draws
            if __lux_tmp_draws_73 == nil then
              __lux_tmp_draws_73 = 0
            end
            stats.draws = __lux_tmp_draws_73 + 1
          end
          traceEnd(trace)
          return
        end
        local surfaceTrace = traceStart("surface.DrawTexturedRectUV")
        surfaceDrawTexturedRectUV(x, y, w, h, u0, v0, u1, v1)
        traceEnd(surfaceTrace)
        do
          local __lux_tmp_draws_74 = stats.draws
          if __lux_tmp_draws_74 == nil then
            __lux_tmp_draws_74 = 0
          end
          stats.draws = __lux_tmp_draws_74 + 1
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
        local __lux_tmp_draws_75 = stats.draws
        if __lux_tmp_draws_75 == nil then
          __lux_tmp_draws_75 = 0
        end
        stats.draws = __lux_tmp_draws_75 + draws
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
        local __lux_tmp_draws_76 = stats.draws
        if __lux_tmp_draws_76 == nil then
          __lux_tmp_draws_76 = 0
        end
        stats.draws = __lux_tmp_draws_76 + 1
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
          local __lux_tmp_draws_77 = stats.draws
          if __lux_tmp_draws_77 == nil then
            __lux_tmp_draws_77 = 0
          end
          stats.draws = __lux_tmp_draws_77 + 1
        end
      end
    end
    drawTexturedRectUV = function(x, y, w, h, u0, v0, u1, v1)
      if hasTransform() then
        return drawTexturedQuadUV(x, y, w, h, u0, v0, u1, v1)
      else
        surfaceDrawTexturedRectUV(x, y, w, h, u0, v0, u1, v1)
        do
          local __lux_tmp_draws_78 = stats.draws
          if __lux_tmp_draws_78 == nil then
            __lux_tmp_draws_78 = 0
          end
          stats.draws = __lux_tmp_draws_78 + 1
        end
      end
    end
    textureSize = function(texture)
      local tw = 1
      local th = 1
      if texture ~= nil and texture.Width ~= nil then
        do
          local __lux_tmp_Width_79 = toNumber(texture:Width())
          if __lux_tmp_Width_79 == nil then
            __lux_tmp_Width_79 = tw
          end
          tw = __lux_tmp_Width_79
        end
      end
      if texture ~= nil and texture.Height ~= nil then
        do
          local __lux_tmp_Height_80 = toNumber(texture:Height())
          if __lux_tmp_Height_80 == nil then
            __lux_tmp_Height_80 = th
          end
          th = __lux_tmp_Height_80
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
        local __lux_tmp_tint_81 = resolved.tint
        if __lux_tmp_tint_81 == nil then
          __lux_tmp_tint_81 = resolved.color
        end
        tint = styleUtil.asColor(__lux_tmp_tint_81, color_white)
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
        local __lux_tmp_opacity_82 = toNumber(opacity)
        if __lux_tmp_opacity_82 == nil then
          __lux_tmp_opacity_82 = 255
        end
        opacity = __lux_tmp_opacity_82
      end
      if opacity <= 1 then
        alpha = alpha * mathClamp(opacity, 0, 1)
      else
        alpha = alpha * mathClamp(opacity, 0, 255) / 255
      end
      do
        local __lux_tmp_r_83 = tint.r
        if __lux_tmp_r_83 == nil then
          __lux_tmp_r_83 = 255
        end
        imageTintScratch.r = __lux_tmp_r_83
      end
      do
        local __lux_tmp_g_84 = tint.g
        if __lux_tmp_g_84 == nil then
          __lux_tmp_g_84 = 255
        end
        imageTintScratch.g = __lux_tmp_g_84
      end
      do
        local __lux_tmp_b_85 = tint.b
        if __lux_tmp_b_85 == nil then
          __lux_tmp_b_85 = 255
        end
        imageTintScratch.b = __lux_tmp_b_85
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
          local __lux_tmp_pct_86 = toNumber(pct)
          if __lux_tmp_pct_86 == nil then
            __lux_tmp_pct_86 = 0
          end
          return mathMin(w, h) * mathClamp(__lux_tmp_pct_86 / 100, 0, 1)
        end
        local px = stringMatch(lower, "^%s*([%d%.]+)%s*px%s*$")
        if px ~= nil then
          local __lux_tmp_px_87 = toNumber(px)
          if __lux_tmp_px_87 == nil then
            __lux_tmp_px_87 = 0
          end
          return __lux_tmp_px_87
        end
      end
      local __lux_tmp_radius_88 = toNumber(radius)
      if __lux_tmp_radius_88 == nil then
        __lux_tmp_radius_88 = 0
      end
      return mathMax(0, __lux_tmp_radius_88)
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
            local __lux_tmp_x_89 = position.x
            if __lux_tmp_x_89 == nil then
              __lux_tmp_x_89 = position[1]
            end
            ax = __lux_tmp_x_89
          end
        end
        if ay == nil then
          do
            local __lux_tmp_y_90 = position.y
            if __lux_tmp_y_90 == nil then
              __lux_tmp_y_90 = position[2]
            end
            ay = __lux_tmp_y_90
          end
        end
      end
      local __lux_tmp_ax_91 = toNumber(ax)
      if __lux_tmp_ax_91 == nil then
        __lux_tmp_ax_91 = 0.5
      end
      local __lux_tmp_ay_92 = toNumber(ay)
      if __lux_tmp_ay_92 == nil then
        __lux_tmp_ay_92 = 0.5
      end
      return mathClamp(__lux_tmp_ax_91, 0, 1), mathClamp(__lux_tmp_ay_92, 0, 1)
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
          local __lux_tmp_u0_93 = uv.u0
          if __lux_tmp_u0_93 == nil then
            __lux_tmp_u0_93 = uv.x0
          end
          if __lux_tmp_u0_93 == nil then
            __lux_tmp_u0_93 = uv[1]
          end
          local __lux_tmp_u0_94 = toNumber(__lux_tmp_u0_93)
          if __lux_tmp_u0_94 == nil then
            __lux_tmp_u0_94 = u0
          end
          u0 = __lux_tmp_u0_94
        end
        do
          local __lux_tmp_v0_95 = uv.v0
          if __lux_tmp_v0_95 == nil then
            __lux_tmp_v0_95 = uv.y0
          end
          if __lux_tmp_v0_95 == nil then
            __lux_tmp_v0_95 = uv[2]
          end
          local __lux_tmp_v0_96 = toNumber(__lux_tmp_v0_95)
          if __lux_tmp_v0_96 == nil then
            __lux_tmp_v0_96 = v0
          end
          v0 = __lux_tmp_v0_96
        end
        do
          local __lux_tmp_u1_97 = uv.u1
          if __lux_tmp_u1_97 == nil then
            __lux_tmp_u1_97 = uv.x1
          end
          if __lux_tmp_u1_97 == nil then
            __lux_tmp_u1_97 = uv[3]
          end
          local __lux_tmp_u1_98 = toNumber(__lux_tmp_u1_97)
          if __lux_tmp_u1_98 == nil then
            __lux_tmp_u1_98 = u1
          end
          u1 = __lux_tmp_u1_98
        end
        do
          local __lux_tmp_v1_99 = uv.v1
          if __lux_tmp_v1_99 == nil then
            __lux_tmp_v1_99 = uv.y1
          end
          if __lux_tmp_v1_99 == nil then
            __lux_tmp_v1_99 = uv[4]
          end
          local __lux_tmp_v1_100 = toNumber(__lux_tmp_v1_99)
          if __lux_tmp_v1_100 == nil then
            __lux_tmp_v1_100 = v1
          end
          v1 = __lux_tmp_v1_100
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
              local __lux_tmp_w_101 = crop.w
              if __lux_tmp_w_101 == nil then
                __lux_tmp_w_101 = crop.width
              end
              w = toNumber(__lux_tmp_w_101)
              if w == nil then
                w = 1
              end
            end
            local h
            do
              local __lux_tmp_h_102 = crop.h
              if __lux_tmp_h_102 == nil then
                __lux_tmp_h_102 = crop.height
              end
              h = toNumber(__lux_tmp_h_102)
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
              local __lux_tmp_u0_103 = crop.u0
              if __lux_tmp_u0_103 == nil then
                __lux_tmp_u0_103 = crop[1]
              end
              local __lux_tmp_u0_104 = toNumber(__lux_tmp_u0_103)
              if __lux_tmp_u0_104 == nil then
                __lux_tmp_u0_104 = u0
              end
              u0 = __lux_tmp_u0_104
            end
            do
              local __lux_tmp_v0_105 = crop.v0
              if __lux_tmp_v0_105 == nil then
                __lux_tmp_v0_105 = crop[2]
              end
              local __lux_tmp_v0_106 = toNumber(__lux_tmp_v0_105)
              if __lux_tmp_v0_106 == nil then
                __lux_tmp_v0_106 = v0
              end
              v0 = __lux_tmp_v0_106
            end
            do
              local __lux_tmp_u1_107 = crop.u1
              if __lux_tmp_u1_107 == nil then
                __lux_tmp_u1_107 = crop[3]
              end
              local __lux_tmp_u1_108 = toNumber(__lux_tmp_u1_107)
              if __lux_tmp_u1_108 == nil then
                __lux_tmp_u1_108 = u1
              end
              u1 = __lux_tmp_u1_108
            end
            do
              local __lux_tmp_v1_109 = crop.v1
              if __lux_tmp_v1_109 == nil then
                __lux_tmp_v1_109 = crop[4]
              end
              local __lux_tmp_v1_110 = toNumber(__lux_tmp_v1_109)
              if __lux_tmp_v1_110 == nil then
                __lux_tmp_v1_110 = v1
              end
              v1 = __lux_tmp_v1_110
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
      local __lux_tmp_value_111 = toNumber(value)
      if __lux_tmp_value_111 == nil then
        __lux_tmp_value_111 = 16
      end
      return mathClamp(__lux_tmp_value_111 / 16, 0.001, 4)
    end
    setupBackdropBlurConstants = function(material, w, h, vertical, intensity)
      local matrix = backdropBlurParamMatrices[material]
      if matrix == nil then
        matrix = matrixCtor()
        backdropBlurParamMatrices[material] = matrix
      end
      do
        local __lux_tmp_112
        if vertical then
          __lux_tmp_112 = 1
        else
          __lux_tmp_112 = 0
        end
        backdropBlurMatrixSetUnpacked(
          matrix,
          __lux_tmp_112,
          w,
          0,
          0,
          intensity,
          h,
          0,
          0,
          0,
          0,
          1,
          0,
          0,
          0,
          0,
          0
        )
      end
      return material:SetMatrix("$viewprojmat", matrix)
    end
    prepareBackdropBlur = function(amount, recapture)
      if recapture == nil then
        recapture = false
      end
      local currentFrame = frameNumber()
      if not recapture and backdropBlurPreparedFrame == currentFrame then
        do
          local __lux_tmp_blurReuses_113 = stats.blurReuses
          if __lux_tmp_blurReuses_113 == nil then
            __lux_tmp_blurReuses_113 = 0
          end
          stats.blurReuses = __lux_tmp_blurReuses_113 + 1
        end
        return backdropBlurPreparedIntensity
      end
      local materialState
      do
        local __lux_obj_geometryOwner_114 = geometryOwner
        local __lux_val_MaterialState_115 = nil
        if __lux_obj_geometryOwner_114 ~= nil then
          __lux_val_MaterialState_115 = __lux_obj_geometryOwner_114._MaterialState
        end
        materialState = __lux_val_MaterialState_115
      end
      if materialState == nil then
        errorFn("MGFX material state unavailable for backdrop blur", 2)
      end
      local materials = materialState.materials
      local sourceRT = materialState.blurRT
      local horizontalRT = materialState.backdropBlurHorizontalRT
      local finalRT = materialState.backdropBlurRT
      local horizontalMaterial = materials.backdrop_blur_horizontal
      local verticalMaterial = materials.backdrop_blur_vertical
      local width = ScrW()
      local height = ScrH()
      local intensity = blurIntensity(amount)
      local previousR, previousG, previousB = renderGetColorModulation()
      local previousBlend = renderGetBlend()
      renderCopyRenderTargetToTexture(sourceRT)
      renderPushRenderTarget(horizontalRT)
      renderSetScissorRect(0, 0, 0, 0, false)
      renderSetColorModulation(1, 1, 1)
      renderSetBlend(1)
      renderOverrideAlphaWriteEnable(true, true)
      renderOverrideBlend(
        true,
        BLEND_ONE,
        BLEND_ZERO,
        BLENDFUNC_ADD,
        BLEND_ONE,
        BLEND_ZERO,
        BLENDFUNC_ADD
      )
      setupBackdropBlurConstants(horizontalMaterial, width, height, false, intensity)
      renderSetMaterial(horizontalMaterial)
      renderDrawScreenQuad()
      do
        local __lux_tmp_draws_116 = stats.draws
        if __lux_tmp_draws_116 == nil then
          __lux_tmp_draws_116 = 0
        end
        stats.draws = __lux_tmp_draws_116 + 1
      end
      renderPopRenderTarget()
      renderPushRenderTarget(finalRT)
      setupBackdropBlurConstants(verticalMaterial, width, height, true, intensity)
      renderSetMaterial(verticalMaterial)
      renderDrawScreenQuad()
      do
        local __lux_tmp_draws_117 = stats.draws
        if __lux_tmp_draws_117 == nil then
          __lux_tmp_draws_117 = 0
        end
        stats.draws = __lux_tmp_draws_117 + 1
      end
      renderOverrideBlend(false)
      renderOverrideAlphaWriteEnable(false)
      renderSetColorModulation(previousR, previousG, previousB)
      renderSetBlend(previousBlend)
      renderPopRenderTarget()
      frame.restoreScissor()
      backdropBlurPreparedFrame = currentFrame
      backdropBlurPreparedIntensity = intensity
      do
        local __lux_tmp_blurCaptures_118 = stats.blurCaptures
        if __lux_tmp_blurCaptures_118 == nil then
          __lux_tmp_blurCaptures_118 = 0
        end
        stats.blurCaptures = __lux_tmp_blurCaptures_118 + 1
      end
      do
        local __lux_tmp_blurPasses_119 = stats.blurPasses
        if __lux_tmp_blurPasses_119 == nil then
          __lux_tmp_blurPasses_119 = 0
        end
        stats.blurPasses = __lux_tmp_blurPasses_119 + 2
      end
      return intensity
    end
    bindStats = function(owner)
      do
        local __lux_tmp_stats_120 = owner.stats
        if __lux_tmp_stats_120 == nil then
          __lux_tmp_stats_120 = {}
        end
        owner.stats = __lux_tmp_stats_120
      end
      local targetStats = owner.stats
      for key, value in pairs(stats) do
        if targetStats[key] == nil then
          targetStats[key] = value
        end
      end
      stats = targetStats
      do
        local __lux_tmp_draws_121 = stats.draws
        if __lux_tmp_draws_121 == nil then
          __lux_tmp_draws_121 = 0
        end
        stats.draws = __lux_tmp_draws_121
      end
      do
        local __lux_tmp_blurPasses_122 = stats.blurPasses
        if __lux_tmp_blurPasses_122 == nil then
          __lux_tmp_blurPasses_122 = 0
        end
        stats.blurPasses = __lux_tmp_blurPasses_122
      end
      do
        local __lux_tmp_blurCaptures_123 = stats.blurCaptures
        if __lux_tmp_blurCaptures_123 == nil then
          __lux_tmp_blurCaptures_123 = 0
        end
        stats.blurCaptures = __lux_tmp_blurCaptures_123
      end
      do
        local __lux_tmp_blurReuses_124 = stats.blurReuses
        if __lux_tmp_blurReuses_124 == nil then
          __lux_tmp_blurReuses_124 = 0
        end
        stats.blurReuses = __lux_tmp_blurReuses_124
      end
      do
        local __lux_tmp_fallbacks_125 = stats.fallbacks
        if __lux_tmp_fallbacks_125 == nil then
          __lux_tmp_fallbacks_125 = 0
        end
        stats.fallbacks = __lux_tmp_fallbacks_125
      end
      do
        local __lux_tmp_culled_126 = stats.culled
        if __lux_tmp_culled_126 == nil then
          __lux_tmp_culled_126 = 0
        end
        stats.culled = __lux_tmp_culled_126
      end
      return stats
    end
    resetFrameStats = function()
      stats.draws = 0
      stats.blurPasses = 0
      stats.blurCaptures = 0
      stats.blurReuses = 0
      stats.fallbacks = 0
      stats.culled = 0
      return stats
    end
    recordDraws = function(amount)
      if amount == nil then
        amount = 1
      end
      do
        local __lux_tmp_draws_127 = stats.draws
        if __lux_tmp_draws_127 == nil then
          __lux_tmp_draws_127 = 0
        end
        local __lux_tmp_amount_128 = amount
        if __lux_tmp_amount_128 == nil then
          __lux_tmp_amount_128 = 1
        end
        stats.draws = __lux_tmp_draws_127 + __lux_tmp_amount_128
      end
      return stats.draws
    end
    recordFallbacks = function(amount)
      if amount == nil then
        amount = 1
      end
      do
        local __lux_tmp_fallbacks_129 = stats.fallbacks
        if __lux_tmp_fallbacks_129 == nil then
          __lux_tmp_fallbacks_129 = 0
        end
        local __lux_tmp_amount_130 = amount
        if __lux_tmp_amount_130 == nil then
          __lux_tmp_amount_130 = 1
        end
        stats.fallbacks = __lux_tmp_fallbacks_129 + __lux_tmp_amount_130
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
      geometryOwner = owner
      backdropBlurPreparedFrame = -1
      backdropBlurPreparedIntensity = 0
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
        local __lux_tmp_internal_131 = owner._internal
        if __lux_tmp_internal_131 == nil then
          __lux_tmp_internal_131 = {}
        end
        owner._internal = __lux_tmp_internal_131
      end
      owner._Geometry = {
        blurIntensity = blurIntensity,
        prepareBackdropBlur = prepareBackdropBlur,
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
  __lux_exports.prepareBackdropBlur = prepareBackdropBlur
  __lux_exports.resetFrameStats = resetFrameStats
  __lux_exports.recordDraws = recordDraws
  __lux_exports.recordFallbacks = recordFallbacks
  __lux_exports.profileSnapshot = profileSnapshot
  __lux_exports.install = install

  return __lux_exports
end
