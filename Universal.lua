local ver = "0.01"


if FileExist(COMMON_PATH.."MixLib.lua") then
 require('MixLib')
else
 PrintChat("MixLib not found. Please wait for download.")
 DownloadFileAsync("https://raw.githubusercontent.com/VTNEETS/NEET-Scripts/master/MixLib.lua", COMMON_PATH.."MixLib.lua", function() PrintChat("Downloaded MixLib. Please 2x F6!") return end)
end




require("OpenPredict")
require("DamageLib")

function AutoUpdate(data)
    if tonumber(data) > tonumber(ver) then
        PrintChat('<font color = "#00FFFF">New version found! ' .. data)
        PrintChat('<font color = "#00FFFF">Downloading update, please wait...')
        DownloadFileAsync('https://raw.githubusercontent.com/allwillburn/Universal/master/Universal.lua', SCRIPT_PATH .. 'Universal.lua', function() PrintChat('<font color = "#00FFFF">Update Complete, please 2x F6!') return end)
    else
        PrintChat('<font color = "#00FFFF">No updates found!')
    end
end

GetWebResultAsync("https://raw.githubusercontent.com/allwillburn/Universal/master/Universal.version", AutoUpdate)


GetLevelPoints = function(unit) return GetLevel(unit) - (GetCastLevel(unit,0)+GetCastLevel(unit,1)+GetCastLevel(unit,2)+GetCastLevel(unit,3)) end
local SetDCP, SkinChanger = 0

l
local UniversalMenu = Menu("Universal", "Universal")

UniversalMenu:SubMenu("Combo", "Combo")

UniversalMenu.Combo:Boolean("Q", "Use Q in combo", true)
UniversalMenu.Combo:Boolean("W", "Use W in combo", true)
UniversalMenu.Combo:Boolean("E", "Use E in combo", true)
UniversalMenu.Combo:Boolean("R", "Use R in combo", true)
UniversalMenu.Combo:Slider("RX", "X Enemies to Cast R",3,1,5,1)
UniversalMenu.Combo:Boolean("Cutlass", "Use Cutlass", true)
UniversalMenu.Combo:Boolean("Tiamat", "Use Tiamat", true)
UniversalMenu.Combo:Boolean("BOTRK", "Use BOTRK", true)
UniversalMenu.Combo:Boolean("RHydra", "Use RHydra", true)
UniversalMenu.Combo:Boolean("YGB", "Use GhostBlade", true)
UniversalMenu.Combo:Boolean("Gunblade", "Use Gunblade", true)
UniversalMenu.Combo:Boolean("Randuins", "Use Randuins", true)


UniversalMenu:SubMenu("AutoMode", "AutoMode")
UniversalMenu.AutoMode:Boolean("Level", "Auto level spells", false)
UniversalMenu.AutoMode:Boolean("Ghost", "Auto Ghost", false)
UniversalMenu.AutoMode:Boolean("Q", "Auto Q", false)
UniversalMenu.AutoMode:Boolean("W", "Auto W", false)
UniversalMenu.AutoMode:Boolean("E", "Auto E", false)
UniversalMenu.AutoMode:Boolean("R", "Auto R", false)

UniversalMenu:SubMenu("Farm", "Farm")
UniversalMenu.Farm:Boolean("E", "AutoE", true)
UniversalMenu.Farm:Boolean("W", "AutoW", true)
UniversalMenu.Farm:Boolean("Q", "AutoQ", true)
UniversalMenu.Farm:Boolean("AA", "AutoAA", true)

UniversalMenu:SubMenu("LaneClear", "LaneClear")
UniversalMenu.LaneClear:Boolean("Q", "Use Q", true)
UniversalMenu.LaneClear:Boolean("E", "Use E", true)
UniversalMenu.LaneClear:Boolean("RHydra", "Use RHydra", true)
UniversalMenu.LaneClear:Boolean("Tiamat", "Use Tiamat", true)

UniversalMenu:SubMenu("Harass", "Harass")
UniversalMenu.Harass:Boolean("Q", "Use Q", true)

UniversalMenu:SubMenu("KillSteal", "KillSteal")
UniversalMenu.KillSteal:Boolean("Q", "KS w Q", true)
UniversalMenu.KillSteal:Boolean("E", "KS w E", true)
UniversalMenu.KillSteal:Boolean("R", "KS w R", true)

UniversalMenu:SubMenu("AutoIgnite", "AutoIgnite")
UniversalMenu.AutoIgnite:Boolean("Ignite", "Ignite if killable", true)

UniversalMenu:SubMenu("Drawings", "Drawings")
UniversalMenu.Drawings:Boolean("DQ", "Draw Q Range", true)

UniversalMenu:SubMenu("SkinChanger", "SkinChanger")
UniversalMenu.SkinChanger:Boolean("Skin", "UseSkinChanger", true)
UniversalMenu.SkinChanger:Slider("SelectedSkin", "Select A Skin:", 1, 0, 4, 1, function(SetDCP) HeroSkinChanger(myHero, SetDCP)  end, true)

