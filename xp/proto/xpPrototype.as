class xp.proto.xpPrototype {
	//
	//
	//
	static function insertPrototype (m:Object):Object {
		//
		for (var o = m; o.prototype != undefined; o = o.prototype) {
		}
		//
		//
		//
		
		if (o.__xp__prototype) {
			return o
		}
		else {
			o.prototype = new xp.proto.xpPrototype ();
			return o.prototype;
		}
	}
	private var __xp__prototype:Boolean = true;
	function xpPrototype () {
		trace(this+"---");
		__xp__prototype = true;
	}
}
