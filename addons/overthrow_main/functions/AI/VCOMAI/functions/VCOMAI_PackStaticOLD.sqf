private["_group","_weapon","_position","_leader","_units","_gunner","_assistant","_type","_wait","_weaponBP","_tripodBP"];

//_group = 	[_this, 0, grpNull] call bis_fnc_param;
_Unit = _this select 1;
_group = group _Unit;
sleep 2;

_UnitGroups = units _group;
_weapon = 	_Unit getVariable "supportWeaponSetup";
_position = (getPos _Unit);
_leader = 	leader _group;
_type = 	typeOf _weapon;
_Unit leaveVehicle _weapon;

_UnitStatic = _Unit getVariable "USEDSTATICWEAP";

sleep 0.25;
_Unit action ["DisAssemble",_weapon];
deleteVehicle _weapon;
sleep 1;
//_assistant action ["takeBag",_tripodBP];
//_Unit action ["takeBag",_weaponBP];
//_assistant action ["takeBag",_tripodBP];
_Unit addBackpack _UnitStatic;

//_Unit setVariable ["SETUPAMOUNT",false,false];