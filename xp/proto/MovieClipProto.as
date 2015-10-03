class xp.proto.MovieClipProto extends MovieClip{
	static function _p_CreateEmptyClassClip () {
		var o = MovieClip.prototype;
		o.createEmptyClassClip = MovieClipProto.prototype.createEmptyClassClip;
	}
	function createEmptyClassClip (cls:Function, n:String, dep:Number, io:Object):MovieClip {
		//check for class parameter.
		if (typeof (cls) != "function") {
			xp.debugUti.warn ("unexpect type for cls = " + cls);
		}
		//
		if (cls == MovieClip || MovieClip (cls.prototype)) {
		}
		else {
			xp.debugUti.warn ("not a MovieClip type,parameter 1 'cls' should be a MovieClip or its subClass");
		}
		//
		//
		var o = this.createEmptyMovieClip (n, dep, io);
		//inheriting from cls.
		o.__proto__ = cls.prototype;
		//call constructor.
		cls.apply (o);
		cls.prototype.onLoad.apply(o);
		return o;
	}
}
