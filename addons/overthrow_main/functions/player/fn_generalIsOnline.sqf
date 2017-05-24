private _online = false;
{
    if((getPlayerUID _x) in (server getvariable ["generals",[]])) exitWith {
            _online = true;
    };
}foreach(call CBA_fnc_players);
_online;
