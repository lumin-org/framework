# Lifecycle

The [`Lifecycle`]() class

## Properties

### `Name`

The name of the lifecycle, this will correspond with the method used.

- `string`

---

### `Listeners`

A list of the methods with the name of `Name` from each provider.

- `{ (...any) -> () }`

## Methods

### `Fire`

Run the listeners of the lifecycle.

**Parameters**

- **params:** `...any`<br>
A list of parameters to be passed to the provider method

**Returns**

- `void`
