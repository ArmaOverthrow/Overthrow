private['_roll', '_pitch', '_yaw', '_radians', '_sinR', '_cosR', '_sinP', '_cosP', '_sinY', '_cosY', '_DCM'];
/*
	Author: Kyle Kotowick

	Description:
	Converts roll, pitch, and yaw to a direction cosine matrix (DCM)

	Arguments:
		0: the roll
		1: the pitch
		2: the yaw
		3: (bool) are the parameters in radians? (true for rads, false for degrees, default: false)

	Returns:
		(ARRAY) the DCM in format [[r1c1,r1c2,r1c3],[r2c1,r2c2,r2c3],[r3c1,r3c2,r3c3]] (r1 = row 1, c1 = column 1)
*/

_roll = [_this,0] call BIS_fnc_param;
_pitch = [_this,1] call BIS_fnc_param;
_yaw = [_this,2] call BIS_fnc_param;
_radians = [_this,3,false,[false]] call BIS_fnc_param;

// if they're in radians, convert them into degrees first (since that's what the trig commands expect)
if(_radians) then {
	_roll = _roll * 180 / pi;
	_pitch = _pitch * 180 / pi;
	_yaw = _yaw * 180 / pi;
};

_sinR = sin _roll;
_cosR = cos _roll;
_sinP = sin _pitch;
_cosP = cos _pitch;
_sinY = sin _yaw;
_cosY = cos _yaw;

_DCM = [[_cosP * _cosY, (_sinR * _sinP * _cosY) - (_cosR * _sinY), (_cosR * _sinP * _cosY) + (_sinR * _sinY)],
			[_cosP * _sinY, (_sinR * _sinP * _sinY) + (_cosR * _cosY), (_cosR * _sinP * _sinY) - (_sinR * _cosY)],
			[-1 * _sinP, _sinR *_cosP, _cosR * _cosP]];

_DCM