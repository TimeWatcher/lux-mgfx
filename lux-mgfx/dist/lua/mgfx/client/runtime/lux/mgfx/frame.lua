return function(__lux_import)
  local __lux_exports = {}
  local drawSimpleText
  local disableClipping
  local errorFn
  local pcallFn
  local renderSetScissorRect
  local surfaceSetDrawColor
  local surfaceDrawRect
  local mathCeil
  local mathFloor
  local mathMax
  local mathMin
  local toNumber
  local toString
  local debugLib
  local getConVar
  local sysTime
  local state
  local bleedStateStack
  local bleedStateTop
  local clipRecordPool
  local commandStackPool
  local profiler
  local profileActive
  local profileCallsite
  local profileStart
  local profileEnd
  local current
  local clearArray
  local acquireClipRecord
  local releaseClipRecord
  local clearClipStack
  local acquireCommandStack
  local releaseCommandStack
  local restoreScissor
  local beginExpandedScissor
  local panelClip
  local toScreen
  local isCulled
  local installFrameClip
  local beginCommandFrame
  local flushTextBatch
  local appendTextCommand
  local appendTextBatchCommand
  local drawTextBoxCommand
  local commandName
  local flushQueuedCommands
  local finishFrame
  local beginFrameProfile
  local startScreen
  local endScreen
  local startPanel
  local endPanel
  local pushClip
  local popClip
  local withClip
  local beginPanelEffectBleed
  local beginPanelEffectDraw
  local endPanelEffectBleed
  local withPanelEffectBleed
  local beginCommands
  local queue
  local flushCommands
  local debugOverlay
  local install
  do
    drawSimpleText = _G.draw.SimpleText
    disableClipping = DisableClipping
    errorFn = error
    pcallFn = pcall
    renderSetScissorRect = render.SetScissorRect
    surfaceSetDrawColor = surface.SetDrawColor
    surfaceDrawRect = surface.DrawRect
    mathCeil = math.ceil
    mathFloor = math.floor
    mathMax = math.max
    mathMin = math.min
    toNumber = tonumber
    toString = tostring
    debugLib = debug
    getConVar = GetConVar
    sysTime = SysTime
    state = {
      active = false,
      owner = nil,
      screenX = 0,
      screenY = 0,
      w = 0,
      h = 0,
      clipToFrame = false,
      clipStack = {},
      commandStack = nil,
      replaying = false,
    }
    bleedStateStack = {}
    bleedStateTop = 0
    clipRecordPool = {}
    commandStackPool = {}
    profiler = function()
      local __lux_obj_owner_1 = state.owner
      local __lux_val_Profiler_2 = nil
      if __lux_obj_owner_1 ~= nil then
        __lux_val_Profiler_2 = __lux_obj_owner_1.Profiler
      end
      return __lux_val_Profiler_2
    end
    profileActive = function()
      local api = profiler()
      if api ~= nil and api.IsEnabled ~= nil then
        return api.IsEnabled()
      end
      local cvar
      if getConVar ~= nil then
        cvar = getConVar("mgfx_profile")
      else
        cvar = nil
      end
      return cvar ~= nil and cvar.GetBool ~= nil and cvar:GetBool() or false
    end
    profileCallsite = function(level)
      if level == nil then
        level = 3
      end
      if not profileActive() or debugLib == nil or debugLib.getinfo == nil then
        return nil
      end
      return debugLib.getinfo(level, "Sln")
    end
    profileStart = function()
      local api = profiler()
      if api ~= nil and api.Start ~= nil then
        return api.Start()
      end
      return nil
    end
    profileEnd = function(name, started, count)
      if count == nil then
        count = 1
      end
      if started == nil then
        return
      end
      local api = profiler()
      if api ~= nil and api.Record ~= nil then
        api.Record(name, (sysTime() - started) * 1000, count)
      end
    end
    current = function()
      return state
    end
    clearArray = function(items)
      for index = #items, 1, -1 do
        items[index] = nil
      end
      return items
    end
    acquireClipRecord = function()
      local index = #clipRecordPool
      local clip = clipRecordPool[index]
      if clip ~= nil then
        clipRecordPool[index] = nil
        return clip
      end
      return {}
    end
    releaseClipRecord = function(clip)
      if clip == nil then
        return
      end
      clip.localX = nil
      clip.localY = nil
      clip.x = nil
      clip.y = nil
      clip.w = nil
      clip.h = nil
      clip.frame = nil
      clipRecordPool[#clipRecordPool + 1] = clip
    end
    clearClipStack = function()
      for index = #state.clipStack, 1, -1 do
        local clip = state.clipStack[index]
        state.clipStack[index] = nil
        releaseClipRecord(clip)
      end
    end
    acquireCommandStack = function()
      local index = #commandStackPool
      local stack = commandStackPool[index]
      if stack ~= nil then
        commandStackPool[index] = nil
        return stack
      end
      return {}
    end
    releaseCommandStack = function(stack)
      if stack == nil then
        return
      end
      clearArray(stack)
      commandStackPool[#commandStackPool + 1] = stack
    end
    restoreScissor = function()
      local clip = state.clipStack[#state.clipStack]
      if clip ~= nil then
        return renderSetScissorRect(clip.x, clip.y, clip.x + clip.w, clip.y + clip.h, true)
      else
        return renderSetScissorRect(0, 0, 0, 0, false)
      end
    end
    beginExpandedScissor = function(sx, sy, ex, ey)
      local token = bleedStateTop + 1
      bleedStateTop = token
      local saved = bleedStateStack[token]
      if saved == nil then
        saved = {}
        bleedStateStack[token] = saved
      end
      if disableClipping ~= nil then
        saved.prevClipping = disableClipping(true)
      else
        saved.prevClipping = nil
      end
      renderSetScissorRect(mathFloor(sx), mathFloor(sy), mathCeil(ex), mathCeil(ey), true)
      return token
    end
    panelClip = function()
      for index = 1, #state.clipStack do
        local clip = state.clipStack[index]
        if clip ~= nil and clip.frame == true then
          return clip
        end
      end
      return state.clipStack[1]
    end
    toScreen = function(x, y)
      local __lux_tmp_x_3 = x
      if __lux_tmp_x_3 == nil then
        __lux_tmp_x_3 = 0
      end
      local __lux_tmp_y_4 = y
      if __lux_tmp_y_4 == nil then
        __lux_tmp_y_4 = 0
      end
      return state.screenX + __lux_tmp_x_3, state.screenY + __lux_tmp_y_4
    end
    isCulled = function(x, y, w, h)
      local __lux_tmp_w_7 = w
      if __lux_tmp_w_7 == nil then
        __lux_tmp_w_7 = 0
      end
      local __lux_tmp_9 = __lux_tmp_w_7 <= 0
      if not __lux_tmp_9 then
        local __lux_tmp_h_8 = h
        if __lux_tmp_h_8 == nil then
          __lux_tmp_h_8 = 0
        end
        __lux_tmp_9 = __lux_tmp_h_8 <= 0
      end
      if __lux_tmp_9 then
        return true
      end
      local clip = state.clipStack[#state.clipStack]
      if clip == nil then
        return false
      end
      local __lux_tmp_w_12 = clip.w
      if __lux_tmp_w_12 == nil then
        __lux_tmp_w_12 = 0
      end
      local __lux_tmp_14 = __lux_tmp_w_12 <= 0
      if not __lux_tmp_14 then
        local __lux_tmp_h_13 = clip.h
        if __lux_tmp_h_13 == nil then
          __lux_tmp_h_13 = 0
        end
        __lux_tmp_14 = __lux_tmp_h_13 <= 0
      end
      if __lux_tmp_14 then
        return true
      end
      local __lux_tmp_localX_17 = clip.localX
      if __lux_tmp_localX_17 == nil then
        __lux_tmp_localX_17 = 0
      end
      local __lux_tmp_19 = x + w < __lux_tmp_localX_17
      if not __lux_tmp_19 then
        local __lux_tmp_localY_18 = clip.localY
        if __lux_tmp_localY_18 == nil then
          __lux_tmp_localY_18 = 0
        end
        __lux_tmp_19 = y + h < __lux_tmp_localY_18
      end
      local __lux_tmp_21 = __lux_tmp_19
      if not __lux_tmp_21 then
        local __lux_tmp_localX_20 = clip.localX
        if __lux_tmp_localX_20 == nil then
          __lux_tmp_localX_20 = 0
        end
        __lux_tmp_21 = x > __lux_tmp_localX_20 + clip.w
      end
      local __lux_tmp_23 = __lux_tmp_21
      if not __lux_tmp_23 then
        local __lux_tmp_localY_22 = clip.localY
        if __lux_tmp_localY_22 == nil then
          __lux_tmp_localY_22 = 0
        end
        __lux_tmp_23 = y > __lux_tmp_localY_22 + clip.h
      end
      if __lux_tmp_23 then
        return true
      end
      return false
    end
    installFrameClip = function()
      clearClipStack()
      if not state.clipToFrame then
        renderSetScissorRect(0, 0, 0, 0, false)
        return
      end
      local fw = state.w
      if fw == nil then
        fw = 0
      end
      local fh = state.h
      if fh == nil then
        fh = 0
      end
      if fw <= 0 or fh <= 0 then
        return
      end
      local sx = state.screenX
      if sx == nil then
        sx = 0
      end
      local sy = state.screenY
      if sy == nil then
        sy = 0
      end
      local clip = acquireClipRecord()
      clip.localX = 0
      clip.localY = 0
      clip.x = sx
      clip.y = sy
      clip.w = fw
      clip.h = fh
      clip.frame = true
      state.clipStack[#state.clipStack + 1] = clip
      return renderSetScissorRect(sx, sy, sx + fw, sy + fh, true)
    end
    beginCommandFrame = function()
      if state.commandStack ~= nil then
        return state.commandStack
      end
      state.commandStack = acquireCommandStack()
      state.replaying = false
      return state.commandStack
    end
    flushTextBatch = function(textBatch, reason)
      if reason == nil then
        reason = "end"
      end
      if #textBatch == 0 then
        return
      end
      local started = profileStart()
      local renderer
      do
        local __lux_obj_owner_24 = state.owner
        local __lux_val_TextRenderer_25 = nil
        if __lux_obj_owner_24 ~= nil then
          __lux_val_TextRenderer_25 = __lux_obj_owner_24._TextRenderer
        end
        renderer = __lux_val_TextRenderer_25
      end
      if renderer == nil or renderer.Flush == nil then
        errorFn("MGFX text renderer unavailable during frame text flush", 2)
      end
      renderer.Flush(textBatch, reason)
      profileEnd("textFlush", started)
      return clearArray(textBatch)
    end
    appendTextCommand = function(command, textBatch)
      local renderer
      do
        local __lux_obj_owner_26 = state.owner
        local __lux_val_TextRenderer_27 = nil
        if __lux_obj_owner_26 ~= nil then
          __lux_val_TextRenderer_27 = __lux_obj_owner_26._TextRenderer
        end
        renderer = __lux_val_TextRenderer_27
      end
      if command.record ~= nil then
        textBatch[#textBatch + 1] = command.record
      else
        if renderer ~= nil and renderer.MakeRecord ~= nil then
          textBatch[#textBatch + 1] = renderer.MakeRecord(
            command.text,
            command.font,
            command.x,
            command.y,
            command.color,
            command.ax,
            command.ay,
            command.style
          )
        else
          textBatch[#textBatch + 1] = command
        end
      end
    end
    appendTextBatchCommand = function(command, textBatch)
      local records = command.records
      if records == nil then
        return
      end
      for index = 1, #records do
        textBatch[#textBatch + 1] = records[index]
      end
    end
    drawTextBoxCommand = function(command)
      local ownerStats
      do
        local __lux_obj_owner_28 = state.owner
        local __lux_val_stats_29 = nil
        if __lux_obj_owner_28 ~= nil then
          __lux_val_stats_29 = __lux_obj_owner_28.stats
        end
        ownerStats = __lux_val_stats_29
      end
      if ownerStats ~= nil and state.drawCountsActive then
        do
          local __lux_tmp_drawImmediateCounts_30 = ownerStats.drawImmediateCounts
          if __lux_tmp_drawImmediateCounts_30 == nil then
            __lux_tmp_drawImmediateCounts_30 = {}
          end
          ownerStats.drawImmediateCounts = __lux_tmp_drawImmediateCounts_30
        end
        do
          local __lux_tmp_textBox_31 = ownerStats.drawImmediateCounts.textBox
          if __lux_tmp_textBox_31 == nil then
            __lux_tmp_textBox_31 = 0
          end
          ownerStats.drawImmediateCounts.textBox = __lux_tmp_textBox_31 + 1
        end
      end
      local renderer
      do
        local __lux_obj_owner_32 = state.owner
        local __lux_val_TextRenderer_33 = nil
        if __lux_obj_owner_32 ~= nil then
          __lux_val_TextRenderer_33 = __lux_obj_owner_32._TextRenderer
        end
        renderer = __lux_val_TextRenderer_33
      end
      if renderer == nil or renderer.DrawTextBoxImmediate == nil then
        errorFn("MGFX text renderer unavailable during frame textbox flush", 2)
      end
      return renderer.DrawTextBoxImmediate(
        command.text,
        command.font,
        command.x,
        command.y,
        command.w,
        command.h,
        command.style
      )
    end
    commandName = function(command)
      local __lux_obj_command_34 = command
      local __lux_tmp_op_35 = nil
      if __lux_obj_command_34 ~= nil then
        __lux_tmp_op_35 = __lux_obj_command_34.op
      end
      if __lux_tmp_op_35 == nil then
        local __lux_obj_command_36 = command
        local __lux_val_command_38 = nil
        if __lux_obj_command_36 ~= nil then
          local __lux_key_37 = 1
          __lux_val_command_38 = __lux_obj_command_36[__lux_key_37]
        end
        __lux_tmp_op_35 = __lux_val_command_38
      end
      return __lux_tmp_op_35
    end
    flushQueuedCommands = function()
      local stack = state.commandStack
      if stack == nil then
        return 0
      end
      local count = #stack
      state.commandStack = nil
      if count <= 0 then
        releaseCommandStack(stack)
        return 0
      end
      state.replaying = true
      installFrameClip()
      local textBatch = {}
      local loopProfile = profileStart()
      for index = 1, #stack do
        local command = stack[index]
        local name = commandName(command)
        local commandProfile = profileStart()
        local ownerStats
        do
          local __lux_obj_owner_39 = state.owner
          local __lux_val_stats_40 = nil
          if __lux_obj_owner_39 ~= nil then
            __lux_val_stats_40 = __lux_obj_owner_39.stats
          end
          ownerStats = __lux_val_stats_40
        end
        if ownerStats ~= nil and state.drawCountsActive then
          do
            local __lux_tmp_drawCommandCounts_41 = ownerStats.drawCommandCounts
            if __lux_tmp_drawCommandCounts_41 == nil then
              __lux_tmp_drawCommandCounts_41 = {}
            end
            ownerStats.drawCommandCounts = __lux_tmp_drawCommandCounts_41
          end
          local statKey = name
          if statKey == nil then
            statKey = "unknown"
          end
          do
            local __lux_tmp_statKey_42 = ownerStats.drawCommandCounts[statKey]
            if __lux_tmp_statKey_42 == nil then
              __lux_tmp_statKey_42 = 0
            end
            ownerStats.drawCommandCounts[statKey] = __lux_tmp_statKey_42 + 1
          end
        end
        local __lux_match_43 = commandName(command)
        if __lux_match_43 == "DrawText" then
          appendTextCommand(command, textBatch)
        elseif __lux_match_43 == "DrawTextBatch" then
          appendTextBatchCommand(command, textBatch)
        elseif __lux_match_43 == "DrawTextBox" then
          flushTextBatch(textBatch, "text")
          drawTextBoxCommand(command)
        elseif __lux_match_43 == "PushClip" then
          flushTextBatch(textBatch, "clip")
          pushClip(command.x, command.y, command.w, command.h)
        elseif __lux_match_43 == "PopClip" then
          flushTextBatch(textBatch, "clip")
          popClip()
        else
        end
        do
          local __lux_tmp_name_44 = name
          if __lux_tmp_name_44 == nil then
            __lux_tmp_name_44 = "unknown"
          end
          profileEnd("cmd." .. toString(__lux_tmp_name_44), commandProfile)
        end
      end
      profileEnd("commandLoop", loopProfile)
      flushTextBatch(textBatch, "end")
      releaseCommandStack(stack)
      state.replaying = false
      return count
    end
    finishFrame = function()
      local frameProfile = state.profileFrameStarted
      profileEnd("frame", frameProfile)
      profileEnd("paintTotal", state.profilePaintStarted)
      state.profileFrameStarted = nil
      state.profilePaintStarted = nil
      local api = profiler()
      if api ~= nil and api.EndFrame ~= nil then
        api.EndFrame()
      end
      clearClipStack()
      renderSetScissorRect(0, 0, 0, 0, false)
      state.active = false
      state.w = 0
      state.h = 0
      state.screenX = 0
      state.screenY = 0
      state.clipToFrame = false
      state.drawCountsActive = false
      state.commandStack = nil
      state.replaying = false
      return state
    end
    beginFrameProfile = function(kind, subject, label)
      local enabled = profileActive()
      local api
      if enabled then
        api = profiler()
      else
        api = nil
      end
      local active = false
      if api ~= nil and api.BeginFrame ~= nil then
        local info = { callsite = profileCallsite(4) }
        if label ~= nil then
          info.label = label
        end
        active = api.BeginFrame(kind, subject, info)
      end
      do
        local __lux_tmp_45
        local cvar
        if getConVar ~= nil then
          cvar = getConVar("mgfx_draw_counts")
        else
          cvar = nil
        end
        __lux_tmp_45 = cvar ~= nil and cvar.GetBool ~= nil and cvar:GetBool() or false
        state.drawCountsActive = __lux_tmp_45
      end
      if active then
        state.profilePaintStarted = profileStart()
        state.profileFrameStarted = nil
      else
        state.profilePaintStarted = nil
        state.profileFrameStarted = nil
      end
    end
    startScreen = function(w, h)
      if w == nil then
        w = ScrW()
      end
      if h == nil then
        h = ScrH()
      end
      state.active = true
      state.screenX = 0
      state.screenY = 0
      state.w = w
      state.h = h
      state.clipToFrame = false
      state.commandStack = nil
      state.replaying = false
      beginFrameProfile("screen", nil, "screen")
      installFrameClip()
      return state
    end
    endScreen = function()
      local frameProfile = profileStart()
      if frameProfile ~= nil and state.profilePaintStarted ~= nil then
        local api = profiler()
        if api ~= nil and api.Record ~= nil then
          api.Record("paintBuild", (frameProfile - state.profilePaintStarted) * 1000)
        end
      end
      state.profileFrameStarted = frameProfile
      flushQueuedCommands()
      return finishFrame()
    end
    startPanel = function(panel, w, h)
      local x = 0
      local y = 0
      if panel ~= nil and panel.LocalToScreen ~= nil then
        x, y = panel:LocalToScreen(0, 0)
      end
      state.active = true
      state.screenX = x
      state.screenY = y
      do
        local __lux_tmp_w_46 = w
        if __lux_tmp_w_46 == nil then
          local __lux_tmp_47
          if panel ~= nil and panel.GetWide ~= nil then
            __lux_tmp_47 = panel:GetWide()
          else
            __lux_tmp_47 = 0
          end
          __lux_tmp_w_46 = __lux_tmp_47
        end
        state.w = __lux_tmp_w_46
      end
      do
        local __lux_tmp_h_48 = h
        if __lux_tmp_h_48 == nil then
          local __lux_tmp_49
          if panel ~= nil and panel.GetTall ~= nil then
            __lux_tmp_49 = panel:GetTall()
          else
            __lux_tmp_49 = 0
          end
          __lux_tmp_h_48 = __lux_tmp_49
        end
        state.h = __lux_tmp_h_48
      end
      state.clipToFrame = true
      state.commandStack = nil
      state.replaying = false
      beginFrameProfile("panel", panel)
      installFrameClip()
      return state
    end
    endPanel = function()
      return endScreen()
    end
    pushClip = function(x, y, w, h)
      if x == nil then
        x = 0
      end
      if y == nil then
        y = 0
      end
      if w == nil then
        w = 0
      end
      if h == nil then
        h = 0
      end
      if state.commandStack ~= nil and not state.replaying then
        state.commandStack[#state.commandStack + 1] = { op = "PushClip", x = x, y = y, w = w, h = h }
      end
      local sx, sy = toScreen(x, y)
      local ex = sx + w
      local ey = sy + h
      local parent = state.clipStack[#state.clipStack]
      if parent ~= nil then
        sx = mathMax(sx, parent.x)
        sy = mathMax(sy, parent.y)
        ex = mathMin(ex, parent.x + parent.w)
        ey = mathMin(ey, parent.y + parent.h)
      end
      if ex <= sx or ey <= sy then
        local clip = acquireClipRecord()
        clip.localX = x
        clip.localY = y
        clip.x = sx
        clip.y = sy
        clip.w = 0
        clip.h = 0
        clip.frame = nil
        state.clipStack[#state.clipStack + 1] = clip
        renderSetScissorRect(0, 0, 0, 0, true)
        return clip
      end
      local clip = acquireClipRecord()
      do
        local __lux_tmp_screenX_50 = state.screenX
        if __lux_tmp_screenX_50 == nil then
          __lux_tmp_screenX_50 = 0
        end
        clip.localX = sx - __lux_tmp_screenX_50
      end
      do
        local __lux_tmp_screenY_51 = state.screenY
        if __lux_tmp_screenY_51 == nil then
          __lux_tmp_screenY_51 = 0
        end
        clip.localY = sy - __lux_tmp_screenY_51
      end
      clip.x = sx
      clip.y = sy
      clip.w = ex - sx
      clip.h = ey - sy
      clip.frame = nil
      state.clipStack[#state.clipStack + 1] = clip
      renderSetScissorRect(clip.x, clip.y, clip.x + clip.w, clip.y + clip.h, true)
      return clip
    end
    popClip = function()
      if state.commandStack ~= nil and not state.replaying then
        state.commandStack[#state.commandStack + 1] = { op = "PopClip" }
      end
      if #state.clipStack > 0 then
        local index = #state.clipStack
        local clip = state.clipStack[index]
        state.clipStack[index] = nil
        releaseClipRecord(clip)
      end
      return restoreScissor()
    end
    withClip = function(x, y, w, h, callback)
      pushClip(x, y, w, h)
      local ok, a, b, c, d = pcallFn(callback)
      popClip()
      if not ok then
        errorFn(a, 2)
      end
      return a, b, c, d
    end
    beginPanelEffectBleed = function(left, top, right, bottom)
      if left == nil then
        left = 0
      end
      if top == nil then
        top = 0
      end
      if right == nil then
        right = 0
      end
      if bottom == nil then
        bottom = 0
      end
      do
        local __lux_tmp_left_52 = toNumber(left)
        if __lux_tmp_left_52 == nil then
          __lux_tmp_left_52 = 0
        end
        left = mathMax(0, __lux_tmp_left_52)
      end
      do
        local __lux_tmp_top_53 = toNumber(top)
        if __lux_tmp_top_53 == nil then
          __lux_tmp_top_53 = 0
        end
        top = mathMax(0, __lux_tmp_top_53)
      end
      do
        local __lux_tmp_right_54 = toNumber(right)
        if __lux_tmp_right_54 == nil then
          __lux_tmp_right_54 = 0
        end
        right = mathMax(0, __lux_tmp_right_54)
      end
      do
        local __lux_tmp_bottom_55 = toNumber(bottom)
        if __lux_tmp_bottom_55 == nil then
          __lux_tmp_bottom_55 = 0
        end
        bottom = mathMax(0, __lux_tmp_bottom_55)
      end
      if left <= 0 and top <= 0 and right <= 0 and bottom <= 0 then
        return nil
      end
      local clip = panelClip()
      if clip == nil then
        return nil
      end
      return beginExpandedScissor(
        clip.x - left,
        clip.y - top,
        clip.x + clip.w + right,
        clip.y + clip.h + bottom
      )
    end
    beginPanelEffectDraw = function(drawX, drawY, drawW, drawH)
      if drawW <= 0 or drawH <= 0 then
        return nil
      end
      local currentClip = state.clipStack[#state.clipStack]
      if currentClip == nil then
        return nil
      end
      local drawRight = drawX + drawW
      local drawBottom = drawY + drawH
      local clipRight
      do
        local __lux_tmp_localX_56 = currentClip.localX
        if __lux_tmp_localX_56 == nil then
          __lux_tmp_localX_56 = 0
        end
        local __lux_tmp_w_57 = currentClip.w
        if __lux_tmp_w_57 == nil then
          __lux_tmp_w_57 = 0
        end
        clipRight = __lux_tmp_localX_56 + __lux_tmp_w_57
      end
      local clipBottom
      do
        local __lux_tmp_localY_58 = currentClip.localY
        if __lux_tmp_localY_58 == nil then
          __lux_tmp_localY_58 = 0
        end
        local __lux_tmp_h_59 = currentClip.h
        if __lux_tmp_h_59 == nil then
          __lux_tmp_h_59 = 0
        end
        clipBottom = __lux_tmp_localY_58 + __lux_tmp_h_59
      end
      local __lux_tmp_localX_62 = currentClip.localX
      if __lux_tmp_localX_62 == nil then
        __lux_tmp_localX_62 = 0
      end
      local __lux_tmp_64 = drawX >= __lux_tmp_localX_62
      if __lux_tmp_64 then
        local __lux_tmp_localY_63 = currentClip.localY
        if __lux_tmp_localY_63 == nil then
          __lux_tmp_localY_63 = 0
        end
        __lux_tmp_64 = drawY >= __lux_tmp_localY_63
      end
      local __lux_tmp_65 = __lux_tmp_64
      if __lux_tmp_65 then
        __lux_tmp_65 = drawRight <= clipRight
      end
      local __lux_tmp_66 = __lux_tmp_65
      if __lux_tmp_66 then
        __lux_tmp_66 = drawBottom <= clipBottom
      end
      if __lux_tmp_66 then
        return nil
      end
      local clip = panelClip()
      if clip == nil then
        return nil
      end
      local sx
      do
        local __lux_tmp_screenX_67 = state.screenX
        if __lux_tmp_screenX_67 == nil then
          __lux_tmp_screenX_67 = 0
        end
        sx = __lux_tmp_screenX_67 + drawX
      end
      local sy
      do
        local __lux_tmp_screenY_68 = state.screenY
        if __lux_tmp_screenY_68 == nil then
          __lux_tmp_screenY_68 = 0
        end
        sy = __lux_tmp_screenY_68 + drawY
      end
      return beginExpandedScissor(
        mathMin(clip.x, sx),
        mathMin(clip.y, sy),
        mathMax(clip.x + clip.w, sx + drawW),
        mathMax(clip.y + clip.h, sy + drawH)
      )
    end
    endPanelEffectBleed = function(token)
      if token == nil then
        return
      end
      if token ~= bleedStateTop then
        errorFn("MGFX panel bleed scope mismatch", 2)
      end
      local saved = bleedStateStack[token]
      restoreScissor()
      if disableClipping ~= nil then
        local prevClipping = nil
        if saved ~= nil then
          prevClipping = saved.prevClipping
        end
        disableClipping(prevClipping)
      end
      bleedStateTop = token - 1
    end
    withPanelEffectBleed = function(left, top, right, bottom, callback)
      if left == nil then
        left = 0
      end
      if top == nil then
        top = 0
      end
      if right == nil then
        right = 0
      end
      if bottom == nil then
        bottom = 0
      end
      local token = beginPanelEffectBleed(left, top, right, bottom)
      local ok, a, b, c, d = pcallFn(callback)
      endPanelEffectBleed(token)
      if not ok then
        errorFn(a, 2)
      end
      return a, b, c, d
    end
    beginCommands = function()
      return beginCommandFrame()
    end
    queue = function(command)
      if state.commandStack == nil or state.replaying then
        return false
      end
      state.commandStack[#state.commandStack + 1] = command
      return true
    end
    flushCommands = function(replay)
      local stack = state.commandStack
      if stack == nil then
        return 0
      end
      state.replaying = true
      for index = 1, #stack do
        replay(stack[index])
      end
      state.replaying = false
      local count = #stack
      clearArray(stack)
      state.commandStack = nil
      return count
    end
    debugOverlay = function(x, y)
      if x == nil then
        x = 8
      end
      if y == nil then
        y = 8
      end
      surfaceSetDrawColor(0, 0, 0, 180)
      surfaceDrawRect(x, y, 240, 72)
      drawSimpleText("Lux MGFX frame", "DermaDefault", x + 8, y + 8, color_white)
      drawSimpleText(
        "clip depth: " .. tostring(#state.clipStack),
        "DermaDefault",
        x + 8,
        y + 28,
        color_white
      )
      return drawSimpleText(
        "size: " .. tostring(state.w) .. "x" .. tostring(state.h),
        "DermaDefault",
        x + 8,
        y + 48,
        color_white
      )
    end
    install = function(owner)
      state.owner = owner
      owner.StartPanel = startPanel
      owner.EndPanel = endPanel
      owner.StartScreen = startScreen
      owner.EndScreen = endScreen
      owner.BeginCommands = beginCommands
      owner.FlushCommands = flushCommands
      owner.PushClip = pushClip
      owner.PopClip = popClip
      owner.BeginPanelEffectBleed = beginPanelEffectBleed
      owner.BeginPanelEffectDraw = beginPanelEffectDraw
      owner.EndPanelEffectBleed = endPanelEffectBleed
      owner.WithPanelEffectBleed = withPanelEffectBleed
      owner.DebugOverlay = debugOverlay
      owner._FrameState = state
      return owner
    end
  end

  __lux_exports.current = current
  __lux_exports.restoreScissor = restoreScissor
  __lux_exports.toScreen = toScreen
  __lux_exports.isCulled = isCulled
  __lux_exports.startScreen = startScreen
  __lux_exports.endScreen = endScreen
  __lux_exports.startPanel = startPanel
  __lux_exports.endPanel = endPanel
  __lux_exports.pushClip = pushClip
  __lux_exports.popClip = popClip
  __lux_exports.withClip = withClip
  __lux_exports.beginPanelEffectBleed = beginPanelEffectBleed
  __lux_exports.beginPanelEffectDraw = beginPanelEffectDraw
  __lux_exports.endPanelEffectBleed = endPanelEffectBleed
  __lux_exports.withPanelEffectBleed = withPanelEffectBleed
  __lux_exports.beginCommands = beginCommands
  __lux_exports.queue = queue
  __lux_exports.flushCommands = flushCommands
  __lux_exports.debugOverlay = debugOverlay
  __lux_exports.install = install

  return __lux_exports
end
