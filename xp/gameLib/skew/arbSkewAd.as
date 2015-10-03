import dateType.*;
import elements.sideElement.skew.*;
import elements.sideElement.skew.content.*;

/**
	function added:
		slope
		rotate
		volume control.

*/
class elements.sideElement.skew.arbSkewAd extends arbitarySkew implements _i_skewAd
{
	/**
	description of the slope of the element.
	
	*/
	var bvl:bevel;
	/**
	vanish point height in ver
	*/
	private var uu:Number;
	/**
@param alp Number ori angle.
@param _u Number ori height


*/
	function arbSkewAd (alp:Number, _u:Number)
	{
		super ();
		if (alp != undefined && _u != undefined)
		{
			_rotation = alp;
			_x = _u * Math.cos (alp*Math.PI/180+Math.PI/2);
			_y = _u * Math.sin (alp*Math.PI/180+Math.PI/2);
		}
		else
		{
			_u = 0;
		}
		uu = _u;
		bvl = new bevel (_u);
	}
	//over write:
	function setSkew (x, y)
	{
		//_n_FS();
		var xx0=x;
		var yy0=y;
		var a=Math.atan2(y,x);
		var l=Math.sqrt(x*x+y*y);
		
		var r=a-_rotation/180*Math.PI;
	
		x=Math.cos(r)*l;
		y=Math.sin(r)*l;
		//
		var dy = bvl.stepH * (_c_RealLength - getPosition ());

		super.setSkew (x, y - dy - uu);
		//recored target position 
		//& over write the same operation in super.setSkew.
		tX=xx0;
		tY=yy0;
		//_n_FE();
	}
	function setBevel (_u)
	{
		
		if (_u == undefined)
		{
			////_n_t ("error");
			return;
		}
		uu = _u;
		var alp = _rotation/180*Math.PI+Math.PI/2;
		_x = uu * Math.cos (alp);
		_y = uu * Math.sin (alp);
		bvl.update (uu);
	}
	function getSlope(){
		return bvl.getSlope();
	}
	function getK(){
		return bvl.getSlope();
	}
	//
	//
	
	function setAngle (alp:Number)
	{
		
		if (alp == undefined)
		{
			////_n_t ("error");
			return;
		}
		_rotation = alp;
		_x = uu * Math.cos (alp*Math.PI/180+Math.PI/2);
		_y = uu * Math.sin (alp*Math.PI/180+Math.PI/2);
	}
	function getAngle(){
		return _rotation;
	}
	function getArc(){
		return _rotation/180*Math.PI;
	}

}
