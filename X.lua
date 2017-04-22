require("DeftLib")
require("OpenPredict")
require("DamageLib")


local ExectuteMenu = Menu("Exectute", "Execute")

ExectuteMenu:SubMenu("KillSteal", "KillSteal")

ExectuteMenu.KillSteal:Boolean("Q", "Use Q ", true)
ExectuteMenu.KillSteal:Boolean("W", "Use W ", true)
ExectuteMenu.KillSteal:Boolean("E", "Use E ", true)
ExectuteMenu.KillSteal:Boolean("R", "Use R ", true)
ExectuteMenu.KillSteal:Boolean("Combo", "Use Full Combo ", true)

OnTick(function (myHero)
	local target = GetCurrentTarget()
        local BonusAD = GetBonusDmg(myHero)
        local BaseAD = GetBaseDamage(myHero)
	local BonusAP = GetBonusDmg(myHero)
        local BaseAP = GetBaseDamage(myHero)

   if IsReady(_Q) and ValidTarget(enemy, QRange) and ExectuteMenu.KillSteal.Q:Value() and GetHP(enemy) < getdmg("Q",enemy) then		         
                                      CastSkillShot(_Q, target)
		         
                 end 

  if IsReady(_W) and ValidTarget(enemy, WRange) and ExectuteMenu.KillSteal.W:Value() and GetHP(enemy) < getdmg("W",enemy) then		         
                                      CastSkillShot(_W, target)
		 end 

  if IsReady(_E) and ValidTarget(enemy, ERange) and ExectuteMenu.KillSteal.E:Value() and GetHP(enemy) < getdmg("E",enemy) then
		                      CastSkillShot(_E, target)
                 end

  if IsReady(_R) and ValidTarget(enemy, RRange) and ExectuteMenu.KillSteal.R:Value() and GetHP(enemy) < getdmg("R",enemy) then
		                      CastSkillShot(_R, target)
                 end


  

  
  if IsReady(_R) and IsReady(_E) and IsReady(_Q) and ValidTarget(enemy, RRange) and ValidTarget(enemy, ERange) and ValidTarget(enemy, QRange) and ExectuteMenu.KillSteal.Combo:Value() and GetHP(enemy) < (getdmg("Q",enemy) + getdmg("E",enemy) + getdmg("R",enemy)) then
		                     CastTargetSpell(target, _Q)  CastSkillShot(_E, target.pos)  CastSkillShot(_R, target)
                 end

      	
	 	
       
   
end)


