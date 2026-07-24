if SERVER then return end

MGFX = MGFX or {}

local RUNTIME_INSTALL_VERSION = "coverage-v2-runtime-1"
local installedRuntime = MGFX._internal and MGFX._internal.runtimeInstall
if installedRuntime then
	if installedRuntime.version ~= RUNTIME_INSTALL_VERSION then
			error("another MGFX runtime version is already installed; perform a full client Lua refresh before replacing it", 2)
	end
else
	MGFX._BasePath = "mgfx/"
	include("mgfx/cl_mgfx_shaderpack.lua")
	include("mgfx/cl_mgfx.lua")
end

include("mgfx/cl_mgfx_demo.lua")
include("mgfx/cl_mgfx_wheel_demo.lua")
include("mgfx/cl_mgfx_perf_demo.lua")
