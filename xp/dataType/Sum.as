/**
 * @author xp
 * calculate sum of all properties in many Objects.
 */
class xp.dataType.Sum {
	
	//private var olist:Array;
	private var _sum:Object;
	private var totalWeight:Number;
	
	function Sum(){
		clear();
	}
	
	
	function addObj(o:Object,w:Number){
		if (w==undefined)w=1;
		//olist.push(o);	
		calculateSum(o,w);
	}
	
	function clear(){
		//olist=new Array();
		totalWeight=0;
		
		_sum=new Object();
	}
	
	function get summary(){
		var o=new Object();
		for (var i : String in _sum) {
			o[i]=_sum[i]/totalWeight;
		}
		return o;
	}
	
	
	/**
	 * calculate sum,overWritten by subClass.	 */
	function calculateSum(o:Object,w:Number){
		for (var i : String in o) {			
			if (_sum[i]==undefined) _sum[i]=0;
			if (o[i]!=undefined && !isNaN(o[i])) _sum[i]+=o[i]*w;			
		}		
		totalWeight+=w;
	}
	
	
}