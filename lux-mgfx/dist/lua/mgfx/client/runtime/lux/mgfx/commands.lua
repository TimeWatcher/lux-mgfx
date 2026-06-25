return function(__lux_import)
  local __lux_exports = {}
  local toNumber
  local typeOf
  local field
  local name
  local alreadyRecord
  local makeRoundedBox
  local makePoly
  local makeImage
  local makeLine
  local makeClip
  local makeProgress
  local makeRing
  local makeArc
  local makeSector
  local makeText
  local makeTextBox
  local roundedBox
  local roundedBoxValues
  local chamferBox
  local poly
  local polyValues
  local image
  local imageValues
  local line
  local lineValues
  local clip
  local clipValues
  local progressBar
  local progressBarValues
  local segmentBar
  local ring
  local ringValues
  local arc
  local arcValues
  local sector
  local sectorValues
  local text
  local textValues
  local textBox
  local textBoxValues
  local bounds
  local normalize
  local normalizeAll
  local values
  local install
  do
    toNumber = tonumber
    typeOf = type
    field = function(command, name, index)
      if command[name] ~= nil then
        return command[name]
      end
      return command[index]
    end
    name = function(command)
      local __lux_tmp_1 = command.op
      if __lux_tmp_1 == nil then
        __lux_tmp_1 = command[1]
      end
      return __lux_tmp_1
    end
    alreadyRecord = function(command)
      local __lux_tmp_2 = typeOf(command) == "table"
      if __lux_tmp_2 then
        __lux_tmp_2 = command.op ~= nil
      end
      return __lux_tmp_2
    end
  end
  do
    makeRoundedBox = function(op, x, y, w, h, style)
      return { op = op, x = x, y = y, w = w, h = h, style = style }
    end
    makePoly = function(op, points, style)
      return { op = op, points = points, style = style }
    end
    makeImage = function(op, x, y, w, h, source, style)
      return { op = op, x = x, y = y, w = w, h = h, source = source, style = style }
    end
    makeLine = function(op, x1, y1, x2, y2, style)
      return { op = op, x1 = x1, y1 = y1, x2 = x2, y2 = y2, style = style }
    end
    makeClip = function(op, x, y, w, h)
      return { op = op, x = x, y = y, w = w, h = h }
    end
    makeProgress = function(op, x, y, w, h, value, style)
      return { op = op, x = x, y = y, w = w, h = h, value = value, style = style }
    end
    makeRing = function(op, x, y, radius, width, drawStyle)
      return { op = op, x = x, y = y, radius = radius, width = width, style = drawStyle }
    end
    makeArc = function(op, x, y, radius, width, startDeg, endDeg, drawStyle)
      return {
        op = op,
        x = x,
        y = y,
        radius = radius,
        width = width,
        startDeg = startDeg,
        endDeg = endDeg,
        style = drawStyle,
      }
    end
    makeSector = function(op, x, y, innerRadius, outerRadius, startDeg, endDeg, drawStyle)
      return {
        op = op,
        x = x,
        y = y,
        innerRadius = innerRadius,
        outerRadius = outerRadius,
        startDeg = startDeg,
        endDeg = endDeg,
        style = drawStyle,
      }
    end
    makeText = function(op, text, font, x, y, color, ax, ay, drawStyle)
      return {
        op = op,
        text = text,
        font = font,
        x = x,
        y = y,
        color = color,
        ax = ax,
        ay = ay,
        style = drawStyle,
      }
    end
    makeTextBox = function(op, text, font, x, y, w, h, drawStyle)
      return { op = op, text = text, font = font, x = x, y = y, w = w, h = h, style = drawStyle }
    end
  end
  do
    roundedBox = function(command)
      if alreadyRecord(command) then
        return command
      end
      return makeRoundedBox(command[1], command[2], command[3], command[4], command[5], command[6])
    end
    roundedBoxValues = function(command)
      return field(command, "x", 2), field(command, "y", 3), field(command, "w", 4), field(command, "h", 5), field(command, "style", 6)
    end
    chamferBox = function(command)
      return roundedBox(command)
    end
    poly = function(command)
      if alreadyRecord(command) then
        return command
      end
      return makePoly(command[1], command[2], command[3])
    end
    polyValues = function(command)
      return field(command, "points", 2), field(command, "style", 3)
    end
    image = function(command)
      if alreadyRecord(command) then
        return command
      end
      return makeImage(
        command[1],
        command[2],
        command[3],
        command[4],
        command[5],
        command[6],
        command[7]
      )
    end
    imageValues = function(command)
      return field(command, "x", 2), field(command, "y", 3), field(command, "w", 4), field(command, "h", 5), field(command, "source", 6), field(command, "style", 7)
    end
    line = function(command)
      if alreadyRecord(command) then
        return command
      end
      return makeLine(command[1], command[2], command[3], command[4], command[5], command[6])
    end
    lineValues = function(command)
      return field(command, "x1", 2), field(command, "y1", 3), field(command, "x2", 4), field(command, "y2", 5), field(command, "style", 6)
    end
    clip = function(command)
      if alreadyRecord(command) then
        return command
      end
      return makeClip(command[1], command[2], command[3], command[4], command[5])
    end
    clipValues = function(command)
      return field(command, "x", 2), field(command, "y", 3), field(command, "w", 4), field(command, "h", 5)
    end
  end
  do
    progressBar = function(command)
      if alreadyRecord(command) then
        return command
      end
      return makeProgress(
        command[1],
        command[2],
        command[3],
        command[4],
        command[5],
        command[6],
        command[7]
      )
    end
    progressBarValues = function(command)
      return field(command, "x", 2), field(command, "y", 3), field(command, "w", 4), field(command, "h", 5), field(command, "value", 6), field(command, "style", 7)
    end
    segmentBar = function(command)
      return progressBar(command)
    end
    ring = function(command)
      if alreadyRecord(command) then
        return command
      end
      return makeRing(command[1], command[2], command[3], command[4], command[5], command[6])
    end
    ringValues = function(command)
      return field(command, "cx", 2), field(command, "cy", 3), field(command, "radius", 4), field(command, "width", 5), field(command, "style", 6)
    end
    arc = function(command)
      if alreadyRecord(command) then
        return command
      end
      return makeArc(
        command[1],
        command[2],
        command[3],
        command[4],
        command[5],
        command[6],
        command[7],
        command[8]
      )
    end
    arcValues = function(command)
      return field(command, "cx", 2), field(command, "cy", 3), field(command, "radius", 4), field(command, "width", 5), field(command, "startDeg", 6), field(command, "endDeg", 7), field(command, "style", 8)
    end
    sector = function(command)
      if alreadyRecord(command) then
        return command
      end
      return makeSector(
        command[1],
        command[2],
        command[3],
        command[4],
        command[5],
        command[6],
        command[7],
        command[8]
      )
    end
    sectorValues = function(command)
      return field(command, "cx", 2), field(command, "cy", 3), field(command, "innerRadius", 4), field(command, "outerRadius", 5), field(command, "startDeg", 6), field(command, "endDeg", 7), field(command, "style", 8)
    end
  end
  do
    text = function(command)
      if alreadyRecord(command) then
        return command
      end
      return makeText(
        command[1],
        command[2],
        command[3],
        command[4],
        command[5],
        command[6],
        command[7],
        command[8],
        command[9]
      )
    end
    textValues = function(command)
      return field(command, "text", 2), field(command, "font", 3), field(command, "x", 4), field(command, "y", 5), field(command, "color", 6), field(command, "ax", 7), field(command, "ay", 8), field(command, "style", 9)
    end
    textBox = function(command)
      if alreadyRecord(command) then
        return command
      end
      return makeTextBox(
        command[1],
        command[2],
        command[3],
        command[4],
        command[5],
        command[6],
        command[7],
        command[8]
      )
    end
    textBoxValues = function(command)
      return field(command, "text", 2), field(command, "font", 3), field(command, "x", 4), field(command, "y", 5), field(command, "w", 6), field(command, "h", 7), field(command, "style", 8)
    end
  end
  do
    bounds = function(command)
      local op = name(command)
      local __lux_match_3 = op
      if __lux_match_3 == "DrawText" then
        local c = text(command)
        return c.x, c.y, 0, 0
      elseif __lux_match_3 == "DrawTextBox" or __lux_match_3 == "PushClip" then
        local c
        local __lux_match_4 = op
        if __lux_match_4 == "DrawTextBox" then
          c = textBox(command)
        else
          c = clip(command)
        end
        return c.x, c.y, c.w, c.h
      elseif __lux_match_3 == "DrawRing" or __lux_match_3 == "DrawArc" then
        local c
        local __lux_match_5 = op
        if __lux_match_5 == "DrawRing" then
          c = ring(command)
        else
          c = arc(command)
        end
        local r
        do
          local __lux_tmp_6 = toNumber(c.radius)
          if __lux_tmp_6 == nil then
            __lux_tmp_6 = 0
          end
          r = __lux_tmp_6
        end
        return c.x - r, c.y - r, r * 2, r * 2
      elseif __lux_match_3 == "DrawSector" then
        local c = sector(command)
        local r
        do
          local __lux_tmp_7 = toNumber(c.outerRadius)
          if __lux_tmp_7 == nil then
            __lux_tmp_7 = 0
          end
          r = __lux_tmp_7
        end
        return c.x - r, c.y - r, r * 2, r * 2
      elseif __lux_match_3 == "DrawPoly" then
        return 0, 0, 0, 0
      else
        local c = normalize(command)
        local __lux_tmp_8 = c.x
        if __lux_tmp_8 == nil then
          __lux_tmp_8 = 0
        end
        local __lux_tmp_9 = c.y
        if __lux_tmp_9 == nil then
          __lux_tmp_9 = 0
        end
        local __lux_tmp_10 = c.w
        if __lux_tmp_10 == nil then
          __lux_tmp_10 = 0
        end
        local __lux_tmp_11 = c.h
        if __lux_tmp_11 == nil then
          __lux_tmp_11 = 0
        end
        return __lux_tmp_8, __lux_tmp_9, __lux_tmp_10, __lux_tmp_11
      end
    end
    normalize = function(command)
      local __lux_match_12 = name(command)
      if __lux_match_12 == "DrawRoundedBox" then
        return roundedBox(command)
      elseif __lux_match_12 == "DrawChamferBox" then
        return chamferBox(command)
      elseif __lux_match_12 == "DrawPoly" then
        return poly(command)
      elseif __lux_match_12 == "DrawImage" then
        return image(command)
      elseif __lux_match_12 == "DrawLine" then
        return line(command)
      elseif __lux_match_12 == "PushClip" or __lux_match_12 == "PopClip" then
        return clip(command)
      elseif __lux_match_12 == "DrawProgressBar" then
        return progressBar(command)
      elseif __lux_match_12 == "DrawSegmentBar" then
        return segmentBar(command)
      elseif __lux_match_12 == "DrawRing" then
        return ring(command)
      elseif __lux_match_12 == "DrawArc" then
        return arc(command)
      elseif __lux_match_12 == "DrawSector" then
        return sector(command)
      elseif __lux_match_12 == "DrawText" then
        return text(command)
      elseif __lux_match_12 == "DrawTextBox" then
        return textBox(command)
      else
        return command
      end
    end
    normalizeAll = function(commands)
      local out = {}
      do
        local __lux_tmp_13 = commands
        if __lux_tmp_13 == nil then
          __lux_tmp_13 = {}
        end
        for index = 1, #__lux_tmp_13 do
          out[index] = normalize(commands[index])
        end
      end
      return out
    end
    values = function(command)
      local __lux_match_14 = name(command)
      if __lux_match_14 == "DrawRoundedBox" or __lux_match_14 == "DrawChamferBox" then
        return roundedBoxValues(command)
      elseif __lux_match_14 == "DrawPoly" then
        return polyValues(command)
      elseif __lux_match_14 == "DrawImage" then
        return imageValues(command)
      elseif __lux_match_14 == "DrawLine" then
        return lineValues(command)
      elseif __lux_match_14 == "PushClip" or __lux_match_14 == "PopClip" then
        return clipValues(command)
      elseif __lux_match_14 == "DrawProgressBar" or __lux_match_14 == "DrawSegmentBar" then
        return progressBarValues(command)
      elseif __lux_match_14 == "DrawRing" then
        return ringValues(command)
      elseif __lux_match_14 == "DrawArc" then
        return arcValues(command)
      elseif __lux_match_14 == "DrawSector" then
        return sectorValues(command)
      elseif __lux_match_14 == "DrawText" then
        return textValues(command)
      elseif __lux_match_14 == "DrawTextBox" then
        return textBoxValues(command)
      else
        return nil
      end
    end
  end
  do
    install = function(owner)
      owner._CreateCommandApi = function()
        return {
          name = name,
          normalize = normalize,
          normalizeAll = normalizeAll,
          values = values,
          roundedBox = roundedBox,
          roundedBoxValues = roundedBoxValues,
          chamferBox = chamferBox,
          poly = poly,
          polyValues = polyValues,
          image = image,
          imageValues = imageValues,
          line = line,
          lineValues = lineValues,
          clip = clip,
          clipValues = clipValues,
          progressBar = progressBar,
          progressBarValues = progressBarValues,
          segmentBar = segmentBar,
          ring = ring,
          ringValues = ringValues,
          arc = arc,
          arcValues = arcValues,
          sector = sector,
          sectorValues = sectorValues,
          text = text,
          textValues = textValues,
          textBox = textBox,
          textBoxValues = textBoxValues,
          bounds = bounds,
        }
      end
      owner.Command = owner._CreateCommandApi()
      return owner
    end
  end
  
  __lux_exports.name = name
  __lux_exports.makeRoundedBox = makeRoundedBox
  __lux_exports.makePoly = makePoly
  __lux_exports.makeImage = makeImage
  __lux_exports.makeLine = makeLine
  __lux_exports.makeClip = makeClip
  __lux_exports.makeProgress = makeProgress
  __lux_exports.makeRing = makeRing
  __lux_exports.makeArc = makeArc
  __lux_exports.makeSector = makeSector
  __lux_exports.makeText = makeText
  __lux_exports.makeTextBox = makeTextBox
  __lux_exports.roundedBox = roundedBox
  __lux_exports.roundedBoxValues = roundedBoxValues
  __lux_exports.chamferBox = chamferBox
  __lux_exports.poly = poly
  __lux_exports.polyValues = polyValues
  __lux_exports.image = image
  __lux_exports.imageValues = imageValues
  __lux_exports.line = line
  __lux_exports.lineValues = lineValues
  __lux_exports.clip = clip
  __lux_exports.clipValues = clipValues
  __lux_exports.progressBar = progressBar
  __lux_exports.progressBarValues = progressBarValues
  __lux_exports.segmentBar = segmentBar
  __lux_exports.ring = ring
  __lux_exports.ringValues = ringValues
  __lux_exports.arc = arc
  __lux_exports.arcValues = arcValues
  __lux_exports.sector = sector
  __lux_exports.sectorValues = sectorValues
  __lux_exports.text = text
  __lux_exports.textValues = textValues
  __lux_exports.textBox = textBox
  __lux_exports.textBoxValues = textBoxValues
  __lux_exports.bounds = bounds
  __lux_exports.normalize = normalize
  __lux_exports.normalizeAll = normalizeAll
  __lux_exports.values = values
  __lux_exports.install = install
  
  return __lux_exports
end
