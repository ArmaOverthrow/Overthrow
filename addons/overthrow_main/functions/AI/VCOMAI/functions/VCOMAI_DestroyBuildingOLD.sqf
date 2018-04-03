private ["_Unit", "_UnitGroup", "_Point", "_PreviousPosition", "_vehicle", "_Offset", "_ToWorld1", "_ToWorld2", "_PointHeight", "_PointHeightC", "_LookVar", "_nBuilding", "_Building", "_SatchelOfUse", "_Truth", "_PrimaryWeapon", "_PrimaryWeaponItems", "_SecondaryWeapon", "_SecondaryWeaponItems", "_HandgunWeapon", "_HandgunWeaponItems"];
//Script used to make AI attach explosives to buildings and bring them down if players garrison them.
_Unit = _this;

//_UnitGroup = group _Unit;
//[_Unit] joinSilent grpNull;
//_Point = _Unit getVariable "VCOM_CLOSESTENEMY";

//systemchat format ["D %1",_Unit];
_Point = _Unit call VCOMAI_ClosestEnemy;
if (_Point isEqualTo [] || {isNil "_Point"}) exitWith {};

_PreviousPosition = (getPosATL _Unit);
if (isNil "_Point") exitWith {};
//Hint format ["_Point %1",_Point];
sleep 2;
if ((_Unit distance _Point) < 200) then 
{

/*
while {(count (waypoints _UnitGroup)) > 0} do
{
 deleteWaypoint ((waypoints _UnitGroup) select 0);
  sleep 0.25;
};
*/

_vehicle = vehicle _Point;

if (_Point isEqualTo _vehicle) then {
/*
_Offset = [0,0,0];
_ToWorld1 = _Point modelToWorld _Offset;
_ToWorld2 = _Unit modelToWorld _Offset;
_PointHeight = _ToWorld1 select 2;
_PointHeightC = _ToWorld2 select 2;
_LookVar = (_PointHeight - _PointHeightC);
*/

//if (_LookVar >= 1) then {
//Hint "EXECUTING!";

_nBuilding = nearestBuilding _Point;
if ((_nBuilding distance _Point) > 20) exitWith {};

//_Unit disableAI "TARGET";
//_Unit disableAI "AUTOTARGET";
sleep 2;
doStop _Unit; _Unit doMove (getPos _nBuilding);
[_Unit,_nBuilding,_PreviousPosition] spawn {
_Unit = _this select 0;
_Building = _this select 1;
_PreviousPosition = _this select 2;
//_UnitGroup = _this select 3;
_SatchelOfUse = _Unit getVariable "VCOM_SATCHELBOMB";
//Hint format ["_SatchelOfUse %1",_SatchelOfUse];

if (VCOM_AIDEBUG isEqualTo 1) then
{
	[_Unit,"Blowing up a building! >:D!!!!",30,20000] remoteExec ["3DText",0];
};		


_Truth = true;
while {_Truth} do {
	if ((_Unit distance _Building) <= 10) then {_Truth = false;};
	sleep 0.25;
};

/*
//Hint "FIRE FIRE FIRE!";
_PrimaryWeapon = primaryWeapon _Unit;
_PrimaryWeaponItems = primaryWeaponItems _Unit;
_Unit removeWeapon _PrimaryWeapon;
_SecondaryWeapon = secondaryWeapon _Unit;
_SecondaryWeaponItems = secondaryWeaponItems _Unit;
_Unit removeWeapon _SecondaryWeapon;
_HandgunWeapon = handgunWeapon _Unit;
_HandgunWeaponItems = handgunItems _Unit;
_Unit removeWeapon _HandgunWeapon;
sleep 2;
_Unit fire ["PipeBombMuzzle","PipeBombMuzzle",_SatchelOfUse];
_Unit fire ["DemoChargeMuzzle","DemoChargeMuzzle",_SatchelOfUse];
*/
_Bomb = _Unit getVariable "VCOM_SATCHELBOMB";
_RemoveMag = _Unit getVariable "Vcom_SatchelObjectMagazine";
_Unit removeMagazine _RemoveMag;
_mine = createMine [_Bomb,getposATL _unit, [], 0];



_PlantPosition = (getpos _Unit);
/*
if (_PrimaryWeapon != "") then {
_Unit addWeapon _PrimaryWeapon;
{
_Unit addPrimaryWeaponItem _x;
} forEach _PrimaryWeaponItems;
};
if (_SecondaryWeapon != "") then {
_Unit addWeapon _SecondaryWeapon;
{
_Unit addSecondaryWeaponItem _x;
} forEach _SecondaryWeaponItems;
};
if (_HandgunWeapon != "") then {
_Unit addWeapon _HandgunWeapon;
{
_Unit addHandgunItem _x;
} forEach _HandgunWeaponItems;
};
*/
//_Unit enableAI "TARGET";
//_Unit enableAI "AUTOTARGET";
_NotSafe = true;
_Array1 = [];
_UnitSide = (side _Unit);
doStop _Unit;
_Unit doMove _PreviousPosition;
{
	if (alive _x && (side _x) isEqualTo _UnitSide) then {_Array1 pushback _x;};
} foreach allUnits;
while {_NotSafe} do
{
	_ClosestFriendly = [_Array1,_PlantPosition] call VCOMAI_ClosestObject;
	if (_ClosestFriendly distance _PlantPosition > 15) then {_NotSafe = false;};
	sleep 5;
};
//[_Unit] joinSilent _UnitGroup;
//Hint "TOUCH OFF!";
//_Unit action ["TOUCHOFF", _Unit];
_mine setdamage 1;
//_Unit enableAI "TARGET";
//_Unit enableAI "AUTOTARGET";
};




//};
};
};