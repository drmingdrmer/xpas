import it.sephiroth.structNode;

/**
* @class PathFinder
* @author Alessandro Crugnola
* @version 1.0
*/
class it.sephiroth.PathFinder
{
	/* var declaration */
	private var __array:Array = new Array();
	private var __finalPosition:Array = new Array();
	private var __startPosition:Array = new Array();
	private var __openList:Array = new Array();
	private var __closedList:Array = new Array();
	private var startingNode:structNode;
	/**
	* @method __init__ public
	* @description must be called before searching for paths
	*/
	public function __init__(){
		if(__startPosition.length == 0){
			var e:Error = new Error();
			e.message = "__init__ must be called after set start and end position"
			throw(e)
		}
		startingNode:structNode; = new structNode (__startPosition);
		startingNode.f = 0
		startingNode.h = 0
		startingNode.g = 0
		__openList.push (startingNode);
	}
	/* getter/setter */
	function set finalPosition(value:Array){
		__finalPosition = value;
	}
	function set startPosition(value:Array){
		__startPosition = value;
	}
	/**
	* @method findPath public
	*/
	public function findPath():Array
	{
		var __max:Number;
		var __sel:Number;
		var node:Object;
		var ret:Array = new Array();
		var cur:Object;
		var succ:Array;
		var skip:Boolean;
		// check first if startposition and finalposition not empty
		while (__openList.length > 0) {
			__max = 5000;
			__sel = -1;
			for (var a = 0; a < __openList.length; a++) {
				if (__openList[a].f < __max) {
					__max = __openList[a].f;
					__sel = a;
				}
			}			
			node =__openList.splice (__sel, 1);
			node = node[0];
			if (node.pos_str == __finalPosition.toString ()) {
				__closedList.push(node)
				cur = __closedList[__closedList.length - 1]
				while(cur.parent != undefined){
					ret.push(cur)
					cur = cur.parent
				}
				return ret
			}
			succ = getSuccessors (node.pos);
			for (var a = 0; a < succ.length; a++) {
				_skip = false;
				var struct = new structNode (succ[a]);
				struct.parent = node;
				struct.g = node.g + getDistance (struct.pos, node.pos);
				struct.h = getDistance (struct.pos, __finalPosition);
				struct.f = struct.g + struct.h;
				for (var b in __openList) {
					if (__openList[b].pos_str == struct.pos_str && this.openList[b].f < struct.f) {
						_skip = true;
						break;
					}
				}
				for (var b in __closedList) {
					if (this.closedList[b].pos_str == struct.pos_str && __closedList[b].f < struct.f) {
						_skip = true;
						break;
					}
				}
				if (_skip == false) {
					for (var c in __openList) {
						if (_openList[c].pos_str == struct.pos_str) {
							__openList.splice (c, 1);
						}
					}
					for (var c in __closedList) {
						if (__closedList[c].pos_str == struct.pos_str) {
							__closedList.splice (c, 1);
						}
					}
					__openList.push (struct);
				}
			}
		__closedList.push (node);
		}
	return [-1,-1]
	}
	
	/**
	* @method getSuccessor private
	* @description get the 8 successor by position
	*/
	private function getSuccessors (pos:Array):Array 
	{
		var r:Number = Number (pos[0]);
		var c:Number = Number (pos[1]);
		var ret:Array = new Array ();
		if (__array[r - 1][c] == 0) {
			ret.push ([r - 1, c]);
		}
		if (__array[r][c + 1] == 0) {
			ret.push ([r, c + 1]);
		}
		if (__array[r + 1][c] == 0) {
			ret.push ([r + 1, c]);
		}
		if (__array[r][c - 1] == 0) {
			ret.push ([r, c - 1]);
		}
		return ret;
	}
	/**
	* @method getDistance private
	* @description get the distance between 2 positions
	*/
	private function getDistance (pos1:Array, pos2:Array):Number
	{
		var d1:Number = Math.abs (pos2[0] - pos1[0]);
		var d2:Number = Math.abs (pos2[1] - pos1[1]);
		return d1 + d2;
	}
}