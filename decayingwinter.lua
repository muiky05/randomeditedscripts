local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/KadeTheExploiter/Uncategorized-Scripts/main/UI-Libraries/Bloom/UI.lua"))()
local Main = Library:Create("DecayingWinterUI") -- Library:Create(<string: Name>, <Color3: DetailColor>, <Color3: TextColor>)
local TabH = Main.MakeTab("Ernads Decaying Winter Hub - Hello, "..game.Players.LocalPlayer.Name, 6023426922)
local LocalPlayer = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local mainHandler = { instance = nil, senv = nil }
local IsRegenning
local RegenAmount
local Play = game:GetService("Workspace").ServerStuff.playAudio
local wl = false

local wlTable = {
"muiky05",
"bruh814653264",
"runeexecutorreal",
"arnoying",
"Metaquestappstore",
"bbclovey1",
}

for i = 1, #wlTable do
	if (wlTable[i] == Players.LocalPlayer.Name) then
		wl = true
	end
end
if wl == false then LocalPlayer:Kick("You are not whitelisted. Contact me if this is a mistake.") return end

local Sections = {
    ['Main'] = {
    Perks = TabH.MakeSection("Perks"),
	Spawnables = TabH.MakeSection("Spawnables"),
	Humanoids = TabH.MakeSection("Humanoids"),
	Sounds = TabH.MakeSection("Sounds"),
	Notes = TabH.MakeSection("Notes")
    }
}

local Perks = Sections.Main.Perks
local Spawnables = Sections.Main.Spawnables
local Humanoids = Sections.Main.Humanoids
local Sounds = Sections.Main.Sounds
local Notes = Sections.Main.Notes

Humanoids.Toggle("Enable Regeneration", false, function(Bool)
	IsRegenning = Bool
end)
Humanoids.Slider("Regeneration Strength", 1, 10, 1, function(Int)
    RegenAmount = Int
end)
Humanoids.Label("All strengths survive all guns.")
Humanoids.Label("3+ can survive Castle.")
Humanoids.Label("8+ can survive some explosives.")

