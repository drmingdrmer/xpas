import elements.sideElement.skew.content.zClip;
class elements.sideElement.skew.content.zClipSimpleRoller extends zClip {
	var _n_className = "zClipSimpleRoller";
	var _cn_zClipSimpleRoller = true;
	function zClipSimpleRoller(){
		super();
		
	}
		
	function setPosition (pP:Number) {
		//////_n_t(pP);
		//snap real length to frame length.
		//real length is the distance from 0 to _c_RealLength,& just for convenience to use with width length(-1000~1000 in most).
		//here, pP is in _c_RealLength
		//
	
		pP = pP - Math.floor (pP / _n_RealLen) * _n_RealLen;
		
		super.setPosition (pP);
		
	}
}
 