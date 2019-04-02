params ["_obj","_sel","_dmg"];

if(damage _obj isEqualTo 1) then {
    _damaged = owners getVariable ["damagedBuildings",[]];
    _id = [_obj] call OT_fnc_getBuildID;
    if !(_id in _damaged) then {
        _damaged pushback _id;
        owners setVariable ["damagedBuildings",_damaged,true];
        _ty = typeof _obj;

        if(_ty isEqualTo OT_warehouseBuilding) then {
            format ["Warehouse damaged %1",(getpos _obj) call BIS_fnc_locationDescription] remoteExec ["OT_fnc_notifyMinor",0,false];
        };
        if(_ty isEqualTo OT_policeStation) then {
            _town = (getpos _obj) call OT_fnc_nearestTown;
            _abandoned = server getVariable ["NATOabandoned",[]];
            server setVariable [format["police%1",_town],0,true];
            if(_town in _abandoned) then {
                [_town,-20] call OT_fnc_stability;
                format ["Police station destroyed in %1",_town] remoteExec ["OT_fnc_notifyMinor",0,false];
            };
        };
    };
};
