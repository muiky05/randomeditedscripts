local Players = game:GetService('Players')
local VoiceChatService = game:GetService('VoiceChatService')
local key = game:GetService("UserInputService")
local vci = game:GetService("VoiceChatInternal")

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/KadeTheExploiter/Uncategorized-Scripts/main/UI-Libraries/Bloom/UI.lua"))()

local LocalPlayer = Players.LocalPlayer
local wl = false
local AutoBypass = false
local fakeSuspend = false
local freespeaktimer = 0

local wlTable = {
"muiky05",
"wesleyapollo",
"IMP0STER_SUSSY",
"arnoying",
"MetaQuestappstore",
"LISTEN_NOOBY",
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

Bypass.Button("Unsuspend VC", function()
	VoiceChatService:joinVoice()
	fakeSuspend = false
end)

Bypass.Button("Fake Suspension", function()
	vci:Leave()
	fakeSuspend = true
end)

Bypass.Toggle("Auto Unban", false, function(Bool)
	AutoBypass = Bool
end)

Bypass.Label("Made by Keozog on Discord.")

local thingy = true
local FreeSpeak = Bypass.Label("FreeSpeak")

while task.wait(1) do
	if freespeaktimer > 0 then
		freespeaktimer -= 1
	end
	thingy = not thingy
	FreeSpeak.UpdateLabel("Free Speak: " .. tostring(freespeaktimer))
	if vci.VoiceChatState ~= Enum.VoiceChatState.Joined and vci.VoiceChatState ~= Enum.VoiceChatState.Joining then
		if AutoBypass then
			VoiceChatService:joinVoice()
			fakeSuspend = false
		end
		if not fakeSuspend and freespeaktimer == 0 then
			freespeaktimer = 300
		end
	end
end
