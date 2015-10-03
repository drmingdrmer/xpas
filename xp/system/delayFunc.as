class xp.system.delayFunc extends MovieClip{
	//
	//inner class:
	private static var __instant:MovieClip;

	
	private var fList:Array;
	
	static function initialize (o:Object) {
		
		xp.SystemRepair.MovieClip_createEmptyClassClip();
		
		//create a invoker for all object.
		if (__instant == undefined) {
			__instant = _root.createEmptyClassClip (delayFunc,"__instant", xp.___.getSystemDepth ());			
		}
		
		//
		o.delayFunction = __instant.delayFunction;
	}
	
	
	function delayFunc(){
		fList=new Array();
	}
	
	
	function onEnterFrame(){
		var oldf = this.fList;
		this.fList = new Array ();
		for (var i = 0; i < oldf.length; i++) {
			var o = oldf[i];
			o._func.apply (o._this, o._arg);
		}
			
		
	}
	
	
	function delayFunction (func:Function, arg:Array, o:Object) {
		
		if (o == undefined) {
			o = this;
		}
		__instant.fList.push ({_this:o, _func:func, _arg:arg});
	}
	
	
	
	
	
}
