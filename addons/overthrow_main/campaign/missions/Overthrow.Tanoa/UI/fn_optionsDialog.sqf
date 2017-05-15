

private _amgen = (getPlayerUID player) in (server getVariable ["generals",[]]);
if(!isMultiplayer) then {_amgen = true};

if(!_amgen) then {
    "You must be a General to change options" call OT_fnc_notifyMinor;
}else{
    createDialog 'OT_dialog_options';
    if(!isMultiplayer) then {
        ctrlEnable [1603,false];
        ctrlEnable [1604,false];
    }
};
