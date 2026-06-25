if SERVER then return end

MGFX = MGFX or {}

local bit_bor = bit.bor

local shaderKV = [==[
screenspace_general
{
	$pixshader ""
	$vertexshader ""

	$basetexture "color/white"
	$texture1    ""
	$texture2    ""
	$texture3    ""

	$ignorez            1
	$vertexcolor        1
	$vertextransform    1
	"<dx90"
	{
		$no_draw 1
	}

	$copyalpha                 0
	$alpha_blend_color_overlay 0
	$alpha_blend               1
	$linearwrite               1
	$linearread_basetexture    1
	$linearread_texture1       1
	$linearread_texture2       1
	$linearread_texture3       1

	$c0_x 0
	$c0_y 0
	$c0_z 0
	$c0_w 0
	$c1_x 1
	$c1_y 1
	$c1_z 0
	$c1_w 0
	$c2_x 0
	$c2_y 0
	$c2_z 1
	$c2_w 0
	$c3_x 0
	$c3_y 0
	$c3_z 0
	$c3_w 0
}
]==]

function MGFX._CreateMaterialState(owner)
	owner = owner or MGFX

	local shaderVersion = MGFXShaderPack and MGFXShaderPack.Version or ""
	local shaderMountName = shaderVersion ~= "" and ("mgfx_shaders_" .. shaderVersion .. ".gma") or nil

	if shaderMountName and MGFXShaderPack.GMA and MGFXShaderPack.GMA ~= "" then
		local decoded = util.Base64Decode(MGFXShaderPack.GMA)
		if decoded and decoded ~= "" then
			file.Write(shaderMountName, decoded)
			print("Mounting MGFX GMA: " .. tostring(game.MountGMA("data/" .. shaderMountName)))
			print("GMA Version: " .. shaderVersion)
		end
	end

	local function shaderName(name)
		return shaderVersion ~= "" and (shaderVersion .. "_" .. name) or name
	end

	local materials = {}
	local blurRTFlags = bit_bor(2, 256, 4, 8)
	local blurRT = GetRenderTargetEx(
		"MGFXBlur" .. (shaderVersion ~= "" and shaderVersion or "dev") .. SysTime(),
		ScrW(),
		ScrH(),
		RT_SIZE_LITERAL,
		MATERIAL_RT_DEPTH_SEPARATE,
		blurRTFlags,
		0,
		IMAGE_FORMAT_BGRA8888
	)

	local function createScreenMaterial(name, pixshader, values)
		local kv = util.KeyValuesToTable(shaderKV, false, true)
		kv["$pixshader"] = shaderName(pixshader)
		kv["$vertexshader"] = shaderName("mgfx_vs30")

		for k, v in pairs(values or {}) do
			kv[k] = v
		end

		return CreateMaterial("mgfx_" .. name .. "_" .. SysTime(), "screenspace_general", kv)
	end

	local function createMaterial(key, pixshader, values)
		local mat = createScreenMaterial(key, pixshader, values)
		materials[key] = mat
		return mat
	end

	local function createShapeMaterials()
		if materials.roundrect then return end

		createMaterial("roundrect", "mgfx_roundrect_ps30")
		createMaterial("roundrect_fx", "mgfx_roundrect_fx_ps30")
		createMaterial("roundrect_fused", "mgfx_roundrect_fused_ps30")
		createMaterial("roundrect_solid", "mgfx_roundrect_solid_ps30")
		createMaterial("roundrect_stroke", "mgfx_roundrect_stroke_ps30")
		createMaterial("roundrect_texture", "mgfx_roundrect_texture_ps30")
		createMaterial("param_probe", "mgfx_param_probe_ps30")
		createMaterial("param_probe_inv", "mgfx_param_probe_inv_ps30")
		createMaterial("chamfer", "mgfx_chamfer_ps30")
		createMaterial("chamfer_texture", "mgfx_chamfer_texture_ps30")
		createMaterial("image_mask", "mgfx_image_mask_ps30")
		createMaterial("image_mask_shadow_outer", "mgfx_image_mask_shadow_outer_ps30")
		createMaterial("image_mask_backdrop", "mgfx_image_mask_backdrop_ps30", {
			["$basetexture"] = blurRT:GetName(),
			["$texture1"] = "_rt_FullFrameFB",
		})
		createMaterial("image_mask_backdrop_fill", "mgfx_image_mask_backdrop_ps30")
		createMaterial("chamfer_stroke", "mgfx_chamfer_stroke_ps30")
		createMaterial("roundrect_blur", "mgfx_roundrect_blur_ps30", {
			["$basetexture"] = blurRT:GetName(),
			["$texture1"] = "_rt_FullFrameFB",
		})
		createMaterial("roundrect_innerglow", "mgfx_roundrect_innerglow_ps30")
		createMaterial("chamfer_innerglow", "mgfx_chamfer_innerglow_ps30")
		createMaterial("roundrect_shadow_outer", "mgfx_roundrect_shadow_outer_ps30")
		createMaterial("chamfer_shadow_outer", "mgfx_chamfer_shadow_outer_ps30")
		createMaterial("chamfer_backdrop", "mgfx_chamfer_backdrop_ps30", {
			["$basetexture"] = blurRT:GetName(),
			["$texture1"] = "_rt_FullFrameFB",
		})
		createMaterial("progress", "mgfx_progress_ps30")
		createMaterial("progress_fx", "mgfx_progress_fx_ps30")
		createMaterial("segmentbar", "mgfx_segmentbar_ps30")
		createMaterial("line", "mgfx_line_ps30")
		createMaterial("text_face", "mgfx_text_face_ps30", {
			["$linearread_basetexture"] = 0,
		})
		createMaterial("text_compose", "mgfx_text_compose_ps30", {
			["$linearread_basetexture"] = 0,
		})
		createMaterial("roundrect_pattern", "mgfx_roundrect_pattern_ps30")
		createMaterial("chamfer_pattern", "mgfx_chamfer_pattern_ps30")
		createMaterial("poly_pattern", "mgfx_poly_pattern_ps30")
		createMaterial("ring", "mgfx_ring_ps30")
		createMaterial("ring_fx", "mgfx_ring_fx_ps30")
		createMaterial("ring_backdrop", "mgfx_ring_backdrop_ps30", {
			["$basetexture"] = blurRT:GetName(),
			["$texture1"] = "_rt_FullFrameFB",
		})
		createMaterial("ring_stroke", "mgfx_ring_stroke_ps30")
		createMaterial("ring_innerglow", "mgfx_ring_innerglow_ps30")
		createMaterial("ring_shadow_outer", "mgfx_ring_shadow_outer_ps30")
		createMaterial("ring_pattern", "mgfx_ring_pattern_ps30")

		for _, count in ipairs({3, 4, 5, 6, 7, 8}) do
			createMaterial("poly" .. count .. "_stroke", "mgfx_poly" .. count .. "_stroke_ps30")
			createMaterial("poly" .. count, "mgfx_poly" .. count .. "_ps30")
			createMaterial("poly" .. count .. "_shadow", "mgfx_poly" .. count .. "_shadow_ps30")
			createMaterial("poly" .. count .. "_outerglow", "mgfx_poly" .. count .. "_outerglow_ps30")
			createMaterial("poly" .. count .. "_blur", "mgfx_poly" .. count .. "_blur_ps30", {
				["$basetexture"] = blurRT:GetName(),
				["$texture1"] = "_rt_FullFrameFB",
			})
		end
	end

	local function matOK(mat)
		return mat and not mat:IsError()
	end

	createShapeMaterials()

	local state = {
		shaderVersion = shaderVersion,
		shaderMountName = shaderMountName,
		materials = materials,
		blurRT = blurRT,
		matOK = matOK,
		shaderName = shaderName,
	}

	-- Per-page text materials: the compose/face shaders bound to a SPECIFIC atlas
	-- page RT. Drawing many pages in one frame through a single shared material
	-- (rebinding its $basetexture per page) makes Source keep the previously bound
	-- page, so later pages sample the wrong RT and render blank. A distinct
	-- material object per page lets render.SetMaterial rebind correctly.
	function state.CreatePageTextMaterials(rt)
		local key = (rt and rt.GetName and rt:GetName()) or tostring(rt)
		return {
			compose = createScreenMaterial("text_compose_pg_" .. key, "mgfx_text_compose_ps30", {
				["$linearread_basetexture"] = 0,
				["$basetexture"] = key,
			}),
			face = createScreenMaterial("text_face_pg_" .. key, "mgfx_text_face_ps30", {
				["$linearread_basetexture"] = 0,
				["$basetexture"] = key,
			}),
		}
	end

	function owner.hasShaders()
		if render.GetDXLevel and render.GetDXLevel() < 90 then return false end
		return shaderVersion ~= "" and matOK(materials.roundrect)
	end

	function owner.shaderStatus()
		return {
			loaded = owner.hasShaders(),
			version = shaderVersion,
			mount = shaderMountName or "external/custom",
			roundrect = materials.roundrect,
			roundrectFx = materials.roundrect_fx,
			roundrectFused = materials.roundrect_fused,
			roundrectSolid = materials.roundrect_solid,
			roundrectStroke = materials.roundrect_stroke,
			paramProbe = materials.param_probe,
			paramProbeInv = materials.param_probe_inv,
			chamfer = materials.chamfer,
			blur = materials.roundrect_blur,
			image = materials.roundrect_texture,
			chamferImage = materials.chamfer_texture,
			imageMask = materials.image_mask,
			imageMaskShadowOuter = materials.image_mask_shadow_outer,
			imageMaskBackdrop = materials.image_mask_backdrop,
			imageMaskBackdropFill = materials.image_mask_backdrop_fill,
			chamferStroke = materials.chamfer_stroke,
			innerGlow = materials.roundrect_innerglow,
			chamferInnerGlow = materials.chamfer_innerglow,
			shadowOuter = materials.roundrect_shadow_outer,
			chamferShadowOuter = materials.chamfer_shadow_outer,
			chamferBackdrop = materials.chamfer_backdrop,
			progress = materials.progress,
			progressFx = materials.progress_fx,
			segmentbar = materials.segmentbar,
			line = materials.line,
			textCompose = materials.text_compose,
			pattern = materials.roundrect_pattern,
			chamferPattern = materials.chamfer_pattern,
			polyPattern = materials.poly_pattern,
			ring = materials.ring,
			ringFx = materials.ring_fx,
			ringBackdrop = materials.ring_backdrop,
			ringStroke = materials.ring_stroke,
			ringInnerGlow = materials.ring_innerglow,
			ringShadowOuter = materials.ring_shadow_outer,
			ringPattern = materials.ring_pattern,
			poly3Stroke = materials.poly3_stroke,
			poly3 = materials.poly3,
			poly3Shadow = materials.poly3_shadow,
			poly3OuterGlow = materials.poly3_outerglow,
			poly3Blur = materials.poly3_blur,
			poly4Stroke = materials.poly4_stroke,
			poly4 = materials.poly4,
			poly4Shadow = materials.poly4_shadow,
			poly4OuterGlow = materials.poly4_outerglow,
			poly4Blur = materials.poly4_blur,
			poly5Stroke = materials.poly5_stroke,
			poly5 = materials.poly5,
			poly5Shadow = materials.poly5_shadow,
			poly5OuterGlow = materials.poly5_outerglow,
			poly5Blur = materials.poly5_blur,
			poly6Stroke = materials.poly6_stroke,
			poly6 = materials.poly6,
			poly6Shadow = materials.poly6_shadow,
			poly6OuterGlow = materials.poly6_outerglow,
			poly6Blur = materials.poly6_blur,
			poly7Stroke = materials.poly7_stroke,
			poly7 = materials.poly7,
			poly7Shadow = materials.poly7_shadow,
			poly7OuterGlow = materials.poly7_outerglow,
			poly7Blur = materials.poly7_blur,
			poly8Stroke = materials.poly8_stroke,
			poly8 = materials.poly8,
			poly8Shadow = materials.poly8_shadow,
			poly8OuterGlow = materials.poly8_outerglow,
			poly8Blur = materials.poly8_blur,
		}
	end

	return state
end
