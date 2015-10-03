/**
 * @author xp
 * chaser is not in the team of Target/SimpleTarget<br>
 * it is a another way to implement chasing.
 */
class xp.gameLib.chase.Chaser extends MovieClip{
	
	static var impulser:MovieClip;
	
	static var defaultPropList:Object={
		_x:1,
		_y:1,
		_xscale:1,
		_yscale:1,
		_width:1,
		_height:1,
		_rotation:1,
		_alpha:1
		};
	
	
	var propList:Object;
	
	
	
	/**
	 * mc list	 */
	private var mlist:Array;
	/**
	 * 	 */
	var totalWeight:Number;
	
	
	
	
	public function Chaser() {
		if (impulser==undefined){
			impulser=xp.system.Broadcaster.createAutoBroadcaster("callChase",2);			
		}
		impulser.addListener(this);
		
		
		propList=new Object();
		for (var i in defaultPropList){
			propList[i]=defaultPropList[i];
		}
			
		
		mlist=new Array();
		totalWeight=0;
		
	}
	
	function addTarget(m:MovieClip,w:Number){
		if (!m) return;
		if (w==undefined || isNaN(w)) w=1;
		mlist.push({w:w,ins:m});
		totalWeight+=w;
	}
	
	
	//broadcast event:
	function callChase(){
		var eo:Object=new Object();
		var tx=0;
		var ty=0;
		for (var j : Number = 0; j < mlist.length; j++) {
			tx+=mlist[j].ins._x*mlist[j].w;
			ty+=mlist[j].ins._y*mlist[j].w;
			
		}
		eo._x=tx/totalWeight;
		eo._y=ty/totalWeight;
		
		//for compatible
		eo.ins=eo;
		eo.geo=eo;
		
		
		//subclass implement onChase by get/set function !!
		this["onChase"](eo);
	}
	
	
	
	
}