# Creating Providers

Creating a provider using the `.New` function allows you to ensure that you built it correctly. It checks the types of the properties provided, and also inserts defaults if they were not already there.

## Usage

Here, we will create a very simple provider that has usage of both `Init` and `Start`.

```luau
local Framework = require(path.to.framework)

-- This will run first
local function Init()
    print("Initiated!")
end

-- This will run second
local function Start()
    print("Started!")
end

return Framework.New {
    Init = Init,
    Start = Start,
}
```
