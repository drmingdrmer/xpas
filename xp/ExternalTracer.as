/**
 * @author xp
 */
class xp.ExternalTracer extends LocalConnection{
	
	var connectName:String="debug";
	
	static private var _instance:ExternalTracer;
	
	
	public function ExternalTracer() {
		super();
	}
	
	
	static function initialize(o:Object){
		
		if (_instance==undefined) _instance=new ExternalTracer();
		_global._tr=_instance.eTrace;
		Object.prototype._tr=_instance.eTrace;
		
	}
	
	function eTrace(o:Object){
		trace("sending"+o.toString());
		ExternalTracer._instance.send(ExternalTracer._instance.connectName,"log",o);
	}
	
	function onStatus(io:Object){
		if (io.level){
			trace("con");
		}
		else
		{
			trace("dis");
		}
				
	}
}