private _squad = (hcselected player) select 0;
private _veh = cursorObject;
private _leader = leader _squad;
if(_leader distance _veh > 30) exitWith {"Squad leader must be within 30m of vehicle" call OT_fnc_notifyMinor};
if((_veh isKindOf "StaticWeapon") || (_veh isKindOf "Air") || (_veh isKindOf "Land") || (_veh isKindOf "Ship")) then {
    _squad setVariable ["OT_assigned",_veh,false];
    _squad addVehicle _veh;
    (units _squad) orderGetIn true;
    player hcSelectGroup [_squad,false];
    format["%1 assigned to %2",(typeof _veh) call OT_fnc_vehicleGetName,groupId _squad] call OT_fnc_notifyMinor;
};
