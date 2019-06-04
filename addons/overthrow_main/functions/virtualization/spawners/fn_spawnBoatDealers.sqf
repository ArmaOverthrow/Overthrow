private ["_town","_id","_pos","_building","_tracked","_civs","_vehs","_group","_groups","_all","_shopkeeper"];
if (!isServer) exitwith {};

sleep random 0.5;

params ["_town","_spawnid"];
private _activeshops = server getVariable [format["activepiersin%1",_town],[]];

_count = 0;

_posTown = server getVariable _town;

_shopkeeper = objNULL;


_group = createGroup civilian;
_group setBehaviour "CARELESS";
_groups = [_group];
{
	private _pos = _x;
	_building = nearestBuilding _pos;

	_dir = getDir _building;
	_shopkeeper = _group createUnit [OT_civType_carDealer, [_pos,[0,0,2]] call BIS_fnc_vectorAdd, [],0, "NONE"];
	_shopkeeper disableAI "MOVE";
	_shopkeeper disableAI "AUTOCOMBAT";
	_shopkeeper setVariable ["NOAI",true,false];
	_shopkeeper setVariable ["shop",true,true];

	_shopkeeper setDir (_dir-180);

	[_shopkeeper] call OT_fnc_initHarbor;
	_shopkeeper setVariable ["harbor",true,true];
	sleep 0.5;
}foreach(_activeshops);

spawner setvariable [_spawnid,(spawner getvariable [_spawnid,[]]) + _groups,false];
