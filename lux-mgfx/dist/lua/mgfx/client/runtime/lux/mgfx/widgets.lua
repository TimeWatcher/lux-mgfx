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
    local geometryImport = __lux_import("lux/mgfx/geometry#client")
    local paintImport = __lux_import("lux/mgfx/paint#client")
    local primitivesImport = __lux_import("lux/mgfx/primitives#client")
    local roundrectImport = __lux_import("lux/mgfx/roundrect#client")
    local styleImport = __lux_import("lux/mgfx/style#client")
    local textImport = __lux_import("lux/mgfx/text#client")
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
    hasTransform = geometry.hasTransform
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
    setupAuxConstants = function(material, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3)
      if material == nil then
        return false
      end
      do
        local __lux_tmp_a0_27 = a0
        if __lux_tmp_a0_27 == nil then
          __lux_tmp_a0_27 = 0
        end
        material:SetFloat("$c0_x", __lux_tmp_a0_27)
      end
      do
        local __lux_tmp_a1_28 = a1
        if __lux_tmp_a1_28 == nil then
          __lux_tmp_a1_28 = 0
        end
        material:SetFloat("$c0_y", __lux_tmp_a1_28)
      end
      do
        local __lux_tmp_a2_29 = a2
        if __lux_tmp_a2_29 == nil then
          __lux_tmp_a2_29 = 0
        end
        material:SetFloat("$c0_z", __lux_tmp_a2_29)
      end
      do
        local __lux_tmp_a3_30 = a3
        if __lux_tmp_a3_30 == nil then
          __lux_tmp_a3_30 = 0
        end
        material:SetFloat("$c0_w", __lux_tmp_a3_30)
      end
      do
        local __lux_tmp_b0_31 = b0
        if __lux_tmp_b0_31 == nil then
          __lux_tmp_b0_31 = 0
        end
        material:SetFloat("$c1_x", __lux_tmp_b0_31)
      end
      do
        local __lux_tmp_b1_32 = b1
        if __lux_tmp_b1_32 == nil then
          __lux_tmp_b1_32 = 0
        end
        material:SetFloat("$c1_y", __lux_tmp_b1_32)
      end
      do
        local __lux_tmp_b2_33 = b2
        if __lux_tmp_b2_33 == nil then
          __lux_tmp_b2_33 = 0
        end
        material:SetFloat("$c1_z", __lux_tmp_b2_33)
      end
      do
        local __lux_tmp_b3_34 = b3
        if __lux_tmp_b3_34 == nil then
          __lux_tmp_b3_34 = 0
        end
        material:SetFloat("$c1_w", __lux_tmp_b3_34)
      end
      do
        local __lux_tmp_c0_35 = c0
        if __lux_tmp_c0_35 == nil then
          __lux_tmp_c0_35 = 0
        end
        material:SetFloat("$c2_x", __lux_tmp_c0_35)
      end
      do
        local __lux_tmp_c1_36 = c1
        if __lux_tmp_c1_36 == nil then
          __lux_tmp_c1_36 = 0
        end
        material:SetFloat("$c2_y", __lux_tmp_c1_36)
      end
      do
        local __lux_tmp_c2_37 = c2
        if __lux_tmp_c2_37 == nil then
          __lux_tmp_c2_37 = 0
        end
        material:SetFloat("$c2_z", __lux_tmp_c2_37)
      end
      do
        local __lux_tmp_c3_38 = c3
        if __lux_tmp_c3_38 == nil then
          __lux_tmp_c3_38 = 0
        end
        material:SetFloat("$c2_w", __lux_tmp_c3_38)
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
            local __lux_tmp_count_39 = tickSpec.count
            if __lux_tmp_count_39 == nil then
              __lux_tmp_count_39 = 0
            end
            ticks = __lux_tmp_count_39
          end
        end
      end
      local __lux_tmp_ticks_40 = toNumber(ticks)
      if __lux_tmp_ticks_40 == nil then
        __lux_tmp_ticks_40 = 0
      end
      return glow, sheen, marker, mathClamp(mathFloor(__lux_tmp_ticks_40), 0, 31)
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
            local __lux_tmp_count_41 = tickSpec.count
            if __lux_tmp_count_41 == nil then
              __lux_tmp_count_41 = 0
            end
            ticks = __lux_tmp_count_41
          end
        end
      end
      local __lux_tmp_ticks_42 = toNumber(ticks)
      if __lux_tmp_ticks_42 == nil then
        __lux_tmp_ticks_42 = 0
      end
      return flags, mathClamp(mathFloor(__lux_tmp_ticks_42), 0, 31)
    end
    progressFillCanFast = function(fill)
      local __lux_match_43 = fill
      local __lux_tag_44
      if __lux_match_43 ~= nil then
        __lux_tag_44 = __lux_match_43.kind
      end
      if __lux_tag_44 == style.FILL_SOLID then
        return true
      elseif __lux_tag_44 == style.FILL_LINEAR then
        local x1 = __lux_match_43.x1
        local y1 = __lux_match_43.y1
        local x2 = __lux_match_43.x2
        local y2 = __lux_match_43.y2
        local __lux_tmp_x1_45 = x1
        if __lux_tmp_x1_45 == nil then
          __lux_tmp_x1_45 = 0
        end
        local __lux_tmp_47 = __lux_tmp_x1_45 == 0
        if __lux_tmp_47 then
          local __lux_tmp_y1_46 = y1
          if __lux_tmp_y1_46 == nil then
            __lux_tmp_y1_46 = 0
          end
          __lux_tmp_47 = __lux_tmp_y1_46 == 0
        end
        local __lux_tmp_49 = __lux_tmp_47
        if __lux_tmp_49 then
          local __lux_tmp_x2_48 = x2
          if __lux_tmp_x2_48 == nil then
            __lux_tmp_x2_48 = 1
          end
          __lux_tmp_49 = __lux_tmp_x2_48 == 1
        end
        local __lux_tmp_51 = __lux_tmp_49
        if __lux_tmp_51 then
          local __lux_tmp_y2_50 = y2
          if __lux_tmp_y2_50 == nil then
            __lux_tmp_y2_50 = 0
          end
          __lux_tmp_51 = __lux_tmp_y2_50 == 0
        end
        return __lux_tmp_51
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
        local __lux_tmp_stroke_52 = stroke
        if __lux_tmp_stroke_52 == nil then
          __lux_tmp_stroke_52 = transparentColor
        end
        r, g, b, a = style.color01(__lux_tmp_stroke_52)
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
        local __lux_tmp_flags_53 = toNumber(flags)
        if __lux_tmp_flags_53 == nil then
          __lux_tmp_flags_53 = 0
        end
        flags = mathClamp(mathFloor(__lux_tmp_flags_53), 0, 7)
      end
      do
        local __lux_tmp_ticks_54 = toNumber(ticks)
        if __lux_tmp_ticks_54 == nil then
          __lux_tmp_ticks_54 = 0
        end
        ticks = mathClamp(mathFloor(__lux_tmp_ticks_54), 0, 31)
      end
      do
        local __lux_tmp_radius_55 = toNumber(radius)
        if __lux_tmp_radius_55 == nil then
          __lux_tmp_radius_55 = 0
        end
        radius = mathClamp(__lux_tmp_radius_55, 0, 255)
      end
      do
        local __lux_tmp_inset_56 = toNumber(inset)
        if __lux_tmp_inset_56 == nil then
          __lux_tmp_inset_56 = 0
        end
        inset = mathClamp(mathFloor(__lux_tmp_inset_56), 0, 31)
      end
      do
        local __lux_tmp_strokeWidth_57 = toNumber(strokeWidth)
        if __lux_tmp_strokeWidth_57 == nil then
          __lux_tmp_strokeWidth_57 = 0
        end
        strokeWidth = mathClamp(mathFloor(__lux_tmp_strokeWidth_57), 0, 15)
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
        local __lux_tmp_stroke_58 = stroke
        if __lux_tmp_stroke_58 == nil then
          __lux_tmp_stroke_58 = transparentColor
        end
        r, g, b, a = style.color01(__lux_tmp_stroke_58)
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
      drawTexturedQuad(x, y, w, h)
      return true
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
      local __lux_tmp_colorA_59 = fill.colorA
      if __lux_tmp_colorA_59 == nil then
        __lux_tmp_colorA_59 = color_white
      end
      local __lux_tmp_colorB_60 = fill.colorB
      if __lux_tmp_colorB_60 == nil then
        __lux_tmp_colorB_60 = fill.colorA
      end
      if __lux_tmp_colorB_60 == nil then
        __lux_tmp_colorB_60 = color_white
      end
      return __lux_tmp_colorA_59, __lux_tmp_colorB_60
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
        local __lux_tmp_value_61 = toNumber(value)
        if __lux_tmp_value_61 == nil then
          __lux_tmp_value_61 = 0
        end
        local __lux_tmp_62
        if drawStyle.radius == nil then
          __lux_tmp_62 = mathMin(2, h * 0.35)
        else
          __lux_tmp_62 = drawStyle.radius
        end
        local __lux_tmp_toNumber_63 = toNumber(__lux_tmp_62)
        if __lux_tmp_toNumber_63 == nil then
          __lux_tmp_toNumber_63 = 0
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
          mathClamp(__lux_tmp_value_61, 0, 1),
          mathMax(0, __lux_tmp_toNumber_63),
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
        local __lux_tmp_value_64 = toNumber(value)
        if __lux_tmp_value_64 == nil then
          __lux_tmp_value_64 = 0
        end
        frac = mathClamp(__lux_tmp_value_64, 0, 1)
      end
      local radius = stripped.radius
      if radius == nil then
        radius = mathMin(4, h * 0.5)
      end
      local inset
      do
        local __lux_tmp_padding_65 = toNumber(stripped.padding)
        if __lux_tmp_padding_65 == nil then
          __lux_tmp_padding_65 = 0
        end
        inset = mathMax(0, __lux_tmp_padding_65)
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
        local __lux_tmp_r_66 = track.r
        if __lux_tmp_r_66 == nil then
          __lux_tmp_r_66 = 0
        end
        local __lux_tmp_g_67 = track.g
        if __lux_tmp_g_67 == nil then
          __lux_tmp_g_67 = 0
        end
        local __lux_tmp_b_68 = track.b
        if __lux_tmp_b_68 == nil then
          __lux_tmp_b_68 = 0
        end
        local __lux_tmp_a_69 = track.a
        if __lux_tmp_a_69 == nil then
          __lux_tmp_a_69 = 190
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
                mathFloor(__lux_tmp_r_66 * 0.65),
                mathFloor(__lux_tmp_g_67 * 0.65),
                mathFloor(__lux_tmp_b_68 * 0.65),
                __lux_tmp_a_69
              ),
              track
            ),
            stroke = stroke,
            strokeWidth = strokeWidth,
            shadow = stripped.shadow,
            outerGlow = stripped.outerGlow,
            innerGlow = stripped.innerGlow,
            backdrop = stripped.backdrop,
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
      if innerH <= 0 or innerW <= 0 then
        return
      end
      if glow and innerW > 4 then
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
        local __lux_tmp_fillPattern_70 = stripped.fillPattern
        if __lux_tmp_fillPattern_70 == nil then
          __lux_tmp_fillPattern_70 = stripped.pattern
        end
        roundrect.roundedBoxEx(
          x + inset,
          y + inset,
          innerW,
          innerH,
          {
            radius = mathMin(mathMax(0, radius - inset), innerH * 0.5, innerW * 0.5),
            fill = fill,
            pattern = __lux_tmp_fillPattern_70,
          }
        )
      end
      if sheen and innerW > 8 then
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
      if marker and innerW > 5 then
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
        local __lux_tmp_segments_71 = toNumber(stripped.segments)
        if __lux_tmp_segments_71 == nil then
          __lux_tmp_segments_71 = 10
        end
        count = mathClamp(mathFloor(__lux_tmp_segments_71), 1, 128)
      end
      local gap
      do
        local __lux_tmp_gap_72 = toNumber(stripped.gap)
        if __lux_tmp_gap_72 == nil then
          __lux_tmp_gap_72 = 2
        end
        gap = mathMax(0, __lux_tmp_gap_72)
      end
      local frac
      do
        local __lux_tmp_value_73 = toNumber(value)
        if __lux_tmp_value_73 == nil then
          __lux_tmp_value_73 = 0
        end
        frac = mathClamp(__lux_tmp_value_73, 0, 1)
      end
      local active = mathFloor(frac * count + 0.0001)
      local fill
      do
        local __lux_tmp_fill_74 = stripped.fill
        if __lux_tmp_fill_74 == nil then
          __lux_tmp_fill_74 = stripped.color
        end
        if __lux_tmp_fill_74 == nil then
          __lux_tmp_fill_74 = defaultSegmentFill
        end
        fill = style.fillFromStyle(__lux_tmp_fill_74)
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
        do
          local __lux_tmp_background_75 = stripped.background
          if __lux_tmp_background_75 == nil then
            __lux_tmp_background_75 = transparentColor
          end
          roundrect.roundedBoxEx(
            x,
            y,
            w,
            h,
            {
              radius = containerRadius,
              fill = __lux_tmp_background_75,
              shadow = stripped.shadow,
              outerGlow = stripped.outerGlow,
              innerGlow = stripped.innerGlow,
              backdrop = stripped.backdrop,
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
          pattern = stripped.fillPattern
          if pattern == nil then
            pattern = stripped.pattern
          end
        else
          pattern = stripped.trackPattern
        end
        if color ~= nil or pattern ~= nil then
          do
            local __lux_tmp_76
            if stripped.radius == nil then
              __lux_tmp_76 = mathMin(2, h * 0.35)
            else
              __lux_tmp_76 = stripped.radius
            end
            local __lux_tmp_color_77 = color
            if __lux_tmp_color_77 == nil then
              __lux_tmp_color_77 = transparentColor
            end
            local __lux_tmp_strokeWidth_78 = stripped.strokeWidth
            if __lux_tmp_strokeWidth_78 == nil then
              __lux_tmp_strokeWidth_78 = 0
            end
            roundrect.roundedBoxEx(
              sx,
              y,
              segmentW,
              h,
              {
                radius = __lux_tmp_76,
                fill = __lux_tmp_color_77,
                pattern = pattern,
                stroke = stripped.stroke,
                strokeWidth = __lux_tmp_strokeWidth_78,
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
        local __lux_tmp_endDeg_79 = endDeg
        if __lux_tmp_endDeg_79 == nil then
          __lux_tmp_endDeg_79 = 360
        end
        local __lux_tmp_startDeg_80 = startDeg
        if __lux_tmp_startDeg_80 == nil then
          __lux_tmp_startDeg_80 = 0
        end
        sweep = mathAbs(__lux_tmp_endDeg_79 - __lux_tmp_startDeg_80)
      end
      return mathClamp(mathFloor(sweep / 360 * fallback), 3, fallback)
    end
    ringModeValue = function(mode)
      local __lux_match_81 = mode
      if __lux_match_81 == "sector" or __lux_match_81 == 2 then
        return 2
      elseif __lux_match_81 == "arc" or __lux_match_81 == true or __lux_match_81 == 1 then
        return 1
      else
        return 0
      end
    end
    ringShapeConstants = function(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      local __lux_tmp_innerRadius_82 = toNumber(innerRadius)
      if __lux_tmp_innerRadius_82 == nil then
        __lux_tmp_innerRadius_82 = 0
      end
      local __lux_tmp_outerRadius_83 = toNumber(outerRadius)
      if __lux_tmp_outerRadius_83 == nil then
        __lux_tmp_outerRadius_83 = mathMin(w, h) * 0.5
      end
      local __lux_tmp_startDeg_84 = toNumber(startDeg)
      if __lux_tmp_startDeg_84 == nil then
        __lux_tmp_startDeg_84 = 0
      end
      local __lux_tmp_endDeg_85 = toNumber(endDeg)
      if __lux_tmp_endDeg_85 == nil then
        __lux_tmp_endDeg_85 = 360
      end
      return w, h, mathMax(0, __lux_tmp_innerRadius_82), mathMax(0.001, __lux_tmp_outerRadius_83), mathRad(__lux_tmp_startDeg_84), mathRad(__lux_tmp_endDeg_85), ringModeValue(mode)
    end
    ringFillParams = function(fill)
      local __lux_match_86 = fill
      local __lux_tag_87
      if __lux_match_86 ~= nil then
        __lux_tag_87 = __lux_match_86.kind
      end
      if __lux_tag_87 == style.FILL_LINEAR then
        local x1 = __lux_match_86.x1
        local y1 = __lux_match_86.y1
        local x2 = __lux_match_86.x2
        local y2 = __lux_match_86.y2
        local __lux_tmp_x1_88 = x1
        if __lux_tmp_x1_88 == nil then
          __lux_tmp_x1_88 = 0
        end
        local __lux_tmp_y1_89 = y1
        if __lux_tmp_y1_89 == nil then
          __lux_tmp_y1_89 = 0
        end
        local __lux_tmp_x2_90 = x2
        if __lux_tmp_x2_90 == nil then
          __lux_tmp_x2_90 = 1
        end
        local __lux_tmp_y2_91 = y2
        if __lux_tmp_y2_91 == nil then
          __lux_tmp_y2_91 = 0
        end
        return __lux_tmp_x1_88, __lux_tmp_y1_89, __lux_tmp_x2_90, __lux_tmp_y2_91
      elseif __lux_tag_87 == style.FILL_RADIAL then
        local cx = __lux_match_86.cx
        local cy = __lux_match_86.cy
        local radius = __lux_match_86.radius
        local localRadial = fill.localRadial == true or fill.ringRadial == true or fill.sectorRadial == true
        local __lux_tmp_cx_92 = cx
        if __lux_tmp_cx_92 == nil then
          __lux_tmp_cx_92 = 0.5
        end
        local __lux_tmp_cy_93 = cy
        if __lux_tmp_cy_93 == nil then
          __lux_tmp_cy_93 = 0.5
        end
        local __lux_tmp_radius_94 = radius
        if __lux_tmp_radius_94 == nil then
          __lux_tmp_radius_94 = 0.5
        end
        local __lux_tmp_95
        if localRadial then
          __lux_tmp_95 = 1
        else
          __lux_tmp_95 = 0
        end
        return __lux_tmp_cx_92, __lux_tmp_cy_93, __lux_tmp_radius_94, __lux_tmp_95
      elseif __lux_tag_87 == style.FILL_CONIC then
        local cx = __lux_match_86.cx
        local cy = __lux_match_86.cy
        local rotation = __lux_match_86.rotation
        local localAngular = fill.localAngular == true or fill.shapeAngular == true
        local __lux_tmp_cx_96 = cx
        if __lux_tmp_cx_96 == nil then
          __lux_tmp_cx_96 = 0.5
        end
        local __lux_tmp_cy_97 = cy
        if __lux_tmp_cy_97 == nil then
          __lux_tmp_cy_97 = 0.5
        end
        local __lux_tmp_98
        if localAngular then
          __lux_tmp_98 = 1
        else
          __lux_tmp_98 = 0
        end
        return __lux_tmp_cx_96, __lux_tmp_cy_97, style.normalizedRotation(rotation), __lux_tmp_98
      else
        local __lux_unused_99 = nil
      end
      return 0, 0, 1, 0
    end
    ringFillNeedsLut = function(fill)
      local __lux_match_100 = fill
      local __lux_tag_101
      if __lux_match_100 ~= nil then
        __lux_tag_101 = __lux_match_100.kind
      end
      if __lux_tag_101 == style.FILL_LINEAR or __lux_tag_101 == style.FILL_RADIAL or __lux_tag_101 == style.FILL_CONIC then
        return true
      else
        return false
      end
    end
    ringLineStyle = function(width, fill, drawStyle)
      local __lux_obj_drawStyle_102 = drawStyle
      local __lux_val_outerGlow_103 = nil
      if __lux_obj_drawStyle_102 ~= nil then
        __lux_val_outerGlow_103 = __lux_obj_drawStyle_102.outerGlow
      end
      local __lux_obj_drawStyle_104 = drawStyle
      local __lux_val_backdrop_105 = nil
      if __lux_obj_drawStyle_104 ~= nil then
        __lux_val_backdrop_105 = __lux_obj_drawStyle_104.backdrop
      end
      return {
        width = width,
        fill = fill,
        noCaps = false,
        outerGlow = __lux_val_outerGlow_103,
        backdrop = __lux_val_backdrop_105,
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
        local __lux_tmp_segments_106 = drawStyle.segments
        if __lux_tmp_segments_106 == nil then
          __lux_tmp_segments_106 = 64
        end
        segments = arcSegmentCount(outerRadius, startDeg, endDeg, __lux_tmp_segments_106)
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
          local __lux_tmp_innerRadius_109 = toNumber(drawStyle.innerRadius)
          if __lux_tmp_innerRadius_109 == nil then
            __lux_tmp_innerRadius_109 = mathMax(0, outerRadius - arcWidth)
          end
          innerRadius = mathClamp(__lux_tmp_innerRadius_109, 0, outerRadius)
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
      drawTexturedQuad(x, y, w, h)
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
          local __lux_tmp_color_112 = innerSpec.color
          if __lux_tmp_color_112 == nil then
            __lux_tmp_color_112 = transparentColor
          end
          gr, gg, gb, ga = style.color01(__lux_tmp_color_112)
        end
        do
          local __lux_tmp_width_113 = toNumber(innerSpec.width)
          if __lux_tmp_width_113 == nil then
            __lux_tmp_width_113 = 8
          end
          glowWidth = mathMax(0.001, __lux_tmp_width_113)
        end
        do
          local __lux_tmp_strength_114 = toNumber(innerSpec.strength)
          if __lux_tmp_strength_114 == nil then
            __lux_tmp_strength_114 = 1
          end
          glowStrength = mathMax(0, __lux_tmp_strength_114)
        end
        do
          local __lux_tmp_falloff_115 = toNumber(innerSpec.falloff)
          if __lux_tmp_falloff_115 == nil then
            __lux_tmp_falloff_115 = 1.65
          end
          glowFalloff = mathMax(0.001, __lux_tmp_falloff_115)
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
        local __lux_tmp_kind_116 = fill.kind
        if __lux_tmp_kind_116 == nil then
          __lux_tmp_kind_116 = style.FILL_SOLID
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
          __lux_tmp_kind_116,
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
        local __lux_tmp_colorA_117 = fill.colorA
        if __lux_tmp_colorA_117 == nil then
          __lux_tmp_colorA_117 = color_white
        end
        style.setDrawColor(__lux_tmp_colorA_117)
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h)
      return true
    end
    drawRingInnerGlowPass = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, spec)
      if spec == nil or not shadersActive() or not materialOK(widgetMaterials.ring_innerglow) then
        return false
      end
      local color = spec.color
      local __lux_tmp_120 = color == nil
      if not __lux_tmp_120 then
        local __lux_tmp_a_119 = color.a
        if __lux_tmp_a_119 == nil then
          __lux_tmp_a_119 = 255
        end
        __lux_tmp_120 = __lux_tmp_a_119 <= 0
      end
      if __lux_tmp_120 then
        return false
      end
      local material = widgetMaterials.ring_innerglow
      local r, g, b, a = style.color01(color)
      local sw, sh, ir, orad, sr, er, modeValue = ringShapeConstants(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      do
        local __lux_tmp_width_121 = toNumber(spec.width)
        if __lux_tmp_width_121 == nil then
          __lux_tmp_width_121 = 8
        end
        local __lux_tmp_strength_122 = toNumber(spec.strength)
        if __lux_tmp_strength_122 == nil then
          __lux_tmp_strength_122 = 1
        end
        local __lux_tmp_falloff_123 = toNumber(spec.falloff)
        if __lux_tmp_falloff_123 == nil then
          __lux_tmp_falloff_123 = 1.65
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
          mathMax(0.001, __lux_tmp_width_121),
          mathMax(0, __lux_tmp_strength_122),
          mathMax(0.001, __lux_tmp_falloff_123),
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
      if spec == nil or not shadersActive() or not materialOK(widgetMaterials.ring_outerglow) then
        return false
      end
      local color = spec.color
      local __lux_tmp_126 = color == nil
      if not __lux_tmp_126 then
        local __lux_tmp_a_125 = color.a
        if __lux_tmp_a_125 == nil then
          __lux_tmp_a_125 = 255
        end
        __lux_tmp_126 = __lux_tmp_a_125 <= 0
      end
      if __lux_tmp_126 then
        return false
      end
      local grow
      do
        local __lux_tmp_grow_127 = spec.grow
        if __lux_tmp_grow_127 == nil then
          __lux_tmp_grow_127 = spec.shapeSpread
        end
        if __lux_tmp_grow_127 == nil then
          __lux_tmp_grow_127 = spec.expand
        end
        local __lux_tmp_grow_128 = toNumber(__lux_tmp_grow_127)
        if __lux_tmp_grow_128 == nil then
          __lux_tmp_grow_128 = 0
        end
        grow = mathMax(0, __lux_tmp_grow_128)
      end
      local ox
      do
        local __lux_tmp_x_129 = spec.x
        if __lux_tmp_x_129 == nil then
          __lux_tmp_x_129 = spec.offsetX
        end
        if __lux_tmp_x_129 == nil then
          __lux_tmp_x_129 = spec.dx
        end
        ox = toNumber(__lux_tmp_x_129)
        if ox == nil then
          ox = 0
        end
      end
      local oy
      do
        local __lux_tmp_y_130 = spec.y
        if __lux_tmp_y_130 == nil then
          __lux_tmp_y_130 = spec.offsetY
        end
        if __lux_tmp_y_130 == nil then
          __lux_tmp_y_130 = spec.dy
        end
        oy = toNumber(__lux_tmp_y_130)
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
        local __lux_tmp_innerRadius_131 = toNumber(innerRadius)
        if __lux_tmp_innerRadius_131 == nil then
          __lux_tmp_innerRadius_131 = 0
        end
        gi = mathMax(0, __lux_tmp_innerRadius_131 - grow)
      end
      local go
      do
        local __lux_tmp_outerRadius_132 = toNumber(outerRadius)
        if __lux_tmp_outerRadius_132 == nil then
          __lux_tmp_outerRadius_132 = mathMin(w, h) * 0.5
        end
        go = mathMax(0.001, __lux_tmp_outerRadius_132 + grow)
      end
      local spread
      do
        local __lux_tmp_spread_133 = spec.spread
        if __lux_tmp_spread_133 == nil then
          __lux_tmp_spread_133 = spec.width
        end
        local __lux_tmp_spread_134 = toNumber(__lux_tmp_spread_133)
        if __lux_tmp_spread_134 == nil then
          __lux_tmp_spread_134 = 18
        end
        spread = mathMax(1, __lux_tmp_spread_134)
      end
      local material = widgetMaterials.ring_outerglow
      local r, g, b, a = style.color01(color)
      local sw, sh, ir, orad, sr, er, modeValue = ringShapeConstants(gw, gh, gi, go, startDeg, endDeg, mode)
      do
        local __lux_tmp_width_135 = toNumber(spec.width)
        if __lux_tmp_width_135 == nil then
          __lux_tmp_width_135 = spread
        end
        local __lux_tmp_strength_136 = toNumber(spec.strength)
        if __lux_tmp_strength_136 == nil then
          __lux_tmp_strength_136 = 1
        end
        local __lux_tmp_falloff_137 = toNumber(spec.falloff)
        if __lux_tmp_falloff_137 == nil then
          __lux_tmp_falloff_137 = 1.9
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
          mathMax(0.001, __lux_tmp_width_135),
          mathMax(0, __lux_tmp_strength_136),
          mathMax(0.001, __lux_tmp_falloff_137),
          0
        )
      end
      surfaceSetMaterial(material)
      surfaceSetDrawColor(255, 255, 255, 255)
      drawTexturedQuad(gx - spread, gy - spread, gw + spread * 2, gh + spread * 2)
      return true
    end
    ringBackdropTintColor = function(spec)
      if spec == nil or spec.tint == nil then
        return nil
      end
      local tint = spec.tint
      local alpha
      do
        local __lux_tmp_a_138 = tint.a
        if __lux_tmp_a_138 == nil then
          __lux_tmp_a_138 = 255
        end
        local __lux_tmp_opacity_139 = spec.opacity
        if __lux_tmp_opacity_139 == nil then
          __lux_tmp_opacity_139 = 1
        end
        alpha = __lux_tmp_a_138 * __lux_tmp_opacity_139
      end
      if alpha <= 0 then
        return nil
      end
      local __lux_tmp_r_140 = tint.r
      if __lux_tmp_r_140 == nil then
        __lux_tmp_r_140 = 0
      end
      local __lux_tmp_g_141 = tint.g
      if __lux_tmp_g_141 == nil then
        __lux_tmp_g_141 = 0
      end
      local __lux_tmp_b_142 = tint.b
      if __lux_tmp_b_142 == nil then
        __lux_tmp_b_142 = 0
      end
      return makeColor(
        __lux_tmp_r_140,
        __lux_tmp_g_141,
        __lux_tmp_b_142,
        mathFloor(mathClamp(alpha, 0, 255) + 0.5)
      )
    end
    setupRingBackdropConstants = function(material, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, vertical, intensity)
      local sw, sh, ir, orad, sr, er, modeValue = ringShapeConstants(w, h, innerRadius, outerRadius, startDeg, endDeg, mode)
      local __lux_tmp_intensity_143 = intensity
      if __lux_tmp_intensity_143 == nil then
        __lux_tmp_intensity_143 = 1
      end
      return setupParamMatrix(
        material,
        vertical and 1 or 0,
        __lux_tmp_intensity_143,
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
      if spec.blur > 0 and widgetBlurRT ~= nil and renderCopyRenderTargetToTexture ~= nil and materialOK(widgetMaterials.ring_backdrop) then
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
      if spec == nil or not shadersActive() or not materialOK(widgetMaterials.ring_pattern) then
        return false
      end
      local material = widgetMaterials.ring_pattern
      local angle
      do
        local __lux_tmp_angle_144 = toNumber(spec.angle)
        if __lux_tmp_angle_144 == nil then
          __lux_tmp_angle_144 = 135
        end
        angle = mathRad(__lux_tmp_angle_144)
      end
      local smoke
      local __lux_match_145 = spec.kind
      if __lux_match_145 == "smoke" then
        smoke = true
      else
        smoke = false
      end
      local pz
      if smoke then
        do
          local __lux_tmp_scale_146 = toNumber(spec.scale)
          if __lux_tmp_scale_146 == nil then
            __lux_tmp_scale_146 = 140
          end
          pz = mathMax(1, __lux_tmp_scale_146)
        end
      else
        do
          local __lux_tmp_spacing_147 = toNumber(spec.spacing)
          if __lux_tmp_spacing_147 == nil then
            __lux_tmp_spacing_147 = 12
          end
          pz = mathMax(1, __lux_tmp_spacing_147)
        end
      end
      local pw
      if smoke then
        do
          local __lux_tmp_density_148 = toNumber(spec.density)
          if __lux_tmp_density_148 == nil then
            __lux_tmp_density_148 = 0.48
          end
          pw = mathClamp(__lux_tmp_density_148, 0, 1)
        end
      else
        do
          local __lux_tmp_width_149 = toNumber(spec.width)
          if __lux_tmp_width_149 == nil then
            __lux_tmp_width_149 = 2
          end
          pw = mathMax(0.25, __lux_tmp_width_149)
        end
      end
      do
        local __lux_tmp_150
        if smoke then
          __lux_tmp_150 = toNumber(spec.seed)
          if __lux_tmp_150 == nil then
            __lux_tmp_150 = 0
          end
        else
          __lux_tmp_150 = 0
        end
        local __lux_tmp_151
        if smoke then
          do
            local __lux_tmp_softness_152 = toNumber(spec.softness)
            if __lux_tmp_softness_152 == nil then
              __lux_tmp_softness_152 = 0.3
            end
            __lux_tmp_151 = mathMax(0.001, __lux_tmp_softness_152)
          end
        else
          __lux_tmp_151 = 0
        end
        local __lux_tmp_153
        if smoke then
          do
            local __lux_tmp_warp_154 = toNumber(spec.warp)
            if __lux_tmp_warp_154 == nil then
              __lux_tmp_warp_154 = 0.85
            end
            __lux_tmp_153 = mathMax(0, __lux_tmp_warp_154)
          end
        else
          __lux_tmp_153 = 0
        end
        local __lux_tmp_innerRadius_155 = toNumber(innerRadius)
        if __lux_tmp_innerRadius_155 == nil then
          __lux_tmp_innerRadius_155 = 0
        end
        local __lux_tmp_outerRadius_156 = toNumber(outerRadius)
        if __lux_tmp_outerRadius_156 == nil then
          __lux_tmp_outerRadius_156 = mathMin(w, h) * 0.5
        end
        local __lux_tmp_startDeg_157 = toNumber(startDeg)
        if __lux_tmp_startDeg_157 == nil then
          __lux_tmp_startDeg_157 = 0
        end
        local __lux_tmp_endDeg_158 = toNumber(endDeg)
        if __lux_tmp_endDeg_158 == nil then
          __lux_tmp_endDeg_158 = 360
        end
        local __lux_tmp_159
        if smoke then
          __lux_tmp_159 = 1
        else
          __lux_tmp_159 = 0
        end
        setupParamMatrix(
          material,
          __lux_tmp_150,
          roundrect.patternOffset(spec),
          __lux_tmp_151,
          __lux_tmp_153,
          w,
          h,
          mathMax(0, __lux_tmp_innerRadius_155),
          mathMax(0.001, __lux_tmp_outerRadius_156),
          mathRad(__lux_tmp_startDeg_157),
          mathRad(__lux_tmp_endDeg_158),
          ringModeValue(mode),
          __lux_tmp_159,
          mathCos(angle),
          mathSin(angle),
          pz,
          pw
        )
      end
      do
        local __lux_tmp_color_160 = spec.color
        if __lux_tmp_color_160 == nil then
          __lux_tmp_color_160 = spec.tint
        end
        if __lux_tmp_color_160 == nil then
          __lux_tmp_color_160 = makeColor(255, 255, 255, 24)
        end
        style.setDrawColor(__lux_tmp_color_160)
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h)
      return true
    end
    drawRingBox = function(x, y, w, h, innerRadius, outerRadius, startDeg, endDeg, mode, drawStyle)
      if drawStyle == nil then
        drawStyle = {}
      end
      local fill
      do
        local __lux_tmp_fill_161 = drawStyle.fill
        if __lux_tmp_fill_161 == nil then
          __lux_tmp_fill_161 = drawStyle.color
        end
        if __lux_tmp_fill_161 == nil then
          __lux_tmp_fill_161 = defaultRingFill
        end
        fill = style.fillFromStyle(__lux_tmp_fill_161)
      end
      if not shadersActive() or not materialOK(widgetMaterials.ring) then
        local __lux_table_162 = {}
        local __lux_spread_163 = drawStyle
        if __lux_spread_163 ~= nil then
          for __lux_k_164, __lux_v_165 in pairs(__lux_spread_163) do
            __lux_table_162[__lux_k_164] = __lux_v_165
          end
        end
        __lux_table_162.fill = fill
        __lux_table_162.innerRadius = innerRadius
        return drawRingFallback(
          x + w * 0.5,
          y + h * 0.5,
          outerRadius,
          outerRadius - innerRadius,
          startDeg,
          endDeg,
          mode,
          __lux_table_162
        )
      end
      local shadow = roundrect.shadowStyle(drawStyle.shadow)
      if shadow ~= nil then
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
          shadow
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
        local __lux_tmp_radius_166 = toNumber(radius)
        if __lux_tmp_radius_166 == nil then
          __lux_tmp_radius_166 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_radius_166)
      end
      local ringWidth
      do
        local __lux_tmp_width_167 = toNumber(width)
        if __lux_tmp_width_167 == nil then
          __lux_tmp_width_167 = mathMax(1, outerRadius * 0.18)
        end
        ringWidth = mathMax(0.001, __lux_tmp_width_167)
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
        local __lux_tmp_radius_168 = toNumber(radius)
        if __lux_tmp_radius_168 == nil then
          __lux_tmp_radius_168 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_radius_168)
      end
      local arcWidth
      do
        local __lux_tmp_width_169 = toNumber(width)
        if __lux_tmp_width_169 == nil then
          __lux_tmp_width_169 = mathMax(1, outerRadius * 0.18)
        end
        arcWidth = mathMax(0.001, __lux_tmp_width_169)
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
        local __lux_tmp_outerRadius_170 = toNumber(outerRadius)
        if __lux_tmp_outerRadius_170 == nil then
          __lux_tmp_outerRadius_170 = 0
        end
        outerRadius = mathMax(0.001, __lux_tmp_outerRadius_170)
      end
      do
        local __lux_tmp_innerRadius_171 = toNumber(innerRadius)
        if __lux_tmp_innerRadius_171 == nil then
          __lux_tmp_innerRadius_171 = 0
        end
        innerRadius = mathClamp(__lux_tmp_innerRadius_171, 0, outerRadius)
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
            local __lux_tmp_172
            if material ~= nil and material.IsError ~= nil and not material:IsError() then
              __lux_tmp_172 = material
            else
              __lux_tmp_172 = false
            end
            cached = __lux_tmp_172
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
        local __lux_tmp_texture_173 = texture
        if __lux_tmp_texture_173 == nil then
          __lux_tmp_texture_173 = false
        end
        imageWhiteTexture = __lux_tmp_texture_173
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
      local __lux_match_174 = kind
      if __lux_match_174 == "round" or __lux_match_174 == "rounded" or __lux_match_174 == "roundedbox" or __lux_match_174 == "roundrect" then
        return 0
      elseif __lux_match_174 == "chamfer" or __lux_match_174 == "bevel" then
        return 1
      elseif __lux_match_174 == "circle" then
        return 2
      elseif __lux_match_174 == "capsule" or __lux_match_174 == "pill" then
        return 3
      elseif __lux_match_174 == "texture" or __lux_match_174 == "alpha" or __lux_match_174 == "image" then
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
      local __lux_match_175 = normalized
      if __lux_match_175 == "a" or __lux_match_175 == "alpha" then
        return 10
      elseif __lux_match_175 == "r" or __lux_match_175 == "red" then
        return 11
      elseif __lux_match_175 == "g" or __lux_match_175 == "green" then
        return 12
      elseif __lux_match_175 == "b" or __lux_match_175 == "blue" then
        return 13
      elseif __lux_match_175 == "luma" or __lux_match_175 == "lum" or __lux_match_175 == "luminance" or __lux_match_175 == "rgb" then
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
        local __lux_tmp_u0_176 = mask.u0
        if __lux_tmp_u0_176 == nil then
          __lux_tmp_u0_176 = mask.x0
        end
        if __lux_tmp_u0_176 == nil then
          __lux_tmp_u0_176 = mask[1]
        end
        u0 = toNumber(__lux_tmp_u0_176)
        if u0 == nil then
          u0 = 0
        end
      end
      local v0
      do
        local __lux_tmp_v0_177 = mask.v0
        if __lux_tmp_v0_177 == nil then
          __lux_tmp_v0_177 = mask.y0
        end
        if __lux_tmp_v0_177 == nil then
          __lux_tmp_v0_177 = mask[2]
        end
        v0 = toNumber(__lux_tmp_v0_177)
        if v0 == nil then
          v0 = 0
        end
      end
      local u1
      do
        local __lux_tmp_u1_178 = mask.u1
        if __lux_tmp_u1_178 == nil then
          __lux_tmp_u1_178 = mask.x1
        end
        if __lux_tmp_u1_178 == nil then
          __lux_tmp_u1_178 = mask[3]
        end
        u1 = toNumber(__lux_tmp_u1_178)
        if u1 == nil then
          u1 = 1
        end
      end
      local v1
      do
        local __lux_tmp_v1_179 = mask.v1
        if __lux_tmp_v1_179 == nil then
          __lux_tmp_v1_179 = mask.y1
        end
        if __lux_tmp_v1_179 == nil then
          __lux_tmp_v1_179 = mask[4]
        end
        v1 = toNumber(__lux_tmp_v1_179)
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
      local __lux_match_180 = resolvedMask
      local __lux_tag_181
      if __lux_match_180 ~= nil then
        __lux_tag_181 = __lux_match_180.kind
      end
      if __lux_tag_181 == "chamfer" then
        local cuts = __lux_match_180.cuts
        local __lux_tmp_cuts_182 = cuts
        if __lux_tmp_cuts_182 == nil then
          __lux_tmp_cuts_182 = 0
        end
        return __lux_tmp_cuts_182
      else
        return nil
      end
    end
    imageChamferMaskTuple = function(mask, w, h)
      local cuts = mask ~= nil and mask.cuts or 0
      return primitives.chamferTuple(cuts, w, h)
    end
    setupImageMaskConstants = function(material, w, h, sourceU0, sourceV0, sourceU1, sourceV1, stroke, strokeWidth, mask, kind, maskTexture)
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
    drawImageMaskPass = function(x, y, w, h, texture, u0, v0, u1, v1, tint, stroke, strokeWidth, mask, kind, maskTexture)
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
        maskTexture
      )
      do
        local __lux_tmp_tint_183 = tint
        if __lux_tmp_tint_183 == nil then
          __lux_tmp_tint_183 = color_white
        end
        style.setDrawColor(__lux_tmp_tint_183)
      end
      surfaceSetMaterial(material)
      drawTexturedQuad(x, y, w, h)
      return true
    end
    imageBackdropTintColor = function(spec)
      if spec == nil or spec.tint == nil then
        return nil
      end
      local tint = spec.tint
      local alpha
      do
        local __lux_tmp_a_184 = tint.a
        if __lux_tmp_a_184 == nil then
          __lux_tmp_a_184 = 255
        end
        local __lux_tmp_opacity_185 = spec.opacity
        if __lux_tmp_opacity_185 == nil then
          __lux_tmp_opacity_185 = 1
        end
        alpha = __lux_tmp_a_184 * __lux_tmp_opacity_185
      end
      if alpha <= 0 then
        return nil
      end
      local __lux_tmp_r_186 = tint.r
      if __lux_tmp_r_186 == nil then
        __lux_tmp_r_186 = 0
      end
      local __lux_tmp_g_187 = tint.g
      if __lux_tmp_g_187 == nil then
        __lux_tmp_g_187 = 0
      end
      local __lux_tmp_b_188 = tint.b
      if __lux_tmp_b_188 == nil then
        __lux_tmp_b_188 = 0
      end
      return makeColor(
        __lux_tmp_r_186,
        __lux_tmp_g_187,
        __lux_tmp_b_188,
        mathFloor(mathClamp(alpha, 0, 255) + 0.5)
      )
    end
    setupImageMaskBackdropConstants = function(material, w, h, mask, kind, maskTexture, vertical, intensity)
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
          if maskTexture ~= nil then
            material:SetTexture("$texture2", maskTexture)
          end
        end
      end
      local __lux_tmp_intensity_189 = intensity
      if __lux_tmp_intensity_189 == nil then
        __lux_tmp_intensity_189 = 1
      end
      return setupParamMatrix(
        material,
        vertical and 1 or 0,
        __lux_tmp_intensity_189,
        0,
        0,
        w,
        h,
        packedKind,
        mask ~= nil and geometry.imageRadius(mask.radius, w, h) or 0,
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
      if spec == nil or typeOf(mask) ~= "table" or kind == nil then
        return nil
      end
      if imageMaskUsesTexture(kind) and maskTexture == nil then
        return nil
      end
      if spec.blur > 0 and widgetBlurRT ~= nil and renderCopyRenderTargetToTexture ~= nil and materialOK(widgetMaterials.image_mask_backdrop) then
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
        maskTexture
      )
    end
    drawImageMaskOuterGlow = function(x, y, w, h, mask, kind, glow)
      local spec = glow
      if spec == nil or typeOf(mask) ~= "table" or not materialOK(widgetMaterials.image_mask_outerglow) then
        return false
      end
      if kind == nil then
        kind = imageMaskKindValue(mask)
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
        local __lux_tmp_spread_190 = spec.spread
        if __lux_tmp_spread_190 == nil then
          __lux_tmp_spread_190 = spec.width
        end
        local __lux_tmp_spread_191 = toNumber(__lux_tmp_spread_190)
        if __lux_tmp_spread_191 == nil then
          __lux_tmp_spread_191 = 18
        end
        spread = mathMax(1, __lux_tmp_spread_191)
      end
      local ox
      do
        local __lux_tmp_x_192 = spec.x
        if __lux_tmp_x_192 == nil then
          __lux_tmp_x_192 = spec.offsetX
        end
        if __lux_tmp_x_192 == nil then
          __lux_tmp_x_192 = spec.dx
        end
        ox = toNumber(__lux_tmp_x_192)
        if ox == nil then
          ox = 0
        end
      end
      local oy
      do
        local __lux_tmp_y_193 = spec.y
        if __lux_tmp_y_193 == nil then
          __lux_tmp_y_193 = spec.offsetY
        end
        if __lux_tmp_y_193 == nil then
          __lux_tmp_y_193 = spec.dy
        end
        oy = toNumber(__lux_tmp_y_193)
        if oy == nil then
          oy = 0
        end
      end
      local material = widgetMaterials.image_mask_outerglow
      local r, g, b, a
      do
        local __lux_tmp_color_194 = spec.color
        if __lux_tmp_color_194 == nil then
          __lux_tmp_color_194 = makeColor(76, 190, 255, 88)
        end
        r, g, b, a = style.color01(__lux_tmp_color_194)
      end
      local glowR = r
      local glowG = g
      local glowB = b
      local glowA = a
      local packedKind = kind
      if mask.invert or mask.inverse then
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
        local __lux_tmp_strength_195 = spec.strength
        if __lux_tmp_strength_195 == nil then
          __lux_tmp_strength_195 = spec.opacity
        end
        local __lux_tmp_strength_196 = toNumber(__lux_tmp_strength_195)
        if __lux_tmp_strength_196 == nil then
          __lux_tmp_strength_196 = 1
        end
        local __lux_tmp_falloff_197 = toNumber(spec.falloff)
        if __lux_tmp_falloff_197 == nil then
          __lux_tmp_falloff_197 = 1.8
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
          mask ~= nil and geometry.imageRadius(mask.radius, w, h) or 0,
          spread,
          mathMax(0, __lux_tmp_strength_196),
          mathClamp(1 / mathMax(__lux_tmp_falloff_197, 0.001), 0.1, 1),
          0,
          p0,
          p1,
          p2,
          p3
        )
      end
      surfaceSetDrawColor(255, 255, 255, 255)
      surfaceSetMaterial(material)
      drawTexturedQuad(x + ox - spread, y + oy - spread, w + spread * 2, h + spread * 2)
      return true
    end
  end
  do
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
      local __lux_tmp_200 = background ~= nil
      if __lux_tmp_200 then
        local __lux_tmp_a_199 = background.a
        if __lux_tmp_a_199 == nil then
          __lux_tmp_a_199 = 255
        end
        __lux_tmp_200 = __lux_tmp_a_199 > 0
      end
      if __lux_tmp_200 then
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
      if drawStyle.shadow ~= nil then
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
      local background = drawStyle.fill
      if background == nil then
        background = drawStyle.background
      end
      local __lux_tmp_203 = background ~= nil
      if __lux_tmp_203 then
        local __lux_tmp_a_202 = background.a
        if __lux_tmp_a_202 == nil then
          __lux_tmp_a_202 = 255
        end
        __lux_tmp_203 = __lux_tmp_a_202 > 0
      end
      if __lux_tmp_203 then
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
      local __lux_match_204 = maskKind
      if __lux_match_204 == 2 or __lux_match_204 == 3 then
        return mathMin(w, h) * 0.5
      elseif __lux_match_204 == 0 then
        if mask ~= nil and mask.radius ~= nil then
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
      if not shadersActive() or not materialOK(widgetMaterials.roundrect_texture) then
        drawImageFallback(x, y, w, h, source, resolved)
        return
      end
      local u0, v0, u1, v1 = geometry.imageUV(resolved, texture)
      x, y, w, h, u0, v0, u1, v1 = geometry.imageFitRect(x, y, w, h, texture, resolved, u0, v0, u1, v1)
      if w <= 0 or h <= 0 then
        return
      end
      local mask = style.imageMaskStyle(resolved.mask, resolved)
      local maskKind = imageMaskKindValue(mask)
      local backdrop = style.backdropStyle(resolved.backdrop)
      if backdrop ~= nil and mask == nil then
        mask = { kind = "texture", source = source, channel = "alpha" }
        maskKind = 10
      end
      if imageMaskUsesTexture(maskKind) then
        local maskTexture = imageMaskTextureSource(mask)
        local backdropMaskKind = imageMaskTextureChannelKind(mask.channel)
        if backdropMaskKind == nil then
          backdropMaskKind = maskKind
        end
        drawImageMaskOuterGlow(
          x,
          y,
          w,
          h,
          mask,
          maskKind,
          roundrect.shadowStyle(resolved.shadow)
        )
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
      if cuts ~= nil and drawImageChamfer(x, y, w, h, texture, u0, v0, u1, v1, resolved, cuts) then
        return
      end
      local radius = imageRoundedRadius(resolved, mask, maskKind, w, h)
      if resolved.shadow ~= nil then
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
      local background = resolved.fill
      if background == nil then
        background = resolved.background
      end
      local __lux_tmp_207 = background ~= nil
      if __lux_tmp_207 then
        local __lux_tmp_a_206 = background.a
        if __lux_tmp_a_206 == nil then
          __lux_tmp_a_206 = 255
        end
        __lux_tmp_207 = __lux_tmp_a_206 > 0
      end
      if __lux_tmp_207 then
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
