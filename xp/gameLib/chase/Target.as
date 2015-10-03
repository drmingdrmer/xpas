import xp.gameLib.chase.ChaseDelegateObject;
/**
 * 将MC做成1个目标,可以被其他MC追踪,包括追踪各种属性:<br>
 * <code>
 * _x
 * _y
 * _width
 * _height
 * _rotation
 * _alpha
 * _xscale
 * _yscale 
 * </code>
 * 以及追踪<code>colorTransform</code>对象<br>
 * <br>
 * <strong>
 * composed in eclipse,compiled by MTASC 1.01;
 * </strong>
 * @author drmingdrmer (or call me xp)
 * @see xp.gameLib.ChasingFunc
 * @version 0.7
 * @since flash mx2k4; mm flashPlayer 7.0
 * 
*/
class xp.gameLib.chase.Target{
	//
	//
		
		 
	/**
	 * generate a unique ID 
	 */
	static private var _ID:Number=0;
	static public function get ID(){
		return _ID++;
	}
	 
	 /**
	 * constructor
	 * @description 初始化各个变量云云.
	 * @param none
	 */
	 
	function Target () {
		/*
		cList= new Array ();
		propList={}
		clrObj = new Color (this);
		clrTsm = clrObj.getTransform ();
		propList._x = this._x;
		propList._y = this._y;
		propList._width = this._width;
		propList._height = this._height;
		propList._rotation = this._rotation;
		propList._alpha = this._alpha;
		propList._xscale = this._xscale;
		propList._yscale = this._yscale;
		//
		
		
		for (var j : String in clrTsm) {
			propList["clrTsm_"+j]=clrTsm[j]
		}
		delete propList.clrTsm;
		*/
	}
	/**
	 * @comm add a chaser to list,& begins to send event with chasing data to this Object,especially a MovieClip.
	 * @description 添加1个追踪者,使它可以追踪到target实例的各种属性,但target实例并不直接修改追踪者的属性,只是传送给追踪者所需要的数据.<br>
	 * @description 数据保存在发送给追踪者的event object中,属性列表:
	 * <code>
	 * _x 
		_y 
		_width
		_height 
		_rotation 
		_alpha 
		_xscale 
		_yscale 
		clrTsm
	 * </code>
	 * 
	 * @param mc Object reference.
	 * @param weight how much this Target affect to mc Object.
	 * @return void
	 */
	static function chase (mc:Object,targetObj:Object,weight:Number,chaseSet:String) {
		
		if (!mc) {
			Flashout.error("param mc is undefined");	
			return;
		}
		if (weight==undefined || isNaN(weight)) weight=1;
		if (chaseSet==undefined || chaseSet=="") chaseSet="default";
		
		
		
		if (mc["_chase_delegate"+chaseSet]==undefined){
			mc["_chase_delegate"+chaseSet]=new ChaseDelegateObject(mc,chaseSet);
		}
		mc["_chase_delegate"+chaseSet].addTarget(targetObj,weight);
		
	}
	
	
	
	
}
