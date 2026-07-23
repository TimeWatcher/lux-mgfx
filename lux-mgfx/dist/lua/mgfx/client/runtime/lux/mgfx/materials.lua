return function(__lux_import)
  local __lux_exports = {}
  local shaderpack
  local bitBor
  local createMaterial
  local fileWrite
  local gameMountGMA
  local getRenderTargetEx
  local makeMaterial
  local printFn
  local renderGetDXLevel
  local sysTime
  local systemIsWindows
  local tableCopy
  local toString
  local typeOf
  local utilBase64Decode
  local utilKeyValuesToTable
  local shaderKV
  local materialKeys
  local shaderNames
  local shaderPack
  local matOK
  local shaderName
  local mountShaderPack
  local blurTargets
  local screenMaterialFactory
  local textureValues
  local materialValues
  local create
  local hasShaders
  local shaderStatus
  local textureFallbackMaterial
  local install
  do
    local shaderpackImport = __lux_import("lux/mgfx/shaderpack#client")
    shaderpack = shaderpackImport
    do
      local __lux_obj_bit_1 = bit
      local __lux_val_bor_2 = nil
      if __lux_obj_bit_1 ~= nil then
        __lux_val_bor_2 = __lux_obj_bit_1.bor
      end
      bitBor = __lux_val_bor_2
    end
    createMaterial = CreateMaterial
    do
      local __lux_obj_file_3 = file
      local __lux_val_Write_4 = nil
      if __lux_obj_file_3 ~= nil then
        __lux_val_Write_4 = __lux_obj_file_3.Write
      end
      fileWrite = __lux_val_Write_4
    end
    do
      local __lux_obj_game_5 = game
      local __lux_val_MountGMA_6 = nil
      if __lux_obj_game_5 ~= nil then
        __lux_val_MountGMA_6 = __lux_obj_game_5.MountGMA
      end
      gameMountGMA = __lux_val_MountGMA_6
    end
    getRenderTargetEx = GetRenderTargetEx
    makeMaterial = Material
    printFn = print
    do
      local __lux_obj_render_7 = render
      local __lux_val_GetDXLevel_8 = nil
      if __lux_obj_render_7 ~= nil then
        __lux_val_GetDXLevel_8 = __lux_obj_render_7.GetDXLevel
      end
      renderGetDXLevel = __lux_val_GetDXLevel_8
    end
    sysTime = SysTime
    systemIsWindows = system.IsWindows
    tableCopy = table.Copy
    toString = tostring
    typeOf = type
    do
      local __lux_obj_util_9 = util
      local __lux_val_Base64Decode_10 = nil
      if __lux_obj_util_9 ~= nil then
        __lux_val_Base64Decode_10 = __lux_obj_util_9.Base64Decode
      end
      utilBase64Decode = __lux_val_Base64Decode_10
    end
    do
      local __lux_obj_util_11 = util
      local __lux_val_KeyValuesToTable_12 = nil
      if __lux_obj_util_11 ~= nil then
        __lux_val_KeyValuesToTable_12 = __lux_obj_util_11.KeyValuesToTable
      end
      utilKeyValuesToTable = __lux_val_KeyValuesToTable_12
    end
    shaderKV = "screenspace_general\n" ..
      "{\n" ..
        "  $pixshader \"\"\n" ..
          "  $vertexshader \"\"\n" ..
            "  $basetexture \"color/white\"\n" ..
              "  $texture1 \"color/white\"\n" ..
                "  $texture2 \"\"\n" ..
                  "  $texture3 \"\"\n" ..
                    "  $ignorez 1\n" ..
                      "  $vertexcolor 1\n" ..
                        "  $vertextransform 1\n" ..
                          "  $copyalpha 0\n" ..
                            "  $alpha_blend_color_overlay 0\n" ..
                              "  $alpha_blend 1\n" ..
                                "  $linearwrite 1\n" ..
                                  "  $linearread_basetexture 1\n" ..
                                    "  $linearread_texture1 1\n" ..
                                      "  $linearread_texture2 1\n" ..
                                        "  $linearread_texture3 1\n" ..
                                          "  $c0_x 0\n" ..
                                            "  $c0_y 0\n" ..
                                              "  $c0_z 0\n" ..
                                                "  $c0_w 0\n" ..
                                                  "  $c1_x 1\n" ..
                                                    "  $c1_y 1\n" ..
                                                      "  $c1_z 0\n" ..
                                                        "  $c1_w 0\n" ..
                                                          "  $c2_x 0\n" ..
                                                            "  $c2_y 0\n" ..
                                                              "  $c2_z 1\n" ..
                                                                "  $c2_w 0\n" ..
                                                                  "  $c3_x 0\n" .. "  $c3_y 0\n" .. "  $c3_z 0\n" .. "  $c3_w 0\n" .. "}\n"
    materialKeys = {
      "roundrect",
      "roundrect_fx",
      "roundrect_fused",
      "roundrect_solid",
      "roundrect_stroke",
      "roundrect_texture",
      "param_probe",
      "param_probe_inv",
      "chamfer",
      "chamfer_texture",
      "image_mask",
      "shape_clip",
      "image_mask_shadow_outer",
      "image_mask_backdrop",
      "image_mask_backdrop_fill",
      "chamfer_stroke",
      "backdrop_blur_horizontal",
      "backdrop_blur_vertical",
      "roundrect_blur",
      "roundrect_innerglow",
      "chamfer_innerglow",
      "roundrect_shadow_outer",
      "chamfer_shadow_outer",
      "chamfer_backdrop",
      "progress",
      "progress_fx",
      "segmentbar",
      "line",
      "text_face",
      "text_compose",
      "roundrect_pattern",
      "chamfer_pattern",
      "poly_pattern",
      "ring",
      "ring_fx",
      "ring_backdrop",
      "ring_stroke",
      "ring_innerglow",
      "ring_shadow_outer",
      "ring_pattern",
      "poly3_stroke",
      "poly3",
      "poly3_shadow",
      "poly3_outerglow",
      "poly3_blur",
      "poly4_stroke",
      "poly4",
      "poly4_shadow",
      "poly4_outerglow",
      "poly4_blur",
      "poly5_stroke",
      "poly5",
      "poly5_shadow",
      "poly5_outerglow",
      "poly5_blur",
      "poly6_stroke",
      "poly6",
      "poly6_shadow",
      "poly6_outerglow",
      "poly6_blur",
      "poly7_stroke",
      "poly7",
      "poly7_shadow",
      "poly7_outerglow",
      "poly7_blur",
      "poly8_stroke",
      "poly8",
      "poly8_shadow",
      "poly8_outerglow",
      "poly8_blur",
    }
    shaderNames = {
      roundrect = "mgfx_roundrect_ps30",
      roundrect_fx = "mgfx_roundrect_fx_ps30",
      roundrect_fused = "mgfx_roundrect_fused_ps30",
      roundrect_solid = "mgfx_roundrect_solid_ps30",
      roundrect_stroke = "mgfx_roundrect_stroke_ps30",
      roundrect_texture = "mgfx_roundrect_texture_ps30",
      param_probe = "mgfx_param_probe_ps30",
      param_probe_inv = "mgfx_param_probe_inv_ps30",
      chamfer = "mgfx_chamfer_ps30",
      chamfer_texture = "mgfx_chamfer_texture_ps30",
      image_mask = "mgfx_image_mask_ps30",
      shape_clip = "mgfx_shape_clip_ps30",
      image_mask_shadow_outer = "mgfx_image_mask_shadow_outer_ps30",
      image_mask_backdrop = "mgfx_image_mask_backdrop_sample_ps30",
      image_mask_backdrop_fill = "mgfx_image_mask_backdrop_ps30",
      chamfer_stroke = "mgfx_chamfer_stroke_ps30",
      backdrop_blur_horizontal = "mgfx_poly3_blur_ps30",
      backdrop_blur_vertical = "mgfx_poly3_blur_ps30",
      roundrect_blur = "mgfx_roundrect_backdrop_sample_ps30",
      roundrect_innerglow = "mgfx_roundrect_innerglow_ps30",
      chamfer_innerglow = "mgfx_chamfer_innerglow_ps30",
      roundrect_shadow_outer = "mgfx_roundrect_shadow_outer_ps30",
      chamfer_shadow_outer = "mgfx_chamfer_shadow_outer_ps30",
      chamfer_backdrop = "mgfx_chamfer_backdrop_sample_ps30",
      progress = "mgfx_progress_ps30",
      progress_fx = "mgfx_progress_fx_ps30",
      segmentbar = "mgfx_segmentbar_ps30",
      line = "mgfx_line_ps30",
      text_face = "mgfx_text_face_ps30",
      text_compose = "mgfx_text_compose_ps30",
      roundrect_pattern = "mgfx_roundrect_pattern_ps30",
      chamfer_pattern = "mgfx_chamfer_pattern_ps30",
      poly_pattern = "mgfx_poly_pattern_ps30",
      ring = "mgfx_ring_ps30",
      ring_fx = "mgfx_ring_fx_ps30",
      ring_backdrop = "mgfx_ring_backdrop_sample_ps30",
      ring_stroke = "mgfx_ring_stroke_ps30",
      ring_innerglow = "mgfx_ring_innerglow_ps30",
      ring_shadow_outer = "mgfx_ring_shadow_outer_ps30",
      ring_pattern = "mgfx_ring_pattern_ps30",
      poly3_stroke = "mgfx_poly3_stroke_ps30",
      poly3 = "mgfx_poly3_ps30",
      poly3_shadow = "mgfx_poly3_shadow_ps30",
      poly3_outerglow = "mgfx_poly3_outerglow_ps30",
      poly3_blur = "mgfx_backdrop_sample_ps30",
      poly4_stroke = "mgfx_poly4_stroke_ps30",
      poly4 = "mgfx_poly4_ps30",
      poly4_shadow = "mgfx_poly4_shadow_ps30",
      poly4_outerglow = "mgfx_poly4_outerglow_ps30",
      poly4_blur = "mgfx_backdrop_sample_ps30",
      poly5_stroke = "mgfx_poly5_stroke_ps30",
      poly5 = "mgfx_poly5_ps30",
      poly5_shadow = "mgfx_poly5_shadow_ps30",
      poly5_outerglow = "mgfx_poly5_outerglow_ps30",
      poly5_blur = "mgfx_backdrop_sample_ps30",
      poly6_stroke = "mgfx_poly6_stroke_ps30",
      poly6 = "mgfx_poly6_ps30",
      poly6_shadow = "mgfx_poly6_shadow_ps30",
      poly6_outerglow = "mgfx_poly6_outerglow_ps30",
      poly6_blur = "mgfx_backdrop_sample_ps30",
      poly7_stroke = "mgfx_poly7_stroke_ps30",
      poly7 = "mgfx_poly7_ps30",
      poly7_shadow = "mgfx_poly7_shadow_ps30",
      poly7_outerglow = "mgfx_poly7_outerglow_ps30",
      poly7_blur = "mgfx_backdrop_sample_ps30",
      poly8_stroke = "mgfx_poly8_stroke_ps30",
      poly8 = "mgfx_poly8_ps30",
      poly8_shadow = "mgfx_poly8_shadow_ps30",
      poly8_outerglow = "mgfx_poly8_outerglow_ps30",
      poly8_blur = "mgfx_backdrop_sample_ps30",
    }
    shaderPack = function()
      return shaderpack.current()
    end
    matOK = function(material)
      return material ~= nil and material.IsError ~= nil and not material:IsError()
    end
    shaderName = function(version, name)
      if version ~= "" then
        return version .. "_" .. name
      else
        return name
      end
    end
    mountShaderPack = function(version)
      local pack = shaderPack()
      if version == "" or pack.GMA == nil or pack.GMA == "" or utilBase64Decode == nil or fileWrite == nil or gameMountGMA == nil then
        return nil
      end
      local mountName = "mgfx_shaders_" .. version .. ".gma"
      local decoded = utilBase64Decode(pack.GMA)
      if decoded ~= nil and decoded ~= "" then
        fileWrite(mountName, decoded)
        printFn("Mounting MGFX GMA: " .. toString(gameMountGMA("data/" .. mountName)))
        printFn("GMA Version: " .. version)
        return mountName
      end
      return nil
    end
    blurTargets = function(version)
      if getRenderTargetEx == nil or bitBor == nil then
        return nil, nil, nil
      end
      local flags = bitBor(2, 256, 4, 8)
      local namespace
      do
        local __lux_tmp_13
        if version ~= "" then
          __lux_tmp_13 = version
        else
          __lux_tmp_13 = "dev"
        end
        namespace = "MGFXBlur" .. __lux_tmp_13 .. sysTime()
      end
      local source = getRenderTargetEx(
        namespace .. "_source",
        -1,
        -1,
        RT_SIZE_FULL_FRAME_BUFFER,
        MATERIAL_RT_DEPTH_NONE,
        flags,
        0,
        IMAGE_FORMAT_BGRA8888
      )
      local horizontal = getRenderTargetEx(
        namespace .. "_horizontal",
        -1,
        -1,
        RT_SIZE_FULL_FRAME_BUFFER,
        MATERIAL_RT_DEPTH_NONE,
        flags,
        0,
        IMAGE_FORMAT_BGRA8888
      )
      local final = getRenderTargetEx(
        namespace .. "_final",
        -1,
        -1,
        RT_SIZE_FULL_FRAME_BUFFER,
        MATERIAL_RT_DEPTH_NONE,
        flags,
        0,
        IMAGE_FORMAT_BGRA8888
      )
      return source, horizontal, final
    end
    screenMaterialFactory = function(version)
      return function(name, pixshader, values)
        if createMaterial == nil then
          return nil
        end
        local kv
        if utilKeyValuesToTable ~= nil then
          kv = utilKeyValuesToTable(shaderKV, false, true)
        else
          kv = {}
        end
        kv["$pixshader"] = shaderName(version, pixshader)
        kv["$vertexshader"] = shaderName(version, "mgfx_vs30")
        if values ~= nil then
          for key, value in pairs(values) do
            kv[key] = value
          end
        end
        return createMaterial("mgfx_" .. name .. "_" .. sysTime(), "screenspace_general", kv)
      end
    end
    textureValues = function(texture)
      local textureName
      if texture ~= nil and texture.GetName ~= nil then
        textureName = texture:GetName()
      else
        textureName = ""
      end
      return { ["$basetexture"] = textureName, ["$texture1"] = "_rt_FullFrameFB" }
    end
    materialValues = function(key, blurRT, horizontalRT, finalRT)
      if key == "shape_clip" then
        return {
          ["$texture1"] = "color/white",
          ["$texture2"] = "color/white",
          ["$texture3"] = "color/white",
        }
      end
      if key == "backdrop_blur_horizontal" then
        return textureValues(blurRT)
      end
      if key == "backdrop_blur_vertical" then
        return textureValues(horizontalRT)
      end
      if key == "roundrect_blur" or key == "image_mask_backdrop" or key == "chamfer_backdrop" or key == "ring_backdrop" or key == "poly3_blur" or key == "poly4_blur" or key == "poly5_blur" or key == "poly6_blur" or key == "poly7_blur" or key == "poly8_blur" then
        local textureName
        if finalRT ~= nil and finalRT.GetName ~= nil then
          textureName = finalRT:GetName()
        else
          textureName = ""
        end
        return { ["$basetexture"] = textureName, ["$texture1"] = "_rt_FullFrameFB" }
      end
      if key == "text_face" or key == "text_compose" then
        return { ["$linearread_basetexture"] = 0 }
      end
      return nil
    end
  end
  do
    create = function(owner)
      local pack = shaderPack()
      local version = pack.Version
      if version == nil then
        version = ""
      end
      local mountName = mountShaderPack(version)
      local blurRT, backdropBlurHorizontalRT, backdropBlurRT = blurTargets(version)
      local materials = {}
      local createScreenMaterial = screenMaterialFactory(version)
      for _, key in ipairs(materialKeys) do
        local pixshader = shaderNames[key]
        if pixshader ~= nil then
          materials[key] = createScreenMaterial(
            key,
            pixshader,
            materialValues(key, blurRT, backdropBlurHorizontalRT, backdropBlurRT)
          )
        end
      end
      local state = {
        shaderVersion = version,
        shaderMountName = mountName,
        materials = materials,
        blurRT = blurRT,
        backdropBlurHorizontalRT = backdropBlurHorizontalRT,
        backdropBlurRT = backdropBlurRT,
        matOK = matOK,
        shaderName = function(name)
          return shaderName(version, name)
        end,
      }
      state.CreatePageTextMaterials = function(rt)
        local key
        if rt ~= nil and rt.GetName ~= nil then
          key = rt:GetName()
        else
          key = toString(rt)
        end
        return {
          compose = createScreenMaterial(
            "text_compose_pg_" .. key,
            "mgfx_text_compose_ps30",
            { ["$linearread_basetexture"] = 0, ["$basetexture"] = key }
          ),
          face = createScreenMaterial(
            "text_face_pg_" .. key,
            "mgfx_text_face_ps30",
            { ["$linearread_basetexture"] = 0, ["$basetexture"] = key }
          ),
        }
      end
      return state
    end
  end
  do
    hasShaders = function(state)
      if systemIsWindows() and renderGetDXLevel ~= nil then
        local dxLevel = renderGetDXLevel()
        if dxLevel ~= nil and dxLevel < 90 then
          return false
        end
      end
      return state ~= nil and state.shaderVersion ~= "" and matOK(state.materials.roundrect)
    end
    shaderStatus = function(state)
      local materials
      do
        local __lux_obj_state_14 = state
        local __lux_val_materials_15 = nil
        if __lux_obj_state_14 ~= nil then
          __lux_val_materials_15 = __lux_obj_state_14.materials
        end
        materials = __lux_val_materials_15
        if materials == nil then
          materials = {}
        end
      end
      local __lux_obj_state_16 = state
      local __lux_tmp_shaderVersion_17 = nil
      if __lux_obj_state_16 ~= nil then
        __lux_tmp_shaderVersion_17 = __lux_obj_state_16.shaderVersion
      end
      if __lux_tmp_shaderVersion_17 == nil then
        __lux_tmp_shaderVersion_17 = ""
      end
      local __lux_obj_state_18 = state
      local __lux_tmp_shaderMountName_19 = nil
      if __lux_obj_state_18 ~= nil then
        __lux_tmp_shaderMountName_19 = __lux_obj_state_18.shaderMountName
      end
      if __lux_tmp_shaderMountName_19 == nil then
        __lux_tmp_shaderMountName_19 = "external/custom"
      end
      return {
        loaded = hasShaders(state),
        version = __lux_tmp_shaderVersion_17,
        mount = __lux_tmp_shaderMountName_19,
        roundrect = materials.roundrect,
        roundrectFx = materials.roundrect_fx,
        roundrectFused = materials.roundrect_fused,
        roundrectSolid = materials.roundrect_solid,
        roundrectStroke = materials.roundrect_stroke,
        paramProbe = materials.param_probe,
        paramProbeInv = materials.param_probe_inv,
        chamfer = materials.chamfer,
        blur = materials.roundrect_blur,
        backdropBlurHorizontal = materials.backdrop_blur_horizontal,
        backdropBlurVertical = materials.backdrop_blur_vertical,
        image = materials.roundrect_texture,
        chamferImage = materials.chamfer_texture,
        imageMask = materials.image_mask,
        shapeClip = materials.shape_clip,
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
  end
  do
    textureFallbackMaterial = function(texture)
      if texture == nil then
        return nil
      end
      if makeMaterial ~= nil and typeOf(texture) == "string" then
        return makeMaterial(texture, "smooth")
      end
      return texture
    end
  end
  do
    install = function(owner)
      local state = create(owner)
      owner._MaterialState = state
      owner._Materials = state.materials
      owner._BlurRT = state.blurRT
      owner._BackdropBlurHorizontalRT = state.backdropBlurHorizontalRT
      owner._BackdropBlurRT = state.backdropBlurRT
      owner.MaterialOK = matOK
      owner.GetMaterialState = function()
        return state
      end
      owner.hasShaders = function()
        return hasShaders(state)
      end
      owner.shaderStatus = function()
        return shaderStatus(state)
      end
      owner.TextureFallbackMaterial = textureFallbackMaterial
      return owner
    end
  end

  __lux_exports.matOK = matOK
  __lux_exports.create = create
  __lux_exports.hasShaders = hasShaders
  __lux_exports.shaderStatus = shaderStatus
  __lux_exports.textureFallbackMaterial = textureFallbackMaterial
  __lux_exports.install = install

  return __lux_exports
end
