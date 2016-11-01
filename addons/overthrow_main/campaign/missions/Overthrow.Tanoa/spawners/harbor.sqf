private ["_town","_id","_pos","_building","_tracked","_civs","_vehs","_group","_groups","_all","_shopkeeper"];
if (!isServer) exitwith {};


_count = 0;
_town = _this;
_posTown = server getVariable _town;

_shopkeeper = objNULL;


_group = createGroup civilian;	
_group setBehaviour "CARELESS";
_groups = [_group];
{	
	_building = _x;		
	_pos = getpos _building;
	_t = _pos call nearestTown;
	if(_t == _town) then {		
		_dir = getDir _building;		
		_shopkeeper = _group createUnit [OT_civType_carDealer, [_pos,[0,0,2]] call BIS_fnc_vectorAdd, [],0, "NONE"];
		_shopkeeper disableAI "MOVE";
		_shopkeeper disableAI "AUTOCOMBAT";
		_shopkeeper setVariable ["NOAI",true,false];

		_shopkeeper setDir (_dir-180);			

		_shopkeeper remoteExec ["initHarborLocal",0,_shopkeeper];
		[_shopkeeper] call initHarbor;
		_shopkeeper setVariable ["harbor",true,true];
	};
}foreach(nearestObjects [_posTown,OT_piers, 700]);
		
{
	_x addCuratorEditableObjects [units _group,true];
} forEach allCurators;
	
_groups