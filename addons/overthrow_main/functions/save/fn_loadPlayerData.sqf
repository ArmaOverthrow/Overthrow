private _player = _this;
private _data = players_NS getvariable (getplayeruid _player);
private _newplayer = isNil "_data";
if !(_newplayer) then {
    {
        _x params ["_key","_val"];
        if !(isNil "_val") then {
            if((_key select [0,3] != "tf_") && {!((_key select [0,7]) in ["@attack","@counte","@assaul"])}) then {
                _player setVariable [_key,_val,true];
            };
        };
    }foreach(_data);

};
_player setVariable ["OT_newplayer",_newplayer,true];

private _loadout = players_NS getvariable format["loadout%1",getplayeruid _player];
if !(isNil "_loadout") then {
    _player setunitloadout _loadout;
};
_player setVariable ["OT_loaded",true,true];
