import xp.dataType.*;

class xp.dataType.motion
{
	var _n_className="motion";
	var _cn_motion=true;
	//
	var position:vector;
	
	var velocity:vector;
	var acceleration:vector;
	var time:Number;
	function motion(p:vector,v:vector,a:vector,t:Number){
		position=p;
		velocity=v;
		acceleration=a;
		time=t;
	}
}