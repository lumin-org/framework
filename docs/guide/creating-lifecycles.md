# Creating Lifecycles

Lifecycles are objects with listeners, and these listeners are already existing methods that exist within your providers. This is where the term "hook on" comes in, because all you have to do is define your lifecycle name as a method in one module, and in another create the lifecycle and/or `Fire` it.

## Usage

To create a lifecycle, you must provide a name and optionally a callback. This callback is what is used when `Fire` is called, and is explained in more depth in the [unique callbacks guide.](./unique-callbacks.md) Let's create an example where we use a `Heartbeat` lifecycle across multiple providers to simplify our code.

::: code-group
```luau [lifecycles.luau]
local RunService = game:GetService("RunService")
local Framework = require(path.to.framework)

local HeartbeatLifecycle = Framework.Lifecycle("Heartbeat")
RunService.Heartbeat:Connect(function(deltaTime)
    HeartbeatLifecycle:Fire(deltaTime)
end)
```

```luau [provider1.luau]
local Framework = require(path.to.framework)

...

local function Heartbeat()
    print("Provider 1")
end

return Framework.New {
    Heartbeat = Heartbeat,
    ...
}
```

```luau [provider2.luau]
local Framework = require(path.to.framework)

...

local function Heartbeat()
    print("Provider 2")
end

return Framework.New {
    Heartbeat = Heartbeat,
    ...
}
```
:::

This result in both `Provider 1` and `Provider 2` being print every frame.
