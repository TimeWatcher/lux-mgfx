return function(__lux_import)
  local __lux_exports = {}
  local drawSimpleText
  local renderSetScissorRect
  local surfaceSetDrawColor
  local surfaceDrawRect
  local mathCeil
  local mathFloor
  local mathMax
  local state
  local current
  local clearArray
  local restoreScissor
  local toScreen
  local isCulled
  local startScreen
  local endScreen
  local startPanel
  local endPanel
  local pushClip
  local popClip
  local withClip
  local beginCommands
  local queue
  local flushCommands
  local debugOverlay
  local install
  do
    drawSimpleText = _G.draw.SimpleText
    renderSetScissorRect = render.SetScissorRect
    surfaceSetDrawColor = surface.SetDrawColor
    surfaceDrawRect = surface.DrawRect
    mathCeil = math.ceil
    mathFloor = math.floor
    mathMax = math.max
    state = {
      active = false,
      screenX = 0,
      screenY = 0,
      w = 0,
      h = 0,
      clipStack = {},
      commandStack = nil,
      replaying = false,
    }
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
    toScreen = function(x, y)
      local __lux_tmp_x_1 = x
      if __lux_tmp_x_1 == nil then
        __lux_tmp_x_1 = 0
      end
      local __lux_tmp_y_2 = y
      if __lux_tmp_y_2 == nil then
        __lux_tmp_y_2 = 0
      end
      return state.screenX + __lux_tmp_x_1, state.screenY + __lux_tmp_y_2
    end
    isCulled = function(x, y, w, h)
      local sx, sy = toScreen(x, y)
      local ex
      do
        local __lux_tmp_w_3 = w
        if __lux_tmp_w_3 == nil then
          __lux_tmp_w_3 = 0
        end
        ex = sx + __lux_tmp_w_3
      end
      local ey
      do
        local __lux_tmp_h_4 = h
        if __lux_tmp_h_4 == nil then
          __lux_tmp_h_4 = 0
        end
        ey = sy + __lux_tmp_h_4
      end
      if ex <= state.screenX or ey <= state.screenY then
        return true
      end
      if sx >= state.screenX + state.w or sy >= state.screenY + state.h then
        return true
      end
      return false
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
      clearArray(state.clipStack)
      return state
    end
    endScreen = function()
      restoreScissor()
      state.active = false
      state.commandStack = nil
      state.replaying = false
      return state
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
        local __lux_tmp_w_5 = w
        if __lux_tmp_w_5 == nil then
          local __lux_tmp_6
          if panel ~= nil and panel.GetWide ~= nil then
            __lux_tmp_6 = panel:GetWide()
          else
            __lux_tmp_6 = 0
          end
          __lux_tmp_w_5 = __lux_tmp_6
        end
        state.w = __lux_tmp_w_5
      end
      do
        local __lux_tmp_h_7 = h
        if __lux_tmp_h_7 == nil then
          local __lux_tmp_8
          if panel ~= nil and panel.GetTall ~= nil then
            __lux_tmp_8 = panel:GetTall()
          else
            __lux_tmp_8 = 0
          end
          __lux_tmp_h_7 = __lux_tmp_8
        end
        state.h = __lux_tmp_h_7
      end
      clearArray(state.clipStack)
      return state
    end
    endPanel = function()
      return endScreen()
    end
    pushClip = function(x, y, w, h)
      local sx, sy = toScreen(x, y)
      local clip
      do
        local __lux_tmp_w_9 = w
        if __lux_tmp_w_9 == nil then
          __lux_tmp_w_9 = 0
        end
        local __lux_tmp_h_10 = h
        if __lux_tmp_h_10 == nil then
          __lux_tmp_h_10 = 0
        end
        clip = {
          x = mathFloor(sx),
          y = mathFloor(sy),
          w = mathMax(0, mathCeil(__lux_tmp_w_9)),
          h = mathMax(0, mathCeil(__lux_tmp_h_10)),
        }
      end
      state.clipStack[#state.clipStack + 1] = clip
      renderSetScissorRect(clip.x, clip.y, clip.x + clip.w, clip.y + clip.h, true)
      return clip
    end
    popClip = function()
      if #state.clipStack > 0 then
        state.clipStack[#state.clipStack] = nil
      end
      return restoreScissor()
    end
    withClip = function(x, y, w, h, callback)
      pushClip(x, y, w, h)
      local ok, result = pcall(callback)
      popClip()
      if not ok then
        error(result, 2)
      end
      return result
    end
    beginCommands = function()
      state.commandStack = {}
      state.replaying = false
      return state.commandStack
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
      owner.StartPanel = startPanel
      owner.EndPanel = endPanel
      owner.StartScreen = startScreen
      owner.EndScreen = endScreen
      owner.PushClip = pushClip
      owner.PopClip = popClip
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
  __lux_exports.beginCommands = beginCommands
  __lux_exports.queue = queue
  __lux_exports.flushCommands = flushCommands
  __lux_exports.debugOverlay = debugOverlay
  __lux_exports.install = install
  
  return __lux_exports
end
