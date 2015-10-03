/**
   ActionScript Class File -- Created with SAPIEN Technologies PrimalScript 3.1
   
   @class  
   @package
   @author dr-dr
   @codehint 
   @example 
   @tooltip 
*/
class xp.SystemRepair extends MovieClip {
	static var inited:Boolean=false;
	
	// static var __xp_init_repair=repair();
	static function repair () {
		if (!inited){
			inited=true;
			enableMovieClip_onLoad ();
			MovieClip_removeMovieClipAdv ();
			MovieClip_loadMovieAdv ();
			MovieClip_createEmptyClassClip ();
			Object_multiFunction ();
			Mouse_DoubleClick();
		}
		//
		//
	}
	 static function MovieClip_loadMovieAdv () {
		//not test
		//
		//new MovieClip.loadMovie function enables onDate,onLoad event even for dynamic MCs.
		//add a method 'loadMovieAdv' to MovieClip.
		MovieClip.prototype.oldLoadMovie = MovieClip.prototype.loadMovie;
		MovieClip.prototype.loadMovieAdv = function (url, vars) {
			if (this.onData != undefined && this.onData != null) {
				var o = _root.createEmptyMovieClip ("__fixEvents" + Math.random (), xp.___.getTempDepth ());
				o.theTarget = this;
				o.onData = this.onData;
				if (this.onLoad != undefined && this.onLoad != null) {
					o.onLoad = this.onLoad;
				}
				o.onEnterFrame = function () {
					this.oldv = this.v;
					this.v = this.theTarget.getBytesLoaded ();
					if (this.v != this.oldv) {
						this.onData.apply (this.theTarget);
					}
					if (this.v == this.theTarget.getBytesTotal ()) {
						this.theTarget.onData = this.onData;
						if (this.onLoad != undefined) {
							this.theTarget.onLoad = this.onLoad;
						}
						this.onLoad.apply (this.theTarget);
						this.removeMovieClip ();
					}
				};
			}
			this.oldLoadMovie (url, vars);
		};
		//
		//
		//
	}
	 static function enableMovieClip_onLoad () {
		//enable MovieClip.onLoad
		MovieClip.prototype.onLoad = function () {
		};
	}
	 static function MovieClip_removeMovieClipAdv () {
		//not test;
		//return: boolean if clip deleted at once, or delayed to after frame because of onUnload
		MovieClip.prototype.removeMovieClipAdv = function () {
			//attention here:NOT xp.___.deleteDepth 'cause of removed mc may not be delete instantaneously.
			//so,we cnt use a single depth.
			this.swapDepths (xp.___.getTempDepth ());
			this.removeMovieClip ();
			if (this) {
				return false;
			}
			else {
				return true;
			}
		};
	}
	 static function MovieClip_createEmptyClassClip () {
		//test
		if (MovieClip.prototype.createEmptyClassClip) {
			trace("exist");
			return;
		}
		
		MovieClip.prototype.createEmptyClassClip = function (cls:Function, Nm:String, dep:Number, io:Object):MovieClip {
			//
		
			if (cls == undefined || typeof (cls) != "function") {
				cls = MovieClip;
			}
			//
			
			if (!MovieClip.prototype.isPrototypeOf(cls.prototype) && cls!=MovieClip){
				trace("no MovieClip or subClass");
				Flashout.warning("no MovieClip subClass");
			}
			
			//create
			var n:MovieClip = this.createEmptyMovieClip (Nm, dep);			
			//apply class;
			n.__proto__ = cls.prototype;
			//init
			for (var i in io) {
				n[i] = io[i];
			}
			//invoke constructor
			cls.apply (n);
			//invoke onLoad
			n.onLoad ();
			return n;
		};
	}
	 static function Object_multiFunction () {
		Object.prototype.multiFunction = function (funcName:String) {
			
			if (this[funcName + "_enabled"] != undefined) {
				return;
			}
			this[funcName + "_enabled"] = true;
			//---------------------------------------------------------------------------
			//function call each functions in the list of specific function Name.
			this[funcName + "__callList"] = function () {
				var o = this[arguments.callee.__fName + "_mfList"];
				// 
				for (var i = 0; i < o.length; i++) {
					o[i].apply (this, arguments);
				}
			};
			var cl = this[funcName + "__callList"];
			cl.__fName = funcName;
			cl.owner = this;
			//
			cl.clearAll = function () {
				this.owner[this.__fName + "_mfList"] = new Array ();
			};
			cl.getOne = function (i:Number) {
				return this.owner[this.__fName + "_mfList"][i];
			};
			cl.getLength = function () {
				return this.owner[this.__fName + "_mfList"].length;
			};
			cl.enable = function (b:Boolean) {
				this.owner[this.__fName + "_enabled"] = b;
			};
			//
			//------------------------------------------------------------------
			var _g = function () {
				
				if (this[arguments.callee.__fName + "_enabled"]) {
					return arguments.callee.__callList;
				}
				else {
					return this[arguments.callee.__fName + "_mfList"][0];
				}
			};
			_g.__fName = funcName;
			_g.__callList = cl;
			//------------------------------------------------------------------
			var _s = function (f:Function) {
				
				if (this[arguments.callee.__fName + "_mfList"] == undefined) {
					this[arguments.callee.__fName + "_mfList"] = new Array ();
				}
				
				
				var o = this[arguments.callee.__fName + "_mfList"];
				var p = f.owner[f.__fName + "_mfList"];
				
				
				if (this[arguments.callee.__fName + "_enabled"]) {
					
					if (p != undefined) {
						// f is a multi function
						// add all function s in f.__mfList to this
						for (var i = 0; i < p.length; i++) {
							o.push (p[i]);
						}
					}
					else {
						o.push (f);
					}
					
				}
				else {
					
					this[arguments.callee.__fName + "_mfList"] = new Array ();
					if (p != undefined) {
						this[arguments.callee.__fName + "_mfList"].push (p[0]);
					}
					else {
						this[arguments.callee.__fName + "_mfList"].push (f);
					}
					
				}
				
			};
			_s.__fName = funcName;
			
			this.addProperty (funcName, _g, _s);
		};
	}
	
	 static function Mouse_DoubleClick () {
		var o:Object = Mouse;
		o.selfListener = new Object ();
		var l = o.selfListener;
		Mouse.addListener (l);
		//
		l.delay = 300;
		l.lastClick = 0;
		l.onMouseDown = function () {
			var c = getTimer ();
			if (c - this.lastClick < this.delay) {
				//broadcast 'onDoubleClick'
				Mouse["broadcastMessage"] ("__onDoubleClick");
				//prevent combo click.
				this.lastClick = 0;
				return;
			}
			this.lastClick = c;
		};
		//
		//
		o.addProperty ("dcDelay", function () {
			return this.selfListener.delay;
		}, function (s) {
			this.selfListener.delay = s;
		});
		//
		_global.ASSetPropFlags (Mouse, "selfListener", 1, true);
		//
		//
		//
		MovieClip.prototype.addProperty ("onDoubleClick", function () {
			return this.__onDoubleClick;
		}, function (s) {
			
			this.__onDoubleClick = s;
			_global.ASSetPropFlags (this, "__onDoubleClick", 1, true);
			Mouse.addListener (this);
		});
		
		//
	}
	
	
}
