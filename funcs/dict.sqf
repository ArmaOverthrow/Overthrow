dict_create = {
    //_ref = call dict_create;
    private "_ref";
    _ref = str ("WeaponHolderSimulated" createVehicleLocal [0,0,0]);
    missionNamespace setVariable [_ref + "_KEYS", []];
    missionNamespace setVariable [_ref + "_VALS", []];
    _ref
};

dict_set = {
	//_ref = [_ref, _key, _val] call dict_set;
    private ["_ref","_keysRef","_valsRef","_keys","_vals","_key","_indx"];
    _ref = _this select 0;
    _keysRef = format ["%1_KEYS", _ref];
    _valsRef = format ["%1_VALS", _ref];
    if (isNil _keysRef || isNil _valsRef) then {
        missionNamespace setVariable [_keysRef, []];
        missionNamespace setVariable [_valsRef, []];
    };
    _keys = missionNamespace getVariable _keysRef;
    _vals = missionNamespace getVariable _valsRef;
    _key = _this select 1;
    _indx = _keys find _key;
    if (_indx < 0) then {
        _indx = count _keys;
        _keys set [_indx, _key];
    };
    _vals set [_indx, _this select 2];
    _ref
};

dict_pushback = {
	//_ref = [_ref, _key, _val] call dict_pushback;
	_arr = [_this select 0, _this select 1] call dict_get;
	if(isNil "_arr") then {
		_arr = [];
	};
	_arr pushback (_this select 2);
	[_this select 0, _this select 1, _arr] call dict_set;
};

dict_exists = {
	//_bool = [_ref, _key] call dict_exists
	(_this select 1 in (missionNamespace getVariable [format [
        "%1_KEYS", 
        _this select 0
    ], []]))
};

dict_get = {
	//_val = [_ref, _key] call dict_get;
    private ["_ref","_keys","_indx"];
    _ref = _this select 0;
    _keys = missionNamespace getVariable [format ["%1_KEYS", _ref], []];
    _indx = _keys find (_this select 1);
    if (_indx < 0) exitWith {};
    (missionNamespace getVariable [format ["%1_VALS", _ref], []]) select _indx
};

dict_destroy = {
	//_ref call KK_fnc_assocArrayDestroy;
    missionNamespace setVariable [format ["%1_KEYS", _this], nil];
    missionNamespace setVariable [format ["%1_VALS", _this], nil];
};

dict_keys = {
    //_keys = _ref call dict_keys
    missionNamespace getVariable [format ["%1_KEYS", _this], []]
};