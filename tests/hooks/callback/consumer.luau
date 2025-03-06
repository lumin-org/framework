local function HookCallback(args)
    print(args)
end

return  {
    HookCallback = HookCallback,
}
