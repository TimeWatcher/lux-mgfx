if SERVER then return end

MGFX = MGFX or {}

function MGFX._CreateCommandApi()
	local api = {}

	function api.name(command)
		return command and (command.op or command[1])
	end

	function api.roundedBox(command)
		if command and command.op then return command end
		return {
			op = command[1],
			x = command[2],
			y = command[3],
			w = command[4],
			h = command[5],
			style = command[6],
		}
	end

	function api.chamferBox(command)
		if command and command.op then return command end
		return {
			op = command[1],
			x = command[2],
			y = command[3],
			w = command[4],
			h = command[5],
			style = command[6],
		}
	end

	function api.poly(command)
		if command and command.op then return command end
		return {
			op = command[1],
			points = command[2],
			style = command[3],
		}
	end

	function api.image(command)
		if command and command.op then return command end
		return {
			op = command[1],
			x = command[2],
			y = command[3],
			w = command[4],
			h = command[5],
			source = command[6],
			style = command[7],
		}
	end

	function api.line(command)
		if command and command.op then return command end
		return {
			op = command[1],
			x1 = command[2],
			y1 = command[3],
			x2 = command[4],
			y2 = command[5],
			style = command[6],
		}
	end

	function api.clip(command)
		if command and command.op then return command end
		return {
			op = command[1],
			x = command[2],
			y = command[3],
			w = command[4],
			h = command[5],
		}
	end

	function api.progressBar(command)
		if command and command.op then return command end
		return {
			op = command[1],
			x = command[2],
			y = command[3],
			w = command[4],
			h = command[5],
			value = command[6],
			style = command[7],
		}
	end

	function api.segmentBar(command)
		if command and command.op then return command end
		return {
			op = command[1],
			x = command[2],
			y = command[3],
			w = command[4],
			h = command[5],
			value = command[6],
			style = command[7],
		}
	end

	function api.ring(command)
		if command and command.op then return command end
		return {
			op = command[1],
			x = command[2],
			y = command[3],
			radius = command[4],
			width = command[5],
			style = command[6],
		}
	end

	function api.arc(command)
		if command and command.op then return command end
		return {
			op = command[1],
			x = command[2],
			y = command[3],
			radius = command[4],
			width = command[5],
			startDeg = command[6],
			endDeg = command[7],
			style = command[8],
		}
	end

	function api.sector(command)
		if command and command.op then return command end
		return {
			op = command[1],
			x = command[2],
			y = command[3],
			innerRadius = command[4],
			outerRadius = command[5],
			startDeg = command[6],
			endDeg = command[7],
			style = command[8],
		}
	end

	function api.text(command)
		if command and command.op then return command end
		return {
			op = command[1],
			text = command[2],
			font = command[3],
			x = command[4],
			y = command[5],
			color = command[6],
			ax = command[7],
			ay = command[8],
			style = command[9],
		}
	end

	function api.textBox(command)
		if command and command.op then return command end
		return {
			op = command[1],
			text = command[2],
			font = command[3],
			x = command[4],
			y = command[5],
			w = command[6],
			h = command[7],
			style = command[8],
		}
	end

	function api.bounds(command)
		local name = api.name(command)
		if name == "DrawRoundedBox" then
			local c = api.roundedBox(command)
			return c.x, c.y, c.w, c.h
		elseif name == "DrawChamferBox" then
			local c = api.chamferBox(command)
			return c.x, c.y, c.w, c.h
		elseif name == "DrawProgressBar" then
			local c = api.progressBar(command)
			return c.x, c.y, c.w, c.h
		elseif name == "DrawSegmentBar" then
			local c = api.segmentBar(command)
			return c.x, c.y, c.w, c.h
		elseif name == "DrawImage" then
			local c = api.image(command)
			return c.x, c.y, c.w, c.h
		elseif name == "DrawRing" then
			local c = api.ring(command)
			local r = tonumber(c.radius) or 0
			return c.x - r, c.y - r, r * 2, r * 2
		elseif name == "DrawArc" then
			local c = api.arc(command)
			local r = tonumber(c.radius) or 0
			return c.x - r, c.y - r, r * 2, r * 2
		elseif name == "DrawSector" then
			local c = api.sector(command)
			local r = tonumber(c.outerRadius) or 0
			return c.x - r, c.y - r, r * 2, r * 2
		end
	end

	return api
end
