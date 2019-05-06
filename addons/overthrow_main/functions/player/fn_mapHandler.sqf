if !(visibleMap || visibleGPS) exitWith {};

disableSerialization;
params ["_mapCtrl"];

private _vehs = [];
private _cfgVeh = configFile >> "CfgVehicles";
if(isMultiplayer) then {
	{
		private _veh = vehicle _x;
		if(_veh isEqualTo _x) then {
			_mapCtrl drawIcon [
				"iconMan",
				[[0,0.2,0,1], [0,0.5,0,1]] select captive _x,
				getPosASL _x,
				24,
				24,
				getdir _x,
				name _x
			];
		}else{
			_vehs pushBackUnique _veh;
		};
	}foreach([] call CBA_fnc_players);
};

private _grpUnits = groupSelectedUnits player;
{
	if (!(isPlayer _x) && {(side _x isEqualTo resistance) || captive _x}) then {
		private _veh = vehicle _x;
		if(_veh isEqualTo _x) then {
			private _color = [[0,0.2,0,1],[0,0.5,0,1]] select captive _x;
			private _visPos = visiblePosition _x;
			private _txt = "";
			if(leader _x isEqualTo player) then {
				expectedDestination _x params ["_destpos","_planning"];
				if (_planning == "LEADER PLANNED") then {
					_mapCtrl drawLine [
						_visPos,
						_destpos,
						_color
					];
					_mapCtrl drawIcon [
						"\A3\ui_f\data\map\groupicons\waypoint.paa",
						_color,
						_destpos,
						24,
						24,
						0
					];
				};

				if(_x in _grpUnits) then {
					_mapCtrl drawIcon [
						"\A3\ui_f\data\igui\cfg\islandmap\iconplayer_ca.paa",
						_color,
						_visPos,
						24,
						24,
						0
					];
				};
			}else {

				_mapCtrl drawIcon [
					"iconMan",
					_color,
					_visPos,
					24,
					24,
					getDir _x
				];
			};

		}else{
			_vehs pushBackUnique _veh;
		};
	};
}foreach(allunits);

if (!visibleGPS) then {
	private _mortars = spawner getVariable ["NATOmortars",[]];
	{
		_mapCtrl drawIcon [
			"\A3\ui_f\data\map\markers\nato\b_mortar.paa",
			[0,0.3,0.59,(2000 - (_x select 1)) / 2000],
			_x select 2,
			24,
			24,
			0,
			""
		];
	}foreach(_mortars);
	if(((getposatl player) select 2) > 30) then {
		//Show no-fly zones
		private _abandoned = server getVariable ["NATOabandoned",[]];
		{
			if !(_x in _abandoned) then {
				_mapCtrl drawEllipse [
					server getvariable _x,
					2000,
					2000,
					0,
					[1, 0, 0, 1],
					"\A3\ui_f\data\map\markerbrushes\bdiagonal_ca.paa"
				];
			};
		}foreach(OT_allAirports);
		private _attack = server getVariable ["NATOattacking",""];
		if(_attack != "") then {
			_mapCtrl drawEllipse [
				server getvariable [_attack, [0,0]],
				2000,
				2000,
				0,
				[1, 0, 0, 1],
				"\A3\ui_f\data\map\markerbrushes\bdiagonal_ca.paa"
			];
		};
	};
};

{
	private _pos = getPosASL _x;
	if (!visibleGPS || { _pos distance2D player < 1200 }) then {
		private _passengers = "";
		private _color = [0,0.5,0,1];
		{
			if(isPlayer _x && !(_x isEqualTo player)) then {
				_passengers = format["%1 %2",_passengers,name _x];
			};
			if !(captive _x) then {_color = [0,0.2,0,1];};
		}foreach(crew _x);

		_mapCtrl drawIcon [
			getText(_cfgVeh >> (typeof _x) >> "icon"),
			_color,
			_pos,
			24,
			24,
			getdir _x,
			_passengers
		];
	};
}foreach(_vehs);

{
	if(side _x isEqualTo west) then {
		private _u = leader _x;
		private _alive = alive _u;
		if(!_alive) then {
			{
				if(alive _x) exitWith {
					_u = _x;
					_alive=true;
				};
			}foreach(units _x);
		};
		if(_alive) then {
			private _ka = resistance knowsabout _u;
			if(_ka > 1.4) then {
				_mapCtrl drawIcon [
					"\A3\ui_f\data\map\markers\nato\b_inf.paa",
					[0,0.3,0.59,((_ka-1.4) / 1) min 1],
					visiblePosition _u,
					30,
					30,
					0
				];
			};
		};
	};

	if(side _x isEqualTo east) then {
		private _u = leader _x;
		private _alive = alive _u;
		if(!_alive) then {
			{
				if(alive _x) exitWith {
					_u = _x;
					_alive=true;
				};
			}foreach(units _x);
		};
		if(_alive) then {
			private _ka = resistance knowsabout _u;
			if(_ka > 1.4) then {
				_mapCtrl drawIcon [
					"\A3\ui_f\data\map\markers\nato\b_inf.paa",
					[0.5,0,0,((_ka-1.4) / 1) min 1],
					visiblePosition _u,
					30,
					30,
					0
				];
			};
		}
	};
}foreach(allGroups);

