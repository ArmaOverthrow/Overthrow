private _ft = server getVariable ["OT_fastTravelType",1];
private _diff = server getVariable ["OT_difficulty",1];
private _ftrules = server getVariable ["OT_fastTravelRules",_diff];
if(!OT_adminMode && _ft > 1) exitWith {hint "Fast Travel is disabled"};

if !(captive player) exitWith {hint "You cannot fast travel while wanted"};
if !("ItemMap" in assignedItems player) exitWith {hint "You need a map to fast travel"};

if(_ftrules > 0 && !((primaryWeapon player) isEqualTo "" && (secondaryWeapon player) isEqualTo "" && (handgunWeapon player) isEqualTo "")) exitWith {hint "You cannot fast travel holding a weapon"};

_foundweapon = false;
if((vehicle player) != player && _ftrules > 0) then {
	{
		if(!((primaryWeapon _x) isEqualTo "" && (secondaryWeapon _x) isEqualTo "" && (handgunWeapon _x) isEqualTo "")) exitWith {_foundweapon = true};
	}foreach(crew vehicle player);
};
if(_foundweapon) exitWith {hint "A passenger is holding a weapon"};

private _hasdrugs = false;
{
	if(_x in OT_allDrugs) exitWith {_hasdrugs = true};
}foreach(items player);

if(_hasdrugs && _ftrules > 0) exitWith {"You cannot fast travel while carrying drugs" call OT_fnc_notifyMinor};

private _exit = false;
if((vehicle player) != player) then {
	{
		if(_x in OT_allDrugs) exitWith {_hasdrugs = true};
	}foreach(itemCargo vehicle player);

	if(_hasdrugs && _ftrules > 0) exitWith {hint "You cannot fast travel while carrying drugs";_exit=true};
	if (driver (vehicle player) != player)  exitWith {hint "You are not the driver of this vehicle";_exit=true};
	if({!captive _x && alive _x} count (crew vehicle player) != 0)  exitWith {hint "There are wanted people in this vehicle";_exit=true};
	if(_ftrules > 1 && ((typeOf(vehicle player)) in (OT_allVehicleThreats + OT_allHeliThreats + OT_allPlaneThreats)))  exitWith {hint "You cannot fast travel in an offensive vehicle";_exit=true};
};
if(_exit) exitWith {};

if(((vehicle player) != player) && (vehicle player) isKindOf "Ship") exitWith {hint "You cannot fast travel in a boat"};

if !((vehicle player) call OT_fnc_vehicleCanMove)  exitWith {hint "This vehicle is unable to move"};

OT_FastTravel_MapSingleClickEHId = addMissionEventHandler ["MapSingleClick", {
	params ["", "_pos"];
	private _starttown = player call OT_fnc_nearestTown;
	private _region = server getVariable format["region_%1",_starttown];

	private _handled = false;

	private _buildings =  _pos nearObjects [OT_item_Tent,30];
	if !(_buildings isEqualTo []) then {
		_bdg = (_buildings select 0);
		if !(_bdg getVariable ["owner",""] isEqualTo "") then {
			_handled = true;
		};
	};

	private _exit = false;

	if !(_handled) then {
		if([_pos,"Misc"] call OT_fnc_canPlace) then {
			_handled = true;
		};
	};

	private _ob = _pos call OT_fnc_nearestObjective;
	private _valid = true;
	_ob params ["_obpos","_obname"];
	private _validob = (_obpos distance _pos < 50) && (_obname in OT_allAirports);
	if !(_validob) then {
		if (!OT_adminMode && !(_pos inArea _region)) then {
			if !([_region,_pos] call OT_fnc_regionIsConnected) then {
				_valid = false;
				hint "You cannot fast travel between islands unless there is a bridge or your destination is a controlled airfield";
				openMap false;
			};
		};
	};
	if(!_valid) exitWith {};
	if(_pos distance player < 150) exitWith {
		hint "You cannot fast travel less than 150m. Just walk!";
		openMap false;
	};

	if(OT_adminMode) then {_handled = true};

	if !(_handled) then {
		hint "You must click near a friendly base/camp or a building you own";
		openMap false;
	}else{
		private _ft = server getVariable ["OT_fastTravelType",1];
		if(_handled && _ft isEqualTo 1 && !OT_adminMode) then {
			private _cost = 0;
			if((vehicle player) isEqualTo player) then {
				_cost = ceil((player distance _pos) / 50);
			}else{
				_cost = ceil((player distance _pos) / 20);
			};
			if((player getVariable ["money",0]) < _cost) exitWith {_exit = true;hint format ["You need $%1 to fast travel that distance",_cost]};
			[-_cost] call OT_fnc_money;
		};

		if(_exit) exitWith {};

		player allowDamage false;
		disableUserInput true;

		cutText ["Fast travelling","BLACK",2];
		[
			{
				private _pos = _this;

				if((vehicle player) != player) then {
					if ((driver vehicle player) isEqualTo player) then {
						private _tam = 10;
						private _roads = [];
						while {true} do {
							_roads = _pos nearRoads _tam;
							if (count _roads < 1) then {_tam = _tam + 10};
							if (count _roads > 0) exitWith {};
						};
						{_x allowDamage false} foreach(crew vehicle player);
						private _road = _roads select 0;
						_pos = position _road findEmptyPosition [10,120,typeOf (vehicle player)];
						vehicle player setPos _pos;
					};
				}else{
					player setpos (_pos findEmptyPosition [2,100]);
				};

				disableUserInput false;
				cutText ["","BLACK IN",3];

				if((vehicle player) != player) then {
					{_x allowDamage true} foreach(crew vehicle player);
				};
				player allowDamage true;
				openMap false;
			},
			_pos,
			2
		] call CBA_fnc_waitAndExecute;
	};
}];

OT_FastTravel_MapEHId = addMissionEventHandler ["Map", {
	params ["_mapIsOpened"];
	if (!_mapIsOpened) then {
		if (isNil "OT_FastTravel_MapEHId" || isNil "OT_FastTravel_MapSingleClickEHId") exitWith {};
		removeMissionEventHandler["Map", OT_FastTravel_MapEHId];
		removeMissionEventHandler["MapSingleClick", OT_FastTravel_MapSingleClickEHId];
		OT_FastTravel_MapEHId = nil;
		OT_FastTravel_MapSingleClickEHId = nil;
	};
}];

"Click near a friendly base/camp or a building you own" call OT_fnc_notifyMinor;
openMap true;
