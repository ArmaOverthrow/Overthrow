private['_v1', '_v2', '_v3', '_V', '_Sinv', '_DCM'];
/*
	Author: Kyle Kotowick

	Description:
	Converts the given vectorDir and vectorUp into a direction cosine matrix (DCM)

	Arguments:
		0: vectorDir
		1: vectorUp

	Return:
		(ARRAY) the DCM, in format [[r1c1,r1c2,r1c3],[r2c1,r2c2,r2c3],[r3c1,r3c2,r3c3]] (r1 = row 1, c1 = column 1)
*/

_v1 = [_this,0] call BIS_fnc_param;
_v2 = [_this,1] call BIS_fnc_param;

_v3 = _v1 vectorCrossProduct _v2;

_V = [[_v1 select 1, _v2 select 1, _v3 select 1],
	  [_v1 select 0, _v2 select 0, _v3 select 0],
	  [-1*(_v1 select 2), -1*(_v2 select 2), -1*(_v3 select 2)]];

_SInv = [[1, 0, 0],
		  [0, 0, -1],
		  [0, 1, 0]];

_DCM = [_V,_sInv] call MOP_fnc_matrixMultiply;

_DCM