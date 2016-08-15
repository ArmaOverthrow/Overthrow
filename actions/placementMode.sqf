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
	if(_typecls == "Camp") exitWith {attachAt = [0,3.5,1.1];modeValues = [AIT_item_Tent];_cost=40;_description="Creates a fast travel destination. Only one allowed per player, will remove any existing camps."};
	if(_typecls == "Ammobox") exitWith {modeValues = [AIT_item_Storage];_cost=60;_description="Another empty ammobox to fill with items you have acquired through.. various means."};
	if(_typecls == "Whiteboard") exitWith {modeValues = [AIT_item_Map];_cost=20;_description="Plan out your next assault in the middle of the jungle."};
	{
		if((_x select 0) == _typecls) exitWith {modeValues = _x select 2;_cost = _x select 1;attachAt = _x select 3};
	}foreach(AIT_Placeables);
};
//Price check (on aisle 3)
_money = player getVariable "money";
if(_cost > _money) exitWith {format["You cannot afford that, you need $%1",_cost] call notify_minor};

//Building proximity check
_estate = (getpos player) call getNearestRealEstate;
if(typename _estate == "ARRAY") then {
	_b = _estate select 0;
	if(_b call hasOwner) then {
		_owner = _b getVariable "owner";
		if(_owner != getplayeruid player) then {
			if(_typecls == "Camp") then {
				_cost = 0;
			};
		}else{
			if(_typecls == "Camp") then {
				_cost = 0;
			};
		};
	}else{
		if(_typecls != "Camp") then {
			_cost = 0;
		};
	};
}else{
	if(_typecls != "Camp") then {
		_cost = 0;
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
				deleteVehicle modeTarget;
				modeValue = modeValue + 1;
				if(modeValue > ((count modeValues)-1)) then {modeValue = 0};

				_cls = modeValues select modeValue;

				modeTarget = createVehicle [_cls, [0,0,0], [], 0, "CAN_COLLIDE"];	
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
	modeTarget enableSimulationGlobal false;
	
	clearWeaponCargoGlobal modeTarget;
	clearMagazineCargoGlobal modeTarget;
	clearBackpackCargoGlobal modeTarget;
	clearItemCargoGlobal modeTarget;	
	
	modeTarget attachTo [player,attachAt];
	
	waitUntil {sleep 0.1; modeFinished or modeCancelled or (count attachedObjects player == 0) or (vehicle player != player) or (!alive player) or (!isPlayer player)};
	
	(findDisplay 46) displayRemoveEventHandler ["KeyDown",_handlerId];
	
	{detach _x} forEach attachedObjects player;
	
	if(modeCancelled or (vehicle player != player) or (!alive player) or (!isPlayer player)) then {
		deleteVehicle modeTarget;
	}else{	
		_estate = (getpos player) call getNearestRealEstate;
		if(typename _estate == "ARRAY") then {
			_b = _estate select 0;
			if(_b call hasOwner) then {
				_owner = _b getVariable "owner";
				if(_owner != getplayeruid player) then {
					if(_typecls == "Camp") then {
						_cost = 0;
					};
				}else{
					if(_typecls == "Camp") then {
						_cost = 0;
					};
				};
			}else{
				if(_typecls != "Camp") then {
					_cost = 0;
				};
			};
		}else{
			if(_typecls != "Camp") then {
				_cost = 0;
			};
		};
		if(_cost > 0) then {
			player setVariable ["money",_money - _cost,true];		
			modeTarget setPosATL [getPosATL modeTarget select 0,getPosATL modeTarget select 1,getPosATL player select 2];
			modeTarget enableSimulationGlobal true;
			modeTarget setVariable ["owner",getPlayerUID player,true];
			modeTarget call initObjectLocal;
		}else{
			if(_typecls != "Camp") then {
				"To place this item you must be near a building or camp that you own" call notify_minor;
			}else{
				"You cannot place a camp near an owned building" call notify_minor;
			};
			deleteVehicle modeTarget;
		};
	};	
}else{
	if(_typecls != "Camp") then {
		"To place this item you must be near a building or camp that you own" call notify_minor;
	}else{
		"You cannot place a camp near a building you own" call notify_minor;
	};
};

//Cleanup public vars
modeTarget = nil;
modeCancelled = nil;
modeFinished = nil;
modeValue = nil;