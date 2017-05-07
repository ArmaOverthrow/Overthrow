params ["_obj","_owner"];
if(typename _obj == "SCALAR") exitWith {
    owners setVariable [str _obj,_owner,true];
};
if(_obj isKindOf "Building") exitWith {
    _id = [_obj] call OT_fnc_getBuildID;
    owners setVariable [str _id,_owner,true];
};
if(_obj isKindOf "CAManBase") exitWith {
    _obj setVariable ["owner",_owner,true];
};
owners setVariable [str _obj,_owner,true];
