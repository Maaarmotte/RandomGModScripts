
local damagedice = 20
local damagemultiplier = 1


local function CostumDamageScale(ply, hitgroup, dmg)
	local damage = 100
	
	if hitgroup == HITGROUP_HEAD then
		damage = 400
	elseif hitgroup == HITGROUP_CHEST then
		damage = 100
	elseif hitgroup == HITGROUP_STOMACH then
		damage = 125
	elseif hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM then
		damage = 90
	elseif hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG then
		damage = 70
	else
		damage = 100
	end
	
	scale = math.Round(damage/100 * (math.Rand(-damagedice, damagedice)/100 + 1) * damagemultiplier, 2)
	
	
	dmg:ScaleDamage(scale)
	
	
	return false
end

hook.Add("ScalePlayerDamage", "CostumDamageScale", CostumDamageScale) 
hook.Add("ScaleNPCDamage", "CostumDamageScale", CostumDamageScale) 