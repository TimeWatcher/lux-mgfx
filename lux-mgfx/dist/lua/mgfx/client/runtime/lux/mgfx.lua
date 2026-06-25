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
    local __lux_import_1 = __lux_import("lux/mgfx/api#client")
    local api_mod = __lux_import_1
    local __lux_import_2 = __lux_import("lux/mgfx/capabilities#client")
    local capabilities_mod = __lux_import_2
    local __lux_import_3 = __lux_import("lux/mgfx/commands#client")
    local commands_mod = __lux_import_3
    local __lux_import_4 = __lux_import("lux/mgfx/console#client")
    local console_mod = __lux_import_4
    local __lux_import_5 = __lux_import("lux/mgfx/frame#client")
    local frame_mod = __lux_import_5
    local __lux_import_6 = __lux_import("lux/mgfx/geometry#client")
    local geometry_mod = __lux_import_6
    local __lux_import_7 = __lux_import("lux/mgfx/materials#client")
    local materials_mod = __lux_import_7
    local __lux_import_8 = __lux_import("lux/mgfx/paint#client")
    local paint_mod = __lux_import_8
    local __lux_import_9 = __lux_import("lux/mgfx/primitives#client")
    local primitives_mod = __lux_import_9
    local __lux_import_10 = __lux_import("lux/mgfx/profiler#client")
    local profiler_mod = __lux_import_10
    local __lux_import_11 = __lux_import("lux/mgfx/roundrect#client")
    local roundrect_mod = __lux_import_11
    local __lux_import_12 = __lux_import("lux/mgfx/shaderpack#client")
    local shaderpack_mod = __lux_import_12
    local __lux_import_13 = __lux_import("lux/mgfx/style#client")
    local style_mod = __lux_import_13
    local __lux_import_14 = __lux_import("lux/mgfx/text#client")
    local text_mod = __lux_import_14
    local __lux_import_15 = __lux_import("lux/mgfx/widgets#client")
    local widgets_mod = __lux_import_15
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
      local out
      do
        local __lux_tmp_16 = _G[name]
        if __lux_tmp_16 == nil then
          __lux_tmp_16 = {}
        end
        out = __lux_tmp_16
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
