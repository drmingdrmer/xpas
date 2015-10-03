import xp.gameLib.chase.*;




class xp.gameLib.struct.Joint extends Target{
	
	
	private static var _Draw_:MovieClip;
	static private var impulser:MovieClip;
	
	
	private var _jointVisible:Boolean=true;
	function get jointVisible():Boolean{
		return _jointVisible;
	}
	function set jointVisible(v:Boolean){
		_jointVisible=v;
		this._visible=v;
	}
	
	
	
	
	
	private var drawClip:MovieClip;
	
	
	
	
	function Joint(aimTarget:Target){
		super();
		
		
		
		if (!_Draw_) {
			_Draw_=this._parent.createEmptyMovieClip("__drawingClip__",xp.___.getNextDepth(this._parent,500));			
			
			_Draw_.clearDrawClip=function(){
				
				this.clear();
			}
		}
		if (impulser==undefined) {
			//priority set to be 1.5 mean invoking after Target-dispatch(1) and before onChase(2);
			impulser=xp.system.Broadcaster.createAutoBroadcaster("clearDrawClip",1.5);
			
			impulser.addListener(_Draw_);

		}
		
		addParent(aimTarget);
		createDrawClip();
		
	}
	
	
	function addParent(o:Target,w:Number,s:String){
		if (!o) return;
		o.addChaser(this,w,s);
	}
	
	
	//modifying is forbidden
	function set onChase(o:Function){
	}
	function get onChase():Function{
		return _onChase;
	}
	
	
	function _onChase(eo:ChasingEventObj){
		//action(eo);
		render(eo,drawClip);
		
	}
	
	function createDrawClip(){
		drawClip=_Draw_;
		
	}
	
	//do some calculate
	function action(t:Object){
		
	}
	
	//drawing job 
	function render(t:Object,o){
		o.lineStyle(10,0xffaaaa,100);
		o.moveTo(_x,_y);
		o.lineTo(t.ins._x,t.ins._y);
		
		
		
	}
	
	
	
	
}
	