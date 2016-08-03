private['_DCM', '_radians', '_roll', '_pitch', '_yaw'];
/*
	Author: Kyle Kotowick

	Description:
	Converts a direction cosine matrix (DCM) into roll-pitch-yaw format

	Arguments:
		0: (array) the DCM, in format [[r1c1,r1c2,r1c3],[r2c1,r2c2,r2c3],[r3c1,r3c2,r3c3]] (r1 = row 1, c1 = column 1)
		1: (bool) should the result be converted to radians? (true for rads, false for degrees)

	Returns:
		0: roll
		1: pitch
		2: yaw
*/

_DCM = [_this,0] call BIS_fnc_param;
_radians = [_this,1,false,[false]] call BIS_fnc_param;

_roll = ((_DCM select 2) select 1) atan2 ((_DCM select 2) select 2);
_pitch = -1 * asin ((_DCM select 2) select 0);
_yaw = ((_DCM select 1) select 0) atan2 ((_DCM select 0) select 0);

if(_radians) then {
	_roll = _roll * pi / 180;
	_pitch = _pitch * pi / 180;
	_yaw = _yaw * pi / 180;
};

[_roll,_pitch,_yaw]