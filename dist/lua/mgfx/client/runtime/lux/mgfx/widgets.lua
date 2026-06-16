return function(__lux_import)
  local __lux_exports = {}
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
  local hasTransform
  local paramMatrixProbe
  local paramMatrixSetUnpacked
  local paramMatrices
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
  local progressFxBits
  local progressFillCanFast
  local canDrawProgressFast
  local setupProgressConstants
  local setupProgressFxConstants
  local drawProgressFast
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
  local drawRingOuterGlowPass
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
  local imageBackdropTintColor
  local setupImageMaskBackdropConstants
  local drawImageMaskBackdrop
  local drawImageMaskShader
  local drawImageMaskOuterGlow
  local drawImageFallback
  local drawImageChamfer
  local imageRoundedRadius
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
    local __lux_import_1 = __lux_import("lux/mgfx/geometry#client")
    local geometryImport = __lux_import_1
    local __lux_import_2 = __lux_import("lux/mgfx/paint#client")
    local paintImport = __lux_import_2
    local __lux_import_3 = __lux_import("lux/mgfx/primitives#client")
    local primitivesImport = __lux_import_3
    local __lux_import_4 = __lux_import("lux/mgfx/roundrect#client")
    local roundrectImport = __lux_import_4
    local __lux_import_5 = __lux_import("lux/mgfx/style#client")
    local styleImport = __lux_import_5
    local __lux_import_6 = __lux_import("lux/mgfx/text#client")
    local textImport = __lux_import_6
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
    hasTransform = geometry.hasTransform
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
    progressStyle = {}
    segmentStyle = {}
    ringStyle = {}
    arcStyle = {}
    sectorStyle = {}
    imageStyleScratch = {}
    iconStyleScratch = {}
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
    setupAuxConstants = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3)
      if material == nil then
        return false
      end
      do
        local __lux_tmp_48 = a0
        if __lux_tmp_48 == nil then
          __lux_tmp_48 = 0
        end
        material:SetFloat("$c0_x", __lux_tmp_48)
      end
      do
        local __lux_tmp_49 = a1
        if __lux_tmp_49 == nil then
          __lux_tmp_49 = 0
        end
        material:SetFloat("$c0_y", __lux_tmp_49)
      end
      do
        local __lux_tmp_50 = a2
        if __lux_tmp_50 == nil then
          __lux_tmp_50 = 0
        end
        material:SetFloat("$c0_z", __lux_tmp_50)
      end
      do
        local __lux_tmp_51 = a3
        if __lux_tmp_51 == nil then
          __lux_tmp_51 = 0
        end
        material:SetFloat("$c0_w", __lux_tmp_51)
      end
      do
        local __lux_tmp_52 = b0
        if __lux_tmp_52 == nil then
          __lux_tmp_52 = 0
        end
        material:SetFloat("$c1_x", __lux_tmp_52)
      end
      do
        local __lux_tmp_53 = b1
        if __lux_tmp_53 == nil then
          __lux_tmp_53 = 0
        end
        material:SetFloat("$c1_y", __lux_tmp_53)
      end
      do
        local __lux_tmp_54 = b2
        if __lux_tmp_54 == nil then
          __lux_tmp_54 = 0
        end
        material:SetFloat("$c1_z", __lux_tmp_54)
      end
      do
        local __lux_tmp_55 = b3
        if __lux_tmp_55 == nil then
          __lux_tmp_55 = 0
        end
        material:SetFloat("$c1_w", __lux_tmp_55)
      end
      do
        local __lux_tmp_56 = c0
        if __lux_tmp_56 == nil then
          __lux_tmp_56 = 0
        end
        material:SetFloat("$c2_x", __lux_tmp_56)
      end
      do
        local __lux_tmp_57 = c1
        if __lux_tmp_57 == nil then
          __lux_tmp_57 = 0
        end
        material:SetFloat("$c2_y", __lux_tmp_57)
      end
      do
        local __lux_tmp_58 = c2
        if __lux_tmp_58 == nil then
          __lux_tmp_58 = 0
        end
        material:SetFloat("$c2_z", __lux_tmp_58)
      end
      do
        local __lux_tmp_59 = c3
        if __lux_tmp_59 == nil then
          __lux_tmp_59 = 0
        end
        material:SetFloat("$c2_w", __lux_tmp_59)
      end
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
        local __lux_tmp_60 = typeOf(drawStyle.fx) == "table"
        if __lux_tmp_60 then
          __lux_tmp_60 = drawStyle.fx
        end
        local __lux_tmp_61 = __lux_tmp_60
        if not __lux_tmp_61 then
          __lux_tmp_61 = nil
        end
        fx = __lux_tmp_61
      end
      if fx == nil then
        return false, false, false, 0
      end
      local glow
      do
        local __lux_tmp_62 = fx.glow == true
        if not __lux_tmp_62 then
          __lux_tmp_62 = typeOf(fx.glow) == "table"
        end
        glow = __lux_tmp_62
      end
      local sheen
      do
        local __lux_tmp_63 = fx.sheen == true
        if not __lux_tmp_63 then
          __lux_tmp_63 = typeOf(fx.sheen) == "table"
        end
        sheen = __lux_tmp_63
      end
      local marker
      do
        local __lux_tmp_64 = fx.marker == true
        if not __lux_tmp_64 then
          __lux_tmp_64 = typeOf(fx.marker) == "table"
        end
        marker = __lux_tmp_64
      end
      local ticks = 0
      local tickSpec = fx.ticks
      if typeOf(tickSpec) == "number" then
        ticks = tickSpec
      else
        if typeOf(tickSpec) == "table" then
          do
            local __lux_tmp_65 = tickSpec.count
            if __lux_tmp_65 == nil then
              __lux_tmp_65 = 0
            end
            ticks = __lux_tmp_65
          end
        end
      end
      local __lux_tmp_66 = toNumber(ticks)
      if __lux_tmp_66 == nil then
        __lux_tmp_66 = 0
      end
      return glow, sheen, marker, mathClamp(mathFloor(__lux_tmp_66), 0, 31)
    end
  end
  do
    progressFxBits = function(drawStyle)
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
        return 0, 0
      end
      local flags = 0
      local __lux_tmp_69 = fx.glow == true
      if not __lux_tmp_69 then
        __lux_tmp_69 = typeOf(fx.glow) == "table"
      end
      if __lux_tmp_69 then
        flags = flags + 1
      end
      local __lux_tmp_70 = fx.sheen == true
      if not __lux_tmp_70 then
        __lux_tmp_70 = typeOf(fx.sheen) == "table"
      end
      if __lux_tmp_70 then
        flags = flags + 2
      end
      local __lux_tmp_71 = fx.marker == true
      if not __lux_tmp_71 then
        __lux_tmp_71 = typeOf(fx.marker) == "table"
      end
      if __lux_tmp_71 then
        flags = flags + 4
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
      return flags, mathClamp(mathFloor(__lux_tmp_73), 0, 31)
    end
    progressFillCanFast = function(fill)
      local __lux_match_74 = fill
      local __lux_tag_75
      if __lux_match_74 ~= nil then
        __lux_tag_75 = __lux_match_74.kind
      end
      if __lux_tag_75 == style.FILL_SOLID then
        return true
      elseif __lux_tag_75 == style.FILL_LINEAR then
        local x1 = __lux_match_74.x1
        local y1 = __lux_match_74.y1
        local x2 = __lux_match_74.x2
        local y2 = __lux_match_74.y2
        local __lux_tmp_76 = x1
        if __lux_tmp_76 == nil then
          __lux_tmp_76 = 0
        end
        local __lux_tmp_77 = __lux_tmp_76 == 0
        if __lux_tmp_77 then
          local __lux_tmp_78 = y1
          if __lux_tmp_78 == nil then
            __lux_tmp_78 = 0
          end
          __lux_tmp_77 = __lux_tmp_78 == 0
        end
        local __lux_tmp_79 = __lux_tmp_77
        if __lux_tmp_79 then
          local __lux_tmp_80 = x2
          if __lux_tmp_80 == nil then
            __lux_tmp_80 = 1
          end
          __lux_tmp_79 = __lux_tmp_80 == 1
        end
        local __lux_tmp_81 = __lux_tmp_79
        if __lux_tmp_81 then
          local __lux_tmp_82 = y2
          if __lux_tmp_82 == nil then
            __lux_tmp_82 = 0
          end
          __lux_tmp_81 = __lux_tmp_82 == 0
        end
        return __lux_tmp_81
      else
        return false
      end
    end
    canDrawProgressFast = function(fill, drawStyle, inset, strokeWidth, flags, ticks, fxMat)
      local __lux_tmp_83 = not shadersActive()
      if not __lux_tmp_83 then
        __lux_tmp_83 = not materialOK(fxMat)
      end
      if __lux_tmp_83 then
        return false
      end
      local __lux_tmp_84 = drawStyle.shadow ~= nil
      if not __lux_tmp_84 then
        __lux_tmp_84 = drawStyle.backdrop ~= nil
      end
      local __lux_tmp_85 = __lux_tmp_84
      if not __lux_tmp_85 then
        __lux_tmp_85 = drawStyle.outerGlow ~= nil
      end
      local __lux_tmp_86 = __lux_tmp_85
      if not __lux_tmp_86 then
        __lux_tmp_86 = drawStyle.innerGlow ~= nil
      end
      local __lux_tmp_87 = __lux_tmp_86
      if not __lux_tmp_87 then
        __lux_tmp_87 = drawStyle.pattern ~= nil
      end
      local __lux_tmp_88 = __lux_tmp_87
      if not __lux_tmp_88 then
        __lux_tmp_88 = drawStyle.fillPattern ~= nil
      end
      local __lux_tmp_89 = __lux_tmp_88
      if not __lux_tmp_89 then
        __lux_tmp_89 = drawStyle.trackPattern ~= nil
      end
      if __lux_tmp_89 then
        return false
      end
      local __lux_tmp_90 = inset ~= mathFloor(inset)
      if not __lux_tmp_90 then
        __lux_tmp_90 = strokeWidth ~= mathFloor(strokeWidth)
      end
      if __lux_tmp_90 then
        return false
      end
      local __lux_tmp_91 = inset < 0
      if not __lux_tmp_91 then
        __lux_tmp_91 = inset > 31
      end
      local __lux_tmp_92 = __lux_tmp_91
      if not __lux_tmp_92 then
        __lux_tmp_92 = strokeWidth < 0
      end
      local __lux_tmp_93 = __lux_tmp_92
      if not __lux_tmp_93 then
        __lux_tmp_93 = strokeWidth > 15
      end
      if __lux_tmp_93 then
        return false
      end
      if not progressFillCanFast(fill) then
        return false
      end
      local __lux_tmp_94 = fxMat == widgetMaterials.progress
      if __lux_tmp_94 then
        local __lux_tmp_95 = flags ~= 0
        if not __lux_tmp_95 then
          __lux_tmp_95 = ticks > 1
        end
        __lux_tmp_94 = __lux_tmp_95
      end
      if __lux_tmp_94 then
        return false
      end
      return true
    end
    setupProgressConstants = function(material, w, h, value, radius, inset, track, fill, stroke, strokeWidth)
      local fillA
      do
        local __lux_tmp_96 = fill.colorA
        if __lux_tmp_96 == nil then
          __lux_tmp_96 = color_white
        end
        fillA = __lux_tmp_96
      end
      local fillB
      do
        local __lux_tmp_97 = fill.colorB
        if __lux_tmp_97 == nil then
          __lux_tmp_97 = fillA
        end
        fillB = __lux_tmp_97
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
        local __lux_tmp_98 = stroke
        if __lux_tmp_98 == nil then
          __lux_tmp_98 = transparentColor
        end
        r, g, b, a = style.color01(__lux_tmp_98)
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
        local __lux_tmp_99 = fill.colorA
        if __lux_tmp_99 == nil then
          __lux_tmp_99 = color_white
        end
        fillA = __lux_tmp_99
      end
      local fillB
      do
        local __lux_tmp_100 = fill.colorB
        if __lux_tmp_100 == nil then
          __lux_tmp_100 = fillA
        end
        fillB = __lux_tmp_100
      end
      do
        local __lux_tmp_101 = toNumber(flags)
        if __lux_tmp_101 == nil then
          __lux_tmp_101 = 0
        end
        flags = mathClamp(mathFloor(__lux_tmp_101), 0, 7)
      end
      do
        local __lux_tmp_102 = toNumber(ticks)
        if __lux_tmp_102 == nil then
          __lux_tmp_102 = 0
        end
        ticks = mathClamp(mathFloor(__lux_tmp_102), 0, 31)
      end
      do
        local __lux_tmp_103 = toNumber(radius)
        if __lux_tmp_103 == nil then
          __lux_tmp_103 = 0
        end
        radius = mathClamp(__lux_tmp_103, 0, 255)
      end
      do
        local __lux_tmp_104 = toNumber(inset)
        if __lux_tmp_104 == nil then
          __lux_tmp_104 = 0
        end
        inset = mathClamp(mathFloor(__lux_tmp_104), 0, 31)
      end
      do
        local __lux_tmp_105 = toNumber(strokeWidth)
        if __lux_tmp_105 == nil then
          __lux_tmp_105 = 0
        end
        strokeWidth = mathClamp(mathFloor(__lux_tmp_105), 0, 15)
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
        local __lux_tmp_106 = stroke
        if __lux_tmp_106 == nil then
          __lux_tmp_106 = transparentColor
        end
        r, g, b, a = style.color01(__lux_tmp_106)
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
        local __lux_tmp_107 = flags ~= 0
        if not __lux_tmp_107 then
          __lux_tmp_107 = ticks > 1
        end
        if __lux_tmp_107 then
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
      drawTexturedQuad(x, y, w, h)
      return true
    end
    segmentFillEndpoints = function(fill)
      local __lux_tmp_108 = fill.stops ~= nil
      if __lux_tmp_108 then
        __lux_tmp_108 = #fill.stops > 0
      end
      if __lux_tmp_108 then
        local first = nil
        local last = nil
        for _, stop in ipairs(fill.stops) do
          local color
          do
            local __lux_tmp_109 = stop.color
            if __lux_tmp_109 == nil then
              __lux_tmp_109 = stop[2]
            end
            color = __lux_tmp_109
          end
          local __lux_tmp_110 = color ~= nil
          if __lux_tmp_110 then
            local __lux_tmp_111 = color.a == nil
            if not __lux_tmp_111 then
              __lux_tmp_111 = color.a > 0
            end
            __lux_tmp_110 = __lux_tmp_111
          end
          if __lux_tmp_110 then
            do
              local __lux_tmp_112 = first
              if __lux_tmp_112 == nil then
                __lux_tmp_112 = color
              end
              first = __lux_tmp_112
            end
            last = color
          end
        end
        local __lux_tmp_113 = first ~= nil
        if __lux_tmp_113 then
          __lux_tmp_113 = last ~= nil
        end
        if __lux_tmp_113 then
          return first, last
        end
      end
      local __lux_tmp_114 = fill.colorA
      if __lux_tmp_114 == nil then
        __lux_tmp_114 = color_white
      end
      local __lux_tmp_115 = fill.colorB
      if __lux_tmp_115 == nil then
        local __lux_tmp_116 = fill.colorA
        if __lux_tmp_116 == nil then
          __lux_tmp_116 = color_white
        end
        __lux_tmp_115 = __lux_tmp_116
      end
      return __lux_tmp_114, __lux_tmp_115
    end
    drawSegmentBarShader = function(x, y, w, h, value, drawStyle, count, gap, fill, track)
      local __lux_tmp_117 = not shadersActive()
      if not __lux_tmp_117 then
        __lux_tmp_117 = not materialOK(widgetMaterials.segmentbar)
      end
      if __lux_tmp_117 then
        return false
      end
      if drawStyle.background ~= nil then
        return false
      end
      if style.strokeVisible(drawStyle.stroke, drawStyle.strokeWidth) then
        return false
      end
      local __lux_tmp_118 = drawStyle.outerGlow ~= nil
      if not __lux_tmp_118 then
        __lux_tmp_118 = drawStyle.innerGlow ~= nil
      end
      local __lux_tmp_119 = __lux_tmp_118
      if not __lux_tmp_119 then
        __lux_tmp_119 = drawStyle.pattern ~= nil
      end
      local __lux_tmp_120 = __lux_tmp_119
      if not __lux_tmp_120 then
        __lux_tmp_120 = drawStyle.fillPattern ~= nil
      end
      local __lux_tmp_121 = __lux_tmp_120
      if not __lux_tmp_121 then
        __lux_tmp_121 = drawStyle.trackPattern ~= nil
      end
      if __lux_tmp_121 then
        return false
      end
      local totalGap = gap * (count - 1)
      local segmentW = (w - totalGap) / count
      local __lux_tmp_122 = segmentW <= 0
      if not __lux_tmp_122 then
        __lux_tmp_122 = h <= 0
      end
      if __lux_tmp_122 then
        return true
      end
      local trackColor = style.asColor(track, defaultSegmentTrack)
      local fillA, fillB = segmentFillEndpoints(fill)
      local hasFill = style.fillVisible(fill)
      local hasTrack
      do
        local __lux_tmp_123 = trackColor.a == nil
        if not __lux_tmp_123 then
          __lux_tmp_123 = trackColor.a > 0
        end
        hasTrack = __lux_tmp_123
      end
      local __lux_tmp_124 = not hasFill
      if __lux_tmp_124 then
        __lux_tmp_124 = not hasTrack
      end
      if __lux_tmp_124 then
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
        local __lux_tmp_125 = toNumber(value)
        if __lux_tmp_125 == nil then
          __lux_tmp_125 = 0
        end
        local __lux_tmp_126
        if drawStyle.radius == nil then
          __lux_tmp_126 = mathMin(2, h * 0.35)
        else
          __lux_tmp_126 = drawStyle.radius
        end
        local __lux_tmp_127 = toNumber(__lux_tmp_126)
        if __lux_tmp_127 == nil then
          __lux_tmp_127 = 0
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
          mathClamp(__lux_tmp_125, 0, 1),
          mathMax(0, __lux_tmp_127),
          0,
          0
        )
      end
      style.bindGradientLut(material, fill)
      style.setDrawColor(fillA)
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h)
      return true
    end
    progressBarEx = function(x, y, w, h, value, drawStyle)
      local resolved
      do
        local __lux_tmp_128 = drawStyle
        if __lux_tmp_128 == nil then
          __lux_tmp_128 = {}
        end
        resolved = __lux_tmp_128
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
        local __lux_tmp_129 = toNumber(value)
        if __lux_tmp_129 == nil then
          __lux_tmp_129 = 0
        end
        frac = mathClamp(__lux_tmp_129, 0, 1)
      end
      local radius
      do
        local __lux_tmp_130 = stripped.radius
        if __lux_tmp_130 == nil then
          __lux_tmp_130 = mathMin(4, h * 0.5)
        end
        radius = __lux_tmp_130
      end
      local inset
      do
        local __lux_tmp_131 = toNumber(stripped.padding)
        if __lux_tmp_131 == nil then
          __lux_tmp_131 = 0
        end
        inset = mathMax(0, __lux_tmp_131)
      end
      local track
      do
        local __lux_tmp_132 = stripped.track
        if __lux_tmp_132 == nil then
          __lux_tmp_132 = defaultProgressTrack
        end
        track = __lux_tmp_132
      end
      local fill
      do
        local __lux_tmp_133 = stripped.fill
        if __lux_tmp_133 == nil then
          __lux_tmp_133 = color_white
        end
        fill = __lux_tmp_133
      end
      local stroke
      do
        local __lux_tmp_134 = stripped.stroke
        if __lux_tmp_134 == nil then
          __lux_tmp_134 = defaultProgressStroke
        end
        stroke = __lux_tmp_134
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
        local __lux_tmp_135 = track.r
        if __lux_tmp_135 == nil then
          __lux_tmp_135 = 0
        end
        local __lux_tmp_136 = track.g
        if __lux_tmp_136 == nil then
          __lux_tmp_136 = 0
        end
        local __lux_tmp_137 = track.b
        if __lux_tmp_137 == nil then
          __lux_tmp_137 = 0
        end
        local __lux_tmp_138 = track.a
        if __lux_tmp_138 == nil then
          __lux_tmp_138 = 190
        end
        roundrect.roundedBoxEx(
          x,
          y,
          w,
          h,
          {
            radius = radius,
            fill = style.linearGradient(
              0,
              0,
              0,
              1,
              makeColor(
                mathFloor(__lux_tmp_135 * 0.65),
                mathFloor(__lux_tmp_136 * 0.65),
                mathFloor(__lux_tmp_137 * 0.65),
                __lux_tmp_138
              ),
              track
            ),
            stroke = stroke,
            strokeWidth = strokeWidth,
            outerGlow = stripped.outerGlow,
            innerGlow = stripped.innerGlow,
            pattern = stripped.trackPattern,
          }
        )
      end
      local innerH = h - inset * 2
      local innerW = (w - inset * 2) * frac
      if frac >= 0.999 then
        innerW = w - inset * 2
      end
      if ticks > 1 then
        local tickColor = makeColor(255, 255, 255, 18)
        for index = 1, ticks - 1 do
          local tx = x + mathFloor(w * index / ticks)
          roundrect.roundedBoxEx(
            tx,
            y + 3,
            1,
            mathMax(1, h - 6),
            { radius = 0, fill = tickColor }
          )
        end
      end
      local __lux_tmp_139 = innerH <= 0
      if not __lux_tmp_139 then
        __lux_tmp_139 = innerW <= 0
      end
      if __lux_tmp_139 then
        return
      end
      local __lux_tmp_140 = glow
      if __lux_tmp_140 then
        __lux_tmp_140 = innerW > 4
      end
      if __lux_tmp_140 then
        roundrect.roundedBoxEx(
          x + inset - 2,
          y + inset - 2,
          innerW + 4,
          innerH + 4,
          {
            radius = mathMin(radius + 2, (innerH + 4) * 0.5, (innerW + 4) * 0.5),
            fill = makeColor(80, 190, 255, 38),
          }
        )
      end
      do
        local __lux_tmp_141 = stripped.fillPattern
        if __lux_tmp_141 == nil then
          __lux_tmp_141 = stripped.pattern
        end
        roundrect.roundedBoxEx(
          x + inset,
          y + inset,
          innerW,
          innerH,
          {
            radius = mathMin(mathMax(0, radius - inset), innerH * 0.5, innerW * 0.5),
            fill = fill,
            pattern = __lux_tmp_141,
          }
        )
      end
      local __lux_tmp_142 = sheen
      if __lux_tmp_142 then
        __lux_tmp_142 = innerW > 8
      end
      if __lux_tmp_142 then
        roundrect.roundedBoxEx(
          x + inset + 1,
          y + inset + 1,
          mathMax(1, innerW - 2),
          mathMax(1, innerH * 0.38),
          {
            radius = mathMin(radius, innerH * 0.25),
            fill = style.linearGradient(
              0,
              0,
              0,
              1,
              makeColor(255, 255, 255, 42),
              makeColor(255, 255, 255, 0)
            ),
          }
        )
      end
      local __lux_tmp_143 = marker
      if __lux_tmp_143 then
        __lux_tmp_143 = innerW > 5
      end
      if __lux_tmp_143 then
        local mx = x + inset + innerW - 2
        roundrect.roundedBoxEx(
          mx,
          y + 2,
          2,
          h - 4,
          { radius = 1, fill = makeColor(255, 255, 255, 96) }
        )
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
        local __lux_tmp_144 = drawStyle
        if __lux_tmp_144 == nil then
          __lux_tmp_144 = {}
        end
        resolved = __lux_tmp_144
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
        local __lux_tmp_145 = toNumber(stripped.segments)
        if __lux_tmp_145 == nil then
          __lux_tmp_145 = 10
        end
        count = mathClamp(mathFloor(__lux_tmp_145), 1, 128)
      end
      local gap
      do
        local __lux_tmp_146 = toNumber(stripped.gap)
        if __lux_tmp_146 == nil then
          __lux_tmp_146 = 2
        end
        gap = mathMax(0, __lux_tmp_146)
      end
      local frac
      do
        local __lux_tmp_147 = toNumber(value)
        if __lux_tmp_147 == nil then
          __lux_tmp_147 = 0
        end
        frac = mathClamp(__lux_tmp_147, 0, 1)
      end
      local active = mathFloor(frac * count + 0.0001)
      local fill
      do
        local __lux_tmp_148 = stripped.fill
        if __lux_tmp_148 == nil then
          local __lux_tmp_149 = stripped.color
          if __lux_tmp_149 == nil then
            __lux_tmp_149 = defaultSegmentFill
          end
          __lux_tmp_148 = __lux_tmp_149
        end
        fill = style.fillFromStyle(__lux_tmp_148)
      end
      local track
      do
        local __lux_tmp_150 = stripped.track
        if __lux_tmp_150 == nil then
          __lux_tmp_150 = defaultSegmentTrack
        end
        track = __lux_tmp_150
      end
      if drawSegmentBarShader(x, y, w, h, frac, stripped, count, gap, fill, track) then
        return
      end
      local totalGap = gap * (count - 1)
      local segmentW = (w - totalGap) / count
      local __lux_tmp_151 = segmentW <= 0
      if not __lux_tmp_151 then
        __lux_tmp_151 = h <= 0
      end
      if __lux_tmp_151 then
        return
      end
      local containerRadius
      do
        local __lux_tmp_152 = stripped.backgroundRadius
        if __lux_tmp_152 == nil then
          local __lux_tmp_153 = stripped.radius
          if __lux_tmp_153 == nil then
            __lux_tmp_153 = mathMin(3, h * 0.5)
          end
          __lux_tmp_152 = __lux_tmp_153
        end
        containerRadius = __lux_tmp_152
      end
      local __lux_tmp_154 = stripped.outerGlow ~= nil
      if not __lux_tmp_154 then
        __lux_tmp_154 = stripped.innerGlow ~= nil
      end
      local __lux_tmp_155 = __lux_tmp_154
      if not __lux_tmp_155 then
        __lux_tmp_155 = stripped.background ~= nil
      end
      if __lux_tmp_155 then
        do
          local __lux_tmp_156 = stripped.background
          if __lux_tmp_156 == nil then
            __lux_tmp_156 = transparentColor
          end
          roundrect.roundedBoxEx(
            x,
            y,
            w,
            h,
            {
              radius = containerRadius,
              fill = __lux_tmp_156,
              outerGlow = stripped.outerGlow,
              innerGlow = stripped.innerGlow,
            }
          )
        end
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
        local pattern
        if filled then
          do
            local __lux_tmp_157 = stripped.fillPattern
            if __lux_tmp_157 == nil then
              __lux_tmp_157 = stripped.pattern
            end
            pattern = __lux_tmp_157
          end
        else
          pattern = stripped.trackPattern
        end
        local __lux_tmp_158 = color ~= nil
        if not __lux_tmp_158 then
          __lux_tmp_158 = pattern ~= nil
        end
        if __lux_tmp_158 then
          do
            local __lux_tmp_159
            if stripped.radius == nil then
              __lux_tmp_159 = mathMin(2, h * 0.35)
            else
              __lux_tmp_159 = stripped.radius
            end
            local __lux_tmp_160 = color
            if __lux_tmp_160 == nil then
              __lux_tmp_160 = transparentColor
            end
            local __lux_tmp_161 = stripped.strokeWidth
            if __lux_tmp_161 == nil then
              __lux_tmp_161 = 0
            end
            roundrect.roundedBoxEx(
              sx,
              y,
              segmentW,
              h,
              {
                radius = __lux_tmp_159,
                fill = __lux_tmp_160,
                pattern = pattern,
                stroke = stripped.stroke,
                strokeWidth = __lux_tmp_161,
              }
            )
          end
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
        local __lux_tmp_162 = endDeg
        if __lux_tmp_162 == nil then
          __lux_tmp_162 = 360
        end
        local __lux_tmp_163 = startDeg
        if __lux_tmp_163 == nil then
          __lux_tmp_163 = 0
        end
        sweep = mathAbs(__lux_tmp_162 - __lux_tmp_163)
      end
      return mathClamp(mathFloor(sweep / 360 * fallback), 3, fallback)
    end
    ringModeValue = function(mode)
      local __lux_match_164 = mode
      if __lux_match_164 == "sector" or __lux_match_164 == 2 then
        return 2
      elseif __lux_match_164 == "arc" or __lux_match_164 == true or __lux_match_164 == 1 then
        return 1
      else
        return 0
      end
    end
    ringShapeConstants = function(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      local __lux_tmp_165 = toNumber(innerRadius)
      if __lux_tmp_165 == nil then
        __lux_tmp_165 = 0
      end
      local __lux_tmp_166 = toNumber(outerRadius)
      if __lux_tmp_166 == nil then
        __lux_tmp_166 = mathMin(w, h) * 0.5
      end
      local __lux_tmp_167 = toNumber(startDeg)
      if __lux_tmp_167 == nil then
        __lux_tmp_167 = 0
      end
      local __lux_tmp_168 = toNumber(endDeg)
      if __lux_tmp_168 == nil then
        __lux_tmp_168 = 360
      end
      return w, h, mathMax(0, __lux_tmp_165), mathMax(0.001, __lux_tmp_166), mathRad(__lux_tmp_167), mathRad(__lux_tmp_168), ringModeValue(mode)
    end
    ringFillParams = function(fill)
      local __lux_match_169 = fill
      local __lux_tag_170
      if __lux_match_169 ~= nil then
        __lux_tag_170 = __lux_match_169.kind
      end
      if __lux_tag_170 == style.FILL_LINEAR then
        local x1 = __lux_match_169.x1
        local y1 = __lux_match_169.y1
        local x2 = __lux_match_169.x2
        local y2 = __lux_match_169.y2
        local __lux_tmp_171 = x1
        if __lux_tmp_171 == nil then
          __lux_tmp_171 = 0
        end
        local __lux_tmp_172 = y1
        if __lux_tmp_172 == nil then
          __lux_tmp_172 = 0
        end
        local __lux_tmp_173 = x2
        if __lux_tmp_173 == nil then
          __lux_tmp_173 = 1
        end
        local __lux_tmp_174 = y2
        if __lux_tmp_174 == nil then
          __lux_tmp_174 = 0
        end
        return __lux_tmp_171, __lux_tmp_172, __lux_tmp_173, __lux_tmp_174
      elseif __lux_tag_170 == style.FILL_RADIAL then
        local cx = __lux_match_169.cx
        local cy = __lux_match_169.cy
        local radius = __lux_match_169.radius
        local localRadial
        do
          local __lux_tmp_175 = fill.localRadial == true
          if not __lux_tmp_175 then
            __lux_tmp_175 = fill.ringRadial == true
          end
          local __lux_tmp_176 = __lux_tmp_175
          if not __lux_tmp_176 then
            __lux_tmp_176 = fill.sectorRadial == true
          end
          localRadial = __lux_tmp_176
        end
        local __lux_tmp_177 = cx
        if __lux_tmp_177 == nil then
          __lux_tmp_177 = 0.5
        end
        local __lux_tmp_178 = cy
        if __lux_tmp_178 == nil then
          __lux_tmp_178 = 0.5
        end
        local __lux_tmp_179 = radius
        if __lux_tmp_179 == nil then
          __lux_tmp_179 = 0.5
        end
        local __lux_tmp_180
        if localRadial then
          __lux_tmp_180 = 1
        else
          __lux_tmp_180 = 0
        end
        return __lux_tmp_177, __lux_tmp_178, __lux_tmp_179, __lux_tmp_180
      elseif __lux_tag_170 == style.FILL_CONIC then
        local cx = __lux_match_169.cx
        local cy = __lux_match_169.cy
        local rotation = __lux_match_169.rotation
        local localAngular
        do
          local __lux_tmp_181 = fill.localAngular == true
          if not __lux_tmp_181 then
            __lux_tmp_181 = fill.shapeAngular == true
          end
          localAngular = __lux_tmp_181
        end
        local __lux_tmp_182 = cx
        if __lux_tmp_182 == nil then
          __lux_tmp_182 = 0.5
        end
        local __lux_tmp_183 = cy
        if __lux_tmp_183 == nil then
          __lux_tmp_183 = 0.5
        end
        local __lux_tmp_184
        if localAngular then
          __lux_tmp_184 = 1
        else
          __lux_tmp_184 = 0
        end
        return __lux_tmp_182, __lux_tmp_183, style.normalizedRotation(rotation), __lux_tmp_184
      else
        local __lux_unused_185 = nil
      end
      return 0, 0, 1, 0
    end
    ringFillNeedsLut = function(fill)
      local __lux_match_186 = fill
      local __lux_tag_187
      if __lux_match_186 ~= nil then
        __lux_tag_187 = __lux_match_186.kind
      end
      if __lux_tag_187 == style.FILL_LINEAR or __lux_tag_187 == style.FILL_RADIAL or __lux_tag_187 == style.FILL_CONIC then
        return true
      else
        return false
      end
    end
    ringLineStyle = function(width, fill, drawStyle)
      local __lux_obj_188 = drawStyle
      local __lux_val_189 = nil
      if __lux_obj_188 ~= nil then
        __lux_val_189 = __lux_obj_188.outerGlow
      end
      local __lux_obj_190 = drawStyle
      local __lux_val_191 = nil
      if __lux_obj_190 ~= nil then
        __lux_val_191 = __lux_obj_190.backdrop
      end
      return {
        width = width,
        fill = fill,
        noCaps = false,
        outerGlow = __lux_val_189,
        backdrop = __lux_val_191,
      }
    end
    drawRingFallback = function(cx, cy, outerRadius, arcWidth, startDeg, endDeg, mode, drawStyle)
      local fill
      do
        local __lux_tmp_192 = drawStyle.fill
        if __lux_tmp_192 == nil then
          local __lux_tmp_193 = drawStyle.color
          if __lux_tmp_193 == nil then
            __lux_tmp_193 = defaultRingFill
          end
          __lux_tmp_192 = __lux_tmp_193
        end
        fill = __lux_tmp_192
      end
      local segments
      do
        local __lux_tmp_194 = drawStyle.segments
        if __lux_tmp_194 == nil then
          __lux_tmp_194 = 64
        end
        segments = arcSegmentCount(outerRadius, startDeg, endDeg, __lux_tmp_194)
      end
      local startRad
      do
        local __lux_tmp_195 = startDeg
        if __lux_tmp_195 == nil then
          __lux_tmp_195 = 0
        end
        startRad = mathRad(__lux_tmp_195)
      end
      local endRad
      do
        local __lux_tmp_196 = endDeg
        if __lux_tmp_196 == nil then
          __lux_tmp_196 = 360
        end
        endRad = mathRad(__lux_tmp_196)
      end
      if mode == 2 then
        local innerRadius
        do
          local __lux_tmp_197 = toNumber(drawStyle.innerRadius)
          if __lux_tmp_197 == nil then
            __lux_tmp_197 = mathMax(0, outerRadius - arcWidth)
          end
          innerRadius = mathClamp(__lux_tmp_197, 0, outerRadius)
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
      local __lux_tmp_198 = not style.fillVisible(fill)
      if not __lux_tmp_198 then
        __lux_tmp_198 = not shadersActive()
      end
      local __lux_tmp_199 = __lux_tmp_198
      if not __lux_tmp_199 then
        __lux_tmp_199 = not materialOK(widgetMaterials.ring)
      end
      if __lux_tmp_199 then
        return false
      end
      local material = widgetMaterials.ring
      local colorB
      do
        local __lux_tmp_200 = fill.colorB
        if __lux_tmp_200 == nil then
          local __lux_tmp_201 = fill.colorA
          if __lux_tmp_201 == nil then
            __lux_tmp_201 = color_white
          end
          __lux_tmp_200 = __lux_tmp_201
        end
        colorB = __lux_tmp_200
      end
      local r, g, b, a = style.color01(colorB)
      local sw, sh, ir, orad, sr, er, modeValue = ringShapeConstants(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      local p0, p1, p2, p3 = ringFillParams(fill)
      do
        local __lux_tmp_202 = fill.kind
        if __lux_tmp_202 == nil then
          __lux_tmp_202 = style.FILL_SOLID
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
          __lux_tmp_202,
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
        local __lux_tmp_203 = fill.colorA
        if __lux_tmp_203 == nil then
          __lux_tmp_203 = color_white
        end
        style.setDrawColor(__lux_tmp_203)
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h)
      return true
    end
    drawRingStrokePass = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, stroke, strokeWidth)
      local width = style.strokeWidth(strokeWidth, 0)
      local __lux_tmp_204 = not style.strokeVisible(stroke, width)
      if not __lux_tmp_204 then
        __lux_tmp_204 = not shadersActive()
      end
      local __lux_tmp_205 = __lux_tmp_204
      if not __lux_tmp_205 then
        __lux_tmp_205 = not materialOK(widgetMaterials.ring_stroke)
      end
      if __lux_tmp_205 then
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
      drawTexturedQuad(x, y, w, h)
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
          local __lux_tmp_206 = innerSpec.color
          if __lux_tmp_206 == nil then
            __lux_tmp_206 = transparentColor
          end
          gr, gg, gb, ga = style.color01(__lux_tmp_206)
        end
        do
          local __lux_tmp_207 = toNumber(innerSpec.width)
          if __lux_tmp_207 == nil then
            __lux_tmp_207 = 8
          end
          glowWidth = mathMax(0.001, __lux_tmp_207)
        end
        do
          local __lux_tmp_208 = toNumber(innerSpec.strength)
          if __lux_tmp_208 == nil then
            __lux_tmp_208 = 1
          end
          glowStrength = mathMax(0, __lux_tmp_208)
        end
        do
          local __lux_tmp_209 = toNumber(innerSpec.falloff)
          if __lux_tmp_209 == nil then
            __lux_tmp_209 = 1.65
          end
          glowFalloff = mathMax(0.001, __lux_tmp_209)
        end
        do
          local __lux_tmp_210 = ga > 0
          if __lux_tmp_210 then
            __lux_tmp_210 = glowWidth > 0
          end
          local __lux_tmp_211 = __lux_tmp_210
          if __lux_tmp_211 then
            __lux_tmp_211 = glowStrength > 0
          end
          hasGlow = __lux_tmp_211
        end
      end
      local __lux_tmp_212 = not hasStroke
      if __lux_tmp_212 then
        __lux_tmp_212 = not hasGlow
      end
      local __lux_tmp_213 = __lux_tmp_212
      if not __lux_tmp_213 then
        __lux_tmp_213 = not shadersActive()
      end
      local __lux_tmp_214 = __lux_tmp_213
      if not __lux_tmp_214 then
        __lux_tmp_214 = not materialOK(widgetMaterials.ring_fx)
      end
      if __lux_tmp_214 then
        return false
      end
      local material = widgetMaterials.ring_fx
      local colorB
      do
        local __lux_tmp_215 = fill.colorB
        if __lux_tmp_215 == nil then
          local __lux_tmp_216 = fill.colorA
          if __lux_tmp_216 == nil then
            __lux_tmp_216 = color_white
          end
          __lux_tmp_215 = __lux_tmp_216
        end
        colorB = __lux_tmp_215
      end
      local r, g, b, a = style.color01(colorB)
      local sw, sh, ir, orad, sr, er, modeValue = ringShapeConstants(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      local p0, p1, p2, p3 = ringFillParams(fill)
      do
        local __lux_tmp_217 = fill.kind
        if __lux_tmp_217 == nil then
          __lux_tmp_217 = style.FILL_SOLID
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
          __lux_tmp_217,
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
        local __lux_tmp_218 = fill.colorA
        if __lux_tmp_218 == nil then
          __lux_tmp_218 = color_white
        end
        style.setDrawColor(__lux_tmp_218)
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h)
      return true
    end
    drawRingInnerGlowPass = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, spec)
      local __lux_tmp_219 = spec == nil
      if not __lux_tmp_219 then
        __lux_tmp_219 = not shadersActive()
      end
      local __lux_tmp_220 = __lux_tmp_219
      if not __lux_tmp_220 then
        __lux_tmp_220 = not materialOK(widgetMaterials.ring_innerglow)
      end
      if __lux_tmp_220 then
        return false
      end
      local color = spec.color
      local __lux_tmp_221 = color == nil
      if not __lux_tmp_221 then
        local __lux_tmp_222 = color.a
        if __lux_tmp_222 == nil then
          __lux_tmp_222 = 255
        end
        __lux_tmp_221 = __lux_tmp_222 <= 0
      end
      if __lux_tmp_221 then
        return false
      end
      local material = widgetMaterials.ring_innerglow
      local r, g, b, a = style.color01(color)
      local sw, sh, ir, orad, sr, er, modeValue = ringShapeConstants(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      do
        local __lux_tmp_223 = toNumber(spec.width)
        if __lux_tmp_223 == nil then
          __lux_tmp_223 = 8
        end
        local __lux_tmp_224 = toNumber(spec.strength)
        if __lux_tmp_224 == nil then
          __lux_tmp_224 = 1
        end
        local __lux_tmp_225 = toNumber(spec.falloff)
        if __lux_tmp_225 == nil then
          __lux_tmp_225 = 1.65
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
          mathMax(0.001, __lux_tmp_223),
          mathMax(0, __lux_tmp_224),
          mathMax(0.001, __lux_tmp_225),
          0,
          0
        )
      end
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(x, y, w, h)
      return true
    end
    drawRingOuterGlowPass = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, spec)
      local __lux_tmp_226 = spec == nil
      if not __lux_tmp_226 then
        __lux_tmp_226 = not shadersActive()
      end
      local __lux_tmp_227 = __lux_tmp_226
      if not __lux_tmp_227 then
        __lux_tmp_227 = not materialOK(widgetMaterials.ring_outerglow)
      end
      if __lux_tmp_227 then
        return false
      end
      local color = spec.color
      local __lux_tmp_228 = color == nil
      if not __lux_tmp_228 then
        local __lux_tmp_229 = color.a
        if __lux_tmp_229 == nil then
          __lux_tmp_229 = 255
        end
        __lux_tmp_228 = __lux_tmp_229 <= 0
      end
      if __lux_tmp_228 then
        return false
      end
      local spread
      do
        local __lux_tmp_230 = spec.spread
        if __lux_tmp_230 == nil then
          __lux_tmp_230 = spec.width
        end
        local __lux_tmp_231 = toNumber(__lux_tmp_230)
        if __lux_tmp_231 == nil then
          __lux_tmp_231 = 18
        end
        spread = mathMax(1, __lux_tmp_231)
      end
      local material = widgetMaterials.ring_outerglow
      local r, g, b, a = style.color01(color)
      local sw, sh, ir, orad, sr, er, modeValue = ringShapeConstants(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      do
        local __lux_tmp_232 = toNumber(spec.width)
        if __lux_tmp_232 == nil then
          __lux_tmp_232 = spread
        end
        local __lux_tmp_233 = toNumber(spec.strength)
        if __lux_tmp_233 == nil then
          __lux_tmp_233 = 1
        end
        local __lux_tmp_234 = toNumber(spec.falloff)
        if __lux_tmp_234 == nil then
          __lux_tmp_234 = 1.9
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
          spread,
          mathMax(0.001, __lux_tmp_232),
          mathMax(0, __lux_tmp_233),
          mathMax(0.001, __lux_tmp_234),
          0
        )
      end
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(x - spread, y - spread, w + spread * 2, h + spread * 2)
      return true
    end
    ringBackdropTintColor = function(spec)
      local __lux_tmp_235 = spec == nil
      if not __lux_tmp_235 then
        __lux_tmp_235 = spec.tint == nil
      end
      if __lux_tmp_235 then
        return nil
      end
      local tint = spec.tint
      local alpha
      do
        local __lux_tmp_236 = tint.a
        if __lux_tmp_236 == nil then
          __lux_tmp_236 = 255
        end
        local __lux_tmp_237 = spec.opacity
        if __lux_tmp_237 == nil then
          __lux_tmp_237 = 1
        end
        alpha = __lux_tmp_236 * __lux_tmp_237
      end
      if alpha <= 0 then
        return nil
      end
      local __lux_tmp_238 = tint.r
      if __lux_tmp_238 == nil then
        __lux_tmp_238 = 0
      end
      local __lux_tmp_239 = tint.g
      if __lux_tmp_239 == nil then
        __lux_tmp_239 = 0
      end
      local __lux_tmp_240 = tint.b
      if __lux_tmp_240 == nil then
        __lux_tmp_240 = 0
      end
      return makeColor(
        __lux_tmp_238,
        __lux_tmp_239,
        __lux_tmp_240,
        mathFloor(mathClamp(alpha, 0, 255) + 0.5)
      )
    end
    setupRingBackdropConstants = function(material, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, vertical, intensity)
      local sw, sh, ir, orad, sr, er, modeValue = ringShapeConstants(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      local __lux_tmp_241 = vertical
      if __lux_tmp_241 then
        __lux_tmp_241 = 1
      end
      local __lux_tmp_242 = __lux_tmp_241
      if not __lux_tmp_242 then
        __lux_tmp_242 = 0
      end
      local __lux_tmp_243 = intensity
      if __lux_tmp_243 == nil then
        __lux_tmp_243 = 1
      end
      return setupParamMatrix(
        material,
        __lux_tmp_242,
        __lux_tmp_243,
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
      local __lux_tmp_244 = spec.blur > 0
      if __lux_tmp_244 then
        __lux_tmp_244 = widgetBlurRT ~= nil
      end
      local __lux_tmp_245 = __lux_tmp_244
      if __lux_tmp_245 then
        __lux_tmp_245 = renderCopyRenderTargetToTexture ~= nil
      end
      local __lux_tmp_246 = __lux_tmp_245
      if __lux_tmp_246 then
        __lux_tmp_246 = materialOK(widgetMaterials.ring_backdrop)
      end
      if __lux_tmp_246 then
        local material = widgetMaterials.ring_backdrop
        surfaceSetMaterial(material)
        surfaceSetDrawColor(255, 255, 255, 255)
        renderCopyRenderTargetToTexture(widgetBlurRT)
        setupRingBackdropConstants(
          material,
          w,
          h,
          innerRadius,
          outerRadius,
          startDeg,
          endDeg,
          mode,
          false,
          spec.blur
        )
        drawTexturedQuad(x, y, w, h)
        renderCopyRenderTargetToTexture(widgetBlurRT)
        setupRingBackdropConstants(
          material,
          w,
          h,
          innerRadius,
          outerRadius,
          startDeg,
          endDeg,
          mode,
          true,
          spec.blur
        )
        drawTexturedQuad(x, y, w, h)
      end
      local tint = ringBackdropTintColor(spec)
      if tint ~= nil then
        drawRingFillPass(
          x,
          y,
          w,
          h,
          innerRadius,
          outerRadius,
          startDeg,
          endDeg,
          mode,
          style.solid(tint)
        )
      end
      return spec
    end
    drawRingPatternPass = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, pattern)
      local spec = roundrect.patternStyle(pattern)
      local __lux_tmp_247 = spec == nil
      if not __lux_tmp_247 then
        __lux_tmp_247 = not shadersActive()
      end
      local __lux_tmp_248 = __lux_tmp_247
      if not __lux_tmp_248 then
        __lux_tmp_248 = not materialOK(widgetMaterials.ring_pattern)
      end
      if __lux_tmp_248 then
        return false
      end
      local material = widgetMaterials.ring_pattern
      local angle
      do
        local __lux_tmp_249 = toNumber(spec.angle)
        if __lux_tmp_249 == nil then
          __lux_tmp_249 = 135
        end
        angle = mathRad(__lux_tmp_249)
      end
      local smoke
      local __lux_match_250 = spec.kind
      if __lux_match_250 == "smoke" then
        smoke = true
      else
        smoke = false
      end
      local pz
      if smoke then
        do
          local __lux_tmp_251 = toNumber(spec.scale)
          if __lux_tmp_251 == nil then
            __lux_tmp_251 = 140
          end
          pz = mathMax(1, __lux_tmp_251)
        end
      else
        do
          local __lux_tmp_252 = toNumber(spec.spacing)
          if __lux_tmp_252 == nil then
            __lux_tmp_252 = 12
          end
          pz = mathMax(1, __lux_tmp_252)
        end
      end
      local pw
      if smoke then
        do
          local __lux_tmp_253 = toNumber(spec.density)
          if __lux_tmp_253 == nil then
            __lux_tmp_253 = 0.48
          end
          pw = mathClamp(__lux_tmp_253, 0, 1)
        end
      else
        do
          local __lux_tmp_254 = toNumber(spec.width)
          if __lux_tmp_254 == nil then
            __lux_tmp_254 = 2
          end
          pw = mathMax(0.25, __lux_tmp_254)
        end
      end
      do
        local __lux_tmp_255
        if smoke then
          do
            local __lux_tmp_256 = toNumber(spec.seed)
            if __lux_tmp_256 == nil then
              __lux_tmp_256 = 0
            end
            __lux_tmp_255 = __lux_tmp_256
          end
        else
          __lux_tmp_255 = 0
        end
        local __lux_tmp_257
        if smoke then
          do
            local __lux_tmp_258 = toNumber(spec.softness)
            if __lux_tmp_258 == nil then
              __lux_tmp_258 = 0.3
            end
            __lux_tmp_257 = mathMax(0.001, __lux_tmp_258)
          end
        else
          __lux_tmp_257 = 0
        end
        local __lux_tmp_259
        if smoke then
          do
            local __lux_tmp_260 = toNumber(spec.warp)
            if __lux_tmp_260 == nil then
              __lux_tmp_260 = 0.85
            end
            __lux_tmp_259 = mathMax(0, __lux_tmp_260)
          end
        else
          __lux_tmp_259 = 0
        end
        local __lux_tmp_261 = toNumber(innerRadius)
        if __lux_tmp_261 == nil then
          __lux_tmp_261 = 0
        end
        local __lux_tmp_262 = toNumber(outerRadius)
        if __lux_tmp_262 == nil then
          __lux_tmp_262 = mathMin(w, h) * 0.5
        end
        local __lux_tmp_263 = toNumber(startDeg)
        if __lux_tmp_263 == nil then
          __lux_tmp_263 = 0
        end
        local __lux_tmp_264 = toNumber(endDeg)
        if __lux_tmp_264 == nil then
          __lux_tmp_264 = 360
        end
        local __lux_tmp_265
        if smoke then
          __lux_tmp_265 = 1
        else
          __lux_tmp_265 = 0
        end
        setupParamMatrix(
          material,
          __lux_tmp_255,
          roundrect.patternOffset(spec),
          __lux_tmp_257,
          __lux_tmp_259,
          w,
          h,
          mathMax(0, __lux_tmp_261),
          mathMax(0.001, __lux_tmp_262),
          mathRad(__lux_tmp_263),
          mathRad(__lux_tmp_264),
          ringModeValue(mode),
          __lux_tmp_265,
          mathCos(angle),
          mathSin(angle),
          pz,
          pw
        )
      end
      do
        local __lux_tmp_266 = spec.color
        if __lux_tmp_266 == nil then
          local __lux_tmp_267 = spec.tint
          if __lux_tmp_267 == nil then
            __lux_tmp_267 = makeColor(255, 255, 255, 24)
          end
          __lux_tmp_266 = __lux_tmp_267
        end
        style.setDrawColor(__lux_tmp_266)
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h)
      return true
    end
    drawRingBox = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, drawStyle)
      do
        local __lux_tmp_268 = drawStyle
        if __lux_tmp_268 == nil then
          __lux_tmp_268 = {}
        end
        drawStyle = __lux_tmp_268
      end
      local fill
      do
        local __lux_tmp_269 = drawStyle.fill
        if __lux_tmp_269 == nil then
          local __lux_tmp_270 = drawStyle.color
          if __lux_tmp_270 == nil then
            __lux_tmp_270 = defaultRingFill
          end
          __lux_tmp_269 = __lux_tmp_270
        end
        fill = style.fillFromStyle(__lux_tmp_269)
      end
      local __lux_tmp_271 = not shadersActive()
      if not __lux_tmp_271 then
        __lux_tmp_271 = not materialOK(widgetMaterials.ring)
      end
      if __lux_tmp_271 then
        local __lux_table_272 = {}
        local __lux_spread_273 = drawStyle
        if __lux_spread_273 ~= nil then
          for __lux_k_274, __lux_v_275 in pairs(__lux_spread_273) do
            __lux_table_272[__lux_k_274] = __lux_v_275
          end
        end
        __lux_table_272.fill = fill
        __lux_table_272.innerRadius = innerRadius
        return drawRingFallback(
          x + w * 0.5,
          y + h * 0.5,
          outerRadius,
          outerRadius - innerRadius,
          startDeg,
          endDeg,
          mode,
          __lux_table_272
        )
      end
      local outer = roundrect.outerGlowStyle(drawStyle.outerGlow)
      if outer ~= nil then
        drawRingOuterGlowPass(
          x,
          y,
          w,
          h,
          innerRadius,
          outerRadius,
          startDeg,
          endDeg,
          mode,
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
      local __lux_tmp_276 = drawStyle.pattern == nil
      if __lux_tmp_276 then
        local __lux_tmp_277 = hasStroke
        if not __lux_tmp_277 then
          __lux_tmp_277 = inner ~= nil
        end
        __lux_tmp_276 = __lux_tmp_277
      end
      local __lux_tmp_278 = __lux_tmp_276
      if __lux_tmp_278 then
        __lux_tmp_278 = drawRingFxPass(
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
      if __lux_tmp_278 then
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
        local __lux_tmp_279 = drawStyle
        if __lux_tmp_279 == nil then
          __lux_tmp_279 = {}
        end
        resolved = __lux_tmp_279
      end
      local transform, stripped = geometry.splitStyleTransform(resolved)
      local outerRadius
      do
        local __lux_tmp_280 = toNumber(radius)
        if __lux_tmp_280 == nil then
          __lux_tmp_280 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_280)
      end
      local ringWidth
      do
        local __lux_tmp_281 = toNumber(width)
        if __lux_tmp_281 == nil then
          __lux_tmp_281 = mathMax(1, outerRadius * 0.18)
        end
        ringWidth = mathMax(0.001, __lux_tmp_281)
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
        local __lux_tmp_282 = drawStyle
        if __lux_tmp_282 == nil then
          __lux_tmp_282 = {}
        end
        resolved = __lux_tmp_282
      end
      local transform, stripped = geometry.splitStyleTransform(resolved)
      local outerRadius
      do
        local __lux_tmp_283 = toNumber(radius)
        if __lux_tmp_283 == nil then
          __lux_tmp_283 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_283)
      end
      local arcWidth
      do
        local __lux_tmp_284 = toNumber(width)
        if __lux_tmp_284 == nil then
          __lux_tmp_284 = mathMax(1, outerRadius * 0.18)
        end
        arcWidth = mathMax(0.001, __lux_tmp_284)
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
        local __lux_tmp_285 = drawStyle
        if __lux_tmp_285 == nil then
          __lux_tmp_285 = {}
        end
        resolved = __lux_tmp_285
      end
      local transform, stripped = geometry.splitStyleTransform(resolved)
      do
        local __lux_tmp_286 = toNumber(outerRadius)
        if __lux_tmp_286 == nil then
          __lux_tmp_286 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_286)
      end
      do
        local __lux_tmp_287 = toNumber(innerRadius)
        if __lux_tmp_287 == nil then
          __lux_tmp_287 = 0
        end
        innerRadius = mathClamp(__lux_tmp_287, 0, outerRadius)
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
            local __lux_tmp_288
            do
              local __lux_tmp_289 = material ~= nil
              if __lux_tmp_289 then
                __lux_tmp_289 = material.IsError ~= nil
              end
              local __lux_tmp_290 = __lux_tmp_289
              if __lux_tmp_290 then
                __lux_tmp_290 = not material:IsError()
              end
              if __lux_tmp_290 then
                __lux_tmp_288 = material
              else
                __lux_tmp_288 = false
              end
            end
            cached = __lux_tmp_288
          end
          imageMaterialCache[source] = cached
        end
        if cached == false then
          return nil, nil
        end
        return cached:GetTexture("$basetexture"), cached
      end
      local __lux_tmp_291 = source ~= nil
      if __lux_tmp_291 then
        __lux_tmp_291 = source.GetTexture ~= nil
      end
      if __lux_tmp_291 then
        return source:GetTexture("$basetexture"), source
      end
      local __lux_tmp_292 = source ~= nil
      if __lux_tmp_292 then
        __lux_tmp_292 = source.GetName ~= nil
      end
      if __lux_tmp_292 then
        return source, nil
      end
      return nil, nil
    end
    imageWhiteTextureSource = function()
      if imageWhiteTexture ~= nil then
        local __lux_tmp_293 = imageWhiteTexture ~= false
        if __lux_tmp_293 then
          __lux_tmp_293 = imageWhiteTexture
        end
        local __lux_tmp_294 = __lux_tmp_293
        if not __lux_tmp_294 then
          __lux_tmp_294 = nil
        end
        return __lux_tmp_294
      end
      local texture = imageTextureSource("color/white")
      do
        local __lux_tmp_295 = texture
        if __lux_tmp_295 == nil then
          __lux_tmp_295 = false
        end
        imageWhiteTexture = __lux_tmp_295
      end
      local __lux_tmp_296 = imageWhiteTexture ~= false
      if __lux_tmp_296 then
        __lux_tmp_296 = imageWhiteTexture
      end
      local __lux_tmp_297 = __lux_tmp_296
      if not __lux_tmp_297 then
        __lux_tmp_297 = nil
      end
      return __lux_tmp_297
    end
    imageFallbackMaterialForTexture = function(texture)
      local __lux_tmp_298 = texture == nil
      if not __lux_tmp_298 then
        __lux_tmp_298 = imageCreateMaterial == nil
      end
      if __lux_tmp_298 then
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
      local __lux_tmp_299 = kind ~= nil
      if __lux_tmp_299 then
        __lux_tmp_299 = kind >= 10
      end
      return __lux_tmp_299
    end
    imageMaskKindValue = function(mask)
      if typeOf(mask) ~= "table" then
        return nil
      end
      local kind
      do
        local __lux_tmp_300 = mask.kind
        if __lux_tmp_300 == nil then
          __lux_tmp_300 = mask.shape
        end
        kind = __lux_tmp_300
      end
      if typeOf(kind) ~= "string" then
        return nil
      end
      kind = imageStringLower(kind)
      local __lux_match_301 = kind
      if __lux_match_301 == "round" or __lux_match_301 == "rounded" or __lux_match_301 == "roundedbox" or __lux_match_301 == "roundrect" then
        return 0
      elseif __lux_match_301 == "chamfer" or __lux_match_301 == "bevel" then
        return 1
      elseif __lux_match_301 == "circle" then
        return 2
      elseif __lux_match_301 == "capsule" or __lux_match_301 == "pill" then
        return 3
      elseif __lux_match_301 == "texture" or __lux_match_301 == "alpha" or __lux_match_301 == "image" then
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
      local __lux_match_302 = normalized
      if __lux_match_302 == "a" or __lux_match_302 == "alpha" then
        return 10
      elseif __lux_match_302 == "r" or __lux_match_302 == "red" then
        return 11
      elseif __lux_match_302 == "g" or __lux_match_302 == "green" then
        return 12
      elseif __lux_match_302 == "b" or __lux_match_302 == "blue" then
        return 13
      elseif __lux_match_302 == "luma" or __lux_match_302 == "lum" or __lux_match_302 == "luminance" or __lux_match_302 == "rgb" then
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
        local __lux_tmp_303 = mask.source
        if __lux_tmp_303 == nil then
          local __lux_tmp_304 = mask.material
          if __lux_tmp_304 == nil then
            local __lux_tmp_305 = mask.texture
            if __lux_tmp_305 == nil then
              __lux_tmp_305 = mask.image
            end
            __lux_tmp_304 = __lux_tmp_305
          end
          __lux_tmp_303 = __lux_tmp_304
        end
        source = __lux_tmp_303
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
      local __lux_tmp_306 = typeOf(mask.uv) == "table"
      if not __lux_tmp_306 then
        __lux_tmp_306 = typeOf(mask.crop) == "table"
      end
      if __lux_tmp_306 then
        return geometry.imageUV(mask, texture)
      end
      local u0
      do
        local __lux_tmp_307 = mask.u0
        if __lux_tmp_307 == nil then
          local __lux_tmp_308 = mask.x0
          if __lux_tmp_308 == nil then
            __lux_tmp_308 = mask[1]
          end
          __lux_tmp_307 = __lux_tmp_308
        end
        local __lux_tmp_309 = toNumber(__lux_tmp_307)
        if __lux_tmp_309 == nil then
          __lux_tmp_309 = 0
        end
        u0 = __lux_tmp_309
      end
      local v0
      do
        local __lux_tmp_310 = mask.v0
        if __lux_tmp_310 == nil then
          local __lux_tmp_311 = mask.y0
          if __lux_tmp_311 == nil then
            __lux_tmp_311 = mask[2]
          end
          __lux_tmp_310 = __lux_tmp_311
        end
        local __lux_tmp_312 = toNumber(__lux_tmp_310)
        if __lux_tmp_312 == nil then
          __lux_tmp_312 = 0
        end
        v0 = __lux_tmp_312
      end
      local u1
      do
        local __lux_tmp_313 = mask.u1
        if __lux_tmp_313 == nil then
          local __lux_tmp_314 = mask.x1
          if __lux_tmp_314 == nil then
            __lux_tmp_314 = mask[3]
          end
          __lux_tmp_313 = __lux_tmp_314
        end
        local __lux_tmp_315 = toNumber(__lux_tmp_313)
        if __lux_tmp_315 == nil then
          __lux_tmp_315 = 1
        end
        u1 = __lux_tmp_315
      end
      local v1
      do
        local __lux_tmp_316 = mask.v1
        if __lux_tmp_316 == nil then
          local __lux_tmp_317 = mask.y1
          if __lux_tmp_317 == nil then
            __lux_tmp_317 = mask[4]
          end
          __lux_tmp_316 = __lux_tmp_317
        end
        local __lux_tmp_318 = toNumber(__lux_tmp_316)
        if __lux_tmp_318 == nil then
          __lux_tmp_318 = 1
        end
        v1 = __lux_tmp_318
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
        local __lux_tmp_319 = mask
        if __lux_tmp_319 == nil then
          __lux_tmp_319 = style.imageMaskStyle(drawStyle.mask, drawStyle)
        end
        resolvedMask = __lux_tmp_319
      end
      if typeOf(resolvedMask) ~= "table" then
        return nil
      end
      local __lux_match_320 = resolvedMask
      local __lux_tag_321
      if __lux_match_320 ~= nil then
        __lux_tag_321 = __lux_match_320.kind
      end
      if __lux_tag_321 == "chamfer" then
        local cuts = __lux_match_320.cuts
        local __lux_tmp_322 = cuts
        if __lux_tmp_322 == nil then
          __lux_tmp_322 = 0
        end
        return __lux_tmp_322
      else
        return nil
      end
    end
    imageChamferMaskTuple = function(mask, w, h)
      local cuts
      do
        local __lux_tmp_323 = mask ~= nil
        if __lux_tmp_323 then
          __lux_tmp_323 = mask.cuts
        end
        local __lux_tmp_324 = __lux_tmp_323
        if not __lux_tmp_324 then
          __lux_tmp_324 = 0
        end
        cuts = __lux_tmp_324
      end
      return primitives.chamferTuple(cuts, w, h)
    end
    setupImageMaskConstants = function(material, w, h, sourceU0, sourceV0, sourceU1, sourceV1, stroke, strokeWidth, mask, kind, maskTexture)
      local strokeColor
      do
        local __lux_tmp_325 = stroke
        if __lux_tmp_325 == nil then
          __lux_tmp_325 = transparentColor
        end
        strokeColor = __lux_tmp_325
      end
      local r, g, b, a = style.color01(strokeColor)
      local strokeR = r
      local strokeG = g
      local strokeB = b
      local strokeA = a
      local packedKind = kind
      local __lux_tmp_326 = mask ~= nil
      if __lux_tmp_326 then
        local __lux_tmp_327 = mask.invert
        if not __lux_tmp_327 then
          __lux_tmp_327 = mask.inverse
        end
        __lux_tmp_326 = __lux_tmp_327
      end
      if __lux_tmp_326 then
        packedKind = packedKind + 128
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
      local __lux_tmp_328 = mask ~= nil
      if __lux_tmp_328 then
        __lux_tmp_328 = geometry.imageRadius(mask.radius, w, h)
      end
      local __lux_tmp_329 = __lux_tmp_328
      if not __lux_tmp_329 then
        __lux_tmp_329 = 0
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
        __lux_tmp_329,
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
    drawImageMaskPass = function(x, y, w, h, texture, u0, v0, u1, v1, tint, stroke, strokeWidth, mask, kind, maskTexture)
      local __lux_tmp_330 = texture == nil
      if not __lux_tmp_330 then
        __lux_tmp_330 = not materialOK(widgetMaterials.image_mask)
      end
      if __lux_tmp_330 then
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
        maskTexture
      )
      do
        local __lux_tmp_331 = tint
        if __lux_tmp_331 == nil then
          __lux_tmp_331 = color_white
        end
        style.setDrawColor(__lux_tmp_331)
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h)
      return true
    end
    imageBackdropTintColor = function(spec)
      local __lux_tmp_332 = spec == nil
      if not __lux_tmp_332 then
        __lux_tmp_332 = spec.tint == nil
      end
      if __lux_tmp_332 then
        return nil
      end
      local tint = spec.tint
      local alpha
      do
        local __lux_tmp_333 = tint.a
        if __lux_tmp_333 == nil then
          __lux_tmp_333 = 255
        end
        local __lux_tmp_334 = spec.opacity
        if __lux_tmp_334 == nil then
          __lux_tmp_334 = 1
        end
        alpha = __lux_tmp_333 * __lux_tmp_334
      end
      if alpha <= 0 then
        return nil
      end
      local __lux_tmp_335 = tint.r
      if __lux_tmp_335 == nil then
        __lux_tmp_335 = 0
      end
      local __lux_tmp_336 = tint.g
      if __lux_tmp_336 == nil then
        __lux_tmp_336 = 0
      end
      local __lux_tmp_337 = tint.b
      if __lux_tmp_337 == nil then
        __lux_tmp_337 = 0
      end
      return makeColor(
        __lux_tmp_335,
        __lux_tmp_336,
        __lux_tmp_337,
        mathFloor(mathClamp(alpha, 0, 255) + 0.5)
      )
    end
    setupImageMaskBackdropConstants = function(material, w, h, mask, kind, maskTexture, vertical, intensity)
      local packedKind = kind
      local __lux_tmp_338 = mask ~= nil
      if __lux_tmp_338 then
        local __lux_tmp_339 = mask.invert
        if not __lux_tmp_339 then
          __lux_tmp_339 = mask.inverse
        end
        __lux_tmp_338 = __lux_tmp_339
      end
      if __lux_tmp_338 then
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
          if maskTexture ~= nil then
            material:SetTexture("$texture2", maskTexture)
          end
        end
      end
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
      local __lux_tmp_343 = mask ~= nil
      if __lux_tmp_343 then
        __lux_tmp_343 = geometry.imageRadius(mask.radius, w, h)
      end
      local __lux_tmp_344 = __lux_tmp_343
      if not __lux_tmp_344 then
        __lux_tmp_344 = 0
      end
      return setupParamMatrix(
        material,
        __lux_tmp_341,
        __lux_tmp_342,
        0,
        0,
        w,
        h,
        packedKind,
        __lux_tmp_344,
        0,
        0,
        1,
        1,
        p0,
        p1,
        p2,
        p3
      )
    end
    drawImageMaskBackdrop = function(x, y, w, h, mask, kind, maskTexture, backdrop)
      local spec = style.backdropStyle(backdrop)
      local __lux_tmp_345 = spec == nil
      if not __lux_tmp_345 then
        __lux_tmp_345 = typeOf(mask) ~= "table"
      end
      local __lux_tmp_346 = __lux_tmp_345
      if not __lux_tmp_346 then
        __lux_tmp_346 = kind == nil
      end
      if __lux_tmp_346 then
        return nil
      end
      local __lux_tmp_347 = imageMaskUsesTexture(kind)
      if __lux_tmp_347 then
        __lux_tmp_347 = maskTexture == nil
      end
      if __lux_tmp_347 then
        return nil
      end
      local __lux_tmp_348 = spec.blur > 0
      if __lux_tmp_348 then
        __lux_tmp_348 = widgetBlurRT ~= nil
      end
      local __lux_tmp_349 = __lux_tmp_348
      if __lux_tmp_349 then
        __lux_tmp_349 = renderCopyRenderTargetToTexture ~= nil
      end
      local __lux_tmp_350 = __lux_tmp_349
      if __lux_tmp_350 then
        __lux_tmp_350 = materialOK(widgetMaterials.image_mask_backdrop)
      end
      if __lux_tmp_350 then
        local material = widgetMaterials.image_mask_backdrop
        surfaceSetMaterial(material)
        surfaceSetDrawColor(255, 255, 255, 255)
        renderCopyRenderTargetToTexture(widgetBlurRT)
        setupImageMaskBackdropConstants(
          material,
          w,
          h,
          mask,
          kind,
          maskTexture,
          false,
          spec.blur
        )
        drawTexturedQuad(x, y, w, h)
        renderCopyRenderTargetToTexture(widgetBlurRT)
        setupImageMaskBackdropConstants(
          material,
          w,
          h,
          mask,
          kind,
          maskTexture,
          true,
          spec.blur
        )
        drawTexturedQuad(x, y, w, h)
      end
      local tint = imageBackdropTintColor(spec)
      if tint ~= nil then
        local white = imageWhiteTextureSource()
        if white ~= nil then
          drawImageMaskPass(x, y, w, h, white, 0, 0, 1, 1, tint, nil, 0, mask, kind, maskTexture)
        end
      end
      return spec
    end
    drawImageMaskShader = function(x, y, w, h, texture, u0, v0, u1, v1, drawStyle, mask, kind)
      if typeOf(mask) ~= "table" then
        return false
      end
      do
        local __lux_tmp_351 = kind
        if __lux_tmp_351 == nil then
          __lux_tmp_351 = imageMaskKindValue(mask)
        end
        kind = __lux_tmp_351
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
        local __lux_tmp_352 = drawStyle.fill
        if __lux_tmp_352 == nil then
          __lux_tmp_352 = drawStyle.background
        end
        background = __lux_tmp_352
      end
      local __lux_tmp_353 = background ~= nil
      if __lux_tmp_353 then
        __lux_tmp_353 = background.r ~= nil
      end
      local __lux_tmp_354 = __lux_tmp_353
      if __lux_tmp_354 then
        local __lux_tmp_355 = background.a == nil
        if not __lux_tmp_355 then
          __lux_tmp_355 = background.a > 0
        end
        __lux_tmp_354 = __lux_tmp_355
      end
      if __lux_tmp_354 then
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
        maskTexture
      )
    end
    drawImageMaskOuterGlow = function(x, y, w, h, mask, kind, glow)
      local spec = glow
      local __lux_tmp_356 = spec == nil
      if not __lux_tmp_356 then
        __lux_tmp_356 = typeOf(mask) ~= "table"
      end
      local __lux_tmp_357 = __lux_tmp_356
      if not __lux_tmp_357 then
        __lux_tmp_357 = not materialOK(widgetMaterials.image_mask_outerglow)
      end
      if __lux_tmp_357 then
        return false
      end
      do
        local __lux_tmp_358 = kind
        if __lux_tmp_358 == nil then
          __lux_tmp_358 = imageMaskKindValue(mask)
        end
        kind = __lux_tmp_358
      end
      if kind == nil then
        return false
      end
      local maskTexture = nil
      if imageMaskUsesTexture(kind) then
        kind = imageMaskTextureChannelKind(mask.channel)
        if kind == nil then
          return false
        end
        maskTexture = imageMaskTextureSource(mask)
        if maskTexture == nil then
          return false
        end
      end
      local spread
      do
        local __lux_tmp_359 = spec.spread
        if __lux_tmp_359 == nil then
          __lux_tmp_359 = spec.width
        end
        local __lux_tmp_360 = toNumber(__lux_tmp_359)
        if __lux_tmp_360 == nil then
          __lux_tmp_360 = 18
        end
        spread = mathMax(1, __lux_tmp_360)
      end
      local material = widgetMaterials.image_mask_outerglow
      local r, g, b, a
      do
        local __lux_tmp_361 = spec.color
        if __lux_tmp_361 == nil then
          __lux_tmp_361 = makeColor(76, 190, 255, 88)
        end
        r, g, b, a = style.color01(__lux_tmp_361)
      end
      local glowR = r
      local glowG = g
      local glowB = b
      local glowA = a
      local packedKind = kind
      local __lux_tmp_362 = mask.invert
      if not __lux_tmp_362 then
        __lux_tmp_362 = mask.inverse
      end
      if __lux_tmp_362 then
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
        local __lux_tmp_363 = mask ~= nil
        if __lux_tmp_363 then
          __lux_tmp_363 = geometry.imageRadius(mask.radius, w, h)
        end
        local __lux_tmp_364 = __lux_tmp_363
        if not __lux_tmp_364 then
          __lux_tmp_364 = 0
        end
        local __lux_tmp_365 = spec.strength
        if __lux_tmp_365 == nil then
          __lux_tmp_365 = spec.opacity
        end
        local __lux_tmp_366 = toNumber(__lux_tmp_365)
        if __lux_tmp_366 == nil then
          __lux_tmp_366 = 1
        end
        local __lux_tmp_367 = toNumber(spec.falloff)
        if __lux_tmp_367 == nil then
          __lux_tmp_367 = 1.8
        end
        setupParamMatrix(
          material,
          glowR,
          glowG,
          glowB,
          glowA,
          w,
          h,
          packedKind,
          __lux_tmp_364,
          spread,
          mathMax(0, __lux_tmp_366),
          mathClamp(1 / mathMax(__lux_tmp_367, 0.001), 0.1, 1),
          0,
          p0,
          p1,
          p2,
          p3
        )
      end
      surfaceSetDrawColor(255, 255, 255, 255)
      surfaceSetMaterial(material)
      drawTexturedQuad(x - spread, y - spread, w + spread * 2, h + spread * 2)
      return true
    end
  end
  do
    drawImageFallback = function(x, y, w, h, source, drawStyle)
      local texture, material = imageTextureSource(source)
      local createdMaterialFallback = material == nil
      do
        local __lux_tmp_368 = material
        if __lux_tmp_368 == nil then
          __lux_tmp_368 = imageFallbackMaterialForTexture(texture)
        end
        material = __lux_tmp_368
      end
      if material == nil then
        return
      end
      local u0, v0, u1, v1 = geometry.imageUV(drawStyle, texture)
      x, y, w, h, u0, v0, u1, v1 = geometry.imageFitRect(x, y, w, h, texture, drawStyle, u0, v0, u1, v1)
      local __lux_tmp_369 = w <= 0
      if not __lux_tmp_369 then
        __lux_tmp_369 = h <= 0
      end
      if __lux_tmp_369 then
        return
      end
      local radius = geometry.imageRadius(drawStyle.radius, w, h)
      local background
      do
        local __lux_tmp_370 = drawStyle.fill
        if __lux_tmp_370 == nil then
          __lux_tmp_370 = drawStyle.background
        end
        background = __lux_tmp_370
      end
      local __lux_tmp_371 = background ~= nil
      if __lux_tmp_371 then
        local __lux_tmp_372 = background.a
        if __lux_tmp_372 == nil then
          __lux_tmp_372 = 255
        end
        __lux_tmp_371 = __lux_tmp_372 > 0
      end
      if __lux_tmp_371 then
        roundrect.roundedBoxEx(x, y, w, h, { radius = radius, fill = background })
      end
      surfaceSetMaterial(material)
      style.setDrawColor(geometry.imageTint(drawStyle))
      if hasTransform() then
        geometry.drawTexturedQuadUV(x, y, w, h, u0, v0, u1, v1)
      else
        if createdMaterialFallback then
          geometry.drawCreatedMaterialTexturedRectUV(x, y, w, h, u0, v0, u1, v1)
        else
          geometry.drawTexturedRectUV(x, y, w, h, u0, v0, u1, v1)
        end
      end
      local strokeWidth = style.strokeWidthValue(drawStyle.strokeWidth, 0)
      if style.strokeVisible(drawStyle.stroke, strokeWidth) then
        roundrect.roundedBoxEx(
          x,
          y,
          w,
          h,
          {
            radius = radius,
            fill = transparentColor,
            stroke = drawStyle.stroke,
            strokeWidth = mathMax(1, mathFloor(strokeWidth)),
          }
        )
      end
    end
    drawImageChamfer = function(x, y, w, h, texture, u0, v0, u1, v1, drawStyle, cuts)
      if not materialOK(widgetMaterials.chamfer_texture) then
        return false
      end
      local __lux_tmp_373 = drawStyle.shadow ~= nil
      if __lux_tmp_373 then
        __lux_tmp_373 = drawStyle.shadow.color ~= nil
      end
      local __lux_tmp_374 = __lux_tmp_373
      if __lux_tmp_374 then
        local __lux_tmp_375 = drawStyle.shadow.color.a
        if __lux_tmp_375 == nil then
          __lux_tmp_375 = 255
        end
        __lux_tmp_374 = __lux_tmp_375 > 0
      end
      if __lux_tmp_374 then
        primitives.chamferBoxEx(
          x,
          y,
          w,
          h,
          { cuts = cuts, fill = transparentColor, shadow = drawStyle.shadow }
        )
      end
      if drawStyle.backdrop ~= nil then
        primitives.chamferBoxEx(
          x,
          y,
          w,
          h,
          { cuts = cuts, backdrop = drawStyle.backdrop, fill = transparentColor }
        )
      end
      local background
      do
        local __lux_tmp_376 = drawStyle.fill
        if __lux_tmp_376 == nil then
          __lux_tmp_376 = drawStyle.background
        end
        background = __lux_tmp_376
      end
      local __lux_tmp_377 = background ~= nil
      if __lux_tmp_377 then
        local __lux_tmp_378 = background.a
        if __lux_tmp_378 == nil then
          __lux_tmp_378 = 255
        end
        __lux_tmp_377 = __lux_tmp_378 > 0
      end
      if __lux_tmp_377 then
        primitives.chamferBoxEx(x, y, w, h, { cuts = cuts, fill = background })
      end
      local tl, tr, br, bl = primitives.chamferTuple(cuts, w, h)
      local material = widgetMaterials.chamfer_texture
      local r, g, b, a = style.color01(geometry.imageTint(drawStyle))
      material:SetTexture("$basetexture", texture)
      setupParamMatrix(material, r, g, b, a, w, h, 0, 0, u0, v0, u1, v1, tl, tr, br, bl)
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(x, y, w, h)
      if style.strokeVisible(drawStyle.stroke, drawStyle.strokeWidth) then
        primitives.chamferBoxEx(
          x,
          y,
          w,
          h,
          {
            cuts = cuts,
            fill = transparentColor,
            stroke = drawStyle.stroke,
            strokeWidth = drawStyle.strokeWidth,
          }
        )
      end
      return true
    end
    imageRoundedRadius = function(drawStyle, mask, maskKind, w, h)
      local __lux_match_379 = maskKind
      if __lux_match_379 == 2 or __lux_match_379 == 3 then
        return mathMin(w, h) * 0.5
      elseif __lux_match_379 == 0 then
        local __lux_tmp_380 = mask ~= nil
        if __lux_tmp_380 then
          __lux_tmp_380 = mask.radius ~= nil
        end
        if __lux_tmp_380 then
          return geometry.imageRadius(mask.radius, w, h)
        end
        return geometry.imageRadius(drawStyle.radius, w, h)
      else
        return geometry.imageRadius(drawStyle.radius, w, h)
      end
    end
    drawImageRoundRectShader = function(x, y, w, h, texture, u0, v0, u1, v1, drawStyle, radius)
      local material = widgetMaterials.roundrect_texture
      if not materialOK(material) then
        return false
      end
      material:SetTexture("$basetexture", texture)
      local stroke
      do
        local __lux_tmp_381 = drawStyle.stroke
        if __lux_tmp_381 == nil then
          __lux_tmp_381 = transparentColor
        end
        stroke = __lux_tmp_381
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
      drawTexturedQuad(x, y, w, h)
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
      local __lux_tmp_382 = not shadersActive()
      if not __lux_tmp_382 then
        __lux_tmp_382 = not materialOK(widgetMaterials.roundrect_texture)
      end
      if __lux_tmp_382 then
        drawImageFallback(x, y, w, h, source, resolved)
        return
      end
      local u0, v0, u1, v1 = geometry.imageUV(resolved, texture)
      x, y, w, h, u0, v0, u1, v1 = geometry.imageFitRect(x, y, w, h, texture, resolved, u0, v0, u1, v1)
      local __lux_tmp_383 = w <= 0
      if not __lux_tmp_383 then
        __lux_tmp_383 = h <= 0
      end
      if __lux_tmp_383 then
        return
      end
      local mask = style.imageMaskStyle(resolved.mask, resolved)
      local maskKind = imageMaskKindValue(mask)
      local backdrop = style.backdropStyle(resolved.backdrop)
      local __lux_tmp_384 = backdrop ~= nil
      if __lux_tmp_384 then
        __lux_tmp_384 = mask == nil
      end
      if __lux_tmp_384 then
        mask = { kind = "texture", source = source, channel = "alpha" }
        maskKind = 10
      end
      if imageMaskUsesTexture(maskKind) then
        local maskTexture = imageMaskTextureSource(mask)
        local backdropMaskKind
        do
          local __lux_tmp_385 = imageMaskTextureChannelKind(mask.channel)
          if __lux_tmp_385 == nil then
            __lux_tmp_385 = maskKind
          end
          backdropMaskKind = __lux_tmp_385
        end
        drawImageMaskOuterGlow(
          x,
          y,
          w,
          h,
          mask,
          maskKind,
          roundrect.outerGlowStyle(resolved.outerGlow)
        )
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
      local __lux_tmp_386 = cuts ~= nil
      if __lux_tmp_386 then
        __lux_tmp_386 = drawImageChamfer(x, y, w, h, texture, u0, v0, u1, v1, resolved, cuts)
      end
      if __lux_tmp_386 then
        return
      end
      local radius = imageRoundedRadius(resolved, mask, maskKind, w, h)
      local __lux_tmp_387 = resolved.shadow ~= nil
      if __lux_tmp_387 then
        __lux_tmp_387 = resolved.shadow.color ~= nil
      end
      local __lux_tmp_388 = __lux_tmp_387
      if __lux_tmp_388 then
        local __lux_tmp_389 = resolved.shadow.color.a
        if __lux_tmp_389 == nil then
          __lux_tmp_389 = 255
        end
        __lux_tmp_388 = __lux_tmp_389 > 0
      end
      if __lux_tmp_388 then
        roundrect.roundedBoxEx(
          x,
          y,
          w,
          h,
          { radius = radius, fill = transparentColor, shadow = resolved.shadow }
        )
      end
      if resolved.outerGlow ~= nil then
        roundrect.roundedBoxEx(
          x,
          y,
          w,
          h,
          { radius = radius, fill = transparentColor, outerGlow = resolved.outerGlow }
        )
      end
      if resolved.backdrop ~= nil then
        roundrect.roundedBoxEx(
          x,
          y,
          w,
          h,
          { radius = radius, backdrop = resolved.backdrop, fill = transparentColor }
        )
      end
      local background
      do
        local __lux_tmp_390 = resolved.fill
        if __lux_tmp_390 == nil then
          __lux_tmp_390 = resolved.background
        end
        background = __lux_tmp_390
      end
      local __lux_tmp_391 = background ~= nil
      if __lux_tmp_391 then
        local __lux_tmp_392 = background.a
        if __lux_tmp_392 == nil then
          __lux_tmp_392 = 255
        end
        __lux_tmp_391 = __lux_tmp_392 > 0
      end
      if __lux_tmp_391 then
        roundrect.roundedBoxEx(x, y, w, h, { radius = radius, fill = background })
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
      local __lux_tmp_393 = resolved.fit == nil
      if __lux_tmp_393 then
        __lux_tmp_393 = resolved.objectFit == nil
      end
      if __lux_tmp_393 then
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
