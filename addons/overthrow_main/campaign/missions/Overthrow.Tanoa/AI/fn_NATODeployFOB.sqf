_leader = _this;

_group = group _leader;
private _targetPos = _leader getVariable ["OT_targetPos",objNull];
private _veh = vehicle _leader;

{
    unassignVehicle _x;
}foreach(units _group);
(units _group) allowGetIn false;

sleep 10;
if(({alive _x} count (units _group)) == 0) exitWith {};

if(!isNull _veh) then {deleteVehicle _veh};
_flag = OT_flag_NATO createVehicle _targetPos;

private _fobs = server getVariable ["NATOfobs",[]];
_fobs pushback [_targetPos,count units _group,[]];
server setVariable ["NATOfobs",_fobs,true];
_group call OT_fnc_initMilitaryPatrol;
