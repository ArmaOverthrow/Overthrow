params ["_p","_create"];

_charge = true;
if(count _this > 2) then {
    _charge = _this select 2;
};

private _b = _p call OT_fnc_nearestBase;
private _pos = _b select 0;
_code = format["fob%1",_pos];
if(_pos distance player > 30) then {
    _b = _p call OT_fnc_nearestObjective;
    _pos = _b select 0;
    _code = _b select 1;
};

if((({side _x == west or side _x == east} count (_pos nearEntities 50)) > 0) and _charge) exitWith {"You cannot garrison with enemies nearby" call OT_fnc_notifyMinor};

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

    [-_cost] call OT_fnc_money;

    private _civ = [_soldier,_pos,_group] call OT_fnc_createSoldier;

    if(_doinit) then {
        _group call OT_fnc_initMilitaryPatrol;
    };
}else{
    if(_create == "HMG") then {
        private _buildings = nearestObjects [_pos, OT_garrisonBuildings, 250];
        _done = false;
        _dir = 0;
        _p = [];
    	{
    		private _building = _x;
    		private _type = typeof _x;
    		call {
    			if((damage _building) > 0.95) exitWith {};
    			if ((_type == "Land_Cargo_HQ_V1_F") or (_type == "Land_Cargo_HQ_V2_F") or (_type == "Land_Cargo_HQ_V3_F") or (_type == "Land_Cargo_HQ_V4_F")) exitWith {
                    _p = (_building buildingPos 8);
                    _guns = {alive _x} count(nearestObjects [_p, ["I_HMG_01_high_F","I_GMG_01_high_F"], 5]);
                    if(_guns == 0) then {
                        _done = true;
                        _dir = getDir _building;
                    };
                };
                if 	((_type == "Land_Cargo_Patrol_V1_F") or (_type == "Land_Cargo_Patrol_V2_F") or (_type == "Land_Cargo_Patrol_V3_F") or (_type == "Land_Cargo_Patrol_V4_F")) exitWith {
                    _ang = (getDir _building) - 190;
    				_p = [_building buildingPos 1, 2.3, _ang] call BIS_Fnc_relPos;
    				_dir = (getDir _building) - 180;

                    _guns = {alive _x} count(nearestObjects [_p, ["I_HMG_01_high_F","I_GMG_01_high_F"], 5]);
                    if(_guns == 0) then {
                        _done = true;
                        _dir = getDir _building;
                    };
                };

                _p = _building buildingPos 11;
                _guns = {alive _x} count(nearestObjects [_p, ["I_HMG_01_high_F","I_GMG_01_high_F"], 5]);
                if(_guns == 0) exitWith {
                    _done = true;
                    _dir = getDir _building;
                };

                _p = _building buildingPos 13;
                _guns = {alive _x} count(nearestObjects [_p, ["I_HMG_01_high_F","I_GMG_01_high_F"], 5]);
                if(_guns == 0) exitWith {
                    _done = true;
                    _dir = getDir _building;
                };
            };
            if(_done) exitWith{};
        }foreach(_buildings);

        if !(_done) then {
            _p = _pos findEmptyPosition [30,80,"I_HMG_01_high_F"];
        };

        _cost = [OT_nation,"I_HMG_01_high_weapon_F",0] call OT_fnc_getPrice;
        _cost = _cost + ([OT_nation,"CIV",0] call OT_fnc_getPrice);
        _cost = _cost + 300;

        if(_charge) then {
            private _money = player getVariable ["money",0];
            if(_money < _cost) exitWith {format ["You need $%1",_cost] call OT_fnc_notifyMinor};
            [-_cost] call OT_fnc_money;
        };

        _gun = "I_HMG_01_high_F" createVehicle _p;
        _gun setVariable ["OT_garrison",true,true];
        [_gun,getplayeruid player] call OT_fnc_setOwner;
        _gun setDir _dir;
        _gun setPosATL _p;
        createVehicleCrew _gun;
        {
            [_x] joinSilent _group;
        }foreach(crew _gun);
    };
    if(_create == "GMG") then {
        private _buildings = nearestObjects [_posTown, OT_garrisonBuildings, 250];
        _done = false;
        _dir = 0;
        _p = [];
    	{
    		private _building = _x;
    		private _type = typeof _x;

    		call {
    			if((damage _building) > 0.95) exitWith {};
    			if ((_type == "Land_Cargo_HQ_V1_F") or (_type == "Land_Cargo_HQ_V2_F") or (_type == "Land_Cargo_HQ_V3_F") or (_type == "Land_Cargo_HQ_V4_F")) exitWith {
                    _p = (_building buildingPos 8);
                    _guns = {alive _x} count(nearestObjects [_p, ["I_HMG_01_high_F","I_GMG_01_high_F"], 5]);
                    if(_guns == 0) then {
                        _done = true;
                        _dir = getDir _building;
                    };
                };
                if 	((_type == "Land_Cargo_Patrol_V1_F") or (_type == "Land_Cargo_Patrol_V2_F") or (_type == "Land_Cargo_Patrol_V3_F") or (_type == "Land_Cargo_Patrol_V4_F")) exitWith {
                    _ang = (getDir _building) - 190;
    				_p = [_building buildingPos 1, 2.3, _ang] call BIS_Fnc_relPos;
    				_dir = (getDir _building) - 180;

                    _guns = {alive _x} count(nearestObjects [_p, ["I_HMG_01_high_F","I_GMG_01_high_F"], 5]);
                    if(_guns == 0) then {
                        _done = true;
                        _dir = getDir _building;
                    };
                };

                _p = _building buildingPos 11;
                _guns = {alive _x} count(nearestObjects [_p, ["I_HMG_01_high_F","I_GMG_01_high_F"], 5]);
                if(_guns == 0) exitWith {
                    _done = true;
                    _dir = getDir _building;
                };

                _p = _building buildingPos 13;
                _guns = {alive _x} count(nearestObjects [_p, ["I_HMG_01_high_F","I_GMG_01_high_F"], 5]);
                if(_guns == 0) exitWith {
                    _done = true;
                    _dir = getDir _building;
                };
            };
            if(_done) exitWith{};
        }foreach(_buildings);

        if !(_done) then {
            _p = _pos findEmptyPosition [30,80,"I_GMG_01_high_F"];
        };

        _cost = [OT_nation,"I_GMG_01_high_weapon_F",0] call OT_fnc_getPrice;
        _cost = _cost + ([OT_nation,"CIV",0] call OT_fnc_getPrice);
        _cost = _cost + 300;

        if(_charge) then {
            private _money = player getVariable ["money",0];
            if(_money < _cost) exitWith {format ["You need $%1",_cost] call OT_fnc_notifyMinor};
            [-_cost] call OT_fnc_money;
        };

        _gun = "I_GMG_01_high_F" createVehicle _p;
        _gun setVariable ["OT_garrison",true,true];
        [_gun,getplayeruid player] call OT_fnc_setOwner;
        _gun setDir _dir;
        _gun setPosATL _p;
        createVehicleCrew _gun;
        {
            [_x] joinSilent _group;
        }foreach(crew _gun);
    };
};
