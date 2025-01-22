# Adding Directories

In order for the framework to properly load all of your providers, you must specify the paths/directories that should be loaded. This will not `require` deeply, only on child surface.

## Usage

Add dirs by using `Add`, and add multiple by passing more along into the table.

```luau
local Framework = require(path.to.framework)
local MyFirstDir = path.to.dir
local MySecondDir = path.to.dir

Framework.Add({
    MyFirstDir,
    MySecondDir,
})
```
Keep in mind you can also run `Add` multiple times before `Start` is called. For example, if you have any directories referenced later you can add their paths as well.


