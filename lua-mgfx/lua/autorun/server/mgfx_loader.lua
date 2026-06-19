if CLIENT then return end

local files = {
	"cl_mgfx_shaderpack.lua",
	"cl_mgfx_materials.lua",
	"cl_mgfx_capabilities.lua",
	"cl_mgfx_style.lua",
	"cl_mgfx_geometry.lua",
	"cl_mgfx_frame_geometry.lua",
	"cl_mgfx_commands.lua",
	"cl_mgfx_profiler.lua",
	"cl_mgfx_text.lua",
	"cl_mgfx_roundrect.lua",
	"cl_mgfx_primitives.lua",
	"cl_mgfx_widgets_bars.lua",
	"cl_mgfx_widgets_rings.lua",
	"cl_mgfx_widgets_images.lua",
	"cl_mgfx_widgets_text.lua",
	"cl_mgfx_widgets.lua",
	"cl_mgfx_frame.lua",
	"cl_mgfx_console.lua",
	"cl_mgfx.lua",
}

local demoFiles = {
	"cl_mgfx_demo.lua",
	"cl_mgfx_wheel_demo.lua",
}

AddCSLuaFile("autorun/client/mgfx_loader.lua")

for _, name in ipairs(files) do
	AddCSLuaFile("mgfx/" .. name)
end

for _, name in ipairs(demoFiles) do
	AddCSLuaFile("mgfx/" .. name)
end

resource.AddFile("resource/fonts/notosanssc-vf.ttf")
