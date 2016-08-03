private['_DCM', '_S', '_V', '_v1', '_v2'];
/*
	Author: Kyle Kotowick

	Description:
	Converts the given direction cosine matrix (DCM) to a vectorDirAndUp format

	Arguments:
		0: the DCM, in format [[r1c1,r1c2,r1c3],[r2c1,r2c2,r2c3],[r3c1,r3c2,r3c3]] (r1 = row 1, c1 = column 1)

	Return:
		0: vectorDir
		1: vectorUp
*/

_DCM = [_this,0] call BIS_fnc_param;

_S = [[1, 0, 0],
	  [0, 0, 1],
	  [0, -1, 0]];

_V = [_DCM, _S] call utils_fnc_matrixMultiply;

_v1 = [(_V select 1) select 0, (_V select 0) select 0, -1 * ((_V select 2) select 0)];
_v2 = [(_V select 1) select 1, (_V select 0) select 1, -1 * ((_V select 2) select 1)];

[_v1, _v2]