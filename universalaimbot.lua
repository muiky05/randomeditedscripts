local Players = cloneref(game:GetService("Players"))

--[[
local wl = false

local wlTable = {
"muiky05",
"bruh814653254",
"MetaQuestappstore",
"glupayeden",
"emrahabot",
}

for i = 1, #wlTable do
	if (wlTable[i] == Players.LocalPlayer.Name) then
		wl = true
	end
end
if wl == false then Players.LocalPlayer:Kick("You are not whitelisted. Contact me if this is a mistake.") end
]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/KadeTheExploiter/Uncategorized-Scripts/main/UI-Libraries/Bloom/UI.lua"))()
local VirtualInputManager = cloneref(game:GetService("VirtualInputManager"))
repeat task.wait() until Players.LocalPlayer.Character
local CharacterFolder = Players.LocalPlayer.Character.Parent
local Main = Library:Create("Main")
local TabH = Main.MakeTab("Ernads Universal Aimbot - Welcome, "..Players.LocalPlayer.Name, 6023426922)

local Sections = {
    ['Home'] = {
        ESP = TabH.MakeSection("ESP"),
	Aimbot = TabH.MakeSection("Aimbot")
    },
}

local maxdist = 0
local isEsping = false
local tween = nil
local triggering = false
local aimbotting = false
local teamcheck = false
local godcheck = false
local friendcheck = false
--local aimpart = Enum.Keycode.MouseRightButton

local ESP = Sections.Home.ESP
local Aimbot = Sections.Home.Aimbot

ESP.Toggle("Toggle ESP", false, function(Bool)
	isEsping = Bool
end)
ESP.Slider("Max ESP Distance", 0, 2500, 0, function(Int)
	maxdist = Int
end)
--[[
Aimbot.Toggle("Aim-Bot", false, function(Bool)
	aimbotting = Bool
end)
]]
Aimbot.Toggle("Trigger-Bot", false, function(Bool)
	triggering = Bool
end)
--[[
Info.Dropdown("Aim Part", {"Head", "HumanoidRootPart"}, function(String)
	aimpart = String
end)
Info.Textbox("Aim Key", function(String)
	if Enum.Keycode[String] then
		aimpart = Enum.Keycode[String]
	end
end)
]]
Aimbot.Toggle("Team Check", false, function(Bool)
	teamcheck = Bool
end)
Aimbot.Toggle("God Check", false, function(Bool)
	teamcheck = Bool
end)
Aimbot.Toggle("Friend Check", false, function(Bool)
	friendcheck = Bool
end)

ESP.Label("Made by Keozog on Discord.")
--[[
Aimbot.Label("Aimbot doesn't shoot for you!")
Aimbot.Label("You can combine both bots to achieve this.")
]]
Aimbot.Label("Made by Keozog on Discord.")

while task.wait() do
	local Mouse = Players.LocalPlayer:GetMouse()
	for i, v in CharacterFolder:GetChildren() do
		if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			local dist = (v.HumanoidRootPart.Position - Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
			if isEsping and not v:FindFirstChild("Highlight") and dist < maxdist and v.Name ~= Players.LocalPlayer.Character.Name then
				local Highlight = Instance.new("Highlight")
				Highlight.FillTransparency = 1
				if Players:FindFirstChild(v.Name).Team then
					Highlight.OutlineColor = Players:FindFirstChild(v.Name).Team.TeamColor.Color
				end
				Highlight.Parent = v
			elseif v:FindFirstChild("Highlight") then
				if Players:FindFirstChild(v.Name).Team then
					v.Highlight.OutlineColor = Players:FindFirstChild(v.Name).Team.TeamColor.Color
				end
				if dist > maxdist or not isEsping then
					v:FindFirstChild("Highlight"):Destroy()
				end
			end
		end
	end
	if Mouse and Mouse.Target and triggering and Mouse.Target.Parent:FindFirstChild('Humanoid') and Mouse.Target.Parent.Humanoid.Health > 0 then
		if teamcheck then
			if Players:FindFirstChild(Mouse.Target.Parent.Name).Team ~= Players.LocalPlayer.Team then
				if godcheck then
					if Mouse.Target.Parent.Humanoid.Health ~= math.huge then
						if friendcheck then
							if not Players:FindFirstChild(Mouse.Target.Parent.Name):IsFriendsWith(Players.LocalPlayer.UserId) then
								VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, true, game, 1)
								wait(math.random(30, 60)/1000)
           							VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, false, game, 1)
							end
						else
							VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, true, game, 1)
							wait(math.random(30, 60)/1000)
           						VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, false, game, 1)
						end
					end
				else
					if friendcheck then
						if not Players:FindFirstChild(Mouse.Target.Parent.Name):IsFriendsWith(Players.LocalPlayer.UserId) then
							VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, true, game, 1)
							wait(math.random(30, 60)/1000)
           						VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, false, game, 1)
						end
					else
						VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, true, game, 1)
						wait(math.random(30, 60)/1000)
           					VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, false, game, 1)
					end
				end
			end
		else
			if godcheck then
				if Mouse.Target.Parent.Humanoid.Health ~= math.huge and not Mouse.Target.Parent:FindFirstChild("ForceField") then
					if friendcheck then
						if not Players:FindFirstChild(Mouse.Target.Parent.Name):IsFriendsWith(Players.LocalPlayer.UserId) then
							VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, true, game, 1)
							wait(math.random(30, 60)/1000)
           						VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, false, game, 1)
						end
					else
						VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, true, game, 1)
						wait(math.random(30, 60)/1000)
           					VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, false, game, 1)
					end
				end
			else
				if friendcheck then
					if not Players:FindFirstChild(Mouse.Target.Parent.Name):IsFriendsWith(Players.LocalPlayer.UserId) then
						VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, true, game, 1)
						wait(math.random(30, 60)/1000)
           					VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, false, game, 1)
					end
				else
					VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, true, game, 1)
					wait(math.random(30, 60)/1000)
           				VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, false, game, 1)
				end
			end
		end
	end
end
