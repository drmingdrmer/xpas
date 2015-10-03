/**
 * @author xp
 */
class xp.algorithm._2D {
	static function rotate(r,o){
		var s=Math.sin(r*Math.PI/180);
		var c=Math.cos(r*Math.PI/180);
		
		var xn=o.x*c-o.y*s;
		var yn=o.x*s+o.y*c;
		o.x=xn;
		o.y=yn;
		
	}
}