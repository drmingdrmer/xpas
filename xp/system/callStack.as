class xp.system.callStack{
	
	
	function initialize(o:Object){
		if (o==undefined) return;
		if (o.__xp__callStack==true){return;}
		else
		{
			o.__xp__callStack=true;
			//
			//get visual func list:
			var vList=new Array();
			for (var i in o){
				if (typeof(o[i])=="function" && o.__proto__[i]==undefined) vList.push(i);
			}
			
			
			
			
			
			
			
		}
		
	}
	
	
	
	
	
	
}