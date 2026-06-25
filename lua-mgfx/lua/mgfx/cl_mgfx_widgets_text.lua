if SERVER then return end

MGFX = MGFX or {}

function MGFX._InstallWidgetText(C)
	local M = C.M
	local materials = C.materials
	local forceFallback = C.forceFallback
	local queueCommand = C.queueCommand
	local queueTextRecord = C.queueTextRecord
	local queueTextBatch = C.queueTextBatch
	local copyStyle = C.copyStyle or function(style) return istable(style) and table.Copy(style) or {} end
	local resolveDrawStyle = C.resolveDrawStyle or copyStyle
	local matOK = C.matOK
	local asColor = C.asColor
	local color01 = C.color01
	local setDrawColor = C.setDrawColor
	local strokeWidthValue = C.strokeWidthValue
	local radiusTuple = C.radiusTuple
	local radiusScalar = C.radiusScalar
	local fillFromStyle = C.fillFromStyle
	local fillVisible = C.fillVisible
	local strokeVisible = C.strokeVisible
	local colorAtFill = C.colorAtFill
	local isCulled = C.isCulled
	local normalizedRotation = C.normalizedRotation
	local imageMaskStyle = C.imageMaskStyle or function(mask) return mask end
	local setupConstants = C.setupConstants
	local drawTexturedQuad = C.drawTexturedQuad
	local drawCreatedMaterialTexturedRectUV = C.drawCreatedMaterialTexturedRectUV
	local imageTint = C.imageTint
	local imageStyle = C.imageStyle
	local imageRadius = C.imageRadius
	local imageUV = C.imageUV
	local imageFitRect = C.imageFitRect
	local drawRoundRectImmediate = C.drawRoundRectImmediate
	local drawRoundRectOuterGlow = C.drawRoundRectOuterGlow
	local chamferTuple = C.chamferTuple
	local drawChamferOuterGlow = C.drawChamferOuterGlow
	local drawChamferPattern = C.drawChamferPattern
	local patternStyle = C.patternStyle
	local patternOffset = C.patternOffset
	local textureFallbackMaterial = C.textureFallbackMaterial
	local materialCache = C.materialCache
	local textRenderer = C.textRenderer
	local FILL_SOLID = C.FILL_SOLID
	local FILL_LINEAR = C.FILL_LINEAR
	local FILL_RADIAL = C.FILL_RADIAL
	local FILL_CONIC = C.FILL_CONIC
	local math_abs = math.abs
	local math_max = math.max
	local math_min = math.min
	local math_floor = math.floor
	local math_rad = math.rad
	local math_cos = math.cos
	local math_sin = math.sin
	local surface_DrawTexturedRectUV = surface.DrawTexturedRectUV
	local surface_SetDrawColor = surface.SetDrawColor
	local surface_SetMaterial = surface.SetMaterial
	local FX_GLOW = 1
	local FX_SHEEN = 2
	local FX_MARKER = 4
	local MASK_ROUNDED = 0
	local MASK_CHAMFER = 1
	local MASK_CIRCLE = 2
	local MASK_CAPSULE = 3
	local MASK_TEXTURE_A = 10
	local MASK_TEXTURE_R = 11
	local MASK_TEXTURE_G = 12
	local MASK_TEXTURE_B = 13
	local MASK_TEXTURE_LUMA = 14

local function measureTextFallback(textValue, font)
	surface.SetFont(font or "DermaDefault")
	local tw, th = surface.GetTextSize(tostring(textValue or ""))
	return tw or 0, th or 0
end

local function isResolvedTextStyle(style)
	return istable(style) and style.__mgfxTextResolved == true
end

function M.MeasureText(textValue, font)
	if textRenderer and textRenderer.MeasureText then
		return textRenderer.MeasureText(textValue, font)
	end
	return measureTextFallback(textValue, font)
end

function M.MeasureTextBox(textValue, font, w, style)
	if textRenderer and textRenderer.MeasureTextBox then
		return textRenderer.MeasureTextBox(textValue, font, w, style or {})
	end
	local tw, th = measureTextFallback(textValue, font)
	return math_min(tw, tonumber(w) or tw), th, {tostring(textValue or "")}
end

function M.ResolveTextStyle(style)
	if isResolvedTextStyle(style) then return style end
	style = resolveDrawStyle(style, M.TARGET.TEXT)
	if textRenderer and textRenderer.ResolveStyle then
		return textRenderer.ResolveStyle(style or {})
	end
	return istable(style) and table.Copy(style) or {}
end

function M.DefineTextStyle(name, style)
	if textRenderer and textRenderer.DefineStyle then
		return textRenderer.DefineStyle(name, style or {})
	end
	return nil
end

function M.GetTextStyle(name)
	if textRenderer and textRenderer.GetStyle then
		return textRenderer.GetStyle(name)
	end
	return nil
end

function M.RegisterTextFont(fontName, spec)
	if textRenderer and textRenderer.RegisterFont then
		return textRenderer.RegisterFont(fontName, spec)
	end
	return false
