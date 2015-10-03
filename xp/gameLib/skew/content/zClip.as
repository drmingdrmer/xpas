import elements.sideElement.skew.*;
import elements.sideElement.skew.content.*;
class elements.sideElement.skew.content.zClip extends MovieClip implements _i_side_control
{
	#include "../../../../const.as"
	
	var _n_className="zClip";
	var _cn_zClip=true;
	//
	/**
				all zClip instance hs a length equal to _c_length ,or  100.
				
				
				*/
	//
	//total length,internal variable
	private var _n_len:Number;
	private var _n_RealLen:Number;
	private var _n_scl:Number;
	//
	private var pstn:Number;
	//
	//default value is 10.
	var segLength:Number;
	var segWidth:Number;
	//
	//store the original scale
	var xscl0:Number;
	var yscl0:Number;
	/**
				whether it is a rollback animation.
				*/
	var rollback:Boolean = false;
	function zClip (rb)
	{
		//
		xscl0 = _xscale;
		yscl0 = _yscale;
		//
		////_n_t ("segLength=" + segLength);
		//in a cycle,the 1st frame is the same as the last frame.
		_n_len = this._totalframes - 1;
		_n_RealLen = (_n_len - 1) / (_c_length - 1) * _c_RealLength;
		//
		if (rb != undefined)
		{
			////_n_t ("roll back flag not specified");
			rollback = rb;
		}
		
		//
		this.stop ();
	}
	function setPosition (pP:Number)
	{
		//////_n_t(pP);
		//snap real length to frame length.
		//real length is the distance from 0 to _c_RealLength,& just for convenience to use with width length(-1000~1000 in most).
		//here, pP is in _c_RealLength
		var full = pP;
		pP = pP / _c_RealLength * (_c_length - 1) + 1;
		//
		pP = Math.floor (pP);
		//
		if (full < 0)
		{
		//full = 0;
		}
		if (full > _n_RealLen)
		{
			full = _n_RealLen;
		}
		if (pP < 1)
		{
			pP = 1;
		}
		if (pP > _n_len)
		{
			pP = _n_len;
		}
		
		
		//current position; it is not the correct position.the distance is compensated with scaling
		var crt = (pP - 1) / (_c_length - 1) * _c_RealLength;
		
		//
		var scl = (_c_RealLength - crt + _c_RealX) / (_c_RealLength - full + _c_RealX);
		//////_n_t(crt+" "+full);
		this._xscale = xscl0 * scl;
		//for trim capatability
		this._yscale = yscl0 * scl;
		pstn = full;
		//
		this.gotoAndStop (pP);
	}
	function getPosition (seg:Number)
	{
		return pstn;
	}
	function getSegLength ():Number
	{
		if (segLength == undefined)
		{
			////_n_t ("warning: no segLength defined");
			return _c_defaultLength + 1;
			//1 seg.
			//1/_c_length*_c_RealLength
		}
		//in _c_RealLength
		return segLength;
	}
	function getSegWidth ():Number
	{
		if (segWidth == undefined)
		{
			////_n_t ("warning: no segWidth defined");
			return _c_element_max_width;
			//1 seg.
			//1/_c_length*_c_RealLength
		}
		return segWidth;
	}
}
