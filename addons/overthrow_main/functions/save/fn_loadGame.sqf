params [
	["_data",profileNameSpace getVariable [OT_saveName,""]]
];

//get all server data
"Loading persistent save" remoteExec['OT_fnc_notifyStart',0,false];

if (_data isEqualType "" && {_data isEqualTo ""}) then {
	[] remoteExec ['OT_fnc_newGame',2];
	"No save found, starting new game" remoteExec ["hint",0,false];
};

private _cc = 0;

//make sure server vars are done first
{
	_x params ["_key","_val"];
	if(_key == "server") then {
		{
			_x params ["_subkey","_subval"];
			if(!(toLower (_subkey select [0,4]) in ["cba_","bis_"])) then {
				server setVariable [_subkey,_subval,true];
			};
		}foreach(_val);
		_set = false;
	};
}foreach(_data);

sleep 0.3;


//now do everything else
private _buildableHouses = [];
private _hasList_buildableHouses = false;
{
	_x params ["_key","_val"];

	// copy, we might modify it
	if (_val isEqualType []) then {_val = +_val;};
	private _set = true;

	if(_key == "players") then {
		{
			_x params ["_subkey","_subval"];
			if(!(toLower (_subkey select [0,4]) in ["ace_","cba_","bis_"]) && {(_subkey select [0,9]) != "seencache"}) then {
				//v0.7.8.3 : Clears extraneous tutorial done entries
				if(_subval isEqualType []) then {
					{
						if(_x isEqualType []) then {
							if(count _x == 2) then {
								_x params ["_k","_v"];
								if(_k isEqualTo "ot_tutesdone") then {
									_x set [1,_v arrayIntersect _v];
								};
							};
						};
					}foreach(_subval);
				};
				players_NS setVariable [_subkey,_subval,true];
			};
		}foreach(_val);
		_set = false;
	};
	if(_key == "civilians") then {
		{
			_x params ["_subkey",["_subval",""]];
			if!(toLower (_subkey select [0,4]) in ["ace_","cba_","bis_"]) then {
				OT_civilians setVariable [_subkey,_subval,true];
			};
		}foreach(_val);
		_set = false;
	};
	if(_key == "buildingpositions") then {
		{
			_x params ["_subkey","_subval"];
			if!(toLower (_subkey select [0,4]) in ["ace_","cba_","bis_"]) then {
				buildingpositions setVariable [_subkey,_subval,true];
			};
		}foreach(_val);
		_set = false;
	};
	if(_key == "bases") then {
		{
			_x params ["_pos","_name","_owner"];

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

		// todo _set = false?
	};
	if(_key == "warehouse") then {
		private _version = _val param [0,1,[0]];
		switch (_version) do {
			case 2: {
				_val deleteAt 0;
				{
					if(!isNil "_x") then {
						if(_x isEqualType []) then {
							_x params [["_itemClass","",[""]],["_itemCount",0,[0]]];
							if (_itemCount > 0 && !(_itemClass isEqualTo "")) then {
								warehouse setVariable [format["item_%1",_itemClass],[_itemClass,_itemCount],true];
							};
						};
					};
				}foreach(_val);
			};
			default {
				{
					_x params ["_itemClassL","_itemData"];
					if !(isNil "_itemData") then {
						if (_itemData isEqualType []) then {
							_itemData params ["_cls",["_num",0,[0]]];
							if (_num > 0) then {
								warehouse setVariable [format["item_%1",_itemClassL],_itemData,true];
							};
						};
					};
				}foreach(_val select {!(((toLower (_x#0)) select [0,4]) in ["cba_","bis_"])});
			};
		};
		_set = false;
	};
	if(_key == "vehicles") then {
		_set = false;
		_ccc = 0;
		{
			_type = _x select 0;
			if(_type isEqualTo "Land_MapBoard_F") then {
				//Backwards-compatability map upgrade for old saves
				_type = OT_item_Map;
			};
			if !(_type isKindOf "Man") then {
				_pos = ((_x select 1)#0);
				_simulation = ((_x select 1)#1);
				_posFormat = (_x select 1) param [2, 0];		// Assume format 0 by default (posATL)
				_dir = _x select 2;
				_stock = _x select 3;
				_owner = _x select 4;
				_name = "";
				if(count _x > 5) then {
					_name = _x select 5;
				};
				_veh = createVehicle [_type, [0,0,1000], [], 0, "CAN_COLLIDE"];
				if !(_type isKindOf "LandVehicle" || _type isKindOf "Air" || _type isKindOf "Ship") then {
					_veh enableDynamicSimulation true;
				};
				/*
				if !(_simulation) then {
					_veh enableSimulationGlobal false;
				}else{
					_veh enableDynamicSimulation true;
				};
				*/

				if(count _x > 7) then {		// index range 0..6
					(_x select 7) params ["_fuel","_dmg"];
					//Fuel in tank
					if !(_veh isKindOf "Building") then {
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
				};

				// Fetch the list of buildable houses
				if (!_hasList_buildableHouses) then {
					if (!isNil "OT_Buildables") then {
						_buildableHouses = (OT_Buildables param [9, []]) param [2, []];
						_hasList_buildableHouses = true;
					};
				};

				// If the object is a player-built house, fetch its variables
				private _houseParams = _x param [8, []];
				if (!(_houseParams isEqualTo []) or {_type in _buildableHouses}) then {
					_veh setVariable ["OT_house_isPlayerBuilt", true, true];

					private _isLeased = _houseParams param [0, false];
					if (_isLeased) then {
						_veh setVariable ["OT_house_isLeased", true, true];

						private _leasedBuilt = [_owner,"leasedBuilt",[]] call OT_fnc_getOfflinePlayerAttribute;
						_leasedBuilt pushBack _veh;
						[_owner,"leasedBuilt",_leasedBuilt] call OT_fnc_setOfflinePlayerAttribute;
					};
				};

				if (_posFormat == 1) then {
					_veh setPosWorld _pos;		// format 1 is the new posWorld format
				} else {
					_veh setPosATL _pos;		// <= v0.7.8.5 save - use the old posATL format
				};

				if(_dir isEqualType 0) then {
					//Pre 0.6.8 save, scalar direction
					_veh setDir _dir;
				}else{
					_veh setVectorDirAndUp _dir;
				};
				if(_type isKindOf "Building") then {
					_clu = createVehicle ["Land_ClutterCutter_large_F", _pos, [], 0, "CAN_COLLIDE"];
					_clu enableDynamicSimulation true;
				};

				clearWeaponCargoGlobal _veh;
				clearMagazineCargoGlobal _veh;
				clearBackpackCargoGlobal _veh;
				clearItemCargoGlobal _veh;
				_veh setVariable ["name",_name,true];

				// If this vehicle doesn't have an owner, set the forceSaveunowned flag to true so it gets saved again (until somebody owns it)
				if (_owner isEqualTo "") then {
					 _veh setVariable ["OT_forceSaveUnowned", true, true];
				// Otherwise, set the owner (as per usual)
				} else {
					[_veh,_owner] call OT_fnc_setOwner;
				};

				{
					[_x,_veh] call {
						params ["_it", "_veh"];
						_it params ["_cls", "_num"];
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
						if(_cls isKindOf ["Default",configFile >> "CfgMagazines"]) exitWith {
							private _scope = getNumber(configFile >> "CfgMagazines" >> _cls >> "scope");
							if(_scope > 1) then {
								_veh addMagazineCargoGlobal [_cls,_num];
							};
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

				if(_type isEqualTo OT_policeStation) then {
					_town = _pos call OT_fnc_nearestTown;
					_mrkid = format["%1-police",_town];
					createMarker [_mrkid,_pos];
					_mrkid setMarkerShape "ICON";
					_mrkid setMarkerType "o_installation";
					_mrkid setMarkerColor "ColorGUER";
					_mrkid setMarkerAlpha 1;
				};

				if(_type isEqualTo OT_warehouse) then {
					_mrkid = format["bdg-%1",_veh];
					createMarker [_mrkid,_pos];
					_mrkid setMarkerShape "ICON";
					_mrkid setMarkerType "OT_warehouse";
					_mrkid setMarkerColor "ColorWhite";
					_mrkid setMarkerAlpha 1;
				};

				if(_type isEqualTo OT_item_tent) then {
					_mrkid = format["%1-camp",_owner];
					createMarker [_mrkid,_pos];
					_mrkid setMarkerShape "ICON";
					_mrkid setMarkerType "ot_Camp";
					_mrkid setMarkerColor "ColorWhite";
					_mrkid setMarkerAlpha 1;
					_mrkid setMarkerText format ["Camp %1",players_NS getvariable [format["name%1",_owner],""]];
				};
			};
			if(_ccc isEqualTo 10) then {
				_ccc = 0;
				sleep 0.3;
			};
		}foreach(_val);
	};
	if(_key == "recruits") then {
		server setVariable [_key,_val,true];
		_set = false;
	};
	if(_key == "squads") then {
		server setVariable [_key,_val,true];
		_set = false;
	};
	if(_key == "timedate") then {
		server setVariable [_key,_val,true];
		_set = false;
	};
	if(_key == "autosave") then {
		OT_autoSave_time = (_val#0);
		OT_autoSave_last_time = (_val#1);
		_set = false;
	};
	if(_key == "recruitables") then {
		private _done = false;
		{
			_x params ["_cls","_loadout"];
			{
				_x params ["_c","_l"];
				if(_c == _cls) exitWith {_done = true;_x set [1,_loadout]};
			}foreach(OT_Recruitables);
		}foreach(_val);
		if !(_done) then {OT_Recruitables pushback [_cls,_loadout]};
		publicVariable "OT_Recruitables";
		_set = false;
	};
	if(_key == "policeLoadout") then {
		OT_Loadout_Police = _val;
		publicVariable "OT_Loadout_Police";
		_set = false;
	};

	if(_set && !(isNil "_val")) then {
		if!(toLower (_key select [0,4]) in ["ace_","cba_","bis_"]) then {
			// server setvariable [_key,_val,true];
			diag_log format["Dangling key value pair found: %1 - %2", _key, _val];
		};
	};
	_cc = _cc + 1;
	if(_cc isEqualTo 100) then {
		_cc = 0;
		sleep 0.3;
	};
}foreach(_data);
sleep 0.3;

{
	_pos = _x select 0;
	_code = format["fob%1",_pos];
	_garrison = server getVariable [format["resgarrison%1",_code],[]];
	if(count _garrison > 0) then {
		_group = creategroup resistance;
		spawner setVariable [format["resgarrison%1",_code],_group,true];
		{
			_x params ["_cls","_loadout"];
			if(_cls isEqualType 0) then {
				_cls = (OT_Recruitables select _cls) select 0;
			};

			if(_cls != "HMG" && _cls != "GMG") then {
				private _start = [[[_pos,30]]] call BIS_fnc_randomPos;
				private _civ = _group createUnit [_cls, _start, [],0, "NONE"];
				_civ setUnitLoadout [_loadout,true];
			}else{
				[_pos,_cls,false] call OT_fnc_addGarrison;
			};
			sleep 0.1;
		}foreach(_garrison);
	};
	private _mrkid = format["%1-base",_pos];
    createMarker [_mrkid,_pos];
    _mrkid setMarkerShape "ICON";
    _mrkid setMarkerType "mil_Flag";
    _mrkid setMarkerColor "ColorWhite";
    _mrkid setMarkerAlpha 1;
    _mrkid setMarkerText (_x select 1);
	_veh = OT_flag_IND createVehicle _pos;
	[_veh,(server getVariable ["generals",[getPlayerUID player]]) select 0] call OT_fnc_setOwner;
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
			if(_cls isEqualType 0) then {
				_cls = (OT_Recruitables select _cls) select 0;
			};
			if(_cls != "HMG" && _cls != "GMG") then {
				private _start = [[[_pos,30]]] call BIS_fnc_randomPos;
				private _civ = _group createUnit [_cls, _start, [],0, "NONE"];
				_civ setUnitLoadout [_loadout,true];
			}else{
				[_pos,_cls,false] call OT_fnc_addGarrison;
			};
			sleep 0.1;
		}foreach(_garrison);
	};
}foreach(OT_objectiveData + OT_airportData);

//reveal gang camps
private _revealed = server getVariable ["revealedGangs",[]];
{
	private _gang = OT_civilians getVariable [format["gang%1",_x],[]];

	if((count _gang) > 0) then {
		_mrkid = format["gang%1",_gang select 2];
		_mrk = createMarker [_mrkid, _gang select 4];
		_mrkid setMarkerType "ot_Camp";
		_mrkid setMarkerColor "colorOPFOR";
	};
}foreach(_revealed);

private _built = (allMissionObjects "Static");
{
	private _uid = _x;
	private _vars = players_NS getVariable [_uid,[]];
	private _leased = [_uid,"leased",[]] call OT_fnc_getOfflinePlayerAttribute;
	private _leasedata = [];
	private _leasedNew = [];
	{
		_x params ["_name","_val"];
		if(_name isEqualTo "owned") then {
			{
				if(false/*typename _x isEqualTo "ARRAY"*/) then {
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
					if(count _pos isEqualTo 0) then {
						_bdg = OT_centerPos nearestObject parseNumber _x;
						buildingpositions setVariable [_x,position _bdg,true];
					}else{
						_bdg = _pos nearestObject parseNumber _x;
					};
					if !(_bdg in _built) then {
						_bdg addEventHandler ["Dammaged",OT_fnc_buildingDamagedHandler];
					};
					if(_x in _leased) then {
						_leasedata pushback [_x,typeof _bdg,_pos,_pos call OT_fnc_nearestTown];
						_leasedNew pushBack _x;
					};
				};
			}foreach(_val);
		};
	}foreach(_vars);

	// Add the built houses
	{
		private _ID = [_x] call OT_fnc_getBuildID;
		private _pos = position _x;
		_leasedata pushBack [_ID, typeof _x,_pos,_pos call OT_fnc_nearestTown];
		_leasedNew pushBack _ID;
	} forEach ([_uid,"leasedBuilt",[]] call OT_fnc_getOfflinePlayerAttribute);

	[_uid,"leasedata",_leasedata] call OT_fnc_setOfflinePlayerAttribute;
	[_uid,"leased",_leasedNew] call OT_fnc_setOfflinePlayerAttribute;		// Overwrite the "leased" data to get rid of the IDs that point to buildings which no longer exist (player-built houses)
	[_uid,"leasedBuilt",[]] call OT_fnc_setOfflinePlayerAttribute;
}foreach(players_NS getvariable ["OT_allPlayers",[]]);

OT_autoSave_last_time = (time + (OT_autoSave_time*60)) + 60;

sleep 2; //let the variables propagate
server setVariable ["StartupType","LOAD",true];
hint "Persistent Save Loaded";
