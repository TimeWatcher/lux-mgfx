return function(__lux_import)
  local __lux_exports = {}
  local tableConcat
  local VERSION
  local chunks
  local cachedGma
  local gma
  local pack
  local current
  local installGlobal
  do
    local __lux_import_1 = __lux_import("lux/mgfx/shaderpack/chunk01#client")
    local chunk01 = __lux_import_1.chunk01
    local __lux_import_2 = __lux_import("lux/mgfx/shaderpack/chunk02#client")
    local chunk02 = __lux_import_2.chunk02
    local __lux_import_3 = __lux_import("lux/mgfx/shaderpack/chunk03#client")
    local chunk03 = __lux_import_3.chunk03
    local __lux_import_4 = __lux_import("lux/mgfx/shaderpack/chunk04#client")
    local chunk04 = __lux_import_4.chunk04
    local __lux_import_5 = __lux_import("lux/mgfx/shaderpack/chunk05#client")
    local chunk05 = __lux_import_5.chunk05
    tableConcat = table.concat
    VERSION = "1783792605"
    chunks = { chunk01, chunk02, chunk03, chunk04, chunk05 }
    cachedGma = nil
    gma = function()
      if cachedGma == nil then
        cachedGma = tableConcat(chunks)
      end
      return cachedGma
    end
    pack = function()
      return { Version = VERSION, GMA = gma() }
    end
    current = function()
      local globalPack = MGFXShaderPack
      if globalPack ~= nil and globalPack.GMA ~= nil and globalPack.GMA ~= "" then
        return globalPack
      end
      return pack()
    end
    installGlobal = function(name)
      if name == nil then
        name = "MGFXShaderPack"
      end
      local target = _G[name]
      if target == nil then
        target = {}
      end
      target.Version = VERSION
      target.GMA = gma()
      _G[name] = target
      return target
    end
  end

  __lux_exports.VERSION = VERSION
  __lux_exports.gma = gma
  __lux_exports.pack = pack
  __lux_exports.current = current
  __lux_exports.installGlobal = installGlobal

  return __lux_exports
end
