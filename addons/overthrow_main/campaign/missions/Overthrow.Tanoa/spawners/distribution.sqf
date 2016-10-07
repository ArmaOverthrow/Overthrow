private ["_id","_pos","_building","_tracked","_civs","_vehs","_group","_all","_shopkeeper"];

_hour = date select 3;
_town = _this;
_activeshops = server getVariable [format["activedistin%1",_town],[]];

_groups = [];
{
	_pos = _x select 0;
	_stock = _x select 1;
	
	_building = nearestBuilding _pos;
	_security = server getvariable format["garrison%1",_pos];
	
	//Parked truck
	_vehtype = OT_vehType_distro;
	_start = [_pos,11,(getDir _building)-155] call BIS_fnc_relPos;
	
	_posVeh = _start findEmptyPosition [0,15,_vehtype];
	_veh = _building getVariable "truck";
	if(count _posVeh > 0 and isNil("_veh")) then {				
		_veh = _vehtype createVehicle _posVeh;
		clearItemCargoGlobal _veh;
				
		_veh setDir (getDir _building)-90;
		_groups pushBack _veh;
		_building setVariable ["truck",_veh,false];
		_veh setVariable ["distro",_building,false];					
	
		_veh addEventHandler ["Take",{
			_unit setCaptive false;
		}];
	};
	sleep 0.1;
	if(_hour > 18 or _hour < 8) then {
		//Put a light on
		sleep 0.1;
		_lightpos = getpos _building;
		_light = "#lightpoint" createVehicle [_lightpos select 0,_lightpos select 1,(_lightpos select 2)+4];
		_light setLightBrightness 0.2;
		_light setLightAmbient[.9, .9, .6];
		_light setLightColor[.5, .5, .4];
		_groups pushback _light;
	};
	
	_group = createGroup blufor;
	_groups pushback _group;		
	_count = 0;
	while {_count < _security} do {
		_start = [[[_pos,50]]] call BIS_fnc_randomPos;									
		_civ = _group createUnit [OT_NATO_Unit_Police, _start, [],0, "NONE"];
		_civ setBehaviour "SAFE";
		[_civ,_building] spawn initSecurity;			
		_count = _count + 1;				
		sleep 0.1;
	};
	
	_wp = _group addWaypoint [_pos,5];
	_wp setWaypointType "GUARD";
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointSpeed "LIMITED";
	
	//Inventory
	_vehtype = OT_items_distroStorage select 0;	
	
	_pos = [_pos,4.5,(getDir _building)-135] call BIS_fnc_relPos;
	_veh = _vehtype createVehicle _pos;
	clearItemCargoGlobal _veh;					
	_veh setDir (getDir _building);
	_veh setVariable ["stockof",_building];
	_veh addEventHandler ["ContainerOpened",illegalContainerOpened];
	
	if(OT_hasAce) then {
		_veh setVariable ["ace_illegalCargo",true,false];				
	};
	_groups pushback _veh;
	{
		_cls = _x select 0;
		_num = _x select 1;
		if(_cls in OT_allBackpacks) then {	
			_veh addBackpackCargoGlobal _x;
		}else{
			_veh addItemCargoGlobal _x;
		};	
		sleep 0.1;
	}foreach(_stock);
	
}foreach(_activeshops);

_groups