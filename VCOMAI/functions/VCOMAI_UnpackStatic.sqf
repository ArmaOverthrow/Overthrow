private ["_cansee","_position", "_Unit", "_weapon", "_leader", "_gunner", "_assistant", "_UnitGroups", "_CurrentBackPack", "_class", "_parents", "_rnd", "_dist", "_dir", "_positions", "_myNearestEnemy", "_StaticClassName", "_IsMortar", "_WeaponClassname", "_StaticCreated", "_dirTo"];_group = 		_this select 0;
_position =		_this select 1;
_Unit = _this select 2;
_VCOM_HASDEPLOYED = _this select 3;
_weapon = 		objNull;
_leader = 		leader _group;
_units = 		(units _group) - [leader _group];
//_gunner = 		_units select 0;
//_assistant = 	_units select 1;

_group = group _Unit;
_UnitGroups = units _group;
_gunner = 0;
_cansee = 1;

_CurrentBackPack = backpack _Unit;

if (!(isNil "_CurrentBackPack")) then 
{
  _class = [_CurrentBackPack] call VCOMAI_Classvehicle;
  if (!(isNil "_class")) then 
  {
    _parents = [_class,true] call BIS_fnc_returnParents;
    if (!(isNil "_parents")) then 
    {
      if (("StaticWeapon" in _parents) || {("Weapon_Bag_Base" in _parents)}) then {_Unit setVariable ["USEDSTATICWEAP",_CurrentBackPack,false];_gunner = _Unit;};
    };
  };
};


if (_gunner isEqualTo 0) exitWith {};

_myNearestEnemy = _Unit findNearestEnemy (getPosASL _Unit);
//_myNearestEnemy = player;


if (isNull _myNearestEnemy) then 
{
		_myNearestEnemy = _Unit call VCOMAI_ClosestEnemy;
};


if (_myNearestEnemy isEqualTo []) exitWith {};

sleep 0.25;
//_assistant action ["PutBag",_assistant];

	_StaticClassName = _Unit getVariable "VCOM_StaticClassName";
	
	_IsMortar = ["Mortar",_StaticClassName,false] call BIS_fnc_inString;

	
	if (["grn",_StaticClassName,false] call BIS_fnc_inString) then
	{
		_WeaponClassname = [_StaticClassName,0,-13] call BIS_fnc_trimString;
	}
	else
	{
		_WeaponClassname = [_StaticClassName,0,-9] call BIS_fnc_trimString;	
	};
	
	
	if !(_IsMortar) then 
	{
		_WeaponClassname = _WeaponClassname + "_high_F";
		_cansee = [_Unit, "VIEW"] checkVisibility [eyePos _Unit, eyePos _myNearestEnemy];		
	} 
	else 
	{
		_WeaponClassname = _WeaponClassname + "_F";
	};

	if !(_cansee > 0) exitwith {};	
	_StaticCreated = _WeaponClassname createvehicle [0,0,0];
	_StaticCreated setposATL (getposATL _Unit);
	
  _weapon = nearestObject [_position,"StaticWeapon"];
  _Unit setVariable ["supportWeaponSetup",_weapon,false];

  _Unit assignAsGunner _weapon;
	[_Unit] orderGetIn true;
	_Unit moveInGunner _weapon;
	removeBackpackGlobal _Unit;

_dirTo = [position _weapon,position _myNearestEnemy] call BIS_fnc_dirTo;
_weapon setDir _dirTo;
(Vehicle _Unit) setDir _dirTo;


[_Unit,_group] spawn {
_Unit = _this select 0;
_group = _this select 1;
sleep (180 + (random 180));
if (!(alive _Unit) || {_Unit isEqualTo (Vehicle _Unit)}) exitWith {};
[_group,_Unit] spawn VCOMAI_PackStatic;
};



