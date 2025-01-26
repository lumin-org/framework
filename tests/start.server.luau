local Packages = script.Parent.Parent
local Tests = script.Parent

local Framework = require(Packages.framework.src)
local TESTING = {
    -- lifecycles
    Tests.lifecycles,
    Tests.lifecycles.callback,
    -- providers
    Tests.providers,
    Tests.providers.dependencies,
    Tests.providers.order,
}

Framework.Add(TESTING)
Framework.Start({
    profiling = true,
})
