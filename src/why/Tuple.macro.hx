package why;

import haxe.macro.Expr;
import tink.macro.BuildCache;

using tink.MacroApi;

class Tuple {
	public static function build() {
		return BuildCache.getTypeN('why.Tuple', (ctx:BuildContextN) -> {
			final name = ctx.name;
			final ctFields = [];
			final ct = TAnonymous(ctFields);
			final initFields = [];
			final init = EObjectDecl(initFields);
			final ctorArgs = [];
			
			final def = macro class $name {}
			
			for(i => type in ctx.types) {
				final fname = 'v$i';
				ctFields.push({
					access: [AFinal],
					name: fname,
					pos: ctx.pos,
					kind: FVar(type.toComplex()),
				});
				initFields.push({
					field: fname,
					expr: macro @:pos(ctx.pos) $i{fname},
				});
				ctorArgs.push(fname);
			}
			
			def.fields.push({
				access: [APublic, AInline],
				name: 'new',
				pos: ctx.pos,
				kind: FFun({
					args: ctorArgs.map(a -> ({name: a, type: null}:FunctionArg)),
					ret: null,
					expr: macro @:pos(ctx.pos) this = ${init.at(ctx.pos)},
				}),
			});
			def.meta = [{name: ':forward', pos: ctx.pos}];
			def.kind = TDAbstract(ct, [ct], [ct]);
			def.pack = ['why', 'tuple'];
			def;
		});
	}
}