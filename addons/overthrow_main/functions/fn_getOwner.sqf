if(_this isKindOf "Building") exitWith {
    _id = [_this] call OT_fnc_getBuildID;
    owners getVariable [str _id,nil];
};
if(_this isKindOf "CAManBase") exitWith {
    _this getVariable ["owner",nil];
};
owners getVariable [str _this,nil];
