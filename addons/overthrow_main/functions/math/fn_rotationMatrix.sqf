private _v1 = vectorDir _this;
private _v2 = vectorUp _this;

private _v3 = _v1 vectorCrossProduct _v2;

private _V = [[_v1 select 1, _v2 select 1, _v3 select 1],
	  [_v1 select 0, _v2 select 0, _v3 select 0],
	  [-1*(_v1 select 2), -1*(_v2 select 2), -1*(_v3 select 2)]];

private _SInv = [[1, 0, 0],
		  [0, 0, -1],
		  [0, 1, 0]];

private _DCM = [_V,_sInv] call OT_fnc_matrixMultiply;

_DCM
