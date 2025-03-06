export type Provider<T> = {
	Name: string?,
	Uses: { any }?,
	Order: number?,
	Init: (() -> ())?,
	Start: (() -> ())?,
} & T

export type Hook<T...> = {
	Name: string,
	Fire: (self: Hook<T...>, T...) -> (),
	Listeners: { (...any) -> () },
}

return {}
