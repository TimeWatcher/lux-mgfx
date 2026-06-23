return function(__lux_import)
  local __lux_exports = {}
  local createClientConVar
  local sysTime
  local mathMax
  local tableCopy
  local tableEmpty
  local tableSort
  local stringFormat
  local toBool
  local toString
  local typeOf
  local cvarsLib
  local makeConVar
  local create
  local install
  do
    createClientConVar = CreateClientConVar
    sysTime = SysTime
    mathMax = math.max
    tableCopy = table.Copy
    tableEmpty = table.Empty
    tableSort = table.sort
    stringFormat = string.format
    toBool = tobool
    toString = tostring
    typeOf = type
    cvarsLib = cvars
    makeConVar = function(name, defaultValue, help)
      if createClientConVar == nil then
        return nil
      end
      return createClientConVar(name, defaultValue, true, false, help)
    end
    create = function(owner, options)
      local target = owner
      if target == nil then
        target = {}
      end
      local enabledConVar
      do
        local __lux_obj_options_1 = options
        local __lux_val_enabledConVar_2 = nil
        if __lux_obj_options_1 ~= nil then
          __lux_val_enabledConVar_2 = __lux_obj_options_1.enabledConVar
        end
        enabledConVar = __lux_val_enabledConVar_2
        if enabledConVar == nil then
          enabledConVar = makeConVar("mgfx_profile", "0", "MGFX: enable renderer profiler.")
        end
      end
      local windowConVar
      do
        local __lux_obj_options_3 = options
        local __lux_val_windowConVar_4 = nil
        if __lux_obj_options_3 ~= nil then
          __lux_val_windowConVar_4 = __lux_obj_options_3.windowConVar
        end
        windowConVar = __lux_val_windowConVar_4
        if windowConVar == nil then
          windowConVar = makeConVar("mgfx_profile_window", "120", "MGFX: rolling profiler sample window.")
        end
      end
      local topConVar
      do
        local __lux_obj_options_5 = options
        local __lux_val_topConVar_6 = nil
        if __lux_obj_options_5 ~= nil then
          __lux_val_topConVar_6 = __lux_obj_options_5.topConVar
        end
        topConVar = __lux_val_topConVar_6
        if topConVar == nil then
          topConVar = makeConVar(
            "mgfx_profile_top",
            "18",
            "MGFX: number of profiler rows printed by mgfx_profile_status."
          )
        end
      end
      local rolling = {}
      local frameIndex = 0
      local active = false
      local wrappedOriginals = {}
      local wrappersInstalled = false
      local wrappedOwner = nil
      local wrappedNames = nil
      local wrappedSuppress = nil
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
      api.BeginFrame = function()
        active = isEnabled()
        if active then
          frameIndex = frameIndex + 1
        end
        return active
      end
      api.IsActive = function()
        return active
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
          local __lux_tmp_name_7 = name
          if __lux_tmp_name_7 == nil then
            __lux_tmp_name_7 = "unknown"
          end
          name = toString(__lux_tmp_name_7)
        end
        do
          local __lux_tmp_stats_8 = target.stats
          if __lux_tmp_stats_8 == nil then
            __lux_tmp_stats_8 = {}
          end
          target.stats = __lux_tmp_stats_8
        end
        do
          local __lux_tmp_profileTimes_9 = target.stats.profileTimes
          if __lux_tmp_profileTimes_9 == nil then
            __lux_tmp_profileTimes_9 = {}
          end
          target.stats.profileTimes = __lux_tmp_profileTimes_9
        end
        do
          local __lux_tmp_profileCounts_10 = target.stats.profileCounts
          if __lux_tmp_profileCounts_10 == nil then
            __lux_tmp_profileCounts_10 = {}
          end
          target.stats.profileCounts = __lux_tmp_profileCounts_10
        end
        do
          local __lux_tmp_name_11 = target.stats.profileTimes[name]
          if __lux_tmp_name_11 == nil then
            __lux_tmp_name_11 = 0
          end
          target.stats.profileTimes[name] = __lux_tmp_name_11 + elapsedMs
        end
        do
          local __lux_tmp_name_12 = target.stats.profileCounts[name]
          if __lux_tmp_name_12 == nil then
            __lux_tmp_name_12 = 0
          end
          local __lux_tmp_count_13 = count
          if __lux_tmp_count_13 == nil then
            __lux_tmp_count_13 = 1
          end
          target.stats.profileCounts[name] = __lux_tmp_name_12 + __lux_tmp_count_13
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
        local window = windowSize()
        do
          local __lux_obj_target_14 = target.stats
          local __lux_tmp_profileTimes_15 = nil
          if __lux_obj_target_14 ~= nil then
            __lux_tmp_profileTimes_15 = __lux_obj_target_14.profileTimes
          end
          if __lux_tmp_profileTimes_15 == nil then
            __lux_tmp_profileTimes_15 = {}
          end
          for name, ms in pairs(__lux_tmp_profileTimes_15) do
            local bucket = rolling[name]
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
              rolling[name] = bucket
            end
            local index = bucket.index
            local oldMs = bucket.samples[index]
            if oldMs == nil then
              oldMs = 0
            end
            if bucket.n == window then
              bucket.sum = bucket.sum - oldMs
              do
                local __lux_tmp_index_16 = bucket.counts[index]
                if __lux_tmp_index_16 == nil then
                  __lux_tmp_index_16 = 0
                end
                bucket.countSum = bucket.countSum - __lux_tmp_index_16
              end
            else
              bucket.n = bucket.n + 1
            end
            local counts
            do
              local __lux_obj_stats_17 = target.stats
              local __lux_val_profileCounts_18 = nil
              if __lux_obj_stats_17 ~= nil then
                __lux_val_profileCounts_18 = __lux_obj_stats_17.profileCounts
              end
              counts = __lux_val_profileCounts_18
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
            bucket.samples[index] = ms
            bucket.counts[index] = sampleCount
            bucket.sum = bucket.sum + ms
            bucket.countSum = bucket.countSum + sampleCount
            bucket.last = ms
            bucket.lastCount = sampleCount
            local __lux_tmp_max_19 = bucket.max
            if __lux_tmp_max_19 == nil then
              __lux_tmp_max_19 = 0
            end
            if ms >= __lux_tmp_max_19 then
              bucket.max = ms
            else
              local __lux_tmp_max_20 = bucket.max
              if __lux_tmp_max_20 == nil then
                __lux_tmp_max_20 = 0
              end
              if oldMs >= __lux_tmp_max_20 then
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
          end
        end
      end
      api.Reset = function()
        if tableEmpty ~= nil then
          tableEmpty(rolling)
        else
          for key, _ in pairs(rolling) do
            rolling[key] = nil
          end
        end
        frameIndex = 0
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
            local __lux_tmp_last_21 = bucket.last
            if __lux_tmp_last_21 == nil then
              __lux_tmp_last_21 = 0
            end
            local __lux_tmp_sum_22 = bucket.sum
            if __lux_tmp_sum_22 == nil then
              __lux_tmp_sum_22 = 0
            end
            local __lux_tmp_max_23 = bucket.max
            if __lux_tmp_max_23 == nil then
              __lux_tmp_max_23 = 0
            end
            local __lux_tmp_lastCount_24 = bucket.lastCount
            if __lux_tmp_lastCount_24 == nil then
              __lux_tmp_lastCount_24 = 0
            end
            local __lux_tmp_countSum_25 = bucket.countSum
            if __lux_tmp_countSum_25 == nil then
              __lux_tmp_countSum_25 = 0
            end
            local __lux_tmp_n_26 = bucket.n
            if __lux_tmp_n_26 == nil then
              __lux_tmp_n_26 = 0
            end
            rows[#rows + 1] = {
              name = name,
              last = __lux_tmp_last_21,
              avg = __lux_tmp_sum_22 / n,
              max = __lux_tmp_max_23,
              count = __lux_tmp_lastCount_24,
              avgCount = __lux_tmp_countSum_25 / n,
              samples = __lux_tmp_n_26,
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
      api.CurrentRows = function(limit)
        if limit == nil then
          limit = topLimit()
        end
        local rows = {}
        do
          local __lux_obj_target_27 = target.stats
          local __lux_tmp_profileTimes_28 = nil
          if __lux_obj_target_27 ~= nil then
            __lux_tmp_profileTimes_28 = __lux_obj_target_27.profileTimes
          end
          if __lux_tmp_profileTimes_28 == nil then
            __lux_tmp_profileTimes_28 = {}
          end
          for name, ms in pairs(__lux_tmp_profileTimes_28) do
            do
              local __lux_tmp_ms_29 = ms
              if __lux_tmp_ms_29 == nil then
                __lux_tmp_ms_29 = 0
              end
              local __lux_tmp_30
              local counts
              do
                local __lux_obj_stats_31 = target.stats
                local __lux_val_profileCounts_32 = nil
                if __lux_obj_stats_31 ~= nil then
                  __lux_val_profileCounts_32 = __lux_obj_stats_31.profileCounts
                end
                counts = __lux_val_profileCounts_32
              end
              if counts ~= nil then
                __lux_tmp_30 = counts[name]
                if __lux_tmp_30 == nil then
                  __lux_tmp_30 = 0
                end
              else
                __lux_tmp_30 = 0
              end
              rows[#rows + 1] = { name = name, last = __lux_tmp_ms_29, count = __lux_tmp_30 }
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
      api.FormatRows = function(rows, rollingRows)
        if rollingRows == nil then
          rollingRows = false
        end
        local out = {}
        do
          local __lux_tmp_rows_33 = rows
          if __lux_tmp_rows_33 == nil then
            __lux_tmp_rows_33 = {}
          end
          for _, row in ipairs(__lux_tmp_rows_33) do
            if rollingRows then
              do
                local __lux_tmp_last_34 = row.last
                if __lux_tmp_last_34 == nil then
                  __lux_tmp_last_34 = 0
                end
                local __lux_tmp_avg_35 = row.avg
                if __lux_tmp_avg_35 == nil then
                  __lux_tmp_avg_35 = 0
                end
                local __lux_tmp_max_36 = row.max
                if __lux_tmp_max_36 == nil then
                  __lux_tmp_max_36 = 0
                end
                local __lux_tmp_count_37 = row.count
                if __lux_tmp_count_37 == nil then
                  __lux_tmp_count_37 = 0
                end
                local __lux_tmp_avgCount_38 = row.avgCount
                if __lux_tmp_avgCount_38 == nil then
                  __lux_tmp_avgCount_38 = 0
                end
                local __lux_tmp_samples_39 = row.samples
                if __lux_tmp_samples_39 == nil then
                  __lux_tmp_samples_39 = 0
                end
                out[#out + 1] = stringFormat(
                  "%s last=%.3f avg=%.3f max=%.3f count=%d avgCount=%.1f samples=%d",
                  row.name,
                  __lux_tmp_last_34,
                  __lux_tmp_avg_35,
                  __lux_tmp_max_36,
                  __lux_tmp_count_37,
                  __lux_tmp_avgCount_38,
                  __lux_tmp_samples_39
                )
              end
            else
              do
                local __lux_tmp_last_40 = row.last
                if __lux_tmp_last_40 == nil then
                  __lux_tmp_last_40 = 0
                end
                local __lux_tmp_count_41 = row.count
                if __lux_tmp_count_41 == nil then
                  __lux_tmp_count_41 = 0
                end
                out[#out + 1] = stringFormat("%s %.3fms count=%d", row.name, __lux_tmp_last_40, __lux_tmp_count_41)
              end
            end
          end
        end
        return out
      end
      local unwrapApi
      local wrapApi
      unwrapApi = function()
        if not wrappersInstalled or wrappedOwner == nil then
          return
        end
        local originalsStore = wrappedOwner._mgfxProfileOriginals
        for name, original in pairs(wrappedOriginals) do
          wrappedOwner[name] = original
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
          local __lux_tmp_mgfxProfileOriginals_42 = wrappedOwner._mgfxProfileOriginals
          if __lux_tmp_mgfxProfileOriginals_42 == nil then
            __lux_tmp_mgfxProfileOriginals_42 = {}
          end
          wrappedOwner._mgfxProfileOriginals = __lux_tmp_mgfxProfileOriginals_42
        end
        local originalsStore = wrappedOwner._mgfxProfileOriginals
        do
          local __lux_tmp_wrappedNames_43 = wrappedNames
          if __lux_tmp_wrappedNames_43 == nil then
            __lux_tmp_wrappedNames_43 = {}
          end
          for _, name in ipairs(__lux_tmp_wrappedNames_43) do
            local original = wrappedOwner[name]
            if typeOf(original) == "function" and wrappedOriginals[name] == nil then
              wrappedOriginals[name] = original
              originalsStore[name] = original
              wrappedOwner[name] = function(...)
                local started = api.Start()
                local a, b, c, d, e, f = original(...)
                api.End(name, started, 1)
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
        unwrapApi()
        wrappedOwner = owner
        wrappedNames = names
        wrappedSuppress = suppress
        if cvarsLib ~= nil and cvarsLib.RemoveChangeCallback ~= nil then
          cvarsLib.RemoveChangeCallback("mgfx_profile", "MGFXProfileApiWrappers")
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
            "MGFXProfileApiWrappers"
          )
        end
        if isEnabled() then
          wrapApi()
        end
      end
      return api
    end
    install = function(owner)
      do
        local __lux_tmp_stats_44 = owner.stats
        if __lux_tmp_stats_44 == nil then
          __lux_tmp_stats_44 = {}
        end
        owner.stats = __lux_tmp_stats_44
      end
      do
        local __lux_tmp_profileTimes_45 = owner.stats.profileTimes
        if __lux_tmp_profileTimes_45 == nil then
          __lux_tmp_profileTimes_45 = {}
        end
        owner.stats.profileTimes = __lux_tmp_profileTimes_45
      end
      do
        local __lux_tmp_profileCounts_46 = owner.stats.profileCounts
        if __lux_tmp_profileCounts_46 == nil then
          __lux_tmp_profileCounts_46 = {}
        end
        owner.stats.profileCounts = __lux_tmp_profileCounts_46
      end
      local api = create(owner)
      owner.Profiler = api
      owner.BeginProfileFrame = api.BeginFrame
      owner.EndProfileFrame = api.EndFrame
      owner.GetProfileRows = api.Snapshot
      owner.GetCurrentProfileRows = api.CurrentRows
      owner.FormatProfileRows = api.FormatRows
      owner.ResetProfile = api.Reset
      owner.InstallApiWrappers = api.InstallApiWrappers
      return owner
    end
  end
  
  __lux_exports.create = create
  __lux_exports.install = install
  
  return __lux_exports
end
