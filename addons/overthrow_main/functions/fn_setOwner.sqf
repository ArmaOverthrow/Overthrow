params ["_obj","_owner"];
if(typename _obj == "SCALAR") exitWith {
    owners setVariable [str _obj,_owner,true];
};
if((getObjectType _obj) != 8 and (_obj isKindOf "Building")) exitWith {
    _id = [_obj] call OT_fnc_getBuildID;
    owners setVariable [str _id,_owner,true];
};
_obj setVariable ["owner",_owner,true];
