/**
 * @author xp
 */
class xp.system.pool.Pool extends xp.system.MovieClipAdv{
	
	var pool:Array;
	var activeTable:Array;
	
	private var current:Number;
	
	
	
	public function Pool(n:Number) {
		createConstructor(arguments);
		var nn=Number(n);
		if (!isNaN(nn)) initPool(nn);
	}
	
	function initPool(n:Number){
		pool=new Array();
		activeTable=new Array(n);
		for (var i : Number = 0; i < n; i++) {
			var o=_createInstance(i)
			o.deactive();
			pool.push(o);
			activeTable[i]=false;
			
		}
		
		
		current=0;
	}
	
	
	//overWrite
	//fetch an instance from pool.if no instance available,return null.
	function getIns():Object{
		
		var i=current;
		while(activeTable[current]){
			
			current++;
			if (current>=pool.length)
				current=0;
			if (current==i){
				Flashout.info("cant assignate instance from Poll "+this);
				return null;
			}
		}	
		return pool[current];
	}
	
	
	
	//overWrite
	//call by instance..it must call this method after finish using a pool instance.
	function deactive(){
		Flashout.log(this+" deactivitated");
		this["__pool__"].activeTable[this["__ID__"]]=false;
	}
	
	
	function _createInstance(n):Object{
		var o:Object=createInstance();
		o.deactive=this.deactive;
		o.__ID__=n;
		o.__pool__=this;
		return o;
	}
	
	//overWrite:
	function createInstance():Object{
			
		return null;
	}
}