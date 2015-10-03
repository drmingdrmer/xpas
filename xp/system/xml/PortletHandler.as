class PortletHandler extends Handler{
	//overwritten
	var lineAlpha:Number = 0;
	
	var centerLineWidth:Number = 1;
	var centerLineAlpha:Number = 100;
	var centerLineColor:String = "0xff0000";
	
	
	var txt:String;
	
	function PortletHandler(){
		
		
		//this.createTextField("tt", 23423, 0, 0, this._width, this._height);
		//this["tt"].text=txt;
		this.attachMovie("psymbol","x",123234);
		trace("!!!!!!!!!!");
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
		
		d.moveTo(0, height/2);
		d.lineTo(width, height/2);
		
		
	}
	
	
}