disableSerialization;
private _sel = lbCurSel 1500;
if(_sel isEqualTo -1) exitWith {};

private _id = lbData [1500, _sel];
private _veh = _id call BIS_fnc_objectFromNetId;

if(!isNil "_veh") then {
    [player,getpos _veh,(typeof _veh) call OT_fnc_vehicleGetName] call OT_fnc_givePlayerWaypoint;
};
