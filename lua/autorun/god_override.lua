local Player = FindMetaTable("Player")

if SERVER then
	function Player:GodEnable()
		if hook.Call("GodEnable", GAMEMODE, self) then return end

		self:SetNWBool("HasGodMode", true)
		self:AddFlags(FL_GODMODE)
	end
	
	function Player:GodDisable()
		if hook.Call("GodDisable", GAMEMODE, self) then return end

		self:SetNWBool("HasGodMode", false)
		self:RemoveFlags(FL_GODMODE)
	end
	
	hook.Add("PlayerSpawn","GodOverride_PlayerSpawn", function(ply)
		if ply:HasGodMode() then
			ply:GodEnable()
		end
	end)
	
	hook.Add("PlayerDeath","GodOverride_PlayerDeath", function(ply)
		ply:SetNWBool("HasGodMode", false)
	end)

	hook.Remove("PlayerSpawn","God_PlayerSpawn")
	hook.Remove("PlayerDeath","God_PlayerDeath")
end

function Player:HasGodMode()
	return self:GetNWBool("HasGodMode")
end
