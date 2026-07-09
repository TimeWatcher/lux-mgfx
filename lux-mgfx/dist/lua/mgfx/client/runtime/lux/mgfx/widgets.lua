return function(__lux_import)
  local __lux_exports = {}
  local frame
  local geometry
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
  local progressTrackDarkColor
  local progressTickColor
  local progressGlowColor
  local progressMarkerColor
  local progressTrackGradient
  local progressSheenGradient
  local sourceAlphaMaskScratch
  local defaultProgressTrack
  local defaultProgressStroke
  local defaultSegmentFill
  local defaultSegmentTrack
  local defaultRingFill
  local transparentColor
  local transparentFill
  local configureWidgets
  local materialOK
  local shadersActive
  local setupParamMatrix
  local setupAuxConstants
  local copyInto
  local colorAt
  local fxFlagsFromInput
  local effectBleedFromDrawRect
  local solidFillInto
  local preparedStrokeVisible
  local preparedFillVisible
  local drawPreparedRoundRectPlain
  local drawPreparedRoundRectEffects
  local progressTickFill
  local progressGlowFill
  local progressMarkerFill
  local segmentItemFillScratch
  local segmentContainerFillScratch
  local progressFxBits
  local progressFillCanFast
  local canDrawProgressFast
  local setupProgressConstants
  local setupProgressFxConstants
  local drawProgressFast
  local setGradientColors
  local segmentFillEndpoints
  local drawSegmentBarShaderRaw
  local progressBarRaw
  local progressBarEx
  local progressBar
  local segmentBarRaw
  local segmentBarEx
  local segmentBar
  local arcSegmentCount
  local ringModeValue
  local ringShapeConstants
  local ringFillParams
  local ringFillNeedsLut
  local drawRingFallbackRaw
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
  local drawRingBoxRaw
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
  local imageFitRectRaw
  local imageTintRaw
  local drawImageRawFallback
  local drawImageChamfer
  local imageRoundedRadius
  local imageUsesSourceAlphaEffectMask
  local drawImageRoundRectShader
  local drawRoundImageShadowOuterPrepared
  local imageImmediate
  local imageRaw
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
    local primitivesImport = __lux_import("lux/mgfx/primitives#client")
    local roundrectImport = __lux_import("lux/mgfx/roundrect#client")
    local styleImport = __lux_import("lux/mgfx/style#client")
    local textImport = __lux_import("lux/mgfx/text#client")
    frame = frameImport
    geometry = geometryImport
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
    sourceAlphaMaskScratch = { kind = "texture", channel = "alpha", sourceAlpha = true }
    defaultProgressTrack = makeColor(10, 18, 24, 190)
    defaultProgressStroke = makeColor(255, 255, 255, 18)
    defaultSegmentFill = makeColor(255, 120, 72, 230)
    defaultSegmentTrack = makeColor(255, 255, 255, 22)
    defaultRingFill = makeColor(255, 255, 255, 180)
    transparentColor = makeColor(0, 0, 0, 0)
    transparentFill = {
      kind = style.FILL_SOLID,
      colorA = transparentColor,
      colorB = transparentColor,
      _mgfxFillVisible = false,
    }
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
    fxFlagsFromInput = function(fxInput)
      local fx = typeOf(fxInput) == "table" and fxInput or nil
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
    solidFillInto = function(out, color)
      local c = color
      if c == nil then
        c = transparentColor
      end
      out.kind = style.FILL_SOLID
      out.colorA = c
      out.colorB = c
      out._mgfxFillVisible = c.a == nil or c.a > 0
      return out
    end
    preparedStrokeVisible = function(strokeValue, strokeWidth)
      local __lux_tmp_46 = strokeValue ~= nil and (strokeValue.a == nil or strokeValue.a > 0)
      if __lux_tmp_46 then
        local __lux_tmp_strokeWidth_45 = strokeWidth
        if __lux_tmp_strokeWidth_45 == nil then
          __lux_tmp_strokeWidth_45 = 0
        end
        __lux_tmp_46 = __lux_tmp_strokeWidth_45 > 0
      end
      return __lux_tmp_46
    end
    preparedFillVisible = function(fill)
      if fill == nil then
        return false
      end
      if fill._mgfxFillVisible ~= nil then
        return fill._mgfxFillVisible
      end
      if style.isColor(fill) then
        return fill.a == nil or fill.a > 0
      end
      return style.fillVisible(fill)
    end
    drawPreparedRoundRectPlain = function(x, y, w, h, radius, fill, strokeValue, strokeWidth, patternSpec)
      if strokeWidth == nil then
        strokeWidth = 0
      end
      local __lux_tmp_fill_47 = fill
      if __lux_tmp_fill_47 == nil then
        __lux_tmp_fill_47 = transparentFill
      end
      return roundrect.drawRoundRectPrepared(
        x,
        y,
        w,
        h,
        radius,
        __lux_tmp_fill_47,
        preparedFillVisible(fill),
        strokeValue,
        strokeWidth,
        preparedStrokeVisible(strokeValue, strokeWidth),
        false,
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        1,
        0,
        0,
        1,
        0,
        0,
        false,
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        1,
        0,
        0,
        1,
        0,
        0,
        false,
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        nil,
        patternSpec
      )
    end
    drawPreparedRoundRectEffects = function(x, y, w, h, radius, fill, strokeValue, strokeWidth, hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread, hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread, hasInner, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff, backdropSpec, patternSpec)
      local __lux_tmp_fill_48 = fill
      if __lux_tmp_fill_48 == nil then
        __lux_tmp_fill_48 = transparentFill
      end
      return roundrect.drawRoundRectPrepared(
        x,
        y,
        w,
        h,
        radius,
        __lux_tmp_fill_48,
        preparedFillVisible(fill),
        strokeValue,
        strokeWidth,
        preparedStrokeVisible(strokeValue, strokeWidth),
        hasShadow,
        sr,
        sg,
        sb,
        sa,
        shadowX,
        shadowY,
        shadowWidth,
        shadowSpread,
        shadowGrow,
        shadowStrength,
        shadowFalloff,
        shadowExtent,
        shadowCullSpread,
        hasOuter,
        orr,
        og,
        ob,
        oa,
        outerX,
        outerY,
        outerWidth,
        outerSpread,
        outerGrow,
        outerStrength,
        outerFalloff,
        outerExtent,
        outerCullSpread,
        hasInner,
        igr,
        igg,
        igb,
        iga,
        innerWidth,
        innerStrength,
        innerFalloff,
        backdropSpec,
        patternSpec
      )
    end
  end
  do
    progressTickFill = solidFillInto({}, progressTickColor)
    progressGlowFill = solidFillInto({}, progressGlowColor)
    progressMarkerFill = solidFillInto({}, progressMarkerColor)
    segmentItemFillScratch = {}
    segmentContainerFillScratch = {}
    progressFxBits = function(fxInput)
      local fx = typeOf(fxInput) == "table" and fxInput or nil
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
            local __lux_tmp_count_49 = tickSpec.count
            if __lux_tmp_count_49 == nil then
              __lux_tmp_count_49 = 0
            end
            ticks = __lux_tmp_count_49
          end
        end
      end
      local __lux_tmp_ticks_50 = toNumber(ticks)
      if __lux_tmp_ticks_50 == nil then
        __lux_tmp_ticks_50 = 0
      end
      return flags, mathClamp(mathFloor(__lux_tmp_ticks_50), 0, 31)
    end
    progressFillCanFast = function(fill)
      local __lux_match_51 = fill
      local __lux_tag_52
      if __lux_match_51 ~= nil then
        __lux_tag_52 = __lux_match_51.kind
      end
      if __lux_tag_52 == style.FILL_SOLID then
        return true
      elseif __lux_tag_52 == style.FILL_LINEAR then
        local x1 = __lux_match_51.x1
        local y1 = __lux_match_51.y1
        local x2 = __lux_match_51.x2
        local y2 = __lux_match_51.y2
        local __lux_tmp_x1_53 = x1
        if __lux_tmp_x1_53 == nil then
          __lux_tmp_x1_53 = 0
        end
        local __lux_tmp_55 = __lux_tmp_x1_53 == 0
        if __lux_tmp_55 then
          local __lux_tmp_y1_54 = y1
          if __lux_tmp_y1_54 == nil then
            __lux_tmp_y1_54 = 0
          end
          __lux_tmp_55 = __lux_tmp_y1_54 == 0
        end
        local __lux_tmp_57 = __lux_tmp_55
        if __lux_tmp_57 then
          local __lux_tmp_x2_56 = x2
          if __lux_tmp_x2_56 == nil then
            __lux_tmp_x2_56 = 1
          end
          __lux_tmp_57 = __lux_tmp_x2_56 == 1
        end
        local __lux_tmp_59 = __lux_tmp_57
        if __lux_tmp_59 then
          local __lux_tmp_y2_58 = y2
          if __lux_tmp_y2_58 == nil then
            __lux_tmp_y2_58 = 0
          end
          __lux_tmp_59 = __lux_tmp_y2_58 == 0
        end
        return __lux_tmp_59
      else
        return false
      end
    end
    canDrawProgressFast = function(fill, inset, strokeWidth, flags, ticks, fxMat, shadow, backdrop, outerGlow, innerGlow, pattern, fillPattern, trackPattern)
      if not shadersActive() or not materialOK(fxMat) then
        return false
      end
      if shadow ~= nil or backdrop ~= nil or outerGlow ~= nil or innerGlow ~= nil or pattern ~= nil or fillPattern ~= nil or trackPattern ~= nil then
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
        local __lux_tmp_stroke_60 = stroke
        if __lux_tmp_stroke_60 == nil then
          __lux_tmp_stroke_60 = transparentColor
        end
        r, g, b, a = style.color01(__lux_tmp_stroke_60)
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
        local __lux_tmp_flags_61 = toNumber(flags)
        if __lux_tmp_flags_61 == nil then
          __lux_tmp_flags_61 = 0
        end
        flags = mathClamp(mathFloor(__lux_tmp_flags_61), 0, 7)
      end
      do
        local __lux_tmp_ticks_62 = toNumber(ticks)
        if __lux_tmp_ticks_62 == nil then
          __lux_tmp_ticks_62 = 0
        end
        ticks = mathClamp(mathFloor(__lux_tmp_ticks_62), 0, 31)
      end
      do
        local __lux_tmp_radius_63 = toNumber(radius)
        if __lux_tmp_radius_63 == nil then
          __lux_tmp_radius_63 = 0
        end
        radius = mathClamp(__lux_tmp_radius_63, 0, 255)
      end
      do
        local __lux_tmp_inset_64 = toNumber(inset)
        if __lux_tmp_inset_64 == nil then
          __lux_tmp_inset_64 = 0
        end
        inset = mathClamp(mathFloor(__lux_tmp_inset_64), 0, 31)
      end
      do
        local __lux_tmp_strokeWidth_65 = toNumber(strokeWidth)
        if __lux_tmp_strokeWidth_65 == nil then
          __lux_tmp_strokeWidth_65 = 0
        end
        strokeWidth = mathClamp(mathFloor(__lux_tmp_strokeWidth_65), 0, 15)
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
        local __lux_tmp_stroke_66 = stroke
        if __lux_tmp_stroke_66 == nil then
          __lux_tmp_stroke_66 = transparentColor
        end
        r, g, b, a = style.color01(__lux_tmp_stroke_66)
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
    drawProgressFast = function(x, y, w, h, value, fill, radius, inset, track, stroke, strokeWidth, flags, ticks, shadow, backdrop, outerGlow, innerGlow, pattern, fillPattern, trackPattern)
      local material
      if flags ~= 0 or ticks > 1 then
        material = widgetMaterials.progress_fx
      else
        material = widgetMaterials.progress
      end
      if not canDrawProgressFast(
        fill,
        inset,
        strokeWidth,
        flags,
        ticks,
        material,
        shadow,
        backdrop,
        outerGlow,
        innerGlow,
        pattern,
        fillPattern,
        trackPattern
      ) then
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
      local __lux_tmp_colorA_67 = fill.colorA
      if __lux_tmp_colorA_67 == nil then
        __lux_tmp_colorA_67 = color_white
      end
      local __lux_tmp_colorB_68 = fill.colorB
      if __lux_tmp_colorB_68 == nil then
        __lux_tmp_colorB_68 = fill.colorA
      end
      if __lux_tmp_colorB_68 == nil then
        __lux_tmp_colorB_68 = color_white
      end
      return __lux_tmp_colorA_67, __lux_tmp_colorB_68
    end
    drawSegmentBarShaderRaw = function(x, y, w, h, value, count, gap, fill, track, radius, background, stroke, strokeWidth, shadow, backdrop, outerGlow, innerGlow, pattern, fillPattern, trackPattern)
      if not shadersActive() or not materialOK(widgetMaterials.segmentbar) then
        return false
      end
      if background ~= nil then
        return false
      end
      if style.strokeVisible(stroke, strokeWidth) then
        return false
      end
      if shadow ~= nil or backdrop ~= nil or outerGlow ~= nil or innerGlow ~= nil or pattern ~= nil or fillPattern ~= nil or trackPattern ~= nil then
        return false
      end
      local totalGap = gap * (count - 1)
      local segmentW = (w - totalGap) / count
      if segmentW <= 0 or h <= 0 then
        return true
      end
      local trackColor = style.asColor(track, defaultSegmentTrack)
      local fillA, fillB = segmentFillEndpoints(fill)
      local hasFill = preparedFillVisible(fill)
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
        local __lux_tmp_value_69 = toNumber(value)
        if __lux_tmp_value_69 == nil then
          __lux_tmp_value_69 = 0
        end
        local __lux_tmp_70
        if radius == nil then
          __lux_tmp_70 = mathMin(2, h * 0.35)
        else
          __lux_tmp_70 = radius
        end
        local __lux_tmp_toNumber_71 = toNumber(__lux_tmp_70)
        if __lux_tmp_toNumber_71 == nil then
          __lux_tmp_toNumber_71 = 0
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
          mathClamp(__lux_tmp_value_69, 0, 1),
          mathMax(0, __lux_tmp_toNumber_71),
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
    progressBarRaw = function(x, y, w, h, value, radiusInput, trackInput, fillInput, strokeInput, strokeWidthInput, paddingInput, fxInput, shadow, outerGlow, innerGlow, backdrop, pattern, fillPattern, trackPattern)
      local frac
      do
        local __lux_tmp_value_72 = toNumber(value)
        if __lux_tmp_value_72 == nil then
          __lux_tmp_value_72 = 0
        end
        frac = mathClamp(__lux_tmp_value_72, 0, 1)
      end
      local radius = radiusInput
      if radius == nil then
        radius = mathMin(4, h * 0.5)
      end
      local inset
      do
        local __lux_tmp_paddingInput_73 = toNumber(paddingInput)
        if __lux_tmp_paddingInput_73 == nil then
          __lux_tmp_paddingInput_73 = 0
        end
        inset = mathMax(0, __lux_tmp_paddingInput_73)
      end
      local track = trackInput
      if track == nil then
        track = defaultProgressTrack
      end
      local fill = fillInput
      if fill == nil then
        fill = color_white
      end
      local stroke = strokeInput
      if stroke == nil then
        stroke = defaultProgressStroke
      end
      local strokeWidth = style.strokeWidth(strokeWidthInput, 1)
      local flags, shaderTicks = progressFxBits(fxInput)
      local fillObj = style.fillFromStyle(fill)
      if drawProgressFast(
        x,
        y,
        w,
        h,
        frac,
        fillObj,
        radius,
        inset,
        track,
        stroke,
        strokeWidth,
        flags,
        shaderTicks,
        shadow,
        backdrop,
        outerGlow,
        innerGlow,
        pattern,
        fillPattern,
        trackPattern
      ) then
        return
      end
      local glow, sheen, marker, ticks = fxFlagsFromInput(fxInput)
      local hasShadow = false
      local sr = 0
      local sg = 0
      local sb = 0
      local sa = 0
      local shadowX = 0
      local shadowY = 0
      local shadowWidth = 1
      local shadowSpread = 1
      local shadowGrow = 0
      local shadowStrength = 0
      local shadowFalloff = 1
      local shadowExtent = 0
      local shadowCullSpread = 0
      if shadow ~= nil and shadow ~= false then
        hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread = roundrect.shadowRaw(shadow)
      end
      local hasOuter = false
      local orr = 0
      local og = 0
      local ob = 0
      local oa = 0
      local outerX = 0
      local outerY = 0
      local outerWidth = 1
      local outerSpread = 1
      local outerGrow = 0
      local outerStrength = 0
      local outerFalloff = 1
      local outerExtent = 0
      local outerCullSpread = 0
      if outerGlow ~= nil and outerGlow ~= false then
        hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread = roundrect.outerGlowRaw(outerGlow)
      end
      local hasInner = false
      local igr = 0
      local igg = 0
      local igb = 0
      local iga = 0
      local innerWidth = 0
      local innerStrength = 0
      local innerFalloff = 1
      if innerGlow ~= nil and innerGlow ~= false then
        hasInner, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff = roundrect.innerGlowRaw(innerGlow)
      end
      local backdropSpec
      if backdrop ~= nil and backdrop ~= false then
        backdropSpec = style.backdropStyle(backdrop)
      else
        backdropSpec = nil
      end
      local patternSpec
      if pattern ~= nil and pattern ~= false then
        patternSpec = roundrect.patternStyle(pattern)
      else
        patternSpec = nil
      end
      local fillPatternSpec
      if fillPattern ~= nil and fillPattern ~= false then
        fillPatternSpec = roundrect.patternStyle(fillPattern)
      else
        fillPatternSpec = patternSpec
      end
      local trackPatternSpec
      if trackPattern ~= nil and trackPattern ~= false then
        trackPatternSpec = roundrect.patternStyle(trackPattern)
      else
        trackPatternSpec = nil
      end
      do
        local __lux_tmp_r_74 = track.r
        if __lux_tmp_r_74 == nil then
          __lux_tmp_r_74 = 0
        end
        progressTrackDarkColor.r = mathFloor(__lux_tmp_r_74 * 0.65)
      end
      do
        local __lux_tmp_g_75 = track.g
        if __lux_tmp_g_75 == nil then
          __lux_tmp_g_75 = 0
        end
        progressTrackDarkColor.g = mathFloor(__lux_tmp_g_75 * 0.65)
      end
      do
        local __lux_tmp_b_76 = track.b
        if __lux_tmp_b_76 == nil then
          __lux_tmp_b_76 = 0
        end
        progressTrackDarkColor.b = mathFloor(__lux_tmp_b_76 * 0.65)
      end
      do
        local __lux_tmp_a_77 = track.a
        if __lux_tmp_a_77 == nil then
          __lux_tmp_a_77 = 190
        end
        progressTrackDarkColor.a = __lux_tmp_a_77
      end
      local trackFill = setGradientColors(progressTrackGradient, progressTrackDarkColor, track)
      drawPreparedRoundRectEffects(
        x,
        y,
        w,
        h,
        radius,
        trackFill,
        stroke,
        strokeWidth,
        hasShadow,
        sr,
        sg,
        sb,
        sa,
        shadowX,
        shadowY,
        shadowWidth,
        shadowSpread,
        shadowGrow,
        shadowStrength,
        shadowFalloff,
        shadowExtent,
        shadowCullSpread,
        hasOuter,
        orr,
        og,
        ob,
        oa,
        outerX,
        outerY,
        outerWidth,
        outerSpread,
        outerGrow,
        outerStrength,
        outerFalloff,
        outerExtent,
        outerCullSpread,
        hasInner,
        igr,
        igg,
        igb,
        iga,
        innerWidth,
        innerStrength,
        innerFalloff,
        backdropSpec,
        trackPatternSpec
      )
      local innerH = h - inset * 2
      local innerW = (w - inset * 2) * frac
      if frac >= 0.999 then
        innerW = w - inset * 2
      end
      if ticks > 1 then
        for index = 1, ticks - 1 do
          local tx = x + mathFloor(w * index / ticks)
          drawPreparedRoundRectPlain(tx, y + 3, 1, mathMax(1, h - 6), 0, progressTickFill)
        end
      end
      if innerH <= 0 or innerW <= 0 then
        return
      end
      if glow and innerW > 4 then
        local glowRadius = mathMin(radius + 2, (innerH + 4) * 0.5, (innerW + 4) * 0.5)
        drawPreparedRoundRectPlain(
          x + inset - 2,
          y + inset - 2,
          innerW + 4,
          innerH + 4,
          glowRadius,
          progressGlowFill
        )
      end
      local fillRadius = mathMin(mathMax(0, radius - inset), innerH * 0.5, innerW * 0.5)
      drawPreparedRoundRectPlain(
        x + inset,
        y + inset,
        innerW,
        innerH,
        fillRadius,
        fillObj,
        nil,
        0,
        fillPatternSpec
      )
      if sheen and innerW > 8 then
        local sheenRadius = mathMin(radius, innerH * 0.25)
        drawPreparedRoundRectPlain(
          x + inset + 1,
          y + inset + 1,
          mathMax(1, innerW - 2),
          mathMax(1, innerH * 0.38),
          sheenRadius,
          progressSheenGradient
        )
      end
      if marker and innerW > 5 then
        local mx = x + inset + innerW - 2
        drawPreparedRoundRectPlain(mx, y + 2, 2, h - 4, 1, progressMarkerFill)
      end
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
      local __lux_tmp_fill_78 = stripped.fill
      if __lux_tmp_fill_78 == nil then
        __lux_tmp_fill_78 = stripped.color
      end
      return progressBarRaw(
        x,
        y,
        w,
        h,
        value,
        stripped.radius,
        stripped.track,
        __lux_tmp_fill_78,
        stripped.stroke,
        stripped.strokeWidth,
        stripped.padding,
        stripped.fx,
        stripped.shadow,
        stripped.outerGlow,
        stripped.innerGlow,
        stripped.backdrop,
        stripped.pattern,
        stripped.fillPattern,
        stripped.trackPattern
      )
    end
    progressBar = function(x, y, w, h, value, radius, track, fill, stroke, strokeWidth)
      return progressBarRaw(x, y, w, h, value, radius, track, fill, stroke, strokeWidth)
    end
    segmentBarRaw = function(x, y, w, h, value, segments, fillInput, colorInput, trackInput, radius, gapInput, backgroundRadius, background, stroke, strokeWidth, shadow, outerGlow, innerGlow, backdrop, pattern, fillPattern, trackPattern)
      local count
      do
        local __lux_tmp_segments_79 = toNumber(segments)
        if __lux_tmp_segments_79 == nil then
          __lux_tmp_segments_79 = 10
        end
        count = mathClamp(mathFloor(__lux_tmp_segments_79), 1, 128)
      end
      local gap
      do
        local __lux_tmp_gapInput_80 = toNumber(gapInput)
        if __lux_tmp_gapInput_80 == nil then
          __lux_tmp_gapInput_80 = 2
        end
        gap = mathMax(0, __lux_tmp_gapInput_80)
      end
      local frac
      do
        local __lux_tmp_value_81 = toNumber(value)
        if __lux_tmp_value_81 == nil then
          __lux_tmp_value_81 = 0
        end
        frac = mathClamp(__lux_tmp_value_81, 0, 1)
      end
      local active = mathFloor(frac * count + 0.0001)
      local fill
      do
        local __lux_tmp_fillInput_82 = fillInput
        if __lux_tmp_fillInput_82 == nil then
          __lux_tmp_fillInput_82 = colorInput
        end
        if __lux_tmp_fillInput_82 == nil then
          __lux_tmp_fillInput_82 = defaultSegmentFill
        end
        fill = style.fillFromStyle(__lux_tmp_fillInput_82)
      end
      local track = trackInput
      if track == nil then
        track = defaultSegmentTrack
      end
      local strokeWidthValue = style.strokeWidth(strokeWidth, 0)
      if drawSegmentBarShaderRaw(
        x,
        y,
        w,
        h,
        frac,
        count,
        gap,
        fill,
        track,
        radius,
        background,
        stroke,
        strokeWidthValue,
        shadow,
        backdrop,
        outerGlow,
        innerGlow,
        pattern,
        fillPattern,
        trackPattern
      ) then
        return
      end
      local totalGap = gap * (count - 1)
      local segmentW = (w - totalGap) / count
      if segmentW <= 0 or h <= 0 then
        return
      end
      local containerRadius = backgroundRadius
      if containerRadius == nil then
        containerRadius = radius
        if containerRadius == nil then
          containerRadius = mathMin(3, h * 0.5)
        end
      end
      if shadow ~= nil or outerGlow ~= nil or innerGlow ~= nil or backdrop ~= nil or background ~= nil then
        local hasShadow = false
        local sr = 0
        local sg = 0
        local sb = 0
        local sa = 0
        local shadowX = 0
        local shadowY = 0
        local shadowWidth = 1
        local shadowSpread = 1
        local shadowGrow = 0
        local shadowStrength = 0
        local shadowFalloff = 1
        local shadowExtent = 0
        local shadowCullSpread = 0
        if shadow ~= nil and shadow ~= false then
          hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread = roundrect.shadowRaw(shadow)
        end
        local hasOuter = false
        local orr = 0
        local og = 0
        local ob = 0
        local oa = 0
        local outerX = 0
        local outerY = 0
        local outerWidth = 1
        local outerSpread = 1
        local outerGrow = 0
        local outerStrength = 0
        local outerFalloff = 1
        local outerExtent = 0
        local outerCullSpread = 0
        if outerGlow ~= nil and outerGlow ~= false then
          hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread = roundrect.outerGlowRaw(outerGlow)
        end
        local hasInner = false
        local igr = 0
        local igg = 0
        local igb = 0
        local iga = 0
        local innerWidth = 0
        local innerStrength = 0
        local innerFalloff = 1
        if innerGlow ~= nil and innerGlow ~= false then
          hasInner, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff = roundrect.innerGlowRaw(innerGlow)
        end
        local backdropSpec
        if backdrop ~= nil and backdrop ~= false then
          backdropSpec = style.backdropStyle(backdrop)
        else
          backdropSpec = nil
        end
        local backgroundFill
        if background ~= nil then
          backgroundFill = style.fillFromStyle(background)
        else
          backgroundFill = solidFillInto(segmentContainerFillScratch, transparentColor)
        end
        drawPreparedRoundRectEffects(
          x,
          y,
          w,
          h,
          containerRadius,
          backgroundFill,
          nil,
          0,
          hasShadow,
          sr,
          sg,
          sb,
          sa,
          shadowX,
          shadowY,
          shadowWidth,
          shadowSpread,
          shadowGrow,
          shadowStrength,
          shadowFalloff,
          shadowExtent,
          shadowCullSpread,
          hasOuter,
          orr,
          og,
          ob,
          oa,
          outerX,
          outerY,
          outerWidth,
          outerSpread,
          outerGrow,
          outerStrength,
          outerFalloff,
          outerExtent,
          outerCullSpread,
          hasInner,
          igr,
          igg,
          igb,
          iga,
          innerWidth,
          innerStrength,
          innerFalloff,
          backdropSpec,
          nil
        )
      end
      local itemRadius
      if radius == nil then
        itemRadius = mathMin(2, h * 0.35)
      else
        itemRadius = radius
      end
      local trackFill = style.fillFromStyle(track)
      local patternSpec
      if pattern ~= nil and pattern ~= false then
        patternSpec = roundrect.patternStyle(pattern)
      else
        patternSpec = nil
      end
      local fillPatternSpec
      if fillPattern ~= nil and fillPattern ~= false then
        fillPatternSpec = roundrect.patternStyle(fillPattern)
      else
        fillPatternSpec = patternSpec
      end
      local trackPatternSpec
      if trackPattern ~= nil and trackPattern ~= false then
        trackPatternSpec = roundrect.patternStyle(trackPattern)
      else
        trackPatternSpec = nil
      end
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
        local itemFill
        if filled then
          itemFill = solidFillInto(segmentItemFillScratch, color)
        else
          itemFill = trackFill
        end
        local itemPattern
        if filled then
          itemPattern = fillPatternSpec
        else
          itemPattern = trackPatternSpec
        end
        if preparedFillVisible(itemFill) or itemPattern ~= nil then
          drawPreparedRoundRectPlain(
            sx,
            y,
            segmentW,
            h,
            itemRadius,
            itemFill,
            stroke,
            strokeWidthValue,
            itemPattern
          )
        end
      end
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
      return segmentBarRaw(
        x,
        y,
        w,
        h,
        value,
        stripped.segments,
        stripped.fill,
        stripped.color,
        stripped.track,
        stripped.radius,
        stripped.gap,
        stripped.backgroundRadius,
        stripped.background,
        stripped.stroke,
        stripped.strokeWidth,
        stripped.shadow,
        stripped.outerGlow,
        stripped.innerGlow,
        stripped.backdrop,
        stripped.pattern,
        stripped.fillPattern,
        stripped.trackPattern
      )
    end
    segmentBar = function(x, y, w, h, value, segments, fill, track)
      return segmentBarRaw(x, y, w, h, value, segments, fill, nil, track)
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
    drawRingFallbackRaw = function(cx, cy, outerRadius, arcWidth, startDeg, endDeg, mode, innerRadiusInput, fillInput, colorInput, stroke, strokeWidth, shadow, outerGlow, backdrop, segmentsInput)
      local fill = fillInput
      if fill == nil then
        fill = colorInput
        if fill == nil then
          fill = defaultRingFill
        end
      end
      local segments
      do
        local __lux_tmp_segmentsInput_106 = segmentsInput
        if __lux_tmp_segmentsInput_106 == nil then
          __lux_tmp_segmentsInput_106 = 64
        end
        segments = arcSegmentCount(outerRadius, startDeg, endDeg, __lux_tmp_segmentsInput_106)
      end
      local startRad
      do
        local __lux_tmp_startDeg_107 = startDeg
        if __lux_tmp_startDeg_107 == nil then
          __lux_tmp_startDeg_107 = 0
        end
        startRad = mathRad(__lux_tmp_startDeg_107)
      end
      local endRad
      do
        local __lux_tmp_endDeg_108 = endDeg
        if __lux_tmp_endDeg_108 == nil then
          __lux_tmp_endDeg_108 = 360
        end
        endRad = mathRad(__lux_tmp_endDeg_108)
      end
      if mode == 2 then
        local innerRadius
        do
          local __lux_tmp_innerRadiusInput_109 = toNumber(innerRadiusInput)
          if __lux_tmp_innerRadiusInput_109 == nil then
            __lux_tmp_innerRadiusInput_109 = mathMax(0, outerRadius - arcWidth)
          end
          innerRadius = mathClamp(__lux_tmp_innerRadiusInput_109, 0, outerRadius)
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
        return primitives.drawPolyRaw(
          points,
          nil,
          fill,
          stroke,
          strokeWidth,
          shadow,
          outerGlow,
          backdrop
        )
      end
      for index = 1, segments do
        local t1 = (index - 1) / segments
        local t2 = index / segments
        local a1 = startRad + (endRad - startRad) * t1
        local a2 = startRad + (endRad - startRad) * t2
        primitives.drawLineRaw(
          cx + mathCos(a1) * outerRadius,
          cy + mathSin(a1) * outerRadius,
          cx + mathCos(a2) * outerRadius,
          cy + mathSin(a2) * outerRadius,
          fill,
          arcWidth,
          nil,
          nil,
          outerGlow,
          backdrop,
          false
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
        local __lux_tmp_kind_110 = fill.kind
        if __lux_tmp_kind_110 == nil then
          __lux_tmp_kind_110 = style.FILL_SOLID
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
          __lux_tmp_kind_110,
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
        local __lux_tmp_colorA_111 = fill.colorA
        if __lux_tmp_colorA_111 == nil then
          __lux_tmp_colorA_111 = color_white
        end
        style.setDrawColor(__lux_tmp_colorA_111)
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
    drawRingFxPass = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, fill, stroke, strokeWidth, innerEnabled, gr, gg, gb, ga, glowWidth, glowStrength, glowFalloff)
      local width = style.strokeWidth(strokeWidth, 0)
      local hasStroke = style.strokeVisible(stroke, width)
      local hasGlow = innerEnabled and ga > 0 and glowStrength > 0
      if hasGlow then
        do
          local __lux_tmp_glowWidth_112 = toNumber(glowWidth)
          if __lux_tmp_glowWidth_112 == nil then
            __lux_tmp_glowWidth_112 = 8
          end
          glowWidth = mathMax(0.001, __lux_tmp_glowWidth_112)
        end
        do
          local __lux_tmp_glowStrength_113 = toNumber(glowStrength)
          if __lux_tmp_glowStrength_113 == nil then
            __lux_tmp_glowStrength_113 = 1
          end
          glowStrength = mathMax(0, __lux_tmp_glowStrength_113)
        end
        do
          local __lux_tmp_glowFalloff_114 = toNumber(glowFalloff)
          if __lux_tmp_glowFalloff_114 == nil then
            __lux_tmp_glowFalloff_114 = 1.65
          end
          glowFalloff = mathMax(0.001, __lux_tmp_glowFalloff_114)
        end
      else
        gr = 0
        gg = 0
        gb = 0
        ga = 0
        glowWidth = 0
        glowStrength = 0
        glowFalloff = 1
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
        local __lux_tmp_kind_115 = fill.kind
        if __lux_tmp_kind_115 == nil then
          __lux_tmp_kind_115 = style.FILL_SOLID
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
          __lux_tmp_kind_115,
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
        local __lux_tmp_colorA_116 = fill.colorA
        if __lux_tmp_colorA_116 == nil then
          __lux_tmp_colorA_116 = color_white
        end
        style.setDrawColor(__lux_tmp_colorA_116)
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    drawRingInnerGlowPass = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, enabled, gr, gg, gb, ga, glowWidth, glowStrength, glowFalloff)
      if not enabled or ga <= 0 or glowStrength <= 0 or not shadersActive() or not materialOK(widgetMaterials.ring_innerglow) then
        return false
      end
      local material = widgetMaterials.ring_innerglow
      local sw, sh, ir, orad, sr, er, modeValue = ringShapeConstants(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      do
        local __lux_tmp_glowWidth_117 = toNumber(glowWidth)
        if __lux_tmp_glowWidth_117 == nil then
          __lux_tmp_glowWidth_117 = 8
        end
        local __lux_tmp_glowStrength_118 = toNumber(glowStrength)
        if __lux_tmp_glowStrength_118 == nil then
          __lux_tmp_glowStrength_118 = 1
        end
        local __lux_tmp_glowFalloff_119 = toNumber(glowFalloff)
        if __lux_tmp_glowFalloff_119 == nil then
          __lux_tmp_glowFalloff_119 = 1.65
        end
        setupParamMatrix(
          material,
          gr,
          gg,
          gb,
          ga,
          sw,
          sh,
          ir,
          orad,
          sr,
          er,
          modeValue,
          mathMax(0.001, __lux_tmp_glowWidth_117),
          mathMax(0, __lux_tmp_glowStrength_118),
          mathMax(0.001, __lux_tmp_glowFalloff_119),
          0,
          0
        )
      end
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    ringEffectBounds = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, enabled, alpha, ox, oy, width, extent, grow, strength, falloff, biasOffset)
      if biasOffset == nil then
        biasOffset = false
      end
      if not enabled or alpha <= 0 or strength <= 0 then
        return nil
      end
      do
        local __lux_tmp_grow_120 = toNumber(grow)
        if __lux_tmp_grow_120 == nil then
          __lux_tmp_grow_120 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_120)
      end
      do
        local __lux_tmp_ox_121 = toNumber(ox)
        if __lux_tmp_ox_121 == nil then
          __lux_tmp_ox_121 = 0
        end
        ox = __lux_tmp_ox_121
      end
      do
        local __lux_tmp_oy_122 = toNumber(oy)
        if __lux_tmp_oy_122 == nil then
          __lux_tmp_oy_122 = 0
        end
        oy = __lux_tmp_oy_122
      end
      do
        local __lux_tmp_width_123 = toNumber(width)
        if __lux_tmp_width_123 == nil then
          __lux_tmp_width_123 = 18
        end
        width = mathMax(0.001, __lux_tmp_width_123)
      end
      do
        local __lux_tmp_extent_124 = toNumber(extent)
        if __lux_tmp_extent_124 == nil then
          __lux_tmp_extent_124 = width
        end
        extent = mathMax(1, __lux_tmp_extent_124)
      end
      do
        local __lux_tmp_strength_125 = toNumber(strength)
        if __lux_tmp_strength_125 == nil then
          __lux_tmp_strength_125 = 1
        end
        strength = mathMax(0, __lux_tmp_strength_125)
      end
      do
        local __lux_tmp_falloff_126 = toNumber(falloff)
        if __lux_tmp_falloff_126 == nil then
          __lux_tmp_falloff_126 = 1.9
        end
        falloff = mathMax(0.001, __lux_tmp_falloff_126)
      end
      local gx = x + ox - grow
      local gy = y + oy - grow
      local gw = w + grow * 2
      local gh = h + grow * 2
      local gi
      do
        local __lux_tmp_innerRadius_127 = toNumber(innerRadius)
        if __lux_tmp_innerRadius_127 == nil then
          __lux_tmp_innerRadius_127 = 0
        end
        gi = mathMax(0, __lux_tmp_innerRadius_127 - grow)
      end
      local go
      do
        local __lux_tmp_outerRadius_128 = toNumber(outerRadius)
        if __lux_tmp_outerRadius_128 == nil then
          __lux_tmp_outerRadius_128 = mathMin(w, h) * 0.5
        end
        go = mathMax(0.001, __lux_tmp_outerRadius_128 + grow)
      end
      local spread = extent
      if biasOffset then
        local left, top, right, bottom = roundrect.glowBiasPads(spread, ox, oy)
        local __lux_tmp_startDeg_129 = toNumber(startDeg)
        if __lux_tmp_startDeg_129 == nil then
          __lux_tmp_startDeg_129 = 0
        end
        local __lux_tmp_endDeg_130 = toNumber(endDeg)
        if __lux_tmp_endDeg_130 == nil then
          __lux_tmp_endDeg_130 = 360
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
          start = mathRad(__lux_tmp_startDeg_129),
          finish = mathRad(__lux_tmp_endDeg_130),
          mode = ringModeValue(mode),
          width = width,
          strength = strength,
          falloff = falloff,
        }
      end
      local __lux_tmp_startDeg_131 = toNumber(startDeg)
      if __lux_tmp_startDeg_131 == nil then
        __lux_tmp_startDeg_131 = 0
      end
      local __lux_tmp_endDeg_132 = toNumber(endDeg)
      if __lux_tmp_endDeg_132 == nil then
        __lux_tmp_endDeg_132 = 360
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
        start = mathRad(__lux_tmp_startDeg_131),
        finish = mathRad(__lux_tmp_endDeg_132),
        mode = ringModeValue(mode),
        width = width,
        strength = strength,
        falloff = falloff,
      }
    end
    drawRingShadowOuterPass = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowExtent, shadowGrow, shadowStrength, shadowFalloff, hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerExtent, outerGrow, outerStrength, outerFalloff)
      if not hasShadow and not hasOuter or not shadersActive() or not materialOK(widgetMaterials.ring_shadow_outer) then
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
        hasShadow,
        sa,
        shadowX,
        shadowY,
        shadowWidth,
        shadowExtent,
        shadowGrow,
        shadowStrength,
        shadowFalloff,
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
        hasOuter,
        oa,
        outerX,
        outerY,
        outerWidth,
        outerExtent,
        outerGrow,
        outerStrength,
        outerFalloff,
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
      local material = widgetMaterials.ring_shadow_outer
      do
        local __lux_tmp_133
        if shadowBounds ~= nil then
          __lux_tmp_133 = sr
        else
          __lux_tmp_133 = 0
        end
        local __lux_tmp_134
        if shadowBounds ~= nil then
          __lux_tmp_134 = sg
        else
          __lux_tmp_134 = 0
        end
        local __lux_tmp_135
        if shadowBounds ~= nil then
          __lux_tmp_135 = sb
        else
          __lux_tmp_135 = 0
        end
        local __lux_tmp_136
        if shadowBounds ~= nil then
          __lux_tmp_136 = sa
        else
          __lux_tmp_136 = 0
        end
        local __lux_obj_shadowBounds_137 = shadowBounds
        local __lux_tmp_x_138 = nil
        if __lux_obj_shadowBounds_137 ~= nil then
          __lux_tmp_x_138 = __lux_obj_shadowBounds_137.x
        end
        if __lux_tmp_x_138 == nil then
          __lux_tmp_x_138 = x
        end
        local __lux_obj_shadowBounds_139 = shadowBounds
        local __lux_tmp_shapeX_140 = nil
        if __lux_obj_shadowBounds_139 ~= nil then
          __lux_tmp_shapeX_140 = __lux_obj_shadowBounds_139.shapeX
        end
        if __lux_tmp_shapeX_140 == nil then
          __lux_tmp_shapeX_140 = 0
        end
        local __lux_obj_shadowBounds_141 = shadowBounds
        local __lux_tmp_outer_142 = nil
        if __lux_obj_shadowBounds_141 ~= nil then
          __lux_tmp_outer_142 = __lux_obj_shadowBounds_141.outer
        end
        if __lux_tmp_outer_142 == nil then
          __lux_tmp_outer_142 = 0
        end
        local __lux_obj_shadowBounds_143 = shadowBounds
        local __lux_tmp_y_144 = nil
        if __lux_obj_shadowBounds_143 ~= nil then
          __lux_tmp_y_144 = __lux_obj_shadowBounds_143.y
        end
        if __lux_tmp_y_144 == nil then
          __lux_tmp_y_144 = y
        end
        local __lux_obj_shadowBounds_145 = shadowBounds
        local __lux_tmp_shapeY_146 = nil
        if __lux_obj_shadowBounds_145 ~= nil then
          __lux_tmp_shapeY_146 = __lux_obj_shadowBounds_145.shapeY
        end
        if __lux_tmp_shapeY_146 == nil then
          __lux_tmp_shapeY_146 = 0
        end
        local __lux_obj_shadowBounds_147 = shadowBounds
        local __lux_tmp_outer_148 = nil
        if __lux_obj_shadowBounds_147 ~= nil then
          __lux_tmp_outer_148 = __lux_obj_shadowBounds_147.outer
        end
        if __lux_tmp_outer_148 == nil then
          __lux_tmp_outer_148 = 0
        end
        local __lux_obj_shadowBounds_149 = shadowBounds
        local __lux_tmp_inner_150 = nil
        if __lux_obj_shadowBounds_149 ~= nil then
          __lux_tmp_inner_150 = __lux_obj_shadowBounds_149.inner
        end
        if __lux_tmp_inner_150 == nil then
          __lux_tmp_inner_150 = 0
        end
        local __lux_obj_shadowBounds_151 = shadowBounds
        local __lux_tmp_outer_152 = nil
        if __lux_obj_shadowBounds_151 ~= nil then
          __lux_tmp_outer_152 = __lux_obj_shadowBounds_151.outer
        end
        if __lux_tmp_outer_152 == nil then
          __lux_tmp_outer_152 = 1
        end
        local __lux_obj_shadowBounds_153 = shadowBounds
        local __lux_tmp_start_154 = nil
        if __lux_obj_shadowBounds_153 ~= nil then
          __lux_tmp_start_154 = __lux_obj_shadowBounds_153.start
        end
        if __lux_tmp_start_154 == nil then
          __lux_tmp_start_154 = 0
        end
        local __lux_obj_shadowBounds_155 = shadowBounds
        local __lux_tmp_finish_156 = nil
        if __lux_obj_shadowBounds_155 ~= nil then
          __lux_tmp_finish_156 = __lux_obj_shadowBounds_155.finish
        end
        if __lux_tmp_finish_156 == nil then
          __lux_tmp_finish_156 = mathRad(360)
        end
        local __lux_obj_shadowBounds_157 = shadowBounds
        local __lux_tmp_mode_158 = nil
        if __lux_obj_shadowBounds_157 ~= nil then
          __lux_tmp_mode_158 = __lux_obj_shadowBounds_157.mode
        end
        if __lux_tmp_mode_158 == nil then
          __lux_tmp_mode_158 = 0
        end
        local __lux_tmp_159
        if shadowBounds ~= nil then
          __lux_tmp_159 = shadowBounds.width
        else
          __lux_tmp_159 = 1
        end
        setupParamMatrix(
          material,
          drawW,
          drawH,
          0,
          0,
          __lux_tmp_133,
          __lux_tmp_134,
          __lux_tmp_135,
          __lux_tmp_136,
          __lux_tmp_x_138 + __lux_tmp_shapeX_140 + __lux_tmp_outer_142 - sx,
          __lux_tmp_y_144 + __lux_tmp_shapeY_146 + __lux_tmp_outer_148 - sy,
          __lux_tmp_inner_150,
          __lux_tmp_outer_152,
          __lux_tmp_start_154,
          __lux_tmp_finish_156,
          __lux_tmp_mode_158,
          __lux_tmp_159
        )
      end
      do
        local __lux_tmp_160
        if outerBounds ~= nil then
          __lux_tmp_160 = orr
        else
          __lux_tmp_160 = 0
        end
        local __lux_tmp_161
        if outerBounds ~= nil then
          __lux_tmp_161 = og
        else
          __lux_tmp_161 = 0
        end
        local __lux_tmp_162
        if outerBounds ~= nil then
          __lux_tmp_162 = ob
        else
          __lux_tmp_162 = 0
        end
        local __lux_tmp_163
        if outerBounds ~= nil then
          __lux_tmp_163 = oa
        else
          __lux_tmp_163 = 0
        end
        local __lux_obj_outerBounds_164 = outerBounds
        local __lux_tmp_x_165 = nil
        if __lux_obj_outerBounds_164 ~= nil then
          __lux_tmp_x_165 = __lux_obj_outerBounds_164.x
        end
        if __lux_tmp_x_165 == nil then
          __lux_tmp_x_165 = x
        end
        local __lux_obj_outerBounds_166 = outerBounds
        local __lux_tmp_shapeX_167 = nil
        if __lux_obj_outerBounds_166 ~= nil then
          __lux_tmp_shapeX_167 = __lux_obj_outerBounds_166.shapeX
        end
        if __lux_tmp_shapeX_167 == nil then
          __lux_tmp_shapeX_167 = 0
        end
        local __lux_obj_outerBounds_168 = outerBounds
        local __lux_tmp_outer_169 = nil
        if __lux_obj_outerBounds_168 ~= nil then
          __lux_tmp_outer_169 = __lux_obj_outerBounds_168.outer
        end
        if __lux_tmp_outer_169 == nil then
          __lux_tmp_outer_169 = 0
        end
        local __lux_obj_outerBounds_170 = outerBounds
        local __lux_tmp_y_171 = nil
        if __lux_obj_outerBounds_170 ~= nil then
          __lux_tmp_y_171 = __lux_obj_outerBounds_170.y
        end
        if __lux_tmp_y_171 == nil then
          __lux_tmp_y_171 = y
        end
        local __lux_obj_outerBounds_172 = outerBounds
        local __lux_tmp_shapeY_173 = nil
        if __lux_obj_outerBounds_172 ~= nil then
          __lux_tmp_shapeY_173 = __lux_obj_outerBounds_172.shapeY
        end
        if __lux_tmp_shapeY_173 == nil then
          __lux_tmp_shapeY_173 = 0
        end
        local __lux_obj_outerBounds_174 = outerBounds
        local __lux_tmp_outer_175 = nil
        if __lux_obj_outerBounds_174 ~= nil then
          __lux_tmp_outer_175 = __lux_obj_outerBounds_174.outer
        end
        if __lux_tmp_outer_175 == nil then
          __lux_tmp_outer_175 = 0
        end
        local __lux_obj_outerBounds_176 = outerBounds
        local __lux_tmp_inner_177 = nil
        if __lux_obj_outerBounds_176 ~= nil then
          __lux_tmp_inner_177 = __lux_obj_outerBounds_176.inner
        end
        if __lux_tmp_inner_177 == nil then
          __lux_tmp_inner_177 = 0
        end
        local __lux_obj_outerBounds_178 = outerBounds
        local __lux_tmp_outer_179 = nil
        if __lux_obj_outerBounds_178 ~= nil then
          __lux_tmp_outer_179 = __lux_obj_outerBounds_178.outer
        end
        if __lux_tmp_outer_179 == nil then
          __lux_tmp_outer_179 = 1
        end
        local __lux_obj_outerBounds_180 = outerBounds
        local __lux_tmp_start_181 = nil
        if __lux_obj_outerBounds_180 ~= nil then
          __lux_tmp_start_181 = __lux_obj_outerBounds_180.start
        end
        if __lux_tmp_start_181 == nil then
          __lux_tmp_start_181 = 0
        end
        local __lux_obj_outerBounds_182 = outerBounds
        local __lux_tmp_finish_183 = nil
        if __lux_obj_outerBounds_182 ~= nil then
          __lux_tmp_finish_183 = __lux_obj_outerBounds_182.finish
        end
        if __lux_tmp_finish_183 == nil then
          __lux_tmp_finish_183 = mathRad(360)
        end
        local __lux_obj_outerBounds_184 = outerBounds
        local __lux_tmp_mode_185 = nil
        if __lux_obj_outerBounds_184 ~= nil then
          __lux_tmp_mode_185 = __lux_obj_outerBounds_184.mode
        end
        if __lux_tmp_mode_185 == nil then
          __lux_tmp_mode_185 = 0
        end
        local __lux_tmp_186
        if outerBounds ~= nil then
          __lux_tmp_186 = outerBounds.width
        else
          __lux_tmp_186 = 1
        end
        local __lux_tmp_187
        if shadowBounds ~= nil then
          __lux_tmp_187 = shadowBounds.falloff
        else
          __lux_tmp_187 = 1
        end
        local __lux_tmp_188
        if shadowBounds ~= nil then
          __lux_tmp_188 = shadowBounds.strength
        else
          __lux_tmp_188 = 0
        end
        local __lux_tmp_189
        if outerBounds ~= nil then
          __lux_tmp_189 = outerBounds.falloff
        else
          __lux_tmp_189 = 1
        end
        local __lux_tmp_190
        if outerBounds ~= nil then
          __lux_tmp_190 = outerBounds.strength
        else
          __lux_tmp_190 = 0
        end
        setupAuxConstants(
          material,
          __lux_tmp_160,
          __lux_tmp_161,
          __lux_tmp_162,
          __lux_tmp_163,
          __lux_tmp_x_165 + __lux_tmp_shapeX_167 + __lux_tmp_outer_169 - sx,
          __lux_tmp_y_171 + __lux_tmp_shapeY_173 + __lux_tmp_outer_175 - sy,
          __lux_tmp_inner_177,
          __lux_tmp_outer_179,
          __lux_tmp_start_181,
          __lux_tmp_finish_183,
          __lux_tmp_mode_185,
          __lux_tmp_186,
          __lux_tmp_187,
          __lux_tmp_188,
          __lux_tmp_189,
          __lux_tmp_190
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
        local __lux_tmp_a_191 = tint.a
        if __lux_tmp_a_191 == nil then
          __lux_tmp_a_191 = 255
        end
        local __lux_tmp_opacity_192 = spec.opacity
        if __lux_tmp_opacity_192 == nil then
          __lux_tmp_opacity_192 = 1
        end
        alpha = __lux_tmp_a_191 * __lux_tmp_opacity_192
      end
      if alpha <= 0 then
        return nil
      end
      local __lux_tmp_r_193 = tint.r
      if __lux_tmp_r_193 == nil then
        __lux_tmp_r_193 = 0
      end
      local __lux_tmp_g_194 = tint.g
      if __lux_tmp_g_194 == nil then
        __lux_tmp_g_194 = 0
      end
      local __lux_tmp_b_195 = tint.b
      if __lux_tmp_b_195 == nil then
        __lux_tmp_b_195 = 0
      end
      return makeColor(
        __lux_tmp_r_193,
        __lux_tmp_g_194,
        __lux_tmp_b_195,
        mathFloor(mathClamp(alpha, 0, 255) + 0.5)
      )
    end
    setupRingBackdropConstants = function(material, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, vertical, intensity)
      local sw, sh, ir, orad, sr, er, modeValue = ringShapeConstants(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      local __lux_tmp_intensity_196 = intensity
      if __lux_tmp_intensity_196 == nil then
        __lux_tmp_intensity_196 = 1
      end
      return setupParamMatrix(
        material,
        vertical and 1 or 0,
        __lux_tmp_intensity_196,
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
        local __lux_tmp_padding_197 = toNumber(spec.padding)
        if __lux_tmp_padding_197 == nil then
          __lux_tmp_padding_197 = 0
        end
        pad = mathMax(0, __lux_tmp_padding_197)
      end
      local bx = x - pad
      local by = y - pad
      local bw = w + pad * 2
      local bh = h + pad * 2
      local bi
      do
        local __lux_tmp_innerRadius_198 = toNumber(innerRadius)
        if __lux_tmp_innerRadius_198 == nil then
          __lux_tmp_innerRadius_198 = 0
        end
        bi = mathMax(0, __lux_tmp_innerRadius_198 - pad)
      end
      local bo
      do
        local __lux_tmp_outerRadius_199 = toNumber(outerRadius)
        if __lux_tmp_outerRadius_199 == nil then
          __lux_tmp_outerRadius_199 = mathMin(w, h) * 0.5
        end
        bo = mathMax(0.001, __lux_tmp_outerRadius_199 + pad)
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
        local __lux_tmp_angle_200 = toNumber(spec.angle)
        if __lux_tmp_angle_200 == nil then
          __lux_tmp_angle_200 = 135
        end
        angle = mathRad(__lux_tmp_angle_200)
      end
      local smoke
      local __lux_match_201 = spec.kind
      if __lux_match_201 == "smoke" then
        smoke = true
      else
        smoke = false
      end
      local worn
      local __lux_match_202 = spec.kind
      if __lux_match_202 == "worn" then
        worn = true
      else
        worn = false
      end
      local pz
      if worn then
        do
          local __lux_tmp_scale_203 = toNumber(spec.scale)
          if __lux_tmp_scale_203 == nil then
            __lux_tmp_scale_203 = 32
          end
          pz = mathMax(1, __lux_tmp_scale_203)
        end
      else
        if smoke then
          do
            local __lux_tmp_scale_204 = toNumber(spec.scale)
            if __lux_tmp_scale_204 == nil then
              __lux_tmp_scale_204 = 140
            end
            pz = mathMax(1, __lux_tmp_scale_204)
          end
        else
          do
            local __lux_tmp_spacing_205 = toNumber(spec.spacing)
            if __lux_tmp_spacing_205 == nil then
              __lux_tmp_spacing_205 = 12
            end
            pz = mathMax(1, __lux_tmp_spacing_205)
          end
        end
      end
      local pw
      if worn then
        do
          local __lux_tmp_edgeWidth_206 = toNumber(spec.edgeWidth)
          if __lux_tmp_edgeWidth_206 == nil then
            __lux_tmp_edgeWidth_206 = 7
          end
          pw = mathMax(0.5, __lux_tmp_edgeWidth_206)
        end
      else
        if smoke then
          do
            local __lux_tmp_density_207 = toNumber(spec.density)
            if __lux_tmp_density_207 == nil then
              __lux_tmp_density_207 = 0.48
            end
            pw = mathClamp(__lux_tmp_density_207, 0, 1)
          end
        else
          do
            local __lux_tmp_width_208 = toNumber(spec.width)
            if __lux_tmp_width_208 == nil then
              __lux_tmp_width_208 = 2
            end
            pw = mathMax(0.25, __lux_tmp_width_208)
          end
        end
      end
      do
        local __lux_tmp_209
        if smoke or worn then
          __lux_tmp_209 = toNumber(spec.seed)
          if __lux_tmp_209 == nil then
            __lux_tmp_209 = 0
          end
        else
          __lux_tmp_209 = 0
        end
        local __lux_tmp_210
        if smoke or worn then
          do
            local __lux_tmp_softness_211 = toNumber(spec.softness)
            if __lux_tmp_softness_211 == nil then
              local __lux_tmp_212
              if worn then
                __lux_tmp_212 = 0.10
              else
                __lux_tmp_212 = 0.3
              end
              __lux_tmp_softness_211 = __lux_tmp_212
            end
            __lux_tmp_210 = mathMax(0.001, __lux_tmp_softness_211)
          end
        else
          __lux_tmp_210 = 0
        end
        local __lux_tmp_213
        if smoke or worn then
          do
            local __lux_tmp_warp_214 = toNumber(spec.warp)
            if __lux_tmp_warp_214 == nil then
              local __lux_tmp_215
              if worn then
                __lux_tmp_215 = 0.035
              else
                __lux_tmp_215 = 0.85
              end
              __lux_tmp_warp_214 = __lux_tmp_215
            end
            __lux_tmp_213 = mathMax(0, __lux_tmp_warp_214)
          end
        else
          __lux_tmp_213 = 0
        end
        local __lux_tmp_innerRadius_216 = toNumber(innerRadius)
        if __lux_tmp_innerRadius_216 == nil then
          __lux_tmp_innerRadius_216 = 0
        end
        local __lux_tmp_outerRadius_217 = toNumber(outerRadius)
        if __lux_tmp_outerRadius_217 == nil then
          __lux_tmp_outerRadius_217 = mathMin(w, h) * 0.5
        end
        local __lux_tmp_startDeg_218 = toNumber(startDeg)
        if __lux_tmp_startDeg_218 == nil then
          __lux_tmp_startDeg_218 = 0
        end
        local __lux_tmp_endDeg_219 = toNumber(endDeg)
        if __lux_tmp_endDeg_219 == nil then
          __lux_tmp_endDeg_219 = 360
        end
        local __lux_tmp_220
        if smoke then
          __lux_tmp_220 = 1
        else
          if worn then
            __lux_tmp_220 = 2
          else
            __lux_tmp_220 = 0
          end
        end
        setupParamMatrix(
          material,
          __lux_tmp_209,
          roundrect.patternOffset(spec),
          __lux_tmp_210,
          __lux_tmp_213,
          w,
          h,
          mathMax(0, __lux_tmp_innerRadius_216),
          mathMax(0.001, __lux_tmp_outerRadius_217),
          mathRad(__lux_tmp_startDeg_218),
          mathRad(__lux_tmp_endDeg_219),
          ringModeValue(mode),
          __lux_tmp_220,
          mathCos(angle),
          mathSin(angle),
          pz,
          pw
        )
      end
      if worn then
        local edgeColor = style.asColor(spec.edgeColor, makeColor(218, 208, 184, 78))
        local er, eg, eb, ea = style.color01(edgeColor)
        do
          local __lux_tmp_fractal_221 = toNumber(spec.fractal)
          if __lux_tmp_fractal_221 == nil then
            __lux_tmp_fractal_221 = 0.44
          end
          local __lux_tmp_grain_222 = toNumber(spec.grain)
          if __lux_tmp_grain_222 == nil then
            __lux_tmp_grain_222 = 0.64
          end
          local __lux_tmp_scratches_223 = spec.scratches
          if __lux_tmp_scratches_223 == nil then
            __lux_tmp_scratches_223 = spec.scratch
          end
          local __lux_tmp_scratches_224 = toNumber(__lux_tmp_scratches_223)
          if __lux_tmp_scratches_224 == nil then
            __lux_tmp_scratches_224 = 0.30
          end
          local __lux_tmp_edge_225 = spec.edge
          if __lux_tmp_edge_225 == nil then
            __lux_tmp_edge_225 = spec.edgeWear
          end
          local __lux_tmp_edge_226 = toNumber(__lux_tmp_edge_225)
          if __lux_tmp_edge_226 == nil then
            __lux_tmp_edge_226 = 0.54
          end
          local __lux_tmp_grainScale_227 = toNumber(spec.grainScale)
          if __lux_tmp_grainScale_227 == nil then
            __lux_tmp_grainScale_227 = 5.6
          end
          local __lux_tmp_scratchScale_228 = toNumber(spec.scratchScale)
          if __lux_tmp_scratchScale_228 == nil then
            __lux_tmp_scratchScale_228 = 26
          end
          local __lux_tmp_scratchWidth_229 = toNumber(spec.scratchWidth)
          if __lux_tmp_scratchWidth_229 == nil then
            __lux_tmp_scratchWidth_229 = 0.045
          end
          local __lux_tmp_edgeWidth_230 = toNumber(spec.edgeWidth)
          if __lux_tmp_edgeWidth_230 == nil then
            __lux_tmp_edgeWidth_230 = 7
          end
          local __lux_tmp_softness_231 = toNumber(spec.softness)
          if __lux_tmp_softness_231 == nil then
            __lux_tmp_softness_231 = 0.10
          end
          local __lux_tmp_warp_232 = toNumber(spec.warp)
          if __lux_tmp_warp_232 == nil then
            __lux_tmp_warp_232 = 0.035
          end
          setupAuxConstants(
            material,
            er,
            eg,
            eb,
            ea,
            mathClamp(__lux_tmp_fractal_221, 0, 1),
            mathClamp(__lux_tmp_grain_222, 0, 1),
            mathClamp(__lux_tmp_scratches_224, 0, 1),
            mathClamp(__lux_tmp_edge_226, 0, 1),
            mathMax(0.25, __lux_tmp_grainScale_227),
            mathMax(1, __lux_tmp_scratchScale_228),
            mathClamp(__lux_tmp_scratchWidth_229, 0.005, 0.5),
            mathMax(0.5, __lux_tmp_edgeWidth_230),
            mathCos(angle),
            mathSin(angle),
            mathClamp(__lux_tmp_softness_231, 0.001, 1),
            mathMax(0, __lux_tmp_warp_232)
          )
        end
      end
      do
        local __lux_tmp_color_233 = spec.color
        if __lux_tmp_color_233 == nil then
          __lux_tmp_color_233 = spec.tint
        end
        if __lux_tmp_color_233 == nil then
          __lux_tmp_color_233 = makeColor(255, 255, 255, 24)
        end
        style.setDrawColor(__lux_tmp_color_233)
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    drawRingBoxRaw = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, fillInput, colorInput, stroke, strokeWidthInput, shadow, outerGlow, innerGlow, backdrop, pattern, segments)
      local fill
      do
        local __lux_tmp_fillInput_234 = fillInput
        if __lux_tmp_fillInput_234 == nil then
          __lux_tmp_fillInput_234 = colorInput
        end
        if __lux_tmp_fillInput_234 == nil then
          __lux_tmp_fillInput_234 = defaultRingFill
        end
        fill = style.fillFromStyle(__lux_tmp_fillInput_234)
      end
      if not shadersActive() or not materialOK(widgetMaterials.ring) then
        return drawRingFallbackRaw(
          x + w * 0.5,
          y + h * 0.5,
          outerRadius,
          outerRadius - innerRadius,
          startDeg,
          endDeg,
          mode,
          innerRadius,
          fill,
          nil,
          stroke,
          strokeWidthInput,
          shadow,
          outerGlow,
          backdrop,
          segments
        )
      end
      local hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpreadUnused, shadowGrow, shadowStrength, shadowFalloff, shadowExtent = roundrect.shadowRaw(shadow)
      local hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpreadUnused, outerGrow, outerStrength, outerFalloff, outerExtent = roundrect.outerGlowRaw(outerGlow)
      if hasShadow or hasOuter then
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
          hasShadow,
          sr,
          sg,
          sb,
          sa,
          shadowX,
          shadowY,
          shadowWidth,
          shadowExtent,
          shadowGrow,
          shadowStrength,
          shadowFalloff,
          hasOuter,
          orr,
          og,
          ob,
          oa,
          outerX,
          outerY,
          outerWidth,
          outerExtent,
          outerGrow,
          outerStrength,
          outerFalloff
        )
      end
      if backdrop ~= nil then
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
          backdrop
        )
      end
      local hasInner, igr, igg, igb, iga, innerWidth, innerStrength, innerFalloff = roundrect.innerGlowRaw(innerGlow)
      local strokeWidth = style.strokeWidth(strokeWidthInput, 0)
      local hasStroke = style.strokeVisible(stroke, strokeWidth)
      if pattern == nil and (hasStroke or hasInner) and drawRingFxPass(
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
        stroke,
        strokeWidth,
        hasInner,
        igr,
        igg,
        igb,
        iga,
        innerWidth,
        innerStrength,
        innerFalloff
      ) then
        return
      end
      drawRingFillPass(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, fill)
      if pattern ~= nil then
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
          pattern
        )
      end
      if hasInner then
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
          true,
          igr,
          igg,
          igb,
          iga,
          innerWidth,
          innerStrength,
          innerFalloff
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
          stroke,
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
        local __lux_tmp_radius_235 = toNumber(radius)
        if __lux_tmp_radius_235 == nil then
          __lux_tmp_radius_235 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_radius_235)
      end
      local ringWidth
      do
        local __lux_tmp_width_236 = toNumber(width)
        if __lux_tmp_width_236 == nil then
          __lux_tmp_width_236 = mathMax(1, outerRadius * 0.18)
        end
        ringWidth = mathMax(0.001, __lux_tmp_width_236)
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
            return drawRingBoxRaw(
              x,
              y,
              size,
              size,
              innerRadius,
              outerRadius,
              0,
              360,
              0,
              stripped.fill,
              stripped.color,
              stripped.stroke,
              stripped.strokeWidth,
              stripped.shadow,
              stripped.outerGlow,
              stripped.innerGlow,
              stripped.backdrop,
              stripped.pattern,
              stripped.segments
            )
          end
        )
      end
      return drawRingBoxRaw(
        x,
        y,
        size,
        size,
        innerRadius,
        outerRadius,
        0,
        360,
        0,
        stripped.fill,
        stripped.color,
        stripped.stroke,
        stripped.strokeWidth,
        stripped.shadow,
        stripped.outerGlow,
        stripped.innerGlow,
        stripped.backdrop,
        stripped.pattern,
        stripped.segments
      )
    end
    ring = function(cx, cy, radius, width, fill)
      local outerRadius
      do
        local __lux_tmp_radius_237 = toNumber(radius)
        if __lux_tmp_radius_237 == nil then
          __lux_tmp_radius_237 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_radius_237)
      end
      local ringWidth
      do
        local __lux_tmp_width_238 = toNumber(width)
        if __lux_tmp_width_238 == nil then
          __lux_tmp_width_238 = mathMax(1, outerRadius * 0.18)
        end
        ringWidth = mathMax(0.001, __lux_tmp_width_238)
      end
      local innerRadius = mathMax(0, outerRadius - ringWidth)
      local x = cx - outerRadius
      local y = cy - outerRadius
      local size = outerRadius * 2
      return drawRingBoxRaw(x, y, size, size, innerRadius, outerRadius, 0, 360, 0, fill)
    end
    arcEx = function(cx, cy, radius, width, startDeg, endDeg, drawStyle)
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local transform, stripped = geometry.splitStyleTransform(resolved)
      local outerRadius
      do
        local __lux_tmp_radius_239 = toNumber(radius)
        if __lux_tmp_radius_239 == nil then
          __lux_tmp_radius_239 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_radius_239)
      end
      local arcWidth
      do
        local __lux_tmp_width_240 = toNumber(width)
        if __lux_tmp_width_240 == nil then
          __lux_tmp_width_240 = mathMax(1, outerRadius * 0.18)
        end
        arcWidth = mathMax(0.001, __lux_tmp_width_240)
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
            return drawRingBoxRaw(
              x,
              y,
              size,
              size,
              innerRadius,
              outerRadius,
              startDeg,
              endDeg,
              1,
              stripped.fill,
              stripped.color,
              stripped.stroke,
              stripped.strokeWidth,
              stripped.shadow,
              stripped.outerGlow,
              stripped.innerGlow,
              stripped.backdrop,
              stripped.pattern,
              stripped.segments
            )
          end
        )
      end
      return drawRingBoxRaw(
        x,
        y,
        size,
        size,
        innerRadius,
        outerRadius,
        startDeg,
        endDeg,
        1,
        stripped.fill,
        stripped.color,
        stripped.stroke,
        stripped.strokeWidth,
        stripped.shadow,
        stripped.outerGlow,
        stripped.innerGlow,
        stripped.backdrop,
        stripped.pattern,
        stripped.segments
      )
    end
    arc = function(cx, cy, radius, startDeg, endDeg, width, fill)
      local outerRadius
      do
        local __lux_tmp_radius_241 = toNumber(radius)
        if __lux_tmp_radius_241 == nil then
          __lux_tmp_radius_241 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_radius_241)
      end
      local arcWidth
      do
        local __lux_tmp_width_242 = toNumber(width)
        if __lux_tmp_width_242 == nil then
          __lux_tmp_width_242 = mathMax(1, outerRadius * 0.18)
        end
        arcWidth = mathMax(0.001, __lux_tmp_width_242)
      end
      local innerRadius = mathMax(0, outerRadius - arcWidth)
      local x = cx - outerRadius
      local y = cy - outerRadius
      local size = outerRadius * 2
      return drawRingBoxRaw(x, y, size, size, innerRadius, outerRadius, startDeg, endDeg, 1, fill)
    end
    sectorEx = function(cx, cy, innerRadius, outerRadius, startDeg, endDeg, drawStyle)
      local resolved = drawStyle
      if resolved == nil then
        resolved = {}
      end
      local transform, stripped = geometry.splitStyleTransform(resolved)
      do
        local __lux_tmp_outerRadius_243 = toNumber(outerRadius)
        if __lux_tmp_outerRadius_243 == nil then
          __lux_tmp_outerRadius_243 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_outerRadius_243)
      end
      do
        local __lux_tmp_innerRadius_244 = toNumber(innerRadius)
        if __lux_tmp_innerRadius_244 == nil then
          __lux_tmp_innerRadius_244 = 0
        end
        innerRadius = mathClamp(__lux_tmp_innerRadius_244, 0, outerRadius)
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
            return drawRingBoxRaw(
              x,
              y,
              size,
              size,
              innerRadius,
              outerRadius,
              startDeg,
              endDeg,
              2,
              stripped.fill,
              stripped.color,
              stripped.stroke,
              stripped.strokeWidth,
              stripped.shadow,
              stripped.outerGlow,
              stripped.innerGlow,
              stripped.backdrop,
              stripped.pattern,
              stripped.segments
            )
          end
        )
      end
      return drawRingBoxRaw(
        x,
        y,
        size,
        size,
        innerRadius,
        outerRadius,
        startDeg,
        endDeg,
        2,
        stripped.fill,
        stripped.color,
        stripped.stroke,
        stripped.strokeWidth,
        stripped.shadow,
        stripped.outerGlow,
        stripped.innerGlow,
        stripped.backdrop,
        stripped.pattern,
        stripped.segments
      )
    end
    sector = function(cx, cy, innerRadius, outerRadius, startDeg, endDeg, fill)
      do
        local __lux_tmp_outerRadius_245 = toNumber(outerRadius)
        if __lux_tmp_outerRadius_245 == nil then
          __lux_tmp_outerRadius_245 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_outerRadius_245)
      end
      do
        local __lux_tmp_innerRadius_246 = toNumber(innerRadius)
        if __lux_tmp_innerRadius_246 == nil then
          __lux_tmp_innerRadius_246 = 0
        end
        innerRadius = mathClamp(__lux_tmp_innerRadius_246, 0, outerRadius)
      end
      local x = cx - outerRadius
      local y = cy - outerRadius
      local size = outerRadius * 2
      return drawRingBoxRaw(x, y, size, size, innerRadius, outerRadius, startDeg, endDeg, 2, fill)
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
            local __lux_tmp_247
            if material ~= nil and material.IsError ~= nil and not material:IsError() then
              __lux_tmp_247 = material
            else
              __lux_tmp_247 = false
            end
            cached = __lux_tmp_247
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
        local __lux_tmp_texture_248 = texture
        if __lux_tmp_texture_248 == nil then
          __lux_tmp_texture_248 = false
        end
        imageWhiteTexture = __lux_tmp_texture_248
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
      local __lux_match_249 = kind
      if __lux_match_249 == "round" or __lux_match_249 == "rounded" or __lux_match_249 == "roundedbox" or __lux_match_249 == "roundrect" then
        return 0
      elseif __lux_match_249 == "chamfer" or __lux_match_249 == "bevel" then
        return 1
      elseif __lux_match_249 == "circle" then
        return 2
      elseif __lux_match_249 == "capsule" or __lux_match_249 == "pill" then
        return 3
      elseif __lux_match_249 == "texture" or __lux_match_249 == "alpha" or __lux_match_249 == "image" then
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
      local __lux_match_250 = normalized
      if __lux_match_250 == "a" or __lux_match_250 == "alpha" then
        return 10
      elseif __lux_match_250 == "r" or __lux_match_250 == "red" then
        return 11
      elseif __lux_match_250 == "g" or __lux_match_250 == "green" then
        return 12
      elseif __lux_match_250 == "b" or __lux_match_250 == "blue" then
        return 13
      elseif __lux_match_250 == "luma" or __lux_match_250 == "lum" or __lux_match_250 == "luminance" or __lux_match_250 == "rgb" then
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
        local __lux_tmp_u0_251 = mask.u0
        if __lux_tmp_u0_251 == nil then
          __lux_tmp_u0_251 = mask.x0
        end
        if __lux_tmp_u0_251 == nil then
          __lux_tmp_u0_251 = mask[1]
        end
        u0 = toNumber(__lux_tmp_u0_251)
        if u0 == nil then
          u0 = 0
        end
      end
      local v0
      do
        local __lux_tmp_v0_252 = mask.v0
        if __lux_tmp_v0_252 == nil then
          __lux_tmp_v0_252 = mask.y0
        end
        if __lux_tmp_v0_252 == nil then
          __lux_tmp_v0_252 = mask[2]
        end
        v0 = toNumber(__lux_tmp_v0_252)
        if v0 == nil then
          v0 = 0
        end
      end
      local u1
      do
        local __lux_tmp_u1_253 = mask.u1
        if __lux_tmp_u1_253 == nil then
          __lux_tmp_u1_253 = mask.x1
        end
        if __lux_tmp_u1_253 == nil then
          __lux_tmp_u1_253 = mask[3]
        end
        u1 = toNumber(__lux_tmp_u1_253)
        if u1 == nil then
          u1 = 1
        end
      end
      local v1
      do
        local __lux_tmp_v1_254 = mask.v1
        if __lux_tmp_v1_254 == nil then
          __lux_tmp_v1_254 = mask.y1
        end
        if __lux_tmp_v1_254 == nil then
          __lux_tmp_v1_254 = mask[4]
        end
        v1 = toNumber(__lux_tmp_v1_254)
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
      local __lux_match_255 = resolvedMask
      local __lux_tag_256
      if __lux_match_255 ~= nil then
        __lux_tag_256 = __lux_match_255.kind
      end
      if __lux_tag_256 == "chamfer" then
        local cuts = __lux_match_255.cuts
        local __lux_tmp_cuts_257 = cuts
        if __lux_tmp_cuts_257 == nil then
          __lux_tmp_cuts_257 = 0
        end
        return __lux_tmp_cuts_257
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
      material:SetTexture("$texture1", texture)
      if maskTexture ~= nil then
        material:SetTexture("$texture2", maskTexture)
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
        local __lux_tmp_tint_258 = tint
        if __lux_tmp_tint_258 == nil then
          __lux_tmp_tint_258 = color_white
        end
        style.setDrawColor(__lux_tmp_tint_258)
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
        local __lux_tmp_a_259 = tint.a
        if __lux_tmp_a_259 == nil then
          __lux_tmp_a_259 = 255
        end
        local __lux_tmp_opacity_260 = spec.opacity
        if __lux_tmp_opacity_260 == nil then
          __lux_tmp_opacity_260 = 1
        end
        alpha = __lux_tmp_a_259 * __lux_tmp_opacity_260
      end
      if alpha <= 0 then
        return nil
      end
      local __lux_tmp_r_261 = tint.r
      if __lux_tmp_r_261 == nil then
        __lux_tmp_r_261 = 0
      end
      local __lux_tmp_g_262 = tint.g
      if __lux_tmp_g_262 == nil then
        __lux_tmp_g_262 = 0
      end
      local __lux_tmp_b_263 = tint.b
      if __lux_tmp_b_263 == nil then
        __lux_tmp_b_263 = 0
      end
      return makeColor(
        __lux_tmp_r_261,
        __lux_tmp_g_262,
        __lux_tmp_b_263,
        mathFloor(mathClamp(alpha, 0, 255) + 0.5)
      )
    end
    setupImageMaskEffectParams = function(material, w, h, mask, kind, maskTexture, drawW, drawH, shadowX, shadowY, outerX, outerY, hasShadow, sr, sg, sb, sa, shadowWidth, shadowStrength, shadowFalloff, shadowExtent, hasOuter, orr, og, ob, oa, outerWidth, outerStrength, outerFalloff, outerExtent)
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
      do
        local __lux_tmp_264
        if hasShadow then
          __lux_tmp_264 = shadowExtent
        else
          __lux_tmp_264 = 0
        end
        local __lux_tmp_265
        if hasOuter then
          __lux_tmp_265 = outerExtent
        else
          __lux_tmp_265 = 0
        end
        local __lux_tmp_266
        if hasShadow then
          __lux_tmp_266 = sr
        else
          __lux_tmp_266 = 0
        end
        local __lux_tmp_267
        if hasShadow then
          __lux_tmp_267 = sg
        else
          __lux_tmp_267 = 0
        end
        local __lux_tmp_268
        if hasShadow then
          __lux_tmp_268 = sb
        else
          __lux_tmp_268 = 0
        end
        local __lux_tmp_269
        if hasShadow then
          __lux_tmp_269 = sa
        else
          __lux_tmp_269 = 0
        end
        local __lux_tmp_270
        if hasShadow then
          do
            local __lux_tmp_shadowWidth_271 = toNumber(shadowWidth)
            if __lux_tmp_shadowWidth_271 == nil then
              __lux_tmp_shadowWidth_271 = 18
            end
            __lux_tmp_270 = mathMax(0.001, __lux_tmp_shadowWidth_271)
          end
        else
          __lux_tmp_270 = 1
        end
        local __lux_tmp_272
        if hasShadow then
          do
            local __lux_tmp_shadowStrength_273 = toNumber(shadowStrength)
            if __lux_tmp_shadowStrength_273 == nil then
              __lux_tmp_shadowStrength_273 = 1
            end
            __lux_tmp_272 = mathMax(0, __lux_tmp_shadowStrength_273)
          end
        else
          __lux_tmp_272 = 0
        end
        setupParamMatrix(
          material,
          drawW,
          drawH,
          w,
          h,
          packedKind,
          mask ~= nil and geometry.imageRadius(mask.radius, w, h) or 0,
          __lux_tmp_264,
          __lux_tmp_265,
          __lux_tmp_266,
          __lux_tmp_267,
          __lux_tmp_268,
          __lux_tmp_269,
          shadowX,
          shadowY,
          __lux_tmp_270,
          __lux_tmp_272
        )
      end
      local __lux_tmp_274
      if hasOuter then
        __lux_tmp_274 = orr
      else
        __lux_tmp_274 = 0
      end
      local __lux_tmp_275
      if hasOuter then
        __lux_tmp_275 = og
      else
        __lux_tmp_275 = 0
      end
      local __lux_tmp_276
      if hasOuter then
        __lux_tmp_276 = ob
      else
        __lux_tmp_276 = 0
      end
      local __lux_tmp_277
      if hasOuter then
        __lux_tmp_277 = oa
      else
        __lux_tmp_277 = 0
      end
      local __lux_tmp_278
      if hasOuter then
        do
          local __lux_tmp_outerWidth_279 = toNumber(outerWidth)
          if __lux_tmp_outerWidth_279 == nil then
            __lux_tmp_outerWidth_279 = 18
          end
          __lux_tmp_278 = mathMax(0.001, __lux_tmp_outerWidth_279)
        end
      else
        __lux_tmp_278 = 1
      end
      local __lux_tmp_280
      if hasOuter then
        do
          local __lux_tmp_outerStrength_281 = toNumber(outerStrength)
          if __lux_tmp_outerStrength_281 == nil then
            __lux_tmp_outerStrength_281 = 1
          end
          __lux_tmp_280 = mathMax(0, __lux_tmp_outerStrength_281)
        end
      else
        __lux_tmp_280 = 0
      end
      local __lux_tmp_282
      if hasShadow then
        do
          local __lux_tmp_shadowFalloff_283 = toNumber(shadowFalloff)
          if __lux_tmp_shadowFalloff_283 == nil then
            __lux_tmp_shadowFalloff_283 = 1.8
          end
          __lux_tmp_282 = mathClamp(1 / mathMax(__lux_tmp_shadowFalloff_283, 0.001), 0.1, 1)
        end
      else
        __lux_tmp_282 = 1
      end
      local __lux_tmp_284
      if hasOuter then
        do
          local __lux_tmp_outerFalloff_285 = toNumber(outerFalloff)
          if __lux_tmp_outerFalloff_285 == nil then
            __lux_tmp_outerFalloff_285 = 1.8
          end
          __lux_tmp_284 = mathClamp(1 / mathMax(__lux_tmp_outerFalloff_285, 0.001), 0.1, 1)
        end
      else
        __lux_tmp_284 = 1
      end
      return setupAuxConstants(
        material,
        __lux_tmp_274,
        __lux_tmp_275,
        __lux_tmp_276,
        __lux_tmp_277,
        outerX,
        outerY,
        __lux_tmp_278,
        __lux_tmp_280,
        __lux_tmp_282,
        __lux_tmp_284,
        0,
        0,
        p0,
        p1,
        p2,
        p3
      )
    end
    drawImageMaskShadowOuter = function(x, y, w, h, mask, kind, hasShadow, sr, sg, sb, sa, shadowOffsetX, shadowOffsetY, shadowWidth, shadowExtent, shadowGrow, shadowStrength, shadowFalloff, hasOuter, orr, og, ob, oa, outerOffsetX, outerOffsetY, outerWidth, outerExtent, outerGrow, outerStrength, outerFalloff)
      if not hasShadow and not hasOuter or typeOf(mask) ~= "table" or not shadersActive() or not materialOK(widgetMaterials.image_mask_shadow_outer) then
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
      hasShadow = hasShadow and sa > 0 and shadowStrength > 0
      hasOuter = hasOuter and oa > 0 and outerStrength > 0
      if not hasShadow and not hasOuter then
        return false
      end
      do
        local __lux_tmp_shadowExtent_286 = toNumber(shadowExtent)
        if __lux_tmp_shadowExtent_286 == nil then
          __lux_tmp_shadowExtent_286 = 0
        end
        shadowExtent = mathMax(0, __lux_tmp_shadowExtent_286)
      end
      do
        local __lux_tmp_outerExtent_287 = toNumber(outerExtent)
        if __lux_tmp_outerExtent_287 == nil then
          __lux_tmp_outerExtent_287 = 0
        end
        outerExtent = mathMax(0, __lux_tmp_outerExtent_287)
      end
      local shadowX
      if hasShadow then
        do
          local __lux_tmp_shadowOffsetX_288 = toNumber(shadowOffsetX)
          if __lux_tmp_shadowOffsetX_288 == nil then
            __lux_tmp_shadowOffsetX_288 = 0
          end
          shadowX = x + __lux_tmp_shadowOffsetX_288 - shadowExtent
        end
      else
        shadowX = x
      end
      local shadowY
      if hasShadow then
        do
          local __lux_tmp_shadowOffsetY_289 = toNumber(shadowOffsetY)
          if __lux_tmp_shadowOffsetY_289 == nil then
            __lux_tmp_shadowOffsetY_289 = 0
          end
          shadowY = y + __lux_tmp_shadowOffsetY_289 - shadowExtent
        end
      else
        shadowY = y
      end
      local outerX
      if hasOuter then
        do
          local __lux_tmp_outerOffsetX_290 = toNumber(outerOffsetX)
          if __lux_tmp_outerOffsetX_290 == nil then
            __lux_tmp_outerOffsetX_290 = 0
          end
          outerX = x + __lux_tmp_outerOffsetX_290 - outerExtent
        end
      else
        outerX = x
      end
      local outerY
      if hasOuter then
        do
          local __lux_tmp_outerOffsetY_291 = toNumber(outerOffsetY)
          if __lux_tmp_outerOffsetY_291 == nil then
            __lux_tmp_outerOffsetY_291 = 0
          end
          outerY = y + __lux_tmp_outerOffsetY_291 - outerExtent
        end
      else
        outerY = y
      end
      local sx
      do
        local __lux_tmp_292
        if hasShadow then
          __lux_tmp_292 = shadowX
        else
          __lux_tmp_292 = outerX
        end
        local __lux_tmp_293
        if hasOuter then
          __lux_tmp_293 = outerX
        else
          __lux_tmp_293 = shadowX
        end
        sx = mathMin(__lux_tmp_292, __lux_tmp_293)
      end
      local sy
      do
        local __lux_tmp_294
        if hasShadow then
          __lux_tmp_294 = shadowY
        else
          __lux_tmp_294 = outerY
        end
        local __lux_tmp_295
        if hasOuter then
          __lux_tmp_295 = outerY
        else
          __lux_tmp_295 = shadowY
        end
        sy = mathMin(__lux_tmp_294, __lux_tmp_295)
      end
      local ex
      do
        local __lux_tmp_296
        if hasShadow then
          __lux_tmp_296 = shadowX + w + shadowExtent * 2
        else
          __lux_tmp_296 = outerX + w + outerExtent * 2
        end
        local __lux_tmp_297
        if hasOuter then
          __lux_tmp_297 = outerX + w + outerExtent * 2
        else
          __lux_tmp_297 = shadowX + w + shadowExtent * 2
        end
        ex = mathMax(__lux_tmp_296, __lux_tmp_297)
      end
      local ey
      do
        local __lux_tmp_298
        if hasShadow then
          __lux_tmp_298 = shadowY + h + shadowExtent * 2
        else
          __lux_tmp_298 = outerY + h + outerExtent * 2
        end
        local __lux_tmp_299
        if hasOuter then
          __lux_tmp_299 = outerY + h + outerExtent * 2
        else
          __lux_tmp_299 = shadowY + h + shadowExtent * 2
        end
        ey = mathMax(__lux_tmp_298, __lux_tmp_299)
      end
      local drawW = ex - sx
      local drawH = ey - sy
      local material = widgetMaterials.image_mask_shadow_outer
      if not setupImageMaskEffectParams(
        material,
        w,
        h,
        mask,
        kind,
        maskTexture,
        drawW,
        drawH,
        x - sx,
        y - sy,
        x - sx,
        y - sy,
        hasShadow,
        sr,
        sg,
        sb,
        sa,
        shadowWidth,
        shadowStrength,
        shadowFalloff,
        shadowExtent,
        hasOuter,
        orr,
        og,
        ob,
        oa,
        outerWidth,
        outerStrength,
        outerFalloff,
        outerExtent
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
      local __lux_tmp_intensity_300 = intensity
      if __lux_tmp_intensity_300 == nil then
        __lux_tmp_intensity_300 = 1
      end
      return setupParamMatrix(
        material,
        vertical and 1 or 0,
        __lux_tmp_intensity_300,
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
    drawImageMaskBackdrop = function(x, y, w, h, mask, kind, maskTexture, spec)
      if spec == nil or typeOf(mask) ~= "table" or kind == nil then
        return nil
      end
      if imageMaskUsesTexture(kind) and maskTexture == nil then
        return nil
      end
      local pad
      do
        local __lux_tmp_padding_301 = toNumber(spec.padding)
        if __lux_tmp_padding_301 == nil then
          __lux_tmp_padding_301 = 0
        end
        pad = mathMax(0, __lux_tmp_padding_301)
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
    drawImageMaskShader = function(x, y, w, h, texture, u0, v0, u1, v1, tint, background, stroke, strokeWidth, mask, kind)
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
        tint,
        stroke,
        strokeWidth,
        mask,
        kind,
        maskTexture,
        mask.sourceAlpha == true
      )
    end
  end
  do
    drawRoundImageEffect = function(x, y, w, h, radius, fill, shadow, outerGlow, backdrop, stroke, strokeWidth)
      return roundrect.drawRoundRectRaw(
        x,
        y,
        w,
        h,
        radius,
        fill,
        stroke,
        strokeWidth,
        shadow,
        outerGlow,
        nil,
        backdrop
      )
    end
    drawChamferImageEffect = function(x, y, w, h, cuts, fill, shadow, outerGlow, backdrop, stroke, strokeWidth)
      return primitives.drawChamferBoxRaw(
        x,
        y,
        w,
        h,
        cuts,
        fill,
        stroke,
        strokeWidth,
        shadow,
        outerGlow,
        nil,
        backdrop
      )
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
      local __lux_tmp_304 = background ~= nil
      if __lux_tmp_304 then
        local __lux_tmp_a_303 = background.a
        if __lux_tmp_a_303 == nil then
          __lux_tmp_a_303 = 255
        end
        __lux_tmp_304 = __lux_tmp_a_303 > 0
      end
      if __lux_tmp_304 then
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
    imageFitRectRaw = function(x, y, w, h, texture, fit, u0, v0, u1, v1)
      if typeOf(fit) ~= "string" then
        fit = "fill"
      end
      fit = string.lower(fit)
      if fit == "stretch" then
        fit = "fill"
      end
      if fit == "fill" then
        return x, y, w, h, u0, v0, u1, v1
      end
      local tw, th = geometry.textureSize(texture)
      local spanU = u1 - u0
      local spanV = v1 - v0
      local sourceW = mathMax(1, tw * spanU)
      local sourceH = mathMax(1, th * spanV)
      local sourceAspect = sourceW / sourceH
      local destAspect = mathMax(1, w) / mathMax(1, h)
      local ax = 0.5
      local ay = 0.5
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
            local newH = w / sourceAspect
            y = y + (h - newH) * ay
            h = newH
          else
            if sourceAspect < destAspect then
              local newW = h * sourceAspect
              x = x + (w - newW) * ax
              w = newW
            end
          end
        end
      end
      return x, y, w, h, u0, v0, u1, v1
    end
    imageTintRaw = function(tint)
      return style.asColor(tint, color_white)
    end
    drawImageRawFallback = function(x, y, w, h, source, radius, tint, fit)
      local texture, material = imageTextureSource(source)
      local createdMaterialFallback = material == nil
      if material == nil then
        material = imageFallbackMaterialForTexture(texture)
      end
      if material == nil then
        return
      end
      local u0, v0, u1, v1 = 0, 0, 1, 1
      x, y, w, h, u0, v0, u1, v1 = imageFitRectRaw(x, y, w, h, texture, fit, u0, v0, u1, v1)
      if w <= 0 or h <= 0 then
        return
      end
      surfaceSetMaterial(material)
      style.setDrawColor(imageTintRaw(tint))
      if hasTransform() then
        return geometry.drawTexturedQuadUV(x, y, w, h, u0, v0, u1, v1, material)
      else
        if createdMaterialFallback then
          return geometry.drawCreatedMaterialTexturedRectUV(x, y, w, h, u0, v0, u1, v1)
        else
          return geometry.drawTexturedQuadUV(x, y, w, h, u0, v0, u1, v1, material)
        end
      end
    end
    drawImageChamfer = function(x, y, w, h, texture, u0, v0, u1, v1, tint, background, stroke, strokeWidth, shadow, outerGlow, backdrop, cuts)
      if not materialOK(widgetMaterials.chamfer_texture) then
        return false
      end
      if shadow ~= nil then
        drawChamferImageEffect(x, y, w, h, cuts, transparentColor, shadow)
      end
      if outerGlow ~= nil then
        drawChamferImageEffect(x, y, w, h, cuts, transparentColor, nil, outerGlow)
      end
      if backdrop ~= nil then
        drawChamferImageEffect(x, y, w, h, cuts, transparentColor, nil, nil, backdrop)
      end
      local __lux_tmp_307 = background ~= nil
      if __lux_tmp_307 then
        local __lux_tmp_a_306 = background.a
        if __lux_tmp_a_306 == nil then
          __lux_tmp_a_306 = 255
        end
        __lux_tmp_307 = __lux_tmp_a_306 > 0
      end
      if __lux_tmp_307 then
        drawChamferImageEffect(x, y, w, h, cuts, background)
      end
      local tl, tr, br, bl = primitives.chamferTuple(cuts, w, h)
      local material = widgetMaterials.chamfer_texture
      local r, g, b, a = style.color01(tint)
      material:SetTexture("$basetexture", texture)
      setupParamMatrix(material, r, g, b, a, w, h, 0, 0, u0, v0, u1, v1, tl, tr, br, bl)
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(x, y, w, h, material)
      if style.strokeVisible(stroke, strokeWidth) then
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
          stroke,
          strokeWidth
        )
      end
      return true
    end
    imageRoundedRadius = function(radiusInput, mask, maskKind, w, h)
      local __lux_match_308 = maskKind
      if __lux_match_308 == 2 or __lux_match_308 == 3 then
        return mathMin(w, h) * 0.5
      elseif __lux_match_308 == 0 then
        if mask ~= nil and mask.radius ~= nil then
          return geometry.imageRadius(mask.radius, w, h)
        end
        return geometry.imageRadius(radiusInput, w, h)
      else
        return geometry.imageRadius(radiusInput, w, h)
      end
    end
    imageUsesSourceAlphaEffectMask = function(maskInput, radiusInput, hasShadow, hasOuter, backdrop)
      if maskInput ~= nil then
        return false
      end
      if radiusInput ~= nil then
        return false
      end
      return hasShadow or hasOuter or backdrop ~= nil
    end
    drawImageRoundRectShader = function(x, y, w, h, texture, u0, v0, u1, v1, tint, stroke, strokeWidth, radius)
      local material = widgetMaterials.roundrect_texture
      if not materialOK(material) then
        return false
      end
      material:SetTexture("$basetexture", texture)
      if stroke == nil then
        stroke = transparentColor
      end
      if strokeWidth == nil then
        strokeWidth = 0
      end
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
      style.setDrawColor(tint)
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    drawRoundImageShadowOuterPrepared = function(x, y, w, h, radius, hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread, hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread)
      return drawPreparedRoundRectEffects(
        x,
        y,
        w,
        h,
        radius,
        transparentFill,
        nil,
        0,
        hasShadow,
        sr,
        sg,
        sb,
        sa,
        shadowX,
        shadowY,
        shadowWidth,
        shadowSpread,
        shadowGrow,
        shadowStrength,
        shadowFalloff,
        shadowExtent,
        shadowCullSpread,
        hasOuter,
        orr,
        og,
        ob,
        oa,
        outerX,
        outerY,
        outerWidth,
        outerSpread,
        outerGrow,
        outerStrength,
        outerFalloff,
        outerExtent,
        outerCullSpread,
        false,
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        nil,
        nil
      )
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
      local tint = geometry.imageTint(resolved)
      local background = resolved.fill
      if background == nil then
        background = resolved.background
      end
      local stroke = resolved.stroke
      local strokeWidth = style.strokeWidthValue(resolved.strokeWidth, 0)
      local shadow = resolved.shadow
      local outerGlow = resolved.outerGlow
      local backdropInput = resolved.backdrop
      local radiusInput = resolved.radius
      local maskInput = resolved.mask
      local hasShadow = false
      local sr = 0
      local sg = 0
      local sb = 0
      local sa = 0
      local shadowX = 0
      local shadowY = 0
      local shadowWidth = 1
      local shadowSpread = 1
      local shadowGrow = 0
      local shadowStrength = 0
      local shadowFalloff = 1
      local shadowExtent = 0
      local shadowCullSpread = 0
      if shadow ~= nil and shadow ~= false then
        hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpread, shadowGrow, shadowStrength, shadowFalloff, shadowExtent, shadowCullSpread = roundrect.shadowRaw(shadow)
      end
      local hasOuter = false
      local orr = 0
      local og = 0
      local ob = 0
      local oa = 0
      local outerX = 0
      local outerY = 0
      local outerWidth = 1
      local outerSpread = 1
      local outerGrow = 0
      local outerStrength = 0
      local outerFalloff = 1
      local outerExtent = 0
      local outerCullSpread = 0
      if outerGlow ~= nil and outerGlow ~= false then
        hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpread, outerGrow, outerStrength, outerFalloff, outerExtent, outerCullSpread = roundrect.outerGlowRaw(outerGlow)
      end
      local backdrop
      if backdropInput ~= nil and backdropInput ~= false then
        backdrop = style.backdropStyle(backdropInput)
      else
        backdrop = nil
      end
      local mask
      local maskKind
      if imageUsesSourceAlphaEffectMask(maskInput, radiusInput, hasShadow, hasOuter, backdrop) then
        mask = sourceAlphaMaskScratch
        mask.source = source
        mask.u0 = u0
        mask.v0 = v0
        mask.u1 = u1
        mask.v1 = v1
        maskKind = 10
      else
        mask = style.imageMaskStyle(maskInput, resolved)
        maskKind = imageMaskKindValue(mask)
      end
      if imageMaskUsesTexture(maskKind) or maskKind == 2 then
        local maskTexture = nil
        local backdropMaskKind = maskKind
        if imageMaskUsesTexture(maskKind) then
          maskTexture = imageMaskTextureSource(mask)
          do
            local __lux_tmp_channel_309 = imageMaskTextureChannelKind(mask.channel)
            if __lux_tmp_channel_309 == nil then
              __lux_tmp_channel_309 = maskKind
            end
            backdropMaskKind = __lux_tmp_channel_309
          end
        end
        if hasShadow or hasOuter then
          drawImageMaskShadowOuter(
            x,
            y,
            w,
            h,
            mask,
            maskKind,
            hasShadow,
            sr,
            sg,
            sb,
            sa,
            shadowX,
            shadowY,
            shadowWidth,
            shadowExtent,
            shadowGrow,
            shadowStrength,
            shadowFalloff,
            hasOuter,
            orr,
            og,
            ob,
            oa,
            outerX,
            outerY,
            outerWidth,
            outerExtent,
            outerGrow,
            outerStrength,
            outerFalloff
          )
        end
        drawImageMaskBackdrop(x, y, w, h, mask, backdropMaskKind, maskTexture, backdrop)
        if drawImageMaskShader(
          x,
          y,
          w,
          h,
          texture,
          u0,
          v0,
          u1,
          v1,
          tint,
          background,
          stroke,
          strokeWidth,
          mask,
          maskKind
        ) then
          return
        end
      end
      local cuts = imageChamferCuts(resolved, mask)
      if cuts ~= nil then
        local chamferShadow
        if hasShadow then
          chamferShadow = shadow
        else
          chamferShadow = nil
        end
        local chamferOuter
        if hasOuter then
          chamferOuter = outerGlow
        else
          chamferOuter = nil
        end
        local chamferBackdrop
        if backdrop ~= nil then
          chamferBackdrop = backdropInput
        else
          chamferBackdrop = nil
        end
        if drawImageChamfer(
          x,
          y,
          w,
          h,
          texture,
          u0,
          v0,
          u1,
          v1,
          tint,
          background,
          stroke,
          strokeWidth,
          chamferShadow,
          chamferOuter,
          chamferBackdrop,
          cuts
        ) then
          return
        end
      end
      local radius = imageRoundedRadius(radiusInput, mask, maskKind, w, h)
      if hasShadow or hasOuter then
        drawRoundImageShadowOuterPrepared(
          x,
          y,
          w,
          h,
          radius,
          hasShadow,
          sr,
          sg,
          sb,
          sa,
          shadowX,
          shadowY,
          shadowWidth,
          shadowSpread,
          shadowGrow,
          shadowStrength,
          shadowFalloff,
          shadowExtent,
          shadowCullSpread,
          hasOuter,
          orr,
          og,
          ob,
          oa,
          outerX,
          outerY,
          outerWidth,
          outerSpread,
          outerGrow,
          outerStrength,
          outerFalloff,
          outerExtent,
          outerCullSpread
        )
      end
      if backdrop ~= nil then
        drawPreparedRoundRectEffects(
          x,
          y,
          w,
          h,
          radius,
          transparentFill,
          nil,
          0,
          false,
          0,
          0,
          0,
          0,
          0,
          0,
          1,
          1,
          0,
          0,
          1,
          0,
          0,
          false,
          0,
          0,
          0,
          0,
          0,
          0,
          1,
          1,
          0,
          0,
          1,
          0,
          0,
          false,
          0,
          0,
          0,
          0,
          0,
          0,
          1,
          backdrop,
          nil
        )
      end
      local __lux_tmp_312 = background ~= nil
      if __lux_tmp_312 then
        local __lux_tmp_a_311 = background.a
        if __lux_tmp_a_311 == nil then
          __lux_tmp_a_311 = 255
        end
        __lux_tmp_312 = __lux_tmp_a_311 > 0
      end
      if __lux_tmp_312 then
        drawPreparedRoundRectPlain(x, y, w, h, radius, style.fillFromStyle(background))
      end
      return drawImageRoundRectShader(
        x,
        y,
        w,
        h,
        texture,
        u0,
        v0,
        u1,
        v1,
        tint,
        stroke,
        strokeWidth,
        radius
      )
    end
    imageRaw = function(x, y, w, h, source, radius, tint, fit)
      local texture = imageTextureSource(source)
      if texture == nil then
        return
      end
      if not shadersActive() or not materialOK(widgetMaterials.roundrect_texture) then
        drawImageRawFallback(x, y, w, h, source, radius, tint, fit)
        return
      end
      local u0, v0, u1, v1 = 0, 0, 1, 1
      x, y, w, h, u0, v0, u1, v1 = imageFitRectRaw(x, y, w, h, texture, fit, u0, v0, u1, v1)
      if w <= 0 or h <= 0 then
        return
      end
      local material = widgetMaterials.roundrect_texture
      local resolvedRadius = imageRadius(radius, w, h)
      material:SetTexture("$basetexture", texture)
      setupParamMatrix(
        material,
        0,
        0,
        0,
        0,
        w,
        h,
        0,
        resolvedRadius,
        u0,
        v0,
        u1,
        v1,
        0,
        0,
        0,
        0
      )
      style.setDrawColor(imageTintRaw(tint))
      surfaceSetMaterial(material)
      return drawTexturedQuad(x, y, w, h, material)
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
      return imageRaw(x, y, w, h, source, radius, tint)
    end
    iconEx = function(x, y, w, h, source, drawStyle)
      local resolved = geometry.imageStyle(drawStyle)
      if resolved.fit == nil and resolved.objectFit == nil then
        resolved.fit = "contain"
      end
      return imageEx(x, y, w, h, source, resolved)
    end
    icon = function(x, y, w, h, source, tint)
      return imageRaw(x, y, w, h, source, nil, tint, "contain")
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
  
  __lux_exports.progressBarRaw = progressBarRaw
  __lux_exports.progressBarEx = progressBarEx
  __lux_exports.progressBar = progressBar
  __lux_exports.segmentBarRaw = segmentBarRaw
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
