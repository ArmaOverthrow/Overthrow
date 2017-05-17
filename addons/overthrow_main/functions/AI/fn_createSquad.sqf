private _units = groupselectedunits player;
if(count _units < 2) exitWith {"You must select at least 2 recruits" call OT_fnc_notifyMinor};
_group = createGroup resistance;
_cc = player getVariable ["OT_squadcount",1];
{
    if(_x != player) then {
        _x setVariable ["NOAI",false,false];
        [_x] joinSilent _group;
    };
}foreach(_units);
_group setGroupIdGlobal [format["S-%1",_cc]];
_cc = _cc + 1;
player hcSetGroup [_group,groupId _group,"teamgreen"];

player setVariable ["OT_squadcount",_cc,true];

_recruits = server getVariable ["squads",[]];
_recruits pushback [getplayeruid player,"CUSTOM",_group,[]];
server setVariable ["squads",_recruits,true];

_remove = [];
_recruits = server getVariable ["recruits",[]];
{
    if((_x select 2) in _units) then {
        _remove pushback _x;
    };
}foreach(_recruits);
{
    _recruits deleteAt (_recruits find _x);
}foreach(_remove);
server setVariable ["recruits",_recruits,true];

"Squad created, use ctrl + space to command" call OT_fnc_notifyMinor;
