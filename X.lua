require("DeftLib")
require("OpenPredict")
require("DamageLib")


local UniversalMenu = Menu("Universal", "Universal")

UniversalMenu:SubMenu("KillSteal", "KillSteal")

UniversalMenu.KillSteal:Boolean("Q", "Use Q ", true)
UniversalMenu.KillSteal:Boolean("W", "Use W ", true)
UniversalMenu.KillSteal:Boolean("E", "Use E ", true)
UniversalMenu.KillSteal:Boolean("R", "Use R ", true)
UniversalMenu.KillSteal:Boolean("Combo", "Use Full Combo ", true)

OnTick(function (myHero)
	local target = GetCurrentTarget()
        local BonusAD = GetBonusDmg(myHero)
        local BaseAD = GetBaseDamage(myHero)
	local BonusAP = GetBonusDmg(myHero)
        local BaseAP = GetBaseDamage(myHero)

   if IsReady(_Q) and ValidTarget(enemy, QRange) and UniversalMenu.KillSteal.Q:Value() and GetHP(enemy) < getdmg("Q",enemy) then		         
                                      CastSkillShot(_Q, target)
		         
                 end 

  if IsReady(_W) and ValidTarget(enemy, WRange) and UniversalMenu.KillSteal.W:Value() and GetHP(enemy) < getdmg("W",enemy) then		         
                                      CastSkillShot(_W, target)
		 end 

  if IsReady(_E) and ValidTarget(enemy, ERange) and UniversalMenu.KillSteal.E:Value() and GetHP(enemy) < getdmg("E",enemy) then
		                      CastSkillShot(_E, target)
                 end

  if IsReady(_R) and ValidTarget(enemy, RRange) and UniversalMenu.KillSteal.R:Value() and GetHP(enemy) < getdmg("R",enemy) then
		                      CastSkillShot(_R, target)
                 end


  

  
  if IsReady(_R) and IsReady(_E) and IsReady(_W) and IsReady(_Q) and ValidTarget(enemy, RRange) and ValidTarget(enemy, ERange) and ValidTarget(enemy, WRange) and ValidTarget(enemy, QRange) and UniversalMenu.KillSteal.Combo:Value() and GetHP(enemy) < (getdmg("Q",enemy) + getdmg("W",enemy) + getdmg("E",enemy) + getdmg("R",enemy)) then
		                     CastTargetSpell(target, _Q)  CastSpell(_W)  CastSkillShot(_E, target.pos)  CastSkillShot(_R, target)
                 end

      	
	end   	
       
   
end)


