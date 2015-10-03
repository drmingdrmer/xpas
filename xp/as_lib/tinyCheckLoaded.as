//	---------------------------
//	MovieClip.tinyCheckLoaded
//	---
//	Author: jonas@onrelease.org
//	2003-01-26 01:26:54
//	Flash 6
//	----------------------------
// tinyCheckLoaded Function v1.2
// by Jonas Galvez (jonas@onrelease.org)

MovieClip.prototype.addProperty("loaded", function() {
    var l = this.getBytesLoaded(); var t = this.getBytesTotal();
    return t > 4 && Math.round(l) == Math.round(t);
}, null);

MovieClip.prototype.addProperty("hasContent", function() {
    return this.getBytesTotal() > 4;
}, null);

ASSetPropFlags(MovieClip.prototype, "loaded,hasContent", 1);

_global.tinyCheckLoaded = function(mc, _onLoad, _onStart, _onStatus) {
    var timer = setInterval(function() {
        var ref = typeof mc == "string" ? get(mc) : mc;
        if(ref.loaded) { _onLoad.call(ref); clearInterval(timer); }
        else if(ref.hasContent && !start) { _onStart.call(ref); var start = 1; }
        else if(ref.hasContent) { _onStatus.call(ref); };
    }, 100);
};

// loadMovieNum("loaded.swf", 1);
// tinyCheckLoaded("_level1", function() {
//    this.gotoAndStop(10);
// }); 