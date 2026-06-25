return function(__lux_import)
  local __lux_exports = {}
  local frame
  local geometry
  local paint
  local primitives
  local roundrect
  local style
  local text
  local getConVar
  local matrixCtor
  local makeColor
  local mathClamp
  local mathCos
  local mathFloor
  local mathAbs
  local mathMax
  local mathMin
  local mathRad
  local mathSin
  local renderCopyRenderTargetToTexture
  local surfaceSetDrawColor
  local surfaceSetMaterial
  local toNumber
  local typeOf
  local drawTexturedQuad
  local blurIntensity
  local hasTransform
  local beginPanelEffectBleed
  local endPanelEffectBleed
  local withPanelEffectBleed
  local paramMatrixProbe
  local paramMatrixSetUnpacked
  local paramMatrices
  local auxParamMatrices
  local widgetMaterials
  local widgetBlurRT
  local widgetMatOK
  local widgetHasShaders
  local forceFallbackCvar
  local progressStyle
  local segmentStyle
  local ringStyle
  local arcStyle
  local sectorStyle
  local imageStyleScratch
  local iconStyleScratch
  local progressTrackStyle
  local progressTickStyle
  local progressGlowStyle
  local progressFillStyle
  local progressSheenStyle
  local progressMarkerStyle
  local segmentContainerStyle
  local segmentItemStyle
  local progressTrackDarkColor
  local progressTickColor
  local progressGlowColor
  local progressMarkerColor
  local progressTrackGradient
  local progressSheenGradient
  local imageRoundEffectStyle
  local imageChamferEffectStyle
  local sourceAlphaMaskScratch
  local defaultProgressTrack
  local defaultProgressStroke
  local defaultSegmentFill
  local defaultSegmentTrack
  local defaultRingFill
  local transparentColor
  local configureWidgets
  local materialOK
  local shadersActive
  local setupParamMatrix
  local setupAuxConstants
  local copyInto
  local colorAt
  local fxFlags
  local effectBleedFromDrawRect
  local progressFxBits
  local progressFillCanFast
  local canDrawProgressFast
  local setupProgressConstants
  local setupProgressFxConstants
  local drawProgressFast
  local setGradientColors
  local segmentFillEndpoints
  local drawSegmentBarShader
  local progressBarEx
  local progressBar
  local segmentBarEx
  local segmentBar
  local arcSegmentCount
  local ringModeValue
  local ringShapeConstants
  local ringFillParams
  local ringFillNeedsLut
  local ringLineStyle
  local drawRingFallback
  local drawRingFillPass
  local drawRingStrokePass
  local drawRingFxPass
  local drawRingInnerGlowPass
  local ringEffectBounds
  local drawRingShadowOuterPass
  local ringBackdropTintColor
  local setupRingBackdropConstants
  local drawRingBackdropPass
  local drawRingPatternPass
  local drawRingBox
  local ringEx
  local ring
  local arcEx
  local arc
  local sectorEx
  local sector
  local imageMakeMaterial
  local imageCreateMaterial
  local imageSysTime
  local imageSourceSerial
  local imageMaterialCache
  local imageTextureFallbackMaterial
  local imageWhiteTexture
  local imageTextureSource
  local imageWhiteTextureSource
  local imageFallbackMaterialForTexture
  local imageStringLower
  local imageMaskUsesTexture
  local imageMaskKindValue
  local imageMaskTextureChannelKind
  local imageMaskTextureSource
  local imageMaskTextureUV
  local imageChamferCuts
  local imageChamferMaskTuple
  local setupImageMaskConstants
  local drawImageMaskPass
  local resolveMaskTexture
  local imageBackdropTintColor
  local setupImageMaskEffectParams
  local drawImageMaskShadowOuter
  local setupImageMaskBackdropConstants
  local drawImageMaskBackdrop
  local drawImageMaskShader
  local drawRoundImageEffect
  local drawChamferImageEffect
  local drawImageFallback
  local drawImageChamfer
  local imageRoundedRadius
  local imageUsesSourceAlphaEffectMask
  local drawImageRoundRectShader
  local imageImmediate
  local imageEx
  local image
  local iconEx
  local icon
  local textEx
  local textDraw
  local textBoxEx
  local textBox
  local install
  do
    local frameImport = __lux_import("lux/mgfx/frame#client")
    local geometryImport = __lux_import("lux/mgfx/geometry#client")
    local paintImport = __lux_import("lux/mgfx/paint#client")
    local primitivesImport = __lux_import("lux/mgfx/primitives#client")
    local roundrectImport = __lux_import("lux/mgfx/roundrect#client")
    local styleImport = __lux_import("lux/mgfx/style#client")
    local textImport = __lux_import("lux/mgfx/text#client")
    frame = frameImport
    geometry = geometryImport
    paint = paintImport
    primitives = primitivesImport
    roundrect = roundrectImport
    style = styleImport
    text = textImport
    getConVar = GetConVar
    matrixCtor = Matrix
    makeColor = Color
    mathClamp = math.Clamp
    mathCos = math.cos
    mathFloor = math.floor
    mathAbs = math.abs
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
    surfaceSetDrawColor = surface.SetDrawColor
    surfaceSetMaterial = surface.SetMaterial
    toNumber = tonumber
    typeOf = type
    drawTexturedQuad = geometry.drawTexturedQuad
    blurIntensity = geometry.blurIntensity
    hasTransform = geometry.hasTransform
    beginPanelEffectBleed = frame.beginPanelEffectBleed
    endPanelEffectBleed = frame.endPanelEffectBleed
    withPanelEffectBleed = frame.withPanelEffectBleed
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
    auxParamMatrices = {}
    widgetMaterials = {}
    widgetBlurRT = nil
    widgetMatOK = function(material)
      return material ~= nil and material.IsError ~= nil and not material:IsError()
    end
    widgetHasShaders = function()
      return false
    end
    forceFallbackCvar = nil
    progressStyle = {}
    segmentStyle = {}
    ringStyle = {}
    arcStyle = {}
    sectorStyle = {}
    imageStyleScratch = {}
    iconStyleScratch = {}
    progressTrackStyle = {}
    progressTickStyle = { radius = 0 }
    progressGlowStyle = {}
    progressFillStyle = {}
    progressSheenStyle = {}
    progressMarkerStyle = { radius = 1 }
    segmentContainerStyle = {}
    segmentItemStyle = {}
    progressTrackDarkColor = makeColor(0, 0, 0, 0)
    progressTickColor = makeColor(255, 255, 255, 18)
    progressGlowColor = makeColor(80, 190, 255, 38)
    progressMarkerColor = makeColor(255, 255, 255, 96)
    progressTrackGradient = style.linearGradient(0, 0, 0, 1, makeColor(0, 0, 0, 0), color_white)
    progressSheenGradient = style.linearGradient(
      0,
      0,
      0,
      1,
      makeColor(255, 255, 255, 42),
      makeColor(255, 255, 255, 0)
    )
    imageRoundEffectStyle = {}
    imageChamferEffectStyle = {}
    sourceAlphaMaskScratch = { kind = "texture", channel = "alpha", sourceAlpha = true }
    defaultProgressTrack = makeColor(10, 18, 24, 190)
    defaultProgressStroke = makeColor(255, 255, 255, 18)
    defaultSegmentFill = makeColor(255, 120, 72, 230)
    defaultSegmentTrack = makeColor(255, 255, 255, 22)
    defaultRingFill = makeColor(255, 255, 255, 180)
    transparentColor = makeColor(0, 0, 0, 0)
    configureWidgets = function(owner)
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
          __lux_tmp_Materials_6 = widgetMaterials
        end
        if __lux_tmp_Materials_6 == nil then
          __lux_tmp_Materials_6 = {}
        end
        widgetMaterials = __lux_tmp_Materials_6
      end
      do
        local __lux_tmp_BlurRT_7 = owner._BlurRT
        if __lux_tmp_BlurRT_7 == nil then
          __lux_tmp_BlurRT_7 = materialState.blurRT
        end
        if __lux_tmp_BlurRT_7 == nil then
          __lux_tmp_BlurRT_7 = widgetBlurRT
        end
        widgetBlurRT = __lux_tmp_BlurRT_7
      end
      do
        local __lux_tmp_MaterialOK_8 = owner.MaterialOK
        if __lux_tmp_MaterialOK_8 == nil then
          __lux_tmp_MaterialOK_8 = materialState.matOK
        end
        if __lux_tmp_MaterialOK_8 == nil then
          __lux_tmp_MaterialOK_8 = widgetMatOK
        end
        widgetMatOK = __lux_tmp_MaterialOK_8
      end
      do
        local __lux_tmp_hasShaders_9 = owner.hasShaders
        if __lux_tmp_hasShaders_9 == nil then
          __lux_tmp_hasShaders_9 = widgetHasShaders
        end
        widgetHasShaders = __lux_tmp_hasShaders_9
      end
      return true
    end
    materialOK = function(material)
      return widgetMatOK ~= nil and widgetMatOK(material)
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
      return widgetHasShaders ~= nil and widgetHasShaders()
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
        local __lux_tmp_a0_11 = a0
        if __lux_tmp_a0_11 == nil then
          __lux_tmp_a0_11 = 0
        end
        local __lux_tmp_b0_12 = b0
        if __lux_tmp_b0_12 == nil then
          __lux_tmp_b0_12 = 0
        end
        local __lux_tmp_c0_13 = c0
        if __lux_tmp_c0_13 == nil then
          __lux_tmp_c0_13 = 0
        end
        local __lux_tmp_d0_14 = d0
        if __lux_tmp_d0_14 == nil then
          __lux_tmp_d0_14 = 0
        end
        local __lux_tmp_a1_15 = a1
        if __lux_tmp_a1_15 == nil then
          __lux_tmp_a1_15 = 0
        end
        local __lux_tmp_b1_16 = b1
        if __lux_tmp_b1_16 == nil then
          __lux_tmp_b1_16 = 0
        end
        local __lux_tmp_c1_17 = c1
        if __lux_tmp_c1_17 == nil then
          __lux_tmp_c1_17 = 0
        end
        local __lux_tmp_d1_18 = d1
        if __lux_tmp_d1_18 == nil then
          __lux_tmp_d1_18 = 0
        end
        local __lux_tmp_a2_19 = a2
        if __lux_tmp_a2_19 == nil then
          __lux_tmp_a2_19 = 0
        end
        local __lux_tmp_b2_20 = b2
        if __lux_tmp_b2_20 == nil then
          __lux_tmp_b2_20 = 0
        end
        local __lux_tmp_c2_21 = c2
        if __lux_tmp_c2_21 == nil then
          __lux_tmp_c2_21 = 0
        end
        local __lux_tmp_d2_22 = d2
        if __lux_tmp_d2_22 == nil then
          __lux_tmp_d2_22 = 0
        end
        local __lux_tmp_a3_23 = a3
        if __lux_tmp_a3_23 == nil then
          __lux_tmp_a3_23 = 0
        end
        local __lux_tmp_b3_24 = b3
        if __lux_tmp_b3_24 == nil then
          __lux_tmp_b3_24 = 0
        end
        local __lux_tmp_c3_25 = c3
        if __lux_tmp_c3_25 == nil then
          __lux_tmp_c3_25 = 0
        end
        local __lux_tmp_d3_26 = d3
        if __lux_tmp_d3_26 == nil then
          __lux_tmp_d3_26 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_a0_11,
          __lux_tmp_b0_12,
          __lux_tmp_c0_13,
          __lux_tmp_d0_14,
          __lux_tmp_a1_15,
          __lux_tmp_b1_16,
          __lux_tmp_c1_17,
          __lux_tmp_d1_18,
          __lux_tmp_a2_19,
          __lux_tmp_b2_20,
          __lux_tmp_c2_21,
          __lux_tmp_d2_22,
          __lux_tmp_a3_23,
          __lux_tmp_b3_24,
          __lux_tmp_c3_25,
          __lux_tmp_d3_26
        )
      end
      material:SetMatrix("$viewprojmat", matrix)
      return true
    end
    setupAuxConstants = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3)
      if d0 == nil then
        d0 = 0
      end
      if d1 == nil then
        d1 = 0
      end
      if d2 == nil then
        d2 = 0
      end
      if d3 == nil then
        d3 = 0
      end
      if material == nil or paramMatrixSetUnpacked == nil or matrixCtor == nil then
        return false
      end
      local matrix = auxParamMatrices[material]
      if matrix == nil then
        matrix = matrixCtor()
        auxParamMatrices[material] = matrix
      end
      do
        local __lux_tmp_a0_27 = a0
        if __lux_tmp_a0_27 == nil then
          __lux_tmp_a0_27 = 0
        end
        local __lux_tmp_b0_28 = b0
        if __lux_tmp_b0_28 == nil then
          __lux_tmp_b0_28 = 0
        end
        local __lux_tmp_c0_29 = c0
        if __lux_tmp_c0_29 == nil then
          __lux_tmp_c0_29 = 0
        end
        local __lux_tmp_d0_30 = d0
        if __lux_tmp_d0_30 == nil then
          __lux_tmp_d0_30 = 0
        end
        local __lux_tmp_a1_31 = a1
        if __lux_tmp_a1_31 == nil then
          __lux_tmp_a1_31 = 0
        end
        local __lux_tmp_b1_32 = b1
        if __lux_tmp_b1_32 == nil then
          __lux_tmp_b1_32 = 0
        end
        local __lux_tmp_c1_33 = c1
        if __lux_tmp_c1_33 == nil then
          __lux_tmp_c1_33 = 0
        end
        local __lux_tmp_d1_34 = d1
        if __lux_tmp_d1_34 == nil then
          __lux_tmp_d1_34 = 0
        end
        local __lux_tmp_a2_35 = a2
        if __lux_tmp_a2_35 == nil then
          __lux_tmp_a2_35 = 0
        end
        local __lux_tmp_b2_36 = b2
        if __lux_tmp_b2_36 == nil then
          __lux_tmp_b2_36 = 0
        end
        local __lux_tmp_c2_37 = c2
        if __lux_tmp_c2_37 == nil then
          __lux_tmp_c2_37 = 0
        end
        local __lux_tmp_d2_38 = d2
        if __lux_tmp_d2_38 == nil then
          __lux_tmp_d2_38 = 0
        end
        local __lux_tmp_a3_39 = a3
        if __lux_tmp_a3_39 == nil then
          __lux_tmp_a3_39 = 0
        end
        local __lux_tmp_b3_40 = b3
        if __lux_tmp_b3_40 == nil then
          __lux_tmp_b3_40 = 0
        end
        local __lux_tmp_c3_41 = c3
        if __lux_tmp_c3_41 == nil then
          __lux_tmp_c3_41 = 0
        end
        local __lux_tmp_d3_42 = d3
        if __lux_tmp_d3_42 == nil then
          __lux_tmp_d3_42 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_a0_27,
          __lux_tmp_b0_28,
          __lux_tmp_c0_29,
          __lux_tmp_d0_30,
          __lux_tmp_a1_31,
          __lux_tmp_b1_32,
          __lux_tmp_c1_33,
          __lux_tmp_d1_34,
          __lux_tmp_a2_35,
          __lux_tmp_b2_36,
          __lux_tmp_c2_37,
          __lux_tmp_d2_38,
          __lux_tmp_a3_39,
          __lux_tmp_b3_40,
          __lux_tmp_c3_41,
          __lux_tmp_d3_42
        )
      end
      material:SetMatrix("$invviewprojmat", matrix)
      return true
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
    colorAt = function(fill, t)
      return style.colorAtFill(fill, t)
    end
    fxFlags = function(drawStyle)
      local fx = typeOf(drawStyle.fx) == "table" and drawStyle.fx or nil
      if fx == nil then
        return false, false, false, 0
      end
      local glow = fx.glow == true or typeOf(fx.glow) == "table"
      local sheen = fx.sheen == true or typeOf(fx.sheen) == "table"
      local marker = fx.marker == true or typeOf(fx.marker) == "table"
      local ticks = 0
      local tickSpec = fx.ticks
      if typeOf(tickSpec) == "number" then
        ticks = tickSpec
      else
        if typeOf(tickSpec) == "table" then
          do
            local __lux_tmp_count_43 = tickSpec.count
            if __lux_tmp_count_43 == nil then
              __lux_tmp_count_43 = 0
            end
            ticks = __lux_tmp_count_43
          end
        end
      end
      local __lux_tmp_ticks_44 = toNumber(ticks)
      if __lux_tmp_ticks_44 == nil then
        __lux_tmp_ticks_44 = 0
      end
      return glow, sheen, marker, mathClamp(mathFloor(__lux_tmp_ticks_44), 0, 31)
    end
    effectBleedFromDrawRect = function(x, y, w, h, drawX, drawY, drawW, drawH)
      local left = mathMax(0, x - drawX)
      local top = mathMax(0, y - drawY)
      local right = mathMax(0, drawX + drawW - (x + w))
      local bottom = mathMax(0, drawY + drawH - (y + h))
      return left, top, right, bottom
    end
  end
  do
    progressFxBits = function(drawStyle)
      local fx = typeOf(drawStyle.fx) == "table" and drawStyle.fx or nil
      if fx == nil then
        return 0, 0
      end
      local flags = 0
      if fx.glow == true or typeOf(fx.glow) == "table" then
        flags = flags + 1
      end
      if fx.sheen == true or typeOf(fx.sheen) == "table" then
        flags = flags + 2
      end
      if fx.marker == true or typeOf(fx.marker) == "table" then
        flags = flags + 4
      end
      local ticks = 0
      local tickSpec = fx.ticks
      if typeOf(tickSpec) == "number" then
        ticks = tickSpec
      else
        if typeOf(tickSpec) == "table" then
          do
            local __lux_tmp_count_45 = tickSpec.count
            if __lux_tmp_count_45 == nil then
              __lux_tmp_count_45 = 0
            end
            ticks = __lux_tmp_count_45
          end
        end
      end
      local __lux_tmp_ticks_46 = toNumber(ticks)
      if __lux_tmp_ticks_46 == nil then
        __lux_tmp_ticks_46 = 0
      end
      return flags, mathClamp(mathFloor(__lux_tmp_ticks_46), 0, 31)
    end
    progressFillCanFast = function(fill)
      local __lux_match_47 = fill
      local __lux_tag_48
      if __lux_match_47 ~= nil then
        __lux_tag_48 = __lux_match_47.kind
      end
      if __lux_tag_48 == style.FILL_SOLID then
        return true
      elseif __lux_tag_48 == style.FILL_LINEAR then
        local x1 = __lux_match_47.x1
        local y1 = __lux_match_47.y1
        local x2 = __lux_match_47.x2
        local y2 = __lux_match_47.y2
        local __lux_tmp_x1_49 = x1
        if __lux_tmp_x1_49 == nil then
          __lux_tmp_x1_49 = 0
        end
        local __lux_tmp_51 = __lux_tmp_x1_49 == 0
        if __lux_tmp_51 then
          local __lux_tmp_y1_50 = y1
          if __lux_tmp_y1_50 == nil then
            __lux_tmp_y1_50 = 0
          end
          __lux_tmp_51 = __lux_tmp_y1_50 == 0
        end
        local __lux_tmp_53 = __lux_tmp_51
        if __lux_tmp_53 then
          local __lux_tmp_x2_52 = x2
          if __lux_tmp_x2_52 == nil then
            __lux_tmp_x2_52 = 1
          end
          __lux_tmp_53 = __lux_tmp_x2_52 == 1
        end
        local __lux_tmp_55 = __lux_tmp_53
        if __lux_tmp_55 then
          local __lux_tmp_y2_54 = y2
          if __lux_tmp_y2_54 == nil then
            __lux_tmp_y2_54 = 0
          end
          __lux_tmp_55 = __lux_tmp_y2_54 == 0
        end
        return __lux_tmp_55
      else
        return false
      end
    end
    canDrawProgressFast = function(fill, drawStyle, inset, strokeWidth, flags, ticks, fxMat)
      if not shadersActive() or not materialOK(fxMat) then
        return false
      end
      if drawStyle.shadow ~= nil or drawStyle.backdrop ~= nil or drawStyle.outerGlow ~= nil or drawStyle.innerGlow ~= nil or drawStyle.pattern ~= nil or drawStyle.fillPattern ~= nil or drawStyle.trackPattern ~= nil then
        return false
      end
      if inset ~= mathFloor(inset) or strokeWidth ~= mathFloor(strokeWidth) then
        return false
      end
      if inset < 0 or inset > 31 or strokeWidth < 0 or strokeWidth > 15 then
        return false
      end
      if not progressFillCanFast(fill) then
        return false
      end
      if fxMat == widgetMaterials.progress and (flags ~= 0 or ticks > 1) then
        return false
      end
      return true
    end
    setupProgressConstants = function(material, w, h, value, radius, inset, track, fill, stroke, strokeWidth)
      local fillA = fill.colorA
      if fillA == nil then
        fillA = color_white
      end
      local fillB = fill.colorB
      if fillB == nil then
        fillB = fillA
      end
      local r, g, b, a = style.color01(fillB)
      local br = r
      local bg = g
      local bb = b
      local ba = a
      local packedProgress = mathFloor(inset) * 2 + mathClamp(value, 0, 1)
      local packedRadius = mathMax(0, radius) + mathClamp(strokeWidth, 0, 15) * 256
      r, g, b, a = style.color01(fillA)
      local ar = r
      local ag = g
      local ab = b
      local aa = a
      do
        local __lux_tmp_stroke_56 = stroke
        if __lux_tmp_stroke_56 == nil then
          __lux_tmp_stroke_56 = transparentColor
        end
        r, g, b, a = style.color01(__lux_tmp_stroke_56)
      end
      setupParamMatrix(
        material,
        br,
        bg,
        bb,
        ba,
        w,
        h,
        packedProgress,
        packedRadius,
        ar,
        ag,
        ab,
        aa,
        r,
        g,
        b,
        a
      )
      style.bindGradientLut(material, fill)
      return style.setDrawColor(track)
    end
    setupProgressFxConstants = function(material, w, h, value, radius, inset, track, fill, stroke, strokeWidth, flags, ticks)
      local fillA = fill.colorA
      if fillA == nil then
        fillA = color_white
      end
      local fillB = fill.colorB
      if fillB == nil then
        fillB = fillA
      end
      do
        local __lux_tmp_flags_57 = toNumber(flags)
        if __lux_tmp_flags_57 == nil then
          __lux_tmp_flags_57 = 0
        end
        flags = mathClamp(mathFloor(__lux_tmp_flags_57), 0, 7)
      end
      do
        local __lux_tmp_ticks_58 = toNumber(ticks)
        if __lux_tmp_ticks_58 == nil then
          __lux_tmp_ticks_58 = 0
        end
        ticks = mathClamp(mathFloor(__lux_tmp_ticks_58), 0, 31)
      end
      do
        local __lux_tmp_radius_59 = toNumber(radius)
        if __lux_tmp_radius_59 == nil then
          __lux_tmp_radius_59 = 0
        end
        radius = mathClamp(__lux_tmp_radius_59, 0, 255)
      end
      do
        local __lux_tmp_inset_60 = toNumber(inset)
        if __lux_tmp_inset_60 == nil then
          __lux_tmp_inset_60 = 0
        end
        inset = mathClamp(mathFloor(__lux_tmp_inset_60), 0, 31)
      end
      do
        local __lux_tmp_strokeWidth_61 = toNumber(strokeWidth)
        if __lux_tmp_strokeWidth_61 == nil then
          __lux_tmp_strokeWidth_61 = 0
        end
        strokeWidth = mathClamp(mathFloor(__lux_tmp_strokeWidth_61), 0, 15)
      end
      local r, g, b, a = style.color01(fillB)
      local br = r
      local bg = g
      local bb = b
      local ba = a
      local packedFx = mathClamp(value, 0, 1) * 0.5 + flags + ticks * 8
      local packedLayout = radius + strokeWidth * 256 + inset * 4096
      r, g, b, a = style.color01(fillA)
      local ar = r
      local ag = g
      local ab = b
      local aa = a
      do
        local __lux_tmp_stroke_62 = stroke
        if __lux_tmp_stroke_62 == nil then
          __lux_tmp_stroke_62 = transparentColor
        end
        r, g, b, a = style.color01(__lux_tmp_stroke_62)
      end
      setupParamMatrix(
        material,
        br,
        bg,
        bb,
        ba,
        w,
        h,
        packedFx,
        packedLayout,
        ar,
        ag,
        ab,
        aa,
        r,
        g,
        b,
        a
      )
      style.bindGradientLut(material, fill)
      return style.setDrawColor(track)
    end
    drawProgressFast = function(x, y, w, h, value, drawStyle, fill, radius, inset, track, stroke, strokeWidth, flags, ticks)
      local material
      if flags ~= 0 or ticks > 1 then
        material = widgetMaterials.progress_fx
      else
        material = widgetMaterials.progress
      end
      if not canDrawProgressFast(fill, drawStyle, inset, strokeWidth, flags, ticks, material) then
        return false
      end
      if material == widgetMaterials.progress_fx then
        setupProgressFxConstants(
          material,
          w,
          h,
          value,
          radius,
          inset,
          track,
          fill,
          stroke,
          strokeWidth,
          flags,
          ticks
        )
      else
        setupProgressConstants(
          material,
          w,
          h,
          value,
          radius,
          inset,
          track,
          fill,
          stroke,
          strokeWidth
        )
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    setGradientColors = function(fill, colorA, colorB)
      fill.colorA = colorA
      fill.colorB = colorB
      fill.stops[1].color = colorA
      fill.stops[2].color = colorB
      fill._mgfxFillVisible = colorA.a == nil or colorA.a > 0 or (colorB.a == nil or colorB.a > 0)
      fill._mgfxLutCacheSafe = false
      return fill
    end
    segmentFillEndpoints = function(fill)
      if fill.stops ~= nil and #fill.stops > 0 then
        local first = nil
        local last = nil
        for _, stop in ipairs(fill.stops) do
          local color = stop.color
          if color == nil then
            color = stop[2]
          end
          if color ~= nil and (color.a == nil or color.a > 0) then
            if first == nil then
              first = color
            end
            last = color
          end
        end
        if first ~= nil and last ~= nil then
          return first, last
        end
      end
      local __lux_tmp_colorA_63 = fill.colorA
      if __lux_tmp_colorA_63 == nil then
        __lux_tmp_colorA_63 = color_white
      end
      local __lux_tmp_colorB_64 = fill.colorB
      if __lux_tmp_colorB_64 == nil then
        __lux_tmp_colorB_64 = fill.colorA
      end
      if __lux_tmp_colorB_64 == nil then
        __lux_tmp_colorB_64 = color_white
      end
      return __lux_tmp_colorA_63, __lux_tmp_colorB_64
    end
    drawSegmentBarShader = function(x, y, w, h, value, drawStyle, count, gap, fill, track)
      if not shadersActive() or not materialOK(widgetMaterials.segmentbar) then
        return false
      end
      if drawStyle.background ~= nil then
        return false
      end
      if style.strokeVisible(drawStyle.stroke, drawStyle.strokeWidth) then
        return false
      end
      if drawStyle.shadow ~= nil or drawStyle.backdrop ~= nil or drawStyle.outerGlow ~= nil or drawStyle.innerGlow ~= nil or drawStyle.pattern ~= nil or drawStyle.fillPattern ~= nil or drawStyle.trackPattern ~= nil then
        return false
      end
      local totalGap = gap * (count - 1)
      local segmentW = (w - totalGap) / count
      if segmentW <= 0 or h <= 0 then
        return true
      end
      local trackColor = style.asColor(track, defaultSegmentTrack)
      local fillA, fillB = segmentFillEndpoints(fill)
      local hasFill = style.fillVisible(fill)
      local hasTrack = trackColor.a == nil or trackColor.a > 0
      if not hasFill and not hasTrack then
        return true
      end
      local material = widgetMaterials.segmentbar
      local r, g, b, a = style.color01(fillB)
      local fillR = r
      local fillG = g
      local fillBValue = b
      local fillAValue = a
      r, g, b, a = style.color01(trackColor)
      do
        local __lux_tmp_value_65 = toNumber(value)
        if __lux_tmp_value_65 == nil then
          __lux_tmp_value_65 = 0
        end
        local __lux_tmp_66
        if drawStyle.radius == nil then
          __lux_tmp_66 = mathMin(2, h * 0.35)
        else
          __lux_tmp_66 = drawStyle.radius
        end
        local __lux_tmp_toNumber_67 = toNumber(__lux_tmp_66)
        if __lux_tmp_toNumber_67 == nil then
          __lux_tmp_toNumber_67 = 0
        end
        setupParamMatrix(
          material,
          fillR,
          fillG,
          fillBValue,
          fillAValue,
          r,
          g,
          b,
          a,
          w,
          h,
          count,
          gap,
          mathClamp(__lux_tmp_value_65, 0, 1),
          mathMax(0, __lux_tmp_toNumber_67),
          0,
          0
        )
      end
      style.bindGradientLut(material, fill)
      style.setDrawColor(fillA)
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    progressBarEx = function(x, y, w, h, value, drawStyle)
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local transform, stripped = geometry.splitStyleTransform(resolved)
      if transform ~= nil then
        return geometry.withTransform(
          transform,
          x,
          y,
          w,
          h,
          function()
            return progressBarEx(x, y, w, h, value, stripped)
          end
        )
      end
      local frac
      do
        local __lux_tmp_value_68 = toNumber(value)
        if __lux_tmp_value_68 == nil then
          __lux_tmp_value_68 = 0
        end
        frac = mathClamp(__lux_tmp_value_68, 0, 1)
      end
      local radius = stripped.radius
      if radius == nil then
        radius = mathMin(4, h * 0.5)
      end
      local inset
      do
        local __lux_tmp_padding_69 = toNumber(stripped.padding)
        if __lux_tmp_padding_69 == nil then
          __lux_tmp_padding_69 = 0
        end
        inset = mathMax(0, __lux_tmp_padding_69)
      end
      local track = stripped.track
      if track == nil then
        track = defaultProgressTrack
      end
      local fill = stripped.fill
      if fill == nil then
        fill = color_white
      end
      local stroke = stripped.stroke
      if stroke == nil then
        stroke = defaultProgressStroke
      end
      local strokeWidth = style.strokeWidth(stripped.strokeWidth, 1)
      local flags, shaderTicks = progressFxBits(stripped)
      local fillObj = style.fillFromStyle(fill)
      if drawProgressFast(
        x,
        y,
        w,
        h,
        frac,
        stripped,
        fillObj,
        radius,
        inset,
        track,
        stroke,
        strokeWidth,
        flags,
        shaderTicks
      ) then
        return
      end
      local glow, sheen, marker, ticks = fxFlags(stripped)
      do
        local __lux_tmp_r_70 = track.r
        if __lux_tmp_r_70 == nil then
          __lux_tmp_r_70 = 0
        end
        progressTrackDarkColor.r = mathFloor(__lux_tmp_r_70 * 0.65)
      end
      do
        local __lux_tmp_g_71 = track.g
        if __lux_tmp_g_71 == nil then
          __lux_tmp_g_71 = 0
        end
        progressTrackDarkColor.g = mathFloor(__lux_tmp_g_71 * 0.65)
      end
      do
        local __lux_tmp_b_72 = track.b
        if __lux_tmp_b_72 == nil then
          __lux_tmp_b_72 = 0
        end
        progressTrackDarkColor.b = mathFloor(__lux_tmp_b_72 * 0.65)
      end
      do
        local __lux_tmp_a_73 = track.a
        if __lux_tmp_a_73 == nil then
          __lux_tmp_a_73 = 190
        end
        progressTrackDarkColor.a = __lux_tmp_a_73
      end
      progressTrackStyle.radius = radius
      progressTrackStyle.fill = setGradientColors(progressTrackGradient, progressTrackDarkColor, track)
      progressTrackStyle.stroke = stroke
      progressTrackStyle.strokeWidth = strokeWidth
      progressTrackStyle.shadow = stripped.shadow
      progressTrackStyle.outerGlow = stripped.outerGlow
      progressTrackStyle.innerGlow = stripped.innerGlow
      progressTrackStyle.backdrop = stripped.backdrop
      progressTrackStyle.pattern = stripped.trackPattern
      roundrect.drawRoundRectImmediate(x, y, w, h, progressTrackStyle)
      local innerH = h - inset * 2
      local innerW = (w - inset * 2) * frac
      if frac >= 0.999 then
        innerW = w - inset * 2
      end
      if ticks > 1 then
        progressTickStyle.shadow = nil
        progressTickStyle.outerGlow = nil
        progressTickStyle.innerGlow = nil
        progressTickStyle.backdrop = nil
        progressTickStyle.pattern = nil
        progressTickStyle.stroke = nil
        progressTickStyle.strokeWidth = nil
        progressTickStyle.fill = progressTickColor
        for index = 1, ticks - 1 do
          local tx = x + mathFloor(w * index / ticks)
          roundrect.drawRoundRectImmediate(tx, y + 3, 1, mathMax(1, h - 6), progressTickStyle)
        end
      end
      if innerH <= 0 or innerW <= 0 then
        return
      end
      if glow and innerW > 4 then
        progressGlowStyle.radius = mathMin(radius + 2, (innerH + 4) * 0.5, (innerW + 4) * 0.5)
        progressGlowStyle.fill = progressGlowColor
        progressGlowStyle.shadow = nil
        progressGlowStyle.outerGlow = nil
        progressGlowStyle.innerGlow = nil
        progressGlowStyle.backdrop = nil
        progressGlowStyle.pattern = nil
        progressGlowStyle.stroke = nil
        progressGlowStyle.strokeWidth = nil
        roundrect.drawRoundRectImmediate(
          x + inset - 2,
          y + inset - 2,
          innerW + 4,
          innerH + 4,
          progressGlowStyle
        )
      end
      progressFillStyle.radius = mathMin(mathMax(0, radius - inset), innerH * 0.5, innerW * 0.5)
      progressFillStyle.fill = fill
      do
        local __lux_tmp_fillPattern_74 = stripped.fillPattern
        if __lux_tmp_fillPattern_74 == nil then
          __lux_tmp_fillPattern_74 = stripped.pattern
        end
        progressFillStyle.pattern = __lux_tmp_fillPattern_74
      end
      progressFillStyle.shadow = nil
      progressFillStyle.outerGlow = nil
      progressFillStyle.innerGlow = nil
      progressFillStyle.backdrop = nil
      progressFillStyle.stroke = nil
      progressFillStyle.strokeWidth = nil
      roundrect.drawRoundRectImmediate(
        x + inset,
        y + inset,
        innerW,
        innerH,
        progressFillStyle
      )
      if sheen and innerW > 8 then
        progressSheenStyle.radius = mathMin(radius, innerH * 0.25)
        progressSheenStyle.fill = progressSheenGradient
        progressSheenStyle.shadow = nil
        progressSheenStyle.outerGlow = nil
        progressSheenStyle.innerGlow = nil
        progressSheenStyle.backdrop = nil
        progressSheenStyle.pattern = nil
        progressSheenStyle.stroke = nil
        progressSheenStyle.strokeWidth = nil
        roundrect.drawRoundRectImmediate(
          x + inset + 1,
          y + inset + 1,
          mathMax(1, innerW - 2),
          mathMax(1, innerH * 0.38),
          progressSheenStyle
        )
      end
      if marker and innerW > 5 then
        local mx = x + inset + innerW - 2
        progressMarkerStyle.fill = progressMarkerColor
        progressMarkerStyle.shadow = nil
        progressMarkerStyle.outerGlow = nil
        progressMarkerStyle.innerGlow = nil
        progressMarkerStyle.backdrop = nil
        progressMarkerStyle.pattern = nil
        progressMarkerStyle.stroke = nil
        progressMarkerStyle.strokeWidth = nil
        roundrect.drawRoundRectImmediate(mx, y + 2, 2, h - 4, progressMarkerStyle)
      end
    end
    progressBar = function(x, y, w, h, value, radius, track, fill, stroke, strokeWidth)
      progressStyle.radius = radius
      progressStyle.track = track
      progressStyle.fill = fill
      progressStyle.stroke = stroke
      progressStyle.strokeWidth = strokeWidth
      progressStyle.padding = nil
      progressStyle.fx = nil
      return progressBarEx(x, y, w, h, value, progressStyle)
    end
    segmentBarEx = function(x, y, w, h, value, drawStyle)
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local transform, stripped = geometry.splitStyleTransform(resolved)
      if transform ~= nil then
        return geometry.withTransform(
          transform,
          x,
          y,
          w,
          h,
          function()
            return segmentBarEx(x, y, w, h, value, stripped)
          end
        )
      end
      local count
      do
        local __lux_tmp_segments_75 = toNumber(stripped.segments)
        if __lux_tmp_segments_75 == nil then
          __lux_tmp_segments_75 = 10
        end
        count = mathClamp(mathFloor(__lux_tmp_segments_75), 1, 128)
      end
      local gap
      do
        local __lux_tmp_gap_76 = toNumber(stripped.gap)
        if __lux_tmp_gap_76 == nil then
          __lux_tmp_gap_76 = 2
        end
        gap = mathMax(0, __lux_tmp_gap_76)
      end
      local frac
      do
        local __lux_tmp_value_77 = toNumber(value)
        if __lux_tmp_value_77 == nil then
          __lux_tmp_value_77 = 0
        end
        frac = mathClamp(__lux_tmp_value_77, 0, 1)
      end
      local active = mathFloor(frac * count + 0.0001)
      local fill
      do
        local __lux_tmp_fill_78 = stripped.fill
        if __lux_tmp_fill_78 == nil then
          __lux_tmp_fill_78 = stripped.color
        end
        if __lux_tmp_fill_78 == nil then
          __lux_tmp_fill_78 = defaultSegmentFill
        end
        fill = style.fillFromStyle(__lux_tmp_fill_78)
      end
      local track = stripped.track
      if track == nil then
        track = defaultSegmentTrack
      end
      if drawSegmentBarShader(x, y, w, h, frac, stripped, count, gap, fill, track) then
        return
      end
      local totalGap = gap * (count - 1)
      local segmentW = (w - totalGap) / count
      if segmentW <= 0 or h <= 0 then
        return
      end
      local containerRadius = stripped.backgroundRadius
      if containerRadius == nil then
        containerRadius = stripped.radius
        if containerRadius == nil then
          containerRadius = mathMin(3, h * 0.5)
        end
      end
      if stripped.shadow ~= nil or stripped.outerGlow ~= nil or stripped.innerGlow ~= nil or stripped.backdrop ~= nil or stripped.background ~= nil then
        segmentContainerStyle.radius = containerRadius
        do
          local __lux_tmp_background_79 = stripped.background
          if __lux_tmp_background_79 == nil then
            __lux_tmp_background_79 = transparentColor
          end
          segmentContainerStyle.fill = __lux_tmp_background_79
        end
        segmentContainerStyle.shadow = stripped.shadow
        segmentContainerStyle.outerGlow = stripped.outerGlow
        segmentContainerStyle.innerGlow = stripped.innerGlow
        segmentContainerStyle.backdrop = stripped.backdrop
        segmentContainerStyle.pattern = nil
        segmentContainerStyle.stroke = nil
        segmentContainerStyle.strokeWidth = nil
        roundrect.drawRoundRectImmediate(x, y, w, h, segmentContainerStyle)
      end
      do
        local __lux_tmp_80
        if stripped.radius == nil then
          __lux_tmp_80 = mathMin(2, h * 0.35)
        else
          __lux_tmp_80 = stripped.radius
        end
        segmentItemStyle.radius = __lux_tmp_80
      end
      segmentItemStyle.stroke = stripped.stroke
      do
        local __lux_tmp_strokeWidth_81 = stripped.strokeWidth
        if __lux_tmp_strokeWidth_81 == nil then
          __lux_tmp_strokeWidth_81 = 0
        end
        segmentItemStyle.strokeWidth = __lux_tmp_strokeWidth_81
      end
      segmentItemStyle.shadow = nil
      segmentItemStyle.outerGlow = nil
      segmentItemStyle.innerGlow = nil
      segmentItemStyle.backdrop = nil
      for index = 1, count do
        local t
        if count == 1 then
          t = 1
        else
          t = (index - 1) / (count - 1)
        end
        local sx = x + (index - 1) * (segmentW + gap)
        local filled = index <= active
        local color
        if filled then
          color = colorAt(fill, t)
        else
          color = track
        end
        local pattern
        if filled then
          pattern = stripped.fillPattern
          if pattern == nil then
            pattern = stripped.pattern
          end
        else
          pattern = stripped.trackPattern
        end
        if color ~= nil or pattern ~= nil then
          do
            local __lux_tmp_color_82 = color
            if __lux_tmp_color_82 == nil then
              __lux_tmp_color_82 = transparentColor
            end
            segmentItemStyle.fill = __lux_tmp_color_82
          end
          segmentItemStyle.pattern = pattern
          roundrect.drawRoundRectImmediate(sx, y, segmentW, h, segmentItemStyle)
        end
      end
    end
    segmentBar = function(x, y, w, h, value, segments, fill, track)
      segmentStyle.segments = segments
      segmentStyle.fill = fill
      segmentStyle.track = track
      segmentStyle.radius = nil
      segmentStyle.gap = nil
      segmentStyle.stroke = nil
      segmentStyle.strokeWidth = nil
      return segmentBarEx(x, y, w, h, value, segmentStyle)
    end
  end
  do
    arcSegmentCount = function(radius, startDeg, endDeg, fallback)
      if fallback == nil then
        fallback = 64
      end
      local sweep
      do
        local __lux_tmp_endDeg_83 = endDeg
        if __lux_tmp_endDeg_83 == nil then
          __lux_tmp_endDeg_83 = 360
        end
        local __lux_tmp_startDeg_84 = startDeg
        if __lux_tmp_startDeg_84 == nil then
          __lux_tmp_startDeg_84 = 0
        end
        sweep = mathAbs(__lux_tmp_endDeg_83 - __lux_tmp_startDeg_84)
      end
      return mathClamp(mathFloor(sweep / 360 * fallback), 3, fallback)
    end
    ringModeValue = function(mode)
      local __lux_match_85 = mode
      if __lux_match_85 == "sector" or __lux_match_85 == 2 then
        return 2
      elseif __lux_match_85 == "arc" or __lux_match_85 == true or __lux_match_85 == 1 then
        return 1
      else
        return 0
      end
    end
    ringShapeConstants = function(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      local __lux_tmp_innerRadius_86 = toNumber(innerRadius)
      if __lux_tmp_innerRadius_86 == nil then
        __lux_tmp_innerRadius_86 = 0
      end
      local __lux_tmp_outerRadius_87 = toNumber(outerRadius)
      if __lux_tmp_outerRadius_87 == nil then
        __lux_tmp_outerRadius_87 = mathMin(w, h) * 0.5
      end
      local __lux_tmp_startDeg_88 = toNumber(startDeg)
      if __lux_tmp_startDeg_88 == nil then
        __lux_tmp_startDeg_88 = 0
      end
      local __lux_tmp_endDeg_89 = toNumber(endDeg)
      if __lux_tmp_endDeg_89 == nil then
        __lux_tmp_endDeg_89 = 360
      end
      return w, h, mathMax(0, __lux_tmp_innerRadius_86), mathMax(0.001, __lux_tmp_outerRadius_87), mathRad(__lux_tmp_startDeg_88), mathRad(__lux_tmp_endDeg_89), ringModeValue(mode)
    end
    ringFillParams = function(fill)
      local __lux_match_90 = fill
      local __lux_tag_91
      if __lux_match_90 ~= nil then
        __lux_tag_91 = __lux_match_90.kind
      end
      if __lux_tag_91 == style.FILL_LINEAR then
        local x1 = __lux_match_90.x1
        local y1 = __lux_match_90.y1
        local x2 = __lux_match_90.x2
        local y2 = __lux_match_90.y2
        local __lux_tmp_x1_92 = x1
        if __lux_tmp_x1_92 == nil then
          __lux_tmp_x1_92 = 0
        end
        local __lux_tmp_y1_93 = y1
        if __lux_tmp_y1_93 == nil then
          __lux_tmp_y1_93 = 0
        end
        local __lux_tmp_x2_94 = x2
        if __lux_tmp_x2_94 == nil then
          __lux_tmp_x2_94 = 1
        end
        local __lux_tmp_y2_95 = y2
        if __lux_tmp_y2_95 == nil then
          __lux_tmp_y2_95 = 0
        end
        return __lux_tmp_x1_92, __lux_tmp_y1_93, __lux_tmp_x2_94, __lux_tmp_y2_95
      elseif __lux_tag_91 == style.FILL_RADIAL then
        local cx = __lux_match_90.cx
        local cy = __lux_match_90.cy
        local radius = __lux_match_90.radius
        local localRadial = fill.localRadial == true or fill.ringRadial == true or fill.sectorRadial == true
        local __lux_tmp_cx_96 = cx
        if __lux_tmp_cx_96 == nil then
          __lux_tmp_cx_96 = 0.5
        end
        local __lux_tmp_cy_97 = cy
        if __lux_tmp_cy_97 == nil then
          __lux_tmp_cy_97 = 0.5
        end
        local __lux_tmp_radius_98 = radius
        if __lux_tmp_radius_98 == nil then
          __lux_tmp_radius_98 = 0.5
        end
        local __lux_tmp_99
        if localRadial then
          __lux_tmp_99 = 1
        else
          __lux_tmp_99 = 0
        end
        return __lux_tmp_cx_96, __lux_tmp_cy_97, __lux_tmp_radius_98, __lux_tmp_99
      elseif __lux_tag_91 == style.FILL_CONIC then
        local cx = __lux_match_90.cx
        local cy = __lux_match_90.cy
        local rotation = __lux_match_90.rotation
        local localAngular = fill.localAngular == true or fill.shapeAngular == true
        local __lux_tmp_cx_100 = cx
        if __lux_tmp_cx_100 == nil then
          __lux_tmp_cx_100 = 0.5
        end
        local __lux_tmp_cy_101 = cy
        if __lux_tmp_cy_101 == nil then
          __lux_tmp_cy_101 = 0.5
        end
        local __lux_tmp_102
        if localAngular then
          __lux_tmp_102 = 1
        else
          __lux_tmp_102 = 0
        end
        return __lux_tmp_cx_100, __lux_tmp_cy_101, style.normalizedRotation(rotation), __lux_tmp_102
      else
        local __lux_unused_103 = nil
      end
      return 0, 0, 1, 0
    end
    ringFillNeedsLut = function(fill)
      local __lux_match_104 = fill
      local __lux_tag_105
      if __lux_match_104 ~= nil then
        __lux_tag_105 = __lux_match_104.kind
      end
      if __lux_tag_105 == style.FILL_LINEAR or __lux_tag_105 == style.FILL_RADIAL or __lux_tag_105 == style.FILL_CONIC then
        return true
      else
        return false
      end
    end
    ringLineStyle = function(width, fill, drawStyle)
      local __lux_obj_drawStyle_106 = drawStyle
      local __lux_val_outerGlow_107 = nil
      if __lux_obj_drawStyle_106 ~= nil then
        __lux_val_outerGlow_107 = __lux_obj_drawStyle_106.outerGlow
      end
      local __lux_obj_drawStyle_108 = drawStyle
      local __lux_val_backdrop_109 = nil
      if __lux_obj_drawStyle_108 ~= nil then
        __lux_val_backdrop_109 = __lux_obj_drawStyle_108.backdrop
      end
      return {
        width = width,
        fill = fill,
        noCaps = false,
        outerGlow = __lux_val_outerGlow_107,
        backdrop = __lux_val_backdrop_109,
      }
    end
    drawRingFallback = function(cx, cy, outerRadius, arcWidth, startDeg, endDeg, mode, drawStyle)
      local fill = drawStyle.fill
      if fill == nil then
        fill = drawStyle.color
        if fill == nil then
          fill = defaultRingFill
        end
      end
      local segments
      do
        local __lux_tmp_segments_110 = drawStyle.segments
        if __lux_tmp_segments_110 == nil then
          __lux_tmp_segments_110 = 64
        end
        segments = arcSegmentCount(outerRadius, startDeg, endDeg, __lux_tmp_segments_110)
      end
      local startRad
      do
        local __lux_tmp_startDeg_111 = startDeg
        if __lux_tmp_startDeg_111 == nil then
          __lux_tmp_startDeg_111 = 0
        end
        startRad = mathRad(__lux_tmp_startDeg_111)
      end
      local endRad
      do
        local __lux_tmp_endDeg_112 = endDeg
        if __lux_tmp_endDeg_112 == nil then
          __lux_tmp_endDeg_112 = 360
        end
        endRad = mathRad(__lux_tmp_endDeg_112)
      end
      if mode == 2 then
        local innerRadius
        do
          local __lux_tmp_innerRadius_113 = toNumber(drawStyle.innerRadius)
          if __lux_tmp_innerRadius_113 == nil then
            __lux_tmp_innerRadius_113 = mathMax(0, outerRadius - arcWidth)
          end
          innerRadius = mathClamp(__lux_tmp_innerRadius_113, 0, outerRadius)
        end
        local points = {}
        for index = 1, segments + 1 do
          local t = (index - 1) / segments
          local angle = startRad + (endRad - startRad) * t
          points[#points + 1] = { x = cx + mathCos(angle) * outerRadius, y = cy + mathSin(angle) * outerRadius }
        end
        for index = segments + 1, 1, -1 do
          local t = (index - 1) / segments
          local angle = startRad + (endRad - startRad) * t
          points[#points + 1] = { x = cx + mathCos(angle) * innerRadius, y = cy + mathSin(angle) * innerRadius }
        end
        return primitives.polyEx(points, drawStyle)
      end
      for index = 1, segments do
        local t1 = (index - 1) / segments
        local t2 = index / segments
        local a1 = startRad + (endRad - startRad) * t1
        local a2 = startRad + (endRad - startRad) * t2
        primitives.lineEx(
          cx + mathCos(a1) * outerRadius,
          cy + mathSin(a1) * outerRadius,
          cx + mathCos(a2) * outerRadius,
          cy + mathSin(a2) * outerRadius,
          ringLineStyle(arcWidth, fill, drawStyle)
        )
      end
    end
    drawRingFillPass = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, fill)
      if not style.fillVisible(fill) or not shadersActive() or not materialOK(widgetMaterials.ring) then
        return false
      end
      local material = widgetMaterials.ring
      local colorB = fill.colorB
      if colorB == nil then
        colorB = fill.colorA
        if colorB == nil then
          colorB = color_white
        end
      end
      local r, g, b, a = style.color01(colorB)
      local sw, sh, ir, orad, sr, er, modeValue = ringShapeConstants(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      local p0, p1, p2, p3 = ringFillParams(fill)
      do
        local __lux_tmp_kind_114 = fill.kind
        if __lux_tmp_kind_114 == nil then
          __lux_tmp_kind_114 = style.FILL_SOLID
        end
        setupParamMatrix(
          material,
          r,
          g,
          b,
          a,
          sw,
          sh,
          ir,
          orad,
          sr,
          er,
          modeValue,
          __lux_tmp_kind_114,
          p0,
          p1,
          p2,
          p3
        )
      end
      if ringFillNeedsLut(fill) then
        style.bindGradientLut(material, fill)
      end
      do
        local __lux_tmp_colorA_115 = fill.colorA
        if __lux_tmp_colorA_115 == nil then
          __lux_tmp_colorA_115 = color_white
        end
        style.setDrawColor(__lux_tmp_colorA_115)
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    drawRingStrokePass = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, stroke, strokeWidth)
      local width = style.strokeWidth(strokeWidth, 0)
      if not style.strokeVisible(stroke, width) or not shadersActive() or not materialOK(widgetMaterials.ring_stroke) then
        return false
      end
      local material = widgetMaterials.ring_stroke
      local r, g, b, a = style.color01(stroke)
      local sw, sh, ir, orad, sr, er, modeValue = ringShapeConstants(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      setupParamMatrix(
        material,
        r,
        g,
        b,
        a,
        sw,
        sh,
        ir,
        orad,
        sr,
        er,
        modeValue,
        mathMax(0, width),
        0,
        0,
        0,
        0
      )
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    drawRingFxPass = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, fill, stroke, strokeWidth, innerSpec)
      local width = style.strokeWidth(strokeWidth, 0)
      local hasStroke = style.strokeVisible(stroke, width)
      local gr = 0
      local gg = 0
      local gb = 0
      local ga = 0
      local glowWidth = 0
      local glowStrength = 0
      local glowFalloff = 1
      local hasGlow = false
      if innerSpec ~= nil then
        do
          local __lux_tmp_color_116 = innerSpec.color
          if __lux_tmp_color_116 == nil then
            __lux_tmp_color_116 = transparentColor
          end
          gr, gg, gb, ga = style.color01(__lux_tmp_color_116)
        end
        do
          local __lux_tmp_width_117 = toNumber(innerSpec.width)
          if __lux_tmp_width_117 == nil then
            __lux_tmp_width_117 = 8
          end
          glowWidth = mathMax(0.001, __lux_tmp_width_117)
        end
        do
          local __lux_tmp_strength_118 = toNumber(innerSpec.strength)
          if __lux_tmp_strength_118 == nil then
            __lux_tmp_strength_118 = 1
          end
          glowStrength = mathMax(0, __lux_tmp_strength_118)
        end
        do
          local __lux_tmp_falloff_119 = toNumber(innerSpec.falloff)
          if __lux_tmp_falloff_119 == nil then
            __lux_tmp_falloff_119 = 1.65
          end
          glowFalloff = mathMax(0.001, __lux_tmp_falloff_119)
        end
        hasGlow = ga > 0 and glowWidth > 0 and glowStrength > 0
      end
      if not hasStroke and not hasGlow or not shadersActive() or not materialOK(widgetMaterials.ring_fx) then
        return false
      end
      local material = widgetMaterials.ring_fx
      local colorB = fill.colorB
      if colorB == nil then
        colorB = fill.colorA
        if colorB == nil then
          colorB = color_white
        end
      end
      local r, g, b, a = style.color01(colorB)
      local sw, sh, ir, orad, sr, er, modeValue = ringShapeConstants(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      local p0, p1, p2, p3 = ringFillParams(fill)
      do
        local __lux_tmp_kind_120 = fill.kind
        if __lux_tmp_kind_120 == nil then
          __lux_tmp_kind_120 = style.FILL_SOLID
        end
        setupParamMatrix(
          material,
          r,
          g,
          b,
          a,
          sw,
          sh,
          ir,
          orad,
          sr,
          er,
          modeValue,
          __lux_tmp_kind_120,
          p0,
          p1,
          p2,
          p3
        )
      end
      if ringFillNeedsLut(fill) then
        style.bindGradientLut(material, fill)
      end
      local sr0 = 0
      local sg0 = 0
      local sb0 = 0
      local sa0 = 0
      if hasStroke then
        sr0, sg0, sb0, sa0 = style.color01(stroke)
      end
      setupAuxConstants(
        material,
        sr0,
        sg0,
        sb0,
        sa0,
        mathMax(0, width),
        glowWidth,
        glowStrength,
        glowFalloff,
        gr,
        gg,
        gb,
        ga
      )
      do
        local __lux_tmp_colorA_121 = fill.colorA
        if __lux_tmp_colorA_121 == nil then
          __lux_tmp_colorA_121 = color_white
        end
        style.setDrawColor(__lux_tmp_colorA_121)
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    drawRingInnerGlowPass = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, spec)
      if spec == nil or not shadersActive() or not materialOK(widgetMaterials.ring_innerglow) then
        return false
      end
      local color = spec.color
      local __lux_tmp_124 = color == nil
      if not __lux_tmp_124 then
        local __lux_tmp_a_123 = color.a
        if __lux_tmp_a_123 == nil then
          __lux_tmp_a_123 = 255
        end
        __lux_tmp_124 = __lux_tmp_a_123 <= 0
      end
      if __lux_tmp_124 then
        return false
      end
      local material = widgetMaterials.ring_innerglow
      local r, g, b, a = style.color01(color)
      local sw, sh, ir, orad, sr, er, modeValue = ringShapeConstants(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      do
        local __lux_tmp_width_125 = toNumber(spec.width)
        if __lux_tmp_width_125 == nil then
          __lux_tmp_width_125 = 8
        end
        local __lux_tmp_strength_126 = toNumber(spec.strength)
        if __lux_tmp_strength_126 == nil then
          __lux_tmp_strength_126 = 1
        end
        local __lux_tmp_falloff_127 = toNumber(spec.falloff)
        if __lux_tmp_falloff_127 == nil then
          __lux_tmp_falloff_127 = 1.65
        end
        setupParamMatrix(
          material,
          r,
          g,
          b,
          a,
          sw,
          sh,
          ir,
          orad,
          sr,
          er,
          modeValue,
          mathMax(0.001, __lux_tmp_width_125),
          mathMax(0, __lux_tmp_strength_126),
          mathMax(0.001, __lux_tmp_falloff_127),
          0,
          0
        )
      end
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    ringEffectBounds = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, spec, biasOffset)
      if biasOffset == nil then
        biasOffset = false
      end
      local __lux_tmp_130 = spec == nil or spec.color == nil
      if not __lux_tmp_130 then
        local __lux_tmp_a_129 = spec.color.a
        if __lux_tmp_a_129 == nil then
          __lux_tmp_a_129 = 255
        end
        __lux_tmp_130 = __lux_tmp_a_129 <= 0
      end
      if __lux_tmp_130 then
        return nil
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
      local gx = x + ox - grow
      local gy = y + oy - grow
      local gw = w + grow * 2
      local gh = h + grow * 2
      local gi
      do
        local __lux_tmp_innerRadius_135 = toNumber(innerRadius)
        if __lux_tmp_innerRadius_135 == nil then
          __lux_tmp_innerRadius_135 = 0
        end
        gi = mathMax(0, __lux_tmp_innerRadius_135 - grow)
      end
      local go
      do
        local __lux_tmp_outerRadius_136 = toNumber(outerRadius)
        if __lux_tmp_outerRadius_136 == nil then
          __lux_tmp_outerRadius_136 = mathMin(w, h) * 0.5
        end
        go = mathMax(0.001, __lux_tmp_outerRadius_136 + grow)
      end
      local spread = roundrect.effectExtentFromSpec(spec, 18)
      if biasOffset then
        local left, top, right, bottom = roundrect.glowBiasPads(spread, ox, oy)
        local __lux_tmp_startDeg_137 = toNumber(startDeg)
        if __lux_tmp_startDeg_137 == nil then
          __lux_tmp_startDeg_137 = 0
        end
        local __lux_tmp_endDeg_138 = toNumber(endDeg)
        if __lux_tmp_endDeg_138 == nil then
          __lux_tmp_endDeg_138 = 360
        end
        local __lux_tmp_width_139 = toNumber(spec.width)
        if __lux_tmp_width_139 == nil then
          __lux_tmp_width_139 = 18
        end
        local __lux_tmp_strength_140 = toNumber(spec.strength)
        if __lux_tmp_strength_140 == nil then
          __lux_tmp_strength_140 = 1
        end
        local __lux_tmp_falloff_141 = toNumber(spec.falloff)
        if __lux_tmp_falloff_141 == nil then
          __lux_tmp_falloff_141 = 1.9
        end
        return {
          x = x - grow - left,
          y = y - grow - top,
          w = gw + left + right,
          h = gh + top + bottom,
          shapeX = left,
          shapeY = top,
          inner = gi,
          outer = go,
          start = mathRad(__lux_tmp_startDeg_137),
          finish = mathRad(__lux_tmp_endDeg_138),
          mode = ringModeValue(mode),
          width = mathMax(0.001, __lux_tmp_width_139),
          strength = mathMax(0, __lux_tmp_strength_140),
          falloff = mathMax(0.001, __lux_tmp_falloff_141),
        }
      end
      local __lux_tmp_startDeg_142 = toNumber(startDeg)
      if __lux_tmp_startDeg_142 == nil then
        __lux_tmp_startDeg_142 = 0
      end
      local __lux_tmp_endDeg_143 = toNumber(endDeg)
      if __lux_tmp_endDeg_143 == nil then
        __lux_tmp_endDeg_143 = 360
      end
      local __lux_tmp_width_144 = toNumber(spec.width)
      if __lux_tmp_width_144 == nil then
        __lux_tmp_width_144 = 18
      end
      local __lux_tmp_strength_145 = toNumber(spec.strength)
      if __lux_tmp_strength_145 == nil then
        __lux_tmp_strength_145 = 1
      end
      local __lux_tmp_falloff_146 = toNumber(spec.falloff)
      if __lux_tmp_falloff_146 == nil then
        __lux_tmp_falloff_146 = 1.9
      end
      return {
        x = gx - spread,
        y = gy - spread,
        w = gw + spread * 2,
        h = gh + spread * 2,
        shapeX = spread,
        shapeY = spread,
        inner = gi,
        outer = go,
        start = mathRad(__lux_tmp_startDeg_142),
        finish = mathRad(__lux_tmp_endDeg_143),
        mode = ringModeValue(mode),
        width = mathMax(0.001, __lux_tmp_width_144),
        strength = mathMax(0, __lux_tmp_strength_145),
        falloff = mathMax(0.001, __lux_tmp_falloff_146),
      }
    end
    drawRingShadowOuterPass = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, shadowSpec, outerSpec)
      if shadowSpec == nil and outerSpec == nil or not shadersActive() or not materialOK(widgetMaterials.ring_shadow_outer) then
        return false
      end
      local shadowBounds = ringEffectBounds(
        x,
        y,
        w,
        h,
        innerRadius,
        outerRadius,
        startDeg,
        endDeg,
        mode,
        shadowSpec,
        false
      )
      local outerBounds = ringEffectBounds(
        x,
        y,
        w,
        h,
        innerRadius,
        outerRadius,
        startDeg,
        endDeg,
        mode,
        outerSpec,
        false
      )
      if shadowBounds == nil and outerBounds == nil then
        return false
      end
      local baseBounds = shadowBounds
      if baseBounds == nil then
        baseBounds = outerBounds
      end
      local sx = baseBounds.x
      local sy = baseBounds.y
      local ex = baseBounds.x + baseBounds.w
      local ey = baseBounds.y + baseBounds.h
      if shadowBounds ~= nil then
        sx = mathMin(sx, shadowBounds.x)
        sy = mathMin(sy, shadowBounds.y)
        ex = mathMax(ex, shadowBounds.x + shadowBounds.w)
        ey = mathMax(ey, shadowBounds.y + shadowBounds.h)
      end
      if outerBounds ~= nil then
        sx = mathMin(sx, outerBounds.x)
        sy = mathMin(sy, outerBounds.y)
        ex = mathMax(ex, outerBounds.x + outerBounds.w)
        ey = mathMax(ey, outerBounds.y + outerBounds.h)
      end
      local drawW = ex - sx
      local drawH = ey - sy
      local shadowColor
      do
        local __lux_obj_shadowSpec_147 = shadowSpec
        local __lux_val_color_148 = nil
        if __lux_obj_shadowSpec_147 ~= nil then
          __lux_val_color_148 = __lux_obj_shadowSpec_147.color
        end
        shadowColor = __lux_val_color_148
        if shadowColor == nil then
          shadowColor = transparentColor
        end
      end
      local outerColor
      do
        local __lux_obj_outerSpec_149 = outerSpec
        local __lux_val_color_150 = nil
        if __lux_obj_outerSpec_149 ~= nil then
          __lux_val_color_150 = __lux_obj_outerSpec_149.color
        end
        outerColor = __lux_val_color_150
        if outerColor == nil then
          outerColor = transparentColor
        end
      end
      local material = widgetMaterials.ring_shadow_outer
      do
        local __lux_tmp_r_151 = shadowColor.r
        if __lux_tmp_r_151 == nil then
          __lux_tmp_r_151 = 0
        end
        local __lux_tmp_g_152 = shadowColor.g
        if __lux_tmp_g_152 == nil then
          __lux_tmp_g_152 = 0
        end
        local __lux_tmp_b_153 = shadowColor.b
        if __lux_tmp_b_153 == nil then
          __lux_tmp_b_153 = 0
        end
        local __lux_tmp_154
        if shadowBounds ~= nil then
          do
            local __lux_tmp_a_155 = shadowColor.a
            if __lux_tmp_a_155 == nil then
              __lux_tmp_a_155 = 255
            end
            __lux_tmp_154 = __lux_tmp_a_155 / 255
          end
        else
          __lux_tmp_154 = 0
        end
        local __lux_obj_shadowBounds_156 = shadowBounds
        local __lux_tmp_x_157 = nil
        if __lux_obj_shadowBounds_156 ~= nil then
          __lux_tmp_x_157 = __lux_obj_shadowBounds_156.x
        end
        if __lux_tmp_x_157 == nil then
          __lux_tmp_x_157 = x
        end
        local __lux_obj_shadowBounds_158 = shadowBounds
        local __lux_tmp_shapeX_159 = nil
        if __lux_obj_shadowBounds_158 ~= nil then
          __lux_tmp_shapeX_159 = __lux_obj_shadowBounds_158.shapeX
        end
        if __lux_tmp_shapeX_159 == nil then
          __lux_tmp_shapeX_159 = 0
        end
        local __lux_obj_shadowBounds_160 = shadowBounds
        local __lux_tmp_outer_161 = nil
        if __lux_obj_shadowBounds_160 ~= nil then
          __lux_tmp_outer_161 = __lux_obj_shadowBounds_160.outer
        end
        if __lux_tmp_outer_161 == nil then
          __lux_tmp_outer_161 = 0
        end
        local __lux_obj_shadowBounds_162 = shadowBounds
        local __lux_tmp_y_163 = nil
        if __lux_obj_shadowBounds_162 ~= nil then
          __lux_tmp_y_163 = __lux_obj_shadowBounds_162.y
        end
        if __lux_tmp_y_163 == nil then
          __lux_tmp_y_163 = y
        end
        local __lux_obj_shadowBounds_164 = shadowBounds
        local __lux_tmp_shapeY_165 = nil
        if __lux_obj_shadowBounds_164 ~= nil then
          __lux_tmp_shapeY_165 = __lux_obj_shadowBounds_164.shapeY
        end
        if __lux_tmp_shapeY_165 == nil then
          __lux_tmp_shapeY_165 = 0
        end
        local __lux_obj_shadowBounds_166 = shadowBounds
        local __lux_tmp_outer_167 = nil
        if __lux_obj_shadowBounds_166 ~= nil then
          __lux_tmp_outer_167 = __lux_obj_shadowBounds_166.outer
        end
        if __lux_tmp_outer_167 == nil then
          __lux_tmp_outer_167 = 0
        end
        local __lux_obj_shadowBounds_168 = shadowBounds
        local __lux_tmp_inner_169 = nil
        if __lux_obj_shadowBounds_168 ~= nil then
          __lux_tmp_inner_169 = __lux_obj_shadowBounds_168.inner
        end
        if __lux_tmp_inner_169 == nil then
          __lux_tmp_inner_169 = 0
        end
        local __lux_obj_shadowBounds_170 = shadowBounds
        local __lux_tmp_outer_171 = nil
        if __lux_obj_shadowBounds_170 ~= nil then
          __lux_tmp_outer_171 = __lux_obj_shadowBounds_170.outer
        end
        if __lux_tmp_outer_171 == nil then
          __lux_tmp_outer_171 = 1
        end
        local __lux_obj_shadowBounds_172 = shadowBounds
        local __lux_tmp_start_173 = nil
        if __lux_obj_shadowBounds_172 ~= nil then
          __lux_tmp_start_173 = __lux_obj_shadowBounds_172.start
        end
        if __lux_tmp_start_173 == nil then
          __lux_tmp_start_173 = 0
        end
        local __lux_obj_shadowBounds_174 = shadowBounds
        local __lux_tmp_finish_175 = nil
        if __lux_obj_shadowBounds_174 ~= nil then
          __lux_tmp_finish_175 = __lux_obj_shadowBounds_174.finish
        end
        if __lux_tmp_finish_175 == nil then
          __lux_tmp_finish_175 = mathRad(360)
        end
        local __lux_obj_shadowBounds_176 = shadowBounds
        local __lux_tmp_mode_177 = nil
        if __lux_obj_shadowBounds_176 ~= nil then
          __lux_tmp_mode_177 = __lux_obj_shadowBounds_176.mode
        end
        if __lux_tmp_mode_177 == nil then
          __lux_tmp_mode_177 = 0
        end
        local __lux_tmp_178
        if shadowBounds ~= nil then
          __lux_tmp_178 = shadowBounds.width
        else
          __lux_tmp_178 = 1
        end
        setupParamMatrix(
          material,
          drawW,
          drawH,
          0,
          0,
          __lux_tmp_r_151 / 255,
          __lux_tmp_g_152 / 255,
          __lux_tmp_b_153 / 255,
          __lux_tmp_154,
          __lux_tmp_x_157 + __lux_tmp_shapeX_159 + __lux_tmp_outer_161 - sx,
          __lux_tmp_y_163 + __lux_tmp_shapeY_165 + __lux_tmp_outer_167 - sy,
          __lux_tmp_inner_169,
          __lux_tmp_outer_171,
          __lux_tmp_start_173,
          __lux_tmp_finish_175,
          __lux_tmp_mode_177,
          __lux_tmp_178
        )
      end
      do
        local __lux_tmp_r_179 = outerColor.r
        if __lux_tmp_r_179 == nil then
          __lux_tmp_r_179 = 0
        end
        local __lux_tmp_g_180 = outerColor.g
        if __lux_tmp_g_180 == nil then
          __lux_tmp_g_180 = 0
        end
        local __lux_tmp_b_181 = outerColor.b
        if __lux_tmp_b_181 == nil then
          __lux_tmp_b_181 = 0
        end
        local __lux_tmp_182
        if outerBounds ~= nil then
          do
            local __lux_tmp_a_183 = outerColor.a
            if __lux_tmp_a_183 == nil then
              __lux_tmp_a_183 = 255
            end
            __lux_tmp_182 = __lux_tmp_a_183 / 255
          end
        else
          __lux_tmp_182 = 0
        end
        local __lux_obj_outerBounds_184 = outerBounds
        local __lux_tmp_x_185 = nil
        if __lux_obj_outerBounds_184 ~= nil then
          __lux_tmp_x_185 = __lux_obj_outerBounds_184.x
        end
        if __lux_tmp_x_185 == nil then
          __lux_tmp_x_185 = x
        end
        local __lux_obj_outerBounds_186 = outerBounds
        local __lux_tmp_shapeX_187 = nil
        if __lux_obj_outerBounds_186 ~= nil then
          __lux_tmp_shapeX_187 = __lux_obj_outerBounds_186.shapeX
        end
        if __lux_tmp_shapeX_187 == nil then
          __lux_tmp_shapeX_187 = 0
        end
        local __lux_obj_outerBounds_188 = outerBounds
        local __lux_tmp_outer_189 = nil
        if __lux_obj_outerBounds_188 ~= nil then
          __lux_tmp_outer_189 = __lux_obj_outerBounds_188.outer
        end
        if __lux_tmp_outer_189 == nil then
          __lux_tmp_outer_189 = 0
        end
        local __lux_obj_outerBounds_190 = outerBounds
        local __lux_tmp_y_191 = nil
        if __lux_obj_outerBounds_190 ~= nil then
          __lux_tmp_y_191 = __lux_obj_outerBounds_190.y
        end
        if __lux_tmp_y_191 == nil then
          __lux_tmp_y_191 = y
        end
        local __lux_obj_outerBounds_192 = outerBounds
        local __lux_tmp_shapeY_193 = nil
        if __lux_obj_outerBounds_192 ~= nil then
          __lux_tmp_shapeY_193 = __lux_obj_outerBounds_192.shapeY
        end
        if __lux_tmp_shapeY_193 == nil then
          __lux_tmp_shapeY_193 = 0
        end
        local __lux_obj_outerBounds_194 = outerBounds
        local __lux_tmp_outer_195 = nil
        if __lux_obj_outerBounds_194 ~= nil then
          __lux_tmp_outer_195 = __lux_obj_outerBounds_194.outer
        end
        if __lux_tmp_outer_195 == nil then
          __lux_tmp_outer_195 = 0
        end
        local __lux_obj_outerBounds_196 = outerBounds
        local __lux_tmp_inner_197 = nil
        if __lux_obj_outerBounds_196 ~= nil then
          __lux_tmp_inner_197 = __lux_obj_outerBounds_196.inner
        end
        if __lux_tmp_inner_197 == nil then
          __lux_tmp_inner_197 = 0
        end
        local __lux_obj_outerBounds_198 = outerBounds
        local __lux_tmp_outer_199 = nil
        if __lux_obj_outerBounds_198 ~= nil then
          __lux_tmp_outer_199 = __lux_obj_outerBounds_198.outer
        end
        if __lux_tmp_outer_199 == nil then
          __lux_tmp_outer_199 = 1
        end
        local __lux_obj_outerBounds_200 = outerBounds
        local __lux_tmp_start_201 = nil
        if __lux_obj_outerBounds_200 ~= nil then
          __lux_tmp_start_201 = __lux_obj_outerBounds_200.start
        end
        if __lux_tmp_start_201 == nil then
          __lux_tmp_start_201 = 0
        end
        local __lux_obj_outerBounds_202 = outerBounds
        local __lux_tmp_finish_203 = nil
        if __lux_obj_outerBounds_202 ~= nil then
          __lux_tmp_finish_203 = __lux_obj_outerBounds_202.finish
        end
        if __lux_tmp_finish_203 == nil then
          __lux_tmp_finish_203 = mathRad(360)
        end
        local __lux_obj_outerBounds_204 = outerBounds
        local __lux_tmp_mode_205 = nil
        if __lux_obj_outerBounds_204 ~= nil then
          __lux_tmp_mode_205 = __lux_obj_outerBounds_204.mode
        end
        if __lux_tmp_mode_205 == nil then
          __lux_tmp_mode_205 = 0
        end
        local __lux_tmp_206
        if outerBounds ~= nil then
          __lux_tmp_206 = outerBounds.width
        else
          __lux_tmp_206 = 1
        end
        local __lux_tmp_207
        if shadowBounds ~= nil then
          __lux_tmp_207 = shadowBounds.falloff
        else
          __lux_tmp_207 = 1
        end
        local __lux_tmp_208
        if shadowBounds ~= nil then
          __lux_tmp_208 = shadowBounds.strength
        else
          __lux_tmp_208 = 0
        end
        local __lux_tmp_209
        if outerBounds ~= nil then
          __lux_tmp_209 = outerBounds.falloff
        else
          __lux_tmp_209 = 1
        end
        local __lux_tmp_210
        if outerBounds ~= nil then
          __lux_tmp_210 = outerBounds.strength
        else
          __lux_tmp_210 = 0
        end
        setupAuxConstants(
          material,
          __lux_tmp_r_179 / 255,
          __lux_tmp_g_180 / 255,
          __lux_tmp_b_181 / 255,
          __lux_tmp_182,
          __lux_tmp_x_185 + __lux_tmp_shapeX_187 + __lux_tmp_outer_189 - sx,
          __lux_tmp_y_191 + __lux_tmp_shapeY_193 + __lux_tmp_outer_195 - sy,
          __lux_tmp_inner_197,
          __lux_tmp_outer_199,
          __lux_tmp_start_201,
          __lux_tmp_finish_203,
          __lux_tmp_mode_205,
          __lux_tmp_206,
          __lux_tmp_207,
          __lux_tmp_208,
          __lux_tmp_209,
          __lux_tmp_210
        )
      end
      local bleedLeft, bleedTop, bleedRight, bleedBottom = effectBleedFromDrawRect(x, y, w, h, sx, sy, drawW, drawH)
      local bleedToken = beginPanelEffectBleed(bleedLeft, bleedTop, bleedRight, bleedBottom)
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(sx, sy, drawW, drawH, material)
      endPanelEffectBleed(bleedToken)
      return true
    end
    ringBackdropTintColor = function(spec)
      if spec == nil or spec.tint == nil then
        return nil
      end
      local tint = spec.tint
      local alpha
      do
        local __lux_tmp_a_211 = tint.a
        if __lux_tmp_a_211 == nil then
          __lux_tmp_a_211 = 255
        end
        local __lux_tmp_opacity_212 = spec.opacity
        if __lux_tmp_opacity_212 == nil then
          __lux_tmp_opacity_212 = 1
        end
        alpha = __lux_tmp_a_211 * __lux_tmp_opacity_212
      end
      if alpha <= 0 then
        return nil
      end
      local __lux_tmp_r_213 = tint.r
      if __lux_tmp_r_213 == nil then
        __lux_tmp_r_213 = 0
      end
      local __lux_tmp_g_214 = tint.g
      if __lux_tmp_g_214 == nil then
        __lux_tmp_g_214 = 0
      end
      local __lux_tmp_b_215 = tint.b
      if __lux_tmp_b_215 == nil then
        __lux_tmp_b_215 = 0
      end
      return makeColor(
        __lux_tmp_r_213,
        __lux_tmp_g_214,
        __lux_tmp_b_215,
        mathFloor(mathClamp(alpha, 0, 255) + 0.5)
      )
    end
    setupRingBackdropConstants = function(material, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, vertical, intensity)
      local sw, sh, ir, orad, sr, er, modeValue = ringShapeConstants(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      local __lux_tmp_intensity_216 = intensity
      if __lux_tmp_intensity_216 == nil then
        __lux_tmp_intensity_216 = 1
      end
      return setupParamMatrix(
        material,
        vertical and 1 or 0,
        __lux_tmp_intensity_216,
        0,
        0,
        sw,
        sh,
        ir,
        orad,
        sr,
        er,
        modeValue,
        0,
        0,
        0,
        0,
        0
      )
    end
    drawRingBackdropPass = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, backdrop)
      local spec = style.backdropStyle(backdrop)
      if spec == nil then
        return nil
      end
      local pad
      do
        local __lux_tmp_padding_217 = toNumber(spec.padding)
        if __lux_tmp_padding_217 == nil then
          __lux_tmp_padding_217 = 0
        end
        pad = mathMax(0, __lux_tmp_padding_217)
      end
      local bx = x - pad
      local by = y - pad
      local bw = w + pad * 2
      local bh = h + pad * 2
      local bi
      do
        local __lux_tmp_innerRadius_218 = toNumber(innerRadius)
        if __lux_tmp_innerRadius_218 == nil then
          __lux_tmp_innerRadius_218 = 0
        end
        bi = mathMax(0, __lux_tmp_innerRadius_218 - pad)
      end
      local bo
      do
        local __lux_tmp_outerRadius_219 = toNumber(outerRadius)
        if __lux_tmp_outerRadius_219 == nil then
          __lux_tmp_outerRadius_219 = mathMin(w, h) * 0.5
        end
        bo = mathMax(0.001, __lux_tmp_outerRadius_219 + pad)
      end
      if spec.blur > 0 and widgetBlurRT ~= nil and renderCopyRenderTargetToTexture ~= nil and materialOK(widgetMaterials.ring_backdrop) then
        local material = widgetMaterials.ring_backdrop
        local intensity = blurIntensity(spec.blur)
        surfaceSetMaterial(material)
        surfaceSetDrawColor(255, 255, 255, 255)
        renderCopyRenderTargetToTexture(widgetBlurRT)
        setupRingBackdropConstants(
          material,
          bw,
          bh,
          bi,
          bo,
          startDeg,
          endDeg,
          mode,
          false,
          intensity
        )
        drawTexturedQuad(bx, by, bw, bh, material)
        renderCopyRenderTargetToTexture(widgetBlurRT)
        setupRingBackdropConstants(
          material,
          bw,
          bh,
          bi,
          bo,
          startDeg,
          endDeg,
          mode,
          true,
          intensity
        )
        drawTexturedQuad(bx, by, bw, bh, material)
      end
      local tint = ringBackdropTintColor(spec)
      if tint ~= nil then
        drawRingFillPass(bx, by, bw, bh, bi, bo, startDeg, endDeg, mode, style.solid(tint))
      end
      return spec
    end
    drawRingPatternPass = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, pattern)
      local spec = roundrect.patternStyle(pattern)
      if spec == nil or not shadersActive() or not materialOK(widgetMaterials.ring_pattern) then
        return false
      end
      local material = widgetMaterials.ring_pattern
      local angle
      do
        local __lux_tmp_angle_220 = toNumber(spec.angle)
        if __lux_tmp_angle_220 == nil then
          __lux_tmp_angle_220 = 135
        end
        angle = mathRad(__lux_tmp_angle_220)
      end
      local smoke
      local __lux_match_221 = spec.kind
      if __lux_match_221 == "smoke" then
        smoke = true
      else
        smoke = false
      end
      local pz
      if smoke then
        do
          local __lux_tmp_scale_222 = toNumber(spec.scale)
          if __lux_tmp_scale_222 == nil then
            __lux_tmp_scale_222 = 140
          end
          pz = mathMax(1, __lux_tmp_scale_222)
        end
      else
        do
          local __lux_tmp_spacing_223 = toNumber(spec.spacing)
          if __lux_tmp_spacing_223 == nil then
            __lux_tmp_spacing_223 = 12
          end
          pz = mathMax(1, __lux_tmp_spacing_223)
        end
      end
      local pw
      if smoke then
        do
          local __lux_tmp_density_224 = toNumber(spec.density)
          if __lux_tmp_density_224 == nil then
            __lux_tmp_density_224 = 0.48
          end
          pw = mathClamp(__lux_tmp_density_224, 0, 1)
        end
      else
        do
          local __lux_tmp_width_225 = toNumber(spec.width)
          if __lux_tmp_width_225 == nil then
            __lux_tmp_width_225 = 2
          end
          pw = mathMax(0.25, __lux_tmp_width_225)
        end
      end
      do
        local __lux_tmp_226
        if smoke then
          __lux_tmp_226 = toNumber(spec.seed)
          if __lux_tmp_226 == nil then
            __lux_tmp_226 = 0
          end
        else
          __lux_tmp_226 = 0
        end
        local __lux_tmp_227
        if smoke then
          do
            local __lux_tmp_softness_228 = toNumber(spec.softness)
            if __lux_tmp_softness_228 == nil then
              __lux_tmp_softness_228 = 0.3
            end
            __lux_tmp_227 = mathMax(0.001, __lux_tmp_softness_228)
          end
        else
          __lux_tmp_227 = 0
        end
        local __lux_tmp_229
        if smoke then
          do
            local __lux_tmp_warp_230 = toNumber(spec.warp)
            if __lux_tmp_warp_230 == nil then
              __lux_tmp_warp_230 = 0.85
            end
            __lux_tmp_229 = mathMax(0, __lux_tmp_warp_230)
          end
        else
          __lux_tmp_229 = 0
        end
        local __lux_tmp_innerRadius_231 = toNumber(innerRadius)
        if __lux_tmp_innerRadius_231 == nil then
          __lux_tmp_innerRadius_231 = 0
        end
        local __lux_tmp_outerRadius_232 = toNumber(outerRadius)
        if __lux_tmp_outerRadius_232 == nil then
          __lux_tmp_outerRadius_232 = mathMin(w, h) * 0.5
        end
        local __lux_tmp_startDeg_233 = toNumber(startDeg)
        if __lux_tmp_startDeg_233 == nil then
          __lux_tmp_startDeg_233 = 0
        end
        local __lux_tmp_endDeg_234 = toNumber(endDeg)
        if __lux_tmp_endDeg_234 == nil then
          __lux_tmp_endDeg_234 = 360
        end
        local __lux_tmp_235
        if smoke then
          __lux_tmp_235 = 1
        else
          __lux_tmp_235 = 0
        end
        setupParamMatrix(
          material,
          __lux_tmp_226,
          roundrect.patternOffset(spec),
          __lux_tmp_227,
          __lux_tmp_229,
          w,
          h,
          mathMax(0, __lux_tmp_innerRadius_231),
          mathMax(0.001, __lux_tmp_outerRadius_232),
          mathRad(__lux_tmp_startDeg_233),
          mathRad(__lux_tmp_endDeg_234),
          ringModeValue(mode),
          __lux_tmp_235,
          mathCos(angle),
          mathSin(angle),
          pz,
          pw
        )
      end
      do
        local __lux_tmp_color_236 = spec.color
        if __lux_tmp_color_236 == nil then
          __lux_tmp_color_236 = spec.tint
        end
        if __lux_tmp_color_236 == nil then
          __lux_tmp_color_236 = makeColor(255, 255, 255, 24)
        end
        style.setDrawColor(__lux_tmp_color_236)
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    drawRingBox = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, drawStyle)
      if drawStyle == nil then
        drawStyle = {}
      end
      local fill
      do
        local __lux_tmp_fill_237 = drawStyle.fill
        if __lux_tmp_fill_237 == nil then
          __lux_tmp_fill_237 = drawStyle.color
        end
        if __lux_tmp_fill_237 == nil then
          __lux_tmp_fill_237 = defaultRingFill
        end
        fill = style.fillFromStyle(__lux_tmp_fill_237)
      end
      if not shadersActive() or not materialOK(widgetMaterials.ring) then
        local __lux_table_238 = {}
        local __lux_spread_239 = drawStyle
        if __lux_spread_239 ~= nil then
          for __lux_k_240, __lux_v_241 in pairs(__lux_spread_239) do
            __lux_table_238[__lux_k_240] = __lux_v_241
          end
        end
        __lux_table_238.fill = fill
        __lux_table_238.innerRadius = innerRadius
        return drawRingFallback(
          x + w * 0.5,
          y + h * 0.5,
          outerRadius,
          outerRadius - innerRadius,
          startDeg,
          endDeg,
          mode,
          __lux_table_238
        )
      end
      local shadow = roundrect.shadowStyle(drawStyle.shadow)
      local outer = roundrect.outerGlowStyle(drawStyle.outerGlow)
      if shadow ~= nil or outer ~= nil then
        drawRingShadowOuterPass(
          x,
          y,
          w,
          h,
          innerRadius,
          outerRadius,
          startDeg,
          endDeg,
          mode,
          shadow,
          outer
        )
      end
      if drawStyle.backdrop ~= nil then
        drawRingBackdropPass(
          x,
          y,
          w,
          h,
          innerRadius,
          outerRadius,
          startDeg,
          endDeg,
          mode,
          drawStyle.backdrop
        )
      end
      local inner = roundrect.innerGlowStyle(drawStyle.innerGlow)
      local strokeWidth = style.strokeWidth(drawStyle.strokeWidth, 0)
      local hasStroke = style.strokeVisible(drawStyle.stroke, strokeWidth)
      if drawStyle.pattern == nil and (hasStroke or inner ~= nil) and drawRingFxPass(
        x,
        y,
        w,
        h,
        innerRadius,
        outerRadius,
        startDeg,
        endDeg,
        mode,
        fill,
        drawStyle.stroke,
        strokeWidth,
        inner
      ) then
        return
      end
      drawRingFillPass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, fill)
      if drawStyle.pattern ~= nil then
        drawRingPatternPass(
          x,
          y,
          w,
          h,
          innerRadius,
          outerRadius,
          startDeg,
          endDeg,
          mode,
          drawStyle.pattern
        )
      end
      if inner ~= nil then
        drawRingInnerGlowPass(
          x,
          y,
          w,
          h,
          innerRadius,
          outerRadius,
          startDeg,
          endDeg,
          mode,
          inner
        )
      end
      if hasStroke then
        drawRingStrokePass(
          x,
          y,
          w,
          h,
          innerRadius,
          outerRadius,
          startDeg,
          endDeg,
          mode,
          drawStyle.stroke,
          strokeWidth
        )
      end
    end
    ringEx = function(cx, cy, radius, width, drawStyle)
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local transform, stripped = geometry.splitStyleTransform(resolved)
      local outerRadius
      do
        local __lux_tmp_radius_242 = toNumber(radius)
        if __lux_tmp_radius_242 == nil then
          __lux_tmp_radius_242 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_radius_242)
      end
      local ringWidth
      do
        local __lux_tmp_width_243 = toNumber(width)
        if __lux_tmp_width_243 == nil then
          __lux_tmp_width_243 = mathMax(1, outerRadius * 0.18)
        end
        ringWidth = mathMax(0.001, __lux_tmp_width_243)
      end
      local innerRadius = mathMax(0, outerRadius - ringWidth)
      local x = cx - outerRadius
      local y = cy - outerRadius
      local size = outerRadius * 2
      if transform ~= nil then
        return geometry.withTransform(
          transform,
          x,
          y,
          size,
          size,
          function()
            return drawRingBox(x, y, size, size, innerRadius, outerRadius, 0, 360, 0, stripped)
          end
        )
      end
      return drawRingBox(x, y, size, size, innerRadius, outerRadius, 0, 360, 0, stripped)
    end
    ring = function(cx, cy, radius, width, fill)
      ringStyle.fill = fill
      return ringEx(cx, cy, radius, width, ringStyle)
    end
    arcEx = function(cx, cy, radius, width, startDeg, endDeg, drawStyle)
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local transform, stripped = geometry.splitStyleTransform(resolved)
      local outerRadius
      do
        local __lux_tmp_radius_244 = toNumber(radius)
        if __lux_tmp_radius_244 == nil then
          __lux_tmp_radius_244 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_radius_244)
      end
      local arcWidth
      do
        local __lux_tmp_width_245 = toNumber(width)
        if __lux_tmp_width_245 == nil then
          __lux_tmp_width_245 = mathMax(1, outerRadius * 0.18)
        end
        arcWidth = mathMax(0.001, __lux_tmp_width_245)
      end
      local innerRadius = mathMax(0, outerRadius - arcWidth)
      local x = cx - outerRadius
      local y = cy - outerRadius
      local size = outerRadius * 2
      if transform ~= nil then
        return geometry.withTransform(
          transform,
          x,
          y,
          size,
          size,
          function()
            return drawRingBox(x, y, size, size, innerRadius, outerRadius, startDeg, endDeg, 1, stripped)
          end
        )
      end
      return drawRingBox(x, y, size, size, innerRadius, outerRadius, startDeg, endDeg, 1, stripped)
    end
    arc = function(cx, cy, radius, startDeg, endDeg, width, fill)
      arcStyle.fill = fill
      return arcEx(cx, cy, radius, width, startDeg, endDeg, arcStyle)
    end
    sectorEx = function(cx, cy, innerRadius, outerRadius, startDeg, endDeg, drawStyle)
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local transform, stripped = geometry.splitStyleTransform(resolved)
      do
        local __lux_tmp_outerRadius_246 = toNumber(outerRadius)
        if __lux_tmp_outerRadius_246 == nil then
          __lux_tmp_outerRadius_246 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_outerRadius_246)
      end
      do
        local __lux_tmp_innerRadius_247 = toNumber(innerRadius)
        if __lux_tmp_innerRadius_247 == nil then
          __lux_tmp_innerRadius_247 = 0
        end
        innerRadius = mathClamp(__lux_tmp_innerRadius_247, 0, outerRadius)
      end
      local x = cx - outerRadius
      local y = cy - outerRadius
      local size = outerRadius * 2
      if transform ~= nil then
        return geometry.withTransform(
          transform,
          x,
          y,
          size,
          size,
          function()
            return drawRingBox(x, y, size, size, innerRadius, outerRadius, startDeg, endDeg, 2, stripped)
          end
        )
      end
      return drawRingBox(x, y, size, size, innerRadius, outerRadius, startDeg, endDeg, 2, stripped)
    end
    sector = function(cx, cy, innerRadius, outerRadius, startDeg, endDeg, fill)
      sectorStyle.fill = fill
      return sectorEx(cx, cy, innerRadius, outerRadius, startDeg, endDeg, sectorStyle)
    end
  end
  do
    imageMakeMaterial = Material
    imageCreateMaterial = CreateMaterial
    imageSysTime = SysTime
    imageSourceSerial = 0
    imageMaterialCache = {}
    imageTextureFallbackMaterial = nil
    imageWhiteTexture = nil
    imageTextureSource = function(source)
      if typeOf(source) == "string" then
        local cached = imageMaterialCache[source]
        if cached == nil then
          local material
          if imageMakeMaterial ~= nil then
            material = imageMakeMaterial(source, "smooth noclamp")
          else
            material = nil
          end
          do
            local __lux_tmp_248
            if material ~= nil and material.IsError ~= nil and not material:IsError() then
              __lux_tmp_248 = material
            else
              __lux_tmp_248 = false
            end
            cached = __lux_tmp_248
          end
          imageMaterialCache[source] = cached
        end
        if cached == false then
          return nil, nil
        end
        return cached:GetTexture("$basetexture"), cached
      end
      if source ~= nil and source.GetTexture ~= nil then
        return source:GetTexture("$basetexture"), source
      end
      if source ~= nil and source.GetName ~= nil then
        return source, nil
      end
      return nil, nil
    end
    imageWhiteTextureSource = function()
      if imageWhiteTexture ~= nil then
        return imageWhiteTexture ~= false and imageWhiteTexture or nil
      end
      local texture = imageTextureSource("color/white")
      do
        local __lux_tmp_texture_249 = texture
        if __lux_tmp_texture_249 == nil then
          __lux_tmp_texture_249 = false
        end
        imageWhiteTexture = __lux_tmp_texture_249
      end
      return imageWhiteTexture ~= false and imageWhiteTexture or nil
    end
    imageFallbackMaterialForTexture = function(texture)
      if texture == nil or imageCreateMaterial == nil then
        return nil
      end
      if imageTextureFallbackMaterial == nil then
        imageSourceSerial = imageSourceSerial + 1
        local suffix
        if imageSysTime ~= nil then
          suffix = imageSysTime()
        else
          suffix = imageSourceSerial
        end
        imageTextureFallbackMaterial = imageCreateMaterial(
          "mgfx_texture_fallback_" .. suffix,
          "UnlitGeneric",
          {
            ["$basetexture"] = "color/white",
            ["$translucent"] = "1",
            ["$vertexalpha"] = "1",
            ["$vertexcolor"] = "1",
          }
        )
      end
      imageTextureFallbackMaterial:SetTexture("$basetexture", texture)
      return imageTextureFallbackMaterial
    end
  end
  do
    imageStringLower = string.lower
    imageMaskUsesTexture = function(kind)
      return kind ~= nil and kind >= 10
    end
    imageMaskKindValue = function(mask)
      if typeOf(mask) ~= "table" then
        return nil
      end
      local kind = mask.kind
      if kind == nil then
        kind = mask.shape
      end
      if typeOf(kind) ~= "string" then
        return nil
      end
      kind = imageStringLower(kind)
      local __lux_match_250 = kind
      if __lux_match_250 == "round" or __lux_match_250 == "rounded" or __lux_match_250 == "roundedbox" or __lux_match_250 == "roundrect" then
        return 0
      elseif __lux_match_250 == "chamfer" or __lux_match_250 == "bevel" then
        return 1
      elseif __lux_match_250 == "circle" then
        return 2
      elseif __lux_match_250 == "capsule" or __lux_match_250 == "pill" then
        return 3
      elseif __lux_match_250 == "texture" or __lux_match_250 == "alpha" or __lux_match_250 == "image" then
        return 10
      else
        return nil
      end
    end
    imageMaskTextureChannelKind = function(channel)
      if channel == nil then
        return 10
      end
      local normalized = imageStringLower(tostring(channel))
      local __lux_match_251 = normalized
      if __lux_match_251 == "a" or __lux_match_251 == "alpha" then
        return 10
      elseif __lux_match_251 == "r" or __lux_match_251 == "red" then
        return 11
      elseif __lux_match_251 == "g" or __lux_match_251 == "green" then
        return 12
      elseif __lux_match_251 == "b" or __lux_match_251 == "blue" then
        return 13
      elseif __lux_match_251 == "luma" or __lux_match_251 == "lum" or __lux_match_251 == "luminance" or __lux_match_251 == "rgb" then
        return 14
      else
        return nil
      end
    end
    imageMaskTextureSource = function(mask)
      if typeOf(mask) ~= "table" then
        return nil, nil
      end
      local source = mask.source
      if source == nil then
        source = mask.material
        if source == nil then
          source = mask.texture
          if source == nil then
            source = mask.image
          end
        end
      end
      if source == nil then
        return nil, nil
      end
      return imageTextureSource(source)
    end
    imageMaskTextureUV = function(mask, texture)
      if typeOf(mask) ~= "table" then
        return 0, 0, 1, 1
      end
      if typeOf(mask.uv) == "table" or typeOf(mask.crop) == "table" then
        return geometry.imageUV(mask, texture)
      end
      local u0
      do
        local __lux_tmp_u0_252 = mask.u0
        if __lux_tmp_u0_252 == nil then
          __lux_tmp_u0_252 = mask.x0
        end
        if __lux_tmp_u0_252 == nil then
          __lux_tmp_u0_252 = mask[1]
        end
        u0 = toNumber(__lux_tmp_u0_252)
        if u0 == nil then
          u0 = 0
        end
      end
      local v0
      do
        local __lux_tmp_v0_253 = mask.v0
        if __lux_tmp_v0_253 == nil then
          __lux_tmp_v0_253 = mask.y0
        end
        if __lux_tmp_v0_253 == nil then
          __lux_tmp_v0_253 = mask[2]
        end
        v0 = toNumber(__lux_tmp_v0_253)
        if v0 == nil then
          v0 = 0
        end
      end
      local u1
      do
        local __lux_tmp_u1_254 = mask.u1
        if __lux_tmp_u1_254 == nil then
          __lux_tmp_u1_254 = mask.x1
        end
        if __lux_tmp_u1_254 == nil then
          __lux_tmp_u1_254 = mask[3]
        end
        u1 = toNumber(__lux_tmp_u1_254)
        if u1 == nil then
          u1 = 1
        end
      end
      local v1
      do
        local __lux_tmp_v1_255 = mask.v1
        if __lux_tmp_v1_255 == nil then
          __lux_tmp_v1_255 = mask.y1
        end
        if __lux_tmp_v1_255 == nil then
          __lux_tmp_v1_255 = mask[4]
        end
        v1 = toNumber(__lux_tmp_v1_255)
        if v1 == nil then
          v1 = 1
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
    imageChamferCuts = function(drawStyle, mask)
      if typeOf(drawStyle) ~= "table" then
        return nil
      end
      local resolvedMask = mask
      if resolvedMask == nil then
        resolvedMask = style.imageMaskStyle(drawStyle.mask, drawStyle)
      end
      if typeOf(resolvedMask) ~= "table" then
        return nil
      end
      local __lux_match_256 = resolvedMask
      local __lux_tag_257
      if __lux_match_256 ~= nil then
        __lux_tag_257 = __lux_match_256.kind
      end
      if __lux_tag_257 == "chamfer" then
        local cuts = __lux_match_256.cuts
        local __lux_tmp_cuts_258 = cuts
        if __lux_tmp_cuts_258 == nil then
          __lux_tmp_cuts_258 = 0
        end
        return __lux_tmp_cuts_258
      else
        return nil
      end
    end
    imageChamferMaskTuple = function(mask, w, h)
      local cuts = mask ~= nil and mask.cuts or 0
      return primitives.chamferTuple(cuts, w, h)
    end
    setupImageMaskConstants = function(material, w, h, sourceU0, sourceV0, sourceU1, sourceV1, stroke, strokeWidth, mask, kind, maskTexture, sourceAlphaBase)
      if sourceAlphaBase == nil then
        sourceAlphaBase = false
      end
      local strokeColor = stroke
      if strokeColor == nil then
        strokeColor = transparentColor
      end
      local r, g, b, a = style.color01(strokeColor)
      local strokeR = r
      local strokeG = g
      local strokeB = b
      local strokeA = a
      local packedKind = kind
      if mask ~= nil and (mask.invert or mask.inverse) then
        packedKind = packedKind + 128
      end
      if sourceAlphaBase then
        packedKind = packedKind + 65536
      end
      packedKind = packedKind + mathClamp(mathFloor(style.strokeWidthValue(strokeWidth, 0)), 0, 255) * 256
      local p0 = 0
      local p1 = 0
      local p2 = 0
      local p3 = 0
      if kind == 1 then
        p0, p1, p2, p3 = imageChamferMaskTuple(mask, w, h)
      else
        if imageMaskUsesTexture(kind) then
          p0, p1, p2, p3 = imageMaskTextureUV(mask, maskTexture)
        end
      end
      return setupParamMatrix(
        material,
        strokeR,
        strokeG,
        strokeB,
        strokeA,
        w,
        h,
        packedKind,
        mask ~= nil and geometry.imageRadius(mask.radius, w, h) or 0,
        sourceU0,
        sourceV0,
        sourceU1,
        sourceV1,
        p0,
        p1,
        p2,
        p3
      )
    end
    drawImageMaskPass = function(x, y, w, h, texture, u0, v0, u1, v1, tint, stroke, strokeWidth, mask, kind, maskTexture, sourceAlphaBase)
      if sourceAlphaBase == nil then
        sourceAlphaBase = false
      end
      if texture == nil or not materialOK(widgetMaterials.image_mask) then
        return false
      end
      local material = widgetMaterials.image_mask
      material:SetTexture("$basetexture", texture)
      if maskTexture ~= nil then
        material:SetTexture("$texture1", maskTexture)
      end
      setupImageMaskConstants(
        material,
        w,
        h,
        u0,
        v0,
        u1,
        v1,
        stroke,
        strokeWidth,
        mask,
        kind,
        maskTexture,
        sourceAlphaBase
      )
      do
        local __lux_tmp_tint_259 = tint
        if __lux_tmp_tint_259 == nil then
          __lux_tmp_tint_259 = color_white
        end
        style.setDrawColor(__lux_tmp_tint_259)
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    resolveMaskTexture = function(mask, kind)
      if imageMaskUsesTexture(kind) then
        local resolvedKind = imageMaskTextureChannelKind(mask.channel)
        if resolvedKind == nil then
          return nil, nil
        end
        local texture = imageMaskTextureSource(mask)
        if texture == nil then
          return nil, nil
        end
        return resolvedKind, texture
      end
      return kind, nil
    end
    imageBackdropTintColor = function(spec)
      if spec == nil or spec.tint == nil then
        return nil
      end
      local tint = spec.tint
      local alpha
      do
        local __lux_tmp_a_260 = tint.a
        if __lux_tmp_a_260 == nil then
          __lux_tmp_a_260 = 255
        end
        local __lux_tmp_opacity_261 = spec.opacity
        if __lux_tmp_opacity_261 == nil then
          __lux_tmp_opacity_261 = 1
        end
        alpha = __lux_tmp_a_260 * __lux_tmp_opacity_261
      end
      if alpha <= 0 then
        return nil
      end
      local __lux_tmp_r_262 = tint.r
      if __lux_tmp_r_262 == nil then
        __lux_tmp_r_262 = 0
      end
      local __lux_tmp_g_263 = tint.g
      if __lux_tmp_g_263 == nil then
        __lux_tmp_g_263 = 0
      end
      local __lux_tmp_b_264 = tint.b
      if __lux_tmp_b_264 == nil then
        __lux_tmp_b_264 = 0
      end
      return makeColor(
        __lux_tmp_r_262,
        __lux_tmp_g_263,
        __lux_tmp_b_264,
        mathFloor(mathClamp(alpha, 0, 255) + 0.5)
      )
    end
    setupImageMaskEffectParams = function(material, w, h, mask, kind, maskTexture, shadowSpec, outerSpec, drawX, drawY, shadowX, shadowY, outerX, outerY)
      local packedKind = kind
      if mask ~= nil and (mask.invert or mask.inverse) then
        packedKind = packedKind + 128
      end
      local p0 = 0
      local p1 = 0
      local p2 = 0
      local p3 = 0
      if kind == 1 then
        p0, p1, p2, p3 = imageChamferMaskTuple(mask, w, h)
      else
        if imageMaskUsesTexture(kind) then
          p0, p1, p2, p3 = imageMaskTextureUV(mask, maskTexture)
          material:SetTexture("$texture1", maskTexture)
        end
      end
      local shadowColor
      do
        local __lux_obj_shadowSpec_265 = shadowSpec
        local __lux_val_color_266 = nil
        if __lux_obj_shadowSpec_265 ~= nil then
          __lux_val_color_266 = __lux_obj_shadowSpec_265.color
        end
        shadowColor = __lux_val_color_266
        if shadowColor == nil then
          shadowColor = makeColor(0, 0, 0, 0)
        end
      end
      local outerColor
      do
        local __lux_obj_outerSpec_267 = outerSpec
        local __lux_val_color_268 = nil
        if __lux_obj_outerSpec_267 ~= nil then
          __lux_val_color_268 = __lux_obj_outerSpec_267.color
        end
        outerColor = __lux_val_color_268
        if outerColor == nil then
          outerColor = makeColor(0, 0, 0, 0)
        end
      end
      do
        local __lux_tmp_269
        if shadowSpec ~= nil then
          __lux_tmp_269 = roundrect.effectExtentFromSpec(shadowSpec, 18)
        else
          __lux_tmp_269 = 0
        end
        local __lux_tmp_270
        if outerSpec ~= nil then
          __lux_tmp_270 = roundrect.effectExtentFromSpec(outerSpec, 18)
        else
          __lux_tmp_270 = 0
        end
        local __lux_tmp_r_271 = shadowColor.r
        if __lux_tmp_r_271 == nil then
          __lux_tmp_r_271 = 0
        end
        local __lux_tmp_g_272 = shadowColor.g
        if __lux_tmp_g_272 == nil then
          __lux_tmp_g_272 = 0
        end
        local __lux_tmp_b_273 = shadowColor.b
        if __lux_tmp_b_273 == nil then
          __lux_tmp_b_273 = 0
        end
        local __lux_tmp_274
        if shadowSpec ~= nil then
          do
            local __lux_tmp_a_275 = shadowColor.a
            if __lux_tmp_a_275 == nil then
              __lux_tmp_a_275 = 255
            end
            __lux_tmp_274 = __lux_tmp_a_275 / 255
          end
        else
          __lux_tmp_274 = 0
        end
        local __lux_tmp_276
        if shadowSpec ~= nil then
          do
            local __lux_tmp_width_277 = toNumber(shadowSpec.width)
            if __lux_tmp_width_277 == nil then
              __lux_tmp_width_277 = 18
            end
            __lux_tmp_276 = mathMax(0.001, __lux_tmp_width_277)
          end
        else
          __lux_tmp_276 = 1
        end
        local __lux_tmp_278
        if shadowSpec ~= nil then
          do
            local __lux_tmp_strength_279 = shadowSpec.strength
            if __lux_tmp_strength_279 == nil then
              __lux_tmp_strength_279 = shadowSpec.opacity
            end
            local __lux_tmp_strength_280 = toNumber(__lux_tmp_strength_279)
            if __lux_tmp_strength_280 == nil then
              __lux_tmp_strength_280 = 1
            end
            __lux_tmp_278 = mathMax(0, __lux_tmp_strength_280)
          end
        else
          __lux_tmp_278 = 0
        end
        setupParamMatrix(
          material,
          drawX,
          drawY,
          w,
          h,
          packedKind,
          mask ~= nil and geometry.imageRadius(mask.radius, w, h) or 0,
          __lux_tmp_269,
          __lux_tmp_270,
          __lux_tmp_r_271 / 255,
          __lux_tmp_g_272 / 255,
          __lux_tmp_b_273 / 255,
          __lux_tmp_274,
          shadowX,
          shadowY,
          __lux_tmp_276,
          __lux_tmp_278
        )
      end
      local __lux_tmp_r_281 = outerColor.r
      if __lux_tmp_r_281 == nil then
        __lux_tmp_r_281 = 0
      end
      local __lux_tmp_g_282 = outerColor.g
      if __lux_tmp_g_282 == nil then
        __lux_tmp_g_282 = 0
      end
      local __lux_tmp_b_283 = outerColor.b
      if __lux_tmp_b_283 == nil then
        __lux_tmp_b_283 = 0
      end
      local __lux_tmp_284
      if outerSpec ~= nil then
        do
          local __lux_tmp_a_285 = outerColor.a
          if __lux_tmp_a_285 == nil then
            __lux_tmp_a_285 = 255
          end
          __lux_tmp_284 = __lux_tmp_a_285 / 255
        end
      else
        __lux_tmp_284 = 0
      end
      local __lux_tmp_286
      if outerSpec ~= nil then
        do
          local __lux_tmp_width_287 = toNumber(outerSpec.width)
          if __lux_tmp_width_287 == nil then
            __lux_tmp_width_287 = 18
          end
          __lux_tmp_286 = mathMax(0.001, __lux_tmp_width_287)
        end
      else
        __lux_tmp_286 = 1
      end
      local __lux_tmp_288
      if outerSpec ~= nil then
        do
          local __lux_tmp_strength_289 = outerSpec.strength
          if __lux_tmp_strength_289 == nil then
            __lux_tmp_strength_289 = outerSpec.opacity
          end
          local __lux_tmp_strength_290 = toNumber(__lux_tmp_strength_289)
          if __lux_tmp_strength_290 == nil then
            __lux_tmp_strength_290 = 1
          end
          __lux_tmp_288 = mathMax(0, __lux_tmp_strength_290)
        end
      else
        __lux_tmp_288 = 0
      end
      local __lux_tmp_291
      if shadowSpec ~= nil then
        do
          local __lux_tmp_falloff_292 = toNumber(shadowSpec.falloff)
          if __lux_tmp_falloff_292 == nil then
            __lux_tmp_falloff_292 = 1.8
          end
          __lux_tmp_291 = mathClamp(1 / mathMax(__lux_tmp_falloff_292, 0.001), 0.1, 1)
        end
      else
        __lux_tmp_291 = 1
      end
      local __lux_tmp_293
      if outerSpec ~= nil then
        do
          local __lux_tmp_falloff_294 = toNumber(outerSpec.falloff)
          if __lux_tmp_falloff_294 == nil then
            __lux_tmp_falloff_294 = 1.8
          end
          __lux_tmp_293 = mathClamp(1 / mathMax(__lux_tmp_falloff_294, 0.001), 0.1, 1)
        end
      else
        __lux_tmp_293 = 1
      end
      return setupAuxConstants(
        material,
        __lux_tmp_r_281 / 255,
        __lux_tmp_g_282 / 255,
        __lux_tmp_b_283 / 255,
        __lux_tmp_284,
        outerX,
        outerY,
        __lux_tmp_286,
        __lux_tmp_288,
        __lux_tmp_291,
        __lux_tmp_293,
        0,
        0,
        p0,
        p1,
        p2,
        p3
      )
    end
    drawImageMaskShadowOuter = function(x, y, w, h, mask, kind, shadow, outer)
      if shadow == nil and outer == nil or typeOf(mask) ~= "table" or not shadersActive() or not materialOK(widgetMaterials.image_mask_shadow_outer) then
        return false
      end
      if kind == nil then
        kind = imageMaskKindValue(mask)
      end
      if kind == nil then
        return false
      end
      local maskTexture
      kind, maskTexture = resolveMaskTexture(mask, kind)
      if kind == nil then
        return false
      end
      local shadowValid
      do
        local __lux_tmp_296 = shadow ~= nil and shadow.color ~= nil
        if __lux_tmp_296 then
          local __lux_tmp_a_295 = shadow.color.a
          if __lux_tmp_a_295 == nil then
            __lux_tmp_a_295 = 255
          end
          __lux_tmp_296 = __lux_tmp_a_295 > 0
        end
        shadowValid = __lux_tmp_296
      end
      local outerValid
      do
        local __lux_tmp_298 = outer ~= nil and outer.color ~= nil
        if __lux_tmp_298 then
          local __lux_tmp_a_297 = outer.color.a
          if __lux_tmp_a_297 == nil then
            __lux_tmp_a_297 = 255
          end
          __lux_tmp_298 = __lux_tmp_a_297 > 0
        end
        outerValid = __lux_tmp_298
      end
      if not shadowValid and not outerValid then
        return false
      end
      local shadowExtent
      if shadowValid then
        shadowExtent = roundrect.effectExtentFromSpec(shadow, 18)
      else
        shadowExtent = 0
      end
      local outerExtent
      if outerValid then
        outerExtent = roundrect.effectExtentFromSpec(outer, 18)
      else
        outerExtent = 0
      end
      local shadowX
      if shadowValid then
        do
          local __lux_tmp_x_299 = shadow.x
          if __lux_tmp_x_299 == nil then
            __lux_tmp_x_299 = shadow.offsetX
          end
          if __lux_tmp_x_299 == nil then
            __lux_tmp_x_299 = shadow.dx
          end
          local __lux_tmp_x_300 = toNumber(__lux_tmp_x_299)
          if __lux_tmp_x_300 == nil then
            __lux_tmp_x_300 = 0
          end
          shadowX = x + __lux_tmp_x_300 - shadowExtent
        end
      else
        shadowX = x
      end
      local shadowY
      if shadowValid then
        do
          local __lux_tmp_y_301 = shadow.y
          if __lux_tmp_y_301 == nil then
            __lux_tmp_y_301 = shadow.offsetY
          end
          if __lux_tmp_y_301 == nil then
            __lux_tmp_y_301 = shadow.dy
          end
          local __lux_tmp_y_302 = toNumber(__lux_tmp_y_301)
          if __lux_tmp_y_302 == nil then
            __lux_tmp_y_302 = 0
          end
          shadowY = y + __lux_tmp_y_302 - shadowExtent
        end
      else
        shadowY = y
      end
      local outerX
      if outerValid then
        do
          local __lux_tmp_x_303 = outer.x
          if __lux_tmp_x_303 == nil then
            __lux_tmp_x_303 = outer.offsetX
          end
          if __lux_tmp_x_303 == nil then
            __lux_tmp_x_303 = outer.dx
          end
          local __lux_tmp_x_304 = toNumber(__lux_tmp_x_303)
          if __lux_tmp_x_304 == nil then
            __lux_tmp_x_304 = 0
          end
          outerX = x + __lux_tmp_x_304 - outerExtent
        end
      else
        outerX = x
      end
      local outerY
      if outerValid then
        do
          local __lux_tmp_y_305 = outer.y
          if __lux_tmp_y_305 == nil then
            __lux_tmp_y_305 = outer.offsetY
          end
          if __lux_tmp_y_305 == nil then
            __lux_tmp_y_305 = outer.dy
          end
          local __lux_tmp_y_306 = toNumber(__lux_tmp_y_305)
          if __lux_tmp_y_306 == nil then
            __lux_tmp_y_306 = 0
          end
          outerY = y + __lux_tmp_y_306 - outerExtent
        end
      else
        outerY = y
      end
      local sx
      do
        local __lux_tmp_307
        if shadowValid then
          __lux_tmp_307 = shadowX
        else
          __lux_tmp_307 = outerX
        end
        local __lux_tmp_308
        if outerValid then
          __lux_tmp_308 = outerX
        else
          __lux_tmp_308 = shadowX
        end
        sx = mathMin(__lux_tmp_307, __lux_tmp_308)
      end
      local sy
      do
        local __lux_tmp_309
        if shadowValid then
          __lux_tmp_309 = shadowY
        else
          __lux_tmp_309 = outerY
        end
        local __lux_tmp_310
        if outerValid then
          __lux_tmp_310 = outerY
        else
          __lux_tmp_310 = shadowY
        end
        sy = mathMin(__lux_tmp_309, __lux_tmp_310)
      end
      local ex
      do
        local __lux_tmp_311
        if shadowValid then
          __lux_tmp_311 = shadowX + w + shadowExtent * 2
        else
          __lux_tmp_311 = outerX + w + outerExtent * 2
        end
        local __lux_tmp_312
        if outerValid then
          __lux_tmp_312 = outerX + w + outerExtent * 2
        else
          __lux_tmp_312 = shadowX + w + shadowExtent * 2
        end
        ex = mathMax(__lux_tmp_311, __lux_tmp_312)
      end
      local ey
      do
        local __lux_tmp_313
        if shadowValid then
          __lux_tmp_313 = shadowY + h + shadowExtent * 2
        else
          __lux_tmp_313 = outerY + h + outerExtent * 2
        end
        local __lux_tmp_314
        if outerValid then
          __lux_tmp_314 = outerY + h + outerExtent * 2
        else
          __lux_tmp_314 = shadowY + h + shadowExtent * 2
        end
        ey = mathMax(__lux_tmp_313, __lux_tmp_314)
      end
      local drawW = ex - sx
      local drawH = ey - sy
      local material = widgetMaterials.image_mask_shadow_outer
      local shadowArg
      if shadowValid then
        shadowArg = shadow
      else
        shadowArg = nil
      end
      local outerArg
      if outerValid then
        outerArg = outer
      else
        outerArg = nil
      end
      if not setupImageMaskEffectParams(
        material,
        w,
        h,
        mask,
        kind,
        maskTexture,
        shadowArg,
        outerArg,
        drawW,
        drawH,
        x - sx,
        y - sy,
        x - sx,
        y - sy
      ) then
        return false
      end
      local bleedLeft, bleedTop, bleedRight, bleedBottom = effectBleedFromDrawRect(x, y, w, h, sx, sy, drawW, drawH)
      local bleedToken = beginPanelEffectBleed(bleedLeft, bleedTop, bleedRight, bleedBottom)
      surfaceSetDrawColor(255, 255, 255, 255)
      surfaceSetMaterial(material)
      drawTexturedQuad(sx, sy, drawW, drawH, material)
      endPanelEffectBleed(bleedToken)
      return true
    end
    setupImageMaskBackdropConstants = function(material, drawW, drawH, shapeW, shapeH, mask, kind, maskTexture, vertical, intensity)
      local packedKind = kind
      if mask ~= nil and (mask.invert or mask.inverse) then
        packedKind = packedKind + 128
      end
      local p0 = 0
      local p1 = 0
      local p2 = 0
      local p3 = 0
      if kind == 1 then
        p0, p1, p2, p3 = imageChamferMaskTuple(mask, shapeW, shapeH)
      else
        if imageMaskUsesTexture(kind) then
          p0, p1, p2, p3 = imageMaskTextureUV(mask, maskTexture)
          if maskTexture ~= nil then
            material:SetTexture("$texture2", maskTexture)
          end
        end
      end
      local __lux_tmp_intensity_315 = intensity
      if __lux_tmp_intensity_315 == nil then
        __lux_tmp_intensity_315 = 1
      end
      return setupParamMatrix(
        material,
        vertical and 1 or 0,
        __lux_tmp_intensity_315,
        drawW,
        drawH,
        shapeW,
        shapeH,
        packedKind,
        mask ~= nil and geometry.imageRadius(mask.radius, shapeW, shapeH) or 0,
        0,
        0,
        0,
        0,
        p0,
        p1,
        p2,
        p3
      )
    end
    drawImageMaskBackdrop = function(x, y, w, h, mask, kind, maskTexture, backdrop)
      local spec = style.backdropStyle(backdrop)
      if spec == nil or typeOf(mask) ~= "table" or kind == nil then
        return nil
      end
      if imageMaskUsesTexture(kind) and maskTexture == nil then
        return nil
      end
      local pad
      do
        local __lux_tmp_padding_316 = toNumber(spec.padding)
        if __lux_tmp_padding_316 == nil then
          __lux_tmp_padding_316 = 0
        end
        pad = mathMax(0, __lux_tmp_padding_316)
      end
      local bx = x - pad
      local by = y - pad
      local bw = w + pad * 2
      local bh = h + pad * 2
      if spec.blur > 0 and widgetBlurRT ~= nil and renderCopyRenderTargetToTexture ~= nil and materialOK(widgetMaterials.image_mask_backdrop) then
        local material = widgetMaterials.image_mask_backdrop
        local intensity = blurIntensity(spec.blur)
        surfaceSetMaterial(material)
        surfaceSetDrawColor(255, 255, 255, 255)
        renderCopyRenderTargetToTexture(widgetBlurRT)
        setupImageMaskBackdropConstants(
          material,
          bw,
          bh,
          w,
          h,
          mask,
          kind,
          maskTexture,
          false,
          intensity
        )
        drawTexturedQuad(bx, by, bw, bh, material)
        renderCopyRenderTargetToTexture(widgetBlurRT)
        setupImageMaskBackdropConstants(
          material,
          bw,
          bh,
          w,
          h,
          mask,
          kind,
          maskTexture,
          true,
          intensity
        )
        drawTexturedQuad(bx, by, bw, bh, material)
      end
      local tint = imageBackdropTintColor(spec)
      if tint ~= nil and materialOK(widgetMaterials.image_mask_backdrop_fill) then
        local material = widgetMaterials.image_mask_backdrop_fill
        surfaceSetMaterial(material)
        style.setDrawColor(tint)
        setupImageMaskBackdropConstants(
          material,
          bw,
          bh,
          w,
          h,
          mask,
          kind,
          maskTexture,
          false,
          0
        )
        drawTexturedQuad(bx, by, bw, bh, material)
      end
      return spec
    end
    drawImageMaskShader = function(x, y, w, h, texture, u0, v0, u1, v1, drawStyle, mask, kind)
      if typeOf(mask) ~= "table" then
        return false
      end
      if kind == nil then
        kind = imageMaskKindValue(mask)
      end
      if kind == nil then
        return false
      end
      if not materialOK(widgetMaterials.image_mask) then
        return true
      end
      local maskTexture = nil
      if imageMaskUsesTexture(kind) then
        kind = imageMaskTextureChannelKind(mask.channel)
        if kind == nil then
          return true
        end
        maskTexture = imageMaskTextureSource(mask)
        if maskTexture == nil then
          return true
        end
      end
      local background = drawStyle.fill
      if background == nil then
        background = drawStyle.background
      end
      if background ~= nil and background.r ~= nil and (background.a == nil or background.a > 0) then
        local white = imageWhiteTextureSource()
        if white ~= nil then
          drawImageMaskPass(
            x,
            y,
            w,
            h,
            white,
            0,
            0,
            1,
            1,
            background,
            nil,
            0,
            mask,
            kind,
            maskTexture
          )
        end
      end
      return drawImageMaskPass(
        x,
        y,
        w,
        h,
        texture,
        u0,
        v0,
        u1,
        v1,
        geometry.imageTint(drawStyle),
        drawStyle.stroke,
        drawStyle.strokeWidth,
        mask,
        kind,
        maskTexture,
        mask.sourceAlpha == true
      )
    end
  end
  do
    drawRoundImageEffect = function(x, y, w, h, radius, fill, shadow, outerGlow, backdrop, stroke, strokeWidth)
      local resolved = imageRoundEffectStyle
      resolved.radius = radius
      resolved.fill = fill
      resolved.shadow = shadow
      resolved.outerGlow = outerGlow
      resolved.backdrop = backdrop
      resolved.stroke = stroke
      resolved.strokeWidth = strokeWidth
      return roundrect.drawRoundRectImmediate(x, y, w, h, resolved)
    end
    drawChamferImageEffect = function(x, y, w, h, cuts, fill, shadow, outerGlow, backdrop, stroke, strokeWidth)
      local resolved = imageChamferEffectStyle
      resolved.cuts = cuts
      resolved.fill = fill
      resolved.shadow = shadow
      resolved.outerGlow = outerGlow
      resolved.backdrop = backdrop
      resolved.stroke = stroke
      resolved.strokeWidth = strokeWidth
      return primitives.drawChamferBoxImmediate(x, y, w, h, resolved, cuts)
    end
    drawImageFallback = function(x, y, w, h, source, drawStyle)
      local texture, material = imageTextureSource(source)
      local createdMaterialFallback = material == nil
      if material == nil then
        material = imageFallbackMaterialForTexture(texture)
      end
      if material == nil then
        return
      end
      local u0, v0, u1, v1 = geometry.imageUV(drawStyle, texture)
      x, y, w, h, u0, v0, u1, v1 = geometry.imageFitRect(x, y, w, h, texture, drawStyle, u0, v0, u1, v1)
      if w <= 0 or h <= 0 then
        return
      end
      local radius = geometry.imageRadius(drawStyle.radius, w, h)
      local background = drawStyle.fill
      if background == nil then
        background = drawStyle.background
      end
      local __lux_tmp_319 = background ~= nil
      if __lux_tmp_319 then
        local __lux_tmp_a_318 = background.a
        if __lux_tmp_a_318 == nil then
          __lux_tmp_a_318 = 255
        end
        __lux_tmp_319 = __lux_tmp_a_318 > 0
      end
      if __lux_tmp_319 then
        drawRoundImageEffect(x, y, w, h, radius, background)
      end
      surfaceSetMaterial(material)
      style.setDrawColor(geometry.imageTint(drawStyle))
      if hasTransform() then
        geometry.drawTexturedQuadUV(x, y, w, h, u0, v0, u1, v1, material)
      else
        if createdMaterialFallback then
          geometry.drawCreatedMaterialTexturedRectUV(x, y, w, h, u0, v0, u1, v1)
        else
          geometry.drawTexturedQuadUV(x, y, w, h, u0, v0, u1, v1, material)
        end
      end
      local strokeWidth = style.strokeWidthValue(drawStyle.strokeWidth, 0)
      if style.strokeVisible(drawStyle.stroke, strokeWidth) then
        drawRoundImageEffect(
          x,
          y,
          w,
          h,
          radius,
          transparentColor,
          nil,
          nil,
          nil,
          drawStyle.stroke,
          mathMax(1, mathFloor(strokeWidth))
        )
      end
    end
    drawImageChamfer = function(x, y, w, h, texture, u0, v0, u1, v1, drawStyle, cuts)
      if not materialOK(widgetMaterials.chamfer_texture) then
        return false
      end
      if drawStyle.shadow ~= nil then
        drawChamferImageEffect(x, y, w, h, cuts, transparentColor, drawStyle.shadow)
      end
      if drawStyle.outerGlow ~= nil then
        drawChamferImageEffect(x, y, w, h, cuts, transparentColor, nil, drawStyle.outerGlow)
      end
      if drawStyle.backdrop ~= nil then
        drawChamferImageEffect(x, y, w, h, cuts, transparentColor, nil, nil, drawStyle.backdrop)
      end
      local background = drawStyle.fill
      if background == nil then
        background = drawStyle.background
      end
      local __lux_tmp_322 = background ~= nil
      if __lux_tmp_322 then
        local __lux_tmp_a_321 = background.a
        if __lux_tmp_a_321 == nil then
          __lux_tmp_a_321 = 255
        end
        __lux_tmp_322 = __lux_tmp_a_321 > 0
      end
      if __lux_tmp_322 then
        drawChamferImageEffect(x, y, w, h, cuts, background)
      end
      local tl, tr, br, bl = primitives.chamferTuple(cuts, w, h)
      local material = widgetMaterials.chamfer_texture
      local r, g, b, a = style.color01(geometry.imageTint(drawStyle))
      material:SetTexture("$basetexture", texture)
      setupParamMatrix(material, r, g, b, a, w, h, 0, 0, u0, v0, u1, v1, tl, tr, br, bl)
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(x, y, w, h, material)
      if style.strokeVisible(drawStyle.stroke, drawStyle.strokeWidth) then
        drawChamferImageEffect(
          x,
          y,
          w,
          h,
          cuts,
          transparentColor,
          nil,
          nil,
          nil,
          drawStyle.stroke,
          drawStyle.strokeWidth
        )
      end
      return true
    end
    imageRoundedRadius = function(drawStyle, mask, maskKind, w, h)
      local __lux_match_323 = maskKind
      if __lux_match_323 == 2 or __lux_match_323 == 3 then
        return mathMin(w, h) * 0.5
      elseif __lux_match_323 == 0 then
        if mask ~= nil and mask.radius ~= nil then
          return geometry.imageRadius(mask.radius, w, h)
        end
        return geometry.imageRadius(drawStyle.radius, w, h)
      else
        return geometry.imageRadius(drawStyle.radius, w, h)
      end
    end
    imageUsesSourceAlphaEffectMask = function(drawStyle, shadow, outer, backdrop)
      if typeOf(drawStyle) ~= "table" then
        return false
      end
      if drawStyle.mask ~= nil then
        return false
      end
      if drawStyle.radius ~= nil then
        return false
      end
      return shadow ~= nil or outer ~= nil or backdrop ~= nil
    end
    drawImageRoundRectShader = function(x, y, w, h, texture, u0, v0, u1, v1, drawStyle, radius)
      local material = widgetMaterials.roundrect_texture
      if not materialOK(material) then
        return false
      end
      material:SetTexture("$basetexture", texture)
      local stroke = drawStyle.stroke
      if stroke == nil then
        stroke = transparentColor
      end
      local strokeWidth = style.strokeWidthValue(drawStyle.strokeWidth, 0)
      local packedStyle = mathClamp(strokeWidth, 0, 255)
      local sr, sg, sb, sa = style.color01(stroke)
      setupParamMatrix(
        material,
        0,
        0,
        0,
        0,
        w,
        h,
        packedStyle,
        radius,
        u0,
        v0,
        u1,
        v1,
        sr,
        sg,
        sb,
        sa
      )
      style.setDrawColor(geometry.imageTint(drawStyle))
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    imageImmediate = function(x, y, w, h, source, drawStyle)
      local resolved
      if typeOf(drawStyle) == "table" then
        resolved = drawStyle
      else
        resolved = geometry.imageStyle(drawStyle)
      end
      local texture = imageTextureSource(source)
      if texture == nil then
        return
      end
      if not shadersActive() or not materialOK(widgetMaterials.roundrect_texture) then
        drawImageFallback(x, y, w, h, source, resolved)
        return
      end
      local u0, v0, u1, v1 = geometry.imageUV(resolved, texture)
      x, y, w, h, u0, v0, u1, v1 = geometry.imageFitRect(x, y, w, h, texture, resolved, u0, v0, u1, v1)
      if w <= 0 or h <= 0 then
        return
      end
      local shadow = roundrect.shadowStyle(resolved.shadow)
      local outer = roundrect.outerGlowStyle(resolved.outerGlow)
      local backdrop = style.backdropStyle(resolved.backdrop)
      local mask
      local maskKind
      if imageUsesSourceAlphaEffectMask(resolved, shadow, outer, backdrop) then
        mask = sourceAlphaMaskScratch
        mask.source = source
        mask.u0 = u0
        mask.v0 = v0
        mask.u1 = u1
        mask.v1 = v1
        maskKind = 10
      else
        mask = style.imageMaskStyle(resolved.mask, resolved)
        maskKind = imageMaskKindValue(mask)
      end
      if imageMaskUsesTexture(maskKind) then
        local maskTexture = imageMaskTextureSource(mask)
        local backdropMaskKind = imageMaskTextureChannelKind(mask.channel)
        if backdropMaskKind == nil then
          backdropMaskKind = maskKind
        end
        if shadow ~= nil or outer ~= nil then
          drawImageMaskShadowOuter(x, y, w, h, mask, maskKind, shadow, outer)
        end
        drawImageMaskBackdrop(
          x,
          y,
          w,
          h,
          mask,
          backdropMaskKind,
          maskTexture,
          resolved.backdrop
        )
        if drawImageMaskShader(x, y, w, h, texture, u0, v0, u1, v1, resolved, mask, maskKind) then
          return
        end
      end
      local cuts = imageChamferCuts(resolved, mask)
      if cuts ~= nil and drawImageChamfer(x, y, w, h, texture, u0, v0, u1, v1, resolved, cuts) then
        return
      end
      local radius = imageRoundedRadius(resolved, mask, maskKind, w, h)
      if resolved.shadow ~= nil or resolved.outerGlow ~= nil then
        drawRoundImageEffect(
          x,
          y,
          w,
          h,
          radius,
          transparentColor,
          resolved.shadow,
          resolved.outerGlow
        )
      end
      if resolved.backdrop ~= nil then
        drawRoundImageEffect(x, y, w, h, radius, transparentColor, nil, nil, resolved.backdrop)
      end
      local background = resolved.fill
      if background == nil then
        background = resolved.background
      end
      local __lux_tmp_326 = background ~= nil
      if __lux_tmp_326 then
        local __lux_tmp_a_325 = background.a
        if __lux_tmp_a_325 == nil then
          __lux_tmp_a_325 = 255
        end
        __lux_tmp_326 = __lux_tmp_a_325 > 0
      end
      if __lux_tmp_326 then
        drawRoundImageEffect(x, y, w, h, radius, background)
      end
      return drawImageRoundRectShader(x, y, w, h, texture, u0, v0, u1, v1, resolved, radius)
    end
  end
  do
    imageEx = function(x, y, w, h, source, drawStyle)
      local resolved = geometry.imageStyle(drawStyle)
      local transform, stripped = geometry.splitStyleTransform(resolved)
      if transform ~= nil then
        return geometry.withTransform(
          transform,
          x,
          y,
          w,
          h,
          function()
            return imageImmediate(x, y, w, h, source, stripped)
          end
        )
      end
      return imageImmediate(x, y, w, h, source, stripped)
    end
    image = function(x, y, w, h, source, radius, tint)
      imageStyleScratch.radius = radius
      imageStyleScratch.tint = tint
      imageStyleScratch.alpha = nil
      imageStyleScratch.fit = nil
      imageStyleScratch.objectFit = nil
      imageStyleScratch.uv = nil
      imageStyleScratch.crop = nil
      imageStyleScratch.stroke = nil
      imageStyleScratch.strokeWidth = nil
      imageStyleScratch.fill = nil
      imageStyleScratch.background = nil
      imageStyleScratch.mask = nil
      imageStyleScratch.outerGlow = nil
      imageStyleScratch.innerGlow = nil
      imageStyleScratch.backdrop = nil
      imageStyleScratch.shadow = nil
      return imageEx(x, y, w, h, source, imageStyleScratch)
    end
    iconEx = function(x, y, w, h, source, drawStyle)
      local resolved = geometry.imageStyle(drawStyle)
      if resolved.fit == nil and resolved.objectFit == nil then
        resolved.fit = "contain"
      end
      return imageEx(x, y, w, h, source, resolved)
    end
    icon = function(x, y, w, h, source, tint)
      iconStyleScratch.tint = tint
      iconStyleScratch.fit = "contain"
      iconStyleScratch.radius = nil
      iconStyleScratch.alpha = nil
      iconStyleScratch.objectFit = nil
      iconStyleScratch.uv = nil
      iconStyleScratch.crop = nil
      iconStyleScratch.stroke = nil
      iconStyleScratch.strokeWidth = nil
      iconStyleScratch.fill = nil
      iconStyleScratch.background = nil
      iconStyleScratch.mask = nil
      iconStyleScratch.outerGlow = nil
      iconStyleScratch.innerGlow = nil
      iconStyleScratch.backdrop = nil
      iconStyleScratch.shadow = nil
      return iconEx(x, y, w, h, source, iconStyleScratch)
    end
  end
  do
    textEx = function(value, font, x, y, color, ax, ay, textStyle)
      if ax == nil then
        ax = 0
      end
      if ay == nil then
        ay = 0
      end
      return text.drawEx(value, font, x, y, color, ax, ay, textStyle)
    end
    textDraw = function(value, font, x, y, color, ax, ay)
      if ax == nil then
        ax = 0
      end
      if ay == nil then
        ay = 0
      end
      return text.draw(value, font, x, y, color, ax, ay)
    end
    textBoxEx = function(value, font, x, y, w, h, textStyle)
      return text.boxEx(value, font, x, y, w, h, textStyle)
    end
    textBox = function(value, font, x, y, w, h, color, alignX, alignY)
      if alignX == nil then
        alignX = TEXT_ALIGN_LEFT
      end
      if alignY == nil then
        alignY = TEXT_ALIGN_TOP
      end
      return text.box(value, font, x, y, w, h, color, alignX, alignY)
    end
  end
  do
    install = function(owner)
      configureWidgets(owner)
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
      owner._Widgets = {
        progressBarEx = progressBarEx,
        segmentBarEx = segmentBarEx,
        ringEx = ringEx,
        arcEx = arcEx,
        sectorEx = sectorEx,
        imageEx = imageEx,
        text = textDraw,
        textEx = textEx,
        textBox = textBox,
        textBoxEx = textBoxEx,
      }
      return owner
    end
  end
  
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
  __lux_exports.textEx = textEx
  __lux_exports.textDraw = textDraw
  __lux_exports.textBoxEx = textBoxEx
  __lux_exports.textBox = textBox
  __lux_exports.install = install
  
  return __lux_exports
end
