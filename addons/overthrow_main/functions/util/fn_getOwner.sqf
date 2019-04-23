if(_this isEqualType 1) exitWith {
    owners getVariable [str _this,nil];
};
if(_this isEqualType "") exitWith {
    owners getVariable [_this,nil];
};
if((getObjectType _this) != 8 && (typeOf _this isKindOf ["Building", configFile >> "CfgVehicles"])) exitWith {
    owners getVariable [[_this] call OT_fnc_getBuildID,nil];
};
_this getVariable ["owner",nil];
