params ["_unit","_dir"];
(group _unit) setFormDir _dir;
_unit spawn {
    private _ti = 0;
    waitUntil {
        sleep 1;
        _ti = _ti + 1;
        (!(_this getVariable["OT_talking",false]) && isNull (findDisplay 8001) && isNull (findDisplay 8002)) || _ti > 20
    };
};
