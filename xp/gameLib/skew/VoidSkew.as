import xp.gameLib.skew.*;
/**
 * @author xp
 */
class xp.gameLib.skew.VoidSkew extends xp.system.MovieClipAdv implements _i_flat_skew
{
	var _n_className="voidSkew";
	var _cn_voidSkew=true;


	/**
	total frames for calculate;
	there are _totalframes-1 cut in the circle
	@summary rough angle amount
	*/
	var frameAccount:Number;
	/**
	start alpha
	@summary start alpha
	*/
	var Alpha0:Number;
	/**
		//target position to skew to .
		in parent scope.
		*/
	var tX:Number=0;
	var tY:Number=0;
	//
	/**
	the clip managing compensating scale;
	*/
	private var a:MovieClip;
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
	function VoidSkew ()
	{
		createConstructor(arguments);
		
		//the motion in this clip cuts circle by frames number ,averagely
		this.stop ();
		frameAccount = this._totalframes - 1;
		Alpha0 = Math.PI / 2 + 15 / 180 * Math.PI;
		
	}
	
	//___________________________________________________________________________skew
	//
	//
	private function setAlp (n)
	{
		//optimizing..
		//get the index.
		var s = n / 2 / Math.PI;
		//enclose it to 0~1;
		s -= Math.floor (s);
		//target frame
		var fr = Math.round (s * frameAccount) + 1;
		this.gotoAndStop (fr);
		//return the rough alpha;
		return (fr - 1) * Math.PI * 2 / frameAccount;
	}
	//
	//
	/**
	set the skew angle.to skew the point (0,100) inside this clip to the specified point (x,y);
	
	@summary set the skew angle.to skew the point (0,100) inside this clip to the specified point (x,y);
	@param x Number
	@param y Number
	*/
	//_i_flat_skew
	function setSkew (x:Number, y:Number)
	{
		//correct rotation.
		if (this._rotation!=0){
			var o={x:x,y:y};
			xp.algorithm._2D.rotate(-this._rotation,o);
			x=o.x;
			y=o.y;			
		}
		//avoiding bug in the integer angle of 0 or PI.
		//here supported that x and y are all integer
		x -= .01;
		//calculate alpha
		var alp = Math.atan2 (y, x) - Alpha0;
		//set to the rough angle by going to the certain frame.
		alp = setAlp (alp);
		//snap to the precise angle & point.
		this._yscale = y / Math.sin (alp + Alpha0);
		this._xscale = x / Math.cos (alp + Alpha0);
		//compensate _xscale
		a.o._xscale = 10000 / this._xscale;
		//record target position;
		tX = x;
		tY = y;
	}

	
}