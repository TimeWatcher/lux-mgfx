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
    local __lux_import_1 = __lux_import("lux/mgfx/frame#client")
    local frameImport = __lux_import_1
    local __lux_import_2 = __lux_import("lux/mgfx/geometry#client")
    local geometryImport = __lux_import_2
    local __lux_import_3 = __lux_import("lux/mgfx/paint#client")
    local paintImport = __lux_import_3
    local __lux_import_4 = __lux_import("lux/mgfx/primitives#client")
    local primitivesImport = __lux_import_4
    local __lux_import_5 = __lux_import("lux/mgfx/roundrect#client")
    local roundrectImport = __lux_import_5
    local __lux_import_6 = __lux_import("lux/mgfx/style#client")
    local styleImport = __lux_import_6
    local __lux_import_7 = __lux_import("lux/mgfx/text#client")
    local textImport = __lux_import_7
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
      local __lux_obj_8 = render
      local __lux_val_9 = nil
      if __lux_obj_8 ~= nil then
        __lux_val_9 = __lux_obj_8.CopyRenderTargetToTexture
      end
      renderCopyRenderTargetToTexture = __lux_val_9
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
      local __lux_tmp_10
      if matrixCtor ~= nil then
        __lux_tmp_10 = matrixCtor()
      else
        __lux_tmp_10 = nil
      end
      paramMatrixProbe = __lux_tmp_10
    end
    do
      local __lux_obj_11 = paramMatrixProbe
      local __lux_val_12 = nil
      if __lux_obj_11 ~= nil then
        __lux_val_12 = __lux_obj_11.SetUnpacked
      end
      paramMatrixSetUnpacked = __lux_val_12
    end
    paramMatrices = {}
    auxParamMatrices = {}
    widgetMaterials = {}
    widgetBlurRT = nil
    widgetMatOK = function(material)
      local __lux_tmp_13 = material ~= nil
      if __lux_tmp_13 then
        __lux_tmp_13 = material.IsError ~= nil
      end
      local __lux_tmp_14 = __lux_tmp_13
      if __lux_tmp_14 then
        __lux_tmp_14 = not material:IsError()
      end
      return __lux_tmp_14
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
      do
        local __lux_tmp_15 = owner
        if __lux_tmp_15 == nil then
          __lux_tmp_15 = {}
        end
        owner = __lux_tmp_15
      end
      local materialState
      do
        local __lux_tmp_16 = owner._MaterialState
        if __lux_tmp_16 == nil then
          __lux_tmp_16 = {}
        end
        materialState = __lux_tmp_16
      end
      do
        local __lux_tmp_17 = owner._Materials
        if __lux_tmp_17 == nil then
          local __lux_tmp_18 = materialState.materials
          if __lux_tmp_18 == nil then
            local __lux_tmp_19 = widgetMaterials
            if __lux_tmp_19 == nil then
              __lux_tmp_19 = {}
            end
            __lux_tmp_18 = __lux_tmp_19
          end
          __lux_tmp_17 = __lux_tmp_18
        end
        widgetMaterials = __lux_tmp_17
      end
      do
        local __lux_tmp_20 = owner._BlurRT
        if __lux_tmp_20 == nil then
          local __lux_tmp_21 = materialState.blurRT
          if __lux_tmp_21 == nil then
            __lux_tmp_21 = widgetBlurRT
          end
          __lux_tmp_20 = __lux_tmp_21
        end
        widgetBlurRT = __lux_tmp_20
      end
      do
        local __lux_tmp_22 = owner.MaterialOK
        if __lux_tmp_22 == nil then
          local __lux_tmp_23 = materialState.matOK
          if __lux_tmp_23 == nil then
            __lux_tmp_23 = widgetMatOK
          end
          __lux_tmp_22 = __lux_tmp_23
        end
        widgetMatOK = __lux_tmp_22
      end
      do
        local __lux_tmp_24 = owner.hasShaders
        if __lux_tmp_24 == nil then
          __lux_tmp_24 = widgetHasShaders
        end
        widgetHasShaders = __lux_tmp_24
      end
      return true
    end
    materialOK = function(material)
      local __lux_tmp_25 = widgetMatOK ~= nil
      if __lux_tmp_25 then
        __lux_tmp_25 = widgetMatOK(material)
      end
      return __lux_tmp_25
    end
    shadersActive = function()
      local __lux_tmp_26 = forceFallbackCvar == nil
      if __lux_tmp_26 then
        __lux_tmp_26 = getConVar ~= nil
      end
      if __lux_tmp_26 then
        do
          local __lux_tmp_27 = getConVar("mgfx_force_fallback")
          if __lux_tmp_27 == nil then
            __lux_tmp_27 = false
          end
          forceFallbackCvar = __lux_tmp_27
        end
      end
      local __lux_tmp_28 = forceFallbackCvar ~= nil
      if __lux_tmp_28 then
        __lux_tmp_28 = forceFallbackCvar ~= false
      end
      local __lux_tmp_29 = __lux_tmp_28
      if __lux_tmp_29 then
        __lux_tmp_29 = forceFallbackCvar:GetBool()
      end
      if __lux_tmp_29 then
        return false
      end
      local __lux_tmp_30 = widgetHasShaders ~= nil
      if __lux_tmp_30 then
        __lux_tmp_30 = widgetHasShaders()
      end
      return __lux_tmp_30
    end
    setupParamMatrix = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3)
      local __lux_tmp_31 = material == nil
      if not __lux_tmp_31 then
        __lux_tmp_31 = paramMatrixSetUnpacked == nil
      end
      local __lux_tmp_32 = __lux_tmp_31
      if not __lux_tmp_32 then
        __lux_tmp_32 = matrixCtor == nil
      end
      if __lux_tmp_32 then
        return false
      end
      local matrix = paramMatrices[material]
      if matrix == nil then
        matrix = matrixCtor()
        paramMatrices[material] = matrix
      end
      do
        local __lux_tmp_33 = a0
        if __lux_tmp_33 == nil then
          __lux_tmp_33 = 0
        end
        local __lux_tmp_34 = b0
        if __lux_tmp_34 == nil then
          __lux_tmp_34 = 0
        end
        local __lux_tmp_35 = c0
        if __lux_tmp_35 == nil then
          __lux_tmp_35 = 0
        end
        local __lux_tmp_36 = d0
        if __lux_tmp_36 == nil then
          __lux_tmp_36 = 0
        end
        local __lux_tmp_37 = a1
        if __lux_tmp_37 == nil then
          __lux_tmp_37 = 0
        end
        local __lux_tmp_38 = b1
        if __lux_tmp_38 == nil then
          __lux_tmp_38 = 0
        end
        local __lux_tmp_39 = c1
        if __lux_tmp_39 == nil then
          __lux_tmp_39 = 0
        end
        local __lux_tmp_40 = d1
        if __lux_tmp_40 == nil then
          __lux_tmp_40 = 0
        end
        local __lux_tmp_41 = a2
        if __lux_tmp_41 == nil then
          __lux_tmp_41 = 0
        end
        local __lux_tmp_42 = b2
        if __lux_tmp_42 == nil then
          __lux_tmp_42 = 0
        end
        local __lux_tmp_43 = c2
        if __lux_tmp_43 == nil then
          __lux_tmp_43 = 0
        end
        local __lux_tmp_44 = d2
        if __lux_tmp_44 == nil then
          __lux_tmp_44 = 0
        end
        local __lux_tmp_45 = a3
        if __lux_tmp_45 == nil then
          __lux_tmp_45 = 0
        end
        local __lux_tmp_46 = b3
        if __lux_tmp_46 == nil then
          __lux_tmp_46 = 0
        end
        local __lux_tmp_47 = c3
        if __lux_tmp_47 == nil then
          __lux_tmp_47 = 0
        end
        local __lux_tmp_48 = d3
        if __lux_tmp_48 == nil then
          __lux_tmp_48 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
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
          __lux_tmp_47,
          __lux_tmp_48
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
      local __lux_tmp_49 = material == nil
      if not __lux_tmp_49 then
        __lux_tmp_49 = paramMatrixSetUnpacked == nil
      end
      local __lux_tmp_50 = __lux_tmp_49
      if not __lux_tmp_50 then
        __lux_tmp_50 = matrixCtor == nil
      end
      if __lux_tmp_50 then
        return false
      end
      local matrix = auxParamMatrices[material]
      if matrix == nil then
        matrix = matrixCtor()
        auxParamMatrices[material] = matrix
      end
      do
        local __lux_tmp_51 = a0
        if __lux_tmp_51 == nil then
          __lux_tmp_51 = 0
        end
        local __lux_tmp_52 = b0
        if __lux_tmp_52 == nil then
          __lux_tmp_52 = 0
        end
        local __lux_tmp_53 = c0
        if __lux_tmp_53 == nil then
          __lux_tmp_53 = 0
        end
        local __lux_tmp_54 = d0
        if __lux_tmp_54 == nil then
          __lux_tmp_54 = 0
        end
        local __lux_tmp_55 = a1
        if __lux_tmp_55 == nil then
          __lux_tmp_55 = 0
        end
        local __lux_tmp_56 = b1
        if __lux_tmp_56 == nil then
          __lux_tmp_56 = 0
        end
        local __lux_tmp_57 = c1
        if __lux_tmp_57 == nil then
          __lux_tmp_57 = 0
        end
        local __lux_tmp_58 = d1
        if __lux_tmp_58 == nil then
          __lux_tmp_58 = 0
        end
        local __lux_tmp_59 = a2
        if __lux_tmp_59 == nil then
          __lux_tmp_59 = 0
        end
        local __lux_tmp_60 = b2
        if __lux_tmp_60 == nil then
          __lux_tmp_60 = 0
        end
        local __lux_tmp_61 = c2
        if __lux_tmp_61 == nil then
          __lux_tmp_61 = 0
        end
        local __lux_tmp_62 = d2
        if __lux_tmp_62 == nil then
          __lux_tmp_62 = 0
        end
        local __lux_tmp_63 = a3
        if __lux_tmp_63 == nil then
          __lux_tmp_63 = 0
        end
        local __lux_tmp_64 = b3
        if __lux_tmp_64 == nil then
          __lux_tmp_64 = 0
        end
        local __lux_tmp_65 = c3
        if __lux_tmp_65 == nil then
          __lux_tmp_65 = 0
        end
        local __lux_tmp_66 = d3
        if __lux_tmp_66 == nil then
          __lux_tmp_66 = 0
        end
        paramMatrixSetUnpacked(
          matrix,
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
          __lux_tmp_65,
          __lux_tmp_66
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
      local fx
      do
        local __lux_tmp_67 = typeOf(drawStyle.fx) == "table"
        if __lux_tmp_67 then
          __lux_tmp_67 = drawStyle.fx
        end
        local __lux_tmp_68 = __lux_tmp_67
        if not __lux_tmp_68 then
          __lux_tmp_68 = nil
        end
        fx = __lux_tmp_68
      end
      if fx == nil then
        return false, false, false, 0
      end
      local glow
      do
        local __lux_tmp_69 = fx.glow == true
        if not __lux_tmp_69 then
          __lux_tmp_69 = typeOf(fx.glow) == "table"
        end
        glow = __lux_tmp_69
      end
      local sheen
      do
        local __lux_tmp_70 = fx.sheen == true
        if not __lux_tmp_70 then
          __lux_tmp_70 = typeOf(fx.sheen) == "table"
        end
        sheen = __lux_tmp_70
      end
      local marker
      do
        local __lux_tmp_71 = fx.marker == true
        if not __lux_tmp_71 then
          __lux_tmp_71 = typeOf(fx.marker) == "table"
        end
        marker = __lux_tmp_71
      end
      local ticks = 0
      local tickSpec = fx.ticks
      if typeOf(tickSpec) == "number" then
        ticks = tickSpec
      else
        if typeOf(tickSpec) == "table" then
          do
            local __lux_tmp_72 = tickSpec.count
            if __lux_tmp_72 == nil then
              __lux_tmp_72 = 0
            end
            ticks = __lux_tmp_72
          end
        end
      end
      local __lux_tmp_73 = toNumber(ticks)
      if __lux_tmp_73 == nil then
        __lux_tmp_73 = 0
      end
      return glow, sheen, marker, mathClamp(mathFloor(__lux_tmp_73), 0, 31)
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
      local fx
      do
        local __lux_tmp_74 = typeOf(drawStyle.fx) == "table"
        if __lux_tmp_74 then
          __lux_tmp_74 = drawStyle.fx
        end
        local __lux_tmp_75 = __lux_tmp_74
        if not __lux_tmp_75 then
          __lux_tmp_75 = nil
        end
        fx = __lux_tmp_75
      end
      if fx == nil then
        return 0, 0
      end
      local flags = 0
      local __lux_tmp_76 = fx.glow == true
      if not __lux_tmp_76 then
        __lux_tmp_76 = typeOf(fx.glow) == "table"
      end
      if __lux_tmp_76 then
        flags = flags + 1
      end
      local __lux_tmp_77 = fx.sheen == true
      if not __lux_tmp_77 then
        __lux_tmp_77 = typeOf(fx.sheen) == "table"
      end
      if __lux_tmp_77 then
        flags = flags + 2
      end
      local __lux_tmp_78 = fx.marker == true
      if not __lux_tmp_78 then
        __lux_tmp_78 = typeOf(fx.marker) == "table"
      end
      if __lux_tmp_78 then
        flags = flags + 4
      end
      local ticks = 0
      local tickSpec = fx.ticks
      if typeOf(tickSpec) == "number" then
        ticks = tickSpec
      else
        if typeOf(tickSpec) == "table" then
          do
            local __lux_tmp_79 = tickSpec.count
            if __lux_tmp_79 == nil then
              __lux_tmp_79 = 0
            end
            ticks = __lux_tmp_79
          end
        end
      end
      local __lux_tmp_80 = toNumber(ticks)
      if __lux_tmp_80 == nil then
        __lux_tmp_80 = 0
      end
      return flags, mathClamp(mathFloor(__lux_tmp_80), 0, 31)
    end
    progressFillCanFast = function(fill)
      local __lux_match_81 = fill
      local __lux_tag_82
      if __lux_match_81 ~= nil then
        __lux_tag_82 = __lux_match_81.kind
      end
      if __lux_tag_82 == style.FILL_SOLID then
        return true
      elseif __lux_tag_82 == style.FILL_LINEAR then
        local x1 = __lux_match_81.x1
        local y1 = __lux_match_81.y1
        local x2 = __lux_match_81.x2
        local y2 = __lux_match_81.y2
        local __lux_tmp_83 = x1
        if __lux_tmp_83 == nil then
          __lux_tmp_83 = 0
        end
        local __lux_tmp_84 = __lux_tmp_83 == 0
        if __lux_tmp_84 then
          local __lux_tmp_85 = y1
          if __lux_tmp_85 == nil then
            __lux_tmp_85 = 0
          end
          __lux_tmp_84 = __lux_tmp_85 == 0
        end
        local __lux_tmp_86 = __lux_tmp_84
        if __lux_tmp_86 then
          local __lux_tmp_87 = x2
          if __lux_tmp_87 == nil then
            __lux_tmp_87 = 1
          end
          __lux_tmp_86 = __lux_tmp_87 == 1
        end
        local __lux_tmp_88 = __lux_tmp_86
        if __lux_tmp_88 then
          local __lux_tmp_89 = y2
          if __lux_tmp_89 == nil then
            __lux_tmp_89 = 0
          end
          __lux_tmp_88 = __lux_tmp_89 == 0
        end
        return __lux_tmp_88
      else
        return false
      end
    end
    canDrawProgressFast = function(fill, drawStyle, inset, strokeWidth, flags, ticks, fxMat)
      local __lux_tmp_90 = not shadersActive()
      if not __lux_tmp_90 then
        __lux_tmp_90 = not materialOK(fxMat)
      end
      if __lux_tmp_90 then
        return false
      end
      local __lux_tmp_91 = drawStyle.shadow ~= nil
      if not __lux_tmp_91 then
        __lux_tmp_91 = drawStyle.backdrop ~= nil
      end
      local __lux_tmp_92 = __lux_tmp_91
      if not __lux_tmp_92 then
        __lux_tmp_92 = drawStyle.outerGlow ~= nil
      end
      local __lux_tmp_93 = __lux_tmp_92
      if not __lux_tmp_93 then
        __lux_tmp_93 = drawStyle.innerGlow ~= nil
      end
      local __lux_tmp_94 = __lux_tmp_93
      if not __lux_tmp_94 then
        __lux_tmp_94 = drawStyle.pattern ~= nil
      end
      local __lux_tmp_95 = __lux_tmp_94
      if not __lux_tmp_95 then
        __lux_tmp_95 = drawStyle.fillPattern ~= nil
      end
      local __lux_tmp_96 = __lux_tmp_95
      if not __lux_tmp_96 then
        __lux_tmp_96 = drawStyle.trackPattern ~= nil
      end
      if __lux_tmp_96 then
        return false
      end
      local __lux_tmp_97 = inset ~= mathFloor(inset)
      if not __lux_tmp_97 then
        __lux_tmp_97 = strokeWidth ~= mathFloor(strokeWidth)
      end
      if __lux_tmp_97 then
        return false
      end
      local __lux_tmp_98 = inset < 0
      if not __lux_tmp_98 then
        __lux_tmp_98 = inset > 31
      end
      local __lux_tmp_99 = __lux_tmp_98
      if not __lux_tmp_99 then
        __lux_tmp_99 = strokeWidth < 0
      end
      local __lux_tmp_100 = __lux_tmp_99
      if not __lux_tmp_100 then
        __lux_tmp_100 = strokeWidth > 15
      end
      if __lux_tmp_100 then
        return false
      end
      if not progressFillCanFast(fill) then
        return false
      end
      local __lux_tmp_101 = fxMat == widgetMaterials.progress
      if __lux_tmp_101 then
        local __lux_tmp_102 = flags ~= 0
        if not __lux_tmp_102 then
          __lux_tmp_102 = ticks > 1
        end
        __lux_tmp_101 = __lux_tmp_102
      end
      if __lux_tmp_101 then
        return false
      end
      return true
    end
    setupProgressConstants = function(material, w, h, value, radius, inset, track, fill, stroke, strokeWidth)
      local fillA
      do
        local __lux_tmp_103 = fill.colorA
        if __lux_tmp_103 == nil then
          __lux_tmp_103 = color_white
        end
        fillA = __lux_tmp_103
      end
      local fillB
      do
        local __lux_tmp_104 = fill.colorB
        if __lux_tmp_104 == nil then
          __lux_tmp_104 = fillA
        end
        fillB = __lux_tmp_104
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
        local __lux_tmp_105 = stroke
        if __lux_tmp_105 == nil then
          __lux_tmp_105 = transparentColor
        end
        r, g, b, a = style.color01(__lux_tmp_105)
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
        local __lux_tmp_106 = fill.colorA
        if __lux_tmp_106 == nil then
          __lux_tmp_106 = color_white
        end
        fillA = __lux_tmp_106
      end
      local fillB
      do
        local __lux_tmp_107 = fill.colorB
        if __lux_tmp_107 == nil then
          __lux_tmp_107 = fillA
        end
        fillB = __lux_tmp_107
      end
      do
        local __lux_tmp_108 = toNumber(flags)
        if __lux_tmp_108 == nil then
          __lux_tmp_108 = 0
        end
        flags = mathClamp(mathFloor(__lux_tmp_108), 0, 7)
      end
      do
        local __lux_tmp_109 = toNumber(ticks)
        if __lux_tmp_109 == nil then
          __lux_tmp_109 = 0
        end
        ticks = mathClamp(mathFloor(__lux_tmp_109), 0, 31)
      end
      do
        local __lux_tmp_110 = toNumber(radius)
        if __lux_tmp_110 == nil then
          __lux_tmp_110 = 0
        end
        radius = mathClamp(__lux_tmp_110, 0, 255)
      end
      do
        local __lux_tmp_111 = toNumber(inset)
        if __lux_tmp_111 == nil then
          __lux_tmp_111 = 0
        end
        inset = mathClamp(mathFloor(__lux_tmp_111), 0, 31)
      end
      do
        local __lux_tmp_112 = toNumber(strokeWidth)
        if __lux_tmp_112 == nil then
          __lux_tmp_112 = 0
        end
        strokeWidth = mathClamp(mathFloor(__lux_tmp_112), 0, 15)
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
        local __lux_tmp_113 = stroke
        if __lux_tmp_113 == nil then
          __lux_tmp_113 = transparentColor
        end
        r, g, b, a = style.color01(__lux_tmp_113)
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
      do
        local __lux_tmp_114 = flags ~= 0
        if not __lux_tmp_114 then
          __lux_tmp_114 = ticks > 1
        end
        if __lux_tmp_114 then
          material = widgetMaterials.progress_fx
        else
          material = widgetMaterials.progress
        end
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
      do
        local __lux_tmp_115 = colorA.a == nil
        if not __lux_tmp_115 then
          __lux_tmp_115 = colorA.a > 0
        end
        local __lux_tmp_116 = __lux_tmp_115
        if not __lux_tmp_116 then
          local __lux_tmp_117 = colorB.a == nil
          if not __lux_tmp_117 then
            __lux_tmp_117 = colorB.a > 0
          end
          __lux_tmp_116 = __lux_tmp_117
        end
        fill._mgfxFillVisible = __lux_tmp_116
      end
      fill._mgfxLutCacheSafe = false
      return fill
    end
    segmentFillEndpoints = function(fill)
      local __lux_tmp_118 = fill.stops ~= nil
      if __lux_tmp_118 then
        __lux_tmp_118 = #fill.stops > 0
      end
      if __lux_tmp_118 then
        local first = nil
        local last = nil
        for _, stop in ipairs(fill.stops) do
          local color
          do
            local __lux_tmp_119 = stop.color
            if __lux_tmp_119 == nil then
              __lux_tmp_119 = stop[2]
            end
            color = __lux_tmp_119
          end
          local __lux_tmp_120 = color ~= nil
          if __lux_tmp_120 then
            local __lux_tmp_121 = color.a == nil
            if not __lux_tmp_121 then
              __lux_tmp_121 = color.a > 0
            end
            __lux_tmp_120 = __lux_tmp_121
          end
          if __lux_tmp_120 then
            do
              local __lux_tmp_122 = first
              if __lux_tmp_122 == nil then
                __lux_tmp_122 = color
              end
              first = __lux_tmp_122
            end
            last = color
          end
        end
        local __lux_tmp_123 = first ~= nil
        if __lux_tmp_123 then
          __lux_tmp_123 = last ~= nil
        end
        if __lux_tmp_123 then
          return first, last
        end
      end
      local __lux_tmp_124 = fill.colorA
      if __lux_tmp_124 == nil then
        __lux_tmp_124 = color_white
      end
      local __lux_tmp_125 = fill.colorB
      if __lux_tmp_125 == nil then
        local __lux_tmp_126 = fill.colorA
        if __lux_tmp_126 == nil then
          __lux_tmp_126 = color_white
        end
        __lux_tmp_125 = __lux_tmp_126
      end
      return __lux_tmp_124, __lux_tmp_125
    end
    drawSegmentBarShader = function(x, y, w, h, value, drawStyle, count, gap, fill, track)
      local __lux_tmp_127 = not shadersActive()
      if not __lux_tmp_127 then
        __lux_tmp_127 = not materialOK(widgetMaterials.segmentbar)
      end
      if __lux_tmp_127 then
        return false
      end
      if drawStyle.background ~= nil then
        return false
      end
      if style.strokeVisible(drawStyle.stroke, drawStyle.strokeWidth) then
        return false
      end
      local __lux_tmp_128 = drawStyle.shadow ~= nil
      if not __lux_tmp_128 then
        __lux_tmp_128 = drawStyle.backdrop ~= nil
      end
      local __lux_tmp_129 = __lux_tmp_128
      if not __lux_tmp_129 then
        __lux_tmp_129 = drawStyle.outerGlow ~= nil
      end
      local __lux_tmp_130 = __lux_tmp_129
      if not __lux_tmp_130 then
        __lux_tmp_130 = drawStyle.innerGlow ~= nil
      end
      local __lux_tmp_131 = __lux_tmp_130
      if not __lux_tmp_131 then
        __lux_tmp_131 = drawStyle.pattern ~= nil
      end
      local __lux_tmp_132 = __lux_tmp_131
      if not __lux_tmp_132 then
        __lux_tmp_132 = drawStyle.fillPattern ~= nil
      end
      local __lux_tmp_133 = __lux_tmp_132
      if not __lux_tmp_133 then
        __lux_tmp_133 = drawStyle.trackPattern ~= nil
      end
      if __lux_tmp_133 then
        return false
      end
      local totalGap = gap * (count - 1)
      local segmentW = (w - totalGap) / count
      local __lux_tmp_134 = segmentW <= 0
      if not __lux_tmp_134 then
        __lux_tmp_134 = h <= 0
      end
      if __lux_tmp_134 then
        return true
      end
      local trackColor = style.asColor(track, defaultSegmentTrack)
      local fillA, fillB = segmentFillEndpoints(fill)
      local hasFill = style.fillVisible(fill)
      local hasTrack
      do
        local __lux_tmp_135 = trackColor.a == nil
        if not __lux_tmp_135 then
          __lux_tmp_135 = trackColor.a > 0
        end
        hasTrack = __lux_tmp_135
      end
      local __lux_tmp_136 = not hasFill
      if __lux_tmp_136 then
        __lux_tmp_136 = not hasTrack
      end
      if __lux_tmp_136 then
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
        local __lux_tmp_137 = toNumber(value)
        if __lux_tmp_137 == nil then
          __lux_tmp_137 = 0
        end
        local __lux_tmp_138
        if drawStyle.radius == nil then
          __lux_tmp_138 = mathMin(2, h * 0.35)
        else
          __lux_tmp_138 = drawStyle.radius
        end
        local __lux_tmp_139 = toNumber(__lux_tmp_138)
        if __lux_tmp_139 == nil then
          __lux_tmp_139 = 0
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
          mathClamp(__lux_tmp_137, 0, 1),
          mathMax(0, __lux_tmp_139),
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
      local resolved
      do
        local __lux_tmp_140 = drawStyle
        if __lux_tmp_140 == nil then
          __lux_tmp_140 = {}
        end
        resolved = __lux_tmp_140
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
        local __lux_tmp_141 = toNumber(value)
        if __lux_tmp_141 == nil then
          __lux_tmp_141 = 0
        end
        frac = mathClamp(__lux_tmp_141, 0, 1)
      end
      local radius
      do
        local __lux_tmp_142 = stripped.radius
        if __lux_tmp_142 == nil then
          __lux_tmp_142 = mathMin(4, h * 0.5)
        end
        radius = __lux_tmp_142
      end
      local inset
      do
        local __lux_tmp_143 = toNumber(stripped.padding)
        if __lux_tmp_143 == nil then
          __lux_tmp_143 = 0
        end
        inset = mathMax(0, __lux_tmp_143)
      end
      local track
      do
        local __lux_tmp_144 = stripped.track
        if __lux_tmp_144 == nil then
          __lux_tmp_144 = defaultProgressTrack
        end
        track = __lux_tmp_144
      end
      local fill
      do
        local __lux_tmp_145 = stripped.fill
        if __lux_tmp_145 == nil then
          __lux_tmp_145 = color_white
        end
        fill = __lux_tmp_145
      end
      local stroke
      do
        local __lux_tmp_146 = stripped.stroke
        if __lux_tmp_146 == nil then
          __lux_tmp_146 = defaultProgressStroke
        end
        stroke = __lux_tmp_146
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
        local __lux_tmp_147 = track.r
        if __lux_tmp_147 == nil then
          __lux_tmp_147 = 0
        end
        progressTrackDarkColor.r = mathFloor(__lux_tmp_147 * 0.65)
      end
      do
        local __lux_tmp_148 = track.g
        if __lux_tmp_148 == nil then
          __lux_tmp_148 = 0
        end
        progressTrackDarkColor.g = mathFloor(__lux_tmp_148 * 0.65)
      end
      do
        local __lux_tmp_149 = track.b
        if __lux_tmp_149 == nil then
          __lux_tmp_149 = 0
        end
        progressTrackDarkColor.b = mathFloor(__lux_tmp_149 * 0.65)
      end
      do
        local __lux_tmp_150 = track.a
        if __lux_tmp_150 == nil then
          __lux_tmp_150 = 190
        end
        progressTrackDarkColor.a = __lux_tmp_150
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
      local __lux_tmp_151 = innerH <= 0
      if not __lux_tmp_151 then
        __lux_tmp_151 = innerW <= 0
      end
      if __lux_tmp_151 then
        return
      end
      local __lux_tmp_152 = glow
      if __lux_tmp_152 then
        __lux_tmp_152 = innerW > 4
      end
      if __lux_tmp_152 then
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
        local __lux_tmp_153 = stripped.fillPattern
        if __lux_tmp_153 == nil then
          __lux_tmp_153 = stripped.pattern
        end
        progressFillStyle.pattern = __lux_tmp_153
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
      local __lux_tmp_154 = sheen
      if __lux_tmp_154 then
        __lux_tmp_154 = innerW > 8
      end
      if __lux_tmp_154 then
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
      local __lux_tmp_155 = marker
      if __lux_tmp_155 then
        __lux_tmp_155 = innerW > 5
      end
      if __lux_tmp_155 then
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
      local resolved
      do
        local __lux_tmp_156 = drawStyle
        if __lux_tmp_156 == nil then
          __lux_tmp_156 = {}
        end
        resolved = __lux_tmp_156
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
        local __lux_tmp_157 = toNumber(stripped.segments)
        if __lux_tmp_157 == nil then
          __lux_tmp_157 = 10
        end
        count = mathClamp(mathFloor(__lux_tmp_157), 1, 128)
      end
      local gap
      do
        local __lux_tmp_158 = toNumber(stripped.gap)
        if __lux_tmp_158 == nil then
          __lux_tmp_158 = 2
        end
        gap = mathMax(0, __lux_tmp_158)
      end
      local frac
      do
        local __lux_tmp_159 = toNumber(value)
        if __lux_tmp_159 == nil then
          __lux_tmp_159 = 0
        end
        frac = mathClamp(__lux_tmp_159, 0, 1)
      end
      local active = mathFloor(frac * count + 0.0001)
      local fill
      do
        local __lux_tmp_160 = stripped.fill
        if __lux_tmp_160 == nil then
          local __lux_tmp_161 = stripped.color
          if __lux_tmp_161 == nil then
            __lux_tmp_161 = defaultSegmentFill
          end
          __lux_tmp_160 = __lux_tmp_161
        end
        fill = style.fillFromStyle(__lux_tmp_160)
      end
      local track
      do
        local __lux_tmp_162 = stripped.track
        if __lux_tmp_162 == nil then
          __lux_tmp_162 = defaultSegmentTrack
        end
        track = __lux_tmp_162
      end
      if drawSegmentBarShader(x, y, w, h, frac, stripped, count, gap, fill, track) then
        return
      end
      local totalGap = gap * (count - 1)
      local segmentW = (w - totalGap) / count
      local __lux_tmp_163 = segmentW <= 0
      if not __lux_tmp_163 then
        __lux_tmp_163 = h <= 0
      end
      if __lux_tmp_163 then
        return
      end
      local containerRadius
      do
        local __lux_tmp_164 = stripped.backgroundRadius
        if __lux_tmp_164 == nil then
          local __lux_tmp_165 = stripped.radius
          if __lux_tmp_165 == nil then
            __lux_tmp_165 = mathMin(3, h * 0.5)
          end
          __lux_tmp_164 = __lux_tmp_165
        end
        containerRadius = __lux_tmp_164
      end
      local __lux_tmp_166 = stripped.shadow ~= nil
      if not __lux_tmp_166 then
        __lux_tmp_166 = stripped.outerGlow ~= nil
      end
      local __lux_tmp_167 = __lux_tmp_166
      if not __lux_tmp_167 then
        __lux_tmp_167 = stripped.innerGlow ~= nil
      end
      local __lux_tmp_168 = __lux_tmp_167
      if not __lux_tmp_168 then
        __lux_tmp_168 = stripped.backdrop ~= nil
      end
      local __lux_tmp_169 = __lux_tmp_168
      if not __lux_tmp_169 then
        __lux_tmp_169 = stripped.background ~= nil
      end
      if __lux_tmp_169 then
        segmentContainerStyle.radius = containerRadius
        do
          local __lux_tmp_170 = stripped.background
          if __lux_tmp_170 == nil then
            __lux_tmp_170 = transparentColor
          end
          segmentContainerStyle.fill = __lux_tmp_170
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
        local __lux_tmp_171
        if stripped.radius == nil then
          __lux_tmp_171 = mathMin(2, h * 0.35)
        else
          __lux_tmp_171 = stripped.radius
        end
        segmentItemStyle.radius = __lux_tmp_171
      end
      segmentItemStyle.stroke = stripped.stroke
      do
        local __lux_tmp_172 = stripped.strokeWidth
        if __lux_tmp_172 == nil then
          __lux_tmp_172 = 0
        end
        segmentItemStyle.strokeWidth = __lux_tmp_172
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
          do
            local __lux_tmp_173 = stripped.fillPattern
            if __lux_tmp_173 == nil then
              __lux_tmp_173 = stripped.pattern
            end
            pattern = __lux_tmp_173
          end
        else
          pattern = stripped.trackPattern
        end
        local __lux_tmp_174 = color ~= nil
        if not __lux_tmp_174 then
          __lux_tmp_174 = pattern ~= nil
        end
        if __lux_tmp_174 then
          do
            local __lux_tmp_175 = color
            if __lux_tmp_175 == nil then
              __lux_tmp_175 = transparentColor
            end
            segmentItemStyle.fill = __lux_tmp_175
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
        local __lux_tmp_176 = endDeg
        if __lux_tmp_176 == nil then
          __lux_tmp_176 = 360
        end
        local __lux_tmp_177 = startDeg
        if __lux_tmp_177 == nil then
          __lux_tmp_177 = 0
        end
        sweep = mathAbs(__lux_tmp_176 - __lux_tmp_177)
      end
      return mathClamp(mathFloor(sweep / 360 * fallback), 3, fallback)
    end
    ringModeValue = function(mode)
      local __lux_match_178 = mode
      if __lux_match_178 == "sector" or __lux_match_178 == 2 then
        return 2
      elseif __lux_match_178 == "arc" or __lux_match_178 == true or __lux_match_178 == 1 then
        return 1
      else
        return 0
      end
    end
    ringShapeConstants = function(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      local __lux_tmp_179 = toNumber(innerRadius)
      if __lux_tmp_179 == nil then
        __lux_tmp_179 = 0
      end
      local __lux_tmp_180 = toNumber(outerRadius)
      if __lux_tmp_180 == nil then
        __lux_tmp_180 = mathMin(w, h) * 0.5
      end
      local __lux_tmp_181 = toNumber(startDeg)
      if __lux_tmp_181 == nil then
        __lux_tmp_181 = 0
      end
      local __lux_tmp_182 = toNumber(endDeg)
      if __lux_tmp_182 == nil then
        __lux_tmp_182 = 360
      end
      return w, h, mathMax(0, __lux_tmp_179), mathMax(0.001, __lux_tmp_180), mathRad(__lux_tmp_181), mathRad(__lux_tmp_182), ringModeValue(mode)
    end
    ringFillParams = function(fill)
      local __lux_match_183 = fill
      local __lux_tag_184
      if __lux_match_183 ~= nil then
        __lux_tag_184 = __lux_match_183.kind
      end
      if __lux_tag_184 == style.FILL_LINEAR then
        local x1 = __lux_match_183.x1
        local y1 = __lux_match_183.y1
        local x2 = __lux_match_183.x2
        local y2 = __lux_match_183.y2
        local __lux_tmp_185 = x1
        if __lux_tmp_185 == nil then
          __lux_tmp_185 = 0
        end
        local __lux_tmp_186 = y1
        if __lux_tmp_186 == nil then
          __lux_tmp_186 = 0
        end
        local __lux_tmp_187 = x2
        if __lux_tmp_187 == nil then
          __lux_tmp_187 = 1
        end
        local __lux_tmp_188 = y2
        if __lux_tmp_188 == nil then
          __lux_tmp_188 = 0
        end
        return __lux_tmp_185, __lux_tmp_186, __lux_tmp_187, __lux_tmp_188
      elseif __lux_tag_184 == style.FILL_RADIAL then
        local cx = __lux_match_183.cx
        local cy = __lux_match_183.cy
        local radius = __lux_match_183.radius
        local localRadial
        do
          local __lux_tmp_189 = fill.localRadial == true
          if not __lux_tmp_189 then
            __lux_tmp_189 = fill.ringRadial == true
          end
          local __lux_tmp_190 = __lux_tmp_189
          if not __lux_tmp_190 then
            __lux_tmp_190 = fill.sectorRadial == true
          end
          localRadial = __lux_tmp_190
        end
        local __lux_tmp_191 = cx
        if __lux_tmp_191 == nil then
          __lux_tmp_191 = 0.5
        end
        local __lux_tmp_192 = cy
        if __lux_tmp_192 == nil then
          __lux_tmp_192 = 0.5
        end
        local __lux_tmp_193 = radius
        if __lux_tmp_193 == nil then
          __lux_tmp_193 = 0.5
        end
        local __lux_tmp_194
        if localRadial then
          __lux_tmp_194 = 1
        else
          __lux_tmp_194 = 0
        end
        return __lux_tmp_191, __lux_tmp_192, __lux_tmp_193, __lux_tmp_194
      elseif __lux_tag_184 == style.FILL_CONIC then
        local cx = __lux_match_183.cx
        local cy = __lux_match_183.cy
        local rotation = __lux_match_183.rotation
        local localAngular
        do
          local __lux_tmp_195 = fill.localAngular == true
          if not __lux_tmp_195 then
            __lux_tmp_195 = fill.shapeAngular == true
          end
          localAngular = __lux_tmp_195
        end
        local __lux_tmp_196 = cx
        if __lux_tmp_196 == nil then
          __lux_tmp_196 = 0.5
        end
        local __lux_tmp_197 = cy
        if __lux_tmp_197 == nil then
          __lux_tmp_197 = 0.5
        end
        local __lux_tmp_198
        if localAngular then
          __lux_tmp_198 = 1
        else
          __lux_tmp_198 = 0
        end
        return __lux_tmp_196, __lux_tmp_197, style.normalizedRotation(rotation), __lux_tmp_198
      else
        local __lux_unused_199 = nil
      end
      return 0, 0, 1, 0
    end
    ringFillNeedsLut = function(fill)
      local __lux_match_200 = fill
      local __lux_tag_201
      if __lux_match_200 ~= nil then
        __lux_tag_201 = __lux_match_200.kind
      end
      if __lux_tag_201 == style.FILL_LINEAR or __lux_tag_201 == style.FILL_RADIAL or __lux_tag_201 == style.FILL_CONIC then
        return true
      else
        return false
      end
    end
    ringLineStyle = function(width, fill, drawStyle)
      local __lux_obj_202 = drawStyle
      local __lux_val_203 = nil
      if __lux_obj_202 ~= nil then
        __lux_val_203 = __lux_obj_202.outerGlow
      end
      local __lux_obj_204 = drawStyle
      local __lux_val_205 = nil
      if __lux_obj_204 ~= nil then
        __lux_val_205 = __lux_obj_204.backdrop
      end
      return {
        width = width,
        fill = fill,
        noCaps = false,
        outerGlow = __lux_val_203,
        backdrop = __lux_val_205,
      }
    end
    drawRingFallback = function(cx, cy, outerRadius, arcWidth, startDeg, endDeg, mode, drawStyle)
      local fill
      do
        local __lux_tmp_206 = drawStyle.fill
        if __lux_tmp_206 == nil then
          local __lux_tmp_207 = drawStyle.color
          if __lux_tmp_207 == nil then
            __lux_tmp_207 = defaultRingFill
          end
          __lux_tmp_206 = __lux_tmp_207
        end
        fill = __lux_tmp_206
      end
      local segments
      do
        local __lux_tmp_208 = drawStyle.segments
        if __lux_tmp_208 == nil then
          __lux_tmp_208 = 64
        end
        segments = arcSegmentCount(outerRadius, startDeg, endDeg, __lux_tmp_208)
      end
      local startRad
      do
        local __lux_tmp_209 = startDeg
        if __lux_tmp_209 == nil then
          __lux_tmp_209 = 0
        end
        startRad = mathRad(__lux_tmp_209)
      end
      local endRad
      do
        local __lux_tmp_210 = endDeg
        if __lux_tmp_210 == nil then
          __lux_tmp_210 = 360
        end
        endRad = mathRad(__lux_tmp_210)
      end
      if mode == 2 then
        local innerRadius
        do
          local __lux_tmp_211 = toNumber(drawStyle.innerRadius)
          if __lux_tmp_211 == nil then
            __lux_tmp_211 = mathMax(0, outerRadius - arcWidth)
          end
          innerRadius = mathClamp(__lux_tmp_211, 0, outerRadius)
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
      local __lux_tmp_212 = not style.fillVisible(fill)
      if not __lux_tmp_212 then
        __lux_tmp_212 = not shadersActive()
      end
      local __lux_tmp_213 = __lux_tmp_212
      if not __lux_tmp_213 then
        __lux_tmp_213 = not materialOK(widgetMaterials.ring)
      end
      if __lux_tmp_213 then
        return false
      end
      local material = widgetMaterials.ring
      local colorB
      do
        local __lux_tmp_214 = fill.colorB
        if __lux_tmp_214 == nil then
          local __lux_tmp_215 = fill.colorA
          if __lux_tmp_215 == nil then
            __lux_tmp_215 = color_white
          end
          __lux_tmp_214 = __lux_tmp_215
        end
        colorB = __lux_tmp_214
      end
      local r, g, b, a = style.color01(colorB)
      local sw, sh, ir, orad, sr, er, modeValue = ringShapeConstants(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      local p0, p1, p2, p3 = ringFillParams(fill)
      do
        local __lux_tmp_216 = fill.kind
        if __lux_tmp_216 == nil then
          __lux_tmp_216 = style.FILL_SOLID
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
          __lux_tmp_216,
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
        local __lux_tmp_217 = fill.colorA
        if __lux_tmp_217 == nil then
          __lux_tmp_217 = color_white
        end
        style.setDrawColor(__lux_tmp_217)
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    drawRingStrokePass = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, stroke, strokeWidth)
      local width = style.strokeWidth(strokeWidth, 0)
      local __lux_tmp_218 = not style.strokeVisible(stroke, width)
      if not __lux_tmp_218 then
        __lux_tmp_218 = not shadersActive()
      end
      local __lux_tmp_219 = __lux_tmp_218
      if not __lux_tmp_219 then
        __lux_tmp_219 = not materialOK(widgetMaterials.ring_stroke)
      end
      if __lux_tmp_219 then
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
          local __lux_tmp_220 = innerSpec.color
          if __lux_tmp_220 == nil then
            __lux_tmp_220 = transparentColor
          end
          gr, gg, gb, ga = style.color01(__lux_tmp_220)
        end
        do
          local __lux_tmp_221 = toNumber(innerSpec.width)
          if __lux_tmp_221 == nil then
            __lux_tmp_221 = 8
          end
          glowWidth = mathMax(0.001, __lux_tmp_221)
        end
        do
          local __lux_tmp_222 = toNumber(innerSpec.strength)
          if __lux_tmp_222 == nil then
            __lux_tmp_222 = 1
          end
          glowStrength = mathMax(0, __lux_tmp_222)
        end
        do
          local __lux_tmp_223 = toNumber(innerSpec.falloff)
          if __lux_tmp_223 == nil then
            __lux_tmp_223 = 1.65
          end
          glowFalloff = mathMax(0.001, __lux_tmp_223)
        end
        do
          local __lux_tmp_224 = ga > 0
          if __lux_tmp_224 then
            __lux_tmp_224 = glowWidth > 0
          end
          local __lux_tmp_225 = __lux_tmp_224
          if __lux_tmp_225 then
            __lux_tmp_225 = glowStrength > 0
          end
          hasGlow = __lux_tmp_225
        end
      end
      local __lux_tmp_226 = not hasStroke
      if __lux_tmp_226 then
        __lux_tmp_226 = not hasGlow
      end
      local __lux_tmp_227 = __lux_tmp_226
      if not __lux_tmp_227 then
        __lux_tmp_227 = not shadersActive()
      end
      local __lux_tmp_228 = __lux_tmp_227
      if not __lux_tmp_228 then
        __lux_tmp_228 = not materialOK(widgetMaterials.ring_fx)
      end
      if __lux_tmp_228 then
        return false
      end
      local material = widgetMaterials.ring_fx
      local colorB
      do
        local __lux_tmp_229 = fill.colorB
        if __lux_tmp_229 == nil then
          local __lux_tmp_230 = fill.colorA
          if __lux_tmp_230 == nil then
            __lux_tmp_230 = color_white
          end
          __lux_tmp_229 = __lux_tmp_230
        end
        colorB = __lux_tmp_229
      end
      local r, g, b, a = style.color01(colorB)
      local sw, sh, ir, orad, sr, er, modeValue = ringShapeConstants(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      local p0, p1, p2, p3 = ringFillParams(fill)
      do
        local __lux_tmp_231 = fill.kind
        if __lux_tmp_231 == nil then
          __lux_tmp_231 = style.FILL_SOLID
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
          __lux_tmp_231,
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
        local __lux_tmp_232 = fill.colorA
        if __lux_tmp_232 == nil then
          __lux_tmp_232 = color_white
        end
        style.setDrawColor(__lux_tmp_232)
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    drawRingInnerGlowPass = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, spec)
      local __lux_tmp_233 = spec == nil
      if not __lux_tmp_233 then
        __lux_tmp_233 = not shadersActive()
      end
      local __lux_tmp_234 = __lux_tmp_233
      if not __lux_tmp_234 then
        __lux_tmp_234 = not materialOK(widgetMaterials.ring_innerglow)
      end
      if __lux_tmp_234 then
        return false
      end
      local color = spec.color
      local __lux_tmp_235 = color == nil
      if not __lux_tmp_235 then
        local __lux_tmp_236 = color.a
        if __lux_tmp_236 == nil then
          __lux_tmp_236 = 255
        end
        __lux_tmp_235 = __lux_tmp_236 <= 0
      end
      if __lux_tmp_235 then
        return false
      end
      local material = widgetMaterials.ring_innerglow
      local r, g, b, a = style.color01(color)
      local sw, sh, ir, orad, sr, er, modeValue = ringShapeConstants(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      do
        local __lux_tmp_237 = toNumber(spec.width)
        if __lux_tmp_237 == nil then
          __lux_tmp_237 = 8
        end
        local __lux_tmp_238 = toNumber(spec.strength)
        if __lux_tmp_238 == nil then
          __lux_tmp_238 = 1
        end
        local __lux_tmp_239 = toNumber(spec.falloff)
        if __lux_tmp_239 == nil then
          __lux_tmp_239 = 1.65
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
          mathMax(0.001, __lux_tmp_237),
          mathMax(0, __lux_tmp_238),
          mathMax(0.001, __lux_tmp_239),
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
      local __lux_tmp_240 = spec == nil
      if not __lux_tmp_240 then
        __lux_tmp_240 = spec.color == nil
      end
      local __lux_tmp_241 = __lux_tmp_240
      if not __lux_tmp_241 then
        local __lux_tmp_242 = spec.color.a
        if __lux_tmp_242 == nil then
          __lux_tmp_242 = 255
        end
        __lux_tmp_241 = __lux_tmp_242 <= 0
      end
      if __lux_tmp_241 then
        return nil
      end
      local grow
      do
        local __lux_tmp_243 = spec.grow
        if __lux_tmp_243 == nil then
          local __lux_tmp_244 = spec.shapeSpread
          if __lux_tmp_244 == nil then
            __lux_tmp_244 = spec.expand
          end
          __lux_tmp_243 = __lux_tmp_244
        end
        local __lux_tmp_245 = toNumber(__lux_tmp_243)
        if __lux_tmp_245 == nil then
          __lux_tmp_245 = 0
        end
        grow = mathMax(0, __lux_tmp_245)
      end
      local ox
      do
        local __lux_tmp_246 = spec.x
        if __lux_tmp_246 == nil then
          local __lux_tmp_247 = spec.offsetX
          if __lux_tmp_247 == nil then
            __lux_tmp_247 = spec.dx
          end
          __lux_tmp_246 = __lux_tmp_247
        end
        local __lux_tmp_248 = toNumber(__lux_tmp_246)
        if __lux_tmp_248 == nil then
          __lux_tmp_248 = 0
        end
        ox = __lux_tmp_248
      end
      local oy
      do
        local __lux_tmp_249 = spec.y
        if __lux_tmp_249 == nil then
          local __lux_tmp_250 = spec.offsetY
          if __lux_tmp_250 == nil then
            __lux_tmp_250 = spec.dy
          end
          __lux_tmp_249 = __lux_tmp_250
        end
        local __lux_tmp_251 = toNumber(__lux_tmp_249)
        if __lux_tmp_251 == nil then
          __lux_tmp_251 = 0
        end
        oy = __lux_tmp_251
      end
      local gx = x + ox - grow
      local gy = y + oy - grow
      local gw = w + grow * 2
      local gh = h + grow * 2
      local gi
      do
        local __lux_tmp_252 = toNumber(innerRadius)
        if __lux_tmp_252 == nil then
          __lux_tmp_252 = 0
        end
        gi = mathMax(0, __lux_tmp_252 - grow)
      end
      local go
      do
        local __lux_tmp_253 = toNumber(outerRadius)
        if __lux_tmp_253 == nil then
          __lux_tmp_253 = mathMin(w, h) * 0.5
        end
        go = mathMax(0.001, __lux_tmp_253 + grow)
      end
      local spread = roundrect.effectExtentFromSpec(spec, 18)
      if biasOffset then
        local left, top, right, bottom = roundrect.glowBiasPads(spread, ox, oy)
        local __lux_tmp_254 = toNumber(startDeg)
        if __lux_tmp_254 == nil then
          __lux_tmp_254 = 0
        end
        local __lux_tmp_255 = toNumber(endDeg)
        if __lux_tmp_255 == nil then
          __lux_tmp_255 = 360
        end
        local __lux_tmp_256 = toNumber(spec.width)
        if __lux_tmp_256 == nil then
          __lux_tmp_256 = 18
        end
        local __lux_tmp_257 = toNumber(spec.strength)
        if __lux_tmp_257 == nil then
          __lux_tmp_257 = 1
        end
        local __lux_tmp_258 = toNumber(spec.falloff)
        if __lux_tmp_258 == nil then
          __lux_tmp_258 = 1.9
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
          start = mathRad(__lux_tmp_254),
          finish = mathRad(__lux_tmp_255),
          mode = ringModeValue(mode),
          width = mathMax(0.001, __lux_tmp_256),
          strength = mathMax(0, __lux_tmp_257),
          falloff = mathMax(0.001, __lux_tmp_258),
        }
      end
      local __lux_tmp_259 = toNumber(startDeg)
      if __lux_tmp_259 == nil then
        __lux_tmp_259 = 0
      end
      local __lux_tmp_260 = toNumber(endDeg)
      if __lux_tmp_260 == nil then
        __lux_tmp_260 = 360
      end
      local __lux_tmp_261 = toNumber(spec.width)
      if __lux_tmp_261 == nil then
        __lux_tmp_261 = 18
      end
      local __lux_tmp_262 = toNumber(spec.strength)
      if __lux_tmp_262 == nil then
        __lux_tmp_262 = 1
      end
      local __lux_tmp_263 = toNumber(spec.falloff)
      if __lux_tmp_263 == nil then
        __lux_tmp_263 = 1.9
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
        start = mathRad(__lux_tmp_259),
        finish = mathRad(__lux_tmp_260),
        mode = ringModeValue(mode),
        width = mathMax(0.001, __lux_tmp_261),
        strength = mathMax(0, __lux_tmp_262),
        falloff = mathMax(0.001, __lux_tmp_263),
      }
    end
    drawRingShadowOuterPass = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, shadowSpec, outerSpec)
      local __lux_tmp_264 = shadowSpec == nil
      if __lux_tmp_264 then
        __lux_tmp_264 = outerSpec == nil
      end
      local __lux_tmp_265 = __lux_tmp_264
      if not __lux_tmp_265 then
        __lux_tmp_265 = not shadersActive()
      end
      local __lux_tmp_266 = __lux_tmp_265
      if not __lux_tmp_266 then
        __lux_tmp_266 = not materialOK(widgetMaterials.ring_shadow_outer)
      end
      if __lux_tmp_266 then
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
      local __lux_tmp_267 = shadowBounds == nil
      if __lux_tmp_267 then
        __lux_tmp_267 = outerBounds == nil
      end
      if __lux_tmp_267 then
        return false
      end
      local baseBounds
      do
        local __lux_tmp_268 = shadowBounds
        if __lux_tmp_268 == nil then
          __lux_tmp_268 = outerBounds
        end
        baseBounds = __lux_tmp_268
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
        local __lux_obj_269 = shadowSpec
        local __lux_val_270 = nil
        if __lux_obj_269 ~= nil then
          __lux_val_270 = __lux_obj_269.color
        end
        local __lux_tmp_271 = __lux_val_270
        if __lux_tmp_271 == nil then
          __lux_tmp_271 = transparentColor
        end
        shadowColor = __lux_tmp_271
      end
      local outerColor
      do
        local __lux_obj_272 = outerSpec
        local __lux_val_273 = nil
        if __lux_obj_272 ~= nil then
          __lux_val_273 = __lux_obj_272.color
        end
        local __lux_tmp_274 = __lux_val_273
        if __lux_tmp_274 == nil then
          __lux_tmp_274 = transparentColor
        end
        outerColor = __lux_tmp_274
      end
      local material = widgetMaterials.ring_shadow_outer
      do
        local __lux_tmp_275 = shadowColor.r
        if __lux_tmp_275 == nil then
          __lux_tmp_275 = 0
        end
        local __lux_tmp_276 = shadowColor.g
        if __lux_tmp_276 == nil then
          __lux_tmp_276 = 0
        end
        local __lux_tmp_277 = shadowColor.b
        if __lux_tmp_277 == nil then
          __lux_tmp_277 = 0
        end
        local __lux_tmp_278
        if shadowBounds ~= nil then
          do
            local __lux_tmp_279 = shadowColor.a
            if __lux_tmp_279 == nil then
              __lux_tmp_279 = 255
            end
            __lux_tmp_278 = __lux_tmp_279 / 255
          end
        else
          __lux_tmp_278 = 0
        end
        local __lux_obj_280 = shadowBounds
        local __lux_val_281 = nil
        if __lux_obj_280 ~= nil then
          __lux_val_281 = __lux_obj_280.x
        end
        local __lux_tmp_282 = __lux_val_281
        if __lux_tmp_282 == nil then
          __lux_tmp_282 = x
        end
        local __lux_obj_283 = shadowBounds
        local __lux_val_284 = nil
        if __lux_obj_283 ~= nil then
          __lux_val_284 = __lux_obj_283.shapeX
        end
        local __lux_tmp_285 = __lux_val_284
        if __lux_tmp_285 == nil then
          __lux_tmp_285 = 0
        end
        local __lux_obj_286 = shadowBounds
        local __lux_val_287 = nil
        if __lux_obj_286 ~= nil then
          __lux_val_287 = __lux_obj_286.outer
        end
        local __lux_tmp_288 = __lux_val_287
        if __lux_tmp_288 == nil then
          __lux_tmp_288 = 0
        end
        local __lux_obj_289 = shadowBounds
        local __lux_val_290 = nil
        if __lux_obj_289 ~= nil then
          __lux_val_290 = __lux_obj_289.y
        end
        local __lux_tmp_291 = __lux_val_290
        if __lux_tmp_291 == nil then
          __lux_tmp_291 = y
        end
        local __lux_obj_292 = shadowBounds
        local __lux_val_293 = nil
        if __lux_obj_292 ~= nil then
          __lux_val_293 = __lux_obj_292.shapeY
        end
        local __lux_tmp_294 = __lux_val_293
        if __lux_tmp_294 == nil then
          __lux_tmp_294 = 0
        end
        local __lux_obj_295 = shadowBounds
        local __lux_val_296 = nil
        if __lux_obj_295 ~= nil then
          __lux_val_296 = __lux_obj_295.outer
        end
        local __lux_tmp_297 = __lux_val_296
        if __lux_tmp_297 == nil then
          __lux_tmp_297 = 0
        end
        local __lux_obj_298 = shadowBounds
        local __lux_val_299 = nil
        if __lux_obj_298 ~= nil then
          __lux_val_299 = __lux_obj_298.inner
        end
        local __lux_tmp_300 = __lux_val_299
        if __lux_tmp_300 == nil then
          __lux_tmp_300 = 0
        end
        local __lux_obj_301 = shadowBounds
        local __lux_val_302 = nil
        if __lux_obj_301 ~= nil then
          __lux_val_302 = __lux_obj_301.outer
        end
        local __lux_tmp_303 = __lux_val_302
        if __lux_tmp_303 == nil then
          __lux_tmp_303 = 1
        end
        local __lux_obj_304 = shadowBounds
        local __lux_val_305 = nil
        if __lux_obj_304 ~= nil then
          __lux_val_305 = __lux_obj_304.start
        end
        local __lux_tmp_306 = __lux_val_305
        if __lux_tmp_306 == nil then
          __lux_tmp_306 = 0
        end
        local __lux_obj_307 = shadowBounds
        local __lux_val_308 = nil
        if __lux_obj_307 ~= nil then
          __lux_val_308 = __lux_obj_307.finish
        end
        local __lux_tmp_309 = __lux_val_308
        if __lux_tmp_309 == nil then
          __lux_tmp_309 = mathRad(360)
        end
        local __lux_obj_310 = shadowBounds
        local __lux_val_311 = nil
        if __lux_obj_310 ~= nil then
          __lux_val_311 = __lux_obj_310.mode
        end
        local __lux_tmp_312 = __lux_val_311
        if __lux_tmp_312 == nil then
          __lux_tmp_312 = 0
        end
        local __lux_tmp_313
        if shadowBounds ~= nil then
          __lux_tmp_313 = shadowBounds.width
        else
          __lux_tmp_313 = 1
        end
        setupParamMatrix(
          material,
          drawW,
          drawH,
          0,
          0,
          __lux_tmp_275 / 255,
          __lux_tmp_276 / 255,
          __lux_tmp_277 / 255,
          __lux_tmp_278,
          __lux_tmp_282 + __lux_tmp_285 + __lux_tmp_288 - sx,
          __lux_tmp_291 + __lux_tmp_294 + __lux_tmp_297 - sy,
          __lux_tmp_300,
          __lux_tmp_303,
          __lux_tmp_306,
          __lux_tmp_309,
          __lux_tmp_312,
          __lux_tmp_313
        )
      end
      do
        local __lux_tmp_314 = outerColor.r
        if __lux_tmp_314 == nil then
          __lux_tmp_314 = 0
        end
        local __lux_tmp_315 = outerColor.g
        if __lux_tmp_315 == nil then
          __lux_tmp_315 = 0
        end
        local __lux_tmp_316 = outerColor.b
        if __lux_tmp_316 == nil then
          __lux_tmp_316 = 0
        end
        local __lux_tmp_317
        if outerBounds ~= nil then
          do
            local __lux_tmp_318 = outerColor.a
            if __lux_tmp_318 == nil then
              __lux_tmp_318 = 255
            end
            __lux_tmp_317 = __lux_tmp_318 / 255
          end
        else
          __lux_tmp_317 = 0
        end
        local __lux_obj_319 = outerBounds
        local __lux_val_320 = nil
        if __lux_obj_319 ~= nil then
          __lux_val_320 = __lux_obj_319.x
        end
        local __lux_tmp_321 = __lux_val_320
        if __lux_tmp_321 == nil then
          __lux_tmp_321 = x
        end
        local __lux_obj_322 = outerBounds
        local __lux_val_323 = nil
        if __lux_obj_322 ~= nil then
          __lux_val_323 = __lux_obj_322.shapeX
        end
        local __lux_tmp_324 = __lux_val_323
        if __lux_tmp_324 == nil then
          __lux_tmp_324 = 0
        end
        local __lux_obj_325 = outerBounds
        local __lux_val_326 = nil
        if __lux_obj_325 ~= nil then
          __lux_val_326 = __lux_obj_325.outer
        end
        local __lux_tmp_327 = __lux_val_326
        if __lux_tmp_327 == nil then
          __lux_tmp_327 = 0
        end
        local __lux_obj_328 = outerBounds
        local __lux_val_329 = nil
        if __lux_obj_328 ~= nil then
          __lux_val_329 = __lux_obj_328.y
        end
        local __lux_tmp_330 = __lux_val_329
        if __lux_tmp_330 == nil then
          __lux_tmp_330 = y
        end
        local __lux_obj_331 = outerBounds
        local __lux_val_332 = nil
        if __lux_obj_331 ~= nil then
          __lux_val_332 = __lux_obj_331.shapeY
        end
        local __lux_tmp_333 = __lux_val_332
        if __lux_tmp_333 == nil then
          __lux_tmp_333 = 0
        end
        local __lux_obj_334 = outerBounds
        local __lux_val_335 = nil
        if __lux_obj_334 ~= nil then
          __lux_val_335 = __lux_obj_334.outer
        end
        local __lux_tmp_336 = __lux_val_335
        if __lux_tmp_336 == nil then
          __lux_tmp_336 = 0
        end
        local __lux_obj_337 = outerBounds
        local __lux_val_338 = nil
        if __lux_obj_337 ~= nil then
          __lux_val_338 = __lux_obj_337.inner
        end
        local __lux_tmp_339 = __lux_val_338
        if __lux_tmp_339 == nil then
          __lux_tmp_339 = 0
        end
        local __lux_obj_340 = outerBounds
        local __lux_val_341 = nil
        if __lux_obj_340 ~= nil then
          __lux_val_341 = __lux_obj_340.outer
        end
        local __lux_tmp_342 = __lux_val_341
        if __lux_tmp_342 == nil then
          __lux_tmp_342 = 1
        end
        local __lux_obj_343 = outerBounds
        local __lux_val_344 = nil
        if __lux_obj_343 ~= nil then
          __lux_val_344 = __lux_obj_343.start
        end
        local __lux_tmp_345 = __lux_val_344
        if __lux_tmp_345 == nil then
          __lux_tmp_345 = 0
        end
        local __lux_obj_346 = outerBounds
        local __lux_val_347 = nil
        if __lux_obj_346 ~= nil then
          __lux_val_347 = __lux_obj_346.finish
        end
        local __lux_tmp_348 = __lux_val_347
        if __lux_tmp_348 == nil then
          __lux_tmp_348 = mathRad(360)
        end
        local __lux_obj_349 = outerBounds
        local __lux_val_350 = nil
        if __lux_obj_349 ~= nil then
          __lux_val_350 = __lux_obj_349.mode
        end
        local __lux_tmp_351 = __lux_val_350
        if __lux_tmp_351 == nil then
          __lux_tmp_351 = 0
        end
        local __lux_tmp_352
        if outerBounds ~= nil then
          __lux_tmp_352 = outerBounds.width
        else
          __lux_tmp_352 = 1
        end
        local __lux_tmp_353
        if shadowBounds ~= nil then
          __lux_tmp_353 = shadowBounds.falloff
        else
          __lux_tmp_353 = 1
        end
        local __lux_tmp_354
        if shadowBounds ~= nil then
          __lux_tmp_354 = shadowBounds.strength
        else
          __lux_tmp_354 = 0
        end
        local __lux_tmp_355
        if outerBounds ~= nil then
          __lux_tmp_355 = outerBounds.falloff
        else
          __lux_tmp_355 = 1
        end
        local __lux_tmp_356
        if outerBounds ~= nil then
          __lux_tmp_356 = outerBounds.strength
        else
          __lux_tmp_356 = 0
        end
        setupAuxConstants(
          material,
          __lux_tmp_314 / 255,
          __lux_tmp_315 / 255,
          __lux_tmp_316 / 255,
          __lux_tmp_317,
          __lux_tmp_321 + __lux_tmp_324 + __lux_tmp_327 - sx,
          __lux_tmp_330 + __lux_tmp_333 + __lux_tmp_336 - sy,
          __lux_tmp_339,
          __lux_tmp_342,
          __lux_tmp_345,
          __lux_tmp_348,
          __lux_tmp_351,
          __lux_tmp_352,
          __lux_tmp_353,
          __lux_tmp_354,
          __lux_tmp_355,
          __lux_tmp_356
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
      local __lux_tmp_357 = spec == nil
      if not __lux_tmp_357 then
        __lux_tmp_357 = spec.tint == nil
      end
      if __lux_tmp_357 then
        return nil
      end
      local tint = spec.tint
      local alpha
      do
        local __lux_tmp_358 = tint.a
        if __lux_tmp_358 == nil then
          __lux_tmp_358 = 255
        end
        local __lux_tmp_359 = spec.opacity
        if __lux_tmp_359 == nil then
          __lux_tmp_359 = 1
        end
        alpha = __lux_tmp_358 * __lux_tmp_359
      end
      if alpha <= 0 then
        return nil
      end
      local __lux_tmp_360 = tint.r
      if __lux_tmp_360 == nil then
        __lux_tmp_360 = 0
      end
      local __lux_tmp_361 = tint.g
      if __lux_tmp_361 == nil then
        __lux_tmp_361 = 0
      end
      local __lux_tmp_362 = tint.b
      if __lux_tmp_362 == nil then
        __lux_tmp_362 = 0
      end
      return makeColor(
        __lux_tmp_360,
        __lux_tmp_361,
        __lux_tmp_362,
        mathFloor(mathClamp(alpha, 0, 255) + 0.5)
      )
    end
    setupRingBackdropConstants = function(material, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, vertical, intensity)
      local sw, sh, ir, orad, sr, er, modeValue = ringShapeConstants(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      local __lux_tmp_363 = vertical
      if __lux_tmp_363 then
        __lux_tmp_363 = 1
      end
      local __lux_tmp_364 = __lux_tmp_363
      if not __lux_tmp_364 then
        __lux_tmp_364 = 0
      end
      local __lux_tmp_365 = intensity
      if __lux_tmp_365 == nil then
        __lux_tmp_365 = 1
      end
      return setupParamMatrix(
        material,
        __lux_tmp_364,
        __lux_tmp_365,
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
        local __lux_tmp_366 = toNumber(spec.padding)
        if __lux_tmp_366 == nil then
          __lux_tmp_366 = 0
        end
        pad = mathMax(0, __lux_tmp_366)
      end
      local bx = x - pad
      local by = y - pad
      local bw = w + pad * 2
      local bh = h + pad * 2
      local bi
      do
        local __lux_tmp_367 = toNumber(innerRadius)
        if __lux_tmp_367 == nil then
          __lux_tmp_367 = 0
        end
        bi = mathMax(0, __lux_tmp_367 - pad)
      end
      local bo
      do
        local __lux_tmp_368 = toNumber(outerRadius)
        if __lux_tmp_368 == nil then
          __lux_tmp_368 = mathMin(w, h) * 0.5
        end
        bo = mathMax(0.001, __lux_tmp_368 + pad)
      end
      local __lux_tmp_369 = spec.blur > 0
      if __lux_tmp_369 then
        __lux_tmp_369 = widgetBlurRT ~= nil
      end
      local __lux_tmp_370 = __lux_tmp_369
      if __lux_tmp_370 then
        __lux_tmp_370 = renderCopyRenderTargetToTexture ~= nil
      end
      local __lux_tmp_371 = __lux_tmp_370
      if __lux_tmp_371 then
        __lux_tmp_371 = materialOK(widgetMaterials.ring_backdrop)
      end
      if __lux_tmp_371 then
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
      local __lux_tmp_372 = spec == nil
      if not __lux_tmp_372 then
        __lux_tmp_372 = not shadersActive()
      end
      local __lux_tmp_373 = __lux_tmp_372
      if not __lux_tmp_373 then
        __lux_tmp_373 = not materialOK(widgetMaterials.ring_pattern)
      end
      if __lux_tmp_373 then
        return false
      end
      local material = widgetMaterials.ring_pattern
      local angle
      do
        local __lux_tmp_374 = toNumber(spec.angle)
        if __lux_tmp_374 == nil then
          __lux_tmp_374 = 135
        end
        angle = mathRad(__lux_tmp_374)
      end
      local smoke
      local __lux_match_375 = spec.kind
      if __lux_match_375 == "smoke" then
        smoke = true
      else
        smoke = false
      end
      local pz
      if smoke then
        do
          local __lux_tmp_376 = toNumber(spec.scale)
          if __lux_tmp_376 == nil then
            __lux_tmp_376 = 140
          end
          pz = mathMax(1, __lux_tmp_376)
        end
      else
        do
          local __lux_tmp_377 = toNumber(spec.spacing)
          if __lux_tmp_377 == nil then
            __lux_tmp_377 = 12
          end
          pz = mathMax(1, __lux_tmp_377)
        end
      end
      local pw
      if smoke then
        do
          local __lux_tmp_378 = toNumber(spec.density)
          if __lux_tmp_378 == nil then
            __lux_tmp_378 = 0.48
          end
          pw = mathClamp(__lux_tmp_378, 0, 1)
        end
      else
        do
          local __lux_tmp_379 = toNumber(spec.width)
          if __lux_tmp_379 == nil then
            __lux_tmp_379 = 2
          end
          pw = mathMax(0.25, __lux_tmp_379)
        end
      end
      do
        local __lux_tmp_380
        if smoke then
          do
            local __lux_tmp_381 = toNumber(spec.seed)
            if __lux_tmp_381 == nil then
              __lux_tmp_381 = 0
            end
            __lux_tmp_380 = __lux_tmp_381
          end
        else
          __lux_tmp_380 = 0
        end
        local __lux_tmp_382
        if smoke then
          do
            local __lux_tmp_383 = toNumber(spec.softness)
            if __lux_tmp_383 == nil then
              __lux_tmp_383 = 0.3
            end
            __lux_tmp_382 = mathMax(0.001, __lux_tmp_383)
          end
        else
          __lux_tmp_382 = 0
        end
        local __lux_tmp_384
        if smoke then
          do
            local __lux_tmp_385 = toNumber(spec.warp)
            if __lux_tmp_385 == nil then
              __lux_tmp_385 = 0.85
            end
            __lux_tmp_384 = mathMax(0, __lux_tmp_385)
          end
        else
          __lux_tmp_384 = 0
        end
        local __lux_tmp_386 = toNumber(innerRadius)
        if __lux_tmp_386 == nil then
          __lux_tmp_386 = 0
        end
        local __lux_tmp_387 = toNumber(outerRadius)
        if __lux_tmp_387 == nil then
          __lux_tmp_387 = mathMin(w, h) * 0.5
        end
        local __lux_tmp_388 = toNumber(startDeg)
        if __lux_tmp_388 == nil then
          __lux_tmp_388 = 0
        end
        local __lux_tmp_389 = toNumber(endDeg)
        if __lux_tmp_389 == nil then
          __lux_tmp_389 = 360
        end
        local __lux_tmp_390
        if smoke then
          __lux_tmp_390 = 1
        else
          __lux_tmp_390 = 0
        end
        setupParamMatrix(
          material,
          __lux_tmp_380,
          roundrect.patternOffset(spec),
          __lux_tmp_382,
          __lux_tmp_384,
          w,
          h,
          mathMax(0, __lux_tmp_386),
          mathMax(0.001, __lux_tmp_387),
          mathRad(__lux_tmp_388),
          mathRad(__lux_tmp_389),
          ringModeValue(mode),
          __lux_tmp_390,
          mathCos(angle),
          mathSin(angle),
          pz,
          pw
        )
      end
      do
        local __lux_tmp_391 = spec.color
        if __lux_tmp_391 == nil then
          local __lux_tmp_392 = spec.tint
          if __lux_tmp_392 == nil then
            __lux_tmp_392 = makeColor(255, 255, 255, 24)
          end
          __lux_tmp_391 = __lux_tmp_392
        end
        style.setDrawColor(__lux_tmp_391)
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h, material)
      return true
    end
    drawRingBox = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, drawStyle)
      do
        local __lux_tmp_393 = drawStyle
        if __lux_tmp_393 == nil then
          __lux_tmp_393 = {}
        end
        drawStyle = __lux_tmp_393
      end
      local fill
      do
        local __lux_tmp_394 = drawStyle.fill
        if __lux_tmp_394 == nil then
          local __lux_tmp_395 = drawStyle.color
          if __lux_tmp_395 == nil then
            __lux_tmp_395 = defaultRingFill
          end
          __lux_tmp_394 = __lux_tmp_395
        end
        fill = style.fillFromStyle(__lux_tmp_394)
      end
      local __lux_tmp_396 = not shadersActive()
      if not __lux_tmp_396 then
        __lux_tmp_396 = not materialOK(widgetMaterials.ring)
      end
      if __lux_tmp_396 then
        local __lux_table_397 = {}
        local __lux_spread_398 = drawStyle
        if __lux_spread_398 ~= nil then
          for __lux_k_399, __lux_v_400 in pairs(__lux_spread_398) do
            __lux_table_397[__lux_k_399] = __lux_v_400
          end
        end
        __lux_table_397.fill = fill
        __lux_table_397.innerRadius = innerRadius
        return drawRingFallback(
          x + w * 0.5,
          y + h * 0.5,
          outerRadius,
          outerRadius - innerRadius,
          startDeg,
          endDeg,
          mode,
          __lux_table_397
        )
      end
      local shadow = roundrect.shadowStyle(drawStyle.shadow)
      local outer = roundrect.outerGlowStyle(drawStyle.outerGlow)
      local __lux_tmp_401 = shadow ~= nil
      if not __lux_tmp_401 then
        __lux_tmp_401 = outer ~= nil
      end
      if __lux_tmp_401 then
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
      local __lux_tmp_402 = drawStyle.pattern == nil
      if __lux_tmp_402 then
        local __lux_tmp_403 = hasStroke
        if not __lux_tmp_403 then
          __lux_tmp_403 = inner ~= nil
        end
        __lux_tmp_402 = __lux_tmp_403
      end
      local __lux_tmp_404 = __lux_tmp_402
      if __lux_tmp_404 then
        __lux_tmp_404 = drawRingFxPass(
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
      )
      end
      if __lux_tmp_404 then
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
      local resolved
      do
        local __lux_tmp_405 = drawStyle
        if __lux_tmp_405 == nil then
          __lux_tmp_405 = {}
        end
        resolved = __lux_tmp_405
      end
      local transform, stripped = geometry.splitStyleTransform(resolved)
      local outerRadius
      do
        local __lux_tmp_406 = toNumber(radius)
        if __lux_tmp_406 == nil then
          __lux_tmp_406 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_406)
      end
      local ringWidth
      do
        local __lux_tmp_407 = toNumber(width)
        if __lux_tmp_407 == nil then
          __lux_tmp_407 = mathMax(1, outerRadius * 0.18)
        end
        ringWidth = mathMax(0.001, __lux_tmp_407)
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
      local resolved
      do
        local __lux_tmp_408 = drawStyle
        if __lux_tmp_408 == nil then
          __lux_tmp_408 = {}
        end
        resolved = __lux_tmp_408
      end
      local transform, stripped = geometry.splitStyleTransform(resolved)
      local outerRadius
      do
        local __lux_tmp_409 = toNumber(radius)
        if __lux_tmp_409 == nil then
          __lux_tmp_409 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_409)
      end
      local arcWidth
      do
        local __lux_tmp_410 = toNumber(width)
        if __lux_tmp_410 == nil then
          __lux_tmp_410 = mathMax(1, outerRadius * 0.18)
        end
        arcWidth = mathMax(0.001, __lux_tmp_410)
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
      local resolved
      do
        local __lux_tmp_411 = drawStyle
        if __lux_tmp_411 == nil then
          __lux_tmp_411 = {}
        end
        resolved = __lux_tmp_411
      end
      local transform, stripped = geometry.splitStyleTransform(resolved)
      do
        local __lux_tmp_412 = toNumber(outerRadius)
        if __lux_tmp_412 == nil then
          __lux_tmp_412 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_412)
      end
      do
        local __lux_tmp_413 = toNumber(innerRadius)
        if __lux_tmp_413 == nil then
          __lux_tmp_413 = 0
        end
        innerRadius = mathClamp(__lux_tmp_413, 0, outerRadius)
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
            local __lux_tmp_414
            do
              local __lux_tmp_415 = material ~= nil
              if __lux_tmp_415 then
                __lux_tmp_415 = material.IsError ~= nil
              end
              local __lux_tmp_416 = __lux_tmp_415
              if __lux_tmp_416 then
                __lux_tmp_416 = not material:IsError()
              end
              if __lux_tmp_416 then
                __lux_tmp_414 = material
              else
                __lux_tmp_414 = false
              end
            end
            cached = __lux_tmp_414
          end
          imageMaterialCache[source] = cached
        end
        if cached == false then
          return nil, nil
        end
        return cached:GetTexture("$basetexture"), cached
      end
      local __lux_tmp_417 = source ~= nil
      if __lux_tmp_417 then
        __lux_tmp_417 = source.GetTexture ~= nil
      end
      if __lux_tmp_417 then
        return source:GetTexture("$basetexture"), source
      end
      local __lux_tmp_418 = source ~= nil
      if __lux_tmp_418 then
        __lux_tmp_418 = source.GetName ~= nil
      end
      if __lux_tmp_418 then
        return source, nil
      end
      return nil, nil
    end
    imageWhiteTextureSource = function()
      if imageWhiteTexture ~= nil then
        local __lux_tmp_419 = imageWhiteTexture ~= false
        if __lux_tmp_419 then
          __lux_tmp_419 = imageWhiteTexture
        end
        local __lux_tmp_420 = __lux_tmp_419
        if not __lux_tmp_420 then
          __lux_tmp_420 = nil
        end
        return __lux_tmp_420
      end
      local texture = imageTextureSource("color/white")
      do
        local __lux_tmp_421 = texture
        if __lux_tmp_421 == nil then
          __lux_tmp_421 = false
        end
        imageWhiteTexture = __lux_tmp_421
      end
      local __lux_tmp_422 = imageWhiteTexture ~= false
      if __lux_tmp_422 then
        __lux_tmp_422 = imageWhiteTexture
      end
      local __lux_tmp_423 = __lux_tmp_422
      if not __lux_tmp_423 then
        __lux_tmp_423 = nil
      end
      return __lux_tmp_423
    end
    imageFallbackMaterialForTexture = function(texture)
      local __lux_tmp_424 = texture == nil
      if not __lux_tmp_424 then
        __lux_tmp_424 = imageCreateMaterial == nil
      end
      if __lux_tmp_424 then
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
      local __lux_tmp_425 = kind ~= nil
      if __lux_tmp_425 then
        __lux_tmp_425 = kind >= 10
      end
      return __lux_tmp_425
    end
    imageMaskKindValue = function(mask)
      if typeOf(mask) ~= "table" then
        return nil
      end
      local kind
      do
        local __lux_tmp_426 = mask.kind
        if __lux_tmp_426 == nil then
          __lux_tmp_426 = mask.shape
        end
        kind = __lux_tmp_426
      end
      if typeOf(kind) ~= "string" then
        return nil
      end
      kind = imageStringLower(kind)
      local __lux_match_427 = kind
      if __lux_match_427 == "round" or __lux_match_427 == "rounded" or __lux_match_427 == "roundedbox" or __lux_match_427 == "roundrect" then
        return 0
      elseif __lux_match_427 == "chamfer" or __lux_match_427 == "bevel" then
        return 1
      elseif __lux_match_427 == "circle" then
        return 2
      elseif __lux_match_427 == "capsule" or __lux_match_427 == "pill" then
        return 3
      elseif __lux_match_427 == "texture" or __lux_match_427 == "alpha" or __lux_match_427 == "image" then
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
      local __lux_match_428 = normalized
      if __lux_match_428 == "a" or __lux_match_428 == "alpha" then
        return 10
      elseif __lux_match_428 == "r" or __lux_match_428 == "red" then
        return 11
      elseif __lux_match_428 == "g" or __lux_match_428 == "green" then
        return 12
      elseif __lux_match_428 == "b" or __lux_match_428 == "blue" then
        return 13
      elseif __lux_match_428 == "luma" or __lux_match_428 == "lum" or __lux_match_428 == "luminance" or __lux_match_428 == "rgb" then
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
        local __lux_tmp_429 = mask.source
        if __lux_tmp_429 == nil then
          local __lux_tmp_430 = mask.material
          if __lux_tmp_430 == nil then
            local __lux_tmp_431 = mask.texture
            if __lux_tmp_431 == nil then
              __lux_tmp_431 = mask.image
            end
            __lux_tmp_430 = __lux_tmp_431
          end
          __lux_tmp_429 = __lux_tmp_430
        end
        source = __lux_tmp_429
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
      local __lux_tmp_432 = typeOf(mask.uv) == "table"
      if not __lux_tmp_432 then
        __lux_tmp_432 = typeOf(mask.crop) == "table"
      end
      if __lux_tmp_432 then
        return geometry.imageUV(mask, texture)
      end
      local u0
      do
        local __lux_tmp_433 = mask.u0
        if __lux_tmp_433 == nil then
          local __lux_tmp_434 = mask.x0
          if __lux_tmp_434 == nil then
            __lux_tmp_434 = mask[1]
          end
          __lux_tmp_433 = __lux_tmp_434
        end
        local __lux_tmp_435 = toNumber(__lux_tmp_433)
        if __lux_tmp_435 == nil then
          __lux_tmp_435 = 0
        end
        u0 = __lux_tmp_435
      end
      local v0
      do
        local __lux_tmp_436 = mask.v0
        if __lux_tmp_436 == nil then
          local __lux_tmp_437 = mask.y0
          if __lux_tmp_437 == nil then
            __lux_tmp_437 = mask[2]
          end
          __lux_tmp_436 = __lux_tmp_437
        end
        local __lux_tmp_438 = toNumber(__lux_tmp_436)
        if __lux_tmp_438 == nil then
          __lux_tmp_438 = 0
        end
        v0 = __lux_tmp_438
      end
      local u1
      do
        local __lux_tmp_439 = mask.u1
        if __lux_tmp_439 == nil then
          local __lux_tmp_440 = mask.x1
          if __lux_tmp_440 == nil then
            __lux_tmp_440 = mask[3]
          end
          __lux_tmp_439 = __lux_tmp_440
        end
        local __lux_tmp_441 = toNumber(__lux_tmp_439)
        if __lux_tmp_441 == nil then
          __lux_tmp_441 = 1
        end
        u1 = __lux_tmp_441
      end
      local v1
      do
        local __lux_tmp_442 = mask.v1
        if __lux_tmp_442 == nil then
          local __lux_tmp_443 = mask.y1
          if __lux_tmp_443 == nil then
            __lux_tmp_443 = mask[4]
          end
          __lux_tmp_442 = __lux_tmp_443
        end
        local __lux_tmp_444 = toNumber(__lux_tmp_442)
        if __lux_tmp_444 == nil then
          __lux_tmp_444 = 1
        end
        v1 = __lux_tmp_444
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
        local __lux_tmp_445 = mask
        if __lux_tmp_445 == nil then
          __lux_tmp_445 = style.imageMaskStyle(drawStyle.mask, drawStyle)
        end
        resolvedMask = __lux_tmp_445
      end
      if typeOf(resolvedMask) ~= "table" then
        return nil
      end
      local __lux_match_446 = resolvedMask
      local __lux_tag_447
      if __lux_match_446 ~= nil then
        __lux_tag_447 = __lux_match_446.kind
      end
      if __lux_tag_447 == "chamfer" then
        local cuts = __lux_match_446.cuts
        local __lux_tmp_448 = cuts
        if __lux_tmp_448 == nil then
          __lux_tmp_448 = 0
        end
        return __lux_tmp_448
      else
        return nil
      end
    end
    imageChamferMaskTuple = function(mask, w, h)
      local cuts
      do
        local __lux_tmp_449 = mask ~= nil
        if __lux_tmp_449 then
          __lux_tmp_449 = mask.cuts
        end
        local __lux_tmp_450 = __lux_tmp_449
        if not __lux_tmp_450 then
          __lux_tmp_450 = 0
        end
        cuts = __lux_tmp_450
      end
      return primitives.chamferTuple(cuts, w, h)
    end
    setupImageMaskConstants = function(material, w, h, sourceU0, sourceV0, sourceU1, sourceV1, stroke, strokeWidth, mask, kind, maskTexture, sourceAlphaBase)
      if sourceAlphaBase == nil then
        sourceAlphaBase = false
      end
      local strokeColor
      do
        local __lux_tmp_451 = stroke
        if __lux_tmp_451 == nil then
          __lux_tmp_451 = transparentColor
        end
        strokeColor = __lux_tmp_451
      end
      local r, g, b, a = style.color01(strokeColor)
      local strokeR = r
      local strokeG = g
      local strokeB = b
      local strokeA = a
      local packedKind = kind
      local __lux_tmp_452 = mask ~= nil
      if __lux_tmp_452 then
        local __lux_tmp_453 = mask.invert
        if not __lux_tmp_453 then
          __lux_tmp_453 = mask.inverse
        end
        __lux_tmp_452 = __lux_tmp_453
      end
      if __lux_tmp_452 then
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
      local __lux_tmp_454 = mask ~= nil
      if __lux_tmp_454 then
        __lux_tmp_454 = geometry.imageRadius(mask.radius, w, h)
      end
      local __lux_tmp_455 = __lux_tmp_454
      if not __lux_tmp_455 then
        __lux_tmp_455 = 0
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
        __lux_tmp_455,
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
      local __lux_tmp_456 = texture == nil
      if not __lux_tmp_456 then
        __lux_tmp_456 = not materialOK(widgetMaterials.image_mask)
      end
      if __lux_tmp_456 then
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
        local __lux_tmp_457 = tint
        if __lux_tmp_457 == nil then
          __lux_tmp_457 = color_white
        end
        style.setDrawColor(__lux_tmp_457)
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
      local __lux_tmp_458 = spec == nil
      if not __lux_tmp_458 then
        __lux_tmp_458 = spec.tint == nil
      end
      if __lux_tmp_458 then
        return nil
      end
      local tint = spec.tint
      local alpha
      do
        local __lux_tmp_459 = tint.a
        if __lux_tmp_459 == nil then
          __lux_tmp_459 = 255
        end
        local __lux_tmp_460 = spec.opacity
        if __lux_tmp_460 == nil then
          __lux_tmp_460 = 1
        end
        alpha = __lux_tmp_459 * __lux_tmp_460
      end
      if alpha <= 0 then
        return nil
      end
      local __lux_tmp_461 = tint.r
      if __lux_tmp_461 == nil then
        __lux_tmp_461 = 0
      end
      local __lux_tmp_462 = tint.g
      if __lux_tmp_462 == nil then
        __lux_tmp_462 = 0
      end
      local __lux_tmp_463 = tint.b
      if __lux_tmp_463 == nil then
        __lux_tmp_463 = 0
      end
      return makeColor(
        __lux_tmp_461,
        __lux_tmp_462,
        __lux_tmp_463,
        mathFloor(mathClamp(alpha, 0, 255) + 0.5)
      )
    end
    setupImageMaskEffectParams = function(material, w, h, mask, kind, maskTexture, shadowSpec, outerSpec, drawX, drawY, shadowX, shadowY, outerX, outerY)
      local packedKind = kind
      local __lux_tmp_464 = mask ~= nil
      if __lux_tmp_464 then
        local __lux_tmp_465 = mask.invert
        if not __lux_tmp_465 then
          __lux_tmp_465 = mask.inverse
        end
        __lux_tmp_464 = __lux_tmp_465
      end
      if __lux_tmp_464 then
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
        local __lux_obj_466 = shadowSpec
        local __lux_val_467 = nil
        if __lux_obj_466 ~= nil then
          __lux_val_467 = __lux_obj_466.color
        end
        local __lux_tmp_468 = __lux_val_467
        if __lux_tmp_468 == nil then
          __lux_tmp_468 = makeColor(0, 0, 0, 0)
        end
        shadowColor = __lux_tmp_468
      end
      local outerColor
      do
        local __lux_obj_469 = outerSpec
        local __lux_val_470 = nil
        if __lux_obj_469 ~= nil then
          __lux_val_470 = __lux_obj_469.color
        end
        local __lux_tmp_471 = __lux_val_470
        if __lux_tmp_471 == nil then
          __lux_tmp_471 = makeColor(0, 0, 0, 0)
        end
        outerColor = __lux_tmp_471
      end
      do
        local __lux_tmp_472 = mask ~= nil
        if __lux_tmp_472 then
          __lux_tmp_472 = geometry.imageRadius(mask.radius, w, h)
        end
        local __lux_tmp_473 = __lux_tmp_472
        if not __lux_tmp_473 then
          __lux_tmp_473 = 0
        end
        local __lux_tmp_474
        if shadowSpec ~= nil then
          __lux_tmp_474 = roundrect.effectExtentFromSpec(shadowSpec, 18)
        else
          __lux_tmp_474 = 0
        end
        local __lux_tmp_475
        if outerSpec ~= nil then
          __lux_tmp_475 = roundrect.effectExtentFromSpec(outerSpec, 18)
        else
          __lux_tmp_475 = 0
        end
        local __lux_tmp_476 = shadowColor.r
        if __lux_tmp_476 == nil then
          __lux_tmp_476 = 0
        end
        local __lux_tmp_477 = shadowColor.g
        if __lux_tmp_477 == nil then
          __lux_tmp_477 = 0
        end
        local __lux_tmp_478 = shadowColor.b
        if __lux_tmp_478 == nil then
          __lux_tmp_478 = 0
        end
        local __lux_tmp_479
        if shadowSpec ~= nil then
          do
            local __lux_tmp_480 = shadowColor.a
            if __lux_tmp_480 == nil then
              __lux_tmp_480 = 255
            end
            __lux_tmp_479 = __lux_tmp_480 / 255
          end
        else
          __lux_tmp_479 = 0
        end
        local __lux_tmp_481
        if shadowSpec ~= nil then
          do
            local __lux_tmp_482 = toNumber(shadowSpec.width)
            if __lux_tmp_482 == nil then
              __lux_tmp_482 = 18
            end
            __lux_tmp_481 = mathMax(0.001, __lux_tmp_482)
          end
        else
          __lux_tmp_481 = 1
        end
        local __lux_tmp_483
        if shadowSpec ~= nil then
          do
            local __lux_tmp_484 = shadowSpec.strength
            if __lux_tmp_484 == nil then
              __lux_tmp_484 = shadowSpec.opacity
            end
            local __lux_tmp_485 = toNumber(__lux_tmp_484)
            if __lux_tmp_485 == nil then
              __lux_tmp_485 = 1
            end
            __lux_tmp_483 = mathMax(0, __lux_tmp_485)
          end
        else
          __lux_tmp_483 = 0
        end
        setupParamMatrix(
          material,
          drawX,
          drawY,
          w,
          h,
          packedKind,
          __lux_tmp_473,
          __lux_tmp_474,
          __lux_tmp_475,
          __lux_tmp_476 / 255,
          __lux_tmp_477 / 255,
          __lux_tmp_478 / 255,
          __lux_tmp_479,
          shadowX,
          shadowY,
          __lux_tmp_481,
          __lux_tmp_483
        )
      end
      local __lux_tmp_486 = outerColor.r
      if __lux_tmp_486 == nil then
        __lux_tmp_486 = 0
      end
      local __lux_tmp_487 = outerColor.g
      if __lux_tmp_487 == nil then
        __lux_tmp_487 = 0
      end
      local __lux_tmp_488 = outerColor.b
      if __lux_tmp_488 == nil then
        __lux_tmp_488 = 0
      end
      local __lux_tmp_489
      if outerSpec ~= nil then
        do
          local __lux_tmp_490 = outerColor.a
          if __lux_tmp_490 == nil then
            __lux_tmp_490 = 255
          end
          __lux_tmp_489 = __lux_tmp_490 / 255
        end
      else
        __lux_tmp_489 = 0
      end
      local __lux_tmp_491
      if outerSpec ~= nil then
        do
          local __lux_tmp_492 = toNumber(outerSpec.width)
          if __lux_tmp_492 == nil then
            __lux_tmp_492 = 18
          end
          __lux_tmp_491 = mathMax(0.001, __lux_tmp_492)
        end
      else
        __lux_tmp_491 = 1
      end
      local __lux_tmp_493
      if outerSpec ~= nil then
        do
          local __lux_tmp_494 = outerSpec.strength
          if __lux_tmp_494 == nil then
            __lux_tmp_494 = outerSpec.opacity
          end
          local __lux_tmp_495 = toNumber(__lux_tmp_494)
          if __lux_tmp_495 == nil then
            __lux_tmp_495 = 1
          end
          __lux_tmp_493 = mathMax(0, __lux_tmp_495)
        end
      else
        __lux_tmp_493 = 0
      end
      local __lux_tmp_496
      if shadowSpec ~= nil then
        do
          local __lux_tmp_497 = toNumber(shadowSpec.falloff)
          if __lux_tmp_497 == nil then
            __lux_tmp_497 = 1.8
          end
          __lux_tmp_496 = mathClamp(1 / mathMax(__lux_tmp_497, 0.001), 0.1, 1)
        end
      else
        __lux_tmp_496 = 1
      end
      local __lux_tmp_498
      if outerSpec ~= nil then
        do
          local __lux_tmp_499 = toNumber(outerSpec.falloff)
          if __lux_tmp_499 == nil then
            __lux_tmp_499 = 1.8
          end
          __lux_tmp_498 = mathClamp(1 / mathMax(__lux_tmp_499, 0.001), 0.1, 1)
        end
      else
        __lux_tmp_498 = 1
      end
      return setupAuxConstants(
        material,
        __lux_tmp_486 / 255,
        __lux_tmp_487 / 255,
        __lux_tmp_488 / 255,
        __lux_tmp_489,
        outerX,
        outerY,
        __lux_tmp_491,
        __lux_tmp_493,
        __lux_tmp_496,
        __lux_tmp_498,
        0,
        0,
        p0,
        p1,
        p2,
        p3
      )
    end
    drawImageMaskShadowOuter = function(x, y, w, h, mask, kind, shadow, outer)
      local __lux_tmp_500 = shadow == nil
      if __lux_tmp_500 then
        __lux_tmp_500 = outer == nil
      end
      local __lux_tmp_501 = __lux_tmp_500
      if not __lux_tmp_501 then
        __lux_tmp_501 = typeOf(mask) ~= "table"
      end
      local __lux_tmp_502 = __lux_tmp_501
      if not __lux_tmp_502 then
        __lux_tmp_502 = not shadersActive()
      end
      local __lux_tmp_503 = __lux_tmp_502
      if not __lux_tmp_503 then
        __lux_tmp_503 = not materialOK(widgetMaterials.image_mask_shadow_outer)
      end
      if __lux_tmp_503 then
        return false
      end
      do
        local __lux_tmp_504 = kind
        if __lux_tmp_504 == nil then
          __lux_tmp_504 = imageMaskKindValue(mask)
        end
        kind = __lux_tmp_504
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
        local __lux_tmp_505 = shadow ~= nil
        if __lux_tmp_505 then
          __lux_tmp_505 = shadow.color ~= nil
        end
        local __lux_tmp_506 = __lux_tmp_505
        if __lux_tmp_506 then
          local __lux_tmp_507 = shadow.color.a
          if __lux_tmp_507 == nil then
            __lux_tmp_507 = 255
          end
          __lux_tmp_506 = __lux_tmp_507 > 0
        end
        shadowValid = __lux_tmp_506
      end
      local outerValid
      do
        local __lux_tmp_508 = outer ~= nil
        if __lux_tmp_508 then
          __lux_tmp_508 = outer.color ~= nil
        end
        local __lux_tmp_509 = __lux_tmp_508
        if __lux_tmp_509 then
          local __lux_tmp_510 = outer.color.a
          if __lux_tmp_510 == nil then
            __lux_tmp_510 = 255
          end
          __lux_tmp_509 = __lux_tmp_510 > 0
        end
        outerValid = __lux_tmp_509
      end
      local __lux_tmp_511 = not shadowValid
      if __lux_tmp_511 then
        __lux_tmp_511 = not outerValid
      end
      if __lux_tmp_511 then
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
          local __lux_tmp_512 = shadow.x
          if __lux_tmp_512 == nil then
            local __lux_tmp_513 = shadow.offsetX
            if __lux_tmp_513 == nil then
              __lux_tmp_513 = shadow.dx
            end
            __lux_tmp_512 = __lux_tmp_513
          end
          local __lux_tmp_514 = toNumber(__lux_tmp_512)
          if __lux_tmp_514 == nil then
            __lux_tmp_514 = 0
          end
          shadowX = x + __lux_tmp_514 - shadowExtent
        end
      else
        shadowX = x
      end
      local shadowY
      if shadowValid then
        do
          local __lux_tmp_515 = shadow.y
          if __lux_tmp_515 == nil then
            local __lux_tmp_516 = shadow.offsetY
            if __lux_tmp_516 == nil then
              __lux_tmp_516 = shadow.dy
            end
            __lux_tmp_515 = __lux_tmp_516
          end
          local __lux_tmp_517 = toNumber(__lux_tmp_515)
          if __lux_tmp_517 == nil then
            __lux_tmp_517 = 0
          end
          shadowY = y + __lux_tmp_517 - shadowExtent
        end
      else
        shadowY = y
      end
      local outerX
      if outerValid then
        do
          local __lux_tmp_518 = outer.x
          if __lux_tmp_518 == nil then
            local __lux_tmp_519 = outer.offsetX
            if __lux_tmp_519 == nil then
              __lux_tmp_519 = outer.dx
            end
            __lux_tmp_518 = __lux_tmp_519
          end
          local __lux_tmp_520 = toNumber(__lux_tmp_518)
          if __lux_tmp_520 == nil then
            __lux_tmp_520 = 0
          end
          outerX = x + __lux_tmp_520 - outerExtent
        end
      else
        outerX = x
      end
      local outerY
      if outerValid then
        do
          local __lux_tmp_521 = outer.y
          if __lux_tmp_521 == nil then
            local __lux_tmp_522 = outer.offsetY
            if __lux_tmp_522 == nil then
              __lux_tmp_522 = outer.dy
            end
            __lux_tmp_521 = __lux_tmp_522
          end
          local __lux_tmp_523 = toNumber(__lux_tmp_521)
          if __lux_tmp_523 == nil then
            __lux_tmp_523 = 0
          end
          outerY = y + __lux_tmp_523 - outerExtent
        end
      else
        outerY = y
      end
      local sx
      do
        local __lux_tmp_524
        if shadowValid then
          __lux_tmp_524 = shadowX
        else
          __lux_tmp_524 = outerX
        end
        local __lux_tmp_525
        if outerValid then
          __lux_tmp_525 = outerX
        else
          __lux_tmp_525 = shadowX
        end
        sx = mathMin(__lux_tmp_524, __lux_tmp_525)
      end
      local sy
      do
        local __lux_tmp_526
        if shadowValid then
          __lux_tmp_526 = shadowY
        else
          __lux_tmp_526 = outerY
        end
        local __lux_tmp_527
        if outerValid then
          __lux_tmp_527 = outerY
        else
          __lux_tmp_527 = shadowY
        end
        sy = mathMin(__lux_tmp_526, __lux_tmp_527)
      end
      local ex
      do
        local __lux_tmp_528
        if shadowValid then
          __lux_tmp_528 = shadowX + w + shadowExtent * 2
        else
          __lux_tmp_528 = outerX + w + outerExtent * 2
        end
        local __lux_tmp_529
        if outerValid then
          __lux_tmp_529 = outerX + w + outerExtent * 2
        else
          __lux_tmp_529 = shadowX + w + shadowExtent * 2
        end
        ex = mathMax(__lux_tmp_528, __lux_tmp_529)
      end
      local ey
      do
        local __lux_tmp_530
        if shadowValid then
          __lux_tmp_530 = shadowY + h + shadowExtent * 2
        else
          __lux_tmp_530 = outerY + h + outerExtent * 2
        end
        local __lux_tmp_531
        if outerValid then
          __lux_tmp_531 = outerY + h + outerExtent * 2
        else
          __lux_tmp_531 = shadowY + h + shadowExtent * 2
        end
        ey = mathMax(__lux_tmp_530, __lux_tmp_531)
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
      local __lux_tmp_532 = mask ~= nil
      if __lux_tmp_532 then
        local __lux_tmp_533 = mask.invert
        if not __lux_tmp_533 then
          __lux_tmp_533 = mask.inverse
        end
        __lux_tmp_532 = __lux_tmp_533
      end
      if __lux_tmp_532 then
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
      local __lux_tmp_534 = vertical
      if __lux_tmp_534 then
        __lux_tmp_534 = 1
      end
      local __lux_tmp_535 = __lux_tmp_534
      if not __lux_tmp_535 then
        __lux_tmp_535 = 0
      end
      local __lux_tmp_536 = intensity
      if __lux_tmp_536 == nil then
        __lux_tmp_536 = 1
      end
      local __lux_tmp_537 = mask ~= nil
      if __lux_tmp_537 then
        __lux_tmp_537 = geometry.imageRadius(mask.radius, shapeW, shapeH)
      end
      local __lux_tmp_538 = __lux_tmp_537
      if not __lux_tmp_538 then
        __lux_tmp_538 = 0
      end
      return setupParamMatrix(
        material,
        __lux_tmp_535,
        __lux_tmp_536,
        drawW,
        drawH,
        shapeW,
        shapeH,
        packedKind,
        __lux_tmp_538,
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
      local __lux_tmp_539 = spec == nil
      if not __lux_tmp_539 then
        __lux_tmp_539 = typeOf(mask) ~= "table"
      end
      local __lux_tmp_540 = __lux_tmp_539
      if not __lux_tmp_540 then
        __lux_tmp_540 = kind == nil
      end
      if __lux_tmp_540 then
        return nil
      end
      local __lux_tmp_541 = imageMaskUsesTexture(kind)
      if __lux_tmp_541 then
        __lux_tmp_541 = maskTexture == nil
      end
      if __lux_tmp_541 then
        return nil
      end
      local pad
      do
        local __lux_tmp_542 = toNumber(spec.padding)
        if __lux_tmp_542 == nil then
          __lux_tmp_542 = 0
        end
        pad = mathMax(0, __lux_tmp_542)
      end
      local bx = x - pad
      local by = y - pad
      local bw = w + pad * 2
      local bh = h + pad * 2
      local __lux_tmp_543 = spec.blur > 0
      if __lux_tmp_543 then
        __lux_tmp_543 = widgetBlurRT ~= nil
      end
      local __lux_tmp_544 = __lux_tmp_543
      if __lux_tmp_544 then
        __lux_tmp_544 = renderCopyRenderTargetToTexture ~= nil
      end
      local __lux_tmp_545 = __lux_tmp_544
      if __lux_tmp_545 then
        __lux_tmp_545 = materialOK(widgetMaterials.image_mask_backdrop)
      end
      if __lux_tmp_545 then
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
      local __lux_tmp_546 = tint ~= nil
      if __lux_tmp_546 then
        __lux_tmp_546 = materialOK(widgetMaterials.image_mask_backdrop_fill)
      end
      if __lux_tmp_546 then
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
        local __lux_tmp_547 = kind
        if __lux_tmp_547 == nil then
          __lux_tmp_547 = imageMaskKindValue(mask)
        end
        kind = __lux_tmp_547
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
        local __lux_tmp_548 = drawStyle.fill
        if __lux_tmp_548 == nil then
          __lux_tmp_548 = drawStyle.background
        end
        background = __lux_tmp_548
      end
      local __lux_tmp_549 = background ~= nil
      if __lux_tmp_549 then
        __lux_tmp_549 = background.r ~= nil
      end
      local __lux_tmp_550 = __lux_tmp_549
      if __lux_tmp_550 then
        local __lux_tmp_551 = background.a == nil
        if not __lux_tmp_551 then
          __lux_tmp_551 = background.a > 0
        end
        __lux_tmp_550 = __lux_tmp_551
      end
      if __lux_tmp_550 then
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
      do
        local __lux_tmp_552 = material
        if __lux_tmp_552 == nil then
          __lux_tmp_552 = imageFallbackMaterialForTexture(texture)
        end
        material = __lux_tmp_552
      end
      if material == nil then
        return
      end
      local u0, v0, u1, v1 = geometry.imageUV(drawStyle, texture)
      x, y, w, h, u0, v0, u1, v1 = geometry.imageFitRect(x, y, w, h, texture, drawStyle, u0, v0, u1, v1)
      local __lux_tmp_553 = w <= 0
      if not __lux_tmp_553 then
        __lux_tmp_553 = h <= 0
      end
      if __lux_tmp_553 then
        return
      end
      local radius = geometry.imageRadius(drawStyle.radius, w, h)
      local background
      do
        local __lux_tmp_554 = drawStyle.fill
        if __lux_tmp_554 == nil then
          __lux_tmp_554 = drawStyle.background
        end
        background = __lux_tmp_554
      end
      local __lux_tmp_555 = background ~= nil
      if __lux_tmp_555 then
        local __lux_tmp_556 = background.a
        if __lux_tmp_556 == nil then
          __lux_tmp_556 = 255
        end
        __lux_tmp_555 = __lux_tmp_556 > 0
      end
      if __lux_tmp_555 then
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
      local background
      do
        local __lux_tmp_557 = drawStyle.fill
        if __lux_tmp_557 == nil then
          __lux_tmp_557 = drawStyle.background
        end
        background = __lux_tmp_557
      end
      local __lux_tmp_558 = background ~= nil
      if __lux_tmp_558 then
        local __lux_tmp_559 = background.a
        if __lux_tmp_559 == nil then
          __lux_tmp_559 = 255
        end
        __lux_tmp_558 = __lux_tmp_559 > 0
      end
      if __lux_tmp_558 then
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
      local __lux_match_560 = maskKind
      if __lux_match_560 == 2 or __lux_match_560 == 3 then
        return mathMin(w, h) * 0.5
      elseif __lux_match_560 == 0 then
        local __lux_tmp_561 = mask ~= nil
        if __lux_tmp_561 then
          __lux_tmp_561 = mask.radius ~= nil
        end
        if __lux_tmp_561 then
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
      local __lux_tmp_562 = shadow ~= nil
      if not __lux_tmp_562 then
        __lux_tmp_562 = outer ~= nil
      end
      local __lux_tmp_563 = __lux_tmp_562
      if not __lux_tmp_563 then
        __lux_tmp_563 = backdrop ~= nil
      end
      return __lux_tmp_563
    end
    drawImageRoundRectShader = function(x, y, w, h, texture, u0, v0, u1, v1, drawStyle, radius)
      local material = widgetMaterials.roundrect_texture
      if not materialOK(material) then
        return false
      end
      material:SetTexture("$basetexture", texture)
      local stroke
      do
        local __lux_tmp_564 = drawStyle.stroke
        if __lux_tmp_564 == nil then
          __lux_tmp_564 = transparentColor
        end
        stroke = __lux_tmp_564
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
      local __lux_tmp_565 = not shadersActive()
      if not __lux_tmp_565 then
        __lux_tmp_565 = not materialOK(widgetMaterials.roundrect_texture)
      end
      if __lux_tmp_565 then
        drawImageFallback(x, y, w, h, source, resolved)
        return
      end
      local u0, v0, u1, v1 = geometry.imageUV(resolved, texture)
      x, y, w, h, u0, v0, u1, v1 = geometry.imageFitRect(x, y, w, h, texture, resolved, u0, v0, u1, v1)
      local __lux_tmp_566 = w <= 0
      if not __lux_tmp_566 then
        __lux_tmp_566 = h <= 0
      end
      if __lux_tmp_566 then
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
        local backdropMaskKind
        do
          local __lux_tmp_567 = imageMaskTextureChannelKind(mask.channel)
          if __lux_tmp_567 == nil then
            __lux_tmp_567 = maskKind
          end
          backdropMaskKind = __lux_tmp_567
        end
        local __lux_tmp_568 = shadow ~= nil
        if not __lux_tmp_568 then
          __lux_tmp_568 = outer ~= nil
        end
        if __lux_tmp_568 then
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
      local __lux_tmp_569 = cuts ~= nil
      if __lux_tmp_569 then
        __lux_tmp_569 = drawImageChamfer(x, y, w, h, texture, u0, v0, u1, v1, resolved, cuts)
      end
      if __lux_tmp_569 then
        return
      end
      local radius = imageRoundedRadius(resolved, mask, maskKind, w, h)
      local __lux_tmp_570 = resolved.shadow ~= nil
      if not __lux_tmp_570 then
        __lux_tmp_570 = resolved.outerGlow ~= nil
      end
      if __lux_tmp_570 then
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
        local __lux_tmp_571 = resolved.fill
        if __lux_tmp_571 == nil then
          __lux_tmp_571 = resolved.background
        end
        background = __lux_tmp_571
      end
      local __lux_tmp_572 = background ~= nil
      if __lux_tmp_572 then
        local __lux_tmp_573 = background.a
        if __lux_tmp_573 == nil then
          __lux_tmp_573 = 255
        end
        __lux_tmp_572 = __lux_tmp_573 > 0
      end
      if __lux_tmp_572 then
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
      local __lux_tmp_574 = resolved.fit == nil
      if __lux_tmp_574 then
        __lux_tmp_574 = resolved.objectFit == nil
      end
      if __lux_tmp_574 then
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
