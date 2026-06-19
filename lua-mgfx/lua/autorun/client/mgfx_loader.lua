if SERVER then return end

MGFX = MGFX or {}
MGFX._BasePath = "mgfx/"

include("mgfx/cl_mgfx_shaderpack.lua")
include("mgfx/cl_mgfx.lua")

local demoCvar = GetConVar("mgfx_enable_demos")
if (demoCvar and demoCvar:GetBool()) or MGFX_INCLUDE_DEMOS == true then
	include("mgfx/cl_mgfx_demo.lua")
	include("mgfx/cl_mgfx_wheel_demo.lua")
end
