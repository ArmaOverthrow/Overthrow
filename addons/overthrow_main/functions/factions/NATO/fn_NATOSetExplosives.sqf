_leader = _this;

_group = group _leader;
private _targetPos = _leader getVariable ["OT_targetPos",objNull];

_gotexp = false;
_expert = objNull;
{
    if("DemoCharge_Remote_Mag" in magazines _x) then {
        _gotexp = true;
        _expert = _x;
    };
}foreach(units _group);

if(_gotexp) then {
    _p = _targetPos;
    _expert setVariable ["NOAI",true,true];
    _group setCombatMode "COMBAT";
    _expert commandMove _p;
    waitUntil {sleep 1;(!alive _expert) || (_expert distance _targetPos) < 10};
    if(alive _expert) then {
        _expert removeMagazineGlobal "DemoCharge_Remote_Mag";
        _p set [2,1];
        _charge = "DemoCharge_Remote_Ammo" createVehicle _p;
        _charge setPosATL _p;

        //run away!
        _runto = [_p,[1000,2000],random 360] call SHK_pos_fnc_pos;
        _wp = _group addWaypoint [_runto,0];
        _wp setWaypointType "MOVE";
        _wp setWaypointBehaviour "COMBAT";
        _wp setWaypointSpeed "FULL";
        _expert setVariable ["NOAI",false,true];

        sleep 120;
        [[_charge], 0] call ace_explosives_fnc_scriptedExplosive;
    };
};
