/**
this is a trim area for mask.for the purpose to create a hole in mask.

*/
import elements.sideElement.skew.*;

import elements.sideElement.skew.content.*;

class elements.sideElement.skew.trim.subTrimMask extends zClip
{
	function subTrimMask ()
	{
		//trim dnt roll back
		super (false);
		if (flip ())
		{
			flip ();
		}
	}
	/**
		flip this clip to trim to mask,or add to mask.
		
		*/
	function flip ():Boolean
	{
		this._yscale *= -1;
		this.yscl0 *= -1;
		return this._yscale > 0;
	}

}
