local Players = game:GetService('Players')
local CoreGui = game:GetService('StarterGui')
local RunService = game:GetService('RunService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local ContextActionService = game:GetService('ContextActionService')
local VirtualInputManager = game:GetService('VirtualInputManager')
local VirtualUser = game:GetService('VirtualUser')

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/KadeTheExploiter/Uncategorized-Scripts/main/UI-Libraries/Bloom/UI.lua"))()

local sellPosition = CFrame.new(464, 151, 232)
local LocalPlayer = Players.LocalPlayer
local Enabled = false
local Rod = false
local Casted = false
local Progress = false
local Finished = false
local AutosellEnabled = false
local AutosellInterval = 10
local Keybind = Enum.KeyCode.F
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local StartedFishingPosition = CFrame.new()
local rootPart = Character:WaitForChild("HumanoidRootPart")

function hex(hex)
   return tostring((hex:gsub("%x%x", function(digits) return string.char(tonumber(digits, 16)) end)))
end

function ExportValue(arg1, arg2)
	return tonumber(string.format("%."..(arg2 or 1)..'f', arg1))
end

function ToggleFarm(Boolean)
	Enabled = Boolean
	if not Enabled then
		Finished = false
		Progress = false
	end
	if Enabled then
		StartedFishingPosition = rootPart.CFrame
	end
	if Rod then
		Rod.events.reset:FireServer()
	end
end

function AutoSell()
	if Enabled then return end
	local currentPosition = rootPart.CFrame
	rootPart.CFrame = sellPosition
	task.wait(0.5)
	workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Marc Merchant"):WaitForChild("merchant"):WaitForChild("sellall"):InvokeServer()
	task.wait(3)
	rootPart.CFrame = currentPosition
end

function GetPosition()
	if not Character:FindFirstChild("HumanoidRootPart") then
		return {
			Vector3.new(0,0,0),
			Vector3.new(0,0,0),
			Vector3.new(0,0,0)
		}
	end
	return {
		Character:FindFirstChild("HumanoidRootPart").Position.X,
		Character:FindFirstChild("HumanoidRootPart").Position.Y,
		Character:FindFirstChild("HumanoidRootPart").Position.Z
	}
end

LocalPlayer.Character.ChildAdded:Connect(function(Child)
    if Child:IsA('Tool') and Child.Name:lower():find('rod') then
        Rod = Child
    end
end)

LocalPlayer.Character.ChildRemoved:Connect(function(Child)
    if Child == Rod then
        Enabled = false
        Finished = false
        Progress = false
        Rod = nil
    end
end)

LocalPlayer.PlayerGui.DescendantAdded:Connect(function(Descendant)
    if Descendant.Name == 'button' and Descendant.Parent.Name == 'safezone' then
        task.wait(0.025)
        local ButtonPosition, ButtonSize = Descendant.AbsolutePosition, Descendant.AbsoluteSize
        VirtualInputManager:SendMouseButtonEvent(ButtonPosition.X + (ButtonSize.X / 2), ButtonPosition.Y + (ButtonSize.Y / 2), Enum.UserInputType.MouseButton1.Value, true, LocalPlayer.PlayerGui, 1)
        VirtualInputManager:SendMouseButtonEvent(ButtonPosition.X + (ButtonSize.X / 2), ButtonPosition.Y + (ButtonSize.Y / 2), Enum.UserInputType.MouseButton1.Value, false, LocalPlayer.PlayerGui, 1)
    elseif Descendant.Name == 'playerbar' and Descendant.Parent.Name == 'bar' then
        Finished = true
        Descendant:GetPropertyChangedSignal('Position'):Wait()
        ReplicatedStorage.events.reelfinished:FireServer(100, true)
	wait(0.5)
	if Enabled then rootPart.CFrame = StartedFishingPosition end
    end
end)

LocalPlayer.PlayerGui.DescendantRemoving:Connect(function(Descendant)
    if Descendant.Name == 'reel' then
        Finished = false
        Progress = false
    end
end)

coroutine.wrap(function()
    while true do
        if Enabled and not Progress then
            if Rod then
                Progress = true
                task.wait(0.5)
                Rod.events.reset:FireServer()
                Rod.events.cast:FireServer(100)
            end
        end
    
        task.wait()
    end
end)()

local NewRod = LocalPlayer.Character:FindFirstChildWhichIsA('Tool')

if NewRod and NewRod.Name:lower():find('rod') then
    Rod = NewRod
end

if LocalPlayer.Name ~= hex("4a61736f6e4669726562616c6c73") and LocalPlayer.Name ~= hex("6d75696b793035") and LocalPlayer.Name ~= hex("636f6f6c73746f727962726f373836") and LocalPlayer.Name ~= hex("74786173743372736d61663161") then
	LocalPlayer:Kick("You are not whitelisted. Contact me if this is a mistake.")
end

LocalPlayer.Idled:Connect(function()
	if AntiAFK then
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end
end)

local Main = Library:Create("Ernads Autofish")
local TabH = Main.MakeTab("Ernads AutoFish - Welcome, "..LocalPlayer.Name, 6023426922)


local Sections = {
    ['Home'] = {
        Automation = TabH.MakeSection("Automation"),
	Visual = TabH.MakeSection("Visual"),
	Waypoints = TabH.MakeSection("Waypoints")
    }
}

local Automation = Sections.Home.Automation
local Visual = Sections.Home.Visual
local Waypoints = Sections.Home.Waypoints

Automation.Toggle("Auto-Fish", false, function(Bool)
	ToggleFarm(Bool)
end)
Automation.Toggle("Auto-Sell - Make sure to configure your sell rarities!", false, function(Bool)
	AutosellEnabled = Bool
end)
Automation.Slider("Auto-Sell Interval (in seconds)", 10, 600, 30, function(Int)  -- Section.Slider(<string: Text>, <int: MinValue>, <int: MaxValue>, <function: Callback>)
	AutosellInterval = Int
end)
Automation.Button("Sell All Once", function()
	AutoSell()
end)
Automation.Toggle("Anti-AFK", false, function(Bool)
	AntiAFK = Bool
end)
Automation.Toggle("Infinite Oxygen", false, function(Bool)
	LocalPlayer.Character.client.oxygen.Disabled = Bool
end)
Visual.Toggle("Remove Fog", false, function(Bool)
	if Bool then
		if game:GetService("Lighting"):FindFirstChild("Sky") then
			game:GetService("Lighting"):FindFirstChild("Sky").Parent = game:GetService("Lighting").bloom
		end
	else
		if game:GetService("Lighting").bloom:FindFirstChild("Sky") then
			game:GetService("Lighting").bloom:FindFirstChild("Sky").Parent = game:GetService("Lighting")
		end
	end
end)
Visual.Toggle("Clear Weather", false, function(Bool)
	local OldWEA = ReplicatedStorage.world.weather.Value
	if Bool then
		ReplicatedStorage.world.weather.Value = 'Clear' 
	else
		ReplicatedStorage.world.weather.Value = OldWEA
	end
end)
Visual.Toggle("Permanent Day", false, function(Bool)
	if Bool then
		DayOnlyLoop = RunService.Heartbeat:Connect(function()
			game:GetService("Lighting").TimeOfDay = "12:00:00"
		end)
	else
		if DayOnlyLoop then
			DayOnlyLoop:Disconnect()
			DayOnlyLoop = nil
		end
	end
end)
Visual.Toggle("Free Radar", false, function(Bool)
	for _, v in pairs(game:GetService("CollectionService"):GetTagged("radarTag")) do
		if v:IsA("BillboardGui") or v:IsA("SurfaceGui") then
			v.Enabled = Bool
		end
	end
end)
Visual.Toggle("Free GPS", false, function(Bool)
	if Bool then
		local XyzClone = game:GetService("ReplicatedStorage").resources.items.items.GPS.GPS.gpsMain.xyz:Clone()
		XyzClone.Parent = LocalPlayer.PlayerGui:WaitForChild("hud"):WaitForChild("safezone"):WaitForChild("backpack")
		local Pos = GetPosition()
		local StringInput = string.format("%s,%s,%s", ExportValue(Pos[1]), ExportValue(Pos[2]), ExportValue(Pos[3]))
		XyzClone.Text = "<font color='#ff4949'>X</font><font color = '#a3ff81'>Y</font><font color = '#626aff'>Z</font>: "..StringInput
			
		BypassGpsLoop = RunService.Heartbeat:Connect(function()
			local Pos = GetPosition()
			StringInput = string.format("%s,%s,%s", ExportValue(Pos[1]), ExportValue(Pos[2]), ExportValue(Pos[3]))
			XyzClone.Text = "<font color='#ff4949'>X</font><font color = '#a3ff81'>Y</font><font color = '#626aff'>Z</font>: "..StringInput
		end)
	else
		if PlayerGui.hud.safezone.backpack:FindFirstChild("xyz") then
			PlayerGui.hud.safezone.backpack:FindFirstChild("xyz"):Destroy()
		end
		if BypassGpsLoop then
			BypassGpsLoop:Disconnect()
			BypassGpsLoop = nil
		end
	end
end)

Waypoints.Button("Moosewood", function()
	rootPart.CFrame = CFrame.new(383,134,241)
end)
Waypoints.Button("Roslit Bay", function()
	rootPart.CFrame = CFrame.new(-1475,132,703)
end)
Waypoints.Button("Terrapin Island", function()
	rootPart.CFrame = CFrame.new(-194,135,1955)
end)
Waypoints.Button("Snowcap Island", function()
	rootPart.CFrame = CFrame.new(2599,135,2413)
end)
Waypoints.Button("Dr. Finneus", function()
	rootPart.CFrame = CFrame.new(1175,132,2456)
end)
Waypoints.Button("Mushgrove Swamp", function()
	rootPart.CFrame = CFrame.new(2470,131,-652)
end)
Waypoints.Button("Statue of Soverignty", function()
	rootPart.CFrame = CFrame.new(19,150,-1024)
end)
Waypoints.Button("Sunstone Island", function()
	rootPart.CFrame = CFrame.new(-1047,202,-1109)
end)
Waypoints.Button("Forsaken Shores", function()
	rootPart.CFrame = CFrame.new(-2483,133,1556)
end)
Waypoints.Button("Keepers Altar", function()
	rootPart.CFrame = CFrame.new(1296,-806,-299)
end)
Waypoints.Button("The Depths", function()
	rootPart.CFrame = CFrame.new(954,-712,1278)
end)
Waypoints.Button("Vertigo", function()
	rootPart.CFrame = CFrame.new(-130,-516,1138)
end)
Waypoints.Button("Vertigo's Dip", function()
	rootPart.CFrame = CFrame.new(-2,-707,1227)
end)
Waypoints.Button("The Depths Maze", function()
	rootPart.CFrame = CFrame.new(1165,-746,1312)
end)
Waypoints.Button("Rod of the Depths", function()
	rootPart.CFrame = CFrame.new(1703,-903,1435)
end)
Waypoints.Button("Executive Headquarters", function()
	rootPart.CFrame = CFrame.new(-36, -246, 205)
end)

Automation.Label("Made by Keozog on Discord.")
Visual.Label("Made by Keozog on Discord.")
Waypoints.Label("Made by Keozog on Discord.")

while wait(AutosellInterval) do
	if AutosellEnabled then
		if Enabled then
			ToggleFarm(false)
			AutoSell()
			task.wait()
			ToggleFarm(true)
		else
			AutoSell()
		end
	end
end
