import xp.gameLib.KeyMapper;
class xp.gameLib.KeyBuffer extends xp.dataType.ScrollBuffer{
	function KeyBuffer(l){
		super(l);
	}
	function addObj(o:Object){
		var i:String;
		var co=getCurrentObj();
		for (i in o){
			o[i+1]=co[i+1];
			o[i+2]=co[i+2];
			o[i+3]=co[i+3];
			o[i+4]=co[i+4];
			o[i+o[i]]=0;
		}
		super.addObj(o);
		
		
		
		
		
		
		
		
		
	}
	
	
	
	
	
	
	
	
}