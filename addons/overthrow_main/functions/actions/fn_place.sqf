if !(captive player) exitWith {"You cannot place objects while wanted" call OT_fnc_notifyMinor};
private ["_typecls","_types","_cost","_attach","_idx","_money"];

_typecls = _this;
modeValues = [];
_cost = 0;
attachAt = [0,2,1];
_description = "";
modeFinished = false;
modeCancelled = false;
call {
	if(_typecls == "Camp") exitWith {attachAt = [0,3.5,1.1];modeValues = [OT_item_Tent];_cost=40;_description="Creates a fast travel destination for all friendlies. Only one allowed per player, will remove any existing camps."};
	if(_typecls == "Base") exitWith {attachAt = [0,6,4];modeValues = [OT_flag_IND];_cost=250;_description="Creates a fast travel destination for all friendlies and enables build mode for basic military structures"};
	if(_typecls == "Ammobox") exitWith {modeValues = [OT_item_Storage];_cost=60;_description="Another empty ammobox to fill with items you have acquired through.. various means."};
	if(_typecls == "Whiteboard") exitWith {modeValues = [OT_item_Map];_cost=20;_description="Plan out your next assault in the middle of the jungle."};
	{
		if((_x select 0) == _typecls) exitWith {modeValues = _x select 2;_cost = _x select 1;attachAt = _x select 3};
	}foreach(OT_Placeables);
};
//Price check (on aisle 3)
_money = player getVariable "money";
if(_cost > _money) exitWith {format["You cannot afford that, you need $%1",_cost] call OT_fnc_notifyMinor};

if !([getpos player,_typecls] call OT_fnc_canPlace) exitWith {
	call {
		if(_typecls == "Camp") exitWith {"Camps cannot be near another building" call OT_fnc_notifyMinor};
		if(_typecls == "Base") exitWith {"Bases cannot be too close to a town, NATO installation or existing base" call OT_fnc_notifyMinor};
		"You must be near a base or owned structure" call OT_fnc_notifyMinor
	};
};

if(isNil "modeValue") then {
	modeValue = 0;
};

modeTarget = objNULL;
modeRedo = false;
if(isNil "modeRotation") then {
	modeRotation = 180;
};

