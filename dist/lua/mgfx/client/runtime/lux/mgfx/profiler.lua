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
      local target
      do
        local __lux_tmp_1 = owner
        if __lux_tmp_1 == nil then
          __lux_tmp_1 = {}
        end
        target = __lux_tmp_1
      end
      local enabledConVar
      do
        local __lux_obj_2 = options
        local __lux_val_3 = nil
        if __lux_obj_2 ~= nil then
          __lux_val_3 = __lux_obj_2.enabledConVar
        end
        local __lux_tmp_4 = __lux_val_3
        if __lux_tmp_4 == nil then
          __lux_tmp_4 = makeConVar("mgfx_profile", "0", "MGFX: enable renderer profiler.")
        end
        enabledConVar = __lux_tmp_4
      end
      local windowConVar
      do
        local __lux_obj_5 = options
        local __lux_val_6 = nil
        if __lux_obj_5 ~= nil then
          __lux_val_6 = __lux_obj_5.windowConVar
        end
        local __lux_tmp_7 = __lux_val_6
        if __lux_tmp_7 == nil then
          __lux_tmp_7 = makeConVar("mgfx_profile_window", "120", "MGFX: rolling profiler sample window.")
        end
        windowConVar = __lux_tmp_7
      end
      local topConVar
      do
        local __lux_obj_8 = options
        local __lux_val_9 = nil
        if __lux_obj_8 ~= nil then
          __lux_val_9 = __lux_obj_8.topConVar
        end
        local __lux_tmp_10 = __lux_val_9
        if __lux_tmp_10 == nil then
          __lux_tmp_10 = makeConVar(
          "mgfx_profile_top",
          "18",
          "MGFX: number of profiler rows printed by mgfx_profile_status."
        )
        end
        topConVar = __lux_tmp_10
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
        local __lux_tmp_11 = enabledConVar ~= nil
        if __lux_tmp_11 then
          __lux_tmp_11 = enabledConVar.GetBool ~= nil
        end
        local __lux_tmp_12 = __lux_tmp_11
        if __lux_tmp_12 then
          __lux_tmp_12 = enabledConVar:GetBool()
        end
        local __lux_tmp_13 = __lux_tmp_12
        if not __lux_tmp_13 then
          __lux_tmp_13 = false
        end
        return __lux_tmp_13
      end
      local windowSize = function()
        local __lux_tmp_14 = windowConVar ~= nil
        if __lux_tmp_14 then
          __lux_tmp_14 = windowConVar.GetInt ~= nil
        end
        local __lux_tmp_15 = __lux_tmp_14
        if __lux_tmp_15 then
          __lux_tmp_15 = windowConVar:GetInt()
        end
        local __lux_tmp_16 = __lux_tmp_15
        if not __lux_tmp_16 then
          __lux_tmp_16 = 120
        end
        return mathMax(1, __lux_tmp_16)
      end
      local topLimit = function()
        local __lux_tmp_17 = topConVar ~= nil
        if __lux_tmp_17 then
          __lux_tmp_17 = topConVar.GetInt ~= nil
        end
        local __lux_tmp_18 = __lux_tmp_17
        if __lux_tmp_18 then
          __lux_tmp_18 = topConVar:GetInt()
        end
        local __lux_tmp_19 = __lux_tmp_18
        if not __lux_tmp_19 then
          __lux_tmp_19 = 18
        end
        return mathMax(1, __lux_tmp_19)
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
        local __lux_tmp_20 = not active
        if not __lux_tmp_20 then
          __lux_tmp_20 = elapsedMs == nil
        end
        if __lux_tmp_20 then
          return
        end
        do
          local __lux_tmp_21 = name
          if __lux_tmp_21 == nil then
            __lux_tmp_21 = "unknown"
          end
          name = toString(__lux_tmp_21)
        end
        do
          local __lux_tmp_22 = target.stats
          if __lux_tmp_22 == nil then
            __lux_tmp_22 = {}
          end
          target.stats = __lux_tmp_22
        end
        do
          local __lux_tmp_23 = target.stats.profileTimes
          if __lux_tmp_23 == nil then
            __lux_tmp_23 = {}
          end
          target.stats.profileTimes = __lux_tmp_23
        end
        do
          local __lux_tmp_24 = target.stats.profileCounts
          if __lux_tmp_24 == nil then
            __lux_tmp_24 = {}
          end
          target.stats.profileCounts = __lux_tmp_24
        end
        do
          local __lux_tmp_25 = target.stats.profileTimes[name]
          if __lux_tmp_25 == nil then
            __lux_tmp_25 = 0
          end
          target.stats.profileTimes[name] = __lux_tmp_25 + elapsedMs
        end
        do
          local __lux_tmp_26 = target.stats.profileCounts[name]
          if __lux_tmp_26 == nil then
            __lux_tmp_26 = 0
          end
          local __lux_tmp_27 = count
          if __lux_tmp_27 == nil then
            __lux_tmp_27 = 1
          end
          target.stats.profileCounts[name] = __lux_tmp_26 + __lux_tmp_27
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
          local __lux_obj_28 = target.stats
          local __lux_val_29 = nil
          if __lux_obj_28 ~= nil then
            __lux_val_29 = __lux_obj_28.profileTimes
          end
          local __lux_tmp_30 = __lux_val_29
          if __lux_tmp_30 == nil then
            __lux_tmp_30 = {}
          end
          for name, ms in pairs(__lux_tmp_30) do
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
            local oldMs
            do
              local __lux_tmp_31 = bucket.samples[index]
              if __lux_tmp_31 == nil then
                __lux_tmp_31 = 0
              end
              oldMs = __lux_tmp_31
            end
            if bucket.n == window then
              bucket.sum = bucket.sum - oldMs
              do
                local __lux_tmp_32 = bucket.counts[index]
                if __lux_tmp_32 == nil then
                  __lux_tmp_32 = 0
                end
                bucket.countSum = bucket.countSum - __lux_tmp_32
              end
            else
              bucket.n = bucket.n + 1
            end
            local counts
            do
              local __lux_obj_33 = target.stats
              local __lux_val_34 = nil
              if __lux_obj_33 ~= nil then
                __lux_val_34 = __lux_obj_33.profileCounts
              end
              counts = __lux_val_34
            end
            local sampleCount
            if counts ~= nil then
              do
                local __lux_tmp_35 = counts[name]
                if __lux_tmp_35 == nil then
                  __lux_tmp_35 = 0
                end
                sampleCount = __lux_tmp_35
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
            local __lux_tmp_36 = bucket.max
            if __lux_tmp_36 == nil then
              __lux_tmp_36 = 0
            end
            if ms >= __lux_tmp_36 then
              bucket.max = ms
            else
              local __lux_tmp_37 = bucket.max
              if __lux_tmp_37 == nil then
                __lux_tmp_37 = 0
              end
              if oldMs >= __lux_tmp_37 then
                local maxValue = 0
                for sampleIndex = 1, bucket.n do
                  local sample
                  do
                    local __lux_tmp_38 = bucket.samples[sampleIndex]
                    if __lux_tmp_38 == nil then
                      __lux_tmp_38 = 0
                    end
                    sample = __lux_tmp_38
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
        do
          local __lux_tmp_39 = limit
          if __lux_tmp_39 == nil then
            __lux_tmp_39 = topLimit()
          end
          limit = __lux_tmp_39
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
            local __lux_tmp_40 = bucket.last
            if __lux_tmp_40 == nil then
              __lux_tmp_40 = 0
            end
            local __lux_tmp_41 = bucket.sum
            if __lux_tmp_41 == nil then
              __lux_tmp_41 = 0
            end
            local __lux_tmp_42 = bucket.max
            if __lux_tmp_42 == nil then
              __lux_tmp_42 = 0
            end
            local __lux_tmp_43 = bucket.lastCount
            if __lux_tmp_43 == nil then
              __lux_tmp_43 = 0
            end
            local __lux_tmp_44 = bucket.countSum
            if __lux_tmp_44 == nil then
              __lux_tmp_44 = 0
            end
            local __lux_tmp_45 = bucket.n
            if __lux_tmp_45 == nil then
              __lux_tmp_45 = 0
            end
            rows[#rows + 1] = {
              name = name,
              last = __lux_tmp_40,
              avg = __lux_tmp_41 / n,
              max = __lux_tmp_42,
              count = __lux_tmp_43,
              avgCount = __lux_tmp_44 / n,
              samples = __lux_tmp_45,
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
        do
          local __lux_tmp_46 = limit
          if __lux_tmp_46 == nil then
            __lux_tmp_46 = topLimit()
          end
          limit = __lux_tmp_46
        end
        local rows = {}
        do
          local __lux_obj_47 = target.stats
          local __lux_val_48 = nil
          if __lux_obj_47 ~= nil then
            __lux_val_48 = __lux_obj_47.profileTimes
          end
          local __lux_tmp_49 = __lux_val_48
          if __lux_tmp_49 == nil then
            __lux_tmp_49 = {}
          end
          for name, ms in pairs(__lux_tmp_49) do
            do
              local __lux_tmp_50 = ms
              if __lux_tmp_50 == nil then
                __lux_tmp_50 = 0
              end
              local __lux_tmp_51
              local counts
              do
                local __lux_obj_52 = target.stats
                local __lux_val_53 = nil
                if __lux_obj_52 ~= nil then
                  __lux_val_53 = __lux_obj_52.profileCounts
                end
                counts = __lux_val_53
              end
              if counts ~= nil then
                do
                  local __lux_tmp_54 = counts[name]
                  if __lux_tmp_54 == nil then
                    __lux_tmp_54 = 0
                  end
                  __lux_tmp_51 = __lux_tmp_54
                end
              else
                __lux_tmp_51 = 0
              end
              rows[#rows + 1] = { name = name, last = __lux_tmp_50, count = __lux_tmp_51 }
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
          local __lux_tmp_55 = rows
          if __lux_tmp_55 == nil then
            __lux_tmp_55 = {}
          end
          for _, row in ipairs(__lux_tmp_55) do
            if rollingRows then
              do
                local __lux_tmp_56 = row.last
                if __lux_tmp_56 == nil then
                  __lux_tmp_56 = 0
                end
                local __lux_tmp_57 = row.avg
                if __lux_tmp_57 == nil then
                  __lux_tmp_57 = 0
                end
                local __lux_tmp_58 = row.max
                if __lux_tmp_58 == nil then
                  __lux_tmp_58 = 0
                end
                local __lux_tmp_59 = row.count
                if __lux_tmp_59 == nil then
                  __lux_tmp_59 = 0
                end
                local __lux_tmp_60 = row.avgCount
                if __lux_tmp_60 == nil then
                  __lux_tmp_60 = 0
                end
                local __lux_tmp_61 = row.samples
                if __lux_tmp_61 == nil then
                  __lux_tmp_61 = 0
                end
                out[#out + 1] = stringFormat(
                  "%s last=%.3f avg=%.3f max=%.3f count=%d avgCount=%.1f samples=%d",
                  row.name,
                  __lux_tmp_56,
                  __lux_tmp_57,
                  __lux_tmp_58,
                  __lux_tmp_59,
                  __lux_tmp_60,
                  __lux_tmp_61
                )
              end
            else
              do
                local __lux_tmp_62 = row.last
                if __lux_tmp_62 == nil then
                  __lux_tmp_62 = 0
                end
                local __lux_tmp_63 = row.count
                if __lux_tmp_63 == nil then
                  __lux_tmp_63 = 0
                end
                out[#out + 1] = stringFormat("%s %.3fms count=%d", row.name, __lux_tmp_62, __lux_tmp_63)
              end
            end
          end
        end
        return out
      end
      local unwrapApi
      local wrapApi
      unwrapApi = function()
        local __lux_tmp_64 = not wrappersInstalled
        if not __lux_tmp_64 then
          __lux_tmp_64 = wrappedOwner == nil
        end
        if __lux_tmp_64 then
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
        local __lux_tmp_65 = wrappersInstalled
        if not __lux_tmp_65 then
          __lux_tmp_65 = wrappedOwner == nil
        end
        if __lux_tmp_65 then
          return
        end
        do
          local __lux_tmp_66 = wrappedOwner._mgfxProfileOriginals
          if __lux_tmp_66 == nil then
            __lux_tmp_66 = {}
          end
          wrappedOwner._mgfxProfileOriginals = __lux_tmp_66
        end
        local originalsStore = wrappedOwner._mgfxProfileOriginals
        do
          local __lux_tmp_67 = wrappedNames
          if __lux_tmp_67 == nil then
            __lux_tmp_67 = {}
          end
          for _, name in ipairs(__lux_tmp_67) do
            local original = wrappedOwner[name]
            local __lux_tmp_68 = typeOf(original) == "function"
            if __lux_tmp_68 then
              __lux_tmp_68 = wrappedOriginals[name] == nil
            end
            if __lux_tmp_68 then
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
        local __lux_tmp_69 = cvarsLib ~= nil
        if __lux_tmp_69 then
          __lux_tmp_69 = cvarsLib.RemoveChangeCallback ~= nil
        end
        if __lux_tmp_69 then
          cvarsLib.RemoveChangeCallback("mgfx_profile", "MGFXProfileApiWrappers")
        end
        local __lux_tmp_70 = cvarsLib ~= nil
        if __lux_tmp_70 then
          __lux_tmp_70 = cvarsLib.AddChangeCallback ~= nil
        end
        if __lux_tmp_70 then
          cvarsLib.AddChangeCallback(
            "mgfx_profile",
            function(_, _, newValue)
              if toBool(newValue) then
                wrapApi()
              else
                unwrapApi()
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
        local __lux_tmp_71 = owner.stats
        if __lux_tmp_71 == nil then
          __lux_tmp_71 = {}
        end
        owner.stats = __lux_tmp_71
      end
      do
        local __lux_tmp_72 = owner.stats.profileTimes
        if __lux_tmp_72 == nil then
          __lux_tmp_72 = {}
        end
        owner.stats.profileTimes = __lux_tmp_72
      end
      do
        local __lux_tmp_73 = owner.stats.profileCounts
        if __lux_tmp_73 == nil then
          __lux_tmp_73 = {}
        end
        owner.stats.profileCounts = __lux_tmp_73
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
