
hook.Add("KeyPress", "Wizz", function(ply, key)
	if key == IN_USE then
		local trace   	= ply:GetEyeTrace()
		local target  	= trace.Entity
		local distance	= (trace.StartPos - trace.HitPos):Length()
		
		if IsValid(target) and target:IsPlayer() then
			if distance < 100 then
				if (CurTime() - (ply.lastwizz or 0)) > 1 then
					ply.lastwizz = CurTime()
					
					if target:HasGodMode() then
						target = ply
					end
					
					util.ScreenShake((target:GetShootPos() + target:GetPos())/2, 50, 50, 1, 5)
					target:TakeDamage(math.Round(math.random(3,8)), ply)
					target:EmitSound("ambient/energy/zap" .. math.Round(math.random(1,9)) .. ".wav")
				end
			end
		end
	end
end)