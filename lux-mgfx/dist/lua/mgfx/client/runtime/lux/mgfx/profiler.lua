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
        local __lux_tmp_1 = source
        if __lux_tmp_1 == nil then
          __lux_tmp_1 = {}
        end
        for key, value in pairs(__lux_tmp_1) do
          do
            local __lux_tmp_2 = toNumber(value)
            if __lux_tmp_2 == nil then
              __lux_tmp_2 = 0
            end
            out[key] = __lux_tmp_2
          end
        end
      end
      return out
    end
    addCountsInto = function(out, source)
      do
        local __lux_tmp_3 = source
        if __lux_tmp_3 == nil then
          __lux_tmp_3 = {}
        end
        for key, value in pairs(__lux_tmp_3) do
          do
            local __lux_tmp_4 = out[key]
            if __lux_tmp_4 == nil then
              __lux_tmp_4 = 0
            end
            local __lux_tmp_5 = toNumber(value)
            if __lux_tmp_5 == nil then
              __lux_tmp_5 = 0
            end
            out[key] = __lux_tmp_4 + __lux_tmp_5
          end
        end
      end
    end
    copyScalarStats = function(source)
      local out = {}
      for index = 1, #scalarStatKeys do
        local key = scalarStatKeys[index]
        do
          local __lux_obj_6 = source
          local __lux_val_8 = nil
          if __lux_obj_6 ~= nil then
            local __lux_key_7 = key
            __lux_val_8 = __lux_obj_6[__lux_key_7]
          end
          local __lux_tmp_9 = toNumber(__lux_val_8)
          if __lux_tmp_9 == nil then
            __lux_tmp_9 = 0
          end
          out[key] = __lux_tmp_9
        end
      end
      return out
    end
    snapshotStats = function(target)
      local stats
      do
        local __lux_tmp_10 = target.stats
        if __lux_tmp_10 == nil then
          __lux_tmp_10 = {}
        end
        stats = __lux_tmp_10
      end
      local out = {}
      for index = 1, #scalarStatKeys do
        local key = scalarStatKeys[index]
        do
          local __lux_tmp_11 = toNumber(stats[key])
          if __lux_tmp_11 == nil then
            __lux_tmp_11 = 0
          end
          out[key] = __lux_tmp_11
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
        local __lux_tmp_12 = after
        if __lux_tmp_12 == nil then
          __lux_tmp_12 = {}
        end
        for key, value in pairs(__lux_tmp_12) do
          local delta
          do
            local __lux_tmp_13 = toNumber(value)
            if __lux_tmp_13 == nil then
              __lux_tmp_13 = 0
            end
            local __lux_obj_14 = before
            local __lux_val_16 = nil
            if __lux_obj_14 ~= nil then
              local __lux_key_15 = key
              __lux_val_16 = __lux_obj_14[__lux_key_15]
            end
            local __lux_tmp_17 = toNumber(__lux_val_16)
            if __lux_tmp_17 == nil then
              __lux_tmp_17 = 0
            end
            delta = __lux_tmp_13 - __lux_tmp_17
          end
          if delta ~= 0 then
            out[key] = delta
            total = total + delta
          end
        end
      end
      do
        local __lux_tmp_18 = before
        if __lux_tmp_18 == nil then
          __lux_tmp_18 = {}
        end
        for key, value in pairs(__lux_tmp_18) do
          local __lux_tmp_19 = after == nil
          if not __lux_tmp_19 then
            __lux_tmp_19 = after[key] == nil
          end
          if __lux_tmp_19 then
            local delta
            do
              local __lux_tmp_20 = toNumber(value)
              if __lux_tmp_20 == nil then
                __lux_tmp_20 = 0
              end
              delta = -__lux_tmp_20
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
          local __lux_tmp_21 = now[key]
          if __lux_tmp_21 == nil then
            __lux_tmp_21 = 0
          end
          local __lux_obj_22 = startedStats
          local __lux_val_24 = nil
          if __lux_obj_22 ~= nil then
            local __lux_key_23 = key
            __lux_val_24 = __lux_obj_22[__lux_key_23]
          end
          local __lux_tmp_25 = __lux_val_24
          if __lux_tmp_25 == nil then
            __lux_tmp_25 = 0
          end
          out[key] = __lux_tmp_21 - __lux_tmp_25
        end
      end
      for index = 1, #tableStatKeys do
        local key = tableStatKeys[index]
        do
          local __lux_obj_26 = startedStats
          local __lux_val_28 = nil
          if __lux_obj_26 ~= nil then
            local __lux_key_27 = key
            __lux_val_28 = __lux_obj_26[__lux_key_27]
          end
          out[key] = diffCounts(now[key], __lux_val_28)
        end
      end
      return out
    end
    sumCounts = function(source)
      local total = 0
      do
        local __lux_tmp_29 = source
        if __lux_tmp_29 == nil then
          __lux_tmp_29 = {}
        end
        for _, value in pairs(__lux_tmp_29) do
          do
            local __lux_tmp_30 = toNumber(value)
            if __lux_tmp_30 == nil then
              __lux_tmp_30 = 0
            end
            total = total + __lux_tmp_30
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
        local __lux_tmp_31 = times
        if __lux_tmp_31 == nil then
          __lux_tmp_31 = {}
        end
        for name, ms in pairs(__lux_tmp_31) do
          local include
          do
            local __lux_tmp_32 = prefix == nil
            if not __lux_tmp_32 then
              __lux_tmp_32 = stringSub(toString(name), 1, #prefix) == prefix
            end
            include = __lux_tmp_32
          end
          local __lux_tmp_33 = include
          if __lux_tmp_33 then
            local __lux_tmp_34 = not omitBroad
            if not __lux_tmp_34 then
              __lux_tmp_34 = broadProfileLabels[name] ~= true
            end
            __lux_tmp_33 = __lux_tmp_34
          end
          if __lux_tmp_33 then
            do
              local __lux_tmp_35 = ms
              if __lux_tmp_35 == nil then
                __lux_tmp_35 = 0
              end
              local __lux_tmp_36 = ms
              if __lux_tmp_36 == nil then
                __lux_tmp_36 = 0
              end
              local __lux_tmp_37 = ms
              if __lux_tmp_37 == nil then
                __lux_tmp_37 = 0
              end
              local __lux_obj_38 = counts
              local __lux_val_40 = nil
              if __lux_obj_38 ~= nil then
                local __lux_key_39 = name
                __lux_val_40 = __lux_obj_38[__lux_key_39]
              end
              local __lux_tmp_41 = __lux_val_40
              if __lux_tmp_41 == nil then
                __lux_tmp_41 = 0
              end
              local __lux_obj_42 = counts
              local __lux_val_44 = nil
              if __lux_obj_42 ~= nil then
                local __lux_key_43 = name
                __lux_val_44 = __lux_obj_42[__lux_key_43]
              end
              local __lux_tmp_45 = __lux_val_44
              if __lux_tmp_45 == nil then
                __lux_tmp_45 = 0
              end
              rows[#rows + 1] = {
                name = name,
                last = __lux_tmp_35,
                avg = __lux_tmp_36,
                max = __lux_tmp_37,
                count = __lux_tmp_41,
                avgCount = __lux_tmp_45,
              }
            end
          end
        end
      end
      tableSort(
        rows,
        function(a, b)
          do
            local __lux_tmp_46 = a.avg
            if __lux_tmp_46 == nil then
              local __lux_tmp_47 = a.last
              if __lux_tmp_47 == nil then
                __lux_tmp_47 = 0
              end
              __lux_tmp_46 = __lux_tmp_47
            end
            local __lux_tmp_48 = b.avg
            if __lux_tmp_48 == nil then
              local __lux_tmp_49 = b.last
              if __lux_tmp_49 == nil then
                __lux_tmp_49 = 0
              end
              __lux_tmp_48 = __lux_tmp_49
            end
            if __lux_tmp_46 == __lux_tmp_48 then
              return a.name < b.name
            else
              local __lux_tmp_50 = a.avg
              if __lux_tmp_50 == nil then
                local __lux_tmp_51 = a.last
                if __lux_tmp_51 == nil then
                  __lux_tmp_51 = 0
                end
                __lux_tmp_50 = __lux_tmp_51
              end
              local __lux_tmp_52 = b.avg
              if __lux_tmp_52 == nil then
                local __lux_tmp_53 = b.last
                if __lux_tmp_53 == nil then
                  __lux_tmp_53 = 0
                end
                __lux_tmp_52 = __lux_tmp_53
              end
              return __lux_tmp_50 > __lux_tmp_52
            end
          end
        end
      )
      do
        local __lux_tmp_54 = toNumber(limit)
        if __lux_tmp_54 == nil then
          __lux_tmp_54 = 6
        end
        limit = mathMax(1, __lux_tmp_54)
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
        local __lux_tmp_55 = store
        if __lux_tmp_55 == nil then
          __lux_tmp_55 = {}
        end
        for key, bucket in pairs(__lux_tmp_55) do
          local name
          do
            local __lux_obj_56 = bucket.meta
            local __lux_val_57 = nil
            if __lux_obj_56 ~= nil then
              __lux_val_57 = __lux_obj_56.name
            end
            local __lux_tmp_58 = __lux_val_57
            if __lux_tmp_58 == nil then
              __lux_tmp_58 = key
            end
            name = __lux_tmp_58
          end
          local include
          do
            local __lux_tmp_59 = prefix == nil
            if not __lux_tmp_59 then
              __lux_tmp_59 = stringSub(toString(name), 1, #prefix) == prefix
            end
            include = __lux_tmp_59
          end
          local __lux_tmp_60 = include
          if __lux_tmp_60 then
            local __lux_tmp_61 = not omitBroad
            if not __lux_tmp_61 then
              __lux_tmp_61 = broadProfileLabels[name] ~= true
            end
            __lux_tmp_60 = __lux_tmp_61
          end
          if __lux_tmp_60 then
            local n
            if bucket.n > 0 then
              n = bucket.n
            else
              n = 1
            end
            do
              local __lux_tmp_62 = bucket.last
              if __lux_tmp_62 == nil then
                __lux_tmp_62 = 0
              end
              local __lux_tmp_63 = bucket.sum
              if __lux_tmp_63 == nil then
                __lux_tmp_63 = 0
              end
              local __lux_tmp_64 = bucket.max
              if __lux_tmp_64 == nil then
                __lux_tmp_64 = 0
              end
              local __lux_tmp_65 = bucket.lastCount
              if __lux_tmp_65 == nil then
                __lux_tmp_65 = 0
              end
              local __lux_tmp_66 = bucket.countSum
              if __lux_tmp_66 == nil then
                __lux_tmp_66 = 0
              end
              local __lux_tmp_67 = bucket.n
              if __lux_tmp_67 == nil then
                __lux_tmp_67 = 0
              end
              rows[#rows + 1] = {
                name = name,
                last = __lux_tmp_62,
                avg = __lux_tmp_63 / n,
                max = __lux_tmp_64,
                count = __lux_tmp_65,
                avgCount = __lux_tmp_66 / n,
                samples = __lux_tmp_67,
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
        local __lux_tmp_68 = toNumber(limit)
        if __lux_tmp_68 == nil then
          __lux_tmp_68 = 6
        end
        limit = mathMax(1, __lux_tmp_68)
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
      local source
      do
        local __lux_tmp_69 = callsite.short_src
        if __lux_tmp_69 == nil then
          local __lux_tmp_70 = callsite.source
          if __lux_tmp_70 == nil then
            local __lux_tmp_71 = callsite.file
            if __lux_tmp_71 == nil then
              __lux_tmp_71 = "?"
            end
            __lux_tmp_70 = __lux_tmp_71
          end
          __lux_tmp_69 = __lux_tmp_70
        end
        source = __lux_tmp_69
      end
      local line
      do
        local __lux_tmp_72 = callsite.currentline
        if __lux_tmp_72 == nil then
          local __lux_tmp_73 = callsite.line
          if __lux_tmp_73 == nil then
            __lux_tmp_73 = 0
          end
          __lux_tmp_72 = __lux_tmp_73
        end
        line = __lux_tmp_72
      end
      local name = callsite.name
      local __lux_tmp_74 = name ~= nil
      if __lux_tmp_74 then
        __lux_tmp_74 = name ~= ""
      end
      if __lux_tmp_74 then
        return toString(source) .. ":" .. toString(line) .. " " .. toString(name)
      end
      return toString(source) .. ":" .. toString(line)
    end
    panelLabel = function(panel, kind)
      local __lux_tmp_75 = kind == "screen"
      if not __lux_tmp_75 then
        __lux_tmp_75 = panel == nil
      end
      if __lux_tmp_75 then
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
      local __lux_tmp_76 = className ~= nil
      if __lux_tmp_76 then
        __lux_tmp_76 = className ~= ""
      end
      if __lux_tmp_76 then
        parts[#parts + 1] = className
      end
      local __lux_tmp_77 = panelName ~= nil
      if __lux_tmp_77 then
        __lux_tmp_77 = panelName ~= ""
      end
      local __lux_tmp_78 = __lux_tmp_77
      if __lux_tmp_78 then
        __lux_tmp_78 = panelName ~= className
      end
      if __lux_tmp_78 then
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
        local __lux_tmp_79 = kind
        if __lux_tmp_79 == nil then
          __lux_tmp_79 = "frame"
        end
        kind = toString(__lux_tmp_79)
      end
      if subject ~= nil then
        return kind .. ":" .. toString(subject)
      end
      local callsite
      do
        local __lux_obj_80 = info
        local __lux_val_81 = nil
        if __lux_obj_80 ~= nil then
          __lux_val_81 = __lux_obj_80.callsite
        end
        callsite = __lux_val_81
      end
      if callsite ~= nil then
        return kind .. ":" .. formatCallsite(callsite)
      end
      return kind .. ":unknown"
    end
    scopeRowFromBucket = function(key, bucket)
      local meta
      do
        local __lux_tmp_82 = bucket.meta
        if __lux_tmp_82 == nil then
          __lux_tmp_82 = {}
        end
        meta = __lux_tmp_82
      end
      local n
      if bucket.n > 0 then
        n = bucket.n
      else
        n = 1
      end
      local stats
      do
        local __lux_tmp_83 = meta.stats
        if __lux_tmp_83 == nil then
          __lux_tmp_83 = {}
        end
        stats = __lux_tmp_83
      end
      local __lux_tmp_84 = meta.name
      if __lux_tmp_84 == nil then
        __lux_tmp_84 = key
      end
      local __lux_tmp_85 = meta.kind
      if __lux_tmp_85 == nil then
        __lux_tmp_85 = "frame"
      end
      local __lux_tmp_86 = meta.callsiteText
      if __lux_tmp_86 == nil then
        __lux_tmp_86 = "unknown"
      end
      local __lux_tmp_87 = bucket.last
      if __lux_tmp_87 == nil then
        __lux_tmp_87 = 0
      end
      local __lux_tmp_88 = bucket.sum
      if __lux_tmp_88 == nil then
        __lux_tmp_88 = 0
      end
      local __lux_tmp_89 = bucket.max
      if __lux_tmp_89 == nil then
        __lux_tmp_89 = 0
      end
      local __lux_tmp_90 = bucket.lastCount
      if __lux_tmp_90 == nil then
        __lux_tmp_90 = 0
      end
      local __lux_tmp_91 = bucket.countSum
      if __lux_tmp_91 == nil then
        __lux_tmp_91 = 0
      end
      local __lux_tmp_92 = bucket.n
      if __lux_tmp_92 == nil then
        __lux_tmp_92 = 0
      end
      local __lux_tmp_93 = meta.profileTimes
      if __lux_tmp_93 == nil then
        __lux_tmp_93 = {}
      end
      local __lux_tmp_94 = meta.profileCounts
      if __lux_tmp_94 == nil then
        __lux_tmp_94 = {}
      end
      local __lux_tmp_95 = meta.profileTop
      if __lux_tmp_95 == nil then
        __lux_tmp_95 = {}
      end
      local __lux_tmp_96 = stats.drawCommandCounts
      if __lux_tmp_96 == nil then
        __lux_tmp_96 = {}
      end
      local __lux_tmp_97 = stats.drawImmediateCounts
      if __lux_tmp_97 == nil then
        __lux_tmp_97 = {}
      end
      return {
        key = key,
        name = __lux_tmp_84,
        kind = __lux_tmp_85,
        callsite = __lux_tmp_86,
        last = __lux_tmp_87,
        avg = __lux_tmp_88 / n,
        max = __lux_tmp_89,
        count = __lux_tmp_90,
        avgCount = __lux_tmp_91 / n,
        samples = __lux_tmp_92,
        stats = stats,
        profileTimes = __lux_tmp_93,
        profileCounts = __lux_tmp_94,
        profileTop = __lux_tmp_95,
        commandCounts = __lux_tmp_96,
        immediateCounts = __lux_tmp_97,
      }
    end
    sourceInstanceName = function(target, instanceId)
      local explicit
      do
        local __lux_obj_98 = target
        local __lux_val_99 = nil
        if __lux_obj_98 ~= nil then
          __lux_val_99 = __lux_obj_98._ProfilerName
        end
        local __lux_tmp_100 = __lux_val_99
        if __lux_tmp_100 == nil then
          local __lux_obj_101 = target
          local __lux_val_102 = nil
          if __lux_obj_101 ~= nil then
            __lux_val_102 = __lux_obj_101._LuxRuntimeBase
          end
          __lux_tmp_100 = __lux_val_102
        end
        explicit = __lux_tmp_100
      end
      if explicit ~= nil then
        return toString(explicit)
      end
      local __lux_tmp_103 = debugLib ~= nil
      if __lux_tmp_103 then
        __lux_tmp_103 = debugLib.getinfo ~= nil
      end
      local __lux_tmp_104 = __lux_tmp_103
      if __lux_tmp_104 then
        __lux_tmp_104 = stringMatch ~= nil
      end
      if __lux_tmp_104 then
        local info = debugLib.getinfo(create, "S")
        local source
        do
          local __lux_obj_105 = info
          local __lux_val_106 = nil
          if __lux_obj_105 ~= nil then
            __lux_val_106 = __lux_obj_105.source
          end
          local __lux_tmp_107 = __lux_val_106
          if __lux_tmp_107 == nil then
            local __lux_obj_108 = info
            local __lux_val_109 = nil
            if __lux_obj_108 ~= nil then
              __lux_val_109 = __lux_obj_108.short_src
            end
            __lux_tmp_107 = __lux_val_109
          end
          source = __lux_tmp_107
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
      local target
      do
        local __lux_tmp_110 = owner
        if __lux_tmp_110 == nil then
          __lux_tmp_110 = {}
        end
        target = __lux_tmp_110
      end
      local enabledConVar
      do
        local __lux_obj_111 = options
        local __lux_val_112 = nil
        if __lux_obj_111 ~= nil then
          __lux_val_112 = __lux_obj_111.enabledConVar
        end
        local __lux_tmp_113 = __lux_val_112
        if __lux_tmp_113 == nil then
          __lux_tmp_113 = makeConVar("mgfx_profile", "0", "MGFX: enable renderer profiler.")
        end
        enabledConVar = __lux_tmp_113
      end
      local windowConVar
      do
        local __lux_obj_114 = options
        local __lux_val_115 = nil
        if __lux_obj_114 ~= nil then
          __lux_val_115 = __lux_obj_114.windowConVar
        end
        local __lux_tmp_116 = __lux_val_115
        if __lux_tmp_116 == nil then
          __lux_tmp_116 = makeConVar("mgfx_profile_window", "120", "MGFX: rolling profiler sample window.")
        end
        windowConVar = __lux_tmp_116
      end
      local topConVar
      do
        local __lux_obj_117 = options
        local __lux_val_118 = nil
        if __lux_obj_117 ~= nil then
          __lux_val_118 = __lux_obj_117.topConVar
        end
        local __lux_tmp_119 = __lux_val_118
        if __lux_tmp_119 == nil then
          __lux_tmp_119 = makeConVar(
          "mgfx_profile_top",
          "18",
          "MGFX: number of profiler rows printed by mgfx_profile_status."
        )
        end
        topConVar = __lux_tmp_119
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
      local globalMGFX
      do
        local __lux_tmp_120 = globalTable.MGFX
        if __lux_tmp_120 == nil then
          __lux_tmp_120 = {}
        end
        globalMGFX = __lux_tmp_120
      end
      globalTable.MGFX = globalMGFX
      local registry
      do
        local __lux_tmp_121 = globalMGFX._ProfilerRegistry
        if __lux_tmp_121 == nil then
          __lux_tmp_121 = { items = {}, nextId = 0 }
        end
        registry = __lux_tmp_121
      end
      globalMGFX._ProfilerRegistry = registry
      do
        local __lux_tmp_122 = registry.items
        if __lux_tmp_122 == nil then
          __lux_tmp_122 = {}
        end
        registry.items = __lux_tmp_122
      end
      for id, item in pairs(registry.items) do
        if item.owner == target then
          local __lux_tmp_123 = item.callbackId ~= nil
          if __lux_tmp_123 then
            __lux_tmp_123 = cvarsLib ~= nil
          end
          local __lux_tmp_124 = __lux_tmp_123
          if __lux_tmp_124 then
            __lux_tmp_124 = cvarsLib.RemoveChangeCallback ~= nil
          end
          if __lux_tmp_124 then
            cvarsLib.RemoveChangeCallback("mgfx_profile", item.callbackId)
          end
          registry.items[id] = nil
        end
      end
      do
        local __lux_tmp_125 = registry.nextId
        if __lux_tmp_125 == nil then
          __lux_tmp_125 = 0
        end
        registry.nextId = __lux_tmp_125 + 1
      end
      local instanceId = registry.nextId
      local instanceName = sourceInstanceName(target, instanceId)
      local callbackId = "MGFXProfileApiWrappers" .. toString(instanceId)
      local api = {}
      local isEnabled = function()
        local __lux_tmp_126 = enabledConVar ~= nil
        if __lux_tmp_126 then
          __lux_tmp_126 = enabledConVar.GetBool ~= nil
        end
        local __lux_tmp_127 = __lux_tmp_126
        if __lux_tmp_127 then
          __lux_tmp_127 = enabledConVar:GetBool()
        end
        local __lux_tmp_128 = __lux_tmp_127
        if not __lux_tmp_128 then
          __lux_tmp_128 = false
        end
        return __lux_tmp_128
      end
      local windowSize = function()
        local __lux_tmp_129 = windowConVar ~= nil
        if __lux_tmp_129 then
          __lux_tmp_129 = windowConVar.GetInt ~= nil
        end
        local __lux_tmp_130 = __lux_tmp_129
        if __lux_tmp_130 then
          __lux_tmp_130 = windowConVar:GetInt()
        end
        local __lux_tmp_131 = __lux_tmp_130
        if not __lux_tmp_131 then
          __lux_tmp_131 = 120
        end
        return mathMax(1, __lux_tmp_131)
      end
      local topLimit = function()
        local __lux_tmp_132 = topConVar ~= nil
        if __lux_tmp_132 then
          __lux_tmp_132 = topConVar.GetInt ~= nil
        end
        local __lux_tmp_133 = __lux_tmp_132
        if __lux_tmp_133 then
          __lux_tmp_133 = topConVar:GetInt()
        end
        local __lux_tmp_134 = __lux_tmp_133
        if not __lux_tmp_134 then
          __lux_tmp_134 = 18
        end
        return mathMax(1, __lux_tmp_134)
      end
      local newTraceNode = function(name)
        do
          local __lux_tmp_135 = name
          if __lux_tmp_135 == nil then
            __lux_tmp_135 = "unknown"
          end
          name = toString(__lux_tmp_135)
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
          local __lux_tmp_136 = name
          if __lux_tmp_136 == nil then
            __lux_tmp_136 = "unknown"
          end
          key = toString(__lux_tmp_136)
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
          local __lux_tmp_137 = node.total
          if __lux_tmp_137 == nil then
            __lux_tmp_137 = 0
          end
          local __lux_tmp_138 = node.self
          if __lux_tmp_138 == nil then
            __lux_tmp_138 = 0
          end
          local __lux_tmp_139 = node.childTotal
          if __lux_tmp_139 == nil then
            __lux_tmp_139 = 0
          end
          local __lux_tmp_140 = node.count
          if __lux_tmp_140 == nil then
            __lux_tmp_140 = 0
          end
          local __lux_tmp_141 = node.max
          if __lux_tmp_141 == nil then
            __lux_tmp_141 = 0
          end
          local __lux_tmp_142 = node.selfMax
          if __lux_tmp_142 == nil then
            __lux_tmp_142 = 0
          end
          out = {
            name = node.name,
            total = __lux_tmp_137,
            self = __lux_tmp_138,
            childTotal = __lux_tmp_139,
            count = __lux_tmp_140,
            max = __lux_tmp_141,
            selfMax = __lux_tmp_142,
            children = {},
          }
        end
        do
          local __lux_tmp_143 = node.children
          if __lux_tmp_143 == nil then
            __lux_tmp_143 = {}
          end
          for index = 1, #__lux_tmp_143 do
            out.children[index] = copyTraceNode(node.children[index])
          end
        end
        return out
      end
      local finishTraceSpan = function(token)
        local elapsed = (sysTime() - token.started) * 1000
        local selfElapsed
        do
          local __lux_tmp_144 = token.childElapsed
          if __lux_tmp_144 == nil then
            __lux_tmp_144 = 0
          end
          selfElapsed = elapsed - __lux_tmp_144
        end
        if selfElapsed < 0 then
          selfElapsed = 0
        end
        local node = token.node
        do
          local __lux_tmp_145 = node.total
          if __lux_tmp_145 == nil then
            __lux_tmp_145 = 0
          end
          node.total = __lux_tmp_145 + elapsed
        end
        do
          local __lux_tmp_146 = node.self
          if __lux_tmp_146 == nil then
            __lux_tmp_146 = 0
          end
          node.self = __lux_tmp_146 + selfElapsed
        end
        do
          local __lux_tmp_147 = node.childTotal
          if __lux_tmp_147 == nil then
            __lux_tmp_147 = 0
          end
          local __lux_tmp_148 = token.childElapsed
          if __lux_tmp_148 == nil then
            __lux_tmp_148 = 0
          end
          node.childTotal = __lux_tmp_147 + __lux_tmp_148
        end
        do
          local __lux_tmp_149 = node.count
          if __lux_tmp_149 == nil then
            __lux_tmp_149 = 0
          end
          node.count = __lux_tmp_149 + 1
        end
        local __lux_tmp_150 = node.max
        if __lux_tmp_150 == nil then
          __lux_tmp_150 = 0
        end
        if elapsed > __lux_tmp_150 then
          node.max = elapsed
        end
        local __lux_tmp_151 = node.selfMax
        if __lux_tmp_151 == nil then
          __lux_tmp_151 = 0
        end
        if selfElapsed > __lux_tmp_151 then
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
        local oldMs
        do
          local __lux_tmp_152 = bucket.samples[index]
          if __lux_tmp_152 == nil then
            __lux_tmp_152 = 0
          end
          oldMs = __lux_tmp_152
        end
        if bucket.n == window then
          bucket.sum = bucket.sum - oldMs
          do
            local __lux_tmp_153 = bucket.counts[index]
            if __lux_tmp_153 == nil then
              __lux_tmp_153 = 0
            end
            bucket.countSum = bucket.countSum - __lux_tmp_153
          end
        else
          bucket.n = bucket.n + 1
        end
        do
          local __lux_tmp_154 = count
          if __lux_tmp_154 == nil then
            __lux_tmp_154 = 0
          end
          count = __lux_tmp_154
        end
        bucket.samples[index] = ms
        bucket.counts[index] = count
        bucket.sum = bucket.sum + ms
        bucket.countSum = bucket.countSum + count
        bucket.last = ms
        bucket.lastCount = count
        local __lux_tmp_155 = bucket.max
        if __lux_tmp_155 == nil then
          __lux_tmp_155 = 0
        end
        if ms >= __lux_tmp_155 then
          bucket.max = ms
        else
          local __lux_tmp_156 = bucket.max
          if __lux_tmp_156 == nil then
            __lux_tmp_156 = 0
          end
          if oldMs >= __lux_tmp_156 then
            local maxValue = 0
            for sampleIndex = 1, bucket.n do
              local sample
              do
                local __lux_tmp_157 = bucket.samples[sampleIndex]
                if __lux_tmp_157 == nil then
                  __lux_tmp_157 = 0
                end
                sample = __lux_tmp_157
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
          local __lux_tmp_158 = values == nil
          if not __lux_tmp_158 then
            __lux_tmp_158 = values[key] == nil
          end
          if __lux_tmp_158 then
            rollBucket(store, key, 0, 0, { name = key })
          end
        end
        do
          local __lux_tmp_159 = values
          if __lux_tmp_159 == nil then
            __lux_tmp_159 = {}
          end
          for key, value in pairs(__lux_tmp_159) do
            do
              local __lux_tmp_160 = toNumber(value)
              if __lux_tmp_160 == nil then
                __lux_tmp_160 = 0
              end
              local __lux_obj_161 = counts
              local __lux_val_163 = nil
              if __lux_obj_161 ~= nil then
                local __lux_key_162 = key
                __lux_val_163 = __lux_obj_161[__lux_key_162]
              end
              local __lux_tmp_164 = __lux_val_163
              if __lux_tmp_164 == nil then
                local __lux_tmp_165 = value
                if __lux_tmp_165 == nil then
                  __lux_tmp_165 = 0
                end
                __lux_tmp_164 = __lux_tmp_165
              end
              rollBucket(store, key, __lux_tmp_160, __lux_tmp_164, { name = key })
            end
          end
        end
      end
      local clearInstanceCurrent = function()
        instanceCurrent = nil
      end
      local rollInstanceFrame = function()
        local aggregate = instanceCurrent
        local __lux_tmp_166 = aggregate == nil
        if not __lux_tmp_166 then
          local __lux_tmp_167 = aggregate.scopes
          if __lux_tmp_167 == nil then
            __lux_tmp_167 = 0
          end
          __lux_tmp_166 = __lux_tmp_167 <= 0
        end
        if __lux_tmp_166 then
          return
        end
        local stats = copyScalarStats(aggregate.stats)
        stats.drawCommandCounts = copyCounts(aggregate.commandCounts)
        stats.drawImmediateCounts = copyCounts(aggregate.immediateCounts)
        do
          local __lux_tmp_168 = aggregate.elapsed
          if __lux_tmp_168 == nil then
            __lux_tmp_168 = 0
          end
          local __lux_tmp_169 = aggregate.scopes
          if __lux_tmp_169 == nil then
            __lux_tmp_169 = 0
          end
          rollBucket(
            instanceRolling,
            "runtime",
            __lux_tmp_168,
            __lux_tmp_169,
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
        local __lux_tmp_170 = instanceCurrent ~= nil
        if __lux_tmp_170 then
          __lux_tmp_170 = instanceCurrent.frame ~= engineFrame
        end
        if __lux_tmp_170 then
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
          local __lux_tmp_171 = aggregate.elapsed
          if __lux_tmp_171 == nil then
            __lux_tmp_171 = 0
          end
          local __lux_tmp_172 = elapsedMs
          if __lux_tmp_172 == nil then
            __lux_tmp_172 = 0
          end
          aggregate.elapsed = __lux_tmp_171 + __lux_tmp_172
        end
        do
          local __lux_tmp_173 = aggregate.scopes
          if __lux_tmp_173 == nil then
            __lux_tmp_173 = 0
          end
          aggregate.scopes = __lux_tmp_173 + 1
        end
        for index = 1, #scalarStatKeys do
          local key = scalarStatKeys[index]
          do
            local __lux_tmp_174 = aggregate.stats[key]
            if __lux_tmp_174 == nil then
              __lux_tmp_174 = 0
            end
            local __lux_obj_175 = stats
            local __lux_val_177 = nil
            if __lux_obj_175 ~= nil then
              local __lux_key_176 = key
              __lux_val_177 = __lux_obj_175[__lux_key_176]
            end
            local __lux_tmp_178 = toNumber(__lux_val_177)
            if __lux_tmp_178 == nil then
              __lux_tmp_178 = 0
            end
            aggregate.stats[key] = __lux_tmp_174 + __lux_tmp_178
          end
        end
        addCountsInto(aggregate.profileTimes, profileTimes)
        addCountsInto(aggregate.profileCounts, profileCounts)
        do
          local __lux_obj_179 = stats
          local __lux_val_180 = nil
          if __lux_obj_179 ~= nil then
            __lux_val_180 = __lux_obj_179.drawCommandCounts
          end
          addCountsInto(aggregate.commandCounts, __lux_val_180)
        end
        local __lux_obj_181 = stats
        local __lux_val_182 = nil
        if __lux_obj_181 ~= nil then
          __lux_val_182 = __lux_obj_181.drawImmediateCounts
        end
        return addCountsInto(aggregate.immediateCounts, __lux_val_182)
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
          do
            local __lux_tmp_183 = info
            if __lux_tmp_183 == nil then
              __lux_tmp_183 = {}
            end
            info = __lux_tmp_183
          end
          local scopeKind
          do
            local __lux_tmp_184 = kind
            if __lux_tmp_184 == nil then
              __lux_tmp_184 = "frame"
            end
            scopeKind = toString(__lux_tmp_184)
          end
          do
            local __lux_tmp_185 = info.label
            if __lux_tmp_185 == nil then
              __lux_tmp_185 = panelLabel(subject, scopeKind)
            end
            currentScope = {
              key = scopeKey(scopeKind, subject, info),
              kind = scopeKind,
              name = __lux_tmp_185,
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
        local __lux_tmp_186 = not api._TraceActive
        if not __lux_tmp_186 then
          __lux_tmp_186 = traceStack == nil
        end
        if __lux_tmp_186 then
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
        local __lux_tmp_187 = not api._TraceActive
        if not __lux_tmp_187 then
          __lux_tmp_187 = traceStack == nil
        end
        if __lux_tmp_187 then
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
            local __lux_tmp_188 = parent.childElapsed
            if __lux_tmp_188 == nil then
              __lux_tmp_188 = 0
            end
            parent.childElapsed = __lux_tmp_188 + elapsed
          end
        end
      end
      api.EndTrace = function()
        if not api._TraceActive then
          return nil
        end
        local __lux_tmp_189 = traceStack == nil
        if not __lux_tmp_189 then
          __lux_tmp_189 = #traceStack ~= 1
        end
        if __lux_tmp_189 then
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
        local __lux_tmp_190 = not active
        if not __lux_tmp_190 then
          __lux_tmp_190 = elapsedMs == nil
        end
        if __lux_tmp_190 then
          return
        end
        do
          local __lux_tmp_191 = name
          if __lux_tmp_191 == nil then
            __lux_tmp_191 = "unknown"
          end
          name = toString(__lux_tmp_191)
        end
        do
          local __lux_tmp_192 = target.stats
          if __lux_tmp_192 == nil then
            __lux_tmp_192 = {}
          end
          target.stats = __lux_tmp_192
        end
        do
          local __lux_tmp_193 = target.stats.profileTimes
          if __lux_tmp_193 == nil then
            __lux_tmp_193 = {}
          end
          target.stats.profileTimes = __lux_tmp_193
        end
        do
          local __lux_tmp_194 = target.stats.profileCounts
          if __lux_tmp_194 == nil then
            __lux_tmp_194 = {}
          end
          target.stats.profileCounts = __lux_tmp_194
        end
        do
          local __lux_tmp_195 = target.stats.profileTimes[name]
          if __lux_tmp_195 == nil then
            __lux_tmp_195 = 0
          end
          target.stats.profileTimes[name] = __lux_tmp_195 + elapsedMs
        end
        do
          local __lux_tmp_196 = target.stats.profileCounts[name]
          if __lux_tmp_196 == nil then
            __lux_tmp_196 = 0
          end
          local __lux_tmp_197 = count
          if __lux_tmp_197 == nil then
            __lux_tmp_197 = 1
          end
          target.stats.profileCounts[name] = __lux_tmp_196 + __lux_tmp_197
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
          local __lux_obj_198 = target.stats
          local __lux_val_199 = nil
          if __lux_obj_198 ~= nil then
            __lux_val_199 = __lux_obj_198.profileTimes
          end
          local __lux_tmp_200 = __lux_val_199
          if __lux_tmp_200 == nil then
            __lux_tmp_200 = {}
          end
          for name, ms in pairs(__lux_tmp_200) do
            local counts
            do
              local __lux_obj_201 = target.stats
              local __lux_val_202 = nil
              if __lux_obj_201 ~= nil then
                __lux_val_202 = __lux_obj_201.profileCounts
              end
              counts = __lux_val_202
            end
            local sampleCount
            if counts ~= nil then
              do
                local __lux_tmp_203 = counts[name]
                if __lux_tmp_203 == nil then
                  __lux_tmp_203 = 0
                end
                sampleCount = __lux_tmp_203
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
        do
          local __lux_tmp_204 = limit
          if __lux_tmp_204 == nil then
            __lux_tmp_204 = topLimit()
          end
          limit = __lux_tmp_204
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
            local __lux_tmp_205 = bucket.last
            if __lux_tmp_205 == nil then
              __lux_tmp_205 = 0
            end
            local __lux_tmp_206 = bucket.sum
            if __lux_tmp_206 == nil then
              __lux_tmp_206 = 0
            end
            local __lux_tmp_207 = bucket.max
            if __lux_tmp_207 == nil then
              __lux_tmp_207 = 0
            end
            local __lux_tmp_208 = bucket.lastCount
            if __lux_tmp_208 == nil then
              __lux_tmp_208 = 0
            end
            local __lux_tmp_209 = bucket.countSum
            if __lux_tmp_209 == nil then
              __lux_tmp_209 = 0
            end
            local __lux_tmp_210 = bucket.n
            if __lux_tmp_210 == nil then
              __lux_tmp_210 = 0
            end
            rows[#rows + 1] = {
              name = "[" .. instanceName .. "] " .. name,
              localName = name,
              instance = instanceName,
              instanceId = instanceId,
              last = __lux_tmp_205,
              avg = __lux_tmp_206 / n,
              max = __lux_tmp_207,
              count = __lux_tmp_208,
              avgCount = __lux_tmp_209 / n,
              samples = __lux_tmp_210,
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
        do
          local __lux_tmp_211 = limit
          if __lux_tmp_211 == nil then
            __lux_tmp_211 = topLimit()
          end
          limit = __lux_tmp_211
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
        do
          local __lux_tmp_212 = limit
          if __lux_tmp_212 == nil then
            __lux_tmp_212 = topLimit()
          end
          limit = __lux_tmp_212
        end
        local rows = {}
        local first = mathMax(1, #recentScopes - limit + 1)
        for index = #recentScopes, first, -1 do
          rows[#rows + 1] = recentScopes[index]
        end
        return rows
      end
      api.CurrentRows = function(limit)
        do
          local __lux_tmp_213 = limit
          if __lux_tmp_213 == nil then
            __lux_tmp_213 = topLimit()
          end
          limit = __lux_tmp_213
        end
        local rows = {}
        do
          local __lux_obj_214 = target.stats
          local __lux_val_215 = nil
          if __lux_obj_214 ~= nil then
            __lux_val_215 = __lux_obj_214.profileTimes
          end
          local __lux_tmp_216 = __lux_val_215
          if __lux_tmp_216 == nil then
            __lux_tmp_216 = {}
          end
          for name, ms in pairs(__lux_tmp_216) do
            do
              local __lux_tmp_217 = ms
              if __lux_tmp_217 == nil then
                __lux_tmp_217 = 0
              end
              local __lux_tmp_218
              local counts
              do
                local __lux_obj_219 = target.stats
                local __lux_val_220 = nil
                if __lux_obj_219 ~= nil then
                  __lux_val_220 = __lux_obj_219.profileCounts
                end
                counts = __lux_val_220
              end
              if counts ~= nil then
                do
                  local __lux_tmp_221 = counts[name]
                  if __lux_tmp_221 == nil then
                    __lux_tmp_221 = 0
                  end
                  __lux_tmp_218 = __lux_tmp_221
                end
              else
                __lux_tmp_218 = 0
              end
              rows[#rows + 1] = {
                name = "[" .. instanceName .. "] " .. name,
                localName = name,
                instance = instanceName,
                instanceId = instanceId,
                last = __lux_tmp_217,
                count = __lux_tmp_218,
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
        do
          local __lux_tmp_222 = limit
          if __lux_tmp_222 == nil then
            __lux_tmp_222 = topLimit()
          end
          limit = __lux_tmp_222
        end
        local __lux_tmp_223 = instanceCurrent ~= nil
        if __lux_tmp_223 then
          __lux_tmp_223 = instanceCurrent.frame ~= currentEngineFrame()
        end
        if __lux_tmp_223 then
          rollInstanceFrame()
          clearInstanceCurrent()
        end
        local bucket = instanceRolling.runtime
        local current = instanceCurrent
        local __lux_tmp_224 = bucket == nil
        if __lux_tmp_224 then
          __lux_tmp_224 = current == nil
        end
        if __lux_tmp_224 then
          return {}
        end
        local n
        do
          local __lux_tmp_225 = bucket ~= nil
          if __lux_tmp_225 then
            __lux_tmp_225 = bucket.n > 0
          end
          if __lux_tmp_225 then
            n = bucket.n
          else
            n = 1
          end
        end
        local meta
        do
          local __lux_obj_226 = bucket
          local __lux_val_227 = nil
          if __lux_obj_226 ~= nil then
            __lux_val_227 = __lux_obj_226.meta
          end
          local __lux_tmp_228 = __lux_val_227
          if __lux_tmp_228 == nil then
            __lux_tmp_228 = {}
          end
          meta = __lux_tmp_228
        end
        local rowStats
        if current ~= nil then
          rowStats = current.stats
        else
          do
            local __lux_tmp_229 = meta.stats
            if __lux_tmp_229 == nil then
              __lux_tmp_229 = {}
            end
            rowStats = __lux_tmp_229
          end
        end
        local row
        do
          local __lux_tmp_230
          if current ~= nil then
            __lux_tmp_230 = current.elapsed
          else
            do
              local __lux_obj_231 = bucket
              local __lux_val_232 = nil
              if __lux_obj_231 ~= nil then
                __lux_val_232 = __lux_obj_231.last
              end
              local __lux_tmp_233 = __lux_val_232
              if __lux_tmp_233 == nil then
                __lux_tmp_233 = 0
              end
              __lux_tmp_230 = __lux_tmp_233
            end
          end
          local __lux_tmp_234
          if bucket ~= nil then
            do
              local __lux_tmp_235 = bucket.sum
              if __lux_tmp_235 == nil then
                __lux_tmp_235 = 0
              end
              __lux_tmp_234 = __lux_tmp_235 / n
            end
          else
            do
              local __lux_obj_236 = current
              local __lux_val_237 = nil
              if __lux_obj_236 ~= nil then
                __lux_val_237 = __lux_obj_236.elapsed
              end
              local __lux_tmp_238 = __lux_val_237
              if __lux_tmp_238 == nil then
                __lux_tmp_238 = 0
              end
              __lux_tmp_234 = __lux_tmp_238
            end
          end
          local __lux_tmp_239
          if bucket ~= nil then
            do
              local __lux_tmp_240 = bucket.max
              if __lux_tmp_240 == nil then
                __lux_tmp_240 = 0
              end
              __lux_tmp_239 = __lux_tmp_240
            end
          else
            do
              local __lux_obj_241 = current
              local __lux_val_242 = nil
              if __lux_obj_241 ~= nil then
                __lux_val_242 = __lux_obj_241.elapsed
              end
              local __lux_tmp_243 = __lux_val_242
              if __lux_tmp_243 == nil then
                __lux_tmp_243 = 0
              end
              __lux_tmp_239 = __lux_tmp_243
            end
          end
          local __lux_tmp_244
          if current ~= nil then
            __lux_tmp_244 = current.scopes
          else
            do
              local __lux_obj_245 = bucket
              local __lux_val_246 = nil
              if __lux_obj_245 ~= nil then
                __lux_val_246 = __lux_obj_245.lastCount
              end
              local __lux_tmp_247 = __lux_val_246
              if __lux_tmp_247 == nil then
                __lux_tmp_247 = 0
              end
              __lux_tmp_244 = __lux_tmp_247
            end
          end
          local __lux_tmp_248
          if bucket ~= nil then
            do
              local __lux_tmp_249 = bucket.countSum
              if __lux_tmp_249 == nil then
                __lux_tmp_249 = 0
              end
              __lux_tmp_248 = __lux_tmp_249 / n
            end
          else
            do
              local __lux_obj_250 = current
              local __lux_val_251 = nil
              if __lux_obj_250 ~= nil then
                __lux_val_251 = __lux_obj_250.scopes
              end
              local __lux_tmp_252 = __lux_val_251
              if __lux_tmp_252 == nil then
                __lux_tmp_252 = 0
              end
              __lux_tmp_248 = __lux_tmp_252
            end
          end
          local __lux_obj_253 = bucket
          local __lux_val_254 = nil
          if __lux_obj_253 ~= nil then
            __lux_val_254 = __lux_obj_253.n
          end
          local __lux_tmp_255 = __lux_val_254
          if __lux_tmp_255 == nil then
            __lux_tmp_255 = 0
          end
          row = {
            name = "[" .. instanceName .. "] total",
            localName = "total",
            instance = instanceName,
            instanceId = instanceId,
            last = __lux_tmp_230,
            avg = __lux_tmp_234,
            max = __lux_tmp_239,
            count = __lux_tmp_244,
            avgCount = __lux_tmp_248,
            samples = __lux_tmp_255,
            stats = rowStats,
            profileTop = topRowsFromBuckets(instanceProfileRolling, limit, nil, true),
            apiTop = topRowsFromBuckets(instanceProfileRolling, limit, "api.", false),
            commandTop = topRowsFromBuckets(instanceCommandRolling, limit),
            immediateTop = topRowsFromBuckets(instanceImmediateRolling, limit),
          }
        end
        local __lux_tmp_256 = #row.profileTop == 0
        if __lux_tmp_256 then
          __lux_tmp_256 = current ~= nil
        end
        if __lux_tmp_256 then
          row.profileTop = topRowsFromCounts(current.profileTimes, current.profileCounts, limit, nil, true)
        end
        local __lux_tmp_257 = #row.apiTop == 0
        if __lux_tmp_257 then
          __lux_tmp_257 = current ~= nil
        end
        if __lux_tmp_257 then
          row.apiTop = topRowsFromCounts(current.profileTimes, current.profileCounts, limit, "api.", false)
        end
        local __lux_tmp_258 = #row.commandTop == 0
        if __lux_tmp_258 then
          __lux_tmp_258 = current ~= nil
        end
        if __lux_tmp_258 then
          row.commandTop = topRowsFromCounts(current.commandCounts, current.commandCounts, limit)
        end
        local __lux_tmp_259 = #row.immediateTop == 0
        if __lux_tmp_259 then
          __lux_tmp_259 = current ~= nil
        end
        if __lux_tmp_259 then
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
          local __lux_tmp_260 = rows
          if __lux_tmp_260 == nil then
            __lux_tmp_260 = {}
          end
          for _, row in ipairs(__lux_tmp_260) do
            if rollingRows then
              do
                local __lux_tmp_261 = row.last
                if __lux_tmp_261 == nil then
                  __lux_tmp_261 = 0
                end
                local __lux_tmp_262 = row.avg
                if __lux_tmp_262 == nil then
                  __lux_tmp_262 = 0
                end
                local __lux_tmp_263 = row.max
                if __lux_tmp_263 == nil then
                  __lux_tmp_263 = 0
                end
                local __lux_tmp_264 = row.count
                if __lux_tmp_264 == nil then
                  __lux_tmp_264 = 0
                end
                local __lux_tmp_265 = row.avgCount
                if __lux_tmp_265 == nil then
                  __lux_tmp_265 = 0
                end
                local __lux_tmp_266 = row.samples
                if __lux_tmp_266 == nil then
                  __lux_tmp_266 = 0
                end
                out[#out + 1] = stringFormat(
                  "%s last=%.3f avg=%.3f max=%.3f count=%d avgCount=%.1f samples=%d",
                  row.name,
                  __lux_tmp_261,
                  __lux_tmp_262,
                  __lux_tmp_263,
                  __lux_tmp_264,
                  __lux_tmp_265,
                  __lux_tmp_266
                )
              end
            else
              do
                local __lux_tmp_267 = row.last
                if __lux_tmp_267 == nil then
                  __lux_tmp_267 = 0
                end
                local __lux_tmp_268 = row.count
                if __lux_tmp_268 == nil then
                  __lux_tmp_268 = 0
                end
                out[#out + 1] = stringFormat("%s %.3fms count=%d", row.name, __lux_tmp_267, __lux_tmp_268)
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
          local __lux_tmp_269 = rows
          if __lux_tmp_269 == nil then
            __lux_tmp_269 = {}
          end
          for _, row in ipairs(__lux_tmp_269) do
            local stats
            do
              local __lux_tmp_270 = row.stats
              if __lux_tmp_270 == nil then
                __lux_tmp_270 = {}
              end
              stats = __lux_tmp_270
            end
            do
              local __lux_tmp_271 = row.name
              if __lux_tmp_271 == nil then
                local __lux_tmp_272 = row.key
                if __lux_tmp_272 == nil then
                  __lux_tmp_272 = "scope"
                end
                __lux_tmp_271 = __lux_tmp_272
              end
              local __lux_tmp_273 = row.last
              if __lux_tmp_273 == nil then
                __lux_tmp_273 = 0
              end
              local __lux_tmp_274 = row.avg
              if __lux_tmp_274 == nil then
                local __lux_tmp_275 = row.last
                if __lux_tmp_275 == nil then
                  __lux_tmp_275 = 0
                end
                __lux_tmp_274 = __lux_tmp_275
              end
              local __lux_tmp_276 = row.max
              if __lux_tmp_276 == nil then
                local __lux_tmp_277 = row.last
                if __lux_tmp_277 == nil then
                  __lux_tmp_277 = 0
                end
                __lux_tmp_276 = __lux_tmp_277
              end
              local __lux_tmp_278 = stats.draws
              if __lux_tmp_278 == nil then
                __lux_tmp_278 = 0
              end
              local __lux_tmp_279 = stats.blurPasses
              if __lux_tmp_279 == nil then
                __lux_tmp_279 = 0
              end
              local __lux_tmp_280 = stats.textDraws
              if __lux_tmp_280 == nil then
                __lux_tmp_280 = 0
              end
              local __lux_tmp_281 = stats.textShaderDraws
              if __lux_tmp_281 == nil then
                __lux_tmp_281 = 0
              end
              local __lux_tmp_282 = stats.textComposedBakes
              if __lux_tmp_282 == nil then
                __lux_tmp_282 = 0
              end
              local __lux_tmp_283 = stats.fallbacks
              if __lux_tmp_283 == nil then
                __lux_tmp_283 = 0
              end
              local __lux_tmp_284 = row.samples
              if __lux_tmp_284 == nil then
                __lux_tmp_284 = 1
              end
              local __lux_tmp_285 = row.callsite
              if __lux_tmp_285 == nil then
                __lux_tmp_285 = "unknown"
              end
              out[#out + 1] = stringFormat(
                "%s last=%.3f avg=%.3f max=%.3f draws=%d blur=%d text=%d shaderText=%d bakes=%d fallbacks=%d samples=%d call=%s",
                __lux_tmp_271,
                __lux_tmp_273,
                __lux_tmp_274,
                __lux_tmp_276,
                __lux_tmp_278,
                __lux_tmp_279,
                __lux_tmp_280,
                __lux_tmp_281,
                __lux_tmp_282,
                __lux_tmp_283,
                __lux_tmp_284,
                __lux_tmp_285
              )
            end
            if includeBreakdown then
              local top
              do
                local __lux_tmp_286 = row.profileTop
                if __lux_tmp_286 == nil then
                  __lux_tmp_286 = topRowsFromCounts(row.profileTimes, row.profileCounts, 5)
                end
                top = __lux_tmp_286
              end
              if #top > 0 then
                local parts = {}
                for index = 1, #top do
                  local item = top[index]
                  do
                    local __lux_tmp_287 = item.last
                    if __lux_tmp_287 == nil then
                      __lux_tmp_287 = 0
                    end
                    local __lux_tmp_288 = item.count
                    if __lux_tmp_288 == nil then
                      __lux_tmp_288 = 0
                    end
                    parts[#parts + 1] = stringFormat("%s=%.3fms/%d", item.name, __lux_tmp_287, __lux_tmp_288)
                  end
                end
                out[#out + 1] = "  top " .. tableConcat(parts, "  ")
              end
              local commands
              do
                local __lux_tmp_289 = row.commandCounts
                if __lux_tmp_289 == nil then
                  __lux_tmp_289 = {}
                end
                commands = __lux_tmp_289
              end
              local __lux_cmp_290 = false
              if sumCounts(commands) ~= nil and 0 ~= nil then
                __lux_cmp_290 = sumCounts(commands) > 0
              end
              if __lux_cmp_290 then
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
        local __lux_tmp_291 = typeOf(fnValue) ~= "function"
        if not __lux_tmp_291 then
          __lux_tmp_291 = debugLib == nil
        end
        local __lux_tmp_292 = __lux_tmp_291
        if not __lux_tmp_292 then
          __lux_tmp_292 = debugLib.getupvalue == nil
        end
        local __lux_tmp_293 = __lux_tmp_292
        if not __lux_tmp_293 then
          __lux_tmp_293 = depth > 8
        end
        if __lux_tmp_293 then
          return fnValue
        end
        local original = nil
        local profilerLabel = false
        for i = 1, 16 do
          local name, value = debugLib.getupvalue(fnValue, i)
          if name == nil then
            break
          end
          local __lux_tmp_294 = name == "original"
          if __lux_tmp_294 then
            __lux_tmp_294 = typeOf(value) == "function"
          end
          if __lux_tmp_294 then
            original = value
          else
            local __lux_tmp_295 = name == "label"
            if __lux_tmp_295 then
              __lux_tmp_295 = typeOf(value) == "string"
            end
            local __lux_tmp_296 = __lux_tmp_295
            if __lux_tmp_296 then
              __lux_tmp_296 = stringSub(value, 1, 4) == "api."
            end
            if __lux_tmp_296 then
              profilerLabel = true
            end
          end
        end
        local __lux_tmp_297 = profilerLabel
        if __lux_tmp_297 then
          __lux_tmp_297 = original ~= nil
        end
        if __lux_tmp_297 then
          return unwrapKnownProfilerWrapper(original, depth + 1)
        end
        return fnValue
      end
      local restoreSharedWrappers = function(ownerValue, names)
        local __lux_tmp_298 = ownerValue == nil
        if not __lux_tmp_298 then
          __lux_tmp_298 = names == nil
        end
        if __lux_tmp_298 then
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
        local __lux_tmp_299 = not wrappersInstalled
        if not __lux_tmp_299 then
          __lux_tmp_299 = wrappedOwner == nil
        end
        if __lux_tmp_299 then
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
        local __lux_tmp_300 = wrappersInstalled
        if not __lux_tmp_300 then
          __lux_tmp_300 = wrappedOwner == nil
        end
        if __lux_tmp_300 then
          return
        end
        do
          local __lux_tmp_301 = wrappedOwner._mgfxProfileOriginals
          if __lux_tmp_301 == nil then
            __lux_tmp_301 = {}
          end
          wrappedOwner._mgfxProfileOriginals = __lux_tmp_301
        end
        local originalsStore = wrappedOwner._mgfxProfileOriginals
        do
          local __lux_tmp_302 = wrappedNames
          if __lux_tmp_302 == nil then
            __lux_tmp_302 = {}
          end
          for _, name in ipairs(__lux_tmp_302) do
            local original = unwrapKnownProfilerWrapper(wrappedOwner[name])
            local __lux_tmp_303 = typeOf(original) == "function"
            if __lux_tmp_303 then
              __lux_tmp_303 = wrappedOriginals[name] == nil
            end
            if __lux_tmp_303 then
              local label = "api." .. name
              wrappedOriginals[name] = original
              originalsStore[name] = original
              wrappedOwner[name] = function(...)
                local started
                do
                  local __lux_tmp_304 = active
                  if __lux_tmp_304 then
                    local __lux_tmp_305 = typeOf(wrappedSuppress) == "function"
                    if __lux_tmp_305 then
                      __lux_tmp_305 = wrappedSuppress()
                    end
                    __lux_tmp_304 = not __lux_tmp_305
                  end
                  local __lux_tmp_306 = __lux_tmp_304
                  if __lux_tmp_306 then
                    __lux_tmp_306 = sysTime()
                  end
                  local __lux_tmp_307 = __lux_tmp_306
                  if not __lux_tmp_307 then
                    __lux_tmp_307 = nil
                  end
                  started = __lux_tmp_307
                end
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
        local __lux_tmp_308 = cvarsLib ~= nil
        if __lux_tmp_308 then
          __lux_tmp_308 = cvarsLib.RemoveChangeCallback ~= nil
        end
        if __lux_tmp_308 then
          cvarsLib.RemoveChangeCallback("mgfx_profile", callbackId)
        end
        local __lux_tmp_309 = cvarsLib ~= nil
        if __lux_tmp_309 then
          __lux_tmp_309 = cvarsLib.AddChangeCallback ~= nil
        end
        if __lux_tmp_309 then
          cvarsLib.AddChangeCallback(
            "mgfx_profile",
            function(_, _, newValue)
              if toBool(newValue) then
                wrapApi()
              else
                unwrapApi()
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
        local __lux_tmp_310 = owner.stats
        if __lux_tmp_310 == nil then
          __lux_tmp_310 = {}
        end
        owner.stats = __lux_tmp_310
      end
      do
        local __lux_tmp_311 = owner.stats.profileTimes
        if __lux_tmp_311 == nil then
          __lux_tmp_311 = {}
        end
        owner.stats.profileTimes = __lux_tmp_311
      end
      do
        local __lux_tmp_312 = owner.stats.profileCounts
        if __lux_tmp_312 == nil then
          __lux_tmp_312 = {}
        end
        owner.stats.profileCounts = __lux_tmp_312
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
