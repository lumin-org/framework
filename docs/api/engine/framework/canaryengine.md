# CanaryEngine

The main class of CanaryEngine.

## Properties

### Runtime <Badge type="tip" text="read only" />

The runtime property contains settings that are set during runtime, and the current context of the server/client.

* [**EngineRuntime**](/api/engine/runtime/engineruntime)

---

### Debugger <Badge type="tip" text="read only" />

The internal engine debugger, has useful functions to abide by debug settings.

* [**EngineDebugger**](/api/engine/dependencies/enginedebugger)

---

### Future <Badge type="tip" text="read only" />

A reference to the Future package, which is a optimized version of a Promise.

* [**Future**](https://util.redblox.dev/future.html)

---

### Guard <Badge type="tip" text="read only" />

A reference to the Guard package, which allows for type checking during runtime.

* [**Future**](https://util.redblox.dev/future.html)

## Functions

### GetFrameworkServer <Badge type="danger" text="server" />

Gets the server-sided interface of CanaryEngine.

**Returns**

* [**CanaryEngineServer?**](/api/engine/framework/canaryengineserver)

---

### GetFrameworkClient <Badge type="danger" text="client" />

Gets the client-sided interface of CanaryEngine.

**Returns**

* [**CanaryEngineClient?**](/api/engine/framework/canaryengineclient)

---

### GetFrameworkReplicated

Gets the global-sided interface of CanaryEngine. Recommended that use this only in replicated packages, this is a bad practice anywhere else.

**Returns**

* [**CanaryEngineRepliated?**](/api/engine/framework/canaryenginereplicated)

---

### ImportPackagesInOrder

Imports the provided packages in chronological order, also allowing for you to import descendants aswell.

**Parameters**

* **importList:** `{ModuleScript}`\
A list of packages to import\

* **importDeep:** `boolean?`\
Whether or not to import the package's descendants, defaults to `false`.

**Returns**

* **void**

---

### CreateSignal

Creates a new signal that is then given a reference in the signals table. Create a new anonymous signal by leaving the name blank.

**Parameters**

* **signalName:** `string?`\
The name of the signal

**Returns**

* [**SignalController**](/api/controllers/signal/signalcontroller)

---

### CreateAnonymousSignal

Creates a new anonymous signal, this does not have a reference outside of the variable it was created in. This is essentially an alias for an empty [`CreateSignal`](#createsignal)

**Returns**

* [**SignalController**](/api/controllers/signal/signalcontroller)