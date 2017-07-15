private ["_data"];

//get all server data
"Loading persistent save" remoteExec['OT_fnc_notifyStart',0,false];

_data = profileNameSpace getVariable [OT_saveName,""];
if(typename _data != "ARRAY") exitWith {
	[] remoteExec ['newGame',2];
	"No save found, starting new game" remoteExec ["hint",0,false];
};

private _cc = 0;

{
	_key = _x select 0;
	_val = _x select 1;
	if(typename _val == "ARRAY") then {
		_new = [];
		{
			_new pushback _x;
		}foreach(_val);
		_val = _new;
	};
	_set = true;
	if(_key == "civilians") then {
		{
			_y = _x select 0;
			if((_y select [0,4]) != "ace_" and (_y select [0,4]) != "cba_" and (_y select [0,4]) != "bis_") then {
				OT_civilians setVariable [_x select 0,_x select 1,true];
			};
		}foreach(_val);
		_set = false;
	};
	if(_key == "buildingpositions") then {
		{
			_y = _x select 0;
			if((_y select [0,4]) != "ace_" and (_y select [0,4]) != "cba_" and (_y select [0,4]) != "bis_") then {
				buildingpositions setVariable [_x select 0,_x select 1,true];
			};
		}foreach(_val);
		_set = false;
	};
	if(_key == "bases") then {
		{
			_pos = _x select 0;
			_name = _x select 1;
			_owner = _x select 2;

			_veh = createVehicle [OT_flag_IND, _pos, [], 0, "CAN_COLLIDE"];
			_veh enableDynamicSimulation true;
			[_veh,_owner] call OT_fnc_setOwner;
			_veh = createVehicle ["Land_ClutterCutter_large_F", _pos, [], 0, "CAN_COLLIDE"];
			_veh enableDynamicSimulation true;

			_mrkid = format["%1-base",_pos];
			createMarker [_mrkid,_pos];
			_mrkid setMarkerShape "ICON";
			_mrkid setMarkerType "mil_Flag";
			_mrkid setMarkerColor "ColorWhite";
			_mrkid setMarkerAlpha 1;
			_mrkid setMarkerText _name;
		}foreach(_val);
	};
	if((_key == "warehouse") and (typename _val) == "ARRAY") then {
		_set = false;
		{
			if(typename _x == "ARRAY") then {
				_y = _x select 0;
				if(typeName _y != "CODE") then {
					if((_y select [0,4]) != "ace_" and (_y select [0,4]) != "cba_" and (_y select [0,4]) != "bis_") then {
						warehouse setVariable [_x select 0,_x,true];
					};
				};
			};
		}foreach(_val);
	};
	if(_key == "vehicles") then {
		if(typename _val == "ARRAY") then {
			_set = false;
			_ccc = 0;
			{
				_type = _x select 0;
				if(_type == "Land_MapBoard_F") then {
					//Backwards-compatability map upgrade for old saves
					_type = OT_item_Map;
				};
				if !(_type isKindOf "Man") then {
					_pos = _x select 1;
					_dir = _x select 2;
					_stock = _x select 3;
					_owner = _x select 4;
					_name = "";
					if(count _x > 5) then {
						_name = _x select 5;
					};
					_veh = createVehicle [_type, _pos, [], 0, "CAN_COLLIDE"];
					_veh enableDynamicSimulation true;

					if(count _x > 7) then {
						(_x select 7) params ["_fuel","_dmg"];
						//Fuel in tank
						_veh setFuel _fuel;
						{
							_d = (_dmg select 2) select _forEachIndex;
							if(_d > 0) then {
								_veh setHitPointDamage [_x, _d, false];
							};
						}foreach(_dmg select 0);
						if(count (_x select 7) > 2) then {
							//ACE refuel (fuel trucks)
							[_veh, (_x select 7) select 2] call ace_refuel_fnc_setFuel;
						};
						if(count (_x select 7) > 3) then {
							//Lock/unlock
							_veh setVariable ["OT_locked",(_x select 7) select 3,true];
						};
						if(count (_x select 7) > 4) then {
							//Ammo
							_ammo = (_x select 7) select 4;
							{
								_veh setAmmo [_x select 0,_x select 1];
							}foreach((_x select 7) select 4);
						};
						if(count (_x select 7) > 5) then {
							//Attached
							_a = (_x select 7) select 5;
							if(count _a > 0) then {
								_a params ["_attached","_am"];
								_veh setVariable ["OT_attachedClass",_attached,true];
								[_veh,_am] call OT_fnc_initAttached;
							};
						};
					};

					_veh setPosATL _pos;
					if(_type isKindOf "Building") then {
						_clu = createVehicle ["Land_ClutterCutter_large_F", _pos, [], 0, "CAN_COLLIDE"];
						_clu enableDynamicSimulation true;
					};
					if(typename _dir == "SCALAR") then {
						//Pre 0.6.8 save, scalar direction
						_veh setDir _dir;
					}else{
						_veh setVectorDirAndUp _dir;
					};

					clearWeaponCargoGlobal _veh;
					clearMagazineCargoGlobal _veh;
					clearBackpackCargoGlobal _veh;
					clearItemCargoGlobal _veh;
					_veh setVariable ["name",_name,true];

					[_veh,_owner] call OT_fnc_setOwner;
					{
						_cls = _x select 0;
						_num = _x select 1;

						call {
							if(_cls == "money") exitWith {
								_veh setVariable ["money",_num,true];
							};
							if(_cls == "password") exitWith {
								_veh setVariable ["password",_num,true];
							};
							if(_cls isKindOf ["Rifle",configFile >> "CfgWeapons"]) exitWith {
								_veh addWeaponCargoGlobal [_cls,_num];
							};
							if(_cls isKindOf ["Launcher",configFile >> "CfgWeapons"]) exitWith {
								_veh addWeaponCargoGlobal [_cls,_num];
							};
							if(_cls isKindOf ["Pistol",configFile >> "CfgWeapons"]) exitWith {
								_veh addWeaponCargoGlobal [_cls,_num];
							};
							if(_cls isKindOf ["CA_Magazine",configFile >> "CfgMagazines"]) exitWith {
								_veh addMagazineCargoGlobal [_cls,_num];
							};
							if(_cls isKindOf "Bag_Base") exitWith {
								_cls = _cls call BIS_fnc_basicBackpack;
								_veh addBackpackCargoGlobal [_cls,_num];
							};
							_veh addItemCargoGlobal _x;
						};
					}foreach(_stock);

					if(count _x > 6) then {
						_code = (_x select 6);
						if(_code != "") then {
							[_veh,getpos _veh,_code] call OT_fnc_initBuilding;
						};
						_veh setVariable ["OT_init",_code,true];
					};

					if(_type == OT_policeStation) then {
						_town = _pos call OT_fnc_nearestTown;
						_mrkid = format["%1-police",_town];
						createMarker [_mrkid,_pos];
						_mrkid setMarkerShape "ICON";
						_mrkid setMarkerType "o_installation";
						_mrkid setMarkerColor "ColorGUER";
						_mrkid setMarkerAlpha 1;
					};

					if(_type == OT_warehouse) then {
						_mrkid = format["bdg-%1",_veh];
						createMarker [_mrkid,_pos];
						_mrkid setMarkerShape "ICON";
						_mrkid setMarkerType "OT_warehouse";
						_mrkid setMarkerColor "ColorWhite";
						_mrkid setMarkerAlpha 1;
					};

					if(_type == OT_item_tent) then {
						_mrkid = format["%1-camp",_owner];
						createMarker [_mrkid,_pos];
						_mrkid setMarkerShape "ICON";
						_mrkid setMarkerType "ot_Camp";
						_mrkid setMarkerColor "ColorWhite";
						_mrkid setMarkerAlpha 1;
						_mrkid setMarkerText format ["Camp %1",server getvariable [format["name%1",_owner],""]];
					};
				};
				if(_ccc == 10) then {
					_ccc = 0;
					sleep 0.2;
				};
			}foreach(_val);
		};
	};

	if(_set and !(isNil "_val")) then {
		if((_key select [0,4]) != "ace_" and (_key select [0,4]) != "cba_" and (_key select [0,4]) != "bis_") then {
			if(typename _val == "ARRAY") then {
				//make a copy
				_orig = _val;
				_val = [];
				{
					_val pushback _x;
				}foreach(_orig);
			};
			server setvariable [_key,_val,true];
		};
	};
	_cc = _cc + 1;
	if(_cc == 100) then {
		_cc = 0;
		sleep 0.2;
	};
}foreach(_data);
sleep 0.2;

