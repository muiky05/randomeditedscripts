local Players = game:GetService('Players')
local CoreGui = game:GetService('StarterGui')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local ContextActionService = game:GetService('ContextActionService')
local VirtualInputManager = game:GetService('VirtualInputManager')

local LocalPlayer = Players.LocalPlayer

local Enabled = false
local Rod = false
local Casted = false
local Progress = false
local Finished = false

local Keybind = Enum.KeyCode.F

function ShowNotification(String)
    CoreGui:SetCore('SendNotification', {
        Title = 'Ernads AutoFish',
        Text = String,
        Duration = 2
    })
end

function ToggleFarm(Name, State, Input)
    if State == Enum.UserInputState.Begin then
        Enabled = not Enabled
        if not Enabled then
            Finished = false
            Progress = false
            
            if Rod then
                Rod.events.reset:FireServer()
            end
        end
        
        ShowNotification(`{Enabled}`)
    end
end

LocalPlayer.Character.ChildAdded:Connect(function(Child)
    if Child:IsA('Tool') and Child.Name:lower():find('rod') then
        Rod = Child
		ShowNotification(`Rod equipped`)
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
				ShowNotification(`Rod Thrown`)
            end
        end
    
        task.wait()
    end
end)()

local NewRod = LocalPlayer.Character:FindFirstChildWhichIsA('Tool')

if NewRod and NewRod.Name:lower():find('rod') then
    Rod = NewRod
end

if LocalPlayer.Name == "muiky05" then
	ContextActionService:BindAction('ToggleFarm', ToggleFarm, false, Keybind)
	ShowNotification(`Hello Jason!`)
	ShowNotification(`Press '{Keybind.Name}' to enable.`)
else
	ShowNotification(`You are not whitelisted.`)
	wait(5)
	LocalPlayer:Kick("You are not whitelisted. Contact me if this is a mistake.")
end
