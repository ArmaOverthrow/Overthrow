
//Keeps track of all entities that should trigger the spawner
while {true} do {	
	sleep 10;
	_track = [];
	{
		if(_x getVariable ["spawntrack",false]) then {
			_track pushback _x;
		}else{
			if((_x call hasOwner) and (alive _x) and (!isPlayer _x)) then {_track pushback _x};
		};	
		sleep 0.01;
	}foreach(allunits);	
	spawner setVariable ["track",_track,false];
	private _dead = count alldeadmen;
	if(_dead > 100) then {
		format["There are %1 dead bodies, loot them or clean via map options",_dead] remoteExec ["notify_minor",0,false];
	};
};