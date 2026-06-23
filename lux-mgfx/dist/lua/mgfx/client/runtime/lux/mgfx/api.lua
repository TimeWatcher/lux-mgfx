return function(__lux_import)
  local __lux_exports = {}
  local installTargets
  local resetFrameStats
  local installFrameStatsReset
  local installNormalizedDrawApi
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
  local mask
  local backdrop
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
    local frame = __lux_import("lux/mgfx/frame#client")
    local geometry = __lux_import("lux/mgfx/geometry#client")
    local materials = __lux_import("lux/mgfx/materials#client")
    local paint = __lux_import("lux/mgfx/paint#client")
    local primitives = __lux_import("lux/mgfx/primitives#client")
    local profiler = __lux_import("lux/mgfx/profiler#client")
    local roundrect = __lux_import("lux/mgfx/roundrect#client")
    local shaderpack = __lux_import("lux/mgfx/shaderpack#client")
    local style = __lux_import("lux/mgfx/style#client")
    local textModule = __lux_import("lux/mgfx/text#client")
    local widgets = __lux_import("lux/mgfx/widgets#client")
    installTargets = function(owner)
      owner.TARGET = capabilities.TARGET
      owner.TARGET_NAME = capabilities.TARGET_NAME
    end
    resetFrameStats = function(owner)
      do
        local __lux_tmp_stats_1 = owner.stats
        if __lux_tmp_stats_1 == nil then
          __lux_tmp_stats_1 = {}
        end
        owner.stats = __lux_tmp_stats_1
      end
      if owner.ResetGeometryFrameStats ~= nil then
        owner.ResetGeometryFrameStats()
      end
      if owner.ResetTextFrameStats ~= nil then
        owner.ResetTextFrameStats()
      end
      return owner.stats
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
          capabilities.normalizeStyle(drawStyle, capabilities.TARGET.ROUNDED_BOX)
        )
      end
      owner.CircleEx = function(cx, cy, radius, drawStyle)
        return rawCircleEx(
          cx,
          cy,
          radius,
          capabilities.normalizeStyle(drawStyle, capabilities.TARGET.CIRCLE)
        )
      end
      owner.CapsuleEx = function(x, y, w, h, drawStyle)
        return rawCapsuleEx(
          x,
          y,
          w,
          h,
          capabilities.normalizeStyle(drawStyle, capabilities.TARGET.CAPSULE)
        )
      end
      owner.ChamferBoxEx = function(x, y, w, h, drawStyle)
        return rawChamferBoxEx(
          x,
          y,
          w,
          h,
          capabilities.normalizeStyle(drawStyle, capabilities.TARGET.CHAMFER_BOX)
        )
      end
      owner.RegularPolyEx = function(cx, cy, radius, sides, drawStyle)
        return rawRegularPolyEx(
          cx,
          cy,
          radius,
          sides,
          capabilities.normalizeStyle(drawStyle, capabilities.TARGET.POLY)
        )
      end
      owner.DiamondEx = function(x, y, w, h, drawStyle)
        return rawDiamondEx(
          x,
          y,
          w,
          h,
          capabilities.normalizeStyle(drawStyle, capabilities.TARGET.POLY)
        )
      end
      owner.CaretEx = function(x, y, w, h, drawStyle)
        return rawCaretEx(x, y, w, h, capabilities.normalizeStyle(drawStyle, capabilities.TARGET.POLY))
      end
      owner.PolyEx = function(points, drawStyle)
        return rawPolyEx(points, capabilities.normalizeStyle(drawStyle, capabilities.TARGET.POLY))
      end
      owner.LineEx = function(x1, y1, x2, y2, drawStyle)
        return rawLineEx(
          x1,
          y1,
          x2,
          y2,
          capabilities.normalizeStyle(drawStyle, capabilities.TARGET.LINE)
        )
      end
      owner.ProgressBarEx = function(x, y, w, h, value, drawStyle)
        return rawProgressBarEx(
          x,
          y,
          w,
          h,
          value,
          capabilities.normalizeStyle(drawStyle, capabilities.TARGET.PROGRESS_BAR)
        )
      end
      owner.SegmentBarEx = function(x, y, w, h, value, drawStyle)
        return rawSegmentBarEx(
          x,
          y,
          w,
          h,
          value,
          capabilities.normalizeStyle(drawStyle, capabilities.TARGET.SEGMENT_BAR)
        )
      end
      owner.RingEx = function(cx, cy, radius, width, drawStyle)
        return rawRingEx(
          cx,
          cy,
          radius,
          width,
          capabilities.normalizeStyle(drawStyle, capabilities.TARGET.RING)
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
          capabilities.normalizeStyle(drawStyle, capabilities.TARGET.ARC)
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
          capabilities.normalizeStyle(drawStyle, capabilities.TARGET.SECTOR)
        )
      end
      owner.ImageEx = function(x, y, w, h, source, drawStyle)
        return rawImageEx(
          x,
          y,
          w,
          h,
          source,
          capabilities.normalizeStyle(drawStyle, capabilities.TARGET.IMAGE)
        )
      end
      owner.IconEx = function(x, y, w, h, source, drawStyle)
        return rawIconEx(
          x,
          y,
          w,
          h,
          source,
          capabilities.normalizeStyle(drawStyle, capabilities.TARGET.IMAGE)
        )
      end
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
      frame.install(out)
      geometry.install(out)
      materials.install(out)
      profiler.install(out)
      paint.install(out)
      textModule.install(out)
      roundrect.install(out)
      primitives.install(out)
      widgets.install(out)
      installNormalizedDrawApi(out)
      installFrameStatsReset(out)
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
    local frame = __lux_import("lux/mgfx/frame#client")
    local geometry = __lux_import("lux/mgfx/geometry#client")
    local primitives = __lux_import("lux/mgfx/primitives#client")
    local roundrect = __lux_import("lux/mgfx/roundrect#client")
    local style = __lux_import("lux/mgfx/style#client")
    local textModule = __lux_import("lux/mgfx/text#client")
    local widgets = __lux_import("lux/mgfx/widgets#client")
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
      return style.solid(color)
    end
    linearGradient = function(x1, y1, x2, y2, stopsOrColorA, colorB)
      return style.linearGradient(x1, y1, x2, y2, stopsOrColorA, colorB)
    end
    linearGradientStops = function(x1, y1, x2, y2, stops)
      return style.linearGradientStops(x1, y1, x2, y2, stops)
    end
    radialGradient = function(cx, cy, radius, stopsOrColorA, colorB)
      return style.radialGradient(cx, cy, radius, stopsOrColorA, colorB)
    end
    ringRadialGradient = function(stopsOrColorA, colorB)
      return style.ringRadialGradient(stopsOrColorA, colorB)
    end
    sectorRadialGradient = function(stopsOrColorA, colorB)
      return style.sectorRadialGradient(stopsOrColorA, colorB)
    end
    conicGradient = function(cx, cy, rotation, stopsOrColorA, colorB)
      return style.conicGradient(cx, cy, rotation, stopsOrColorA, colorB)
    end
    shapeAngularGradient = function(stopsOrColorA, colorB, rotation)
      return style.shapeAngularGradient(stopsOrColorA, colorB, rotation)
    end
    ringAngularGradient = function(stopsOrColorA, colorB, rotation)
      if rotation == nil then
        rotation = 0
      end
      return style.ringAngularGradient(stopsOrColorA, colorB, rotation)
    end
    arcAngularGradient = function(stopsOrColorA, colorB, rotation)
      if rotation == nil then
        rotation = 0
      end
      return style.arcAngularGradient(stopsOrColorA, colorB, rotation)
    end
    sectorAngularGradient = function(stopsOrColorA, colorB, rotation)
      if rotation == nil then
        rotation = 0
      end
      return style.sectorAngularGradient(stopsOrColorA, colorB, rotation)
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
      return style.stripePattern(color, spacing, width, angle, offset)
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
      return style.smokePattern(color, scale, density, softness, angle, offset, seed)
    end
    mask = function(kind, spec)
      return style.mask(kind, spec)
    end
    backdrop = function(value)
      return style.backdrop(value)
    end
    backdropStyle = function(value)
      return style.backdropStyle(value)
    end
    imageMaskStyle = function(maskValue, drawStyle)
      return style.imageMaskStyle(maskValue, drawStyle)
    end
    fillFromStyle = function(fill)
      return style.fillFromStyle(fill)
    end
    colorAtFill = function(fill, t)
      return style.colorAtFill(fill, t)
    end
    normalizedRotation = function(value)
      return style.normalizedRotation(value)
    end
    glowSoftnessToFalloff = function(softness, defaultSoftness)
      if defaultSoftness == nil then
        defaultSoftness = 0.55
      end
      return style.glowSoftnessToFalloff(softness, defaultSoftness)
    end
    gradientLutForFill = function(fill)
      return style.gradientLutForFill(fill)
    end
    bindGradientLut = function(material, fill)
      return style.bindGradientLut(material, fill)
    end
    gradientLutStatus = function()
      return style.gradientLutStatus()
    end
    getCapabilities = function(target)
      return capabilities.get(target)
    end
    supports = function(target, key)
      return capabilities.supports(target, key)
    end
    normalizeStyle = function(input, target)
      return capabilities.normalizeStyle(input, target)
    end
    startPanel = function(panel, w, h)
      return frame.startPanel(panel, w, h)
    end
    endPanel = function()
      return frame.endPanel()
    end
    startScreen = function(w, h)
      return frame.startScreen(w, h)
    end
    endScreen = function()
      return frame.endScreen()
    end
    pushClip = function(x, y, w, h)
      return frame.pushClip(x, y, w, h)
    end
    popClip = function()
      return frame.popClip()
    end
    debugOverlay = function(x, y)
      if x == nil then
        x = 8
      end
      if y == nil then
        y = 8
      end
      return frame.debugOverlay(x, y)
    end
    transform = function(spec)
      return geometry.transform(spec)
    end
    projectedQuad = function(spec)
      return geometry.projectedQuad(spec)
    end
    pointerTilt = function(x, y, spec)
      return geometry.pointerTilt(x, y, spec)
    end
    pushTransform = function(spec, x, y, w, h)
      return geometry.pushTransform(spec, x, y, w, h)
    end
    popTransform = function()
      return geometry.popTransform()
    end
    transformPoint = function(x, y)
      return geometry.transformPoint(x, y)
    end
    untransformPoint = function(sx, sy)
      return geometry.untransformPoint(sx, sy)
    end
    roundedBoxEx = function(x, y, w, h, drawStyle)
      return roundrect.roundedBoxEx(x, y, w, h, resolvedStyle(drawStyle, TARGET_ROUNDED_BOX))
    end
    roundedBox = function(x, y, w, h, radius, fill, stroke, strokeWidth)
      return roundrect.roundedBox(x, y, w, h, radius, fill, stroke, strokeWidth)
    end
    circleEx = function(cx, cy, radius, drawStyle)
      return roundrect.circleEx(cx, cy, radius, resolvedStyle(drawStyle, TARGET_CIRCLE))
    end
    circle = function(cx, cy, radius, fill, stroke, strokeWidth)
      return roundrect.circle(cx, cy, radius, fill, stroke, strokeWidth)
    end
    capsuleEx = function(x, y, w, h, drawStyle)
      return roundrect.capsuleEx(x, y, w, h, resolvedStyle(drawStyle, TARGET_CAPSULE))
    end
    capsule = function(x, y, w, h, fill, stroke, strokeWidth)
      return roundrect.capsule(x, y, w, h, fill, stroke, strokeWidth)
    end
    chamferBoxEx = function(x, y, w, h, drawStyle)
      return primitives.chamferBoxEx(x, y, w, h, resolvedStyle(drawStyle, TARGET_CHAMFER_BOX))
    end
    chamferBox = function(x, y, w, h, cuts, fill, stroke, strokeWidth)
      return primitives.chamferBox(x, y, w, h, cuts, fill, stroke, strokeWidth)
    end
    regularPolyEx = function(cx, cy, radius, sides, drawStyle)
      return primitives.regularPolyEx(cx, cy, radius, sides, resolvedStyle(drawStyle, TARGET_POLY))
    end
    regularPoly = function(cx, cy, radius, sides, rotation, fill, stroke, strokeWidth)
      return primitives.regularPoly(cx, cy, radius, sides, rotation, fill, stroke, strokeWidth)
    end
    diamondEx = function(x, y, w, h, drawStyle)
      return primitives.diamondEx(x, y, w, h, resolvedStyle(drawStyle, TARGET_POLY))
    end
    diamond = function(x, y, w, h, fill, stroke, strokeWidth)
      return primitives.diamond(x, y, w, h, fill, stroke, strokeWidth)
    end
    caretEx = function(x, y, w, h, drawStyle)
      return primitives.caretEx(x, y, w, h, resolvedStyle(drawStyle, TARGET_POLY))
    end
    caret = function(x, y, w, h, direction, fill, stroke, strokeWidth)
      return primitives.caret(x, y, w, h, direction, fill, stroke, strokeWidth)
    end
    polyEx = function(points, drawStyle)
      return primitives.polyEx(points, resolvedStyle(drawStyle, TARGET_POLY))
    end
    poly = function(points, fill, stroke, strokeWidth)
      return primitives.poly(points, fill, stroke, strokeWidth)
    end
    lineEx = function(x1, y1, x2, y2, drawStyle)
      return primitives.lineEx(x1, y1, x2, y2, resolvedStyle(drawStyle, TARGET_LINE))
    end
    line = function(x1, y1, x2, y2, width, fill)
      if width == nil then
        width = 1
      end
      return primitives.line(x1, y1, x2, y2, width, fill)
    end
    progressBarEx = function(x, y, w, h, value, drawStyle)
      return widgets.progressBarEx(x, y, w, h, value, resolvedStyle(drawStyle, TARGET_PROGRESS_BAR))
    end
    progressBar = function(x, y, w, h, value, radius, track, fill, stroke, strokeWidth)
      return widgets.progressBar(x, y, w, h, value, radius, track, fill, stroke, strokeWidth)
    end
    segmentBarEx = function(x, y, w, h, value, drawStyle)
      return widgets.segmentBarEx(x, y, w, h, value, resolvedStyle(drawStyle, TARGET_SEGMENT_BAR))
    end
    segmentBar = function(x, y, w, h, value, segments, fill, track)
      return widgets.segmentBar(x, y, w, h, value, segments, fill, track)
    end
    ringEx = function(cx, cy, radius, width, drawStyle)
      return widgets.ringEx(cx, cy, radius, width, resolvedStyle(drawStyle, TARGET_RING))
    end
    ring = function(cx, cy, radius, width, fill)
      return widgets.ring(cx, cy, radius, width, fill)
    end
    arcEx = function(cx, cy, radius, width, startDeg, endDeg, drawStyle)
      return widgets.arcEx(
        cx,
        cy,
        radius,
        width,
        startDeg,
        endDeg,
        resolvedStyle(drawStyle, TARGET_ARC)
      )
    end
    arc = function(cx, cy, radius, startDeg, endDeg, width, fill)
      return widgets.arc(cx, cy, radius, startDeg, endDeg, width, fill)
    end
    sectorEx = function(cx, cy, innerRadius, outerRadius, startDeg, endDeg, drawStyle)
      return widgets.sectorEx(
        cx,
        cy,
        innerRadius,
        outerRadius,
        startDeg,
        endDeg,
        resolvedStyle(drawStyle, TARGET_SECTOR)
      )
    end
    sector = function(cx, cy, innerRadius, outerRadius, startDeg, endDeg, fill)
      return widgets.sector(cx, cy, innerRadius, outerRadius, startDeg, endDeg, fill)
    end
    imageEx = function(x, y, w, h, source, drawStyle)
      return widgets.imageEx(x, y, w, h, source, resolvedStyle(drawStyle, TARGET_IMAGE))
    end
    image = function(x, y, w, h, source, radius, tint)
      return widgets.image(x, y, w, h, source, radius, tint)
    end
    iconEx = function(x, y, w, h, source, drawStyle)
      return widgets.iconEx(x, y, w, h, source, resolvedStyle(drawStyle, TARGET_IMAGE))
    end
    icon = function(x, y, w, h, source, tint)
      return widgets.icon(x, y, w, h, source, tint)
    end
    registerTextFont = function(fontName, spec)
      return textModule.registerFont(fontName, spec)
    end
    defineTextStyle = function(name, textStyle)
      return textModule.defineStyle(name, textStyle)
    end
    getTextStyle = function(name)
      return textModule.getStyle(name)
    end
    resolveTextStyle = function(textStyle)
      return textModule.resolveStyle(textStyle)
    end
    measureText = function(value, font)
      if font == nil then
        font = "DermaDefault"
      end
      return textModule.measure(value, font)
    end
    measureTextBox = function(value, font, w, textStyle)
      return textModule.measureBox(value, font, w, textStyle)
    end
    text = function(value, font, x, y, color, ax, ay)
      if ax == nil then
        ax = 0
      end
      if ay == nil then
        ay = 0
      end
      return textModule.draw(value, font, x, y, color, ax, ay)
    end
    textEx = function(value, font, x, y, color, ax, ay, textStyle)
      if ax == nil then
        ax = 0
      end
      if ay == nil then
        ay = 0
      end
      return textModule.drawEx(
        value,
        font,
        x,
        y,
        color,
        ax,
        ay,
        resolvedStyle(textStyle, TARGET_TEXT)
      )
    end
    textBox = function(value, font, x, y, w, h, color, alignX, alignY)
      if alignX == nil then
        alignX = TEXT_ALIGN_LEFT
      end
      if alignY == nil then
        alignY = TEXT_ALIGN_TOP
      end
      return textModule.box(value, font, x, y, w, h, color, alignX, alignY)
    end
    textBoxEx = function(value, font, x, y, w, h, textStyle)
      return textModule.boxEx(value, font, x, y, w, h, resolvedStyle(textStyle, TARGET_TEXT))
    end
    textBatchEx = function(records)
      return textModule.batch(records)
    end
    prewarmText = function(value, font, textStyle)
      return textModule.prewarm(value, font, textStyle)
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
  __lux_exports.mask = mask
  __lux_exports.backdrop = backdrop
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
