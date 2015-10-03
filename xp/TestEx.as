/**
 * @author xp
 */
class xp.TestEx extends xp.Test{
	function get q(){
		return super.q+3;
	}
	static function main(){
		Flashout.log((new TestEx()).q)
	}
}