# Unique Callbacks

When using hooks, you can specify your own unique callback. The default callback is spawning each of the listeners in a thread and passing along their arguments. In a case like our previous `Heartbeat` hook sample, it could be more efficient to run the listener directly rather than spawn or reuse a thread every time.

## Usage

To add a unique callback to your hook, all you have to do is use the second parameter of the hook constructor called `callback`. Let's reuse our `Heartbeat` example.

```luau
local RunService = game:GetService("RunService")
local Framework = require(path.to.framework)

local Heartbeathook = Framework.Hook("Heartbeat", function(self, ...: any)
	for _, listener in self.Listeners do
		listener(...)
	end
end)

RunService.Heartbeat:Connect(function(deltaTime)
    HeartbeatHook:Fire(deltaTime)
end)
```
Now, instead of spawning or reusing a thread each frame, our hook will only call the listener and potentially wait for yielding (if any). The `self` argument here is the hook object itself, so you may also use props like `Name` if you wish.
