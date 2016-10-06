
//Hint "LAUNCH!";
//AI will use artillery/mortars when possible. This script makes artillery AI fire at a certain position
//First hash 6/14/2014
//SYSTEmchat "CALLED ARTY!";
_Unit = _this select 0;
_Enemy = _this select 1;

{
	if (isNull _x) then {ArtilleryArray = ArtilleryArray - [_x];};
} foreach ArtilleryArray;

//Hint format ["%1",ArtilleryArray];

_Indsupport = [];
_Bluforsupport = [];
_Opforsupport = [];
_Chosen = [];
_ArtilleryUnits = [];

if (side _Unit isEqualTo West) then 
{
	{
		if (side _x isEqualTo West) then {_Bluforsupport = _Bluforsupport + [(vehicle _x)];};
	} foreach ArtilleryArray;
	_Chosen = _Bluforsupport;
};

if (side _Unit isEqualTo East) then 
{
	{
		if (side _x isEqualTo East) then {_Opforsupport = _Opforsupport + [(vehicle _x)];};
	} foreach ArtilleryArray;
	_Chosen = _Opforsupport;
};

if (side _Unit isEqualTo Resistance) then 
{
	{
		if (side _x isEqualTo Resistance) then {_Indsupport = _Indsupport + [(vehicle _x)];};
	} foreach ArtilleryArray;
	_Chosen = _Indsupport;
};

//systemchat format ["_Chosen: %1",_Chosen];
if ((count _Chosen) <= 0) exitWith {};

//player sidechat format ["ARTY CALLED: %1",(vehicle _Unit)];
_ReturnedSupport = [_Chosen,(vehicle _Unit)] call VCOMAI_ClosestObject;
if (isNil "_ReturnedSupport") exitWith {};

if !(_ReturnedSupport in ArtilleryArray) exitWith {};
//player sidechat format ["ARTY _ReturnedSupport: %1",_ReturnedSupport];

_ArtilleryGroup = group _ReturnedSupport;
_ArtilleryGroupActual = [];
{
	if (group _x isEqualTo _ArtilleryGroup) then
	{
		_ArtilleryGroupActual pushback _x;
	};

} foreach _Chosen;


////player sidechat format ["ARTY _ArtilleryGroup: %1",_ArtilleryGroup];

_ArtilleryGroupUnits = units _ArtilleryGroup;
//player sidechat format ["ARTY _ArtilleryGroupUnits: %1",_ArtilleryGroupUnits];


//player sidechat format ["ARTY _ArtilleryGroupActual: %1",_ArtilleryGroupActual];
_AmmoArray = getArtilleryAmmo _ArtilleryGroupActual;
//player sidechat format ["ARTY _AmmoArray: %1",_AmmoArray];
if (isNil "_AmmoArray") exitWith {};

_RandomAmmoArray = _AmmoArray call BIS_fnc_selectRandom;
//player sidechat format ["ARTY _RandomAmmoArray: %1",_RandomAmmoArray];
_ContinueFiring = (getPos _Enemy) inRangeOfArtillery [_ArtilleryGroupActual,_RandomAmmoArray];
//player sidechat format ["_ContinueFiring _ContinueFiring: %1",_ContinueFiring];
if !(_ContinueFiring) exitWith {};
//Hint format ["_ArtilleryGroupActual : %1",_ArtilleryGroupActual];


{
	sleep (random 3);
	_x doArtilleryFire [(getPos _Enemy),_RandomAmmoArray,(floor(random 4))];
	//_x commandArtilleryFire [(getPos _Enemy),_RandomAmmoArray,(floor(random 4))];
	
} foreach _ArtilleryGroupActual;
