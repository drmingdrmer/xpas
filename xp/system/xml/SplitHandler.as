class SplitHandler extends Handler {
	//overwritten
	var lineAlpha:Number = 0;
	
	var centerLineWidth:Number = 1;
	var centerLineAlpha:Number = 100;
	var centerLineColor:String = "0xff0000";
	
	
	var hori:Boolean = true;
	
	function SplitHandler() {
		//Flashout.log("create");
	}
	
	function renderBorder(d) {
		
		d.lineStyle(lineWidth,Number(lineColor),lineAlpha);
		
		
		d.beginFill(Number(this.fillColor),fillAlpha);
		
		d.moveTo(0,0);
		d.lineTo(0,_b-_t);	
		d.lineTo(_r-_l,_b-_t);
		d.lineTo(_r-_l,0);
		d.lineTo(0,0);
		
		d.endFill();
		
		
		
		
		d.lineStyle(centerLineWidth, Number(centerLineColor), centerLineAlpha);
		if (hori) {
			d.moveTo(0, height/2);
			d.lineTo(width, height/2);
		}
		else{
			d.moveTo(width/2,0);
			d.lineTo(width/2, height);
		}
	}
}
