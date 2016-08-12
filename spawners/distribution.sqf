private ["_id","_pos","_building","_tracked","_civs","_vehs","_group","_all","_shopkeeper"];
if (!isServer) exitwith {};

_active = false;

_count = 0;
_id = _this select 0;
_pos = _this select 1;
_building = _this select 3;

_vehs = []; //Stores all civs for tear down
_civs = [];
_groups = [];
sleep 2;

waitUntil{spawner getVariable _id};
[_building] spawn run_distribution;
sleep 4;
while{true} do {
	//Do any updates here that should happen whether spawned or not
	
	//Main spawner
	if !(_active) then {
		if (spawner getVariable _id) then {
			_hour = date select 3;
			
			_active = true;
			//Spawn stuff in
			_stock = _building getVariable "stock";
			_employees = _building getVariable "employees";
			_security = _building getVariable "security";
						
			_vehtype = AIT_vehType_distro;
			_start = [_pos,11,(getDir _building)-155] call BIS_fnc_relPos;
			
			_posVeh = _start findEmptyPosition [0,15,_vehtype];
			_veh = _building getVariable "truck";
			if(count _posVeh > 0 and isNil("_veh")) then {				
				_veh = _vehtype createVehicle _posVeh;
				clearItemCargoGlobal _veh;
						
				_veh setDir (getDir _building)-90;
				_vehs pushBack _veh;
				_building setVariable ["truck",_veh,false];
				_veh setVariable ["distro",_building,false];
							
				_veh addEventHandler ["GetIn",{						
					_unit = _this select 2;						
					_v = _this select 0;
					if(isPlayer _unit) then {
						_v setVariable ["owner",getPlayerUID _unit,true];
						_v setVariable ["stolen",true,true];
						if(_unit call unitSeen) then {
							_unit setCaptive false;
						};
					};
				}];
				
				_veh addEventHandler ["Take",{
					_unit setCaptive false;
				}];
			};
			
			if(_hour > 18 or _hour < 8) then {
				//Put a light on
				_lightpos = getpos _building;
				_light = "#lightpoint" createVehicle [_lightpos select 0,_lightpos select 1,(_lightpos select 2)+4];
				_light setLightBrightness 0.2;
				_light setLightAmbient[.9, .9, .6];
				_light setLightColor[.5, .5, .4];
				_vehs pushback _light;
			};
			
			_group = createGroup blufor;
			_groups pushback _group;		

			while {_count < _security} do {
				_start = [[[_pos,50]]] call BIS_fnc_randomPos;									
				_civ = _group createUnit [AIT_NATO_Unit_Police, _start, [],0, "NONE"];
				_civ setBehaviour "SAFE";
				[_civ,_building] spawn initSecurity;
				_civs pushBack _civ;				
				_count = _count + 1;				
				sleep 0.01;
			};
			
			_wp = _group addWaypoint [_pos,5];
			_wp setWaypointType "GUARD";
			_wp setWaypointBehaviour "SAFE";
			_wp setWaypointSpeed "LIMITED";
						
			sleep 1;
			
			//Inventory
			_vehtype = AIT_items_distroStorage select 0;	
			
			_pos = [_pos,4.5,(getDir _building)-135] call BIS_fnc_relPos;
			_veh = _vehtype createVehicle _pos;
			clearItemCargoGlobal _veh;					
			_veh setDir (getDir _building);
			_veh setVariable ["stockof",_building];
			_veh addEventHandler ["ContainerOpened",illegalContainerOpened];
			
			if(AIT_hasAce) then {
				_veh setVariable ["ace_illegalCargo",true,false];				
			};
			sleep 0.2;
			_vehs pushBack _veh;
			{		
				if((random 100) > 97) then {
					_pos = [_pos,2.5,(getDir _building)-90] call BIS_fnc_relPos;
					_veh setVariable ["stockof",_building,false];
					_veh = _vehtype createVehicle _pos;
					clearItemCargoGlobal _veh;					
					_veh setDir (getDir _building);
					_veh addEventHandler ["ContainerOpened",illegalContainerOpened];
					if(AIT_hasAce) then {
						_veh setVariable ["ace_illegalCargo",true,false];				
					};
					sleep 0.2;
				};
				_cls = _x select 0;
				_num = _x select 1;
				if(_cls in AIT_allBackpacks) then {	
					_veh addBackpackCargo _x;
				}else{
					_veh addItemCargo _x;
				};				
			}foreach(_stock);
			
			{
				_x addCuratorEditableObjects [_civs,true];
			} forEach allCurators;
			
			sleep 1;
			{
				_x setDamage 0;				
			}foreach(_civs);				
		};
	}else{
		if (spawner getVariable _id) then {
			//Do updates here that should happen only while spawned
			//...
		}else{			
			_active = false;
			//Tear it all down
			{
				_delivery = _x getVariable "delivery";
				if (!(_x call hasOwner) and !isNil "_delivery") then {
					sleep 0.1;
					deleteVehicle _x;
				};				
			}foreach(_vehs);
			{
				sleep 0.1;
				deleteVehicle _x;						
			}foreach(_civs);
			{				
				deleteGroup _x;								
			}foreach(_groups);
			_civs = [];
			_groups = [];
			_vehs = [];
			_building setVariable ["truck",false,true];
		};
	};
	sleep 2;
};