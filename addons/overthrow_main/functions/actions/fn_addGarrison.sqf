params ["_p","_create",["_charge",true]];

private _b = _p call OT_fnc_nearestBase;
private _pos = _b select 0;
private _code = format["fob%1",_pos];
if((_pos distance player) > 100) then {
    _b = _p call OT_fnc_nearestObjective;
    _pos = _b select 0;
    _code = _b select 1;
};

if(
    (({side _x isEqualTo west || side _x isEqualTo east} count (_pos nearEntities 50)) > 0)
    &&
    _charge
) exitWith {
    "You cannot garrison with enemies nearby" call OT_fnc_notifyMinor;
};

private _group = spawner getVariable [format["resgarrison%1",_code],grpNull];
private _doinit = false;
if(isNull _group) then {
    _group = creategroup resistance;
    _group setVariable ["VCM_TOUGHSQUAD",true,true];
	_group setVariable ["VCM_NORESCUE",true,true];
    spawner setVariable [format["resgarrison%1",_code],_group,true];
    _doinit = true;
};
if(_create isEqualType 1) then {
    private _sol = OT_recruitables select _create;
    _sol params ["_cls"];
    private _soldier = _cls call OT_fnc_getSoldier;

    private _money = player getVariable ["money",0];
    private _cost = _soldier select 0;
    if(_money < _cost && _charge) exitWith {
        format ["You need $%1",_cost] call OT_fnc_notifyMinor;
    };
    if(_charge) then {
        [-_cost] call OT_fnc_money;
    };

    private _civ = [_soldier,_pos,_group] call OT_fnc_createSoldier;

    if(_doinit) then {
        _group call OT_fnc_initMilitaryPatrol;
    };
    if(_charge) then {
        _loadout = getUnitLoadout _civ;
        _garrison = server getVariable [format["resgarrison%1",_code],[]];
        _garrison pushback [_cls,_loadout];
        server setVariable [format["resgarrison%1",_code],_garrison,true];
    };
}else{
    if(_create == "HMG" || _create == "GMG") then {
        private _buildings = nearestObjects [_pos, OT_garrisonBuildings, 250];
        private _done = false;
        private _dir = 0;
        private _p = [];
    	{
    		private _res = (_x call {
                params ["_building"];
                private _type = typeof _building;
    			if((damage _building) > 0.95) exitWith { []; };
    			if(
                    (_type == "Land_Cargo_HQ_V1_F")
                    || (_type == "Land_Cargo_HQ_V2_F")
                    || (_type == "Land_Cargo_HQ_V3_F")
                    || (_type == "Land_Cargo_HQ_V4_F")
                ) exitWith {
                    private _p = (_building buildingPos 8);
                    private _guns = ({alive _x} count (nearestObjects [_p, ["I_HMG_01_high_F","I_GMG_01_high_F"], 5]));
                    if(_guns == 0) then {
                        [getDir _building, _p];
                    } else {
                        [];
                    };
                };
                if(
                    (_type == "Land_Cargo_Patrol_V1_F")
                    || (_type == "Land_Cargo_Patrol_V2_F")
                    || (_type == "Land_Cargo_Patrol_V3_F")
                    || (_type == "Land_Cargo_Patrol_V4_F")
                ) exitWith {
                    private _ang = (getDir _building) - 190;
    				private _p = [_building buildingPos 1, 2.3, _ang] call BIS_Fnc_relPos;
    				private _dir = (getDir _building) - 180;

                    private _guns = {alive _x} count(nearestObjects [_p, ["I_HMG_01_high_F","I_GMG_01_high_F"], 5]);
                    if(_guns == 0) then {
                        [ getDir _building, _p ];
                    } else {
                        [];
                    };
                };

                private _p = _building buildingPos 11;
                private _guns = {alive _x} count(nearestObjects [_p, ["I_HMG_01_high_F","I_GMG_01_high_F"], 5]);
                if(_guns isEqualTo 0) exitWith {
                    [getDir _building, _p];
                };

                _p = _building buildingPos 13;
                _guns = {alive _x} count(nearestObjects [_p, ["I_HMG_01_high_F","I_GMG_01_high_F"], 5]);
                if(_guns isEqualTo 0) exitWith {
                    [getDir _building, _p];
                };

                []
            });
            if!(_res isEqualTo []) exitWith{
                _done = true;
                _dir = _res select 0;
                _p = _res select 1;
            };
        }foreach(_buildings);

        private _class_obj = "";
        private _class_price = "";
        if (_create == "HMG") then {
            _class_obj = "I_HMG_01_high_F";
            _class_price = "I_HMG_01_high_weapon_F";
        } else {
            _class_obj = "I_GMG_01_high_F";
            _class_price = "I_GMG_01_high_weapon_F";
        };

        if !(_done) then {
            _p = _pos findEmptyPosition [20,120,_class_obj];
            _dir = random 360;
            //put sandbags
			private _sp = [_p,1.5,_dir] call BIS_fnc_relPos;
			_veh =  OT_NATO_Sandbag_Curved createVehicle _sp;
			_veh setpos _sp;
			_veh setDir (_dir-180);
			_sp = [_p,-1.5,_dir] call BIS_fnc_relPos;
			_veh =  OT_NATO_Sandbag_Curved createVehicle _sp;
			_veh setpos _sp;
			_veh setDir (_dir);
        };

        private _cost = [OT_nation,_class_price,0] call OT_fnc_getPrice;
        _cost = _cost + ([OT_nation,"CIV",0] call OT_fnc_getPrice);
        _cost = _cost + 300;
        private _doit = true;

        if(_charge) then {
            private _money = player getVariable ["money",0];
            if(_money < _cost) exitWith {_doit = false;format ["You need $%1",_cost] call OT_fnc_notifyMinor};
            [-_cost] call OT_fnc_money;
            _garrison = server getVariable [format["resgarrison%1",_code],[]];
            _garrison pushback [_create,[]];
            server setVariable [format["resgarrison%1",_code],_garrison,true];
        };

        if(_doit) then {
            private _gun = _class_obj createVehicle _p;
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
};