end

function M.PrewarmText(textValue, font, style)
	if textRenderer and textRenderer.PrewarmText then
		return textRenderer.PrewarmText(textValue, font, style and M.ResolveTextStyle(style) or nil)
	end
end

function M.SetTextProfileActive(active)
	if textRenderer and textRenderer.SetProfileActive then
		return textRenderer.SetProfileActive(active)
	end
end

function M.ResetTextProfile()
	if textRenderer and textRenderer.ResetProfile then
		return textRenderer.ResetProfile()
	end
end

function M.GetTextProfileSnapshot(reset)
	if textRenderer and textRenderer.ProfileSnapshot then
		return textRenderer.ProfileSnapshot(reset)
	end
	return {}, {}
end

function M.TextBatchEx(records)
	if not records or #records == 0 then return end

	local batch = {}
	for i = 1, #records do
		local r = records[i]
		if r then
			local style = M.ResolveTextStyle(r.style or {})
			if textRenderer and textRenderer.MakeRecord then
				batch[#batch + 1] = textRenderer.MakeRecord(
					r.text or r.value,
					r.font,
					r.x,
					r.y,
					r.color,
					r.ax or r.alignX,
					r.ay or r.alignY,
					style
				)
			else
				batch[#batch + 1] = {
					text = r.text or r.value,
					font = r.font,
					x = r.x,
					y = r.y,
					color = r.color,
					alignX = r.ax or r.alignX,
					alignY = r.ay or r.alignY,
					style = style,
				}
			end
		end
	end
	if #batch == 0 then return end

	if queueTextBatch then
		if queueTextBatch(batch) then return end
	elseif queueCommand({op = "DrawTextBatch", records = batch}) then
		return
	end
	if textRenderer and textRenderer.Flush then
		return textRenderer.Flush(batch, "batch")
	end

	for i = 1, #batch do
		local r = batch[i]
		draw.SimpleText(tostring(r.text or ""), r.font or "DermaDefault", r.x or 0, r.y or 0, r.color or color_white, r.alignX or TEXT_ALIGN_LEFT, r.alignY or TEXT_ALIGN_TOP)
	end
end

function M.TextEx(textValue, font, x, y, color, ax, ay, style)
	local resolvedStyle = M.ResolveTextStyle(style or {})
	if textRenderer and textRenderer.MakeRecord then
		local record = textRenderer.MakeRecord(textValue, font, x, y, color, ax, ay, resolvedStyle)
		if queueTextRecord then
			if queueTextRecord(record) then return end
		elseif queueCommand({op = "DrawText", record = record}) then
			return
		end
		if textRenderer.DrawRecordImmediate then
			return textRenderer.DrawRecordImmediate(record)
		end
	elseif queueCommand({op = "DrawText", text = textValue, font = font, x = x, y = y, color = color, ax = ax, ay = ay, style = resolvedStyle}) then
		return
	end

	if textRenderer and textRenderer.DrawTextImmediate then
		return textRenderer.DrawTextImmediate(textValue, font, x, y, color, ax, ay, resolvedStyle)
	end

	draw.SimpleText(tostring(textValue or ""), font or "DermaDefault", x or 0, y or 0, color or color_white, ax or TEXT_ALIGN_LEFT, ay or TEXT_ALIGN_TOP)
end

function M.Text(textValue, font, x, y, color, ax, ay)
	return M.TextEx(textValue, font, x, y, color, ax, ay, nil)
end

function M.TextBoxEx(textValue, font, x, y, w, h, style)
	local resolvedStyle = M.ResolveTextStyle(style or {})
	if queueCommand({op = "DrawTextBox", text = textValue, font = font, x = x, y = y, w = w, h = h, style = resolvedStyle}) then return end

	if textRenderer and textRenderer.DrawTextBoxImmediate then
		return textRenderer.DrawTextBoxImmediate(textValue, font, x, y, w, h, resolvedStyle)
	end

	local styleFallback = resolvedStyle or {}
	draw.SimpleText(tostring(textValue or ""), font or "DermaDefault", x or 0, y or 0, styleFallback.color or styleFallback.fill or color_white, styleFallback.alignX or TEXT_ALIGN_LEFT, styleFallback.alignY or TEXT_ALIGN_TOP)
end

function M.TextBox(textValue, font, x, y, w, h, color, alignX, alignY)
	if textRenderer and textRenderer.DrawTextBoxImmediate then
		local resolvedStyle = textRenderer.ResolveStyle({
			color = color,
			alignX = alignX,
			alignY = alignY,
		})
		if queueCommand({op = "DrawTextBox", text = textValue, font = font, x = x, y = y, w = w, h = h, style = resolvedStyle}) then return end
		return textRenderer.DrawTextBoxImmediate(textValue, font, x, y, w, h, resolvedStyle)
	end

	draw.SimpleText(tostring(textValue or ""), font or "DermaDefault", x or 0, y or 0, color or color_white, alignX or TEXT_ALIGN_LEFT, alignY or TEXT_ALIGN_TOP)
end

end
