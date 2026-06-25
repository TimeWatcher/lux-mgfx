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
    local __lux_import_1 = __lux_import("lux/mgfx/materials#client")
    local materialsPkgImport = __lux_import_1
    materialsPkg = materialsPkgImport
    do
      local __lux_obj_2 = concommand
      local __lux_val_3 = nil
      if __lux_obj_2 ~= nil then
        __lux_val_3 = __lux_obj_2.Add
      end
      concommandAdd = __lux_val_3
    end
    do
      local __lux_obj_4 = concommand
      local __lux_val_5 = nil
      if __lux_obj_4 ~= nil then
        __lux_val_5 = __lux_obj_4.Remove
      end
      concommandRemove = __lux_val_5
    end
    createClientConVar = CreateClientConVar
    getConVar = GetConVar
    do
      local __lux_obj_6 = hook
      local __lux_val_7 = nil
      if __lux_obj_6 ~= nil then
        __lux_val_7 = __lux_obj_6.Add
      end
      hookAdd = __lux_val_7
    end
    do
      local __lux_obj_8 = hook
      local __lux_val_9 = nil
      if __lux_obj_8 ~= nil then
        __lux_val_9 = __lux_obj_8.Remove
      end
      hookRemove = __lux_val_9
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
      local __lux_obj_10 = surface
      local __lux_val_11 = nil
      if __lux_obj_10 ~= nil then
        __lux_val_11 = __lux_obj_10.CreateFont
      end
      surfaceCreateFont = __lux_val_11
    end
    do
      local __lux_obj_12 = surface
      local __lux_val_13 = nil
      if __lux_obj_12 ~= nil then
        __lux_val_13 = __lux_obj_12.DrawOutlinedRect
      end
      surfaceDrawOutlinedRect = __lux_val_13
    end
    do
      local __lux_obj_14 = surface
      local __lux_val_15 = nil
      if __lux_obj_14 ~= nil then
        __lux_val_15 = __lux_obj_14.DrawRect
      end
      surfaceDrawRect = __lux_val_15
    end
    do
      local __lux_obj_16 = surface
      local __lux_val_17 = nil
      if __lux_obj_16 ~= nil then
        __lux_val_17 = __lux_obj_16.DrawTexturedRectUV
      end
      surfaceDrawTexturedRectUV = __lux_val_17
    end
    do
      local __lux_obj_18 = surface
      local __lux_val_19 = nil
      if __lux_obj_18 ~= nil then
        __lux_val_19 = __lux_obj_18.SetDrawColor
      end
      surfaceSetDrawColor = __lux_val_19
    end
    do
      local __lux_obj_20 = surface
      local __lux_val_21 = nil
      if __lux_obj_20 ~= nil then
        __lux_val_21 = __lux_obj_20.SetMaterial
      end
      surfaceSetMaterial = __lux_val_21
    end
    sysTime = SysTime
    tableConcat = table.concat
    tableSort = table.sort
    do
      local __lux_obj_22 = timer
      local __lux_val_23 = nil
      if __lux_obj_22 ~= nil then
        __lux_val_23 = __lux_obj_22.Create
      end
      timerCreate = __lux_val_23
    end
    do
      local __lux_obj_24 = timer
      local __lux_val_25 = nil
      if __lux_obj_24 ~= nil then
        __lux_val_25 = __lux_obj_24.Remove
      end
      timerRemove = __lux_val_25
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
      local __lux_tmp_26
      if matrixCtor ~= nil then
        __lux_tmp_26 = matrixCtor()
      else
        __lux_tmp_26 = nil
      end
      paramProbeMatrix = __lux_tmp_26
    end
    do
      local __lux_obj_27 = paramProbeMatrix
      local __lux_val_28 = nil
      if __lux_obj_27 ~= nil then
        __lux_val_28 = __lux_obj_27.SetUnpacked
      end
      paramProbeSetUnpacked = __lux_val_28
    end
    do
      local __lux_tmp_29
      if matrixCtor ~= nil then
        __lux_tmp_29 = matrixCtor()
      else
        __lux_tmp_29 = nil
      end
      paramProbeInvMatrix = __lux_tmp_29
    end
    do
      local __lux_obj_30 = paramProbeInvMatrix
      local __lux_val_31 = nil
      if __lux_obj_30 ~= nil then
        __lux_val_31 = __lux_obj_30.SetUnpacked
      end
      paramProbeInvSetUnpacked = __lux_val_31
    end
    do
      local __lux_tmp_32
      if matrixCtor ~= nil then
        __lux_tmp_32 = matrixCtor()
      else
        __lux_tmp_32 = nil
      end
      paramBenchMatrix = __lux_tmp_32
    end
    do
      local __lux_obj_33 = paramBenchMatrix
      local __lux_val_34 = nil
      if __lux_obj_33 ~= nil then
        __lux_val_34 = __lux_obj_33.SetUnpacked
      end
      paramBenchSetUnpacked = __lux_val_34
    end
    paramBenchTimer = "MGFXParamBench"
    profileHudHook = "MGFXProfileHUD"
    profileHudX = 24
    profileHudY = 360
    profileHudRows = 4
    profileHudTopRows = 6
    do
      local __lux_tmp_35
      if createClientConVar ~= nil then
        __lux_tmp_35 = createClientConVar(
          "mgfx_text_demo_fx",
          "1",
          true,
          false,
          "MGFX text demo effect intensity."
        )
      else
        __lux_tmp_35 = nil
      end
      textDemoFx = __lux_tmp_35
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
      local __lux_tmp_36 = cvar ~= nil
      if __lux_tmp_36 then
        __lux_tmp_36 = cvar.GetBool ~= nil
      end
      if __lux_tmp_36 then
        return cvar:GetBool()
      end
      return fallback
    end
    ownerStats = function(owner)
      do
        local __lux_tmp_37 = owner.stats
        if __lux_tmp_37 == nil then
          __lux_tmp_37 = {}
        end
        owner.stats = __lux_tmp_37
      end
      do
        local __lux_tmp_38 = owner.stats.drawCommandCounts
        if __lux_tmp_38 == nil then
          __lux_tmp_38 = {}
        end
        owner.stats.drawCommandCounts = __lux_tmp_38
      end
      do
        local __lux_tmp_39 = owner.stats.drawImmediateCounts
        if __lux_tmp_39 == nil then
          __lux_tmp_39 = {}
        end
        owner.stats.drawImmediateCounts = __lux_tmp_39
      end
      do
        local __lux_tmp_40 = owner.stats.profileTimes
        if __lux_tmp_40 == nil then
          __lux_tmp_40 = {}
        end
        owner.stats.profileTimes = __lux_tmp_40
      end
      do
        local __lux_tmp_41 = owner.stats.profileCounts
        if __lux_tmp_41 == nil then
          __lux_tmp_41 = {}
        end
        owner.stats.profileCounts = __lux_tmp_41
      end
      return owner.stats
    end
    addCommand = function(owner, name, callback, helpText)
      local add
      do
        local __lux_obj_42 = owner
        local __lux_val_43 = nil
        if __lux_obj_42 ~= nil then
          __lux_val_43 = __lux_obj_42._AddCommand
        end
        local __lux_tmp_44 = __lux_val_43
        if __lux_tmp_44 == nil then
          __lux_tmp_44 = concommandAdd
        end
        add = __lux_tmp_44
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
      local __lux_tmp_45 = concommandRemove ~= nil
      if __lux_tmp_45 then
        __lux_tmp_45 = string.sub(name, 1, 5) == "mgfx_"
      end
      if __lux_tmp_45 then
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
        local __lux_tmp_46 = counts
        if __lux_tmp_46 == nil then
          __lux_tmp_46 = {}
        end
        for key, value in pairs(__lux_tmp_46) do
          local __lux_tmp_47 = value ~= nil
          if __lux_tmp_47 then
            __lux_tmp_47 = value ~= 0
          end
          if __lux_tmp_47 then
            parts[#parts + 1] = toString(key) .. "=" .. toString(value)
          end
        end
      end
      tableSort(parts)
      local __lux_tmp_48
      if #parts > 0 then
        __lux_tmp_48 = tableConcat(parts, " ")
      else
        __lux_tmp_48 = "none"
      end
      return printFn("[MGFX] " .. label .. ": " .. __lux_tmp_48)
    end
    shaderStatus = function(owner)
      local statusFn
      do
        local __lux_obj_49 = owner
        local __lux_val_50 = nil
        if __lux_obj_49 ~= nil then
          __lux_val_50 = __lux_obj_49.shaderStatus
        end
        statusFn = __lux_val_50
      end
      if statusFn ~= nil then
        return statusFn()
      end
      local __lux_obj_51 = owner
      local __lux_val_52 = nil
      if __lux_obj_51 ~= nil then
        __lux_val_52 = __lux_obj_51._MaterialState
      end
      return materialsPkg.shaderStatus(__lux_val_52)
    end
    profilerApi = function(owner)
      local __lux_obj_53 = owner
      local __lux_val_54 = nil
      if __lux_obj_53 ~= nil then
        __lux_val_54 = __lux_obj_53.Profiler
      end
      return __lux_val_54
    end
    profilerRegistry = function()
      local __lux_obj_55 = globalTable.MGFX
      local __lux_val_56 = nil
      if __lux_obj_55 ~= nil then
        __lux_val_56 = __lux_obj_55._ProfilerRegistry
      end
      local __lux_obj_57 = __lux_val_56
      local __lux_val_58 = nil
      if __lux_obj_57 ~= nil then
        __lux_val_58 = __lux_obj_57.items
      end
      return __lux_val_58
    end
    collectProfilerRows = function(owner, methodName, limit)
      local rows = {}
      local registry = profilerRegistry()
      if registry ~= nil then
        for _, item in pairs(registry) do
          local api
          do
            local __lux_obj_59 = item
            local __lux_val_60 = nil
            if __lux_obj_59 ~= nil then
              __lux_val_60 = __lux_obj_59.profiler
            end
            api = __lux_val_60
          end
          local method
          do
            local __lux_obj_61 = api
            local __lux_val_63 = nil
            if __lux_obj_61 ~= nil then
              local __lux_key_62 = methodName
              __lux_val_63 = __lux_obj_61[__lux_key_62]
            end
            method = __lux_val_63
          end
          if method ~= nil then
            local instanceRows = method(limit)
            do
              local __lux_tmp_64 = instanceRows
              if __lux_tmp_64 == nil then
                __lux_tmp_64 = {}
              end
              for index = 1, #__lux_tmp_64 do
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
          local __lux_obj_65 = profiler
          local __lux_val_67 = nil
          if __lux_obj_65 ~= nil then
            local __lux_key_66 = methodName
            __lux_val_67 = __lux_obj_65[__lux_key_66]
          end
          method = __lux_val_67
        end
        if method ~= nil then
          do
            local __lux_tmp_68 = method(limit)
            if __lux_tmp_68 == nil then
              __lux_tmp_68 = {}
            end
            rows = __lux_tmp_68
          end
        end
      end
      tableSort(
        rows,
        function(a, b)
          local av
          if methodName == "RecentScopes" then
            do
              local __lux_tmp_69 = a.last
              if __lux_tmp_69 == nil then
                __lux_tmp_69 = 0
              end
              av = __lux_tmp_69
            end
          else
            do
              local __lux_tmp_70 = a.avg
              if __lux_tmp_70 == nil then
                local __lux_tmp_71 = a.last
                if __lux_tmp_71 == nil then
                  __lux_tmp_71 = 0
                end
                __lux_tmp_70 = __lux_tmp_71
              end
              av = __lux_tmp_70
            end
          end
          local bv
          if methodName == "RecentScopes" then
            do
              local __lux_tmp_72 = b.last
              if __lux_tmp_72 == nil then
                __lux_tmp_72 = 0
              end
              bv = __lux_tmp_72
            end
          else
            do
              local __lux_tmp_73 = b.avg
              if __lux_tmp_73 == nil then
                local __lux_tmp_74 = b.last
                if __lux_tmp_74 == nil then
                  __lux_tmp_74 = 0
                end
                __lux_tmp_73 = __lux_tmp_74
              end
              bv = __lux_tmp_73
            end
          end
          if av == bv then
            local __lux_tmp_75 = a.name
            if __lux_tmp_75 == nil then
              __lux_tmp_75 = ""
            end
            local __lux_tmp_76 = b.name
            if __lux_tmp_76 == nil then
              __lux_tmp_76 = ""
            end
            local __lux_cmp_77 = false
            if toString(__lux_tmp_75) ~= nil and toString(__lux_tmp_76) ~= nil then
              __lux_cmp_77 = toString(__lux_tmp_75) < toString(__lux_tmp_76)
            end
            return __lux_cmp_77
          end
          return av > bv
        end
      )
      local numericLimit = toNumber(limit)
      local __lux_tmp_78 = numericLimit ~= nil
      if __lux_tmp_78 then
        __lux_tmp_78 = numericLimit > 0
      end
      if __lux_tmp_78 then
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
        local __lux_obj_79 = item
        local __lux_val_80 = nil
        if __lux_obj_79 ~= nil then
          __lux_val_80 = __lux_obj_79.profiler
        end
        if __lux_val_80 ~= nil then
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
          local __lux_obj_81 = item
          local __lux_val_82 = nil
          if __lux_obj_81 ~= nil then
            __lux_val_82 = __lux_obj_81.profiler
          end
          if __lux_val_82 ~= nil then
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
            local __lux_obj_83 = item
            local __lux_val_84 = nil
            if __lux_obj_83 ~= nil then
              __lux_val_84 = __lux_obj_83.profiler
            end
            local __lux_obj_85 = __lux_val_84
            local __lux_val_86 = nil
            if __lux_obj_85 ~= nil then
              __lux_val_86 = __lux_obj_85.Reset
            end
            reset = __lux_val_86
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
        local __lux_obj_87 = owner
        local __lux_val_88 = nil
        if __lux_obj_87 ~= nil then
          __lux_val_88 = __lux_obj_87.GetTextProfileSnapshot
        end
        snapshotFn = __lux_val_88
      end
      if snapshotFn ~= nil then
        snapshot = snapshotFn(false)
      end
      local __lux_tmp_89 = snapshot
      if __lux_tmp_89 == nil then
        __lux_tmp_89 = {}
      end
      return __lux_tmp_89
    end
    textRendererStatus = function(owner)
      local statusFn
      do
        local __lux_obj_90 = owner
        local __lux_val_91 = nil
        if __lux_obj_90 ~= nil then
          __lux_val_91 = __lux_obj_90.GetTextRendererStatus
        end
        statusFn = __lux_val_91
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
        local __lux_tmp_92
        if status.loaded then
          __lux_tmp_92 = "loaded"
        else
          __lux_tmp_92 = "fallback"
        end
        printFn("[MGFX] shaders: " .. __lux_tmp_92)
      end
      printFn("[MGFX] version: " .. toString(status.version))
      printFn("[MGFX] mount: " .. toString(status.mount))
      do
        local __lux_tmp_93 = fallback ~= nil
        if __lux_tmp_93 then
          __lux_tmp_93 = fallback:GetBool()
        end
        local __lux_tmp_94 = __lux_tmp_93
        if not __lux_tmp_94 then
          __lux_tmp_94 = false
        end
        printFn("[MGFX] force fallback: " .. toString(__lux_tmp_94))
      end
      do
        local __lux_tmp_95 = drawCounts ~= nil
        if __lux_tmp_95 then
          __lux_tmp_95 = drawCounts:GetBool()
        end
        local __lux_tmp_96 = __lux_tmp_95
        if not __lux_tmp_96 then
          __lux_tmp_96 = false
        end
        printFn("[MGFX] draw counts: " .. toString(__lux_tmp_96))
      end
      do
        local __lux_tmp_97 = stats.draws
        if __lux_tmp_97 == nil then
          __lux_tmp_97 = 0
        end
        local __lux_tmp_98 = stats.blurPasses
        if __lux_tmp_98 == nil then
          __lux_tmp_98 = 0
        end
        local __lux_tmp_99 = stats.fallbacks
        if __lux_tmp_99 == nil then
          __lux_tmp_99 = 0
        end
        local __lux_tmp_100 = stats.culled
        if __lux_tmp_100 == nil then
          __lux_tmp_100 = 0
        end
        printFn(
          "[MGFX] stats draws=" ..
            toString(__lux_tmp_97) ..
              " blur=" ..
                toString(__lux_tmp_98) ..
                  " fallback=" .. toString(__lux_tmp_99) .. " culled=" .. toString(__lux_tmp_100)
        )
      end
      countsLine("draw commands", stats.drawCommandCounts)
      countsLine("immediate draws", stats.drawImmediateCounts)
      countsLine("profile ms", stats.profileTimes)
      local text = textStatus(owner)
      local textRenderer = textRendererStatus(owner)
      do
        local __lux_tmp_101 = textRenderer.draws
        if __lux_tmp_101 == nil then
          local __lux_tmp_102 = text.draws
          if __lux_tmp_102 == nil then
            local __lux_tmp_103 = stats.textDraws
            if __lux_tmp_103 == nil then
              __lux_tmp_103 = 0
            end
            __lux_tmp_102 = __lux_tmp_103
          end
          __lux_tmp_101 = __lux_tmp_102
        end
        local __lux_tmp_104 = textRenderer.nativeDraws
        if __lux_tmp_104 == nil then
          local __lux_tmp_105 = stats.textNativeDraws
          if __lux_tmp_105 == nil then
            __lux_tmp_105 = 0
          end
          __lux_tmp_104 = __lux_tmp_105
        end
        local __lux_tmp_106 = textRenderer.composedDraws
        if __lux_tmp_106 == nil then
          local __lux_tmp_107 = stats.textComposedDraws
          if __lux_tmp_107 == nil then
            __lux_tmp_107 = 0
          end
          __lux_tmp_106 = __lux_tmp_107
        end
        local __lux_tmp_108 = text.measures
        if __lux_tmp_108 == nil then
          __lux_tmp_108 = 0
        end
        printFn(
          "[MGFX] text draws=" ..
            toString(__lux_tmp_101) ..
              " native=" ..
                toString(__lux_tmp_104) ..
                  " composed=" .. toString(__lux_tmp_106) .. " measures=" .. toString(__lux_tmp_108)
        )
      end
      do
        local __lux_tmp_109 = textRenderer.mode
        if __lux_tmp_109 == nil then
          __lux_tmp_109 = "n/a"
        end
        local __lux_tmp_110 = textRenderer.composedEnabled
        if __lux_tmp_110 == nil then
          __lux_tmp_110 = false
        end
        local __lux_tmp_111 = textRenderer.composedAtlasPages
        if __lux_tmp_111 == nil then
          __lux_tmp_111 = 0
        end
        local __lux_tmp_112 = textRenderer.composedEntries
        if __lux_tmp_112 == nil then
          __lux_tmp_112 = 0
        end
        printFn(
          "[MGFX] text renderer mode=" ..
            toString(__lux_tmp_109) ..
              " composed=" ..
                toString(__lux_tmp_110) ..
                  " atlasPages=" .. toString(__lux_tmp_111) .. " entries=" .. toString(__lux_tmp_112)
        )
      end
      printMaterialStatus(status)
      return status
    end
    printProfileRows = function(label, rows, rollingRows, profiler)
      printFn("[MGFX] " .. label)
      local __lux_tmp_113 = rows == nil
      if not __lux_tmp_113 then
        __lux_tmp_113 = #rows == 0
      end
      if __lux_tmp_113 then
        printFn("[MGFX]   none")
        return
      end
      local formatRows
      do
        local __lux_obj_114 = profiler
        local __lux_val_115 = nil
        if __lux_obj_114 ~= nil then
          __lux_val_115 = __lux_obj_114.FormatRows
        end
        formatRows = __lux_val_115
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
      local __lux_tmp_116 = rows == nil
      if not __lux_tmp_116 then
        __lux_tmp_116 = #rows == 0
      end
      if __lux_tmp_116 then
        printFn("[MGFX]   none")
        return
      end
      local formatRows
      do
        local __lux_obj_117 = profiler
        local __lux_val_118 = nil
        if __lux_obj_117 ~= nil then
          __lux_val_118 = __lux_obj_117.FormatScopeRows
        end
        formatRows = __lux_val_118
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
        local __lux_tmp_119 = items
        if __lux_tmp_119 == nil then
          __lux_tmp_119 = {}
        end
        for index = 1, #__lux_tmp_119 do
          if index > maxParts then
            break
          end
          local item = items[index]
          local ms
          if useAvg then
            do
              local __lux_tmp_120 = item.avg
              if __lux_tmp_120 == nil then
                local __lux_tmp_121 = item.last
                if __lux_tmp_121 == nil then
                  __lux_tmp_121 = 0
                end
                __lux_tmp_120 = __lux_tmp_121
              end
              ms = __lux_tmp_120
            end
          else
            do
              local __lux_tmp_122 = item.last
              if __lux_tmp_122 == nil then
                local __lux_tmp_123 = item.avg
                if __lux_tmp_123 == nil then
                  __lux_tmp_123 = 0
                end
                __lux_tmp_122 = __lux_tmp_123
              end
              ms = __lux_tmp_122
            end
          end
          local count
          do
            local __lux_tmp_124 = item.avgCount
            if __lux_tmp_124 == nil then
              local __lux_tmp_125 = item.count
              if __lux_tmp_125 == nil then
                __lux_tmp_125 = 0
              end
              __lux_tmp_124 = __lux_tmp_125
            end
            count = __lux_tmp_124
          end
          do
            local __lux_tmp_126 = item.name
            if __lux_tmp_126 == nil then
              __lux_tmp_126 = "?"
            end
            parts[#parts + 1] = stringFormat("%s %.2f/%d", __lux_tmp_126, ms, count)
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
      local __lux_tmp_127 = rows == nil
      if not __lux_tmp_127 then
        __lux_tmp_127 = #rows == 0
      end
      if __lux_tmp_127 then
        printFn("[MGFX]   none")
        return
      end
      for index = 1, #rows do
        local row = rows[index]
        local stats
        do
          local __lux_tmp_128 = row.stats
          if __lux_tmp_128 == nil then
            __lux_tmp_128 = {}
          end
          stats = __lux_tmp_128
        end
        do
          local __lux_tmp_129 = row.name
          if __lux_tmp_129 == nil then
            local __lux_tmp_130 = row.instance
            if __lux_tmp_130 == nil then
              __lux_tmp_130 = "runtime"
            end
            __lux_tmp_129 = __lux_tmp_130
          end
          local __lux_tmp_131 = row.last
          if __lux_tmp_131 == nil then
            __lux_tmp_131 = 0
          end
          local __lux_tmp_132 = row.avg
          if __lux_tmp_132 == nil then
            __lux_tmp_132 = 0
          end
          local __lux_tmp_133 = row.max
          if __lux_tmp_133 == nil then
            __lux_tmp_133 = 0
          end
          local __lux_tmp_134 = row.count
          if __lux_tmp_134 == nil then
            __lux_tmp_134 = 0
          end
          local __lux_tmp_135 = row.avgCount
          if __lux_tmp_135 == nil then
            __lux_tmp_135 = 0
          end
          local __lux_tmp_136 = stats.draws
          if __lux_tmp_136 == nil then
            __lux_tmp_136 = 0
          end
          local __lux_tmp_137 = stats.blurPasses
          if __lux_tmp_137 == nil then
            __lux_tmp_137 = 0
          end
          local __lux_tmp_138 = stats.textDraws
          if __lux_tmp_138 == nil then
            __lux_tmp_138 = 0
          end
          local __lux_tmp_139 = stats.textComposedBakes
          if __lux_tmp_139 == nil then
            __lux_tmp_139 = 0
          end
          local __lux_tmp_140 = stats.fallbacks
          if __lux_tmp_140 == nil then
            __lux_tmp_140 = 0
          end
          local __lux_tmp_141 = row.samples
          if __lux_tmp_141 == nil then
            __lux_tmp_141 = 0
          end
          printFn(
            stringFormat(
              "[MGFX]   %s last=%.3f avg=%.3f max=%.3f scopes=%d avgScopes=%.1f draws=%d blur=%d text=%d bake=%d fallback=%d samples=%d",
              __lux_tmp_129,
              __lux_tmp_131,
              __lux_tmp_132,
              __lux_tmp_133,
              __lux_tmp_134,
              __lux_tmp_135,
              __lux_tmp_136,
              __lux_tmp_137,
              __lux_tmp_138,
              __lux_tmp_139,
              __lux_tmp_140,
              __lux_tmp_141
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
      do
        local __lux_tmp_142 = enabled ~= nil
        if __lux_tmp_142 then
          __lux_tmp_142 = enabled:GetBool()
        end
        local __lux_tmp_143 = __lux_tmp_142
        if not __lux_tmp_143 then
          __lux_tmp_143 = false
        end
        local __lux_tmp_144 = window ~= nil
        if __lux_tmp_144 then
          __lux_tmp_144 = window:GetInt()
        end
        local __lux_tmp_145 = __lux_tmp_144
        if not __lux_tmp_145 then
          __lux_tmp_145 = "n/a"
        end
        local __lux_tmp_146 = top ~= nil
        if __lux_tmp_146 then
          __lux_tmp_146 = top:GetInt()
        end
        local __lux_tmp_147 = __lux_tmp_146
        if not __lux_tmp_147 then
          __lux_tmp_147 = "n/a"
        end
        printFn(
          "[MGFX] profiler enabled=" ..
            toString(__lux_tmp_143) ..
              " window=" ..
                toString(__lux_tmp_145) ..
                  " top=" .. toString(__lux_tmp_147) .. " instances=" .. toString(profilerInstanceCount())
        )
      end
      local __lux_tmp_148 = profiler == nil
      if __lux_tmp_148 then
        __lux_tmp_148 = profilerInstanceCount() == 0
      end
      if __lux_tmp_148 then
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
      local __lux_tmp_149 = profiler == nil
      if __lux_tmp_149 then
        __lux_tmp_149 = profilerInstanceCount() == 0
      end
      if __lux_tmp_149 then
        printFn("[MGFX] profiler unavailable")
        return false
      end
      local rows = collectProfilerRows(owner, "ScopeRows", limit)
      printProfileScopes("profile panel/screen rolling", rows, true, profiler)
      return true
    end
    profileCurrent = function(owner, limit)
      local profiler = formatProfiler(owner)
      local __lux_tmp_150 = profiler == nil
      if __lux_tmp_150 then
        __lux_tmp_150 = profilerInstanceCount() == 0
      end
      if __lux_tmp_150 then
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
          local __lux_tmp_151 = textValue
          if __lux_tmp_151 == nil then
            __lux_tmp_151 = ""
          end
          local __lux_tmp_152 = font
          if __lux_tmp_152 == nil then
            __lux_tmp_152 = "DermaDefault"
          end
          local __lux_tmp_153 = color
          if __lux_tmp_153 == nil then
            __lux_tmp_153 = color_white
          end
          local __lux_tmp_154 = align
          if __lux_tmp_154 == nil then
            __lux_tmp_154 = TEXT_ALIGN_LEFT
          end
          drawSimpleText(
            toString(__lux_tmp_151),
            __lux_tmp_152,
            x,
            y,
            __lux_tmp_153,
            __lux_tmp_154,
            TEXT_ALIGN_TOP
          )
        end
      end
    end
    shortHotspotName = function(name)
      local text
      do
        local __lux_tmp_155 = name
        if __lux_tmp_155 == nil then
          __lux_tmp_155 = "?"
        end
        text = toString(__lux_tmp_155)
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
      local __lux_tmp_156 = items == nil
      if not __lux_tmp_156 then
        __lux_tmp_156 = #items == 0
      end
      if __lux_tmp_156 then
        hudText("none", "DermaDefault", x + 18, y, makeColor(145, 160, 170))
        return y + 16
      end
      do
        local __lux_tmp_157 = maxRows
        if __lux_tmp_157 == nil then
          __lux_tmp_157 = profileHudTopRows
        end
        maxRows = mathMin(__lux_tmp_157, #items)
      end
      for index = 1, maxRows do
        local item = items[index]
        hudText(stringFormat("%02d", index), "DermaDefault", x, y, rowColor)
        hudText(shortHotspotName(item.name), "DermaDefault", x + 30, y, rowColor)
        do
          local __lux_tmp_158 = item.avg
          if __lux_tmp_158 == nil then
            local __lux_tmp_159 = item.last
            if __lux_tmp_159 == nil then
              __lux_tmp_159 = 0
            end
            __lux_tmp_158 = __lux_tmp_159
          end
          hudText(
            stringFormat("%.2f", __lux_tmp_158),
            "DermaDefault",
            x + 330,
            y,
            rowColor,
            TEXT_ALIGN_RIGHT
          )
        end
        do
          local __lux_tmp_160 = item.last
          if __lux_tmp_160 == nil then
            local __lux_tmp_161 = item.avg
            if __lux_tmp_161 == nil then
              __lux_tmp_161 = 0
            end
            __lux_tmp_160 = __lux_tmp_161
          end
          hudText(
            stringFormat("%.2f", __lux_tmp_160),
            "DermaDefault",
            x + 395,
            y,
            rowColor,
            TEXT_ALIGN_RIGHT
          )
        end
        do
          local __lux_tmp_162 = item.max
          if __lux_tmp_162 == nil then
            __lux_tmp_162 = 0
          end
          hudText(
            stringFormat("%.2f", __lux_tmp_162),
            "DermaDefault",
            x + 460,
            y,
            rowColor,
            TEXT_ALIGN_RIGHT
          )
        end
        do
          local __lux_tmp_163 = item.avgCount
          if __lux_tmp_163 == nil then
            local __lux_tmp_164 = item.count
            if __lux_tmp_164 == nil then
              __lux_tmp_164 = 0
            end
            __lux_tmp_163 = __lux_tmp_164
          end
          hudText(
            stringFormat("%.1f", __lux_tmp_163),
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
      local __lux_tmp_165 = profiler == nil
      if __lux_tmp_165 then
        __lux_tmp_165 = profilerInstanceCount() == 0
      end
      if __lux_tmp_165 then
        return
      end
      local rows = collectProfilerRows(owner, "InstanceRows", profileHudRows)
      local width = 1260
      local blockH = 112 + profileHudTopRows * 15
      local headerH = 42
      local height = headerH + mathMax(1, #rows) * blockH + 18
      local x = profileHudX
      local y = profileHudY
      local __lux_tmp_166 = surfaceSetDrawColor ~= nil
      if __lux_tmp_166 then
        __lux_tmp_166 = surfaceDrawRect ~= nil
      end
      if __lux_tmp_166 then
        surfaceSetDrawColor(5, 8, 12, 218)
        surfaceDrawRect(x, y, width, height)
      end
      local __lux_tmp_167 = surfaceSetDrawColor ~= nil
      if __lux_tmp_167 then
        __lux_tmp_167 = surfaceDrawOutlinedRect ~= nil
      end
      if __lux_tmp_167 then
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
      do
        local __lux_tmp_168 = enabled ~= nil
        if __lux_tmp_168 then
          __lux_tmp_168 = enabled:GetBool()
        end
        local __lux_tmp_169 = __lux_tmp_168
        if not __lux_tmp_169 then
          __lux_tmp_169 = false
        end
        local __lux_tmp_170 = drawCounts ~= nil
        if __lux_tmp_170 then
          __lux_tmp_170 = drawCounts:GetBool()
        end
        local __lux_tmp_171 = __lux_tmp_170
        if not __lux_tmp_171 then
          __lux_tmp_171 = false
        end
        hudText(
          "runtime total + API hotspots  profile=" ..
            toString(__lux_tmp_169) ..
              "  counts=" ..
                toString(__lux_tmp_171) .. "  instances=" .. toString(profilerInstanceCount()),
          "DermaDefault",
          x + 170,
          y + 8,
          makeColor(205, 220, 226)
        )
      end
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
        local stats
        do
          local __lux_tmp_172 = row.stats
          if __lux_tmp_172 == nil then
            __lux_tmp_172 = {}
          end
          stats = __lux_tmp_172
        end
        local hot
        do
          local __lux_tmp_173 = row.last
          if __lux_tmp_173 == nil then
            __lux_tmp_173 = 0
          end
          hot = __lux_tmp_173 >= 2
        end
        local rowColor
        if hot then
          rowColor = makeColor(255, 206, 128)
        else
          rowColor = makeColor(210, 224, 232)
        end
        local name
        do
          local __lux_tmp_174 = row.name
          if __lux_tmp_174 == nil then
            local __lux_tmp_175 = row.key
            if __lux_tmp_175 == nil then
              __lux_tmp_175 = "scope"
            end
            __lux_tmp_174 = __lux_tmp_175
          end
          name = toString(__lux_tmp_174)
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
          local __lux_tmp_176 = row.last
          if __lux_tmp_176 == nil then
            __lux_tmp_176 = 0
          end
          local __lux_tmp_177 = row.avg
          if __lux_tmp_177 == nil then
            __lux_tmp_177 = 0
          end
          local __lux_tmp_178 = row.max
          if __lux_tmp_178 == nil then
            __lux_tmp_178 = 0
          end
          local __lux_tmp_179 = row.avgCount
          if __lux_tmp_179 == nil then
            local __lux_tmp_180 = row.count
            if __lux_tmp_180 == nil then
              __lux_tmp_180 = 0
            end
            __lux_tmp_179 = __lux_tmp_180
          end
          hudText(
            stringFormat(
              "total last %.2fms   avg %.2fms   max %.2fms   scopes %.0f/frame",
              __lux_tmp_176,
              __lux_tmp_177,
              __lux_tmp_178,
              __lux_tmp_179
            ),
            "DermaDefaultBold",
            x + 430,
            rowY,
            rowColor
          )
        end
        rowY = rowY + 17
        do
          local __lux_tmp_181 = stats.draws
          if __lux_tmp_181 == nil then
            __lux_tmp_181 = 0
          end
          local __lux_tmp_182 = stats.blurPasses
          if __lux_tmp_182 == nil then
            __lux_tmp_182 = 0
          end
          local __lux_tmp_183 = stats.textDraws
          if __lux_tmp_183 == nil then
            __lux_tmp_183 = 0
          end
          local __lux_tmp_184 = stats.textComposedBakes
          if __lux_tmp_184 == nil then
            __lux_tmp_184 = 0
          end
          local __lux_tmp_185 = stats.fallbacks
          if __lux_tmp_185 == nil then
            __lux_tmp_185 = 0
          end
          hudText(
            stringFormat(
              "draws %d   blur %d   text %d   bakes %d   fallback %d",
              __lux_tmp_181,
              __lux_tmp_182,
              __lux_tmp_183,
              __lux_tmp_184,
              __lux_tmp_185
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
        local __lux_tmp_186
        if profileHudEnabled then
          __lux_tmp_186 = "ON"
        else
          __lux_tmp_186 = "OFF"
        end
        printFn("[MGFX] profile hud " .. __lux_tmp_186)
      end
      return profileHudEnabled
    end
    toggleProfileHud = function(owner, mode)
      if mode == nil then
        mode = "toggle"
      end
      local __lux_tmp_187 = mode == "1"
      if not __lux_tmp_187 then
        __lux_tmp_187 = mode == "on"
      end
      local __lux_tmp_188 = __lux_tmp_187
      if not __lux_tmp_188 then
        __lux_tmp_188 = mode == "true"
      end
      if __lux_tmp_188 then
        return setProfileHud(owner, true)
      end
      local __lux_tmp_189 = mode == "0"
      if not __lux_tmp_189 then
        __lux_tmp_189 = mode == "off"
      end
      local __lux_tmp_190 = __lux_tmp_189
      if not __lux_tmp_190 then
        __lux_tmp_190 = mode == "false"
      end
      if __lux_tmp_190 then
        return setProfileHud(owner, false)
      end
      return setProfileHud(owner, not profileHudEnabled)
    end
    profileReset = function(owner)
      local count = resetAllProfilers()
      if count == 0 then
        local profiler = profilerApi(owner)
        local __lux_tmp_191 = profiler ~= nil
        if __lux_tmp_191 then
          __lux_tmp_191 = profiler.Reset ~= nil
        end
        if __lux_tmp_191 then
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
        local __lux_tmp_192 = toNumber(status.composedAtlasFill)
        if __lux_tmp_192 == nil then
          __lux_tmp_192 = 0
        end
        fillPct = mathFloor(__lux_tmp_192 * 100 + 0.5)
      end
      do
        local __lux_tmp_193 = status.mode
        if __lux_tmp_193 == nil then
          __lux_tmp_193 = "n/a"
        end
        local __lux_tmp_194 = status.composedEnabled
        if __lux_tmp_194 == nil then
          __lux_tmp_194 = false
        end
        local __lux_tmp_195 = status.composedFailed
        if __lux_tmp_195 == nil then
          __lux_tmp_195 = false
        end
        printFn(
          "[MGFX] text mode=" ..
            toString(__lux_tmp_193) ..
              " composed=" .. toString(__lux_tmp_194) .. " failed=" .. toString(__lux_tmp_195)
        )
      end
      do
        local __lux_tmp_196 = status.draws
        if __lux_tmp_196 == nil then
          local __lux_tmp_197 = snapshot.draws
          if __lux_tmp_197 == nil then
            local __lux_tmp_198 = stats.textDraws
            if __lux_tmp_198 == nil then
              __lux_tmp_198 = 0
            end
            __lux_tmp_197 = __lux_tmp_198
          end
          __lux_tmp_196 = __lux_tmp_197
        end
        local __lux_tmp_199 = status.nativeDraws
        if __lux_tmp_199 == nil then
          local __lux_tmp_200 = stats.textNativeDraws
          if __lux_tmp_200 == nil then
            __lux_tmp_200 = 0
          end
          __lux_tmp_199 = __lux_tmp_200
        end
        local __lux_tmp_201 = status.shaderDraws
        if __lux_tmp_201 == nil then
          local __lux_tmp_202 = stats.textShaderDraws
          if __lux_tmp_202 == nil then
            __lux_tmp_202 = 0
          end
          __lux_tmp_201 = __lux_tmp_202
        end
        local __lux_tmp_203 = status.composedDraws
        if __lux_tmp_203 == nil then
          local __lux_tmp_204 = stats.textComposedDraws
          if __lux_tmp_204 == nil then
            __lux_tmp_204 = 0
          end
          __lux_tmp_203 = __lux_tmp_204
        end
        printFn(
          "[MGFX] text draws=" ..
            toString(__lux_tmp_196) ..
              " native=" ..
                toString(__lux_tmp_199) ..
                  " shader=" .. toString(__lux_tmp_201) .. " composed=" .. toString(__lux_tmp_203)
        )
      end
      do
        local __lux_tmp_205 = stats.textQueuedBatches
        if __lux_tmp_205 == nil then
          __lux_tmp_205 = 0
        end
        local __lux_tmp_206 = stats.textQueuedRecords
        if __lux_tmp_206 == nil then
          __lux_tmp_206 = 0
        end
        printFn(
          "[MGFX] text queued batches=" ..
            toString(__lux_tmp_205) .. " records=" .. toString(__lux_tmp_206)
        )
      end
      do
        local __lux_tmp_207 = stats.textComposedBatchDraws
        if __lux_tmp_207 == nil then
          __lux_tmp_207 = 0
        end
        local __lux_tmp_208 = stats.textComposedBatchedRecords
        if __lux_tmp_208 == nil then
          __lux_tmp_208 = 0
        end
        printFn(
          "[MGFX] text batch draws=" ..
            toString(__lux_tmp_207) .. " records=" .. toString(__lux_tmp_208)
        )
      end
      do
        local __lux_tmp_209 = stats.textComposedRequests
        if __lux_tmp_209 == nil then
          __lux_tmp_209 = 0
        end
        local __lux_tmp_210 = stats.textComposedBatches
        if __lux_tmp_210 == nil then
          __lux_tmp_210 = 0
        end
        local __lux_tmp_211 = stats.textComposedReadyBatches
        if __lux_tmp_211 == nil then
          __lux_tmp_211 = 0
        end
        local __lux_tmp_212 = stats.textComposedFallbackBatches
        if __lux_tmp_212 == nil then
          __lux_tmp_212 = 0
        end
        local __lux_tmp_213 = stats.textComposedFallbackRecords
        if __lux_tmp_213 == nil then
          __lux_tmp_213 = 0
        end
        local __lux_tmp_214 = stats.textComposedPrewarmFails
        if __lux_tmp_214 == nil then
          __lux_tmp_214 = 0
        end
        local __lux_tmp_215 = stats.textComposedPrewarmRestarts
        if __lux_tmp_215 == nil then
          __lux_tmp_215 = 0
        end
        printFn(
          "[MGFX] text composer route requests=" ..
            toString(__lux_tmp_209) ..
              " batches=" ..
                toString(__lux_tmp_210) ..
                  " readyBatches=" ..
                    toString(__lux_tmp_211) ..
                      " fallbackBatches=" ..
                        toString(__lux_tmp_212) ..
                          " fallbackRecords=" ..
                            toString(__lux_tmp_213) ..
                              " prewarmFails=" ..
                                toString(__lux_tmp_214) .. " prewarmRestarts=" .. toString(__lux_tmp_215)
        )
      end
      do
        local __lux_tmp_216 = stats.textEntryCacheHits
        if __lux_tmp_216 == nil then
          __lux_tmp_216 = 0
        end
        local __lux_tmp_217 = stats.textEntryCacheMisses
        if __lux_tmp_217 == nil then
          __lux_tmp_217 = 0
        end
        printFn(
          "[MGFX] text entry cache hit/miss=" ..
            toString(__lux_tmp_216) .. "/" .. toString(__lux_tmp_217)
        )
      end
      do
        local __lux_tmp_218 = stats.textMeasureHits
        if __lux_tmp_218 == nil then
          __lux_tmp_218 = 0
        end
        local __lux_tmp_219 = stats.textMeasureMisses
        if __lux_tmp_219 == nil then
          __lux_tmp_219 = 0
        end
        local __lux_tmp_220 = stats.textCacheSize
        if __lux_tmp_220 == nil then
          __lux_tmp_220 = 0
        end
        printFn(
          "[MGFX] text measure hit/miss=" ..
            toString(__lux_tmp_218) ..
              "/" .. toString(__lux_tmp_219) .. " cache=" .. toString(__lux_tmp_220)
        )
      end
      do
        local __lux_tmp_221 = status.composedEnabled
        if __lux_tmp_221 == nil then
          __lux_tmp_221 = false
        end
        local __lux_tmp_222 = status.fontCount
        if __lux_tmp_222 == nil then
          __lux_tmp_222 = 0
        end
        local __lux_tmp_223 = status.composedAtlasW
        if __lux_tmp_223 == nil then
          __lux_tmp_223 = 0
        end
        local __lux_tmp_224 = status.composedAtlasH
        if __lux_tmp_224 == nil then
          __lux_tmp_224 = 0
        end
        local __lux_tmp_225 = status.composedAtlasPages
        if __lux_tmp_225 == nil then
          __lux_tmp_225 = 0
        end
        local __lux_tmp_226 = status.composedAtlasMaxPages
        if __lux_tmp_226 == nil then
          __lux_tmp_226 = 0
        end
        local __lux_tmp_227 = status.composedEntries
        if __lux_tmp_227 == nil then
          local __lux_tmp_228 = stats.textComposedEntries
          if __lux_tmp_228 == nil then
            __lux_tmp_228 = 0
          end
          __lux_tmp_227 = __lux_tmp_228
        end
        local __lux_tmp_229 = status.styleCount
        if __lux_tmp_229 == nil then
          __lux_tmp_229 = 0
        end
        local __lux_tmp_230 = status.styleStackDepth
        if __lux_tmp_230 == nil then
          __lux_tmp_230 = 0
        end
        local __lux_tmp_231 = status.composedFailed
        if __lux_tmp_231 == nil then
          __lux_tmp_231 = false
        end
        printFn(
          "[MGFX] text composer enabled=" ..
            toString(__lux_tmp_221) ..
              " aliases=" ..
                toString(__lux_tmp_222) ..
                  " atlas=" ..
                    toString(__lux_tmp_223) ..
                      "x" ..
                        toString(__lux_tmp_224) ..
                          " pages=" ..
                            toString(__lux_tmp_225) ..
                              "/" ..
                                toString(__lux_tmp_226) ..
                                  " fill=" ..
                                    toString(fillPct) ..
                                      "% entries=" ..
                                        toString(__lux_tmp_227) ..
                                          " styles=" ..
                                            toString(__lux_tmp_229) ..
                                              " stack=" .. toString(__lux_tmp_230) .. " failed=" .. toString(__lux_tmp_231)
        )
      end
      do
        local __lux_tmp_232 = status.composedBakes
        if __lux_tmp_232 == nil then
          local __lux_tmp_233 = stats.textComposedBakes
          if __lux_tmp_233 == nil then
            __lux_tmp_233 = 0
          end
          __lux_tmp_232 = __lux_tmp_233
        end
        local __lux_tmp_234 = status.composedBlits
        if __lux_tmp_234 == nil then
          local __lux_tmp_235 = stats.textComposedBlits
          if __lux_tmp_235 == nil then
            __lux_tmp_235 = 0
          end
          __lux_tmp_234 = __lux_tmp_235
        end
        local __lux_tmp_236 = stats.textComposedFallbackRecords
        if __lux_tmp_236 == nil then
          __lux_tmp_236 = 0
        end
        printFn(
          "[MGFX] text compose bakes=" ..
            toString(__lux_tmp_232) ..
              " blits=" .. toString(__lux_tmp_234) .. " fallbackRecords=" .. toString(__lux_tmp_236)
        )
      end
      return status
    end
    textCacheClear = function(owner)
      local clearMeasure
      do
        local __lux_obj_237 = owner
        local __lux_val_238 = nil
        if __lux_obj_237 ~= nil then
          __lux_val_238 = __lux_obj_237.ClearTextMeasureCache
        end
        clearMeasure = __lux_val_238
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
        local __lux_obj_239 = owner
        local __lux_val_240 = nil
        if __lux_obj_239 ~= nil then
          __lux_val_240 = __lux_obj_239.ClearTextComposedCache
        end
        clearComposed = __lux_val_240
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
        local __lux_obj_241 = owner
        local __lux_val_242 = nil
        if __lux_obj_241 ~= nil then
          __lux_val_242 = __lux_obj_241.RegisterTextFont
        end
        register = __lux_val_242
      end
      if register == nil then
        return false
      end
      local ok = true
      do
        local __lux_tmp_243 = register(
          "MGFXTextDemoTitle",
          { face = "Bahnschrift", size = 34, weight = 650, lineHeight = 42 }
        )
        if __lux_tmp_243 then
          __lux_tmp_243 = ok
        end
        ok = __lux_tmp_243
      end
      do
        local __lux_tmp_244 = register(
          "MGFXTextDemoBody",
          { face = "Bahnschrift", size = 18, weight = 520, lineHeight = 24 }
        )
        if __lux_tmp_244 then
          __lux_tmp_244 = ok
        end
        ok = __lux_tmp_244
      end
      do
        local __lux_tmp_245 = register(
          "MGFXTextDemoSmall",
          { face = TEXT_DEMO_CJK_FACE, size = 15, weight = 400, lineHeight = 22 }
        )
        if __lux_tmp_245 then
          __lux_tmp_245 = ok
        end
        ok = __lux_tmp_245
      end
      do
        local __lux_tmp_246 = register(
          "MGFXTextDemoCJK",
          { face = TEXT_DEMO_CJK_FACE, size = 18, weight = 400, lineHeight = 26 }
        )
        if __lux_tmp_246 then
          __lux_tmp_246 = ok
        end
        ok = __lux_tmp_246
      end
      do
        local __lux_tmp_247 = register(
          "MGFXTextDemoNum",
          { face = "Bahnschrift", size = 26, weight = 700, lineHeight = 32 }
        )
        if __lux_tmp_247 then
          __lux_tmp_247 = ok
        end
        ok = __lux_tmp_247
      end
      textDemoFontsReady = ok == true
      return textDemoFontsReady
    end
    drawTextDemo = function(owner)
      ensureTextDemoFonts(owner)
      local sw = ScrW()
      local sh = ScrH()
      local strong
      do
        local __lux_tmp_248 = textDemoFx ~= nil
        if __lux_tmp_248 then
          __lux_tmp_248 = textDemoFx:GetBool()
        end
        local __lux_tmp_249 = __lux_tmp_248
        if not __lux_tmp_249 then
          __lux_tmp_249 = false
        end
        strong = __lux_tmp_249
      end
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
      local composedEnabled
      do
        local __lux_tmp_250 = owner.TextComposedEnabled ~= nil
        if __lux_tmp_250 then
          __lux_tmp_250 = owner.TextComposedEnabled()
        end
        composedEnabled = __lux_tmp_250
      end
      local composedLabel
      if composedEnabled then
        composedLabel = "on"
      else
        composedLabel = "off"
      end
      do
        local __lux_tmp_251 = stats.textShaderDraws
        if __lux_tmp_251 == nil then
          local __lux_tmp_252 = status.shaderDraws
          if __lux_tmp_252 == nil then
            __lux_tmp_252 = 0
          end
          __lux_tmp_251 = __lux_tmp_252
        end
        local __lux_tmp_253 = stats.textNativeDraws
        if __lux_tmp_253 == nil then
          local __lux_tmp_254 = status.nativeDraws
          if __lux_tmp_254 == nil then
            __lux_tmp_254 = 0
          end
          __lux_tmp_253 = __lux_tmp_254
        end
        local __lux_tmp_255 = stats.textComposedBakes
        if __lux_tmp_255 == nil then
          local __lux_tmp_256 = status.composedBakes
          if __lux_tmp_256 == nil then
            __lux_tmp_256 = 0
          end
          __lux_tmp_255 = __lux_tmp_256
        end
        local __lux_tmp_257 = stats.textComposedBlits
        if __lux_tmp_257 == nil then
          local __lux_tmp_258 = status.composedBlits
          if __lux_tmp_258 == nil then
            __lux_tmp_258 = 0
          end
          __lux_tmp_257 = __lux_tmp_258
        end
        local __lux_tmp_259 = status.composedEntries
        if __lux_tmp_259 == nil then
          local __lux_tmp_260 = stats.textComposedEntries
          if __lux_tmp_260 == nil then
            __lux_tmp_260 = 0
          end
          __lux_tmp_259 = __lux_tmp_260
        end
        draw.SimpleText(
          stringFormat(
            "text composed:%d native:%d bakes:%d blits:%d entries:%d fx:%s",
            __lux_tmp_251,
            __lux_tmp_253,
            __lux_tmp_255,
            __lux_tmp_257,
            __lux_tmp_259,
            fxLabel
          ),
          "DermaDefault",
          56,
          500,
          makeColor(210, 230, 235)
        )
      end
      local __lux_tmp_261 = stats.textComposedBakes
      if __lux_tmp_261 == nil then
        local __lux_tmp_262 = status.composedBakes
        if __lux_tmp_262 == nil then
          __lux_tmp_262 = 0
        end
        __lux_tmp_261 = __lux_tmp_262
      end
      local __lux_tmp_263 = stats.textComposedBlits
      if __lux_tmp_263 == nil then
        local __lux_tmp_264 = status.composedBlits
        if __lux_tmp_264 == nil then
          __lux_tmp_264 = 0
        end
        __lux_tmp_263 = __lux_tmp_264
      end
      local __lux_tmp_265 = stats.textComposedEntries
      if __lux_tmp_265 == nil then
        local __lux_tmp_266 = status.composedEntries
        if __lux_tmp_266 == nil then
          __lux_tmp_266 = 0
        end
        __lux_tmp_265 = __lux_tmp_266
      end
      local __lux_tmp_267 = stats.textComposedEvicts
      if __lux_tmp_267 == nil then
        local __lux_tmp_268 = status.composedEvicts
        if __lux_tmp_268 == nil then
          __lux_tmp_268 = 0
        end
        __lux_tmp_267 = __lux_tmp_268
      end
      return draw.SimpleText(
        stringFormat(
          "composed bakes:%d blits:%d entries:%d evicts:%d  (mgfx_text_composed %s)",
          __lux_tmp_261,
          __lux_tmp_263,
          __lux_tmp_265,
          __lux_tmp_267,
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
      local __lux_tmp_269 = mode == "0"
      if not __lux_tmp_269 then
        __lux_tmp_269 = mode == "off"
      end
      local __lux_tmp_270 = __lux_tmp_269
      if not __lux_tmp_270 then
        __lux_tmp_270 = mode == "close"
      end
      local __lux_tmp_271 = __lux_tmp_270
      if not __lux_tmp_271 then
        local __lux_tmp_272 = mode == "toggle"
        if __lux_tmp_272 then
          __lux_tmp_272 = textDemoEnabled
        end
        __lux_tmp_271 = __lux_tmp_272
      end
      if __lux_tmp_271 then
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
        local __lux_obj_273 = owner
        local __lux_val_274 = nil
        if __lux_obj_273 ~= nil then
          __lux_val_274 = __lux_obj_273.DebugResolveText
        end
        resolve = __lux_val_274
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
          local __lux_obj_275 = info
          local __lux_val_276 = nil
          if __lux_obj_275 ~= nil then
            __lux_val_276 = __lux_obj_275.missing
          end
          local __lux_tmp_277 = __lux_val_276
          if __lux_tmp_277 == nil then
            __lux_tmp_277 = {}
          end
          missing = __lux_tmp_277
        end
        do
          local __lux_obj_278 = info
          local __lux_val_279 = nil
          if __lux_obj_278 ~= nil then
            __lux_val_279 = __lux_obj_278.atlasKey
          end
          local __lux_obj_280 = info
          local __lux_val_281 = nil
          if __lux_obj_280 ~= nil then
            __lux_val_281 = __lux_obj_280.kind
          end
          local __lux_obj_282 = info
          local __lux_val_283 = nil
          if __lux_obj_282 ~= nil then
            __lux_val_283 = __lux_obj_282.routeAtlas
          end
          local __lux_obj_284 = info
          local __lux_val_285 = nil
          if __lux_obj_284 ~= nil then
            __lux_val_285 = __lux_obj_284.routeKind
          end
          printFn(
            stringFormat(
              "[MGFX] demo text %d font=%s atlas=%s kind=%s route=%s routeKind=%s missing=%d",
              index,
              toString(item[2]),
              toString(__lux_val_279),
              toString(__lux_val_281),
              toString(__lux_val_283),
              toString(__lux_val_285),
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
        local __lux_obj_286 = owner
        local __lux_val_287 = nil
        if __lux_obj_286 ~= nil then
          __lux_val_287 = __lux_obj_286.DebugDrawTextAtlas
        end
        debugDraw = __lux_val_287
      end
      local __lux_tmp_288 = hookAdd ~= nil
      if __lux_tmp_288 then
        __lux_tmp_288 = debugDraw ~= nil
      end
      if __lux_tmp_288 then
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
        local __lux_obj_289 = owner
        local __lux_val_290 = nil
        if __lux_obj_289 ~= nil then
          __lux_val_290 = __lux_obj_289.RegisterTextFont
        end
        register = __lux_val_290
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
        setUnpacked(
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
          setUnpacked(
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
          setUnpacked(
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
      local __lux_tmp_291 = not materialsPkg.matOK(mat)
      if not __lux_tmp_291 then
        __lux_tmp_291 = paramProbeMatrix == nil
      end
      local __lux_tmp_292 = __lux_tmp_291
      if not __lux_tmp_292 then
        __lux_tmp_292 = paramProbeSetUnpacked == nil
      end
      if __lux_tmp_292 then
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
      local __lux_tmp_293 = not materialsPkg.matOK(mat)
      if not __lux_tmp_293 then
        __lux_tmp_293 = matrix == nil
      end
      local __lux_tmp_294 = __lux_tmp_293
      if not __lux_tmp_294 then
        __lux_tmp_294 = setUnpacked == nil
      end
      if __lux_tmp_294 then
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
        local __lux_obj_295 = owner
        local __lux_val_296 = nil
        if __lux_obj_295 ~= nil then
          __lux_val_296 = __lux_obj_295._Materials
        end
        local __lux_obj_297 = __lux_val_296
        local __lux_val_298 = nil
        if __lux_obj_297 ~= nil then
          __lux_val_298 = __lux_obj_297.param_probe
        end
        mat = __lux_val_298
      end
      local x = 42
      local y = 300
      local w = 360
      local h = 76
      local __lux_tmp_299 = not materialsPkg.matOK(mat)
      if not __lux_tmp_299 then
        __lux_tmp_299 = paramProbeMatrix == nil
      end
      local __lux_tmp_300 = __lux_tmp_299
      if not __lux_tmp_300 then
        __lux_tmp_300 = paramProbeSetUnpacked == nil
      end
      if __lux_tmp_300 then
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
      local __lux_tmp_301 = paramProbeEnabled
      if __lux_tmp_301 then
        __lux_tmp_301 = hookAdd ~= nil
      end
      if __lux_tmp_301 then
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
        local __lux_obj_302 = owner
        local __lux_val_303 = nil
        if __lux_obj_302 ~= nil then
          __lux_val_303 = __lux_obj_302._Materials
        end
        local __lux_tmp_304 = __lux_val_303
        if __lux_tmp_304 == nil then
          __lux_tmp_304 = {}
        end
        materials = __lux_tmp_304
      end
      local matC11 = materials.param_probe
      local matC15 = materials.param_probe_inv
      local x = 42
      local y = 300
      local w = 360
      local h = 76
      local __lux_tmp_305 = not materialsPkg.matOK(matC11)
      if not __lux_tmp_305 then
        __lux_tmp_305 = not materialsPkg.matOK(matC15)
      end
      local __lux_tmp_306 = __lux_tmp_305
      if not __lux_tmp_306 then
        __lux_tmp_306 = paramProbeMatrix == nil
      end
      local __lux_tmp_307 = __lux_tmp_306
      if not __lux_tmp_307 then
        __lux_tmp_307 = paramProbeSetUnpacked == nil
      end
      local __lux_tmp_308 = __lux_tmp_307
      if not __lux_tmp_308 then
        __lux_tmp_308 = paramProbeInvMatrix == nil
      end
      local __lux_tmp_309 = __lux_tmp_308
      if not __lux_tmp_309 then
        __lux_tmp_309 = paramProbeInvSetUnpacked == nil
      end
      if __lux_tmp_309 then
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
      local __lux_tmp_310 = paramProbeInvEnabled
      if __lux_tmp_310 then
        __lux_tmp_310 = hookAdd ~= nil
      end
      if __lux_tmp_310 then
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
        local __lux_tmp_311 = emptyMs
        if __lux_tmp_311 == nil then
          __lux_tmp_311 = 0
        end
        netMs = mathMax(0, elapsedMs - __lux_tmp_311)
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
        local __lux_obj_312 = owner
        local __lux_val_313 = nil
        if __lux_obj_312 ~= nil then
          __lux_val_313 = __lux_obj_312._Materials
        end
        local __lux_tmp_314 = __lux_val_313
        if __lux_tmp_314 == nil then
          __lux_tmp_314 = {}
        end
        materials = __lux_tmp_314
      end
      local mat
      do
        local __lux_tmp_315 = materials.param_probe_inv
        if __lux_tmp_315 == nil then
          local __lux_tmp_316 = materials.param_probe
          if __lux_tmp_316 == nil then
            __lux_tmp_316 = materials.roundrect
          end
          __lux_tmp_315 = __lux_tmp_316
        end
        mat = __lux_tmp_315
      end
      if not materialsPkg.matOK(mat) then
        printFn("[MGFX] param bench unavailable: material error")
        return false
      end
      local matrix = paramBenchMatrix
      local setUnpacked = paramBenchSetUnpacked
      local __lux_tmp_317 = matrix == nil
      if not __lux_tmp_317 then
        __lux_tmp_317 = setUnpacked == nil
      end
      if __lux_tmp_317 then
        printFn("[MGFX] param bench unavailable: Matrix:SetUnpacked missing")
        return false
      end
      local __lux_tmp_318 = timerCreate == nil
      if not __lux_tmp_318 then
        __lux_tmp_318 = timerRemove == nil
      end
      local __lux_tmp_319 = __lux_tmp_318
      if not __lux_tmp_319 then
        __lux_tmp_319 = sysTime == nil
      end
      if __lux_tmp_319 then
        printFn("[MGFX] param bench unavailable: timer/SysTime missing")
        return false
      end
      local iterations
      do
        local __lux_obj_320 = args
        local __lux_val_322 = nil
        if __lux_obj_320 ~= nil then
          local __lux_key_321 = 1
          __lux_val_322 = __lux_obj_320[__lux_key_321]
        end
        local __lux_tmp_323 = toNumber(__lux_val_322)
        if __lux_tmp_323 == nil then
          __lux_tmp_323 = 3000
        end
        iterations = mathClamp(__lux_tmp_323, 250, 10000)
      end
      local roundCount
      do
        local __lux_obj_324 = args
        local __lux_val_326 = nil
        if __lux_obj_324 ~= nil then
          local __lux_key_325 = 2
          __lux_val_326 = __lux_obj_324[__lux_key_325]
        end
        local __lux_tmp_327 = toNumber(__lux_val_326)
        if __lux_tmp_327 == nil then
          __lux_tmp_327 = 2
        end
        roundCount = mathClamp(__lux_tmp_327, 1, 5)
      end
      local batchSize
      do
        local __lux_obj_328 = args
        local __lux_val_330 = nil
        if __lux_obj_328 ~= nil then
          local __lux_key_329 = 3
          __lux_val_330 = __lux_obj_328[__lux_key_329]
        end
        local __lux_tmp_331 = toNumber(__lux_val_330)
        if __lux_tmp_331 == nil then
          __lux_tmp_331 = 100
        end
        batchSize = mathClamp(__lux_tmp_331, 10, 250)
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
        local __lux_obj_332 = owner
        local __lux_val_333 = nil
        if __lux_obj_332 ~= nil then
          __lux_val_333 = __lux_obj_332._Materials
        end
        local __lux_tmp_334 = __lux_val_333
        if __lux_tmp_334 == nil then
          __lux_tmp_334 = {}
        end
        materials = __lux_tmp_334
      end
      local failed = 0
      printFn("[MGFX] selftest begin")
      printFn("[MGFX] version: " .. toString(status.version))
      do
        local __lux_tmp_335
        if status.loaded then
          __lux_tmp_335 = "loaded"
        else
          __lux_tmp_335 = "fallback"
        end
        printFn("[MGFX] shaders: " .. __lux_tmp_335)
      end
      for index = 1, #requiredMaterialKeys do
        local key = requiredMaterialKeys[index]
        local ok = materialsPkg.matOK(materials[key])
        if not ok then
          failed = failed + 1
        end
        do
          local __lux_tmp_336
          if ok then
            __lux_tmp_336 = "ok"
          else
            __lux_tmp_336 = "error"
          end
          printFn("[MGFX] material " .. key .. ": " .. __lux_tmp_336)
        end
      end
      for index = 1, #requiredApis do
        local key = requiredApis[index]
        local ok = isFunction(owner[key])
        if not ok then
          failed = failed + 1
        end
        do
          local __lux_tmp_337
          if ok then
            __lux_tmp_337 = "ok"
          else
            __lux_tmp_337 = "missing"
          end
          printFn("[MGFX] api " .. key .. ": " .. __lux_tmp_337)
        end
      end
      for index = 1, #requiredTargets do
        local key = requiredTargets[index]
        local ok
        do
          local __lux_tmp_338 = owner.TARGET ~= nil
          if __lux_tmp_338 then
            __lux_tmp_338 = owner.TARGET[key] ~= nil
          end
          ok = __lux_tmp_338
        end
        if not ok then
          failed = failed + 1
        end
        do
          local __lux_tmp_339
          if ok then
            __lux_tmp_339 = "ok"
          else
            __lux_tmp_339 = "missing"
          end
          printFn("[MGFX] target " .. key .. ": " .. __lux_tmp_339)
        end
      end
      printFn("[MGFX] selftest end failures=" .. toString(failed))
      return failed == 0
    end
    reloadMGFX = function(owner)
      local reload
      do
        local __lux_obj_340 = owner
        local __lux_val_341 = nil
        if __lux_obj_340 ~= nil then
          __lux_val_341 = __lux_obj_340.Reload
        end
        local __lux_tmp_342 = __lux_val_341
        if __lux_tmp_342 == nil then
          local __lux_obj_343 = owner
          local __lux_val_344 = nil
          if __lux_obj_343 ~= nil then
            __lux_val_344 = __lux_obj_343._LuxReload
          end
          __lux_tmp_342 = __lux_val_344
        end
        reload = __lux_tmp_342
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
        local __lux_tmp_345 = owner._AddCommand
        if __lux_tmp_345 == nil then
          __lux_tmp_345 = rawAddCommand
        end
        owner._AddCommand = __lux_tmp_345
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
          local __lux_obj_346 = args
          local __lux_val_348 = nil
          if __lux_obj_346 ~= nil then
            local __lux_key_347 = 1
            __lux_val_348 = __lux_obj_346[__lux_key_347]
          end
          return profilePanels(owner, toNumber(__lux_val_348))
        end,
        "Print MGFX panel/screen profiler rows."
      )
      addCommand(
        owner,
        "mgfx_profile_current",
        function(_cmd, _argString, args)
          local __lux_obj_349 = args
          local __lux_val_351 = nil
          if __lux_obj_349 ~= nil then
            local __lux_key_350 = 1
            __lux_val_351 = __lux_obj_349[__lux_key_350]
          end
          return profileCurrent(owner, toNumber(__lux_val_351))
        end,
        "Print recent MGFX profiler scopes."
      )
      addCommand(
        owner,
        "mgfx_profile_hud",
        function(_cmd, _argString, args)
          local __lux_obj_352 = args
          local __lux_val_354 = nil
          if __lux_obj_352 ~= nil then
            local __lux_key_353 = 1
            __lux_val_354 = __lux_obj_352[__lux_key_353]
          end
          local __lux_tmp_355 = __lux_val_354
          if __lux_tmp_355 == nil then
            __lux_tmp_355 = "toggle"
          end
          return toggleProfileHud(owner, __lux_tmp_355)
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
          local __lux_obj_356 = args
          local __lux_val_358 = nil
          if __lux_obj_356 ~= nil then
            local __lux_key_357 = 1
            __lux_val_358 = __lux_obj_356[__lux_key_357]
          end
          local __lux_tmp_359 = __lux_val_358
          if __lux_tmp_359 == nil then
            __lux_tmp_359 = "toggle"
          end
          return toggleTextDemo(owner, __lux_tmp_359)
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
