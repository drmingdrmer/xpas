/**
 * @author xp
 */
class xp.gameLib.DrawClip extends MovieClip{
	
	
	static private var layerDepth:Number=50;
	static function set depth(d:Number){
		
		layerDepth=d;
	}
	static function get depth():Number{
		return layerDepth;
	}
	
	
	private var _layer:Number=0;
	static var _instance:DrawClip;
	
	static function initialize(o:MovieClip){
		if (_instance==undefined) _instance=new DrawClip;
		
		o._layer=0;
		o.setDepth=_instance.setDepth;		
	}
	
	
	
	function set referenceObject(o:Object){
		
	}
	function get referenceObject():Object{
		return null;
	}
	
	
	
	
	
	public function DrawClip(l:Number) {
		
		if (l>=depth || l<0) {
			l=0;
			trace("larger than depth");
			//_tr("larger than depth");
		}
		_layer=l;
		
		if (_instance==undefined) _instance=this;
		
	}
	
	
	function setDepth(n:Number){
		
		this.swapDepths(n*depth+this._layer);
	}
	
	
	
	
	
	
	
}