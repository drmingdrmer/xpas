class xp.proto.MouseProto {
	static function _p_DoubleClick () {
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
				Mouse.broadcastMessage ("__onDoubleClick");
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
