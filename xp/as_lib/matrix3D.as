// -------------------
// 3D Matrix Class
// -------------------
// Matrix3D constructor
// ------------------
function matrix3D () {
	this.element = new Array ();
	this.createBase ();
	this.vCount = 0;
}
// Base creation
// -------------
matrix3D.prototype.createBase = function () {
	this.base = new Array ();
	this.base[1] = new Array (1, 0, 0);
	this.base[2] = new Array (0, 1, 0);
	this.base[3] = new Array (0, 0, 1);
};
// Adding a vector
// ---------------
matrix3D.prototype.addVector = function (x, y, z) {
	this.vCount++;
	this.element[this.vCount] = new Array ();
	this.element[this.vCount][1] = x;
	this.element[this.vCount][2] = y;
	this.element[this.vCount][3] = z;
};
// Deleting a vector
// ---------------
matrix3D.prototype.delVector = function (index, count) {
	if (!count) {
		count = 1;
	}
	this.element.splice (index, count);
	this.vCount -= count;
};
// Getting an element's value
// --------------------------
matrix3D.prototype.get = function (row, column) {
	return (this.element[row][column]);
};
// Setting an element's value
// --------------------------
matrix3D.prototype.set = function (row, column, arg) {
	this.element[row][column] = arg;
};
// Rotation around the X axis
// --------------------------
// It multiplicates each vector (dot multiplication) by the transformation matrix:
// 
// 1      0      0
// 0    cos ß  -sin ß
// 0    sin ß   cos ß
// 
// So, it will result the matrix transformed by:
// 
// x' = x
// y' = (cos ß) * y - (sin ß) * z
// z' = (sin ß) * y + (cos ß) * z
// 
matrix3D.prototype.Xrotation = function (beta) {
	for (var iVector = 1; iVector <= this.vCount; iVector++) {
		this.element[iVector][2] = ((Math.cos (beta)) * this.element[iVector][2]) - ((Math.sin (beta)) * this.element[iVector][3]);
		this.element[iVector][3] = ((Math.sin (beta)) * this.element[iVector][2]) + ((Math.cos (beta)) * this.element[iVector][3]);
	}
};
// Rotation around the Y axis
// --------------------------
// Transformation Matrix:
// 
// cos ß   0    sin ß
//   0     1     0   
// -sin ß  0    cos ß
//
matrix3D.prototype.Yrotation = function (beta) {
	for (var iVector = 1; iVector <= this.vCount; iVector++) {
		this.element[iVector][1] = ((Math.cos (beta)) * this.element[iVector][1]) + ((Math.sin (beta)) * this.element[iVector][3]);
		this.element[iVector][3] = (-(Math.sin (beta)) * this.element[iVector][1]) + ((Math.cos (beta)) * this.element[iVector][3]);
	}
};
// Rotation around the Z axis
// --------------------------
// Transformation Matrix:
// 
// cos ß   -sin ß   0
// sin ß    cos ß   0
//   0       0      1
//
matrix3D.prototype.Zrotation = function (beta) {
	for (var iVector = 1; iVector <= this.vCount; iVector++) {
		this.element[iVector][1] = ((Math.cos (beta)) * this.element[iVector][1]) - ((Math.sin (beta)) * this.element[iVector][2]);
		this.element[iVector][2] = ((Math.sin (beta)) * this.element[iVector][1]) + ((Math.cos (beta)) * this.element[iVector][2]);
	}
};
// Base Translation
// ----------------
matrix3D.prototype.translate = function (x, y, z) {
	this.base[1] = new Array (x, 0, 0);
	this.base[2] = new Array (0, y, 0);
	this.base[3] = new Array (0, 0, z);
};
