private ["_data"];

//get all server data
"Loading persistent save" remoteExec['blackFaded',0,false];

_data = profileNameSpace getVariable ["Overthrow.save.001",""];
if(typename _data != "ARRAY") exitWith {
	[] remoteExec ['newGame',2];
	"No save found, starting new game" remoteExec ["hint",bigboss,true];
};

{
	_key = _x select 0;
	_val = _x select 1;
	_set = true;
	if(_key == "bases") then {
		{
			_pos = _x select 0;
			_name = _x select 1;
			_owner = _x select 2;

			_veh = createVehicle [OT_Item_Flag, _pos, [], 0, "CAN_COLLIDE"];
			_veh setVariable ["owner",_owner,true];
			_veh = createVehicle ["Land_ClutterCutter_large_F", _pos, [], 0, "CAN_COLLIDE"];

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
					_veh setPosATL _pos;
					if(_type isKindOf "Building") then {
						createVehicle ["Land_ClutterCutter_large_F", _pos, [], 0, "CAN_COLLIDE"];
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

					_veh setVariable ["owner",_owner,true];
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
							[getpos _veh,_code] call structureInit;
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
						_mrkid = format["%1-camp",_pos];
						createMarker [_mrkid,_pos];
						_mrkid setMarkerShape "ICON";
						_mrkid setMarkerType "ot_Camp";
						_mrkid setMarkerColor "ColorWhite";
						_mrkid setMarkerAlpha 1;
						_mrkid setMarkerText format ["Camp %1",server getvariable [format["name%1",_owner],""]];
					};
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
}foreach(_data);
sleep 0.1;
{
	_uid = _x;
	_vars = server getVariable [_uid,[]];
	{
		_x params ["_name","_val"];
		if(_name == "owned") exitWith {
			{
				if(typename _x == "ARRAY") then {
					//old save with positions
					_buildings = (_x nearObjects ["Building",8]);
					if(count _buildings > 0) then {
						_bdg = _buildings select 0;
						_bdg setVariable ["owner",getplayeruid player,true];
					};
				}else{
					//new save with IDs
					if (typename _x == "SCALAR") then {
						_bdg = OT_centerPos nearestObject _x;
						_bdg setVariable ["owner",getplayeruid player,true];
					};
				};
			}foreach(_val);
		};
	}foreach(_vars);
}foreach(server getvariable ["OT_allPlayers",[]]);
sleep 2; //let the variables propagate
server setVariable ["StartupType","LOAD",true];
hint "Persistent Save Loaded";
