import dateType.*
import xp.gameLib.skew.VoidSkew;
import xp.gameLib.skew._;
//import xp.gameLib.skew.content.*;


/**
 * no Trim,no mask. */
class xp.gameLib.skew.SkewSimpleContent extends VoidSkew
{
	
	var _n_className="SkewCon";
	var _cn_SkewCon=true;
	/**
	 * this is the linkage name of the content clip.
	 
	 * @summary the content to skew.
	*	@see zClip
	*	@see arbitarySkew
	 	 */	 

	[Inspectable(defaultValue="", type="Array")]
	var attachClips:Array;
	//
	[Inspectable(defaultValue="", type="String")]
	var vName:String;
	/**
	content MovieClip to skew
	@summary content MovieClip to skew
	*/
	//the content used as volumn control.
	var skewContent:MovieClip;
	//content list
	var skewContents:Array;
	//mc containing all added clips.
	var __con:MovieClip;
	//
	function SkewSimpleContent ()
	{
		super ();
		
		createConstructor(arguments);
		
		//
		__con = this.a.o//.createEmptyMovieClip ("c", 14);
		for (var j : String in __con) {
		//	__con[j].swapDepths(_.deleteDepth);
			__con[j].removeMovieClip();
		}
		
		//__con.o.swapDepths(_.deleteDepth);
		//__con.o.removeMovieClip();
		//__con.setMask (this.a.o.rMask);
		//
		skewContents = new Array ();
		skewContent = undefined;
		//
		for (var i = 0; i < attachClips.length; i++)
		{
			//create contents
			var dd = addContent (attachClips[i]);
			//
			//
			////_n_t (attachClips[i]);
			if (skewContent == undefined && attachClips[i] == vName)
			{
				skewContent = skewContents[dd];
			}
			//
		}
		//select the last as default.
		if (skewContent == undefined)
		{			
			skewContent = skewContents[skewContents.length - 1];
			
		}
	}
	
	//--------------------------------------------------------------------------------------------------------------------------------------
	function addContent (clp:String):Number
	{
		//depth.
		var dp = __con.getNextHighestDepth ();
		
		//
		var io = {_rotation:90, _xscale:100};
		//io is specially for zClipRoll class.
		var o = __con.attachMovie (clp, "contentClip" + dp, dp, io);
		
		//
		skewContents[dp] = o;
		
		
		//return an ID for this content.
		return dp;
	}
	//param d : depth.
	function delContent (d:Number):Boolean
	{
		skewContents[d].removeMovieClip ();
		skewContents[d]=undefined;
		return true;
	}
	//
	function setAsVol (d:Number):Boolean
	{
		skewContent = skewContents[d];
		return true;
	}
	
	
	function getLength ():Number
	{
		return skewContent.getLength ();
	}
	function getWidth ():Number
	{
		return skewContent.getWidth ();
	}
}
