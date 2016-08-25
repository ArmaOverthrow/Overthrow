if !(captive player) exitWith {"You cannot place objects while wanted" call notify_minor};
private ["_typecls","_types","_cost","_attach","_idx","_money"];

_typecls = _this;
modeValues = [];
_cost = 0;
attachAt = [0,2,1];
_description = "";
modeFinished = false;
modeCancelled = false;
call {
	if(_typecls == "Camp") exitWith {attachAt = [0,3.5,1.1];modeValues = [AIT_item_Tent];_cost=40;_description="Creates a fast travel destination for you and your group. Only one allowed per player, will remove any existing camps."};
	if(_typecls == "Base") exitWith {attachAt = [0,6,4];modeValues = [AIT_item_Flag];_cost=500;_description="Creates a fast travel destination for all friendlies and enables build mode for military structures"};
	if(_typecls == "Ammobox") exitWith {modeValues = [AIT_item_Storage];_cost=60;_description="Another empty ammobox to fill with items you have acquired through.. various means."};
	if(_typecls == "Whiteboard") exitWith {modeValues = [AIT_item_Map];_cost=20;_description="Plan out your next assault in the middle of the jungle."};
	{
		if((_x select 0) == _typecls) exitWith {modeValues = _x select 2;_cost = _x select 1;attachAt = _x select 3};
	}foreach(AIT_Placeables);
};
//Price check (on aisle 3)
_money = player getVariable "money";
if(_cost > _money) exitWith {format["You cannot afford that, you need $%1",_cost] call notify_minor};

if !([getpos player,_typecls] call canPlace) exitWith {
	call {
		if(_typecls == "Camp") exitWith {"Camps cannot be near another building" call notify_minor};
		if(_typecls == "Base") exitWith {"Bases cannot be near a town, NATO installation or existing base" call notify_minor};
		"You must be near a base, camp or owned structure" call notify_minor
	};
};

modeValue = 0;
modeTarget = objNULL;


if(_cost > 0) then {
	_txt = format ["<t size='1.1' color='#eeeeee'>%1</t><br/><t size='0.8' color='#bbbbbb'>$%2</t><br/><t size='0.4' color='#bbbbbb'>%3</t><br/><br/><t size='0.5' color='#bbbbbb'>Q,E = Rotate<br/>Space = Change Type<br/>Enter = Done<br/>Esc = Cancel</t>",_typecls,[_cost, 1, 0, true] call CBA_fnc_formatNumber,_description];
	[_txt, [safeZoneX + (0.8 * safeZoneW), (0.2 * safeZoneW)], 0.5, 10, 0, 0, 2] spawn bis_fnc_dynamicText;
	
	
	_keyhandler = {
		_handled = false;
		_key = _this select 1;
		
		_p = getDir modeTarget;
		_v = getDir player;
		_c = 360;

		_dir = _c-((_c-_p)-(_c-_v));
		if(_dir >= 360) then {_dir = _dir - 360};
		
		call {
			if (_key == 16) exitWith {
				//Q
				_handled = true;	
				_newdir = _dir - 1;
				if(_newdir < 0) then {_newdir = 359};
				modeTarget setDir (_newdir);
			};
			if (_key == 18) exitWith {
				//E
				_handled = true;
				_newdir = _dir + 1;
				if(_newdir > 359) then {_newdir = 0};
				modeTarget setDir (_newdir);
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
				if(_cls == "B_Boat_Transport_01_F") then {
					_dir = _dir + 90;
				};
				modeTarget remoteExec ["enableSimulationGlobal false",2];
				if(_cls == AIT_item_Map) then {
					modeTarget setObjectTextureGlobal [0,"dialogs\maptanoa.paa"];
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
	modeTarget remoteExec ["enableSimulationGlobal false",2];
	modeTarget enableSimulation false;
	if(_cls == AIT_item_Map) then {
		modeTarget setObjectTextureGlobal [0,"dialogs\maptanoa.paa"];
	};		
	modeTarget enableSimulationGlobal false;
	
	
	clearWeaponCargoGlobal modeTarget;
	clearMagazineCargoGlobal modeTarget;
	clearBackpackCargoGlobal modeTarget;
	clearItemCargoGlobal modeTarget;	
	
	modeTarget attachTo [player,attachAt];
	
	if(_cls == "B_Boat_Transport_01_F") then {
		_p = getDir modeTarget;
		_v = getDir player;
		_c = 360;

		_dir = _c-((_c-_p)-(_c-_v));
		if(_dir >= 360) then {_dir = _dir - 360};
		
		modeTarget setDir _dir + 90;
	};
	
	waitUntil {sleep 0.1; modeFinished or modeCancelled or (count attachedObjects player == 0) or (vehicle player != player) or (!alive player) or (!isPlayer player)};
	
	(findDisplay 46) displayRemoveEventHandler ["KeyDown",_handlerId];
	
	{detach _x} forEach attachedObjects player;
	
	if(modeCancelled or (vehicle player != player) or (!alive player) or (!isPlayer player)) then {
		detach modeTarget;
		deleteVehicle modeTarget;
	}else{		
		if ([getpos player,_typecls] call canPlace) then {			
			player setVariable ["money",_money - _cost,true];		
			modeTarget setPosATL [getPosATL modeTarget select 0,getPosATL modeTarget select 1,getPosATL player select 2];
			modeTarget remoteExec ["enableSimulationGlobal true",2];
			modeTarget enableSimulation true;
			modeTarget setVariable ["owner",getPlayerUID player,true];
			modeTarget call initObjectLocal;
			if(_typecls == "Base" or _typecls == "Camp") then {
				_veh = createVehicle ["Land_ClutterCutter_large_F", (getpos modeTarget), [], 0, "CAN_COLLIDE"];
			};
			
			if(_typecls == "Base") then {
				createDialog "AIT_dialog_name";
				ctrlSetText [1400,"Base"];
				
				onNameDone = {
					_name = ctrltext 1400;
					if(_name != "") then {
						closeDialog 0;
						
						_base = (player nearObjects [AIT_item_Flag,50]) select 0;
						
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
		}else{
			call {
				if(_typecls == "Camp") exitWith {"Camps cannot be near a structure you already own" call notify_minor};
				if(_typecls == "Base") exitWith {"Bases cannot be near a town, NATO installation or existing base" call notify_minor};
				"You must be near a base or owned building" call notify_minor
			};
			detach modeTarget;
			deleteVehicle modeTarget;
		};
	};	
}else{
	if(_typecls != "Camp" and _typecls != "Base") then {
		"To place this item you must be near a base or a building that you own" call notify_minor;
	}else{
		"You cannot place a camp/base near a building you own. Bases must also be built away from towns." call notify_minor;
	};
};

//Cleanup public vars
modeTarget = nil;
modeCancelled = nil;
modeFinished = nil;
modeValue = nil;