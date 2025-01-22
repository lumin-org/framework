# Unique Callbacks

When using lifecycles, you can specify your own unique callback. The default callback is spawning each of the listeners in a thread and passing along their arguments. In a case like our previous `Heartbeat` lifecycle sample, it could be more efficient to run the listener directly rather than spawn or reuse a thread every time.

## Usage

To add a unique callback to your lifecycle, all you have to do is use the second parameter of the lifecycle constructor called `callback`. Let's reuse our `Heartbeat` example.

```luau
local RunService = game:GetService("RunService")
local Framework = require(path.to.framework)

local HeartbeatLifecycle = Framework.Lifecycle("Heartbeat", function(self, ...: any)
	for _, listener in self.Listeners do
		listener(...)
	end
end)

RunService.Heartbeat:Connect(function(deltaTime)
    HeartbeatLifecycle:Fire(deltaTime)
end)
```
Now, instead of spawning or reusing a thread each frame, our lifecycle will only call the listener and potentially wait for yielding (if any). The `self` argument here is the lifecycle object itself, so you may also use props like `Name` if you wish.
