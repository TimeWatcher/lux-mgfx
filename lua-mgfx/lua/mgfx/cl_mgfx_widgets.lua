if SERVER then return end

MGFX = MGFX or {}

function MGFX._InstallWidgets(C)
	local installers = {
		MGFX._InstallWidgetBars,
		MGFX._InstallWidgetRings,
		MGFX._InstallWidgetImages,
		MGFX._InstallWidgetText,
	}

	for _, install in ipairs(installers) do
		assert(type(install) == "function", "MGFX widget submodule missing")
		install(C)
	end
end
