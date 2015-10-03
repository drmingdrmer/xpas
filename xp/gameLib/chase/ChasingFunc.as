class xp.gameLib.chase.ChasingFunc {
	static function instantaneous (s, e):Number {
		if (typeof (s) == "number") {
			return e;
		}
		else {
			
			var k=new Object();
			for (var i in s){
				k[i]=e[i];
			}
			return k;
		}
	}
	static function geometric(s,e,q,st):Number{
		if (!q) q=.5;
		if (typeof (s) == "number") {
			return (e-s)*q+s;
		}
		else {
			var k=new Object();
			for (var i in s){
				k[i]=(e[i]-s[i])*q+s[i];
			}
			return k;
		}
	}
	static function specifiedStep(s,e,q,st):Number{
		if (!st) st=1;
		if (typeof (s) == "number") {
			var o:Number=(e-s);
			Flashout.log("correct --"+ (o>st?st:(o<(-st)?(-st):o)));
			
			return (o>st?st:(o<(-st)?(-st):o))+s;
		}
		else {
			trace(typeof(s))
			var k=new Object();
			for (var i in s){
				//
			}
			return k;
		}
	}


}
