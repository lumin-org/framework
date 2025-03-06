# Init & Start

If you have not used a framework before, the concept of having Init and Start may seem confusing because they appear to do the same thing. Their differences are highlighted below, and also when you should use them.

## When to Use Init

Init is not used very much realistically, but it can have its benefits. An example is if you need to stop other providers from loading before the current one with an important initialization job.

::: danger
Init is prone to errors and yielding, so its highly advised to avoid this behavior. Yielding will affect the `Init` stack as well as the `Start` stack, and cause longer load times.
:::

## When to Use Start

Start is generally used for things that run in the background of your game, and runs after all Init's are finished.

::: tip
`Start` callbacks use a reused/spawned thread, so you can safely yield and error in `Start` without causing issues in the loading stack.
:::

---

**TL;DR** You will use `Start` more often, but the unique `Init` behavior is needed in some situations.
