return function(__lux_import)
  local __lux_exports = {}
  local materialsPkg
  local concommandAdd
  local concommandRemove
  local createClientConVar
  local getConVar
  local hookAdd
  local hookRemove
  local makeColor
  local mathClamp
  local mathFloor
  local mathMax
  local mathMin
  local matrixCtor
  local printFn
  local realTime
  local runConsoleCommand
  local stringFormat
  local stringSub
  local drawSimpleText
  local globalTable
  local surfaceCreateFont
  local surfaceDrawOutlinedRect
  local surfaceDrawRect
  local surfaceDrawTexturedRectUV
  local surfaceSetDrawColor
  local surfaceSetMaterial
  local sysTime
  local tableConcat
  local tableSort
  local timerCreate
  local timerRemove
  local toNumber
  local toString
  local typeOf
  local commandNames
  local textDemoEnabled
  local textStressEnabled
  local atlasDebugEnabled
  local profileHudEnabled
  local paramProbeEnabled
  local paramProbeInvEnabled
  local textDemoFontsReady
  local paramProbeMatrix
  local paramProbeSetUnpacked
  local paramProbeInvMatrix
  local paramProbeInvSetUnpacked
  local paramBenchMatrix
  local paramBenchSetUnpacked
  local paramBenchTimer
  local profileHudHook
  local profileHudX
  local profileHudY
  local profileHudRows
  local profileHudTopRows
  local textDemoFx
  local requiredMaterialKeys
  local requiredApis
  local requiredTargets
  local isFunction
  local convarBool
  local ownerStats
  local addCommand
  local rawAddCommand
  local removeCommand
  local countsLine
  local shaderStatus
  local profilerApi
  local profilerRegistry
  local collectProfilerRows
  local profilerInstanceCount
  local formatProfiler
  local resetAllProfilers
  local textStatus
  local textRendererStatus
  local statusMaterialFields
  local printMaterialStatus
  local status
  local printProfileRows
  local printProfileScopes
  local rowTopParts
  local printProfileInstanceRows
  local profileStatus
  local profilePanels
  local profileCurrent
  local hudText
  local shortHotspotName
  local drawHotspotTable
  local drawProfileHud
  local setProfileHud
  local toggleProfileHud
  local profileReset
  local textStatusCommand
  local textCacheClear
  local textComposedClear
  local TEXT_DEMO_CJK_FACE
  local textDemoStrings
  local ensureTextDemoFonts
  local drawTextDemo
  local toggleTextDemo
  local traceTextDemo
  local toggleAtlasDebug
  local toggleTextStress
  local writeParamProbeMatrix
  local setupParamProbeMatrix
  local setupNamedParamProbeMatrix
  local drawParamProbeBlock
  local drawParamProbe
  local toggleParamProbe
  local drawNamedParamProbeBlock
  local drawParamProbeInv
  local toggleParamProbeInv
  local printBenchResult
  local runParamBenchSlice
  local stopParamBench
  local runParamBench
  local selftest
  local reloadMGFX
  local install
  local uninstall
  do
    local materialsPkgImport = __lux_import("lux/mgfx/materials#client")
    materialsPkg = materialsPkgImport
    do
      local __lux_obj_concommand_1 = concommand
      local __lux_val_Add_2 = nil
      if __lux_obj_concommand_1 ~= nil then
        __lux_val_Add_2 = __lux_obj_concommand_1.Add
      end
      concommandAdd = __lux_val_Add_2
    end
    do
      local __lux_obj_concommand_3 = concommand
      local __lux_val_Remove_4 = nil
      if __lux_obj_concommand_3 ~= nil then
        __lux_val_Remove_4 = __lux_obj_concommand_3.Remove
      end
      concommandRemove = __lux_val_Remove_4
    end
    createClientConVar = CreateClientConVar
    getConVar = GetConVar
    do
      local __lux_obj_hook_5 = hook
      local __lux_val_Add_6 = nil
      if __lux_obj_hook_5 ~= nil then
        __lux_val_Add_6 = __lux_obj_hook_5.Add
      end
      hookAdd = __lux_val_Add_6
    end
    do
      local __lux_obj_hook_7 = hook
      local __lux_val_Remove_8 = nil
      if __lux_obj_hook_7 ~= nil then
        __lux_val_Remove_8 = __lux_obj_hook_7.Remove
      end
      hookRemove = __lux_val_Remove_8
    end
    makeColor = Color
    mathClamp = math.Clamp
    mathFloor = math.floor
    mathMax = math.max
    mathMin = math.min
    matrixCtor = Matrix
    printFn = print
    realTime = RealTime
    runConsoleCommand = RunConsoleCommand
    stringFormat = string.format
    stringSub = string.sub
    drawSimpleText = _G.draw.SimpleText
    globalTable = _G
    do
      local __lux_obj_surface_9 = surface
      local __lux_val_CreateFont_10 = nil
      if __lux_obj_surface_9 ~= nil then
        __lux_val_CreateFont_10 = __lux_obj_surface_9.CreateFont
      end
      surfaceCreateFont = __lux_val_CreateFont_10
    end
    do
      local __lux_obj_surface_11 = surface
      local __lux_val_DrawOutlinedRect_12 = nil
      if __lux_obj_surface_11 ~= nil then
        __lux_val_DrawOutlinedRect_12 = __lux_obj_surface_11.DrawOutlinedRect
      end
      surfaceDrawOutlinedRect = __lux_val_DrawOutlinedRect_12
    end
    do
      local __lux_obj_surface_13 = surface
      local __lux_val_DrawRect_14 = nil
      if __lux_obj_surface_13 ~= nil then
        __lux_val_DrawRect_14 = __lux_obj_surface_13.DrawRect
      end
      surfaceDrawRect = __lux_val_DrawRect_14
    end
    do
      local __lux_obj_surface_15 = surface
      local __lux_val_DrawTexturedRectUV_16 = nil
      if __lux_obj_surface_15 ~= nil then
        __lux_val_DrawTexturedRectUV_16 = __lux_obj_surface_15.DrawTexturedRectUV
      end
      surfaceDrawTexturedRectUV = __lux_val_DrawTexturedRectUV_16
    end
    do
      local __lux_obj_surface_17 = surface
      local __lux_val_SetDrawColor_18 = nil
      if __lux_obj_surface_17 ~= nil then
        __lux_val_SetDrawColor_18 = __lux_obj_surface_17.SetDrawColor
      end
      surfaceSetDrawColor = __lux_val_SetDrawColor_18
    end
    do
      local __lux_obj_surface_19 = surface
      local __lux_val_SetMaterial_20 = nil
      if __lux_obj_surface_19 ~= nil then
        __lux_val_SetMaterial_20 = __lux_obj_surface_19.SetMaterial
      end
      surfaceSetMaterial = __lux_val_SetMaterial_20
    end
    sysTime = SysTime
    tableConcat = table.concat
    tableSort = table.sort
    do
      local __lux_obj_timer_21 = timer
      local __lux_val_Create_22 = nil
      if __lux_obj_timer_21 ~= nil then
        __lux_val_Create_22 = __lux_obj_timer_21.Create
      end
      timerCreate = __lux_val_Create_22
    end
    do
      local __lux_obj_timer_23 = timer
      local __lux_val_Remove_24 = nil
      if __lux_obj_timer_23 ~= nil then
        __lux_val_Remove_24 = __lux_obj_timer_23.Remove
      end
      timerRemove = __lux_val_Remove_24
    end
    toNumber = tonumber
    toString = tostring
    typeOf = type
    commandNames = {}
    textDemoEnabled = false
    textStressEnabled = false
    atlasDebugEnabled = false
    profileHudEnabled = false
    paramProbeEnabled = false
    paramProbeInvEnabled = false
    textDemoFontsReady = false
    do
      local __lux_tmp_25
      if matrixCtor ~= nil then
        __lux_tmp_25 = matrixCtor()
      else
        __lux_tmp_25 = nil
      end
      paramProbeMatrix = __lux_tmp_25
    end
    do
      local __lux_obj_paramProbeMatrix_26 = paramProbeMatrix
      local __lux_val_SetUnpacked_27 = nil
      if __lux_obj_paramProbeMatrix_26 ~= nil then
        __lux_val_SetUnpacked_27 = __lux_obj_paramProbeMatrix_26.SetUnpacked
      end
      paramProbeSetUnpacked = __lux_val_SetUnpacked_27
    end
    do
      local __lux_tmp_28
      if matrixCtor ~= nil then
        __lux_tmp_28 = matrixCtor()
      else
        __lux_tmp_28 = nil
      end
      paramProbeInvMatrix = __lux_tmp_28
    end
    do
      local __lux_obj_paramProbeInvMatrix_29 = paramProbeInvMatrix
      local __lux_val_SetUnpacked_30 = nil
      if __lux_obj_paramProbeInvMatrix_29 ~= nil then
        __lux_val_SetUnpacked_30 = __lux_obj_paramProbeInvMatrix_29.SetUnpacked
      end
      paramProbeInvSetUnpacked = __lux_val_SetUnpacked_30
    end
    do
      local __lux_tmp_31
      if matrixCtor ~= nil then
        __lux_tmp_31 = matrixCtor()
      else
        __lux_tmp_31 = nil
      end
      paramBenchMatrix = __lux_tmp_31
    end
    do
      local __lux_obj_paramBenchMatrix_32 = paramBenchMatrix
      local __lux_val_SetUnpacked_33 = nil
      if __lux_obj_paramBenchMatrix_32 ~= nil then
        __lux_val_SetUnpacked_33 = __lux_obj_paramBenchMatrix_32.SetUnpacked
      end
      paramBenchSetUnpacked = __lux_val_SetUnpacked_33
    end
    paramBenchTimer = "MGFXParamBench"
    profileHudHook = "MGFXProfileHUD"
    profileHudX = 24
    profileHudY = 360
    profileHudRows = 4
    profileHudTopRows = 6
    do
      local __lux_tmp_34
      if createClientConVar ~= nil then
        __lux_tmp_34 = createClientConVar(
          "mgfx_text_demo_fx",
          "1",
          true,
          false,
          "MGFX text demo effect intensity."
        )
      else
        __lux_tmp_34 = nil
      end
      textDemoFx = __lux_tmp_34
    end
    requiredMaterialKeys = {
      "roundrect",
      "roundrect_fx",
      "roundrect_solid",
      "roundrect_stroke",
      "roundrect_texture",
      "param_probe",
      "param_probe_inv",
      "chamfer",
      "chamfer_texture",
      "image_mask",
      "image_mask_shadow_outer",
      "image_mask_backdrop",
      "chamfer_stroke",
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
    requiredApis = {
      "StartPanel",
      "EndPanel",
      "StartScreen",
      "EndScreen",
      "PushClip",
      "PopClip",
      "RoundedBox",
      "RoundedBoxEx",
      "ChamferBox",
      "ChamferBoxEx",
      "Poly",
      "PolyEx",
      "Line",
      "LineEx",
      "Circle",
      "CircleEx",
      "Capsule",
      "CapsuleEx",
      "Image",
      "ImageEx",
      "Icon",
      "IconEx",
      "Text",
      "TextEx",
      "TextBox",
      "TextBoxEx",
      "MeasureText",
      "MeasureTextBox",
      "DefineTextStyle",
      "GetTextStyle",
      "ResolveTextStyle",
      "RegisterTextFont",
      "PrewarmText",
      "GetCapabilities",
      "Supports",
      "Transform",
      "ProjectedQuad",
      "PointerTilt",
      "PushTransform",
      "PopTransform",
      "TransformPoint",
      "UntransformPoint",
      "ProgressBar",
      "ProgressBarEx",
      "SegmentBar",
      "SegmentBarEx",
      "Ring",
      "RingEx",
      "Arc",
      "ArcEx",
      "Sector",
      "SectorEx",
      "Solid",
      "LinearGradient",
      "LinearGradientStops",
      "RadialGradient",
      "RingRadialGradient",
      "SectorRadialGradient",
      "ConicGradient",
      "ShapeAngularGradient",
      "RingAngularGradient",
      "ArcAngularGradient",
      "SectorAngularGradient",
      "StripePattern",
      "SmokePattern",
      "Mask",
      "DebugOverlay",
    }
    requiredTargets = {
      "ROUNDED_BOX",
      "CHAMFER_BOX",
      "POLY",
      "LINE",
      "CIRCLE",
      "CAPSULE",
      "IMAGE",
      "PROGRESS_BAR",
      "SEGMENT_BAR",
      "RING",
      "ARC",
      "SECTOR",
      "TEXT",
    }
  end
  do
    isFunction = function(value)
      return typeOf(value) == "function"
    end
    convarBool = function(name, fallback)
      if fallback == nil then
        fallback = false
      end
      local cvar
      if getConVar ~= nil then
        cvar = getConVar(name)
      else
        cvar = nil
      end
      if cvar ~= nil and cvar.GetBool ~= nil then
        return cvar:GetBool()
      end
      return fallback
    end
    ownerStats = function(owner)
      do
        local __lux_tmp_stats_35 = owner.stats
        if __lux_tmp_stats_35 == nil then
          __lux_tmp_stats_35 = {}
        end
        owner.stats = __lux_tmp_stats_35
      end
      do
        local __lux_tmp_drawCommandCounts_36 = owner.stats.drawCommandCounts
        if __lux_tmp_drawCommandCounts_36 == nil then
          __lux_tmp_drawCommandCounts_36 = {}
        end
        owner.stats.drawCommandCounts = __lux_tmp_drawCommandCounts_36
      end
      do
        local __lux_tmp_drawImmediateCounts_37 = owner.stats.drawImmediateCounts
        if __lux_tmp_drawImmediateCounts_37 == nil then
          __lux_tmp_drawImmediateCounts_37 = {}
        end
        owner.stats.drawImmediateCounts = __lux_tmp_drawImmediateCounts_37
      end
      do
        local __lux_tmp_profileTimes_38 = owner.stats.profileTimes
        if __lux_tmp_profileTimes_38 == nil then
          __lux_tmp_profileTimes_38 = {}
        end
        owner.stats.profileTimes = __lux_tmp_profileTimes_38
      end
      do
        local __lux_tmp_profileCounts_39 = owner.stats.profileCounts
        if __lux_tmp_profileCounts_39 == nil then
          __lux_tmp_profileCounts_39 = {}
        end
        owner.stats.profileCounts = __lux_tmp_profileCounts_39
      end
      return owner.stats
    end
    addCommand = function(owner, name, callback, helpText)
      local add
      do
        local __lux_obj_owner_40 = owner
        local __lux_val_AddCommand_41 = nil
        if __lux_obj_owner_40 ~= nil then
          __lux_val_AddCommand_41 = __lux_obj_owner_40._AddCommand
        end
        add = __lux_val_AddCommand_41
        if add == nil then
          add = concommandAdd
        end
      end
      if add == nil then
        return false
      end
      add(name, callback, nil, helpText)
      commandNames[#commandNames + 1] = name
      return true
    end
    rawAddCommand = function(name, callback, autocomplete, helpText, flags)
      if concommandAdd == nil then
        return false
      end
      if concommandRemove ~= nil and string.sub(name, 1, 5) == "mgfx_" then
        concommandRemove(name)
      end
      concommandAdd(name, callback, autocomplete, helpText, flags)
      return true
    end
    removeCommand = function(name)
      if concommandRemove ~= nil then
        concommandRemove(name)
      end
    end
  end
  do
    countsLine = function(label, counts)
      local parts = {}
      do
        local __lux_tmp_counts_42 = counts
        if __lux_tmp_counts_42 == nil then
          __lux_tmp_counts_42 = {}
        end
        for key, value in pairs(__lux_tmp_counts_42) do
          if value ~= nil and value ~= 0 then
            parts[#parts + 1] = toString(key) .. "=" .. toString(value)
          end
        end
      end
      tableSort(parts)
      local __lux_tmp_43
      if #parts > 0 then
        __lux_tmp_43 = tableConcat(parts, " ")
      else
        __lux_tmp_43 = "none"
      end
      return printFn("[MGFX] " .. label .. ": " .. __lux_tmp_43)
    end
    shaderStatus = function(owner)
      local statusFn
      do
        local __lux_obj_owner_44 = owner
        local __lux_val_shaderStatus_45 = nil
        if __lux_obj_owner_44 ~= nil then
          __lux_val_shaderStatus_45 = __lux_obj_owner_44.shaderStatus
        end
        statusFn = __lux_val_shaderStatus_45
      end
      if statusFn ~= nil then
        return statusFn()
      end
      local __lux_obj_owner_46 = owner
      local __lux_val_MaterialState_47 = nil
      if __lux_obj_owner_46 ~= nil then
        __lux_val_MaterialState_47 = __lux_obj_owner_46._MaterialState
      end
      return materialsPkg.shaderStatus(__lux_val_MaterialState_47)
    end
    profilerApi = function(owner)
      local __lux_obj_owner_48 = owner
      local __lux_val_Profiler_49 = nil
      if __lux_obj_owner_48 ~= nil then
        __lux_val_Profiler_49 = __lux_obj_owner_48.Profiler
      end
      return __lux_val_Profiler_49
    end
    profilerRegistry = function()
      local __lux_obj_MGFX_50 = globalTable.MGFX
      local __lux_val_ProfilerRegistry_51 = nil
      if __lux_obj_MGFX_50 ~= nil then
        __lux_val_ProfilerRegistry_51 = __lux_obj_MGFX_50._ProfilerRegistry
      end
      local __lux_obj_ProfilerRegistry_52 = __lux_val_ProfilerRegistry_51
      local __lux_val_items_53 = nil
      if __lux_obj_ProfilerRegistry_52 ~= nil then
        __lux_val_items_53 = __lux_obj_ProfilerRegistry_52.items
      end
      return __lux_val_items_53
    end
    collectProfilerRows = function(owner, methodName, limit)
      local rows = {}
      local registry = profilerRegistry()
      if registry ~= nil then
        for _, item in pairs(registry) do
          local api
          do
            local __lux_obj_item_54 = item
            local __lux_val_profiler_55 = nil
            if __lux_obj_item_54 ~= nil then
              __lux_val_profiler_55 = __lux_obj_item_54.profiler
            end
            api = __lux_val_profiler_55
          end
          local method
          do
            local __lux_obj_api_56 = api
            local __lux_val_api_58 = nil
            if __lux_obj_api_56 ~= nil then
              local __lux_key_methodName_57 = methodName
              __lux_val_api_58 = __lux_obj_api_56[__lux_key_methodName_57]
            end
            method = __lux_val_api_58
          end
          if method ~= nil then
            local instanceRows = method(limit)
            do
              local __lux_tmp_instanceRows_59 = instanceRows
              if __lux_tmp_instanceRows_59 == nil then
                __lux_tmp_instanceRows_59 = {}
              end
              for index = 1, #__lux_tmp_instanceRows_59 do
                rows[#rows + 1] = instanceRows[index]
              end
            end
          end
        end
      end
      if #rows == 0 then
        local profiler = profilerApi(owner)
        local method
        do
          local __lux_obj_profiler_60 = profiler
          local __lux_val_profiler_62 = nil
          if __lux_obj_profiler_60 ~= nil then
            local __lux_key_methodName_61 = methodName
            __lux_val_profiler_62 = __lux_obj_profiler_60[__lux_key_methodName_61]
          end
          method = __lux_val_profiler_62
        end
        if method ~= nil then
          do
            local __lux_tmp_limit_63 = method(limit)
            if __lux_tmp_limit_63 == nil then
              __lux_tmp_limit_63 = {}
            end
            rows = __lux_tmp_limit_63
          end
        end
      end
      tableSort(
        rows,
        function(a, b)
          local av
          if methodName == "RecentScopes" then
            av = a.last
            if av == nil then
              av = 0
            end
          else
            av = a.avg
            if av == nil then
              av = a.last
              if av == nil then
                av = 0
              end
            end
          end
          local bv
          if methodName == "RecentScopes" then
            bv = b.last
            if bv == nil then
              bv = 0
            end
          else
            bv = b.avg
            if bv == nil then
              bv = b.last
              if bv == nil then
                bv = 0
              end
            end
          end
          if av == bv then
            local __lux_tmp_name_64 = a.name
            if __lux_tmp_name_64 == nil then
              __lux_tmp_name_64 = ""
            end
            local __lux_tmp_name_65 = b.name
            if __lux_tmp_name_65 == nil then
              __lux_tmp_name_65 = ""
            end
            local __lux_cmp_66 = false
            if toString(__lux_tmp_name_64) ~= nil and toString(__lux_tmp_name_65) ~= nil then
              __lux_cmp_66 = toString(__lux_tmp_name_64) < toString(__lux_tmp_name_65)
            end
            return __lux_cmp_66
          end
          return av > bv
        end
      )
      local numericLimit = toNumber(limit)
      if numericLimit ~= nil and numericLimit > 0 then
        while #rows > numericLimit do
          rows[#rows] = nil
        end
      end
      return rows
    end
    profilerInstanceCount = function()
      local registry = profilerRegistry()
      if registry == nil then
        return 0
      end
      local count = 0
      for _, item in pairs(registry) do
        local __lux_obj_item_67 = item
        local __lux_val_profiler_68 = nil
        if __lux_obj_item_67 ~= nil then
          __lux_val_profiler_68 = __lux_obj_item_67.profiler
        end
        if __lux_val_profiler_68 ~= nil then
          count = count + 1
        end
      end
      return count
    end
    formatProfiler = function(owner)
      local direct = profilerApi(owner)
      if direct ~= nil then
        return direct
      end
      local registry = profilerRegistry()
      if registry ~= nil then
        for _, item in pairs(registry) do
          local __lux_obj_item_69 = item
          local __lux_val_profiler_70 = nil
          if __lux_obj_item_69 ~= nil then
            __lux_val_profiler_70 = __lux_obj_item_69.profiler
          end
          if __lux_val_profiler_70 ~= nil then
            return item.profiler
          end
        end
      end
      return nil
    end
    resetAllProfilers = function()
      local registry = profilerRegistry()
      local count = 0
      if registry ~= nil then
        for _, item in pairs(registry) do
          local reset
          do
            local __lux_obj_item_71 = item
            local __lux_val_profiler_72 = nil
            if __lux_obj_item_71 ~= nil then
              __lux_val_profiler_72 = __lux_obj_item_71.profiler
            end
            local __lux_obj_profiler_73 = __lux_val_profiler_72
            local __lux_val_Reset_74 = nil
            if __lux_obj_profiler_73 ~= nil then
              __lux_val_Reset_74 = __lux_obj_profiler_73.Reset
            end
            reset = __lux_val_Reset_74
          end
          if reset ~= nil then
            reset()
            count = count + 1
          end
        end
      end
      return count
    end
    textStatus = function(owner)
      local snapshot = nil
      local snapshotFn
      do
        local __lux_obj_owner_75 = owner
        local __lux_val_GetTextProfileSnapshot_76 = nil
        if __lux_obj_owner_75 ~= nil then
          __lux_val_GetTextProfileSnapshot_76 = __lux_obj_owner_75.GetTextProfileSnapshot
        end
        snapshotFn = __lux_val_GetTextProfileSnapshot_76
      end
      if snapshotFn ~= nil then
        snapshot = snapshotFn(false)
      end
      local __lux_tmp_snapshot_77 = snapshot
      if __lux_tmp_snapshot_77 == nil then
        __lux_tmp_snapshot_77 = {}
      end
      return __lux_tmp_snapshot_77
    end
    textRendererStatus = function(owner)
      local statusFn
      do
        local __lux_obj_owner_78 = owner
        local __lux_val_GetTextRendererStatus_79 = nil
        if __lux_obj_owner_78 ~= nil then
          __lux_val_GetTextRendererStatus_79 = __lux_obj_owner_78.GetTextRendererStatus
        end
        statusFn = __lux_val_GetTextRendererStatus_79
      end
      if statusFn ~= nil then
        return statusFn()
      end
      return {}
    end
    statusMaterialFields = {
      { "roundrect", "roundrect" },
      { "roundrect fx", "roundrectFx" },
      { "roundrect solid", "roundrectSolid" },
      { "roundrect stroke", "roundrectStroke" },
      { "param probe", "paramProbe" },
      { "param probe inv", "paramProbeInv" },
      { "blur", "blur" },
      { "chamfer", "chamfer" },
      { "chamfer image", "chamferImage" },
      { "image mask", "imageMask" },
      { "image mask shadow outer", "imageMaskShadowOuter" },
      { "image mask backdrop", "imageMaskBackdrop" },
      { "chamfer stroke", "chamferStroke" },
      { "inner glow", "innerGlow" },
      { "chamfer inner glow", "chamferInnerGlow" },
      { "shadow outer", "shadowOuter" },
      { "chamfer shadow outer", "chamferShadowOuter" },
      { "chamfer backdrop", "chamferBackdrop" },
      { "progress", "progress" },
      { "progress fx", "progressFx" },
      { "segmentbar", "segmentbar" },
      { "line", "line" },
      { "text compose", "textCompose" },
      { "pattern", "pattern" },
      { "chamfer pattern", "chamferPattern" },
      { "poly pattern", "polyPattern" },
      { "ring", "ring" },
      { "ring fx", "ringFx" },
      { "ring backdrop", "ringBackdrop" },
      { "ring stroke", "ringStroke" },
      { "ring inner glow", "ringInnerGlow" },
      { "ring shadow outer", "ringShadowOuter" },
      { "ring pattern", "ringPattern" },
      { "poly3 stroke", "poly3Stroke" },
      { "poly3", "poly3" },
      { "poly3 shadow", "poly3Shadow" },
      { "poly3 outer glow", "poly3OuterGlow" },
      { "poly3 blur", "poly3Blur" },
      { "poly4 stroke", "poly4Stroke" },
      { "poly4", "poly4" },
      { "poly4 shadow", "poly4Shadow" },
      { "poly4 outer glow", "poly4OuterGlow" },
      { "poly4 blur", "poly4Blur" },
      { "poly5 stroke", "poly5Stroke" },
      { "poly5", "poly5" },
      { "poly5 shadow", "poly5Shadow" },
      { "poly5 outer glow", "poly5OuterGlow" },
      { "poly5 blur", "poly5Blur" },
      { "poly6 stroke", "poly6Stroke" },
      { "poly6", "poly6" },
      { "poly6 shadow", "poly6Shadow" },
      { "poly6 outer glow", "poly6OuterGlow" },
      { "poly6 blur", "poly6Blur" },
      { "poly7 stroke", "poly7Stroke" },
      { "poly7", "poly7" },
      { "poly7 shadow", "poly7Shadow" },
      { "poly7 outer glow", "poly7OuterGlow" },
      { "poly7 blur", "poly7Blur" },
      { "poly8 stroke", "poly8Stroke" },
      { "poly8", "poly8" },
      { "poly8 shadow", "poly8Shadow" },
      { "poly8 outer glow", "poly8OuterGlow" },
      { "poly8 blur", "poly8Blur" },
    }
    printMaterialStatus = function(status)
      for index = 1, #statusMaterialFields do
        local item = statusMaterialFields[index]
        printFn("[MGFX] " .. item[1] .. " material: " .. toString(status[item[2]]))
      end
    end
    status = function(owner)
      local stats = ownerStats(owner)
      local status = shaderStatus(owner)
      local profileCvar
      if getConVar ~= nil then
        profileCvar = getConVar("mgfx_profile")
      else
        profileCvar = nil
      end
      local drawCounts
      if getConVar ~= nil then
        drawCounts = getConVar("mgfx_draw_counts")
      else
        drawCounts = nil
      end
      local fallback
      if getConVar ~= nil then
        fallback = getConVar("mgfx_force_fallback")
      else
        fallback = nil
      end
      do
        local __lux_tmp_80
        if status.loaded then
          __lux_tmp_80 = "loaded"
        else
          __lux_tmp_80 = "fallback"
        end
        printFn("[MGFX] shaders: " .. __lux_tmp_80)
      end
      printFn("[MGFX] version: " .. toString(status.version))
      printFn("[MGFX] mount: " .. toString(status.mount))
      printFn(
        "[MGFX] force fallback: " .. toString(fallback ~= nil and fallback:GetBool() or false)
      )
      printFn(
        "[MGFX] draw counts: " .. toString(drawCounts ~= nil and drawCounts:GetBool() or false)
      )
      do
        local __lux_tmp_draws_81 = stats.draws
        if __lux_tmp_draws_81 == nil then
          __lux_tmp_draws_81 = 0
        end
        local __lux_tmp_blurPasses_82 = stats.blurPasses
        if __lux_tmp_blurPasses_82 == nil then
          __lux_tmp_blurPasses_82 = 0
        end
        local __lux_tmp_fallbacks_83 = stats.fallbacks
        if __lux_tmp_fallbacks_83 == nil then
          __lux_tmp_fallbacks_83 = 0
        end
        local __lux_tmp_culled_84 = stats.culled
        if __lux_tmp_culled_84 == nil then
          __lux_tmp_culled_84 = 0
        end
        printFn(
          "[MGFX] stats draws=" ..
            toString(__lux_tmp_draws_81) ..
              " blur=" ..
                toString(__lux_tmp_blurPasses_82) ..
                  " fallback=" ..
                    toString(__lux_tmp_fallbacks_83) .. " culled=" .. toString(__lux_tmp_culled_84)
        )
      end
      countsLine("draw commands", stats.drawCommandCounts)
      countsLine("immediate draws", stats.drawImmediateCounts)
      countsLine("profile ms", stats.profileTimes)
      local text = textStatus(owner)
      local textRenderer = textRendererStatus(owner)
      do
        local __lux_tmp_draws_85 = textRenderer.draws
        if __lux_tmp_draws_85 == nil then
          __lux_tmp_draws_85 = text.draws
        end
        if __lux_tmp_draws_85 == nil then
          __lux_tmp_draws_85 = stats.textDraws
        end
        if __lux_tmp_draws_85 == nil then
          __lux_tmp_draws_85 = 0
        end
        local __lux_tmp_nativeDraws_86 = textRenderer.nativeDraws
        if __lux_tmp_nativeDraws_86 == nil then
          __lux_tmp_nativeDraws_86 = stats.textNativeDraws
        end
        if __lux_tmp_nativeDraws_86 == nil then
          __lux_tmp_nativeDraws_86 = 0
        end
        local __lux_tmp_composedDraws_87 = textRenderer.composedDraws
        if __lux_tmp_composedDraws_87 == nil then
          __lux_tmp_composedDraws_87 = stats.textComposedDraws
        end
        if __lux_tmp_composedDraws_87 == nil then
          __lux_tmp_composedDraws_87 = 0
        end
        local __lux_tmp_measures_88 = text.measures
        if __lux_tmp_measures_88 == nil then
          __lux_tmp_measures_88 = 0
        end
        printFn(
          "[MGFX] text draws=" ..
            toString(__lux_tmp_draws_85) ..
              " native=" ..
                toString(__lux_tmp_nativeDraws_86) ..
                  " composed=" ..
                    toString(__lux_tmp_composedDraws_87) .. " measures=" .. toString(__lux_tmp_measures_88)
        )
      end
      do
        local __lux_tmp_mode_89 = textRenderer.mode
        if __lux_tmp_mode_89 == nil then
          __lux_tmp_mode_89 = "n/a"
        end
        local __lux_tmp_composedEnabled_90 = textRenderer.composedEnabled
        if __lux_tmp_composedEnabled_90 == nil then
          __lux_tmp_composedEnabled_90 = false
        end
        local __lux_tmp_composedAtlasPages_91 = textRenderer.composedAtlasPages
        if __lux_tmp_composedAtlasPages_91 == nil then
          __lux_tmp_composedAtlasPages_91 = 0
        end
        local __lux_tmp_composedEntries_92 = textRenderer.composedEntries
        if __lux_tmp_composedEntries_92 == nil then
          __lux_tmp_composedEntries_92 = 0
        end
        printFn(
          "[MGFX] text renderer mode=" ..
            toString(__lux_tmp_mode_89) ..
              " composed=" ..
                toString(__lux_tmp_composedEnabled_90) ..
                  " atlasPages=" ..
                    toString(__lux_tmp_composedAtlasPages_91) ..
                      " entries=" .. toString(__lux_tmp_composedEntries_92)
        )
      end
      printMaterialStatus(status)
      return status
    end
    printProfileRows = function(label, rows, rollingRows, profiler)
      printFn("[MGFX] " .. label)
      if rows == nil or #rows == 0 then
        printFn("[MGFX]   none")
        return
      end
      local formatRows
      do
        local __lux_obj_profiler_93 = profiler
        local __lux_val_FormatRows_94 = nil
        if __lux_obj_profiler_93 ~= nil then
          __lux_val_FormatRows_94 = __lux_obj_profiler_93.FormatRows
        end
        formatRows = __lux_val_FormatRows_94
      end
      local formatted
      if formatRows ~= nil then
        formatted = formatRows(rows, rollingRows)
      else
        formatted = {}
      end
      for index = 1, #formatted do
        printFn("[MGFX]   " .. formatted[index])
      end
    end
    printProfileScopes = function(label, rows, includeBreakdown, profiler)
      printFn("[MGFX] " .. label)
      if rows == nil or #rows == 0 then
        printFn("[MGFX]   none")
        return
      end
      local formatRows
      do
        local __lux_obj_profiler_95 = profiler
        local __lux_val_FormatScopeRows_96 = nil
        if __lux_obj_profiler_95 ~= nil then
          __lux_val_FormatScopeRows_96 = __lux_obj_profiler_95.FormatScopeRows
        end
        formatRows = __lux_val_FormatScopeRows_96
      end
      local formatted
      if formatRows ~= nil then
        formatted = formatRows(rows, includeBreakdown)
      else
        formatted = {}
      end
      for index = 1, #formatted do
        printFn("[MGFX]   " .. formatted[index])
      end
    end
    rowTopParts = function(items, maxParts, useAvg)
      if maxParts == nil then
        maxParts = profileHudTopRows
      end
      if useAvg == nil then
        useAvg = true
      end
      local parts = {}
      do
        local __lux_tmp_items_97 = items
        if __lux_tmp_items_97 == nil then
          __lux_tmp_items_97 = {}
        end
        for index = 1, #__lux_tmp_items_97 do
          if index > maxParts then
            break
          end
          local item = items[index]
          local ms
          if useAvg then
            ms = item.avg
            if ms == nil then
              ms = item.last
              if ms == nil then
                ms = 0
              end
            end
          else
            ms = item.last
            if ms == nil then
              ms = item.avg
              if ms == nil then
                ms = 0
              end
            end
          end
          local count = item.avgCount
          if count == nil then
            count = item.count
            if count == nil then
              count = 0
            end
          end
          do
            local __lux_tmp_name_98 = item.name
            if __lux_tmp_name_98 == nil then
              __lux_tmp_name_98 = "?"
            end
            parts[#parts + 1] = stringFormat("%s %.2f/%d", __lux_tmp_name_98, ms, count)
          end
        end
      end
      if #parts > 0 then
        return tableConcat(parts, "  ")
      else
        return "none"
      end
    end
    printProfileInstanceRows = function(label, rows)
      printFn("[MGFX] " .. label)
      if rows == nil or #rows == 0 then
        printFn("[MGFX]   none")
        return
      end
      for index = 1, #rows do
        local row = rows[index]
        local stats = row.stats
        if stats == nil then
          stats = {}
        end
        do
          local __lux_tmp_name_99 = row.name
          if __lux_tmp_name_99 == nil then
            __lux_tmp_name_99 = row.instance
          end
          if __lux_tmp_name_99 == nil then
            __lux_tmp_name_99 = "runtime"
          end
          local __lux_tmp_last_100 = row.last
          if __lux_tmp_last_100 == nil then
            __lux_tmp_last_100 = 0
          end
          local __lux_tmp_avg_101 = row.avg
          if __lux_tmp_avg_101 == nil then
            __lux_tmp_avg_101 = 0
          end
          local __lux_tmp_max_102 = row.max
          if __lux_tmp_max_102 == nil then
            __lux_tmp_max_102 = 0
          end
          local __lux_tmp_count_103 = row.count
          if __lux_tmp_count_103 == nil then
            __lux_tmp_count_103 = 0
          end
          local __lux_tmp_avgCount_104 = row.avgCount
          if __lux_tmp_avgCount_104 == nil then
            __lux_tmp_avgCount_104 = 0
          end
          local __lux_tmp_draws_105 = stats.draws
          if __lux_tmp_draws_105 == nil then
            __lux_tmp_draws_105 = 0
          end
          local __lux_tmp_blurPasses_106 = stats.blurPasses
          if __lux_tmp_blurPasses_106 == nil then
            __lux_tmp_blurPasses_106 = 0
          end
          local __lux_tmp_textDraws_107 = stats.textDraws
          if __lux_tmp_textDraws_107 == nil then
            __lux_tmp_textDraws_107 = 0
          end
          local __lux_tmp_textComposedBakes_108 = stats.textComposedBakes
          if __lux_tmp_textComposedBakes_108 == nil then
            __lux_tmp_textComposedBakes_108 = 0
          end
          local __lux_tmp_fallbacks_109 = stats.fallbacks
          if __lux_tmp_fallbacks_109 == nil then
            __lux_tmp_fallbacks_109 = 0
          end
          local __lux_tmp_samples_110 = row.samples
          if __lux_tmp_samples_110 == nil then
            __lux_tmp_samples_110 = 0
          end
          printFn(
            stringFormat(
              "[MGFX]   %s last=%.3f avg=%.3f max=%.3f scopes=%d avgScopes=%.1f draws=%d blur=%d text=%d bake=%d fallback=%d samples=%d",
              __lux_tmp_name_99,
              __lux_tmp_last_100,
              __lux_tmp_avg_101,
              __lux_tmp_max_102,
              __lux_tmp_count_103,
              __lux_tmp_avgCount_104,
              __lux_tmp_draws_105,
              __lux_tmp_blurPasses_106,
              __lux_tmp_textDraws_107,
              __lux_tmp_textComposedBakes_108,
              __lux_tmp_fallbacks_109,
              __lux_tmp_samples_110
            )
          )
        end
        printFn("[MGFX]     api " .. rowTopParts(row.apiTop, 8, true))
        printFn("[MGFX]     stage " .. rowTopParts(row.profileTop, 8, true))
        printFn("[MGFX]     commands " .. rowTopParts(row.commandTop, 8, true))
        printFn("[MGFX]     immediate " .. rowTopParts(row.immediateTop, 8, true))
      end
    end
    profileStatus = function(owner)
      local profiler = formatProfiler(owner)
      local enabled
      if getConVar ~= nil then
        enabled = getConVar("mgfx_profile")
      else
        enabled = nil
      end
      local window
      if getConVar ~= nil then
        window = getConVar("mgfx_profile_window")
      else
        window = nil
      end
      local top
      if getConVar ~= nil then
        top = getConVar("mgfx_profile_top")
      else
        top = nil
      end
      printFn(
        "[MGFX] profiler enabled=" ..
          toString(enabled ~= nil and enabled:GetBool() or false) ..
            " window=" ..
              toString(window ~= nil and window:GetInt() or "n/a") ..
                " top=" ..
                  toString(top ~= nil and top:GetInt() or "n/a") ..
                    " instances=" .. toString(profilerInstanceCount())
      )
      if profiler == nil and profilerInstanceCount() == 0 then
        printFn("[MGFX] profiler unavailable")
        return false
      end
      local instanceRows = collectProfilerRows(owner, "InstanceRows")
      printProfileInstanceRows("profile instances", instanceRows)
      printFn(
        "[MGFX] scope details: use mgfx_profile_panels for rolling panel/screen rows, mgfx_profile_current for recent scopes."
      )
      return true
    end
    profilePanels = function(owner, limit)
      local profiler = formatProfiler(owner)
      if profiler == nil and profilerInstanceCount() == 0 then
        printFn("[MGFX] profiler unavailable")
        return false
      end
      local rows = collectProfilerRows(owner, "ScopeRows", limit)
      printProfileScopes("profile panel/screen rolling", rows, true, profiler)
      return true
    end
    profileCurrent = function(owner, limit)
      local profiler = formatProfiler(owner)
      if profiler == nil and profilerInstanceCount() == 0 then
        printFn("[MGFX] profiler unavailable")
        return false
      end
      local rows = collectProfilerRows(owner, "RecentScopes", limit)
      printProfileScopes("profile recent scopes", rows, true, profiler)
      return true
    end
    hudText = function(textValue, font, x, y, color, align)
      if drawSimpleText ~= nil then
        do
          local __lux_tmp_textValue_111 = textValue
          if __lux_tmp_textValue_111 == nil then
            __lux_tmp_textValue_111 = ""
          end
          local __lux_tmp_font_112 = font
          if __lux_tmp_font_112 == nil then
            __lux_tmp_font_112 = "DermaDefault"
          end
          local __lux_tmp_color_113 = color
          if __lux_tmp_color_113 == nil then
            __lux_tmp_color_113 = color_white
          end
          local __lux_tmp_align_114 = align
          if __lux_tmp_align_114 == nil then
            __lux_tmp_align_114 = TEXT_ALIGN_LEFT
          end
          drawSimpleText(
            toString(__lux_tmp_textValue_111),
            __lux_tmp_font_112,
            x,
            y,
            __lux_tmp_color_113,
            __lux_tmp_align_114,
            TEXT_ALIGN_TOP
          )
        end
      end
    end
    shortHotspotName = function(name)
      local text
      do
        local __lux_tmp_name_115 = name
        if __lux_tmp_name_115 == nil then
          __lux_tmp_name_115 = "?"
        end
        text = toString(__lux_tmp_name_115)
      end
      if stringSub(text, 1, 4) == "api." then
        text = stringSub(text, 5)
      else
        if stringSub(text, 1, 4) == "cmd." then
          text = stringSub(text, 5)
        end
      end
      if #text > 32 then
        text = stringSub(text, 1, 29) .. "..."
      end
      return text
    end
    drawHotspotTable = function(title, items, x, y, maxRows, headerColor, rowColor)
      hudText(title, "DermaDefaultBold", x, y, headerColor)
      hudText("avg", "DermaDefaultBold", x + 330, y, headerColor, TEXT_ALIGN_RIGHT)
      hudText("last", "DermaDefaultBold", x + 395, y, headerColor, TEXT_ALIGN_RIGHT)
      hudText("max", "DermaDefaultBold", x + 460, y, headerColor, TEXT_ALIGN_RIGHT)
      hudText("calls/f", "DermaDefaultBold", x + 535, y, headerColor, TEXT_ALIGN_RIGHT)
      y = y + 16
      if items == nil or #items == 0 then
        hudText("none", "DermaDefault", x + 18, y, makeColor(145, 160, 170))
        return y + 16
      end
      do
        local __lux_tmp_maxRows_116 = maxRows
        if __lux_tmp_maxRows_116 == nil then
          __lux_tmp_maxRows_116 = profileHudTopRows
        end
        maxRows = mathMin(__lux_tmp_maxRows_116, #items)
      end
      for index = 1, maxRows do
        local item = items[index]
        hudText(stringFormat("%02d", index), "DermaDefault", x, y, rowColor)
        hudText(shortHotspotName(item.name), "DermaDefault", x + 30, y, rowColor)
        do
          local __lux_tmp_avg_117 = item.avg
          if __lux_tmp_avg_117 == nil then
            __lux_tmp_avg_117 = item.last
          end
          if __lux_tmp_avg_117 == nil then
            __lux_tmp_avg_117 = 0
          end
          hudText(
            stringFormat("%.2f", __lux_tmp_avg_117),
            "DermaDefault",
            x + 330,
            y,
            rowColor,
            TEXT_ALIGN_RIGHT
          )
        end
        do
          local __lux_tmp_last_118 = item.last
          if __lux_tmp_last_118 == nil then
            __lux_tmp_last_118 = item.avg
          end
          if __lux_tmp_last_118 == nil then
            __lux_tmp_last_118 = 0
          end
          hudText(
            stringFormat("%.2f", __lux_tmp_last_118),
            "DermaDefault",
            x + 395,
            y,
            rowColor,
            TEXT_ALIGN_RIGHT
          )
        end
        do
          local __lux_tmp_max_119 = item.max
          if __lux_tmp_max_119 == nil then
            __lux_tmp_max_119 = 0
          end
          hudText(
            stringFormat("%.2f", __lux_tmp_max_119),
            "DermaDefault",
            x + 460,
            y,
            rowColor,
            TEXT_ALIGN_RIGHT
          )
        end
        do
          local __lux_tmp_avgCount_120 = item.avgCount
          if __lux_tmp_avgCount_120 == nil then
            __lux_tmp_avgCount_120 = item.count
          end
          if __lux_tmp_avgCount_120 == nil then
            __lux_tmp_avgCount_120 = 0
          end
          hudText(
            stringFormat("%.1f", __lux_tmp_avgCount_120),
            "DermaDefault",
            x + 535,
            y,
            rowColor,
            TEXT_ALIGN_RIGHT
          )
        end
        y = y + 15
      end
      return y
    end
    drawProfileHud = function(owner)
      local profiler = formatProfiler(owner)
      if profiler == nil and profilerInstanceCount() == 0 then
        return
      end
      local rows = collectProfilerRows(owner, "InstanceRows", profileHudRows)
      local width = 1260
      local blockH = 112 + profileHudTopRows * 15
      local headerH = 42
      local height = headerH + mathMax(1, #rows) * blockH + 18
      local x = profileHudX
      local y = profileHudY
      if surfaceSetDrawColor ~= nil and surfaceDrawRect ~= nil then
        surfaceSetDrawColor(5, 8, 12, 218)
        surfaceDrawRect(x, y, width, height)
      end
      if surfaceSetDrawColor ~= nil and surfaceDrawOutlinedRect ~= nil then
        surfaceSetDrawColor(86, 176, 230, 150)
        surfaceDrawOutlinedRect(x, y, width, height)
      end
      local enabled
      if getConVar ~= nil then
        enabled = getConVar("mgfx_profile")
      else
        enabled = nil
      end
      local drawCounts
      if getConVar ~= nil then
        drawCounts = getConVar("mgfx_draw_counts")
      else
        drawCounts = nil
      end
      hudText("MGFX PROFILE HUD", "DermaDefaultBold", x + 10, y + 8, makeColor(130, 220, 255))
      hudText(
        "runtime total + API hotspots  profile=" ..
          toString(enabled ~= nil and enabled:GetBool() or false) ..
            "  counts=" ..
              toString(drawCounts ~= nil and drawCounts:GetBool() or false) ..
                "  instances=" .. toString(profilerInstanceCount()),
        "DermaDefault",
        x + 170,
        y + 8,
        makeColor(205, 220, 226)
      )
      hudText(
        "Use mgfx_profile_panels only when the runtime/API view points to a suspicious container.",
        "DermaDefault",
        x + 10,
        y + 26,
        makeColor(150, 176, 188)
      )
      local rowY = y + headerH
      for index = 1, #rows do
        local row = rows[index]
        local stats = row.stats
        if stats == nil then
          stats = {}
        end
        local hot
        do
          local __lux_tmp_last_121 = row.last
          if __lux_tmp_last_121 == nil then
            __lux_tmp_last_121 = 0
          end
          hot = __lux_tmp_last_121 >= 2
        end
        local rowColor
        if hot then
          rowColor = makeColor(255, 206, 128)
        else
          rowColor = makeColor(210, 224, 232)
        end
        local name
        do
          local __lux_tmp_name_122 = row.name
          if __lux_tmp_name_122 == nil then
            __lux_tmp_name_122 = row.key
          end
          if __lux_tmp_name_122 == nil then
            __lux_tmp_name_122 = "scope"
          end
          name = toString(__lux_tmp_name_122)
        end
        if #name > 58 then
          name = stringSub(name, 1, 55) .. "..."
        end
        hudText(
          stringFormat("%02d %s", index, name),
          "DermaDefaultBold",
          x + 10,
          rowY,
          rowColor
        )
        do
          local __lux_tmp_last_123 = row.last
          if __lux_tmp_last_123 == nil then
            __lux_tmp_last_123 = 0
          end
          local __lux_tmp_avg_124 = row.avg
          if __lux_tmp_avg_124 == nil then
            __lux_tmp_avg_124 = 0
          end
          local __lux_tmp_max_125 = row.max
          if __lux_tmp_max_125 == nil then
            __lux_tmp_max_125 = 0
          end
          local __lux_tmp_avgCount_126 = row.avgCount
          if __lux_tmp_avgCount_126 == nil then
            __lux_tmp_avgCount_126 = row.count
          end
          if __lux_tmp_avgCount_126 == nil then
            __lux_tmp_avgCount_126 = 0
          end
          hudText(
            stringFormat(
              "total last %.2fms   avg %.2fms   max %.2fms   scopes %.0f/frame",
              __lux_tmp_last_123,
              __lux_tmp_avg_124,
              __lux_tmp_max_125,
              __lux_tmp_avgCount_126
            ),
            "DermaDefaultBold",
            x + 430,
            rowY,
            rowColor
          )
        end
        rowY = rowY + 17
        do
          local __lux_tmp_draws_127 = stats.draws
          if __lux_tmp_draws_127 == nil then
            __lux_tmp_draws_127 = 0
          end
          local __lux_tmp_blurPasses_128 = stats.blurPasses
          if __lux_tmp_blurPasses_128 == nil then
            __lux_tmp_blurPasses_128 = 0
          end
          local __lux_tmp_textDraws_129 = stats.textDraws
          if __lux_tmp_textDraws_129 == nil then
            __lux_tmp_textDraws_129 = 0
          end
          local __lux_tmp_textComposedBakes_130 = stats.textComposedBakes
          if __lux_tmp_textComposedBakes_130 == nil then
            __lux_tmp_textComposedBakes_130 = 0
          end
          local __lux_tmp_fallbacks_131 = stats.fallbacks
          if __lux_tmp_fallbacks_131 == nil then
            __lux_tmp_fallbacks_131 = 0
          end
          hudText(
            stringFormat(
              "draws %d   blur %d   text %d   bakes %d   fallback %d",
              __lux_tmp_draws_127,
              __lux_tmp_blurPasses_128,
              __lux_tmp_textDraws_129,
              __lux_tmp_textComposedBakes_130,
              __lux_tmp_fallbacks_131
            ),
            "DermaDefault",
            x + 30,
            rowY,
            makeColor(170, 194, 204)
          )
        end
        rowY = rowY + 19
        local tableY = drawHotspotTable(
          "API hotspots in this runtime",
          row.apiTop,
          x + 30,
          rowY,
          profileHudTopRows,
          makeColor(180, 218, 232),
          makeColor(210, 226, 234)
        )
        hudText(
          "stage " .. rowTopParts(row.profileTop, 4, true),
          "DermaDefault",
          x + 640,
          rowY,
          makeColor(170, 204, 218)
        )
        hudText(
          "commands " .. rowTopParts(row.commandTop, 4, true),
          "DermaDefault",
          x + 640,
          rowY + 17,
          makeColor(160, 190, 204)
        )
        hudText(
          "immediate " .. rowTopParts(row.immediateTop, 4, true),
          "DermaDefault",
          x + 640,
          rowY + 34,
          makeColor(160, 190, 204)
        )
        rowY = tableY + 16
      end
    end
    setProfileHud = function(owner, enabled)
      profileHudEnabled = enabled == true
      if hookRemove ~= nil then
        hookRemove("HUDPaint", profileHudHook)
      end
      if profileHudEnabled then
        if runConsoleCommand ~= nil then
          runConsoleCommand("mgfx_profile", "1")
          runConsoleCommand("mgfx_draw_counts", "1")
        end
        if hookAdd ~= nil then
          hookAdd(
            "HUDPaint",
            profileHudHook,
            function()
              drawProfileHud(owner)
            end
          )
        end
      end
      do
        local __lux_tmp_132
        if profileHudEnabled then
          __lux_tmp_132 = "ON"
        else
          __lux_tmp_132 = "OFF"
        end
        printFn("[MGFX] profile hud " .. __lux_tmp_132)
      end
      return profileHudEnabled
    end
    toggleProfileHud = function(owner, mode)
      if mode == nil then
        mode = "toggle"
      end
      if mode == "1" or mode == "on" or mode == "true" then
        return setProfileHud(owner, true)
      end
      if mode == "0" or mode == "off" or mode == "false" then
        return setProfileHud(owner, false)
      end
      return setProfileHud(owner, not profileHudEnabled)
    end
    profileReset = function(owner)
      local count = resetAllProfilers()
      if count == 0 then
        local profiler = profilerApi(owner)
        if profiler ~= nil and profiler.Reset ~= nil then
          profiler.Reset()
          count = 1
        end
      end
      printFn("[MGFX] profiler reset instances=" .. toString(count))
      return true
    end
    textStatusCommand = function(owner)
      local stats = ownerStats(owner)
      local snapshot = textStatus(owner)
      local status = textRendererStatus(owner)
      local fillPct
      do
        local __lux_tmp_composedAtlasFill_133 = toNumber(status.composedAtlasFill)
        if __lux_tmp_composedAtlasFill_133 == nil then
          __lux_tmp_composedAtlasFill_133 = 0
        end
        fillPct = mathFloor(__lux_tmp_composedAtlasFill_133 * 100 + 0.5)
      end
      do
        local __lux_tmp_mode_134 = status.mode
        if __lux_tmp_mode_134 == nil then
          __lux_tmp_mode_134 = "n/a"
        end
        local __lux_tmp_composedEnabled_135 = status.composedEnabled
        if __lux_tmp_composedEnabled_135 == nil then
          __lux_tmp_composedEnabled_135 = false
        end
        local __lux_tmp_composedFailed_136 = status.composedFailed
        if __lux_tmp_composedFailed_136 == nil then
          __lux_tmp_composedFailed_136 = false
        end
        printFn(
          "[MGFX] text mode=" ..
            toString(__lux_tmp_mode_134) ..
              " composed=" ..
                toString(__lux_tmp_composedEnabled_135) ..
                  " failed=" .. toString(__lux_tmp_composedFailed_136)
        )
      end
      do
        local __lux_tmp_draws_137 = status.draws
        if __lux_tmp_draws_137 == nil then
          __lux_tmp_draws_137 = snapshot.draws
        end
        if __lux_tmp_draws_137 == nil then
          __lux_tmp_draws_137 = stats.textDraws
        end
        if __lux_tmp_draws_137 == nil then
          __lux_tmp_draws_137 = 0
        end
        local __lux_tmp_nativeDraws_138 = status.nativeDraws
        if __lux_tmp_nativeDraws_138 == nil then
          __lux_tmp_nativeDraws_138 = stats.textNativeDraws
        end
        if __lux_tmp_nativeDraws_138 == nil then
          __lux_tmp_nativeDraws_138 = 0
        end
        local __lux_tmp_shaderDraws_139 = status.shaderDraws
        if __lux_tmp_shaderDraws_139 == nil then
          __lux_tmp_shaderDraws_139 = stats.textShaderDraws
        end
        if __lux_tmp_shaderDraws_139 == nil then
          __lux_tmp_shaderDraws_139 = 0
        end
        local __lux_tmp_composedDraws_140 = status.composedDraws
        if __lux_tmp_composedDraws_140 == nil then
          __lux_tmp_composedDraws_140 = stats.textComposedDraws
        end
        if __lux_tmp_composedDraws_140 == nil then
          __lux_tmp_composedDraws_140 = 0
        end
        printFn(
          "[MGFX] text draws=" ..
            toString(__lux_tmp_draws_137) ..
              " native=" ..
                toString(__lux_tmp_nativeDraws_138) ..
                  " shader=" ..
                    toString(__lux_tmp_shaderDraws_139) ..
                      " composed=" .. toString(__lux_tmp_composedDraws_140)
        )
      end
      do
        local __lux_tmp_textQueuedBatches_141 = stats.textQueuedBatches
        if __lux_tmp_textQueuedBatches_141 == nil then
          __lux_tmp_textQueuedBatches_141 = 0
        end
        local __lux_tmp_textQueuedRecords_142 = stats.textQueuedRecords
        if __lux_tmp_textQueuedRecords_142 == nil then
          __lux_tmp_textQueuedRecords_142 = 0
        end
        printFn(
          "[MGFX] text queued batches=" ..
            toString(__lux_tmp_textQueuedBatches_141) ..
              " records=" .. toString(__lux_tmp_textQueuedRecords_142)
        )
      end
      do
        local __lux_tmp_textComposedBatchDraws_143 = stats.textComposedBatchDraws
        if __lux_tmp_textComposedBatchDraws_143 == nil then
          __lux_tmp_textComposedBatchDraws_143 = 0
        end
        local __lux_tmp_textComposedBatchedRecords_144 = stats.textComposedBatchedRecords
        if __lux_tmp_textComposedBatchedRecords_144 == nil then
          __lux_tmp_textComposedBatchedRecords_144 = 0
        end
        printFn(
          "[MGFX] text batch draws=" ..
            toString(__lux_tmp_textComposedBatchDraws_143) ..
              " records=" .. toString(__lux_tmp_textComposedBatchedRecords_144)
        )
      end
      do
        local __lux_tmp_textComposedRequests_145 = stats.textComposedRequests
        if __lux_tmp_textComposedRequests_145 == nil then
          __lux_tmp_textComposedRequests_145 = 0
        end
        local __lux_tmp_textComposedBatches_146 = stats.textComposedBatches
        if __lux_tmp_textComposedBatches_146 == nil then
          __lux_tmp_textComposedBatches_146 = 0
        end
        local __lux_tmp_textComposedReadyBatches_147 = stats.textComposedReadyBatches
        if __lux_tmp_textComposedReadyBatches_147 == nil then
          __lux_tmp_textComposedReadyBatches_147 = 0
        end
        local __lux_tmp_textComposedFallbackBatches_148 = stats.textComposedFallbackBatches
        if __lux_tmp_textComposedFallbackBatches_148 == nil then
          __lux_tmp_textComposedFallbackBatches_148 = 0
        end
        local __lux_tmp_textComposedFallbackRecords_149 = stats.textComposedFallbackRecords
        if __lux_tmp_textComposedFallbackRecords_149 == nil then
          __lux_tmp_textComposedFallbackRecords_149 = 0
        end
        local __lux_tmp_textComposedPrewarmFails_150 = stats.textComposedPrewarmFails
        if __lux_tmp_textComposedPrewarmFails_150 == nil then
          __lux_tmp_textComposedPrewarmFails_150 = 0
        end
        local __lux_tmp_textComposedPrewarmRestarts_151 = stats.textComposedPrewarmRestarts
        if __lux_tmp_textComposedPrewarmRestarts_151 == nil then
          __lux_tmp_textComposedPrewarmRestarts_151 = 0
        end
        printFn(
          "[MGFX] text composer route requests=" ..
            toString(__lux_tmp_textComposedRequests_145) ..
              " batches=" ..
                toString(__lux_tmp_textComposedBatches_146) ..
                  " readyBatches=" ..
                    toString(__lux_tmp_textComposedReadyBatches_147) ..
                      " fallbackBatches=" ..
                        toString(__lux_tmp_textComposedFallbackBatches_148) ..
                          " fallbackRecords=" ..
                            toString(__lux_tmp_textComposedFallbackRecords_149) ..
                              " prewarmFails=" ..
                                toString(__lux_tmp_textComposedPrewarmFails_150) ..
                                  " prewarmRestarts=" .. toString(__lux_tmp_textComposedPrewarmRestarts_151)
        )
      end
      do
        local __lux_tmp_textEntryCacheHits_152 = stats.textEntryCacheHits
        if __lux_tmp_textEntryCacheHits_152 == nil then
          __lux_tmp_textEntryCacheHits_152 = 0
        end
        local __lux_tmp_textEntryCacheMisses_153 = stats.textEntryCacheMisses
        if __lux_tmp_textEntryCacheMisses_153 == nil then
          __lux_tmp_textEntryCacheMisses_153 = 0
        end
        printFn(
          "[MGFX] text entry cache hit/miss=" ..
            toString(__lux_tmp_textEntryCacheHits_152) ..
              "/" .. toString(__lux_tmp_textEntryCacheMisses_153)
        )
      end
      do
        local __lux_tmp_textMeasureHits_154 = stats.textMeasureHits
        if __lux_tmp_textMeasureHits_154 == nil then
          __lux_tmp_textMeasureHits_154 = 0
        end
        local __lux_tmp_textMeasureMisses_155 = stats.textMeasureMisses
        if __lux_tmp_textMeasureMisses_155 == nil then
          __lux_tmp_textMeasureMisses_155 = 0
        end
        local __lux_tmp_textCacheSize_156 = stats.textCacheSize
        if __lux_tmp_textCacheSize_156 == nil then
          __lux_tmp_textCacheSize_156 = 0
        end
        printFn(
          "[MGFX] text measure hit/miss=" ..
            toString(__lux_tmp_textMeasureHits_154) ..
              "/" ..
                toString(__lux_tmp_textMeasureMisses_155) ..
                  " cache=" .. toString(__lux_tmp_textCacheSize_156)
        )
      end
      do
        local __lux_tmp_composedEnabled_157 = status.composedEnabled
        if __lux_tmp_composedEnabled_157 == nil then
          __lux_tmp_composedEnabled_157 = false
        end
        local __lux_tmp_fontCount_158 = status.fontCount
        if __lux_tmp_fontCount_158 == nil then
          __lux_tmp_fontCount_158 = 0
        end
        local __lux_tmp_composedAtlasW_159 = status.composedAtlasW
        if __lux_tmp_composedAtlasW_159 == nil then
          __lux_tmp_composedAtlasW_159 = 0
        end
        local __lux_tmp_composedAtlasH_160 = status.composedAtlasH
        if __lux_tmp_composedAtlasH_160 == nil then
          __lux_tmp_composedAtlasH_160 = 0
        end
        local __lux_tmp_composedAtlasPages_161 = status.composedAtlasPages
        if __lux_tmp_composedAtlasPages_161 == nil then
          __lux_tmp_composedAtlasPages_161 = 0
        end
        local __lux_tmp_composedAtlasMaxPages_162 = status.composedAtlasMaxPages
        if __lux_tmp_composedAtlasMaxPages_162 == nil then
          __lux_tmp_composedAtlasMaxPages_162 = 0
        end
        local __lux_tmp_composedEntries_163 = status.composedEntries
        if __lux_tmp_composedEntries_163 == nil then
          __lux_tmp_composedEntries_163 = stats.textComposedEntries
        end
        if __lux_tmp_composedEntries_163 == nil then
          __lux_tmp_composedEntries_163 = 0
        end
        local __lux_tmp_styleCount_164 = status.styleCount
        if __lux_tmp_styleCount_164 == nil then
          __lux_tmp_styleCount_164 = 0
        end
        local __lux_tmp_styleStackDepth_165 = status.styleStackDepth
        if __lux_tmp_styleStackDepth_165 == nil then
          __lux_tmp_styleStackDepth_165 = 0
        end
        local __lux_tmp_composedFailed_166 = status.composedFailed
        if __lux_tmp_composedFailed_166 == nil then
          __lux_tmp_composedFailed_166 = false
        end
        printFn(
          "[MGFX] text composer enabled=" ..
            toString(__lux_tmp_composedEnabled_157) ..
              " aliases=" ..
                toString(__lux_tmp_fontCount_158) ..
                  " atlas=" ..
                    toString(__lux_tmp_composedAtlasW_159) ..
                      "x" ..
                        toString(__lux_tmp_composedAtlasH_160) ..
                          " pages=" ..
                            toString(__lux_tmp_composedAtlasPages_161) ..
                              "/" ..
                                toString(__lux_tmp_composedAtlasMaxPages_162) ..
                                  " fill=" ..
                                    toString(fillPct) ..
                                      "% entries=" ..
                                        toString(__lux_tmp_composedEntries_163) ..
                                          " styles=" ..
                                            toString(__lux_tmp_styleCount_164) ..
                                              " stack=" ..
                                                toString(__lux_tmp_styleStackDepth_165) ..
                                                  " failed=" .. toString(__lux_tmp_composedFailed_166)
        )
      end
      do
        local __lux_tmp_composedBakes_167 = status.composedBakes
        if __lux_tmp_composedBakes_167 == nil then
          __lux_tmp_composedBakes_167 = stats.textComposedBakes
        end
        if __lux_tmp_composedBakes_167 == nil then
          __lux_tmp_composedBakes_167 = 0
        end
        local __lux_tmp_composedBlits_168 = status.composedBlits
        if __lux_tmp_composedBlits_168 == nil then
          __lux_tmp_composedBlits_168 = stats.textComposedBlits
        end
        if __lux_tmp_composedBlits_168 == nil then
          __lux_tmp_composedBlits_168 = 0
        end
        local __lux_tmp_textComposedFallbackRecords_169 = stats.textComposedFallbackRecords
        if __lux_tmp_textComposedFallbackRecords_169 == nil then
          __lux_tmp_textComposedFallbackRecords_169 = 0
        end
        printFn(
          "[MGFX] text compose bakes=" ..
            toString(__lux_tmp_composedBakes_167) ..
              " blits=" ..
                toString(__lux_tmp_composedBlits_168) ..
                  " fallbackRecords=" .. toString(__lux_tmp_textComposedFallbackRecords_169)
        )
      end
      return status
    end
    textCacheClear = function(owner)
      local clearMeasure
      do
        local __lux_obj_owner_170 = owner
        local __lux_val_ClearTextMeasureCache_171 = nil
        if __lux_obj_owner_170 ~= nil then
          __lux_val_ClearTextMeasureCache_171 = __lux_obj_owner_170.ClearTextMeasureCache
        end
        clearMeasure = __lux_val_ClearTextMeasureCache_171
      end
      if clearMeasure ~= nil then
        clearMeasure()
      end
      printFn("[MGFX] text measure cache cleared")
      return true
    end
    textComposedClear = function(owner)
      local clearComposed
      do
        local __lux_obj_owner_172 = owner
        local __lux_val_ClearTextComposedCache_173 = nil
        if __lux_obj_owner_172 ~= nil then
          __lux_val_ClearTextComposedCache_173 = __lux_obj_owner_172.ClearTextComposedCache
        end
        clearComposed = __lux_val_ClearTextComposedCache_173
      end
      local ok = false
      if clearComposed ~= nil then
        ok = clearComposed() == true
      end
      printFn("[MGFX] text composer cache clear: " .. toString(ok))
      return true
    end
  end
  do
    TEXT_DEMO_CJK_FACE = "Noto Sans SC"
    textDemoStrings = {
      { "MGFX TEXT FX", "MGFXTextDemoTitle" },
      { "gradient face / outline / glow / shadow / numeric / cjk", "MGFXTextDemoSmall" },
      { "OUTLINE 128,450 中文描边", "MGFXTextDemoCJK" },
      { "GLOW 外发光 soft halo", "MGFXTextDemoCJK" },
      { "SHADOW 软阴影不走整段文字 RT", "MGFXTextDemoCJK" },
      { "FACE polish Aa 123 中文正常", "MGFXTextDemoCJK" },
      { "SOLID clean fill 中文纯色 Aa123", "MGFXTextDemoCJK" },
      { "128,450  +100 XP", "MGFXTextDemoNum" },
      { "Bold  Thin  Italic  Slanted", "MGFXTextDemoBody" },
      {
        "TextBox: 自动测量、ellipsis、矩形锚定，表格和栏位不再手写每个字符 baseline。",
        "MGFXTextDemoSmall",
      },
    }
    ensureTextDemoFonts = function(owner)
      if textDemoFontsReady then
        return true
      end
      if surfaceCreateFont ~= nil then
        surfaceCreateFont(
          "MGFXTextDemoNativeCJK",
          {
            font = TEXT_DEMO_CJK_FACE,
            size = 18,
            weight = 400,
            antialias = true,
            extended = true,
          }
        )
      end
      local register
      do
        local __lux_obj_owner_174 = owner
        local __lux_val_RegisterTextFont_175 = nil
        if __lux_obj_owner_174 ~= nil then
          __lux_val_RegisterTextFont_175 = __lux_obj_owner_174.RegisterTextFont
        end
        register = __lux_val_RegisterTextFont_175
      end
      if register == nil then
        return false
      end
      local ok = true
      ok = register(
        "MGFXTextDemoTitle",
        { face = "Bahnschrift", size = 34, weight = 650, lineHeight = 42 }
      ) and ok
      ok = register(
        "MGFXTextDemoBody",
        { face = "Bahnschrift", size = 18, weight = 520, lineHeight = 24 }
      ) and ok
      ok = register(
        "MGFXTextDemoSmall",
        { face = TEXT_DEMO_CJK_FACE, size = 15, weight = 400, lineHeight = 22 }
      ) and ok
      ok = register(
        "MGFXTextDemoCJK",
        { face = TEXT_DEMO_CJK_FACE, size = 18, weight = 400, lineHeight = 26 }
      ) and ok
      ok = register(
        "MGFXTextDemoNum",
        { face = "Bahnschrift", size = 26, weight = 700, lineHeight = 32 }
      ) and ok
      textDemoFontsReady = ok == true
      return textDemoFontsReady
    end
    drawTextDemo = function(owner)
      ensureTextDemoFonts(owner)
      local sw = ScrW()
      local sh = ScrH()
      local strong = textDemoFx ~= nil and textDemoFx:GetBool() or false
      local glowW
      if strong then
        glowW = 7
      else
        glowW = 4
      end
      local strokeW
      if strong then
        strokeW = 1.05
      else
        strokeW = 0.8
      end
      local panelW = mathMin(840, sw - 96)
      owner.StartScreen(sw, sh)
      owner.RoundedBoxEx(
        48,
        48,
        panelW,
        430,
        {
          radius = 10,
          fill = makeColor(4, 14, 20, 220),
          stroke = makeColor(90, 190, 255, 60),
          strokeWidth = 1,
          innerGlow = { color = makeColor(80, 200, 255, 24), size = 16, opacity = 0.5 },
        }
      )
      owner.TextEx(
        "MGFX TEXT FX",
        "MGFXTextDemoTitle",
        76,
        83,
        nil,
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER,
        {
          fill = owner.LinearGradient(
            0,
            0,
            1,
            0,
            {
              { 0, makeColor(104, 210, 255, 255) },
              { 0.55, makeColor(238, 248, 255, 255) },
              { 1, makeColor(255, 204, 112, 255) },
            }
          ),
          stroke = { width = 0.9, softness = 0.55, color = makeColor(2, 9, 12, 185) },
          shadow = { x = 0, y = 2, blur = 5, color = makeColor(0, 0, 0, 145) },
          glow = { size = glowW, color = makeColor(66, 188, 255, 64), opacity = 0.58, softness = 0.56 },
          surface = { strength = 0.14 },
        }
      )
      owner.TextEx(
        "gradient face / outline / glow / shadow / numeric / cjk",
        "MGFXTextDemoSmall",
        78,
        116,
        makeColor(178, 204, 214),
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER,
        { shadow = { x = 0, y = 1, blur = 2, color = makeColor(0, 0, 0, 110) } }
      )
      owner.TextEx(
        "OUTLINE",
        "MGFXTextDemoBody",
        78,
        160,
        makeColor(238, 246, 252),
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER,
        {
          stroke = { width = strokeW, softness = 0.58, color = makeColor(0, 0, 0, 178) },
          shadow = { x = 0, y = 2, blur = 4, color = makeColor(0, 0, 0, 125) },
        }
      )
      owner.TextEx(
        "128,450 中文描边",
        "MGFXTextDemoCJK",
        178,
        160,
        makeColor(246, 250, 255),
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER,
        {
          stroke = { width = strokeW, softness = 0.62, color = makeColor(0, 0, 0, 164) },
          shadow = { x = 0, y = 2, blur = 4, color = makeColor(0, 0, 0, 115) },
        }
      )
      owner.TextEx(
        "GLOW",
        "MGFXTextDemoBody",
        78,
        204,
        makeColor(205, 244, 255),
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER,
        {
          stroke = { width = 0.65, softness = 0.58, color = makeColor(2, 10, 16, 142) },
          glow = {
            size = glowW + 1,
            color = makeColor(70, 205, 255, 88),
            opacity = 0.72,
            softness = 0.62,
          },
          surface = { strength = 0.08 },
        }
      )
      owner.TextEx(
        "外发光 / soft halo",
        "MGFXTextDemoCJK",
        178,
        204,
        makeColor(211, 245, 255),
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER,
        {
          stroke = { width = 0.65, softness = 0.60, color = makeColor(2, 10, 16, 136) },
          glow = {
            size = glowW + 1,
            color = makeColor(70, 205, 255, 86),
            opacity = 0.70,
            softness = 0.62,
          },
          surface = { strength = 0.06 },
        }
      )
      owner.TextEx(
        "SHADOW",
        "MGFXTextDemoBody",
        78,
        248,
        makeColor(255, 222, 166),
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER,
        {
          shadow = { x = 4, y = 5, blur = 8, color = makeColor(0, 0, 0, 175) },
          stroke = { width = 0.55, softness = 0.65, color = makeColor(46, 24, 2, 110) },
        }
      )
      owner.TextEx(
        "软阴影不走整段文字 RT",
        "MGFXTextDemoCJK",
        178,
        248,
        makeColor(255, 224, 178),
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER,
        {
          shadow = { x = 4, y = 5, blur = 8, color = makeColor(0, 0, 0, 165) },
          stroke = { width = 0.55, softness = 0.65, color = makeColor(46, 24, 2, 105) },
        }
      )
      owner.TextEx(
        "FACE",
        "MGFXTextDemoBody",
        78,
        292,
        makeColor(232, 240, 245),
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER,
        {
          stroke = { width = 0.55, softness = 0.64, color = makeColor(0, 0, 0, 108) },
          surface = { strength = 0.16 },
          shadow = { x = 0, y = 2, blur = 4, color = makeColor(0, 0, 0, 105) },
        }
      )
      owner.TextEx(
        "polish Aa 123 中文正常",
        "MGFXTextDemoCJK",
        178,
        292,
        makeColor(232, 242, 246),
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER,
        {
          stroke = { width = 0.50, softness = 0.66, color = makeColor(0, 0, 0, 96) },
          surface = { strength = 0.08 },
          shadow = { x = 0, y = 2, blur = 4, color = makeColor(0, 0, 0, 100) },
        }
      )
      owner.TextEx(
        "SOLID",
        "MGFXTextDemoBody",
        78,
        326,
        makeColor(232, 238, 242),
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER
      )
      owner.TextEx(
        "clean fill 中文纯色 Aa123",
        "MGFXTextDemoCJK",
        178,
        326,
        makeColor(232, 238, 242),
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER
      )
      owner.TextEx(
        "NATIVE",
        "MGFXTextDemoBody",
        78,
        354,
        makeColor(190, 222, 230),
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER
      )
      owner.TextEx(
        "plain TextEx route 中文 Aa123",
        "MGFXTextDemoCJK",
        178,
        354,
        makeColor(220, 238, 240),
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER
      )
      owner.TextEx(
        "128,450",
        "MGFXTextDemoNum",
        514,
        160,
        makeColor(232, 248, 255),
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER,
        {
          stroke = { width = 0.65, softness = 0.58, color = makeColor(0, 0, 0, 148) },
          glow = { size = 5, color = makeColor(66, 190, 255, 44), opacity = 0.55, softness = 0.5 },
          shadow = { x = 0, y = 2, blur = 5, color = makeColor(0, 0, 0, 135) },
          surface = { strength = 0.12 },
        }
      )
      owner.TextEx(
        "+100 XP",
        "MGFXTextDemoNum",
        514,
        194,
        makeColor(178, 221, 255),
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER,
        {
          stroke = { width = 0.55, softness = 0.60, color = makeColor(0, 0, 0, 130) },
          shadow = { x = 0, y = 2, blur = 4, color = makeColor(0, 0, 0, 120) },
        }
      )
      owner.TextEx(
        "Bold",
        "MGFXTextDemoBody",
        514,
        246,
        makeColor(238, 245, 249),
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER,
        {
          bold = true,
          stroke = { width = 0.50, softness = 0.62, color = makeColor(0, 0, 0, 105) },
          shadow = { x = 0, y = 2, blur = 4, color = makeColor(0, 0, 0, 110) },
        }
      )
      owner.TextEx(
        "Thin",
        "MGFXTextDemoBody",
        594,
        246,
        makeColor(190, 228, 238),
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER,
        {
          thin = true,
          stroke = { width = 0.30, softness = 0.68, color = makeColor(0, 0, 0, 72) },
          shadow = { x = 0, y = 1, blur = 3, color = makeColor(0, 0, 0, 85) },
        }
      )
      owner.TextEx(
        "Italic",
        "MGFXTextDemoBody",
        664,
        246,
        makeColor(238, 245, 249),
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER,
        {
          italic = true,
          stroke = { width = 0.42, softness = 0.64, color = makeColor(0, 0, 0, 96) },
          shadow = { x = 0, y = 2, blur = 4, color = makeColor(0, 0, 0, 105) },
        }
      )
      owner.TextEx(
        "bold / thin 中文",
        "MGFXTextDemoSmall",
        514,
        292,
        makeColor(178, 222, 234),
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER,
        {
          bold = true,
          stroke = { width = 0.22, softness = 0.70, color = makeColor(0, 0, 0, 60) },
          glow = { size = 3, color = makeColor(90, 210, 255, 38), opacity = 0.42, softness = 0.46 },
          shadow = { x = 0, y = 1, blur = 3, color = makeColor(0, 0, 0, 78) },
        }
      )
      owner.TextBoxEx(
        "TextBox: 自动测量、ellipsis、矩形锚定，表格和栏位不再手写每个字符 baseline。",
        "MGFXTextDemoSmall",
        78,
        394,
        panelW - 156,
        42,
        {
          color = makeColor(214, 226, 220),
          alignX = "left",
          alignY = "center",
          overflow = "ellipsis",
          stroke = { width = 0.22, softness = 0.70, color = makeColor(0, 0, 0, 58) },
          shadow = { x = 0, y = 1, blur = 3, color = makeColor(0, 0, 0, 95) },
        }
      )
      owner.EndScreen()
      draw.SimpleText(
        "NATIVE",
        "DermaDefault",
        78,
        374,
        makeColor(190, 222, 230),
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER
      )
      draw.SimpleText(
        "native compare 中文 Aa123",
        "MGFXTextDemoNativeCJK",
        178,
        374,
        makeColor(220, 238, 240),
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER
      )
      local stats = ownerStats(owner)
      local status
      if owner.GetTextRendererStatus ~= nil then
        status = owner.GetTextRendererStatus()
      else
        status = {}
      end
      local fxLabel
      if strong then
        fxLabel = "strong"
      else
        fxLabel = "normal"
      end
      local composedEnabled = owner.TextComposedEnabled ~= nil and owner.TextComposedEnabled()
      local composedLabel
      if composedEnabled then
        composedLabel = "on"
      else
        composedLabel = "off"
      end
      do
        local __lux_tmp_textShaderDraws_176 = stats.textShaderDraws
        if __lux_tmp_textShaderDraws_176 == nil then
          __lux_tmp_textShaderDraws_176 = status.shaderDraws
        end
        if __lux_tmp_textShaderDraws_176 == nil then
          __lux_tmp_textShaderDraws_176 = 0
        end
        local __lux_tmp_textNativeDraws_177 = stats.textNativeDraws
        if __lux_tmp_textNativeDraws_177 == nil then
          __lux_tmp_textNativeDraws_177 = status.nativeDraws
        end
        if __lux_tmp_textNativeDraws_177 == nil then
          __lux_tmp_textNativeDraws_177 = 0
        end
        local __lux_tmp_textComposedBakes_178 = stats.textComposedBakes
        if __lux_tmp_textComposedBakes_178 == nil then
          __lux_tmp_textComposedBakes_178 = status.composedBakes
        end
        if __lux_tmp_textComposedBakes_178 == nil then
          __lux_tmp_textComposedBakes_178 = 0
        end
        local __lux_tmp_textComposedBlits_179 = stats.textComposedBlits
        if __lux_tmp_textComposedBlits_179 == nil then
          __lux_tmp_textComposedBlits_179 = status.composedBlits
        end
        if __lux_tmp_textComposedBlits_179 == nil then
          __lux_tmp_textComposedBlits_179 = 0
        end
        local __lux_tmp_composedEntries_180 = status.composedEntries
        if __lux_tmp_composedEntries_180 == nil then
          __lux_tmp_composedEntries_180 = stats.textComposedEntries
        end
        if __lux_tmp_composedEntries_180 == nil then
          __lux_tmp_composedEntries_180 = 0
        end
        draw.SimpleText(
          stringFormat(
            "text composed:%d native:%d bakes:%d blits:%d entries:%d fx:%s",
            __lux_tmp_textShaderDraws_176,
            __lux_tmp_textNativeDraws_177,
            __lux_tmp_textComposedBakes_178,
            __lux_tmp_textComposedBlits_179,
            __lux_tmp_composedEntries_180,
            fxLabel
          ),
          "DermaDefault",
          56,
          500,
          makeColor(210, 230, 235)
        )
      end
      local __lux_tmp_textComposedBakes_181 = stats.textComposedBakes
      if __lux_tmp_textComposedBakes_181 == nil then
        __lux_tmp_textComposedBakes_181 = status.composedBakes
      end
      if __lux_tmp_textComposedBakes_181 == nil then
        __lux_tmp_textComposedBakes_181 = 0
      end
      local __lux_tmp_textComposedBlits_182 = stats.textComposedBlits
      if __lux_tmp_textComposedBlits_182 == nil then
        __lux_tmp_textComposedBlits_182 = status.composedBlits
      end
      if __lux_tmp_textComposedBlits_182 == nil then
        __lux_tmp_textComposedBlits_182 = 0
      end
      local __lux_tmp_textComposedEntries_183 = stats.textComposedEntries
      if __lux_tmp_textComposedEntries_183 == nil then
        __lux_tmp_textComposedEntries_183 = status.composedEntries
      end
      if __lux_tmp_textComposedEntries_183 == nil then
        __lux_tmp_textComposedEntries_183 = 0
      end
      local __lux_tmp_textComposedEvicts_184 = stats.textComposedEvicts
      if __lux_tmp_textComposedEvicts_184 == nil then
        __lux_tmp_textComposedEvicts_184 = status.composedEvicts
      end
      if __lux_tmp_textComposedEvicts_184 == nil then
        __lux_tmp_textComposedEvicts_184 = 0
      end
      return draw.SimpleText(
        stringFormat(
          "composed bakes:%d blits:%d entries:%d evicts:%d  (mgfx_text_composed %s)",
          __lux_tmp_textComposedBakes_181,
          __lux_tmp_textComposedBlits_182,
          __lux_tmp_textComposedEntries_183,
          __lux_tmp_textComposedEvicts_184,
          composedLabel
        ),
        "DermaDefault",
        56,
        514,
        makeColor(170, 230, 200)
      )
    end
    toggleTextDemo = function(owner, mode)
      if mode == nil then
        mode = "toggle"
      end
      if hookRemove ~= nil then
        hookRemove("HUDPaint", "MGFXTextDemo")
      end
      if mode == "0" or mode == "off" or mode == "close" or mode == "toggle" and textDemoEnabled then
        textDemoEnabled = false
        printFn("[MGFX] text demo off")
        return false
      end
      if hookAdd ~= nil then
        hookAdd(
          "HUDPaint",
          "MGFXTextDemo",
          function()
            return drawTextDemo(owner)
          end
        )
      end
      textDemoEnabled = true
      printFn("[MGFX] text demo on")
      return true
    end
    traceTextDemo = function(owner)
      ensureTextDemoFonts(owner)
      local resolve
      do
        local __lux_obj_owner_185 = owner
        local __lux_val_DebugResolveText_186 = nil
        if __lux_obj_owner_185 ~= nil then
          __lux_val_DebugResolveText_186 = __lux_obj_owner_185.DebugResolveText
        end
        resolve = __lux_val_DebugResolveText_186
      end
      if resolve == nil then
        printFn("[MGFX] text trace unavailable")
        return false
      end
      for index = 1, #textDemoStrings do
        local item = textDemoStrings[index]
        local info = resolve(item[1], item[2])
        local missing
        do
          local __lux_obj_info_187 = info
          local __lux_val_missing_188 = nil
          if __lux_obj_info_187 ~= nil then
            __lux_val_missing_188 = __lux_obj_info_187.missing
          end
          missing = __lux_val_missing_188
          if missing == nil then
            missing = {}
          end
        end
        do
          local __lux_obj_info_189 = info
          local __lux_val_atlasKey_190 = nil
          if __lux_obj_info_189 ~= nil then
            __lux_val_atlasKey_190 = __lux_obj_info_189.atlasKey
          end
          local __lux_obj_info_191 = info
          local __lux_val_kind_192 = nil
          if __lux_obj_info_191 ~= nil then
            __lux_val_kind_192 = __lux_obj_info_191.kind
          end
          local __lux_obj_info_193 = info
          local __lux_val_routeAtlas_194 = nil
          if __lux_obj_info_193 ~= nil then
            __lux_val_routeAtlas_194 = __lux_obj_info_193.routeAtlas
          end
          local __lux_obj_info_195 = info
          local __lux_val_routeKind_196 = nil
          if __lux_obj_info_195 ~= nil then
            __lux_val_routeKind_196 = __lux_obj_info_195.routeKind
          end
          printFn(
            stringFormat(
              "[MGFX] demo text %d font=%s atlas=%s kind=%s route=%s routeKind=%s missing=%d",
              index,
              toString(item[2]),
              toString(__lux_val_atlasKey_190),
              toString(__lux_val_kind_192),
              toString(__lux_val_routeAtlas_194),
              toString(__lux_val_routeKind_196),
              #missing
            )
          )
        end
        if #missing > 0 then
          printFn("[MGFX]   missing chars: " .. tableConcat(missing, ""))
        end
      end
      return true
    end
    toggleAtlasDebug = function(owner)
      atlasDebugEnabled = not atlasDebugEnabled
      if hookRemove ~= nil then
        hookRemove("HUDPaint", "MGFXTextAtlasDebug")
      end
      if not atlasDebugEnabled then
        printFn("[MGFX] atlas debug overlay OFF")
        return false
      end
      local debugDraw
      do
        local __lux_obj_owner_197 = owner
        local __lux_val_DebugDrawTextAtlas_198 = nil
        if __lux_obj_owner_197 ~= nil then
          __lux_val_DebugDrawTextAtlas_198 = __lux_obj_owner_197.DebugDrawTextAtlas
        end
        debugDraw = __lux_val_DebugDrawTextAtlas_198
      end
      if hookAdd ~= nil and debugDraw ~= nil then
        hookAdd(
          "HUDPaint",
          "MGFXTextAtlasDebug",
          function()
            return debugDraw()
          end
        )
        printFn("[MGFX] atlas debug overlay ON")
        return true
      end
      printFn("[MGFX] atlas debug unavailable")
      return false
    end
    toggleTextStress = function(owner)
      textStressEnabled = not textStressEnabled
      if hookRemove ~= nil then
        hookRemove("HUDPaint", "MGFXTextStress")
      end
      if not textStressEnabled then
        printFn("[MGFX] text stress OFF")
        return false
      end
      local register
      do
        local __lux_obj_owner_199 = owner
        local __lux_val_RegisterTextFont_200 = nil
        if __lux_obj_owner_199 ~= nil then
          __lux_val_RegisterTextFont_200 = __lux_obj_owner_199.RegisterTextFont
        end
        register = __lux_val_RegisterTextFont_200
      end
      if register ~= nil then
        register(
          "MGFXStressNum",
          { face = "Bahnschrift", size = 40, weight = 900, lineHeight = 48 }
        )
      end
      local style = {
        stroke = { width = 1, color = makeColor(0, 0, 0, 190), samples = 10 },
        shadow = { x = 1, y = 1, blur = 2, color = makeColor(0, 0, 0, 150) },
      }
      if hookAdd ~= nil then
        hookAdd(
          "HUDPaint",
          "MGFXTextStress",
          function()
            local cols = 8
            local rows = 5
            local cw = 168
            local ch = 76
            local x0 = 40
            local y0 = 150
            local frame
            if FrameNumber ~= nil then
              frame = FrameNumber()
            else
              frame = mathFloor(sysTime() * 60)
            end
            for index = 0, cols * rows - 1 do
              local cx = x0 + index % cols * cw
              local cy = y0 + mathFloor(index / cols) * ch
              surfaceSetDrawColor(18, 22, 28, 235)
              surfaceDrawRect(cx, cy, cw - 6, ch - 6)
              surfaceSetDrawColor(60, 70, 84, 255)
              surfaceDrawOutlinedRect(cx, cy, cw - 6, ch - 6)
            end
            owner.StartScreen(ScrW(), ScrH())
            for index = 0, cols * rows - 1 do
              local value = stringFormat("%02d:%02d", (frame + index * 7) % 100, frame * (index + 1) % 100)
              local cx = x0 + index % cols * cw + (cw - 6) * 0.5
              local cy = y0 + mathFloor(index / cols) * ch + (ch - 6) * 0.5
              owner.TextEx(
                value,
                "MGFXStressNum",
                cx,
                cy,
                makeColor(130, 230, 255),
                TEXT_ALIGN_CENTER,
                TEXT_ALIGN_CENTER,
                style
              )
            end
            owner.EndScreen()
            return draw.SimpleText(
              "MGFX stress: " ..
                cols * rows ..
                  " changing FX-composed numbers/frame -- watch for BLANK cells (toggle mgfx_text_atlas to inspect slots)",
              "DermaDefaultBold",
              x0,
              y0 - 18,
              makeColor(255, 220, 120)
            )
          end
        )
      end
      printFn("[MGFX] text stress ON")
      return true
    end
  end
  do
    writeParamProbeMatrix = function(matrix, setUnpacked, columnPacked, variant)
      if variant == nil then
        variant = "view"
      end
      local pulse = math.sin(realTime() * 2.2) * 0.2 + 0.2
      if variant == "inv" then
        return setUnpacked(
          matrix,
          0.05,
          1.0,
          1.0,
          0.35 + pulse,
          0.85,
          0.05,
          0.72,
          1.0,
          1.0,
          0.85,
          0.05,
          0.05,
          1.0,
          1.0,
          1.0,
          1.0
        )
      else
        if columnPacked then
          return setUnpacked(
            matrix,
            1.0,
            0.05,
            0.05,
            1.0,
            0.05,
            1.0,
            0.05,
            1.0,
            0.05,
            0.05,
            1.0,
            pulse,
            1.0,
            1.0,
            1.0,
            1.0
          )
        else
          return setUnpacked(
            matrix,
            1.0,
            0.05,
            0.05,
            1.0,
            0.05,
            1.0,
            0.05,
            1.0,
            0.05,
            0.05,
            1.0,
            1.0,
            1.0,
            1.0,
            pulse,
            1.0
          )
        end
      end
    end
    setupParamProbeMatrix = function(mat, columnPacked)
      if not materialsPkg.matOK(mat) or paramProbeMatrix == nil or paramProbeSetUnpacked == nil then
        return false
      end
      writeParamProbeMatrix(paramProbeMatrix, paramProbeSetUnpacked, columnPacked)
      mat:SetMatrix("$viewprojmat", paramProbeMatrix)
      return true
    end
    setupNamedParamProbeMatrix = function(mat, matrix, setUnpacked, paramName, variant)
      if variant == nil then
        variant = "view"
      end
      if not materialsPkg.matOK(mat) or matrix == nil or setUnpacked == nil then
        return false
      end
      writeParamProbeMatrix(matrix, setUnpacked, true, variant)
      mat:SetMatrix(paramName, matrix)
      return true
    end
    drawParamProbeBlock = function(mat, x, y, w, h, columnPacked)
      if not setupParamProbeMatrix(mat, columnPacked) then
        return false
      end
      surfaceSetMaterial(mat)
      surfaceSetDrawColor(255, 255, 255, 255)
      surfaceDrawTexturedRectUV(x, y, w, h, -0.015625, -0.015625, 1.015625, 1.015625)
      return true
    end
    drawParamProbe = function(owner)
      local mat
      do
        local __lux_obj_owner_201 = owner
        local __lux_val_Materials_202 = nil
        if __lux_obj_owner_201 ~= nil then
          __lux_val_Materials_202 = __lux_obj_owner_201._Materials
        end
        local __lux_obj_Materials_203 = __lux_val_Materials_202
        local __lux_val_param_probe_204 = nil
        if __lux_obj_Materials_203 ~= nil then
          __lux_val_param_probe_204 = __lux_obj_Materials_203.param_probe
        end
        mat = __lux_val_param_probe_204
      end
      local x = 42
      local y = 300
      local w = 360
      local h = 76
      if not materialsPkg.matOK(mat) or paramProbeMatrix == nil or paramProbeSetUnpacked == nil then
        draw.SimpleText(
          "MGFX param probe unavailable",
          "DermaDefaultBold",
          x,
          y,
          makeColor(255, 90, 90)
        )
        return
      end
      draw.SimpleText("row-packed control", "DermaDefaultBold", x, y - 16, color_white)
      drawParamProbeBlock(mat, x, y, w, h, false)
      local y2 = y + h + 42
      draw.SimpleText("column-packed candidate", "DermaDefaultBold", x, y2 - 16, color_white)
      return drawParamProbeBlock(mat, x, y2, w, h, true)
    end
    toggleParamProbe = function(owner)
      paramProbeEnabled = not paramProbeEnabled
      if hookRemove ~= nil then
        hookRemove("HUDPaint", "MGFXParamProbe")
        hookRemove("HUDPaint", "MGFXParamProbeInv")
      end
      paramProbeInvEnabled = false
      if paramProbeEnabled and hookAdd ~= nil then
        hookAdd(
          "HUDPaint",
          "MGFXParamProbe",
          function()
            drawParamProbe(owner)
          end
        )
        printFn("[MGFX] param probe ON")
        return true
      end
      printFn("[MGFX] param probe OFF")
      return false
    end
    drawNamedParamProbeBlock = function(mat, matrix, setUnpacked, paramName, variant, x, y, w, h)
      if not setupNamedParamProbeMatrix(mat, matrix, setUnpacked, paramName, variant) then
        return false
      end
      surfaceSetMaterial(mat)
      surfaceSetDrawColor(255, 255, 255, 255)
      surfaceDrawTexturedRectUV(x, y, w, h, -0.015625, -0.015625, 1.015625, 1.015625)
      return true
    end
    drawParamProbeInv = function(owner)
      local materials
      do
        local __lux_obj_owner_205 = owner
        local __lux_val_Materials_206 = nil
        if __lux_obj_owner_205 ~= nil then
          __lux_val_Materials_206 = __lux_obj_owner_205._Materials
        end
        materials = __lux_val_Materials_206
        if materials == nil then
          materials = {}
        end
      end
      local matC11 = materials.param_probe
      local matC15 = materials.param_probe_inv
      local x = 42
      local y = 300
      local w = 360
      local h = 76
      if not materialsPkg.matOK(matC11) or not materialsPkg.matOK(matC15) or paramProbeMatrix == nil or paramProbeSetUnpacked == nil or paramProbeInvMatrix == nil or paramProbeInvSetUnpacked == nil then
        draw.SimpleText(
          "MGFX c15 param probe unavailable",
          "DermaDefaultBold",
          x,
          y,
          makeColor(255, 90, 90)
        )
        return
      end
      draw.SimpleText(
        "c11 / $viewprojmat: red, green, blue, yellow pulse",
        "DermaDefaultBold",
        x,
        y - 16,
        color_white
      )
      drawNamedParamProbeBlock(
        matC11,
        paramProbeMatrix,
        paramProbeSetUnpacked,
        "$viewprojmat",
        "view",
        x,
        y,
        w,
        h
      )
      local y2 = y + h + 42
      draw.SimpleText(
        "c15 / $invviewprojmat: cyan, magenta, amber, lime pulse",
        "DermaDefaultBold",
        x,
        y2 - 16,
        color_white
      )
      drawNamedParamProbeBlock(
        matC15,
        paramProbeInvMatrix,
        paramProbeInvSetUnpacked,
        "$invviewprojmat",
        "inv",
        x,
        y2,
        w,
        h
      )
      return draw.SimpleText(
        "if both blocks are correct and different, c15 is an independent matrix parameter page",
        "DermaDefault",
        x,
        y2 + h + 6,
        makeColor(210, 230, 240)
      )
    end
    toggleParamProbeInv = function(owner)
      paramProbeInvEnabled = not paramProbeInvEnabled
      if hookRemove ~= nil then
        hookRemove("HUDPaint", "MGFXParamProbeInv")
        hookRemove("HUDPaint", "MGFXParamProbe")
      end
      paramProbeEnabled = false
      if paramProbeInvEnabled and hookAdd ~= nil then
        hookAdd(
          "HUDPaint",
          "MGFXParamProbeInv",
          function()
            drawParamProbeInv(owner)
          end
        )
        printFn("[MGFX] c15 param probe ON: compare $viewprojmat/c11 with $invviewprojmat/c15")
        return true
      end
      printFn("[MGFX] c15 param probe OFF")
      return false
    end
    printBenchResult = function(name, iterations, elapsedMs, emptyMs, sink)
      local netMs
      do
        local __lux_tmp_emptyMs_207 = emptyMs
        if __lux_tmp_emptyMs_207 == nil then
          __lux_tmp_emptyMs_207 = 0
        end
        netMs = mathMax(0, elapsedMs - __lux_tmp_emptyMs_207)
      end
      return printFn(
        stringFormat(
          "[MGFX] param bench %-26s raw=%8.3fms net=%8.3fms %.3fus/iter sink=%.3f",
          name,
          elapsedMs,
          netMs,
          netMs * 1000 / mathMax(1, iterations),
          sink
        )
      )
    end
    runParamBenchSlice = function(test, mat, matrix, setUnpacked, first, last)
      local sink = 0
      if test == "empty" then
        for index = first, last do
          local value = index % 1024 * 0.0009765625
          sink = sink + value
        end
      else
        if test == "SetFloat x8" then
          for index = first, last do
            local value = index % 1024 * 0.0009765625
            mat:SetFloat("$c0_x", value)
            mat:SetFloat("$c0_y", value + 0.01)
            mat:SetFloat("$c0_z", value + 0.02)
            mat:SetFloat("$c0_w", value + 0.03)
            mat:SetFloat("$c1_x", value + 0.04)
            mat:SetFloat("$c1_y", value + 0.05)
            mat:SetFloat("$c1_z", value + 0.06)
            mat:SetFloat("$c1_w", value + 0.07)
            sink = sink + value
          end
        else
          if test == "SetFloat x16" then
            for index = first, last do
              local value = index % 1024 * 0.0009765625
              mat:SetFloat("$c0_x", value)
              mat:SetFloat("$c0_y", value + 0.01)
              mat:SetFloat("$c0_z", value + 0.02)
              mat:SetFloat("$c0_w", value + 0.03)
              mat:SetFloat("$c1_x", value + 0.04)
              mat:SetFloat("$c1_y", value + 0.05)
              mat:SetFloat("$c1_z", value + 0.06)
              mat:SetFloat("$c1_w", value + 0.07)
              mat:SetFloat("$c2_x", value + 0.08)
              mat:SetFloat("$c2_y", value + 0.09)
              mat:SetFloat("$c2_z", value + 0.10)
              mat:SetFloat("$c2_w", value + 0.11)
              mat:SetFloat("$c3_x", value + 0.12)
              mat:SetFloat("$c3_y", value + 0.13)
              mat:SetFloat("$c3_z", value + 0.14)
              mat:SetFloat("$c3_w", value + 0.15)
              sink = sink + value
            end
          else
            if test == "SetUnpacked only" then
              for index = first, last do
                local value = index % 1024 * 0.0009765625
                setUnpacked(
                  matrix,
                  value,
                  value + 0.04,
                  value + 0.08,
                  value + 0.12,
                  value + 0.01,
                  value + 0.05,
                  value + 0.09,
                  value + 0.13,
                  value + 0.02,
                  value + 0.06,
                  value + 0.10,
                  value + 0.14,
                  value + 0.03,
                  value + 0.07,
                  value + 0.11,
                  value + 0.15
                )
                sink = sink + value
              end
            else
              if test == "SetMatrix only" then
                for index = first, last do
                  local value = index % 1024 * 0.0009765625
                  mat:SetMatrix("$viewprojmat", matrix)
                  sink = sink + value
                end
              else
                if test == "SetInvMatrix only" then
                  for index = first, last do
                    local value = index % 1024 * 0.0009765625
                    mat:SetMatrix("$invviewprojmat", matrix)
                    sink = sink + value
                  end
                else
                  if test == "SetUnpacked + SetMatrix" then
                    for index = first, last do
                      local value = index % 1024 * 0.0009765625
                      setUnpacked(
                        matrix,
                        value,
                        value + 0.04,
                        value + 0.08,
                        value + 0.12,
                        value + 0.01,
                        value + 0.05,
                        value + 0.09,
                        value + 0.13,
                        value + 0.02,
                        value + 0.06,
                        value + 0.10,
                        value + 0.14,
                        value + 0.03,
                        value + 0.07,
                        value + 0.11,
                        value + 0.15
                      )
                      mat:SetMatrix("$viewprojmat", matrix)
                      sink = sink + value
                    end
                  else
                    if test == "SetUnpacked + SetInvMatrix" then
                      for index = first, last do
                        local value = index % 1024 * 0.0009765625
                        setUnpacked(
                          matrix,
                          value,
                          value + 0.04,
                          value + 0.08,
                          value + 0.12,
                          value + 0.01,
                          value + 0.05,
                          value + 0.09,
                          value + 0.13,
                          value + 0.02,
                          value + 0.06,
                          value + 0.10,
                          value + 0.14,
                          value + 0.03,
                          value + 0.07,
                          value + 0.11,
                          value + 0.15
                        )
                        mat:SetMatrix("$invviewprojmat", matrix)
                        sink = sink + value
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
      return sink
    end
    stopParamBench = function()
      if timerRemove ~= nil then
        timerRemove(paramBenchTimer)
      end
      printFn("[MGFX] param bench stopped")
      return true
    end
    runParamBench = function(owner, args)
      local materials
      do
        local __lux_obj_owner_208 = owner
        local __lux_val_Materials_209 = nil
        if __lux_obj_owner_208 ~= nil then
          __lux_val_Materials_209 = __lux_obj_owner_208._Materials
        end
        materials = __lux_val_Materials_209
        if materials == nil then
          materials = {}
        end
      end
      local mat = materials.param_probe_inv
      if mat == nil then
        mat = materials.param_probe
        if mat == nil then
          mat = materials.roundrect
        end
      end
      if not materialsPkg.matOK(mat) then
        printFn("[MGFX] param bench unavailable: material error")
        return false
      end
      local matrix = paramBenchMatrix
      local setUnpacked = paramBenchSetUnpacked
      if matrix == nil or setUnpacked == nil then
        printFn("[MGFX] param bench unavailable: Matrix:SetUnpacked missing")
        return false
      end
      if timerCreate == nil or timerRemove == nil or sysTime == nil then
        printFn("[MGFX] param bench unavailable: timer/SysTime missing")
        return false
      end
      local iterations
      do
        local __lux_obj_args_210 = args
        local __lux_val_args_212 = nil
        if __lux_obj_args_210 ~= nil then
          local __lux_key_211 = 1
          __lux_val_args_212 = __lux_obj_args_210[__lux_key_211]
        end
        local __lux_tmp_args_213 = toNumber(__lux_val_args_212)
        if __lux_tmp_args_213 == nil then
          __lux_tmp_args_213 = 3000
        end
        iterations = mathClamp(__lux_tmp_args_213, 250, 10000)
      end
      local roundCount
      do
        local __lux_obj_args_214 = args
        local __lux_val_args_216 = nil
        if __lux_obj_args_214 ~= nil then
          local __lux_key_215 = 2
          __lux_val_args_216 = __lux_obj_args_214[__lux_key_215]
        end
        local __lux_tmp_args_217 = toNumber(__lux_val_args_216)
        if __lux_tmp_args_217 == nil then
          __lux_tmp_args_217 = 2
        end
        roundCount = mathClamp(__lux_tmp_args_217, 1, 5)
      end
      local batchSize
      do
        local __lux_obj_args_218 = args
        local __lux_val_args_220 = nil
        if __lux_obj_args_218 ~= nil then
          local __lux_key_219 = 3
          __lux_val_args_220 = __lux_obj_args_218[__lux_key_219]
        end
        local __lux_tmp_args_221 = toNumber(__lux_val_args_220)
        if __lux_tmp_args_221 == nil then
          __lux_tmp_args_221 = 100
        end
        batchSize = mathClamp(__lux_tmp_args_221, 10, 250)
      end
      timerRemove(paramBenchTimer)
      local tests = {
        "empty",
        "SetFloat x8",
        "SetFloat x16",
        "SetUnpacked only",
        "SetMatrix only",
        "SetInvMatrix only",
        "SetUnpacked + SetMatrix",
        "SetUnpacked + SetInvMatrix",
      }
      local state = { round = 1, testIndex = 1, iter = 1, elapsedMs = 0, emptyMs = 0, sink = 0 }
      printFn(
        stringFormat(
          "[MGFX] param bench begin iterations=%d rounds=%d batch=%d material=%s",
          iterations,
          roundCount,
          batchSize,
          toString(mat)
        )
      )
      printFn(
        "[MGFX] param bench note: sliced across frames; use mgfx_param_bench_stop to cancel."
      )
      timerCreate(
        paramBenchTimer,
        0,
        0,
        function()
          local testName = tests[state.testIndex]
          if testName == nil then
            printFn("[MGFX] param bench end")
            timerRemove(paramBenchTimer)
            return
          end
          local last = mathMin(iterations, state.iter + batchSize - 1)
          local started = sysTime()
          state.sink = state.sink + runParamBenchSlice(testName, mat, matrix, setUnpacked, state.iter, last)
          state.elapsedMs = state.elapsedMs + (sysTime() - started) * 1000
          state.iter = last + 1
          if state.iter <= iterations then
            return
          end
          if testName == "empty" then
            state.emptyMs = state.elapsedMs
            printBenchResult(testName, iterations, state.elapsedMs, 0, state.sink)
          else
            printBenchResult(testName, iterations, state.elapsedMs, state.emptyMs, state.sink)
          end
          state.testIndex = state.testIndex + 1
          state.iter = 1
          state.elapsedMs = 0
          state.sink = 0
          if state.testIndex > #tests then
            state.round = state.round + 1
            if state.round > roundCount then
              printFn("[MGFX] param bench end")
              timerRemove(paramBenchTimer)
              return
            end
            state.testIndex = 1
            state.emptyMs = 0
            printFn(stringFormat("[MGFX] param bench round %d/%d", state.round, roundCount))
          end
        end
      )
      return true
    end
  end
  do
    selftest = function(owner)
      local status = shaderStatus(owner)
      local materials
      do
        local __lux_obj_owner_222 = owner
        local __lux_val_Materials_223 = nil
        if __lux_obj_owner_222 ~= nil then
          __lux_val_Materials_223 = __lux_obj_owner_222._Materials
        end
        materials = __lux_val_Materials_223
        if materials == nil then
          materials = {}
        end
      end
      local failed = 0
      printFn("[MGFX] selftest begin")
      printFn("[MGFX] version: " .. toString(status.version))
      do
        local __lux_tmp_224
        if status.loaded then
          __lux_tmp_224 = "loaded"
        else
          __lux_tmp_224 = "fallback"
        end
        printFn("[MGFX] shaders: " .. __lux_tmp_224)
      end
      for index = 1, #requiredMaterialKeys do
        local key = requiredMaterialKeys[index]
        local ok = materialsPkg.matOK(materials[key])
        if not ok then
          failed = failed + 1
        end
        do
          local __lux_tmp_225
          if ok then
            __lux_tmp_225 = "ok"
          else
            __lux_tmp_225 = "error"
          end
          printFn("[MGFX] material " .. key .. ": " .. __lux_tmp_225)
        end
      end
      for index = 1, #requiredApis do
        local key = requiredApis[index]
        local ok = isFunction(owner[key])
        if not ok then
          failed = failed + 1
        end
        do
          local __lux_tmp_226
          if ok then
            __lux_tmp_226 = "ok"
          else
            __lux_tmp_226 = "missing"
          end
          printFn("[MGFX] api " .. key .. ": " .. __lux_tmp_226)
        end
      end
      for index = 1, #requiredTargets do
        local key = requiredTargets[index]
        local ok = owner.TARGET ~= nil and owner.TARGET[key] ~= nil
        if not ok then
          failed = failed + 1
        end
        do
          local __lux_tmp_227
          if ok then
            __lux_tmp_227 = "ok"
          else
            __lux_tmp_227 = "missing"
          end
          printFn("[MGFX] target " .. key .. ": " .. __lux_tmp_227)
        end
      end
      printFn("[MGFX] selftest end failures=" .. toString(failed))
      return failed == 0
    end
    reloadMGFX = function(owner)
      local reload
      do
        local __lux_obj_owner_228 = owner
        local __lux_val_Reload_229 = nil
        if __lux_obj_owner_228 ~= nil then
          __lux_val_Reload_229 = __lux_obj_owner_228.Reload
        end
        reload = __lux_val_Reload_229
        if reload == nil then
          do
            local __lux_obj_owner_230 = owner
            local __lux_val_LuxReload_231 = nil
            if __lux_obj_owner_230 ~= nil then
              __lux_val_LuxReload_231 = __lux_obj_owner_230._LuxReload
            end
            reload = __lux_val_LuxReload_231
          end
        end
      end
      if reload == nil then
        printFn("[MGFX] reload unavailable: owner has no Lux reload hook")
        return false
      end
      printFn("[MGFX] reload begin")
      local ok, result = pcall(reload)
      if not ok then
        printFn("[MGFX] reload failed: " .. toString(result))
        return false
      end
      local status = shaderStatus(owner)
      printFn(
        "[MGFX] reload end version=" ..
          toString(status.version) .. " shaders=" .. toString(status.loaded)
      )
      return true
    end
    install = function(owner)
      do
        local __lux_tmp_AddCommand_232 = owner._AddCommand
        if __lux_tmp_AddCommand_232 == nil then
          __lux_tmp_AddCommand_232 = rawAddCommand
        end
        owner._AddCommand = __lux_tmp_AddCommand_232
      end
      owner._TextDemoStrings = textDemoStrings
      addCommand(
        owner,
        "mgfx_reload",
        function()
          return reloadMGFX(owner)
        end,
        "Reload Lux MGFX into the current API table."
      )
      addCommand(
        owner,
        "mgfx_hot_reload",
        function()
          return reloadMGFX(owner)
        end,
        "Reload Lux MGFX into the current API table."
      )
      addCommand(
        owner,
        "mgfx_status",
        function()
          return status(owner)
        end,
        "Print MGFX runtime status."
      )
      addCommand(
        owner,
        "mgfx_profile_status",
        function()
          return profileStatus(owner)
        end,
        "Print MGFX profiler rows."
      )
      addCommand(
        owner,
        "mgfx_profile_panels",
        function(_cmd, _argString, args)
          local __lux_obj_args_233 = args
          local __lux_val_args_235 = nil
          if __lux_obj_args_233 ~= nil then
            local __lux_key_234 = 1
            __lux_val_args_235 = __lux_obj_args_233[__lux_key_234]
          end
          return profilePanels(owner, toNumber(__lux_val_args_235))
        end,
        "Print MGFX panel/screen profiler rows."
      )
      addCommand(
        owner,
        "mgfx_profile_current",
        function(_cmd, _argString, args)
          local __lux_obj_args_236 = args
          local __lux_val_args_238 = nil
          if __lux_obj_args_236 ~= nil then
            local __lux_key_237 = 1
            __lux_val_args_238 = __lux_obj_args_236[__lux_key_237]
          end
          return profileCurrent(owner, toNumber(__lux_val_args_238))
        end,
        "Print recent MGFX profiler scopes."
      )
      addCommand(
        owner,
        "mgfx_profile_hud",
        function(_cmd, _argString, args)
          local __lux_obj_args_239 = args
          local __lux_val_args_241 = nil
          if __lux_obj_args_239 ~= nil then
            local __lux_key_240 = 1
            __lux_val_args_241 = __lux_obj_args_239[__lux_key_240]
          end
          local __lux_tmp_args_242 = __lux_val_args_241
          if __lux_tmp_args_242 == nil then
            __lux_tmp_args_242 = "toggle"
          end
          return toggleProfileHud(owner, __lux_tmp_args_242)
        end,
        "Toggle MGFX profiler HUD overlay."
      )
      addCommand(
        owner,
        "mgfx_profile_reset",
        function()
          return profileReset(owner)
        end,
        "Reset MGFX profiler rows."
      )
      addCommand(
        owner,
        "mgfx_text_status",
        function()
          return textStatusCommand(owner)
        end,
        "Print MGFX text renderer status."
      )
      addCommand(
        owner,
        "mgfx_text_cache_clear",
        function()
          return textCacheClear(owner)
        end,
        "Clear MGFX text measure cache."
      )
      addCommand(
        owner,
        "mgfx_text_composed_clear",
        function()
          return textComposedClear(owner)
        end,
        "Clear MGFX composed text cache."
      )
      addCommand(
        owner,
        "mgfx_text_atlas",
        function()
          return toggleAtlasDebug(owner)
        end,
        "Toggle MGFX text atlas debug overlay."
      )
      addCommand(
        owner,
        "mgfx_text_stress",
        function()
          return toggleTextStress(owner)
        end,
        "Toggle MGFX text stress overlay."
      )
      addCommand(
        owner,
        "mgfx_text_demo",
        function(_cmd, _argString, args)
          local __lux_obj_args_243 = args
          local __lux_val_args_245 = nil
          if __lux_obj_args_243 ~= nil then
            local __lux_key_244 = 1
            __lux_val_args_245 = __lux_obj_args_243[__lux_key_244]
          end
          local __lux_tmp_args_246 = __lux_val_args_245
          if __lux_tmp_args_246 == nil then
            __lux_tmp_args_246 = "toggle"
          end
          return toggleTextDemo(owner, __lux_tmp_args_246)
        end,
        "Toggle MGFX text demo overlay."
      )
      addCommand(
        owner,
        "mgfx_text_trace_demo",
        function()
          return traceTextDemo(owner)
        end,
        "Print MGFX text demo font/atlas route diagnostics."
      )
      addCommand(
        owner,
        "mgfx_param_probe",
        function()
          return toggleParamProbe(owner)
        end,
        "Toggle MGFX shader parameter probe."
      )
      addCommand(
        owner,
        "mgfx_param_probe_inv",
        function()
          return toggleParamProbeInv(owner)
        end,
        "Toggle MGFX c15 shader parameter probe."
      )
      addCommand(
        owner,
        "mgfx_param_bench_stop",
        function()
          return stopParamBench()
        end,
        "Stop MGFX shader parameter benchmark."
      )
      addCommand(
        owner,
        "mgfx_param_bench",
        function(_cmd, _argString, args)
          return runParamBench(owner, args)
        end,
        "Run MGFX shader parameter benchmark."
      )
      addCommand(
        owner,
        "mgfx_selftest",
        function()
          return selftest(owner)
        end,
        "Run MGFX API/material selftest."
      )
      owner.Status = function()
        return status(owner)
      end
      owner.SelfTest = function()
        return selftest(owner)
      end
      owner.ReloadCommand = function()
        return reloadMGFX(owner)
      end
      owner.ProfileStatus = function()
        return profileStatus(owner)
      end
      owner.ProfilePanels = function(limit)
        return profilePanels(owner, limit)
      end
      owner.ProfileCurrent = function(limit)
        return profileCurrent(owner, limit)
      end
      owner.ToggleProfileHud = function(mode)
        if mode == nil then
          mode = "toggle"
        end
        return toggleProfileHud(owner, mode)
      end
      owner.ResetProfileCommand = function()
        return profileReset(owner)
      end
      owner.ToggleTextDemo = function(mode)
        if mode == nil then
          mode = "toggle"
        end
        return toggleTextDemo(owner, mode)
      end
      owner.TraceTextDemo = function()
        return traceTextDemo(owner)
      end
      owner.ToggleTextStress = function()
        return toggleTextStress(owner)
      end
      owner.ToggleParamProbe = function()
        return toggleParamProbe(owner)
      end
      owner.ToggleParamProbeInv = function()
        return toggleParamProbeInv(owner)
      end
      owner.RunParamBench = function(args)
        return runParamBench(owner, args)
      end
      owner.StopParamBench = function()
        return stopParamBench()
      end
      owner._ConsoleCommands = commandNames
      return owner
    end
    uninstall = function(owner)
      for index = 1, #commandNames do
        removeCommand(commandNames[index])
      end
      if hookRemove ~= nil then
        hookRemove("HUDPaint", "MGFXTextDemo")
        hookRemove("HUDPaint", "MGFXTextStress")
        hookRemove("HUDPaint", "MGFXTextAtlasDebug")
        hookRemove("HUDPaint", profileHudHook)
        hookRemove("HUDPaint", "MGFXParamProbe")
        hookRemove("HUDPaint", "MGFXParamProbeInv")
      end
      if timerRemove ~= nil then
        timerRemove(paramBenchTimer)
      end
      commandNames = {}
      textDemoEnabled = false
      textStressEnabled = false
      atlasDebugEnabled = false
      profileHudEnabled = false
      paramProbeEnabled = false
      paramProbeInvEnabled = false
      return true
    end
  end
  
  __lux_exports.status = status
  __lux_exports.profileStatus = profileStatus
  __lux_exports.profilePanels = profilePanels
  __lux_exports.profileCurrent = profileCurrent
  __lux_exports.setProfileHud = setProfileHud
  __lux_exports.toggleProfileHud = toggleProfileHud
  __lux_exports.profileReset = profileReset
  __lux_exports.textStatusCommand = textStatusCommand
  __lux_exports.textCacheClear = textCacheClear
  __lux_exports.textComposedClear = textComposedClear
  __lux_exports.toggleTextDemo = toggleTextDemo
  __lux_exports.traceTextDemo = traceTextDemo
  __lux_exports.toggleAtlasDebug = toggleAtlasDebug
  __lux_exports.toggleTextStress = toggleTextStress
  __lux_exports.toggleParamProbe = toggleParamProbe
  __lux_exports.toggleParamProbeInv = toggleParamProbeInv
  __lux_exports.stopParamBench = stopParamBench
  __lux_exports.runParamBench = runParamBench
  __lux_exports.selftest = selftest
  __lux_exports.install = install
  __lux_exports.uninstall = uninstall
  
  return __lux_exports
end
