/*****************************************************
*
*	Peter Hall 2002
*	www.peterjoel.com
*
*	HSB conversion methods for the Color object
*
*	myCol.setHSB({H:hue, S:sat, B:bri})
*	myCol.getHSB()
*		- returns {H:hue, S:sat, B:bri}
*
*	Static methods:
*
*	Color.RGB_to_HSB(0xRRGGBB)
*		- returns {H:hue, S:sat, B:bri}
*	Color.HSB_to_RGB({H:hue, S:sat, B:bri})
*		- returns 0xRRGGBB
*
*	The colour-space conversion is based purely on
*	my own interpretation and intuitive notion of the
*	colour spaces. These methods may produce results
*	which vary slightly from conversions carried out
*	by different graphical software that you may be
*	used to.
*
*   If this script enables you or your company to make
*	significant financial gain, you might like to make
*	a contribution to show your appreciation. Please
*   see my site for more information.
*
******************************************************/


Color.prototype.setHSB = function(colHSB){
	var hue = (colHSB.H == null) ? 0 : (360+colHSB.H)%360;
	var sat = (colHSB.S == null) ? 100 : colHSB.S;
	var bri = (colHSB.B == null) ? 100 : colHSB.B;
	this.setRGB(Color.HSB_to_RGB({H:hue,S:sat,B:bri}));
}

Color.prototype.getHSB = function(){
	return Color.RGB_to_HSB(this.getRGB());
}

Color.RGB_to_HSB = function(colRGB){

	var red = (colRGB&0xFF0000)>>16;
	var gre = (colRGB&0x00FF00)>>8;
	var blu = colRGB&0x0000FF;

	var max = Math.max(red,Math.max(gre,blu));
	var min = Math.min(red,Math.min(gre,blu));

	var colHSB = {}
	colHSB.B = Math.round(max*100/255);

	if(max==min){ // if grey
		colHSB.S = 0;
		colHSB.H = 0;
	}else{
		colHSB.S = Math.round(100*(max-min)/max);
		// find hue
		var hue;
		var tmpR = (max-red)/(max-min);
		var tmpG = (max-gre)/(max-min);
		var tmpB = (max-blu)/(max-min);
		if(red==max){
			hue = tmpB - tmpG;
		}else if(gre==max){
			hue = 2 + tmpR - tmpB;
		}else if(blu==max){
			hue = 4 + tmpG - tmpR;
		}
		colHSB.H = (Math.round(hue*60) + 360)%360;
	}

	return colHSB;

}

Color.HSB_to_RGB = function(colHSB){
	var sat = colHSB.S;
	var bri = colHSB.B;

	var red, gre, blu;
	// if grey don't bother doing any more
	if(sat==0){
		red = bri;
		gre = bri;
		blu = bri;
	}else{

		var hue = (colHSB.H+360)%360;
		var hue2 = Math.floor(hue/60);

		var dif = (hue%60)/60;
		var mid1 = bri*(100-sat*dif)/100;
		var mid2 = bri*(100-sat*(1-dif))/100;
		var min = bri*(100-sat)/100;

		if(hue2 == 0){
			red = bri;
			gre = mid2;
			blu = min;
		}else if(hue2 == 1){
			red = mid1;
			gre = bri;
			blu = min;
		}else if(hue2 == 2){
			red = min;
			gre = bri;
			blu = mid2;
		}else if(hue2 == 3){
			red = min;
			gre = mid1;
			blu = bri;
		}else if(hue2 == 4){
			red = mid2;
			gre = min;
			blu = bri;
		}else{
			red = bri;
			gre = min;
			blu = mid1;
		}
	}
	return (Math.round(red*255/100)<<16 | Math.round(gre*255/100) <<8 | Math.round(blu*255/100));
}


