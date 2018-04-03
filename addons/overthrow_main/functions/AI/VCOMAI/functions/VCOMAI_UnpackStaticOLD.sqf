//This function provides the AI the ability to deploy static weapons, and then tells them when to pack the static weapon up.
//Last edited on: 8/7/2017 @ 1925

//_SetDownStatic = [_Unit,_VCOM_HASDEPLOYED] spawn VCOMAI_UnpackStatic;

private _Unit = _this select 0;
private _VCOM_HASDEPLOYED = _this select 1;

private _group = group _Unit;

_gunner = false;
_cansee = 1;
_Vcom_Indoor = false;

_CurrentBackPack = backpack _Unit;

if (!(isNil "_CurrentBackPack")) then 
{
  _class = [_CurrentBackPack] call VCOMAI_Classvehicle;
  if (!(isNil "_class")) then 
  {
    _parents = [_class,true] call BIS_fnc_returnParents;
    if (!(isNil "_parents")) then 
    {
      if (("StaticWeapon" in _parents) || {("Weapon_Bag_Base" in _parents)}) then {_Unit setVariable ["VCOM_USEDSTATICWEAP",_CurrentBackPack,false];_gunner = true;};
    };
  };
};


if !(_gunner) exitWith {};

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
		_Position = getposATL _Unit;
		_Array = lineIntersectsObjs [_Position,[_Position select 0,_Position select 1,(_Position select 2) + 10], objnull, objnull, true, 4];
		{
			if (_x isKindof "Building") then {_Vcom_Indoor = true;};
		} foreach _Array;

		_WeaponClassname = _WeaponClassname + "_F";
	};

	
	if (!(_cansee > 0) || (_Vcom_Indoor)) exitwith {};	
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



