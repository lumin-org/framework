-- Variables
local http = game:GetService("HttpService")

local types = require(script.types)
local logs = require(script.logs)
local spawn = require(script.spawn)
local debugger = require(script.Parent.roblox_packages.debugger)

local assert = debugger.assert
local fatal = debugger.fatal
local warn = debugger.warn

local started = false

-- Names that reserved for the framework only
local reservedNames: { string } = { "Init", "Start", "Uses", "Order", "Name" }
-- Providers imported using the Add function
local addedProviders: { types.Provider<any> } = {}
-- Lifecycles created using the Lifecycle function
local addedLifecycles: { types.Lifecycle<...any> } = {}
-- Providers that have been loaded already
local initiatedProviders: { types.Provider<any> } = {}

-- Functions

local function StartLifecycles(provider: Provider<any>)
	for _, lifecycle in addedLifecycles do
		if (provider :: any)[lifecycle.Name] then -- Check if the provider has a lifecycle
			-- Add the lifecycle callback to the listeners of it
			table.insert(lifecycle.Listeners, (provider :: any)[lifecycle.Name])
		end
	end
end

-- Starts a provider
local function StartProvider(provider: Provider<any>)
	if provider.Start then
		-- Ensure prop is the correct type
		local argType = type(provider.Start)
		assert(argType == "function", "InvalidType", "function", argType)
		-- Start the provider
		debug.setmemorycategory(provider.Name)
		spawn(provider.Start)
	end
end

-- Inits a provider
local function InitProvider(provider: Provider<any>)
	if provider.Init then
		-- Ensure prop is the correct type
		local argType = type(provider.Init)
		assert(argType == "function", "InvalidType", "function", argType)

		-- Use custom pcall to supply error to fatal debug
		local success, result: debugger.ParsedError = xpcall(function()
			-- Init the providertype(members)
			debug.setmemorycategory(provider.Name);
			(provider :: any).Init()
		end, debugger.parse)

		if not success then
			fatal("FatalInit", result.Message) -- If there was an error, share it with the user
		end

		table.insert(initiatedProviders, result :: any) -- Add to the loaded providers table
	end
end

-- Inits the dependencies of a provider (deep indexing)type(members)
local function InitDependencies(provider: Provider<any>)
	if provider.Uses then
		-- Ensure prop is the correct type
		local argType = type(provider.Uses)
		assert(argType == "table", "InvalidType", "table", argType)

		for _, usedProvider in provider.Uses :: any do
			if usedProvider.Init and not table.find(initiatedProviders, usedProvider) then
				InitDependencies(usedProvider) -- Check if there are more dependencies nested
				InitProvider(usedProvider) -- Load the dependency
			end
		end
	end
end

--[=[
	Creates a new lifecycle that hooks onto already existing provider methods.

	[Open Documentation](https://lumin-org.github.io/framework/api/#lifecycle)
]=]
local function Lifecycle<T...>(name: string, callback: ((self: Lifecycle<T...>, ...any) -> ())?): Lifecycle<T...>
	assert(not started, "AlreadyStarted")
	assert(not table.find(reservedNames, name), "ReservedName", name, "lifecycle")
	local lifecycle = table.freeze({
		Name = name :: string,
		Listeners = {},
		Fire = callback or function(self: Lifecycle<T...>, ...: any)
			for _, listener in self.Listeners do
				spawn(listener, ...)
			end
		end,
	})
	table.insert(addedLifecycles, lifecycle)
	return lifecycle
end

--[=[
	Creates a new provider for management of various tasks. Returned table is frozen.

	[Open Documentation](https://lumin-org.github.io/framework/api/#new)
]=]
local function New<T>(members: Provider<T>): T
    local argType = type(members)
	assert(not started, "AlreadyStarted")
    assert(argType == "table", "InvalidType", "table", argType)
    members.Name = members.Name or `provider-{http:GenerateGUID(false)}` -- Default naming scheme
    members.Order = members.Order or 0 -- Default order (no order)
	return table.freeze(members) :: any
end

--[=[
	Adds all of the modules located within the specified dirs to the framework loading stack.

	[Open Documentation](https://lumin-org.github.io/framework/api/#add)
]=]
local function Add(dirs: { Instance }, filter: ((ModuleScript) -> boolean)?)
	assert(not started, "AlreadyStarted")

	for _, dir in dirs do
		for _, module in dir:GetDescendants() do
			if not module:IsA("ModuleScript") then
				continue
			end

			if filter and not filter(module) then
				continue
			end

			local success, result: debugger.ParsedError = xpcall(require, debugger.parse, module)

            if not success then
                if result.Message:find("Module code did not return exactly one value") then
                    warn("FatalAddModule", result.Message)
                else
                    fatal("FatalAddModule", result.Message)
                end
            end

			table.insert(addedProviders, result :: any)
		end
	end
end

--[=[
	Starts the framework, loading all the created Providers and starting Lifecycles.

	[Open Documentation](https://lumin-org.github.io/framework/api/#start)
]=]
local function Start()
	assert(not started, "AlreadyStarted")

	-- Sort by load order, least to greatest
	table.sort(addedProviders, function(a: any, b: any)
		return a.Order < b.Order
	end)

	for _, provider in addedProviders do
		StartLifecycles(provider)
		InitDependencies(provider)
		InitProvider(provider)
	end

	for _, provider in initiatedProviders do
		StartProvider(provider)
	end

	started = true

	table.freeze(addedProviders)
	table.freeze(addedLifecycles)
end

-- Debugger

debugger.set({
	Logs = logs,
	Name = "Framework",
	URL = "https://lumin-org.github.io/framework/error/#",
})

-- Types

export type Lifecycle<T...> = types.Lifecycle<T...>
export type Provider<T> = types.Provider<T>

-- Module

return table.freeze({
	Start = Start,
	Add = Add,
	New = New,
	Lifecycle = Lifecycle,
})
