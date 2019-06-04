
params ["_drone","_obname"];
private _targets = [];
while {sleep 10; alive _drone} do {
    if(((getpos _drone) select 2) < 2) exitWith {
        //Drone has landed?
        deleteVehicle _drone;
        spawner setVariable [format["drone%1",_obname],objNull,false];
    };
    {
        if((damage _x) < 1) then {
            [_x,_drone,_targets] call {
                params ["_x","_drone","_targets"];
                private _ty = typeof _x;
                if((_x isKindOf "StaticWeapon") && (side _x != west)) exitWith {
                    if(([_drone, "VIEW"] checkVisibility [position _drone,position _x]) > 0) then {
                        _targets pushback ["SW",position _x,100,_x];
                    };
                };
                if(_ty isEqualTo OT_flag_IND) exitWith {
                    _targets pushback ["FOB",position _x,50,_x];
                };
                if(_ty isEqualTo OT_warehouse) exitWith {
                    if(_x call OT_fnc_hasOwner) then {
                        _targets pushback ["WH",position _x,80,_x];
                    };
                };
                if((count crew _x) > 0 && ((_x isKindOf "Car") || (_x isKindOf "Air") || (_x isKindOf "Ship")) && !(_ty in (OT_allVehicles+OT_allBoats+OT_helis))) exitWith {
                    if !(side _x isEqualTo west) then {
                        if(([_drone, "VIEW"] checkVisibility [position _drone,position _x]) > 0) then {
                            //determine threat
                            private _targetType = "V";
                            private _threat = 0;

                            call {
                                if(_ty in OT_allVehicleThreats) exitWith {
                                    _threat = 150;
                                };
                                if !(_x getVariable ["OT_attachedClass",""] isEqualTo "") exitWith {
                                    _threat = 100;
                                };
                                if(_ty in OT_allPlaneThreats) exitWith {
                                    _targetType = "P";
                                    _threat = 500;
                                };
                                if(_ty in OT_allHeliThreats) exitWith {
                                    _targetType = "H";
                                    _threat = 300;
                                };
                            };

                            _targets pushback [_targetType,position _x,_threat,_x];
                        };
                    };
                };
                if(_ty isEqualTo OT_item_Storage) exitWith {
                    if(([_drone, "VIEW"] checkVisibility [position _drone,position _x]) > 0) then {
                        _targets pushback ["AMMO",position _x,25,_x];
                    };
                };
            };
        };
    }foreach((_drone nearObjects ["Static",500]) + (_drone nearObjects ["AllVehicles",500]));

    //look for concentrations of troops
    _nummil = {side _x isEqualTo west} count (_drone nearObjects ["CAManBase",200]);
    _numres = {side _x isEqualTo resistance} count (_drone nearObjects ["CAManBase",200]);
    if(_nummil isEqualTo 0 && _numres > 7) then {
        _targets pushback ["INF",position _drone,100,_drone];
    };

    _drone setVariable ["OT_seenTargets",_targets,false];
};
