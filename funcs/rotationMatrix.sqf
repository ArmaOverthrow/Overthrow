_v1 = vectorDir _this;
_v2 = vectorUp _this;

_v3 = _v1 vectorCrossProduct _v2;

_V = [[_v1 select 1, _v2 select 1, _v3 select 1],
	  [_v1 select 0, _v2 select 0, _v3 select 0],
	  [-1*(_v1 select 2), -1*(_v2 select 2), -1*(_v3 select 2)]];

_SInv = [[1, 0, 0],
		  [0, 0, -1],
		  [0, 1, 0]];

_DCM = [_V,_sInv] call matrixMultiply;

_DCM