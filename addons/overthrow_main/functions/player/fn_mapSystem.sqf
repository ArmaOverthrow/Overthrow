if(isMultiplayer) then {
	if(!isNil "OT_MapPlayer_EachFramEHId") then {
		removeMissionEventHandler["EachFrame",OT_MapPlayer_EachFramEHId];
	};
	OT_MapPlayer_EachFramEHId = addMissionEventHandler["EachFrame", {
		if !(alive player) exitWith {};
		{
			if !(_x isEqualTo player) then {
				private _dis = round(_x distance player);
				private _t = "m";
				if(_dis > 999) then {
					_dis = round(_dis / 1000);
					_t = "km";
				};
				drawIcon3D [
					"a3\ui_f\data\map\groupicons\selector_selectable_ca.paa",
					[1,1,1,0.3],
					getPosATLVisual _x,
					1,
					1,
					0,
					format["%1 (%2%3)",name _x,_dis,_t],
					0,
					0.02,
					"TahomaB",
					"center",
					true
				];
			};
		}foreach([] call CBA_fnc_players);
	}];
};

if(!isNil "OT_Map_EachFrameEHId") then {
	removeMissionEventHandler["EachFrame",OT_Map_EachFrameEHId];
};
OT_Map_EachFrameEHId = addMissionEventHandler["EachFrame", {
	if(alive player && !isNil "OT_missionMarker") then {
		private _dis = OT_missionMarker distance2D player;
		private _t = "m";
		if(_dis >= 1000) then {
			_dis = _dis / 1000;
			_t = "km";
		};
		drawIcon3D [
			"a3\ui_f\data\map\markers\military\dot_ca.paa",
			[1,1,1,1],
			OT_missionMarker,
			1,
			1,
			0,
			format["%1 (%2%3)",OT_missionMarkerText,_dis toFixed 1,_t],
			0,
			0.02,
			"TahomaB",
			"center",
			true
		];
	};
}];

OT_Map_EachFrameLastTownCheckPos = [0,0,0];
OT_Map_EachFrameLastTown = "";
[OT_fnc_townCheckLoop,_this,1] call CBA_fnc_waitAndExecute;
