local Lumin = require(game.ReplicatedStorage.framework.src)
local Signal = require(script.Parent.Parent.Packages.Signal)

local CollectionService = game:GetService("CollectionService")
local SpleefBricks = CollectionService:GetTagged("SpleefBrick")

local InitialBrickCount = #SpleefBricks
local BrokenBricks = 0
local TouchDebounce = false

local SpleefPart = {
    GameFinishedSignal = Signal.new()
}

function SpleefPart.Init()
	for _, part: Part in SpleefBricks do
		part.Touched:Connect(function(basePart)
			if not part.CanCollide or TouchDebounce then
				return
			end

			TouchDebounce = true

			local Character = basePart.Parent :: Model

			if Character:FindFirstChildWhichIsA("Humanoid") then
				task.wait(0.15)
				print("Broke part")

				part.Transparency = 1
				part.CanCollide = false

				BrokenBricks += 1

				if BrokenBricks == InitialBrickCount then
					SpleefPart.GameFinishedSignal:Fire()
				end
			end

			TouchDebounce = false
		end)
	end
end

SpleefPart.GameFinishedSignal:Connect(function()
    print("Game finished!")
    task.wait(3)
    for _, part: Part in SpleefBricks do
        part.Transparency = 0
        part.CanCollide = true
    end
    BrokenBricks = 0
end)

return Lumin.New(SpleefPart)
