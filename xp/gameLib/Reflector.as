//
//on(collide) or onCollide
//on(passed) or onPassed
//on(hit) or onHit
[Event("collide")]
[Event("passed")]
[Event("hit")]
class xp.gameLib.Reflector extends MovieClip {
	//
	// event dispatch utilities:
	var addEventListener:Function;
	var removeEventListener:Function;
	var dispatchEvent:Function;
	private var dispatchQueue:Function;
	//
	private static var __xp__init_EventDispatcher = mx.events.EventDispatcher.initialize (Reflector.prototype);
	//
	//
	//broadcaster for test collision/refresh.
	private static var __testCollisionBroadcaster ;
	//	
	//
	//event list:
	private var __f_hit:Function;
	private var __f_collide:Function;
	private var __f_passed:Function;
	//
	var onHit:Function;
	var onCollide:Function;
	var onPassed:Function;
	//
	//list of mc which will be test 	
	private var testList:Array;
	//
	//width control variables
	var xMax = 0, xMin = 0;
	//
	//bounds
	var top, left, right, bottom;
	//
	//
	//component parameters for config this plane,& also could be set in runtime.
	//
	//
	//visual effect clip's linkage id.
	[Inspectable(defaultValue="",type="String")]
	var clipName:String = "ef";
	//
	var clipIns:MovieClip;
	

	
	//
	//if it is a double side plane.
	[Inspectable(defaultValue=false,type="Boolean")]
	var doubleSide:Boolean = false;
	//
	//
	//friction:
	//
	//f>0;
	//0:+oo friction
	//1:no friction;
	[Inspectable(defaultValue=0,type="Number")]
	var f:Number = 0;
	//
	//
	//elasticity:
	//
	//0:no elasticity,object will be sticked after collision.
	//>0:reflect after collision;
	//>1:speed up & reflect.
	//<0:get through,but slow down.
	//<-1:get through,and speed up.
	[Inspectable(defaultValue=0,type="Number")]
	var e:Number = 0;
	//
	//u could add a force to a mc while it touch it.
	[Inspectable(defaultValue=0,type="Number")]
	var xForce = 0;
	//
	[Inspectable(defaultValue=0,type="Number")]
	var yForce = 0;
	//
	//
	//
	var _enabled:Boolean = true;
	//
	function set enabled (e:Boolean) {
		_enabled = e;
		//
		//update old position record:
		if (e) {
			for (var i = 0; i < testList.length; i++) {
				var o = testList[i];
				//remove dead links.
				if (o.ins == undefined) {
					testList.splice (i, 1);
					i--;
					continue;
				}
				//new position
				o.v1.x = o.ins._x;
				o.v1.y = o.ins._y;
				//
				o.ins._parent.localToGlobal (o.v1);
				this.globalToLocal (o.v1);
			}
		}
	}
	function get enabled(){
		return _enabled;
	}
	//
	
	//refresh for all reflectors
	static function refresh () {
		
		
		__testCollisionBroadcaster.broadcast ();
	}
	
	//
	//
	function Reflector () {
		super ();
		//
		_global.refreshReflector=xp.gameLib.Reflector.refresh;
		//
		testList = new Array ();
		//
		//
		if (clipName==undefined || clipName=="") clipName="ef";
		clipIns= this.attachMovie (clipName, "1", 1);
		//
		//
		if (!__testCollisionBroadcaster) __testCollisionBroadcaster = xp.system.Broadcaster.createManualBroadcaster ("testCollision")
		
		__testCollisionBroadcaster.addListener (this);
		//
		//
		this.addEventListener ("onHit", this);
		this.addEventListener ("onCollide", this);
		this.addEventListener ("onPassed", this);
		//
		//
		update ();
		
	}
	//
	//
	//
	function addTarget (o:MovieClip) {
		testList.push ({ins:o, v1:{x:0, y:0}, v2:{x:0, y:0}});
		this.addEventListener ("onHit", o);
		this.addEventListener ("onCollide", o);
		this.addEventListener ("onPassed", o);
	}
	//
	function removeTarget (o:MovieClip) {
		for (var i = 0; i < testList.length; i++) {
			if (testList[i].ins == o) {
				testList.splice (i, 1);
			}
		}
	}
	
