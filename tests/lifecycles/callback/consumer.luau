local Packages = script.Parent.Parent.Parent.Parent
local Framework = require(Packages.framework.src)

local function LifecycleCallback(args)
    print(args)
end

return Framework {
    LifecycleCallback = LifecycleCallback,
}
