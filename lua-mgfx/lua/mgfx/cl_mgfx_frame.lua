if SERVER then return end

MGFX = MGFX or {}

function MGFX._InstallFrame(C)
	local M = C.M
	local forceFallback = C.forceFallback
	local profileEnabled = C.profileEnabled
	local drawCountsEnabled = C.drawCountsEnabled
	local profiler = C.profiler
	local clipStack = C.clipStack
	local frameState = C.frameState
	local commandState = C.commandState
	local commandApi = C.commandApi
	local acquireCommandStack = C.acquireCommandStack or function() return {} end
	local releaseCommandStack = C.releaseCommandStack or function() end
	local resetStats = C.resetStats
	local textRenderer = C.textRenderer
	local SysTime = SysTime
	local profileFrameActive = false
	assert(commandApi, "MGFX frame module requires commandApi")

local function profileStart()
	if profileFrameActive then
		return SysTime()
	end
	return nil
end

local function profileEnd(name, started)
	if not started then return end
	local elapsed = (SysTime() - started) * 1000
	if profiler and profiler.Record then
		profiler.Record(name, elapsed)
	else
		local times = M.stats.profileTimes
		times[name] = (times[name] or 0) + elapsed
	end
end

local function addStat(tableName, key, amount)
	local t = M.stats[tableName]
	if not t then return end
	key = key or "unknown"
	t[key] = (t[key] or 0) + (amount or 1)
end

