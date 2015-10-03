class xp.system.Broadcaster extends MovieClip{
	
	static var _list:Array;
	
	
		
	static function createAutoBroadcaster (msg:String,prio:Number):MovieClip {
		var o = createBroadcasterClip (msg,prio);		
		o.autoBroadcast = o.broadcastMsg;
		return o;
	}
	 
	
	static function createManualBroadcaster (msg:String,prio:Number):MovieClip {
		var o = createBroadcasterClip (msg,prio);
		o.broadcast = o.broadcastMsg;
		return o;
	}
	
	
	private static function createBroadcasterClip (msg:String,prio:Number):MovieClip {
		if (prio==undefined || isNaN(prio)) prio=0;
		
		//enable createEmptyClassClip function.
		xp.SystemRepair.MovieClip_createEmptyClassClip();
		
		
		var dep:Number = xp.___.getSystemDepth ();		
		var o=_root.createEmptyClassClip(Broadcaster,"broadcaster" + dep,dep,{priority:prio});
		o.addMessage(msg,0);
		
		return o;
	}
	
	
	
	//
	static private var __xp__init__BroadcasterMX=mx.transitions.BroadcasterMX.initialize (Broadcaster.prototype);
	
	
	/**
	 * manually broadcast messagees.
	 */
	var broadcast:Function;	
	
	
	var priority:Number=0;
	var msg:String;
	var msgList:Array;
	
	
	
	//
	private var _enabled:Boolean = true;
	function set enabled (e:Boolean) {
		_enabled = e;
	}
	function get enabled ():Boolean {
		return _enabled;
	}
	
	
	
	
	//constructor
	function Broadcaster () {
		if (_list==undefined) {
			_list=new Array();
			//create total Broadcaster:
			var q=xp.___.getReservedClip();
			q._list=_list;
			q.onEnterFrame=function(){
				for (var i : Number = 0; i < this._list.length; i++) {
					this._list[i].ins["autoBroadcast"]();
				}
			}
		}
		_list.push({priority:this.priority,ins:this});
		_list.sortOn("priority",Array.NUMERIC);
		_enabled = true;
		msgList=new Array();
		
	}
	
	function addMessage(msg:String,order:Number):Boolean{
		
		for (var i : Number = 0; i < msgList.length; i++) {				
			if (msgList[i].msg==msg) return false;
		}
		
		msgList.push({order:order,msg:msg});
		msgList.sortOn("order",Array.NUMERIC);
		return true;
	}
	
	
	
	
	function deleteMessage(msg:String):Boolean{
		for (var i : Number = 0; i < msgList.length; i++) {				
			if (msgList[i].msg==msg){
				msgList.splice (i, 1);
				
				return true;
			}
		}
		return false;
	}
	
	
	
	
	
	//
	function broadcastMsg () {
		if (this._enabled) {
			for (var i : Number = 0; i < msgList.length; i++) {			
				this["broadcastMessage"] (this.msgList[i].msg);
			}
			updateAfterEvent ();
		}
	}
}
