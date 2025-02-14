local msg = ({
	["content"] = "",
	["embeds"] = {{
		["title"] = "Script Ran",
		["description"] = game.Players.LocalPlayer.Name.." ran the hub.",
		["type"] = "rich",
		["color"] = tonumber(0xffffff),
	}}
})

request = http_request or request or HttpPost or syn.request
request({
	Url = "https://webhook.lewisakura.moe/api/webhooks/1339775663472640164/VZRhlXstsTTenw7fBpxPjWyyjhGgdKNmEp4orSaRU3Aos5eWalDFpgf3aEQJj69wP2Mu",
	Method = "POST",
	Headers = {
		["Content-Type"] = "application/json",
	},
	Body = game:GetService("HttpService"):JSONEncode(msg),
})
print("ran")

if game.PlaceId == 16732694052 then
  loadstring(game:HttpGet('https://raw.githubusercontent.com/muiky05/randomeditedscripts/refs/heads/main/autofish.lua'))()
elseif game.PlaceId == 13438553315 then
  loadstring(game:HttpGet('https://raw.githubusercontent.com/muiky05/randomeditedscripts/refs/heads/main/decayingwinter.lua'))()
elseif game.PlaceId == 11157166793 then
  loadstring(game:HttpGet('https://raw.githubusercontent.com/muiky05/randomeditedscripts/refs/heads/main/antwar.lua'))()
else
  loadstring(game:HttpGet('https://raw.githubusercontent.com/muiky05/randomeditedscripts/refs/heads/main/vcbypass.lua'))()
end