	//
	//
	//
	function testCollision () {
		
		if (!_enabled) {
			return;
		}
		
		//
		for (var i = 0; i < testList.length; i++) {
			var o = testList[i];
			var re:Object;
			//remove dead links.
			if (o.ins == undefined) {
				testList.splice (i, 1);
				i--;
				continue;
			}
			//new position
			o.v2.x = o.ins._x;
			o.v2.y = o.ins._y;
			//
			o.ins._parent.localToGlobal (o.v2);
			this.globalToLocal (o.v2);
			//
			re=new Object();
			
			var flag:Boolean=collisionCalculate (o.v1, o.v2,o.ins,re);
			
			
			
			if (flag)
			{
			
			
			
				//
				var rp={x:re.x0+re.vvx,y:re.vvy};
				this.localToGlobal(rp);
				o.ins._parent.globalToLocal(rp);
				//
				var rp0={x:re.x0,y:0};
				this.localToGlobal(rp0);
				o.ins._parent.globalToLocal(rp0);
				//
				rp.x-=rp0.x;
				rp.y-=rp0.y;
				
				//
				//
				//event dispatching:
				//clip event & onXXX event.
				//
				this.__f_hit ();
				this.dispatchEvent ({type:"onHit", hitPosition:re.x0,velocity:{x:re.vvx,y:re.vvy},rv:{x:rp.x,y:rp.y}});
				//
				if (e >= 0) {
					this.__f_collide ();
					this.dispatchEvent ({type:"onCollide", hitPosition:re.x0,velocity:{x:re.vvx,y:re.vvy},rv:{x:rp.x,y:rp.y}});
				}
				else {
					this.__f_passed ();
					this.dispatchEvent ({type:"onPassed", hitPosition:re.x0,velocity:{x:re.vvx,y:re.vvy},rv:{x:rp.x,y:rp.y}});
				}
				
			
			}
			//record old position for next test.
			o.v1.x = o.v2.x;
			o.v1.y = o.v2.y;
			//
			this.localToGlobal (o.v2);
			o.ins._parent.globalToLocal (o.v2);
			//
			//refresh position.
			o.ins._x = o.v2.x;
			o.ins._y = o.v2.y;
		}
	}
	//
	//
	//v1 / v2 are objects with properties 'x' & 'y',in this coordinates
	//
	function collisionCalculate (v1, v2,ins,result):Boolean {
		
		//
		var x0 = (v1.x * v2.y - v2.x * v1.y) / (v2.y - v1.y);
		//
		var _through = (v1.y * v2.y <= 0 && (v1.y !=0 || v2.y != 0)) && (doubleSide || (!doubleSide && v1.y < v2.y));
		//
		if (_enabled && _through && x0 < xMax && x0 > xMin) {
			var t2=v2.y/(v2.y-v1.y);
			//it collides to this plane.
			//
			v2.y*=-e;
			/*
			if (v2.y > 0) {
				//this 0.01 is the plane's height,for bug avoiding.
				//move 0.01 away from the reflector..
				//it is easy to create a plane with real height,but most time it is not necessary
				v2.y *= -e;
				v2.y -= .1;
			}
			else if (v2.y<0){
				v2.y *= -e;
				v2.y += .1;
			}
			*/
			v2.x = x0 + (v2.x - x0) * f;
			//
			//
			
			//
			var vvx,vvy;
			if (t2==0) {
				//infinite avoiding
				vvx=0;
				vvy=0;
			}
			else
			{
				vvx=(v2.x-x0)/t2;
				vvy=v2.y/t2
			}
			vvx+=xForce;
			vvy-=yForce;
			//
			result.vvx=vvx;
			result.vvy=vvy;
			result.x0=x0;
			
			return true;
		}
		else {
			return false;
		}
	}
	//
	function update () {
		//
		var o = this.getBounds (this._parent);
		//
		top = o.yMin;
		bottom = o.yMax;
		left = o.xMin;
		right = o.xMax;
		//
		o = this.getBounds (this);
		xMax = o.xMax;
		xMin = o.xMin;
	}
}
