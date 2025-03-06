# Creating Hooks

Hooks are objects with listeners, and these listeners are already existing functions that exist within your providers. This is where the term "hook on" comes in, because all you have to do is define your hook name as a method in one module, and in another create the hook and/or `Fire` it.

## Usage

To create a hook, you must provide a name and optionally a callback. This callback is what is used when `Fire` is called, and is explained in more depth in the [unique callbacks guide.](./unique-callbacks.md) Let's create an example where we use a `Heartbeat` hook across multiple providers to simplify our code.

::: code-group
```luau [hooks.luau]
local RunService = game:GetService("RunService")
local Framework = require(path.to.framework)

local HeartbeatHook = Framework.Hook("Heartbeat")
RunService.Heartbeat:Connect(function(deltaTime)
    HeartbeatHook:Fire(deltaTime)
end)
```

```luau [provider1.luau]
...

local function Heartbeat(deltaTime)
    print("Provider 1:", deltaTime) --> Provider 1: 0.013
end

return {
    Heartbeat = Heartbeat,
    ...
}
```

```luau [provider2.luau]
...

local function Heartbeat(deltaTime)
    print("Provider 2:", deltaTime) --> Provider 2: 0.012
end

return {
    Heartbeat = Heartbeat,
    ...
}
```
:::

This result in both `Provider 1` and `Provider 2` being print every frame.
