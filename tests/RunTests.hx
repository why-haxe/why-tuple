package ;

import tink.unit.*;
import tink.testrunner.*;
import why.Tuple;

@:asserts
class RunTests {

	static function main() {
		Runner.run(TestBatch.make([
			new RunTests(),
		])).handle(Runner.exit);
	}
	
	function new() {}
	
	public function tuple2() {
		var v = new Tuple<Int, String>(1, 'foo');
		asserts.assert(v.v0 == 1);
		asserts.assert(v.v1 == 'foo');
		var v = Tuple.make(1, 'foo');
		asserts.assert(v.v0 == 1);
		asserts.assert(v.v1 == 'foo');
		return asserts.done();
	}
	
	public function tuple3() {
		var v = new Tuple<Int, String, Bool>(1, 'foo', true);
		asserts.assert(v.v0 == 1);
		asserts.assert(v.v1 == 'foo');
		asserts.assert(v.v2);
		var v = Tuple.make(1, 'foo', true);
		asserts.assert(v.v0 == 1);
		asserts.assert(v.v1 == 'foo');
		asserts.assert(v.v2);
		return asserts.done();
	}
	
	public function topDownInference() {
		var v:Tuple<String, Number> = Tuple.make('foo', 16);
		asserts.assert(v.v0 == 'foo');
		asserts.assert(v.v1 == 16);
		asserts.assert(v.v1.toHex() == '10');
		return asserts.done();
	}
}

abstract Number(Int) from Int to Int {
	public inline function toHex() {
		return StringTools.hex(this);
	}
}