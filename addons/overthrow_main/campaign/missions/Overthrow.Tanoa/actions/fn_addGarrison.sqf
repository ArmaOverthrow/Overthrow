params ["_create"];

private _b = (getpos player) call OT_fnc_nearestBase;
private _pos = _b select 0;
_code = format["fob%1",_pos];
if(_pos distance player > 30) then {
    _b = (getpos player) call OT_fnc_nearestObjective;
    _pos = _b select 0;
    _code = _b select 1;
};

if(({side _x == west or side _x == east} count (_pos nearEntities 50)) > 0) exitWith {"You cannot garrison with enemies nearby" call OT_fnc_notifyMinor};

_group = spawner getVariable [format["resgarrison%1",_code],grpNull];
_doinit = false;
if(isNull _group) then {
    _group = creategroup resistance;
    spawner setVariable [format["resgarrison%1",_code],_group,true];
    _doinit = true;
};
private _sol = [];
if(typename _create == "SCALAR") then {
    _sol = OT_recruitables select _create;
    _cls = _sol select 0;

    _soldier = _cls call OT_fnc_getSoldier;

    private _money = player getVariable ["money",0];
    private _cost = _soldier select 0;
    if(_money < _cost) exitWith {format ["You need $%1",_cost] call OT_fnc_notifyMinor};

    [-_cost] call money;

    private _civ = [_soldier,_pos,_group] call OT_fnc_createSoldier;

    if(_doinit) then {
        _group call OT_fnc_initMilitaryPatrol;
    };
}else{
    if(_create == "HMG") then {
        _p = _pos findEmptyPosition [30,80,"I_HMG_01_high_F"];

        _cost = ["Tanoa","I_HMG_01_high_weapon_F",0] call OT_fnc_getPrice;
        _cost = _cost + (["Tanoa","CIV",0] call OT_fnc_getPrice);
        _cost = _cost + 300;

        private _money = player getVariable ["money",0];
        if(_money < _cost) exitWith {format ["You need $%1",_cost] call OT_fnc_notifyMinor};
        [-_cost] call money;

        _gun = "I_HMG_01_high_F" createVehicle _p;
        createVehicleCrew _gun;
        {
            [_x] joinSilent _group;
        }foreach(crew _gun);
    };
    if(_create == "GMG") then {
        _p = _pos findEmptyPosition [10,50,"I_GMG_01_high_F"];

        _cost = ["Tanoa","I_GMG_01_high_weapon_F",0] call OT_fnc_getPrice;
        _cost = _cost + (["Tanoa","CIV",0] call OT_fnc_getPrice);
        _cost = _cost + 300;

        private _money = player getVariable ["money",0];
        if(_money < _cost) exitWith {format ["You need $%1",_cost] call OT_fnc_notifyMinor};
        [-_cost] call money;

        _gun = "I_GMG_01_high_F" createVehicle _p;
        createVehicleCrew _gun;
        {
            [_x] joinSilent _group;
        }foreach(crew _gun);
    };
};
