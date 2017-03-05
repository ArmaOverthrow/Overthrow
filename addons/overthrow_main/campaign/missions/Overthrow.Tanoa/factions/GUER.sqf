
private _blueprints = server getVariable ["GEURblueprints",[]];
if(count _blueprints == 0) then {
	_blueprints = OT_item_DefaultBlueprints;
	server setVariable ["GEURblueprints",_blueprints,true];
};
//Keeps track of all entities that should trigger the spawner
private _lastmin = date select 4;
while {true} do {
	sleep 10;
	_track = [];
	{
		if(_x getVariable ["spawntrack",false]) then {
			_track pushback _x;
		}else{
			if((_x call OT_fnc_hasOwner) and (alive _x) and (!isPlayer _x)) then {_track pushback _x};
		};
		sleep 0.01;
	}foreach(allunits);
	spawner setVariable ["track",_track,false];
	private _dead = count alldeadmen;
	if(_dead > 150) then {
		format["There are %1 dead bodies, loot them or clean via options",_dead] remoteExec ["notify_minor",0,false];
	};

	{
		if (typename _x == "GROUP") then {
			{
				deleteVehicle _x;
			}foreach(units _x);
			deleteGroup _x;
		};
		if (typename _x == "OBJECT") then {
			deleteVehicle _x;
		};
	}foreach(spawner getVariable ["_noid_",[]]);


	if {(date select 4) != _lastmin} then {
		_lastmin = date select 4;

		
	}

};
