//
class xp.simpleUI.container extends xp.simpleUI.content{
	var list:Array;
	/**
	
	
	*/
	function container(){
		list=new Array();
		//remember all movieclip
		for (var i in this){
			if (typeof(this[i])=="movieclip"){
				list.push(this[i]);
			}
			
		}
		
	}
	
	
}