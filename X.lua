if FileExist(COMMON_PATH.."MixLib.lua") then
 require('MixLib')
else
 PrintChat("MixLib not found. Please wait for download.")
 DownloadFileAsync("https://raw.githubusercontent.com/VTNEETS/NEET-Scripts/master/MixLib.lua", COMMON_PATH.."MixLib.lua", function() PrintChat("Downloaded MixLib. Please 2x F6!") return end)
end



require("DamageLib")
require("DeftLib")

local ChampMenu = Menu("Champ", "Champ")

ChampMenu:SubMenu("Combo", "Combo")

ChampMenu.Combo:Boolean("Q", "Use Q in combo", true)
ChampMenu.Combo:Boolean("W", "Use W in combo", true)
ChampMenu.Combo:Boolean("E", "Use E in combo", true)
ChampMenu.Combo:Boolean("R", "Use R in combo", true)

OnTick(function (myHero)
local target = GetCurrentTarget()

--COMBO
if Mix:Mode() == "Combo" then

if ChampMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, GetCastRange(myHero,_Q)) then
		     if target ~= nil then 
                         Cast(_Q, target)
                     end
end

 if ChampMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, GetCastRange(myHero,_W)) then
			Cast(_W, target)
end	

 if ChampMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target, GetCastRange(myHero,_E)) then
			Cast(_E, target)
end      
      
      if ChampMenu.Combo.R1:Value() and Ready(_R) and ValidTarget(target, GetCastRange(myHero,_R)) then
			Cast(_R, target)
      end	
    end
  end)  
