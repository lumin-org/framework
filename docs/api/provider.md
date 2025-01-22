# Provider

The [`Provider`]() class

## Properties

### `Uses`

Any other providers that the current one uses

- [`{ Provider }`](./provider.md)

---

### `Order`

The order that the provider should be loaded in. Defaults to 1 (no order).

- `number`

---

### `Name`

The name of the provider. Defaults to `provider-<GUID>`.

- `string`

## Functions

### `Init`

Prepares the provider so that it can be used across the data model.

**Returns**

- `void`

---

### `Start`

Called internally when the provider is safe to use other dependencies that were prepared previously by `Init`.

**Returns**

- `void`