if(_cost > 0) then {
	_txt = format ["<t size='1.1' color='#eeeeee'>%1</t><br/><t size='0.8' color='#bbbbbb'>$%2</t><br/><t size='0.4' color='#bbbbbb'>%3</t><br/><br/><t size='0.5' color='#bbbbbb'>Q,E = Rotate<br/>Space = Change Type<br/>Enter = Done<br/>Shift = Rotate faster/Place multiple<br/>Esc = Cancel</t>",_typecls,[_cost, 1, 0, true] call CBA_fnc_formatNumber,_description];
	[_txt, [safeZoneX + (0.8 * safeZoneW), (0.2 * safeZoneW)], 0.5, 10, 0, 0, 2] spawn bis_fnc_dynamicText;


	_keyhandler = {
		_handled = false;
		_key = _this select 1;

		_dir = modeRotation;

		call {
			if(_key == 19) exitWith {
				//R

			};
			if (_key == 16) exitWith {
				//Q
				_handled = true;
				_amt = 1;
				if(_this select 2) then {_amt = 45};
				_newdir = _dir - _amt;
				if(_newdir < 0) then {_newdir = _newdir + 360};
				modeTarget setDir (_newdir);
				modeRotation = _newDir;
			};
			if (_key == 18) exitWith {
				//E
				_handled = true;
				_amt = 1;
				if(_this select 2) then {_amt = 45};
				_newdir = _dir + _amt;
				if(_newdir > 359) then {_newdir = _newdir - 360};
				modeTarget setDir (_newdir);
				modeRotation = _newDir;
			};
			if(_key == 57) exitWith {
				//Space
				_handled = true;
				detach modeTarget;
				deleteVehicle modeTarget;
				modeValue = modeValue + 1;
				if(modeValue > ((count modeValues)-1)) then {modeValue = 0};

				_cls = modeValues select modeValue;

				modeTarget = createVehicle [_cls, [0,0,0], [], 0, "CAN_COLLIDE"];
				modeTarget enableDynamicSimulation true;
				if(_cls == "B_Boat_Transport_01_F") then {
					_dir = _dir + 90;
				};

				clearWeaponCargoGlobal modeTarget;
				clearMagazineCargoGlobal modeTarget;
				clearBackpackCargoGlobal modeTarget;
				clearItemCargoGlobal modeTarget;

				modeTarget attachTo [player,attachAt];
				modeTarget setDir _dir;
			};
			if(_key == 28) exitWith {
				//Enter
				_handled = true;
				modeFinished = true;
				if(_this select 2) then {
					modeRedo = true;
				};
			};
			if(_key == 1) exitWith {
				//ESC
				_handled = true;
				modeCancelled = true;
			};
		};
		_handled
	};
	_cls = modeValues select modeValue;
	_handlerId = (findDisplay 46) displayAddEventHandler ["KeyDown",_keyhandler];
	modeTarget = createVehicle [_cls, [0,0,0], [], 0, "CAN_COLLIDE"];

	clearWeaponCargoGlobal modeTarget;
	clearMagazineCargoGlobal modeTarget;
	clearBackpackCargoGlobal modeTarget;
	clearItemCargoGlobal modeTarget;

	modeTarget attachTo [player,attachAt];
	modeTarget setDir modeRotation;
	if(_cls == "B_Boat_Transport_01_F") then {
		_p = getDir modeTarget;
		_v = getDir player;
		_c = 360;

		_dir = _c-((_c-_p)-(_c-_v));
		if(_dir >= 360) then {_dir = _dir - 360};

		modeTarget setDir _dir + 90;
	};

	waitUntil {sleep 0.5; modeFinished or modeCancelled or (count attachedObjects player == 0) or (vehicle player != player) or (!alive player) or (!isPlayer player)};

	(findDisplay 46) displayRemoveEventHandler ["KeyDown",_handlerId];

	{detach _x} forEach attachedObjects player;

	if(modeCancelled or (vehicle player != player) or (!alive player) or (!isPlayer player)) then {
		detach modeTarget;
		deleteVehicle modeTarget;
	}else{
		if ([getpos player,_typecls] call OT_fnc_canPlace) then {
			[-_cost] call OT_fnc_money;
			modeTarget setPosATL [getPosATL modeTarget select 0,getPosATL modeTarget select 1,getPosATL player select 2];
			[modeTarget,getPlayerUID player] call OT_fnc_setOwner;
			modeTarget remoteExec["OT_fnc_initObjectLocal",0,modeTarget];
			if(_typecls == "Base" or _typecls == "Camp") then {
				_veh = createVehicle ["Land_ClutterCutter_large_F", (getpos modeTarget), [], 0, "CAN_COLLIDE"];
			};

			if(_typecls == "Base") then {
				createDialog "OT_dialog_name";
				ctrlSetText [1400,"Base"];

				onNameDone = {
					_name = ctrltext 1400;
					if(_name != "") then {
						closeDialog 0;

						_base = (player nearObjects [OT_flag_IND,50]) select 0;

						_bases = server getVariable ["bases",[]];
						_bases pushback [getpos _base,_name,getplayeruid player];
						server setVariable ["bases",_bases,true];

						_base setVariable ["name",_name];

						_mrkid = format["%1-base",getpos _base];
						createMarker [_mrkid,getpos _base];
						_mrkid setMarkerShape "ICON";
						_mrkid setMarkerType "mil_Flag";
						_mrkid setMarkerColor "ColorWhite";
						_mrkid setMarkerAlpha 1;
						_mrkid setMarkerText _name;
						_builder = name player;
						{
							[_x,format["New Base: %1",_name],format["%1 created a new base for resistance efforts %2",_builder,(getpos _base) call BIS_fnc_locationDescription]] call BIS_fnc_createLogRecord;
						}foreach([] call CBA_fnc_players);
					};
				};
				onNameKeyDown = {
					_key = _this select 1;
					_name = ctrltext 1400;
					if(_key == 28 and _name != "") exitWith {
						[] call onNameDone;
						true
					};
				};
			};
			if(_typecls == "Camp") then {
				_mrkid = format["%1-camp",getplayeruid player];
				createMarker [_mrkid,getpos modeTarget];
				_mrkid setMarkerPos (getpos modeTarget);
				_camp = player getVariable["camp",[]];
				if(count _camp > 0) then {
					{
						_t = typeof _x;
						if((_x call OT_fnc_getOwner) == getplayeruid player) then {
							if(_t == OT_item_Tent or _t == "Land_ClutterCutter_large_F") then {
								deleteVehicle _x;
							};
						}
					}foreach(_camp nearObjects 10);
				};
				player setVariable ["camp",getpos modeTarget];
				_mrkid setMarkerShape "ICON";
				_mrkid setMarkerType "ot_Camp";
				_mrkid setMarkerColor "ColorWhite";
				_mrkid setMarkerAlpha 1;
				_mrkid setMarkerText format ["Camp %1",name player];
				_builder = name player;
				{
					_desc = (getpos modeTarget) call BIS_fnc_locationDescription;
					[_x,format["New Camp %1",_desc],format["%1 placed a camp %2",_builder,_desc]] call BIS_fnc_createLogRecord;
				}foreach([] call CBA_fnc_players);
			};
		}else{
			call {
				if(_typecls == "Camp") exitWith {"Camps cannot be near a structure you already own" call OT_fnc_notifyMinor};
				if(_typecls == "Base") exitWith {"Bases cannot be near a town, NATO installation or existing base" call OT_fnc_notifyMinor};
				"You must be near a base or owned building" call OT_fnc_notifyMinor
			};
			detach modeTarget;
			deleteVehicle modeTarget;
		};
	};
}else{
	if(_typecls != "Camp" and _typecls != "Base") then {
		"To place this item you must be near a base or a building that you own" call OT_fnc_notifyMinor;
	}else{
		"You cannot place a camp/base near a building you own. Bases must also be built away from towns." call OT_fnc_notifyMinor;
	};
};

//Cleanup public vars
modeTarget = nil;
modeCancelled = nil;
modeFinished = nil;
if(modeRedo) then {
	_typecls spawn OT_fnc_place;
}else{
	modeValue = nil;
}
