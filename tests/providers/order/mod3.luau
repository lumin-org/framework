local TEST_NAME = "ORDER-TEST"

local function Init()
    print(`{TEST_NAME}: Third`)
end

return {
    Init = Init,
    Order = -1,
}
