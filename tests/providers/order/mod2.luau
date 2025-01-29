local TEST_NAME = "ORDER-TEST"

local function Init()
    print(`{TEST_NAME}: Second`)
end

return {
    Init = Init,
    Order = -2,
}
