# Provider

Responsible for controlling most of the game's functions

## Properties

---

### `Uses`

Any other providers that the current one uses

- [`{ Provider }`](./provider.md)

## Functions

---

### `Init`

Prepares the provider so that it can be used across the data model.

**Returns**

- `void`

---

### `Start`

Called internally when the provider is safe to use other dependencies that were prepared previously by `Init`.

**Returns**

- `void`
