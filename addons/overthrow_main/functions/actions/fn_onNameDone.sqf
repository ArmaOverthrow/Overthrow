private _name = ctrltext 1400;
if(_name != "") then {
    closeDialog 0;

    private _base = (player nearObjects [OT_flag_IND,50]) select 0;

    [_base, ["Set As Home", {player setVariable ["home",getpos (_this select 0),true];"This FOB is now your home" call OT_fnc_notifyMinor},nil,0,false,true]] remoteExec ["addAction",0,_base];

    private _bases = server getVariable ["bases",[]];
    _bases pushback [getpos _base,_name,getplayeruid player];
    server setVariable ["bases",_bases,true];
    _base setVariable ["name",_name];
    private _mrkid = format["%1-base",getpos _base];
    createMarker [_mrkid,getpos _base];
    _mrkid setMarkerShape "ICON";
    _mrkid setMarkerType "mil_Flag";
    _mrkid setMarkerColor "ColorWhite";
    _mrkid setMarkerAlpha 1;
    _mrkid setMarkerText _name;
    private _builder = name player;
    {
        [
            _x,
            format["New Base: %1",_name],
            format["%1 created a new base for resistance efforts %2",_builder,(getpos _base) call BIS_fnc_locationDescription]
        ] call BIS_fnc_createLogRecord;
    }foreach([] call CBA_fnc_players);
};
