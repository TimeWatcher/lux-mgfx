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
  local blurTarget
  local screenMaterialFactory
  local materialValues
  local create
  local hasShaders
  local shaderStatus
  local textureFallbackMaterial
  local install
  do
    local __lux_import_1 = __lux_import("lux/mgfx/shaderpack#client")
    local shaderpackImport = __lux_import_1
    shaderpack = shaderpackImport
    do
      local __lux_obj_2 = bit
      local __lux_val_3 = nil
      if __lux_obj_2 ~= nil then
        __lux_val_3 = __lux_obj_2.bor
      end
      bitBor = __lux_val_3
    end
    createMaterial = CreateMaterial
    do
      local __lux_obj_4 = file
      local __lux_val_5 = nil
      if __lux_obj_4 ~= nil then
        __lux_val_5 = __lux_obj_4.Write
      end
      fileWrite = __lux_val_5
    end
    do
      local __lux_obj_6 = game
      local __lux_val_7 = nil
      if __lux_obj_6 ~= nil then
        __lux_val_7 = __lux_obj_6.MountGMA
      end
      gameMountGMA = __lux_val_7
    end
    getRenderTargetEx = GetRenderTargetEx
    makeMaterial = Material
    printFn = print
    do
      local __lux_obj_8 = render
      local __lux_val_9 = nil
      if __lux_obj_8 ~= nil then
        __lux_val_9 = __lux_obj_8.GetDXLevel
      end
      renderGetDXLevel = __lux_val_9
    end
    sysTime = SysTime
    tableCopy = table.Copy
    toString = tostring
    typeOf = type
    do
      local __lux_obj_10 = util
      local __lux_val_11 = nil
      if __lux_obj_10 ~= nil then
        __lux_val_11 = __lux_obj_10.Base64Decode
      end
      utilBase64Decode = __lux_val_11
    end
    do
      local __lux_obj_12 = util
      local __lux_val_13 = nil
      if __lux_obj_12 ~= nil then
        __lux_val_13 = __lux_obj_12.KeyValuesToTable
      end
      utilKeyValuesToTable = __lux_val_13
    end
    shaderKV = "screenspace_general\n" ..
      "{\n" ..
        "  $pixshader \"\"\n" ..
          "  $vertexshader \"\"\n" ..
            "  $basetexture \"color/white\"\n" ..
              "  $texture1 \"\"\n" ..
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
      "roundrect_solid",
      "roundrect_stroke",
      "roundrect_texture",
      "param_probe",
      "chamfer",
      "chamfer_texture",
      "image_mask",
      "image_mask_outerglow",
      "image_mask_backdrop",
      "chamfer_stroke",
      "roundrect_blur",
      "roundrect_innerglow",
      "chamfer_innerglow",
      "roundrect_outerglow",
      "chamfer_outerglow",
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
      "ring_outerglow",
      "ring_pattern",
      "poly_stroke",
      "poly3",
      "poly3_blur",
      "poly4",
      "poly4_blur",
      "poly5",
      "poly5_blur",
      "poly6",
      "poly6_blur",
      "poly7",
      "poly7_blur",
      "poly8",
      "poly8_blur",
    }
    shaderNames = {
      roundrect = "mgfx_roundrect_ps30",
      roundrect_fx = "mgfx_roundrect_fx_ps30",
      roundrect_solid = "mgfx_roundrect_solid_ps30",
      roundrect_stroke = "mgfx_roundrect_stroke_ps30",
      roundrect_texture = "mgfx_roundrect_texture_ps30",
      param_probe = "mgfx_param_probe_ps30",
      chamfer = "mgfx_chamfer_ps30",
      chamfer_texture = "mgfx_chamfer_texture_ps30",
      image_mask = "mgfx_image_mask_ps30",
      image_mask_outerglow = "mgfx_image_mask_outerglow_ps30",
      image_mask_backdrop = "mgfx_image_mask_backdrop_ps30",
      chamfer_stroke = "mgfx_chamfer_stroke_ps30",
      roundrect_blur = "mgfx_roundrect_blur_ps30",
      roundrect_innerglow = "mgfx_roundrect_innerglow_ps30",
      chamfer_innerglow = "mgfx_chamfer_innerglow_ps30",
      roundrect_outerglow = "mgfx_roundrect_outerglow_ps30",
      chamfer_outerglow = "mgfx_chamfer_outerglow_ps30",
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
      ring_backdrop = "mgfx_ring_backdrop_ps30",
      ring_stroke = "mgfx_ring_stroke_ps30",
      ring_innerglow = "mgfx_ring_innerglow_ps30",
      ring_outerglow = "mgfx_ring_outerglow_ps30",
      ring_pattern = "mgfx_ring_pattern_ps30",
      poly_stroke = "mgfx_poly_stroke_ps30",
      poly3 = "mgfx_poly3_ps30",
      poly3_blur = "mgfx_poly3_blur_ps30",
      poly4 = "mgfx_poly4_ps30",
      poly4_blur = "mgfx_poly4_blur_ps30",
      poly5 = "mgfx_poly5_ps30",
      poly5_blur = "mgfx_poly5_blur_ps30",
      poly6 = "mgfx_poly6_ps30",
      poly6_blur = "mgfx_poly6_blur_ps30",
      poly7 = "mgfx_poly7_ps30",
      poly7_blur = "mgfx_poly7_blur_ps30",
      poly8 = "mgfx_poly8_ps30",
      poly8_blur = "mgfx_poly8_blur_ps30",
    }
    shaderPack = function()
      return shaderpack.current()
    end
    matOK = function(material)
      local __lux_tmp_14 = material ~= nil
      if __lux_tmp_14 then
        __lux_tmp_14 = material.IsError ~= nil
      end
      local __lux_tmp_15 = __lux_tmp_14
      if __lux_tmp_15 then
        __lux_tmp_15 = not material:IsError()
      end
      return __lux_tmp_15
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
      local __lux_tmp_16 = version == ""
      if not __lux_tmp_16 then
        __lux_tmp_16 = pack.GMA == nil
      end
      local __lux_tmp_17 = __lux_tmp_16
      if not __lux_tmp_17 then
        __lux_tmp_17 = pack.GMA == ""
      end
      local __lux_tmp_18 = __lux_tmp_17
      if not __lux_tmp_18 then
        __lux_tmp_18 = utilBase64Decode == nil
      end
      local __lux_tmp_19 = __lux_tmp_18
      if not __lux_tmp_19 then
        __lux_tmp_19 = fileWrite == nil
      end
      local __lux_tmp_20 = __lux_tmp_19
      if not __lux_tmp_20 then
        __lux_tmp_20 = gameMountGMA == nil
      end
      if __lux_tmp_20 then
        return nil
      end
      local mountName = "mgfx_shaders_" .. version .. ".gma"
      local decoded = utilBase64Decode(pack.GMA)
      local __lux_tmp_21 = decoded ~= nil
      if __lux_tmp_21 then
        __lux_tmp_21 = decoded ~= ""
      end
      if __lux_tmp_21 then
        fileWrite(mountName, decoded)
        printFn("Mounting MGFX GMA: " .. toString(gameMountGMA("data/" .. mountName)))
        printFn("GMA Version: " .. version)
        return mountName
      end
      return nil
    end
    blurTarget = function(version)
      local __lux_tmp_22 = getRenderTargetEx == nil
      if not __lux_tmp_22 then
        __lux_tmp_22 = bitBor == nil
      end
      if __lux_tmp_22 then
        return nil
      end
      local __lux_tmp_23
      if version ~= "" then
        __lux_tmp_23 = version
      else
        __lux_tmp_23 = "dev"
      end
      return getRenderTargetEx(
        "MGFXBlur" .. __lux_tmp_23 .. sysTime(),
        1024,
        1024,
        RT_SIZE_LITERAL,
        MATERIAL_RT_DEPTH_SEPARATE,
        bitBor(2, 256, 4, 8),
        0,
        IMAGE_FORMAT_BGRA8888
      )
    end
    screenMaterialFactory = function(version, blurRT)
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
    materialValues = function(key, blurRT)
      local __lux_tmp_24 = key == "roundrect_blur"
      if not __lux_tmp_24 then
        __lux_tmp_24 = key == "image_mask_backdrop"
      end
      local __lux_tmp_25 = __lux_tmp_24
      if not __lux_tmp_25 then
        __lux_tmp_25 = key == "ring_backdrop"
      end
      local __lux_tmp_26 = __lux_tmp_25
      if not __lux_tmp_26 then
        __lux_tmp_26 = key == "poly3_blur"
      end
      local __lux_tmp_27 = __lux_tmp_26
      if not __lux_tmp_27 then
        __lux_tmp_27 = key == "poly4_blur"
      end
      local __lux_tmp_28 = __lux_tmp_27
      if not __lux_tmp_28 then
        __lux_tmp_28 = key == "poly5_blur"
      end
      local __lux_tmp_29 = __lux_tmp_28
      if not __lux_tmp_29 then
        __lux_tmp_29 = key == "poly6_blur"
      end
      local __lux_tmp_30 = __lux_tmp_29
      if not __lux_tmp_30 then
        __lux_tmp_30 = key == "poly7_blur"
      end
      local __lux_tmp_31 = __lux_tmp_30
      if not __lux_tmp_31 then
        __lux_tmp_31 = key == "poly8_blur"
      end
      if __lux_tmp_31 then
        local textureName
        do
          local __lux_tmp_32 = blurRT ~= nil
          if __lux_tmp_32 then
            __lux_tmp_32 = blurRT.GetName ~= nil
          end
          if __lux_tmp_32 then
            textureName = blurRT:GetName()
          else
            textureName = ""
          end
        end
        return { ["$basetexture"] = textureName, ["$texture1"] = "_rt_FullFrameFB" }
      end
      local __lux_tmp_33 = key == "text_face"
      if not __lux_tmp_33 then
        __lux_tmp_33 = key == "text_compose"
      end
      if __lux_tmp_33 then
        return { ["$linearread_basetexture"] = 0 }
      end
      return nil
    end
  end
  do
    create = function(owner)
      local pack = shaderPack()
      local version
      do
        local __lux_tmp_34 = pack.Version
        if __lux_tmp_34 == nil then
          __lux_tmp_34 = ""
        end
        version = __lux_tmp_34
      end
      local mountName = mountShaderPack(version)
      local blurRT = blurTarget(version)
      local materials = {}
      local createScreenMaterial = screenMaterialFactory(version, blurRT)
      for _, key in ipairs(materialKeys) do
        local pixshader = shaderNames[key]
        if pixshader ~= nil then
          materials[key] = createScreenMaterial(key, pixshader, materialValues(key, blurRT))
        end
      end
      local state = {
        shaderVersion = version,
        shaderMountName = mountName,
        materials = materials,
        blurRT = blurRT,
        matOK = matOK,
        shaderName = function(name)
          return shaderName(version, name)
        end,
      }
      state.CreatePageTextMaterials = function(rt)
        local key
        do
          local __lux_tmp_35 = rt ~= nil
          if __lux_tmp_35 then
            __lux_tmp_35 = rt.GetName ~= nil
          end
          if __lux_tmp_35 then
            key = rt:GetName()
          else
            key = toString(rt)
          end
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
      if renderGetDXLevel ~= nil then
        local dxLevel = renderGetDXLevel()
        local __lux_tmp_36 = dxLevel ~= nil
        if __lux_tmp_36 then
          __lux_tmp_36 = dxLevel < 90
        end
        if __lux_tmp_36 then
          return false
        end
      end
      local __lux_tmp_37 = state ~= nil
      if __lux_tmp_37 then
        __lux_tmp_37 = state.shaderVersion ~= ""
      end
      local __lux_tmp_38 = __lux_tmp_37
      if __lux_tmp_38 then
        __lux_tmp_38 = matOK(state.materials.roundrect)
      end
      return __lux_tmp_38
    end
    shaderStatus = function(state)
      local materials
      do
        local __lux_obj_39 = state
        local __lux_val_40 = nil
        if __lux_obj_39 ~= nil then
          __lux_val_40 = __lux_obj_39.materials
        end
        local __lux_tmp_41 = __lux_val_40
        if __lux_tmp_41 == nil then
          __lux_tmp_41 = {}
        end
        materials = __lux_tmp_41
      end
      local __lux_obj_42 = state
      local __lux_val_43 = nil
      if __lux_obj_42 ~= nil then
        __lux_val_43 = __lux_obj_42.shaderVersion
      end
      local __lux_tmp_44 = __lux_val_43
      if __lux_tmp_44 == nil then
        __lux_tmp_44 = ""
      end
      local __lux_obj_45 = state
      local __lux_val_46 = nil
      if __lux_obj_45 ~= nil then
        __lux_val_46 = __lux_obj_45.shaderMountName
      end
      local __lux_tmp_47 = __lux_val_46
      if __lux_tmp_47 == nil then
        __lux_tmp_47 = "external/custom"
      end
      return {
        loaded = hasShaders(state),
        version = __lux_tmp_44,
        mount = __lux_tmp_47,
        roundrect = materials.roundrect,
        roundrectFx = materials.roundrect_fx,
        roundrectSolid = materials.roundrect_solid,
        roundrectStroke = materials.roundrect_stroke,
        paramProbe = materials.param_probe,
        chamfer = materials.chamfer,
        blur = materials.roundrect_blur,
        image = materials.roundrect_texture,
        chamferImage = materials.chamfer_texture,
        imageMask = materials.image_mask,
        imageMaskOuterGlow = materials.image_mask_outerglow,
        imageMaskBackdrop = materials.image_mask_backdrop,
        chamferStroke = materials.chamfer_stroke,
        innerGlow = materials.roundrect_innerglow,
        chamferInnerGlow = materials.chamfer_innerglow,
        outerGlow = materials.roundrect_outerglow,
        chamferOuterGlow = materials.chamfer_outerglow,
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
        ringOuterGlow = materials.ring_outerglow,
        ringPattern = materials.ring_pattern,
        polyStroke = materials.poly_stroke,
        poly3 = materials.poly3,
        poly3Blur = materials.poly3_blur,
        poly4 = materials.poly4,
        poly4Blur = materials.poly4_blur,
        poly5 = materials.poly5,
        poly5Blur = materials.poly5_blur,
        poly6 = materials.poly6,
        poly6Blur = materials.poly6_blur,
        poly7 = materials.poly7,
        poly7Blur = materials.poly7_blur,
        poly8 = materials.poly8,
        poly8Blur = materials.poly8_blur,
      }
    end
  end
  do
    textureFallbackMaterial = function(texture)
      if texture == nil then
        return nil
      end
      local __lux_tmp_48 = makeMaterial ~= nil
      if __lux_tmp_48 then
        __lux_tmp_48 = typeOf(texture) == "string"
      end
      if __lux_tmp_48 then
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
