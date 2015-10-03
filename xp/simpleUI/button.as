import xp.simpleUI.__c;
class xp.simpleUI.button extends xp.simpleUI.content {
	//init variables
	[Inspectable(defaultValue="",type="String")]
	var label:String;
	[Inspectable(defaultValue="",type="String")]
	var effectClipID:String;
	[Inspectable(defaultValue="",type="String")]
	var iconClipID:String;
	[Inspectable(defaultValue="",type="String")]
	var clickMessage:String;
	//
	//button's contents:
	var eff:MovieClip;
	var icn:MovieClip;
	var labelIns:TextField;
	function button () {
		super ();
		if (effectClipID == "") {
			effectClipID = __c.defaultEffect;
		}
		if (iconClipID == "") {
			iconClipID = __c.defaultIcon;
		}
		//
		//
		eff = this.attachMovie (effectClipID, "eff", 1000);
		icn = this.attachMovie (iconClipID, "icn", 1001);
		//
		hide();
		//
		//mx.events.EventDispatcher.initialize(this);
	}
	function onRollOver () {
		this.eff.show ();
	}
	function onRollOut () {
		this.eff.hide ();
	}
	function onRelease () {
		//var eo={type:"click",msg:this.clickMessage};
		//dispatchEvent(eo);
	}
}
