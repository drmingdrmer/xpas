/**
 * @author 刘洋
 */
class xp.system.xml.XMLadv extends XMLNode{
	
	
	/**
	 * add some function to xml.prototype to make it works better.	 */
	
	static function init(){
		var proto=XMLadv.prototype;
		
		
		var o=XMLNode.prototype;
		o.getAtt=proto.getAtt;
		o.setAtt=proto.setAtt;
		o.getChilds=proto.getChilds;

	}
	
	function XMLadv(str){
		super(str);
	}
	
	
	function getAtt(n:String):String{
		return this.attributes[n];
	}
	function setAtt(n:String,v:Object){
		this.attributes[n]=v.toString();
	}
	
	
	function getChilds(n:String):Array{
		var list:Array=new Array();
		var o:Array=this.childNodes;
		for (var i : Number = 0; i < o.length; i++) {
			if (o[i].nodeName==n){
				list.push(o[i]);
			}			
		}
		return list;
	}
	
	
}