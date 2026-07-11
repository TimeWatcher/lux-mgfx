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
  local surfaceSetDrawColor
  local surfaceSetMaterial
  local toNumber
  local typeOf
  local drawTexturedQuad
  local hasTransform
  local prepareBackdropBlur
  local beginPanelEffectBleed
  local endPanelEffectBleed
  local withPanelEffectBleed
  local paramMatrixProbe
  local paramMatrixSetUnpacked
  local paramMatrices
  local auxParamMatrices
  local widgetMaterials
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
    surfaceSetDrawColor = surface.SetDrawColor
    surfaceSetMaterial = surface.SetMaterial
    toNumber = tonumber
    typeOf = type
    drawTexturedQuad = geometry.drawTexturedQuad
    hasTransform = geometry.hasTransform
    prepareBackdropBlur = geometry.prepareBackdropBlur
    beginPanelEffectBleed = frame.beginPanelEffectBleed
    endPanelEffectBleed = frame.endPanelEffectBleed
    withPanelEffectBleed = frame.withPanelEffectBleed
    do
      local __lux_tmp_1
      if matrixCtor ~= nil then
        __lux_tmp_1 = matrixCtor()
      else
        __lux_tmp_1 = nil
      end
      paramMatrixProbe = __lux_tmp_1
    end
    do
      local __lux_obj_paramMatrixProbe_2 = paramMatrixProbe
      local __lux_val_SetUnpacked_3 = nil
      if __lux_obj_paramMatrixProbe_2 ~= nil then
        __lux_val_SetUnpacked_3 = __lux_obj_paramMatrixProbe_2.SetUnpacked
      end
      paramMatrixSetUnpacked = __lux_val_SetUnpacked_3
    end
    paramMatrices = {}
    auxParamMatrices = {}
    widgetMaterials = {}
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
        local __lux_tmp_Materials_4 = owner._Materials
        if __lux_tmp_Materials_4 == nil then
          __lux_tmp_Materials_4 = materialState.materials
        end
        if __lux_tmp_Materials_4 == nil then
          __lux_tmp_Materials_4 = widgetMaterials
        end
        if __lux_tmp_Materials_4 == nil then
          __lux_tmp_Materials_4 = {}
        end
        widgetMaterials = __lux_tmp_Materials_4
      end
      do
        local __lux_tmp_MaterialOK_5 = owner.MaterialOK
        if __lux_tmp_MaterialOK_5 == nil then
          __lux_tmp_MaterialOK_5 = materialState.matOK
        end
        if __lux_tmp_MaterialOK_5 == nil then
          __lux_tmp_MaterialOK_5 = widgetMatOK
        end
        widgetMatOK = __lux_tmp_MaterialOK_5
      end
      do
        local __lux_tmp_hasShaders_6 = owner.hasShaders
        if __lux_tmp_hasShaders_6 == nil then
          __lux_tmp_hasShaders_6 = widgetHasShaders
        end
        widgetHasShaders = __lux_tmp_hasShaders_6
      end
      return true
    end
    materialOK = function(material)
      return widgetMatOK ~= nil and widgetMatOK(material)
    end
    shadersActive = function()
      if forceFallbackCvar == nil and getConVar ~= nil then
        do
          local __lux_tmp_getConVar_7 = getConVar("mgfx_force_fallback")
          if __lux_tmp_getConVar_7 == nil then
            __lux_tmp_getConVar_7 = false
          end
          forceFallbackCvar = __lux_tmp_getConVar_7
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
        local __lux_tmp_a0_8 = a0
        if __lux_tmp_a0_8 == nil then
          __lux_tmp_a0_8 = 0
        end
        local __lux_tmp_b0_9 = b0
        if __lux_tmp_b0_9 == nil then
          __lux_tmp_b0_9 = 0
        end
        local __lux_tmp_c0_10 = c0
        if __lux_tmp_c0_10 == nil then
          __lux_tmp_c0_10 = 0
        end
        local __lux_tmp_d0_11 = d0
        if __lux_tmp_d0_11 == nil then
          __lux_tmp_d0_11 = 0
        end
        local __lux_tmp_a1_12 = a1
        if __lux_tmp_a1_12 == nil then
          __lux_tmp_a1_12 = 0
        end
        local __lux_tmp_b1_13 = b1
        if __lux_tmp_b1_13 == nil then
          __lux_tmp_b1_13 = 0
        end
        local __lux_tmp_c1_14 = c1
        if __lux_tmp_c1_14 == nil then
          __lux_tmp_c1_14 = 0
        end
        local __lux_tmp_d1_15 = d1
        if __lux_tmp_d1_15 == nil then
          __lux_tmp_d1_15 = 0
        end
        local __lux_tmp_a2_16 = a2
        if __lux_tmp_a2_16 == nil then
          __lux_tmp_a2_16 = 0
        end
        local __lux_tmp_b2_17 = b2
        if __lux_tmp_b2_17 == nil then
          __lux_tmp_b2_17 = 0
        end
        local __lux_tmp_c2_18 = c2
        if __lux_tmp_c2_18 == nil then
          __lux_tmp_c2_18 = 0
        end
        local __lux_tmp_d2_19 = d2
        if __lux_tmp_d2_19 == nil then
          __lux_tmp_d2_19 = 0
        end
        local __lux_tmp_a3_20 = a3
        if __lux_tmp_a3_20 == nil then
          __lux_tmp_a3_20 = 0
        end
        local __lux_tmp_b3_21 = b3
        if __lux_tmp_b3_21 == nil then
          __lux_tmp_b3_21 = 0
        end
        local __lux_tmp_c3_22 = c3
        if __lux_tmp_c3_22 == nil then
          __lux_tmp_c3_22 = 0
        end
        local __lux_tmp_d3_23 = d3
        if __lux_tmp_d3_23 == nil then
          __lux_tmp_d3_23 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_a0_8,
          __lux_tmp_b0_9,
          __lux_tmp_c0_10,
          __lux_tmp_d0_11,
          __lux_tmp_a1_12,
          __lux_tmp_b1_13,
          __lux_tmp_c1_14,
          __lux_tmp_d1_15,
          __lux_tmp_a2_16,
          __lux_tmp_b2_17,
          __lux_tmp_c2_18,
          __lux_tmp_d2_19,
          __lux_tmp_a3_20,
          __lux_tmp_b3_21,
          __lux_tmp_c3_22,
          __lux_tmp_d3_23
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
        local __lux_tmp_a0_24 = a0
        if __lux_tmp_a0_24 == nil then
          __lux_tmp_a0_24 = 0
        end
        local __lux_tmp_b0_25 = b0
        if __lux_tmp_b0_25 == nil then
          __lux_tmp_b0_25 = 0
        end
        local __lux_tmp_c0_26 = c0
        if __lux_tmp_c0_26 == nil then
          __lux_tmp_c0_26 = 0
        end
        local __lux_tmp_d0_27 = d0
        if __lux_tmp_d0_27 == nil then
          __lux_tmp_d0_27 = 0
        end
        local __lux_tmp_a1_28 = a1
        if __lux_tmp_a1_28 == nil then
          __lux_tmp_a1_28 = 0
        end
        local __lux_tmp_b1_29 = b1
        if __lux_tmp_b1_29 == nil then
          __lux_tmp_b1_29 = 0
        end
        local __lux_tmp_c1_30 = c1
        if __lux_tmp_c1_30 == nil then
          __lux_tmp_c1_30 = 0
        end
        local __lux_tmp_d1_31 = d1
        if __lux_tmp_d1_31 == nil then
          __lux_tmp_d1_31 = 0
        end
        local __lux_tmp_a2_32 = a2
        if __lux_tmp_a2_32 == nil then
          __lux_tmp_a2_32 = 0
        end
        local __lux_tmp_b2_33 = b2
        if __lux_tmp_b2_33 == nil then
          __lux_tmp_b2_33 = 0
        end
        local __lux_tmp_c2_34 = c2
        if __lux_tmp_c2_34 == nil then
          __lux_tmp_c2_34 = 0
        end
        local __lux_tmp_d2_35 = d2
        if __lux_tmp_d2_35 == nil then
          __lux_tmp_d2_35 = 0
        end
        local __lux_tmp_a3_36 = a3
        if __lux_tmp_a3_36 == nil then
          __lux_tmp_a3_36 = 0
        end
        local __lux_tmp_b3_37 = b3
        if __lux_tmp_b3_37 == nil then
          __lux_tmp_b3_37 = 0
        end
        local __lux_tmp_c3_38 = c3
        if __lux_tmp_c3_38 == nil then
          __lux_tmp_c3_38 = 0
        end
        local __lux_tmp_d3_39 = d3
        if __lux_tmp_d3_39 == nil then
          __lux_tmp_d3_39 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_a0_24,
          __lux_tmp_b0_25,
          __lux_tmp_c0_26,
          __lux_tmp_d0_27,
          __lux_tmp_a1_28,
          __lux_tmp_b1_29,
          __lux_tmp_c1_30,
          __lux_tmp_d1_31,
          __lux_tmp_a2_32,
          __lux_tmp_b2_33,
          __lux_tmp_c2_34,
          __lux_tmp_d2_35,
          __lux_tmp_a3_36,
          __lux_tmp_b3_37,
          __lux_tmp_c3_38,
          __lux_tmp_d3_39
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
            local __lux_tmp_count_40 = tickSpec.count
            if __lux_tmp_count_40 == nil then
              __lux_tmp_count_40 = 0
            end
            ticks = __lux_tmp_count_40
          end
        end
      end
      local __lux_tmp_ticks_41 = toNumber(ticks)
      if __lux_tmp_ticks_41 == nil then
        __lux_tmp_ticks_41 = 0
      end
      return glow, sheen, marker, mathClamp(mathFloor(__lux_tmp_ticks_41), 0, 31)
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
      local __lux_tmp_43 = strokeValue ~= nil and (strokeValue.a == nil or strokeValue.a > 0)
      if __lux_tmp_43 then
        local __lux_tmp_strokeWidth_42 = strokeWidth
        if __lux_tmp_strokeWidth_42 == nil then
          __lux_tmp_strokeWidth_42 = 0
        end
        __lux_tmp_43 = __lux_tmp_strokeWidth_42 > 0
      end
      return __lux_tmp_43
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
      local __lux_tmp_fill_44 = fill
      if __lux_tmp_fill_44 == nil then
        __lux_tmp_fill_44 = transparentFill
      end
      return roundrect.drawRoundRectPrepared(
        x,
        y,
        w,
        h,
        radius,
        __lux_tmp_fill_44,
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
      local __lux_tmp_fill_45 = fill
      if __lux_tmp_fill_45 == nil then
        __lux_tmp_fill_45 = transparentFill
      end
      return roundrect.drawRoundRectPrepared(
        x,
        y,
        w,
        h,
        radius,
        __lux_tmp_fill_45,
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
            local __lux_tmp_count_46 = tickSpec.count
            if __lux_tmp_count_46 == nil then
              __lux_tmp_count_46 = 0
            end
            ticks = __lux_tmp_count_46
          end
        end
      end
      local __lux_tmp_ticks_47 = toNumber(ticks)
      if __lux_tmp_ticks_47 == nil then
        __lux_tmp_ticks_47 = 0
      end
      return flags, mathClamp(mathFloor(__lux_tmp_ticks_47), 0, 31)
    end
    progressFillCanFast = function(fill)
      local __lux_match_48 = fill
      local __lux_tag_49
      if __lux_match_48 ~= nil then
        __lux_tag_49 = __lux_match_48.kind
      end
      if __lux_tag_49 == style.FILL_SOLID then
        return true
      elseif __lux_tag_49 == style.FILL_LINEAR then
        local x1 = __lux_match_48.x1
        local y1 = __lux_match_48.y1
        local x2 = __lux_match_48.x2
        local y2 = __lux_match_48.y2
        local __lux_tmp_x1_50 = x1
        if __lux_tmp_x1_50 == nil then
          __lux_tmp_x1_50 = 0
        end
        local __lux_tmp_52 = __lux_tmp_x1_50 == 0
        if __lux_tmp_52 then
          local __lux_tmp_y1_51 = y1
          if __lux_tmp_y1_51 == nil then
            __lux_tmp_y1_51 = 0
          end
          __lux_tmp_52 = __lux_tmp_y1_51 == 0
        end
        local __lux_tmp_54 = __lux_tmp_52
        if __lux_tmp_54 then
          local __lux_tmp_x2_53 = x2
          if __lux_tmp_x2_53 == nil then
            __lux_tmp_x2_53 = 1
          end
          __lux_tmp_54 = __lux_tmp_x2_53 == 1
        end
        local __lux_tmp_56 = __lux_tmp_54
        if __lux_tmp_56 then
          local __lux_tmp_y2_55 = y2
          if __lux_tmp_y2_55 == nil then
            __lux_tmp_y2_55 = 0
          end
          __lux_tmp_56 = __lux_tmp_y2_55 == 0
        end
        return __lux_tmp_56
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
        local __lux_tmp_stroke_57 = stroke
        if __lux_tmp_stroke_57 == nil then
          __lux_tmp_stroke_57 = transparentColor
        end
        r, g, b, a = style.color01(__lux_tmp_stroke_57)
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
        local __lux_tmp_flags_58 = toNumber(flags)
        if __lux_tmp_flags_58 == nil then
          __lux_tmp_flags_58 = 0
        end
        flags = mathClamp(mathFloor(__lux_tmp_flags_58), 0, 7)
      end
      do
        local __lux_tmp_ticks_59 = toNumber(ticks)
        if __lux_tmp_ticks_59 == nil then
          __lux_tmp_ticks_59 = 0
        end
        ticks = mathClamp(mathFloor(__lux_tmp_ticks_59), 0, 31)
      end
      do
        local __lux_tmp_radius_60 = toNumber(radius)
        if __lux_tmp_radius_60 == nil then
          __lux_tmp_radius_60 = 0
        end
        radius = mathClamp(__lux_tmp_radius_60, 0, 255)
      end
      do
        local __lux_tmp_inset_61 = toNumber(inset)
        if __lux_tmp_inset_61 == nil then
          __lux_tmp_inset_61 = 0
        end
        inset = mathClamp(mathFloor(__lux_tmp_inset_61), 0, 31)
      end
      do
        local __lux_tmp_strokeWidth_62 = toNumber(strokeWidth)
        if __lux_tmp_strokeWidth_62 == nil then
          __lux_tmp_strokeWidth_62 = 0
        end
        strokeWidth = mathClamp(mathFloor(__lux_tmp_strokeWidth_62), 0, 15)
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
        local __lux_tmp_stroke_63 = stroke
        if __lux_tmp_stroke_63 == nil then
          __lux_tmp_stroke_63 = transparentColor
        end
        r, g, b, a = style.color01(__lux_tmp_stroke_63)
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
      local __lux_tmp_colorA_64 = fill.colorA
      if __lux_tmp_colorA_64 == nil then
        __lux_tmp_colorA_64 = color_white
      end
      local __lux_tmp_colorB_65 = fill.colorB
      if __lux_tmp_colorB_65 == nil then
        __lux_tmp_colorB_65 = fill.colorA
      end
      if __lux_tmp_colorB_65 == nil then
        __lux_tmp_colorB_65 = color_white
      end
      return __lux_tmp_colorA_64, __lux_tmp_colorB_65
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
        local __lux_tmp_value_66 = toNumber(value)
        if __lux_tmp_value_66 == nil then
          __lux_tmp_value_66 = 0
        end
        local __lux_tmp_67
        if radius == nil then
          __lux_tmp_67 = mathMin(2, h * 0.35)
        else
          __lux_tmp_67 = radius
        end
        local __lux_tmp_toNumber_68 = toNumber(__lux_tmp_67)
        if __lux_tmp_toNumber_68 == nil then
          __lux_tmp_toNumber_68 = 0
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
          mathClamp(__lux_tmp_value_66, 0, 1),
          mathMax(0, __lux_tmp_toNumber_68),
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
        local __lux_tmp_value_69 = toNumber(value)
        if __lux_tmp_value_69 == nil then
          __lux_tmp_value_69 = 0
        end
        frac = mathClamp(__lux_tmp_value_69, 0, 1)
      end
      local radius = radiusInput
      if radius == nil then
        radius = mathMin(4, h * 0.5)
      end
      local inset
      do
        local __lux_tmp_paddingInput_70 = toNumber(paddingInput)
        if __lux_tmp_paddingInput_70 == nil then
          __lux_tmp_paddingInput_70 = 0
        end
        inset = mathMax(0, __lux_tmp_paddingInput_70)
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
        local __lux_tmp_r_71 = track.r
        if __lux_tmp_r_71 == nil then
          __lux_tmp_r_71 = 0
        end
        progressTrackDarkColor.r = mathFloor(__lux_tmp_r_71 * 0.65)
      end
      do
        local __lux_tmp_g_72 = track.g
        if __lux_tmp_g_72 == nil then
          __lux_tmp_g_72 = 0
        end
        progressTrackDarkColor.g = mathFloor(__lux_tmp_g_72 * 0.65)
      end
      do
        local __lux_tmp_b_73 = track.b
        if __lux_tmp_b_73 == nil then
          __lux_tmp_b_73 = 0
        end
        progressTrackDarkColor.b = mathFloor(__lux_tmp_b_73 * 0.65)
      end
      do
        local __lux_tmp_a_74 = track.a
        if __lux_tmp_a_74 == nil then
          __lux_tmp_a_74 = 190
        end
        progressTrackDarkColor.a = __lux_tmp_a_74
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
      local __lux_tmp_fill_75 = stripped.fill
      if __lux_tmp_fill_75 == nil then
        __lux_tmp_fill_75 = stripped.color
      end
      return progressBarRaw(
        x,
        y,
        w,
        h,
        value,
        stripped.radius,
        stripped.track,
        __lux_tmp_fill_75,
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
        local __lux_tmp_segments_76 = toNumber(segments)
        if __lux_tmp_segments_76 == nil then
          __lux_tmp_segments_76 = 10
        end
        count = mathClamp(mathFloor(__lux_tmp_segments_76), 1, 128)
      end
      local gap
      do
        local __lux_tmp_gapInput_77 = toNumber(gapInput)
        if __lux_tmp_gapInput_77 == nil then
          __lux_tmp_gapInput_77 = 2
        end
        gap = mathMax(0, __lux_tmp_gapInput_77)
      end
      local frac
      do
        local __lux_tmp_value_78 = toNumber(value)
        if __lux_tmp_value_78 == nil then
          __lux_tmp_value_78 = 0
        end
        frac = mathClamp(__lux_tmp_value_78, 0, 1)
      end
      local active = mathFloor(frac * count + 0.0001)
      local fill
      do
        local __lux_tmp_fillInput_79 = fillInput
        if __lux_tmp_fillInput_79 == nil then
          __lux_tmp_fillInput_79 = colorInput
        end
        if __lux_tmp_fillInput_79 == nil then
          __lux_tmp_fillInput_79 = defaultSegmentFill
        end
        fill = style.fillFromStyle(__lux_tmp_fillInput_79)
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
        local __lux_tmp_endDeg_80 = endDeg
        if __lux_tmp_endDeg_80 == nil then
          __lux_tmp_endDeg_80 = 360
        end
        local __lux_tmp_startDeg_81 = startDeg
        if __lux_tmp_startDeg_81 == nil then
          __lux_tmp_startDeg_81 = 0
        end
        sweep = mathAbs(__lux_tmp_endDeg_80 - __lux_tmp_startDeg_81)
      end
      return mathClamp(mathFloor(sweep / 360 * fallback), 3, fallback)
    end
    ringModeValue = function(mode)
      local __lux_match_82 = mode
      if __lux_match_82 == "sector" or __lux_match_82 == 2 then
        return 2
      elseif __lux_match_82 == "arc" or __lux_match_82 == true or __lux_match_82 == 1 then
        return 1
      else
        return 0
      end
    end
    ringShapeConstants = function(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      local __lux_tmp_innerRadius_83 = toNumber(innerRadius)
      if __lux_tmp_innerRadius_83 == nil then
        __lux_tmp_innerRadius_83 = 0
      end
      local __lux_tmp_outerRadius_84 = toNumber(outerRadius)
      if __lux_tmp_outerRadius_84 == nil then
        __lux_tmp_outerRadius_84 = mathMin(w, h) * 0.5
      end
      local __lux_tmp_startDeg_85 = toNumber(startDeg)
      if __lux_tmp_startDeg_85 == nil then
        __lux_tmp_startDeg_85 = 0
      end
      local __lux_tmp_endDeg_86 = toNumber(endDeg)
      if __lux_tmp_endDeg_86 == nil then
        __lux_tmp_endDeg_86 = 360
      end
      return w, h, mathMax(0, __lux_tmp_innerRadius_83), mathMax(0.001, __lux_tmp_outerRadius_84), mathRad(__lux_tmp_startDeg_85), mathRad(__lux_tmp_endDeg_86), ringModeValue(mode)
    end
    ringFillParams = function(fill)
      local __lux_match_87 = fill
      local __lux_tag_88
      if __lux_match_87 ~= nil then
        __lux_tag_88 = __lux_match_87.kind
      end
      if __lux_tag_88 == style.FILL_LINEAR then
        local x1 = __lux_match_87.x1
        local y1 = __lux_match_87.y1
        local x2 = __lux_match_87.x2
        local y2 = __lux_match_87.y2
        local __lux_tmp_x1_89 = x1
        if __lux_tmp_x1_89 == nil then
          __lux_tmp_x1_89 = 0
        end
        local __lux_tmp_y1_90 = y1
        if __lux_tmp_y1_90 == nil then
          __lux_tmp_y1_90 = 0
        end
        local __lux_tmp_x2_91 = x2
        if __lux_tmp_x2_91 == nil then
          __lux_tmp_x2_91 = 1
        end
        local __lux_tmp_y2_92 = y2
        if __lux_tmp_y2_92 == nil then
          __lux_tmp_y2_92 = 0
        end
        return __lux_tmp_x1_89, __lux_tmp_y1_90, __lux_tmp_x2_91, __lux_tmp_y2_92
      elseif __lux_tag_88 == style.FILL_RADIAL then
        local cx = __lux_match_87.cx
        local cy = __lux_match_87.cy
        local radius = __lux_match_87.radius
        local localRadial = fill.localRadial == true or fill.ringRadial == true or fill.sectorRadial == true
        local __lux_tmp_cx_93 = cx
        if __lux_tmp_cx_93 == nil then
          __lux_tmp_cx_93 = 0.5
        end
        local __lux_tmp_cy_94 = cy
        if __lux_tmp_cy_94 == nil then
          __lux_tmp_cy_94 = 0.5
        end
        local __lux_tmp_radius_95 = radius
        if __lux_tmp_radius_95 == nil then
          __lux_tmp_radius_95 = 0.5
        end
        local __lux_tmp_96
        if localRadial then
          __lux_tmp_96 = 1
        else
          __lux_tmp_96 = 0
        end
        return __lux_tmp_cx_93, __lux_tmp_cy_94, __lux_tmp_radius_95, __lux_tmp_96
      elseif __lux_tag_88 == style.FILL_CONIC then
        local cx = __lux_match_87.cx
        local cy = __lux_match_87.cy
        local rotation = __lux_match_87.rotation
        local localAngular = fill.localAngular == true or fill.shapeAngular == true
        local __lux_tmp_cx_97 = cx
        if __lux_tmp_cx_97 == nil then
          __lux_tmp_cx_97 = 0.5
        end
        local __lux_tmp_cy_98 = cy
        if __lux_tmp_cy_98 == nil then
          __lux_tmp_cy_98 = 0.5
        end
        local __lux_tmp_99
        if localAngular then
          __lux_tmp_99 = 1
        else
          __lux_tmp_99 = 0
        end
        return __lux_tmp_cx_97, __lux_tmp_cy_98, style.normalizedRotation(rotation), __lux_tmp_99
      else
        local __lux_unused_100 = nil
      end
      return 0, 0, 1, 0
    end
    ringFillNeedsLut = function(fill)
      local __lux_match_101 = fill
      local __lux_tag_102
      if __lux_match_101 ~= nil then
        __lux_tag_102 = __lux_match_101.kind
      end
      if __lux_tag_102 == style.FILL_LINEAR or __lux_tag_102 == style.FILL_RADIAL or __lux_tag_102 == style.FILL_CONIC then
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
        local __lux_tmp_segmentsInput_103 = segmentsInput
        if __lux_tmp_segmentsInput_103 == nil then
          __lux_tmp_segmentsInput_103 = 64
        end
        segments = arcSegmentCount(outerRadius, startDeg, endDeg, __lux_tmp_segmentsInput_103)
      end
      local startRad
      do
        local __lux_tmp_startDeg_104 = startDeg
        if __lux_tmp_startDeg_104 == nil then
          __lux_tmp_startDeg_104 = 0
        end
        startRad = mathRad(__lux_tmp_startDeg_104)
      end
      local endRad
      do
        local __lux_tmp_endDeg_105 = endDeg
        if __lux_tmp_endDeg_105 == nil then
          __lux_tmp_endDeg_105 = 360
        end
        endRad = mathRad(__lux_tmp_endDeg_105)
      end
      if mode == 2 then
        local innerRadius
        do
          local __lux_tmp_innerRadiusInput_106 = toNumber(innerRadiusInput)
          if __lux_tmp_innerRadiusInput_106 == nil then
            __lux_tmp_innerRadiusInput_106 = mathMax(0, outerRadius - arcWidth)
          end
          innerRadius = mathClamp(__lux_tmp_innerRadiusInput_106, 0, outerRadius)
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
        local __lux_tmp_kind_107 = fill.kind
        if __lux_tmp_kind_107 == nil then
          __lux_tmp_kind_107 = style.FILL_SOLID
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
          __lux_tmp_kind_107,
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
        local __lux_tmp_colorA_108 = fill.colorA
        if __lux_tmp_colorA_108 == nil then
          __lux_tmp_colorA_108 = color_white
        end
        style.setDrawColor(__lux_tmp_colorA_108)
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
          local __lux_tmp_glowWidth_109 = toNumber(glowWidth)
          if __lux_tmp_glowWidth_109 == nil then
            __lux_tmp_glowWidth_109 = 8
          end
          glowWidth = mathMax(0.001, __lux_tmp_glowWidth_109)
        end
        do
          local __lux_tmp_glowStrength_110 = toNumber(glowStrength)
          if __lux_tmp_glowStrength_110 == nil then
            __lux_tmp_glowStrength_110 = 1
          end
          glowStrength = mathMax(0, __lux_tmp_glowStrength_110)
        end
        do
          local __lux_tmp_glowFalloff_111 = toNumber(glowFalloff)
          if __lux_tmp_glowFalloff_111 == nil then
            __lux_tmp_glowFalloff_111 = 1.65
          end
          glowFalloff = mathMax(0.001, __lux_tmp_glowFalloff_111)
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
        local __lux_tmp_kind_112 = fill.kind
        if __lux_tmp_kind_112 == nil then
          __lux_tmp_kind_112 = style.FILL_SOLID
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
          __lux_tmp_kind_112,
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
        local __lux_tmp_colorA_113 = fill.colorA
        if __lux_tmp_colorA_113 == nil then
          __lux_tmp_colorA_113 = color_white
        end
        style.setDrawColor(__lux_tmp_colorA_113)
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
        local __lux_tmp_glowWidth_114 = toNumber(glowWidth)
        if __lux_tmp_glowWidth_114 == nil then
          __lux_tmp_glowWidth_114 = 8
        end
        local __lux_tmp_glowStrength_115 = toNumber(glowStrength)
        if __lux_tmp_glowStrength_115 == nil then
          __lux_tmp_glowStrength_115 = 1
        end
        local __lux_tmp_glowFalloff_116 = toNumber(glowFalloff)
        if __lux_tmp_glowFalloff_116 == nil then
          __lux_tmp_glowFalloff_116 = 1.65
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
          mathMax(0.001, __lux_tmp_glowWidth_114),
          mathMax(0, __lux_tmp_glowStrength_115),
          mathMax(0.001, __lux_tmp_glowFalloff_116),
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
        local __lux_tmp_grow_117 = toNumber(grow)
        if __lux_tmp_grow_117 == nil then
          __lux_tmp_grow_117 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_117)
      end
      do
        local __lux_tmp_ox_118 = toNumber(ox)
        if __lux_tmp_ox_118 == nil then
          __lux_tmp_ox_118 = 0
        end
        ox = __lux_tmp_ox_118
      end
      do
        local __lux_tmp_oy_119 = toNumber(oy)
        if __lux_tmp_oy_119 == nil then
          __lux_tmp_oy_119 = 0
        end
        oy = __lux_tmp_oy_119
      end
      do
        local __lux_tmp_width_120 = toNumber(width)
        if __lux_tmp_width_120 == nil then
          __lux_tmp_width_120 = 18
        end
        width = mathMax(0.001, __lux_tmp_width_120)
      end
      do
        local __lux_tmp_extent_121 = toNumber(extent)
        if __lux_tmp_extent_121 == nil then
          __lux_tmp_extent_121 = width
        end
        extent = mathMax(1, __lux_tmp_extent_121)
      end
      do
        local __lux_tmp_strength_122 = toNumber(strength)
        if __lux_tmp_strength_122 == nil then
          __lux_tmp_strength_122 = 1
        end
        strength = mathMax(0, __lux_tmp_strength_122)
      end
      do
        local __lux_tmp_falloff_123 = toNumber(falloff)
        if __lux_tmp_falloff_123 == nil then
          __lux_tmp_falloff_123 = 1.9
        end
        falloff = mathMax(0.001, __lux_tmp_falloff_123)
      end
      local gx = x + ox - grow
      local gy = y + oy - grow
      local gw = w + grow * 2
      local gh = h + grow * 2
      local gi
      do
        local __lux_tmp_innerRadius_124 = toNumber(innerRadius)
        if __lux_tmp_innerRadius_124 == nil then
          __lux_tmp_innerRadius_124 = 0
        end
        gi = mathMax(0, __lux_tmp_innerRadius_124 - grow)
      end
      local go
      do
        local __lux_tmp_outerRadius_125 = toNumber(outerRadius)
        if __lux_tmp_outerRadius_125 == nil then
          __lux_tmp_outerRadius_125 = mathMin(w, h) * 0.5
        end
        go = mathMax(0.001, __lux_tmp_outerRadius_125 + grow)
      end
      local spread = extent
      if biasOffset then
        local left, top, right, bottom = roundrect.glowBiasPads(spread, ox, oy)
        local __lux_tmp_startDeg_126 = toNumber(startDeg)
        if __lux_tmp_startDeg_126 == nil then
          __lux_tmp_startDeg_126 = 0
        end
        local __lux_tmp_endDeg_127 = toNumber(endDeg)
        if __lux_tmp_endDeg_127 == nil then
          __lux_tmp_endDeg_127 = 360
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
          start = mathRad(__lux_tmp_startDeg_126),
          finish = mathRad(__lux_tmp_endDeg_127),
          mode = ringModeValue(mode),
          width = width,
          strength = strength,
          falloff = falloff,
        }
      end
      local __lux_tmp_startDeg_128 = toNumber(startDeg)
      if __lux_tmp_startDeg_128 == nil then
        __lux_tmp_startDeg_128 = 0
      end
      local __lux_tmp_endDeg_129 = toNumber(endDeg)
      if __lux_tmp_endDeg_129 == nil then
        __lux_tmp_endDeg_129 = 360
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
        start = mathRad(__lux_tmp_startDeg_128),
        finish = mathRad(__lux_tmp_endDeg_129),
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
        local __lux_tmp_130
        if shadowBounds ~= nil then
          __lux_tmp_130 = sr
        else
          __lux_tmp_130 = 0
        end
        local __lux_tmp_131
        if shadowBounds ~= nil then
          __lux_tmp_131 = sg
        else
          __lux_tmp_131 = 0
        end
        local __lux_tmp_132
        if shadowBounds ~= nil then
          __lux_tmp_132 = sb
        else
          __lux_tmp_132 = 0
        end
        local __lux_tmp_133
        if shadowBounds ~= nil then
          __lux_tmp_133 = sa
        else
          __lux_tmp_133 = 0
        end
        local __lux_obj_shadowBounds_134 = shadowBounds
        local __lux_tmp_x_135 = nil
        if __lux_obj_shadowBounds_134 ~= nil then
          __lux_tmp_x_135 = __lux_obj_shadowBounds_134.x
        end
        if __lux_tmp_x_135 == nil then
          __lux_tmp_x_135 = x
        end
        local __lux_obj_shadowBounds_136 = shadowBounds
        local __lux_tmp_shapeX_137 = nil
        if __lux_obj_shadowBounds_136 ~= nil then
          __lux_tmp_shapeX_137 = __lux_obj_shadowBounds_136.shapeX
        end
        if __lux_tmp_shapeX_137 == nil then
          __lux_tmp_shapeX_137 = 0
        end
        local __lux_obj_shadowBounds_138 = shadowBounds
        local __lux_tmp_outer_139 = nil
        if __lux_obj_shadowBounds_138 ~= nil then
          __lux_tmp_outer_139 = __lux_obj_shadowBounds_138.outer
        end
        if __lux_tmp_outer_139 == nil then
          __lux_tmp_outer_139 = 0
        end
        local __lux_obj_shadowBounds_140 = shadowBounds
        local __lux_tmp_y_141 = nil
        if __lux_obj_shadowBounds_140 ~= nil then
          __lux_tmp_y_141 = __lux_obj_shadowBounds_140.y
        end
        if __lux_tmp_y_141 == nil then
          __lux_tmp_y_141 = y
        end
        local __lux_obj_shadowBounds_142 = shadowBounds
        local __lux_tmp_shapeY_143 = nil
        if __lux_obj_shadowBounds_142 ~= nil then
          __lux_tmp_shapeY_143 = __lux_obj_shadowBounds_142.shapeY
        end
        if __lux_tmp_shapeY_143 == nil then
          __lux_tmp_shapeY_143 = 0
        end
        local __lux_obj_shadowBounds_144 = shadowBounds
        local __lux_tmp_outer_145 = nil
        if __lux_obj_shadowBounds_144 ~= nil then
          __lux_tmp_outer_145 = __lux_obj_shadowBounds_144.outer
        end
        if __lux_tmp_outer_145 == nil then
          __lux_tmp_outer_145 = 0
        end
        local __lux_obj_shadowBounds_146 = shadowBounds
        local __lux_tmp_inner_147 = nil
        if __lux_obj_shadowBounds_146 ~= nil then
          __lux_tmp_inner_147 = __lux_obj_shadowBounds_146.inner
        end
        if __lux_tmp_inner_147 == nil then
          __lux_tmp_inner_147 = 0
        end
        local __lux_obj_shadowBounds_148 = shadowBounds
        local __lux_tmp_outer_149 = nil
        if __lux_obj_shadowBounds_148 ~= nil then
          __lux_tmp_outer_149 = __lux_obj_shadowBounds_148.outer
        end
        if __lux_tmp_outer_149 == nil then
          __lux_tmp_outer_149 = 1
        end
        local __lux_obj_shadowBounds_150 = shadowBounds
        local __lux_tmp_start_151 = nil
        if __lux_obj_shadowBounds_150 ~= nil then
          __lux_tmp_start_151 = __lux_obj_shadowBounds_150.start
        end
        if __lux_tmp_start_151 == nil then
          __lux_tmp_start_151 = 0
        end
        local __lux_obj_shadowBounds_152 = shadowBounds
        local __lux_tmp_finish_153 = nil
        if __lux_obj_shadowBounds_152 ~= nil then
          __lux_tmp_finish_153 = __lux_obj_shadowBounds_152.finish
        end
        if __lux_tmp_finish_153 == nil then
          __lux_tmp_finish_153 = mathRad(360)
        end
        local __lux_obj_shadowBounds_154 = shadowBounds
        local __lux_tmp_mode_155 = nil
        if __lux_obj_shadowBounds_154 ~= nil then
          __lux_tmp_mode_155 = __lux_obj_shadowBounds_154.mode
        end
        if __lux_tmp_mode_155 == nil then
          __lux_tmp_mode_155 = 0
        end
        local __lux_tmp_156
        if shadowBounds ~= nil then
          __lux_tmp_156 = shadowBounds.width
        else
          __lux_tmp_156 = 1
        end
        setupParamMatrix(
          material,
          drawW,
          drawH,
          0,
          0,
          __lux_tmp_130,
          __lux_tmp_131,
          __lux_tmp_132,
          __lux_tmp_133,
          __lux_tmp_x_135 + __lux_tmp_shapeX_137 + __lux_tmp_outer_139 - sx,
          __lux_tmp_y_141 + __lux_tmp_shapeY_143 + __lux_tmp_outer_145 - sy,
          __lux_tmp_inner_147,
          __lux_tmp_outer_149,
          __lux_tmp_start_151,
          __lux_tmp_finish_153,
          __lux_tmp_mode_155,
          __lux_tmp_156
        )
      end
      do
        local __lux_tmp_157
        if outerBounds ~= nil then
          __lux_tmp_157 = orr
        else
          __lux_tmp_157 = 0
        end
        local __lux_tmp_158
        if outerBounds ~= nil then
          __lux_tmp_158 = og
        else
          __lux_tmp_158 = 0
        end
        local __lux_tmp_159
        if outerBounds ~= nil then
          __lux_tmp_159 = ob
        else
          __lux_tmp_159 = 0
        end
        local __lux_tmp_160
        if outerBounds ~= nil then
          __lux_tmp_160 = oa
        else
          __lux_tmp_160 = 0
        end
        local __lux_obj_outerBounds_161 = outerBounds
        local __lux_tmp_x_162 = nil
        if __lux_obj_outerBounds_161 ~= nil then
          __lux_tmp_x_162 = __lux_obj_outerBounds_161.x
        end
        if __lux_tmp_x_162 == nil then
          __lux_tmp_x_162 = x
        end
        local __lux_obj_outerBounds_163 = outerBounds
        local __lux_tmp_shapeX_164 = nil
        if __lux_obj_outerBounds_163 ~= nil then
          __lux_tmp_shapeX_164 = __lux_obj_outerBounds_163.shapeX
        end
        if __lux_tmp_shapeX_164 == nil then
          __lux_tmp_shapeX_164 = 0
        end
        local __lux_obj_outerBounds_165 = outerBounds
        local __lux_tmp_outer_166 = nil
        if __lux_obj_outerBounds_165 ~= nil then
          __lux_tmp_outer_166 = __lux_obj_outerBounds_165.outer
        end
        if __lux_tmp_outer_166 == nil then
          __lux_tmp_outer_166 = 0
        end
        local __lux_obj_outerBounds_167 = outerBounds
        local __lux_tmp_y_168 = nil
        if __lux_obj_outerBounds_167 ~= nil then
          __lux_tmp_y_168 = __lux_obj_outerBounds_167.y
        end
        if __lux_tmp_y_168 == nil then
          __lux_tmp_y_168 = y
        end
        local __lux_obj_outerBounds_169 = outerBounds
        local __lux_tmp_shapeY_170 = nil
        if __lux_obj_outerBounds_169 ~= nil then
          __lux_tmp_shapeY_170 = __lux_obj_outerBounds_169.shapeY
        end
        if __lux_tmp_shapeY_170 == nil then
          __lux_tmp_shapeY_170 = 0
        end
        local __lux_obj_outerBounds_171 = outerBounds
        local __lux_tmp_outer_172 = nil
        if __lux_obj_outerBounds_171 ~= nil then
          __lux_tmp_outer_172 = __lux_obj_outerBounds_171.outer
        end
        if __lux_tmp_outer_172 == nil then
          __lux_tmp_outer_172 = 0
        end
        local __lux_obj_outerBounds_173 = outerBounds
        local __lux_tmp_inner_174 = nil
        if __lux_obj_outerBounds_173 ~= nil then
          __lux_tmp_inner_174 = __lux_obj_outerBounds_173.inner
        end
        if __lux_tmp_inner_174 == nil then
          __lux_tmp_inner_174 = 0
        end
        local __lux_obj_outerBounds_175 = outerBounds
        local __lux_tmp_outer_176 = nil
        if __lux_obj_outerBounds_175 ~= nil then
          __lux_tmp_outer_176 = __lux_obj_outerBounds_175.outer
        end
        if __lux_tmp_outer_176 == nil then
          __lux_tmp_outer_176 = 1
        end
        local __lux_obj_outerBounds_177 = outerBounds
        local __lux_tmp_start_178 = nil
        if __lux_obj_outerBounds_177 ~= nil then
          __lux_tmp_start_178 = __lux_obj_outerBounds_177.start
        end
        if __lux_tmp_start_178 == nil then
          __lux_tmp_start_178 = 0
        end
        local __lux_obj_outerBounds_179 = outerBounds
        local __lux_tmp_finish_180 = nil
        if __lux_obj_outerBounds_179 ~= nil then
          __lux_tmp_finish_180 = __lux_obj_outerBounds_179.finish
        end
        if __lux_tmp_finish_180 == nil then
          __lux_tmp_finish_180 = mathRad(360)
        end
        local __lux_obj_outerBounds_181 = outerBounds
        local __lux_tmp_mode_182 = nil
        if __lux_obj_outerBounds_181 ~= nil then
          __lux_tmp_mode_182 = __lux_obj_outerBounds_181.mode
        end
        if __lux_tmp_mode_182 == nil then
          __lux_tmp_mode_182 = 0
        end
        local __lux_tmp_183
        if outerBounds ~= nil then
          __lux_tmp_183 = outerBounds.width
        else
          __lux_tmp_183 = 1
        end
        local __lux_tmp_184
        if shadowBounds ~= nil then
          __lux_tmp_184 = shadowBounds.falloff
        else
          __lux_tmp_184 = 1
        end
        local __lux_tmp_185
        if shadowBounds ~= nil then
          __lux_tmp_185 = shadowBounds.strength
        else
          __lux_tmp_185 = 0
        end
        local __lux_tmp_186
        if outerBounds ~= nil then
          __lux_tmp_186 = outerBounds.falloff
        else
          __lux_tmp_186 = 1
        end
        local __lux_tmp_187
        if outerBounds ~= nil then
          __lux_tmp_187 = outerBounds.strength
        else
          __lux_tmp_187 = 0
        end
        setupAuxConstants(
          material,
          __lux_tmp_157,
          __lux_tmp_158,
          __lux_tmp_159,
          __lux_tmp_160,
          __lux_tmp_x_162 + __lux_tmp_shapeX_164 + __lux_tmp_outer_166 - sx,
          __lux_tmp_y_168 + __lux_tmp_shapeY_170 + __lux_tmp_outer_172 - sy,
          __lux_tmp_inner_174,
          __lux_tmp_outer_176,
          __lux_tmp_start_178,
          __lux_tmp_finish_180,
          __lux_tmp_mode_182,
          __lux_tmp_183,
          __lux_tmp_184,
          __lux_tmp_185,
          __lux_tmp_186,
          __lux_tmp_187
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
        local __lux_tmp_a_188 = tint.a
        if __lux_tmp_a_188 == nil then
          __lux_tmp_a_188 = 255
        end
        local __lux_tmp_opacity_189 = spec.opacity
        if __lux_tmp_opacity_189 == nil then
          __lux_tmp_opacity_189 = 1
        end
        alpha = __lux_tmp_a_188 * __lux_tmp_opacity_189
      end
      if alpha <= 0 then
        return nil
      end
      local __lux_tmp_r_190 = tint.r
      if __lux_tmp_r_190 == nil then
        __lux_tmp_r_190 = 0
      end
      local __lux_tmp_g_191 = tint.g
      if __lux_tmp_g_191 == nil then
        __lux_tmp_g_191 = 0
      end
      local __lux_tmp_b_192 = tint.b
      if __lux_tmp_b_192 == nil then
        __lux_tmp_b_192 = 0
      end
      return makeColor(
        __lux_tmp_r_190,
        __lux_tmp_g_191,
        __lux_tmp_b_192,
        mathFloor(mathClamp(alpha, 0, 255) + 0.5)
      )
    end
    setupRingBackdropConstants = function(material, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, vertical, intensity)
      local sw, sh, ir, orad, sr, er, modeValue = ringShapeConstants(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      local __lux_tmp_intensity_193 = intensity
      if __lux_tmp_intensity_193 == nil then
        __lux_tmp_intensity_193 = 1
      end
      return setupParamMatrix(
        material,
        vertical and 1 or 0,
        __lux_tmp_intensity_193,
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
        local __lux_tmp_padding_194 = toNumber(spec.padding)
        if __lux_tmp_padding_194 == nil then
          __lux_tmp_padding_194 = 0
        end
        pad = mathMax(0, __lux_tmp_padding_194)
      end
      local bx = x - pad
      local by = y - pad
      local bw = w + pad * 2
      local bh = h + pad * 2
      local bi
      do
        local __lux_tmp_innerRadius_195 = toNumber(innerRadius)
        if __lux_tmp_innerRadius_195 == nil then
          __lux_tmp_innerRadius_195 = 0
        end
        bi = mathMax(0, __lux_tmp_innerRadius_195 - pad)
      end
      local bo
      do
        local __lux_tmp_outerRadius_196 = toNumber(outerRadius)
        if __lux_tmp_outerRadius_196 == nil then
          __lux_tmp_outerRadius_196 = mathMin(w, h) * 0.5
        end
        bo = mathMax(0.001, __lux_tmp_outerRadius_196 + pad)
      end
      if spec.blur > 0 and materialOK(widgetMaterials.ring_backdrop) then
        local material = widgetMaterials.ring_backdrop
        prepareBackdropBlur(spec.blur, spec.recapture)
        surfaceSetMaterial(material)
        surfaceSetDrawColor(255, 255, 255, 255)
        setupRingBackdropConstants(material, bw, bh, bi, bo, startDeg, endDeg, mode, true, 0)
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
        local __lux_tmp_angle_197 = toNumber(spec.angle)
        if __lux_tmp_angle_197 == nil then
          __lux_tmp_angle_197 = 135
        end
        angle = mathRad(__lux_tmp_angle_197)
      end
      local smoke
      local __lux_match_198 = spec.kind
      if __lux_match_198 == "smoke" then
        smoke = true
      else
        smoke = false
      end
      local worn
      local __lux_match_199 = spec.kind
      if __lux_match_199 == "worn" then
        worn = true
      else
        worn = false
      end
      local pz
      if worn then
        do
          local __lux_tmp_scale_200 = toNumber(spec.scale)
          if __lux_tmp_scale_200 == nil then
            __lux_tmp_scale_200 = 32
          end
          pz = mathMax(1, __lux_tmp_scale_200)
        end
      else
        if smoke then
          do
            local __lux_tmp_scale_201 = toNumber(spec.scale)
            if __lux_tmp_scale_201 == nil then
              __lux_tmp_scale_201 = 140
            end
            pz = mathMax(1, __lux_tmp_scale_201)
          end
        else
          do
            local __lux_tmp_spacing_202 = toNumber(spec.spacing)
            if __lux_tmp_spacing_202 == nil then
              __lux_tmp_spacing_202 = 12
            end
            pz = mathMax(1, __lux_tmp_spacing_202)
          end
        end
      end
      local pw
      if worn then
        do
          local __lux_tmp_edgeWidth_203 = toNumber(spec.edgeWidth)
          if __lux_tmp_edgeWidth_203 == nil then
            __lux_tmp_edgeWidth_203 = 7
          end
          pw = mathMax(0.5, __lux_tmp_edgeWidth_203)
        end
      else
        if smoke then
          do
            local __lux_tmp_density_204 = toNumber(spec.density)
            if __lux_tmp_density_204 == nil then
              __lux_tmp_density_204 = 0.48
            end
            pw = mathClamp(__lux_tmp_density_204, 0, 1)
          end
        else
          do
            local __lux_tmp_width_205 = toNumber(spec.width)
            if __lux_tmp_width_205 == nil then
              __lux_tmp_width_205 = 2
            end
            pw = mathMax(0.25, __lux_tmp_width_205)
          end
        end
      end
      do
        local __lux_tmp_206
        if smoke or worn then
          __lux_tmp_206 = toNumber(spec.seed)
          if __lux_tmp_206 == nil then
            __lux_tmp_206 = 0
          end
        else
          __lux_tmp_206 = 0
        end
        local __lux_tmp_207
        if smoke or worn then
          do
            local __lux_tmp_softness_208 = toNumber(spec.softness)
            if __lux_tmp_softness_208 == nil then
              local __lux_tmp_209
              if worn then
                __lux_tmp_209 = 0.10
              else
                __lux_tmp_209 = 0.3
              end
              __lux_tmp_softness_208 = __lux_tmp_209
            end
            __lux_tmp_207 = mathMax(0.001, __lux_tmp_softness_208)
          end
        else
          __lux_tmp_207 = 0
        end
        local __lux_tmp_210
        if smoke or worn then
          do
            local __lux_tmp_warp_211 = toNumber(spec.warp)
            if __lux_tmp_warp_211 == nil then
              local __lux_tmp_212
              if worn then
                __lux_tmp_212 = 0.035
              else
                __lux_tmp_212 = 0.85
              end
              __lux_tmp_warp_211 = __lux_tmp_212
            end
            __lux_tmp_210 = mathMax(0, __lux_tmp_warp_211)
          end
        else
          __lux_tmp_210 = 0
        end
        local __lux_tmp_innerRadius_213 = toNumber(innerRadius)
        if __lux_tmp_innerRadius_213 == nil then
          __lux_tmp_innerRadius_213 = 0
        end
        local __lux_tmp_outerRadius_214 = toNumber(outerRadius)
        if __lux_tmp_outerRadius_214 == nil then
          __lux_tmp_outerRadius_214 = mathMin(w, h) * 0.5
        end
        local __lux_tmp_startDeg_215 = toNumber(startDeg)
        if __lux_tmp_startDeg_215 == nil then
          __lux_tmp_startDeg_215 = 0
        end
        local __lux_tmp_endDeg_216 = toNumber(endDeg)
        if __lux_tmp_endDeg_216 == nil then
          __lux_tmp_endDeg_216 = 360
        end
        local __lux_tmp_217
        if smoke then
          __lux_tmp_217 = 1
        else
          if worn then
            __lux_tmp_217 = 2
          else
            __lux_tmp_217 = 0
          end
        end
        setupParamMatrix(
          material,
          __lux_tmp_206,
          roundrect.patternOffset(spec),
          __lux_tmp_207,
          __lux_tmp_210,
          w,
          h,
          mathMax(0, __lux_tmp_innerRadius_213),
          mathMax(0.001, __lux_tmp_outerRadius_214),
          mathRad(__lux_tmp_startDeg_215),
          mathRad(__lux_tmp_endDeg_216),
          ringModeValue(mode),
          __lux_tmp_217,
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
          local __lux_tmp_fractal_218 = toNumber(spec.fractal)
          if __lux_tmp_fractal_218 == nil then
            __lux_tmp_fractal_218 = 0.44
          end
          local __lux_tmp_grain_219 = toNumber(spec.grain)
          if __lux_tmp_grain_219 == nil then
            __lux_tmp_grain_219 = 0.64
          end
          local __lux_tmp_scratches_220 = spec.scratches
          if __lux_tmp_scratches_220 == nil then
            __lux_tmp_scratches_220 = spec.scratch
          end
          local __lux_tmp_scratches_221 = toNumber(__lux_tmp_scratches_220)
          if __lux_tmp_scratches_221 == nil then
            __lux_tmp_scratches_221 = 0.30
          end
          local __lux_tmp_edge_222 = spec.edge
          if __lux_tmp_edge_222 == nil then
            __lux_tmp_edge_222 = spec.edgeWear
          end
          local __lux_tmp_edge_223 = toNumber(__lux_tmp_edge_222)
          if __lux_tmp_edge_223 == nil then
            __lux_tmp_edge_223 = 0.54
          end
          local __lux_tmp_grainScale_224 = toNumber(spec.grainScale)
          if __lux_tmp_grainScale_224 == nil then
            __lux_tmp_grainScale_224 = 5.6
          end
          local __lux_tmp_scratchScale_225 = toNumber(spec.scratchScale)
          if __lux_tmp_scratchScale_225 == nil then
            __lux_tmp_scratchScale_225 = 26
          end
          local __lux_tmp_scratchWidth_226 = toNumber(spec.scratchWidth)
          if __lux_tmp_scratchWidth_226 == nil then
            __lux_tmp_scratchWidth_226 = 0.045
          end
          local __lux_tmp_edgeWidth_227 = toNumber(spec.edgeWidth)
          if __lux_tmp_edgeWidth_227 == nil then
            __lux_tmp_edgeWidth_227 = 7
          end
          local __lux_tmp_softness_228 = toNumber(spec.softness)
          if __lux_tmp_softness_228 == nil then
            __lux_tmp_softness_228 = 0.10
          end
          local __lux_tmp_warp_229 = toNumber(spec.warp)
          if __lux_tmp_warp_229 == nil then
            __lux_tmp_warp_229 = 0.035
          end
          setupAuxConstants(
            material,
            er,
            eg,
            eb,
            ea,
            mathClamp(__lux_tmp_fractal_218, 0, 1),
            mathClamp(__lux_tmp_grain_219, 0, 1),
            mathClamp(__lux_tmp_scratches_221, 0, 1),
            mathClamp(__lux_tmp_edge_223, 0, 1),
            mathMax(0.25, __lux_tmp_grainScale_224),
            mathMax(1, __lux_tmp_scratchScale_225),
            mathClamp(__lux_tmp_scratchWidth_226, 0.005, 0.5),
            mathMax(0.5, __lux_tmp_edgeWidth_227),
            mathCos(angle),
            mathSin(angle),
            mathClamp(__lux_tmp_softness_228, 0.001, 1),
            mathMax(0, __lux_tmp_warp_229)
          )
        end
      end
      do
        local __lux_tmp_color_230 = spec.color
        if __lux_tmp_color_230 == nil then
          __lux_tmp_color_230 = spec.tint
        end
        if __lux_tmp_color_230 == nil then
          __lux_tmp_color_230 = makeColor(255, 255, 255, 24)
        end
        style.setDrawColor(__lux_tmp_color_230)
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    drawRingBoxRaw = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, fillInput, colorInput, stroke, strokeWidthInput, shadow, outerGlow, innerGlow, backdrop, pattern, segments)
      local fill
      do
        local __lux_tmp_fillInput_231 = fillInput
        if __lux_tmp_fillInput_231 == nil then
          __lux_tmp_fillInput_231 = colorInput
        end
        if __lux_tmp_fillInput_231 == nil then
          __lux_tmp_fillInput_231 = defaultRingFill
        end
        fill = style.fillFromStyle(__lux_tmp_fillInput_231)
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
        local __lux_tmp_radius_232 = toNumber(radius)
        if __lux_tmp_radius_232 == nil then
          __lux_tmp_radius_232 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_radius_232)
      end
      local ringWidth
      do
        local __lux_tmp_width_233 = toNumber(width)
        if __lux_tmp_width_233 == nil then
          __lux_tmp_width_233 = mathMax(1, outerRadius * 0.18)
        end
        ringWidth = mathMax(0.001, __lux_tmp_width_233)
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
        local __lux_tmp_radius_234 = toNumber(radius)
        if __lux_tmp_radius_234 == nil then
          __lux_tmp_radius_234 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_radius_234)
      end
      local ringWidth
      do
        local __lux_tmp_width_235 = toNumber(width)
        if __lux_tmp_width_235 == nil then
          __lux_tmp_width_235 = mathMax(1, outerRadius * 0.18)
        end
        ringWidth = mathMax(0.001, __lux_tmp_width_235)
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
        local __lux_tmp_radius_236 = toNumber(radius)
        if __lux_tmp_radius_236 == nil then
          __lux_tmp_radius_236 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_radius_236)
      end
      local arcWidth
      do
        local __lux_tmp_width_237 = toNumber(width)
        if __lux_tmp_width_237 == nil then
          __lux_tmp_width_237 = mathMax(1, outerRadius * 0.18)
        end
        arcWidth = mathMax(0.001, __lux_tmp_width_237)
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
        local __lux_tmp_radius_238 = toNumber(radius)
        if __lux_tmp_radius_238 == nil then
          __lux_tmp_radius_238 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_radius_238)
      end
      local arcWidth
      do
        local __lux_tmp_width_239 = toNumber(width)
        if __lux_tmp_width_239 == nil then
          __lux_tmp_width_239 = mathMax(1, outerRadius * 0.18)
        end
        arcWidth = mathMax(0.001, __lux_tmp_width_239)
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
        local __lux_tmp_outerRadius_240 = toNumber(outerRadius)
        if __lux_tmp_outerRadius_240 == nil then
          __lux_tmp_outerRadius_240 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_outerRadius_240)
      end
      do
        local __lux_tmp_innerRadius_241 = toNumber(innerRadius)
        if __lux_tmp_innerRadius_241 == nil then
          __lux_tmp_innerRadius_241 = 0
        end
        innerRadius = mathClamp(__lux_tmp_innerRadius_241, 0, outerRadius)
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
        local __lux_tmp_outerRadius_242 = toNumber(outerRadius)
        if __lux_tmp_outerRadius_242 == nil then
          __lux_tmp_outerRadius_242 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_outerRadius_242)
      end
      do
        local __lux_tmp_innerRadius_243 = toNumber(innerRadius)
        if __lux_tmp_innerRadius_243 == nil then
          __lux_tmp_innerRadius_243 = 0
        end
        innerRadius = mathClamp(__lux_tmp_innerRadius_243, 0, outerRadius)
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
            local __lux_tmp_244
            if material ~= nil and material.IsError ~= nil and not material:IsError() then
              __lux_tmp_244 = material
            else
              __lux_tmp_244 = false
            end
            cached = __lux_tmp_244
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
        local __lux_tmp_texture_245 = texture
        if __lux_tmp_texture_245 == nil then
          __lux_tmp_texture_245 = false
        end
        imageWhiteTexture = __lux_tmp_texture_245
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
      local __lux_match_246 = kind
      if __lux_match_246 == "round" or __lux_match_246 == "rounded" or __lux_match_246 == "roundedbox" or __lux_match_246 == "roundrect" then
        return 0
      elseif __lux_match_246 == "chamfer" or __lux_match_246 == "bevel" then
        return 1
      elseif __lux_match_246 == "circle" then
        return 2
      elseif __lux_match_246 == "capsule" or __lux_match_246 == "pill" then
        return 3
      elseif __lux_match_246 == "texture" or __lux_match_246 == "alpha" or __lux_match_246 == "image" then
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
      local __lux_match_247 = normalized
      if __lux_match_247 == "a" or __lux_match_247 == "alpha" then
        return 10
      elseif __lux_match_247 == "r" or __lux_match_247 == "red" then
        return 11
      elseif __lux_match_247 == "g" or __lux_match_247 == "green" then
        return 12
      elseif __lux_match_247 == "b" or __lux_match_247 == "blue" then
        return 13
      elseif __lux_match_247 == "luma" or __lux_match_247 == "lum" or __lux_match_247 == "luminance" or __lux_match_247 == "rgb" then
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
        local __lux_tmp_u0_248 = mask.u0
        if __lux_tmp_u0_248 == nil then
          __lux_tmp_u0_248 = mask.x0
        end
        if __lux_tmp_u0_248 == nil then
          __lux_tmp_u0_248 = mask[1]
        end
        u0 = toNumber(__lux_tmp_u0_248)
        if u0 == nil then
          u0 = 0
        end
      end
      local v0
      do
        local __lux_tmp_v0_249 = mask.v0
        if __lux_tmp_v0_249 == nil then
          __lux_tmp_v0_249 = mask.y0
        end
        if __lux_tmp_v0_249 == nil then
          __lux_tmp_v0_249 = mask[2]
        end
        v0 = toNumber(__lux_tmp_v0_249)
        if v0 == nil then
          v0 = 0
        end
      end
      local u1
      do
        local __lux_tmp_u1_250 = mask.u1
        if __lux_tmp_u1_250 == nil then
          __lux_tmp_u1_250 = mask.x1
        end
        if __lux_tmp_u1_250 == nil then
          __lux_tmp_u1_250 = mask[3]
        end
        u1 = toNumber(__lux_tmp_u1_250)
        if u1 == nil then
          u1 = 1
        end
      end
      local v1
      do
        local __lux_tmp_v1_251 = mask.v1
        if __lux_tmp_v1_251 == nil then
          __lux_tmp_v1_251 = mask.y1
        end
        if __lux_tmp_v1_251 == nil then
          __lux_tmp_v1_251 = mask[4]
        end
        v1 = toNumber(__lux_tmp_v1_251)
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
      local __lux_match_252 = resolvedMask
      local __lux_tag_253
      if __lux_match_252 ~= nil then
        __lux_tag_253 = __lux_match_252.kind
      end
      if __lux_tag_253 == "chamfer" then
        local cuts = __lux_match_252.cuts
        local __lux_tmp_cuts_254 = cuts
        if __lux_tmp_cuts_254 == nil then
          __lux_tmp_cuts_254 = 0
        end
        return __lux_tmp_cuts_254
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
        local __lux_tmp_tint_255 = tint
        if __lux_tmp_tint_255 == nil then
          __lux_tmp_tint_255 = color_white
        end
        style.setDrawColor(__lux_tmp_tint_255)
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
        local __lux_tmp_a_256 = tint.a
        if __lux_tmp_a_256 == nil then
          __lux_tmp_a_256 = 255
        end
        local __lux_tmp_opacity_257 = spec.opacity
        if __lux_tmp_opacity_257 == nil then
          __lux_tmp_opacity_257 = 1
        end
        alpha = __lux_tmp_a_256 * __lux_tmp_opacity_257
      end
      if alpha <= 0 then
        return nil
      end
      local __lux_tmp_r_258 = tint.r
      if __lux_tmp_r_258 == nil then
        __lux_tmp_r_258 = 0
      end
      local __lux_tmp_g_259 = tint.g
      if __lux_tmp_g_259 == nil then
        __lux_tmp_g_259 = 0
      end
      local __lux_tmp_b_260 = tint.b
      if __lux_tmp_b_260 == nil then
        __lux_tmp_b_260 = 0
      end
      return makeColor(
        __lux_tmp_r_258,
        __lux_tmp_g_259,
        __lux_tmp_b_260,
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
        local __lux_tmp_261
        if hasShadow then
          __lux_tmp_261 = shadowExtent
        else
          __lux_tmp_261 = 0
        end
        local __lux_tmp_262
        if hasOuter then
          __lux_tmp_262 = outerExtent
        else
          __lux_tmp_262 = 0
        end
        local __lux_tmp_263
        if hasShadow then
          __lux_tmp_263 = sr
        else
          __lux_tmp_263 = 0
        end
        local __lux_tmp_264
        if hasShadow then
          __lux_tmp_264 = sg
        else
          __lux_tmp_264 = 0
        end
        local __lux_tmp_265
        if hasShadow then
          __lux_tmp_265 = sb
        else
          __lux_tmp_265 = 0
        end
        local __lux_tmp_266
        if hasShadow then
          __lux_tmp_266 = sa
        else
          __lux_tmp_266 = 0
        end
        local __lux_tmp_267
        if hasShadow then
          do
            local __lux_tmp_shadowWidth_268 = toNumber(shadowWidth)
            if __lux_tmp_shadowWidth_268 == nil then
              __lux_tmp_shadowWidth_268 = 18
            end
            __lux_tmp_267 = mathMax(0.001, __lux_tmp_shadowWidth_268)
          end
        else
          __lux_tmp_267 = 1
        end
        local __lux_tmp_269
        if hasShadow then
          do
            local __lux_tmp_shadowStrength_270 = toNumber(shadowStrength)
            if __lux_tmp_shadowStrength_270 == nil then
              __lux_tmp_shadowStrength_270 = 1
            end
            __lux_tmp_269 = mathMax(0, __lux_tmp_shadowStrength_270)
          end
        else
          __lux_tmp_269 = 0
        end
        setupParamMatrix(
          material,
          drawW,
          drawH,
          w,
          h,
          packedKind,
          mask ~= nil and geometry.imageRadius(mask.radius, w, h) or 0,
          __lux_tmp_261,
          __lux_tmp_262,
          __lux_tmp_263,
          __lux_tmp_264,
          __lux_tmp_265,
          __lux_tmp_266,
          shadowX,
          shadowY,
          __lux_tmp_267,
          __lux_tmp_269
        )
      end
      local __lux_tmp_271
      if hasOuter then
        __lux_tmp_271 = orr
      else
        __lux_tmp_271 = 0
      end
      local __lux_tmp_272
      if hasOuter then
        __lux_tmp_272 = og
      else
        __lux_tmp_272 = 0
      end
      local __lux_tmp_273
      if hasOuter then
        __lux_tmp_273 = ob
      else
        __lux_tmp_273 = 0
      end
      local __lux_tmp_274
      if hasOuter then
        __lux_tmp_274 = oa
      else
        __lux_tmp_274 = 0
      end
      local __lux_tmp_275
      if hasOuter then
        do
          local __lux_tmp_outerWidth_276 = toNumber(outerWidth)
          if __lux_tmp_outerWidth_276 == nil then
            __lux_tmp_outerWidth_276 = 18
          end
          __lux_tmp_275 = mathMax(0.001, __lux_tmp_outerWidth_276)
        end
      else
        __lux_tmp_275 = 1
      end
      local __lux_tmp_277
      if hasOuter then
        do
          local __lux_tmp_outerStrength_278 = toNumber(outerStrength)
          if __lux_tmp_outerStrength_278 == nil then
            __lux_tmp_outerStrength_278 = 1
          end
          __lux_tmp_277 = mathMax(0, __lux_tmp_outerStrength_278)
        end
      else
        __lux_tmp_277 = 0
      end
      local __lux_tmp_279
      if hasShadow then
        do
          local __lux_tmp_shadowFalloff_280 = toNumber(shadowFalloff)
          if __lux_tmp_shadowFalloff_280 == nil then
            __lux_tmp_shadowFalloff_280 = 1.8
          end
          __lux_tmp_279 = mathClamp(1 / mathMax(__lux_tmp_shadowFalloff_280, 0.001), 0.1, 1)
        end
      else
        __lux_tmp_279 = 1
      end
      local __lux_tmp_281
      if hasOuter then
        do
          local __lux_tmp_outerFalloff_282 = toNumber(outerFalloff)
          if __lux_tmp_outerFalloff_282 == nil then
            __lux_tmp_outerFalloff_282 = 1.8
          end
          __lux_tmp_281 = mathClamp(1 / mathMax(__lux_tmp_outerFalloff_282, 0.001), 0.1, 1)
        end
      else
        __lux_tmp_281 = 1
      end
      return setupAuxConstants(
        material,
        __lux_tmp_271,
        __lux_tmp_272,
        __lux_tmp_273,
        __lux_tmp_274,
        outerX,
        outerY,
        __lux_tmp_275,
        __lux_tmp_277,
        __lux_tmp_279,
        __lux_tmp_281,
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
        local __lux_tmp_shadowExtent_283 = toNumber(shadowExtent)
        if __lux_tmp_shadowExtent_283 == nil then
          __lux_tmp_shadowExtent_283 = 0
        end
        shadowExtent = mathMax(0, __lux_tmp_shadowExtent_283)
      end
      do
        local __lux_tmp_outerExtent_284 = toNumber(outerExtent)
        if __lux_tmp_outerExtent_284 == nil then
          __lux_tmp_outerExtent_284 = 0
        end
        outerExtent = mathMax(0, __lux_tmp_outerExtent_284)
      end
      local shadowX
      if hasShadow then
        do
          local __lux_tmp_shadowOffsetX_285 = toNumber(shadowOffsetX)
          if __lux_tmp_shadowOffsetX_285 == nil then
            __lux_tmp_shadowOffsetX_285 = 0
          end
          shadowX = x + __lux_tmp_shadowOffsetX_285 - shadowExtent
        end
      else
        shadowX = x
      end
      local shadowY
      if hasShadow then
        do
          local __lux_tmp_shadowOffsetY_286 = toNumber(shadowOffsetY)
          if __lux_tmp_shadowOffsetY_286 == nil then
            __lux_tmp_shadowOffsetY_286 = 0
          end
          shadowY = y + __lux_tmp_shadowOffsetY_286 - shadowExtent
        end
      else
        shadowY = y
      end
      local outerX
      if hasOuter then
        do
          local __lux_tmp_outerOffsetX_287 = toNumber(outerOffsetX)
          if __lux_tmp_outerOffsetX_287 == nil then
            __lux_tmp_outerOffsetX_287 = 0
          end
          outerX = x + __lux_tmp_outerOffsetX_287 - outerExtent
        end
      else
        outerX = x
      end
      local outerY
      if hasOuter then
        do
          local __lux_tmp_outerOffsetY_288 = toNumber(outerOffsetY)
          if __lux_tmp_outerOffsetY_288 == nil then
            __lux_tmp_outerOffsetY_288 = 0
          end
          outerY = y + __lux_tmp_outerOffsetY_288 - outerExtent
        end
      else
        outerY = y
      end
      local sx
      do
        local __lux_tmp_289
        if hasShadow then
          __lux_tmp_289 = shadowX
        else
          __lux_tmp_289 = outerX
        end
        local __lux_tmp_290
        if hasOuter then
          __lux_tmp_290 = outerX
        else
          __lux_tmp_290 = shadowX
        end
        sx = mathMin(__lux_tmp_289, __lux_tmp_290)
      end
      local sy
      do
        local __lux_tmp_291
        if hasShadow then
          __lux_tmp_291 = shadowY
        else
          __lux_tmp_291 = outerY
        end
        local __lux_tmp_292
        if hasOuter then
          __lux_tmp_292 = outerY
        else
          __lux_tmp_292 = shadowY
        end
        sy = mathMin(__lux_tmp_291, __lux_tmp_292)
      end
      local ex
      do
        local __lux_tmp_293
        if hasShadow then
          __lux_tmp_293 = shadowX + w + shadowExtent * 2
        else
          __lux_tmp_293 = outerX + w + outerExtent * 2
        end
        local __lux_tmp_294
        if hasOuter then
          __lux_tmp_294 = outerX + w + outerExtent * 2
        else
          __lux_tmp_294 = shadowX + w + shadowExtent * 2
        end
        ex = mathMax(__lux_tmp_293, __lux_tmp_294)
      end
      local ey
      do
        local __lux_tmp_295
        if hasShadow then
          __lux_tmp_295 = shadowY + h + shadowExtent * 2
        else
          __lux_tmp_295 = outerY + h + outerExtent * 2
        end
        local __lux_tmp_296
        if hasOuter then
          __lux_tmp_296 = outerY + h + outerExtent * 2
        else
          __lux_tmp_296 = shadowY + h + shadowExtent * 2
        end
        ey = mathMax(__lux_tmp_295, __lux_tmp_296)
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
      local __lux_tmp_intensity_297 = intensity
      if __lux_tmp_intensity_297 == nil then
        __lux_tmp_intensity_297 = 1
      end
      return setupParamMatrix(
        material,
        vertical and 1 or 0,
        __lux_tmp_intensity_297,
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
        local __lux_tmp_padding_298 = toNumber(spec.padding)
        if __lux_tmp_padding_298 == nil then
          __lux_tmp_padding_298 = 0
        end
        pad = mathMax(0, __lux_tmp_padding_298)
      end
      local bx = x - pad
      local by = y - pad
      local bw = w + pad * 2
      local bh = h + pad * 2
      if spec.blur > 0 and materialOK(widgetMaterials.image_mask_backdrop) then
        local material = widgetMaterials.image_mask_backdrop
        prepareBackdropBlur(spec.blur, spec.recapture)
        surfaceSetMaterial(material)
        surfaceSetDrawColor(255, 255, 255, 255)
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
          0
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
      local __lux_tmp_301 = background ~= nil
      if __lux_tmp_301 then
        local __lux_tmp_a_300 = background.a
        if __lux_tmp_a_300 == nil then
          __lux_tmp_a_300 = 255
        end
        __lux_tmp_301 = __lux_tmp_a_300 > 0
      end
      if __lux_tmp_301 then
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
      local __lux_tmp_304 = background ~= nil
      if __lux_tmp_304 then
        local __lux_tmp_a_303 = background.a
        if __lux_tmp_a_303 == nil then
          __lux_tmp_a_303 = 255
        end
        __lux_tmp_304 = __lux_tmp_a_303 > 0
      end
      if __lux_tmp_304 then
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
      local __lux_match_305 = maskKind
      if __lux_match_305 == 2 or __lux_match_305 == 3 then
        return mathMin(w, h) * 0.5
      elseif __lux_match_305 == 0 then
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
            local __lux_tmp_channel_306 = imageMaskTextureChannelKind(mask.channel)
            if __lux_tmp_channel_306 == nil then
              __lux_tmp_channel_306 = maskKind
            end
            backdropMaskKind = __lux_tmp_channel_306
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
      local __lux_tmp_309 = background ~= nil
      if __lux_tmp_309 then
        local __lux_tmp_a_308 = background.a
        if __lux_tmp_a_308 == nil then
          __lux_tmp_a_308 = 255
        end
        __lux_tmp_309 = __lux_tmp_a_308 > 0
      end
      if __lux_tmp_309 then
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
