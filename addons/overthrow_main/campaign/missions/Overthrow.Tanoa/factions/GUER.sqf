
//Keeps track of all entities that should trigger the spawner
while {true} do {	
	sleep 10;
	_track = [];
	{
		if(_x getVariable ["spawntrack",false]) then {
			_track pushback _x;
		}else{
			if(((side _x == resistance) or (_x call hasOwner)) and (alive _x) and (!isPlayer _x)) then {_track pushback _x};
		};	
		sleep 0.01;
	}foreach(allunits);	
	spawner setVariable ["track",_track,false];
};