if (VCOM_MineLayChance < (random 100)) exitWith {};

private _Unit = _this select 0;
private _MineArray = _this select 1;

private _MineType = _MineArray select 0;
private _MagazineName = _MineArray select 1;

if (_MineArray isEqualTo []) exitWith {};

_Unit removeMagazine _MagazineName;

//systemchat format ["I %1",_Unit];
private _NearestEnemy = _Unit call VCOMAI_ClosestEnemy;
if (_NearestEnemy isEqualTo [] || {isNil "_NearestEnemy"}) exitWith {};

private _mine = "";

if (_NearestEnemy distance _Unit < 200) then
{
	//_mine = createMine [_MineType,getposATL _Unit, [], 2];
	_mine = _MineType createVehicle (getposATL _Unit);
	[_Unit,"AinvPknlMstpSnonWnonDnon_Putdown_AmovPknlMstpSnonWnonDnon"] remoteExec ["playMoveEverywhere",0];
}
else
{
	_NearRoads = _Unit nearRoads 50;
	if (count _NearRoads > 0) then 
	{
		private _ClosestRoad = [_NearRoads,_Unit] call VCOMAI_ClosestObject;
		_Unit doMove (getpos _ClosestRoad);
		waitUntil {!(alive _Unit) || _Unit distance _ClosestRoad < 6};
		_mine = _MineType createVehicle (getposATL _ClosestRoad);
		//_mine = createMine [_MineType,getposATL _ClosestRoad, [], 3];
		[_Unit,"AinvPknlMstpSnonWnonDnon_Putdown_AmovPknlMstpSnonWnonDnon"] remoteExec ["playMoveEverywhere",0];
	}
	else
	{
		//_mine = createMine [_MineType,getposATL _Unit, [], 3];
		_mine = _MineType createVehicle (getposATL _Unit);
		[_Unit,"AinvPknlMstpSnonWnonDnon_Putdown_AmovPknlMstpSnonWnonDnon"] remoteExec ["playMoveEverywhere",0];
	};
};

_UnitSide = (side _Unit);


if (_mine isEqualTo "") exitWith {};

[_mine,_UnitSide] spawn 
{
	params ["_Mine","_UnitSide"];
	
	_NotSafe = true;
	
	while {alive _mine && _NotSafe} do 
	{
		
		private _Array1 = (allUnits select {!(side _x isEqualTo _UnitSide)});
		private _ClosestEnemy = [0,0,0];
		_ClosestEnemy = [_Array1,_Mine] call VCOMAI_ClosestObject;
		if (_ClosestEnemy distance _Mine < 2.5) then {_NotSafe = false;};
		sleep 0.15;	
	};
	_Mine setdamage 1;
};