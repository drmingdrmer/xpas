import elements.sideElement.skew.*;
import elements.sideElement.skew.content.*;
import elements.sideElement.skew.trim.*;

/**
this class 
@class
*/
class elements.sideElement.skew.arbitarySkew extends skewCon implements _i_trim_control
{
	[Inspectable(defaultValue="", type="String")]
	var farTrimName:String;
	[Inspectable(defaultValue="", type="String")]
	var nearTrimName:String;
	//main mask clip
	var maskClip:MovieClip;
	//trim mask clip:
	var wMask:MovieClip;
	var farTrim:MovieClip = undefined;
	var nearTrim:MovieClip = undefined;
	//
	//
	//
	/**
		<p>this class implements the skew functionality.fjdsaklf;jdsakl;fjdsalkf;djsalkf;dsajkfl;dsajfdks;lafjdsalk;fdjsla</p>
		<p>	component parameters:</p>
		
		@param attachClip String the content movieClip's linkage name.
		@see attachClip
		
		<p>contructor:</p>
			
		@param noParameters
		
		@summary this class implements the skew functionality.
		
		@class
		
		
		*/
	function arbitarySkew ()
	{
		super ();
		maskClip = this.a.o.tMask;
		wMask = maskClip.wMask;
		if (!_global.debugMode)
		this.a.o.setMask (maskClip);
		
		//
		addFarTrim (farTrimName);
		addNearTrim (nearTrimName);
	}
	//
	//___________________________________________________________________________trim
	//contruction
	function addFarTrim (pN:String):Boolean
	{
		farTrim = maskClip.attachMovie (pN, "ft", _c_farTrimDepth);
		return subTrimMask (farTrim) != null;
	}
	function addNearTrim (pN:String):Boolean
	{
		nearTrim = maskClip.attachMovie (pN, "nt", _c_nearTrimDepth);
		return subTrimMask (nearTrim) != null;
	}
	function delFarTrim ():Boolean
	{
		if (!farTrim)
		{
			return false;
		}
		farTrim.removeMovieClip ();
		return true;
	}
	function delNearTrim ():Boolean
	{
		if (!nearTrim)
		{
			return false;
		}
		nearTrim.removeMovieClip ();
		return true;
	}
	//operation
	function setFP (pP:Number)
	{
		farTrim.setPosition (pP);
	}
	function setNP (pP:Number)
	{
		nearTrim.setPosition (pP);
	}
	function getFP ()
	{
		return farTrim.getPosition ();
	}
	function getNP ()
	{
		return nearTrim.getPosition ();
	}
	//
	function setWidth (pW:Number)
	{
		var o = _c_element_max_width;
		if (pW > o)
		{
			pW = o;
		}
		if (pW < 1)
		{
			pW = 1;
		}
		wMask._yscale = pW / o * 100;
	}
	function getWidth ()
	{
		return wMask._yscale / 100 * _c_element_max_width;
	}
}
