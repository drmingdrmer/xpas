//	---------------------------
//	_global.jgLoader
//	---
//	Author: jonas@onrelease.org
//	2003-02-24 12:27:50
//	Flash 6
//	----------------------------
// jgLoader Function v0.9 BETA
// by Jonas Galvez (jonas@onrelease.org)
//
// What BETA means: I'm not sure if this will 
// work as it should, so if you're so courageous and
// insane to try and use it, please tell me if you 
// find any problems - and I'll be eternally thankful =)
//
// Description:
// The purpose of this function is very simple: to 
// deliver an easy way to manage preloading of external 
// files in Flash MX. It can be used to monitor files 
// being loaded by instances of the MovieClip, Sound, 
// LoadVars and XML classes.
// 
// ActionScript File:
// http://onrelease.org/jonas/downloads/jgloader_function.as

function() {

    // Getter/setter properties
    // Object.prototype.loaded and 
    // Object.prototype.hasContent

    // Returns true if the content of the 
    // object is completely loaded
    this.addProperty("loaded", function() {
        var r = Math.round; 
        var l = this.getBytesLoaded(); 
        var t = this.getBytesTotal();
        return (this instanceof MovieClip) ?
        t > 4 && r(l) == r(t) : r(l) == r(t);
    }, null);

    // Returns true if the content of the
    // object has already started loading
    this.addProperty("hasContent", function() {
        var t = function(o) { return o.getBytesTotal(); };
        return (this instanceof MovieClip) ?
        t(this) > 4 : t(this) > 0;
    }, null);

    // Prevent the properties from being
    // accessed in for...in iteration
    ASSetPropFlags(this, "loaded,hasContent", 1);

// Apply the anonymous function
// to the Object's prototype object
}.call(Object.prototype);

_global.jgLoader = function(obj, callbacks) {
    
    var ref, started, loader = function() {

        // If the obj parameter is a string,
        // retrieve the reference it contains
        if(typeof obj == "string") obj = eval(obj);

        // Stores a boolean value in the
        // hasContent local variable to determine
        // whether the external file has started
        // to be downloaded or not
        hasContent = obj.hasContent;

        // Executes the onStart callback when
        // the external file starts to be loaded
        // The started variable is used as a flag to 
        // make sure the function is called only once
        if(!started && hasContent) {
            callbacks.onStart.call(obj); started = 1;
            
        // Calls the onStatus handler
        // constantly while the file is loading
        } else if(hasContent) {

            // An object is passed as the 1st parameter 
            // of the function. It has three properties: 
            // bytesLoaded, bytesTotal and percentComplete
            var t = obj.getBytesTotal();
            var l = obj.getBytesLoaded();
            var loadData = {
                bytesTotal:t,bytesLoaded:l,
                percentComplete:Math.round(l*100/t)
            };
            callbacks.onStatus.call(obj, loadData);
            
            // Executes the onLoad callback
            // and kills the interval when 
            // the loading is done
            if(obj.loaded) {
                callbacks.onLoad.call(obj); 
                clearInterval(loader_id);
            };
        };
    };
    
    // Starts the execution of the loader function
    var hasContent, loader_id = setInterval(loader, 100);
    
};

// Hides the jgLoader function so it
// won't be accessed in for...in loops
ASSetPropFlags(_global, "jgLoader", 1);

// Syntax:
// jgLoader(object, callbacks);
//
// The parameter [object] can be an instance of
// the MovieClip, Sound, LoadVars and XML classes.
//
// The parameter [callbacks] is optional. It can be
// used to define three event handlers: [onStart],
// [onStatus] and [onLoad]. The onStart callback will
// be executed only once, when the external file starts 
// loading. The onLoad event handler will be called
// when the external file is completely loaded.
//
// The onStatus callback will be called continuously 
// during loading. This function will receive an 
// an object in the first parameter. The object will
// have three properties: bytesTotal, bytesLoaded and
// percentComplete - providing info about the loading.
// 
// The parameter callbacks must be an object containing
// the callbacks defined with names that correspond
// to the event (onStart, onStatus and onLoad).
//
// Examples:
//
// var event_handlers = {
//     onStart:function() {
//         trace("The loading has started!");
//     },
//     onStatus:function(o) {
//         trace("bytesTotal: " + o.bytesTotal);
//         trace("bytesLoaded: " + o.bytesLoaded);
//         trace("percentComplete: " + o.percentComplete);
//     },
//     onLoad:function() {
//         trace("The loading has ended!");
//     }
// };
// jgLoader(movieClipObject, event_handlers);
//
// --
//
// jgLoader(movieClipObject, {
//     onStart:function() {},
//     onStatus:function() {},
//     onLoad:function() {}
//  ));
//
// --
//
// jgLoader("_level0", {
//     onStart:function() {},
//     onStatus:function() {},
//     onLoad:function() {}
// )); 