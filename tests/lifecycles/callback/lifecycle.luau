local Packages = script.Parent.Parent.Parent.Parent
local Framework = require(Packages.framework.src)
local TEST_NAME = "LIFECYCLE-TEST"

local RunService = game:GetService("RunService")
local Lifecycle = Framework.Lifecycle("LifecycleCallback", function(self, ...)
	for _, listener in self.Listeners do
		print(`{TEST_NAME}: Lifecycle custom listener`)
		listener(...)
	end
end)

RunService.Heartbeat:Connect(function()
    Lifecycle:Fire(TEST_NAME)
end)

return {}
