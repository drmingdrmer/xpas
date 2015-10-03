class xp.gameLib.chase.ChasingEventObj {
	
		
	var type:String;
	var target:Object;
	var receiver:Object;
	
	var eoSum:Object;
	
	
	//from which set this eo is emitted.
	var setName:String;
	
	/**
	 * @comm function to calculate chasing increment
	 * @description 用于设置追踪时计算逼近目标数值方式的函数.<br>
	 * @description 所使用的函数为xp.gameLib.ChasingFunc中的静态函数.
	 * @see xp.gameLib.chase.ChasingFunc
	 */	
	var cFunc:Function=xp.gameLib.chase.ChasingFunc.instantaneous;
	/**
	 * @comm used for some chasing function.
	 * @description 用于计算逼近方式的附加参数.
	 */	
	var CFq:Number=.2;
	var CFst:Number=1;
	
	var refineRotation:Function;
	
	
	
	function ChasingEventObj(tp:String){
		
		refineRotation=autoR;
		
		type=tp;	
		eoSum=new Object();
	}
	
	
	
	/**
	 * config calculate algorithm
	 */
	function get instantaneous(){
		cFunc=xp.gameLib.chase.ChasingFunc.instantaneous;
		return this;
	}
	function get geometric(){
		cFunc=xp.gameLib.chase.ChasingFunc.geometric;
		return this;
	}
	function get specifiedStep(){
		cFunc=xp.gameLib.chase.ChasingFunc.specifiedStep;
		return this;
	}
	
	//shortCuts:
	function get ins(){
		return instantaneous;
	}
	function get geo(){
		return geometric;
	}
	function get stp(){
		return specifiedStep;
	}
		
	
	
	
	//clock way
	function get CW(){
		refineRotation=cwR;
		return this;	
	}
	function get CCW(){
		refineRotation=ccwR;
		return this;
	}
	function get auto(){
		refineRotation=autoR;
		return this;
	}
		
	
	
	
	
	
	/**
	 * config chasing
	 * 
	 */
	function get chasingStep(){
		return CFst;
	}
	function set chasingStep(n:Number){
		if (n==undefined || isNaN(n)) return;
			CFst=n;
	}
	
	
	
	function get chasingRate(){
		return CFq;
	}
	function set chasingRate(n:Number){
		if (!n)
			CFq=n;
	}
	
	
	
	
	
	
	
	/**
	 * calculate properties.
	 */
	function get _x(){
		return cFunc(receiver._x,eoSum._x,CFq,CFst);
	}
	
	function get _y(){
		return cFunc(receiver._y,eoSum._y,CFq,CFst);
	}
	
	function get _alpha(){
		return cFunc(receiver._alpha,eoSum._alpha,CFq,CFst);
	}
	
	function get _rotation(){
		var r=refineRotation(receiver._rotation,eoSum._rotation);
		return cFunc(r,eoSum._rotation,CFq,CFst);
	}
	
	function get _aimRotation():Number{
		var dx=eoSum._x-receiver._x;
		var dy=eoSum._y-receiver._y;
		var rr0=Math.atan2(dy,dx)*180/Math.PI;
		var rr=refineRotation(receiver._rotation,rr0);
		
		return cFunc(rr,rr0,CFq,CFst);
		
	}
	
	function get _distance():Number{
		var dx=eoSum._x-receiver._x;
		var dy=eoSum._y-receiver._y;
		var l=Math.sqrt(dx*dx+dy*dy);
		return l;
	}
	
	function get _width(){
		return cFunc(receiver._width,eoSum._widht,CFq,CFst);
	}
	
	function get _height(){
		return cFunc(receiver._height,eoSum._height,CFq,CFst);
	}
	
	function get _xscale(){
		return cFunc(receiver._xscale,eoSum._xscale,CFq,CFst);
	}
	
	function get _yscale(){
		return cFunc(receiver._yscale,eoSum._yscale,CFq,CFst);
	}
	
	function get colorTransform(){
		var clrObj:Color=new Color(receiver);
		var clrTsm:Object=clrObj.getTransform();
		for (var i : String in clrTsm) {
			receiver["clrTsm_"+i]=clrTsm[i];			
		}
		
		return {ra:cFunc(receiver.clrTsm_ra,eoSum.clrTsm_ra,CFq,CFst),
			    rb:cFunc(receiver.clrTsm_rb,eoSum.clrTsm_rb,CFq,CFst),
			    
			    ga:cFunc(receiver.clrTsm_ga,eoSum.clrTsm_ga,CFq,CFst),
			    gb:cFunc(receiver.clrTsm_gb,eoSum.clrTsm_gb,CFq,CFst),
			    
			    ba:cFunc(receiver.clrTsm_ba,eoSum.clrTsm_ba,CFq,CFst),
			    bb:cFunc(receiver.clrTsm_bb,eoSum.clrTsm_bb,CFq,CFst),
			    
			    aa:cFunc(receiver.clrTsm_aa,eoSum.clrTsm_aa,CFq,CFst),
			    ab:cFunc(receiver.clrTsm_ab,eoSum.clrTsm_ab,CFq,CFst)}
	}
			
			
			
	
	
	
	
	/**
	 * rotation control	 */
	function autoR(r0:Number,r1:Number):Number{
		
		return ((r1-r0)>180?(r0+360):(r1-r0)<(-180)?(r0-360):r0);
		
		
	}
	function cwR(r0:Number,r1:Number):Number{
		return r0>r1?r0-360:r0;
		
		
	}
	function ccwR(r0:Number,r1:Number):Number{
		
		return r0<r1?r0+360:r0;
		
		
	}
	
	
	

	

	
	
	
}