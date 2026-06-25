return function(__lux_import)
  local __lux_exports = {}
  local api
  local capabilities
  local commands
  local console
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
  local install
  local installGlobal
  local create
  do
    local api_mod = __lux_import("lux/mgfx/api#client")
    local capabilities_mod = __lux_import("lux/mgfx/capabilities#client")
    local commands_mod = __lux_import("lux/mgfx/commands#client")
    local console_mod = __lux_import("lux/mgfx/console#client")
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
    api = api_mod
    capabilities = capabilities_mod
    commands = commands_mod
    console = console_mod
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
    install = function(owner)
      return api.install(owner)
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
      return api.create()
    end
  end
  
  __lux_exports.install = install
  __lux_exports.installGlobal = installGlobal
  __lux_exports.create = create
  __lux_exports.api = api
  __lux_exports.capabilities = capabilities
  __lux_exports.commands = commands
  __lux_exports.console = console
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
