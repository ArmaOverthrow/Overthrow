if(typeof _this == OT_item_Map) then {
	_this addAction ["Town Info", "actions\townInfo.sqf",nil,0,false,true,"",""];
	_this addAction ["Most Wanted", "actions\mostWanted.sqf",nil,0,false,true,"",""];
	if(player == bigboss) then {
		_this addAction ["Options", {
			closedialog 0;			
			_nul = createDialog "OT_dialog_options";
		},nil,0,false,true,"",""];			
	};
};
if(typeof _this == OT_item_Tent) exitWith {
	_camp = player getVariable ["camp",objNull];
	if !(isNull _camp) then {
		_fire = _camp getVariable "fire";
		deleteVehicle _fire;
		deleteVehicle _camp;
	};
	_mrkid = format["%1-camp",getplayeruid player];
	createMarkerLocal [_mrkid,getpos _this];
	_mrkid setMarkerPos (getpos _this);
	_mrkid setMarkerShape "ICON";
	_mrkid setMarkerType "loc_Bunker";
	_mrkid setMarkerColor "ColorWhite";
	_mrkid setMarkerAlpha 0;
	_mrkid setMarkerAlphaLocal 1;
	_mrkid setMarkerText "Camp";
	
	_pos = [(getpos _this),1.2,getDir _this] call BIS_fnc_relPos;
	_fire = "Land_Campfire_F" createVehicle _pos;
	_this setVariable ["fire",_fire,false];
	player setvariable ["camp",_this,false];
};

if(_this isKindOf "Building" or _this isKindOf "Man") exitWith{};

if(OT_hasACE) then {
	_dir = 0;
	if(typeof _this == "C_Rubberboat") then {
		_dir = 90;
	};
	[_this, true, [0, 2, 0.4],_dir] call ace_dragging_fnc_setCarryable;
}else{
	_this addAction ["Move this", "actions\move.sqf",nil,0,false,true,"",""];
};


