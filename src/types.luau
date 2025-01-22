export type Provider<T> = {
	Name: string?,
	Uses: { any }?,
	Order: number?,
	Init: (() -> ())?,
	Start: (() -> ())?,
} & T

export type Lifecycle<T...> = {
	Name: string,
	Fire: (self: Lifecycle<T...>, T...) -> (),
	Listeners: { (...any) -> () },
}

return {}
