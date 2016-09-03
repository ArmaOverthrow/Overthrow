if !(captive player) exitWith {"You cannot fast travel while wanted" call notify_minor};

if((vehicle player) != player) then {
	if (driver (vehicle player) != player)  exitWith {"You are not the driver of this vehicle" call notify_minor};
	if({!captive _x} count (crew vehicle player) != 0)  exitWith {"There are wanted people in this vehicle" call notify_minor};
};
posTravel = [];
"Click near a base, or building/camp you own" call notify_minor;
openMap true;

onMapSingleClick "posTravel = _pos;";

waitUntil {sleep 0.1; (count posTravel > 0) or (not visiblemap)};
onMapSingleClick "";

if !(visibleMap) exitWith {};

_handled = false;

if(posTravel distance player < 150) exitWith {
	"You cannot fast travel less than 150m. Just walk!" call notify_minor;
	openMap false;
};

_obj = posTravel call nearestObjective;
_objpos = _obj select 0;
_closestobj = _obj select 1;
if(_closestobj in (server getVariable ["NATOabandoned",[]]) and (_objpos distance posTravel) < 50) then {
	_handled = true;
};
	
if !(_handled) then {
	_buildings =  posTravel nearObjects [AIT_item_Tent,30];
	if !(_buildings isEqualTo []) then {
		{
			if(_x getVariable ["owner",""] == getplayeruid player) then {
				_handled = true;
			};
		}foreach(_buildings);
	};
};

if !(_handled) then {
	if([posTravel,"Misc"] call canPlace) then {
		_handled = true;		
	};
};

if !(_handled) then {
	"You must click near a base or a building/camp you own" call notify_minor;
	openMap false;
}else{
	player allowDamage false;
	disableUserInput true;
	
	cutText ["Fast traveling, please wait","BLACK",2];			
	sleep 2;
	openMap false;
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
			_pos = position _road findEmptyPosition [1,120,typeOf (vehicle player)];
			vehicle player setPos _pos;
		};				
	}else{
		player setpos posTravel;		
	};				

	disableUserInput false;
	cutText ["","BLACK IN",3];
		
	if((vehicle player) != player) then {
		_crew = crew vehicle player;
		sleep 5;
		{_x allowDamage true} foreach(_crew);		
	}else{
		sleep 5;		
	};	
	player allowDamage true;
};