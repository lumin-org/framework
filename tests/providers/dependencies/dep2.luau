local Packages = script.Parent.Parent.Parent.Parent
local Framework = require(Packages.framework.src)
local TEST_NAME = "DEPENDENCIES-TEST"

local function Init()
    print(`{TEST_NAME}: Dependency 2 (first)`)
end

return Framework {
    Init = Init,
}
