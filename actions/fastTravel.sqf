if !(captive player) exitWith {"You cannot fast travel while wanted" call notify_minor};

if((vehicle player) != player) then {
	if (driver vehicle player == player)  exitWith {"You are not the driver of this vehicle" call notify_minor};
	if({!captive _x} count (crew vehicle player) != 0)  exitWith {"There are wanted people in this vehicle" call notify_minor};
};
posTravel = [];
"Where would you like to go?" call notify_minor;
openMap true;

onMapSingleClick "posTravel = _pos;";

waitUntil {sleep 0.1; (count posTravel > 0) or (not visiblemap)};
onMapSingleClick "";

if !(visibleMap) exitWith {};

_buildings =  posTravel nearObjects 50;
_handled = false;
_possible = [];
{
	_owner = _x getVariable "owner";
	if !(isNil "_owner") then {
		if(_owner == player and (typeof _x) in AIT_allBuyableBuildings) exitWith {
			_handled = true;
			player allowDamage false;
			if((vehicle player) != player) then {
				if (driver vehicle player == player) then {
					_tam = 10;
					_roads = [];
					while {true} do {
						_roads = posTravel nearRoads _tam;
						if (count _roads < 1) then {_tam = _tam + 10};
						if (count _roads > 0) exitWith {};
					};
					{_x allowDamage false} foreach(crew vehicle player);					
					_road = _roads select 0;
					_pos = position _road findEmptyPosition [1,50,typeOf (vehicle player)];
					vehicle player setPos _pos;
				};				
			}else{
				player setpos ([getpos _x, 0, 25, 1, 0, 0, 0] call BIS_fnc_findSafePos);
			};			
			openMap false;			
		};
	}
}foreach(_buildings);

if !(_handled) then {
	"You don't own any buildings near there" call notify_minor;
	openMap false;
}else{
	if((vehicle player) != player) then {
		_crew = crew vehicle player;
		sleep 5;
		{_x allowDamage true} foreach(_crew);		
	}else{
		sleep 5;		
	};	
	player allowDamage true;
};