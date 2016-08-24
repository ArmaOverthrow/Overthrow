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
		_tracked = _building call spawnTemplate;
		sleep 0.2;
		_vehs = _tracked select 0;
		[_groups,_vehs] call BIS_fnc_arrayPushStack;
		
		_cashdesk = _pos nearestObject AIT_item_ShopRegister;
		_dir = getDir _cashdesk;
		_cashpos = [getpos _cashdesk,1,_dir] call BIS_fnc_relPos;		
		
		_shopkeeper = _group createUnit [AIT_civType_carDealer, _cashpos, [],0, "NONE"];
		_shopkeeper disableAI "MOVE";
		_shopkeeper disableAI "AUTOCOMBAT";
		_shopkeeper setVariable ["NOAI",true,false];

		_shopkeeper setDir (_dir-180);			

		_shopkeeper remoteExec ["initCarShopLocal",0,true];
		[_shopkeeper] call initCarDealer;
		_shopkeeper setVariable ["carshop",true,true];
	};
}foreach(nearestObjects [_posTown,AIT_carShops, 700]);
		
		
_groups