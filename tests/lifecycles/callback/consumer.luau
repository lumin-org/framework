local function LifecycleCallback(args)
    print(args)
end

return  {
    LifecycleCallback = LifecycleCallback,
}
