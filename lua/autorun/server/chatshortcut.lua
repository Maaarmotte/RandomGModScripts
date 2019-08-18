chatshortcut = {}
local csc = chatshortcut
csc.list = {}

function csc.Add(prefix, command, callback, shouldhide)
	local tab = {
		prefix = prefix,
		command = command,
		hide = isbool(shouldhide) and shouldhide or true 
	}

	if isstring(callback) then
		local cmd = callback
		callback = function(ply, args)
			ply:ConCommand(cmd .. " " .. table.concat(args, " "))
		end
	end

	tab.callback = callback
	
	csc.list[prefix] = csc.list[prefix] or {}
	csc.list[prefix][command] = tab
end

function csc.Remove(prefix, command)
	csc.list[prefix][command] = nil
end

hook.Add("PlayerSay", "ChatShortCut", function(ply, text)
	local pfx = string.sub(text, 1, 1)
	local args = string.Explode(" ", string.sub(text, 2))
	local cmd = table.remove(args, 1)

	if csc.list[pfx] and csc.list[pfx][cmd] then
		local sc = csc.list[pfx][cmd]

		sc.callback(ply, args)

		if sc.hide then
			return ""
		end
	end
end)