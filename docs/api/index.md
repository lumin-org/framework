# Framework

The main class

## Functions

### `Add`

Allows you to add directories that the framework will `Init` and `Start` when `Start` is called.

**Parameters**

- **dirs:** `{ Instance }`\
A list of directories that should be loaded (shallow)

- **filter:** `((ModuleScript) -> boolean)` <Badge type="warning" text="OPTIONAL" />\
The filter which should be applied during loading, returning `false` means to skip the module

**Returns**

- `void`

---

### `Start`

Starts the framework and prepares all of the lifecycles/providers.

**Parameters**

- **options:** `{ profiling: boolean? }` <Badge type="warning" text="OPTIONAL" />\
A list of settings or options to apply to the framework.

**Returns**

- `void`

---

### `New`

Creates a new provider for management of various tasks.

**Parameters**

- **members:** `{ any }`\
This is where functions, properties, and methods are stored. Use this like a generic module

**Returns**

- [`Provider`](./provider.md)

---

### `Lifecycle`

Creates a new lifecycle that hooks onto already existing controller methods.

**Parameters**

- **name:** `string`\
The name of the lifecycle method to run

- **callback:** `(self: Lifecycle, ...any) -> ()` <Badge type="warning" text="OPTIONAL" />\
The callback that should run when `Fire` is called. Defaults to spawning each listener with arguments

**Returns**

- [`Lifecycle`](./lifecycle.md)
