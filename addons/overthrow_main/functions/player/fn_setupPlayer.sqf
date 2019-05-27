player call OT_fnc_statsSystem;
player call OT_fnc_wantedSystem;
player call OT_fnc_mapSystem;

[OT_fnc_perkSystem,player,1] call CBA_fnc_waitAndExecute;
[OT_fnc_notificationLoop,player,1] call CBA_fnc_waitAndExecute;

player setVariable ["player_uid",getPlayerUID player,true];

disableUserInput false;

//Scroll actions
{
    _x params ["_pos"];
    private _base = _pos nearObjects [OT_flag_IND,5];
    if((count _base) > 0) then {
        _base = _base#0;
        _base addAction ["Set As Home", {player setVariable ["home",getpos (_this select 0),true];"This FOB is now your home" call OT_fnc_notifyMinor},nil,0,false,true];
    };
}foreach(server getVariable ["bases",[]]);
