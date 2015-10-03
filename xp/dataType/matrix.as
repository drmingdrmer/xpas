/**
* @class StringTokenizer
* @author Joe Coder
*/
import xp.dataType.*;

class xp.dataType.matrix implements xp.dataType._i_matrix
{
	
	var _n_className="matrix";
	var _cn_matrix=true;
	//
	var rank:Number;
	var mtr:Array;
	//
	var updated:Boolean = false;
	//
	var determinant:Number;
	var inverse:Array;
	function matrix (n:Number)
	{
		rank = n;
		//
		mtr = new Array (rank + 1);
		for (var i = 1; i <= rank; i++)
		{
			mtr[i] = new Array (rank + 1);
		}
	}
	//
	function getRank ():Number
	{
		return rank;
	}
	//
	function setLine (i:Number, l:Array)
	{
		updated = false;
		mtr[i] = l;
		if (l.length != rank + 1)
		{
			////_n_t ("warning : uncorrect array length");
		}
	}
	//
	function getNumber (i:Number, j:Number):Number
	{
		return mtr[i][j];
	}
	//
	function update ()
	{
		getInverse ();
		updated = true;
	}
	//----------------------------------------------------------------------------------------逆矩阵	
	function getInverse ()
	{
		//
		inverse = getComplementMtr ();
		determinant = getDeterminant (mtr, rank);
		mtrDiv (inverse, determinant);
	}
	//------------------------------------------------------------------------------------------div
	function mtrDiv (m0:Array, d:Number)
	{
		for (var i = 1; i < m0.length; i++)
		{
			for (var j = 1; j < m0[i].length; j++)
			{
				m0[i][j] /= d;
			}
		}
	}
	//----------------/----------------/----------------/----------------/----------------求伴随矩阵
	function getComplementMtr ():Array
	{
		var m:Array = new Array (rank + 1);
		for (var i = 1; i <= rank; i++)
		{
			m[i] = new Array (rank + 1);
		}
		//
		for (var i = 1; i <= rank; i++)
		{
			for (var j = 1; j <= rank; j++)
			{
				//代数余子式
				m[j][i] = getCom (mtr, i, j);
			}
		}
		//伴随矩阵
		return m;
	}
	//----------------/----------------/----------------/----------------/---determinant calculate
	//求余子式值
	function getCom (m0:Array, i:Number, j:Number):Number
	{
		var mm:Array = new Array (m0.length);
		//
		//dulplicate
		var a:Number;
		var b:Number;
		for (a = 1; a <= m0.length; a++)
		{
			mm[a] = new Array (m0.length + 1);
			for (b = 1; b <= m0.length; b++)
			{
				mm[a][b] = m0[a][b];
			}
		}
		//
		//生成余字式
		for (a = 1; a <= m0.length; a++)
		{
			mm[a].splice (j, 1);
		}
		mm.splice (i, 1);
		//
		//计算余子式
		return getDeterminant (mm, rank - 1) * Math.cos (Math.PI * (i + j));
		//
	}
	//计算行列式
	function getDeterminant (mt:Array, rr:Number):Number
	{
		if (rr == 2)
		{
			return mt[1][1] * mt[2][2] - mt[2][1] * mt[1][2];
		}
		else if (rr == 1)
		{
			return mt[1][1];
		}
		else
		{
			var result:Number = 0;
			for (var i = 1; i <= rr; i++)
			{
				result += mt[1][i] * getCom (mt, 1, i);
			}
			return result;
		}
	}
	//________/________/________/________/________/________/________/________/________/________/________calculate:
	//vector multy matrix.only 3 rank supported.
	function vMul (v:vector, i:Number, isInverse:Boolean):Number
	{
		var ar:Array;
		if (isInverse)
		{
			ar = inverse;
		}
		else
		{
			ar = mtr;
		}
		var r = v.x * ar[1][i];
		r += v.y * ar[2][i];
		r += v.p * ar[3][i];
		return r;
	}
	//
	function toString(){
		var re="";
		for (var i=1;i<=rank;i++){
			for (var j=1;j<=rank;j++){
				re+=mtr[i][j]+"    ";
			}
			re+="\n";
		}
		return re;
		
		
	}
}
