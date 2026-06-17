return function(__lux_import)
  local __lux_exports = {}
  local capabilities
  local commands
  local frame
  local geometry
  local materials
  local paint
  local primitives
  local profiler
  local roundrect
  local shaderpack
  local style
  local text
  local widgets
  local installTargets
  local resetFrameStats
  local installFrameStatsReset
  local install
  local installGlobal
  local create
  do
    local capabilities_mod = __lux_import("lux/mgfx/capabilities#client")
    local commands_mod = __lux_import("lux/mgfx/commands#client")
    local frame_mod = __lux_import("lux/mgfx/frame#client")
    local geometry_mod = __lux_import("lux/mgfx/geometry#client")
    local materials_mod = __lux_import("lux/mgfx/materials#client")
    local paint_mod = __lux_import("lux/mgfx/paint#client")
    local primitives_mod = __lux_import("lux/mgfx/primitives#client")
    local profiler_mod = __lux_import("lux/mgfx/profiler#client")
    local roundrect_mod = __lux_import("lux/mgfx/roundrect#client")
    local shaderpack_mod = __lux_import("lux/mgfx/shaderpack#client")
    local style_mod = __lux_import("lux/mgfx/style#client")
    local text_mod = __lux_import("lux/mgfx/text#client")
    local widgets_mod = __lux_import("lux/mgfx/widgets#client")
    capabilities = capabilities_mod
    commands = commands_mod
    frame = frame_mod
    geometry = geometry_mod
    materials = materials_mod
    paint = paint_mod
    primitives = primitives_mod
    profiler = profiler_mod
    roundrect = roundrect_mod
    shaderpack = shaderpack_mod
    style = style_mod
    text = text_mod
    widgets = widgets_mod
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
    install = function(owner)
      local api = owner
      if api == nil then
        api = {}
      end
      api.Reload = function()
        return install(api)
      end
      api._LuxReload = api.Reload
      installTargets(api)
      shaderpack.installGlobal()
      style.install(api)
      capabilities.install(api)
      commands.install(api)
      frame.install(api)
      geometry.install(api)
      materials.install(api)
      profiler.install(api)
      paint.install(api)
      text.install(api)
      roundrect.install(api)
      primitives.install(api)
      widgets.install(api)
      installFrameStatsReset(api)
      return api
    end
    installGlobal = function(name)
      if name == nil then
        name = "MGFX"
      end
      local api = _G[name]
      if api == nil then
        api = {}
      end
      _G[name] = install(api)
      return _G[name]
    end
    create = function()
      return install({})
    end
  end
  
  __lux_exports.install = install
  __lux_exports.installGlobal = installGlobal
  __lux_exports.create = create
  __lux_exports.capabilities = capabilities
  __lux_exports.commands = commands
  __lux_exports.frame = frame
  __lux_exports.geometry = geometry
  __lux_exports.materials = materials
  __lux_exports.paint = paint
  __lux_exports.primitives = primitives
  __lux_exports.profiler = profiler
  __lux_exports.roundrect = roundrect
  __lux_exports.shaderpack = shaderpack
  __lux_exports.style = style
  __lux_exports.text = text
  __lux_exports.widgets = widgets
  
  return __lux_exports
end
