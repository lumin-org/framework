export type Provider<T> = {
	Name: string?,
	Uses: { any }?,
	Order: number?,
	Init: (() -> ())?,
	Start: (() -> ())?,
} & T

return {}
