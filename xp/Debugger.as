/**
 * @author xp
 */
class xp.Debugger extends LocalConnection{
	
	private static var __xp__init__eventDispatcher=xp.events.EventDispatcher.initialize(Debugger.prototype);
	
	var addEventListener:Function;
	var removeEventListener:Function;
	var dispatchEvent:Function;
	
	
	function log(i:Object){
		var eo:Object={type:"log",msg:i};
		dispatchEvent(eo);
	}
	
	
	
	
	
	
	
	
	
	
	////////////////////
	
	
	function Debugger(){
		connect("debug");		
	}
	
	
}