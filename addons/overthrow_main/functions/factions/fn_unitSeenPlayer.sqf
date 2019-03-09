if!((vehicle _this) isEqualTo _this) then {_this = vehicle _this};

private _cache = _this getVariable "SeenCachePlayer";
if (isNil "_cache" || {time > (_cache select 1)}) then {
    _cache = [
        !(
            ((call CBA_fnc_players) findIf {
                _x = driver _x;
                (_x distance _this) < 7
                ||
                { (time - ((_x targetKnowledge _this) select 2)) < 10 }
            }) isEqualTo -1
        ),
        time + 7
    ];
    _this setVariable ["SeenCachePlayer",_cache];
};
_cache select 0
