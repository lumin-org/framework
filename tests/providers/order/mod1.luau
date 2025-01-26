local Packages = script.Parent.Parent.Parent.Parent
local Framework = require(Packages.framework.src)
local TEST_NAME = "ORDER-TEST"

local function Init()
    print(`{TEST_NAME}: First`)
end

return Framework {
    Init = Init,
    Order = -3,
}
