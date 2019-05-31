params ["_unit",["_baseloadout",[]],["_params",[]]];

private _index = "";
if(_unit isEqualType "") then {
    _index = _unit;
}else{
    _index = typeof _unit;
};

private _loadouts = spawner getVariable [format["loadouts_%1",_index],[]];
private _loadout = [];
if(count _loadouts > 0) then {
    //return a cached loadout
    _loadout = selectRandom _loadouts;
}else{
    //generate one and cache it
    if((count _baseloadout) isEqualTo 0) then {
        _baseloadout = getUnitLoadout _unit;
    };
    private _options = [_baseloadout] + _params;
    _loadout = _options call OT_fnc_randomizeLoadout;
    spawner setVariable [format["loadouts_%1",_index],[_loadout],false];
};
_loadout;