Perks.Button("Custom Perks", function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local UserInputService = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")
	local StarterGui = game:GetService("StarterGui")
	local Lighting = game:GetService("Lighting")
	local Players = game:GetService("Players")

	local stuff = game.Workspace.InteractablesNoDel
	local gui = game.Players.LocalPlayer.PlayerGui.controlsGui
	local localplayer = game.Players.LocalPlayer
	local mainHandler = { instance = nil, senv = nil }
	local namecall = nil
	local waitTable = {}
	local tgas = {
   	     ["throwrating"] = 1,
       		["ability"] = "Can obscure vision.",
       		["blacklisted"] = false,
        	["animset"] = "THRW",
        	["desc"] = "Used by riot police! Yes, we still have those! We have many hired and stationed on site at all time " ..
        	    "and borrowed some of these!",
        	["weapontype"] = "Item",
        	["name"] = "Riot Grenade",
        	["damagerating"] = {
        	    [1] = 0,
        	    [2] = 0
        	},
        	["sizerating"] = 4,
        	["icon"] = "2520535457",
        	["woundrating"] = 2
	}

	function getkey()
	spawn(function()
	for _, instance in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
	    	if instance:IsA("LocalScript") and instance.Name ~= "ClickDetectorScript" then
			repeat
	    	        mainHandler = getsenv(instance)
	    	        RunService.Heartbeat:Wait()
			until mainHandler.afflictstatus ~= nil
			local upvalue = getupvalues(mainHandler.afflictstatus)
		        _G.serverKey = upvalue[16]
		        _G.playerKey = upvalue[17]
		end
	end
--// Virus blocking
for index, status in pairs(getupvalue(mainHandler.afflictstatus, 1)) do
    if string.match(index, "Virus") ~= nil then
        status.effects.currentduration = math.huge
    end
end
end)
end
--// parry
UserInputService.InputBegan:Connect(function(input, Typing)
    if Typing then
        return
    end
	if input.KeyCode == Enum.KeyCode.R then
	        for i=1, 10 do
            workspace.ServerStuff.initiateblock:FireServer(_G.serverKey, true)
	        end
	end
end)
--// stun
UserInputService.InputBegan:Connect(function(input, Typing)
    if Typing then
        return
    end
	if input.KeyCode == Enum.KeyCode.Y then
            local args = {
                [1] = "TGas",
                [2] = 20,
                [3] = game.Workspace.CurrentCamera.CFrame,
                [4] = 1,
                [5] = tgas,
                [6] = 1,
                [8] = _G.serverKey,
                [10] = _G.playerKey
            }

            workspace.ServerStuff.throwWeapon:FireServer(unpack(args))
    end
end)
-- // scan
UserInputService.InputBegan:Connect(function(input, Typing)
    if Typing then
        return
    end
	if input.KeyCode == Enum.KeyCode.B then
        	workspace.ServerStuff.applyGore:FireServer("scanarea", localplayer.Character, localplayer, {[1] = game.Workspace.CurrentCamera.CFrame})
    	end
end)
--// smoke
UserInputService.InputBegan:Connect(function(input, Typing)
    if Typing then
        return
    end
	if input.KeyCode == Enum.KeyCode.U then
	    workspace.ServerStuff.dealDamage:FireServer("fireSmoke", workspace.CurrentCamera.CFrame, _G.serverKey, _G.playerKey)
    end
end)
UserInputService.InputBegan:Connect(function(input, Typing)
    if Typing then
        return
    end
	if input.KeyCode == Enum.KeyCode.M then
	    for i=1, 1 do
            workspace.ServerStuff.dropAmmo:FireServer("rations", "MRE")
            workspace.ServerStuff.dropAmmo:FireServer("rations", "Bottle")
            workspace.ServerStuff.dropAmmo:FireServer("rations", "Beans")
              workspace.ServerStuff.dropAmmo:FireServer("rations", "Soda")
            wait(0.1)
        end
    end
end)
UserInputService.InputBegan:Connect(function(input, Typing)
    if Typing then
        return
    end
	if input.KeyCode == Enum.KeyCode.R then
	    for i=1, 10 do
            workspace.ServerStuff.initiateblock:FireServer(_G.serverKey, true)
	    end
	end
end)
local alert = Instance.new("Sound",game:GetService("SoundService"))
alert.SoundId = "rbxassetid://232127604"
--// controlsGui
gui.Enabled = false
loadstring(game:HttpGet("https://raw.githubusercontent.com/muiky05/randomeditedscripts/refs/heads/main/dwnotifs.lua"))()
function Callback(answer)
    if answer == "Yes" then
        wait(2)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/IrishBaker/scripts/main/decaying%20winter/Auto%20Finish.lua"))()
    elseif answer == "No" then
        print("Player rejected.")
    end
end
local Bindable = Instance.new("BindableFunction")
Bindable.OnInvoke = Callback
loadstring(game:HttpGet("https://raw.githubusercontent.com/IrishBaker/scripts/main/decaying%20winter/Longer%20Effects.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IrishBaker/scripts/main/decaying%20winter/Passive%20Heal.lua"))()
while true do
    getkey()
    wait(1)
end
end)

Spawnables.Slider("Spawn Scrap [NO COOLDOWN]", 1, 1000, 10, function(Int)
	game:GetService("Workspace").ServerStuff.dropAmmo:FireServer("scrap", Int)
end)

Spawnables.Button("Spawn MRE", function()
	game:GetService("Workspace").ServerStuff.dropAmmo:FireServer("rations", "MRE")
end)

Spawnables.Button("Spawn Bottle", function()
	game:GetService("Workspace").ServerStuff.dropAmmo:FireServer("rations", "Bottle")
end)

Perks.Button("Hacked Tanziner", function()
	local perks = require(workspace.ServerStuff.Statistics["CLASS_STATISTICS"])["shield"].basestats
	local perk = require(workspace.ServerStuff.Statistics["CLASS_STATISTICS"])["shield"]
	if perks then
		perk.name = "Tanziner"
		perk.desc = "You believe in art of technology."
		perk.pros = { "Immune to bleeding","Extra M1 Damage","Higher defense" }
		perk.cons = { "People will dislike you." }
		perk.activename = "Tanziner"
		perk.activedetails = "A Man from 2093."
		perks.atkmod = 1950 -- 2 taps any bosses
		perks.healthmod = 250
		perks.defmod = 1500 -- take 1 dmg per hit except explosion
		perks.stammod = 1950
		perks.shovemod = 1950
		perks.lightatkspeed = 100
		perks.heavyatkspeed = 1950 
		perks.recoilmod = 2000
		perks.harvestmod = 100
		perks.accmod = 1950
		perks.reloadmod = 250 
		perks.noaimmod = false 
		perks.bleed_immune = true
		perks.mvtmod = 100
		perks.aegisduration = math.huge
		perks.aegisdamagetakenmelee = 0
		perks.aegisrangeddamagemultiplier = 50
		perks.cooldown = 0
	end
end)

