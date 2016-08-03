private['_object', '_visual', '_DCM'];
/*
	Author: Kyle Kotowick

	Description:
	Gets the direction cosine matrix (DCM) of the given object
	Arguments:
		0: (object) the object in question
		1: (bool) visual orientation? (false for simulation time, true for render time, default: false)

	Returns:
		(ARRAY) the DCM in format [[r1c1,r1c2,r1c3],[r2c1,r2c2,r2c3],[r3c1,r3c2,r3c3]] (r1 = row 1, c1 = column 1)
*/

_object = [_this,0] call BIS_fnc_param;
_visual = [_this,1,false,[false]] call BIS_fnc_param;

_DCM = if(_visual) then {
	[vectorDirVisual _object, vectorUpVisual _object] call MOP_fnc_vectorDirAndUp2DCM;
} else {
	[vectorDir _object, vectorUp _object] call MOP_fnc_vectorDirAndUp2DCM;
};

_DCM