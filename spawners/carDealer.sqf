private ["_id","_pos","_building","_tracked","_civs","_vehs","_group","_groups","_all","_shopkeeper"];
if (!isServer) exitwith {};


_count = 0;
_town = _this;
_posTown = server getVariable _town;

_shopkeeper = objNULL;

_groups = [];

{
	_building = _x;
	_pos = getpos _building;
	_tracked = _building call spawnTemplate;
	sleep 1;
	_vehs = _tracked select 0;
	[_groups,_vehs] call BIS_fnc_arrayPushStack;
	
	_cashdesk = _pos nearestObject AIT_item_ShopRegister;
	_cashpos = [getpos _cashdesk,1,getDir _cashdesk] call BIS_fnc_relPos;
	_pos = [[[_cashpos,50]]] call BIS_fnc_randomPos;
	
	_group = createGroup civilian;	
	_group setBehaviour "CARELESS";
	_shopkeeper = _group createUnit [AIT_civType_carDealer, _pos, [],0, "NONE"];					


	_wp = _group addWaypoint [_cashpos,2];
	_wp setWaypointType "MOVE";
	_wp setWaypointSpeed "LIMITED";				

	_shopkeeper remoteExec ["initCarShopLocal",0,true];
	[_shopkeeper] call initCarDealer;
	
	_allactive = spawner getVariable ["activecarshops",[]];
	_allactive pushback _shopkeeper;
	spawner setVariable ["activecarshops",_allactive,true];
	
}foreach(nearestObjects [_posTown,AIT_carShops, 400]);
		
		
_groups