private ["_id","_pos","_building","_tracked","_civs","_vehs","_group","_all","_shopkeeper"];
if (!isServer) exitwith {};

_active = false;

_count = 0;
_id = _this select 0;
_pos = _this select 1;
_building = _this select 3;

_vehs = []; //Stores all civs for tear down

waitUntil{spawner getVariable _id};

while{true} do {
	//Do any updates here that should happen whether spawned or not
	
	//Main spawner
	if !(_active) then {
		if (spawner getVariable _id) then {
			_active = true;
			//Spawn stuff in
			
			
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
			}foreach(_vehs);
			_vehs = [];
		};
	};
	sleep 1;
};