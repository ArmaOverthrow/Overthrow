private ["_pos","_shop"];

_pos = _this select 0;
_shop = (_pos nearObjects ["Land_Cargo_House_V4_F",10]) select 0;

if(OT_hasACE) then {
	[_shop] call ace_repair_fnc_moduleAssignRepairFacility;	
};
