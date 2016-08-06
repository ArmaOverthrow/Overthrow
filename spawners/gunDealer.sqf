private ["_id","_pos","_building","_tracked","_civs","_vehs","_group","_all","_shopkeeper"];
if (!isServer) exitwith {};

_active = false;

_count = 0;
_id = _this select 0;
_posTown = _this select 1;
_town = _this select 3;

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
			_gundealerpos = server getVariable format["gundealer%1",_town];
			if(isNil "_gundealerpos") then {
				_building = (nearestObjects [_posTown, AIT_allHouses, 400]) call BIS_Fnc_selectRandom;
				_gundealerpos = _building buildingPos 0;
				server setVariable [format["gundealer%1",_town],_gundealerpos,true];
				_building setVariable ["owner",true,true];
			};
			_group = createGroup civilian;	
			_groups	pushback _group;
			
			_group setBehaviour "CARELESS";
			_type = AIT_civTypes_gunDealers call BIS_Fnc_selectRandom;
			_pos = [[[_gundealerpos,50]]] call BIS_fnc_randomPos;
			_dealer = _group createUnit [_type, _pos, [],0, "NONE"];
			_civs pushBack _dealer;
			
			_all = server getVariable "activedealers";
			_all pushback _dealer;
			server setVariable ["activedealers",_all,true];
			
			_wp = _group addWaypoint [_gundealerpos,5];
			_wp setWaypointType "MOVE";
			_wp setWaypointSpeed "LIMITED";

			_dealer remoteExec ["initGunDealerLocal",0,true];
			[_dealer] call initGunDealer;
	
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
	sleep 1;
};