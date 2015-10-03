class xp.simpleUI.menuBar extends xp.simpleUI.content {
	var autoHide:Boolean=true;
	function menuBar () {
		super();
		gotoAndStop("void");
		hide();
	}
	function onMouseMove () {
		var flg:Boolean = this.hitTest (_root._xmouse, _root._ymouse, true);
		if (!flg && !hidden && autoHide) {
			this.hide ();
		}
	}
	
}
