local Players = game:GetService('Players')
local CoreGui = game:GetService('StarterGui')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local ContextActionService = game:GetService('ContextActionService')
local VirtualInputManager = game:GetService('VirtualInputManager')
local VirtualUser = game:GetService('VirtualUser')
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/KadeTheExploiter/Uncategorized-Scripts/main/UI-Libraries/Bloom/UI.lua"))()
local sellPosition = CFrame.new(464, 151, 232)

local LocalPlayer = Players.LocalPlayer

local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

function hex(hex)
   return tostring((hex:gsub("%x%x", function(digits) return string.char(tonumber(digits, 16)) end)))
end

function AutoSell()
	local currentPosition = rootPart.CFrame
	rootPart.CFrame = sellPosition
	task.wait(0.5)
	workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Marc Merchant"):WaitForChild("merchant"):WaitForChild("sellall"):InvokeServer()
	task.wait(3)
	rootPart.CFrame = currentPosition
end

local Enabled = false
local Rod = false
local Casted = false
local Progress = false
local Finished = false
local AutosellInterval = 10
local AutosellEnabled = false

function ToggleFarm(Boolean)
	Enabled = Boolean
	if not Enabled then
		Finished = false
		Progress = false
	end
	if Rod then
		Rod.events.reset:FireServer()
	end
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
        task.wait(0.1)
        local ButtonPosition, ButtonSize = Descendant.AbsolutePosition, Descendant.AbsoluteSize
        VirtualInputManager:SendMouseButtonEvent(ButtonPosition.X + (ButtonSize.X / 2), ButtonPosition.Y + (ButtonSize.Y / 2), Enum.UserInputType.MouseButton1.Value, true, LocalPlayer.PlayerGui, 1)
        VirtualInputManager:SendMouseButtonEvent(ButtonPosition.X + (ButtonSize.X / 2), ButtonPosition.Y + (ButtonSize.Y / 2), Enum.UserInputType.MouseButton1.Value, false, LocalPlayer.PlayerGui, 1)
    elseif Descendant.Name == 'playerbar' and Descendant.Parent.Name == 'bar' then
        Finished = true
        Descendant:GetPropertyChangedSignal('Position'):Wait()
        ReplicatedStorage.events.reelfinished:FireServer(100, true)
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

if LocalPlayer.Name ~= hex("4a61736f6e4669726562616c6c73") and LocalPlayer.Name ~= hex("6d75696b793035") then
	LocalPlayer:Kick("You are not whitelisted. Contact me if this is a mistake.")
end

LocalPlayer.Idled:Connect(function()
	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new())
end)

local Main = Library:Create("Ernads Autofish")
local TabH = Main.MakeTab("Ernads AutoFish - Welcome, "..LocalPlayer.Name, 6023426922)


local Sections = {
    ['Home'] = {
        Info = TabH.MakeSection("Automation")
    }
}

local Info = Sections.Home.Info

Info.Toggle("Auto-Sell", false, function(Bool)
	ToggleFarm(Bool)
end)
Info.Toggle("Auto-Sell - Make sure to configure your sell rarities!", false, function(Bool)
	AutosellEnabled = Bool
end)
Info.Slider("Auto-Sell Interval (in seconds)", 10, 600, function(Int)  -- Section.Slider(<string: Text>, <int: MinValue>, <int: MaxValue>, <function: Callback>)
	AutosellInterval = Int
end)
Info.Button("Sell All Once", function()
	AutoSell()
end)
Info.Toggle("Auto-Fish", false, ToggleFarm(Bool))
Info.Label("Made by Keozog on Discord.")
while wait(AutosellInterval) do
	if AutosellEnabled then
		AutoSell()
	end
end
