dynamic class xp.dataType.ScrollBuffer extends Array {
	private var current:Number = 0;
	function ScrollBuffer (l:Number) {
		super (l);
	}
	function addObj (o:Object) {
		this[current] = o;
		current++;
		if (current >= this.length) {
			current = 0;
		}
	}
	function getObj (n:Number):Object {
		if (n > 0) {
			//illegal to read data unfit
			return undefined;
			n = 0;
		}
		if (n <= -this.length) {
			//the last one is -(this.length-1),equal to 1
			return undefined;
			n = 1;
		}
		//current item is current-1.current is to be fit
		var l = current - 1 + n + this.length;
		return this[l % this.length];
	}
	function getCurrentObj():Object{
		return this[current];
	}
}
