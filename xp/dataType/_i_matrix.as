interface xp.dataType._i_matrix{

	function getRank ():Number
	
	//
	function setLine (i:Number, l:Array)
	//
	function getNumber (i:Number, j:Number):Number
	
	//
	
	//----------------------------------------------------------------------------------------逆矩阵	
	function getInverse ()
	
	//------------------------------------------------------------------------------------------div
	function mtrDiv (m0:Array, d:Number)
	
	//----------------/----------------/----------------/----------------/----------------求伴随矩阵
	function getComplementMtr ():Array
	
	//----------------/----------------/----------------/----------------/---determinant calculate
	//求余子式值
	function getCom (m0:Array, i:Number, j:Number):Number
	
	//计算行列式
	function getDeterminant (mt:Array, rr:Number):Number
	

/*
	Determinant 

transpose 
	*/
}