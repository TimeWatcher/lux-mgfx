if SERVER then return end

MGFX = MGFX or {}

function MGFX._CreateProfiler(C)
	local M = C.M
	local enabledConVar = C.enabledConVar
	local windowConVar = CreateClientConVar("mgfx_profile_window", "120", true, false, "MGFX: rolling profiler sample window.")
	local topConVar = CreateClientConVar("mgfx_profile_top", "18", true, false, "MGFX: number of profiler rows printed by mgfx_profile_status.")
	local SysTime = SysTime
	local math_max = math.max
	local table_sort = table.sort
	local rolling = {}
	local frameIndex = 0
	local active = false
	local wrappedOwner
	local wrappedNames
	local wrappedSuppress
	local wrappedOriginals = {}
	local wrappersInstalled = false

	local api = {}

	local function unwrapKnownProfilerWrapper(fn, depth)
		if not isfunction(fn) or not debug or not debug.getupvalue then return fn end
		if (depth or 0) > 8 then return fn end

		local original
		local profilerLabel = false
		for i = 1, 16 do
			local name, value = debug.getupvalue(fn, i)
			if name == nil then break end
			if name == "original" and isfunction(value) then
				original = value
			elseif name == "label" and isstring(value) and string.sub(value, 1, 4) == "api." then
				profilerLabel = true
			end
		end

		if profilerLabel and original then
			return unwrapKnownProfilerWrapper(original, (depth or 0) + 1)
		end
		return fn
	end

	local function restoreSharedWrappers(owner, names)
		if not owner or not names then return end
		local shared = owner._mgfxProfileOriginals
		for _, name in ipairs(names) do
			local current = owner[name]
			local original = shared and shared[name] or nil
			if original then
				owner[name] = original
				shared[name] = nil
			else
				owner[name] = unwrapKnownProfilerWrapper(current)
			end
		end
	end

	local function isEnabled()
		return enabledConVar and enabledConVar.GetBool and enabledConVar:GetBool() or false
	end

	local function windowSize()
		return math_max(1, windowConVar and windowConVar.GetInt and windowConVar:GetInt() or 120)
	end

	local function topLimit()
		return math_max(1, topConVar and topConVar.GetInt and topConVar:GetInt() or 18)
	end

	function api.BeginFrame()
		active = isEnabled()
		if active then frameIndex = frameIndex + 1 end
		return active
	end

	function api.IsActive()
		return active
	end

	function api.Start()
		if active then return SysTime() end
		return nil
	end

	function api.Record(name, elapsedMs, count)
		if not active or not elapsedMs then return end
		name = tostring(name or "unknown")
		local times = M.stats.profileTimes
		local counts = M.stats.profileCounts
		times[name] = (times[name] or 0) + elapsedMs
		counts[name] = (counts[name] or 0) + (count or 1)
	end

	function api.End(name, started, count)
		if not started then return end
		api.Record(name, (SysTime() - started) * 1000, count)
	end

	function api.EndFrame()
		if not active then return end
		local window = windowSize()
		for name, ms in pairs(M.stats.profileTimes or {}) do
			local bucket = rolling[name]
			if not bucket then
				bucket = {samples = {}, counts = {}, index = 1, n = 0, sum = 0, countSum = 0, max = 0, last = 0, lastCount = 0}
				rolling[name] = bucket
			end

			local idx = bucket.index
			local oldMs = bucket.samples[idx] or 0
			if bucket.n == window then
				bucket.sum = bucket.sum - oldMs
				bucket.countSum = bucket.countSum - (bucket.counts[idx] or 0)
			else
				bucket.n = bucket.n + 1
			end

			local count = (M.stats.profileCounts and M.stats.profileCounts[name]) or 0
			bucket.samples[idx] = ms
			bucket.counts[idx] = count
			bucket.sum = bucket.sum + ms
			bucket.countSum = bucket.countSum + count
			bucket.last = ms
			bucket.lastCount = count
			if ms >= (bucket.max or 0) then
				bucket.max = ms
			elseif oldMs >= (bucket.max or 0) then
				local maxValue = 0
				for i = 1, bucket.n do
					local sample = bucket.samples[i] or 0
					if sample > maxValue then maxValue = sample end
				end
				bucket.max = maxValue
			end
			bucket.index = (idx % window) + 1
			bucket.frame = frameIndex
		end
	end

	function api.Reset()
		table.Empty(rolling)
		frameIndex = 0
	end

	local function wrapApi()
		if wrappersInstalled or not wrappedOwner or not wrappedNames then return end
		wrappedOwner._mgfxProfileOriginals = wrappedOwner._mgfxProfileOriginals or {}
		local shared = wrappedOwner._mgfxProfileOriginals
		for _, name in ipairs(wrappedNames) do
			local original = unwrapKnownProfilerWrapper(wrappedOwner[name])
			if isfunction(original) then
				local label = "api." .. name
				shared[name] = original
				wrappedOriginals[name] = original
				wrappedOwner[name] = function(...)
					local started = active and not (wrappedSuppress and wrappedSuppress()) and SysTime() or nil
					local a, b, c, d = original(...)
					if started then api.Record(label, (SysTime() - started) * 1000) end
					return a, b, c, d
				end
			end
		end
		wrappersInstalled = true
	end

	local function unwrapApi()
		if not wrappersInstalled or not wrappedOwner then return end
		local shared = wrappedOwner._mgfxProfileOriginals
		for name, original in pairs(wrappedOriginals) do
			wrappedOwner[name] = original
			if shared then shared[name] = nil end
			wrappedOriginals[name] = nil
		end
		wrappersInstalled = false
	end

	function api.InstallApiWrappers(owner, names, suppress)
		restoreSharedWrappers(owner, names)
		wrappedOwner = owner
		wrappedNames = names
		wrappedSuppress = suppress
		if cvars and cvars.RemoveChangeCallback then
			cvars.RemoveChangeCallback("mgfx_profile", "MGFXProfileApiWrappers")
		end
		if cvars and cvars.AddChangeCallback then
			cvars.AddChangeCallback("mgfx_profile", function(_, _, newValue)
				if tobool(newValue) then
					wrapApi()
				else
					unwrapApi()
				end
			end, "MGFXProfileApiWrappers")
		end
		if isEnabled() then wrapApi() end
	end

	function api.Snapshot(limit)
		limit = limit or topLimit()
		local rows = {}
		for name, bucket in pairs(rolling) do
			local n = bucket.n > 0 and bucket.n or 1
			rows[#rows + 1] = {
				name = name,
				last = bucket.last or 0,
				avg = (bucket.sum or 0) / n,
				max = bucket.max or 0,
				count = bucket.lastCount or 0,
				avgCount = (bucket.countSum or 0) / n,
				samples = bucket.n or 0,
			}
		end

		table_sort(rows, function(a, b)
			if a.avg == b.avg then return a.last > b.last end
			return a.avg > b.avg
		end)

		while #rows > limit do rows[#rows] = nil end
		return rows
	end

	function api.CurrentRows(limit)
		limit = limit or topLimit()
		local rows = {}
		for name, ms in pairs(M.stats.profileTimes or {}) do
			rows[#rows + 1] = {
				name = name,
				last = ms or 0,
				count = (M.stats.profileCounts and M.stats.profileCounts[name]) or 0,
			}
		end

		table_sort(rows, function(a, b)
			if a.last == b.last then return a.name < b.name end
			return a.last > b.last
		end)

		while #rows > limit do rows[#rows] = nil end
		return rows
	end

	function api.FormatRows(rows, rollingRows)
		local out = {}
		for _, row in ipairs(rows or {}) do
			if rollingRows then
				out[#out + 1] = string.format("%s last=%.3f avg=%.3f max=%.3f count=%d avgCount=%.1f samples=%d",
					row.name, row.last or 0, row.avg or 0, row.max or 0, row.count or 0, row.avgCount or 0, row.samples or 0)
			else
				out[#out + 1] = string.format("%s %.3fms count=%d", row.name, row.last or 0, row.count or 0)
			end
		end
		return out
	end

	return api
end
