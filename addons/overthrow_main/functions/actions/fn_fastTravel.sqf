private _ft = server getVariable ["OT_fastTravelType",1];
if(!OT_adminMode and _ft > 1) exitWith {"Fast Travel is disabled" call OT_fnc_notifyMinor};

if !(captive player) exitWith {"You cannot fast travel while wanted" call OT_fnc_notifyMinor};
if !("ItemMap" in assignedItems player) exitWith {"You need a map to fast travel" call OT_fnc_notifyMinor};
private _hasdrugs = false;

{
	if(_x in OT_allDrugs) exitWith {_hasdrugs = true};
}foreach(items player);

if(_hasdrugs) exitWith {"You cannot fast travel while carrying drugs" call OT_fnc_notifyMinor};

_exit = false;
if((vehicle player) != player) then {
	{
		if(_x in OT_allDrugs) exitWith {_hasdrugs = true};
	}foreach(itemCargo vehicle player);

	if(_hasdrugs) exitWith {"You cannot fast travel while carrying drugs" call OT_fnc_notifyMinor;_exit=true};
	if (driver (vehicle player) != player)  exitWith {"You are not the driver of this vehicle" call OT_fnc_notifyMinor;_exit=true};
	if({!captive _x} count (crew vehicle player) != 0)  exitWith {"There are wanted people in this vehicle" call OT_fnc_notifyMinor;_exit=true};
};
if(_exit) exitWith {};

if(((vehicle player) != player) and (vehicle player) isKindOf "Ship") exitWith {"You cannot fast travel in a boat" call OT_fnc_notifyMinor};

if !((vehicle player) call OT_fnc_vehicleCanMove)  exitWith {"This vehicle is unable to move" call OT_fnc_notifyMinor};

"Click near a friendly base/camp or a building you own" call OT_fnc_notifyMinor;
openMap true;

["fastTravel", "onMapSingleClick", {
	private _starttown = player call OT_fnc_nearestTown;
	private _region = server getVariable format["region_%1",_starttown];

	private _handled = false;

	_buildings =  _pos nearObjects [OT_item_Tent,30];
	if !(_buildings isEqualTo []) then {
		_handled = true;
	};

	_exit = false;

	if !(_handled) then {
		if([_pos,"Misc"] call OT_fnc_canPlace) then {
			_handled = true;
		};
	};

	_ob = _pos call OT_fnc_nearestObjective;
	_valid = true;
	_ob params ["_obpos","_obname"];
	_validob = (_obpos distance _pos < 50) and (_obname in OT_allAirports);
	if !(_validob) then {
		if (!OT_adminMode and !(_pos inArea _region)) then {
			if !([_region,_pos] call OT_fnc_regionIsConnected) then {
				_valid = false;
				"You cannot fast travel between islands unless there is a bridge or your destination is a controlled airfield" call OT_fnc_notifyMinor;
				openMap false;
			};
		};
	};
	if(!_valid) exitWith {};
	if(_pos distance player < 150) exitWith {
		"You cannot fast travel less than 150m. Just walk!" call OT_fnc_notifyMinor;
		openMap false;
	};

	if(OT_adminMode) then {_handled = true};

	if !(_handled) then {
		"You must click near a friendly base/camp or a building you own" call OT_fnc_notifyMinor;
		openMap false;
	}else{
		private _ft = server getVariable ["OT_fastTravelType",1];
		if(_handled and _ft == 1 and !OT_adminMode) then {
			_cost = 0;
			if((vehicle player) == player) then {
				_cost = ceil((player distance _pos) / 150);
			}else{
				_cost = ceil((player distance _pos) / 300);
			};
			if((player getVariable ["money",0]) < _cost) exitWith {_exit = true;format ["You need $%1 to fast travel that distance",_cost] call OT_fnc_notifyMinor};
			[-_cost] call OT_fnc_money;
		};

		if(_exit) exitWith {};

		player allowDamage false;
		disableUserInput true;

		cutText ["Fast travelling","BLACK",2];
		_pos spawn {
			private _pos = _this;
			sleep 2;

			if((vehicle player) != player) then {
				if ((driver vehicle player) == player) then {
					_tam = 10;
					_roads = [];
					while {true} do {
						_roads = _pos nearRoads _tam;
						if (count _roads < 1) then {_tam = _tam + 10};
						if (count _roads > 0) exitWith {};
					};
					{_x allowDamage false} foreach(crew vehicle player);
					_road = _roads select 0;
					_pos = position _road findEmptyPosition [1,120,typeOf (vehicle player)];
					vehicle player setPos _pos;
				};
			}else{
				player setpos _pos;
			};

			disableUserInput false;
			cutText ["","BLACK IN",3];

			if((vehicle player) != player) then {
				_crew = crew vehicle player;
				{_x allowDamage true} foreach(_crew);
			};
			player allowDamage true;
			openMap false;
		};
	};
}, nil] call BIS_fnc_addStackedEventHandler;

waitUntil {!visibleMap};

["fastTravel", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
