local Packages = script.Parent.Parent.Parent
local Framework = require(Packages.framework.src)
local TEST_NAME = "LIFECYCLE-TEST"

local RunService = game:GetService("RunService")
local Lifecycle = Framework.Lifecycle("LifecycleTest")

RunService.Heartbeat:Connect(function()
    Lifecycle:Fire(TEST_NAME)
end)

return {}
