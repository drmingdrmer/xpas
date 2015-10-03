//game protocal:
/*
all parameter values are integer.



*/
//game define:
/*

normal run------slow down when beat an obstacle
deadly run------never slow down even when beat an obstacle,but more damage.


*/
//constants definition
/*
instru:
_n_:internal property or function 
_e_:event name OR event receiver function name
_c_:constant variable;
_i_:interface
p:parameter





*/
//
class xp.gameLib.skew._ extends xp.___ {

	
	
	static var _c_RealLength = 1000;
	static var _c_length:Number = 100;
	static var _c_element_max_width = 250;
	static var _c_screen_w = 1000;
	static var _c_screen_h = 1000;
	static var _c_farTrimDepth = 7;
	static var _c_nearTrimDepth = 6;
	static var _c_defaultLength = 10;
	//
	static var _c_a = 34;
	static var _c_b = 500;
	//far point scale div near point scale.
	static var _c_farNearRate = 34 / 500;
	//the distance from near point to camera
	static var _c_x = _c_length * _c_a / (_c_b - _c_a);
	static var _c_RealX = _c_RealLength * _c_a / (_c_b - _c_a);
	
	
	
	//
	static var _c_viewRangeMin = -_c_RealLength;
	static var _c_viewRangeMax = _c_RealLength;
	//
	static var _c_maxDepth=1048575;
	static var _c_warningDepth=1040000;
	
	//
	
	static var _c_minDep = 1000;
	static var _c_maxDep = 1000000;
	static var _c_layerH = 10000;
	static var _c_localPlaneH = 200;
	static var _c_localPointH = _c_layerH - _c_localPlaneH - 1;
	static var _c_layerNumber = (_c_maxDep - _c_minDep) / _c_layerH;
	//
	static var _c_simpleLayerH = 200000 - 1;
	static var _c_simpleLayerL = 6;
	//
	//static var _c_itemU=900000;//9*10^5
	static var _c_itemL = 700001;
	//
	//static var _c_wayU=600000;
	static var _c_wayL = 400001;
	//
	//static var _c_outU=300000;//3*10^5
	static var _c_outL = 100001;
	//
	//condition def:
	//1 : this is up to target.
	//-1:this is below target.
	//0: this is splited by target.
	static var _c_up = 1;
	static var _c_down = -1;
	static var _c_slice = 0;
	//
	static var _c_big = 2;
	static var _c_small = -2;
	static var _c_bigBoth = 1;
	static var _c_smallBoth = -1;
	//type:
	static var _c_point = 1;
	static var _c_wall = 2;
	static var _c_side_wall = 4;
	//min thick
	//mini thick
	static var _c_thick = 0;
	static var _c_nthick=-50;
	//mini radius
	static var _c_radius=5;
	//
	static var _c_velocityMax=(_c_thick-_c_nthick+_c_radius*2)*.98;
	//view radius ,
	static var _c_viewRadius = 40;
	//
	static var _c_activeRange=_c_RealLength;
	//
	static var _c_weaponLength = 30;
	
	
	
	static var _c_weaponMagnify = _c_RealLength * _c_a / (_c_b - _c_a)/*_c_RealX*//_c_weaponLength;
	static var _c_weaponRealX = 15;
	static var _c_weaponRealY = 15;
	static var _c_weaponViewX = 22.5//_c_weaponRealX * _c_weaponMagnify;
	static var _c_weaponViewY = 22.5//_c_weaponRealY * _c_weaponMagnify;
	//
	static var _n_field = {x:0, y:0, p:0};
	static var _c_e=1.5
	//
	//
	//
	//
	static var _c_debug =false;// true;
	//
/*
function _n_getName (p:Function):String {
	var f = _global["ASSetPropFlags"];
	for (var _p = this; _p != undefined; _p = _p.__proto__) {
		f (_p, null, 0, true);
	}
	for ( var i in this) {
		//debugUtility.debugPanel.traceDebug (i);
		if (p == this[i]) {
			return i;
		}
	}
}
function _n_t (s) {
	if (!_c_debug) {
		return;
	}
	var nm = _n_getName (arguments.caller);
	var ths = typeof (this) == "movieclip" ? this : this._n_className;
	debugUtility.debugPanel.traceDebug (ths + "[ " + nm + " ]");
	_n_CS ();
	debugUtility.debugPanel.traceDebug (s);
	debugUtility.debugPanel.traceDebug ("\n");
}
function _n_warn (s) {
	if (!_c_debug) {
		return;
	}
	var nm = _n_getName (arguments.caller);
	var ths = typeof (this) == "movieclip" ? this : this._n_className;
	debugUtility.debugPanel.traceDebug (ths + "[ " + nm + " ]");
	_n_CS ();
	debugUtility.debugPanel.traceDebug ("****   warning *****    :" + s);
	debugUtility.debugPanel.traceDebug ("\n");
}
function _n_FS () {
	if (!_c_debug) {
		return;
	}
	 var nm = _n_getName (arguments.caller);
	 var ths = typeof (this) == "movieclip" ? this : this._n_className;
	 var str = ths + "[ " + nm + " ]";
	//
	_n_addToCallStack (str + "   ");
	_global[_global.stack] = new Date ().getTime ();
	//
	//debugUtility.debugPanel.traceDebug (str + "----------START");
	//_n_CS ();
	//debugUtility.debugPanel.traceDebug ("\n");
}
function _n_FE () {
	if (!_c_debug) {
		return;
	}
	 var nm = _n_getName (arguments.caller);
	 var ths = typeof (this) == "movieclip" ? this : this._n_className;
	 var str = ths + "[ " + nm + " ]";
	 var tm:Number = new Date ().getTime () - _global[_global.stack];
	_n_removeFromCallStack (str + "   ");
//	debugUtility.debugPanel.traceDebug (str + "----------END");
//	_n_CS ();
//	debugUtility.debugPanel.traceDebug ("time cost : " + tm);
//	debugUtility.debugPanel.traceDebug ("\n");
}
function _n_uncr (s) {
	if (!_c_debug) {
		return;
	}
	 var nm = _n_getName (arguments.caller);
	 var ths = typeof (this) == "movieclip" ? this : this._n_className;
	debugUtility.debugPanel.traceDebug (ths + "  [ " + nm + " ]----------");
	debugUtility.debugPanel.traceDebug ("**** uncorrect parameter *****    :\n");
	debugUtility.debugPanel.traceDebug ("instance: " + s);
	debugUtility.debugPanel.traceDebug ("class: " + s._n_className);
	debugUtility.debugPanel.traceDebug ("\n");
}
function _n_addToCallStack (str:String) {
	if (!_c_debug) {
		return;
	}
	if (_global.stack == undefined) {
		_global.stack = "";
	}
	_global.stack = str + _global.stack;
}
function _n_removeFromCallStack (str:String) {
	if (!_c_debug) {
		return;
	}
	if (_global.stack == undefined) {
		return;
	}
	 var s = _global.stack.indexOf (str) + str.length;
	_global.stack = _global.stack.substring (s);
}
function _n_CS () {
	if (!_c_debug) {
		return;
	}
	debugUtility.debugPanel.traceDebug ("===" + _global.stack);
}

/*
	function onEnterFrame(){
		if (Key.isDown(Key.CONTROL) && Key.isDown(68))
		_n_debug();
	}
	function _n_debug(){}
	*/
	

}