OnTick(function (myHero)
	local target = GetCurrentTarget()
        local YGB = GetItemSlot(myHero, 3142)
	local RHydra = GetItemSlot(myHero, 3074)
	local Tiamat = GetItemSlot(myHero, 3077)
        local Gunblade = GetItemSlot(myHero, 3146)
        local BOTRK = GetItemSlot(myHero, 3153)
        local Cutlass = GetItemSlot(myHero, 3144)
        local Randuins = GetItemSlot(myHero, 3143) 
        local BonusAD = GetBonusDmg(myHero)
        local BaseAD = GetBaseDamage(myHero)
	local BonusAP = GetBonusDmg(myHero)
        local BaseAP = GetBaseDamage(myHero)
        

	--AUTO LEVEL UP
	if UniversalMenu.AutoMode.Level:Value() then

			spellorder = {_E, _W, _Q, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				LevelSpell(spellorder[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
			end
	end
        
        --Harass
          if Mix:Mode() == "Harass" then
            if UniversalMenu.Harass.Q:Value() and Ready(_Q) and ValidTarget(target, 475) then
				if target ~= nil then 
                                      CastSkillShot(_Q, target)
                                end
            end
     
          end

	--COMBO
	  if Mix:Mode() == "Combo" then
            if UniversalMenu.Combo.YGB:Value() and YGB > 0 and Ready(YGB) and ValidTarget(target, 700) then
			CastSpell(YGB)
            end

            if UniversalMenu.Combo.Randuins:Value() and Randuins > 0 and Ready(Randuins) and ValidTarget(target, 500) then
			CastSpell(Randuins)
            end

            if UniversalMenu.Combo.BOTRK:Value() and BOTRK > 0 and Ready(BOTRK) and ValidTarget(target, 550) then
			 CastTargetSpell(target, BOTRK)
            end

            if UniversalMenu.Combo.Cutlass:Value() and Cutlass > 0 and Ready(Cutlass) and ValidTarget(target, 700) then
			 CastTargetSpell(target, Cutlass)
            end

            if UniversalMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target, ERange) then
			CastTargetSpell(target,_E)
	    
            elseif UniversalMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target, ERange) then
			CastSpell(_E)
	    
            elseif UniversalMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target, ERange) then
			CastSkillShot(_E, target)
            elseif UniversalMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target, ERange) then
			CastTargetSpell(_E, target)
	        end
               end
              end 
             end    



            if UniversalMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, QRange) then
		     if target ~= nil then 
                         CastSkillShot(_Q, target)
                     end
            
            elseif UniversalMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, QRange) then 
                         CastTargetSpell(target, _Q)
            elseif UniversalMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, QRange) then 
                         CastTargetSpell(_Q, target)                     
            
            elseif UniversalMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, QRange) then 
                         CastSpell(_Q)                  
                end
               end
              end
             end


 
            if UniversalMenu.Combo.Tiamat:Value() and Tiamat > 0 and Ready(Tiamat) and ValidTarget(target, 350) then
			CastSpell(Tiamat)
            end

            if UniversalMenu.Combo.Gunblade:Value() and Gunblade > 0 and Ready(Gunblade) and ValidTarget(target, 700) then
			CastTargetSpell(target, Gunblade)
            end

            if UniversalMenu.Combo.RHydra:Value() and RHydra > 0 and Ready(RHydra) and ValidTarget(target, 400) then
			CastSpell(RHydra)
            end




	    if UniversalMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, WRange) then
			CastSkillShot(_W, target)
	    
            elseif UniversalMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, WRange) then
			CastTargetSpell(target, _W)
	    
            elseif UniversalMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, WRange) then
			CastTargetSpell(_W, target)
	    
            elseif UniversalMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, WRange) then
			CastSpell(_W) 
	       end
              end
             end
            end
	    
	    	 
	    if UniversalMenu.Combo.W:Value() and Ready(_R) and ValidTarget(target, RRange) then
			CastSkillShot(_R, target)
	    
            elseif UniversalMenu.Combo.R:Value() and Ready(_R) and ValidTarget(target, RRange) then
			CastTargetSpell(target, _R)
	    
            elseif UniversalMenu.Combo.R:Value() and Ready(_R) and ValidTarget(target, RRange) then
			CastTargetSpell(_R, target)
	    
            elseif UniversalMenu.Combo.R:Value() and Ready(_R) and ValidTarget(target, RRange) then
			CastSpell(_R) 
	       end
              end
             end
            end

          end

         --AUTO IGNITE
	for _, enemy in pairs(GetEnemyHeroes()) do
		
		if GetCastName(myHero, SUMMONER_1) == 'SummonerDot' then
			 Ignite = SUMMONER_1
			if ValidTarget(enemy, 600) then
				if 20 * GetLevel(myHero) + 50 > GetCurrentHP(enemy) + GetHPRegen(enemy) * 3 then
					CastTargetSpell(enemy, Ignite)
				end
			end

		elseif GetCastName(myHero, SUMMONER_2) == 'SummonerDot' then
			 Ignite = SUMMONER_2
			if ValidTarget(enemy, 600) then
				if 20 * GetLevel(myHero) + 50 > GetCurrentHP(enemy) + GetHPRegen(enemy) * 3 then
					CastTargetSpell(enemy, Ignite)
				end
			end
		end

	end

        for _, enemy in pairs(GetEnemyHeroes()) do
                
                if IsReady(_Q) and ValidTarget(enemy, QRange) and UniversalMenu.KillSteal.Q:Value() and GetHP(enemy) < getdmg("Q",enemy) then
		         if target ~= nil then 
                                      CastTargetSpell(target, _Q)
		         end
                end 

                if IsReady(_E) and ValidTarget(enemy, ERange) and UniversalMenu.KillSteal.E:Value() and GetHP(enemy) < getdmg("E",enemy) then
		                     CastTargetSpell(target,_E)
  
                end
			
		if IsReady(_R) and ValidTarget(enemy, RRange) and UniversalMenu.KillSteal.R:Value() and GetHP(enemy) < getdmg("R",enemy) then
		                     CastTargetSpell(target, _R)
  
                end
      end

      if Mix:Mode() == "LaneClear" then
      	  for _,closeminion in pairs(minionManager.objects) do
	        if UniversalMenu.LaneClear.Q:Value() and Ready(_Q) and ValidTarget(minion, QRange) then
	        	CastSkillShot(_Q, minion)
                end


                if UniversalMenu.LaneClear.E:Value() and Ready(_E) and ValidTarget(minion, ERange) then
	        	CastTargetSpell(minion, _E)
	        end

                if UniversalMenu.LaneClear.Tiamat:Value() and ValidTarget(closeminion, 350) then
			CastSpell(Tiamat)
		end
	
		if UniversalMenu.LaneClear.RHydra:Value() and ValidTarget(closeminion, 400) then
                        CastTargetSpell(closeminion, RHydra)
      	        end
          end
      end
        --AutoMode
        if UniversalMenu.AutoMode.Q:Value() then        
          if Ready(_Q) and ValidTarget(target, QRange) then
		      CastSkillShot(_Q, target)
          end
        end 
        if UniversalMenu.AutoMode.W:Value() then        
          if Ready(_W) and ValidTarget(target, WRange) then
	  	      CastSkillShot(_W, target)
          end
        end
        if UniversalMenu.AutoMode.E:Value() then        
	  if Ready(_E) and ValidTarget(target, ERange) then
		      CastTargetSpell(target,_E)
	  end
        end
		
        if UniversalMenu.AutoMode.R:Value() then        
	  if Ready(_R) and ValidTarget(target, RRange) then
		     CastSpell(_R)
	  end
        end
                
	--AUTO GHOST
	if UniversalMenu.AutoMode.Ghost:Value() then
		if GetCastName(myHero, SUMMONER_1) == "SummonerHaste" and Ready(SUMMONER_1) then
			CastSpell(SUMMONER_1)
		elseif GetCastName(myHero, SUMMONER_2) == "SummonerHaste" and Ready(SUMMONER_2) then
			CastSpell(Summoner_2)
		end
	end


