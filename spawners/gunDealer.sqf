private ["_id","_pos","_building","_tracked","_civs","_vehs","_group","_all","_shopkeeper"];
if (!isServer) exitwith {};

_active = false;

_count = 0;
_id = _this select 0;
_posTown = _this select 1;
_town = _this select 3;

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
				_building = [_posTown,AIT_gunDealerHouses] call getRandomBuilding;
				_gundealerpos = (_building call BIS_fnc_buildingPositions) call BIS_fnc_selectRandom;
				server setVariable [format["gundealer%1",_town],_gundealerpos,false];
				_building setVariable ["owner","system",true];
			};
			_group = createGroup civilian;	
			_groups	pushback _group;
			
			_group setBehaviour "CARELESS";
			_type = AIT_civTypes_gunDealers call BIS_Fnc_selectRandom;
			_pos = [[[_gundealerpos,50]]] call BIS_fnc_randomPos;
			_dealer = _group createUnit [_type, _pos, [],0, "NONE"];
						
			_wp = _group addWaypoint [_gundealerpos,0];
			_wp setWaypointType "MOVE";
			_wp setWaypointSpeed "LIMITED";

			_dealer remoteExec ["initGunDealerLocal",0,true];
			[_dealer] call initGunDealer;
			_allactive = spawner getVariable ["activedealers",[]];
			_allactive pushback _dealer;
			spawner setVariable ["activedealers",_allactive,true];
		};
	}else{
		if (spawner getVariable _id) then {
			//Do updates here that should happen only while spawned
			//...
		}else{			
			_active = false;
			//Tear it all down
			_allactive = spawner getVariable ["activedealers",[]];
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
			spawner setVariable ["activedealers",_allactive,true];
			_groups = [];
		};
	};
	sleep 2;
};