Perks.Button("Hacked Arbiter", function()
	local perks = require(workspace.ServerStuff.Statistics["CLASS_STATISTICS"])["shotgun"].basestats
	local perk = require(workspace.ServerStuff.Statistics["CLASS_STATISTICS"])["shotgun"]
	perk.name = "Arbiter but you're SQ"
	perk.desc = "UJEEUJ"
	perk.pros = { "More Ammunition.","Speed, No Fall Dmg, No Explosive dmg, and take barely any HP upon shot.","0 Cooldown","Faster Swings"};
	perk.cons = {"There are no downsides, you're just OP as hell."}
	perk.activename = "Arbiter.exe"
	perk.activedetails = "i dunno"
	perks.atkmod = 1950 -- 2 taps any bosses
	perks.healthmod = 250
	perks.defmod = 1500 -- take 1 dmg per hit except explosion
	perks.stammod = 1950
	perks.shovemod = 1950
	perks.lightatkspeed = 100
	perks.heavyatkspeed = 1950 
	perks.recoilmod = 2000
	perks.accmod = 1950
	perks.reloadmod = 900
	perks.noaimmod = false
	perks.scavmod = 4000
	perks.harvestmod = 100
	perks.mvtmod = 40
	explosive_resist = true
	perks.cripple_immune = true
	perks.exhaust_immune = true
	perks.frac_immune = true 
	perks.nomorale = true
	perks.explosivemod = 400
	perks.grap = true
	perks.bleed_immune = true
	perks.backpack = true
	perks.falldamagemod = true
	perks.craftcostmod = -55 
end)
Perks.Button("Hacked Hivemind", function()
        local perks = require(workspace.ServerStuff.Statistics["CLASS_STATISTICS"])["hive"].basestats
local perk = require(workspace.ServerStuff.Statistics["CLASS_STATISTICS"])["hive"]
    perk.name = "Hivemaster"
    perk.desc = "UJEEUJ"
    perk.pros = { "More Ammunition.","Speed, No Fall Dmg, No Explosive dmg, and take barely any HP upon shot.","0 Cooldown","Faster Swings"};
    perk.cons = {"There are no downsides, you're just OP as hell."}
   perk.activename = "Arbiter.exe"
   perk.activedetails = "i dunno"
   perks.atkmod = 1950 -- 2 taps any bosses
   perks.healthmod = 250
   perks.defmod = 1500 -- take 1 dmg per hit except explosion
   perks.stammod = 1950
   perks.shovemod = 1950
   perks.lightatkspeed = 100
    perks.heavyatkspeed = 1950 
    perks.recoilmod = 2000
    perks.accmod = 1950
     perks.reloadmod = 900
     perks.noaimmod = false
     perks.scavmod = 4000
     perks.harvestmod = 100
     perks.mvtmod = 40
     explosive_resist = true
     perks.cripple_immune = true
     perks.exhaust_immune = true
     perks.frac_immune = true 
     perks.nomorale = true
     perks.explosivemod = 400
     perks.grap = true
     perks.bleed_immune = true
    perks.backpack = true
    perks.falldamagemod = true
    perks.craftcostmod = -55 
end)

Spawnables.Button("Spawn Crafted: AKM", function()
        local workbench = workspace.Interactables:FindFirstChild("Workbench")
        game.Players.LocalPlayer.Character:PivotTo(workbench:GetPivot() + Vector3.new(0, 5, 0))
        local args = {
            [1] = workspace.Interactables.Workbench,
            [2] = "workbenchblueprintSUPAK",
        }
        
        game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args))
        wait(1.7)
        local args = {
            [1] = workspace.Interactables.Workbench,
            [2] = "workbench",
        }
        
        game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args))
        
end)

Spawnables.Button("Spawn Crafted: Fireier Axe", function()
        local workbench = workspace.Interactables:FindFirstChild("Workbench")
        game.Players.LocalPlayer.Character:PivotTo(workbench:GetPivot() + Vector3.new(0, 5, 0))
        local args = {
            [1] = workspace.Interactables.Workbench,
            [2] = "workbenchblueprintFAxe",
        }
        
        game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args))
        wait(1.7)
        local args = {
            [1] = workspace.Interactables.Workbench,
            [2] = "workbench",
        }
        
        game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args))
end)
Spawnables.Button("Spawn Crafted: The Decimator", function()
        local workbench = workspace.Interactables:FindFirstChild("Workbench")
        game.Players.LocalPlayer.Character:PivotTo(workbench:GetPivot() + Vector3.new(0, 5, 0))
        local args = {
            [1] = workspace.Interactables.Workbench,
            [2] = "workbenchblueprintRBHammer",
        }
        
        game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args))
        wait(1.7)
        local args = {
            [1] = workspace.Interactables.Workbench,
            [2] = "workbench",
        }
        
        game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args))
