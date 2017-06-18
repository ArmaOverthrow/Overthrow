private _player = _this;
_newplayer = true;
_data = server getvariable (getplayeruid _player);
_count = 0;
if !(isNil "_data") then {
    _newplayer = false;
    {
        _key = _x select 0;
        _val = _x select 1;
        if !(isNil "_val") then {
            _player setVariable [_key,_val,true];
        };
        _count = _count + 1;
        if(_count > 50) then {
            _count = 0;
            sleep 0.2;
        };
    }foreach(_data);

};

_loadout = server getvariable format["loadout%1",getplayeruid _player];
if !(isNil "_loadout") then {
    _player setunitloadout _loadout;
};
_player setVariable ["OT_loaded",true,true];
_player setVariable ["OT_newplayer",_newplayer,true];
