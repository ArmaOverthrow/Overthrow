OT_salvageVehicle = _this;
private _doSalvage = {
    private _wreck = OT_salvageVehicle;
    private _steel = 3;
    private _plastic = 0;
    private _cost = cost getVariable [typeof _wreck,[100,0,0,0]];
    if((_cost select 2) > 10) then {
        _steel = 4;
    };
    if((_cost select 2) > 20) then {
        _steel = 5;
    };
    if((_cost select 2) > 40) then {
        _steel = 6;
    };
    if((_cost select 2) > 80) then {
        _steel = 8;
    };
    if((_cost select 3) > 0 and (random 100) > 90) then {
        _plastic = 1;
    };

    private _veh = _this;


    closeDialog 0;
	private _toname = (typeof _veh) call OT_fnc_vehicleGetName;
	format["Salvaging wreck into %1",_toname] call OT_fnc_notifyMinor;
    player playMove "AinvPknlMstpSnonWnonDnon_medic_1";
	[14,false] call OT_fnc_progressBar;
    if(damage _veh > 0.1) then {
    	sleep 7;
        player playMove "AinvPknlMstpSnonWnonDnon_medic_1";
        sleep 7;
    }else{
        sleep 2;
        _veh setDamage [0.8,false];
        sleep 2;
        _veh setDamage [0.6,false];
        sleep 2;
        _veh setDamage [0.4,false];
        sleep 1;
        player playMove "AinvPknlMstpSnonWnonDnon_medic_1";
        sleep 1;
        _veh setDamage [0.2,false];
        sleep 2;
        _veh setDamage [0.0,false];
        sleep 4;
    };
    _done = 0;
    for "_x" from 0 to (_steel - 1) do {
        if(!(_veh isKindOf "Truck_F" or _veh isKindOf "ReammoBox_F") and !(_veh canAdd "OT_Steel")) exitWith {
            "Vehicle is full, use a truck or ammobox for more storage" call OT_fnc_notifyMinor;
        };
        _done = _done + 1;
        _veh addItemCargoGlobal ["OT_Steel", 1];
    };
    if(_plastic > 0 and ((_veh isKindOf "Truck_F" or _veh isKindOf "ReammoBox_F") or (_veh canAdd "OT_Plastic"))) then {
        _veh addItemCargoGlobal ["OT_Plastic", _plastic];
        format["Salvaged: %1 x Steel, %1 x Plastic",_done,_plastic] call OT_fnc_notifyMinor;
    }else{
        format["Salvaged: %1 x Steel",_done] call OT_fnc_notifyMinor;
    };
    deleteVehicle _wreck;
};

private _objects = player nearEntities [["Car","ReammoBox_F","Air","Ship"],20];
_filtered = [];
{
    if !(_x isEqualTo OT_salvageVehicle) then {_filtered pushback _x};
}foreach(_objects);

if(count _filtered == 1) then {
	(_filtered select 0) call _doSalvage;
}else{
    if(count _filtered > 1) then {
    	private _options = [];
    	{
            _options pushback [format["%1 (%2m)",(typeof _x) call OT_fnc_vehicleGetName,round (_x distance player)],_doSalvage,_x];
    	}foreach(_filtered);
    	"Salvage to which container?" call OT_fnc_notifyBig;
    	_options spawn OT_fnc_playerDecision;
    }else{
        "No nearby containers or vehicles to put salvaged items" call OT_fnc_notifyMinor;
    };
};
