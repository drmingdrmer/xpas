/**
 * @author 刘洋
 */
class AbstractLayoutElement extends DisplayClip{
	
	private var X:XMLNode;
	
	
	
	
	/*
	BorderLayout
	
	*/
	var type:String="layout";
	var name:String="borderLayout";	
	var title:String="xp";
	var description:String="fooo";
	var url:String="xx.com";
	var position:String="here";
	
	var attList:Object={type:1,name:1,title:1,description:1,url:1,position:1};
	
	
	
	var handlers:Array;
	
	private var cells:Array;
	
	private var sub:Object;
	
	public function AbstractLayoutElement() {
		init();
		sub=new Object();
		handlers=new Array();
		
	}
	
	function init(){
	}
	
	
	function addSubLayout(position:String,type:Function):AbstractLayoutElement{
		for (var i : Number = 0; i < cells.length; i++) {
			if (cells[i].position==position){
				if (sub[position]){
					sub[position].removeMovieclip();
				}
				
				sub[position]=this["createEmptyClassClip"](type,position+Math.random(),this.getNextHighestDepth(),cells[i]);
				return sub[position];
			}
		}
		
		
	}
	
	//overwritten
	function createCells(){
	}
	
	//overwritten
	function createHandler(){
		
	}
	
	
	
	//overwritten
	function onGetFocus(eo){
		Flashout.log("onGetFocus");
		fillAlpha+=10;
		for (var i in handlers){
			handlers[i].fillAlpha+=10;
		}
		update();
	}
	
	//overwritten
	function onLostFocus(eo){
		Flashout.log("onLostFocus");
		fillAlpha-=10;
		for (var i in handlers){
			handlers[i].fillAlpha-=10;
		}
		update();
		
	}
	
	
	
	function createLayoutFromXML(x:XMLNode){
		
		
		//create cells..
		applyXML(x);
		createCells();
		createHandler();
		
		for (var i in attList){
			this[i]=x["getAtt"](i);
		}
		//
		var a:Array=x["getChilds"]("xpart");
		
		Flashout.log(a);
		//
		
		for (var j=0;j<a.length;j++){
			
			var pstn=a[j]["getAtt"]("position");
			var tp=a[j]["getAtt"]("type");
			if (tp=="portlet"){
				var q=addSubLayout(pstn,PortletLayout);
				
				
				q.createLayoutFromXML(a[j]);
			}else
			if (tp=="layout")
			{
				var q=addSubLayout(pstn,eval(a[j]["getAtt"]("name")));
				
				
				q.createLayoutFromXML(a[j]);
				Flashout.log(a[j]["getAtt"]("name"));
				
			}
					
		}
		
		
	}
	
	
	
	//apply xml data to layout.especially for the properties.
	//overwritten by sub.
	function applyXML(x:XMLNode){
		
		
	}
	
	
	
	
	
	
	function converLayoutToXML():XMLNode{
		//basic functions.
		var x:XMLNode=(new XML()).createElement("xpart");
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
	
	
	function deleteMe(){
		var q=this.position;
		var o=this._parent
		o.sub[q].removeMovieClip();
		o.sub[q]=undefined;
		
		Flashout.info(this.position);
		Flashout.info(this._parent.sub[this.position]);
		
		
	}
	
	
	
	
	
	function refreshLayout(){
		
		if (this._parent.sub[this.position]!=this){
			//change position:
			this._parent.changePosition(this);
		}
		
		createCells();
		createHandler();
		for (var i in sub){
			var o=sub[i];
			var c=findCell(i);
			if (c==undefined) delete o;
			else {
				c.position=o.position;
				for (var j in c){
					o[j]=c[j];
				}
				o.refreshLayout();
			
			}
			
		}
		
	}
	
	function changePosition(o:Object){
		
		var c=findCell(o.position);
		
		sub[o.position].removeMovieClip();
		
		c.position=o.position;
		for (var i in c){
			o[i]=c[i];
			trace(c[i]);
		}
		sub[o.position]=o;
		
		
		//clear old dead.
		for (var i in sub){
			Flashout.info(sub[i].position+" "+i)
			
			if (sub[i].position!=i) {
				sub[i]=undefined;
				delete sub[i];
			}
			
		}
		
		
	}
	
	
	
	
	function findCell(n:String){
		for (var i=0;i<cells.length;i++){
			if (cells[i].position==n)
				return cells[i];
			
		}
		
	}
	
	function createSubDefault(type:Function){
		var c=findFreeCell();
		
		Flashout.info(c);
		Flashout.info(c.position);
		
		var l=addSubLayout(c.position,type);
		Flashout.info("createSubDefault");
		Flashout.info(type);
		l.init();
		l.refreshLayout();
//		update();
		
	}
	function findFreeCell():Object{
		for (var i=0;i<cells.length;i++){
			if (!sub[cells[i].position]) return cells[i];
			else trace(sub[cells[i].position]);
		}
		return null;
		
	}
	
	
	
	
	
	
	//invoke when state changes.
	function update(){
		refresh();
		renderHandler();
		
		
		for (var i in sub){
			sub[i].update();
		}
	}
	
	

	
	//overwritten
	function renderHandler(){
		
	}
	
	
}