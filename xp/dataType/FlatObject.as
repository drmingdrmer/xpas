/**
 * @author xp
 */
class xp.dataType.FlatObject {
	/**
	 * 6 '_'s
	 */
	static var deli:String="_^____^_";
	
	
	static function flat(o:Object):Object{
		var re:Object=new Object();
		_flat(o,re,"");
		return re;
	}
	
	static function _flat(o:Object,newO:Object,h:String){
		
		if (h==undefined) h="";		
		
		for (var i : String in o) {
			var t:String=typeof(o[i]);
			if (t=="object" || t=="movieclip"){
				_flat(o[i],newO,h+i+deli);				
			}
			else
			{
				newO[h+i]=o[i];				
			}	
		}
	}
	
	
	static function unFlat(o:Object):Object{
		return _unFlat(o);
	}
	
	static function _unFlat(o:Object):Object{
		
		var dlen=deli.length;
		
		var newO:Object=new Object();
		for (var i : String in o) {
			var l:Number=i.indexOf(deli);
			if (l==-1){
				newO[i]=o[i];
				
			}
			else{
				var oN:String=i.substring(0,l);
				var pN:String=i.substring(l+dlen);
				if (newO[oN]==undefined) newO[oN]=new Object();
				newO[oN][pN]=o[i];
			}
		}
		
		for (var i : String in newO) {
			if (typeof(newO[i])=="object") newO[i]=_unFlat(newO[i]);
		}
						
		return newO;
	}
	
}