local function HookTest(arg)
    print(`{arg}: Default listener`)
end

return {
    HookTest = HookTest,
}
