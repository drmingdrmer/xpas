/**
 * @author 刘洋
 */
class xp.ui.DisplayClip extends MovieClip{
	
	private var _l,_r,_t,_b:Number;
	
	private var _border:MovieClip;
	
	var fillColor:String="0x000000";
	var fillAlpha:Number=0;
	var lineColor:String="0x330000";
	var lineAlpha:Number=100;
	var lineWidth:Number=1;
	
	
	public function DisplayClip() {
		xp.SystemRepair.MovieClip_createEmptyClassClip();
		if (!_border) {
			_border=this.createEmptyMovieClip("___",100000);
		}
		refresh();
	}
	
	
	
	function set left(n:Number){
		_l=n;
		refresh();
	}
	function set right(n:Number){
		_r=n;
		refresh();
	}
	function set top(n:Number){
		_t=n;
		refresh();
	}
	function set bottom(n:Number){
		_b=n;
		refresh();
	}
	
	
	
	function get left():Number{
		return _l;
	}
	function get right():Number{
		return _r;
	}
	function get top():Number{
		return _t;
	}
	function get bottom():Number{
		return _b;
	}
	
	function get width():Number{
		return _r-_l;
	}
	function get height():Number{
		return _b-_t;
	}
	
	function get hMid():Number{
		return (_l+_r)/2;
	}
	function get vMid():Number{
		return (_t+_b)/2;
	}
	
	
	function refresh(){
		
		/*
		if (_r<_l){
			var q=_r;
			_r=_l;
			_l=q;
		};
		if (_b<_t){
			var q=_b;
			_b=_t;
			_t=q;
		}
		*/
		this._x=_l;
		this._y=_t;
		
		
		_border.clear();
		renderBorder(_border);
		
	}
	
	//default render function 
	function renderBorder(d){	
		
		d.lineStyle(lineWidth,Number(lineColor),lineAlpha);
		
		
		//d.beginFill(Number(this.fillColor),fillAlpha);
		
		d.moveTo(0,0);
		d.lineTo(0,_b-_t);	
		d.lineTo(_r-_l,_b-_t);
		d.lineTo(_r-_l,0);
		d.lineTo(0,0);
		
		var g:Number=2;		
		d.lineStyle(lineWidth+g,Number(fillColor),fillAlpha);

		
		d.moveTo(g,g);
		d.lineTo(g,_b-_t-g);	
		d.lineTo(_r-_l-g,_b-_t-g);
		d.lineTo(_r-_l-g,g);
		d.lineTo(g,g);
		
		//d.endFill();
	}
	
	
}