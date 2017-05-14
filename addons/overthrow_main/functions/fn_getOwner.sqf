if(typename _this == "SCALAR") exitWith {
    owners getVariable [str _this,nil];
};
if((getObjectType _this) != 8 and (_this isKindOf "Building")) exitWith {
    _id = [_this] call OT_fnc_getBuildID;
    owners getVariable [str _id,nil];
};
_this getVariable ["owner",nil];
