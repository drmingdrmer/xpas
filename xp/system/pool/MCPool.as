/**
 * @author xp
 */
class xp.system.pool.MCPool extends xp.system.pool.Pool{
	
	static private var __xp__init=xp.SystemRepair.repair();
	
	//to which pool add mc.
	var targetMC:MovieClip
	
	
	
	var _insClass:Function;
	var _insSymbol:String;
	
	
	function get insClass():Function{
		return _insClass;
	}
	function set insClass(f:Function){
		_insClass=f;
		_insSymbol=undefined;		
	}
		
	function get insSymbol():String{
		return _insSymbol;
	}
	function set insSymbol(s:String){
		_insSymbol=s;
		_insClass=undefined;		
	}
	
	
	
		
	public function MCPool() {
		createConstructor(arguments);
		//default target mc is itself.
		targetMC=this;
	}
	
	
	//overWritten
	function createInstance():MovieClip{
		
		var d=targetMC.getNextHighestDepth();
		var o:MovieClip;
		if (_insSymbol!=undefined){
			
			o=targetMC.attachMovie(_insSymbol,"poolIns"+d,d);
			Flashout.info("create mc using symbol for MCPool "+this);
		}
		else if (_insClass!=undefined){
			o=targetMC.createEmptyClassClip(_insClass,"poolIns"+d,d);
			Flashout.info("create mc using Class for MCPool "+this);
		}
		else {
			o=targetMC.createEmptyMovieClip("poolIns"+d,d);
			Flashout.info("create normal mc for MCPool "+this);			
		}
		
		return o;
	}
	
	
	
	
	//overWritten:
	function getIns():MovieClip{
		var o=super.getIns();
		o._visible=true;
		return o;
		
	}
	
	
	
	//overWritten.
	//do something clearing
	function deactive(){
		
		this._visible=false;
		
		super.deactive();
	}
}