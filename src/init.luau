-- Variables
local Types = require(script.types)
local Logs = require(script.logs)
local Spawn = require(script.spawn)
local Debugger = require(script.Parent.roblox_packages.debugger)

local assert = Debugger.assert
local fatal = Debugger.fatal

local Started = false
local Profiling = false
local ProviderCount = 0

-- Names that have been already claimed by other providers
local ProviderNames: { string } = {}
-- Names that are reserved for the framework only
local ReservedNames: { string } = { "Init", "Start", "Uses", "Order", "Name" }
-- Providers imported using the Add function
local AddedProviders: { Types.Provider<any> } = {}
-- Lifecycles created using the Lifecycle function
local AddedLifecycles: { Types.Lifecycle<...any> } = {}
-- Providers that have been loaded already
local InitiatedProviders: { Types.Provider<any> } = {}

-- Functions

-- Adds the the callback from the provider to the lifecycle listeners
local function StartLifecycles(provider: Provider<any>)
	for _, lifecycle in AddedLifecycles do
		if (provider :: any)[lifecycle.Name] and type((provider :: any)[lifecycle.Name]) == "function" then -- Check if the provider has a lifecycle
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
		if Profiling then
			debug.setmemorycategory(provider.Name)
		end
		Spawn(provider.Start)
	end
end

-- Inits a provider
local function InitProvider(provider: Provider<any>)
	if provider.Init and not table.find(InitiatedProviders, provider) then
		-- Ensure prop is the correct type
		local argType = type(provider.Init)
		assert(argType == "function", "InvalidType", "function", argType)

		-- Use custom pcall to supply error to fatal debug
		local success, result: Debugger.ParsedError = xpcall(function()
			-- Init the provider
			if Profiling then
				debug.setmemorycategory(provider.Name)
			end
			(provider :: any).Init()
		end, Debugger.parse)

		if not success then
			fatal("FatalInit", result.Message) -- If there was an error, share it with the user
		end
	end
	table.insert(InitiatedProviders, provider) -- Add to the loaded providers table
end

-- Inits the dependencies of a provider (deep indexing)
local function InitDependencies(provider: Provider<any>)
	if provider.Uses then
		-- Ensure prop is the correct type
		local argType = type(provider.Uses)
		assert(argType == "table", "InvalidType", "table", argType)

		for _, usedProvider in provider.Uses :: any do
			if usedProvider.Init and not table.find(InitiatedProviders, usedProvider) then
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
	assert(not Started, "AlreadyStarted")
	assert(not table.find(ReservedNames, name), "ReservedName", name, "lifecycle")
	local Lifecycle = table.freeze({
		Name = name :: string,
		Listeners = {},
		Fire = callback or function(self: Lifecycle<T...>, ...: any)
			for _, listener in self.Listeners do
				Spawn(listener, ...)
			end
		end,
		Disconnect = function(self: Lifecycle<T...>)
			table.clear(self.Listeners)
			table.freeze(self.Listeners)
		end,
	})
	table.insert(AddedLifecycles, Lifecycle)
	return Lifecycle
end

--[=[
	Adds all of the modules located within the specified dirs to the framework loading stack.

	[Open Documentation](https://lumin-org.github.io/framework/api/#add)
]=]
local function Add(dirs: { Instance }, filter: ((ModuleScript) -> boolean)?)
	assert(not Started, "AlreadyStarted")

	for _, dir in dirs do
		for _, module in dir:GetChildren() do
			if not module:IsA("ModuleScript") then
				continue
			end

			if filter and not filter(module) then
				continue
			end

			local success, result = pcall(require, module)
			assert(success, "FatalAddModule", result)
			table.insert(AddedProviders, result)
		end
	end
end

--[=[
	Starts the framework, loading all the created Providers.

	[Open Documentation](https://lumin-org.github.io/framework/api/#start)
]=]
local function Start(config: { Profiling: boolean? }?)
	assert(not Started, "AlreadyStarted")

	if config then
		-- Set configurations
		Profiling = config.Profiling or Profiling
	end

	-- Default provider properties
	for _, provider in AddedProviders do
        provider.Order = provider.Order or 1 -- Default order (no order)
        ProviderCount += 1
		local DefaultName = provider.Name or `provider-{ProviderCount}`
		if not table.find(ProviderNames, DefaultName) then
            provider.Name = DefaultName -- Default naming scheme
			table.insert(ProviderNames, DefaultName)
		end
        table.freeze(provider)
	end

	-- Sort by load order, least to greatest
	table.sort(AddedProviders, function(a: any, b: any)
		return a.Order < b.Order
	end)

	for _, provider in AddedProviders do
        StartLifecycles(provider)
		InitDependencies(provider)
		InitProvider(provider)
	end

	for _, provider in InitiatedProviders do
		StartProvider(provider)
	end

	Started = true

	table.freeze(AddedProviders)
end

-- Debugger

Debugger.set({
	Logs = Logs,
	Name = "Framework",
	URL = "https://lumin-org.github.io/framework/guide/errors#",
})

-- Types

export type Provider<T> = Types.Provider<T>
export type Lifecycle<T...> = Types.Lifecycle<T...>

-- Module

return table.freeze({
	Start = Start,
	Add = Add,
	Lifecycle = Lifecycle,
})
