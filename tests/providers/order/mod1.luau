local TEST_NAME = "ORDER-TEST"

local function Init()
    print(`{TEST_NAME}: First`)
end

return {
    Init = Init,
    Order = -3,
}
