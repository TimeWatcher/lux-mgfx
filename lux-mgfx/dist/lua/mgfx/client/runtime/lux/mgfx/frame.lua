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
  local profiler
  local profileActive
  local profileCallsite
  local profileStart
  local profileEnd
  local current
  local clearArray
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
    profiler = function()
      local __lux_obj_1 = state.owner
      local __lux_val_2 = nil
      if __lux_obj_1 ~= nil then
        __lux_val_2 = __lux_obj_1.Profiler
      end
      return __lux_val_2
    end
    profileActive = function()
      local api = profiler()
      local __lux_tmp_3 = api ~= nil
      if __lux_tmp_3 then
        __lux_tmp_3 = api.IsEnabled ~= nil
      end
      if __lux_tmp_3 then
        return api.IsEnabled()
      end
      local cvar
      if getConVar ~= nil then
        cvar = getConVar("mgfx_profile")
      else
        cvar = nil
      end
      local __lux_tmp_4 = cvar ~= nil
      if __lux_tmp_4 then
        __lux_tmp_4 = cvar.GetBool ~= nil
      end
      local __lux_tmp_5 = __lux_tmp_4
      if __lux_tmp_5 then
        __lux_tmp_5 = cvar:GetBool()
      end
      local __lux_tmp_6 = __lux_tmp_5
      if not __lux_tmp_6 then
        __lux_tmp_6 = false
      end
      return __lux_tmp_6
    end
    profileCallsite = function()
      local __lux_tmp_7 = not profileActive()
      if not __lux_tmp_7 then
        __lux_tmp_7 = debugLib == nil
      end
      local __lux_tmp_8 = __lux_tmp_7
      if not __lux_tmp_8 then
        __lux_tmp_8 = debugLib.getinfo == nil
      end
      if __lux_tmp_8 then
        return nil
      end
      return debugLib.getinfo(3, "Sln")
    end
    profileStart = function()
      local api = profiler()
      local __lux_tmp_9 = api ~= nil
      if __lux_tmp_9 then
        __lux_tmp_9 = api.Start ~= nil
      end
      if __lux_tmp_9 then
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
      local __lux_tmp_10 = api ~= nil
      if __lux_tmp_10 then
        __lux_tmp_10 = api.Record ~= nil
      end
      if __lux_tmp_10 then
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
    restoreScissor = function()
      local clip = state.clipStack[#state.clipStack]
      if clip ~= nil then
        renderSetScissorRect(clip.x, clip.y, clip.x + clip.w, clip.y + clip.h, true)
      else
        renderSetScissorRect(0, 0, 0, 0, false)
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
        local __lux_tmp_11 = clip ~= nil
        if __lux_tmp_11 then
          __lux_tmp_11 = clip.frame == true
        end
        if __lux_tmp_11 then
          return clip
        end
      end
      return state.clipStack[1]
    end
    toScreen = function(x, y)
      local __lux_tmp_12 = x
      if __lux_tmp_12 == nil then
        __lux_tmp_12 = 0
      end
      local __lux_tmp_13 = y
      if __lux_tmp_13 == nil then
        __lux_tmp_13 = 0
      end
      return state.screenX + __lux_tmp_12, state.screenY + __lux_tmp_13
    end
    isCulled = function(x, y, w, h)
      local __lux_tmp_14 = w
      if __lux_tmp_14 == nil then
        __lux_tmp_14 = 0
      end
      local __lux_tmp_15 = __lux_tmp_14 <= 0
      if not __lux_tmp_15 then
        local __lux_tmp_16 = h
        if __lux_tmp_16 == nil then
          __lux_tmp_16 = 0
        end
        __lux_tmp_15 = __lux_tmp_16 <= 0
      end
      if __lux_tmp_15 then
        return true
      end
      local clip = state.clipStack[#state.clipStack]
      if clip == nil then
        return false
      end
      local __lux_tmp_17 = clip.w
      if __lux_tmp_17 == nil then
        __lux_tmp_17 = 0
      end
      local __lux_tmp_18 = __lux_tmp_17 <= 0
      if not __lux_tmp_18 then
        local __lux_tmp_19 = clip.h
        if __lux_tmp_19 == nil then
          __lux_tmp_19 = 0
        end
        __lux_tmp_18 = __lux_tmp_19 <= 0
      end
      if __lux_tmp_18 then
        return true
      end
      local __lux_tmp_20 = clip.localX
      if __lux_tmp_20 == nil then
        __lux_tmp_20 = 0
      end
      local __lux_tmp_21 = x + w < __lux_tmp_20
      if not __lux_tmp_21 then
        local __lux_tmp_22 = clip.localY
        if __lux_tmp_22 == nil then
          __lux_tmp_22 = 0
        end
        __lux_tmp_21 = y + h < __lux_tmp_22
      end
      local __lux_tmp_23 = __lux_tmp_21
      if not __lux_tmp_23 then
        local __lux_tmp_24 = clip.localX
        if __lux_tmp_24 == nil then
          __lux_tmp_24 = 0
        end
        __lux_tmp_23 = x > __lux_tmp_24 + clip.w
      end
      local __lux_tmp_25 = __lux_tmp_23
      if not __lux_tmp_25 then
        local __lux_tmp_26 = clip.localY
        if __lux_tmp_26 == nil then
          __lux_tmp_26 = 0
        end
        __lux_tmp_25 = y > __lux_tmp_26 + clip.h
      end
      if __lux_tmp_25 then
        return true
      end
      return false
    end
    installFrameClip = function()
      clearArray(state.clipStack)
      if not state.clipToFrame then
        renderSetScissorRect(0, 0, 0, 0, false)
        return
      end
      local fw
      do
        local __lux_tmp_27 = state.w
        if __lux_tmp_27 == nil then
          __lux_tmp_27 = 0
        end
        fw = __lux_tmp_27
      end
      local fh
      do
        local __lux_tmp_28 = state.h
        if __lux_tmp_28 == nil then
          __lux_tmp_28 = 0
        end
        fh = __lux_tmp_28
      end
      local __lux_tmp_29 = fw <= 0
      if not __lux_tmp_29 then
        __lux_tmp_29 = fh <= 0
      end
      if __lux_tmp_29 then
        return
      end
      local sx
      do
        local __lux_tmp_30 = state.screenX
        if __lux_tmp_30 == nil then
          __lux_tmp_30 = 0
        end
        sx = __lux_tmp_30
      end
      local sy
      do
        local __lux_tmp_31 = state.screenY
        if __lux_tmp_31 == nil then
          __lux_tmp_31 = 0
        end
        sy = __lux_tmp_31
      end
      state.clipStack[#state.clipStack + 1] = { localX = 0, localY = 0, x = sx, y = sy, w = fw, h = fh, frame = true }
      return renderSetScissorRect(sx, sy, sx + fw, sy + fh, true)
    end
    beginCommandFrame = function()
      state.commandStack = {}
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
        local __lux_obj_32 = state.owner
        local __lux_val_33 = nil
        if __lux_obj_32 ~= nil then
          __lux_val_33 = __lux_obj_32._TextRenderer
        end
        renderer = __lux_val_33
      end
      local __lux_tmp_34 = renderer == nil
      if not __lux_tmp_34 then
        __lux_tmp_34 = renderer.Flush == nil
      end
      if __lux_tmp_34 then
        errorFn("MGFX text renderer unavailable during frame text flush", 2)
      end
      renderer.Flush(textBatch, reason)
      profileEnd("textFlush", started)
      return clearArray(textBatch)
    end
    appendTextCommand = function(command, textBatch)
      local renderer
      do
        local __lux_obj_35 = state.owner
        local __lux_val_36 = nil
        if __lux_obj_35 ~= nil then
          __lux_val_36 = __lux_obj_35._TextRenderer
        end
        renderer = __lux_val_36
      end
      if command.record ~= nil then
        textBatch[#textBatch + 1] = command.record
      else
        local __lux_tmp_37 = renderer ~= nil
        if __lux_tmp_37 then
          __lux_tmp_37 = renderer.MakeRecord ~= nil
        end
        if __lux_tmp_37 then
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
        local __lux_obj_38 = state.owner
        local __lux_val_39 = nil
        if __lux_obj_38 ~= nil then
          __lux_val_39 = __lux_obj_38.stats
        end
        ownerStats = __lux_val_39
      end
      local __lux_tmp_40 = ownerStats ~= nil
      if __lux_tmp_40 then
        __lux_tmp_40 = state.drawCountsActive
      end
      if __lux_tmp_40 then
        do
          local __lux_tmp_41 = ownerStats.drawImmediateCounts
          if __lux_tmp_41 == nil then
            __lux_tmp_41 = {}
          end
          ownerStats.drawImmediateCounts = __lux_tmp_41
        end
        do
          local __lux_tmp_42 = ownerStats.drawImmediateCounts.textBox
          if __lux_tmp_42 == nil then
            __lux_tmp_42 = 0
          end
          ownerStats.drawImmediateCounts.textBox = __lux_tmp_42 + 1
        end
      end
      local renderer
      do
        local __lux_obj_43 = state.owner
        local __lux_val_44 = nil
        if __lux_obj_43 ~= nil then
          __lux_val_44 = __lux_obj_43._TextRenderer
        end
        renderer = __lux_val_44
      end
      local __lux_tmp_45 = renderer == nil
      if not __lux_tmp_45 then
        __lux_tmp_45 = renderer.DrawTextBoxImmediate == nil
      end
      if __lux_tmp_45 then
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
      local __lux_obj_46 = command
      local __lux_val_47 = nil
      if __lux_obj_46 ~= nil then
        __lux_val_47 = __lux_obj_46.op
      end
      local __lux_tmp_48 = __lux_val_47
      if __lux_tmp_48 == nil then
        local __lux_obj_49 = command
        local __lux_val_51 = nil
        if __lux_obj_49 ~= nil then
          local __lux_key_50 = 1
          __lux_val_51 = __lux_obj_49[__lux_key_50]
        end
        __lux_tmp_48 = __lux_val_51
      end
      return __lux_tmp_48
    end
    flushQueuedCommands = function()
      local stack = state.commandStack
      if stack == nil then
        return 0
      end
      state.commandStack = nil
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
          local __lux_obj_52 = state.owner
          local __lux_val_53 = nil
          if __lux_obj_52 ~= nil then
            __lux_val_53 = __lux_obj_52.stats
          end
          ownerStats = __lux_val_53
        end
        local __lux_tmp_54 = ownerStats ~= nil
        if __lux_tmp_54 then
          __lux_tmp_54 = state.drawCountsActive
        end
        if __lux_tmp_54 then
          do
            local __lux_tmp_55 = ownerStats.drawCommandCounts
            if __lux_tmp_55 == nil then
              __lux_tmp_55 = {}
            end
            ownerStats.drawCommandCounts = __lux_tmp_55
          end
          local statKey
          do
            local __lux_tmp_56 = name
            if __lux_tmp_56 == nil then
              __lux_tmp_56 = "unknown"
            end
            statKey = __lux_tmp_56
          end
          do
            local __lux_tmp_57 = ownerStats.drawCommandCounts[statKey]
            if __lux_tmp_57 == nil then
              __lux_tmp_57 = 0
            end
            ownerStats.drawCommandCounts[statKey] = __lux_tmp_57 + 1
          end
        end
        local __lux_match_58 = commandName(command)
        if __lux_match_58 == "DrawText" then
          appendTextCommand(command, textBatch)
        elseif __lux_match_58 == "DrawTextBatch" then
          appendTextBatchCommand(command, textBatch)
        elseif __lux_match_58 == "DrawTextBox" then
          flushTextBatch(textBatch, "text")
          drawTextBoxCommand(command)
        elseif __lux_match_58 == "PushClip" then
          flushTextBatch(textBatch, "clip")
          pushClip(command.x, command.y, command.w, command.h)
        elseif __lux_match_58 == "PopClip" then
          flushTextBatch(textBatch, "clip")
          popClip()
        else
        end
        do
          local __lux_tmp_59 = name
          if __lux_tmp_59 == nil then
            __lux_tmp_59 = "unknown"
          end
          profileEnd("cmd." .. toString(__lux_tmp_59), commandProfile)
        end
      end
      profileEnd("commandLoop", loopProfile)
      flushTextBatch(textBatch, "end")
      local count = #stack
      clearArray(stack)
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
      local __lux_tmp_60 = api ~= nil
      if __lux_tmp_60 then
        __lux_tmp_60 = api.EndFrame ~= nil
      end
      if __lux_tmp_60 then
        api.EndFrame()
      end
      clearArray(state.clipStack)
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
    beginFrameProfile = function(kind, subject, info)
      local api = profiler()
      local active = false
      local __lux_tmp_61 = api ~= nil
      if __lux_tmp_61 then
        __lux_tmp_61 = api.BeginFrame ~= nil
      end
      if __lux_tmp_61 then
        active = api.BeginFrame(kind, subject, info)
      end
      do
        local __lux_tmp_62
        local cvar
        if getConVar ~= nil then
          cvar = getConVar("mgfx_draw_counts")
        else
          cvar = nil
        end
        do
          local __lux_tmp_63 = cvar ~= nil
          if __lux_tmp_63 then
            __lux_tmp_63 = cvar.GetBool ~= nil
          end
          local __lux_tmp_64 = __lux_tmp_63
          if __lux_tmp_64 then
            __lux_tmp_64 = cvar:GetBool()
          end
          local __lux_tmp_65 = __lux_tmp_64
          if not __lux_tmp_65 then
            __lux_tmp_65 = false
          end
          __lux_tmp_62 = __lux_tmp_65
        end
        state.drawCountsActive = __lux_tmp_62
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
      beginFrameProfile("screen", nil, { callsite = profileCallsite(), label = "screen" })
      installFrameClip()
      return state
    end
    endScreen = function()
      local frameProfile = profileStart()
      local __lux_tmp_66 = frameProfile ~= nil
      if __lux_tmp_66 then
        __lux_tmp_66 = state.profilePaintStarted ~= nil
      end
      if __lux_tmp_66 then
        local api = profiler()
        local __lux_tmp_67 = api ~= nil
        if __lux_tmp_67 then
          __lux_tmp_67 = api.Record ~= nil
        end
        if __lux_tmp_67 then
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
      local __lux_tmp_68 = panel ~= nil
      if __lux_tmp_68 then
        __lux_tmp_68 = panel.LocalToScreen ~= nil
      end
      if __lux_tmp_68 then
        x, y = panel:LocalToScreen(0, 0)
      end
      state.active = true
      state.screenX = x
      state.screenY = y
      do
        local __lux_tmp_69 = w
        if __lux_tmp_69 == nil then
          local __lux_tmp_70
          do
            local __lux_tmp_71 = panel ~= nil
            if __lux_tmp_71 then
              __lux_tmp_71 = panel.GetWide ~= nil
            end
            if __lux_tmp_71 then
              __lux_tmp_70 = panel:GetWide()
            else
              __lux_tmp_70 = 0
            end
          end
          __lux_tmp_69 = __lux_tmp_70
        end
        state.w = __lux_tmp_69
      end
      do
        local __lux_tmp_72 = h
        if __lux_tmp_72 == nil then
          local __lux_tmp_73
          do
            local __lux_tmp_74 = panel ~= nil
            if __lux_tmp_74 then
              __lux_tmp_74 = panel.GetTall ~= nil
            end
            if __lux_tmp_74 then
              __lux_tmp_73 = panel:GetTall()
            else
              __lux_tmp_73 = 0
            end
          end
          __lux_tmp_72 = __lux_tmp_73
        end
        state.h = __lux_tmp_72
      end
      state.clipToFrame = true
      state.commandStack = nil
      state.replaying = false
      beginFrameProfile("panel", panel, { callsite = profileCallsite() })
      installFrameClip()
      return state
    end
    endPanel = function()
      return endScreen()
    end
    pushClip = function(x, y, w, h)
      do
        local __lux_tmp_75 = x
        if __lux_tmp_75 == nil then
          __lux_tmp_75 = 0
        end
        x = __lux_tmp_75
      end
      do
        local __lux_tmp_76 = y
        if __lux_tmp_76 == nil then
          __lux_tmp_76 = 0
        end
        y = __lux_tmp_76
      end
      do
        local __lux_tmp_77 = w
        if __lux_tmp_77 == nil then
          __lux_tmp_77 = 0
        end
        w = __lux_tmp_77
      end
      do
        local __lux_tmp_78 = h
        if __lux_tmp_78 == nil then
          __lux_tmp_78 = 0
        end
        h = __lux_tmp_78
      end
      local __lux_tmp_79 = state.commandStack ~= nil
      if __lux_tmp_79 then
        __lux_tmp_79 = not state.replaying
      end
      if __lux_tmp_79 then
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
      local __lux_tmp_80 = ex <= sx
      if not __lux_tmp_80 then
        __lux_tmp_80 = ey <= sy
      end
      if __lux_tmp_80 then
        local clip = { localX = x, localY = y, x = sx, y = sy, w = 0, h = 0 }
        state.clipStack[#state.clipStack + 1] = clip
        renderSetScissorRect(0, 0, 0, 0, true)
        return clip
      end
      local clip
      do
        local __lux_tmp_81 = state.screenX
        if __lux_tmp_81 == nil then
          __lux_tmp_81 = 0
        end
        local __lux_tmp_82 = state.screenY
        if __lux_tmp_82 == nil then
          __lux_tmp_82 = 0
        end
        clip = {
          localX = sx - __lux_tmp_81,
          localY = sy - __lux_tmp_82,
          x = sx,
          y = sy,
          w = ex - sx,
          h = ey - sy,
        }
      end
      state.clipStack[#state.clipStack + 1] = clip
      renderSetScissorRect(clip.x, clip.y, clip.x + clip.w, clip.y + clip.h, true)
      return clip
    end
    popClip = function()
      local __lux_tmp_83 = state.commandStack ~= nil
      if __lux_tmp_83 then
        __lux_tmp_83 = not state.replaying
      end
      if __lux_tmp_83 then
        state.commandStack[#state.commandStack + 1] = { op = "PopClip" }
      end
      if #state.clipStack > 0 then
        state.clipStack[#state.clipStack] = nil
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
        local __lux_tmp_84 = toNumber(left)
        if __lux_tmp_84 == nil then
          __lux_tmp_84 = 0
        end
        left = mathMax(0, __lux_tmp_84)
      end
      do
        local __lux_tmp_85 = toNumber(top)
        if __lux_tmp_85 == nil then
          __lux_tmp_85 = 0
        end
        top = mathMax(0, __lux_tmp_85)
      end
      do
        local __lux_tmp_86 = toNumber(right)
        if __lux_tmp_86 == nil then
          __lux_tmp_86 = 0
        end
        right = mathMax(0, __lux_tmp_86)
      end
      do
        local __lux_tmp_87 = toNumber(bottom)
        if __lux_tmp_87 == nil then
          __lux_tmp_87 = 0
        end
        bottom = mathMax(0, __lux_tmp_87)
      end
      local __lux_tmp_88 = left <= 0
      if __lux_tmp_88 then
        __lux_tmp_88 = top <= 0
      end
      local __lux_tmp_89 = __lux_tmp_88
      if __lux_tmp_89 then
        __lux_tmp_89 = right <= 0
      end
      local __lux_tmp_90 = __lux_tmp_89
      if __lux_tmp_90 then
        __lux_tmp_90 = bottom <= 0
      end
      if __lux_tmp_90 then
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
      local __lux_tmp_91 = drawW <= 0
      if not __lux_tmp_91 then
        __lux_tmp_91 = drawH <= 0
      end
      if __lux_tmp_91 then
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
        local __lux_tmp_92 = currentClip.localX
        if __lux_tmp_92 == nil then
          __lux_tmp_92 = 0
        end
        local __lux_tmp_93 = currentClip.w
        if __lux_tmp_93 == nil then
          __lux_tmp_93 = 0
        end
        clipRight = __lux_tmp_92 + __lux_tmp_93
      end
      local clipBottom
      do
        local __lux_tmp_94 = currentClip.localY
        if __lux_tmp_94 == nil then
          __lux_tmp_94 = 0
        end
        local __lux_tmp_95 = currentClip.h
        if __lux_tmp_95 == nil then
          __lux_tmp_95 = 0
        end
        clipBottom = __lux_tmp_94 + __lux_tmp_95
      end
      local __lux_tmp_96 = currentClip.localX
      if __lux_tmp_96 == nil then
        __lux_tmp_96 = 0
      end
      local __lux_tmp_97 = drawX >= __lux_tmp_96
      if __lux_tmp_97 then
        local __lux_tmp_98 = currentClip.localY
        if __lux_tmp_98 == nil then
          __lux_tmp_98 = 0
        end
        __lux_tmp_97 = drawY >= __lux_tmp_98
      end
      local __lux_tmp_99 = __lux_tmp_97
      if __lux_tmp_99 then
        __lux_tmp_99 = drawRight <= clipRight
      end
      local __lux_tmp_100 = __lux_tmp_99
      if __lux_tmp_100 then
        __lux_tmp_100 = drawBottom <= clipBottom
      end
      if __lux_tmp_100 then
        return nil
      end
      local clip = panelClip()
      if clip == nil then
        return nil
      end
      local sx
      do
        local __lux_tmp_101 = state.screenX
        if __lux_tmp_101 == nil then
          __lux_tmp_101 = 0
        end
        sx = __lux_tmp_101 + drawX
      end
      local sy
      do
        local __lux_tmp_102 = state.screenY
        if __lux_tmp_102 == nil then
          __lux_tmp_102 = 0
        end
        sy = __lux_tmp_102 + drawY
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
      local __lux_tmp_103 = state.commandStack == nil
      if not __lux_tmp_103 then
        __lux_tmp_103 = state.replaying
      end
      if __lux_tmp_103 then
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