{
	_pos = _x select 0;
	_code = format["fob%1",_pos];
	_garrison = server getVariable [format["resgarrison%1",_code],[]];
	if(count _garrison > 0) then {
		_group = creategroup resistance;
		spawner setVariable [format["resgarrison%1",_code],_group,true];
		{
			_x params ["_cls","_loadout"];

			if(_cls != "HMG" and _cls != "GMG") then {
				private _start = [[[_pos,30]]] call BIS_fnc_randomPos;
				private _civ = _group createUnit [_cls, _start, [],0, "NONE"];
				_civ setUnitLoadout [_loadout,true];
			}else{
				[_pos,_cls,false] spawn OT_fnc_addGarrison;
			};
		}foreach(_garrison);
	};
}foreach(server getvariable ["bases",[]]);

{
	_pos = _x select 0;
	_code = _x select 1;
	_garrison = server getVariable [format["resgarrison%1",_code],[]];
	if(count _garrison > 0) then {
		_group = creategroup resistance;
		spawner setVariable [format["resgarrison%1",_code],_group,true];
		{
			_x params ["_cls","_loadout"];
			if(_cls != "HMG" and _cls != "GMG") then {
				private _start = [[[_pos,30]]] call BIS_fnc_randomPos;
				private _civ = _group createUnit [_cls, _start, [],0, "NONE"];
				_civ setUnitLoadout [_loadout,true];
			}else{
				[_pos,_cls,false] spawn OT_fnc_addGarrison;
			};
		}foreach(_garrison);
	};
}foreach(OT_objectiveData + OT_airportData);

