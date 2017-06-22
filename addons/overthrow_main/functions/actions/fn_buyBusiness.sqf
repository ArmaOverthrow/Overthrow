_b = (position player) call OT_fnc_nearestLocation;
if((_b select 1) == "Business") then {
    if (call OT_fnc_playerIsGeneral) then {
        _name = (_b select 0);
        _pos = (_b select 2) select 0;
        _price = _name call OT_fnc_getBusinessPrice;
        _err = true;
        _money = [] call OT_fnc_resistanceFunds;
        if(_money >= _price) then {
            [-_price] call OT_fnc_resistanceFunds;
            _owned = server getVariable ["GEURowned",[]];
            if(_owned find _name == -1) then {
                server setVariable ["GEURowned",_owned + [_name],true];
                server setVariable [format["%1employ",_name],2];
                _pos remoteExec ["OT_fnc_resetSpawn",2,false];
                format["%1 is now operational",_name] remoteExec ["OT_fnc_notifyMinor",0,false];
                _name setMarkerColor "ColorGUER";
            };
        }else{
            "The resistance cannot afford this" call OT_fnc_notifyMinor;
        };
    };
}else{
    if((getpos player) distance OT_factoryPos < 150) then {
        if (call OT_fnc_playerIsGeneral) then {
            _name = "Factory";

            _owned = server getVariable ["GEURowned",[]];
            if(_owned find _name == -1) then {
                _pos = OT_factoryPos;
                _price = _name call OT_fnc_getBusinessPrice;
                _err = true;
                _money = [] call OT_fnc_resistanceFunds;
                if(_money >= _price) then {
                    [-_price] call OT_fnc_resistanceFunds;
                    server setVariable ["GEURowned",_owned + [_name],true];
                    server setVariable [format["%1employ",_name],2];
                    _pos remoteExec ["OT_fnc_resetSpawn",2,false];
                    format["%1 is now operational",_name] remoteExec ["OT_fnc_notifyMinor",0,false];
                    _name setMarkerColor "ColorGUER";

                    private _veh = OT_factoryPos nearestObject OT_item_CargoContainer;
                    if(_veh isEqualTo objNull) then {
                        _p = OT_factoryPos findEmptyPosition [0,100,OT_item_CargoContainer];
                        _veh = OT_item_CargoContainer createVehicle _p;
                        [_veh,(server getVariable ["generals",[]]) select 0] call OT_fnc_setOwner;
                        clearWeaponCargoGlobal _veh;
                        clearMagazineCargoGlobal _veh;
                        clearBackpackCargoGlobal _veh;
                        clearItemCargoGlobal _veh;
                    };
                }else{
                    "The resistance cannot afford this" call OT_fnc_notifyMinor;
                };
            }else{
                //Manage
                [] spawn OT_fnc_factoryDialog;
                _isfactory = true;
            };
        };
    };
};
