private ["_id","_pos","_building","_tracked","_vehs","_group","_all","_shopkeeper","_groups"];
if (!isServer) exitwith {};

_active = false;
_spawned = false;

_count = 0;
_id = _this select 0;
_pos = _this select 1;
_building = _this select 3;

_hour = date select 3;

_groups = [];
_vehs = [];

waitUntil{spawner getVariable _id};
[_building] spawn run_shop;
sleep 4;
while{true} do {
	//Do any updates here that should happen whether spawned or not
	
	//Main spawner
	if !(_active) then {
		//Shop hours are 9am to 9pm
		if (spawner getVariable _id) then {
			_active = true;
			//Spawn shop furniture in
			_tracked = _building call spawnTemplate;
			sleep 1;
			_vehs = _tracked select 0;
			
			_cashdesk = _pos nearestObject AIT_item_ShopRegister;
			_cashpos = [getpos _cashdesk,1,getDir _cashdesk] call BIS_fnc_relPos;
			
			if(_hour > 8 and _hour < 22) then {
				//Shop is open, spawn shopkeeper
				
				_pos = [[[_cashpos,50]]] call BIS_fnc_randomPos;
				
				_group = createGroup civilian;	
				_groups pushback _group;
				_group setBehaviour "CARELESS";	
				_shopkeeper = _group createUnit [AIT_civType_shopkeeper, _pos, [],0, "NONE"];
				_shopkeeper setVariable ["shop",_building,true];
				
				_wp = _group addWaypoint [_cashpos,2];
				_wp setWaypointType "MOVE";
				_wp setWaypointSpeed "LIMITED";
				
				_shopkeeper remoteExec ["initShopLocal",0,true];
				[_shopkeeper] call initShopkeeper;	
				
				if((_hour > 18 and _hour < 22) or (_hour < 9 and _hour > 5)) then {
					//Put a light on
					_pos = getpos _building;
					_light = "#lightpoint" createVehicle [_cashpos select 0,_cashpos select 1,(_cashpos select 2)+2.2];
					_light setLightBrightness 0.11;
					_light setLightAmbient[.9, .9, .6];
					_light setLightColor[.5, .5, .4];
					_vehs pushback _light;				
				};
				_allactive = spawner getVariable ["activeshops",[]];
				_allactive pushback _shopkeeper;
				spawner setVariable ["activeshops",_allactive,true];
			};
		};
	}else{
		if (spawner getVariable _id) then {
			//Do updates here that should happen only while spawned
			//...
			
		}else{			
			_active = false;
			//Tear it all down
			{
				deleteVehicle _x;		
			}foreach(_vehs);
			_allactive = spawner getVariable ["activeshops",[]];
			{
				{
					sleep 0.1;
					if(_x in _allactive) then {
						_allactive deleteAt (_allactive find _x);
					};
					if !(_x call hasOwner) then {
						deleteVehicle _x;
					};	
				}foreach(units _x);
				deleteGroup _x;
			}foreach(_groups);
			spawner setVariable ["activeshops",_allactive,true];
			_groups = [];
			_vehs = [];
		};
	};
	sleep 2;
};