(group (_this select 0)) setFormDir (_this select 1);
(_this select 0) spawn {
    _ti = 0;
    waitUntil {sleep 1;_ti = _ti + 1;(!(_this getVariable["OT_talking",false]) and isNull (findDisplay 8001) and isNull (findDisplay 8002)) or _ti > 20};
};
