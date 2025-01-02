local FreeThreads: { thread } = {}

local function RunCallback(callback: (...any) -> (...any), thread: thread, ...)
	callback(...)
	table.insert(FreeThreads, thread)
end

local function Yielder()
	while true do
		RunCallback(coroutine.yield())
	end
end

return function<T...>(callback: (T...) -> (), ...: T...)
	local Thread
	if #FreeThreads > 0 then
		Thread = FreeThreads[#FreeThreads]
		FreeThreads[#FreeThreads] = nil
	else
		Thread = coroutine.create(Yielder)
		coroutine.resume(Thread)
	end

	task.spawn(Thread, callback, Thread, ...)
end
