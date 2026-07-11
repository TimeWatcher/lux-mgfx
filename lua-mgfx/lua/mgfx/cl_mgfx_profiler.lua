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
	local table_concat = table.concat
	local table_remove = table.remove
	local rolling = {}
	local scopeRolling = {}
	local recentScopes = {}
	local instanceRolling = {}
	local instanceProfileRolling = {}
	local instanceCommandRolling = {}
	local instanceImmediateRolling = {}
	local instanceCurrent
	local frameIndex = 0
	local active = false
	local traceRoot
	local traceStack
	local currentScope
	local wrappedOwner
	local wrappedNames
	local wrappedSuppress
	local wrappedOriginals = {}
	local wrappersInstalled = false
	local registry = MGFX._ProfilerRegistry or {items = {}, nextId = 0}
	MGFX._ProfilerRegistry = registry
	registry.items = registry.items or {}
	for id, item in pairs(registry.items) do
		if item.owner == M then
			if item.callbackId and cvars and cvars.RemoveChangeCallback then
				cvars.RemoveChangeCallback("mgfx_profile", item.callbackId)
			end
			registry.items[id] = nil
		end
	end
	registry.nextId = (registry.nextId or 0) + 1
	local instanceId = registry.nextId
	local instanceName = tostring(C.name or M._ProfilerName or M._LuxRuntimeBase or M._BasePath or ("instance " .. tostring(instanceId)))
	local callbackId = "MGFXProfileApiWrappers" .. tostring(instanceId)
	local RECENT_SCOPE_LIMIT = 96
	local scalarStatKeys = {
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
	local tableStatKeys = {
		"drawCommandCounts",
		"drawImmediateCounts",
		"profileTimes",
		"profileCounts",
		"textProfileTimes",
		"textProfileCounts",
	}
	local broadProfileLabels = {
		frame = true,
		paintBuild = true,
		paintTotal = true,
	}

	local api = {}
	local isEnabled
	local windowSize
	local topLimit

	local function clearTable(t)
		if not t then return end
		if table.Empty then
			table.Empty(t)
			return
		end
		for key in pairs(t) do
			t[key] = nil
		end
	end

	local function copyCounts(source)
		local out = {}
		for key, value in pairs(source or {}) do
			out[key] = tonumber(value) or 0
		end
		return out
	end

	local function addCountsInto(out, source)
		for key, value in pairs(source or {}) do
			out[key] = (out[key] or 0) + (tonumber(value) or 0)
		end
	end

	local function copyScalarStats(source)
		local out = {}
		for i = 1, #scalarStatKeys do
			local key = scalarStatKeys[i]
			out[key] = tonumber(source and source[key]) or 0
		end
		return out
	end

	local function snapshotStats()
		local stats = M.stats or {}
		local out = {}
		for i = 1, #scalarStatKeys do
			local key = scalarStatKeys[i]
			out[key] = tonumber(stats[key]) or 0
		end
		for i = 1, #tableStatKeys do
			local key = tableStatKeys[i]
			out[key] = copyCounts(stats[key])
		end
		return out
	end

	local function diffCounts(after, before)
		local out = {}
		local total = 0
		for key, value in pairs(after or {}) do
			local delta = (tonumber(value) or 0) - (tonumber(before and before[key]) or 0)
			if delta ~= 0 then
				out[key] = delta
				total = total + delta
			end
		end
		for key, value in pairs(before or {}) do
			if not after or after[key] == nil then
				local delta = -(tonumber(value) or 0)
				if delta ~= 0 then
					out[key] = delta
					total = total + delta
				end
			end
		end
		return out, total
	end

	local function diffStats(startStats)
		local now = snapshotStats()
		local out = {}
		for i = 1, #scalarStatKeys do
			local key = scalarStatKeys[i]
			local delta = (now[key] or 0) - ((startStats and startStats[key]) or 0)
			out[key] = delta
		end
		for i = 1, #tableStatKeys do
			local key = tableStatKeys[i]
			out[key] = diffCounts(now[key], startStats and startStats[key])
		end
		return out
	end

	local function sumCounts(source)
		local total = 0
		for _, value in pairs(source or {}) do
			total = total + (tonumber(value) or 0)
		end
		return total
	end

	local function topRowsFromCounts(times, counts, limit, prefix, omitBroad)
		local rows = {}
		for name, ms in pairs(times or {}) do
			local include = (not prefix or string.sub(tostring(name), 1, #prefix) == prefix)
			if include and (not omitBroad or not broadProfileLabels[name]) then
				rows[#rows + 1] = {
					name = name,
					last = ms or 0,
					avg = ms or 0,
					max = ms or 0,
					count = counts and counts[name] or 0,
					avgCount = counts and counts[name] or 0,
				}
			end
		end
		table_sort(rows, function(a, b)
			if (a.avg or a.last or 0) == (b.avg or b.last or 0) then return a.name < b.name end
			return (a.avg or a.last or 0) > (b.avg or b.last or 0)
		end)
		limit = math_max(1, tonumber(limit) or 6)
		while #rows > limit do rows[#rows] = nil end
		return rows
	end

	local function topRowsFromBuckets(store, limit, prefix, omitBroad)
		local rows = {}
		for key, bucket in pairs(store or {}) do
			local name = bucket.meta and bucket.meta.name or key
			local include = (not prefix or string.sub(tostring(name), 1, #prefix) == prefix)
			if include and (not omitBroad or not broadProfileLabels[name]) then
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
		end
		table_sort(rows, function(a, b)
			if a.avg == b.avg then return a.name < b.name end
			return a.avg > b.avg
		end)
		limit = math_max(1, tonumber(limit) or 6)
		while #rows > limit do rows[#rows] = nil end
		return rows
	end

	local function newTraceNode(name)
		return {
			name = tostring(name or "unknown"),
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

	local function traceChild(parent, name)
		local key = tostring(name or "unknown")
		local node = parent.childMap[key]
		if node then return node end

		node = newTraceNode(key)
		parent.childMap[key] = node
		parent.children[#parent.children + 1] = node
		return node
	end

	local function copyTraceNode(node)
		if not node then return nil end
		local out = {
			name = node.name,
			total = node.total or 0,
			self = node.self or 0,
			childTotal = node.childTotal or 0,
			count = node.count or 0,
			max = node.max or 0,
			selfMax = node.selfMax or 0,
			children = {},
		}
		for i = 1, #node.children do
			out.children[i] = copyTraceNode(node.children[i])
		end
		return out
	end

	local function finishTraceSpan(token)
		local elapsed = (SysTime() - token.started) * 1000
		local selfElapsed = elapsed - (token.childElapsed or 0)
		if selfElapsed < 0 then selfElapsed = 0 end
		local node = token.node
		node.total = (node.total or 0) + elapsed
		node.self = (node.self or 0) + selfElapsed
		node.childTotal = (node.childTotal or 0) + (token.childElapsed or 0)
		node.count = (node.count or 0) + 1
		if elapsed > (node.max or 0) then node.max = elapsed end
		if selfElapsed > (node.selfMax or 0) then node.selfMax = selfElapsed end
		return elapsed
	end

	local function formatCallsite(callsite)
		if not callsite then return "unknown" end
		local source = callsite.short_src or callsite.source or callsite.file or "?"
		local line = callsite.currentline or callsite.line or 0
		local name = callsite.name
		if name and name ~= "" then
			return tostring(source) .. ":" .. tostring(line) .. " " .. tostring(name)
		end
		return tostring(source) .. ":" .. tostring(line)
	end

	local function panelLabel(panel, kind)
		if kind == "screen" or panel == nil then
			return "screen"
		end

		local className = panel.GetClassName and panel:GetClassName() or nil
		local name = panel.GetName and panel:GetName() or nil
		local parts = {}
		if className and className ~= "" then parts[#parts + 1] = className end
		if name and name ~= "" and name ~= className then parts[#parts + 1] = name end
		parts[#parts + 1] = tostring(panel)
		return table_concat(parts, " ")
	end

	local function scopeKey(kind, subject, info)
		kind = tostring(kind or "frame")
		if subject ~= nil then
			return kind .. ":" .. tostring(subject)
		end
		local callsite = info and info.callsite
		if callsite then
			return kind .. ":" .. formatCallsite(callsite)
		end
		return kind .. ":unknown"
	end

	local function rollBucket(store, key, ms, count, meta)
		local window = windowSize()
		local bucket = store[key]
		if not bucket then
			bucket = {samples = {}, counts = {}, index = 1, n = 0, sum = 0, countSum = 0, max = 0, last = 0, lastCount = 0}
			store[key] = bucket
		end

		local idx = bucket.index
		local oldMs = bucket.samples[idx] or 0
		if bucket.n == window then
			bucket.sum = bucket.sum - oldMs
			bucket.countSum = bucket.countSum - (bucket.counts[idx] or 0)
		else
			bucket.n = bucket.n + 1
		end

		count = count or 0
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
		bucket.meta = meta
		return bucket
	end

	local function rollSeries(store, values, counts)
		for key in pairs(store) do
			if not values or values[key] == nil then
				rollBucket(store, key, 0, 0, {name = key})
			end
		end
		for key, value in pairs(values or {}) do
			rollBucket(store, key, tonumber(value) or 0, counts and counts[key] or value or 0, {name = key})
		end
	end

	local function rollInstanceFrame()
		local aggregate = instanceCurrent
		if not aggregate or (aggregate.scopes or 0) <= 0 then return end

		local stats = copyScalarStats(aggregate.stats)
		stats.drawCommandCounts = copyCounts(aggregate.commandCounts)
		stats.drawImmediateCounts = copyCounts(aggregate.immediateCounts)
		rollBucket(instanceRolling, "runtime", aggregate.elapsed or 0, aggregate.scopes or 0, {
			name = "[" .. instanceName .. "] total",
			stats = stats,
			profileTimes = copyCounts(aggregate.profileTimes),
			profileCounts = copyCounts(aggregate.profileCounts),
		})
		rollSeries(instanceProfileRolling, aggregate.profileTimes, aggregate.profileCounts)
		rollSeries(instanceCommandRolling, aggregate.commandCounts, aggregate.commandCounts)
		rollSeries(instanceImmediateRolling, aggregate.immediateCounts, aggregate.immediateCounts)
	end

	local function clearInstanceCurrent()
		instanceCurrent = nil
	end

	local function currentEngineFrame()
		return FrameNumber and FrameNumber() or frameIndex
	end

	local function ensureInstanceAggregate()
		local engineFrame = currentEngineFrame()
		if instanceCurrent and instanceCurrent.frame ~= engineFrame then
			rollInstanceFrame()
			clearInstanceCurrent()
		end
		if not instanceCurrent then
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

	local function accumulateInstanceScope(elapsedMs, stats, profileTimes, profileCounts)
		local aggregate = ensureInstanceAggregate()
		aggregate.elapsed = (aggregate.elapsed or 0) + (elapsedMs or 0)
		aggregate.scopes = (aggregate.scopes or 0) + 1
		for i = 1, #scalarStatKeys do
			local key = scalarStatKeys[i]
			aggregate.stats[key] = (aggregate.stats[key] or 0) + (tonumber(stats and stats[key]) or 0)
		end
		addCountsInto(aggregate.profileTimes, profileTimes)
		addCountsInto(aggregate.profileCounts, profileCounts)
		addCountsInto(aggregate.commandCounts, stats and stats.drawCommandCounts)
		addCountsInto(aggregate.immediateCounts, stats and stats.drawImmediateCounts)
	end

	local function scopeRowFromBucket(key, bucket)
		local meta = bucket.meta or {}
		local n = bucket.n > 0 and bucket.n or 1
		local stats = meta.stats or {}
		return {
			key = key,
			name = meta.name or key,
			kind = meta.kind or "frame",
			callsite = meta.callsiteText or "unknown",
			last = bucket.last or 0,
			avg = (bucket.sum or 0) / n,
			max = bucket.max or 0,
			count = bucket.lastCount or 0,
			avgCount = (bucket.countSum or 0) / n,
			samples = bucket.n or 0,
			stats = stats,
			profileTimes = meta.profileTimes or {},
			profileCounts = meta.profileCounts or {},
			profileTop = meta.profileTop or {},
			commandCounts = stats.drawCommandCounts or {},
			immediateCounts = stats.drawImmediateCounts or {},
		}
	end

	local function finishScope(scope)
		if not scope then return end

		local elapsedMs = (SysTime() - scope.started) * 1000
		local stats = diffStats(scope.startStats)
		local profileTimes = copyCounts(stats.profileTimes)
		local profileCounts = copyCounts(stats.profileCounts)
		accumulateInstanceScope(elapsedMs, stats, profileTimes, profileCounts)
		local row = {
			name = scope.name,
			kind = scope.kind,
			callsiteText = scope.callsiteText,
			stats = stats,
			profileTimes = profileTimes,
			profileCounts = profileCounts,
			profileTop = topRowsFromCounts(profileTimes, profileCounts, 6),
		}
		rollBucket(scopeRolling, scope.key, elapsedMs, 1, row)

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
			profileTop = row.profileTop,
			frame = frameIndex,
		}
		while #recentScopes > RECENT_SCOPE_LIMIT do
			table_remove(recentScopes, 1)
		end
	end

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
			local unwrapped = unwrapKnownProfilerWrapper(current)
			if unwrapped ~= current then
				owner[name] = unwrapped
			end
			if shared then shared[name] = nil end
		end
	end

	function isEnabled()
		return enabledConVar and enabledConVar.GetBool and enabledConVar:GetBool() or false
	end

	function windowSize()
		return math_max(1, windowConVar and windowConVar.GetInt and windowConVar:GetInt() or 120)
	end

	function topLimit()
		return math_max(1, topConVar and topConVar.GetInt and topConVar:GetInt() or 18)
	end

	function api.IsEnabled()
		return isEnabled()
	end

	function api.InstanceId()
		return instanceId
	end

	function api.InstanceName()
		return instanceName
	end

	function api.BeginFrame(kind, subject, info)
		active = isEnabled()
		currentScope = nil
		if active then
			frameIndex = frameIndex + 1
			info = info or {}
			local scopeKind = tostring(kind or "frame")
			local key = scopeKey(scopeKind, subject, info)
			currentScope = {
				key = key,
				kind = scopeKind,
				name = info.label or panelLabel(subject, scopeKind),
				callsiteText = formatCallsite(info.callsite),
				started = SysTime(),
				startStats = snapshotStats(),
			}
		end
		return active
	end

	function api.IsActive()
		return active
	end

	api._TraceActive = false

	function api.BeginTrace(name)
		if api._TraceActive then
			error("MGFX trace already active")
		end
		traceRoot = newTraceNode(name or "trace")
		traceStack = {{
			node = traceRoot,
			started = SysTime(),
			childElapsed = 0,
		}}
		api._TraceActive = true
		return traceRoot
	end

	function api.TraceActive()
		return api._TraceActive
	end

	function api.TraceStart(name)
		if not api._TraceActive or not traceStack then return nil end
		local parent = traceStack[#traceStack]
		if not parent then return nil end
		local token = {
			node = traceChild(parent.node, name),
			started = SysTime(),
			childElapsed = 0,
		}
		traceStack[#traceStack + 1] = token
		return token
	end

	function api.TraceEnd(token)
		if not token then return end
		if not api._TraceActive or not traceStack then
			error("MGFX trace span ended with no active trace")
		end
		local top = traceStack[#traceStack]
		if top ~= token then
			error("MGFX trace span stack mismatch")
		end
		local elapsed = finishTraceSpan(token)
		traceStack[#traceStack] = nil
		local parent = traceStack[#traceStack]
		if parent then
			parent.childElapsed = (parent.childElapsed or 0) + elapsed
		end
	end

	function api.EndTrace()
		if not api._TraceActive then return nil end
		if not traceStack or #traceStack ~= 1 then
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
		finishScope(currentScope)
		currentScope = nil
		for name, ms in pairs(M.stats.profileTimes or {}) do
			local count = (M.stats.profileCounts and M.stats.profileCounts[name]) or 0
			rollBucket(rolling, name, ms, count, {name = name})
		end
		active = false
	end

	function api.Reset()
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
			local current = wrappedOwner[name]
			if current ~= original then
				local unwrapped = unwrapKnownProfilerWrapper(current)
				if unwrapped ~= current then
					wrappedOwner[name] = unwrapped
				end
			else
				wrappedOwner[name] = original
			end
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
			cvars.RemoveChangeCallback("mgfx_profile", callbackId)
		end
		if cvars and cvars.AddChangeCallback then
			cvars.AddChangeCallback("mgfx_profile", function(_, _, newValue)
				if tobool(newValue) then
					wrapApi()
				else
					unwrapApi()
				end
			end, callbackId)
		end
		if isEnabled() then wrapApi() end
	end

	function api.Snapshot(limit)
		limit = limit or topLimit()
		local rows = {}
		for name, bucket in pairs(rolling) do
			local n = bucket.n > 0 and bucket.n or 1
			rows[#rows + 1] = {
				name = "[" .. instanceName .. "] " .. name,
				localName = name,
				instance = instanceName,
				instanceId = instanceId,
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

	function api.ScopeRows(limit)
		limit = limit or topLimit()
		local rows = {}
		for key, bucket in pairs(scopeRolling) do
			local row = scopeRowFromBucket(key, bucket)
			row.localName = row.name
			row.instance = instanceName
			row.instanceId = instanceId
			row.name = "[" .. instanceName .. "] " .. row.name
			rows[#rows + 1] = row
		end

		table_sort(rows, function(a, b)
			if a.avg == b.avg then return a.last > b.last end
			return a.avg > b.avg
		end)

		while #rows > limit do rows[#rows] = nil end
		return rows
	end

	function api.RecentScopes(limit)
		limit = limit or topLimit()
		local rows = {}
		local first = math_max(1, #recentScopes - limit + 1)
		for i = #recentScopes, first, -1 do
			rows[#rows + 1] = recentScopes[i]
		end
		return rows
	end

	function api.CurrentRows(limit)
		limit = limit or topLimit()
		local rows = {}
		for name, ms in pairs(M.stats.profileTimes or {}) do
			rows[#rows + 1] = {
				name = "[" .. instanceName .. "] " .. name,
				localName = name,
				instance = instanceName,
				instanceId = instanceId,
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

	function api.InstanceRows(limit)
		limit = limit or topLimit()
		if instanceCurrent and instanceCurrent.frame ~= currentEngineFrame() then
			rollInstanceFrame()
			clearInstanceCurrent()
		end
		local bucket = instanceRolling.runtime
		local current = instanceCurrent
		if not bucket and not current then return {} end

		local n = bucket and bucket.n > 0 and bucket.n or 1
		local meta = bucket and bucket.meta or {}
		local rowStats = current and current.stats or meta.stats or {}
		local row = {
			name = "[" .. instanceName .. "] total",
			localName = "total",
			instance = instanceName,
			instanceId = instanceId,
			last = current and current.elapsed or (bucket and bucket.last or 0),
			avg = bucket and (bucket.sum or 0) / n or (current and current.elapsed or 0),
			max = bucket and bucket.max or (current and current.elapsed or 0),
			count = current and current.scopes or (bucket and bucket.lastCount or 0),
			avgCount = bucket and (bucket.countSum or 0) / n or (current and current.scopes or 0),
			samples = bucket and bucket.n or 0,
			stats = rowStats,
			profileTop = topRowsFromBuckets(instanceProfileRolling, limit, nil, true),
			apiTop = topRowsFromBuckets(instanceProfileRolling, limit, "api.", false),
			commandTop = topRowsFromBuckets(instanceCommandRolling, limit),
			immediateTop = topRowsFromBuckets(instanceImmediateRolling, limit),
		}

		if #row.profileTop == 0 and current then
			row.profileTop = topRowsFromCounts(current.profileTimes, current.profileCounts, limit, nil, true)
		end
		if #row.apiTop == 0 and current then
			row.apiTop = topRowsFromCounts(current.profileTimes, current.profileCounts, limit, "api.", false)
		end
		if #row.commandTop == 0 and current then
			row.commandTop = topRowsFromCounts(current.commandCounts, current.commandCounts, limit)
		end
		if #row.immediateTop == 0 and current then
			row.immediateTop = topRowsFromCounts(current.immediateCounts, current.immediateCounts, limit)
		end

		return {row}
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

	function api.FormatScopeRows(rows, includeBreakdown)
		local out = {}
		for _, row in ipairs(rows or {}) do
			local stats = row.stats or {}
			out[#out + 1] = string.format("%s last=%.3f avg=%.3f max=%.3f draws=%d blur=%d captures=%d reuses=%d text=%d shaderText=%d bakes=%d fallbacks=%d samples=%d call=%s",
				row.name or row.key or "scope",
				row.last or 0,
				row.avg or row.last or 0,
				row.max or row.last or 0,
				stats.draws or 0,
				stats.blurPasses or 0,
				stats.blurCaptures or 0,
				stats.blurReuses or 0,
				stats.textDraws or 0,
				stats.textShaderDraws or 0,
				stats.textComposedBakes or 0,
				stats.fallbacks or 0,
				row.samples or 1,
				row.callsite or "unknown")
			if includeBreakdown then
				local top = row.profileTop or topRowsFromCounts(row.profileTimes, row.profileCounts, 5)
				if #top > 0 then
					local parts = {}
					for i = 1, #top do
						local item = top[i]
						parts[#parts + 1] = string.format("%s=%.3fms/%d", item.name, item.last or 0, item.count or 0)
					end
					out[#out + 1] = "  top " .. table_concat(parts, "  ")
				end
				local commands = row.commandCounts or {}
				if sumCounts(commands) > 0 then
					local parts = {}
					for key, value in pairs(commands) do
						parts[#parts + 1] = tostring(key) .. "=" .. tostring(value)
					end
					table_sort(parts)
					out[#out + 1] = "  commands " .. table_concat(parts, " ")
				end
			end
		end
		return out
	end

	registry.items[instanceId] = {
		id = instanceId,
		name = instanceName,
		owner = M,
		profiler = api,
		callbackId = callbackId,
	}
	M._ProfilerInstanceId = instanceId
	M._ProfilerName = instanceName

	return api
end
