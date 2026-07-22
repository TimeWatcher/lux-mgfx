return function(__lux_import)
  local __lux_exports = {}
  local tableEmpty
  local typeOf
  local makeColor
  local colorDrawStyleCache
  local transparentFillColor
  local installTargets
  local clearFrameStatTables
  local resetFrameStats
  local installFrameStatsReset
  local colorDrawStyle
  local normalizeDrawStyle
  local compileDrawStyle
  local installNormalizedDrawApi
  local installProfileWrappers
  local install
  local installGlobal
  local create
  local defaultRuntime
  local TARGET_ROUNDED_BOX
  local TARGET_CHAMFER_BOX
  local TARGET_POLY
  local TARGET_LINE
  local TARGET_CIRCLE
  local TARGET_CAPSULE
  local TARGET_IMAGE
  local TARGET_PROGRESS_BAR
  local TARGET_SEGMENT_BAR
  local TARGET_RING
  local TARGET_ARC
  local TARGET_TEXT
  local TARGET_SECTOR
  local resolvedStyle
  local solid
  local linearGradient
  local linearGradientStops
  local radialGradient
  local ringRadialGradient
  local sectorRadialGradient
  local conicGradient
  local shapeAngularGradient
  local ringAngularGradient
  local arcAngularGradient
  local sectorAngularGradient
  local stripePattern
  local smokePattern
  local wornPattern
  local mask
  local backdrop
  local compileBackdrop
  local compileStyle
  local backdropStyle
  local imageMaskStyle
  local fillFromStyle
  local colorAtFill
  local normalizedRotation
  local glowSoftnessToFalloff
  local gradientLutForFill
  local bindGradientLut
  local gradientLutStatus
  local getCapabilities
  local supports
  local normalizeStyle
  local startPanel
  local endPanel
  local startScreen
  local endScreen
  local pushClip
  local popClip
  local debugOverlay
  local transform
  local projectedQuad
  local pointerTilt
  local pushTransform
  local popTransform
  local transformPoint
  local untransformPoint
  local roundedBoxEx
  local roundedBox
  local roundedBoxBackdrop
  local circleEx
  local circle
  local capsuleEx
  local capsule
  local chamferBoxEx
  local chamferBox
  local regularPolyEx
  local regularPoly
  local diamondEx
  local diamond
  local caretEx
  local caret
  local polyEx
  local poly
  local lineEx
  local line
  local lineNoCaps
  local progressBarEx
  local progressBar
  local segmentBarEx
  local segmentBar
  local ringEx
  local ring
  local arcEx
  local arc
  local sectorEx
  local sector
  local imageEx
  local image
  local imageUV
  local iconEx
  local icon
  local registerTextFont
  local defineTextStyle
  local getTextStyle
  local resolveTextStyle
  local measureText
  local measureTextBox
  local text
  local textEx
  local textBox
  local textBoxEx
  local textBatchEx
  local prewarmText
  do
    local capabilities = __lux_import("lux/mgfx/capabilities#client")
    local commands = __lux_import("lux/mgfx/commands#client")
    local console = __lux_import("lux/mgfx/console#client")
    local frame = __lux_import("lux/mgfx/frame#client")
    local geometry = __lux_import("lux/mgfx/geometry#client")
    local materials = __lux_import("lux/mgfx/materials#client")
    local primitives = __lux_import("lux/mgfx/primitives#client")
    local profiler = __lux_import("lux/mgfx/profiler#client")
    local roundrect = __lux_import("lux/mgfx/roundrect#client")
    local shaderpack = __lux_import("lux/mgfx/shaderpack#client")
    local style = __lux_import("lux/mgfx/style#client")
    local textModule = __lux_import("lux/mgfx/text#client")
    local widgets = __lux_import("lux/mgfx/widgets#client")
    tableEmpty = table.Empty
    typeOf = type
    makeColor = Color
    colorDrawStyleCache = setmetatable({}, { __mode = "k" })
    transparentFillColor = makeColor(0, 0, 0, 0)
    installTargets = function(owner)
      owner.TARGET = capabilities.TARGET
      owner.TARGET_NAME = capabilities.TARGET_NAME
    end
    clearFrameStatTables = function(stats)
      do
        local __lux_tmp_drawCommandCounts_1 = stats.drawCommandCounts
        if __lux_tmp_drawCommandCounts_1 == nil then
          __lux_tmp_drawCommandCounts_1 = {}
        end
        stats.drawCommandCounts = __lux_tmp_drawCommandCounts_1
      end
      do
        local __lux_tmp_drawImmediateCounts_2 = stats.drawImmediateCounts
        if __lux_tmp_drawImmediateCounts_2 == nil then
          __lux_tmp_drawImmediateCounts_2 = {}
        end
        stats.drawImmediateCounts = __lux_tmp_drawImmediateCounts_2
      end
      do
        local __lux_tmp_profileTimes_3 = stats.profileTimes
        if __lux_tmp_profileTimes_3 == nil then
          __lux_tmp_profileTimes_3 = {}
        end
        stats.profileTimes = __lux_tmp_profileTimes_3
      end
      do
        local __lux_tmp_profileCounts_4 = stats.profileCounts
        if __lux_tmp_profileCounts_4 == nil then
          __lux_tmp_profileCounts_4 = {}
        end
        stats.profileCounts = __lux_tmp_profileCounts_4
      end
      tableEmpty(stats.drawCommandCounts)
      tableEmpty(stats.drawImmediateCounts)
      tableEmpty(stats.profileTimes)
      return tableEmpty(stats.profileCounts)
    end
    resetFrameStats = function(owner)
      do
        local __lux_tmp_stats_5 = owner.stats
        if __lux_tmp_stats_5 == nil then
          __lux_tmp_stats_5 = {}
        end
        owner.stats = __lux_tmp_stats_5
      end
      local stats = owner.stats
      stats.draws = 0
      stats.blurPasses = 0
      stats.blurCaptures = 0
      stats.blurReuses = 0
      stats.fallbacks = 0
      stats.culled = 0
      stats.gradientLutFillHits = 0
      stats.textQueuedBatches = 0
      stats.textQueuedRecords = 0
      clearFrameStatTables(stats)
      if owner.ResetGeometryFrameStats ~= nil then
        owner.ResetGeometryFrameStats()
      end
      if owner.ResetTextFrameStats ~= nil then
        owner.ResetTextFrameStats()
      end
      return stats
    end
    installFrameStatsReset = function(owner)
      local rawStartPanel = owner.StartPanel
      local rawStartScreen = owner.StartScreen
      owner.ResetFrameStats = function()
        return resetFrameStats(owner)
      end
      if rawStartPanel ~= nil then
        owner._LuxRawStartPanel = rawStartPanel
        owner.StartPanel = function(panel, w, h)
          resetFrameStats(owner)
          return rawStartPanel(panel, w, h)
        end
      end
      if rawStartScreen ~= nil then
        owner._LuxRawStartScreen = rawStartScreen
        owner.StartScreen = function(w, h)
          resetFrameStats(owner)
          return rawStartScreen(w, h)
        end
      end
      return owner
    end
    colorDrawStyle = function(color)
      local cached = colorDrawStyleCache[color]
      if cached ~= nil then
        return cached
      end
      cached = { fill = color }
      colorDrawStyleCache[color] = cached
      return cached
    end
    normalizeDrawStyle = function(drawStyle, target)
      if drawStyle == nil then
        return nil
      end
      if style.isColor(drawStyle) then
        return colorDrawStyle(drawStyle)
      end
      if typeOf(drawStyle) ~= "table" then
        return nil
      end
      if drawStyle._mgfxCompiledStyle == true then
        return drawStyle
      end
      local fill = drawStyle.fill
      local fillKind
      if typeOf(fill) == "table" then
        fillKind = fill.kind
      else
        fillKind = nil
      end
      if fillKind ~= style.PATTERN_STRIPE and fillKind ~= style.PATTERN_SMOKE then
        return drawStyle
      end
      if target == capabilities.TARGET.PROGRESS_BAR or target == capabilities.TARGET.SEGMENT_BAR then
        local out
        do
          local __lux_table_6 = {}
          local __lux_spread_7 = drawStyle
          if __lux_spread_7 ~= nil then
            for __lux_k_8, __lux_v_9 in pairs(__lux_spread_7) do
              __lux_table_6[__lux_k_8] = __lux_v_9
            end
          end
          out = __lux_table_6
        end
        if out.fillPattern == nil then
          out.fillPattern = fill
        end
        do
          local __lux_tmp_fillBase_10 = drawStyle.fillBase
          if __lux_tmp_fillBase_10 == nil then
            __lux_tmp_fillBase_10 = drawStyle.baseFill
          end
          out.fill = __lux_tmp_fillBase_10
        end
        return out
      end
      local cap = capabilities.get(target)
      if cap == nil or cap.keys == nil or cap.keys.pattern ~= true or drawStyle.pattern ~= nil then
        return drawStyle
      end
      local out
      do
        local __lux_table_11 = {}
        local __lux_spread_12 = drawStyle
        if __lux_spread_12 ~= nil then
          for __lux_k_13, __lux_v_14 in pairs(__lux_spread_12) do
            __lux_table_11[__lux_k_13] = __lux_v_14
          end
        end
        out = __lux_table_11
      end
      out.pattern = fill
      do
        local __lux_tmp_patternBase_15 = drawStyle.patternBase
        if __lux_tmp_patternBase_15 == nil then
          __lux_tmp_patternBase_15 = drawStyle.baseFill
        end
        if __lux_tmp_patternBase_15 == nil then
          __lux_tmp_patternBase_15 = transparentFillColor
        end
        out.fill = __lux_tmp_patternBase_15
      end
      return out
    end
    compileDrawStyle = function(drawStyle, target)
      if drawStyle == nil then
        return nil
      end
      if style.isColor(drawStyle) then
        return colorDrawStyle(drawStyle)
      end
      if typeOf(drawStyle) ~= "table" then
        return nil
      end
      if drawStyle._mgfxCompiledStyle == true then
        return drawStyle
      end
      local normalized = normalizeDrawStyle(drawStyle, target)
      if normalized == nil then
        normalized = drawStyle
      end
      local out
      do
        local __lux_table_16 = {}
        local __lux_spread_17 = normalized
        if __lux_spread_17 ~= nil then
          for __lux_k_18, __lux_v_19 in pairs(__lux_spread_17) do
            __lux_table_16[__lux_k_18] = __lux_v_19
          end
        end
        out = __lux_table_16
      end
      if out.backdrop ~= nil and out.backdrop ~= false then
        out.backdrop = style.compileBackdrop(out.backdrop)
      end
      if out.pattern ~= nil and out.pattern ~= false then
        out.pattern = roundrect.patternStyle(out.pattern)
      end
      if out.fillPattern ~= nil and out.fillPattern ~= false then
        out.fillPattern = roundrect.patternStyle(out.fillPattern)
      end
      if out.trackPattern ~= nil and out.trackPattern ~= false then
        out.trackPattern = roundrect.patternStyle(out.trackPattern)
      end
      out._mgfxCompiledStyle = true
      return out
    end
    installNormalizedDrawApi = function(owner)
      local rawRoundedBoxEx = owner.RoundedBoxEx
      local rawCircleEx = owner.CircleEx
      local rawCapsuleEx = owner.CapsuleEx
      local rawChamferBoxEx = owner.ChamferBoxEx
      local rawRegularPolyEx = owner.RegularPolyEx
      local rawDiamondEx = owner.DiamondEx
      local rawCaretEx = owner.CaretEx
      local rawPolyEx = owner.PolyEx
      local rawLineEx = owner.LineEx
      local rawProgressBarEx = owner.ProgressBarEx
      local rawSegmentBarEx = owner.SegmentBarEx
      local rawRingEx = owner.RingEx
      local rawArcEx = owner.ArcEx
      local rawSectorEx = owner.SectorEx
      local rawImageEx = owner.ImageEx
      local rawIconEx = owner.IconEx
      owner.RoundedBoxEx = function(x, y, w, h, drawStyle)
        return rawRoundedBoxEx(
          x,
          y,
          w,
          h,
          normalizeDrawStyle(drawStyle, capabilities.TARGET.ROUNDED_BOX)
        )
      end
      owner.CircleEx = function(cx, cy, radius, drawStyle)
        return rawCircleEx(cx, cy, radius, normalizeDrawStyle(drawStyle, capabilities.TARGET.CIRCLE))
      end
      owner.CapsuleEx = function(x, y, w, h, drawStyle)
        return rawCapsuleEx(x, y, w, h, normalizeDrawStyle(drawStyle, capabilities.TARGET.CAPSULE))
      end
      owner.ChamferBoxEx = function(x, y, w, h, drawStyle)
        return rawChamferBoxEx(
          x,
          y,
          w,
          h,
          normalizeDrawStyle(drawStyle, capabilities.TARGET.CHAMFER_BOX)
        )
      end
      owner.RegularPolyEx = function(cx, cy, radius, sides, drawStyle)
        return rawRegularPolyEx(
          cx,
          cy,
          radius,
          sides,
          normalizeDrawStyle(drawStyle, capabilities.TARGET.POLY)
        )
      end
      owner.DiamondEx = function(x, y, w, h, drawStyle)
        return rawDiamondEx(x, y, w, h, normalizeDrawStyle(drawStyle, capabilities.TARGET.POLY))
      end
      owner.CaretEx = function(x, y, w, h, drawStyle)
        return rawCaretEx(x, y, w, h, normalizeDrawStyle(drawStyle, capabilities.TARGET.POLY))
      end
      owner.PolyEx = function(points, drawStyle)
        return rawPolyEx(points, normalizeDrawStyle(drawStyle, capabilities.TARGET.POLY))
      end
      owner.LineEx = function(x1, y1, x2, y2, drawStyle)
        return rawLineEx(x1, y1, x2, y2, normalizeDrawStyle(drawStyle, capabilities.TARGET.LINE))
      end
      owner.ProgressBarEx = function(x, y, w, h, value, drawStyle)
        return rawProgressBarEx(
          x,
          y,
          w,
          h,
          value,
          normalizeDrawStyle(drawStyle, capabilities.TARGET.PROGRESS_BAR)
        )
      end
      owner.SegmentBarEx = function(x, y, w, h, value, drawStyle)
        return rawSegmentBarEx(
          x,
          y,
          w,
          h,
          value,
          normalizeDrawStyle(drawStyle, capabilities.TARGET.SEGMENT_BAR)
        )
      end
      owner.RingEx = function(cx, cy, radius, width, drawStyle)
        return rawRingEx(
          cx,
          cy,
          radius,
          width,
          normalizeDrawStyle(drawStyle, capabilities.TARGET.RING)
        )
      end
      owner.ArcEx = function(cx, cy, radius, width, startDeg, endDeg, drawStyle)
        return rawArcEx(
          cx,
          cy,
          radius,
          width,
          startDeg,
          endDeg,
          normalizeDrawStyle(drawStyle, capabilities.TARGET.ARC)
        )
      end
      owner.SectorEx = function(cx, cy, innerRadius, outerRadius, startDeg, endDeg, drawStyle)
        return rawSectorEx(
          cx,
          cy,
          innerRadius,
          outerRadius,
          startDeg,
          endDeg,
          normalizeDrawStyle(drawStyle, capabilities.TARGET.SECTOR)
        )
      end
      owner.ImageEx = function(x, y, w, h, source, drawStyle)
        return rawImageEx(x, y, w, h, source, normalizeDrawStyle(drawStyle, capabilities.TARGET.IMAGE))
      end
      owner.IconEx = function(x, y, w, h, source, drawStyle)
        return rawIconEx(x, y, w, h, source, normalizeDrawStyle(drawStyle, capabilities.TARGET.IMAGE))
      end
      return owner
    end
    installProfileWrappers = function(owner)
      local api = owner.Profiler
      if api == nil or api.InstallApiWrappers == nil then
        return owner
      end
      api.InstallApiWrappers(
        owner,
        {
          "RoundedBox",
          "RoundedBoxBackdrop",
          "RoundedBoxEx",
          "ChamferBox",
          "ChamferBoxEx",
          "RegularPoly",
          "RegularPolyEx",
          "Diamond",
          "DiamondEx",
          "Caret",
          "CaretEx",
          "Poly",
          "PolyEx",
          "Image",
          "ImageUV",
          "ImageEx",
          "Icon",
          "IconEx",
          "Text",
          "TextEx",
          "TextBatchEx",
          "TextBox",
          "TextBoxEx",
          "ProgressBar",
          "ProgressBarEx",
          "SegmentBar",
          "SegmentBarEx",
          "Line",
          "LineNoCaps",
          "LineEx",
          "Ring",
          "RingEx",
          "Arc",
          "ArcEx",
          "Circle",
          "CircleEx",
          "Capsule",
          "CapsuleEx",
          "PushClip",
          "PopClip",
          "Solid",
          "LinearGradient",
          "LinearGradientStops",
          "RadialGradient",
          "RingRadialGradient",
          "SectorRadialGradient",
          "ConicGradient",
          "ShapeAngularGradient",
          "RingAngularGradient",
          "ArcAngularGradient",
          "SectorAngularGradient",
          "StripePattern",
          "SmokePattern",
          "WornPattern",
          "Mask",
          "Backdrop",
          "CompileBackdrop",
          "CompileStyle",
          "ImageMaskStyle",
          "BackdropStyle",
          "FillFromStyle",
          "ColorAtFill",
          "NormalizedRotation",
          "GlowSoftnessToFalloff",
          "GradientLutForFill",
          "BindGradientLut",
          "GradientLutStatus",
          "GetCapabilities",
          "Supports",
          "NormalizeStyle",
          "Transform",
          "ProjectedQuad",
          "PointerTilt",
          "PushTransform",
          "PopTransform",
          "TransformPoint",
          "UntransformPoint",
          "RegisterTextFont",
          "DefineTextStyle",
          "GetTextStyle",
          "ResolveTextStyle",
          "MeasureText",
          "MeasureTextBox",
          "PrewarmText",
        },
        function()
          return owner._FrameState ~= nil and owner._FrameState.replaying == true
        end
      )
      return owner
    end
    install = function(owner)
      local out = owner
      if out == nil then
        out = {}
      end
      out.Reload = function()
        return install(out)
      end
      out._LuxReload = out.Reload
      out.api = out
      installTargets(out)
      shaderpack.installGlobal()
      style.install(out)
      capabilities.install(out)
      commands.install(out)
      console.install(out)
      profiler.install(out)
      frame.install(out)
      geometry.install(out)
      materials.install(out)
      textModule.install(out)
      roundrect.install(out)
      primitives.install(out)
      widgets.install(out)
      installNormalizedDrawApi(out)
      out.CompileStyle = compileDrawStyle
      installFrameStatsReset(out)
      installProfileWrappers(out)
      return out
    end
    installGlobal = function(name)
      if name == nil then
        name = "MGFX"
      end
      local out = _G[name]
      if out == nil then
        out = {}
      end
      _G[name] = install(out)
      return _G[name]
    end
    create = function()
      return install({})
    end
  end
  do
    local capabilities = __lux_import("lux/mgfx/capabilities#client")
    defaultRuntime = install({})
    TARGET_ROUNDED_BOX = 1
    TARGET_CHAMFER_BOX = 2
    TARGET_POLY = 3
    TARGET_LINE = 4
    TARGET_CIRCLE = 5
    TARGET_CAPSULE = 6
    TARGET_IMAGE = 8
    TARGET_PROGRESS_BAR = 9
    TARGET_SEGMENT_BAR = 10
    TARGET_RING = 11
    TARGET_ARC = 12
    TARGET_TEXT = 13
    TARGET_SECTOR = 14
    resolvedStyle = function(drawStyle, target)
      return capabilities.normalizeStyle(drawStyle, target)
    end
    solid = function(color)
      return defaultRuntime.Solid(color)
    end
    linearGradient = function(x1, y1, x2, y2, stopsOrColorA, colorB)
      return defaultRuntime.LinearGradient(x1, y1, x2, y2, stopsOrColorA, colorB)
    end
    linearGradientStops = function(x1, y1, x2, y2, stops)
      return defaultRuntime.LinearGradientStops(x1, y1, x2, y2, stops)
    end
    radialGradient = function(cx, cy, radius, stopsOrColorA, colorB)
      return defaultRuntime.RadialGradient(cx, cy, radius, stopsOrColorA, colorB)
    end
    ringRadialGradient = function(stopsOrColorA, colorB)
      return defaultRuntime.RingRadialGradient(stopsOrColorA, colorB)
    end
    sectorRadialGradient = function(stopsOrColorA, colorB)
      return defaultRuntime.SectorRadialGradient(stopsOrColorA, colorB)
    end
    conicGradient = function(cx, cy, rotation, stopsOrColorA, colorB)
      return defaultRuntime.ConicGradient(cx, cy, rotation, stopsOrColorA, colorB)
    end
    shapeAngularGradient = function(stopsOrColorA, colorB, rotation)
      return defaultRuntime.ShapeAngularGradient(stopsOrColorA, colorB, rotation)
    end
    ringAngularGradient = function(stopsOrColorA, colorB, rotation)
      if rotation == nil then
        rotation = 0
      end
      return defaultRuntime.RingAngularGradient(stopsOrColorA, colorB, rotation)
    end
    arcAngularGradient = function(stopsOrColorA, colorB, rotation)
      if rotation == nil then
        rotation = 0
      end
      return defaultRuntime.ArcAngularGradient(stopsOrColorA, colorB, rotation)
    end
    sectorAngularGradient = function(stopsOrColorA, colorB, rotation)
      if rotation == nil then
        rotation = 0
      end
      return defaultRuntime.SectorAngularGradient(stopsOrColorA, colorB, rotation)
    end
    stripePattern = function(color, spacing, width, angle, offset)
      if spacing == nil then
        spacing = 12
      end
      if width == nil then
        width = 2
      end
      if angle == nil then
        angle = 135
      end
      if offset == nil then
        offset = 0
      end
      return defaultRuntime.StripePattern(color, spacing, width, angle, offset)
    end
    smokePattern = function(color, scale, density, softness, angle, offset, seed)
      if scale == nil then
        scale = 140
      end
      if density == nil then
        density = 0.48
      end
      if softness == nil then
        softness = 0.3
      end
      if angle == nil then
        angle = 135
      end
      if offset == nil then
        offset = 0
      end
      if seed == nil then
        seed = 0
      end
      return defaultRuntime.SmokePattern(color, scale, density, softness, angle, offset, seed)
    end
    wornPattern = function(spec)
      return defaultRuntime.WornPattern(spec)
    end
    mask = function(kind, spec)
      return defaultRuntime.Mask(kind, spec)
    end
    backdrop = function(value)
      return defaultRuntime.Backdrop(value)
    end
    compileBackdrop = function(value)
      return defaultRuntime.CompileBackdrop(value)
    end
    compileStyle = function(drawStyle, target)
      return defaultRuntime.CompileStyle(drawStyle, target)
    end
    backdropStyle = function(value)
      return defaultRuntime.BackdropStyle(value)
    end
    imageMaskStyle = function(maskValue, drawStyle)
      return defaultRuntime.ImageMaskStyle(maskValue, drawStyle)
    end
    fillFromStyle = function(fill)
      return defaultRuntime.FillFromStyle(fill)
    end
    colorAtFill = function(fill, t)
      return defaultRuntime.ColorAtFill(fill, t)
    end
    normalizedRotation = function(value)
      return defaultRuntime.NormalizedRotation(value)
    end
    glowSoftnessToFalloff = function(softness, defaultSoftness)
      if defaultSoftness == nil then
        defaultSoftness = 0.55
      end
      return defaultRuntime.GlowSoftnessToFalloff(softness, defaultSoftness)
    end
    gradientLutForFill = function(fill)
      return defaultRuntime.GradientLutForFill(fill)
    end
    bindGradientLut = function(material, fill)
      return defaultRuntime.BindGradientLut(material, fill)
    end
    gradientLutStatus = function()
      return defaultRuntime.GradientLutStatus()
    end
    getCapabilities = function(target)
      return defaultRuntime.GetCapabilities(target)
    end
    supports = function(target, key)
      return defaultRuntime.Supports(target, key)
    end
    normalizeStyle = function(input, target)
      return defaultRuntime.NormalizeStyle(input, target)
    end
    startPanel = function(panel, w, h)
      return defaultRuntime.StartPanel(panel, w, h)
    end
    endPanel = function()
      return defaultRuntime.EndPanel()
    end
    startScreen = function(w, h)
      return defaultRuntime.StartScreen(w, h)
    end
    endScreen = function()
      return defaultRuntime.EndScreen()
    end
    pushClip = function(x, y, w, h)
      return defaultRuntime.PushClip(x, y, w, h)
    end
    popClip = function()
      return defaultRuntime.PopClip()
    end
    debugOverlay = function(x, y)
      if x == nil then
        x = 8
      end
      if y == nil then
        y = 8
      end
      return defaultRuntime.DebugOverlay(x, y)
    end
    transform = function(spec)
      return defaultRuntime.Transform(spec)
    end
    projectedQuad = function(spec)
      return defaultRuntime.ProjectedQuad(spec)
    end
    pointerTilt = function(x, y, spec)
      return defaultRuntime.PointerTilt(x, y, spec)
    end
    pushTransform = function(spec, x, y, w, h)
      return defaultRuntime.PushTransform(spec, x, y, w, h)
    end
    popTransform = function()
      return defaultRuntime.PopTransform()
    end
    transformPoint = function(x, y)
      return defaultRuntime.TransformPoint(x, y)
    end
    untransformPoint = function(sx, sy)
      return defaultRuntime.UntransformPoint(sx, sy)
    end
    roundedBoxEx = function(x, y, w, h, drawStyle)
      return defaultRuntime.RoundedBoxEx(x, y, w, h, drawStyle)
    end
    roundedBox = function(x, y, w, h, radius, fill, stroke, strokeWidth)
      return defaultRuntime.RoundedBox(x, y, w, h, radius, fill, stroke, strokeWidth)
    end
    roundedBoxBackdrop = function(x, y, w, h, radius, backdrop)
      return defaultRuntime.RoundedBoxBackdrop(x, y, w, h, radius, backdrop)
    end
    circleEx = function(cx, cy, radius, drawStyle)
      return defaultRuntime.CircleEx(cx, cy, radius, drawStyle)
    end
    circle = function(cx, cy, radius, fill, stroke, strokeWidth)
      return defaultRuntime.Circle(cx, cy, radius, fill, stroke, strokeWidth)
    end
    capsuleEx = function(x, y, w, h, drawStyle)
      return defaultRuntime.CapsuleEx(x, y, w, h, drawStyle)
    end
    capsule = function(x, y, w, h, fill, stroke, strokeWidth)
      return defaultRuntime.Capsule(x, y, w, h, fill, stroke, strokeWidth)
    end
    chamferBoxEx = function(x, y, w, h, drawStyle)
      return defaultRuntime.ChamferBoxEx(x, y, w, h, drawStyle)
    end
    chamferBox = function(x, y, w, h, cuts, fill, stroke, strokeWidth)
      return defaultRuntime.ChamferBox(x, y, w, h, cuts, fill, stroke, strokeWidth)
    end
    regularPolyEx = function(cx, cy, radius, sides, drawStyle)
      return defaultRuntime.RegularPolyEx(cx, cy, radius, sides, drawStyle)
    end
    regularPoly = function(cx, cy, radius, sides, rotation, fill, stroke, strokeWidth)
      return defaultRuntime.RegularPoly(cx, cy, radius, sides, rotation, fill, stroke, strokeWidth)
    end
    diamondEx = function(x, y, w, h, drawStyle)
      return defaultRuntime.DiamondEx(x, y, w, h, drawStyle)
    end
    diamond = function(x, y, w, h, fill, stroke, strokeWidth)
      return defaultRuntime.Diamond(x, y, w, h, fill, stroke, strokeWidth)
    end
    caretEx = function(x, y, w, h, drawStyle)
      return defaultRuntime.CaretEx(x, y, w, h, drawStyle)
    end
    caret = function(x, y, w, h, direction, fill, stroke, strokeWidth)
      return defaultRuntime.Caret(x, y, w, h, direction, fill, stroke, strokeWidth)
    end
    polyEx = function(points, drawStyle)
      return defaultRuntime.PolyEx(points, drawStyle)
    end
    poly = function(points, fill, stroke, strokeWidth)
      return defaultRuntime.Poly(points, fill, stroke, strokeWidth)
    end
    lineEx = function(x1, y1, x2, y2, drawStyle)
      return defaultRuntime.LineEx(x1, y1, x2, y2, drawStyle)
    end
    line = function(x1, y1, x2, y2, width, fill)
      if width == nil then
        width = 1
      end
      return defaultRuntime.Line(x1, y1, x2, y2, width, fill)
    end
    lineNoCaps = function(x1, y1, x2, y2, width, fill)
      if width == nil then
        width = 1
      end
      return defaultRuntime.LineNoCaps(x1, y1, x2, y2, width, fill)
    end
    progressBarEx = function(x, y, w, h, value, drawStyle)
      return defaultRuntime.ProgressBarEx(x, y, w, h, value, drawStyle)
    end
    progressBar = function(x, y, w, h, value, radius, track, fill, stroke, strokeWidth)
      return defaultRuntime.ProgressBar(x, y, w, h, value, radius, track, fill, stroke, strokeWidth)
    end
    segmentBarEx = function(x, y, w, h, value, drawStyle)
      return defaultRuntime.SegmentBarEx(x, y, w, h, value, drawStyle)
    end
    segmentBar = function(x, y, w, h, value, segments, fill, track)
      return defaultRuntime.SegmentBar(x, y, w, h, value, segments, fill, track)
    end
    ringEx = function(cx, cy, radius, width, drawStyle)
      return defaultRuntime.RingEx(cx, cy, radius, width, drawStyle)
    end
    ring = function(cx, cy, radius, width, fill)
      return defaultRuntime.Ring(cx, cy, radius, width, fill)
    end
    arcEx = function(cx, cy, radius, width, startDeg, endDeg, drawStyle)
      return defaultRuntime.ArcEx(cx, cy, radius, width, startDeg, endDeg, drawStyle)
    end
    arc = function(cx, cy, radius, startDeg, endDeg, width, fill)
      return defaultRuntime.Arc(cx, cy, radius, startDeg, endDeg, width, fill)
    end
    sectorEx = function(cx, cy, innerRadius, outerRadius, startDeg, endDeg, drawStyle)
      return defaultRuntime.SectorEx(cx, cy, innerRadius, outerRadius, startDeg, endDeg, drawStyle)
    end
    sector = function(cx, cy, innerRadius, outerRadius, startDeg, endDeg, fill)
      return defaultRuntime.Sector(cx, cy, innerRadius, outerRadius, startDeg, endDeg, fill)
    end
    imageEx = function(x, y, w, h, source, drawStyle)
      return defaultRuntime.ImageEx(x, y, w, h, source, drawStyle)
    end
    image = function(x, y, w, h, source, radius, tint)
      return defaultRuntime.Image(x, y, w, h, source, radius, tint)
    end
    imageUV = function(x, y, w, h, source, u0, v0, u1, v1, tint)
      if u0 == nil then
        u0 = 0
      end
      if v0 == nil then
        v0 = 0
      end
      if u1 == nil then
        u1 = 1
      end
      if v1 == nil then
        v1 = 1
      end
      return defaultRuntime.ImageUV(x, y, w, h, source, u0, v0, u1, v1, tint)
    end
    iconEx = function(x, y, w, h, source, drawStyle)
      return defaultRuntime.IconEx(x, y, w, h, source, drawStyle)
    end
    icon = function(x, y, w, h, source, tint)
      return defaultRuntime.Icon(x, y, w, h, source, tint)
    end
    registerTextFont = function(fontName, spec)
      return defaultRuntime.RegisterTextFont(fontName, spec)
    end
    defineTextStyle = function(name, textStyle)
      return defaultRuntime.DefineTextStyle(name, textStyle)
    end
    getTextStyle = function(name)
      return defaultRuntime.GetTextStyle(name)
    end
    resolveTextStyle = function(textStyle)
      return defaultRuntime.ResolveTextStyle(textStyle)
    end
    measureText = function(value, font)
      if font == nil then
        font = "DermaDefault"
      end
      return defaultRuntime.MeasureText(value, font)
    end
    measureTextBox = function(value, font, w, textStyle)
      return defaultRuntime.MeasureTextBox(value, font, w, textStyle)
    end
    text = function(value, font, x, y, color, ax, ay)
      if ax == nil then
        ax = 0
      end
      if ay == nil then
        ay = 0
      end
      return defaultRuntime.Text(value, font, x, y, color, ax, ay)
    end
    textEx = function(value, font, x, y, color, ax, ay, textStyle)
      if ax == nil then
        ax = 0
      end
      if ay == nil then
        ay = 0
      end
      return defaultRuntime.TextEx(value, font, x, y, color, ax, ay, textStyle)
    end
    textBox = function(value, font, x, y, w, h, color, alignX, alignY)
      if alignX == nil then
        alignX = TEXT_ALIGN_LEFT
      end
      if alignY == nil then
        alignY = TEXT_ALIGN_TOP
      end
      return defaultRuntime.TextBox(value, font, x, y, w, h, color, alignX, alignY)
    end
    textBoxEx = function(value, font, x, y, w, h, textStyle)
      return defaultRuntime.TextBoxEx(value, font, x, y, w, h, textStyle)
    end
    textBatchEx = function(records)
      return defaultRuntime.TextBatchEx(records)
    end
    prewarmText = function(value, font, textStyle)
      return defaultRuntime.PrewarmText(value, font, textStyle)
    end
  end

  __lux_exports.install = install
  __lux_exports.installGlobal = installGlobal
  __lux_exports.create = create
  __lux_exports.solid = solid
  __lux_exports.linearGradient = linearGradient
  __lux_exports.linearGradientStops = linearGradientStops
  __lux_exports.radialGradient = radialGradient
  __lux_exports.ringRadialGradient = ringRadialGradient
  __lux_exports.sectorRadialGradient = sectorRadialGradient
  __lux_exports.conicGradient = conicGradient
  __lux_exports.shapeAngularGradient = shapeAngularGradient
  __lux_exports.ringAngularGradient = ringAngularGradient
  __lux_exports.arcAngularGradient = arcAngularGradient
  __lux_exports.sectorAngularGradient = sectorAngularGradient
  __lux_exports.stripePattern = stripePattern
  __lux_exports.smokePattern = smokePattern
  __lux_exports.wornPattern = wornPattern
  __lux_exports.mask = mask
  __lux_exports.backdrop = backdrop
  __lux_exports.compileBackdrop = compileBackdrop
  __lux_exports.compileStyle = compileStyle
  __lux_exports.backdropStyle = backdropStyle
  __lux_exports.imageMaskStyle = imageMaskStyle
  __lux_exports.fillFromStyle = fillFromStyle
  __lux_exports.colorAtFill = colorAtFill
  __lux_exports.normalizedRotation = normalizedRotation
  __lux_exports.glowSoftnessToFalloff = glowSoftnessToFalloff
  __lux_exports.gradientLutForFill = gradientLutForFill
  __lux_exports.bindGradientLut = bindGradientLut
  __lux_exports.gradientLutStatus = gradientLutStatus
  __lux_exports.getCapabilities = getCapabilities
  __lux_exports.supports = supports
  __lux_exports.normalizeStyle = normalizeStyle
  __lux_exports.startPanel = startPanel
  __lux_exports.endPanel = endPanel
  __lux_exports.startScreen = startScreen
  __lux_exports.endScreen = endScreen
  __lux_exports.pushClip = pushClip
  __lux_exports.popClip = popClip
  __lux_exports.debugOverlay = debugOverlay
  __lux_exports.transform = transform
  __lux_exports.projectedQuad = projectedQuad
  __lux_exports.pointerTilt = pointerTilt
  __lux_exports.pushTransform = pushTransform
  __lux_exports.popTransform = popTransform
  __lux_exports.transformPoint = transformPoint
  __lux_exports.untransformPoint = untransformPoint
  __lux_exports.roundedBoxEx = roundedBoxEx
  __lux_exports.roundedBox = roundedBox
  __lux_exports.roundedBoxBackdrop = roundedBoxBackdrop
  __lux_exports.circleEx = circleEx
  __lux_exports.circle = circle
  __lux_exports.capsuleEx = capsuleEx
  __lux_exports.capsule = capsule
  __lux_exports.chamferBoxEx = chamferBoxEx
  __lux_exports.chamferBox = chamferBox
  __lux_exports.regularPolyEx = regularPolyEx
  __lux_exports.regularPoly = regularPoly
  __lux_exports.diamondEx = diamondEx
  __lux_exports.diamond = diamond
  __lux_exports.caretEx = caretEx
  __lux_exports.caret = caret
  __lux_exports.polyEx = polyEx
  __lux_exports.poly = poly
  __lux_exports.lineEx = lineEx
  __lux_exports.line = line
  __lux_exports.lineNoCaps = lineNoCaps
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
  __lux_exports.imageUV = imageUV
  __lux_exports.iconEx = iconEx
  __lux_exports.icon = icon
  __lux_exports.registerTextFont = registerTextFont
  __lux_exports.defineTextStyle = defineTextStyle
  __lux_exports.getTextStyle = getTextStyle
  __lux_exports.resolveTextStyle = resolveTextStyle
  __lux_exports.measureText = measureText
  __lux_exports.measureTextBox = measureTextBox
  __lux_exports.text = text
  __lux_exports.textEx = textEx
  __lux_exports.textBox = textBox
  __lux_exports.textBoxEx = textBoxEx
  __lux_exports.textBatchEx = textBatchEx
  __lux_exports.prewarmText = prewarmText

  return __lux_exports
end
