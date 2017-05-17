/*

	fnc_getBuildID.sqf - Twirly 22 Sept 2011
	Function for returning building ID's

	In your init.sqf:-

		fnc_getBuildID = compile preprocessFile "fnc_getBuildID.sqf";

	Call with:-

		_id = [building] call OT_fnc_getBuildID;

*/

private ["_build","_sn","_sf","_ef","_na","_id","_i","_item"];

_build = _this select 0;

_sn = toArray (str (_build));

_sf = false;_ef = false;_na = [];_id = 0;

for "_i" from 0 to (count _sn)-1  do {
	_item = _sn select _i;
	if (_sf and (not (_ef))) then {
		_na set [count _na,_item];
	};
	if (_item == 35) then {
		_sf = true;
	};
	if (_item == 58) then {
		_ef = true;
	};
};

if ((count _na) >=3) then {
	_na set [((count _na)-1) ,"delete"];
	_na = _na - ["delete"];
	_na set [0 ,"delete"];
	_na = _na - ["delete"];
	_id = parseNumber(toString (_na));
};

_id
