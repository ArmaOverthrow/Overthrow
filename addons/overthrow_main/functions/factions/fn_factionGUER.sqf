
private _blueprints = server getVariable ["GEURblueprints",[]];
if(count _blueprints isEqualTo 0) then {
	_blueprints = OT_item_DefaultBlueprints;
	server setVariable ["GEURblueprints",_blueprints,true];
};
//Keeps track of all entities that should trigger the spawner
private _lastmin = date select 4;
private _lasthr = date select 3;
private _currentProduction = "";
private _stabcounter = 0;
private _trackcounter = 0;

GUER_faction_loop_data = [_lastmin,_lasthr,_currentProduction,_stabcounter,_trackcounter];

["GUER_faction_loop","_counter%5 isEqualTo 0","call OT_fnc_GUERLoop"] call OT_fnc_addActionLoop;
