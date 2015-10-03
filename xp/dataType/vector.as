class xp.dataType.vector
{
	var _n_className="vector";
	var _cn_vector=true;
	var p:Number;
	var x:Number;
	var y:Number;
	//
	function vector (x0:Number, y0:Number, p0:Number)
	{
		x = x0;
		y = y0;
		p = p0;
	}
	//
	//
	function mul (n:Number):vector
	{
		x *= n;
		y *= n;
		p *= n;
		return this;
	}
	function addv (v:vector):vector
	{
		x += v.x;
		y += v.y;
		p += v.p;
		return this;
	}
	function subv (v:vector):vector
	{
		x -= v.x;
		y -= v.y;
		p -= v.p;
		return this;
	}
	
	
	//
	//
	function mulP (v:vector):Number
	{
		return x * v.x + y * v.y + p * v.p;
	}
	function mulC (v:vector):vector
	{
		var x0 = y * v.p - p * v.y;
		var y0 = p * v.x - x * v.p;
		var p0 = x * v.y - y * v.x;
/*
		x = x0;
		y = y0;
		p = p0;
		*/
		return new vector(x0,y0,p0);
	}
	function module(){
		var l=Math.sqrt(x*x+y*y+p*p);
		x/=l;
		y/=l;
		p/=l;
		
	}
	
	
	//
	//
	function toString ():String
	{
		return String (x + " " + y + " " + p);
	}
}
