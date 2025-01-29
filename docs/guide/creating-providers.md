# Creating Providers

Creating a provider is as easy as creating a normal module. `Add` will automatically infer whether the added modules pass as providers and there is no constructor needed.

## Usage

Here, we will create a very simple provider that has usage of both `Init` and `Start`.

```luau
-- This will run first
local function Init()
    print("Initiated!")
end

-- This will run second
local function Start()
    print("Started!")
end

return {
    Init = Init,
    Start = Start,
}
```
