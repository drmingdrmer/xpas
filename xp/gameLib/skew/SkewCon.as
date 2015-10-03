import dateType.*
import xp.gameLib.skew.*;
import xp.gameLib.skew.content.*;
class xp.gameLib.skew.SkewCon extends VoidSkew implements _i_side_control, _i_content_control
{
	
	var _n_className="skewCon";
	var _cn_skewCon=true;
	/**
	 this is the linkage name of the content clip.
	 @summary the content to skew.
	@see zClip
	@see arbitarySkew
	*/
	[Inspectable(defaultValue="", type="Array")]
	var attachClips:Array;
	//
	[Inspectable(defaultValue="", type="Array")]
	var clipDistance:Array;
	//
	[Inspectable(defaultValue="", type="Array")]
	var rollAccount:Array;
	//
	[Inspectable(defaultValue="", type="Array")]
	var rollNames:Array;
	//
	[Inspectable(defaultValue="", type="String")]
	var vName:String;
	/**
						content MovieClip to skew
						@summary content MovieClip to skew
						*/
	//the content used as volumn control.
	var skewContent:_i_side_control;
	//content list
	var skewContents:Array;
	//mc containing all added clips.
	var __con:MovieClip;
	//
	function SkewCon ()
	{
		super ();
		//
		__con = this.a.o.createEmptyMovieClip ("c", 14);
		__con.setMask (this.a.o.rMask);
		//
		skewContents = new Array ();
		skewContent = undefined;
		//
		for (var i = 0; i < attachClips.length; i++)
		{
			//create contents
			var dd = addContent (attachClips[i], Number (clipDistance[i]), Number (rollAccount[i]), rollNames[i]);
			//
			//
			////_n_t (attachClips[i]);
			if (skewContent == undefined && attachClips[i] == vName)
			{
				skewContent = skewContents[dd];
			}
			//
		}
		if (skewContent == undefined)
		{
			
			skewContent = skewContents[skewContents.length - 1];
			
		}
	}
	//--------------------------------------------------------------------------------------------------------------------------------------
	function addContent (clp:String, ofst:Number, rlN:Number, rlName:String):Number
	{
		var dp = __con.getNextHighestDepth ();
		//
		var ll:Number = segList.getLength (clp);
		if (ll < 0)
		{
			ll = segList.getLength (rlName);
		}
		if (ll < 0)
		{
			ll = _c_defaultLength;
			_n_warn ("no length defined for " + rlName + " symbol");
		}
		//
		var ww:Number = segList.getWidth (clp);
		if (ww < 0)
		{
			ww = segList.getWidth (rlName);
		}
		if (ww < 0)
		{
			ww = _c_element_max_width;
			_n_warn ("no width defined for " + rlName + " symbol");
		}
		//
		var io = {rollN:rlN, zClipName:rlName, segLength:ll, segWidth:ww, _rotation:90, _xscale:10000 / _c_screen_h * 2};
		//io is specially for zClipRoll class.
		var o = __con.attachMovie (clp, "contentClip" + dp, dp, io);
		//
		if (!_i_side_control (o))
		{
			////_n_t ("_i_side_control interface unimplemented\n              " + clp);
			return;
		}
		//
		//
		skewContents[dp] = o;
		if (ofst==undefined || isNaN(ofst)) ofst=0;
		clipDistance[dp] = ofst;
		return dp;
	}
	//param d : depth.
	function delContent (d:Number):Boolean
	{
		skewContents[d].removeMovieClip ();
		return true;
	}
	//
	function setAsVol (d:Number):Boolean
	{
		skewContent = skewContents[d];
		return true;
	}
	//___________________________________________________________________________position
	/**
	set all contents Clip the z position.
	
	
	*/
	//_i_side_control
	function setPosition (pP:Number)
	{
		for (var i in skewContents)
		{
			var o:_i_side_control = skewContents[i];
			o.setPosition (pP + clipDistance[i]);
			
		}
	}
	//_i_side_control
	function getPosition (seg:Number)
	{
		//////_n_t ();
		return skewContent.getPosition (seg);
	}
	//
	function getSegLength ():Number
	{
		return skewContent.getSegLength ();
	}
	function getSegWidth ():Number
	{
		return skewContent.getSegWidth ();
	}
}
