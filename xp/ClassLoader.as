//
//loaded in class is in swf file format.& for stability considering,class defined
//in these swf file must not be export at frame 1! 
//
//
//
//
//
//
//
//
//
//

class xp.ClassLoader extends MovieClip {
	//
	
	static var inProgressing:Boolean=false;
	
	//
	static var __xp__init_initialize = initialize ();
	//
	static function loadClass (p:String):Boolean {
		if (inProgressing) return false;
		//
		var dpth:Number = xp.___.getTempDepth ();
		//
		var o = _root.createEmptyMovieClip ("ldr", dpth);
		//
		trace("created a container clip "+o)
		o.addinClass = xp.ClassLoader.addinClass;
		trace(o.addinClass);
		o.onData =function (){trace("kaaaaaaaaa");}//= mx.utils.Delegate.create (o, o.addinClass);
		trace(o.onLoad);
		o.loadMovie (p);
		//
		inProgressing=true;
		return true;
	}
	//
	static function addinClass () {
		trace("addinClass");
		var t = ["this"];
		trace (t);
		 
		xp.ClassLoader.store_GlobalData ();
		t.onEnterFrame = function () {
			//after create all
			if (this._currentframe == this._totalframes) {
				//after reading data in
				xp.ClassLoader.release_GlobalData();
				xp.ClassLoader.inProgressing=false;
				//
				
				
				xp.___.removeMe (this);
				
				
			}
		};
		t.play ();
	}
	//
	
	

	
	
	
	
	
	
	
	
	
	
	static function store_GlobalData () {
		for (var i in _global) {
			 var t=typeof(_global[i]);
			 if (t!="object" && t!="function") continue;
			 //
			_global.__xp__classHoler[i] = _global[i];
			_global[i]=undefined;
		}
	}
	static function release_GlobalData () {
		xp.___.addObj (_global, _global.__xp__classHoler);
		for (var i in _global.__xp__classHoler) {
			_global[i] = _global.__xp__classHoler[i];
			delete _global.__xp__ClassLoader[i];
		}
	}
	static function initialize () {
		if (_global.__xp__ClassLoader == undefined) {
			trace("ClassLoader initialized");
			//enable onLoad event.
			MovieClip.prototype.onLoad = function () {			};
			
			//create backup object
			_global.__xp__classHoler = new Object ();
			//hide from 'for in'
			_global.ASSetPropFlags (_global, "__xp__classHoler", 1, true);
		}
	}
}
