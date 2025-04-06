local Workspace = game:FindFirstChildOfClass("Workspace")

local offsets = {
	Vector3.new(5, 0, 0),
	Vector3.new(-5, 0, 0),
	Vector3.new(0, 0, 5),
	Vector3.new(0, 0, -5),
	Vector3.new(5, 0, 5),
	Vector3.new(5, 0, -5),
	Vector3.new(-5, 0, 5),
	Vector3.new(-5, 0, -5),
}

local function vecToKey(vec)
	return string.format("%0.1f,%0.1f,%0.1f", vec.X, vec.Y, vec.Z)
end

task.spawn(function()
	while task.wait(0.4) do
		local parts = Workspace.Flag.Parts:GetChildren()

		local positionMap = {}
		for _, part in ipairs(parts) do
			positionMap[vecToKey(part.Position)] = part
		end

		for _, v in ipairs(parts) do
			local numberGui = v:FindFirstChild("NumberGui")
			if numberGui then
				local label = numberGui:FindFirstChild("TextLabel")
				if label then
					local bombcount = tonumber(label.Text)
					if bombcount then
						local possiblebombs = 0
						local flaggedbombs = 0
						local surroundingParts = {}

						for _, offset in ipairs(offsets) do
							local checkPos = v.Position + offset
							local neighbor = positionMap[vecToKey(checkPos)]
							if neighbor then
								local color = neighbor.BrickColor
								if color == BrickColor.new("Moss") or color == BrickColor.new("Shamrock") then
									possiblebombs += 1
								elseif color == BrickColor.new("Really red") then
									possiblebombs += 1
									flaggedbombs += 1
								end
								table.insert(surroundingParts, neighbor)
							end
						end

						if possiblebombs <= bombcount then
							for _, neighbor in ipairs(surroundingParts) do
								local color = neighbor.BrickColor
								if color == BrickColor.new("Moss") or color == BrickColor.new("Shamrock") then
									neighbor.BrickColor = BrickColor.new("Really red")
									neighbor:FindFirstChildOfClass("TouchTransmitter"):Destroy()
								end
							end
						end
						if flaggedbombs == bombcount then
							for _, neighbor in ipairs(surroundingParts) do
								local color = neighbor.BrickColor
								if color == BrickColor.new("Moss") or color == BrickColor.new("Shamrock") then
									neighbor.BrickColor = BrickColor.new("Lime green")
								end
							end
						end
					end
				end
			end
		end
	end
end)
