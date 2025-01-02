-- Variables
local types = require(script.types)
local logs = require(script.logs)
local spawn = require(script.spawn)
local debug = require(script.Parent.roblox_packages.debugger)

local assert = debug.assert
local fatal = debug.fatal

local started = false

-- Modules imported using the Import function
local addedProviders: { types.Provider<any> } = {}
-- Providers created using the New function
local providers: { types.Provider<any> } = {}
-- Lifecycles created using the Lifecycle function
local lifecycles: { types.Lifecycle<...any> } = {}
-- Providers that have been loaded already
local loadedProviders: { types.Provider<any> } = {}

-- Functions

--[=[
	Fires the listeners of a lifecycle sequentially and yields between listeners.

	[Open Documentation](https://lumin-org.github.io/framework/api/#fireconcurrent)
]=]
local function FireSequential<T...>(self: Lifecycle<T...>, ...: any)
	for _, listener in self.Listeners do
		listener(...)
	end
end

--[=[
	Fires the listeners of a lifecycle concurrently (no yielding between listeners).

	[Open Documentation](https://lumin-org.github.io/framework/api/#fireconcurrent)
]=]
local function FireConcurrent<T...>(self: Lifecycle<T...>, ...: any)
	for _, listener in self.Listeners do
		spawn(listener, ...)
	end
end

--[=[
	Creates a new lifecycle that hooks onto already existing provider methods.

	[Open Documentation](https://lumin-org.github.io/framework/api/#lifecycle)
]=]
local function Lifecycle<T...>(name: string, callback: ((self: Lifecycle<T...>, ...any) -> ())?): Lifecycle<T...>
	assert(not started, "AlreadyStarted")
	assert(name, "MustProvide", "name")
	local lifecycle = table.freeze({
		Name = name :: string,
		Listeners = {},
		Fire = callback or FireConcurrent,
	})
	table.insert(lifecycles, lifecycle)
	return lifecycle
end

local initLifecycle = Lifecycle("Init")
local startLifecycle = Lifecycle("Start")

--[=[
	Creates a new provider for management of various tasks. Returned table is frozen.

	[Open Documentation](https://lumin-org.github.io/framework/api/#new)
]=]
local function New<T>(members: Provider<T>): T
	assert(not started, "AlreadyStarted")
	assert(members, "MustProvide", "members")
	table.freeze(members)
	table.insert(providers, members)
	return members
end

local function LoadLifecycles(provider: Provider<any>)
	for _, lifecycle in lifecycles do
		if (provider :: any)[lifecycle.Name] then -- Check if the provider has a lifecycle
			-- Add the lifecycle callback to the listeners of it
			table.insert(lifecycle.Listeners, (provider :: any)[lifecycle.Name])
		end
	end
end

-- Loads a provider
local function InitProvider(provider: Provider<any>)
	if provider.Init then
		-- Ensure prop is the correct type
		local Type = type(provider.Init)
		assert(Type == "function", "InvalidType", "function", Type)

		-- Use custom pcall to supply error to fatal debug
		local success, err: debug.ParsedError = xpcall(function()
			initLifecycle:Fire()
		end, debug.parse)

		if not success then
			fatal("FatalInit", err.Message) -- If false, give a FatalInit error
		end

		table.insert(LoadedProviders, provider) -- Add to the loaded providers table
	end
end

-- Loads all of the dependencies of a provider
local function LoadDependencies(provider: Provider<any>)
	if provider.Uses then
		-- Ensure prop is the correct type
		local Type = type(provider.Uses)
		assert(Type == "table", "InvalidType", "table", Type)

		for _, usedProvider in provider.Uses :: any do
			if usedProvider.Init and not table.find(LoadedProviders, usedProvider) then
				LoadDependencies(usedProvider) -- Check if there are more dependencies nested
				InitProvider(usedProvider) -- Load the dependency
			end
		end
	end
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

			table.insert(AddedProviders, (require)(module))
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
	table.sort(AddedProviders, function(a: any, b: any)
		return a.Order < b.Order
	end)

	for _, provider in AddedProviders do
		-- Load lifecycles
		LoadLifecycles(provider)
		-- Load dependencies
		LoadDependencies(provider)
		-- Load the provider itself
		LoadProvider(provider)
	end

	started = true

	table.freeze(AddedProviders)
	table.freeze(Lifecycles)
end

-- Debugger

debug.set({
	Logs = logs,
	Name = "Framework",
	URL = "https://lumin-org.github.io/framework/error/#",
})

-- Types

export type Lifecycle<T...> = types.Lifecycle<T...>
export type Provider<T> = types.Provider<T>

-- Module

return table.freeze({
	FireConcurrent = FireConcurrent,
	FireSequential = FireSequential,
	Start = Start,
	Add = Add,
	New = New,
	Lifecycle = Lifecycle,
})
