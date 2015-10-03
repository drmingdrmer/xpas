//const class
/**
 * 
 * 
 * 
 * 
 * 
 */
class xp.___{
	//
	//
	//
	//-16384 to 1048575
	//preserved depth value for system use.
	static var preservedDepthMin:Number=1000001;
	static var preservedDepthMax:Number=1048574;
	
	// 	
// 	
// 	
// 	
// 	
// 	
// 	
// 	
// 	
// 	
	//
	//when delete a clip in a negative depth,first swap it to this depth.
	static var deleteDepth:Number=1048575;
	//
	
	
	
	//
	// 
// 	
// 	
// 	
// 	
// 	
	//depth for temporarily loaded clip in _root
	static var loadTemporaryMin:Number=preservedDepthMin;
	static var loadTemporaryMax:Number=preservedDepthMin+1000;
	static var tempDepth:Number=loadTemporaryMin;
	//
	static function getTempDepth():Number{
		if (tempDepth==___.preservedDepthMax){
			tempDepth=___.preservedDepthMin;
			return ___.preservedDepthMax;
		}
		else
		{
			tempDepth++;
			return tempDepth-1;
		}
		
	}
	//
	static function removeMe(t:MovieClip){
		
		t.swapDepths(___.getTempDepth());
		t.removeMovieClip();
	}
	// 

// 
// 
// 
// 
// 	reserved depth
//	for system component use , supposed that assigned depth wont be recycled
//
	static var systemDepthMin:Number=loadTemporaryMax+1;
	static var systemDepthMax:Number=systemDepthMin+10000;
	static var systemDepthAvailable:Number=systemDepthMin;
	//
	static function getSystemDepth():Number{
		return systemDepthAvailable++;
	}
// 
	//reserved clip
	static var reservedClipDepthMin:Number=systemDepthMax+1;
	static var reservedClipDepthMax:Number=reservedClipDepthMin+10000;
	static var reservedClipDepthCurrent:Number=reservedClipDepthMin;
	static function getReservedClip(mc:MovieClip):MovieClip{
		if (!mc) mc=_root;
		if (!mc.__xp__reservedClipDepthCurrent){
			mc.__xp__reservedClipDepthCurrent=xp.___.reservedClipDepthMin;
		}
		var q=mc.createEmptyMovieClip("reserved"+mc.__xp__reservedClipDepthCurrent,mc.__xp__reservedClipDepthCurrent++);
		return q;
		
	}
// 
// 
// 
// 
// 
	//get next available depth higher or lower
	static function getNextDepth(m:MovieClip,dep:Number,upDown:Number){
		
		if (upDown<0) upDown=-1;
		else upDown=1;
		
		var n=0;
		while (m.getInstanceAtDepth(dep+n)){n+=upDown}
		
		return dep+n;
	}
//		
//
//
//
//
//
//

	static function copyObj(s,d){
		
	}
	static function addObj(s,d){
		for (var i in s){
			if (d[i]==undefined){
				d[i]=s[i];
			}
			else
			if (typeof(s[i])!="object") d[i]=s[i];
			else addObj(s[i],d[i]);
			
			
			
		}
		
	}
	//
	//
	//
	//
	//
	//
	//

	
}