class PageLayout extends AbstractLayoutElement{
	
	var url:String;
	var owner:String;
	
	var attList:Object={url:1,owner:1};
	


	
	function init(){
		
	}
	
	
	function PageLayout(){
		
		
	}
	
	//

	
	//overwritten by sub.

	function applyXML(x:XMLNode){
		for (var i in attList){
			this[i]=x["getAtt"](i);
		}
		
		
	}
		

	
	
	
	
	function converLayoutToXML():XMLNode{
		//basic functions.
		var x:XMLNode=(new XML()).createElement("xprofile");
		//add Attributes.
		for (var i in attList){
			x["setAtt"](i,this[i]);
		}
		//
		//add xparts
		for ( i in sub){
			var sx:XMLNode=sub[i].converLayoutToXML();
			x.appendChild(sx);
		}
		
		
		
		
		return x;
		//add properties
		
		
		
	}
		

	
	
	function addSubLayout(position:String,type:Function):AbstractLayoutElement{
		if (position=="") position="_";
		cells[0].position=position;
			
		if (sub[position]){
			sub[position].removeMovieclip();
		}
		
		sub[position]=this["createEmptyClassClip"](type,position+Math.random(),this.getNextHighestDepth(),cells[0]);

		
		return sub[position];
			
		
	}
	
	//
	function createCells(){
		cells=new Array();
		
		cells.push({position:"_",left:0,right:width,top:0,bottom:height});
		
	}
	
	
	
	
	
	
	
	
	
	//
	function createHandler(){
		
		
		
		
		
		
		
		
	}
	
	
	//overwritten
	function renderHandler(){
		
		
	}
	
	
	
}