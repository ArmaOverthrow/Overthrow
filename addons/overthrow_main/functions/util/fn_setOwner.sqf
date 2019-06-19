params ["_obj",["_owner",objNull]];
if(typename _obj isEqualTo "SCALAR") exitWith {
    owners setVariable [str _obj,_owner,true];
};
if(typename _obj isEqualTo "STRING") exitWith {
    owners setVariable [_obj,_owner,true];
};
if(typename _obj != "OBJECT") exitWith {};
_obj setVariable ["owner",_owner,true];
if((getObjectType _obj) != 8 && (_obj isKindOf "Building")) exitWith {
    _id = [_obj] call OT_fnc_getBuildID;
    owners setVariable [_id,_owner,true];
};
