import xp.system.Broadcaster;
import xp.gameLib.chase.ChasingEventObj;
class xp.gameLib.chase.ChaseDelegateObject {
	
	private static var __xp__init_eventDispatcher = xp.events.EventDispatcher.initialize (ChaseDelegateObject.prototype);
	var dispatchEvent:Function;
	var addEventListener:Function;
	var removeEventListener:Function;
	
	
	
	/**
	 * for which this delegate object works for.	 */
	var chaser:Object;
	
	
	
	/**
	 * name of category	 */
	var setName:String;
	
	
	
	/**
	 * {weight:0,ins:o}	 */
	var targetList:Array;
	
	
	/**
	 * properties list	 */
	static var propList:Object={
		_x:1,
		_y:1,
		_xscale:1,
		_yscale:1,
		_width:1,
		_height:1,
		_rotation:1,
		_alpha:1
		};
	
	
	
	/**
	 * broadcaster for summarying target data.	 */
	static var impulser:MovieClip;
	
	
	function ChaseDelegateObject(o:Object,n:String){
		
		if (o!=undefined) chaser=o;
		if (n!=undefined) setName=n;		
		
		addEventListener("onChase",o);
		
		if (impulser==undefined){
			impulser=xp.system.Broadcaster.createAutoBroadcaster("chasingEvent",2);			
		}
		impulser.addListener(this);
		
		targetList=new Array();			
		
		implementChaserFunction(o.__proto__);
	}
	
	
	/**
	 * add some function to chaser for manipulate target. 	 */
	 
	function implementChaserFunction(o:Object){
		
	}
	
	
	
	function addTarget(t:Object,w:Number){
		
		if (t==undefined) return;
		if (w==undefined || isNaN(w)) w=1;
		
		for (var i : Number = 0; i < targetList.length; i++) {
			if (targetList[i].ins==t) return;
		}
		targetList.push({weight:w,ins:t});
		
		
		implementTargetFunction(t.__proto__);
	
	}
	
	
	
	
	/**
	 * add some function to target.__proto__ if needed.<br>
	 * for example:colorTransform 	 */
	function implementTargetFunction(t:Object){
		
	}
	
	
	
	
	
	
	/**
	 * [event]
	 * collect eos from Target,& send a delegate EO to chaser<br>
	 * invoked in each frame.
	 */
	function chasingEvent(){
		//Flashout.log("chasingEvent");
		//
		var eo:ChasingEventObj=new ChasingEventObj("onChase");
		
		
		//summing:
		for (var j : String in propList) {
			
			var totalweight:Number=0;
			if (eo.eoSum[j]==undefined) eo.eoSum[j]=0;
			
			for (var i : Number = 0; i < targetList.length; i++) {
				
				var ins=targetList[i].ins;
				var w=targetList[i].weight;	
				
				if (targetList[i].ins[j]!=undefined) eo.eoSum[j]+=targetList[i].ins[j];
				
				totalweight+=w;
								
			}
			eo.eoSum[j]/=totalweight;
			
	
		}
		
		
		eo.setName=this.setName;
		
		/**
		 * dispatch event<br>
		 * 'c there is only 1 listener for each delegate,call onChase directly.
		 */
		dispatchEvent(eo);
		
	}
	
	
}