local function applyPushClip(x, y, w, h)
	x = tonumber(x) or 0
	y = tonumber(y) or 0
	w = tonumber(w) or 0
	h = tonumber(h) or 0

	local frameX = frameState.screenX or 0
	local frameY = frameState.screenY or 0
	local sx = frameX + x
	local sy = frameY + y
	local ex = sx + w
	local ey = sy + h
	local parent = clipStack[#clipStack]
	if parent then
		sx = math.max(sx, parent.x)
		sy = math.max(sy, parent.y)
		ex = math.min(ex, parent.x + parent.w)
		ey = math.min(ey, parent.y + parent.h)
	end

	if ex <= sx or ey <= sy then
		clipStack[#clipStack + 1] = {
			localX = x,
			localY = y,
			x = sx,
			y = sy,
			w = 0,
			h = 0,
		}
		render.SetScissorRect(0, 0, 0, 0, true)
		return
	end

	clipStack[#clipStack + 1] = {
		localX = sx - frameX,
		localY = sy - frameY,
		x = sx,
		y = sy,
		w = ex - sx,
		h = ey - sy,
	}
	render.SetScissorRect(sx, sy, ex, ey, true)
end

local function applyPopClip()
	clipStack[#clipStack] = nil
	local clip = clipStack[#clipStack]
	if clip then
		render.SetScissorRect(clip.x, clip.y, clip.x + clip.w, clip.y + clip.h, true)
	else
		render.SetScissorRect(0, 0, 0, 0, false)
	end
end

local function installFrameClip()
	table.Empty(clipStack)
	if not frameState.clipToFrame then
		render.SetScissorRect(0, 0, 0, 0, false)
		return
	end

	local fw = tonumber(frameState.w) or 0
	local fh = tonumber(frameState.h) or 0
	if fw <= 0 or fh <= 0 then return end

	local sx = tonumber(frameState.screenX) or 0
	local sy = tonumber(frameState.screenY) or 0
	clipStack[#clipStack + 1] = {
		localX = 0,
		localY = 0,
		x = sx,
		y = sy,
		w = fw,
		h = fh,
		frame = true,
	}
	render.SetScissorRect(sx, sy, sx + fw, sy + fh, true)
end

local function flushTextBatch(textBatch, reason)
	if #textBatch == 0 then return end
	local profile = profileStart()
	if textRenderer and textRenderer.Flush then
		textRenderer.Flush(textBatch, reason)
	else
		for _, record in ipairs(textBatch) do
			draw.SimpleText(tostring(record.text or ""), record.font or "DermaDefault", record.x or 0, record.y or 0, record.color or color_white, record.alignX or TEXT_ALIGN_LEFT, record.alignY or TEXT_ALIGN_TOP)
		end
	end
	table.Empty(textBatch)
	profileEnd("textFlush", profile)
end

local function appendTextCommand(command, textBatch)
	local cmd = commandApi.text(command)
	if textRenderer and textRenderer.MakeRecord then
		textBatch[#textBatch + 1] = cmd.record or textRenderer.MakeRecord(cmd.text, cmd.font, cmd.x, cmd.y, cmd.color, cmd.ax, cmd.ay, cmd.style)
	else
		textBatch[#textBatch + 1] = {
			text = cmd.text,
			font = cmd.font,
			x = cmd.x,
			y = cmd.y,
			color = cmd.color,
			alignX = cmd.ax,
			alignY = cmd.ay,
		}
	end
end

local function appendTextBatchCommand(command, textBatch)
	local records = command.records
	if not records then return end
	for i = 1, #records do
		textBatch[#textBatch + 1] = records[i]
	end
end

local function drawTextBoxCommand(command)
	if frameState.drawCountsActive then
		addStat("drawImmediateCounts", "textBox")
	end
	local cmd = commandApi.textBox(command)
	if textRenderer and textRenderer.DrawTextBoxImmediate then
		textRenderer.DrawTextBoxImmediate(cmd.text, cmd.font, cmd.x, cmd.y, cmd.w, cmd.h, cmd.style)
	else
		local style = cmd.style or {}
		draw.SimpleText(tostring(cmd.text or ""), cmd.font or "DermaDefault", cmd.x or 0, cmd.y or 0, style.color or style.fill or color_white, style.alignX or TEXT_ALIGN_LEFT, style.alignY or TEXT_ALIGN_TOP)
	end
end

local function finishFrame(commands, frameProfile)
	commandState.replaying = false
	releaseCommandStack(commands)
	table.Empty(clipStack)
	render.SetScissorRect(0, 0, 0, 0, false)
	frameState.w = nil
	frameState.h = nil
	frameState.screenX = 0
	frameState.screenY = 0
	frameState.clipToFrame = false
	frameState.forceFallback = nil
	frameState.shadersActive = nil
	frameState.drawCountsActive = nil
	profileEnd("frame", frameProfile)
	profileEnd("paintTotal", frameState.profilePaintStarted)
	frameState.profilePaintStarted = nil
	if profiler and profiler.EndFrame then profiler.EndFrame() end
	profileFrameActive = false
end

local function startFrame(w, h, screenX, screenY)
	resetStats()
	profileFrameActive = profiler and profiler.BeginFrame and profiler.BeginFrame()
	if not profileFrameActive and profileEnabled and profileEnabled.GetBool then
		profileFrameActive = profileEnabled:GetBool()
	end
	table.Empty(clipStack)
	render.SetScissorRect(0, 0, 0, 0, false)
	commandState.stack = acquireCommandStack()
	commandState.replaying = false
	frameState.forceFallback = forceFallback:GetBool()
	frameState.shadersActive = not frameState.forceFallback and M.hasShaders()
	frameState.drawCountsActive = drawCountsEnabled and drawCountsEnabled.GetBool and drawCountsEnabled:GetBool() or false
	frameState.w = tonumber(w) or ScrW()
	frameState.h = tonumber(h) or ScrH()
	frameState.screenX = tonumber(screenX) or 0
	frameState.screenY = tonumber(screenY) or 0
	frameState.clipToFrame = false
	frameState.profilePaintStarted = profileStart()
end

local function flushFrame()
	if not commandState.stack then return end
	local frameProfile = profileStart()
	if frameProfile and frameState.profilePaintStarted and profiler and profiler.Record then
		profiler.Record("paintBuild", (frameProfile - frameState.profilePaintStarted) * 1000)
	end

	local commands = commandState.stack
	commandState.stack = nil
	commandState.replaying = true
	installFrameClip()

	local textBatch = {}
	local loopProfile = profileStart()
	for commandIndex = 1, #commands do
		local command = commands[commandIndex]
		local commandName = command and (command.op or command[1])
		local commandProfile = profileStart()
		if frameState.drawCountsActive then
			addStat("drawCommandCounts", commandName)
		end

		if commandName == "DrawText" then
			appendTextCommand(command, textBatch)
		elseif commandName == "DrawTextBatch" then
			appendTextBatchCommand(command, textBatch)
		elseif commandName == "DrawTextBox" then
			flushTextBatch(textBatch, "text")
			drawTextBoxCommand(command)
		elseif commandName == "PushClip" then
			flushTextBatch(textBatch, "clip")
			local cmd = commandApi.clip(command)
			applyPushClip(cmd.x, cmd.y, cmd.w, cmd.h)
		elseif commandName == "PopClip" then
			flushTextBatch(textBatch, "clip")
			applyPopClip()
		end

		profileEnd("cmd." .. tostring(commandName or "unknown"), commandProfile)
	end
	profileEnd("commandLoop", loopProfile)

	flushTextBatch(textBatch, "end")
	finishFrame(commands, frameProfile)
end

function M.StartPanel(panel, w, h)
	local sx, sy = 0, 0
	if IsValid(panel) and panel.LocalToScreen then
		sx, sy = panel:LocalToScreen(0, 0)
	end

	if (not w or not h) and IsValid(panel) and panel.GetSize then
		w, h = panel:GetSize()
	end

	startFrame(w, h, sx, sy)
	frameState.clipToFrame = true
	installFrameClip()
end

function M.EndPanel()
	return flushFrame()
end

function M.StartScreen(w, h)
	return startFrame(w or ScrW(), h or ScrH(), 0, 0)
end

function M.EndScreen()
	return flushFrame()
end

function M.PushClip(x, y, w, h)
	if commandState.stack and not commandState.replaying then
		C.queueCommand("PushClip", x, y, w, h)
	end
	applyPushClip(x, y, w, h)
end

function M.PopClip()
	if commandState.stack and not commandState.replaying then
		C.queueCommand("PopClip")
	end
	applyPopClip()
end

function M.DebugOverlay(x, y)
	x, y = x or 16, y or 16
	draw.SimpleText(string.format("MGFX draws:%d blur:%d fallback:%d culled:%d", M.stats.draws, M.stats.blurPasses, M.stats.fallbacks, M.stats.culled), "DermaDefault", x, y, color_white)
	draw.SimpleText(string.format("commands:%d immediate:%d", M.stats.textQueuedRecords or 0, M.stats.draws or 0), "DermaDefault", x, y + 14, Color(190, 225, 235))
	draw.SimpleText(string.format("text draws:%d native:%d composed:%d fallback:%d", M.stats.textDraws or 0, M.stats.textNativeDraws or 0, M.stats.textShaderDraws or 0, M.stats.textFallbacks or 0), "DermaDefault", x, y + 28, Color(210, 225, 230))
	draw.SimpleText(string.format("text composed bakes:%d blits:%d entries:%d evicts:%d", M.stats.textComposedBakes or 0, M.stats.textComposedBlits or 0, M.stats.textComposedEntries or 0, M.stats.textComposedEvicts or 0), "DermaDefault", x, y + 42, Color(170, 230, 200))
end

M._internal = M._internal or {}
M._internal.ResetStats = resetStats
M._internal.TextStatus = function()
	return textRenderer and textRenderer.Status and textRenderer.Status() or nil
end
M._internal.ClearTextMeasureCache = function()
	if textRenderer and textRenderer.ClearMeasureCache then textRenderer.ClearMeasureCache() end
end

end
