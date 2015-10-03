interface elements.sideElement.skew.trim._i_trim_control
{
	//contruction
	function addFarTrim (pN:String):Boolean;
	function addNearTrim (pN:String):Boolean;
	function delFarTrim ():Boolean;
	function delNearTrim():Boolean;
	//operation
	function setFP(pP:Number);
	function setNP(pP:Number);
	function getFP();
	function getNP();
	
	function setWidth(pW:Number);
	function getWidth();
	
}
