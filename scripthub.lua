if menutype then
  if menutype == "bothub" then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/muiky05/randomeditedscripts/refs/heads/main/bot.lua'))()
  elseif menutype == "vcbypass" then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/muiky05/randomeditedscripts/refs/heads/main/vcbypass.lua'))()
  end
else
  if game.PlaceId == 16732694052 then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/muiky05/randomeditedscripts/refs/heads/main/autofish.lua'))()
  elseif game.PlaceId == 13438553315 then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/muiky05/randomeditedscripts/refs/heads/main/decayingwinter.lua'))()
  elseif game.PlaceId == 11157166793 then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/muiky05/randomeditedscripts/refs/heads/main/antwar.lua'))()
  end
end
