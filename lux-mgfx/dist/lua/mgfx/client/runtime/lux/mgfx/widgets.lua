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
  local configureWidgets
  local materialOK
  local shadersActive
  local setupParamMatrix
  local setupAuxConstants
  local copyInto
  local colorAt
  local fxFlagsFromInput
  local effectBleedFromDrawRect
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
    local __lux_import_1 = __lux_import("lux/mgfx/frame#client")
    local frameImport = __lux_import_1
    local __lux_import_2 = __lux_import("lux/mgfx/geometry#client")
    local geometryImport = __lux_import_2
    local __lux_import_3 = __lux_import("lux/mgfx/primitives#client")
    local primitivesImport = __lux_import_3
    local __lux_import_4 = __lux_import("lux/mgfx/roundrect#client")
    local roundrectImport = __lux_import_4
    local __lux_import_5 = __lux_import("lux/mgfx/style#client")
    local styleImport = __lux_import_5
    local __lux_import_6 = __lux_import("lux/mgfx/text#client")
    local textImport = __lux_import_6
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
      local __lux_obj_7 = render
      local __lux_val_8 = nil
      if __lux_obj_7 ~= nil then
        __lux_val_8 = __lux_obj_7.CopyRenderTargetToTexture
      end
      renderCopyRenderTargetToTexture = __lux_val_8
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
      local __lux_tmp_9
      if matrixCtor ~= nil then
        __lux_tmp_9 = matrixCtor()
      else
        __lux_tmp_9 = nil
      end
      paramMatrixProbe = __lux_tmp_9
    end
    do
      local __lux_obj_10 = paramMatrixProbe
      local __lux_val_11 = nil
      if __lux_obj_10 ~= nil then
        __lux_val_11 = __lux_obj_10.SetUnpacked
      end
      paramMatrixSetUnpacked = __lux_val_11
    end
    paramMatrices = {}
    auxParamMatrices = {}
    widgetMaterials = {}
    widgetBlurRT = nil
    widgetMatOK = function(material)
      local __lux_tmp_12 = material ~= nil
      if __lux_tmp_12 then
        __lux_tmp_12 = material.IsError ~= nil
      end
      local __lux_tmp_13 = __lux_tmp_12
      if __lux_tmp_13 then
        __lux_tmp_13 = not material:IsError()
      end
      return __lux_tmp_13
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
    configureWidgets = function(owner)
      do
        local __lux_tmp_14 = owner
        if __lux_tmp_14 == nil then
          __lux_tmp_14 = {}
        end
        owner = __lux_tmp_14
      end
      local materialState
      do
        local __lux_tmp_15 = owner._MaterialState
        if __lux_tmp_15 == nil then
          __lux_tmp_15 = {}
        end
        materialState = __lux_tmp_15
      end
      do
        local __lux_tmp_16 = owner._Materials
        if __lux_tmp_16 == nil then
          local __lux_tmp_17 = materialState.materials
          if __lux_tmp_17 == nil then
            local __lux_tmp_18 = widgetMaterials
            if __lux_tmp_18 == nil then
              __lux_tmp_18 = {}
            end
            __lux_tmp_17 = __lux_tmp_18
          end
          __lux_tmp_16 = __lux_tmp_17
        end
        widgetMaterials = __lux_tmp_16
      end
      do
        local __lux_tmp_19 = owner._BlurRT
        if __lux_tmp_19 == nil then
          local __lux_tmp_20 = materialState.blurRT
          if __lux_tmp_20 == nil then
            __lux_tmp_20 = widgetBlurRT
          end
          __lux_tmp_19 = __lux_tmp_20
        end
        widgetBlurRT = __lux_tmp_19
      end
      do
        local __lux_tmp_21 = owner.MaterialOK
        if __lux_tmp_21 == nil then
          local __lux_tmp_22 = materialState.matOK
          if __lux_tmp_22 == nil then
            __lux_tmp_22 = widgetMatOK
          end
          __lux_tmp_21 = __lux_tmp_22
        end
        widgetMatOK = __lux_tmp_21
      end
      do
        local __lux_tmp_23 = owner.hasShaders
        if __lux_tmp_23 == nil then
          __lux_tmp_23 = widgetHasShaders
        end
        widgetHasShaders = __lux_tmp_23
      end
      return true
    end
    materialOK = function(material)
      local __lux_tmp_24 = widgetMatOK ~= nil
      if __lux_tmp_24 then
        __lux_tmp_24 = widgetMatOK(material)
      end
      return __lux_tmp_24
    end
    shadersActive = function()
      local __lux_tmp_25 = forceFallbackCvar == nil
      if __lux_tmp_25 then
        __lux_tmp_25 = getConVar ~= nil
      end
      if __lux_tmp_25 then
        do
          local __lux_tmp_26 = getConVar("mgfx_force_fallback")
          if __lux_tmp_26 == nil then
            __lux_tmp_26 = false
          end
          forceFallbackCvar = __lux_tmp_26
        end
      end
      local __lux_tmp_27 = forceFallbackCvar ~= nil
      if __lux_tmp_27 then
        __lux_tmp_27 = forceFallbackCvar ~= false
      end
      local __lux_tmp_28 = __lux_tmp_27
      if __lux_tmp_28 then
        __lux_tmp_28 = forceFallbackCvar:GetBool()
      end
      if __lux_tmp_28 then
        return false
      end
      local __lux_tmp_29 = widgetHasShaders ~= nil
      if __lux_tmp_29 then
        __lux_tmp_29 = widgetHasShaders()
      end
      return __lux_tmp_29
    end
    setupParamMatrix = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3)
      local __lux_tmp_30 = material == nil
      if not __lux_tmp_30 then
        __lux_tmp_30 = paramMatrixSetUnpacked == nil
      end
      local __lux_tmp_31 = __lux_tmp_30
      if not __lux_tmp_31 then
        __lux_tmp_31 = matrixCtor == nil
      end
      if __lux_tmp_31 then
        return false
      end
      local matrix = paramMatrices[material]
      if matrix == nil then
        matrix = matrixCtor()
        paramMatrices[material] = matrix
      end
      do
        local __lux_tmp_32 = a0
        if __lux_tmp_32 == nil then
          __lux_tmp_32 = 0
        end
        local __lux_tmp_33 = b0
        if __lux_tmp_33 == nil then
          __lux_tmp_33 = 0
        end
        local __lux_tmp_34 = c0
        if __lux_tmp_34 == nil then
          __lux_tmp_34 = 0
        end
        local __lux_tmp_35 = d0
        if __lux_tmp_35 == nil then
          __lux_tmp_35 = 0
        end
        local __lux_tmp_36 = a1
        if __lux_tmp_36 == nil then
          __lux_tmp_36 = 0
        end
        local __lux_tmp_37 = b1
        if __lux_tmp_37 == nil then
          __lux_tmp_37 = 0
        end
        local __lux_tmp_38 = c1
        if __lux_tmp_38 == nil then
          __lux_tmp_38 = 0
        end
        local __lux_tmp_39 = d1
        if __lux_tmp_39 == nil then
          __lux_tmp_39 = 0
        end
        local __lux_tmp_40 = a2
        if __lux_tmp_40 == nil then
          __lux_tmp_40 = 0
        end
        local __lux_tmp_41 = b2
        if __lux_tmp_41 == nil then
          __lux_tmp_41 = 0
        end
        local __lux_tmp_42 = c2
        if __lux_tmp_42 == nil then
          __lux_tmp_42 = 0
        end
        local __lux_tmp_43 = d2
        if __lux_tmp_43 == nil then
          __lux_tmp_43 = 0
        end
        local __lux_tmp_44 = a3
        if __lux_tmp_44 == nil then
          __lux_tmp_44 = 0
        end
        local __lux_tmp_45 = b3
        if __lux_tmp_45 == nil then
          __lux_tmp_45 = 0
        end
        local __lux_tmp_46 = c3
        if __lux_tmp_46 == nil then
          __lux_tmp_46 = 0
        end
        local __lux_tmp_47 = d3
        if __lux_tmp_47 == nil then
          __lux_tmp_47 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_32,
          __lux_tmp_33,
          __lux_tmp_34,
          __lux_tmp_35,
          __lux_tmp_36,
          __lux_tmp_37,
          __lux_tmp_38,
          __lux_tmp_39,
          __lux_tmp_40,
          __lux_tmp_41,
          __lux_tmp_42,
          __lux_tmp_43,
          __lux_tmp_44,
          __lux_tmp_45,
          __lux_tmp_46,
          __lux_tmp_47
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
      local __lux_tmp_48 = material == nil
      if not __lux_tmp_48 then
        __lux_tmp_48 = paramMatrixSetUnpacked == nil
      end
      local __lux_tmp_49 = __lux_tmp_48
      if not __lux_tmp_49 then
        __lux_tmp_49 = matrixCtor == nil
      end
      if __lux_tmp_49 then
        return false
      end
      local matrix = auxParamMatrices[material]
      if matrix == nil then
        matrix = matrixCtor()
        auxParamMatrices[material] = matrix
      end
      do
        local __lux_tmp_50 = a0
        if __lux_tmp_50 == nil then
          __lux_tmp_50 = 0
        end
        local __lux_tmp_51 = b0
        if __lux_tmp_51 == nil then
          __lux_tmp_51 = 0
        end
        local __lux_tmp_52 = c0
        if __lux_tmp_52 == nil then
          __lux_tmp_52 = 0
        end
        local __lux_tmp_53 = d0
        if __lux_tmp_53 == nil then
          __lux_tmp_53 = 0
        end
        local __lux_tmp_54 = a1
        if __lux_tmp_54 == nil then
          __lux_tmp_54 = 0
        end
        local __lux_tmp_55 = b1
        if __lux_tmp_55 == nil then
          __lux_tmp_55 = 0
        end
        local __lux_tmp_56 = c1
        if __lux_tmp_56 == nil then
          __lux_tmp_56 = 0
        end
        local __lux_tmp_57 = d1
        if __lux_tmp_57 == nil then
          __lux_tmp_57 = 0
        end
        local __lux_tmp_58 = a2
        if __lux_tmp_58 == nil then
          __lux_tmp_58 = 0
        end
        local __lux_tmp_59 = b2
        if __lux_tmp_59 == nil then
          __lux_tmp_59 = 0
        end
        local __lux_tmp_60 = c2
        if __lux_tmp_60 == nil then
          __lux_tmp_60 = 0
        end
        local __lux_tmp_61 = d2
        if __lux_tmp_61 == nil then
          __lux_tmp_61 = 0
        end
        local __lux_tmp_62 = a3
        if __lux_tmp_62 == nil then
          __lux_tmp_62 = 0
        end
        local __lux_tmp_63 = b3
        if __lux_tmp_63 == nil then
          __lux_tmp_63 = 0
        end
        local __lux_tmp_64 = c3
        if __lux_tmp_64 == nil then
          __lux_tmp_64 = 0
        end
        local __lux_tmp_65 = d3
        if __lux_tmp_65 == nil then
          __lux_tmp_65 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
          __lux_tmp_50,
          __lux_tmp_51,
          __lux_tmp_52,
          __lux_tmp_53,
          __lux_tmp_54,
          __lux_tmp_55,
          __lux_tmp_56,
          __lux_tmp_57,
          __lux_tmp_58,
          __lux_tmp_59,
          __lux_tmp_60,
          __lux_tmp_61,
          __lux_tmp_62,
          __lux_tmp_63,
          __lux_tmp_64,
          __lux_tmp_65
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
      local fx
      do
        local __lux_tmp_66 = typeOf(fxInput) == "table"
        if __lux_tmp_66 then
          __lux_tmp_66 = fxInput
        end
        local __lux_tmp_67 = __lux_tmp_66
        if not __lux_tmp_67 then
          __lux_tmp_67 = nil
        end
        fx = __lux_tmp_67
      end
      if fx == nil then
        return false, false, false, 0
      end
      local glow
      do
        local __lux_tmp_68 = fx.glow == true
        if not __lux_tmp_68 then
          __lux_tmp_68 = typeOf(fx.glow) == "table"
        end
        glow = __lux_tmp_68
      end
      local sheen
      do
        local __lux_tmp_69 = fx.sheen == true
        if not __lux_tmp_69 then
          __lux_tmp_69 = typeOf(fx.sheen) == "table"
        end
        sheen = __lux_tmp_69
      end
      local marker
      do
        local __lux_tmp_70 = fx.marker == true
        if not __lux_tmp_70 then
          __lux_tmp_70 = typeOf(fx.marker) == "table"
        end
        marker = __lux_tmp_70
      end
      local ticks = 0
      local tickSpec = fx.ticks
      if typeOf(tickSpec) == "number" then
        ticks = tickSpec
      else
        if typeOf(tickSpec) == "table" then
          do
            local __lux_tmp_71 = tickSpec.count
            if __lux_tmp_71 == nil then
              __lux_tmp_71 = 0
            end
            ticks = __lux_tmp_71
          end
        end
      end
      local __lux_tmp_72 = toNumber(ticks)
      if __lux_tmp_72 == nil then
        __lux_tmp_72 = 0
      end
      return glow, sheen, marker, mathClamp(mathFloor(__lux_tmp_72), 0, 31)
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
    progressFxBits = function(fxInput)
      local fx
      do
        local __lux_tmp_73 = typeOf(fxInput) == "table"
        if __lux_tmp_73 then
          __lux_tmp_73 = fxInput
        end
        local __lux_tmp_74 = __lux_tmp_73
        if not __lux_tmp_74 then
          __lux_tmp_74 = nil
        end
        fx = __lux_tmp_74
      end
      if fx == nil then
        return 0, 0
      end
      local flags = 0
      local __lux_tmp_75 = fx.glow == true
      if not __lux_tmp_75 then
        __lux_tmp_75 = typeOf(fx.glow) == "table"
      end
      if __lux_tmp_75 then
        flags = flags + 1
      end
      local __lux_tmp_76 = fx.sheen == true
      if not __lux_tmp_76 then
        __lux_tmp_76 = typeOf(fx.sheen) == "table"
      end
      if __lux_tmp_76 then
        flags = flags + 2
      end
      local __lux_tmp_77 = fx.marker == true
      if not __lux_tmp_77 then
        __lux_tmp_77 = typeOf(fx.marker) == "table"
      end
      if __lux_tmp_77 then
        flags = flags + 4
      end
      local ticks = 0
      local tickSpec = fx.ticks
      if typeOf(tickSpec) == "number" then
        ticks = tickSpec
      else
        if typeOf(tickSpec) == "table" then
          do
            local __lux_tmp_78 = tickSpec.count
            if __lux_tmp_78 == nil then
              __lux_tmp_78 = 0
            end
            ticks = __lux_tmp_78
          end
        end
      end
      local __lux_tmp_79 = toNumber(ticks)
      if __lux_tmp_79 == nil then
        __lux_tmp_79 = 0
      end
      return flags, mathClamp(mathFloor(__lux_tmp_79), 0, 31)
    end
    progressFillCanFast = function(fill)
      local __lux_match_80 = fill
      local __lux_tag_81
      if __lux_match_80 ~= nil then
        __lux_tag_81 = __lux_match_80.kind
      end
      if __lux_tag_81 == style.FILL_SOLID then
        return true
      elseif __lux_tag_81 == style.FILL_LINEAR then
        local x1 = __lux_match_80.x1
        local y1 = __lux_match_80.y1
        local x2 = __lux_match_80.x2
        local y2 = __lux_match_80.y2
        local __lux_tmp_82 = x1
        if __lux_tmp_82 == nil then
          __lux_tmp_82 = 0
        end
        local __lux_tmp_83 = __lux_tmp_82 == 0
        if __lux_tmp_83 then
          local __lux_tmp_84 = y1
          if __lux_tmp_84 == nil then
            __lux_tmp_84 = 0
          end
          __lux_tmp_83 = __lux_tmp_84 == 0
        end
        local __lux_tmp_85 = __lux_tmp_83
        if __lux_tmp_85 then
          local __lux_tmp_86 = x2
          if __lux_tmp_86 == nil then
            __lux_tmp_86 = 1
          end
          __lux_tmp_85 = __lux_tmp_86 == 1
        end
        local __lux_tmp_87 = __lux_tmp_85
        if __lux_tmp_87 then
          local __lux_tmp_88 = y2
          if __lux_tmp_88 == nil then
            __lux_tmp_88 = 0
          end
          __lux_tmp_87 = __lux_tmp_88 == 0
        end
        return __lux_tmp_87
      else
        return false
      end
    end
    canDrawProgressFast = function(fill, inset, strokeWidth, flags, ticks, fxMat, shadow, backdrop, outerGlow, innerGlow, pattern, fillPattern, trackPattern)
      local __lux_tmp_89 = not shadersActive()
      if not __lux_tmp_89 then
        __lux_tmp_89 = not materialOK(fxMat)
      end
      if __lux_tmp_89 then
        return false
      end
      local __lux_tmp_90 = shadow ~= nil
      if not __lux_tmp_90 then
        __lux_tmp_90 = backdrop ~= nil
      end
      local __lux_tmp_91 = __lux_tmp_90
      if not __lux_tmp_91 then
        __lux_tmp_91 = outerGlow ~= nil
      end
      local __lux_tmp_92 = __lux_tmp_91
      if not __lux_tmp_92 then
        __lux_tmp_92 = innerGlow ~= nil
      end
      local __lux_tmp_93 = __lux_tmp_92
      if not __lux_tmp_93 then
        __lux_tmp_93 = pattern ~= nil
      end
      local __lux_tmp_94 = __lux_tmp_93
      if not __lux_tmp_94 then
        __lux_tmp_94 = fillPattern ~= nil
      end
      local __lux_tmp_95 = __lux_tmp_94
      if not __lux_tmp_95 then
        __lux_tmp_95 = trackPattern ~= nil
      end
      if __lux_tmp_95 then
        return false
      end
      local __lux_tmp_96 = inset ~= mathFloor(inset)
      if not __lux_tmp_96 then
        __lux_tmp_96 = strokeWidth ~= mathFloor(strokeWidth)
      end
      if __lux_tmp_96 then
        return false
      end
      local __lux_tmp_97 = inset < 0
      if not __lux_tmp_97 then
        __lux_tmp_97 = inset > 31
      end
      local __lux_tmp_98 = __lux_tmp_97
      if not __lux_tmp_98 then
        __lux_tmp_98 = strokeWidth < 0
      end
      local __lux_tmp_99 = __lux_tmp_98
      if not __lux_tmp_99 then
        __lux_tmp_99 = strokeWidth > 15
      end
      if __lux_tmp_99 then
        return false
      end
      if not progressFillCanFast(fill) then
        return false
      end
      local __lux_tmp_100 = fxMat == widgetMaterials.progress
      if __lux_tmp_100 then
        local __lux_tmp_101 = flags ~= 0
        if not __lux_tmp_101 then
          __lux_tmp_101 = ticks > 1
        end
        __lux_tmp_100 = __lux_tmp_101
      end
      if __lux_tmp_100 then
        return false
      end
      return true
    end
    setupProgressConstants = function(material, w, h, value, radius, inset, track, fill, stroke, strokeWidth)
      local fillA
      do
        local __lux_tmp_102 = fill.colorA
        if __lux_tmp_102 == nil then
          __lux_tmp_102 = color_white
        end
        fillA = __lux_tmp_102
      end
      local fillB
      do
        local __lux_tmp_103 = fill.colorB
        if __lux_tmp_103 == nil then
          __lux_tmp_103 = fillA
        end
        fillB = __lux_tmp_103
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
        local __lux_tmp_104 = stroke
        if __lux_tmp_104 == nil then
          __lux_tmp_104 = transparentColor
        end
        r, g, b, a = style.color01(__lux_tmp_104)
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
      local fillA
      do
        local __lux_tmp_105 = fill.colorA
        if __lux_tmp_105 == nil then
          __lux_tmp_105 = color_white
        end
        fillA = __lux_tmp_105
      end
      local fillB
      do
        local __lux_tmp_106 = fill.colorB
        if __lux_tmp_106 == nil then
          __lux_tmp_106 = fillA
        end
        fillB = __lux_tmp_106
      end
      do
        local __lux_tmp_107 = toNumber(flags)
        if __lux_tmp_107 == nil then
          __lux_tmp_107 = 0
        end
        flags = mathClamp(mathFloor(__lux_tmp_107), 0, 7)
      end
      do
        local __lux_tmp_108 = toNumber(ticks)
        if __lux_tmp_108 == nil then
          __lux_tmp_108 = 0
        end
        ticks = mathClamp(mathFloor(__lux_tmp_108), 0, 31)
      end
      do
        local __lux_tmp_109 = toNumber(radius)
        if __lux_tmp_109 == nil then
          __lux_tmp_109 = 0
        end
        radius = mathClamp(__lux_tmp_109, 0, 255)
      end
      do
        local __lux_tmp_110 = toNumber(inset)
        if __lux_tmp_110 == nil then
          __lux_tmp_110 = 0
        end
        inset = mathClamp(mathFloor(__lux_tmp_110), 0, 31)
      end
      do
        local __lux_tmp_111 = toNumber(strokeWidth)
        if __lux_tmp_111 == nil then
          __lux_tmp_111 = 0
        end
        strokeWidth = mathClamp(mathFloor(__lux_tmp_111), 0, 15)
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
        local __lux_tmp_112 = stroke
        if __lux_tmp_112 == nil then
          __lux_tmp_112 = transparentColor
        end
        r, g, b, a = style.color01(__lux_tmp_112)
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
      do
        local __lux_tmp_113 = flags ~= 0
        if not __lux_tmp_113 then
          __lux_tmp_113 = ticks > 1
        end
        if __lux_tmp_113 then
          material = widgetMaterials.progress_fx
        else
          material = widgetMaterials.progress
        end
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
      do
        local __lux_tmp_114 = colorA.a == nil
        if not __lux_tmp_114 then
          __lux_tmp_114 = colorA.a > 0
        end
        local __lux_tmp_115 = __lux_tmp_114
        if not __lux_tmp_115 then
          local __lux_tmp_116 = colorB.a == nil
          if not __lux_tmp_116 then
            __lux_tmp_116 = colorB.a > 0
          end
          __lux_tmp_115 = __lux_tmp_116
        end
        fill._mgfxFillVisible = __lux_tmp_115
      end
      fill._mgfxLutCacheSafe = false
      return fill
    end
    segmentFillEndpoints = function(fill)
      local __lux_tmp_117 = fill.stops ~= nil
      if __lux_tmp_117 then
        __lux_tmp_117 = #fill.stops > 0
      end
      if __lux_tmp_117 then
        local first = nil
        local last = nil
        for _, stop in ipairs(fill.stops) do
          local color
          do
            local __lux_tmp_118 = stop.color
            if __lux_tmp_118 == nil then
              __lux_tmp_118 = stop[2]
            end
            color = __lux_tmp_118
          end
          local __lux_tmp_119 = color ~= nil
          if __lux_tmp_119 then
            local __lux_tmp_120 = color.a == nil
            if not __lux_tmp_120 then
              __lux_tmp_120 = color.a > 0
            end
            __lux_tmp_119 = __lux_tmp_120
          end
          if __lux_tmp_119 then
            do
              local __lux_tmp_121 = first
              if __lux_tmp_121 == nil then
                __lux_tmp_121 = color
              end
              first = __lux_tmp_121
            end
            last = color
          end
        end
        local __lux_tmp_122 = first ~= nil
        if __lux_tmp_122 then
          __lux_tmp_122 = last ~= nil
        end
        if __lux_tmp_122 then
          return first, last
        end
      end
      local __lux_tmp_123 = fill.colorA
      if __lux_tmp_123 == nil then
        __lux_tmp_123 = color_white
      end
      local __lux_tmp_124 = fill.colorB
      if __lux_tmp_124 == nil then
        local __lux_tmp_125 = fill.colorA
        if __lux_tmp_125 == nil then
          __lux_tmp_125 = color_white
        end
        __lux_tmp_124 = __lux_tmp_125
      end
      return __lux_tmp_123, __lux_tmp_124
    end
    drawSegmentBarShaderRaw = function(x, y, w, h, value, count, gap, fill, track, radius, background, stroke, strokeWidth, shadow, backdrop, outerGlow, innerGlow, pattern, fillPattern, trackPattern)
      local __lux_tmp_126 = not shadersActive()
      if not __lux_tmp_126 then
        __lux_tmp_126 = not materialOK(widgetMaterials.segmentbar)
      end
      if __lux_tmp_126 then
        return false
      end
      if background ~= nil then
        return false
      end
      if style.strokeVisible(stroke, strokeWidth) then
        return false
      end
      local __lux_tmp_127 = shadow ~= nil
      if not __lux_tmp_127 then
        __lux_tmp_127 = backdrop ~= nil
      end
      local __lux_tmp_128 = __lux_tmp_127
      if not __lux_tmp_128 then
        __lux_tmp_128 = outerGlow ~= nil
      end
      local __lux_tmp_129 = __lux_tmp_128
      if not __lux_tmp_129 then
        __lux_tmp_129 = innerGlow ~= nil
      end
      local __lux_tmp_130 = __lux_tmp_129
      if not __lux_tmp_130 then
        __lux_tmp_130 = pattern ~= nil
      end
      local __lux_tmp_131 = __lux_tmp_130
      if not __lux_tmp_131 then
        __lux_tmp_131 = fillPattern ~= nil
      end
      local __lux_tmp_132 = __lux_tmp_131
      if not __lux_tmp_132 then
        __lux_tmp_132 = trackPattern ~= nil
      end
      if __lux_tmp_132 then
        return false
      end
      local totalGap = gap * (count - 1)
      local segmentW = (w - totalGap) / count
      local __lux_tmp_133 = segmentW <= 0
      if not __lux_tmp_133 then
        __lux_tmp_133 = h <= 0
      end
      if __lux_tmp_133 then
        return true
      end
      local trackColor = style.asColor(track, defaultSegmentTrack)
      local fillA, fillB = segmentFillEndpoints(fill)
      local hasFill = style.fillVisible(fill)
      local hasTrack
      do
        local __lux_tmp_134 = trackColor.a == nil
        if not __lux_tmp_134 then
          __lux_tmp_134 = trackColor.a > 0
        end
        hasTrack = __lux_tmp_134
      end
      local __lux_tmp_135 = not hasFill
      if __lux_tmp_135 then
        __lux_tmp_135 = not hasTrack
      end
      if __lux_tmp_135 then
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
        local __lux_tmp_136 = toNumber(value)
        if __lux_tmp_136 == nil then
          __lux_tmp_136 = 0
        end
        local __lux_tmp_137
        if radius == nil then
          __lux_tmp_137 = mathMin(2, h * 0.35)
        else
          __lux_tmp_137 = radius
        end
        local __lux_tmp_138 = toNumber(__lux_tmp_137)
        if __lux_tmp_138 == nil then
          __lux_tmp_138 = 0
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
          mathClamp(__lux_tmp_136, 0, 1),
          mathMax(0, __lux_tmp_138),
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
        local __lux_tmp_139 = toNumber(value)
        if __lux_tmp_139 == nil then
          __lux_tmp_139 = 0
        end
        frac = mathClamp(__lux_tmp_139, 0, 1)
      end
      local radius
      do
        local __lux_tmp_140 = radiusInput
        if __lux_tmp_140 == nil then
          __lux_tmp_140 = mathMin(4, h * 0.5)
        end
        radius = __lux_tmp_140
      end
      local inset
      do
        local __lux_tmp_141 = toNumber(paddingInput)
        if __lux_tmp_141 == nil then
          __lux_tmp_141 = 0
        end
        inset = mathMax(0, __lux_tmp_141)
      end
      local track
      do
        local __lux_tmp_142 = trackInput
        if __lux_tmp_142 == nil then
          __lux_tmp_142 = defaultProgressTrack
        end
        track = __lux_tmp_142
      end
      local fill
      do
        local __lux_tmp_143 = fillInput
        if __lux_tmp_143 == nil then
          __lux_tmp_143 = color_white
        end
        fill = __lux_tmp_143
      end
      local stroke
      do
        local __lux_tmp_144 = strokeInput
        if __lux_tmp_144 == nil then
          __lux_tmp_144 = defaultProgressStroke
        end
        stroke = __lux_tmp_144
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
      do
        local __lux_tmp_145 = track.r
        if __lux_tmp_145 == nil then
          __lux_tmp_145 = 0
        end
        progressTrackDarkColor.r = mathFloor(__lux_tmp_145 * 0.65)
      end
      do
        local __lux_tmp_146 = track.g
        if __lux_tmp_146 == nil then
          __lux_tmp_146 = 0
        end
        progressTrackDarkColor.g = mathFloor(__lux_tmp_146 * 0.65)
      end
      do
        local __lux_tmp_147 = track.b
        if __lux_tmp_147 == nil then
          __lux_tmp_147 = 0
        end
        progressTrackDarkColor.b = mathFloor(__lux_tmp_147 * 0.65)
      end
      do
        local __lux_tmp_148 = track.a
        if __lux_tmp_148 == nil then
          __lux_tmp_148 = 190
        end
        progressTrackDarkColor.a = __lux_tmp_148
      end
      local trackFill = setGradientColors(progressTrackGradient, progressTrackDarkColor, track)
      roundrect.drawRoundRectRaw(
        x,
        y,
        w,
        h,
        radius,
        trackFill,
        stroke,
        strokeWidth,
        shadow,
        outerGlow,
        innerGlow,
        backdrop,
        trackPattern
      )
      local innerH = h - inset * 2
      local innerW = (w - inset * 2) * frac
      if frac >= 0.999 then
        innerW = w - inset * 2
      end
      if ticks > 1 then
        for index = 1, ticks - 1 do
          local tx = x + mathFloor(w * index / ticks)
          roundrect.drawRoundRectRaw(tx, y + 3, 1, mathMax(1, h - 6), 0, progressTickColor)
        end
      end
      local __lux_tmp_149 = innerH <= 0
      if not __lux_tmp_149 then
        __lux_tmp_149 = innerW <= 0
      end
      if __lux_tmp_149 then
        return
      end
      local __lux_tmp_150 = glow
      if __lux_tmp_150 then
        __lux_tmp_150 = innerW > 4
      end
      if __lux_tmp_150 then
        local glowRadius = mathMin(radius + 2, (innerH + 4) * 0.5, (innerW + 4) * 0.5)
        roundrect.drawRoundRectRaw(
          x + inset - 2,
          y + inset - 2,
          innerW + 4,
          innerH + 4,
          glowRadius,
          progressGlowColor
        )
      end
      local fillRadius = mathMin(mathMax(0, radius - inset), innerH * 0.5, innerW * 0.5)
      do
        local __lux_tmp_151 = fillPattern
        if __lux_tmp_151 == nil then
          __lux_tmp_151 = pattern
        end
        roundrect.drawRoundRectRaw(
          x + inset,
          y + inset,
          innerW,
          innerH,
          fillRadius,
          fill,
          nil,
          nil,
          nil,
          nil,
          nil,
          nil,
          __lux_tmp_151
        )
      end
      local __lux_tmp_152 = sheen
      if __lux_tmp_152 then
        __lux_tmp_152 = innerW > 8
      end
      if __lux_tmp_152 then
        local sheenRadius = mathMin(radius, innerH * 0.25)
        roundrect.drawRoundRectRaw(
          x + inset + 1,
          y + inset + 1,
          mathMax(1, innerW - 2),
          mathMax(1, innerH * 0.38),
          sheenRadius,
          progressSheenGradient
        )
      end
      local __lux_tmp_153 = marker
      if __lux_tmp_153 then
        __lux_tmp_153 = innerW > 5
      end
      if __lux_tmp_153 then
        local mx = x + inset + innerW - 2
        roundrect.drawRoundRectRaw(mx, y + 2, 2, h - 4, 1, progressMarkerColor)
      end
    end
    progressBarEx = function(x, y, w, h, value, drawStyle)
      local resolved
      do
        local __lux_tmp_154 = drawStyle
        if __lux_tmp_154 == nil then
          __lux_tmp_154 = {}
        end
        resolved = __lux_tmp_154
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
      local __lux_tmp_155 = stripped.fill
      if __lux_tmp_155 == nil then
        __lux_tmp_155 = stripped.color
      end
      return progressBarRaw(
        x,
        y,
        w,
        h,
        value,
        stripped.radius,
        stripped.track,
        __lux_tmp_155,
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
        local __lux_tmp_156 = toNumber(segments)
        if __lux_tmp_156 == nil then
          __lux_tmp_156 = 10
        end
        count = mathClamp(mathFloor(__lux_tmp_156), 1, 128)
      end
      local gap
      do
        local __lux_tmp_157 = toNumber(gapInput)
        if __lux_tmp_157 == nil then
          __lux_tmp_157 = 2
        end
        gap = mathMax(0, __lux_tmp_157)
      end
      local frac
      do
        local __lux_tmp_158 = toNumber(value)
        if __lux_tmp_158 == nil then
          __lux_tmp_158 = 0
        end
        frac = mathClamp(__lux_tmp_158, 0, 1)
      end
      local active = mathFloor(frac * count + 0.0001)
      local fill
      do
        local __lux_tmp_159 = fillInput
        if __lux_tmp_159 == nil then
          local __lux_tmp_160 = colorInput
          if __lux_tmp_160 == nil then
            __lux_tmp_160 = defaultSegmentFill
          end
          __lux_tmp_159 = __lux_tmp_160
        end
        fill = style.fillFromStyle(__lux_tmp_159)
      end
      local track
      do
        local __lux_tmp_161 = trackInput
        if __lux_tmp_161 == nil then
          __lux_tmp_161 = defaultSegmentTrack
        end
        track = __lux_tmp_161
      end
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
        strokeWidth,
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
      local __lux_tmp_162 = segmentW <= 0
      if not __lux_tmp_162 then
        __lux_tmp_162 = h <= 0
      end
      if __lux_tmp_162 then
        return
      end
      local containerRadius
      do
        local __lux_tmp_163 = backgroundRadius
        if __lux_tmp_163 == nil then
          local __lux_tmp_164 = radius
          if __lux_tmp_164 == nil then
            __lux_tmp_164 = mathMin(3, h * 0.5)
          end
          __lux_tmp_163 = __lux_tmp_164
        end
        containerRadius = __lux_tmp_163
      end
      local __lux_tmp_165 = shadow ~= nil
      if not __lux_tmp_165 then
        __lux_tmp_165 = outerGlow ~= nil
      end
      local __lux_tmp_166 = __lux_tmp_165
      if not __lux_tmp_166 then
        __lux_tmp_166 = innerGlow ~= nil
      end
      local __lux_tmp_167 = __lux_tmp_166
      if not __lux_tmp_167 then
        __lux_tmp_167 = backdrop ~= nil
      end
      local __lux_tmp_168 = __lux_tmp_167
      if not __lux_tmp_168 then
        __lux_tmp_168 = background ~= nil
      end
      if __lux_tmp_168 then
        do
          local __lux_tmp_169 = background
          if __lux_tmp_169 == nil then
            __lux_tmp_169 = transparentColor
          end
          roundrect.drawRoundRectRaw(
            x,
            y,
            w,
            h,
            containerRadius,
            __lux_tmp_169,
            nil,
            nil,
            shadow,
            outerGlow,
            innerGlow,
            backdrop
          )
        end
      end
      local itemRadius
      if radius == nil then
        itemRadius = mathMin(2, h * 0.35)
      else
        itemRadius = radius
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
        local itemPattern
        if filled then
          do
            local __lux_tmp_170 = fillPattern
            if __lux_tmp_170 == nil then
              __lux_tmp_170 = pattern
            end
            itemPattern = __lux_tmp_170
          end
        else
          itemPattern = trackPattern
        end
        local __lux_tmp_171 = color ~= nil
        if not __lux_tmp_171 then
          __lux_tmp_171 = itemPattern ~= nil
        end
        if __lux_tmp_171 then
          do
            local __lux_tmp_172 = color
            if __lux_tmp_172 == nil then
              __lux_tmp_172 = transparentColor
            end
            local __lux_tmp_173 = strokeWidth
            if __lux_tmp_173 == nil then
              __lux_tmp_173 = 0
            end
            roundrect.drawRoundRectRaw(
              sx,
              y,
              segmentW,
              h,
              itemRadius,
              __lux_tmp_172,
              stroke,
              __lux_tmp_173,
              nil,
              nil,
              nil,
              nil,
              itemPattern
            )
          end
        end
      end
    end
    segmentBarEx = function(x, y, w, h, value, drawStyle)
      local resolved
      do
        local __lux_tmp_174 = drawStyle
        if __lux_tmp_174 == nil then
          __lux_tmp_174 = {}
        end
        resolved = __lux_tmp_174
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
        local __lux_tmp_175 = endDeg
        if __lux_tmp_175 == nil then
          __lux_tmp_175 = 360
        end
        local __lux_tmp_176 = startDeg
        if __lux_tmp_176 == nil then
          __lux_tmp_176 = 0
        end
        sweep = mathAbs(__lux_tmp_175 - __lux_tmp_176)
      end
      return mathClamp(mathFloor(sweep / 360 * fallback), 3, fallback)
    end
    ringModeValue = function(mode)
      local __lux_match_177 = mode
      if __lux_match_177 == "sector" or __lux_match_177 == 2 then
        return 2
      elseif __lux_match_177 == "arc" or __lux_match_177 == true or __lux_match_177 == 1 then
        return 1
      else
        return 0
      end
    end
    ringShapeConstants = function(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      local __lux_tmp_178 = toNumber(innerRadius)
      if __lux_tmp_178 == nil then
        __lux_tmp_178 = 0
      end
      local __lux_tmp_179 = toNumber(outerRadius)
      if __lux_tmp_179 == nil then
        __lux_tmp_179 = mathMin(w, h) * 0.5
      end
      local __lux_tmp_180 = toNumber(startDeg)
      if __lux_tmp_180 == nil then
        __lux_tmp_180 = 0
      end
      local __lux_tmp_181 = toNumber(endDeg)
      if __lux_tmp_181 == nil then
        __lux_tmp_181 = 360
      end
      return w, h, mathMax(0, __lux_tmp_178), mathMax(0.001, __lux_tmp_179), mathRad(__lux_tmp_180), mathRad(__lux_tmp_181), ringModeValue(mode)
    end
    ringFillParams = function(fill)
      local __lux_match_182 = fill
      local __lux_tag_183
      if __lux_match_182 ~= nil then
        __lux_tag_183 = __lux_match_182.kind
      end
      if __lux_tag_183 == style.FILL_LINEAR then
        local x1 = __lux_match_182.x1
        local y1 = __lux_match_182.y1
        local x2 = __lux_match_182.x2
        local y2 = __lux_match_182.y2
        local __lux_tmp_184 = x1
        if __lux_tmp_184 == nil then
          __lux_tmp_184 = 0
        end
        local __lux_tmp_185 = y1
        if __lux_tmp_185 == nil then
          __lux_tmp_185 = 0
        end
        local __lux_tmp_186 = x2
        if __lux_tmp_186 == nil then
          __lux_tmp_186 = 1
        end
        local __lux_tmp_187 = y2
        if __lux_tmp_187 == nil then
          __lux_tmp_187 = 0
        end
        return __lux_tmp_184, __lux_tmp_185, __lux_tmp_186, __lux_tmp_187
      elseif __lux_tag_183 == style.FILL_RADIAL then
        local cx = __lux_match_182.cx
        local cy = __lux_match_182.cy
        local radius = __lux_match_182.radius
        local localRadial
        do
          local __lux_tmp_188 = fill.localRadial == true
          if not __lux_tmp_188 then
            __lux_tmp_188 = fill.ringRadial == true
          end
          local __lux_tmp_189 = __lux_tmp_188
          if not __lux_tmp_189 then
            __lux_tmp_189 = fill.sectorRadial == true
          end
          localRadial = __lux_tmp_189
        end
        local __lux_tmp_190 = cx
        if __lux_tmp_190 == nil then
          __lux_tmp_190 = 0.5
        end
        local __lux_tmp_191 = cy
        if __lux_tmp_191 == nil then
          __lux_tmp_191 = 0.5
        end
        local __lux_tmp_192 = radius
        if __lux_tmp_192 == nil then
          __lux_tmp_192 = 0.5
        end
        local __lux_tmp_193
        if localRadial then
          __lux_tmp_193 = 1
        else
          __lux_tmp_193 = 0
        end
        return __lux_tmp_190, __lux_tmp_191, __lux_tmp_192, __lux_tmp_193
      elseif __lux_tag_183 == style.FILL_CONIC then
        local cx = __lux_match_182.cx
        local cy = __lux_match_182.cy
        local rotation = __lux_match_182.rotation
        local localAngular
        do
          local __lux_tmp_194 = fill.localAngular == true
          if not __lux_tmp_194 then
            __lux_tmp_194 = fill.shapeAngular == true
          end
          localAngular = __lux_tmp_194
        end
        local __lux_tmp_195 = cx
        if __lux_tmp_195 == nil then
          __lux_tmp_195 = 0.5
        end
        local __lux_tmp_196 = cy
        if __lux_tmp_196 == nil then
          __lux_tmp_196 = 0.5
        end
        local __lux_tmp_197
        if localAngular then
          __lux_tmp_197 = 1
        else
          __lux_tmp_197 = 0
        end
        return __lux_tmp_195, __lux_tmp_196, style.normalizedRotation(rotation), __lux_tmp_197
      else
        local __lux_unused_198 = nil
      end
      return 0, 0, 1, 0
    end
    ringFillNeedsLut = function(fill)
      local __lux_match_199 = fill
      local __lux_tag_200
      if __lux_match_199 ~= nil then
        __lux_tag_200 = __lux_match_199.kind
      end
      if __lux_tag_200 == style.FILL_LINEAR or __lux_tag_200 == style.FILL_RADIAL or __lux_tag_200 == style.FILL_CONIC then
        return true
      else
        return false
      end
    end
    drawRingFallbackRaw = function(cx, cy, outerRadius, arcWidth, startDeg, endDeg, mode, innerRadiusInput, fillInput, colorInput, stroke, strokeWidth, shadow, outerGlow, backdrop, segmentsInput)
      local fill
      do
        local __lux_tmp_201 = fillInput
        if __lux_tmp_201 == nil then
          local __lux_tmp_202 = colorInput
          if __lux_tmp_202 == nil then
            __lux_tmp_202 = defaultRingFill
          end
          __lux_tmp_201 = __lux_tmp_202
        end
        fill = __lux_tmp_201
      end
      local segments
      do
        local __lux_tmp_203 = segmentsInput
        if __lux_tmp_203 == nil then
          __lux_tmp_203 = 64
        end
        segments = arcSegmentCount(outerRadius, startDeg, endDeg, __lux_tmp_203)
      end
      local startRad
      do
        local __lux_tmp_204 = startDeg
        if __lux_tmp_204 == nil then
          __lux_tmp_204 = 0
        end
        startRad = mathRad(__lux_tmp_204)
      end
      local endRad
      do
        local __lux_tmp_205 = endDeg
        if __lux_tmp_205 == nil then
          __lux_tmp_205 = 360
        end
        endRad = mathRad(__lux_tmp_205)
      end
      if mode == 2 then
        local innerRadius
        do
          local __lux_tmp_206 = toNumber(innerRadiusInput)
          if __lux_tmp_206 == nil then
            __lux_tmp_206 = mathMax(0, outerRadius - arcWidth)
          end
          innerRadius = mathClamp(__lux_tmp_206, 0, outerRadius)
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
      local __lux_tmp_207 = not style.fillVisible(fill)
      if not __lux_tmp_207 then
        __lux_tmp_207 = not shadersActive()
      end
      local __lux_tmp_208 = __lux_tmp_207
      if not __lux_tmp_208 then
        __lux_tmp_208 = not materialOK(widgetMaterials.ring)
      end
      if __lux_tmp_208 then
        return false
      end
      local material = widgetMaterials.ring
      local colorB
      do
        local __lux_tmp_209 = fill.colorB
        if __lux_tmp_209 == nil then
          local __lux_tmp_210 = fill.colorA
          if __lux_tmp_210 == nil then
            __lux_tmp_210 = color_white
          end
          __lux_tmp_209 = __lux_tmp_210
        end
        colorB = __lux_tmp_209
      end
      local r, g, b, a = style.color01(colorB)
      local sw, sh, ir, orad, sr, er, modeValue = ringShapeConstants(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      local p0, p1, p2, p3 = ringFillParams(fill)
      do
        local __lux_tmp_211 = fill.kind
        if __lux_tmp_211 == nil then
          __lux_tmp_211 = style.FILL_SOLID
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
          __lux_tmp_211,
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
        local __lux_tmp_212 = fill.colorA
        if __lux_tmp_212 == nil then
          __lux_tmp_212 = color_white
        end
        style.setDrawColor(__lux_tmp_212)
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    drawRingStrokePass = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, stroke, strokeWidth)
      local width = style.strokeWidth(strokeWidth, 0)
      local __lux_tmp_213 = not style.strokeVisible(stroke, width)
      if not __lux_tmp_213 then
        __lux_tmp_213 = not shadersActive()
      end
      local __lux_tmp_214 = __lux_tmp_213
      if not __lux_tmp_214 then
        __lux_tmp_214 = not materialOK(widgetMaterials.ring_stroke)
      end
      if __lux_tmp_214 then
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
      local hasGlow
      do
        local __lux_tmp_215 = innerEnabled
        if __lux_tmp_215 then
          __lux_tmp_215 = ga > 0
        end
        local __lux_tmp_216 = __lux_tmp_215
        if __lux_tmp_216 then
          __lux_tmp_216 = glowStrength > 0
        end
        hasGlow = __lux_tmp_216
      end
      if hasGlow then
        do
          local __lux_tmp_217 = toNumber(glowWidth)
          if __lux_tmp_217 == nil then
            __lux_tmp_217 = 8
          end
          glowWidth = mathMax(0.001, __lux_tmp_217)
        end
        do
          local __lux_tmp_218 = toNumber(glowStrength)
          if __lux_tmp_218 == nil then
            __lux_tmp_218 = 1
          end
          glowStrength = mathMax(0, __lux_tmp_218)
        end
        do
          local __lux_tmp_219 = toNumber(glowFalloff)
          if __lux_tmp_219 == nil then
            __lux_tmp_219 = 1.65
          end
          glowFalloff = mathMax(0.001, __lux_tmp_219)
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
      local __lux_tmp_220 = not hasStroke
      if __lux_tmp_220 then
        __lux_tmp_220 = not hasGlow
      end
      local __lux_tmp_221 = __lux_tmp_220
      if not __lux_tmp_221 then
        __lux_tmp_221 = not shadersActive()
      end
      local __lux_tmp_222 = __lux_tmp_221
      if not __lux_tmp_222 then
        __lux_tmp_222 = not materialOK(widgetMaterials.ring_fx)
      end
      if __lux_tmp_222 then
        return false
      end
      local material = widgetMaterials.ring_fx
      local colorB
      do
        local __lux_tmp_223 = fill.colorB
        if __lux_tmp_223 == nil then
          local __lux_tmp_224 = fill.colorA
          if __lux_tmp_224 == nil then
            __lux_tmp_224 = color_white
          end
          __lux_tmp_223 = __lux_tmp_224
        end
        colorB = __lux_tmp_223
      end
      local r, g, b, a = style.color01(colorB)
      local sw, sh, ir, orad, sr, er, modeValue = ringShapeConstants(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      local p0, p1, p2, p3 = ringFillParams(fill)
      do
        local __lux_tmp_225 = fill.kind
        if __lux_tmp_225 == nil then
          __lux_tmp_225 = style.FILL_SOLID
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
          __lux_tmp_225,
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
        local __lux_tmp_226 = fill.colorA
        if __lux_tmp_226 == nil then
          __lux_tmp_226 = color_white
        end
        style.setDrawColor(__lux_tmp_226)
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    drawRingInnerGlowPass = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, enabled, gr, gg, gb, ga, glowWidth, glowStrength, glowFalloff)
      local __lux_tmp_227 = not enabled
      if not __lux_tmp_227 then
        __lux_tmp_227 = ga <= 0
      end
      local __lux_tmp_228 = __lux_tmp_227
      if not __lux_tmp_228 then
        __lux_tmp_228 = glowStrength <= 0
      end
      local __lux_tmp_229 = __lux_tmp_228
      if not __lux_tmp_229 then
        __lux_tmp_229 = not shadersActive()
      end
      local __lux_tmp_230 = __lux_tmp_229
      if not __lux_tmp_230 then
        __lux_tmp_230 = not materialOK(widgetMaterials.ring_innerglow)
      end
      if __lux_tmp_230 then
        return false
      end
      local material = widgetMaterials.ring_innerglow
      local sw, sh, ir, orad, sr, er, modeValue = ringShapeConstants(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      do
        local __lux_tmp_231 = toNumber(glowWidth)
        if __lux_tmp_231 == nil then
          __lux_tmp_231 = 8
        end
        local __lux_tmp_232 = toNumber(glowStrength)
        if __lux_tmp_232 == nil then
          __lux_tmp_232 = 1
        end
        local __lux_tmp_233 = toNumber(glowFalloff)
        if __lux_tmp_233 == nil then
          __lux_tmp_233 = 1.65
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
          mathMax(0.001, __lux_tmp_231),
          mathMax(0, __lux_tmp_232),
          mathMax(0.001, __lux_tmp_233),
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
      local __lux_tmp_234 = not enabled
      if not __lux_tmp_234 then
        __lux_tmp_234 = alpha <= 0
      end
      local __lux_tmp_235 = __lux_tmp_234
      if not __lux_tmp_235 then
        __lux_tmp_235 = strength <= 0
      end
      if __lux_tmp_235 then
        return nil
      end
      do
        local __lux_tmp_236 = toNumber(grow)
        if __lux_tmp_236 == nil then
          __lux_tmp_236 = 0
        end
        grow = mathMax(0, __lux_tmp_236)
      end
      do
        local __lux_tmp_237 = toNumber(ox)
        if __lux_tmp_237 == nil then
          __lux_tmp_237 = 0
        end
        ox = __lux_tmp_237
      end
      do
        local __lux_tmp_238 = toNumber(oy)
        if __lux_tmp_238 == nil then
          __lux_tmp_238 = 0
        end
        oy = __lux_tmp_238
      end
      do
        local __lux_tmp_239 = toNumber(width)
        if __lux_tmp_239 == nil then
          __lux_tmp_239 = 18
        end
        width = mathMax(0.001, __lux_tmp_239)
      end
      do
        local __lux_tmp_240 = toNumber(extent)
        if __lux_tmp_240 == nil then
          __lux_tmp_240 = width
        end
        extent = mathMax(1, __lux_tmp_240)
      end
      do
        local __lux_tmp_241 = toNumber(strength)
        if __lux_tmp_241 == nil then
          __lux_tmp_241 = 1
        end
        strength = mathMax(0, __lux_tmp_241)
      end
      do
        local __lux_tmp_242 = toNumber(falloff)
        if __lux_tmp_242 == nil then
          __lux_tmp_242 = 1.9
        end
        falloff = mathMax(0.001, __lux_tmp_242)
      end
      local gx = x + ox - grow
      local gy = y + oy - grow
      local gw = w + grow * 2
      local gh = h + grow * 2
      local gi
      do
        local __lux_tmp_243 = toNumber(innerRadius)
        if __lux_tmp_243 == nil then
          __lux_tmp_243 = 0
        end
        gi = mathMax(0, __lux_tmp_243 - grow)
      end
      local go
      do
        local __lux_tmp_244 = toNumber(outerRadius)
        if __lux_tmp_244 == nil then
          __lux_tmp_244 = mathMin(w, h) * 0.5
        end
        go = mathMax(0.001, __lux_tmp_244 + grow)
      end
      local spread = extent
      if biasOffset then
        local left, top, right, bottom = roundrect.glowBiasPads(spread, ox, oy)
        local __lux_tmp_245 = toNumber(startDeg)
        if __lux_tmp_245 == nil then
          __lux_tmp_245 = 0
        end
        local __lux_tmp_246 = toNumber(endDeg)
        if __lux_tmp_246 == nil then
          __lux_tmp_246 = 360
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
          start = mathRad(__lux_tmp_245),
          finish = mathRad(__lux_tmp_246),
          mode = ringModeValue(mode),
          width = width,
          strength = strength,
          falloff = falloff,
        }
      end
      local __lux_tmp_247 = toNumber(startDeg)
      if __lux_tmp_247 == nil then
        __lux_tmp_247 = 0
      end
      local __lux_tmp_248 = toNumber(endDeg)
      if __lux_tmp_248 == nil then
        __lux_tmp_248 = 360
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
        start = mathRad(__lux_tmp_247),
        finish = mathRad(__lux_tmp_248),
        mode = ringModeValue(mode),
        width = width,
        strength = strength,
        falloff = falloff,
      }
    end
    drawRingShadowOuterPass = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowExtent, shadowGrow, shadowStrength, shadowFalloff, hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerExtent, outerGrow, outerStrength, outerFalloff)
      local __lux_tmp_249 = not hasShadow
      if __lux_tmp_249 then
        __lux_tmp_249 = not hasOuter
      end
      local __lux_tmp_250 = __lux_tmp_249
      if not __lux_tmp_250 then
        __lux_tmp_250 = not shadersActive()
      end
      local __lux_tmp_251 = __lux_tmp_250
      if not __lux_tmp_251 then
        __lux_tmp_251 = not materialOK(widgetMaterials.ring_shadow_outer)
      end
      if __lux_tmp_251 then
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
      local __lux_tmp_252 = shadowBounds == nil
      if __lux_tmp_252 then
        __lux_tmp_252 = outerBounds == nil
      end
      if __lux_tmp_252 then
        return false
      end
      local baseBounds
      do
        local __lux_tmp_253 = shadowBounds
        if __lux_tmp_253 == nil then
          __lux_tmp_253 = outerBounds
        end
        baseBounds = __lux_tmp_253
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
        local __lux_tmp_254
        if shadowBounds ~= nil then
          __lux_tmp_254 = sr
        else
          __lux_tmp_254 = 0
        end
        local __lux_tmp_255
        if shadowBounds ~= nil then
          __lux_tmp_255 = sg
        else
          __lux_tmp_255 = 0
        end
        local __lux_tmp_256
        if shadowBounds ~= nil then
          __lux_tmp_256 = sb
        else
          __lux_tmp_256 = 0
        end
        local __lux_tmp_257
        if shadowBounds ~= nil then
          __lux_tmp_257 = sa
        else
          __lux_tmp_257 = 0
        end
        local __lux_obj_258 = shadowBounds
        local __lux_val_259 = nil
        if __lux_obj_258 ~= nil then
          __lux_val_259 = __lux_obj_258.x
        end
        local __lux_tmp_260 = __lux_val_259
        if __lux_tmp_260 == nil then
          __lux_tmp_260 = x
        end
        local __lux_obj_261 = shadowBounds
        local __lux_val_262 = nil
        if __lux_obj_261 ~= nil then
          __lux_val_262 = __lux_obj_261.shapeX
        end
        local __lux_tmp_263 = __lux_val_262
        if __lux_tmp_263 == nil then
          __lux_tmp_263 = 0
        end
        local __lux_obj_264 = shadowBounds
        local __lux_val_265 = nil
        if __lux_obj_264 ~= nil then
          __lux_val_265 = __lux_obj_264.outer
        end
        local __lux_tmp_266 = __lux_val_265
        if __lux_tmp_266 == nil then
          __lux_tmp_266 = 0
        end
        local __lux_obj_267 = shadowBounds
        local __lux_val_268 = nil
        if __lux_obj_267 ~= nil then
          __lux_val_268 = __lux_obj_267.y
        end
        local __lux_tmp_269 = __lux_val_268
        if __lux_tmp_269 == nil then
          __lux_tmp_269 = y
        end
        local __lux_obj_270 = shadowBounds
        local __lux_val_271 = nil
        if __lux_obj_270 ~= nil then
          __lux_val_271 = __lux_obj_270.shapeY
        end
        local __lux_tmp_272 = __lux_val_271
        if __lux_tmp_272 == nil then
          __lux_tmp_272 = 0
        end
        local __lux_obj_273 = shadowBounds
        local __lux_val_274 = nil
        if __lux_obj_273 ~= nil then
          __lux_val_274 = __lux_obj_273.outer
        end
        local __lux_tmp_275 = __lux_val_274
        if __lux_tmp_275 == nil then
          __lux_tmp_275 = 0
        end
        local __lux_obj_276 = shadowBounds
        local __lux_val_277 = nil
        if __lux_obj_276 ~= nil then
          __lux_val_277 = __lux_obj_276.inner
        end
        local __lux_tmp_278 = __lux_val_277
        if __lux_tmp_278 == nil then
          __lux_tmp_278 = 0
        end
        local __lux_obj_279 = shadowBounds
        local __lux_val_280 = nil
        if __lux_obj_279 ~= nil then
          __lux_val_280 = __lux_obj_279.outer
        end
        local __lux_tmp_281 = __lux_val_280
        if __lux_tmp_281 == nil then
          __lux_tmp_281 = 1
        end
        local __lux_obj_282 = shadowBounds
        local __lux_val_283 = nil
        if __lux_obj_282 ~= nil then
          __lux_val_283 = __lux_obj_282.start
        end
        local __lux_tmp_284 = __lux_val_283
        if __lux_tmp_284 == nil then
          __lux_tmp_284 = 0
        end
        local __lux_obj_285 = shadowBounds
        local __lux_val_286 = nil
        if __lux_obj_285 ~= nil then
          __lux_val_286 = __lux_obj_285.finish
        end
        local __lux_tmp_287 = __lux_val_286
        if __lux_tmp_287 == nil then
          __lux_tmp_287 = mathRad(360)
        end
        local __lux_obj_288 = shadowBounds
        local __lux_val_289 = nil
        if __lux_obj_288 ~= nil then
          __lux_val_289 = __lux_obj_288.mode
        end
        local __lux_tmp_290 = __lux_val_289
        if __lux_tmp_290 == nil then
          __lux_tmp_290 = 0
        end
        local __lux_tmp_291
        if shadowBounds ~= nil then
          __lux_tmp_291 = shadowBounds.width
        else
          __lux_tmp_291 = 1
        end
        setupParamMatrix(
          material,
          drawW,
          drawH,
          0,
          0,
          __lux_tmp_254,
          __lux_tmp_255,
          __lux_tmp_256,
          __lux_tmp_257,
          __lux_tmp_260 + __lux_tmp_263 + __lux_tmp_266 - sx,
          __lux_tmp_269 + __lux_tmp_272 + __lux_tmp_275 - sy,
          __lux_tmp_278,
          __lux_tmp_281,
          __lux_tmp_284,
          __lux_tmp_287,
          __lux_tmp_290,
          __lux_tmp_291
        )
      end
      do
        local __lux_tmp_292
        if outerBounds ~= nil then
          __lux_tmp_292 = orr
        else
          __lux_tmp_292 = 0
        end
        local __lux_tmp_293
        if outerBounds ~= nil then
          __lux_tmp_293 = og
        else
          __lux_tmp_293 = 0
        end
        local __lux_tmp_294
        if outerBounds ~= nil then
          __lux_tmp_294 = ob
        else
          __lux_tmp_294 = 0
        end
        local __lux_tmp_295
        if outerBounds ~= nil then
          __lux_tmp_295 = oa
        else
          __lux_tmp_295 = 0
        end
        local __lux_obj_296 = outerBounds
        local __lux_val_297 = nil
        if __lux_obj_296 ~= nil then
          __lux_val_297 = __lux_obj_296.x
        end
        local __lux_tmp_298 = __lux_val_297
        if __lux_tmp_298 == nil then
          __lux_tmp_298 = x
        end
        local __lux_obj_299 = outerBounds
        local __lux_val_300 = nil
        if __lux_obj_299 ~= nil then
          __lux_val_300 = __lux_obj_299.shapeX
        end
        local __lux_tmp_301 = __lux_val_300
        if __lux_tmp_301 == nil then
          __lux_tmp_301 = 0
        end
        local __lux_obj_302 = outerBounds
        local __lux_val_303 = nil
        if __lux_obj_302 ~= nil then
          __lux_val_303 = __lux_obj_302.outer
        end
        local __lux_tmp_304 = __lux_val_303
        if __lux_tmp_304 == nil then
          __lux_tmp_304 = 0
        end
        local __lux_obj_305 = outerBounds
        local __lux_val_306 = nil
        if __lux_obj_305 ~= nil then
          __lux_val_306 = __lux_obj_305.y
        end
        local __lux_tmp_307 = __lux_val_306
        if __lux_tmp_307 == nil then
          __lux_tmp_307 = y
        end
        local __lux_obj_308 = outerBounds
        local __lux_val_309 = nil
        if __lux_obj_308 ~= nil then
          __lux_val_309 = __lux_obj_308.shapeY
        end
        local __lux_tmp_310 = __lux_val_309
        if __lux_tmp_310 == nil then
          __lux_tmp_310 = 0
        end
        local __lux_obj_311 = outerBounds
        local __lux_val_312 = nil
        if __lux_obj_311 ~= nil then
          __lux_val_312 = __lux_obj_311.outer
        end
        local __lux_tmp_313 = __lux_val_312
        if __lux_tmp_313 == nil then
          __lux_tmp_313 = 0
        end
        local __lux_obj_314 = outerBounds
        local __lux_val_315 = nil
        if __lux_obj_314 ~= nil then
          __lux_val_315 = __lux_obj_314.inner
        end
        local __lux_tmp_316 = __lux_val_315
        if __lux_tmp_316 == nil then
          __lux_tmp_316 = 0
        end
        local __lux_obj_317 = outerBounds
        local __lux_val_318 = nil
        if __lux_obj_317 ~= nil then
          __lux_val_318 = __lux_obj_317.outer
        end
        local __lux_tmp_319 = __lux_val_318
        if __lux_tmp_319 == nil then
          __lux_tmp_319 = 1
        end
        local __lux_obj_320 = outerBounds
        local __lux_val_321 = nil
        if __lux_obj_320 ~= nil then
          __lux_val_321 = __lux_obj_320.start
        end
        local __lux_tmp_322 = __lux_val_321
        if __lux_tmp_322 == nil then
          __lux_tmp_322 = 0
        end
        local __lux_obj_323 = outerBounds
        local __lux_val_324 = nil
        if __lux_obj_323 ~= nil then
          __lux_val_324 = __lux_obj_323.finish
        end
        local __lux_tmp_325 = __lux_val_324
        if __lux_tmp_325 == nil then
          __lux_tmp_325 = mathRad(360)
        end
        local __lux_obj_326 = outerBounds
        local __lux_val_327 = nil
        if __lux_obj_326 ~= nil then
          __lux_val_327 = __lux_obj_326.mode
        end
        local __lux_tmp_328 = __lux_val_327
        if __lux_tmp_328 == nil then
          __lux_tmp_328 = 0
        end
        local __lux_tmp_329
        if outerBounds ~= nil then
          __lux_tmp_329 = outerBounds.width
        else
          __lux_tmp_329 = 1
        end
        local __lux_tmp_330
        if shadowBounds ~= nil then
          __lux_tmp_330 = shadowBounds.falloff
        else
          __lux_tmp_330 = 1
        end
        local __lux_tmp_331
        if shadowBounds ~= nil then
          __lux_tmp_331 = shadowBounds.strength
        else
          __lux_tmp_331 = 0
        end
        local __lux_tmp_332
        if outerBounds ~= nil then
          __lux_tmp_332 = outerBounds.falloff
        else
          __lux_tmp_332 = 1
        end
        local __lux_tmp_333
        if outerBounds ~= nil then
          __lux_tmp_333 = outerBounds.strength
        else
          __lux_tmp_333 = 0
        end
        setupAuxConstants(
          material,
          __lux_tmp_292,
          __lux_tmp_293,
          __lux_tmp_294,
          __lux_tmp_295,
          __lux_tmp_298 + __lux_tmp_301 + __lux_tmp_304 - sx,
          __lux_tmp_307 + __lux_tmp_310 + __lux_tmp_313 - sy,
          __lux_tmp_316,
          __lux_tmp_319,
          __lux_tmp_322,
          __lux_tmp_325,
          __lux_tmp_328,
          __lux_tmp_329,
          __lux_tmp_330,
          __lux_tmp_331,
          __lux_tmp_332,
          __lux_tmp_333
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
      local __lux_tmp_334 = spec == nil
      if not __lux_tmp_334 then
        __lux_tmp_334 = spec.tint == nil
      end
      if __lux_tmp_334 then
        return nil
      end
      local tint = spec.tint
      local alpha
      do
        local __lux_tmp_335 = tint.a
        if __lux_tmp_335 == nil then
          __lux_tmp_335 = 255
        end
        local __lux_tmp_336 = spec.opacity
        if __lux_tmp_336 == nil then
          __lux_tmp_336 = 1
        end
        alpha = __lux_tmp_335 * __lux_tmp_336
      end
      if alpha <= 0 then
        return nil
      end
      local __lux_tmp_337 = tint.r
      if __lux_tmp_337 == nil then
        __lux_tmp_337 = 0
      end
      local __lux_tmp_338 = tint.g
      if __lux_tmp_338 == nil then
        __lux_tmp_338 = 0
      end
      local __lux_tmp_339 = tint.b
      if __lux_tmp_339 == nil then
        __lux_tmp_339 = 0
      end
      return makeColor(
        __lux_tmp_337,
        __lux_tmp_338,
        __lux_tmp_339,
        mathFloor(mathClamp(alpha, 0, 255) + 0.5)
      )
    end
    setupRingBackdropConstants = function(material, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, vertical, intensity)
      local sw, sh, ir, orad, sr, er, modeValue = ringShapeConstants(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      local __lux_tmp_340 = vertical
      if __lux_tmp_340 then
        __lux_tmp_340 = 1
      end
      local __lux_tmp_341 = __lux_tmp_340
      if not __lux_tmp_341 then
        __lux_tmp_341 = 0
      end
      local __lux_tmp_342 = intensity
      if __lux_tmp_342 == nil then
        __lux_tmp_342 = 1
      end
      return setupParamMatrix(
        material,
        __lux_tmp_341,
        __lux_tmp_342,
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
        local __lux_tmp_343 = toNumber(spec.padding)
        if __lux_tmp_343 == nil then
          __lux_tmp_343 = 0
        end
        pad = mathMax(0, __lux_tmp_343)
      end
      local bx = x - pad
      local by = y - pad
      local bw = w + pad * 2
      local bh = h + pad * 2
      local bi
      do
        local __lux_tmp_344 = toNumber(innerRadius)
        if __lux_tmp_344 == nil then
          __lux_tmp_344 = 0
        end
        bi = mathMax(0, __lux_tmp_344 - pad)
      end
      local bo
      do
        local __lux_tmp_345 = toNumber(outerRadius)
        if __lux_tmp_345 == nil then
          __lux_tmp_345 = mathMin(w, h) * 0.5
        end
        bo = mathMax(0.001, __lux_tmp_345 + pad)
      end
      local __lux_tmp_346 = spec.blur > 0
      if __lux_tmp_346 then
        __lux_tmp_346 = widgetBlurRT ~= nil
      end
      local __lux_tmp_347 = __lux_tmp_346
      if __lux_tmp_347 then
        __lux_tmp_347 = renderCopyRenderTargetToTexture ~= nil
      end
      local __lux_tmp_348 = __lux_tmp_347
      if __lux_tmp_348 then
        __lux_tmp_348 = materialOK(widgetMaterials.ring_backdrop)
      end
      if __lux_tmp_348 then
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
      local __lux_tmp_349 = spec == nil
      if not __lux_tmp_349 then
        __lux_tmp_349 = not shadersActive()
      end
      local __lux_tmp_350 = __lux_tmp_349
      if not __lux_tmp_350 then
        __lux_tmp_350 = not materialOK(widgetMaterials.ring_pattern)
      end
      if __lux_tmp_350 then
        return false
      end
      local material = widgetMaterials.ring_pattern
      local angle
      do
        local __lux_tmp_351 = toNumber(spec.angle)
        if __lux_tmp_351 == nil then
          __lux_tmp_351 = 135
        end
        angle = mathRad(__lux_tmp_351)
      end
      local smoke
      local __lux_match_352 = spec.kind
      if __lux_match_352 == "smoke" then
        smoke = true
      else
        smoke = false
      end
      local pz
      if smoke then
        do
          local __lux_tmp_353 = toNumber(spec.scale)
          if __lux_tmp_353 == nil then
            __lux_tmp_353 = 140
          end
          pz = mathMax(1, __lux_tmp_353)
        end
      else
        do
          local __lux_tmp_354 = toNumber(spec.spacing)
          if __lux_tmp_354 == nil then
            __lux_tmp_354 = 12
          end
          pz = mathMax(1, __lux_tmp_354)
        end
      end
      local pw
      if smoke then
        do
          local __lux_tmp_355 = toNumber(spec.density)
          if __lux_tmp_355 == nil then
            __lux_tmp_355 = 0.48
          end
          pw = mathClamp(__lux_tmp_355, 0, 1)
        end
      else
        do
          local __lux_tmp_356 = toNumber(spec.width)
          if __lux_tmp_356 == nil then
            __lux_tmp_356 = 2
          end
          pw = mathMax(0.25, __lux_tmp_356)
        end
      end
      do
        local __lux_tmp_357
        if smoke then
          do
            local __lux_tmp_358 = toNumber(spec.seed)
            if __lux_tmp_358 == nil then
              __lux_tmp_358 = 0
            end
            __lux_tmp_357 = __lux_tmp_358
          end
        else
          __lux_tmp_357 = 0
        end
        local __lux_tmp_359
        if smoke then
          do
            local __lux_tmp_360 = toNumber(spec.softness)
            if __lux_tmp_360 == nil then
              __lux_tmp_360 = 0.3
            end
            __lux_tmp_359 = mathMax(0.001, __lux_tmp_360)
          end
        else
          __lux_tmp_359 = 0
        end
        local __lux_tmp_361
        if smoke then
          do
            local __lux_tmp_362 = toNumber(spec.warp)
            if __lux_tmp_362 == nil then
              __lux_tmp_362 = 0.85
            end
            __lux_tmp_361 = mathMax(0, __lux_tmp_362)
          end
        else
          __lux_tmp_361 = 0
        end
        local __lux_tmp_363 = toNumber(innerRadius)
        if __lux_tmp_363 == nil then
          __lux_tmp_363 = 0
        end
        local __lux_tmp_364 = toNumber(outerRadius)
        if __lux_tmp_364 == nil then
          __lux_tmp_364 = mathMin(w, h) * 0.5
        end
        local __lux_tmp_365 = toNumber(startDeg)
        if __lux_tmp_365 == nil then
          __lux_tmp_365 = 0
        end
        local __lux_tmp_366 = toNumber(endDeg)
        if __lux_tmp_366 == nil then
          __lux_tmp_366 = 360
        end
        local __lux_tmp_367
        if smoke then
          __lux_tmp_367 = 1
        else
          __lux_tmp_367 = 0
        end
        setupParamMatrix(
          material,
          __lux_tmp_357,
          roundrect.patternOffset(spec),
          __lux_tmp_359,
          __lux_tmp_361,
          w,
          h,
          mathMax(0, __lux_tmp_363),
          mathMax(0.001, __lux_tmp_364),
          mathRad(__lux_tmp_365),
          mathRad(__lux_tmp_366),
          ringModeValue(mode),
          __lux_tmp_367,
          mathCos(angle),
          mathSin(angle),
          pz,
          pw
        )
      end
      do
        local __lux_tmp_368 = spec.color
        if __lux_tmp_368 == nil then
          local __lux_tmp_369 = spec.tint
          if __lux_tmp_369 == nil then
            __lux_tmp_369 = makeColor(255, 255, 255, 24)
          end
          __lux_tmp_368 = __lux_tmp_369
        end
        style.setDrawColor(__lux_tmp_368)
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    drawRingBoxRaw = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, fillInput, colorInput, stroke, strokeWidthInput, shadow, outerGlow, innerGlow, backdrop, pattern, segments)
      local fill
      do
        local __lux_tmp_370 = fillInput
        if __lux_tmp_370 == nil then
          local __lux_tmp_371 = colorInput
          if __lux_tmp_371 == nil then
            __lux_tmp_371 = defaultRingFill
          end
          __lux_tmp_370 = __lux_tmp_371
        end
        fill = style.fillFromStyle(__lux_tmp_370)
      end
      local __lux_tmp_372 = not shadersActive()
      if not __lux_tmp_372 then
        __lux_tmp_372 = not materialOK(widgetMaterials.ring)
      end
      if __lux_tmp_372 then
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
      local __lux_tmp_373 = hasShadow
      if not __lux_tmp_373 then
        __lux_tmp_373 = hasOuter
      end
      if __lux_tmp_373 then
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
      local __lux_tmp_374 = pattern == nil
      if __lux_tmp_374 then
        local __lux_tmp_375 = hasStroke
        if not __lux_tmp_375 then
          __lux_tmp_375 = hasInner
        end
        __lux_tmp_374 = __lux_tmp_375
      end
      local __lux_tmp_376 = __lux_tmp_374
      if __lux_tmp_376 then
        __lux_tmp_376 = drawRingFxPass(
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
      )
      end
      if __lux_tmp_376 then
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
      local resolved
      do
        local __lux_tmp_377 = drawStyle
        if __lux_tmp_377 == nil then
          __lux_tmp_377 = {}
        end
        resolved = __lux_tmp_377
      end
      local transform, stripped = geometry.splitStyleTransform(resolved)
      local outerRadius
      do
        local __lux_tmp_378 = toNumber(radius)
        if __lux_tmp_378 == nil then
          __lux_tmp_378 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_378)
      end
      local ringWidth
      do
        local __lux_tmp_379 = toNumber(width)
        if __lux_tmp_379 == nil then
          __lux_tmp_379 = mathMax(1, outerRadius * 0.18)
        end
        ringWidth = mathMax(0.001, __lux_tmp_379)
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
        local __lux_tmp_380 = toNumber(radius)
        if __lux_tmp_380 == nil then
          __lux_tmp_380 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_380)
      end
      local ringWidth
      do
        local __lux_tmp_381 = toNumber(width)
        if __lux_tmp_381 == nil then
          __lux_tmp_381 = mathMax(1, outerRadius * 0.18)
        end
        ringWidth = mathMax(0.001, __lux_tmp_381)
      end
      local innerRadius = mathMax(0, outerRadius - ringWidth)
      local x = cx - outerRadius
      local y = cy - outerRadius
      local size = outerRadius * 2
      return drawRingBoxRaw(x, y, size, size, innerRadius, outerRadius, 0, 360, 0, fill)
    end
    arcEx = function(cx, cy, radius, width, startDeg, endDeg, drawStyle)
      local resolved
      do
        local __lux_tmp_382 = drawStyle
        if __lux_tmp_382 == nil then
          __lux_tmp_382 = {}
        end
        resolved = __lux_tmp_382
      end
      local transform, stripped = geometry.splitStyleTransform(resolved)
      local outerRadius
      do
        local __lux_tmp_383 = toNumber(radius)
        if __lux_tmp_383 == nil then
          __lux_tmp_383 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_383)
      end
      local arcWidth
      do
        local __lux_tmp_384 = toNumber(width)
        if __lux_tmp_384 == nil then
          __lux_tmp_384 = mathMax(1, outerRadius * 0.18)
        end
        arcWidth = mathMax(0.001, __lux_tmp_384)
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
        local __lux_tmp_385 = toNumber(radius)
        if __lux_tmp_385 == nil then
          __lux_tmp_385 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_385)
      end
      local arcWidth
      do
        local __lux_tmp_386 = toNumber(width)
        if __lux_tmp_386 == nil then
          __lux_tmp_386 = mathMax(1, outerRadius * 0.18)
        end
        arcWidth = mathMax(0.001, __lux_tmp_386)
      end
      local innerRadius = mathMax(0, outerRadius - arcWidth)
      local x = cx - outerRadius
      local y = cy - outerRadius
      local size = outerRadius * 2
      return drawRingBoxRaw(x, y, size, size, innerRadius, outerRadius, startDeg, endDeg, 1, fill)
    end
    sectorEx = function(cx, cy, innerRadius, outerRadius, startDeg, endDeg, drawStyle)
      local resolved
      do
        local __lux_tmp_387 = drawStyle
        if __lux_tmp_387 == nil then
          __lux_tmp_387 = {}
        end
        resolved = __lux_tmp_387
      end
      local transform, stripped = geometry.splitStyleTransform(resolved)
      do
        local __lux_tmp_388 = toNumber(outerRadius)
        if __lux_tmp_388 == nil then
          __lux_tmp_388 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_388)
      end
      do
        local __lux_tmp_389 = toNumber(innerRadius)
        if __lux_tmp_389 == nil then
          __lux_tmp_389 = 0
        end
        innerRadius = mathClamp(__lux_tmp_389, 0, outerRadius)
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
        local __lux_tmp_390 = toNumber(outerRadius)
        if __lux_tmp_390 == nil then
          __lux_tmp_390 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_390)
      end
      do
        local __lux_tmp_391 = toNumber(innerRadius)
        if __lux_tmp_391 == nil then
          __lux_tmp_391 = 0
        end
        innerRadius = mathClamp(__lux_tmp_391, 0, outerRadius)
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
            local __lux_tmp_392
            do
              local __lux_tmp_393 = material ~= nil
              if __lux_tmp_393 then
                __lux_tmp_393 = material.IsError ~= nil
              end
              local __lux_tmp_394 = __lux_tmp_393
              if __lux_tmp_394 then
                __lux_tmp_394 = not material:IsError()
              end
              if __lux_tmp_394 then
                __lux_tmp_392 = material
              else
                __lux_tmp_392 = false
              end
            end
            cached = __lux_tmp_392
          end
          imageMaterialCache[source] = cached
        end
        if cached == false then
          return nil, nil
        end
        return cached:GetTexture("$basetexture"), cached
      end
      local __lux_tmp_395 = source ~= nil
      if __lux_tmp_395 then
        __lux_tmp_395 = source.GetTexture ~= nil
      end
      if __lux_tmp_395 then
        return source:GetTexture("$basetexture"), source
      end
      local __lux_tmp_396 = source ~= nil
      if __lux_tmp_396 then
        __lux_tmp_396 = source.GetName ~= nil
      end
      if __lux_tmp_396 then
        return source, nil
      end
      return nil, nil
    end
    imageWhiteTextureSource = function()
      if imageWhiteTexture ~= nil then
        local __lux_tmp_397 = imageWhiteTexture ~= false
        if __lux_tmp_397 then
          __lux_tmp_397 = imageWhiteTexture
        end
        local __lux_tmp_398 = __lux_tmp_397
        if not __lux_tmp_398 then
          __lux_tmp_398 = nil
        end
        return __lux_tmp_398
      end
      local texture = imageTextureSource("color/white")
      do
        local __lux_tmp_399 = texture
        if __lux_tmp_399 == nil then
          __lux_tmp_399 = false
        end
        imageWhiteTexture = __lux_tmp_399
      end
      local __lux_tmp_400 = imageWhiteTexture ~= false
      if __lux_tmp_400 then
        __lux_tmp_400 = imageWhiteTexture
      end
      local __lux_tmp_401 = __lux_tmp_400
      if not __lux_tmp_401 then
        __lux_tmp_401 = nil
      end
      return __lux_tmp_401
    end
    imageFallbackMaterialForTexture = function(texture)
      local __lux_tmp_402 = texture == nil
      if not __lux_tmp_402 then
        __lux_tmp_402 = imageCreateMaterial == nil
      end
      if __lux_tmp_402 then
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
      local __lux_tmp_403 = kind ~= nil
      if __lux_tmp_403 then
        __lux_tmp_403 = kind >= 10
      end
      return __lux_tmp_403
    end
    imageMaskKindValue = function(mask)
      if typeOf(mask) ~= "table" then
        return nil
      end
      local kind
      do
        local __lux_tmp_404 = mask.kind
        if __lux_tmp_404 == nil then
          __lux_tmp_404 = mask.shape
        end
        kind = __lux_tmp_404
      end
      if typeOf(kind) ~= "string" then
        return nil
      end
      kind = imageStringLower(kind)
      local __lux_match_405 = kind
      if __lux_match_405 == "round" or __lux_match_405 == "rounded" or __lux_match_405 == "roundedbox" or __lux_match_405 == "roundrect" then
        return 0
      elseif __lux_match_405 == "chamfer" or __lux_match_405 == "bevel" then
        return 1
      elseif __lux_match_405 == "circle" then
        return 2
      elseif __lux_match_405 == "capsule" or __lux_match_405 == "pill" then
        return 3
      elseif __lux_match_405 == "texture" or __lux_match_405 == "alpha" or __lux_match_405 == "image" then
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
      local __lux_match_406 = normalized
      if __lux_match_406 == "a" or __lux_match_406 == "alpha" then
        return 10
      elseif __lux_match_406 == "r" or __lux_match_406 == "red" then
        return 11
      elseif __lux_match_406 == "g" or __lux_match_406 == "green" then
        return 12
      elseif __lux_match_406 == "b" or __lux_match_406 == "blue" then
        return 13
      elseif __lux_match_406 == "luma" or __lux_match_406 == "lum" or __lux_match_406 == "luminance" or __lux_match_406 == "rgb" then
        return 14
      else
        return nil
      end
    end
    imageMaskTextureSource = function(mask)
      if typeOf(mask) ~= "table" then
        return nil, nil
      end
      local source
      do
        local __lux_tmp_407 = mask.source
        if __lux_tmp_407 == nil then
          local __lux_tmp_408 = mask.material
          if __lux_tmp_408 == nil then
            local __lux_tmp_409 = mask.texture
            if __lux_tmp_409 == nil then
              __lux_tmp_409 = mask.image
            end
            __lux_tmp_408 = __lux_tmp_409
          end
          __lux_tmp_407 = __lux_tmp_408
        end
        source = __lux_tmp_407
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
      local __lux_tmp_410 = typeOf(mask.uv) == "table"
      if not __lux_tmp_410 then
        __lux_tmp_410 = typeOf(mask.crop) == "table"
      end
      if __lux_tmp_410 then
        return geometry.imageUV(mask, texture)
      end
      local u0
      do
        local __lux_tmp_411 = mask.u0
        if __lux_tmp_411 == nil then
          local __lux_tmp_412 = mask.x0
          if __lux_tmp_412 == nil then
            __lux_tmp_412 = mask[1]
          end
          __lux_tmp_411 = __lux_tmp_412
        end
        local __lux_tmp_413 = toNumber(__lux_tmp_411)
        if __lux_tmp_413 == nil then
          __lux_tmp_413 = 0
        end
        u0 = __lux_tmp_413
      end
      local v0
      do
        local __lux_tmp_414 = mask.v0
        if __lux_tmp_414 == nil then
          local __lux_tmp_415 = mask.y0
          if __lux_tmp_415 == nil then
            __lux_tmp_415 = mask[2]
          end
          __lux_tmp_414 = __lux_tmp_415
        end
        local __lux_tmp_416 = toNumber(__lux_tmp_414)
        if __lux_tmp_416 == nil then
          __lux_tmp_416 = 0
        end
        v0 = __lux_tmp_416
      end
      local u1
      do
        local __lux_tmp_417 = mask.u1
        if __lux_tmp_417 == nil then
          local __lux_tmp_418 = mask.x1
          if __lux_tmp_418 == nil then
            __lux_tmp_418 = mask[3]
          end
          __lux_tmp_417 = __lux_tmp_418
        end
        local __lux_tmp_419 = toNumber(__lux_tmp_417)
        if __lux_tmp_419 == nil then
          __lux_tmp_419 = 1
        end
        u1 = __lux_tmp_419
      end
      local v1
      do
        local __lux_tmp_420 = mask.v1
        if __lux_tmp_420 == nil then
          local __lux_tmp_421 = mask.y1
          if __lux_tmp_421 == nil then
            __lux_tmp_421 = mask[4]
          end
          __lux_tmp_420 = __lux_tmp_421
        end
        local __lux_tmp_422 = toNumber(__lux_tmp_420)
        if __lux_tmp_422 == nil then
          __lux_tmp_422 = 1
        end
        v1 = __lux_tmp_422
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
      local resolvedMask
      do
        local __lux_tmp_423 = mask
        if __lux_tmp_423 == nil then
          __lux_tmp_423 = style.imageMaskStyle(drawStyle.mask, drawStyle)
        end
        resolvedMask = __lux_tmp_423
      end
      if typeOf(resolvedMask) ~= "table" then
        return nil
      end
      local __lux_match_424 = resolvedMask
      local __lux_tag_425
      if __lux_match_424 ~= nil then
        __lux_tag_425 = __lux_match_424.kind
      end
      if __lux_tag_425 == "chamfer" then
        local cuts = __lux_match_424.cuts
        local __lux_tmp_426 = cuts
        if __lux_tmp_426 == nil then
          __lux_tmp_426 = 0
        end
        return __lux_tmp_426
      else
        return nil
      end
    end
    imageChamferMaskTuple = function(mask, w, h)
      local cuts
      do
        local __lux_tmp_427 = mask ~= nil
        if __lux_tmp_427 then
          __lux_tmp_427 = mask.cuts
        end
        local __lux_tmp_428 = __lux_tmp_427
        if not __lux_tmp_428 then
          __lux_tmp_428 = 0
        end
        cuts = __lux_tmp_428
      end
      return primitives.chamferTuple(cuts, w, h)
    end
    setupImageMaskConstants = function(material, w, h, sourceU0, sourceV0, sourceU1, sourceV1, stroke, strokeWidth, mask, kind, maskTexture, sourceAlphaBase)
      if sourceAlphaBase == nil then
        sourceAlphaBase = false
      end
      local strokeColor
      do
        local __lux_tmp_429 = stroke
        if __lux_tmp_429 == nil then
          __lux_tmp_429 = transparentColor
        end
        strokeColor = __lux_tmp_429
      end
      local r, g, b, a = style.color01(strokeColor)
      local strokeR = r
      local strokeG = g
      local strokeB = b
      local strokeA = a
      local packedKind = kind
      local __lux_tmp_430 = mask ~= nil
      if __lux_tmp_430 then
        local __lux_tmp_431 = mask.invert
        if not __lux_tmp_431 then
          __lux_tmp_431 = mask.inverse
        end
        __lux_tmp_430 = __lux_tmp_431
      end
      if __lux_tmp_430 then
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
      local __lux_tmp_432 = mask ~= nil
      if __lux_tmp_432 then
        __lux_tmp_432 = geometry.imageRadius(mask.radius, w, h)
      end
      local __lux_tmp_433 = __lux_tmp_432
      if not __lux_tmp_433 then
        __lux_tmp_433 = 0
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
        __lux_tmp_433,
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
      local __lux_tmp_434 = texture == nil
      if not __lux_tmp_434 then
        __lux_tmp_434 = not materialOK(widgetMaterials.image_mask)
      end
      if __lux_tmp_434 then
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
        local __lux_tmp_435 = tint
        if __lux_tmp_435 == nil then
          __lux_tmp_435 = color_white
        end
        style.setDrawColor(__lux_tmp_435)
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
      local __lux_tmp_436 = spec == nil
      if not __lux_tmp_436 then
        __lux_tmp_436 = spec.tint == nil
      end
      if __lux_tmp_436 then
        return nil
      end
      local tint = spec.tint
      local alpha
      do
        local __lux_tmp_437 = tint.a
        if __lux_tmp_437 == nil then
          __lux_tmp_437 = 255
        end
        local __lux_tmp_438 = spec.opacity
        if __lux_tmp_438 == nil then
          __lux_tmp_438 = 1
        end
        alpha = __lux_tmp_437 * __lux_tmp_438
      end
      if alpha <= 0 then
        return nil
      end
      local __lux_tmp_439 = tint.r
      if __lux_tmp_439 == nil then
        __lux_tmp_439 = 0
      end
      local __lux_tmp_440 = tint.g
      if __lux_tmp_440 == nil then
        __lux_tmp_440 = 0
      end
      local __lux_tmp_441 = tint.b
      if __lux_tmp_441 == nil then
        __lux_tmp_441 = 0
      end
      return makeColor(
        __lux_tmp_439,
        __lux_tmp_440,
        __lux_tmp_441,
        mathFloor(mathClamp(alpha, 0, 255) + 0.5)
      )
    end
    setupImageMaskEffectParams = function(material, w, h, mask, kind, maskTexture, drawW, drawH, shadowX, shadowY, outerX, outerY, hasShadow, sr, sg, sb, sa, shadowWidth, shadowStrength, shadowFalloff, shadowExtent, hasOuter, orr, og, ob, oa, outerWidth, outerStrength, outerFalloff, outerExtent)
      local packedKind = kind
      local __lux_tmp_442 = mask ~= nil
      if __lux_tmp_442 then
        local __lux_tmp_443 = mask.invert
        if not __lux_tmp_443 then
          __lux_tmp_443 = mask.inverse
        end
        __lux_tmp_442 = __lux_tmp_443
      end
      if __lux_tmp_442 then
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
        local __lux_tmp_444 = mask ~= nil
        if __lux_tmp_444 then
          __lux_tmp_444 = geometry.imageRadius(mask.radius, w, h)
        end
        local __lux_tmp_445 = __lux_tmp_444
        if not __lux_tmp_445 then
          __lux_tmp_445 = 0
        end
        local __lux_tmp_446
        if hasShadow then
          __lux_tmp_446 = shadowExtent
        else
          __lux_tmp_446 = 0
        end
        local __lux_tmp_447
        if hasOuter then
          __lux_tmp_447 = outerExtent
        else
          __lux_tmp_447 = 0
        end
        local __lux_tmp_448
        if hasShadow then
          __lux_tmp_448 = sr
        else
          __lux_tmp_448 = 0
        end
        local __lux_tmp_449
        if hasShadow then
          __lux_tmp_449 = sg
        else
          __lux_tmp_449 = 0
        end
        local __lux_tmp_450
        if hasShadow then
          __lux_tmp_450 = sb
        else
          __lux_tmp_450 = 0
        end
        local __lux_tmp_451
        if hasShadow then
          __lux_tmp_451 = sa
        else
          __lux_tmp_451 = 0
        end
        local __lux_tmp_452
        if hasShadow then
          do
            local __lux_tmp_453 = toNumber(shadowWidth)
            if __lux_tmp_453 == nil then
              __lux_tmp_453 = 18
            end
            __lux_tmp_452 = mathMax(0.001, __lux_tmp_453)
          end
        else
          __lux_tmp_452 = 1
        end
        local __lux_tmp_454
        if hasShadow then
          do
            local __lux_tmp_455 = toNumber(shadowStrength)
            if __lux_tmp_455 == nil then
              __lux_tmp_455 = 1
            end
            __lux_tmp_454 = mathMax(0, __lux_tmp_455)
          end
        else
          __lux_tmp_454 = 0
        end
        setupParamMatrix(
          material,
          drawW,
          drawH,
          w,
          h,
          packedKind,
          __lux_tmp_445,
          __lux_tmp_446,
          __lux_tmp_447,
          __lux_tmp_448,
          __lux_tmp_449,
          __lux_tmp_450,
          __lux_tmp_451,
          shadowX,
          shadowY,
          __lux_tmp_452,
          __lux_tmp_454
        )
      end
      local __lux_tmp_456
      if hasOuter then
        __lux_tmp_456 = orr
      else
        __lux_tmp_456 = 0
      end
      local __lux_tmp_457
      if hasOuter then
        __lux_tmp_457 = og
      else
        __lux_tmp_457 = 0
      end
      local __lux_tmp_458
      if hasOuter then
        __lux_tmp_458 = ob
      else
        __lux_tmp_458 = 0
      end
      local __lux_tmp_459
      if hasOuter then
        __lux_tmp_459 = oa
      else
        __lux_tmp_459 = 0
      end
      local __lux_tmp_460
      if hasOuter then
        do
          local __lux_tmp_461 = toNumber(outerWidth)
          if __lux_tmp_461 == nil then
            __lux_tmp_461 = 18
          end
          __lux_tmp_460 = mathMax(0.001, __lux_tmp_461)
        end
      else
        __lux_tmp_460 = 1
      end
      local __lux_tmp_462
      if hasOuter then
        do
          local __lux_tmp_463 = toNumber(outerStrength)
          if __lux_tmp_463 == nil then
            __lux_tmp_463 = 1
          end
          __lux_tmp_462 = mathMax(0, __lux_tmp_463)
        end
      else
        __lux_tmp_462 = 0
      end
      local __lux_tmp_464
      if hasShadow then
        do
          local __lux_tmp_465 = toNumber(shadowFalloff)
          if __lux_tmp_465 == nil then
            __lux_tmp_465 = 1.8
          end
          __lux_tmp_464 = mathClamp(1 / mathMax(__lux_tmp_465, 0.001), 0.1, 1)
        end
      else
        __lux_tmp_464 = 1
      end
      local __lux_tmp_466
      if hasOuter then
        do
          local __lux_tmp_467 = toNumber(outerFalloff)
          if __lux_tmp_467 == nil then
            __lux_tmp_467 = 1.8
          end
          __lux_tmp_466 = mathClamp(1 / mathMax(__lux_tmp_467, 0.001), 0.1, 1)
        end
      else
        __lux_tmp_466 = 1
      end
      return setupAuxConstants(
        material,
        __lux_tmp_456,
        __lux_tmp_457,
        __lux_tmp_458,
        __lux_tmp_459,
        outerX,
        outerY,
        __lux_tmp_460,
        __lux_tmp_462,
        __lux_tmp_464,
        __lux_tmp_466,
        0,
        0,
        p0,
        p1,
        p2,
        p3
      )
    end
    drawImageMaskShadowOuter = function(x, y, w, h, mask, kind, hasShadow, sr, sg, sb, sa, shadowOffsetX, shadowOffsetY, shadowWidth, shadowExtent, shadowGrow, shadowStrength, shadowFalloff, hasOuter, orr, og, ob, oa, outerOffsetX, outerOffsetY, outerWidth, outerExtent, outerGrow, outerStrength, outerFalloff)
      local __lux_tmp_468 = not hasShadow
      if __lux_tmp_468 then
        __lux_tmp_468 = not hasOuter
      end
      local __lux_tmp_469 = __lux_tmp_468
      if not __lux_tmp_469 then
        __lux_tmp_469 = typeOf(mask) ~= "table"
      end
      local __lux_tmp_470 = __lux_tmp_469
      if not __lux_tmp_470 then
        __lux_tmp_470 = not shadersActive()
      end
      local __lux_tmp_471 = __lux_tmp_470
      if not __lux_tmp_471 then
        __lux_tmp_471 = not materialOK(widgetMaterials.image_mask_shadow_outer)
      end
      if __lux_tmp_471 then
        return false
      end
      do
        local __lux_tmp_472 = kind
        if __lux_tmp_472 == nil then
          __lux_tmp_472 = imageMaskKindValue(mask)
        end
        kind = __lux_tmp_472
      end
      if kind == nil then
        return false
      end
      local maskTexture
      kind, maskTexture = resolveMaskTexture(mask, kind)
      if kind == nil then
        return false
      end
      do
        local __lux_tmp_473 = hasShadow
        if __lux_tmp_473 then
          __lux_tmp_473 = sa > 0
        end
        local __lux_tmp_474 = __lux_tmp_473
        if __lux_tmp_474 then
          __lux_tmp_474 = shadowStrength > 0
        end
        hasShadow = __lux_tmp_474
      end
      do
        local __lux_tmp_475 = hasOuter
        if __lux_tmp_475 then
          __lux_tmp_475 = oa > 0
        end
        local __lux_tmp_476 = __lux_tmp_475
        if __lux_tmp_476 then
          __lux_tmp_476 = outerStrength > 0
        end
        hasOuter = __lux_tmp_476
      end
      local __lux_tmp_477 = not hasShadow
      if __lux_tmp_477 then
        __lux_tmp_477 = not hasOuter
      end
      if __lux_tmp_477 then
        return false
      end
      do
        local __lux_tmp_478 = toNumber(shadowExtent)
        if __lux_tmp_478 == nil then
          __lux_tmp_478 = 0
        end
        shadowExtent = mathMax(0, __lux_tmp_478)
      end
      do
        local __lux_tmp_479 = toNumber(outerExtent)
        if __lux_tmp_479 == nil then
          __lux_tmp_479 = 0
        end
        outerExtent = mathMax(0, __lux_tmp_479)
      end
      local shadowX
      if hasShadow then
        do
          local __lux_tmp_480 = toNumber(shadowOffsetX)
          if __lux_tmp_480 == nil then
            __lux_tmp_480 = 0
          end
          shadowX = x + __lux_tmp_480 - shadowExtent
        end
      else
        shadowX = x
      end
      local shadowY
      if hasShadow then
        do
          local __lux_tmp_481 = toNumber(shadowOffsetY)
          if __lux_tmp_481 == nil then
            __lux_tmp_481 = 0
          end
          shadowY = y + __lux_tmp_481 - shadowExtent
        end
      else
        shadowY = y
      end
      local outerX
      if hasOuter then
        do
          local __lux_tmp_482 = toNumber(outerOffsetX)
          if __lux_tmp_482 == nil then
            __lux_tmp_482 = 0
          end
          outerX = x + __lux_tmp_482 - outerExtent
        end
      else
        outerX = x
      end
      local outerY
      if hasOuter then
        do
          local __lux_tmp_483 = toNumber(outerOffsetY)
          if __lux_tmp_483 == nil then
            __lux_tmp_483 = 0
          end
          outerY = y + __lux_tmp_483 - outerExtent
        end
      else
        outerY = y
      end
      local sx
      do
        local __lux_tmp_484
        if hasShadow then
          __lux_tmp_484 = shadowX
        else
          __lux_tmp_484 = outerX
        end
        local __lux_tmp_485
        if hasOuter then
          __lux_tmp_485 = outerX
        else
          __lux_tmp_485 = shadowX
        end
        sx = mathMin(__lux_tmp_484, __lux_tmp_485)
      end
      local sy
      do
        local __lux_tmp_486
        if hasShadow then
          __lux_tmp_486 = shadowY
        else
          __lux_tmp_486 = outerY
        end
        local __lux_tmp_487
        if hasOuter then
          __lux_tmp_487 = outerY
        else
          __lux_tmp_487 = shadowY
        end
        sy = mathMin(__lux_tmp_486, __lux_tmp_487)
      end
      local ex
      do
        local __lux_tmp_488
        if hasShadow then
          __lux_tmp_488 = shadowX + w + shadowExtent * 2
        else
          __lux_tmp_488 = outerX + w + outerExtent * 2
        end
        local __lux_tmp_489
        if hasOuter then
          __lux_tmp_489 = outerX + w + outerExtent * 2
        else
          __lux_tmp_489 = shadowX + w + shadowExtent * 2
        end
        ex = mathMax(__lux_tmp_488, __lux_tmp_489)
      end
      local ey
      do
        local __lux_tmp_490
        if hasShadow then
          __lux_tmp_490 = shadowY + h + shadowExtent * 2
        else
          __lux_tmp_490 = outerY + h + outerExtent * 2
        end
        local __lux_tmp_491
        if hasOuter then
          __lux_tmp_491 = outerY + h + outerExtent * 2
        else
          __lux_tmp_491 = shadowY + h + shadowExtent * 2
        end
        ey = mathMax(__lux_tmp_490, __lux_tmp_491)
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
      local __lux_tmp_492 = mask ~= nil
      if __lux_tmp_492 then
        local __lux_tmp_493 = mask.invert
        if not __lux_tmp_493 then
          __lux_tmp_493 = mask.inverse
        end
        __lux_tmp_492 = __lux_tmp_493
      end
      if __lux_tmp_492 then
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
      local __lux_tmp_494 = vertical
      if __lux_tmp_494 then
        __lux_tmp_494 = 1
      end
      local __lux_tmp_495 = __lux_tmp_494
      if not __lux_tmp_495 then
        __lux_tmp_495 = 0
      end
      local __lux_tmp_496 = intensity
      if __lux_tmp_496 == nil then
        __lux_tmp_496 = 1
      end
      local __lux_tmp_497 = mask ~= nil
      if __lux_tmp_497 then
        __lux_tmp_497 = geometry.imageRadius(mask.radius, shapeW, shapeH)
      end
      local __lux_tmp_498 = __lux_tmp_497
      if not __lux_tmp_498 then
        __lux_tmp_498 = 0
      end
      return setupParamMatrix(
        material,
        __lux_tmp_495,
        __lux_tmp_496,
        drawW,
        drawH,
        shapeW,
        shapeH,
        packedKind,
        __lux_tmp_498,
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
      local __lux_tmp_499 = spec == nil
      if not __lux_tmp_499 then
        __lux_tmp_499 = typeOf(mask) ~= "table"
      end
      local __lux_tmp_500 = __lux_tmp_499
      if not __lux_tmp_500 then
        __lux_tmp_500 = kind == nil
      end
      if __lux_tmp_500 then
        return nil
      end
      local __lux_tmp_501 = imageMaskUsesTexture(kind)
      if __lux_tmp_501 then
        __lux_tmp_501 = maskTexture == nil
      end
      if __lux_tmp_501 then
        return nil
      end
      local pad
      do
        local __lux_tmp_502 = toNumber(spec.padding)
        if __lux_tmp_502 == nil then
          __lux_tmp_502 = 0
        end
        pad = mathMax(0, __lux_tmp_502)
      end
      local bx = x - pad
      local by = y - pad
      local bw = w + pad * 2
      local bh = h + pad * 2
      local __lux_tmp_503 = spec.blur > 0
      if __lux_tmp_503 then
        __lux_tmp_503 = widgetBlurRT ~= nil
      end
      local __lux_tmp_504 = __lux_tmp_503
      if __lux_tmp_504 then
        __lux_tmp_504 = renderCopyRenderTargetToTexture ~= nil
      end
      local __lux_tmp_505 = __lux_tmp_504
      if __lux_tmp_505 then
        __lux_tmp_505 = materialOK(widgetMaterials.image_mask_backdrop)
      end
      if __lux_tmp_505 then
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
      local __lux_tmp_506 = tint ~= nil
      if __lux_tmp_506 then
        __lux_tmp_506 = materialOK(widgetMaterials.image_mask_backdrop_fill)
      end
      if __lux_tmp_506 then
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
      do
        local __lux_tmp_507 = kind
        if __lux_tmp_507 == nil then
          __lux_tmp_507 = imageMaskKindValue(mask)
        end
        kind = __lux_tmp_507
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
      local background
      do
        local __lux_tmp_508 = drawStyle.fill
        if __lux_tmp_508 == nil then
          __lux_tmp_508 = drawStyle.background
        end
        background = __lux_tmp_508
      end
      local __lux_tmp_509 = background ~= nil
      if __lux_tmp_509 then
        __lux_tmp_509 = background.r ~= nil
      end
      local __lux_tmp_510 = __lux_tmp_509
      if __lux_tmp_510 then
        local __lux_tmp_511 = background.a == nil
        if not __lux_tmp_511 then
          __lux_tmp_511 = background.a > 0
        end
        __lux_tmp_510 = __lux_tmp_511
      end
      if __lux_tmp_510 then
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
      do
        local __lux_tmp_512 = material
        if __lux_tmp_512 == nil then
          __lux_tmp_512 = imageFallbackMaterialForTexture(texture)
        end
        material = __lux_tmp_512
      end
      if material == nil then
        return
      end
      local u0, v0, u1, v1 = geometry.imageUV(drawStyle, texture)
      x, y, w, h, u0, v0, u1, v1 = geometry.imageFitRect(x, y, w, h, texture, drawStyle, u0, v0, u1, v1)
      local __lux_tmp_513 = w <= 0
      if not __lux_tmp_513 then
        __lux_tmp_513 = h <= 0
      end
      if __lux_tmp_513 then
        return
      end
      local radius = geometry.imageRadius(drawStyle.radius, w, h)
      local background
      do
        local __lux_tmp_514 = drawStyle.fill
        if __lux_tmp_514 == nil then
          __lux_tmp_514 = drawStyle.background
        end
        background = __lux_tmp_514
      end
      local __lux_tmp_515 = background ~= nil
      if __lux_tmp_515 then
        local __lux_tmp_516 = background.a
        if __lux_tmp_516 == nil then
          __lux_tmp_516 = 255
        end
        __lux_tmp_515 = __lux_tmp_516 > 0
      end
      if __lux_tmp_515 then
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
      do
        local __lux_tmp_517 = material
        if __lux_tmp_517 == nil then
          __lux_tmp_517 = imageFallbackMaterialForTexture(texture)
        end
        material = __lux_tmp_517
      end
      if material == nil then
        return
      end
      local u0, v0, u1, v1 = 0, 0, 1, 1
      x, y, w, h, u0, v0, u1, v1 = imageFitRectRaw(x, y, w, h, texture, fit, u0, v0, u1, v1)
      local __lux_tmp_518 = w <= 0
      if not __lux_tmp_518 then
        __lux_tmp_518 = h <= 0
      end
      if __lux_tmp_518 then
        return
      end
      surfaceSetMaterial(material)
      style.setDrawColor(imageTintRaw(tint))
      if hasTransform() then
        geometry.drawTexturedQuadUV(x, y, w, h, u0, v0, u1, v1, material)
      else
        if createdMaterialFallback then
          geometry.drawCreatedMaterialTexturedRectUV(x, y, w, h, u0, v0, u1, v1)
        else
          geometry.drawTexturedQuadUV(x, y, w, h, u0, v0, u1, v1, material)
        end
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
      local background
      do
        local __lux_tmp_519 = drawStyle.fill
        if __lux_tmp_519 == nil then
          __lux_tmp_519 = drawStyle.background
        end
        background = __lux_tmp_519
      end
      local __lux_tmp_520 = background ~= nil
      if __lux_tmp_520 then
        local __lux_tmp_521 = background.a
        if __lux_tmp_521 == nil then
          __lux_tmp_521 = 255
        end
        __lux_tmp_520 = __lux_tmp_521 > 0
      end
      if __lux_tmp_520 then
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
      local __lux_match_522 = maskKind
      if __lux_match_522 == 2 or __lux_match_522 == 3 then
        return mathMin(w, h) * 0.5
      elseif __lux_match_522 == 0 then
        local __lux_tmp_523 = mask ~= nil
        if __lux_tmp_523 then
          __lux_tmp_523 = mask.radius ~= nil
        end
        if __lux_tmp_523 then
          return geometry.imageRadius(mask.radius, w, h)
        end
        return geometry.imageRadius(drawStyle.radius, w, h)
      else
        return geometry.imageRadius(drawStyle.radius, w, h)
      end
    end
    imageUsesSourceAlphaEffectMask = function(drawStyle, hasShadow, hasOuter, backdrop)
      if typeOf(drawStyle) ~= "table" then
        return false
      end
      if drawStyle.mask ~= nil then
        return false
      end
      if drawStyle.radius ~= nil then
        return false
      end
      local __lux_tmp_524 = hasShadow
      if not __lux_tmp_524 then
        __lux_tmp_524 = hasOuter
      end
      local __lux_tmp_525 = __lux_tmp_524
      if not __lux_tmp_525 then
        __lux_tmp_525 = backdrop ~= nil
      end
      return __lux_tmp_525
    end
    drawImageRoundRectShader = function(x, y, w, h, texture, u0, v0, u1, v1, drawStyle, radius)
      local material = widgetMaterials.roundrect_texture
      if not materialOK(material) then
        return false
      end
      material:SetTexture("$basetexture", texture)
      local stroke
      do
        local __lux_tmp_526 = drawStyle.stroke
        if __lux_tmp_526 == nil then
          __lux_tmp_526 = transparentColor
        end
        stroke = __lux_tmp_526
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
      local __lux_tmp_527 = not shadersActive()
      if not __lux_tmp_527 then
        __lux_tmp_527 = not materialOK(widgetMaterials.roundrect_texture)
      end
      if __lux_tmp_527 then
        drawImageFallback(x, y, w, h, source, resolved)
        return
      end
      local u0, v0, u1, v1 = geometry.imageUV(resolved, texture)
      x, y, w, h, u0, v0, u1, v1 = geometry.imageFitRect(x, y, w, h, texture, resolved, u0, v0, u1, v1)
      local __lux_tmp_528 = w <= 0
      if not __lux_tmp_528 then
        __lux_tmp_528 = h <= 0
      end
      if __lux_tmp_528 then
        return
      end
      local hasShadow, sr, sg, sb, sa, shadowX, shadowY, shadowWidth, shadowSpreadUnused, shadowGrow, shadowStrength, shadowFalloff, shadowExtent = roundrect.shadowRaw(resolved.shadow)
      local hasOuter, orr, og, ob, oa, outerX, outerY, outerWidth, outerSpreadUnused, outerGrow, outerStrength, outerFalloff, outerExtent = roundrect.outerGlowRaw(resolved.outerGlow)
      local backdrop = style.backdropStyle(resolved.backdrop)
      local mask
      local maskKind
      if imageUsesSourceAlphaEffectMask(resolved, hasShadow, hasOuter, backdrop) then
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
        local backdropMaskKind
        do
          local __lux_tmp_529 = imageMaskTextureChannelKind(mask.channel)
          if __lux_tmp_529 == nil then
            __lux_tmp_529 = maskKind
          end
          backdropMaskKind = __lux_tmp_529
        end
        local __lux_tmp_530 = hasShadow
        if not __lux_tmp_530 then
          __lux_tmp_530 = hasOuter
        end
        if __lux_tmp_530 then
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
      local __lux_tmp_531 = cuts ~= nil
      if __lux_tmp_531 then
        __lux_tmp_531 = drawImageChamfer(x, y, w, h, texture, u0, v0, u1, v1, resolved, cuts)
      end
      if __lux_tmp_531 then
        return
      end
      local radius = imageRoundedRadius(resolved, mask, maskKind, w, h)
      local __lux_tmp_532 = resolved.shadow ~= nil
      if not __lux_tmp_532 then
        __lux_tmp_532 = resolved.outerGlow ~= nil
      end
      if __lux_tmp_532 then
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
      local background
      do
        local __lux_tmp_533 = resolved.fill
        if __lux_tmp_533 == nil then
          __lux_tmp_533 = resolved.background
        end
        background = __lux_tmp_533
      end
      local __lux_tmp_534 = background ~= nil
      if __lux_tmp_534 then
        local __lux_tmp_535 = background.a
        if __lux_tmp_535 == nil then
          __lux_tmp_535 = 255
        end
        __lux_tmp_534 = __lux_tmp_535 > 0
      end
      if __lux_tmp_534 then
        drawRoundImageEffect(x, y, w, h, radius, background)
      end
      return drawImageRoundRectShader(x, y, w, h, texture, u0, v0, u1, v1, resolved, radius)
    end
    imageRaw = function(x, y, w, h, source, radius, tint, fit)
      local texture = imageTextureSource(source)
      if texture == nil then
        return
      end
      local __lux_tmp_536 = not shadersActive()
      if not __lux_tmp_536 then
        __lux_tmp_536 = not materialOK(widgetMaterials.roundrect_texture)
      end
      if __lux_tmp_536 then
        drawImageRawFallback(x, y, w, h, source, radius, tint, fit)
        return
      end
      local u0, v0, u1, v1 = 0, 0, 1, 1
      x, y, w, h, u0, v0, u1, v1 = imageFitRectRaw(x, y, w, h, texture, fit, u0, v0, u1, v1)
      local __lux_tmp_537 = w <= 0
      if not __lux_tmp_537 then
        __lux_tmp_537 = h <= 0
      end
      if __lux_tmp_537 then
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
      local __lux_tmp_538 = resolved.fit == nil
      if __lux_tmp_538 then
        __lux_tmp_538 = resolved.objectFit == nil
      end
      if __lux_tmp_538 then
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