end)
Spawnables.Button("Spawn Crafted: A.J.M. 9", function()
        local workbench = workspace.Interactables:FindFirstChild("Workbench")
        game.Players.LocalPlayer.Character:PivotTo(workbench:GetPivot() + Vector3.new(0, 5, 0))
        local args = {
            [1] = workspace.Interactables.Workbench,
            [2] = "workbenchblueprintAJM",
        }
        
        game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args))
        wait(1.7)
        local args = {
            [1] = workspace.Interactables.Workbench,
            [2] = "workbench",
        }
        
        game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args))
end)
Spawnables.Button("Spawn Crafted: KSG", function()
        local workbench = workspace.Interactables:FindFirstChild("Workbench")
        game.Players.LocalPlayer.Character:PivotTo(workbench:GetPivot() + Vector3.new(0, 5, 0))
        local args = {
            [1] = workspace.Interactables.Workbench,
            [2] = "workbenchblueprintKSG",
        }
        
        game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args))
        wait(1.7)
        local args = {
            [1] = workspace.Interactables.Workbench,
            [2] = "workbench",
        }
        
        game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args))
end)
Spawnables.Button("Spawn Crafted: Maria", function()
        local workbench = workspace.Interactables:FindFirstChild("Workbench")
        game.Players.LocalPlayer.Character:PivotTo(workbench:GetPivot() + Vector3.new(0, 5, 0))
        local args = {
            [1] = workspace.Interactables.Workbench,
            [2] = "workbenchblueprintNailedB",
        }
        
        game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args))
        wait(1.7)
        local args = {
            [1] = workspace.Interactables.Workbench,
            [2] = "workbench",
        }
        
        game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args))
end)
Spawnables.Button("Spawn Crafted: Billhook", function()
        local workbench = workspace.Interactables:FindFirstChild("Workbench")
        game.Players.LocalPlayer.Character:PivotTo(workbench:GetPivot() + Vector3.new(0, 5, 0))
        local args = {
            [1] = workspace.Interactables.Workbench,
            [2] = "workbenchblueprintHook",
        }
        
        game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args))
        wait(1.7)
        local args = {
            [1] = workspace.Interactables.Workbench,
            [2] = "workbench",
        }
        
        game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args))
end)

Spawnables.Button("Spawn Crafted: Executioner", function()
        local workbench = workspace.Interactables:FindFirstChild("Workbench")
        game.Players.LocalPlayer.Character:PivotTo(workbench:GetPivot() + Vector3.new(0, 5, 0))
        local args = {
            [1] = workspace.Interactables.Workbench,
            [2] = "workbenchblueprintExec",
        }
        
        game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args))
        wait(1.7)
        local args = {
            [1] = workspace.Interactables.Workbench,
            [2] = "workbench",
        }
        
        game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args))
end)
--[[
Spawnables.Button("Duplicate Inventory", function()
        for i = 1, 10 do
            task.wait()
            workspace.ServerStuff.deathPlay:FireServer()
            task.wait()
        end
end)
]]--
        
Sounds.Button("Knights Theme", function()
    Play:FireServer({"songs", "holdout_bosses"}, "medieval", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Boss Themes";
    Text = "Playing - Knights Theme";
    Icon = "rbxassetid://6833114846";
    Duration = 4;
    })
end)
        
Sounds.Button("Zealot Theme", function()
    Play:FireServer({"songs", "holdout_bosses"}, "zealot", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Boss Themes";
    Text = "Playing - Zealot Theme";
    Icon = "rbxassetid://6833114846";
    Duration = 4;
    })
end)
Sounds.Button("Sickler Theme", function()
    Play:FireServer({"songs", "holdout_bosses"}, "sickler", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Boss Themes";
    Text = "Playing - Sickler Theme";
    Icon = "rbxassetid://6833114846";
    Duration = 4;
    })
end)
Sounds.Button("Sledge Queen Theme", function()
    Play:FireServer({"songs", "holdout_bosses"}, "sledge", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Boss Themes";
    Text = "Playing - Sledge Theme";
    Icon = "rbxassetid://6833114846";
    Duration = 4;
    })
end)
Sounds.Button("Yosef Theme", function()
    Play:FireServer({"songs", "holdout_bosses"}, "yosef", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Boss Themes";
    Text = "Playing - Yosef Theme";
    Icon = "rbxassetid://6833114846";
    Duration = 4;
    })
