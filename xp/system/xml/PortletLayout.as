class PortletLayout extends AbstractLayoutElement{

	var styleName:String;
	var showTitle:Number;
	var titlePosition:String;
	
	var portletAttList:Object={styleName:1,showTitle:1,titlePosition:1};
	
	
	var handlerWidth:Number=5;
	
	var handlerDep:Number=789;
	
	var h:PortletHandler;
	
	function init(){
		styleName="orange";
		showTitle=1;
		titlePosition="top"
	}
	
	
	function PortletLayout(){
		type="portlet";
		name="xx";	
		
	}
	
	
	
	
	//overwritten by sub.
	function applyXML(x:XMLNode){
		styleName=x["getProp"]("styleName");
		showTitle=x["getProp"]("showTitle")=="1"?1:0;
				
		
	}
	
	
	
	
	function converLayoutToXML():XMLNode{
		var x:XMLNode=super.converLayoutToXML();
		for (var i in portletAttList){
			
			x["setProp"](i,this[i]);
		}
		return x;
		
	}
	
	
	function onGetFocus(eo){
		super.onGetFocus(eo);
		var io={_x:545,_y:110}
		io.owner=this;
		for (var i in portletAttList) io[i]=this[i];
		for (var i in attList) io[i]=this[i];
		_root.attachMovie("PortletPro","xx",1234,io);
		
	}
	
	function applyChange(o:Object){
		onLostFocus();
		
		
		for (var i in portletAttList) this[i]=o[i];
		for (var i in attList) this[i]=o[i];		
		refreshLayout();
		
		
		onGetFocus();
		
	
		
	}
	
	
	
	
	
	
	
	
	
	
	
	//
	function createCells(){
		
		
	}
	
	
	
	
	
	
	
	
	
	//
	function createHandler(){
		for (var i in handlers) handlers[i].removeMovieClip();
		handlers=new Array();
		
		var cx=width/2;
		var cy=height/2;
				
		h=this["createEmptyClassClip"](PortletHandler,"h",handlerDep+0,{left:cx-handlerWidth,
									 						  right:cx+handlerWidth,
															  top:cy-handlerWidth,
															  bottom:cy+handlerWidth,
															  hori:true});
		
		
		handlers.push(h);
		
	}
	
	
	//overwritten
	function renderHandler(){
		h.refresh();
		
		
	}
	
	function renderBorder(d){	
	
	}
	
	
}