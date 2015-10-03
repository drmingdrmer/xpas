/**
 * @author xp
 */
class xp.system.MovieClipAdv extends MovieClip{
	var constructor:Function;
	function MovieClipAdv(){
		constructor=arguments.caller;
	}
	
	
	/**
	 * @param a arguments instance.	 */
	function createConstructor(a:Object){
		//implement constructor Property.
		//only for sub Class.
		if (a.caller.prototype.constructor==a.callee)
		{
			constructor=a.caller;
		}
	}
}