/*
what's new:
	state support,each state represented by a String,& to this state,linked 1 or more combos.in preview version,there is only 1 state:'normal'.
	now your designing a character is very easy with many state,by simply swiching the states of the character,you can make it know what can do & what cant do in some actions,or some progressing.& all are automate
	
	new addCombo method format,but compatible to earlier.
		param priority could be strings preset representing the priorities,which is the suggested value.
		in earlier version,a combo input without a =?-? time specifying will be set to be =0-10,now you can set a default value for all input without time specifying.
		& normally,you should send a stateList parameter,which containing all states this combo is for,
		
	
	method: resetBuffer:reset buffer size & clear buffer.you shouldnt use it as the game is running.
			state: change state
			getCombo:by id.
			addComboToState:

*/

/**
@author drmingdrmer 
@description 	receive buttons input & find out combos from them.for each picked-out combo,dispatches a specific event to each listener.<br>
			inputing data is an Object,in the format:<br>
			object[button_name]=button_stats;
@usage		ComboInput_Instance.addCombo("2,4,2,6,a",1,"heavyAttack");<br>
			this.heavyAttack=function(){trace("succeed");};<br>
			ComboInput_Instance.addListener(this);<br>
@see			ComboInput#addCombo
*/
class xp.gameLib.ComboInput extends MovieClip {
	//private static var __xp__init_broadcaster = mx.events.EventDispatcher.initialize (xp.gameLib.ComboInput.prototype);
	private static var __xp__init_broadcaster2 = mx.transitions.BroadcasterMX.initialize (xp.gameLib.ComboInput.prototype);
	//
	//
	private var broadcastMessage:Function;
	/** add a listener receiving all events emitted by ComboInput_instance.<br>
	that is different to dispatchEvent().
	*/
	var addListener:Function;
	/** remove a listener.
	*/
	var removeListener:Function;
	//
	private static var ____=initKeyInfo();
	private static function initKeyInfo(){
		_global._KD=1;
		_global._KU=2;
		_global._KH=3;
		_global._KR=4;
	}
	//
	
	private var __comboBroadcaster;
	//
	private var buffer:xp.dataType.ScrollBuffer;	
	//
	//
	static var prio:Object={super:0,
									 special_high:100,
									 special:200,
									 special_low:300,									 
									 command_high:400,
									 command:500,
									 command_low:600,
									 normal_high:700,
									 normal:800,
									 normal_low:900};
	//
	
	
	
	//
	private var allCombo:Array;
	private var stateComboList:Object;
	private var _state:String;
	private var comboList:Array;
	
	
	
	//
	//
	//
	//
	function addState(st:String){
		if (!stateComboList[st]){
			stateComboList[st]=new Array();
		}
	}
	
	function set state(st){
		if (stateComboList[st]){
			comboList=stateComboList[st];
			_state=st;
		}
		
	}
	function get state():String{
		return _state;
	}
	function listAllState(){
		var re:String="";
		for (var i in stateComboList) re+=i+",";
		return re.substring(0,re.length-1);
	}
		//
		//
		//
		//
		
		//
	
	
	//
	/**@description initializing..
	
	
	*/
	
	function ComboInput (bf:Number) {
		resetBuffer(bf);
		
		//
		allCombo=new Array();
		
		stateComboList={};
		addState("normal");
		state="normal";
		//
		if (__comboBroadcaster == undefined) {
			__comboBroadcaster = xp.system.Broadcaster.createAutoBroadcaster ("findCombo");
		}
		__comboBroadcaster.addListener (this);
	}
	
	/**
	 add a combo to combo-list.
	@param c 招数的数据，可以是一个字符串或一个数组。
		
	@param priority the priority of this combo,0 represent the highest priority.& higher lower.<br>
	                if the specified priority hs been existed.this combo will be add to after the combos with the same priority.<br>
					if priority is not a legal parameter,it 
	@param nm <b>String</b> the event name this combo linking to.It must be a legal method name of a object(the listener)
	@param io io.defaultDelay:delay frames for these input without specifying a time.<br>
	          io.stateList:list of states for which this combo is.it could be an Array of state's name,or string of state's name splited by ','
	@return id of this combo.
	*/
	function addCombo (c:Object, priority:Object, nm:String,io:Object) :Number{
		//convert string priority to nummeric priority;
		if (priority.constructor==String) priority=Number(prio[Number(priority)]);
		//check for undefined priority,set to normal as default.
		if (priority==undefined || isNaN(priority)) priority=prio.normal;
		//
		if (!io) io={};
		//without speicification,this combo is added to normal state only.
		if (io.stateList==undefined) io.stateList="normal";
		//convert string states list to array.
		if (io.stateList.constructor==String) io.stateList=io.stateList.split(",");
		//create combo.
		if (c.constructor == String) {
			c = new xp.gameLib.Combo (c,io.defaultDelay);
		}
		//add to combo list for all.& get a id for this combo,later being returned.
		var id;
		var exist=false;
		for (var t=0;t<allCombo.length;t++){
			if (c.equal(allCombo[t].combo)) {
				exist=true;
				id=t;
				break;
			}
		}
		
		if (!exist) id=allCombo.push ({combo:c, pri:priority, comboName:nm})-1;
		//for each state,add this combo.
		for (var i=0;i<io.stateList.length;i++){
			var st=io.stateList[i];
			if (!stateComboList[st]) stateComboList[st]=new Array();
			var sc=stateComboList[st];
			var j:Number;
			for (j=0;j<sc.length;j++){
				if (sc[j].combo.equal(c)){
					break;
				}
			}
			
			if (j==sc.length){
				sc.push(allCombo[id]);
				sc.sortOn("pri",Array.NUMERIC);
			}
			
			
		}
		//
		//
		return id;
	}
	//
	//
	//
	function addComboToState(id,st){
		if (!st) return;
		if (!stateComboList[st]) stateComboList[st]=new Array();
		var exist:Boolean=false;
		
		for (var i=0;i<stateComboList[st].length;i++){
			if (stateComboList[st][i].combo.equal(allCombo[id].combo)){
				exist=true;
				break;
			}
		}
		if (!exist){
			var sc=stateComboList[st];
			sc.push(allCombo[id]);
			sc.sortOn("pri",Array.NUMERIC);
		}
		return !exist;
	}
	
	
	
	//
	//
	//
	function getCombo(id:Number):String{
		return allCombo[id].combo.toString();
	}
	//
	//
	//
	
	
	
	function resetBuffer(bf:Number){
		if (bf==undefined || isNaN(bf)) bf=60;
		//
		buffer=new xp.dataType.ScrollBuffer(bf);
		//buffer=new xp.gameLib.KeyBuffer(bf);
		
	}
	
	
	
	
	/**button event handler<br>
				receive 'button' event from KeyMapper or you can call this method manually
				
	@param eo <b>Object</b> event Object.its property 'btn' store buttons data. 
				
	*/
	function button (eo) {
		
		buffer.addObj(eo.btn);
	}
	
	//main function,find out a combo from buffer.and dispatch a message.
	private function findCombo () {
		//trace ("");
		for (var i = 0; i < comboList.length; i++) {
			var o = comboList[i].combo;
			var f = o.testCombo(buffer);
			if (f) {
				broadcastMessage (comboList[i].comboName);
				//no more than one combo for every frame
				return;
			}
		}
	}
	
	
	
}
