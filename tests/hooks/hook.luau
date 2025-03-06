local Packages = script.Parent.Parent.Parent
local Framework = require(Packages.framework.src)
local TEST_NAME = "HOOK-TEST"

local RunService = game:GetService("RunService")
local Hook = Framework.Hook("HookTest")

RunService.Heartbeat:Connect(function()
    Hook:Fire(TEST_NAME)
end)

return {}