private _scale = ctrlMapScale _mapCtrl;
if(_scale <= 0.16) then {
	private _leased = player getvariable ["leased",[]];
	{
		private _buildingPos = buildingpositions getVariable _x;
		if!(isNil "_buildingPos") then {
			_mapCtrl drawIcon [
				"\A3\ui_f\data\map\mapcontrol\Tourism_CA.paa",
				[1,1,1,[1,0.3] select (_x in _leased)],
				_buildingPos,
				0.3/_scale,
				0.3/_scale,
				0
			];
		};
	}foreach(player getvariable ["owned",[]]);

	{
		_x params ["_cls","_name","_side","_flag"];
		if!(_side isEqualTo 1) then {
			private _factionPos = server getVariable format["factionrep%1",_cls];
			if!(isNil "_factionPos") then {
				_mapCtrl drawIcon [
					_flag,
					[1,1,1,1],
					_factionPos,
					0.6/_scale,
					0.5/_scale,
					0
				];
			};
		};
	}foreach(OT_allFactions);

	private _towns = OT_allTowns;
	if (visibleGPS) then {
		_towns = [ missionNamespace getVariable ["OT_Map_EachFrameLastTown", ""] ];
	};

	{
		private _townPos = server getVariable format["gundealer%1",_x];
		if!(isNil "_townPos") then {
			_mapCtrl drawIcon [
				OT_flagImage,
				[1,1,1,1],
				_townPos,
				0.3/_scale,
				0.3/_scale,
				0
			];
			{
				_mapCtrl drawIcon [
					format["\overthrow_main\ui\markers\shop-%1.paa",_x select 1],
					[1,1,1,1],
					_x select 0,
					0.2/_scale,
					0.2/_scale,
					0
				];
			}foreach(server getVariable [format["activeshopsin%1",_x],[]]);
			{
				_mapCtrl drawIcon [
					"\overthrow_main\ui\markers\shop-Hardware.paa",
					[1,1,1,1],
					_x select 0,
					0.3/_scale,
					0.3/_scale,
					0
				];
			}foreach(server getVariable [format["activehardwarein%1",_x],[]]);
		};
	}foreach(_towns);

	if (!visibleGPS) then {
		{
			if ((typeof _x != "B_UAV_AI") && !(_x getVariable ["OT_looted",false])) then {
				_mapCtrl drawIcon [
					"\overthrow_main\ui\markers\death.paa",
					[1,1,1,0.5],
					getPosASL _x,
					0.2/_scale,
					0.2/_scale,
					0
				];
			};
		}foreach(alldeadmen);
		{
			private _visPos = getPosASL _x;
			if(
				typeOf _x isKindOf ["AllVehicles",_cfgVeh]
				&& { (crew _x isEqualTo []) }
				&& { (_x call OT_fnc_hasOwner) }
			) then {
				if(typeOf _x isKindOf ["StaticWeapon", _cfgVeh] && {(isNull attachedTo _x) && (alive _x)}) then {
					if(side _x isEqualTo civilian || side _x isEqualTo resistance || captive _x) then {
						_mapCtrl drawIcon [
							[
								"\A3\ui_f\data\map\markers\nato\o_art.paa",
								"\A3\ui_f\data\map\markers\nato\o_mortar.paa"
							] select (typeOf _x isKindOf ["StaticMortar", _cfgVeh]),
							[
								[0.5,0] select alive gunner _x,
								0.5,
								[0.4,1] select (someAmmo _x),
								1
							],
							_visPos,
							30,
							30,
							0
						];
					};
				} else {
					_mapCtrl drawIcon [
						getText(_cfgVeh >> (typeof _x) >> "icon"),
						[1,1,1,1],
						_visPos,
						0.4/_scale,
						0.4/_scale,
						getdir _x
					];
				};
			};
		}foreach(vehicles);
	};
};
private _qrf = server getVariable "QRFpos";
if(!isNil "_qrf") then {
	private _progress = server getVariable ["QRFprogress",0];
	if(_progress != 0) then {
		_mapCtrl drawEllipse [
			_qrf,
			100,
			100,
			0,
			[
				parseNumber(_progress > 0),
				parseNumber(_progress < 0),
				1,
				abs _progress
			],
			"\A3\ui_f\data\map\markerbrushes\bdiagonal_ca.paa"
		];
	};
};
