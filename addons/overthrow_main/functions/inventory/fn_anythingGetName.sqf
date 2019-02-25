private _cls = _this;

//@todo: support literally anything, ie a player, civ, location
if(_cls isKindOf "AllVehicles"or _cls isKindOf "Bag_Base") exitWith {
    _cls call OT_fnc_vehicleGetName;
};
if(_cls isKindOf ["Default",configFile >> "CfgWeapons"]) exitWith {
    _cls call OT_fnc_weaponGetName;
};
if(_cls isKindOf ["Default",configFile >> "CfgMagazines"]) exitWith {
    _cls call OT_fnc_magazineGetName;
};
if(_cls isKindOf ["None",configFile >> "CfgGlasses"]) exitWith {
    _cls call OT_fnc_glassesGetName;
};
"Unknown"
