private _player = _this;
private _data = players getvariable (getplayeruid _player);
private _newplayer = isNil "_data";
if !(_newplayer) then {
    {
        _x params ["_key","_val"];
        if !(isNil "_val") then {
            _player setVariable [_key,_val,true];
        };
    }foreach(_data);

};

private _loadout = players getvariable format["loadout%1",getplayeruid _player];
if !(isNil "_loadout") then {
    _player setunitloadout _loadout;
};
_player setVariable ["OT_loaded",true,true];
_player setVariable ["OT_newplayer",_newplayer,true];
