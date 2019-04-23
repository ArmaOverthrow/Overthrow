player call OT_fnc_statsSystem;
player call OT_fnc_wantedSystem;
player call OT_fnc_mapSystem;

[OT_fnc_perkSystem,player,1] call CBA_fnc_waitAndExecute;
[OT_fnc_notificationLoop,player,1] call CBA_fnc_waitAndExecute;

player setVariable ["player_uid",getPlayerUID player,true];

disableUserInput false;
