local Packages = script.Parent.Parent.Parent
local Framework = require(Packages.framework.src)
local TEST_NAME = "PROVIDER-TEST"

local function Init()
    print(`{TEST_NAME}: Init (first)`)
end

local function Start()
    print(`{TEST_NAME}: Start (second)`)
end

return Framework {
    Init = Init,
    Start = Start,
    Name = "provider-custom",
}
