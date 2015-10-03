/**
 * @author 刘洋
 */
class Handler extends DisplayClip {
	
	
	static var selection:MovieClip;
	
	static function setHandler(h:Handler){
		if (h._parent==selection) return;
		
		selection["onLostFocus"]();
		
		selection=h._parent;
		selection["onGetFocus"]();
		
	}
	
	
	
	//static var __xp__init = AsBroadcaster.initialize(Handler.prototype);
	static var __xp__init = mx.events.EventDispatcher.initialize(Handler.prototype);
	
	var removeEventListener:Function;
	var addEventListener:Function;
	var dispatchEvent:Function;
	
	
	
	public function Handler() {
		this.addEventListener("onGetFocus",this._parent);
		this.addEventListener("onLostFocus",this._parent);
		
	}
	
	
	function onRelease(){
		setHandler(this);
	}
	
	function onRollOver(){
		dispatchEvent({type:"onOver"});		
	}
	
	
}
