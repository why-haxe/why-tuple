package why.tuple;

import haxe.macro.Expr;
import haxe.macro.Context;

#if macro
using tink.MacroApi;
#end

class Maker {
	public macro static function make(rest:Array<Expr>) {
		final tp = switch Context.getExpectedType() {
			case null | TMono(_): 'why.Tuple'.asTypePath([for(e in rest) TPType(Context.typeof(e).toComplex())]);
			case TAbstract(_.get() => {module: module, name: name}, _): '$module.$name'.asTypePath();
			case v: Context.currentPos().error('[why-tuple] No idea how to handle this expected type: $v');
		}
		return macro new $tp($a{rest});
	}
}