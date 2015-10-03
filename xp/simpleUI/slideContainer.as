class xp.simpleUI.slideContainer extends xp.simpleUI.container {
	var current:MovieClip = undefined;
	function slideContainer () {
		super ();
		for (var i in list) {
			if (typeof (list[i]) == "movieclip") {
				list[i].hide ();
			}
		}
	}
	function select (n:String) {
		trace("select "+n);
		for (var i in list) {
			if (list[i]._name == n) {
				if (current != undefined) {
					current.hide ();
				}
				list[i].show ();
				current = list[i];
			}
		}
	}
}
