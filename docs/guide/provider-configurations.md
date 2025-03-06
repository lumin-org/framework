# Provider Configurations

There are couple provider configurations that are available for use. These are both completely optional, and will be defaulted upon provider creation.

## Name

A default name is given to your provider for profiling purposes, which is in the format of `provider-<number>`. There wouldn't be much reason to change it if profiling is off, because that's the only time when the provider name is actually used.

```luau
{
    Name = "very-cool-provider"
}
```

## Load Order

The load order dictates which provider will be initiated first. `1` being the first one, and `3` being the last one. If you have more dependencies, it's recommended to use `Uses` instead as it can be more scalable than load order.

```luau
{
    Order = 4
}
```
