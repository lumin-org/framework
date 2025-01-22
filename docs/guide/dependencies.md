# Dependencies

In a lot of scenarios, dependencies can start to get very messy as the build up. In order to solve this, you can implement a `Uses` property on your provider. This is a table of all the other providers that your provider is dependent on.

## Usage

All that needs to be appended to your provider is `Uses` on creation. This will lead to the used provider being initiated before the one shown in the example.

::: code-group
```luau [provider.luau]
local Framework = require(path.to.framework)
local Dependency = require(path.to.dependency)

local function Init()
    print("This will print second!")
end

return Framework.New {
    Uses = { Dependency }
    Init = Init,
}
```

```luau [dependency.luau]
local Framework = require(path.to.framework)

local function Init()
    print("This will print first!")
end

return Framework.New {
    Init = Init,
}
```
:::
