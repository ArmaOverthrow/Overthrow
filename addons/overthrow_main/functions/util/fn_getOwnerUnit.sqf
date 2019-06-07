private _uid = _this call OT_fnc_getOwner;
private _player = objNull;
{
    if(getplayeruid _x isEqualTo _uid) exitWith {_player = _x};
}foreach(allplayers);

_player
