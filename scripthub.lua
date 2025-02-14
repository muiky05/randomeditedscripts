local GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local HS = game:GetService("HttpService")
local WebhookURL = "https://webhook.lewisakura.moe/api/webhooks/1339775663472640164/VZRhlXstsTTenw7fBpxPjWyyjhGgdKNmEp4orSaRU3Aos5eWalDFpgf3aEQJj69wP2Mu" --if ur somehow here, you can go ahead and wreck the webhook, props to you, but i will end up just making a new one
--why target me anyways? lol go ham tho

local MessageData = {
	["content"] = game.Players.LocalPlayer.Name .. "ran the hub in " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. " (" .. tostring(game.PlaceId) .. ")"
}
MessageData = HS:JSONEncode(MessageData)
HS:PostAsync(WebhookURL,MessageData)

if game.PlaceId == 16732694052 then
  loadstring(game:HttpGet('https://raw.githubusercontent.com/muiky05/randomeditedscripts/refs/heads/main/autofish.lua'))()
elseif game.PlaceId == 13438553315 then
  loadstring(game:HttpGet('https://raw.githubusercontent.com/muiky05/randomeditedscripts/refs/heads/main/decayingwinter.lua'))()
elseif game.PlaceId == 11157166793 then
  loadstring(game:HttpGet('https://raw.githubusercontent.com/muiky05/randomeditedscripts/refs/heads/main/antwar.lua'))()
else
  loadstring(game:HttpGet('https://raw.githubusercontent.com/muiky05/randomeditedscripts/refs/heads/main/vcbypass.lua'))()
end
