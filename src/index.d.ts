export = Framework;
export as namespace Framework;

declare namespace Framework {
    export type Provider<T> = T & {
        Name?: string
        Uses?: any[]
        Order?: number
        Init?: () => void
        Start?: () => void
    }

    export type Hook<T extends any[]> = {
        Name: string
        Fire: (self: Hook<T>, ...args: T) => void;
        Unhook: (self: Hook<T>) => void;
        Listeners: Array<(...args: T) => void>;
    }

    export function Start(): void;
    export function Add(dirs: Array<Instance>, filter?: (module: ModuleScript) => boolean): void;
    export function Hook<T extends any[]>(name: string, callback?: (self: Hook<T>, args: T) => void): Hook<T>;
}
