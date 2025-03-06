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

local ProviderNames: { string } = {}
local ReservedNames: { string } = { "Init", "Start", "Uses", "Order", "Name" }
local AddedProviders: { Types.Provider<any> } = {}
local AddedHooks: { Types.Hook<...any> } = {}
local InitiatedProviders: { Types.Provider<any> } = {}

-- Functions

-- Adds the the callback from the provider to the listeners of the hook
local function StartHooks(provider: Provider<any>)
	for _, hook in AddedHooks do
	    if (provider :: any)[hook.Name] and type((provider :: any)[hook.Name]) == "function" then -- Check if the provider has a hook function
	       -- Add the hook callback to the listeners of it
	       table.insert(hook.Listeners, (provider :: any)[hook.Name])
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
		local success, result: Debugger.Parsed = xpcall(function()
			-- Init the provider
			if Profiling then
				debug.setmemorycategory(provider.Name)
			end
			(provider :: any).Init()
		end, Debugger.parse)

		if not success then
			fatal("FatalInit", result.message) -- If there was an error, share it with the user
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
	Creates a new hook that uses pre-existing provider functions.

	[Open Documentation](https://lumin-org.github.io/framework/api/#hook)
]=]
local function Hook<T...>(name: string, callback: ((self: Hook<T...>, ...any) -> ())?): Hook<T...>
	assert(not Started, "AlreadyStarted")
	assert(not table.find(ReservedNames, name), "ReservedName", name, "hook")
	local Hook = table.freeze({
		Name = name :: string,
		Listeners = {},
		Fire = callback or function(self: Hook<T...>, ...: any)
			for _, listener in self.Listeners do
				Spawn(listener, ...)
			end
		end,
		Unhook = function(self: Hook<T...>)
			table.clear(self.Listeners)
			table.freeze(self.Listeners)
		end,
	})
	table.insert(AddedHooks, Hook)
	return Hook
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
		Profiling = config.Profiling or Profiling
	end

	-- Default provider properties
	for _, provider in AddedProviders do
        ProviderCount += 1
        provider.Order = provider.Order or 1 -- Default order (no order)
		provider.Name = provider.Name or `provider-{ProviderCount}`
		if not table.find(ProviderNames, provider.Name) then
			table.insert(ProviderNames, provider.Name)
        else
            fatal("ProviderDuplicate", provider.Name)
		end
        table.freeze(provider)
	end

	-- Sort by load order, least to greatest
	table.sort(AddedProviders, function(a: any, b: any)
		return a.Order < b.Order
	end)

	for _, provider in AddedProviders do
        StartHooks(provider)
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
Debugger.set("Framework", Logs)

-- Types
export type Provider<T> = Types.Provider<T>
export type Hook<T...> = Types.Hook<T...>

-- Module
return table.freeze({
	Start = Start,
	Add = Add,
	Hook = Hook,
})
