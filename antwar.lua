local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/KadeTheExploiter/Uncategorized-Scripts/main/UI-Libraries/Bloom/UI.lua"))()
local Main = Library:Create("Ernads Ant War GUI")
local TabH = Main.MakeTab("Ernads Ant War GUI - Welcome, "..game.Players.LocalPlayer.Name, 6023426922)


local Sections = {
    ['Home'] = {
        Main = TabH.MakeSection("Main")
    }
}

local Main = Sections.Home.Main
local killaura

Main.Toggle("Auto-Attack (+Attack Speed)", false, function(Bool)
	killaura = Bool
end)

local function findClosestPlayer()
    local myPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local distance = (myPosition - character.HumanoidRootPart.Position).magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end
end

while task.wait(0.1) do
  local closestPlayer = findClosestPlayer()
    if closestPlayer then
    	local args = {
    	    [1] = "Bite",
    	    [2] = closestPlayer.Character.Humanoid,
    	    [3] = closestPlayer.Character.BiteHitbox
    	}
      if killaura == true then
    	  game:GetService("ReplicatedStorage").ServerEvents.Bite:FireServer(unpack(args))
      end
    end
end
