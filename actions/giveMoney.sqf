_money = player getVariable "money";

if(_money < 100) exitWith {"You don't have $100 to give" call notify_minor};

_people = (getpos player) nearObjects ["Man",5];

_handled = false;

_town = (getpos player) call nearestTown;
_rep = player getVariable format["rep%1",_town];
if(_rep > 100) then {_rep = 100};
if(_rep < -100) then {_rep = -100};
{
	if !(_x == player) then {
		if(side _x == west and (random 100 > 80)) then {
			if(random 100 > _rep) exitWith {
				_handled = true;
				_x globalChat "Don't tell my superiors, but thanks!";
			};
		};
		if(isPlayer _x) exitWith {
			_handled = true;
			_mon = _x getVariable "money";
			_x setVariable ["money",_mon+100,true];
		};
		if(side _x == civilian) then {
			_handled = true;			
			
			if((random 100) > 80) then {
				_x globalChat "I'll tell everyone in town how generous you are!";
				player setVariable [format["rep%1",_town],_rep+1,true];
				format["Standing (%1): %2",_town,_rep+1] call notify;
			}else{
				_x globalChat "Thank you, kind sir!";
			};			
		};
		if(side _x == east) then {
			//lol
			_x globalChat "Hahahah thanks for the money!";
			_handled = true;
			player setVariable [format["rep%1",_town],_rep-1,true];
			format["Standing (%1): %2",_town,_rep-1] call notify;
		};
	};
}foreach(_people);

if(_handled) then {
	player setVariable ["money",_money-100,true];
}else{
	"There is noone nearby that will take your money" call notify_minor;
};