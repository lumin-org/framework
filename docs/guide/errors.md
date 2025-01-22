# Errors

If you come across an error, you should be able to find it here. If not, [file an issue](https://github.com/lumin-org/framework/issues/new?template=broken-src.md) because it's unintentional.

## `AlreadyStarted`

The framework has already started, you cannot create any new providers, create new lifecycles, add paths, or run `Start` again.

## `FatalInit`

An `Init` function errored somewhere, the message is provided in the error.

## `FatalAddModule`

There was an issue adding the module to the load stack, which means a simple `require` caused an error.

## `ReservedName`

Lifecycle events cannot have the same name as one of the following reserved names:

- `Name`
- `Order`
- `Uses`
- `Init`
- `Start`

## `InvalidType`

The type you are passing to a parameter of some sort is invalid.
