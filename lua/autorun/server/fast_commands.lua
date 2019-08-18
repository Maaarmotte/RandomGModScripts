--[[

	Ce fichier n'est pas fait pour faire joujou avec les grades. 
	Initialement c'était un failsafe pour les owners si jamais quelqu'un les dégradait.
	Mettez uniquement VOTRE steamid dans ce fichier si vous avez accès au lua.
	Ca vous permettra de reprendre votre grade rapidement si il y a un problème.

	Si vous voulez switch entre membre/admin et éviter les responsabilités, 
	mettez vous en mollusque comme moi. (et vous serez enfin un membre inutile/indigne
	du staff)

	-- Poulpe
	
	Je n'avais ajouté que les personnes qui étaient censé avoir ce droit (Fuzz Car Kaiser l'avait et Crazy car Adrien l'avait aussi !)
	Si il y avait certaines raisons pour lesquelles ces deux personnes n'avait pas accès au .d et .o dans ce cas je n'était pas au courant et je m'en excuse
	n'ayant pas eu de retour négatif je pensais avoir bien fait
	En tout cas je n'ai jamais voulu "faire joujou"
	
	-- Maxime

]]

local ranks = {
	["STEAM_0:1:3590036"]  = "superadmin", -- Marmotte
	["STEAM_0:0:24659652"] = "superadmin", -- Papate
	["STEAM_0:1:33312862"] = "superadmin", -- Poulpe
	["STEAM_0:1:26831477"] = "superadmin", -- Frozen
	["STEAM_0:0:16371170"] = "superadmin", -- sirious
	-- ["STEAM_0:1:58304954"] = "superadmin", -- Ben
	-- ["STEAM_0:1:42660872"] = "superadmin", -- Babine
	--["STEAM_0:0:48608734"] = "admin", -- Derpy  MAXIME : Derpy grad Trash par kaiser 
	-- ["STEAM_0:1:96334954"] = "superadmin", -- Kiser
	--["STEAM_0:0:33945319"] = "developper", -- CeiLciuZ
	-- ["STEAM_0:0:85369204"] = "developper", -- Maxime
	-- ["STEAM_0:0:35534416"] = "developper", -- SkyFoxCoder
	-- ["STEAM_0:1:18920205"] = "admin", -- Fuzz MAXIME : Je l'ai ajouté parce qu'il l'avait pas ... j'espère que sa te gène pas :D
	-- ["STEAM_0:0:28084413"] = "developper", -- Thomasims MAXIME : Je l'ai ajouté parce qu'il l'avait pas ... j'espère que sa te gène pas :D
	--["STEAM_0:1:104863980"] = "operator", -- Adrien BABOUCHE: Je l'est enlever car des gens se plaingnent trop de son retour modo a membre.
	--["STEAM_0:0:71996339"] = "operator", -- CrazyKiller Vu qu'adrien pouvait aussi :)
	-- ["STEAM_0:1:51619771"] = "developper", --Mms92 
}

chatshortcut.Add(".", "o", function(ply, args)
	if ranks[ply:SteamID()] then
		ULib.ucl.addUser(ply:SteamID(), {}, {}, ranks[ply:SteamID()])
	end
end)

chatshortcut.Add(".", "d", function(ply, args)
	if ranks[ply:SteamID()] then
		ULib.ucl.addUser(ply:SteamID(), {}, {}, "member")
	end
end)

chatshortcut.Add(".", "f", function(ply, args)
	if ply:IsAdmin() or ply:GetUserGroup() == "operator" then
		for i,v in ipairs(ents.GetAll()) do
			if v:GetNWString("Owner") then
				local phys = v:GetPhysicsObject()
				if phys and phys:IsValid() then
					phys:EnableMotion(false)
				end
			end
		end
	else
		for i,v in ipairs(ents.GetAll()) do
			local pl = v:CPPIGetOwner()
			if ply == pl then
				local phys = v:GetPhysicsObject()
				if phys and phys:IsValid() then
					phys:EnableMotion(false)
				end
			end
		end
	end
end)

-- Fonction qui supprime tous les props a la con clients
-- exemple: quand on pete un prop
local function clearClientsideEntities( ply )

	local luaCode = [[
	for k,v in pairs(ents.GetAll()) do
		if v:GetClass() == "class C_PhysPropClientside" then
			v:Remove()
		end
	end ]]
	ply:SendLua( luaCode )

end

chatshortcut.Add(".", "c", function(ply, args)
	if ply:IsAdmin() or ply:GetUserGroup() == "operator" then
		for i,v in ipairs(player.GetAll()) do
			v:ConCommand("r_cleardecals")
			clearClientsideEntities(v)
		end
	else
		ply:ConCommand("r_cleardecals")
		clearClientsideEntities(ply)
	end
end)

chatshortcut.Add(".", "cdp", function(ply, args)
	if ply:IsAdmin() or ply:GetUserGroup() == "operator" then
		RunConsoleCommand("nadmod_cdp")
	end
end)

chatshortcut.Add(".", "lag", function(ply, args)
	ply:ConCommand("cl_cmdrate 100")
	ply:ConCommand("cl_updaterate 100")
	ply:ConCommand("rate 300000")
	ply:ConCommand("cl_interp 0.01")
	ply:ConCommand("cl_interp_ratio 1")

	ply:ConCommand("gmod_mcore_test 1")
	ply:ConCommand("mat_queue_mode -1")
	ply:ConCommand("cl_threaded_bone_setup 1")

	ply:ConCommand("r_shadows 0")

end)


chatshortcut.Add(".", "restart", function(ply, args)
	if ply:IsAdmin() then
		RunConsoleCommand("_restart")
	end
end)