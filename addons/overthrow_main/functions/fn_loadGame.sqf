private ["_data"];

//get all server data
"Loading persistent save" remoteExec['blackFaded',0,false];

_data = profileNameSpace getVariable ["Overthrow.save.001",""];
if(typename _data != "ARRAY") exitWith {
	[] remoteExec ['newGame',2];
	"No save found, starting new game" remoteExec ["hint",0,true];
};

private _cc = 0;

{
	_key = _x select 0;
	_val = _x select 1;
	_set = true;
	if(_key == "buildingpositions") then {
		{
			buildingpositions setVariable [_x select 0,_x select 1,true];
		}foreach(_val);
		_set = false;
	};
	if(_key == "bases") then {
		{
			_pos = _x select 0;
			_name = _x select 1;
			_owner = _x select 2;

			_veh = createVehicle [OT_Item_Flag, _pos, [], 0, "CAN_COLLIDE"];
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
				_cls = _x select 0;
				warehouse setVariable [_cls,_x,true];
			};
		}foreach(_val);
	};
	if(_key == "vehicles") then {
		if(typename _val == "ARRAY") then {
			_set = false;
			_ccc = 0;
			{
				_type = _x select 0;

				if !(_type isKindOf "Man") then {
					_pos = _x select 1;
					_dir = _x select 2;
					_stock = _x select 3;
					_owner = _x select 4;
					_name = "";
					if(count _x > 5) then {
						_name = _x select 5;
					};
					_veh = _type createVehicle _pos;
					_veh enableDynamicSimulation true;

					if(count _x > 7) then {
						(_x select 7) params ["_fuel","_dmg"];
						_veh setFuel _fuel;
						{
							_veh setHitPointDamage [_x, (_dmg select 2) select _forEachIndex]
						}foreach(_dmg select 0);
						if(count (_x select 7) > 2) then {
							[_veh, (_x select 7) select 2] call ace_refuel_fnc_setFuel;
						};
						if(count (_x select 7) > 3) then {
							_veh setVariable ["OT_locked",(_x select 7) select 3,true];
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

					_veh enableSimulationGlobal true;

					if(_type == OT_item_Map) then {
						_veh setObjectTextureGlobal [0,"\ot\ui\maptanoa.paa"];
					};

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
								_veh addBackpackCargoGlobal [_cls,_num];
							};
							_veh addItemCargoGlobal _x;
						};
					}foreach(_stock);

					if(count _x > 6) then {
						_code = (_x select 6);
						if(_code != "") then {
							[_veh,getpos _veh,_code] call structureInit;
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
					sleep 0.1;
				};
			}foreach(_val);
		};
	};

	if(_set and !(isNil "_val")) then {
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
	_cc = _cc + 1;
	if(_cc == 100) then {
		_cc = 0;
		sleep 0.1;
	};
}foreach(_data);
sleep 0.1;

{
	_pos = _x select 0;
	_code = format["fob%1",_pos];
	_garrison = server getVariable [format["resgarrison%1",_code],[]];
	if(count _garrison > 0) then {
		_group = creategroup resistance;
		spawner setVariable [format["resgarrison",_code],_group,true];
		{
			_x params ["_cls","_loadout"];
			call {
				if(_cls == "HMG") exitWith {
					_p = _pos findEmptyPosition [0,50,"I_HMG_01_high_F"];
			        _gun = "I_HMG_01_high_F" createVehicle _p;
			        createVehicleCrew _gun;
			        {
			            [_x] joinSilent _group;
			        }foreach(crew _gun);
				};
				if(_cls == "GMG") exitWith {
					_p = _pos findEmptyPosition [0,50,"I_GMG_01_high_F"];
			        _gun = "I_GMG_01_high_F" createVehicle _p;
			        createVehicleCrew _gun;
			        {
			            [_x] joinSilent _group;
			        }foreach(crew _gun);
				};
				private _start = [[[_pos,30]]] call BIS_fnc_randomPos;
				private _civ = _group createUnit [_cls, _start, [],0, "NONE"];
				_civ setUnitLoadout [_loadout,true];
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
		spawner setVariable [format["resgarrison",_code],_group,true];
		{
			_x params ["_cls","_loadout"];
			private _start = [[[_pos,30]]] call BIS_fnc_randomPos;
			private _civ = _group createUnit [_cls, _start, [],0, "NONE"];
			_civ setUnitLoadout [_loadout,true];
		}foreach(_garrison);
	};
}foreach(OT_objectiveData + OT_airportData);

private _built = (allMissionObjects "Static");
{
	private _uid = _x;
	private _vars = server getVariable [_uid,[]];
	private _leased = [_uid,"leased",[]] call OT_fnc_getOfflinePlayerAttribute;
	private _leasedata = [];
	private _handler = compileFinal preprocessFileLineNumbers "events\buildingDamaged.sqf";
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
					//new save with IDs
					if (typename _x == "SCALAR") then {
						[_x,_uid] call OT_fnc_setOwner;

						_pos = buildingpositions getVariable [str _x,[]];
						_bdg = objNull;
						if(count _pos == 0) then {
							_bdg = OT_centerPos nearestObject _x;
							buildingpositions setVariable [str _x,position _bdg,true];
						}else{
							_bdg = _pos nearestObject _x;
						};
						if !(_bdg in _built) then {
							_bdg addEventHandler ["Dammaged",_handler];
						};
						if(_x in _leased) then {
							_leasedata pushback [_x,typeof _bdg,_pos,_pos call OT_fnc_nearestTown];
						};
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
