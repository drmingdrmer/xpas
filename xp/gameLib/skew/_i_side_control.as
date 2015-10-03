//control interface for z depth movement
interface xp.gameLib.skew._i_side_control{
	function setPosition(pP:Number);
	//the parameter is for zClipRoller which hs more than 1 content clip.
	//use this parameter to choose one of them to get a position value.
	//for these classes that hs only 1 content clip,just ignore this parameter.
	function getPosition(seg:Number);
	//
	function getSegLength ():Number;
	function getSegWidth():Number;
	
}