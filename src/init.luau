-- Variables
local Http = game:GetService("HttpService")

local Types = require(script.types)
local Logs = require(script.logs)
local Spawn = require(script.spawn)
local Debugger = require(script.Parent.roblox_packages.debugger)

local assert = Debugger.assert
local fatal = Debugger.fatal
local warn = Debugger.warn

local Started = false
local Profiling = false

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
		if Profiling then
			debug.setmemorycategory(provider.Name)
		end
		Spawn(provider.Start)
	end
end

-- Inits a provider
local function InitProvider(provider: Provider<any>)
	if provider.Init then
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
	})
	table.insert(AddedLifecycles, Lifecycle)
	return Lifecycle
end

--[=[
	Creates a new provider for management of various tasks.

	[Open Documentation](https://lumin-org.github.io/framework/api/#new)
]=]
local function New<T>(members: Provider<T>): T
	local argType = type(members)
	assert(not Started, "AlreadyStarted")
	assert(argType == "table", "InvalidType", "table", argType)
	members.Name = members.Name or `provider-{Http:GenerateGUID(false)}` -- Default naming scheme
	members.Order = members.Order or 1 -- Default order (no order)
	return members
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

			local success, result: Debugger.ParsedError = xpcall(require, Debugger.parse, module)

			if not success then
				if result.Message:find("Module code did not return exactly one value") then
					warn("FatalAddModule", result.Message)
				else
					fatal("FatalAddModule", result.Message)
				end
			end

			table.insert(AddedProviders, result :: any)
		end
	end
end

--[=[
	Starts the framework, loading all the created Providers.

	[Open Documentation](https://lumin-org.github.io/framework/api/#start)
]=]
local function Start(config: { profiling: boolean? }?)
	assert(not Started, "AlreadyStarted")

	if config then
		-- Set configurations
		Profiling = config.profiling or Profiling
	end

	-- Sort by load order, least to greatest
	table.sort(AddedProviders, function(a: any, b: any)
		return a.Order < b.Order
	end)

	for _, provider in AddedProviders do
		table.freeze(provider)
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
	New = New,
	Lifecycle = Lifecycle,
})