--Auto E on minions
    for _, minion in pairs(minionManager.objects) do
			
			   	
        if UniversalMenu.Farm.Q:Value() and Ready(_Q) and ValidTarget(minion, QRange) and GetCurrentHP(minion) < CalcDamage(myHero,minion,QDmg,Q) then
            CastSkillShot(_Q, minion)
        end
			
        if UniversalMenu.Farm.E:Value() and Ready(_E) and ValidTarget(minion, ERange) and GetCurrentHP(minion) < getdmg("E",minion) then 
            CastTargetSpell(minion,_E)
        endW
        if UniversalMenu.Farm.W:Value() and Ready(_E) and ValidTarget(minion, WRange) and GetCurrentHP(minion) < getdmg("W",minion) then 
            CastTargetSpell(minion,_W)
        end
			
	if UniversalMenu.Farm.AA:Value() and ValidTarget(minion, 175) and GetCurrentHP(minion) < CalcDamage(myHero,minion,AADmg,AA) then
            AttackUnit(minion)
        end	
			
		   	
       
    end	
end)


OnDraw(function (myHero)
        
         if UniversalMenu.Drawings.DQ:Value() then
		DrawCircle(GetOrigin(myHero), QRange, 0, 200, GoS.Red)
	end

end)


OnProcessSpell(function(unit, spell)
	local target = GetCurrentTarget()        
       
        
        if unit.isMe and spell.name:lower():find("itemtiamatcleave") then
		Mix:ResetAA()
	end	
               
        if unit.isMe and spell.name:lower():find("itemravenoushydracrescent") then
		Mix:ResetAA()
	end

end) 


local function SkinChanger()
	if UniversalMenu.SkinChanger.UseSkinChanger:Value() then
		if SetDCP >= 0  and SetDCP ~= GlobalSkin then
			HeroSkinChanger(myHero, SetDCP)
			GlobalSkin = SetDCP
		end
        end
end


print('<font color = "#01DF01"><b>Universal</b> <font color = "#01DF01">by <font color = "#01DF01"><b>Allwillburn</b> <font color = "#01DF01">Loaded!')





