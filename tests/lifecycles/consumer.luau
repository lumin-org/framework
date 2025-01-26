local Packages = script.Parent.Parent.Parent
local Framework = require(Packages.framework.src)

local function LifecycleTest(arg)
    print(`{arg}: Default listener`)
end

return Framework {
    LifecycleTest = LifecycleTest,
}
