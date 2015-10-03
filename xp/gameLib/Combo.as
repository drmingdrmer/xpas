/**
	input format:
	keyName[([KD][KH][KU][KR])][=[start]-[end]],[],[];
	*/
class xp.gameLib.Combo {
	/** 
		default delay frames between 2 input
		*/
	#include "../inc/traceUti.as"
	private static var __init__xp_tr = xp.TraceUti.initialize (Combo.prototype);
	//
	var inputDelay:Number = 10;
	//frame;
	//
	private var iList:Array;
	//string of this combo.
	private var str:String=undefined;

	function Combo (i:Object,defaultDelay:Number) {
		if (defaultDelay==undefined || isNaN(defaultDelay)) defaultDelay=10;
		inputDelay=defaultDelay;
		setInputList (i);
		
	}
	function setInputList (q:Object) {
		if (typeof (q) != "string") {
			this["iList"] = q;
		}
		else {
			iList = q.split (",");
			for (var i = 0; i < iList.length; i++) {
				iList[i] = analyse (iList[i]);
				//traceAll (iList[i]);
			}
		}
	}
	function analyse (str:String):Object {
		var r:Object = {};
		var o = str.split ("=");
		//key info
		var k = o[0];
		//input time
		var t = o[1];
		//
		//
		var b1 = k.indexOf ("(");
		var b2 = k.indexOf (")");
		if (b1 == -1) {
			r.button = k;
			r.state = "KD";
		}
		else {
			r.button = k.substring (0, b1);
			r.state = k.substring (b1 + 1, b2);
		}
		//convert string to number.
		var br = r.state;
		r.state = xp.gameLib.KeyMapper[br];
		//
		if (r.state == undefined) {
			r.state = xp.gameLib.KeyMapper.KD;
		}
		//
		//
		var tm = t.split ("-");
		//default delay is 0.
		r.sTime = (tm[0] == undefined || isNaN (tm[0])) ? 0 : Number (tm[0]);
		r.eTime = (tm[1] == undefined || isNaN (tm[1])) ? inputDelay : Number (tm[1]);
		if (r.eTime < r.sTime) {
			r.eTime = r.sTime;
		}
		//
		return r;
	}

	
	function testCombo(bf:xp.dataType.ScrollBuffer):Boolean{
		var b=0;
		var s1,s2;
		var j;
		for (var i=iList.length-1;i>=0;i--){
			var o=iList[i];
			s1=b-o.eTime;
			s2=b-o.sTime;
			var hasInput=false;
			for (j=s2;j>=s1;j--){
				var inp=bf.getObj(j);
				if (inp==undefined) return false;
				if (inp[o.button]==o.state){
					b=j;
					hasInput=true;
					break;
					
				}
				
			}
			//
			if (!hasInput) return false;
			
			
		}
		//
		return true;
		
		
	}
	
	function equal(c:Combo):Boolean{
		return c.string==this.string;
	}
	
	
	function get string(){
		return toString();
	}
	
	
	function toString():String{
		if (str!=undefined) return str;
		var re:String="";
		for (var i=0;i<iList.length;i++){
			var o=iList[i];
			var st=o.state;
			re+=o.button+"("+xp.gameLib.KeyMapper.keyName[st]+")="+o.sTime+"-"+o.eTime;
			if (i!=iList.length-1) re+=","
			
		}
		str=re;
		return str;
		
	}
	
	
}
