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
		return asserts.done();
	}
	public function tuple3() {
		var v = new Tuple<Int, String, Bool>(1, 'foo', true);
		asserts.assert(v.v0 == 1);
		asserts.assert(v.v1 == 'foo');
		asserts.assert(v.v2);
		return asserts.done();
	}
}