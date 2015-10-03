/**
 * @author xp
 */
class xp.DebugDisplayer extends MovieClip{
	
	private var logString:String;
	
	
	public function DebugDisplayer() {
		clearAll();
	}
	
	
	
	///////////////
	function log(eo:Object){
		
		this.addLog(eo.msg.toString());
	}
	
	function addLog(s:String){
		logString+=s+"\n";
	}
	
	
	
	
	
	////////////////
	function clearAll(){
		clearLog();
	}
	
	function clearLog(){
		logString="";
	}
	
	
}