private _built = (allMissionObjects "Static");
{
	private _uid = _x;
	private _vars = server getVariable [_uid,[]];
	private _leased = [_uid,"leased",[]] call OT_fnc_getOfflinePlayerAttribute;
	private _leasedata = [];
	{
		_x params ["_name","_val"];
		if(_name == "owned") then {
			{
				if(typename _x == "ARRAY") then {
					//old save with positions
					_buildings = (_x nearObjects ["Building",8]);
					if(count _buildings > 0) then {
						_bdg = _buildings select 0;
						[_bdg,_uid] call OT_fnc_setOwner;
					};
				}else{
					[_x,_uid] call OT_fnc_setOwner;

					_pos = buildingpositions getVariable [_x,[]];
					_bdg = objNull;
					if(count _pos == 0) then {
						_bdg = OT_centerPos nearestObject parseNumber _x;
						buildingpositions setVariable [_x,position _bdg,true];
					}else{
						_bdg = _pos nearestObject _x;
					};
					if !(_bdg in _built) then {
						_bdg addEventHandler ["Dammaged",OT_fnc_buildingDamagedHandler];
					};
					if(_x in _leased) then {
						_leasedata pushback [_x,typeof _bdg,_pos,_pos call OT_fnc_nearestTown];
					};
				};
			}foreach(_val);
		};
	}foreach(_vars);
	[_uid,"leasedata",_leasedata] call OT_fnc_setOfflinePlayerAttribute;
}foreach(server getvariable ["OT_allPlayers",[]]);
sleep 2; //let the variables propagate
server setVariable ["StartupType","LOAD",true];
hint "Persistent Save Loaded";
