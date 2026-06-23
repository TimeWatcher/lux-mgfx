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
  local state
  local current
  local clearArray
  local restoreScissor
  local panelClip
  local toScreen
  local isCulled
  local installFrameClip
  local startScreen
  local endScreen
  local startPanel
  local endPanel
  local pushClip
  local popClip
  local withClip
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
    state = {
      active = false,
      screenX = 0,
      screenY = 0,
      w = 0,
      h = 0,
      clipToFrame = false,
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
        return renderSetScissorRect(clip.x, clip.y, clip.x + clip.w, clip.y + clip.h, true)
      else
        return renderSetScissorRect(0, 0, 0, 0, false)
      end
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
      local __lux_tmp_w_5 = w
      if __lux_tmp_w_5 == nil then
        __lux_tmp_w_5 = 0
      end
      local __lux_tmp_7 = __lux_tmp_w_5 <= 0
      if not __lux_tmp_7 then
        local __lux_tmp_h_6 = h
        if __lux_tmp_h_6 == nil then
          __lux_tmp_h_6 = 0
        end
        __lux_tmp_7 = __lux_tmp_h_6 <= 0
      end
      if __lux_tmp_7 then
        return true
      end
      local clip = state.clipStack[#state.clipStack]
      if clip == nil then
        return false
      end
      local __lux_tmp_w_10 = clip.w
      if __lux_tmp_w_10 == nil then
        __lux_tmp_w_10 = 0
      end
      local __lux_tmp_12 = __lux_tmp_w_10 <= 0
      if not __lux_tmp_12 then
        local __lux_tmp_h_11 = clip.h
        if __lux_tmp_h_11 == nil then
          __lux_tmp_h_11 = 0
        end
        __lux_tmp_12 = __lux_tmp_h_11 <= 0
      end
      if __lux_tmp_12 then
        return true
      end
      local __lux_tmp_localX_15 = clip.localX
      if __lux_tmp_localX_15 == nil then
        __lux_tmp_localX_15 = 0
      end
      local __lux_tmp_17 = x + w < __lux_tmp_localX_15
      if not __lux_tmp_17 then
        local __lux_tmp_localY_16 = clip.localY
        if __lux_tmp_localY_16 == nil then
          __lux_tmp_localY_16 = 0
        end
        __lux_tmp_17 = y + h < __lux_tmp_localY_16
      end
      local __lux_tmp_19 = __lux_tmp_17
      if not __lux_tmp_19 then
        local __lux_tmp_localX_18 = clip.localX
        if __lux_tmp_localX_18 == nil then
          __lux_tmp_localX_18 = 0
        end
        __lux_tmp_19 = x > __lux_tmp_localX_18 + clip.w
      end
      local __lux_tmp_21 = __lux_tmp_19
      if not __lux_tmp_21 then
        local __lux_tmp_localY_20 = clip.localY
        if __lux_tmp_localY_20 == nil then
          __lux_tmp_localY_20 = 0
        end
        __lux_tmp_21 = y > __lux_tmp_localY_20 + clip.h
      end
      if __lux_tmp_21 then
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
      state.clipStack[#state.clipStack + 1] = { localX = 0, localY = 0, x = sx, y = sy, w = fw, h = fh, frame = true }
      return renderSetScissorRect(sx, sy, sx + fw, sy + fh, true)
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
      installFrameClip()
      return state
    end
    endScreen = function()
      clearArray(state.clipStack)
      renderSetScissorRect(0, 0, 0, 0, false)
      state.active = false
      state.w = 0
      state.h = 0
      state.screenX = 0
      state.screenY = 0
      state.clipToFrame = false
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
        local __lux_tmp_w_22 = w
        if __lux_tmp_w_22 == nil then
          local __lux_tmp_23
          if panel ~= nil and panel.GetWide ~= nil then
            __lux_tmp_23 = panel:GetWide()
          else
            __lux_tmp_23 = 0
          end
          __lux_tmp_w_22 = __lux_tmp_23
        end
        state.w = __lux_tmp_w_22
      end
      do
        local __lux_tmp_h_24 = h
        if __lux_tmp_h_24 == nil then
          local __lux_tmp_25
          if panel ~= nil and panel.GetTall ~= nil then
            __lux_tmp_25 = panel:GetTall()
          else
            __lux_tmp_25 = 0
          end
          __lux_tmp_h_24 = __lux_tmp_25
        end
        state.h = __lux_tmp_h_24
      end
      state.clipToFrame = true
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
        local clip = { localX = x, localY = y, x = sx, y = sy, w = 0, h = 0 }
        state.clipStack[#state.clipStack + 1] = clip
        renderSetScissorRect(0, 0, 0, 0, true)
        return clip
      end
      local clip
      do
        local __lux_tmp_screenX_26 = state.screenX
        if __lux_tmp_screenX_26 == nil then
          __lux_tmp_screenX_26 = 0
        end
        local __lux_tmp_screenY_27 = state.screenY
        if __lux_tmp_screenY_27 == nil then
          __lux_tmp_screenY_27 = 0
        end
        clip = {
          localX = sx - __lux_tmp_screenX_26,
          localY = sy - __lux_tmp_screenY_27,
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
      do
        local __lux_tmp_left_28 = left
        if __lux_tmp_left_28 == nil then
          __lux_tmp_left_28 = 0
        end
        left = mathMax(0, __lux_tmp_left_28)
      end
      do
        local __lux_tmp_top_29 = top
        if __lux_tmp_top_29 == nil then
          __lux_tmp_top_29 = 0
        end
        top = mathMax(0, __lux_tmp_top_29)
      end
      do
        local __lux_tmp_right_30 = right
        if __lux_tmp_right_30 == nil then
          __lux_tmp_right_30 = 0
        end
        right = mathMax(0, __lux_tmp_right_30)
      end
      do
        local __lux_tmp_bottom_31 = bottom
        if __lux_tmp_bottom_31 == nil then
          __lux_tmp_bottom_31 = 0
        end
        bottom = mathMax(0, __lux_tmp_bottom_31)
      end
      if left <= 0 and top <= 0 and right <= 0 and bottom <= 0 then
        return callback()
      end
      local clip = panelClip()
      if clip == nil then
        return callback()
      end
      local prevClipping = nil
      if disableClipping ~= nil then
        prevClipping = disableClipping(true)
      end
      renderSetScissorRect(
        mathFloor(clip.x - left),
        mathFloor(clip.y - top),
        mathCeil(clip.x + clip.w + right),
        mathCeil(clip.y + clip.h + bottom),
        true
      )
      local ok, a, b, c, d = pcallFn(callback)
      restoreScissor()
      if disableClipping ~= nil then
        disableClipping(prevClipping)
      end
      if not ok then
        errorFn(a, 2)
      end
      return a, b, c, d
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
  __lux_exports.withPanelEffectBleed = withPanelEffectBleed
  __lux_exports.beginCommands = beginCommands
  __lux_exports.queue = queue
  __lux_exports.flushCommands = flushCommands
  __lux_exports.debugOverlay = debugOverlay
  __lux_exports.install = install
  
  return __lux_exports
end
