if(isMultiplayer) then {
	addMissionEventHandler ["Draw3D", {
		if !(OT_showPlayerMarkers) exitWith {};
		{
			if !(_x isEqualTo player) then {
				private _dis = round(_x distance player);
				if(_dis < 250) then {
					private _t = "m";
					if(_dis > 999) then {
						_dis = round(_dis / 1000);
						_t = "km";
					};
					drawIcon3D ["a3\ui_f\data\map\groupicons\selector_selectable_ca.paa", [1,1,1,0.3], getPosATLVisual _x, 1, 1, 0, format["%1 (%2%3)",name _x,_dis,_t], 0, 0.02, "TahomaB", "center", true];
				};
			};
		}foreach([] call CBA_fnc_players);
	}];
};

addMissionEventHandler ["Draw3D", {
	if(!isNil "OT_missionMarker") then {
		private _dis = round(OT_missionMarker distance player);
		private _t = "m";
		if(_dis > 999) then {
			_dis = round(_dis / 1000);
			_t = "km";
		};
		drawIcon3D ["a3\ui_f\data\map\markers\military\dot_ca.paa", [1,1,1,1], OT_missionMarker, 1, 1, 0, format["%1 (%2%3)",OT_missionMarkerText,_dis,_t], 0, 0.02, "TahomaB", "center", true];
	};
}];

if(!isNil "OT_OnDraw") then {
	((findDisplay 12) displayCtrl 51) ctrlRemoveEventHandler ["Draw",OT_OnDraw];
};

OT_OnDraw = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw", OT_fnc_mapHandler];

//Map caching
OT_mapcache_vehicles = [];
OT_mapcache_radar = [];
[{
	if (!visibleMap) exitWith {};
	private _vehs = [];
	private _radar = [];
	private _cfgVeh = configFile >> "CfgVehicles";
	{
		if(((typeof _x == OT_item_CargoContainer) || (_x isKindOf "Ship") || (_x isKindOf "Air") || (_x isKindOf "Car")) && {(count crew _x == 0)} && {(_x call OT_fnc_hasOwner)}) then {
				_vehs pushback [
					getText(_cfgVeh >> (typeof _x) >> "icon"),
					[1,1,1,1],
					getpos _x,
					0.4,
					0.4,
					getdir _x
				];
			};
			if((_x isKindOf "StaticWeapon") && {(isNull attachedTo _x)} && {(alive _x)}) then {
				if(side _x isEqualTo civilian || side _x isEqualTo resistance || captive _x) then {
					_col = [0.5,0.5,0.5,1];
					if(!(isNull gunner _x) && {(alive gunner _x)}) then {_col = [0,0.5,0,1]};
					_i = "\A3\ui_f\data\map\markers\nato\o_art.paa";
					if(_x isKindOf "StaticMortar") then {_i = "\A3\ui_f\data\map\markers\nato\o_mortar.paa"};
					if !(someAmmo _x) then {_col set [3,0.4]};
					_vehs pushback [
						_i,
						_col,
						position _x,
						30,
						30,
						0
					];
				};
			};

		if((_x isKindOf "Air") && !(_x isKindOf "Parachute") && {(alive _x)} && ((side _x) isEqualTo west) && (_x call OT_fnc_isRadarInRange) && {(count crew _x > 0)}) then {
			_radar pushback _x;
		};
	}foreach(vehicles);
	OT_mapcache_vehicles = _vehs;
	OT_mapcache_radar = _radar;
}, 3, []] call CBA_fnc_addPerFrameHandler;

[{
	disableSerialization;
	private _gps = controlNull;
	{
		if !(isNil {_x displayCtrl 101}) exitWith {
			_gps = _x displayCtrl 101;
		};
	} foreach(uiNamespace getVariable "IGUI_Displays");
	if (!isNull _gps) exitWith {
		if(!isNil "OT_GPSOnDraw") then {
			_gps ctrlRemoveEventHandler ['Draw',OT_GPSOnDraw];
		};
		OT_GPSOnDraw = _gps ctrlAddEventHandler ['Draw',OT_fnc_mapHandler];
	};
}, 0.5, []] call CBA_fnc_addPerFrameHandler;
