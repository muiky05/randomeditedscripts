local Players = game:GetService('Players')
local VoiceChatService = game:GetService('VoiceChatService')

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/KadeTheExploiter/Uncategorized-Scripts/main/UI-Libraries/Bloom/UI.lua"))()

local LocalPlayer = Players.LocalPlayer
local wl = false

local wlTable = {
"muiky05",
}

for i = 1, #wlTable do
	if (wlTable[i] == Players.LocalPlayer.Name) then
		wl = true
	end
end
if wl == false then LocalPlayer:Kick("You are not whitelisted. Contact me if this is a mistake.") end

local Main = Library:Create("Ernads VC Bypasser")
local TabH = Main.MakeTab("Ernads VC Bypasser - Welcome, "..LocalPlayer.Name, 6023426922)


local Sections = {
    ['Home'] = {
        Bypass = TabH.MakeSection("Bypass"),
    }
}

local Bypass = Sections.Home.Bypass

Bypass.Button("Unban VC", function()
  VoiceChatService:joinVoice()
end)

Bypass.Label("Made by Keozog on Discord.")
