class BorderLayout extends AbstractLayoutElement{
	
	var northHeight:Number;
	var midHeight:Number;
	var southHeight:Number;
	var westWidth:Number;
	var midWidth:Number;
	var eastWidth:Number;
	
	var borderAttList:Object={northHeight:1,midHeight:1,southHeight:1,westWidth:1,midWidth:1,eastWidth:1};
	
	
	var handlerWidth:Number=5;
	
	
	//handler for north,south,west,east.
	var hn:MovieClip;
	var hs:MovieClip;
	var hw:MovieClip;
	var he:MovieClip;
	
	var handlerDep:Number=789;
	
	function init(){
		for (var i in borderAttList){
			if (this[i]==undefined) this[i]=30;
		}
	}
	
	
	function BorderLayout(){
		type="layout";
		name="BorderLayout";	
		
	}
	
	//
	function onGetFocus(eo){
		super.onGetFocus(eo);
		var io={_x:545,_y:110}
		io.owner=this;
		for (var i in borderAttList) io[i]=this[i];
		for (var i in attList) io[i]=this[i];
		_root.attachMovie("BorderPro","xx",1234,io);
		
	}
	
	function applyChange(o:Object){
		onLostFocus();
		
		
		for (var i in borderAttList) this[i]=o[i];
		for (var i in attList) this[i]=o[i];		
		refreshLayout();
		
		
		onGetFocus();
		
	
		
	}
	
	
	
	
	//overwritten by sub.
	function applyXML(x:XMLNode){
		
		for (var i in borderAttList){
			this[i]=x["getProp"](i);
			this[i]=this[i].substring(0,this[i].length-1);
			this[i]=Number(this[i]);
		}
		
		
	}
	
	
	
	
	function converLayoutToXML():XMLNode{
		var x:XMLNode=super.converLayoutToXML();
		for (var i in borderAttList){
			
			x["setProp"](i,this[i]+"%");
		}
		return x;
		
	}
	
	
	
	
	//
	function createCells(){
		cells=new Array();
		
		var t=height*northHeight/100;
		var b=height*(100-southHeight)/100;
		
		var w=width*westWidth/100;
		var e=width*(100-eastWidth)/100;
		cells.push({position:'NORTH',left:0,right:width,top:0,bottom:t});
		cells.push({position:'SOUTH',left:0,right:width,top:b,bottom:height});
		cells.push({position:'WEST',left:0,right:w,top:t,bottom:b});
		cells.push({position:'EAST',left:e,right:width,top:t,bottom:b});
		cells.push({position:'CENTER',left:w,right:e,top:t,bottom:b});
		
	}
	
	
	
	
	
	
	
	
	
	//
	function createHandler(){
		for (var i in handlers) handlers[i].removeMovieClip();
		handlers=new Array();
		
		for (var i in borderAttList){
			if (this[i]==undefined) this[i]=30;
		}
		
		var t=height*northHeight/100;
		var b=height*(100-southHeight)/100;
		
		hn=this["createEmptyClassClip"](SplitHandler,"hn",handlerDep+0,{left:0,
									 						  right:width,
															  top:t-handlerWidth,
															  bottom:t+handlerWidth,
															  hori:true});
		
		hs=this["createEmptyClassClip"](SplitHandler,"hs",handlerDep+1,{left:0,
									 						  right:width,
															  top:b-handlerWidth,
															  bottom:b+handlerWidth,
															  hori:true});
		
		
		
		var w=width*westWidth/100;
		var e=width*(100-eastWidth)/100;
		
		hw=this["createEmptyClassClip"](SplitHandler,"hw",handlerDep+2,{left:w-handlerWidth,
									 							right:w+handlerWidth,
																top:t,
																bottom:b,
																hori:false});
		
		
		he=this["createEmptyClassClip"](SplitHandler,"he",handlerDep+3,{left:e-handlerWidth,
									 							right:e+handlerWidth,
																top:t,
																bottom:b,
																hori:false});
		
		handlers.push(hn,hs,hw,he);
		
	}
	
	
	//overwritten
	function renderHandler(){
		hn.refresh();
		hs.refresh();
		hw.refresh();
		he.refresh();
		
	}
	
	
	
}