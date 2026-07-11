return function(__lux_import)
  local __lux_exports = {}
  local createClientConVar
  local sysTime
  local mathMax
  local tableConcat
  local tableEmpty
  local tableRemove
  local tableSort
  local stringFormat
  local stringMatch
  local toBool
  local toNumber
  local toString
  local typeOf
  local cvarsLib
  local debugLib
  local globalTable
  local stringSub
  local frameNumber
  local RECENT_SCOPE_LIMIT
  local scalarStatKeys
  local tableStatKeys
  local broadProfileLabels
  local makeConVar
  local clearTable
  local copyCounts
  local addCountsInto
  local copyScalarStats
  local snapshotStats
  local diffCounts
  local diffStats
  local sumCounts
  local topRowsFromCounts
  local topRowsFromBuckets
  local formatCallsite
  local panelLabel
  local scopeKey
  local scopeRowFromBucket
  local sourceInstanceName
  local create
  local install
  do
    createClientConVar = CreateClientConVar
    sysTime = SysTime
    mathMax = math.max
    tableConcat = table.concat
    tableEmpty = table.Empty
    tableRemove = table.remove
    tableSort = table.sort
    stringFormat = string.format
    stringMatch = string.match
    toBool = tobool
    toNumber = tonumber
    toString = tostring
    typeOf = type
    cvarsLib = cvars
    debugLib = debug
    globalTable = _G
    stringSub = string.sub
    frameNumber = FrameNumber
    RECENT_SCOPE_LIMIT = 96
    scalarStatKeys = {
      "draws",
      "blurPasses",
      "blurCaptures",
      "blurReuses",
      "fallbacks",
      "culled",
      "gradientLutFillHits",
      "textQueuedBatches",
      "textQueuedRecords",
      "textDraws",
      "textNativeDraws",
      "textShaderDraws",
      "textComposedDraws",
      "textComposedBatchDraws",
      "textComposedBatchedRecords",
      "textComposedFaceDraws",
      "textComposedFxDraws",
      "textComposedBakes",
      "textComposedBlits",
      "textComposedRequests",
      "textComposedBatches",
      "textComposedReadyBatches",
      "textComposedFallbackBatches",
      "textComposedFallbackRecords",
      "textComposedPrewarmFails",
      "textComposedPrewarmRestarts",
      "textFallbacks",
      "textDataDraws",
      "textDataBatches",
      "textAtlasUploads",
      "textAtlasGlyphs",
      "textAtlasResets",
    }
    tableStatKeys = {
      "drawCommandCounts",
      "drawImmediateCounts",
      "profileTimes",
      "profileCounts",
      "textProfileTimes",
      "textProfileCounts",
    }
    broadProfileLabels = { frame = true, paintBuild = true, paintTotal = true }
    makeConVar = function(name, defaultValue, help)
      if createClientConVar == nil then
        return nil
      end
      return createClientConVar(name, defaultValue, true, false, help)
    end
    clearTable = function(items)
      if items == nil then
        return
      end
      if tableEmpty ~= nil then
        tableEmpty(items)
        return
      end
      for key, _ in pairs(items) do
        items[key] = nil
      end
    end
    copyCounts = function(source)
      local out = {}
      do
        local __lux_tmp_source_1 = source
        if __lux_tmp_source_1 == nil then
          __lux_tmp_source_1 = {}
        end
        for key, value in pairs(__lux_tmp_source_1) do
          do
            local __lux_tmp_value_2 = toNumber(value)
            if __lux_tmp_value_2 == nil then
              __lux_tmp_value_2 = 0
            end
            out[key] = __lux_tmp_value_2
          end
        end
      end
      return out
    end
    addCountsInto = function(out, source)
      do
        local __lux_tmp_source_3 = source
        if __lux_tmp_source_3 == nil then
          __lux_tmp_source_3 = {}
        end
        for key, value in pairs(__lux_tmp_source_3) do
          do
            local __lux_tmp_key_4 = out[key]
            if __lux_tmp_key_4 == nil then
              __lux_tmp_key_4 = 0
            end
            local __lux_tmp_value_5 = toNumber(value)
            if __lux_tmp_value_5 == nil then
              __lux_tmp_value_5 = 0
            end
            out[key] = __lux_tmp_key_4 + __lux_tmp_value_5
          end
        end
      end
    end
    copyScalarStats = function(source)
      local out = {}
      for index = 1, #scalarStatKeys do
        local key = scalarStatKeys[index]
        do
          local __lux_obj_source_6 = source
          local __lux_val_source_8 = nil
          if __lux_obj_source_6 ~= nil then
            local __lux_key_key_7 = key
            __lux_val_source_8 = __lux_obj_source_6[__lux_key_key_7]
          end
          local __lux_tmp_key_9 = toNumber(__lux_val_source_8)
          if __lux_tmp_key_9 == nil then
            __lux_tmp_key_9 = 0
          end
          out[key] = __lux_tmp_key_9
        end
      end
      return out
    end
    snapshotStats = function(target)
      local stats = target.stats
      if stats == nil then
        stats = {}
      end
      local out = {}
      for index = 1, #scalarStatKeys do
        local key = scalarStatKeys[index]
        do
          local __lux_tmp_key_10 = toNumber(stats[key])
          if __lux_tmp_key_10 == nil then
            __lux_tmp_key_10 = 0
          end
          out[key] = __lux_tmp_key_10
        end
      end
      for index = 1, #tableStatKeys do
        local key = tableStatKeys[index]
        out[key] = copyCounts(stats[key])
      end
      return out
    end
    diffCounts = function(after, before)
      local out = {}
      local total = 0
      do
        local __lux_tmp_after_11 = after
        if __lux_tmp_after_11 == nil then
          __lux_tmp_after_11 = {}
        end
        for key, value in pairs(__lux_tmp_after_11) do
          local delta
          do
            local __lux_tmp_value_12 = toNumber(value)
            if __lux_tmp_value_12 == nil then
              __lux_tmp_value_12 = 0
            end
            local __lux_obj_before_13 = before
            local __lux_val_before_15 = nil
            if __lux_obj_before_13 ~= nil then
              local __lux_key_key_14 = key
              __lux_val_before_15 = __lux_obj_before_13[__lux_key_key_14]
            end
            local __lux_tmp_key_16 = toNumber(__lux_val_before_15)
            if __lux_tmp_key_16 == nil then
              __lux_tmp_key_16 = 0
            end
            delta = __lux_tmp_value_12 - __lux_tmp_key_16
          end
          if delta ~= 0 then
            out[key] = delta
            total = total + delta
          end
        end
      end
      do
        local __lux_tmp_before_17 = before
        if __lux_tmp_before_17 == nil then
          __lux_tmp_before_17 = {}
        end
        for key, value in pairs(__lux_tmp_before_17) do
          if after == nil or after[key] == nil then
            local delta
            do
              local __lux_tmp_value_18 = toNumber(value)
              if __lux_tmp_value_18 == nil then
                __lux_tmp_value_18 = 0
              end
              delta = -__lux_tmp_value_18
            end
            if delta ~= 0 then
              out[key] = delta
              total = total + delta
            end
          end
        end
      end
      return out, total
    end
    diffStats = function(target, startedStats)
      local now = snapshotStats(target)
      local out = {}
      for index = 1, #scalarStatKeys do
        local key = scalarStatKeys[index]
        do
          local __lux_tmp_key_19 = now[key]
          if __lux_tmp_key_19 == nil then
            __lux_tmp_key_19 = 0
          end
          local __lux_obj_startedStats_20 = startedStats
          local __lux_val_startedStats_22 = nil
          if __lux_obj_startedStats_20 ~= nil then
            local __lux_key_key_21 = key
            __lux_val_startedStats_22 = __lux_obj_startedStats_20[__lux_key_key_21]
          end
          local __lux_tmp_key_23 = __lux_val_startedStats_22
          if __lux_tmp_key_23 == nil then
            __lux_tmp_key_23 = 0
          end
          out[key] = __lux_tmp_key_19 - __lux_tmp_key_23
        end
      end
      for index = 1, #tableStatKeys do
        local key = tableStatKeys[index]
        do
          local __lux_obj_startedStats_24 = startedStats
          local __lux_val_startedStats_26 = nil
          if __lux_obj_startedStats_24 ~= nil then
            local __lux_key_key_25 = key
            __lux_val_startedStats_26 = __lux_obj_startedStats_24[__lux_key_key_25]
          end
          out[key] = diffCounts(now[key], __lux_val_startedStats_26)
        end
      end
      return out
    end
    sumCounts = function(source)
      local total = 0
      do
        local __lux_tmp_source_27 = source
        if __lux_tmp_source_27 == nil then
          __lux_tmp_source_27 = {}
        end
        for _, value in pairs(__lux_tmp_source_27) do
          do
            local __lux_tmp_value_28 = toNumber(value)
            if __lux_tmp_value_28 == nil then
              __lux_tmp_value_28 = 0
            end
            total = total + __lux_tmp_value_28
          end
        end
      end
      return total
    end
    topRowsFromCounts = function(times, counts, limit, prefix, omitBroad)
      if limit == nil then
        limit = 6
      end
      if omitBroad == nil then
        omitBroad = false
      end
      local rows = {}
      do
        local __lux_tmp_times_29 = times
        if __lux_tmp_times_29 == nil then
          __lux_tmp_times_29 = {}
        end
        for name, ms in pairs(__lux_tmp_times_29) do
          local include = prefix == nil or stringSub(toString(name), 1, #prefix) == prefix
          if include and (not omitBroad or broadProfileLabels[name] ~= true) then
            do
              local __lux_tmp_ms_30 = ms
              if __lux_tmp_ms_30 == nil then
                __lux_tmp_ms_30 = 0
              end
              local __lux_tmp_ms_31 = ms
              if __lux_tmp_ms_31 == nil then
                __lux_tmp_ms_31 = 0
              end
              local __lux_tmp_ms_32 = ms
              if __lux_tmp_ms_32 == nil then
                __lux_tmp_ms_32 = 0
              end
              local __lux_obj_counts_33 = counts
              local __lux_val_counts_35 = nil
              if __lux_obj_counts_33 ~= nil then
                local __lux_key_name_34 = name
                __lux_val_counts_35 = __lux_obj_counts_33[__lux_key_name_34]
              end
              local __lux_tmp_name_36 = __lux_val_counts_35
              if __lux_tmp_name_36 == nil then
                __lux_tmp_name_36 = 0
              end
              local __lux_obj_counts_37 = counts
              local __lux_val_counts_39 = nil
              if __lux_obj_counts_37 ~= nil then
                local __lux_key_name_38 = name
                __lux_val_counts_39 = __lux_obj_counts_37[__lux_key_name_38]
              end
              local __lux_tmp_name_40 = __lux_val_counts_39
              if __lux_tmp_name_40 == nil then
                __lux_tmp_name_40 = 0
              end
              rows[#rows + 1] = {
                name = name,
                last = __lux_tmp_ms_30,
                avg = __lux_tmp_ms_31,
                max = __lux_tmp_ms_32,
                count = __lux_tmp_name_36,
                avgCount = __lux_tmp_name_40,
              }
            end
          end
        end
      end
      tableSort(
        rows,
        function(a, b)
          do
            local __lux_tmp_avg_41 = a.avg
            if __lux_tmp_avg_41 == nil then
              __lux_tmp_avg_41 = a.last
            end
            if __lux_tmp_avg_41 == nil then
              __lux_tmp_avg_41 = 0
            end
            local __lux_tmp_avg_42 = b.avg
            if __lux_tmp_avg_42 == nil then
              __lux_tmp_avg_42 = b.last
            end
            if __lux_tmp_avg_42 == nil then
              __lux_tmp_avg_42 = 0
            end
            if __lux_tmp_avg_41 == __lux_tmp_avg_42 then
              return a.name < b.name
            else
              local __lux_tmp_avg_43 = a.avg
              if __lux_tmp_avg_43 == nil then
                __lux_tmp_avg_43 = a.last
              end
              if __lux_tmp_avg_43 == nil then
                __lux_tmp_avg_43 = 0
              end
              local __lux_tmp_avg_44 = b.avg
              if __lux_tmp_avg_44 == nil then
                __lux_tmp_avg_44 = b.last
              end
              if __lux_tmp_avg_44 == nil then
                __lux_tmp_avg_44 = 0
              end
              return __lux_tmp_avg_43 > __lux_tmp_avg_44
            end
          end
        end
      )
      do
        local __lux_tmp_limit_45 = toNumber(limit)
        if __lux_tmp_limit_45 == nil then
          __lux_tmp_limit_45 = 6
        end
        limit = mathMax(1, __lux_tmp_limit_45)
      end
      while #rows > limit do
        rows[#rows] = nil
      end
      return rows
    end
    topRowsFromBuckets = function(store, limit, prefix, omitBroad)
      if limit == nil then
        limit = 6
      end
      if omitBroad == nil then
        omitBroad = false
      end
      local rows = {}
      do
        local __lux_tmp_store_46 = store
        if __lux_tmp_store_46 == nil then
          __lux_tmp_store_46 = {}
        end
        for key, bucket in pairs(__lux_tmp_store_46) do
          local name
          do
            local __lux_obj_meta_47 = bucket.meta
            local __lux_val_name_48 = nil
            if __lux_obj_meta_47 ~= nil then
              __lux_val_name_48 = __lux_obj_meta_47.name
            end
            name = __lux_val_name_48
            if name == nil then
              name = key
            end
          end
          local include = prefix == nil or stringSub(toString(name), 1, #prefix) == prefix
          if include and (not omitBroad or broadProfileLabels[name] ~= true) then
            local n
            if bucket.n > 0 then
              n = bucket.n
            else
              n = 1
            end
            do
              local __lux_tmp_last_49 = bucket.last
              if __lux_tmp_last_49 == nil then
                __lux_tmp_last_49 = 0
              end
              local __lux_tmp_sum_50 = bucket.sum
              if __lux_tmp_sum_50 == nil then
                __lux_tmp_sum_50 = 0
              end
              local __lux_tmp_max_51 = bucket.max
              if __lux_tmp_max_51 == nil then
                __lux_tmp_max_51 = 0
              end
              local __lux_tmp_lastCount_52 = bucket.lastCount
              if __lux_tmp_lastCount_52 == nil then
                __lux_tmp_lastCount_52 = 0
              end
              local __lux_tmp_countSum_53 = bucket.countSum
              if __lux_tmp_countSum_53 == nil then
                __lux_tmp_countSum_53 = 0
              end
              local __lux_tmp_n_54 = bucket.n
              if __lux_tmp_n_54 == nil then
                __lux_tmp_n_54 = 0
              end
              rows[#rows + 1] = {
                name = name,
                last = __lux_tmp_last_49,
                avg = __lux_tmp_sum_50 / n,
                max = __lux_tmp_max_51,
                count = __lux_tmp_lastCount_52,
                avgCount = __lux_tmp_countSum_53 / n,
                samples = __lux_tmp_n_54,
              }
            end
          end
        end
      end
      tableSort(
        rows,
        function(a, b)
          if a.avg == b.avg then
            return a.name < b.name
          else
            return a.avg > b.avg
          end
        end
      )
      do
        local __lux_tmp_limit_55 = toNumber(limit)
        if __lux_tmp_limit_55 == nil then
          __lux_tmp_limit_55 = 6
        end
        limit = mathMax(1, __lux_tmp_limit_55)
      end
      while #rows > limit do
        rows[#rows] = nil
      end
      return rows
    end
    formatCallsite = function(callsite)
      if callsite == nil then
        return "unknown"
      end
      local source = callsite.short_src
      if source == nil then
        source = callsite.source
        if source == nil then
          source = callsite.file
          if source == nil then
            source = "?"
          end
        end
      end
      local line = callsite.currentline
      if line == nil then
        line = callsite.line
        if line == nil then
          line = 0
        end
      end
      local name = callsite.name
      if name ~= nil and name ~= "" then
        return toString(source) .. ":" .. toString(line) .. " " .. toString(name)
      end
      return toString(source) .. ":" .. toString(line)
    end
    panelLabel = function(panel, kind)
      if kind == "screen" or panel == nil then
        return "screen"
      end
      local className
      if panel.GetClassName ~= nil then
        className = panel:GetClassName()
      else
        className = nil
      end
      local panelName
      if panel.GetName ~= nil then
        panelName = panel:GetName()
      else
        panelName = nil
      end
      local parts = {}
      if className ~= nil and className ~= "" then
        parts[#parts + 1] = className
      end
      if panelName ~= nil and panelName ~= "" and panelName ~= className then
        parts[#parts + 1] = panelName
      end
      parts[#parts + 1] = toString(panel)
      return tableConcat(parts, " ")
    end
    scopeKey = function(kind, subject, info)
      if kind == nil then
        kind = "frame"
      end
      do
        local __lux_tmp_kind_56 = kind
        if __lux_tmp_kind_56 == nil then
          __lux_tmp_kind_56 = "frame"
        end
        kind = toString(__lux_tmp_kind_56)
      end
      if subject ~= nil then
        return kind .. ":" .. toString(subject)
      end
      local callsite
      do
        local __lux_obj_info_57 = info
        local __lux_val_callsite_58 = nil
        if __lux_obj_info_57 ~= nil then
          __lux_val_callsite_58 = __lux_obj_info_57.callsite
        end
        callsite = __lux_val_callsite_58
      end
      if callsite ~= nil then
        return kind .. ":" .. formatCallsite(callsite)
      end
      return kind .. ":unknown"
    end
    scopeRowFromBucket = function(key, bucket)
      local meta = bucket.meta
      if meta == nil then
        meta = {}
      end
      local n
      if bucket.n > 0 then
        n = bucket.n
      else
        n = 1
      end
      local stats = meta.stats
      if stats == nil then
        stats = {}
      end
      local __lux_tmp_name_59 = meta.name
      if __lux_tmp_name_59 == nil then
        __lux_tmp_name_59 = key
      end
      local __lux_tmp_kind_60 = meta.kind
      if __lux_tmp_kind_60 == nil then
        __lux_tmp_kind_60 = "frame"
      end
      local __lux_tmp_callsiteText_61 = meta.callsiteText
      if __lux_tmp_callsiteText_61 == nil then
        __lux_tmp_callsiteText_61 = "unknown"
      end
      local __lux_tmp_last_62 = bucket.last
      if __lux_tmp_last_62 == nil then
        __lux_tmp_last_62 = 0
      end
      local __lux_tmp_sum_63 = bucket.sum
      if __lux_tmp_sum_63 == nil then
        __lux_tmp_sum_63 = 0
      end
      local __lux_tmp_max_64 = bucket.max
      if __lux_tmp_max_64 == nil then
        __lux_tmp_max_64 = 0
      end
      local __lux_tmp_lastCount_65 = bucket.lastCount
      if __lux_tmp_lastCount_65 == nil then
        __lux_tmp_lastCount_65 = 0
      end
      local __lux_tmp_countSum_66 = bucket.countSum
      if __lux_tmp_countSum_66 == nil then
        __lux_tmp_countSum_66 = 0
      end
      local __lux_tmp_n_67 = bucket.n
      if __lux_tmp_n_67 == nil then
        __lux_tmp_n_67 = 0
      end
      local __lux_tmp_profileTimes_68 = meta.profileTimes
      if __lux_tmp_profileTimes_68 == nil then
        __lux_tmp_profileTimes_68 = {}
      end
      local __lux_tmp_profileCounts_69 = meta.profileCounts
      if __lux_tmp_profileCounts_69 == nil then
        __lux_tmp_profileCounts_69 = {}
      end
      local __lux_tmp_profileTop_70 = meta.profileTop
      if __lux_tmp_profileTop_70 == nil then
        __lux_tmp_profileTop_70 = {}
      end
      local __lux_tmp_drawCommandCounts_71 = stats.drawCommandCounts
      if __lux_tmp_drawCommandCounts_71 == nil then
        __lux_tmp_drawCommandCounts_71 = {}
      end
      local __lux_tmp_drawImmediateCounts_72 = stats.drawImmediateCounts
      if __lux_tmp_drawImmediateCounts_72 == nil then
        __lux_tmp_drawImmediateCounts_72 = {}
      end
      return {
        key = key,
        name = __lux_tmp_name_59,
        kind = __lux_tmp_kind_60,
        callsite = __lux_tmp_callsiteText_61,
        last = __lux_tmp_last_62,
        avg = __lux_tmp_sum_63 / n,
        max = __lux_tmp_max_64,
        count = __lux_tmp_lastCount_65,
        avgCount = __lux_tmp_countSum_66 / n,
        samples = __lux_tmp_n_67,
        stats = stats,
        profileTimes = __lux_tmp_profileTimes_68,
        profileCounts = __lux_tmp_profileCounts_69,
        profileTop = __lux_tmp_profileTop_70,
        commandCounts = __lux_tmp_drawCommandCounts_71,
        immediateCounts = __lux_tmp_drawImmediateCounts_72,
      }
    end
    sourceInstanceName = function(target, instanceId)
      local explicit
      do
        local __lux_obj_target_73 = target
        local __lux_val_ProfilerName_74 = nil
        if __lux_obj_target_73 ~= nil then
          __lux_val_ProfilerName_74 = __lux_obj_target_73._ProfilerName
        end
        explicit = __lux_val_ProfilerName_74
        if explicit == nil then
          do
            local __lux_obj_target_75 = target
            local __lux_val_LuxRuntimeBase_76 = nil
            if __lux_obj_target_75 ~= nil then
              __lux_val_LuxRuntimeBase_76 = __lux_obj_target_75._LuxRuntimeBase
            end
            explicit = __lux_val_LuxRuntimeBase_76
          end
        end
      end
      if explicit ~= nil then
        return toString(explicit)
      end
      if debugLib ~= nil and debugLib.getinfo ~= nil and stringMatch ~= nil then
        local info = debugLib.getinfo(create, "S")
        local source
        do
          local __lux_obj_info_77 = info
          local __lux_val_source_78 = nil
          if __lux_obj_info_77 ~= nil then
            __lux_val_source_78 = __lux_obj_info_77.source
          end
          source = __lux_val_source_78
          if source == nil then
            do
              local __lux_obj_info_79 = info
              local __lux_val_short_src_80 = nil
              if __lux_obj_info_79 ~= nil then
                __lux_val_short_src_80 = __lux_obj_info_79.short_src
              end
              source = __lux_val_short_src_80
            end
          end
        end
        if source ~= nil then
          local addon = stringMatch(source, "lux/([^/]+)/client/runtime/lux/mgfx/profiler%.lua")
          if addon ~= nil then
            return "lux/" .. addon
          end
          if stringMatch(source, "mgfx/client/runtime/lux/mgfx/profiler%.lua") ~= nil then
            return "lux/mgfx"
          end
        end
      end
      return "instance " .. toString(instanceId)
    end
    create = function(owner, options)
      local target = owner
      if target == nil then
        target = {}
      end
      local enabledConVar
      do
        local __lux_obj_options_81 = options
        local __lux_val_enabledConVar_82 = nil
        if __lux_obj_options_81 ~= nil then
          __lux_val_enabledConVar_82 = __lux_obj_options_81.enabledConVar
        end
        enabledConVar = __lux_val_enabledConVar_82
        if enabledConVar == nil then
          enabledConVar = makeConVar("mgfx_profile", "0", "MGFX: enable renderer profiler.")
        end
      end
      local windowConVar
      do
        local __lux_obj_options_83 = options
        local __lux_val_windowConVar_84 = nil
        if __lux_obj_options_83 ~= nil then
          __lux_val_windowConVar_84 = __lux_obj_options_83.windowConVar
        end
        windowConVar = __lux_val_windowConVar_84
        if windowConVar == nil then
          windowConVar = makeConVar("mgfx_profile_window", "120", "MGFX: rolling profiler sample window.")
        end
      end
      local topConVar
      do
        local __lux_obj_options_85 = options
        local __lux_val_topConVar_86 = nil
        if __lux_obj_options_85 ~= nil then
          __lux_val_topConVar_86 = __lux_obj_options_85.topConVar
        end
        topConVar = __lux_val_topConVar_86
        if topConVar == nil then
          topConVar = makeConVar(
            "mgfx_profile_top",
            "18",
            "MGFX: number of profiler rows printed by mgfx_profile_status."
          )
        end
      end
      local rolling = {}
      local scopeRolling = {}
      local recentScopes = {}
      local instanceRolling = {}
      local instanceProfileRolling = {}
      local instanceCommandRolling = {}
      local instanceImmediateRolling = {}
      local instanceCurrent = nil
      local frameIndex = 0
      local active = false
      local traceRoot = nil
      local traceStack = nil
      local currentScope = nil
      local wrappedOriginals = {}
      local wrappersInstalled = false
      local wrappedOwner = nil
      local wrappedNames = nil
      local wrappedSuppress = nil
      local globalMGFX = globalTable.MGFX
      if globalMGFX == nil then
        globalMGFX = {}
      end
      globalTable.MGFX = globalMGFX
      local registry = globalMGFX._ProfilerRegistry
      if registry == nil then
        registry = { items = {}, nextId = 0 }
      end
      globalMGFX._ProfilerRegistry = registry
      do
        local __lux_tmp_items_87 = registry.items
        if __lux_tmp_items_87 == nil then
          __lux_tmp_items_87 = {}
        end
        registry.items = __lux_tmp_items_87
      end
      for id, item in pairs(registry.items) do
        if item.owner == target then
          if item.callbackId ~= nil and cvarsLib ~= nil and cvarsLib.RemoveChangeCallback ~= nil then
            cvarsLib.RemoveChangeCallback("mgfx_profile", item.callbackId)
          end
          registry.items[id] = nil
        end
      end
      do
        local __lux_tmp_nextId_88 = registry.nextId
        if __lux_tmp_nextId_88 == nil then
          __lux_tmp_nextId_88 = 0
        end
        registry.nextId = __lux_tmp_nextId_88 + 1
      end
      local instanceId = registry.nextId
      local instanceName = sourceInstanceName(target, instanceId)
      local callbackId = "MGFXProfileApiWrappers" .. toString(instanceId)
      local api = {}
      local isEnabled = function()
        return enabledConVar ~= nil and enabledConVar.GetBool ~= nil and enabledConVar:GetBool() or false
      end
      local windowSize = function()
        return mathMax(
          1,
          windowConVar ~= nil and windowConVar.GetInt ~= nil and windowConVar:GetInt() or 120
        )
      end
      local topLimit = function()
        return mathMax(1, topConVar ~= nil and topConVar.GetInt ~= nil and topConVar:GetInt() or 18)
      end
      local newTraceNode = function(name)
        do
          local __lux_tmp_name_89 = name
          if __lux_tmp_name_89 == nil then
            __lux_tmp_name_89 = "unknown"
          end
          name = toString(__lux_tmp_name_89)
        end
        return {
          name = name,
          total = 0,
          self = 0,
          childTotal = 0,
          count = 0,
          max = 0,
          selfMax = 0,
          children = {},
          childMap = {},
        }
      end
      local traceChild = function(parent, name)
        local key
        do
          local __lux_tmp_name_90 = name
          if __lux_tmp_name_90 == nil then
            __lux_tmp_name_90 = "unknown"
          end
          key = toString(__lux_tmp_name_90)
        end
        local node = parent.childMap[key]
        if node ~= nil then
          return node
        end
        node = newTraceNode(key)
        parent.childMap[key] = node
        parent.children[#parent.children + 1] = node
        return node
      end
      local copyTraceNode
      copyTraceNode = function(node)
        if node == nil then
          return nil
        end
        local out
        do
          local __lux_tmp_total_91 = node.total
          if __lux_tmp_total_91 == nil then
            __lux_tmp_total_91 = 0
          end
          local __lux_tmp_self_92 = node.self
          if __lux_tmp_self_92 == nil then
            __lux_tmp_self_92 = 0
          end
          local __lux_tmp_childTotal_93 = node.childTotal
          if __lux_tmp_childTotal_93 == nil then
            __lux_tmp_childTotal_93 = 0
          end
          local __lux_tmp_count_94 = node.count
          if __lux_tmp_count_94 == nil then
            __lux_tmp_count_94 = 0
          end
          local __lux_tmp_max_95 = node.max
          if __lux_tmp_max_95 == nil then
            __lux_tmp_max_95 = 0
          end
          local __lux_tmp_selfMax_96 = node.selfMax
          if __lux_tmp_selfMax_96 == nil then
            __lux_tmp_selfMax_96 = 0
          end
          out = {
            name = node.name,
            total = __lux_tmp_total_91,
            self = __lux_tmp_self_92,
            childTotal = __lux_tmp_childTotal_93,
            count = __lux_tmp_count_94,
            max = __lux_tmp_max_95,
            selfMax = __lux_tmp_selfMax_96,
            children = {},
          }
        end
        do
          local __lux_tmp_children_97 = node.children
          if __lux_tmp_children_97 == nil then
            __lux_tmp_children_97 = {}
          end
          for index = 1, #__lux_tmp_children_97 do
            out.children[index] = copyTraceNode(node.children[index])
          end
        end
        return out
      end
      local finishTraceSpan = function(token)
        local elapsed = (sysTime() - token.started) * 1000
        local selfElapsed
        do
          local __lux_tmp_childElapsed_98 = token.childElapsed
          if __lux_tmp_childElapsed_98 == nil then
            __lux_tmp_childElapsed_98 = 0
          end
          selfElapsed = elapsed - __lux_tmp_childElapsed_98
        end
        if selfElapsed < 0 then
          selfElapsed = 0
        end
        local node = token.node
        do
          local __lux_tmp_total_99 = node.total
          if __lux_tmp_total_99 == nil then
            __lux_tmp_total_99 = 0
          end
          node.total = __lux_tmp_total_99 + elapsed
        end
        do
          local __lux_tmp_self_100 = node.self
          if __lux_tmp_self_100 == nil then
            __lux_tmp_self_100 = 0
          end
          node.self = __lux_tmp_self_100 + selfElapsed
        end
        do
          local __lux_tmp_childTotal_101 = node.childTotal
          if __lux_tmp_childTotal_101 == nil then
            __lux_tmp_childTotal_101 = 0
          end
          local __lux_tmp_childElapsed_102 = token.childElapsed
          if __lux_tmp_childElapsed_102 == nil then
            __lux_tmp_childElapsed_102 = 0
          end
          node.childTotal = __lux_tmp_childTotal_101 + __lux_tmp_childElapsed_102
        end
        do
          local __lux_tmp_count_103 = node.count
          if __lux_tmp_count_103 == nil then
            __lux_tmp_count_103 = 0
          end
          node.count = __lux_tmp_count_103 + 1
        end
        local __lux_tmp_max_104 = node.max
        if __lux_tmp_max_104 == nil then
          __lux_tmp_max_104 = 0
        end
        if elapsed > __lux_tmp_max_104 then
          node.max = elapsed
        end
        local __lux_tmp_selfMax_105 = node.selfMax
        if __lux_tmp_selfMax_105 == nil then
          __lux_tmp_selfMax_105 = 0
        end
        if selfElapsed > __lux_tmp_selfMax_105 then
          node.selfMax = selfElapsed
        end
        return elapsed
      end
      local rollBucket = function(store, key, ms, count, meta)
        if count == nil then
          count = 0
        end
        local window = windowSize()
        local bucket = store[key]
        if bucket == nil then
          bucket = {
            samples = {},
            counts = {},
            index = 1,
            n = 0,
            sum = 0,
            countSum = 0,
            max = 0,
            last = 0,
            lastCount = 0,
          }
          store[key] = bucket
        end
        local index = bucket.index
        local oldMs = bucket.samples[index]
        if oldMs == nil then
          oldMs = 0
        end
        if bucket.n == window then
          bucket.sum = bucket.sum - oldMs
          do
            local __lux_tmp_index_106 = bucket.counts[index]
            if __lux_tmp_index_106 == nil then
              __lux_tmp_index_106 = 0
            end
            bucket.countSum = bucket.countSum - __lux_tmp_index_106
          end
        else
          bucket.n = bucket.n + 1
        end
        if count == nil then
          count = 0
        end
        bucket.samples[index] = ms
        bucket.counts[index] = count
        bucket.sum = bucket.sum + ms
        bucket.countSum = bucket.countSum + count
        bucket.last = ms
        bucket.lastCount = count
        local __lux_tmp_max_107 = bucket.max
        if __lux_tmp_max_107 == nil then
          __lux_tmp_max_107 = 0
        end
        if ms >= __lux_tmp_max_107 then
          bucket.max = ms
        else
          local __lux_tmp_max_108 = bucket.max
          if __lux_tmp_max_108 == nil then
            __lux_tmp_max_108 = 0
          end
          if oldMs >= __lux_tmp_max_108 then
            local maxValue = 0
            for sampleIndex = 1, bucket.n do
              local sample = bucket.samples[sampleIndex]
              if sample == nil then
                sample = 0
              end
              if sample > maxValue then
                maxValue = sample
              end
            end
            bucket.max = maxValue
          end
        end
        bucket.index = index % window + 1
        bucket.frame = frameIndex
        bucket.meta = meta
        return bucket
      end
      local rollSeries = function(store, values, counts)
        for key, _ in pairs(store) do
          if values == nil or values[key] == nil then
            rollBucket(store, key, 0, 0, { name = key })
          end
        end
        do
          local __lux_tmp_values_109 = values
          if __lux_tmp_values_109 == nil then
            __lux_tmp_values_109 = {}
          end
          for key, value in pairs(__lux_tmp_values_109) do
            do
              local __lux_tmp_value_110 = toNumber(value)
              if __lux_tmp_value_110 == nil then
                __lux_tmp_value_110 = 0
              end
              local __lux_obj_counts_111 = counts
              local __lux_val_counts_113 = nil
              if __lux_obj_counts_111 ~= nil then
                local __lux_key_key_112 = key
                __lux_val_counts_113 = __lux_obj_counts_111[__lux_key_key_112]
              end
              local __lux_tmp_key_114 = __lux_val_counts_113
              if __lux_tmp_key_114 == nil then
                __lux_tmp_key_114 = value
              end
              if __lux_tmp_key_114 == nil then
                __lux_tmp_key_114 = 0
              end
              rollBucket(store, key, __lux_tmp_value_110, __lux_tmp_key_114, { name = key })
            end
          end
        end
      end
      local clearInstanceCurrent = function()
        instanceCurrent = nil
      end
      local rollInstanceFrame = function()
        local aggregate = instanceCurrent
        local __lux_tmp_117 = aggregate == nil
        if not __lux_tmp_117 then
          local __lux_tmp_scopes_116 = aggregate.scopes
          if __lux_tmp_scopes_116 == nil then
            __lux_tmp_scopes_116 = 0
          end
          __lux_tmp_117 = __lux_tmp_scopes_116 <= 0
        end
        if __lux_tmp_117 then
          return
        end
        local stats = copyScalarStats(aggregate.stats)
        stats.drawCommandCounts = copyCounts(aggregate.commandCounts)
        stats.drawImmediateCounts = copyCounts(aggregate.immediateCounts)
        do
          local __lux_tmp_elapsed_118 = aggregate.elapsed
          if __lux_tmp_elapsed_118 == nil then
            __lux_tmp_elapsed_118 = 0
          end
          local __lux_tmp_scopes_119 = aggregate.scopes
          if __lux_tmp_scopes_119 == nil then
            __lux_tmp_scopes_119 = 0
          end
          rollBucket(
            instanceRolling,
            "runtime",
            __lux_tmp_elapsed_118,
            __lux_tmp_scopes_119,
            {
              name = "[" .. instanceName .. "] total",
              stats = stats,
              profileTimes = copyCounts(aggregate.profileTimes),
              profileCounts = copyCounts(aggregate.profileCounts),
            }
          )
        end
        rollSeries(instanceProfileRolling, aggregate.profileTimes, aggregate.profileCounts)
        rollSeries(instanceCommandRolling, aggregate.commandCounts, aggregate.commandCounts)
        return rollSeries(
          instanceImmediateRolling,
          aggregate.immediateCounts,
          aggregate.immediateCounts
        )
      end
      local currentEngineFrame = function()
        if frameNumber ~= nil then
          return frameNumber()
        else
          return frameIndex
        end
      end
      local ensureInstanceAggregate = function()
        local engineFrame = currentEngineFrame()
        if instanceCurrent ~= nil and instanceCurrent.frame ~= engineFrame then
          rollInstanceFrame()
          clearInstanceCurrent()
        end
        if instanceCurrent == nil then
          instanceCurrent = {
            frame = engineFrame,
            elapsed = 0,
            scopes = 0,
            stats = {},
            profileTimes = {},
            profileCounts = {},
            commandCounts = {},
            immediateCounts = {},
          }
        end
        return instanceCurrent
      end
      local accumulateInstanceScope = function(elapsedMs, stats, profileTimes, profileCounts)
        local aggregate = ensureInstanceAggregate()
        do
          local __lux_tmp_elapsed_120 = aggregate.elapsed
          if __lux_tmp_elapsed_120 == nil then
            __lux_tmp_elapsed_120 = 0
          end
          local __lux_tmp_elapsedMs_121 = elapsedMs
          if __lux_tmp_elapsedMs_121 == nil then
            __lux_tmp_elapsedMs_121 = 0
          end
          aggregate.elapsed = __lux_tmp_elapsed_120 + __lux_tmp_elapsedMs_121
        end
        do
          local __lux_tmp_scopes_122 = aggregate.scopes
          if __lux_tmp_scopes_122 == nil then
            __lux_tmp_scopes_122 = 0
          end
          aggregate.scopes = __lux_tmp_scopes_122 + 1
        end
        for index = 1, #scalarStatKeys do
          local key = scalarStatKeys[index]
          do
            local __lux_tmp_key_123 = aggregate.stats[key]
            if __lux_tmp_key_123 == nil then
              __lux_tmp_key_123 = 0
            end
            local __lux_obj_stats_124 = stats
            local __lux_val_stats_126 = nil
            if __lux_obj_stats_124 ~= nil then
              local __lux_key_key_125 = key
              __lux_val_stats_126 = __lux_obj_stats_124[__lux_key_key_125]
            end
            local __lux_tmp_key_127 = toNumber(__lux_val_stats_126)
            if __lux_tmp_key_127 == nil then
              __lux_tmp_key_127 = 0
            end
            aggregate.stats[key] = __lux_tmp_key_123 + __lux_tmp_key_127
          end
        end
        addCountsInto(aggregate.profileTimes, profileTimes)
        addCountsInto(aggregate.profileCounts, profileCounts)
        do
          local __lux_obj_stats_128 = stats
          local __lux_val_drawCommandCounts_129 = nil
          if __lux_obj_stats_128 ~= nil then
            __lux_val_drawCommandCounts_129 = __lux_obj_stats_128.drawCommandCounts
          end
          addCountsInto(aggregate.commandCounts, __lux_val_drawCommandCounts_129)
        end
        local __lux_obj_stats_130 = stats
        local __lux_val_drawImmediateCounts_131 = nil
        if __lux_obj_stats_130 ~= nil then
          __lux_val_drawImmediateCounts_131 = __lux_obj_stats_130.drawImmediateCounts
        end
        return addCountsInto(aggregate.immediateCounts, __lux_val_drawImmediateCounts_131)
      end
      local finishScope = function(scope)
        if scope == nil then
          return
        end
        local elapsedMs = (sysTime() - scope.started) * 1000
        local stats = diffStats(target, scope.startStats)
        local profileTimes = copyCounts(stats.profileTimes)
        local profileCounts = copyCounts(stats.profileCounts)
        accumulateInstanceScope(elapsedMs, stats, profileTimes, profileCounts)
        local meta = {
          name = scope.name,
          kind = scope.kind,
          callsiteText = scope.callsiteText,
          stats = stats,
          profileTimes = profileTimes,
          profileCounts = profileCounts,
          profileTop = topRowsFromCounts(profileTimes, profileCounts, 6),
        }
        rollBucket(scopeRolling, scope.key, elapsedMs, 1, meta)
        recentScopes[#recentScopes + 1] = {
          key = scope.key,
          name = "[" .. instanceName .. "] " .. scope.name,
          localName = scope.name,
          instance = instanceName,
          instanceId = instanceId,
          kind = scope.kind,
          callsite = scope.callsiteText,
          last = elapsedMs,
          stats = stats,
          profileTimes = profileTimes,
          profileCounts = profileCounts,
          profileTop = meta.profileTop,
          frame = frameIndex,
        }
        while #recentScopes > RECENT_SCOPE_LIMIT do
          if tableRemove ~= nil then
            tableRemove(recentScopes, 1)
          else
            for index = 1, #recentScopes - 1 do
              recentScopes[index] = recentScopes[index + 1]
            end
            recentScopes[#recentScopes] = nil
          end
        end
      end
      api.IsEnabled = function()
        return isEnabled()
      end
      api.InstanceId = function()
        return instanceId
      end
      api.InstanceName = function()
        return instanceName
      end
      api.BeginFrame = function(kind, subject, info)
        if kind == nil then
          kind = "frame"
        end
        active = isEnabled()
        currentScope = nil
        if active then
          frameIndex = frameIndex + 1
          if info == nil then
            info = {}
          end
          local scopeKind
          do
            local __lux_tmp_kind_132 = kind
            if __lux_tmp_kind_132 == nil then
              __lux_tmp_kind_132 = "frame"
            end
            scopeKind = toString(__lux_tmp_kind_132)
          end
          do
            local __lux_tmp_label_133 = info.label
            if __lux_tmp_label_133 == nil then
              __lux_tmp_label_133 = panelLabel(subject, scopeKind)
            end
            currentScope = {
              key = scopeKey(scopeKind, subject, info),
              kind = scopeKind,
              name = __lux_tmp_label_133,
              callsiteText = formatCallsite(info.callsite),
              started = sysTime(),
              startStats = snapshotStats(target),
            }
          end
        end
        return active
      end
      api.IsActive = function()
        return active
      end
      api._TraceActive = false
      api.BeginTrace = function(name)
        if name == nil then
          name = "trace"
        end
        if api._TraceActive then
          error("MGFX trace already active")
        end
        traceRoot = newTraceNode(name)
        traceStack = { { node = traceRoot, started = sysTime(), childElapsed = 0 } }
        api._TraceActive = true
        return traceRoot
      end
      api.TraceActive = function()
        return api._TraceActive
      end
      api.TraceStart = function(name)
        if not api._TraceActive or traceStack == nil then
          return nil
        end
        local parent = traceStack[#traceStack]
        if parent == nil then
          return nil
        end
        local token = { node = traceChild(parent.node, name), started = sysTime(), childElapsed = 0 }
        traceStack[#traceStack + 1] = token
        return token
      end
      api.TraceEnd = function(token)
        if token == nil then
          return
        end
        if not api._TraceActive or traceStack == nil then
          error("MGFX trace span ended with no active trace")
        end
        local top = traceStack[#traceStack]
        if top ~= token then
          error("MGFX trace span stack mismatch")
        end
        local elapsed = finishTraceSpan(token)
        traceStack[#traceStack] = nil
        local parent = traceStack[#traceStack]
        if parent ~= nil then
          do
            local __lux_tmp_childElapsed_134 = parent.childElapsed
            if __lux_tmp_childElapsed_134 == nil then
              __lux_tmp_childElapsed_134 = 0
            end
            parent.childElapsed = __lux_tmp_childElapsed_134 + elapsed
          end
        end
      end
      api.EndTrace = function()
        if not api._TraceActive then
          return nil
        end
        if traceStack == nil or #traceStack ~= 1 then
          error("MGFX trace ended with unclosed spans")
        end
        local rootToken = traceStack[1]
        finishTraceSpan(rootToken)
        local out = copyTraceNode(traceRoot)
        api._TraceActive = false
        traceRoot = nil
        traceStack = nil
        return out
      end
      api.Start = function()
        if active then
          return sysTime()
        else
          return nil
        end
      end
      api.Record = function(name, elapsedMs, count)
        if count == nil then
          count = 1
        end
        if not active or elapsedMs == nil then
          return
        end
        do
          local __lux_tmp_name_135 = name
          if __lux_tmp_name_135 == nil then
            __lux_tmp_name_135 = "unknown"
          end
          name = toString(__lux_tmp_name_135)
        end
        do
          local __lux_tmp_stats_136 = target.stats
          if __lux_tmp_stats_136 == nil then
            __lux_tmp_stats_136 = {}
          end
          target.stats = __lux_tmp_stats_136
        end
        do
          local __lux_tmp_profileTimes_137 = target.stats.profileTimes
          if __lux_tmp_profileTimes_137 == nil then
            __lux_tmp_profileTimes_137 = {}
          end
          target.stats.profileTimes = __lux_tmp_profileTimes_137
        end
        do
          local __lux_tmp_profileCounts_138 = target.stats.profileCounts
          if __lux_tmp_profileCounts_138 == nil then
            __lux_tmp_profileCounts_138 = {}
          end
          target.stats.profileCounts = __lux_tmp_profileCounts_138
        end
        do
          local __lux_tmp_name_139 = target.stats.profileTimes[name]
          if __lux_tmp_name_139 == nil then
            __lux_tmp_name_139 = 0
          end
          target.stats.profileTimes[name] = __lux_tmp_name_139 + elapsedMs
        end
        do
          local __lux_tmp_name_140 = target.stats.profileCounts[name]
          if __lux_tmp_name_140 == nil then
            __lux_tmp_name_140 = 0
          end
          local __lux_tmp_count_141 = count
          if __lux_tmp_count_141 == nil then
            __lux_tmp_count_141 = 1
          end
          target.stats.profileCounts[name] = __lux_tmp_name_140 + __lux_tmp_count_141
        end
      end
      api.End = function(name, started, count)
        if count == nil then
          count = 1
        end
        if started ~= nil then
          api.Record(name, (sysTime() - started) * 1000, count)
        end
      end
      api.EndFrame = function()
        if not active then
          return
        end
        finishScope(currentScope)
        currentScope = nil
        do
          local __lux_obj_target_142 = target.stats
          local __lux_tmp_profileTimes_143 = nil
          if __lux_obj_target_142 ~= nil then
            __lux_tmp_profileTimes_143 = __lux_obj_target_142.profileTimes
          end
          if __lux_tmp_profileTimes_143 == nil then
            __lux_tmp_profileTimes_143 = {}
          end
          for name, ms in pairs(__lux_tmp_profileTimes_143) do
            local counts
            do
              local __lux_obj_stats_144 = target.stats
              local __lux_val_profileCounts_145 = nil
              if __lux_obj_stats_144 ~= nil then
                __lux_val_profileCounts_145 = __lux_obj_stats_144.profileCounts
              end
              counts = __lux_val_profileCounts_145
            end
            local sampleCount
            if counts ~= nil then
              sampleCount = counts[name]
              if sampleCount == nil then
                sampleCount = 0
              end
            else
              sampleCount = 0
            end
            rollBucket(rolling, name, ms, sampleCount, { name = name })
          end
        end
        active = false
      end
      api.Reset = function()
        clearTable(rolling)
        clearTable(scopeRolling)
        clearTable(recentScopes)
        clearTable(instanceRolling)
        clearTable(instanceProfileRolling)
        clearTable(instanceCommandRolling)
        clearTable(instanceImmediateRolling)
        clearInstanceCurrent()
        frameIndex = 0
        currentScope = nil
        traceRoot = nil
        traceStack = nil
        api._TraceActive = false
      end
      api.Snapshot = function(limit)
        if limit == nil then
          limit = topLimit()
        end
        local rows = {}
        for name, bucket in pairs(rolling) do
          local n
          if bucket.n > 0 then
            n = bucket.n
          else
            n = 1
          end
          do
            local __lux_tmp_last_146 = bucket.last
            if __lux_tmp_last_146 == nil then
              __lux_tmp_last_146 = 0
            end
            local __lux_tmp_sum_147 = bucket.sum
            if __lux_tmp_sum_147 == nil then
              __lux_tmp_sum_147 = 0
            end
            local __lux_tmp_max_148 = bucket.max
            if __lux_tmp_max_148 == nil then
              __lux_tmp_max_148 = 0
            end
            local __lux_tmp_lastCount_149 = bucket.lastCount
            if __lux_tmp_lastCount_149 == nil then
              __lux_tmp_lastCount_149 = 0
            end
            local __lux_tmp_countSum_150 = bucket.countSum
            if __lux_tmp_countSum_150 == nil then
              __lux_tmp_countSum_150 = 0
            end
            local __lux_tmp_n_151 = bucket.n
            if __lux_tmp_n_151 == nil then
              __lux_tmp_n_151 = 0
            end
            rows[#rows + 1] = {
              name = "[" .. instanceName .. "] " .. name,
              localName = name,
              instance = instanceName,
              instanceId = instanceId,
              last = __lux_tmp_last_146,
              avg = __lux_tmp_sum_147 / n,
              max = __lux_tmp_max_148,
              count = __lux_tmp_lastCount_149,
              avgCount = __lux_tmp_countSum_150 / n,
              samples = __lux_tmp_n_151,
            }
          end
        end
        tableSort(
          rows,
          function(a, b)
            if a.avg == b.avg then
              return a.last > b.last
            else
              return a.avg > b.avg
            end
          end
        )
        while #rows > limit do
          rows[#rows] = nil
        end
        return rows
      end
      api.ScopeRows = function(limit)
        if limit == nil then
          limit = topLimit()
        end
        local rows = {}
        for key, bucket in pairs(scopeRolling) do
          local row = scopeRowFromBucket(key, bucket)
          row.localName = row.name
          row.instance = instanceName
          row.instanceId = instanceId
          row.name = "[" .. instanceName .. "] " .. row.name
          rows[#rows + 1] = row
        end
        tableSort(
          rows,
          function(a, b)
            if a.avg == b.avg then
              return a.last > b.last
            else
              return a.avg > b.avg
            end
          end
        )
        while #rows > limit do
          rows[#rows] = nil
        end
        return rows
      end
      api.RecentScopes = function(limit)
        if limit == nil then
          limit = topLimit()
        end
        local rows = {}
        local first = mathMax(1, #recentScopes - limit + 1)
        for index = #recentScopes, first, -1 do
          rows[#rows + 1] = recentScopes[index]
        end
        return rows
      end
      api.CurrentRows = function(limit)
        if limit == nil then
          limit = topLimit()
        end
        local rows = {}
        do
          local __lux_obj_target_152 = target.stats
          local __lux_tmp_profileTimes_153 = nil
          if __lux_obj_target_152 ~= nil then
            __lux_tmp_profileTimes_153 = __lux_obj_target_152.profileTimes
          end
          if __lux_tmp_profileTimes_153 == nil then
            __lux_tmp_profileTimes_153 = {}
          end
          for name, ms in pairs(__lux_tmp_profileTimes_153) do
            do
              local __lux_tmp_ms_154 = ms
              if __lux_tmp_ms_154 == nil then
                __lux_tmp_ms_154 = 0
              end
              local __lux_tmp_155
              local counts
              do
                local __lux_obj_stats_156 = target.stats
                local __lux_val_profileCounts_157 = nil
                if __lux_obj_stats_156 ~= nil then
                  __lux_val_profileCounts_157 = __lux_obj_stats_156.profileCounts
                end
                counts = __lux_val_profileCounts_157
              end
              if counts ~= nil then
                __lux_tmp_155 = counts[name]
                if __lux_tmp_155 == nil then
                  __lux_tmp_155 = 0
                end
              else
                __lux_tmp_155 = 0
              end
              rows[#rows + 1] = {
                name = "[" .. instanceName .. "] " .. name,
                localName = name,
                instance = instanceName,
                instanceId = instanceId,
                last = __lux_tmp_ms_154,
                count = __lux_tmp_155,
              }
            end
          end
        end
        tableSort(
          rows,
          function(a, b)
            if a.last == b.last then
              return a.name < b.name
            else
              return a.last > b.last
            end
          end
        )
        while #rows > limit do
          rows[#rows] = nil
        end
        return rows
      end
      api.InstanceRows = function(limit)
        if limit == nil then
          limit = topLimit()
        end
        if instanceCurrent ~= nil and instanceCurrent.frame ~= currentEngineFrame() then
          rollInstanceFrame()
          clearInstanceCurrent()
        end
        local bucket = instanceRolling.runtime
        local current = instanceCurrent
        if bucket == nil and current == nil then
          return {}
        end
        local n
        if bucket ~= nil and bucket.n > 0 then
          n = bucket.n
        else
          n = 1
        end
        local meta
        do
          local __lux_obj_bucket_158 = bucket
          local __lux_val_meta_159 = nil
          if __lux_obj_bucket_158 ~= nil then
            __lux_val_meta_159 = __lux_obj_bucket_158.meta
          end
          meta = __lux_val_meta_159
          if meta == nil then
            meta = {}
          end
        end
        local rowStats
        if current ~= nil then
          rowStats = current.stats
        else
          rowStats = meta.stats
          if rowStats == nil then
            rowStats = {}
          end
        end
        local row
        do
          local __lux_tmp_160
          if current ~= nil then
            __lux_tmp_160 = current.elapsed
          else
            do
              local __lux_obj_bucket_161 = bucket
              local __lux_val_last_162 = nil
              if __lux_obj_bucket_161 ~= nil then
                __lux_val_last_162 = __lux_obj_bucket_161.last
              end
              __lux_tmp_160 = __lux_val_last_162
              if __lux_tmp_160 == nil then
                __lux_tmp_160 = 0
              end
            end
          end
          local __lux_tmp_163
          if bucket ~= nil then
            do
              local __lux_tmp_sum_164 = bucket.sum
              if __lux_tmp_sum_164 == nil then
                __lux_tmp_sum_164 = 0
              end
              __lux_tmp_163 = __lux_tmp_sum_164 / n
            end
          else
            do
              local __lux_obj_current_165 = current
              local __lux_val_elapsed_166 = nil
              if __lux_obj_current_165 ~= nil then
                __lux_val_elapsed_166 = __lux_obj_current_165.elapsed
              end
              __lux_tmp_163 = __lux_val_elapsed_166
              if __lux_tmp_163 == nil then
                __lux_tmp_163 = 0
              end
            end
          end
          local __lux_tmp_167
          if bucket ~= nil then
            __lux_tmp_167 = bucket.max
            if __lux_tmp_167 == nil then
              __lux_tmp_167 = 0
            end
          else
            do
              local __lux_obj_current_168 = current
              local __lux_val_elapsed_169 = nil
              if __lux_obj_current_168 ~= nil then
                __lux_val_elapsed_169 = __lux_obj_current_168.elapsed
              end
              __lux_tmp_167 = __lux_val_elapsed_169
              if __lux_tmp_167 == nil then
                __lux_tmp_167 = 0
              end
            end
          end
          local __lux_tmp_170
          if current ~= nil then
            __lux_tmp_170 = current.scopes
          else
            do
              local __lux_obj_bucket_171 = bucket
              local __lux_val_lastCount_172 = nil
              if __lux_obj_bucket_171 ~= nil then
                __lux_val_lastCount_172 = __lux_obj_bucket_171.lastCount
              end
              __lux_tmp_170 = __lux_val_lastCount_172
              if __lux_tmp_170 == nil then
                __lux_tmp_170 = 0
              end
            end
          end
          local __lux_tmp_173
          if bucket ~= nil then
            do
              local __lux_tmp_countSum_174 = bucket.countSum
              if __lux_tmp_countSum_174 == nil then
                __lux_tmp_countSum_174 = 0
              end
              __lux_tmp_173 = __lux_tmp_countSum_174 / n
            end
          else
            do
              local __lux_obj_current_175 = current
              local __lux_val_scopes_176 = nil
              if __lux_obj_current_175 ~= nil then
                __lux_val_scopes_176 = __lux_obj_current_175.scopes
              end
              __lux_tmp_173 = __lux_val_scopes_176
              if __lux_tmp_173 == nil then
                __lux_tmp_173 = 0
              end
            end
          end
          local __lux_obj_bucket_177 = bucket
          local __lux_tmp_n_178 = nil
          if __lux_obj_bucket_177 ~= nil then
            __lux_tmp_n_178 = __lux_obj_bucket_177.n
          end
          if __lux_tmp_n_178 == nil then
            __lux_tmp_n_178 = 0
          end
          row = {
            name = "[" .. instanceName .. "] total",
            localName = "total",
            instance = instanceName,
            instanceId = instanceId,
            last = __lux_tmp_160,
            avg = __lux_tmp_163,
            max = __lux_tmp_167,
            count = __lux_tmp_170,
            avgCount = __lux_tmp_173,
            samples = __lux_tmp_n_178,
            stats = rowStats,
            profileTop = topRowsFromBuckets(instanceProfileRolling, limit, nil, true),
            apiTop = topRowsFromBuckets(instanceProfileRolling, limit, "api.", false),
            commandTop = topRowsFromBuckets(instanceCommandRolling, limit),
            immediateTop = topRowsFromBuckets(instanceImmediateRolling, limit),
          }
        end
        if #row.profileTop == 0 and current ~= nil then
          row.profileTop = topRowsFromCounts(current.profileTimes, current.profileCounts, limit, nil, true)
        end
        if #row.apiTop == 0 and current ~= nil then
          row.apiTop = topRowsFromCounts(current.profileTimes, current.profileCounts, limit, "api.", false)
        end
        if #row.commandTop == 0 and current ~= nil then
          row.commandTop = topRowsFromCounts(current.commandCounts, current.commandCounts, limit)
        end
        if #row.immediateTop == 0 and current ~= nil then
          row.immediateTop = topRowsFromCounts(current.immediateCounts, current.immediateCounts, limit)
        end
        return { row }
      end
      api.FormatRows = function(rows, rollingRows)
        if rollingRows == nil then
          rollingRows = false
        end
        local out = {}
        do
          local __lux_tmp_rows_179 = rows
          if __lux_tmp_rows_179 == nil then
            __lux_tmp_rows_179 = {}
          end
          for _, row in ipairs(__lux_tmp_rows_179) do
            if rollingRows then
              do
                local __lux_tmp_last_180 = row.last
                if __lux_tmp_last_180 == nil then
                  __lux_tmp_last_180 = 0
                end
                local __lux_tmp_avg_181 = row.avg
                if __lux_tmp_avg_181 == nil then
                  __lux_tmp_avg_181 = 0
                end
                local __lux_tmp_max_182 = row.max
                if __lux_tmp_max_182 == nil then
                  __lux_tmp_max_182 = 0
                end
                local __lux_tmp_count_183 = row.count
                if __lux_tmp_count_183 == nil then
                  __lux_tmp_count_183 = 0
                end
                local __lux_tmp_avgCount_184 = row.avgCount
                if __lux_tmp_avgCount_184 == nil then
                  __lux_tmp_avgCount_184 = 0
                end
                local __lux_tmp_samples_185 = row.samples
                if __lux_tmp_samples_185 == nil then
                  __lux_tmp_samples_185 = 0
                end
                out[#out + 1] = stringFormat(
                  "%s last=%.3f avg=%.3f max=%.3f count=%d avgCount=%.1f samples=%d",
                  row.name,
                  __lux_tmp_last_180,
                  __lux_tmp_avg_181,
                  __lux_tmp_max_182,
                  __lux_tmp_count_183,
                  __lux_tmp_avgCount_184,
                  __lux_tmp_samples_185
                )
              end
            else
              do
                local __lux_tmp_last_186 = row.last
                if __lux_tmp_last_186 == nil then
                  __lux_tmp_last_186 = 0
                end
                local __lux_tmp_count_187 = row.count
                if __lux_tmp_count_187 == nil then
                  __lux_tmp_count_187 = 0
                end
                out[#out + 1] = stringFormat("%s %.3fms count=%d", row.name, __lux_tmp_last_186, __lux_tmp_count_187)
              end
            end
          end
        end
        return out
      end
      api.FormatScopeRows = function(rows, includeBreakdown)
        if includeBreakdown == nil then
          includeBreakdown = false
        end
        local out = {}
        do
          local __lux_tmp_rows_188 = rows
          if __lux_tmp_rows_188 == nil then
            __lux_tmp_rows_188 = {}
          end
          for _, row in ipairs(__lux_tmp_rows_188) do
            local stats = row.stats
            if stats == nil then
              stats = {}
            end
            do
              local __lux_tmp_name_189 = row.name
              if __lux_tmp_name_189 == nil then
                __lux_tmp_name_189 = row.key
              end
              if __lux_tmp_name_189 == nil then
                __lux_tmp_name_189 = "scope"
              end
              local __lux_tmp_last_190 = row.last
              if __lux_tmp_last_190 == nil then
                __lux_tmp_last_190 = 0
              end
              local __lux_tmp_avg_191 = row.avg
              if __lux_tmp_avg_191 == nil then
                __lux_tmp_avg_191 = row.last
              end
              if __lux_tmp_avg_191 == nil then
                __lux_tmp_avg_191 = 0
              end
              local __lux_tmp_max_192 = row.max
              if __lux_tmp_max_192 == nil then
                __lux_tmp_max_192 = row.last
              end
              if __lux_tmp_max_192 == nil then
                __lux_tmp_max_192 = 0
              end
              local __lux_tmp_draws_193 = stats.draws
              if __lux_tmp_draws_193 == nil then
                __lux_tmp_draws_193 = 0
              end
              local __lux_tmp_blurPasses_194 = stats.blurPasses
              if __lux_tmp_blurPasses_194 == nil then
                __lux_tmp_blurPasses_194 = 0
              end
              local __lux_tmp_textDraws_195 = stats.textDraws
              if __lux_tmp_textDraws_195 == nil then
                __lux_tmp_textDraws_195 = 0
              end
              local __lux_tmp_textShaderDraws_196 = stats.textShaderDraws
              if __lux_tmp_textShaderDraws_196 == nil then
                __lux_tmp_textShaderDraws_196 = 0
              end
              local __lux_tmp_textComposedBakes_197 = stats.textComposedBakes
              if __lux_tmp_textComposedBakes_197 == nil then
                __lux_tmp_textComposedBakes_197 = 0
              end
              local __lux_tmp_fallbacks_198 = stats.fallbacks
              if __lux_tmp_fallbacks_198 == nil then
                __lux_tmp_fallbacks_198 = 0
              end
              local __lux_tmp_samples_199 = row.samples
              if __lux_tmp_samples_199 == nil then
                __lux_tmp_samples_199 = 1
              end
              local __lux_tmp_callsite_200 = row.callsite
              if __lux_tmp_callsite_200 == nil then
                __lux_tmp_callsite_200 = "unknown"
              end
              out[#out + 1] = stringFormat(
                "%s last=%.3f avg=%.3f max=%.3f draws=%d blur=%d text=%d shaderText=%d bakes=%d fallbacks=%d samples=%d call=%s",
                __lux_tmp_name_189,
                __lux_tmp_last_190,
                __lux_tmp_avg_191,
                __lux_tmp_max_192,
                __lux_tmp_draws_193,
                __lux_tmp_blurPasses_194,
                __lux_tmp_textDraws_195,
                __lux_tmp_textShaderDraws_196,
                __lux_tmp_textComposedBakes_197,
                __lux_tmp_fallbacks_198,
                __lux_tmp_samples_199,
                __lux_tmp_callsite_200
              )
            end
            if includeBreakdown then
              local top = row.profileTop
              if top == nil then
                top = topRowsFromCounts(row.profileTimes, row.profileCounts, 5)
              end
              if #top > 0 then
                local parts = {}
                for index = 1, #top do
                  local item = top[index]
                  do
                    local __lux_tmp_last_201 = item.last
                    if __lux_tmp_last_201 == nil then
                      __lux_tmp_last_201 = 0
                    end
                    local __lux_tmp_count_202 = item.count
                    if __lux_tmp_count_202 == nil then
                      __lux_tmp_count_202 = 0
                    end
                    parts[#parts + 1] = stringFormat("%s=%.3fms/%d", item.name, __lux_tmp_last_201, __lux_tmp_count_202)
                  end
                end
                out[#out + 1] = "  top " .. tableConcat(parts, "  ")
              end
              local commands = row.commandCounts
              if commands == nil then
                commands = {}
              end
              local __lux_cmp_203 = false
              if sumCounts(commands) ~= nil then
                __lux_cmp_203 = sumCounts(commands) > 0
              end
              if __lux_cmp_203 then
                local parts = {}
                for key, value in pairs(commands) do
                  parts[#parts + 1] = toString(key) .. "=" .. toString(value)
                end
                tableSort(parts)
                out[#out + 1] = "  commands " .. tableConcat(parts, " ")
              end
            end
          end
        end
        return out
      end
      local unwrapApi
      local wrapApi
      local unwrapKnownProfilerWrapper
      unwrapKnownProfilerWrapper = function(fnValue, depth)
        if depth == nil then
          depth = 0
        end
        if typeOf(fnValue) ~= "function" or debugLib == nil or debugLib.getupvalue == nil or depth > 8 then
          return fnValue
        end
        local original = nil
        local profilerLabel = false
        for i = 1, 16 do
          local name, value = debugLib.getupvalue(fnValue, i)
          if name == nil then
            break
          end
          if name == "original" and typeOf(value) == "function" then
            original = value
          else
            if name == "label" and typeOf(value) == "string" and stringSub(value, 1, 4) == "api." then
              profilerLabel = true
            end
          end
        end
        if profilerLabel and original ~= nil then
          return unwrapKnownProfilerWrapper(original, depth + 1)
        end
        return fnValue
      end
      local restoreSharedWrappers = function(ownerValue, names)
        if ownerValue == nil or names == nil then
          return
        end
        local sharedOriginals = ownerValue._mgfxProfileOriginals
        for _, name in ipairs(names) do
          local current = ownerValue[name]
          local unwrapped = unwrapKnownProfilerWrapper(current)
          if unwrapped ~= current then
            ownerValue[name] = unwrapped
          end
          if sharedOriginals ~= nil then
            sharedOriginals[name] = nil
          end
        end
      end
      unwrapApi = function()
        if not wrappersInstalled or wrappedOwner == nil then
          return
        end
        local originalsStore = wrappedOwner._mgfxProfileOriginals
        for name, original in pairs(wrappedOriginals) do
          if wrappedOwner[name] ~= original then
            local unwrapped = unwrapKnownProfilerWrapper(wrappedOwner[name])
            if unwrapped ~= wrappedOwner[name] then
              wrappedOwner[name] = unwrapped
            end
          else
            wrappedOwner[name] = original
          end
          if originalsStore ~= nil then
            originalsStore[name] = nil
          end
          wrappedOriginals[name] = nil
        end
        wrappersInstalled = false
      end
      wrapApi = function()
        if wrappersInstalled or wrappedOwner == nil then
          return
        end
        do
          local __lux_tmp_mgfxProfileOriginals_204 = wrappedOwner._mgfxProfileOriginals
          if __lux_tmp_mgfxProfileOriginals_204 == nil then
            __lux_tmp_mgfxProfileOriginals_204 = {}
          end
          wrappedOwner._mgfxProfileOriginals = __lux_tmp_mgfxProfileOriginals_204
        end
        local originalsStore = wrappedOwner._mgfxProfileOriginals
        do
          local __lux_tmp_wrappedNames_205 = wrappedNames
          if __lux_tmp_wrappedNames_205 == nil then
            __lux_tmp_wrappedNames_205 = {}
          end
          for _, name in ipairs(__lux_tmp_wrappedNames_205) do
            local original = unwrapKnownProfilerWrapper(wrappedOwner[name])
            if typeOf(original) == "function" and wrappedOriginals[name] == nil then
              local label = "api." .. name
              wrappedOriginals[name] = original
              originalsStore[name] = original
              wrappedOwner[name] = function(...)
                local started = active and not (typeOf(wrappedSuppress) == "function" and wrappedSuppress()) and sysTime() or nil
                local a, b, c, d, e, f = original(...)
                if started ~= nil then
                  api.Record(label, (sysTime() - started) * 1000, 1)
                end
                return a, b, c, d, e, f
              end
            else
              if wrappedSuppress ~= true then
                print("[MGFX] profiler wrapper skipped missing api: " .. toString(name))
              end
            end
          end
        end
        wrappersInstalled = true
      end
      api.InstallApiWrappers = function(owner, names, suppress)
        if suppress == nil then
          suppress = false
        end
        restoreSharedWrappers(owner, names)
        wrappedOwner = owner
        wrappedNames = names
        wrappedSuppress = suppress
        if cvarsLib ~= nil and cvarsLib.RemoveChangeCallback ~= nil then
          cvarsLib.RemoveChangeCallback("mgfx_profile", callbackId)
        end
        if cvarsLib ~= nil and cvarsLib.AddChangeCallback ~= nil then
          cvarsLib.AddChangeCallback(
            "mgfx_profile",
            function(_, _, newValue)
              if toBool(newValue) then
                return wrapApi()
              else
                return unwrapApi()
              end
            end,
            callbackId
          )
        end
        if isEnabled() then
          wrapApi()
        end
      end
      registry.items[instanceId] = {
        id = instanceId,
        name = instanceName,
        owner = target,
        profiler = api,
        callbackId = callbackId,
      }
      target._ProfilerInstanceId = instanceId
      target._ProfilerName = instanceName
      return api
    end
    install = function(owner)
      do
        local __lux_tmp_stats_206 = owner.stats
        if __lux_tmp_stats_206 == nil then
          __lux_tmp_stats_206 = {}
        end
        owner.stats = __lux_tmp_stats_206
      end
      do
        local __lux_tmp_profileTimes_207 = owner.stats.profileTimes
        if __lux_tmp_profileTimes_207 == nil then
          __lux_tmp_profileTimes_207 = {}
        end
        owner.stats.profileTimes = __lux_tmp_profileTimes_207
      end
      do
        local __lux_tmp_profileCounts_208 = owner.stats.profileCounts
        if __lux_tmp_profileCounts_208 == nil then
          __lux_tmp_profileCounts_208 = {}
        end
        owner.stats.profileCounts = __lux_tmp_profileCounts_208
      end
      local api = create(owner)
      owner.Profiler = api
      owner.BeginProfileFrame = api.BeginFrame
      owner.EndProfileFrame = api.EndFrame
      owner.GetProfileRows = api.Snapshot
      owner.GetCurrentProfileRows = api.CurrentRows
      owner.GetProfileScopeRows = api.ScopeRows
      owner.GetRecentProfileScopes = api.RecentScopes
      owner.GetProfileInstanceRows = api.InstanceRows
      owner.FormatProfileRows = api.FormatRows
      owner.FormatProfileScopeRows = api.FormatScopeRows
      owner.ResetProfile = api.Reset
      owner.InstallApiWrappers = api.InstallApiWrappers
      owner.BeginTrace = api.BeginTrace
      owner.EndTrace = api.EndTrace
      owner.TraceStart = api.TraceStart
      owner.TraceEnd = api.TraceEnd
      return owner
    end
  end

  __lux_exports.create = create
  __lux_exports.install = install

  return __lux_exports
end
