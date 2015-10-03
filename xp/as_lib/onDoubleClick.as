//	---------------------------
//	MovieClip.onDoubleClick
//	---
//	Author: jonas@onrelease.org
//	2003-01-27 14:43:56
//	Flash 6
//	----------------------------
// MovieClip.onDoubleClick Event v1.0
// by Jonas Galvez (jonas@onrelease.org)

MovieClip.prototype.addProperty("onDoubleClick",
    function() { return this.$onDoubleClick },
    function(f) { this.$onDoubleClick = f; Mouse.addListener(this); }
);
Mouse.onMouseDown = function() {
    if(this.last_click == undefined) this.last_click = 300;
    if(getTimer() - this.last_click < 300)
        this.broadcastMessage("$onDoubleClick");
    this.last_click = getTimer();
};
Mouse.addListener(Mouse);

// this.onDoubleClick = function () {
//     trace("DoubleClick!");
// }; 