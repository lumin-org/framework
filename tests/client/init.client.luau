local Lumin = require(game.ReplicatedStorage.framework.src)
local Modules = script.Modules

local Lifecycle = Lumin.Lifecycle("Heartbeat")
game:GetService("RunService").Heartbeat:Connect(function(delta)
    Lifecycle:Fire(delta)
end)

Lumin.Add({Modules})
Lumin.Start()