end)
Sounds.Button("Rhyer Theme", function()
    Play:FireServer({"songs", "holdout_bosses"}, "rhyer", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Boss Themes";
    Text = "Playing - Rhyer Theme";
    Icon = "rbxassetid://6833114846";
    Duration = 4;
    })
end)
Sounds.Button("Bad Business Theme", function()
    Play:FireServer({"songs", "holdout_bosses"}, "bad", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Boss Themes";
    Text = "Playing - Bad Theme";
    Icon = "rbxassetid://6833114846";
    Duration = 4;
    })
end)
        
Sounds.Button("ScavFinal Theme", function()
    Play:FireServer({"songs"}, "scavfinal", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Theme";
    Text = "Playing - Scavfinal Theme";
    Icon = "rbxassetid://6833114846";
    Duration = 4;
    })
end)
        
Sounds.Button("Scav Wars Theme", function()
    Play:FireServer({"songs"}, "scavwar", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Theme";
    Text = "Playing - Scavwars Theme";
    Icon = "rbxassetid://6833114846";
    Duration = 4;
    })
end)
        
Sounds.Button("Final Theme", function()
    Play:FireServer({"songs"}, "final", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Theme";
    Text = "Playing - Final Theme";
    Icon = "rbxassetid://6833114846";
    Duration = 4;
    })
end)
        
Sounds.Button("Ending Credits Theme", function()
    Play:FireServer({"songs"}, "unused2", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Theme";
    Text = "Playing - End Theme";
    Icon = "rbxassetid://6833114846";
    Duration = 4;
    })
end)
        
Sounds.Button("Unused Theme", function()
    Play:FireServer({"songs"}, "unused1", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Theme";
    Text = "Playing - Unused Theme";
    Icon = "rbxassetid://6833114846";
    Duration = 4;
    })
end)
        
Sounds.Button("Juggernaut", function()
    Play:FireServer({"gamemode"}, "juggernaut", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Random";
    Text = "Playing - Juggernaut";
    Icon = "rbxassetid://6833114846";
    Duration = 4;
    })
end)
        
Sounds.Button("Bloodrush", function()
    Play:FireServer({"gamemode"}, "bloodrush", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Random";
    Text = "Playing - Bloodrush";
    Icon = "rbxassetid://6833114846";
    Duration = 4;
    })
end)
        
Sounds.Button("Gamemode A", function()
    Play:FireServer({"gamemode"}, "gamemodeA", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Random";
    Text = "Playing - GamemodeA";
    Icon = "rbxassetid://6833114846";
    Duration = 4;
    })
end)
        
Sounds.Button("Gamemode A", function()
    Play:FireServer({"gamemode"}, "gamemodeB", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Random";
    Text = "Playing - GamemodeB";
    Icon = "rbxassetid://6833114846";
    Duration = 4;
    })
end)
        
Sounds.Button("Gamemode C", function()
    Play:FireServer({"gamemode"}, "gamemodeC", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Random";
    Text = "Playing - GamemodeC";
    Icon = "rbxassetid://6833114846";
    Duration = 4;
    })
end)
        
Sounds.Button("Horn", function()
    Play:FireServer({"gamemode"}, "horn", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Random";
    Text = "Playing - Horn";
    Icon = "rbxassetid://6833114846";
    Duration = 4;
    })
end)
        
Sounds.Button("Kill Switch", function()
    Play:FireServer({"events", "survevents"}, "killswitch", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Events";
    Text = "Playing - KillSwitch";
    Icon = "rbxassetid://6833114846";
    Duration = 4;
    })
end)
        
Sounds.Button("Flareraid", function()
    Play:FireServer({"events", "survevents"}, "flareraid", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Events";
    Text = "Playing - Flareraid";
    Icon = "rbxassetid://6833114846";
    Duration = 4;
    })
end)
        
Sounds.Button("Bloodrush Event", function()
    Play:FireServer({"events", "survevents"}, "bloodrush", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Events";
    Text = "Playing - Bloodrush";
    Icon = "rbxassetid://6833114846";
    Duration = 4;
    })
end)
        
Sounds.Button("Thunder", function()
    Play:FireServer({"events", "survevents"}, "thunder", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Events";
    Text = "Playing - Thunder";
    Icon = "rbxassetid://6833114846";
    Duration = 4;
    })
end)
        
Sounds.Button("Exotic", function()
    Play:FireServer({"events", "survevents"}, "exotic", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Events";
    Text = "Playing - Exotic";
    Icon = "rbxassetid://6833114846";
    Duration = 4;
    })
end)
        
