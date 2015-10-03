class GridLayout extends AbstractLayoutElement{
	
	var row:Number;
	var column:Number;
	
	var gridAttList:Object={row:1,column:1};
	
	
	var handlerWidth:Number=5;
	
	
	//handler
	var hr:Array;
	var hc:Array;

	
	var handlerDep:Number=789;
	
	function init(){
		for (var i in gridAttList){
			if (this[i]==undefined) this[i]=2;
		}
	}
	
	
	function GridLayout(){
		type="layout";
		name="GridLayout";	
		
	}
	
	
	
	
	//overwritten by sub.
	function applyXML(x:XMLNode){
		for (var i in gridAttList){
			this[i]=x["getProp"](i);			
			this[i]=Number(this[i]);
			
		}
		
		
	}
	
	
	
	
	function converLayoutToXML():XMLNode{
		var x:XMLNode=super.converLayoutToXML();
		for (var i in gridAttList){
			
			x["setProp"](i,this[i]);
		}
		return x;
		
	}
	
	//
	function onGetFocus(eo){
		super.onGetFocus(eo);
		var io={_x:545,_y:110}
		io.owner=this;
		for (var i in gridAttList) io[i]=this[i];
		for (var i in attList) io[i]=this[i];
		_root.attachMovie("GridPro","xx",1234,io);
		
	}
	
	function applyChange(o:Object){
		onLostFocus();
		
		
		for (var i in gridAttList) this[i]=o[i];
		for (var i in attList) this[i]=o[i];		
		refreshLayout();
		
		
		onGetFocus();
		
	
		
	}
	
	
	
	
	
	
	
	
	//
	function createCells(){
		cells=new Array();
		
		var w=width/column;
		var h=height/row;
		
		var nm=0;
		for (var i=0;i<row;i++){
			for (var j=0;j<column;j++){
				cells.push({position:String(nm++),left:w*j,right:w*(j+1),top:h*i,bottom:h*(i+1)});
				
			}
		}
		
	}

	
	
	
	
	
	//
	function createHandler(){
		for (var i in handlers) handlers[i].removeMovieClip();
		handlers=new Array();
		
		for (var i in gridAttList){
			if (this[i]==undefined) this[i]=2;
		}
		
		hr=new Array();
		hc=new Array();
		
		var w=width/column;
		var h=height/row;
		
		for (var j=1;j<column;j++){
			hr[j]=this["createEmptyClassClip"](SplitHandler,"hn"+j,handlerDep+100+j,{left:w*j-handlerWidth,
									 						  right:w*j+handlerWidth,
															  top:0,
															  bottom:height,
															  hori:false});
			handlers.push(hr[j]);
		}
		for (var j=1;j<row;j++){
			hc[j]=this["createEmptyClassClip"](SplitHandler,"hn"+j,handlerDep+200+j,{left:0,
									 						  right:width,
															  top:h*j-handlerWidth,
															  bottom:h*j+handlerWidth,
															  hori:true});
			handlers.push(hc[j]);
			
		}
		
		
		
		
		
		
	}
	
	
	//overwritten
	function renderHandler(){
		for (var j=1;j<column;j++){
			hr[j].refresh();
		}
		for (var j=1;j<row;j++){
			hc[j].refresh();
		}
		
	}
	
	
	
}