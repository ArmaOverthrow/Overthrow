if(_this isEqualType 1) exitWith {
    owners getVariable [str _this,nil];
};
if(_this isEqualType "") exitWith {
    owners getVariable [_this,nil];
};
if((getObjectType _this) != 8 && (_this isKindOf "Building")) exitWith {
    _id = [_this] call OT_fnc_getBuildID;
    owners getVariable [_id,nil];
};
_this getVariable ["owner",nil];
