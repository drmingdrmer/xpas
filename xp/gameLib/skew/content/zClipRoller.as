import elements.sideElement.skew.*;
import elements.sideElement.skew.content.*;
class elements.sideElement.skew.content.zClipRoller extends MovieClip implements _i_side_control {
	#include "../../../../const.as"
	var _n_className = "zClipRoller";
	var _cn_zClipRoller = true;
	//
	//
	//
	//amount of segments
	[Inspectable(defaultValue=1,type="Number")]
	var rollN:Number;
	//the zclip to use as contents.
	[Inspectable(defaultValue="",type="String")]
	var zClipName:String;
	//
	//
	var segLength:Number;
	var segWidth:Number;
	//distance between 2 seg.
	private var _n_step:Number;
	//
	//
	//
	function zClipRoller () {
		if (rollN == undefined || isNaN (rollN)) {
			rollN = 6;
		}
		if (zClipName == undefined) {
			zClipName = "road";
		}
		//
		if (rollN == 0) {
			_n_step = _c_RealLength;
		}
		else {
			_n_step = _c_RealLength / rollN;
		}
		//if only 1 seg.
		
		for (var i = 0; i <= rollN; i++) {
			var s = this.attachMovie (zClipName, "z" + i, 10 + i, {segLength:segLength});
			s.setPosition (_n_step * i);
		}
	}
	//
	function setPosition (pP:Number) {
		//////_n_t (pP);
		
		pP = pP - Math.floor (pP / _n_step) * _n_step;
		
		
		for (var i = 0; i <= rollN; i++) {
			var s = this["z" + i];
			s.setPosition (_n_step * i + pP);
		}
	}
	function getPosition (seg:Number) {
		//////_n_t(seg);
		if (seg == undefined) {
			seg = rollN;
		}
		seg = Math.floor (Number (seg));
		if (seg < 0 || seg > rollN) {
			seg = rollN;
		}
		return this["z" + seg].getPosition ();
	}
	//
	function getSegLength ():Number {
		return segLength;
	}
	function getSegWidth ():Number {
		return segWidth;
	}
}
