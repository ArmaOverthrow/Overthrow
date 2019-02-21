//This function is called when a squad leader asks for artillery support
//First hash 6/14/2014 Updated on 8/15/17 @ 2023
params ["_Unit","_Enemy"];

{
	if (isNull _x) then {ArtilleryArray = ArtilleryArray - [_x];};
} foreach ArtilleryArray;

private _Indsupport = [];
private _Bluforsupport = [];
private _Opforsupport = [];
private _Chosen = [];
private _ArtilleryUnits = [];

if (side _Unit isEqualTo West) then 
{
	{
		if (side _x isEqualTo West) then {_Bluforsupport = _Bluforsupport + [(vehicle _x)];};
	} foreach ArtilleryArray;
	_Chosen = _Bluforsupport;
	Vcom_WestArtCooldown = false; [] spawn {sleep VCOM_ArtilleryCooldown;Vcom_WestArtCooldown = true;};
};

if (side _Unit isEqualTo East) then 
{
	{
		if (side _x isEqualTo East) then {_Opforsupport = _Opforsupport + [(vehicle _x)];};
	} foreach ArtilleryArray;
	_Chosen = _Opforsupport;
	Vcom_EastArtCooldown = false; [] spawn {sleep VCOM_ArtilleryCooldown;Vcom_EastArtCooldown = true;};
};

if (side _Unit isEqualTo Resistance) then 
{
	{
		if (side _x isEqualTo Resistance) then {_Indsupport = _Indsupport + [(vehicle _x)];};
	} foreach ArtilleryArray;
	_Chosen = _Indsupport;
	Vcom_ResistanceArtCooldown = false; [] spawn {sleep VCOM_ArtilleryCooldown;Vcom_ResistanceArtCooldown = true;};
};

if ((count _Chosen) <= 0) exitWith {};

//player sidechat format ["ARTY CALLED: %1",(vehicle _Unit)];
private _ReturnedSupport = [_Chosen,(vehicle _Unit)] call VCOMAI_ClosestObject;
if (isNil "_ReturnedSupport") exitWith {};

if !(_ReturnedSupport in ArtilleryArray) exitWith {};

_ArtilleryGroup = group _ReturnedSupport;
_ArtilleryGroupActual = [];
{
	if (group _x isEqualTo _ArtilleryGroup) then
	{
		_ArtilleryGroupActual pushback _x;
	};

} foreach _Chosen;

private _ArtilleryGroupUnits = units _ArtilleryGroup;

private _AmmoArray = getArtilleryAmmo _ArtilleryGroupActual;
if (isNil "_AmmoArray") exitWith {};

private _RandomAmmoArray = _AmmoArray call BIS_fnc_selectRandom;
if (isNil "_RandomAmmoArray") exitWith {};

private _ContinueFiring = (getPos _Enemy) inRangeOfArtillery [_ArtilleryGroupActual,_RandomAmmoArray];

if !(_ContinueFiring) exitWith {};

private _EnemyGroup = group _Enemy;
private _RoundsToFire = round (count (units _EnemyGroup)/4);

if (_RoundsToFire < 2) then {_RoundsToFire = 2};

{
	private _dist = random (15 + (random VCOM_ArtillerySpread));
	private _dir = random 360;
	private _pos = getpos _Enemy;
	private _positions = [(_pos select 0) + (sin _dir) * _dist, (_pos select 1) + (cos _dir) * _dist, 0];

	sleep (random 3);
	
	_x doArtilleryFire [_positions,_RandomAmmoArray,_RoundsToFire];
	//_x commandArtilleryFire [(getPos _Enemy),_RandomAmmoArray,(floor(random 4))];
	if (VCOM_AIDEBUG isEqualTo 1) then
	{
		[_x,"I am firing my ARTY >:D!!!",120,20000] remoteExec ["3DText",0];
	};	
	
} foreach _ArtilleryGroupActual;