/* 
	Filename: Simple ParaDrop Script v0.96 eject.sqf
	Author: Beerkan
	
	Description:
     A Simple Paradrop Script
   
	Parameter(s):
	0: VEHICLE  - vehicle that will be doing the paradrop (object)
	1: ALTITUDE - (optional) the altitude where the group will open their parachute (number)
   
   Example:
   0 = [vehicle, altitude] execVM "eject.sqf"
*/  

if (!isServer) exitWith {};
private ["_paras","_vehicle","_chuteHeight","_dir"];
_vehicle = _this select 0; 
_chuteheight = if ( count _this > 1 ) then { _this select 1 } else { 100 };
_vehicle allowDamage false;
_paras = assignedcargo _vehicle;
_dir = direction _vehicle;    

paraLandSafe = 
{
	private ["_unit"];
	_unit = _this select 0;
	_chuteheight = _this select 1;
	(vehicle _unit) allowDamage false;
	if (isPlayer _unit) then {[_unit,_chuteheight] spawn OpenPlayerchute};
	waitUntil { isTouchingGround _unit || (position _unit select 2) < 1 };
	_unit action ["eject", vehicle _unit];
	sleep 1;
	_inv = name _unit;
	[_unit, [missionNamespace, format["%1%2", "Inventory",_inv]]] call BIS_fnc_loadInventory;// Reload Loadout.
	_unit allowdamage true;// Now you can take damage.
};

OpenPlayerChute =
{
	private ["_paraPlayer"];
	_paraPlayer = _this select 0;
	_chuteheight = _this select 1;
	waitUntil {(position _paraPlayer select 2) <= _chuteheight};
	_paraPlayer action ["openParachute", _paraPlayer];
};

{
	_inv = name _x;// Get Unique name for Unit's loadout.
	[_x, [missionNamespace, format["%1%2", "Inventory",_inv]]] call BIS_fnc_saveInventory;// Save Loadout
	removeBackpack _x;
	_x disableCollisionWith _vehicle;// Sometimes units take damage when being ejected.
	_x allowdamage false;// Trying to prevent damage.
	_x addBackPack "B_parachute";
	unassignvehicle _x;
	moveout _x;
	_x setDir (_dir + 90);// Exit the chopper at right angles.
	sleep 0.3;
} forEach _paras;

_vehicle allowDamage true;

{ 
	[_x,_chuteheight] spawn paraLandSafe;
} forEach _paras;