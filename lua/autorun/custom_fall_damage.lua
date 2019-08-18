
AddCSLuaFile()

CFD        	= {}
CFD.enabled	= true

if SERVER then
	CFD.degree    	= 0.00025
	CFD.speedfloor	= 450
	CFD.randdif   	= 20

	CFD.damagefloor     	= 5
	CFD.lightdamageceil 	= 20
	CFD.normaldamageceil	= 60

end
	

hook.Add("OnPlayerHitGround", "CustomFallDamage", function(ply, inWater, onFloater, speed)
	if CFD.enabled then
		if SERVER then
			if speed > CFD.speedfloor then
				local world = ents.GetByIndex(0)
				local damage = CFD.degree*(speed-CFD.speedfloor)^2
				damage = damage + damage*math.Rand(-CFD.randdif,CFD.randdif)/100
				
				local dmg = DamageInfo()
				dmg:SetDamage(damage)
				dmg:SetDamageType(DMG_FALL)
				dmg:SetAttacker(world)
				dmg:SetInflictor(world)
				
				if damage > CFD.damagefloor then
					ply:TakeDamageInfo(dmg)
					
					if damage < CFD.lightdamageceil then
						ply:EmitSound("player/pl_fallpain3.wav")
					elseif damage < CFD.normaldamageceil then
						ply:EmitSound("player/pl_fallpain1.wav")
					else
						ply:EmitSound("player/pl_fallpain.wav")
					end
				end
			end
		end
		
		return true
	end
end)