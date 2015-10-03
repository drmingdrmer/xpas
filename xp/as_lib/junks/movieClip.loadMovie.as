Movieclip.prototype.oldLoadMovie = Movieclip.prototype.loadMovie;
Movieclip.prototype.loadMovie = function (url, vars) {
	if (this.onData != undefined && this.onData != null) {
		this._parent.createEmptyMovieClip ("__fixEvents", xp.___.getTempDepth());
		this._parent.__fixEvents.theTarget = this;
		this._parent.__fixEvents.onData = this.onData;
		if (this.onLoad != undefined && this.onLoad != null) {
			this._parent.__fixEvents.onLoad = this.onLoad;
		}
		this._parent.__fixEvents.onEnterFrame = function () {
			this.oldv = this.v;
			this.v = this.theTarget.getBytesLoaded ();
			if (this.v != this.oldv) {
				this.onData.call (this.theTarget);
			}
			if (this.v == this.theTarget.getBytesTotal ()) {
				this.theTarget.onData = this.onData;
				if (this.onLoad != undefined) {
					this.theTarget.onLoad = this.onLoad;
				}
				this.onLoad.call (this.theTarget);
				this.removeMovieClip ();
			}
		};
	}
	this.oldLoadMovie (url, vars);
};
