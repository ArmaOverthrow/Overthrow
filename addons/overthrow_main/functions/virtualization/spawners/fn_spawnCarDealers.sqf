private ["_town","_id","_pos","_building","_tracked","_civs","_vehs","_group","_groups","_all","_shopkeeper"];
if (!isServer) exitwith {};


_count = 0;
params ["_town","_spawnid"];
_posTown = server getVariable _town;
sleep random 0.2;
_shopkeeper = objNULL;
private _activeshops = server getVariable [format["activecarshopsin%1",_town],[]];


private _groups = [];
{
	private _pos = _x;
	_building = nearestBuilding _pos;

	_group = createGroup civilian;
	_group setBehaviour "CARELESS";
	_groups pushback _group;

	_tracked = _building call OT_fnc_spawnTemplate;
	_vehs = _tracked select 0;
	[_groups,_vehs] call BIS_fnc_arrayPushStack;

	_cashdesk = _pos nearestObject OT_item_ShopRegister;
	_dir = getDir _cashdesk;
	_cashpos = [getpos _cashdesk,1,_dir] call BIS_fnc_relPos;
	private _start = _building buildingPos 0;
	_shopkeeper = _group createUnit [OT_civType_carDealer, _start, [],0, "NONE"];
	_shopkeeper allowDamage false;
	_shopkeeper disableAI "MOVE";
	_shopkeeper disableAI "AUTOCOMBAT";
	_shopkeeper setVariable ["NOAI",true,false];

	_shopkeeper setDir (_dir-180);

	[_shopkeeper] call OT_fnc_initCarDealer;
	_shopkeeper setVariable ["carshop",true,true];
	_shopkeeper setVariable ["shopcheck",true,true];
	sleep 0.5;
}foreach(_activeshops);


spawner setvariable [_spawnid,(spawner getvariable [_spawnid,[]]) + _groups,false];
