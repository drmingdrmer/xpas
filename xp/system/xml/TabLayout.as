class TabLayout extends AbstractLayoutElement{
	
	var visibleTab:String;
	var styleName:String;
	
	var tabAttList:Object={visibleTab:1,styleName:1};
	
	
	var handlerWidth:Number=5;
	
	
	//handler
	var h:TabHandler

	
	var handlerDep:Number=789;
	
	function init(){
		for (var i in tabAttList){
			if (this[i]==undefined) this[i]="";
		}
	}
	
	
	function TabLayout(){
		type="layout";
		name="TabLayout";	
		
	}
	
	
	
	
	//overwritten by sub.
	function applyXML(x:XMLNode){
		for (var i in tabAttList){
			this[i]=x["getProp"](i);			
			
			
		}
		
		
	}
	
	
	
	
	function converLayoutToXML():XMLNode{
		var x:XMLNode=super.converLayoutToXML();
		for (var i in tabAttList){			
			x["setProp"](i,this[i]);
		}
		return x;
		
	}
	
	
	function addSubLayout(position:String,type:Function):AbstractLayoutElement{
		if (position=="" || position==undefined) position="_";
		cells[0].position=position;
			
		if (sub[position]){
			sub[position].removeMovieclip();
		}
		
		sub[position]=this["createEmptyClassClip"](type,position+Math.random(),this.getNextHighestDepth(),cells[0]);
		if (visibleTab!=position) sub[position]._visible=false;
		return sub[position];
			
		
	}
	
	
	function onGetFocus(eo){
		super.onGetFocus(eo);
		var io={_x:545,_y:110}
		io.owner=this;
		for (var i in tabAttList) io[i]=this[i];
		for (var i in attList) io[i]=this[i];
		io.list="";
		for (var i in sub) io.list+=i+"\n";
		_root.attachMovie("TabPro","xx",1234,io);
		
	}
	
	function applyChange(o:Object){
		onLostFocus();
		
		
		for (var i in tabAttList) this[i]=o[i];
		for (var i in attList) this[i]=o[i];		
		
		
		
		refreshLayout();
		setVisibleTab();
		
		
		
		onGetFocus();
		
	
		
	}
	
	

	
	
	
	
	function findFreeCell(n:String){
		cells[0].position="newTab"+ID;
		return cells[0];
			
		
		
	}
	
	function get ID():Number{
		if (this["_id"]==undefined) this["_id"]=0;
		return this["_id"]++;
	}
	
	
	
	
	
	function setVisibleTab(){
		
	
		for (var i in sub){
			sub[i]._visible=false;
		}
		sub[visibleTab]._visible=true;
		
	}
	
	
	
	
	
	
	//
	function createCells(){
		cells=new Array();
		
		cells.push({position:"_",left:0,right:width,top:20,bottom:height});
		
	}
	
	function findCell(n:String){
		return cells[0];
		
	}
	
	
	
	
	
	
	
	
	//
	function createHandler(){
		for (var i in handlers) handlers[i].removeMovieClip();
		handlers=new Array();
		
		for (var i in tabAttList){
			if (this[i]==undefined) this[i]="";
		}		
		
	
		h=this["createEmptyClassClip"](TabHandler,"h",handlerDep,{left:0,
														  right:width,
														  top:0,
														  bottom:20});
				
		handlers.push(h);
		
		
		
		
		
		
		
		
	}
	
	
	//overwritten
	function renderHandler(){
		h.refresh();
		
	}
	
	
	
}