Sounds.Button("Monte", function()
    Play:FireServer({"events", "survevents"}, "monte", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Events";
	Text = "Playing - Monte";
    Icon = "rbxassetid://6833114846";
    Duration = 4;
    })
end)
        
Sounds.Button("Flare Trap", function()
    Play:FireServer({"world_item"}, "trap_flare1", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Trigger";
    Text = "Triggering - Flare";
    Icon = "rbxassetid://6833114846";
    Duration = 1;
    })
end)
        
Sounds.Button("Flare Trap 2", function()
    Play:FireServer({"world_item"}, "trap_flare2", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Trigger";
    Text = "Triggering - Flare2";
    Icon = "rbxassetid://6833114846";
    Duration = 1;
    })
end)
        
Sounds.Button("Dynamite Trap", function()
    Play:FireServer({"world_item"}, "trap_fuse", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Trigger";
    Text = "Triggering - Flare";
    Icon = "rbxassetid://6833114846";
    Duration = 1;
    })
end)
        
Sounds.Button("Firebomb", function()
    Play:FireServer({"world_item"}, "firebomb", workspace)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Trigger";
    Text = "Triggering - Firebomb";
    Icon = "rbxassetid://6833114846";
    Duration = 1;
    })
end)

Sounds.Dropdown("Taunt", {"taunt_1", "taunt_2", "taunt_3", "taunt_4", "taunt_5", "taunt_6", "taunt_7", "taunt_8", "taunt_9"}, function(String)
    Play:FireServer({"ai", "boss"}, String, workspace)
end)
Sounds.Dropdown("Hurt", {"hurt_1", "hurt_2", "hurt_3", "hurt_4"}, function(String)
    Play:FireServer({"ai", "boss"}, String, workspace)
end)
        
Sounds.Button("Big Hurt", function()
    Play:FireServer({"ai", "boss"}, "big_hurt", workspace)
end)
        
Sounds.Button("Introduction", function()
    Play:FireServer({"ai", "boss"}, "intro_1", workspace)
end)
        
Sounds.Button("Introduction2", function()
    Play:FireServer({"ai", "boss"}, "intro_2", workspace)
end)
        
Sounds.Button("Gameover", function()
    Play:FireServer({"ai", "boss"}, "game_over1", workspace)
end)
        
Sounds.Button("Gameover2", function()
    Play:FireServer({"ai", "boss"}, "game_over2", workspace)
end)
        
Sounds.Button("Behold Power of an Angel", function()
    Play:FireServer({"ai", "boss"}, "behold", workspace)
end)
        
Sounds.Button("Enough", function()
    Play:FireServer({"ai", "boss"}, "enough", workspace)
end)
        
Sounds.Button("Woes", function()
    Play:FireServer({"ai", "boss"}, "woes", workspace)
end)

Sounds.Dropdown("Begin", {"begin1", "begin2", "begin3"}, function(String)
   Play:FireServer({"events", "emperor"}, String, workspace)
end)

Sounds.Dropdown("Blocked", {"blocked1", "blocked2", "blocked3", "blocked4", "blocked5"}, function(String)
   Play:FireServer({"events", "emperor"}, String, workspace)
end)

Sounds.Dropdown("Chatter", {"chatter1", "chatter2", "chatter3", "chatter4", "chatter5"}, function(String)
   Play:FireServer({"events", "emperor"}, String, workspace)
end)

Sounds.Dropdown("Confirm", {"confirm1", "confirm2", "confirm3", "confirm4", "confirm5"}, function(String)
   Play:FireServer({"events", "emperor"}, String, workspace)
end)

Sounds.Dropdown("Lowhealth", {"lowhealth1", "lowhealth2", "lowhealth3"}, function(String)
   Play:FireServer({"events", "emperor"}, String, workspace)
end)

Sounds.Dropdown("Arrive", {"arrive1", "arrive2", "arrive3"}, function(String)
   Play:FireServer({"voices", "ilija", "arrive"}, String, workspace)
end)

Sounds.Dropdown("Quip", {"quip1", "quip2", "quip3", "quip4", "quip5"}, function(String)
   Play:FireServer({"voices", "ilija", "quip"}, String, workspace)
end)

Sounds.Dropdown("End", {"end1", "end2", "end3"}, function(String)
   Play:FireServer({"voices", "ilija", "end"}, String, workspace)
end)

Sounds.Dropdown("Reload", {"reload1", "reload2", "reload3", "reload4", "reload5", "reload6", "reload7", "reload8", "reload9"}, function(String)
   Play:FireServer({"voices", "ilija", "reload"}, String, workspace)
end)

