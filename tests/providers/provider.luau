local TEST_NAME = "PROVIDER-TEST"

local function Init()
    print(`{TEST_NAME}: Init (first)`)
end

local function Start()
    print(`{TEST_NAME}: Start (second)`)
end

return {
    Init = Init,
    Start = Start,
    Name = "provider-custom",
}
