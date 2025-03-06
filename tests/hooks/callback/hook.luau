local Packages = script.Parent.Parent.Parent.Parent
local Framework = require(Packages.framework.src)
local TEST_NAME = "HOOK-TEST"

local RunService = game:GetService("RunService")
local Hook = Framework.Hook("HookCallback", function(self, ...)
	for _, listener in self.Listeners do
		print(`{TEST_NAME}: Hook custom listener`)
		listener(...)
	end
end)

RunService.Heartbeat:Connect(function()
    Hook:Fire(TEST_NAME)
end)

return {}