Sounds.Dropdown("Shot", {"shot1", "shot2", "shot3", "shot4", "shot5", "shot6", "shot7", "shot8", "shot9", "shot10", "shot11"}, function(String)
   Play:FireServer({"voices", "ilija", "shot"}, String, workspace)
end)

Sounds.Dropdown("Stormenter", {"storm1", "storm2"}, function(String)
	Play:FireServer({"AGENT", "stormenter"}, String, workspace)
end)

Sounds.Dropdown("Stormleave", {"storm1", "storm2"}, function(String)
	Play:FireServer({"AGENT", "stormleave"}, String, workspace)
end)

Sounds.Dropdown("Hostile", {"hostile1", "hostile2", "hostile3", "hostile4", "hostile5", "hostile6", "hostile7", "hostile8"}, function(String)
	Play:FireServer({"AGENT", "hostile"}, String, workspace)
end)

Sounds.Dropdown("Heavy", {"heavy1", "heavy2"}, function(String)
	Play:FireServer({"AGENT", "heavy"}, String, workspace)
end)

Sounds.Dropdown("Join", {"join1", "join2", "join3"}, function(String)
	Play:FireServer({"AGENT", "join"}, String, workspace)
end)

Sounds.Dropdown("Left", {"left1", "left2", "left3"}, function(String)
	Play:FireServer({"AGENT", "left"}, String, workspace)
end)

Sounds.Dropdown("Down", {"down1", "down2"}, function(String)
	Play:FireServer({"AGENT", "down"}, String, workspace)
end)

Sounds.Dropdown("High Value Target", {"hvt1", "hvt2", "hvt3"}, function(String)
	Play:FireServer({"AGENT", "hvt"}, String, workspace)
end)

Sounds.Dropdown("Lowhealth", {"lowhealth1", "lowhealth2", "lowhealth3"}, function(String)
	Play:FireServer({"AGENT", "lowhealth"}, String, workspace)
end)

Sounds.Dropdown("Echo Start", {"start1", "start2"}, function(String)
	Play:FireServer({"AGENT", "echo_start"}, String, workspace)
end)

Sounds.Button("Sickler Scream", function()
	Play:FireServer({"shadow"}, "alert", workspace)
end)

Sounds.Button("Chainbreak", function()
	Play:FireServer({"shadow"}, "chainbreak", workspace)
end)

Sounds.Button("Sickler Theme", function()
	Play:FireServer({"shadow"}, "sickler_song", workspace)
end)
        
Sounds.Button("Sickler Crying", function()
	Play:FireServer({"shadow"}, "sickler_idle", workspace)
end)

Sounds.Dropdown("Sickler", {"sickler_noise1", "sickler_noise2", "sickler_noise3"}, function(String)
	Play:FireServer({"shadow"}, String, workspace)
end)

Sounds.Dropdown("Skinner Voice", {"skinner_noise1", "skinner_noise2", "skinner_noise3", "skinner_noise4", "skinner_noise5"}, function(String)
	Play:FireServer({"shadow"}, String, workspace)
end)

Sounds.Dropdown("Hanger Alert", {"alert1", "alert2", "alert3"}, function(String)
	Play:FireServer({"shadow", "hang"}, String, workspace)
end)
        
Sounds.Button("Influence", function()
        Play:FireServer({"shadow", "hang"}, "influence1", workspace)
end)
        
Sounds.Button("Influence2", function()
        Play:FireServer({"shadow", "hang"}, "influence2", workspace)
end)
        
Sounds.Button("Possessed Sound", function()
	Play:FireServer({"shadow", "hang"}, "cast", workspace)
end)
        
Sounds.Button("Resist Possession", function()
        Play:FireServer({"shadow", "hang"}, "resist", workspace)
end)
        
Sounds.Button("Hidden Attack Sound", function()
	Play:FireServer({"events", "hiddenB"}, "attack", workspace)
end)

Sounds.Dropdown("Voicelines", {"taunt1", "taunt2", "taunt3", "taunt4"}, function(String)
	Play:FireServer({"events", "hiddenB"}, String, workspace)
end)

