private _amgen = (getPlayerUID player) in (server getVariable ["generals",[]]);
if(!isMultiplayer) then {_amgen = true};


createDialog 'OT_dialog_options';
if(!isMultiplayer) then {
    ctrlEnable [1603,false];
    ctrlEnable [1604,false];
};
if (!server_dedi) then {
  ctrlEnable [1608,false];
};
if !(isServer || (call BIS_fnc_admin isEqualTo 2)) then {
  ctrlEnable [1609,false];
  ctrlShow [1609,false];
};

if(!_amgen) then {
    ctrlEnable [1600,false];
    ctrlEnable [1607,false];
    ctrlEnable [1608,false];
    ctrlEnable [1601,false];
    ctrlEnable [1602,false];
    ctrlEnable [1603,false];
    ctrlEnable [1604,false];
};
