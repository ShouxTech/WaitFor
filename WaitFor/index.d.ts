type AsTuple<T> = T extends any[] ? T : [T];

type UnwrapLuaTuple<T> = T extends LuaTuple<infer U> ? U : T;

type WaitForArgs<S extends Signal<any>> =
	S extends { Wait(): infer R }
		? AsTuple<UnwrapLuaTuple<R>>
		: never;

type WaitForAnyReturn<S extends Signal<any>[]> = {
	[K in keyof S]: S[K] extends Signal<any> ? [S[K], ...WaitForArgs<S[K]>] : never;
}[number];

declare namespace WaitFor {
	const Signal: <T = unknown>(
		signal: Signal<T>,
		timeout: number
	) => AsTuple<T> | undefined;

	const Attribute: (
		instance: Instance,
		attribute: string,
		timeout: number
	) => AttributeValue | undefined;

	const Any: <S extends Signal<any>[]>(
		...signals: S
	) => WaitForAnyReturn<S>;
}

export = WaitFor;