Humanoids.Button("Infinite Stamina", function()
        repeat
            task.wait()
        until game.Players.LocalPlayer.PlayerGui.mainHUD.StaminaFrame:FindFirstChild("TextLabel") ~= nil
        
        if game.Players.LocalPlayer.PlayerGui.mainHUD.StaminaFrame == nil then
            return
        end
        
        function GrabMainScript()
            for _, instance in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if instance:IsA("LocalScript") and instance.Name ~= "ClickDetectorScript" then
                    return instance
                end
            end
        end
        
        local func
        local script = GrabMainScript()
        for i, v in pairs(getreg()) do
            if type(v) == "function" and getfenv(v).script then
                if getfenv(v).script == script then
                    local upvalues = getupvalues(v)
                    if
                        tostring(upvalues[3]) ==
                            tostring(game.Players.LocalPlayer.PlayerGui.mainHUD.StaminaFrame:FindFirstChild("TextLabel").Text)
                     then
                        func = v
                    end
                end
            end
        end
        spawn(
            function()
                repeat
                    setupvalue(func, 3, math.huge)
                    task.wait()
                until game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health <= 0
            end
        )
end)

Humanoids.Button("Control Sledge Queen [Use IY commands]", function()
        local controlling = workspace.activeHostiles["AI_QUEEN"]
        local friendly = true
        game.Players.LocalPlayer.Character = controlling
        workspace.CurrentCamera.CameraSubject = controlling
        workspace.CurrentCamera.CameraType = "Custom"
        local player = game.Players.LocalPlayer
        LocalPlayer = game.Players.LocalPlayer
        Players = game:GetService("Players")
        RunService = game:GetService("RunService")
        local lp = game.Players.LocalPlayer
        local gui = lp.PlayerGui
        local rs = game.ReplicatedStorage
        local ms = lp:GetMouse()
        controlling.Humanoid:GetPropertyChangedSignal("WalkToPoint"):Connect(function()
            controlling.Humanoid.WalkToPoint = controlling.HumanoidRootPart.Position
        end)
                if controlling:FindFirstChild("HumanoidRootPart") then
                    if workspace.speccingPlayers[game.Players.LocalPlayer.Name].HumanoidRootPart:FindFirstChild("BodyPosition") then
        workspace.speccingPlayers[game.Players.LocalPlayer.Name].HumanoidRootPart:FindFirstChild("BodyPosition"):Destroy()
        end
            workspace.speccingPlayers[game.Players.LocalPlayer.Name].HumanoidRootPart.Anchored = false
        workspace.speccingPlayers[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame = controlling.HumanoidRootPart.CFrame - Vector3.new(0,10,0)
        wait(0.2)
         --[[spawn(function()
            game:GetService('RunService').Stepped:connect(function()
                workspace.speccingPlayers[game.Players.LocalPlayer.Name].Humanoid:ChangeState(11)
                end)
            end)--]]
        spawn(function()
            local lp = game:GetService("Players").LocalPlayer
        local c = workspace.speccingPlayers[game.Players.LocalPlayer.Name]
        local hrp0 = c:FindFirstChild("HumanoidRootPart")
        local hrp1 = hrp0:Clone()
        c.Parent = nil
        hrp0.Parent = hrp1
        hrp0.RootJoint.Part0 = nil
        hrp1.Parent = c
        local h = game:GetService("RunService").Heartbeat
        c.Parent = workspace
        spawn(function()
        
        hrp0.Transparency = 0.5
        while h:Wait() and c and c.Parent do
            hrp0.CFrame = hrp1.CFrame
            hrp0.Orientation += Vector3.new(0, 0, 180)
            hrp0.Position = controlling.HumanoidRootPart.Position - Vector3.new(0,10,0)
            hrp0.Velocity = hrp1.Velocity
        end
        end)
        end)
        
        end
end)

Notes.Label("It is HIGHLY reccomended to use Infinite Yield for this!")
Notes.Button("Inject Infinite Yield", function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)
Notes.Label("Hub made by Keozog on Discord")

local serverkey
local playerkey
local delaygetkey

while task.wait() do
	if not delaygetkey then delaygetkey = 0 end
	if IsRegenning then
		if RegenAmount == nil then RegenAmount = 1 end
		for i = 1, RegenAmount do
			game.Workspace.ServerStuff.dealDamage:FireServer("Regeneration", nil, serverkey, playerkey)
		end
		delaygetkey += 1
		if delaygetkey == 50 then
			print("got key")
			spawn(function()
				for _, instance in pairs(LocalPlayer.Backpack:GetChildren()) do
	    				if instance:IsA("LocalScript") and instance.Name ~= "ClickDetectorScript" then
						repeat
							mainHandler = getsenv(instance)
	    						RunService.Heartbeat:Wait()
						until mainHandler.afflictstatus ~= nil
						local upvalue = getupvalues(mainHandler.afflictstatus)
		        			serverkey = upvalue[16]
		        			playerkey = upvalue[17]
					end
				end
			end)
			delaygetkey = 0
		end
	end
end
