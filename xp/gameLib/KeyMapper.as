/*
release note : a bit faster.



*/


/**
 * @author drmingdrmer

* 
*		
*		
*		<b>HTML</b> or other meta characters.

* 

*/
/**@description 	KeyMapper maps Key input to specific virtual buttons.<br>
*			KeyMapper stores many maps,& you could choose any 1 of them.<br>
			KeyMapper dnt supply a user interface to config keys map.<br>
			<br>
*@description KeyMapper dispatchs 'button' event in every frame,with a property 'btn' in event object,indicate 
*		  which virtual button(not key) hs been pressed or released.<br>
			<br>
*		  KeyMapper add 4 variables to _global indicating 4 states of the virtual buttons<br>
*		  _global._KD : button hs just been preesed.<br>
*		  _global._KU : button hs just been released.<br>
*		  _global._KH : button is keeping hold pressed.<br>
*		  _global._KR : button is keeping released.<br>
*@usage function button(eo){ <br>
*	    //test if button 'fist" pressed<br>
*         if (eo.btn["fist"]==_KD){....}<br>
*	  }
*
*@since	Flash MX 2K4 or later
*/
//[Event("button")]
//[Event("mapChanged")]
class xp.gameLib.KeyMapper extends MovieClip {
	//
	//
	private static var __xp__init_broadcaster = mx.events.EventDispatcher.initialize (xp.gameLib.KeyMapper.prototype);
	//
	private static var __keyScanBroadcaster;
	private var broadcastMessage:Function;
	private var addListener:Function;
	private var removeListener:Function;
	//
	/**  
			add a event listener
			@description add a event listener
			*	@usage addEventListener("button",ur_Obj);
			*/
	var addEventListener:Function;
	/**  remove a event listener
			@description remove a event listener
			*	
			*/
	var removeEventListener:Function;
	private var dispatchEvent:Function;
	//
	//
	//buttons used in a app/game mapping to keyboards.
	private var buttons:Array;
	//
	//1:down        2:up         3:hold        4:released
	private var buttonStatus:Object;
	static var KD = 1, KU = 2, KH = 3, KR = 4;
	static var keyName:Array=["","KD","KU","KH","KR"];
	private static var ____ = initKeyInfo ();
	private static function initKeyInfo () {
		_global._KD = 1;
		_global._KU = 2;
		_global._KH = 3;
		_global._KR = 4;
	}
	//
	private var maps:Array;
	private var mapI:Number = 0;
	//
	//
	private var _enabled:Boolean = false;
	//
	/** setter/getter parameter enable or disable itself.
			
			*/
	function set enabled (e:Boolean) {
		_enabled = e;
		if (_enabled) {
		}
	}
	function get enabled ():Boolean {
		return _enabled;
	}
	//
	//
	/**@description initialize KeyMapper & start it to work.
			*	@param b button's names used as virtual buttons,2 types allowed:<br>
			*		<b>String:</b>	names delimited by ',' , for example,the codes below defines 3 buttons:<br>
			*					"fist,kick,jump".<br>
			*		<b>Array</b>	buttons names Array,for example: ["fist","kick","jump"]<br>
			*					this is the same as the string parameter above.<br>
					<br>
					KeyMapper use a default buttons set of ["8", "2", "6", "4", "a", "b", "c", "d"].<br>
			*	@param m no use in this version.<br>
					
			*@description 	
						KeyMapper add 2 maps & use the 1st one as default map.<br>
						This map maps the default buttons to (W,S,A,D,U,I,J,K).<br>
						If u use ur own buttons set,u must define ur own maps using {@link KeyMapper#addMap}
			*@usage		new KeyMapper("fist,kick,jump");<br>
						new KeyMapper(["fist","kick","jump"]);
			*/
	function KeyMapper (b:Object, m:Array) {
		
		//
		if (__keyScanBroadcaster == undefined) {
			__keyScanBroadcaster = xp.system.Broadcaster.createAutoBroadcaster ("dispatchKey");
		}
		__keyScanBroadcaster.addListener (this);
		//
		//
		maps = new Array ();
		//
		if (b != undefined) {
			
			setButtons (b);
		}
		else {
			//up,down,front,back.....
			setButtons(["8", "2", "6", "4", "a", "b", "c", "d"]);
			
		}
		buttonStatus = new Object ();
		for (var i in buttons) {			
			buttonStatus[buttons[i]]=KeyMapper.KR;
		}
		//map1//inversed map1
		addMap([87, 83, 68, 65, 85, 73, 74, 75]);		
		addMap([87, 83, 65, 68, 85, 73, 74, 75]);
		switchMap(0);
		//
		
		enabled=true;
	}
	//
	//
	//
	/**add a key map
			@description Add a map.
			@param m Array of key code.<br>
				it simply add an Array to stack,& dnt check for duplicate.
			@return The index of the new map in stacks.
			
			*/
	function addMap (m:Array):Number {
		return maps.push (m) - 1;
	}
	/** select a map to use
			
			
			*/
	function switchMap (i:Number) {
		if (i > maps.length) {
			i = maps.length;
		}
		if (i < 0) {
			i = 0;
		}
		mapI = i;
	}
	//
	//
	/** set the button set.
			@description 
			
			@param b String delimited by ',' or Array of String.
			
			
			*/
	function setButtons (b:Object) {
		if (typeof (b) == "string") {
			buttons = b.split (",");
		}
		else if (Array (b) != null) {
			this["buttons"] = b;
		}
		trace ("buttons set to " + buttons);
	}
	/** get buttons set;
			*/
	function getButtons ():Array {
		return buttons;
	}
	//
	//
	/**get currently used map.or get the specified map.
			
			
			*/
	function getMap (i:Number):Array {
		if (i == undefined || isNaN (i)) {
			i = mapI;
		}
		return maps[i];
	}
	/**get a button's mapping key code.
			@param q button name,that must be in KeyMapper's buttons set.
			@return key code.
			*/
	function getMappedKey (q:String):Number {
		for (var i in buttons) {
			if (buttons[i] == q) {
				return maps[mapI][i];
			}
		}
		return undefined;
	}
	//
	//main function dispatch events every frame to listener.
	private function dispatchKey () {
		if (!_enabled) {
			return;
		}
		var bf:Object = new Object ();
		for (var i = 0; i < buttons.length; i++) {
			var bb = buttons[i];
			var mp = maps[mapI][i];
			
			
			
			//
			var down = false;
			if (mp.constructor == Array) {
				for (var mi = 0; mi < mp.length; mi++) {
					down = Key.isDown (mp[mi]);
					if (down) {
						break;
					}
				}
			}
			else {
				down = Key.isDown (mp);
			}
			//
			var lst=buttonStatus[bb];
			if (lst==KeyMapper.KD) buttonStatus[bb]=KeyMapper.KH;
			else if (lst==KeyMapper.KU) buttonStatus[bb]=KeyMapper.KR;
			
			//
			var hold = buttonStatus[bb] == KeyMapper.KH;
			
			//
			if (down && !hold) {
				buttonStatus[bb] = KeyMapper.KD;
			}
			else if (!down && hold) {
				buttonStatus[bb] = KeyMapper.KU;
			}
			
			//
			bf[bb] = buttonStatus[bb];
		}
		
		this.dispatchEvent ({type:"button", btn:bf});
		
	}
}
