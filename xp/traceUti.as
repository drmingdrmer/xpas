/**
   ActionScript Class File -- Created with SAPIEN Technologies PrimalScript 3.1
   
   @class  
   @package
   @author dr-dr
   @codehint 
   @example 
   @tooltip 
*/
class xp.TraceUti{
	static function initialize(o){
		o.traceAll=TraceUti.traceAll;
		o.tracePoint=TraceUti.tracePoint;
		
	}
	static function traceAll(o:Object){
		var i;
		for (i in o){
			trace(i+"="+o[i]);
		}
	}
	static function tracePoint(o:Object,s:String){
		if (s=="" || s==undefined) s="xy";
		var a:Array=s.split("");
		var re:String="";
		for (var i=0;i<a.length;i++){
			re+=a[i]+"="+o[a[i]]+"  ";
		}
		trace(re);
	}
}
	

