closeDialog 0;
private _idx = lbCurSel 1500;
private _cls = lbData [1500,_idx];

private _soldier = _cls call OT_fnc_getSoldier;

_soldier params ["","","_loadout","_clothes"];

private _items = [];
//Add warehouse items to arsenal
{
    if(_x select [0,5] isEqualTo "item_") then {
        private _d = warehouse getVariable [_x,[_x select [5],0,[0]]];
        if(_d isEqualType []) then {
            _items pushback _d#0;
        };
    };
}foreach(allVariables warehouse);

if((count _items) isEqualTo 0) exitWith {hint "Cannot edit loadout, no items in warehouse"};

//spawn a virtual dude
private _start = (getpos player) findEmptyPosition [5,40,_cls];
private _civ = (group player) createUnit [_cls, _start, [],0, "NONE"];
_civ disableAI "MOVE";
_civ disableAI "AUTOTARGET";
_civ disableAI "TARGET";
_civ disableAI "WEAPONAIM";
_civ disableAI "FSM";

[_civ, (OT_faces_local call BIS_fnc_selectRandom)] remoteExecCall ["setFace", 0, _civ];

if(_clothes != "") then {
	_civ forceAddUniform _clothes;
}else{
	_clothes = (OT_clothes_guerilla call BIS_fnc_selectRandom);
	_civ forceAddUniform _clothes;
};

_civ setskill ["courage",1];

removeAllWeapons _civ;
removeAllAssignedItems _civ;
removeGoggles _civ;
removeBackpack _civ;
removeHeadgear _civ;
removeVest _civ;

_civ setUnitLoadout [_loadout, false];
_civ setFatigue 0;

if ((_civ getVariable ["cba_projectile_firedEhId", -1]) != -1) then {
    _civ call CBA_fnc_removeUnitTrackProjectiles;
};

[_civ, true, false] call ace_arsenal_fnc_removeVirtualItems;
[_civ,_items,false] call ace_arsenal_fnc_addVirtualItems;

["ace_arsenal_displayOpened", {
    _thisArgs params ["_unit"];
    [{
        switch (true) do {
            case (primaryWeapon _this != ""): {
                _this switchMove "amovpercmstpslowwrfldnon";
            };
            case (handgunWeapon _this != ""): {
                _this switchMove "amovpercmstpslowwpstdnon";
            };
            default {
                _this switchMove "amovpercmstpsnonwnondnon";
            };
        };
    }, _unit] call CBA_fnc_execNextFrame;

    [_thisType, _thisId] call CBA_fnc_removeEventHandler;
},[_civ]] call CBA_fnc_addEventHandlerArgs;

["ace_arsenal_displayClosed", {
    _thisArgs params ["_unit","_cls"];
    private _loadout = getUnitLoadout _unit;

    {
        _x params ["_c"];
        if(_c isEqualTo _cls) exitWith {_x set [1,_loadout]};
    }foreach(OT_Recruitables);
    publicVariable "OT_Recruitables";

    [_cls call OT_fnc_vehicleGetName, _loadout] remoteExec ["ace_arsenal_fnc_addDefaultLoadout",0,false];

    playSound "3DEN_notificationDefault";
    "Saved loadout" call OT_fnc_notifyMinor;

    deleteVehicle _unit;

    [_thisType, _thisId] call CBA_fnc_removeEventHandler;
},[_civ,_cls]] call CBA_fnc_addEventHandlerArgs;

[_civ,_civ] call ace_arsenal_fnc_openBox;
