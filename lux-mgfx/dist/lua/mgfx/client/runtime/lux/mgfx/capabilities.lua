return function(__lux_import)
  local __lux_exports = {}
  local makeColor
  local tableCopy
  local typeOf
  local colorStyleCache
  local keySet
  local TARGET
  local TARGET_NAME
  local matrix
  local get
  local supports
  local isPattern
  local isFill
  local normalizePaintSlots
  local normalizeStyle
  local install
  do
    local style = __lux_import("lux/mgfx/style#client")
    makeColor = Color
    tableCopy = table.Copy
    typeOf = type
    colorStyleCache = setmetatable({}, { __mode = "k" })
    keySet = function(...)
      local out = {}
      for index = 1, select("#", ...) do
        local key = select(index, ...)
        out[key] = true
      end
      return out
    end
    TARGET = {}
    TARGET_NAME = {}
    matrix = {}
    TARGET.ROUNDED_BOX = 1
    TARGET_NAME[1] = "MGFX.TARGET.ROUNDED_BOX"
    matrix[1] = {
      family = "shape",
      coverage = "roundedBox",
      keys = keySet(
        "fill",
        "stroke",
        "strokeWidth",
        "shadow",
        "outerGlow",
        "innerGlow",
        "backdrop",
        "pattern",
        "transform"
      ),
    }
    TARGET.CHAMFER_BOX = 2
    TARGET_NAME[2] = "MGFX.TARGET.CHAMFER_BOX"
    matrix[2] = {
      family = "shape",
      coverage = "chamferBox",
      keys = keySet(
        "fill",
        "stroke",
        "strokeWidth",
        "shadow",
        "outerGlow",
        "innerGlow",
        "backdrop",
        "pattern",
        "cuts",
        "transform"
      ),
    }
    TARGET.POLY = 3
    TARGET_NAME[3] = "MGFX.TARGET.POLY"
    matrix[3] = {
      family = "shape",
      coverage = "convexPoly",
      keys = keySet(
        "fill",
        "stroke",
        "strokeWidth",
        "shadow",
        "outerGlow",
        "backdrop",
        "pattern",
        "transform"
      ),
    }
    TARGET.LINE = 4
    TARGET_NAME[4] = "MGFX.TARGET.LINE"
    matrix[4] = {
      family = "shape",
      coverage = "line",
      keys = keySet(
        "fill",
        "color",
        "width",
        "radius",
        "caps",
        "noCaps",
        "outerGlow",
        "backdrop",
        "transform"
      ),
    }
    TARGET.CIRCLE = 5
    TARGET_NAME[5] = "MGFX.TARGET.CIRCLE"
    matrix[5] = {
      family = "shape",
      coverage = "circle",
      keys = keySet(
        "fill",
        "stroke",
        "strokeWidth",
        "shadow",
        "outerGlow",
        "innerGlow",
        "backdrop",
        "pattern",
        "transform"
      ),
    }
    TARGET.CAPSULE = 6
    TARGET_NAME[6] = "MGFX.TARGET.CAPSULE"
    matrix[6] = {
      family = "shape",
      coverage = "capsule",
      keys = keySet(
        "fill",
        "stroke",
        "strokeWidth",
        "shadow",
        "outerGlow",
        "innerGlow",
        "backdrop",
        "pattern",
        "transform"
      ),
    }
    TARGET.IMAGE = 8
    TARGET_NAME[8] = "MGFX.TARGET.IMAGE"
    matrix[8] = {
      family = "content",
      coverage = "imageMask",
      keys = keySet(
        "source",
        "fill",
        "background",
        "stroke",
        "strokeWidth",
        "shadow",
        "outerGlow",
        "backdrop",
        "mask",
        "radius",
        "tint",
        "color",
        "alpha",
        "fit",
        "objectFit",
        "position",
        "positionX",
        "positionY",
        "alignX",
        "alignY",
        "crop",
        "uv",
        "transform"
      ),
    }
    TARGET.PROGRESS_BAR = 9
    TARGET_NAME[9] = "MGFX.TARGET.PROGRESS_BAR"
    matrix[9] = {
      family = "compound",
      coverage = "progress",
      keys = keySet(
        "track",
        "fill",
        "stroke",
        "strokeWidth",
        "radius",
        "padding",
        "shadow",
        "outerGlow",
        "innerGlow",
        "backdrop",
        "fillPattern",
        "trackPattern",
        "pattern",
        "fx",
        "transform"
      ),
    }
    TARGET.SEGMENT_BAR = 10
    TARGET_NAME[10] = "MGFX.TARGET.SEGMENT_BAR"
    matrix[10] = {
      family = "compound",
      coverage = "segmentBar",
      keys = keySet(
        "segments",
        "gap",
        "track",
        "fill",
        "stroke",
        "strokeWidth",
        "radius",
        "background",
        "backgroundRadius",
        "shadow",
        "outerGlow",
        "innerGlow",
        "backdrop",
        "fillPattern",
        "trackPattern",
        "pattern",
        "transform"
      ),
    }
    TARGET.RING = 11
    TARGET_NAME[11] = "MGFX.TARGET.RING"
    matrix[11] = {
      family = "shape",
      coverage = "ring",
      keys = keySet(
        "fill",
        "color",
        "stroke",
        "strokeWidth",
        "shadow",
        "outerGlow",
        "innerGlow",
        "backdrop",
        "pattern",
        "transform"
      ),
    }
    TARGET.ARC = 12
    TARGET_NAME[12] = "MGFX.TARGET.ARC"
    matrix[12] = {
      family = "shape",
      coverage = "arc",
      keys = keySet(
        "fill",
        "color",
        "stroke",
        "strokeWidth",
        "shadow",
        "outerGlow",
        "innerGlow",
        "backdrop",
        "pattern",
        "transform"
      ),
    }
    TARGET.TEXT = 13
    TARGET_NAME[13] = "MGFX.TARGET.TEXT"
    matrix[13] = {
      family = "text",
      coverage = "glyph",
      keys = keySet(
        "fill",
        "color",
        "alignX",
        "alignY",
        "valign",
        "shadow",
        "stroke",
        "glow",
        "weight",
        "italic",
        "letterSpacing",
        "lineHeight"
      ),
    }
    TARGET.SECTOR = 14
    TARGET_NAME[14] = "MGFX.TARGET.SECTOR"
    matrix[14] = {
      family = "shape",
      coverage = "sector",
      keys = keySet(
        "fill",
        "color",
        "stroke",
        "strokeWidth",
        "shadow",
        "outerGlow",
        "innerGlow",
        "backdrop",
        "pattern",
        "transform"
      ),
    }
    get = function(target)
      return matrix[target]
    end
    supports = function(target, key)
      local entry = get(target)
      return entry ~= nil and entry.keys ~= nil and entry.keys[key] == true
    end
    isPattern = function(value)
      local __lux_tmp_4 = typeOf(value) == "table"
      if __lux_tmp_4 then
        local __lux_tmp_1
        local __lux_match_2 = value
        local __lux_tag_3
        if __lux_match_2 ~= nil then
          __lux_tag_3 = __lux_match_2.kind
        end
        if __lux_tag_3 == style.PATTERN_STRIPE or __lux_tag_3 == style.PATTERN_SMOKE then
          __lux_tmp_1 = true
        else
          __lux_tmp_1 = false
        end
        __lux_tmp_4 = __lux_tmp_1
      end
      return __lux_tmp_4
    end
    isFill = function(value)
      if typeOf(value) ~= "table" then
        return true
      end
      local __lux_match_5 = value
      local __lux_tag_6
      if __lux_match_5 ~= nil then
        __lux_tag_6 = __lux_match_5.kind
      end
      if __lux_tag_6 == style.FILL_SOLID or __lux_tag_6 == style.FILL_LINEAR or __lux_tag_6 == style.FILL_RADIAL or __lux_tag_6 == style.FILL_CONIC then
        return true
      else
        return value.r ~= nil
      end
    end
    normalizePaintSlots = function(input, target)
      if typeOf(input) ~= "table" then
        return input
      end
      local fill = input.fill
      local fillKind
      if typeOf(fill) == "table" then
        fillKind = fill.kind
      else
        fillKind = nil
      end
      if fillKind ~= style.PATTERN_STRIPE and fillKind ~= style.PATTERN_SMOKE then
        return input
      end
      local __lux_match_7 = target
      if __lux_match_7 == 9 or __lux_match_7 == 10 then
        local out = tableCopy(input)
        if out.fillPattern == nil then
          out.fillPattern = out.fill
        end
        do
          local __lux_tmp_fillBase_8 = out.fillBase
          if __lux_tmp_fillBase_8 == nil then
            __lux_tmp_fillBase_8 = out.baseFill
          end
          out.fill = __lux_tmp_fillBase_8
        end
        return out
      else
        local __lux_unused_9 = nil
      end
      local cap = get(target)
      if cap == nil or cap.keys == nil or cap.keys.pattern ~= true or input.pattern ~= nil then
        return input
      end
      local out = tableCopy(input)
      out.pattern = out.fill
      do
        local __lux_tmp_patternBase_10 = out.patternBase
        if __lux_tmp_patternBase_10 == nil then
          __lux_tmp_patternBase_10 = out.baseFill
        end
        if __lux_tmp_patternBase_10 == nil then
          __lux_tmp_patternBase_10 = makeColor(0, 0, 0, 0)
        end
        out.fill = __lux_tmp_patternBase_10
      end
      return out
    end
    normalizeStyle = function(input, target)
      if input == nil then
        return {}
      end
      if style.isColor(input) then
        local cached = colorStyleCache[input]
        if cached == nil then
          cached = { fill = input }
          colorStyleCache[input] = cached
        end
        return cached
      end
      if typeOf(input) ~= "table" then
        return {}
      end
      return normalizePaintSlots(input, target)
    end
    install = function(owner)
      owner.GetCapabilities = get
      owner.Supports = supports
      owner.IsPattern = isPattern
      owner.IsFill = isFill
      owner.NormalizeStyle = normalizeStyle
      owner.hasShaders = function()
        return false
      end
      owner.shaderStatus = function()
        return { ok = false, shaderVersion = nil, reason = "lux/mgfx fallback renderer active" }
      end
      return owner
    end
  end
  
  __lux_exports.TARGET = TARGET
  __lux_exports.TARGET_NAME = TARGET_NAME
  __lux_exports.get = get
  __lux_exports.supports = supports
  __lux_exports.isPattern = isPattern
  __lux_exports.isFill = isFill
  __lux_exports.normalizeStyle = normalizeStyle
  __lux_exports.install = install
  
  return __lux_exports
end
