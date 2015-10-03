
class xp.events.BroadcasterMX {
	private var _listeners:Array;
	
	static function initialize (o:Object, dontCreateArray:Boolean) {
		if (o.broadcastMessage != undefined) delete o.broadcastMessage;
		o.addListener = mx.transitions.BroadcasterMX.prototype.addListener;
		o.removeListener = mx.transitions.BroadcasterMX.prototype.removeListener;

		
	}

	function addListener (o:Object):Number {
		this.removeListener (o);
		if (this.broadcastMessage == undefined) {
			this.broadcastMessage = xp.events.BroadcasterMX.prototype.broadcastMessage;
			//_global.ASSetPropFlags (this, "broadcastMessage", 1);
		}
		/**
		 * create Array dynamically.		 */
		if (this._listeners==undefined) this._listeners=new Array();
		
		return this._listeners.push(o);
	}
	
	function removeListener (o:Object):Boolean {
		var a:Array = this._listeners;	
		var i:Number = a.length;
		while (i--) {
			if (a[i] == o) {
				a.splice (i, 1);
				if (!a.length) this.broadcastMessage = undefined;
				return true;
			}
		}
		return false;
	}
	
	function broadcastMessage ():Void {
		var e:String = String(arguments.shift());
		/**
		 * ??????		 */
		var a:Array = this._listeners.concat();
		var l:Number = a.length;
		for (var i=0; i<l; i++) a[i][e].apply(a[i], arguments);
	}

};
