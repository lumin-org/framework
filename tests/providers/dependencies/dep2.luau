local TEST_NAME = "DEPENDENCIES-TEST"

local function Init()
    print(`{TEST_NAME}: Dependency 2 (first)`)
end

return {
    Init = Init,
}
