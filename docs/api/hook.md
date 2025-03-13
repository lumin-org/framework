# Lifecycle

The [`Hook`]() class

## Properties

### `Name`

The name of the hook, this will correspond with the method used.

- `string`

---

### `Listeners`

A list of the methods with the name of `Name` from each provider.

- `{ (...any) -> () }`

## Methods

### `Fire`

Run the listeners of the hook.

**Parameters**

- **params:** `...any`\
A list of parameters to be passed to the provider method

**Returns**

- `void`

---

### `Unhook`

Makes the hook invalid, and removes all listeners.

**Returns**

- `void`
