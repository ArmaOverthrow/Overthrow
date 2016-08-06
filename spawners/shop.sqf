private ["_id","_pos","_building","_tracked","_civs","_vehs","_group","_all","_shopkeeper"];
if (!isServer) exitwith {};

_active = false;

_count = 0;
_id = _this select 0;
_pos = _this select 1;
_building = _this select 3;

_civs = []; //Stores all civs for tear down
_groups = [];

waitUntil{spawner getVariable _id};

while{true} do {
	//Do any updates here that should happen whether spawned or not
	
	//Main spawner
	if !(_active) then {
		if (spawner getVariable _id) then {
			_active = true;
			//Spawn stuff in
			_tracked = _building call spawnTemplate;
			sleep 1;
			_vehs = _tracked select 0;
			[_civs,_vehs] call BIS_fnc_arrayPushStack;
			
			_cashdesk = _pos nearestObject AIT_item_ShopRegister;
			_cashpos = [getpos _cashdesk,1,getDir _cashdesk] call BIS_fnc_relPos;
			
			_pos = [[[_cashpos,50]]] call BIS_fnc_randomPos;
			
			_group = createGroup civilian;	
			_groups pushback _group;
			_group setBehaviour "CARELESS";
			_type = (AIT_civTypes_locals + AIT_civTypes_expats) call BIS_Fnc_selectRandom;		
			_shopkeeper = _group createUnit [_type, _pos, [],0, "NONE"];
			
			_civs pushback _shopkeeper;
										
			_all = server getVariable "activeshops";
			_all pushback _shopkeeper;
			server setVariable ["activeshops",_all,true];
			
			_wp = _group addWaypoint [_cashpos,2];
			_wp setWaypointType "MOVE";
			_wp setWaypointSpeed "LIMITED";
			
			_shopkeeper remoteExec ["initShopLocal",0,true];
			[_shopkeeper] call initShopkeeper;	
			
		};
	}else{
		if (spawner getVariable _id) then {
			//Do updates here that should happen only while spawned
			//...
		}else{			
			_active = false;
			//Tear it all down
			{
				if !(_x call hasOwner) then {
					deleteVehicle _x;
				};				
			}foreach(_civs);
			{
				deleteGroup _x;
			}foreach(_groups);
			_groups = [];
			_civs = [];
		};
	};
	sleep 0.5;
};