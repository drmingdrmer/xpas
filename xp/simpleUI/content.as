//content class,containing graphic or animation.
//in the content's MovieClip timeline,there r 2 labeled frame:"show","hide",or more."void" for example
[Event("hide")]
[Event("show")]

class xp.simpleUI.content extends MovieClip {
	#include "../inc/eventDispatcher.as"
	static private var __init__xp_eventDispatcher=mx.events.EventDispatcher.initialize(content.prototype);
	var hidden:Boolean=undefined;
	function content () {
		
		super();
		
		this.stop();
	}
	function show () {
		if (hidden==false) return;
		hidden=false;
		this.gotoAndPlay ("show");
		this["__f_show"]();
		dispatchEvent({type:"show"});
	}
	function hide () {
		if (hidden==true) return;
		hidden=true;
		this.gotoAndPlay ("hide");
		this["__f_hide"]();
		dispatchEvent({type:"hide"});
	}
	function hideAtOnce(){
		if (hidden==true) return;
		hidden=true;
		this.gotoAndPlay ("void");
		this["__f_hide"]();
		dispatchEvent({type:"hide"});
	}
}
